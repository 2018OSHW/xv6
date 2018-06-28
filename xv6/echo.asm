
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
      27:	ba 1c 22 00 00       	mov    $0x221c,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba 1e 22 00 00       	mov    $0x221e,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 20 22 00 00       	push   $0x2220
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
     3f7:	0f b6 80 f8 28 00 00 	movzbl 0x28f8(%eax),%eax
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
     535:	c7 45 f4 25 22 00 00 	movl   $0x2225,-0xc(%ebp)
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
     5fb:	a1 2c 29 00 00       	mov    0x292c,%eax
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
     6c6:	a3 2c 29 00 00       	mov    %eax,0x292c
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
     727:	a1 2c 29 00 00       	mov    0x292c,%eax
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
     743:	a1 2c 29 00 00       	mov    0x292c,%eax
     748:	89 45 f0             	mov    %eax,-0x10(%ebp)
     74b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     74f:	75 23                	jne    774 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     751:	c7 45 f0 24 29 00 00 	movl   $0x2924,-0x10(%ebp)
     758:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75b:	a3 2c 29 00 00       	mov    %eax,0x292c
     760:	a1 2c 29 00 00       	mov    0x292c,%eax
     765:	a3 24 29 00 00       	mov    %eax,0x2924
    base.s.size = 0;
     76a:	c7 05 28 29 00 00 00 	movl   $0x0,0x2928
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
     7c7:	a3 2c 29 00 00       	mov    %eax,0x292c
      return (void*)(p + 1);
     7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7cf:	83 c0 08             	add    $0x8,%eax
     7d2:	eb 3b                	jmp    80f <malloc+0xe1>
    }
    if(p == freep)
     7d4:	a1 2c 29 00 00       	mov    0x292c,%eax
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
     91a:	68 2c 22 00 00       	push   $0x222c
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

000011d6 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    11d6:	55                   	push   %ebp
    11d7:	89 e5                	mov    %esp,%ebp
}
    11d9:	90                   	nop
    11da:	5d                   	pop    %ebp
    11db:	c3                   	ret    

000011dc <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    11dc:	55                   	push   %ebp
    11dd:	89 e5                	mov    %esp,%ebp
    11df:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    11e2:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    11e6:	0f 88 8e 01 00 00    	js     137a <APDcCopy+0x19e>
    11ec:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    11f0:	0f 88 84 01 00 00    	js     137a <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    11f6:	8b 55 0c             	mov    0xc(%ebp),%edx
    11f9:	8b 45 20             	mov    0x20(%ebp),%eax
    11fc:	01 d0                	add    %edx,%eax
    11fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1201:	8b 55 10             	mov    0x10(%ebp),%edx
    1204:	8b 45 24             	mov    0x24(%ebp),%eax
    1207:	01 d0                	add    %edx,%eax
    1209:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    120c:	8b 55 18             	mov    0x18(%ebp),%edx
    120f:	8b 45 20             	mov    0x20(%ebp),%eax
    1212:	01 d0                	add    %edx,%eax
    1214:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1217:	8b 55 1c             	mov    0x1c(%ebp),%edx
    121a:	8b 45 24             	mov    0x24(%ebp),%eax
    121d:	01 d0                	add    %edx,%eax
    121f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1222:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1226:	0f 88 51 01 00 00    	js     137d <APDcCopy+0x1a1>
    122c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1230:	0f 88 47 01 00 00    	js     137d <APDcCopy+0x1a1>
    1236:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    123a:	0f 88 3d 01 00 00    	js     137d <APDcCopy+0x1a1>
    1240:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1244:	0f 88 33 01 00 00    	js     137d <APDcCopy+0x1a1>
    124a:	8b 45 14             	mov    0x14(%ebp),%eax
    124d:	8b 00                	mov    (%eax),%eax
    124f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1252:	0f 8c 25 01 00 00    	jl     137d <APDcCopy+0x1a1>
    1258:	8b 45 14             	mov    0x14(%ebp),%eax
    125b:	8b 40 04             	mov    0x4(%eax),%eax
    125e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1261:	0f 8c 16 01 00 00    	jl     137d <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1267:	8b 45 08             	mov    0x8(%ebp),%eax
    126a:	8b 00                	mov    (%eax),%eax
    126c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    126f:	7f 0b                	jg     127c <APDcCopy+0xa0>
    1271:	8b 45 08             	mov    0x8(%ebp),%eax
    1274:	8b 00                	mov    (%eax),%eax
    1276:	83 e8 01             	sub    $0x1,%eax
    1279:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    127c:	8b 45 08             	mov    0x8(%ebp),%eax
    127f:	8b 40 04             	mov    0x4(%eax),%eax
    1282:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1285:	7f 0c                	jg     1293 <APDcCopy+0xb7>
    1287:	8b 45 08             	mov    0x8(%ebp),%eax
    128a:	8b 40 04             	mov    0x4(%eax),%eax
    128d:	83 e8 01             	sub    $0x1,%eax
    1290:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1293:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    129a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    12a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12a8:	e9 bc 00 00 00       	jmp    1369 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
    12b0:	8b 00                	mov    (%eax),%eax
    12b2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12b5:	8b 55 10             	mov    0x10(%ebp),%edx
    12b8:	01 ca                	add    %ecx,%edx
    12ba:	0f af d0             	imul   %eax,%edx
    12bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    12c0:	01 d0                	add    %edx,%eax
    12c2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    12c5:	8b 45 14             	mov    0x14(%ebp),%eax
    12c8:	8b 00                	mov    (%eax),%eax
    12ca:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12cd:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12d0:	01 ca                	add    %ecx,%edx
    12d2:	0f af d0             	imul   %eax,%edx
    12d5:	8b 45 18             	mov    0x18(%ebp),%eax
    12d8:	01 d0                	add    %edx,%eax
    12da:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    12dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12e4:	eb 74                	jmp    135a <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    12e6:	8b 45 14             	mov    0x14(%ebp),%eax
    12e9:	8b 50 18             	mov    0x18(%eax),%edx
    12ec:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f2:	01 c8                	add    %ecx,%eax
    12f4:	89 c1                	mov    %eax,%ecx
    12f6:	89 c8                	mov    %ecx,%eax
    12f8:	01 c0                	add    %eax,%eax
    12fa:	01 c8                	add    %ecx,%eax
    12fc:	01 d0                	add    %edx,%eax
    12fe:	0f b7 10             	movzwl (%eax),%edx
    1301:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1305:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1309:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    130c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1310:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1314:	38 c2                	cmp    %al,%dl
    1316:	75 18                	jne    1330 <APDcCopy+0x154>
    1318:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    131c:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1320:	38 c2                	cmp    %al,%dl
    1322:	75 0c                	jne    1330 <APDcCopy+0x154>
    1324:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1328:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    132c:	38 c2                	cmp    %al,%dl
    132e:	74 26                	je     1356 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1330:	8b 45 08             	mov    0x8(%ebp),%eax
    1333:	8b 50 18             	mov    0x18(%eax),%edx
    1336:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1339:	8b 45 f0             	mov    -0x10(%ebp),%eax
    133c:	01 c8                	add    %ecx,%eax
    133e:	89 c1                	mov    %eax,%ecx
    1340:	89 c8                	mov    %ecx,%eax
    1342:	01 c0                	add    %eax,%eax
    1344:	01 c8                	add    %ecx,%eax
    1346:	01 d0                	add    %edx,%eax
    1348:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    134c:	66 89 10             	mov    %dx,(%eax)
    134f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1353:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1356:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    135a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    135d:	2b 45 0c             	sub    0xc(%ebp),%eax
    1360:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1363:	7d 81                	jge    12e6 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1365:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1369:	8b 45 f8             	mov    -0x8(%ebp),%eax
    136c:	2b 45 10             	sub    0x10(%ebp),%eax
    136f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1372:	0f 8d 35 ff ff ff    	jge    12ad <APDcCopy+0xd1>
    1378:	eb 04                	jmp    137e <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    137a:	90                   	nop
    137b:	eb 01                	jmp    137e <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    137d:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    137e:	c9                   	leave  
    137f:	c3                   	ret    

00001380 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	83 ec 1c             	sub    $0x1c,%esp
    1386:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1389:	8b 55 10             	mov    0x10(%ebp),%edx
    138c:	8b 45 14             	mov    0x14(%ebp),%eax
    138f:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1392:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1395:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1398:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    139c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    139f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    13a3:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    13a6:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    13aa:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    13ad:	8b 45 08             	mov    0x8(%ebp),%eax
    13b0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    13b4:	66 89 10             	mov    %dx,(%eax)
    13b7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    13bb:	88 50 02             	mov    %dl,0x2(%eax)
}
    13be:	8b 45 08             	mov    0x8(%ebp),%eax
    13c1:	c9                   	leave  
    13c2:	c2 04 00             	ret    $0x4

000013c5 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    13c5:	55                   	push   %ebp
    13c6:	89 e5                	mov    %esp,%ebp
    13c8:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    13cb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ce:	8b 00                	mov    (%eax),%eax
    13d0:	83 ec 08             	sub    $0x8,%esp
    13d3:	8d 55 0c             	lea    0xc(%ebp),%edx
    13d6:	52                   	push   %edx
    13d7:	50                   	push   %eax
    13d8:	e8 87 ef ff ff       	call   364 <sendMessage>
    13dd:	83 c4 10             	add    $0x10,%esp
}
    13e0:	90                   	nop
    13e1:	c9                   	leave  
    13e2:	c3                   	ret    

000013e3 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    13e3:	55                   	push   %ebp
    13e4:	89 e5                	mov    %esp,%ebp
    13e6:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    13e9:	83 ec 0c             	sub    $0xc,%esp
    13ec:	68 98 00 00 00       	push   $0x98
    13f1:	e8 38 f3 ff ff       	call   72e <malloc>
    13f6:	83 c4 10             	add    $0x10,%esp
    13f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    13fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1400:	75 15                	jne    1417 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1402:	83 ec 04             	sub    $0x4,%esp
    1405:	ff 75 08             	pushl  0x8(%ebp)
    1408:	68 3c 22 00 00       	push   $0x223c
    140d:	6a 01                	push   $0x1
    140f:	e8 47 f0 ff ff       	call   45b <printf>
    1414:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1417:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141a:	05 84 00 00 00       	add    $0x84,%eax
    141f:	83 ec 08             	sub    $0x8,%esp
    1422:	ff 75 08             	pushl  0x8(%ebp)
    1425:	50                   	push   %eax
    1426:	e8 60 ec ff ff       	call   8b <strcpy>
    142b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    142e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1431:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1438:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143b:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1442:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1445:	8b 40 3c             	mov    0x3c(%eax),%eax
    1448:	89 c2                	mov    %eax,%edx
    144a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    144d:	8b 40 40             	mov    0x40(%eax),%eax
    1450:	0f af d0             	imul   %eax,%edx
    1453:	89 d0                	mov    %edx,%eax
    1455:	01 c0                	add    %eax,%eax
    1457:	01 d0                	add    %edx,%eax
    1459:	83 ec 0c             	sub    $0xc,%esp
    145c:	50                   	push   %eax
    145d:	e8 cc f2 ff ff       	call   72e <malloc>
    1462:	83 c4 10             	add    $0x10,%esp
    1465:	89 c2                	mov    %eax,%edx
    1467:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146a:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    146d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1470:	8b 40 54             	mov    0x54(%eax),%eax
    1473:	85 c0                	test   %eax,%eax
    1475:	75 15                	jne    148c <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1477:	83 ec 04             	sub    $0x4,%esp
    147a:	ff 75 08             	pushl  0x8(%ebp)
    147d:	68 5c 22 00 00       	push   $0x225c
    1482:	6a 01                	push   $0x1
    1484:	e8 d2 ef ff ff       	call   45b <printf>
    1489:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    148c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148f:	8b 40 3c             	mov    0x3c(%eax),%eax
    1492:	89 c2                	mov    %eax,%edx
    1494:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1497:	8b 40 40             	mov    0x40(%eax),%eax
    149a:	0f af d0             	imul   %eax,%edx
    149d:	89 d0                	mov    %edx,%eax
    149f:	01 c0                	add    %eax,%eax
    14a1:	01 c2                	add    %eax,%edx
    14a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14a6:	8b 40 54             	mov    0x54(%eax),%eax
    14a9:	83 ec 04             	sub    $0x4,%esp
    14ac:	52                   	push   %edx
    14ad:	68 ff ff ff 00       	push   $0xffffff
    14b2:	50                   	push   %eax
    14b3:	e8 69 ec ff ff       	call   121 <memset>
    14b8:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    14bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14be:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    14c5:	e8 72 ee ff ff       	call   33c <getpid>
    14ca:	89 c2                	mov    %eax,%edx
    14cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14cf:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    14d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d5:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    14dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14df:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    14e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e9:	8b 40 58             	mov    0x58(%eax),%eax
    14ec:	89 c2                	mov    %eax,%edx
    14ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f1:	8b 40 5c             	mov    0x5c(%eax),%eax
    14f4:	0f af d0             	imul   %eax,%edx
    14f7:	89 d0                	mov    %edx,%eax
    14f9:	01 c0                	add    %eax,%eax
    14fb:	01 d0                	add    %edx,%eax
    14fd:	83 ec 0c             	sub    $0xc,%esp
    1500:	50                   	push   %eax
    1501:	e8 28 f2 ff ff       	call   72e <malloc>
    1506:	83 c4 10             	add    $0x10,%esp
    1509:	89 c2                	mov    %eax,%edx
    150b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150e:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1511:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1514:	8b 40 70             	mov    0x70(%eax),%eax
    1517:	85 c0                	test   %eax,%eax
    1519:	75 15                	jne    1530 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    151b:	83 ec 04             	sub    $0x4,%esp
    151e:	ff 75 08             	pushl  0x8(%ebp)
    1521:	68 80 22 00 00       	push   $0x2280
    1526:	6a 01                	push   $0x1
    1528:	e8 2e ef ff ff       	call   45b <printf>
    152d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1530:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1533:	8b 40 3c             	mov    0x3c(%eax),%eax
    1536:	89 c2                	mov    %eax,%edx
    1538:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153b:	8b 40 40             	mov    0x40(%eax),%eax
    153e:	0f af d0             	imul   %eax,%edx
    1541:	89 d0                	mov    %edx,%eax
    1543:	01 c0                	add    %eax,%eax
    1545:	01 c2                	add    %eax,%edx
    1547:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154a:	8b 40 54             	mov    0x54(%eax),%eax
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
    156c:	74 49                	je     15b7 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    156e:	8b 45 10             	mov    0x10(%ebp),%eax
    1571:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1577:	83 ec 0c             	sub    $0xc,%esp
    157a:	50                   	push   %eax
    157b:	e8 ae f1 ff ff       	call   72e <malloc>
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
        r->pos_x = 0;
    159e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a1:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    15b2:	e9 8d 00 00 00       	jmp    1644 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    15c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c4:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    15cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ce:	8b 40 20             	mov    0x20(%eax),%eax
    15d1:	89 c2                	mov    %eax,%edx
    15d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d6:	8b 40 24             	mov    0x24(%eax),%eax
    15d9:	0f af d0             	imul   %eax,%edx
    15dc:	89 d0                	mov    %edx,%eax
    15de:	01 c0                	add    %eax,%eax
    15e0:	01 d0                	add    %edx,%eax
    15e2:	83 ec 0c             	sub    $0xc,%esp
    15e5:	50                   	push   %eax
    15e6:	e8 43 f1 ff ff       	call   72e <malloc>
    15eb:	83 c4 10             	add    $0x10,%esp
    15ee:	89 c2                	mov    %eax,%edx
    15f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f3:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	8b 40 38             	mov    0x38(%eax),%eax
    15fc:	85 c0                	test   %eax,%eax
    15fe:	75 15                	jne    1615 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1600:	83 ec 04             	sub    $0x4,%esp
    1603:	ff 75 08             	pushl  0x8(%ebp)
    1606:	68 a8 22 00 00       	push   $0x22a8
    160b:	6a 01                	push   $0x1
    160d:	e8 49 ee ff ff       	call   45b <printf>
    1612:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1615:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1618:	8b 40 20             	mov    0x20(%eax),%eax
    161b:	89 c2                	mov    %eax,%edx
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	8b 40 24             	mov    0x24(%eax),%eax
    1623:	0f af d0             	imul   %eax,%edx
    1626:	89 d0                	mov    %edx,%eax
    1628:	01 c0                	add    %eax,%eax
    162a:	01 c2                	add    %eax,%edx
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	8b 40 38             	mov    0x38(%eax),%eax
    1632:	83 ec 04             	sub    $0x4,%esp
    1635:	52                   	push   %edx
    1636:	68 ff ff ff 00       	push   $0xffffff
    163b:	50                   	push   %eax
    163c:	e8 e0 ea ff ff       	call   121 <memset>
    1641:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1647:	c9                   	leave  
    1648:	c3                   	ret    

00001649 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1649:	55                   	push   %ebp
    164a:	89 e5                	mov    %esp,%ebp
    164c:	57                   	push   %edi
    164d:	56                   	push   %esi
    164e:	53                   	push   %ebx
    164f:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1652:	8b 45 0c             	mov    0xc(%ebp),%eax
    1655:	83 f8 03             	cmp    $0x3,%eax
    1658:	74 02                	je     165c <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    165a:	eb 7c                	jmp    16d8 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    165c:	8b 45 08             	mov    0x8(%ebp),%eax
    165f:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1662:	8b 45 08             	mov    0x8(%ebp),%eax
    1665:	8b 48 18             	mov    0x18(%eax),%ecx
    1668:	8b 45 08             	mov    0x8(%ebp),%eax
    166b:	8b 50 5c             	mov    0x5c(%eax),%edx
    166e:	8b 45 08             	mov    0x8(%ebp),%eax
    1671:	8b 40 58             	mov    0x58(%eax),%eax
    1674:	8b 75 08             	mov    0x8(%ebp),%esi
    1677:	83 c6 58             	add    $0x58,%esi
    167a:	83 ec 04             	sub    $0x4,%esp
    167d:	53                   	push   %ebx
    167e:	51                   	push   %ecx
    167f:	6a 00                	push   $0x0
    1681:	52                   	push   %edx
    1682:	50                   	push   %eax
    1683:	6a 00                	push   $0x0
    1685:	6a 00                	push   $0x0
    1687:	56                   	push   %esi
    1688:	6a 00                	push   $0x0
    168a:	6a 00                	push   $0x0
    168c:	ff 75 08             	pushl  0x8(%ebp)
    168f:	e8 c8 ec ff ff       	call   35c <paintWindow>
    1694:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1697:	8b 45 08             	mov    0x8(%ebp),%eax
    169a:	8b 70 1c             	mov    0x1c(%eax),%esi
    169d:	8b 45 08             	mov    0x8(%ebp),%eax
    16a0:	8b 58 18             	mov    0x18(%eax),%ebx
    16a3:	8b 45 08             	mov    0x8(%ebp),%eax
    16a6:	8b 48 08             	mov    0x8(%eax),%ecx
    16a9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ac:	8b 50 40             	mov    0x40(%eax),%edx
    16af:	8b 45 08             	mov    0x8(%ebp),%eax
    16b2:	8b 40 3c             	mov    0x3c(%eax),%eax
    16b5:	8b 7d 08             	mov    0x8(%ebp),%edi
    16b8:	83 c7 3c             	add    $0x3c,%edi
    16bb:	83 ec 04             	sub    $0x4,%esp
    16be:	56                   	push   %esi
    16bf:	53                   	push   %ebx
    16c0:	51                   	push   %ecx
    16c1:	52                   	push   %edx
    16c2:	50                   	push   %eax
    16c3:	6a 00                	push   $0x0
    16c5:	6a 00                	push   $0x0
    16c7:	57                   	push   %edi
    16c8:	6a 32                	push   $0x32
    16ca:	6a 00                	push   $0x0
    16cc:	ff 75 08             	pushl  0x8(%ebp)
    16cf:	e8 88 ec ff ff       	call   35c <paintWindow>
    16d4:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    16d7:	90                   	nop
        default: break;
            
            
    }
    return False;
    16d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16e0:	5b                   	pop    %ebx
    16e1:	5e                   	pop    %esi
    16e2:	5f                   	pop    %edi
    16e3:	5d                   	pop    %ebp
    16e4:	c3                   	ret    

000016e5 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    16e5:	55                   	push   %ebp
    16e6:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    16e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    16eb:	8b 50 08             	mov    0x8(%eax),%edx
    16ee:	8b 45 08             	mov    0x8(%ebp),%eax
    16f1:	8b 00                	mov    (%eax),%eax
    16f3:	39 c2                	cmp    %eax,%edx
    16f5:	74 07                	je     16fe <APPreJudge+0x19>
        return False;
    16f7:	b8 00 00 00 00       	mov    $0x0,%eax
    16fc:	eb 05                	jmp    1703 <APPreJudge+0x1e>
    return True;
    16fe:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1703:	5d                   	pop    %ebp
    1704:	c3                   	ret    

00001705 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1705:	55                   	push   %ebp
    1706:	89 e5                	mov    %esp,%ebp
    1708:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    170b:	8b 45 08             	mov    0x8(%ebp),%eax
    170e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1711:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1717:	83 ec 0c             	sub    $0xc,%esp
    171a:	ff 75 08             	pushl  0x8(%ebp)
    171d:	e8 52 ec ff ff       	call   374 <registWindow>
    1722:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1725:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    172c:	8b 45 08             	mov    0x8(%ebp),%eax
    172f:	8b 00                	mov    (%eax),%eax
    1731:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1734:	ff 75 f4             	pushl  -0xc(%ebp)
    1737:	ff 75 f0             	pushl  -0x10(%ebp)
    173a:	ff 75 ec             	pushl  -0x14(%ebp)
    173d:	ff 75 08             	pushl  0x8(%ebp)
    1740:	e8 80 fc ff ff       	call   13c5 <APSendMessage>
    1745:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1748:	83 ec 0c             	sub    $0xc,%esp
    174b:	ff 75 08             	pushl  0x8(%ebp)
    174e:	e8 19 ec ff ff       	call   36c <getMessage>
    1753:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1756:	8b 45 08             	mov    0x8(%ebp),%eax
    1759:	83 c0 74             	add    $0x74,%eax
    175c:	83 ec 08             	sub    $0x8,%esp
    175f:	50                   	push   %eax
    1760:	ff 75 08             	pushl  0x8(%ebp)
    1763:	e8 7d ff ff ff       	call   16e5 <APPreJudge>
    1768:	83 c4 10             	add    $0x10,%esp
    176b:	84 c0                	test   %al,%al
    176d:	74 1b                	je     178a <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    176f:	8b 45 08             	mov    0x8(%ebp),%eax
    1772:	ff 70 7c             	pushl  0x7c(%eax)
    1775:	ff 70 78             	pushl  0x78(%eax)
    1778:	ff 70 74             	pushl  0x74(%eax)
    177b:	ff 75 08             	pushl  0x8(%ebp)
    177e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1781:	ff d0                	call   *%eax
    1783:	83 c4 10             	add    $0x10,%esp
    1786:	84 c0                	test   %al,%al
    1788:	75 0c                	jne    1796 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    178a:	8b 45 08             	mov    0x8(%ebp),%eax
    178d:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1794:	eb b2                	jmp    1748 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1796:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1797:	90                   	nop
    1798:	c9                   	leave  
    1799:	c3                   	ret    

0000179a <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    179a:	55                   	push   %ebp
    179b:	89 e5                	mov    %esp,%ebp
    179d:	57                   	push   %edi
    179e:	56                   	push   %esi
    179f:	53                   	push   %ebx
    17a0:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17a3:	a1 30 29 00 00       	mov    0x2930,%eax
    17a8:	85 c0                	test   %eax,%eax
    17aa:	0f 85 2c 02 00 00    	jne    19dc <APGridPaint+0x242>
    {
        iconReady = 1;
    17b0:	c7 05 30 29 00 00 01 	movl   $0x1,0x2930
    17b7:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17ba:	8d 45 98             	lea    -0x68(%ebp),%eax
    17bd:	83 ec 08             	sub    $0x8,%esp
    17c0:	68 cf 22 00 00       	push   $0x22cf
    17c5:	50                   	push   %eax
    17c6:	e8 16 f1 ff ff       	call   8e1 <APLoadBitmap>
    17cb:	83 c4 0c             	add    $0xc,%esp
    17ce:	8b 45 98             	mov    -0x68(%ebp),%eax
    17d1:	a3 54 29 00 00       	mov    %eax,0x2954
    17d6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    17d9:	a3 58 29 00 00       	mov    %eax,0x2958
    17de:	8b 45 a0             	mov    -0x60(%ebp),%eax
    17e1:	a3 5c 29 00 00       	mov    %eax,0x295c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    17e6:	83 ec 04             	sub    $0x4,%esp
    17e9:	ff 35 5c 29 00 00    	pushl  0x295c
    17ef:	ff 35 58 29 00 00    	pushl  0x2958
    17f5:	ff 35 54 29 00 00    	pushl  0x2954
    17fb:	e8 1b f3 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    1800:	83 c4 10             	add    $0x10,%esp
    1803:	a3 60 29 00 00       	mov    %eax,0x2960
        grid_river = APLoadBitmap ("grid_river.bmp");
    1808:	8d 45 98             	lea    -0x68(%ebp),%eax
    180b:	83 ec 08             	sub    $0x8,%esp
    180e:	68 dd 22 00 00       	push   $0x22dd
    1813:	50                   	push   %eax
    1814:	e8 c8 f0 ff ff       	call   8e1 <APLoadBitmap>
    1819:	83 c4 0c             	add    $0xc,%esp
    181c:	8b 45 98             	mov    -0x68(%ebp),%eax
    181f:	a3 90 29 00 00       	mov    %eax,0x2990
    1824:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1827:	a3 94 29 00 00       	mov    %eax,0x2994
    182c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    182f:	a3 98 29 00 00       	mov    %eax,0x2998
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1834:	83 ec 04             	sub    $0x4,%esp
    1837:	ff 35 98 29 00 00    	pushl  0x2998
    183d:	ff 35 94 29 00 00    	pushl  0x2994
    1843:	ff 35 90 29 00 00    	pushl  0x2990
    1849:	e8 cd f2 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    184e:	83 c4 10             	add    $0x10,%esp
    1851:	a3 80 29 00 00       	mov    %eax,0x2980
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1856:	8d 45 98             	lea    -0x68(%ebp),%eax
    1859:	83 ec 08             	sub    $0x8,%esp
    185c:	68 ec 22 00 00       	push   $0x22ec
    1861:	50                   	push   %eax
    1862:	e8 7a f0 ff ff       	call   8e1 <APLoadBitmap>
    1867:	83 c4 0c             	add    $0xc,%esp
    186a:	8b 45 98             	mov    -0x68(%ebp),%eax
    186d:	a3 84 29 00 00       	mov    %eax,0x2984
    1872:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1875:	a3 88 29 00 00       	mov    %eax,0x2988
    187a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    187d:	a3 8c 29 00 00       	mov    %eax,0x298c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1882:	83 ec 04             	sub    $0x4,%esp
    1885:	ff 35 8c 29 00 00    	pushl  0x298c
    188b:	ff 35 88 29 00 00    	pushl  0x2988
    1891:	ff 35 84 29 00 00    	pushl  0x2984
    1897:	e8 7f f2 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    189c:	83 c4 10             	add    $0x10,%esp
    189f:	a3 34 29 00 00       	mov    %eax,0x2934
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18a4:	8d 45 98             	lea    -0x68(%ebp),%eax
    18a7:	83 ec 08             	sub    $0x8,%esp
    18aa:	68 fb 22 00 00       	push   $0x22fb
    18af:	50                   	push   %eax
    18b0:	e8 2c f0 ff ff       	call   8e1 <APLoadBitmap>
    18b5:	83 c4 0c             	add    $0xc,%esp
    18b8:	8b 45 98             	mov    -0x68(%ebp),%eax
    18bb:	a3 68 29 00 00       	mov    %eax,0x2968
    18c0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18c3:	a3 6c 29 00 00       	mov    %eax,0x296c
    18c8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18cb:	a3 70 29 00 00       	mov    %eax,0x2970
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    18d0:	83 ec 04             	sub    $0x4,%esp
    18d3:	ff 35 70 29 00 00    	pushl  0x2970
    18d9:	ff 35 6c 29 00 00    	pushl  0x296c
    18df:	ff 35 68 29 00 00    	pushl  0x2968
    18e5:	e8 31 f2 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    18ea:	83 c4 10             	add    $0x10,%esp
    18ed:	a3 9c 29 00 00       	mov    %eax,0x299c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    18f2:	8d 45 98             	lea    -0x68(%ebp),%eax
    18f5:	83 ec 08             	sub    $0x8,%esp
    18f8:	68 09 23 00 00       	push   $0x2309
    18fd:	50                   	push   %eax
    18fe:	e8 de ef ff ff       	call   8e1 <APLoadBitmap>
    1903:	83 c4 0c             	add    $0xc,%esp
    1906:	8b 45 98             	mov    -0x68(%ebp),%eax
    1909:	a3 44 29 00 00       	mov    %eax,0x2944
    190e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1911:	a3 48 29 00 00       	mov    %eax,0x2948
    1916:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1919:	a3 4c 29 00 00       	mov    %eax,0x294c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    191e:	83 ec 04             	sub    $0x4,%esp
    1921:	ff 35 4c 29 00 00    	pushl  0x294c
    1927:	ff 35 48 29 00 00    	pushl  0x2948
    192d:	ff 35 44 29 00 00    	pushl  0x2944
    1933:	e8 e3 f1 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    1938:	83 c4 10             	add    $0x10,%esp
    193b:	a3 64 29 00 00       	mov    %eax,0x2964
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1940:	8d 45 98             	lea    -0x68(%ebp),%eax
    1943:	83 ec 08             	sub    $0x8,%esp
    1946:	68 19 23 00 00       	push   $0x2319
    194b:	50                   	push   %eax
    194c:	e8 90 ef ff ff       	call   8e1 <APLoadBitmap>
    1951:	83 c4 0c             	add    $0xc,%esp
    1954:	8b 45 98             	mov    -0x68(%ebp),%eax
    1957:	a3 38 29 00 00       	mov    %eax,0x2938
    195c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    195f:	a3 3c 29 00 00       	mov    %eax,0x293c
    1964:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1967:	a3 40 29 00 00       	mov    %eax,0x2940
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    196c:	83 ec 04             	sub    $0x4,%esp
    196f:	ff 35 40 29 00 00    	pushl  0x2940
    1975:	ff 35 3c 29 00 00    	pushl  0x293c
    197b:	ff 35 38 29 00 00    	pushl  0x2938
    1981:	e8 95 f1 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    1986:	83 c4 10             	add    $0x10,%esp
    1989:	a3 50 29 00 00       	mov    %eax,0x2950
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    198e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1991:	83 ec 08             	sub    $0x8,%esp
    1994:	68 2b 23 00 00       	push   $0x232b
    1999:	50                   	push   %eax
    199a:	e8 42 ef ff ff       	call   8e1 <APLoadBitmap>
    199f:	83 c4 0c             	add    $0xc,%esp
    19a2:	8b 45 98             	mov    -0x68(%ebp),%eax
    19a5:	a3 74 29 00 00       	mov    %eax,0x2974
    19aa:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19ad:	a3 78 29 00 00       	mov    %eax,0x2978
    19b2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19b5:	a3 7c 29 00 00       	mov    %eax,0x297c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19ba:	83 ec 04             	sub    $0x4,%esp
    19bd:	ff 35 7c 29 00 00    	pushl  0x297c
    19c3:	ff 35 78 29 00 00    	pushl  0x2978
    19c9:	ff 35 74 29 00 00    	pushl  0x2974
    19cf:	e8 47 f1 ff ff       	call   b1b <APCreateCompatibleDCFromBitmap>
    19d4:	83 c4 10             	add    $0x10,%esp
    19d7:	a3 a0 29 00 00       	mov    %eax,0x29a0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    19dc:	8b 45 08             	mov    0x8(%ebp),%eax
    19df:	8b 40 08             	mov    0x8(%eax),%eax
    19e2:	85 c0                	test   %eax,%eax
    19e4:	75 17                	jne    19fd <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    19e6:	83 ec 08             	sub    $0x8,%esp
    19e9:	68 3c 23 00 00       	push   $0x233c
    19ee:	6a 01                	push   $0x1
    19f0:	e8 66 ea ff ff       	call   45b <printf>
    19f5:	83 c4 10             	add    $0x10,%esp
        return;
    19f8:	e9 a0 04 00 00       	jmp    1e9d <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    19fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1a00:	8b 40 10             	mov    0x10(%eax),%eax
    1a03:	85 c0                	test   %eax,%eax
    1a05:	7e 10                	jle    1a17 <APGridPaint+0x27d>
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	8b 50 14             	mov    0x14(%eax),%edx
    1a0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a10:	8b 40 10             	mov    0x10(%eax),%eax
    1a13:	39 c2                	cmp    %eax,%edx
    1a15:	7c 17                	jl     1a2e <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a17:	83 ec 08             	sub    $0x8,%esp
    1a1a:	68 62 23 00 00       	push   $0x2362
    1a1f:	6a 01                	push   $0x1
    1a21:	e8 35 ea ff ff       	call   45b <printf>
    1a26:	83 c4 10             	add    $0x10,%esp
        return;
    1a29:	e9 6f 04 00 00       	jmp    1e9d <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a31:	8b 40 14             	mov    0x14(%eax),%eax
    1a34:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a3a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a3d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a40:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a43:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a4a:	e9 96 03 00 00       	jmp    1de5 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a4f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a56:	e9 7c 03 00 00       	jmp    1dd7 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a5e:	c1 e0 04             	shl    $0x4,%eax
    1a61:	89 c2                	mov    %eax,%edx
    1a63:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1a66:	01 c2                	add    %eax,%edx
    1a68:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a6b:	01 d0                	add    %edx,%eax
    1a6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1a70:	8b 45 08             	mov    0x8(%ebp),%eax
    1a73:	8b 40 0c             	mov    0xc(%eax),%eax
    1a76:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1a79:	c1 e2 02             	shl    $0x2,%edx
    1a7c:	01 d0                	add    %edx,%eax
    1a7e:	8b 00                	mov    (%eax),%eax
    1a80:	83 f8 07             	cmp    $0x7,%eax
    1a83:	0f 87 49 03 00 00    	ja     1dd2 <APGridPaint+0x638>
    1a89:	8b 04 85 78 23 00 00 	mov    0x2378(,%eax,4),%eax
    1a90:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1a92:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1a95:	6a 0c                	push   $0xc
    1a97:	6a 0c                	push   $0xc
    1a99:	6a 0c                	push   $0xc
    1a9b:	50                   	push   %eax
    1a9c:	e8 df f8 ff ff       	call   1380 <RGB>
    1aa1:	83 c4 0c             	add    $0xc,%esp
    1aa4:	8b 1d 60 29 00 00    	mov    0x2960,%ebx
    1aaa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1aad:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ab0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ab3:	6b c0 32             	imul   $0x32,%eax,%eax
    1ab6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ab9:	8b 45 08             	mov    0x8(%ebp),%eax
    1abc:	8d 78 3c             	lea    0x3c(%eax),%edi
    1abf:	83 ec 0c             	sub    $0xc,%esp
    1ac2:	83 ec 04             	sub    $0x4,%esp
    1ac5:	89 e0                	mov    %esp,%eax
    1ac7:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1acb:	66 89 30             	mov    %si,(%eax)
    1ace:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1ad2:	88 50 02             	mov    %dl,0x2(%eax)
    1ad5:	6a 32                	push   $0x32
    1ad7:	6a 32                	push   $0x32
    1ad9:	6a 00                	push   $0x0
    1adb:	6a 00                	push   $0x0
    1add:	53                   	push   %ebx
    1ade:	51                   	push   %ecx
    1adf:	ff 75 94             	pushl  -0x6c(%ebp)
    1ae2:	57                   	push   %edi
    1ae3:	e8 f4 f6 ff ff       	call   11dc <APDcCopy>
    1ae8:	83 c4 30             	add    $0x30,%esp
                    break;
    1aeb:	e9 e3 02 00 00       	jmp    1dd3 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1af0:	8d 45 98             	lea    -0x68(%ebp),%eax
    1af3:	6a 69                	push   $0x69
    1af5:	6a 69                	push   $0x69
    1af7:	6a 69                	push   $0x69
    1af9:	50                   	push   %eax
    1afa:	e8 81 f8 ff ff       	call   1380 <RGB>
    1aff:	83 c4 0c             	add    $0xc,%esp
    1b02:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b06:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1b0a:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b0e:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1b11:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b18:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b1b:	6a 69                	push   $0x69
    1b1d:	6a 69                	push   $0x69
    1b1f:	6a 69                	push   $0x69
    1b21:	50                   	push   %eax
    1b22:	e8 59 f8 ff ff       	call   1380 <RGB>
    1b27:	83 c4 0c             	add    $0xc,%esp
    1b2a:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b2e:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1b32:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b36:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b39:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3c:	8d 50 3c             	lea    0x3c(%eax),%edx
    1b3f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b42:	ff 75 b0             	pushl  -0x50(%ebp)
    1b45:	ff 75 ac             	pushl  -0x54(%ebp)
    1b48:	52                   	push   %edx
    1b49:	50                   	push   %eax
    1b4a:	e8 61 f0 ff ff       	call   bb0 <APSetPen>
    1b4f:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b52:	8b 45 08             	mov    0x8(%ebp),%eax
    1b55:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1b58:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b5b:	83 ec 04             	sub    $0x4,%esp
    1b5e:	83 ec 04             	sub    $0x4,%esp
    1b61:	89 e0                	mov    %esp,%eax
    1b63:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1b67:	66 89 08             	mov    %cx,(%eax)
    1b6a:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1b6e:	88 48 02             	mov    %cl,0x2(%eax)
    1b71:	53                   	push   %ebx
    1b72:	52                   	push   %edx
    1b73:	e8 71 f0 ff ff       	call   be9 <APSetBrush>
    1b78:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b7e:	6b d0 32             	imul   $0x32,%eax,%edx
    1b81:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b84:	6b c0 32             	imul   $0x32,%eax,%eax
    1b87:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b8a:	83 c1 3c             	add    $0x3c,%ecx
    1b8d:	83 ec 0c             	sub    $0xc,%esp
    1b90:	6a 32                	push   $0x32
    1b92:	6a 32                	push   $0x32
    1b94:	52                   	push   %edx
    1b95:	50                   	push   %eax
    1b96:	51                   	push   %ecx
    1b97:	e8 35 f4 ff ff       	call   fd1 <APDrawRect>
    1b9c:	83 c4 20             	add    $0x20,%esp
                    break;
    1b9f:	e9 2f 02 00 00       	jmp    1dd3 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ba4:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1ba7:	6a 0c                	push   $0xc
    1ba9:	6a 0c                	push   $0xc
    1bab:	6a 0c                	push   $0xc
    1bad:	50                   	push   %eax
    1bae:	e8 cd f7 ff ff       	call   1380 <RGB>
    1bb3:	83 c4 0c             	add    $0xc,%esp
    1bb6:	8b 1d a0 29 00 00    	mov    0x29a0,%ebx
    1bbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bbf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bc5:	6b c0 32             	imul   $0x32,%eax,%eax
    1bc8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bce:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bd1:	83 ec 0c             	sub    $0xc,%esp
    1bd4:	83 ec 04             	sub    $0x4,%esp
    1bd7:	89 e0                	mov    %esp,%eax
    1bd9:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1bdd:	66 89 30             	mov    %si,(%eax)
    1be0:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1be4:	88 50 02             	mov    %dl,0x2(%eax)
    1be7:	6a 32                	push   $0x32
    1be9:	6a 32                	push   $0x32
    1beb:	6a 00                	push   $0x0
    1bed:	6a 00                	push   $0x0
    1bef:	53                   	push   %ebx
    1bf0:	51                   	push   %ecx
    1bf1:	ff 75 94             	pushl  -0x6c(%ebp)
    1bf4:	57                   	push   %edi
    1bf5:	e8 e2 f5 ff ff       	call   11dc <APDcCopy>
    1bfa:	83 c4 30             	add    $0x30,%esp
                    break;
    1bfd:	e9 d1 01 00 00       	jmp    1dd3 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c02:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c05:	6a 0c                	push   $0xc
    1c07:	6a 0c                	push   $0xc
    1c09:	6a 0c                	push   $0xc
    1c0b:	50                   	push   %eax
    1c0c:	e8 6f f7 ff ff       	call   1380 <RGB>
    1c11:	83 c4 0c             	add    $0xc,%esp
    1c14:	8b 1d 80 29 00 00    	mov    0x2980,%ebx
    1c1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c1d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c20:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c23:	6b c0 32             	imul   $0x32,%eax,%eax
    1c26:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c29:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c2f:	83 ec 0c             	sub    $0xc,%esp
    1c32:	83 ec 04             	sub    $0x4,%esp
    1c35:	89 e0                	mov    %esp,%eax
    1c37:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c3b:	66 89 30             	mov    %si,(%eax)
    1c3e:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c42:	88 50 02             	mov    %dl,0x2(%eax)
    1c45:	6a 32                	push   $0x32
    1c47:	6a 32                	push   $0x32
    1c49:	6a 00                	push   $0x0
    1c4b:	6a 00                	push   $0x0
    1c4d:	53                   	push   %ebx
    1c4e:	51                   	push   %ecx
    1c4f:	ff 75 94             	pushl  -0x6c(%ebp)
    1c52:	57                   	push   %edi
    1c53:	e8 84 f5 ff ff       	call   11dc <APDcCopy>
    1c58:	83 c4 30             	add    $0x30,%esp
                    break;
    1c5b:	e9 73 01 00 00       	jmp    1dd3 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c60:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1c63:	6a 0c                	push   $0xc
    1c65:	6a 0c                	push   $0xc
    1c67:	6a 0c                	push   $0xc
    1c69:	50                   	push   %eax
    1c6a:	e8 11 f7 ff ff       	call   1380 <RGB>
    1c6f:	83 c4 0c             	add    $0xc,%esp
    1c72:	8b 1d 64 29 00 00    	mov    0x2964,%ebx
    1c78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c7b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c81:	6b c0 32             	imul   $0x32,%eax,%eax
    1c84:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c87:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c8d:	83 ec 0c             	sub    $0xc,%esp
    1c90:	83 ec 04             	sub    $0x4,%esp
    1c93:	89 e0                	mov    %esp,%eax
    1c95:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1c99:	66 89 30             	mov    %si,(%eax)
    1c9c:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ca0:	88 50 02             	mov    %dl,0x2(%eax)
    1ca3:	6a 32                	push   $0x32
    1ca5:	6a 32                	push   $0x32
    1ca7:	6a 00                	push   $0x0
    1ca9:	6a 00                	push   $0x0
    1cab:	53                   	push   %ebx
    1cac:	51                   	push   %ecx
    1cad:	ff 75 94             	pushl  -0x6c(%ebp)
    1cb0:	57                   	push   %edi
    1cb1:	e8 26 f5 ff ff       	call   11dc <APDcCopy>
    1cb6:	83 c4 30             	add    $0x30,%esp
                    break;
    1cb9:	e9 15 01 00 00       	jmp    1dd3 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cbe:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cc1:	6a 0c                	push   $0xc
    1cc3:	6a 0c                	push   $0xc
    1cc5:	6a 0c                	push   $0xc
    1cc7:	50                   	push   %eax
    1cc8:	e8 b3 f6 ff ff       	call   1380 <RGB>
    1ccd:	83 c4 0c             	add    $0xc,%esp
    1cd0:	8b 1d 9c 29 00 00    	mov    0x299c,%ebx
    1cd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cdc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cdf:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ce5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce8:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ceb:	83 ec 0c             	sub    $0xc,%esp
    1cee:	83 ec 04             	sub    $0x4,%esp
    1cf1:	89 e0                	mov    %esp,%eax
    1cf3:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1cf7:	66 89 30             	mov    %si,(%eax)
    1cfa:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1cfe:	88 50 02             	mov    %dl,0x2(%eax)
    1d01:	6a 32                	push   $0x32
    1d03:	6a 32                	push   $0x32
    1d05:	6a 00                	push   $0x0
    1d07:	6a 00                	push   $0x0
    1d09:	53                   	push   %ebx
    1d0a:	51                   	push   %ecx
    1d0b:	ff 75 94             	pushl  -0x6c(%ebp)
    1d0e:	57                   	push   %edi
    1d0f:	e8 c8 f4 ff ff       	call   11dc <APDcCopy>
    1d14:	83 c4 30             	add    $0x30,%esp
                    break;
    1d17:	e9 b7 00 00 00       	jmp    1dd3 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d1c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d1f:	6a 0c                	push   $0xc
    1d21:	6a 0c                	push   $0xc
    1d23:	6a 0c                	push   $0xc
    1d25:	50                   	push   %eax
    1d26:	e8 55 f6 ff ff       	call   1380 <RGB>
    1d2b:	83 c4 0c             	add    $0xc,%esp
    1d2e:	8b 1d 34 29 00 00    	mov    0x2934,%ebx
    1d34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d37:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d3d:	6b c0 32             	imul   $0x32,%eax,%eax
    1d40:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d43:	8b 45 08             	mov    0x8(%ebp),%eax
    1d46:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d49:	83 ec 0c             	sub    $0xc,%esp
    1d4c:	83 ec 04             	sub    $0x4,%esp
    1d4f:	89 e0                	mov    %esp,%eax
    1d51:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d55:	66 89 30             	mov    %si,(%eax)
    1d58:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d5c:	88 50 02             	mov    %dl,0x2(%eax)
    1d5f:	6a 32                	push   $0x32
    1d61:	6a 32                	push   $0x32
    1d63:	6a 00                	push   $0x0
    1d65:	6a 00                	push   $0x0
    1d67:	53                   	push   %ebx
    1d68:	51                   	push   %ecx
    1d69:	ff 75 94             	pushl  -0x6c(%ebp)
    1d6c:	57                   	push   %edi
    1d6d:	e8 6a f4 ff ff       	call   11dc <APDcCopy>
    1d72:	83 c4 30             	add    $0x30,%esp
                    break;
    1d75:	eb 5c                	jmp    1dd3 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d77:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1d7a:	6a 0c                	push   $0xc
    1d7c:	6a 0c                	push   $0xc
    1d7e:	6a 0c                	push   $0xc
    1d80:	50                   	push   %eax
    1d81:	e8 fa f5 ff ff       	call   1380 <RGB>
    1d86:	83 c4 0c             	add    $0xc,%esp
    1d89:	8b 1d 50 29 00 00    	mov    0x2950,%ebx
    1d8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d92:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d95:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d98:	6b c0 32             	imul   $0x32,%eax,%eax
    1d9b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1da1:	8d 78 3c             	lea    0x3c(%eax),%edi
    1da4:	83 ec 0c             	sub    $0xc,%esp
    1da7:	83 ec 04             	sub    $0x4,%esp
    1daa:	89 e0                	mov    %esp,%eax
    1dac:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1db0:	66 89 30             	mov    %si,(%eax)
    1db3:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1db7:	88 50 02             	mov    %dl,0x2(%eax)
    1dba:	6a 32                	push   $0x32
    1dbc:	6a 32                	push   $0x32
    1dbe:	6a 00                	push   $0x0
    1dc0:	6a 00                	push   $0x0
    1dc2:	53                   	push   %ebx
    1dc3:	51                   	push   %ecx
    1dc4:	ff 75 94             	pushl  -0x6c(%ebp)
    1dc7:	57                   	push   %edi
    1dc8:	e8 0f f4 ff ff       	call   11dc <APDcCopy>
    1dcd:	83 c4 30             	add    $0x30,%esp
                    break;
    1dd0:	eb 01                	jmp    1dd3 <APGridPaint+0x639>
                default: break;
    1dd2:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1dd3:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1dd7:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1ddb:	0f 8e 7a fc ff ff    	jle    1a5b <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1de1:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1de5:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1de9:	0f 8e 60 fc ff ff    	jle    1a4f <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1def:	8d 45 98             	lea    -0x68(%ebp),%eax
    1df2:	68 cd 00 00 00       	push   $0xcd
    1df7:	6a 74                	push   $0x74
    1df9:	6a 18                	push   $0x18
    1dfb:	50                   	push   %eax
    1dfc:	e8 7f f5 ff ff       	call   1380 <RGB>
    1e01:	83 c4 0c             	add    $0xc,%esp
    1e04:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e08:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1e0c:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e10:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1e13:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1e1a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e1d:	68 cd 00 00 00       	push   $0xcd
    1e22:	6a 74                	push   $0x74
    1e24:	6a 18                	push   $0x18
    1e26:	50                   	push   %eax
    1e27:	e8 54 f5 ff ff       	call   1380 <RGB>
    1e2c:	83 c4 0c             	add    $0xc,%esp
    1e2f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e33:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1e37:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e3b:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1e3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e41:	8d 50 58             	lea    0x58(%eax),%edx
    1e44:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e47:	ff 75 bc             	pushl  -0x44(%ebp)
    1e4a:	ff 75 b8             	pushl  -0x48(%ebp)
    1e4d:	52                   	push   %edx
    1e4e:	50                   	push   %eax
    1e4f:	e8 5c ed ff ff       	call   bb0 <APSetPen>
    1e54:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1e57:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5a:	8d 58 58             	lea    0x58(%eax),%ebx
    1e5d:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e60:	83 ec 04             	sub    $0x4,%esp
    1e63:	83 ec 04             	sub    $0x4,%esp
    1e66:	89 e0                	mov    %esp,%eax
    1e68:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e6c:	66 89 08             	mov    %cx,(%eax)
    1e6f:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e73:	88 48 02             	mov    %cl,0x2(%eax)
    1e76:	53                   	push   %ebx
    1e77:	52                   	push   %edx
    1e78:	e8 6c ed ff ff       	call   be9 <APSetBrush>
    1e7d:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1e80:	8b 45 08             	mov    0x8(%ebp),%eax
    1e83:	83 c0 58             	add    $0x58,%eax
    1e86:	83 ec 0c             	sub    $0xc,%esp
    1e89:	6a 32                	push   $0x32
    1e8b:	68 20 03 00 00       	push   $0x320
    1e90:	6a 00                	push   $0x0
    1e92:	6a 00                	push   $0x0
    1e94:	50                   	push   %eax
    1e95:	e8 37 f1 ff ff       	call   fd1 <APDrawRect>
    1e9a:	83 c4 20             	add    $0x20,%esp
}
    1e9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ea0:	5b                   	pop    %ebx
    1ea1:	5e                   	pop    %esi
    1ea2:	5f                   	pop    %edi
    1ea3:	5d                   	pop    %ebp
    1ea4:	c3                   	ret    

00001ea5 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1ea5:	55                   	push   %ebp
    1ea6:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1ea8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1eac:	7e 08                	jle    1eb6 <random+0x11>
{
rand_num = seed;
    1eae:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb1:	a3 0c 29 00 00       	mov    %eax,0x290c
}
rand_num *= 3;
    1eb6:	8b 15 0c 29 00 00    	mov    0x290c,%edx
    1ebc:	89 d0                	mov    %edx,%eax
    1ebe:	01 c0                	add    %eax,%eax
    1ec0:	01 d0                	add    %edx,%eax
    1ec2:	a3 0c 29 00 00       	mov    %eax,0x290c
if (rand_num < 0)
    1ec7:	a1 0c 29 00 00       	mov    0x290c,%eax
    1ecc:	85 c0                	test   %eax,%eax
    1ece:	79 0c                	jns    1edc <random+0x37>
{
rand_num *= (-1);
    1ed0:	a1 0c 29 00 00       	mov    0x290c,%eax
    1ed5:	f7 d8                	neg    %eax
    1ed7:	a3 0c 29 00 00       	mov    %eax,0x290c
}
return rand_num % 997;
    1edc:	8b 0d 0c 29 00 00    	mov    0x290c,%ecx
    1ee2:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1ee7:	89 c8                	mov    %ecx,%eax
    1ee9:	f7 ea                	imul   %edx
    1eeb:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1eee:	c1 f8 09             	sar    $0x9,%eax
    1ef1:	89 c2                	mov    %eax,%edx
    1ef3:	89 c8                	mov    %ecx,%eax
    1ef5:	c1 f8 1f             	sar    $0x1f,%eax
    1ef8:	29 c2                	sub    %eax,%edx
    1efa:	89 d0                	mov    %edx,%eax
    1efc:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1f02:	29 c1                	sub    %eax,%ecx
    1f04:	89 c8                	mov    %ecx,%eax
}
    1f06:	5d                   	pop    %ebp
    1f07:	c3                   	ret    

00001f08 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1f08:	55                   	push   %ebp
    1f09:	89 e5                	mov    %esp,%ebp
    1f0b:	53                   	push   %ebx
    1f0c:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1f0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1f16:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1f1a:	74 17                	je     1f33 <sprintint+0x2b>
    1f1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1f20:	79 11                	jns    1f33 <sprintint+0x2b>
        neg = 1;
    1f22:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f29:	8b 45 10             	mov    0x10(%ebp),%eax
    1f2c:	f7 d8                	neg    %eax
    1f2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f31:	eb 06                	jmp    1f39 <sprintint+0x31>
    } else {
        x = xx;
    1f33:	8b 45 10             	mov    0x10(%ebp),%eax
    1f36:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f39:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f40:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f43:	8d 41 01             	lea    0x1(%ecx),%eax
    1f46:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f49:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f4f:	ba 00 00 00 00       	mov    $0x0,%edx
    1f54:	f7 f3                	div    %ebx
    1f56:	89 d0                	mov    %edx,%eax
    1f58:	0f b6 80 10 29 00 00 	movzbl 0x2910(%eax),%eax
    1f5f:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f63:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f66:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f69:	ba 00 00 00 00       	mov    $0x0,%edx
    1f6e:	f7 f3                	div    %ebx
    1f70:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f77:	75 c7                	jne    1f40 <sprintint+0x38>
    if(neg)
    1f79:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f7d:	74 0e                	je     1f8d <sprintint+0x85>
        buf[i++] = '-';
    1f7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f82:	8d 50 01             	lea    0x1(%eax),%edx
    1f85:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f88:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f90:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f93:	eb 1b                	jmp    1fb0 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f95:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f98:	8b 00                	mov    (%eax),%eax
    1f9a:	8d 48 01             	lea    0x1(%eax),%ecx
    1f9d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fa0:	89 0a                	mov    %ecx,(%edx)
    1fa2:	89 c2                	mov    %eax,%edx
    1fa4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa7:	01 d0                	add    %edx,%eax
    1fa9:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1fac:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1fb0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1fb4:	7f df                	jg     1f95 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fb6:	eb 21                	jmp    1fd9 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
    1fbb:	8b 00                	mov    (%eax),%eax
    1fbd:	8d 48 01             	lea    0x1(%eax),%ecx
    1fc0:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fc3:	89 0a                	mov    %ecx,(%edx)
    1fc5:	89 c2                	mov    %eax,%edx
    1fc7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fca:	01 c2                	add    %eax,%edx
    1fcc:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fd2:	01 c8                	add    %ecx,%eax
    1fd4:	0f b6 00             	movzbl (%eax),%eax
    1fd7:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fd9:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fdd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1fe1:	79 d5                	jns    1fb8 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1fe3:	90                   	nop
    1fe4:	83 c4 20             	add    $0x20,%esp
    1fe7:	5b                   	pop    %ebx
    1fe8:	5d                   	pop    %ebp
    1fe9:	c3                   	ret    

00001fea <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1fea:	55                   	push   %ebp
    1feb:	89 e5                	mov    %esp,%ebp
    1fed:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1ff0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1ff7:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1ffe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2005:	8d 45 0c             	lea    0xc(%ebp),%eax
    2008:	83 c0 04             	add    $0x4,%eax
    200b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    200e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2015:	e9 d9 01 00 00       	jmp    21f3 <sprintf+0x209>
        c = fmt[i] & 0xff;
    201a:	8b 55 0c             	mov    0xc(%ebp),%edx
    201d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2020:	01 d0                	add    %edx,%eax
    2022:	0f b6 00             	movzbl (%eax),%eax
    2025:	0f be c0             	movsbl %al,%eax
    2028:	25 ff 00 00 00       	and    $0xff,%eax
    202d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2030:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2034:	75 2c                	jne    2062 <sprintf+0x78>
            if(c == '%'){
    2036:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    203a:	75 0c                	jne    2048 <sprintf+0x5e>
                state = '%';
    203c:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2043:	e9 a7 01 00 00       	jmp    21ef <sprintf+0x205>
            } else {
                dst[j++] = c;
    2048:	8b 45 c8             	mov    -0x38(%ebp),%eax
    204b:	8d 50 01             	lea    0x1(%eax),%edx
    204e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2051:	89 c2                	mov    %eax,%edx
    2053:	8b 45 08             	mov    0x8(%ebp),%eax
    2056:	01 d0                	add    %edx,%eax
    2058:	8b 55 e0             	mov    -0x20(%ebp),%edx
    205b:	88 10                	mov    %dl,(%eax)
    205d:	e9 8d 01 00 00       	jmp    21ef <sprintf+0x205>
            }
        } else if(state == '%'){
    2062:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2066:	0f 85 83 01 00 00    	jne    21ef <sprintf+0x205>
            if(c == 'd'){
    206c:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2070:	75 4c                	jne    20be <sprintf+0xd4>
                buf[bi] = '\0';
    2072:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2075:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2078:	01 d0                	add    %edx,%eax
    207a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    207d:	83 ec 0c             	sub    $0xc,%esp
    2080:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2083:	50                   	push   %eax
    2084:	e8 a1 e1 ff ff       	call   22a <atoi>
    2089:	83 c4 10             	add    $0x10,%esp
    208c:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    208f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2096:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2099:	8b 00                	mov    (%eax),%eax
    209b:	83 ec 08             	sub    $0x8,%esp
    209e:	ff 75 d8             	pushl  -0x28(%ebp)
    20a1:	6a 01                	push   $0x1
    20a3:	6a 0a                	push   $0xa
    20a5:	50                   	push   %eax
    20a6:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20a9:	50                   	push   %eax
    20aa:	ff 75 08             	pushl  0x8(%ebp)
    20ad:	e8 56 fe ff ff       	call   1f08 <sprintint>
    20b2:	83 c4 20             	add    $0x20,%esp
                ap++;
    20b5:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20b9:	e9 2a 01 00 00       	jmp    21e8 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    20be:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    20c2:	74 06                	je     20ca <sprintf+0xe0>
    20c4:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20c8:	75 4c                	jne    2116 <sprintf+0x12c>
                buf[bi] = '\0';
    20ca:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20d0:	01 d0                	add    %edx,%eax
    20d2:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20d5:	83 ec 0c             	sub    $0xc,%esp
    20d8:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20db:	50                   	push   %eax
    20dc:	e8 49 e1 ff ff       	call   22a <atoi>
    20e1:	83 c4 10             	add    $0x10,%esp
    20e4:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f1:	8b 00                	mov    (%eax),%eax
    20f3:	83 ec 08             	sub    $0x8,%esp
    20f6:	ff 75 dc             	pushl  -0x24(%ebp)
    20f9:	6a 00                	push   $0x0
    20fb:	6a 10                	push   $0x10
    20fd:	50                   	push   %eax
    20fe:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2101:	50                   	push   %eax
    2102:	ff 75 08             	pushl  0x8(%ebp)
    2105:	e8 fe fd ff ff       	call   1f08 <sprintint>
    210a:	83 c4 20             	add    $0x20,%esp
                ap++;
    210d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2111:	e9 d2 00 00 00       	jmp    21e8 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2116:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    211a:	75 46                	jne    2162 <sprintf+0x178>
                s = (char*)*ap;
    211c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    211f:	8b 00                	mov    (%eax),%eax
    2121:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2124:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2128:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    212c:	75 25                	jne    2153 <sprintf+0x169>
                    s = "(null)";
    212e:	c7 45 f4 98 23 00 00 	movl   $0x2398,-0xc(%ebp)
                while(*s != 0){
    2135:	eb 1c                	jmp    2153 <sprintf+0x169>
                    dst[j++] = *s;
    2137:	8b 45 c8             	mov    -0x38(%ebp),%eax
    213a:	8d 50 01             	lea    0x1(%eax),%edx
    213d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2140:	89 c2                	mov    %eax,%edx
    2142:	8b 45 08             	mov    0x8(%ebp),%eax
    2145:	01 c2                	add    %eax,%edx
    2147:	8b 45 f4             	mov    -0xc(%ebp),%eax
    214a:	0f b6 00             	movzbl (%eax),%eax
    214d:	88 02                	mov    %al,(%edx)
                    s++;
    214f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2153:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2156:	0f b6 00             	movzbl (%eax),%eax
    2159:	84 c0                	test   %al,%al
    215b:	75 da                	jne    2137 <sprintf+0x14d>
    215d:	e9 86 00 00 00       	jmp    21e8 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2162:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2166:	75 1d                	jne    2185 <sprintf+0x19b>
                dst[j++] = *ap;
    2168:	8b 45 c8             	mov    -0x38(%ebp),%eax
    216b:	8d 50 01             	lea    0x1(%eax),%edx
    216e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2171:	89 c2                	mov    %eax,%edx
    2173:	8b 45 08             	mov    0x8(%ebp),%eax
    2176:	01 c2                	add    %eax,%edx
    2178:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    217b:	8b 00                	mov    (%eax),%eax
    217d:	88 02                	mov    %al,(%edx)
                ap++;
    217f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2183:	eb 63                	jmp    21e8 <sprintf+0x1fe>
            } else if(c == '%'){
    2185:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2189:	75 17                	jne    21a2 <sprintf+0x1b8>
                dst[j++] = c;
    218b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    218e:	8d 50 01             	lea    0x1(%eax),%edx
    2191:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2194:	89 c2                	mov    %eax,%edx
    2196:	8b 45 08             	mov    0x8(%ebp),%eax
    2199:	01 d0                	add    %edx,%eax
    219b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    219e:	88 10                	mov    %dl,(%eax)
    21a0:	eb 46                	jmp    21e8 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    21a2:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    21a6:	7e 18                	jle    21c0 <sprintf+0x1d6>
    21a8:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    21ac:	7f 12                	jg     21c0 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    21ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21b1:	8d 50 01             	lea    0x1(%eax),%edx
    21b4:	89 55 f0             	mov    %edx,-0x10(%ebp)
    21b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21ba:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    21be:	eb 2f                	jmp    21ef <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    21c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21c3:	8d 50 01             	lea    0x1(%eax),%edx
    21c6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21c9:	89 c2                	mov    %eax,%edx
    21cb:	8b 45 08             	mov    0x8(%ebp),%eax
    21ce:	01 d0                	add    %edx,%eax
    21d0:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21d3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21d6:	8d 50 01             	lea    0x1(%eax),%edx
    21d9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21dc:	89 c2                	mov    %eax,%edx
    21de:	8b 45 08             	mov    0x8(%ebp),%eax
    21e1:	01 d0                	add    %edx,%eax
    21e3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21e6:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21e8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21ef:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    21f3:	8b 55 0c             	mov    0xc(%ebp),%edx
    21f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21f9:	01 d0                	add    %edx,%eax
    21fb:	0f b6 00             	movzbl (%eax),%eax
    21fe:	84 c0                	test   %al,%al
    2200:	0f 85 14 fe ff ff    	jne    201a <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2206:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2209:	8d 50 01             	lea    0x1(%eax),%edx
    220c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    220f:	89 c2                	mov    %eax,%edx
    2211:	8b 45 08             	mov    0x8(%ebp),%eax
    2214:	01 d0                	add    %edx,%eax
    2216:	c6 00 00             	movb   $0x0,(%eax)
}
    2219:	90                   	nop
    221a:	c9                   	leave  
    221b:	c3                   	ret    
