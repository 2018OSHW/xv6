
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
      1c:	68 58 22 00 00       	push   $0x2258
      21:	6a 02                	push   $0x2
      23:	e8 6e 04 00 00       	call   496 <printf>
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
      6f:	68 6c 22 00 00       	push   $0x226c
      74:	6a 02                	push   $0x2
      76:	e8 1b 04 00 00       	call   496 <printf>
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

000003bf <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3bf:	55                   	push   %ebp
     3c0:	89 e5                	mov    %esp,%ebp
     3c2:	83 ec 18             	sub    $0x18,%esp
     3c5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3cb:	83 ec 04             	sub    $0x4,%esp
     3ce:	6a 01                	push   $0x1
     3d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3d3:	50                   	push   %eax
     3d4:	ff 75 08             	pushl  0x8(%ebp)
     3d7:	e8 2b ff ff ff       	call   307 <write>
     3dc:	83 c4 10             	add    $0x10,%esp
}
     3df:	90                   	nop
     3e0:	c9                   	leave  
     3e1:	c3                   	ret    

000003e2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3e2:	55                   	push   %ebp
     3e3:	89 e5                	mov    %esp,%ebp
     3e5:	53                   	push   %ebx
     3e6:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3f0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3f4:	74 17                	je     40d <printint+0x2b>
     3f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3fa:	79 11                	jns    40d <printint+0x2b>
    neg = 1;
     3fc:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     403:	8b 45 0c             	mov    0xc(%ebp),%eax
     406:	f7 d8                	neg    %eax
     408:	89 45 ec             	mov    %eax,-0x14(%ebp)
     40b:	eb 06                	jmp    413 <printint+0x31>
  } else {
    x = xx;
     40d:	8b 45 0c             	mov    0xc(%ebp),%eax
     410:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     413:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     41a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     41d:	8d 41 01             	lea    0x1(%ecx),%eax
     420:	89 45 f4             	mov    %eax,-0xc(%ebp)
     423:	8b 5d 10             	mov    0x10(%ebp),%ebx
     426:	8b 45 ec             	mov    -0x14(%ebp),%eax
     429:	ba 00 00 00 00       	mov    $0x0,%edx
     42e:	f7 f3                	div    %ebx
     430:	89 d0                	mov    %edx,%eax
     432:	0f b6 80 58 29 00 00 	movzbl 0x2958(%eax),%eax
     439:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     43d:	8b 5d 10             	mov    0x10(%ebp),%ebx
     440:	8b 45 ec             	mov    -0x14(%ebp),%eax
     443:	ba 00 00 00 00       	mov    $0x0,%edx
     448:	f7 f3                	div    %ebx
     44a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     44d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     451:	75 c7                	jne    41a <printint+0x38>
  if(neg)
     453:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     457:	74 2d                	je     486 <printint+0xa4>
    buf[i++] = '-';
     459:	8b 45 f4             	mov    -0xc(%ebp),%eax
     45c:	8d 50 01             	lea    0x1(%eax),%edx
     45f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     462:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     467:	eb 1d                	jmp    486 <printint+0xa4>
    putc(fd, buf[i]);
     469:	8d 55 dc             	lea    -0x24(%ebp),%edx
     46c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46f:	01 d0                	add    %edx,%eax
     471:	0f b6 00             	movzbl (%eax),%eax
     474:	0f be c0             	movsbl %al,%eax
     477:	83 ec 08             	sub    $0x8,%esp
     47a:	50                   	push   %eax
     47b:	ff 75 08             	pushl  0x8(%ebp)
     47e:	e8 3c ff ff ff       	call   3bf <putc>
     483:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     486:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     48a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     48e:	79 d9                	jns    469 <printint+0x87>
    putc(fd, buf[i]);
}
     490:	90                   	nop
     491:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     494:	c9                   	leave  
     495:	c3                   	ret    

00000496 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     496:	55                   	push   %ebp
     497:	89 e5                	mov    %esp,%ebp
     499:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     49c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4a3:	8d 45 0c             	lea    0xc(%ebp),%eax
     4a6:	83 c0 04             	add    $0x4,%eax
     4a9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4b3:	e9 59 01 00 00       	jmp    611 <printf+0x17b>
    c = fmt[i] & 0xff;
     4b8:	8b 55 0c             	mov    0xc(%ebp),%edx
     4bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4be:	01 d0                	add    %edx,%eax
     4c0:	0f b6 00             	movzbl (%eax),%eax
     4c3:	0f be c0             	movsbl %al,%eax
     4c6:	25 ff 00 00 00       	and    $0xff,%eax
     4cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4d2:	75 2c                	jne    500 <printf+0x6a>
      if(c == '%'){
     4d4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4d8:	75 0c                	jne    4e6 <printf+0x50>
        state = '%';
     4da:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4e1:	e9 27 01 00 00       	jmp    60d <printf+0x177>
      } else {
        putc(fd, c);
     4e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4e9:	0f be c0             	movsbl %al,%eax
     4ec:	83 ec 08             	sub    $0x8,%esp
     4ef:	50                   	push   %eax
     4f0:	ff 75 08             	pushl  0x8(%ebp)
     4f3:	e8 c7 fe ff ff       	call   3bf <putc>
     4f8:	83 c4 10             	add    $0x10,%esp
     4fb:	e9 0d 01 00 00       	jmp    60d <printf+0x177>
      }
    } else if(state == '%'){
     500:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     504:	0f 85 03 01 00 00    	jne    60d <printf+0x177>
      if(c == 'd'){
     50a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     50e:	75 1e                	jne    52e <printf+0x98>
        printint(fd, *ap, 10, 1);
     510:	8b 45 e8             	mov    -0x18(%ebp),%eax
     513:	8b 00                	mov    (%eax),%eax
     515:	6a 01                	push   $0x1
     517:	6a 0a                	push   $0xa
     519:	50                   	push   %eax
     51a:	ff 75 08             	pushl  0x8(%ebp)
     51d:	e8 c0 fe ff ff       	call   3e2 <printint>
     522:	83 c4 10             	add    $0x10,%esp
        ap++;
     525:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     529:	e9 d8 00 00 00       	jmp    606 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     52e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     532:	74 06                	je     53a <printf+0xa4>
     534:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     538:	75 1e                	jne    558 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     53a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53d:	8b 00                	mov    (%eax),%eax
     53f:	6a 00                	push   $0x0
     541:	6a 10                	push   $0x10
     543:	50                   	push   %eax
     544:	ff 75 08             	pushl  0x8(%ebp)
     547:	e8 96 fe ff ff       	call   3e2 <printint>
     54c:	83 c4 10             	add    $0x10,%esp
        ap++;
     54f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     553:	e9 ae 00 00 00       	jmp    606 <printf+0x170>
      } else if(c == 's'){
     558:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     55c:	75 43                	jne    5a1 <printf+0x10b>
        s = (char*)*ap;
     55e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     561:	8b 00                	mov    (%eax),%eax
     563:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     566:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     56a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     56e:	75 25                	jne    595 <printf+0xff>
          s = "(null)";
     570:	c7 45 f4 85 22 00 00 	movl   $0x2285,-0xc(%ebp)
        while(*s != 0){
     577:	eb 1c                	jmp    595 <printf+0xff>
          putc(fd, *s);
     579:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57c:	0f b6 00             	movzbl (%eax),%eax
     57f:	0f be c0             	movsbl %al,%eax
     582:	83 ec 08             	sub    $0x8,%esp
     585:	50                   	push   %eax
     586:	ff 75 08             	pushl  0x8(%ebp)
     589:	e8 31 fe ff ff       	call   3bf <putc>
     58e:	83 c4 10             	add    $0x10,%esp
          s++;
     591:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     595:	8b 45 f4             	mov    -0xc(%ebp),%eax
     598:	0f b6 00             	movzbl (%eax),%eax
     59b:	84 c0                	test   %al,%al
     59d:	75 da                	jne    579 <printf+0xe3>
     59f:	eb 65                	jmp    606 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     5a1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5a5:	75 1d                	jne    5c4 <printf+0x12e>
        putc(fd, *ap);
     5a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5aa:	8b 00                	mov    (%eax),%eax
     5ac:	0f be c0             	movsbl %al,%eax
     5af:	83 ec 08             	sub    $0x8,%esp
     5b2:	50                   	push   %eax
     5b3:	ff 75 08             	pushl  0x8(%ebp)
     5b6:	e8 04 fe ff ff       	call   3bf <putc>
     5bb:	83 c4 10             	add    $0x10,%esp
        ap++;
     5be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c2:	eb 42                	jmp    606 <printf+0x170>
      } else if(c == '%'){
     5c4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5c8:	75 17                	jne    5e1 <printf+0x14b>
        putc(fd, c);
     5ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5cd:	0f be c0             	movsbl %al,%eax
     5d0:	83 ec 08             	sub    $0x8,%esp
     5d3:	50                   	push   %eax
     5d4:	ff 75 08             	pushl  0x8(%ebp)
     5d7:	e8 e3 fd ff ff       	call   3bf <putc>
     5dc:	83 c4 10             	add    $0x10,%esp
     5df:	eb 25                	jmp    606 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5e1:	83 ec 08             	sub    $0x8,%esp
     5e4:	6a 25                	push   $0x25
     5e6:	ff 75 08             	pushl  0x8(%ebp)
     5e9:	e8 d1 fd ff ff       	call   3bf <putc>
     5ee:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5f4:	0f be c0             	movsbl %al,%eax
     5f7:	83 ec 08             	sub    $0x8,%esp
     5fa:	50                   	push   %eax
     5fb:	ff 75 08             	pushl  0x8(%ebp)
     5fe:	e8 bc fd ff ff       	call   3bf <putc>
     603:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     606:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     60d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     611:	8b 55 0c             	mov    0xc(%ebp),%edx
     614:	8b 45 f0             	mov    -0x10(%ebp),%eax
     617:	01 d0                	add    %edx,%eax
     619:	0f b6 00             	movzbl (%eax),%eax
     61c:	84 c0                	test   %al,%al
     61e:	0f 85 94 fe ff ff    	jne    4b8 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     624:	90                   	nop
     625:	c9                   	leave  
     626:	c3                   	ret    

00000627 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     627:	55                   	push   %ebp
     628:	89 e5                	mov    %esp,%ebp
     62a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     62d:	8b 45 08             	mov    0x8(%ebp),%eax
     630:	83 e8 08             	sub    $0x8,%eax
     633:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     636:	a1 8c 29 00 00       	mov    0x298c,%eax
     63b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     63e:	eb 24                	jmp    664 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     640:	8b 45 fc             	mov    -0x4(%ebp),%eax
     643:	8b 00                	mov    (%eax),%eax
     645:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     648:	77 12                	ja     65c <free+0x35>
     64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     650:	77 24                	ja     676 <free+0x4f>
     652:	8b 45 fc             	mov    -0x4(%ebp),%eax
     655:	8b 00                	mov    (%eax),%eax
     657:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     65a:	77 1a                	ja     676 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65f:	8b 00                	mov    (%eax),%eax
     661:	89 45 fc             	mov    %eax,-0x4(%ebp)
     664:	8b 45 f8             	mov    -0x8(%ebp),%eax
     667:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     66a:	76 d4                	jbe    640 <free+0x19>
     66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66f:	8b 00                	mov    (%eax),%eax
     671:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     674:	76 ca                	jbe    640 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     676:	8b 45 f8             	mov    -0x8(%ebp),%eax
     679:	8b 40 04             	mov    0x4(%eax),%eax
     67c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     683:	8b 45 f8             	mov    -0x8(%ebp),%eax
     686:	01 c2                	add    %eax,%edx
     688:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68b:	8b 00                	mov    (%eax),%eax
     68d:	39 c2                	cmp    %eax,%edx
     68f:	75 24                	jne    6b5 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     691:	8b 45 f8             	mov    -0x8(%ebp),%eax
     694:	8b 50 04             	mov    0x4(%eax),%edx
     697:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69a:	8b 00                	mov    (%eax),%eax
     69c:	8b 40 04             	mov    0x4(%eax),%eax
     69f:	01 c2                	add    %eax,%edx
     6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a4:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6aa:	8b 00                	mov    (%eax),%eax
     6ac:	8b 10                	mov    (%eax),%edx
     6ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b1:	89 10                	mov    %edx,(%eax)
     6b3:	eb 0a                	jmp    6bf <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b8:	8b 10                	mov    (%eax),%edx
     6ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bd:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c2:	8b 40 04             	mov    0x4(%eax),%eax
     6c5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cf:	01 d0                	add    %edx,%eax
     6d1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6d4:	75 20                	jne    6f6 <free+0xcf>
    p->s.size += bp->s.size;
     6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d9:	8b 50 04             	mov    0x4(%eax),%edx
     6dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6df:	8b 40 04             	mov    0x4(%eax),%eax
     6e2:	01 c2                	add    %eax,%edx
     6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ed:	8b 10                	mov    (%eax),%edx
     6ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f2:	89 10                	mov    %edx,(%eax)
     6f4:	eb 08                	jmp    6fe <free+0xd7>
  } else
    p->s.ptr = bp;
     6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f9:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6fc:	89 10                	mov    %edx,(%eax)
  freep = p;
     6fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
     701:	a3 8c 29 00 00       	mov    %eax,0x298c
}
     706:	90                   	nop
     707:	c9                   	leave  
     708:	c3                   	ret    

00000709 <morecore>:

static Header*
morecore(uint nu)
{
     709:	55                   	push   %ebp
     70a:	89 e5                	mov    %esp,%ebp
     70c:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     70f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     716:	77 07                	ja     71f <morecore+0x16>
    nu = 4096;
     718:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     71f:	8b 45 08             	mov    0x8(%ebp),%eax
     722:	c1 e0 03             	shl    $0x3,%eax
     725:	83 ec 0c             	sub    $0xc,%esp
     728:	50                   	push   %eax
     729:	e8 41 fc ff ff       	call   36f <sbrk>
     72e:	83 c4 10             	add    $0x10,%esp
     731:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     734:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     738:	75 07                	jne    741 <morecore+0x38>
    return 0;
     73a:	b8 00 00 00 00       	mov    $0x0,%eax
     73f:	eb 26                	jmp    767 <morecore+0x5e>
  hp = (Header*)p;
     741:	8b 45 f4             	mov    -0xc(%ebp),%eax
     744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     747:	8b 45 f0             	mov    -0x10(%ebp),%eax
     74a:	8b 55 08             	mov    0x8(%ebp),%edx
     74d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     750:	8b 45 f0             	mov    -0x10(%ebp),%eax
     753:	83 c0 08             	add    $0x8,%eax
     756:	83 ec 0c             	sub    $0xc,%esp
     759:	50                   	push   %eax
     75a:	e8 c8 fe ff ff       	call   627 <free>
     75f:	83 c4 10             	add    $0x10,%esp
  return freep;
     762:	a1 8c 29 00 00       	mov    0x298c,%eax
}
     767:	c9                   	leave  
     768:	c3                   	ret    

00000769 <malloc>:

void*
malloc(uint nbytes)
{
     769:	55                   	push   %ebp
     76a:	89 e5                	mov    %esp,%ebp
     76c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     76f:	8b 45 08             	mov    0x8(%ebp),%eax
     772:	83 c0 07             	add    $0x7,%eax
     775:	c1 e8 03             	shr    $0x3,%eax
     778:	83 c0 01             	add    $0x1,%eax
     77b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     77e:	a1 8c 29 00 00       	mov    0x298c,%eax
     783:	89 45 f0             	mov    %eax,-0x10(%ebp)
     786:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     78a:	75 23                	jne    7af <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     78c:	c7 45 f0 84 29 00 00 	movl   $0x2984,-0x10(%ebp)
     793:	8b 45 f0             	mov    -0x10(%ebp),%eax
     796:	a3 8c 29 00 00       	mov    %eax,0x298c
     79b:	a1 8c 29 00 00       	mov    0x298c,%eax
     7a0:	a3 84 29 00 00       	mov    %eax,0x2984
    base.s.size = 0;
     7a5:	c7 05 88 29 00 00 00 	movl   $0x0,0x2988
     7ac:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b2:	8b 00                	mov    (%eax),%eax
     7b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ba:	8b 40 04             	mov    0x4(%eax),%eax
     7bd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7c0:	72 4d                	jb     80f <malloc+0xa6>
      if(p->s.size == nunits)
     7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c5:	8b 40 04             	mov    0x4(%eax),%eax
     7c8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7cb:	75 0c                	jne    7d9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d0:	8b 10                	mov    (%eax),%edx
     7d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d5:	89 10                	mov    %edx,(%eax)
     7d7:	eb 26                	jmp    7ff <malloc+0x96>
      else {
        p->s.size -= nunits;
     7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dc:	8b 40 04             	mov    0x4(%eax),%eax
     7df:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7e2:	89 c2                	mov    %eax,%edx
     7e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ed:	8b 40 04             	mov    0x4(%eax),%eax
     7f0:	c1 e0 03             	shl    $0x3,%eax
     7f3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7fc:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     802:	a3 8c 29 00 00       	mov    %eax,0x298c
      return (void*)(p + 1);
     807:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80a:	83 c0 08             	add    $0x8,%eax
     80d:	eb 3b                	jmp    84a <malloc+0xe1>
    }
    if(p == freep)
     80f:	a1 8c 29 00 00       	mov    0x298c,%eax
     814:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     817:	75 1e                	jne    837 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     819:	83 ec 0c             	sub    $0xc,%esp
     81c:	ff 75 ec             	pushl  -0x14(%ebp)
     81f:	e8 e5 fe ff ff       	call   709 <morecore>
     824:	83 c4 10             	add    $0x10,%esp
     827:	89 45 f4             	mov    %eax,-0xc(%ebp)
     82a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     82e:	75 07                	jne    837 <malloc+0xce>
        return 0;
     830:	b8 00 00 00 00       	mov    $0x0,%eax
     835:	eb 13                	jmp    84a <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     837:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     83d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     840:	8b 00                	mov    (%eax),%eax
     842:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     845:	e9 6d ff ff ff       	jmp    7b7 <malloc+0x4e>
}
     84a:	c9                   	leave  
     84b:	c3                   	ret    

0000084c <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     84c:	55                   	push   %ebp
     84d:	89 e5                	mov    %esp,%ebp
     84f:	83 ec 1c             	sub    $0x1c,%esp
     852:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     855:	8b 55 10             	mov    0x10(%ebp),%edx
     858:	8b 45 14             	mov    0x14(%ebp),%eax
     85b:	88 4d ec             	mov    %cl,-0x14(%ebp)
     85e:	88 55 e8             	mov    %dl,-0x18(%ebp)
     861:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     864:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     868:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     86b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     86f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     872:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     876:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     879:	8b 45 08             	mov    0x8(%ebp),%eax
     87c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     880:	66 89 10             	mov    %dx,(%eax)
     883:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     887:	88 50 02             	mov    %dl,0x2(%eax)
}
     88a:	8b 45 08             	mov    0x8(%ebp),%eax
     88d:	c9                   	leave  
     88e:	c2 04 00             	ret    $0x4

00000891 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     891:	55                   	push   %ebp
     892:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     894:	8b 45 08             	mov    0x8(%ebp),%eax
     897:	2b 45 10             	sub    0x10(%ebp),%eax
     89a:	89 c2                	mov    %eax,%edx
     89c:	8b 45 08             	mov    0x8(%ebp),%eax
     89f:	2b 45 10             	sub    0x10(%ebp),%eax
     8a2:	0f af d0             	imul   %eax,%edx
     8a5:	8b 45 0c             	mov    0xc(%ebp),%eax
     8a8:	2b 45 14             	sub    0x14(%ebp),%eax
     8ab:	89 c1                	mov    %eax,%ecx
     8ad:	8b 45 0c             	mov    0xc(%ebp),%eax
     8b0:	2b 45 14             	sub    0x14(%ebp),%eax
     8b3:	0f af c1             	imul   %ecx,%eax
     8b6:	01 d0                	add    %edx,%eax
}
     8b8:	5d                   	pop    %ebp
     8b9:	c3                   	ret    

000008ba <abs_int>:

static inline int abs_int(int x)
{
     8ba:	55                   	push   %ebp
     8bb:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8bd:	8b 45 08             	mov    0x8(%ebp),%eax
     8c0:	99                   	cltd   
     8c1:	89 d0                	mov    %edx,%eax
     8c3:	33 45 08             	xor    0x8(%ebp),%eax
     8c6:	29 d0                	sub    %edx,%eax
}
     8c8:	5d                   	pop    %ebp
     8c9:	c3                   	ret    

000008ca <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8ca:	55                   	push   %ebp
     8cb:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8d1:	79 07                	jns    8da <APGetIndex+0x10>
        return X_SMALLER;
     8d3:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8d8:	eb 40                	jmp    91a <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8da:	8b 45 08             	mov    0x8(%ebp),%eax
     8dd:	8b 00                	mov    (%eax),%eax
     8df:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8e2:	7f 07                	jg     8eb <APGetIndex+0x21>
        return X_BIGGER;
     8e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8e9:	eb 2f                	jmp    91a <APGetIndex+0x50>
    if (y < 0)
     8eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8ef:	79 07                	jns    8f8 <APGetIndex+0x2e>
        return Y_SMALLER;
     8f1:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8f6:	eb 22                	jmp    91a <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8f8:	8b 45 08             	mov    0x8(%ebp),%eax
     8fb:	8b 40 04             	mov    0x4(%eax),%eax
     8fe:	3b 45 10             	cmp    0x10(%ebp),%eax
     901:	7f 07                	jg     90a <APGetIndex+0x40>
        return Y_BIGGER;
     903:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     908:	eb 10                	jmp    91a <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     90a:	8b 45 08             	mov    0x8(%ebp),%eax
     90d:	8b 00                	mov    (%eax),%eax
     90f:	0f af 45 10          	imul   0x10(%ebp),%eax
     913:	89 c2                	mov    %eax,%edx
     915:	8b 45 0c             	mov    0xc(%ebp),%eax
     918:	01 d0                	add    %edx,%eax
}
     91a:	5d                   	pop    %ebp
     91b:	c3                   	ret    

0000091c <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     91c:	55                   	push   %ebp
     91d:	89 e5                	mov    %esp,%ebp
     91f:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     922:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     929:	8b 45 cc             	mov    -0x34(%ebp),%eax
     92c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     92f:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     936:	83 ec 08             	sub    $0x8,%esp
     939:	6a 00                	push   $0x0
     93b:	ff 75 0c             	pushl  0xc(%ebp)
     93e:	e8 e4 f9 ff ff       	call   327 <open>
     943:	83 c4 10             	add    $0x10,%esp
     946:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     949:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     94d:	79 2e                	jns    97d <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     94f:	83 ec 04             	sub    $0x4,%esp
     952:	ff 75 0c             	pushl  0xc(%ebp)
     955:	68 8c 22 00 00       	push   $0x228c
     95a:	6a 01                	push   $0x1
     95c:	e8 35 fb ff ff       	call   496 <printf>
     961:	83 c4 10             	add    $0x10,%esp
        return bmp;
     964:	8b 45 08             	mov    0x8(%ebp),%eax
     967:	8b 55 c8             	mov    -0x38(%ebp),%edx
     96a:	89 10                	mov    %edx,(%eax)
     96c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     96f:	89 50 04             	mov    %edx,0x4(%eax)
     972:	8b 55 d0             	mov    -0x30(%ebp),%edx
     975:	89 50 08             	mov    %edx,0x8(%eax)
     978:	e9 d2 01 00 00       	jmp    b4f <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     97d:	83 ec 04             	sub    $0x4,%esp
     980:	6a 0e                	push   $0xe
     982:	8d 45 ba             	lea    -0x46(%ebp),%eax
     985:	50                   	push   %eax
     986:	ff 75 ec             	pushl  -0x14(%ebp)
     989:	e8 71 f9 ff ff       	call   2ff <read>
     98e:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     991:	83 ec 04             	sub    $0x4,%esp
     994:	6a 28                	push   $0x28
     996:	8d 45 92             	lea    -0x6e(%ebp),%eax
     999:	50                   	push   %eax
     99a:	ff 75 ec             	pushl  -0x14(%ebp)
     99d:	e8 5d f9 ff ff       	call   2ff <read>
     9a2:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     9a5:	8b 45 96             	mov    -0x6a(%ebp),%eax
     9a8:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     9ab:	8b 45 9a             	mov    -0x66(%ebp),%eax
     9ae:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9b1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9b4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9b7:	0f af d0             	imul   %eax,%edx
     9ba:	89 d0                	mov    %edx,%eax
     9bc:	01 c0                	add    %eax,%eax
     9be:	01 d0                	add    %edx,%eax
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	50                   	push   %eax
     9c4:	e8 a0 fd ff ff       	call   769 <malloc>
     9c9:	83 c4 10             	add    $0x10,%esp
     9cc:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9cf:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9d3:	0f b7 c0             	movzwl %ax,%eax
     9d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9d9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9df:	0f af c2             	imul   %edx,%eax
     9e2:	83 c0 1f             	add    $0x1f,%eax
     9e5:	c1 e8 05             	shr    $0x5,%eax
     9e8:	c1 e0 02             	shl    $0x2,%eax
     9eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9ee:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9f4:	0f af c2             	imul   %edx,%eax
     9f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9fd:	83 ec 0c             	sub    $0xc,%esp
     a00:	50                   	push   %eax
     a01:	e8 63 fd ff ff       	call   769 <malloc>
     a06:	83 c4 10             	add    $0x10,%esp
     a09:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a0c:	83 ec 04             	sub    $0x4,%esp
     a0f:	ff 75 e0             	pushl  -0x20(%ebp)
     a12:	ff 75 dc             	pushl  -0x24(%ebp)
     a15:	ff 75 ec             	pushl  -0x14(%ebp)
     a18:	e8 e2 f8 ff ff       	call   2ff <read>
     a1d:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a20:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a24:	66 c1 e8 03          	shr    $0x3,%ax
     a28:	0f b7 c0             	movzwl %ax,%eax
     a2b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a35:	e9 e5 00 00 00       	jmp    b1f <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a3a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a40:	29 c2                	sub    %eax,%edx
     a42:	89 d0                	mov    %edx,%eax
     a44:	8d 50 ff             	lea    -0x1(%eax),%edx
     a47:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a4a:	0f af c2             	imul   %edx,%eax
     a4d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a50:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a57:	e9 b1 00 00 00       	jmp    b0d <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a5c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a5f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a62:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a65:	01 c8                	add    %ecx,%eax
     a67:	89 c1                	mov    %eax,%ecx
     a69:	89 c8                	mov    %ecx,%eax
     a6b:	01 c0                	add    %eax,%eax
     a6d:	01 c8                	add    %ecx,%eax
     a6f:	01 c2                	add    %eax,%edx
     a71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a74:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a78:	89 c1                	mov    %eax,%ecx
     a7a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a7d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a81:	01 c1                	add    %eax,%ecx
     a83:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a86:	01 c8                	add    %ecx,%eax
     a88:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a8b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a8e:	01 c8                	add    %ecx,%eax
     a90:	0f b6 00             	movzbl (%eax),%eax
     a93:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a96:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a99:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a9f:	01 c8                	add    %ecx,%eax
     aa1:	89 c1                	mov    %eax,%ecx
     aa3:	89 c8                	mov    %ecx,%eax
     aa5:	01 c0                	add    %eax,%eax
     aa7:	01 c8                	add    %ecx,%eax
     aa9:	01 c2                	add    %eax,%edx
     aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aae:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ab2:	89 c1                	mov    %eax,%ecx
     ab4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ab7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     abb:	01 c1                	add    %eax,%ecx
     abd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac0:	01 c8                	add    %ecx,%eax
     ac2:	8d 48 fe             	lea    -0x2(%eax),%ecx
     ac5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ac8:	01 c8                	add    %ecx,%eax
     aca:	0f b6 00             	movzbl (%eax),%eax
     acd:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ad0:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ad3:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ad6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad9:	01 c8                	add    %ecx,%eax
     adb:	89 c1                	mov    %eax,%ecx
     add:	89 c8                	mov    %ecx,%eax
     adf:	01 c0                	add    %eax,%eax
     ae1:	01 c8                	add    %ecx,%eax
     ae3:	01 c2                	add    %eax,%edx
     ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae8:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     aec:	89 c1                	mov    %eax,%ecx
     aee:	8b 45 d8             	mov    -0x28(%ebp),%eax
     af1:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     af5:	01 c1                	add    %eax,%ecx
     af7:	8b 45 d8             	mov    -0x28(%ebp),%eax
     afa:	01 c8                	add    %ecx,%eax
     afc:	8d 48 fd             	lea    -0x3(%eax),%ecx
     aff:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b02:	01 c8                	add    %ecx,%eax
     b04:	0f b6 00             	movzbl (%eax),%eax
     b07:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b09:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b0d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b10:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b13:	39 c2                	cmp    %eax,%edx
     b15:	0f 87 41 ff ff ff    	ja     a5c <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b1b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b1f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b25:	39 c2                	cmp    %eax,%edx
     b27:	0f 87 0d ff ff ff    	ja     a3a <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b2d:	83 ec 0c             	sub    $0xc,%esp
     b30:	ff 75 ec             	pushl  -0x14(%ebp)
     b33:	e8 d7 f7 ff ff       	call   30f <close>
     b38:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b3b:	8b 45 08             	mov    0x8(%ebp),%eax
     b3e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b41:	89 10                	mov    %edx,(%eax)
     b43:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b46:	89 50 04             	mov    %edx,0x4(%eax)
     b49:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b4c:	89 50 08             	mov    %edx,0x8(%eax)
}
     b4f:	8b 45 08             	mov    0x8(%ebp),%eax
     b52:	c9                   	leave  
     b53:	c2 04 00             	ret    $0x4

00000b56 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b56:	55                   	push   %ebp
     b57:	89 e5                	mov    %esp,%ebp
     b59:	53                   	push   %ebx
     b5a:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b5d:	83 ec 0c             	sub    $0xc,%esp
     b60:	6a 1c                	push   $0x1c
     b62:	e8 02 fc ff ff       	call   769 <malloc>
     b67:	83 c4 10             	add    $0x10,%esp
     b6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b70:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b77:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b7a:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b7d:	6a 0c                	push   $0xc
     b7f:	6a 0c                	push   $0xc
     b81:	6a 0c                	push   $0xc
     b83:	50                   	push   %eax
     b84:	e8 c3 fc ff ff       	call   84c <RGB>
     b89:	83 c4 0c             	add    $0xc,%esp
     b8c:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b90:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b94:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b98:	88 43 15             	mov    %al,0x15(%ebx)
     b9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ba1:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     ba5:	66 89 48 10          	mov    %cx,0x10(%eax)
     ba9:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     bad:	88 50 12             	mov    %dl,0x12(%eax)
     bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bb6:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bba:	66 89 48 08          	mov    %cx,0x8(%eax)
     bbe:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     bc2:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     bc5:	8b 45 08             	mov    0x8(%ebp),%eax
     bc8:	89 c2                	mov    %eax,%edx
     bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bcd:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bcf:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd2:	89 c2                	mov    %eax,%edx
     bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd7:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bda:	8b 55 10             	mov    0x10(%ebp),%edx
     bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be0:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     be6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     be9:	c9                   	leave  
     bea:	c3                   	ret    

00000beb <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     beb:	55                   	push   %ebp
     bec:	89 e5                	mov    %esp,%ebp
     bee:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bf1:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf4:	8b 50 08             	mov    0x8(%eax),%edx
     bf7:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bfa:	8b 40 0c             	mov    0xc(%eax),%eax
     bfd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c00:	8b 45 0c             	mov    0xc(%ebp),%eax
     c03:	8b 55 10             	mov    0x10(%ebp),%edx
     c06:	89 50 08             	mov    %edx,0x8(%eax)
     c09:	8b 55 14             	mov    0x14(%ebp),%edx
     c0c:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c0f:	8b 45 08             	mov    0x8(%ebp),%eax
     c12:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c15:	89 10                	mov    %edx,(%eax)
     c17:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c1a:	89 50 04             	mov    %edx,0x4(%eax)
}
     c1d:	8b 45 08             	mov    0x8(%ebp),%eax
     c20:	c9                   	leave  
     c21:	c2 04 00             	ret    $0x4

00000c24 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c24:	55                   	push   %ebp
     c25:	89 e5                	mov    %esp,%ebp
     c27:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c2d:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c31:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c35:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c39:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c3c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3f:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c43:	66 89 50 10          	mov    %dx,0x10(%eax)
     c47:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c4b:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c4e:	8b 45 08             	mov    0x8(%ebp),%eax
     c51:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c55:	66 89 10             	mov    %dx,(%eax)
     c58:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c5c:	88 50 02             	mov    %dl,0x2(%eax)
}
     c5f:	8b 45 08             	mov    0x8(%ebp),%eax
     c62:	c9                   	leave  
     c63:	c2 04 00             	ret    $0x4

00000c66 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c66:	55                   	push   %ebp
     c67:	89 e5                	mov    %esp,%ebp
     c69:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c6c:	8b 45 08             	mov    0x8(%ebp),%eax
     c6f:	8b 40 0c             	mov    0xc(%eax),%eax
     c72:	89 c2                	mov    %eax,%edx
     c74:	c1 ea 1f             	shr    $0x1f,%edx
     c77:	01 d0                	add    %edx,%eax
     c79:	d1 f8                	sar    %eax
     c7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c81:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c85:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c88:	8b 45 10             	mov    0x10(%ebp),%eax
     c8b:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c91:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c95:	0f 89 98 00 00 00    	jns    d33 <APDrawPoint+0xcd>
        i = 0;
     c9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     ca2:	e9 8c 00 00 00       	jmp    d33 <APDrawPoint+0xcd>
    {
        j = x - off;
     ca7:	8b 45 0c             	mov    0xc(%ebp),%eax
     caa:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cad:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cb0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cb4:	79 69                	jns    d1f <APDrawPoint+0xb9>
            j = 0;
     cb6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cbd:	eb 60                	jmp    d1f <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cbf:	ff 75 fc             	pushl  -0x4(%ebp)
     cc2:	ff 75 f8             	pushl  -0x8(%ebp)
     cc5:	ff 75 08             	pushl  0x8(%ebp)
     cc8:	e8 fd fb ff ff       	call   8ca <APGetIndex>
     ccd:	83 c4 0c             	add    $0xc,%esp
     cd0:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cd3:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cd7:	74 55                	je     d2e <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cd9:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cdd:	74 67                	je     d46 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cdf:	ff 75 10             	pushl  0x10(%ebp)
     ce2:	ff 75 0c             	pushl  0xc(%ebp)
     ce5:	ff 75 fc             	pushl  -0x4(%ebp)
     ce8:	ff 75 f8             	pushl  -0x8(%ebp)
     ceb:	e8 a1 fb ff ff       	call   891 <distance_2>
     cf0:	83 c4 10             	add    $0x10,%esp
     cf3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cf6:	7f 23                	jg     d1b <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cf8:	8b 45 08             	mov    0x8(%ebp),%eax
     cfb:	8b 48 18             	mov    0x18(%eax),%ecx
     cfe:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d01:	89 d0                	mov    %edx,%eax
     d03:	01 c0                	add    %eax,%eax
     d05:	01 d0                	add    %edx,%eax
     d07:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d0a:	8b 45 08             	mov    0x8(%ebp),%eax
     d0d:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d11:	66 89 0a             	mov    %cx,(%edx)
     d14:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d18:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d1b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d1f:	8b 55 0c             	mov    0xc(%ebp),%edx
     d22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d25:	01 d0                	add    %edx,%eax
     d27:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d2a:	7d 93                	jge    cbf <APDrawPoint+0x59>
     d2c:	eb 01                	jmp    d2f <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d2e:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d2f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d33:	8b 55 10             	mov    0x10(%ebp),%edx
     d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d39:	01 d0                	add    %edx,%eax
     d3b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d3e:	0f 8d 63 ff ff ff    	jge    ca7 <APDrawPoint+0x41>
     d44:	eb 01                	jmp    d47 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d46:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d47:	c9                   	leave  
     d48:	c3                   	ret    

00000d49 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d49:	55                   	push   %ebp
     d4a:	89 e5                	mov    %esp,%ebp
     d4c:	53                   	push   %ebx
     d4d:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d50:	8b 45 0c             	mov    0xc(%ebp),%eax
     d53:	3b 45 14             	cmp    0x14(%ebp),%eax
     d56:	0f 85 80 00 00 00    	jne    ddc <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d5c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d60:	0f 88 9d 02 00 00    	js     1003 <APDrawLine+0x2ba>
     d66:	8b 45 08             	mov    0x8(%ebp),%eax
     d69:	8b 00                	mov    (%eax),%eax
     d6b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d6e:	0f 8e 8f 02 00 00    	jle    1003 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d74:	8b 45 10             	mov    0x10(%ebp),%eax
     d77:	3b 45 18             	cmp    0x18(%ebp),%eax
     d7a:	7e 12                	jle    d8e <APDrawLine+0x45>
        {
            int tmp = y2;
     d7c:	8b 45 18             	mov    0x18(%ebp),%eax
     d7f:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d82:	8b 45 10             	mov    0x10(%ebp),%eax
     d85:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d88:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d8b:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d92:	79 07                	jns    d9b <APDrawLine+0x52>
     d94:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d9b:	8b 45 08             	mov    0x8(%ebp),%eax
     d9e:	8b 40 04             	mov    0x4(%eax),%eax
     da1:	3b 45 18             	cmp    0x18(%ebp),%eax
     da4:	7d 0c                	jge    db2 <APDrawLine+0x69>
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	8b 40 04             	mov    0x4(%eax),%eax
     dac:	83 e8 01             	sub    $0x1,%eax
     daf:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     db2:	8b 45 10             	mov    0x10(%ebp),%eax
     db5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     db8:	eb 15                	jmp    dcf <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dba:	ff 75 f4             	pushl  -0xc(%ebp)
     dbd:	ff 75 0c             	pushl  0xc(%ebp)
     dc0:	ff 75 08             	pushl  0x8(%ebp)
     dc3:	e8 9e fe ff ff       	call   c66 <APDrawPoint>
     dc8:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     dcb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd2:	3b 45 18             	cmp    0x18(%ebp),%eax
     dd5:	7e e3                	jle    dba <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dd7:	e9 2b 02 00 00       	jmp    1007 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     ddc:	8b 45 10             	mov    0x10(%ebp),%eax
     ddf:	3b 45 18             	cmp    0x18(%ebp),%eax
     de2:	75 7f                	jne    e63 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     de4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     de8:	0f 88 18 02 00 00    	js     1006 <APDrawLine+0x2bd>
     dee:	8b 45 08             	mov    0x8(%ebp),%eax
     df1:	8b 40 04             	mov    0x4(%eax),%eax
     df4:	3b 45 10             	cmp    0x10(%ebp),%eax
     df7:	0f 8e 09 02 00 00    	jle    1006 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
     e00:	3b 45 14             	cmp    0x14(%ebp),%eax
     e03:	7e 12                	jle    e17 <APDrawLine+0xce>
        {
            int tmp = x2;
     e05:	8b 45 14             	mov    0x14(%ebp),%eax
     e08:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e0b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0e:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e11:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e14:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e17:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e1b:	79 07                	jns    e24 <APDrawLine+0xdb>
     e1d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e24:	8b 45 08             	mov    0x8(%ebp),%eax
     e27:	8b 00                	mov    (%eax),%eax
     e29:	3b 45 14             	cmp    0x14(%ebp),%eax
     e2c:	7d 0b                	jge    e39 <APDrawLine+0xf0>
     e2e:	8b 45 08             	mov    0x8(%ebp),%eax
     e31:	8b 00                	mov    (%eax),%eax
     e33:	83 e8 01             	sub    $0x1,%eax
     e36:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e39:	8b 45 0c             	mov    0xc(%ebp),%eax
     e3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e3f:	eb 15                	jmp    e56 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e41:	ff 75 10             	pushl  0x10(%ebp)
     e44:	ff 75 f0             	pushl  -0x10(%ebp)
     e47:	ff 75 08             	pushl  0x8(%ebp)
     e4a:	e8 17 fe ff ff       	call   c66 <APDrawPoint>
     e4f:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e52:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e56:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e59:	3b 45 14             	cmp    0x14(%ebp),%eax
     e5c:	7e e3                	jle    e41 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e5e:	e9 a4 01 00 00       	jmp    1007 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e63:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e6a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e71:	8b 45 0c             	mov    0xc(%ebp),%eax
     e74:	2b 45 14             	sub    0x14(%ebp),%eax
     e77:	50                   	push   %eax
     e78:	e8 3d fa ff ff       	call   8ba <abs_int>
     e7d:	83 c4 04             	add    $0x4,%esp
     e80:	89 c3                	mov    %eax,%ebx
     e82:	8b 45 10             	mov    0x10(%ebp),%eax
     e85:	2b 45 18             	sub    0x18(%ebp),%eax
     e88:	50                   	push   %eax
     e89:	e8 2c fa ff ff       	call   8ba <abs_int>
     e8e:	83 c4 04             	add    $0x4,%esp
     e91:	39 c3                	cmp    %eax,%ebx
     e93:	0f 8e b5 00 00 00    	jle    f4e <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e99:	8b 45 10             	mov    0x10(%ebp),%eax
     e9c:	2b 45 18             	sub    0x18(%ebp),%eax
     e9f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ea2:	db 45 b0             	fildl  -0x50(%ebp)
     ea5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea8:	2b 45 14             	sub    0x14(%ebp),%eax
     eab:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eae:	db 45 b0             	fildl  -0x50(%ebp)
     eb1:	de f9                	fdivrp %st,%st(1)
     eb3:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     eb6:	8b 45 14             	mov    0x14(%ebp),%eax
     eb9:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ebc:	7e 0e                	jle    ecc <APDrawLine+0x183>
        {
            s = x1;
     ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ec4:	8b 45 14             	mov    0x14(%ebp),%eax
     ec7:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eca:	eb 0c                	jmp    ed8 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ecc:	8b 45 14             	mov    0x14(%ebp),%eax
     ecf:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ed2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed5:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ed8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     edc:	79 07                	jns    ee5 <APDrawLine+0x19c>
     ede:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ee5:	8b 45 08             	mov    0x8(%ebp),%eax
     ee8:	8b 00                	mov    (%eax),%eax
     eea:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     eed:	7f 0b                	jg     efa <APDrawLine+0x1b1>
     eef:	8b 45 08             	mov    0x8(%ebp),%eax
     ef2:	8b 00                	mov    (%eax),%eax
     ef4:	83 e8 01             	sub    $0x1,%eax
     ef7:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     efa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     efd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f00:	eb 3f                	jmp    f41 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f02:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f05:	2b 45 0c             	sub    0xc(%ebp),%eax
     f08:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f0b:	db 45 b0             	fildl  -0x50(%ebp)
     f0e:	dc 4d d0             	fmull  -0x30(%ebp)
     f11:	db 45 10             	fildl  0x10(%ebp)
     f14:	de c1                	faddp  %st,%st(1)
     f16:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f19:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f1d:	b4 0c                	mov    $0xc,%ah
     f1f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f23:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f26:	db 5d cc             	fistpl -0x34(%ebp)
     f29:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f2c:	ff 75 cc             	pushl  -0x34(%ebp)
     f2f:	ff 75 e4             	pushl  -0x1c(%ebp)
     f32:	ff 75 08             	pushl  0x8(%ebp)
     f35:	e8 2c fd ff ff       	call   c66 <APDrawPoint>
     f3a:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f3d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f44:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f47:	7e b9                	jle    f02 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f49:	e9 b9 00 00 00       	jmp    1007 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f51:	2b 45 14             	sub    0x14(%ebp),%eax
     f54:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f57:	db 45 b0             	fildl  -0x50(%ebp)
     f5a:	8b 45 10             	mov    0x10(%ebp),%eax
     f5d:	2b 45 18             	sub    0x18(%ebp),%eax
     f60:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f63:	db 45 b0             	fildl  -0x50(%ebp)
     f66:	de f9                	fdivrp %st,%st(1)
     f68:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f6b:	8b 45 10             	mov    0x10(%ebp),%eax
     f6e:	3b 45 18             	cmp    0x18(%ebp),%eax
     f71:	7e 0e                	jle    f81 <APDrawLine+0x238>
    {
        s = y2;
     f73:	8b 45 18             	mov    0x18(%ebp),%eax
     f76:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f79:	8b 45 10             	mov    0x10(%ebp),%eax
     f7c:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f7f:	eb 0c                	jmp    f8d <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f81:	8b 45 10             	mov    0x10(%ebp),%eax
     f84:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f87:	8b 45 18             	mov    0x18(%ebp),%eax
     f8a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f8d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f91:	79 07                	jns    f9a <APDrawLine+0x251>
     f93:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f9a:	8b 45 08             	mov    0x8(%ebp),%eax
     f9d:	8b 40 04             	mov    0x4(%eax),%eax
     fa0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fa3:	7f 0c                	jg     fb1 <APDrawLine+0x268>
     fa5:	8b 45 08             	mov    0x8(%ebp),%eax
     fa8:	8b 40 04             	mov    0x4(%eax),%eax
     fab:	83 e8 01             	sub    $0x1,%eax
     fae:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fb1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fb4:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fb7:	eb 3f                	jmp    ff8 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fb9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fbc:	2b 45 10             	sub    0x10(%ebp),%eax
     fbf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc2:	db 45 b0             	fildl  -0x50(%ebp)
     fc5:	dc 4d c0             	fmull  -0x40(%ebp)
     fc8:	db 45 0c             	fildl  0xc(%ebp)
     fcb:	de c1                	faddp  %st,%st(1)
     fcd:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fd0:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fd4:	b4 0c                	mov    $0xc,%ah
     fd6:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fda:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fdd:	db 5d bc             	fistpl -0x44(%ebp)
     fe0:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fe3:	ff 75 e0             	pushl  -0x20(%ebp)
     fe6:	ff 75 bc             	pushl  -0x44(%ebp)
     fe9:	ff 75 08             	pushl  0x8(%ebp)
     fec:	e8 75 fc ff ff       	call   c66 <APDrawPoint>
     ff1:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     ff4:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     ff8:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ffb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ffe:	7e b9                	jle    fb9 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1000:	90                   	nop
    1001:	eb 04                	jmp    1007 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1003:	90                   	nop
    1004:	eb 01                	jmp    1007 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1006:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1007:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    100a:	c9                   	leave  
    100b:	c3                   	ret    

0000100c <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    100c:	55                   	push   %ebp
    100d:	89 e5                	mov    %esp,%ebp
    100f:	53                   	push   %ebx
    1010:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1013:	8b 55 10             	mov    0x10(%ebp),%edx
    1016:	8b 45 18             	mov    0x18(%ebp),%eax
    1019:	01 d0                	add    %edx,%eax
    101b:	83 e8 01             	sub    $0x1,%eax
    101e:	83 ec 04             	sub    $0x4,%esp
    1021:	50                   	push   %eax
    1022:	ff 75 0c             	pushl  0xc(%ebp)
    1025:	ff 75 10             	pushl  0x10(%ebp)
    1028:	ff 75 0c             	pushl  0xc(%ebp)
    102b:	ff 75 08             	pushl  0x8(%ebp)
    102e:	e8 16 fd ff ff       	call   d49 <APDrawLine>
    1033:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1036:	8b 55 0c             	mov    0xc(%ebp),%edx
    1039:	8b 45 14             	mov    0x14(%ebp),%eax
    103c:	01 d0                	add    %edx,%eax
    103e:	83 e8 01             	sub    $0x1,%eax
    1041:	83 ec 04             	sub    $0x4,%esp
    1044:	ff 75 10             	pushl  0x10(%ebp)
    1047:	50                   	push   %eax
    1048:	ff 75 10             	pushl  0x10(%ebp)
    104b:	ff 75 0c             	pushl  0xc(%ebp)
    104e:	ff 75 08             	pushl  0x8(%ebp)
    1051:	e8 f3 fc ff ff       	call   d49 <APDrawLine>
    1056:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1059:	8b 55 10             	mov    0x10(%ebp),%edx
    105c:	8b 45 18             	mov    0x18(%ebp),%eax
    105f:	01 d0                	add    %edx,%eax
    1061:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1064:	8b 55 0c             	mov    0xc(%ebp),%edx
    1067:	8b 45 14             	mov    0x14(%ebp),%eax
    106a:	01 d0                	add    %edx,%eax
    106c:	8d 50 ff             	lea    -0x1(%eax),%edx
    106f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1072:	8b 45 14             	mov    0x14(%ebp),%eax
    1075:	01 d8                	add    %ebx,%eax
    1077:	83 e8 01             	sub    $0x1,%eax
    107a:	83 ec 04             	sub    $0x4,%esp
    107d:	51                   	push   %ecx
    107e:	52                   	push   %edx
    107f:	ff 75 10             	pushl  0x10(%ebp)
    1082:	50                   	push   %eax
    1083:	ff 75 08             	pushl  0x8(%ebp)
    1086:	e8 be fc ff ff       	call   d49 <APDrawLine>
    108b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    108e:	8b 55 10             	mov    0x10(%ebp),%edx
    1091:	8b 45 18             	mov    0x18(%ebp),%eax
    1094:	01 d0                	add    %edx,%eax
    1096:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1099:	8b 55 0c             	mov    0xc(%ebp),%edx
    109c:	8b 45 14             	mov    0x14(%ebp),%eax
    109f:	01 d0                	add    %edx,%eax
    10a1:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a4:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10a7:	8b 45 18             	mov    0x18(%ebp),%eax
    10aa:	01 d8                	add    %ebx,%eax
    10ac:	83 e8 01             	sub    $0x1,%eax
    10af:	83 ec 04             	sub    $0x4,%esp
    10b2:	51                   	push   %ecx
    10b3:	52                   	push   %edx
    10b4:	50                   	push   %eax
    10b5:	ff 75 0c             	pushl  0xc(%ebp)
    10b8:	ff 75 08             	pushl  0x8(%ebp)
    10bb:	e8 89 fc ff ff       	call   d49 <APDrawLine>
    10c0:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10c3:	8b 55 0c             	mov    0xc(%ebp),%edx
    10c6:	8b 45 14             	mov    0x14(%ebp),%eax
    10c9:	01 d0                	add    %edx,%eax
    10cb:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ce:	8b 45 08             	mov    0x8(%ebp),%eax
    10d1:	8b 40 0c             	mov    0xc(%eax),%eax
    10d4:	89 c1                	mov    %eax,%ecx
    10d6:	c1 e9 1f             	shr    $0x1f,%ecx
    10d9:	01 c8                	add    %ecx,%eax
    10db:	d1 f8                	sar    %eax
    10dd:	29 c2                	sub    %eax,%edx
    10df:	89 d0                	mov    %edx,%eax
    10e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10e4:	8b 55 10             	mov    0x10(%ebp),%edx
    10e7:	8b 45 18             	mov    0x18(%ebp),%eax
    10ea:	01 d0                	add    %edx,%eax
    10ec:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ef:	8b 45 08             	mov    0x8(%ebp),%eax
    10f2:	8b 40 0c             	mov    0xc(%eax),%eax
    10f5:	89 c1                	mov    %eax,%ecx
    10f7:	c1 e9 1f             	shr    $0x1f,%ecx
    10fa:	01 c8                	add    %ecx,%eax
    10fc:	d1 f8                	sar    %eax
    10fe:	29 c2                	sub    %eax,%edx
    1100:	89 d0                	mov    %edx,%eax
    1102:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1105:	8b 45 08             	mov    0x8(%ebp),%eax
    1108:	8b 40 0c             	mov    0xc(%eax),%eax
    110b:	89 c2                	mov    %eax,%edx
    110d:	c1 ea 1f             	shr    $0x1f,%edx
    1110:	01 d0                	add    %edx,%eax
    1112:	d1 f8                	sar    %eax
    1114:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1117:	8b 45 08             	mov    0x8(%ebp),%eax
    111a:	8b 40 0c             	mov    0xc(%eax),%eax
    111d:	89 c2                	mov    %eax,%edx
    111f:	c1 ea 1f             	shr    $0x1f,%edx
    1122:	01 d0                	add    %edx,%eax
    1124:	d1 f8                	sar    %eax
    1126:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1129:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    112d:	0f 88 d8 00 00 00    	js     120b <APDrawRect+0x1ff>
    1133:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1137:	0f 88 ce 00 00 00    	js     120b <APDrawRect+0x1ff>
    113d:	8b 45 08             	mov    0x8(%ebp),%eax
    1140:	8b 00                	mov    (%eax),%eax
    1142:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1145:	0f 8e c0 00 00 00    	jle    120b <APDrawRect+0x1ff>
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	8b 40 04             	mov    0x4(%eax),%eax
    1151:	3b 45 10             	cmp    0x10(%ebp),%eax
    1154:	0f 8e b1 00 00 00    	jle    120b <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    115a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    115e:	79 07                	jns    1167 <APDrawRect+0x15b>
    1160:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1167:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    116b:	79 07                	jns    1174 <APDrawRect+0x168>
    116d:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	8b 00                	mov    (%eax),%eax
    1179:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    117c:	7f 0b                	jg     1189 <APDrawRect+0x17d>
    117e:	8b 45 08             	mov    0x8(%ebp),%eax
    1181:	8b 00                	mov    (%eax),%eax
    1183:	83 e8 01             	sub    $0x1,%eax
    1186:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1189:	8b 45 08             	mov    0x8(%ebp),%eax
    118c:	8b 40 04             	mov    0x4(%eax),%eax
    118f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1192:	7f 0c                	jg     11a0 <APDrawRect+0x194>
    1194:	8b 45 08             	mov    0x8(%ebp),%eax
    1197:	8b 40 04             	mov    0x4(%eax),%eax
    119a:	83 e8 01             	sub    $0x1,%eax
    119d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    11aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11ad:	eb 52                	jmp    1201 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11af:	8b 45 10             	mov    0x10(%ebp),%eax
    11b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11b5:	eb 3e                	jmp    11f5 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11b7:	83 ec 04             	sub    $0x4,%esp
    11ba:	ff 75 e8             	pushl  -0x18(%ebp)
    11bd:	ff 75 ec             	pushl  -0x14(%ebp)
    11c0:	ff 75 08             	pushl  0x8(%ebp)
    11c3:	e8 02 f7 ff ff       	call   8ca <APGetIndex>
    11c8:	83 c4 10             	add    $0x10,%esp
    11cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11ce:	8b 45 08             	mov    0x8(%ebp),%eax
    11d1:	8b 48 18             	mov    0x18(%eax),%ecx
    11d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11d7:	89 d0                	mov    %edx,%eax
    11d9:	01 c0                	add    %eax,%eax
    11db:	01 d0                	add    %edx,%eax
    11dd:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11e0:	8b 45 08             	mov    0x8(%ebp),%eax
    11e3:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11e7:	66 89 0a             	mov    %cx,(%edx)
    11ea:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11ee:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11f1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11f8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11fb:	7e ba                	jle    11b7 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11fd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1201:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1204:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1207:	7e a6                	jle    11af <APDrawRect+0x1a3>
    1209:	eb 01                	jmp    120c <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    120b:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    120c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    120f:	c9                   	leave  
    1210:	c3                   	ret    

00001211 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1211:	55                   	push   %ebp
    1212:	89 e5                	mov    %esp,%ebp
}
    1214:	90                   	nop
    1215:	5d                   	pop    %ebp
    1216:	c3                   	ret    

00001217 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1217:	55                   	push   %ebp
    1218:	89 e5                	mov    %esp,%ebp
    121a:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    121d:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1221:	0f 88 8e 01 00 00    	js     13b5 <APDcCopy+0x19e>
    1227:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    122b:	0f 88 84 01 00 00    	js     13b5 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1231:	8b 55 0c             	mov    0xc(%ebp),%edx
    1234:	8b 45 20             	mov    0x20(%ebp),%eax
    1237:	01 d0                	add    %edx,%eax
    1239:	89 45 fc             	mov    %eax,-0x4(%ebp)
    123c:	8b 55 10             	mov    0x10(%ebp),%edx
    123f:	8b 45 24             	mov    0x24(%ebp),%eax
    1242:	01 d0                	add    %edx,%eax
    1244:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1247:	8b 55 18             	mov    0x18(%ebp),%edx
    124a:	8b 45 20             	mov    0x20(%ebp),%eax
    124d:	01 d0                	add    %edx,%eax
    124f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1252:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1255:	8b 45 24             	mov    0x24(%ebp),%eax
    1258:	01 d0                	add    %edx,%eax
    125a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    125d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1261:	0f 88 51 01 00 00    	js     13b8 <APDcCopy+0x1a1>
    1267:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    126b:	0f 88 47 01 00 00    	js     13b8 <APDcCopy+0x1a1>
    1271:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1275:	0f 88 3d 01 00 00    	js     13b8 <APDcCopy+0x1a1>
    127b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    127f:	0f 88 33 01 00 00    	js     13b8 <APDcCopy+0x1a1>
    1285:	8b 45 14             	mov    0x14(%ebp),%eax
    1288:	8b 00                	mov    (%eax),%eax
    128a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    128d:	0f 8c 25 01 00 00    	jl     13b8 <APDcCopy+0x1a1>
    1293:	8b 45 14             	mov    0x14(%ebp),%eax
    1296:	8b 40 04             	mov    0x4(%eax),%eax
    1299:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    129c:	0f 8c 16 01 00 00    	jl     13b8 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    12a2:	8b 45 08             	mov    0x8(%ebp),%eax
    12a5:	8b 00                	mov    (%eax),%eax
    12a7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    12aa:	7f 0b                	jg     12b7 <APDcCopy+0xa0>
    12ac:	8b 45 08             	mov    0x8(%ebp),%eax
    12af:	8b 00                	mov    (%eax),%eax
    12b1:	83 e8 01             	sub    $0x1,%eax
    12b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    12b7:	8b 45 08             	mov    0x8(%ebp),%eax
    12ba:	8b 40 04             	mov    0x4(%eax),%eax
    12bd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12c0:	7f 0c                	jg     12ce <APDcCopy+0xb7>
    12c2:	8b 45 08             	mov    0x8(%ebp),%eax
    12c5:	8b 40 04             	mov    0x4(%eax),%eax
    12c8:	83 e8 01             	sub    $0x1,%eax
    12cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12ce:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12d5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12e3:	e9 bc 00 00 00       	jmp    13a4 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12e8:	8b 45 08             	mov    0x8(%ebp),%eax
    12eb:	8b 00                	mov    (%eax),%eax
    12ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12f0:	8b 55 10             	mov    0x10(%ebp),%edx
    12f3:	01 ca                	add    %ecx,%edx
    12f5:	0f af d0             	imul   %eax,%edx
    12f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    12fb:	01 d0                	add    %edx,%eax
    12fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1300:	8b 45 14             	mov    0x14(%ebp),%eax
    1303:	8b 00                	mov    (%eax),%eax
    1305:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1308:	8b 55 1c             	mov    0x1c(%ebp),%edx
    130b:	01 ca                	add    %ecx,%edx
    130d:	0f af d0             	imul   %eax,%edx
    1310:	8b 45 18             	mov    0x18(%ebp),%eax
    1313:	01 d0                	add    %edx,%eax
    1315:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1318:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    131f:	eb 74                	jmp    1395 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1321:	8b 45 14             	mov    0x14(%ebp),%eax
    1324:	8b 50 18             	mov    0x18(%eax),%edx
    1327:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    132a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    132d:	01 c8                	add    %ecx,%eax
    132f:	89 c1                	mov    %eax,%ecx
    1331:	89 c8                	mov    %ecx,%eax
    1333:	01 c0                	add    %eax,%eax
    1335:	01 c8                	add    %ecx,%eax
    1337:	01 d0                	add    %edx,%eax
    1339:	0f b7 10             	movzwl (%eax),%edx
    133c:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1340:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1344:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1347:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    134b:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    134f:	38 c2                	cmp    %al,%dl
    1351:	75 18                	jne    136b <APDcCopy+0x154>
    1353:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1357:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    135b:	38 c2                	cmp    %al,%dl
    135d:	75 0c                	jne    136b <APDcCopy+0x154>
    135f:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1363:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1367:	38 c2                	cmp    %al,%dl
    1369:	74 26                	je     1391 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    136b:	8b 45 08             	mov    0x8(%ebp),%eax
    136e:	8b 50 18             	mov    0x18(%eax),%edx
    1371:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1374:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1377:	01 c8                	add    %ecx,%eax
    1379:	89 c1                	mov    %eax,%ecx
    137b:	89 c8                	mov    %ecx,%eax
    137d:	01 c0                	add    %eax,%eax
    137f:	01 c8                	add    %ecx,%eax
    1381:	01 d0                	add    %edx,%eax
    1383:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1387:	66 89 10             	mov    %dx,(%eax)
    138a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    138e:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1391:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1395:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1398:	2b 45 0c             	sub    0xc(%ebp),%eax
    139b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    139e:	7d 81                	jge    1321 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    13a0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13a7:	2b 45 10             	sub    0x10(%ebp),%eax
    13aa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13ad:	0f 8d 35 ff ff ff    	jge    12e8 <APDcCopy+0xd1>
    13b3:	eb 04                	jmp    13b9 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    13b5:	90                   	nop
    13b6:	eb 01                	jmp    13b9 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    13b8:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13b9:	c9                   	leave  
    13ba:	c3                   	ret    

000013bb <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13bb:	55                   	push   %ebp
    13bc:	89 e5                	mov    %esp,%ebp
    13be:	83 ec 1c             	sub    $0x1c,%esp
    13c1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13c4:	8b 55 10             	mov    0x10(%ebp),%edx
    13c7:	8b 45 14             	mov    0x14(%ebp),%eax
    13ca:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13cd:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13d0:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13d3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13d7:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13da:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13de:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13e1:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13e5:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13e8:	8b 45 08             	mov    0x8(%ebp),%eax
    13eb:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13ef:	66 89 10             	mov    %dx,(%eax)
    13f2:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13f6:	88 50 02             	mov    %dl,0x2(%eax)
}
    13f9:	8b 45 08             	mov    0x8(%ebp),%eax
    13fc:	c9                   	leave  
    13fd:	c2 04 00             	ret    $0x4

00001400 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1406:	8b 45 08             	mov    0x8(%ebp),%eax
    1409:	8b 00                	mov    (%eax),%eax
    140b:	83 ec 08             	sub    $0x8,%esp
    140e:	8d 55 0c             	lea    0xc(%ebp),%edx
    1411:	52                   	push   %edx
    1412:	50                   	push   %eax
    1413:	e8 77 ef ff ff       	call   38f <sendMessage>
    1418:	83 c4 10             	add    $0x10,%esp
}
    141b:	90                   	nop
    141c:	c9                   	leave  
    141d:	c3                   	ret    

0000141e <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    141e:	55                   	push   %ebp
    141f:	89 e5                	mov    %esp,%ebp
    1421:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1424:	83 ec 0c             	sub    $0xc,%esp
    1427:	68 98 00 00 00       	push   $0x98
    142c:	e8 38 f3 ff ff       	call   769 <malloc>
    1431:	83 c4 10             	add    $0x10,%esp
    1434:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1437:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    143b:	75 15                	jne    1452 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    143d:	83 ec 04             	sub    $0x4,%esp
    1440:	ff 75 08             	pushl  0x8(%ebp)
    1443:	68 9c 22 00 00       	push   $0x229c
    1448:	6a 01                	push   $0x1
    144a:	e8 47 f0 ff ff       	call   496 <printf>
    144f:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1452:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1455:	05 84 00 00 00       	add    $0x84,%eax
    145a:	83 ec 08             	sub    $0x8,%esp
    145d:	ff 75 08             	pushl  0x8(%ebp)
    1460:	50                   	push   %eax
    1461:	e8 50 ec ff ff       	call   b6 <strcpy>
    1466:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1469:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146c:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1473:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1476:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    147d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1480:	8b 40 3c             	mov    0x3c(%eax),%eax
    1483:	89 c2                	mov    %eax,%edx
    1485:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1488:	8b 40 40             	mov    0x40(%eax),%eax
    148b:	0f af d0             	imul   %eax,%edx
    148e:	89 d0                	mov    %edx,%eax
    1490:	01 c0                	add    %eax,%eax
    1492:	01 d0                	add    %edx,%eax
    1494:	83 ec 0c             	sub    $0xc,%esp
    1497:	50                   	push   %eax
    1498:	e8 cc f2 ff ff       	call   769 <malloc>
    149d:	83 c4 10             	add    $0x10,%esp
    14a0:	89 c2                	mov    %eax,%edx
    14a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a5:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    14a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ab:	8b 40 54             	mov    0x54(%eax),%eax
    14ae:	85 c0                	test   %eax,%eax
    14b0:	75 15                	jne    14c7 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    14b2:	83 ec 04             	sub    $0x4,%esp
    14b5:	ff 75 08             	pushl  0x8(%ebp)
    14b8:	68 bc 22 00 00       	push   $0x22bc
    14bd:	6a 01                	push   $0x1
    14bf:	e8 d2 ef ff ff       	call   496 <printf>
    14c4:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ca:	8b 40 3c             	mov    0x3c(%eax),%eax
    14cd:	89 c2                	mov    %eax,%edx
    14cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d2:	8b 40 40             	mov    0x40(%eax),%eax
    14d5:	0f af d0             	imul   %eax,%edx
    14d8:	89 d0                	mov    %edx,%eax
    14da:	01 c0                	add    %eax,%eax
    14dc:	01 c2                	add    %eax,%edx
    14de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e1:	8b 40 54             	mov    0x54(%eax),%eax
    14e4:	83 ec 04             	sub    $0x4,%esp
    14e7:	52                   	push   %edx
    14e8:	68 ff ff ff 00       	push   $0xffffff
    14ed:	50                   	push   %eax
    14ee:	e8 59 ec ff ff       	call   14c <memset>
    14f3:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f9:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1500:	e8 62 ee ff ff       	call   367 <getpid>
    1505:	89 c2                	mov    %eax,%edx
    1507:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150a:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    150d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1510:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1517:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151a:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	8b 40 58             	mov    0x58(%eax),%eax
    1527:	89 c2                	mov    %eax,%edx
    1529:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152c:	8b 40 5c             	mov    0x5c(%eax),%eax
    152f:	0f af d0             	imul   %eax,%edx
    1532:	89 d0                	mov    %edx,%eax
    1534:	01 c0                	add    %eax,%eax
    1536:	01 d0                	add    %edx,%eax
    1538:	83 ec 0c             	sub    $0xc,%esp
    153b:	50                   	push   %eax
    153c:	e8 28 f2 ff ff       	call   769 <malloc>
    1541:	83 c4 10             	add    $0x10,%esp
    1544:	89 c2                	mov    %eax,%edx
    1546:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1549:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    154c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154f:	8b 40 70             	mov    0x70(%eax),%eax
    1552:	85 c0                	test   %eax,%eax
    1554:	75 15                	jne    156b <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1556:	83 ec 04             	sub    $0x4,%esp
    1559:	ff 75 08             	pushl  0x8(%ebp)
    155c:	68 e0 22 00 00       	push   $0x22e0
    1561:	6a 01                	push   $0x1
    1563:	e8 2e ef ff ff       	call   496 <printf>
    1568:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    156b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1571:	89 c2                	mov    %eax,%edx
    1573:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1576:	8b 40 40             	mov    0x40(%eax),%eax
    1579:	0f af d0             	imul   %eax,%edx
    157c:	89 d0                	mov    %edx,%eax
    157e:	01 c0                	add    %eax,%eax
    1580:	01 c2                	add    %eax,%edx
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	8b 40 54             	mov    0x54(%eax),%eax
    1588:	83 ec 04             	sub    $0x4,%esp
    158b:	52                   	push   %edx
    158c:	68 ff 00 00 00       	push   $0xff
    1591:	50                   	push   %eax
    1592:	e8 b5 eb ff ff       	call   14c <memset>
    1597:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    159a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159d:	8b 55 0c             	mov    0xc(%ebp),%edx
    15a0:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    15a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15a7:	74 49                	je     15f2 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    15a9:	8b 45 10             	mov    0x10(%ebp),%eax
    15ac:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    15b2:	83 ec 0c             	sub    $0xc,%esp
    15b5:	50                   	push   %eax
    15b6:	e8 ae f1 ff ff       	call   769 <malloc>
    15bb:	83 c4 10             	add    $0x10,%esp
    15be:	89 c2                	mov    %eax,%edx
    15c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c3:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c9:	8b 55 10             	mov    0x10(%ebp),%edx
    15cc:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    15d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dc:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e6:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15ed:	e9 8d 00 00 00       	jmp    167f <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f5:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ff:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	8b 40 20             	mov    0x20(%eax),%eax
    160c:	89 c2                	mov    %eax,%edx
    160e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1611:	8b 40 24             	mov    0x24(%eax),%eax
    1614:	0f af d0             	imul   %eax,%edx
    1617:	89 d0                	mov    %edx,%eax
    1619:	01 c0                	add    %eax,%eax
    161b:	01 d0                	add    %edx,%eax
    161d:	83 ec 0c             	sub    $0xc,%esp
    1620:	50                   	push   %eax
    1621:	e8 43 f1 ff ff       	call   769 <malloc>
    1626:	83 c4 10             	add    $0x10,%esp
    1629:	89 c2                	mov    %eax,%edx
    162b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162e:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1631:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1634:	8b 40 38             	mov    0x38(%eax),%eax
    1637:	85 c0                	test   %eax,%eax
    1639:	75 15                	jne    1650 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    163b:	83 ec 04             	sub    $0x4,%esp
    163e:	ff 75 08             	pushl  0x8(%ebp)
    1641:	68 08 23 00 00       	push   $0x2308
    1646:	6a 01                	push   $0x1
    1648:	e8 49 ee ff ff       	call   496 <printf>
    164d:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1650:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1653:	8b 40 20             	mov    0x20(%eax),%eax
    1656:	89 c2                	mov    %eax,%edx
    1658:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165b:	8b 40 24             	mov    0x24(%eax),%eax
    165e:	0f af d0             	imul   %eax,%edx
    1661:	89 d0                	mov    %edx,%eax
    1663:	01 c0                	add    %eax,%eax
    1665:	01 c2                	add    %eax,%edx
    1667:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166a:	8b 40 38             	mov    0x38(%eax),%eax
    166d:	83 ec 04             	sub    $0x4,%esp
    1670:	52                   	push   %edx
    1671:	68 ff ff ff 00       	push   $0xffffff
    1676:	50                   	push   %eax
    1677:	e8 d0 ea ff ff       	call   14c <memset>
    167c:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    167f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1682:	c9                   	leave  
    1683:	c3                   	ret    

00001684 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1684:	55                   	push   %ebp
    1685:	89 e5                	mov    %esp,%ebp
    1687:	57                   	push   %edi
    1688:	56                   	push   %esi
    1689:	53                   	push   %ebx
    168a:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    168d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1690:	83 f8 03             	cmp    $0x3,%eax
    1693:	74 02                	je     1697 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1695:	eb 7c                	jmp    1713 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1697:	8b 45 08             	mov    0x8(%ebp),%eax
    169a:	8b 58 1c             	mov    0x1c(%eax),%ebx
    169d:	8b 45 08             	mov    0x8(%ebp),%eax
    16a0:	8b 48 18             	mov    0x18(%eax),%ecx
    16a3:	8b 45 08             	mov    0x8(%ebp),%eax
    16a6:	8b 50 5c             	mov    0x5c(%eax),%edx
    16a9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ac:	8b 40 58             	mov    0x58(%eax),%eax
    16af:	8b 75 08             	mov    0x8(%ebp),%esi
    16b2:	83 c6 58             	add    $0x58,%esi
    16b5:	83 ec 04             	sub    $0x4,%esp
    16b8:	53                   	push   %ebx
    16b9:	51                   	push   %ecx
    16ba:	6a 00                	push   $0x0
    16bc:	52                   	push   %edx
    16bd:	50                   	push   %eax
    16be:	6a 00                	push   $0x0
    16c0:	6a 00                	push   $0x0
    16c2:	56                   	push   %esi
    16c3:	6a 00                	push   $0x0
    16c5:	6a 00                	push   $0x0
    16c7:	ff 75 08             	pushl  0x8(%ebp)
    16ca:	e8 b8 ec ff ff       	call   387 <paintWindow>
    16cf:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    16d2:	8b 45 08             	mov    0x8(%ebp),%eax
    16d5:	8b 70 1c             	mov    0x1c(%eax),%esi
    16d8:	8b 45 08             	mov    0x8(%ebp),%eax
    16db:	8b 58 18             	mov    0x18(%eax),%ebx
    16de:	8b 45 08             	mov    0x8(%ebp),%eax
    16e1:	8b 48 08             	mov    0x8(%eax),%ecx
    16e4:	8b 45 08             	mov    0x8(%ebp),%eax
    16e7:	8b 50 40             	mov    0x40(%eax),%edx
    16ea:	8b 45 08             	mov    0x8(%ebp),%eax
    16ed:	8b 40 3c             	mov    0x3c(%eax),%eax
    16f0:	8b 7d 08             	mov    0x8(%ebp),%edi
    16f3:	83 c7 3c             	add    $0x3c,%edi
    16f6:	83 ec 04             	sub    $0x4,%esp
    16f9:	56                   	push   %esi
    16fa:	53                   	push   %ebx
    16fb:	51                   	push   %ecx
    16fc:	52                   	push   %edx
    16fd:	50                   	push   %eax
    16fe:	6a 00                	push   $0x0
    1700:	6a 00                	push   $0x0
    1702:	57                   	push   %edi
    1703:	6a 32                	push   $0x32
    1705:	6a 00                	push   $0x0
    1707:	ff 75 08             	pushl  0x8(%ebp)
    170a:	e8 78 ec ff ff       	call   387 <paintWindow>
    170f:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1712:	90                   	nop
        default: break;
            
            
    }
    return False;
    1713:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1718:	8d 65 f4             	lea    -0xc(%ebp),%esp
    171b:	5b                   	pop    %ebx
    171c:	5e                   	pop    %esi
    171d:	5f                   	pop    %edi
    171e:	5d                   	pop    %ebp
    171f:	c3                   	ret    

00001720 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1720:	55                   	push   %ebp
    1721:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1723:	8b 45 0c             	mov    0xc(%ebp),%eax
    1726:	8b 50 08             	mov    0x8(%eax),%edx
    1729:	8b 45 08             	mov    0x8(%ebp),%eax
    172c:	8b 00                	mov    (%eax),%eax
    172e:	39 c2                	cmp    %eax,%edx
    1730:	74 07                	je     1739 <APPreJudge+0x19>
        return False;
    1732:	b8 00 00 00 00       	mov    $0x0,%eax
    1737:	eb 05                	jmp    173e <APPreJudge+0x1e>
    return True;
    1739:	b8 01 00 00 00       	mov    $0x1,%eax
}
    173e:	5d                   	pop    %ebp
    173f:	c3                   	ret    

00001740 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1740:	55                   	push   %ebp
    1741:	89 e5                	mov    %esp,%ebp
    1743:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1746:	8b 45 08             	mov    0x8(%ebp),%eax
    1749:	8b 55 0c             	mov    0xc(%ebp),%edx
    174c:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1752:	83 ec 0c             	sub    $0xc,%esp
    1755:	ff 75 08             	pushl  0x8(%ebp)
    1758:	e8 42 ec ff ff       	call   39f <registWindow>
    175d:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1760:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1767:	8b 45 08             	mov    0x8(%ebp),%eax
    176a:	8b 00                	mov    (%eax),%eax
    176c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    176f:	ff 75 f4             	pushl  -0xc(%ebp)
    1772:	ff 75 f0             	pushl  -0x10(%ebp)
    1775:	ff 75 ec             	pushl  -0x14(%ebp)
    1778:	ff 75 08             	pushl  0x8(%ebp)
    177b:	e8 80 fc ff ff       	call   1400 <APSendMessage>
    1780:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1783:	83 ec 0c             	sub    $0xc,%esp
    1786:	ff 75 08             	pushl  0x8(%ebp)
    1789:	e8 09 ec ff ff       	call   397 <getMessage>
    178e:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1791:	8b 45 08             	mov    0x8(%ebp),%eax
    1794:	83 c0 74             	add    $0x74,%eax
    1797:	83 ec 08             	sub    $0x8,%esp
    179a:	50                   	push   %eax
    179b:	ff 75 08             	pushl  0x8(%ebp)
    179e:	e8 7d ff ff ff       	call   1720 <APPreJudge>
    17a3:	83 c4 10             	add    $0x10,%esp
    17a6:	84 c0                	test   %al,%al
    17a8:	74 1b                	je     17c5 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    17aa:	8b 45 08             	mov    0x8(%ebp),%eax
    17ad:	ff 70 7c             	pushl  0x7c(%eax)
    17b0:	ff 70 78             	pushl  0x78(%eax)
    17b3:	ff 70 74             	pushl  0x74(%eax)
    17b6:	ff 75 08             	pushl  0x8(%ebp)
    17b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    17bc:	ff d0                	call   *%eax
    17be:	83 c4 10             	add    $0x10,%esp
    17c1:	84 c0                	test   %al,%al
    17c3:	75 0c                	jne    17d1 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    17c5:	8b 45 08             	mov    0x8(%ebp),%eax
    17c8:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    17cf:	eb b2                	jmp    1783 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17d1:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17d2:	90                   	nop
    17d3:	c9                   	leave  
    17d4:	c3                   	ret    

000017d5 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17d5:	55                   	push   %ebp
    17d6:	89 e5                	mov    %esp,%ebp
    17d8:	57                   	push   %edi
    17d9:	56                   	push   %esi
    17da:	53                   	push   %ebx
    17db:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17de:	a1 90 29 00 00       	mov    0x2990,%eax
    17e3:	85 c0                	test   %eax,%eax
    17e5:	0f 85 2c 02 00 00    	jne    1a17 <APGridPaint+0x242>
    {
        iconReady = 1;
    17eb:	c7 05 90 29 00 00 01 	movl   $0x1,0x2990
    17f2:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17f5:	8d 45 98             	lea    -0x68(%ebp),%eax
    17f8:	83 ec 08             	sub    $0x8,%esp
    17fb:	68 2f 23 00 00       	push   $0x232f
    1800:	50                   	push   %eax
    1801:	e8 16 f1 ff ff       	call   91c <APLoadBitmap>
    1806:	83 c4 0c             	add    $0xc,%esp
    1809:	8b 45 98             	mov    -0x68(%ebp),%eax
    180c:	a3 b4 29 00 00       	mov    %eax,0x29b4
    1811:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1814:	a3 b8 29 00 00       	mov    %eax,0x29b8
    1819:	8b 45 a0             	mov    -0x60(%ebp),%eax
    181c:	a3 bc 29 00 00       	mov    %eax,0x29bc
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1821:	83 ec 04             	sub    $0x4,%esp
    1824:	ff 35 bc 29 00 00    	pushl  0x29bc
    182a:	ff 35 b8 29 00 00    	pushl  0x29b8
    1830:	ff 35 b4 29 00 00    	pushl  0x29b4
    1836:	e8 1b f3 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    183b:	83 c4 10             	add    $0x10,%esp
    183e:	a3 c0 29 00 00       	mov    %eax,0x29c0
        grid_river = APLoadBitmap ("grid_river.bmp");
    1843:	8d 45 98             	lea    -0x68(%ebp),%eax
    1846:	83 ec 08             	sub    $0x8,%esp
    1849:	68 3d 23 00 00       	push   $0x233d
    184e:	50                   	push   %eax
    184f:	e8 c8 f0 ff ff       	call   91c <APLoadBitmap>
    1854:	83 c4 0c             	add    $0xc,%esp
    1857:	8b 45 98             	mov    -0x68(%ebp),%eax
    185a:	a3 f0 29 00 00       	mov    %eax,0x29f0
    185f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1862:	a3 f4 29 00 00       	mov    %eax,0x29f4
    1867:	8b 45 a0             	mov    -0x60(%ebp),%eax
    186a:	a3 f8 29 00 00       	mov    %eax,0x29f8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    186f:	83 ec 04             	sub    $0x4,%esp
    1872:	ff 35 f8 29 00 00    	pushl  0x29f8
    1878:	ff 35 f4 29 00 00    	pushl  0x29f4
    187e:	ff 35 f0 29 00 00    	pushl  0x29f0
    1884:	e8 cd f2 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1889:	83 c4 10             	add    $0x10,%esp
    188c:	a3 e0 29 00 00       	mov    %eax,0x29e0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1891:	8d 45 98             	lea    -0x68(%ebp),%eax
    1894:	83 ec 08             	sub    $0x8,%esp
    1897:	68 4c 23 00 00       	push   $0x234c
    189c:	50                   	push   %eax
    189d:	e8 7a f0 ff ff       	call   91c <APLoadBitmap>
    18a2:	83 c4 0c             	add    $0xc,%esp
    18a5:	8b 45 98             	mov    -0x68(%ebp),%eax
    18a8:	a3 e4 29 00 00       	mov    %eax,0x29e4
    18ad:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18b0:	a3 e8 29 00 00       	mov    %eax,0x29e8
    18b5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18b8:	a3 ec 29 00 00       	mov    %eax,0x29ec
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    18bd:	83 ec 04             	sub    $0x4,%esp
    18c0:	ff 35 ec 29 00 00    	pushl  0x29ec
    18c6:	ff 35 e8 29 00 00    	pushl  0x29e8
    18cc:	ff 35 e4 29 00 00    	pushl  0x29e4
    18d2:	e8 7f f2 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    18d7:	83 c4 10             	add    $0x10,%esp
    18da:	a3 94 29 00 00       	mov    %eax,0x2994
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18df:	8d 45 98             	lea    -0x68(%ebp),%eax
    18e2:	83 ec 08             	sub    $0x8,%esp
    18e5:	68 5b 23 00 00       	push   $0x235b
    18ea:	50                   	push   %eax
    18eb:	e8 2c f0 ff ff       	call   91c <APLoadBitmap>
    18f0:	83 c4 0c             	add    $0xc,%esp
    18f3:	8b 45 98             	mov    -0x68(%ebp),%eax
    18f6:	a3 c8 29 00 00       	mov    %eax,0x29c8
    18fb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18fe:	a3 cc 29 00 00       	mov    %eax,0x29cc
    1903:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1906:	a3 d0 29 00 00       	mov    %eax,0x29d0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    190b:	83 ec 04             	sub    $0x4,%esp
    190e:	ff 35 d0 29 00 00    	pushl  0x29d0
    1914:	ff 35 cc 29 00 00    	pushl  0x29cc
    191a:	ff 35 c8 29 00 00    	pushl  0x29c8
    1920:	e8 31 f2 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1925:	83 c4 10             	add    $0x10,%esp
    1928:	a3 fc 29 00 00       	mov    %eax,0x29fc
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    192d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1930:	83 ec 08             	sub    $0x8,%esp
    1933:	68 69 23 00 00       	push   $0x2369
    1938:	50                   	push   %eax
    1939:	e8 de ef ff ff       	call   91c <APLoadBitmap>
    193e:	83 c4 0c             	add    $0xc,%esp
    1941:	8b 45 98             	mov    -0x68(%ebp),%eax
    1944:	a3 a4 29 00 00       	mov    %eax,0x29a4
    1949:	8b 45 9c             	mov    -0x64(%ebp),%eax
    194c:	a3 a8 29 00 00       	mov    %eax,0x29a8
    1951:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1954:	a3 ac 29 00 00       	mov    %eax,0x29ac
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1959:	83 ec 04             	sub    $0x4,%esp
    195c:	ff 35 ac 29 00 00    	pushl  0x29ac
    1962:	ff 35 a8 29 00 00    	pushl  0x29a8
    1968:	ff 35 a4 29 00 00    	pushl  0x29a4
    196e:	e8 e3 f1 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1973:	83 c4 10             	add    $0x10,%esp
    1976:	a3 c4 29 00 00       	mov    %eax,0x29c4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    197b:	8d 45 98             	lea    -0x68(%ebp),%eax
    197e:	83 ec 08             	sub    $0x8,%esp
    1981:	68 79 23 00 00       	push   $0x2379
    1986:	50                   	push   %eax
    1987:	e8 90 ef ff ff       	call   91c <APLoadBitmap>
    198c:	83 c4 0c             	add    $0xc,%esp
    198f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1992:	a3 98 29 00 00       	mov    %eax,0x2998
    1997:	8b 45 9c             	mov    -0x64(%ebp),%eax
    199a:	a3 9c 29 00 00       	mov    %eax,0x299c
    199f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19a2:	a3 a0 29 00 00       	mov    %eax,0x29a0
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    19a7:	83 ec 04             	sub    $0x4,%esp
    19aa:	ff 35 a0 29 00 00    	pushl  0x29a0
    19b0:	ff 35 9c 29 00 00    	pushl  0x299c
    19b6:	ff 35 98 29 00 00    	pushl  0x2998
    19bc:	e8 95 f1 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    19c1:	83 c4 10             	add    $0x10,%esp
    19c4:	a3 b0 29 00 00       	mov    %eax,0x29b0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19c9:	8d 45 98             	lea    -0x68(%ebp),%eax
    19cc:	83 ec 08             	sub    $0x8,%esp
    19cf:	68 8b 23 00 00       	push   $0x238b
    19d4:	50                   	push   %eax
    19d5:	e8 42 ef ff ff       	call   91c <APLoadBitmap>
    19da:	83 c4 0c             	add    $0xc,%esp
    19dd:	8b 45 98             	mov    -0x68(%ebp),%eax
    19e0:	a3 d4 29 00 00       	mov    %eax,0x29d4
    19e5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19e8:	a3 d8 29 00 00       	mov    %eax,0x29d8
    19ed:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19f0:	a3 dc 29 00 00       	mov    %eax,0x29dc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19f5:	83 ec 04             	sub    $0x4,%esp
    19f8:	ff 35 dc 29 00 00    	pushl  0x29dc
    19fe:	ff 35 d8 29 00 00    	pushl  0x29d8
    1a04:	ff 35 d4 29 00 00    	pushl  0x29d4
    1a0a:	e8 47 f1 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1a0f:	83 c4 10             	add    $0x10,%esp
    1a12:	a3 00 2a 00 00       	mov    %eax,0x2a00
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a17:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1a:	8b 40 08             	mov    0x8(%eax),%eax
    1a1d:	85 c0                	test   %eax,%eax
    1a1f:	75 17                	jne    1a38 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a21:	83 ec 08             	sub    $0x8,%esp
    1a24:	68 9c 23 00 00       	push   $0x239c
    1a29:	6a 01                	push   $0x1
    1a2b:	e8 66 ea ff ff       	call   496 <printf>
    1a30:	83 c4 10             	add    $0x10,%esp
        return;
    1a33:	e9 a0 04 00 00       	jmp    1ed8 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a38:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3b:	8b 40 10             	mov    0x10(%eax),%eax
    1a3e:	85 c0                	test   %eax,%eax
    1a40:	7e 10                	jle    1a52 <APGridPaint+0x27d>
    1a42:	8b 45 08             	mov    0x8(%ebp),%eax
    1a45:	8b 50 14             	mov    0x14(%eax),%edx
    1a48:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4b:	8b 40 10             	mov    0x10(%eax),%eax
    1a4e:	39 c2                	cmp    %eax,%edx
    1a50:	7c 17                	jl     1a69 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a52:	83 ec 08             	sub    $0x8,%esp
    1a55:	68 c2 23 00 00       	push   $0x23c2
    1a5a:	6a 01                	push   $0x1
    1a5c:	e8 35 ea ff ff       	call   496 <printf>
    1a61:	83 c4 10             	add    $0x10,%esp
        return;
    1a64:	e9 6f 04 00 00       	jmp    1ed8 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a69:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6c:	8b 40 14             	mov    0x14(%eax),%eax
    1a6f:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a75:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a78:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a7b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a7e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a85:	e9 96 03 00 00       	jmp    1e20 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a8a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a91:	e9 7c 03 00 00       	jmp    1e12 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a99:	c1 e0 04             	shl    $0x4,%eax
    1a9c:	89 c2                	mov    %eax,%edx
    1a9e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1aa1:	01 c2                	add    %eax,%edx
    1aa3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1aa6:	01 d0                	add    %edx,%eax
    1aa8:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1aab:	8b 45 08             	mov    0x8(%ebp),%eax
    1aae:	8b 40 0c             	mov    0xc(%eax),%eax
    1ab1:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1ab4:	c1 e2 02             	shl    $0x2,%edx
    1ab7:	01 d0                	add    %edx,%eax
    1ab9:	8b 00                	mov    (%eax),%eax
    1abb:	83 f8 07             	cmp    $0x7,%eax
    1abe:	0f 87 49 03 00 00    	ja     1e0d <APGridPaint+0x638>
    1ac4:	8b 04 85 d8 23 00 00 	mov    0x23d8(,%eax,4),%eax
    1acb:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1acd:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ad0:	6a 0c                	push   $0xc
    1ad2:	6a 0c                	push   $0xc
    1ad4:	6a 0c                	push   $0xc
    1ad6:	50                   	push   %eax
    1ad7:	e8 df f8 ff ff       	call   13bb <RGB>
    1adc:	83 c4 0c             	add    $0xc,%esp
    1adf:	8b 1d c0 29 00 00    	mov    0x29c0,%ebx
    1ae5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ae8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1aeb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1aee:	6b c0 32             	imul   $0x32,%eax,%eax
    1af1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1af4:	8b 45 08             	mov    0x8(%ebp),%eax
    1af7:	8d 78 3c             	lea    0x3c(%eax),%edi
    1afa:	83 ec 0c             	sub    $0xc,%esp
    1afd:	83 ec 04             	sub    $0x4,%esp
    1b00:	89 e0                	mov    %esp,%eax
    1b02:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b06:	66 89 30             	mov    %si,(%eax)
    1b09:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b0d:	88 50 02             	mov    %dl,0x2(%eax)
    1b10:	6a 32                	push   $0x32
    1b12:	6a 32                	push   $0x32
    1b14:	6a 00                	push   $0x0
    1b16:	6a 00                	push   $0x0
    1b18:	53                   	push   %ebx
    1b19:	51                   	push   %ecx
    1b1a:	ff 75 94             	pushl  -0x6c(%ebp)
    1b1d:	57                   	push   %edi
    1b1e:	e8 f4 f6 ff ff       	call   1217 <APDcCopy>
    1b23:	83 c4 30             	add    $0x30,%esp
                    break;
    1b26:	e9 e3 02 00 00       	jmp    1e0e <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b2b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b2e:	6a 69                	push   $0x69
    1b30:	6a 69                	push   $0x69
    1b32:	6a 69                	push   $0x69
    1b34:	50                   	push   %eax
    1b35:	e8 81 f8 ff ff       	call   13bb <RGB>
    1b3a:	83 c4 0c             	add    $0xc,%esp
    1b3d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b41:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b45:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b49:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b4c:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b53:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b56:	6a 69                	push   $0x69
    1b58:	6a 69                	push   $0x69
    1b5a:	6a 69                	push   $0x69
    1b5c:	50                   	push   %eax
    1b5d:	e8 59 f8 ff ff       	call   13bb <RGB>
    1b62:	83 c4 0c             	add    $0xc,%esp
    1b65:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b69:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b6d:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b71:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b74:	8b 45 08             	mov    0x8(%ebp),%eax
    1b77:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b7a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b7d:	ff 75 b0             	pushl  -0x50(%ebp)
    1b80:	ff 75 ac             	pushl  -0x54(%ebp)
    1b83:	52                   	push   %edx
    1b84:	50                   	push   %eax
    1b85:	e8 61 f0 ff ff       	call   beb <APSetPen>
    1b8a:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b90:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b93:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b96:	83 ec 04             	sub    $0x4,%esp
    1b99:	83 ec 04             	sub    $0x4,%esp
    1b9c:	89 e0                	mov    %esp,%eax
    1b9e:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1ba2:	66 89 08             	mov    %cx,(%eax)
    1ba5:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1ba9:	88 48 02             	mov    %cl,0x2(%eax)
    1bac:	53                   	push   %ebx
    1bad:	52                   	push   %edx
    1bae:	e8 71 f0 ff ff       	call   c24 <APSetBrush>
    1bb3:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1bb6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bb9:	6b d0 32             	imul   $0x32,%eax,%edx
    1bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bbf:	6b c0 32             	imul   $0x32,%eax,%eax
    1bc2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bc5:	83 c1 3c             	add    $0x3c,%ecx
    1bc8:	83 ec 0c             	sub    $0xc,%esp
    1bcb:	6a 32                	push   $0x32
    1bcd:	6a 32                	push   $0x32
    1bcf:	52                   	push   %edx
    1bd0:	50                   	push   %eax
    1bd1:	51                   	push   %ecx
    1bd2:	e8 35 f4 ff ff       	call   100c <APDrawRect>
    1bd7:	83 c4 20             	add    $0x20,%esp
                    break;
    1bda:	e9 2f 02 00 00       	jmp    1e0e <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bdf:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1be2:	6a 0c                	push   $0xc
    1be4:	6a 0c                	push   $0xc
    1be6:	6a 0c                	push   $0xc
    1be8:	50                   	push   %eax
    1be9:	e8 cd f7 ff ff       	call   13bb <RGB>
    1bee:	83 c4 0c             	add    $0xc,%esp
    1bf1:	8b 1d 00 2a 00 00    	mov    0x2a00,%ebx
    1bf7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bfa:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bfd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c00:	6b c0 32             	imul   $0x32,%eax,%eax
    1c03:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c06:	8b 45 08             	mov    0x8(%ebp),%eax
    1c09:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c0c:	83 ec 0c             	sub    $0xc,%esp
    1c0f:	83 ec 04             	sub    $0x4,%esp
    1c12:	89 e0                	mov    %esp,%eax
    1c14:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c18:	66 89 30             	mov    %si,(%eax)
    1c1b:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c1f:	88 50 02             	mov    %dl,0x2(%eax)
    1c22:	6a 32                	push   $0x32
    1c24:	6a 32                	push   $0x32
    1c26:	6a 00                	push   $0x0
    1c28:	6a 00                	push   $0x0
    1c2a:	53                   	push   %ebx
    1c2b:	51                   	push   %ecx
    1c2c:	ff 75 94             	pushl  -0x6c(%ebp)
    1c2f:	57                   	push   %edi
    1c30:	e8 e2 f5 ff ff       	call   1217 <APDcCopy>
    1c35:	83 c4 30             	add    $0x30,%esp
                    break;
    1c38:	e9 d1 01 00 00       	jmp    1e0e <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c3d:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c40:	6a 0c                	push   $0xc
    1c42:	6a 0c                	push   $0xc
    1c44:	6a 0c                	push   $0xc
    1c46:	50                   	push   %eax
    1c47:	e8 6f f7 ff ff       	call   13bb <RGB>
    1c4c:	83 c4 0c             	add    $0xc,%esp
    1c4f:	8b 1d e0 29 00 00    	mov    0x29e0,%ebx
    1c55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c58:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c5e:	6b c0 32             	imul   $0x32,%eax,%eax
    1c61:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c64:	8b 45 08             	mov    0x8(%ebp),%eax
    1c67:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c6a:	83 ec 0c             	sub    $0xc,%esp
    1c6d:	83 ec 04             	sub    $0x4,%esp
    1c70:	89 e0                	mov    %esp,%eax
    1c72:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c76:	66 89 30             	mov    %si,(%eax)
    1c79:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c7d:	88 50 02             	mov    %dl,0x2(%eax)
    1c80:	6a 32                	push   $0x32
    1c82:	6a 32                	push   $0x32
    1c84:	6a 00                	push   $0x0
    1c86:	6a 00                	push   $0x0
    1c88:	53                   	push   %ebx
    1c89:	51                   	push   %ecx
    1c8a:	ff 75 94             	pushl  -0x6c(%ebp)
    1c8d:	57                   	push   %edi
    1c8e:	e8 84 f5 ff ff       	call   1217 <APDcCopy>
    1c93:	83 c4 30             	add    $0x30,%esp
                    break;
    1c96:	e9 73 01 00 00       	jmp    1e0e <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c9b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c9e:	6a 0c                	push   $0xc
    1ca0:	6a 0c                	push   $0xc
    1ca2:	6a 0c                	push   $0xc
    1ca4:	50                   	push   %eax
    1ca5:	e8 11 f7 ff ff       	call   13bb <RGB>
    1caa:	83 c4 0c             	add    $0xc,%esp
    1cad:	8b 1d c4 29 00 00    	mov    0x29c4,%ebx
    1cb3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cb6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cb9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cbc:	6b c0 32             	imul   $0x32,%eax,%eax
    1cbf:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cc2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cc8:	83 ec 0c             	sub    $0xc,%esp
    1ccb:	83 ec 04             	sub    $0x4,%esp
    1cce:	89 e0                	mov    %esp,%eax
    1cd0:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cd4:	66 89 30             	mov    %si,(%eax)
    1cd7:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1cdb:	88 50 02             	mov    %dl,0x2(%eax)
    1cde:	6a 32                	push   $0x32
    1ce0:	6a 32                	push   $0x32
    1ce2:	6a 00                	push   $0x0
    1ce4:	6a 00                	push   $0x0
    1ce6:	53                   	push   %ebx
    1ce7:	51                   	push   %ecx
    1ce8:	ff 75 94             	pushl  -0x6c(%ebp)
    1ceb:	57                   	push   %edi
    1cec:	e8 26 f5 ff ff       	call   1217 <APDcCopy>
    1cf1:	83 c4 30             	add    $0x30,%esp
                    break;
    1cf4:	e9 15 01 00 00       	jmp    1e0e <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cf9:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cfc:	6a 0c                	push   $0xc
    1cfe:	6a 0c                	push   $0xc
    1d00:	6a 0c                	push   $0xc
    1d02:	50                   	push   %eax
    1d03:	e8 b3 f6 ff ff       	call   13bb <RGB>
    1d08:	83 c4 0c             	add    $0xc,%esp
    1d0b:	8b 1d fc 29 00 00    	mov    0x29fc,%ebx
    1d11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d14:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d17:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d1a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d1d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d20:	8b 45 08             	mov    0x8(%ebp),%eax
    1d23:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d26:	83 ec 0c             	sub    $0xc,%esp
    1d29:	83 ec 04             	sub    $0x4,%esp
    1d2c:	89 e0                	mov    %esp,%eax
    1d2e:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d32:	66 89 30             	mov    %si,(%eax)
    1d35:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d39:	88 50 02             	mov    %dl,0x2(%eax)
    1d3c:	6a 32                	push   $0x32
    1d3e:	6a 32                	push   $0x32
    1d40:	6a 00                	push   $0x0
    1d42:	6a 00                	push   $0x0
    1d44:	53                   	push   %ebx
    1d45:	51                   	push   %ecx
    1d46:	ff 75 94             	pushl  -0x6c(%ebp)
    1d49:	57                   	push   %edi
    1d4a:	e8 c8 f4 ff ff       	call   1217 <APDcCopy>
    1d4f:	83 c4 30             	add    $0x30,%esp
                    break;
    1d52:	e9 b7 00 00 00       	jmp    1e0e <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d57:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d5a:	6a 0c                	push   $0xc
    1d5c:	6a 0c                	push   $0xc
    1d5e:	6a 0c                	push   $0xc
    1d60:	50                   	push   %eax
    1d61:	e8 55 f6 ff ff       	call   13bb <RGB>
    1d66:	83 c4 0c             	add    $0xc,%esp
    1d69:	8b 1d 94 29 00 00    	mov    0x2994,%ebx
    1d6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d72:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d75:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d78:	6b c0 32             	imul   $0x32,%eax,%eax
    1d7b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d81:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d84:	83 ec 0c             	sub    $0xc,%esp
    1d87:	83 ec 04             	sub    $0x4,%esp
    1d8a:	89 e0                	mov    %esp,%eax
    1d8c:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d90:	66 89 30             	mov    %si,(%eax)
    1d93:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d97:	88 50 02             	mov    %dl,0x2(%eax)
    1d9a:	6a 32                	push   $0x32
    1d9c:	6a 32                	push   $0x32
    1d9e:	6a 00                	push   $0x0
    1da0:	6a 00                	push   $0x0
    1da2:	53                   	push   %ebx
    1da3:	51                   	push   %ecx
    1da4:	ff 75 94             	pushl  -0x6c(%ebp)
    1da7:	57                   	push   %edi
    1da8:	e8 6a f4 ff ff       	call   1217 <APDcCopy>
    1dad:	83 c4 30             	add    $0x30,%esp
                    break;
    1db0:	eb 5c                	jmp    1e0e <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1db2:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1db5:	6a 0c                	push   $0xc
    1db7:	6a 0c                	push   $0xc
    1db9:	6a 0c                	push   $0xc
    1dbb:	50                   	push   %eax
    1dbc:	e8 fa f5 ff ff       	call   13bb <RGB>
    1dc1:	83 c4 0c             	add    $0xc,%esp
    1dc4:	8b 1d b0 29 00 00    	mov    0x29b0,%ebx
    1dca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dcd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dd3:	6b c0 32             	imul   $0x32,%eax,%eax
    1dd6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddc:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ddf:	83 ec 0c             	sub    $0xc,%esp
    1de2:	83 ec 04             	sub    $0x4,%esp
    1de5:	89 e0                	mov    %esp,%eax
    1de7:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1deb:	66 89 30             	mov    %si,(%eax)
    1dee:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1df2:	88 50 02             	mov    %dl,0x2(%eax)
    1df5:	6a 32                	push   $0x32
    1df7:	6a 32                	push   $0x32
    1df9:	6a 00                	push   $0x0
    1dfb:	6a 00                	push   $0x0
    1dfd:	53                   	push   %ebx
    1dfe:	51                   	push   %ecx
    1dff:	ff 75 94             	pushl  -0x6c(%ebp)
    1e02:	57                   	push   %edi
    1e03:	e8 0f f4 ff ff       	call   1217 <APDcCopy>
    1e08:	83 c4 30             	add    $0x30,%esp
                    break;
    1e0b:	eb 01                	jmp    1e0e <APGridPaint+0x639>
                default: break;
    1e0d:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e0e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e12:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e16:	0f 8e 7a fc ff ff    	jle    1a96 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e1c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e20:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e24:	0f 8e 60 fc ff ff    	jle    1a8a <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1e2a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e2d:	68 cd 00 00 00       	push   $0xcd
    1e32:	6a 74                	push   $0x74
    1e34:	6a 18                	push   $0x18
    1e36:	50                   	push   %eax
    1e37:	e8 7f f5 ff ff       	call   13bb <RGB>
    1e3c:	83 c4 0c             	add    $0xc,%esp
    1e3f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e43:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e47:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e4b:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e4e:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e55:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e58:	68 cd 00 00 00       	push   $0xcd
    1e5d:	6a 74                	push   $0x74
    1e5f:	6a 18                	push   $0x18
    1e61:	50                   	push   %eax
    1e62:	e8 54 f5 ff ff       	call   13bb <RGB>
    1e67:	83 c4 0c             	add    $0xc,%esp
    1e6a:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e6e:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e72:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e76:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e79:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7c:	8d 50 58             	lea    0x58(%eax),%edx
    1e7f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e82:	ff 75 bc             	pushl  -0x44(%ebp)
    1e85:	ff 75 b8             	pushl  -0x48(%ebp)
    1e88:	52                   	push   %edx
    1e89:	50                   	push   %eax
    1e8a:	e8 5c ed ff ff       	call   beb <APSetPen>
    1e8f:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e92:	8b 45 08             	mov    0x8(%ebp),%eax
    1e95:	8d 58 58             	lea    0x58(%eax),%ebx
    1e98:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e9b:	83 ec 04             	sub    $0x4,%esp
    1e9e:	83 ec 04             	sub    $0x4,%esp
    1ea1:	89 e0                	mov    %esp,%eax
    1ea3:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1ea7:	66 89 08             	mov    %cx,(%eax)
    1eaa:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1eae:	88 48 02             	mov    %cl,0x2(%eax)
    1eb1:	53                   	push   %ebx
    1eb2:	52                   	push   %edx
    1eb3:	e8 6c ed ff ff       	call   c24 <APSetBrush>
    1eb8:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1ebb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebe:	83 c0 58             	add    $0x58,%eax
    1ec1:	83 ec 0c             	sub    $0xc,%esp
    1ec4:	6a 32                	push   $0x32
    1ec6:	68 20 03 00 00       	push   $0x320
    1ecb:	6a 00                	push   $0x0
    1ecd:	6a 00                	push   $0x0
    1ecf:	50                   	push   %eax
    1ed0:	e8 37 f1 ff ff       	call   100c <APDrawRect>
    1ed5:	83 c4 20             	add    $0x20,%esp
}
    1ed8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1edb:	5b                   	pop    %ebx
    1edc:	5e                   	pop    %esi
    1edd:	5f                   	pop    %edi
    1ede:	5d                   	pop    %ebp
    1edf:	c3                   	ret    

00001ee0 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1ee0:	55                   	push   %ebp
    1ee1:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1ee3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1ee7:	7e 08                	jle    1ef1 <random+0x11>
{
rand_num = seed;
    1ee9:	8b 45 08             	mov    0x8(%ebp),%eax
    1eec:	a3 6c 29 00 00       	mov    %eax,0x296c
}
rand_num *= 3;
    1ef1:	8b 15 6c 29 00 00    	mov    0x296c,%edx
    1ef7:	89 d0                	mov    %edx,%eax
    1ef9:	01 c0                	add    %eax,%eax
    1efb:	01 d0                	add    %edx,%eax
    1efd:	a3 6c 29 00 00       	mov    %eax,0x296c
if (rand_num < 0)
    1f02:	a1 6c 29 00 00       	mov    0x296c,%eax
    1f07:	85 c0                	test   %eax,%eax
    1f09:	79 0c                	jns    1f17 <random+0x37>
{
rand_num *= (-1);
    1f0b:	a1 6c 29 00 00       	mov    0x296c,%eax
    1f10:	f7 d8                	neg    %eax
    1f12:	a3 6c 29 00 00       	mov    %eax,0x296c
}
return rand_num % 997;
    1f17:	8b 0d 6c 29 00 00    	mov    0x296c,%ecx
    1f1d:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1f22:	89 c8                	mov    %ecx,%eax
    1f24:	f7 ea                	imul   %edx
    1f26:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1f29:	c1 f8 09             	sar    $0x9,%eax
    1f2c:	89 c2                	mov    %eax,%edx
    1f2e:	89 c8                	mov    %ecx,%eax
    1f30:	c1 f8 1f             	sar    $0x1f,%eax
    1f33:	29 c2                	sub    %eax,%edx
    1f35:	89 d0                	mov    %edx,%eax
    1f37:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f3d:	29 c1                	sub    %eax,%ecx
    1f3f:	89 c8                	mov    %ecx,%eax
}
    1f41:	5d                   	pop    %ebp
    1f42:	c3                   	ret    

00001f43 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f43:	55                   	push   %ebp
    1f44:	89 e5                	mov    %esp,%ebp
    1f46:	53                   	push   %ebx
    1f47:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f51:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f55:	74 17                	je     1f6e <sprintint+0x2b>
    1f57:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f5b:	79 11                	jns    1f6e <sprintint+0x2b>
        neg = 1;
    1f5d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f64:	8b 45 10             	mov    0x10(%ebp),%eax
    1f67:	f7 d8                	neg    %eax
    1f69:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f6c:	eb 06                	jmp    1f74 <sprintint+0x31>
    } else {
        x = xx;
    1f6e:	8b 45 10             	mov    0x10(%ebp),%eax
    1f71:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f74:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f7b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f7e:	8d 41 01             	lea    0x1(%ecx),%eax
    1f81:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f84:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f87:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f8a:	ba 00 00 00 00       	mov    $0x0,%edx
    1f8f:	f7 f3                	div    %ebx
    1f91:	89 d0                	mov    %edx,%eax
    1f93:	0f b6 80 70 29 00 00 	movzbl 0x2970(%eax),%eax
    1f9a:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f9e:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1fa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fa4:	ba 00 00 00 00       	mov    $0x0,%edx
    1fa9:	f7 f3                	div    %ebx
    1fab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1fae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1fb2:	75 c7                	jne    1f7b <sprintint+0x38>
    if(neg)
    1fb4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fb8:	74 0e                	je     1fc8 <sprintint+0x85>
        buf[i++] = '-';
    1fba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fbd:	8d 50 01             	lea    0x1(%eax),%edx
    1fc0:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1fc3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1fc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fcb:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1fce:	eb 1b                	jmp    1feb <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fd0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fd3:	8b 00                	mov    (%eax),%eax
    1fd5:	8d 48 01             	lea    0x1(%eax),%ecx
    1fd8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fdb:	89 0a                	mov    %ecx,(%edx)
    1fdd:	89 c2                	mov    %eax,%edx
    1fdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe2:	01 d0                	add    %edx,%eax
    1fe4:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fe7:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1feb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fef:	7f df                	jg     1fd0 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ff1:	eb 21                	jmp    2014 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1ff3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ff6:	8b 00                	mov    (%eax),%eax
    1ff8:	8d 48 01             	lea    0x1(%eax),%ecx
    1ffb:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ffe:	89 0a                	mov    %ecx,(%edx)
    2000:	89 c2                	mov    %eax,%edx
    2002:	8b 45 08             	mov    0x8(%ebp),%eax
    2005:	01 c2                	add    %eax,%edx
    2007:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    200a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    200d:	01 c8                	add    %ecx,%eax
    200f:	0f b6 00             	movzbl (%eax),%eax
    2012:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2014:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2018:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    201c:	79 d5                	jns    1ff3 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    201e:	90                   	nop
    201f:	83 c4 20             	add    $0x20,%esp
    2022:	5b                   	pop    %ebx
    2023:	5d                   	pop    %ebp
    2024:	c3                   	ret    

00002025 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2025:	55                   	push   %ebp
    2026:	89 e5                	mov    %esp,%ebp
    2028:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    202b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2032:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2039:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2040:	8d 45 0c             	lea    0xc(%ebp),%eax
    2043:	83 c0 04             	add    $0x4,%eax
    2046:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2049:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2050:	e9 d9 01 00 00       	jmp    222e <sprintf+0x209>
        c = fmt[i] & 0xff;
    2055:	8b 55 0c             	mov    0xc(%ebp),%edx
    2058:	8b 45 ec             	mov    -0x14(%ebp),%eax
    205b:	01 d0                	add    %edx,%eax
    205d:	0f b6 00             	movzbl (%eax),%eax
    2060:	0f be c0             	movsbl %al,%eax
    2063:	25 ff 00 00 00       	and    $0xff,%eax
    2068:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    206b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    206f:	75 2c                	jne    209d <sprintf+0x78>
            if(c == '%'){
    2071:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2075:	75 0c                	jne    2083 <sprintf+0x5e>
                state = '%';
    2077:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    207e:	e9 a7 01 00 00       	jmp    222a <sprintf+0x205>
            } else {
                dst[j++] = c;
    2083:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2086:	8d 50 01             	lea    0x1(%eax),%edx
    2089:	89 55 c8             	mov    %edx,-0x38(%ebp)
    208c:	89 c2                	mov    %eax,%edx
    208e:	8b 45 08             	mov    0x8(%ebp),%eax
    2091:	01 d0                	add    %edx,%eax
    2093:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2096:	88 10                	mov    %dl,(%eax)
    2098:	e9 8d 01 00 00       	jmp    222a <sprintf+0x205>
            }
        } else if(state == '%'){
    209d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    20a1:	0f 85 83 01 00 00    	jne    222a <sprintf+0x205>
            if(c == 'd'){
    20a7:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    20ab:	75 4c                	jne    20f9 <sprintf+0xd4>
                buf[bi] = '\0';
    20ad:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20b3:	01 d0                	add    %edx,%eax
    20b5:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20be:	50                   	push   %eax
    20bf:	e8 91 e1 ff ff       	call   255 <atoi>
    20c4:	83 c4 10             	add    $0x10,%esp
    20c7:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    20ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20d4:	8b 00                	mov    (%eax),%eax
    20d6:	83 ec 08             	sub    $0x8,%esp
    20d9:	ff 75 d8             	pushl  -0x28(%ebp)
    20dc:	6a 01                	push   $0x1
    20de:	6a 0a                	push   $0xa
    20e0:	50                   	push   %eax
    20e1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20e4:	50                   	push   %eax
    20e5:	ff 75 08             	pushl  0x8(%ebp)
    20e8:	e8 56 fe ff ff       	call   1f43 <sprintint>
    20ed:	83 c4 20             	add    $0x20,%esp
                ap++;
    20f0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20f4:	e9 2a 01 00 00       	jmp    2223 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20f9:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20fd:	74 06                	je     2105 <sprintf+0xe0>
    20ff:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2103:	75 4c                	jne    2151 <sprintf+0x12c>
                buf[bi] = '\0';
    2105:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2108:	8b 45 f0             	mov    -0x10(%ebp),%eax
    210b:	01 d0                	add    %edx,%eax
    210d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2110:	83 ec 0c             	sub    $0xc,%esp
    2113:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2116:	50                   	push   %eax
    2117:	e8 39 e1 ff ff       	call   255 <atoi>
    211c:	83 c4 10             	add    $0x10,%esp
    211f:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2122:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2129:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    212c:	8b 00                	mov    (%eax),%eax
    212e:	83 ec 08             	sub    $0x8,%esp
    2131:	ff 75 dc             	pushl  -0x24(%ebp)
    2134:	6a 00                	push   $0x0
    2136:	6a 10                	push   $0x10
    2138:	50                   	push   %eax
    2139:	8d 45 c8             	lea    -0x38(%ebp),%eax
    213c:	50                   	push   %eax
    213d:	ff 75 08             	pushl  0x8(%ebp)
    2140:	e8 fe fd ff ff       	call   1f43 <sprintint>
    2145:	83 c4 20             	add    $0x20,%esp
                ap++;
    2148:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    214c:	e9 d2 00 00 00       	jmp    2223 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2151:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2155:	75 46                	jne    219d <sprintf+0x178>
                s = (char*)*ap;
    2157:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    215a:	8b 00                	mov    (%eax),%eax
    215c:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    215f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2163:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2167:	75 25                	jne    218e <sprintf+0x169>
                    s = "(null)";
    2169:	c7 45 f4 f8 23 00 00 	movl   $0x23f8,-0xc(%ebp)
                while(*s != 0){
    2170:	eb 1c                	jmp    218e <sprintf+0x169>
                    dst[j++] = *s;
    2172:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2175:	8d 50 01             	lea    0x1(%eax),%edx
    2178:	89 55 c8             	mov    %edx,-0x38(%ebp)
    217b:	89 c2                	mov    %eax,%edx
    217d:	8b 45 08             	mov    0x8(%ebp),%eax
    2180:	01 c2                	add    %eax,%edx
    2182:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2185:	0f b6 00             	movzbl (%eax),%eax
    2188:	88 02                	mov    %al,(%edx)
                    s++;
    218a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    218e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2191:	0f b6 00             	movzbl (%eax),%eax
    2194:	84 c0                	test   %al,%al
    2196:	75 da                	jne    2172 <sprintf+0x14d>
    2198:	e9 86 00 00 00       	jmp    2223 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    219d:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    21a1:	75 1d                	jne    21c0 <sprintf+0x19b>
                dst[j++] = *ap;
    21a3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21a6:	8d 50 01             	lea    0x1(%eax),%edx
    21a9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21ac:	89 c2                	mov    %eax,%edx
    21ae:	8b 45 08             	mov    0x8(%ebp),%eax
    21b1:	01 c2                	add    %eax,%edx
    21b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21b6:	8b 00                	mov    (%eax),%eax
    21b8:	88 02                	mov    %al,(%edx)
                ap++;
    21ba:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21be:	eb 63                	jmp    2223 <sprintf+0x1fe>
            } else if(c == '%'){
    21c0:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21c4:	75 17                	jne    21dd <sprintf+0x1b8>
                dst[j++] = c;
    21c6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21c9:	8d 50 01             	lea    0x1(%eax),%edx
    21cc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21cf:	89 c2                	mov    %eax,%edx
    21d1:	8b 45 08             	mov    0x8(%ebp),%eax
    21d4:	01 d0                	add    %edx,%eax
    21d6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21d9:	88 10                	mov    %dl,(%eax)
    21db:	eb 46                	jmp    2223 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21dd:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21e1:	7e 18                	jle    21fb <sprintf+0x1d6>
    21e3:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21e7:	7f 12                	jg     21fb <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21ec:	8d 50 01             	lea    0x1(%eax),%edx
    21ef:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21f5:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21f9:	eb 2f                	jmp    222a <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21fb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21fe:	8d 50 01             	lea    0x1(%eax),%edx
    2201:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2204:	89 c2                	mov    %eax,%edx
    2206:	8b 45 08             	mov    0x8(%ebp),%eax
    2209:	01 d0                	add    %edx,%eax
    220b:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    220e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2211:	8d 50 01             	lea    0x1(%eax),%edx
    2214:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2217:	89 c2                	mov    %eax,%edx
    2219:	8b 45 08             	mov    0x8(%ebp),%eax
    221c:	01 d0                	add    %edx,%eax
    221e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2221:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2223:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    222a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    222e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2231:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2234:	01 d0                	add    %edx,%eax
    2236:	0f b6 00             	movzbl (%eax),%eax
    2239:	84 c0                	test   %al,%al
    223b:	0f 85 14 fe ff ff    	jne    2055 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2241:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2244:	8d 50 01             	lea    0x1(%eax),%edx
    2247:	89 55 c8             	mov    %edx,-0x38(%ebp)
    224a:	89 c2                	mov    %eax,%edx
    224c:	8b 45 08             	mov    0x8(%ebp),%eax
    224f:	01 d0                	add    %edx,%eax
    2251:	c6 00 00             	movb   $0x0,(%eax)
}
    2254:	90                   	nop
    2255:	c9                   	leave  
    2256:	c3                   	ret    
