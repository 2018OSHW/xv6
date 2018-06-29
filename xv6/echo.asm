
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
      27:	ba 2c 22 00 00       	mov    $0x222c,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba 2e 22 00 00       	mov    $0x222e,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 30 22 00 00       	push   $0x2230
      4b:	6a 01                	push   $0x1
      4d:	e8 19 04 00 00       	call   46b <printf>
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

00000364 <sendMessage>:
SYSCALL(sendMessage)
     364:	b8 17 00 00 00       	mov    $0x17,%eax
     369:	cd 40                	int    $0x40
     36b:	c3                   	ret    

0000036c <getMessage>:
SYSCALL(getMessage)
     36c:	b8 19 00 00 00       	mov    $0x19,%eax
     371:	cd 40                	int    $0x40
     373:	c3                   	ret    

00000374 <registWindow>:
SYSCALL(registWindow)
     374:	b8 18 00 00 00       	mov    $0x18,%eax
     379:	cd 40                	int    $0x40
     37b:	c3                   	ret    

0000037c <changePosition>:
SYSCALL(changePosition)
     37c:	b8 1a 00 00 00       	mov    $0x1a,%eax
     381:	cd 40                	int    $0x40
     383:	c3                   	ret    

00000384 <setupTimer>:
SYSCALL(setupTimer)
     384:	b8 1b 00 00 00       	mov    $0x1b,%eax
     389:	cd 40                	int    $0x40
     38b:	c3                   	ret    

0000038c <deleteTimer>:
SYSCALL(deleteTimer)
     38c:	b8 1c 00 00 00       	mov    $0x1c,%eax
     391:	cd 40                	int    $0x40
     393:	c3                   	ret    

00000394 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     394:	55                   	push   %ebp
     395:	89 e5                	mov    %esp,%ebp
     397:	83 ec 18             	sub    $0x18,%esp
     39a:	8b 45 0c             	mov    0xc(%ebp),%eax
     39d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3a0:	83 ec 04             	sub    $0x4,%esp
     3a3:	6a 01                	push   $0x1
     3a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3a8:	50                   	push   %eax
     3a9:	ff 75 08             	pushl  0x8(%ebp)
     3ac:	e8 2b ff ff ff       	call   2dc <write>
     3b1:	83 c4 10             	add    $0x10,%esp
}
     3b4:	90                   	nop
     3b5:	c9                   	leave  
     3b6:	c3                   	ret    

000003b7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3b7:	55                   	push   %ebp
     3b8:	89 e5                	mov    %esp,%ebp
     3ba:	53                   	push   %ebx
     3bb:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3c5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3c9:	74 17                	je     3e2 <printint+0x2b>
     3cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3cf:	79 11                	jns    3e2 <printint+0x2b>
    neg = 1;
     3d1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3d8:	8b 45 0c             	mov    0xc(%ebp),%eax
     3db:	f7 d8                	neg    %eax
     3dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3e0:	eb 06                	jmp    3e8 <printint+0x31>
  } else {
    x = xx;
     3e2:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3ef:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3f2:	8d 41 01             	lea    0x1(%ecx),%eax
     3f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3fe:	ba 00 00 00 00       	mov    $0x0,%edx
     403:	f7 f3                	div    %ebx
     405:	89 d0                	mov    %edx,%eax
     407:	0f b6 80 08 29 00 00 	movzbl 0x2908(%eax),%eax
     40e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     412:	8b 5d 10             	mov    0x10(%ebp),%ebx
     415:	8b 45 ec             	mov    -0x14(%ebp),%eax
     418:	ba 00 00 00 00       	mov    $0x0,%edx
     41d:	f7 f3                	div    %ebx
     41f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     422:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     426:	75 c7                	jne    3ef <printint+0x38>
  if(neg)
     428:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     42c:	74 2d                	je     45b <printint+0xa4>
    buf[i++] = '-';
     42e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     431:	8d 50 01             	lea    0x1(%eax),%edx
     434:	89 55 f4             	mov    %edx,-0xc(%ebp)
     437:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     43c:	eb 1d                	jmp    45b <printint+0xa4>
    putc(fd, buf[i]);
     43e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     441:	8b 45 f4             	mov    -0xc(%ebp),%eax
     444:	01 d0                	add    %edx,%eax
     446:	0f b6 00             	movzbl (%eax),%eax
     449:	0f be c0             	movsbl %al,%eax
     44c:	83 ec 08             	sub    $0x8,%esp
     44f:	50                   	push   %eax
     450:	ff 75 08             	pushl  0x8(%ebp)
     453:	e8 3c ff ff ff       	call   394 <putc>
     458:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     45b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     45f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     463:	79 d9                	jns    43e <printint+0x87>
    putc(fd, buf[i]);
}
     465:	90                   	nop
     466:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     469:	c9                   	leave  
     46a:	c3                   	ret    

0000046b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     46b:	55                   	push   %ebp
     46c:	89 e5                	mov    %esp,%ebp
     46e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     471:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     478:	8d 45 0c             	lea    0xc(%ebp),%eax
     47b:	83 c0 04             	add    $0x4,%eax
     47e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     481:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     488:	e9 59 01 00 00       	jmp    5e6 <printf+0x17b>
    c = fmt[i] & 0xff;
     48d:	8b 55 0c             	mov    0xc(%ebp),%edx
     490:	8b 45 f0             	mov    -0x10(%ebp),%eax
     493:	01 d0                	add    %edx,%eax
     495:	0f b6 00             	movzbl (%eax),%eax
     498:	0f be c0             	movsbl %al,%eax
     49b:	25 ff 00 00 00       	and    $0xff,%eax
     4a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4a3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4a7:	75 2c                	jne    4d5 <printf+0x6a>
      if(c == '%'){
     4a9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4ad:	75 0c                	jne    4bb <printf+0x50>
        state = '%';
     4af:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4b6:	e9 27 01 00 00       	jmp    5e2 <printf+0x177>
      } else {
        putc(fd, c);
     4bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4be:	0f be c0             	movsbl %al,%eax
     4c1:	83 ec 08             	sub    $0x8,%esp
     4c4:	50                   	push   %eax
     4c5:	ff 75 08             	pushl  0x8(%ebp)
     4c8:	e8 c7 fe ff ff       	call   394 <putc>
     4cd:	83 c4 10             	add    $0x10,%esp
     4d0:	e9 0d 01 00 00       	jmp    5e2 <printf+0x177>
      }
    } else if(state == '%'){
     4d5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4d9:	0f 85 03 01 00 00    	jne    5e2 <printf+0x177>
      if(c == 'd'){
     4df:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4e3:	75 1e                	jne    503 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4e8:	8b 00                	mov    (%eax),%eax
     4ea:	6a 01                	push   $0x1
     4ec:	6a 0a                	push   $0xa
     4ee:	50                   	push   %eax
     4ef:	ff 75 08             	pushl  0x8(%ebp)
     4f2:	e8 c0 fe ff ff       	call   3b7 <printint>
     4f7:	83 c4 10             	add    $0x10,%esp
        ap++;
     4fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4fe:	e9 d8 00 00 00       	jmp    5db <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     503:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     507:	74 06                	je     50f <printf+0xa4>
     509:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     50d:	75 1e                	jne    52d <printf+0xc2>
        printint(fd, *ap, 16, 0);
     50f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     512:	8b 00                	mov    (%eax),%eax
     514:	6a 00                	push   $0x0
     516:	6a 10                	push   $0x10
     518:	50                   	push   %eax
     519:	ff 75 08             	pushl  0x8(%ebp)
     51c:	e8 96 fe ff ff       	call   3b7 <printint>
     521:	83 c4 10             	add    $0x10,%esp
        ap++;
     524:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     528:	e9 ae 00 00 00       	jmp    5db <printf+0x170>
      } else if(c == 's'){
     52d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     531:	75 43                	jne    576 <printf+0x10b>
        s = (char*)*ap;
     533:	8b 45 e8             	mov    -0x18(%ebp),%eax
     536:	8b 00                	mov    (%eax),%eax
     538:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     53b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     53f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     543:	75 25                	jne    56a <printf+0xff>
          s = "(null)";
     545:	c7 45 f4 35 22 00 00 	movl   $0x2235,-0xc(%ebp)
        while(*s != 0){
     54c:	eb 1c                	jmp    56a <printf+0xff>
          putc(fd, *s);
     54e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     551:	0f b6 00             	movzbl (%eax),%eax
     554:	0f be c0             	movsbl %al,%eax
     557:	83 ec 08             	sub    $0x8,%esp
     55a:	50                   	push   %eax
     55b:	ff 75 08             	pushl  0x8(%ebp)
     55e:	e8 31 fe ff ff       	call   394 <putc>
     563:	83 c4 10             	add    $0x10,%esp
          s++;
     566:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     56a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56d:	0f b6 00             	movzbl (%eax),%eax
     570:	84 c0                	test   %al,%al
     572:	75 da                	jne    54e <printf+0xe3>
     574:	eb 65                	jmp    5db <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     576:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     57a:	75 1d                	jne    599 <printf+0x12e>
        putc(fd, *ap);
     57c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     57f:	8b 00                	mov    (%eax),%eax
     581:	0f be c0             	movsbl %al,%eax
     584:	83 ec 08             	sub    $0x8,%esp
     587:	50                   	push   %eax
     588:	ff 75 08             	pushl  0x8(%ebp)
     58b:	e8 04 fe ff ff       	call   394 <putc>
     590:	83 c4 10             	add    $0x10,%esp
        ap++;
     593:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     597:	eb 42                	jmp    5db <printf+0x170>
      } else if(c == '%'){
     599:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     59d:	75 17                	jne    5b6 <printf+0x14b>
        putc(fd, c);
     59f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a2:	0f be c0             	movsbl %al,%eax
     5a5:	83 ec 08             	sub    $0x8,%esp
     5a8:	50                   	push   %eax
     5a9:	ff 75 08             	pushl  0x8(%ebp)
     5ac:	e8 e3 fd ff ff       	call   394 <putc>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	eb 25                	jmp    5db <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5b6:	83 ec 08             	sub    $0x8,%esp
     5b9:	6a 25                	push   $0x25
     5bb:	ff 75 08             	pushl  0x8(%ebp)
     5be:	e8 d1 fd ff ff       	call   394 <putc>
     5c3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c9:	0f be c0             	movsbl %al,%eax
     5cc:	83 ec 08             	sub    $0x8,%esp
     5cf:	50                   	push   %eax
     5d0:	ff 75 08             	pushl  0x8(%ebp)
     5d3:	e8 bc fd ff ff       	call   394 <putc>
     5d8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5e2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5e6:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5ec:	01 d0                	add    %edx,%eax
     5ee:	0f b6 00             	movzbl (%eax),%eax
     5f1:	84 c0                	test   %al,%al
     5f3:	0f 85 94 fe ff ff    	jne    48d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5f9:	90                   	nop
     5fa:	c9                   	leave  
     5fb:	c3                   	ret    

000005fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5fc:	55                   	push   %ebp
     5fd:	89 e5                	mov    %esp,%ebp
     5ff:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     602:	8b 45 08             	mov    0x8(%ebp),%eax
     605:	83 e8 08             	sub    $0x8,%eax
     608:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     60b:	a1 3c 29 00 00       	mov    0x293c,%eax
     610:	89 45 fc             	mov    %eax,-0x4(%ebp)
     613:	eb 24                	jmp    639 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     615:	8b 45 fc             	mov    -0x4(%ebp),%eax
     618:	8b 00                	mov    (%eax),%eax
     61a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     61d:	77 12                	ja     631 <free+0x35>
     61f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     622:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     625:	77 24                	ja     64b <free+0x4f>
     627:	8b 45 fc             	mov    -0x4(%ebp),%eax
     62a:	8b 00                	mov    (%eax),%eax
     62c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     62f:	77 1a                	ja     64b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     631:	8b 45 fc             	mov    -0x4(%ebp),%eax
     634:	8b 00                	mov    (%eax),%eax
     636:	89 45 fc             	mov    %eax,-0x4(%ebp)
     639:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     63f:	76 d4                	jbe    615 <free+0x19>
     641:	8b 45 fc             	mov    -0x4(%ebp),%eax
     644:	8b 00                	mov    (%eax),%eax
     646:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     649:	76 ca                	jbe    615 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     64b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64e:	8b 40 04             	mov    0x4(%eax),%eax
     651:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     658:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65b:	01 c2                	add    %eax,%edx
     65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     660:	8b 00                	mov    (%eax),%eax
     662:	39 c2                	cmp    %eax,%edx
     664:	75 24                	jne    68a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     666:	8b 45 f8             	mov    -0x8(%ebp),%eax
     669:	8b 50 04             	mov    0x4(%eax),%edx
     66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66f:	8b 00                	mov    (%eax),%eax
     671:	8b 40 04             	mov    0x4(%eax),%eax
     674:	01 c2                	add    %eax,%edx
     676:	8b 45 f8             	mov    -0x8(%ebp),%eax
     679:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67f:	8b 00                	mov    (%eax),%eax
     681:	8b 10                	mov    (%eax),%edx
     683:	8b 45 f8             	mov    -0x8(%ebp),%eax
     686:	89 10                	mov    %edx,(%eax)
     688:	eb 0a                	jmp    694 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68d:	8b 10                	mov    (%eax),%edx
     68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     692:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     694:	8b 45 fc             	mov    -0x4(%ebp),%eax
     697:	8b 40 04             	mov    0x4(%eax),%eax
     69a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a4:	01 d0                	add    %edx,%eax
     6a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6a9:	75 20                	jne    6cb <free+0xcf>
    p->s.size += bp->s.size;
     6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ae:	8b 50 04             	mov    0x4(%eax),%edx
     6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b4:	8b 40 04             	mov    0x4(%eax),%eax
     6b7:	01 c2                	add    %eax,%edx
     6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c2:	8b 10                	mov    (%eax),%edx
     6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c7:	89 10                	mov    %edx,(%eax)
     6c9:	eb 08                	jmp    6d3 <free+0xd7>
  } else
    p->s.ptr = bp;
     6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ce:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6d1:	89 10                	mov    %edx,(%eax)
  freep = p;
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	a3 3c 29 00 00       	mov    %eax,0x293c
}
     6db:	90                   	nop
     6dc:	c9                   	leave  
     6dd:	c3                   	ret    

000006de <morecore>:

static Header*
morecore(uint nu)
{
     6de:	55                   	push   %ebp
     6df:	89 e5                	mov    %esp,%ebp
     6e1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6e4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6eb:	77 07                	ja     6f4 <morecore+0x16>
    nu = 4096;
     6ed:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6f4:	8b 45 08             	mov    0x8(%ebp),%eax
     6f7:	c1 e0 03             	shl    $0x3,%eax
     6fa:	83 ec 0c             	sub    $0xc,%esp
     6fd:	50                   	push   %eax
     6fe:	e8 41 fc ff ff       	call   344 <sbrk>
     703:	83 c4 10             	add    $0x10,%esp
     706:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     709:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     70d:	75 07                	jne    716 <morecore+0x38>
    return 0;
     70f:	b8 00 00 00 00       	mov    $0x0,%eax
     714:	eb 26                	jmp    73c <morecore+0x5e>
  hp = (Header*)p;
     716:	8b 45 f4             	mov    -0xc(%ebp),%eax
     719:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     71c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     71f:	8b 55 08             	mov    0x8(%ebp),%edx
     722:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     725:	8b 45 f0             	mov    -0x10(%ebp),%eax
     728:	83 c0 08             	add    $0x8,%eax
     72b:	83 ec 0c             	sub    $0xc,%esp
     72e:	50                   	push   %eax
     72f:	e8 c8 fe ff ff       	call   5fc <free>
     734:	83 c4 10             	add    $0x10,%esp
  return freep;
     737:	a1 3c 29 00 00       	mov    0x293c,%eax
}
     73c:	c9                   	leave  
     73d:	c3                   	ret    

0000073e <malloc>:

void*
malloc(uint nbytes)
{
     73e:	55                   	push   %ebp
     73f:	89 e5                	mov    %esp,%ebp
     741:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     744:	8b 45 08             	mov    0x8(%ebp),%eax
     747:	83 c0 07             	add    $0x7,%eax
     74a:	c1 e8 03             	shr    $0x3,%eax
     74d:	83 c0 01             	add    $0x1,%eax
     750:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     753:	a1 3c 29 00 00       	mov    0x293c,%eax
     758:	89 45 f0             	mov    %eax,-0x10(%ebp)
     75b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75f:	75 23                	jne    784 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     761:	c7 45 f0 34 29 00 00 	movl   $0x2934,-0x10(%ebp)
     768:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76b:	a3 3c 29 00 00       	mov    %eax,0x293c
     770:	a1 3c 29 00 00       	mov    0x293c,%eax
     775:	a3 34 29 00 00       	mov    %eax,0x2934
    base.s.size = 0;
     77a:	c7 05 38 29 00 00 00 	movl   $0x0,0x2938
     781:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     784:	8b 45 f0             	mov    -0x10(%ebp),%eax
     787:	8b 00                	mov    (%eax),%eax
     789:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     78c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78f:	8b 40 04             	mov    0x4(%eax),%eax
     792:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     795:	72 4d                	jb     7e4 <malloc+0xa6>
      if(p->s.size == nunits)
     797:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79a:	8b 40 04             	mov    0x4(%eax),%eax
     79d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7a0:	75 0c                	jne    7ae <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a5:	8b 10                	mov    (%eax),%edx
     7a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7aa:	89 10                	mov    %edx,(%eax)
     7ac:	eb 26                	jmp    7d4 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b1:	8b 40 04             	mov    0x4(%eax),%eax
     7b4:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7b7:	89 c2                	mov    %eax,%edx
     7b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bc:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c2:	8b 40 04             	mov    0x4(%eax),%eax
     7c5:	c1 e0 03             	shl    $0x3,%eax
     7c8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ce:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7d1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d7:	a3 3c 29 00 00       	mov    %eax,0x293c
      return (void*)(p + 1);
     7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7df:	83 c0 08             	add    $0x8,%eax
     7e2:	eb 3b                	jmp    81f <malloc+0xe1>
    }
    if(p == freep)
     7e4:	a1 3c 29 00 00       	mov    0x293c,%eax
     7e9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7ec:	75 1e                	jne    80c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7ee:	83 ec 0c             	sub    $0xc,%esp
     7f1:	ff 75 ec             	pushl  -0x14(%ebp)
     7f4:	e8 e5 fe ff ff       	call   6de <morecore>
     7f9:	83 c4 10             	add    $0x10,%esp
     7fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     803:	75 07                	jne    80c <malloc+0xce>
        return 0;
     805:	b8 00 00 00 00       	mov    $0x0,%eax
     80a:	eb 13                	jmp    81f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     80c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     812:	8b 45 f4             	mov    -0xc(%ebp),%eax
     815:	8b 00                	mov    (%eax),%eax
     817:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     81a:	e9 6d ff ff ff       	jmp    78c <malloc+0x4e>
}
     81f:	c9                   	leave  
     820:	c3                   	ret    

00000821 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     821:	55                   	push   %ebp
     822:	89 e5                	mov    %esp,%ebp
     824:	83 ec 1c             	sub    $0x1c,%esp
     827:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     82a:	8b 55 10             	mov    0x10(%ebp),%edx
     82d:	8b 45 14             	mov    0x14(%ebp),%eax
     830:	88 4d ec             	mov    %cl,-0x14(%ebp)
     833:	88 55 e8             	mov    %dl,-0x18(%ebp)
     836:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     839:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     83d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     840:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     844:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     847:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     84b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     84e:	8b 45 08             	mov    0x8(%ebp),%eax
     851:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     855:	66 89 10             	mov    %dx,(%eax)
     858:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     85c:	88 50 02             	mov    %dl,0x2(%eax)
}
     85f:	8b 45 08             	mov    0x8(%ebp),%eax
     862:	c9                   	leave  
     863:	c2 04 00             	ret    $0x4

00000866 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     866:	55                   	push   %ebp
     867:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     869:	8b 45 08             	mov    0x8(%ebp),%eax
     86c:	2b 45 10             	sub    0x10(%ebp),%eax
     86f:	89 c2                	mov    %eax,%edx
     871:	8b 45 08             	mov    0x8(%ebp),%eax
     874:	2b 45 10             	sub    0x10(%ebp),%eax
     877:	0f af d0             	imul   %eax,%edx
     87a:	8b 45 0c             	mov    0xc(%ebp),%eax
     87d:	2b 45 14             	sub    0x14(%ebp),%eax
     880:	89 c1                	mov    %eax,%ecx
     882:	8b 45 0c             	mov    0xc(%ebp),%eax
     885:	2b 45 14             	sub    0x14(%ebp),%eax
     888:	0f af c1             	imul   %ecx,%eax
     88b:	01 d0                	add    %edx,%eax
}
     88d:	5d                   	pop    %ebp
     88e:	c3                   	ret    

0000088f <abs_int>:

static inline int abs_int(int x)
{
     88f:	55                   	push   %ebp
     890:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     892:	8b 45 08             	mov    0x8(%ebp),%eax
     895:	99                   	cltd   
     896:	89 d0                	mov    %edx,%eax
     898:	33 45 08             	xor    0x8(%ebp),%eax
     89b:	29 d0                	sub    %edx,%eax
}
     89d:	5d                   	pop    %ebp
     89e:	c3                   	ret    

0000089f <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     89f:	55                   	push   %ebp
     8a0:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8a6:	79 07                	jns    8af <APGetIndex+0x10>
        return X_SMALLER;
     8a8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8ad:	eb 40                	jmp    8ef <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8af:	8b 45 08             	mov    0x8(%ebp),%eax
     8b2:	8b 00                	mov    (%eax),%eax
     8b4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8b7:	7f 07                	jg     8c0 <APGetIndex+0x21>
        return X_BIGGER;
     8b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8be:	eb 2f                	jmp    8ef <APGetIndex+0x50>
    if (y < 0)
     8c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8c4:	79 07                	jns    8cd <APGetIndex+0x2e>
        return Y_SMALLER;
     8c6:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8cb:	eb 22                	jmp    8ef <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8cd:	8b 45 08             	mov    0x8(%ebp),%eax
     8d0:	8b 40 04             	mov    0x4(%eax),%eax
     8d3:	3b 45 10             	cmp    0x10(%ebp),%eax
     8d6:	7f 07                	jg     8df <APGetIndex+0x40>
        return Y_BIGGER;
     8d8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8dd:	eb 10                	jmp    8ef <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8df:	8b 45 08             	mov    0x8(%ebp),%eax
     8e2:	8b 00                	mov    (%eax),%eax
     8e4:	0f af 45 10          	imul   0x10(%ebp),%eax
     8e8:	89 c2                	mov    %eax,%edx
     8ea:	8b 45 0c             	mov    0xc(%ebp),%eax
     8ed:	01 d0                	add    %edx,%eax
}
     8ef:	5d                   	pop    %ebp
     8f0:	c3                   	ret    

000008f1 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8f1:	55                   	push   %ebp
     8f2:	89 e5                	mov    %esp,%ebp
     8f4:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8f7:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8fe:	8b 45 cc             	mov    -0x34(%ebp),%eax
     901:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     904:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     90b:	83 ec 08             	sub    $0x8,%esp
     90e:	6a 00                	push   $0x0
     910:	ff 75 0c             	pushl  0xc(%ebp)
     913:	e8 e4 f9 ff ff       	call   2fc <open>
     918:	83 c4 10             	add    $0x10,%esp
     91b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     91e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     922:	79 2e                	jns    952 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     924:	83 ec 04             	sub    $0x4,%esp
     927:	ff 75 0c             	pushl  0xc(%ebp)
     92a:	68 3c 22 00 00       	push   $0x223c
     92f:	6a 01                	push   $0x1
     931:	e8 35 fb ff ff       	call   46b <printf>
     936:	83 c4 10             	add    $0x10,%esp
        return bmp;
     939:	8b 45 08             	mov    0x8(%ebp),%eax
     93c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     93f:	89 10                	mov    %edx,(%eax)
     941:	8b 55 cc             	mov    -0x34(%ebp),%edx
     944:	89 50 04             	mov    %edx,0x4(%eax)
     947:	8b 55 d0             	mov    -0x30(%ebp),%edx
     94a:	89 50 08             	mov    %edx,0x8(%eax)
     94d:	e9 d2 01 00 00       	jmp    b24 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     952:	83 ec 04             	sub    $0x4,%esp
     955:	6a 0e                	push   $0xe
     957:	8d 45 ba             	lea    -0x46(%ebp),%eax
     95a:	50                   	push   %eax
     95b:	ff 75 ec             	pushl  -0x14(%ebp)
     95e:	e8 71 f9 ff ff       	call   2d4 <read>
     963:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     966:	83 ec 04             	sub    $0x4,%esp
     969:	6a 28                	push   $0x28
     96b:	8d 45 92             	lea    -0x6e(%ebp),%eax
     96e:	50                   	push   %eax
     96f:	ff 75 ec             	pushl  -0x14(%ebp)
     972:	e8 5d f9 ff ff       	call   2d4 <read>
     977:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     97a:	8b 45 96             	mov    -0x6a(%ebp),%eax
     97d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     980:	8b 45 9a             	mov    -0x66(%ebp),%eax
     983:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     986:	8b 55 c8             	mov    -0x38(%ebp),%edx
     989:	8b 45 cc             	mov    -0x34(%ebp),%eax
     98c:	0f af d0             	imul   %eax,%edx
     98f:	89 d0                	mov    %edx,%eax
     991:	01 c0                	add    %eax,%eax
     993:	01 d0                	add    %edx,%eax
     995:	83 ec 0c             	sub    $0xc,%esp
     998:	50                   	push   %eax
     999:	e8 a0 fd ff ff       	call   73e <malloc>
     99e:	83 c4 10             	add    $0x10,%esp
     9a1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9a4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9a8:	0f b7 c0             	movzwl %ax,%eax
     9ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9ae:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9b4:	0f af c2             	imul   %edx,%eax
     9b7:	83 c0 1f             	add    $0x1f,%eax
     9ba:	c1 e8 05             	shr    $0x5,%eax
     9bd:	c1 e0 02             	shl    $0x2,%eax
     9c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9c3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9c9:	0f af c2             	imul   %edx,%eax
     9cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9d2:	83 ec 0c             	sub    $0xc,%esp
     9d5:	50                   	push   %eax
     9d6:	e8 63 fd ff ff       	call   73e <malloc>
     9db:	83 c4 10             	add    $0x10,%esp
     9de:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9e1:	83 ec 04             	sub    $0x4,%esp
     9e4:	ff 75 e0             	pushl  -0x20(%ebp)
     9e7:	ff 75 dc             	pushl  -0x24(%ebp)
     9ea:	ff 75 ec             	pushl  -0x14(%ebp)
     9ed:	e8 e2 f8 ff ff       	call   2d4 <read>
     9f2:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9f5:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9f9:	66 c1 e8 03          	shr    $0x3,%ax
     9fd:	0f b7 c0             	movzwl %ax,%eax
     a00:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a03:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a0a:	e9 e5 00 00 00       	jmp    af4 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a0f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a15:	29 c2                	sub    %eax,%edx
     a17:	89 d0                	mov    %edx,%eax
     a19:	8d 50 ff             	lea    -0x1(%eax),%edx
     a1c:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a1f:	0f af c2             	imul   %edx,%eax
     a22:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a25:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a2c:	e9 b1 00 00 00       	jmp    ae2 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a31:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a34:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3a:	01 c8                	add    %ecx,%eax
     a3c:	89 c1                	mov    %eax,%ecx
     a3e:	89 c8                	mov    %ecx,%eax
     a40:	01 c0                	add    %eax,%eax
     a42:	01 c8                	add    %ecx,%eax
     a44:	01 c2                	add    %eax,%edx
     a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a49:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a4d:	89 c1                	mov    %eax,%ecx
     a4f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a52:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a56:	01 c1                	add    %eax,%ecx
     a58:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a5b:	01 c8                	add    %ecx,%eax
     a5d:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a60:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a63:	01 c8                	add    %ecx,%eax
     a65:	0f b6 00             	movzbl (%eax),%eax
     a68:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a6b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a6e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a74:	01 c8                	add    %ecx,%eax
     a76:	89 c1                	mov    %eax,%ecx
     a78:	89 c8                	mov    %ecx,%eax
     a7a:	01 c0                	add    %eax,%eax
     a7c:	01 c8                	add    %ecx,%eax
     a7e:	01 c2                	add    %eax,%edx
     a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a83:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a87:	89 c1                	mov    %eax,%ecx
     a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a8c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a90:	01 c1                	add    %eax,%ecx
     a92:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a95:	01 c8                	add    %ecx,%eax
     a97:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a9d:	01 c8                	add    %ecx,%eax
     a9f:	0f b6 00             	movzbl (%eax),%eax
     aa2:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     aa5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aa8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aae:	01 c8                	add    %ecx,%eax
     ab0:	89 c1                	mov    %eax,%ecx
     ab2:	89 c8                	mov    %ecx,%eax
     ab4:	01 c0                	add    %eax,%eax
     ab6:	01 c8                	add    %ecx,%eax
     ab8:	01 c2                	add    %eax,%edx
     aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abd:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ac1:	89 c1                	mov    %eax,%ecx
     ac3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ac6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aca:	01 c1                	add    %eax,%ecx
     acc:	8b 45 d8             	mov    -0x28(%ebp),%eax
     acf:	01 c8                	add    %ecx,%eax
     ad1:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ad4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ad7:	01 c8                	add    %ecx,%eax
     ad9:	0f b6 00             	movzbl (%eax),%eax
     adc:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ade:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ae2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ae5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae8:	39 c2                	cmp    %eax,%edx
     aea:	0f 87 41 ff ff ff    	ja     a31 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     af0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     af4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afa:	39 c2                	cmp    %eax,%edx
     afc:	0f 87 0d ff ff ff    	ja     a0f <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b02:	83 ec 0c             	sub    $0xc,%esp
     b05:	ff 75 ec             	pushl  -0x14(%ebp)
     b08:	e8 d7 f7 ff ff       	call   2e4 <close>
     b0d:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b10:	8b 45 08             	mov    0x8(%ebp),%eax
     b13:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b16:	89 10                	mov    %edx,(%eax)
     b18:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b1b:	89 50 04             	mov    %edx,0x4(%eax)
     b1e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b21:	89 50 08             	mov    %edx,0x8(%eax)
}
     b24:	8b 45 08             	mov    0x8(%ebp),%eax
     b27:	c9                   	leave  
     b28:	c2 04 00             	ret    $0x4

00000b2b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b2b:	55                   	push   %ebp
     b2c:	89 e5                	mov    %esp,%ebp
     b2e:	53                   	push   %ebx
     b2f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b32:	83 ec 0c             	sub    $0xc,%esp
     b35:	6a 1c                	push   $0x1c
     b37:	e8 02 fc ff ff       	call   73e <malloc>
     b3c:	83 c4 10             	add    $0x10,%esp
     b3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b45:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b4c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b4f:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b52:	6a 0c                	push   $0xc
     b54:	6a 0c                	push   $0xc
     b56:	6a 0c                	push   $0xc
     b58:	50                   	push   %eax
     b59:	e8 c3 fc ff ff       	call   821 <RGB>
     b5e:	83 c4 0c             	add    $0xc,%esp
     b61:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b65:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b69:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b6d:	88 43 15             	mov    %al,0x15(%ebx)
     b70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b73:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b76:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b7a:	66 89 48 10          	mov    %cx,0x10(%eax)
     b7e:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b82:	88 50 12             	mov    %dl,0x12(%eax)
     b85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b88:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b8b:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b8f:	66 89 48 08          	mov    %cx,0x8(%eax)
     b93:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b97:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b9a:	8b 45 08             	mov    0x8(%ebp),%eax
     b9d:	89 c2                	mov    %eax,%edx
     b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ba4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba7:	89 c2                	mov    %eax,%edx
     ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bac:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     baf:	8b 55 10             	mov    0x10(%ebp),%edx
     bb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bbb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bbe:	c9                   	leave  
     bbf:	c3                   	ret    

00000bc0 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc9:	8b 50 08             	mov    0x8(%eax),%edx
     bcc:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bcf:	8b 40 0c             	mov    0xc(%eax),%eax
     bd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bd5:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd8:	8b 55 10             	mov    0x10(%ebp),%edx
     bdb:	89 50 08             	mov    %edx,0x8(%eax)
     bde:	8b 55 14             	mov    0x14(%ebp),%edx
     be1:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     be4:	8b 45 08             	mov    0x8(%ebp),%eax
     be7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bea:	89 10                	mov    %edx,(%eax)
     bec:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bef:	89 50 04             	mov    %edx,0x4(%eax)
}
     bf2:	8b 45 08             	mov    0x8(%ebp),%eax
     bf5:	c9                   	leave  
     bf6:	c2 04 00             	ret    $0x4

00000bf9 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     bf9:	55                   	push   %ebp
     bfa:	89 e5                	mov    %esp,%ebp
     bfc:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bff:	8b 45 0c             	mov    0xc(%ebp),%eax
     c02:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c06:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c0a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c0e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c11:	8b 45 0c             	mov    0xc(%ebp),%eax
     c14:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c18:	66 89 50 10          	mov    %dx,0x10(%eax)
     c1c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c20:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c23:	8b 45 08             	mov    0x8(%ebp),%eax
     c26:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c2a:	66 89 10             	mov    %dx,(%eax)
     c2d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c31:	88 50 02             	mov    %dl,0x2(%eax)
}
     c34:	8b 45 08             	mov    0x8(%ebp),%eax
     c37:	c9                   	leave  
     c38:	c2 04 00             	ret    $0x4

00000c3b <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c3b:	55                   	push   %ebp
     c3c:	89 e5                	mov    %esp,%ebp
     c3e:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c41:	8b 45 08             	mov    0x8(%ebp),%eax
     c44:	8b 40 0c             	mov    0xc(%eax),%eax
     c47:	89 c2                	mov    %eax,%edx
     c49:	c1 ea 1f             	shr    $0x1f,%edx
     c4c:	01 d0                	add    %edx,%eax
     c4e:	d1 f8                	sar    %eax
     c50:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c56:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c5d:	8b 45 10             	mov    0x10(%ebp),%eax
     c60:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c63:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c66:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c6a:	0f 89 98 00 00 00    	jns    d08 <APDrawPoint+0xcd>
        i = 0;
     c70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c77:	e9 8c 00 00 00       	jmp    d08 <APDrawPoint+0xcd>
    {
        j = x - off;
     c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c82:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c85:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c89:	79 69                	jns    cf4 <APDrawPoint+0xb9>
            j = 0;
     c8b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c92:	eb 60                	jmp    cf4 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c94:	ff 75 fc             	pushl  -0x4(%ebp)
     c97:	ff 75 f8             	pushl  -0x8(%ebp)
     c9a:	ff 75 08             	pushl  0x8(%ebp)
     c9d:	e8 fd fb ff ff       	call   89f <APGetIndex>
     ca2:	83 c4 0c             	add    $0xc,%esp
     ca5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ca8:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cac:	74 55                	je     d03 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cae:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cb2:	74 67                	je     d1b <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cb4:	ff 75 10             	pushl  0x10(%ebp)
     cb7:	ff 75 0c             	pushl  0xc(%ebp)
     cba:	ff 75 fc             	pushl  -0x4(%ebp)
     cbd:	ff 75 f8             	pushl  -0x8(%ebp)
     cc0:	e8 a1 fb ff ff       	call   866 <distance_2>
     cc5:	83 c4 10             	add    $0x10,%esp
     cc8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     ccb:	7f 23                	jg     cf0 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ccd:	8b 45 08             	mov    0x8(%ebp),%eax
     cd0:	8b 48 18             	mov    0x18(%eax),%ecx
     cd3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cd6:	89 d0                	mov    %edx,%eax
     cd8:	01 c0                	add    %eax,%eax
     cda:	01 d0                	add    %edx,%eax
     cdc:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     cdf:	8b 45 08             	mov    0x8(%ebp),%eax
     ce2:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ce6:	66 89 0a             	mov    %cx,(%edx)
     ce9:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     ced:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     cf0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     cf4:	8b 55 0c             	mov    0xc(%ebp),%edx
     cf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cfa:	01 d0                	add    %edx,%eax
     cfc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cff:	7d 93                	jge    c94 <APDrawPoint+0x59>
     d01:	eb 01                	jmp    d04 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d03:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d04:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d08:	8b 55 10             	mov    0x10(%ebp),%edx
     d0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0e:	01 d0                	add    %edx,%eax
     d10:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d13:	0f 8d 63 ff ff ff    	jge    c7c <APDrawPoint+0x41>
     d19:	eb 01                	jmp    d1c <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d1b:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d1c:	c9                   	leave  
     d1d:	c3                   	ret    

00000d1e <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d1e:	55                   	push   %ebp
     d1f:	89 e5                	mov    %esp,%ebp
     d21:	53                   	push   %ebx
     d22:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d25:	8b 45 0c             	mov    0xc(%ebp),%eax
     d28:	3b 45 14             	cmp    0x14(%ebp),%eax
     d2b:	0f 85 80 00 00 00    	jne    db1 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d31:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d35:	0f 88 9d 02 00 00    	js     fd8 <APDrawLine+0x2ba>
     d3b:	8b 45 08             	mov    0x8(%ebp),%eax
     d3e:	8b 00                	mov    (%eax),%eax
     d40:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d43:	0f 8e 8f 02 00 00    	jle    fd8 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d49:	8b 45 10             	mov    0x10(%ebp),%eax
     d4c:	3b 45 18             	cmp    0x18(%ebp),%eax
     d4f:	7e 12                	jle    d63 <APDrawLine+0x45>
        {
            int tmp = y2;
     d51:	8b 45 18             	mov    0x18(%ebp),%eax
     d54:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d57:	8b 45 10             	mov    0x10(%ebp),%eax
     d5a:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d5d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d60:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d67:	79 07                	jns    d70 <APDrawLine+0x52>
     d69:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d70:	8b 45 08             	mov    0x8(%ebp),%eax
     d73:	8b 40 04             	mov    0x4(%eax),%eax
     d76:	3b 45 18             	cmp    0x18(%ebp),%eax
     d79:	7d 0c                	jge    d87 <APDrawLine+0x69>
     d7b:	8b 45 08             	mov    0x8(%ebp),%eax
     d7e:	8b 40 04             	mov    0x4(%eax),%eax
     d81:	83 e8 01             	sub    $0x1,%eax
     d84:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d87:	8b 45 10             	mov    0x10(%ebp),%eax
     d8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d8d:	eb 15                	jmp    da4 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d8f:	ff 75 f4             	pushl  -0xc(%ebp)
     d92:	ff 75 0c             	pushl  0xc(%ebp)
     d95:	ff 75 08             	pushl  0x8(%ebp)
     d98:	e8 9e fe ff ff       	call   c3b <APDrawPoint>
     d9d:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     da0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     da4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da7:	3b 45 18             	cmp    0x18(%ebp),%eax
     daa:	7e e3                	jle    d8f <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dac:	e9 2b 02 00 00       	jmp    fdc <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     db1:	8b 45 10             	mov    0x10(%ebp),%eax
     db4:	3b 45 18             	cmp    0x18(%ebp),%eax
     db7:	75 7f                	jne    e38 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     db9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dbd:	0f 88 18 02 00 00    	js     fdb <APDrawLine+0x2bd>
     dc3:	8b 45 08             	mov    0x8(%ebp),%eax
     dc6:	8b 40 04             	mov    0x4(%eax),%eax
     dc9:	3b 45 10             	cmp    0x10(%ebp),%eax
     dcc:	0f 8e 09 02 00 00    	jle    fdb <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dd2:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd5:	3b 45 14             	cmp    0x14(%ebp),%eax
     dd8:	7e 12                	jle    dec <APDrawLine+0xce>
        {
            int tmp = x2;
     dda:	8b 45 14             	mov    0x14(%ebp),%eax
     ddd:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     de0:	8b 45 0c             	mov    0xc(%ebp),%eax
     de3:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     de6:	8b 45 d8             	mov    -0x28(%ebp),%eax
     de9:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     dec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     df0:	79 07                	jns    df9 <APDrawLine+0xdb>
     df2:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     df9:	8b 45 08             	mov    0x8(%ebp),%eax
     dfc:	8b 00                	mov    (%eax),%eax
     dfe:	3b 45 14             	cmp    0x14(%ebp),%eax
     e01:	7d 0b                	jge    e0e <APDrawLine+0xf0>
     e03:	8b 45 08             	mov    0x8(%ebp),%eax
     e06:	8b 00                	mov    (%eax),%eax
     e08:	83 e8 01             	sub    $0x1,%eax
     e0b:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e0e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e11:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e14:	eb 15                	jmp    e2b <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e16:	ff 75 10             	pushl  0x10(%ebp)
     e19:	ff 75 f0             	pushl  -0x10(%ebp)
     e1c:	ff 75 08             	pushl  0x8(%ebp)
     e1f:	e8 17 fe ff ff       	call   c3b <APDrawPoint>
     e24:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e27:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2e:	3b 45 14             	cmp    0x14(%ebp),%eax
     e31:	7e e3                	jle    e16 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e33:	e9 a4 01 00 00       	jmp    fdc <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e38:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e3f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e46:	8b 45 0c             	mov    0xc(%ebp),%eax
     e49:	2b 45 14             	sub    0x14(%ebp),%eax
     e4c:	50                   	push   %eax
     e4d:	e8 3d fa ff ff       	call   88f <abs_int>
     e52:	83 c4 04             	add    $0x4,%esp
     e55:	89 c3                	mov    %eax,%ebx
     e57:	8b 45 10             	mov    0x10(%ebp),%eax
     e5a:	2b 45 18             	sub    0x18(%ebp),%eax
     e5d:	50                   	push   %eax
     e5e:	e8 2c fa ff ff       	call   88f <abs_int>
     e63:	83 c4 04             	add    $0x4,%esp
     e66:	39 c3                	cmp    %eax,%ebx
     e68:	0f 8e b5 00 00 00    	jle    f23 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e6e:	8b 45 10             	mov    0x10(%ebp),%eax
     e71:	2b 45 18             	sub    0x18(%ebp),%eax
     e74:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e77:	db 45 b0             	fildl  -0x50(%ebp)
     e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7d:	2b 45 14             	sub    0x14(%ebp),%eax
     e80:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e83:	db 45 b0             	fildl  -0x50(%ebp)
     e86:	de f9                	fdivrp %st,%st(1)
     e88:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e8b:	8b 45 14             	mov    0x14(%ebp),%eax
     e8e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e91:	7e 0e                	jle    ea1 <APDrawLine+0x183>
        {
            s = x1;
     e93:	8b 45 0c             	mov    0xc(%ebp),%eax
     e96:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e99:	8b 45 14             	mov    0x14(%ebp),%eax
     e9c:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e9f:	eb 0c                	jmp    ead <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ea1:	8b 45 14             	mov    0x14(%ebp),%eax
     ea4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eaa:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     ead:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eb1:	79 07                	jns    eba <APDrawLine+0x19c>
     eb3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     eba:	8b 45 08             	mov    0x8(%ebp),%eax
     ebd:	8b 00                	mov    (%eax),%eax
     ebf:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ec2:	7f 0b                	jg     ecf <APDrawLine+0x1b1>
     ec4:	8b 45 08             	mov    0x8(%ebp),%eax
     ec7:	8b 00                	mov    (%eax),%eax
     ec9:	83 e8 01             	sub    $0x1,%eax
     ecc:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ecf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ed5:	eb 3f                	jmp    f16 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ed7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     eda:	2b 45 0c             	sub    0xc(%ebp),%eax
     edd:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ee0:	db 45 b0             	fildl  -0x50(%ebp)
     ee3:	dc 4d d0             	fmull  -0x30(%ebp)
     ee6:	db 45 10             	fildl  0x10(%ebp)
     ee9:	de c1                	faddp  %st,%st(1)
     eeb:	d9 7d b6             	fnstcw -0x4a(%ebp)
     eee:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ef2:	b4 0c                	mov    $0xc,%ah
     ef4:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ef8:	d9 6d b4             	fldcw  -0x4c(%ebp)
     efb:	db 5d cc             	fistpl -0x34(%ebp)
     efe:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f01:	ff 75 cc             	pushl  -0x34(%ebp)
     f04:	ff 75 e4             	pushl  -0x1c(%ebp)
     f07:	ff 75 08             	pushl  0x8(%ebp)
     f0a:	e8 2c fd ff ff       	call   c3b <APDrawPoint>
     f0f:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f12:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f19:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f1c:	7e b9                	jle    ed7 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f1e:	e9 b9 00 00 00       	jmp    fdc <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f23:	8b 45 0c             	mov    0xc(%ebp),%eax
     f26:	2b 45 14             	sub    0x14(%ebp),%eax
     f29:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f2c:	db 45 b0             	fildl  -0x50(%ebp)
     f2f:	8b 45 10             	mov    0x10(%ebp),%eax
     f32:	2b 45 18             	sub    0x18(%ebp),%eax
     f35:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f38:	db 45 b0             	fildl  -0x50(%ebp)
     f3b:	de f9                	fdivrp %st,%st(1)
     f3d:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f40:	8b 45 10             	mov    0x10(%ebp),%eax
     f43:	3b 45 18             	cmp    0x18(%ebp),%eax
     f46:	7e 0e                	jle    f56 <APDrawLine+0x238>
    {
        s = y2;
     f48:	8b 45 18             	mov    0x18(%ebp),%eax
     f4b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f4e:	8b 45 10             	mov    0x10(%ebp),%eax
     f51:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f54:	eb 0c                	jmp    f62 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f56:	8b 45 10             	mov    0x10(%ebp),%eax
     f59:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f5c:	8b 45 18             	mov    0x18(%ebp),%eax
     f5f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f62:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f66:	79 07                	jns    f6f <APDrawLine+0x251>
     f68:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f6f:	8b 45 08             	mov    0x8(%ebp),%eax
     f72:	8b 40 04             	mov    0x4(%eax),%eax
     f75:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f78:	7f 0c                	jg     f86 <APDrawLine+0x268>
     f7a:	8b 45 08             	mov    0x8(%ebp),%eax
     f7d:	8b 40 04             	mov    0x4(%eax),%eax
     f80:	83 e8 01             	sub    $0x1,%eax
     f83:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f86:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f89:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f8c:	eb 3f                	jmp    fcd <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f91:	2b 45 10             	sub    0x10(%ebp),%eax
     f94:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f97:	db 45 b0             	fildl  -0x50(%ebp)
     f9a:	dc 4d c0             	fmull  -0x40(%ebp)
     f9d:	db 45 0c             	fildl  0xc(%ebp)
     fa0:	de c1                	faddp  %st,%st(1)
     fa2:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fa5:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fa9:	b4 0c                	mov    $0xc,%ah
     fab:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     faf:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fb2:	db 5d bc             	fistpl -0x44(%ebp)
     fb5:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fb8:	ff 75 e0             	pushl  -0x20(%ebp)
     fbb:	ff 75 bc             	pushl  -0x44(%ebp)
     fbe:	ff 75 08             	pushl  0x8(%ebp)
     fc1:	e8 75 fc ff ff       	call   c3b <APDrawPoint>
     fc6:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fc9:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fd0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fd3:	7e b9                	jle    f8e <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fd5:	90                   	nop
     fd6:	eb 04                	jmp    fdc <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fd8:	90                   	nop
     fd9:	eb 01                	jmp    fdc <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fdb:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fdc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fdf:	c9                   	leave  
     fe0:	c3                   	ret    

00000fe1 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fe1:	55                   	push   %ebp
     fe2:	89 e5                	mov    %esp,%ebp
     fe4:	53                   	push   %ebx
     fe5:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fe8:	8b 55 10             	mov    0x10(%ebp),%edx
     feb:	8b 45 18             	mov    0x18(%ebp),%eax
     fee:	01 d0                	add    %edx,%eax
     ff0:	83 e8 01             	sub    $0x1,%eax
     ff3:	83 ec 04             	sub    $0x4,%esp
     ff6:	50                   	push   %eax
     ff7:	ff 75 0c             	pushl  0xc(%ebp)
     ffa:	ff 75 10             	pushl  0x10(%ebp)
     ffd:	ff 75 0c             	pushl  0xc(%ebp)
    1000:	ff 75 08             	pushl  0x8(%ebp)
    1003:	e8 16 fd ff ff       	call   d1e <APDrawLine>
    1008:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    100b:	8b 55 0c             	mov    0xc(%ebp),%edx
    100e:	8b 45 14             	mov    0x14(%ebp),%eax
    1011:	01 d0                	add    %edx,%eax
    1013:	83 e8 01             	sub    $0x1,%eax
    1016:	83 ec 04             	sub    $0x4,%esp
    1019:	ff 75 10             	pushl  0x10(%ebp)
    101c:	50                   	push   %eax
    101d:	ff 75 10             	pushl  0x10(%ebp)
    1020:	ff 75 0c             	pushl  0xc(%ebp)
    1023:	ff 75 08             	pushl  0x8(%ebp)
    1026:	e8 f3 fc ff ff       	call   d1e <APDrawLine>
    102b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    102e:	8b 55 10             	mov    0x10(%ebp),%edx
    1031:	8b 45 18             	mov    0x18(%ebp),%eax
    1034:	01 d0                	add    %edx,%eax
    1036:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1039:	8b 55 0c             	mov    0xc(%ebp),%edx
    103c:	8b 45 14             	mov    0x14(%ebp),%eax
    103f:	01 d0                	add    %edx,%eax
    1041:	8d 50 ff             	lea    -0x1(%eax),%edx
    1044:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1047:	8b 45 14             	mov    0x14(%ebp),%eax
    104a:	01 d8                	add    %ebx,%eax
    104c:	83 e8 01             	sub    $0x1,%eax
    104f:	83 ec 04             	sub    $0x4,%esp
    1052:	51                   	push   %ecx
    1053:	52                   	push   %edx
    1054:	ff 75 10             	pushl  0x10(%ebp)
    1057:	50                   	push   %eax
    1058:	ff 75 08             	pushl  0x8(%ebp)
    105b:	e8 be fc ff ff       	call   d1e <APDrawLine>
    1060:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1063:	8b 55 10             	mov    0x10(%ebp),%edx
    1066:	8b 45 18             	mov    0x18(%ebp),%eax
    1069:	01 d0                	add    %edx,%eax
    106b:	8d 48 ff             	lea    -0x1(%eax),%ecx
    106e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1071:	8b 45 14             	mov    0x14(%ebp),%eax
    1074:	01 d0                	add    %edx,%eax
    1076:	8d 50 ff             	lea    -0x1(%eax),%edx
    1079:	8b 5d 10             	mov    0x10(%ebp),%ebx
    107c:	8b 45 18             	mov    0x18(%ebp),%eax
    107f:	01 d8                	add    %ebx,%eax
    1081:	83 e8 01             	sub    $0x1,%eax
    1084:	83 ec 04             	sub    $0x4,%esp
    1087:	51                   	push   %ecx
    1088:	52                   	push   %edx
    1089:	50                   	push   %eax
    108a:	ff 75 0c             	pushl  0xc(%ebp)
    108d:	ff 75 08             	pushl  0x8(%ebp)
    1090:	e8 89 fc ff ff       	call   d1e <APDrawLine>
    1095:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1098:	8b 55 0c             	mov    0xc(%ebp),%edx
    109b:	8b 45 14             	mov    0x14(%ebp),%eax
    109e:	01 d0                	add    %edx,%eax
    10a0:	8d 50 ff             	lea    -0x1(%eax),%edx
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	8b 40 0c             	mov    0xc(%eax),%eax
    10a9:	89 c1                	mov    %eax,%ecx
    10ab:	c1 e9 1f             	shr    $0x1f,%ecx
    10ae:	01 c8                	add    %ecx,%eax
    10b0:	d1 f8                	sar    %eax
    10b2:	29 c2                	sub    %eax,%edx
    10b4:	89 d0                	mov    %edx,%eax
    10b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10b9:	8b 55 10             	mov    0x10(%ebp),%edx
    10bc:	8b 45 18             	mov    0x18(%ebp),%eax
    10bf:	01 d0                	add    %edx,%eax
    10c1:	8d 50 ff             	lea    -0x1(%eax),%edx
    10c4:	8b 45 08             	mov    0x8(%ebp),%eax
    10c7:	8b 40 0c             	mov    0xc(%eax),%eax
    10ca:	89 c1                	mov    %eax,%ecx
    10cc:	c1 e9 1f             	shr    $0x1f,%ecx
    10cf:	01 c8                	add    %ecx,%eax
    10d1:	d1 f8                	sar    %eax
    10d3:	29 c2                	sub    %eax,%edx
    10d5:	89 d0                	mov    %edx,%eax
    10d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10da:	8b 45 08             	mov    0x8(%ebp),%eax
    10dd:	8b 40 0c             	mov    0xc(%eax),%eax
    10e0:	89 c2                	mov    %eax,%edx
    10e2:	c1 ea 1f             	shr    $0x1f,%edx
    10e5:	01 d0                	add    %edx,%eax
    10e7:	d1 f8                	sar    %eax
    10e9:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10ec:	8b 45 08             	mov    0x8(%ebp),%eax
    10ef:	8b 40 0c             	mov    0xc(%eax),%eax
    10f2:	89 c2                	mov    %eax,%edx
    10f4:	c1 ea 1f             	shr    $0x1f,%edx
    10f7:	01 d0                	add    %edx,%eax
    10f9:	d1 f8                	sar    %eax
    10fb:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1102:	0f 88 d8 00 00 00    	js     11e0 <APDrawRect+0x1ff>
    1108:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    110c:	0f 88 ce 00 00 00    	js     11e0 <APDrawRect+0x1ff>
    1112:	8b 45 08             	mov    0x8(%ebp),%eax
    1115:	8b 00                	mov    (%eax),%eax
    1117:	3b 45 0c             	cmp    0xc(%ebp),%eax
    111a:	0f 8e c0 00 00 00    	jle    11e0 <APDrawRect+0x1ff>
    1120:	8b 45 08             	mov    0x8(%ebp),%eax
    1123:	8b 40 04             	mov    0x4(%eax),%eax
    1126:	3b 45 10             	cmp    0x10(%ebp),%eax
    1129:	0f 8e b1 00 00 00    	jle    11e0 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    112f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1133:	79 07                	jns    113c <APDrawRect+0x15b>
    1135:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    113c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1140:	79 07                	jns    1149 <APDrawRect+0x168>
    1142:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1149:	8b 45 08             	mov    0x8(%ebp),%eax
    114c:	8b 00                	mov    (%eax),%eax
    114e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1151:	7f 0b                	jg     115e <APDrawRect+0x17d>
    1153:	8b 45 08             	mov    0x8(%ebp),%eax
    1156:	8b 00                	mov    (%eax),%eax
    1158:	83 e8 01             	sub    $0x1,%eax
    115b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    115e:	8b 45 08             	mov    0x8(%ebp),%eax
    1161:	8b 40 04             	mov    0x4(%eax),%eax
    1164:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1167:	7f 0c                	jg     1175 <APDrawRect+0x194>
    1169:	8b 45 08             	mov    0x8(%ebp),%eax
    116c:	8b 40 04             	mov    0x4(%eax),%eax
    116f:	83 e8 01             	sub    $0x1,%eax
    1172:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1175:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    117c:	8b 45 0c             	mov    0xc(%ebp),%eax
    117f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1182:	eb 52                	jmp    11d6 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1184:	8b 45 10             	mov    0x10(%ebp),%eax
    1187:	89 45 e8             	mov    %eax,-0x18(%ebp)
    118a:	eb 3e                	jmp    11ca <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    118c:	83 ec 04             	sub    $0x4,%esp
    118f:	ff 75 e8             	pushl  -0x18(%ebp)
    1192:	ff 75 ec             	pushl  -0x14(%ebp)
    1195:	ff 75 08             	pushl  0x8(%ebp)
    1198:	e8 02 f7 ff ff       	call   89f <APGetIndex>
    119d:	83 c4 10             	add    $0x10,%esp
    11a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11a3:	8b 45 08             	mov    0x8(%ebp),%eax
    11a6:	8b 48 18             	mov    0x18(%eax),%ecx
    11a9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11ac:	89 d0                	mov    %edx,%eax
    11ae:	01 c0                	add    %eax,%eax
    11b0:	01 d0                	add    %edx,%eax
    11b2:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11b5:	8b 45 08             	mov    0x8(%ebp),%eax
    11b8:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11bc:	66 89 0a             	mov    %cx,(%edx)
    11bf:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11c3:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11c6:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11d0:	7e ba                	jle    118c <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11d2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11dc:	7e a6                	jle    1184 <APDrawRect+0x1a3>
    11de:	eb 01                	jmp    11e1 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11e0:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11e4:	c9                   	leave  
    11e5:	c3                   	ret    

000011e6 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11e6:	55                   	push   %ebp
    11e7:	89 e5                	mov    %esp,%ebp
}
    11e9:	90                   	nop
    11ea:	5d                   	pop    %ebp
    11eb:	c3                   	ret    

000011ec <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11ec:	55                   	push   %ebp
    11ed:	89 e5                	mov    %esp,%ebp
    11ef:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11f2:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11f6:	0f 88 8e 01 00 00    	js     138a <APDcCopy+0x19e>
    11fc:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1200:	0f 88 84 01 00 00    	js     138a <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1206:	8b 55 0c             	mov    0xc(%ebp),%edx
    1209:	8b 45 20             	mov    0x20(%ebp),%eax
    120c:	01 d0                	add    %edx,%eax
    120e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1211:	8b 55 10             	mov    0x10(%ebp),%edx
    1214:	8b 45 24             	mov    0x24(%ebp),%eax
    1217:	01 d0                	add    %edx,%eax
    1219:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    121c:	8b 55 18             	mov    0x18(%ebp),%edx
    121f:	8b 45 20             	mov    0x20(%ebp),%eax
    1222:	01 d0                	add    %edx,%eax
    1224:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1227:	8b 55 1c             	mov    0x1c(%ebp),%edx
    122a:	8b 45 24             	mov    0x24(%ebp),%eax
    122d:	01 d0                	add    %edx,%eax
    122f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1232:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1236:	0f 88 51 01 00 00    	js     138d <APDcCopy+0x1a1>
    123c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1240:	0f 88 47 01 00 00    	js     138d <APDcCopy+0x1a1>
    1246:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    124a:	0f 88 3d 01 00 00    	js     138d <APDcCopy+0x1a1>
    1250:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1254:	0f 88 33 01 00 00    	js     138d <APDcCopy+0x1a1>
    125a:	8b 45 14             	mov    0x14(%ebp),%eax
    125d:	8b 00                	mov    (%eax),%eax
    125f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1262:	0f 8c 25 01 00 00    	jl     138d <APDcCopy+0x1a1>
    1268:	8b 45 14             	mov    0x14(%ebp),%eax
    126b:	8b 40 04             	mov    0x4(%eax),%eax
    126e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1271:	0f 8c 16 01 00 00    	jl     138d <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1277:	8b 45 08             	mov    0x8(%ebp),%eax
    127a:	8b 00                	mov    (%eax),%eax
    127c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    127f:	7f 0b                	jg     128c <APDcCopy+0xa0>
    1281:	8b 45 08             	mov    0x8(%ebp),%eax
    1284:	8b 00                	mov    (%eax),%eax
    1286:	83 e8 01             	sub    $0x1,%eax
    1289:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    128c:	8b 45 08             	mov    0x8(%ebp),%eax
    128f:	8b 40 04             	mov    0x4(%eax),%eax
    1292:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1295:	7f 0c                	jg     12a3 <APDcCopy+0xb7>
    1297:	8b 45 08             	mov    0x8(%ebp),%eax
    129a:	8b 40 04             	mov    0x4(%eax),%eax
    129d:	83 e8 01             	sub    $0x1,%eax
    12a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12aa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12b8:	e9 bc 00 00 00       	jmp    1379 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12bd:	8b 45 08             	mov    0x8(%ebp),%eax
    12c0:	8b 00                	mov    (%eax),%eax
    12c2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12c5:	8b 55 10             	mov    0x10(%ebp),%edx
    12c8:	01 ca                	add    %ecx,%edx
    12ca:	0f af d0             	imul   %eax,%edx
    12cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d0:	01 d0                	add    %edx,%eax
    12d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12d5:	8b 45 14             	mov    0x14(%ebp),%eax
    12d8:	8b 00                	mov    (%eax),%eax
    12da:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12dd:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12e0:	01 ca                	add    %ecx,%edx
    12e2:	0f af d0             	imul   %eax,%edx
    12e5:	8b 45 18             	mov    0x18(%ebp),%eax
    12e8:	01 d0                	add    %edx,%eax
    12ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12f4:	eb 74                	jmp    136a <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12f6:	8b 45 14             	mov    0x14(%ebp),%eax
    12f9:	8b 50 18             	mov    0x18(%eax),%edx
    12fc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1302:	01 c8                	add    %ecx,%eax
    1304:	89 c1                	mov    %eax,%ecx
    1306:	89 c8                	mov    %ecx,%eax
    1308:	01 c0                	add    %eax,%eax
    130a:	01 c8                	add    %ecx,%eax
    130c:	01 d0                	add    %edx,%eax
    130e:	0f b7 10             	movzwl (%eax),%edx
    1311:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1315:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1319:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    131c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1320:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1324:	38 c2                	cmp    %al,%dl
    1326:	75 18                	jne    1340 <APDcCopy+0x154>
    1328:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    132c:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1330:	38 c2                	cmp    %al,%dl
    1332:	75 0c                	jne    1340 <APDcCopy+0x154>
    1334:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1338:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    133c:	38 c2                	cmp    %al,%dl
    133e:	74 26                	je     1366 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1340:	8b 45 08             	mov    0x8(%ebp),%eax
    1343:	8b 50 18             	mov    0x18(%eax),%edx
    1346:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1349:	8b 45 f0             	mov    -0x10(%ebp),%eax
    134c:	01 c8                	add    %ecx,%eax
    134e:	89 c1                	mov    %eax,%ecx
    1350:	89 c8                	mov    %ecx,%eax
    1352:	01 c0                	add    %eax,%eax
    1354:	01 c8                	add    %ecx,%eax
    1356:	01 d0                	add    %edx,%eax
    1358:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    135c:	66 89 10             	mov    %dx,(%eax)
    135f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1363:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1366:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    136a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    136d:	2b 45 0c             	sub    0xc(%ebp),%eax
    1370:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1373:	7d 81                	jge    12f6 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1375:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1379:	8b 45 f8             	mov    -0x8(%ebp),%eax
    137c:	2b 45 10             	sub    0x10(%ebp),%eax
    137f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1382:	0f 8d 35 ff ff ff    	jge    12bd <APDcCopy+0xd1>
    1388:	eb 04                	jmp    138e <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    138a:	90                   	nop
    138b:	eb 01                	jmp    138e <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    138d:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    138e:	c9                   	leave  
    138f:	c3                   	ret    

00001390 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1390:	55                   	push   %ebp
    1391:	89 e5                	mov    %esp,%ebp
    1393:	83 ec 1c             	sub    $0x1c,%esp
    1396:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1399:	8b 55 10             	mov    0x10(%ebp),%edx
    139c:	8b 45 14             	mov    0x14(%ebp),%eax
    139f:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13a2:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13a5:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13a8:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13ac:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13af:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13b3:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13b6:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13ba:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13bd:	8b 45 08             	mov    0x8(%ebp),%eax
    13c0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13c4:	66 89 10             	mov    %dx,(%eax)
    13c7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13cb:	88 50 02             	mov    %dl,0x2(%eax)
}
    13ce:	8b 45 08             	mov    0x8(%ebp),%eax
    13d1:	c9                   	leave  
    13d2:	c2 04 00             	ret    $0x4

000013d5 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13d5:	55                   	push   %ebp
    13d6:	89 e5                	mov    %esp,%ebp
    13d8:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13db:	8b 45 08             	mov    0x8(%ebp),%eax
    13de:	8b 00                	mov    (%eax),%eax
    13e0:	83 ec 08             	sub    $0x8,%esp
    13e3:	8d 55 0c             	lea    0xc(%ebp),%edx
    13e6:	52                   	push   %edx
    13e7:	50                   	push   %eax
    13e8:	e8 77 ef ff ff       	call   364 <sendMessage>
    13ed:	83 c4 10             	add    $0x10,%esp
}
    13f0:	90                   	nop
    13f1:	c9                   	leave  
    13f2:	c3                   	ret    

000013f3 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13f3:	55                   	push   %ebp
    13f4:	89 e5                	mov    %esp,%ebp
    13f6:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13f9:	83 ec 0c             	sub    $0xc,%esp
    13fc:	68 98 00 00 00       	push   $0x98
    1401:	e8 38 f3 ff ff       	call   73e <malloc>
    1406:	83 c4 10             	add    $0x10,%esp
    1409:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    140c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1410:	75 15                	jne    1427 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1412:	83 ec 04             	sub    $0x4,%esp
    1415:	ff 75 08             	pushl  0x8(%ebp)
    1418:	68 4c 22 00 00       	push   $0x224c
    141d:	6a 01                	push   $0x1
    141f:	e8 47 f0 ff ff       	call   46b <printf>
    1424:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1427:	8b 45 f4             	mov    -0xc(%ebp),%eax
    142a:	05 84 00 00 00       	add    $0x84,%eax
    142f:	83 ec 08             	sub    $0x8,%esp
    1432:	ff 75 08             	pushl  0x8(%ebp)
    1435:	50                   	push   %eax
    1436:	e8 50 ec ff ff       	call   8b <strcpy>
    143b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    143e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1441:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1448:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144b:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1452:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1455:	8b 40 3c             	mov    0x3c(%eax),%eax
    1458:	89 c2                	mov    %eax,%edx
    145a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    145d:	8b 40 40             	mov    0x40(%eax),%eax
    1460:	0f af d0             	imul   %eax,%edx
    1463:	89 d0                	mov    %edx,%eax
    1465:	01 c0                	add    %eax,%eax
    1467:	01 d0                	add    %edx,%eax
    1469:	83 ec 0c             	sub    $0xc,%esp
    146c:	50                   	push   %eax
    146d:	e8 cc f2 ff ff       	call   73e <malloc>
    1472:	83 c4 10             	add    $0x10,%esp
    1475:	89 c2                	mov    %eax,%edx
    1477:	8b 45 f4             	mov    -0xc(%ebp),%eax
    147a:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    147d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1480:	8b 40 54             	mov    0x54(%eax),%eax
    1483:	85 c0                	test   %eax,%eax
    1485:	75 15                	jne    149c <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1487:	83 ec 04             	sub    $0x4,%esp
    148a:	ff 75 08             	pushl  0x8(%ebp)
    148d:	68 6c 22 00 00       	push   $0x226c
    1492:	6a 01                	push   $0x1
    1494:	e8 d2 ef ff ff       	call   46b <printf>
    1499:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    149c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149f:	8b 40 3c             	mov    0x3c(%eax),%eax
    14a2:	89 c2                	mov    %eax,%edx
    14a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a7:	8b 40 40             	mov    0x40(%eax),%eax
    14aa:	0f af d0             	imul   %eax,%edx
    14ad:	89 d0                	mov    %edx,%eax
    14af:	01 c0                	add    %eax,%eax
    14b1:	01 c2                	add    %eax,%edx
    14b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b6:	8b 40 54             	mov    0x54(%eax),%eax
    14b9:	83 ec 04             	sub    $0x4,%esp
    14bc:	52                   	push   %edx
    14bd:	68 ff ff ff 00       	push   $0xffffff
    14c2:	50                   	push   %eax
    14c3:	e8 59 ec ff ff       	call   121 <memset>
    14c8:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ce:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    14d5:	e8 62 ee ff ff       	call   33c <getpid>
    14da:	89 c2                	mov    %eax,%edx
    14dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14df:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e5:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ef:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f9:	8b 40 58             	mov    0x58(%eax),%eax
    14fc:	89 c2                	mov    %eax,%edx
    14fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1501:	8b 40 5c             	mov    0x5c(%eax),%eax
    1504:	0f af d0             	imul   %eax,%edx
    1507:	89 d0                	mov    %edx,%eax
    1509:	01 c0                	add    %eax,%eax
    150b:	01 d0                	add    %edx,%eax
    150d:	83 ec 0c             	sub    $0xc,%esp
    1510:	50                   	push   %eax
    1511:	e8 28 f2 ff ff       	call   73e <malloc>
    1516:	83 c4 10             	add    $0x10,%esp
    1519:	89 c2                	mov    %eax,%edx
    151b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151e:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	8b 40 70             	mov    0x70(%eax),%eax
    1527:	85 c0                	test   %eax,%eax
    1529:	75 15                	jne    1540 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    152b:	83 ec 04             	sub    $0x4,%esp
    152e:	ff 75 08             	pushl  0x8(%ebp)
    1531:	68 90 22 00 00       	push   $0x2290
    1536:	6a 01                	push   $0x1
    1538:	e8 2e ef ff ff       	call   46b <printf>
    153d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1540:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1543:	8b 40 3c             	mov    0x3c(%eax),%eax
    1546:	89 c2                	mov    %eax,%edx
    1548:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154b:	8b 40 40             	mov    0x40(%eax),%eax
    154e:	0f af d0             	imul   %eax,%edx
    1551:	89 d0                	mov    %edx,%eax
    1553:	01 c0                	add    %eax,%eax
    1555:	01 c2                	add    %eax,%edx
    1557:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155a:	8b 40 54             	mov    0x54(%eax),%eax
    155d:	83 ec 04             	sub    $0x4,%esp
    1560:	52                   	push   %edx
    1561:	68 ff 00 00 00       	push   $0xff
    1566:	50                   	push   %eax
    1567:	e8 b5 eb ff ff       	call   121 <memset>
    156c:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    156f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1572:	8b 55 0c             	mov    0xc(%ebp),%edx
    1575:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1578:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    157c:	74 49                	je     15c7 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    157e:	8b 45 10             	mov    0x10(%ebp),%eax
    1581:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1587:	83 ec 0c             	sub    $0xc,%esp
    158a:	50                   	push   %eax
    158b:	e8 ae f1 ff ff       	call   73e <malloc>
    1590:	83 c4 10             	add    $0x10,%esp
    1593:	89 c2                	mov    %eax,%edx
    1595:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1598:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	8b 55 10             	mov    0x10(%ebp),%edx
    15a1:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    15ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b1:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15c2:	e9 8d 00 00 00       	jmp    1654 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ca:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d4:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15de:	8b 40 20             	mov    0x20(%eax),%eax
    15e1:	89 c2                	mov    %eax,%edx
    15e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e6:	8b 40 24             	mov    0x24(%eax),%eax
    15e9:	0f af d0             	imul   %eax,%edx
    15ec:	89 d0                	mov    %edx,%eax
    15ee:	01 c0                	add    %eax,%eax
    15f0:	01 d0                	add    %edx,%eax
    15f2:	83 ec 0c             	sub    $0xc,%esp
    15f5:	50                   	push   %eax
    15f6:	e8 43 f1 ff ff       	call   73e <malloc>
    15fb:	83 c4 10             	add    $0x10,%esp
    15fe:	89 c2                	mov    %eax,%edx
    1600:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1603:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	8b 40 38             	mov    0x38(%eax),%eax
    160c:	85 c0                	test   %eax,%eax
    160e:	75 15                	jne    1625 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1610:	83 ec 04             	sub    $0x4,%esp
    1613:	ff 75 08             	pushl  0x8(%ebp)
    1616:	68 b8 22 00 00       	push   $0x22b8
    161b:	6a 01                	push   $0x1
    161d:	e8 49 ee ff ff       	call   46b <printf>
    1622:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1625:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1628:	8b 40 20             	mov    0x20(%eax),%eax
    162b:	89 c2                	mov    %eax,%edx
    162d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1630:	8b 40 24             	mov    0x24(%eax),%eax
    1633:	0f af d0             	imul   %eax,%edx
    1636:	89 d0                	mov    %edx,%eax
    1638:	01 c0                	add    %eax,%eax
    163a:	01 c2                	add    %eax,%edx
    163c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163f:	8b 40 38             	mov    0x38(%eax),%eax
    1642:	83 ec 04             	sub    $0x4,%esp
    1645:	52                   	push   %edx
    1646:	68 ff ff ff 00       	push   $0xffffff
    164b:	50                   	push   %eax
    164c:	e8 d0 ea ff ff       	call   121 <memset>
    1651:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1654:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1657:	c9                   	leave  
    1658:	c3                   	ret    

00001659 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1659:	55                   	push   %ebp
    165a:	89 e5                	mov    %esp,%ebp
    165c:	57                   	push   %edi
    165d:	56                   	push   %esi
    165e:	53                   	push   %ebx
    165f:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1662:	8b 45 0c             	mov    0xc(%ebp),%eax
    1665:	83 f8 03             	cmp    $0x3,%eax
    1668:	74 02                	je     166c <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    166a:	eb 7c                	jmp    16e8 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    166c:	8b 45 08             	mov    0x8(%ebp),%eax
    166f:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1672:	8b 45 08             	mov    0x8(%ebp),%eax
    1675:	8b 48 18             	mov    0x18(%eax),%ecx
    1678:	8b 45 08             	mov    0x8(%ebp),%eax
    167b:	8b 50 5c             	mov    0x5c(%eax),%edx
    167e:	8b 45 08             	mov    0x8(%ebp),%eax
    1681:	8b 40 58             	mov    0x58(%eax),%eax
    1684:	8b 75 08             	mov    0x8(%ebp),%esi
    1687:	83 c6 58             	add    $0x58,%esi
    168a:	83 ec 04             	sub    $0x4,%esp
    168d:	53                   	push   %ebx
    168e:	51                   	push   %ecx
    168f:	6a 00                	push   $0x0
    1691:	52                   	push   %edx
    1692:	50                   	push   %eax
    1693:	6a 00                	push   $0x0
    1695:	6a 00                	push   $0x0
    1697:	56                   	push   %esi
    1698:	6a 00                	push   $0x0
    169a:	6a 00                	push   $0x0
    169c:	ff 75 08             	pushl  0x8(%ebp)
    169f:	e8 b8 ec ff ff       	call   35c <paintWindow>
    16a4:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    16a7:	8b 45 08             	mov    0x8(%ebp),%eax
    16aa:	8b 70 1c             	mov    0x1c(%eax),%esi
    16ad:	8b 45 08             	mov    0x8(%ebp),%eax
    16b0:	8b 58 18             	mov    0x18(%eax),%ebx
    16b3:	8b 45 08             	mov    0x8(%ebp),%eax
    16b6:	8b 48 08             	mov    0x8(%eax),%ecx
    16b9:	8b 45 08             	mov    0x8(%ebp),%eax
    16bc:	8b 50 40             	mov    0x40(%eax),%edx
    16bf:	8b 45 08             	mov    0x8(%ebp),%eax
    16c2:	8b 40 3c             	mov    0x3c(%eax),%eax
    16c5:	8b 7d 08             	mov    0x8(%ebp),%edi
    16c8:	83 c7 3c             	add    $0x3c,%edi
    16cb:	83 ec 04             	sub    $0x4,%esp
    16ce:	56                   	push   %esi
    16cf:	53                   	push   %ebx
    16d0:	51                   	push   %ecx
    16d1:	52                   	push   %edx
    16d2:	50                   	push   %eax
    16d3:	6a 00                	push   $0x0
    16d5:	6a 00                	push   $0x0
    16d7:	57                   	push   %edi
    16d8:	6a 32                	push   $0x32
    16da:	6a 00                	push   $0x0
    16dc:	ff 75 08             	pushl  0x8(%ebp)
    16df:	e8 78 ec ff ff       	call   35c <paintWindow>
    16e4:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16e7:	90                   	nop
        default: break;
            
            
    }
    return False;
    16e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16f0:	5b                   	pop    %ebx
    16f1:	5e                   	pop    %esi
    16f2:	5f                   	pop    %edi
    16f3:	5d                   	pop    %ebp
    16f4:	c3                   	ret    

000016f5 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16f5:	55                   	push   %ebp
    16f6:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    16fb:	8b 50 08             	mov    0x8(%eax),%edx
    16fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1701:	8b 00                	mov    (%eax),%eax
    1703:	39 c2                	cmp    %eax,%edx
    1705:	74 07                	je     170e <APPreJudge+0x19>
        return False;
    1707:	b8 00 00 00 00       	mov    $0x0,%eax
    170c:	eb 05                	jmp    1713 <APPreJudge+0x1e>
    return True;
    170e:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1713:	5d                   	pop    %ebp
    1714:	c3                   	ret    

00001715 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1715:	55                   	push   %ebp
    1716:	89 e5                	mov    %esp,%ebp
    1718:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    171b:	8b 45 08             	mov    0x8(%ebp),%eax
    171e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1721:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1727:	83 ec 0c             	sub    $0xc,%esp
    172a:	ff 75 08             	pushl  0x8(%ebp)
    172d:	e8 42 ec ff ff       	call   374 <registWindow>
    1732:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1735:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    173c:	8b 45 08             	mov    0x8(%ebp),%eax
    173f:	8b 00                	mov    (%eax),%eax
    1741:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1744:	ff 75 f4             	pushl  -0xc(%ebp)
    1747:	ff 75 f0             	pushl  -0x10(%ebp)
    174a:	ff 75 ec             	pushl  -0x14(%ebp)
    174d:	ff 75 08             	pushl  0x8(%ebp)
    1750:	e8 80 fc ff ff       	call   13d5 <APSendMessage>
    1755:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1758:	83 ec 0c             	sub    $0xc,%esp
    175b:	ff 75 08             	pushl  0x8(%ebp)
    175e:	e8 09 ec ff ff       	call   36c <getMessage>
    1763:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1766:	8b 45 08             	mov    0x8(%ebp),%eax
    1769:	83 c0 74             	add    $0x74,%eax
    176c:	83 ec 08             	sub    $0x8,%esp
    176f:	50                   	push   %eax
    1770:	ff 75 08             	pushl  0x8(%ebp)
    1773:	e8 7d ff ff ff       	call   16f5 <APPreJudge>
    1778:	83 c4 10             	add    $0x10,%esp
    177b:	84 c0                	test   %al,%al
    177d:	74 1b                	je     179a <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    177f:	8b 45 08             	mov    0x8(%ebp),%eax
    1782:	ff 70 7c             	pushl  0x7c(%eax)
    1785:	ff 70 78             	pushl  0x78(%eax)
    1788:	ff 70 74             	pushl  0x74(%eax)
    178b:	ff 75 08             	pushl  0x8(%ebp)
    178e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1791:	ff d0                	call   *%eax
    1793:	83 c4 10             	add    $0x10,%esp
    1796:	84 c0                	test   %al,%al
    1798:	75 0c                	jne    17a6 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    179a:	8b 45 08             	mov    0x8(%ebp),%eax
    179d:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    17a4:	eb b2                	jmp    1758 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17a6:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17a7:	90                   	nop
    17a8:	c9                   	leave  
    17a9:	c3                   	ret    

000017aa <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17aa:	55                   	push   %ebp
    17ab:	89 e5                	mov    %esp,%ebp
    17ad:	57                   	push   %edi
    17ae:	56                   	push   %esi
    17af:	53                   	push   %ebx
    17b0:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17b3:	a1 40 29 00 00       	mov    0x2940,%eax
    17b8:	85 c0                	test   %eax,%eax
    17ba:	0f 85 2c 02 00 00    	jne    19ec <APGridPaint+0x242>
    {
        iconReady = 1;
    17c0:	c7 05 40 29 00 00 01 	movl   $0x1,0x2940
    17c7:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17ca:	8d 45 98             	lea    -0x68(%ebp),%eax
    17cd:	83 ec 08             	sub    $0x8,%esp
    17d0:	68 df 22 00 00       	push   $0x22df
    17d5:	50                   	push   %eax
    17d6:	e8 16 f1 ff ff       	call   8f1 <APLoadBitmap>
    17db:	83 c4 0c             	add    $0xc,%esp
    17de:	8b 45 98             	mov    -0x68(%ebp),%eax
    17e1:	a3 64 29 00 00       	mov    %eax,0x2964
    17e6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17e9:	a3 68 29 00 00       	mov    %eax,0x2968
    17ee:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17f1:	a3 6c 29 00 00       	mov    %eax,0x296c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17f6:	83 ec 04             	sub    $0x4,%esp
    17f9:	ff 35 6c 29 00 00    	pushl  0x296c
    17ff:	ff 35 68 29 00 00    	pushl  0x2968
    1805:	ff 35 64 29 00 00    	pushl  0x2964
    180b:	e8 1b f3 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1810:	83 c4 10             	add    $0x10,%esp
    1813:	a3 70 29 00 00       	mov    %eax,0x2970
        grid_river = APLoadBitmap ("grid_river.bmp");
    1818:	8d 45 98             	lea    -0x68(%ebp),%eax
    181b:	83 ec 08             	sub    $0x8,%esp
    181e:	68 ed 22 00 00       	push   $0x22ed
    1823:	50                   	push   %eax
    1824:	e8 c8 f0 ff ff       	call   8f1 <APLoadBitmap>
    1829:	83 c4 0c             	add    $0xc,%esp
    182c:	8b 45 98             	mov    -0x68(%ebp),%eax
    182f:	a3 a0 29 00 00       	mov    %eax,0x29a0
    1834:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1837:	a3 a4 29 00 00       	mov    %eax,0x29a4
    183c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    183f:	a3 a8 29 00 00       	mov    %eax,0x29a8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1844:	83 ec 04             	sub    $0x4,%esp
    1847:	ff 35 a8 29 00 00    	pushl  0x29a8
    184d:	ff 35 a4 29 00 00    	pushl  0x29a4
    1853:	ff 35 a0 29 00 00    	pushl  0x29a0
    1859:	e8 cd f2 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    185e:	83 c4 10             	add    $0x10,%esp
    1861:	a3 90 29 00 00       	mov    %eax,0x2990
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1866:	8d 45 98             	lea    -0x68(%ebp),%eax
    1869:	83 ec 08             	sub    $0x8,%esp
    186c:	68 fc 22 00 00       	push   $0x22fc
    1871:	50                   	push   %eax
    1872:	e8 7a f0 ff ff       	call   8f1 <APLoadBitmap>
    1877:	83 c4 0c             	add    $0xc,%esp
    187a:	8b 45 98             	mov    -0x68(%ebp),%eax
    187d:	a3 94 29 00 00       	mov    %eax,0x2994
    1882:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1885:	a3 98 29 00 00       	mov    %eax,0x2998
    188a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    188d:	a3 9c 29 00 00       	mov    %eax,0x299c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1892:	83 ec 04             	sub    $0x4,%esp
    1895:	ff 35 9c 29 00 00    	pushl  0x299c
    189b:	ff 35 98 29 00 00    	pushl  0x2998
    18a1:	ff 35 94 29 00 00    	pushl  0x2994
    18a7:	e8 7f f2 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    18ac:	83 c4 10             	add    $0x10,%esp
    18af:	a3 44 29 00 00       	mov    %eax,0x2944
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18b4:	8d 45 98             	lea    -0x68(%ebp),%eax
    18b7:	83 ec 08             	sub    $0x8,%esp
    18ba:	68 0b 23 00 00       	push   $0x230b
    18bf:	50                   	push   %eax
    18c0:	e8 2c f0 ff ff       	call   8f1 <APLoadBitmap>
    18c5:	83 c4 0c             	add    $0xc,%esp
    18c8:	8b 45 98             	mov    -0x68(%ebp),%eax
    18cb:	a3 78 29 00 00       	mov    %eax,0x2978
    18d0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d3:	a3 7c 29 00 00       	mov    %eax,0x297c
    18d8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18db:	a3 80 29 00 00       	mov    %eax,0x2980
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18e0:	83 ec 04             	sub    $0x4,%esp
    18e3:	ff 35 80 29 00 00    	pushl  0x2980
    18e9:	ff 35 7c 29 00 00    	pushl  0x297c
    18ef:	ff 35 78 29 00 00    	pushl  0x2978
    18f5:	e8 31 f2 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    18fa:	83 c4 10             	add    $0x10,%esp
    18fd:	a3 ac 29 00 00       	mov    %eax,0x29ac
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1902:	8d 45 98             	lea    -0x68(%ebp),%eax
    1905:	83 ec 08             	sub    $0x8,%esp
    1908:	68 19 23 00 00       	push   $0x2319
    190d:	50                   	push   %eax
    190e:	e8 de ef ff ff       	call   8f1 <APLoadBitmap>
    1913:	83 c4 0c             	add    $0xc,%esp
    1916:	8b 45 98             	mov    -0x68(%ebp),%eax
    1919:	a3 54 29 00 00       	mov    %eax,0x2954
    191e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1921:	a3 58 29 00 00       	mov    %eax,0x2958
    1926:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1929:	a3 5c 29 00 00       	mov    %eax,0x295c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    192e:	83 ec 04             	sub    $0x4,%esp
    1931:	ff 35 5c 29 00 00    	pushl  0x295c
    1937:	ff 35 58 29 00 00    	pushl  0x2958
    193d:	ff 35 54 29 00 00    	pushl  0x2954
    1943:	e8 e3 f1 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1948:	83 c4 10             	add    $0x10,%esp
    194b:	a3 74 29 00 00       	mov    %eax,0x2974
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1950:	8d 45 98             	lea    -0x68(%ebp),%eax
    1953:	83 ec 08             	sub    $0x8,%esp
    1956:	68 29 23 00 00       	push   $0x2329
    195b:	50                   	push   %eax
    195c:	e8 90 ef ff ff       	call   8f1 <APLoadBitmap>
    1961:	83 c4 0c             	add    $0xc,%esp
    1964:	8b 45 98             	mov    -0x68(%ebp),%eax
    1967:	a3 48 29 00 00       	mov    %eax,0x2948
    196c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    196f:	a3 4c 29 00 00       	mov    %eax,0x294c
    1974:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1977:	a3 50 29 00 00       	mov    %eax,0x2950
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    197c:	83 ec 04             	sub    $0x4,%esp
    197f:	ff 35 50 29 00 00    	pushl  0x2950
    1985:	ff 35 4c 29 00 00    	pushl  0x294c
    198b:	ff 35 48 29 00 00    	pushl  0x2948
    1991:	e8 95 f1 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1996:	83 c4 10             	add    $0x10,%esp
    1999:	a3 60 29 00 00       	mov    %eax,0x2960
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    199e:	8d 45 98             	lea    -0x68(%ebp),%eax
    19a1:	83 ec 08             	sub    $0x8,%esp
    19a4:	68 3b 23 00 00       	push   $0x233b
    19a9:	50                   	push   %eax
    19aa:	e8 42 ef ff ff       	call   8f1 <APLoadBitmap>
    19af:	83 c4 0c             	add    $0xc,%esp
    19b2:	8b 45 98             	mov    -0x68(%ebp),%eax
    19b5:	a3 84 29 00 00       	mov    %eax,0x2984
    19ba:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19bd:	a3 88 29 00 00       	mov    %eax,0x2988
    19c2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19c5:	a3 8c 29 00 00       	mov    %eax,0x298c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19ca:	83 ec 04             	sub    $0x4,%esp
    19cd:	ff 35 8c 29 00 00    	pushl  0x298c
    19d3:	ff 35 88 29 00 00    	pushl  0x2988
    19d9:	ff 35 84 29 00 00    	pushl  0x2984
    19df:	e8 47 f1 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    19e4:	83 c4 10             	add    $0x10,%esp
    19e7:	a3 b0 29 00 00       	mov    %eax,0x29b0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19ec:	8b 45 08             	mov    0x8(%ebp),%eax
    19ef:	8b 40 08             	mov    0x8(%eax),%eax
    19f2:	85 c0                	test   %eax,%eax
    19f4:	75 17                	jne    1a0d <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19f6:	83 ec 08             	sub    $0x8,%esp
    19f9:	68 4c 23 00 00       	push   $0x234c
    19fe:	6a 01                	push   $0x1
    1a00:	e8 66 ea ff ff       	call   46b <printf>
    1a05:	83 c4 10             	add    $0x10,%esp
        return;
    1a08:	e9 a0 04 00 00       	jmp    1ead <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a10:	8b 40 10             	mov    0x10(%eax),%eax
    1a13:	85 c0                	test   %eax,%eax
    1a15:	7e 10                	jle    1a27 <APGridPaint+0x27d>
    1a17:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1a:	8b 50 14             	mov    0x14(%eax),%edx
    1a1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a20:	8b 40 10             	mov    0x10(%eax),%eax
    1a23:	39 c2                	cmp    %eax,%edx
    1a25:	7c 17                	jl     1a3e <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a27:	83 ec 08             	sub    $0x8,%esp
    1a2a:	68 72 23 00 00       	push   $0x2372
    1a2f:	6a 01                	push   $0x1
    1a31:	e8 35 ea ff ff       	call   46b <printf>
    1a36:	83 c4 10             	add    $0x10,%esp
        return;
    1a39:	e9 6f 04 00 00       	jmp    1ead <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	8b 40 14             	mov    0x14(%eax),%eax
    1a44:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a4a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a50:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a53:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a5a:	e9 96 03 00 00       	jmp    1df5 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a5f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a66:	e9 7c 03 00 00       	jmp    1de7 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a6e:	c1 e0 04             	shl    $0x4,%eax
    1a71:	89 c2                	mov    %eax,%edx
    1a73:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a76:	01 c2                	add    %eax,%edx
    1a78:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a7b:	01 d0                	add    %edx,%eax
    1a7d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a80:	8b 45 08             	mov    0x8(%ebp),%eax
    1a83:	8b 40 0c             	mov    0xc(%eax),%eax
    1a86:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a89:	c1 e2 02             	shl    $0x2,%edx
    1a8c:	01 d0                	add    %edx,%eax
    1a8e:	8b 00                	mov    (%eax),%eax
    1a90:	83 f8 07             	cmp    $0x7,%eax
    1a93:	0f 87 49 03 00 00    	ja     1de2 <APGridPaint+0x638>
    1a99:	8b 04 85 88 23 00 00 	mov    0x2388(,%eax,4),%eax
    1aa0:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1aa2:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1aa5:	6a 0c                	push   $0xc
    1aa7:	6a 0c                	push   $0xc
    1aa9:	6a 0c                	push   $0xc
    1aab:	50                   	push   %eax
    1aac:	e8 df f8 ff ff       	call   1390 <RGB>
    1ab1:	83 c4 0c             	add    $0xc,%esp
    1ab4:	8b 1d 70 29 00 00    	mov    0x2970,%ebx
    1aba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1abd:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ac0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ac3:	6b c0 32             	imul   $0x32,%eax,%eax
    1ac6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ac9:	8b 45 08             	mov    0x8(%ebp),%eax
    1acc:	8d 78 3c             	lea    0x3c(%eax),%edi
    1acf:	83 ec 0c             	sub    $0xc,%esp
    1ad2:	83 ec 04             	sub    $0x4,%esp
    1ad5:	89 e0                	mov    %esp,%eax
    1ad7:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1adb:	66 89 30             	mov    %si,(%eax)
    1ade:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1ae2:	88 50 02             	mov    %dl,0x2(%eax)
    1ae5:	6a 32                	push   $0x32
    1ae7:	6a 32                	push   $0x32
    1ae9:	6a 00                	push   $0x0
    1aeb:	6a 00                	push   $0x0
    1aed:	53                   	push   %ebx
    1aee:	51                   	push   %ecx
    1aef:	ff 75 94             	pushl  -0x6c(%ebp)
    1af2:	57                   	push   %edi
    1af3:	e8 f4 f6 ff ff       	call   11ec <APDcCopy>
    1af8:	83 c4 30             	add    $0x30,%esp
                    break;
    1afb:	e9 e3 02 00 00       	jmp    1de3 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b00:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b03:	6a 69                	push   $0x69
    1b05:	6a 69                	push   $0x69
    1b07:	6a 69                	push   $0x69
    1b09:	50                   	push   %eax
    1b0a:	e8 81 f8 ff ff       	call   1390 <RGB>
    1b0f:	83 c4 0c             	add    $0xc,%esp
    1b12:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b16:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b1a:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b1e:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b21:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b28:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b2b:	6a 69                	push   $0x69
    1b2d:	6a 69                	push   $0x69
    1b2f:	6a 69                	push   $0x69
    1b31:	50                   	push   %eax
    1b32:	e8 59 f8 ff ff       	call   1390 <RGB>
    1b37:	83 c4 0c             	add    $0xc,%esp
    1b3a:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b3e:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b42:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b46:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b49:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4c:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b4f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b52:	ff 75 b0             	pushl  -0x50(%ebp)
    1b55:	ff 75 ac             	pushl  -0x54(%ebp)
    1b58:	52                   	push   %edx
    1b59:	50                   	push   %eax
    1b5a:	e8 61 f0 ff ff       	call   bc0 <APSetPen>
    1b5f:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b62:	8b 45 08             	mov    0x8(%ebp),%eax
    1b65:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b68:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b6b:	83 ec 04             	sub    $0x4,%esp
    1b6e:	83 ec 04             	sub    $0x4,%esp
    1b71:	89 e0                	mov    %esp,%eax
    1b73:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b77:	66 89 08             	mov    %cx,(%eax)
    1b7a:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b7e:	88 48 02             	mov    %cl,0x2(%eax)
    1b81:	53                   	push   %ebx
    1b82:	52                   	push   %edx
    1b83:	e8 71 f0 ff ff       	call   bf9 <APSetBrush>
    1b88:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b8e:	6b d0 32             	imul   $0x32,%eax,%edx
    1b91:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b94:	6b c0 32             	imul   $0x32,%eax,%eax
    1b97:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b9a:	83 c1 3c             	add    $0x3c,%ecx
    1b9d:	83 ec 0c             	sub    $0xc,%esp
    1ba0:	6a 32                	push   $0x32
    1ba2:	6a 32                	push   $0x32
    1ba4:	52                   	push   %edx
    1ba5:	50                   	push   %eax
    1ba6:	51                   	push   %ecx
    1ba7:	e8 35 f4 ff ff       	call   fe1 <APDrawRect>
    1bac:	83 c4 20             	add    $0x20,%esp
                    break;
    1baf:	e9 2f 02 00 00       	jmp    1de3 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bb4:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bb7:	6a 0c                	push   $0xc
    1bb9:	6a 0c                	push   $0xc
    1bbb:	6a 0c                	push   $0xc
    1bbd:	50                   	push   %eax
    1bbe:	e8 cd f7 ff ff       	call   1390 <RGB>
    1bc3:	83 c4 0c             	add    $0xc,%esp
    1bc6:	8b 1d b0 29 00 00    	mov    0x29b0,%ebx
    1bcc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bcf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bd2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bd5:	6b c0 32             	imul   $0x32,%eax,%eax
    1bd8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bdb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bde:	8d 78 3c             	lea    0x3c(%eax),%edi
    1be1:	83 ec 0c             	sub    $0xc,%esp
    1be4:	83 ec 04             	sub    $0x4,%esp
    1be7:	89 e0                	mov    %esp,%eax
    1be9:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1bed:	66 89 30             	mov    %si,(%eax)
    1bf0:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1bf4:	88 50 02             	mov    %dl,0x2(%eax)
    1bf7:	6a 32                	push   $0x32
    1bf9:	6a 32                	push   $0x32
    1bfb:	6a 00                	push   $0x0
    1bfd:	6a 00                	push   $0x0
    1bff:	53                   	push   %ebx
    1c00:	51                   	push   %ecx
    1c01:	ff 75 94             	pushl  -0x6c(%ebp)
    1c04:	57                   	push   %edi
    1c05:	e8 e2 f5 ff ff       	call   11ec <APDcCopy>
    1c0a:	83 c4 30             	add    $0x30,%esp
                    break;
    1c0d:	e9 d1 01 00 00       	jmp    1de3 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c12:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c15:	6a 0c                	push   $0xc
    1c17:	6a 0c                	push   $0xc
    1c19:	6a 0c                	push   $0xc
    1c1b:	50                   	push   %eax
    1c1c:	e8 6f f7 ff ff       	call   1390 <RGB>
    1c21:	83 c4 0c             	add    $0xc,%esp
    1c24:	8b 1d 90 29 00 00    	mov    0x2990,%ebx
    1c2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c2d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c30:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c33:	6b c0 32             	imul   $0x32,%eax,%eax
    1c36:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c39:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c3f:	83 ec 0c             	sub    $0xc,%esp
    1c42:	83 ec 04             	sub    $0x4,%esp
    1c45:	89 e0                	mov    %esp,%eax
    1c47:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c4b:	66 89 30             	mov    %si,(%eax)
    1c4e:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c52:	88 50 02             	mov    %dl,0x2(%eax)
    1c55:	6a 32                	push   $0x32
    1c57:	6a 32                	push   $0x32
    1c59:	6a 00                	push   $0x0
    1c5b:	6a 00                	push   $0x0
    1c5d:	53                   	push   %ebx
    1c5e:	51                   	push   %ecx
    1c5f:	ff 75 94             	pushl  -0x6c(%ebp)
    1c62:	57                   	push   %edi
    1c63:	e8 84 f5 ff ff       	call   11ec <APDcCopy>
    1c68:	83 c4 30             	add    $0x30,%esp
                    break;
    1c6b:	e9 73 01 00 00       	jmp    1de3 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c70:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c73:	6a 0c                	push   $0xc
    1c75:	6a 0c                	push   $0xc
    1c77:	6a 0c                	push   $0xc
    1c79:	50                   	push   %eax
    1c7a:	e8 11 f7 ff ff       	call   1390 <RGB>
    1c7f:	83 c4 0c             	add    $0xc,%esp
    1c82:	8b 1d 74 29 00 00    	mov    0x2974,%ebx
    1c88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c8b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c91:	6b c0 32             	imul   $0x32,%eax,%eax
    1c94:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c97:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c9d:	83 ec 0c             	sub    $0xc,%esp
    1ca0:	83 ec 04             	sub    $0x4,%esp
    1ca3:	89 e0                	mov    %esp,%eax
    1ca5:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1ca9:	66 89 30             	mov    %si,(%eax)
    1cac:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1cb0:	88 50 02             	mov    %dl,0x2(%eax)
    1cb3:	6a 32                	push   $0x32
    1cb5:	6a 32                	push   $0x32
    1cb7:	6a 00                	push   $0x0
    1cb9:	6a 00                	push   $0x0
    1cbb:	53                   	push   %ebx
    1cbc:	51                   	push   %ecx
    1cbd:	ff 75 94             	pushl  -0x6c(%ebp)
    1cc0:	57                   	push   %edi
    1cc1:	e8 26 f5 ff ff       	call   11ec <APDcCopy>
    1cc6:	83 c4 30             	add    $0x30,%esp
                    break;
    1cc9:	e9 15 01 00 00       	jmp    1de3 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cce:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cd1:	6a 0c                	push   $0xc
    1cd3:	6a 0c                	push   $0xc
    1cd5:	6a 0c                	push   $0xc
    1cd7:	50                   	push   %eax
    1cd8:	e8 b3 f6 ff ff       	call   1390 <RGB>
    1cdd:	83 c4 0c             	add    $0xc,%esp
    1ce0:	8b 1d ac 29 00 00    	mov    0x29ac,%ebx
    1ce6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ce9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cec:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cef:	6b c0 32             	imul   $0x32,%eax,%eax
    1cf2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cf5:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf8:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cfb:	83 ec 0c             	sub    $0xc,%esp
    1cfe:	83 ec 04             	sub    $0x4,%esp
    1d01:	89 e0                	mov    %esp,%eax
    1d03:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d07:	66 89 30             	mov    %si,(%eax)
    1d0a:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d0e:	88 50 02             	mov    %dl,0x2(%eax)
    1d11:	6a 32                	push   $0x32
    1d13:	6a 32                	push   $0x32
    1d15:	6a 00                	push   $0x0
    1d17:	6a 00                	push   $0x0
    1d19:	53                   	push   %ebx
    1d1a:	51                   	push   %ecx
    1d1b:	ff 75 94             	pushl  -0x6c(%ebp)
    1d1e:	57                   	push   %edi
    1d1f:	e8 c8 f4 ff ff       	call   11ec <APDcCopy>
    1d24:	83 c4 30             	add    $0x30,%esp
                    break;
    1d27:	e9 b7 00 00 00       	jmp    1de3 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d2c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d2f:	6a 0c                	push   $0xc
    1d31:	6a 0c                	push   $0xc
    1d33:	6a 0c                	push   $0xc
    1d35:	50                   	push   %eax
    1d36:	e8 55 f6 ff ff       	call   1390 <RGB>
    1d3b:	83 c4 0c             	add    $0xc,%esp
    1d3e:	8b 1d 44 29 00 00    	mov    0x2944,%ebx
    1d44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d47:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d4a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d4d:	6b c0 32             	imul   $0x32,%eax,%eax
    1d50:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d53:	8b 45 08             	mov    0x8(%ebp),%eax
    1d56:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d59:	83 ec 0c             	sub    $0xc,%esp
    1d5c:	83 ec 04             	sub    $0x4,%esp
    1d5f:	89 e0                	mov    %esp,%eax
    1d61:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d65:	66 89 30             	mov    %si,(%eax)
    1d68:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d6c:	88 50 02             	mov    %dl,0x2(%eax)
    1d6f:	6a 32                	push   $0x32
    1d71:	6a 32                	push   $0x32
    1d73:	6a 00                	push   $0x0
    1d75:	6a 00                	push   $0x0
    1d77:	53                   	push   %ebx
    1d78:	51                   	push   %ecx
    1d79:	ff 75 94             	pushl  -0x6c(%ebp)
    1d7c:	57                   	push   %edi
    1d7d:	e8 6a f4 ff ff       	call   11ec <APDcCopy>
    1d82:	83 c4 30             	add    $0x30,%esp
                    break;
    1d85:	eb 5c                	jmp    1de3 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d87:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d8a:	6a 0c                	push   $0xc
    1d8c:	6a 0c                	push   $0xc
    1d8e:	6a 0c                	push   $0xc
    1d90:	50                   	push   %eax
    1d91:	e8 fa f5 ff ff       	call   1390 <RGB>
    1d96:	83 c4 0c             	add    $0xc,%esp
    1d99:	8b 1d 60 29 00 00    	mov    0x2960,%ebx
    1d9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1da2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1da5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1da8:	6b c0 32             	imul   $0x32,%eax,%eax
    1dab:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dae:	8b 45 08             	mov    0x8(%ebp),%eax
    1db1:	8d 78 3c             	lea    0x3c(%eax),%edi
    1db4:	83 ec 0c             	sub    $0xc,%esp
    1db7:	83 ec 04             	sub    $0x4,%esp
    1dba:	89 e0                	mov    %esp,%eax
    1dbc:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1dc0:	66 89 30             	mov    %si,(%eax)
    1dc3:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1dc7:	88 50 02             	mov    %dl,0x2(%eax)
    1dca:	6a 32                	push   $0x32
    1dcc:	6a 32                	push   $0x32
    1dce:	6a 00                	push   $0x0
    1dd0:	6a 00                	push   $0x0
    1dd2:	53                   	push   %ebx
    1dd3:	51                   	push   %ecx
    1dd4:	ff 75 94             	pushl  -0x6c(%ebp)
    1dd7:	57                   	push   %edi
    1dd8:	e8 0f f4 ff ff       	call   11ec <APDcCopy>
    1ddd:	83 c4 30             	add    $0x30,%esp
                    break;
    1de0:	eb 01                	jmp    1de3 <APGridPaint+0x639>
                default: break;
    1de2:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1de3:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1de7:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1deb:	0f 8e 7a fc ff ff    	jle    1a6b <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1df1:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1df5:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1df9:	0f 8e 60 fc ff ff    	jle    1a5f <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1dff:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e02:	68 cd 00 00 00       	push   $0xcd
    1e07:	6a 74                	push   $0x74
    1e09:	6a 18                	push   $0x18
    1e0b:	50                   	push   %eax
    1e0c:	e8 7f f5 ff ff       	call   1390 <RGB>
    1e11:	83 c4 0c             	add    $0xc,%esp
    1e14:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e18:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e1c:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e20:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e23:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e2a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e2d:	68 cd 00 00 00       	push   $0xcd
    1e32:	6a 74                	push   $0x74
    1e34:	6a 18                	push   $0x18
    1e36:	50                   	push   %eax
    1e37:	e8 54 f5 ff ff       	call   1390 <RGB>
    1e3c:	83 c4 0c             	add    $0xc,%esp
    1e3f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e43:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e47:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e4b:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e51:	8d 50 58             	lea    0x58(%eax),%edx
    1e54:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e57:	ff 75 bc             	pushl  -0x44(%ebp)
    1e5a:	ff 75 b8             	pushl  -0x48(%ebp)
    1e5d:	52                   	push   %edx
    1e5e:	50                   	push   %eax
    1e5f:	e8 5c ed ff ff       	call   bc0 <APSetPen>
    1e64:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e67:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6a:	8d 58 58             	lea    0x58(%eax),%ebx
    1e6d:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e70:	83 ec 04             	sub    $0x4,%esp
    1e73:	83 ec 04             	sub    $0x4,%esp
    1e76:	89 e0                	mov    %esp,%eax
    1e78:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e7c:	66 89 08             	mov    %cx,(%eax)
    1e7f:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e83:	88 48 02             	mov    %cl,0x2(%eax)
    1e86:	53                   	push   %ebx
    1e87:	52                   	push   %edx
    1e88:	e8 6c ed ff ff       	call   bf9 <APSetBrush>
    1e8d:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e90:	8b 45 08             	mov    0x8(%ebp),%eax
    1e93:	83 c0 58             	add    $0x58,%eax
    1e96:	83 ec 0c             	sub    $0xc,%esp
    1e99:	6a 32                	push   $0x32
    1e9b:	68 20 03 00 00       	push   $0x320
    1ea0:	6a 00                	push   $0x0
    1ea2:	6a 00                	push   $0x0
    1ea4:	50                   	push   %eax
    1ea5:	e8 37 f1 ff ff       	call   fe1 <APDrawRect>
    1eaa:	83 c4 20             	add    $0x20,%esp
}
    1ead:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1eb0:	5b                   	pop    %ebx
    1eb1:	5e                   	pop    %esi
    1eb2:	5f                   	pop    %edi
    1eb3:	5d                   	pop    %ebp
    1eb4:	c3                   	ret    

00001eb5 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1eb5:	55                   	push   %ebp
    1eb6:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1eb8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1ebc:	7e 08                	jle    1ec6 <random+0x11>
{
rand_num = seed;
    1ebe:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec1:	a3 1c 29 00 00       	mov    %eax,0x291c
}
rand_num *= 3;
    1ec6:	8b 15 1c 29 00 00    	mov    0x291c,%edx
    1ecc:	89 d0                	mov    %edx,%eax
    1ece:	01 c0                	add    %eax,%eax
    1ed0:	01 d0                	add    %edx,%eax
    1ed2:	a3 1c 29 00 00       	mov    %eax,0x291c
if (rand_num < 0)
    1ed7:	a1 1c 29 00 00       	mov    0x291c,%eax
    1edc:	85 c0                	test   %eax,%eax
    1ede:	79 0c                	jns    1eec <random+0x37>
{
rand_num *= (-1);
    1ee0:	a1 1c 29 00 00       	mov    0x291c,%eax
    1ee5:	f7 d8                	neg    %eax
    1ee7:	a3 1c 29 00 00       	mov    %eax,0x291c
}
return rand_num % 997;
    1eec:	8b 0d 1c 29 00 00    	mov    0x291c,%ecx
    1ef2:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1ef7:	89 c8                	mov    %ecx,%eax
    1ef9:	f7 ea                	imul   %edx
    1efb:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1efe:	c1 f8 09             	sar    $0x9,%eax
    1f01:	89 c2                	mov    %eax,%edx
    1f03:	89 c8                	mov    %ecx,%eax
    1f05:	c1 f8 1f             	sar    $0x1f,%eax
    1f08:	29 c2                	sub    %eax,%edx
    1f0a:	89 d0                	mov    %edx,%eax
    1f0c:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f12:	29 c1                	sub    %eax,%ecx
    1f14:	89 c8                	mov    %ecx,%eax
}
    1f16:	5d                   	pop    %ebp
    1f17:	c3                   	ret    

00001f18 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f18:	55                   	push   %ebp
    1f19:	89 e5                	mov    %esp,%ebp
    1f1b:	53                   	push   %ebx
    1f1c:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f1f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f26:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f2a:	74 17                	je     1f43 <sprintint+0x2b>
    1f2c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f30:	79 11                	jns    1f43 <sprintint+0x2b>
        neg = 1;
    1f32:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f39:	8b 45 10             	mov    0x10(%ebp),%eax
    1f3c:	f7 d8                	neg    %eax
    1f3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f41:	eb 06                	jmp    1f49 <sprintint+0x31>
    } else {
        x = xx;
    1f43:	8b 45 10             	mov    0x10(%ebp),%eax
    1f46:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f49:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f50:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f53:	8d 41 01             	lea    0x1(%ecx),%eax
    1f56:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f59:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f5f:	ba 00 00 00 00       	mov    $0x0,%edx
    1f64:	f7 f3                	div    %ebx
    1f66:	89 d0                	mov    %edx,%eax
    1f68:	0f b6 80 20 29 00 00 	movzbl 0x2920(%eax),%eax
    1f6f:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f73:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f76:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f79:	ba 00 00 00 00       	mov    $0x0,%edx
    1f7e:	f7 f3                	div    %ebx
    1f80:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f83:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f87:	75 c7                	jne    1f50 <sprintint+0x38>
    if(neg)
    1f89:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f8d:	74 0e                	je     1f9d <sprintint+0x85>
        buf[i++] = '-';
    1f8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f92:	8d 50 01             	lea    0x1(%eax),%edx
    1f95:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f98:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fa0:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1fa3:	eb 1b                	jmp    1fc0 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fa8:	8b 00                	mov    (%eax),%eax
    1faa:	8d 48 01             	lea    0x1(%eax),%ecx
    1fad:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fb0:	89 0a                	mov    %ecx,(%edx)
    1fb2:	89 c2                	mov    %eax,%edx
    1fb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb7:	01 d0                	add    %edx,%eax
    1fb9:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fbc:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1fc0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fc4:	7f df                	jg     1fa5 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fc6:	eb 21                	jmp    1fe9 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fcb:	8b 00                	mov    (%eax),%eax
    1fcd:	8d 48 01             	lea    0x1(%eax),%ecx
    1fd0:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fd3:	89 0a                	mov    %ecx,(%edx)
    1fd5:	89 c2                	mov    %eax,%edx
    1fd7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fda:	01 c2                	add    %eax,%edx
    1fdc:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fdf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fe2:	01 c8                	add    %ecx,%eax
    1fe4:	0f b6 00             	movzbl (%eax),%eax
    1fe7:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fe9:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fed:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1ff1:	79 d5                	jns    1fc8 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1ff3:	90                   	nop
    1ff4:	83 c4 20             	add    $0x20,%esp
    1ff7:	5b                   	pop    %ebx
    1ff8:	5d                   	pop    %ebp
    1ff9:	c3                   	ret    

00001ffa <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1ffa:	55                   	push   %ebp
    1ffb:	89 e5                	mov    %esp,%ebp
    1ffd:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2000:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2007:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    200e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2015:	8d 45 0c             	lea    0xc(%ebp),%eax
    2018:	83 c0 04             	add    $0x4,%eax
    201b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    201e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2025:	e9 d9 01 00 00       	jmp    2203 <sprintf+0x209>
        c = fmt[i] & 0xff;
    202a:	8b 55 0c             	mov    0xc(%ebp),%edx
    202d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2030:	01 d0                	add    %edx,%eax
    2032:	0f b6 00             	movzbl (%eax),%eax
    2035:	0f be c0             	movsbl %al,%eax
    2038:	25 ff 00 00 00       	and    $0xff,%eax
    203d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2040:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2044:	75 2c                	jne    2072 <sprintf+0x78>
            if(c == '%'){
    2046:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    204a:	75 0c                	jne    2058 <sprintf+0x5e>
                state = '%';
    204c:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2053:	e9 a7 01 00 00       	jmp    21ff <sprintf+0x205>
            } else {
                dst[j++] = c;
    2058:	8b 45 c8             	mov    -0x38(%ebp),%eax
    205b:	8d 50 01             	lea    0x1(%eax),%edx
    205e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2061:	89 c2                	mov    %eax,%edx
    2063:	8b 45 08             	mov    0x8(%ebp),%eax
    2066:	01 d0                	add    %edx,%eax
    2068:	8b 55 e0             	mov    -0x20(%ebp),%edx
    206b:	88 10                	mov    %dl,(%eax)
    206d:	e9 8d 01 00 00       	jmp    21ff <sprintf+0x205>
            }
        } else if(state == '%'){
    2072:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2076:	0f 85 83 01 00 00    	jne    21ff <sprintf+0x205>
            if(c == 'd'){
    207c:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2080:	75 4c                	jne    20ce <sprintf+0xd4>
                buf[bi] = '\0';
    2082:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2085:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2088:	01 d0                	add    %edx,%eax
    208a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    208d:	83 ec 0c             	sub    $0xc,%esp
    2090:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2093:	50                   	push   %eax
    2094:	e8 91 e1 ff ff       	call   22a <atoi>
    2099:	83 c4 10             	add    $0x10,%esp
    209c:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    209f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    20a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20a9:	8b 00                	mov    (%eax),%eax
    20ab:	83 ec 08             	sub    $0x8,%esp
    20ae:	ff 75 d8             	pushl  -0x28(%ebp)
    20b1:	6a 01                	push   $0x1
    20b3:	6a 0a                	push   $0xa
    20b5:	50                   	push   %eax
    20b6:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20b9:	50                   	push   %eax
    20ba:	ff 75 08             	pushl  0x8(%ebp)
    20bd:	e8 56 fe ff ff       	call   1f18 <sprintint>
    20c2:	83 c4 20             	add    $0x20,%esp
                ap++;
    20c5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20c9:	e9 2a 01 00 00       	jmp    21f8 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20ce:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20d2:	74 06                	je     20da <sprintf+0xe0>
    20d4:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20d8:	75 4c                	jne    2126 <sprintf+0x12c>
                buf[bi] = '\0';
    20da:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20e0:	01 d0                	add    %edx,%eax
    20e2:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20e5:	83 ec 0c             	sub    $0xc,%esp
    20e8:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20eb:	50                   	push   %eax
    20ec:	e8 39 e1 ff ff       	call   22a <atoi>
    20f1:	83 c4 10             	add    $0x10,%esp
    20f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2101:	8b 00                	mov    (%eax),%eax
    2103:	83 ec 08             	sub    $0x8,%esp
    2106:	ff 75 dc             	pushl  -0x24(%ebp)
    2109:	6a 00                	push   $0x0
    210b:	6a 10                	push   $0x10
    210d:	50                   	push   %eax
    210e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2111:	50                   	push   %eax
    2112:	ff 75 08             	pushl  0x8(%ebp)
    2115:	e8 fe fd ff ff       	call   1f18 <sprintint>
    211a:	83 c4 20             	add    $0x20,%esp
                ap++;
    211d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2121:	e9 d2 00 00 00       	jmp    21f8 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2126:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    212a:	75 46                	jne    2172 <sprintf+0x178>
                s = (char*)*ap;
    212c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    212f:	8b 00                	mov    (%eax),%eax
    2131:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2134:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2138:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    213c:	75 25                	jne    2163 <sprintf+0x169>
                    s = "(null)";
    213e:	c7 45 f4 a8 23 00 00 	movl   $0x23a8,-0xc(%ebp)
                while(*s != 0){
    2145:	eb 1c                	jmp    2163 <sprintf+0x169>
                    dst[j++] = *s;
    2147:	8b 45 c8             	mov    -0x38(%ebp),%eax
    214a:	8d 50 01             	lea    0x1(%eax),%edx
    214d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2150:	89 c2                	mov    %eax,%edx
    2152:	8b 45 08             	mov    0x8(%ebp),%eax
    2155:	01 c2                	add    %eax,%edx
    2157:	8b 45 f4             	mov    -0xc(%ebp),%eax
    215a:	0f b6 00             	movzbl (%eax),%eax
    215d:	88 02                	mov    %al,(%edx)
                    s++;
    215f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2163:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2166:	0f b6 00             	movzbl (%eax),%eax
    2169:	84 c0                	test   %al,%al
    216b:	75 da                	jne    2147 <sprintf+0x14d>
    216d:	e9 86 00 00 00       	jmp    21f8 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2172:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2176:	75 1d                	jne    2195 <sprintf+0x19b>
                dst[j++] = *ap;
    2178:	8b 45 c8             	mov    -0x38(%ebp),%eax
    217b:	8d 50 01             	lea    0x1(%eax),%edx
    217e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2181:	89 c2                	mov    %eax,%edx
    2183:	8b 45 08             	mov    0x8(%ebp),%eax
    2186:	01 c2                	add    %eax,%edx
    2188:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    218b:	8b 00                	mov    (%eax),%eax
    218d:	88 02                	mov    %al,(%edx)
                ap++;
    218f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2193:	eb 63                	jmp    21f8 <sprintf+0x1fe>
            } else if(c == '%'){
    2195:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2199:	75 17                	jne    21b2 <sprintf+0x1b8>
                dst[j++] = c;
    219b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219e:	8d 50 01             	lea    0x1(%eax),%edx
    21a1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a4:	89 c2                	mov    %eax,%edx
    21a6:	8b 45 08             	mov    0x8(%ebp),%eax
    21a9:	01 d0                	add    %edx,%eax
    21ab:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21ae:	88 10                	mov    %dl,(%eax)
    21b0:	eb 46                	jmp    21f8 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21b2:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21b6:	7e 18                	jle    21d0 <sprintf+0x1d6>
    21b8:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21bc:	7f 12                	jg     21d0 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21c1:	8d 50 01             	lea    0x1(%eax),%edx
    21c4:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21ca:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21ce:	eb 2f                	jmp    21ff <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21d0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21d3:	8d 50 01             	lea    0x1(%eax),%edx
    21d6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21d9:	89 c2                	mov    %eax,%edx
    21db:	8b 45 08             	mov    0x8(%ebp),%eax
    21de:	01 d0                	add    %edx,%eax
    21e0:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21e3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e6:	8d 50 01             	lea    0x1(%eax),%edx
    21e9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21ec:	89 c2                	mov    %eax,%edx
    21ee:	8b 45 08             	mov    0x8(%ebp),%eax
    21f1:	01 d0                	add    %edx,%eax
    21f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21f6:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21ff:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2203:	8b 55 0c             	mov    0xc(%ebp),%edx
    2206:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2209:	01 d0                	add    %edx,%eax
    220b:	0f b6 00             	movzbl (%eax),%eax
    220e:	84 c0                	test   %al,%al
    2210:	0f 85 14 fe ff ff    	jne    202a <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2216:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2219:	8d 50 01             	lea    0x1(%eax),%edx
    221c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    221f:	89 c2                	mov    %eax,%edx
    2221:	8b 45 08             	mov    0x8(%ebp),%eax
    2224:	01 d0                	add    %edx,%eax
    2226:	c6 00 00             	movb   $0x0,(%eax)
}
    2229:	90                   	nop
    222a:	c9                   	leave  
    222b:	c3                   	ret    
