
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
      27:	ba 94 24 00 00       	mov    $0x2494,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba 96 24 00 00       	mov    $0x2496,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 98 24 00 00       	push   $0x2498
      4b:	6a 01                	push   $0x1
      4d:	e8 29 04 00 00       	call   47b <printf>
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

00000394 <getCurrentTime>:
SYSCALL(getCurrentTime)
     394:	b8 1d 00 00 00       	mov    $0x1d,%eax
     399:	cd 40                	int    $0x40
     39b:	c3                   	ret    

0000039c <removeWindow>:
SYSCALL(removeWindow)
     39c:	b8 1e 00 00 00       	mov    $0x1e,%eax
     3a1:	cd 40                	int    $0x40
     3a3:	c3                   	ret    

000003a4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3a4:	55                   	push   %ebp
     3a5:	89 e5                	mov    %esp,%ebp
     3a7:	83 ec 18             	sub    $0x18,%esp
     3aa:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ad:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3b0:	83 ec 04             	sub    $0x4,%esp
     3b3:	6a 01                	push   $0x1
     3b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3b8:	50                   	push   %eax
     3b9:	ff 75 08             	pushl  0x8(%ebp)
     3bc:	e8 1b ff ff ff       	call   2dc <write>
     3c1:	83 c4 10             	add    $0x10,%esp
}
     3c4:	90                   	nop
     3c5:	c9                   	leave  
     3c6:	c3                   	ret    

000003c7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3c7:	55                   	push   %ebp
     3c8:	89 e5                	mov    %esp,%ebp
     3ca:	53                   	push   %ebx
     3cb:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3d5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3d9:	74 17                	je     3f2 <printint+0x2b>
     3db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3df:	79 11                	jns    3f2 <printint+0x2b>
    neg = 1;
     3e1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3e8:	8b 45 0c             	mov    0xc(%ebp),%eax
     3eb:	f7 d8                	neg    %eax
     3ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3f0:	eb 06                	jmp    3f8 <printint+0x31>
  } else {
    x = xx;
     3f2:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3ff:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     402:	8d 41 01             	lea    0x1(%ecx),%eax
     405:	89 45 f4             	mov    %eax,-0xc(%ebp)
     408:	8b 5d 10             	mov    0x10(%ebp),%ebx
     40b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     40e:	ba 00 00 00 00       	mov    $0x0,%edx
     413:	f7 f3                	div    %ebx
     415:	89 d0                	mov    %edx,%eax
     417:	0f b6 80 c0 2b 00 00 	movzbl 0x2bc0(%eax),%eax
     41e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     422:	8b 5d 10             	mov    0x10(%ebp),%ebx
     425:	8b 45 ec             	mov    -0x14(%ebp),%eax
     428:	ba 00 00 00 00       	mov    $0x0,%edx
     42d:	f7 f3                	div    %ebx
     42f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     432:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     436:	75 c7                	jne    3ff <printint+0x38>
  if(neg)
     438:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     43c:	74 2d                	je     46b <printint+0xa4>
    buf[i++] = '-';
     43e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     441:	8d 50 01             	lea    0x1(%eax),%edx
     444:	89 55 f4             	mov    %edx,-0xc(%ebp)
     447:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     44c:	eb 1d                	jmp    46b <printint+0xa4>
    putc(fd, buf[i]);
     44e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     451:	8b 45 f4             	mov    -0xc(%ebp),%eax
     454:	01 d0                	add    %edx,%eax
     456:	0f b6 00             	movzbl (%eax),%eax
     459:	0f be c0             	movsbl %al,%eax
     45c:	83 ec 08             	sub    $0x8,%esp
     45f:	50                   	push   %eax
     460:	ff 75 08             	pushl  0x8(%ebp)
     463:	e8 3c ff ff ff       	call   3a4 <putc>
     468:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     46b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     46f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     473:	79 d9                	jns    44e <printint+0x87>
    putc(fd, buf[i]);
}
     475:	90                   	nop
     476:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     479:	c9                   	leave  
     47a:	c3                   	ret    

0000047b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     47b:	55                   	push   %ebp
     47c:	89 e5                	mov    %esp,%ebp
     47e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     481:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     488:	8d 45 0c             	lea    0xc(%ebp),%eax
     48b:	83 c0 04             	add    $0x4,%eax
     48e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     491:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     498:	e9 59 01 00 00       	jmp    5f6 <printf+0x17b>
    c = fmt[i] & 0xff;
     49d:	8b 55 0c             	mov    0xc(%ebp),%edx
     4a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4a3:	01 d0                	add    %edx,%eax
     4a5:	0f b6 00             	movzbl (%eax),%eax
     4a8:	0f be c0             	movsbl %al,%eax
     4ab:	25 ff 00 00 00       	and    $0xff,%eax
     4b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4b7:	75 2c                	jne    4e5 <printf+0x6a>
      if(c == '%'){
     4b9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4bd:	75 0c                	jne    4cb <printf+0x50>
        state = '%';
     4bf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4c6:	e9 27 01 00 00       	jmp    5f2 <printf+0x177>
      } else {
        putc(fd, c);
     4cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4ce:	0f be c0             	movsbl %al,%eax
     4d1:	83 ec 08             	sub    $0x8,%esp
     4d4:	50                   	push   %eax
     4d5:	ff 75 08             	pushl  0x8(%ebp)
     4d8:	e8 c7 fe ff ff       	call   3a4 <putc>
     4dd:	83 c4 10             	add    $0x10,%esp
     4e0:	e9 0d 01 00 00       	jmp    5f2 <printf+0x177>
      }
    } else if(state == '%'){
     4e5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4e9:	0f 85 03 01 00 00    	jne    5f2 <printf+0x177>
      if(c == 'd'){
     4ef:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4f3:	75 1e                	jne    513 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4f8:	8b 00                	mov    (%eax),%eax
     4fa:	6a 01                	push   $0x1
     4fc:	6a 0a                	push   $0xa
     4fe:	50                   	push   %eax
     4ff:	ff 75 08             	pushl  0x8(%ebp)
     502:	e8 c0 fe ff ff       	call   3c7 <printint>
     507:	83 c4 10             	add    $0x10,%esp
        ap++;
     50a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     50e:	e9 d8 00 00 00       	jmp    5eb <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     513:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     517:	74 06                	je     51f <printf+0xa4>
     519:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     51d:	75 1e                	jne    53d <printf+0xc2>
        printint(fd, *ap, 16, 0);
     51f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     522:	8b 00                	mov    (%eax),%eax
     524:	6a 00                	push   $0x0
     526:	6a 10                	push   $0x10
     528:	50                   	push   %eax
     529:	ff 75 08             	pushl  0x8(%ebp)
     52c:	e8 96 fe ff ff       	call   3c7 <printint>
     531:	83 c4 10             	add    $0x10,%esp
        ap++;
     534:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     538:	e9 ae 00 00 00       	jmp    5eb <printf+0x170>
      } else if(c == 's'){
     53d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     541:	75 43                	jne    586 <printf+0x10b>
        s = (char*)*ap;
     543:	8b 45 e8             	mov    -0x18(%ebp),%eax
     546:	8b 00                	mov    (%eax),%eax
     548:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     54b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     54f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     553:	75 25                	jne    57a <printf+0xff>
          s = "(null)";
     555:	c7 45 f4 9d 24 00 00 	movl   $0x249d,-0xc(%ebp)
        while(*s != 0){
     55c:	eb 1c                	jmp    57a <printf+0xff>
          putc(fd, *s);
     55e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     561:	0f b6 00             	movzbl (%eax),%eax
     564:	0f be c0             	movsbl %al,%eax
     567:	83 ec 08             	sub    $0x8,%esp
     56a:	50                   	push   %eax
     56b:	ff 75 08             	pushl  0x8(%ebp)
     56e:	e8 31 fe ff ff       	call   3a4 <putc>
     573:	83 c4 10             	add    $0x10,%esp
          s++;
     576:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     57a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57d:	0f b6 00             	movzbl (%eax),%eax
     580:	84 c0                	test   %al,%al
     582:	75 da                	jne    55e <printf+0xe3>
     584:	eb 65                	jmp    5eb <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     586:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     58a:	75 1d                	jne    5a9 <printf+0x12e>
        putc(fd, *ap);
     58c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     58f:	8b 00                	mov    (%eax),%eax
     591:	0f be c0             	movsbl %al,%eax
     594:	83 ec 08             	sub    $0x8,%esp
     597:	50                   	push   %eax
     598:	ff 75 08             	pushl  0x8(%ebp)
     59b:	e8 04 fe ff ff       	call   3a4 <putc>
     5a0:	83 c4 10             	add    $0x10,%esp
        ap++;
     5a3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5a7:	eb 42                	jmp    5eb <printf+0x170>
      } else if(c == '%'){
     5a9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5ad:	75 17                	jne    5c6 <printf+0x14b>
        putc(fd, c);
     5af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5b2:	0f be c0             	movsbl %al,%eax
     5b5:	83 ec 08             	sub    $0x8,%esp
     5b8:	50                   	push   %eax
     5b9:	ff 75 08             	pushl  0x8(%ebp)
     5bc:	e8 e3 fd ff ff       	call   3a4 <putc>
     5c1:	83 c4 10             	add    $0x10,%esp
     5c4:	eb 25                	jmp    5eb <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5c6:	83 ec 08             	sub    $0x8,%esp
     5c9:	6a 25                	push   $0x25
     5cb:	ff 75 08             	pushl  0x8(%ebp)
     5ce:	e8 d1 fd ff ff       	call   3a4 <putc>
     5d3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d9:	0f be c0             	movsbl %al,%eax
     5dc:	83 ec 08             	sub    $0x8,%esp
     5df:	50                   	push   %eax
     5e0:	ff 75 08             	pushl  0x8(%ebp)
     5e3:	e8 bc fd ff ff       	call   3a4 <putc>
     5e8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     5f2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5f6:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5fc:	01 d0                	add    %edx,%eax
     5fe:	0f b6 00             	movzbl (%eax),%eax
     601:	84 c0                	test   %al,%al
     603:	0f 85 94 fe ff ff    	jne    49d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     609:	90                   	nop
     60a:	c9                   	leave  
     60b:	c3                   	ret    

0000060c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     60c:	55                   	push   %ebp
     60d:	89 e5                	mov    %esp,%ebp
     60f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     612:	8b 45 08             	mov    0x8(%ebp),%eax
     615:	83 e8 08             	sub    $0x8,%eax
     618:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     61b:	a1 20 68 00 00       	mov    0x6820,%eax
     620:	89 45 fc             	mov    %eax,-0x4(%ebp)
     623:	eb 24                	jmp    649 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     625:	8b 45 fc             	mov    -0x4(%ebp),%eax
     628:	8b 00                	mov    (%eax),%eax
     62a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62d:	77 12                	ja     641 <free+0x35>
     62f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     632:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     635:	77 24                	ja     65b <free+0x4f>
     637:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63a:	8b 00                	mov    (%eax),%eax
     63c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     63f:	77 1a                	ja     65b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     641:	8b 45 fc             	mov    -0x4(%ebp),%eax
     644:	8b 00                	mov    (%eax),%eax
     646:	89 45 fc             	mov    %eax,-0x4(%ebp)
     649:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     64f:	76 d4                	jbe    625 <free+0x19>
     651:	8b 45 fc             	mov    -0x4(%ebp),%eax
     654:	8b 00                	mov    (%eax),%eax
     656:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     659:	76 ca                	jbe    625 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     65b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65e:	8b 40 04             	mov    0x4(%eax),%eax
     661:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     668:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66b:	01 c2                	add    %eax,%edx
     66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     670:	8b 00                	mov    (%eax),%eax
     672:	39 c2                	cmp    %eax,%edx
     674:	75 24                	jne    69a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     676:	8b 45 f8             	mov    -0x8(%ebp),%eax
     679:	8b 50 04             	mov    0x4(%eax),%edx
     67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67f:	8b 00                	mov    (%eax),%eax
     681:	8b 40 04             	mov    0x4(%eax),%eax
     684:	01 c2                	add    %eax,%edx
     686:	8b 45 f8             	mov    -0x8(%ebp),%eax
     689:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     68f:	8b 00                	mov    (%eax),%eax
     691:	8b 10                	mov    (%eax),%edx
     693:	8b 45 f8             	mov    -0x8(%ebp),%eax
     696:	89 10                	mov    %edx,(%eax)
     698:	eb 0a                	jmp    6a4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     69a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69d:	8b 10                	mov    (%eax),%edx
     69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a7:	8b 40 04             	mov    0x4(%eax),%eax
     6aa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b4:	01 d0                	add    %edx,%eax
     6b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6b9:	75 20                	jne    6db <free+0xcf>
    p->s.size += bp->s.size;
     6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6be:	8b 50 04             	mov    0x4(%eax),%edx
     6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c4:	8b 40 04             	mov    0x4(%eax),%eax
     6c7:	01 c2                	add    %eax,%edx
     6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d2:	8b 10                	mov    (%eax),%edx
     6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d7:	89 10                	mov    %edx,(%eax)
     6d9:	eb 08                	jmp    6e3 <free+0xd7>
  } else
    p->s.ptr = bp;
     6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6de:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6e1:	89 10                	mov    %edx,(%eax)
  freep = p;
     6e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e6:	a3 20 68 00 00       	mov    %eax,0x6820
}
     6eb:	90                   	nop
     6ec:	c9                   	leave  
     6ed:	c3                   	ret    

000006ee <morecore>:

static Header*
morecore(uint nu)
{
     6ee:	55                   	push   %ebp
     6ef:	89 e5                	mov    %esp,%ebp
     6f1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6f4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6fb:	77 07                	ja     704 <morecore+0x16>
    nu = 4096;
     6fd:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     704:	8b 45 08             	mov    0x8(%ebp),%eax
     707:	c1 e0 03             	shl    $0x3,%eax
     70a:	83 ec 0c             	sub    $0xc,%esp
     70d:	50                   	push   %eax
     70e:	e8 31 fc ff ff       	call   344 <sbrk>
     713:	83 c4 10             	add    $0x10,%esp
     716:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     719:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     71d:	75 07                	jne    726 <morecore+0x38>
    return 0;
     71f:	b8 00 00 00 00       	mov    $0x0,%eax
     724:	eb 26                	jmp    74c <morecore+0x5e>
  hp = (Header*)p;
     726:	8b 45 f4             	mov    -0xc(%ebp),%eax
     729:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     72c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     72f:	8b 55 08             	mov    0x8(%ebp),%edx
     732:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     735:	8b 45 f0             	mov    -0x10(%ebp),%eax
     738:	83 c0 08             	add    $0x8,%eax
     73b:	83 ec 0c             	sub    $0xc,%esp
     73e:	50                   	push   %eax
     73f:	e8 c8 fe ff ff       	call   60c <free>
     744:	83 c4 10             	add    $0x10,%esp
  return freep;
     747:	a1 20 68 00 00       	mov    0x6820,%eax
}
     74c:	c9                   	leave  
     74d:	c3                   	ret    

0000074e <malloc>:

void*
malloc(uint nbytes)
{
     74e:	55                   	push   %ebp
     74f:	89 e5                	mov    %esp,%ebp
     751:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     754:	8b 45 08             	mov    0x8(%ebp),%eax
     757:	83 c0 07             	add    $0x7,%eax
     75a:	c1 e8 03             	shr    $0x3,%eax
     75d:	83 c0 01             	add    $0x1,%eax
     760:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     763:	a1 20 68 00 00       	mov    0x6820,%eax
     768:	89 45 f0             	mov    %eax,-0x10(%ebp)
     76b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     76f:	75 23                	jne    794 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     771:	c7 45 f0 18 68 00 00 	movl   $0x6818,-0x10(%ebp)
     778:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77b:	a3 20 68 00 00       	mov    %eax,0x6820
     780:	a1 20 68 00 00       	mov    0x6820,%eax
     785:	a3 18 68 00 00       	mov    %eax,0x6818
    base.s.size = 0;
     78a:	c7 05 1c 68 00 00 00 	movl   $0x0,0x681c
     791:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     794:	8b 45 f0             	mov    -0x10(%ebp),%eax
     797:	8b 00                	mov    (%eax),%eax
     799:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79f:	8b 40 04             	mov    0x4(%eax),%eax
     7a2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7a5:	72 4d                	jb     7f4 <malloc+0xa6>
      if(p->s.size == nunits)
     7a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7aa:	8b 40 04             	mov    0x4(%eax),%eax
     7ad:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7b0:	75 0c                	jne    7be <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b5:	8b 10                	mov    (%eax),%edx
     7b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ba:	89 10                	mov    %edx,(%eax)
     7bc:	eb 26                	jmp    7e4 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c1:	8b 40 04             	mov    0x4(%eax),%eax
     7c4:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7c7:	89 c2                	mov    %eax,%edx
     7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cc:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d2:	8b 40 04             	mov    0x4(%eax),%eax
     7d5:	c1 e0 03             	shl    $0x3,%eax
     7d8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7de:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7e1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e7:	a3 20 68 00 00       	mov    %eax,0x6820
      return (void*)(p + 1);
     7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ef:	83 c0 08             	add    $0x8,%eax
     7f2:	eb 3b                	jmp    82f <malloc+0xe1>
    }
    if(p == freep)
     7f4:	a1 20 68 00 00       	mov    0x6820,%eax
     7f9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7fc:	75 1e                	jne    81c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7fe:	83 ec 0c             	sub    $0xc,%esp
     801:	ff 75 ec             	pushl  -0x14(%ebp)
     804:	e8 e5 fe ff ff       	call   6ee <morecore>
     809:	83 c4 10             	add    $0x10,%esp
     80c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     80f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     813:	75 07                	jne    81c <malloc+0xce>
        return 0;
     815:	b8 00 00 00 00       	mov    $0x0,%eax
     81a:	eb 13                	jmp    82f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     822:	8b 45 f4             	mov    -0xc(%ebp),%eax
     825:	8b 00                	mov    (%eax),%eax
     827:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     82a:	e9 6d ff ff ff       	jmp    79c <malloc+0x4e>
}
     82f:	c9                   	leave  
     830:	c3                   	ret    

00000831 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     831:	55                   	push   %ebp
     832:	89 e5                	mov    %esp,%ebp
     834:	83 ec 1c             	sub    $0x1c,%esp
     837:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     83a:	8b 55 10             	mov    0x10(%ebp),%edx
     83d:	8b 45 14             	mov    0x14(%ebp),%eax
     840:	88 4d ec             	mov    %cl,-0x14(%ebp)
     843:	88 55 e8             	mov    %dl,-0x18(%ebp)
     846:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     849:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     84d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     850:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     854:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     857:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     85b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     85e:	8b 45 08             	mov    0x8(%ebp),%eax
     861:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     865:	66 89 10             	mov    %dx,(%eax)
     868:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     86c:	88 50 02             	mov    %dl,0x2(%eax)
}
     86f:	8b 45 08             	mov    0x8(%ebp),%eax
     872:	c9                   	leave  
     873:	c2 04 00             	ret    $0x4

00000876 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     876:	55                   	push   %ebp
     877:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     879:	8b 45 08             	mov    0x8(%ebp),%eax
     87c:	2b 45 10             	sub    0x10(%ebp),%eax
     87f:	89 c2                	mov    %eax,%edx
     881:	8b 45 08             	mov    0x8(%ebp),%eax
     884:	2b 45 10             	sub    0x10(%ebp),%eax
     887:	0f af d0             	imul   %eax,%edx
     88a:	8b 45 0c             	mov    0xc(%ebp),%eax
     88d:	2b 45 14             	sub    0x14(%ebp),%eax
     890:	89 c1                	mov    %eax,%ecx
     892:	8b 45 0c             	mov    0xc(%ebp),%eax
     895:	2b 45 14             	sub    0x14(%ebp),%eax
     898:	0f af c1             	imul   %ecx,%eax
     89b:	01 d0                	add    %edx,%eax
}
     89d:	5d                   	pop    %ebp
     89e:	c3                   	ret    

0000089f <abs_int>:

static inline int abs_int(int x)
{
     89f:	55                   	push   %ebp
     8a0:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     8a2:	8b 45 08             	mov    0x8(%ebp),%eax
     8a5:	99                   	cltd   
     8a6:	89 d0                	mov    %edx,%eax
     8a8:	33 45 08             	xor    0x8(%ebp),%eax
     8ab:	29 d0                	sub    %edx,%eax
}
     8ad:	5d                   	pop    %ebp
     8ae:	c3                   	ret    

000008af <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     8af:	55                   	push   %ebp
     8b0:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     8b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8b6:	79 07                	jns    8bf <APGetIndex+0x10>
        return X_SMALLER;
     8b8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     8bd:	eb 40                	jmp    8ff <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     8bf:	8b 45 08             	mov    0x8(%ebp),%eax
     8c2:	8b 00                	mov    (%eax),%eax
     8c4:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8c7:	7f 07                	jg     8d0 <APGetIndex+0x21>
        return X_BIGGER;
     8c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8ce:	eb 2f                	jmp    8ff <APGetIndex+0x50>
    if (y < 0)
     8d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8d4:	79 07                	jns    8dd <APGetIndex+0x2e>
        return Y_SMALLER;
     8d6:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     8db:	eb 22                	jmp    8ff <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     8dd:	8b 45 08             	mov    0x8(%ebp),%eax
     8e0:	8b 40 04             	mov    0x4(%eax),%eax
     8e3:	3b 45 10             	cmp    0x10(%ebp),%eax
     8e6:	7f 07                	jg     8ef <APGetIndex+0x40>
        return Y_BIGGER;
     8e8:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     8ed:	eb 10                	jmp    8ff <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     8ef:	8b 45 08             	mov    0x8(%ebp),%eax
     8f2:	8b 00                	mov    (%eax),%eax
     8f4:	0f af 45 10          	imul   0x10(%ebp),%eax
     8f8:	89 c2                	mov    %eax,%edx
     8fa:	8b 45 0c             	mov    0xc(%ebp),%eax
     8fd:	01 d0                	add    %edx,%eax
}
     8ff:	5d                   	pop    %ebp
     900:	c3                   	ret    

00000901 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     901:	55                   	push   %ebp
     902:	89 e5                	mov    %esp,%ebp
     904:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     907:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     90e:	8b 45 cc             	mov    -0x34(%ebp),%eax
     911:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     914:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     91b:	83 ec 08             	sub    $0x8,%esp
     91e:	6a 00                	push   $0x0
     920:	ff 75 0c             	pushl  0xc(%ebp)
     923:	e8 d4 f9 ff ff       	call   2fc <open>
     928:	83 c4 10             	add    $0x10,%esp
     92b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     92e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     932:	79 2e                	jns    962 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     934:	83 ec 04             	sub    $0x4,%esp
     937:	ff 75 0c             	pushl  0xc(%ebp)
     93a:	68 a4 24 00 00       	push   $0x24a4
     93f:	6a 01                	push   $0x1
     941:	e8 35 fb ff ff       	call   47b <printf>
     946:	83 c4 10             	add    $0x10,%esp
        return bmp;
     949:	8b 45 08             	mov    0x8(%ebp),%eax
     94c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     94f:	89 10                	mov    %edx,(%eax)
     951:	8b 55 cc             	mov    -0x34(%ebp),%edx
     954:	89 50 04             	mov    %edx,0x4(%eax)
     957:	8b 55 d0             	mov    -0x30(%ebp),%edx
     95a:	89 50 08             	mov    %edx,0x8(%eax)
     95d:	e9 d2 01 00 00       	jmp    b34 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     962:	83 ec 04             	sub    $0x4,%esp
     965:	6a 0e                	push   $0xe
     967:	8d 45 ba             	lea    -0x46(%ebp),%eax
     96a:	50                   	push   %eax
     96b:	ff 75 ec             	pushl  -0x14(%ebp)
     96e:	e8 61 f9 ff ff       	call   2d4 <read>
     973:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     976:	83 ec 04             	sub    $0x4,%esp
     979:	6a 28                	push   $0x28
     97b:	8d 45 92             	lea    -0x6e(%ebp),%eax
     97e:	50                   	push   %eax
     97f:	ff 75 ec             	pushl  -0x14(%ebp)
     982:	e8 4d f9 ff ff       	call   2d4 <read>
     987:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     98a:	8b 45 96             	mov    -0x6a(%ebp),%eax
     98d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     990:	8b 45 9a             	mov    -0x66(%ebp),%eax
     993:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     996:	8b 55 c8             	mov    -0x38(%ebp),%edx
     999:	8b 45 cc             	mov    -0x34(%ebp),%eax
     99c:	0f af d0             	imul   %eax,%edx
     99f:	89 d0                	mov    %edx,%eax
     9a1:	01 c0                	add    %eax,%eax
     9a3:	01 d0                	add    %edx,%eax
     9a5:	83 ec 0c             	sub    $0xc,%esp
     9a8:	50                   	push   %eax
     9a9:	e8 a0 fd ff ff       	call   74e <malloc>
     9ae:	83 c4 10             	add    $0x10,%esp
     9b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     9b4:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9b8:	0f b7 c0             	movzwl %ax,%eax
     9bb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     9be:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9c4:	0f af c2             	imul   %edx,%eax
     9c7:	83 c0 1f             	add    $0x1f,%eax
     9ca:	c1 e8 05             	shr    $0x5,%eax
     9cd:	c1 e0 02             	shl    $0x2,%eax
     9d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9d3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9d9:	0f af c2             	imul   %edx,%eax
     9dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9df:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9e2:	83 ec 0c             	sub    $0xc,%esp
     9e5:	50                   	push   %eax
     9e6:	e8 63 fd ff ff       	call   74e <malloc>
     9eb:	83 c4 10             	add    $0x10,%esp
     9ee:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9f1:	83 ec 04             	sub    $0x4,%esp
     9f4:	ff 75 e0             	pushl  -0x20(%ebp)
     9f7:	ff 75 dc             	pushl  -0x24(%ebp)
     9fa:	ff 75 ec             	pushl  -0x14(%ebp)
     9fd:	e8 d2 f8 ff ff       	call   2d4 <read>
     a02:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a05:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a09:	66 c1 e8 03          	shr    $0x3,%ax
     a0d:	0f b7 c0             	movzwl %ax,%eax
     a10:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a1a:	e9 e5 00 00 00       	jmp    b04 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     a1f:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a25:	29 c2                	sub    %eax,%edx
     a27:	89 d0                	mov    %edx,%eax
     a29:	8d 50 ff             	lea    -0x1(%eax),%edx
     a2c:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a2f:	0f af c2             	imul   %edx,%eax
     a32:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a35:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a3c:	e9 b1 00 00 00       	jmp    af2 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a41:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a44:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4a:	01 c8                	add    %ecx,%eax
     a4c:	89 c1                	mov    %eax,%ecx
     a4e:	89 c8                	mov    %ecx,%eax
     a50:	01 c0                	add    %eax,%eax
     a52:	01 c8                	add    %ecx,%eax
     a54:	01 c2                	add    %eax,%edx
     a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a59:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a5d:	89 c1                	mov    %eax,%ecx
     a5f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a62:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a66:	01 c1                	add    %eax,%ecx
     a68:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a6b:	01 c8                	add    %ecx,%eax
     a6d:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a70:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a73:	01 c8                	add    %ecx,%eax
     a75:	0f b6 00             	movzbl (%eax),%eax
     a78:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a7b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a7e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a84:	01 c8                	add    %ecx,%eax
     a86:	89 c1                	mov    %eax,%ecx
     a88:	89 c8                	mov    %ecx,%eax
     a8a:	01 c0                	add    %eax,%eax
     a8c:	01 c8                	add    %ecx,%eax
     a8e:	01 c2                	add    %eax,%edx
     a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a93:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a97:	89 c1                	mov    %eax,%ecx
     a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a9c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aa0:	01 c1                	add    %eax,%ecx
     aa2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa5:	01 c8                	add    %ecx,%eax
     aa7:	8d 48 fe             	lea    -0x2(%eax),%ecx
     aaa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aad:	01 c8                	add    %ecx,%eax
     aaf:	0f b6 00             	movzbl (%eax),%eax
     ab2:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ab5:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ab8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     abb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abe:	01 c8                	add    %ecx,%eax
     ac0:	89 c1                	mov    %eax,%ecx
     ac2:	89 c8                	mov    %ecx,%eax
     ac4:	01 c0                	add    %eax,%eax
     ac6:	01 c8                	add    %ecx,%eax
     ac8:	01 c2                	add    %eax,%edx
     aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acd:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ad1:	89 c1                	mov    %eax,%ecx
     ad3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ada:	01 c1                	add    %eax,%ecx
     adc:	8b 45 d8             	mov    -0x28(%ebp),%eax
     adf:	01 c8                	add    %ecx,%eax
     ae1:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ae4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ae7:	01 c8                	add    %ecx,%eax
     ae9:	0f b6 00             	movzbl (%eax),%eax
     aec:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     aee:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     af2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af8:	39 c2                	cmp    %eax,%edx
     afa:	0f 87 41 ff ff ff    	ja     a41 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b00:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b04:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0a:	39 c2                	cmp    %eax,%edx
     b0c:	0f 87 0d ff ff ff    	ja     a1f <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b12:	83 ec 0c             	sub    $0xc,%esp
     b15:	ff 75 ec             	pushl  -0x14(%ebp)
     b18:	e8 c7 f7 ff ff       	call   2e4 <close>
     b1d:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b20:	8b 45 08             	mov    0x8(%ebp),%eax
     b23:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b26:	89 10                	mov    %edx,(%eax)
     b28:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b2b:	89 50 04             	mov    %edx,0x4(%eax)
     b2e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b31:	89 50 08             	mov    %edx,0x8(%eax)
}
     b34:	8b 45 08             	mov    0x8(%ebp),%eax
     b37:	c9                   	leave  
     b38:	c2 04 00             	ret    $0x4

00000b3b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b3b:	55                   	push   %ebp
     b3c:	89 e5                	mov    %esp,%ebp
     b3e:	53                   	push   %ebx
     b3f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b42:	83 ec 0c             	sub    $0xc,%esp
     b45:	6a 1c                	push   $0x1c
     b47:	e8 02 fc ff ff       	call   74e <malloc>
     b4c:	83 c4 10             	add    $0x10,%esp
     b4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b55:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b5c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b5f:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b62:	6a 0c                	push   $0xc
     b64:	6a 0c                	push   $0xc
     b66:	6a 0c                	push   $0xc
     b68:	50                   	push   %eax
     b69:	e8 c3 fc ff ff       	call   831 <RGB>
     b6e:	83 c4 0c             	add    $0xc,%esp
     b71:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b75:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b79:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b7d:	88 43 15             	mov    %al,0x15(%ebx)
     b80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b83:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b86:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b8a:	66 89 48 10          	mov    %cx,0x10(%eax)
     b8e:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b92:	88 50 12             	mov    %dl,0x12(%eax)
     b95:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b98:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b9b:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b9f:	66 89 48 08          	mov    %cx,0x8(%eax)
     ba3:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     ba7:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     baa:	8b 45 08             	mov    0x8(%ebp),%eax
     bad:	89 c2                	mov    %eax,%edx
     baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb2:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     bb4:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb7:	89 c2                	mov    %eax,%edx
     bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbc:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     bbf:	8b 55 10             	mov    0x10(%ebp),%edx
     bc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bce:	c9                   	leave  
     bcf:	c3                   	ret    

00000bd0 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bd6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bd9:	8b 50 08             	mov    0x8(%eax),%edx
     bdc:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bdf:	8b 40 0c             	mov    0xc(%eax),%eax
     be2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     be5:	8b 45 0c             	mov    0xc(%ebp),%eax
     be8:	8b 55 10             	mov    0x10(%ebp),%edx
     beb:	89 50 08             	mov    %edx,0x8(%eax)
     bee:	8b 55 14             	mov    0x14(%ebp),%edx
     bf1:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bf4:	8b 45 08             	mov    0x8(%ebp),%eax
     bf7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bfa:	89 10                	mov    %edx,(%eax)
     bfc:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bff:	89 50 04             	mov    %edx,0x4(%eax)
}
     c02:	8b 45 08             	mov    0x8(%ebp),%eax
     c05:	c9                   	leave  
     c06:	c2 04 00             	ret    $0x4

00000c09 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c09:	55                   	push   %ebp
     c0a:	89 e5                	mov    %esp,%ebp
     c0c:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c0f:	8b 45 0c             	mov    0xc(%ebp),%eax
     c12:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     c16:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c1a:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     c1e:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c21:	8b 45 0c             	mov    0xc(%ebp),%eax
     c24:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c28:	66 89 50 10          	mov    %dx,0x10(%eax)
     c2c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c30:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c3a:	66 89 10             	mov    %dx,(%eax)
     c3d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c41:	88 50 02             	mov    %dl,0x2(%eax)
}
     c44:	8b 45 08             	mov    0x8(%ebp),%eax
     c47:	c9                   	leave  
     c48:	c2 04 00             	ret    $0x4

00000c4b <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c4b:	55                   	push   %ebp
     c4c:	89 e5                	mov    %esp,%ebp
     c4e:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c51:	8b 45 0c             	mov    0xc(%ebp),%eax
     c54:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c58:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c5c:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c60:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c63:	8b 45 0c             	mov    0xc(%ebp),%eax
     c66:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c6a:	66 89 50 13          	mov    %dx,0x13(%eax)
     c6e:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c72:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c75:	8b 45 08             	mov    0x8(%ebp),%eax
     c78:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c7c:	66 89 10             	mov    %dx,(%eax)
     c7f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c83:	88 50 02             	mov    %dl,0x2(%eax)
}
     c86:	8b 45 08             	mov    0x8(%ebp),%eax
     c89:	c9                   	leave  
     c8a:	c2 04 00             	ret    $0x4

00000c8d <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c8d:	55                   	push   %ebp
     c8e:	89 e5                	mov    %esp,%ebp
     c90:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c93:	8b 45 08             	mov    0x8(%ebp),%eax
     c96:	8b 40 0c             	mov    0xc(%eax),%eax
     c99:	89 c2                	mov    %eax,%edx
     c9b:	c1 ea 1f             	shr    $0x1f,%edx
     c9e:	01 d0                	add    %edx,%eax
     ca0:	d1 f8                	sar    %eax
     ca2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca8:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     caf:	8b 45 10             	mov    0x10(%ebp),%eax
     cb2:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cb5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     cb8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cbc:	0f 89 98 00 00 00    	jns    d5a <APDrawPoint+0xcd>
        i = 0;
     cc2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cc9:	e9 8c 00 00 00       	jmp    d5a <APDrawPoint+0xcd>
    {
        j = x - off;
     cce:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd1:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cd7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     cdb:	79 69                	jns    d46 <APDrawPoint+0xb9>
            j = 0;
     cdd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     ce4:	eb 60                	jmp    d46 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     ce6:	ff 75 fc             	pushl  -0x4(%ebp)
     ce9:	ff 75 f8             	pushl  -0x8(%ebp)
     cec:	ff 75 08             	pushl  0x8(%ebp)
     cef:	e8 bb fb ff ff       	call   8af <APGetIndex>
     cf4:	83 c4 0c             	add    $0xc,%esp
     cf7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cfa:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cfe:	74 55                	je     d55 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d00:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d04:	74 67                	je     d6d <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d06:	ff 75 10             	pushl  0x10(%ebp)
     d09:	ff 75 0c             	pushl  0xc(%ebp)
     d0c:	ff 75 fc             	pushl  -0x4(%ebp)
     d0f:	ff 75 f8             	pushl  -0x8(%ebp)
     d12:	e8 5f fb ff ff       	call   876 <distance_2>
     d17:	83 c4 10             	add    $0x10,%esp
     d1a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d1d:	7f 23                	jg     d42 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d1f:	8b 45 08             	mov    0x8(%ebp),%eax
     d22:	8b 48 18             	mov    0x18(%eax),%ecx
     d25:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d28:	89 d0                	mov    %edx,%eax
     d2a:	01 c0                	add    %eax,%eax
     d2c:	01 d0                	add    %edx,%eax
     d2e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d31:	8b 45 08             	mov    0x8(%ebp),%eax
     d34:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d38:	66 89 0a             	mov    %cx,(%edx)
     d3b:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d3f:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d42:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d46:	8b 55 0c             	mov    0xc(%ebp),%edx
     d49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4c:	01 d0                	add    %edx,%eax
     d4e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d51:	7d 93                	jge    ce6 <APDrawPoint+0x59>
     d53:	eb 01                	jmp    d56 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d55:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d56:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d5a:	8b 55 10             	mov    0x10(%ebp),%edx
     d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d60:	01 d0                	add    %edx,%eax
     d62:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d65:	0f 8d 63 ff ff ff    	jge    cce <APDrawPoint+0x41>
     d6b:	eb 01                	jmp    d6e <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d6d:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d6e:	c9                   	leave  
     d6f:	c3                   	ret    

00000d70 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	53                   	push   %ebx
     d74:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d77:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7a:	3b 45 14             	cmp    0x14(%ebp),%eax
     d7d:	0f 85 80 00 00 00    	jne    e03 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d83:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d87:	0f 88 9d 02 00 00    	js     102a <APDrawLine+0x2ba>
     d8d:	8b 45 08             	mov    0x8(%ebp),%eax
     d90:	8b 00                	mov    (%eax),%eax
     d92:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d95:	0f 8e 8f 02 00 00    	jle    102a <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d9b:	8b 45 10             	mov    0x10(%ebp),%eax
     d9e:	3b 45 18             	cmp    0x18(%ebp),%eax
     da1:	7e 12                	jle    db5 <APDrawLine+0x45>
        {
            int tmp = y2;
     da3:	8b 45 18             	mov    0x18(%ebp),%eax
     da6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     da9:	8b 45 10             	mov    0x10(%ebp),%eax
     dac:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     daf:	8b 45 dc             	mov    -0x24(%ebp),%eax
     db2:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     db5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     db9:	79 07                	jns    dc2 <APDrawLine+0x52>
     dbb:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     dc2:	8b 45 08             	mov    0x8(%ebp),%eax
     dc5:	8b 40 04             	mov    0x4(%eax),%eax
     dc8:	3b 45 18             	cmp    0x18(%ebp),%eax
     dcb:	7d 0c                	jge    dd9 <APDrawLine+0x69>
     dcd:	8b 45 08             	mov    0x8(%ebp),%eax
     dd0:	8b 40 04             	mov    0x4(%eax),%eax
     dd3:	83 e8 01             	sub    $0x1,%eax
     dd6:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     dd9:	8b 45 10             	mov    0x10(%ebp),%eax
     ddc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ddf:	eb 15                	jmp    df6 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     de1:	ff 75 f4             	pushl  -0xc(%ebp)
     de4:	ff 75 0c             	pushl  0xc(%ebp)
     de7:	ff 75 08             	pushl  0x8(%ebp)
     dea:	e8 9e fe ff ff       	call   c8d <APDrawPoint>
     def:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     df2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df9:	3b 45 18             	cmp    0x18(%ebp),%eax
     dfc:	7e e3                	jle    de1 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dfe:	e9 2b 02 00 00       	jmp    102e <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e03:	8b 45 10             	mov    0x10(%ebp),%eax
     e06:	3b 45 18             	cmp    0x18(%ebp),%eax
     e09:	75 7f                	jne    e8a <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e0f:	0f 88 18 02 00 00    	js     102d <APDrawLine+0x2bd>
     e15:	8b 45 08             	mov    0x8(%ebp),%eax
     e18:	8b 40 04             	mov    0x4(%eax),%eax
     e1b:	3b 45 10             	cmp    0x10(%ebp),%eax
     e1e:	0f 8e 09 02 00 00    	jle    102d <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e24:	8b 45 0c             	mov    0xc(%ebp),%eax
     e27:	3b 45 14             	cmp    0x14(%ebp),%eax
     e2a:	7e 12                	jle    e3e <APDrawLine+0xce>
        {
            int tmp = x2;
     e2c:	8b 45 14             	mov    0x14(%ebp),%eax
     e2f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e32:	8b 45 0c             	mov    0xc(%ebp),%eax
     e35:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e38:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e3b:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e42:	79 07                	jns    e4b <APDrawLine+0xdb>
     e44:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e4b:	8b 45 08             	mov    0x8(%ebp),%eax
     e4e:	8b 00                	mov    (%eax),%eax
     e50:	3b 45 14             	cmp    0x14(%ebp),%eax
     e53:	7d 0b                	jge    e60 <APDrawLine+0xf0>
     e55:	8b 45 08             	mov    0x8(%ebp),%eax
     e58:	8b 00                	mov    (%eax),%eax
     e5a:	83 e8 01             	sub    $0x1,%eax
     e5d:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e60:	8b 45 0c             	mov    0xc(%ebp),%eax
     e63:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e66:	eb 15                	jmp    e7d <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e68:	ff 75 10             	pushl  0x10(%ebp)
     e6b:	ff 75 f0             	pushl  -0x10(%ebp)
     e6e:	ff 75 08             	pushl  0x8(%ebp)
     e71:	e8 17 fe ff ff       	call   c8d <APDrawPoint>
     e76:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e79:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e80:	3b 45 14             	cmp    0x14(%ebp),%eax
     e83:	7e e3                	jle    e68 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e85:	e9 a4 01 00 00       	jmp    102e <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e8a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e91:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e98:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9b:	2b 45 14             	sub    0x14(%ebp),%eax
     e9e:	50                   	push   %eax
     e9f:	e8 fb f9 ff ff       	call   89f <abs_int>
     ea4:	83 c4 04             	add    $0x4,%esp
     ea7:	89 c3                	mov    %eax,%ebx
     ea9:	8b 45 10             	mov    0x10(%ebp),%eax
     eac:	2b 45 18             	sub    0x18(%ebp),%eax
     eaf:	50                   	push   %eax
     eb0:	e8 ea f9 ff ff       	call   89f <abs_int>
     eb5:	83 c4 04             	add    $0x4,%esp
     eb8:	39 c3                	cmp    %eax,%ebx
     eba:	0f 8e b5 00 00 00    	jle    f75 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     ec0:	8b 45 10             	mov    0x10(%ebp),%eax
     ec3:	2b 45 18             	sub    0x18(%ebp),%eax
     ec6:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ec9:	db 45 b0             	fildl  -0x50(%ebp)
     ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecf:	2b 45 14             	sub    0x14(%ebp),%eax
     ed2:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed5:	db 45 b0             	fildl  -0x50(%ebp)
     ed8:	de f9                	fdivrp %st,%st(1)
     eda:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     edd:	8b 45 14             	mov    0x14(%ebp),%eax
     ee0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ee3:	7e 0e                	jle    ef3 <APDrawLine+0x183>
        {
            s = x1;
     ee5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     eeb:	8b 45 14             	mov    0x14(%ebp),%eax
     eee:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ef1:	eb 0c                	jmp    eff <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ef3:	8b 45 14             	mov    0x14(%ebp),%eax
     ef6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
     efc:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f03:	79 07                	jns    f0c <APDrawLine+0x19c>
     f05:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f0c:	8b 45 08             	mov    0x8(%ebp),%eax
     f0f:	8b 00                	mov    (%eax),%eax
     f11:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f14:	7f 0b                	jg     f21 <APDrawLine+0x1b1>
     f16:	8b 45 08             	mov    0x8(%ebp),%eax
     f19:	8b 00                	mov    (%eax),%eax
     f1b:	83 e8 01             	sub    $0x1,%eax
     f1e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f21:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f27:	eb 3f                	jmp    f68 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f2c:	2b 45 0c             	sub    0xc(%ebp),%eax
     f2f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f32:	db 45 b0             	fildl  -0x50(%ebp)
     f35:	dc 4d d0             	fmull  -0x30(%ebp)
     f38:	db 45 10             	fildl  0x10(%ebp)
     f3b:	de c1                	faddp  %st,%st(1)
     f3d:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f40:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f44:	b4 0c                	mov    $0xc,%ah
     f46:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f4a:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f4d:	db 5d cc             	fistpl -0x34(%ebp)
     f50:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f53:	ff 75 cc             	pushl  -0x34(%ebp)
     f56:	ff 75 e4             	pushl  -0x1c(%ebp)
     f59:	ff 75 08             	pushl  0x8(%ebp)
     f5c:	e8 2c fd ff ff       	call   c8d <APDrawPoint>
     f61:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f64:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f6b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f6e:	7e b9                	jle    f29 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f70:	e9 b9 00 00 00       	jmp    102e <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f75:	8b 45 0c             	mov    0xc(%ebp),%eax
     f78:	2b 45 14             	sub    0x14(%ebp),%eax
     f7b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7e:	db 45 b0             	fildl  -0x50(%ebp)
     f81:	8b 45 10             	mov    0x10(%ebp),%eax
     f84:	2b 45 18             	sub    0x18(%ebp),%eax
     f87:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f8a:	db 45 b0             	fildl  -0x50(%ebp)
     f8d:	de f9                	fdivrp %st,%st(1)
     f8f:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f92:	8b 45 10             	mov    0x10(%ebp),%eax
     f95:	3b 45 18             	cmp    0x18(%ebp),%eax
     f98:	7e 0e                	jle    fa8 <APDrawLine+0x238>
    {
        s = y2;
     f9a:	8b 45 18             	mov    0x18(%ebp),%eax
     f9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fa0:	8b 45 10             	mov    0x10(%ebp),%eax
     fa3:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fa6:	eb 0c                	jmp    fb4 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     fa8:	8b 45 10             	mov    0x10(%ebp),%eax
     fab:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     fae:	8b 45 18             	mov    0x18(%ebp),%eax
     fb1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fb4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fb8:	79 07                	jns    fc1 <APDrawLine+0x251>
     fba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fc1:	8b 45 08             	mov    0x8(%ebp),%eax
     fc4:	8b 40 04             	mov    0x4(%eax),%eax
     fc7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fca:	7f 0c                	jg     fd8 <APDrawLine+0x268>
     fcc:	8b 45 08             	mov    0x8(%ebp),%eax
     fcf:	8b 40 04             	mov    0x4(%eax),%eax
     fd2:	83 e8 01             	sub    $0x1,%eax
     fd5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fd8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fdb:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fde:	eb 3f                	jmp    101f <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fe0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fe3:	2b 45 10             	sub    0x10(%ebp),%eax
     fe6:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fe9:	db 45 b0             	fildl  -0x50(%ebp)
     fec:	dc 4d c0             	fmull  -0x40(%ebp)
     fef:	db 45 0c             	fildl  0xc(%ebp)
     ff2:	de c1                	faddp  %st,%st(1)
     ff4:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ff7:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ffb:	b4 0c                	mov    $0xc,%ah
     ffd:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1001:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1004:	db 5d bc             	fistpl -0x44(%ebp)
    1007:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    100a:	ff 75 e0             	pushl  -0x20(%ebp)
    100d:	ff 75 bc             	pushl  -0x44(%ebp)
    1010:	ff 75 08             	pushl  0x8(%ebp)
    1013:	e8 75 fc ff ff       	call   c8d <APDrawPoint>
    1018:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    101b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    101f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1022:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1025:	7e b9                	jle    fe0 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1027:	90                   	nop
    1028:	eb 04                	jmp    102e <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    102a:	90                   	nop
    102b:	eb 01                	jmp    102e <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    102d:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    102e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1031:	c9                   	leave  
    1032:	c3                   	ret    

00001033 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1033:	55                   	push   %ebp
    1034:	89 e5                	mov    %esp,%ebp
    1036:	53                   	push   %ebx
    1037:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    103a:	8b 55 10             	mov    0x10(%ebp),%edx
    103d:	8b 45 18             	mov    0x18(%ebp),%eax
    1040:	01 d0                	add    %edx,%eax
    1042:	83 e8 01             	sub    $0x1,%eax
    1045:	83 ec 04             	sub    $0x4,%esp
    1048:	50                   	push   %eax
    1049:	ff 75 0c             	pushl  0xc(%ebp)
    104c:	ff 75 10             	pushl  0x10(%ebp)
    104f:	ff 75 0c             	pushl  0xc(%ebp)
    1052:	ff 75 08             	pushl  0x8(%ebp)
    1055:	e8 16 fd ff ff       	call   d70 <APDrawLine>
    105a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    105d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1060:	8b 45 14             	mov    0x14(%ebp),%eax
    1063:	01 d0                	add    %edx,%eax
    1065:	83 e8 01             	sub    $0x1,%eax
    1068:	83 ec 04             	sub    $0x4,%esp
    106b:	ff 75 10             	pushl  0x10(%ebp)
    106e:	50                   	push   %eax
    106f:	ff 75 10             	pushl  0x10(%ebp)
    1072:	ff 75 0c             	pushl  0xc(%ebp)
    1075:	ff 75 08             	pushl  0x8(%ebp)
    1078:	e8 f3 fc ff ff       	call   d70 <APDrawLine>
    107d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1080:	8b 55 10             	mov    0x10(%ebp),%edx
    1083:	8b 45 18             	mov    0x18(%ebp),%eax
    1086:	01 d0                	add    %edx,%eax
    1088:	8d 48 ff             	lea    -0x1(%eax),%ecx
    108b:	8b 55 0c             	mov    0xc(%ebp),%edx
    108e:	8b 45 14             	mov    0x14(%ebp),%eax
    1091:	01 d0                	add    %edx,%eax
    1093:	8d 50 ff             	lea    -0x1(%eax),%edx
    1096:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1099:	8b 45 14             	mov    0x14(%ebp),%eax
    109c:	01 d8                	add    %ebx,%eax
    109e:	83 e8 01             	sub    $0x1,%eax
    10a1:	83 ec 04             	sub    $0x4,%esp
    10a4:	51                   	push   %ecx
    10a5:	52                   	push   %edx
    10a6:	ff 75 10             	pushl  0x10(%ebp)
    10a9:	50                   	push   %eax
    10aa:	ff 75 08             	pushl  0x8(%ebp)
    10ad:	e8 be fc ff ff       	call   d70 <APDrawLine>
    10b2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10b5:	8b 55 10             	mov    0x10(%ebp),%edx
    10b8:	8b 45 18             	mov    0x18(%ebp),%eax
    10bb:	01 d0                	add    %edx,%eax
    10bd:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10c0:	8b 55 0c             	mov    0xc(%ebp),%edx
    10c3:	8b 45 14             	mov    0x14(%ebp),%eax
    10c6:	01 d0                	add    %edx,%eax
    10c8:	8d 50 ff             	lea    -0x1(%eax),%edx
    10cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10ce:	8b 45 18             	mov    0x18(%ebp),%eax
    10d1:	01 d8                	add    %ebx,%eax
    10d3:	83 e8 01             	sub    $0x1,%eax
    10d6:	83 ec 04             	sub    $0x4,%esp
    10d9:	51                   	push   %ecx
    10da:	52                   	push   %edx
    10db:	50                   	push   %eax
    10dc:	ff 75 0c             	pushl  0xc(%ebp)
    10df:	ff 75 08             	pushl  0x8(%ebp)
    10e2:	e8 89 fc ff ff       	call   d70 <APDrawLine>
    10e7:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10ea:	8b 55 0c             	mov    0xc(%ebp),%edx
    10ed:	8b 45 14             	mov    0x14(%ebp),%eax
    10f0:	01 d0                	add    %edx,%eax
    10f2:	8d 50 ff             	lea    -0x1(%eax),%edx
    10f5:	8b 45 08             	mov    0x8(%ebp),%eax
    10f8:	8b 40 0c             	mov    0xc(%eax),%eax
    10fb:	89 c1                	mov    %eax,%ecx
    10fd:	c1 e9 1f             	shr    $0x1f,%ecx
    1100:	01 c8                	add    %ecx,%eax
    1102:	d1 f8                	sar    %eax
    1104:	29 c2                	sub    %eax,%edx
    1106:	89 d0                	mov    %edx,%eax
    1108:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    110b:	8b 55 10             	mov    0x10(%ebp),%edx
    110e:	8b 45 18             	mov    0x18(%ebp),%eax
    1111:	01 d0                	add    %edx,%eax
    1113:	8d 50 ff             	lea    -0x1(%eax),%edx
    1116:	8b 45 08             	mov    0x8(%ebp),%eax
    1119:	8b 40 0c             	mov    0xc(%eax),%eax
    111c:	89 c1                	mov    %eax,%ecx
    111e:	c1 e9 1f             	shr    $0x1f,%ecx
    1121:	01 c8                	add    %ecx,%eax
    1123:	d1 f8                	sar    %eax
    1125:	29 c2                	sub    %eax,%edx
    1127:	89 d0                	mov    %edx,%eax
    1129:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    112c:	8b 45 08             	mov    0x8(%ebp),%eax
    112f:	8b 40 0c             	mov    0xc(%eax),%eax
    1132:	89 c2                	mov    %eax,%edx
    1134:	c1 ea 1f             	shr    $0x1f,%edx
    1137:	01 d0                	add    %edx,%eax
    1139:	d1 f8                	sar    %eax
    113b:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    113e:	8b 45 08             	mov    0x8(%ebp),%eax
    1141:	8b 40 0c             	mov    0xc(%eax),%eax
    1144:	89 c2                	mov    %eax,%edx
    1146:	c1 ea 1f             	shr    $0x1f,%edx
    1149:	01 d0                	add    %edx,%eax
    114b:	d1 f8                	sar    %eax
    114d:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1150:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1154:	0f 88 d8 00 00 00    	js     1232 <APDrawRect+0x1ff>
    115a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    115e:	0f 88 ce 00 00 00    	js     1232 <APDrawRect+0x1ff>
    1164:	8b 45 08             	mov    0x8(%ebp),%eax
    1167:	8b 00                	mov    (%eax),%eax
    1169:	3b 45 0c             	cmp    0xc(%ebp),%eax
    116c:	0f 8e c0 00 00 00    	jle    1232 <APDrawRect+0x1ff>
    1172:	8b 45 08             	mov    0x8(%ebp),%eax
    1175:	8b 40 04             	mov    0x4(%eax),%eax
    1178:	3b 45 10             	cmp    0x10(%ebp),%eax
    117b:	0f 8e b1 00 00 00    	jle    1232 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1181:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1185:	79 07                	jns    118e <APDrawRect+0x15b>
    1187:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    118e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1192:	79 07                	jns    119b <APDrawRect+0x168>
    1194:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    119b:	8b 45 08             	mov    0x8(%ebp),%eax
    119e:	8b 00                	mov    (%eax),%eax
    11a0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11a3:	7f 0b                	jg     11b0 <APDrawRect+0x17d>
    11a5:	8b 45 08             	mov    0x8(%ebp),%eax
    11a8:	8b 00                	mov    (%eax),%eax
    11aa:	83 e8 01             	sub    $0x1,%eax
    11ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11b0:	8b 45 08             	mov    0x8(%ebp),%eax
    11b3:	8b 40 04             	mov    0x4(%eax),%eax
    11b6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11b9:	7f 0c                	jg     11c7 <APDrawRect+0x194>
    11bb:	8b 45 08             	mov    0x8(%ebp),%eax
    11be:	8b 40 04             	mov    0x4(%eax),%eax
    11c1:	83 e8 01             	sub    $0x1,%eax
    11c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11c7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    11d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11d4:	eb 52                	jmp    1228 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11d6:	8b 45 10             	mov    0x10(%ebp),%eax
    11d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11dc:	eb 3e                	jmp    121c <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11de:	83 ec 04             	sub    $0x4,%esp
    11e1:	ff 75 e8             	pushl  -0x18(%ebp)
    11e4:	ff 75 ec             	pushl  -0x14(%ebp)
    11e7:	ff 75 08             	pushl  0x8(%ebp)
    11ea:	e8 c0 f6 ff ff       	call   8af <APGetIndex>
    11ef:	83 c4 10             	add    $0x10,%esp
    11f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	8b 48 18             	mov    0x18(%eax),%ecx
    11fb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11fe:	89 d0                	mov    %edx,%eax
    1200:	01 c0                	add    %eax,%eax
    1202:	01 d0                	add    %edx,%eax
    1204:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1207:	8b 45 08             	mov    0x8(%ebp),%eax
    120a:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    120e:	66 89 0a             	mov    %cx,(%edx)
    1211:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1215:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1218:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    121c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    121f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1222:	7e ba                	jle    11de <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1224:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1228:	8b 45 ec             	mov    -0x14(%ebp),%eax
    122b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    122e:	7e a6                	jle    11d6 <APDrawRect+0x1a3>
    1230:	eb 01                	jmp    1233 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1232:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1233:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1236:	c9                   	leave  
    1237:	c3                   	ret    

00001238 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1238:	55                   	push   %ebp
    1239:	89 e5                	mov    %esp,%ebp
    123b:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    123e:	83 ec 0c             	sub    $0xc,%esp
    1241:	ff 75 0c             	pushl  0xc(%ebp)
    1244:	e8 b1 ee ff ff       	call   fa <strlen>
    1249:	83 c4 10             	add    $0x10,%esp
    124c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    124f:	8b 45 08             	mov    0x8(%ebp),%eax
    1252:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1256:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    125a:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    125e:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1261:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1268:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    126f:	e9 bc 00 00 00       	jmp    1330 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1274:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1277:	8b 45 0c             	mov    0xc(%ebp),%eax
    127a:	01 d0                	add    %edx,%eax
    127c:	0f b6 00             	movzbl (%eax),%eax
    127f:	0f be c0             	movsbl %al,%eax
    1282:	83 e8 20             	sub    $0x20,%eax
    1285:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1288:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    128c:	0f 87 9a 00 00 00    	ja     132c <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1292:	8b 45 08             	mov    0x8(%ebp),%eax
    1295:	8b 00                	mov    (%eax),%eax
    1297:	0f af 45 14          	imul   0x14(%ebp),%eax
    129b:	89 c2                	mov    %eax,%edx
    129d:	8b 45 10             	mov    0x10(%ebp),%eax
    12a0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    12a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    12a6:	89 d0                	mov    %edx,%eax
    12a8:	c1 e0 03             	shl    $0x3,%eax
    12ab:	01 d0                	add    %edx,%eax
    12ad:	01 c8                	add    %ecx,%eax
    12af:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12b2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12b9:	eb 6b                	jmp    1326 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12bb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12c2:	eb 50                	jmp    1314 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12c4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12ca:	89 d0                	mov    %edx,%eax
    12cc:	c1 e0 03             	shl    $0x3,%eax
    12cf:	01 d0                	add    %edx,%eax
    12d1:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    12d7:	01 c2                	add    %eax,%edx
    12d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12dc:	01 d0                	add    %edx,%eax
    12de:	05 e0 2b 00 00       	add    $0x2be0,%eax
    12e3:	0f b6 00             	movzbl (%eax),%eax
    12e6:	84 c0                	test   %al,%al
    12e8:	74 26                	je     1310 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12ea:	8b 45 08             	mov    0x8(%ebp),%eax
    12ed:	8b 50 18             	mov    0x18(%eax),%edx
    12f0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    12f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12f6:	01 c8                	add    %ecx,%eax
    12f8:	89 c1                	mov    %eax,%ecx
    12fa:	89 c8                	mov    %ecx,%eax
    12fc:	01 c0                	add    %eax,%eax
    12fe:	01 c8                	add    %ecx,%eax
    1300:	01 d0                	add    %edx,%eax
    1302:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1306:	66 89 10             	mov    %dx,(%eax)
    1309:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    130d:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1310:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1314:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1318:	7e aa                	jle    12c4 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    131a:	8b 45 08             	mov    0x8(%ebp),%eax
    131d:	8b 00                	mov    (%eax),%eax
    131f:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1322:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1326:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    132a:	7e 8f                	jle    12bb <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    132c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1330:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1333:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1336:	0f 82 38 ff ff ff    	jb     1274 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    133c:	90                   	nop
    133d:	c9                   	leave  
    133e:	c3                   	ret    

0000133f <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    133f:	55                   	push   %ebp
    1340:	89 e5                	mov    %esp,%ebp
    1342:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1345:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1349:	0f 88 8e 01 00 00    	js     14dd <APDcCopy+0x19e>
    134f:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1353:	0f 88 84 01 00 00    	js     14dd <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1359:	8b 55 0c             	mov    0xc(%ebp),%edx
    135c:	8b 45 20             	mov    0x20(%ebp),%eax
    135f:	01 d0                	add    %edx,%eax
    1361:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1364:	8b 55 10             	mov    0x10(%ebp),%edx
    1367:	8b 45 24             	mov    0x24(%ebp),%eax
    136a:	01 d0                	add    %edx,%eax
    136c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    136f:	8b 55 18             	mov    0x18(%ebp),%edx
    1372:	8b 45 20             	mov    0x20(%ebp),%eax
    1375:	01 d0                	add    %edx,%eax
    1377:	89 45 ec             	mov    %eax,-0x14(%ebp)
    137a:	8b 55 1c             	mov    0x1c(%ebp),%edx
    137d:	8b 45 24             	mov    0x24(%ebp),%eax
    1380:	01 d0                	add    %edx,%eax
    1382:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1385:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1389:	0f 88 51 01 00 00    	js     14e0 <APDcCopy+0x1a1>
    138f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1393:	0f 88 47 01 00 00    	js     14e0 <APDcCopy+0x1a1>
    1399:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    139d:	0f 88 3d 01 00 00    	js     14e0 <APDcCopy+0x1a1>
    13a3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    13a7:	0f 88 33 01 00 00    	js     14e0 <APDcCopy+0x1a1>
    13ad:	8b 45 14             	mov    0x14(%ebp),%eax
    13b0:	8b 00                	mov    (%eax),%eax
    13b2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13b5:	0f 8c 25 01 00 00    	jl     14e0 <APDcCopy+0x1a1>
    13bb:	8b 45 14             	mov    0x14(%ebp),%eax
    13be:	8b 40 04             	mov    0x4(%eax),%eax
    13c1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13c4:	0f 8c 16 01 00 00    	jl     14e0 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13ca:	8b 45 08             	mov    0x8(%ebp),%eax
    13cd:	8b 00                	mov    (%eax),%eax
    13cf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13d2:	7f 0b                	jg     13df <APDcCopy+0xa0>
    13d4:	8b 45 08             	mov    0x8(%ebp),%eax
    13d7:	8b 00                	mov    (%eax),%eax
    13d9:	83 e8 01             	sub    $0x1,%eax
    13dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13df:	8b 45 08             	mov    0x8(%ebp),%eax
    13e2:	8b 40 04             	mov    0x4(%eax),%eax
    13e5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13e8:	7f 0c                	jg     13f6 <APDcCopy+0xb7>
    13ea:	8b 45 08             	mov    0x8(%ebp),%eax
    13ed:	8b 40 04             	mov    0x4(%eax),%eax
    13f0:	83 e8 01             	sub    $0x1,%eax
    13f3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13f6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13fd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1404:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    140b:	e9 bc 00 00 00       	jmp    14cc <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1410:	8b 45 08             	mov    0x8(%ebp),%eax
    1413:	8b 00                	mov    (%eax),%eax
    1415:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1418:	8b 55 10             	mov    0x10(%ebp),%edx
    141b:	01 ca                	add    %ecx,%edx
    141d:	0f af d0             	imul   %eax,%edx
    1420:	8b 45 0c             	mov    0xc(%ebp),%eax
    1423:	01 d0                	add    %edx,%eax
    1425:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1428:	8b 45 14             	mov    0x14(%ebp),%eax
    142b:	8b 00                	mov    (%eax),%eax
    142d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1430:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1433:	01 ca                	add    %ecx,%edx
    1435:	0f af d0             	imul   %eax,%edx
    1438:	8b 45 18             	mov    0x18(%ebp),%eax
    143b:	01 d0                	add    %edx,%eax
    143d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1440:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1447:	eb 74                	jmp    14bd <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1449:	8b 45 14             	mov    0x14(%ebp),%eax
    144c:	8b 50 18             	mov    0x18(%eax),%edx
    144f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1452:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1455:	01 c8                	add    %ecx,%eax
    1457:	89 c1                	mov    %eax,%ecx
    1459:	89 c8                	mov    %ecx,%eax
    145b:	01 c0                	add    %eax,%eax
    145d:	01 c8                	add    %ecx,%eax
    145f:	01 d0                	add    %edx,%eax
    1461:	0f b7 10             	movzwl (%eax),%edx
    1464:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1468:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    146c:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    146f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1473:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1477:	38 c2                	cmp    %al,%dl
    1479:	75 18                	jne    1493 <APDcCopy+0x154>
    147b:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    147f:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1483:	38 c2                	cmp    %al,%dl
    1485:	75 0c                	jne    1493 <APDcCopy+0x154>
    1487:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    148b:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    148f:	38 c2                	cmp    %al,%dl
    1491:	74 26                	je     14b9 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1493:	8b 45 08             	mov    0x8(%ebp),%eax
    1496:	8b 50 18             	mov    0x18(%eax),%edx
    1499:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    149c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149f:	01 c8                	add    %ecx,%eax
    14a1:	89 c1                	mov    %eax,%ecx
    14a3:	89 c8                	mov    %ecx,%eax
    14a5:	01 c0                	add    %eax,%eax
    14a7:	01 c8                	add    %ecx,%eax
    14a9:	01 d0                	add    %edx,%eax
    14ab:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    14af:	66 89 10             	mov    %dx,(%eax)
    14b2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14b6:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14b9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14c0:	2b 45 0c             	sub    0xc(%ebp),%eax
    14c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14c6:	7d 81                	jge    1449 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14cf:	2b 45 10             	sub    0x10(%ebp),%eax
    14d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14d5:	0f 8d 35 ff ff ff    	jge    1410 <APDcCopy+0xd1>
    14db:	eb 04                	jmp    14e1 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14dd:	90                   	nop
    14de:	eb 01                	jmp    14e1 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14e0:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14e1:	c9                   	leave  
    14e2:	c3                   	ret    

000014e3 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14e3:	55                   	push   %ebp
    14e4:	89 e5                	mov    %esp,%ebp
    14e6:	83 ec 1c             	sub    $0x1c,%esp
    14e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14ec:	8b 55 10             	mov    0x10(%ebp),%edx
    14ef:	8b 45 14             	mov    0x14(%ebp),%eax
    14f2:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14f5:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14f8:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14fb:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14ff:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1502:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1506:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1509:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    150d:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1510:	8b 45 08             	mov    0x8(%ebp),%eax
    1513:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1517:	66 89 10             	mov    %dx,(%eax)
    151a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    151e:	88 50 02             	mov    %dl,0x2(%eax)
}
    1521:	8b 45 08             	mov    0x8(%ebp),%eax
    1524:	c9                   	leave  
    1525:	c2 04 00             	ret    $0x4

00001528 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1528:	55                   	push   %ebp
    1529:	89 e5                	mov    %esp,%ebp
    152b:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    152e:	8b 45 08             	mov    0x8(%ebp),%eax
    1531:	8b 00                	mov    (%eax),%eax
    1533:	83 ec 08             	sub    $0x8,%esp
    1536:	8d 55 0c             	lea    0xc(%ebp),%edx
    1539:	52                   	push   %edx
    153a:	50                   	push   %eax
    153b:	e8 24 ee ff ff       	call   364 <sendMessage>
    1540:	83 c4 10             	add    $0x10,%esp
}
    1543:	90                   	nop
    1544:	c9                   	leave  
    1545:	c3                   	ret    

00001546 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1546:	55                   	push   %ebp
    1547:	89 e5                	mov    %esp,%ebp
    1549:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    154c:	83 ec 0c             	sub    $0xc,%esp
    154f:	68 98 00 00 00       	push   $0x98
    1554:	e8 f5 f1 ff ff       	call   74e <malloc>
    1559:	83 c4 10             	add    $0x10,%esp
    155c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    155f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1563:	75 15                	jne    157a <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1565:	83 ec 04             	sub    $0x4,%esp
    1568:	ff 75 08             	pushl  0x8(%ebp)
    156b:	68 b4 24 00 00       	push   $0x24b4
    1570:	6a 01                	push   $0x1
    1572:	e8 04 ef ff ff       	call   47b <printf>
    1577:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    157a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157d:	05 84 00 00 00       	add    $0x84,%eax
    1582:	83 ec 08             	sub    $0x8,%esp
    1585:	ff 75 08             	pushl  0x8(%ebp)
    1588:	50                   	push   %eax
    1589:	e8 fd ea ff ff       	call   8b <strcpy>
    158e:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1591:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1594:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a8:	8b 40 3c             	mov    0x3c(%eax),%eax
    15ab:	89 c2                	mov    %eax,%edx
    15ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b0:	8b 40 40             	mov    0x40(%eax),%eax
    15b3:	0f af d0             	imul   %eax,%edx
    15b6:	89 d0                	mov    %edx,%eax
    15b8:	01 c0                	add    %eax,%eax
    15ba:	01 d0                	add    %edx,%eax
    15bc:	83 ec 0c             	sub    $0xc,%esp
    15bf:	50                   	push   %eax
    15c0:	e8 89 f1 ff ff       	call   74e <malloc>
    15c5:	83 c4 10             	add    $0x10,%esp
    15c8:	89 c2                	mov    %eax,%edx
    15ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cd:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d3:	8b 40 54             	mov    0x54(%eax),%eax
    15d6:	85 c0                	test   %eax,%eax
    15d8:	75 15                	jne    15ef <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15da:	83 ec 04             	sub    $0x4,%esp
    15dd:	ff 75 08             	pushl  0x8(%ebp)
    15e0:	68 d4 24 00 00       	push   $0x24d4
    15e5:	6a 01                	push   $0x1
    15e7:	e8 8f ee ff ff       	call   47b <printf>
    15ec:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f2:	8b 40 3c             	mov    0x3c(%eax),%eax
    15f5:	89 c2                	mov    %eax,%edx
    15f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fa:	8b 40 40             	mov    0x40(%eax),%eax
    15fd:	0f af d0             	imul   %eax,%edx
    1600:	89 d0                	mov    %edx,%eax
    1602:	01 c0                	add    %eax,%eax
    1604:	01 c2                	add    %eax,%edx
    1606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1609:	8b 40 54             	mov    0x54(%eax),%eax
    160c:	83 ec 04             	sub    $0x4,%esp
    160f:	52                   	push   %edx
    1610:	68 ff ff ff 00       	push   $0xffffff
    1615:	50                   	push   %eax
    1616:	e8 06 eb ff ff       	call   121 <memset>
    161b:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    161e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1621:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1628:	e8 0f ed ff ff       	call   33c <getpid>
    162d:	89 c2                	mov    %eax,%edx
    162f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1632:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    163f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1642:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1649:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164c:	8b 40 58             	mov    0x58(%eax),%eax
    164f:	89 c2                	mov    %eax,%edx
    1651:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1654:	8b 40 5c             	mov    0x5c(%eax),%eax
    1657:	0f af d0             	imul   %eax,%edx
    165a:	89 d0                	mov    %edx,%eax
    165c:	01 c0                	add    %eax,%eax
    165e:	01 d0                	add    %edx,%eax
    1660:	83 ec 0c             	sub    $0xc,%esp
    1663:	50                   	push   %eax
    1664:	e8 e5 f0 ff ff       	call   74e <malloc>
    1669:	83 c4 10             	add    $0x10,%esp
    166c:	89 c2                	mov    %eax,%edx
    166e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1671:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1674:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1677:	8b 40 70             	mov    0x70(%eax),%eax
    167a:	85 c0                	test   %eax,%eax
    167c:	75 15                	jne    1693 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    167e:	83 ec 04             	sub    $0x4,%esp
    1681:	ff 75 08             	pushl  0x8(%ebp)
    1684:	68 f8 24 00 00       	push   $0x24f8
    1689:	6a 01                	push   $0x1
    168b:	e8 eb ed ff ff       	call   47b <printf>
    1690:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1693:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1696:	8b 40 3c             	mov    0x3c(%eax),%eax
    1699:	89 c2                	mov    %eax,%edx
    169b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169e:	8b 40 40             	mov    0x40(%eax),%eax
    16a1:	0f af d0             	imul   %eax,%edx
    16a4:	89 d0                	mov    %edx,%eax
    16a6:	01 c0                	add    %eax,%eax
    16a8:	01 c2                	add    %eax,%edx
    16aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ad:	8b 40 54             	mov    0x54(%eax),%eax
    16b0:	83 ec 04             	sub    $0x4,%esp
    16b3:	52                   	push   %edx
    16b4:	68 ff 00 00 00       	push   $0xff
    16b9:	50                   	push   %eax
    16ba:	e8 62 ea ff ff       	call   121 <memset>
    16bf:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c5:	8b 55 0c             	mov    0xc(%ebp),%edx
    16c8:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16cf:	74 49                	je     171a <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16d1:	8b 45 10             	mov    0x10(%ebp),%eax
    16d4:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16da:	83 ec 0c             	sub    $0xc,%esp
    16dd:	50                   	push   %eax
    16de:	e8 6b f0 ff ff       	call   74e <malloc>
    16e3:	83 c4 10             	add    $0x10,%esp
    16e6:	89 c2                	mov    %eax,%edx
    16e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16eb:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f1:	8b 55 10             	mov    0x10(%ebp),%edx
    16f4:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fa:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1701:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1704:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    170b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170e:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1715:	e9 8d 00 00 00       	jmp    17a7 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    171a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171d:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1724:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1727:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    172e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1731:	8b 40 20             	mov    0x20(%eax),%eax
    1734:	89 c2                	mov    %eax,%edx
    1736:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1739:	8b 40 24             	mov    0x24(%eax),%eax
    173c:	0f af d0             	imul   %eax,%edx
    173f:	89 d0                	mov    %edx,%eax
    1741:	01 c0                	add    %eax,%eax
    1743:	01 d0                	add    %edx,%eax
    1745:	83 ec 0c             	sub    $0xc,%esp
    1748:	50                   	push   %eax
    1749:	e8 00 f0 ff ff       	call   74e <malloc>
    174e:	83 c4 10             	add    $0x10,%esp
    1751:	89 c2                	mov    %eax,%edx
    1753:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1756:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175c:	8b 40 38             	mov    0x38(%eax),%eax
    175f:	85 c0                	test   %eax,%eax
    1761:	75 15                	jne    1778 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1763:	83 ec 04             	sub    $0x4,%esp
    1766:	ff 75 08             	pushl  0x8(%ebp)
    1769:	68 20 25 00 00       	push   $0x2520
    176e:	6a 01                	push   $0x1
    1770:	e8 06 ed ff ff       	call   47b <printf>
    1775:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1778:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177b:	8b 40 20             	mov    0x20(%eax),%eax
    177e:	89 c2                	mov    %eax,%edx
    1780:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1783:	8b 40 24             	mov    0x24(%eax),%eax
    1786:	0f af d0             	imul   %eax,%edx
    1789:	89 d0                	mov    %edx,%eax
    178b:	01 c0                	add    %eax,%eax
    178d:	01 c2                	add    %eax,%edx
    178f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1792:	8b 40 38             	mov    0x38(%eax),%eax
    1795:	83 ec 04             	sub    $0x4,%esp
    1798:	52                   	push   %edx
    1799:	68 ff ff ff 00       	push   $0xffffff
    179e:	50                   	push   %eax
    179f:	e8 7d e9 ff ff       	call   121 <memset>
    17a4:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    17a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17aa:	c9                   	leave  
    17ab:	c3                   	ret    

000017ac <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    17ac:	55                   	push   %ebp
    17ad:	89 e5                	mov    %esp,%ebp
    17af:	57                   	push   %edi
    17b0:	56                   	push   %esi
    17b1:	53                   	push   %ebx
    17b2:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17b8:	83 f8 03             	cmp    $0x3,%eax
    17bb:	74 02                	je     17bf <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17bd:	eb 7c                	jmp    183b <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17bf:	8b 45 08             	mov    0x8(%ebp),%eax
    17c2:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17c5:	8b 45 08             	mov    0x8(%ebp),%eax
    17c8:	8b 48 18             	mov    0x18(%eax),%ecx
    17cb:	8b 45 08             	mov    0x8(%ebp),%eax
    17ce:	8b 50 5c             	mov    0x5c(%eax),%edx
    17d1:	8b 45 08             	mov    0x8(%ebp),%eax
    17d4:	8b 40 58             	mov    0x58(%eax),%eax
    17d7:	8b 75 08             	mov    0x8(%ebp),%esi
    17da:	83 c6 58             	add    $0x58,%esi
    17dd:	83 ec 04             	sub    $0x4,%esp
    17e0:	53                   	push   %ebx
    17e1:	51                   	push   %ecx
    17e2:	6a 00                	push   $0x0
    17e4:	52                   	push   %edx
    17e5:	50                   	push   %eax
    17e6:	6a 00                	push   $0x0
    17e8:	6a 00                	push   $0x0
    17ea:	56                   	push   %esi
    17eb:	6a 00                	push   $0x0
    17ed:	6a 00                	push   $0x0
    17ef:	ff 75 08             	pushl  0x8(%ebp)
    17f2:	e8 65 eb ff ff       	call   35c <paintWindow>
    17f7:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    17fa:	8b 45 08             	mov    0x8(%ebp),%eax
    17fd:	8b 70 1c             	mov    0x1c(%eax),%esi
    1800:	8b 45 08             	mov    0x8(%ebp),%eax
    1803:	8b 58 18             	mov    0x18(%eax),%ebx
    1806:	8b 45 08             	mov    0x8(%ebp),%eax
    1809:	8b 48 08             	mov    0x8(%eax),%ecx
    180c:	8b 45 08             	mov    0x8(%ebp),%eax
    180f:	8b 50 40             	mov    0x40(%eax),%edx
    1812:	8b 45 08             	mov    0x8(%ebp),%eax
    1815:	8b 40 3c             	mov    0x3c(%eax),%eax
    1818:	8b 7d 08             	mov    0x8(%ebp),%edi
    181b:	83 c7 3c             	add    $0x3c,%edi
    181e:	83 ec 04             	sub    $0x4,%esp
    1821:	56                   	push   %esi
    1822:	53                   	push   %ebx
    1823:	51                   	push   %ecx
    1824:	52                   	push   %edx
    1825:	50                   	push   %eax
    1826:	6a 00                	push   $0x0
    1828:	6a 00                	push   $0x0
    182a:	57                   	push   %edi
    182b:	6a 32                	push   $0x32
    182d:	6a 00                	push   $0x0
    182f:	ff 75 08             	pushl  0x8(%ebp)
    1832:	e8 25 eb ff ff       	call   35c <paintWindow>
    1837:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    183a:	90                   	nop
        default: break;
            
            
    }
    return False;
    183b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1840:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1843:	5b                   	pop    %ebx
    1844:	5e                   	pop    %esi
    1845:	5f                   	pop    %edi
    1846:	5d                   	pop    %ebp
    1847:	c3                   	ret    

00001848 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1848:	55                   	push   %ebp
    1849:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    184b:	8b 45 0c             	mov    0xc(%ebp),%eax
    184e:	8b 50 08             	mov    0x8(%eax),%edx
    1851:	8b 45 08             	mov    0x8(%ebp),%eax
    1854:	8b 00                	mov    (%eax),%eax
    1856:	39 c2                	cmp    %eax,%edx
    1858:	74 07                	je     1861 <APPreJudge+0x19>
        return False;
    185a:	b8 00 00 00 00       	mov    $0x0,%eax
    185f:	eb 05                	jmp    1866 <APPreJudge+0x1e>
    return True;
    1861:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1866:	5d                   	pop    %ebp
    1867:	c3                   	ret    

00001868 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1868:	55                   	push   %ebp
    1869:	89 e5                	mov    %esp,%ebp
    186b:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    186e:	8b 45 08             	mov    0x8(%ebp),%eax
    1871:	8b 55 0c             	mov    0xc(%ebp),%edx
    1874:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    187a:	83 ec 0c             	sub    $0xc,%esp
    187d:	ff 75 08             	pushl  0x8(%ebp)
    1880:	e8 ef ea ff ff       	call   374 <registWindow>
    1885:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1888:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    188f:	8b 45 08             	mov    0x8(%ebp),%eax
    1892:	8b 00                	mov    (%eax),%eax
    1894:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1897:	ff 75 f4             	pushl  -0xc(%ebp)
    189a:	ff 75 f0             	pushl  -0x10(%ebp)
    189d:	ff 75 ec             	pushl  -0x14(%ebp)
    18a0:	ff 75 08             	pushl  0x8(%ebp)
    18a3:	e8 80 fc ff ff       	call   1528 <APSendMessage>
    18a8:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    18ab:	83 ec 0c             	sub    $0xc,%esp
    18ae:	ff 75 08             	pushl  0x8(%ebp)
    18b1:	e8 b6 ea ff ff       	call   36c <getMessage>
    18b6:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18b9:	8b 45 08             	mov    0x8(%ebp),%eax
    18bc:	83 c0 74             	add    $0x74,%eax
    18bf:	83 ec 08             	sub    $0x8,%esp
    18c2:	50                   	push   %eax
    18c3:	ff 75 08             	pushl  0x8(%ebp)
    18c6:	e8 7d ff ff ff       	call   1848 <APPreJudge>
    18cb:	83 c4 10             	add    $0x10,%esp
    18ce:	84 c0                	test   %al,%al
    18d0:	74 1b                	je     18ed <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    18d2:	8b 45 08             	mov    0x8(%ebp),%eax
    18d5:	ff 70 7c             	pushl  0x7c(%eax)
    18d8:	ff 70 78             	pushl  0x78(%eax)
    18db:	ff 70 74             	pushl  0x74(%eax)
    18de:	ff 75 08             	pushl  0x8(%ebp)
    18e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e4:	ff d0                	call   *%eax
    18e6:	83 c4 10             	add    $0x10,%esp
    18e9:	84 c0                	test   %al,%al
    18eb:	75 0c                	jne    18f9 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18ed:	8b 45 08             	mov    0x8(%ebp),%eax
    18f0:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    18f7:	eb b2                	jmp    18ab <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18f9:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18fa:	90                   	nop
    18fb:	c9                   	leave  
    18fc:	c3                   	ret    

000018fd <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    18fd:	55                   	push   %ebp
    18fe:	89 e5                	mov    %esp,%ebp
    1900:	57                   	push   %edi
    1901:	56                   	push   %esi
    1902:	53                   	push   %ebx
    1903:	83 ec 7c             	sub    $0x7c,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1906:	8d 45 88             	lea    -0x78(%ebp),%eax
    1909:	6a 08                	push   $0x8
    190b:	6a 08                	push   $0x8
    190d:	6a 08                	push   $0x8
    190f:	50                   	push   %eax
    1910:	e8 ce fb ff ff       	call   14e3 <RGB>
    1915:	83 c4 0c             	add    $0xc,%esp
    1918:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    191c:	66 89 45 bd          	mov    %ax,-0x43(%ebp)
    1920:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1924:	88 45 bf             	mov    %al,-0x41(%ebp)
    APSetFont(&wnd->TitleDc,font);
    1927:	8b 45 08             	mov    0x8(%ebp),%eax
    192a:	8d 58 58             	lea    0x58(%eax),%ebx
    192d:	8d 55 88             	lea    -0x78(%ebp),%edx
    1930:	83 ec 04             	sub    $0x4,%esp
    1933:	83 ec 04             	sub    $0x4,%esp
    1936:	89 e0                	mov    %esp,%eax
    1938:	0f b7 4d bd          	movzwl -0x43(%ebp),%ecx
    193c:	66 89 08             	mov    %cx,(%eax)
    193f:	0f b6 4d bf          	movzbl -0x41(%ebp),%ecx
    1943:	88 48 02             	mov    %cl,0x2(%eax)
    1946:	53                   	push   %ebx
    1947:	52                   	push   %edx
    1948:	e8 fe f2 ff ff       	call   c4b <APSetFont>
    194d:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    1950:	8b 45 08             	mov    0x8(%ebp),%eax
    1953:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
    195c:	83 c0 58             	add    $0x58,%eax
    195f:	6a 14                	push   $0x14
    1961:	6a 14                	push   $0x14
    1963:	52                   	push   %edx
    1964:	50                   	push   %eax
    1965:	e8 ce f8 ff ff       	call   1238 <APDrawText>
    196a:	83 c4 10             	add    $0x10,%esp
    
    if (!iconReady)
    196d:	a1 24 68 00 00       	mov    0x6824,%eax
    1972:	85 c0                	test   %eax,%eax
    1974:	0f 85 7a 02 00 00    	jne    1bf4 <APGridPaint+0x2f7>
    {
        iconReady = 1;
    197a:	c7 05 24 68 00 00 01 	movl   $0x1,0x6824
    1981:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1984:	8d 45 88             	lea    -0x78(%ebp),%eax
    1987:	83 ec 08             	sub    $0x8,%esp
    198a:	68 47 25 00 00       	push   $0x2547
    198f:	50                   	push   %eax
    1990:	e8 6c ef ff ff       	call   901 <APLoadBitmap>
    1995:	83 c4 0c             	add    $0xc,%esp
    1998:	8b 45 88             	mov    -0x78(%ebp),%eax
    199b:	a3 48 68 00 00       	mov    %eax,0x6848
    19a0:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19a3:	a3 4c 68 00 00       	mov    %eax,0x684c
    19a8:	8b 45 90             	mov    -0x70(%ebp),%eax
    19ab:	a3 50 68 00 00       	mov    %eax,0x6850
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    19b0:	83 ec 04             	sub    $0x4,%esp
    19b3:	ff 35 50 68 00 00    	pushl  0x6850
    19b9:	ff 35 4c 68 00 00    	pushl  0x684c
    19bf:	ff 35 48 68 00 00    	pushl  0x6848
    19c5:	e8 71 f1 ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    19ca:	83 c4 10             	add    $0x10,%esp
    19cd:	a3 54 68 00 00       	mov    %eax,0x6854
        grid_river = APLoadBitmap ("grid_river.bmp");
    19d2:	8d 45 88             	lea    -0x78(%ebp),%eax
    19d5:	83 ec 08             	sub    $0x8,%esp
    19d8:	68 55 25 00 00       	push   $0x2555
    19dd:	50                   	push   %eax
    19de:	e8 1e ef ff ff       	call   901 <APLoadBitmap>
    19e3:	83 c4 0c             	add    $0xc,%esp
    19e6:	8b 45 88             	mov    -0x78(%ebp),%eax
    19e9:	a3 90 68 00 00       	mov    %eax,0x6890
    19ee:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19f1:	a3 94 68 00 00       	mov    %eax,0x6894
    19f6:	8b 45 90             	mov    -0x70(%ebp),%eax
    19f9:	a3 98 68 00 00       	mov    %eax,0x6898
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    19fe:	83 ec 04             	sub    $0x4,%esp
    1a01:	ff 35 98 68 00 00    	pushl  0x6898
    1a07:	ff 35 94 68 00 00    	pushl  0x6894
    1a0d:	ff 35 90 68 00 00    	pushl  0x6890
    1a13:	e8 23 f1 ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    1a18:	83 c4 10             	add    $0x10,%esp
    1a1b:	a3 80 68 00 00       	mov    %eax,0x6880
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1a20:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a23:	83 ec 08             	sub    $0x8,%esp
    1a26:	68 64 25 00 00       	push   $0x2564
    1a2b:	50                   	push   %eax
    1a2c:	e8 d0 ee ff ff       	call   901 <APLoadBitmap>
    1a31:	83 c4 0c             	add    $0xc,%esp
    1a34:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a37:	a3 84 68 00 00       	mov    %eax,0x6884
    1a3c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a3f:	a3 88 68 00 00       	mov    %eax,0x6888
    1a44:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a47:	a3 8c 68 00 00       	mov    %eax,0x688c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a4c:	83 ec 04             	sub    $0x4,%esp
    1a4f:	ff 35 8c 68 00 00    	pushl  0x688c
    1a55:	ff 35 88 68 00 00    	pushl  0x6888
    1a5b:	ff 35 84 68 00 00    	pushl  0x6884
    1a61:	e8 d5 f0 ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    1a66:	83 c4 10             	add    $0x10,%esp
    1a69:	a3 28 68 00 00       	mov    %eax,0x6828
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1a6e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a71:	83 ec 08             	sub    $0x8,%esp
    1a74:	68 73 25 00 00       	push   $0x2573
    1a79:	50                   	push   %eax
    1a7a:	e8 82 ee ff ff       	call   901 <APLoadBitmap>
    1a7f:	83 c4 0c             	add    $0xc,%esp
    1a82:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a85:	a3 5c 68 00 00       	mov    %eax,0x685c
    1a8a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a8d:	a3 60 68 00 00       	mov    %eax,0x6860
    1a92:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a95:	a3 64 68 00 00       	mov    %eax,0x6864
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a9a:	83 ec 04             	sub    $0x4,%esp
    1a9d:	ff 35 64 68 00 00    	pushl  0x6864
    1aa3:	ff 35 60 68 00 00    	pushl  0x6860
    1aa9:	ff 35 5c 68 00 00    	pushl  0x685c
    1aaf:	e8 87 f0 ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    1ab4:	83 c4 10             	add    $0x10,%esp
    1ab7:	a3 a0 68 00 00       	mov    %eax,0x68a0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1abc:	8d 45 88             	lea    -0x78(%ebp),%eax
    1abf:	83 ec 08             	sub    $0x8,%esp
    1ac2:	68 81 25 00 00       	push   $0x2581
    1ac7:	50                   	push   %eax
    1ac8:	e8 34 ee ff ff       	call   901 <APLoadBitmap>
    1acd:	83 c4 0c             	add    $0xc,%esp
    1ad0:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ad3:	a3 38 68 00 00       	mov    %eax,0x6838
    1ad8:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1adb:	a3 3c 68 00 00       	mov    %eax,0x683c
    1ae0:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ae3:	a3 40 68 00 00       	mov    %eax,0x6840
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1ae8:	83 ec 04             	sub    $0x4,%esp
    1aeb:	ff 35 40 68 00 00    	pushl  0x6840
    1af1:	ff 35 3c 68 00 00    	pushl  0x683c
    1af7:	ff 35 38 68 00 00    	pushl  0x6838
    1afd:	e8 39 f0 ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    1b02:	83 c4 10             	add    $0x10,%esp
    1b05:	a3 58 68 00 00       	mov    %eax,0x6858
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1b0a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b0d:	83 ec 08             	sub    $0x8,%esp
    1b10:	68 91 25 00 00       	push   $0x2591
    1b15:	50                   	push   %eax
    1b16:	e8 e6 ed ff ff       	call   901 <APLoadBitmap>
    1b1b:	83 c4 0c             	add    $0xc,%esp
    1b1e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b21:	a3 2c 68 00 00       	mov    %eax,0x682c
    1b26:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b29:	a3 30 68 00 00       	mov    %eax,0x6830
    1b2e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b31:	a3 34 68 00 00       	mov    %eax,0x6834
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1b36:	83 ec 04             	sub    $0x4,%esp
    1b39:	ff 35 34 68 00 00    	pushl  0x6834
    1b3f:	ff 35 30 68 00 00    	pushl  0x6830
    1b45:	ff 35 2c 68 00 00    	pushl  0x682c
    1b4b:	e8 eb ef ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    1b50:	83 c4 10             	add    $0x10,%esp
    1b53:	a3 44 68 00 00       	mov    %eax,0x6844
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b58:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b5b:	83 ec 08             	sub    $0x8,%esp
    1b5e:	68 a3 25 00 00       	push   $0x25a3
    1b63:	50                   	push   %eax
    1b64:	e8 98 ed ff ff       	call   901 <APLoadBitmap>
    1b69:	83 c4 0c             	add    $0xc,%esp
    1b6c:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b6f:	a3 74 68 00 00       	mov    %eax,0x6874
    1b74:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b77:	a3 78 68 00 00       	mov    %eax,0x6878
    1b7c:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b7f:	a3 7c 68 00 00       	mov    %eax,0x687c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b84:	83 ec 04             	sub    $0x4,%esp
    1b87:	ff 35 7c 68 00 00    	pushl  0x687c
    1b8d:	ff 35 78 68 00 00    	pushl  0x6878
    1b93:	ff 35 74 68 00 00    	pushl  0x6874
    1b99:	e8 9d ef ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    1b9e:	83 c4 10             	add    $0x10,%esp
    1ba1:	a3 a4 68 00 00       	mov    %eax,0x68a4
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1ba6:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ba9:	83 ec 08             	sub    $0x8,%esp
    1bac:	68 b2 25 00 00       	push   $0x25b2
    1bb1:	50                   	push   %eax
    1bb2:	e8 4a ed ff ff       	call   901 <APLoadBitmap>
    1bb7:	83 c4 0c             	add    $0xc,%esp
    1bba:	8b 45 88             	mov    -0x78(%ebp),%eax
    1bbd:	a3 68 68 00 00       	mov    %eax,0x6868
    1bc2:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1bc5:	a3 6c 68 00 00       	mov    %eax,0x686c
    1bca:	8b 45 90             	mov    -0x70(%ebp),%eax
    1bcd:	a3 70 68 00 00       	mov    %eax,0x6870
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1bd2:	83 ec 04             	sub    $0x4,%esp
    1bd5:	ff 35 70 68 00 00    	pushl  0x6870
    1bdb:	ff 35 6c 68 00 00    	pushl  0x686c
    1be1:	ff 35 68 68 00 00    	pushl  0x6868
    1be7:	e8 4f ef ff ff       	call   b3b <APCreateCompatibleDCFromBitmap>
    1bec:	83 c4 10             	add    $0x10,%esp
    1bef:	a3 9c 68 00 00       	mov    %eax,0x689c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1bf4:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf7:	8b 40 08             	mov    0x8(%eax),%eax
    1bfa:	85 c0                	test   %eax,%eax
    1bfc:	75 17                	jne    1c15 <APGridPaint+0x318>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1bfe:	83 ec 08             	sub    $0x8,%esp
    1c01:	68 c4 25 00 00       	push   $0x25c4
    1c06:	6a 01                	push   $0x1
    1c08:	e8 6e e8 ff ff       	call   47b <printf>
    1c0d:	83 c4 10             	add    $0x10,%esp
        return;
    1c10:	e9 fe 04 00 00       	jmp    2113 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c15:	8b 45 08             	mov    0x8(%ebp),%eax
    1c18:	8b 40 10             	mov    0x10(%eax),%eax
    1c1b:	85 c0                	test   %eax,%eax
    1c1d:	7e 10                	jle    1c2f <APGridPaint+0x332>
    1c1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c22:	8b 50 14             	mov    0x14(%eax),%edx
    1c25:	8b 45 08             	mov    0x8(%ebp),%eax
    1c28:	8b 40 10             	mov    0x10(%eax),%eax
    1c2b:	39 c2                	cmp    %eax,%edx
    1c2d:	7c 17                	jl     1c46 <APGridPaint+0x349>
    {
        printf(1,"Grid mode page error!");
    1c2f:	83 ec 08             	sub    $0x8,%esp
    1c32:	68 ea 25 00 00       	push   $0x25ea
    1c37:	6a 01                	push   $0x1
    1c39:	e8 3d e8 ff ff       	call   47b <printf>
    1c3e:	83 c4 10             	add    $0x10,%esp
        return;
    1c41:	e9 cd 04 00 00       	jmp    2113 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1c46:	8b 45 08             	mov    0x8(%ebp),%eax
    1c49:	8b 40 14             	mov    0x14(%eax),%eax
    1c4c:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1c52:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1c55:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c58:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c5b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c62:	e9 f4 03 00 00       	jmp    205b <APGridPaint+0x75e>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c67:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1c6e:	e9 da 03 00 00       	jmp    204d <APGridPaint+0x750>
        {
            index = start + GRID_W_NUMBER * j + i;
    1c73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c76:	c1 e0 04             	shl    $0x4,%eax
    1c79:	89 c2                	mov    %eax,%edx
    1c7b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c7e:	01 c2                	add    %eax,%edx
    1c80:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c83:	01 d0                	add    %edx,%eax
    1c85:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1c88:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8b:	8b 40 0c             	mov    0xc(%eax),%eax
    1c8e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1c91:	c1 e2 02             	shl    $0x2,%edx
    1c94:	01 d0                	add    %edx,%eax
    1c96:	8b 00                	mov    (%eax),%eax
    1c98:	83 f8 0a             	cmp    $0xa,%eax
    1c9b:	0f 87 a7 03 00 00    	ja     2048 <APGridPaint+0x74b>
    1ca1:	8b 04 85 00 26 00 00 	mov    0x2600(,%eax,4),%eax
    1ca8:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1caa:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1cad:	6a 0c                	push   $0xc
    1caf:	6a 0c                	push   $0xc
    1cb1:	6a 0c                	push   $0xc
    1cb3:	50                   	push   %eax
    1cb4:	e8 2a f8 ff ff       	call   14e3 <RGB>
    1cb9:	83 c4 0c             	add    $0xc,%esp
    1cbc:	8b 1d 54 68 00 00    	mov    0x6854,%ebx
    1cc2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cc5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ccb:	6b c0 32             	imul   $0x32,%eax,%eax
    1cce:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1cd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd4:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cd7:	83 ec 0c             	sub    $0xc,%esp
    1cda:	83 ec 04             	sub    $0x4,%esp
    1cdd:	89 e0                	mov    %esp,%eax
    1cdf:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1ce3:	66 89 30             	mov    %si,(%eax)
    1ce6:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1cea:	88 50 02             	mov    %dl,0x2(%eax)
    1ced:	6a 32                	push   $0x32
    1cef:	6a 32                	push   $0x32
    1cf1:	6a 00                	push   $0x0
    1cf3:	6a 00                	push   $0x0
    1cf5:	53                   	push   %ebx
    1cf6:	51                   	push   %ecx
    1cf7:	ff 75 84             	pushl  -0x7c(%ebp)
    1cfa:	57                   	push   %edi
    1cfb:	e8 3f f6 ff ff       	call   133f <APDcCopy>
    1d00:	83 c4 30             	add    $0x30,%esp
                    break;
    1d03:	e9 41 03 00 00       	jmp    2049 <APGridPaint+0x74c>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d08:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d0b:	6a 69                	push   $0x69
    1d0d:	6a 69                	push   $0x69
    1d0f:	6a 69                	push   $0x69
    1d11:	50                   	push   %eax
    1d12:	e8 cc f7 ff ff       	call   14e3 <RGB>
    1d17:	83 c4 0c             	add    $0xc,%esp
    1d1a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1d1e:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1d22:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1d26:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1d29:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d30:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d33:	6a 69                	push   $0x69
    1d35:	6a 69                	push   $0x69
    1d37:	6a 69                	push   $0x69
    1d39:	50                   	push   %eax
    1d3a:	e8 a4 f7 ff ff       	call   14e3 <RGB>
    1d3f:	83 c4 0c             	add    $0xc,%esp
    1d42:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1d46:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1d4a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1d4e:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d51:	8b 45 08             	mov    0x8(%ebp),%eax
    1d54:	8d 50 3c             	lea    0x3c(%eax),%edx
    1d57:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d5a:	ff 75 ac             	pushl  -0x54(%ebp)
    1d5d:	ff 75 a8             	pushl  -0x58(%ebp)
    1d60:	52                   	push   %edx
    1d61:	50                   	push   %eax
    1d62:	e8 69 ee ff ff       	call   bd0 <APSetPen>
    1d67:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6d:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1d70:	8d 55 88             	lea    -0x78(%ebp),%edx
    1d73:	83 ec 04             	sub    $0x4,%esp
    1d76:	83 ec 04             	sub    $0x4,%esp
    1d79:	89 e0                	mov    %esp,%eax
    1d7b:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1d7f:	66 89 08             	mov    %cx,(%eax)
    1d82:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1d86:	88 48 02             	mov    %cl,0x2(%eax)
    1d89:	53                   	push   %ebx
    1d8a:	52                   	push   %edx
    1d8b:	e8 79 ee ff ff       	call   c09 <APSetBrush>
    1d90:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d96:	6b d0 32             	imul   $0x32,%eax,%edx
    1d99:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d9c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d9f:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1da2:	83 c1 3c             	add    $0x3c,%ecx
    1da5:	83 ec 0c             	sub    $0xc,%esp
    1da8:	6a 32                	push   $0x32
    1daa:	6a 32                	push   $0x32
    1dac:	52                   	push   %edx
    1dad:	50                   	push   %eax
    1dae:	51                   	push   %ecx
    1daf:	e8 7f f2 ff ff       	call   1033 <APDrawRect>
    1db4:	83 c4 20             	add    $0x20,%esp
                    break;
    1db7:	e9 8d 02 00 00       	jmp    2049 <APGridPaint+0x74c>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dbc:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1dbf:	6a 0c                	push   $0xc
    1dc1:	6a 0c                	push   $0xc
    1dc3:	6a 0c                	push   $0xc
    1dc5:	50                   	push   %eax
    1dc6:	e8 18 f7 ff ff       	call   14e3 <RGB>
    1dcb:	83 c4 0c             	add    $0xc,%esp
    1dce:	8b 1d a4 68 00 00    	mov    0x68a4,%ebx
    1dd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dd7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dda:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ddd:	6b c0 32             	imul   $0x32,%eax,%eax
    1de0:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1de3:	8b 45 08             	mov    0x8(%ebp),%eax
    1de6:	8d 78 3c             	lea    0x3c(%eax),%edi
    1de9:	83 ec 0c             	sub    $0xc,%esp
    1dec:	83 ec 04             	sub    $0x4,%esp
    1def:	89 e0                	mov    %esp,%eax
    1df1:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1df5:	66 89 30             	mov    %si,(%eax)
    1df8:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1dfc:	88 50 02             	mov    %dl,0x2(%eax)
    1dff:	6a 32                	push   $0x32
    1e01:	6a 32                	push   $0x32
    1e03:	6a 00                	push   $0x0
    1e05:	6a 00                	push   $0x0
    1e07:	53                   	push   %ebx
    1e08:	51                   	push   %ecx
    1e09:	ff 75 84             	pushl  -0x7c(%ebp)
    1e0c:	57                   	push   %edi
    1e0d:	e8 2d f5 ff ff       	call   133f <APDcCopy>
    1e12:	83 c4 30             	add    $0x30,%esp
                    break;
    1e15:	e9 2f 02 00 00       	jmp    2049 <APGridPaint+0x74c>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e1a:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e1d:	6a 0c                	push   $0xc
    1e1f:	6a 0c                	push   $0xc
    1e21:	6a 0c                	push   $0xc
    1e23:	50                   	push   %eax
    1e24:	e8 ba f6 ff ff       	call   14e3 <RGB>
    1e29:	83 c4 0c             	add    $0xc,%esp
    1e2c:	8b 1d 80 68 00 00    	mov    0x6880,%ebx
    1e32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e35:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e38:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e3b:	6b c0 32             	imul   $0x32,%eax,%eax
    1e3e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e41:	8b 45 08             	mov    0x8(%ebp),%eax
    1e44:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e47:	83 ec 0c             	sub    $0xc,%esp
    1e4a:	83 ec 04             	sub    $0x4,%esp
    1e4d:	89 e0                	mov    %esp,%eax
    1e4f:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e53:	66 89 30             	mov    %si,(%eax)
    1e56:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e5a:	88 50 02             	mov    %dl,0x2(%eax)
    1e5d:	6a 32                	push   $0x32
    1e5f:	6a 32                	push   $0x32
    1e61:	6a 00                	push   $0x0
    1e63:	6a 00                	push   $0x0
    1e65:	53                   	push   %ebx
    1e66:	51                   	push   %ecx
    1e67:	ff 75 84             	pushl  -0x7c(%ebp)
    1e6a:	57                   	push   %edi
    1e6b:	e8 cf f4 ff ff       	call   133f <APDcCopy>
    1e70:	83 c4 30             	add    $0x30,%esp
                    break;
    1e73:	e9 d1 01 00 00       	jmp    2049 <APGridPaint+0x74c>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e78:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e7b:	6a 0c                	push   $0xc
    1e7d:	6a 0c                	push   $0xc
    1e7f:	6a 0c                	push   $0xc
    1e81:	50                   	push   %eax
    1e82:	e8 5c f6 ff ff       	call   14e3 <RGB>
    1e87:	83 c4 0c             	add    $0xc,%esp
    1e8a:	8b 1d 58 68 00 00    	mov    0x6858,%ebx
    1e90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e93:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e96:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e99:	6b c0 32             	imul   $0x32,%eax,%eax
    1e9c:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea2:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ea5:	83 ec 0c             	sub    $0xc,%esp
    1ea8:	83 ec 04             	sub    $0x4,%esp
    1eab:	89 e0                	mov    %esp,%eax
    1ead:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1eb1:	66 89 30             	mov    %si,(%eax)
    1eb4:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1eb8:	88 50 02             	mov    %dl,0x2(%eax)
    1ebb:	6a 32                	push   $0x32
    1ebd:	6a 32                	push   $0x32
    1ebf:	6a 00                	push   $0x0
    1ec1:	6a 00                	push   $0x0
    1ec3:	53                   	push   %ebx
    1ec4:	51                   	push   %ecx
    1ec5:	ff 75 84             	pushl  -0x7c(%ebp)
    1ec8:	57                   	push   %edi
    1ec9:	e8 71 f4 ff ff       	call   133f <APDcCopy>
    1ece:	83 c4 30             	add    $0x30,%esp
                    break;
    1ed1:	e9 73 01 00 00       	jmp    2049 <APGridPaint+0x74c>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ed6:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ed9:	6a 0c                	push   $0xc
    1edb:	6a 0c                	push   $0xc
    1edd:	6a 0c                	push   $0xc
    1edf:	50                   	push   %eax
    1ee0:	e8 fe f5 ff ff       	call   14e3 <RGB>
    1ee5:	83 c4 0c             	add    $0xc,%esp
    1ee8:	8b 1d a0 68 00 00    	mov    0x68a0,%ebx
    1eee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ef4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ef7:	6b c0 32             	imul   $0x32,%eax,%eax
    1efa:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1efd:	8b 45 08             	mov    0x8(%ebp),%eax
    1f00:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f03:	83 ec 0c             	sub    $0xc,%esp
    1f06:	83 ec 04             	sub    $0x4,%esp
    1f09:	89 e0                	mov    %esp,%eax
    1f0b:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f0f:	66 89 30             	mov    %si,(%eax)
    1f12:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f16:	88 50 02             	mov    %dl,0x2(%eax)
    1f19:	6a 32                	push   $0x32
    1f1b:	6a 32                	push   $0x32
    1f1d:	6a 00                	push   $0x0
    1f1f:	6a 00                	push   $0x0
    1f21:	53                   	push   %ebx
    1f22:	51                   	push   %ecx
    1f23:	ff 75 84             	pushl  -0x7c(%ebp)
    1f26:	57                   	push   %edi
    1f27:	e8 13 f4 ff ff       	call   133f <APDcCopy>
    1f2c:	83 c4 30             	add    $0x30,%esp
                    break;
    1f2f:	e9 15 01 00 00       	jmp    2049 <APGridPaint+0x74c>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f34:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f37:	6a 0c                	push   $0xc
    1f39:	6a 0c                	push   $0xc
    1f3b:	6a 0c                	push   $0xc
    1f3d:	50                   	push   %eax
    1f3e:	e8 a0 f5 ff ff       	call   14e3 <RGB>
    1f43:	83 c4 0c             	add    $0xc,%esp
    1f46:	8b 1d 28 68 00 00    	mov    0x6828,%ebx
    1f4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f4f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f52:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f55:	6b c0 32             	imul   $0x32,%eax,%eax
    1f58:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f61:	83 ec 0c             	sub    $0xc,%esp
    1f64:	83 ec 04             	sub    $0x4,%esp
    1f67:	89 e0                	mov    %esp,%eax
    1f69:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f6d:	66 89 30             	mov    %si,(%eax)
    1f70:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f74:	88 50 02             	mov    %dl,0x2(%eax)
    1f77:	6a 32                	push   $0x32
    1f79:	6a 32                	push   $0x32
    1f7b:	6a 00                	push   $0x0
    1f7d:	6a 00                	push   $0x0
    1f7f:	53                   	push   %ebx
    1f80:	51                   	push   %ecx
    1f81:	ff 75 84             	pushl  -0x7c(%ebp)
    1f84:	57                   	push   %edi
    1f85:	e8 b5 f3 ff ff       	call   133f <APDcCopy>
    1f8a:	83 c4 30             	add    $0x30,%esp
                    break;
    1f8d:	e9 b7 00 00 00       	jmp    2049 <APGridPaint+0x74c>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f92:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f95:	6a 0c                	push   $0xc
    1f97:	6a 0c                	push   $0xc
    1f99:	6a 0c                	push   $0xc
    1f9b:	50                   	push   %eax
    1f9c:	e8 42 f5 ff ff       	call   14e3 <RGB>
    1fa1:	83 c4 0c             	add    $0xc,%esp
    1fa4:	8b 1d 44 68 00 00    	mov    0x6844,%ebx
    1faa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fad:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fb0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fb3:	6b c0 32             	imul   $0x32,%eax,%eax
    1fb6:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1fb9:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbc:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fbf:	83 ec 0c             	sub    $0xc,%esp
    1fc2:	83 ec 04             	sub    $0x4,%esp
    1fc5:	89 e0                	mov    %esp,%eax
    1fc7:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1fcb:	66 89 30             	mov    %si,(%eax)
    1fce:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1fd2:	88 50 02             	mov    %dl,0x2(%eax)
    1fd5:	6a 32                	push   $0x32
    1fd7:	6a 32                	push   $0x32
    1fd9:	6a 00                	push   $0x0
    1fdb:	6a 00                	push   $0x0
    1fdd:	53                   	push   %ebx
    1fde:	51                   	push   %ecx
    1fdf:	ff 75 84             	pushl  -0x7c(%ebp)
    1fe2:	57                   	push   %edi
    1fe3:	e8 57 f3 ff ff       	call   133f <APDcCopy>
    1fe8:	83 c4 30             	add    $0x30,%esp
                    break;
    1feb:	eb 5c                	jmp    2049 <APGridPaint+0x74c>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fed:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ff0:	6a 0c                	push   $0xc
    1ff2:	6a 0c                	push   $0xc
    1ff4:	6a 0c                	push   $0xc
    1ff6:	50                   	push   %eax
    1ff7:	e8 e7 f4 ff ff       	call   14e3 <RGB>
    1ffc:	83 c4 0c             	add    $0xc,%esp
    1fff:	8b 1d 9c 68 00 00    	mov    0x689c,%ebx
    2005:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2008:	6b c8 32             	imul   $0x32,%eax,%ecx
    200b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    200e:	6b c0 32             	imul   $0x32,%eax,%eax
    2011:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2014:	8b 45 08             	mov    0x8(%ebp),%eax
    2017:	8d 78 3c             	lea    0x3c(%eax),%edi
    201a:	83 ec 0c             	sub    $0xc,%esp
    201d:	83 ec 04             	sub    $0x4,%esp
    2020:	89 e0                	mov    %esp,%eax
    2022:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2026:	66 89 30             	mov    %si,(%eax)
    2029:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    202d:	88 50 02             	mov    %dl,0x2(%eax)
    2030:	6a 32                	push   $0x32
    2032:	6a 32                	push   $0x32
    2034:	6a 00                	push   $0x0
    2036:	6a 00                	push   $0x0
    2038:	53                   	push   %ebx
    2039:	51                   	push   %ecx
    203a:	ff 75 84             	pushl  -0x7c(%ebp)
    203d:	57                   	push   %edi
    203e:	e8 fc f2 ff ff       	call   133f <APDcCopy>
    2043:	83 c4 30             	add    $0x30,%esp
                    break;
    2046:	eb 01                	jmp    2049 <APGridPaint+0x74c>
                default: break;
    2048:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2049:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    204d:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2051:	0f 8e 1c fc ff ff    	jle    1c73 <APGridPaint+0x376>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2057:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    205b:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    205f:	0f 8e 02 fc ff ff    	jle    1c67 <APGridPaint+0x36a>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2065:	8d 45 88             	lea    -0x78(%ebp),%eax
    2068:	68 cd 00 00 00       	push   $0xcd
    206d:	6a 74                	push   $0x74
    206f:	6a 18                	push   $0x18
    2071:	50                   	push   %eax
    2072:	e8 6c f4 ff ff       	call   14e3 <RGB>
    2077:	83 c4 0c             	add    $0xc,%esp
    207a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    207e:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2082:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2086:	88 45 b6             	mov    %al,-0x4a(%ebp)
    pen.size = 1;
    2089:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2090:	8d 45 88             	lea    -0x78(%ebp),%eax
    2093:	68 cd 00 00 00       	push   $0xcd
    2098:	6a 74                	push   $0x74
    209a:	6a 18                	push   $0x18
    209c:	50                   	push   %eax
    209d:	e8 41 f4 ff ff       	call   14e3 <RGB>
    20a2:	83 c4 0c             	add    $0xc,%esp
    20a5:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20a9:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    20ad:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20b1:	88 45 b3             	mov    %al,-0x4d(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    20b4:	8b 45 08             	mov    0x8(%ebp),%eax
    20b7:	8d 50 58             	lea    0x58(%eax),%edx
    20ba:	8d 45 88             	lea    -0x78(%ebp),%eax
    20bd:	ff 75 b8             	pushl  -0x48(%ebp)
    20c0:	ff 75 b4             	pushl  -0x4c(%ebp)
    20c3:	52                   	push   %edx
    20c4:	50                   	push   %eax
    20c5:	e8 06 eb ff ff       	call   bd0 <APSetPen>
    20ca:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    20cd:	8b 45 08             	mov    0x8(%ebp),%eax
    20d0:	8d 58 58             	lea    0x58(%eax),%ebx
    20d3:	8d 55 88             	lea    -0x78(%ebp),%edx
    20d6:	83 ec 04             	sub    $0x4,%esp
    20d9:	83 ec 04             	sub    $0x4,%esp
    20dc:	89 e0                	mov    %esp,%eax
    20de:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    20e2:	66 89 08             	mov    %cx,(%eax)
    20e5:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    20e9:	88 48 02             	mov    %cl,0x2(%eax)
    20ec:	53                   	push   %ebx
    20ed:	52                   	push   %edx
    20ee:	e8 16 eb ff ff       	call   c09 <APSetBrush>
    20f3:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    20f6:	8b 45 08             	mov    0x8(%ebp),%eax
    20f9:	83 c0 58             	add    $0x58,%eax
    20fc:	83 ec 0c             	sub    $0xc,%esp
    20ff:	6a 32                	push   $0x32
    2101:	68 20 03 00 00       	push   $0x320
    2106:	6a 00                	push   $0x0
    2108:	6a 00                	push   $0x0
    210a:	50                   	push   %eax
    210b:	e8 23 ef ff ff       	call   1033 <APDrawRect>
    2110:	83 c4 20             	add    $0x20,%esp
    
    
}
    2113:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2116:	5b                   	pop    %ebx
    2117:	5e                   	pop    %esi
    2118:	5f                   	pop    %edi
    2119:	5d                   	pop    %ebp
    211a:	c3                   	ret    

0000211b <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    211b:	55                   	push   %ebp
    211c:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    211e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2122:	7e 08                	jle    212c <random+0x11>
{
rand_num = seed;
    2124:	8b 45 08             	mov    0x8(%ebp),%eax
    2127:	a3 00 68 00 00       	mov    %eax,0x6800
}
rand_num *= 3;
    212c:	8b 15 00 68 00 00    	mov    0x6800,%edx
    2132:	89 d0                	mov    %edx,%eax
    2134:	01 c0                	add    %eax,%eax
    2136:	01 d0                	add    %edx,%eax
    2138:	a3 00 68 00 00       	mov    %eax,0x6800
if (rand_num < 0)
    213d:	a1 00 68 00 00       	mov    0x6800,%eax
    2142:	85 c0                	test   %eax,%eax
    2144:	79 0c                	jns    2152 <random+0x37>
{
rand_num *= (-1);
    2146:	a1 00 68 00 00       	mov    0x6800,%eax
    214b:	f7 d8                	neg    %eax
    214d:	a3 00 68 00 00       	mov    %eax,0x6800
}
return rand_num % 997;
    2152:	8b 0d 00 68 00 00    	mov    0x6800,%ecx
    2158:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    215d:	89 c8                	mov    %ecx,%eax
    215f:	f7 ea                	imul   %edx
    2161:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2164:	c1 f8 09             	sar    $0x9,%eax
    2167:	89 c2                	mov    %eax,%edx
    2169:	89 c8                	mov    %ecx,%eax
    216b:	c1 f8 1f             	sar    $0x1f,%eax
    216e:	29 c2                	sub    %eax,%edx
    2170:	89 d0                	mov    %edx,%eax
    2172:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2178:	29 c1                	sub    %eax,%ecx
    217a:	89 c8                	mov    %ecx,%eax
}
    217c:	5d                   	pop    %ebp
    217d:	c3                   	ret    

0000217e <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    217e:	55                   	push   %ebp
    217f:	89 e5                	mov    %esp,%ebp
    2181:	53                   	push   %ebx
    2182:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2185:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    218c:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2190:	74 17                	je     21a9 <sprintint+0x2b>
    2192:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2196:	79 11                	jns    21a9 <sprintint+0x2b>
        neg = 1;
    2198:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    219f:	8b 45 10             	mov    0x10(%ebp),%eax
    21a2:	f7 d8                	neg    %eax
    21a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21a7:	eb 06                	jmp    21af <sprintint+0x31>
    } else {
        x = xx;
    21a9:	8b 45 10             	mov    0x10(%ebp),%eax
    21ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    21af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    21b6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    21b9:	8d 41 01             	lea    0x1(%ecx),%eax
    21bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
    21bf:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21c5:	ba 00 00 00 00       	mov    $0x0,%edx
    21ca:	f7 f3                	div    %ebx
    21cc:	89 d0                	mov    %edx,%eax
    21ce:	0f b6 80 04 68 00 00 	movzbl 0x6804(%eax),%eax
    21d5:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    21d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21df:	ba 00 00 00 00       	mov    $0x0,%edx
    21e4:	f7 f3                	div    %ebx
    21e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    21ed:	75 c7                	jne    21b6 <sprintint+0x38>
    if(neg)
    21ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21f3:	74 0e                	je     2203 <sprintint+0x85>
        buf[i++] = '-';
    21f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21f8:	8d 50 01             	lea    0x1(%eax),%edx
    21fb:	89 55 f8             	mov    %edx,-0x8(%ebp)
    21fe:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2203:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2206:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2209:	eb 1b                	jmp    2226 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    220b:	8b 45 0c             	mov    0xc(%ebp),%eax
    220e:	8b 00                	mov    (%eax),%eax
    2210:	8d 48 01             	lea    0x1(%eax),%ecx
    2213:	8b 55 0c             	mov    0xc(%ebp),%edx
    2216:	89 0a                	mov    %ecx,(%edx)
    2218:	89 c2                	mov    %eax,%edx
    221a:	8b 45 08             	mov    0x8(%ebp),%eax
    221d:	01 d0                	add    %edx,%eax
    221f:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2222:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2226:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    222a:	7f df                	jg     220b <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    222c:	eb 21                	jmp    224f <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    222e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2231:	8b 00                	mov    (%eax),%eax
    2233:	8d 48 01             	lea    0x1(%eax),%ecx
    2236:	8b 55 0c             	mov    0xc(%ebp),%edx
    2239:	89 0a                	mov    %ecx,(%edx)
    223b:	89 c2                	mov    %eax,%edx
    223d:	8b 45 08             	mov    0x8(%ebp),%eax
    2240:	01 c2                	add    %eax,%edx
    2242:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2245:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2248:	01 c8                	add    %ecx,%eax
    224a:	0f b6 00             	movzbl (%eax),%eax
    224d:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    224f:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2253:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2257:	79 d5                	jns    222e <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2259:	90                   	nop
    225a:	83 c4 20             	add    $0x20,%esp
    225d:	5b                   	pop    %ebx
    225e:	5d                   	pop    %ebp
    225f:	c3                   	ret    

00002260 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2260:	55                   	push   %ebp
    2261:	89 e5                	mov    %esp,%ebp
    2263:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2266:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    226d:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2274:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    227b:	8d 45 0c             	lea    0xc(%ebp),%eax
    227e:	83 c0 04             	add    $0x4,%eax
    2281:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2284:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    228b:	e9 d9 01 00 00       	jmp    2469 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2290:	8b 55 0c             	mov    0xc(%ebp),%edx
    2293:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2296:	01 d0                	add    %edx,%eax
    2298:	0f b6 00             	movzbl (%eax),%eax
    229b:	0f be c0             	movsbl %al,%eax
    229e:	25 ff 00 00 00       	and    $0xff,%eax
    22a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    22a6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    22aa:	75 2c                	jne    22d8 <sprintf+0x78>
            if(c == '%'){
    22ac:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    22b0:	75 0c                	jne    22be <sprintf+0x5e>
                state = '%';
    22b2:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    22b9:	e9 a7 01 00 00       	jmp    2465 <sprintf+0x205>
            } else {
                dst[j++] = c;
    22be:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22c1:	8d 50 01             	lea    0x1(%eax),%edx
    22c4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22c7:	89 c2                	mov    %eax,%edx
    22c9:	8b 45 08             	mov    0x8(%ebp),%eax
    22cc:	01 d0                	add    %edx,%eax
    22ce:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22d1:	88 10                	mov    %dl,(%eax)
    22d3:	e9 8d 01 00 00       	jmp    2465 <sprintf+0x205>
            }
        } else if(state == '%'){
    22d8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    22dc:	0f 85 83 01 00 00    	jne    2465 <sprintf+0x205>
            if(c == 'd'){
    22e2:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    22e6:	75 4c                	jne    2334 <sprintf+0xd4>
                buf[bi] = '\0';
    22e8:	8d 55 ce             	lea    -0x32(%ebp),%edx
    22eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22ee:	01 d0                	add    %edx,%eax
    22f0:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    22f3:	83 ec 0c             	sub    $0xc,%esp
    22f6:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22f9:	50                   	push   %eax
    22fa:	e8 2b df ff ff       	call   22a <atoi>
    22ff:	83 c4 10             	add    $0x10,%esp
    2302:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2305:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    230c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    230f:	8b 00                	mov    (%eax),%eax
    2311:	83 ec 08             	sub    $0x8,%esp
    2314:	ff 75 d8             	pushl  -0x28(%ebp)
    2317:	6a 01                	push   $0x1
    2319:	6a 0a                	push   $0xa
    231b:	50                   	push   %eax
    231c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    231f:	50                   	push   %eax
    2320:	ff 75 08             	pushl  0x8(%ebp)
    2323:	e8 56 fe ff ff       	call   217e <sprintint>
    2328:	83 c4 20             	add    $0x20,%esp
                ap++;
    232b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    232f:	e9 2a 01 00 00       	jmp    245e <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2334:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2338:	74 06                	je     2340 <sprintf+0xe0>
    233a:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    233e:	75 4c                	jne    238c <sprintf+0x12c>
                buf[bi] = '\0';
    2340:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2343:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2346:	01 d0                	add    %edx,%eax
    2348:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    234b:	83 ec 0c             	sub    $0xc,%esp
    234e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2351:	50                   	push   %eax
    2352:	e8 d3 de ff ff       	call   22a <atoi>
    2357:	83 c4 10             	add    $0x10,%esp
    235a:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    235d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2364:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2367:	8b 00                	mov    (%eax),%eax
    2369:	83 ec 08             	sub    $0x8,%esp
    236c:	ff 75 dc             	pushl  -0x24(%ebp)
    236f:	6a 00                	push   $0x0
    2371:	6a 10                	push   $0x10
    2373:	50                   	push   %eax
    2374:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2377:	50                   	push   %eax
    2378:	ff 75 08             	pushl  0x8(%ebp)
    237b:	e8 fe fd ff ff       	call   217e <sprintint>
    2380:	83 c4 20             	add    $0x20,%esp
                ap++;
    2383:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2387:	e9 d2 00 00 00       	jmp    245e <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    238c:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2390:	75 46                	jne    23d8 <sprintf+0x178>
                s = (char*)*ap;
    2392:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2395:	8b 00                	mov    (%eax),%eax
    2397:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    239a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    239e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23a2:	75 25                	jne    23c9 <sprintf+0x169>
                    s = "(null)";
    23a4:	c7 45 f4 2c 26 00 00 	movl   $0x262c,-0xc(%ebp)
                while(*s != 0){
    23ab:	eb 1c                	jmp    23c9 <sprintf+0x169>
                    dst[j++] = *s;
    23ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23b0:	8d 50 01             	lea    0x1(%eax),%edx
    23b3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23b6:	89 c2                	mov    %eax,%edx
    23b8:	8b 45 08             	mov    0x8(%ebp),%eax
    23bb:	01 c2                	add    %eax,%edx
    23bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23c0:	0f b6 00             	movzbl (%eax),%eax
    23c3:	88 02                	mov    %al,(%edx)
                    s++;
    23c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    23c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23cc:	0f b6 00             	movzbl (%eax),%eax
    23cf:	84 c0                	test   %al,%al
    23d1:	75 da                	jne    23ad <sprintf+0x14d>
    23d3:	e9 86 00 00 00       	jmp    245e <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    23d8:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    23dc:	75 1d                	jne    23fb <sprintf+0x19b>
                dst[j++] = *ap;
    23de:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23e1:	8d 50 01             	lea    0x1(%eax),%edx
    23e4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23e7:	89 c2                	mov    %eax,%edx
    23e9:	8b 45 08             	mov    0x8(%ebp),%eax
    23ec:	01 c2                	add    %eax,%edx
    23ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23f1:	8b 00                	mov    (%eax),%eax
    23f3:	88 02                	mov    %al,(%edx)
                ap++;
    23f5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23f9:	eb 63                	jmp    245e <sprintf+0x1fe>
            } else if(c == '%'){
    23fb:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    23ff:	75 17                	jne    2418 <sprintf+0x1b8>
                dst[j++] = c;
    2401:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2404:	8d 50 01             	lea    0x1(%eax),%edx
    2407:	89 55 c8             	mov    %edx,-0x38(%ebp)
    240a:	89 c2                	mov    %eax,%edx
    240c:	8b 45 08             	mov    0x8(%ebp),%eax
    240f:	01 d0                	add    %edx,%eax
    2411:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2414:	88 10                	mov    %dl,(%eax)
    2416:	eb 46                	jmp    245e <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2418:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    241c:	7e 18                	jle    2436 <sprintf+0x1d6>
    241e:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2422:	7f 12                	jg     2436 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2424:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2427:	8d 50 01             	lea    0x1(%eax),%edx
    242a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    242d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2430:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2434:	eb 2f                	jmp    2465 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2436:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2439:	8d 50 01             	lea    0x1(%eax),%edx
    243c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    243f:	89 c2                	mov    %eax,%edx
    2441:	8b 45 08             	mov    0x8(%ebp),%eax
    2444:	01 d0                	add    %edx,%eax
    2446:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2449:	8b 45 c8             	mov    -0x38(%ebp),%eax
    244c:	8d 50 01             	lea    0x1(%eax),%edx
    244f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2452:	89 c2                	mov    %eax,%edx
    2454:	8b 45 08             	mov    0x8(%ebp),%eax
    2457:	01 d0                	add    %edx,%eax
    2459:	8b 55 e0             	mov    -0x20(%ebp),%edx
    245c:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    245e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2465:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2469:	8b 55 0c             	mov    0xc(%ebp),%edx
    246c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    246f:	01 d0                	add    %edx,%eax
    2471:	0f b6 00             	movzbl (%eax),%eax
    2474:	84 c0                	test   %al,%al
    2476:	0f 85 14 fe ff ff    	jne    2290 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    247c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    247f:	8d 50 01             	lea    0x1(%eax),%edx
    2482:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2485:	89 c2                	mov    %eax,%edx
    2487:	8b 45 08             	mov    0x8(%ebp),%eax
    248a:	01 d0                	add    %edx,%eax
    248c:	c6 00 00             	movb   $0x0,(%eax)
}
    248f:	90                   	nop
    2490:	c9                   	leave  
    2491:	c3                   	ret    
