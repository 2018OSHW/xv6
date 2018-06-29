
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
      1c:	68 04 24 00 00       	push   $0x2404
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
      6f:	68 18 24 00 00       	push   $0x2418
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
     432:	0f b6 80 40 2b 00 00 	movzbl 0x2b40(%eax),%eax
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
     570:	c7 45 f4 31 24 00 00 	movl   $0x2431,-0xc(%ebp)
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
     636:	a1 a0 67 00 00       	mov    0x67a0,%eax
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
     701:	a3 a0 67 00 00       	mov    %eax,0x67a0
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
     762:	a1 a0 67 00 00       	mov    0x67a0,%eax
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
     77e:	a1 a0 67 00 00       	mov    0x67a0,%eax
     783:	89 45 f0             	mov    %eax,-0x10(%ebp)
     786:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     78a:	75 23                	jne    7af <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     78c:	c7 45 f0 98 67 00 00 	movl   $0x6798,-0x10(%ebp)
     793:	8b 45 f0             	mov    -0x10(%ebp),%eax
     796:	a3 a0 67 00 00       	mov    %eax,0x67a0
     79b:	a1 a0 67 00 00       	mov    0x67a0,%eax
     7a0:	a3 98 67 00 00       	mov    %eax,0x6798
    base.s.size = 0;
     7a5:	c7 05 9c 67 00 00 00 	movl   $0x0,0x679c
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
     802:	a3 a0 67 00 00       	mov    %eax,0x67a0
      return (void*)(p + 1);
     807:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80a:	83 c0 08             	add    $0x8,%eax
     80d:	eb 3b                	jmp    84a <malloc+0xe1>
    }
    if(p == freep)
     80f:	a1 a0 67 00 00       	mov    0x67a0,%eax
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
     955:	68 38 24 00 00       	push   $0x2438
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

00000c66 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c66:	55                   	push   %ebp
     c67:	89 e5                	mov    %esp,%ebp
     c69:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6f:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c73:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c77:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c7b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c81:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c85:	66 89 50 13          	mov    %dx,0x13(%eax)
     c89:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c8d:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c90:	8b 45 08             	mov    0x8(%ebp),%eax
     c93:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c97:	66 89 10             	mov    %dx,(%eax)
     c9a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c9e:	88 50 02             	mov    %dl,0x2(%eax)
}
     ca1:	8b 45 08             	mov    0x8(%ebp),%eax
     ca4:	c9                   	leave  
     ca5:	c2 04 00             	ret    $0x4

00000ca8 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     ca8:	55                   	push   %ebp
     ca9:	89 e5                	mov    %esp,%ebp
     cab:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     cae:	8b 45 08             	mov    0x8(%ebp),%eax
     cb1:	8b 40 0c             	mov    0xc(%eax),%eax
     cb4:	89 c2                	mov    %eax,%edx
     cb6:	c1 ea 1f             	shr    $0x1f,%edx
     cb9:	01 d0                	add    %edx,%eax
     cbb:	d1 f8                	sar    %eax
     cbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc3:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cca:	8b 45 10             	mov    0x10(%ebp),%eax
     ccd:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cd0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cd3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cd7:	0f 89 98 00 00 00    	jns    d75 <APDrawPoint+0xcd>
        i = 0;
     cdd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     ce4:	e9 8c 00 00 00       	jmp    d75 <APDrawPoint+0xcd>
    {
        j = x - off;
     ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cec:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cef:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cf2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cf6:	79 69                	jns    d61 <APDrawPoint+0xb9>
            j = 0;
     cf8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cff:	eb 60                	jmp    d61 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d01:	ff 75 fc             	pushl  -0x4(%ebp)
     d04:	ff 75 f8             	pushl  -0x8(%ebp)
     d07:	ff 75 08             	pushl  0x8(%ebp)
     d0a:	e8 bb fb ff ff       	call   8ca <APGetIndex>
     d0f:	83 c4 0c             	add    $0xc,%esp
     d12:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d15:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d19:	74 55                	je     d70 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d1b:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d1f:	74 67                	je     d88 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d21:	ff 75 10             	pushl  0x10(%ebp)
     d24:	ff 75 0c             	pushl  0xc(%ebp)
     d27:	ff 75 fc             	pushl  -0x4(%ebp)
     d2a:	ff 75 f8             	pushl  -0x8(%ebp)
     d2d:	e8 5f fb ff ff       	call   891 <distance_2>
     d32:	83 c4 10             	add    $0x10,%esp
     d35:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d38:	7f 23                	jg     d5d <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d3a:	8b 45 08             	mov    0x8(%ebp),%eax
     d3d:	8b 48 18             	mov    0x18(%eax),%ecx
     d40:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d43:	89 d0                	mov    %edx,%eax
     d45:	01 c0                	add    %eax,%eax
     d47:	01 d0                	add    %edx,%eax
     d49:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d4c:	8b 45 08             	mov    0x8(%ebp),%eax
     d4f:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d53:	66 89 0a             	mov    %cx,(%edx)
     d56:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d5a:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d5d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d61:	8b 55 0c             	mov    0xc(%ebp),%edx
     d64:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d67:	01 d0                	add    %edx,%eax
     d69:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d6c:	7d 93                	jge    d01 <APDrawPoint+0x59>
     d6e:	eb 01                	jmp    d71 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d70:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d71:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d75:	8b 55 10             	mov    0x10(%ebp),%edx
     d78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d7b:	01 d0                	add    %edx,%eax
     d7d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d80:	0f 8d 63 ff ff ff    	jge    ce9 <APDrawPoint+0x41>
     d86:	eb 01                	jmp    d89 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d88:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d89:	c9                   	leave  
     d8a:	c3                   	ret    

00000d8b <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d8b:	55                   	push   %ebp
     d8c:	89 e5                	mov    %esp,%ebp
     d8e:	53                   	push   %ebx
     d8f:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d92:	8b 45 0c             	mov    0xc(%ebp),%eax
     d95:	3b 45 14             	cmp    0x14(%ebp),%eax
     d98:	0f 85 80 00 00 00    	jne    e1e <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d9e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     da2:	0f 88 9d 02 00 00    	js     1045 <APDrawLine+0x2ba>
     da8:	8b 45 08             	mov    0x8(%ebp),%eax
     dab:	8b 00                	mov    (%eax),%eax
     dad:	3b 45 0c             	cmp    0xc(%ebp),%eax
     db0:	0f 8e 8f 02 00 00    	jle    1045 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     db6:	8b 45 10             	mov    0x10(%ebp),%eax
     db9:	3b 45 18             	cmp    0x18(%ebp),%eax
     dbc:	7e 12                	jle    dd0 <APDrawLine+0x45>
        {
            int tmp = y2;
     dbe:	8b 45 18             	mov    0x18(%ebp),%eax
     dc1:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     dc4:	8b 45 10             	mov    0x10(%ebp),%eax
     dc7:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dcd:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     dd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dd4:	79 07                	jns    ddd <APDrawLine+0x52>
     dd6:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     ddd:	8b 45 08             	mov    0x8(%ebp),%eax
     de0:	8b 40 04             	mov    0x4(%eax),%eax
     de3:	3b 45 18             	cmp    0x18(%ebp),%eax
     de6:	7d 0c                	jge    df4 <APDrawLine+0x69>
     de8:	8b 45 08             	mov    0x8(%ebp),%eax
     deb:	8b 40 04             	mov    0x4(%eax),%eax
     dee:	83 e8 01             	sub    $0x1,%eax
     df1:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     df4:	8b 45 10             	mov    0x10(%ebp),%eax
     df7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dfa:	eb 15                	jmp    e11 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dfc:	ff 75 f4             	pushl  -0xc(%ebp)
     dff:	ff 75 0c             	pushl  0xc(%ebp)
     e02:	ff 75 08             	pushl  0x8(%ebp)
     e05:	e8 9e fe ff ff       	call   ca8 <APDrawPoint>
     e0a:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e14:	3b 45 18             	cmp    0x18(%ebp),%eax
     e17:	7e e3                	jle    dfc <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e19:	e9 2b 02 00 00       	jmp    1049 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e1e:	8b 45 10             	mov    0x10(%ebp),%eax
     e21:	3b 45 18             	cmp    0x18(%ebp),%eax
     e24:	75 7f                	jne    ea5 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e2a:	0f 88 18 02 00 00    	js     1048 <APDrawLine+0x2bd>
     e30:	8b 45 08             	mov    0x8(%ebp),%eax
     e33:	8b 40 04             	mov    0x4(%eax),%eax
     e36:	3b 45 10             	cmp    0x10(%ebp),%eax
     e39:	0f 8e 09 02 00 00    	jle    1048 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e42:	3b 45 14             	cmp    0x14(%ebp),%eax
     e45:	7e 12                	jle    e59 <APDrawLine+0xce>
        {
            int tmp = x2;
     e47:	8b 45 14             	mov    0x14(%ebp),%eax
     e4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e4d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e50:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e53:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e56:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e59:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e5d:	79 07                	jns    e66 <APDrawLine+0xdb>
     e5f:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e66:	8b 45 08             	mov    0x8(%ebp),%eax
     e69:	8b 00                	mov    (%eax),%eax
     e6b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e6e:	7d 0b                	jge    e7b <APDrawLine+0xf0>
     e70:	8b 45 08             	mov    0x8(%ebp),%eax
     e73:	8b 00                	mov    (%eax),%eax
     e75:	83 e8 01             	sub    $0x1,%eax
     e78:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e7b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e81:	eb 15                	jmp    e98 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e83:	ff 75 10             	pushl  0x10(%ebp)
     e86:	ff 75 f0             	pushl  -0x10(%ebp)
     e89:	ff 75 08             	pushl  0x8(%ebp)
     e8c:	e8 17 fe ff ff       	call   ca8 <APDrawPoint>
     e91:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e94:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e98:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e9b:	3b 45 14             	cmp    0x14(%ebp),%eax
     e9e:	7e e3                	jle    e83 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     ea0:	e9 a4 01 00 00       	jmp    1049 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ea5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     eac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb6:	2b 45 14             	sub    0x14(%ebp),%eax
     eb9:	50                   	push   %eax
     eba:	e8 fb f9 ff ff       	call   8ba <abs_int>
     ebf:	83 c4 04             	add    $0x4,%esp
     ec2:	89 c3                	mov    %eax,%ebx
     ec4:	8b 45 10             	mov    0x10(%ebp),%eax
     ec7:	2b 45 18             	sub    0x18(%ebp),%eax
     eca:	50                   	push   %eax
     ecb:	e8 ea f9 ff ff       	call   8ba <abs_int>
     ed0:	83 c4 04             	add    $0x4,%esp
     ed3:	39 c3                	cmp    %eax,%ebx
     ed5:	0f 8e b5 00 00 00    	jle    f90 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     edb:	8b 45 10             	mov    0x10(%ebp),%eax
     ede:	2b 45 18             	sub    0x18(%ebp),%eax
     ee1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee4:	db 45 b0             	fildl  -0x50(%ebp)
     ee7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eea:	2b 45 14             	sub    0x14(%ebp),%eax
     eed:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ef0:	db 45 b0             	fildl  -0x50(%ebp)
     ef3:	de f9                	fdivrp %st,%st(1)
     ef5:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     ef8:	8b 45 14             	mov    0x14(%ebp),%eax
     efb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     efe:	7e 0e                	jle    f0e <APDrawLine+0x183>
        {
            s = x1;
     f00:	8b 45 0c             	mov    0xc(%ebp),%eax
     f03:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f06:	8b 45 14             	mov    0x14(%ebp),%eax
     f09:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f0c:	eb 0c                	jmp    f1a <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f0e:	8b 45 14             	mov    0x14(%ebp),%eax
     f11:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f14:	8b 45 0c             	mov    0xc(%ebp),%eax
     f17:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f1a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f1e:	79 07                	jns    f27 <APDrawLine+0x19c>
     f20:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f27:	8b 45 08             	mov    0x8(%ebp),%eax
     f2a:	8b 00                	mov    (%eax),%eax
     f2c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f2f:	7f 0b                	jg     f3c <APDrawLine+0x1b1>
     f31:	8b 45 08             	mov    0x8(%ebp),%eax
     f34:	8b 00                	mov    (%eax),%eax
     f36:	83 e8 01             	sub    $0x1,%eax
     f39:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f42:	eb 3f                	jmp    f83 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f47:	2b 45 0c             	sub    0xc(%ebp),%eax
     f4a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f4d:	db 45 b0             	fildl  -0x50(%ebp)
     f50:	dc 4d d0             	fmull  -0x30(%ebp)
     f53:	db 45 10             	fildl  0x10(%ebp)
     f56:	de c1                	faddp  %st,%st(1)
     f58:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f5b:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f5f:	b4 0c                	mov    $0xc,%ah
     f61:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f65:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f68:	db 5d cc             	fistpl -0x34(%ebp)
     f6b:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f6e:	ff 75 cc             	pushl  -0x34(%ebp)
     f71:	ff 75 e4             	pushl  -0x1c(%ebp)
     f74:	ff 75 08             	pushl  0x8(%ebp)
     f77:	e8 2c fd ff ff       	call   ca8 <APDrawPoint>
     f7c:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f7f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f86:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f89:	7e b9                	jle    f44 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f8b:	e9 b9 00 00 00       	jmp    1049 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f90:	8b 45 0c             	mov    0xc(%ebp),%eax
     f93:	2b 45 14             	sub    0x14(%ebp),%eax
     f96:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f99:	db 45 b0             	fildl  -0x50(%ebp)
     f9c:	8b 45 10             	mov    0x10(%ebp),%eax
     f9f:	2b 45 18             	sub    0x18(%ebp),%eax
     fa2:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa5:	db 45 b0             	fildl  -0x50(%ebp)
     fa8:	de f9                	fdivrp %st,%st(1)
     faa:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fad:	8b 45 10             	mov    0x10(%ebp),%eax
     fb0:	3b 45 18             	cmp    0x18(%ebp),%eax
     fb3:	7e 0e                	jle    fc3 <APDrawLine+0x238>
    {
        s = y2;
     fb5:	8b 45 18             	mov    0x18(%ebp),%eax
     fb8:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fbb:	8b 45 10             	mov    0x10(%ebp),%eax
     fbe:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fc1:	eb 0c                	jmp    fcf <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fc3:	8b 45 10             	mov    0x10(%ebp),%eax
     fc6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fc9:	8b 45 18             	mov    0x18(%ebp),%eax
     fcc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fcf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fd3:	79 07                	jns    fdc <APDrawLine+0x251>
     fd5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fdc:	8b 45 08             	mov    0x8(%ebp),%eax
     fdf:	8b 40 04             	mov    0x4(%eax),%eax
     fe2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fe5:	7f 0c                	jg     ff3 <APDrawLine+0x268>
     fe7:	8b 45 08             	mov    0x8(%ebp),%eax
     fea:	8b 40 04             	mov    0x4(%eax),%eax
     fed:	83 e8 01             	sub    $0x1,%eax
     ff0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     ff3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ff6:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ff9:	eb 3f                	jmp    103a <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     ffb:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ffe:	2b 45 10             	sub    0x10(%ebp),%eax
    1001:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1004:	db 45 b0             	fildl  -0x50(%ebp)
    1007:	dc 4d c0             	fmull  -0x40(%ebp)
    100a:	db 45 0c             	fildl  0xc(%ebp)
    100d:	de c1                	faddp  %st,%st(1)
    100f:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1012:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1016:	b4 0c                	mov    $0xc,%ah
    1018:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    101c:	d9 6d b4             	fldcw  -0x4c(%ebp)
    101f:	db 5d bc             	fistpl -0x44(%ebp)
    1022:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1025:	ff 75 e0             	pushl  -0x20(%ebp)
    1028:	ff 75 bc             	pushl  -0x44(%ebp)
    102b:	ff 75 08             	pushl  0x8(%ebp)
    102e:	e8 75 fc ff ff       	call   ca8 <APDrawPoint>
    1033:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1036:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    103a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    103d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1040:	7e b9                	jle    ffb <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1042:	90                   	nop
    1043:	eb 04                	jmp    1049 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1045:	90                   	nop
    1046:	eb 01                	jmp    1049 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1048:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1049:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    104c:	c9                   	leave  
    104d:	c3                   	ret    

0000104e <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    104e:	55                   	push   %ebp
    104f:	89 e5                	mov    %esp,%ebp
    1051:	53                   	push   %ebx
    1052:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1055:	8b 55 10             	mov    0x10(%ebp),%edx
    1058:	8b 45 18             	mov    0x18(%ebp),%eax
    105b:	01 d0                	add    %edx,%eax
    105d:	83 e8 01             	sub    $0x1,%eax
    1060:	83 ec 04             	sub    $0x4,%esp
    1063:	50                   	push   %eax
    1064:	ff 75 0c             	pushl  0xc(%ebp)
    1067:	ff 75 10             	pushl  0x10(%ebp)
    106a:	ff 75 0c             	pushl  0xc(%ebp)
    106d:	ff 75 08             	pushl  0x8(%ebp)
    1070:	e8 16 fd ff ff       	call   d8b <APDrawLine>
    1075:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1078:	8b 55 0c             	mov    0xc(%ebp),%edx
    107b:	8b 45 14             	mov    0x14(%ebp),%eax
    107e:	01 d0                	add    %edx,%eax
    1080:	83 e8 01             	sub    $0x1,%eax
    1083:	83 ec 04             	sub    $0x4,%esp
    1086:	ff 75 10             	pushl  0x10(%ebp)
    1089:	50                   	push   %eax
    108a:	ff 75 10             	pushl  0x10(%ebp)
    108d:	ff 75 0c             	pushl  0xc(%ebp)
    1090:	ff 75 08             	pushl  0x8(%ebp)
    1093:	e8 f3 fc ff ff       	call   d8b <APDrawLine>
    1098:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    109b:	8b 55 10             	mov    0x10(%ebp),%edx
    109e:	8b 45 18             	mov    0x18(%ebp),%eax
    10a1:	01 d0                	add    %edx,%eax
    10a3:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10a6:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a9:	8b 45 14             	mov    0x14(%ebp),%eax
    10ac:	01 d0                	add    %edx,%eax
    10ae:	8d 50 ff             	lea    -0x1(%eax),%edx
    10b1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10b4:	8b 45 14             	mov    0x14(%ebp),%eax
    10b7:	01 d8                	add    %ebx,%eax
    10b9:	83 e8 01             	sub    $0x1,%eax
    10bc:	83 ec 04             	sub    $0x4,%esp
    10bf:	51                   	push   %ecx
    10c0:	52                   	push   %edx
    10c1:	ff 75 10             	pushl  0x10(%ebp)
    10c4:	50                   	push   %eax
    10c5:	ff 75 08             	pushl  0x8(%ebp)
    10c8:	e8 be fc ff ff       	call   d8b <APDrawLine>
    10cd:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10d0:	8b 55 10             	mov    0x10(%ebp),%edx
    10d3:	8b 45 18             	mov    0x18(%ebp),%eax
    10d6:	01 d0                	add    %edx,%eax
    10d8:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10db:	8b 55 0c             	mov    0xc(%ebp),%edx
    10de:	8b 45 14             	mov    0x14(%ebp),%eax
    10e1:	01 d0                	add    %edx,%eax
    10e3:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e6:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10e9:	8b 45 18             	mov    0x18(%ebp),%eax
    10ec:	01 d8                	add    %ebx,%eax
    10ee:	83 e8 01             	sub    $0x1,%eax
    10f1:	83 ec 04             	sub    $0x4,%esp
    10f4:	51                   	push   %ecx
    10f5:	52                   	push   %edx
    10f6:	50                   	push   %eax
    10f7:	ff 75 0c             	pushl  0xc(%ebp)
    10fa:	ff 75 08             	pushl  0x8(%ebp)
    10fd:	e8 89 fc ff ff       	call   d8b <APDrawLine>
    1102:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1105:	8b 55 0c             	mov    0xc(%ebp),%edx
    1108:	8b 45 14             	mov    0x14(%ebp),%eax
    110b:	01 d0                	add    %edx,%eax
    110d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1110:	8b 45 08             	mov    0x8(%ebp),%eax
    1113:	8b 40 0c             	mov    0xc(%eax),%eax
    1116:	89 c1                	mov    %eax,%ecx
    1118:	c1 e9 1f             	shr    $0x1f,%ecx
    111b:	01 c8                	add    %ecx,%eax
    111d:	d1 f8                	sar    %eax
    111f:	29 c2                	sub    %eax,%edx
    1121:	89 d0                	mov    %edx,%eax
    1123:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1126:	8b 55 10             	mov    0x10(%ebp),%edx
    1129:	8b 45 18             	mov    0x18(%ebp),%eax
    112c:	01 d0                	add    %edx,%eax
    112e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1131:	8b 45 08             	mov    0x8(%ebp),%eax
    1134:	8b 40 0c             	mov    0xc(%eax),%eax
    1137:	89 c1                	mov    %eax,%ecx
    1139:	c1 e9 1f             	shr    $0x1f,%ecx
    113c:	01 c8                	add    %ecx,%eax
    113e:	d1 f8                	sar    %eax
    1140:	29 c2                	sub    %eax,%edx
    1142:	89 d0                	mov    %edx,%eax
    1144:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1147:	8b 45 08             	mov    0x8(%ebp),%eax
    114a:	8b 40 0c             	mov    0xc(%eax),%eax
    114d:	89 c2                	mov    %eax,%edx
    114f:	c1 ea 1f             	shr    $0x1f,%edx
    1152:	01 d0                	add    %edx,%eax
    1154:	d1 f8                	sar    %eax
    1156:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
    115c:	8b 40 0c             	mov    0xc(%eax),%eax
    115f:	89 c2                	mov    %eax,%edx
    1161:	c1 ea 1f             	shr    $0x1f,%edx
    1164:	01 d0                	add    %edx,%eax
    1166:	d1 f8                	sar    %eax
    1168:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    116b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    116f:	0f 88 d8 00 00 00    	js     124d <APDrawRect+0x1ff>
    1175:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1179:	0f 88 ce 00 00 00    	js     124d <APDrawRect+0x1ff>
    117f:	8b 45 08             	mov    0x8(%ebp),%eax
    1182:	8b 00                	mov    (%eax),%eax
    1184:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1187:	0f 8e c0 00 00 00    	jle    124d <APDrawRect+0x1ff>
    118d:	8b 45 08             	mov    0x8(%ebp),%eax
    1190:	8b 40 04             	mov    0x4(%eax),%eax
    1193:	3b 45 10             	cmp    0x10(%ebp),%eax
    1196:	0f 8e b1 00 00 00    	jle    124d <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    119c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11a0:	79 07                	jns    11a9 <APDrawRect+0x15b>
    11a2:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11ad:	79 07                	jns    11b6 <APDrawRect+0x168>
    11af:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11b6:	8b 45 08             	mov    0x8(%ebp),%eax
    11b9:	8b 00                	mov    (%eax),%eax
    11bb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11be:	7f 0b                	jg     11cb <APDrawRect+0x17d>
    11c0:	8b 45 08             	mov    0x8(%ebp),%eax
    11c3:	8b 00                	mov    (%eax),%eax
    11c5:	83 e8 01             	sub    $0x1,%eax
    11c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11cb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ce:	8b 40 04             	mov    0x4(%eax),%eax
    11d1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11d4:	7f 0c                	jg     11e2 <APDrawRect+0x194>
    11d6:	8b 45 08             	mov    0x8(%ebp),%eax
    11d9:	8b 40 04             	mov    0x4(%eax),%eax
    11dc:	83 e8 01             	sub    $0x1,%eax
    11df:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11e2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11ef:	eb 52                	jmp    1243 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11f1:	8b 45 10             	mov    0x10(%ebp),%eax
    11f4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11f7:	eb 3e                	jmp    1237 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11f9:	83 ec 04             	sub    $0x4,%esp
    11fc:	ff 75 e8             	pushl  -0x18(%ebp)
    11ff:	ff 75 ec             	pushl  -0x14(%ebp)
    1202:	ff 75 08             	pushl  0x8(%ebp)
    1205:	e8 c0 f6 ff ff       	call   8ca <APGetIndex>
    120a:	83 c4 10             	add    $0x10,%esp
    120d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1210:	8b 45 08             	mov    0x8(%ebp),%eax
    1213:	8b 48 18             	mov    0x18(%eax),%ecx
    1216:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1219:	89 d0                	mov    %edx,%eax
    121b:	01 c0                	add    %eax,%eax
    121d:	01 d0                	add    %edx,%eax
    121f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1222:	8b 45 08             	mov    0x8(%ebp),%eax
    1225:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1229:	66 89 0a             	mov    %cx,(%edx)
    122c:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1230:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1233:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1237:	8b 45 e8             	mov    -0x18(%ebp),%eax
    123a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    123d:	7e ba                	jle    11f9 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    123f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1243:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1246:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1249:	7e a6                	jle    11f1 <APDrawRect+0x1a3>
    124b:	eb 01                	jmp    124e <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    124d:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    124e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1251:	c9                   	leave  
    1252:	c3                   	ret    

00001253 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1253:	55                   	push   %ebp
    1254:	89 e5                	mov    %esp,%ebp
    1256:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1259:	83 ec 0c             	sub    $0xc,%esp
    125c:	ff 75 0c             	pushl  0xc(%ebp)
    125f:	e8 c1 ee ff ff       	call   125 <strlen>
    1264:	83 c4 10             	add    $0x10,%esp
    1267:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    126a:	8b 45 08             	mov    0x8(%ebp),%eax
    126d:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1271:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1275:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1279:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    127c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1283:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    128a:	e9 bc 00 00 00       	jmp    134b <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    128f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1292:	8b 45 0c             	mov    0xc(%ebp),%eax
    1295:	01 d0                	add    %edx,%eax
    1297:	0f b6 00             	movzbl (%eax),%eax
    129a:	0f be c0             	movsbl %al,%eax
    129d:	83 e8 20             	sub    $0x20,%eax
    12a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    12a3:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    12a7:	0f 87 9a 00 00 00    	ja     1347 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
    12b0:	8b 00                	mov    (%eax),%eax
    12b2:	0f af 45 14          	imul   0x14(%ebp),%eax
    12b6:	89 c2                	mov    %eax,%edx
    12b8:	8b 45 10             	mov    0x10(%ebp),%eax
    12bb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12be:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12c1:	89 d0                	mov    %edx,%eax
    12c3:	c1 e0 03             	shl    $0x3,%eax
    12c6:	01 d0                	add    %edx,%eax
    12c8:	01 c8                	add    %ecx,%eax
    12ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12d4:	eb 6b                	jmp    1341 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12d6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12dd:	eb 50                	jmp    132f <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12df:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12e2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12e5:	89 d0                	mov    %edx,%eax
    12e7:	c1 e0 03             	shl    $0x3,%eax
    12ea:	01 d0                	add    %edx,%eax
    12ec:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    12f2:	01 c2                	add    %eax,%edx
    12f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12f7:	01 d0                	add    %edx,%eax
    12f9:	05 60 2b 00 00       	add    $0x2b60,%eax
    12fe:	0f b6 00             	movzbl (%eax),%eax
    1301:	84 c0                	test   %al,%al
    1303:	74 26                	je     132b <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1305:	8b 45 08             	mov    0x8(%ebp),%eax
    1308:	8b 50 18             	mov    0x18(%eax),%edx
    130b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    130e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1311:	01 c8                	add    %ecx,%eax
    1313:	89 c1                	mov    %eax,%ecx
    1315:	89 c8                	mov    %ecx,%eax
    1317:	01 c0                	add    %eax,%eax
    1319:	01 c8                	add    %ecx,%eax
    131b:	01 d0                	add    %edx,%eax
    131d:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1321:	66 89 10             	mov    %dx,(%eax)
    1324:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1328:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    132b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    132f:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1333:	7e aa                	jle    12df <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1335:	8b 45 08             	mov    0x8(%ebp),%eax
    1338:	8b 00                	mov    (%eax),%eax
    133a:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    133d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1341:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1345:	7e 8f                	jle    12d6 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1347:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    134b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    134e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1351:	0f 82 38 ff ff ff    	jb     128f <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1357:	90                   	nop
    1358:	c9                   	leave  
    1359:	c3                   	ret    

0000135a <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    135a:	55                   	push   %ebp
    135b:	89 e5                	mov    %esp,%ebp
    135d:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1360:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1364:	0f 88 8e 01 00 00    	js     14f8 <APDcCopy+0x19e>
    136a:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    136e:	0f 88 84 01 00 00    	js     14f8 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1374:	8b 55 0c             	mov    0xc(%ebp),%edx
    1377:	8b 45 20             	mov    0x20(%ebp),%eax
    137a:	01 d0                	add    %edx,%eax
    137c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    137f:	8b 55 10             	mov    0x10(%ebp),%edx
    1382:	8b 45 24             	mov    0x24(%ebp),%eax
    1385:	01 d0                	add    %edx,%eax
    1387:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    138a:	8b 55 18             	mov    0x18(%ebp),%edx
    138d:	8b 45 20             	mov    0x20(%ebp),%eax
    1390:	01 d0                	add    %edx,%eax
    1392:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1395:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1398:	8b 45 24             	mov    0x24(%ebp),%eax
    139b:	01 d0                	add    %edx,%eax
    139d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    13a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13a4:	0f 88 51 01 00 00    	js     14fb <APDcCopy+0x1a1>
    13aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13ae:	0f 88 47 01 00 00    	js     14fb <APDcCopy+0x1a1>
    13b4:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    13b8:	0f 88 3d 01 00 00    	js     14fb <APDcCopy+0x1a1>
    13be:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13c2:	0f 88 33 01 00 00    	js     14fb <APDcCopy+0x1a1>
    13c8:	8b 45 14             	mov    0x14(%ebp),%eax
    13cb:	8b 00                	mov    (%eax),%eax
    13cd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13d0:	0f 8c 25 01 00 00    	jl     14fb <APDcCopy+0x1a1>
    13d6:	8b 45 14             	mov    0x14(%ebp),%eax
    13d9:	8b 40 04             	mov    0x4(%eax),%eax
    13dc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13df:	0f 8c 16 01 00 00    	jl     14fb <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13e5:	8b 45 08             	mov    0x8(%ebp),%eax
    13e8:	8b 00                	mov    (%eax),%eax
    13ea:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13ed:	7f 0b                	jg     13fa <APDcCopy+0xa0>
    13ef:	8b 45 08             	mov    0x8(%ebp),%eax
    13f2:	8b 00                	mov    (%eax),%eax
    13f4:	83 e8 01             	sub    $0x1,%eax
    13f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13fa:	8b 45 08             	mov    0x8(%ebp),%eax
    13fd:	8b 40 04             	mov    0x4(%eax),%eax
    1400:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1403:	7f 0c                	jg     1411 <APDcCopy+0xb7>
    1405:	8b 45 08             	mov    0x8(%ebp),%eax
    1408:	8b 40 04             	mov    0x4(%eax),%eax
    140b:	83 e8 01             	sub    $0x1,%eax
    140e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1411:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1418:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    141f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1426:	e9 bc 00 00 00       	jmp    14e7 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    142b:	8b 45 08             	mov    0x8(%ebp),%eax
    142e:	8b 00                	mov    (%eax),%eax
    1430:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1433:	8b 55 10             	mov    0x10(%ebp),%edx
    1436:	01 ca                	add    %ecx,%edx
    1438:	0f af d0             	imul   %eax,%edx
    143b:	8b 45 0c             	mov    0xc(%ebp),%eax
    143e:	01 d0                	add    %edx,%eax
    1440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1443:	8b 45 14             	mov    0x14(%ebp),%eax
    1446:	8b 00                	mov    (%eax),%eax
    1448:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    144b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    144e:	01 ca                	add    %ecx,%edx
    1450:	0f af d0             	imul   %eax,%edx
    1453:	8b 45 18             	mov    0x18(%ebp),%eax
    1456:	01 d0                	add    %edx,%eax
    1458:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    145b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1462:	eb 74                	jmp    14d8 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1464:	8b 45 14             	mov    0x14(%ebp),%eax
    1467:	8b 50 18             	mov    0x18(%eax),%edx
    146a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    146d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1470:	01 c8                	add    %ecx,%eax
    1472:	89 c1                	mov    %eax,%ecx
    1474:	89 c8                	mov    %ecx,%eax
    1476:	01 c0                	add    %eax,%eax
    1478:	01 c8                	add    %ecx,%eax
    147a:	01 d0                	add    %edx,%eax
    147c:	0f b7 10             	movzwl (%eax),%edx
    147f:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1483:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1487:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    148a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    148e:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1492:	38 c2                	cmp    %al,%dl
    1494:	75 18                	jne    14ae <APDcCopy+0x154>
    1496:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    149a:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    149e:	38 c2                	cmp    %al,%dl
    14a0:	75 0c                	jne    14ae <APDcCopy+0x154>
    14a2:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    14a6:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    14aa:	38 c2                	cmp    %al,%dl
    14ac:	74 26                	je     14d4 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    14ae:	8b 45 08             	mov    0x8(%ebp),%eax
    14b1:	8b 50 18             	mov    0x18(%eax),%edx
    14b4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    14b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ba:	01 c8                	add    %ecx,%eax
    14bc:	89 c1                	mov    %eax,%ecx
    14be:	89 c8                	mov    %ecx,%eax
    14c0:	01 c0                	add    %eax,%eax
    14c2:	01 c8                	add    %ecx,%eax
    14c4:	01 d0                	add    %edx,%eax
    14c6:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14ca:	66 89 10             	mov    %dx,(%eax)
    14cd:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14d1:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14d4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14db:	2b 45 0c             	sub    0xc(%ebp),%eax
    14de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14e1:	7d 81                	jge    1464 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14ea:	2b 45 10             	sub    0x10(%ebp),%eax
    14ed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14f0:	0f 8d 35 ff ff ff    	jge    142b <APDcCopy+0xd1>
    14f6:	eb 04                	jmp    14fc <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14f8:	90                   	nop
    14f9:	eb 01                	jmp    14fc <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14fb:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14fc:	c9                   	leave  
    14fd:	c3                   	ret    

000014fe <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14fe:	55                   	push   %ebp
    14ff:	89 e5                	mov    %esp,%ebp
    1501:	83 ec 1c             	sub    $0x1c,%esp
    1504:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1507:	8b 55 10             	mov    0x10(%ebp),%edx
    150a:	8b 45 14             	mov    0x14(%ebp),%eax
    150d:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1510:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1513:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1516:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    151a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    151d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1521:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1524:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1528:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    152b:	8b 45 08             	mov    0x8(%ebp),%eax
    152e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1532:	66 89 10             	mov    %dx,(%eax)
    1535:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1539:	88 50 02             	mov    %dl,0x2(%eax)
}
    153c:	8b 45 08             	mov    0x8(%ebp),%eax
    153f:	c9                   	leave  
    1540:	c2 04 00             	ret    $0x4

00001543 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1543:	55                   	push   %ebp
    1544:	89 e5                	mov    %esp,%ebp
    1546:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1549:	8b 45 08             	mov    0x8(%ebp),%eax
    154c:	8b 00                	mov    (%eax),%eax
    154e:	83 ec 08             	sub    $0x8,%esp
    1551:	8d 55 0c             	lea    0xc(%ebp),%edx
    1554:	52                   	push   %edx
    1555:	50                   	push   %eax
    1556:	e8 34 ee ff ff       	call   38f <sendMessage>
    155b:	83 c4 10             	add    $0x10,%esp
}
    155e:	90                   	nop
    155f:	c9                   	leave  
    1560:	c3                   	ret    

00001561 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1561:	55                   	push   %ebp
    1562:	89 e5                	mov    %esp,%ebp
    1564:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1567:	83 ec 0c             	sub    $0xc,%esp
    156a:	68 98 00 00 00       	push   $0x98
    156f:	e8 f5 f1 ff ff       	call   769 <malloc>
    1574:	83 c4 10             	add    $0x10,%esp
    1577:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    157a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    157e:	75 15                	jne    1595 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1580:	83 ec 04             	sub    $0x4,%esp
    1583:	ff 75 08             	pushl  0x8(%ebp)
    1586:	68 48 24 00 00       	push   $0x2448
    158b:	6a 01                	push   $0x1
    158d:	e8 04 ef ff ff       	call   496 <printf>
    1592:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1595:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1598:	05 84 00 00 00       	add    $0x84,%eax
    159d:	83 ec 08             	sub    $0x8,%esp
    15a0:	ff 75 08             	pushl  0x8(%ebp)
    15a3:	50                   	push   %eax
    15a4:	e8 0d eb ff ff       	call   b6 <strcpy>
    15a9:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    15ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15af:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    15b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b9:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c3:	8b 40 3c             	mov    0x3c(%eax),%eax
    15c6:	89 c2                	mov    %eax,%edx
    15c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cb:	8b 40 40             	mov    0x40(%eax),%eax
    15ce:	0f af d0             	imul   %eax,%edx
    15d1:	89 d0                	mov    %edx,%eax
    15d3:	01 c0                	add    %eax,%eax
    15d5:	01 d0                	add    %edx,%eax
    15d7:	83 ec 0c             	sub    $0xc,%esp
    15da:	50                   	push   %eax
    15db:	e8 89 f1 ff ff       	call   769 <malloc>
    15e0:	83 c4 10             	add    $0x10,%esp
    15e3:	89 c2                	mov    %eax,%edx
    15e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e8:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ee:	8b 40 54             	mov    0x54(%eax),%eax
    15f1:	85 c0                	test   %eax,%eax
    15f3:	75 15                	jne    160a <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15f5:	83 ec 04             	sub    $0x4,%esp
    15f8:	ff 75 08             	pushl  0x8(%ebp)
    15fb:	68 68 24 00 00       	push   $0x2468
    1600:	6a 01                	push   $0x1
    1602:	e8 8f ee ff ff       	call   496 <printf>
    1607:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    160a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160d:	8b 40 3c             	mov    0x3c(%eax),%eax
    1610:	89 c2                	mov    %eax,%edx
    1612:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1615:	8b 40 40             	mov    0x40(%eax),%eax
    1618:	0f af d0             	imul   %eax,%edx
    161b:	89 d0                	mov    %edx,%eax
    161d:	01 c0                	add    %eax,%eax
    161f:	01 c2                	add    %eax,%edx
    1621:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1624:	8b 40 54             	mov    0x54(%eax),%eax
    1627:	83 ec 04             	sub    $0x4,%esp
    162a:	52                   	push   %edx
    162b:	68 ff ff ff 00       	push   $0xffffff
    1630:	50                   	push   %eax
    1631:	e8 16 eb ff ff       	call   14c <memset>
    1636:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1643:	e8 1f ed ff ff       	call   367 <getpid>
    1648:	89 c2                	mov    %eax,%edx
    164a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164d:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1650:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1653:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    165a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165d:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1664:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1667:	8b 40 58             	mov    0x58(%eax),%eax
    166a:	89 c2                	mov    %eax,%edx
    166c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166f:	8b 40 5c             	mov    0x5c(%eax),%eax
    1672:	0f af d0             	imul   %eax,%edx
    1675:	89 d0                	mov    %edx,%eax
    1677:	01 c0                	add    %eax,%eax
    1679:	01 d0                	add    %edx,%eax
    167b:	83 ec 0c             	sub    $0xc,%esp
    167e:	50                   	push   %eax
    167f:	e8 e5 f0 ff ff       	call   769 <malloc>
    1684:	83 c4 10             	add    $0x10,%esp
    1687:	89 c2                	mov    %eax,%edx
    1689:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168c:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1692:	8b 40 70             	mov    0x70(%eax),%eax
    1695:	85 c0                	test   %eax,%eax
    1697:	75 15                	jne    16ae <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1699:	83 ec 04             	sub    $0x4,%esp
    169c:	ff 75 08             	pushl  0x8(%ebp)
    169f:	68 8c 24 00 00       	push   $0x248c
    16a4:	6a 01                	push   $0x1
    16a6:	e8 eb ed ff ff       	call   496 <printf>
    16ab:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b1:	8b 40 3c             	mov    0x3c(%eax),%eax
    16b4:	89 c2                	mov    %eax,%edx
    16b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b9:	8b 40 40             	mov    0x40(%eax),%eax
    16bc:	0f af d0             	imul   %eax,%edx
    16bf:	89 d0                	mov    %edx,%eax
    16c1:	01 c0                	add    %eax,%eax
    16c3:	01 c2                	add    %eax,%edx
    16c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c8:	8b 40 54             	mov    0x54(%eax),%eax
    16cb:	83 ec 04             	sub    $0x4,%esp
    16ce:	52                   	push   %edx
    16cf:	68 ff 00 00 00       	push   $0xff
    16d4:	50                   	push   %eax
    16d5:	e8 72 ea ff ff       	call   14c <memset>
    16da:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    16e3:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16ea:	74 49                	je     1735 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16ec:	8b 45 10             	mov    0x10(%ebp),%eax
    16ef:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16f5:	83 ec 0c             	sub    $0xc,%esp
    16f8:	50                   	push   %eax
    16f9:	e8 6b f0 ff ff       	call   769 <malloc>
    16fe:	83 c4 10             	add    $0x10,%esp
    1701:	89 c2                	mov    %eax,%edx
    1703:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1706:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1709:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170c:	8b 55 10             	mov    0x10(%ebp),%edx
    170f:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1712:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1715:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    171c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171f:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1726:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1729:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1730:	e9 8d 00 00 00       	jmp    17c2 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1735:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1738:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    173f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1742:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1749:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174c:	8b 40 20             	mov    0x20(%eax),%eax
    174f:	89 c2                	mov    %eax,%edx
    1751:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1754:	8b 40 24             	mov    0x24(%eax),%eax
    1757:	0f af d0             	imul   %eax,%edx
    175a:	89 d0                	mov    %edx,%eax
    175c:	01 c0                	add    %eax,%eax
    175e:	01 d0                	add    %edx,%eax
    1760:	83 ec 0c             	sub    $0xc,%esp
    1763:	50                   	push   %eax
    1764:	e8 00 f0 ff ff       	call   769 <malloc>
    1769:	83 c4 10             	add    $0x10,%esp
    176c:	89 c2                	mov    %eax,%edx
    176e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1771:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1774:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1777:	8b 40 38             	mov    0x38(%eax),%eax
    177a:	85 c0                	test   %eax,%eax
    177c:	75 15                	jne    1793 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    177e:	83 ec 04             	sub    $0x4,%esp
    1781:	ff 75 08             	pushl  0x8(%ebp)
    1784:	68 b4 24 00 00       	push   $0x24b4
    1789:	6a 01                	push   $0x1
    178b:	e8 06 ed ff ff       	call   496 <printf>
    1790:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1793:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1796:	8b 40 20             	mov    0x20(%eax),%eax
    1799:	89 c2                	mov    %eax,%edx
    179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179e:	8b 40 24             	mov    0x24(%eax),%eax
    17a1:	0f af d0             	imul   %eax,%edx
    17a4:	89 d0                	mov    %edx,%eax
    17a6:	01 c0                	add    %eax,%eax
    17a8:	01 c2                	add    %eax,%edx
    17aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ad:	8b 40 38             	mov    0x38(%eax),%eax
    17b0:	83 ec 04             	sub    $0x4,%esp
    17b3:	52                   	push   %edx
    17b4:	68 ff ff ff 00       	push   $0xffffff
    17b9:	50                   	push   %eax
    17ba:	e8 8d e9 ff ff       	call   14c <memset>
    17bf:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17c5:	c9                   	leave  
    17c6:	c3                   	ret    

000017c7 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17c7:	55                   	push   %ebp
    17c8:	89 e5                	mov    %esp,%ebp
    17ca:	57                   	push   %edi
    17cb:	56                   	push   %esi
    17cc:	53                   	push   %ebx
    17cd:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    17d3:	83 f8 03             	cmp    $0x3,%eax
    17d6:	74 02                	je     17da <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17d8:	eb 7c                	jmp    1856 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17da:	8b 45 08             	mov    0x8(%ebp),%eax
    17dd:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17e0:	8b 45 08             	mov    0x8(%ebp),%eax
    17e3:	8b 48 18             	mov    0x18(%eax),%ecx
    17e6:	8b 45 08             	mov    0x8(%ebp),%eax
    17e9:	8b 50 5c             	mov    0x5c(%eax),%edx
    17ec:	8b 45 08             	mov    0x8(%ebp),%eax
    17ef:	8b 40 58             	mov    0x58(%eax),%eax
    17f2:	8b 75 08             	mov    0x8(%ebp),%esi
    17f5:	83 c6 58             	add    $0x58,%esi
    17f8:	83 ec 04             	sub    $0x4,%esp
    17fb:	53                   	push   %ebx
    17fc:	51                   	push   %ecx
    17fd:	6a 00                	push   $0x0
    17ff:	52                   	push   %edx
    1800:	50                   	push   %eax
    1801:	6a 00                	push   $0x0
    1803:	6a 00                	push   $0x0
    1805:	56                   	push   %esi
    1806:	6a 00                	push   $0x0
    1808:	6a 00                	push   $0x0
    180a:	ff 75 08             	pushl  0x8(%ebp)
    180d:	e8 75 eb ff ff       	call   387 <paintWindow>
    1812:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1815:	8b 45 08             	mov    0x8(%ebp),%eax
    1818:	8b 70 1c             	mov    0x1c(%eax),%esi
    181b:	8b 45 08             	mov    0x8(%ebp),%eax
    181e:	8b 58 18             	mov    0x18(%eax),%ebx
    1821:	8b 45 08             	mov    0x8(%ebp),%eax
    1824:	8b 48 08             	mov    0x8(%eax),%ecx
    1827:	8b 45 08             	mov    0x8(%ebp),%eax
    182a:	8b 50 40             	mov    0x40(%eax),%edx
    182d:	8b 45 08             	mov    0x8(%ebp),%eax
    1830:	8b 40 3c             	mov    0x3c(%eax),%eax
    1833:	8b 7d 08             	mov    0x8(%ebp),%edi
    1836:	83 c7 3c             	add    $0x3c,%edi
    1839:	83 ec 04             	sub    $0x4,%esp
    183c:	56                   	push   %esi
    183d:	53                   	push   %ebx
    183e:	51                   	push   %ecx
    183f:	52                   	push   %edx
    1840:	50                   	push   %eax
    1841:	6a 00                	push   $0x0
    1843:	6a 00                	push   $0x0
    1845:	57                   	push   %edi
    1846:	6a 32                	push   $0x32
    1848:	6a 00                	push   $0x0
    184a:	ff 75 08             	pushl  0x8(%ebp)
    184d:	e8 35 eb ff ff       	call   387 <paintWindow>
    1852:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1855:	90                   	nop
        default: break;
            
            
    }
    return False;
    1856:	b8 00 00 00 00       	mov    $0x0,%eax
}
    185b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    185e:	5b                   	pop    %ebx
    185f:	5e                   	pop    %esi
    1860:	5f                   	pop    %edi
    1861:	5d                   	pop    %ebp
    1862:	c3                   	ret    

00001863 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1863:	55                   	push   %ebp
    1864:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1866:	8b 45 0c             	mov    0xc(%ebp),%eax
    1869:	8b 50 08             	mov    0x8(%eax),%edx
    186c:	8b 45 08             	mov    0x8(%ebp),%eax
    186f:	8b 00                	mov    (%eax),%eax
    1871:	39 c2                	cmp    %eax,%edx
    1873:	74 07                	je     187c <APPreJudge+0x19>
        return False;
    1875:	b8 00 00 00 00       	mov    $0x0,%eax
    187a:	eb 05                	jmp    1881 <APPreJudge+0x1e>
    return True;
    187c:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1881:	5d                   	pop    %ebp
    1882:	c3                   	ret    

00001883 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1883:	55                   	push   %ebp
    1884:	89 e5                	mov    %esp,%ebp
    1886:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1889:	8b 45 08             	mov    0x8(%ebp),%eax
    188c:	8b 55 0c             	mov    0xc(%ebp),%edx
    188f:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1895:	83 ec 0c             	sub    $0xc,%esp
    1898:	ff 75 08             	pushl  0x8(%ebp)
    189b:	e8 ff ea ff ff       	call   39f <registWindow>
    18a0:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    18a3:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    18aa:	8b 45 08             	mov    0x8(%ebp),%eax
    18ad:	8b 00                	mov    (%eax),%eax
    18af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    18b2:	ff 75 f4             	pushl  -0xc(%ebp)
    18b5:	ff 75 f0             	pushl  -0x10(%ebp)
    18b8:	ff 75 ec             	pushl  -0x14(%ebp)
    18bb:	ff 75 08             	pushl  0x8(%ebp)
    18be:	e8 80 fc ff ff       	call   1543 <APSendMessage>
    18c3:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18c6:	83 ec 0c             	sub    $0xc,%esp
    18c9:	ff 75 08             	pushl  0x8(%ebp)
    18cc:	e8 c6 ea ff ff       	call   397 <getMessage>
    18d1:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18d4:	8b 45 08             	mov    0x8(%ebp),%eax
    18d7:	83 c0 74             	add    $0x74,%eax
    18da:	83 ec 08             	sub    $0x8,%esp
    18dd:	50                   	push   %eax
    18de:	ff 75 08             	pushl  0x8(%ebp)
    18e1:	e8 7d ff ff ff       	call   1863 <APPreJudge>
    18e6:	83 c4 10             	add    $0x10,%esp
    18e9:	84 c0                	test   %al,%al
    18eb:	74 1b                	je     1908 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    18ed:	8b 45 08             	mov    0x8(%ebp),%eax
    18f0:	ff 70 7c             	pushl  0x7c(%eax)
    18f3:	ff 70 78             	pushl  0x78(%eax)
    18f6:	ff 70 74             	pushl  0x74(%eax)
    18f9:	ff 75 08             	pushl  0x8(%ebp)
    18fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ff:	ff d0                	call   *%eax
    1901:	83 c4 10             	add    $0x10,%esp
    1904:	84 c0                	test   %al,%al
    1906:	75 0c                	jne    1914 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1908:	8b 45 08             	mov    0x8(%ebp),%eax
    190b:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1912:	eb b2                	jmp    18c6 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1914:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1915:	90                   	nop
    1916:	c9                   	leave  
    1917:	c3                   	ret    

00001918 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1918:	55                   	push   %ebp
    1919:	89 e5                	mov    %esp,%ebp
    191b:	57                   	push   %edi
    191c:	56                   	push   %esi
    191d:	53                   	push   %ebx
    191e:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1921:	a1 a4 67 00 00       	mov    0x67a4,%eax
    1926:	85 c0                	test   %eax,%eax
    1928:	0f 85 2c 02 00 00    	jne    1b5a <APGridPaint+0x242>
    {
        iconReady = 1;
    192e:	c7 05 a4 67 00 00 01 	movl   $0x1,0x67a4
    1935:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1938:	8d 45 88             	lea    -0x78(%ebp),%eax
    193b:	83 ec 08             	sub    $0x8,%esp
    193e:	68 db 24 00 00       	push   $0x24db
    1943:	50                   	push   %eax
    1944:	e8 d3 ef ff ff       	call   91c <APLoadBitmap>
    1949:	83 c4 0c             	add    $0xc,%esp
    194c:	8b 45 88             	mov    -0x78(%ebp),%eax
    194f:	a3 c8 67 00 00       	mov    %eax,0x67c8
    1954:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1957:	a3 cc 67 00 00       	mov    %eax,0x67cc
    195c:	8b 45 90             	mov    -0x70(%ebp),%eax
    195f:	a3 d0 67 00 00       	mov    %eax,0x67d0
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1964:	83 ec 04             	sub    $0x4,%esp
    1967:	ff 35 d0 67 00 00    	pushl  0x67d0
    196d:	ff 35 cc 67 00 00    	pushl  0x67cc
    1973:	ff 35 c8 67 00 00    	pushl  0x67c8
    1979:	e8 d8 f1 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    197e:	83 c4 10             	add    $0x10,%esp
    1981:	a3 d4 67 00 00       	mov    %eax,0x67d4
        grid_river = APLoadBitmap ("grid_river.bmp");
    1986:	8d 45 88             	lea    -0x78(%ebp),%eax
    1989:	83 ec 08             	sub    $0x8,%esp
    198c:	68 e9 24 00 00       	push   $0x24e9
    1991:	50                   	push   %eax
    1992:	e8 85 ef ff ff       	call   91c <APLoadBitmap>
    1997:	83 c4 0c             	add    $0xc,%esp
    199a:	8b 45 88             	mov    -0x78(%ebp),%eax
    199d:	a3 04 68 00 00       	mov    %eax,0x6804
    19a2:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19a5:	a3 08 68 00 00       	mov    %eax,0x6808
    19aa:	8b 45 90             	mov    -0x70(%ebp),%eax
    19ad:	a3 0c 68 00 00       	mov    %eax,0x680c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    19b2:	83 ec 04             	sub    $0x4,%esp
    19b5:	ff 35 0c 68 00 00    	pushl  0x680c
    19bb:	ff 35 08 68 00 00    	pushl  0x6808
    19c1:	ff 35 04 68 00 00    	pushl  0x6804
    19c7:	e8 8a f1 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    19cc:	83 c4 10             	add    $0x10,%esp
    19cf:	a3 f4 67 00 00       	mov    %eax,0x67f4
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19d4:	8d 45 88             	lea    -0x78(%ebp),%eax
    19d7:	83 ec 08             	sub    $0x8,%esp
    19da:	68 f8 24 00 00       	push   $0x24f8
    19df:	50                   	push   %eax
    19e0:	e8 37 ef ff ff       	call   91c <APLoadBitmap>
    19e5:	83 c4 0c             	add    $0xc,%esp
    19e8:	8b 45 88             	mov    -0x78(%ebp),%eax
    19eb:	a3 f8 67 00 00       	mov    %eax,0x67f8
    19f0:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19f3:	a3 fc 67 00 00       	mov    %eax,0x67fc
    19f8:	8b 45 90             	mov    -0x70(%ebp),%eax
    19fb:	a3 00 68 00 00       	mov    %eax,0x6800
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a00:	83 ec 04             	sub    $0x4,%esp
    1a03:	ff 35 00 68 00 00    	pushl  0x6800
    1a09:	ff 35 fc 67 00 00    	pushl  0x67fc
    1a0f:	ff 35 f8 67 00 00    	pushl  0x67f8
    1a15:	e8 3c f1 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1a1a:	83 c4 10             	add    $0x10,%esp
    1a1d:	a3 a8 67 00 00       	mov    %eax,0x67a8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a22:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a25:	83 ec 08             	sub    $0x8,%esp
    1a28:	68 07 25 00 00       	push   $0x2507
    1a2d:	50                   	push   %eax
    1a2e:	e8 e9 ee ff ff       	call   91c <APLoadBitmap>
    1a33:	83 c4 0c             	add    $0xc,%esp
    1a36:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a39:	a3 dc 67 00 00       	mov    %eax,0x67dc
    1a3e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a41:	a3 e0 67 00 00       	mov    %eax,0x67e0
    1a46:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a49:	a3 e4 67 00 00       	mov    %eax,0x67e4
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a4e:	83 ec 04             	sub    $0x4,%esp
    1a51:	ff 35 e4 67 00 00    	pushl  0x67e4
    1a57:	ff 35 e0 67 00 00    	pushl  0x67e0
    1a5d:	ff 35 dc 67 00 00    	pushl  0x67dc
    1a63:	e8 ee f0 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1a68:	83 c4 10             	add    $0x10,%esp
    1a6b:	a3 10 68 00 00       	mov    %eax,0x6810
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a70:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a73:	83 ec 08             	sub    $0x8,%esp
    1a76:	68 15 25 00 00       	push   $0x2515
    1a7b:	50                   	push   %eax
    1a7c:	e8 9b ee ff ff       	call   91c <APLoadBitmap>
    1a81:	83 c4 0c             	add    $0xc,%esp
    1a84:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a87:	a3 b8 67 00 00       	mov    %eax,0x67b8
    1a8c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a8f:	a3 bc 67 00 00       	mov    %eax,0x67bc
    1a94:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a97:	a3 c0 67 00 00       	mov    %eax,0x67c0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a9c:	83 ec 04             	sub    $0x4,%esp
    1a9f:	ff 35 c0 67 00 00    	pushl  0x67c0
    1aa5:	ff 35 bc 67 00 00    	pushl  0x67bc
    1aab:	ff 35 b8 67 00 00    	pushl  0x67b8
    1ab1:	e8 a0 f0 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1ab6:	83 c4 10             	add    $0x10,%esp
    1ab9:	a3 d8 67 00 00       	mov    %eax,0x67d8
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1abe:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ac1:	83 ec 08             	sub    $0x8,%esp
    1ac4:	68 25 25 00 00       	push   $0x2525
    1ac9:	50                   	push   %eax
    1aca:	e8 4d ee ff ff       	call   91c <APLoadBitmap>
    1acf:	83 c4 0c             	add    $0xc,%esp
    1ad2:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ad5:	a3 ac 67 00 00       	mov    %eax,0x67ac
    1ada:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1add:	a3 b0 67 00 00       	mov    %eax,0x67b0
    1ae2:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ae5:	a3 b4 67 00 00       	mov    %eax,0x67b4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1aea:	83 ec 04             	sub    $0x4,%esp
    1aed:	ff 35 b4 67 00 00    	pushl  0x67b4
    1af3:	ff 35 b0 67 00 00    	pushl  0x67b0
    1af9:	ff 35 ac 67 00 00    	pushl  0x67ac
    1aff:	e8 52 f0 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1b04:	83 c4 10             	add    $0x10,%esp
    1b07:	a3 c4 67 00 00       	mov    %eax,0x67c4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b0c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b0f:	83 ec 08             	sub    $0x8,%esp
    1b12:	68 37 25 00 00       	push   $0x2537
    1b17:	50                   	push   %eax
    1b18:	e8 ff ed ff ff       	call   91c <APLoadBitmap>
    1b1d:	83 c4 0c             	add    $0xc,%esp
    1b20:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b23:	a3 e8 67 00 00       	mov    %eax,0x67e8
    1b28:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b2b:	a3 ec 67 00 00       	mov    %eax,0x67ec
    1b30:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b33:	a3 f0 67 00 00       	mov    %eax,0x67f0
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b38:	83 ec 04             	sub    $0x4,%esp
    1b3b:	ff 35 f0 67 00 00    	pushl  0x67f0
    1b41:	ff 35 ec 67 00 00    	pushl  0x67ec
    1b47:	ff 35 e8 67 00 00    	pushl  0x67e8
    1b4d:	e8 04 f0 ff ff       	call   b56 <APCreateCompatibleDCFromBitmap>
    1b52:	83 c4 10             	add    $0x10,%esp
    1b55:	a3 14 68 00 00       	mov    %eax,0x6814
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5d:	8b 40 08             	mov    0x8(%eax),%eax
    1b60:	85 c0                	test   %eax,%eax
    1b62:	75 17                	jne    1b7b <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b64:	83 ec 08             	sub    $0x8,%esp
    1b67:	68 48 25 00 00       	push   $0x2548
    1b6c:	6a 01                	push   $0x1
    1b6e:	e8 23 e9 ff ff       	call   496 <printf>
    1b73:	83 c4 10             	add    $0x10,%esp
        return;
    1b76:	e9 07 05 00 00       	jmp    2082 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7e:	8b 40 10             	mov    0x10(%eax),%eax
    1b81:	85 c0                	test   %eax,%eax
    1b83:	7e 10                	jle    1b95 <APGridPaint+0x27d>
    1b85:	8b 45 08             	mov    0x8(%ebp),%eax
    1b88:	8b 50 14             	mov    0x14(%eax),%edx
    1b8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8e:	8b 40 10             	mov    0x10(%eax),%eax
    1b91:	39 c2                	cmp    %eax,%edx
    1b93:	7c 17                	jl     1bac <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b95:	83 ec 08             	sub    $0x8,%esp
    1b98:	68 6e 25 00 00       	push   $0x256e
    1b9d:	6a 01                	push   $0x1
    1b9f:	e8 f2 e8 ff ff       	call   496 <printf>
    1ba4:	83 c4 10             	add    $0x10,%esp
        return;
    1ba7:	e9 d6 04 00 00       	jmp    2082 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1bac:	8b 45 08             	mov    0x8(%ebp),%eax
    1baf:	8b 40 14             	mov    0x14(%eax),%eax
    1bb2:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1bb8:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1bbb:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1bbe:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1bc1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1bc8:	e9 96 03 00 00       	jmp    1f63 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1bcd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1bd4:	e9 7c 03 00 00       	jmp    1f55 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bd9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bdc:	c1 e0 04             	shl    $0x4,%eax
    1bdf:	89 c2                	mov    %eax,%edx
    1be1:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1be4:	01 c2                	add    %eax,%edx
    1be6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1be9:	01 d0                	add    %edx,%eax
    1beb:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1bee:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf1:	8b 40 0c             	mov    0xc(%eax),%eax
    1bf4:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1bf7:	c1 e2 02             	shl    $0x2,%edx
    1bfa:	01 d0                	add    %edx,%eax
    1bfc:	8b 00                	mov    (%eax),%eax
    1bfe:	83 f8 07             	cmp    $0x7,%eax
    1c01:	0f 87 49 03 00 00    	ja     1f50 <APGridPaint+0x638>
    1c07:	8b 04 85 84 25 00 00 	mov    0x2584(,%eax,4),%eax
    1c0e:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c10:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1c13:	6a 0c                	push   $0xc
    1c15:	6a 0c                	push   $0xc
    1c17:	6a 0c                	push   $0xc
    1c19:	50                   	push   %eax
    1c1a:	e8 df f8 ff ff       	call   14fe <RGB>
    1c1f:	83 c4 0c             	add    $0xc,%esp
    1c22:	8b 1d d4 67 00 00    	mov    0x67d4,%ebx
    1c28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c2b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c31:	6b c0 32             	imul   $0x32,%eax,%eax
    1c34:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1c37:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c3d:	83 ec 0c             	sub    $0xc,%esp
    1c40:	83 ec 04             	sub    $0x4,%esp
    1c43:	89 e0                	mov    %esp,%eax
    1c45:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c49:	66 89 30             	mov    %si,(%eax)
    1c4c:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c50:	88 50 02             	mov    %dl,0x2(%eax)
    1c53:	6a 32                	push   $0x32
    1c55:	6a 32                	push   $0x32
    1c57:	6a 00                	push   $0x0
    1c59:	6a 00                	push   $0x0
    1c5b:	53                   	push   %ebx
    1c5c:	51                   	push   %ecx
    1c5d:	ff 75 84             	pushl  -0x7c(%ebp)
    1c60:	57                   	push   %edi
    1c61:	e8 f4 f6 ff ff       	call   135a <APDcCopy>
    1c66:	83 c4 30             	add    $0x30,%esp
                    break;
    1c69:	e9 e3 02 00 00       	jmp    1f51 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c6e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c71:	6a 69                	push   $0x69
    1c73:	6a 69                	push   $0x69
    1c75:	6a 69                	push   $0x69
    1c77:	50                   	push   %eax
    1c78:	e8 81 f8 ff ff       	call   14fe <RGB>
    1c7d:	83 c4 0c             	add    $0xc,%esp
    1c80:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c84:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1c88:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c8c:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1c8f:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c96:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c99:	6a 69                	push   $0x69
    1c9b:	6a 69                	push   $0x69
    1c9d:	6a 69                	push   $0x69
    1c9f:	50                   	push   %eax
    1ca0:	e8 59 f8 ff ff       	call   14fe <RGB>
    1ca5:	83 c4 0c             	add    $0xc,%esp
    1ca8:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1cac:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1cb0:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1cb4:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1cb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cba:	8d 50 3c             	lea    0x3c(%eax),%edx
    1cbd:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cc0:	ff 75 ac             	pushl  -0x54(%ebp)
    1cc3:	ff 75 a8             	pushl  -0x58(%ebp)
    1cc6:	52                   	push   %edx
    1cc7:	50                   	push   %eax
    1cc8:	e8 1e ef ff ff       	call   beb <APSetPen>
    1ccd:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1cd0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd3:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1cd6:	8d 55 88             	lea    -0x78(%ebp),%edx
    1cd9:	83 ec 04             	sub    $0x4,%esp
    1cdc:	83 ec 04             	sub    $0x4,%esp
    1cdf:	89 e0                	mov    %esp,%eax
    1ce1:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1ce5:	66 89 08             	mov    %cx,(%eax)
    1ce8:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1cec:	88 48 02             	mov    %cl,0x2(%eax)
    1cef:	53                   	push   %ebx
    1cf0:	52                   	push   %edx
    1cf1:	e8 2e ef ff ff       	call   c24 <APSetBrush>
    1cf6:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1cf9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cfc:	6b d0 32             	imul   $0x32,%eax,%edx
    1cff:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d02:	6b c0 32             	imul   $0x32,%eax,%eax
    1d05:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d08:	83 c1 3c             	add    $0x3c,%ecx
    1d0b:	83 ec 0c             	sub    $0xc,%esp
    1d0e:	6a 32                	push   $0x32
    1d10:	6a 32                	push   $0x32
    1d12:	52                   	push   %edx
    1d13:	50                   	push   %eax
    1d14:	51                   	push   %ecx
    1d15:	e8 34 f3 ff ff       	call   104e <APDrawRect>
    1d1a:	83 c4 20             	add    $0x20,%esp
                    break;
    1d1d:	e9 2f 02 00 00       	jmp    1f51 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d22:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1d25:	6a 0c                	push   $0xc
    1d27:	6a 0c                	push   $0xc
    1d29:	6a 0c                	push   $0xc
    1d2b:	50                   	push   %eax
    1d2c:	e8 cd f7 ff ff       	call   14fe <RGB>
    1d31:	83 c4 0c             	add    $0xc,%esp
    1d34:	8b 1d 14 68 00 00    	mov    0x6814,%ebx
    1d3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d3d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d40:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d43:	6b c0 32             	imul   $0x32,%eax,%eax
    1d46:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d49:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d4f:	83 ec 0c             	sub    $0xc,%esp
    1d52:	83 ec 04             	sub    $0x4,%esp
    1d55:	89 e0                	mov    %esp,%eax
    1d57:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d5b:	66 89 30             	mov    %si,(%eax)
    1d5e:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d62:	88 50 02             	mov    %dl,0x2(%eax)
    1d65:	6a 32                	push   $0x32
    1d67:	6a 32                	push   $0x32
    1d69:	6a 00                	push   $0x0
    1d6b:	6a 00                	push   $0x0
    1d6d:	53                   	push   %ebx
    1d6e:	51                   	push   %ecx
    1d6f:	ff 75 84             	pushl  -0x7c(%ebp)
    1d72:	57                   	push   %edi
    1d73:	e8 e2 f5 ff ff       	call   135a <APDcCopy>
    1d78:	83 c4 30             	add    $0x30,%esp
                    break;
    1d7b:	e9 d1 01 00 00       	jmp    1f51 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d80:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d83:	6a 0c                	push   $0xc
    1d85:	6a 0c                	push   $0xc
    1d87:	6a 0c                	push   $0xc
    1d89:	50                   	push   %eax
    1d8a:	e8 6f f7 ff ff       	call   14fe <RGB>
    1d8f:	83 c4 0c             	add    $0xc,%esp
    1d92:	8b 1d f4 67 00 00    	mov    0x67f4,%ebx
    1d98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d9b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d9e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1da1:	6b c0 32             	imul   $0x32,%eax,%eax
    1da4:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1da7:	8b 45 08             	mov    0x8(%ebp),%eax
    1daa:	8d 78 3c             	lea    0x3c(%eax),%edi
    1dad:	83 ec 0c             	sub    $0xc,%esp
    1db0:	83 ec 04             	sub    $0x4,%esp
    1db3:	89 e0                	mov    %esp,%eax
    1db5:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1db9:	66 89 30             	mov    %si,(%eax)
    1dbc:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1dc0:	88 50 02             	mov    %dl,0x2(%eax)
    1dc3:	6a 32                	push   $0x32
    1dc5:	6a 32                	push   $0x32
    1dc7:	6a 00                	push   $0x0
    1dc9:	6a 00                	push   $0x0
    1dcb:	53                   	push   %ebx
    1dcc:	51                   	push   %ecx
    1dcd:	ff 75 84             	pushl  -0x7c(%ebp)
    1dd0:	57                   	push   %edi
    1dd1:	e8 84 f5 ff ff       	call   135a <APDcCopy>
    1dd6:	83 c4 30             	add    $0x30,%esp
                    break;
    1dd9:	e9 73 01 00 00       	jmp    1f51 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dde:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1de1:	6a 0c                	push   $0xc
    1de3:	6a 0c                	push   $0xc
    1de5:	6a 0c                	push   $0xc
    1de7:	50                   	push   %eax
    1de8:	e8 11 f7 ff ff       	call   14fe <RGB>
    1ded:	83 c4 0c             	add    $0xc,%esp
    1df0:	8b 1d d8 67 00 00    	mov    0x67d8,%ebx
    1df6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1df9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dfc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dff:	6b c0 32             	imul   $0x32,%eax,%eax
    1e02:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e05:	8b 45 08             	mov    0x8(%ebp),%eax
    1e08:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e0b:	83 ec 0c             	sub    $0xc,%esp
    1e0e:	83 ec 04             	sub    $0x4,%esp
    1e11:	89 e0                	mov    %esp,%eax
    1e13:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e17:	66 89 30             	mov    %si,(%eax)
    1e1a:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e1e:	88 50 02             	mov    %dl,0x2(%eax)
    1e21:	6a 32                	push   $0x32
    1e23:	6a 32                	push   $0x32
    1e25:	6a 00                	push   $0x0
    1e27:	6a 00                	push   $0x0
    1e29:	53                   	push   %ebx
    1e2a:	51                   	push   %ecx
    1e2b:	ff 75 84             	pushl  -0x7c(%ebp)
    1e2e:	57                   	push   %edi
    1e2f:	e8 26 f5 ff ff       	call   135a <APDcCopy>
    1e34:	83 c4 30             	add    $0x30,%esp
                    break;
    1e37:	e9 15 01 00 00       	jmp    1f51 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e3c:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e3f:	6a 0c                	push   $0xc
    1e41:	6a 0c                	push   $0xc
    1e43:	6a 0c                	push   $0xc
    1e45:	50                   	push   %eax
    1e46:	e8 b3 f6 ff ff       	call   14fe <RGB>
    1e4b:	83 c4 0c             	add    $0xc,%esp
    1e4e:	8b 1d 10 68 00 00    	mov    0x6810,%ebx
    1e54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e57:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e5d:	6b c0 32             	imul   $0x32,%eax,%eax
    1e60:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e63:	8b 45 08             	mov    0x8(%ebp),%eax
    1e66:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e69:	83 ec 0c             	sub    $0xc,%esp
    1e6c:	83 ec 04             	sub    $0x4,%esp
    1e6f:	89 e0                	mov    %esp,%eax
    1e71:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e75:	66 89 30             	mov    %si,(%eax)
    1e78:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e7c:	88 50 02             	mov    %dl,0x2(%eax)
    1e7f:	6a 32                	push   $0x32
    1e81:	6a 32                	push   $0x32
    1e83:	6a 00                	push   $0x0
    1e85:	6a 00                	push   $0x0
    1e87:	53                   	push   %ebx
    1e88:	51                   	push   %ecx
    1e89:	ff 75 84             	pushl  -0x7c(%ebp)
    1e8c:	57                   	push   %edi
    1e8d:	e8 c8 f4 ff ff       	call   135a <APDcCopy>
    1e92:	83 c4 30             	add    $0x30,%esp
                    break;
    1e95:	e9 b7 00 00 00       	jmp    1f51 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e9a:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e9d:	6a 0c                	push   $0xc
    1e9f:	6a 0c                	push   $0xc
    1ea1:	6a 0c                	push   $0xc
    1ea3:	50                   	push   %eax
    1ea4:	e8 55 f6 ff ff       	call   14fe <RGB>
    1ea9:	83 c4 0c             	add    $0xc,%esp
    1eac:	8b 1d a8 67 00 00    	mov    0x67a8,%ebx
    1eb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eb5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1eb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ebb:	6b c0 32             	imul   $0x32,%eax,%eax
    1ebe:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ec1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec4:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ec7:	83 ec 0c             	sub    $0xc,%esp
    1eca:	83 ec 04             	sub    $0x4,%esp
    1ecd:	89 e0                	mov    %esp,%eax
    1ecf:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1ed3:	66 89 30             	mov    %si,(%eax)
    1ed6:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1eda:	88 50 02             	mov    %dl,0x2(%eax)
    1edd:	6a 32                	push   $0x32
    1edf:	6a 32                	push   $0x32
    1ee1:	6a 00                	push   $0x0
    1ee3:	6a 00                	push   $0x0
    1ee5:	53                   	push   %ebx
    1ee6:	51                   	push   %ecx
    1ee7:	ff 75 84             	pushl  -0x7c(%ebp)
    1eea:	57                   	push   %edi
    1eeb:	e8 6a f4 ff ff       	call   135a <APDcCopy>
    1ef0:	83 c4 30             	add    $0x30,%esp
                    break;
    1ef3:	eb 5c                	jmp    1f51 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ef5:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ef8:	6a 0c                	push   $0xc
    1efa:	6a 0c                	push   $0xc
    1efc:	6a 0c                	push   $0xc
    1efe:	50                   	push   %eax
    1eff:	e8 fa f5 ff ff       	call   14fe <RGB>
    1f04:	83 c4 0c             	add    $0xc,%esp
    1f07:	8b 1d c4 67 00 00    	mov    0x67c4,%ebx
    1f0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f10:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f13:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f16:	6b c0 32             	imul   $0x32,%eax,%eax
    1f19:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1f:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f22:	83 ec 0c             	sub    $0xc,%esp
    1f25:	83 ec 04             	sub    $0x4,%esp
    1f28:	89 e0                	mov    %esp,%eax
    1f2a:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f2e:	66 89 30             	mov    %si,(%eax)
    1f31:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f35:	88 50 02             	mov    %dl,0x2(%eax)
    1f38:	6a 32                	push   $0x32
    1f3a:	6a 32                	push   $0x32
    1f3c:	6a 00                	push   $0x0
    1f3e:	6a 00                	push   $0x0
    1f40:	53                   	push   %ebx
    1f41:	51                   	push   %ecx
    1f42:	ff 75 84             	pushl  -0x7c(%ebp)
    1f45:	57                   	push   %edi
    1f46:	e8 0f f4 ff ff       	call   135a <APDcCopy>
    1f4b:	83 c4 30             	add    $0x30,%esp
                    break;
    1f4e:	eb 01                	jmp    1f51 <APGridPaint+0x639>
                default: break;
    1f50:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f51:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f55:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f59:	0f 8e 7a fc ff ff    	jle    1bd9 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f5f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f63:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f67:	0f 8e 60 fc ff ff    	jle    1bcd <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1f6d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f70:	68 cd 00 00 00       	push   $0xcd
    1f75:	6a 74                	push   $0x74
    1f77:	6a 18                	push   $0x18
    1f79:	50                   	push   %eax
    1f7a:	e8 7f f5 ff ff       	call   14fe <RGB>
    1f7f:	83 c4 0c             	add    $0xc,%esp
    1f82:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f86:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1f8a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f8e:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f91:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f98:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f9b:	68 cd 00 00 00       	push   $0xcd
    1fa0:	6a 74                	push   $0x74
    1fa2:	6a 18                	push   $0x18
    1fa4:	50                   	push   %eax
    1fa5:	e8 54 f5 ff ff       	call   14fe <RGB>
    1faa:	83 c4 0c             	add    $0xc,%esp
    1fad:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1fb1:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1fb5:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1fb9:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1fbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbf:	8d 50 58             	lea    0x58(%eax),%edx
    1fc2:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fc5:	ff 75 bc             	pushl  -0x44(%ebp)
    1fc8:	ff 75 b8             	pushl  -0x48(%ebp)
    1fcb:	52                   	push   %edx
    1fcc:	50                   	push   %eax
    1fcd:	e8 19 ec ff ff       	call   beb <APSetPen>
    1fd2:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1fd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd8:	8d 58 58             	lea    0x58(%eax),%ebx
    1fdb:	8d 55 88             	lea    -0x78(%ebp),%edx
    1fde:	83 ec 04             	sub    $0x4,%esp
    1fe1:	83 ec 04             	sub    $0x4,%esp
    1fe4:	89 e0                	mov    %esp,%eax
    1fe6:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1fea:	66 89 08             	mov    %cx,(%eax)
    1fed:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1ff1:	88 48 02             	mov    %cl,0x2(%eax)
    1ff4:	53                   	push   %ebx
    1ff5:	52                   	push   %edx
    1ff6:	e8 29 ec ff ff       	call   c24 <APSetBrush>
    1ffb:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1ffe:	8b 45 08             	mov    0x8(%ebp),%eax
    2001:	83 c0 58             	add    $0x58,%eax
    2004:	83 ec 0c             	sub    $0xc,%esp
    2007:	6a 32                	push   $0x32
    2009:	68 20 03 00 00       	push   $0x320
    200e:	6a 00                	push   $0x0
    2010:	6a 00                	push   $0x0
    2012:	50                   	push   %eax
    2013:	e8 36 f0 ff ff       	call   104e <APDrawRect>
    2018:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    201b:	8d 45 88             	lea    -0x78(%ebp),%eax
    201e:	6a 08                	push   $0x8
    2020:	6a 08                	push   $0x8
    2022:	6a 08                	push   $0x8
    2024:	50                   	push   %eax
    2025:	e8 d4 f4 ff ff       	call   14fe <RGB>
    202a:	83 c4 0c             	add    $0xc,%esp
    202d:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2031:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    2035:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2039:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    203c:	8b 45 08             	mov    0x8(%ebp),%eax
    203f:	8d 58 58             	lea    0x58(%eax),%ebx
    2042:	8d 55 88             	lea    -0x78(%ebp),%edx
    2045:	83 ec 04             	sub    $0x4,%esp
    2048:	83 ec 04             	sub    $0x4,%esp
    204b:	89 e0                	mov    %esp,%eax
    204d:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2051:	66 89 08             	mov    %cx,(%eax)
    2054:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    2058:	88 48 02             	mov    %cl,0x2(%eax)
    205b:	53                   	push   %ebx
    205c:	52                   	push   %edx
    205d:	e8 04 ec ff ff       	call   c66 <APSetFont>
    2062:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2065:	8b 45 08             	mov    0x8(%ebp),%eax
    2068:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    206e:	8b 45 08             	mov    0x8(%ebp),%eax
    2071:	83 c0 58             	add    $0x58,%eax
    2074:	6a 14                	push   $0x14
    2076:	6a 14                	push   $0x14
    2078:	52                   	push   %edx
    2079:	50                   	push   %eax
    207a:	e8 d4 f1 ff ff       	call   1253 <APDrawText>
    207f:	83 c4 10             	add    $0x10,%esp
}
    2082:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2085:	5b                   	pop    %ebx
    2086:	5e                   	pop    %esi
    2087:	5f                   	pop    %edi
    2088:	5d                   	pop    %ebp
    2089:	c3                   	ret    

0000208a <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    208a:	55                   	push   %ebp
    208b:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    208d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2091:	7e 08                	jle    209b <random+0x11>
{
rand_num = seed;
    2093:	8b 45 08             	mov    0x8(%ebp),%eax
    2096:	a3 80 67 00 00       	mov    %eax,0x6780
}
rand_num *= 3;
    209b:	8b 15 80 67 00 00    	mov    0x6780,%edx
    20a1:	89 d0                	mov    %edx,%eax
    20a3:	01 c0                	add    %eax,%eax
    20a5:	01 d0                	add    %edx,%eax
    20a7:	a3 80 67 00 00       	mov    %eax,0x6780
if (rand_num < 0)
    20ac:	a1 80 67 00 00       	mov    0x6780,%eax
    20b1:	85 c0                	test   %eax,%eax
    20b3:	79 0c                	jns    20c1 <random+0x37>
{
rand_num *= (-1);
    20b5:	a1 80 67 00 00       	mov    0x6780,%eax
    20ba:	f7 d8                	neg    %eax
    20bc:	a3 80 67 00 00       	mov    %eax,0x6780
}
return rand_num % 997;
    20c1:	8b 0d 80 67 00 00    	mov    0x6780,%ecx
    20c7:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    20cc:	89 c8                	mov    %ecx,%eax
    20ce:	f7 ea                	imul   %edx
    20d0:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    20d3:	c1 f8 09             	sar    $0x9,%eax
    20d6:	89 c2                	mov    %eax,%edx
    20d8:	89 c8                	mov    %ecx,%eax
    20da:	c1 f8 1f             	sar    $0x1f,%eax
    20dd:	29 c2                	sub    %eax,%edx
    20df:	89 d0                	mov    %edx,%eax
    20e1:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    20e7:	29 c1                	sub    %eax,%ecx
    20e9:	89 c8                	mov    %ecx,%eax
}
    20eb:	5d                   	pop    %ebp
    20ec:	c3                   	ret    

000020ed <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    20ed:	55                   	push   %ebp
    20ee:	89 e5                	mov    %esp,%ebp
    20f0:	53                   	push   %ebx
    20f1:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    20f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    20fb:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    20ff:	74 17                	je     2118 <sprintint+0x2b>
    2101:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2105:	79 11                	jns    2118 <sprintint+0x2b>
        neg = 1;
    2107:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    210e:	8b 45 10             	mov    0x10(%ebp),%eax
    2111:	f7 d8                	neg    %eax
    2113:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2116:	eb 06                	jmp    211e <sprintint+0x31>
    } else {
        x = xx;
    2118:	8b 45 10             	mov    0x10(%ebp),%eax
    211b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    211e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2125:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2128:	8d 41 01             	lea    0x1(%ecx),%eax
    212b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    212e:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2131:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2134:	ba 00 00 00 00       	mov    $0x0,%edx
    2139:	f7 f3                	div    %ebx
    213b:	89 d0                	mov    %edx,%eax
    213d:	0f b6 80 84 67 00 00 	movzbl 0x6784(%eax),%eax
    2144:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2148:	8b 5d 14             	mov    0x14(%ebp),%ebx
    214b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    214e:	ba 00 00 00 00       	mov    $0x0,%edx
    2153:	f7 f3                	div    %ebx
    2155:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2158:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    215c:	75 c7                	jne    2125 <sprintint+0x38>
    if(neg)
    215e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2162:	74 0e                	je     2172 <sprintint+0x85>
        buf[i++] = '-';
    2164:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2167:	8d 50 01             	lea    0x1(%eax),%edx
    216a:	89 55 f8             	mov    %edx,-0x8(%ebp)
    216d:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2172:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2175:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2178:	eb 1b                	jmp    2195 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    217a:	8b 45 0c             	mov    0xc(%ebp),%eax
    217d:	8b 00                	mov    (%eax),%eax
    217f:	8d 48 01             	lea    0x1(%eax),%ecx
    2182:	8b 55 0c             	mov    0xc(%ebp),%edx
    2185:	89 0a                	mov    %ecx,(%edx)
    2187:	89 c2                	mov    %eax,%edx
    2189:	8b 45 08             	mov    0x8(%ebp),%eax
    218c:	01 d0                	add    %edx,%eax
    218e:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2191:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2195:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2199:	7f df                	jg     217a <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    219b:	eb 21                	jmp    21be <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    219d:	8b 45 0c             	mov    0xc(%ebp),%eax
    21a0:	8b 00                	mov    (%eax),%eax
    21a2:	8d 48 01             	lea    0x1(%eax),%ecx
    21a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    21a8:	89 0a                	mov    %ecx,(%edx)
    21aa:	89 c2                	mov    %eax,%edx
    21ac:	8b 45 08             	mov    0x8(%ebp),%eax
    21af:	01 c2                	add    %eax,%edx
    21b1:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    21b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21b7:	01 c8                	add    %ecx,%eax
    21b9:	0f b6 00             	movzbl (%eax),%eax
    21bc:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    21be:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    21c2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    21c6:	79 d5                	jns    219d <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    21c8:	90                   	nop
    21c9:	83 c4 20             	add    $0x20,%esp
    21cc:	5b                   	pop    %ebx
    21cd:	5d                   	pop    %ebp
    21ce:	c3                   	ret    

000021cf <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    21cf:	55                   	push   %ebp
    21d0:	89 e5                	mov    %esp,%ebp
    21d2:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    21d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    21dc:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    21e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    21ea:	8d 45 0c             	lea    0xc(%ebp),%eax
    21ed:	83 c0 04             	add    $0x4,%eax
    21f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    21f3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    21fa:	e9 d9 01 00 00       	jmp    23d8 <sprintf+0x209>
        c = fmt[i] & 0xff;
    21ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    2202:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2205:	01 d0                	add    %edx,%eax
    2207:	0f b6 00             	movzbl (%eax),%eax
    220a:	0f be c0             	movsbl %al,%eax
    220d:	25 ff 00 00 00       	and    $0xff,%eax
    2212:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2215:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2219:	75 2c                	jne    2247 <sprintf+0x78>
            if(c == '%'){
    221b:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    221f:	75 0c                	jne    222d <sprintf+0x5e>
                state = '%';
    2221:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2228:	e9 a7 01 00 00       	jmp    23d4 <sprintf+0x205>
            } else {
                dst[j++] = c;
    222d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2230:	8d 50 01             	lea    0x1(%eax),%edx
    2233:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2236:	89 c2                	mov    %eax,%edx
    2238:	8b 45 08             	mov    0x8(%ebp),%eax
    223b:	01 d0                	add    %edx,%eax
    223d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2240:	88 10                	mov    %dl,(%eax)
    2242:	e9 8d 01 00 00       	jmp    23d4 <sprintf+0x205>
            }
        } else if(state == '%'){
    2247:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    224b:	0f 85 83 01 00 00    	jne    23d4 <sprintf+0x205>
            if(c == 'd'){
    2251:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2255:	75 4c                	jne    22a3 <sprintf+0xd4>
                buf[bi] = '\0';
    2257:	8d 55 ce             	lea    -0x32(%ebp),%edx
    225a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    225d:	01 d0                	add    %edx,%eax
    225f:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2262:	83 ec 0c             	sub    $0xc,%esp
    2265:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2268:	50                   	push   %eax
    2269:	e8 e7 df ff ff       	call   255 <atoi>
    226e:	83 c4 10             	add    $0x10,%esp
    2271:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2274:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    227b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    227e:	8b 00                	mov    (%eax),%eax
    2280:	83 ec 08             	sub    $0x8,%esp
    2283:	ff 75 d8             	pushl  -0x28(%ebp)
    2286:	6a 01                	push   $0x1
    2288:	6a 0a                	push   $0xa
    228a:	50                   	push   %eax
    228b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    228e:	50                   	push   %eax
    228f:	ff 75 08             	pushl  0x8(%ebp)
    2292:	e8 56 fe ff ff       	call   20ed <sprintint>
    2297:	83 c4 20             	add    $0x20,%esp
                ap++;
    229a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    229e:	e9 2a 01 00 00       	jmp    23cd <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    22a3:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    22a7:	74 06                	je     22af <sprintf+0xe0>
    22a9:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    22ad:	75 4c                	jne    22fb <sprintf+0x12c>
                buf[bi] = '\0';
    22af:	8d 55 ce             	lea    -0x32(%ebp),%edx
    22b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22b5:	01 d0                	add    %edx,%eax
    22b7:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    22ba:	83 ec 0c             	sub    $0xc,%esp
    22bd:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22c0:	50                   	push   %eax
    22c1:	e8 8f df ff ff       	call   255 <atoi>
    22c6:	83 c4 10             	add    $0x10,%esp
    22c9:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    22cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    22d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22d6:	8b 00                	mov    (%eax),%eax
    22d8:	83 ec 08             	sub    $0x8,%esp
    22db:	ff 75 dc             	pushl  -0x24(%ebp)
    22de:	6a 00                	push   $0x0
    22e0:	6a 10                	push   $0x10
    22e2:	50                   	push   %eax
    22e3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    22e6:	50                   	push   %eax
    22e7:	ff 75 08             	pushl  0x8(%ebp)
    22ea:	e8 fe fd ff ff       	call   20ed <sprintint>
    22ef:	83 c4 20             	add    $0x20,%esp
                ap++;
    22f2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    22f6:	e9 d2 00 00 00       	jmp    23cd <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    22fb:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    22ff:	75 46                	jne    2347 <sprintf+0x178>
                s = (char*)*ap;
    2301:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2304:	8b 00                	mov    (%eax),%eax
    2306:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2309:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    230d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2311:	75 25                	jne    2338 <sprintf+0x169>
                    s = "(null)";
    2313:	c7 45 f4 a4 25 00 00 	movl   $0x25a4,-0xc(%ebp)
                while(*s != 0){
    231a:	eb 1c                	jmp    2338 <sprintf+0x169>
                    dst[j++] = *s;
    231c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    231f:	8d 50 01             	lea    0x1(%eax),%edx
    2322:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2325:	89 c2                	mov    %eax,%edx
    2327:	8b 45 08             	mov    0x8(%ebp),%eax
    232a:	01 c2                	add    %eax,%edx
    232c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    232f:	0f b6 00             	movzbl (%eax),%eax
    2332:	88 02                	mov    %al,(%edx)
                    s++;
    2334:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2338:	8b 45 f4             	mov    -0xc(%ebp),%eax
    233b:	0f b6 00             	movzbl (%eax),%eax
    233e:	84 c0                	test   %al,%al
    2340:	75 da                	jne    231c <sprintf+0x14d>
    2342:	e9 86 00 00 00       	jmp    23cd <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2347:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    234b:	75 1d                	jne    236a <sprintf+0x19b>
                dst[j++] = *ap;
    234d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2350:	8d 50 01             	lea    0x1(%eax),%edx
    2353:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2356:	89 c2                	mov    %eax,%edx
    2358:	8b 45 08             	mov    0x8(%ebp),%eax
    235b:	01 c2                	add    %eax,%edx
    235d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2360:	8b 00                	mov    (%eax),%eax
    2362:	88 02                	mov    %al,(%edx)
                ap++;
    2364:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2368:	eb 63                	jmp    23cd <sprintf+0x1fe>
            } else if(c == '%'){
    236a:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    236e:	75 17                	jne    2387 <sprintf+0x1b8>
                dst[j++] = c;
    2370:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2373:	8d 50 01             	lea    0x1(%eax),%edx
    2376:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2379:	89 c2                	mov    %eax,%edx
    237b:	8b 45 08             	mov    0x8(%ebp),%eax
    237e:	01 d0                	add    %edx,%eax
    2380:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2383:	88 10                	mov    %dl,(%eax)
    2385:	eb 46                	jmp    23cd <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2387:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    238b:	7e 18                	jle    23a5 <sprintf+0x1d6>
    238d:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2391:	7f 12                	jg     23a5 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2393:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2396:	8d 50 01             	lea    0x1(%eax),%edx
    2399:	89 55 f0             	mov    %edx,-0x10(%ebp)
    239c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    239f:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    23a3:	eb 2f                	jmp    23d4 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    23a5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23a8:	8d 50 01             	lea    0x1(%eax),%edx
    23ab:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23ae:	89 c2                	mov    %eax,%edx
    23b0:	8b 45 08             	mov    0x8(%ebp),%eax
    23b3:	01 d0                	add    %edx,%eax
    23b5:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    23b8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23bb:	8d 50 01             	lea    0x1(%eax),%edx
    23be:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23c1:	89 c2                	mov    %eax,%edx
    23c3:	8b 45 08             	mov    0x8(%ebp),%eax
    23c6:	01 d0                	add    %edx,%eax
    23c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23cb:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    23cd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    23d4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    23d8:	8b 55 0c             	mov    0xc(%ebp),%edx
    23db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23de:	01 d0                	add    %edx,%eax
    23e0:	0f b6 00             	movzbl (%eax),%eax
    23e3:	84 c0                	test   %al,%al
    23e5:	0f 85 14 fe ff ff    	jne    21ff <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    23eb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23ee:	8d 50 01             	lea    0x1(%eax),%edx
    23f1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23f4:	89 c2                	mov    %eax,%edx
    23f6:	8b 45 08             	mov    0x8(%ebp),%eax
    23f9:	01 d0                	add    %edx,%eax
    23fb:	c6 00 00             	movb   $0x0,(%eax)
}
    23fe:	90                   	nop
    23ff:	c9                   	leave  
    2400:	c3                   	ret    
