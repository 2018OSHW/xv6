
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
      1c:	68 48 22 00 00       	push   $0x2248
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
      6f:	68 5c 22 00 00       	push   $0x225c
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
     422:	0f b6 80 48 29 00 00 	movzbl 0x2948(%eax),%eax
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
     560:	c7 45 f4 75 22 00 00 	movl   $0x2275,-0xc(%ebp)
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
     626:	a1 7c 29 00 00       	mov    0x297c,%eax
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
     6f1:	a3 7c 29 00 00       	mov    %eax,0x297c
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
     752:	a1 7c 29 00 00       	mov    0x297c,%eax
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
     76e:	a1 7c 29 00 00       	mov    0x297c,%eax
     773:	89 45 f0             	mov    %eax,-0x10(%ebp)
     776:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     77a:	75 23                	jne    79f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     77c:	c7 45 f0 74 29 00 00 	movl   $0x2974,-0x10(%ebp)
     783:	8b 45 f0             	mov    -0x10(%ebp),%eax
     786:	a3 7c 29 00 00       	mov    %eax,0x297c
     78b:	a1 7c 29 00 00       	mov    0x297c,%eax
     790:	a3 74 29 00 00       	mov    %eax,0x2974
    base.s.size = 0;
     795:	c7 05 78 29 00 00 00 	movl   $0x0,0x2978
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
     7f2:	a3 7c 29 00 00       	mov    %eax,0x297c
      return (void*)(p + 1);
     7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fa:	83 c0 08             	add    $0x8,%eax
     7fd:	eb 3b                	jmp    83a <malloc+0xe1>
    }
    if(p == freep)
     7ff:	a1 7c 29 00 00       	mov    0x297c,%eax
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
     945:	68 7c 22 00 00       	push   $0x227c
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

00001201 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1201:	55                   	push   %ebp
    1202:	89 e5                	mov    %esp,%ebp
}
    1204:	90                   	nop
    1205:	5d                   	pop    %ebp
    1206:	c3                   	ret    

00001207 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1207:	55                   	push   %ebp
    1208:	89 e5                	mov    %esp,%ebp
    120a:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    120d:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1211:	0f 88 8e 01 00 00    	js     13a5 <APDcCopy+0x19e>
    1217:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    121b:	0f 88 84 01 00 00    	js     13a5 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1221:	8b 55 0c             	mov    0xc(%ebp),%edx
    1224:	8b 45 20             	mov    0x20(%ebp),%eax
    1227:	01 d0                	add    %edx,%eax
    1229:	89 45 fc             	mov    %eax,-0x4(%ebp)
    122c:	8b 55 10             	mov    0x10(%ebp),%edx
    122f:	8b 45 24             	mov    0x24(%ebp),%eax
    1232:	01 d0                	add    %edx,%eax
    1234:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1237:	8b 55 18             	mov    0x18(%ebp),%edx
    123a:	8b 45 20             	mov    0x20(%ebp),%eax
    123d:	01 d0                	add    %edx,%eax
    123f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1242:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1245:	8b 45 24             	mov    0x24(%ebp),%eax
    1248:	01 d0                	add    %edx,%eax
    124a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    124d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1251:	0f 88 51 01 00 00    	js     13a8 <APDcCopy+0x1a1>
    1257:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    125b:	0f 88 47 01 00 00    	js     13a8 <APDcCopy+0x1a1>
    1261:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1265:	0f 88 3d 01 00 00    	js     13a8 <APDcCopy+0x1a1>
    126b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    126f:	0f 88 33 01 00 00    	js     13a8 <APDcCopy+0x1a1>
    1275:	8b 45 14             	mov    0x14(%ebp),%eax
    1278:	8b 00                	mov    (%eax),%eax
    127a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    127d:	0f 8c 25 01 00 00    	jl     13a8 <APDcCopy+0x1a1>
    1283:	8b 45 14             	mov    0x14(%ebp),%eax
    1286:	8b 40 04             	mov    0x4(%eax),%eax
    1289:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    128c:	0f 8c 16 01 00 00    	jl     13a8 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1292:	8b 45 08             	mov    0x8(%ebp),%eax
    1295:	8b 00                	mov    (%eax),%eax
    1297:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    129a:	7f 0b                	jg     12a7 <APDcCopy+0xa0>
    129c:	8b 45 08             	mov    0x8(%ebp),%eax
    129f:	8b 00                	mov    (%eax),%eax
    12a1:	83 e8 01             	sub    $0x1,%eax
    12a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    12a7:	8b 45 08             	mov    0x8(%ebp),%eax
    12aa:	8b 40 04             	mov    0x4(%eax),%eax
    12ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12b0:	7f 0c                	jg     12be <APDcCopy+0xb7>
    12b2:	8b 45 08             	mov    0x8(%ebp),%eax
    12b5:	8b 40 04             	mov    0x4(%eax),%eax
    12b8:	83 e8 01             	sub    $0x1,%eax
    12bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12c5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12d3:	e9 bc 00 00 00       	jmp    1394 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12d8:	8b 45 08             	mov    0x8(%ebp),%eax
    12db:	8b 00                	mov    (%eax),%eax
    12dd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12e0:	8b 55 10             	mov    0x10(%ebp),%edx
    12e3:	01 ca                	add    %ecx,%edx
    12e5:	0f af d0             	imul   %eax,%edx
    12e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    12eb:	01 d0                	add    %edx,%eax
    12ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12f0:	8b 45 14             	mov    0x14(%ebp),%eax
    12f3:	8b 00                	mov    (%eax),%eax
    12f5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12f8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12fb:	01 ca                	add    %ecx,%edx
    12fd:	0f af d0             	imul   %eax,%edx
    1300:	8b 45 18             	mov    0x18(%ebp),%eax
    1303:	01 d0                	add    %edx,%eax
    1305:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1308:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    130f:	eb 74                	jmp    1385 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1311:	8b 45 14             	mov    0x14(%ebp),%eax
    1314:	8b 50 18             	mov    0x18(%eax),%edx
    1317:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    131a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    131d:	01 c8                	add    %ecx,%eax
    131f:	89 c1                	mov    %eax,%ecx
    1321:	89 c8                	mov    %ecx,%eax
    1323:	01 c0                	add    %eax,%eax
    1325:	01 c8                	add    %ecx,%eax
    1327:	01 d0                	add    %edx,%eax
    1329:	0f b7 10             	movzwl (%eax),%edx
    132c:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1330:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1334:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1337:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    133b:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    133f:	38 c2                	cmp    %al,%dl
    1341:	75 18                	jne    135b <APDcCopy+0x154>
    1343:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1347:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    134b:	38 c2                	cmp    %al,%dl
    134d:	75 0c                	jne    135b <APDcCopy+0x154>
    134f:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1353:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1357:	38 c2                	cmp    %al,%dl
    1359:	74 26                	je     1381 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    135b:	8b 45 08             	mov    0x8(%ebp),%eax
    135e:	8b 50 18             	mov    0x18(%eax),%edx
    1361:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1364:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1367:	01 c8                	add    %ecx,%eax
    1369:	89 c1                	mov    %eax,%ecx
    136b:	89 c8                	mov    %ecx,%eax
    136d:	01 c0                	add    %eax,%eax
    136f:	01 c8                	add    %ecx,%eax
    1371:	01 d0                	add    %edx,%eax
    1373:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1377:	66 89 10             	mov    %dx,(%eax)
    137a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    137e:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1381:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1385:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1388:	2b 45 0c             	sub    0xc(%ebp),%eax
    138b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    138e:	7d 81                	jge    1311 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1390:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1394:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1397:	2b 45 10             	sub    0x10(%ebp),%eax
    139a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    139d:	0f 8d 35 ff ff ff    	jge    12d8 <APDcCopy+0xd1>
    13a3:	eb 04                	jmp    13a9 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    13a5:	90                   	nop
    13a6:	eb 01                	jmp    13a9 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    13a8:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13a9:	c9                   	leave  
    13aa:	c3                   	ret    

000013ab <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13ab:	55                   	push   %ebp
    13ac:	89 e5                	mov    %esp,%ebp
    13ae:	83 ec 1c             	sub    $0x1c,%esp
    13b1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13b4:	8b 55 10             	mov    0x10(%ebp),%edx
    13b7:	8b 45 14             	mov    0x14(%ebp),%eax
    13ba:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13bd:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13c0:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13c3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13c7:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13ca:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13ce:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13d1:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13d5:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13df:	66 89 10             	mov    %dx,(%eax)
    13e2:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13e6:	88 50 02             	mov    %dl,0x2(%eax)
}
    13e9:	8b 45 08             	mov    0x8(%ebp),%eax
    13ec:	c9                   	leave  
    13ed:	c2 04 00             	ret    $0x4

000013f0 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
    13f3:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13f6:	8b 45 08             	mov    0x8(%ebp),%eax
    13f9:	8b 00                	mov    (%eax),%eax
    13fb:	83 ec 08             	sub    $0x8,%esp
    13fe:	8d 55 0c             	lea    0xc(%ebp),%edx
    1401:	52                   	push   %edx
    1402:	50                   	push   %eax
    1403:	e8 87 ef ff ff       	call   38f <sendMessage>
    1408:	83 c4 10             	add    $0x10,%esp
}
    140b:	90                   	nop
    140c:	c9                   	leave  
    140d:	c3                   	ret    

0000140e <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    140e:	55                   	push   %ebp
    140f:	89 e5                	mov    %esp,%ebp
    1411:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1414:	83 ec 0c             	sub    $0xc,%esp
    1417:	68 98 00 00 00       	push   $0x98
    141c:	e8 38 f3 ff ff       	call   759 <malloc>
    1421:	83 c4 10             	add    $0x10,%esp
    1424:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1427:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    142b:	75 15                	jne    1442 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    142d:	83 ec 04             	sub    $0x4,%esp
    1430:	ff 75 08             	pushl  0x8(%ebp)
    1433:	68 8c 22 00 00       	push   $0x228c
    1438:	6a 01                	push   $0x1
    143a:	e8 47 f0 ff ff       	call   486 <printf>
    143f:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1442:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1445:	05 84 00 00 00       	add    $0x84,%eax
    144a:	83 ec 08             	sub    $0x8,%esp
    144d:	ff 75 08             	pushl  0x8(%ebp)
    1450:	50                   	push   %eax
    1451:	e8 60 ec ff ff       	call   b6 <strcpy>
    1456:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145c:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1463:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1466:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1470:	8b 40 3c             	mov    0x3c(%eax),%eax
    1473:	89 c2                	mov    %eax,%edx
    1475:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1478:	8b 40 40             	mov    0x40(%eax),%eax
    147b:	0f af d0             	imul   %eax,%edx
    147e:	89 d0                	mov    %edx,%eax
    1480:	01 c0                	add    %eax,%eax
    1482:	01 d0                	add    %edx,%eax
    1484:	83 ec 0c             	sub    $0xc,%esp
    1487:	50                   	push   %eax
    1488:	e8 cc f2 ff ff       	call   759 <malloc>
    148d:	83 c4 10             	add    $0x10,%esp
    1490:	89 c2                	mov    %eax,%edx
    1492:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1495:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1498:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149b:	8b 40 54             	mov    0x54(%eax),%eax
    149e:	85 c0                	test   %eax,%eax
    14a0:	75 15                	jne    14b7 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    14a2:	83 ec 04             	sub    $0x4,%esp
    14a5:	ff 75 08             	pushl  0x8(%ebp)
    14a8:	68 ac 22 00 00       	push   $0x22ac
    14ad:	6a 01                	push   $0x1
    14af:	e8 d2 ef ff ff       	call   486 <printf>
    14b4:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ba:	8b 40 3c             	mov    0x3c(%eax),%eax
    14bd:	89 c2                	mov    %eax,%edx
    14bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c2:	8b 40 40             	mov    0x40(%eax),%eax
    14c5:	0f af d0             	imul   %eax,%edx
    14c8:	89 d0                	mov    %edx,%eax
    14ca:	01 c0                	add    %eax,%eax
    14cc:	01 c2                	add    %eax,%edx
    14ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d1:	8b 40 54             	mov    0x54(%eax),%eax
    14d4:	83 ec 04             	sub    $0x4,%esp
    14d7:	52                   	push   %edx
    14d8:	68 ff ff ff 00       	push   $0xffffff
    14dd:	50                   	push   %eax
    14de:	e8 69 ec ff ff       	call   14c <memset>
    14e3:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    14f0:	e8 72 ee ff ff       	call   367 <getpid>
    14f5:	89 c2                	mov    %eax,%edx
    14f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14fa:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1500:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1507:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150a:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1511:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1514:	8b 40 58             	mov    0x58(%eax),%eax
    1517:	89 c2                	mov    %eax,%edx
    1519:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151c:	8b 40 5c             	mov    0x5c(%eax),%eax
    151f:	0f af d0             	imul   %eax,%edx
    1522:	89 d0                	mov    %edx,%eax
    1524:	01 c0                	add    %eax,%eax
    1526:	01 d0                	add    %edx,%eax
    1528:	83 ec 0c             	sub    $0xc,%esp
    152b:	50                   	push   %eax
    152c:	e8 28 f2 ff ff       	call   759 <malloc>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	89 c2                	mov    %eax,%edx
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    153c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153f:	8b 40 70             	mov    0x70(%eax),%eax
    1542:	85 c0                	test   %eax,%eax
    1544:	75 15                	jne    155b <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1546:	83 ec 04             	sub    $0x4,%esp
    1549:	ff 75 08             	pushl  0x8(%ebp)
    154c:	68 d0 22 00 00       	push   $0x22d0
    1551:	6a 01                	push   $0x1
    1553:	e8 2e ef ff ff       	call   486 <printf>
    1558:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    155b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1561:	89 c2                	mov    %eax,%edx
    1563:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1566:	8b 40 40             	mov    0x40(%eax),%eax
    1569:	0f af d0             	imul   %eax,%edx
    156c:	89 d0                	mov    %edx,%eax
    156e:	01 c0                	add    %eax,%eax
    1570:	01 c2                	add    %eax,%edx
    1572:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1575:	8b 40 54             	mov    0x54(%eax),%eax
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
    1597:	74 49                	je     15e2 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1599:	8b 45 10             	mov    0x10(%ebp),%eax
    159c:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    15a2:	83 ec 0c             	sub    $0xc,%esp
    15a5:	50                   	push   %eax
    15a6:	e8 ae f1 ff ff       	call   759 <malloc>
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
        r->pos_x = 0;
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d6:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15dd:	e9 8d 00 00 00       	jmp    166f <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ef:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	8b 40 20             	mov    0x20(%eax),%eax
    15fc:	89 c2                	mov    %eax,%edx
    15fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1601:	8b 40 24             	mov    0x24(%eax),%eax
    1604:	0f af d0             	imul   %eax,%edx
    1607:	89 d0                	mov    %edx,%eax
    1609:	01 c0                	add    %eax,%eax
    160b:	01 d0                	add    %edx,%eax
    160d:	83 ec 0c             	sub    $0xc,%esp
    1610:	50                   	push   %eax
    1611:	e8 43 f1 ff ff       	call   759 <malloc>
    1616:	83 c4 10             	add    $0x10,%esp
    1619:	89 c2                	mov    %eax,%edx
    161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161e:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1621:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1624:	8b 40 38             	mov    0x38(%eax),%eax
    1627:	85 c0                	test   %eax,%eax
    1629:	75 15                	jne    1640 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    162b:	83 ec 04             	sub    $0x4,%esp
    162e:	ff 75 08             	pushl  0x8(%ebp)
    1631:	68 f8 22 00 00       	push   $0x22f8
    1636:	6a 01                	push   $0x1
    1638:	e8 49 ee ff ff       	call   486 <printf>
    163d:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1640:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1643:	8b 40 20             	mov    0x20(%eax),%eax
    1646:	89 c2                	mov    %eax,%edx
    1648:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164b:	8b 40 24             	mov    0x24(%eax),%eax
    164e:	0f af d0             	imul   %eax,%edx
    1651:	89 d0                	mov    %edx,%eax
    1653:	01 c0                	add    %eax,%eax
    1655:	01 c2                	add    %eax,%edx
    1657:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165a:	8b 40 38             	mov    0x38(%eax),%eax
    165d:	83 ec 04             	sub    $0x4,%esp
    1660:	52                   	push   %edx
    1661:	68 ff ff ff 00       	push   $0xffffff
    1666:	50                   	push   %eax
    1667:	e8 e0 ea ff ff       	call   14c <memset>
    166c:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    166f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1672:	c9                   	leave  
    1673:	c3                   	ret    

00001674 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1674:	55                   	push   %ebp
    1675:	89 e5                	mov    %esp,%ebp
    1677:	57                   	push   %edi
    1678:	56                   	push   %esi
    1679:	53                   	push   %ebx
    167a:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    167d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1680:	83 f8 03             	cmp    $0x3,%eax
    1683:	74 02                	je     1687 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1685:	eb 7c                	jmp    1703 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1687:	8b 45 08             	mov    0x8(%ebp),%eax
    168a:	8b 58 1c             	mov    0x1c(%eax),%ebx
    168d:	8b 45 08             	mov    0x8(%ebp),%eax
    1690:	8b 48 18             	mov    0x18(%eax),%ecx
    1693:	8b 45 08             	mov    0x8(%ebp),%eax
    1696:	8b 50 5c             	mov    0x5c(%eax),%edx
    1699:	8b 45 08             	mov    0x8(%ebp),%eax
    169c:	8b 40 58             	mov    0x58(%eax),%eax
    169f:	8b 75 08             	mov    0x8(%ebp),%esi
    16a2:	83 c6 58             	add    $0x58,%esi
    16a5:	83 ec 04             	sub    $0x4,%esp
    16a8:	53                   	push   %ebx
    16a9:	51                   	push   %ecx
    16aa:	6a 00                	push   $0x0
    16ac:	52                   	push   %edx
    16ad:	50                   	push   %eax
    16ae:	6a 00                	push   $0x0
    16b0:	6a 00                	push   $0x0
    16b2:	56                   	push   %esi
    16b3:	6a 00                	push   $0x0
    16b5:	6a 00                	push   $0x0
    16b7:	ff 75 08             	pushl  0x8(%ebp)
    16ba:	e8 c8 ec ff ff       	call   387 <paintWindow>
    16bf:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    16c2:	8b 45 08             	mov    0x8(%ebp),%eax
    16c5:	8b 70 1c             	mov    0x1c(%eax),%esi
    16c8:	8b 45 08             	mov    0x8(%ebp),%eax
    16cb:	8b 58 18             	mov    0x18(%eax),%ebx
    16ce:	8b 45 08             	mov    0x8(%ebp),%eax
    16d1:	8b 48 08             	mov    0x8(%eax),%ecx
    16d4:	8b 45 08             	mov    0x8(%ebp),%eax
    16d7:	8b 50 40             	mov    0x40(%eax),%edx
    16da:	8b 45 08             	mov    0x8(%ebp),%eax
    16dd:	8b 40 3c             	mov    0x3c(%eax),%eax
    16e0:	8b 7d 08             	mov    0x8(%ebp),%edi
    16e3:	83 c7 3c             	add    $0x3c,%edi
    16e6:	83 ec 04             	sub    $0x4,%esp
    16e9:	56                   	push   %esi
    16ea:	53                   	push   %ebx
    16eb:	51                   	push   %ecx
    16ec:	52                   	push   %edx
    16ed:	50                   	push   %eax
    16ee:	6a 00                	push   $0x0
    16f0:	6a 00                	push   $0x0
    16f2:	57                   	push   %edi
    16f3:	6a 32                	push   $0x32
    16f5:	6a 00                	push   $0x0
    16f7:	ff 75 08             	pushl  0x8(%ebp)
    16fa:	e8 88 ec ff ff       	call   387 <paintWindow>
    16ff:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1702:	90                   	nop
        default: break;
            
            
    }
    return False;
    1703:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1708:	8d 65 f4             	lea    -0xc(%ebp),%esp
    170b:	5b                   	pop    %ebx
    170c:	5e                   	pop    %esi
    170d:	5f                   	pop    %edi
    170e:	5d                   	pop    %ebp
    170f:	c3                   	ret    

00001710 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1710:	55                   	push   %ebp
    1711:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1713:	8b 45 0c             	mov    0xc(%ebp),%eax
    1716:	8b 50 08             	mov    0x8(%eax),%edx
    1719:	8b 45 08             	mov    0x8(%ebp),%eax
    171c:	8b 00                	mov    (%eax),%eax
    171e:	39 c2                	cmp    %eax,%edx
    1720:	74 07                	je     1729 <APPreJudge+0x19>
        return False;
    1722:	b8 00 00 00 00       	mov    $0x0,%eax
    1727:	eb 05                	jmp    172e <APPreJudge+0x1e>
    return True;
    1729:	b8 01 00 00 00       	mov    $0x1,%eax
}
    172e:	5d                   	pop    %ebp
    172f:	c3                   	ret    

00001730 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1730:	55                   	push   %ebp
    1731:	89 e5                	mov    %esp,%ebp
    1733:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	8b 55 0c             	mov    0xc(%ebp),%edx
    173c:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1742:	83 ec 0c             	sub    $0xc,%esp
    1745:	ff 75 08             	pushl  0x8(%ebp)
    1748:	e8 52 ec ff ff       	call   39f <registWindow>
    174d:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1750:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1757:	8b 45 08             	mov    0x8(%ebp),%eax
    175a:	8b 00                	mov    (%eax),%eax
    175c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    175f:	ff 75 f4             	pushl  -0xc(%ebp)
    1762:	ff 75 f0             	pushl  -0x10(%ebp)
    1765:	ff 75 ec             	pushl  -0x14(%ebp)
    1768:	ff 75 08             	pushl  0x8(%ebp)
    176b:	e8 80 fc ff ff       	call   13f0 <APSendMessage>
    1770:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1773:	83 ec 0c             	sub    $0xc,%esp
    1776:	ff 75 08             	pushl  0x8(%ebp)
    1779:	e8 19 ec ff ff       	call   397 <getMessage>
    177e:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1781:	8b 45 08             	mov    0x8(%ebp),%eax
    1784:	83 c0 74             	add    $0x74,%eax
    1787:	83 ec 08             	sub    $0x8,%esp
    178a:	50                   	push   %eax
    178b:	ff 75 08             	pushl  0x8(%ebp)
    178e:	e8 7d ff ff ff       	call   1710 <APPreJudge>
    1793:	83 c4 10             	add    $0x10,%esp
    1796:	84 c0                	test   %al,%al
    1798:	74 1b                	je     17b5 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    179a:	8b 45 08             	mov    0x8(%ebp),%eax
    179d:	ff 70 7c             	pushl  0x7c(%eax)
    17a0:	ff 70 78             	pushl  0x78(%eax)
    17a3:	ff 70 74             	pushl  0x74(%eax)
    17a6:	ff 75 08             	pushl  0x8(%ebp)
    17a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    17ac:	ff d0                	call   *%eax
    17ae:	83 c4 10             	add    $0x10,%esp
    17b1:	84 c0                	test   %al,%al
    17b3:	75 0c                	jne    17c1 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    17b5:	8b 45 08             	mov    0x8(%ebp),%eax
    17b8:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    17bf:	eb b2                	jmp    1773 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17c1:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17c2:	90                   	nop
    17c3:	c9                   	leave  
    17c4:	c3                   	ret    

000017c5 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17c5:	55                   	push   %ebp
    17c6:	89 e5                	mov    %esp,%ebp
    17c8:	57                   	push   %edi
    17c9:	56                   	push   %esi
    17ca:	53                   	push   %ebx
    17cb:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17ce:	a1 80 29 00 00       	mov    0x2980,%eax
    17d3:	85 c0                	test   %eax,%eax
    17d5:	0f 85 2c 02 00 00    	jne    1a07 <APGridPaint+0x242>
    {
        iconReady = 1;
    17db:	c7 05 80 29 00 00 01 	movl   $0x1,0x2980
    17e2:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17e5:	8d 45 98             	lea    -0x68(%ebp),%eax
    17e8:	83 ec 08             	sub    $0x8,%esp
    17eb:	68 1f 23 00 00       	push   $0x231f
    17f0:	50                   	push   %eax
    17f1:	e8 16 f1 ff ff       	call   90c <APLoadBitmap>
    17f6:	83 c4 0c             	add    $0xc,%esp
    17f9:	8b 45 98             	mov    -0x68(%ebp),%eax
    17fc:	a3 a4 29 00 00       	mov    %eax,0x29a4
    1801:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1804:	a3 a8 29 00 00       	mov    %eax,0x29a8
    1809:	8b 45 a0             	mov    -0x60(%ebp),%eax
    180c:	a3 ac 29 00 00       	mov    %eax,0x29ac
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1811:	83 ec 04             	sub    $0x4,%esp
    1814:	ff 35 ac 29 00 00    	pushl  0x29ac
    181a:	ff 35 a8 29 00 00    	pushl  0x29a8
    1820:	ff 35 a4 29 00 00    	pushl  0x29a4
    1826:	e8 1b f3 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    182b:	83 c4 10             	add    $0x10,%esp
    182e:	a3 b0 29 00 00       	mov    %eax,0x29b0
        grid_river = APLoadBitmap ("grid_river.bmp");
    1833:	8d 45 98             	lea    -0x68(%ebp),%eax
    1836:	83 ec 08             	sub    $0x8,%esp
    1839:	68 2d 23 00 00       	push   $0x232d
    183e:	50                   	push   %eax
    183f:	e8 c8 f0 ff ff       	call   90c <APLoadBitmap>
    1844:	83 c4 0c             	add    $0xc,%esp
    1847:	8b 45 98             	mov    -0x68(%ebp),%eax
    184a:	a3 e0 29 00 00       	mov    %eax,0x29e0
    184f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1852:	a3 e4 29 00 00       	mov    %eax,0x29e4
    1857:	8b 45 a0             	mov    -0x60(%ebp),%eax
    185a:	a3 e8 29 00 00       	mov    %eax,0x29e8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    185f:	83 ec 04             	sub    $0x4,%esp
    1862:	ff 35 e8 29 00 00    	pushl  0x29e8
    1868:	ff 35 e4 29 00 00    	pushl  0x29e4
    186e:	ff 35 e0 29 00 00    	pushl  0x29e0
    1874:	e8 cd f2 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    1879:	83 c4 10             	add    $0x10,%esp
    187c:	a3 d0 29 00 00       	mov    %eax,0x29d0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1881:	8d 45 98             	lea    -0x68(%ebp),%eax
    1884:	83 ec 08             	sub    $0x8,%esp
    1887:	68 3c 23 00 00       	push   $0x233c
    188c:	50                   	push   %eax
    188d:	e8 7a f0 ff ff       	call   90c <APLoadBitmap>
    1892:	83 c4 0c             	add    $0xc,%esp
    1895:	8b 45 98             	mov    -0x68(%ebp),%eax
    1898:	a3 d4 29 00 00       	mov    %eax,0x29d4
    189d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18a0:	a3 d8 29 00 00       	mov    %eax,0x29d8
    18a5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18a8:	a3 dc 29 00 00       	mov    %eax,0x29dc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    18ad:	83 ec 04             	sub    $0x4,%esp
    18b0:	ff 35 dc 29 00 00    	pushl  0x29dc
    18b6:	ff 35 d8 29 00 00    	pushl  0x29d8
    18bc:	ff 35 d4 29 00 00    	pushl  0x29d4
    18c2:	e8 7f f2 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    18c7:	83 c4 10             	add    $0x10,%esp
    18ca:	a3 84 29 00 00       	mov    %eax,0x2984
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18cf:	8d 45 98             	lea    -0x68(%ebp),%eax
    18d2:	83 ec 08             	sub    $0x8,%esp
    18d5:	68 4b 23 00 00       	push   $0x234b
    18da:	50                   	push   %eax
    18db:	e8 2c f0 ff ff       	call   90c <APLoadBitmap>
    18e0:	83 c4 0c             	add    $0xc,%esp
    18e3:	8b 45 98             	mov    -0x68(%ebp),%eax
    18e6:	a3 b8 29 00 00       	mov    %eax,0x29b8
    18eb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18ee:	a3 bc 29 00 00       	mov    %eax,0x29bc
    18f3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18f6:	a3 c0 29 00 00       	mov    %eax,0x29c0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18fb:	83 ec 04             	sub    $0x4,%esp
    18fe:	ff 35 c0 29 00 00    	pushl  0x29c0
    1904:	ff 35 bc 29 00 00    	pushl  0x29bc
    190a:	ff 35 b8 29 00 00    	pushl  0x29b8
    1910:	e8 31 f2 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    1915:	83 c4 10             	add    $0x10,%esp
    1918:	a3 ec 29 00 00       	mov    %eax,0x29ec
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    191d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1920:	83 ec 08             	sub    $0x8,%esp
    1923:	68 59 23 00 00       	push   $0x2359
    1928:	50                   	push   %eax
    1929:	e8 de ef ff ff       	call   90c <APLoadBitmap>
    192e:	83 c4 0c             	add    $0xc,%esp
    1931:	8b 45 98             	mov    -0x68(%ebp),%eax
    1934:	a3 94 29 00 00       	mov    %eax,0x2994
    1939:	8b 45 9c             	mov    -0x64(%ebp),%eax
    193c:	a3 98 29 00 00       	mov    %eax,0x2998
    1941:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1944:	a3 9c 29 00 00       	mov    %eax,0x299c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1949:	83 ec 04             	sub    $0x4,%esp
    194c:	ff 35 9c 29 00 00    	pushl  0x299c
    1952:	ff 35 98 29 00 00    	pushl  0x2998
    1958:	ff 35 94 29 00 00    	pushl  0x2994
    195e:	e8 e3 f1 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    1963:	83 c4 10             	add    $0x10,%esp
    1966:	a3 b4 29 00 00       	mov    %eax,0x29b4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    196b:	8d 45 98             	lea    -0x68(%ebp),%eax
    196e:	83 ec 08             	sub    $0x8,%esp
    1971:	68 69 23 00 00       	push   $0x2369
    1976:	50                   	push   %eax
    1977:	e8 90 ef ff ff       	call   90c <APLoadBitmap>
    197c:	83 c4 0c             	add    $0xc,%esp
    197f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1982:	a3 88 29 00 00       	mov    %eax,0x2988
    1987:	8b 45 9c             	mov    -0x64(%ebp),%eax
    198a:	a3 8c 29 00 00       	mov    %eax,0x298c
    198f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1992:	a3 90 29 00 00       	mov    %eax,0x2990
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1997:	83 ec 04             	sub    $0x4,%esp
    199a:	ff 35 90 29 00 00    	pushl  0x2990
    19a0:	ff 35 8c 29 00 00    	pushl  0x298c
    19a6:	ff 35 88 29 00 00    	pushl  0x2988
    19ac:	e8 95 f1 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    19b1:	83 c4 10             	add    $0x10,%esp
    19b4:	a3 a0 29 00 00       	mov    %eax,0x29a0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19b9:	8d 45 98             	lea    -0x68(%ebp),%eax
    19bc:	83 ec 08             	sub    $0x8,%esp
    19bf:	68 7b 23 00 00       	push   $0x237b
    19c4:	50                   	push   %eax
    19c5:	e8 42 ef ff ff       	call   90c <APLoadBitmap>
    19ca:	83 c4 0c             	add    $0xc,%esp
    19cd:	8b 45 98             	mov    -0x68(%ebp),%eax
    19d0:	a3 c4 29 00 00       	mov    %eax,0x29c4
    19d5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19d8:	a3 c8 29 00 00       	mov    %eax,0x29c8
    19dd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19e0:	a3 cc 29 00 00       	mov    %eax,0x29cc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19e5:	83 ec 04             	sub    $0x4,%esp
    19e8:	ff 35 cc 29 00 00    	pushl  0x29cc
    19ee:	ff 35 c8 29 00 00    	pushl  0x29c8
    19f4:	ff 35 c4 29 00 00    	pushl  0x29c4
    19fa:	e8 47 f1 ff ff       	call   b46 <APCreateCompatibleDCFromBitmap>
    19ff:	83 c4 10             	add    $0x10,%esp
    1a02:	a3 f0 29 00 00       	mov    %eax,0x29f0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	8b 40 08             	mov    0x8(%eax),%eax
    1a0d:	85 c0                	test   %eax,%eax
    1a0f:	75 17                	jne    1a28 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a11:	83 ec 08             	sub    $0x8,%esp
    1a14:	68 8c 23 00 00       	push   $0x238c
    1a19:	6a 01                	push   $0x1
    1a1b:	e8 66 ea ff ff       	call   486 <printf>
    1a20:	83 c4 10             	add    $0x10,%esp
        return;
    1a23:	e9 a0 04 00 00       	jmp    1ec8 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a28:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2b:	8b 40 10             	mov    0x10(%eax),%eax
    1a2e:	85 c0                	test   %eax,%eax
    1a30:	7e 10                	jle    1a42 <APGridPaint+0x27d>
    1a32:	8b 45 08             	mov    0x8(%ebp),%eax
    1a35:	8b 50 14             	mov    0x14(%eax),%edx
    1a38:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3b:	8b 40 10             	mov    0x10(%eax),%eax
    1a3e:	39 c2                	cmp    %eax,%edx
    1a40:	7c 17                	jl     1a59 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a42:	83 ec 08             	sub    $0x8,%esp
    1a45:	68 b2 23 00 00       	push   $0x23b2
    1a4a:	6a 01                	push   $0x1
    1a4c:	e8 35 ea ff ff       	call   486 <printf>
    1a51:	83 c4 10             	add    $0x10,%esp
        return;
    1a54:	e9 6f 04 00 00       	jmp    1ec8 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a59:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5c:	8b 40 14             	mov    0x14(%eax),%eax
    1a5f:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a65:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a68:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a6b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a6e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a75:	e9 96 03 00 00       	jmp    1e10 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a7a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a81:	e9 7c 03 00 00       	jmp    1e02 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a89:	c1 e0 04             	shl    $0x4,%eax
    1a8c:	89 c2                	mov    %eax,%edx
    1a8e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a91:	01 c2                	add    %eax,%edx
    1a93:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a96:	01 d0                	add    %edx,%eax
    1a98:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9e:	8b 40 0c             	mov    0xc(%eax),%eax
    1aa1:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1aa4:	c1 e2 02             	shl    $0x2,%edx
    1aa7:	01 d0                	add    %edx,%eax
    1aa9:	8b 00                	mov    (%eax),%eax
    1aab:	83 f8 07             	cmp    $0x7,%eax
    1aae:	0f 87 49 03 00 00    	ja     1dfd <APGridPaint+0x638>
    1ab4:	8b 04 85 c8 23 00 00 	mov    0x23c8(,%eax,4),%eax
    1abb:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1abd:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ac0:	6a 0c                	push   $0xc
    1ac2:	6a 0c                	push   $0xc
    1ac4:	6a 0c                	push   $0xc
    1ac6:	50                   	push   %eax
    1ac7:	e8 df f8 ff ff       	call   13ab <RGB>
    1acc:	83 c4 0c             	add    $0xc,%esp
    1acf:	8b 1d b0 29 00 00    	mov    0x29b0,%ebx
    1ad5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ad8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1adb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ade:	6b c0 32             	imul   $0x32,%eax,%eax
    1ae1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ae4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae7:	8d 78 3c             	lea    0x3c(%eax),%edi
    1aea:	83 ec 0c             	sub    $0xc,%esp
    1aed:	83 ec 04             	sub    $0x4,%esp
    1af0:	89 e0                	mov    %esp,%eax
    1af2:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1af6:	66 89 30             	mov    %si,(%eax)
    1af9:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1afd:	88 50 02             	mov    %dl,0x2(%eax)
    1b00:	6a 32                	push   $0x32
    1b02:	6a 32                	push   $0x32
    1b04:	6a 00                	push   $0x0
    1b06:	6a 00                	push   $0x0
    1b08:	53                   	push   %ebx
    1b09:	51                   	push   %ecx
    1b0a:	ff 75 94             	pushl  -0x6c(%ebp)
    1b0d:	57                   	push   %edi
    1b0e:	e8 f4 f6 ff ff       	call   1207 <APDcCopy>
    1b13:	83 c4 30             	add    $0x30,%esp
                    break;
    1b16:	e9 e3 02 00 00       	jmp    1dfe <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b1b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b1e:	6a 69                	push   $0x69
    1b20:	6a 69                	push   $0x69
    1b22:	6a 69                	push   $0x69
    1b24:	50                   	push   %eax
    1b25:	e8 81 f8 ff ff       	call   13ab <RGB>
    1b2a:	83 c4 0c             	add    $0xc,%esp
    1b2d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b31:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b35:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b39:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b3c:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b43:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b46:	6a 69                	push   $0x69
    1b48:	6a 69                	push   $0x69
    1b4a:	6a 69                	push   $0x69
    1b4c:	50                   	push   %eax
    1b4d:	e8 59 f8 ff ff       	call   13ab <RGB>
    1b52:	83 c4 0c             	add    $0xc,%esp
    1b55:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b59:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b5d:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b61:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b64:	8b 45 08             	mov    0x8(%ebp),%eax
    1b67:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b6a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b6d:	ff 75 b0             	pushl  -0x50(%ebp)
    1b70:	ff 75 ac             	pushl  -0x54(%ebp)
    1b73:	52                   	push   %edx
    1b74:	50                   	push   %eax
    1b75:	e8 61 f0 ff ff       	call   bdb <APSetPen>
    1b7a:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b80:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b83:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b86:	83 ec 04             	sub    $0x4,%esp
    1b89:	83 ec 04             	sub    $0x4,%esp
    1b8c:	89 e0                	mov    %esp,%eax
    1b8e:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b92:	66 89 08             	mov    %cx,(%eax)
    1b95:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b99:	88 48 02             	mov    %cl,0x2(%eax)
    1b9c:	53                   	push   %ebx
    1b9d:	52                   	push   %edx
    1b9e:	e8 71 f0 ff ff       	call   c14 <APSetBrush>
    1ba3:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ba6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ba9:	6b d0 32             	imul   $0x32,%eax,%edx
    1bac:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1baf:	6b c0 32             	imul   $0x32,%eax,%eax
    1bb2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bb5:	83 c1 3c             	add    $0x3c,%ecx
    1bb8:	83 ec 0c             	sub    $0xc,%esp
    1bbb:	6a 32                	push   $0x32
    1bbd:	6a 32                	push   $0x32
    1bbf:	52                   	push   %edx
    1bc0:	50                   	push   %eax
    1bc1:	51                   	push   %ecx
    1bc2:	e8 35 f4 ff ff       	call   ffc <APDrawRect>
    1bc7:	83 c4 20             	add    $0x20,%esp
                    break;
    1bca:	e9 2f 02 00 00       	jmp    1dfe <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bcf:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bd2:	6a 0c                	push   $0xc
    1bd4:	6a 0c                	push   $0xc
    1bd6:	6a 0c                	push   $0xc
    1bd8:	50                   	push   %eax
    1bd9:	e8 cd f7 ff ff       	call   13ab <RGB>
    1bde:	83 c4 0c             	add    $0xc,%esp
    1be1:	8b 1d f0 29 00 00    	mov    0x29f0,%ebx
    1be7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bea:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bed:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bf0:	6b c0 32             	imul   $0x32,%eax,%eax
    1bf3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bf6:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bfc:	83 ec 0c             	sub    $0xc,%esp
    1bff:	83 ec 04             	sub    $0x4,%esp
    1c02:	89 e0                	mov    %esp,%eax
    1c04:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c08:	66 89 30             	mov    %si,(%eax)
    1c0b:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c0f:	88 50 02             	mov    %dl,0x2(%eax)
    1c12:	6a 32                	push   $0x32
    1c14:	6a 32                	push   $0x32
    1c16:	6a 00                	push   $0x0
    1c18:	6a 00                	push   $0x0
    1c1a:	53                   	push   %ebx
    1c1b:	51                   	push   %ecx
    1c1c:	ff 75 94             	pushl  -0x6c(%ebp)
    1c1f:	57                   	push   %edi
    1c20:	e8 e2 f5 ff ff       	call   1207 <APDcCopy>
    1c25:	83 c4 30             	add    $0x30,%esp
                    break;
    1c28:	e9 d1 01 00 00       	jmp    1dfe <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c2d:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c30:	6a 0c                	push   $0xc
    1c32:	6a 0c                	push   $0xc
    1c34:	6a 0c                	push   $0xc
    1c36:	50                   	push   %eax
    1c37:	e8 6f f7 ff ff       	call   13ab <RGB>
    1c3c:	83 c4 0c             	add    $0xc,%esp
    1c3f:	8b 1d d0 29 00 00    	mov    0x29d0,%ebx
    1c45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c48:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c4b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c4e:	6b c0 32             	imul   $0x32,%eax,%eax
    1c51:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c54:	8b 45 08             	mov    0x8(%ebp),%eax
    1c57:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c5a:	83 ec 0c             	sub    $0xc,%esp
    1c5d:	83 ec 04             	sub    $0x4,%esp
    1c60:	89 e0                	mov    %esp,%eax
    1c62:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c66:	66 89 30             	mov    %si,(%eax)
    1c69:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c6d:	88 50 02             	mov    %dl,0x2(%eax)
    1c70:	6a 32                	push   $0x32
    1c72:	6a 32                	push   $0x32
    1c74:	6a 00                	push   $0x0
    1c76:	6a 00                	push   $0x0
    1c78:	53                   	push   %ebx
    1c79:	51                   	push   %ecx
    1c7a:	ff 75 94             	pushl  -0x6c(%ebp)
    1c7d:	57                   	push   %edi
    1c7e:	e8 84 f5 ff ff       	call   1207 <APDcCopy>
    1c83:	83 c4 30             	add    $0x30,%esp
                    break;
    1c86:	e9 73 01 00 00       	jmp    1dfe <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c8b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c8e:	6a 0c                	push   $0xc
    1c90:	6a 0c                	push   $0xc
    1c92:	6a 0c                	push   $0xc
    1c94:	50                   	push   %eax
    1c95:	e8 11 f7 ff ff       	call   13ab <RGB>
    1c9a:	83 c4 0c             	add    $0xc,%esp
    1c9d:	8b 1d b4 29 00 00    	mov    0x29b4,%ebx
    1ca3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ca6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ca9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cac:	6b c0 32             	imul   $0x32,%eax,%eax
    1caf:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cb8:	83 ec 0c             	sub    $0xc,%esp
    1cbb:	83 ec 04             	sub    $0x4,%esp
    1cbe:	89 e0                	mov    %esp,%eax
    1cc0:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cc4:	66 89 30             	mov    %si,(%eax)
    1cc7:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ccb:	88 50 02             	mov    %dl,0x2(%eax)
    1cce:	6a 32                	push   $0x32
    1cd0:	6a 32                	push   $0x32
    1cd2:	6a 00                	push   $0x0
    1cd4:	6a 00                	push   $0x0
    1cd6:	53                   	push   %ebx
    1cd7:	51                   	push   %ecx
    1cd8:	ff 75 94             	pushl  -0x6c(%ebp)
    1cdb:	57                   	push   %edi
    1cdc:	e8 26 f5 ff ff       	call   1207 <APDcCopy>
    1ce1:	83 c4 30             	add    $0x30,%esp
                    break;
    1ce4:	e9 15 01 00 00       	jmp    1dfe <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ce9:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cec:	6a 0c                	push   $0xc
    1cee:	6a 0c                	push   $0xc
    1cf0:	6a 0c                	push   $0xc
    1cf2:	50                   	push   %eax
    1cf3:	e8 b3 f6 ff ff       	call   13ab <RGB>
    1cf8:	83 c4 0c             	add    $0xc,%esp
    1cfb:	8b 1d ec 29 00 00    	mov    0x29ec,%ebx
    1d01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d04:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d07:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d0a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d0d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d10:	8b 45 08             	mov    0x8(%ebp),%eax
    1d13:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d16:	83 ec 0c             	sub    $0xc,%esp
    1d19:	83 ec 04             	sub    $0x4,%esp
    1d1c:	89 e0                	mov    %esp,%eax
    1d1e:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d22:	66 89 30             	mov    %si,(%eax)
    1d25:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d29:	88 50 02             	mov    %dl,0x2(%eax)
    1d2c:	6a 32                	push   $0x32
    1d2e:	6a 32                	push   $0x32
    1d30:	6a 00                	push   $0x0
    1d32:	6a 00                	push   $0x0
    1d34:	53                   	push   %ebx
    1d35:	51                   	push   %ecx
    1d36:	ff 75 94             	pushl  -0x6c(%ebp)
    1d39:	57                   	push   %edi
    1d3a:	e8 c8 f4 ff ff       	call   1207 <APDcCopy>
    1d3f:	83 c4 30             	add    $0x30,%esp
                    break;
    1d42:	e9 b7 00 00 00       	jmp    1dfe <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d47:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d4a:	6a 0c                	push   $0xc
    1d4c:	6a 0c                	push   $0xc
    1d4e:	6a 0c                	push   $0xc
    1d50:	50                   	push   %eax
    1d51:	e8 55 f6 ff ff       	call   13ab <RGB>
    1d56:	83 c4 0c             	add    $0xc,%esp
    1d59:	8b 1d 84 29 00 00    	mov    0x2984,%ebx
    1d5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d62:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d65:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d68:	6b c0 32             	imul   $0x32,%eax,%eax
    1d6b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d71:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d74:	83 ec 0c             	sub    $0xc,%esp
    1d77:	83 ec 04             	sub    $0x4,%esp
    1d7a:	89 e0                	mov    %esp,%eax
    1d7c:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d80:	66 89 30             	mov    %si,(%eax)
    1d83:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d87:	88 50 02             	mov    %dl,0x2(%eax)
    1d8a:	6a 32                	push   $0x32
    1d8c:	6a 32                	push   $0x32
    1d8e:	6a 00                	push   $0x0
    1d90:	6a 00                	push   $0x0
    1d92:	53                   	push   %ebx
    1d93:	51                   	push   %ecx
    1d94:	ff 75 94             	pushl  -0x6c(%ebp)
    1d97:	57                   	push   %edi
    1d98:	e8 6a f4 ff ff       	call   1207 <APDcCopy>
    1d9d:	83 c4 30             	add    $0x30,%esp
                    break;
    1da0:	eb 5c                	jmp    1dfe <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1da2:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1da5:	6a 0c                	push   $0xc
    1da7:	6a 0c                	push   $0xc
    1da9:	6a 0c                	push   $0xc
    1dab:	50                   	push   %eax
    1dac:	e8 fa f5 ff ff       	call   13ab <RGB>
    1db1:	83 c4 0c             	add    $0xc,%esp
    1db4:	8b 1d a0 29 00 00    	mov    0x29a0,%ebx
    1dba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dbd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dc3:	6b c0 32             	imul   $0x32,%eax,%eax
    1dc6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dcc:	8d 78 3c             	lea    0x3c(%eax),%edi
    1dcf:	83 ec 0c             	sub    $0xc,%esp
    1dd2:	83 ec 04             	sub    $0x4,%esp
    1dd5:	89 e0                	mov    %esp,%eax
    1dd7:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1ddb:	66 89 30             	mov    %si,(%eax)
    1dde:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1de2:	88 50 02             	mov    %dl,0x2(%eax)
    1de5:	6a 32                	push   $0x32
    1de7:	6a 32                	push   $0x32
    1de9:	6a 00                	push   $0x0
    1deb:	6a 00                	push   $0x0
    1ded:	53                   	push   %ebx
    1dee:	51                   	push   %ecx
    1def:	ff 75 94             	pushl  -0x6c(%ebp)
    1df2:	57                   	push   %edi
    1df3:	e8 0f f4 ff ff       	call   1207 <APDcCopy>
    1df8:	83 c4 30             	add    $0x30,%esp
                    break;
    1dfb:	eb 01                	jmp    1dfe <APGridPaint+0x639>
                default: break;
    1dfd:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1dfe:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e02:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e06:	0f 8e 7a fc ff ff    	jle    1a86 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e0c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e10:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e14:	0f 8e 60 fc ff ff    	jle    1a7a <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1e1a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e1d:	68 cd 00 00 00       	push   $0xcd
    1e22:	6a 74                	push   $0x74
    1e24:	6a 18                	push   $0x18
    1e26:	50                   	push   %eax
    1e27:	e8 7f f5 ff ff       	call   13ab <RGB>
    1e2c:	83 c4 0c             	add    $0xc,%esp
    1e2f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e33:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e37:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e3b:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e3e:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e45:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e48:	68 cd 00 00 00       	push   $0xcd
    1e4d:	6a 74                	push   $0x74
    1e4f:	6a 18                	push   $0x18
    1e51:	50                   	push   %eax
    1e52:	e8 54 f5 ff ff       	call   13ab <RGB>
    1e57:	83 c4 0c             	add    $0xc,%esp
    1e5a:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e5e:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e62:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e66:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e69:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6c:	8d 50 58             	lea    0x58(%eax),%edx
    1e6f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e72:	ff 75 bc             	pushl  -0x44(%ebp)
    1e75:	ff 75 b8             	pushl  -0x48(%ebp)
    1e78:	52                   	push   %edx
    1e79:	50                   	push   %eax
    1e7a:	e8 5c ed ff ff       	call   bdb <APSetPen>
    1e7f:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e82:	8b 45 08             	mov    0x8(%ebp),%eax
    1e85:	8d 58 58             	lea    0x58(%eax),%ebx
    1e88:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e8b:	83 ec 04             	sub    $0x4,%esp
    1e8e:	83 ec 04             	sub    $0x4,%esp
    1e91:	89 e0                	mov    %esp,%eax
    1e93:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e97:	66 89 08             	mov    %cx,(%eax)
    1e9a:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e9e:	88 48 02             	mov    %cl,0x2(%eax)
    1ea1:	53                   	push   %ebx
    1ea2:	52                   	push   %edx
    1ea3:	e8 6c ed ff ff       	call   c14 <APSetBrush>
    1ea8:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1eab:	8b 45 08             	mov    0x8(%ebp),%eax
    1eae:	83 c0 58             	add    $0x58,%eax
    1eb1:	83 ec 0c             	sub    $0xc,%esp
    1eb4:	6a 32                	push   $0x32
    1eb6:	68 20 03 00 00       	push   $0x320
    1ebb:	6a 00                	push   $0x0
    1ebd:	6a 00                	push   $0x0
    1ebf:	50                   	push   %eax
    1ec0:	e8 37 f1 ff ff       	call   ffc <APDrawRect>
    1ec5:	83 c4 20             	add    $0x20,%esp
}
    1ec8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ecb:	5b                   	pop    %ebx
    1ecc:	5e                   	pop    %esi
    1ecd:	5f                   	pop    %edi
    1ece:	5d                   	pop    %ebp
    1ecf:	c3                   	ret    

00001ed0 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1ed0:	55                   	push   %ebp
    1ed1:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1ed3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1ed7:	7e 08                	jle    1ee1 <random+0x11>
{
rand_num = seed;
    1ed9:	8b 45 08             	mov    0x8(%ebp),%eax
    1edc:	a3 5c 29 00 00       	mov    %eax,0x295c
}
rand_num *= 3;
    1ee1:	8b 15 5c 29 00 00    	mov    0x295c,%edx
    1ee7:	89 d0                	mov    %edx,%eax
    1ee9:	01 c0                	add    %eax,%eax
    1eeb:	01 d0                	add    %edx,%eax
    1eed:	a3 5c 29 00 00       	mov    %eax,0x295c
if (rand_num < 0)
    1ef2:	a1 5c 29 00 00       	mov    0x295c,%eax
    1ef7:	85 c0                	test   %eax,%eax
    1ef9:	79 0c                	jns    1f07 <random+0x37>
{
rand_num *= (-1);
    1efb:	a1 5c 29 00 00       	mov    0x295c,%eax
    1f00:	f7 d8                	neg    %eax
    1f02:	a3 5c 29 00 00       	mov    %eax,0x295c
}
return rand_num % 997;
    1f07:	8b 0d 5c 29 00 00    	mov    0x295c,%ecx
    1f0d:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1f12:	89 c8                	mov    %ecx,%eax
    1f14:	f7 ea                	imul   %edx
    1f16:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1f19:	c1 f8 09             	sar    $0x9,%eax
    1f1c:	89 c2                	mov    %eax,%edx
    1f1e:	89 c8                	mov    %ecx,%eax
    1f20:	c1 f8 1f             	sar    $0x1f,%eax
    1f23:	29 c2                	sub    %eax,%edx
    1f25:	89 d0                	mov    %edx,%eax
    1f27:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f2d:	29 c1                	sub    %eax,%ecx
    1f2f:	89 c8                	mov    %ecx,%eax
}
    1f31:	5d                   	pop    %ebp
    1f32:	c3                   	ret    

00001f33 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f33:	55                   	push   %ebp
    1f34:	89 e5                	mov    %esp,%ebp
    1f36:	53                   	push   %ebx
    1f37:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f41:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f45:	74 17                	je     1f5e <sprintint+0x2b>
    1f47:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f4b:	79 11                	jns    1f5e <sprintint+0x2b>
        neg = 1;
    1f4d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f54:	8b 45 10             	mov    0x10(%ebp),%eax
    1f57:	f7 d8                	neg    %eax
    1f59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f5c:	eb 06                	jmp    1f64 <sprintint+0x31>
    } else {
        x = xx;
    1f5e:	8b 45 10             	mov    0x10(%ebp),%eax
    1f61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f64:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f6b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f6e:	8d 41 01             	lea    0x1(%ecx),%eax
    1f71:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f74:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f77:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f7a:	ba 00 00 00 00       	mov    $0x0,%edx
    1f7f:	f7 f3                	div    %ebx
    1f81:	89 d0                	mov    %edx,%eax
    1f83:	0f b6 80 60 29 00 00 	movzbl 0x2960(%eax),%eax
    1f8a:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f8e:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f91:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f94:	ba 00 00 00 00       	mov    $0x0,%edx
    1f99:	f7 f3                	div    %ebx
    1f9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1fa2:	75 c7                	jne    1f6b <sprintint+0x38>
    if(neg)
    1fa4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fa8:	74 0e                	je     1fb8 <sprintint+0x85>
        buf[i++] = '-';
    1faa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fad:	8d 50 01             	lea    0x1(%eax),%edx
    1fb0:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1fb3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1fb8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fbb:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1fbe:	eb 1b                	jmp    1fdb <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fc3:	8b 00                	mov    (%eax),%eax
    1fc5:	8d 48 01             	lea    0x1(%eax),%ecx
    1fc8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fcb:	89 0a                	mov    %ecx,(%edx)
    1fcd:	89 c2                	mov    %eax,%edx
    1fcf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd2:	01 d0                	add    %edx,%eax
    1fd4:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fd7:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1fdb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fdf:	7f df                	jg     1fc0 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fe1:	eb 21                	jmp    2004 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fe6:	8b 00                	mov    (%eax),%eax
    1fe8:	8d 48 01             	lea    0x1(%eax),%ecx
    1feb:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fee:	89 0a                	mov    %ecx,(%edx)
    1ff0:	89 c2                	mov    %eax,%edx
    1ff2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff5:	01 c2                	add    %eax,%edx
    1ff7:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1ffa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ffd:	01 c8                	add    %ecx,%eax
    1fff:	0f b6 00             	movzbl (%eax),%eax
    2002:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2004:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2008:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    200c:	79 d5                	jns    1fe3 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    200e:	90                   	nop
    200f:	83 c4 20             	add    $0x20,%esp
    2012:	5b                   	pop    %ebx
    2013:	5d                   	pop    %ebp
    2014:	c3                   	ret    

00002015 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2015:	55                   	push   %ebp
    2016:	89 e5                	mov    %esp,%ebp
    2018:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    201b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2022:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2029:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2030:	8d 45 0c             	lea    0xc(%ebp),%eax
    2033:	83 c0 04             	add    $0x4,%eax
    2036:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2039:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2040:	e9 d9 01 00 00       	jmp    221e <sprintf+0x209>
        c = fmt[i] & 0xff;
    2045:	8b 55 0c             	mov    0xc(%ebp),%edx
    2048:	8b 45 ec             	mov    -0x14(%ebp),%eax
    204b:	01 d0                	add    %edx,%eax
    204d:	0f b6 00             	movzbl (%eax),%eax
    2050:	0f be c0             	movsbl %al,%eax
    2053:	25 ff 00 00 00       	and    $0xff,%eax
    2058:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    205b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    205f:	75 2c                	jne    208d <sprintf+0x78>
            if(c == '%'){
    2061:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2065:	75 0c                	jne    2073 <sprintf+0x5e>
                state = '%';
    2067:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    206e:	e9 a7 01 00 00       	jmp    221a <sprintf+0x205>
            } else {
                dst[j++] = c;
    2073:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2076:	8d 50 01             	lea    0x1(%eax),%edx
    2079:	89 55 c8             	mov    %edx,-0x38(%ebp)
    207c:	89 c2                	mov    %eax,%edx
    207e:	8b 45 08             	mov    0x8(%ebp),%eax
    2081:	01 d0                	add    %edx,%eax
    2083:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2086:	88 10                	mov    %dl,(%eax)
    2088:	e9 8d 01 00 00       	jmp    221a <sprintf+0x205>
            }
        } else if(state == '%'){
    208d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2091:	0f 85 83 01 00 00    	jne    221a <sprintf+0x205>
            if(c == 'd'){
    2097:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    209b:	75 4c                	jne    20e9 <sprintf+0xd4>
                buf[bi] = '\0';
    209d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20a3:	01 d0                	add    %edx,%eax
    20a5:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20a8:	83 ec 0c             	sub    $0xc,%esp
    20ab:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20ae:	50                   	push   %eax
    20af:	e8 a1 e1 ff ff       	call   255 <atoi>
    20b4:	83 c4 10             	add    $0x10,%esp
    20b7:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    20ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20c4:	8b 00                	mov    (%eax),%eax
    20c6:	83 ec 08             	sub    $0x8,%esp
    20c9:	ff 75 d8             	pushl  -0x28(%ebp)
    20cc:	6a 01                	push   $0x1
    20ce:	6a 0a                	push   $0xa
    20d0:	50                   	push   %eax
    20d1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20d4:	50                   	push   %eax
    20d5:	ff 75 08             	pushl  0x8(%ebp)
    20d8:	e8 56 fe ff ff       	call   1f33 <sprintint>
    20dd:	83 c4 20             	add    $0x20,%esp
                ap++;
    20e0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20e4:	e9 2a 01 00 00       	jmp    2213 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20e9:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20ed:	74 06                	je     20f5 <sprintf+0xe0>
    20ef:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20f3:	75 4c                	jne    2141 <sprintf+0x12c>
                buf[bi] = '\0';
    20f5:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20fb:	01 d0                	add    %edx,%eax
    20fd:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2106:	50                   	push   %eax
    2107:	e8 49 e1 ff ff       	call   255 <atoi>
    210c:	83 c4 10             	add    $0x10,%esp
    210f:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2112:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    211c:	8b 00                	mov    (%eax),%eax
    211e:	83 ec 08             	sub    $0x8,%esp
    2121:	ff 75 dc             	pushl  -0x24(%ebp)
    2124:	6a 00                	push   $0x0
    2126:	6a 10                	push   $0x10
    2128:	50                   	push   %eax
    2129:	8d 45 c8             	lea    -0x38(%ebp),%eax
    212c:	50                   	push   %eax
    212d:	ff 75 08             	pushl  0x8(%ebp)
    2130:	e8 fe fd ff ff       	call   1f33 <sprintint>
    2135:	83 c4 20             	add    $0x20,%esp
                ap++;
    2138:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    213c:	e9 d2 00 00 00       	jmp    2213 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2141:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2145:	75 46                	jne    218d <sprintf+0x178>
                s = (char*)*ap;
    2147:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    214a:	8b 00                	mov    (%eax),%eax
    214c:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    214f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2153:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2157:	75 25                	jne    217e <sprintf+0x169>
                    s = "(null)";
    2159:	c7 45 f4 e8 23 00 00 	movl   $0x23e8,-0xc(%ebp)
                while(*s != 0){
    2160:	eb 1c                	jmp    217e <sprintf+0x169>
                    dst[j++] = *s;
    2162:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2165:	8d 50 01             	lea    0x1(%eax),%edx
    2168:	89 55 c8             	mov    %edx,-0x38(%ebp)
    216b:	89 c2                	mov    %eax,%edx
    216d:	8b 45 08             	mov    0x8(%ebp),%eax
    2170:	01 c2                	add    %eax,%edx
    2172:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2175:	0f b6 00             	movzbl (%eax),%eax
    2178:	88 02                	mov    %al,(%edx)
                    s++;
    217a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    217e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2181:	0f b6 00             	movzbl (%eax),%eax
    2184:	84 c0                	test   %al,%al
    2186:	75 da                	jne    2162 <sprintf+0x14d>
    2188:	e9 86 00 00 00       	jmp    2213 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    218d:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2191:	75 1d                	jne    21b0 <sprintf+0x19b>
                dst[j++] = *ap;
    2193:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2196:	8d 50 01             	lea    0x1(%eax),%edx
    2199:	89 55 c8             	mov    %edx,-0x38(%ebp)
    219c:	89 c2                	mov    %eax,%edx
    219e:	8b 45 08             	mov    0x8(%ebp),%eax
    21a1:	01 c2                	add    %eax,%edx
    21a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21a6:	8b 00                	mov    (%eax),%eax
    21a8:	88 02                	mov    %al,(%edx)
                ap++;
    21aa:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21ae:	eb 63                	jmp    2213 <sprintf+0x1fe>
            } else if(c == '%'){
    21b0:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21b4:	75 17                	jne    21cd <sprintf+0x1b8>
                dst[j++] = c;
    21b6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21b9:	8d 50 01             	lea    0x1(%eax),%edx
    21bc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21bf:	89 c2                	mov    %eax,%edx
    21c1:	8b 45 08             	mov    0x8(%ebp),%eax
    21c4:	01 d0                	add    %edx,%eax
    21c6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21c9:	88 10                	mov    %dl,(%eax)
    21cb:	eb 46                	jmp    2213 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21cd:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21d1:	7e 18                	jle    21eb <sprintf+0x1d6>
    21d3:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21d7:	7f 12                	jg     21eb <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21dc:	8d 50 01             	lea    0x1(%eax),%edx
    21df:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21e2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21e5:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21e9:	eb 2f                	jmp    221a <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21eb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21ee:	8d 50 01             	lea    0x1(%eax),%edx
    21f1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21f4:	89 c2                	mov    %eax,%edx
    21f6:	8b 45 08             	mov    0x8(%ebp),%eax
    21f9:	01 d0                	add    %edx,%eax
    21fb:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21fe:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2201:	8d 50 01             	lea    0x1(%eax),%edx
    2204:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2207:	89 c2                	mov    %eax,%edx
    2209:	8b 45 08             	mov    0x8(%ebp),%eax
    220c:	01 d0                	add    %edx,%eax
    220e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2211:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2213:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    221a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    221e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2221:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2224:	01 d0                	add    %edx,%eax
    2226:	0f b6 00             	movzbl (%eax),%eax
    2229:	84 c0                	test   %al,%al
    222b:	0f 85 14 fe ff ff    	jne    2045 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2231:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2234:	8d 50 01             	lea    0x1(%eax),%edx
    2237:	89 55 c8             	mov    %edx,-0x38(%ebp)
    223a:	89 c2                	mov    %eax,%edx
    223c:	8b 45 08             	mov    0x8(%ebp),%eax
    223f:	01 d0                	add    %edx,%eax
    2241:	c6 00 00             	movb   $0x0,(%eax)
}
    2244:	90                   	nop
    2245:	c9                   	leave  
    2246:	c3                   	ret    
