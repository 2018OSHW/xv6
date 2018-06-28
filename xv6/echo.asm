
_echo：     文件格式 elf32-i386


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

  for(i = 1; i < argc; i++)
      14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
      1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      20:	83 c0 01             	add    $0x1,%eax
      23:	3b 03                	cmp    (%ebx),%eax
      25:	7d 07                	jge    2e <main+0x2e>
      27:	ba 0c 21 00 00       	mov    $0x210c,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba 0e 21 00 00       	mov    $0x210e,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 10 21 00 00       	push   $0x2110
      4b:	6a 01                	push   $0x1
      4d:	e8 11 04 00 00       	call   463 <printf>
      52:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
      55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      59:	8b 45 f4             	mov    -0xc(%ebp),%eax
      5c:	3b 03                	cmp    (%ebx),%eax
      5e:	7c bd                	jl     1d <main+0x1d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
      60:	e8 57 02 00 00       	call   2bc <exit>

00000065 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
      65:	55                   	push   %ebp
      66:	89 e5                	mov    %esp,%ebp
      68:	57                   	push   %edi
      69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
      6d:	8b 55 10             	mov    0x10(%ebp),%edx
      70:	8b 45 0c             	mov    0xc(%ebp),%eax
      73:	89 cb                	mov    %ecx,%ebx
      75:	89 df                	mov    %ebx,%edi
      77:	89 d1                	mov    %edx,%ecx
      79:	fc                   	cld    
      7a:	f3 aa                	rep stos %al,%es:(%edi)
      7c:	89 ca                	mov    %ecx,%edx
      7e:	89 fb                	mov    %edi,%ebx
      80:	89 5d 08             	mov    %ebx,0x8(%ebp)
      83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      86:	90                   	nop
      87:	5b                   	pop    %ebx
      88:	5f                   	pop    %edi
      89:	5d                   	pop    %ebp
      8a:	c3                   	ret    

0000008b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      8b:	55                   	push   %ebp
      8c:	89 e5                	mov    %esp,%ebp
      8e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      91:	8b 45 08             	mov    0x8(%ebp),%eax
      94:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      97:	90                   	nop
      98:	8b 45 08             	mov    0x8(%ebp),%eax
      9b:	8d 50 01             	lea    0x1(%eax),%edx
      9e:	89 55 08             	mov    %edx,0x8(%ebp)
      a1:	8b 55 0c             	mov    0xc(%ebp),%edx
      a4:	8d 4a 01             	lea    0x1(%edx),%ecx
      a7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
      aa:	0f b6 12             	movzbl (%edx),%edx
      ad:	88 10                	mov    %dl,(%eax)
      af:	0f b6 00             	movzbl (%eax),%eax
      b2:	84 c0                	test   %al,%al
      b4:	75 e2                	jne    98 <strcpy+0xd>
    ;
  return os;
      b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      b9:	c9                   	leave  
      ba:	c3                   	ret    

000000bb <strcmp>:

int
strcmp(const char *p, const char *q)
{
      bb:	55                   	push   %ebp
      bc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      be:	eb 08                	jmp    c8 <strcmp+0xd>
    p++, q++;
      c0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      c4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
      c8:	8b 45 08             	mov    0x8(%ebp),%eax
      cb:	0f b6 00             	movzbl (%eax),%eax
      ce:	84 c0                	test   %al,%al
      d0:	74 10                	je     e2 <strcmp+0x27>
      d2:	8b 45 08             	mov    0x8(%ebp),%eax
      d5:	0f b6 10             	movzbl (%eax),%edx
      d8:	8b 45 0c             	mov    0xc(%ebp),%eax
      db:	0f b6 00             	movzbl (%eax),%eax
      de:	38 c2                	cmp    %al,%dl
      e0:	74 de                	je     c0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
      e2:	8b 45 08             	mov    0x8(%ebp),%eax
      e5:	0f b6 00             	movzbl (%eax),%eax
      e8:	0f b6 d0             	movzbl %al,%edx
      eb:	8b 45 0c             	mov    0xc(%ebp),%eax
      ee:	0f b6 00             	movzbl (%eax),%eax
      f1:	0f b6 c0             	movzbl %al,%eax
      f4:	29 c2                	sub    %eax,%edx
      f6:	89 d0                	mov    %edx,%eax
}
      f8:	5d                   	pop    %ebp
      f9:	c3                   	ret    

000000fa <strlen>:

uint
strlen(char *s)
{
      fa:	55                   	push   %ebp
      fb:	89 e5                	mov    %esp,%ebp
      fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     107:	eb 04                	jmp    10d <strlen+0x13>
     109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     10d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     110:	8b 45 08             	mov    0x8(%ebp),%eax
     113:	01 d0                	add    %edx,%eax
     115:	0f b6 00             	movzbl (%eax),%eax
     118:	84 c0                	test   %al,%al
     11a:	75 ed                	jne    109 <strlen+0xf>
    ;
  return n;
     11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     11f:	c9                   	leave  
     120:	c3                   	ret    

00000121 <memset>:

void*
memset(void *dst, int c, uint n)
{
     121:	55                   	push   %ebp
     122:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     124:	8b 45 10             	mov    0x10(%ebp),%eax
     127:	50                   	push   %eax
     128:	ff 75 0c             	pushl  0xc(%ebp)
     12b:	ff 75 08             	pushl  0x8(%ebp)
     12e:	e8 32 ff ff ff       	call   65 <stosb>
     133:	83 c4 0c             	add    $0xc,%esp
  return dst;
     136:	8b 45 08             	mov    0x8(%ebp),%eax
}
     139:	c9                   	leave  
     13a:	c3                   	ret    

0000013b <strchr>:

char*
strchr(const char *s, char c)
{
     13b:	55                   	push   %ebp
     13c:	89 e5                	mov    %esp,%ebp
     13e:	83 ec 04             	sub    $0x4,%esp
     141:	8b 45 0c             	mov    0xc(%ebp),%eax
     144:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     147:	eb 14                	jmp    15d <strchr+0x22>
    if(*s == c)
     149:	8b 45 08             	mov    0x8(%ebp),%eax
     14c:	0f b6 00             	movzbl (%eax),%eax
     14f:	3a 45 fc             	cmp    -0x4(%ebp),%al
     152:	75 05                	jne    159 <strchr+0x1e>
      return (char*)s;
     154:	8b 45 08             	mov    0x8(%ebp),%eax
     157:	eb 13                	jmp    16c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     159:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     15d:	8b 45 08             	mov    0x8(%ebp),%eax
     160:	0f b6 00             	movzbl (%eax),%eax
     163:	84 c0                	test   %al,%al
     165:	75 e2                	jne    149 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     167:	b8 00 00 00 00       	mov    $0x0,%eax
}
     16c:	c9                   	leave  
     16d:	c3                   	ret    

0000016e <gets>:

char*
gets(char *buf, int max)
{
     16e:	55                   	push   %ebp
     16f:	89 e5                	mov    %esp,%ebp
     171:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     174:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     17b:	eb 42                	jmp    1bf <gets+0x51>
    cc = read(0, &c, 1);
     17d:	83 ec 04             	sub    $0x4,%esp
     180:	6a 01                	push   $0x1
     182:	8d 45 ef             	lea    -0x11(%ebp),%eax
     185:	50                   	push   %eax
     186:	6a 00                	push   $0x0
     188:	e8 47 01 00 00       	call   2d4 <read>
     18d:	83 c4 10             	add    $0x10,%esp
     190:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     193:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     197:	7e 33                	jle    1cc <gets+0x5e>
      break;
    buf[i++] = c;
     199:	8b 45 f4             	mov    -0xc(%ebp),%eax
     19c:	8d 50 01             	lea    0x1(%eax),%edx
     19f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1a2:	89 c2                	mov    %eax,%edx
     1a4:	8b 45 08             	mov    0x8(%ebp),%eax
     1a7:	01 c2                	add    %eax,%edx
     1a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1b3:	3c 0a                	cmp    $0xa,%al
     1b5:	74 16                	je     1cd <gets+0x5f>
     1b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1bb:	3c 0d                	cmp    $0xd,%al
     1bd:	74 0e                	je     1cd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c2:	83 c0 01             	add    $0x1,%eax
     1c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     1c8:	7c b3                	jl     17d <gets+0xf>
     1ca:	eb 01                	jmp    1cd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     1cc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     1cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1d0:	8b 45 08             	mov    0x8(%ebp),%eax
     1d3:	01 d0                	add    %edx,%eax
     1d5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1db:	c9                   	leave  
     1dc:	c3                   	ret    

000001dd <stat>:

int
stat(char *n, struct stat *st)
{
     1dd:	55                   	push   %ebp
     1de:	89 e5                	mov    %esp,%ebp
     1e0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1e3:	83 ec 08             	sub    $0x8,%esp
     1e6:	6a 00                	push   $0x0
     1e8:	ff 75 08             	pushl  0x8(%ebp)
     1eb:	e8 0c 01 00 00       	call   2fc <open>
     1f0:	83 c4 10             	add    $0x10,%esp
     1f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     1f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     1fa:	79 07                	jns    203 <stat+0x26>
    return -1;
     1fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     201:	eb 25                	jmp    228 <stat+0x4b>
  r = fstat(fd, st);
     203:	83 ec 08             	sub    $0x8,%esp
     206:	ff 75 0c             	pushl  0xc(%ebp)
     209:	ff 75 f4             	pushl  -0xc(%ebp)
     20c:	e8 03 01 00 00       	call   314 <fstat>
     211:	83 c4 10             	add    $0x10,%esp
     214:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     217:	83 ec 0c             	sub    $0xc,%esp
     21a:	ff 75 f4             	pushl  -0xc(%ebp)
     21d:	e8 c2 00 00 00       	call   2e4 <close>
     222:	83 c4 10             	add    $0x10,%esp
  return r;
     225:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     228:	c9                   	leave  
     229:	c3                   	ret    

0000022a <atoi>:

int
atoi(const char *s)
{
     22a:	55                   	push   %ebp
     22b:	89 e5                	mov    %esp,%ebp
     22d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     237:	eb 25                	jmp    25e <atoi+0x34>
    n = n*10 + *s++ - '0';
     239:	8b 55 fc             	mov    -0x4(%ebp),%edx
     23c:	89 d0                	mov    %edx,%eax
     23e:	c1 e0 02             	shl    $0x2,%eax
     241:	01 d0                	add    %edx,%eax
     243:	01 c0                	add    %eax,%eax
     245:	89 c1                	mov    %eax,%ecx
     247:	8b 45 08             	mov    0x8(%ebp),%eax
     24a:	8d 50 01             	lea    0x1(%eax),%edx
     24d:	89 55 08             	mov    %edx,0x8(%ebp)
     250:	0f b6 00             	movzbl (%eax),%eax
     253:	0f be c0             	movsbl %al,%eax
     256:	01 c8                	add    %ecx,%eax
     258:	83 e8 30             	sub    $0x30,%eax
     25b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     25e:	8b 45 08             	mov    0x8(%ebp),%eax
     261:	0f b6 00             	movzbl (%eax),%eax
     264:	3c 2f                	cmp    $0x2f,%al
     266:	7e 0a                	jle    272 <atoi+0x48>
     268:	8b 45 08             	mov    0x8(%ebp),%eax
     26b:	0f b6 00             	movzbl (%eax),%eax
     26e:	3c 39                	cmp    $0x39,%al
     270:	7e c7                	jle    239 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     272:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     275:	c9                   	leave  
     276:	c3                   	ret    

00000277 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     277:	55                   	push   %ebp
     278:	89 e5                	mov    %esp,%ebp
     27a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     27d:	8b 45 08             	mov    0x8(%ebp),%eax
     280:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     283:	8b 45 0c             	mov    0xc(%ebp),%eax
     286:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     289:	eb 17                	jmp    2a2 <memmove+0x2b>
    *dst++ = *src++;
     28b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     28e:	8d 50 01             	lea    0x1(%eax),%edx
     291:	89 55 fc             	mov    %edx,-0x4(%ebp)
     294:	8b 55 f8             	mov    -0x8(%ebp),%edx
     297:	8d 4a 01             	lea    0x1(%edx),%ecx
     29a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     29d:	0f b6 12             	movzbl (%edx),%edx
     2a0:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     2a2:	8b 45 10             	mov    0x10(%ebp),%eax
     2a5:	8d 50 ff             	lea    -0x1(%eax),%edx
     2a8:	89 55 10             	mov    %edx,0x10(%ebp)
     2ab:	85 c0                	test   %eax,%eax
     2ad:	7f dc                	jg     28b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     2af:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2b2:	c9                   	leave  
     2b3:	c3                   	ret    

000002b4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2b4:	b8 01 00 00 00       	mov    $0x1,%eax
     2b9:	cd 40                	int    $0x40
     2bb:	c3                   	ret    

000002bc <exit>:
SYSCALL(exit)
     2bc:	b8 02 00 00 00       	mov    $0x2,%eax
     2c1:	cd 40                	int    $0x40
     2c3:	c3                   	ret    

000002c4 <wait>:
SYSCALL(wait)
     2c4:	b8 03 00 00 00       	mov    $0x3,%eax
     2c9:	cd 40                	int    $0x40
     2cb:	c3                   	ret    

000002cc <pipe>:
SYSCALL(pipe)
     2cc:	b8 04 00 00 00       	mov    $0x4,%eax
     2d1:	cd 40                	int    $0x40
     2d3:	c3                   	ret    

000002d4 <read>:
SYSCALL(read)
     2d4:	b8 05 00 00 00       	mov    $0x5,%eax
     2d9:	cd 40                	int    $0x40
     2db:	c3                   	ret    

000002dc <write>:
SYSCALL(write)
     2dc:	b8 10 00 00 00       	mov    $0x10,%eax
     2e1:	cd 40                	int    $0x40
     2e3:	c3                   	ret    

000002e4 <close>:
SYSCALL(close)
     2e4:	b8 15 00 00 00       	mov    $0x15,%eax
     2e9:	cd 40                	int    $0x40
     2eb:	c3                   	ret    

000002ec <kill>:
SYSCALL(kill)
     2ec:	b8 06 00 00 00       	mov    $0x6,%eax
     2f1:	cd 40                	int    $0x40
     2f3:	c3                   	ret    

000002f4 <exec>:
SYSCALL(exec)
     2f4:	b8 07 00 00 00       	mov    $0x7,%eax
     2f9:	cd 40                	int    $0x40
     2fb:	c3                   	ret    

000002fc <open>:
SYSCALL(open)
     2fc:	b8 0f 00 00 00       	mov    $0xf,%eax
     301:	cd 40                	int    $0x40
     303:	c3                   	ret    

00000304 <mknod>:
SYSCALL(mknod)
     304:	b8 11 00 00 00       	mov    $0x11,%eax
     309:	cd 40                	int    $0x40
     30b:	c3                   	ret    

0000030c <unlink>:
SYSCALL(unlink)
     30c:	b8 12 00 00 00       	mov    $0x12,%eax
     311:	cd 40                	int    $0x40
     313:	c3                   	ret    

00000314 <fstat>:
SYSCALL(fstat)
     314:	b8 08 00 00 00       	mov    $0x8,%eax
     319:	cd 40                	int    $0x40
     31b:	c3                   	ret    

0000031c <link>:
SYSCALL(link)
     31c:	b8 13 00 00 00       	mov    $0x13,%eax
     321:	cd 40                	int    $0x40
     323:	c3                   	ret    

00000324 <mkdir>:
SYSCALL(mkdir)
     324:	b8 14 00 00 00       	mov    $0x14,%eax
     329:	cd 40                	int    $0x40
     32b:	c3                   	ret    

0000032c <chdir>:
SYSCALL(chdir)
     32c:	b8 09 00 00 00       	mov    $0x9,%eax
     331:	cd 40                	int    $0x40
     333:	c3                   	ret    

00000334 <dup>:
SYSCALL(dup)
     334:	b8 0a 00 00 00       	mov    $0xa,%eax
     339:	cd 40                	int    $0x40
     33b:	c3                   	ret    

0000033c <getpid>:
SYSCALL(getpid)
     33c:	b8 0b 00 00 00       	mov    $0xb,%eax
     341:	cd 40                	int    $0x40
     343:	c3                   	ret    

00000344 <sbrk>:
SYSCALL(sbrk)
     344:	b8 0c 00 00 00       	mov    $0xc,%eax
     349:	cd 40                	int    $0x40
     34b:	c3                   	ret    

0000034c <sleep>:
SYSCALL(sleep)
     34c:	b8 0d 00 00 00       	mov    $0xd,%eax
     351:	cd 40                	int    $0x40
     353:	c3                   	ret    

00000354 <uptime>:
SYSCALL(uptime)
     354:	b8 0e 00 00 00       	mov    $0xe,%eax
     359:	cd 40                	int    $0x40
     35b:	c3                   	ret    

0000035c <paintWindow>:

SYSCALL(paintWindow)
     35c:	b8 16 00 00 00       	mov    $0x16,%eax
     361:	cd 40                	int    $0x40
     363:	c3                   	ret    

00000364 <initStringFigure>:
SYSCALL(initStringFigure)
     364:	b8 17 00 00 00       	mov    $0x17,%eax
     369:	cd 40                	int    $0x40
     36b:	c3                   	ret    

0000036c <sendMessage>:
SYSCALL(sendMessage)
     36c:	b8 18 00 00 00       	mov    $0x18,%eax
     371:	cd 40                	int    $0x40
     373:	c3                   	ret    

00000374 <getMessage>:
SYSCALL(getMessage)
     374:	b8 1a 00 00 00       	mov    $0x1a,%eax
     379:	cd 40                	int    $0x40
     37b:	c3                   	ret    

0000037c <registWindow>:
SYSCALL(registWindow)
     37c:	b8 19 00 00 00       	mov    $0x19,%eax
     381:	cd 40                	int    $0x40
     383:	c3                   	ret    

00000384 <changePosition>:
SYSCALL(changePosition)
     384:	b8 1b 00 00 00       	mov    $0x1b,%eax
     389:	cd 40                	int    $0x40
     38b:	c3                   	ret    

0000038c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     38c:	55                   	push   %ebp
     38d:	89 e5                	mov    %esp,%ebp
     38f:	83 ec 18             	sub    $0x18,%esp
     392:	8b 45 0c             	mov    0xc(%ebp),%eax
     395:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     398:	83 ec 04             	sub    $0x4,%esp
     39b:	6a 01                	push   $0x1
     39d:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3a0:	50                   	push   %eax
     3a1:	ff 75 08             	pushl  0x8(%ebp)
     3a4:	e8 33 ff ff ff       	call   2dc <write>
     3a9:	83 c4 10             	add    $0x10,%esp
}
     3ac:	90                   	nop
     3ad:	c9                   	leave  
     3ae:	c3                   	ret    

000003af <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3af:	55                   	push   %ebp
     3b0:	89 e5                	mov    %esp,%ebp
     3b2:	53                   	push   %ebx
     3b3:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3bd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3c1:	74 17                	je     3da <printint+0x2b>
     3c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3c7:	79 11                	jns    3da <printint+0x2b>
    neg = 1;
     3c9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d3:	f7 d8                	neg    %eax
     3d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3d8:	eb 06                	jmp    3e0 <printint+0x31>
  } else {
    x = xx;
     3da:	8b 45 0c             	mov    0xc(%ebp),%eax
     3dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3e7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3ea:	8d 41 01             	lea    0x1(%ecx),%eax
     3ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3f0:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3f6:	ba 00 00 00 00       	mov    $0x0,%edx
     3fb:	f7 f3                	div    %ebx
     3fd:	89 d0                	mov    %edx,%eax
     3ff:	0f b6 80 c0 27 00 00 	movzbl 0x27c0(%eax),%eax
     406:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     40a:	8b 5d 10             	mov    0x10(%ebp),%ebx
     40d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     410:	ba 00 00 00 00       	mov    $0x0,%edx
     415:	f7 f3                	div    %ebx
     417:	89 45 ec             	mov    %eax,-0x14(%ebp)
     41a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     41e:	75 c7                	jne    3e7 <printint+0x38>
  if(neg)
     420:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     424:	74 2d                	je     453 <printint+0xa4>
    buf[i++] = '-';
     426:	8b 45 f4             	mov    -0xc(%ebp),%eax
     429:	8d 50 01             	lea    0x1(%eax),%edx
     42c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     42f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     434:	eb 1d                	jmp    453 <printint+0xa4>
    putc(fd, buf[i]);
     436:	8d 55 dc             	lea    -0x24(%ebp),%edx
     439:	8b 45 f4             	mov    -0xc(%ebp),%eax
     43c:	01 d0                	add    %edx,%eax
     43e:	0f b6 00             	movzbl (%eax),%eax
     441:	0f be c0             	movsbl %al,%eax
     444:	83 ec 08             	sub    $0x8,%esp
     447:	50                   	push   %eax
     448:	ff 75 08             	pushl  0x8(%ebp)
     44b:	e8 3c ff ff ff       	call   38c <putc>
     450:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     453:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     457:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     45b:	79 d9                	jns    436 <printint+0x87>
    putc(fd, buf[i]);
}
     45d:	90                   	nop
     45e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     461:	c9                   	leave  
     462:	c3                   	ret    

00000463 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     463:	55                   	push   %ebp
     464:	89 e5                	mov    %esp,%ebp
     466:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     469:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     470:	8d 45 0c             	lea    0xc(%ebp),%eax
     473:	83 c0 04             	add    $0x4,%eax
     476:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     479:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     480:	e9 59 01 00 00       	jmp    5de <printf+0x17b>
    c = fmt[i] & 0xff;
     485:	8b 55 0c             	mov    0xc(%ebp),%edx
     488:	8b 45 f0             	mov    -0x10(%ebp),%eax
     48b:	01 d0                	add    %edx,%eax
     48d:	0f b6 00             	movzbl (%eax),%eax
     490:	0f be c0             	movsbl %al,%eax
     493:	25 ff 00 00 00       	and    $0xff,%eax
     498:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     49b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     49f:	75 2c                	jne    4cd <printf+0x6a>
      if(c == '%'){
     4a1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4a5:	75 0c                	jne    4b3 <printf+0x50>
        state = '%';
     4a7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4ae:	e9 27 01 00 00       	jmp    5da <printf+0x177>
      } else {
        putc(fd, c);
     4b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4b6:	0f be c0             	movsbl %al,%eax
     4b9:	83 ec 08             	sub    $0x8,%esp
     4bc:	50                   	push   %eax
     4bd:	ff 75 08             	pushl  0x8(%ebp)
     4c0:	e8 c7 fe ff ff       	call   38c <putc>
     4c5:	83 c4 10             	add    $0x10,%esp
     4c8:	e9 0d 01 00 00       	jmp    5da <printf+0x177>
      }
    } else if(state == '%'){
     4cd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4d1:	0f 85 03 01 00 00    	jne    5da <printf+0x177>
      if(c == 'd'){
     4d7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4db:	75 1e                	jne    4fb <printf+0x98>
        printint(fd, *ap, 10, 1);
     4dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4e0:	8b 00                	mov    (%eax),%eax
     4e2:	6a 01                	push   $0x1
     4e4:	6a 0a                	push   $0xa
     4e6:	50                   	push   %eax
     4e7:	ff 75 08             	pushl  0x8(%ebp)
     4ea:	e8 c0 fe ff ff       	call   3af <printint>
     4ef:	83 c4 10             	add    $0x10,%esp
        ap++;
     4f2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4f6:	e9 d8 00 00 00       	jmp    5d3 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4fb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4ff:	74 06                	je     507 <printf+0xa4>
     501:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     505:	75 1e                	jne    525 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     507:	8b 45 e8             	mov    -0x18(%ebp),%eax
     50a:	8b 00                	mov    (%eax),%eax
     50c:	6a 00                	push   $0x0
     50e:	6a 10                	push   $0x10
     510:	50                   	push   %eax
     511:	ff 75 08             	pushl  0x8(%ebp)
     514:	e8 96 fe ff ff       	call   3af <printint>
     519:	83 c4 10             	add    $0x10,%esp
        ap++;
     51c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     520:	e9 ae 00 00 00       	jmp    5d3 <printf+0x170>
      } else if(c == 's'){
     525:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     529:	75 43                	jne    56e <printf+0x10b>
        s = (char*)*ap;
     52b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     52e:	8b 00                	mov    (%eax),%eax
     530:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     533:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     537:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     53b:	75 25                	jne    562 <printf+0xff>
          s = "(null)";
     53d:	c7 45 f4 15 21 00 00 	movl   $0x2115,-0xc(%ebp)
        while(*s != 0){
     544:	eb 1c                	jmp    562 <printf+0xff>
          putc(fd, *s);
     546:	8b 45 f4             	mov    -0xc(%ebp),%eax
     549:	0f b6 00             	movzbl (%eax),%eax
     54c:	0f be c0             	movsbl %al,%eax
     54f:	83 ec 08             	sub    $0x8,%esp
     552:	50                   	push   %eax
     553:	ff 75 08             	pushl  0x8(%ebp)
     556:	e8 31 fe ff ff       	call   38c <putc>
     55b:	83 c4 10             	add    $0x10,%esp
          s++;
     55e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     562:	8b 45 f4             	mov    -0xc(%ebp),%eax
     565:	0f b6 00             	movzbl (%eax),%eax
     568:	84 c0                	test   %al,%al
     56a:	75 da                	jne    546 <printf+0xe3>
     56c:	eb 65                	jmp    5d3 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     56e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     572:	75 1d                	jne    591 <printf+0x12e>
        putc(fd, *ap);
     574:	8b 45 e8             	mov    -0x18(%ebp),%eax
     577:	8b 00                	mov    (%eax),%eax
     579:	0f be c0             	movsbl %al,%eax
     57c:	83 ec 08             	sub    $0x8,%esp
     57f:	50                   	push   %eax
     580:	ff 75 08             	pushl  0x8(%ebp)
     583:	e8 04 fe ff ff       	call   38c <putc>
     588:	83 c4 10             	add    $0x10,%esp
        ap++;
     58b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     58f:	eb 42                	jmp    5d3 <printf+0x170>
      } else if(c == '%'){
     591:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     595:	75 17                	jne    5ae <printf+0x14b>
        putc(fd, c);
     597:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     59a:	0f be c0             	movsbl %al,%eax
     59d:	83 ec 08             	sub    $0x8,%esp
     5a0:	50                   	push   %eax
     5a1:	ff 75 08             	pushl  0x8(%ebp)
     5a4:	e8 e3 fd ff ff       	call   38c <putc>
     5a9:	83 c4 10             	add    $0x10,%esp
     5ac:	eb 25                	jmp    5d3 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5ae:	83 ec 08             	sub    $0x8,%esp
     5b1:	6a 25                	push   $0x25
     5b3:	ff 75 08             	pushl  0x8(%ebp)
     5b6:	e8 d1 fd ff ff       	call   38c <putc>
     5bb:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c1:	0f be c0             	movsbl %al,%eax
     5c4:	83 ec 08             	sub    $0x8,%esp
     5c7:	50                   	push   %eax
     5c8:	ff 75 08             	pushl  0x8(%ebp)
     5cb:	e8 bc fd ff ff       	call   38c <putc>
     5d0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5d3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5da:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5de:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5e4:	01 d0                	add    %edx,%eax
     5e6:	0f b6 00             	movzbl (%eax),%eax
     5e9:	84 c0                	test   %al,%al
     5eb:	0f 85 94 fe ff ff    	jne    485 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5f1:	90                   	nop
     5f2:	c9                   	leave  
     5f3:	c3                   	ret    

000005f4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5f4:	55                   	push   %ebp
     5f5:	89 e5                	mov    %esp,%ebp
     5f7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5fa:	8b 45 08             	mov    0x8(%ebp),%eax
     5fd:	83 e8 08             	sub    $0x8,%eax
     600:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     603:	a1 f4 27 00 00       	mov    0x27f4,%eax
     608:	89 45 fc             	mov    %eax,-0x4(%ebp)
     60b:	eb 24                	jmp    631 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     60d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     610:	8b 00                	mov    (%eax),%eax
     612:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     615:	77 12                	ja     629 <free+0x35>
     617:	8b 45 f8             	mov    -0x8(%ebp),%eax
     61a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     61d:	77 24                	ja     643 <free+0x4f>
     61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     622:	8b 00                	mov    (%eax),%eax
     624:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     627:	77 1a                	ja     643 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     629:	8b 45 fc             	mov    -0x4(%ebp),%eax
     62c:	8b 00                	mov    (%eax),%eax
     62e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     631:	8b 45 f8             	mov    -0x8(%ebp),%eax
     634:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     637:	76 d4                	jbe    60d <free+0x19>
     639:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63c:	8b 00                	mov    (%eax),%eax
     63e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     641:	76 ca                	jbe    60d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     643:	8b 45 f8             	mov    -0x8(%ebp),%eax
     646:	8b 40 04             	mov    0x4(%eax),%eax
     649:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     650:	8b 45 f8             	mov    -0x8(%ebp),%eax
     653:	01 c2                	add    %eax,%edx
     655:	8b 45 fc             	mov    -0x4(%ebp),%eax
     658:	8b 00                	mov    (%eax),%eax
     65a:	39 c2                	cmp    %eax,%edx
     65c:	75 24                	jne    682 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     661:	8b 50 04             	mov    0x4(%eax),%edx
     664:	8b 45 fc             	mov    -0x4(%ebp),%eax
     667:	8b 00                	mov    (%eax),%eax
     669:	8b 40 04             	mov    0x4(%eax),%eax
     66c:	01 c2                	add    %eax,%edx
     66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     671:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     674:	8b 45 fc             	mov    -0x4(%ebp),%eax
     677:	8b 00                	mov    (%eax),%eax
     679:	8b 10                	mov    (%eax),%edx
     67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67e:	89 10                	mov    %edx,(%eax)
     680:	eb 0a                	jmp    68c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     682:	8b 45 fc             	mov    -0x4(%ebp),%eax
     685:	8b 10                	mov    (%eax),%edx
     687:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68f:	8b 40 04             	mov    0x4(%eax),%eax
     692:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     699:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69c:	01 d0                	add    %edx,%eax
     69e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6a1:	75 20                	jne    6c3 <free+0xcf>
    p->s.size += bp->s.size;
     6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a6:	8b 50 04             	mov    0x4(%eax),%edx
     6a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ac:	8b 40 04             	mov    0x4(%eax),%eax
     6af:	01 c2                	add    %eax,%edx
     6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ba:	8b 10                	mov    (%eax),%edx
     6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bf:	89 10                	mov    %edx,(%eax)
     6c1:	eb 08                	jmp    6cb <free+0xd7>
  } else
    p->s.ptr = bp;
     6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6c9:	89 10                	mov    %edx,(%eax)
  freep = p;
     6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ce:	a3 f4 27 00 00       	mov    %eax,0x27f4
}
     6d3:	90                   	nop
     6d4:	c9                   	leave  
     6d5:	c3                   	ret    

000006d6 <morecore>:

static Header*
morecore(uint nu)
{
     6d6:	55                   	push   %ebp
     6d7:	89 e5                	mov    %esp,%ebp
     6d9:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6dc:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6e3:	77 07                	ja     6ec <morecore+0x16>
    nu = 4096;
     6e5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6ec:	8b 45 08             	mov    0x8(%ebp),%eax
     6ef:	c1 e0 03             	shl    $0x3,%eax
     6f2:	83 ec 0c             	sub    $0xc,%esp
     6f5:	50                   	push   %eax
     6f6:	e8 49 fc ff ff       	call   344 <sbrk>
     6fb:	83 c4 10             	add    $0x10,%esp
     6fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     701:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     705:	75 07                	jne    70e <morecore+0x38>
    return 0;
     707:	b8 00 00 00 00       	mov    $0x0,%eax
     70c:	eb 26                	jmp    734 <morecore+0x5e>
  hp = (Header*)p;
     70e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     711:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     714:	8b 45 f0             	mov    -0x10(%ebp),%eax
     717:	8b 55 08             	mov    0x8(%ebp),%edx
     71a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     71d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     720:	83 c0 08             	add    $0x8,%eax
     723:	83 ec 0c             	sub    $0xc,%esp
     726:	50                   	push   %eax
     727:	e8 c8 fe ff ff       	call   5f4 <free>
     72c:	83 c4 10             	add    $0x10,%esp
  return freep;
     72f:	a1 f4 27 00 00       	mov    0x27f4,%eax
}
     734:	c9                   	leave  
     735:	c3                   	ret    

00000736 <malloc>:

void*
malloc(uint nbytes)
{
     736:	55                   	push   %ebp
     737:	89 e5                	mov    %esp,%ebp
     739:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     73c:	8b 45 08             	mov    0x8(%ebp),%eax
     73f:	83 c0 07             	add    $0x7,%eax
     742:	c1 e8 03             	shr    $0x3,%eax
     745:	83 c0 01             	add    $0x1,%eax
     748:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     74b:	a1 f4 27 00 00       	mov    0x27f4,%eax
     750:	89 45 f0             	mov    %eax,-0x10(%ebp)
     753:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     757:	75 23                	jne    77c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     759:	c7 45 f0 ec 27 00 00 	movl   $0x27ec,-0x10(%ebp)
     760:	8b 45 f0             	mov    -0x10(%ebp),%eax
     763:	a3 f4 27 00 00       	mov    %eax,0x27f4
     768:	a1 f4 27 00 00       	mov    0x27f4,%eax
     76d:	a3 ec 27 00 00       	mov    %eax,0x27ec
    base.s.size = 0;
     772:	c7 05 f0 27 00 00 00 	movl   $0x0,0x27f0
     779:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     77c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77f:	8b 00                	mov    (%eax),%eax
     781:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     784:	8b 45 f4             	mov    -0xc(%ebp),%eax
     787:	8b 40 04             	mov    0x4(%eax),%eax
     78a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     78d:	72 4d                	jb     7dc <malloc+0xa6>
      if(p->s.size == nunits)
     78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     792:	8b 40 04             	mov    0x4(%eax),%eax
     795:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     798:	75 0c                	jne    7a6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79d:	8b 10                	mov    (%eax),%edx
     79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a2:	89 10                	mov    %edx,(%eax)
     7a4:	eb 26                	jmp    7cc <malloc+0x96>
      else {
        p->s.size -= nunits;
     7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a9:	8b 40 04             	mov    0x4(%eax),%eax
     7ac:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7af:	89 c2                	mov    %eax,%edx
     7b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ba:	8b 40 04             	mov    0x4(%eax),%eax
     7bd:	c1 e0 03             	shl    $0x3,%eax
     7c0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7c9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7cf:	a3 f4 27 00 00       	mov    %eax,0x27f4
      return (void*)(p + 1);
     7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d7:	83 c0 08             	add    $0x8,%eax
     7da:	eb 3b                	jmp    817 <malloc+0xe1>
    }
    if(p == freep)
     7dc:	a1 f4 27 00 00       	mov    0x27f4,%eax
     7e1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7e4:	75 1e                	jne    804 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7e6:	83 ec 0c             	sub    $0xc,%esp
     7e9:	ff 75 ec             	pushl  -0x14(%ebp)
     7ec:	e8 e5 fe ff ff       	call   6d6 <morecore>
     7f1:	83 c4 10             	add    $0x10,%esp
     7f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7fb:	75 07                	jne    804 <malloc+0xce>
        return 0;
     7fd:	b8 00 00 00 00       	mov    $0x0,%eax
     802:	eb 13                	jmp    817 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     804:	8b 45 f4             	mov    -0xc(%ebp),%eax
     807:	89 45 f0             	mov    %eax,-0x10(%ebp)
     80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80d:	8b 00                	mov    (%eax),%eax
     80f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     812:	e9 6d ff ff ff       	jmp    784 <malloc+0x4e>
}
     817:	c9                   	leave  
     818:	c3                   	ret    

00000819 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     819:	55                   	push   %ebp
     81a:	89 e5                	mov    %esp,%ebp
     81c:	83 ec 1c             	sub    $0x1c,%esp
     81f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     822:	8b 55 10             	mov    0x10(%ebp),%edx
     825:	8b 45 14             	mov    0x14(%ebp),%eax
     828:	88 4d ec             	mov    %cl,-0x14(%ebp)
     82b:	88 55 e8             	mov    %dl,-0x18(%ebp)
     82e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     831:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     835:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     838:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     83c:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     83f:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     843:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     846:	8b 45 08             	mov    0x8(%ebp),%eax
     849:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     84d:	66 89 10             	mov    %dx,(%eax)
     850:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     854:	88 50 02             	mov    %dl,0x2(%eax)
}
     857:	8b 45 08             	mov    0x8(%ebp),%eax
     85a:	c9                   	leave  
     85b:	c2 04 00             	ret    $0x4

0000085e <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     85e:	55                   	push   %ebp
     85f:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     861:	8b 45 08             	mov    0x8(%ebp),%eax
     864:	2b 45 10             	sub    0x10(%ebp),%eax
     867:	89 c2                	mov    %eax,%edx
     869:	8b 45 08             	mov    0x8(%ebp),%eax
     86c:	2b 45 10             	sub    0x10(%ebp),%eax
     86f:	0f af d0             	imul   %eax,%edx
     872:	8b 45 0c             	mov    0xc(%ebp),%eax
     875:	2b 45 14             	sub    0x14(%ebp),%eax
     878:	89 c1                	mov    %eax,%ecx
     87a:	8b 45 0c             	mov    0xc(%ebp),%eax
     87d:	2b 45 14             	sub    0x14(%ebp),%eax
     880:	0f af c1             	imul   %ecx,%eax
     883:	01 d0                	add    %edx,%eax
}
     885:	5d                   	pop    %ebp
     886:	c3                   	ret    

00000887 <abs_int>:

static inline int abs_int(int x)
{
     887:	55                   	push   %ebp
     888:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     88a:	8b 45 08             	mov    0x8(%ebp),%eax
     88d:	99                   	cltd   
     88e:	89 d0                	mov    %edx,%eax
     890:	33 45 08             	xor    0x8(%ebp),%eax
     893:	29 d0                	sub    %edx,%eax
}
     895:	5d                   	pop    %ebp
     896:	c3                   	ret    

00000897 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     897:	55                   	push   %ebp
     898:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     89a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     89e:	79 07                	jns    8a7 <APGetIndex+0x10>
        return X_SMALLER;
     8a0:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8a5:	eb 40                	jmp    8e7 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8a7:	8b 45 08             	mov    0x8(%ebp),%eax
     8aa:	8b 00                	mov    (%eax),%eax
     8ac:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8af:	7f 07                	jg     8b8 <APGetIndex+0x21>
        return X_BIGGER;
     8b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8b6:	eb 2f                	jmp    8e7 <APGetIndex+0x50>
    if (y < 0)
     8b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8bc:	79 07                	jns    8c5 <APGetIndex+0x2e>
        return Y_SMALLER;
     8be:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8c3:	eb 22                	jmp    8e7 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8c5:	8b 45 08             	mov    0x8(%ebp),%eax
     8c8:	8b 40 04             	mov    0x4(%eax),%eax
     8cb:	3b 45 10             	cmp    0x10(%ebp),%eax
     8ce:	7f 07                	jg     8d7 <APGetIndex+0x40>
        return Y_BIGGER;
     8d0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8d5:	eb 10                	jmp    8e7 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8d7:	8b 45 08             	mov    0x8(%ebp),%eax
     8da:	8b 00                	mov    (%eax),%eax
     8dc:	0f af 45 10          	imul   0x10(%ebp),%eax
     8e0:	89 c2                	mov    %eax,%edx
     8e2:	8b 45 0c             	mov    0xc(%ebp),%eax
     8e5:	01 d0                	add    %edx,%eax
}
     8e7:	5d                   	pop    %ebp
     8e8:	c3                   	ret    

000008e9 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8e9:	55                   	push   %ebp
     8ea:	89 e5                	mov    %esp,%ebp
     8ec:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8ef:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8f6:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8f9:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8fc:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     903:	83 ec 08             	sub    $0x8,%esp
     906:	6a 00                	push   $0x0
     908:	ff 75 0c             	pushl  0xc(%ebp)
     90b:	e8 ec f9 ff ff       	call   2fc <open>
     910:	83 c4 10             	add    $0x10,%esp
     913:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     916:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     91a:	79 2e                	jns    94a <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     91c:	83 ec 04             	sub    $0x4,%esp
     91f:	ff 75 0c             	pushl  0xc(%ebp)
     922:	68 1c 21 00 00       	push   $0x211c
     927:	6a 01                	push   $0x1
     929:	e8 35 fb ff ff       	call   463 <printf>
     92e:	83 c4 10             	add    $0x10,%esp
        return bmp;
     931:	8b 45 08             	mov    0x8(%ebp),%eax
     934:	8b 55 c8             	mov    -0x38(%ebp),%edx
     937:	89 10                	mov    %edx,(%eax)
     939:	8b 55 cc             	mov    -0x34(%ebp),%edx
     93c:	89 50 04             	mov    %edx,0x4(%eax)
     93f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     942:	89 50 08             	mov    %edx,0x8(%eax)
     945:	e9 d2 01 00 00       	jmp    b1c <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     94a:	83 ec 04             	sub    $0x4,%esp
     94d:	6a 0e                	push   $0xe
     94f:	8d 45 ba             	lea    -0x46(%ebp),%eax
     952:	50                   	push   %eax
     953:	ff 75 ec             	pushl  -0x14(%ebp)
     956:	e8 79 f9 ff ff       	call   2d4 <read>
     95b:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     95e:	83 ec 04             	sub    $0x4,%esp
     961:	6a 28                	push   $0x28
     963:	8d 45 92             	lea    -0x6e(%ebp),%eax
     966:	50                   	push   %eax
     967:	ff 75 ec             	pushl  -0x14(%ebp)
     96a:	e8 65 f9 ff ff       	call   2d4 <read>
     96f:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     972:	8b 45 96             	mov    -0x6a(%ebp),%eax
     975:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     978:	8b 45 9a             	mov    -0x66(%ebp),%eax
     97b:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     97e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     981:	8b 45 cc             	mov    -0x34(%ebp),%eax
     984:	0f af d0             	imul   %eax,%edx
     987:	89 d0                	mov    %edx,%eax
     989:	01 c0                	add    %eax,%eax
     98b:	01 d0                	add    %edx,%eax
     98d:	83 ec 0c             	sub    $0xc,%esp
     990:	50                   	push   %eax
     991:	e8 a0 fd ff ff       	call   736 <malloc>
     996:	83 c4 10             	add    $0x10,%esp
     999:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     99c:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9a0:	0f b7 c0             	movzwl %ax,%eax
     9a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9a6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9ac:	0f af c2             	imul   %edx,%eax
     9af:	83 c0 1f             	add    $0x1f,%eax
     9b2:	c1 e8 05             	shr    $0x5,%eax
     9b5:	c1 e0 02             	shl    $0x2,%eax
     9b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9bb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9c1:	0f af c2             	imul   %edx,%eax
     9c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9ca:	83 ec 0c             	sub    $0xc,%esp
     9cd:	50                   	push   %eax
     9ce:	e8 63 fd ff ff       	call   736 <malloc>
     9d3:	83 c4 10             	add    $0x10,%esp
     9d6:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9d9:	83 ec 04             	sub    $0x4,%esp
     9dc:	ff 75 e0             	pushl  -0x20(%ebp)
     9df:	ff 75 dc             	pushl  -0x24(%ebp)
     9e2:	ff 75 ec             	pushl  -0x14(%ebp)
     9e5:	e8 ea f8 ff ff       	call   2d4 <read>
     9ea:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9ed:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9f1:	66 c1 e8 03          	shr    $0x3,%ax
     9f5:	0f b7 c0             	movzwl %ax,%eax
     9f8:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     9fb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a02:	e9 e5 00 00 00       	jmp    aec <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a07:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0d:	29 c2                	sub    %eax,%edx
     a0f:	89 d0                	mov    %edx,%eax
     a11:	8d 50 ff             	lea    -0x1(%eax),%edx
     a14:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a17:	0f af c2             	imul   %edx,%eax
     a1a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a1d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a24:	e9 b1 00 00 00       	jmp    ada <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a29:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a2c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a32:	01 c8                	add    %ecx,%eax
     a34:	89 c1                	mov    %eax,%ecx
     a36:	89 c8                	mov    %ecx,%eax
     a38:	01 c0                	add    %eax,%eax
     a3a:	01 c8                	add    %ecx,%eax
     a3c:	01 c2                	add    %eax,%edx
     a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a41:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a45:	89 c1                	mov    %eax,%ecx
     a47:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a4a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a4e:	01 c1                	add    %eax,%ecx
     a50:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a53:	01 c8                	add    %ecx,%eax
     a55:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a58:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a5b:	01 c8                	add    %ecx,%eax
     a5d:	0f b6 00             	movzbl (%eax),%eax
     a60:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a63:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a66:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a69:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a6c:	01 c8                	add    %ecx,%eax
     a6e:	89 c1                	mov    %eax,%ecx
     a70:	89 c8                	mov    %ecx,%eax
     a72:	01 c0                	add    %eax,%eax
     a74:	01 c8                	add    %ecx,%eax
     a76:	01 c2                	add    %eax,%edx
     a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7b:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a7f:	89 c1                	mov    %eax,%ecx
     a81:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a84:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a88:	01 c1                	add    %eax,%ecx
     a8a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a8d:	01 c8                	add    %ecx,%eax
     a8f:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a92:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a95:	01 c8                	add    %ecx,%eax
     a97:	0f b6 00             	movzbl (%eax),%eax
     a9a:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     a9d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aa0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa6:	01 c8                	add    %ecx,%eax
     aa8:	89 c1                	mov    %eax,%ecx
     aaa:	89 c8                	mov    %ecx,%eax
     aac:	01 c0                	add    %eax,%eax
     aae:	01 c8                	add    %ecx,%eax
     ab0:	01 c2                	add    %eax,%edx
     ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab5:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ab9:	89 c1                	mov    %eax,%ecx
     abb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     abe:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ac2:	01 c1                	add    %eax,%ecx
     ac4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac7:	01 c8                	add    %ecx,%eax
     ac9:	8d 48 fd             	lea    -0x3(%eax),%ecx
     acc:	8b 45 dc             	mov    -0x24(%ebp),%eax
     acf:	01 c8                	add    %ecx,%eax
     ad1:	0f b6 00             	movzbl (%eax),%eax
     ad4:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ad6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ada:	8b 55 c8             	mov    -0x38(%ebp),%edx
     add:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae0:	39 c2                	cmp    %eax,%edx
     ae2:	0f 87 41 ff ff ff    	ja     a29 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     ae8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     aec:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af2:	39 c2                	cmp    %eax,%edx
     af4:	0f 87 0d ff ff ff    	ja     a07 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     afa:	83 ec 0c             	sub    $0xc,%esp
     afd:	ff 75 ec             	pushl  -0x14(%ebp)
     b00:	e8 df f7 ff ff       	call   2e4 <close>
     b05:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b08:	8b 45 08             	mov    0x8(%ebp),%eax
     b0b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b0e:	89 10                	mov    %edx,(%eax)
     b10:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b13:	89 50 04             	mov    %edx,0x4(%eax)
     b16:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b19:	89 50 08             	mov    %edx,0x8(%eax)
}
     b1c:	8b 45 08             	mov    0x8(%ebp),%eax
     b1f:	c9                   	leave  
     b20:	c2 04 00             	ret    $0x4

00000b23 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b23:	55                   	push   %ebp
     b24:	89 e5                	mov    %esp,%ebp
     b26:	53                   	push   %ebx
     b27:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b2a:	83 ec 0c             	sub    $0xc,%esp
     b2d:	6a 1c                	push   $0x1c
     b2f:	e8 02 fc ff ff       	call   736 <malloc>
     b34:	83 c4 10             	add    $0x10,%esp
     b37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b3d:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b44:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b47:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b4a:	6a 0c                	push   $0xc
     b4c:	6a 0c                	push   $0xc
     b4e:	6a 0c                	push   $0xc
     b50:	50                   	push   %eax
     b51:	e8 c3 fc ff ff       	call   819 <RGB>
     b56:	83 c4 0c             	add    $0xc,%esp
     b59:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b5d:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b61:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b65:	88 43 15             	mov    %al,0x15(%ebx)
     b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b6e:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b72:	66 89 48 10          	mov    %cx,0x10(%eax)
     b76:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b7a:	88 50 12             	mov    %dl,0x12(%eax)
     b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b80:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b83:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b87:	66 89 48 08          	mov    %cx,0x8(%eax)
     b8b:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b8f:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b92:	8b 45 08             	mov    0x8(%ebp),%eax
     b95:	89 c2                	mov    %eax,%edx
     b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9a:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     b9c:	8b 45 0c             	mov    0xc(%ebp),%eax
     b9f:	89 c2                	mov    %eax,%edx
     ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba4:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     ba7:	8b 55 10             	mov    0x10(%ebp),%edx
     baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bad:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bb6:	c9                   	leave  
     bb7:	c3                   	ret    

00000bb8 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bb8:	55                   	push   %ebp
     bb9:	89 e5                	mov    %esp,%ebp
     bbb:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc1:	8b 50 08             	mov    0x8(%eax),%edx
     bc4:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bc7:	8b 40 0c             	mov    0xc(%eax),%eax
     bca:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd0:	8b 55 10             	mov    0x10(%ebp),%edx
     bd3:	89 50 08             	mov    %edx,0x8(%eax)
     bd6:	8b 55 14             	mov    0x14(%ebp),%edx
     bd9:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bdc:	8b 45 08             	mov    0x8(%ebp),%eax
     bdf:	8b 55 f8             	mov    -0x8(%ebp),%edx
     be2:	89 10                	mov    %edx,(%eax)
     be4:	8b 55 fc             	mov    -0x4(%ebp),%edx
     be7:	89 50 04             	mov    %edx,0x4(%eax)
}
     bea:	8b 45 08             	mov    0x8(%ebp),%eax
     bed:	c9                   	leave  
     bee:	c2 04 00             	ret    $0x4

00000bf1 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bf1:	55                   	push   %ebp
     bf2:	89 e5                	mov    %esp,%ebp
     bf4:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bf7:	8b 45 0c             	mov    0xc(%ebp),%eax
     bfa:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     bfe:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c02:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c06:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c09:	8b 45 0c             	mov    0xc(%ebp),%eax
     c0c:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c10:	66 89 50 10          	mov    %dx,0x10(%eax)
     c14:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c18:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c1b:	8b 45 08             	mov    0x8(%ebp),%eax
     c1e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c22:	66 89 10             	mov    %dx,(%eax)
     c25:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c29:	88 50 02             	mov    %dl,0x2(%eax)
}
     c2c:	8b 45 08             	mov    0x8(%ebp),%eax
     c2f:	c9                   	leave  
     c30:	c2 04 00             	ret    $0x4

00000c33 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c33:	55                   	push   %ebp
     c34:	89 e5                	mov    %esp,%ebp
     c36:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c39:	8b 45 08             	mov    0x8(%ebp),%eax
     c3c:	8b 40 0c             	mov    0xc(%eax),%eax
     c3f:	89 c2                	mov    %eax,%edx
     c41:	c1 ea 1f             	shr    $0x1f,%edx
     c44:	01 d0                	add    %edx,%eax
     c46:	d1 f8                	sar    %eax
     c48:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4e:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c52:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c55:	8b 45 10             	mov    0x10(%ebp),%eax
     c58:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c5e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c62:	0f 89 98 00 00 00    	jns    d00 <APDrawPoint+0xcd>
        i = 0;
     c68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c6f:	e9 8c 00 00 00       	jmp    d00 <APDrawPoint+0xcd>
    {
        j = x - off;
     c74:	8b 45 0c             	mov    0xc(%ebp),%eax
     c77:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c7a:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c7d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c81:	79 69                	jns    cec <APDrawPoint+0xb9>
            j = 0;
     c83:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c8a:	eb 60                	jmp    cec <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c8c:	ff 75 fc             	pushl  -0x4(%ebp)
     c8f:	ff 75 f8             	pushl  -0x8(%ebp)
     c92:	ff 75 08             	pushl  0x8(%ebp)
     c95:	e8 fd fb ff ff       	call   897 <APGetIndex>
     c9a:	83 c4 0c             	add    $0xc,%esp
     c9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ca0:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ca4:	74 55                	je     cfb <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ca6:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     caa:	74 67                	je     d13 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cac:	ff 75 10             	pushl  0x10(%ebp)
     caf:	ff 75 0c             	pushl  0xc(%ebp)
     cb2:	ff 75 fc             	pushl  -0x4(%ebp)
     cb5:	ff 75 f8             	pushl  -0x8(%ebp)
     cb8:	e8 a1 fb ff ff       	call   85e <distance_2>
     cbd:	83 c4 10             	add    $0x10,%esp
     cc0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cc3:	7f 23                	jg     ce8 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cc5:	8b 45 08             	mov    0x8(%ebp),%eax
     cc8:	8b 48 18             	mov    0x18(%eax),%ecx
     ccb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cce:	89 d0                	mov    %edx,%eax
     cd0:	01 c0                	add    %eax,%eax
     cd2:	01 d0                	add    %edx,%eax
     cd4:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cd7:	8b 45 08             	mov    0x8(%ebp),%eax
     cda:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     cde:	66 89 0a             	mov    %cx,(%edx)
     ce1:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     ce5:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ce8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cec:	8b 55 0c             	mov    0xc(%ebp),%edx
     cef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf2:	01 d0                	add    %edx,%eax
     cf4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cf7:	7d 93                	jge    c8c <APDrawPoint+0x59>
     cf9:	eb 01                	jmp    cfc <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     cfb:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     cfc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d00:	8b 55 10             	mov    0x10(%ebp),%edx
     d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d06:	01 d0                	add    %edx,%eax
     d08:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d0b:	0f 8d 63 ff ff ff    	jge    c74 <APDrawPoint+0x41>
     d11:	eb 01                	jmp    d14 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d13:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d14:	c9                   	leave  
     d15:	c3                   	ret    

00000d16 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d16:	55                   	push   %ebp
     d17:	89 e5                	mov    %esp,%ebp
     d19:	53                   	push   %ebx
     d1a:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d1d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d20:	3b 45 14             	cmp    0x14(%ebp),%eax
     d23:	0f 85 80 00 00 00    	jne    da9 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d29:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d2d:	0f 88 9d 02 00 00    	js     fd0 <APDrawLine+0x2ba>
     d33:	8b 45 08             	mov    0x8(%ebp),%eax
     d36:	8b 00                	mov    (%eax),%eax
     d38:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d3b:	0f 8e 8f 02 00 00    	jle    fd0 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d41:	8b 45 10             	mov    0x10(%ebp),%eax
     d44:	3b 45 18             	cmp    0x18(%ebp),%eax
     d47:	7e 12                	jle    d5b <APDrawLine+0x45>
        {
            int tmp = y2;
     d49:	8b 45 18             	mov    0x18(%ebp),%eax
     d4c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d4f:	8b 45 10             	mov    0x10(%ebp),%eax
     d52:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d55:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d58:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d5b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d5f:	79 07                	jns    d68 <APDrawLine+0x52>
     d61:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d68:	8b 45 08             	mov    0x8(%ebp),%eax
     d6b:	8b 40 04             	mov    0x4(%eax),%eax
     d6e:	3b 45 18             	cmp    0x18(%ebp),%eax
     d71:	7d 0c                	jge    d7f <APDrawLine+0x69>
     d73:	8b 45 08             	mov    0x8(%ebp),%eax
     d76:	8b 40 04             	mov    0x4(%eax),%eax
     d79:	83 e8 01             	sub    $0x1,%eax
     d7c:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d7f:	8b 45 10             	mov    0x10(%ebp),%eax
     d82:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d85:	eb 15                	jmp    d9c <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d87:	ff 75 f4             	pushl  -0xc(%ebp)
     d8a:	ff 75 0c             	pushl  0xc(%ebp)
     d8d:	ff 75 08             	pushl  0x8(%ebp)
     d90:	e8 9e fe ff ff       	call   c33 <APDrawPoint>
     d95:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d98:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9f:	3b 45 18             	cmp    0x18(%ebp),%eax
     da2:	7e e3                	jle    d87 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     da4:	e9 2b 02 00 00       	jmp    fd4 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     da9:	8b 45 10             	mov    0x10(%ebp),%eax
     dac:	3b 45 18             	cmp    0x18(%ebp),%eax
     daf:	75 7f                	jne    e30 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     db1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     db5:	0f 88 18 02 00 00    	js     fd3 <APDrawLine+0x2bd>
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	8b 40 04             	mov    0x4(%eax),%eax
     dc1:	3b 45 10             	cmp    0x10(%ebp),%eax
     dc4:	0f 8e 09 02 00 00    	jle    fd3 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dca:	8b 45 0c             	mov    0xc(%ebp),%eax
     dcd:	3b 45 14             	cmp    0x14(%ebp),%eax
     dd0:	7e 12                	jle    de4 <APDrawLine+0xce>
        {
            int tmp = x2;
     dd2:	8b 45 14             	mov    0x14(%ebp),%eax
     dd5:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     dd8:	8b 45 0c             	mov    0xc(%ebp),%eax
     ddb:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     dde:	8b 45 d8             	mov    -0x28(%ebp),%eax
     de1:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     de4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     de8:	79 07                	jns    df1 <APDrawLine+0xdb>
     dea:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     df1:	8b 45 08             	mov    0x8(%ebp),%eax
     df4:	8b 00                	mov    (%eax),%eax
     df6:	3b 45 14             	cmp    0x14(%ebp),%eax
     df9:	7d 0b                	jge    e06 <APDrawLine+0xf0>
     dfb:	8b 45 08             	mov    0x8(%ebp),%eax
     dfe:	8b 00                	mov    (%eax),%eax
     e00:	83 e8 01             	sub    $0x1,%eax
     e03:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e06:	8b 45 0c             	mov    0xc(%ebp),%eax
     e09:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e0c:	eb 15                	jmp    e23 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e0e:	ff 75 10             	pushl  0x10(%ebp)
     e11:	ff 75 f0             	pushl  -0x10(%ebp)
     e14:	ff 75 08             	pushl  0x8(%ebp)
     e17:	e8 17 fe ff ff       	call   c33 <APDrawPoint>
     e1c:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e1f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e23:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e26:	3b 45 14             	cmp    0x14(%ebp),%eax
     e29:	7e e3                	jle    e0e <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e2b:	e9 a4 01 00 00       	jmp    fd4 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e30:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e37:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e41:	2b 45 14             	sub    0x14(%ebp),%eax
     e44:	50                   	push   %eax
     e45:	e8 3d fa ff ff       	call   887 <abs_int>
     e4a:	83 c4 04             	add    $0x4,%esp
     e4d:	89 c3                	mov    %eax,%ebx
     e4f:	8b 45 10             	mov    0x10(%ebp),%eax
     e52:	2b 45 18             	sub    0x18(%ebp),%eax
     e55:	50                   	push   %eax
     e56:	e8 2c fa ff ff       	call   887 <abs_int>
     e5b:	83 c4 04             	add    $0x4,%esp
     e5e:	39 c3                	cmp    %eax,%ebx
     e60:	0f 8e b5 00 00 00    	jle    f1b <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e66:	8b 45 10             	mov    0x10(%ebp),%eax
     e69:	2b 45 18             	sub    0x18(%ebp),%eax
     e6c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e6f:	db 45 b0             	fildl  -0x50(%ebp)
     e72:	8b 45 0c             	mov    0xc(%ebp),%eax
     e75:	2b 45 14             	sub    0x14(%ebp),%eax
     e78:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e7b:	db 45 b0             	fildl  -0x50(%ebp)
     e7e:	de f9                	fdivrp %st,%st(1)
     e80:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e83:	8b 45 14             	mov    0x14(%ebp),%eax
     e86:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e89:	7e 0e                	jle    e99 <APDrawLine+0x183>
        {
            s = x1;
     e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e91:	8b 45 14             	mov    0x14(%ebp),%eax
     e94:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e97:	eb 0c                	jmp    ea5 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     e99:	8b 45 14             	mov    0x14(%ebp),%eax
     e9c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ea5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ea9:	79 07                	jns    eb2 <APDrawLine+0x19c>
     eab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     eb2:	8b 45 08             	mov    0x8(%ebp),%eax
     eb5:	8b 00                	mov    (%eax),%eax
     eb7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     eba:	7f 0b                	jg     ec7 <APDrawLine+0x1b1>
     ebc:	8b 45 08             	mov    0x8(%ebp),%eax
     ebf:	8b 00                	mov    (%eax),%eax
     ec1:	83 e8 01             	sub    $0x1,%eax
     ec4:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ec7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     eca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ecd:	eb 3f                	jmp    f0e <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ecf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ed2:	2b 45 0c             	sub    0xc(%ebp),%eax
     ed5:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed8:	db 45 b0             	fildl  -0x50(%ebp)
     edb:	dc 4d d0             	fmull  -0x30(%ebp)
     ede:	db 45 10             	fildl  0x10(%ebp)
     ee1:	de c1                	faddp  %st,%st(1)
     ee3:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ee6:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     eea:	b4 0c                	mov    $0xc,%ah
     eec:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ef0:	d9 6d b4             	fldcw  -0x4c(%ebp)
     ef3:	db 5d cc             	fistpl -0x34(%ebp)
     ef6:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     ef9:	ff 75 cc             	pushl  -0x34(%ebp)
     efc:	ff 75 e4             	pushl  -0x1c(%ebp)
     eff:	ff 75 08             	pushl  0x8(%ebp)
     f02:	e8 2c fd ff ff       	call   c33 <APDrawPoint>
     f07:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f0a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f11:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f14:	7e b9                	jle    ecf <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f16:	e9 b9 00 00 00       	jmp    fd4 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f1b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1e:	2b 45 14             	sub    0x14(%ebp),%eax
     f21:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f24:	db 45 b0             	fildl  -0x50(%ebp)
     f27:	8b 45 10             	mov    0x10(%ebp),%eax
     f2a:	2b 45 18             	sub    0x18(%ebp),%eax
     f2d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f30:	db 45 b0             	fildl  -0x50(%ebp)
     f33:	de f9                	fdivrp %st,%st(1)
     f35:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f38:	8b 45 10             	mov    0x10(%ebp),%eax
     f3b:	3b 45 18             	cmp    0x18(%ebp),%eax
     f3e:	7e 0e                	jle    f4e <APDrawLine+0x238>
    {
        s = y2;
     f40:	8b 45 18             	mov    0x18(%ebp),%eax
     f43:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f46:	8b 45 10             	mov    0x10(%ebp),%eax
     f49:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f4c:	eb 0c                	jmp    f5a <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f4e:	8b 45 10             	mov    0x10(%ebp),%eax
     f51:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f54:	8b 45 18             	mov    0x18(%ebp),%eax
     f57:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f5a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f5e:	79 07                	jns    f67 <APDrawLine+0x251>
     f60:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f67:	8b 45 08             	mov    0x8(%ebp),%eax
     f6a:	8b 40 04             	mov    0x4(%eax),%eax
     f6d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f70:	7f 0c                	jg     f7e <APDrawLine+0x268>
     f72:	8b 45 08             	mov    0x8(%ebp),%eax
     f75:	8b 40 04             	mov    0x4(%eax),%eax
     f78:	83 e8 01             	sub    $0x1,%eax
     f7b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f81:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f84:	eb 3f                	jmp    fc5 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f86:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f89:	2b 45 10             	sub    0x10(%ebp),%eax
     f8c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f8f:	db 45 b0             	fildl  -0x50(%ebp)
     f92:	dc 4d c0             	fmull  -0x40(%ebp)
     f95:	db 45 0c             	fildl  0xc(%ebp)
     f98:	de c1                	faddp  %st,%st(1)
     f9a:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f9d:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fa1:	b4 0c                	mov    $0xc,%ah
     fa3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fa7:	d9 6d b4             	fldcw  -0x4c(%ebp)
     faa:	db 5d bc             	fistpl -0x44(%ebp)
     fad:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fb0:	ff 75 e0             	pushl  -0x20(%ebp)
     fb3:	ff 75 bc             	pushl  -0x44(%ebp)
     fb6:	ff 75 08             	pushl  0x8(%ebp)
     fb9:	e8 75 fc ff ff       	call   c33 <APDrawPoint>
     fbe:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fc1:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fc5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fc8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fcb:	7e b9                	jle    f86 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fcd:	90                   	nop
     fce:	eb 04                	jmp    fd4 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fd0:	90                   	nop
     fd1:	eb 01                	jmp    fd4 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fd3:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fd7:	c9                   	leave  
     fd8:	c3                   	ret    

00000fd9 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fd9:	55                   	push   %ebp
     fda:	89 e5                	mov    %esp,%ebp
     fdc:	53                   	push   %ebx
     fdd:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fe0:	8b 55 10             	mov    0x10(%ebp),%edx
     fe3:	8b 45 18             	mov    0x18(%ebp),%eax
     fe6:	01 d0                	add    %edx,%eax
     fe8:	83 e8 01             	sub    $0x1,%eax
     feb:	83 ec 04             	sub    $0x4,%esp
     fee:	50                   	push   %eax
     fef:	ff 75 0c             	pushl  0xc(%ebp)
     ff2:	ff 75 10             	pushl  0x10(%ebp)
     ff5:	ff 75 0c             	pushl  0xc(%ebp)
     ff8:	ff 75 08             	pushl  0x8(%ebp)
     ffb:	e8 16 fd ff ff       	call   d16 <APDrawLine>
    1000:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1003:	8b 55 0c             	mov    0xc(%ebp),%edx
    1006:	8b 45 14             	mov    0x14(%ebp),%eax
    1009:	01 d0                	add    %edx,%eax
    100b:	83 e8 01             	sub    $0x1,%eax
    100e:	83 ec 04             	sub    $0x4,%esp
    1011:	ff 75 10             	pushl  0x10(%ebp)
    1014:	50                   	push   %eax
    1015:	ff 75 10             	pushl  0x10(%ebp)
    1018:	ff 75 0c             	pushl  0xc(%ebp)
    101b:	ff 75 08             	pushl  0x8(%ebp)
    101e:	e8 f3 fc ff ff       	call   d16 <APDrawLine>
    1023:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1026:	8b 55 10             	mov    0x10(%ebp),%edx
    1029:	8b 45 18             	mov    0x18(%ebp),%eax
    102c:	01 d0                	add    %edx,%eax
    102e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1031:	8b 55 0c             	mov    0xc(%ebp),%edx
    1034:	8b 45 14             	mov    0x14(%ebp),%eax
    1037:	01 d0                	add    %edx,%eax
    1039:	8d 50 ff             	lea    -0x1(%eax),%edx
    103c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    103f:	8b 45 14             	mov    0x14(%ebp),%eax
    1042:	01 d8                	add    %ebx,%eax
    1044:	83 e8 01             	sub    $0x1,%eax
    1047:	83 ec 04             	sub    $0x4,%esp
    104a:	51                   	push   %ecx
    104b:	52                   	push   %edx
    104c:	ff 75 10             	pushl  0x10(%ebp)
    104f:	50                   	push   %eax
    1050:	ff 75 08             	pushl  0x8(%ebp)
    1053:	e8 be fc ff ff       	call   d16 <APDrawLine>
    1058:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    105b:	8b 55 10             	mov    0x10(%ebp),%edx
    105e:	8b 45 18             	mov    0x18(%ebp),%eax
    1061:	01 d0                	add    %edx,%eax
    1063:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1066:	8b 55 0c             	mov    0xc(%ebp),%edx
    1069:	8b 45 14             	mov    0x14(%ebp),%eax
    106c:	01 d0                	add    %edx,%eax
    106e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1071:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1074:	8b 45 18             	mov    0x18(%ebp),%eax
    1077:	01 d8                	add    %ebx,%eax
    1079:	83 e8 01             	sub    $0x1,%eax
    107c:	83 ec 04             	sub    $0x4,%esp
    107f:	51                   	push   %ecx
    1080:	52                   	push   %edx
    1081:	50                   	push   %eax
    1082:	ff 75 0c             	pushl  0xc(%ebp)
    1085:	ff 75 08             	pushl  0x8(%ebp)
    1088:	e8 89 fc ff ff       	call   d16 <APDrawLine>
    108d:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1090:	8b 55 0c             	mov    0xc(%ebp),%edx
    1093:	8b 45 14             	mov    0x14(%ebp),%eax
    1096:	01 d0                	add    %edx,%eax
    1098:	8d 50 ff             	lea    -0x1(%eax),%edx
    109b:	8b 45 08             	mov    0x8(%ebp),%eax
    109e:	8b 40 0c             	mov    0xc(%eax),%eax
    10a1:	89 c1                	mov    %eax,%ecx
    10a3:	c1 e9 1f             	shr    $0x1f,%ecx
    10a6:	01 c8                	add    %ecx,%eax
    10a8:	d1 f8                	sar    %eax
    10aa:	29 c2                	sub    %eax,%edx
    10ac:	89 d0                	mov    %edx,%eax
    10ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10b1:	8b 55 10             	mov    0x10(%ebp),%edx
    10b4:	8b 45 18             	mov    0x18(%ebp),%eax
    10b7:	01 d0                	add    %edx,%eax
    10b9:	8d 50 ff             	lea    -0x1(%eax),%edx
    10bc:	8b 45 08             	mov    0x8(%ebp),%eax
    10bf:	8b 40 0c             	mov    0xc(%eax),%eax
    10c2:	89 c1                	mov    %eax,%ecx
    10c4:	c1 e9 1f             	shr    $0x1f,%ecx
    10c7:	01 c8                	add    %ecx,%eax
    10c9:	d1 f8                	sar    %eax
    10cb:	29 c2                	sub    %eax,%edx
    10cd:	89 d0                	mov    %edx,%eax
    10cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10d2:	8b 45 08             	mov    0x8(%ebp),%eax
    10d5:	8b 40 0c             	mov    0xc(%eax),%eax
    10d8:	89 c2                	mov    %eax,%edx
    10da:	c1 ea 1f             	shr    $0x1f,%edx
    10dd:	01 d0                	add    %edx,%eax
    10df:	d1 f8                	sar    %eax
    10e1:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10e4:	8b 45 08             	mov    0x8(%ebp),%eax
    10e7:	8b 40 0c             	mov    0xc(%eax),%eax
    10ea:	89 c2                	mov    %eax,%edx
    10ec:	c1 ea 1f             	shr    $0x1f,%edx
    10ef:	01 d0                	add    %edx,%eax
    10f1:	d1 f8                	sar    %eax
    10f3:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10fa:	0f 88 d8 00 00 00    	js     11d8 <APDrawRect+0x1ff>
    1100:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1104:	0f 88 ce 00 00 00    	js     11d8 <APDrawRect+0x1ff>
    110a:	8b 45 08             	mov    0x8(%ebp),%eax
    110d:	8b 00                	mov    (%eax),%eax
    110f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1112:	0f 8e c0 00 00 00    	jle    11d8 <APDrawRect+0x1ff>
    1118:	8b 45 08             	mov    0x8(%ebp),%eax
    111b:	8b 40 04             	mov    0x4(%eax),%eax
    111e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1121:	0f 8e b1 00 00 00    	jle    11d8 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1127:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    112b:	79 07                	jns    1134 <APDrawRect+0x15b>
    112d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1134:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1138:	79 07                	jns    1141 <APDrawRect+0x168>
    113a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1141:	8b 45 08             	mov    0x8(%ebp),%eax
    1144:	8b 00                	mov    (%eax),%eax
    1146:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1149:	7f 0b                	jg     1156 <APDrawRect+0x17d>
    114b:	8b 45 08             	mov    0x8(%ebp),%eax
    114e:	8b 00                	mov    (%eax),%eax
    1150:	83 e8 01             	sub    $0x1,%eax
    1153:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1156:	8b 45 08             	mov    0x8(%ebp),%eax
    1159:	8b 40 04             	mov    0x4(%eax),%eax
    115c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    115f:	7f 0c                	jg     116d <APDrawRect+0x194>
    1161:	8b 45 08             	mov    0x8(%ebp),%eax
    1164:	8b 40 04             	mov    0x4(%eax),%eax
    1167:	83 e8 01             	sub    $0x1,%eax
    116a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    116d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1174:	8b 45 0c             	mov    0xc(%ebp),%eax
    1177:	89 45 ec             	mov    %eax,-0x14(%ebp)
    117a:	eb 52                	jmp    11ce <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    117c:	8b 45 10             	mov    0x10(%ebp),%eax
    117f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1182:	eb 3e                	jmp    11c2 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1184:	83 ec 04             	sub    $0x4,%esp
    1187:	ff 75 e8             	pushl  -0x18(%ebp)
    118a:	ff 75 ec             	pushl  -0x14(%ebp)
    118d:	ff 75 08             	pushl  0x8(%ebp)
    1190:	e8 02 f7 ff ff       	call   897 <APGetIndex>
    1195:	83 c4 10             	add    $0x10,%esp
    1198:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    119b:	8b 45 08             	mov    0x8(%ebp),%eax
    119e:	8b 48 18             	mov    0x18(%eax),%ecx
    11a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11a4:	89 d0                	mov    %edx,%eax
    11a6:	01 c0                	add    %eax,%eax
    11a8:	01 d0                	add    %edx,%eax
    11aa:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11ad:	8b 45 08             	mov    0x8(%ebp),%eax
    11b0:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11b4:	66 89 0a             	mov    %cx,(%edx)
    11b7:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11bb:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11be:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11c5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11c8:	7e ba                	jle    1184 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11ca:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11d4:	7e a6                	jle    117c <APDrawRect+0x1a3>
    11d6:	eb 01                	jmp    11d9 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11d8:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11dc:	c9                   	leave  
    11dd:	c3                   	ret    

000011de <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11de:	55                   	push   %ebp
    11df:	89 e5                	mov    %esp,%ebp
    11e1:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11e4:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11e8:	0f 88 8e 01 00 00    	js     137c <APDcCopy+0x19e>
    11ee:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11f2:	0f 88 84 01 00 00    	js     137c <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11f8:	8b 55 0c             	mov    0xc(%ebp),%edx
    11fb:	8b 45 20             	mov    0x20(%ebp),%eax
    11fe:	01 d0                	add    %edx,%eax
    1200:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1203:	8b 55 10             	mov    0x10(%ebp),%edx
    1206:	8b 45 24             	mov    0x24(%ebp),%eax
    1209:	01 d0                	add    %edx,%eax
    120b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    120e:	8b 55 18             	mov    0x18(%ebp),%edx
    1211:	8b 45 20             	mov    0x20(%ebp),%eax
    1214:	01 d0                	add    %edx,%eax
    1216:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1219:	8b 55 1c             	mov    0x1c(%ebp),%edx
    121c:	8b 45 24             	mov    0x24(%ebp),%eax
    121f:	01 d0                	add    %edx,%eax
    1221:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1224:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1228:	0f 88 51 01 00 00    	js     137f <APDcCopy+0x1a1>
    122e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1232:	0f 88 47 01 00 00    	js     137f <APDcCopy+0x1a1>
    1238:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    123c:	0f 88 3d 01 00 00    	js     137f <APDcCopy+0x1a1>
    1242:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1246:	0f 88 33 01 00 00    	js     137f <APDcCopy+0x1a1>
    124c:	8b 45 14             	mov    0x14(%ebp),%eax
    124f:	8b 00                	mov    (%eax),%eax
    1251:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1254:	0f 8c 25 01 00 00    	jl     137f <APDcCopy+0x1a1>
    125a:	8b 45 14             	mov    0x14(%ebp),%eax
    125d:	8b 40 04             	mov    0x4(%eax),%eax
    1260:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1263:	0f 8c 16 01 00 00    	jl     137f <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1269:	8b 45 08             	mov    0x8(%ebp),%eax
    126c:	8b 00                	mov    (%eax),%eax
    126e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1271:	7f 0b                	jg     127e <APDcCopy+0xa0>
    1273:	8b 45 08             	mov    0x8(%ebp),%eax
    1276:	8b 00                	mov    (%eax),%eax
    1278:	83 e8 01             	sub    $0x1,%eax
    127b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    127e:	8b 45 08             	mov    0x8(%ebp),%eax
    1281:	8b 40 04             	mov    0x4(%eax),%eax
    1284:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1287:	7f 0c                	jg     1295 <APDcCopy+0xb7>
    1289:	8b 45 08             	mov    0x8(%ebp),%eax
    128c:	8b 40 04             	mov    0x4(%eax),%eax
    128f:	83 e8 01             	sub    $0x1,%eax
    1292:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1295:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    129c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12aa:	e9 bc 00 00 00       	jmp    136b <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12af:	8b 45 08             	mov    0x8(%ebp),%eax
    12b2:	8b 00                	mov    (%eax),%eax
    12b4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12b7:	8b 55 10             	mov    0x10(%ebp),%edx
    12ba:	01 ca                	add    %ecx,%edx
    12bc:	0f af d0             	imul   %eax,%edx
    12bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c2:	01 d0                	add    %edx,%eax
    12c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12c7:	8b 45 14             	mov    0x14(%ebp),%eax
    12ca:	8b 00                	mov    (%eax),%eax
    12cc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12cf:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12d2:	01 ca                	add    %ecx,%edx
    12d4:	0f af d0             	imul   %eax,%edx
    12d7:	8b 45 18             	mov    0x18(%ebp),%eax
    12da:	01 d0                	add    %edx,%eax
    12dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12e6:	eb 74                	jmp    135c <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12e8:	8b 45 14             	mov    0x14(%ebp),%eax
    12eb:	8b 50 18             	mov    0x18(%eax),%edx
    12ee:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f4:	01 c8                	add    %ecx,%eax
    12f6:	89 c1                	mov    %eax,%ecx
    12f8:	89 c8                	mov    %ecx,%eax
    12fa:	01 c0                	add    %eax,%eax
    12fc:	01 c8                	add    %ecx,%eax
    12fe:	01 d0                	add    %edx,%eax
    1300:	0f b7 10             	movzwl (%eax),%edx
    1303:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1307:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    130b:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    130e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1312:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1316:	38 c2                	cmp    %al,%dl
    1318:	75 18                	jne    1332 <APDcCopy+0x154>
    131a:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    131e:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1322:	38 c2                	cmp    %al,%dl
    1324:	75 0c                	jne    1332 <APDcCopy+0x154>
    1326:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    132a:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    132e:	38 c2                	cmp    %al,%dl
    1330:	74 26                	je     1358 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1332:	8b 45 08             	mov    0x8(%ebp),%eax
    1335:	8b 50 18             	mov    0x18(%eax),%edx
    1338:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    133b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    133e:	01 c8                	add    %ecx,%eax
    1340:	89 c1                	mov    %eax,%ecx
    1342:	89 c8                	mov    %ecx,%eax
    1344:	01 c0                	add    %eax,%eax
    1346:	01 c8                	add    %ecx,%eax
    1348:	01 d0                	add    %edx,%eax
    134a:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    134e:	66 89 10             	mov    %dx,(%eax)
    1351:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1355:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1358:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    135c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    135f:	2b 45 0c             	sub    0xc(%ebp),%eax
    1362:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1365:	7d 81                	jge    12e8 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1367:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    136b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    136e:	2b 45 10             	sub    0x10(%ebp),%eax
    1371:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1374:	0f 8d 35 ff ff ff    	jge    12af <APDcCopy+0xd1>
    137a:	eb 04                	jmp    1380 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    137c:	90                   	nop
    137d:	eb 01                	jmp    1380 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    137f:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1380:	c9                   	leave  
    1381:	c3                   	ret    

00001382 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1382:	55                   	push   %ebp
    1383:	89 e5                	mov    %esp,%ebp
    1385:	83 ec 1c             	sub    $0x1c,%esp
    1388:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    138b:	8b 55 10             	mov    0x10(%ebp),%edx
    138e:	8b 45 14             	mov    0x14(%ebp),%eax
    1391:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1394:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1397:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    139a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    139e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13a1:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13a5:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13a8:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13ac:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13af:	8b 45 08             	mov    0x8(%ebp),%eax
    13b2:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13b6:	66 89 10             	mov    %dx,(%eax)
    13b9:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13bd:	88 50 02             	mov    %dl,0x2(%eax)
}
    13c0:	8b 45 08             	mov    0x8(%ebp),%eax
    13c3:	c9                   	leave  
    13c4:	c2 04 00             	ret    $0x4

000013c7 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13c7:	55                   	push   %ebp
    13c8:	89 e5                	mov    %esp,%ebp
    13ca:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13cd:	8b 45 08             	mov    0x8(%ebp),%eax
    13d0:	8b 00                	mov    (%eax),%eax
    13d2:	83 ec 08             	sub    $0x8,%esp
    13d5:	8d 55 0c             	lea    0xc(%ebp),%edx
    13d8:	52                   	push   %edx
    13d9:	50                   	push   %eax
    13da:	e8 8d ef ff ff       	call   36c <sendMessage>
    13df:	83 c4 10             	add    $0x10,%esp
}
    13e2:	90                   	nop
    13e3:	c9                   	leave  
    13e4:	c3                   	ret    

000013e5 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13e5:	55                   	push   %ebp
    13e6:	89 e5                	mov    %esp,%ebp
    13e8:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13eb:	83 ec 0c             	sub    $0xc,%esp
    13ee:	68 90 00 00 00       	push   $0x90
    13f3:	e8 3e f3 ff ff       	call   736 <malloc>
    13f8:	83 c4 10             	add    $0x10,%esp
    13fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    13fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1402:	75 15                	jne    1419 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1404:	83 ec 04             	sub    $0x4,%esp
    1407:	ff 75 08             	pushl  0x8(%ebp)
    140a:	68 2c 21 00 00       	push   $0x212c
    140f:	6a 01                	push   $0x1
    1411:	e8 4d f0 ff ff       	call   463 <printf>
    1416:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1419:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141c:	83 c0 7c             	add    $0x7c,%eax
    141f:	83 ec 08             	sub    $0x8,%esp
    1422:	ff 75 08             	pushl  0x8(%ebp)
    1425:	50                   	push   %eax
    1426:	e8 60 ec ff ff       	call   8b <strcpy>
    142b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    142e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1431:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1438:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143b:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1442:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1445:	8b 40 34             	mov    0x34(%eax),%eax
    1448:	89 c2                	mov    %eax,%edx
    144a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144d:	8b 40 38             	mov    0x38(%eax),%eax
    1450:	0f af d0             	imul   %eax,%edx
    1453:	89 d0                	mov    %edx,%eax
    1455:	01 c0                	add    %eax,%eax
    1457:	01 d0                	add    %edx,%eax
    1459:	83 ec 0c             	sub    $0xc,%esp
    145c:	50                   	push   %eax
    145d:	e8 d4 f2 ff ff       	call   736 <malloc>
    1462:	83 c4 10             	add    $0x10,%esp
    1465:	89 c2                	mov    %eax,%edx
    1467:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146a:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1470:	8b 40 4c             	mov    0x4c(%eax),%eax
    1473:	85 c0                	test   %eax,%eax
    1475:	75 15                	jne    148c <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1477:	83 ec 04             	sub    $0x4,%esp
    147a:	ff 75 08             	pushl  0x8(%ebp)
    147d:	68 4c 21 00 00       	push   $0x214c
    1482:	6a 01                	push   $0x1
    1484:	e8 da ef ff ff       	call   463 <printf>
    1489:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    148c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148f:	8b 40 34             	mov    0x34(%eax),%eax
    1492:	89 c2                	mov    %eax,%edx
    1494:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1497:	8b 40 38             	mov    0x38(%eax),%eax
    149a:	0f af d0             	imul   %eax,%edx
    149d:	89 d0                	mov    %edx,%eax
    149f:	01 c0                	add    %eax,%eax
    14a1:	01 c2                	add    %eax,%edx
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	8b 40 4c             	mov    0x4c(%eax),%eax
    14a9:	83 ec 04             	sub    $0x4,%esp
    14ac:	52                   	push   %edx
    14ad:	68 ff ff ff 00       	push   $0xffffff
    14b2:	50                   	push   %eax
    14b3:	e8 69 ec ff ff       	call   121 <memset>
    14b8:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14be:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14c5:	e8 72 ee ff ff       	call   33c <getpid>
    14ca:	89 c2                	mov    %eax,%edx
    14cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cf:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d5:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14df:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	8b 40 50             	mov    0x50(%eax),%eax
    14ec:	89 c2                	mov    %eax,%edx
    14ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f1:	8b 40 54             	mov    0x54(%eax),%eax
    14f4:	0f af d0             	imul   %eax,%edx
    14f7:	89 d0                	mov    %edx,%eax
    14f9:	01 c0                	add    %eax,%eax
    14fb:	01 d0                	add    %edx,%eax
    14fd:	83 ec 0c             	sub    $0xc,%esp
    1500:	50                   	push   %eax
    1501:	e8 30 f2 ff ff       	call   736 <malloc>
    1506:	83 c4 10             	add    $0x10,%esp
    1509:	89 c2                	mov    %eax,%edx
    150b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150e:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1511:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1514:	8b 40 68             	mov    0x68(%eax),%eax
    1517:	85 c0                	test   %eax,%eax
    1519:	75 15                	jne    1530 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    151b:	83 ec 04             	sub    $0x4,%esp
    151e:	ff 75 08             	pushl  0x8(%ebp)
    1521:	68 70 21 00 00       	push   $0x2170
    1526:	6a 01                	push   $0x1
    1528:	e8 36 ef ff ff       	call   463 <printf>
    152d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1530:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1533:	8b 40 34             	mov    0x34(%eax),%eax
    1536:	89 c2                	mov    %eax,%edx
    1538:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153b:	8b 40 38             	mov    0x38(%eax),%eax
    153e:	0f af d0             	imul   %eax,%edx
    1541:	89 d0                	mov    %edx,%eax
    1543:	01 c0                	add    %eax,%eax
    1545:	01 c2                	add    %eax,%edx
    1547:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154a:	8b 40 4c             	mov    0x4c(%eax),%eax
    154d:	83 ec 04             	sub    $0x4,%esp
    1550:	52                   	push   %edx
    1551:	68 ff 00 00 00       	push   $0xff
    1556:	50                   	push   %eax
    1557:	e8 c5 eb ff ff       	call   121 <memset>
    155c:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    155f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1562:	8b 55 0c             	mov    0xc(%ebp),%edx
    1565:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1568:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    156c:	74 35                	je     15a3 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    156e:	8b 45 10             	mov    0x10(%ebp),%eax
    1571:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1577:	83 ec 0c             	sub    $0xc,%esp
    157a:	50                   	push   %eax
    157b:	e8 b6 f1 ff ff       	call   736 <malloc>
    1580:	83 c4 10             	add    $0x10,%esp
    1583:	89 c2                	mov    %eax,%edx
    1585:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1588:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    158b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158e:	8b 55 10             	mov    0x10(%ebp),%edx
    1591:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1594:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1597:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    159e:	e9 8d 00 00 00       	jmp    1630 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a6:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b0:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	8b 40 18             	mov    0x18(%eax),%eax
    15bd:	89 c2                	mov    %eax,%edx
    15bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c2:	8b 40 1c             	mov    0x1c(%eax),%eax
    15c5:	0f af d0             	imul   %eax,%edx
    15c8:	89 d0                	mov    %edx,%eax
    15ca:	01 c0                	add    %eax,%eax
    15cc:	01 d0                	add    %edx,%eax
    15ce:	83 ec 0c             	sub    $0xc,%esp
    15d1:	50                   	push   %eax
    15d2:	e8 5f f1 ff ff       	call   736 <malloc>
    15d7:	83 c4 10             	add    $0x10,%esp
    15da:	89 c2                	mov    %eax,%edx
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 30             	mov    0x30(%eax),%eax
    15e8:	85 c0                	test   %eax,%eax
    15ea:	75 15                	jne    1601 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15ec:	83 ec 04             	sub    $0x4,%esp
    15ef:	ff 75 08             	pushl  0x8(%ebp)
    15f2:	68 98 21 00 00       	push   $0x2198
    15f7:	6a 01                	push   $0x1
    15f9:	e8 65 ee ff ff       	call   463 <printf>
    15fe:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1601:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1604:	8b 40 18             	mov    0x18(%eax),%eax
    1607:	89 c2                	mov    %eax,%edx
    1609:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160c:	8b 40 1c             	mov    0x1c(%eax),%eax
    160f:	0f af d0             	imul   %eax,%edx
    1612:	89 d0                	mov    %edx,%eax
    1614:	01 c0                	add    %eax,%eax
    1616:	01 c2                	add    %eax,%edx
    1618:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161b:	8b 40 30             	mov    0x30(%eax),%eax
    161e:	83 ec 04             	sub    $0x4,%esp
    1621:	52                   	push   %edx
    1622:	68 ff ff ff 00       	push   $0xffffff
    1627:	50                   	push   %eax
    1628:	e8 f4 ea ff ff       	call   121 <memset>
    162d:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1630:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1633:	c9                   	leave  
    1634:	c3                   	ret    

00001635 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1635:	55                   	push   %ebp
    1636:	89 e5                	mov    %esp,%ebp
    1638:	53                   	push   %ebx
    1639:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    163c:	8b 45 0c             	mov    0xc(%ebp),%eax
    163f:	83 f8 03             	cmp    $0x3,%eax
    1642:	74 02                	je     1646 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1644:	eb 33                	jmp    1679 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1646:	8b 45 08             	mov    0x8(%ebp),%eax
    1649:	8b 48 08             	mov    0x8(%eax),%ecx
    164c:	8b 45 08             	mov    0x8(%ebp),%eax
    164f:	8b 50 38             	mov    0x38(%eax),%edx
    1652:	8b 45 08             	mov    0x8(%ebp),%eax
    1655:	8b 40 34             	mov    0x34(%eax),%eax
    1658:	8b 5d 08             	mov    0x8(%ebp),%ebx
    165b:	83 c3 34             	add    $0x34,%ebx
    165e:	83 ec 0c             	sub    $0xc,%esp
    1661:	51                   	push   %ecx
    1662:	52                   	push   %edx
    1663:	50                   	push   %eax
    1664:	6a 00                	push   $0x0
    1666:	6a 00                	push   $0x0
    1668:	53                   	push   %ebx
    1669:	6a 32                	push   $0x32
    166b:	6a 00                	push   $0x0
    166d:	ff 75 08             	pushl  0x8(%ebp)
    1670:	e8 e7 ec ff ff       	call   35c <paintWindow>
    1675:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1678:	90                   	nop
        default: break;
            
            
    }
    return False;
    1679:	b8 00 00 00 00       	mov    $0x0,%eax
}
    167e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1681:	c9                   	leave  
    1682:	c3                   	ret    

00001683 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1683:	55                   	push   %ebp
    1684:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1686:	8b 45 0c             	mov    0xc(%ebp),%eax
    1689:	8b 50 08             	mov    0x8(%eax),%edx
    168c:	8b 45 08             	mov    0x8(%ebp),%eax
    168f:	8b 00                	mov    (%eax),%eax
    1691:	39 c2                	cmp    %eax,%edx
    1693:	74 07                	je     169c <APPreJudge+0x19>
        return False;
    1695:	b8 00 00 00 00       	mov    $0x0,%eax
    169a:	eb 05                	jmp    16a1 <APPreJudge+0x1e>
    return True;
    169c:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16a1:	5d                   	pop    %ebp
    16a2:	c3                   	ret    

000016a3 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16a3:	55                   	push   %ebp
    16a4:	89 e5                	mov    %esp,%ebp
    16a6:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16a9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ac:	8b 55 0c             	mov    0xc(%ebp),%edx
    16af:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16b2:	83 ec 0c             	sub    $0xc,%esp
    16b5:	ff 75 08             	pushl  0x8(%ebp)
    16b8:	e8 bf ec ff ff       	call   37c <registWindow>
    16bd:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16c0:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16c7:	8b 45 08             	mov    0x8(%ebp),%eax
    16ca:	8b 00                	mov    (%eax),%eax
    16cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16cf:	ff 75 f4             	pushl  -0xc(%ebp)
    16d2:	ff 75 f0             	pushl  -0x10(%ebp)
    16d5:	ff 75 ec             	pushl  -0x14(%ebp)
    16d8:	ff 75 08             	pushl  0x8(%ebp)
    16db:	e8 e7 fc ff ff       	call   13c7 <APSendMessage>
    16e0:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16e3:	83 ec 0c             	sub    $0xc,%esp
    16e6:	ff 75 08             	pushl  0x8(%ebp)
    16e9:	e8 86 ec ff ff       	call   374 <getMessage>
    16ee:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    16f1:	8b 45 08             	mov    0x8(%ebp),%eax
    16f4:	83 c0 6c             	add    $0x6c,%eax
    16f7:	83 ec 08             	sub    $0x8,%esp
    16fa:	50                   	push   %eax
    16fb:	ff 75 08             	pushl  0x8(%ebp)
    16fe:	e8 80 ff ff ff       	call   1683 <APPreJudge>
    1703:	83 c4 10             	add    $0x10,%esp
    1706:	84 c0                	test   %al,%al
    1708:	74 1b                	je     1725 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    170a:	8b 45 08             	mov    0x8(%ebp),%eax
    170d:	ff 70 74             	pushl  0x74(%eax)
    1710:	ff 70 70             	pushl  0x70(%eax)
    1713:	ff 70 6c             	pushl  0x6c(%eax)
    1716:	ff 75 08             	pushl  0x8(%ebp)
    1719:	8b 45 0c             	mov    0xc(%ebp),%eax
    171c:	ff d0                	call   *%eax
    171e:	83 c4 10             	add    $0x10,%esp
    1721:	84 c0                	test   %al,%al
    1723:	75 0c                	jne    1731 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1725:	8b 45 08             	mov    0x8(%ebp),%eax
    1728:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    172f:	eb b2                	jmp    16e3 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1731:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1732:	90                   	nop
    1733:	c9                   	leave  
    1734:	c3                   	ret    

00001735 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1735:	55                   	push   %ebp
    1736:	89 e5                	mov    %esp,%ebp
    1738:	57                   	push   %edi
    1739:	56                   	push   %esi
    173a:	53                   	push   %ebx
    173b:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    173e:	a1 f8 27 00 00       	mov    0x27f8,%eax
    1743:	85 c0                	test   %eax,%eax
    1745:	0f 85 2c 02 00 00    	jne    1977 <APGridPaint+0x242>
    {
        iconReady = 1;
    174b:	c7 05 f8 27 00 00 01 	movl   $0x1,0x27f8
    1752:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1755:	8d 45 98             	lea    -0x68(%ebp),%eax
    1758:	83 ec 08             	sub    $0x8,%esp
    175b:	68 bf 21 00 00       	push   $0x21bf
    1760:	50                   	push   %eax
    1761:	e8 83 f1 ff ff       	call   8e9 <APLoadBitmap>
    1766:	83 c4 0c             	add    $0xc,%esp
    1769:	8b 45 98             	mov    -0x68(%ebp),%eax
    176c:	a3 1c 28 00 00       	mov    %eax,0x281c
    1771:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1774:	a3 20 28 00 00       	mov    %eax,0x2820
    1779:	8b 45 a0             	mov    -0x60(%ebp),%eax
    177c:	a3 24 28 00 00       	mov    %eax,0x2824
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1781:	83 ec 04             	sub    $0x4,%esp
    1784:	ff 35 24 28 00 00    	pushl  0x2824
    178a:	ff 35 20 28 00 00    	pushl  0x2820
    1790:	ff 35 1c 28 00 00    	pushl  0x281c
    1796:	e8 88 f3 ff ff       	call   b23 <APCreateCompatibleDCFromBitmap>
    179b:	83 c4 10             	add    $0x10,%esp
    179e:	a3 28 28 00 00       	mov    %eax,0x2828
        grid_river = APLoadBitmap ("grid_river.bmp");
    17a3:	8d 45 98             	lea    -0x68(%ebp),%eax
    17a6:	83 ec 08             	sub    $0x8,%esp
    17a9:	68 cd 21 00 00       	push   $0x21cd
    17ae:	50                   	push   %eax
    17af:	e8 35 f1 ff ff       	call   8e9 <APLoadBitmap>
    17b4:	83 c4 0c             	add    $0xc,%esp
    17b7:	8b 45 98             	mov    -0x68(%ebp),%eax
    17ba:	a3 58 28 00 00       	mov    %eax,0x2858
    17bf:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17c2:	a3 5c 28 00 00       	mov    %eax,0x285c
    17c7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17ca:	a3 60 28 00 00       	mov    %eax,0x2860
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17cf:	83 ec 04             	sub    $0x4,%esp
    17d2:	ff 35 60 28 00 00    	pushl  0x2860
    17d8:	ff 35 5c 28 00 00    	pushl  0x285c
    17de:	ff 35 58 28 00 00    	pushl  0x2858
    17e4:	e8 3a f3 ff ff       	call   b23 <APCreateCompatibleDCFromBitmap>
    17e9:	83 c4 10             	add    $0x10,%esp
    17ec:	a3 48 28 00 00       	mov    %eax,0x2848
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    17f1:	8d 45 98             	lea    -0x68(%ebp),%eax
    17f4:	83 ec 08             	sub    $0x8,%esp
    17f7:	68 dc 21 00 00       	push   $0x21dc
    17fc:	50                   	push   %eax
    17fd:	e8 e7 f0 ff ff       	call   8e9 <APLoadBitmap>
    1802:	83 c4 0c             	add    $0xc,%esp
    1805:	8b 45 98             	mov    -0x68(%ebp),%eax
    1808:	a3 4c 28 00 00       	mov    %eax,0x284c
    180d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1810:	a3 50 28 00 00       	mov    %eax,0x2850
    1815:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1818:	a3 54 28 00 00       	mov    %eax,0x2854
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    181d:	83 ec 04             	sub    $0x4,%esp
    1820:	ff 35 54 28 00 00    	pushl  0x2854
    1826:	ff 35 50 28 00 00    	pushl  0x2850
    182c:	ff 35 4c 28 00 00    	pushl  0x284c
    1832:	e8 ec f2 ff ff       	call   b23 <APCreateCompatibleDCFromBitmap>
    1837:	83 c4 10             	add    $0x10,%esp
    183a:	a3 fc 27 00 00       	mov    %eax,0x27fc
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    183f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1842:	83 ec 08             	sub    $0x8,%esp
    1845:	68 eb 21 00 00       	push   $0x21eb
    184a:	50                   	push   %eax
    184b:	e8 99 f0 ff ff       	call   8e9 <APLoadBitmap>
    1850:	83 c4 0c             	add    $0xc,%esp
    1853:	8b 45 98             	mov    -0x68(%ebp),%eax
    1856:	a3 30 28 00 00       	mov    %eax,0x2830
    185b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    185e:	a3 34 28 00 00       	mov    %eax,0x2834
    1863:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1866:	a3 38 28 00 00       	mov    %eax,0x2838
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    186b:	83 ec 04             	sub    $0x4,%esp
    186e:	ff 35 38 28 00 00    	pushl  0x2838
    1874:	ff 35 34 28 00 00    	pushl  0x2834
    187a:	ff 35 30 28 00 00    	pushl  0x2830
    1880:	e8 9e f2 ff ff       	call   b23 <APCreateCompatibleDCFromBitmap>
    1885:	83 c4 10             	add    $0x10,%esp
    1888:	a3 64 28 00 00       	mov    %eax,0x2864
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    188d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1890:	83 ec 08             	sub    $0x8,%esp
    1893:	68 f9 21 00 00       	push   $0x21f9
    1898:	50                   	push   %eax
    1899:	e8 4b f0 ff ff       	call   8e9 <APLoadBitmap>
    189e:	83 c4 0c             	add    $0xc,%esp
    18a1:	8b 45 98             	mov    -0x68(%ebp),%eax
    18a4:	a3 0c 28 00 00       	mov    %eax,0x280c
    18a9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18ac:	a3 10 28 00 00       	mov    %eax,0x2810
    18b1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18b4:	a3 14 28 00 00       	mov    %eax,0x2814
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18b9:	83 ec 04             	sub    $0x4,%esp
    18bc:	ff 35 14 28 00 00    	pushl  0x2814
    18c2:	ff 35 10 28 00 00    	pushl  0x2810
    18c8:	ff 35 0c 28 00 00    	pushl  0x280c
    18ce:	e8 50 f2 ff ff       	call   b23 <APCreateCompatibleDCFromBitmap>
    18d3:	83 c4 10             	add    $0x10,%esp
    18d6:	a3 2c 28 00 00       	mov    %eax,0x282c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18db:	8d 45 98             	lea    -0x68(%ebp),%eax
    18de:	83 ec 08             	sub    $0x8,%esp
    18e1:	68 09 22 00 00       	push   $0x2209
    18e6:	50                   	push   %eax
    18e7:	e8 fd ef ff ff       	call   8e9 <APLoadBitmap>
    18ec:	83 c4 0c             	add    $0xc,%esp
    18ef:	8b 45 98             	mov    -0x68(%ebp),%eax
    18f2:	a3 00 28 00 00       	mov    %eax,0x2800
    18f7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18fa:	a3 04 28 00 00       	mov    %eax,0x2804
    18ff:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1902:	a3 08 28 00 00       	mov    %eax,0x2808
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1907:	83 ec 04             	sub    $0x4,%esp
    190a:	ff 35 08 28 00 00    	pushl  0x2808
    1910:	ff 35 04 28 00 00    	pushl  0x2804
    1916:	ff 35 00 28 00 00    	pushl  0x2800
    191c:	e8 02 f2 ff ff       	call   b23 <APCreateCompatibleDCFromBitmap>
    1921:	83 c4 10             	add    $0x10,%esp
    1924:	a3 18 28 00 00       	mov    %eax,0x2818
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1929:	8d 45 98             	lea    -0x68(%ebp),%eax
    192c:	83 ec 08             	sub    $0x8,%esp
    192f:	68 1b 22 00 00       	push   $0x221b
    1934:	50                   	push   %eax
    1935:	e8 af ef ff ff       	call   8e9 <APLoadBitmap>
    193a:	83 c4 0c             	add    $0xc,%esp
    193d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1940:	a3 3c 28 00 00       	mov    %eax,0x283c
    1945:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1948:	a3 40 28 00 00       	mov    %eax,0x2840
    194d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1950:	a3 44 28 00 00       	mov    %eax,0x2844
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1955:	83 ec 04             	sub    $0x4,%esp
    1958:	ff 35 44 28 00 00    	pushl  0x2844
    195e:	ff 35 40 28 00 00    	pushl  0x2840
    1964:	ff 35 3c 28 00 00    	pushl  0x283c
    196a:	e8 b4 f1 ff ff       	call   b23 <APCreateCompatibleDCFromBitmap>
    196f:	83 c4 10             	add    $0x10,%esp
    1972:	a3 68 28 00 00       	mov    %eax,0x2868
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1977:	8b 45 08             	mov    0x8(%ebp),%eax
    197a:	8b 40 08             	mov    0x8(%eax),%eax
    197d:	85 c0                	test   %eax,%eax
    197f:	75 17                	jne    1998 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1981:	83 ec 08             	sub    $0x8,%esp
    1984:	68 2c 22 00 00       	push   $0x222c
    1989:	6a 01                	push   $0x1
    198b:	e8 d3 ea ff ff       	call   463 <printf>
    1990:	83 c4 10             	add    $0x10,%esp
        return;
    1993:	e9 f2 03 00 00       	jmp    1d8a <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1998:	8b 45 08             	mov    0x8(%ebp),%eax
    199b:	8b 40 10             	mov    0x10(%eax),%eax
    199e:	85 c0                	test   %eax,%eax
    19a0:	7e 10                	jle    19b2 <APGridPaint+0x27d>
    19a2:	8b 45 08             	mov    0x8(%ebp),%eax
    19a5:	8b 50 14             	mov    0x14(%eax),%edx
    19a8:	8b 45 08             	mov    0x8(%ebp),%eax
    19ab:	8b 40 10             	mov    0x10(%eax),%eax
    19ae:	39 c2                	cmp    %eax,%edx
    19b0:	7c 17                	jl     19c9 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19b2:	83 ec 08             	sub    $0x8,%esp
    19b5:	68 52 22 00 00       	push   $0x2252
    19ba:	6a 01                	push   $0x1
    19bc:	e8 a2 ea ff ff       	call   463 <printf>
    19c1:	83 c4 10             	add    $0x10,%esp
        return;
    19c4:	e9 c1 03 00 00       	jmp    1d8a <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19c9:	8b 45 08             	mov    0x8(%ebp),%eax
    19cc:	8b 40 14             	mov    0x14(%eax),%eax
    19cf:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19db:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19de:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19e5:	e9 96 03 00 00       	jmp    1d80 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19ea:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19f1:	e9 7c 03 00 00       	jmp    1d72 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    19f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19f9:	c1 e0 04             	shl    $0x4,%eax
    19fc:	89 c2                	mov    %eax,%edx
    19fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a01:	01 c2                	add    %eax,%edx
    1a03:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a06:	01 d0                	add    %edx,%eax
    1a08:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0e:	8b 40 0c             	mov    0xc(%eax),%eax
    1a11:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a14:	c1 e2 02             	shl    $0x2,%edx
    1a17:	01 d0                	add    %edx,%eax
    1a19:	8b 00                	mov    (%eax),%eax
    1a1b:	83 f8 07             	cmp    $0x7,%eax
    1a1e:	0f 87 49 03 00 00    	ja     1d6d <APGridPaint+0x638>
    1a24:	8b 04 85 68 22 00 00 	mov    0x2268(,%eax,4),%eax
    1a2b:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a2d:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a30:	6a 0c                	push   $0xc
    1a32:	6a 0c                	push   $0xc
    1a34:	6a 0c                	push   $0xc
    1a36:	50                   	push   %eax
    1a37:	e8 46 f9 ff ff       	call   1382 <RGB>
    1a3c:	83 c4 0c             	add    $0xc,%esp
    1a3f:	8b 1d 28 28 00 00    	mov    0x2828,%ebx
    1a45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a48:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a4b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a4e:	6b c0 32             	imul   $0x32,%eax,%eax
    1a51:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a54:	8b 45 08             	mov    0x8(%ebp),%eax
    1a57:	8d 78 34             	lea    0x34(%eax),%edi
    1a5a:	83 ec 0c             	sub    $0xc,%esp
    1a5d:	83 ec 04             	sub    $0x4,%esp
    1a60:	89 e0                	mov    %esp,%eax
    1a62:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a66:	66 89 30             	mov    %si,(%eax)
    1a69:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a6d:	88 50 02             	mov    %dl,0x2(%eax)
    1a70:	6a 32                	push   $0x32
    1a72:	6a 32                	push   $0x32
    1a74:	6a 00                	push   $0x0
    1a76:	6a 00                	push   $0x0
    1a78:	53                   	push   %ebx
    1a79:	51                   	push   %ecx
    1a7a:	ff 75 94             	pushl  -0x6c(%ebp)
    1a7d:	57                   	push   %edi
    1a7e:	e8 5b f7 ff ff       	call   11de <APDcCopy>
    1a83:	83 c4 30             	add    $0x30,%esp
                    break;
    1a86:	e9 e3 02 00 00       	jmp    1d6e <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a8b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a8e:	6a 69                	push   $0x69
    1a90:	6a 69                	push   $0x69
    1a92:	6a 69                	push   $0x69
    1a94:	50                   	push   %eax
    1a95:	e8 e8 f8 ff ff       	call   1382 <RGB>
    1a9a:	83 c4 0c             	add    $0xc,%esp
    1a9d:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1aa1:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1aa5:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1aa9:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1aac:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ab3:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ab6:	6a 69                	push   $0x69
    1ab8:	6a 69                	push   $0x69
    1aba:	6a 69                	push   $0x69
    1abc:	50                   	push   %eax
    1abd:	e8 c0 f8 ff ff       	call   1382 <RGB>
    1ac2:	83 c4 0c             	add    $0xc,%esp
    1ac5:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ac9:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1acd:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ad1:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ad4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad7:	8d 50 34             	lea    0x34(%eax),%edx
    1ada:	8d 45 98             	lea    -0x68(%ebp),%eax
    1add:	ff 75 bc             	pushl  -0x44(%ebp)
    1ae0:	ff 75 b8             	pushl  -0x48(%ebp)
    1ae3:	52                   	push   %edx
    1ae4:	50                   	push   %eax
    1ae5:	e8 ce f0 ff ff       	call   bb8 <APSetPen>
    1aea:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1aed:	8b 45 08             	mov    0x8(%ebp),%eax
    1af0:	8d 58 34             	lea    0x34(%eax),%ebx
    1af3:	8d 55 98             	lea    -0x68(%ebp),%edx
    1af6:	83 ec 04             	sub    $0x4,%esp
    1af9:	83 ec 04             	sub    $0x4,%esp
    1afc:	89 e0                	mov    %esp,%eax
    1afe:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1b02:	66 89 08             	mov    %cx,(%eax)
    1b05:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b09:	88 48 02             	mov    %cl,0x2(%eax)
    1b0c:	53                   	push   %ebx
    1b0d:	52                   	push   %edx
    1b0e:	e8 de f0 ff ff       	call   bf1 <APSetBrush>
    1b13:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b19:	6b d0 32             	imul   $0x32,%eax,%edx
    1b1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b1f:	6b c0 32             	imul   $0x32,%eax,%eax
    1b22:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b25:	83 c1 34             	add    $0x34,%ecx
    1b28:	83 ec 0c             	sub    $0xc,%esp
    1b2b:	6a 32                	push   $0x32
    1b2d:	6a 32                	push   $0x32
    1b2f:	52                   	push   %edx
    1b30:	50                   	push   %eax
    1b31:	51                   	push   %ecx
    1b32:	e8 a2 f4 ff ff       	call   fd9 <APDrawRect>
    1b37:	83 c4 20             	add    $0x20,%esp
                    break;
    1b3a:	e9 2f 02 00 00       	jmp    1d6e <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b3f:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b42:	6a 0c                	push   $0xc
    1b44:	6a 0c                	push   $0xc
    1b46:	6a 0c                	push   $0xc
    1b48:	50                   	push   %eax
    1b49:	e8 34 f8 ff ff       	call   1382 <RGB>
    1b4e:	83 c4 0c             	add    $0xc,%esp
    1b51:	8b 1d 68 28 00 00    	mov    0x2868,%ebx
    1b57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b5a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b60:	6b c0 32             	imul   $0x32,%eax,%eax
    1b63:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b66:	8b 45 08             	mov    0x8(%ebp),%eax
    1b69:	8d 78 34             	lea    0x34(%eax),%edi
    1b6c:	83 ec 0c             	sub    $0xc,%esp
    1b6f:	83 ec 04             	sub    $0x4,%esp
    1b72:	89 e0                	mov    %esp,%eax
    1b74:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b78:	66 89 30             	mov    %si,(%eax)
    1b7b:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b7f:	88 50 02             	mov    %dl,0x2(%eax)
    1b82:	6a 32                	push   $0x32
    1b84:	6a 32                	push   $0x32
    1b86:	6a 00                	push   $0x0
    1b88:	6a 00                	push   $0x0
    1b8a:	53                   	push   %ebx
    1b8b:	51                   	push   %ecx
    1b8c:	ff 75 94             	pushl  -0x6c(%ebp)
    1b8f:	57                   	push   %edi
    1b90:	e8 49 f6 ff ff       	call   11de <APDcCopy>
    1b95:	83 c4 30             	add    $0x30,%esp
                    break;
    1b98:	e9 d1 01 00 00       	jmp    1d6e <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b9d:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ba0:	6a 0c                	push   $0xc
    1ba2:	6a 0c                	push   $0xc
    1ba4:	6a 0c                	push   $0xc
    1ba6:	50                   	push   %eax
    1ba7:	e8 d6 f7 ff ff       	call   1382 <RGB>
    1bac:	83 c4 0c             	add    $0xc,%esp
    1baf:	8b 1d 48 28 00 00    	mov    0x2848,%ebx
    1bb5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bb8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bbe:	6b c0 32             	imul   $0x32,%eax,%eax
    1bc1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc7:	8d 78 34             	lea    0x34(%eax),%edi
    1bca:	83 ec 0c             	sub    $0xc,%esp
    1bcd:	83 ec 04             	sub    $0x4,%esp
    1bd0:	89 e0                	mov    %esp,%eax
    1bd2:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1bd6:	66 89 30             	mov    %si,(%eax)
    1bd9:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1bdd:	88 50 02             	mov    %dl,0x2(%eax)
    1be0:	6a 32                	push   $0x32
    1be2:	6a 32                	push   $0x32
    1be4:	6a 00                	push   $0x0
    1be6:	6a 00                	push   $0x0
    1be8:	53                   	push   %ebx
    1be9:	51                   	push   %ecx
    1bea:	ff 75 94             	pushl  -0x6c(%ebp)
    1bed:	57                   	push   %edi
    1bee:	e8 eb f5 ff ff       	call   11de <APDcCopy>
    1bf3:	83 c4 30             	add    $0x30,%esp
                    break;
    1bf6:	e9 73 01 00 00       	jmp    1d6e <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bfb:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1bfe:	6a 0c                	push   $0xc
    1c00:	6a 0c                	push   $0xc
    1c02:	6a 0c                	push   $0xc
    1c04:	50                   	push   %eax
    1c05:	e8 78 f7 ff ff       	call   1382 <RGB>
    1c0a:	83 c4 0c             	add    $0xc,%esp
    1c0d:	8b 1d 2c 28 00 00    	mov    0x282c,%ebx
    1c13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c16:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c19:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c1c:	6b c0 32             	imul   $0x32,%eax,%eax
    1c1f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c22:	8b 45 08             	mov    0x8(%ebp),%eax
    1c25:	8d 78 34             	lea    0x34(%eax),%edi
    1c28:	83 ec 0c             	sub    $0xc,%esp
    1c2b:	83 ec 04             	sub    $0x4,%esp
    1c2e:	89 e0                	mov    %esp,%eax
    1c30:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c34:	66 89 30             	mov    %si,(%eax)
    1c37:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c3b:	88 50 02             	mov    %dl,0x2(%eax)
    1c3e:	6a 32                	push   $0x32
    1c40:	6a 32                	push   $0x32
    1c42:	6a 00                	push   $0x0
    1c44:	6a 00                	push   $0x0
    1c46:	53                   	push   %ebx
    1c47:	51                   	push   %ecx
    1c48:	ff 75 94             	pushl  -0x6c(%ebp)
    1c4b:	57                   	push   %edi
    1c4c:	e8 8d f5 ff ff       	call   11de <APDcCopy>
    1c51:	83 c4 30             	add    $0x30,%esp
                    break;
    1c54:	e9 15 01 00 00       	jmp    1d6e <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c59:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c5c:	6a 0c                	push   $0xc
    1c5e:	6a 0c                	push   $0xc
    1c60:	6a 0c                	push   $0xc
    1c62:	50                   	push   %eax
    1c63:	e8 1a f7 ff ff       	call   1382 <RGB>
    1c68:	83 c4 0c             	add    $0xc,%esp
    1c6b:	8b 1d 64 28 00 00    	mov    0x2864,%ebx
    1c71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c74:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c77:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c7a:	6b c0 32             	imul   $0x32,%eax,%eax
    1c7d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c80:	8b 45 08             	mov    0x8(%ebp),%eax
    1c83:	8d 78 34             	lea    0x34(%eax),%edi
    1c86:	83 ec 0c             	sub    $0xc,%esp
    1c89:	83 ec 04             	sub    $0x4,%esp
    1c8c:	89 e0                	mov    %esp,%eax
    1c8e:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1c92:	66 89 30             	mov    %si,(%eax)
    1c95:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1c99:	88 50 02             	mov    %dl,0x2(%eax)
    1c9c:	6a 32                	push   $0x32
    1c9e:	6a 32                	push   $0x32
    1ca0:	6a 00                	push   $0x0
    1ca2:	6a 00                	push   $0x0
    1ca4:	53                   	push   %ebx
    1ca5:	51                   	push   %ecx
    1ca6:	ff 75 94             	pushl  -0x6c(%ebp)
    1ca9:	57                   	push   %edi
    1caa:	e8 2f f5 ff ff       	call   11de <APDcCopy>
    1caf:	83 c4 30             	add    $0x30,%esp
                    break;
    1cb2:	e9 b7 00 00 00       	jmp    1d6e <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cb7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cba:	6a 0c                	push   $0xc
    1cbc:	6a 0c                	push   $0xc
    1cbe:	6a 0c                	push   $0xc
    1cc0:	50                   	push   %eax
    1cc1:	e8 bc f6 ff ff       	call   1382 <RGB>
    1cc6:	83 c4 0c             	add    $0xc,%esp
    1cc9:	8b 1d fc 27 00 00    	mov    0x27fc,%ebx
    1ccf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cd8:	6b c0 32             	imul   $0x32,%eax,%eax
    1cdb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cde:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce1:	8d 78 34             	lea    0x34(%eax),%edi
    1ce4:	83 ec 0c             	sub    $0xc,%esp
    1ce7:	83 ec 04             	sub    $0x4,%esp
    1cea:	89 e0                	mov    %esp,%eax
    1cec:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1cf0:	66 89 30             	mov    %si,(%eax)
    1cf3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1cf7:	88 50 02             	mov    %dl,0x2(%eax)
    1cfa:	6a 32                	push   $0x32
    1cfc:	6a 32                	push   $0x32
    1cfe:	6a 00                	push   $0x0
    1d00:	6a 00                	push   $0x0
    1d02:	53                   	push   %ebx
    1d03:	51                   	push   %ecx
    1d04:	ff 75 94             	pushl  -0x6c(%ebp)
    1d07:	57                   	push   %edi
    1d08:	e8 d1 f4 ff ff       	call   11de <APDcCopy>
    1d0d:	83 c4 30             	add    $0x30,%esp
                    break;
    1d10:	eb 5c                	jmp    1d6e <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d12:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d15:	6a 0c                	push   $0xc
    1d17:	6a 0c                	push   $0xc
    1d19:	6a 0c                	push   $0xc
    1d1b:	50                   	push   %eax
    1d1c:	e8 61 f6 ff ff       	call   1382 <RGB>
    1d21:	83 c4 0c             	add    $0xc,%esp
    1d24:	8b 1d 18 28 00 00    	mov    0x2818,%ebx
    1d2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d2d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d30:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d33:	6b c0 32             	imul   $0x32,%eax,%eax
    1d36:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d39:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3c:	8d 78 34             	lea    0x34(%eax),%edi
    1d3f:	83 ec 0c             	sub    $0xc,%esp
    1d42:	83 ec 04             	sub    $0x4,%esp
    1d45:	89 e0                	mov    %esp,%eax
    1d47:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d4b:	66 89 30             	mov    %si,(%eax)
    1d4e:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d52:	88 50 02             	mov    %dl,0x2(%eax)
    1d55:	6a 32                	push   $0x32
    1d57:	6a 32                	push   $0x32
    1d59:	6a 00                	push   $0x0
    1d5b:	6a 00                	push   $0x0
    1d5d:	53                   	push   %ebx
    1d5e:	51                   	push   %ecx
    1d5f:	ff 75 94             	pushl  -0x6c(%ebp)
    1d62:	57                   	push   %edi
    1d63:	e8 76 f4 ff ff       	call   11de <APDcCopy>
    1d68:	83 c4 30             	add    $0x30,%esp
                    break;
    1d6b:	eb 01                	jmp    1d6e <APGridPaint+0x639>
                default: break;
    1d6d:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d6e:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d72:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d76:	0f 8e 7a fc ff ff    	jle    19f6 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d7c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d80:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d84:	0f 8e 60 fc ff ff    	jle    19ea <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d8d:	5b                   	pop    %ebx
    1d8e:	5e                   	pop    %esi
    1d8f:	5f                   	pop    %edi
    1d90:	5d                   	pop    %ebp
    1d91:	c3                   	ret    

00001d92 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1d92:	55                   	push   %ebp
    1d93:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1d95:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1d99:	7e 08                	jle    1da3 <random+0x11>
{
rand_num = seed;
    1d9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9e:	a3 d4 27 00 00       	mov    %eax,0x27d4
}
rand_num *= 3;
    1da3:	8b 15 d4 27 00 00    	mov    0x27d4,%edx
    1da9:	89 d0                	mov    %edx,%eax
    1dab:	01 c0                	add    %eax,%eax
    1dad:	01 d0                	add    %edx,%eax
    1daf:	a3 d4 27 00 00       	mov    %eax,0x27d4
if (rand_num < 0)
    1db4:	a1 d4 27 00 00       	mov    0x27d4,%eax
    1db9:	85 c0                	test   %eax,%eax
    1dbb:	79 0c                	jns    1dc9 <random+0x37>
{
rand_num *= (-1);
    1dbd:	a1 d4 27 00 00       	mov    0x27d4,%eax
    1dc2:	f7 d8                	neg    %eax
    1dc4:	a3 d4 27 00 00       	mov    %eax,0x27d4
}
return rand_num % 997;
    1dc9:	8b 0d d4 27 00 00    	mov    0x27d4,%ecx
    1dcf:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1dd4:	89 c8                	mov    %ecx,%eax
    1dd6:	f7 ea                	imul   %edx
    1dd8:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1ddb:	c1 f8 09             	sar    $0x9,%eax
    1dde:	89 c2                	mov    %eax,%edx
    1de0:	89 c8                	mov    %ecx,%eax
    1de2:	c1 f8 1f             	sar    $0x1f,%eax
    1de5:	29 c2                	sub    %eax,%edx
    1de7:	89 d0                	mov    %edx,%eax
    1de9:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1def:	29 c1                	sub    %eax,%ecx
    1df1:	89 c8                	mov    %ecx,%eax
}
    1df3:	5d                   	pop    %ebp
    1df4:	c3                   	ret    

00001df5 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1df5:	55                   	push   %ebp
    1df6:	89 e5                	mov    %esp,%ebp
    1df8:	53                   	push   %ebx
    1df9:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1dfc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e03:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e07:	74 17                	je     1e20 <sprintint+0x2b>
    1e09:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e0d:	79 11                	jns    1e20 <sprintint+0x2b>
        neg = 1;
    1e0f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e16:	8b 45 10             	mov    0x10(%ebp),%eax
    1e19:	f7 d8                	neg    %eax
    1e1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e1e:	eb 06                	jmp    1e26 <sprintint+0x31>
    } else {
        x = xx;
    1e20:	8b 45 10             	mov    0x10(%ebp),%eax
    1e23:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e26:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1e2d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1e30:	8d 41 01             	lea    0x1(%ecx),%eax
    1e33:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e36:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e39:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e3c:	ba 00 00 00 00       	mov    $0x0,%edx
    1e41:	f7 f3                	div    %ebx
    1e43:	89 d0                	mov    %edx,%eax
    1e45:	0f b6 80 d8 27 00 00 	movzbl 0x27d8(%eax),%eax
    1e4c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e50:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e53:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e56:	ba 00 00 00 00       	mov    $0x0,%edx
    1e5b:	f7 f3                	div    %ebx
    1e5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e60:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e64:	75 c7                	jne    1e2d <sprintint+0x38>
    if(neg)
    1e66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e6a:	74 0e                	je     1e7a <sprintint+0x85>
        buf[i++] = '-';
    1e6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e6f:	8d 50 01             	lea    0x1(%eax),%edx
    1e72:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e75:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e7d:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e80:	eb 1b                	jmp    1e9d <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e82:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e85:	8b 00                	mov    (%eax),%eax
    1e87:	8d 48 01             	lea    0x1(%eax),%ecx
    1e8a:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e8d:	89 0a                	mov    %ecx,(%edx)
    1e8f:	89 c2                	mov    %eax,%edx
    1e91:	8b 45 08             	mov    0x8(%ebp),%eax
    1e94:	01 d0                	add    %edx,%eax
    1e96:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e99:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e9d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1ea1:	7f df                	jg     1e82 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ea3:	eb 21                	jmp    1ec6 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1ea5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ea8:	8b 00                	mov    (%eax),%eax
    1eaa:	8d 48 01             	lea    0x1(%eax),%ecx
    1ead:	8b 55 0c             	mov    0xc(%ebp),%edx
    1eb0:	89 0a                	mov    %ecx,(%edx)
    1eb2:	89 c2                	mov    %eax,%edx
    1eb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb7:	01 c2                	add    %eax,%edx
    1eb9:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1ebc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ebf:	01 c8                	add    %ecx,%eax
    1ec1:	0f b6 00             	movzbl (%eax),%eax
    1ec4:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ec6:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1eca:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1ece:	79 d5                	jns    1ea5 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1ed0:	90                   	nop
    1ed1:	83 c4 20             	add    $0x20,%esp
    1ed4:	5b                   	pop    %ebx
    1ed5:	5d                   	pop    %ebp
    1ed6:	c3                   	ret    

00001ed7 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1ed7:	55                   	push   %ebp
    1ed8:	89 e5                	mov    %esp,%ebp
    1eda:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1edd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1ee4:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1eeb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1ef2:	8d 45 0c             	lea    0xc(%ebp),%eax
    1ef5:	83 c0 04             	add    $0x4,%eax
    1ef8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1efb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f02:	e9 d9 01 00 00       	jmp    20e0 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f07:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f0d:	01 d0                	add    %edx,%eax
    1f0f:	0f b6 00             	movzbl (%eax),%eax
    1f12:	0f be c0             	movsbl %al,%eax
    1f15:	25 ff 00 00 00       	and    $0xff,%eax
    1f1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f1d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f21:	75 2c                	jne    1f4f <sprintf+0x78>
            if(c == '%'){
    1f23:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f27:	75 0c                	jne    1f35 <sprintf+0x5e>
                state = '%';
    1f29:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1f30:	e9 a7 01 00 00       	jmp    20dc <sprintf+0x205>
            } else {
                dst[j++] = c;
    1f35:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f38:	8d 50 01             	lea    0x1(%eax),%edx
    1f3b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f3e:	89 c2                	mov    %eax,%edx
    1f40:	8b 45 08             	mov    0x8(%ebp),%eax
    1f43:	01 d0                	add    %edx,%eax
    1f45:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f48:	88 10                	mov    %dl,(%eax)
    1f4a:	e9 8d 01 00 00       	jmp    20dc <sprintf+0x205>
            }
        } else if(state == '%'){
    1f4f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f53:	0f 85 83 01 00 00    	jne    20dc <sprintf+0x205>
            if(c == 'd'){
    1f59:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f5d:	75 4c                	jne    1fab <sprintf+0xd4>
                buf[bi] = '\0';
    1f5f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f62:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f65:	01 d0                	add    %edx,%eax
    1f67:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f6a:	83 ec 0c             	sub    $0xc,%esp
    1f6d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f70:	50                   	push   %eax
    1f71:	e8 b4 e2 ff ff       	call   22a <atoi>
    1f76:	83 c4 10             	add    $0x10,%esp
    1f79:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f7c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f86:	8b 00                	mov    (%eax),%eax
    1f88:	83 ec 08             	sub    $0x8,%esp
    1f8b:	ff 75 d8             	pushl  -0x28(%ebp)
    1f8e:	6a 01                	push   $0x1
    1f90:	6a 0a                	push   $0xa
    1f92:	50                   	push   %eax
    1f93:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f96:	50                   	push   %eax
    1f97:	ff 75 08             	pushl  0x8(%ebp)
    1f9a:	e8 56 fe ff ff       	call   1df5 <sprintint>
    1f9f:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fa2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fa6:	e9 2a 01 00 00       	jmp    20d5 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1fab:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1faf:	74 06                	je     1fb7 <sprintf+0xe0>
    1fb1:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1fb5:	75 4c                	jne    2003 <sprintf+0x12c>
                buf[bi] = '\0';
    1fb7:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fbd:	01 d0                	add    %edx,%eax
    1fbf:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fc2:	83 ec 0c             	sub    $0xc,%esp
    1fc5:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1fc8:	50                   	push   %eax
    1fc9:	e8 5c e2 ff ff       	call   22a <atoi>
    1fce:	83 c4 10             	add    $0x10,%esp
    1fd1:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1fd4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1fdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fde:	8b 00                	mov    (%eax),%eax
    1fe0:	83 ec 08             	sub    $0x8,%esp
    1fe3:	ff 75 dc             	pushl  -0x24(%ebp)
    1fe6:	6a 00                	push   $0x0
    1fe8:	6a 10                	push   $0x10
    1fea:	50                   	push   %eax
    1feb:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fee:	50                   	push   %eax
    1fef:	ff 75 08             	pushl  0x8(%ebp)
    1ff2:	e8 fe fd ff ff       	call   1df5 <sprintint>
    1ff7:	83 c4 20             	add    $0x20,%esp
                ap++;
    1ffa:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1ffe:	e9 d2 00 00 00       	jmp    20d5 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2003:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2007:	75 46                	jne    204f <sprintf+0x178>
                s = (char*)*ap;
    2009:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    200c:	8b 00                	mov    (%eax),%eax
    200e:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2011:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2015:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2019:	75 25                	jne    2040 <sprintf+0x169>
                    s = "(null)";
    201b:	c7 45 f4 88 22 00 00 	movl   $0x2288,-0xc(%ebp)
                while(*s != 0){
    2022:	eb 1c                	jmp    2040 <sprintf+0x169>
                    dst[j++] = *s;
    2024:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2027:	8d 50 01             	lea    0x1(%eax),%edx
    202a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    202d:	89 c2                	mov    %eax,%edx
    202f:	8b 45 08             	mov    0x8(%ebp),%eax
    2032:	01 c2                	add    %eax,%edx
    2034:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2037:	0f b6 00             	movzbl (%eax),%eax
    203a:	88 02                	mov    %al,(%edx)
                    s++;
    203c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2040:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2043:	0f b6 00             	movzbl (%eax),%eax
    2046:	84 c0                	test   %al,%al
    2048:	75 da                	jne    2024 <sprintf+0x14d>
    204a:	e9 86 00 00 00       	jmp    20d5 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    204f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2053:	75 1d                	jne    2072 <sprintf+0x19b>
                dst[j++] = *ap;
    2055:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2058:	8d 50 01             	lea    0x1(%eax),%edx
    205b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    205e:	89 c2                	mov    %eax,%edx
    2060:	8b 45 08             	mov    0x8(%ebp),%eax
    2063:	01 c2                	add    %eax,%edx
    2065:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2068:	8b 00                	mov    (%eax),%eax
    206a:	88 02                	mov    %al,(%edx)
                ap++;
    206c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2070:	eb 63                	jmp    20d5 <sprintf+0x1fe>
            } else if(c == '%'){
    2072:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2076:	75 17                	jne    208f <sprintf+0x1b8>
                dst[j++] = c;
    2078:	8b 45 c8             	mov    -0x38(%ebp),%eax
    207b:	8d 50 01             	lea    0x1(%eax),%edx
    207e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2081:	89 c2                	mov    %eax,%edx
    2083:	8b 45 08             	mov    0x8(%ebp),%eax
    2086:	01 d0                	add    %edx,%eax
    2088:	8b 55 e0             	mov    -0x20(%ebp),%edx
    208b:	88 10                	mov    %dl,(%eax)
    208d:	eb 46                	jmp    20d5 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    208f:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2093:	7e 18                	jle    20ad <sprintf+0x1d6>
    2095:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2099:	7f 12                	jg     20ad <sprintf+0x1d6>
            {
                buf[bi++] = c;
    209b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    209e:	8d 50 01             	lea    0x1(%eax),%edx
    20a1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    20a4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20a7:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    20ab:	eb 2f                	jmp    20dc <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    20ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20b0:	8d 50 01             	lea    0x1(%eax),%edx
    20b3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20b6:	89 c2                	mov    %eax,%edx
    20b8:	8b 45 08             	mov    0x8(%ebp),%eax
    20bb:	01 d0                	add    %edx,%eax
    20bd:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    20c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20c3:	8d 50 01             	lea    0x1(%eax),%edx
    20c6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c9:	89 c2                	mov    %eax,%edx
    20cb:	8b 45 08             	mov    0x8(%ebp),%eax
    20ce:	01 d0                	add    %edx,%eax
    20d0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20d3:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    20d5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    20dc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    20e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    20e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20e6:	01 d0                	add    %edx,%eax
    20e8:	0f b6 00             	movzbl (%eax),%eax
    20eb:	84 c0                	test   %al,%al
    20ed:	0f 85 14 fe ff ff    	jne    1f07 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    20f3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f6:	8d 50 01             	lea    0x1(%eax),%edx
    20f9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20fc:	89 c2                	mov    %eax,%edx
    20fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2101:	01 d0                	add    %edx,%eax
    2103:	c6 00 00             	movb   $0x0,(%eax)
}
    2106:	90                   	nop
    2107:	c9                   	leave  
    2108:	c3                   	ret    
