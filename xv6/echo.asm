
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
      27:	ba a0 1e 00 00       	mov    $0x1ea0,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba a2 1e 00 00       	mov    $0x1ea2,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 a4 1e 00 00       	push   $0x1ea4
      4b:	6a 01                	push   $0x1
      4d:	e8 09 04 00 00       	call   45b <printf>
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

00000384 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     384:	55                   	push   %ebp
     385:	89 e5                	mov    %esp,%ebp
     387:	83 ec 18             	sub    $0x18,%esp
     38a:	8b 45 0c             	mov    0xc(%ebp),%eax
     38d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     390:	83 ec 04             	sub    $0x4,%esp
     393:	6a 01                	push   $0x1
     395:	8d 45 f4             	lea    -0xc(%ebp),%eax
     398:	50                   	push   %eax
     399:	ff 75 08             	pushl  0x8(%ebp)
     39c:	e8 3b ff ff ff       	call   2dc <write>
     3a1:	83 c4 10             	add    $0x10,%esp
}
     3a4:	90                   	nop
     3a5:	c9                   	leave  
     3a6:	c3                   	ret    

000003a7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3a7:	55                   	push   %ebp
     3a8:	89 e5                	mov    %esp,%ebp
     3aa:	53                   	push   %ebx
     3ab:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3b5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3b9:	74 17                	je     3d2 <printint+0x2b>
     3bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3bf:	79 11                	jns    3d2 <printint+0x2b>
    neg = 1;
     3c1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     3cb:	f7 d8                	neg    %eax
     3cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3d0:	eb 06                	jmp    3d8 <printint+0x31>
  } else {
    x = xx;
     3d2:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3df:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     3e2:	8d 41 01             	lea    0x1(%ecx),%eax
     3e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3e8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     3eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3ee:	ba 00 00 00 00       	mov    $0x0,%edx
     3f3:	f7 f3                	div    %ebx
     3f5:	89 d0                	mov    %edx,%eax
     3f7:	0f b6 80 18 25 00 00 	movzbl 0x2518(%eax),%eax
     3fe:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     402:	8b 5d 10             	mov    0x10(%ebp),%ebx
     405:	8b 45 ec             	mov    -0x14(%ebp),%eax
     408:	ba 00 00 00 00       	mov    $0x0,%edx
     40d:	f7 f3                	div    %ebx
     40f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     412:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     416:	75 c7                	jne    3df <printint+0x38>
  if(neg)
     418:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     41c:	74 2d                	je     44b <printint+0xa4>
    buf[i++] = '-';
     41e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     421:	8d 50 01             	lea    0x1(%eax),%edx
     424:	89 55 f4             	mov    %edx,-0xc(%ebp)
     427:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     42c:	eb 1d                	jmp    44b <printint+0xa4>
    putc(fd, buf[i]);
     42e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     431:	8b 45 f4             	mov    -0xc(%ebp),%eax
     434:	01 d0                	add    %edx,%eax
     436:	0f b6 00             	movzbl (%eax),%eax
     439:	0f be c0             	movsbl %al,%eax
     43c:	83 ec 08             	sub    $0x8,%esp
     43f:	50                   	push   %eax
     440:	ff 75 08             	pushl  0x8(%ebp)
     443:	e8 3c ff ff ff       	call   384 <putc>
     448:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     44b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     44f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     453:	79 d9                	jns    42e <printint+0x87>
    putc(fd, buf[i]);
}
     455:	90                   	nop
     456:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     459:	c9                   	leave  
     45a:	c3                   	ret    

0000045b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     45b:	55                   	push   %ebp
     45c:	89 e5                	mov    %esp,%ebp
     45e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     461:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     468:	8d 45 0c             	lea    0xc(%ebp),%eax
     46b:	83 c0 04             	add    $0x4,%eax
     46e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     471:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     478:	e9 59 01 00 00       	jmp    5d6 <printf+0x17b>
    c = fmt[i] & 0xff;
     47d:	8b 55 0c             	mov    0xc(%ebp),%edx
     480:	8b 45 f0             	mov    -0x10(%ebp),%eax
     483:	01 d0                	add    %edx,%eax
     485:	0f b6 00             	movzbl (%eax),%eax
     488:	0f be c0             	movsbl %al,%eax
     48b:	25 ff 00 00 00       	and    $0xff,%eax
     490:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     493:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     497:	75 2c                	jne    4c5 <printf+0x6a>
      if(c == '%'){
     499:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     49d:	75 0c                	jne    4ab <printf+0x50>
        state = '%';
     49f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4a6:	e9 27 01 00 00       	jmp    5d2 <printf+0x177>
      } else {
        putc(fd, c);
     4ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4ae:	0f be c0             	movsbl %al,%eax
     4b1:	83 ec 08             	sub    $0x8,%esp
     4b4:	50                   	push   %eax
     4b5:	ff 75 08             	pushl  0x8(%ebp)
     4b8:	e8 c7 fe ff ff       	call   384 <putc>
     4bd:	83 c4 10             	add    $0x10,%esp
     4c0:	e9 0d 01 00 00       	jmp    5d2 <printf+0x177>
      }
    } else if(state == '%'){
     4c5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4c9:	0f 85 03 01 00 00    	jne    5d2 <printf+0x177>
      if(c == 'd'){
     4cf:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4d3:	75 1e                	jne    4f3 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4d8:	8b 00                	mov    (%eax),%eax
     4da:	6a 01                	push   $0x1
     4dc:	6a 0a                	push   $0xa
     4de:	50                   	push   %eax
     4df:	ff 75 08             	pushl  0x8(%ebp)
     4e2:	e8 c0 fe ff ff       	call   3a7 <printint>
     4e7:	83 c4 10             	add    $0x10,%esp
        ap++;
     4ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4ee:	e9 d8 00 00 00       	jmp    5cb <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4f3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4f7:	74 06                	je     4ff <printf+0xa4>
     4f9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     4fd:	75 1e                	jne    51d <printf+0xc2>
        printint(fd, *ap, 16, 0);
     4ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
     502:	8b 00                	mov    (%eax),%eax
     504:	6a 00                	push   $0x0
     506:	6a 10                	push   $0x10
     508:	50                   	push   %eax
     509:	ff 75 08             	pushl  0x8(%ebp)
     50c:	e8 96 fe ff ff       	call   3a7 <printint>
     511:	83 c4 10             	add    $0x10,%esp
        ap++;
     514:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     518:	e9 ae 00 00 00       	jmp    5cb <printf+0x170>
      } else if(c == 's'){
     51d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     521:	75 43                	jne    566 <printf+0x10b>
        s = (char*)*ap;
     523:	8b 45 e8             	mov    -0x18(%ebp),%eax
     526:	8b 00                	mov    (%eax),%eax
     528:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     52b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     52f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     533:	75 25                	jne    55a <printf+0xff>
          s = "(null)";
     535:	c7 45 f4 a9 1e 00 00 	movl   $0x1ea9,-0xc(%ebp)
        while(*s != 0){
     53c:	eb 1c                	jmp    55a <printf+0xff>
          putc(fd, *s);
     53e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     541:	0f b6 00             	movzbl (%eax),%eax
     544:	0f be c0             	movsbl %al,%eax
     547:	83 ec 08             	sub    $0x8,%esp
     54a:	50                   	push   %eax
     54b:	ff 75 08             	pushl  0x8(%ebp)
     54e:	e8 31 fe ff ff       	call   384 <putc>
     553:	83 c4 10             	add    $0x10,%esp
          s++;
     556:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     55a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55d:	0f b6 00             	movzbl (%eax),%eax
     560:	84 c0                	test   %al,%al
     562:	75 da                	jne    53e <printf+0xe3>
     564:	eb 65                	jmp    5cb <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     566:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     56a:	75 1d                	jne    589 <printf+0x12e>
        putc(fd, *ap);
     56c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     56f:	8b 00                	mov    (%eax),%eax
     571:	0f be c0             	movsbl %al,%eax
     574:	83 ec 08             	sub    $0x8,%esp
     577:	50                   	push   %eax
     578:	ff 75 08             	pushl  0x8(%ebp)
     57b:	e8 04 fe ff ff       	call   384 <putc>
     580:	83 c4 10             	add    $0x10,%esp
        ap++;
     583:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     587:	eb 42                	jmp    5cb <printf+0x170>
      } else if(c == '%'){
     589:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     58d:	75 17                	jne    5a6 <printf+0x14b>
        putc(fd, c);
     58f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     592:	0f be c0             	movsbl %al,%eax
     595:	83 ec 08             	sub    $0x8,%esp
     598:	50                   	push   %eax
     599:	ff 75 08             	pushl  0x8(%ebp)
     59c:	e8 e3 fd ff ff       	call   384 <putc>
     5a1:	83 c4 10             	add    $0x10,%esp
     5a4:	eb 25                	jmp    5cb <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5a6:	83 ec 08             	sub    $0x8,%esp
     5a9:	6a 25                	push   $0x25
     5ab:	ff 75 08             	pushl  0x8(%ebp)
     5ae:	e8 d1 fd ff ff       	call   384 <putc>
     5b3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5b9:	0f be c0             	movsbl %al,%eax
     5bc:	83 ec 08             	sub    $0x8,%esp
     5bf:	50                   	push   %eax
     5c0:	ff 75 08             	pushl  0x8(%ebp)
     5c3:	e8 bc fd ff ff       	call   384 <putc>
     5c8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5d2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5d6:	8b 55 0c             	mov    0xc(%ebp),%edx
     5d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5dc:	01 d0                	add    %edx,%eax
     5de:	0f b6 00             	movzbl (%eax),%eax
     5e1:	84 c0                	test   %al,%al
     5e3:	0f 85 94 fe ff ff    	jne    47d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     5e9:	90                   	nop
     5ea:	c9                   	leave  
     5eb:	c3                   	ret    

000005ec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5ec:	55                   	push   %ebp
     5ed:	89 e5                	mov    %esp,%ebp
     5ef:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5f2:	8b 45 08             	mov    0x8(%ebp),%eax
     5f5:	83 e8 08             	sub    $0x8,%eax
     5f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5fb:	a1 48 25 00 00       	mov    0x2548,%eax
     600:	89 45 fc             	mov    %eax,-0x4(%ebp)
     603:	eb 24                	jmp    629 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     605:	8b 45 fc             	mov    -0x4(%ebp),%eax
     608:	8b 00                	mov    (%eax),%eax
     60a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     60d:	77 12                	ja     621 <free+0x35>
     60f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     612:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     615:	77 24                	ja     63b <free+0x4f>
     617:	8b 45 fc             	mov    -0x4(%ebp),%eax
     61a:	8b 00                	mov    (%eax),%eax
     61c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     61f:	77 1a                	ja     63b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     621:	8b 45 fc             	mov    -0x4(%ebp),%eax
     624:	8b 00                	mov    (%eax),%eax
     626:	89 45 fc             	mov    %eax,-0x4(%ebp)
     629:	8b 45 f8             	mov    -0x8(%ebp),%eax
     62c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62f:	76 d4                	jbe    605 <free+0x19>
     631:	8b 45 fc             	mov    -0x4(%ebp),%eax
     634:	8b 00                	mov    (%eax),%eax
     636:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     639:	76 ca                	jbe    605 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     63b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     63e:	8b 40 04             	mov    0x4(%eax),%eax
     641:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     648:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64b:	01 c2                	add    %eax,%edx
     64d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     650:	8b 00                	mov    (%eax),%eax
     652:	39 c2                	cmp    %eax,%edx
     654:	75 24                	jne    67a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     656:	8b 45 f8             	mov    -0x8(%ebp),%eax
     659:	8b 50 04             	mov    0x4(%eax),%edx
     65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65f:	8b 00                	mov    (%eax),%eax
     661:	8b 40 04             	mov    0x4(%eax),%eax
     664:	01 c2                	add    %eax,%edx
     666:	8b 45 f8             	mov    -0x8(%ebp),%eax
     669:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66f:	8b 00                	mov    (%eax),%eax
     671:	8b 10                	mov    (%eax),%edx
     673:	8b 45 f8             	mov    -0x8(%ebp),%eax
     676:	89 10                	mov    %edx,(%eax)
     678:	eb 0a                	jmp    684 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67d:	8b 10                	mov    (%eax),%edx
     67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     682:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     684:	8b 45 fc             	mov    -0x4(%ebp),%eax
     687:	8b 40 04             	mov    0x4(%eax),%eax
     68a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     691:	8b 45 fc             	mov    -0x4(%ebp),%eax
     694:	01 d0                	add    %edx,%eax
     696:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     699:	75 20                	jne    6bb <free+0xcf>
    p->s.size += bp->s.size;
     69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69e:	8b 50 04             	mov    0x4(%eax),%edx
     6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a4:	8b 40 04             	mov    0x4(%eax),%eax
     6a7:	01 c2                	add    %eax,%edx
     6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ac:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b2:	8b 10                	mov    (%eax),%edx
     6b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b7:	89 10                	mov    %edx,(%eax)
     6b9:	eb 08                	jmp    6c3 <free+0xd7>
  } else
    p->s.ptr = bp;
     6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6be:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6c1:	89 10                	mov    %edx,(%eax)
  freep = p;
     6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c6:	a3 48 25 00 00       	mov    %eax,0x2548
}
     6cb:	90                   	nop
     6cc:	c9                   	leave  
     6cd:	c3                   	ret    

000006ce <morecore>:

static Header*
morecore(uint nu)
{
     6ce:	55                   	push   %ebp
     6cf:	89 e5                	mov    %esp,%ebp
     6d1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6d4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6db:	77 07                	ja     6e4 <morecore+0x16>
    nu = 4096;
     6dd:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6e4:	8b 45 08             	mov    0x8(%ebp),%eax
     6e7:	c1 e0 03             	shl    $0x3,%eax
     6ea:	83 ec 0c             	sub    $0xc,%esp
     6ed:	50                   	push   %eax
     6ee:	e8 51 fc ff ff       	call   344 <sbrk>
     6f3:	83 c4 10             	add    $0x10,%esp
     6f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     6f9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6fd:	75 07                	jne    706 <morecore+0x38>
    return 0;
     6ff:	b8 00 00 00 00       	mov    $0x0,%eax
     704:	eb 26                	jmp    72c <morecore+0x5e>
  hp = (Header*)p;
     706:	8b 45 f4             	mov    -0xc(%ebp),%eax
     709:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     70c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     70f:	8b 55 08             	mov    0x8(%ebp),%edx
     712:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     715:	8b 45 f0             	mov    -0x10(%ebp),%eax
     718:	83 c0 08             	add    $0x8,%eax
     71b:	83 ec 0c             	sub    $0xc,%esp
     71e:	50                   	push   %eax
     71f:	e8 c8 fe ff ff       	call   5ec <free>
     724:	83 c4 10             	add    $0x10,%esp
  return freep;
     727:	a1 48 25 00 00       	mov    0x2548,%eax
}
     72c:	c9                   	leave  
     72d:	c3                   	ret    

0000072e <malloc>:

void*
malloc(uint nbytes)
{
     72e:	55                   	push   %ebp
     72f:	89 e5                	mov    %esp,%ebp
     731:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     734:	8b 45 08             	mov    0x8(%ebp),%eax
     737:	83 c0 07             	add    $0x7,%eax
     73a:	c1 e8 03             	shr    $0x3,%eax
     73d:	83 c0 01             	add    $0x1,%eax
     740:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     743:	a1 48 25 00 00       	mov    0x2548,%eax
     748:	89 45 f0             	mov    %eax,-0x10(%ebp)
     74b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     74f:	75 23                	jne    774 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     751:	c7 45 f0 40 25 00 00 	movl   $0x2540,-0x10(%ebp)
     758:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75b:	a3 48 25 00 00       	mov    %eax,0x2548
     760:	a1 48 25 00 00       	mov    0x2548,%eax
     765:	a3 40 25 00 00       	mov    %eax,0x2540
    base.s.size = 0;
     76a:	c7 05 44 25 00 00 00 	movl   $0x0,0x2544
     771:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     774:	8b 45 f0             	mov    -0x10(%ebp),%eax
     777:	8b 00                	mov    (%eax),%eax
     779:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     77c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77f:	8b 40 04             	mov    0x4(%eax),%eax
     782:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     785:	72 4d                	jb     7d4 <malloc+0xa6>
      if(p->s.size == nunits)
     787:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78a:	8b 40 04             	mov    0x4(%eax),%eax
     78d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     790:	75 0c                	jne    79e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     792:	8b 45 f4             	mov    -0xc(%ebp),%eax
     795:	8b 10                	mov    (%eax),%edx
     797:	8b 45 f0             	mov    -0x10(%ebp),%eax
     79a:	89 10                	mov    %edx,(%eax)
     79c:	eb 26                	jmp    7c4 <malloc+0x96>
      else {
        p->s.size -= nunits;
     79e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a1:	8b 40 04             	mov    0x4(%eax),%eax
     7a4:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7a7:	89 c2                	mov    %eax,%edx
     7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ac:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b2:	8b 40 04             	mov    0x4(%eax),%eax
     7b5:	c1 e0 03             	shl    $0x3,%eax
     7b8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7be:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7c1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c7:	a3 48 25 00 00       	mov    %eax,0x2548
      return (void*)(p + 1);
     7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cf:	83 c0 08             	add    $0x8,%eax
     7d2:	eb 3b                	jmp    80f <malloc+0xe1>
    }
    if(p == freep)
     7d4:	a1 48 25 00 00       	mov    0x2548,%eax
     7d9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7dc:	75 1e                	jne    7fc <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7de:	83 ec 0c             	sub    $0xc,%esp
     7e1:	ff 75 ec             	pushl  -0x14(%ebp)
     7e4:	e8 e5 fe ff ff       	call   6ce <morecore>
     7e9:	83 c4 10             	add    $0x10,%esp
     7ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7f3:	75 07                	jne    7fc <malloc+0xce>
        return 0;
     7f5:	b8 00 00 00 00       	mov    $0x0,%eax
     7fa:	eb 13                	jmp    80f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
     802:	8b 45 f4             	mov    -0xc(%ebp),%eax
     805:	8b 00                	mov    (%eax),%eax
     807:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     80a:	e9 6d ff ff ff       	jmp    77c <malloc+0x4e>
}
     80f:	c9                   	leave  
     810:	c3                   	ret    

00000811 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     811:	55                   	push   %ebp
     812:	89 e5                	mov    %esp,%ebp
     814:	83 ec 1c             	sub    $0x1c,%esp
     817:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     81a:	8b 55 10             	mov    0x10(%ebp),%edx
     81d:	8b 45 14             	mov    0x14(%ebp),%eax
     820:	88 4d ec             	mov    %cl,-0x14(%ebp)
     823:	88 55 e8             	mov    %dl,-0x18(%ebp)
     826:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     829:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     82d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     830:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     834:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     837:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     83b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     83e:	8b 45 08             	mov    0x8(%ebp),%eax
     841:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     845:	66 89 10             	mov    %dx,(%eax)
     848:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     84c:	88 50 02             	mov    %dl,0x2(%eax)
}
     84f:	8b 45 08             	mov    0x8(%ebp),%eax
     852:	c9                   	leave  
     853:	c2 04 00             	ret    $0x4

00000856 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     856:	55                   	push   %ebp
     857:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     859:	8b 45 08             	mov    0x8(%ebp),%eax
     85c:	2b 45 10             	sub    0x10(%ebp),%eax
     85f:	89 c2                	mov    %eax,%edx
     861:	8b 45 08             	mov    0x8(%ebp),%eax
     864:	2b 45 10             	sub    0x10(%ebp),%eax
     867:	0f af d0             	imul   %eax,%edx
     86a:	8b 45 0c             	mov    0xc(%ebp),%eax
     86d:	2b 45 14             	sub    0x14(%ebp),%eax
     870:	89 c1                	mov    %eax,%ecx
     872:	8b 45 0c             	mov    0xc(%ebp),%eax
     875:	2b 45 14             	sub    0x14(%ebp),%eax
     878:	0f af c1             	imul   %ecx,%eax
     87b:	01 d0                	add    %edx,%eax
}
     87d:	5d                   	pop    %ebp
     87e:	c3                   	ret    

0000087f <abs_int>:

static inline int abs_int(int x)
{
     87f:	55                   	push   %ebp
     880:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     882:	8b 45 08             	mov    0x8(%ebp),%eax
     885:	99                   	cltd   
     886:	89 d0                	mov    %edx,%eax
     888:	33 45 08             	xor    0x8(%ebp),%eax
     88b:	29 d0                	sub    %edx,%eax
}
     88d:	5d                   	pop    %ebp
     88e:	c3                   	ret    

0000088f <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     88f:	55                   	push   %ebp
     890:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     892:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     896:	79 07                	jns    89f <APGetIndex+0x10>
        return X_SMALLER;
     898:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     89d:	eb 40                	jmp    8df <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     89f:	8b 45 08             	mov    0x8(%ebp),%eax
     8a2:	8b 00                	mov    (%eax),%eax
     8a4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8a7:	7f 07                	jg     8b0 <APGetIndex+0x21>
        return X_BIGGER;
     8a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8ae:	eb 2f                	jmp    8df <APGetIndex+0x50>
    if (y < 0)
     8b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8b4:	79 07                	jns    8bd <APGetIndex+0x2e>
        return Y_SMALLER;
     8b6:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8bb:	eb 22                	jmp    8df <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8bd:	8b 45 08             	mov    0x8(%ebp),%eax
     8c0:	8b 40 04             	mov    0x4(%eax),%eax
     8c3:	3b 45 10             	cmp    0x10(%ebp),%eax
     8c6:	7f 07                	jg     8cf <APGetIndex+0x40>
        return Y_BIGGER;
     8c8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8cd:	eb 10                	jmp    8df <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8cf:	8b 45 08             	mov    0x8(%ebp),%eax
     8d2:	8b 00                	mov    (%eax),%eax
     8d4:	0f af 45 10          	imul   0x10(%ebp),%eax
     8d8:	89 c2                	mov    %eax,%edx
     8da:	8b 45 0c             	mov    0xc(%ebp),%eax
     8dd:	01 d0                	add    %edx,%eax
}
     8df:	5d                   	pop    %ebp
     8e0:	c3                   	ret    

000008e1 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     8e1:	55                   	push   %ebp
     8e2:	89 e5                	mov    %esp,%ebp
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8e9:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8f0:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8f3:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8f6:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     8fd:	83 ec 08             	sub    $0x8,%esp
     900:	6a 00                	push   $0x0
     902:	ff 75 0c             	pushl  0xc(%ebp)
     905:	e8 f2 f9 ff ff       	call   2fc <open>
     90a:	83 c4 10             	add    $0x10,%esp
     90d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     910:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     914:	79 2e                	jns    944 <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     916:	83 ec 04             	sub    $0x4,%esp
     919:	ff 75 0c             	pushl  0xc(%ebp)
     91c:	68 b0 1e 00 00       	push   $0x1eb0
     921:	6a 01                	push   $0x1
     923:	e8 33 fb ff ff       	call   45b <printf>
     928:	83 c4 10             	add    $0x10,%esp
        return bmp;
     92b:	8b 45 08             	mov    0x8(%ebp),%eax
     92e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     931:	89 10                	mov    %edx,(%eax)
     933:	8b 55 cc             	mov    -0x34(%ebp),%edx
     936:	89 50 04             	mov    %edx,0x4(%eax)
     939:	8b 55 d0             	mov    -0x30(%ebp),%edx
     93c:	89 50 08             	mov    %edx,0x8(%eax)
     93f:	e9 1b 02 00 00       	jmp    b5f <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     944:	83 ec 04             	sub    $0x4,%esp
     947:	6a 10                	push   $0x10
     949:	8d 45 b8             	lea    -0x48(%ebp),%eax
     94c:	50                   	push   %eax
     94d:	ff 75 ec             	pushl  -0x14(%ebp)
     950:	e8 7f f9 ff ff       	call   2d4 <read>
     955:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     958:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     95c:	0f b7 f0             	movzwl %ax,%esi
     95f:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     963:	0f b7 d8             	movzwl %ax,%ebx
     966:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     969:	8b 55 bc             	mov    -0x44(%ebp),%edx
     96c:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     970:	0f b7 c0             	movzwl %ax,%eax
     973:	83 ec 04             	sub    $0x4,%esp
     976:	56                   	push   %esi
     977:	53                   	push   %ebx
     978:	51                   	push   %ecx
     979:	52                   	push   %edx
     97a:	50                   	push   %eax
     97b:	68 c0 1e 00 00       	push   $0x1ec0
     980:	6a 01                	push   $0x1
     982:	e8 d4 fa ff ff       	call   45b <printf>
     987:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     98a:	83 ec 04             	sub    $0x4,%esp
     98d:	6a 28                	push   $0x28
     98f:	8d 45 90             	lea    -0x70(%ebp),%eax
     992:	50                   	push   %eax
     993:	ff 75 ec             	pushl  -0x14(%ebp)
     996:	e8 39 f9 ff ff       	call   2d4 <read>
     99b:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     99e:	8b 45 94             	mov    -0x6c(%ebp),%eax
     9a1:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     9a4:	8b 45 98             	mov    -0x68(%ebp),%eax
     9a7:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     9aa:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9b0:	52                   	push   %edx
     9b1:	50                   	push   %eax
     9b2:	68 d0 1e 00 00       	push   $0x1ed0
     9b7:	6a 01                	push   $0x1
     9b9:	e8 9d fa ff ff       	call   45b <printf>
     9be:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     9c1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9c4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9c7:	0f af d0             	imul   %eax,%edx
     9ca:	89 d0                	mov    %edx,%eax
     9cc:	01 c0                	add    %eax,%eax
     9ce:	01 d0                	add    %edx,%eax
     9d0:	83 ec 0c             	sub    $0xc,%esp
     9d3:	50                   	push   %eax
     9d4:	e8 55 fd ff ff       	call   72e <malloc>
     9d9:	83 c4 10             	add    $0x10,%esp
     9dc:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9df:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
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
     a11:	e8 18 fd ff ff       	call   72e <malloc>
     a16:	83 c4 10             	add    $0x10,%esp
     a19:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a1c:	83 ec 04             	sub    $0x4,%esp
     a1f:	ff 75 e0             	pushl  -0x20(%ebp)
     a22:	ff 75 dc             	pushl  -0x24(%ebp)
     a25:	ff 75 ec             	pushl  -0x14(%ebp)
     a28:	e8 a7 f8 ff ff       	call   2d4 <read>
     a2d:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a30:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     a34:	66 c1 e8 03          	shr    $0x3,%ax
     a38:	0f b7 c0             	movzwl %ax,%eax
     a3b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a45:	e9 e5 00 00 00       	jmp    b2f <APLoadBitmap+0x24e>
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
     a67:	e9 b1 00 00 00       	jmp    b1d <APLoadBitmap+0x23c>
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
     b25:	0f 87 41 ff ff ff    	ja     a6c <APLoadBitmap+0x18b>
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
     b37:	0f 87 0d ff ff ff    	ja     a4a <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b3d:	83 ec 0c             	sub    $0xc,%esp
     b40:	ff 75 ec             	pushl  -0x14(%ebp)
     b43:	e8 9c f7 ff ff       	call   2e4 <close>
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
     b62:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b65:	5b                   	pop    %ebx
     b66:	5e                   	pop    %esi
     b67:	5d                   	pop    %ebp
     b68:	c2 04 00             	ret    $0x4

00000b6b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b6b:	55                   	push   %ebp
     b6c:	89 e5                	mov    %esp,%ebp
     b6e:	53                   	push   %ebx
     b6f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b72:	83 ec 0c             	sub    $0xc,%esp
     b75:	6a 1c                	push   $0x1c
     b77:	e8 b2 fb ff ff       	call   72e <malloc>
     b7c:	83 c4 10             	add    $0x10,%esp
     b7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b85:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b8c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b8f:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b92:	6a 0c                	push   $0xc
     b94:	6a 0c                	push   $0xc
     b96:	6a 0c                	push   $0xc
     b98:	50                   	push   %eax
     b99:	e8 73 fc ff ff       	call   811 <RGB>
     b9e:	83 c4 0c             	add    $0xc,%esp
     ba1:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     ba5:	66 89 43 13          	mov    %ax,0x13(%ebx)
     ba9:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     bad:	88 43 15             	mov    %al,0x15(%ebx)
     bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bb6:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     bba:	66 89 48 10          	mov    %cx,0x10(%eax)
     bbe:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     bc2:	88 50 12             	mov    %dl,0x12(%eax)
     bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bcb:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     bcf:	66 89 48 08          	mov    %cx,0x8(%eax)
     bd3:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     bd7:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     bda:	8b 45 08             	mov    0x8(%ebp),%eax
     bdd:	89 c2                	mov    %eax,%edx
     bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     be4:	8b 45 0c             	mov    0xc(%ebp),%eax
     be7:	89 c2                	mov    %eax,%edx
     be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bec:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bef:	8b 55 10             	mov    0x10(%ebp),%edx
     bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bfb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bfe:	c9                   	leave  
     bff:	c3                   	ret    

00000c00 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c06:	8b 45 0c             	mov    0xc(%ebp),%eax
     c09:	8b 50 08             	mov    0x8(%eax),%edx
     c0c:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c0f:	8b 40 0c             	mov    0xc(%eax),%eax
     c12:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c15:	8b 45 0c             	mov    0xc(%ebp),%eax
     c18:	8b 55 10             	mov    0x10(%ebp),%edx
     c1b:	89 50 08             	mov    %edx,0x8(%eax)
     c1e:	8b 55 14             	mov    0x14(%ebp),%edx
     c21:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c24:	8b 45 08             	mov    0x8(%ebp),%eax
     c27:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c2a:	89 10                	mov    %edx,(%eax)
     c2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c2f:	89 50 04             	mov    %edx,0x4(%eax)
}
     c32:	8b 45 08             	mov    0x8(%ebp),%eax
     c35:	c9                   	leave  
     c36:	c2 04 00             	ret    $0x4

00000c39 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c39:	55                   	push   %ebp
     c3a:	89 e5                	mov    %esp,%ebp
     c3c:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c3f:	8b 45 0c             	mov    0xc(%ebp),%eax
     c42:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c46:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c4a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c4e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c51:	8b 45 0c             	mov    0xc(%ebp),%eax
     c54:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c58:	66 89 50 10          	mov    %dx,0x10(%eax)
     c5c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c60:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c63:	8b 45 08             	mov    0x8(%ebp),%eax
     c66:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c6a:	66 89 10             	mov    %dx,(%eax)
     c6d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c71:	88 50 02             	mov    %dl,0x2(%eax)
}
     c74:	8b 45 08             	mov    0x8(%ebp),%eax
     c77:	c9                   	leave  
     c78:	c2 04 00             	ret    $0x4

00000c7b <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c7b:	55                   	push   %ebp
     c7c:	89 e5                	mov    %esp,%ebp
     c7e:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c81:	8b 45 08             	mov    0x8(%ebp),%eax
     c84:	8b 40 0c             	mov    0xc(%eax),%eax
     c87:	89 c2                	mov    %eax,%edx
     c89:	c1 ea 1f             	shr    $0x1f,%edx
     c8c:	01 d0                	add    %edx,%eax
     c8e:	d1 f8                	sar    %eax
     c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c96:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c9d:	8b 45 10             	mov    0x10(%ebp),%eax
     ca0:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ca3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     ca6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     caa:	0f 89 98 00 00 00    	jns    d48 <APDrawPoint+0xcd>
        i = 0;
     cb0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cb7:	e9 8c 00 00 00       	jmp    d48 <APDrawPoint+0xcd>
    {
        j = x - off;
     cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbf:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cc2:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cc5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cc9:	79 69                	jns    d34 <APDrawPoint+0xb9>
            j = 0;
     ccb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cd2:	eb 60                	jmp    d34 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cd4:	ff 75 fc             	pushl  -0x4(%ebp)
     cd7:	ff 75 f8             	pushl  -0x8(%ebp)
     cda:	ff 75 08             	pushl  0x8(%ebp)
     cdd:	e8 ad fb ff ff       	call   88f <APGetIndex>
     ce2:	83 c4 0c             	add    $0xc,%esp
     ce5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     ce8:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cec:	74 55                	je     d43 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cee:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cf2:	74 67                	je     d5b <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cf4:	ff 75 10             	pushl  0x10(%ebp)
     cf7:	ff 75 0c             	pushl  0xc(%ebp)
     cfa:	ff 75 fc             	pushl  -0x4(%ebp)
     cfd:	ff 75 f8             	pushl  -0x8(%ebp)
     d00:	e8 51 fb ff ff       	call   856 <distance_2>
     d05:	83 c4 10             	add    $0x10,%esp
     d08:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d0b:	7f 23                	jg     d30 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d0d:	8b 45 08             	mov    0x8(%ebp),%eax
     d10:	8b 48 18             	mov    0x18(%eax),%ecx
     d13:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d16:	89 d0                	mov    %edx,%eax
     d18:	01 c0                	add    %eax,%eax
     d1a:	01 d0                	add    %edx,%eax
     d1c:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d1f:	8b 45 08             	mov    0x8(%ebp),%eax
     d22:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d26:	66 89 0a             	mov    %cx,(%edx)
     d29:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d2d:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d30:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d34:	8b 55 0c             	mov    0xc(%ebp),%edx
     d37:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d3a:	01 d0                	add    %edx,%eax
     d3c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d3f:	7d 93                	jge    cd4 <APDrawPoint+0x59>
     d41:	eb 01                	jmp    d44 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d43:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d44:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d48:	8b 55 10             	mov    0x10(%ebp),%edx
     d4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4e:	01 d0                	add    %edx,%eax
     d50:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d53:	0f 8d 63 ff ff ff    	jge    cbc <APDrawPoint+0x41>
     d59:	eb 01                	jmp    d5c <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d5b:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d5c:	c9                   	leave  
     d5d:	c3                   	ret    

00000d5e <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d5e:	55                   	push   %ebp
     d5f:	89 e5                	mov    %esp,%ebp
     d61:	53                   	push   %ebx
     d62:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d65:	8b 45 0c             	mov    0xc(%ebp),%eax
     d68:	3b 45 14             	cmp    0x14(%ebp),%eax
     d6b:	0f 85 80 00 00 00    	jne    df1 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d71:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d75:	0f 88 9d 02 00 00    	js     1018 <APDrawLine+0x2ba>
     d7b:	8b 45 08             	mov    0x8(%ebp),%eax
     d7e:	8b 00                	mov    (%eax),%eax
     d80:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d83:	0f 8e 8f 02 00 00    	jle    1018 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d89:	8b 45 10             	mov    0x10(%ebp),%eax
     d8c:	3b 45 18             	cmp    0x18(%ebp),%eax
     d8f:	7e 12                	jle    da3 <APDrawLine+0x45>
        {
            int tmp = y2;
     d91:	8b 45 18             	mov    0x18(%ebp),%eax
     d94:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d97:	8b 45 10             	mov    0x10(%ebp),%eax
     d9a:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d9d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     da0:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     da3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     da7:	79 07                	jns    db0 <APDrawLine+0x52>
     da9:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     db0:	8b 45 08             	mov    0x8(%ebp),%eax
     db3:	8b 40 04             	mov    0x4(%eax),%eax
     db6:	3b 45 18             	cmp    0x18(%ebp),%eax
     db9:	7d 0c                	jge    dc7 <APDrawLine+0x69>
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	8b 40 04             	mov    0x4(%eax),%eax
     dc1:	83 e8 01             	sub    $0x1,%eax
     dc4:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     dc7:	8b 45 10             	mov    0x10(%ebp),%eax
     dca:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dcd:	eb 15                	jmp    de4 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dcf:	ff 75 f4             	pushl  -0xc(%ebp)
     dd2:	ff 75 0c             	pushl  0xc(%ebp)
     dd5:	ff 75 08             	pushl  0x8(%ebp)
     dd8:	e8 9e fe ff ff       	call   c7b <APDrawPoint>
     ddd:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     de0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     de4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de7:	3b 45 18             	cmp    0x18(%ebp),%eax
     dea:	7e e3                	jle    dcf <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dec:	e9 2b 02 00 00       	jmp    101c <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     df1:	8b 45 10             	mov    0x10(%ebp),%eax
     df4:	3b 45 18             	cmp    0x18(%ebp),%eax
     df7:	75 7f                	jne    e78 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     df9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dfd:	0f 88 18 02 00 00    	js     101b <APDrawLine+0x2bd>
     e03:	8b 45 08             	mov    0x8(%ebp),%eax
     e06:	8b 40 04             	mov    0x4(%eax),%eax
     e09:	3b 45 10             	cmp    0x10(%ebp),%eax
     e0c:	0f 8e 09 02 00 00    	jle    101b <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e12:	8b 45 0c             	mov    0xc(%ebp),%eax
     e15:	3b 45 14             	cmp    0x14(%ebp),%eax
     e18:	7e 12                	jle    e2c <APDrawLine+0xce>
        {
            int tmp = x2;
     e1a:	8b 45 14             	mov    0x14(%ebp),%eax
     e1d:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e20:	8b 45 0c             	mov    0xc(%ebp),%eax
     e23:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e26:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e29:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e30:	79 07                	jns    e39 <APDrawLine+0xdb>
     e32:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e39:	8b 45 08             	mov    0x8(%ebp),%eax
     e3c:	8b 00                	mov    (%eax),%eax
     e3e:	3b 45 14             	cmp    0x14(%ebp),%eax
     e41:	7d 0b                	jge    e4e <APDrawLine+0xf0>
     e43:	8b 45 08             	mov    0x8(%ebp),%eax
     e46:	8b 00                	mov    (%eax),%eax
     e48:	83 e8 01             	sub    $0x1,%eax
     e4b:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e51:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e54:	eb 15                	jmp    e6b <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e56:	ff 75 10             	pushl  0x10(%ebp)
     e59:	ff 75 f0             	pushl  -0x10(%ebp)
     e5c:	ff 75 08             	pushl  0x8(%ebp)
     e5f:	e8 17 fe ff ff       	call   c7b <APDrawPoint>
     e64:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e67:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e6e:	3b 45 14             	cmp    0x14(%ebp),%eax
     e71:	7e e3                	jle    e56 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e73:	e9 a4 01 00 00       	jmp    101c <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e7f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e86:	8b 45 0c             	mov    0xc(%ebp),%eax
     e89:	2b 45 14             	sub    0x14(%ebp),%eax
     e8c:	50                   	push   %eax
     e8d:	e8 ed f9 ff ff       	call   87f <abs_int>
     e92:	83 c4 04             	add    $0x4,%esp
     e95:	89 c3                	mov    %eax,%ebx
     e97:	8b 45 10             	mov    0x10(%ebp),%eax
     e9a:	2b 45 18             	sub    0x18(%ebp),%eax
     e9d:	50                   	push   %eax
     e9e:	e8 dc f9 ff ff       	call   87f <abs_int>
     ea3:	83 c4 04             	add    $0x4,%esp
     ea6:	39 c3                	cmp    %eax,%ebx
     ea8:	0f 8e b5 00 00 00    	jle    f63 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     eae:	8b 45 10             	mov    0x10(%ebp),%eax
     eb1:	2b 45 18             	sub    0x18(%ebp),%eax
     eb4:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eb7:	db 45 b0             	fildl  -0x50(%ebp)
     eba:	8b 45 0c             	mov    0xc(%ebp),%eax
     ebd:	2b 45 14             	sub    0x14(%ebp),%eax
     ec0:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ec3:	db 45 b0             	fildl  -0x50(%ebp)
     ec6:	de f9                	fdivrp %st,%st(1)
     ec8:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     ecb:	8b 45 14             	mov    0x14(%ebp),%eax
     ece:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ed1:	7e 0e                	jle    ee1 <APDrawLine+0x183>
        {
            s = x1;
     ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     ed9:	8b 45 14             	mov    0x14(%ebp),%eax
     edc:	89 45 e8             	mov    %eax,-0x18(%ebp)
     edf:	eb 0c                	jmp    eed <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ee1:	8b 45 14             	mov    0x14(%ebp),%eax
     ee4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ee7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eea:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ef1:	79 07                	jns    efa <APDrawLine+0x19c>
     ef3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     efa:	8b 45 08             	mov    0x8(%ebp),%eax
     efd:	8b 00                	mov    (%eax),%eax
     eff:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f02:	7f 0b                	jg     f0f <APDrawLine+0x1b1>
     f04:	8b 45 08             	mov    0x8(%ebp),%eax
     f07:	8b 00                	mov    (%eax),%eax
     f09:	83 e8 01             	sub    $0x1,%eax
     f0c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f15:	eb 3f                	jmp    f56 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f1a:	2b 45 0c             	sub    0xc(%ebp),%eax
     f1d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f20:	db 45 b0             	fildl  -0x50(%ebp)
     f23:	dc 4d d0             	fmull  -0x30(%ebp)
     f26:	db 45 10             	fildl  0x10(%ebp)
     f29:	de c1                	faddp  %st,%st(1)
     f2b:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f2e:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f32:	b4 0c                	mov    $0xc,%ah
     f34:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f38:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f3b:	db 5d cc             	fistpl -0x34(%ebp)
     f3e:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f41:	ff 75 cc             	pushl  -0x34(%ebp)
     f44:	ff 75 e4             	pushl  -0x1c(%ebp)
     f47:	ff 75 08             	pushl  0x8(%ebp)
     f4a:	e8 2c fd ff ff       	call   c7b <APDrawPoint>
     f4f:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f52:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f59:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f5c:	7e b9                	jle    f17 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f5e:	e9 b9 00 00 00       	jmp    101c <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f63:	8b 45 0c             	mov    0xc(%ebp),%eax
     f66:	2b 45 14             	sub    0x14(%ebp),%eax
     f69:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f6c:	db 45 b0             	fildl  -0x50(%ebp)
     f6f:	8b 45 10             	mov    0x10(%ebp),%eax
     f72:	2b 45 18             	sub    0x18(%ebp),%eax
     f75:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f78:	db 45 b0             	fildl  -0x50(%ebp)
     f7b:	de f9                	fdivrp %st,%st(1)
     f7d:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f80:	8b 45 10             	mov    0x10(%ebp),%eax
     f83:	3b 45 18             	cmp    0x18(%ebp),%eax
     f86:	7e 0e                	jle    f96 <APDrawLine+0x238>
    {
        s = y2;
     f88:	8b 45 18             	mov    0x18(%ebp),%eax
     f8b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f8e:	8b 45 10             	mov    0x10(%ebp),%eax
     f91:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f94:	eb 0c                	jmp    fa2 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f96:	8b 45 10             	mov    0x10(%ebp),%eax
     f99:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f9c:	8b 45 18             	mov    0x18(%ebp),%eax
     f9f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fa2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fa6:	79 07                	jns    faf <APDrawLine+0x251>
     fa8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     faf:	8b 45 08             	mov    0x8(%ebp),%eax
     fb2:	8b 40 04             	mov    0x4(%eax),%eax
     fb5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fb8:	7f 0c                	jg     fc6 <APDrawLine+0x268>
     fba:	8b 45 08             	mov    0x8(%ebp),%eax
     fbd:	8b 40 04             	mov    0x4(%eax),%eax
     fc0:	83 e8 01             	sub    $0x1,%eax
     fc3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fc9:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fcc:	eb 3f                	jmp    100d <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fce:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fd1:	2b 45 10             	sub    0x10(%ebp),%eax
     fd4:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fd7:	db 45 b0             	fildl  -0x50(%ebp)
     fda:	dc 4d c0             	fmull  -0x40(%ebp)
     fdd:	db 45 0c             	fildl  0xc(%ebp)
     fe0:	de c1                	faddp  %st,%st(1)
     fe2:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fe5:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fe9:	b4 0c                	mov    $0xc,%ah
     feb:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fef:	d9 6d b4             	fldcw  -0x4c(%ebp)
     ff2:	db 5d bc             	fistpl -0x44(%ebp)
     ff5:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     ff8:	ff 75 e0             	pushl  -0x20(%ebp)
     ffb:	ff 75 bc             	pushl  -0x44(%ebp)
     ffe:	ff 75 08             	pushl  0x8(%ebp)
    1001:	e8 75 fc ff ff       	call   c7b <APDrawPoint>
    1006:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1009:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    100d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1010:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1013:	7e b9                	jle    fce <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1015:	90                   	nop
    1016:	eb 04                	jmp    101c <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1018:	90                   	nop
    1019:	eb 01                	jmp    101c <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    101b:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    101c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    101f:	c9                   	leave  
    1020:	c3                   	ret    

00001021 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1021:	55                   	push   %ebp
    1022:	89 e5                	mov    %esp,%ebp
    1024:	53                   	push   %ebx
    1025:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1028:	8b 55 10             	mov    0x10(%ebp),%edx
    102b:	8b 45 18             	mov    0x18(%ebp),%eax
    102e:	01 d0                	add    %edx,%eax
    1030:	83 e8 01             	sub    $0x1,%eax
    1033:	83 ec 04             	sub    $0x4,%esp
    1036:	50                   	push   %eax
    1037:	ff 75 0c             	pushl  0xc(%ebp)
    103a:	ff 75 10             	pushl  0x10(%ebp)
    103d:	ff 75 0c             	pushl  0xc(%ebp)
    1040:	ff 75 08             	pushl  0x8(%ebp)
    1043:	e8 16 fd ff ff       	call   d5e <APDrawLine>
    1048:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    104b:	8b 55 0c             	mov    0xc(%ebp),%edx
    104e:	8b 45 14             	mov    0x14(%ebp),%eax
    1051:	01 d0                	add    %edx,%eax
    1053:	83 e8 01             	sub    $0x1,%eax
    1056:	83 ec 04             	sub    $0x4,%esp
    1059:	ff 75 10             	pushl  0x10(%ebp)
    105c:	50                   	push   %eax
    105d:	ff 75 10             	pushl  0x10(%ebp)
    1060:	ff 75 0c             	pushl  0xc(%ebp)
    1063:	ff 75 08             	pushl  0x8(%ebp)
    1066:	e8 f3 fc ff ff       	call   d5e <APDrawLine>
    106b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    106e:	8b 55 10             	mov    0x10(%ebp),%edx
    1071:	8b 45 18             	mov    0x18(%ebp),%eax
    1074:	01 d0                	add    %edx,%eax
    1076:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1079:	8b 55 0c             	mov    0xc(%ebp),%edx
    107c:	8b 45 14             	mov    0x14(%ebp),%eax
    107f:	01 d0                	add    %edx,%eax
    1081:	8d 50 ff             	lea    -0x1(%eax),%edx
    1084:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1087:	8b 45 14             	mov    0x14(%ebp),%eax
    108a:	01 d8                	add    %ebx,%eax
    108c:	83 e8 01             	sub    $0x1,%eax
    108f:	83 ec 04             	sub    $0x4,%esp
    1092:	51                   	push   %ecx
    1093:	52                   	push   %edx
    1094:	ff 75 10             	pushl  0x10(%ebp)
    1097:	50                   	push   %eax
    1098:	ff 75 08             	pushl  0x8(%ebp)
    109b:	e8 be fc ff ff       	call   d5e <APDrawLine>
    10a0:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10a3:	8b 55 10             	mov    0x10(%ebp),%edx
    10a6:	8b 45 18             	mov    0x18(%ebp),%eax
    10a9:	01 d0                	add    %edx,%eax
    10ab:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10ae:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b1:	8b 45 14             	mov    0x14(%ebp),%eax
    10b4:	01 d0                	add    %edx,%eax
    10b6:	8d 50 ff             	lea    -0x1(%eax),%edx
    10b9:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10bc:	8b 45 18             	mov    0x18(%ebp),%eax
    10bf:	01 d8                	add    %ebx,%eax
    10c1:	83 e8 01             	sub    $0x1,%eax
    10c4:	83 ec 04             	sub    $0x4,%esp
    10c7:	51                   	push   %ecx
    10c8:	52                   	push   %edx
    10c9:	50                   	push   %eax
    10ca:	ff 75 0c             	pushl  0xc(%ebp)
    10cd:	ff 75 08             	pushl  0x8(%ebp)
    10d0:	e8 89 fc ff ff       	call   d5e <APDrawLine>
    10d5:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10d8:	8b 55 0c             	mov    0xc(%ebp),%edx
    10db:	8b 45 14             	mov    0x14(%ebp),%eax
    10de:	01 d0                	add    %edx,%eax
    10e0:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e3:	8b 45 08             	mov    0x8(%ebp),%eax
    10e6:	8b 40 0c             	mov    0xc(%eax),%eax
    10e9:	89 c1                	mov    %eax,%ecx
    10eb:	c1 e9 1f             	shr    $0x1f,%ecx
    10ee:	01 c8                	add    %ecx,%eax
    10f0:	d1 f8                	sar    %eax
    10f2:	29 c2                	sub    %eax,%edx
    10f4:	89 d0                	mov    %edx,%eax
    10f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10f9:	8b 55 10             	mov    0x10(%ebp),%edx
    10fc:	8b 45 18             	mov    0x18(%ebp),%eax
    10ff:	01 d0                	add    %edx,%eax
    1101:	8d 50 ff             	lea    -0x1(%eax),%edx
    1104:	8b 45 08             	mov    0x8(%ebp),%eax
    1107:	8b 40 0c             	mov    0xc(%eax),%eax
    110a:	89 c1                	mov    %eax,%ecx
    110c:	c1 e9 1f             	shr    $0x1f,%ecx
    110f:	01 c8                	add    %ecx,%eax
    1111:	d1 f8                	sar    %eax
    1113:	29 c2                	sub    %eax,%edx
    1115:	89 d0                	mov    %edx,%eax
    1117:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    111a:	8b 45 08             	mov    0x8(%ebp),%eax
    111d:	8b 40 0c             	mov    0xc(%eax),%eax
    1120:	89 c2                	mov    %eax,%edx
    1122:	c1 ea 1f             	shr    $0x1f,%edx
    1125:	01 d0                	add    %edx,%eax
    1127:	d1 f8                	sar    %eax
    1129:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    112c:	8b 45 08             	mov    0x8(%ebp),%eax
    112f:	8b 40 0c             	mov    0xc(%eax),%eax
    1132:	89 c2                	mov    %eax,%edx
    1134:	c1 ea 1f             	shr    $0x1f,%edx
    1137:	01 d0                	add    %edx,%eax
    1139:	d1 f8                	sar    %eax
    113b:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    113e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1142:	0f 88 d8 00 00 00    	js     1220 <APDrawRect+0x1ff>
    1148:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    114c:	0f 88 ce 00 00 00    	js     1220 <APDrawRect+0x1ff>
    1152:	8b 45 08             	mov    0x8(%ebp),%eax
    1155:	8b 00                	mov    (%eax),%eax
    1157:	3b 45 0c             	cmp    0xc(%ebp),%eax
    115a:	0f 8e c0 00 00 00    	jle    1220 <APDrawRect+0x1ff>
    1160:	8b 45 08             	mov    0x8(%ebp),%eax
    1163:	8b 40 04             	mov    0x4(%eax),%eax
    1166:	3b 45 10             	cmp    0x10(%ebp),%eax
    1169:	0f 8e b1 00 00 00    	jle    1220 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    116f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1173:	79 07                	jns    117c <APDrawRect+0x15b>
    1175:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    117c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1180:	79 07                	jns    1189 <APDrawRect+0x168>
    1182:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1189:	8b 45 08             	mov    0x8(%ebp),%eax
    118c:	8b 00                	mov    (%eax),%eax
    118e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1191:	7f 0b                	jg     119e <APDrawRect+0x17d>
    1193:	8b 45 08             	mov    0x8(%ebp),%eax
    1196:	8b 00                	mov    (%eax),%eax
    1198:	83 e8 01             	sub    $0x1,%eax
    119b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    119e:	8b 45 08             	mov    0x8(%ebp),%eax
    11a1:	8b 40 04             	mov    0x4(%eax),%eax
    11a4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11a7:	7f 0c                	jg     11b5 <APDrawRect+0x194>
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	8b 40 04             	mov    0x4(%eax),%eax
    11af:	83 e8 01             	sub    $0x1,%eax
    11b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11b5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    11bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11c2:	eb 52                	jmp    1216 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11c4:	8b 45 10             	mov    0x10(%ebp),%eax
    11c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11ca:	eb 3e                	jmp    120a <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11cc:	83 ec 04             	sub    $0x4,%esp
    11cf:	ff 75 e8             	pushl  -0x18(%ebp)
    11d2:	ff 75 ec             	pushl  -0x14(%ebp)
    11d5:	ff 75 08             	pushl  0x8(%ebp)
    11d8:	e8 b2 f6 ff ff       	call   88f <APGetIndex>
    11dd:	83 c4 10             	add    $0x10,%esp
    11e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	8b 48 18             	mov    0x18(%eax),%ecx
    11e9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11ec:	89 d0                	mov    %edx,%eax
    11ee:	01 c0                	add    %eax,%eax
    11f0:	01 d0                	add    %edx,%eax
    11f2:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11fc:	66 89 0a             	mov    %cx,(%edx)
    11ff:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1203:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1206:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    120a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    120d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1210:	7e ba                	jle    11cc <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1212:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1216:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1219:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    121c:	7e a6                	jle    11c4 <APDrawRect+0x1a3>
    121e:	eb 01                	jmp    1221 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1220:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1221:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1224:	c9                   	leave  
    1225:	c3                   	ret    

00001226 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1226:	55                   	push   %ebp
    1227:	89 e5                	mov    %esp,%ebp
    1229:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    122c:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1230:	0f 88 8e 01 00 00    	js     13c4 <APDcCopy+0x19e>
    1236:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    123a:	0f 88 84 01 00 00    	js     13c4 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1240:	8b 55 0c             	mov    0xc(%ebp),%edx
    1243:	8b 45 20             	mov    0x20(%ebp),%eax
    1246:	01 d0                	add    %edx,%eax
    1248:	89 45 fc             	mov    %eax,-0x4(%ebp)
    124b:	8b 55 10             	mov    0x10(%ebp),%edx
    124e:	8b 45 24             	mov    0x24(%ebp),%eax
    1251:	01 d0                	add    %edx,%eax
    1253:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1256:	8b 55 18             	mov    0x18(%ebp),%edx
    1259:	8b 45 20             	mov    0x20(%ebp),%eax
    125c:	01 d0                	add    %edx,%eax
    125e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1261:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1264:	8b 45 24             	mov    0x24(%ebp),%eax
    1267:	01 d0                	add    %edx,%eax
    1269:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    126c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1270:	0f 88 51 01 00 00    	js     13c7 <APDcCopy+0x1a1>
    1276:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    127a:	0f 88 47 01 00 00    	js     13c7 <APDcCopy+0x1a1>
    1280:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1284:	0f 88 3d 01 00 00    	js     13c7 <APDcCopy+0x1a1>
    128a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    128e:	0f 88 33 01 00 00    	js     13c7 <APDcCopy+0x1a1>
    1294:	8b 45 14             	mov    0x14(%ebp),%eax
    1297:	8b 00                	mov    (%eax),%eax
    1299:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    129c:	0f 8e 25 01 00 00    	jle    13c7 <APDcCopy+0x1a1>
    12a2:	8b 45 14             	mov    0x14(%ebp),%eax
    12a5:	8b 40 04             	mov    0x4(%eax),%eax
    12a8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12ab:	0f 8e 16 01 00 00    	jle    13c7 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    12b1:	8b 45 08             	mov    0x8(%ebp),%eax
    12b4:	8b 00                	mov    (%eax),%eax
    12b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    12b9:	7d 0b                	jge    12c6 <APDcCopy+0xa0>
    12bb:	8b 45 08             	mov    0x8(%ebp),%eax
    12be:	8b 00                	mov    (%eax),%eax
    12c0:	83 e8 01             	sub    $0x1,%eax
    12c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    12c6:	8b 45 08             	mov    0x8(%ebp),%eax
    12c9:	8b 40 04             	mov    0x4(%eax),%eax
    12cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    12cf:	7d 0c                	jge    12dd <APDcCopy+0xb7>
    12d1:	8b 45 08             	mov    0x8(%ebp),%eax
    12d4:	8b 40 04             	mov    0x4(%eax),%eax
    12d7:	83 e8 01             	sub    $0x1,%eax
    12da:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    12dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    12e4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    12eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12f2:	e9 bc 00 00 00       	jmp    13b3 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12f7:	8b 45 08             	mov    0x8(%ebp),%eax
    12fa:	8b 00                	mov    (%eax),%eax
    12fc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12ff:	8b 55 10             	mov    0x10(%ebp),%edx
    1302:	01 ca                	add    %ecx,%edx
    1304:	0f af d0             	imul   %eax,%edx
    1307:	8b 45 0c             	mov    0xc(%ebp),%eax
    130a:	01 d0                	add    %edx,%eax
    130c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    130f:	8b 45 14             	mov    0x14(%ebp),%eax
    1312:	8b 00                	mov    (%eax),%eax
    1314:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1317:	8b 55 1c             	mov    0x1c(%ebp),%edx
    131a:	01 ca                	add    %ecx,%edx
    131c:	0f af d0             	imul   %eax,%edx
    131f:	8b 45 18             	mov    0x18(%ebp),%eax
    1322:	01 d0                	add    %edx,%eax
    1324:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    1327:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    132e:	eb 74                	jmp    13a4 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1330:	8b 45 14             	mov    0x14(%ebp),%eax
    1333:	8b 50 18             	mov    0x18(%eax),%edx
    1336:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1339:	8b 45 f0             	mov    -0x10(%ebp),%eax
    133c:	01 c8                	add    %ecx,%eax
    133e:	89 c1                	mov    %eax,%ecx
    1340:	89 c8                	mov    %ecx,%eax
    1342:	01 c0                	add    %eax,%eax
    1344:	01 c8                	add    %ecx,%eax
    1346:	01 d0                	add    %edx,%eax
    1348:	0f b7 10             	movzwl (%eax),%edx
    134b:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    134f:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1353:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1356:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    135a:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    135e:	38 c2                	cmp    %al,%dl
    1360:	75 18                	jne    137a <APDcCopy+0x154>
    1362:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1366:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    136a:	38 c2                	cmp    %al,%dl
    136c:	75 0c                	jne    137a <APDcCopy+0x154>
    136e:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1372:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1376:	38 c2                	cmp    %al,%dl
    1378:	74 26                	je     13a0 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    137a:	8b 45 08             	mov    0x8(%ebp),%eax
    137d:	8b 50 18             	mov    0x18(%eax),%edx
    1380:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1383:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1386:	01 c8                	add    %ecx,%eax
    1388:	89 c1                	mov    %eax,%ecx
    138a:	89 c8                	mov    %ecx,%eax
    138c:	01 c0                	add    %eax,%eax
    138e:	01 c8                	add    %ecx,%eax
    1390:	01 d0                	add    %edx,%eax
    1392:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1396:	66 89 10             	mov    %dx,(%eax)
    1399:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    139d:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    13a0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13a7:	2b 45 0c             	sub    0xc(%ebp),%eax
    13aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    13ad:	7f 81                	jg     1330 <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    13af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13b6:	2b 45 10             	sub    0x10(%ebp),%eax
    13b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    13bc:	0f 8f 35 ff ff ff    	jg     12f7 <APDcCopy+0xd1>
    13c2:	eb 04                	jmp    13c8 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    13c4:	90                   	nop
    13c5:	eb 01                	jmp    13c8 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    13c7:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    13c8:	c9                   	leave  
    13c9:	c3                   	ret    

000013ca <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    13ca:	55                   	push   %ebp
    13cb:	89 e5                	mov    %esp,%ebp
    13cd:	83 ec 1c             	sub    $0x1c,%esp
    13d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    13d3:	8b 55 10             	mov    0x10(%ebp),%edx
    13d6:	8b 45 14             	mov    0x14(%ebp),%eax
    13d9:	88 4d ec             	mov    %cl,-0x14(%ebp)
    13dc:	88 55 e8             	mov    %dl,-0x18(%ebp)
    13df:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    13e2:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    13e6:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    13e9:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13ed:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13f0:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13f4:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13f7:	8b 45 08             	mov    0x8(%ebp),%eax
    13fa:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13fe:	66 89 10             	mov    %dx,(%eax)
    1401:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1405:	88 50 02             	mov    %dl,0x2(%eax)
}
    1408:	8b 45 08             	mov    0x8(%ebp),%eax
    140b:	c9                   	leave  
    140c:	c2 04 00             	ret    $0x4

0000140f <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    140f:	55                   	push   %ebp
    1410:	89 e5                	mov    %esp,%ebp
    1412:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1415:	8b 45 08             	mov    0x8(%ebp),%eax
    1418:	8b 00                	mov    (%eax),%eax
    141a:	83 ec 08             	sub    $0x8,%esp
    141d:	8d 55 0c             	lea    0xc(%ebp),%edx
    1420:	52                   	push   %edx
    1421:	50                   	push   %eax
    1422:	e8 45 ef ff ff       	call   36c <sendMessage>
    1427:	83 c4 10             	add    $0x10,%esp
}
    142a:	90                   	nop
    142b:	c9                   	leave  
    142c:	c3                   	ret    

0000142d <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    142d:	55                   	push   %ebp
    142e:	89 e5                	mov    %esp,%ebp
    1430:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1433:	83 ec 0c             	sub    $0xc,%esp
    1436:	68 90 00 00 00       	push   $0x90
    143b:	e8 ee f2 ff ff       	call   72e <malloc>
    1440:	83 c4 10             	add    $0x10,%esp
    1443:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1446:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    144a:	75 15                	jne    1461 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    144c:	83 ec 04             	sub    $0x4,%esp
    144f:	ff 75 08             	pushl  0x8(%ebp)
    1452:	68 f4 1e 00 00       	push   $0x1ef4
    1457:	6a 01                	push   $0x1
    1459:	e8 fd ef ff ff       	call   45b <printf>
    145e:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1461:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1464:	83 c0 7c             	add    $0x7c,%eax
    1467:	83 ec 08             	sub    $0x8,%esp
    146a:	ff 75 08             	pushl  0x8(%ebp)
    146d:	50                   	push   %eax
    146e:	e8 18 ec ff ff       	call   8b <strcpy>
    1473:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1476:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1479:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1480:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1483:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    148a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148d:	8b 40 34             	mov    0x34(%eax),%eax
    1490:	89 c2                	mov    %eax,%edx
    1492:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1495:	8b 40 38             	mov    0x38(%eax),%eax
    1498:	0f af d0             	imul   %eax,%edx
    149b:	89 d0                	mov    %edx,%eax
    149d:	01 c0                	add    %eax,%eax
    149f:	01 d0                	add    %edx,%eax
    14a1:	83 ec 0c             	sub    $0xc,%esp
    14a4:	50                   	push   %eax
    14a5:	e8 84 f2 ff ff       	call   72e <malloc>
    14aa:	83 c4 10             	add    $0x10,%esp
    14ad:	89 c2                	mov    %eax,%edx
    14af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b2:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    14b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b8:	8b 40 4c             	mov    0x4c(%eax),%eax
    14bb:	85 c0                	test   %eax,%eax
    14bd:	75 15                	jne    14d4 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    14bf:	83 ec 04             	sub    $0x4,%esp
    14c2:	ff 75 08             	pushl  0x8(%ebp)
    14c5:	68 14 1f 00 00       	push   $0x1f14
    14ca:	6a 01                	push   $0x1
    14cc:	e8 8a ef ff ff       	call   45b <printf>
    14d1:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d7:	8b 40 34             	mov    0x34(%eax),%eax
    14da:	89 c2                	mov    %eax,%edx
    14dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14df:	8b 40 38             	mov    0x38(%eax),%eax
    14e2:	0f af d0             	imul   %eax,%edx
    14e5:	89 d0                	mov    %edx,%eax
    14e7:	01 c0                	add    %eax,%eax
    14e9:	01 c2                	add    %eax,%edx
    14eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ee:	8b 40 4c             	mov    0x4c(%eax),%eax
    14f1:	83 ec 04             	sub    $0x4,%esp
    14f4:	52                   	push   %edx
    14f5:	68 ff ff ff 00       	push   $0xffffff
    14fa:	50                   	push   %eax
    14fb:	e8 21 ec ff ff       	call   121 <memset>
    1500:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1503:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1506:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    150d:	e8 2a ee ff ff       	call   33c <getpid>
    1512:	89 c2                	mov    %eax,%edx
    1514:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1517:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    151a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151d:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1524:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1527:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    152e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1531:	8b 40 50             	mov    0x50(%eax),%eax
    1534:	89 c2                	mov    %eax,%edx
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	8b 40 54             	mov    0x54(%eax),%eax
    153c:	0f af d0             	imul   %eax,%edx
    153f:	89 d0                	mov    %edx,%eax
    1541:	01 c0                	add    %eax,%eax
    1543:	01 d0                	add    %edx,%eax
    1545:	83 ec 0c             	sub    $0xc,%esp
    1548:	50                   	push   %eax
    1549:	e8 e0 f1 ff ff       	call   72e <malloc>
    154e:	83 c4 10             	add    $0x10,%esp
    1551:	89 c2                	mov    %eax,%edx
    1553:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1556:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1559:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155c:	8b 40 68             	mov    0x68(%eax),%eax
    155f:	85 c0                	test   %eax,%eax
    1561:	75 15                	jne    1578 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1563:	83 ec 04             	sub    $0x4,%esp
    1566:	ff 75 08             	pushl  0x8(%ebp)
    1569:	68 38 1f 00 00       	push   $0x1f38
    156e:	6a 01                	push   $0x1
    1570:	e8 e6 ee ff ff       	call   45b <printf>
    1575:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1578:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157b:	8b 40 34             	mov    0x34(%eax),%eax
    157e:	89 c2                	mov    %eax,%edx
    1580:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1583:	8b 40 38             	mov    0x38(%eax),%eax
    1586:	0f af d0             	imul   %eax,%edx
    1589:	89 d0                	mov    %edx,%eax
    158b:	01 c0                	add    %eax,%eax
    158d:	01 c2                	add    %eax,%edx
    158f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1592:	8b 40 4c             	mov    0x4c(%eax),%eax
    1595:	83 ec 04             	sub    $0x4,%esp
    1598:	52                   	push   %edx
    1599:	68 ff 00 00 00       	push   $0xff
    159e:	50                   	push   %eax
    159f:	e8 7d eb ff ff       	call   121 <memset>
    15a4:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    15a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15aa:	8b 55 0c             	mov    0xc(%ebp),%edx
    15ad:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    15b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    15b4:	74 35                	je     15eb <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    15b6:	8b 45 10             	mov    0x10(%ebp),%eax
    15b9:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    15bf:	83 ec 0c             	sub    $0xc,%esp
    15c2:	50                   	push   %eax
    15c3:	e8 66 f1 ff ff       	call   72e <malloc>
    15c8:	83 c4 10             	add    $0x10,%esp
    15cb:	89 c2                	mov    %eax,%edx
    15cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d0:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    15d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d6:	8b 55 10             	mov    0x10(%ebp),%edx
    15d9:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    15e6:	e9 8d 00 00 00       	jmp    1678 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ee:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f8:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1602:	8b 40 18             	mov    0x18(%eax),%eax
    1605:	89 c2                	mov    %eax,%edx
    1607:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160a:	8b 40 1c             	mov    0x1c(%eax),%eax
    160d:	0f af d0             	imul   %eax,%edx
    1610:	89 d0                	mov    %edx,%eax
    1612:	01 c0                	add    %eax,%eax
    1614:	01 d0                	add    %edx,%eax
    1616:	83 ec 0c             	sub    $0xc,%esp
    1619:	50                   	push   %eax
    161a:	e8 0f f1 ff ff       	call   72e <malloc>
    161f:	83 c4 10             	add    $0x10,%esp
    1622:	89 c2                	mov    %eax,%edx
    1624:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1627:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	8b 40 30             	mov    0x30(%eax),%eax
    1630:	85 c0                	test   %eax,%eax
    1632:	75 15                	jne    1649 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1634:	83 ec 04             	sub    $0x4,%esp
    1637:	ff 75 08             	pushl  0x8(%ebp)
    163a:	68 60 1f 00 00       	push   $0x1f60
    163f:	6a 01                	push   $0x1
    1641:	e8 15 ee ff ff       	call   45b <printf>
    1646:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	8b 40 18             	mov    0x18(%eax),%eax
    164f:	89 c2                	mov    %eax,%edx
    1651:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1654:	8b 40 1c             	mov    0x1c(%eax),%eax
    1657:	0f af d0             	imul   %eax,%edx
    165a:	89 d0                	mov    %edx,%eax
    165c:	01 c0                	add    %eax,%eax
    165e:	01 c2                	add    %eax,%edx
    1660:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1663:	8b 40 30             	mov    0x30(%eax),%eax
    1666:	83 ec 04             	sub    $0x4,%esp
    1669:	52                   	push   %edx
    166a:	68 ff ff ff 00       	push   $0xffffff
    166f:	50                   	push   %eax
    1670:	e8 ac ea ff ff       	call   121 <memset>
    1675:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1678:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    167b:	c9                   	leave  
    167c:	c3                   	ret    

0000167d <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    167d:	55                   	push   %ebp
    167e:	89 e5                	mov    %esp,%ebp
    1680:	53                   	push   %ebx
    1681:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1684:	8b 45 0c             	mov    0xc(%ebp),%eax
    1687:	83 f8 03             	cmp    $0x3,%eax
    168a:	74 02                	je     168e <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    168c:	eb 33                	jmp    16c1 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    168e:	8b 45 08             	mov    0x8(%ebp),%eax
    1691:	8b 48 08             	mov    0x8(%eax),%ecx
    1694:	8b 45 08             	mov    0x8(%ebp),%eax
    1697:	8b 50 38             	mov    0x38(%eax),%edx
    169a:	8b 45 08             	mov    0x8(%ebp),%eax
    169d:	8b 40 34             	mov    0x34(%eax),%eax
    16a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16a3:	83 c3 34             	add    $0x34,%ebx
    16a6:	83 ec 0c             	sub    $0xc,%esp
    16a9:	51                   	push   %ecx
    16aa:	52                   	push   %edx
    16ab:	50                   	push   %eax
    16ac:	6a 00                	push   $0x0
    16ae:	6a 00                	push   $0x0
    16b0:	53                   	push   %ebx
    16b1:	6a 32                	push   $0x32
    16b3:	6a 00                	push   $0x0
    16b5:	ff 75 08             	pushl  0x8(%ebp)
    16b8:	e8 9f ec ff ff       	call   35c <paintWindow>
    16bd:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16c0:	90                   	nop
        default: break;
            
            
    }
    return False;
    16c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16c9:	c9                   	leave  
    16ca:	c3                   	ret    

000016cb <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16cb:	55                   	push   %ebp
    16cc:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d1:	8b 50 08             	mov    0x8(%eax),%edx
    16d4:	8b 45 08             	mov    0x8(%ebp),%eax
    16d7:	8b 00                	mov    (%eax),%eax
    16d9:	39 c2                	cmp    %eax,%edx
    16db:	74 07                	je     16e4 <APPreJudge+0x19>
        return False;
    16dd:	b8 00 00 00 00       	mov    $0x0,%eax
    16e2:	eb 05                	jmp    16e9 <APPreJudge+0x1e>
    return True;
    16e4:	b8 01 00 00 00       	mov    $0x1,%eax
}
    16e9:	5d                   	pop    %ebp
    16ea:	c3                   	ret    

000016eb <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    16eb:	55                   	push   %ebp
    16ec:	89 e5                	mov    %esp,%ebp
    16ee:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16f1:	8b 45 08             	mov    0x8(%ebp),%eax
    16f4:	8b 55 0c             	mov    0xc(%ebp),%edx
    16f7:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16fa:	83 ec 0c             	sub    $0xc,%esp
    16fd:	ff 75 08             	pushl  0x8(%ebp)
    1700:	e8 77 ec ff ff       	call   37c <registWindow>
    1705:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1708:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    170f:	8b 45 08             	mov    0x8(%ebp),%eax
    1712:	8b 00                	mov    (%eax),%eax
    1714:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1717:	ff 75 f4             	pushl  -0xc(%ebp)
    171a:	ff 75 f0             	pushl  -0x10(%ebp)
    171d:	ff 75 ec             	pushl  -0x14(%ebp)
    1720:	ff 75 08             	pushl  0x8(%ebp)
    1723:	e8 e7 fc ff ff       	call   140f <APSendMessage>
    1728:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    172b:	83 ec 0c             	sub    $0xc,%esp
    172e:	ff 75 08             	pushl  0x8(%ebp)
    1731:	e8 3e ec ff ff       	call   374 <getMessage>
    1736:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	83 c0 6c             	add    $0x6c,%eax
    173f:	83 ec 08             	sub    $0x8,%esp
    1742:	50                   	push   %eax
    1743:	ff 75 08             	pushl  0x8(%ebp)
    1746:	e8 80 ff ff ff       	call   16cb <APPreJudge>
    174b:	83 c4 10             	add    $0x10,%esp
    174e:	84 c0                	test   %al,%al
    1750:	74 1b                	je     176d <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1752:	8b 45 08             	mov    0x8(%ebp),%eax
    1755:	ff 70 74             	pushl  0x74(%eax)
    1758:	ff 70 70             	pushl  0x70(%eax)
    175b:	ff 70 6c             	pushl  0x6c(%eax)
    175e:	ff 75 08             	pushl  0x8(%ebp)
    1761:	8b 45 0c             	mov    0xc(%ebp),%eax
    1764:	ff d0                	call   *%eax
    1766:	83 c4 10             	add    $0x10,%esp
    1769:	84 c0                	test   %al,%al
    176b:	75 0c                	jne    1779 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    176d:	8b 45 08             	mov    0x8(%ebp),%eax
    1770:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1777:	eb b2                	jmp    172b <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1779:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    177a:	90                   	nop
    177b:	c9                   	leave  
    177c:	c3                   	ret    

0000177d <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    177d:	55                   	push   %ebp
    177e:	89 e5                	mov    %esp,%ebp
    1780:	57                   	push   %edi
    1781:	56                   	push   %esi
    1782:	53                   	push   %ebx
    1783:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1786:	a1 4c 25 00 00       	mov    0x254c,%eax
    178b:	85 c0                	test   %eax,%eax
    178d:	75 7c                	jne    180b <APGridPaint+0x8e>
    {
        iconReady = 1;
    178f:	c7 05 4c 25 00 00 01 	movl   $0x1,0x254c
    1796:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1799:	8d 45 b8             	lea    -0x48(%ebp),%eax
    179c:	83 ec 08             	sub    $0x8,%esp
    179f:	68 87 1f 00 00       	push   $0x1f87
    17a4:	50                   	push   %eax
    17a5:	e8 37 f1 ff ff       	call   8e1 <APLoadBitmap>
    17aa:	83 c4 0c             	add    $0xc,%esp
    17ad:	8b 45 b8             	mov    -0x48(%ebp),%eax
    17b0:	a3 50 25 00 00       	mov    %eax,0x2550
    17b5:	8b 45 bc             	mov    -0x44(%ebp),%eax
    17b8:	a3 54 25 00 00       	mov    %eax,0x2554
    17bd:	8b 45 c0             	mov    -0x40(%ebp),%eax
    17c0:	a3 58 25 00 00       	mov    %eax,0x2558
        printf(1,"bitmap loaded!\n");
    17c5:	83 ec 08             	sub    $0x8,%esp
    17c8:	68 91 1f 00 00       	push   $0x1f91
    17cd:	6a 01                	push   $0x1
    17cf:	e8 87 ec ff ff       	call   45b <printf>
    17d4:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17d7:	83 ec 04             	sub    $0x4,%esp
    17da:	ff 35 58 25 00 00    	pushl  0x2558
    17e0:	ff 35 54 25 00 00    	pushl  0x2554
    17e6:	ff 35 50 25 00 00    	pushl  0x2550
    17ec:	e8 7a f3 ff ff       	call   b6b <APCreateCompatibleDCFromBitmap>
    17f1:	83 c4 10             	add    $0x10,%esp
    17f4:	a3 5c 25 00 00       	mov    %eax,0x255c
        printf(1,"bitmap DC created!\n");
    17f9:	83 ec 08             	sub    $0x8,%esp
    17fc:	68 a1 1f 00 00       	push   $0x1fa1
    1801:	6a 01                	push   $0x1
    1803:	e8 53 ec ff ff       	call   45b <printf>
    1808:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    180b:	8b 45 08             	mov    0x8(%ebp),%eax
    180e:	8b 40 08             	mov    0x8(%eax),%eax
    1811:	85 c0                	test   %eax,%eax
    1813:	75 17                	jne    182c <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1815:	83 ec 08             	sub    $0x8,%esp
    1818:	68 b8 1f 00 00       	push   $0x1fb8
    181d:	6a 01                	push   $0x1
    181f:	e8 37 ec ff ff       	call   45b <printf>
    1824:	83 c4 10             	add    $0x10,%esp
        return;
    1827:	e9 55 03 00 00       	jmp    1b81 <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    182c:	8b 45 08             	mov    0x8(%ebp),%eax
    182f:	8b 40 10             	mov    0x10(%eax),%eax
    1832:	85 c0                	test   %eax,%eax
    1834:	7e 10                	jle    1846 <APGridPaint+0xc9>
    1836:	8b 45 08             	mov    0x8(%ebp),%eax
    1839:	8b 50 14             	mov    0x14(%eax),%edx
    183c:	8b 45 08             	mov    0x8(%ebp),%eax
    183f:	8b 40 10             	mov    0x10(%eax),%eax
    1842:	39 c2                	cmp    %eax,%edx
    1844:	7c 17                	jl     185d <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1846:	83 ec 08             	sub    $0x8,%esp
    1849:	68 de 1f 00 00       	push   $0x1fde
    184e:	6a 01                	push   $0x1
    1850:	e8 06 ec ff ff       	call   45b <printf>
    1855:	83 c4 10             	add    $0x10,%esp
        return;
    1858:	e9 24 03 00 00       	jmp    1b81 <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    185d:	8b 45 08             	mov    0x8(%ebp),%eax
    1860:	8b 40 14             	mov    0x14(%eax),%eax
    1863:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1869:	89 45 dc             	mov    %eax,-0x24(%ebp)
    186c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    186f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1872:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1879:	e9 f9 02 00 00       	jmp    1b77 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    187e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1885:	e9 df 02 00 00       	jmp    1b69 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    188a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    188d:	c1 e0 04             	shl    $0x4,%eax
    1890:	89 c2                	mov    %eax,%edx
    1892:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1895:	01 c2                	add    %eax,%edx
    1897:	8b 45 e0             	mov    -0x20(%ebp),%eax
    189a:	01 d0                	add    %edx,%eax
    189c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    189f:	8b 45 08             	mov    0x8(%ebp),%eax
    18a2:	8b 40 0c             	mov    0xc(%eax),%eax
    18a5:	8b 55 dc             	mov    -0x24(%ebp),%edx
    18a8:	c1 e2 02             	shl    $0x2,%edx
    18ab:	01 d0                	add    %edx,%eax
    18ad:	8b 00                	mov    (%eax),%eax
    18af:	83 f8 01             	cmp    $0x1,%eax
    18b2:	0f 84 83 00 00 00    	je     193b <APGridPaint+0x1be>
    18b8:	83 f8 01             	cmp    $0x1,%eax
    18bb:	7f 09                	jg     18c6 <APGridPaint+0x149>
    18bd:	85 c0                	test   %eax,%eax
    18bf:	74 1c                	je     18dd <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    18c1:	e9 9f 02 00 00       	jmp    1b65 <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    18c6:	83 f8 02             	cmp    $0x2,%eax
    18c9:	0f 84 20 01 00 00    	je     19ef <APGridPaint+0x272>
    18cf:	83 f8 03             	cmp    $0x3,%eax
    18d2:	0f 84 d1 01 00 00    	je     1aa9 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    18d8:	e9 88 02 00 00       	jmp    1b65 <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    18dd:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    18e0:	6a 0c                	push   $0xc
    18e2:	6a 0c                	push   $0xc
    18e4:	6a 0c                	push   $0xc
    18e6:	50                   	push   %eax
    18e7:	e8 de fa ff ff       	call   13ca <RGB>
    18ec:	83 c4 0c             	add    $0xc,%esp
    18ef:	8b 1d 5c 25 00 00    	mov    0x255c,%ebx
    18f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18f8:	6b c8 32             	imul   $0x32,%eax,%ecx
    18fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    18fe:	6b c0 32             	imul   $0x32,%eax,%eax
    1901:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    1904:	8b 45 08             	mov    0x8(%ebp),%eax
    1907:	8d 78 34             	lea    0x34(%eax),%edi
    190a:	83 ec 0c             	sub    $0xc,%esp
    190d:	83 ec 04             	sub    $0x4,%esp
    1910:	89 e0                	mov    %esp,%eax
    1912:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1916:	66 89 30             	mov    %si,(%eax)
    1919:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    191d:	88 50 02             	mov    %dl,0x2(%eax)
    1920:	6a 32                	push   $0x32
    1922:	6a 32                	push   $0x32
    1924:	6a 00                	push   $0x0
    1926:	6a 00                	push   $0x0
    1928:	53                   	push   %ebx
    1929:	51                   	push   %ecx
    192a:	ff 75 b4             	pushl  -0x4c(%ebp)
    192d:	57                   	push   %edi
    192e:	e8 f3 f8 ff ff       	call   1226 <APDcCopy>
    1933:	83 c4 30             	add    $0x30,%esp
                    break;
    1936:	e9 2a 02 00 00       	jmp    1b65 <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    193b:	8d 45 b8             	lea    -0x48(%ebp),%eax
    193e:	6a 69                	push   $0x69
    1940:	6a 69                	push   $0x69
    1942:	6a 69                	push   $0x69
    1944:	50                   	push   %eax
    1945:	e8 80 fa ff ff       	call   13ca <RGB>
    194a:	83 c4 0c             	add    $0xc,%esp
    194d:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1951:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1955:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1959:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    195c:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1963:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1966:	6a 69                	push   $0x69
    1968:	6a 69                	push   $0x69
    196a:	6a 69                	push   $0x69
    196c:	50                   	push   %eax
    196d:	e8 58 fa ff ff       	call   13ca <RGB>
    1972:	83 c4 0c             	add    $0xc,%esp
    1975:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1979:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    197d:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1981:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	8d 50 34             	lea    0x34(%eax),%edx
    198a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    198d:	ff 75 d0             	pushl  -0x30(%ebp)
    1990:	ff 75 cc             	pushl  -0x34(%ebp)
    1993:	52                   	push   %edx
    1994:	50                   	push   %eax
    1995:	e8 66 f2 ff ff       	call   c00 <APSetPen>
    199a:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    199d:	8b 45 08             	mov    0x8(%ebp),%eax
    19a0:	8d 58 34             	lea    0x34(%eax),%ebx
    19a3:	8d 55 b8             	lea    -0x48(%ebp),%edx
    19a6:	83 ec 04             	sub    $0x4,%esp
    19a9:	83 ec 04             	sub    $0x4,%esp
    19ac:	89 e0                	mov    %esp,%eax
    19ae:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    19b2:	66 89 08             	mov    %cx,(%eax)
    19b5:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    19b9:	88 48 02             	mov    %cl,0x2(%eax)
    19bc:	53                   	push   %ebx
    19bd:	52                   	push   %edx
    19be:	e8 76 f2 ff ff       	call   c39 <APSetBrush>
    19c3:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    19c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19c9:	6b d0 32             	imul   $0x32,%eax,%edx
    19cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19cf:	6b c0 32             	imul   $0x32,%eax,%eax
    19d2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19d5:	83 c1 34             	add    $0x34,%ecx
    19d8:	83 ec 0c             	sub    $0xc,%esp
    19db:	6a 32                	push   $0x32
    19dd:	6a 32                	push   $0x32
    19df:	52                   	push   %edx
    19e0:	50                   	push   %eax
    19e1:	51                   	push   %ecx
    19e2:	e8 3a f6 ff ff       	call   1021 <APDrawRect>
    19e7:	83 c4 20             	add    $0x20,%esp
                    break;
    19ea:	e9 76 01 00 00       	jmp    1b65 <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    19ef:	8d 45 b8             	lea    -0x48(%ebp),%eax
    19f2:	6a 00                	push   $0x0
    19f4:	68 80 00 00 00       	push   $0x80
    19f9:	6a 00                	push   $0x0
    19fb:	50                   	push   %eax
    19fc:	e8 c9 f9 ff ff       	call   13ca <RGB>
    1a01:	83 c4 0c             	add    $0xc,%esp
    1a04:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a08:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1a0c:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a10:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1a13:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1a1a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a1d:	6a 00                	push   $0x0
    1a1f:	68 80 00 00 00       	push   $0x80
    1a24:	6a 00                	push   $0x0
    1a26:	50                   	push   %eax
    1a27:	e8 9e f9 ff ff       	call   13ca <RGB>
    1a2c:	83 c4 0c             	add    $0xc,%esp
    1a2f:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a33:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1a37:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a3b:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	8d 50 34             	lea    0x34(%eax),%edx
    1a44:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a47:	ff 75 d0             	pushl  -0x30(%ebp)
    1a4a:	ff 75 cc             	pushl  -0x34(%ebp)
    1a4d:	52                   	push   %edx
    1a4e:	50                   	push   %eax
    1a4f:	e8 ac f1 ff ff       	call   c00 <APSetPen>
    1a54:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a57:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5a:	8d 58 34             	lea    0x34(%eax),%ebx
    1a5d:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a60:	83 ec 04             	sub    $0x4,%esp
    1a63:	83 ec 04             	sub    $0x4,%esp
    1a66:	89 e0                	mov    %esp,%eax
    1a68:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a6c:	66 89 08             	mov    %cx,(%eax)
    1a6f:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1a73:	88 48 02             	mov    %cl,0x2(%eax)
    1a76:	53                   	push   %ebx
    1a77:	52                   	push   %edx
    1a78:	e8 bc f1 ff ff       	call   c39 <APSetBrush>
    1a7d:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1a80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a83:	6b d0 32             	imul   $0x32,%eax,%edx
    1a86:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a89:	6b c0 32             	imul   $0x32,%eax,%eax
    1a8c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a8f:	83 c1 34             	add    $0x34,%ecx
    1a92:	83 ec 0c             	sub    $0xc,%esp
    1a95:	6a 32                	push   $0x32
    1a97:	6a 32                	push   $0x32
    1a99:	52                   	push   %edx
    1a9a:	50                   	push   %eax
    1a9b:	51                   	push   %ecx
    1a9c:	e8 80 f5 ff ff       	call   1021 <APDrawRect>
    1aa1:	83 c4 20             	add    $0x20,%esp
                    break;
    1aa4:	e9 bc 00 00 00       	jmp    1b65 <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1aa9:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1aac:	68 ff 00 00 00       	push   $0xff
    1ab1:	68 bf 00 00 00       	push   $0xbf
    1ab6:	6a 00                	push   $0x0
    1ab8:	50                   	push   %eax
    1ab9:	e8 0c f9 ff ff       	call   13ca <RGB>
    1abe:	83 c4 0c             	add    $0xc,%esp
    1ac1:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1ac5:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1ac9:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1acd:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1ad0:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1ad7:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ada:	68 ff 00 00 00       	push   $0xff
    1adf:	68 bf 00 00 00       	push   $0xbf
    1ae4:	6a 00                	push   $0x0
    1ae6:	50                   	push   %eax
    1ae7:	e8 de f8 ff ff       	call   13ca <RGB>
    1aec:	83 c4 0c             	add    $0xc,%esp
    1aef:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1af3:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1af7:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1afb:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1afe:	8b 45 08             	mov    0x8(%ebp),%eax
    1b01:	8d 50 34             	lea    0x34(%eax),%edx
    1b04:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b07:	ff 75 d0             	pushl  -0x30(%ebp)
    1b0a:	ff 75 cc             	pushl  -0x34(%ebp)
    1b0d:	52                   	push   %edx
    1b0e:	50                   	push   %eax
    1b0f:	e8 ec f0 ff ff       	call   c00 <APSetPen>
    1b14:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b17:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1a:	8d 58 34             	lea    0x34(%eax),%ebx
    1b1d:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1b20:	83 ec 04             	sub    $0x4,%esp
    1b23:	83 ec 04             	sub    $0x4,%esp
    1b26:	89 e0                	mov    %esp,%eax
    1b28:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b2c:	66 89 08             	mov    %cx,(%eax)
    1b2f:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b33:	88 48 02             	mov    %cl,0x2(%eax)
    1b36:	53                   	push   %ebx
    1b37:	52                   	push   %edx
    1b38:	e8 fc f0 ff ff       	call   c39 <APSetBrush>
    1b3d:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1b40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b43:	6b d0 32             	imul   $0x32,%eax,%edx
    1b46:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b49:	6b c0 32             	imul   $0x32,%eax,%eax
    1b4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b4f:	83 c1 34             	add    $0x34,%ecx
    1b52:	83 ec 0c             	sub    $0xc,%esp
    1b55:	6a 32                	push   $0x32
    1b57:	6a 32                	push   $0x32
    1b59:	52                   	push   %edx
    1b5a:	50                   	push   %eax
    1b5b:	51                   	push   %ecx
    1b5c:	e8 c0 f4 ff ff       	call   1021 <APDrawRect>
    1b61:	83 c4 20             	add    $0x20,%esp
                    break;
    1b64:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b65:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1b69:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1b6d:	0f 8e 17 fd ff ff    	jle    188a <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b73:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b77:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1b7b:	0f 8e fd fc ff ff    	jle    187e <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1b81:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b84:	5b                   	pop    %ebx
    1b85:	5e                   	pop    %esi
    1b86:	5f                   	pop    %edi
    1b87:	5d                   	pop    %ebp
    1b88:	c3                   	ret    

00001b89 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1b89:	55                   	push   %ebp
    1b8a:	89 e5                	mov    %esp,%ebp
    1b8c:	53                   	push   %ebx
    1b8d:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1b90:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1b97:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1b9b:	74 17                	je     1bb4 <sprintint+0x2b>
    1b9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1ba1:	79 11                	jns    1bb4 <sprintint+0x2b>
        neg = 1;
    1ba3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1baa:	8b 45 10             	mov    0x10(%ebp),%eax
    1bad:	f7 d8                	neg    %eax
    1baf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bb2:	eb 06                	jmp    1bba <sprintint+0x31>
    } else {
        x = xx;
    1bb4:	8b 45 10             	mov    0x10(%ebp),%eax
    1bb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1bba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1bc1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1bc4:	8d 41 01             	lea    0x1(%ecx),%eax
    1bc7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1bca:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1bcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bd0:	ba 00 00 00 00       	mov    $0x0,%edx
    1bd5:	f7 f3                	div    %ebx
    1bd7:	89 d0                	mov    %edx,%eax
    1bd9:	0f b6 80 2c 25 00 00 	movzbl 0x252c(%eax),%eax
    1be0:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1be4:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1be7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bea:	ba 00 00 00 00       	mov    $0x0,%edx
    1bef:	f7 f3                	div    %ebx
    1bf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bf4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bf8:	75 c7                	jne    1bc1 <sprintint+0x38>
    if(neg)
    1bfa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1bfe:	74 0e                	je     1c0e <sprintint+0x85>
        buf[i++] = '-';
    1c00:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c03:	8d 50 01             	lea    0x1(%eax),%edx
    1c06:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1c09:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1c0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c11:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1c14:	eb 1b                	jmp    1c31 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1c16:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c19:	8b 00                	mov    (%eax),%eax
    1c1b:	8d 48 01             	lea    0x1(%eax),%ecx
    1c1e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c21:	89 0a                	mov    %ecx,(%edx)
    1c23:	89 c2                	mov    %eax,%edx
    1c25:	8b 45 08             	mov    0x8(%ebp),%eax
    1c28:	01 d0                	add    %edx,%eax
    1c2a:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1c2d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1c31:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1c35:	7f df                	jg     1c16 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c37:	eb 21                	jmp    1c5a <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1c39:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c3c:	8b 00                	mov    (%eax),%eax
    1c3e:	8d 48 01             	lea    0x1(%eax),%ecx
    1c41:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c44:	89 0a                	mov    %ecx,(%edx)
    1c46:	89 c2                	mov    %eax,%edx
    1c48:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4b:	01 c2                	add    %eax,%edx
    1c4d:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1c50:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c53:	01 c8                	add    %ecx,%eax
    1c55:	0f b6 00             	movzbl (%eax),%eax
    1c58:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1c5a:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1c5e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1c62:	79 d5                	jns    1c39 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1c64:	90                   	nop
    1c65:	83 c4 20             	add    $0x20,%esp
    1c68:	5b                   	pop    %ebx
    1c69:	5d                   	pop    %ebp
    1c6a:	c3                   	ret    

00001c6b <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1c6b:	55                   	push   %ebp
    1c6c:	89 e5                	mov    %esp,%ebp
    1c6e:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1c71:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1c78:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1c7f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1c86:	8d 45 0c             	lea    0xc(%ebp),%eax
    1c89:	83 c0 04             	add    $0x4,%eax
    1c8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1c8f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1c96:	e9 d9 01 00 00       	jmp    1e74 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1c9b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ca1:	01 d0                	add    %edx,%eax
    1ca3:	0f b6 00             	movzbl (%eax),%eax
    1ca6:	0f be c0             	movsbl %al,%eax
    1ca9:	25 ff 00 00 00       	and    $0xff,%eax
    1cae:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1cb1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1cb5:	75 2c                	jne    1ce3 <sprintf+0x78>
            if(c == '%'){
    1cb7:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1cbb:	75 0c                	jne    1cc9 <sprintf+0x5e>
                state = '%';
    1cbd:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1cc4:	e9 a7 01 00 00       	jmp    1e70 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1cc9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ccc:	8d 50 01             	lea    0x1(%eax),%edx
    1ccf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1cd2:	89 c2                	mov    %eax,%edx
    1cd4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd7:	01 d0                	add    %edx,%eax
    1cd9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1cdc:	88 10                	mov    %dl,(%eax)
    1cde:	e9 8d 01 00 00       	jmp    1e70 <sprintf+0x205>
            }
        } else if(state == '%'){
    1ce3:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1ce7:	0f 85 83 01 00 00    	jne    1e70 <sprintf+0x205>
            if(c == 'd'){
    1ced:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1cf1:	75 4c                	jne    1d3f <sprintf+0xd4>
                buf[bi] = '\0';
    1cf3:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cf9:	01 d0                	add    %edx,%eax
    1cfb:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1cfe:	83 ec 0c             	sub    $0xc,%esp
    1d01:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d04:	50                   	push   %eax
    1d05:	e8 20 e5 ff ff       	call   22a <atoi>
    1d0a:	83 c4 10             	add    $0x10,%esp
    1d0d:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1d10:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1d17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d1a:	8b 00                	mov    (%eax),%eax
    1d1c:	83 ec 08             	sub    $0x8,%esp
    1d1f:	ff 75 d8             	pushl  -0x28(%ebp)
    1d22:	6a 01                	push   $0x1
    1d24:	6a 0a                	push   $0xa
    1d26:	50                   	push   %eax
    1d27:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d2a:	50                   	push   %eax
    1d2b:	ff 75 08             	pushl  0x8(%ebp)
    1d2e:	e8 56 fe ff ff       	call   1b89 <sprintint>
    1d33:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d36:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1d3a:	e9 2a 01 00 00       	jmp    1e69 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1d3f:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1d43:	74 06                	je     1d4b <sprintf+0xe0>
    1d45:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1d49:	75 4c                	jne    1d97 <sprintf+0x12c>
                buf[bi] = '\0';
    1d4b:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1d4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d51:	01 d0                	add    %edx,%eax
    1d53:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1d56:	83 ec 0c             	sub    $0xc,%esp
    1d59:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1d5c:	50                   	push   %eax
    1d5d:	e8 c8 e4 ff ff       	call   22a <atoi>
    1d62:	83 c4 10             	add    $0x10,%esp
    1d65:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1d68:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1d6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d72:	8b 00                	mov    (%eax),%eax
    1d74:	83 ec 08             	sub    $0x8,%esp
    1d77:	ff 75 dc             	pushl  -0x24(%ebp)
    1d7a:	6a 00                	push   $0x0
    1d7c:	6a 10                	push   $0x10
    1d7e:	50                   	push   %eax
    1d7f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1d82:	50                   	push   %eax
    1d83:	ff 75 08             	pushl  0x8(%ebp)
    1d86:	e8 fe fd ff ff       	call   1b89 <sprintint>
    1d8b:	83 c4 20             	add    $0x20,%esp
                ap++;
    1d8e:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1d92:	e9 d2 00 00 00       	jmp    1e69 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1d97:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1d9b:	75 46                	jne    1de3 <sprintf+0x178>
                s = (char*)*ap;
    1d9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1da0:	8b 00                	mov    (%eax),%eax
    1da2:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1da5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1da9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dad:	75 25                	jne    1dd4 <sprintf+0x169>
                    s = "(null)";
    1daf:	c7 45 f4 f4 1f 00 00 	movl   $0x1ff4,-0xc(%ebp)
                while(*s != 0){
    1db6:	eb 1c                	jmp    1dd4 <sprintf+0x169>
                    dst[j++] = *s;
    1db8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1dbb:	8d 50 01             	lea    0x1(%eax),%edx
    1dbe:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1dc1:	89 c2                	mov    %eax,%edx
    1dc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc6:	01 c2                	add    %eax,%edx
    1dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dcb:	0f b6 00             	movzbl (%eax),%eax
    1dce:	88 02                	mov    %al,(%edx)
                    s++;
    1dd0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1dd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd7:	0f b6 00             	movzbl (%eax),%eax
    1dda:	84 c0                	test   %al,%al
    1ddc:	75 da                	jne    1db8 <sprintf+0x14d>
    1dde:	e9 86 00 00 00       	jmp    1e69 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1de3:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1de7:	75 1d                	jne    1e06 <sprintf+0x19b>
                dst[j++] = *ap;
    1de9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1dec:	8d 50 01             	lea    0x1(%eax),%edx
    1def:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1df2:	89 c2                	mov    %eax,%edx
    1df4:	8b 45 08             	mov    0x8(%ebp),%eax
    1df7:	01 c2                	add    %eax,%edx
    1df9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dfc:	8b 00                	mov    (%eax),%eax
    1dfe:	88 02                	mov    %al,(%edx)
                ap++;
    1e00:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1e04:	eb 63                	jmp    1e69 <sprintf+0x1fe>
            } else if(c == '%'){
    1e06:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1e0a:	75 17                	jne    1e23 <sprintf+0x1b8>
                dst[j++] = c;
    1e0c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e0f:	8d 50 01             	lea    0x1(%eax),%edx
    1e12:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e15:	89 c2                	mov    %eax,%edx
    1e17:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1a:	01 d0                	add    %edx,%eax
    1e1c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e1f:	88 10                	mov    %dl,(%eax)
    1e21:	eb 46                	jmp    1e69 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1e23:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1e27:	7e 18                	jle    1e41 <sprintf+0x1d6>
    1e29:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1e2d:	7f 12                	jg     1e41 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1e2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e32:	8d 50 01             	lea    0x1(%eax),%edx
    1e35:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1e38:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e3b:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1e3f:	eb 2f                	jmp    1e70 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1e41:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e44:	8d 50 01             	lea    0x1(%eax),%edx
    1e47:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e4a:	89 c2                	mov    %eax,%edx
    1e4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4f:	01 d0                	add    %edx,%eax
    1e51:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1e54:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e57:	8d 50 01             	lea    0x1(%eax),%edx
    1e5a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e5d:	89 c2                	mov    %eax,%edx
    1e5f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e62:	01 d0                	add    %edx,%eax
    1e64:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1e67:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1e69:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1e70:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1e74:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e77:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e7a:	01 d0                	add    %edx,%eax
    1e7c:	0f b6 00             	movzbl (%eax),%eax
    1e7f:	84 c0                	test   %al,%al
    1e81:	0f 85 14 fe ff ff    	jne    1c9b <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1e87:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e8a:	8d 50 01             	lea    0x1(%eax),%edx
    1e8d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e90:	89 c2                	mov    %eax,%edx
    1e92:	8b 45 08             	mov    0x8(%ebp),%eax
    1e95:	01 d0                	add    %edx,%eax
    1e97:	c6 00 00             	movb   $0x0,(%eax)
}
    1e9a:	90                   	nop
    1e9b:	c9                   	leave  
    1e9c:	c3                   	ret    
