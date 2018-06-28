
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
      1c:	68 c8 1e 00 00       	push   $0x1ec8
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
      6f:	68 dc 1e 00 00       	push   $0x1edc
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
     422:	0f b6 80 64 25 00 00 	movzbl 0x2564(%eax),%eax
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
     560:	c7 45 f4 f5 1e 00 00 	movl   $0x1ef5,-0xc(%ebp)
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
     626:	a1 94 25 00 00       	mov    0x2594,%eax
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
     6f1:	a3 94 25 00 00       	mov    %eax,0x2594
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
     752:	a1 94 25 00 00       	mov    0x2594,%eax
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
     76e:	a1 94 25 00 00       	mov    0x2594,%eax
     773:	89 45 f0             	mov    %eax,-0x10(%ebp)
     776:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     77a:	75 23                	jne    79f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     77c:	c7 45 f0 8c 25 00 00 	movl   $0x258c,-0x10(%ebp)
     783:	8b 45 f0             	mov    -0x10(%ebp),%eax
     786:	a3 94 25 00 00       	mov    %eax,0x2594
     78b:	a1 94 25 00 00       	mov    0x2594,%eax
     790:	a3 8c 25 00 00       	mov    %eax,0x258c
    base.s.size = 0;
     795:	c7 05 90 25 00 00 00 	movl   $0x0,0x2590
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
     7f2:	a3 94 25 00 00       	mov    %eax,0x2594
      return (void*)(p + 1);
     7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fa:	83 c0 08             	add    $0x8,%eax
     7fd:	eb 3b                	jmp    83a <malloc+0xe1>
    }
    if(p == freep)
     7ff:	a1 94 25 00 00       	mov    0x2594,%eax
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
     90f:	56                   	push   %esi
     910:	53                   	push   %ebx
     911:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     914:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     91b:	8b 45 cc             	mov    -0x34(%ebp),%eax
     91e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     921:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     928:	83 ec 08             	sub    $0x8,%esp
     92b:	6a 00                	push   $0x0
     92d:	ff 75 0c             	pushl  0xc(%ebp)
     930:	e8 f2 f9 ff ff       	call   327 <open>
     935:	83 c4 10             	add    $0x10,%esp
     938:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     93b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     93f:	79 2e                	jns    96f <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     941:	83 ec 04             	sub    $0x4,%esp
     944:	ff 75 0c             	pushl  0xc(%ebp)
     947:	68 fc 1e 00 00       	push   $0x1efc
     94c:	6a 01                	push   $0x1
     94e:	e8 33 fb ff ff       	call   486 <printf>
     953:	83 c4 10             	add    $0x10,%esp
        return bmp;
     956:	8b 45 08             	mov    0x8(%ebp),%eax
     959:	8b 55 c8             	mov    -0x38(%ebp),%edx
     95c:	89 10                	mov    %edx,(%eax)
     95e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     961:	89 50 04             	mov    %edx,0x4(%eax)
     964:	8b 55 d0             	mov    -0x30(%ebp),%edx
     967:	89 50 08             	mov    %edx,0x8(%eax)
     96a:	e9 1b 02 00 00       	jmp    b8a <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     96f:	83 ec 04             	sub    $0x4,%esp
     972:	6a 10                	push   $0x10
     974:	8d 45 b8             	lea    -0x48(%ebp),%eax
     977:	50                   	push   %eax
     978:	ff 75 ec             	pushl  -0x14(%ebp)
     97b:	e8 7f f9 ff ff       	call   2ff <read>
     980:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     983:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     987:	0f b7 f0             	movzwl %ax,%esi
     98a:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     98e:	0f b7 d8             	movzwl %ax,%ebx
     991:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     994:	8b 55 bc             	mov    -0x44(%ebp),%edx
     997:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     99b:	0f b7 c0             	movzwl %ax,%eax
     99e:	83 ec 04             	sub    $0x4,%esp
     9a1:	56                   	push   %esi
     9a2:	53                   	push   %ebx
     9a3:	51                   	push   %ecx
     9a4:	52                   	push   %edx
     9a5:	50                   	push   %eax
     9a6:	68 0c 1f 00 00       	push   $0x1f0c
     9ab:	6a 01                	push   $0x1
     9ad:	e8 d4 fa ff ff       	call   486 <printf>
     9b2:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     9b5:	83 ec 04             	sub    $0x4,%esp
     9b8:	6a 28                	push   $0x28
     9ba:	8d 45 90             	lea    -0x70(%ebp),%eax
     9bd:	50                   	push   %eax
     9be:	ff 75 ec             	pushl  -0x14(%ebp)
     9c1:	e8 39 f9 ff ff       	call   2ff <read>
     9c6:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     9c9:	8b 45 94             	mov    -0x6c(%ebp),%eax
     9cc:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     9cf:	8b 45 98             	mov    -0x68(%ebp),%eax
     9d2:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     9d5:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9d8:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9db:	52                   	push   %edx
     9dc:	50                   	push   %eax
     9dd:	68 1c 1f 00 00       	push   $0x1f1c
     9e2:	6a 01                	push   $0x1
     9e4:	e8 9d fa ff ff       	call   486 <printf>
     9e9:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9ec:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9ef:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9f2:	0f af d0             	imul   %eax,%edx
     9f5:	89 d0                	mov    %edx,%eax
     9f7:	01 c0                	add    %eax,%eax
     9f9:	01 d0                	add    %edx,%eax
     9fb:	83 ec 0c             	sub    $0xc,%esp
     9fe:	50                   	push   %eax
     9ff:	e8 55 fd ff ff       	call   759 <malloc>
     a04:	83 c4 10             	add    $0x10,%esp
     a07:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a0a:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     a0e:	0f b7 c0             	movzwl %ax,%eax
     a11:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a14:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a17:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a1a:	0f af c2             	imul   %edx,%eax
     a1d:	83 c0 1f             	add    $0x1f,%eax
     a20:	c1 e8 05             	shr    $0x5,%eax
     a23:	c1 e0 02             	shl    $0x2,%eax
     a26:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a29:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a2c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a2f:	0f af c2             	imul   %edx,%eax
     a32:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a35:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a38:	83 ec 0c             	sub    $0xc,%esp
     a3b:	50                   	push   %eax
     a3c:	e8 18 fd ff ff       	call   759 <malloc>
     a41:	83 c4 10             	add    $0x10,%esp
     a44:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a47:	83 ec 04             	sub    $0x4,%esp
     a4a:	ff 75 e0             	pushl  -0x20(%ebp)
     a4d:	ff 75 dc             	pushl  -0x24(%ebp)
     a50:	ff 75 ec             	pushl  -0x14(%ebp)
     a53:	e8 a7 f8 ff ff       	call   2ff <read>
     a58:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a5b:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     a5f:	66 c1 e8 03          	shr    $0x3,%ax
     a63:	0f b7 c0             	movzwl %ax,%eax
     a66:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a69:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a70:	e9 e5 00 00 00       	jmp    b5a <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a75:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7b:	29 c2                	sub    %eax,%edx
     a7d:	89 d0                	mov    %edx,%eax
     a7f:	8d 50 ff             	lea    -0x1(%eax),%edx
     a82:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a85:	0f af c2             	imul   %edx,%eax
     a88:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a8b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a92:	e9 b1 00 00 00       	jmp    b48 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a97:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a9a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa0:	01 c8                	add    %ecx,%eax
     aa2:	89 c1                	mov    %eax,%ecx
     aa4:	89 c8                	mov    %ecx,%eax
     aa6:	01 c0                	add    %eax,%eax
     aa8:	01 c8                	add    %ecx,%eax
     aaa:	01 c2                	add    %eax,%edx
     aac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aaf:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ab3:	89 c1                	mov    %eax,%ecx
     ab5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ab8:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     abc:	01 c1                	add    %eax,%ecx
     abe:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac1:	01 c8                	add    %ecx,%eax
     ac3:	8d 48 ff             	lea    -0x1(%eax),%ecx
     ac6:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ac9:	01 c8                	add    %ecx,%eax
     acb:	0f b6 00             	movzbl (%eax),%eax
     ace:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     ad1:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ad4:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ada:	01 c8                	add    %ecx,%eax
     adc:	89 c1                	mov    %eax,%ecx
     ade:	89 c8                	mov    %ecx,%eax
     ae0:	01 c0                	add    %eax,%eax
     ae2:	01 c8                	add    %ecx,%eax
     ae4:	01 c2                	add    %eax,%edx
     ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae9:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     aed:	89 c1                	mov    %eax,%ecx
     aef:	8b 45 d8             	mov    -0x28(%ebp),%eax
     af2:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     af6:	01 c1                	add    %eax,%ecx
     af8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     afb:	01 c8                	add    %ecx,%eax
     afd:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b00:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b03:	01 c8                	add    %ecx,%eax
     b05:	0f b6 00             	movzbl (%eax),%eax
     b08:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b0b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b0e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b11:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b14:	01 c8                	add    %ecx,%eax
     b16:	89 c1                	mov    %eax,%ecx
     b18:	89 c8                	mov    %ecx,%eax
     b1a:	01 c0                	add    %eax,%eax
     b1c:	01 c8                	add    %ecx,%eax
     b1e:	01 c2                	add    %eax,%edx
     b20:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b23:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b27:	89 c1                	mov    %eax,%ecx
     b29:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b2c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b30:	01 c1                	add    %eax,%ecx
     b32:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b35:	01 c8                	add    %ecx,%eax
     b37:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b3d:	01 c8                	add    %ecx,%eax
     b3f:	0f b6 00             	movzbl (%eax),%eax
     b42:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b44:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b48:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b4e:	39 c2                	cmp    %eax,%edx
     b50:	0f 87 41 ff ff ff    	ja     a97 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b56:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b5a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b60:	39 c2                	cmp    %eax,%edx
     b62:	0f 87 0d ff ff ff    	ja     a75 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b68:	83 ec 0c             	sub    $0xc,%esp
     b6b:	ff 75 ec             	pushl  -0x14(%ebp)
     b6e:	e8 9c f7 ff ff       	call   30f <close>
     b73:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b76:	8b 45 08             	mov    0x8(%ebp),%eax
     b79:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b7c:	89 10                	mov    %edx,(%eax)
     b7e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b81:	89 50 04             	mov    %edx,0x4(%eax)
     b84:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b87:	89 50 08             	mov    %edx,0x8(%eax)
}
     b8a:	8b 45 08             	mov    0x8(%ebp),%eax
     b8d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b90:	5b                   	pop    %ebx
     b91:	5e                   	pop    %esi
     b92:	5d                   	pop    %ebp
     b93:	c2 04 00             	ret    $0x4

00000b96 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b96:	55                   	push   %ebp
     b97:	89 e5                	mov    %esp,%ebp
     b99:	53                   	push   %ebx
     b9a:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b9d:	83 ec 0c             	sub    $0xc,%esp
     ba0:	6a 1c                	push   $0x1c
     ba2:	e8 b2 fb ff ff       	call   759 <malloc>
     ba7:	83 c4 10             	add    $0x10,%esp
     baa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     bb7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     bba:	8d 45 d8             	lea    -0x28(%ebp),%eax
     bbd:	6a 0c                	push   $0xc
     bbf:	6a 0c                	push   $0xc
     bc1:	6a 0c                	push   $0xc
     bc3:	50                   	push   %eax
     bc4:	e8 73 fc ff ff       	call   83c <RGB>
     bc9:	83 c4 0c             	add    $0xc,%esp
     bcc:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     bd0:	66 89 43 13          	mov    %ax,0x13(%ebx)
     bd4:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     bd8:	88 43 15             	mov    %al,0x15(%ebx)
     bdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bde:	8b 55 f4             	mov    -0xc(%ebp),%edx
     be1:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     be5:	66 89 48 10          	mov    %cx,0x10(%eax)
     be9:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     bed:	88 50 12             	mov    %dl,0x12(%eax)
     bf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bf6:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bfa:	66 89 48 08          	mov    %cx,0x8(%eax)
     bfe:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c02:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c05:	8b 45 08             	mov    0x8(%ebp),%eax
     c08:	89 c2                	mov    %eax,%edx
     c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0d:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
     c12:	89 c2                	mov    %eax,%edx
     c14:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c17:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c1a:	8b 55 10             	mov    0x10(%ebp),%edx
     c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c20:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     c23:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c29:	c9                   	leave  
     c2a:	c3                   	ret    

00000c2b <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c2b:	55                   	push   %ebp
     c2c:	89 e5                	mov    %esp,%ebp
     c2e:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c31:	8b 45 0c             	mov    0xc(%ebp),%eax
     c34:	8b 50 08             	mov    0x8(%eax),%edx
     c37:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c3a:	8b 40 0c             	mov    0xc(%eax),%eax
     c3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c40:	8b 45 0c             	mov    0xc(%ebp),%eax
     c43:	8b 55 10             	mov    0x10(%ebp),%edx
     c46:	89 50 08             	mov    %edx,0x8(%eax)
     c49:	8b 55 14             	mov    0x14(%ebp),%edx
     c4c:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c4f:	8b 45 08             	mov    0x8(%ebp),%eax
     c52:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c55:	89 10                	mov    %edx,(%eax)
     c57:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c5a:	89 50 04             	mov    %edx,0x4(%eax)
}
     c5d:	8b 45 08             	mov    0x8(%ebp),%eax
     c60:	c9                   	leave  
     c61:	c2 04 00             	ret    $0x4

00000c64 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c64:	55                   	push   %ebp
     c65:	89 e5                	mov    %esp,%ebp
     c67:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6d:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c71:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c75:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c79:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7f:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c83:	66 89 50 10          	mov    %dx,0x10(%eax)
     c87:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c8b:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c8e:	8b 45 08             	mov    0x8(%ebp),%eax
     c91:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c95:	66 89 10             	mov    %dx,(%eax)
     c98:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c9c:	88 50 02             	mov    %dl,0x2(%eax)
}
     c9f:	8b 45 08             	mov    0x8(%ebp),%eax
     ca2:	c9                   	leave  
     ca3:	c2 04 00             	ret    $0x4

00000ca6 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     ca6:	55                   	push   %ebp
     ca7:	89 e5                	mov    %esp,%ebp
     ca9:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     cac:	8b 45 08             	mov    0x8(%ebp),%eax
     caf:	8b 40 0c             	mov    0xc(%eax),%eax
     cb2:	89 c2                	mov    %eax,%edx
     cb4:	c1 ea 1f             	shr    $0x1f,%edx
     cb7:	01 d0                	add    %edx,%eax
     cb9:	d1 f8                	sar    %eax
     cbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc1:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cc8:	8b 45 10             	mov    0x10(%ebp),%eax
     ccb:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cce:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cd5:	0f 89 98 00 00 00    	jns    d73 <APDrawPoint+0xcd>
        i = 0;
     cdb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     ce2:	e9 8c 00 00 00       	jmp    d73 <APDrawPoint+0xcd>
    {
        j = x - off;
     ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
     cea:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ced:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cf0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cf4:	79 69                	jns    d5f <APDrawPoint+0xb9>
            j = 0;
     cf6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cfd:	eb 60                	jmp    d5f <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cff:	ff 75 fc             	pushl  -0x4(%ebp)
     d02:	ff 75 f8             	pushl  -0x8(%ebp)
     d05:	ff 75 08             	pushl  0x8(%ebp)
     d08:	e8 ad fb ff ff       	call   8ba <APGetIndex>
     d0d:	83 c4 0c             	add    $0xc,%esp
     d10:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d13:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d17:	74 55                	je     d6e <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d19:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d1d:	74 67                	je     d86 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d1f:	ff 75 10             	pushl  0x10(%ebp)
     d22:	ff 75 0c             	pushl  0xc(%ebp)
     d25:	ff 75 fc             	pushl  -0x4(%ebp)
     d28:	ff 75 f8             	pushl  -0x8(%ebp)
     d2b:	e8 51 fb ff ff       	call   881 <distance_2>
     d30:	83 c4 10             	add    $0x10,%esp
     d33:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d36:	7f 23                	jg     d5b <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d38:	8b 45 08             	mov    0x8(%ebp),%eax
     d3b:	8b 48 18             	mov    0x18(%eax),%ecx
     d3e:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d41:	89 d0                	mov    %edx,%eax
     d43:	01 c0                	add    %eax,%eax
     d45:	01 d0                	add    %edx,%eax
     d47:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d4a:	8b 45 08             	mov    0x8(%ebp),%eax
     d4d:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d51:	66 89 0a             	mov    %cx,(%edx)
     d54:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d58:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d5b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d5f:	8b 55 0c             	mov    0xc(%ebp),%edx
     d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d65:	01 d0                	add    %edx,%eax
     d67:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d6a:	7d 93                	jge    cff <APDrawPoint+0x59>
     d6c:	eb 01                	jmp    d6f <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d6e:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d6f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d73:	8b 55 10             	mov    0x10(%ebp),%edx
     d76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d79:	01 d0                	add    %edx,%eax
     d7b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d7e:	0f 8d 63 ff ff ff    	jge    ce7 <APDrawPoint+0x41>
     d84:	eb 01                	jmp    d87 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d86:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d87:	c9                   	leave  
     d88:	c3                   	ret    

00000d89 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d89:	55                   	push   %ebp
     d8a:	89 e5                	mov    %esp,%ebp
     d8c:	53                   	push   %ebx
     d8d:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d90:	8b 45 0c             	mov    0xc(%ebp),%eax
     d93:	3b 45 14             	cmp    0x14(%ebp),%eax
     d96:	0f 85 80 00 00 00    	jne    e1c <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d9c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     da0:	0f 88 9d 02 00 00    	js     1043 <APDrawLine+0x2ba>
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	8b 00                	mov    (%eax),%eax
     dab:	3b 45 0c             	cmp    0xc(%ebp),%eax
     dae:	0f 8e 8f 02 00 00    	jle    1043 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     db4:	8b 45 10             	mov    0x10(%ebp),%eax
     db7:	3b 45 18             	cmp    0x18(%ebp),%eax
     dba:	7e 12                	jle    dce <APDrawLine+0x45>
        {
            int tmp = y2;
     dbc:	8b 45 18             	mov    0x18(%ebp),%eax
     dbf:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     dc2:	8b 45 10             	mov    0x10(%ebp),%eax
     dc5:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dc8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dcb:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     dce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dd2:	79 07                	jns    ddb <APDrawLine+0x52>
     dd4:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     ddb:	8b 45 08             	mov    0x8(%ebp),%eax
     dde:	8b 40 04             	mov    0x4(%eax),%eax
     de1:	3b 45 18             	cmp    0x18(%ebp),%eax
     de4:	7d 0c                	jge    df2 <APDrawLine+0x69>
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
     de9:	8b 40 04             	mov    0x4(%eax),%eax
     dec:	83 e8 01             	sub    $0x1,%eax
     def:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     df2:	8b 45 10             	mov    0x10(%ebp),%eax
     df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     df8:	eb 15                	jmp    e0f <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dfa:	ff 75 f4             	pushl  -0xc(%ebp)
     dfd:	ff 75 0c             	pushl  0xc(%ebp)
     e00:	ff 75 08             	pushl  0x8(%ebp)
     e03:	e8 9e fe ff ff       	call   ca6 <APDrawPoint>
     e08:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e0b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e12:	3b 45 18             	cmp    0x18(%ebp),%eax
     e15:	7e e3                	jle    dfa <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e17:	e9 2b 02 00 00       	jmp    1047 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e1c:	8b 45 10             	mov    0x10(%ebp),%eax
     e1f:	3b 45 18             	cmp    0x18(%ebp),%eax
     e22:	75 7f                	jne    ea3 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e28:	0f 88 18 02 00 00    	js     1046 <APDrawLine+0x2bd>
     e2e:	8b 45 08             	mov    0x8(%ebp),%eax
     e31:	8b 40 04             	mov    0x4(%eax),%eax
     e34:	3b 45 10             	cmp    0x10(%ebp),%eax
     e37:	0f 8e 09 02 00 00    	jle    1046 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e3d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e40:	3b 45 14             	cmp    0x14(%ebp),%eax
     e43:	7e 12                	jle    e57 <APDrawLine+0xce>
        {
            int tmp = x2;
     e45:	8b 45 14             	mov    0x14(%ebp),%eax
     e48:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e4b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e4e:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e51:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e54:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e57:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e5b:	79 07                	jns    e64 <APDrawLine+0xdb>
     e5d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e64:	8b 45 08             	mov    0x8(%ebp),%eax
     e67:	8b 00                	mov    (%eax),%eax
     e69:	3b 45 14             	cmp    0x14(%ebp),%eax
     e6c:	7d 0b                	jge    e79 <APDrawLine+0xf0>
     e6e:	8b 45 08             	mov    0x8(%ebp),%eax
     e71:	8b 00                	mov    (%eax),%eax
     e73:	83 e8 01             	sub    $0x1,%eax
     e76:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e79:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e7f:	eb 15                	jmp    e96 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e81:	ff 75 10             	pushl  0x10(%ebp)
     e84:	ff 75 f0             	pushl  -0x10(%ebp)
     e87:	ff 75 08             	pushl  0x8(%ebp)
     e8a:	e8 17 fe ff ff       	call   ca6 <APDrawPoint>
     e8f:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e92:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e96:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e99:	3b 45 14             	cmp    0x14(%ebp),%eax
     e9c:	7e e3                	jle    e81 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e9e:	e9 a4 01 00 00       	jmp    1047 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ea3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     eaa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     eb1:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb4:	2b 45 14             	sub    0x14(%ebp),%eax
     eb7:	50                   	push   %eax
     eb8:	e8 ed f9 ff ff       	call   8aa <abs_int>
     ebd:	83 c4 04             	add    $0x4,%esp
     ec0:	89 c3                	mov    %eax,%ebx
     ec2:	8b 45 10             	mov    0x10(%ebp),%eax
     ec5:	2b 45 18             	sub    0x18(%ebp),%eax
     ec8:	50                   	push   %eax
     ec9:	e8 dc f9 ff ff       	call   8aa <abs_int>
     ece:	83 c4 04             	add    $0x4,%esp
     ed1:	39 c3                	cmp    %eax,%ebx
     ed3:	0f 8e b5 00 00 00    	jle    f8e <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ed9:	8b 45 10             	mov    0x10(%ebp),%eax
     edc:	2b 45 18             	sub    0x18(%ebp),%eax
     edf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee2:	db 45 b0             	fildl  -0x50(%ebp)
     ee5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee8:	2b 45 14             	sub    0x14(%ebp),%eax
     eeb:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eee:	db 45 b0             	fildl  -0x50(%ebp)
     ef1:	de f9                	fdivrp %st,%st(1)
     ef3:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     ef6:	8b 45 14             	mov    0x14(%ebp),%eax
     ef9:	3b 45 0c             	cmp    0xc(%ebp),%eax
     efc:	7e 0e                	jle    f0c <APDrawLine+0x183>
        {
            s = x1;
     efe:	8b 45 0c             	mov    0xc(%ebp),%eax
     f01:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f04:	8b 45 14             	mov    0x14(%ebp),%eax
     f07:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f0a:	eb 0c                	jmp    f18 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f0c:	8b 45 14             	mov    0x14(%ebp),%eax
     f0f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f12:	8b 45 0c             	mov    0xc(%ebp),%eax
     f15:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f18:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f1c:	79 07                	jns    f25 <APDrawLine+0x19c>
     f1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f25:	8b 45 08             	mov    0x8(%ebp),%eax
     f28:	8b 00                	mov    (%eax),%eax
     f2a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f2d:	7f 0b                	jg     f3a <APDrawLine+0x1b1>
     f2f:	8b 45 08             	mov    0x8(%ebp),%eax
     f32:	8b 00                	mov    (%eax),%eax
     f34:	83 e8 01             	sub    $0x1,%eax
     f37:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f3d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f40:	eb 3f                	jmp    f81 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f45:	2b 45 0c             	sub    0xc(%ebp),%eax
     f48:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f4b:	db 45 b0             	fildl  -0x50(%ebp)
     f4e:	dc 4d d0             	fmull  -0x30(%ebp)
     f51:	db 45 10             	fildl  0x10(%ebp)
     f54:	de c1                	faddp  %st,%st(1)
     f56:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f59:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f5d:	b4 0c                	mov    $0xc,%ah
     f5f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f63:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f66:	db 5d cc             	fistpl -0x34(%ebp)
     f69:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f6c:	ff 75 cc             	pushl  -0x34(%ebp)
     f6f:	ff 75 e4             	pushl  -0x1c(%ebp)
     f72:	ff 75 08             	pushl  0x8(%ebp)
     f75:	e8 2c fd ff ff       	call   ca6 <APDrawPoint>
     f7a:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f7d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f84:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f87:	7e b9                	jle    f42 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f89:	e9 b9 00 00 00       	jmp    1047 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     f91:	2b 45 14             	sub    0x14(%ebp),%eax
     f94:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f97:	db 45 b0             	fildl  -0x50(%ebp)
     f9a:	8b 45 10             	mov    0x10(%ebp),%eax
     f9d:	2b 45 18             	sub    0x18(%ebp),%eax
     fa0:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa3:	db 45 b0             	fildl  -0x50(%ebp)
     fa6:	de f9                	fdivrp %st,%st(1)
     fa8:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fab:	8b 45 10             	mov    0x10(%ebp),%eax
     fae:	3b 45 18             	cmp    0x18(%ebp),%eax
     fb1:	7e 0e                	jle    fc1 <APDrawLine+0x238>
    {
        s = y2;
     fb3:	8b 45 18             	mov    0x18(%ebp),%eax
     fb6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fb9:	8b 45 10             	mov    0x10(%ebp),%eax
     fbc:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fbf:	eb 0c                	jmp    fcd <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fc1:	8b 45 10             	mov    0x10(%ebp),%eax
     fc4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fc7:	8b 45 18             	mov    0x18(%ebp),%eax
     fca:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fcd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fd1:	79 07                	jns    fda <APDrawLine+0x251>
     fd3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fda:	8b 45 08             	mov    0x8(%ebp),%eax
     fdd:	8b 40 04             	mov    0x4(%eax),%eax
     fe0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fe3:	7f 0c                	jg     ff1 <APDrawLine+0x268>
     fe5:	8b 45 08             	mov    0x8(%ebp),%eax
     fe8:	8b 40 04             	mov    0x4(%eax),%eax
     feb:	83 e8 01             	sub    $0x1,%eax
     fee:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     ff1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ff4:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ff7:	eb 3f                	jmp    1038 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     ff9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ffc:	2b 45 10             	sub    0x10(%ebp),%eax
     fff:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1002:	db 45 b0             	fildl  -0x50(%ebp)
    1005:	dc 4d c0             	fmull  -0x40(%ebp)
    1008:	db 45 0c             	fildl  0xc(%ebp)
    100b:	de c1                	faddp  %st,%st(1)
    100d:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1010:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1014:	b4 0c                	mov    $0xc,%ah
    1016:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    101a:	d9 6d b4             	fldcw  -0x4c(%ebp)
    101d:	db 5d bc             	fistpl -0x44(%ebp)
    1020:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1023:	ff 75 e0             	pushl  -0x20(%ebp)
    1026:	ff 75 bc             	pushl  -0x44(%ebp)
    1029:	ff 75 08             	pushl  0x8(%ebp)
    102c:	e8 75 fc ff ff       	call   ca6 <APDrawPoint>
    1031:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1034:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1038:	8b 45 e0             	mov    -0x20(%ebp),%eax
    103b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    103e:	7e b9                	jle    ff9 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1040:	90                   	nop
    1041:	eb 04                	jmp    1047 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1043:	90                   	nop
    1044:	eb 01                	jmp    1047 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1046:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1047:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    104a:	c9                   	leave  
    104b:	c3                   	ret    

0000104c <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    104c:	55                   	push   %ebp
    104d:	89 e5                	mov    %esp,%ebp
    104f:	53                   	push   %ebx
    1050:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1053:	8b 55 10             	mov    0x10(%ebp),%edx
    1056:	8b 45 18             	mov    0x18(%ebp),%eax
    1059:	01 d0                	add    %edx,%eax
    105b:	83 e8 01             	sub    $0x1,%eax
    105e:	83 ec 04             	sub    $0x4,%esp
    1061:	50                   	push   %eax
    1062:	ff 75 0c             	pushl  0xc(%ebp)
    1065:	ff 75 10             	pushl  0x10(%ebp)
    1068:	ff 75 0c             	pushl  0xc(%ebp)
    106b:	ff 75 08             	pushl  0x8(%ebp)
    106e:	e8 16 fd ff ff       	call   d89 <APDrawLine>
    1073:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1076:	8b 55 0c             	mov    0xc(%ebp),%edx
    1079:	8b 45 14             	mov    0x14(%ebp),%eax
    107c:	01 d0                	add    %edx,%eax
    107e:	83 e8 01             	sub    $0x1,%eax
    1081:	83 ec 04             	sub    $0x4,%esp
    1084:	ff 75 10             	pushl  0x10(%ebp)
    1087:	50                   	push   %eax
    1088:	ff 75 10             	pushl  0x10(%ebp)
    108b:	ff 75 0c             	pushl  0xc(%ebp)
    108e:	ff 75 08             	pushl  0x8(%ebp)
    1091:	e8 f3 fc ff ff       	call   d89 <APDrawLine>
    1096:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1099:	8b 55 10             	mov    0x10(%ebp),%edx
    109c:	8b 45 18             	mov    0x18(%ebp),%eax
    109f:	01 d0                	add    %edx,%eax
    10a1:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10a4:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a7:	8b 45 14             	mov    0x14(%ebp),%eax
    10aa:	01 d0                	add    %edx,%eax
    10ac:	8d 50 ff             	lea    -0x1(%eax),%edx
    10af:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10b2:	8b 45 14             	mov    0x14(%ebp),%eax
    10b5:	01 d8                	add    %ebx,%eax
    10b7:	83 e8 01             	sub    $0x1,%eax
    10ba:	83 ec 04             	sub    $0x4,%esp
    10bd:	51                   	push   %ecx
    10be:	52                   	push   %edx
    10bf:	ff 75 10             	pushl  0x10(%ebp)
    10c2:	50                   	push   %eax
    10c3:	ff 75 08             	pushl  0x8(%ebp)
    10c6:	e8 be fc ff ff       	call   d89 <APDrawLine>
    10cb:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10ce:	8b 55 10             	mov    0x10(%ebp),%edx
    10d1:	8b 45 18             	mov    0x18(%ebp),%eax
    10d4:	01 d0                	add    %edx,%eax
    10d6:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    10dc:	8b 45 14             	mov    0x14(%ebp),%eax
    10df:	01 d0                	add    %edx,%eax
    10e1:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e4:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10e7:	8b 45 18             	mov    0x18(%ebp),%eax
    10ea:	01 d8                	add    %ebx,%eax
    10ec:	83 e8 01             	sub    $0x1,%eax
    10ef:	83 ec 04             	sub    $0x4,%esp
    10f2:	51                   	push   %ecx
    10f3:	52                   	push   %edx
    10f4:	50                   	push   %eax
    10f5:	ff 75 0c             	pushl  0xc(%ebp)
    10f8:	ff 75 08             	pushl  0x8(%ebp)
    10fb:	e8 89 fc ff ff       	call   d89 <APDrawLine>
    1100:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1103:	8b 55 0c             	mov    0xc(%ebp),%edx
    1106:	8b 45 14             	mov    0x14(%ebp),%eax
    1109:	01 d0                	add    %edx,%eax
    110b:	8d 50 ff             	lea    -0x1(%eax),%edx
    110e:	8b 45 08             	mov    0x8(%ebp),%eax
    1111:	8b 40 0c             	mov    0xc(%eax),%eax
    1114:	89 c1                	mov    %eax,%ecx
    1116:	c1 e9 1f             	shr    $0x1f,%ecx
    1119:	01 c8                	add    %ecx,%eax
    111b:	d1 f8                	sar    %eax
    111d:	29 c2                	sub    %eax,%edx
    111f:	89 d0                	mov    %edx,%eax
    1121:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1124:	8b 55 10             	mov    0x10(%ebp),%edx
    1127:	8b 45 18             	mov    0x18(%ebp),%eax
    112a:	01 d0                	add    %edx,%eax
    112c:	8d 50 ff             	lea    -0x1(%eax),%edx
    112f:	8b 45 08             	mov    0x8(%ebp),%eax
    1132:	8b 40 0c             	mov    0xc(%eax),%eax
    1135:	89 c1                	mov    %eax,%ecx
    1137:	c1 e9 1f             	shr    $0x1f,%ecx
    113a:	01 c8                	add    %ecx,%eax
    113c:	d1 f8                	sar    %eax
    113e:	29 c2                	sub    %eax,%edx
    1140:	89 d0                	mov    %edx,%eax
    1142:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1145:	8b 45 08             	mov    0x8(%ebp),%eax
    1148:	8b 40 0c             	mov    0xc(%eax),%eax
    114b:	89 c2                	mov    %eax,%edx
    114d:	c1 ea 1f             	shr    $0x1f,%edx
    1150:	01 d0                	add    %edx,%eax
    1152:	d1 f8                	sar    %eax
    1154:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1157:	8b 45 08             	mov    0x8(%ebp),%eax
    115a:	8b 40 0c             	mov    0xc(%eax),%eax
    115d:	89 c2                	mov    %eax,%edx
    115f:	c1 ea 1f             	shr    $0x1f,%edx
    1162:	01 d0                	add    %edx,%eax
    1164:	d1 f8                	sar    %eax
    1166:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1169:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    116d:	0f 88 d8 00 00 00    	js     124b <APDrawRect+0x1ff>
    1173:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1177:	0f 88 ce 00 00 00    	js     124b <APDrawRect+0x1ff>
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	8b 00                	mov    (%eax),%eax
    1182:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1185:	0f 8e c0 00 00 00    	jle    124b <APDrawRect+0x1ff>
    118b:	8b 45 08             	mov    0x8(%ebp),%eax
    118e:	8b 40 04             	mov    0x4(%eax),%eax
    1191:	3b 45 10             	cmp    0x10(%ebp),%eax
    1194:	0f 8e b1 00 00 00    	jle    124b <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    119a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    119e:	79 07                	jns    11a7 <APDrawRect+0x15b>
    11a0:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11ab:	79 07                	jns    11b4 <APDrawRect+0x168>
    11ad:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	8b 00                	mov    (%eax),%eax
    11b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11bc:	7f 0b                	jg     11c9 <APDrawRect+0x17d>
    11be:	8b 45 08             	mov    0x8(%ebp),%eax
    11c1:	8b 00                	mov    (%eax),%eax
    11c3:	83 e8 01             	sub    $0x1,%eax
    11c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11c9:	8b 45 08             	mov    0x8(%ebp),%eax
    11cc:	8b 40 04             	mov    0x4(%eax),%eax
    11cf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11d2:	7f 0c                	jg     11e0 <APDrawRect+0x194>
    11d4:	8b 45 08             	mov    0x8(%ebp),%eax
    11d7:	8b 40 04             	mov    0x4(%eax),%eax
    11da:	83 e8 01             	sub    $0x1,%eax
    11dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11ed:	eb 52                	jmp    1241 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11ef:	8b 45 10             	mov    0x10(%ebp),%eax
    11f2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11f5:	eb 3e                	jmp    1235 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11f7:	83 ec 04             	sub    $0x4,%esp
    11fa:	ff 75 e8             	pushl  -0x18(%ebp)
    11fd:	ff 75 ec             	pushl  -0x14(%ebp)
    1200:	ff 75 08             	pushl  0x8(%ebp)
    1203:	e8 b2 f6 ff ff       	call   8ba <APGetIndex>
    1208:	83 c4 10             	add    $0x10,%esp
    120b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    120e:	8b 45 08             	mov    0x8(%ebp),%eax
    1211:	8b 48 18             	mov    0x18(%eax),%ecx
    1214:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1217:	89 d0                	mov    %edx,%eax
    1219:	01 c0                	add    %eax,%eax
    121b:	01 d0                	add    %edx,%eax
    121d:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1220:	8b 45 08             	mov    0x8(%ebp),%eax
    1223:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1227:	66 89 0a             	mov    %cx,(%edx)
    122a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    122e:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1231:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1235:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1238:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    123b:	7e ba                	jle    11f7 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    123d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1241:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1244:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1247:	7e a6                	jle    11ef <APDrawRect+0x1a3>
    1249:	eb 01                	jmp    124c <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    124b:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    124c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    124f:	c9                   	leave  
    1250:	c3                   	ret    

00001251 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1251:	55                   	push   %ebp
    1252:	89 e5                	mov    %esp,%ebp
    1254:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1257:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    125b:	0f 88 8e 01 00 00    	js     13ef <APDcCopy+0x19e>
    1261:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1265:	0f 88 84 01 00 00    	js     13ef <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    126b:	8b 55 0c             	mov    0xc(%ebp),%edx
    126e:	8b 45 20             	mov    0x20(%ebp),%eax
    1271:	01 d0                	add    %edx,%eax
    1273:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1276:	8b 55 10             	mov    0x10(%ebp),%edx
    1279:	8b 45 24             	mov    0x24(%ebp),%eax
    127c:	01 d0                	add    %edx,%eax
    127e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1281:	8b 55 18             	mov    0x18(%ebp),%edx
    1284:	8b 45 20             	mov    0x20(%ebp),%eax
    1287:	01 d0                	add    %edx,%eax
    1289:	89 45 ec             	mov    %eax,-0x14(%ebp)
    128c:	8b 55 1c             	mov    0x1c(%ebp),%edx
    128f:	8b 45 24             	mov    0x24(%ebp),%eax
    1292:	01 d0                	add    %edx,%eax
    1294:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1297:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    129b:	0f 88 51 01 00 00    	js     13f2 <APDcCopy+0x1a1>
    12a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12a5:	0f 88 47 01 00 00    	js     13f2 <APDcCopy+0x1a1>
    12ab:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12af:	0f 88 3d 01 00 00    	js     13f2 <APDcCopy+0x1a1>
    12b5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12b9:	0f 88 33 01 00 00    	js     13f2 <APDcCopy+0x1a1>
    12bf:	8b 45 14             	mov    0x14(%ebp),%eax
    12c2:	8b 00                	mov    (%eax),%eax
    12c4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12c7:	0f 8e 25 01 00 00    	jle    13f2 <APDcCopy+0x1a1>
    12cd:	8b 45 14             	mov    0x14(%ebp),%eax
    12d0:	8b 40 04             	mov    0x4(%eax),%eax
    12d3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12d6:	0f 8e 16 01 00 00    	jle    13f2 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    12dc:	8b 45 08             	mov    0x8(%ebp),%eax
    12df:	8b 00                	mov    (%eax),%eax
    12e1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    12e4:	7d 0b                	jge    12f1 <APDcCopy+0xa0>
    12e6:	8b 45 08             	mov    0x8(%ebp),%eax
    12e9:	8b 00                	mov    (%eax),%eax
    12eb:	83 e8 01             	sub    $0x1,%eax
    12ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    12f1:	8b 45 08             	mov    0x8(%ebp),%eax
    12f4:	8b 40 04             	mov    0x4(%eax),%eax
    12f7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12fa:	7d 0c                	jge    1308 <APDcCopy+0xb7>
    12fc:	8b 45 08             	mov    0x8(%ebp),%eax
    12ff:	8b 40 04             	mov    0x4(%eax),%eax
    1302:	83 e8 01             	sub    $0x1,%eax
    1305:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1308:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    130f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    1316:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    131d:	e9 bc 00 00 00       	jmp    13de <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1322:	8b 45 08             	mov    0x8(%ebp),%eax
    1325:	8b 00                	mov    (%eax),%eax
    1327:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    132a:	8b 55 10             	mov    0x10(%ebp),%edx
    132d:	01 ca                	add    %ecx,%edx
    132f:	0f af d0             	imul   %eax,%edx
    1332:	8b 45 0c             	mov    0xc(%ebp),%eax
    1335:	01 d0                	add    %edx,%eax
    1337:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    133a:	8b 45 14             	mov    0x14(%ebp),%eax
    133d:	8b 00                	mov    (%eax),%eax
    133f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1342:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1345:	01 ca                	add    %ecx,%edx
    1347:	0f af d0             	imul   %eax,%edx
    134a:	8b 45 18             	mov    0x18(%ebp),%eax
    134d:	01 d0                	add    %edx,%eax
    134f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    1352:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1359:	eb 74                	jmp    13cf <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    135b:	8b 45 14             	mov    0x14(%ebp),%eax
    135e:	8b 50 18             	mov    0x18(%eax),%edx
    1361:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1364:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1367:	01 c8                	add    %ecx,%eax
    1369:	89 c1                	mov    %eax,%ecx
    136b:	89 c8                	mov    %ecx,%eax
    136d:	01 c0                	add    %eax,%eax
    136f:	01 c8                	add    %ecx,%eax
    1371:	01 d0                	add    %edx,%eax
    1373:	0f b7 10             	movzwl (%eax),%edx
    1376:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    137a:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    137e:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1381:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1385:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1389:	38 c2                	cmp    %al,%dl
    138b:	75 18                	jne    13a5 <APDcCopy+0x154>
    138d:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1391:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1395:	38 c2                	cmp    %al,%dl
    1397:	75 0c                	jne    13a5 <APDcCopy+0x154>
    1399:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    139d:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13a1:	38 c2                	cmp    %al,%dl
    13a3:	74 26                	je     13cb <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13a5:	8b 45 08             	mov    0x8(%ebp),%eax
    13a8:	8b 50 18             	mov    0x18(%eax),%edx
    13ab:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b1:	01 c8                	add    %ecx,%eax
    13b3:	89 c1                	mov    %eax,%ecx
    13b5:	89 c8                	mov    %ecx,%eax
    13b7:	01 c0                	add    %eax,%eax
    13b9:	01 c8                	add    %ecx,%eax
    13bb:	01 d0                	add    %edx,%eax
    13bd:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13c1:	66 89 10             	mov    %dx,(%eax)
    13c4:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13c8:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    13cb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13d2:	2b 45 0c             	sub    0xc(%ebp),%eax
    13d5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13d8:	7f 81                	jg     135b <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    13da:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13de:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13e1:	2b 45 10             	sub    0x10(%ebp),%eax
    13e4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13e7:	0f 8f 35 ff ff ff    	jg     1322 <APDcCopy+0xd1>
    13ed:	eb 04                	jmp    13f3 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    13ef:	90                   	nop
    13f0:	eb 01                	jmp    13f3 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    13f2:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13f3:	c9                   	leave  
    13f4:	c3                   	ret    

000013f5 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13f5:	55                   	push   %ebp
    13f6:	89 e5                	mov    %esp,%ebp
    13f8:	83 ec 1c             	sub    $0x1c,%esp
    13fb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13fe:	8b 55 10             	mov    0x10(%ebp),%edx
    1401:	8b 45 14             	mov    0x14(%ebp),%eax
    1404:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1407:	88 55 e8             	mov    %dl,-0x18(%ebp)
    140a:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    140d:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1411:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1414:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1418:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    141b:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    141f:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1422:	8b 45 08             	mov    0x8(%ebp),%eax
    1425:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1429:	66 89 10             	mov    %dx,(%eax)
    142c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1430:	88 50 02             	mov    %dl,0x2(%eax)
}
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	c9                   	leave  
    1437:	c2 04 00             	ret    $0x4

0000143a <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    143a:	55                   	push   %ebp
    143b:	89 e5                	mov    %esp,%ebp
    143d:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1440:	8b 45 08             	mov    0x8(%ebp),%eax
    1443:	8b 00                	mov    (%eax),%eax
    1445:	83 ec 08             	sub    $0x8,%esp
    1448:	8d 55 0c             	lea    0xc(%ebp),%edx
    144b:	52                   	push   %edx
    144c:	50                   	push   %eax
    144d:	e8 45 ef ff ff       	call   397 <sendMessage>
    1452:	83 c4 10             	add    $0x10,%esp
}
    1455:	90                   	nop
    1456:	c9                   	leave  
    1457:	c3                   	ret    

00001458 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1458:	55                   	push   %ebp
    1459:	89 e5                	mov    %esp,%ebp
    145b:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    145e:	83 ec 0c             	sub    $0xc,%esp
    1461:	68 90 00 00 00       	push   $0x90
    1466:	e8 ee f2 ff ff       	call   759 <malloc>
    146b:	83 c4 10             	add    $0x10,%esp
    146e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1471:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1475:	75 15                	jne    148c <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1477:	83 ec 04             	sub    $0x4,%esp
    147a:	ff 75 08             	pushl  0x8(%ebp)
    147d:	68 40 1f 00 00       	push   $0x1f40
    1482:	6a 01                	push   $0x1
    1484:	e8 fd ef ff ff       	call   486 <printf>
    1489:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    148c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148f:	83 c0 7c             	add    $0x7c,%eax
    1492:	83 ec 08             	sub    $0x8,%esp
    1495:	ff 75 08             	pushl  0x8(%ebp)
    1498:	50                   	push   %eax
    1499:	e8 18 ec ff ff       	call   b6 <strcpy>
    149e:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a4:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ae:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b8:	8b 40 34             	mov    0x34(%eax),%eax
    14bb:	89 c2                	mov    %eax,%edx
    14bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c0:	8b 40 38             	mov    0x38(%eax),%eax
    14c3:	0f af d0             	imul   %eax,%edx
    14c6:	89 d0                	mov    %edx,%eax
    14c8:	01 c0                	add    %eax,%eax
    14ca:	01 d0                	add    %edx,%eax
    14cc:	83 ec 0c             	sub    $0xc,%esp
    14cf:	50                   	push   %eax
    14d0:	e8 84 f2 ff ff       	call   759 <malloc>
    14d5:	83 c4 10             	add    $0x10,%esp
    14d8:	89 c2                	mov    %eax,%edx
    14da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dd:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    14e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e3:	8b 40 4c             	mov    0x4c(%eax),%eax
    14e6:	85 c0                	test   %eax,%eax
    14e8:	75 15                	jne    14ff <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    14ea:	83 ec 04             	sub    $0x4,%esp
    14ed:	ff 75 08             	pushl  0x8(%ebp)
    14f0:	68 60 1f 00 00       	push   $0x1f60
    14f5:	6a 01                	push   $0x1
    14f7:	e8 8a ef ff ff       	call   486 <printf>
    14fc:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1502:	8b 40 34             	mov    0x34(%eax),%eax
    1505:	89 c2                	mov    %eax,%edx
    1507:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150a:	8b 40 38             	mov    0x38(%eax),%eax
    150d:	0f af d0             	imul   %eax,%edx
    1510:	89 d0                	mov    %edx,%eax
    1512:	01 c0                	add    %eax,%eax
    1514:	01 c2                	add    %eax,%edx
    1516:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1519:	8b 40 4c             	mov    0x4c(%eax),%eax
    151c:	83 ec 04             	sub    $0x4,%esp
    151f:	52                   	push   %edx
    1520:	68 ff ff ff 00       	push   $0xffffff
    1525:	50                   	push   %eax
    1526:	e8 21 ec ff ff       	call   14c <memset>
    152b:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    152e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1531:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1538:	e8 2a ee ff ff       	call   367 <getpid>
    153d:	89 c2                	mov    %eax,%edx
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1545:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1548:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    154f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1552:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1559:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155c:	8b 40 50             	mov    0x50(%eax),%eax
    155f:	89 c2                	mov    %eax,%edx
    1561:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1564:	8b 40 54             	mov    0x54(%eax),%eax
    1567:	0f af d0             	imul   %eax,%edx
    156a:	89 d0                	mov    %edx,%eax
    156c:	01 c0                	add    %eax,%eax
    156e:	01 d0                	add    %edx,%eax
    1570:	83 ec 0c             	sub    $0xc,%esp
    1573:	50                   	push   %eax
    1574:	e8 e0 f1 ff ff       	call   759 <malloc>
    1579:	83 c4 10             	add    $0x10,%esp
    157c:	89 c2                	mov    %eax,%edx
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1584:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1587:	8b 40 68             	mov    0x68(%eax),%eax
    158a:	85 c0                	test   %eax,%eax
    158c:	75 15                	jne    15a3 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    158e:	83 ec 04             	sub    $0x4,%esp
    1591:	ff 75 08             	pushl  0x8(%ebp)
    1594:	68 84 1f 00 00       	push   $0x1f84
    1599:	6a 01                	push   $0x1
    159b:	e8 e6 ee ff ff       	call   486 <printf>
    15a0:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a6:	8b 40 34             	mov    0x34(%eax),%eax
    15a9:	89 c2                	mov    %eax,%edx
    15ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ae:	8b 40 38             	mov    0x38(%eax),%eax
    15b1:	0f af d0             	imul   %eax,%edx
    15b4:	89 d0                	mov    %edx,%eax
    15b6:	01 c0                	add    %eax,%eax
    15b8:	01 c2                	add    %eax,%edx
    15ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bd:	8b 40 4c             	mov    0x4c(%eax),%eax
    15c0:	83 ec 04             	sub    $0x4,%esp
    15c3:	52                   	push   %edx
    15c4:	68 ff 00 00 00       	push   $0xff
    15c9:	50                   	push   %eax
    15ca:	e8 7d eb ff ff       	call   14c <memset>
    15cf:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    15d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    15d8:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    15db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15df:	74 35                	je     1616 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    15e1:	8b 45 10             	mov    0x10(%ebp),%eax
    15e4:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    15ea:	83 ec 0c             	sub    $0xc,%esp
    15ed:	50                   	push   %eax
    15ee:	e8 66 f1 ff ff       	call   759 <malloc>
    15f3:	83 c4 10             	add    $0x10,%esp
    15f6:	89 c2                	mov    %eax,%edx
    15f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fb:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1601:	8b 55 10             	mov    0x10(%ebp),%edx
    1604:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1607:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1611:	e9 8d 00 00 00       	jmp    16a3 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1619:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1620:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1623:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	8b 40 18             	mov    0x18(%eax),%eax
    1630:	89 c2                	mov    %eax,%edx
    1632:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1635:	8b 40 1c             	mov    0x1c(%eax),%eax
    1638:	0f af d0             	imul   %eax,%edx
    163b:	89 d0                	mov    %edx,%eax
    163d:	01 c0                	add    %eax,%eax
    163f:	01 d0                	add    %edx,%eax
    1641:	83 ec 0c             	sub    $0xc,%esp
    1644:	50                   	push   %eax
    1645:	e8 0f f1 ff ff       	call   759 <malloc>
    164a:	83 c4 10             	add    $0x10,%esp
    164d:	89 c2                	mov    %eax,%edx
    164f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1652:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1655:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1658:	8b 40 30             	mov    0x30(%eax),%eax
    165b:	85 c0                	test   %eax,%eax
    165d:	75 15                	jne    1674 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    165f:	83 ec 04             	sub    $0x4,%esp
    1662:	ff 75 08             	pushl  0x8(%ebp)
    1665:	68 ac 1f 00 00       	push   $0x1fac
    166a:	6a 01                	push   $0x1
    166c:	e8 15 ee ff ff       	call   486 <printf>
    1671:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1674:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1677:	8b 40 18             	mov    0x18(%eax),%eax
    167a:	89 c2                	mov    %eax,%edx
    167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167f:	8b 40 1c             	mov    0x1c(%eax),%eax
    1682:	0f af d0             	imul   %eax,%edx
    1685:	89 d0                	mov    %edx,%eax
    1687:	01 c0                	add    %eax,%eax
    1689:	01 c2                	add    %eax,%edx
    168b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168e:	8b 40 30             	mov    0x30(%eax),%eax
    1691:	83 ec 04             	sub    $0x4,%esp
    1694:	52                   	push   %edx
    1695:	68 ff ff ff 00       	push   $0xffffff
    169a:	50                   	push   %eax
    169b:	e8 ac ea ff ff       	call   14c <memset>
    16a0:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16a6:	c9                   	leave  
    16a7:	c3                   	ret    

000016a8 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16a8:	55                   	push   %ebp
    16a9:	89 e5                	mov    %esp,%ebp
    16ab:	53                   	push   %ebx
    16ac:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16af:	8b 45 0c             	mov    0xc(%ebp),%eax
    16b2:	83 f8 03             	cmp    $0x3,%eax
    16b5:	74 02                	je     16b9 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    16b7:	eb 33                	jmp    16ec <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    16b9:	8b 45 08             	mov    0x8(%ebp),%eax
    16bc:	8b 48 08             	mov    0x8(%eax),%ecx
    16bf:	8b 45 08             	mov    0x8(%ebp),%eax
    16c2:	8b 50 38             	mov    0x38(%eax),%edx
    16c5:	8b 45 08             	mov    0x8(%ebp),%eax
    16c8:	8b 40 34             	mov    0x34(%eax),%eax
    16cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16ce:	83 c3 34             	add    $0x34,%ebx
    16d1:	83 ec 0c             	sub    $0xc,%esp
    16d4:	51                   	push   %ecx
    16d5:	52                   	push   %edx
    16d6:	50                   	push   %eax
    16d7:	6a 00                	push   $0x0
    16d9:	6a 00                	push   $0x0
    16db:	53                   	push   %ebx
    16dc:	6a 32                	push   $0x32
    16de:	6a 00                	push   $0x0
    16e0:	ff 75 08             	pushl  0x8(%ebp)
    16e3:	e8 9f ec ff ff       	call   387 <paintWindow>
    16e8:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16eb:	90                   	nop
        default: break;
            
            
    }
    return False;
    16ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16f4:	c9                   	leave  
    16f5:	c3                   	ret    

000016f6 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16f6:	55                   	push   %ebp
    16f7:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16fc:	8b 50 08             	mov    0x8(%eax),%edx
    16ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1702:	8b 00                	mov    (%eax),%eax
    1704:	39 c2                	cmp    %eax,%edx
    1706:	74 07                	je     170f <APPreJudge+0x19>
        return False;
    1708:	b8 00 00 00 00       	mov    $0x0,%eax
    170d:	eb 05                	jmp    1714 <APPreJudge+0x1e>
    return True;
    170f:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1714:	5d                   	pop    %ebp
    1715:	c3                   	ret    

00001716 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1716:	55                   	push   %ebp
    1717:	89 e5                	mov    %esp,%ebp
    1719:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    171c:	8b 45 08             	mov    0x8(%ebp),%eax
    171f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1722:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1725:	83 ec 0c             	sub    $0xc,%esp
    1728:	ff 75 08             	pushl  0x8(%ebp)
    172b:	e8 77 ec ff ff       	call   3a7 <registWindow>
    1730:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1733:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    173a:	8b 45 08             	mov    0x8(%ebp),%eax
    173d:	8b 00                	mov    (%eax),%eax
    173f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1742:	ff 75 f4             	pushl  -0xc(%ebp)
    1745:	ff 75 f0             	pushl  -0x10(%ebp)
    1748:	ff 75 ec             	pushl  -0x14(%ebp)
    174b:	ff 75 08             	pushl  0x8(%ebp)
    174e:	e8 e7 fc ff ff       	call   143a <APSendMessage>
    1753:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1756:	83 ec 0c             	sub    $0xc,%esp
    1759:	ff 75 08             	pushl  0x8(%ebp)
    175c:	e8 3e ec ff ff       	call   39f <getMessage>
    1761:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1764:	8b 45 08             	mov    0x8(%ebp),%eax
    1767:	83 c0 6c             	add    $0x6c,%eax
    176a:	83 ec 08             	sub    $0x8,%esp
    176d:	50                   	push   %eax
    176e:	ff 75 08             	pushl  0x8(%ebp)
    1771:	e8 80 ff ff ff       	call   16f6 <APPreJudge>
    1776:	83 c4 10             	add    $0x10,%esp
    1779:	84 c0                	test   %al,%al
    177b:	74 1b                	je     1798 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    177d:	8b 45 08             	mov    0x8(%ebp),%eax
    1780:	ff 70 74             	pushl  0x74(%eax)
    1783:	ff 70 70             	pushl  0x70(%eax)
    1786:	ff 70 6c             	pushl  0x6c(%eax)
    1789:	ff 75 08             	pushl  0x8(%ebp)
    178c:	8b 45 0c             	mov    0xc(%ebp),%eax
    178f:	ff d0                	call   *%eax
    1791:	83 c4 10             	add    $0x10,%esp
    1794:	84 c0                	test   %al,%al
    1796:	75 0c                	jne    17a4 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1798:	8b 45 08             	mov    0x8(%ebp),%eax
    179b:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    17a2:	eb b2                	jmp    1756 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17a4:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17a5:	90                   	nop
    17a6:	c9                   	leave  
    17a7:	c3                   	ret    

000017a8 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17a8:	55                   	push   %ebp
    17a9:	89 e5                	mov    %esp,%ebp
    17ab:	57                   	push   %edi
    17ac:	56                   	push   %esi
    17ad:	53                   	push   %ebx
    17ae:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    17b1:	a1 98 25 00 00       	mov    0x2598,%eax
    17b6:	85 c0                	test   %eax,%eax
    17b8:	75 7c                	jne    1836 <APGridPaint+0x8e>
    {
        iconReady = 1;
    17ba:	c7 05 98 25 00 00 01 	movl   $0x1,0x2598
    17c1:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    17c4:	8d 45 b8             	lea    -0x48(%ebp),%eax
    17c7:	83 ec 08             	sub    $0x8,%esp
    17ca:	68 d3 1f 00 00       	push   $0x1fd3
    17cf:	50                   	push   %eax
    17d0:	e8 37 f1 ff ff       	call   90c <APLoadBitmap>
    17d5:	83 c4 0c             	add    $0xc,%esp
    17d8:	8b 45 b8             	mov    -0x48(%ebp),%eax
    17db:	a3 9c 25 00 00       	mov    %eax,0x259c
    17e0:	8b 45 bc             	mov    -0x44(%ebp),%eax
    17e3:	a3 a0 25 00 00       	mov    %eax,0x25a0
    17e8:	8b 45 c0             	mov    -0x40(%ebp),%eax
    17eb:	a3 a4 25 00 00       	mov    %eax,0x25a4
        printf(1,"bitmap loaded!\n");
    17f0:	83 ec 08             	sub    $0x8,%esp
    17f3:	68 dd 1f 00 00       	push   $0x1fdd
    17f8:	6a 01                	push   $0x1
    17fa:	e8 87 ec ff ff       	call   486 <printf>
    17ff:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1802:	83 ec 04             	sub    $0x4,%esp
    1805:	ff 35 a4 25 00 00    	pushl  0x25a4
    180b:	ff 35 a0 25 00 00    	pushl  0x25a0
    1811:	ff 35 9c 25 00 00    	pushl  0x259c
    1817:	e8 7a f3 ff ff       	call   b96 <APCreateCompatibleDCFromBitmap>
    181c:	83 c4 10             	add    $0x10,%esp
    181f:	a3 a8 25 00 00       	mov    %eax,0x25a8
        printf(1,"bitmap DC created!\n");
    1824:	83 ec 08             	sub    $0x8,%esp
    1827:	68 ed 1f 00 00       	push   $0x1fed
    182c:	6a 01                	push   $0x1
    182e:	e8 53 ec ff ff       	call   486 <printf>
    1833:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    1836:	8b 45 08             	mov    0x8(%ebp),%eax
    1839:	8b 40 08             	mov    0x8(%eax),%eax
    183c:	85 c0                	test   %eax,%eax
    183e:	75 17                	jne    1857 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1840:	83 ec 08             	sub    $0x8,%esp
    1843:	68 04 20 00 00       	push   $0x2004
    1848:	6a 01                	push   $0x1
    184a:	e8 37 ec ff ff       	call   486 <printf>
    184f:	83 c4 10             	add    $0x10,%esp
        return;
    1852:	e9 55 03 00 00       	jmp    1bac <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1857:	8b 45 08             	mov    0x8(%ebp),%eax
    185a:	8b 40 10             	mov    0x10(%eax),%eax
    185d:	85 c0                	test   %eax,%eax
    185f:	7e 10                	jle    1871 <APGridPaint+0xc9>
    1861:	8b 45 08             	mov    0x8(%ebp),%eax
    1864:	8b 50 14             	mov    0x14(%eax),%edx
    1867:	8b 45 08             	mov    0x8(%ebp),%eax
    186a:	8b 40 10             	mov    0x10(%eax),%eax
    186d:	39 c2                	cmp    %eax,%edx
    186f:	7c 17                	jl     1888 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1871:	83 ec 08             	sub    $0x8,%esp
    1874:	68 2a 20 00 00       	push   $0x202a
    1879:	6a 01                	push   $0x1
    187b:	e8 06 ec ff ff       	call   486 <printf>
    1880:	83 c4 10             	add    $0x10,%esp
        return;
    1883:	e9 24 03 00 00       	jmp    1bac <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1888:	8b 45 08             	mov    0x8(%ebp),%eax
    188b:	8b 40 14             	mov    0x14(%eax),%eax
    188e:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1894:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1897:	8b 45 dc             	mov    -0x24(%ebp),%eax
    189a:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    189d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    18a4:	e9 f9 02 00 00       	jmp    1ba2 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    18a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    18b0:	e9 df 02 00 00       	jmp    1b94 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    18b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18b8:	c1 e0 04             	shl    $0x4,%eax
    18bb:	89 c2                	mov    %eax,%edx
    18bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
    18c0:	01 c2                	add    %eax,%edx
    18c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    18c5:	01 d0                	add    %edx,%eax
    18c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    18ca:	8b 45 08             	mov    0x8(%ebp),%eax
    18cd:	8b 40 0c             	mov    0xc(%eax),%eax
    18d0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    18d3:	c1 e2 02             	shl    $0x2,%edx
    18d6:	01 d0                	add    %edx,%eax
    18d8:	8b 00                	mov    (%eax),%eax
    18da:	83 f8 01             	cmp    $0x1,%eax
    18dd:	0f 84 83 00 00 00    	je     1966 <APGridPaint+0x1be>
    18e3:	83 f8 01             	cmp    $0x1,%eax
    18e6:	7f 09                	jg     18f1 <APGridPaint+0x149>
    18e8:	85 c0                	test   %eax,%eax
    18ea:	74 1c                	je     1908 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    18ec:	e9 9f 02 00 00       	jmp    1b90 <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    18f1:	83 f8 02             	cmp    $0x2,%eax
    18f4:	0f 84 20 01 00 00    	je     1a1a <APGridPaint+0x272>
    18fa:	83 f8 03             	cmp    $0x3,%eax
    18fd:	0f 84 d1 01 00 00    	je     1ad4 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1903:	e9 88 02 00 00       	jmp    1b90 <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1908:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    190b:	6a 0c                	push   $0xc
    190d:	6a 0c                	push   $0xc
    190f:	6a 0c                	push   $0xc
    1911:	50                   	push   %eax
    1912:	e8 de fa ff ff       	call   13f5 <RGB>
    1917:	83 c4 0c             	add    $0xc,%esp
    191a:	8b 1d a8 25 00 00    	mov    0x25a8,%ebx
    1920:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1923:	6b c8 32             	imul   $0x32,%eax,%ecx
    1926:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1929:	6b c0 32             	imul   $0x32,%eax,%eax
    192c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    192f:	8b 45 08             	mov    0x8(%ebp),%eax
    1932:	8d 78 34             	lea    0x34(%eax),%edi
    1935:	83 ec 0c             	sub    $0xc,%esp
    1938:	83 ec 04             	sub    $0x4,%esp
    193b:	89 e0                	mov    %esp,%eax
    193d:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1941:	66 89 30             	mov    %si,(%eax)
    1944:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1948:	88 50 02             	mov    %dl,0x2(%eax)
    194b:	6a 32                	push   $0x32
    194d:	6a 32                	push   $0x32
    194f:	6a 00                	push   $0x0
    1951:	6a 00                	push   $0x0
    1953:	53                   	push   %ebx
    1954:	51                   	push   %ecx
    1955:	ff 75 b4             	pushl  -0x4c(%ebp)
    1958:	57                   	push   %edi
    1959:	e8 f3 f8 ff ff       	call   1251 <APDcCopy>
    195e:	83 c4 30             	add    $0x30,%esp
                    break;
    1961:	e9 2a 02 00 00       	jmp    1b90 <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1966:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1969:	6a 69                	push   $0x69
    196b:	6a 69                	push   $0x69
    196d:	6a 69                	push   $0x69
    196f:	50                   	push   %eax
    1970:	e8 80 fa ff ff       	call   13f5 <RGB>
    1975:	83 c4 0c             	add    $0xc,%esp
    1978:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    197c:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1980:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1984:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1987:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    198e:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1991:	6a 69                	push   $0x69
    1993:	6a 69                	push   $0x69
    1995:	6a 69                	push   $0x69
    1997:	50                   	push   %eax
    1998:	e8 58 fa ff ff       	call   13f5 <RGB>
    199d:	83 c4 0c             	add    $0xc,%esp
    19a0:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    19a4:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    19a8:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    19ac:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	8d 50 34             	lea    0x34(%eax),%edx
    19b5:	8d 45 b8             	lea    -0x48(%ebp),%eax
    19b8:	ff 75 d0             	pushl  -0x30(%ebp)
    19bb:	ff 75 cc             	pushl  -0x34(%ebp)
    19be:	52                   	push   %edx
    19bf:	50                   	push   %eax
    19c0:	e8 66 f2 ff ff       	call   c2b <APSetPen>
    19c5:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    19c8:	8b 45 08             	mov    0x8(%ebp),%eax
    19cb:	8d 58 34             	lea    0x34(%eax),%ebx
    19ce:	8d 55 b8             	lea    -0x48(%ebp),%edx
    19d1:	83 ec 04             	sub    $0x4,%esp
    19d4:	83 ec 04             	sub    $0x4,%esp
    19d7:	89 e0                	mov    %esp,%eax
    19d9:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    19dd:	66 89 08             	mov    %cx,(%eax)
    19e0:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    19e4:	88 48 02             	mov    %cl,0x2(%eax)
    19e7:	53                   	push   %ebx
    19e8:	52                   	push   %edx
    19e9:	e8 76 f2 ff ff       	call   c64 <APSetBrush>
    19ee:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    19f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19f4:	6b d0 32             	imul   $0x32,%eax,%edx
    19f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19fa:	6b c0 32             	imul   $0x32,%eax,%eax
    19fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a00:	83 c1 34             	add    $0x34,%ecx
    1a03:	83 ec 0c             	sub    $0xc,%esp
    1a06:	6a 32                	push   $0x32
    1a08:	6a 32                	push   $0x32
    1a0a:	52                   	push   %edx
    1a0b:	50                   	push   %eax
    1a0c:	51                   	push   %ecx
    1a0d:	e8 3a f6 ff ff       	call   104c <APDrawRect>
    1a12:	83 c4 20             	add    $0x20,%esp
                    break;
    1a15:	e9 76 01 00 00       	jmp    1b90 <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1a1a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a1d:	6a 00                	push   $0x0
    1a1f:	68 80 00 00 00       	push   $0x80
    1a24:	6a 00                	push   $0x0
    1a26:	50                   	push   %eax
    1a27:	e8 c9 f9 ff ff       	call   13f5 <RGB>
    1a2c:	83 c4 0c             	add    $0xc,%esp
    1a2f:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a33:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1a37:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a3b:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1a3e:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1a45:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a48:	6a 00                	push   $0x0
    1a4a:	68 80 00 00 00       	push   $0x80
    1a4f:	6a 00                	push   $0x0
    1a51:	50                   	push   %eax
    1a52:	e8 9e f9 ff ff       	call   13f5 <RGB>
    1a57:	83 c4 0c             	add    $0xc,%esp
    1a5a:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a5e:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1a62:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a66:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a69:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6c:	8d 50 34             	lea    0x34(%eax),%edx
    1a6f:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a72:	ff 75 d0             	pushl  -0x30(%ebp)
    1a75:	ff 75 cc             	pushl  -0x34(%ebp)
    1a78:	52                   	push   %edx
    1a79:	50                   	push   %eax
    1a7a:	e8 ac f1 ff ff       	call   c2b <APSetPen>
    1a7f:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a82:	8b 45 08             	mov    0x8(%ebp),%eax
    1a85:	8d 58 34             	lea    0x34(%eax),%ebx
    1a88:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a8b:	83 ec 04             	sub    $0x4,%esp
    1a8e:	83 ec 04             	sub    $0x4,%esp
    1a91:	89 e0                	mov    %esp,%eax
    1a93:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a97:	66 89 08             	mov    %cx,(%eax)
    1a9a:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1a9e:	88 48 02             	mov    %cl,0x2(%eax)
    1aa1:	53                   	push   %ebx
    1aa2:	52                   	push   %edx
    1aa3:	e8 bc f1 ff ff       	call   c64 <APSetBrush>
    1aa8:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1aab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1aae:	6b d0 32             	imul   $0x32,%eax,%edx
    1ab1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ab4:	6b c0 32             	imul   $0x32,%eax,%eax
    1ab7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1aba:	83 c1 34             	add    $0x34,%ecx
    1abd:	83 ec 0c             	sub    $0xc,%esp
    1ac0:	6a 32                	push   $0x32
    1ac2:	6a 32                	push   $0x32
    1ac4:	52                   	push   %edx
    1ac5:	50                   	push   %eax
    1ac6:	51                   	push   %ecx
    1ac7:	e8 80 f5 ff ff       	call   104c <APDrawRect>
    1acc:	83 c4 20             	add    $0x20,%esp
                    break;
    1acf:	e9 bc 00 00 00       	jmp    1b90 <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1ad4:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ad7:	68 ff 00 00 00       	push   $0xff
    1adc:	68 bf 00 00 00       	push   $0xbf
    1ae1:	6a 00                	push   $0x0
    1ae3:	50                   	push   %eax
    1ae4:	e8 0c f9 ff ff       	call   13f5 <RGB>
    1ae9:	83 c4 0c             	add    $0xc,%esp
    1aec:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1af0:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1af4:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1af8:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1afb:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1b02:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b05:	68 ff 00 00 00       	push   $0xff
    1b0a:	68 bf 00 00 00       	push   $0xbf
    1b0f:	6a 00                	push   $0x0
    1b11:	50                   	push   %eax
    1b12:	e8 de f8 ff ff       	call   13f5 <RGB>
    1b17:	83 c4 0c             	add    $0xc,%esp
    1b1a:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b1e:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1b22:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b26:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b29:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2c:	8d 50 34             	lea    0x34(%eax),%edx
    1b2f:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b32:	ff 75 d0             	pushl  -0x30(%ebp)
    1b35:	ff 75 cc             	pushl  -0x34(%ebp)
    1b38:	52                   	push   %edx
    1b39:	50                   	push   %eax
    1b3a:	e8 ec f0 ff ff       	call   c2b <APSetPen>
    1b3f:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b42:	8b 45 08             	mov    0x8(%ebp),%eax
    1b45:	8d 58 34             	lea    0x34(%eax),%ebx
    1b48:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1b4b:	83 ec 04             	sub    $0x4,%esp
    1b4e:	83 ec 04             	sub    $0x4,%esp
    1b51:	89 e0                	mov    %esp,%eax
    1b53:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b57:	66 89 08             	mov    %cx,(%eax)
    1b5a:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b5e:	88 48 02             	mov    %cl,0x2(%eax)
    1b61:	53                   	push   %ebx
    1b62:	52                   	push   %edx
    1b63:	e8 fc f0 ff ff       	call   c64 <APSetBrush>
    1b68:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1b6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b6e:	6b d0 32             	imul   $0x32,%eax,%edx
    1b71:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b74:	6b c0 32             	imul   $0x32,%eax,%eax
    1b77:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b7a:	83 c1 34             	add    $0x34,%ecx
    1b7d:	83 ec 0c             	sub    $0xc,%esp
    1b80:	6a 32                	push   $0x32
    1b82:	6a 32                	push   $0x32
    1b84:	52                   	push   %edx
    1b85:	50                   	push   %eax
    1b86:	51                   	push   %ecx
    1b87:	e8 c0 f4 ff ff       	call   104c <APDrawRect>
    1b8c:	83 c4 20             	add    $0x20,%esp
                    break;
    1b8f:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b90:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1b94:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1b98:	0f 8e 17 fd ff ff    	jle    18b5 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b9e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1ba2:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1ba6:	0f 8e fd fc ff ff    	jle    18a9 <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1bac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1baf:	5b                   	pop    %ebx
    1bb0:	5e                   	pop    %esi
    1bb1:	5f                   	pop    %edi
    1bb2:	5d                   	pop    %ebp
    1bb3:	c3                   	ret    

00001bb4 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1bb4:	55                   	push   %ebp
    1bb5:	89 e5                	mov    %esp,%ebp
    1bb7:	53                   	push   %ebx
    1bb8:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1bbb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1bc2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1bc6:	74 17                	je     1bdf <sprintint+0x2b>
    1bc8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1bcc:	79 11                	jns    1bdf <sprintint+0x2b>
        neg = 1;
    1bce:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1bd5:	8b 45 10             	mov    0x10(%ebp),%eax
    1bd8:	f7 d8                	neg    %eax
    1bda:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bdd:	eb 06                	jmp    1be5 <sprintint+0x31>
    } else {
        x = xx;
    1bdf:	8b 45 10             	mov    0x10(%ebp),%eax
    1be2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1be5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1bec:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1bef:	8d 41 01             	lea    0x1(%ecx),%eax
    1bf2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1bf5:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1bf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bfb:	ba 00 00 00 00       	mov    $0x0,%edx
    1c00:	f7 f3                	div    %ebx
    1c02:	89 d0                	mov    %edx,%eax
    1c04:	0f b6 80 78 25 00 00 	movzbl 0x2578(%eax),%eax
    1c0b:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1c0f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1c12:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c15:	ba 00 00 00 00       	mov    $0x0,%edx
    1c1a:	f7 f3                	div    %ebx
    1c1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c1f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c23:	75 c7                	jne    1bec <sprintint+0x38>
    if(neg)
    1c25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c29:	74 0e                	je     1c39 <sprintint+0x85>
        buf[i++] = '-';
    1c2b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c2e:	8d 50 01             	lea    0x1(%eax),%edx
    1c31:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1c34:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1c39:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c3c:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1c3f:	eb 1b                	jmp    1c5c <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1c41:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c44:	8b 00                	mov    (%eax),%eax
    1c46:	8d 48 01             	lea    0x1(%eax),%ecx
    1c49:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c4c:	89 0a                	mov    %ecx,(%edx)
    1c4e:	89 c2                	mov    %eax,%edx
    1c50:	8b 45 08             	mov    0x8(%ebp),%eax
    1c53:	01 d0                	add    %edx,%eax
    1c55:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1c58:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1c5c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1c60:	7f df                	jg     1c41 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c62:	eb 21                	jmp    1c85 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1c64:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c67:	8b 00                	mov    (%eax),%eax
    1c69:	8d 48 01             	lea    0x1(%eax),%ecx
    1c6c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c6f:	89 0a                	mov    %ecx,(%edx)
    1c71:	89 c2                	mov    %eax,%edx
    1c73:	8b 45 08             	mov    0x8(%ebp),%eax
    1c76:	01 c2                	add    %eax,%edx
    1c78:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1c7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c7e:	01 c8                	add    %ecx,%eax
    1c80:	0f b6 00             	movzbl (%eax),%eax
    1c83:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c85:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1c89:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1c8d:	79 d5                	jns    1c64 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1c8f:	90                   	nop
    1c90:	83 c4 20             	add    $0x20,%esp
    1c93:	5b                   	pop    %ebx
    1c94:	5d                   	pop    %ebp
    1c95:	c3                   	ret    

00001c96 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1c96:	55                   	push   %ebp
    1c97:	89 e5                	mov    %esp,%ebp
    1c99:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1c9c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1ca3:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1caa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1cb1:	8d 45 0c             	lea    0xc(%ebp),%eax
    1cb4:	83 c0 04             	add    $0x4,%eax
    1cb7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1cba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1cc1:	e9 d9 01 00 00       	jmp    1e9f <sprintf+0x209>
        c = fmt[i] & 0xff;
    1cc6:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cc9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ccc:	01 d0                	add    %edx,%eax
    1cce:	0f b6 00             	movzbl (%eax),%eax
    1cd1:	0f be c0             	movsbl %al,%eax
    1cd4:	25 ff 00 00 00       	and    $0xff,%eax
    1cd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1cdc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ce0:	75 2c                	jne    1d0e <sprintf+0x78>
            if(c == '%'){
    1ce2:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ce6:	75 0c                	jne    1cf4 <sprintf+0x5e>
                state = '%';
    1ce8:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1cef:	e9 a7 01 00 00       	jmp    1e9b <sprintf+0x205>
            } else {
                dst[j++] = c;
    1cf4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1cf7:	8d 50 01             	lea    0x1(%eax),%edx
    1cfa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1cfd:	89 c2                	mov    %eax,%edx
    1cff:	8b 45 08             	mov    0x8(%ebp),%eax
    1d02:	01 d0                	add    %edx,%eax
    1d04:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1d07:	88 10                	mov    %dl,(%eax)
    1d09:	e9 8d 01 00 00       	jmp    1e9b <sprintf+0x205>
            }
        } else if(state == '%'){
    1d0e:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1d12:	0f 85 83 01 00 00    	jne    1e9b <sprintf+0x205>
            if(c == 'd'){
    1d18:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1d1c:	75 4c                	jne    1d6a <sprintf+0xd4>
                buf[bi] = '\0';
    1d1e:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d21:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d24:	01 d0                	add    %edx,%eax
    1d26:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d29:	83 ec 0c             	sub    $0xc,%esp
    1d2c:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d2f:	50                   	push   %eax
    1d30:	e8 20 e5 ff ff       	call   255 <atoi>
    1d35:	83 c4 10             	add    $0x10,%esp
    1d38:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1d3b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1d42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d45:	8b 00                	mov    (%eax),%eax
    1d47:	83 ec 08             	sub    $0x8,%esp
    1d4a:	ff 75 d8             	pushl  -0x28(%ebp)
    1d4d:	6a 01                	push   $0x1
    1d4f:	6a 0a                	push   $0xa
    1d51:	50                   	push   %eax
    1d52:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d55:	50                   	push   %eax
    1d56:	ff 75 08             	pushl  0x8(%ebp)
    1d59:	e8 56 fe ff ff       	call   1bb4 <sprintint>
    1d5e:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d61:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1d65:	e9 2a 01 00 00       	jmp    1e94 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1d6a:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1d6e:	74 06                	je     1d76 <sprintf+0xe0>
    1d70:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1d74:	75 4c                	jne    1dc2 <sprintf+0x12c>
                buf[bi] = '\0';
    1d76:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d79:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d7c:	01 d0                	add    %edx,%eax
    1d7e:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d81:	83 ec 0c             	sub    $0xc,%esp
    1d84:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d87:	50                   	push   %eax
    1d88:	e8 c8 e4 ff ff       	call   255 <atoi>
    1d8d:	83 c4 10             	add    $0x10,%esp
    1d90:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1d93:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1d9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d9d:	8b 00                	mov    (%eax),%eax
    1d9f:	83 ec 08             	sub    $0x8,%esp
    1da2:	ff 75 dc             	pushl  -0x24(%ebp)
    1da5:	6a 00                	push   $0x0
    1da7:	6a 10                	push   $0x10
    1da9:	50                   	push   %eax
    1daa:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1dad:	50                   	push   %eax
    1dae:	ff 75 08             	pushl  0x8(%ebp)
    1db1:	e8 fe fd ff ff       	call   1bb4 <sprintint>
    1db6:	83 c4 20             	add    $0x20,%esp
                ap++;
    1db9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1dbd:	e9 d2 00 00 00       	jmp    1e94 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1dc2:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1dc6:	75 46                	jne    1e0e <sprintf+0x178>
                s = (char*)*ap;
    1dc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dcb:	8b 00                	mov    (%eax),%eax
    1dcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1dd0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1dd4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dd8:	75 25                	jne    1dff <sprintf+0x169>
                    s = "(null)";
    1dda:	c7 45 f4 40 20 00 00 	movl   $0x2040,-0xc(%ebp)
                while(*s != 0){
    1de1:	eb 1c                	jmp    1dff <sprintf+0x169>
                    dst[j++] = *s;
    1de3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1de6:	8d 50 01             	lea    0x1(%eax),%edx
    1de9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1dec:	89 c2                	mov    %eax,%edx
    1dee:	8b 45 08             	mov    0x8(%ebp),%eax
    1df1:	01 c2                	add    %eax,%edx
    1df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1df6:	0f b6 00             	movzbl (%eax),%eax
    1df9:	88 02                	mov    %al,(%edx)
                    s++;
    1dfb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1dff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e02:	0f b6 00             	movzbl (%eax),%eax
    1e05:	84 c0                	test   %al,%al
    1e07:	75 da                	jne    1de3 <sprintf+0x14d>
    1e09:	e9 86 00 00 00       	jmp    1e94 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1e0e:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1e12:	75 1d                	jne    1e31 <sprintf+0x19b>
                dst[j++] = *ap;
    1e14:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e17:	8d 50 01             	lea    0x1(%eax),%edx
    1e1a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e1d:	89 c2                	mov    %eax,%edx
    1e1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e22:	01 c2                	add    %eax,%edx
    1e24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e27:	8b 00                	mov    (%eax),%eax
    1e29:	88 02                	mov    %al,(%edx)
                ap++;
    1e2b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1e2f:	eb 63                	jmp    1e94 <sprintf+0x1fe>
            } else if(c == '%'){
    1e31:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1e35:	75 17                	jne    1e4e <sprintf+0x1b8>
                dst[j++] = c;
    1e37:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e3a:	8d 50 01             	lea    0x1(%eax),%edx
    1e3d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e40:	89 c2                	mov    %eax,%edx
    1e42:	8b 45 08             	mov    0x8(%ebp),%eax
    1e45:	01 d0                	add    %edx,%eax
    1e47:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e4a:	88 10                	mov    %dl,(%eax)
    1e4c:	eb 46                	jmp    1e94 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1e4e:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1e52:	7e 18                	jle    1e6c <sprintf+0x1d6>
    1e54:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1e58:	7f 12                	jg     1e6c <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e5d:	8d 50 01             	lea    0x1(%eax),%edx
    1e60:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1e63:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e66:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1e6a:	eb 2f                	jmp    1e9b <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1e6c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e6f:	8d 50 01             	lea    0x1(%eax),%edx
    1e72:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e75:	89 c2                	mov    %eax,%edx
    1e77:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7a:	01 d0                	add    %edx,%eax
    1e7c:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1e7f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e82:	8d 50 01             	lea    0x1(%eax),%edx
    1e85:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e88:	89 c2                	mov    %eax,%edx
    1e8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8d:	01 d0                	add    %edx,%eax
    1e8f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e92:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1e94:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1e9b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e9f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ea2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ea5:	01 d0                	add    %edx,%eax
    1ea7:	0f b6 00             	movzbl (%eax),%eax
    1eaa:	84 c0                	test   %al,%al
    1eac:	0f 85 14 fe ff ff    	jne    1cc6 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1eb2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1eb5:	8d 50 01             	lea    0x1(%eax),%edx
    1eb8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ebb:	89 c2                	mov    %eax,%edx
    1ebd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec0:	01 d0                	add    %edx,%eax
    1ec2:	c6 00 00             	movb   $0x0,(%eax)
}
    1ec5:	90                   	nop
    1ec6:	c9                   	leave  
    1ec7:	c3                   	ret    
