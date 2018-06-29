
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
      27:	ba d8 23 00 00       	mov    $0x23d8,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba da 23 00 00       	mov    $0x23da,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 dc 23 00 00       	push   $0x23dc
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
     407:	0f b6 80 e0 2a 00 00 	movzbl 0x2ae0(%eax),%eax
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
     545:	c7 45 f4 e1 23 00 00 	movl   $0x23e1,-0xc(%ebp)
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
     60b:	a1 40 67 00 00       	mov    0x6740,%eax
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
     6d6:	a3 40 67 00 00       	mov    %eax,0x6740
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
     737:	a1 40 67 00 00       	mov    0x6740,%eax
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
     753:	a1 40 67 00 00       	mov    0x6740,%eax
     758:	89 45 f0             	mov    %eax,-0x10(%ebp)
     75b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     75f:	75 23                	jne    784 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     761:	c7 45 f0 38 67 00 00 	movl   $0x6738,-0x10(%ebp)
     768:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76b:	a3 40 67 00 00       	mov    %eax,0x6740
     770:	a1 40 67 00 00       	mov    0x6740,%eax
     775:	a3 38 67 00 00       	mov    %eax,0x6738
    base.s.size = 0;
     77a:	c7 05 3c 67 00 00 00 	movl   $0x0,0x673c
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
     7d7:	a3 40 67 00 00       	mov    %eax,0x6740
      return (void*)(p + 1);
     7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7df:	83 c0 08             	add    $0x8,%eax
     7e2:	eb 3b                	jmp    81f <malloc+0xe1>
    }
    if(p == freep)
     7e4:	a1 40 67 00 00       	mov    0x6740,%eax
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
     92a:	68 e8 23 00 00       	push   $0x23e8
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

00000c3b <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     c3b:	55                   	push   %ebp
     c3c:	89 e5                	mov    %esp,%ebp
     c3e:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     c41:	8b 45 0c             	mov    0xc(%ebp),%eax
     c44:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     c48:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     c4c:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     c50:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     c53:	8b 45 0c             	mov    0xc(%ebp),%eax
     c56:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     c5a:	66 89 50 13          	mov    %dx,0x13(%eax)
     c5e:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     c62:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     c65:	8b 45 08             	mov    0x8(%ebp),%eax
     c68:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     c6c:	66 89 10             	mov    %dx,(%eax)
     c6f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     c73:	88 50 02             	mov    %dl,0x2(%eax)
}
     c76:	8b 45 08             	mov    0x8(%ebp),%eax
     c79:	c9                   	leave  
     c7a:	c2 04 00             	ret    $0x4

00000c7d <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     c7d:	55                   	push   %ebp
     c7e:	89 e5                	mov    %esp,%ebp
     c80:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     c83:	8b 45 08             	mov    0x8(%ebp),%eax
     c86:	8b 40 0c             	mov    0xc(%eax),%eax
     c89:	89 c2                	mov    %eax,%edx
     c8b:	c1 ea 1f             	shr    $0x1f,%edx
     c8e:	01 d0                	add    %edx,%eax
     c90:	d1 f8                	sar    %eax
     c92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     c95:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c98:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     c9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     c9f:	8b 45 10             	mov    0x10(%ebp),%eax
     ca2:	2b 45 f4             	sub    -0xc(%ebp),%eax
     ca5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     ca8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     cac:	0f 89 98 00 00 00    	jns    d4a <APDrawPoint+0xcd>
        i = 0;
     cb2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     cb9:	e9 8c 00 00 00       	jmp    d4a <APDrawPoint+0xcd>
    {
        j = x - off;
     cbe:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc1:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cc4:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     cc7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     ccb:	79 69                	jns    d36 <APDrawPoint+0xb9>
            j = 0;
     ccd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     cd4:	eb 60                	jmp    d36 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     cd6:	ff 75 fc             	pushl  -0x4(%ebp)
     cd9:	ff 75 f8             	pushl  -0x8(%ebp)
     cdc:	ff 75 08             	pushl  0x8(%ebp)
     cdf:	e8 bb fb ff ff       	call   89f <APGetIndex>
     ce4:	83 c4 0c             	add    $0xc,%esp
     ce7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     cea:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     cee:	74 55                	je     d45 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     cf0:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     cf4:	74 67                	je     d5d <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     cf6:	ff 75 10             	pushl  0x10(%ebp)
     cf9:	ff 75 0c             	pushl  0xc(%ebp)
     cfc:	ff 75 fc             	pushl  -0x4(%ebp)
     cff:	ff 75 f8             	pushl  -0x8(%ebp)
     d02:	e8 5f fb ff ff       	call   866 <distance_2>
     d07:	83 c4 10             	add    $0x10,%esp
     d0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d0d:	7f 23                	jg     d32 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d0f:	8b 45 08             	mov    0x8(%ebp),%eax
     d12:	8b 48 18             	mov    0x18(%eax),%ecx
     d15:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d18:	89 d0                	mov    %edx,%eax
     d1a:	01 c0                	add    %eax,%eax
     d1c:	01 d0                	add    %edx,%eax
     d1e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d21:	8b 45 08             	mov    0x8(%ebp),%eax
     d24:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d28:	66 89 0a             	mov    %cx,(%edx)
     d2b:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d2f:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d32:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d36:	8b 55 0c             	mov    0xc(%ebp),%edx
     d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d3c:	01 d0                	add    %edx,%eax
     d3e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d41:	7d 93                	jge    cd6 <APDrawPoint+0x59>
     d43:	eb 01                	jmp    d46 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d45:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d46:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d4a:	8b 55 10             	mov    0x10(%ebp),%edx
     d4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d50:	01 d0                	add    %edx,%eax
     d52:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d55:	0f 8d 63 ff ff ff    	jge    cbe <APDrawPoint+0x41>
     d5b:	eb 01                	jmp    d5e <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     d5d:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     d5e:	c9                   	leave  
     d5f:	c3                   	ret    

00000d60 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     d60:	55                   	push   %ebp
     d61:	89 e5                	mov    %esp,%ebp
     d63:	53                   	push   %ebx
     d64:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     d67:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6a:	3b 45 14             	cmp    0x14(%ebp),%eax
     d6d:	0f 85 80 00 00 00    	jne    df3 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     d73:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d77:	0f 88 9d 02 00 00    	js     101a <APDrawLine+0x2ba>
     d7d:	8b 45 08             	mov    0x8(%ebp),%eax
     d80:	8b 00                	mov    (%eax),%eax
     d82:	3b 45 0c             	cmp    0xc(%ebp),%eax
     d85:	0f 8e 8f 02 00 00    	jle    101a <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     d8b:	8b 45 10             	mov    0x10(%ebp),%eax
     d8e:	3b 45 18             	cmp    0x18(%ebp),%eax
     d91:	7e 12                	jle    da5 <APDrawLine+0x45>
        {
            int tmp = y2;
     d93:	8b 45 18             	mov    0x18(%ebp),%eax
     d96:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     d99:	8b 45 10             	mov    0x10(%ebp),%eax
     d9c:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     d9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     da2:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     da5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     da9:	79 07                	jns    db2 <APDrawLine+0x52>
     dab:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     db2:	8b 45 08             	mov    0x8(%ebp),%eax
     db5:	8b 40 04             	mov    0x4(%eax),%eax
     db8:	3b 45 18             	cmp    0x18(%ebp),%eax
     dbb:	7d 0c                	jge    dc9 <APDrawLine+0x69>
     dbd:	8b 45 08             	mov    0x8(%ebp),%eax
     dc0:	8b 40 04             	mov    0x4(%eax),%eax
     dc3:	83 e8 01             	sub    $0x1,%eax
     dc6:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     dc9:	8b 45 10             	mov    0x10(%ebp),%eax
     dcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dcf:	eb 15                	jmp    de6 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     dd1:	ff 75 f4             	pushl  -0xc(%ebp)
     dd4:	ff 75 0c             	pushl  0xc(%ebp)
     dd7:	ff 75 08             	pushl  0x8(%ebp)
     dda:	e8 9e fe ff ff       	call   c7d <APDrawPoint>
     ddf:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     de2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de9:	3b 45 18             	cmp    0x18(%ebp),%eax
     dec:	7e e3                	jle    dd1 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     dee:	e9 2b 02 00 00       	jmp    101e <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     df3:	8b 45 10             	mov    0x10(%ebp),%eax
     df6:	3b 45 18             	cmp    0x18(%ebp),%eax
     df9:	75 7f                	jne    e7a <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     dfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     dff:	0f 88 18 02 00 00    	js     101d <APDrawLine+0x2bd>
     e05:	8b 45 08             	mov    0x8(%ebp),%eax
     e08:	8b 40 04             	mov    0x4(%eax),%eax
     e0b:	3b 45 10             	cmp    0x10(%ebp),%eax
     e0e:	0f 8e 09 02 00 00    	jle    101d <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e14:	8b 45 0c             	mov    0xc(%ebp),%eax
     e17:	3b 45 14             	cmp    0x14(%ebp),%eax
     e1a:	7e 12                	jle    e2e <APDrawLine+0xce>
        {
            int tmp = x2;
     e1c:	8b 45 14             	mov    0x14(%ebp),%eax
     e1f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e22:	8b 45 0c             	mov    0xc(%ebp),%eax
     e25:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e28:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e2b:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e2e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e32:	79 07                	jns    e3b <APDrawLine+0xdb>
     e34:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e3b:	8b 45 08             	mov    0x8(%ebp),%eax
     e3e:	8b 00                	mov    (%eax),%eax
     e40:	3b 45 14             	cmp    0x14(%ebp),%eax
     e43:	7d 0b                	jge    e50 <APDrawLine+0xf0>
     e45:	8b 45 08             	mov    0x8(%ebp),%eax
     e48:	8b 00                	mov    (%eax),%eax
     e4a:	83 e8 01             	sub    $0x1,%eax
     e4d:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     e50:	8b 45 0c             	mov    0xc(%ebp),%eax
     e53:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e56:	eb 15                	jmp    e6d <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     e58:	ff 75 10             	pushl  0x10(%ebp)
     e5b:	ff 75 f0             	pushl  -0x10(%ebp)
     e5e:	ff 75 08             	pushl  0x8(%ebp)
     e61:	e8 17 fe ff ff       	call   c7d <APDrawPoint>
     e66:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     e69:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e70:	3b 45 14             	cmp    0x14(%ebp),%eax
     e73:	7e e3                	jle    e58 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     e75:	e9 a4 01 00 00       	jmp    101e <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     e7a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e81:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     e88:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8b:	2b 45 14             	sub    0x14(%ebp),%eax
     e8e:	50                   	push   %eax
     e8f:	e8 fb f9 ff ff       	call   88f <abs_int>
     e94:	83 c4 04             	add    $0x4,%esp
     e97:	89 c3                	mov    %eax,%ebx
     e99:	8b 45 10             	mov    0x10(%ebp),%eax
     e9c:	2b 45 18             	sub    0x18(%ebp),%eax
     e9f:	50                   	push   %eax
     ea0:	e8 ea f9 ff ff       	call   88f <abs_int>
     ea5:	83 c4 04             	add    $0x4,%esp
     ea8:	39 c3                	cmp    %eax,%ebx
     eaa:	0f 8e b5 00 00 00    	jle    f65 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     eb0:	8b 45 10             	mov    0x10(%ebp),%eax
     eb3:	2b 45 18             	sub    0x18(%ebp),%eax
     eb6:	89 45 b0             	mov    %eax,-0x50(%ebp)
     eb9:	db 45 b0             	fildl  -0x50(%ebp)
     ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ebf:	2b 45 14             	sub    0x14(%ebp),%eax
     ec2:	89 45 b0             	mov    %eax,-0x50(%ebp)
     ec5:	db 45 b0             	fildl  -0x50(%ebp)
     ec8:	de f9                	fdivrp %st,%st(1)
     eca:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     ecd:	8b 45 14             	mov    0x14(%ebp),%eax
     ed0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ed3:	7e 0e                	jle    ee3 <APDrawLine+0x183>
        {
            s = x1;
     ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     edb:	8b 45 14             	mov    0x14(%ebp),%eax
     ede:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ee1:	eb 0c                	jmp    eef <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     ee3:	8b 45 14             	mov    0x14(%ebp),%eax
     ee6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     ee9:	8b 45 0c             	mov    0xc(%ebp),%eax
     eec:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     eef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ef3:	79 07                	jns    efc <APDrawLine+0x19c>
     ef5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     efc:	8b 45 08             	mov    0x8(%ebp),%eax
     eff:	8b 00                	mov    (%eax),%eax
     f01:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f04:	7f 0b                	jg     f11 <APDrawLine+0x1b1>
     f06:	8b 45 08             	mov    0x8(%ebp),%eax
     f09:	8b 00                	mov    (%eax),%eax
     f0b:	83 e8 01             	sub    $0x1,%eax
     f0e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f11:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f14:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f17:	eb 3f                	jmp    f58 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f1c:	2b 45 0c             	sub    0xc(%ebp),%eax
     f1f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f22:	db 45 b0             	fildl  -0x50(%ebp)
     f25:	dc 4d d0             	fmull  -0x30(%ebp)
     f28:	db 45 10             	fildl  0x10(%ebp)
     f2b:	de c1                	faddp  %st,%st(1)
     f2d:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f30:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f34:	b4 0c                	mov    $0xc,%ah
     f36:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f3a:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f3d:	db 5d cc             	fistpl -0x34(%ebp)
     f40:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f43:	ff 75 cc             	pushl  -0x34(%ebp)
     f46:	ff 75 e4             	pushl  -0x1c(%ebp)
     f49:	ff 75 08             	pushl  0x8(%ebp)
     f4c:	e8 2c fd ff ff       	call   c7d <APDrawPoint>
     f51:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     f54:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     f58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f5b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f5e:	7e b9                	jle    f19 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     f60:	e9 b9 00 00 00       	jmp    101e <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     f65:	8b 45 0c             	mov    0xc(%ebp),%eax
     f68:	2b 45 14             	sub    0x14(%ebp),%eax
     f6b:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f6e:	db 45 b0             	fildl  -0x50(%ebp)
     f71:	8b 45 10             	mov    0x10(%ebp),%eax
     f74:	2b 45 18             	sub    0x18(%ebp),%eax
     f77:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7a:	db 45 b0             	fildl  -0x50(%ebp)
     f7d:	de f9                	fdivrp %st,%st(1)
     f7f:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     f82:	8b 45 10             	mov    0x10(%ebp),%eax
     f85:	3b 45 18             	cmp    0x18(%ebp),%eax
     f88:	7e 0e                	jle    f98 <APDrawLine+0x238>
    {
        s = y2;
     f8a:	8b 45 18             	mov    0x18(%ebp),%eax
     f8d:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     f90:	8b 45 10             	mov    0x10(%ebp),%eax
     f93:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f96:	eb 0c                	jmp    fa4 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     f98:	8b 45 10             	mov    0x10(%ebp),%eax
     f9b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     f9e:	8b 45 18             	mov    0x18(%ebp),%eax
     fa1:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     fa4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fa8:	79 07                	jns    fb1 <APDrawLine+0x251>
     faa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
     fb1:	8b 45 08             	mov    0x8(%ebp),%eax
     fb4:	8b 40 04             	mov    0x4(%eax),%eax
     fb7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fba:	7f 0c                	jg     fc8 <APDrawLine+0x268>
     fbc:	8b 45 08             	mov    0x8(%ebp),%eax
     fbf:	8b 40 04             	mov    0x4(%eax),%eax
     fc2:	83 e8 01             	sub    $0x1,%eax
     fc5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
     fc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fcb:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fce:	eb 3f                	jmp    100f <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
     fd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     fd3:	2b 45 10             	sub    0x10(%ebp),%eax
     fd6:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fd9:	db 45 b0             	fildl  -0x50(%ebp)
     fdc:	dc 4d c0             	fmull  -0x40(%ebp)
     fdf:	db 45 0c             	fildl  0xc(%ebp)
     fe2:	de c1                	faddp  %st,%st(1)
     fe4:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fe7:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     feb:	b4 0c                	mov    $0xc,%ah
     fed:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ff1:	d9 6d b4             	fldcw  -0x4c(%ebp)
     ff4:	db 5d bc             	fistpl -0x44(%ebp)
     ff7:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
     ffa:	ff 75 e0             	pushl  -0x20(%ebp)
     ffd:	ff 75 bc             	pushl  -0x44(%ebp)
    1000:	ff 75 08             	pushl  0x8(%ebp)
    1003:	e8 75 fc ff ff       	call   c7d <APDrawPoint>
    1008:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    100b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    100f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1012:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1015:	7e b9                	jle    fd0 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1017:	90                   	nop
    1018:	eb 04                	jmp    101e <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    101a:	90                   	nop
    101b:	eb 01                	jmp    101e <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    101d:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    101e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1021:	c9                   	leave  
    1022:	c3                   	ret    

00001023 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1023:	55                   	push   %ebp
    1024:	89 e5                	mov    %esp,%ebp
    1026:	53                   	push   %ebx
    1027:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    102a:	8b 55 10             	mov    0x10(%ebp),%edx
    102d:	8b 45 18             	mov    0x18(%ebp),%eax
    1030:	01 d0                	add    %edx,%eax
    1032:	83 e8 01             	sub    $0x1,%eax
    1035:	83 ec 04             	sub    $0x4,%esp
    1038:	50                   	push   %eax
    1039:	ff 75 0c             	pushl  0xc(%ebp)
    103c:	ff 75 10             	pushl  0x10(%ebp)
    103f:	ff 75 0c             	pushl  0xc(%ebp)
    1042:	ff 75 08             	pushl  0x8(%ebp)
    1045:	e8 16 fd ff ff       	call   d60 <APDrawLine>
    104a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    104d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1050:	8b 45 14             	mov    0x14(%ebp),%eax
    1053:	01 d0                	add    %edx,%eax
    1055:	83 e8 01             	sub    $0x1,%eax
    1058:	83 ec 04             	sub    $0x4,%esp
    105b:	ff 75 10             	pushl  0x10(%ebp)
    105e:	50                   	push   %eax
    105f:	ff 75 10             	pushl  0x10(%ebp)
    1062:	ff 75 0c             	pushl  0xc(%ebp)
    1065:	ff 75 08             	pushl  0x8(%ebp)
    1068:	e8 f3 fc ff ff       	call   d60 <APDrawLine>
    106d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1070:	8b 55 10             	mov    0x10(%ebp),%edx
    1073:	8b 45 18             	mov    0x18(%ebp),%eax
    1076:	01 d0                	add    %edx,%eax
    1078:	8d 48 ff             	lea    -0x1(%eax),%ecx
    107b:	8b 55 0c             	mov    0xc(%ebp),%edx
    107e:	8b 45 14             	mov    0x14(%ebp),%eax
    1081:	01 d0                	add    %edx,%eax
    1083:	8d 50 ff             	lea    -0x1(%eax),%edx
    1086:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1089:	8b 45 14             	mov    0x14(%ebp),%eax
    108c:	01 d8                	add    %ebx,%eax
    108e:	83 e8 01             	sub    $0x1,%eax
    1091:	83 ec 04             	sub    $0x4,%esp
    1094:	51                   	push   %ecx
    1095:	52                   	push   %edx
    1096:	ff 75 10             	pushl  0x10(%ebp)
    1099:	50                   	push   %eax
    109a:	ff 75 08             	pushl  0x8(%ebp)
    109d:	e8 be fc ff ff       	call   d60 <APDrawLine>
    10a2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10a5:	8b 55 10             	mov    0x10(%ebp),%edx
    10a8:	8b 45 18             	mov    0x18(%ebp),%eax
    10ab:	01 d0                	add    %edx,%eax
    10ad:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10b0:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b3:	8b 45 14             	mov    0x14(%ebp),%eax
    10b6:	01 d0                	add    %edx,%eax
    10b8:	8d 50 ff             	lea    -0x1(%eax),%edx
    10bb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    10be:	8b 45 18             	mov    0x18(%ebp),%eax
    10c1:	01 d8                	add    %ebx,%eax
    10c3:	83 e8 01             	sub    $0x1,%eax
    10c6:	83 ec 04             	sub    $0x4,%esp
    10c9:	51                   	push   %ecx
    10ca:	52                   	push   %edx
    10cb:	50                   	push   %eax
    10cc:	ff 75 0c             	pushl  0xc(%ebp)
    10cf:	ff 75 08             	pushl  0x8(%ebp)
    10d2:	e8 89 fc ff ff       	call   d60 <APDrawLine>
    10d7:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    10da:	8b 55 0c             	mov    0xc(%ebp),%edx
    10dd:	8b 45 14             	mov    0x14(%ebp),%eax
    10e0:	01 d0                	add    %edx,%eax
    10e2:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e5:	8b 45 08             	mov    0x8(%ebp),%eax
    10e8:	8b 40 0c             	mov    0xc(%eax),%eax
    10eb:	89 c1                	mov    %eax,%ecx
    10ed:	c1 e9 1f             	shr    $0x1f,%ecx
    10f0:	01 c8                	add    %ecx,%eax
    10f2:	d1 f8                	sar    %eax
    10f4:	29 c2                	sub    %eax,%edx
    10f6:	89 d0                	mov    %edx,%eax
    10f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    10fb:	8b 55 10             	mov    0x10(%ebp),%edx
    10fe:	8b 45 18             	mov    0x18(%ebp),%eax
    1101:	01 d0                	add    %edx,%eax
    1103:	8d 50 ff             	lea    -0x1(%eax),%edx
    1106:	8b 45 08             	mov    0x8(%ebp),%eax
    1109:	8b 40 0c             	mov    0xc(%eax),%eax
    110c:	89 c1                	mov    %eax,%ecx
    110e:	c1 e9 1f             	shr    $0x1f,%ecx
    1111:	01 c8                	add    %ecx,%eax
    1113:	d1 f8                	sar    %eax
    1115:	29 c2                	sub    %eax,%edx
    1117:	89 d0                	mov    %edx,%eax
    1119:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    111c:	8b 45 08             	mov    0x8(%ebp),%eax
    111f:	8b 40 0c             	mov    0xc(%eax),%eax
    1122:	89 c2                	mov    %eax,%edx
    1124:	c1 ea 1f             	shr    $0x1f,%edx
    1127:	01 d0                	add    %edx,%eax
    1129:	d1 f8                	sar    %eax
    112b:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    112e:	8b 45 08             	mov    0x8(%ebp),%eax
    1131:	8b 40 0c             	mov    0xc(%eax),%eax
    1134:	89 c2                	mov    %eax,%edx
    1136:	c1 ea 1f             	shr    $0x1f,%edx
    1139:	01 d0                	add    %edx,%eax
    113b:	d1 f8                	sar    %eax
    113d:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1140:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1144:	0f 88 d8 00 00 00    	js     1222 <APDrawRect+0x1ff>
    114a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    114e:	0f 88 ce 00 00 00    	js     1222 <APDrawRect+0x1ff>
    1154:	8b 45 08             	mov    0x8(%ebp),%eax
    1157:	8b 00                	mov    (%eax),%eax
    1159:	3b 45 0c             	cmp    0xc(%ebp),%eax
    115c:	0f 8e c0 00 00 00    	jle    1222 <APDrawRect+0x1ff>
    1162:	8b 45 08             	mov    0x8(%ebp),%eax
    1165:	8b 40 04             	mov    0x4(%eax),%eax
    1168:	3b 45 10             	cmp    0x10(%ebp),%eax
    116b:	0f 8e b1 00 00 00    	jle    1222 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1171:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1175:	79 07                	jns    117e <APDrawRect+0x15b>
    1177:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    117e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1182:	79 07                	jns    118b <APDrawRect+0x168>
    1184:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    118b:	8b 45 08             	mov    0x8(%ebp),%eax
    118e:	8b 00                	mov    (%eax),%eax
    1190:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1193:	7f 0b                	jg     11a0 <APDrawRect+0x17d>
    1195:	8b 45 08             	mov    0x8(%ebp),%eax
    1198:	8b 00                	mov    (%eax),%eax
    119a:	83 e8 01             	sub    $0x1,%eax
    119d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11a0:	8b 45 08             	mov    0x8(%ebp),%eax
    11a3:	8b 40 04             	mov    0x4(%eax),%eax
    11a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    11a9:	7f 0c                	jg     11b7 <APDrawRect+0x194>
    11ab:	8b 45 08             	mov    0x8(%ebp),%eax
    11ae:	8b 40 04             	mov    0x4(%eax),%eax
    11b1:	83 e8 01             	sub    $0x1,%eax
    11b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    11b7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    11be:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    11c4:	eb 52                	jmp    1218 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    11c6:	8b 45 10             	mov    0x10(%ebp),%eax
    11c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11cc:	eb 3e                	jmp    120c <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    11ce:	83 ec 04             	sub    $0x4,%esp
    11d1:	ff 75 e8             	pushl  -0x18(%ebp)
    11d4:	ff 75 ec             	pushl  -0x14(%ebp)
    11d7:	ff 75 08             	pushl  0x8(%ebp)
    11da:	e8 c0 f6 ff ff       	call   89f <APGetIndex>
    11df:	83 c4 10             	add    $0x10,%esp
    11e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    11e5:	8b 45 08             	mov    0x8(%ebp),%eax
    11e8:	8b 48 18             	mov    0x18(%eax),%ecx
    11eb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11ee:	89 d0                	mov    %edx,%eax
    11f0:	01 c0                	add    %eax,%eax
    11f2:	01 d0                	add    %edx,%eax
    11f4:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    11f7:	8b 45 08             	mov    0x8(%ebp),%eax
    11fa:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    11fe:	66 89 0a             	mov    %cx,(%edx)
    1201:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1205:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1208:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    120c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    120f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1212:	7e ba                	jle    11ce <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1214:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1218:	8b 45 ec             	mov    -0x14(%ebp),%eax
    121b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    121e:	7e a6                	jle    11c6 <APDrawRect+0x1a3>
    1220:	eb 01                	jmp    1223 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1222:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1223:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1226:	c9                   	leave  
    1227:	c3                   	ret    

00001228 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1228:	55                   	push   %ebp
    1229:	89 e5                	mov    %esp,%ebp
    122b:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    122e:	83 ec 0c             	sub    $0xc,%esp
    1231:	ff 75 0c             	pushl  0xc(%ebp)
    1234:	e8 c1 ee ff ff       	call   fa <strlen>
    1239:	83 c4 10             	add    $0x10,%esp
    123c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    123f:	8b 45 08             	mov    0x8(%ebp),%eax
    1242:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1246:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    124a:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    124e:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1251:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1258:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    125f:	e9 bc 00 00 00       	jmp    1320 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1264:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1267:	8b 45 0c             	mov    0xc(%ebp),%eax
    126a:	01 d0                	add    %edx,%eax
    126c:	0f b6 00             	movzbl (%eax),%eax
    126f:	0f be c0             	movsbl %al,%eax
    1272:	83 e8 20             	sub    $0x20,%eax
    1275:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1278:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    127c:	0f 87 9a 00 00 00    	ja     131c <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1282:	8b 45 08             	mov    0x8(%ebp),%eax
    1285:	8b 00                	mov    (%eax),%eax
    1287:	0f af 45 14          	imul   0x14(%ebp),%eax
    128b:	89 c2                	mov    %eax,%edx
    128d:	8b 45 10             	mov    0x10(%ebp),%eax
    1290:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1293:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1296:	89 d0                	mov    %edx,%eax
    1298:	c1 e0 03             	shl    $0x3,%eax
    129b:	01 d0                	add    %edx,%eax
    129d:	01 c8                	add    %ecx,%eax
    129f:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    12a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    12a9:	eb 6b                	jmp    1316 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    12ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12b2:	eb 50                	jmp    1304 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    12b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    12b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    12ba:	89 d0                	mov    %edx,%eax
    12bc:	c1 e0 03             	shl    $0x3,%eax
    12bf:	01 d0                	add    %edx,%eax
    12c1:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    12c7:	01 c2                	add    %eax,%edx
    12c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12cc:	01 d0                	add    %edx,%eax
    12ce:	05 00 2b 00 00       	add    $0x2b00,%eax
    12d3:	0f b6 00             	movzbl (%eax),%eax
    12d6:	84 c0                	test   %al,%al
    12d8:	74 26                	je     1300 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    12da:	8b 45 08             	mov    0x8(%ebp),%eax
    12dd:	8b 50 18             	mov    0x18(%eax),%edx
    12e0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    12e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12e6:	01 c8                	add    %ecx,%eax
    12e8:	89 c1                	mov    %eax,%ecx
    12ea:	89 c8                	mov    %ecx,%eax
    12ec:	01 c0                	add    %eax,%eax
    12ee:	01 c8                	add    %ecx,%eax
    12f0:	01 d0                	add    %edx,%eax
    12f2:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    12f6:	66 89 10             	mov    %dx,(%eax)
    12f9:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    12fd:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1300:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1304:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1308:	7e aa                	jle    12b4 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    130a:	8b 45 08             	mov    0x8(%ebp),%eax
    130d:	8b 00                	mov    (%eax),%eax
    130f:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1312:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1316:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    131a:	7e 8f                	jle    12ab <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    131c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1320:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1323:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1326:	0f 82 38 ff ff ff    	jb     1264 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    132c:	90                   	nop
    132d:	c9                   	leave  
    132e:	c3                   	ret    

0000132f <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    132f:	55                   	push   %ebp
    1330:	89 e5                	mov    %esp,%ebp
    1332:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1335:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1339:	0f 88 8e 01 00 00    	js     14cd <APDcCopy+0x19e>
    133f:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1343:	0f 88 84 01 00 00    	js     14cd <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1349:	8b 55 0c             	mov    0xc(%ebp),%edx
    134c:	8b 45 20             	mov    0x20(%ebp),%eax
    134f:	01 d0                	add    %edx,%eax
    1351:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1354:	8b 55 10             	mov    0x10(%ebp),%edx
    1357:	8b 45 24             	mov    0x24(%ebp),%eax
    135a:	01 d0                	add    %edx,%eax
    135c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    135f:	8b 55 18             	mov    0x18(%ebp),%edx
    1362:	8b 45 20             	mov    0x20(%ebp),%eax
    1365:	01 d0                	add    %edx,%eax
    1367:	89 45 ec             	mov    %eax,-0x14(%ebp)
    136a:	8b 55 1c             	mov    0x1c(%ebp),%edx
    136d:	8b 45 24             	mov    0x24(%ebp),%eax
    1370:	01 d0                	add    %edx,%eax
    1372:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1375:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1379:	0f 88 51 01 00 00    	js     14d0 <APDcCopy+0x1a1>
    137f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1383:	0f 88 47 01 00 00    	js     14d0 <APDcCopy+0x1a1>
    1389:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    138d:	0f 88 3d 01 00 00    	js     14d0 <APDcCopy+0x1a1>
    1393:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1397:	0f 88 33 01 00 00    	js     14d0 <APDcCopy+0x1a1>
    139d:	8b 45 14             	mov    0x14(%ebp),%eax
    13a0:	8b 00                	mov    (%eax),%eax
    13a2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    13a5:	0f 8c 25 01 00 00    	jl     14d0 <APDcCopy+0x1a1>
    13ab:	8b 45 14             	mov    0x14(%ebp),%eax
    13ae:	8b 40 04             	mov    0x4(%eax),%eax
    13b1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    13b4:	0f 8c 16 01 00 00    	jl     14d0 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    13ba:	8b 45 08             	mov    0x8(%ebp),%eax
    13bd:	8b 00                	mov    (%eax),%eax
    13bf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13c2:	7f 0b                	jg     13cf <APDcCopy+0xa0>
    13c4:	8b 45 08             	mov    0x8(%ebp),%eax
    13c7:	8b 00                	mov    (%eax),%eax
    13c9:	83 e8 01             	sub    $0x1,%eax
    13cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    13cf:	8b 45 08             	mov    0x8(%ebp),%eax
    13d2:	8b 40 04             	mov    0x4(%eax),%eax
    13d5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13d8:	7f 0c                	jg     13e6 <APDcCopy+0xb7>
    13da:	8b 45 08             	mov    0x8(%ebp),%eax
    13dd:	8b 40 04             	mov    0x4(%eax),%eax
    13e0:	83 e8 01             	sub    $0x1,%eax
    13e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13e6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13ed:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    13f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13fb:	e9 bc 00 00 00       	jmp    14bc <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1400:	8b 45 08             	mov    0x8(%ebp),%eax
    1403:	8b 00                	mov    (%eax),%eax
    1405:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1408:	8b 55 10             	mov    0x10(%ebp),%edx
    140b:	01 ca                	add    %ecx,%edx
    140d:	0f af d0             	imul   %eax,%edx
    1410:	8b 45 0c             	mov    0xc(%ebp),%eax
    1413:	01 d0                	add    %edx,%eax
    1415:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1418:	8b 45 14             	mov    0x14(%ebp),%eax
    141b:	8b 00                	mov    (%eax),%eax
    141d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1420:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1423:	01 ca                	add    %ecx,%edx
    1425:	0f af d0             	imul   %eax,%edx
    1428:	8b 45 18             	mov    0x18(%ebp),%eax
    142b:	01 d0                	add    %edx,%eax
    142d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1430:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1437:	eb 74                	jmp    14ad <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1439:	8b 45 14             	mov    0x14(%ebp),%eax
    143c:	8b 50 18             	mov    0x18(%eax),%edx
    143f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1442:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1445:	01 c8                	add    %ecx,%eax
    1447:	89 c1                	mov    %eax,%ecx
    1449:	89 c8                	mov    %ecx,%eax
    144b:	01 c0                	add    %eax,%eax
    144d:	01 c8                	add    %ecx,%eax
    144f:	01 d0                	add    %edx,%eax
    1451:	0f b7 10             	movzwl (%eax),%edx
    1454:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1458:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    145c:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    145f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1463:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1467:	38 c2                	cmp    %al,%dl
    1469:	75 18                	jne    1483 <APDcCopy+0x154>
    146b:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    146f:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1473:	38 c2                	cmp    %al,%dl
    1475:	75 0c                	jne    1483 <APDcCopy+0x154>
    1477:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    147b:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    147f:	38 c2                	cmp    %al,%dl
    1481:	74 26                	je     14a9 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1483:	8b 45 08             	mov    0x8(%ebp),%eax
    1486:	8b 50 18             	mov    0x18(%eax),%edx
    1489:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    148c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    148f:	01 c8                	add    %ecx,%eax
    1491:	89 c1                	mov    %eax,%ecx
    1493:	89 c8                	mov    %ecx,%eax
    1495:	01 c0                	add    %eax,%eax
    1497:	01 c8                	add    %ecx,%eax
    1499:	01 d0                	add    %edx,%eax
    149b:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    149f:	66 89 10             	mov    %dx,(%eax)
    14a2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    14a6:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    14a9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14b0:	2b 45 0c             	sub    0xc(%ebp),%eax
    14b3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14b6:	7d 81                	jge    1439 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    14b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14bf:	2b 45 10             	sub    0x10(%ebp),%eax
    14c2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14c5:	0f 8d 35 ff ff ff    	jge    1400 <APDcCopy+0xd1>
    14cb:	eb 04                	jmp    14d1 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14cd:	90                   	nop
    14ce:	eb 01                	jmp    14d1 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    14d0:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14d1:	c9                   	leave  
    14d2:	c3                   	ret    

000014d3 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14d3:	55                   	push   %ebp
    14d4:	89 e5                	mov    %esp,%ebp
    14d6:	83 ec 1c             	sub    $0x1c,%esp
    14d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14dc:	8b 55 10             	mov    0x10(%ebp),%edx
    14df:	8b 45 14             	mov    0x14(%ebp),%eax
    14e2:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14e5:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14e8:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14eb:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14ef:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    14f2:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    14f6:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    14f9:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    14fd:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1500:	8b 45 08             	mov    0x8(%ebp),%eax
    1503:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1507:	66 89 10             	mov    %dx,(%eax)
    150a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    150e:	88 50 02             	mov    %dl,0x2(%eax)
}
    1511:	8b 45 08             	mov    0x8(%ebp),%eax
    1514:	c9                   	leave  
    1515:	c2 04 00             	ret    $0x4

00001518 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1518:	55                   	push   %ebp
    1519:	89 e5                	mov    %esp,%ebp
    151b:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    151e:	8b 45 08             	mov    0x8(%ebp),%eax
    1521:	8b 00                	mov    (%eax),%eax
    1523:	83 ec 08             	sub    $0x8,%esp
    1526:	8d 55 0c             	lea    0xc(%ebp),%edx
    1529:	52                   	push   %edx
    152a:	50                   	push   %eax
    152b:	e8 34 ee ff ff       	call   364 <sendMessage>
    1530:	83 c4 10             	add    $0x10,%esp
}
    1533:	90                   	nop
    1534:	c9                   	leave  
    1535:	c3                   	ret    

00001536 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1536:	55                   	push   %ebp
    1537:	89 e5                	mov    %esp,%ebp
    1539:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    153c:	83 ec 0c             	sub    $0xc,%esp
    153f:	68 98 00 00 00       	push   $0x98
    1544:	e8 f5 f1 ff ff       	call   73e <malloc>
    1549:	83 c4 10             	add    $0x10,%esp
    154c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    154f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1553:	75 15                	jne    156a <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1555:	83 ec 04             	sub    $0x4,%esp
    1558:	ff 75 08             	pushl  0x8(%ebp)
    155b:	68 f8 23 00 00       	push   $0x23f8
    1560:	6a 01                	push   $0x1
    1562:	e8 04 ef ff ff       	call   46b <printf>
    1567:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    156a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156d:	05 84 00 00 00       	add    $0x84,%eax
    1572:	83 ec 08             	sub    $0x8,%esp
    1575:	ff 75 08             	pushl  0x8(%ebp)
    1578:	50                   	push   %eax
    1579:	e8 0d eb ff ff       	call   8b <strcpy>
    157e:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1581:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1584:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    158b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158e:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1595:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1598:	8b 40 3c             	mov    0x3c(%eax),%eax
    159b:	89 c2                	mov    %eax,%edx
    159d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a0:	8b 40 40             	mov    0x40(%eax),%eax
    15a3:	0f af d0             	imul   %eax,%edx
    15a6:	89 d0                	mov    %edx,%eax
    15a8:	01 c0                	add    %eax,%eax
    15aa:	01 d0                	add    %edx,%eax
    15ac:	83 ec 0c             	sub    $0xc,%esp
    15af:	50                   	push   %eax
    15b0:	e8 89 f1 ff ff       	call   73e <malloc>
    15b5:	83 c4 10             	add    $0x10,%esp
    15b8:	89 c2                	mov    %eax,%edx
    15ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bd:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    15c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c3:	8b 40 54             	mov    0x54(%eax),%eax
    15c6:	85 c0                	test   %eax,%eax
    15c8:	75 15                	jne    15df <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    15ca:	83 ec 04             	sub    $0x4,%esp
    15cd:	ff 75 08             	pushl  0x8(%ebp)
    15d0:	68 18 24 00 00       	push   $0x2418
    15d5:	6a 01                	push   $0x1
    15d7:	e8 8f ee ff ff       	call   46b <printf>
    15dc:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e2:	8b 40 3c             	mov    0x3c(%eax),%eax
    15e5:	89 c2                	mov    %eax,%edx
    15e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ea:	8b 40 40             	mov    0x40(%eax),%eax
    15ed:	0f af d0             	imul   %eax,%edx
    15f0:	89 d0                	mov    %edx,%eax
    15f2:	01 c0                	add    %eax,%eax
    15f4:	01 c2                	add    %eax,%edx
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	8b 40 54             	mov    0x54(%eax),%eax
    15fc:	83 ec 04             	sub    $0x4,%esp
    15ff:	52                   	push   %edx
    1600:	68 ff ff ff 00       	push   $0xffffff
    1605:	50                   	push   %eax
    1606:	e8 16 eb ff ff       	call   121 <memset>
    160b:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    160e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1611:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1618:	e8 1f ed ff ff       	call   33c <getpid>
    161d:	89 c2                	mov    %eax,%edx
    161f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1622:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1625:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1628:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    162f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1632:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	8b 40 58             	mov    0x58(%eax),%eax
    163f:	89 c2                	mov    %eax,%edx
    1641:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1644:	8b 40 5c             	mov    0x5c(%eax),%eax
    1647:	0f af d0             	imul   %eax,%edx
    164a:	89 d0                	mov    %edx,%eax
    164c:	01 c0                	add    %eax,%eax
    164e:	01 d0                	add    %edx,%eax
    1650:	83 ec 0c             	sub    $0xc,%esp
    1653:	50                   	push   %eax
    1654:	e8 e5 f0 ff ff       	call   73e <malloc>
    1659:	83 c4 10             	add    $0x10,%esp
    165c:	89 c2                	mov    %eax,%edx
    165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1661:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1664:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1667:	8b 40 70             	mov    0x70(%eax),%eax
    166a:	85 c0                	test   %eax,%eax
    166c:	75 15                	jne    1683 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    166e:	83 ec 04             	sub    $0x4,%esp
    1671:	ff 75 08             	pushl  0x8(%ebp)
    1674:	68 3c 24 00 00       	push   $0x243c
    1679:	6a 01                	push   $0x1
    167b:	e8 eb ed ff ff       	call   46b <printf>
    1680:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1683:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1686:	8b 40 3c             	mov    0x3c(%eax),%eax
    1689:	89 c2                	mov    %eax,%edx
    168b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168e:	8b 40 40             	mov    0x40(%eax),%eax
    1691:	0f af d0             	imul   %eax,%edx
    1694:	89 d0                	mov    %edx,%eax
    1696:	01 c0                	add    %eax,%eax
    1698:	01 c2                	add    %eax,%edx
    169a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169d:	8b 40 54             	mov    0x54(%eax),%eax
    16a0:	83 ec 04             	sub    $0x4,%esp
    16a3:	52                   	push   %edx
    16a4:	68 ff 00 00 00       	push   $0xff
    16a9:	50                   	push   %eax
    16aa:	e8 72 ea ff ff       	call   121 <memset>
    16af:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    16b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b5:	8b 55 0c             	mov    0xc(%ebp),%edx
    16b8:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    16bb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16bf:	74 49                	je     170a <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16c1:	8b 45 10             	mov    0x10(%ebp),%eax
    16c4:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16ca:	83 ec 0c             	sub    $0xc,%esp
    16cd:	50                   	push   %eax
    16ce:	e8 6b f0 ff ff       	call   73e <malloc>
    16d3:	83 c4 10             	add    $0x10,%esp
    16d6:	89 c2                	mov    %eax,%edx
    16d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16db:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e1:	8b 55 10             	mov    0x10(%ebp),%edx
    16e4:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ea:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    16f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f4:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    16fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fe:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1705:	e9 8d 00 00 00       	jmp    1797 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170d:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1714:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1717:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    171e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1721:	8b 40 20             	mov    0x20(%eax),%eax
    1724:	89 c2                	mov    %eax,%edx
    1726:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1729:	8b 40 24             	mov    0x24(%eax),%eax
    172c:	0f af d0             	imul   %eax,%edx
    172f:	89 d0                	mov    %edx,%eax
    1731:	01 c0                	add    %eax,%eax
    1733:	01 d0                	add    %edx,%eax
    1735:	83 ec 0c             	sub    $0xc,%esp
    1738:	50                   	push   %eax
    1739:	e8 00 f0 ff ff       	call   73e <malloc>
    173e:	83 c4 10             	add    $0x10,%esp
    1741:	89 c2                	mov    %eax,%edx
    1743:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1746:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1749:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174c:	8b 40 38             	mov    0x38(%eax),%eax
    174f:	85 c0                	test   %eax,%eax
    1751:	75 15                	jne    1768 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1753:	83 ec 04             	sub    $0x4,%esp
    1756:	ff 75 08             	pushl  0x8(%ebp)
    1759:	68 64 24 00 00       	push   $0x2464
    175e:	6a 01                	push   $0x1
    1760:	e8 06 ed ff ff       	call   46b <printf>
    1765:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1768:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176b:	8b 40 20             	mov    0x20(%eax),%eax
    176e:	89 c2                	mov    %eax,%edx
    1770:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1773:	8b 40 24             	mov    0x24(%eax),%eax
    1776:	0f af d0             	imul   %eax,%edx
    1779:	89 d0                	mov    %edx,%eax
    177b:	01 c0                	add    %eax,%eax
    177d:	01 c2                	add    %eax,%edx
    177f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1782:	8b 40 38             	mov    0x38(%eax),%eax
    1785:	83 ec 04             	sub    $0x4,%esp
    1788:	52                   	push   %edx
    1789:	68 ff ff ff 00       	push   $0xffffff
    178e:	50                   	push   %eax
    178f:	e8 8d e9 ff ff       	call   121 <memset>
    1794:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1797:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    179a:	c9                   	leave  
    179b:	c3                   	ret    

0000179c <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    179c:	55                   	push   %ebp
    179d:	89 e5                	mov    %esp,%ebp
    179f:	57                   	push   %edi
    17a0:	56                   	push   %esi
    17a1:	53                   	push   %ebx
    17a2:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    17a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17a8:	83 f8 03             	cmp    $0x3,%eax
    17ab:	74 02                	je     17af <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    17ad:	eb 7c                	jmp    182b <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    17af:	8b 45 08             	mov    0x8(%ebp),%eax
    17b2:	8b 58 1c             	mov    0x1c(%eax),%ebx
    17b5:	8b 45 08             	mov    0x8(%ebp),%eax
    17b8:	8b 48 18             	mov    0x18(%eax),%ecx
    17bb:	8b 45 08             	mov    0x8(%ebp),%eax
    17be:	8b 50 5c             	mov    0x5c(%eax),%edx
    17c1:	8b 45 08             	mov    0x8(%ebp),%eax
    17c4:	8b 40 58             	mov    0x58(%eax),%eax
    17c7:	8b 75 08             	mov    0x8(%ebp),%esi
    17ca:	83 c6 58             	add    $0x58,%esi
    17cd:	83 ec 04             	sub    $0x4,%esp
    17d0:	53                   	push   %ebx
    17d1:	51                   	push   %ecx
    17d2:	6a 00                	push   $0x0
    17d4:	52                   	push   %edx
    17d5:	50                   	push   %eax
    17d6:	6a 00                	push   $0x0
    17d8:	6a 00                	push   $0x0
    17da:	56                   	push   %esi
    17db:	6a 00                	push   $0x0
    17dd:	6a 00                	push   $0x0
    17df:	ff 75 08             	pushl  0x8(%ebp)
    17e2:	e8 75 eb ff ff       	call   35c <paintWindow>
    17e7:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    17ea:	8b 45 08             	mov    0x8(%ebp),%eax
    17ed:	8b 70 1c             	mov    0x1c(%eax),%esi
    17f0:	8b 45 08             	mov    0x8(%ebp),%eax
    17f3:	8b 58 18             	mov    0x18(%eax),%ebx
    17f6:	8b 45 08             	mov    0x8(%ebp),%eax
    17f9:	8b 48 08             	mov    0x8(%eax),%ecx
    17fc:	8b 45 08             	mov    0x8(%ebp),%eax
    17ff:	8b 50 40             	mov    0x40(%eax),%edx
    1802:	8b 45 08             	mov    0x8(%ebp),%eax
    1805:	8b 40 3c             	mov    0x3c(%eax),%eax
    1808:	8b 7d 08             	mov    0x8(%ebp),%edi
    180b:	83 c7 3c             	add    $0x3c,%edi
    180e:	83 ec 04             	sub    $0x4,%esp
    1811:	56                   	push   %esi
    1812:	53                   	push   %ebx
    1813:	51                   	push   %ecx
    1814:	52                   	push   %edx
    1815:	50                   	push   %eax
    1816:	6a 00                	push   $0x0
    1818:	6a 00                	push   $0x0
    181a:	57                   	push   %edi
    181b:	6a 32                	push   $0x32
    181d:	6a 00                	push   $0x0
    181f:	ff 75 08             	pushl  0x8(%ebp)
    1822:	e8 35 eb ff ff       	call   35c <paintWindow>
    1827:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    182a:	90                   	nop
        default: break;
            
            
    }
    return False;
    182b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1830:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1833:	5b                   	pop    %ebx
    1834:	5e                   	pop    %esi
    1835:	5f                   	pop    %edi
    1836:	5d                   	pop    %ebp
    1837:	c3                   	ret    

00001838 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1838:	55                   	push   %ebp
    1839:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    183b:	8b 45 0c             	mov    0xc(%ebp),%eax
    183e:	8b 50 08             	mov    0x8(%eax),%edx
    1841:	8b 45 08             	mov    0x8(%ebp),%eax
    1844:	8b 00                	mov    (%eax),%eax
    1846:	39 c2                	cmp    %eax,%edx
    1848:	74 07                	je     1851 <APPreJudge+0x19>
        return False;
    184a:	b8 00 00 00 00       	mov    $0x0,%eax
    184f:	eb 05                	jmp    1856 <APPreJudge+0x1e>
    return True;
    1851:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1856:	5d                   	pop    %ebp
    1857:	c3                   	ret    

00001858 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1858:	55                   	push   %ebp
    1859:	89 e5                	mov    %esp,%ebp
    185b:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    185e:	8b 45 08             	mov    0x8(%ebp),%eax
    1861:	8b 55 0c             	mov    0xc(%ebp),%edx
    1864:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    186a:	83 ec 0c             	sub    $0xc,%esp
    186d:	ff 75 08             	pushl  0x8(%ebp)
    1870:	e8 ff ea ff ff       	call   374 <registWindow>
    1875:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1878:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    187f:	8b 45 08             	mov    0x8(%ebp),%eax
    1882:	8b 00                	mov    (%eax),%eax
    1884:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1887:	ff 75 f4             	pushl  -0xc(%ebp)
    188a:	ff 75 f0             	pushl  -0x10(%ebp)
    188d:	ff 75 ec             	pushl  -0x14(%ebp)
    1890:	ff 75 08             	pushl  0x8(%ebp)
    1893:	e8 80 fc ff ff       	call   1518 <APSendMessage>
    1898:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    189b:	83 ec 0c             	sub    $0xc,%esp
    189e:	ff 75 08             	pushl  0x8(%ebp)
    18a1:	e8 c6 ea ff ff       	call   36c <getMessage>
    18a6:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    18a9:	8b 45 08             	mov    0x8(%ebp),%eax
    18ac:	83 c0 74             	add    $0x74,%eax
    18af:	83 ec 08             	sub    $0x8,%esp
    18b2:	50                   	push   %eax
    18b3:	ff 75 08             	pushl  0x8(%ebp)
    18b6:	e8 7d ff ff ff       	call   1838 <APPreJudge>
    18bb:	83 c4 10             	add    $0x10,%esp
    18be:	84 c0                	test   %al,%al
    18c0:	74 1b                	je     18dd <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    18c2:	8b 45 08             	mov    0x8(%ebp),%eax
    18c5:	ff 70 7c             	pushl  0x7c(%eax)
    18c8:	ff 70 78             	pushl  0x78(%eax)
    18cb:	ff 70 74             	pushl  0x74(%eax)
    18ce:	ff 75 08             	pushl  0x8(%ebp)
    18d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    18d4:	ff d0                	call   *%eax
    18d6:	83 c4 10             	add    $0x10,%esp
    18d9:	84 c0                	test   %al,%al
    18db:	75 0c                	jne    18e9 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    18dd:	8b 45 08             	mov    0x8(%ebp),%eax
    18e0:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    18e7:	eb b2                	jmp    189b <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    18e9:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    18ea:	90                   	nop
    18eb:	c9                   	leave  
    18ec:	c3                   	ret    

000018ed <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    18ed:	55                   	push   %ebp
    18ee:	89 e5                	mov    %esp,%ebp
    18f0:	57                   	push   %edi
    18f1:	56                   	push   %esi
    18f2:	53                   	push   %ebx
    18f3:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    18f6:	a1 44 67 00 00       	mov    0x6744,%eax
    18fb:	85 c0                	test   %eax,%eax
    18fd:	0f 85 2c 02 00 00    	jne    1b2f <APGridPaint+0x242>
    {
        iconReady = 1;
    1903:	c7 05 44 67 00 00 01 	movl   $0x1,0x6744
    190a:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    190d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1910:	83 ec 08             	sub    $0x8,%esp
    1913:	68 8b 24 00 00       	push   $0x248b
    1918:	50                   	push   %eax
    1919:	e8 d3 ef ff ff       	call   8f1 <APLoadBitmap>
    191e:	83 c4 0c             	add    $0xc,%esp
    1921:	8b 45 88             	mov    -0x78(%ebp),%eax
    1924:	a3 68 67 00 00       	mov    %eax,0x6768
    1929:	8b 45 8c             	mov    -0x74(%ebp),%eax
    192c:	a3 6c 67 00 00       	mov    %eax,0x676c
    1931:	8b 45 90             	mov    -0x70(%ebp),%eax
    1934:	a3 70 67 00 00       	mov    %eax,0x6770
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1939:	83 ec 04             	sub    $0x4,%esp
    193c:	ff 35 70 67 00 00    	pushl  0x6770
    1942:	ff 35 6c 67 00 00    	pushl  0x676c
    1948:	ff 35 68 67 00 00    	pushl  0x6768
    194e:	e8 d8 f1 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1953:	83 c4 10             	add    $0x10,%esp
    1956:	a3 74 67 00 00       	mov    %eax,0x6774
        grid_river = APLoadBitmap ("grid_river.bmp");
    195b:	8d 45 88             	lea    -0x78(%ebp),%eax
    195e:	83 ec 08             	sub    $0x8,%esp
    1961:	68 99 24 00 00       	push   $0x2499
    1966:	50                   	push   %eax
    1967:	e8 85 ef ff ff       	call   8f1 <APLoadBitmap>
    196c:	83 c4 0c             	add    $0xc,%esp
    196f:	8b 45 88             	mov    -0x78(%ebp),%eax
    1972:	a3 a4 67 00 00       	mov    %eax,0x67a4
    1977:	8b 45 8c             	mov    -0x74(%ebp),%eax
    197a:	a3 a8 67 00 00       	mov    %eax,0x67a8
    197f:	8b 45 90             	mov    -0x70(%ebp),%eax
    1982:	a3 ac 67 00 00       	mov    %eax,0x67ac
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1987:	83 ec 04             	sub    $0x4,%esp
    198a:	ff 35 ac 67 00 00    	pushl  0x67ac
    1990:	ff 35 a8 67 00 00    	pushl  0x67a8
    1996:	ff 35 a4 67 00 00    	pushl  0x67a4
    199c:	e8 8a f1 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    19a1:	83 c4 10             	add    $0x10,%esp
    19a4:	a3 94 67 00 00       	mov    %eax,0x6794
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    19a9:	8d 45 88             	lea    -0x78(%ebp),%eax
    19ac:	83 ec 08             	sub    $0x8,%esp
    19af:	68 a8 24 00 00       	push   $0x24a8
    19b4:	50                   	push   %eax
    19b5:	e8 37 ef ff ff       	call   8f1 <APLoadBitmap>
    19ba:	83 c4 0c             	add    $0xc,%esp
    19bd:	8b 45 88             	mov    -0x78(%ebp),%eax
    19c0:	a3 98 67 00 00       	mov    %eax,0x6798
    19c5:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19c8:	a3 9c 67 00 00       	mov    %eax,0x679c
    19cd:	8b 45 90             	mov    -0x70(%ebp),%eax
    19d0:	a3 a0 67 00 00       	mov    %eax,0x67a0
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    19d5:	83 ec 04             	sub    $0x4,%esp
    19d8:	ff 35 a0 67 00 00    	pushl  0x67a0
    19de:	ff 35 9c 67 00 00    	pushl  0x679c
    19e4:	ff 35 98 67 00 00    	pushl  0x6798
    19ea:	e8 3c f1 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    19ef:	83 c4 10             	add    $0x10,%esp
    19f2:	a3 48 67 00 00       	mov    %eax,0x6748
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    19f7:	8d 45 88             	lea    -0x78(%ebp),%eax
    19fa:	83 ec 08             	sub    $0x8,%esp
    19fd:	68 b7 24 00 00       	push   $0x24b7
    1a02:	50                   	push   %eax
    1a03:	e8 e9 ee ff ff       	call   8f1 <APLoadBitmap>
    1a08:	83 c4 0c             	add    $0xc,%esp
    1a0b:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a0e:	a3 7c 67 00 00       	mov    %eax,0x677c
    1a13:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a16:	a3 80 67 00 00       	mov    %eax,0x6780
    1a1b:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a1e:	a3 84 67 00 00       	mov    %eax,0x6784
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1a23:	83 ec 04             	sub    $0x4,%esp
    1a26:	ff 35 84 67 00 00    	pushl  0x6784
    1a2c:	ff 35 80 67 00 00    	pushl  0x6780
    1a32:	ff 35 7c 67 00 00    	pushl  0x677c
    1a38:	e8 ee f0 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1a3d:	83 c4 10             	add    $0x10,%esp
    1a40:	a3 b0 67 00 00       	mov    %eax,0x67b0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1a45:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a48:	83 ec 08             	sub    $0x8,%esp
    1a4b:	68 c5 24 00 00       	push   $0x24c5
    1a50:	50                   	push   %eax
    1a51:	e8 9b ee ff ff       	call   8f1 <APLoadBitmap>
    1a56:	83 c4 0c             	add    $0xc,%esp
    1a59:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a5c:	a3 58 67 00 00       	mov    %eax,0x6758
    1a61:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a64:	a3 5c 67 00 00       	mov    %eax,0x675c
    1a69:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a6c:	a3 60 67 00 00       	mov    %eax,0x6760
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a71:	83 ec 04             	sub    $0x4,%esp
    1a74:	ff 35 60 67 00 00    	pushl  0x6760
    1a7a:	ff 35 5c 67 00 00    	pushl  0x675c
    1a80:	ff 35 58 67 00 00    	pushl  0x6758
    1a86:	e8 a0 f0 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1a8b:	83 c4 10             	add    $0x10,%esp
    1a8e:	a3 78 67 00 00       	mov    %eax,0x6778
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a93:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a96:	83 ec 08             	sub    $0x8,%esp
    1a99:	68 d5 24 00 00       	push   $0x24d5
    1a9e:	50                   	push   %eax
    1a9f:	e8 4d ee ff ff       	call   8f1 <APLoadBitmap>
    1aa4:	83 c4 0c             	add    $0xc,%esp
    1aa7:	8b 45 88             	mov    -0x78(%ebp),%eax
    1aaa:	a3 4c 67 00 00       	mov    %eax,0x674c
    1aaf:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ab2:	a3 50 67 00 00       	mov    %eax,0x6750
    1ab7:	8b 45 90             	mov    -0x70(%ebp),%eax
    1aba:	a3 54 67 00 00       	mov    %eax,0x6754
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1abf:	83 ec 04             	sub    $0x4,%esp
    1ac2:	ff 35 54 67 00 00    	pushl  0x6754
    1ac8:	ff 35 50 67 00 00    	pushl  0x6750
    1ace:	ff 35 4c 67 00 00    	pushl  0x674c
    1ad4:	e8 52 f0 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1ad9:	83 c4 10             	add    $0x10,%esp
    1adc:	a3 64 67 00 00       	mov    %eax,0x6764
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1ae1:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ae4:	83 ec 08             	sub    $0x8,%esp
    1ae7:	68 e7 24 00 00       	push   $0x24e7
    1aec:	50                   	push   %eax
    1aed:	e8 ff ed ff ff       	call   8f1 <APLoadBitmap>
    1af2:	83 c4 0c             	add    $0xc,%esp
    1af5:	8b 45 88             	mov    -0x78(%ebp),%eax
    1af8:	a3 88 67 00 00       	mov    %eax,0x6788
    1afd:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b00:	a3 8c 67 00 00       	mov    %eax,0x678c
    1b05:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b08:	a3 90 67 00 00       	mov    %eax,0x6790
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1b0d:	83 ec 04             	sub    $0x4,%esp
    1b10:	ff 35 90 67 00 00    	pushl  0x6790
    1b16:	ff 35 8c 67 00 00    	pushl  0x678c
    1b1c:	ff 35 88 67 00 00    	pushl  0x6788
    1b22:	e8 04 f0 ff ff       	call   b2b <APCreateCompatibleDCFromBitmap>
    1b27:	83 c4 10             	add    $0x10,%esp
    1b2a:	a3 b4 67 00 00       	mov    %eax,0x67b4
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1b2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b32:	8b 40 08             	mov    0x8(%eax),%eax
    1b35:	85 c0                	test   %eax,%eax
    1b37:	75 17                	jne    1b50 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1b39:	83 ec 08             	sub    $0x8,%esp
    1b3c:	68 f8 24 00 00       	push   $0x24f8
    1b41:	6a 01                	push   $0x1
    1b43:	e8 23 e9 ff ff       	call   46b <printf>
    1b48:	83 c4 10             	add    $0x10,%esp
        return;
    1b4b:	e9 07 05 00 00       	jmp    2057 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b50:	8b 45 08             	mov    0x8(%ebp),%eax
    1b53:	8b 40 10             	mov    0x10(%eax),%eax
    1b56:	85 c0                	test   %eax,%eax
    1b58:	7e 10                	jle    1b6a <APGridPaint+0x27d>
    1b5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5d:	8b 50 14             	mov    0x14(%eax),%edx
    1b60:	8b 45 08             	mov    0x8(%ebp),%eax
    1b63:	8b 40 10             	mov    0x10(%eax),%eax
    1b66:	39 c2                	cmp    %eax,%edx
    1b68:	7c 17                	jl     1b81 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b6a:	83 ec 08             	sub    $0x8,%esp
    1b6d:	68 1e 25 00 00       	push   $0x251e
    1b72:	6a 01                	push   $0x1
    1b74:	e8 f2 e8 ff ff       	call   46b <printf>
    1b79:	83 c4 10             	add    $0x10,%esp
        return;
    1b7c:	e9 d6 04 00 00       	jmp    2057 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b81:	8b 45 08             	mov    0x8(%ebp),%eax
    1b84:	8b 40 14             	mov    0x14(%eax),%eax
    1b87:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b8d:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b90:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b93:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b96:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b9d:	e9 96 03 00 00       	jmp    1f38 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ba2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1ba9:	e9 7c 03 00 00       	jmp    1f2a <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1bae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bb1:	c1 e0 04             	shl    $0x4,%eax
    1bb4:	89 c2                	mov    %eax,%edx
    1bb6:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bb9:	01 c2                	add    %eax,%edx
    1bbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bbe:	01 d0                	add    %edx,%eax
    1bc0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1bc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc6:	8b 40 0c             	mov    0xc(%eax),%eax
    1bc9:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1bcc:	c1 e2 02             	shl    $0x2,%edx
    1bcf:	01 d0                	add    %edx,%eax
    1bd1:	8b 00                	mov    (%eax),%eax
    1bd3:	83 f8 07             	cmp    $0x7,%eax
    1bd6:	0f 87 49 03 00 00    	ja     1f25 <APGridPaint+0x638>
    1bdc:	8b 04 85 34 25 00 00 	mov    0x2534(,%eax,4),%eax
    1be3:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1be5:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1be8:	6a 0c                	push   $0xc
    1bea:	6a 0c                	push   $0xc
    1bec:	6a 0c                	push   $0xc
    1bee:	50                   	push   %eax
    1bef:	e8 df f8 ff ff       	call   14d3 <RGB>
    1bf4:	83 c4 0c             	add    $0xc,%esp
    1bf7:	8b 1d 74 67 00 00    	mov    0x6774,%ebx
    1bfd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c00:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c03:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c06:	6b c0 32             	imul   $0x32,%eax,%eax
    1c09:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1c0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0f:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c12:	83 ec 0c             	sub    $0xc,%esp
    1c15:	83 ec 04             	sub    $0x4,%esp
    1c18:	89 e0                	mov    %esp,%eax
    1c1a:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1c1e:	66 89 30             	mov    %si,(%eax)
    1c21:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1c25:	88 50 02             	mov    %dl,0x2(%eax)
    1c28:	6a 32                	push   $0x32
    1c2a:	6a 32                	push   $0x32
    1c2c:	6a 00                	push   $0x0
    1c2e:	6a 00                	push   $0x0
    1c30:	53                   	push   %ebx
    1c31:	51                   	push   %ecx
    1c32:	ff 75 84             	pushl  -0x7c(%ebp)
    1c35:	57                   	push   %edi
    1c36:	e8 f4 f6 ff ff       	call   132f <APDcCopy>
    1c3b:	83 c4 30             	add    $0x30,%esp
                    break;
    1c3e:	e9 e3 02 00 00       	jmp    1f26 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c43:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c46:	6a 69                	push   $0x69
    1c48:	6a 69                	push   $0x69
    1c4a:	6a 69                	push   $0x69
    1c4c:	50                   	push   %eax
    1c4d:	e8 81 f8 ff ff       	call   14d3 <RGB>
    1c52:	83 c4 0c             	add    $0xc,%esp
    1c55:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c59:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1c5d:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c61:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1c64:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c6b:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c6e:	6a 69                	push   $0x69
    1c70:	6a 69                	push   $0x69
    1c72:	6a 69                	push   $0x69
    1c74:	50                   	push   %eax
    1c75:	e8 59 f8 ff ff       	call   14d3 <RGB>
    1c7a:	83 c4 0c             	add    $0xc,%esp
    1c7d:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1c81:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1c85:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c89:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c8c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8f:	8d 50 3c             	lea    0x3c(%eax),%edx
    1c92:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c95:	ff 75 ac             	pushl  -0x54(%ebp)
    1c98:	ff 75 a8             	pushl  -0x58(%ebp)
    1c9b:	52                   	push   %edx
    1c9c:	50                   	push   %eax
    1c9d:	e8 1e ef ff ff       	call   bc0 <APSetPen>
    1ca2:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ca5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca8:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1cab:	8d 55 88             	lea    -0x78(%ebp),%edx
    1cae:	83 ec 04             	sub    $0x4,%esp
    1cb1:	83 ec 04             	sub    $0x4,%esp
    1cb4:	89 e0                	mov    %esp,%eax
    1cb6:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1cba:	66 89 08             	mov    %cx,(%eax)
    1cbd:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1cc1:	88 48 02             	mov    %cl,0x2(%eax)
    1cc4:	53                   	push   %ebx
    1cc5:	52                   	push   %edx
    1cc6:	e8 2e ef ff ff       	call   bf9 <APSetBrush>
    1ccb:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1cce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd1:	6b d0 32             	imul   $0x32,%eax,%edx
    1cd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cd7:	6b c0 32             	imul   $0x32,%eax,%eax
    1cda:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cdd:	83 c1 3c             	add    $0x3c,%ecx
    1ce0:	83 ec 0c             	sub    $0xc,%esp
    1ce3:	6a 32                	push   $0x32
    1ce5:	6a 32                	push   $0x32
    1ce7:	52                   	push   %edx
    1ce8:	50                   	push   %eax
    1ce9:	51                   	push   %ecx
    1cea:	e8 34 f3 ff ff       	call   1023 <APDrawRect>
    1cef:	83 c4 20             	add    $0x20,%esp
                    break;
    1cf2:	e9 2f 02 00 00       	jmp    1f26 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cf7:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1cfa:	6a 0c                	push   $0xc
    1cfc:	6a 0c                	push   $0xc
    1cfe:	6a 0c                	push   $0xc
    1d00:	50                   	push   %eax
    1d01:	e8 cd f7 ff ff       	call   14d3 <RGB>
    1d06:	83 c4 0c             	add    $0xc,%esp
    1d09:	8b 1d b4 67 00 00    	mov    0x67b4,%ebx
    1d0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d12:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d15:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d18:	6b c0 32             	imul   $0x32,%eax,%eax
    1d1b:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d21:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d24:	83 ec 0c             	sub    $0xc,%esp
    1d27:	83 ec 04             	sub    $0x4,%esp
    1d2a:	89 e0                	mov    %esp,%eax
    1d2c:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1d30:	66 89 30             	mov    %si,(%eax)
    1d33:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1d37:	88 50 02             	mov    %dl,0x2(%eax)
    1d3a:	6a 32                	push   $0x32
    1d3c:	6a 32                	push   $0x32
    1d3e:	6a 00                	push   $0x0
    1d40:	6a 00                	push   $0x0
    1d42:	53                   	push   %ebx
    1d43:	51                   	push   %ecx
    1d44:	ff 75 84             	pushl  -0x7c(%ebp)
    1d47:	57                   	push   %edi
    1d48:	e8 e2 f5 ff ff       	call   132f <APDcCopy>
    1d4d:	83 c4 30             	add    $0x30,%esp
                    break;
    1d50:	e9 d1 01 00 00       	jmp    1f26 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d55:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d58:	6a 0c                	push   $0xc
    1d5a:	6a 0c                	push   $0xc
    1d5c:	6a 0c                	push   $0xc
    1d5e:	50                   	push   %eax
    1d5f:	e8 6f f7 ff ff       	call   14d3 <RGB>
    1d64:	83 c4 0c             	add    $0xc,%esp
    1d67:	8b 1d 94 67 00 00    	mov    0x6794,%ebx
    1d6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d70:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d73:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d76:	6b c0 32             	imul   $0x32,%eax,%eax
    1d79:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1d7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7f:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d82:	83 ec 0c             	sub    $0xc,%esp
    1d85:	83 ec 04             	sub    $0x4,%esp
    1d88:	89 e0                	mov    %esp,%eax
    1d8a:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d8e:	66 89 30             	mov    %si,(%eax)
    1d91:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1d95:	88 50 02             	mov    %dl,0x2(%eax)
    1d98:	6a 32                	push   $0x32
    1d9a:	6a 32                	push   $0x32
    1d9c:	6a 00                	push   $0x0
    1d9e:	6a 00                	push   $0x0
    1da0:	53                   	push   %ebx
    1da1:	51                   	push   %ecx
    1da2:	ff 75 84             	pushl  -0x7c(%ebp)
    1da5:	57                   	push   %edi
    1da6:	e8 84 f5 ff ff       	call   132f <APDcCopy>
    1dab:	83 c4 30             	add    $0x30,%esp
                    break;
    1dae:	e9 73 01 00 00       	jmp    1f26 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1db3:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1db6:	6a 0c                	push   $0xc
    1db8:	6a 0c                	push   $0xc
    1dba:	6a 0c                	push   $0xc
    1dbc:	50                   	push   %eax
    1dbd:	e8 11 f7 ff ff       	call   14d3 <RGB>
    1dc2:	83 c4 0c             	add    $0xc,%esp
    1dc5:	8b 1d 78 67 00 00    	mov    0x6778,%ebx
    1dcb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dce:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dd4:	6b c0 32             	imul   $0x32,%eax,%eax
    1dd7:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1dda:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddd:	8d 78 3c             	lea    0x3c(%eax),%edi
    1de0:	83 ec 0c             	sub    $0xc,%esp
    1de3:	83 ec 04             	sub    $0x4,%esp
    1de6:	89 e0                	mov    %esp,%eax
    1de8:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1dec:	66 89 30             	mov    %si,(%eax)
    1def:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1df3:	88 50 02             	mov    %dl,0x2(%eax)
    1df6:	6a 32                	push   $0x32
    1df8:	6a 32                	push   $0x32
    1dfa:	6a 00                	push   $0x0
    1dfc:	6a 00                	push   $0x0
    1dfe:	53                   	push   %ebx
    1dff:	51                   	push   %ecx
    1e00:	ff 75 84             	pushl  -0x7c(%ebp)
    1e03:	57                   	push   %edi
    1e04:	e8 26 f5 ff ff       	call   132f <APDcCopy>
    1e09:	83 c4 30             	add    $0x30,%esp
                    break;
    1e0c:	e9 15 01 00 00       	jmp    1f26 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e11:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1e14:	6a 0c                	push   $0xc
    1e16:	6a 0c                	push   $0xc
    1e18:	6a 0c                	push   $0xc
    1e1a:	50                   	push   %eax
    1e1b:	e8 b3 f6 ff ff       	call   14d3 <RGB>
    1e20:	83 c4 0c             	add    $0xc,%esp
    1e23:	8b 1d b0 67 00 00    	mov    0x67b0,%ebx
    1e29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e2c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e32:	6b c0 32             	imul   $0x32,%eax,%eax
    1e35:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e38:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e3e:	83 ec 0c             	sub    $0xc,%esp
    1e41:	83 ec 04             	sub    $0x4,%esp
    1e44:	89 e0                	mov    %esp,%eax
    1e46:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1e4a:	66 89 30             	mov    %si,(%eax)
    1e4d:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1e51:	88 50 02             	mov    %dl,0x2(%eax)
    1e54:	6a 32                	push   $0x32
    1e56:	6a 32                	push   $0x32
    1e58:	6a 00                	push   $0x0
    1e5a:	6a 00                	push   $0x0
    1e5c:	53                   	push   %ebx
    1e5d:	51                   	push   %ecx
    1e5e:	ff 75 84             	pushl  -0x7c(%ebp)
    1e61:	57                   	push   %edi
    1e62:	e8 c8 f4 ff ff       	call   132f <APDcCopy>
    1e67:	83 c4 30             	add    $0x30,%esp
                    break;
    1e6a:	e9 b7 00 00 00       	jmp    1f26 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e6f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e72:	6a 0c                	push   $0xc
    1e74:	6a 0c                	push   $0xc
    1e76:	6a 0c                	push   $0xc
    1e78:	50                   	push   %eax
    1e79:	e8 55 f6 ff ff       	call   14d3 <RGB>
    1e7e:	83 c4 0c             	add    $0xc,%esp
    1e81:	8b 1d 48 67 00 00    	mov    0x6748,%ebx
    1e87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e8a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e90:	6b c0 32             	imul   $0x32,%eax,%eax
    1e93:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e96:	8b 45 08             	mov    0x8(%ebp),%eax
    1e99:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e9c:	83 ec 0c             	sub    $0xc,%esp
    1e9f:	83 ec 04             	sub    $0x4,%esp
    1ea2:	89 e0                	mov    %esp,%eax
    1ea4:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1ea8:	66 89 30             	mov    %si,(%eax)
    1eab:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1eaf:	88 50 02             	mov    %dl,0x2(%eax)
    1eb2:	6a 32                	push   $0x32
    1eb4:	6a 32                	push   $0x32
    1eb6:	6a 00                	push   $0x0
    1eb8:	6a 00                	push   $0x0
    1eba:	53                   	push   %ebx
    1ebb:	51                   	push   %ecx
    1ebc:	ff 75 84             	pushl  -0x7c(%ebp)
    1ebf:	57                   	push   %edi
    1ec0:	e8 6a f4 ff ff       	call   132f <APDcCopy>
    1ec5:	83 c4 30             	add    $0x30,%esp
                    break;
    1ec8:	eb 5c                	jmp    1f26 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1eca:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ecd:	6a 0c                	push   $0xc
    1ecf:	6a 0c                	push   $0xc
    1ed1:	6a 0c                	push   $0xc
    1ed3:	50                   	push   %eax
    1ed4:	e8 fa f5 ff ff       	call   14d3 <RGB>
    1ed9:	83 c4 0c             	add    $0xc,%esp
    1edc:	8b 1d 64 67 00 00    	mov    0x6764,%ebx
    1ee2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ee5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ee8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eeb:	6b c0 32             	imul   $0x32,%eax,%eax
    1eee:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ef1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef4:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ef7:	83 ec 0c             	sub    $0xc,%esp
    1efa:	83 ec 04             	sub    $0x4,%esp
    1efd:	89 e0                	mov    %esp,%eax
    1eff:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1f03:	66 89 30             	mov    %si,(%eax)
    1f06:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1f0a:	88 50 02             	mov    %dl,0x2(%eax)
    1f0d:	6a 32                	push   $0x32
    1f0f:	6a 32                	push   $0x32
    1f11:	6a 00                	push   $0x0
    1f13:	6a 00                	push   $0x0
    1f15:	53                   	push   %ebx
    1f16:	51                   	push   %ecx
    1f17:	ff 75 84             	pushl  -0x7c(%ebp)
    1f1a:	57                   	push   %edi
    1f1b:	e8 0f f4 ff ff       	call   132f <APDcCopy>
    1f20:	83 c4 30             	add    $0x30,%esp
                    break;
    1f23:	eb 01                	jmp    1f26 <APGridPaint+0x639>
                default: break;
    1f25:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f26:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1f2a:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1f2e:	0f 8e 7a fc ff ff    	jle    1bae <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f34:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1f38:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1f3c:	0f 8e 60 fc ff ff    	jle    1ba2 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1f42:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f45:	68 cd 00 00 00       	push   $0xcd
    1f4a:	6a 74                	push   $0x74
    1f4c:	6a 18                	push   $0x18
    1f4e:	50                   	push   %eax
    1f4f:	e8 7f f5 ff ff       	call   14d3 <RGB>
    1f54:	83 c4 0c             	add    $0xc,%esp
    1f57:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f5b:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1f5f:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f63:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f66:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f6d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f70:	68 cd 00 00 00       	push   $0xcd
    1f75:	6a 74                	push   $0x74
    1f77:	6a 18                	push   $0x18
    1f79:	50                   	push   %eax
    1f7a:	e8 54 f5 ff ff       	call   14d3 <RGB>
    1f7f:	83 c4 0c             	add    $0xc,%esp
    1f82:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f86:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1f8a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f8e:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1f91:	8b 45 08             	mov    0x8(%ebp),%eax
    1f94:	8d 50 58             	lea    0x58(%eax),%edx
    1f97:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f9a:	ff 75 bc             	pushl  -0x44(%ebp)
    1f9d:	ff 75 b8             	pushl  -0x48(%ebp)
    1fa0:	52                   	push   %edx
    1fa1:	50                   	push   %eax
    1fa2:	e8 19 ec ff ff       	call   bc0 <APSetPen>
    1fa7:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1faa:	8b 45 08             	mov    0x8(%ebp),%eax
    1fad:	8d 58 58             	lea    0x58(%eax),%ebx
    1fb0:	8d 55 88             	lea    -0x78(%ebp),%edx
    1fb3:	83 ec 04             	sub    $0x4,%esp
    1fb6:	83 ec 04             	sub    $0x4,%esp
    1fb9:	89 e0                	mov    %esp,%eax
    1fbb:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1fbf:	66 89 08             	mov    %cx,(%eax)
    1fc2:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1fc6:	88 48 02             	mov    %cl,0x2(%eax)
    1fc9:	53                   	push   %ebx
    1fca:	52                   	push   %edx
    1fcb:	e8 29 ec ff ff       	call   bf9 <APSetBrush>
    1fd0:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1fd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd6:	83 c0 58             	add    $0x58,%eax
    1fd9:	83 ec 0c             	sub    $0xc,%esp
    1fdc:	6a 32                	push   $0x32
    1fde:	68 20 03 00 00       	push   $0x320
    1fe3:	6a 00                	push   $0x0
    1fe5:	6a 00                	push   $0x0
    1fe7:	50                   	push   %eax
    1fe8:	e8 36 f0 ff ff       	call   1023 <APDrawRect>
    1fed:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1ff0:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ff3:	6a 08                	push   $0x8
    1ff5:	6a 08                	push   $0x8
    1ff7:	6a 08                	push   $0x8
    1ff9:	50                   	push   %eax
    1ffa:	e8 d4 f4 ff ff       	call   14d3 <RGB>
    1fff:	83 c4 0c             	add    $0xc,%esp
    2002:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2006:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    200a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    200e:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    2011:	8b 45 08             	mov    0x8(%ebp),%eax
    2014:	8d 58 58             	lea    0x58(%eax),%ebx
    2017:	8d 55 88             	lea    -0x78(%ebp),%edx
    201a:	83 ec 04             	sub    $0x4,%esp
    201d:	83 ec 04             	sub    $0x4,%esp
    2020:	89 e0                	mov    %esp,%eax
    2022:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2026:	66 89 08             	mov    %cx,(%eax)
    2029:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    202d:	88 48 02             	mov    %cl,0x2(%eax)
    2030:	53                   	push   %ebx
    2031:	52                   	push   %edx
    2032:	e8 04 ec ff ff       	call   c3b <APSetFont>
    2037:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    203a:	8b 45 08             	mov    0x8(%ebp),%eax
    203d:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2043:	8b 45 08             	mov    0x8(%ebp),%eax
    2046:	83 c0 58             	add    $0x58,%eax
    2049:	6a 14                	push   $0x14
    204b:	6a 14                	push   $0x14
    204d:	52                   	push   %edx
    204e:	50                   	push   %eax
    204f:	e8 d4 f1 ff ff       	call   1228 <APDrawText>
    2054:	83 c4 10             	add    $0x10,%esp
}
    2057:	8d 65 f4             	lea    -0xc(%ebp),%esp
    205a:	5b                   	pop    %ebx
    205b:	5e                   	pop    %esi
    205c:	5f                   	pop    %edi
    205d:	5d                   	pop    %ebp
    205e:	c3                   	ret    

0000205f <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    205f:	55                   	push   %ebp
    2060:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2062:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2066:	7e 08                	jle    2070 <random+0x11>
{
rand_num = seed;
    2068:	8b 45 08             	mov    0x8(%ebp),%eax
    206b:	a3 20 67 00 00       	mov    %eax,0x6720
}
rand_num *= 3;
    2070:	8b 15 20 67 00 00    	mov    0x6720,%edx
    2076:	89 d0                	mov    %edx,%eax
    2078:	01 c0                	add    %eax,%eax
    207a:	01 d0                	add    %edx,%eax
    207c:	a3 20 67 00 00       	mov    %eax,0x6720
if (rand_num < 0)
    2081:	a1 20 67 00 00       	mov    0x6720,%eax
    2086:	85 c0                	test   %eax,%eax
    2088:	79 0c                	jns    2096 <random+0x37>
{
rand_num *= (-1);
    208a:	a1 20 67 00 00       	mov    0x6720,%eax
    208f:	f7 d8                	neg    %eax
    2091:	a3 20 67 00 00       	mov    %eax,0x6720
}
return rand_num % 997;
    2096:	8b 0d 20 67 00 00    	mov    0x6720,%ecx
    209c:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    20a1:	89 c8                	mov    %ecx,%eax
    20a3:	f7 ea                	imul   %edx
    20a5:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    20a8:	c1 f8 09             	sar    $0x9,%eax
    20ab:	89 c2                	mov    %eax,%edx
    20ad:	89 c8                	mov    %ecx,%eax
    20af:	c1 f8 1f             	sar    $0x1f,%eax
    20b2:	29 c2                	sub    %eax,%edx
    20b4:	89 d0                	mov    %edx,%eax
    20b6:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    20bc:	29 c1                	sub    %eax,%ecx
    20be:	89 c8                	mov    %ecx,%eax
}
    20c0:	5d                   	pop    %ebp
    20c1:	c3                   	ret    

000020c2 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    20c2:	55                   	push   %ebp
    20c3:	89 e5                	mov    %esp,%ebp
    20c5:	53                   	push   %ebx
    20c6:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    20c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    20d0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    20d4:	74 17                	je     20ed <sprintint+0x2b>
    20d6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    20da:	79 11                	jns    20ed <sprintint+0x2b>
        neg = 1;
    20dc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    20e3:	8b 45 10             	mov    0x10(%ebp),%eax
    20e6:	f7 d8                	neg    %eax
    20e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20eb:	eb 06                	jmp    20f3 <sprintint+0x31>
    } else {
        x = xx;
    20ed:	8b 45 10             	mov    0x10(%ebp),%eax
    20f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    20f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    20fa:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    20fd:	8d 41 01             	lea    0x1(%ecx),%eax
    2100:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2103:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2106:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2109:	ba 00 00 00 00       	mov    $0x0,%edx
    210e:	f7 f3                	div    %ebx
    2110:	89 d0                	mov    %edx,%eax
    2112:	0f b6 80 24 67 00 00 	movzbl 0x6724(%eax),%eax
    2119:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    211d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2120:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2123:	ba 00 00 00 00       	mov    $0x0,%edx
    2128:	f7 f3                	div    %ebx
    212a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    212d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2131:	75 c7                	jne    20fa <sprintint+0x38>
    if(neg)
    2133:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2137:	74 0e                	je     2147 <sprintint+0x85>
        buf[i++] = '-';
    2139:	8b 45 f8             	mov    -0x8(%ebp),%eax
    213c:	8d 50 01             	lea    0x1(%eax),%edx
    213f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2142:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2147:	8b 45 f8             	mov    -0x8(%ebp),%eax
    214a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    214d:	eb 1b                	jmp    216a <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    214f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2152:	8b 00                	mov    (%eax),%eax
    2154:	8d 48 01             	lea    0x1(%eax),%ecx
    2157:	8b 55 0c             	mov    0xc(%ebp),%edx
    215a:	89 0a                	mov    %ecx,(%edx)
    215c:	89 c2                	mov    %eax,%edx
    215e:	8b 45 08             	mov    0x8(%ebp),%eax
    2161:	01 d0                	add    %edx,%eax
    2163:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2166:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    216a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    216e:	7f df                	jg     214f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2170:	eb 21                	jmp    2193 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2172:	8b 45 0c             	mov    0xc(%ebp),%eax
    2175:	8b 00                	mov    (%eax),%eax
    2177:	8d 48 01             	lea    0x1(%eax),%ecx
    217a:	8b 55 0c             	mov    0xc(%ebp),%edx
    217d:	89 0a                	mov    %ecx,(%edx)
    217f:	89 c2                	mov    %eax,%edx
    2181:	8b 45 08             	mov    0x8(%ebp),%eax
    2184:	01 c2                	add    %eax,%edx
    2186:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2189:	8b 45 f8             	mov    -0x8(%ebp),%eax
    218c:	01 c8                	add    %ecx,%eax
    218e:	0f b6 00             	movzbl (%eax),%eax
    2191:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2193:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2197:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    219b:	79 d5                	jns    2172 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    219d:	90                   	nop
    219e:	83 c4 20             	add    $0x20,%esp
    21a1:	5b                   	pop    %ebx
    21a2:	5d                   	pop    %ebp
    21a3:	c3                   	ret    

000021a4 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    21a4:	55                   	push   %ebp
    21a5:	89 e5                	mov    %esp,%ebp
    21a7:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    21aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    21b1:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    21b8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    21bf:	8d 45 0c             	lea    0xc(%ebp),%eax
    21c2:	83 c0 04             	add    $0x4,%eax
    21c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    21c8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    21cf:	e9 d9 01 00 00       	jmp    23ad <sprintf+0x209>
        c = fmt[i] & 0xff;
    21d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    21d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21da:	01 d0                	add    %edx,%eax
    21dc:	0f b6 00             	movzbl (%eax),%eax
    21df:	0f be c0             	movsbl %al,%eax
    21e2:	25 ff 00 00 00       	and    $0xff,%eax
    21e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    21ea:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    21ee:	75 2c                	jne    221c <sprintf+0x78>
            if(c == '%'){
    21f0:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    21f4:	75 0c                	jne    2202 <sprintf+0x5e>
                state = '%';
    21f6:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    21fd:	e9 a7 01 00 00       	jmp    23a9 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2202:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2205:	8d 50 01             	lea    0x1(%eax),%edx
    2208:	89 55 c8             	mov    %edx,-0x38(%ebp)
    220b:	89 c2                	mov    %eax,%edx
    220d:	8b 45 08             	mov    0x8(%ebp),%eax
    2210:	01 d0                	add    %edx,%eax
    2212:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2215:	88 10                	mov    %dl,(%eax)
    2217:	e9 8d 01 00 00       	jmp    23a9 <sprintf+0x205>
            }
        } else if(state == '%'){
    221c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2220:	0f 85 83 01 00 00    	jne    23a9 <sprintf+0x205>
            if(c == 'd'){
    2226:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    222a:	75 4c                	jne    2278 <sprintf+0xd4>
                buf[bi] = '\0';
    222c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    222f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2232:	01 d0                	add    %edx,%eax
    2234:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2237:	83 ec 0c             	sub    $0xc,%esp
    223a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    223d:	50                   	push   %eax
    223e:	e8 e7 df ff ff       	call   22a <atoi>
    2243:	83 c4 10             	add    $0x10,%esp
    2246:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2249:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2250:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2253:	8b 00                	mov    (%eax),%eax
    2255:	83 ec 08             	sub    $0x8,%esp
    2258:	ff 75 d8             	pushl  -0x28(%ebp)
    225b:	6a 01                	push   $0x1
    225d:	6a 0a                	push   $0xa
    225f:	50                   	push   %eax
    2260:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2263:	50                   	push   %eax
    2264:	ff 75 08             	pushl  0x8(%ebp)
    2267:	e8 56 fe ff ff       	call   20c2 <sprintint>
    226c:	83 c4 20             	add    $0x20,%esp
                ap++;
    226f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2273:	e9 2a 01 00 00       	jmp    23a2 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2278:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    227c:	74 06                	je     2284 <sprintf+0xe0>
    227e:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2282:	75 4c                	jne    22d0 <sprintf+0x12c>
                buf[bi] = '\0';
    2284:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2287:	8b 45 f0             	mov    -0x10(%ebp),%eax
    228a:	01 d0                	add    %edx,%eax
    228c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    228f:	83 ec 0c             	sub    $0xc,%esp
    2292:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2295:	50                   	push   %eax
    2296:	e8 8f df ff ff       	call   22a <atoi>
    229b:	83 c4 10             	add    $0x10,%esp
    229e:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    22a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    22a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22ab:	8b 00                	mov    (%eax),%eax
    22ad:	83 ec 08             	sub    $0x8,%esp
    22b0:	ff 75 dc             	pushl  -0x24(%ebp)
    22b3:	6a 00                	push   $0x0
    22b5:	6a 10                	push   $0x10
    22b7:	50                   	push   %eax
    22b8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    22bb:	50                   	push   %eax
    22bc:	ff 75 08             	pushl  0x8(%ebp)
    22bf:	e8 fe fd ff ff       	call   20c2 <sprintint>
    22c4:	83 c4 20             	add    $0x20,%esp
                ap++;
    22c7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    22cb:	e9 d2 00 00 00       	jmp    23a2 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    22d0:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    22d4:	75 46                	jne    231c <sprintf+0x178>
                s = (char*)*ap;
    22d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22d9:	8b 00                	mov    (%eax),%eax
    22db:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    22de:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    22e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22e6:	75 25                	jne    230d <sprintf+0x169>
                    s = "(null)";
    22e8:	c7 45 f4 54 25 00 00 	movl   $0x2554,-0xc(%ebp)
                while(*s != 0){
    22ef:	eb 1c                	jmp    230d <sprintf+0x169>
                    dst[j++] = *s;
    22f1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22f4:	8d 50 01             	lea    0x1(%eax),%edx
    22f7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22fa:	89 c2                	mov    %eax,%edx
    22fc:	8b 45 08             	mov    0x8(%ebp),%eax
    22ff:	01 c2                	add    %eax,%edx
    2301:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2304:	0f b6 00             	movzbl (%eax),%eax
    2307:	88 02                	mov    %al,(%edx)
                    s++;
    2309:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    230d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2310:	0f b6 00             	movzbl (%eax),%eax
    2313:	84 c0                	test   %al,%al
    2315:	75 da                	jne    22f1 <sprintf+0x14d>
    2317:	e9 86 00 00 00       	jmp    23a2 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    231c:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2320:	75 1d                	jne    233f <sprintf+0x19b>
                dst[j++] = *ap;
    2322:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2325:	8d 50 01             	lea    0x1(%eax),%edx
    2328:	89 55 c8             	mov    %edx,-0x38(%ebp)
    232b:	89 c2                	mov    %eax,%edx
    232d:	8b 45 08             	mov    0x8(%ebp),%eax
    2330:	01 c2                	add    %eax,%edx
    2332:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2335:	8b 00                	mov    (%eax),%eax
    2337:	88 02                	mov    %al,(%edx)
                ap++;
    2339:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    233d:	eb 63                	jmp    23a2 <sprintf+0x1fe>
            } else if(c == '%'){
    233f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2343:	75 17                	jne    235c <sprintf+0x1b8>
                dst[j++] = c;
    2345:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2348:	8d 50 01             	lea    0x1(%eax),%edx
    234b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    234e:	89 c2                	mov    %eax,%edx
    2350:	8b 45 08             	mov    0x8(%ebp),%eax
    2353:	01 d0                	add    %edx,%eax
    2355:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2358:	88 10                	mov    %dl,(%eax)
    235a:	eb 46                	jmp    23a2 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    235c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2360:	7e 18                	jle    237a <sprintf+0x1d6>
    2362:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2366:	7f 12                	jg     237a <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2368:	8b 45 f0             	mov    -0x10(%ebp),%eax
    236b:	8d 50 01             	lea    0x1(%eax),%edx
    236e:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2371:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2374:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2378:	eb 2f                	jmp    23a9 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    237a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    237d:	8d 50 01             	lea    0x1(%eax),%edx
    2380:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2383:	89 c2                	mov    %eax,%edx
    2385:	8b 45 08             	mov    0x8(%ebp),%eax
    2388:	01 d0                	add    %edx,%eax
    238a:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    238d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2390:	8d 50 01             	lea    0x1(%eax),%edx
    2393:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2396:	89 c2                	mov    %eax,%edx
    2398:	8b 45 08             	mov    0x8(%ebp),%eax
    239b:	01 d0                	add    %edx,%eax
    239d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23a0:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    23a2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    23a9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    23ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    23b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23b3:	01 d0                	add    %edx,%eax
    23b5:	0f b6 00             	movzbl (%eax),%eax
    23b8:	84 c0                	test   %al,%al
    23ba:	0f 85 14 fe ff ff    	jne    21d4 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    23c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23c3:	8d 50 01             	lea    0x1(%eax),%edx
    23c6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23c9:	89 c2                	mov    %eax,%edx
    23cb:	8b 45 08             	mov    0x8(%ebp),%eax
    23ce:	01 d0                	add    %edx,%eax
    23d0:	c6 00 00             	movb   $0x0,(%eax)
}
    23d3:	90                   	nop
    23d4:	c9                   	leave  
    23d5:	c3                   	ret    
