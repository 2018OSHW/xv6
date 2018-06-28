
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
      1c:	68 d4 20 00 00       	push   $0x20d4
      21:	6a 02                	push   $0x2
      23:	e8 66 04 00 00       	call   48e <printf>
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
      6f:	68 e8 20 00 00       	push   $0x20e8
      74:	6a 02                	push   $0x2
      76:	e8 13 04 00 00       	call   48e <printf>
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

000003af <changePosition>:
SYSCALL(changePosition)
     3af:	b8 1b 00 00 00       	mov    $0x1b,%eax
     3b4:	cd 40                	int    $0x40
     3b6:	c3                   	ret    

000003b7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3b7:	55                   	push   %ebp
     3b8:	89 e5                	mov    %esp,%ebp
     3ba:	83 ec 18             	sub    $0x18,%esp
     3bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3c3:	83 ec 04             	sub    $0x4,%esp
     3c6:	6a 01                	push   $0x1
     3c8:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3cb:	50                   	push   %eax
     3cc:	ff 75 08             	pushl  0x8(%ebp)
     3cf:	e8 33 ff ff ff       	call   307 <write>
     3d4:	83 c4 10             	add    $0x10,%esp
}
     3d7:	90                   	nop
     3d8:	c9                   	leave  
     3d9:	c3                   	ret    

000003da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3da:	55                   	push   %ebp
     3db:	89 e5                	mov    %esp,%ebp
     3dd:	53                   	push   %ebx
     3de:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3e8:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3ec:	74 17                	je     405 <printint+0x2b>
     3ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3f2:	79 11                	jns    405 <printint+0x2b>
    neg = 1;
     3f4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3fb:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fe:	f7 d8                	neg    %eax
     400:	89 45 ec             	mov    %eax,-0x14(%ebp)
     403:	eb 06                	jmp    40b <printint+0x31>
  } else {
    x = xx;
     405:	8b 45 0c             	mov    0xc(%ebp),%eax
     408:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     40b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     412:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     415:	8d 41 01             	lea    0x1(%ecx),%eax
     418:	89 45 f4             	mov    %eax,-0xc(%ebp)
     41b:	8b 5d 10             	mov    0x10(%ebp),%ebx
     41e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     421:	ba 00 00 00 00       	mov    $0x0,%edx
     426:	f7 f3                	div    %ebx
     428:	89 d0                	mov    %edx,%eax
     42a:	0f b6 80 8c 27 00 00 	movzbl 0x278c(%eax),%eax
     431:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     435:	8b 5d 10             	mov    0x10(%ebp),%ebx
     438:	8b 45 ec             	mov    -0x14(%ebp),%eax
     43b:	ba 00 00 00 00       	mov    $0x0,%edx
     440:	f7 f3                	div    %ebx
     442:	89 45 ec             	mov    %eax,-0x14(%ebp)
     445:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     449:	75 c7                	jne    412 <printint+0x38>
  if(neg)
     44b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     44f:	74 2d                	je     47e <printint+0xa4>
    buf[i++] = '-';
     451:	8b 45 f4             	mov    -0xc(%ebp),%eax
     454:	8d 50 01             	lea    0x1(%eax),%edx
     457:	89 55 f4             	mov    %edx,-0xc(%ebp)
     45a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     45f:	eb 1d                	jmp    47e <printint+0xa4>
    putc(fd, buf[i]);
     461:	8d 55 dc             	lea    -0x24(%ebp),%edx
     464:	8b 45 f4             	mov    -0xc(%ebp),%eax
     467:	01 d0                	add    %edx,%eax
     469:	0f b6 00             	movzbl (%eax),%eax
     46c:	0f be c0             	movsbl %al,%eax
     46f:	83 ec 08             	sub    $0x8,%esp
     472:	50                   	push   %eax
     473:	ff 75 08             	pushl  0x8(%ebp)
     476:	e8 3c ff ff ff       	call   3b7 <putc>
     47b:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     47e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     482:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     486:	79 d9                	jns    461 <printint+0x87>
    putc(fd, buf[i]);
}
     488:	90                   	nop
     489:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     48c:	c9                   	leave  
     48d:	c3                   	ret    

0000048e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     48e:	55                   	push   %ebp
     48f:	89 e5                	mov    %esp,%ebp
     491:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     494:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     49b:	8d 45 0c             	lea    0xc(%ebp),%eax
     49e:	83 c0 04             	add    $0x4,%eax
     4a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4ab:	e9 59 01 00 00       	jmp    609 <printf+0x17b>
    c = fmt[i] & 0xff;
     4b0:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4b6:	01 d0                	add    %edx,%eax
     4b8:	0f b6 00             	movzbl (%eax),%eax
     4bb:	0f be c0             	movsbl %al,%eax
     4be:	25 ff 00 00 00       	and    $0xff,%eax
     4c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4c6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4ca:	75 2c                	jne    4f8 <printf+0x6a>
      if(c == '%'){
     4cc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4d0:	75 0c                	jne    4de <printf+0x50>
        state = '%';
     4d2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4d9:	e9 27 01 00 00       	jmp    605 <printf+0x177>
      } else {
        putc(fd, c);
     4de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4e1:	0f be c0             	movsbl %al,%eax
     4e4:	83 ec 08             	sub    $0x8,%esp
     4e7:	50                   	push   %eax
     4e8:	ff 75 08             	pushl  0x8(%ebp)
     4eb:	e8 c7 fe ff ff       	call   3b7 <putc>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	e9 0d 01 00 00       	jmp    605 <printf+0x177>
      }
    } else if(state == '%'){
     4f8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4fc:	0f 85 03 01 00 00    	jne    605 <printf+0x177>
      if(c == 'd'){
     502:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     506:	75 1e                	jne    526 <printf+0x98>
        printint(fd, *ap, 10, 1);
     508:	8b 45 e8             	mov    -0x18(%ebp),%eax
     50b:	8b 00                	mov    (%eax),%eax
     50d:	6a 01                	push   $0x1
     50f:	6a 0a                	push   $0xa
     511:	50                   	push   %eax
     512:	ff 75 08             	pushl  0x8(%ebp)
     515:	e8 c0 fe ff ff       	call   3da <printint>
     51a:	83 c4 10             	add    $0x10,%esp
        ap++;
     51d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     521:	e9 d8 00 00 00       	jmp    5fe <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     526:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     52a:	74 06                	je     532 <printf+0xa4>
     52c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     530:	75 1e                	jne    550 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     532:	8b 45 e8             	mov    -0x18(%ebp),%eax
     535:	8b 00                	mov    (%eax),%eax
     537:	6a 00                	push   $0x0
     539:	6a 10                	push   $0x10
     53b:	50                   	push   %eax
     53c:	ff 75 08             	pushl  0x8(%ebp)
     53f:	e8 96 fe ff ff       	call   3da <printint>
     544:	83 c4 10             	add    $0x10,%esp
        ap++;
     547:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     54b:	e9 ae 00 00 00       	jmp    5fe <printf+0x170>
      } else if(c == 's'){
     550:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     554:	75 43                	jne    599 <printf+0x10b>
        s = (char*)*ap;
     556:	8b 45 e8             	mov    -0x18(%ebp),%eax
     559:	8b 00                	mov    (%eax),%eax
     55b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     55e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     562:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     566:	75 25                	jne    58d <printf+0xff>
          s = "(null)";
     568:	c7 45 f4 01 21 00 00 	movl   $0x2101,-0xc(%ebp)
        while(*s != 0){
     56f:	eb 1c                	jmp    58d <printf+0xff>
          putc(fd, *s);
     571:	8b 45 f4             	mov    -0xc(%ebp),%eax
     574:	0f b6 00             	movzbl (%eax),%eax
     577:	0f be c0             	movsbl %al,%eax
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	50                   	push   %eax
     57e:	ff 75 08             	pushl  0x8(%ebp)
     581:	e8 31 fe ff ff       	call   3b7 <putc>
     586:	83 c4 10             	add    $0x10,%esp
          s++;
     589:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     58d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     590:	0f b6 00             	movzbl (%eax),%eax
     593:	84 c0                	test   %al,%al
     595:	75 da                	jne    571 <printf+0xe3>
     597:	eb 65                	jmp    5fe <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     599:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     59d:	75 1d                	jne    5bc <printf+0x12e>
        putc(fd, *ap);
     59f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a2:	8b 00                	mov    (%eax),%eax
     5a4:	0f be c0             	movsbl %al,%eax
     5a7:	83 ec 08             	sub    $0x8,%esp
     5aa:	50                   	push   %eax
     5ab:	ff 75 08             	pushl  0x8(%ebp)
     5ae:	e8 04 fe ff ff       	call   3b7 <putc>
     5b3:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ba:	eb 42                	jmp    5fe <printf+0x170>
      } else if(c == '%'){
     5bc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5c0:	75 17                	jne    5d9 <printf+0x14b>
        putc(fd, c);
     5c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c5:	0f be c0             	movsbl %al,%eax
     5c8:	83 ec 08             	sub    $0x8,%esp
     5cb:	50                   	push   %eax
     5cc:	ff 75 08             	pushl  0x8(%ebp)
     5cf:	e8 e3 fd ff ff       	call   3b7 <putc>
     5d4:	83 c4 10             	add    $0x10,%esp
     5d7:	eb 25                	jmp    5fe <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5d9:	83 ec 08             	sub    $0x8,%esp
     5dc:	6a 25                	push   $0x25
     5de:	ff 75 08             	pushl  0x8(%ebp)
     5e1:	e8 d1 fd ff ff       	call   3b7 <putc>
     5e6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5ec:	0f be c0             	movsbl %al,%eax
     5ef:	83 ec 08             	sub    $0x8,%esp
     5f2:	50                   	push   %eax
     5f3:	ff 75 08             	pushl  0x8(%ebp)
     5f6:	e8 bc fd ff ff       	call   3b7 <putc>
     5fb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     605:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     609:	8b 55 0c             	mov    0xc(%ebp),%edx
     60c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     60f:	01 d0                	add    %edx,%eax
     611:	0f b6 00             	movzbl (%eax),%eax
     614:	84 c0                	test   %al,%al
     616:	0f 85 94 fe ff ff    	jne    4b0 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     61c:	90                   	nop
     61d:	c9                   	leave  
     61e:	c3                   	ret    

0000061f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     61f:	55                   	push   %ebp
     620:	89 e5                	mov    %esp,%ebp
     622:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     625:	8b 45 08             	mov    0x8(%ebp),%eax
     628:	83 e8 08             	sub    $0x8,%eax
     62b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     62e:	a1 bc 27 00 00       	mov    0x27bc,%eax
     633:	89 45 fc             	mov    %eax,-0x4(%ebp)
     636:	eb 24                	jmp    65c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     638:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63b:	8b 00                	mov    (%eax),%eax
     63d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     640:	77 12                	ja     654 <free+0x35>
     642:	8b 45 f8             	mov    -0x8(%ebp),%eax
     645:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     648:	77 24                	ja     66e <free+0x4f>
     64a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64d:	8b 00                	mov    (%eax),%eax
     64f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     652:	77 1a                	ja     66e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     654:	8b 45 fc             	mov    -0x4(%ebp),%eax
     657:	8b 00                	mov    (%eax),%eax
     659:	89 45 fc             	mov    %eax,-0x4(%ebp)
     65c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     662:	76 d4                	jbe    638 <free+0x19>
     664:	8b 45 fc             	mov    -0x4(%ebp),%eax
     667:	8b 00                	mov    (%eax),%eax
     669:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     66c:	76 ca                	jbe    638 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     671:	8b 40 04             	mov    0x4(%eax),%eax
     674:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67e:	01 c2                	add    %eax,%edx
     680:	8b 45 fc             	mov    -0x4(%ebp),%eax
     683:	8b 00                	mov    (%eax),%eax
     685:	39 c2                	cmp    %eax,%edx
     687:	75 24                	jne    6ad <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     689:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68c:	8b 50 04             	mov    0x4(%eax),%edx
     68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     692:	8b 00                	mov    (%eax),%eax
     694:	8b 40 04             	mov    0x4(%eax),%eax
     697:	01 c2                	add    %eax,%edx
     699:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a2:	8b 00                	mov    (%eax),%eax
     6a4:	8b 10                	mov    (%eax),%edx
     6a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a9:	89 10                	mov    %edx,(%eax)
     6ab:	eb 0a                	jmp    6b7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b0:	8b 10                	mov    (%eax),%edx
     6b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ba:	8b 40 04             	mov    0x4(%eax),%eax
     6bd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c7:	01 d0                	add    %edx,%eax
     6c9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6cc:	75 20                	jne    6ee <free+0xcf>
    p->s.size += bp->s.size;
     6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d1:	8b 50 04             	mov    0x4(%eax),%edx
     6d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d7:	8b 40 04             	mov    0x4(%eax),%eax
     6da:	01 c2                	add    %eax,%edx
     6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e5:	8b 10                	mov    (%eax),%edx
     6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ea:	89 10                	mov    %edx,(%eax)
     6ec:	eb 08                	jmp    6f6 <free+0xd7>
  } else
    p->s.ptr = bp;
     6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6f4:	89 10                	mov    %edx,(%eax)
  freep = p;
     6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f9:	a3 bc 27 00 00       	mov    %eax,0x27bc
}
     6fe:	90                   	nop
     6ff:	c9                   	leave  
     700:	c3                   	ret    

00000701 <morecore>:

static Header*
morecore(uint nu)
{
     701:	55                   	push   %ebp
     702:	89 e5                	mov    %esp,%ebp
     704:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     707:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     70e:	77 07                	ja     717 <morecore+0x16>
    nu = 4096;
     710:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     717:	8b 45 08             	mov    0x8(%ebp),%eax
     71a:	c1 e0 03             	shl    $0x3,%eax
     71d:	83 ec 0c             	sub    $0xc,%esp
     720:	50                   	push   %eax
     721:	e8 49 fc ff ff       	call   36f <sbrk>
     726:	83 c4 10             	add    $0x10,%esp
     729:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     72c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     730:	75 07                	jne    739 <morecore+0x38>
    return 0;
     732:	b8 00 00 00 00       	mov    $0x0,%eax
     737:	eb 26                	jmp    75f <morecore+0x5e>
  hp = (Header*)p;
     739:	8b 45 f4             	mov    -0xc(%ebp),%eax
     73c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     73f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     742:	8b 55 08             	mov    0x8(%ebp),%edx
     745:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     748:	8b 45 f0             	mov    -0x10(%ebp),%eax
     74b:	83 c0 08             	add    $0x8,%eax
     74e:	83 ec 0c             	sub    $0xc,%esp
     751:	50                   	push   %eax
     752:	e8 c8 fe ff ff       	call   61f <free>
     757:	83 c4 10             	add    $0x10,%esp
  return freep;
     75a:	a1 bc 27 00 00       	mov    0x27bc,%eax
}
     75f:	c9                   	leave  
     760:	c3                   	ret    

00000761 <malloc>:

void*
malloc(uint nbytes)
{
     761:	55                   	push   %ebp
     762:	89 e5                	mov    %esp,%ebp
     764:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     767:	8b 45 08             	mov    0x8(%ebp),%eax
     76a:	83 c0 07             	add    $0x7,%eax
     76d:	c1 e8 03             	shr    $0x3,%eax
     770:	83 c0 01             	add    $0x1,%eax
     773:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     776:	a1 bc 27 00 00       	mov    0x27bc,%eax
     77b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     77e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     782:	75 23                	jne    7a7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     784:	c7 45 f0 b4 27 00 00 	movl   $0x27b4,-0x10(%ebp)
     78b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78e:	a3 bc 27 00 00       	mov    %eax,0x27bc
     793:	a1 bc 27 00 00       	mov    0x27bc,%eax
     798:	a3 b4 27 00 00       	mov    %eax,0x27b4
    base.s.size = 0;
     79d:	c7 05 b8 27 00 00 00 	movl   $0x0,0x27b8
     7a4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7aa:	8b 00                	mov    (%eax),%eax
     7ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b2:	8b 40 04             	mov    0x4(%eax),%eax
     7b5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7b8:	72 4d                	jb     807 <malloc+0xa6>
      if(p->s.size == nunits)
     7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bd:	8b 40 04             	mov    0x4(%eax),%eax
     7c0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7c3:	75 0c                	jne    7d1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c8:	8b 10                	mov    (%eax),%edx
     7ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7cd:	89 10                	mov    %edx,(%eax)
     7cf:	eb 26                	jmp    7f7 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d4:	8b 40 04             	mov    0x4(%eax),%eax
     7d7:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7da:	89 c2                	mov    %eax,%edx
     7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7df:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e5:	8b 40 04             	mov    0x4(%eax),%eax
     7e8:	c1 e0 03             	shl    $0x3,%eax
     7eb:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7f4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7fa:	a3 bc 27 00 00       	mov    %eax,0x27bc
      return (void*)(p + 1);
     7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     802:	83 c0 08             	add    $0x8,%eax
     805:	eb 3b                	jmp    842 <malloc+0xe1>
    }
    if(p == freep)
     807:	a1 bc 27 00 00       	mov    0x27bc,%eax
     80c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     80f:	75 1e                	jne    82f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     811:	83 ec 0c             	sub    $0xc,%esp
     814:	ff 75 ec             	pushl  -0x14(%ebp)
     817:	e8 e5 fe ff ff       	call   701 <morecore>
     81c:	83 c4 10             	add    $0x10,%esp
     81f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     822:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     826:	75 07                	jne    82f <malloc+0xce>
        return 0;
     828:	b8 00 00 00 00       	mov    $0x0,%eax
     82d:	eb 13                	jmp    842 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     82f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     832:	89 45 f0             	mov    %eax,-0x10(%ebp)
     835:	8b 45 f4             	mov    -0xc(%ebp),%eax
     838:	8b 00                	mov    (%eax),%eax
     83a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     83d:	e9 6d ff ff ff       	jmp    7af <malloc+0x4e>
}
     842:	c9                   	leave  
     843:	c3                   	ret    

00000844 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     844:	55                   	push   %ebp
     845:	89 e5                	mov    %esp,%ebp
     847:	83 ec 1c             	sub    $0x1c,%esp
     84a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     84d:	8b 55 10             	mov    0x10(%ebp),%edx
     850:	8b 45 14             	mov    0x14(%ebp),%eax
     853:	88 4d ec             	mov    %cl,-0x14(%ebp)
     856:	88 55 e8             	mov    %dl,-0x18(%ebp)
     859:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     85c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     860:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     863:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     867:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     86a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     86e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     871:	8b 45 08             	mov    0x8(%ebp),%eax
     874:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     878:	66 89 10             	mov    %dx,(%eax)
     87b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     87f:	88 50 02             	mov    %dl,0x2(%eax)
}
     882:	8b 45 08             	mov    0x8(%ebp),%eax
     885:	c9                   	leave  
     886:	c2 04 00             	ret    $0x4

00000889 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     889:	55                   	push   %ebp
     88a:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     88c:	8b 45 08             	mov    0x8(%ebp),%eax
     88f:	2b 45 10             	sub    0x10(%ebp),%eax
     892:	89 c2                	mov    %eax,%edx
     894:	8b 45 08             	mov    0x8(%ebp),%eax
     897:	2b 45 10             	sub    0x10(%ebp),%eax
     89a:	0f af d0             	imul   %eax,%edx
     89d:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a0:	2b 45 14             	sub    0x14(%ebp),%eax
     8a3:	89 c1                	mov    %eax,%ecx
     8a5:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a8:	2b 45 14             	sub    0x14(%ebp),%eax
     8ab:	0f af c1             	imul   %ecx,%eax
     8ae:	01 d0                	add    %edx,%eax
}
     8b0:	5d                   	pop    %ebp
     8b1:	c3                   	ret    

000008b2 <abs_int>:

static inline int abs_int(int x)
{
     8b2:	55                   	push   %ebp
     8b3:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8b5:	8b 45 08             	mov    0x8(%ebp),%eax
     8b8:	99                   	cltd   
     8b9:	89 d0                	mov    %edx,%eax
     8bb:	33 45 08             	xor    0x8(%ebp),%eax
     8be:	29 d0                	sub    %edx,%eax
}
     8c0:	5d                   	pop    %ebp
     8c1:	c3                   	ret    

000008c2 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8c2:	55                   	push   %ebp
     8c3:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8c9:	79 07                	jns    8d2 <APGetIndex+0x10>
        return X_SMALLER;
     8cb:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8d0:	eb 40                	jmp    912 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8d2:	8b 45 08             	mov    0x8(%ebp),%eax
     8d5:	8b 00                	mov    (%eax),%eax
     8d7:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8da:	7f 07                	jg     8e3 <APGetIndex+0x21>
        return X_BIGGER;
     8dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8e1:	eb 2f                	jmp    912 <APGetIndex+0x50>
    if (y < 0)
     8e3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8e7:	79 07                	jns    8f0 <APGetIndex+0x2e>
        return Y_SMALLER;
     8e9:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8ee:	eb 22                	jmp    912 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8f0:	8b 45 08             	mov    0x8(%ebp),%eax
     8f3:	8b 40 04             	mov    0x4(%eax),%eax
     8f6:	3b 45 10             	cmp    0x10(%ebp),%eax
     8f9:	7f 07                	jg     902 <APGetIndex+0x40>
        return Y_BIGGER;
     8fb:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     900:	eb 10                	jmp    912 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     902:	8b 45 08             	mov    0x8(%ebp),%eax
     905:	8b 00                	mov    (%eax),%eax
     907:	0f af 45 10          	imul   0x10(%ebp),%eax
     90b:	89 c2                	mov    %eax,%edx
     90d:	8b 45 0c             	mov    0xc(%ebp),%eax
     910:	01 d0                	add    %edx,%eax
}
     912:	5d                   	pop    %ebp
     913:	c3                   	ret    

00000914 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     914:	55                   	push   %ebp
     915:	89 e5                	mov    %esp,%ebp
     917:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     91a:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     921:	8b 45 cc             	mov    -0x34(%ebp),%eax
     924:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     927:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     92e:	83 ec 08             	sub    $0x8,%esp
     931:	6a 00                	push   $0x0
     933:	ff 75 0c             	pushl  0xc(%ebp)
     936:	e8 ec f9 ff ff       	call   327 <open>
     93b:	83 c4 10             	add    $0x10,%esp
     93e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     941:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     945:	79 2e                	jns    975 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     947:	83 ec 04             	sub    $0x4,%esp
     94a:	ff 75 0c             	pushl  0xc(%ebp)
     94d:	68 08 21 00 00       	push   $0x2108
     952:	6a 01                	push   $0x1
     954:	e8 35 fb ff ff       	call   48e <printf>
     959:	83 c4 10             	add    $0x10,%esp
        return bmp;
     95c:	8b 45 08             	mov    0x8(%ebp),%eax
     95f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     962:	89 10                	mov    %edx,(%eax)
     964:	8b 55 cc             	mov    -0x34(%ebp),%edx
     967:	89 50 04             	mov    %edx,0x4(%eax)
     96a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     96d:	89 50 08             	mov    %edx,0x8(%eax)
     970:	e9 d2 01 00 00       	jmp    b47 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     975:	83 ec 04             	sub    $0x4,%esp
     978:	6a 0e                	push   $0xe
     97a:	8d 45 ba             	lea    -0x46(%ebp),%eax
     97d:	50                   	push   %eax
     97e:	ff 75 ec             	pushl  -0x14(%ebp)
     981:	e8 79 f9 ff ff       	call   2ff <read>
     986:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     989:	83 ec 04             	sub    $0x4,%esp
     98c:	6a 28                	push   $0x28
     98e:	8d 45 92             	lea    -0x6e(%ebp),%eax
     991:	50                   	push   %eax
     992:	ff 75 ec             	pushl  -0x14(%ebp)
     995:	e8 65 f9 ff ff       	call   2ff <read>
     99a:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     99d:	8b 45 96             	mov    -0x6a(%ebp),%eax
     9a0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     9a3:	8b 45 9a             	mov    -0x66(%ebp),%eax
     9a6:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9a9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9ac:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9af:	0f af d0             	imul   %eax,%edx
     9b2:	89 d0                	mov    %edx,%eax
     9b4:	01 c0                	add    %eax,%eax
     9b6:	01 d0                	add    %edx,%eax
     9b8:	83 ec 0c             	sub    $0xc,%esp
     9bb:	50                   	push   %eax
     9bc:	e8 a0 fd ff ff       	call   761 <malloc>
     9c1:	83 c4 10             	add    $0x10,%esp
     9c4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9c7:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9cb:	0f b7 c0             	movzwl %ax,%eax
     9ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9d1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9d7:	0f af c2             	imul   %edx,%eax
     9da:	83 c0 1f             	add    $0x1f,%eax
     9dd:	c1 e8 05             	shr    $0x5,%eax
     9e0:	c1 e0 02             	shl    $0x2,%eax
     9e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9e6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9ec:	0f af c2             	imul   %edx,%eax
     9ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9f5:	83 ec 0c             	sub    $0xc,%esp
     9f8:	50                   	push   %eax
     9f9:	e8 63 fd ff ff       	call   761 <malloc>
     9fe:	83 c4 10             	add    $0x10,%esp
     a01:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a04:	83 ec 04             	sub    $0x4,%esp
     a07:	ff 75 e0             	pushl  -0x20(%ebp)
     a0a:	ff 75 dc             	pushl  -0x24(%ebp)
     a0d:	ff 75 ec             	pushl  -0x14(%ebp)
     a10:	e8 ea f8 ff ff       	call   2ff <read>
     a15:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a18:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a1c:	66 c1 e8 03          	shr    $0x3,%ax
     a20:	0f b7 c0             	movzwl %ax,%eax
     a23:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a2d:	e9 e5 00 00 00       	jmp    b17 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a32:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a35:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a38:	29 c2                	sub    %eax,%edx
     a3a:	89 d0                	mov    %edx,%eax
     a3c:	8d 50 ff             	lea    -0x1(%eax),%edx
     a3f:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a42:	0f af c2             	imul   %edx,%eax
     a45:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a48:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a4f:	e9 b1 00 00 00       	jmp    b05 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a54:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a57:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a5d:	01 c8                	add    %ecx,%eax
     a5f:	89 c1                	mov    %eax,%ecx
     a61:	89 c8                	mov    %ecx,%eax
     a63:	01 c0                	add    %eax,%eax
     a65:	01 c8                	add    %ecx,%eax
     a67:	01 c2                	add    %eax,%edx
     a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a6c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a70:	89 c1                	mov    %eax,%ecx
     a72:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a75:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a79:	01 c1                	add    %eax,%ecx
     a7b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a7e:	01 c8                	add    %ecx,%eax
     a80:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a83:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a86:	01 c8                	add    %ecx,%eax
     a88:	0f b6 00             	movzbl (%eax),%eax
     a8b:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a8e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a91:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a94:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a97:	01 c8                	add    %ecx,%eax
     a99:	89 c1                	mov    %eax,%ecx
     a9b:	89 c8                	mov    %ecx,%eax
     a9d:	01 c0                	add    %eax,%eax
     a9f:	01 c8                	add    %ecx,%eax
     aa1:	01 c2                	add    %eax,%edx
     aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa6:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     aaa:	89 c1                	mov    %eax,%ecx
     aac:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aaf:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ab3:	01 c1                	add    %eax,%ecx
     ab5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ab8:	01 c8                	add    %ecx,%eax
     aba:	8d 48 fe             	lea    -0x2(%eax),%ecx
     abd:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ac0:	01 c8                	add    %ecx,%eax
     ac2:	0f b6 00             	movzbl (%eax),%eax
     ac5:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ac8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     acb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad1:	01 c8                	add    %ecx,%eax
     ad3:	89 c1                	mov    %eax,%ecx
     ad5:	89 c8                	mov    %ecx,%eax
     ad7:	01 c0                	add    %eax,%eax
     ad9:	01 c8                	add    %ecx,%eax
     adb:	01 c2                	add    %eax,%edx
     add:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae0:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ae4:	89 c1                	mov    %eax,%ecx
     ae6:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ae9:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aed:	01 c1                	add    %eax,%ecx
     aef:	8b 45 d8             	mov    -0x28(%ebp),%eax
     af2:	01 c8                	add    %ecx,%eax
     af4:	8d 48 fd             	lea    -0x3(%eax),%ecx
     af7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     afa:	01 c8                	add    %ecx,%eax
     afc:	0f b6 00             	movzbl (%eax),%eax
     aff:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b01:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b05:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b0b:	39 c2                	cmp    %eax,%edx
     b0d:	0f 87 41 ff ff ff    	ja     a54 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b13:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b17:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1d:	39 c2                	cmp    %eax,%edx
     b1f:	0f 87 0d ff ff ff    	ja     a32 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b25:	83 ec 0c             	sub    $0xc,%esp
     b28:	ff 75 ec             	pushl  -0x14(%ebp)
     b2b:	e8 df f7 ff ff       	call   30f <close>
     b30:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b33:	8b 45 08             	mov    0x8(%ebp),%eax
     b36:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b39:	89 10                	mov    %edx,(%eax)
     b3b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b3e:	89 50 04             	mov    %edx,0x4(%eax)
     b41:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b44:	89 50 08             	mov    %edx,0x8(%eax)
}
     b47:	8b 45 08             	mov    0x8(%ebp),%eax
     b4a:	c9                   	leave  
     b4b:	c2 04 00             	ret    $0x4

00000b4e <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b4e:	55                   	push   %ebp
     b4f:	89 e5                	mov    %esp,%ebp
     b51:	53                   	push   %ebx
     b52:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b55:	83 ec 0c             	sub    $0xc,%esp
     b58:	6a 1c                	push   $0x1c
     b5a:	e8 02 fc ff ff       	call   761 <malloc>
     b5f:	83 c4 10             	add    $0x10,%esp
     b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b68:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b6f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b72:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b75:	6a 0c                	push   $0xc
     b77:	6a 0c                	push   $0xc
     b79:	6a 0c                	push   $0xc
     b7b:	50                   	push   %eax
     b7c:	e8 c3 fc ff ff       	call   844 <RGB>
     b81:	83 c4 0c             	add    $0xc,%esp
     b84:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b88:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b8c:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b90:	88 43 15             	mov    %al,0x15(%ebx)
     b93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b96:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b99:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b9d:	66 89 48 10          	mov    %cx,0x10(%eax)
     ba1:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     ba5:	88 50 12             	mov    %dl,0x12(%eax)
     ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bab:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bae:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bb2:	66 89 48 08          	mov    %cx,0x8(%eax)
     bb6:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     bba:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     bbd:	8b 45 08             	mov    0x8(%ebp),%eax
     bc0:	89 c2                	mov    %eax,%edx
     bc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc5:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bc7:	8b 45 0c             	mov    0xc(%ebp),%eax
     bca:	89 c2                	mov    %eax,%edx
     bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bcf:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bd2:	8b 55 10             	mov    0x10(%ebp),%edx
     bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd8:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     be1:	c9                   	leave  
     be2:	c3                   	ret    

00000be3 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     be3:	55                   	push   %ebp
     be4:	89 e5                	mov    %esp,%ebp
     be6:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     be9:	8b 45 0c             	mov    0xc(%ebp),%eax
     bec:	8b 50 08             	mov    0x8(%eax),%edx
     bef:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bf2:	8b 40 0c             	mov    0xc(%eax),%eax
     bf5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bf8:	8b 45 0c             	mov    0xc(%ebp),%eax
     bfb:	8b 55 10             	mov    0x10(%ebp),%edx
     bfe:	89 50 08             	mov    %edx,0x8(%eax)
     c01:	8b 55 14             	mov    0x14(%ebp),%edx
     c04:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c07:	8b 45 08             	mov    0x8(%ebp),%eax
     c0a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c0d:	89 10                	mov    %edx,(%eax)
     c0f:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c12:	89 50 04             	mov    %edx,0x4(%eax)
}
     c15:	8b 45 08             	mov    0x8(%ebp),%eax
     c18:	c9                   	leave  
     c19:	c2 04 00             	ret    $0x4

00000c1c <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c1c:	55                   	push   %ebp
     c1d:	89 e5                	mov    %esp,%ebp
     c1f:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c22:	8b 45 0c             	mov    0xc(%ebp),%eax
     c25:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c29:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c2d:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c31:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c34:	8b 45 0c             	mov    0xc(%ebp),%eax
     c37:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c3b:	66 89 50 10          	mov    %dx,0x10(%eax)
     c3f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c43:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c46:	8b 45 08             	mov    0x8(%ebp),%eax
     c49:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c4d:	66 89 10             	mov    %dx,(%eax)
     c50:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c54:	88 50 02             	mov    %dl,0x2(%eax)
}
     c57:	8b 45 08             	mov    0x8(%ebp),%eax
     c5a:	c9                   	leave  
     c5b:	c2 04 00             	ret    $0x4

00000c5e <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c5e:	55                   	push   %ebp
     c5f:	89 e5                	mov    %esp,%ebp
     c61:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c64:	8b 45 08             	mov    0x8(%ebp),%eax
     c67:	8b 40 0c             	mov    0xc(%eax),%eax
     c6a:	89 c2                	mov    %eax,%edx
     c6c:	c1 ea 1f             	shr    $0x1f,%edx
     c6f:	01 d0                	add    %edx,%eax
     c71:	d1 f8                	sar    %eax
     c73:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c79:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c80:	8b 45 10             	mov    0x10(%ebp),%eax
     c83:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c86:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c89:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c8d:	0f 89 98 00 00 00    	jns    d2b <APDrawPoint+0xcd>
        i = 0;
     c93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c9a:	e9 8c 00 00 00       	jmp    d2b <APDrawPoint+0xcd>
    {
        j = x - off;
     c9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca2:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ca5:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     ca8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cac:	79 69                	jns    d17 <APDrawPoint+0xb9>
            j = 0;
     cae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cb5:	eb 60                	jmp    d17 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cb7:	ff 75 fc             	pushl  -0x4(%ebp)
     cba:	ff 75 f8             	pushl  -0x8(%ebp)
     cbd:	ff 75 08             	pushl  0x8(%ebp)
     cc0:	e8 fd fb ff ff       	call   8c2 <APGetIndex>
     cc5:	83 c4 0c             	add    $0xc,%esp
     cc8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ccb:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ccf:	74 55                	je     d26 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cd1:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cd5:	74 67                	je     d3e <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cd7:	ff 75 10             	pushl  0x10(%ebp)
     cda:	ff 75 0c             	pushl  0xc(%ebp)
     cdd:	ff 75 fc             	pushl  -0x4(%ebp)
     ce0:	ff 75 f8             	pushl  -0x8(%ebp)
     ce3:	e8 a1 fb ff ff       	call   889 <distance_2>
     ce8:	83 c4 10             	add    $0x10,%esp
     ceb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cee:	7f 23                	jg     d13 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cf0:	8b 45 08             	mov    0x8(%ebp),%eax
     cf3:	8b 48 18             	mov    0x18(%eax),%ecx
     cf6:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cf9:	89 d0                	mov    %edx,%eax
     cfb:	01 c0                	add    %eax,%eax
     cfd:	01 d0                	add    %edx,%eax
     cff:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d02:	8b 45 08             	mov    0x8(%ebp),%eax
     d05:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d09:	66 89 0a             	mov    %cx,(%edx)
     d0c:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d10:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d13:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d17:	8b 55 0c             	mov    0xc(%ebp),%edx
     d1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1d:	01 d0                	add    %edx,%eax
     d1f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d22:	7d 93                	jge    cb7 <APDrawPoint+0x59>
     d24:	eb 01                	jmp    d27 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d26:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d27:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d2b:	8b 55 10             	mov    0x10(%ebp),%edx
     d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d31:	01 d0                	add    %edx,%eax
     d33:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d36:	0f 8d 63 ff ff ff    	jge    c9f <APDrawPoint+0x41>
     d3c:	eb 01                	jmp    d3f <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d3e:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d3f:	c9                   	leave  
     d40:	c3                   	ret    

00000d41 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d41:	55                   	push   %ebp
     d42:	89 e5                	mov    %esp,%ebp
     d44:	53                   	push   %ebx
     d45:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d48:	8b 45 0c             	mov    0xc(%ebp),%eax
     d4b:	3b 45 14             	cmp    0x14(%ebp),%eax
     d4e:	0f 85 80 00 00 00    	jne    dd4 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d54:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d58:	0f 88 9d 02 00 00    	js     ffb <APDrawLine+0x2ba>
     d5e:	8b 45 08             	mov    0x8(%ebp),%eax
     d61:	8b 00                	mov    (%eax),%eax
     d63:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d66:	0f 8e 8f 02 00 00    	jle    ffb <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d6c:	8b 45 10             	mov    0x10(%ebp),%eax
     d6f:	3b 45 18             	cmp    0x18(%ebp),%eax
     d72:	7e 12                	jle    d86 <APDrawLine+0x45>
        {
            int tmp = y2;
     d74:	8b 45 18             	mov    0x18(%ebp),%eax
     d77:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d7a:	8b 45 10             	mov    0x10(%ebp),%eax
     d7d:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d80:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d83:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d86:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d8a:	79 07                	jns    d93 <APDrawLine+0x52>
     d8c:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d93:	8b 45 08             	mov    0x8(%ebp),%eax
     d96:	8b 40 04             	mov    0x4(%eax),%eax
     d99:	3b 45 18             	cmp    0x18(%ebp),%eax
     d9c:	7d 0c                	jge    daa <APDrawLine+0x69>
     d9e:	8b 45 08             	mov    0x8(%ebp),%eax
     da1:	8b 40 04             	mov    0x4(%eax),%eax
     da4:	83 e8 01             	sub    $0x1,%eax
     da7:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     daa:	8b 45 10             	mov    0x10(%ebp),%eax
     dad:	89 45 f4             	mov    %eax,-0xc(%ebp)
     db0:	eb 15                	jmp    dc7 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     db2:	ff 75 f4             	pushl  -0xc(%ebp)
     db5:	ff 75 0c             	pushl  0xc(%ebp)
     db8:	ff 75 08             	pushl  0x8(%ebp)
     dbb:	e8 9e fe ff ff       	call   c5e <APDrawPoint>
     dc0:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     dc3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dca:	3b 45 18             	cmp    0x18(%ebp),%eax
     dcd:	7e e3                	jle    db2 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dcf:	e9 2b 02 00 00       	jmp    fff <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     dd4:	8b 45 10             	mov    0x10(%ebp),%eax
     dd7:	3b 45 18             	cmp    0x18(%ebp),%eax
     dda:	75 7f                	jne    e5b <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ddc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     de0:	0f 88 18 02 00 00    	js     ffe <APDrawLine+0x2bd>
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
     de9:	8b 40 04             	mov    0x4(%eax),%eax
     dec:	3b 45 10             	cmp    0x10(%ebp),%eax
     def:	0f 8e 09 02 00 00    	jle    ffe <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     df5:	8b 45 0c             	mov    0xc(%ebp),%eax
     df8:	3b 45 14             	cmp    0x14(%ebp),%eax
     dfb:	7e 12                	jle    e0f <APDrawLine+0xce>
        {
            int tmp = x2;
     dfd:	8b 45 14             	mov    0x14(%ebp),%eax
     e00:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e03:	8b 45 0c             	mov    0xc(%ebp),%eax
     e06:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e09:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e0c:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e0f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e13:	79 07                	jns    e1c <APDrawLine+0xdb>
     e15:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e1c:	8b 45 08             	mov    0x8(%ebp),%eax
     e1f:	8b 00                	mov    (%eax),%eax
     e21:	3b 45 14             	cmp    0x14(%ebp),%eax
     e24:	7d 0b                	jge    e31 <APDrawLine+0xf0>
     e26:	8b 45 08             	mov    0x8(%ebp),%eax
     e29:	8b 00                	mov    (%eax),%eax
     e2b:	83 e8 01             	sub    $0x1,%eax
     e2e:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e31:	8b 45 0c             	mov    0xc(%ebp),%eax
     e34:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e37:	eb 15                	jmp    e4e <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e39:	ff 75 10             	pushl  0x10(%ebp)
     e3c:	ff 75 f0             	pushl  -0x10(%ebp)
     e3f:	ff 75 08             	pushl  0x8(%ebp)
     e42:	e8 17 fe ff ff       	call   c5e <APDrawPoint>
     e47:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e4a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e51:	3b 45 14             	cmp    0x14(%ebp),%eax
     e54:	7e e3                	jle    e39 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e56:	e9 a4 01 00 00       	jmp    fff <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e5b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e62:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e69:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6c:	2b 45 14             	sub    0x14(%ebp),%eax
     e6f:	50                   	push   %eax
     e70:	e8 3d fa ff ff       	call   8b2 <abs_int>
     e75:	83 c4 04             	add    $0x4,%esp
     e78:	89 c3                	mov    %eax,%ebx
     e7a:	8b 45 10             	mov    0x10(%ebp),%eax
     e7d:	2b 45 18             	sub    0x18(%ebp),%eax
     e80:	50                   	push   %eax
     e81:	e8 2c fa ff ff       	call   8b2 <abs_int>
     e86:	83 c4 04             	add    $0x4,%esp
     e89:	39 c3                	cmp    %eax,%ebx
     e8b:	0f 8e b5 00 00 00    	jle    f46 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e91:	8b 45 10             	mov    0x10(%ebp),%eax
     e94:	2b 45 18             	sub    0x18(%ebp),%eax
     e97:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e9a:	db 45 b0             	fildl  -0x50(%ebp)
     e9d:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea0:	2b 45 14             	sub    0x14(%ebp),%eax
     ea3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ea6:	db 45 b0             	fildl  -0x50(%ebp)
     ea9:	de f9                	fdivrp %st,%st(1)
     eab:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     eae:	8b 45 14             	mov    0x14(%ebp),%eax
     eb1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     eb4:	7e 0e                	jle    ec4 <APDrawLine+0x183>
        {
            s = x1;
     eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb9:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ebc:	8b 45 14             	mov    0x14(%ebp),%eax
     ebf:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ec2:	eb 0c                	jmp    ed0 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ec4:	8b 45 14             	mov    0x14(%ebp),%eax
     ec7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     eca:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecd:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ed0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ed4:	79 07                	jns    edd <APDrawLine+0x19c>
     ed6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     edd:	8b 45 08             	mov    0x8(%ebp),%eax
     ee0:	8b 00                	mov    (%eax),%eax
     ee2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ee5:	7f 0b                	jg     ef2 <APDrawLine+0x1b1>
     ee7:	8b 45 08             	mov    0x8(%ebp),%eax
     eea:	8b 00                	mov    (%eax),%eax
     eec:	83 e8 01             	sub    $0x1,%eax
     eef:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ef2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ef5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ef8:	eb 3f                	jmp    f39 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     efa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     efd:	2b 45 0c             	sub    0xc(%ebp),%eax
     f00:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f03:	db 45 b0             	fildl  -0x50(%ebp)
     f06:	dc 4d d0             	fmull  -0x30(%ebp)
     f09:	db 45 10             	fildl  0x10(%ebp)
     f0c:	de c1                	faddp  %st,%st(1)
     f0e:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f11:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f15:	b4 0c                	mov    $0xc,%ah
     f17:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f1b:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f1e:	db 5d cc             	fistpl -0x34(%ebp)
     f21:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f24:	ff 75 cc             	pushl  -0x34(%ebp)
     f27:	ff 75 e4             	pushl  -0x1c(%ebp)
     f2a:	ff 75 08             	pushl  0x8(%ebp)
     f2d:	e8 2c fd ff ff       	call   c5e <APDrawPoint>
     f32:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f35:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f3c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f3f:	7e b9                	jle    efa <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f41:	e9 b9 00 00 00       	jmp    fff <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f46:	8b 45 0c             	mov    0xc(%ebp),%eax
     f49:	2b 45 14             	sub    0x14(%ebp),%eax
     f4c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f4f:	db 45 b0             	fildl  -0x50(%ebp)
     f52:	8b 45 10             	mov    0x10(%ebp),%eax
     f55:	2b 45 18             	sub    0x18(%ebp),%eax
     f58:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f5b:	db 45 b0             	fildl  -0x50(%ebp)
     f5e:	de f9                	fdivrp %st,%st(1)
     f60:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f63:	8b 45 10             	mov    0x10(%ebp),%eax
     f66:	3b 45 18             	cmp    0x18(%ebp),%eax
     f69:	7e 0e                	jle    f79 <APDrawLine+0x238>
    {
        s = y2;
     f6b:	8b 45 18             	mov    0x18(%ebp),%eax
     f6e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f71:	8b 45 10             	mov    0x10(%ebp),%eax
     f74:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f77:	eb 0c                	jmp    f85 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f79:	8b 45 10             	mov    0x10(%ebp),%eax
     f7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f7f:	8b 45 18             	mov    0x18(%ebp),%eax
     f82:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f85:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f89:	79 07                	jns    f92 <APDrawLine+0x251>
     f8b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f92:	8b 45 08             	mov    0x8(%ebp),%eax
     f95:	8b 40 04             	mov    0x4(%eax),%eax
     f98:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f9b:	7f 0c                	jg     fa9 <APDrawLine+0x268>
     f9d:	8b 45 08             	mov    0x8(%ebp),%eax
     fa0:	8b 40 04             	mov    0x4(%eax),%eax
     fa3:	83 e8 01             	sub    $0x1,%eax
     fa6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fa9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fac:	89 45 e0             	mov    %eax,-0x20(%ebp)
     faf:	eb 3f                	jmp    ff0 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fb1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fb4:	2b 45 10             	sub    0x10(%ebp),%eax
     fb7:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fba:	db 45 b0             	fildl  -0x50(%ebp)
     fbd:	dc 4d c0             	fmull  -0x40(%ebp)
     fc0:	db 45 0c             	fildl  0xc(%ebp)
     fc3:	de c1                	faddp  %st,%st(1)
     fc5:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fc8:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fcc:	b4 0c                	mov    $0xc,%ah
     fce:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fd2:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fd5:	db 5d bc             	fistpl -0x44(%ebp)
     fd8:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fdb:	ff 75 e0             	pushl  -0x20(%ebp)
     fde:	ff 75 bc             	pushl  -0x44(%ebp)
     fe1:	ff 75 08             	pushl  0x8(%ebp)
     fe4:	e8 75 fc ff ff       	call   c5e <APDrawPoint>
     fe9:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fec:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     ff0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ff3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ff6:	7e b9                	jle    fb1 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     ff8:	90                   	nop
     ff9:	eb 04                	jmp    fff <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     ffb:	90                   	nop
     ffc:	eb 01                	jmp    fff <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     ffe:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1002:	c9                   	leave  
    1003:	c3                   	ret    

00001004 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1004:	55                   	push   %ebp
    1005:	89 e5                	mov    %esp,%ebp
    1007:	53                   	push   %ebx
    1008:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    100b:	8b 55 10             	mov    0x10(%ebp),%edx
    100e:	8b 45 18             	mov    0x18(%ebp),%eax
    1011:	01 d0                	add    %edx,%eax
    1013:	83 e8 01             	sub    $0x1,%eax
    1016:	83 ec 04             	sub    $0x4,%esp
    1019:	50                   	push   %eax
    101a:	ff 75 0c             	pushl  0xc(%ebp)
    101d:	ff 75 10             	pushl  0x10(%ebp)
    1020:	ff 75 0c             	pushl  0xc(%ebp)
    1023:	ff 75 08             	pushl  0x8(%ebp)
    1026:	e8 16 fd ff ff       	call   d41 <APDrawLine>
    102b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    102e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1031:	8b 45 14             	mov    0x14(%ebp),%eax
    1034:	01 d0                	add    %edx,%eax
    1036:	83 e8 01             	sub    $0x1,%eax
    1039:	83 ec 04             	sub    $0x4,%esp
    103c:	ff 75 10             	pushl  0x10(%ebp)
    103f:	50                   	push   %eax
    1040:	ff 75 10             	pushl  0x10(%ebp)
    1043:	ff 75 0c             	pushl  0xc(%ebp)
    1046:	ff 75 08             	pushl  0x8(%ebp)
    1049:	e8 f3 fc ff ff       	call   d41 <APDrawLine>
    104e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1051:	8b 55 10             	mov    0x10(%ebp),%edx
    1054:	8b 45 18             	mov    0x18(%ebp),%eax
    1057:	01 d0                	add    %edx,%eax
    1059:	8d 48 ff             	lea    -0x1(%eax),%ecx
    105c:	8b 55 0c             	mov    0xc(%ebp),%edx
    105f:	8b 45 14             	mov    0x14(%ebp),%eax
    1062:	01 d0                	add    %edx,%eax
    1064:	8d 50 ff             	lea    -0x1(%eax),%edx
    1067:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    106a:	8b 45 14             	mov    0x14(%ebp),%eax
    106d:	01 d8                	add    %ebx,%eax
    106f:	83 e8 01             	sub    $0x1,%eax
    1072:	83 ec 04             	sub    $0x4,%esp
    1075:	51                   	push   %ecx
    1076:	52                   	push   %edx
    1077:	ff 75 10             	pushl  0x10(%ebp)
    107a:	50                   	push   %eax
    107b:	ff 75 08             	pushl  0x8(%ebp)
    107e:	e8 be fc ff ff       	call   d41 <APDrawLine>
    1083:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1086:	8b 55 10             	mov    0x10(%ebp),%edx
    1089:	8b 45 18             	mov    0x18(%ebp),%eax
    108c:	01 d0                	add    %edx,%eax
    108e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1091:	8b 55 0c             	mov    0xc(%ebp),%edx
    1094:	8b 45 14             	mov    0x14(%ebp),%eax
    1097:	01 d0                	add    %edx,%eax
    1099:	8d 50 ff             	lea    -0x1(%eax),%edx
    109c:	8b 5d 10             	mov    0x10(%ebp),%ebx
    109f:	8b 45 18             	mov    0x18(%ebp),%eax
    10a2:	01 d8                	add    %ebx,%eax
    10a4:	83 e8 01             	sub    $0x1,%eax
    10a7:	83 ec 04             	sub    $0x4,%esp
    10aa:	51                   	push   %ecx
    10ab:	52                   	push   %edx
    10ac:	50                   	push   %eax
    10ad:	ff 75 0c             	pushl  0xc(%ebp)
    10b0:	ff 75 08             	pushl  0x8(%ebp)
    10b3:	e8 89 fc ff ff       	call   d41 <APDrawLine>
    10b8:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    10be:	8b 45 14             	mov    0x14(%ebp),%eax
    10c1:	01 d0                	add    %edx,%eax
    10c3:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c6:	8b 45 08             	mov    0x8(%ebp),%eax
    10c9:	8b 40 0c             	mov    0xc(%eax),%eax
    10cc:	89 c1                	mov    %eax,%ecx
    10ce:	c1 e9 1f             	shr    $0x1f,%ecx
    10d1:	01 c8                	add    %ecx,%eax
    10d3:	d1 f8                	sar    %eax
    10d5:	29 c2                	sub    %eax,%edx
    10d7:	89 d0                	mov    %edx,%eax
    10d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10dc:	8b 55 10             	mov    0x10(%ebp),%edx
    10df:	8b 45 18             	mov    0x18(%ebp),%eax
    10e2:	01 d0                	add    %edx,%eax
    10e4:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ea:	8b 40 0c             	mov    0xc(%eax),%eax
    10ed:	89 c1                	mov    %eax,%ecx
    10ef:	c1 e9 1f             	shr    $0x1f,%ecx
    10f2:	01 c8                	add    %ecx,%eax
    10f4:	d1 f8                	sar    %eax
    10f6:	29 c2                	sub    %eax,%edx
    10f8:	89 d0                	mov    %edx,%eax
    10fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1100:	8b 40 0c             	mov    0xc(%eax),%eax
    1103:	89 c2                	mov    %eax,%edx
    1105:	c1 ea 1f             	shr    $0x1f,%edx
    1108:	01 d0                	add    %edx,%eax
    110a:	d1 f8                	sar    %eax
    110c:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    110f:	8b 45 08             	mov    0x8(%ebp),%eax
    1112:	8b 40 0c             	mov    0xc(%eax),%eax
    1115:	89 c2                	mov    %eax,%edx
    1117:	c1 ea 1f             	shr    $0x1f,%edx
    111a:	01 d0                	add    %edx,%eax
    111c:	d1 f8                	sar    %eax
    111e:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1121:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1125:	0f 88 d8 00 00 00    	js     1203 <APDrawRect+0x1ff>
    112b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    112f:	0f 88 ce 00 00 00    	js     1203 <APDrawRect+0x1ff>
    1135:	8b 45 08             	mov    0x8(%ebp),%eax
    1138:	8b 00                	mov    (%eax),%eax
    113a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    113d:	0f 8e c0 00 00 00    	jle    1203 <APDrawRect+0x1ff>
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	8b 40 04             	mov    0x4(%eax),%eax
    1149:	3b 45 10             	cmp    0x10(%ebp),%eax
    114c:	0f 8e b1 00 00 00    	jle    1203 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1152:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1156:	79 07                	jns    115f <APDrawRect+0x15b>
    1158:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    115f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1163:	79 07                	jns    116c <APDrawRect+0x168>
    1165:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    116c:	8b 45 08             	mov    0x8(%ebp),%eax
    116f:	8b 00                	mov    (%eax),%eax
    1171:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1174:	7f 0b                	jg     1181 <APDrawRect+0x17d>
    1176:	8b 45 08             	mov    0x8(%ebp),%eax
    1179:	8b 00                	mov    (%eax),%eax
    117b:	83 e8 01             	sub    $0x1,%eax
    117e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1181:	8b 45 08             	mov    0x8(%ebp),%eax
    1184:	8b 40 04             	mov    0x4(%eax),%eax
    1187:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    118a:	7f 0c                	jg     1198 <APDrawRect+0x194>
    118c:	8b 45 08             	mov    0x8(%ebp),%eax
    118f:	8b 40 04             	mov    0x4(%eax),%eax
    1192:	83 e8 01             	sub    $0x1,%eax
    1195:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1198:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    119f:	8b 45 0c             	mov    0xc(%ebp),%eax
    11a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11a5:	eb 52                	jmp    11f9 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11a7:	8b 45 10             	mov    0x10(%ebp),%eax
    11aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11ad:	eb 3e                	jmp    11ed <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11af:	83 ec 04             	sub    $0x4,%esp
    11b2:	ff 75 e8             	pushl  -0x18(%ebp)
    11b5:	ff 75 ec             	pushl  -0x14(%ebp)
    11b8:	ff 75 08             	pushl  0x8(%ebp)
    11bb:	e8 02 f7 ff ff       	call   8c2 <APGetIndex>
    11c0:	83 c4 10             	add    $0x10,%esp
    11c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11c6:	8b 45 08             	mov    0x8(%ebp),%eax
    11c9:	8b 48 18             	mov    0x18(%eax),%ecx
    11cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11cf:	89 d0                	mov    %edx,%eax
    11d1:	01 c0                	add    %eax,%eax
    11d3:	01 d0                	add    %edx,%eax
    11d5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11d8:	8b 45 08             	mov    0x8(%ebp),%eax
    11db:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11df:	66 89 0a             	mov    %cx,(%edx)
    11e2:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11e6:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11e9:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11f0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11f3:	7e ba                	jle    11af <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11f5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11ff:	7e a6                	jle    11a7 <APDrawRect+0x1a3>
    1201:	eb 01                	jmp    1204 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1203:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1204:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1207:	c9                   	leave  
    1208:	c3                   	ret    

00001209 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1209:	55                   	push   %ebp
    120a:	89 e5                	mov    %esp,%ebp
    120c:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    120f:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1213:	0f 88 8e 01 00 00    	js     13a7 <APDcCopy+0x19e>
    1219:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    121d:	0f 88 84 01 00 00    	js     13a7 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1223:	8b 55 0c             	mov    0xc(%ebp),%edx
    1226:	8b 45 20             	mov    0x20(%ebp),%eax
    1229:	01 d0                	add    %edx,%eax
    122b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    122e:	8b 55 10             	mov    0x10(%ebp),%edx
    1231:	8b 45 24             	mov    0x24(%ebp),%eax
    1234:	01 d0                	add    %edx,%eax
    1236:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1239:	8b 55 18             	mov    0x18(%ebp),%edx
    123c:	8b 45 20             	mov    0x20(%ebp),%eax
    123f:	01 d0                	add    %edx,%eax
    1241:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1244:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1247:	8b 45 24             	mov    0x24(%ebp),%eax
    124a:	01 d0                	add    %edx,%eax
    124c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    124f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1253:	0f 88 51 01 00 00    	js     13aa <APDcCopy+0x1a1>
    1259:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    125d:	0f 88 47 01 00 00    	js     13aa <APDcCopy+0x1a1>
    1263:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1267:	0f 88 3d 01 00 00    	js     13aa <APDcCopy+0x1a1>
    126d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1271:	0f 88 33 01 00 00    	js     13aa <APDcCopy+0x1a1>
    1277:	8b 45 14             	mov    0x14(%ebp),%eax
    127a:	8b 00                	mov    (%eax),%eax
    127c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    127f:	0f 8c 25 01 00 00    	jl     13aa <APDcCopy+0x1a1>
    1285:	8b 45 14             	mov    0x14(%ebp),%eax
    1288:	8b 40 04             	mov    0x4(%eax),%eax
    128b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    128e:	0f 8c 16 01 00 00    	jl     13aa <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1294:	8b 45 08             	mov    0x8(%ebp),%eax
    1297:	8b 00                	mov    (%eax),%eax
    1299:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    129c:	7f 0b                	jg     12a9 <APDcCopy+0xa0>
    129e:	8b 45 08             	mov    0x8(%ebp),%eax
    12a1:	8b 00                	mov    (%eax),%eax
    12a3:	83 e8 01             	sub    $0x1,%eax
    12a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    12a9:	8b 45 08             	mov    0x8(%ebp),%eax
    12ac:	8b 40 04             	mov    0x4(%eax),%eax
    12af:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12b2:	7f 0c                	jg     12c0 <APDcCopy+0xb7>
    12b4:	8b 45 08             	mov    0x8(%ebp),%eax
    12b7:	8b 40 04             	mov    0x4(%eax),%eax
    12ba:	83 e8 01             	sub    $0x1,%eax
    12bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12c0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12c7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12d5:	e9 bc 00 00 00       	jmp    1396 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12da:	8b 45 08             	mov    0x8(%ebp),%eax
    12dd:	8b 00                	mov    (%eax),%eax
    12df:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12e2:	8b 55 10             	mov    0x10(%ebp),%edx
    12e5:	01 ca                	add    %ecx,%edx
    12e7:	0f af d0             	imul   %eax,%edx
    12ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ed:	01 d0                	add    %edx,%eax
    12ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12f2:	8b 45 14             	mov    0x14(%ebp),%eax
    12f5:	8b 00                	mov    (%eax),%eax
    12f7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12fa:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12fd:	01 ca                	add    %ecx,%edx
    12ff:	0f af d0             	imul   %eax,%edx
    1302:	8b 45 18             	mov    0x18(%ebp),%eax
    1305:	01 d0                	add    %edx,%eax
    1307:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    130a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1311:	eb 74                	jmp    1387 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1313:	8b 45 14             	mov    0x14(%ebp),%eax
    1316:	8b 50 18             	mov    0x18(%eax),%edx
    1319:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    131c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    131f:	01 c8                	add    %ecx,%eax
    1321:	89 c1                	mov    %eax,%ecx
    1323:	89 c8                	mov    %ecx,%eax
    1325:	01 c0                	add    %eax,%eax
    1327:	01 c8                	add    %ecx,%eax
    1329:	01 d0                	add    %edx,%eax
    132b:	0f b7 10             	movzwl (%eax),%edx
    132e:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1332:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1336:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1339:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    133d:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1341:	38 c2                	cmp    %al,%dl
    1343:	75 18                	jne    135d <APDcCopy+0x154>
    1345:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1349:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    134d:	38 c2                	cmp    %al,%dl
    134f:	75 0c                	jne    135d <APDcCopy+0x154>
    1351:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1355:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1359:	38 c2                	cmp    %al,%dl
    135b:	74 26                	je     1383 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    135d:	8b 45 08             	mov    0x8(%ebp),%eax
    1360:	8b 50 18             	mov    0x18(%eax),%edx
    1363:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1366:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1369:	01 c8                	add    %ecx,%eax
    136b:	89 c1                	mov    %eax,%ecx
    136d:	89 c8                	mov    %ecx,%eax
    136f:	01 c0                	add    %eax,%eax
    1371:	01 c8                	add    %ecx,%eax
    1373:	01 d0                	add    %edx,%eax
    1375:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1379:	66 89 10             	mov    %dx,(%eax)
    137c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1380:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1383:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1387:	8b 45 fc             	mov    -0x4(%ebp),%eax
    138a:	2b 45 0c             	sub    0xc(%ebp),%eax
    138d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1390:	7d 81                	jge    1313 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1392:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1396:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1399:	2b 45 10             	sub    0x10(%ebp),%eax
    139c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    139f:	0f 8d 35 ff ff ff    	jge    12da <APDcCopy+0xd1>
    13a5:	eb 04                	jmp    13ab <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    13a7:	90                   	nop
    13a8:	eb 01                	jmp    13ab <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    13aa:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13ab:	c9                   	leave  
    13ac:	c3                   	ret    

000013ad <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13ad:	55                   	push   %ebp
    13ae:	89 e5                	mov    %esp,%ebp
    13b0:	83 ec 1c             	sub    $0x1c,%esp
    13b3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13b6:	8b 55 10             	mov    0x10(%ebp),%edx
    13b9:	8b 45 14             	mov    0x14(%ebp),%eax
    13bc:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13bf:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13c2:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13c5:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13c9:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13cc:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13d0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13d3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13d7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13da:	8b 45 08             	mov    0x8(%ebp),%eax
    13dd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13e1:	66 89 10             	mov    %dx,(%eax)
    13e4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13e8:	88 50 02             	mov    %dl,0x2(%eax)
}
    13eb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ee:	c9                   	leave  
    13ef:	c2 04 00             	ret    $0x4

000013f2 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13f2:	55                   	push   %ebp
    13f3:	89 e5                	mov    %esp,%ebp
    13f5:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13f8:	8b 45 08             	mov    0x8(%ebp),%eax
    13fb:	8b 00                	mov    (%eax),%eax
    13fd:	83 ec 08             	sub    $0x8,%esp
    1400:	8d 55 0c             	lea    0xc(%ebp),%edx
    1403:	52                   	push   %edx
    1404:	50                   	push   %eax
    1405:	e8 8d ef ff ff       	call   397 <sendMessage>
    140a:	83 c4 10             	add    $0x10,%esp
}
    140d:	90                   	nop
    140e:	c9                   	leave  
    140f:	c3                   	ret    

00001410 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1416:	83 ec 0c             	sub    $0xc,%esp
    1419:	68 90 00 00 00       	push   $0x90
    141e:	e8 3e f3 ff ff       	call   761 <malloc>
    1423:	83 c4 10             	add    $0x10,%esp
    1426:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1429:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    142d:	75 15                	jne    1444 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    142f:	83 ec 04             	sub    $0x4,%esp
    1432:	ff 75 08             	pushl  0x8(%ebp)
    1435:	68 18 21 00 00       	push   $0x2118
    143a:	6a 01                	push   $0x1
    143c:	e8 4d f0 ff ff       	call   48e <printf>
    1441:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1447:	83 c0 7c             	add    $0x7c,%eax
    144a:	83 ec 08             	sub    $0x8,%esp
    144d:	ff 75 08             	pushl  0x8(%ebp)
    1450:	50                   	push   %eax
    1451:	e8 60 ec ff ff       	call   b6 <strcpy>
    1456:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145c:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1463:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1466:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1470:	8b 40 34             	mov    0x34(%eax),%eax
    1473:	89 c2                	mov    %eax,%edx
    1475:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1478:	8b 40 38             	mov    0x38(%eax),%eax
    147b:	0f af d0             	imul   %eax,%edx
    147e:	89 d0                	mov    %edx,%eax
    1480:	01 c0                	add    %eax,%eax
    1482:	01 d0                	add    %edx,%eax
    1484:	83 ec 0c             	sub    $0xc,%esp
    1487:	50                   	push   %eax
    1488:	e8 d4 f2 ff ff       	call   761 <malloc>
    148d:	83 c4 10             	add    $0x10,%esp
    1490:	89 c2                	mov    %eax,%edx
    1492:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1495:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1498:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149b:	8b 40 4c             	mov    0x4c(%eax),%eax
    149e:	85 c0                	test   %eax,%eax
    14a0:	75 15                	jne    14b7 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    14a2:	83 ec 04             	sub    $0x4,%esp
    14a5:	ff 75 08             	pushl  0x8(%ebp)
    14a8:	68 38 21 00 00       	push   $0x2138
    14ad:	6a 01                	push   $0x1
    14af:	e8 da ef ff ff       	call   48e <printf>
    14b4:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ba:	8b 40 34             	mov    0x34(%eax),%eax
    14bd:	89 c2                	mov    %eax,%edx
    14bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c2:	8b 40 38             	mov    0x38(%eax),%eax
    14c5:	0f af d0             	imul   %eax,%edx
    14c8:	89 d0                	mov    %edx,%eax
    14ca:	01 c0                	add    %eax,%eax
    14cc:	01 c2                	add    %eax,%edx
    14ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d1:	8b 40 4c             	mov    0x4c(%eax),%eax
    14d4:	83 ec 04             	sub    $0x4,%esp
    14d7:	52                   	push   %edx
    14d8:	68 ff ff ff 00       	push   $0xffffff
    14dd:	50                   	push   %eax
    14de:	e8 69 ec ff ff       	call   14c <memset>
    14e3:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14f0:	e8 72 ee ff ff       	call   367 <getpid>
    14f5:	89 c2                	mov    %eax,%edx
    14f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fa:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1500:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1507:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150a:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1511:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1514:	8b 40 50             	mov    0x50(%eax),%eax
    1517:	89 c2                	mov    %eax,%edx
    1519:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151c:	8b 40 54             	mov    0x54(%eax),%eax
    151f:	0f af d0             	imul   %eax,%edx
    1522:	89 d0                	mov    %edx,%eax
    1524:	01 c0                	add    %eax,%eax
    1526:	01 d0                	add    %edx,%eax
    1528:	83 ec 0c             	sub    $0xc,%esp
    152b:	50                   	push   %eax
    152c:	e8 30 f2 ff ff       	call   761 <malloc>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	89 c2                	mov    %eax,%edx
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    153c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153f:	8b 40 68             	mov    0x68(%eax),%eax
    1542:	85 c0                	test   %eax,%eax
    1544:	75 15                	jne    155b <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1546:	83 ec 04             	sub    $0x4,%esp
    1549:	ff 75 08             	pushl  0x8(%ebp)
    154c:	68 5c 21 00 00       	push   $0x215c
    1551:	6a 01                	push   $0x1
    1553:	e8 36 ef ff ff       	call   48e <printf>
    1558:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    155b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155e:	8b 40 34             	mov    0x34(%eax),%eax
    1561:	89 c2                	mov    %eax,%edx
    1563:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1566:	8b 40 38             	mov    0x38(%eax),%eax
    1569:	0f af d0             	imul   %eax,%edx
    156c:	89 d0                	mov    %edx,%eax
    156e:	01 c0                	add    %eax,%eax
    1570:	01 c2                	add    %eax,%edx
    1572:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1575:	8b 40 4c             	mov    0x4c(%eax),%eax
    1578:	83 ec 04             	sub    $0x4,%esp
    157b:	52                   	push   %edx
    157c:	68 ff 00 00 00       	push   $0xff
    1581:	50                   	push   %eax
    1582:	e8 c5 eb ff ff       	call   14c <memset>
    1587:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    158a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1590:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1593:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1597:	74 35                	je     15ce <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1599:	8b 45 10             	mov    0x10(%ebp),%eax
    159c:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    15a2:	83 ec 0c             	sub    $0xc,%esp
    15a5:	50                   	push   %eax
    15a6:	e8 b6 f1 ff ff       	call   761 <malloc>
    15ab:	83 c4 10             	add    $0x10,%esp
    15ae:	89 c2                	mov    %eax,%edx
    15b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b3:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b9:	8b 55 10             	mov    0x10(%ebp),%edx
    15bc:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15c9:	e9 8d 00 00 00       	jmp    165b <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d1:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15db:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 18             	mov    0x18(%eax),%eax
    15e8:	89 c2                	mov    %eax,%edx
    15ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ed:	8b 40 1c             	mov    0x1c(%eax),%eax
    15f0:	0f af d0             	imul   %eax,%edx
    15f3:	89 d0                	mov    %edx,%eax
    15f5:	01 c0                	add    %eax,%eax
    15f7:	01 d0                	add    %edx,%eax
    15f9:	83 ec 0c             	sub    $0xc,%esp
    15fc:	50                   	push   %eax
    15fd:	e8 5f f1 ff ff       	call   761 <malloc>
    1602:	83 c4 10             	add    $0x10,%esp
    1605:	89 c2                	mov    %eax,%edx
    1607:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160a:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    160d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1610:	8b 40 30             	mov    0x30(%eax),%eax
    1613:	85 c0                	test   %eax,%eax
    1615:	75 15                	jne    162c <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1617:	83 ec 04             	sub    $0x4,%esp
    161a:	ff 75 08             	pushl  0x8(%ebp)
    161d:	68 84 21 00 00       	push   $0x2184
    1622:	6a 01                	push   $0x1
    1624:	e8 65 ee ff ff       	call   48e <printf>
    1629:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	8b 40 18             	mov    0x18(%eax),%eax
    1632:	89 c2                	mov    %eax,%edx
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	8b 40 1c             	mov    0x1c(%eax),%eax
    163a:	0f af d0             	imul   %eax,%edx
    163d:	89 d0                	mov    %edx,%eax
    163f:	01 c0                	add    %eax,%eax
    1641:	01 c2                	add    %eax,%edx
    1643:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1646:	8b 40 30             	mov    0x30(%eax),%eax
    1649:	83 ec 04             	sub    $0x4,%esp
    164c:	52                   	push   %edx
    164d:	68 ff ff ff 00       	push   $0xffffff
    1652:	50                   	push   %eax
    1653:	e8 f4 ea ff ff       	call   14c <memset>
    1658:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    165b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    165e:	c9                   	leave  
    165f:	c3                   	ret    

00001660 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1660:	55                   	push   %ebp
    1661:	89 e5                	mov    %esp,%ebp
    1663:	53                   	push   %ebx
    1664:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1667:	8b 45 0c             	mov    0xc(%ebp),%eax
    166a:	83 f8 03             	cmp    $0x3,%eax
    166d:	74 02                	je     1671 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    166f:	eb 33                	jmp    16a4 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1671:	8b 45 08             	mov    0x8(%ebp),%eax
    1674:	8b 48 08             	mov    0x8(%eax),%ecx
    1677:	8b 45 08             	mov    0x8(%ebp),%eax
    167a:	8b 50 38             	mov    0x38(%eax),%edx
    167d:	8b 45 08             	mov    0x8(%ebp),%eax
    1680:	8b 40 34             	mov    0x34(%eax),%eax
    1683:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1686:	83 c3 34             	add    $0x34,%ebx
    1689:	83 ec 0c             	sub    $0xc,%esp
    168c:	51                   	push   %ecx
    168d:	52                   	push   %edx
    168e:	50                   	push   %eax
    168f:	6a 00                	push   $0x0
    1691:	6a 00                	push   $0x0
    1693:	53                   	push   %ebx
    1694:	6a 32                	push   $0x32
    1696:	6a 00                	push   $0x0
    1698:	ff 75 08             	pushl  0x8(%ebp)
    169b:	e8 e7 ec ff ff       	call   387 <paintWindow>
    16a0:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16a3:	90                   	nop
        default: break;
            
            
    }
    return False;
    16a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16ac:	c9                   	leave  
    16ad:	c3                   	ret    

000016ae <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16ae:	55                   	push   %ebp
    16af:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16b1:	8b 45 0c             	mov    0xc(%ebp),%eax
    16b4:	8b 50 08             	mov    0x8(%eax),%edx
    16b7:	8b 45 08             	mov    0x8(%ebp),%eax
    16ba:	8b 00                	mov    (%eax),%eax
    16bc:	39 c2                	cmp    %eax,%edx
    16be:	74 07                	je     16c7 <APPreJudge+0x19>
        return False;
    16c0:	b8 00 00 00 00       	mov    $0x0,%eax
    16c5:	eb 05                	jmp    16cc <APPreJudge+0x1e>
    return True;
    16c7:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16cc:	5d                   	pop    %ebp
    16cd:	c3                   	ret    

000016ce <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16ce:	55                   	push   %ebp
    16cf:	89 e5                	mov    %esp,%ebp
    16d1:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16d4:	8b 45 08             	mov    0x8(%ebp),%eax
    16d7:	8b 55 0c             	mov    0xc(%ebp),%edx
    16da:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16dd:	83 ec 0c             	sub    $0xc,%esp
    16e0:	ff 75 08             	pushl  0x8(%ebp)
    16e3:	e8 bf ec ff ff       	call   3a7 <registWindow>
    16e8:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16eb:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16f2:	8b 45 08             	mov    0x8(%ebp),%eax
    16f5:	8b 00                	mov    (%eax),%eax
    16f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16fa:	ff 75 f4             	pushl  -0xc(%ebp)
    16fd:	ff 75 f0             	pushl  -0x10(%ebp)
    1700:	ff 75 ec             	pushl  -0x14(%ebp)
    1703:	ff 75 08             	pushl  0x8(%ebp)
    1706:	e8 e7 fc ff ff       	call   13f2 <APSendMessage>
    170b:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    170e:	83 ec 0c             	sub    $0xc,%esp
    1711:	ff 75 08             	pushl  0x8(%ebp)
    1714:	e8 86 ec ff ff       	call   39f <getMessage>
    1719:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    171c:	8b 45 08             	mov    0x8(%ebp),%eax
    171f:	83 c0 6c             	add    $0x6c,%eax
    1722:	83 ec 08             	sub    $0x8,%esp
    1725:	50                   	push   %eax
    1726:	ff 75 08             	pushl  0x8(%ebp)
    1729:	e8 80 ff ff ff       	call   16ae <APPreJudge>
    172e:	83 c4 10             	add    $0x10,%esp
    1731:	84 c0                	test   %al,%al
    1733:	74 1b                	je     1750 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1735:	8b 45 08             	mov    0x8(%ebp),%eax
    1738:	ff 70 74             	pushl  0x74(%eax)
    173b:	ff 70 70             	pushl  0x70(%eax)
    173e:	ff 70 6c             	pushl  0x6c(%eax)
    1741:	ff 75 08             	pushl  0x8(%ebp)
    1744:	8b 45 0c             	mov    0xc(%ebp),%eax
    1747:	ff d0                	call   *%eax
    1749:	83 c4 10             	add    $0x10,%esp
    174c:	84 c0                	test   %al,%al
    174e:	75 0c                	jne    175c <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1750:	8b 45 08             	mov    0x8(%ebp),%eax
    1753:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    175a:	eb b2                	jmp    170e <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    175c:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    175d:	90                   	nop
    175e:	c9                   	leave  
    175f:	c3                   	ret    

00001760 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1760:	55                   	push   %ebp
    1761:	89 e5                	mov    %esp,%ebp
    1763:	57                   	push   %edi
    1764:	56                   	push   %esi
    1765:	53                   	push   %ebx
    1766:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1769:	a1 c0 27 00 00       	mov    0x27c0,%eax
    176e:	85 c0                	test   %eax,%eax
    1770:	0f 85 2c 02 00 00    	jne    19a2 <APGridPaint+0x242>
    {
        iconReady = 1;
    1776:	c7 05 c0 27 00 00 01 	movl   $0x1,0x27c0
    177d:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1780:	8d 45 98             	lea    -0x68(%ebp),%eax
    1783:	83 ec 08             	sub    $0x8,%esp
    1786:	68 ab 21 00 00       	push   $0x21ab
    178b:	50                   	push   %eax
    178c:	e8 83 f1 ff ff       	call   914 <APLoadBitmap>
    1791:	83 c4 0c             	add    $0xc,%esp
    1794:	8b 45 98             	mov    -0x68(%ebp),%eax
    1797:	a3 e4 27 00 00       	mov    %eax,0x27e4
    179c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    179f:	a3 e8 27 00 00       	mov    %eax,0x27e8
    17a4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17a7:	a3 ec 27 00 00       	mov    %eax,0x27ec
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17ac:	83 ec 04             	sub    $0x4,%esp
    17af:	ff 35 ec 27 00 00    	pushl  0x27ec
    17b5:	ff 35 e8 27 00 00    	pushl  0x27e8
    17bb:	ff 35 e4 27 00 00    	pushl  0x27e4
    17c1:	e8 88 f3 ff ff       	call   b4e <APCreateCompatibleDCFromBitmap>
    17c6:	83 c4 10             	add    $0x10,%esp
    17c9:	a3 f0 27 00 00       	mov    %eax,0x27f0
        grid_river = APLoadBitmap ("grid_river.bmp");
    17ce:	8d 45 98             	lea    -0x68(%ebp),%eax
    17d1:	83 ec 08             	sub    $0x8,%esp
    17d4:	68 b9 21 00 00       	push   $0x21b9
    17d9:	50                   	push   %eax
    17da:	e8 35 f1 ff ff       	call   914 <APLoadBitmap>
    17df:	83 c4 0c             	add    $0xc,%esp
    17e2:	8b 45 98             	mov    -0x68(%ebp),%eax
    17e5:	a3 20 28 00 00       	mov    %eax,0x2820
    17ea:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17ed:	a3 24 28 00 00       	mov    %eax,0x2824
    17f2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17f5:	a3 28 28 00 00       	mov    %eax,0x2828
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17fa:	83 ec 04             	sub    $0x4,%esp
    17fd:	ff 35 28 28 00 00    	pushl  0x2828
    1803:	ff 35 24 28 00 00    	pushl  0x2824
    1809:	ff 35 20 28 00 00    	pushl  0x2820
    180f:	e8 3a f3 ff ff       	call   b4e <APCreateCompatibleDCFromBitmap>
    1814:	83 c4 10             	add    $0x10,%esp
    1817:	a3 10 28 00 00       	mov    %eax,0x2810
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    181c:	8d 45 98             	lea    -0x68(%ebp),%eax
    181f:	83 ec 08             	sub    $0x8,%esp
    1822:	68 c8 21 00 00       	push   $0x21c8
    1827:	50                   	push   %eax
    1828:	e8 e7 f0 ff ff       	call   914 <APLoadBitmap>
    182d:	83 c4 0c             	add    $0xc,%esp
    1830:	8b 45 98             	mov    -0x68(%ebp),%eax
    1833:	a3 14 28 00 00       	mov    %eax,0x2814
    1838:	8b 45 9c             	mov    -0x64(%ebp),%eax
    183b:	a3 18 28 00 00       	mov    %eax,0x2818
    1840:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1843:	a3 1c 28 00 00       	mov    %eax,0x281c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1848:	83 ec 04             	sub    $0x4,%esp
    184b:	ff 35 1c 28 00 00    	pushl  0x281c
    1851:	ff 35 18 28 00 00    	pushl  0x2818
    1857:	ff 35 14 28 00 00    	pushl  0x2814
    185d:	e8 ec f2 ff ff       	call   b4e <APCreateCompatibleDCFromBitmap>
    1862:	83 c4 10             	add    $0x10,%esp
    1865:	a3 c4 27 00 00       	mov    %eax,0x27c4
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    186a:	8d 45 98             	lea    -0x68(%ebp),%eax
    186d:	83 ec 08             	sub    $0x8,%esp
    1870:	68 d7 21 00 00       	push   $0x21d7
    1875:	50                   	push   %eax
    1876:	e8 99 f0 ff ff       	call   914 <APLoadBitmap>
    187b:	83 c4 0c             	add    $0xc,%esp
    187e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1881:	a3 f8 27 00 00       	mov    %eax,0x27f8
    1886:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1889:	a3 fc 27 00 00       	mov    %eax,0x27fc
    188e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1891:	a3 00 28 00 00       	mov    %eax,0x2800
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1896:	83 ec 04             	sub    $0x4,%esp
    1899:	ff 35 00 28 00 00    	pushl  0x2800
    189f:	ff 35 fc 27 00 00    	pushl  0x27fc
    18a5:	ff 35 f8 27 00 00    	pushl  0x27f8
    18ab:	e8 9e f2 ff ff       	call   b4e <APCreateCompatibleDCFromBitmap>
    18b0:	83 c4 10             	add    $0x10,%esp
    18b3:	a3 2c 28 00 00       	mov    %eax,0x282c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    18b8:	8d 45 98             	lea    -0x68(%ebp),%eax
    18bb:	83 ec 08             	sub    $0x8,%esp
    18be:	68 e5 21 00 00       	push   $0x21e5
    18c3:	50                   	push   %eax
    18c4:	e8 4b f0 ff ff       	call   914 <APLoadBitmap>
    18c9:	83 c4 0c             	add    $0xc,%esp
    18cc:	8b 45 98             	mov    -0x68(%ebp),%eax
    18cf:	a3 d4 27 00 00       	mov    %eax,0x27d4
    18d4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d7:	a3 d8 27 00 00       	mov    %eax,0x27d8
    18dc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18df:	a3 dc 27 00 00       	mov    %eax,0x27dc
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18e4:	83 ec 04             	sub    $0x4,%esp
    18e7:	ff 35 dc 27 00 00    	pushl  0x27dc
    18ed:	ff 35 d8 27 00 00    	pushl  0x27d8
    18f3:	ff 35 d4 27 00 00    	pushl  0x27d4
    18f9:	e8 50 f2 ff ff       	call   b4e <APCreateCompatibleDCFromBitmap>
    18fe:	83 c4 10             	add    $0x10,%esp
    1901:	a3 f4 27 00 00       	mov    %eax,0x27f4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1906:	8d 45 98             	lea    -0x68(%ebp),%eax
    1909:	83 ec 08             	sub    $0x8,%esp
    190c:	68 f5 21 00 00       	push   $0x21f5
    1911:	50                   	push   %eax
    1912:	e8 fd ef ff ff       	call   914 <APLoadBitmap>
    1917:	83 c4 0c             	add    $0xc,%esp
    191a:	8b 45 98             	mov    -0x68(%ebp),%eax
    191d:	a3 c8 27 00 00       	mov    %eax,0x27c8
    1922:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1925:	a3 cc 27 00 00       	mov    %eax,0x27cc
    192a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    192d:	a3 d0 27 00 00       	mov    %eax,0x27d0
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1932:	83 ec 04             	sub    $0x4,%esp
    1935:	ff 35 d0 27 00 00    	pushl  0x27d0
    193b:	ff 35 cc 27 00 00    	pushl  0x27cc
    1941:	ff 35 c8 27 00 00    	pushl  0x27c8
    1947:	e8 02 f2 ff ff       	call   b4e <APCreateCompatibleDCFromBitmap>
    194c:	83 c4 10             	add    $0x10,%esp
    194f:	a3 e0 27 00 00       	mov    %eax,0x27e0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1954:	8d 45 98             	lea    -0x68(%ebp),%eax
    1957:	83 ec 08             	sub    $0x8,%esp
    195a:	68 07 22 00 00       	push   $0x2207
    195f:	50                   	push   %eax
    1960:	e8 af ef ff ff       	call   914 <APLoadBitmap>
    1965:	83 c4 0c             	add    $0xc,%esp
    1968:	8b 45 98             	mov    -0x68(%ebp),%eax
    196b:	a3 04 28 00 00       	mov    %eax,0x2804
    1970:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1973:	a3 08 28 00 00       	mov    %eax,0x2808
    1978:	8b 45 a0             	mov    -0x60(%ebp),%eax
    197b:	a3 0c 28 00 00       	mov    %eax,0x280c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1980:	83 ec 04             	sub    $0x4,%esp
    1983:	ff 35 0c 28 00 00    	pushl  0x280c
    1989:	ff 35 08 28 00 00    	pushl  0x2808
    198f:	ff 35 04 28 00 00    	pushl  0x2804
    1995:	e8 b4 f1 ff ff       	call   b4e <APCreateCompatibleDCFromBitmap>
    199a:	83 c4 10             	add    $0x10,%esp
    199d:	a3 30 28 00 00       	mov    %eax,0x2830
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19a2:	8b 45 08             	mov    0x8(%ebp),%eax
    19a5:	8b 40 08             	mov    0x8(%eax),%eax
    19a8:	85 c0                	test   %eax,%eax
    19aa:	75 17                	jne    19c3 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19ac:	83 ec 08             	sub    $0x8,%esp
    19af:	68 18 22 00 00       	push   $0x2218
    19b4:	6a 01                	push   $0x1
    19b6:	e8 d3 ea ff ff       	call   48e <printf>
    19bb:	83 c4 10             	add    $0x10,%esp
        return;
    19be:	e9 f2 03 00 00       	jmp    1db5 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	8b 40 10             	mov    0x10(%eax),%eax
    19c9:	85 c0                	test   %eax,%eax
    19cb:	7e 10                	jle    19dd <APGridPaint+0x27d>
    19cd:	8b 45 08             	mov    0x8(%ebp),%eax
    19d0:	8b 50 14             	mov    0x14(%eax),%edx
    19d3:	8b 45 08             	mov    0x8(%ebp),%eax
    19d6:	8b 40 10             	mov    0x10(%eax),%eax
    19d9:	39 c2                	cmp    %eax,%edx
    19db:	7c 17                	jl     19f4 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19dd:	83 ec 08             	sub    $0x8,%esp
    19e0:	68 3e 22 00 00       	push   $0x223e
    19e5:	6a 01                	push   $0x1
    19e7:	e8 a2 ea ff ff       	call   48e <printf>
    19ec:	83 c4 10             	add    $0x10,%esp
        return;
    19ef:	e9 c1 03 00 00       	jmp    1db5 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19f4:	8b 45 08             	mov    0x8(%ebp),%eax
    19f7:	8b 40 14             	mov    0x14(%eax),%eax
    19fa:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a00:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a03:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a06:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a09:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a10:	e9 96 03 00 00       	jmp    1dab <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a15:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a1c:	e9 7c 03 00 00       	jmp    1d9d <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a24:	c1 e0 04             	shl    $0x4,%eax
    1a27:	89 c2                	mov    %eax,%edx
    1a29:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a2c:	01 c2                	add    %eax,%edx
    1a2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a31:	01 d0                	add    %edx,%eax
    1a33:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a36:	8b 45 08             	mov    0x8(%ebp),%eax
    1a39:	8b 40 0c             	mov    0xc(%eax),%eax
    1a3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a3f:	c1 e2 02             	shl    $0x2,%edx
    1a42:	01 d0                	add    %edx,%eax
    1a44:	8b 00                	mov    (%eax),%eax
    1a46:	83 f8 07             	cmp    $0x7,%eax
    1a49:	0f 87 49 03 00 00    	ja     1d98 <APGridPaint+0x638>
    1a4f:	8b 04 85 54 22 00 00 	mov    0x2254(,%eax,4),%eax
    1a56:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a58:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a5b:	6a 0c                	push   $0xc
    1a5d:	6a 0c                	push   $0xc
    1a5f:	6a 0c                	push   $0xc
    1a61:	50                   	push   %eax
    1a62:	e8 46 f9 ff ff       	call   13ad <RGB>
    1a67:	83 c4 0c             	add    $0xc,%esp
    1a6a:	8b 1d f0 27 00 00    	mov    0x27f0,%ebx
    1a70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a73:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a76:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a79:	6b c0 32             	imul   $0x32,%eax,%eax
    1a7c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a82:	8d 78 34             	lea    0x34(%eax),%edi
    1a85:	83 ec 0c             	sub    $0xc,%esp
    1a88:	83 ec 04             	sub    $0x4,%esp
    1a8b:	89 e0                	mov    %esp,%eax
    1a8d:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a91:	66 89 30             	mov    %si,(%eax)
    1a94:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a98:	88 50 02             	mov    %dl,0x2(%eax)
    1a9b:	6a 32                	push   $0x32
    1a9d:	6a 32                	push   $0x32
    1a9f:	6a 00                	push   $0x0
    1aa1:	6a 00                	push   $0x0
    1aa3:	53                   	push   %ebx
    1aa4:	51                   	push   %ecx
    1aa5:	ff 75 94             	pushl  -0x6c(%ebp)
    1aa8:	57                   	push   %edi
    1aa9:	e8 5b f7 ff ff       	call   1209 <APDcCopy>
    1aae:	83 c4 30             	add    $0x30,%esp
                    break;
    1ab1:	e9 e3 02 00 00       	jmp    1d99 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1ab6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ab9:	6a 69                	push   $0x69
    1abb:	6a 69                	push   $0x69
    1abd:	6a 69                	push   $0x69
    1abf:	50                   	push   %eax
    1ac0:	e8 e8 f8 ff ff       	call   13ad <RGB>
    1ac5:	83 c4 0c             	add    $0xc,%esp
    1ac8:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1acc:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ad0:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ad4:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1ad7:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ade:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ae1:	6a 69                	push   $0x69
    1ae3:	6a 69                	push   $0x69
    1ae5:	6a 69                	push   $0x69
    1ae7:	50                   	push   %eax
    1ae8:	e8 c0 f8 ff ff       	call   13ad <RGB>
    1aed:	83 c4 0c             	add    $0xc,%esp
    1af0:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1af4:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1af8:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1afc:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1aff:	8b 45 08             	mov    0x8(%ebp),%eax
    1b02:	8d 50 34             	lea    0x34(%eax),%edx
    1b05:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b08:	ff 75 bc             	pushl  -0x44(%ebp)
    1b0b:	ff 75 b8             	pushl  -0x48(%ebp)
    1b0e:	52                   	push   %edx
    1b0f:	50                   	push   %eax
    1b10:	e8 ce f0 ff ff       	call   be3 <APSetPen>
    1b15:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b18:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1b:	8d 58 34             	lea    0x34(%eax),%ebx
    1b1e:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b21:	83 ec 04             	sub    $0x4,%esp
    1b24:	83 ec 04             	sub    $0x4,%esp
    1b27:	89 e0                	mov    %esp,%eax
    1b29:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b2d:	66 89 08             	mov    %cx,(%eax)
    1b30:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b34:	88 48 02             	mov    %cl,0x2(%eax)
    1b37:	53                   	push   %ebx
    1b38:	52                   	push   %edx
    1b39:	e8 de f0 ff ff       	call   c1c <APSetBrush>
    1b3e:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b44:	6b d0 32             	imul   $0x32,%eax,%edx
    1b47:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b4a:	6b c0 32             	imul   $0x32,%eax,%eax
    1b4d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b50:	83 c1 34             	add    $0x34,%ecx
    1b53:	83 ec 0c             	sub    $0xc,%esp
    1b56:	6a 32                	push   $0x32
    1b58:	6a 32                	push   $0x32
    1b5a:	52                   	push   %edx
    1b5b:	50                   	push   %eax
    1b5c:	51                   	push   %ecx
    1b5d:	e8 a2 f4 ff ff       	call   1004 <APDrawRect>
    1b62:	83 c4 20             	add    $0x20,%esp
                    break;
    1b65:	e9 2f 02 00 00       	jmp    1d99 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b6a:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b6d:	6a 0c                	push   $0xc
    1b6f:	6a 0c                	push   $0xc
    1b71:	6a 0c                	push   $0xc
    1b73:	50                   	push   %eax
    1b74:	e8 34 f8 ff ff       	call   13ad <RGB>
    1b79:	83 c4 0c             	add    $0xc,%esp
    1b7c:	8b 1d 30 28 00 00    	mov    0x2830,%ebx
    1b82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b85:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b88:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b8b:	6b c0 32             	imul   $0x32,%eax,%eax
    1b8e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b91:	8b 45 08             	mov    0x8(%ebp),%eax
    1b94:	8d 78 34             	lea    0x34(%eax),%edi
    1b97:	83 ec 0c             	sub    $0xc,%esp
    1b9a:	83 ec 04             	sub    $0x4,%esp
    1b9d:	89 e0                	mov    %esp,%eax
    1b9f:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1ba3:	66 89 30             	mov    %si,(%eax)
    1ba6:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1baa:	88 50 02             	mov    %dl,0x2(%eax)
    1bad:	6a 32                	push   $0x32
    1baf:	6a 32                	push   $0x32
    1bb1:	6a 00                	push   $0x0
    1bb3:	6a 00                	push   $0x0
    1bb5:	53                   	push   %ebx
    1bb6:	51                   	push   %ecx
    1bb7:	ff 75 94             	pushl  -0x6c(%ebp)
    1bba:	57                   	push   %edi
    1bbb:	e8 49 f6 ff ff       	call   1209 <APDcCopy>
    1bc0:	83 c4 30             	add    $0x30,%esp
                    break;
    1bc3:	e9 d1 01 00 00       	jmp    1d99 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bc8:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1bcb:	6a 0c                	push   $0xc
    1bcd:	6a 0c                	push   $0xc
    1bcf:	6a 0c                	push   $0xc
    1bd1:	50                   	push   %eax
    1bd2:	e8 d6 f7 ff ff       	call   13ad <RGB>
    1bd7:	83 c4 0c             	add    $0xc,%esp
    1bda:	8b 1d 10 28 00 00    	mov    0x2810,%ebx
    1be0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1be3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1be6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be9:	6b c0 32             	imul   $0x32,%eax,%eax
    1bec:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bef:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf2:	8d 78 34             	lea    0x34(%eax),%edi
    1bf5:	83 ec 0c             	sub    $0xc,%esp
    1bf8:	83 ec 04             	sub    $0x4,%esp
    1bfb:	89 e0                	mov    %esp,%eax
    1bfd:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c01:	66 89 30             	mov    %si,(%eax)
    1c04:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c08:	88 50 02             	mov    %dl,0x2(%eax)
    1c0b:	6a 32                	push   $0x32
    1c0d:	6a 32                	push   $0x32
    1c0f:	6a 00                	push   $0x0
    1c11:	6a 00                	push   $0x0
    1c13:	53                   	push   %ebx
    1c14:	51                   	push   %ecx
    1c15:	ff 75 94             	pushl  -0x6c(%ebp)
    1c18:	57                   	push   %edi
    1c19:	e8 eb f5 ff ff       	call   1209 <APDcCopy>
    1c1e:	83 c4 30             	add    $0x30,%esp
                    break;
    1c21:	e9 73 01 00 00       	jmp    1d99 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c26:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c29:	6a 0c                	push   $0xc
    1c2b:	6a 0c                	push   $0xc
    1c2d:	6a 0c                	push   $0xc
    1c2f:	50                   	push   %eax
    1c30:	e8 78 f7 ff ff       	call   13ad <RGB>
    1c35:	83 c4 0c             	add    $0xc,%esp
    1c38:	8b 1d f4 27 00 00    	mov    0x27f4,%ebx
    1c3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c41:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c44:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c47:	6b c0 32             	imul   $0x32,%eax,%eax
    1c4a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c50:	8d 78 34             	lea    0x34(%eax),%edi
    1c53:	83 ec 0c             	sub    $0xc,%esp
    1c56:	83 ec 04             	sub    $0x4,%esp
    1c59:	89 e0                	mov    %esp,%eax
    1c5b:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c5f:	66 89 30             	mov    %si,(%eax)
    1c62:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c66:	88 50 02             	mov    %dl,0x2(%eax)
    1c69:	6a 32                	push   $0x32
    1c6b:	6a 32                	push   $0x32
    1c6d:	6a 00                	push   $0x0
    1c6f:	6a 00                	push   $0x0
    1c71:	53                   	push   %ebx
    1c72:	51                   	push   %ecx
    1c73:	ff 75 94             	pushl  -0x6c(%ebp)
    1c76:	57                   	push   %edi
    1c77:	e8 8d f5 ff ff       	call   1209 <APDcCopy>
    1c7c:	83 c4 30             	add    $0x30,%esp
                    break;
    1c7f:	e9 15 01 00 00       	jmp    1d99 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c84:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c87:	6a 0c                	push   $0xc
    1c89:	6a 0c                	push   $0xc
    1c8b:	6a 0c                	push   $0xc
    1c8d:	50                   	push   %eax
    1c8e:	e8 1a f7 ff ff       	call   13ad <RGB>
    1c93:	83 c4 0c             	add    $0xc,%esp
    1c96:	8b 1d 2c 28 00 00    	mov    0x282c,%ebx
    1c9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c9f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ca2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ca5:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cab:	8b 45 08             	mov    0x8(%ebp),%eax
    1cae:	8d 78 34             	lea    0x34(%eax),%edi
    1cb1:	83 ec 0c             	sub    $0xc,%esp
    1cb4:	83 ec 04             	sub    $0x4,%esp
    1cb7:	89 e0                	mov    %esp,%eax
    1cb9:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1cbd:	66 89 30             	mov    %si,(%eax)
    1cc0:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1cc4:	88 50 02             	mov    %dl,0x2(%eax)
    1cc7:	6a 32                	push   $0x32
    1cc9:	6a 32                	push   $0x32
    1ccb:	6a 00                	push   $0x0
    1ccd:	6a 00                	push   $0x0
    1ccf:	53                   	push   %ebx
    1cd0:	51                   	push   %ecx
    1cd1:	ff 75 94             	pushl  -0x6c(%ebp)
    1cd4:	57                   	push   %edi
    1cd5:	e8 2f f5 ff ff       	call   1209 <APDcCopy>
    1cda:	83 c4 30             	add    $0x30,%esp
                    break;
    1cdd:	e9 b7 00 00 00       	jmp    1d99 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ce2:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1ce5:	6a 0c                	push   $0xc
    1ce7:	6a 0c                	push   $0xc
    1ce9:	6a 0c                	push   $0xc
    1ceb:	50                   	push   %eax
    1cec:	e8 bc f6 ff ff       	call   13ad <RGB>
    1cf1:	83 c4 0c             	add    $0xc,%esp
    1cf4:	8b 1d c4 27 00 00    	mov    0x27c4,%ebx
    1cfa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cfd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d00:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d03:	6b c0 32             	imul   $0x32,%eax,%eax
    1d06:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d09:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0c:	8d 78 34             	lea    0x34(%eax),%edi
    1d0f:	83 ec 0c             	sub    $0xc,%esp
    1d12:	83 ec 04             	sub    $0x4,%esp
    1d15:	89 e0                	mov    %esp,%eax
    1d17:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d1b:	66 89 30             	mov    %si,(%eax)
    1d1e:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d22:	88 50 02             	mov    %dl,0x2(%eax)
    1d25:	6a 32                	push   $0x32
    1d27:	6a 32                	push   $0x32
    1d29:	6a 00                	push   $0x0
    1d2b:	6a 00                	push   $0x0
    1d2d:	53                   	push   %ebx
    1d2e:	51                   	push   %ecx
    1d2f:	ff 75 94             	pushl  -0x6c(%ebp)
    1d32:	57                   	push   %edi
    1d33:	e8 d1 f4 ff ff       	call   1209 <APDcCopy>
    1d38:	83 c4 30             	add    $0x30,%esp
                    break;
    1d3b:	eb 5c                	jmp    1d99 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d3d:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d40:	6a 0c                	push   $0xc
    1d42:	6a 0c                	push   $0xc
    1d44:	6a 0c                	push   $0xc
    1d46:	50                   	push   %eax
    1d47:	e8 61 f6 ff ff       	call   13ad <RGB>
    1d4c:	83 c4 0c             	add    $0xc,%esp
    1d4f:	8b 1d e0 27 00 00    	mov    0x27e0,%ebx
    1d55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d58:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5e:	6b c0 32             	imul   $0x32,%eax,%eax
    1d61:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d64:	8b 45 08             	mov    0x8(%ebp),%eax
    1d67:	8d 78 34             	lea    0x34(%eax),%edi
    1d6a:	83 ec 0c             	sub    $0xc,%esp
    1d6d:	83 ec 04             	sub    $0x4,%esp
    1d70:	89 e0                	mov    %esp,%eax
    1d72:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d76:	66 89 30             	mov    %si,(%eax)
    1d79:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d7d:	88 50 02             	mov    %dl,0x2(%eax)
    1d80:	6a 32                	push   $0x32
    1d82:	6a 32                	push   $0x32
    1d84:	6a 00                	push   $0x0
    1d86:	6a 00                	push   $0x0
    1d88:	53                   	push   %ebx
    1d89:	51                   	push   %ecx
    1d8a:	ff 75 94             	pushl  -0x6c(%ebp)
    1d8d:	57                   	push   %edi
    1d8e:	e8 76 f4 ff ff       	call   1209 <APDcCopy>
    1d93:	83 c4 30             	add    $0x30,%esp
                    break;
    1d96:	eb 01                	jmp    1d99 <APGridPaint+0x639>
                default: break;
    1d98:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d99:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d9d:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1da1:	0f 8e 7a fc ff ff    	jle    1a21 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1da7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1dab:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1daf:	0f 8e 60 fc ff ff    	jle    1a15 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1db5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1db8:	5b                   	pop    %ebx
    1db9:	5e                   	pop    %esi
    1dba:	5f                   	pop    %edi
    1dbb:	5d                   	pop    %ebp
    1dbc:	c3                   	ret    

00001dbd <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1dbd:	55                   	push   %ebp
    1dbe:	89 e5                	mov    %esp,%ebp
    1dc0:	53                   	push   %ebx
    1dc1:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1dc4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1dcb:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1dcf:	74 17                	je     1de8 <sprintint+0x2b>
    1dd1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1dd5:	79 11                	jns    1de8 <sprintint+0x2b>
        neg = 1;
    1dd7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1dde:	8b 45 10             	mov    0x10(%ebp),%eax
    1de1:	f7 d8                	neg    %eax
    1de3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1de6:	eb 06                	jmp    1dee <sprintint+0x31>
    } else {
        x = xx;
    1de8:	8b 45 10             	mov    0x10(%ebp),%eax
    1deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1dee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1df5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1df8:	8d 41 01             	lea    0x1(%ecx),%eax
    1dfb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1dfe:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e01:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e04:	ba 00 00 00 00       	mov    $0x0,%edx
    1e09:	f7 f3                	div    %ebx
    1e0b:	89 d0                	mov    %edx,%eax
    1e0d:	0f b6 80 a0 27 00 00 	movzbl 0x27a0(%eax),%eax
    1e14:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e18:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e1e:	ba 00 00 00 00       	mov    $0x0,%edx
    1e23:	f7 f3                	div    %ebx
    1e25:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e2c:	75 c7                	jne    1df5 <sprintint+0x38>
    if(neg)
    1e2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e32:	74 0e                	je     1e42 <sprintint+0x85>
        buf[i++] = '-';
    1e34:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e37:	8d 50 01             	lea    0x1(%eax),%edx
    1e3a:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e3d:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e42:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e45:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e48:	eb 1b                	jmp    1e65 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e4d:	8b 00                	mov    (%eax),%eax
    1e4f:	8d 48 01             	lea    0x1(%eax),%ecx
    1e52:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e55:	89 0a                	mov    %ecx,(%edx)
    1e57:	89 c2                	mov    %eax,%edx
    1e59:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5c:	01 d0                	add    %edx,%eax
    1e5e:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e61:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e65:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e69:	7f df                	jg     1e4a <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e6b:	eb 21                	jmp    1e8e <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e70:	8b 00                	mov    (%eax),%eax
    1e72:	8d 48 01             	lea    0x1(%eax),%ecx
    1e75:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e78:	89 0a                	mov    %ecx,(%edx)
    1e7a:	89 c2                	mov    %eax,%edx
    1e7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7f:	01 c2                	add    %eax,%edx
    1e81:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e84:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e87:	01 c8                	add    %ecx,%eax
    1e89:	0f b6 00             	movzbl (%eax),%eax
    1e8c:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e8e:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e92:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e96:	79 d5                	jns    1e6d <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e98:	90                   	nop
    1e99:	83 c4 20             	add    $0x20,%esp
    1e9c:	5b                   	pop    %ebx
    1e9d:	5d                   	pop    %ebp
    1e9e:	c3                   	ret    

00001e9f <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e9f:	55                   	push   %ebp
    1ea0:	89 e5                	mov    %esp,%ebp
    1ea2:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1ea5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1eac:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1eb3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1eba:	8d 45 0c             	lea    0xc(%ebp),%eax
    1ebd:	83 c0 04             	add    $0x4,%eax
    1ec0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1ec3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1eca:	e9 d9 01 00 00       	jmp    20a8 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ecf:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ed2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ed5:	01 d0                	add    %edx,%eax
    1ed7:	0f b6 00             	movzbl (%eax),%eax
    1eda:	0f be c0             	movsbl %al,%eax
    1edd:	25 ff 00 00 00       	and    $0xff,%eax
    1ee2:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1ee5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ee9:	75 2c                	jne    1f17 <sprintf+0x78>
            if(c == '%'){
    1eeb:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1eef:	75 0c                	jne    1efd <sprintf+0x5e>
                state = '%';
    1ef1:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1ef8:	e9 a7 01 00 00       	jmp    20a4 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1efd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f00:	8d 50 01             	lea    0x1(%eax),%edx
    1f03:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f06:	89 c2                	mov    %eax,%edx
    1f08:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0b:	01 d0                	add    %edx,%eax
    1f0d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f10:	88 10                	mov    %dl,(%eax)
    1f12:	e9 8d 01 00 00       	jmp    20a4 <sprintf+0x205>
            }
        } else if(state == '%'){
    1f17:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f1b:	0f 85 83 01 00 00    	jne    20a4 <sprintf+0x205>
            if(c == 'd'){
    1f21:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f25:	75 4c                	jne    1f73 <sprintf+0xd4>
                buf[bi] = '\0';
    1f27:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f2d:	01 d0                	add    %edx,%eax
    1f2f:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f32:	83 ec 0c             	sub    $0xc,%esp
    1f35:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f38:	50                   	push   %eax
    1f39:	e8 17 e3 ff ff       	call   255 <atoi>
    1f3e:	83 c4 10             	add    $0x10,%esp
    1f41:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f44:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f4e:	8b 00                	mov    (%eax),%eax
    1f50:	83 ec 08             	sub    $0x8,%esp
    1f53:	ff 75 d8             	pushl  -0x28(%ebp)
    1f56:	6a 01                	push   $0x1
    1f58:	6a 0a                	push   $0xa
    1f5a:	50                   	push   %eax
    1f5b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f5e:	50                   	push   %eax
    1f5f:	ff 75 08             	pushl  0x8(%ebp)
    1f62:	e8 56 fe ff ff       	call   1dbd <sprintint>
    1f67:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f6a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f6e:	e9 2a 01 00 00       	jmp    209d <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f73:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f77:	74 06                	je     1f7f <sprintf+0xe0>
    1f79:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f7d:	75 4c                	jne    1fcb <sprintf+0x12c>
                buf[bi] = '\0';
    1f7f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f82:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f85:	01 d0                	add    %edx,%eax
    1f87:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f8a:	83 ec 0c             	sub    $0xc,%esp
    1f8d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f90:	50                   	push   %eax
    1f91:	e8 bf e2 ff ff       	call   255 <atoi>
    1f96:	83 c4 10             	add    $0x10,%esp
    1f99:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f9c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1fa3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fa6:	8b 00                	mov    (%eax),%eax
    1fa8:	83 ec 08             	sub    $0x8,%esp
    1fab:	ff 75 dc             	pushl  -0x24(%ebp)
    1fae:	6a 00                	push   $0x0
    1fb0:	6a 10                	push   $0x10
    1fb2:	50                   	push   %eax
    1fb3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fb6:	50                   	push   %eax
    1fb7:	ff 75 08             	pushl  0x8(%ebp)
    1fba:	e8 fe fd ff ff       	call   1dbd <sprintint>
    1fbf:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fc2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1fc6:	e9 d2 00 00 00       	jmp    209d <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1fcb:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1fcf:	75 46                	jne    2017 <sprintf+0x178>
                s = (char*)*ap;
    1fd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fd4:	8b 00                	mov    (%eax),%eax
    1fd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1fd9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1fdd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fe1:	75 25                	jne    2008 <sprintf+0x169>
                    s = "(null)";
    1fe3:	c7 45 f4 74 22 00 00 	movl   $0x2274,-0xc(%ebp)
                while(*s != 0){
    1fea:	eb 1c                	jmp    2008 <sprintf+0x169>
                    dst[j++] = *s;
    1fec:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fef:	8d 50 01             	lea    0x1(%eax),%edx
    1ff2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ff5:	89 c2                	mov    %eax,%edx
    1ff7:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffa:	01 c2                	add    %eax,%edx
    1ffc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fff:	0f b6 00             	movzbl (%eax),%eax
    2002:	88 02                	mov    %al,(%edx)
                    s++;
    2004:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2008:	8b 45 f4             	mov    -0xc(%ebp),%eax
    200b:	0f b6 00             	movzbl (%eax),%eax
    200e:	84 c0                	test   %al,%al
    2010:	75 da                	jne    1fec <sprintf+0x14d>
    2012:	e9 86 00 00 00       	jmp    209d <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2017:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    201b:	75 1d                	jne    203a <sprintf+0x19b>
                dst[j++] = *ap;
    201d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2020:	8d 50 01             	lea    0x1(%eax),%edx
    2023:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2026:	89 c2                	mov    %eax,%edx
    2028:	8b 45 08             	mov    0x8(%ebp),%eax
    202b:	01 c2                	add    %eax,%edx
    202d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2030:	8b 00                	mov    (%eax),%eax
    2032:	88 02                	mov    %al,(%edx)
                ap++;
    2034:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2038:	eb 63                	jmp    209d <sprintf+0x1fe>
            } else if(c == '%'){
    203a:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    203e:	75 17                	jne    2057 <sprintf+0x1b8>
                dst[j++] = c;
    2040:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2043:	8d 50 01             	lea    0x1(%eax),%edx
    2046:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2049:	89 c2                	mov    %eax,%edx
    204b:	8b 45 08             	mov    0x8(%ebp),%eax
    204e:	01 d0                	add    %edx,%eax
    2050:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2053:	88 10                	mov    %dl,(%eax)
    2055:	eb 46                	jmp    209d <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2057:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    205b:	7e 18                	jle    2075 <sprintf+0x1d6>
    205d:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2061:	7f 12                	jg     2075 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2063:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2066:	8d 50 01             	lea    0x1(%eax),%edx
    2069:	89 55 f0             	mov    %edx,-0x10(%ebp)
    206c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    206f:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2073:	eb 2f                	jmp    20a4 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2075:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2078:	8d 50 01             	lea    0x1(%eax),%edx
    207b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    207e:	89 c2                	mov    %eax,%edx
    2080:	8b 45 08             	mov    0x8(%ebp),%eax
    2083:	01 d0                	add    %edx,%eax
    2085:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2088:	8b 45 c8             	mov    -0x38(%ebp),%eax
    208b:	8d 50 01             	lea    0x1(%eax),%edx
    208e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2091:	89 c2                	mov    %eax,%edx
    2093:	8b 45 08             	mov    0x8(%ebp),%eax
    2096:	01 d0                	add    %edx,%eax
    2098:	8b 55 e0             	mov    -0x20(%ebp),%edx
    209b:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    209d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    20a4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    20a8:	8b 55 0c             	mov    0xc(%ebp),%edx
    20ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20ae:	01 d0                	add    %edx,%eax
    20b0:	0f b6 00             	movzbl (%eax),%eax
    20b3:	84 c0                	test   %al,%al
    20b5:	0f 85 14 fe ff ff    	jne    1ecf <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    20bb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20be:	8d 50 01             	lea    0x1(%eax),%edx
    20c1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c4:	89 c2                	mov    %eax,%edx
    20c6:	8b 45 08             	mov    0x8(%ebp),%eax
    20c9:	01 d0                	add    %edx,%eax
    20cb:	c6 00 00             	movb   $0x0,(%eax)
}
    20ce:	90                   	nop
    20cf:	c9                   	leave  
    20d0:	c3                   	ret    
