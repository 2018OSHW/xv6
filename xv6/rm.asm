
_rm：     文件格式 elf32-i386


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
    printf(2, "Usage: rm files...\n");
      19:	83 ec 08             	sub    $0x8,%esp
      1c:	68 cc 20 00 00       	push   $0x20cc
      21:	6a 02                	push   $0x2
      23:	e8 5e 04 00 00       	call   486 <printf>
      28:	83 c4 10             	add    $0x10,%esp
    exit();
      2b:	e8 b7 02 00 00       	call   2e7 <exit>
  }

  for(i = 1; i < argc; i++){
      30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      37:	eb 4b                	jmp    84 <main+0x84>
    if(unlink(argv[i]) < 0){
      39:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      43:	8b 43 04             	mov    0x4(%ebx),%eax
      46:	01 d0                	add    %edx,%eax
      48:	8b 00                	mov    (%eax),%eax
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	50                   	push   %eax
      4e:	e8 e4 02 00 00       	call   337 <unlink>
      53:	83 c4 10             	add    $0x10,%esp
      56:	85 c0                	test   %eax,%eax
      58:	79 26                	jns    80 <main+0x80>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      64:	8b 43 04             	mov    0x4(%ebx),%eax
      67:	01 d0                	add    %edx,%eax
      69:	8b 00                	mov    (%eax),%eax
      6b:	83 ec 04             	sub    $0x4,%esp
      6e:	50                   	push   %eax
      6f:	68 e0 20 00 00       	push   $0x20e0
      74:	6a 02                	push   $0x2
      76:	e8 0b 04 00 00       	call   486 <printf>
      7b:	83 c4 10             	add    $0x10,%esp
      break;
      7e:	eb 0b                	jmp    8b <main+0x8b>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
      80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      84:	8b 45 f4             	mov    -0xc(%ebp),%eax
      87:	3b 03                	cmp    (%ebx),%eax
      89:	7c ae                	jl     39 <main+0x39>
      printf(2, "rm: %s failed to delete\n", argv[i]);
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

0000038f <initStringFigure>:
SYSCALL(initStringFigure)
     38f:	b8 17 00 00 00       	mov    $0x17,%eax
     394:	cd 40                	int    $0x40
     396:	c3                   	ret    

00000397 <sendMessage>:
SYSCALL(sendMessage)
     397:	b8 18 00 00 00       	mov    $0x18,%eax
     39c:	cd 40                	int    $0x40
     39e:	c3                   	ret    

0000039f <getMessage>:
SYSCALL(getMessage)
     39f:	b8 1a 00 00 00       	mov    $0x1a,%eax
     3a4:	cd 40                	int    $0x40
     3a6:	c3                   	ret    

000003a7 <registWindow>:
SYSCALL(registWindow)
     3a7:	b8 19 00 00 00       	mov    $0x19,%eax
     3ac:	cd 40                	int    $0x40
     3ae:	c3                   	ret    

000003af <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3af:	55                   	push   %ebp
     3b0:	89 e5                	mov    %esp,%ebp
     3b2:	83 ec 18             	sub    $0x18,%esp
     3b5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3bb:	83 ec 04             	sub    $0x4,%esp
     3be:	6a 01                	push   $0x1
     3c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3c3:	50                   	push   %eax
     3c4:	ff 75 08             	pushl  0x8(%ebp)
     3c7:	e8 3b ff ff ff       	call   307 <write>
     3cc:	83 c4 10             	add    $0x10,%esp
}
     3cf:	90                   	nop
     3d0:	c9                   	leave  
     3d1:	c3                   	ret    

000003d2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3d2:	55                   	push   %ebp
     3d3:	89 e5                	mov    %esp,%ebp
     3d5:	53                   	push   %ebx
     3d6:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3e0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3e4:	74 17                	je     3fd <printint+0x2b>
     3e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3ea:	79 11                	jns    3fd <printint+0x2b>
    neg = 1;
     3ec:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3f3:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f6:	f7 d8                	neg    %eax
     3f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3fb:	eb 06                	jmp    403 <printint+0x31>
  } else {
    x = xx;
     3fd:	8b 45 0c             	mov    0xc(%ebp),%eax
     400:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     403:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     40a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     40d:	8d 41 01             	lea    0x1(%ecx),%eax
     410:	89 45 f4             	mov    %eax,-0xc(%ebp)
     413:	8b 5d 10             	mov    0x10(%ebp),%ebx
     416:	8b 45 ec             	mov    -0x14(%ebp),%eax
     419:	ba 00 00 00 00       	mov    $0x0,%edx
     41e:	f7 f3                	div    %ebx
     420:	89 d0                	mov    %edx,%eax
     422:	0f b6 80 84 27 00 00 	movzbl 0x2784(%eax),%eax
     429:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     42d:	8b 5d 10             	mov    0x10(%ebp),%ebx
     430:	8b 45 ec             	mov    -0x14(%ebp),%eax
     433:	ba 00 00 00 00       	mov    $0x0,%edx
     438:	f7 f3                	div    %ebx
     43a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     43d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     441:	75 c7                	jne    40a <printint+0x38>
  if(neg)
     443:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     447:	74 2d                	je     476 <printint+0xa4>
    buf[i++] = '-';
     449:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44c:	8d 50 01             	lea    0x1(%eax),%edx
     44f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     452:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     457:	eb 1d                	jmp    476 <printint+0xa4>
    putc(fd, buf[i]);
     459:	8d 55 dc             	lea    -0x24(%ebp),%edx
     45c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     45f:	01 d0                	add    %edx,%eax
     461:	0f b6 00             	movzbl (%eax),%eax
     464:	0f be c0             	movsbl %al,%eax
     467:	83 ec 08             	sub    $0x8,%esp
     46a:	50                   	push   %eax
     46b:	ff 75 08             	pushl  0x8(%ebp)
     46e:	e8 3c ff ff ff       	call   3af <putc>
     473:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     476:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     47a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     47e:	79 d9                	jns    459 <printint+0x87>
    putc(fd, buf[i]);
}
     480:	90                   	nop
     481:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     484:	c9                   	leave  
     485:	c3                   	ret    

00000486 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     486:	55                   	push   %ebp
     487:	89 e5                	mov    %esp,%ebp
     489:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     48c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     493:	8d 45 0c             	lea    0xc(%ebp),%eax
     496:	83 c0 04             	add    $0x4,%eax
     499:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     49c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4a3:	e9 59 01 00 00       	jmp    601 <printf+0x17b>
    c = fmt[i] & 0xff;
     4a8:	8b 55 0c             	mov    0xc(%ebp),%edx
     4ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4ae:	01 d0                	add    %edx,%eax
     4b0:	0f b6 00             	movzbl (%eax),%eax
     4b3:	0f be c0             	movsbl %al,%eax
     4b6:	25 ff 00 00 00       	and    $0xff,%eax
     4bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4be:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4c2:	75 2c                	jne    4f0 <printf+0x6a>
      if(c == '%'){
     4c4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4c8:	75 0c                	jne    4d6 <printf+0x50>
        state = '%';
     4ca:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4d1:	e9 27 01 00 00       	jmp    5fd <printf+0x177>
      } else {
        putc(fd, c);
     4d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4d9:	0f be c0             	movsbl %al,%eax
     4dc:	83 ec 08             	sub    $0x8,%esp
     4df:	50                   	push   %eax
     4e0:	ff 75 08             	pushl  0x8(%ebp)
     4e3:	e8 c7 fe ff ff       	call   3af <putc>
     4e8:	83 c4 10             	add    $0x10,%esp
     4eb:	e9 0d 01 00 00       	jmp    5fd <printf+0x177>
      }
    } else if(state == '%'){
     4f0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4f4:	0f 85 03 01 00 00    	jne    5fd <printf+0x177>
      if(c == 'd'){
     4fa:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4fe:	75 1e                	jne    51e <printf+0x98>
        printint(fd, *ap, 10, 1);
     500:	8b 45 e8             	mov    -0x18(%ebp),%eax
     503:	8b 00                	mov    (%eax),%eax
     505:	6a 01                	push   $0x1
     507:	6a 0a                	push   $0xa
     509:	50                   	push   %eax
     50a:	ff 75 08             	pushl  0x8(%ebp)
     50d:	e8 c0 fe ff ff       	call   3d2 <printint>
     512:	83 c4 10             	add    $0x10,%esp
        ap++;
     515:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     519:	e9 d8 00 00 00       	jmp    5f6 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     51e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     522:	74 06                	je     52a <printf+0xa4>
     524:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     528:	75 1e                	jne    548 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     52a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     52d:	8b 00                	mov    (%eax),%eax
     52f:	6a 00                	push   $0x0
     531:	6a 10                	push   $0x10
     533:	50                   	push   %eax
     534:	ff 75 08             	pushl  0x8(%ebp)
     537:	e8 96 fe ff ff       	call   3d2 <printint>
     53c:	83 c4 10             	add    $0x10,%esp
        ap++;
     53f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     543:	e9 ae 00 00 00       	jmp    5f6 <printf+0x170>
      } else if(c == 's'){
     548:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     54c:	75 43                	jne    591 <printf+0x10b>
        s = (char*)*ap;
     54e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     551:	8b 00                	mov    (%eax),%eax
     553:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     556:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     55a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     55e:	75 25                	jne    585 <printf+0xff>
          s = "(null)";
     560:	c7 45 f4 f9 20 00 00 	movl   $0x20f9,-0xc(%ebp)
        while(*s != 0){
     567:	eb 1c                	jmp    585 <printf+0xff>
          putc(fd, *s);
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	0f be c0             	movsbl %al,%eax
     572:	83 ec 08             	sub    $0x8,%esp
     575:	50                   	push   %eax
     576:	ff 75 08             	pushl  0x8(%ebp)
     579:	e8 31 fe ff ff       	call   3af <putc>
     57e:	83 c4 10             	add    $0x10,%esp
          s++;
     581:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     585:	8b 45 f4             	mov    -0xc(%ebp),%eax
     588:	0f b6 00             	movzbl (%eax),%eax
     58b:	84 c0                	test   %al,%al
     58d:	75 da                	jne    569 <printf+0xe3>
     58f:	eb 65                	jmp    5f6 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     591:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     595:	75 1d                	jne    5b4 <printf+0x12e>
        putc(fd, *ap);
     597:	8b 45 e8             	mov    -0x18(%ebp),%eax
     59a:	8b 00                	mov    (%eax),%eax
     59c:	0f be c0             	movsbl %al,%eax
     59f:	83 ec 08             	sub    $0x8,%esp
     5a2:	50                   	push   %eax
     5a3:	ff 75 08             	pushl  0x8(%ebp)
     5a6:	e8 04 fe ff ff       	call   3af <putc>
     5ab:	83 c4 10             	add    $0x10,%esp
        ap++;
     5ae:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5b2:	eb 42                	jmp    5f6 <printf+0x170>
      } else if(c == '%'){
     5b4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5b8:	75 17                	jne    5d1 <printf+0x14b>
        putc(fd, c);
     5ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5bd:	0f be c0             	movsbl %al,%eax
     5c0:	83 ec 08             	sub    $0x8,%esp
     5c3:	50                   	push   %eax
     5c4:	ff 75 08             	pushl  0x8(%ebp)
     5c7:	e8 e3 fd ff ff       	call   3af <putc>
     5cc:	83 c4 10             	add    $0x10,%esp
     5cf:	eb 25                	jmp    5f6 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5d1:	83 ec 08             	sub    $0x8,%esp
     5d4:	6a 25                	push   $0x25
     5d6:	ff 75 08             	pushl  0x8(%ebp)
     5d9:	e8 d1 fd ff ff       	call   3af <putc>
     5de:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5e4:	0f be c0             	movsbl %al,%eax
     5e7:	83 ec 08             	sub    $0x8,%esp
     5ea:	50                   	push   %eax
     5eb:	ff 75 08             	pushl  0x8(%ebp)
     5ee:	e8 bc fd ff ff       	call   3af <putc>
     5f3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5fd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     601:	8b 55 0c             	mov    0xc(%ebp),%edx
     604:	8b 45 f0             	mov    -0x10(%ebp),%eax
     607:	01 d0                	add    %edx,%eax
     609:	0f b6 00             	movzbl (%eax),%eax
     60c:	84 c0                	test   %al,%al
     60e:	0f 85 94 fe ff ff    	jne    4a8 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     614:	90                   	nop
     615:	c9                   	leave  
     616:	c3                   	ret    

00000617 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     617:	55                   	push   %ebp
     618:	89 e5                	mov    %esp,%ebp
     61a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     61d:	8b 45 08             	mov    0x8(%ebp),%eax
     620:	83 e8 08             	sub    $0x8,%eax
     623:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     626:	a1 b4 27 00 00       	mov    0x27b4,%eax
     62b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     62e:	eb 24                	jmp    654 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     630:	8b 45 fc             	mov    -0x4(%ebp),%eax
     633:	8b 00                	mov    (%eax),%eax
     635:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     638:	77 12                	ja     64c <free+0x35>
     63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     640:	77 24                	ja     666 <free+0x4f>
     642:	8b 45 fc             	mov    -0x4(%ebp),%eax
     645:	8b 00                	mov    (%eax),%eax
     647:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     64a:	77 1a                	ja     666 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64f:	8b 00                	mov    (%eax),%eax
     651:	89 45 fc             	mov    %eax,-0x4(%ebp)
     654:	8b 45 f8             	mov    -0x8(%ebp),%eax
     657:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     65a:	76 d4                	jbe    630 <free+0x19>
     65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65f:	8b 00                	mov    (%eax),%eax
     661:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     664:	76 ca                	jbe    630 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     666:	8b 45 f8             	mov    -0x8(%ebp),%eax
     669:	8b 40 04             	mov    0x4(%eax),%eax
     66c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     673:	8b 45 f8             	mov    -0x8(%ebp),%eax
     676:	01 c2                	add    %eax,%edx
     678:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67b:	8b 00                	mov    (%eax),%eax
     67d:	39 c2                	cmp    %eax,%edx
     67f:	75 24                	jne    6a5 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     681:	8b 45 f8             	mov    -0x8(%ebp),%eax
     684:	8b 50 04             	mov    0x4(%eax),%edx
     687:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68a:	8b 00                	mov    (%eax),%eax
     68c:	8b 40 04             	mov    0x4(%eax),%eax
     68f:	01 c2                	add    %eax,%edx
     691:	8b 45 f8             	mov    -0x8(%ebp),%eax
     694:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     697:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69a:	8b 00                	mov    (%eax),%eax
     69c:	8b 10                	mov    (%eax),%edx
     69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a1:	89 10                	mov    %edx,(%eax)
     6a3:	eb 0a                	jmp    6af <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a8:	8b 10                	mov    (%eax),%edx
     6aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ad:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b2:	8b 40 04             	mov    0x4(%eax),%eax
     6b5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bf:	01 d0                	add    %edx,%eax
     6c1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6c4:	75 20                	jne    6e6 <free+0xcf>
    p->s.size += bp->s.size;
     6c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c9:	8b 50 04             	mov    0x4(%eax),%edx
     6cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6cf:	8b 40 04             	mov    0x4(%eax),%eax
     6d2:	01 c2                	add    %eax,%edx
     6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6da:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6dd:	8b 10                	mov    (%eax),%edx
     6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e2:	89 10                	mov    %edx,(%eax)
     6e4:	eb 08                	jmp    6ee <free+0xd7>
  } else
    p->s.ptr = bp;
     6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e9:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6ec:	89 10                	mov    %edx,(%eax)
  freep = p;
     6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f1:	a3 b4 27 00 00       	mov    %eax,0x27b4
}
     6f6:	90                   	nop
     6f7:	c9                   	leave  
     6f8:	c3                   	ret    

000006f9 <morecore>:

static Header*
morecore(uint nu)
{
     6f9:	55                   	push   %ebp
     6fa:	89 e5                	mov    %esp,%ebp
     6fc:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6ff:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     706:	77 07                	ja     70f <morecore+0x16>
    nu = 4096;
     708:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     70f:	8b 45 08             	mov    0x8(%ebp),%eax
     712:	c1 e0 03             	shl    $0x3,%eax
     715:	83 ec 0c             	sub    $0xc,%esp
     718:	50                   	push   %eax
     719:	e8 51 fc ff ff       	call   36f <sbrk>
     71e:	83 c4 10             	add    $0x10,%esp
     721:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     724:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     728:	75 07                	jne    731 <morecore+0x38>
    return 0;
     72a:	b8 00 00 00 00       	mov    $0x0,%eax
     72f:	eb 26                	jmp    757 <morecore+0x5e>
  hp = (Header*)p;
     731:	8b 45 f4             	mov    -0xc(%ebp),%eax
     734:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     737:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73a:	8b 55 08             	mov    0x8(%ebp),%edx
     73d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     740:	8b 45 f0             	mov    -0x10(%ebp),%eax
     743:	83 c0 08             	add    $0x8,%eax
     746:	83 ec 0c             	sub    $0xc,%esp
     749:	50                   	push   %eax
     74a:	e8 c8 fe ff ff       	call   617 <free>
     74f:	83 c4 10             	add    $0x10,%esp
  return freep;
     752:	a1 b4 27 00 00       	mov    0x27b4,%eax
}
     757:	c9                   	leave  
     758:	c3                   	ret    

00000759 <malloc>:

void*
malloc(uint nbytes)
{
     759:	55                   	push   %ebp
     75a:	89 e5                	mov    %esp,%ebp
     75c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     75f:	8b 45 08             	mov    0x8(%ebp),%eax
     762:	83 c0 07             	add    $0x7,%eax
     765:	c1 e8 03             	shr    $0x3,%eax
     768:	83 c0 01             	add    $0x1,%eax
     76b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     76e:	a1 b4 27 00 00       	mov    0x27b4,%eax
     773:	89 45 f0             	mov    %eax,-0x10(%ebp)
     776:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     77a:	75 23                	jne    79f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     77c:	c7 45 f0 ac 27 00 00 	movl   $0x27ac,-0x10(%ebp)
     783:	8b 45 f0             	mov    -0x10(%ebp),%eax
     786:	a3 b4 27 00 00       	mov    %eax,0x27b4
     78b:	a1 b4 27 00 00       	mov    0x27b4,%eax
     790:	a3 ac 27 00 00       	mov    %eax,0x27ac
    base.s.size = 0;
     795:	c7 05 b0 27 00 00 00 	movl   $0x0,0x27b0
     79c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a2:	8b 00                	mov    (%eax),%eax
     7a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7aa:	8b 40 04             	mov    0x4(%eax),%eax
     7ad:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7b0:	72 4d                	jb     7ff <malloc+0xa6>
      if(p->s.size == nunits)
     7b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b5:	8b 40 04             	mov    0x4(%eax),%eax
     7b8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7bb:	75 0c                	jne    7c9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c0:	8b 10                	mov    (%eax),%edx
     7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c5:	89 10                	mov    %edx,(%eax)
     7c7:	eb 26                	jmp    7ef <malloc+0x96>
      else {
        p->s.size -= nunits;
     7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cc:	8b 40 04             	mov    0x4(%eax),%eax
     7cf:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7d2:	89 c2                	mov    %eax,%edx
     7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dd:	8b 40 04             	mov    0x4(%eax),%eax
     7e0:	c1 e0 03             	shl    $0x3,%eax
     7e3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e9:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7ec:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f2:	a3 b4 27 00 00       	mov    %eax,0x27b4
      return (void*)(p + 1);
     7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fa:	83 c0 08             	add    $0x8,%eax
     7fd:	eb 3b                	jmp    83a <malloc+0xe1>
    }
    if(p == freep)
     7ff:	a1 b4 27 00 00       	mov    0x27b4,%eax
     804:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     807:	75 1e                	jne    827 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     809:	83 ec 0c             	sub    $0xc,%esp
     80c:	ff 75 ec             	pushl  -0x14(%ebp)
     80f:	e8 e5 fe ff ff       	call   6f9 <morecore>
     814:	83 c4 10             	add    $0x10,%esp
     817:	89 45 f4             	mov    %eax,-0xc(%ebp)
     81a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     81e:	75 07                	jne    827 <malloc+0xce>
        return 0;
     820:	b8 00 00 00 00       	mov    $0x0,%eax
     825:	eb 13                	jmp    83a <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     827:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     830:	8b 00                	mov    (%eax),%eax
     832:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     835:	e9 6d ff ff ff       	jmp    7a7 <malloc+0x4e>
}
     83a:	c9                   	leave  
     83b:	c3                   	ret    

0000083c <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     83c:	55                   	push   %ebp
     83d:	89 e5                	mov    %esp,%ebp
     83f:	83 ec 1c             	sub    $0x1c,%esp
     842:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     845:	8b 55 10             	mov    0x10(%ebp),%edx
     848:	8b 45 14             	mov    0x14(%ebp),%eax
     84b:	88 4d ec             	mov    %cl,-0x14(%ebp)
     84e:	88 55 e8             	mov    %dl,-0x18(%ebp)
     851:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     854:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     858:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     85b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     85f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     862:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     866:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     869:	8b 45 08             	mov    0x8(%ebp),%eax
     86c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     870:	66 89 10             	mov    %dx,(%eax)
     873:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     877:	88 50 02             	mov    %dl,0x2(%eax)
}
     87a:	8b 45 08             	mov    0x8(%ebp),%eax
     87d:	c9                   	leave  
     87e:	c2 04 00             	ret    $0x4

00000881 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     881:	55                   	push   %ebp
     882:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     884:	8b 45 08             	mov    0x8(%ebp),%eax
     887:	2b 45 10             	sub    0x10(%ebp),%eax
     88a:	89 c2                	mov    %eax,%edx
     88c:	8b 45 08             	mov    0x8(%ebp),%eax
     88f:	2b 45 10             	sub    0x10(%ebp),%eax
     892:	0f af d0             	imul   %eax,%edx
     895:	8b 45 0c             	mov    0xc(%ebp),%eax
     898:	2b 45 14             	sub    0x14(%ebp),%eax
     89b:	89 c1                	mov    %eax,%ecx
     89d:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a0:	2b 45 14             	sub    0x14(%ebp),%eax
     8a3:	0f af c1             	imul   %ecx,%eax
     8a6:	01 d0                	add    %edx,%eax
}
     8a8:	5d                   	pop    %ebp
     8a9:	c3                   	ret    

000008aa <abs_int>:

static inline int abs_int(int x)
{
     8aa:	55                   	push   %ebp
     8ab:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8ad:	8b 45 08             	mov    0x8(%ebp),%eax
     8b0:	99                   	cltd   
     8b1:	89 d0                	mov    %edx,%eax
     8b3:	33 45 08             	xor    0x8(%ebp),%eax
     8b6:	29 d0                	sub    %edx,%eax
}
     8b8:	5d                   	pop    %ebp
     8b9:	c3                   	ret    

000008ba <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8ba:	55                   	push   %ebp
     8bb:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8c1:	79 07                	jns    8ca <APGetIndex+0x10>
        return X_SMALLER;
     8c3:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8c8:	eb 40                	jmp    90a <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8ca:	8b 45 08             	mov    0x8(%ebp),%eax
     8cd:	8b 00                	mov    (%eax),%eax
     8cf:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8d2:	7f 07                	jg     8db <APGetIndex+0x21>
        return X_BIGGER;
     8d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8d9:	eb 2f                	jmp    90a <APGetIndex+0x50>
    if (y < 0)
     8db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8df:	79 07                	jns    8e8 <APGetIndex+0x2e>
        return Y_SMALLER;
     8e1:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8e6:	eb 22                	jmp    90a <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8e8:	8b 45 08             	mov    0x8(%ebp),%eax
     8eb:	8b 40 04             	mov    0x4(%eax),%eax
     8ee:	3b 45 10             	cmp    0x10(%ebp),%eax
     8f1:	7f 07                	jg     8fa <APGetIndex+0x40>
        return Y_BIGGER;
     8f3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8f8:	eb 10                	jmp    90a <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8fa:	8b 45 08             	mov    0x8(%ebp),%eax
     8fd:	8b 00                	mov    (%eax),%eax
     8ff:	0f af 45 10          	imul   0x10(%ebp),%eax
     903:	89 c2                	mov    %eax,%edx
     905:	8b 45 0c             	mov    0xc(%ebp),%eax
     908:	01 d0                	add    %edx,%eax
}
     90a:	5d                   	pop    %ebp
     90b:	c3                   	ret    

0000090c <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     90c:	55                   	push   %ebp
     90d:	89 e5                	mov    %esp,%ebp
     90f:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     912:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     919:	8b 45 cc             	mov    -0x34(%ebp),%eax
     91c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     91f:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     926:	83 ec 08             	sub    $0x8,%esp
     929:	6a 00                	push   $0x0
     92b:	ff 75 0c             	pushl  0xc(%ebp)
     92e:	e8 f4 f9 ff ff       	call   327 <open>
     933:	83 c4 10             	add    $0x10,%esp
     936:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     939:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     93d:	79 2e                	jns    96d <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     93f:	83 ec 04             	sub    $0x4,%esp
     942:	ff 75 0c             	pushl  0xc(%ebp)
     945:	68 00 21 00 00       	push   $0x2100
     94a:	6a 01                	push   $0x1
     94c:	e8 35 fb ff ff       	call   486 <printf>
     951:	83 c4 10             	add    $0x10,%esp
        return bmp;
     954:	8b 45 08             	mov    0x8(%ebp),%eax
     957:	8b 55 c8             	mov    -0x38(%ebp),%edx
     95a:	89 10                	mov    %edx,(%eax)
     95c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     95f:	89 50 04             	mov    %edx,0x4(%eax)
     962:	8b 55 d0             	mov    -0x30(%ebp),%edx
     965:	89 50 08             	mov    %edx,0x8(%eax)
     968:	e9 d2 01 00 00       	jmp    b3f <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     96d:	83 ec 04             	sub    $0x4,%esp
     970:	6a 0e                	push   $0xe
     972:	8d 45 ba             	lea    -0x46(%ebp),%eax
     975:	50                   	push   %eax
     976:	ff 75 ec             	pushl  -0x14(%ebp)
     979:	e8 81 f9 ff ff       	call   2ff <read>
     97e:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     981:	83 ec 04             	sub    $0x4,%esp
     984:	6a 28                	push   $0x28
     986:	8d 45 92             	lea    -0x6e(%ebp),%eax
     989:	50                   	push   %eax
     98a:	ff 75 ec             	pushl  -0x14(%ebp)
     98d:	e8 6d f9 ff ff       	call   2ff <read>
     992:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     995:	8b 45 96             	mov    -0x6a(%ebp),%eax
     998:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     99b:	8b 45 9a             	mov    -0x66(%ebp),%eax
     99e:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9a1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9a4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9a7:	0f af d0             	imul   %eax,%edx
     9aa:	89 d0                	mov    %edx,%eax
     9ac:	01 c0                	add    %eax,%eax
     9ae:	01 d0                	add    %edx,%eax
     9b0:	83 ec 0c             	sub    $0xc,%esp
     9b3:	50                   	push   %eax
     9b4:	e8 a0 fd ff ff       	call   759 <malloc>
     9b9:	83 c4 10             	add    $0x10,%esp
     9bc:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9bf:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9c3:	0f b7 c0             	movzwl %ax,%eax
     9c6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9c9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9cf:	0f af c2             	imul   %edx,%eax
     9d2:	83 c0 1f             	add    $0x1f,%eax
     9d5:	c1 e8 05             	shr    $0x5,%eax
     9d8:	c1 e0 02             	shl    $0x2,%eax
     9db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9de:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9e4:	0f af c2             	imul   %edx,%eax
     9e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9ed:	83 ec 0c             	sub    $0xc,%esp
     9f0:	50                   	push   %eax
     9f1:	e8 63 fd ff ff       	call   759 <malloc>
     9f6:	83 c4 10             	add    $0x10,%esp
     9f9:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9fc:	83 ec 04             	sub    $0x4,%esp
     9ff:	ff 75 e0             	pushl  -0x20(%ebp)
     a02:	ff 75 dc             	pushl  -0x24(%ebp)
     a05:	ff 75 ec             	pushl  -0x14(%ebp)
     a08:	e8 f2 f8 ff ff       	call   2ff <read>
     a0d:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a10:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a14:	66 c1 e8 03          	shr    $0x3,%ax
     a18:	0f b7 c0             	movzwl %ax,%eax
     a1b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a25:	e9 e5 00 00 00       	jmp    b0f <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a2a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a30:	29 c2                	sub    %eax,%edx
     a32:	89 d0                	mov    %edx,%eax
     a34:	8d 50 ff             	lea    -0x1(%eax),%edx
     a37:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a3a:	0f af c2             	imul   %edx,%eax
     a3d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a40:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a47:	e9 b1 00 00 00       	jmp    afd <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a4c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a4f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a52:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a55:	01 c8                	add    %ecx,%eax
     a57:	89 c1                	mov    %eax,%ecx
     a59:	89 c8                	mov    %ecx,%eax
     a5b:	01 c0                	add    %eax,%eax
     a5d:	01 c8                	add    %ecx,%eax
     a5f:	01 c2                	add    %eax,%edx
     a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a64:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a68:	89 c1                	mov    %eax,%ecx
     a6a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a6d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a71:	01 c1                	add    %eax,%ecx
     a73:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a76:	01 c8                	add    %ecx,%eax
     a78:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a7b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a7e:	01 c8                	add    %ecx,%eax
     a80:	0f b6 00             	movzbl (%eax),%eax
     a83:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a86:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a89:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a8f:	01 c8                	add    %ecx,%eax
     a91:	89 c1                	mov    %eax,%ecx
     a93:	89 c8                	mov    %ecx,%eax
     a95:	01 c0                	add    %eax,%eax
     a97:	01 c8                	add    %ecx,%eax
     a99:	01 c2                	add    %eax,%edx
     a9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     aa2:	89 c1                	mov    %eax,%ecx
     aa4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aab:	01 c1                	add    %eax,%ecx
     aad:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ab0:	01 c8                	add    %ecx,%eax
     ab2:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ab5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ab8:	01 c8                	add    %ecx,%eax
     aba:	0f b6 00             	movzbl (%eax),%eax
     abd:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ac0:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ac3:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac9:	01 c8                	add    %ecx,%eax
     acb:	89 c1                	mov    %eax,%ecx
     acd:	89 c8                	mov    %ecx,%eax
     acf:	01 c0                	add    %eax,%eax
     ad1:	01 c8                	add    %ecx,%eax
     ad3:	01 c2                	add    %eax,%edx
     ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad8:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     adc:	89 c1                	mov    %eax,%ecx
     ade:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ae1:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ae5:	01 c1                	add    %eax,%ecx
     ae7:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aea:	01 c8                	add    %ecx,%eax
     aec:	8d 48 fd             	lea    -0x3(%eax),%ecx
     aef:	8b 45 dc             	mov    -0x24(%ebp),%eax
     af2:	01 c8                	add    %ecx,%eax
     af4:	0f b6 00             	movzbl (%eax),%eax
     af7:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     af9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     afd:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b03:	39 c2                	cmp    %eax,%edx
     b05:	0f 87 41 ff ff ff    	ja     a4c <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b0b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b0f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b15:	39 c2                	cmp    %eax,%edx
     b17:	0f 87 0d ff ff ff    	ja     a2a <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b1d:	83 ec 0c             	sub    $0xc,%esp
     b20:	ff 75 ec             	pushl  -0x14(%ebp)
     b23:	e8 e7 f7 ff ff       	call   30f <close>
     b28:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b2b:	8b 45 08             	mov    0x8(%ebp),%eax
     b2e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b31:	89 10                	mov    %edx,(%eax)
     b33:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b36:	89 50 04             	mov    %edx,0x4(%eax)
     b39:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b3c:	89 50 08             	mov    %edx,0x8(%eax)
}
     b3f:	8b 45 08             	mov    0x8(%ebp),%eax
     b42:	c9                   	leave  
     b43:	c2 04 00             	ret    $0x4

00000b46 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b46:	55                   	push   %ebp
     b47:	89 e5                	mov    %esp,%ebp
     b49:	53                   	push   %ebx
     b4a:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b4d:	83 ec 0c             	sub    $0xc,%esp
     b50:	6a 1c                	push   $0x1c
     b52:	e8 02 fc ff ff       	call   759 <malloc>
     b57:	83 c4 10             	add    $0x10,%esp
     b5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b60:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b67:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b6a:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b6d:	6a 0c                	push   $0xc
     b6f:	6a 0c                	push   $0xc
     b71:	6a 0c                	push   $0xc
     b73:	50                   	push   %eax
     b74:	e8 c3 fc ff ff       	call   83c <RGB>
     b79:	83 c4 0c             	add    $0xc,%esp
     b7c:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b80:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b84:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b88:	88 43 15             	mov    %al,0x15(%ebx)
     b8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b91:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b95:	66 89 48 10          	mov    %cx,0x10(%eax)
     b99:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b9d:	88 50 12             	mov    %dl,0x12(%eax)
     ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ba6:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     baa:	66 89 48 08          	mov    %cx,0x8(%eax)
     bae:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     bb2:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     bb5:	8b 45 08             	mov    0x8(%ebp),%eax
     bb8:	89 c2                	mov    %eax,%edx
     bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbd:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bbf:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc2:	89 c2                	mov    %eax,%edx
     bc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc7:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bca:	8b 55 10             	mov    0x10(%ebp),%edx
     bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd0:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bd6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bd9:	c9                   	leave  
     bda:	c3                   	ret    

00000bdb <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bdb:	55                   	push   %ebp
     bdc:	89 e5                	mov    %esp,%ebp
     bde:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     be1:	8b 45 0c             	mov    0xc(%ebp),%eax
     be4:	8b 50 08             	mov    0x8(%eax),%edx
     be7:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bea:	8b 40 0c             	mov    0xc(%eax),%eax
     bed:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bf0:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf3:	8b 55 10             	mov    0x10(%ebp),%edx
     bf6:	89 50 08             	mov    %edx,0x8(%eax)
     bf9:	8b 55 14             	mov    0x14(%ebp),%edx
     bfc:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bff:	8b 45 08             	mov    0x8(%ebp),%eax
     c02:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c05:	89 10                	mov    %edx,(%eax)
     c07:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c0a:	89 50 04             	mov    %edx,0x4(%eax)
}
     c0d:	8b 45 08             	mov    0x8(%ebp),%eax
     c10:	c9                   	leave  
     c11:	c2 04 00             	ret    $0x4

00000c14 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c14:	55                   	push   %ebp
     c15:	89 e5                	mov    %esp,%ebp
     c17:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c1a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c1d:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c21:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c25:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c29:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c2f:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c33:	66 89 50 10          	mov    %dx,0x10(%eax)
     c37:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c3b:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c3e:	8b 45 08             	mov    0x8(%ebp),%eax
     c41:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c45:	66 89 10             	mov    %dx,(%eax)
     c48:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c4c:	88 50 02             	mov    %dl,0x2(%eax)
}
     c4f:	8b 45 08             	mov    0x8(%ebp),%eax
     c52:	c9                   	leave  
     c53:	c2 04 00             	ret    $0x4

00000c56 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c56:	55                   	push   %ebp
     c57:	89 e5                	mov    %esp,%ebp
     c59:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c5c:	8b 45 08             	mov    0x8(%ebp),%eax
     c5f:	8b 40 0c             	mov    0xc(%eax),%eax
     c62:	89 c2                	mov    %eax,%edx
     c64:	c1 ea 1f             	shr    $0x1f,%edx
     c67:	01 d0                	add    %edx,%eax
     c69:	d1 f8                	sar    %eax
     c6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c71:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c75:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c78:	8b 45 10             	mov    0x10(%ebp),%eax
     c7b:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c7e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c81:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c85:	0f 89 98 00 00 00    	jns    d23 <APDrawPoint+0xcd>
        i = 0;
     c8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c92:	e9 8c 00 00 00       	jmp    d23 <APDrawPoint+0xcd>
    {
        j = x - off;
     c97:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9a:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c9d:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     ca0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     ca4:	79 69                	jns    d0f <APDrawPoint+0xb9>
            j = 0;
     ca6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cad:	eb 60                	jmp    d0f <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     caf:	ff 75 fc             	pushl  -0x4(%ebp)
     cb2:	ff 75 f8             	pushl  -0x8(%ebp)
     cb5:	ff 75 08             	pushl  0x8(%ebp)
     cb8:	e8 fd fb ff ff       	call   8ba <APGetIndex>
     cbd:	83 c4 0c             	add    $0xc,%esp
     cc0:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cc3:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cc7:	74 55                	je     d1e <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cc9:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     ccd:	74 67                	je     d36 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     ccf:	ff 75 10             	pushl  0x10(%ebp)
     cd2:	ff 75 0c             	pushl  0xc(%ebp)
     cd5:	ff 75 fc             	pushl  -0x4(%ebp)
     cd8:	ff 75 f8             	pushl  -0x8(%ebp)
     cdb:	e8 a1 fb ff ff       	call   881 <distance_2>
     ce0:	83 c4 10             	add    $0x10,%esp
     ce3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     ce6:	7f 23                	jg     d0b <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ce8:	8b 45 08             	mov    0x8(%ebp),%eax
     ceb:	8b 48 18             	mov    0x18(%eax),%ecx
     cee:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cf1:	89 d0                	mov    %edx,%eax
     cf3:	01 c0                	add    %eax,%eax
     cf5:	01 d0                	add    %edx,%eax
     cf7:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cfa:	8b 45 08             	mov    0x8(%ebp),%eax
     cfd:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d01:	66 89 0a             	mov    %cx,(%edx)
     d04:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d08:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d0b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d0f:	8b 55 0c             	mov    0xc(%ebp),%edx
     d12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d15:	01 d0                	add    %edx,%eax
     d17:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d1a:	7d 93                	jge    caf <APDrawPoint+0x59>
     d1c:	eb 01                	jmp    d1f <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d1e:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d1f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d23:	8b 55 10             	mov    0x10(%ebp),%edx
     d26:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d29:	01 d0                	add    %edx,%eax
     d2b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d2e:	0f 8d 63 ff ff ff    	jge    c97 <APDrawPoint+0x41>
     d34:	eb 01                	jmp    d37 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d36:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d37:	c9                   	leave  
     d38:	c3                   	ret    

00000d39 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d39:	55                   	push   %ebp
     d3a:	89 e5                	mov    %esp,%ebp
     d3c:	53                   	push   %ebx
     d3d:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d40:	8b 45 0c             	mov    0xc(%ebp),%eax
     d43:	3b 45 14             	cmp    0x14(%ebp),%eax
     d46:	0f 85 80 00 00 00    	jne    dcc <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d4c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d50:	0f 88 9d 02 00 00    	js     ff3 <APDrawLine+0x2ba>
     d56:	8b 45 08             	mov    0x8(%ebp),%eax
     d59:	8b 00                	mov    (%eax),%eax
     d5b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d5e:	0f 8e 8f 02 00 00    	jle    ff3 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d64:	8b 45 10             	mov    0x10(%ebp),%eax
     d67:	3b 45 18             	cmp    0x18(%ebp),%eax
     d6a:	7e 12                	jle    d7e <APDrawLine+0x45>
        {
            int tmp = y2;
     d6c:	8b 45 18             	mov    0x18(%ebp),%eax
     d6f:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d72:	8b 45 10             	mov    0x10(%ebp),%eax
     d75:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d78:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d7b:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d82:	79 07                	jns    d8b <APDrawLine+0x52>
     d84:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d8b:	8b 45 08             	mov    0x8(%ebp),%eax
     d8e:	8b 40 04             	mov    0x4(%eax),%eax
     d91:	3b 45 18             	cmp    0x18(%ebp),%eax
     d94:	7d 0c                	jge    da2 <APDrawLine+0x69>
     d96:	8b 45 08             	mov    0x8(%ebp),%eax
     d99:	8b 40 04             	mov    0x4(%eax),%eax
     d9c:	83 e8 01             	sub    $0x1,%eax
     d9f:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     da2:	8b 45 10             	mov    0x10(%ebp),%eax
     da5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     da8:	eb 15                	jmp    dbf <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     daa:	ff 75 f4             	pushl  -0xc(%ebp)
     dad:	ff 75 0c             	pushl  0xc(%ebp)
     db0:	ff 75 08             	pushl  0x8(%ebp)
     db3:	e8 9e fe ff ff       	call   c56 <APDrawPoint>
     db8:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     dbb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dc2:	3b 45 18             	cmp    0x18(%ebp),%eax
     dc5:	7e e3                	jle    daa <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dc7:	e9 2b 02 00 00       	jmp    ff7 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dcc:	8b 45 10             	mov    0x10(%ebp),%eax
     dcf:	3b 45 18             	cmp    0x18(%ebp),%eax
     dd2:	75 7f                	jne    e53 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dd4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dd8:	0f 88 18 02 00 00    	js     ff6 <APDrawLine+0x2bd>
     dde:	8b 45 08             	mov    0x8(%ebp),%eax
     de1:	8b 40 04             	mov    0x4(%eax),%eax
     de4:	3b 45 10             	cmp    0x10(%ebp),%eax
     de7:	0f 8e 09 02 00 00    	jle    ff6 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ded:	8b 45 0c             	mov    0xc(%ebp),%eax
     df0:	3b 45 14             	cmp    0x14(%ebp),%eax
     df3:	7e 12                	jle    e07 <APDrawLine+0xce>
        {
            int tmp = x2;
     df5:	8b 45 14             	mov    0x14(%ebp),%eax
     df8:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dfe:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e01:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e04:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e07:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e0b:	79 07                	jns    e14 <APDrawLine+0xdb>
     e0d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e14:	8b 45 08             	mov    0x8(%ebp),%eax
     e17:	8b 00                	mov    (%eax),%eax
     e19:	3b 45 14             	cmp    0x14(%ebp),%eax
     e1c:	7d 0b                	jge    e29 <APDrawLine+0xf0>
     e1e:	8b 45 08             	mov    0x8(%ebp),%eax
     e21:	8b 00                	mov    (%eax),%eax
     e23:	83 e8 01             	sub    $0x1,%eax
     e26:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e29:	8b 45 0c             	mov    0xc(%ebp),%eax
     e2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e2f:	eb 15                	jmp    e46 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e31:	ff 75 10             	pushl  0x10(%ebp)
     e34:	ff 75 f0             	pushl  -0x10(%ebp)
     e37:	ff 75 08             	pushl  0x8(%ebp)
     e3a:	e8 17 fe ff ff       	call   c56 <APDrawPoint>
     e3f:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e42:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e46:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e49:	3b 45 14             	cmp    0x14(%ebp),%eax
     e4c:	7e e3                	jle    e31 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e4e:	e9 a4 01 00 00       	jmp    ff7 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e53:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e5a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e61:	8b 45 0c             	mov    0xc(%ebp),%eax
     e64:	2b 45 14             	sub    0x14(%ebp),%eax
     e67:	50                   	push   %eax
     e68:	e8 3d fa ff ff       	call   8aa <abs_int>
     e6d:	83 c4 04             	add    $0x4,%esp
     e70:	89 c3                	mov    %eax,%ebx
     e72:	8b 45 10             	mov    0x10(%ebp),%eax
     e75:	2b 45 18             	sub    0x18(%ebp),%eax
     e78:	50                   	push   %eax
     e79:	e8 2c fa ff ff       	call   8aa <abs_int>
     e7e:	83 c4 04             	add    $0x4,%esp
     e81:	39 c3                	cmp    %eax,%ebx
     e83:	0f 8e b5 00 00 00    	jle    f3e <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e89:	8b 45 10             	mov    0x10(%ebp),%eax
     e8c:	2b 45 18             	sub    0x18(%ebp),%eax
     e8f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e92:	db 45 b0             	fildl  -0x50(%ebp)
     e95:	8b 45 0c             	mov    0xc(%ebp),%eax
     e98:	2b 45 14             	sub    0x14(%ebp),%eax
     e9b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e9e:	db 45 b0             	fildl  -0x50(%ebp)
     ea1:	de f9                	fdivrp %st,%st(1)
     ea3:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     ea6:	8b 45 14             	mov    0x14(%ebp),%eax
     ea9:	3b 45 0c             	cmp    0xc(%ebp),%eax
     eac:	7e 0e                	jle    ebc <APDrawLine+0x183>
        {
            s = x1;
     eae:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     eb4:	8b 45 14             	mov    0x14(%ebp),%eax
     eb7:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eba:	eb 0c                	jmp    ec8 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ebc:	8b 45 14             	mov    0x14(%ebp),%eax
     ebf:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ec2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec5:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ec8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ecc:	79 07                	jns    ed5 <APDrawLine+0x19c>
     ece:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	8b 00                	mov    (%eax),%eax
     eda:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     edd:	7f 0b                	jg     eea <APDrawLine+0x1b1>
     edf:	8b 45 08             	mov    0x8(%ebp),%eax
     ee2:	8b 00                	mov    (%eax),%eax
     ee4:	83 e8 01             	sub    $0x1,%eax
     ee7:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     eea:	8b 45 ec             	mov    -0x14(%ebp),%eax
     eed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ef0:	eb 3f                	jmp    f31 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ef2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ef5:	2b 45 0c             	sub    0xc(%ebp),%eax
     ef8:	89 45 b0             	mov    %eax,-0x50(%ebp)
     efb:	db 45 b0             	fildl  -0x50(%ebp)
     efe:	dc 4d d0             	fmull  -0x30(%ebp)
     f01:	db 45 10             	fildl  0x10(%ebp)
     f04:	de c1                	faddp  %st,%st(1)
     f06:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f09:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f0d:	b4 0c                	mov    $0xc,%ah
     f0f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f13:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f16:	db 5d cc             	fistpl -0x34(%ebp)
     f19:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f1c:	ff 75 cc             	pushl  -0x34(%ebp)
     f1f:	ff 75 e4             	pushl  -0x1c(%ebp)
     f22:	ff 75 08             	pushl  0x8(%ebp)
     f25:	e8 2c fd ff ff       	call   c56 <APDrawPoint>
     f2a:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f2d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f34:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f37:	7e b9                	jle    ef2 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f39:	e9 b9 00 00 00       	jmp    ff7 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f3e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f41:	2b 45 14             	sub    0x14(%ebp),%eax
     f44:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f47:	db 45 b0             	fildl  -0x50(%ebp)
     f4a:	8b 45 10             	mov    0x10(%ebp),%eax
     f4d:	2b 45 18             	sub    0x18(%ebp),%eax
     f50:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f53:	db 45 b0             	fildl  -0x50(%ebp)
     f56:	de f9                	fdivrp %st,%st(1)
     f58:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f5b:	8b 45 10             	mov    0x10(%ebp),%eax
     f5e:	3b 45 18             	cmp    0x18(%ebp),%eax
     f61:	7e 0e                	jle    f71 <APDrawLine+0x238>
    {
        s = y2;
     f63:	8b 45 18             	mov    0x18(%ebp),%eax
     f66:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f69:	8b 45 10             	mov    0x10(%ebp),%eax
     f6c:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f6f:	eb 0c                	jmp    f7d <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f71:	8b 45 10             	mov    0x10(%ebp),%eax
     f74:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f77:	8b 45 18             	mov    0x18(%ebp),%eax
     f7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f7d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f81:	79 07                	jns    f8a <APDrawLine+0x251>
     f83:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f8a:	8b 45 08             	mov    0x8(%ebp),%eax
     f8d:	8b 40 04             	mov    0x4(%eax),%eax
     f90:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f93:	7f 0c                	jg     fa1 <APDrawLine+0x268>
     f95:	8b 45 08             	mov    0x8(%ebp),%eax
     f98:	8b 40 04             	mov    0x4(%eax),%eax
     f9b:	83 e8 01             	sub    $0x1,%eax
     f9e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fa4:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fa7:	eb 3f                	jmp    fe8 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fa9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fac:	2b 45 10             	sub    0x10(%ebp),%eax
     faf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fb2:	db 45 b0             	fildl  -0x50(%ebp)
     fb5:	dc 4d c0             	fmull  -0x40(%ebp)
     fb8:	db 45 0c             	fildl  0xc(%ebp)
     fbb:	de c1                	faddp  %st,%st(1)
     fbd:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fc0:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fc4:	b4 0c                	mov    $0xc,%ah
     fc6:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fca:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fcd:	db 5d bc             	fistpl -0x44(%ebp)
     fd0:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fd3:	ff 75 e0             	pushl  -0x20(%ebp)
     fd6:	ff 75 bc             	pushl  -0x44(%ebp)
     fd9:	ff 75 08             	pushl  0x8(%ebp)
     fdc:	e8 75 fc ff ff       	call   c56 <APDrawPoint>
     fe1:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fe4:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fe8:	8b 45 e0             	mov    -0x20(%ebp),%eax
     feb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fee:	7e b9                	jle    fa9 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     ff0:	90                   	nop
     ff1:	eb 04                	jmp    ff7 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     ff3:	90                   	nop
     ff4:	eb 01                	jmp    ff7 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     ff6:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     ff7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ffa:	c9                   	leave  
     ffb:	c3                   	ret    

00000ffc <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     ffc:	55                   	push   %ebp
     ffd:	89 e5                	mov    %esp,%ebp
     fff:	53                   	push   %ebx
    1000:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1003:	8b 55 10             	mov    0x10(%ebp),%edx
    1006:	8b 45 18             	mov    0x18(%ebp),%eax
    1009:	01 d0                	add    %edx,%eax
    100b:	83 e8 01             	sub    $0x1,%eax
    100e:	83 ec 04             	sub    $0x4,%esp
    1011:	50                   	push   %eax
    1012:	ff 75 0c             	pushl  0xc(%ebp)
    1015:	ff 75 10             	pushl  0x10(%ebp)
    1018:	ff 75 0c             	pushl  0xc(%ebp)
    101b:	ff 75 08             	pushl  0x8(%ebp)
    101e:	e8 16 fd ff ff       	call   d39 <APDrawLine>
    1023:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1026:	8b 55 0c             	mov    0xc(%ebp),%edx
    1029:	8b 45 14             	mov    0x14(%ebp),%eax
    102c:	01 d0                	add    %edx,%eax
    102e:	83 e8 01             	sub    $0x1,%eax
    1031:	83 ec 04             	sub    $0x4,%esp
    1034:	ff 75 10             	pushl  0x10(%ebp)
    1037:	50                   	push   %eax
    1038:	ff 75 10             	pushl  0x10(%ebp)
    103b:	ff 75 0c             	pushl  0xc(%ebp)
    103e:	ff 75 08             	pushl  0x8(%ebp)
    1041:	e8 f3 fc ff ff       	call   d39 <APDrawLine>
    1046:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1049:	8b 55 10             	mov    0x10(%ebp),%edx
    104c:	8b 45 18             	mov    0x18(%ebp),%eax
    104f:	01 d0                	add    %edx,%eax
    1051:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1054:	8b 55 0c             	mov    0xc(%ebp),%edx
    1057:	8b 45 14             	mov    0x14(%ebp),%eax
    105a:	01 d0                	add    %edx,%eax
    105c:	8d 50 ff             	lea    -0x1(%eax),%edx
    105f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1062:	8b 45 14             	mov    0x14(%ebp),%eax
    1065:	01 d8                	add    %ebx,%eax
    1067:	83 e8 01             	sub    $0x1,%eax
    106a:	83 ec 04             	sub    $0x4,%esp
    106d:	51                   	push   %ecx
    106e:	52                   	push   %edx
    106f:	ff 75 10             	pushl  0x10(%ebp)
    1072:	50                   	push   %eax
    1073:	ff 75 08             	pushl  0x8(%ebp)
    1076:	e8 be fc ff ff       	call   d39 <APDrawLine>
    107b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    107e:	8b 55 10             	mov    0x10(%ebp),%edx
    1081:	8b 45 18             	mov    0x18(%ebp),%eax
    1084:	01 d0                	add    %edx,%eax
    1086:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1089:	8b 55 0c             	mov    0xc(%ebp),%edx
    108c:	8b 45 14             	mov    0x14(%ebp),%eax
    108f:	01 d0                	add    %edx,%eax
    1091:	8d 50 ff             	lea    -0x1(%eax),%edx
    1094:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1097:	8b 45 18             	mov    0x18(%ebp),%eax
    109a:	01 d8                	add    %ebx,%eax
    109c:	83 e8 01             	sub    $0x1,%eax
    109f:	83 ec 04             	sub    $0x4,%esp
    10a2:	51                   	push   %ecx
    10a3:	52                   	push   %edx
    10a4:	50                   	push   %eax
    10a5:	ff 75 0c             	pushl  0xc(%ebp)
    10a8:	ff 75 08             	pushl  0x8(%ebp)
    10ab:	e8 89 fc ff ff       	call   d39 <APDrawLine>
    10b0:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10b3:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b6:	8b 45 14             	mov    0x14(%ebp),%eax
    10b9:	01 d0                	add    %edx,%eax
    10bb:	8d 50 ff             	lea    -0x1(%eax),%edx
    10be:	8b 45 08             	mov    0x8(%ebp),%eax
    10c1:	8b 40 0c             	mov    0xc(%eax),%eax
    10c4:	89 c1                	mov    %eax,%ecx
    10c6:	c1 e9 1f             	shr    $0x1f,%ecx
    10c9:	01 c8                	add    %ecx,%eax
    10cb:	d1 f8                	sar    %eax
    10cd:	29 c2                	sub    %eax,%edx
    10cf:	89 d0                	mov    %edx,%eax
    10d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10d4:	8b 55 10             	mov    0x10(%ebp),%edx
    10d7:	8b 45 18             	mov    0x18(%ebp),%eax
    10da:	01 d0                	add    %edx,%eax
    10dc:	8d 50 ff             	lea    -0x1(%eax),%edx
    10df:	8b 45 08             	mov    0x8(%ebp),%eax
    10e2:	8b 40 0c             	mov    0xc(%eax),%eax
    10e5:	89 c1                	mov    %eax,%ecx
    10e7:	c1 e9 1f             	shr    $0x1f,%ecx
    10ea:	01 c8                	add    %ecx,%eax
    10ec:	d1 f8                	sar    %eax
    10ee:	29 c2                	sub    %eax,%edx
    10f0:	89 d0                	mov    %edx,%eax
    10f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10f5:	8b 45 08             	mov    0x8(%ebp),%eax
    10f8:	8b 40 0c             	mov    0xc(%eax),%eax
    10fb:	89 c2                	mov    %eax,%edx
    10fd:	c1 ea 1f             	shr    $0x1f,%edx
    1100:	01 d0                	add    %edx,%eax
    1102:	d1 f8                	sar    %eax
    1104:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1107:	8b 45 08             	mov    0x8(%ebp),%eax
    110a:	8b 40 0c             	mov    0xc(%eax),%eax
    110d:	89 c2                	mov    %eax,%edx
    110f:	c1 ea 1f             	shr    $0x1f,%edx
    1112:	01 d0                	add    %edx,%eax
    1114:	d1 f8                	sar    %eax
    1116:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1119:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    111d:	0f 88 d8 00 00 00    	js     11fb <APDrawRect+0x1ff>
    1123:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1127:	0f 88 ce 00 00 00    	js     11fb <APDrawRect+0x1ff>
    112d:	8b 45 08             	mov    0x8(%ebp),%eax
    1130:	8b 00                	mov    (%eax),%eax
    1132:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1135:	0f 8e c0 00 00 00    	jle    11fb <APDrawRect+0x1ff>
    113b:	8b 45 08             	mov    0x8(%ebp),%eax
    113e:	8b 40 04             	mov    0x4(%eax),%eax
    1141:	3b 45 10             	cmp    0x10(%ebp),%eax
    1144:	0f 8e b1 00 00 00    	jle    11fb <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    114a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    114e:	79 07                	jns    1157 <APDrawRect+0x15b>
    1150:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1157:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    115b:	79 07                	jns    1164 <APDrawRect+0x168>
    115d:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1164:	8b 45 08             	mov    0x8(%ebp),%eax
    1167:	8b 00                	mov    (%eax),%eax
    1169:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    116c:	7f 0b                	jg     1179 <APDrawRect+0x17d>
    116e:	8b 45 08             	mov    0x8(%ebp),%eax
    1171:	8b 00                	mov    (%eax),%eax
    1173:	83 e8 01             	sub    $0x1,%eax
    1176:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1179:	8b 45 08             	mov    0x8(%ebp),%eax
    117c:	8b 40 04             	mov    0x4(%eax),%eax
    117f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1182:	7f 0c                	jg     1190 <APDrawRect+0x194>
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	8b 40 04             	mov    0x4(%eax),%eax
    118a:	83 e8 01             	sub    $0x1,%eax
    118d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1190:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1197:	8b 45 0c             	mov    0xc(%ebp),%eax
    119a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    119d:	eb 52                	jmp    11f1 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    119f:	8b 45 10             	mov    0x10(%ebp),%eax
    11a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11a5:	eb 3e                	jmp    11e5 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11a7:	83 ec 04             	sub    $0x4,%esp
    11aa:	ff 75 e8             	pushl  -0x18(%ebp)
    11ad:	ff 75 ec             	pushl  -0x14(%ebp)
    11b0:	ff 75 08             	pushl  0x8(%ebp)
    11b3:	e8 02 f7 ff ff       	call   8ba <APGetIndex>
    11b8:	83 c4 10             	add    $0x10,%esp
    11bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11be:	8b 45 08             	mov    0x8(%ebp),%eax
    11c1:	8b 48 18             	mov    0x18(%eax),%ecx
    11c4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11c7:	89 d0                	mov    %edx,%eax
    11c9:	01 c0                	add    %eax,%eax
    11cb:	01 d0                	add    %edx,%eax
    11cd:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11d0:	8b 45 08             	mov    0x8(%ebp),%eax
    11d3:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11d7:	66 89 0a             	mov    %cx,(%edx)
    11da:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11de:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11e1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11eb:	7e ba                	jle    11a7 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11ed:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11f7:	7e a6                	jle    119f <APDrawRect+0x1a3>
    11f9:	eb 01                	jmp    11fc <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11fb:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11ff:	c9                   	leave  
    1200:	c3                   	ret    

00001201 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1201:	55                   	push   %ebp
    1202:	89 e5                	mov    %esp,%ebp
    1204:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1207:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    120b:	0f 88 8e 01 00 00    	js     139f <APDcCopy+0x19e>
    1211:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1215:	0f 88 84 01 00 00    	js     139f <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    121b:	8b 55 0c             	mov    0xc(%ebp),%edx
    121e:	8b 45 20             	mov    0x20(%ebp),%eax
    1221:	01 d0                	add    %edx,%eax
    1223:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1226:	8b 55 10             	mov    0x10(%ebp),%edx
    1229:	8b 45 24             	mov    0x24(%ebp),%eax
    122c:	01 d0                	add    %edx,%eax
    122e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1231:	8b 55 18             	mov    0x18(%ebp),%edx
    1234:	8b 45 20             	mov    0x20(%ebp),%eax
    1237:	01 d0                	add    %edx,%eax
    1239:	89 45 ec             	mov    %eax,-0x14(%ebp)
    123c:	8b 55 1c             	mov    0x1c(%ebp),%edx
    123f:	8b 45 24             	mov    0x24(%ebp),%eax
    1242:	01 d0                	add    %edx,%eax
    1244:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1247:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    124b:	0f 88 51 01 00 00    	js     13a2 <APDcCopy+0x1a1>
    1251:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1255:	0f 88 47 01 00 00    	js     13a2 <APDcCopy+0x1a1>
    125b:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    125f:	0f 88 3d 01 00 00    	js     13a2 <APDcCopy+0x1a1>
    1265:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1269:	0f 88 33 01 00 00    	js     13a2 <APDcCopy+0x1a1>
    126f:	8b 45 14             	mov    0x14(%ebp),%eax
    1272:	8b 00                	mov    (%eax),%eax
    1274:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1277:	0f 8c 25 01 00 00    	jl     13a2 <APDcCopy+0x1a1>
    127d:	8b 45 14             	mov    0x14(%ebp),%eax
    1280:	8b 40 04             	mov    0x4(%eax),%eax
    1283:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1286:	0f 8c 16 01 00 00    	jl     13a2 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    128c:	8b 45 08             	mov    0x8(%ebp),%eax
    128f:	8b 00                	mov    (%eax),%eax
    1291:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1294:	7f 0b                	jg     12a1 <APDcCopy+0xa0>
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	8b 00                	mov    (%eax),%eax
    129b:	83 e8 01             	sub    $0x1,%eax
    129e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	8b 40 04             	mov    0x4(%eax),%eax
    12a7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12aa:	7f 0c                	jg     12b8 <APDcCopy+0xb7>
    12ac:	8b 45 08             	mov    0x8(%ebp),%eax
    12af:	8b 40 04             	mov    0x4(%eax),%eax
    12b2:	83 e8 01             	sub    $0x1,%eax
    12b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12b8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12bf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12cd:	e9 bc 00 00 00       	jmp    138e <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12d2:	8b 45 08             	mov    0x8(%ebp),%eax
    12d5:	8b 00                	mov    (%eax),%eax
    12d7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12da:	8b 55 10             	mov    0x10(%ebp),%edx
    12dd:	01 ca                	add    %ecx,%edx
    12df:	0f af d0             	imul   %eax,%edx
    12e2:	8b 45 0c             	mov    0xc(%ebp),%eax
    12e5:	01 d0                	add    %edx,%eax
    12e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12ea:	8b 45 14             	mov    0x14(%ebp),%eax
    12ed:	8b 00                	mov    (%eax),%eax
    12ef:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12f2:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12f5:	01 ca                	add    %ecx,%edx
    12f7:	0f af d0             	imul   %eax,%edx
    12fa:	8b 45 18             	mov    0x18(%ebp),%eax
    12fd:	01 d0                	add    %edx,%eax
    12ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1302:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1309:	eb 74                	jmp    137f <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    130b:	8b 45 14             	mov    0x14(%ebp),%eax
    130e:	8b 50 18             	mov    0x18(%eax),%edx
    1311:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1314:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1317:	01 c8                	add    %ecx,%eax
    1319:	89 c1                	mov    %eax,%ecx
    131b:	89 c8                	mov    %ecx,%eax
    131d:	01 c0                	add    %eax,%eax
    131f:	01 c8                	add    %ecx,%eax
    1321:	01 d0                	add    %edx,%eax
    1323:	0f b7 10             	movzwl (%eax),%edx
    1326:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    132a:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    132e:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1331:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1335:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1339:	38 c2                	cmp    %al,%dl
    133b:	75 18                	jne    1355 <APDcCopy+0x154>
    133d:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1341:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1345:	38 c2                	cmp    %al,%dl
    1347:	75 0c                	jne    1355 <APDcCopy+0x154>
    1349:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    134d:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1351:	38 c2                	cmp    %al,%dl
    1353:	74 26                	je     137b <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1355:	8b 45 08             	mov    0x8(%ebp),%eax
    1358:	8b 50 18             	mov    0x18(%eax),%edx
    135b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    135e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1361:	01 c8                	add    %ecx,%eax
    1363:	89 c1                	mov    %eax,%ecx
    1365:	89 c8                	mov    %ecx,%eax
    1367:	01 c0                	add    %eax,%eax
    1369:	01 c8                	add    %ecx,%eax
    136b:	01 d0                	add    %edx,%eax
    136d:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1371:	66 89 10             	mov    %dx,(%eax)
    1374:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1378:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    137b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    137f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1382:	2b 45 0c             	sub    0xc(%ebp),%eax
    1385:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1388:	7d 81                	jge    130b <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    138a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    138e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1391:	2b 45 10             	sub    0x10(%ebp),%eax
    1394:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1397:	0f 8d 35 ff ff ff    	jge    12d2 <APDcCopy+0xd1>
    139d:	eb 04                	jmp    13a3 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    139f:	90                   	nop
    13a0:	eb 01                	jmp    13a3 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    13a2:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13a3:	c9                   	leave  
    13a4:	c3                   	ret    

000013a5 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13a5:	55                   	push   %ebp
    13a6:	89 e5                	mov    %esp,%ebp
    13a8:	83 ec 1c             	sub    $0x1c,%esp
    13ab:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13ae:	8b 55 10             	mov    0x10(%ebp),%edx
    13b1:	8b 45 14             	mov    0x14(%ebp),%eax
    13b4:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13b7:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13ba:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13bd:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13c1:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13c4:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13c8:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13cb:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13cf:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13d2:	8b 45 08             	mov    0x8(%ebp),%eax
    13d5:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13d9:	66 89 10             	mov    %dx,(%eax)
    13dc:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13e0:	88 50 02             	mov    %dl,0x2(%eax)
}
    13e3:	8b 45 08             	mov    0x8(%ebp),%eax
    13e6:	c9                   	leave  
    13e7:	c2 04 00             	ret    $0x4

000013ea <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13ea:	55                   	push   %ebp
    13eb:	89 e5                	mov    %esp,%ebp
    13ed:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13f0:	8b 45 08             	mov    0x8(%ebp),%eax
    13f3:	8b 00                	mov    (%eax),%eax
    13f5:	83 ec 08             	sub    $0x8,%esp
    13f8:	8d 55 0c             	lea    0xc(%ebp),%edx
    13fb:	52                   	push   %edx
    13fc:	50                   	push   %eax
    13fd:	e8 95 ef ff ff       	call   397 <sendMessage>
    1402:	83 c4 10             	add    $0x10,%esp
}
    1405:	90                   	nop
    1406:	c9                   	leave  
    1407:	c3                   	ret    

00001408 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1408:	55                   	push   %ebp
    1409:	89 e5                	mov    %esp,%ebp
    140b:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    140e:	83 ec 0c             	sub    $0xc,%esp
    1411:	68 90 00 00 00       	push   $0x90
    1416:	e8 3e f3 ff ff       	call   759 <malloc>
    141b:	83 c4 10             	add    $0x10,%esp
    141e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1421:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1425:	75 15                	jne    143c <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1427:	83 ec 04             	sub    $0x4,%esp
    142a:	ff 75 08             	pushl  0x8(%ebp)
    142d:	68 10 21 00 00       	push   $0x2110
    1432:	6a 01                	push   $0x1
    1434:	e8 4d f0 ff ff       	call   486 <printf>
    1439:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    143c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143f:	83 c0 7c             	add    $0x7c,%eax
    1442:	83 ec 08             	sub    $0x8,%esp
    1445:	ff 75 08             	pushl  0x8(%ebp)
    1448:	50                   	push   %eax
    1449:	e8 68 ec ff ff       	call   b6 <strcpy>
    144e:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1451:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1454:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    145b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145e:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1465:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1468:	8b 40 34             	mov    0x34(%eax),%eax
    146b:	89 c2                	mov    %eax,%edx
    146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1470:	8b 40 38             	mov    0x38(%eax),%eax
    1473:	0f af d0             	imul   %eax,%edx
    1476:	89 d0                	mov    %edx,%eax
    1478:	01 c0                	add    %eax,%eax
    147a:	01 d0                	add    %edx,%eax
    147c:	83 ec 0c             	sub    $0xc,%esp
    147f:	50                   	push   %eax
    1480:	e8 d4 f2 ff ff       	call   759 <malloc>
    1485:	83 c4 10             	add    $0x10,%esp
    1488:	89 c2                	mov    %eax,%edx
    148a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148d:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1490:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1493:	8b 40 4c             	mov    0x4c(%eax),%eax
    1496:	85 c0                	test   %eax,%eax
    1498:	75 15                	jne    14af <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    149a:	83 ec 04             	sub    $0x4,%esp
    149d:	ff 75 08             	pushl  0x8(%ebp)
    14a0:	68 30 21 00 00       	push   $0x2130
    14a5:	6a 01                	push   $0x1
    14a7:	e8 da ef ff ff       	call   486 <printf>
    14ac:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b2:	8b 40 34             	mov    0x34(%eax),%eax
    14b5:	89 c2                	mov    %eax,%edx
    14b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ba:	8b 40 38             	mov    0x38(%eax),%eax
    14bd:	0f af d0             	imul   %eax,%edx
    14c0:	89 d0                	mov    %edx,%eax
    14c2:	01 c0                	add    %eax,%eax
    14c4:	01 c2                	add    %eax,%edx
    14c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c9:	8b 40 4c             	mov    0x4c(%eax),%eax
    14cc:	83 ec 04             	sub    $0x4,%esp
    14cf:	52                   	push   %edx
    14d0:	68 ff ff ff 00       	push   $0xffffff
    14d5:	50                   	push   %eax
    14d6:	e8 71 ec ff ff       	call   14c <memset>
    14db:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e1:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14e8:	e8 7a ee ff ff       	call   367 <getpid>
    14ed:	89 c2                	mov    %eax,%edx
    14ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f2:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f8:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1502:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1509:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150c:	8b 40 50             	mov    0x50(%eax),%eax
    150f:	89 c2                	mov    %eax,%edx
    1511:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1514:	8b 40 54             	mov    0x54(%eax),%eax
    1517:	0f af d0             	imul   %eax,%edx
    151a:	89 d0                	mov    %edx,%eax
    151c:	01 c0                	add    %eax,%eax
    151e:	01 d0                	add    %edx,%eax
    1520:	83 ec 0c             	sub    $0xc,%esp
    1523:	50                   	push   %eax
    1524:	e8 30 f2 ff ff       	call   759 <malloc>
    1529:	83 c4 10             	add    $0x10,%esp
    152c:	89 c2                	mov    %eax,%edx
    152e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1531:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1534:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1537:	8b 40 68             	mov    0x68(%eax),%eax
    153a:	85 c0                	test   %eax,%eax
    153c:	75 15                	jne    1553 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    153e:	83 ec 04             	sub    $0x4,%esp
    1541:	ff 75 08             	pushl  0x8(%ebp)
    1544:	68 54 21 00 00       	push   $0x2154
    1549:	6a 01                	push   $0x1
    154b:	e8 36 ef ff ff       	call   486 <printf>
    1550:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1553:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1556:	8b 40 34             	mov    0x34(%eax),%eax
    1559:	89 c2                	mov    %eax,%edx
    155b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155e:	8b 40 38             	mov    0x38(%eax),%eax
    1561:	0f af d0             	imul   %eax,%edx
    1564:	89 d0                	mov    %edx,%eax
    1566:	01 c0                	add    %eax,%eax
    1568:	01 c2                	add    %eax,%edx
    156a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156d:	8b 40 4c             	mov    0x4c(%eax),%eax
    1570:	83 ec 04             	sub    $0x4,%esp
    1573:	52                   	push   %edx
    1574:	68 ff 00 00 00       	push   $0xff
    1579:	50                   	push   %eax
    157a:	e8 cd eb ff ff       	call   14c <memset>
    157f:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	8b 55 0c             	mov    0xc(%ebp),%edx
    1588:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    158b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    158f:	74 35                	je     15c6 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1591:	8b 45 10             	mov    0x10(%ebp),%eax
    1594:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    159a:	83 ec 0c             	sub    $0xc,%esp
    159d:	50                   	push   %eax
    159e:	e8 b6 f1 ff ff       	call   759 <malloc>
    15a3:	83 c4 10             	add    $0x10,%esp
    15a6:	89 c2                	mov    %eax,%edx
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b1:	8b 55 10             	mov    0x10(%ebp),%edx
    15b4:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15c1:	e9 8d 00 00 00       	jmp    1653 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c9:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d3:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dd:	8b 40 18             	mov    0x18(%eax),%eax
    15e0:	89 c2                	mov    %eax,%edx
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 1c             	mov    0x1c(%eax),%eax
    15e8:	0f af d0             	imul   %eax,%edx
    15eb:	89 d0                	mov    %edx,%eax
    15ed:	01 c0                	add    %eax,%eax
    15ef:	01 d0                	add    %edx,%eax
    15f1:	83 ec 0c             	sub    $0xc,%esp
    15f4:	50                   	push   %eax
    15f5:	e8 5f f1 ff ff       	call   759 <malloc>
    15fa:	83 c4 10             	add    $0x10,%esp
    15fd:	89 c2                	mov    %eax,%edx
    15ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1602:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1605:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1608:	8b 40 30             	mov    0x30(%eax),%eax
    160b:	85 c0                	test   %eax,%eax
    160d:	75 15                	jne    1624 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    160f:	83 ec 04             	sub    $0x4,%esp
    1612:	ff 75 08             	pushl  0x8(%ebp)
    1615:	68 7c 21 00 00       	push   $0x217c
    161a:	6a 01                	push   $0x1
    161c:	e8 65 ee ff ff       	call   486 <printf>
    1621:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1624:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1627:	8b 40 18             	mov    0x18(%eax),%eax
    162a:	89 c2                	mov    %eax,%edx
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	8b 40 1c             	mov    0x1c(%eax),%eax
    1632:	0f af d0             	imul   %eax,%edx
    1635:	89 d0                	mov    %edx,%eax
    1637:	01 c0                	add    %eax,%eax
    1639:	01 c2                	add    %eax,%edx
    163b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163e:	8b 40 30             	mov    0x30(%eax),%eax
    1641:	83 ec 04             	sub    $0x4,%esp
    1644:	52                   	push   %edx
    1645:	68 ff ff ff 00       	push   $0xffffff
    164a:	50                   	push   %eax
    164b:	e8 fc ea ff ff       	call   14c <memset>
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
    165b:	53                   	push   %ebx
    165c:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    165f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1662:	83 f8 03             	cmp    $0x3,%eax
    1665:	74 02                	je     1669 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1667:	eb 33                	jmp    169c <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1669:	8b 45 08             	mov    0x8(%ebp),%eax
    166c:	8b 48 08             	mov    0x8(%eax),%ecx
    166f:	8b 45 08             	mov    0x8(%ebp),%eax
    1672:	8b 50 38             	mov    0x38(%eax),%edx
    1675:	8b 45 08             	mov    0x8(%ebp),%eax
    1678:	8b 40 34             	mov    0x34(%eax),%eax
    167b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    167e:	83 c3 34             	add    $0x34,%ebx
    1681:	83 ec 0c             	sub    $0xc,%esp
    1684:	51                   	push   %ecx
    1685:	52                   	push   %edx
    1686:	50                   	push   %eax
    1687:	6a 00                	push   $0x0
    1689:	6a 00                	push   $0x0
    168b:	53                   	push   %ebx
    168c:	6a 32                	push   $0x32
    168e:	6a 00                	push   $0x0
    1690:	ff 75 08             	pushl  0x8(%ebp)
    1693:	e8 ef ec ff ff       	call   387 <paintWindow>
    1698:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    169b:	90                   	nop
        default: break;
            
            
    }
    return False;
    169c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16a4:	c9                   	leave  
    16a5:	c3                   	ret    

000016a6 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16a6:	55                   	push   %ebp
    16a7:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16ac:	8b 50 08             	mov    0x8(%eax),%edx
    16af:	8b 45 08             	mov    0x8(%ebp),%eax
    16b2:	8b 00                	mov    (%eax),%eax
    16b4:	39 c2                	cmp    %eax,%edx
    16b6:	74 07                	je     16bf <APPreJudge+0x19>
        return False;
    16b8:	b8 00 00 00 00       	mov    $0x0,%eax
    16bd:	eb 05                	jmp    16c4 <APPreJudge+0x1e>
    return True;
    16bf:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16c4:	5d                   	pop    %ebp
    16c5:	c3                   	ret    

000016c6 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16c6:	55                   	push   %ebp
    16c7:	89 e5                	mov    %esp,%ebp
    16c9:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16cc:	8b 45 08             	mov    0x8(%ebp),%eax
    16cf:	8b 55 0c             	mov    0xc(%ebp),%edx
    16d2:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16d5:	83 ec 0c             	sub    $0xc,%esp
    16d8:	ff 75 08             	pushl  0x8(%ebp)
    16db:	e8 c7 ec ff ff       	call   3a7 <registWindow>
    16e0:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16e3:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16ea:	8b 45 08             	mov    0x8(%ebp),%eax
    16ed:	8b 00                	mov    (%eax),%eax
    16ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16f2:	ff 75 f4             	pushl  -0xc(%ebp)
    16f5:	ff 75 f0             	pushl  -0x10(%ebp)
    16f8:	ff 75 ec             	pushl  -0x14(%ebp)
    16fb:	ff 75 08             	pushl  0x8(%ebp)
    16fe:	e8 e7 fc ff ff       	call   13ea <APSendMessage>
    1703:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1706:	83 ec 0c             	sub    $0xc,%esp
    1709:	ff 75 08             	pushl  0x8(%ebp)
    170c:	e8 8e ec ff ff       	call   39f <getMessage>
    1711:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1714:	8b 45 08             	mov    0x8(%ebp),%eax
    1717:	83 c0 6c             	add    $0x6c,%eax
    171a:	83 ec 08             	sub    $0x8,%esp
    171d:	50                   	push   %eax
    171e:	ff 75 08             	pushl  0x8(%ebp)
    1721:	e8 80 ff ff ff       	call   16a6 <APPreJudge>
    1726:	83 c4 10             	add    $0x10,%esp
    1729:	84 c0                	test   %al,%al
    172b:	74 1b                	je     1748 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    172d:	8b 45 08             	mov    0x8(%ebp),%eax
    1730:	ff 70 74             	pushl  0x74(%eax)
    1733:	ff 70 70             	pushl  0x70(%eax)
    1736:	ff 70 6c             	pushl  0x6c(%eax)
    1739:	ff 75 08             	pushl  0x8(%ebp)
    173c:	8b 45 0c             	mov    0xc(%ebp),%eax
    173f:	ff d0                	call   *%eax
    1741:	83 c4 10             	add    $0x10,%esp
    1744:	84 c0                	test   %al,%al
    1746:	75 0c                	jne    1754 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1748:	8b 45 08             	mov    0x8(%ebp),%eax
    174b:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1752:	eb b2                	jmp    1706 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1754:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1755:	90                   	nop
    1756:	c9                   	leave  
    1757:	c3                   	ret    

00001758 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1758:	55                   	push   %ebp
    1759:	89 e5                	mov    %esp,%ebp
    175b:	57                   	push   %edi
    175c:	56                   	push   %esi
    175d:	53                   	push   %ebx
    175e:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1761:	a1 b8 27 00 00       	mov    0x27b8,%eax
    1766:	85 c0                	test   %eax,%eax
    1768:	0f 85 2c 02 00 00    	jne    199a <APGridPaint+0x242>
    {
        iconReady = 1;
    176e:	c7 05 b8 27 00 00 01 	movl   $0x1,0x27b8
    1775:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1778:	8d 45 98             	lea    -0x68(%ebp),%eax
    177b:	83 ec 08             	sub    $0x8,%esp
    177e:	68 a3 21 00 00       	push   $0x21a3
    1783:	50                   	push   %eax
    1784:	e8 83 f1 ff ff       	call   90c <APLoadBitmap>
    1789:	83 c4 0c             	add    $0xc,%esp
    178c:	8b 45 98             	mov    -0x68(%ebp),%eax
    178f:	a3 dc 27 00 00       	mov    %eax,0x27dc
    1794:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1797:	a3 e0 27 00 00       	mov    %eax,0x27e0
    179c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    179f:	a3 e4 27 00 00       	mov    %eax,0x27e4
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17a4:	83 ec 04             	sub    $0x4,%esp
    17a7:	ff 35 e4 27 00 00    	pushl  0x27e4
    17ad:	ff 35 e0 27 00 00    	pushl  0x27e0
    17b3:	ff 35 dc 27 00 00    	pushl  0x27dc
    17b9:	e8 88 f3 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    17be:	83 c4 10             	add    $0x10,%esp
    17c1:	a3 e8 27 00 00       	mov    %eax,0x27e8
        grid_river = APLoadBitmap ("grid_river.bmp");
    17c6:	8d 45 98             	lea    -0x68(%ebp),%eax
    17c9:	83 ec 08             	sub    $0x8,%esp
    17cc:	68 b1 21 00 00       	push   $0x21b1
    17d1:	50                   	push   %eax
    17d2:	e8 35 f1 ff ff       	call   90c <APLoadBitmap>
    17d7:	83 c4 0c             	add    $0xc,%esp
    17da:	8b 45 98             	mov    -0x68(%ebp),%eax
    17dd:	a3 18 28 00 00       	mov    %eax,0x2818
    17e2:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17e5:	a3 1c 28 00 00       	mov    %eax,0x281c
    17ea:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17ed:	a3 20 28 00 00       	mov    %eax,0x2820
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17f2:	83 ec 04             	sub    $0x4,%esp
    17f5:	ff 35 20 28 00 00    	pushl  0x2820
    17fb:	ff 35 1c 28 00 00    	pushl  0x281c
    1801:	ff 35 18 28 00 00    	pushl  0x2818
    1807:	e8 3a f3 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    180c:	83 c4 10             	add    $0x10,%esp
    180f:	a3 08 28 00 00       	mov    %eax,0x2808
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1814:	8d 45 98             	lea    -0x68(%ebp),%eax
    1817:	83 ec 08             	sub    $0x8,%esp
    181a:	68 c0 21 00 00       	push   $0x21c0
    181f:	50                   	push   %eax
    1820:	e8 e7 f0 ff ff       	call   90c <APLoadBitmap>
    1825:	83 c4 0c             	add    $0xc,%esp
    1828:	8b 45 98             	mov    -0x68(%ebp),%eax
    182b:	a3 0c 28 00 00       	mov    %eax,0x280c
    1830:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1833:	a3 10 28 00 00       	mov    %eax,0x2810
    1838:	8b 45 a0             	mov    -0x60(%ebp),%eax
    183b:	a3 14 28 00 00       	mov    %eax,0x2814
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1840:	83 ec 04             	sub    $0x4,%esp
    1843:	ff 35 14 28 00 00    	pushl  0x2814
    1849:	ff 35 10 28 00 00    	pushl  0x2810
    184f:	ff 35 0c 28 00 00    	pushl  0x280c
    1855:	e8 ec f2 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    185a:	83 c4 10             	add    $0x10,%esp
    185d:	a3 bc 27 00 00       	mov    %eax,0x27bc
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1862:	8d 45 98             	lea    -0x68(%ebp),%eax
    1865:	83 ec 08             	sub    $0x8,%esp
    1868:	68 cf 21 00 00       	push   $0x21cf
    186d:	50                   	push   %eax
    186e:	e8 99 f0 ff ff       	call   90c <APLoadBitmap>
    1873:	83 c4 0c             	add    $0xc,%esp
    1876:	8b 45 98             	mov    -0x68(%ebp),%eax
    1879:	a3 f0 27 00 00       	mov    %eax,0x27f0
    187e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1881:	a3 f4 27 00 00       	mov    %eax,0x27f4
    1886:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1889:	a3 f8 27 00 00       	mov    %eax,0x27f8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    188e:	83 ec 04             	sub    $0x4,%esp
    1891:	ff 35 f8 27 00 00    	pushl  0x27f8
    1897:	ff 35 f4 27 00 00    	pushl  0x27f4
    189d:	ff 35 f0 27 00 00    	pushl  0x27f0
    18a3:	e8 9e f2 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    18a8:	83 c4 10             	add    $0x10,%esp
    18ab:	a3 24 28 00 00       	mov    %eax,0x2824
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    18b0:	8d 45 98             	lea    -0x68(%ebp),%eax
    18b3:	83 ec 08             	sub    $0x8,%esp
    18b6:	68 dd 21 00 00       	push   $0x21dd
    18bb:	50                   	push   %eax
    18bc:	e8 4b f0 ff ff       	call   90c <APLoadBitmap>
    18c1:	83 c4 0c             	add    $0xc,%esp
    18c4:	8b 45 98             	mov    -0x68(%ebp),%eax
    18c7:	a3 cc 27 00 00       	mov    %eax,0x27cc
    18cc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18cf:	a3 d0 27 00 00       	mov    %eax,0x27d0
    18d4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18d7:	a3 d4 27 00 00       	mov    %eax,0x27d4
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18dc:	83 ec 04             	sub    $0x4,%esp
    18df:	ff 35 d4 27 00 00    	pushl  0x27d4
    18e5:	ff 35 d0 27 00 00    	pushl  0x27d0
    18eb:	ff 35 cc 27 00 00    	pushl  0x27cc
    18f1:	e8 50 f2 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    18f6:	83 c4 10             	add    $0x10,%esp
    18f9:	a3 ec 27 00 00       	mov    %eax,0x27ec
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18fe:	8d 45 98             	lea    -0x68(%ebp),%eax
    1901:	83 ec 08             	sub    $0x8,%esp
    1904:	68 ed 21 00 00       	push   $0x21ed
    1909:	50                   	push   %eax
    190a:	e8 fd ef ff ff       	call   90c <APLoadBitmap>
    190f:	83 c4 0c             	add    $0xc,%esp
    1912:	8b 45 98             	mov    -0x68(%ebp),%eax
    1915:	a3 c0 27 00 00       	mov    %eax,0x27c0
    191a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    191d:	a3 c4 27 00 00       	mov    %eax,0x27c4
    1922:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1925:	a3 c8 27 00 00       	mov    %eax,0x27c8
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    192a:	83 ec 04             	sub    $0x4,%esp
    192d:	ff 35 c8 27 00 00    	pushl  0x27c8
    1933:	ff 35 c4 27 00 00    	pushl  0x27c4
    1939:	ff 35 c0 27 00 00    	pushl  0x27c0
    193f:	e8 02 f2 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    1944:	83 c4 10             	add    $0x10,%esp
    1947:	a3 d8 27 00 00       	mov    %eax,0x27d8
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    194c:	8d 45 98             	lea    -0x68(%ebp),%eax
    194f:	83 ec 08             	sub    $0x8,%esp
    1952:	68 ff 21 00 00       	push   $0x21ff
    1957:	50                   	push   %eax
    1958:	e8 af ef ff ff       	call   90c <APLoadBitmap>
    195d:	83 c4 0c             	add    $0xc,%esp
    1960:	8b 45 98             	mov    -0x68(%ebp),%eax
    1963:	a3 fc 27 00 00       	mov    %eax,0x27fc
    1968:	8b 45 9c             	mov    -0x64(%ebp),%eax
    196b:	a3 00 28 00 00       	mov    %eax,0x2800
    1970:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1973:	a3 04 28 00 00       	mov    %eax,0x2804
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1978:	83 ec 04             	sub    $0x4,%esp
    197b:	ff 35 04 28 00 00    	pushl  0x2804
    1981:	ff 35 00 28 00 00    	pushl  0x2800
    1987:	ff 35 fc 27 00 00    	pushl  0x27fc
    198d:	e8 b4 f1 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    1992:	83 c4 10             	add    $0x10,%esp
    1995:	a3 28 28 00 00       	mov    %eax,0x2828
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    199a:	8b 45 08             	mov    0x8(%ebp),%eax
    199d:	8b 40 08             	mov    0x8(%eax),%eax
    19a0:	85 c0                	test   %eax,%eax
    19a2:	75 17                	jne    19bb <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19a4:	83 ec 08             	sub    $0x8,%esp
    19a7:	68 10 22 00 00       	push   $0x2210
    19ac:	6a 01                	push   $0x1
    19ae:	e8 d3 ea ff ff       	call   486 <printf>
    19b3:	83 c4 10             	add    $0x10,%esp
        return;
    19b6:	e9 f2 03 00 00       	jmp    1dad <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    19bb:	8b 45 08             	mov    0x8(%ebp),%eax
    19be:	8b 40 10             	mov    0x10(%eax),%eax
    19c1:	85 c0                	test   %eax,%eax
    19c3:	7e 10                	jle    19d5 <APGridPaint+0x27d>
    19c5:	8b 45 08             	mov    0x8(%ebp),%eax
    19c8:	8b 50 14             	mov    0x14(%eax),%edx
    19cb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ce:	8b 40 10             	mov    0x10(%eax),%eax
    19d1:	39 c2                	cmp    %eax,%edx
    19d3:	7c 17                	jl     19ec <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19d5:	83 ec 08             	sub    $0x8,%esp
    19d8:	68 36 22 00 00       	push   $0x2236
    19dd:	6a 01                	push   $0x1
    19df:	e8 a2 ea ff ff       	call   486 <printf>
    19e4:	83 c4 10             	add    $0x10,%esp
        return;
    19e7:	e9 c1 03 00 00       	jmp    1dad <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19ec:	8b 45 08             	mov    0x8(%ebp),%eax
    19ef:	8b 40 14             	mov    0x14(%eax),%eax
    19f2:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19f8:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19fe:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a01:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a08:	e9 96 03 00 00       	jmp    1da3 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a0d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a14:	e9 7c 03 00 00       	jmp    1d95 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a1c:	c1 e0 04             	shl    $0x4,%eax
    1a1f:	89 c2                	mov    %eax,%edx
    1a21:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a24:	01 c2                	add    %eax,%edx
    1a26:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a29:	01 d0                	add    %edx,%eax
    1a2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a31:	8b 40 0c             	mov    0xc(%eax),%eax
    1a34:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a37:	c1 e2 02             	shl    $0x2,%edx
    1a3a:	01 d0                	add    %edx,%eax
    1a3c:	8b 00                	mov    (%eax),%eax
    1a3e:	83 f8 07             	cmp    $0x7,%eax
    1a41:	0f 87 49 03 00 00    	ja     1d90 <APGridPaint+0x638>
    1a47:	8b 04 85 4c 22 00 00 	mov    0x224c(,%eax,4),%eax
    1a4e:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a50:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a53:	6a 0c                	push   $0xc
    1a55:	6a 0c                	push   $0xc
    1a57:	6a 0c                	push   $0xc
    1a59:	50                   	push   %eax
    1a5a:	e8 46 f9 ff ff       	call   13a5 <RGB>
    1a5f:	83 c4 0c             	add    $0xc,%esp
    1a62:	8b 1d e8 27 00 00    	mov    0x27e8,%ebx
    1a68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a6b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a71:	6b c0 32             	imul   $0x32,%eax,%eax
    1a74:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a77:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7a:	8d 78 34             	lea    0x34(%eax),%edi
    1a7d:	83 ec 0c             	sub    $0xc,%esp
    1a80:	83 ec 04             	sub    $0x4,%esp
    1a83:	89 e0                	mov    %esp,%eax
    1a85:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a89:	66 89 30             	mov    %si,(%eax)
    1a8c:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a90:	88 50 02             	mov    %dl,0x2(%eax)
    1a93:	6a 32                	push   $0x32
    1a95:	6a 32                	push   $0x32
    1a97:	6a 00                	push   $0x0
    1a99:	6a 00                	push   $0x0
    1a9b:	53                   	push   %ebx
    1a9c:	51                   	push   %ecx
    1a9d:	ff 75 94             	pushl  -0x6c(%ebp)
    1aa0:	57                   	push   %edi
    1aa1:	e8 5b f7 ff ff       	call   1201 <APDcCopy>
    1aa6:	83 c4 30             	add    $0x30,%esp
                    break;
    1aa9:	e9 e3 02 00 00       	jmp    1d91 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1aae:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ab1:	6a 69                	push   $0x69
    1ab3:	6a 69                	push   $0x69
    1ab5:	6a 69                	push   $0x69
    1ab7:	50                   	push   %eax
    1ab8:	e8 e8 f8 ff ff       	call   13a5 <RGB>
    1abd:	83 c4 0c             	add    $0xc,%esp
    1ac0:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ac4:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ac8:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1acc:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1acf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ad6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ad9:	6a 69                	push   $0x69
    1adb:	6a 69                	push   $0x69
    1add:	6a 69                	push   $0x69
    1adf:	50                   	push   %eax
    1ae0:	e8 c0 f8 ff ff       	call   13a5 <RGB>
    1ae5:	83 c4 0c             	add    $0xc,%esp
    1ae8:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1aec:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1af0:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1af4:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1af7:	8b 45 08             	mov    0x8(%ebp),%eax
    1afa:	8d 50 34             	lea    0x34(%eax),%edx
    1afd:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b00:	ff 75 bc             	pushl  -0x44(%ebp)
    1b03:	ff 75 b8             	pushl  -0x48(%ebp)
    1b06:	52                   	push   %edx
    1b07:	50                   	push   %eax
    1b08:	e8 ce f0 ff ff       	call   bdb <APSetPen>
    1b0d:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b10:	8b 45 08             	mov    0x8(%ebp),%eax
    1b13:	8d 58 34             	lea    0x34(%eax),%ebx
    1b16:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b19:	83 ec 04             	sub    $0x4,%esp
    1b1c:	83 ec 04             	sub    $0x4,%esp
    1b1f:	89 e0                	mov    %esp,%eax
    1b21:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b25:	66 89 08             	mov    %cx,(%eax)
    1b28:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b2c:	88 48 02             	mov    %cl,0x2(%eax)
    1b2f:	53                   	push   %ebx
    1b30:	52                   	push   %edx
    1b31:	e8 de f0 ff ff       	call   c14 <APSetBrush>
    1b36:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b3c:	6b d0 32             	imul   $0x32,%eax,%edx
    1b3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b42:	6b c0 32             	imul   $0x32,%eax,%eax
    1b45:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b48:	83 c1 34             	add    $0x34,%ecx
    1b4b:	83 ec 0c             	sub    $0xc,%esp
    1b4e:	6a 32                	push   $0x32
    1b50:	6a 32                	push   $0x32
    1b52:	52                   	push   %edx
    1b53:	50                   	push   %eax
    1b54:	51                   	push   %ecx
    1b55:	e8 a2 f4 ff ff       	call   ffc <APDrawRect>
    1b5a:	83 c4 20             	add    $0x20,%esp
                    break;
    1b5d:	e9 2f 02 00 00       	jmp    1d91 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b62:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b65:	6a 0c                	push   $0xc
    1b67:	6a 0c                	push   $0xc
    1b69:	6a 0c                	push   $0xc
    1b6b:	50                   	push   %eax
    1b6c:	e8 34 f8 ff ff       	call   13a5 <RGB>
    1b71:	83 c4 0c             	add    $0xc,%esp
    1b74:	8b 1d 28 28 00 00    	mov    0x2828,%ebx
    1b7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b7d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b80:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b83:	6b c0 32             	imul   $0x32,%eax,%eax
    1b86:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b89:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8c:	8d 78 34             	lea    0x34(%eax),%edi
    1b8f:	83 ec 0c             	sub    $0xc,%esp
    1b92:	83 ec 04             	sub    $0x4,%esp
    1b95:	89 e0                	mov    %esp,%eax
    1b97:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b9b:	66 89 30             	mov    %si,(%eax)
    1b9e:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ba2:	88 50 02             	mov    %dl,0x2(%eax)
    1ba5:	6a 32                	push   $0x32
    1ba7:	6a 32                	push   $0x32
    1ba9:	6a 00                	push   $0x0
    1bab:	6a 00                	push   $0x0
    1bad:	53                   	push   %ebx
    1bae:	51                   	push   %ecx
    1baf:	ff 75 94             	pushl  -0x6c(%ebp)
    1bb2:	57                   	push   %edi
    1bb3:	e8 49 f6 ff ff       	call   1201 <APDcCopy>
    1bb8:	83 c4 30             	add    $0x30,%esp
                    break;
    1bbb:	e9 d1 01 00 00       	jmp    1d91 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bc0:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1bc3:	6a 0c                	push   $0xc
    1bc5:	6a 0c                	push   $0xc
    1bc7:	6a 0c                	push   $0xc
    1bc9:	50                   	push   %eax
    1bca:	e8 d6 f7 ff ff       	call   13a5 <RGB>
    1bcf:	83 c4 0c             	add    $0xc,%esp
    1bd2:	8b 1d 08 28 00 00    	mov    0x2808,%ebx
    1bd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bdb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bde:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be1:	6b c0 32             	imul   $0x32,%eax,%eax
    1be4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1be7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bea:	8d 78 34             	lea    0x34(%eax),%edi
    1bed:	83 ec 0c             	sub    $0xc,%esp
    1bf0:	83 ec 04             	sub    $0x4,%esp
    1bf3:	89 e0                	mov    %esp,%eax
    1bf5:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1bf9:	66 89 30             	mov    %si,(%eax)
    1bfc:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c00:	88 50 02             	mov    %dl,0x2(%eax)
    1c03:	6a 32                	push   $0x32
    1c05:	6a 32                	push   $0x32
    1c07:	6a 00                	push   $0x0
    1c09:	6a 00                	push   $0x0
    1c0b:	53                   	push   %ebx
    1c0c:	51                   	push   %ecx
    1c0d:	ff 75 94             	pushl  -0x6c(%ebp)
    1c10:	57                   	push   %edi
    1c11:	e8 eb f5 ff ff       	call   1201 <APDcCopy>
    1c16:	83 c4 30             	add    $0x30,%esp
                    break;
    1c19:	e9 73 01 00 00       	jmp    1d91 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c1e:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c21:	6a 0c                	push   $0xc
    1c23:	6a 0c                	push   $0xc
    1c25:	6a 0c                	push   $0xc
    1c27:	50                   	push   %eax
    1c28:	e8 78 f7 ff ff       	call   13a5 <RGB>
    1c2d:	83 c4 0c             	add    $0xc,%esp
    1c30:	8b 1d ec 27 00 00    	mov    0x27ec,%ebx
    1c36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c39:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c3f:	6b c0 32             	imul   $0x32,%eax,%eax
    1c42:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c45:	8b 45 08             	mov    0x8(%ebp),%eax
    1c48:	8d 78 34             	lea    0x34(%eax),%edi
    1c4b:	83 ec 0c             	sub    $0xc,%esp
    1c4e:	83 ec 04             	sub    $0x4,%esp
    1c51:	89 e0                	mov    %esp,%eax
    1c53:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c57:	66 89 30             	mov    %si,(%eax)
    1c5a:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c5e:	88 50 02             	mov    %dl,0x2(%eax)
    1c61:	6a 32                	push   $0x32
    1c63:	6a 32                	push   $0x32
    1c65:	6a 00                	push   $0x0
    1c67:	6a 00                	push   $0x0
    1c69:	53                   	push   %ebx
    1c6a:	51                   	push   %ecx
    1c6b:	ff 75 94             	pushl  -0x6c(%ebp)
    1c6e:	57                   	push   %edi
    1c6f:	e8 8d f5 ff ff       	call   1201 <APDcCopy>
    1c74:	83 c4 30             	add    $0x30,%esp
                    break;
    1c77:	e9 15 01 00 00       	jmp    1d91 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c7c:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c7f:	6a 0c                	push   $0xc
    1c81:	6a 0c                	push   $0xc
    1c83:	6a 0c                	push   $0xc
    1c85:	50                   	push   %eax
    1c86:	e8 1a f7 ff ff       	call   13a5 <RGB>
    1c8b:	83 c4 0c             	add    $0xc,%esp
    1c8e:	8b 1d 24 28 00 00    	mov    0x2824,%ebx
    1c94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c97:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c9d:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ca3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca6:	8d 78 34             	lea    0x34(%eax),%edi
    1ca9:	83 ec 0c             	sub    $0xc,%esp
    1cac:	83 ec 04             	sub    $0x4,%esp
    1caf:	89 e0                	mov    %esp,%eax
    1cb1:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1cb5:	66 89 30             	mov    %si,(%eax)
    1cb8:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1cbc:	88 50 02             	mov    %dl,0x2(%eax)
    1cbf:	6a 32                	push   $0x32
    1cc1:	6a 32                	push   $0x32
    1cc3:	6a 00                	push   $0x0
    1cc5:	6a 00                	push   $0x0
    1cc7:	53                   	push   %ebx
    1cc8:	51                   	push   %ecx
    1cc9:	ff 75 94             	pushl  -0x6c(%ebp)
    1ccc:	57                   	push   %edi
    1ccd:	e8 2f f5 ff ff       	call   1201 <APDcCopy>
    1cd2:	83 c4 30             	add    $0x30,%esp
                    break;
    1cd5:	e9 b7 00 00 00       	jmp    1d91 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cda:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cdd:	6a 0c                	push   $0xc
    1cdf:	6a 0c                	push   $0xc
    1ce1:	6a 0c                	push   $0xc
    1ce3:	50                   	push   %eax
    1ce4:	e8 bc f6 ff ff       	call   13a5 <RGB>
    1ce9:	83 c4 0c             	add    $0xc,%esp
    1cec:	8b 1d bc 27 00 00    	mov    0x27bc,%ebx
    1cf2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cf5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cf8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cfb:	6b c0 32             	imul   $0x32,%eax,%eax
    1cfe:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d01:	8b 45 08             	mov    0x8(%ebp),%eax
    1d04:	8d 78 34             	lea    0x34(%eax),%edi
    1d07:	83 ec 0c             	sub    $0xc,%esp
    1d0a:	83 ec 04             	sub    $0x4,%esp
    1d0d:	89 e0                	mov    %esp,%eax
    1d0f:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d13:	66 89 30             	mov    %si,(%eax)
    1d16:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d1a:	88 50 02             	mov    %dl,0x2(%eax)
    1d1d:	6a 32                	push   $0x32
    1d1f:	6a 32                	push   $0x32
    1d21:	6a 00                	push   $0x0
    1d23:	6a 00                	push   $0x0
    1d25:	53                   	push   %ebx
    1d26:	51                   	push   %ecx
    1d27:	ff 75 94             	pushl  -0x6c(%ebp)
    1d2a:	57                   	push   %edi
    1d2b:	e8 d1 f4 ff ff       	call   1201 <APDcCopy>
    1d30:	83 c4 30             	add    $0x30,%esp
                    break;
    1d33:	eb 5c                	jmp    1d91 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d35:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d38:	6a 0c                	push   $0xc
    1d3a:	6a 0c                	push   $0xc
    1d3c:	6a 0c                	push   $0xc
    1d3e:	50                   	push   %eax
    1d3f:	e8 61 f6 ff ff       	call   13a5 <RGB>
    1d44:	83 c4 0c             	add    $0xc,%esp
    1d47:	8b 1d d8 27 00 00    	mov    0x27d8,%ebx
    1d4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d50:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d53:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d56:	6b c0 32             	imul   $0x32,%eax,%eax
    1d59:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5f:	8d 78 34             	lea    0x34(%eax),%edi
    1d62:	83 ec 0c             	sub    $0xc,%esp
    1d65:	83 ec 04             	sub    $0x4,%esp
    1d68:	89 e0                	mov    %esp,%eax
    1d6a:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d6e:	66 89 30             	mov    %si,(%eax)
    1d71:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d75:	88 50 02             	mov    %dl,0x2(%eax)
    1d78:	6a 32                	push   $0x32
    1d7a:	6a 32                	push   $0x32
    1d7c:	6a 00                	push   $0x0
    1d7e:	6a 00                	push   $0x0
    1d80:	53                   	push   %ebx
    1d81:	51                   	push   %ecx
    1d82:	ff 75 94             	pushl  -0x6c(%ebp)
    1d85:	57                   	push   %edi
    1d86:	e8 76 f4 ff ff       	call   1201 <APDcCopy>
    1d8b:	83 c4 30             	add    $0x30,%esp
                    break;
    1d8e:	eb 01                	jmp    1d91 <APGridPaint+0x639>
                default: break;
    1d90:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d91:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d95:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d99:	0f 8e 7a fc ff ff    	jle    1a19 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d9f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1da3:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1da7:	0f 8e 60 fc ff ff    	jle    1a0d <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1dad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1db0:	5b                   	pop    %ebx
    1db1:	5e                   	pop    %esi
    1db2:	5f                   	pop    %edi
    1db3:	5d                   	pop    %ebp
    1db4:	c3                   	ret    

00001db5 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1db5:	55                   	push   %ebp
    1db6:	89 e5                	mov    %esp,%ebp
    1db8:	53                   	push   %ebx
    1db9:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1dbc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1dc3:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1dc7:	74 17                	je     1de0 <sprintint+0x2b>
    1dc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1dcd:	79 11                	jns    1de0 <sprintint+0x2b>
        neg = 1;
    1dcf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1dd6:	8b 45 10             	mov    0x10(%ebp),%eax
    1dd9:	f7 d8                	neg    %eax
    1ddb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1dde:	eb 06                	jmp    1de6 <sprintint+0x31>
    } else {
        x = xx;
    1de0:	8b 45 10             	mov    0x10(%ebp),%eax
    1de3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1de6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1ded:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1df0:	8d 41 01             	lea    0x1(%ecx),%eax
    1df3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1df6:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1df9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dfc:	ba 00 00 00 00       	mov    $0x0,%edx
    1e01:	f7 f3                	div    %ebx
    1e03:	89 d0                	mov    %edx,%eax
    1e05:	0f b6 80 98 27 00 00 	movzbl 0x2798(%eax),%eax
    1e0c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e10:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e13:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e16:	ba 00 00 00 00       	mov    $0x0,%edx
    1e1b:	f7 f3                	div    %ebx
    1e1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e20:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e24:	75 c7                	jne    1ded <sprintint+0x38>
    if(neg)
    1e26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e2a:	74 0e                	je     1e3a <sprintint+0x85>
        buf[i++] = '-';
    1e2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e2f:	8d 50 01             	lea    0x1(%eax),%edx
    1e32:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e35:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e3d:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e40:	eb 1b                	jmp    1e5d <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e42:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e45:	8b 00                	mov    (%eax),%eax
    1e47:	8d 48 01             	lea    0x1(%eax),%ecx
    1e4a:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e4d:	89 0a                	mov    %ecx,(%edx)
    1e4f:	89 c2                	mov    %eax,%edx
    1e51:	8b 45 08             	mov    0x8(%ebp),%eax
    1e54:	01 d0                	add    %edx,%eax
    1e56:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e59:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e5d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e61:	7f df                	jg     1e42 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e63:	eb 21                	jmp    1e86 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e65:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e68:	8b 00                	mov    (%eax),%eax
    1e6a:	8d 48 01             	lea    0x1(%eax),%ecx
    1e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e70:	89 0a                	mov    %ecx,(%edx)
    1e72:	89 c2                	mov    %eax,%edx
    1e74:	8b 45 08             	mov    0x8(%ebp),%eax
    1e77:	01 c2                	add    %eax,%edx
    1e79:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e7f:	01 c8                	add    %ecx,%eax
    1e81:	0f b6 00             	movzbl (%eax),%eax
    1e84:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e86:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e8a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e8e:	79 d5                	jns    1e65 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e90:	90                   	nop
    1e91:	83 c4 20             	add    $0x20,%esp
    1e94:	5b                   	pop    %ebx
    1e95:	5d                   	pop    %ebp
    1e96:	c3                   	ret    

00001e97 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e97:	55                   	push   %ebp
    1e98:	89 e5                	mov    %esp,%ebp
    1e9a:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1e9d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1ea4:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1eab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1eb2:	8d 45 0c             	lea    0xc(%ebp),%eax
    1eb5:	83 c0 04             	add    $0x4,%eax
    1eb8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1ebb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1ec2:	e9 d9 01 00 00       	jmp    20a0 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ec7:	8b 55 0c             	mov    0xc(%ebp),%edx
    1eca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ecd:	01 d0                	add    %edx,%eax
    1ecf:	0f b6 00             	movzbl (%eax),%eax
    1ed2:	0f be c0             	movsbl %al,%eax
    1ed5:	25 ff 00 00 00       	and    $0xff,%eax
    1eda:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1edd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ee1:	75 2c                	jne    1f0f <sprintf+0x78>
            if(c == '%'){
    1ee3:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ee7:	75 0c                	jne    1ef5 <sprintf+0x5e>
                state = '%';
    1ee9:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1ef0:	e9 a7 01 00 00       	jmp    209c <sprintf+0x205>
            } else {
                dst[j++] = c;
    1ef5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ef8:	8d 50 01             	lea    0x1(%eax),%edx
    1efb:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1efe:	89 c2                	mov    %eax,%edx
    1f00:	8b 45 08             	mov    0x8(%ebp),%eax
    1f03:	01 d0                	add    %edx,%eax
    1f05:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f08:	88 10                	mov    %dl,(%eax)
    1f0a:	e9 8d 01 00 00       	jmp    209c <sprintf+0x205>
            }
        } else if(state == '%'){
    1f0f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f13:	0f 85 83 01 00 00    	jne    209c <sprintf+0x205>
            if(c == 'd'){
    1f19:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f1d:	75 4c                	jne    1f6b <sprintf+0xd4>
                buf[bi] = '\0';
    1f1f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f22:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f25:	01 d0                	add    %edx,%eax
    1f27:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f2a:	83 ec 0c             	sub    $0xc,%esp
    1f2d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f30:	50                   	push   %eax
    1f31:	e8 1f e3 ff ff       	call   255 <atoi>
    1f36:	83 c4 10             	add    $0x10,%esp
    1f39:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f3c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f46:	8b 00                	mov    (%eax),%eax
    1f48:	83 ec 08             	sub    $0x8,%esp
    1f4b:	ff 75 d8             	pushl  -0x28(%ebp)
    1f4e:	6a 01                	push   $0x1
    1f50:	6a 0a                	push   $0xa
    1f52:	50                   	push   %eax
    1f53:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f56:	50                   	push   %eax
    1f57:	ff 75 08             	pushl  0x8(%ebp)
    1f5a:	e8 56 fe ff ff       	call   1db5 <sprintint>
    1f5f:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f62:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f66:	e9 2a 01 00 00       	jmp    2095 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f6b:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f6f:	74 06                	je     1f77 <sprintf+0xe0>
    1f71:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f75:	75 4c                	jne    1fc3 <sprintf+0x12c>
                buf[bi] = '\0';
    1f77:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f7d:	01 d0                	add    %edx,%eax
    1f7f:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f82:	83 ec 0c             	sub    $0xc,%esp
    1f85:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f88:	50                   	push   %eax
    1f89:	e8 c7 e2 ff ff       	call   255 <atoi>
    1f8e:	83 c4 10             	add    $0x10,%esp
    1f91:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f94:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1f9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f9e:	8b 00                	mov    (%eax),%eax
    1fa0:	83 ec 08             	sub    $0x8,%esp
    1fa3:	ff 75 dc             	pushl  -0x24(%ebp)
    1fa6:	6a 00                	push   $0x0
    1fa8:	6a 10                	push   $0x10
    1faa:	50                   	push   %eax
    1fab:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fae:	50                   	push   %eax
    1faf:	ff 75 08             	pushl  0x8(%ebp)
    1fb2:	e8 fe fd ff ff       	call   1db5 <sprintint>
    1fb7:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fba:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1fbe:	e9 d2 00 00 00       	jmp    2095 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1fc3:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1fc7:	75 46                	jne    200f <sprintf+0x178>
                s = (char*)*ap;
    1fc9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fcc:	8b 00                	mov    (%eax),%eax
    1fce:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1fd1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1fd5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fd9:	75 25                	jne    2000 <sprintf+0x169>
                    s = "(null)";
    1fdb:	c7 45 f4 6c 22 00 00 	movl   $0x226c,-0xc(%ebp)
                while(*s != 0){
    1fe2:	eb 1c                	jmp    2000 <sprintf+0x169>
                    dst[j++] = *s;
    1fe4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fe7:	8d 50 01             	lea    0x1(%eax),%edx
    1fea:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fed:	89 c2                	mov    %eax,%edx
    1fef:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff2:	01 c2                	add    %eax,%edx
    1ff4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ff7:	0f b6 00             	movzbl (%eax),%eax
    1ffa:	88 02                	mov    %al,(%edx)
                    s++;
    1ffc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2000:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2003:	0f b6 00             	movzbl (%eax),%eax
    2006:	84 c0                	test   %al,%al
    2008:	75 da                	jne    1fe4 <sprintf+0x14d>
    200a:	e9 86 00 00 00       	jmp    2095 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    200f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2013:	75 1d                	jne    2032 <sprintf+0x19b>
                dst[j++] = *ap;
    2015:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2018:	8d 50 01             	lea    0x1(%eax),%edx
    201b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    201e:	89 c2                	mov    %eax,%edx
    2020:	8b 45 08             	mov    0x8(%ebp),%eax
    2023:	01 c2                	add    %eax,%edx
    2025:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2028:	8b 00                	mov    (%eax),%eax
    202a:	88 02                	mov    %al,(%edx)
                ap++;
    202c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2030:	eb 63                	jmp    2095 <sprintf+0x1fe>
            } else if(c == '%'){
    2032:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2036:	75 17                	jne    204f <sprintf+0x1b8>
                dst[j++] = c;
    2038:	8b 45 c8             	mov    -0x38(%ebp),%eax
    203b:	8d 50 01             	lea    0x1(%eax),%edx
    203e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2041:	89 c2                	mov    %eax,%edx
    2043:	8b 45 08             	mov    0x8(%ebp),%eax
    2046:	01 d0                	add    %edx,%eax
    2048:	8b 55 e0             	mov    -0x20(%ebp),%edx
    204b:	88 10                	mov    %dl,(%eax)
    204d:	eb 46                	jmp    2095 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    204f:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2053:	7e 18                	jle    206d <sprintf+0x1d6>
    2055:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2059:	7f 12                	jg     206d <sprintf+0x1d6>
            {
                buf[bi++] = c;
    205b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    205e:	8d 50 01             	lea    0x1(%eax),%edx
    2061:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2064:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2067:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    206b:	eb 2f                	jmp    209c <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    206d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2070:	8d 50 01             	lea    0x1(%eax),%edx
    2073:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2076:	89 c2                	mov    %eax,%edx
    2078:	8b 45 08             	mov    0x8(%ebp),%eax
    207b:	01 d0                	add    %edx,%eax
    207d:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2080:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2083:	8d 50 01             	lea    0x1(%eax),%edx
    2086:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2089:	89 c2                	mov    %eax,%edx
    208b:	8b 45 08             	mov    0x8(%ebp),%eax
    208e:	01 d0                	add    %edx,%eax
    2090:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2093:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2095:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    209c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    20a0:	8b 55 0c             	mov    0xc(%ebp),%edx
    20a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20a6:	01 d0                	add    %edx,%eax
    20a8:	0f b6 00             	movzbl (%eax),%eax
    20ab:	84 c0                	test   %al,%al
    20ad:	0f 85 14 fe ff ff    	jne    1ec7 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    20b3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20b6:	8d 50 01             	lea    0x1(%eax),%edx
    20b9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20bc:	89 c2                	mov    %eax,%edx
    20be:	8b 45 08             	mov    0x8(%ebp),%eax
    20c1:	01 d0                	add    %edx,%eax
    20c3:	c6 00 00             	movb   $0x0,(%eax)
}
    20c6:	90                   	nop
    20c7:	c9                   	leave  
    20c8:	c3                   	ret    
