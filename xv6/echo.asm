
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
      27:	ba a0 20 00 00       	mov    $0x20a0,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba a2 20 00 00       	mov    $0x20a2,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 a4 20 00 00       	push   $0x20a4
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
     3f7:	0f b6 80 34 27 00 00 	movzbl 0x2734(%eax),%eax
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
     535:	c7 45 f4 a9 20 00 00 	movl   $0x20a9,-0xc(%ebp)
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
     5fb:	a1 64 27 00 00       	mov    0x2764,%eax
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
     6c6:	a3 64 27 00 00       	mov    %eax,0x2764
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
     727:	a1 64 27 00 00       	mov    0x2764,%eax
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
     743:	a1 64 27 00 00       	mov    0x2764,%eax
     748:	89 45 f0             	mov    %eax,-0x10(%ebp)
     74b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     74f:	75 23                	jne    774 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     751:	c7 45 f0 5c 27 00 00 	movl   $0x275c,-0x10(%ebp)
     758:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75b:	a3 64 27 00 00       	mov    %eax,0x2764
     760:	a1 64 27 00 00       	mov    0x2764,%eax
     765:	a3 5c 27 00 00       	mov    %eax,0x275c
    base.s.size = 0;
     76a:	c7 05 60 27 00 00 00 	movl   $0x0,0x2760
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
     7c7:	a3 64 27 00 00       	mov    %eax,0x2764
      return (void*)(p + 1);
     7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cf:	83 c0 08             	add    $0x8,%eax
     7d2:	eb 3b                	jmp    80f <malloc+0xe1>
    }
    if(p == freep)
     7d4:	a1 64 27 00 00       	mov    0x2764,%eax
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
     8e4:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     8e7:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     8ee:	8b 45 cc             	mov    -0x34(%ebp),%eax
     8f1:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     8f4:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     8fb:	83 ec 08             	sub    $0x8,%esp
     8fe:	6a 00                	push   $0x0
     900:	ff 75 0c             	pushl  0xc(%ebp)
     903:	e8 f4 f9 ff ff       	call   2fc <open>
     908:	83 c4 10             	add    $0x10,%esp
     90b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     90e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     912:	79 2e                	jns    942 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     914:	83 ec 04             	sub    $0x4,%esp
     917:	ff 75 0c             	pushl  0xc(%ebp)
     91a:	68 b0 20 00 00       	push   $0x20b0
     91f:	6a 01                	push   $0x1
     921:	e8 35 fb ff ff       	call   45b <printf>
     926:	83 c4 10             	add    $0x10,%esp
        return bmp;
     929:	8b 45 08             	mov    0x8(%ebp),%eax
     92c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     92f:	89 10                	mov    %edx,(%eax)
     931:	8b 55 cc             	mov    -0x34(%ebp),%edx
     934:	89 50 04             	mov    %edx,0x4(%eax)
     937:	8b 55 d0             	mov    -0x30(%ebp),%edx
     93a:	89 50 08             	mov    %edx,0x8(%eax)
     93d:	e9 d2 01 00 00       	jmp    b14 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     942:	83 ec 04             	sub    $0x4,%esp
     945:	6a 0e                	push   $0xe
     947:	8d 45 ba             	lea    -0x46(%ebp),%eax
     94a:	50                   	push   %eax
     94b:	ff 75 ec             	pushl  -0x14(%ebp)
     94e:	e8 81 f9 ff ff       	call   2d4 <read>
     953:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     956:	83 ec 04             	sub    $0x4,%esp
     959:	6a 28                	push   $0x28
     95b:	8d 45 92             	lea    -0x6e(%ebp),%eax
     95e:	50                   	push   %eax
     95f:	ff 75 ec             	pushl  -0x14(%ebp)
     962:	e8 6d f9 ff ff       	call   2d4 <read>
     967:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     96a:	8b 45 96             	mov    -0x6a(%ebp),%eax
     96d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     970:	8b 45 9a             	mov    -0x66(%ebp),%eax
     973:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     976:	8b 55 c8             	mov    -0x38(%ebp),%edx
     979:	8b 45 cc             	mov    -0x34(%ebp),%eax
     97c:	0f af d0             	imul   %eax,%edx
     97f:	89 d0                	mov    %edx,%eax
     981:	01 c0                	add    %eax,%eax
     983:	01 d0                	add    %edx,%eax
     985:	83 ec 0c             	sub    $0xc,%esp
     988:	50                   	push   %eax
     989:	e8 a0 fd ff ff       	call   72e <malloc>
     98e:	83 c4 10             	add    $0x10,%esp
     991:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     994:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     998:	0f b7 c0             	movzwl %ax,%eax
     99b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     99e:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9a4:	0f af c2             	imul   %edx,%eax
     9a7:	83 c0 1f             	add    $0x1f,%eax
     9aa:	c1 e8 05             	shr    $0x5,%eax
     9ad:	c1 e0 02             	shl    $0x2,%eax
     9b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     9b3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9b9:	0f af c2             	imul   %edx,%eax
     9bc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     9bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     9c2:	83 ec 0c             	sub    $0xc,%esp
     9c5:	50                   	push   %eax
     9c6:	e8 63 fd ff ff       	call   72e <malloc>
     9cb:	83 c4 10             	add    $0x10,%esp
     9ce:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     9d1:	83 ec 04             	sub    $0x4,%esp
     9d4:	ff 75 e0             	pushl  -0x20(%ebp)
     9d7:	ff 75 dc             	pushl  -0x24(%ebp)
     9da:	ff 75 ec             	pushl  -0x14(%ebp)
     9dd:	e8 f2 f8 ff ff       	call   2d4 <read>
     9e2:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     9e5:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     9e9:	66 c1 e8 03          	shr    $0x3,%ax
     9ed:	0f b7 c0             	movzwl %ax,%eax
     9f0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     9f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9fa:	e9 e5 00 00 00       	jmp    ae4 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     9ff:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a05:	29 c2                	sub    %eax,%edx
     a07:	89 d0                	mov    %edx,%eax
     a09:	8d 50 ff             	lea    -0x1(%eax),%edx
     a0c:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a0f:	0f af c2             	imul   %edx,%eax
     a12:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     a15:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a1c:	e9 b1 00 00 00       	jmp    ad2 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     a21:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a24:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a27:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a2a:	01 c8                	add    %ecx,%eax
     a2c:	89 c1                	mov    %eax,%ecx
     a2e:	89 c8                	mov    %ecx,%eax
     a30:	01 c0                	add    %eax,%eax
     a32:	01 c8                	add    %ecx,%eax
     a34:	01 c2                	add    %eax,%edx
     a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a39:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a3d:	89 c1                	mov    %eax,%ecx
     a3f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a42:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a46:	01 c1                	add    %eax,%ecx
     a48:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a4b:	01 c8                	add    %ecx,%eax
     a4d:	8d 48 ff             	lea    -0x1(%eax),%ecx
     a50:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a53:	01 c8                	add    %ecx,%eax
     a55:	0f b6 00             	movzbl (%eax),%eax
     a58:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     a5b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a5e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a64:	01 c8                	add    %ecx,%eax
     a66:	89 c1                	mov    %eax,%ecx
     a68:	89 c8                	mov    %ecx,%eax
     a6a:	01 c0                	add    %eax,%eax
     a6c:	01 c8                	add    %ecx,%eax
     a6e:	01 c2                	add    %eax,%edx
     a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a73:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     a77:	89 c1                	mov    %eax,%ecx
     a79:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a7c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     a80:	01 c1                	add    %eax,%ecx
     a82:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a85:	01 c8                	add    %ecx,%eax
     a87:	8d 48 fe             	lea    -0x2(%eax),%ecx
     a8a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a8d:	01 c8                	add    %ecx,%eax
     a8f:	0f b6 00             	movzbl (%eax),%eax
     a92:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     a95:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a98:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a9e:	01 c8                	add    %ecx,%eax
     aa0:	89 c1                	mov    %eax,%ecx
     aa2:	89 c8                	mov    %ecx,%eax
     aa4:	01 c0                	add    %eax,%eax
     aa6:	01 c8                	add    %ecx,%eax
     aa8:	01 c2                	add    %eax,%edx
     aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aad:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ab1:	89 c1                	mov    %eax,%ecx
     ab3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ab6:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     aba:	01 c1                	add    %eax,%ecx
     abc:	8b 45 d8             	mov    -0x28(%ebp),%eax
     abf:	01 c8                	add    %ecx,%eax
     ac1:	8d 48 fd             	lea    -0x3(%eax),%ecx
     ac4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ac7:	01 c8                	add    %ecx,%eax
     ac9:	0f b6 00             	movzbl (%eax),%eax
     acc:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ace:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ad2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ad5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad8:	39 c2                	cmp    %eax,%edx
     ada:	0f 87 41 ff ff ff    	ja     a21 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     ae0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ae4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aea:	39 c2                	cmp    %eax,%edx
     aec:	0f 87 0d ff ff ff    	ja     9ff <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     af2:	83 ec 0c             	sub    $0xc,%esp
     af5:	ff 75 ec             	pushl  -0x14(%ebp)
     af8:	e8 e7 f7 ff ff       	call   2e4 <close>
     afd:	83 c4 10             	add    $0x10,%esp
    return bmp;
     b00:	8b 45 08             	mov    0x8(%ebp),%eax
     b03:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b06:	89 10                	mov    %edx,(%eax)
     b08:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b0b:	89 50 04             	mov    %edx,0x4(%eax)
     b0e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b11:	89 50 08             	mov    %edx,0x8(%eax)
}
     b14:	8b 45 08             	mov    0x8(%ebp),%eax
     b17:	c9                   	leave  
     b18:	c2 04 00             	ret    $0x4

00000b1b <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     b1b:	55                   	push   %ebp
     b1c:	89 e5                	mov    %esp,%ebp
     b1e:	53                   	push   %ebx
     b1f:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     b22:	83 ec 0c             	sub    $0xc,%esp
     b25:	6a 1c                	push   $0x1c
     b27:	e8 02 fc ff ff       	call   72e <malloc>
     b2c:	83 c4 10             	add    $0x10,%esp
     b2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     b32:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b35:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     b3c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     b3f:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b42:	6a 0c                	push   $0xc
     b44:	6a 0c                	push   $0xc
     b46:	6a 0c                	push   $0xc
     b48:	50                   	push   %eax
     b49:	e8 c3 fc ff ff       	call   811 <RGB>
     b4e:	83 c4 0c             	add    $0xc,%esp
     b51:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     b55:	66 89 43 13          	mov    %ax,0x13(%ebx)
     b59:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     b5d:	88 43 15             	mov    %al,0x15(%ebx)
     b60:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b63:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b66:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     b6a:	66 89 48 10          	mov    %cx,0x10(%eax)
     b6e:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     b72:	88 50 12             	mov    %dl,0x12(%eax)
     b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b78:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b7b:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     b7f:	66 89 48 08          	mov    %cx,0x8(%eax)
     b83:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     b87:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     b8a:	8b 45 08             	mov    0x8(%ebp),%eax
     b8d:	89 c2                	mov    %eax,%edx
     b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b92:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     b94:	8b 45 0c             	mov    0xc(%ebp),%eax
     b97:	89 c2                	mov    %eax,%edx
     b99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9c:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     b9f:	8b 55 10             	mov    0x10(%ebp),%edx
     ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba5:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bae:	c9                   	leave  
     baf:	c3                   	ret    

00000bb0 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     bb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb9:	8b 50 08             	mov    0x8(%eax),%edx
     bbc:	89 55 f8             	mov    %edx,-0x8(%ebp)
     bbf:	8b 40 0c             	mov    0xc(%eax),%eax
     bc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     bc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc8:	8b 55 10             	mov    0x10(%ebp),%edx
     bcb:	89 50 08             	mov    %edx,0x8(%eax)
     bce:	8b 55 14             	mov    0x14(%ebp),%edx
     bd1:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     bd4:	8b 45 08             	mov    0x8(%ebp),%eax
     bd7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     bda:	89 10                	mov    %edx,(%eax)
     bdc:	8b 55 fc             	mov    -0x4(%ebp),%edx
     bdf:	89 50 04             	mov    %edx,0x4(%eax)
}
     be2:	8b 45 08             	mov    0x8(%ebp),%eax
     be5:	c9                   	leave  
     be6:	c2 04 00             	ret    $0x4

00000be9 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     be9:	55                   	push   %ebp
     bea:	89 e5                	mov    %esp,%ebp
     bec:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     bef:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf2:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     bf6:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     bfa:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     bfe:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     c01:	8b 45 0c             	mov    0xc(%ebp),%eax
     c04:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c08:	66 89 50 10          	mov    %dx,0x10(%eax)
     c0c:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c10:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     c13:	8b 45 08             	mov    0x8(%ebp),%eax
     c16:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c1a:	66 89 10             	mov    %dx,(%eax)
     c1d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c21:	88 50 02             	mov    %dl,0x2(%eax)
}
     c24:	8b 45 08             	mov    0x8(%ebp),%eax
     c27:	c9                   	leave  
     c28:	c2 04 00             	ret    $0x4

00000c2b <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c2b:	55                   	push   %ebp
     c2c:	89 e5                	mov    %esp,%ebp
     c2e:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c31:	8b 45 08             	mov    0x8(%ebp),%eax
     c34:	8b 40 0c             	mov    0xc(%eax),%eax
     c37:	89 c2                	mov    %eax,%edx
     c39:	c1 ea 1f             	shr    $0x1f,%edx
     c3c:	01 d0                	add    %edx,%eax
     c3e:	d1 f8                	sar    %eax
     c40:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c46:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c4d:	8b 45 10             	mov    0x10(%ebp),%eax
     c50:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c53:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     c56:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     c5a:	0f 89 98 00 00 00    	jns    cf8 <APDrawPoint+0xcd>
        i = 0;
     c60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     c67:	e9 8c 00 00 00       	jmp    cf8 <APDrawPoint+0xcd>
    {
        j = x - off;
     c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     c72:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     c75:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     c79:	79 69                	jns    ce4 <APDrawPoint+0xb9>
            j = 0;
     c7b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     c82:	eb 60                	jmp    ce4 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     c84:	ff 75 fc             	pushl  -0x4(%ebp)
     c87:	ff 75 f8             	pushl  -0x8(%ebp)
     c8a:	ff 75 08             	pushl  0x8(%ebp)
     c8d:	e8 fd fb ff ff       	call   88f <APGetIndex>
     c92:	83 c4 0c             	add    $0xc,%esp
     c95:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     c98:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     c9c:	74 55                	je     cf3 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     c9e:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     ca2:	74 67                	je     d0b <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     ca4:	ff 75 10             	pushl  0x10(%ebp)
     ca7:	ff 75 0c             	pushl  0xc(%ebp)
     caa:	ff 75 fc             	pushl  -0x4(%ebp)
     cad:	ff 75 f8             	pushl  -0x8(%ebp)
     cb0:	e8 a1 fb ff ff       	call   856 <distance_2>
     cb5:	83 c4 10             	add    $0x10,%esp
     cb8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     cbb:	7f 23                	jg     ce0 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     cbd:	8b 45 08             	mov    0x8(%ebp),%eax
     cc0:	8b 48 18             	mov    0x18(%eax),%ecx
     cc3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cc6:	89 d0                	mov    %edx,%eax
     cc8:	01 c0                	add    %eax,%eax
     cca:	01 d0                	add    %edx,%eax
     ccc:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ccf:	8b 45 08             	mov    0x8(%ebp),%eax
     cd2:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     cd6:	66 89 0a             	mov    %cx,(%edx)
     cd9:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     cdd:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ce0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     ce4:	8b 55 0c             	mov    0xc(%ebp),%edx
     ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cea:	01 d0                	add    %edx,%eax
     cec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     cef:	7d 93                	jge    c84 <APDrawPoint+0x59>
     cf1:	eb 01                	jmp    cf4 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     cf3:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     cf4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     cf8:	8b 55 10             	mov    0x10(%ebp),%edx
     cfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cfe:	01 d0                	add    %edx,%eax
     d00:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d03:	0f 8d 63 ff ff ff    	jge    c6c <APDrawPoint+0x41>
     d09:	eb 01                	jmp    d0c <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d0b:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d0c:	c9                   	leave  
     d0d:	c3                   	ret    

00000d0e <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d0e:	55                   	push   %ebp
     d0f:	89 e5                	mov    %esp,%ebp
     d11:	53                   	push   %ebx
     d12:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d15:	8b 45 0c             	mov    0xc(%ebp),%eax
     d18:	3b 45 14             	cmp    0x14(%ebp),%eax
     d1b:	0f 85 80 00 00 00    	jne    da1 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d21:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d25:	0f 88 9d 02 00 00    	js     fc8 <APDrawLine+0x2ba>
     d2b:	8b 45 08             	mov    0x8(%ebp),%eax
     d2e:	8b 00                	mov    (%eax),%eax
     d30:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d33:	0f 8e 8f 02 00 00    	jle    fc8 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d39:	8b 45 10             	mov    0x10(%ebp),%eax
     d3c:	3b 45 18             	cmp    0x18(%ebp),%eax
     d3f:	7e 12                	jle    d53 <APDrawLine+0x45>
        {
            int tmp = y2;
     d41:	8b 45 18             	mov    0x18(%ebp),%eax
     d44:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d47:	8b 45 10             	mov    0x10(%ebp),%eax
     d4a:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d50:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     d53:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     d57:	79 07                	jns    d60 <APDrawLine+0x52>
     d59:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     d60:	8b 45 08             	mov    0x8(%ebp),%eax
     d63:	8b 40 04             	mov    0x4(%eax),%eax
     d66:	3b 45 18             	cmp    0x18(%ebp),%eax
     d69:	7d 0c                	jge    d77 <APDrawLine+0x69>
     d6b:	8b 45 08             	mov    0x8(%ebp),%eax
     d6e:	8b 40 04             	mov    0x4(%eax),%eax
     d71:	83 e8 01             	sub    $0x1,%eax
     d74:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     d77:	8b 45 10             	mov    0x10(%ebp),%eax
     d7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d7d:	eb 15                	jmp    d94 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     d7f:	ff 75 f4             	pushl  -0xc(%ebp)
     d82:	ff 75 0c             	pushl  0xc(%ebp)
     d85:	ff 75 08             	pushl  0x8(%ebp)
     d88:	e8 9e fe ff ff       	call   c2b <APDrawPoint>
     d8d:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     d90:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d97:	3b 45 18             	cmp    0x18(%ebp),%eax
     d9a:	7e e3                	jle    d7f <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     d9c:	e9 2b 02 00 00       	jmp    fcc <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     da1:	8b 45 10             	mov    0x10(%ebp),%eax
     da4:	3b 45 18             	cmp    0x18(%ebp),%eax
     da7:	75 7f                	jne    e28 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     da9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dad:	0f 88 18 02 00 00    	js     fcb <APDrawLine+0x2bd>
     db3:	8b 45 08             	mov    0x8(%ebp),%eax
     db6:	8b 40 04             	mov    0x4(%eax),%eax
     db9:	3b 45 10             	cmp    0x10(%ebp),%eax
     dbc:	0f 8e 09 02 00 00    	jle    fcb <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     dc2:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc5:	3b 45 14             	cmp    0x14(%ebp),%eax
     dc8:	7e 12                	jle    ddc <APDrawLine+0xce>
        {
            int tmp = x2;
     dca:	8b 45 14             	mov    0x14(%ebp),%eax
     dcd:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd3:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     dd6:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dd9:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ddc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     de0:	79 07                	jns    de9 <APDrawLine+0xdb>
     de2:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     de9:	8b 45 08             	mov    0x8(%ebp),%eax
     dec:	8b 00                	mov    (%eax),%eax
     dee:	3b 45 14             	cmp    0x14(%ebp),%eax
     df1:	7d 0b                	jge    dfe <APDrawLine+0xf0>
     df3:	8b 45 08             	mov    0x8(%ebp),%eax
     df6:	8b 00                	mov    (%eax),%eax
     df8:	83 e8 01             	sub    $0x1,%eax
     dfb:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
     e01:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e04:	eb 15                	jmp    e1b <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e06:	ff 75 10             	pushl  0x10(%ebp)
     e09:	ff 75 f0             	pushl  -0x10(%ebp)
     e0c:	ff 75 08             	pushl  0x8(%ebp)
     e0f:	e8 17 fe ff ff       	call   c2b <APDrawPoint>
     e14:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e17:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e1e:	3b 45 14             	cmp    0x14(%ebp),%eax
     e21:	7e e3                	jle    e06 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e23:	e9 a4 01 00 00       	jmp    fcc <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e28:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e2f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e36:	8b 45 0c             	mov    0xc(%ebp),%eax
     e39:	2b 45 14             	sub    0x14(%ebp),%eax
     e3c:	50                   	push   %eax
     e3d:	e8 3d fa ff ff       	call   87f <abs_int>
     e42:	83 c4 04             	add    $0x4,%esp
     e45:	89 c3                	mov    %eax,%ebx
     e47:	8b 45 10             	mov    0x10(%ebp),%eax
     e4a:	2b 45 18             	sub    0x18(%ebp),%eax
     e4d:	50                   	push   %eax
     e4e:	e8 2c fa ff ff       	call   87f <abs_int>
     e53:	83 c4 04             	add    $0x4,%esp
     e56:	39 c3                	cmp    %eax,%ebx
     e58:	0f 8e b5 00 00 00    	jle    f13 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     e5e:	8b 45 10             	mov    0x10(%ebp),%eax
     e61:	2b 45 18             	sub    0x18(%ebp),%eax
     e64:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e67:	db 45 b0             	fildl  -0x50(%ebp)
     e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6d:	2b 45 14             	sub    0x14(%ebp),%eax
     e70:	89 45 b0             	mov    %eax,-0x50(%ebp)
     e73:	db 45 b0             	fildl  -0x50(%ebp)
     e76:	de f9                	fdivrp %st,%st(1)
     e78:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     e7b:	8b 45 14             	mov    0x14(%ebp),%eax
     e7e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e81:	7e 0e                	jle    e91 <APDrawLine+0x183>
        {
            s = x1;
     e83:	8b 45 0c             	mov    0xc(%ebp),%eax
     e86:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     e89:	8b 45 14             	mov    0x14(%ebp),%eax
     e8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e8f:	eb 0c                	jmp    e9d <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     e91:	8b 45 14             	mov    0x14(%ebp),%eax
     e94:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     e97:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9a:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     e9d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ea1:	79 07                	jns    eaa <APDrawLine+0x19c>
     ea3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     eaa:	8b 45 08             	mov    0x8(%ebp),%eax
     ead:	8b 00                	mov    (%eax),%eax
     eaf:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     eb2:	7f 0b                	jg     ebf <APDrawLine+0x1b1>
     eb4:	8b 45 08             	mov    0x8(%ebp),%eax
     eb7:	8b 00                	mov    (%eax),%eax
     eb9:	83 e8 01             	sub    $0x1,%eax
     ebc:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ebf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ec2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ec5:	eb 3f                	jmp    f06 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     ec7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     eca:	2b 45 0c             	sub    0xc(%ebp),%eax
     ecd:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ed0:	db 45 b0             	fildl  -0x50(%ebp)
     ed3:	dc 4d d0             	fmull  -0x30(%ebp)
     ed6:	db 45 10             	fildl  0x10(%ebp)
     ed9:	de c1                	faddp  %st,%st(1)
     edb:	d9 7d b6             	fnstcw -0x4a(%ebp)
     ede:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     ee2:	b4 0c                	mov    $0xc,%ah
     ee4:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ee8:	d9 6d b4             	fldcw  -0x4c(%ebp)
     eeb:	db 5d cc             	fistpl -0x34(%ebp)
     eee:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     ef1:	ff 75 cc             	pushl  -0x34(%ebp)
     ef4:	ff 75 e4             	pushl  -0x1c(%ebp)
     ef7:	ff 75 08             	pushl  0x8(%ebp)
     efa:	e8 2c fd ff ff       	call   c2b <APDrawPoint>
     eff:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f02:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f09:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f0c:	7e b9                	jle    ec7 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f0e:	e9 b9 00 00 00       	jmp    fcc <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f13:	8b 45 0c             	mov    0xc(%ebp),%eax
     f16:	2b 45 14             	sub    0x14(%ebp),%eax
     f19:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f1c:	db 45 b0             	fildl  -0x50(%ebp)
     f1f:	8b 45 10             	mov    0x10(%ebp),%eax
     f22:	2b 45 18             	sub    0x18(%ebp),%eax
     f25:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f28:	db 45 b0             	fildl  -0x50(%ebp)
     f2b:	de f9                	fdivrp %st,%st(1)
     f2d:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f30:	8b 45 10             	mov    0x10(%ebp),%eax
     f33:	3b 45 18             	cmp    0x18(%ebp),%eax
     f36:	7e 0e                	jle    f46 <APDrawLine+0x238>
    {
        s = y2;
     f38:	8b 45 18             	mov    0x18(%ebp),%eax
     f3b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f3e:	8b 45 10             	mov    0x10(%ebp),%eax
     f41:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f44:	eb 0c                	jmp    f52 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f46:	8b 45 10             	mov    0x10(%ebp),%eax
     f49:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f4c:	8b 45 18             	mov    0x18(%ebp),%eax
     f4f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     f52:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f56:	79 07                	jns    f5f <APDrawLine+0x251>
     f58:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     f5f:	8b 45 08             	mov    0x8(%ebp),%eax
     f62:	8b 40 04             	mov    0x4(%eax),%eax
     f65:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f68:	7f 0c                	jg     f76 <APDrawLine+0x268>
     f6a:	8b 45 08             	mov    0x8(%ebp),%eax
     f6d:	8b 40 04             	mov    0x4(%eax),%eax
     f70:	83 e8 01             	sub    $0x1,%eax
     f73:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     f76:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f79:	89 45 e0             	mov    %eax,-0x20(%ebp)
     f7c:	eb 3f                	jmp    fbd <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     f7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f81:	2b 45 10             	sub    0x10(%ebp),%eax
     f84:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f87:	db 45 b0             	fildl  -0x50(%ebp)
     f8a:	dc 4d c0             	fmull  -0x40(%ebp)
     f8d:	db 45 0c             	fildl  0xc(%ebp)
     f90:	de c1                	faddp  %st,%st(1)
     f92:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f95:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f99:	b4 0c                	mov    $0xc,%ah
     f9b:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f9f:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fa2:	db 5d bc             	fistpl -0x44(%ebp)
     fa5:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     fa8:	ff 75 e0             	pushl  -0x20(%ebp)
     fab:	ff 75 bc             	pushl  -0x44(%ebp)
     fae:	ff 75 08             	pushl  0x8(%ebp)
     fb1:	e8 75 fc ff ff       	call   c2b <APDrawPoint>
     fb6:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
     fb9:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
     fbd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fc0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fc3:	7e b9                	jle    f7e <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
     fc5:	90                   	nop
     fc6:	eb 04                	jmp    fcc <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
     fc8:	90                   	nop
     fc9:	eb 01                	jmp    fcc <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
     fcb:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
     fcc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fcf:	c9                   	leave  
     fd0:	c3                   	ret    

00000fd1 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
     fd1:	55                   	push   %ebp
     fd2:	89 e5                	mov    %esp,%ebp
     fd4:	53                   	push   %ebx
     fd5:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
     fd8:	8b 55 10             	mov    0x10(%ebp),%edx
     fdb:	8b 45 18             	mov    0x18(%ebp),%eax
     fde:	01 d0                	add    %edx,%eax
     fe0:	83 e8 01             	sub    $0x1,%eax
     fe3:	83 ec 04             	sub    $0x4,%esp
     fe6:	50                   	push   %eax
     fe7:	ff 75 0c             	pushl  0xc(%ebp)
     fea:	ff 75 10             	pushl  0x10(%ebp)
     fed:	ff 75 0c             	pushl  0xc(%ebp)
     ff0:	ff 75 08             	pushl  0x8(%ebp)
     ff3:	e8 16 fd ff ff       	call   d0e <APDrawLine>
     ff8:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
     ffb:	8b 55 0c             	mov    0xc(%ebp),%edx
     ffe:	8b 45 14             	mov    0x14(%ebp),%eax
    1001:	01 d0                	add    %edx,%eax
    1003:	83 e8 01             	sub    $0x1,%eax
    1006:	83 ec 04             	sub    $0x4,%esp
    1009:	ff 75 10             	pushl  0x10(%ebp)
    100c:	50                   	push   %eax
    100d:	ff 75 10             	pushl  0x10(%ebp)
    1010:	ff 75 0c             	pushl  0xc(%ebp)
    1013:	ff 75 08             	pushl  0x8(%ebp)
    1016:	e8 f3 fc ff ff       	call   d0e <APDrawLine>
    101b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    101e:	8b 55 10             	mov    0x10(%ebp),%edx
    1021:	8b 45 18             	mov    0x18(%ebp),%eax
    1024:	01 d0                	add    %edx,%eax
    1026:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1029:	8b 55 0c             	mov    0xc(%ebp),%edx
    102c:	8b 45 14             	mov    0x14(%ebp),%eax
    102f:	01 d0                	add    %edx,%eax
    1031:	8d 50 ff             	lea    -0x1(%eax),%edx
    1034:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1037:	8b 45 14             	mov    0x14(%ebp),%eax
    103a:	01 d8                	add    %ebx,%eax
    103c:	83 e8 01             	sub    $0x1,%eax
    103f:	83 ec 04             	sub    $0x4,%esp
    1042:	51                   	push   %ecx
    1043:	52                   	push   %edx
    1044:	ff 75 10             	pushl  0x10(%ebp)
    1047:	50                   	push   %eax
    1048:	ff 75 08             	pushl  0x8(%ebp)
    104b:	e8 be fc ff ff       	call   d0e <APDrawLine>
    1050:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1053:	8b 55 10             	mov    0x10(%ebp),%edx
    1056:	8b 45 18             	mov    0x18(%ebp),%eax
    1059:	01 d0                	add    %edx,%eax
    105b:	8d 48 ff             	lea    -0x1(%eax),%ecx
    105e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1061:	8b 45 14             	mov    0x14(%ebp),%eax
    1064:	01 d0                	add    %edx,%eax
    1066:	8d 50 ff             	lea    -0x1(%eax),%edx
    1069:	8b 5d 10             	mov    0x10(%ebp),%ebx
    106c:	8b 45 18             	mov    0x18(%ebp),%eax
    106f:	01 d8                	add    %ebx,%eax
    1071:	83 e8 01             	sub    $0x1,%eax
    1074:	83 ec 04             	sub    $0x4,%esp
    1077:	51                   	push   %ecx
    1078:	52                   	push   %edx
    1079:	50                   	push   %eax
    107a:	ff 75 0c             	pushl  0xc(%ebp)
    107d:	ff 75 08             	pushl  0x8(%ebp)
    1080:	e8 89 fc ff ff       	call   d0e <APDrawLine>
    1085:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1088:	8b 55 0c             	mov    0xc(%ebp),%edx
    108b:	8b 45 14             	mov    0x14(%ebp),%eax
    108e:	01 d0                	add    %edx,%eax
    1090:	8d 50 ff             	lea    -0x1(%eax),%edx
    1093:	8b 45 08             	mov    0x8(%ebp),%eax
    1096:	8b 40 0c             	mov    0xc(%eax),%eax
    1099:	89 c1                	mov    %eax,%ecx
    109b:	c1 e9 1f             	shr    $0x1f,%ecx
    109e:	01 c8                	add    %ecx,%eax
    10a0:	d1 f8                	sar    %eax
    10a2:	29 c2                	sub    %eax,%edx
    10a4:	89 d0                	mov    %edx,%eax
    10a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10a9:	8b 55 10             	mov    0x10(%ebp),%edx
    10ac:	8b 45 18             	mov    0x18(%ebp),%eax
    10af:	01 d0                	add    %edx,%eax
    10b1:	8d 50 ff             	lea    -0x1(%eax),%edx
    10b4:	8b 45 08             	mov    0x8(%ebp),%eax
    10b7:	8b 40 0c             	mov    0xc(%eax),%eax
    10ba:	89 c1                	mov    %eax,%ecx
    10bc:	c1 e9 1f             	shr    $0x1f,%ecx
    10bf:	01 c8                	add    %ecx,%eax
    10c1:	d1 f8                	sar    %eax
    10c3:	29 c2                	sub    %eax,%edx
    10c5:	89 d0                	mov    %edx,%eax
    10c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	8b 40 0c             	mov    0xc(%eax),%eax
    10d0:	89 c2                	mov    %eax,%edx
    10d2:	c1 ea 1f             	shr    $0x1f,%edx
    10d5:	01 d0                	add    %edx,%eax
    10d7:	d1 f8                	sar    %eax
    10d9:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    10dc:	8b 45 08             	mov    0x8(%ebp),%eax
    10df:	8b 40 0c             	mov    0xc(%eax),%eax
    10e2:	89 c2                	mov    %eax,%edx
    10e4:	c1 ea 1f             	shr    $0x1f,%edx
    10e7:	01 d0                	add    %edx,%eax
    10e9:	d1 f8                	sar    %eax
    10eb:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    10ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10f2:	0f 88 d8 00 00 00    	js     11d0 <APDrawRect+0x1ff>
    10f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10fc:	0f 88 ce 00 00 00    	js     11d0 <APDrawRect+0x1ff>
    1102:	8b 45 08             	mov    0x8(%ebp),%eax
    1105:	8b 00                	mov    (%eax),%eax
    1107:	3b 45 0c             	cmp    0xc(%ebp),%eax
    110a:	0f 8e c0 00 00 00    	jle    11d0 <APDrawRect+0x1ff>
    1110:	8b 45 08             	mov    0x8(%ebp),%eax
    1113:	8b 40 04             	mov    0x4(%eax),%eax
    1116:	3b 45 10             	cmp    0x10(%ebp),%eax
    1119:	0f 8e b1 00 00 00    	jle    11d0 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    111f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1123:	79 07                	jns    112c <APDrawRect+0x15b>
    1125:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    112c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1130:	79 07                	jns    1139 <APDrawRect+0x168>
    1132:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1139:	8b 45 08             	mov    0x8(%ebp),%eax
    113c:	8b 00                	mov    (%eax),%eax
    113e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1141:	7f 0b                	jg     114e <APDrawRect+0x17d>
    1143:	8b 45 08             	mov    0x8(%ebp),%eax
    1146:	8b 00                	mov    (%eax),%eax
    1148:	83 e8 01             	sub    $0x1,%eax
    114b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    114e:	8b 45 08             	mov    0x8(%ebp),%eax
    1151:	8b 40 04             	mov    0x4(%eax),%eax
    1154:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1157:	7f 0c                	jg     1165 <APDrawRect+0x194>
    1159:	8b 45 08             	mov    0x8(%ebp),%eax
    115c:	8b 40 04             	mov    0x4(%eax),%eax
    115f:	83 e8 01             	sub    $0x1,%eax
    1162:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1165:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    116c:	8b 45 0c             	mov    0xc(%ebp),%eax
    116f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1172:	eb 52                	jmp    11c6 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1174:	8b 45 10             	mov    0x10(%ebp),%eax
    1177:	89 45 e8             	mov    %eax,-0x18(%ebp)
    117a:	eb 3e                	jmp    11ba <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    117c:	83 ec 04             	sub    $0x4,%esp
    117f:	ff 75 e8             	pushl  -0x18(%ebp)
    1182:	ff 75 ec             	pushl  -0x14(%ebp)
    1185:	ff 75 08             	pushl  0x8(%ebp)
    1188:	e8 02 f7 ff ff       	call   88f <APGetIndex>
    118d:	83 c4 10             	add    $0x10,%esp
    1190:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1193:	8b 45 08             	mov    0x8(%ebp),%eax
    1196:	8b 48 18             	mov    0x18(%eax),%ecx
    1199:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    119c:	89 d0                	mov    %edx,%eax
    119e:	01 c0                	add    %eax,%eax
    11a0:	01 d0                	add    %edx,%eax
    11a2:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11a5:	8b 45 08             	mov    0x8(%ebp),%eax
    11a8:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11ac:	66 89 0a             	mov    %cx,(%edx)
    11af:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    11b3:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    11b6:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11bd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11c0:	7e ba                	jle    117c <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11c2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    11c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11c9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11cc:	7e a6                	jle    1174 <APDrawRect+0x1a3>
    11ce:	eb 01                	jmp    11d1 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    11d0:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    11d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11d4:	c9                   	leave  
    11d5:	c3                   	ret    

000011d6 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11d6:	55                   	push   %ebp
    11d7:	89 e5                	mov    %esp,%ebp
    11d9:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11dc:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11e0:	0f 88 8e 01 00 00    	js     1374 <APDcCopy+0x19e>
    11e6:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11ea:	0f 88 84 01 00 00    	js     1374 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11f0:	8b 55 0c             	mov    0xc(%ebp),%edx
    11f3:	8b 45 20             	mov    0x20(%ebp),%eax
    11f6:	01 d0                	add    %edx,%eax
    11f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11fb:	8b 55 10             	mov    0x10(%ebp),%edx
    11fe:	8b 45 24             	mov    0x24(%ebp),%eax
    1201:	01 d0                	add    %edx,%eax
    1203:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1206:	8b 55 18             	mov    0x18(%ebp),%edx
    1209:	8b 45 20             	mov    0x20(%ebp),%eax
    120c:	01 d0                	add    %edx,%eax
    120e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1211:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1214:	8b 45 24             	mov    0x24(%ebp),%eax
    1217:	01 d0                	add    %edx,%eax
    1219:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    121c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1220:	0f 88 51 01 00 00    	js     1377 <APDcCopy+0x1a1>
    1226:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    122a:	0f 88 47 01 00 00    	js     1377 <APDcCopy+0x1a1>
    1230:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1234:	0f 88 3d 01 00 00    	js     1377 <APDcCopy+0x1a1>
    123a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    123e:	0f 88 33 01 00 00    	js     1377 <APDcCopy+0x1a1>
    1244:	8b 45 14             	mov    0x14(%ebp),%eax
    1247:	8b 00                	mov    (%eax),%eax
    1249:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    124c:	0f 8c 25 01 00 00    	jl     1377 <APDcCopy+0x1a1>
    1252:	8b 45 14             	mov    0x14(%ebp),%eax
    1255:	8b 40 04             	mov    0x4(%eax),%eax
    1258:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    125b:	0f 8c 16 01 00 00    	jl     1377 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1261:	8b 45 08             	mov    0x8(%ebp),%eax
    1264:	8b 00                	mov    (%eax),%eax
    1266:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1269:	7f 0b                	jg     1276 <APDcCopy+0xa0>
    126b:	8b 45 08             	mov    0x8(%ebp),%eax
    126e:	8b 00                	mov    (%eax),%eax
    1270:	83 e8 01             	sub    $0x1,%eax
    1273:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	8b 40 04             	mov    0x4(%eax),%eax
    127c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    127f:	7f 0c                	jg     128d <APDcCopy+0xb7>
    1281:	8b 45 08             	mov    0x8(%ebp),%eax
    1284:	8b 40 04             	mov    0x4(%eax),%eax
    1287:	83 e8 01             	sub    $0x1,%eax
    128a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    128d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1294:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    129b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12a2:	e9 bc 00 00 00       	jmp    1363 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12a7:	8b 45 08             	mov    0x8(%ebp),%eax
    12aa:	8b 00                	mov    (%eax),%eax
    12ac:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12af:	8b 55 10             	mov    0x10(%ebp),%edx
    12b2:	01 ca                	add    %ecx,%edx
    12b4:	0f af d0             	imul   %eax,%edx
    12b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ba:	01 d0                	add    %edx,%eax
    12bc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12bf:	8b 45 14             	mov    0x14(%ebp),%eax
    12c2:	8b 00                	mov    (%eax),%eax
    12c4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12c7:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12ca:	01 ca                	add    %ecx,%edx
    12cc:	0f af d0             	imul   %eax,%edx
    12cf:	8b 45 18             	mov    0x18(%ebp),%eax
    12d2:	01 d0                	add    %edx,%eax
    12d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12de:	eb 74                	jmp    1354 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12e0:	8b 45 14             	mov    0x14(%ebp),%eax
    12e3:	8b 50 18             	mov    0x18(%eax),%edx
    12e6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12ec:	01 c8                	add    %ecx,%eax
    12ee:	89 c1                	mov    %eax,%ecx
    12f0:	89 c8                	mov    %ecx,%eax
    12f2:	01 c0                	add    %eax,%eax
    12f4:	01 c8                	add    %ecx,%eax
    12f6:	01 d0                	add    %edx,%eax
    12f8:	0f b7 10             	movzwl (%eax),%edx
    12fb:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12ff:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1303:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1306:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    130a:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    130e:	38 c2                	cmp    %al,%dl
    1310:	75 18                	jne    132a <APDcCopy+0x154>
    1312:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1316:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    131a:	38 c2                	cmp    %al,%dl
    131c:	75 0c                	jne    132a <APDcCopy+0x154>
    131e:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1322:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1326:	38 c2                	cmp    %al,%dl
    1328:	74 26                	je     1350 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    132a:	8b 45 08             	mov    0x8(%ebp),%eax
    132d:	8b 50 18             	mov    0x18(%eax),%edx
    1330:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1333:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1336:	01 c8                	add    %ecx,%eax
    1338:	89 c1                	mov    %eax,%ecx
    133a:	89 c8                	mov    %ecx,%eax
    133c:	01 c0                	add    %eax,%eax
    133e:	01 c8                	add    %ecx,%eax
    1340:	01 d0                	add    %edx,%eax
    1342:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1346:	66 89 10             	mov    %dx,(%eax)
    1349:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    134d:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1350:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1354:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1357:	2b 45 0c             	sub    0xc(%ebp),%eax
    135a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    135d:	7d 81                	jge    12e0 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    135f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1363:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1366:	2b 45 10             	sub    0x10(%ebp),%eax
    1369:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    136c:	0f 8d 35 ff ff ff    	jge    12a7 <APDcCopy+0xd1>
    1372:	eb 04                	jmp    1378 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1374:	90                   	nop
    1375:	eb 01                	jmp    1378 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1377:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1378:	c9                   	leave  
    1379:	c3                   	ret    

0000137a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    137a:	55                   	push   %ebp
    137b:	89 e5                	mov    %esp,%ebp
    137d:	83 ec 1c             	sub    $0x1c,%esp
    1380:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1383:	8b 55 10             	mov    0x10(%ebp),%edx
    1386:	8b 45 14             	mov    0x14(%ebp),%eax
    1389:	88 4d ec             	mov    %cl,-0x14(%ebp)
    138c:	88 55 e8             	mov    %dl,-0x18(%ebp)
    138f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1392:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1396:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1399:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    139d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13a0:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13a4:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13a7:	8b 45 08             	mov    0x8(%ebp),%eax
    13aa:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13ae:	66 89 10             	mov    %dx,(%eax)
    13b1:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13b5:	88 50 02             	mov    %dl,0x2(%eax)
}
    13b8:	8b 45 08             	mov    0x8(%ebp),%eax
    13bb:	c9                   	leave  
    13bc:	c2 04 00             	ret    $0x4

000013bf <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13bf:	55                   	push   %ebp
    13c0:	89 e5                	mov    %esp,%ebp
    13c2:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13c5:	8b 45 08             	mov    0x8(%ebp),%eax
    13c8:	8b 00                	mov    (%eax),%eax
    13ca:	83 ec 08             	sub    $0x8,%esp
    13cd:	8d 55 0c             	lea    0xc(%ebp),%edx
    13d0:	52                   	push   %edx
    13d1:	50                   	push   %eax
    13d2:	e8 95 ef ff ff       	call   36c <sendMessage>
    13d7:	83 c4 10             	add    $0x10,%esp
}
    13da:	90                   	nop
    13db:	c9                   	leave  
    13dc:	c3                   	ret    

000013dd <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13dd:	55                   	push   %ebp
    13de:	89 e5                	mov    %esp,%ebp
    13e0:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13e3:	83 ec 0c             	sub    $0xc,%esp
    13e6:	68 90 00 00 00       	push   $0x90
    13eb:	e8 3e f3 ff ff       	call   72e <malloc>
    13f0:	83 c4 10             	add    $0x10,%esp
    13f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    13f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13fa:	75 15                	jne    1411 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    13fc:	83 ec 04             	sub    $0x4,%esp
    13ff:	ff 75 08             	pushl  0x8(%ebp)
    1402:	68 c0 20 00 00       	push   $0x20c0
    1407:	6a 01                	push   $0x1
    1409:	e8 4d f0 ff ff       	call   45b <printf>
    140e:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1411:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1414:	83 c0 7c             	add    $0x7c,%eax
    1417:	83 ec 08             	sub    $0x8,%esp
    141a:	ff 75 08             	pushl  0x8(%ebp)
    141d:	50                   	push   %eax
    141e:	e8 68 ec ff ff       	call   8b <strcpy>
    1423:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1426:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1429:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1430:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1433:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    143a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143d:	8b 40 34             	mov    0x34(%eax),%eax
    1440:	89 c2                	mov    %eax,%edx
    1442:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1445:	8b 40 38             	mov    0x38(%eax),%eax
    1448:	0f af d0             	imul   %eax,%edx
    144b:	89 d0                	mov    %edx,%eax
    144d:	01 c0                	add    %eax,%eax
    144f:	01 d0                	add    %edx,%eax
    1451:	83 ec 0c             	sub    $0xc,%esp
    1454:	50                   	push   %eax
    1455:	e8 d4 f2 ff ff       	call   72e <malloc>
    145a:	83 c4 10             	add    $0x10,%esp
    145d:	89 c2                	mov    %eax,%edx
    145f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1462:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1465:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1468:	8b 40 4c             	mov    0x4c(%eax),%eax
    146b:	85 c0                	test   %eax,%eax
    146d:	75 15                	jne    1484 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    146f:	83 ec 04             	sub    $0x4,%esp
    1472:	ff 75 08             	pushl  0x8(%ebp)
    1475:	68 e0 20 00 00       	push   $0x20e0
    147a:	6a 01                	push   $0x1
    147c:	e8 da ef ff ff       	call   45b <printf>
    1481:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1484:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1487:	8b 40 34             	mov    0x34(%eax),%eax
    148a:	89 c2                	mov    %eax,%edx
    148c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148f:	8b 40 38             	mov    0x38(%eax),%eax
    1492:	0f af d0             	imul   %eax,%edx
    1495:	89 d0                	mov    %edx,%eax
    1497:	01 c0                	add    %eax,%eax
    1499:	01 c2                	add    %eax,%edx
    149b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    149e:	8b 40 4c             	mov    0x4c(%eax),%eax
    14a1:	83 ec 04             	sub    $0x4,%esp
    14a4:	52                   	push   %edx
    14a5:	68 ff ff ff 00       	push   $0xffffff
    14aa:	50                   	push   %eax
    14ab:	e8 71 ec ff ff       	call   121 <memset>
    14b0:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b6:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    14bd:	e8 7a ee ff ff       	call   33c <getpid>
    14c2:	89 c2                	mov    %eax,%edx
    14c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c7:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cd:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d7:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e1:	8b 40 50             	mov    0x50(%eax),%eax
    14e4:	89 c2                	mov    %eax,%edx
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	8b 40 54             	mov    0x54(%eax),%eax
    14ec:	0f af d0             	imul   %eax,%edx
    14ef:	89 d0                	mov    %edx,%eax
    14f1:	01 c0                	add    %eax,%eax
    14f3:	01 d0                	add    %edx,%eax
    14f5:	83 ec 0c             	sub    $0xc,%esp
    14f8:	50                   	push   %eax
    14f9:	e8 30 f2 ff ff       	call   72e <malloc>
    14fe:	83 c4 10             	add    $0x10,%esp
    1501:	89 c2                	mov    %eax,%edx
    1503:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1506:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1509:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150c:	8b 40 68             	mov    0x68(%eax),%eax
    150f:	85 c0                	test   %eax,%eax
    1511:	75 15                	jne    1528 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1513:	83 ec 04             	sub    $0x4,%esp
    1516:	ff 75 08             	pushl  0x8(%ebp)
    1519:	68 04 21 00 00       	push   $0x2104
    151e:	6a 01                	push   $0x1
    1520:	e8 36 ef ff ff       	call   45b <printf>
    1525:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1528:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152b:	8b 40 34             	mov    0x34(%eax),%eax
    152e:	89 c2                	mov    %eax,%edx
    1530:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1533:	8b 40 38             	mov    0x38(%eax),%eax
    1536:	0f af d0             	imul   %eax,%edx
    1539:	89 d0                	mov    %edx,%eax
    153b:	01 c0                	add    %eax,%eax
    153d:	01 c2                	add    %eax,%edx
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	8b 40 4c             	mov    0x4c(%eax),%eax
    1545:	83 ec 04             	sub    $0x4,%esp
    1548:	52                   	push   %edx
    1549:	68 ff 00 00 00       	push   $0xff
    154e:	50                   	push   %eax
    154f:	e8 cd eb ff ff       	call   121 <memset>
    1554:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1557:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155a:	8b 55 0c             	mov    0xc(%ebp),%edx
    155d:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1560:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1564:	74 35                	je     159b <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1566:	8b 45 10             	mov    0x10(%ebp),%eax
    1569:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    156f:	83 ec 0c             	sub    $0xc,%esp
    1572:	50                   	push   %eax
    1573:	e8 b6 f1 ff ff       	call   72e <malloc>
    1578:	83 c4 10             	add    $0x10,%esp
    157b:	89 c2                	mov    %eax,%edx
    157d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1580:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1583:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1586:	8b 55 10             	mov    0x10(%ebp),%edx
    1589:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    158c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1596:	e9 8d 00 00 00       	jmp    1628 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a8:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b2:	8b 40 18             	mov    0x18(%eax),%eax
    15b5:	89 c2                	mov    %eax,%edx
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	8b 40 1c             	mov    0x1c(%eax),%eax
    15bd:	0f af d0             	imul   %eax,%edx
    15c0:	89 d0                	mov    %edx,%eax
    15c2:	01 c0                	add    %eax,%eax
    15c4:	01 d0                	add    %edx,%eax
    15c6:	83 ec 0c             	sub    $0xc,%esp
    15c9:	50                   	push   %eax
    15ca:	e8 5f f1 ff ff       	call   72e <malloc>
    15cf:	83 c4 10             	add    $0x10,%esp
    15d2:	89 c2                	mov    %eax,%edx
    15d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d7:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    15da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dd:	8b 40 30             	mov    0x30(%eax),%eax
    15e0:	85 c0                	test   %eax,%eax
    15e2:	75 15                	jne    15f9 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    15e4:	83 ec 04             	sub    $0x4,%esp
    15e7:	ff 75 08             	pushl  0x8(%ebp)
    15ea:	68 2c 21 00 00       	push   $0x212c
    15ef:	6a 01                	push   $0x1
    15f1:	e8 65 ee ff ff       	call   45b <printf>
    15f6:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fc:	8b 40 18             	mov    0x18(%eax),%eax
    15ff:	89 c2                	mov    %eax,%edx
    1601:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1604:	8b 40 1c             	mov    0x1c(%eax),%eax
    1607:	0f af d0             	imul   %eax,%edx
    160a:	89 d0                	mov    %edx,%eax
    160c:	01 c0                	add    %eax,%eax
    160e:	01 c2                	add    %eax,%edx
    1610:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1613:	8b 40 30             	mov    0x30(%eax),%eax
    1616:	83 ec 04             	sub    $0x4,%esp
    1619:	52                   	push   %edx
    161a:	68 ff ff ff 00       	push   $0xffffff
    161f:	50                   	push   %eax
    1620:	e8 fc ea ff ff       	call   121 <memset>
    1625:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1628:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    162b:	c9                   	leave  
    162c:	c3                   	ret    

0000162d <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    162d:	55                   	push   %ebp
    162e:	89 e5                	mov    %esp,%ebp
    1630:	53                   	push   %ebx
    1631:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1634:	8b 45 0c             	mov    0xc(%ebp),%eax
    1637:	83 f8 03             	cmp    $0x3,%eax
    163a:	74 02                	je     163e <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    163c:	eb 33                	jmp    1671 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    163e:	8b 45 08             	mov    0x8(%ebp),%eax
    1641:	8b 48 08             	mov    0x8(%eax),%ecx
    1644:	8b 45 08             	mov    0x8(%ebp),%eax
    1647:	8b 50 38             	mov    0x38(%eax),%edx
    164a:	8b 45 08             	mov    0x8(%ebp),%eax
    164d:	8b 40 34             	mov    0x34(%eax),%eax
    1650:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1653:	83 c3 34             	add    $0x34,%ebx
    1656:	83 ec 0c             	sub    $0xc,%esp
    1659:	51                   	push   %ecx
    165a:	52                   	push   %edx
    165b:	50                   	push   %eax
    165c:	6a 00                	push   $0x0
    165e:	6a 00                	push   $0x0
    1660:	53                   	push   %ebx
    1661:	6a 32                	push   $0x32
    1663:	6a 00                	push   $0x0
    1665:	ff 75 08             	pushl  0x8(%ebp)
    1668:	e8 ef ec ff ff       	call   35c <paintWindow>
    166d:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1670:	90                   	nop
        default: break;
            
            
    }
    return False;
    1671:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1679:	c9                   	leave  
    167a:	c3                   	ret    

0000167b <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    167b:	55                   	push   %ebp
    167c:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    167e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1681:	8b 50 08             	mov    0x8(%eax),%edx
    1684:	8b 45 08             	mov    0x8(%ebp),%eax
    1687:	8b 00                	mov    (%eax),%eax
    1689:	39 c2                	cmp    %eax,%edx
    168b:	74 07                	je     1694 <APPreJudge+0x19>
        return False;
    168d:	b8 00 00 00 00       	mov    $0x0,%eax
    1692:	eb 05                	jmp    1699 <APPreJudge+0x1e>
    return True;
    1694:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1699:	5d                   	pop    %ebp
    169a:	c3                   	ret    

0000169b <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    169b:	55                   	push   %ebp
    169c:	89 e5                	mov    %esp,%ebp
    169e:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    16a1:	8b 45 08             	mov    0x8(%ebp),%eax
    16a4:	8b 55 0c             	mov    0xc(%ebp),%edx
    16a7:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    16aa:	83 ec 0c             	sub    $0xc,%esp
    16ad:	ff 75 08             	pushl  0x8(%ebp)
    16b0:	e8 c7 ec ff ff       	call   37c <registWindow>
    16b5:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    16b8:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    16bf:	8b 45 08             	mov    0x8(%ebp),%eax
    16c2:	8b 00                	mov    (%eax),%eax
    16c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    16c7:	ff 75 f4             	pushl  -0xc(%ebp)
    16ca:	ff 75 f0             	pushl  -0x10(%ebp)
    16cd:	ff 75 ec             	pushl  -0x14(%ebp)
    16d0:	ff 75 08             	pushl  0x8(%ebp)
    16d3:	e8 e7 fc ff ff       	call   13bf <APSendMessage>
    16d8:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    16db:	83 ec 0c             	sub    $0xc,%esp
    16de:	ff 75 08             	pushl  0x8(%ebp)
    16e1:	e8 8e ec ff ff       	call   374 <getMessage>
    16e6:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    16e9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ec:	83 c0 6c             	add    $0x6c,%eax
    16ef:	83 ec 08             	sub    $0x8,%esp
    16f2:	50                   	push   %eax
    16f3:	ff 75 08             	pushl  0x8(%ebp)
    16f6:	e8 80 ff ff ff       	call   167b <APPreJudge>
    16fb:	83 c4 10             	add    $0x10,%esp
    16fe:	84 c0                	test   %al,%al
    1700:	74 1b                	je     171d <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1702:	8b 45 08             	mov    0x8(%ebp),%eax
    1705:	ff 70 74             	pushl  0x74(%eax)
    1708:	ff 70 70             	pushl  0x70(%eax)
    170b:	ff 70 6c             	pushl  0x6c(%eax)
    170e:	ff 75 08             	pushl  0x8(%ebp)
    1711:	8b 45 0c             	mov    0xc(%ebp),%eax
    1714:	ff d0                	call   *%eax
    1716:	83 c4 10             	add    $0x10,%esp
    1719:	84 c0                	test   %al,%al
    171b:	75 0c                	jne    1729 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    171d:	8b 45 08             	mov    0x8(%ebp),%eax
    1720:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1727:	eb b2                	jmp    16db <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1729:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    172a:	90                   	nop
    172b:	c9                   	leave  
    172c:	c3                   	ret    

0000172d <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    172d:	55                   	push   %ebp
    172e:	89 e5                	mov    %esp,%ebp
    1730:	57                   	push   %edi
    1731:	56                   	push   %esi
    1732:	53                   	push   %ebx
    1733:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1736:	a1 68 27 00 00       	mov    0x2768,%eax
    173b:	85 c0                	test   %eax,%eax
    173d:	0f 85 2c 02 00 00    	jne    196f <APGridPaint+0x242>
    {
        iconReady = 1;
    1743:	c7 05 68 27 00 00 01 	movl   $0x1,0x2768
    174a:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    174d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1750:	83 ec 08             	sub    $0x8,%esp
    1753:	68 53 21 00 00       	push   $0x2153
    1758:	50                   	push   %eax
    1759:	e8 83 f1 ff ff       	call   8e1 <APLoadBitmap>
    175e:	83 c4 0c             	add    $0xc,%esp
    1761:	8b 45 98             	mov    -0x68(%ebp),%eax
    1764:	a3 8c 27 00 00       	mov    %eax,0x278c
    1769:	8b 45 9c             	mov    -0x64(%ebp),%eax
    176c:	a3 90 27 00 00       	mov    %eax,0x2790
    1771:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1774:	a3 94 27 00 00       	mov    %eax,0x2794
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1779:	83 ec 04             	sub    $0x4,%esp
    177c:	ff 35 94 27 00 00    	pushl  0x2794
    1782:	ff 35 90 27 00 00    	pushl  0x2790
    1788:	ff 35 8c 27 00 00    	pushl  0x278c
    178e:	e8 88 f3 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    1793:	83 c4 10             	add    $0x10,%esp
    1796:	a3 98 27 00 00       	mov    %eax,0x2798
        grid_river = APLoadBitmap ("grid_river.bmp");
    179b:	8d 45 98             	lea    -0x68(%ebp),%eax
    179e:	83 ec 08             	sub    $0x8,%esp
    17a1:	68 61 21 00 00       	push   $0x2161
    17a6:	50                   	push   %eax
    17a7:	e8 35 f1 ff ff       	call   8e1 <APLoadBitmap>
    17ac:	83 c4 0c             	add    $0xc,%esp
    17af:	8b 45 98             	mov    -0x68(%ebp),%eax
    17b2:	a3 c8 27 00 00       	mov    %eax,0x27c8
    17b7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17ba:	a3 cc 27 00 00       	mov    %eax,0x27cc
    17bf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17c2:	a3 d0 27 00 00       	mov    %eax,0x27d0
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    17c7:	83 ec 04             	sub    $0x4,%esp
    17ca:	ff 35 d0 27 00 00    	pushl  0x27d0
    17d0:	ff 35 cc 27 00 00    	pushl  0x27cc
    17d6:	ff 35 c8 27 00 00    	pushl  0x27c8
    17dc:	e8 3a f3 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    17e1:	83 c4 10             	add    $0x10,%esp
    17e4:	a3 b8 27 00 00       	mov    %eax,0x27b8
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    17e9:	8d 45 98             	lea    -0x68(%ebp),%eax
    17ec:	83 ec 08             	sub    $0x8,%esp
    17ef:	68 70 21 00 00       	push   $0x2170
    17f4:	50                   	push   %eax
    17f5:	e8 e7 f0 ff ff       	call   8e1 <APLoadBitmap>
    17fa:	83 c4 0c             	add    $0xc,%esp
    17fd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1800:	a3 bc 27 00 00       	mov    %eax,0x27bc
    1805:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1808:	a3 c0 27 00 00       	mov    %eax,0x27c0
    180d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1810:	a3 c4 27 00 00       	mov    %eax,0x27c4
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1815:	83 ec 04             	sub    $0x4,%esp
    1818:	ff 35 c4 27 00 00    	pushl  0x27c4
    181e:	ff 35 c0 27 00 00    	pushl  0x27c0
    1824:	ff 35 bc 27 00 00    	pushl  0x27bc
    182a:	e8 ec f2 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    182f:	83 c4 10             	add    $0x10,%esp
    1832:	a3 6c 27 00 00       	mov    %eax,0x276c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1837:	8d 45 98             	lea    -0x68(%ebp),%eax
    183a:	83 ec 08             	sub    $0x8,%esp
    183d:	68 7f 21 00 00       	push   $0x217f
    1842:	50                   	push   %eax
    1843:	e8 99 f0 ff ff       	call   8e1 <APLoadBitmap>
    1848:	83 c4 0c             	add    $0xc,%esp
    184b:	8b 45 98             	mov    -0x68(%ebp),%eax
    184e:	a3 a0 27 00 00       	mov    %eax,0x27a0
    1853:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1856:	a3 a4 27 00 00       	mov    %eax,0x27a4
    185b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    185e:	a3 a8 27 00 00       	mov    %eax,0x27a8
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1863:	83 ec 04             	sub    $0x4,%esp
    1866:	ff 35 a8 27 00 00    	pushl  0x27a8
    186c:	ff 35 a4 27 00 00    	pushl  0x27a4
    1872:	ff 35 a0 27 00 00    	pushl  0x27a0
    1878:	e8 9e f2 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    187d:	83 c4 10             	add    $0x10,%esp
    1880:	a3 d4 27 00 00       	mov    %eax,0x27d4
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1885:	8d 45 98             	lea    -0x68(%ebp),%eax
    1888:	83 ec 08             	sub    $0x8,%esp
    188b:	68 8d 21 00 00       	push   $0x218d
    1890:	50                   	push   %eax
    1891:	e8 4b f0 ff ff       	call   8e1 <APLoadBitmap>
    1896:	83 c4 0c             	add    $0xc,%esp
    1899:	8b 45 98             	mov    -0x68(%ebp),%eax
    189c:	a3 7c 27 00 00       	mov    %eax,0x277c
    18a1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18a4:	a3 80 27 00 00       	mov    %eax,0x2780
    18a9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18ac:	a3 84 27 00 00       	mov    %eax,0x2784
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    18b1:	83 ec 04             	sub    $0x4,%esp
    18b4:	ff 35 84 27 00 00    	pushl  0x2784
    18ba:	ff 35 80 27 00 00    	pushl  0x2780
    18c0:	ff 35 7c 27 00 00    	pushl  0x277c
    18c6:	e8 50 f2 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    18cb:	83 c4 10             	add    $0x10,%esp
    18ce:	a3 9c 27 00 00       	mov    %eax,0x279c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    18d3:	8d 45 98             	lea    -0x68(%ebp),%eax
    18d6:	83 ec 08             	sub    $0x8,%esp
    18d9:	68 9d 21 00 00       	push   $0x219d
    18de:	50                   	push   %eax
    18df:	e8 fd ef ff ff       	call   8e1 <APLoadBitmap>
    18e4:	83 c4 0c             	add    $0xc,%esp
    18e7:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ea:	a3 70 27 00 00       	mov    %eax,0x2770
    18ef:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18f2:	a3 74 27 00 00       	mov    %eax,0x2774
    18f7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18fa:	a3 78 27 00 00       	mov    %eax,0x2778
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    18ff:	83 ec 04             	sub    $0x4,%esp
    1902:	ff 35 78 27 00 00    	pushl  0x2778
    1908:	ff 35 74 27 00 00    	pushl  0x2774
    190e:	ff 35 70 27 00 00    	pushl  0x2770
    1914:	e8 02 f2 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    1919:	83 c4 10             	add    $0x10,%esp
    191c:	a3 88 27 00 00       	mov    %eax,0x2788
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1921:	8d 45 98             	lea    -0x68(%ebp),%eax
    1924:	83 ec 08             	sub    $0x8,%esp
    1927:	68 af 21 00 00       	push   $0x21af
    192c:	50                   	push   %eax
    192d:	e8 af ef ff ff       	call   8e1 <APLoadBitmap>
    1932:	83 c4 0c             	add    $0xc,%esp
    1935:	8b 45 98             	mov    -0x68(%ebp),%eax
    1938:	a3 ac 27 00 00       	mov    %eax,0x27ac
    193d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1940:	a3 b0 27 00 00       	mov    %eax,0x27b0
    1945:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1948:	a3 b4 27 00 00       	mov    %eax,0x27b4
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    194d:	83 ec 04             	sub    $0x4,%esp
    1950:	ff 35 b4 27 00 00    	pushl  0x27b4
    1956:	ff 35 b0 27 00 00    	pushl  0x27b0
    195c:	ff 35 ac 27 00 00    	pushl  0x27ac
    1962:	e8 b4 f1 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    1967:	83 c4 10             	add    $0x10,%esp
    196a:	a3 d8 27 00 00       	mov    %eax,0x27d8
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    196f:	8b 45 08             	mov    0x8(%ebp),%eax
    1972:	8b 40 08             	mov    0x8(%eax),%eax
    1975:	85 c0                	test   %eax,%eax
    1977:	75 17                	jne    1990 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1979:	83 ec 08             	sub    $0x8,%esp
    197c:	68 c0 21 00 00       	push   $0x21c0
    1981:	6a 01                	push   $0x1
    1983:	e8 d3 ea ff ff       	call   45b <printf>
    1988:	83 c4 10             	add    $0x10,%esp
        return;
    198b:	e9 f2 03 00 00       	jmp    1d82 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1990:	8b 45 08             	mov    0x8(%ebp),%eax
    1993:	8b 40 10             	mov    0x10(%eax),%eax
    1996:	85 c0                	test   %eax,%eax
    1998:	7e 10                	jle    19aa <APGridPaint+0x27d>
    199a:	8b 45 08             	mov    0x8(%ebp),%eax
    199d:	8b 50 14             	mov    0x14(%eax),%edx
    19a0:	8b 45 08             	mov    0x8(%ebp),%eax
    19a3:	8b 40 10             	mov    0x10(%eax),%eax
    19a6:	39 c2                	cmp    %eax,%edx
    19a8:	7c 17                	jl     19c1 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    19aa:	83 ec 08             	sub    $0x8,%esp
    19ad:	68 e6 21 00 00       	push   $0x21e6
    19b2:	6a 01                	push   $0x1
    19b4:	e8 a2 ea ff ff       	call   45b <printf>
    19b9:	83 c4 10             	add    $0x10,%esp
        return;
    19bc:	e9 c1 03 00 00       	jmp    1d82 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    19c1:	8b 45 08             	mov    0x8(%ebp),%eax
    19c4:	8b 40 14             	mov    0x14(%eax),%eax
    19c7:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    19cd:	89 45 dc             	mov    %eax,-0x24(%ebp)
    19d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    19d3:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    19d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    19dd:	e9 96 03 00 00       	jmp    1d78 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    19e2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    19e9:	e9 7c 03 00 00       	jmp    1d6a <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    19ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19f1:	c1 e0 04             	shl    $0x4,%eax
    19f4:	89 c2                	mov    %eax,%edx
    19f6:	8b 45 d8             	mov    -0x28(%ebp),%eax
    19f9:	01 c2                	add    %eax,%edx
    19fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19fe:	01 d0                	add    %edx,%eax
    1a00:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a03:	8b 45 08             	mov    0x8(%ebp),%eax
    1a06:	8b 40 0c             	mov    0xc(%eax),%eax
    1a09:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a0c:	c1 e2 02             	shl    $0x2,%edx
    1a0f:	01 d0                	add    %edx,%eax
    1a11:	8b 00                	mov    (%eax),%eax
    1a13:	83 f8 07             	cmp    $0x7,%eax
    1a16:	0f 87 49 03 00 00    	ja     1d65 <APGridPaint+0x638>
    1a1c:	8b 04 85 fc 21 00 00 	mov    0x21fc(,%eax,4),%eax
    1a23:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a25:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a28:	6a 0c                	push   $0xc
    1a2a:	6a 0c                	push   $0xc
    1a2c:	6a 0c                	push   $0xc
    1a2e:	50                   	push   %eax
    1a2f:	e8 46 f9 ff ff       	call   137a <RGB>
    1a34:	83 c4 0c             	add    $0xc,%esp
    1a37:	8b 1d 98 27 00 00    	mov    0x2798,%ebx
    1a3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a40:	6b c8 32             	imul   $0x32,%eax,%ecx
    1a43:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a46:	6b c0 32             	imul   $0x32,%eax,%eax
    1a49:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1a4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4f:	8d 78 34             	lea    0x34(%eax),%edi
    1a52:	83 ec 0c             	sub    $0xc,%esp
    1a55:	83 ec 04             	sub    $0x4,%esp
    1a58:	89 e0                	mov    %esp,%eax
    1a5a:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1a5e:	66 89 30             	mov    %si,(%eax)
    1a61:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1a65:	88 50 02             	mov    %dl,0x2(%eax)
    1a68:	6a 32                	push   $0x32
    1a6a:	6a 32                	push   $0x32
    1a6c:	6a 00                	push   $0x0
    1a6e:	6a 00                	push   $0x0
    1a70:	53                   	push   %ebx
    1a71:	51                   	push   %ecx
    1a72:	ff 75 94             	pushl  -0x6c(%ebp)
    1a75:	57                   	push   %edi
    1a76:	e8 5b f7 ff ff       	call   11d6 <APDcCopy>
    1a7b:	83 c4 30             	add    $0x30,%esp
                    break;
    1a7e:	e9 e3 02 00 00       	jmp    1d66 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a83:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a86:	6a 69                	push   $0x69
    1a88:	6a 69                	push   $0x69
    1a8a:	6a 69                	push   $0x69
    1a8c:	50                   	push   %eax
    1a8d:	e8 e8 f8 ff ff       	call   137a <RGB>
    1a92:	83 c4 0c             	add    $0xc,%esp
    1a95:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1a99:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1a9d:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1aa1:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1aa4:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1aab:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aae:	6a 69                	push   $0x69
    1ab0:	6a 69                	push   $0x69
    1ab2:	6a 69                	push   $0x69
    1ab4:	50                   	push   %eax
    1ab5:	e8 c0 f8 ff ff       	call   137a <RGB>
    1aba:	83 c4 0c             	add    $0xc,%esp
    1abd:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ac1:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ac5:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ac9:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1acc:	8b 45 08             	mov    0x8(%ebp),%eax
    1acf:	8d 50 34             	lea    0x34(%eax),%edx
    1ad2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ad5:	ff 75 bc             	pushl  -0x44(%ebp)
    1ad8:	ff 75 b8             	pushl  -0x48(%ebp)
    1adb:	52                   	push   %edx
    1adc:	50                   	push   %eax
    1add:	e8 ce f0 ff ff       	call   bb0 <APSetPen>
    1ae2:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ae5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae8:	8d 58 34             	lea    0x34(%eax),%ebx
    1aeb:	8d 55 98             	lea    -0x68(%ebp),%edx
    1aee:	83 ec 04             	sub    $0x4,%esp
    1af1:	83 ec 04             	sub    $0x4,%esp
    1af4:	89 e0                	mov    %esp,%eax
    1af6:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1afa:	66 89 08             	mov    %cx,(%eax)
    1afd:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1b01:	88 48 02             	mov    %cl,0x2(%eax)
    1b04:	53                   	push   %ebx
    1b05:	52                   	push   %edx
    1b06:	e8 de f0 ff ff       	call   be9 <APSetBrush>
    1b0b:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b0e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b11:	6b d0 32             	imul   $0x32,%eax,%edx
    1b14:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b17:	6b c0 32             	imul   $0x32,%eax,%eax
    1b1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b1d:	83 c1 34             	add    $0x34,%ecx
    1b20:	83 ec 0c             	sub    $0xc,%esp
    1b23:	6a 32                	push   $0x32
    1b25:	6a 32                	push   $0x32
    1b27:	52                   	push   %edx
    1b28:	50                   	push   %eax
    1b29:	51                   	push   %ecx
    1b2a:	e8 a2 f4 ff ff       	call   fd1 <APDrawRect>
    1b2f:	83 c4 20             	add    $0x20,%esp
                    break;
    1b32:	e9 2f 02 00 00       	jmp    1d66 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b37:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1b3a:	6a 0c                	push   $0xc
    1b3c:	6a 0c                	push   $0xc
    1b3e:	6a 0c                	push   $0xc
    1b40:	50                   	push   %eax
    1b41:	e8 34 f8 ff ff       	call   137a <RGB>
    1b46:	83 c4 0c             	add    $0xc,%esp
    1b49:	8b 1d d8 27 00 00    	mov    0x27d8,%ebx
    1b4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b52:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b55:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b58:	6b c0 32             	imul   $0x32,%eax,%eax
    1b5b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b61:	8d 78 34             	lea    0x34(%eax),%edi
    1b64:	83 ec 0c             	sub    $0xc,%esp
    1b67:	83 ec 04             	sub    $0x4,%esp
    1b6a:	89 e0                	mov    %esp,%eax
    1b6c:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1b70:	66 89 30             	mov    %si,(%eax)
    1b73:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1b77:	88 50 02             	mov    %dl,0x2(%eax)
    1b7a:	6a 32                	push   $0x32
    1b7c:	6a 32                	push   $0x32
    1b7e:	6a 00                	push   $0x0
    1b80:	6a 00                	push   $0x0
    1b82:	53                   	push   %ebx
    1b83:	51                   	push   %ecx
    1b84:	ff 75 94             	pushl  -0x6c(%ebp)
    1b87:	57                   	push   %edi
    1b88:	e8 49 f6 ff ff       	call   11d6 <APDcCopy>
    1b8d:	83 c4 30             	add    $0x30,%esp
                    break;
    1b90:	e9 d1 01 00 00       	jmp    1d66 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b95:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1b98:	6a 0c                	push   $0xc
    1b9a:	6a 0c                	push   $0xc
    1b9c:	6a 0c                	push   $0xc
    1b9e:	50                   	push   %eax
    1b9f:	e8 d6 f7 ff ff       	call   137a <RGB>
    1ba4:	83 c4 0c             	add    $0xc,%esp
    1ba7:	8b 1d b8 27 00 00    	mov    0x27b8,%ebx
    1bad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bb0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bb3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bb6:	6b c0 32             	imul   $0x32,%eax,%eax
    1bb9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbf:	8d 78 34             	lea    0x34(%eax),%edi
    1bc2:	83 ec 0c             	sub    $0xc,%esp
    1bc5:	83 ec 04             	sub    $0x4,%esp
    1bc8:	89 e0                	mov    %esp,%eax
    1bca:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1bce:	66 89 30             	mov    %si,(%eax)
    1bd1:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1bd5:	88 50 02             	mov    %dl,0x2(%eax)
    1bd8:	6a 32                	push   $0x32
    1bda:	6a 32                	push   $0x32
    1bdc:	6a 00                	push   $0x0
    1bde:	6a 00                	push   $0x0
    1be0:	53                   	push   %ebx
    1be1:	51                   	push   %ecx
    1be2:	ff 75 94             	pushl  -0x6c(%ebp)
    1be5:	57                   	push   %edi
    1be6:	e8 eb f5 ff ff       	call   11d6 <APDcCopy>
    1beb:	83 c4 30             	add    $0x30,%esp
                    break;
    1bee:	e9 73 01 00 00       	jmp    1d66 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bf3:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1bf6:	6a 0c                	push   $0xc
    1bf8:	6a 0c                	push   $0xc
    1bfa:	6a 0c                	push   $0xc
    1bfc:	50                   	push   %eax
    1bfd:	e8 78 f7 ff ff       	call   137a <RGB>
    1c02:	83 c4 0c             	add    $0xc,%esp
    1c05:	8b 1d 9c 27 00 00    	mov    0x279c,%ebx
    1c0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c0e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c11:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c14:	6b c0 32             	imul   $0x32,%eax,%eax
    1c17:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1d:	8d 78 34             	lea    0x34(%eax),%edi
    1c20:	83 ec 0c             	sub    $0xc,%esp
    1c23:	83 ec 04             	sub    $0x4,%esp
    1c26:	89 e0                	mov    %esp,%eax
    1c28:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c2c:	66 89 30             	mov    %si,(%eax)
    1c2f:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1c33:	88 50 02             	mov    %dl,0x2(%eax)
    1c36:	6a 32                	push   $0x32
    1c38:	6a 32                	push   $0x32
    1c3a:	6a 00                	push   $0x0
    1c3c:	6a 00                	push   $0x0
    1c3e:	53                   	push   %ebx
    1c3f:	51                   	push   %ecx
    1c40:	ff 75 94             	pushl  -0x6c(%ebp)
    1c43:	57                   	push   %edi
    1c44:	e8 8d f5 ff ff       	call   11d6 <APDcCopy>
    1c49:	83 c4 30             	add    $0x30,%esp
                    break;
    1c4c:	e9 15 01 00 00       	jmp    1d66 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c51:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1c54:	6a 0c                	push   $0xc
    1c56:	6a 0c                	push   $0xc
    1c58:	6a 0c                	push   $0xc
    1c5a:	50                   	push   %eax
    1c5b:	e8 1a f7 ff ff       	call   137a <RGB>
    1c60:	83 c4 0c             	add    $0xc,%esp
    1c63:	8b 1d d4 27 00 00    	mov    0x27d4,%ebx
    1c69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c6c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c72:	6b c0 32             	imul   $0x32,%eax,%eax
    1c75:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c78:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7b:	8d 78 34             	lea    0x34(%eax),%edi
    1c7e:	83 ec 0c             	sub    $0xc,%esp
    1c81:	83 ec 04             	sub    $0x4,%esp
    1c84:	89 e0                	mov    %esp,%eax
    1c86:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1c8a:	66 89 30             	mov    %si,(%eax)
    1c8d:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1c91:	88 50 02             	mov    %dl,0x2(%eax)
    1c94:	6a 32                	push   $0x32
    1c96:	6a 32                	push   $0x32
    1c98:	6a 00                	push   $0x0
    1c9a:	6a 00                	push   $0x0
    1c9c:	53                   	push   %ebx
    1c9d:	51                   	push   %ecx
    1c9e:	ff 75 94             	pushl  -0x6c(%ebp)
    1ca1:	57                   	push   %edi
    1ca2:	e8 2f f5 ff ff       	call   11d6 <APDcCopy>
    1ca7:	83 c4 30             	add    $0x30,%esp
                    break;
    1caa:	e9 b7 00 00 00       	jmp    1d66 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1caf:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1cb2:	6a 0c                	push   $0xc
    1cb4:	6a 0c                	push   $0xc
    1cb6:	6a 0c                	push   $0xc
    1cb8:	50                   	push   %eax
    1cb9:	e8 bc f6 ff ff       	call   137a <RGB>
    1cbe:	83 c4 0c             	add    $0xc,%esp
    1cc1:	8b 1d 6c 27 00 00    	mov    0x276c,%ebx
    1cc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cca:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ccd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cd0:	6b c0 32             	imul   $0x32,%eax,%eax
    1cd3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd9:	8d 78 34             	lea    0x34(%eax),%edi
    1cdc:	83 ec 0c             	sub    $0xc,%esp
    1cdf:	83 ec 04             	sub    $0x4,%esp
    1ce2:	89 e0                	mov    %esp,%eax
    1ce4:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1ce8:	66 89 30             	mov    %si,(%eax)
    1ceb:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1cef:	88 50 02             	mov    %dl,0x2(%eax)
    1cf2:	6a 32                	push   $0x32
    1cf4:	6a 32                	push   $0x32
    1cf6:	6a 00                	push   $0x0
    1cf8:	6a 00                	push   $0x0
    1cfa:	53                   	push   %ebx
    1cfb:	51                   	push   %ecx
    1cfc:	ff 75 94             	pushl  -0x6c(%ebp)
    1cff:	57                   	push   %edi
    1d00:	e8 d1 f4 ff ff       	call   11d6 <APDcCopy>
    1d05:	83 c4 30             	add    $0x30,%esp
                    break;
    1d08:	eb 5c                	jmp    1d66 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d0a:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d0d:	6a 0c                	push   $0xc
    1d0f:	6a 0c                	push   $0xc
    1d11:	6a 0c                	push   $0xc
    1d13:	50                   	push   %eax
    1d14:	e8 61 f6 ff ff       	call   137a <RGB>
    1d19:	83 c4 0c             	add    $0xc,%esp
    1d1c:	8b 1d 88 27 00 00    	mov    0x2788,%ebx
    1d22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d25:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d28:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d2b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d2e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d31:	8b 45 08             	mov    0x8(%ebp),%eax
    1d34:	8d 78 34             	lea    0x34(%eax),%edi
    1d37:	83 ec 0c             	sub    $0xc,%esp
    1d3a:	83 ec 04             	sub    $0x4,%esp
    1d3d:	89 e0                	mov    %esp,%eax
    1d3f:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1d43:	66 89 30             	mov    %si,(%eax)
    1d46:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1d4a:	88 50 02             	mov    %dl,0x2(%eax)
    1d4d:	6a 32                	push   $0x32
    1d4f:	6a 32                	push   $0x32
    1d51:	6a 00                	push   $0x0
    1d53:	6a 00                	push   $0x0
    1d55:	53                   	push   %ebx
    1d56:	51                   	push   %ecx
    1d57:	ff 75 94             	pushl  -0x6c(%ebp)
    1d5a:	57                   	push   %edi
    1d5b:	e8 76 f4 ff ff       	call   11d6 <APDcCopy>
    1d60:	83 c4 30             	add    $0x30,%esp
                    break;
    1d63:	eb 01                	jmp    1d66 <APGridPaint+0x639>
                default: break;
    1d65:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d66:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1d6a:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1d6e:	0f 8e 7a fc ff ff    	jle    19ee <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d74:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1d78:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1d7c:	0f 8e 60 fc ff ff    	jle    19e2 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1d82:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d85:	5b                   	pop    %ebx
    1d86:	5e                   	pop    %esi
    1d87:	5f                   	pop    %edi
    1d88:	5d                   	pop    %ebp
    1d89:	c3                   	ret    

00001d8a <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1d8a:	55                   	push   %ebp
    1d8b:	89 e5                	mov    %esp,%ebp
    1d8d:	53                   	push   %ebx
    1d8e:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1d91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1d98:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1d9c:	74 17                	je     1db5 <sprintint+0x2b>
    1d9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1da2:	79 11                	jns    1db5 <sprintint+0x2b>
        neg = 1;
    1da4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1dab:	8b 45 10             	mov    0x10(%ebp),%eax
    1dae:	f7 d8                	neg    %eax
    1db0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1db3:	eb 06                	jmp    1dbb <sprintint+0x31>
    } else {
        x = xx;
    1db5:	8b 45 10             	mov    0x10(%ebp),%eax
    1db8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1dbb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1dc2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1dc5:	8d 41 01             	lea    0x1(%ecx),%eax
    1dc8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1dcb:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1dce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dd1:	ba 00 00 00 00       	mov    $0x0,%edx
    1dd6:	f7 f3                	div    %ebx
    1dd8:	89 d0                	mov    %edx,%eax
    1dda:	0f b6 80 48 27 00 00 	movzbl 0x2748(%eax),%eax
    1de1:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1de5:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1de8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1deb:	ba 00 00 00 00       	mov    $0x0,%edx
    1df0:	f7 f3                	div    %ebx
    1df2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1df5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1df9:	75 c7                	jne    1dc2 <sprintint+0x38>
    if(neg)
    1dfb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dff:	74 0e                	je     1e0f <sprintint+0x85>
        buf[i++] = '-';
    1e01:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e04:	8d 50 01             	lea    0x1(%eax),%edx
    1e07:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1e0a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1e0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e12:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1e15:	eb 1b                	jmp    1e32 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1e17:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e1a:	8b 00                	mov    (%eax),%eax
    1e1c:	8d 48 01             	lea    0x1(%eax),%ecx
    1e1f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e22:	89 0a                	mov    %ecx,(%edx)
    1e24:	89 c2                	mov    %eax,%edx
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	01 d0                	add    %edx,%eax
    1e2b:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1e2e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1e32:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1e36:	7f df                	jg     1e17 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e38:	eb 21                	jmp    1e5b <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1e3a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e3d:	8b 00                	mov    (%eax),%eax
    1e3f:	8d 48 01             	lea    0x1(%eax),%ecx
    1e42:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e45:	89 0a                	mov    %ecx,(%edx)
    1e47:	89 c2                	mov    %eax,%edx
    1e49:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4c:	01 c2                	add    %eax,%edx
    1e4e:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1e51:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1e54:	01 c8                	add    %ecx,%eax
    1e56:	0f b6 00             	movzbl (%eax),%eax
    1e59:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1e5b:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1e5f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1e63:	79 d5                	jns    1e3a <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1e65:	90                   	nop
    1e66:	83 c4 20             	add    $0x20,%esp
    1e69:	5b                   	pop    %ebx
    1e6a:	5d                   	pop    %ebp
    1e6b:	c3                   	ret    

00001e6c <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1e6c:	55                   	push   %ebp
    1e6d:	89 e5                	mov    %esp,%ebp
    1e6f:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1e72:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1e79:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1e80:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1e87:	8d 45 0c             	lea    0xc(%ebp),%eax
    1e8a:	83 c0 04             	add    $0x4,%eax
    1e8d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1e90:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1e97:	e9 d9 01 00 00       	jmp    2075 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1e9c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ea2:	01 d0                	add    %edx,%eax
    1ea4:	0f b6 00             	movzbl (%eax),%eax
    1ea7:	0f be c0             	movsbl %al,%eax
    1eaa:	25 ff 00 00 00       	and    $0xff,%eax
    1eaf:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1eb2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1eb6:	75 2c                	jne    1ee4 <sprintf+0x78>
            if(c == '%'){
    1eb8:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ebc:	75 0c                	jne    1eca <sprintf+0x5e>
                state = '%';
    1ebe:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1ec5:	e9 a7 01 00 00       	jmp    2071 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1eca:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ecd:	8d 50 01             	lea    0x1(%eax),%edx
    1ed0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ed3:	89 c2                	mov    %eax,%edx
    1ed5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed8:	01 d0                	add    %edx,%eax
    1eda:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1edd:	88 10                	mov    %dl,(%eax)
    1edf:	e9 8d 01 00 00       	jmp    2071 <sprintf+0x205>
            }
        } else if(state == '%'){
    1ee4:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1ee8:	0f 85 83 01 00 00    	jne    2071 <sprintf+0x205>
            if(c == 'd'){
    1eee:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1ef2:	75 4c                	jne    1f40 <sprintf+0xd4>
                buf[bi] = '\0';
    1ef4:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1ef7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1efa:	01 d0                	add    %edx,%eax
    1efc:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1eff:	83 ec 0c             	sub    $0xc,%esp
    1f02:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f05:	50                   	push   %eax
    1f06:	e8 1f e3 ff ff       	call   22a <atoi>
    1f0b:	83 c4 10             	add    $0x10,%esp
    1f0e:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1f11:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1f18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f1b:	8b 00                	mov    (%eax),%eax
    1f1d:	83 ec 08             	sub    $0x8,%esp
    1f20:	ff 75 d8             	pushl  -0x28(%ebp)
    1f23:	6a 01                	push   $0x1
    1f25:	6a 0a                	push   $0xa
    1f27:	50                   	push   %eax
    1f28:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f2b:	50                   	push   %eax
    1f2c:	ff 75 08             	pushl  0x8(%ebp)
    1f2f:	e8 56 fe ff ff       	call   1d8a <sprintint>
    1f34:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f37:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1f3b:	e9 2a 01 00 00       	jmp    206a <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1f40:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1f44:	74 06                	je     1f4c <sprintf+0xe0>
    1f46:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1f4a:	75 4c                	jne    1f98 <sprintf+0x12c>
                buf[bi] = '\0';
    1f4c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1f4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f52:	01 d0                	add    %edx,%eax
    1f54:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1f57:	83 ec 0c             	sub    $0xc,%esp
    1f5a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1f5d:	50                   	push   %eax
    1f5e:	e8 c7 e2 ff ff       	call   22a <atoi>
    1f63:	83 c4 10             	add    $0x10,%esp
    1f66:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1f69:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1f70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f73:	8b 00                	mov    (%eax),%eax
    1f75:	83 ec 08             	sub    $0x8,%esp
    1f78:	ff 75 dc             	pushl  -0x24(%ebp)
    1f7b:	6a 00                	push   $0x0
    1f7d:	6a 10                	push   $0x10
    1f7f:	50                   	push   %eax
    1f80:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1f83:	50                   	push   %eax
    1f84:	ff 75 08             	pushl  0x8(%ebp)
    1f87:	e8 fe fd ff ff       	call   1d8a <sprintint>
    1f8c:	83 c4 20             	add    $0x20,%esp
                ap++;
    1f8f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1f93:	e9 d2 00 00 00       	jmp    206a <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1f98:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1f9c:	75 46                	jne    1fe4 <sprintf+0x178>
                s = (char*)*ap;
    1f9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fa1:	8b 00                	mov    (%eax),%eax
    1fa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1fa6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1faa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fae:	75 25                	jne    1fd5 <sprintf+0x169>
                    s = "(null)";
    1fb0:	c7 45 f4 1c 22 00 00 	movl   $0x221c,-0xc(%ebp)
                while(*s != 0){
    1fb7:	eb 1c                	jmp    1fd5 <sprintf+0x169>
                    dst[j++] = *s;
    1fb9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fbc:	8d 50 01             	lea    0x1(%eax),%edx
    1fbf:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fc2:	89 c2                	mov    %eax,%edx
    1fc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc7:	01 c2                	add    %eax,%edx
    1fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fcc:	0f b6 00             	movzbl (%eax),%eax
    1fcf:	88 02                	mov    %al,(%edx)
                    s++;
    1fd1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1fd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fd8:	0f b6 00             	movzbl (%eax),%eax
    1fdb:	84 c0                	test   %al,%al
    1fdd:	75 da                	jne    1fb9 <sprintf+0x14d>
    1fdf:	e9 86 00 00 00       	jmp    206a <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1fe4:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1fe8:	75 1d                	jne    2007 <sprintf+0x19b>
                dst[j++] = *ap;
    1fea:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fed:	8d 50 01             	lea    0x1(%eax),%edx
    1ff0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ff3:	89 c2                	mov    %eax,%edx
    1ff5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff8:	01 c2                	add    %eax,%edx
    1ffa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ffd:	8b 00                	mov    (%eax),%eax
    1fff:	88 02                	mov    %al,(%edx)
                ap++;
    2001:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2005:	eb 63                	jmp    206a <sprintf+0x1fe>
            } else if(c == '%'){
    2007:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    200b:	75 17                	jne    2024 <sprintf+0x1b8>
                dst[j++] = c;
    200d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2010:	8d 50 01             	lea    0x1(%eax),%edx
    2013:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2016:	89 c2                	mov    %eax,%edx
    2018:	8b 45 08             	mov    0x8(%ebp),%eax
    201b:	01 d0                	add    %edx,%eax
    201d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2020:	88 10                	mov    %dl,(%eax)
    2022:	eb 46                	jmp    206a <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2024:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2028:	7e 18                	jle    2042 <sprintf+0x1d6>
    202a:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    202e:	7f 12                	jg     2042 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2030:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2033:	8d 50 01             	lea    0x1(%eax),%edx
    2036:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2039:	8b 55 e0             	mov    -0x20(%ebp),%edx
    203c:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2040:	eb 2f                	jmp    2071 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2042:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2045:	8d 50 01             	lea    0x1(%eax),%edx
    2048:	89 55 c8             	mov    %edx,-0x38(%ebp)
    204b:	89 c2                	mov    %eax,%edx
    204d:	8b 45 08             	mov    0x8(%ebp),%eax
    2050:	01 d0                	add    %edx,%eax
    2052:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2055:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2058:	8d 50 01             	lea    0x1(%eax),%edx
    205b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    205e:	89 c2                	mov    %eax,%edx
    2060:	8b 45 08             	mov    0x8(%ebp),%eax
    2063:	01 d0                	add    %edx,%eax
    2065:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2068:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    206a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2071:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2075:	8b 55 0c             	mov    0xc(%ebp),%edx
    2078:	8b 45 ec             	mov    -0x14(%ebp),%eax
    207b:	01 d0                	add    %edx,%eax
    207d:	0f b6 00             	movzbl (%eax),%eax
    2080:	84 c0                	test   %al,%al
    2082:	0f 85 14 fe ff ff    	jne    1e9c <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2088:	8b 45 c8             	mov    -0x38(%ebp),%eax
    208b:	8d 50 01             	lea    0x1(%eax),%edx
    208e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2091:	89 c2                	mov    %eax,%edx
    2093:	8b 45 08             	mov    0x8(%ebp),%eax
    2096:	01 d0                	add    %edx,%eax
    2098:	c6 00 00             	movb   $0x0,(%eax)
}
    209b:	90                   	nop
    209c:	c9                   	leave  
    209d:	c3                   	ret    
