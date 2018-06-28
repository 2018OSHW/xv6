
_cat：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
       6:	eb 15                	jmp    1d <cat+0x1d>
    write(1, buf, n);
       8:	83 ec 04             	sub    $0x4,%esp
       b:	ff 75 f4             	pushl  -0xc(%ebp)
       e:	68 40 2a 00 00       	push   $0x2a40
      13:	6a 01                	push   $0x1
      15:	e8 6c 03 00 00       	call   386 <write>
      1a:	83 c4 10             	add    $0x10,%esp
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
      1d:	83 ec 04             	sub    $0x4,%esp
      20:	68 00 02 00 00       	push   $0x200
      25:	68 40 2a 00 00       	push   $0x2a40
      2a:	ff 75 08             	pushl  0x8(%ebp)
      2d:	e8 4c 03 00 00       	call   37e <read>
      32:	83 c4 10             	add    $0x10,%esp
      35:	89 45 f4             	mov    %eax,-0xc(%ebp)
      38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      3c:	7f ca                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
      3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      42:	79 17                	jns    5b <cat+0x5b>
    printf(1, "cat: read error\n");
      44:	83 ec 08             	sub    $0x8,%esp
      47:	68 c8 22 00 00       	push   $0x22c8
      4c:	6a 01                	push   $0x1
      4e:	e8 b2 04 00 00       	call   505 <printf>
      53:	83 c4 10             	add    $0x10,%esp
    exit();
      56:	e8 0b 03 00 00       	call   366 <exit>
  }
}
      5b:	90                   	nop
      5c:	c9                   	leave  
      5d:	c3                   	ret    

0000005e <main>:

int
main(int argc, char *argv[])
{
      5e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      62:	83 e4 f0             	and    $0xfffffff0,%esp
      65:	ff 71 fc             	pushl  -0x4(%ecx)
      68:	55                   	push   %ebp
      69:	89 e5                	mov    %esp,%ebp
      6b:	53                   	push   %ebx
      6c:	51                   	push   %ecx
      6d:	83 ec 10             	sub    $0x10,%esp
      70:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
      72:	83 3b 01             	cmpl   $0x1,(%ebx)
      75:	7f 12                	jg     89 <main+0x2b>
    cat(0);
      77:	83 ec 0c             	sub    $0xc,%esp
      7a:	6a 00                	push   $0x0
      7c:	e8 7f ff ff ff       	call   0 <cat>
      81:	83 c4 10             	add    $0x10,%esp
    exit();
      84:	e8 dd 02 00 00       	call   366 <exit>
  }

  for(i = 1; i < argc; i++){
      89:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      90:	eb 71                	jmp    103 <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
      92:	8b 45 f4             	mov    -0xc(%ebp),%eax
      95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      9c:	8b 43 04             	mov    0x4(%ebx),%eax
      9f:	01 d0                	add    %edx,%eax
      a1:	8b 00                	mov    (%eax),%eax
      a3:	83 ec 08             	sub    $0x8,%esp
      a6:	6a 00                	push   $0x0
      a8:	50                   	push   %eax
      a9:	e8 f8 02 00 00       	call   3a6 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
      b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      b8:	79 29                	jns    e3 <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
      ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
      bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      c4:	8b 43 04             	mov    0x4(%ebx),%eax
      c7:	01 d0                	add    %edx,%eax
      c9:	8b 00                	mov    (%eax),%eax
      cb:	83 ec 04             	sub    $0x4,%esp
      ce:	50                   	push   %eax
      cf:	68 d9 22 00 00       	push   $0x22d9
      d4:	6a 01                	push   $0x1
      d6:	e8 2a 04 00 00       	call   505 <printf>
      db:	83 c4 10             	add    $0x10,%esp
      exit();
      de:	e8 83 02 00 00       	call   366 <exit>
    }
    cat(fd);
      e3:	83 ec 0c             	sub    $0xc,%esp
      e6:	ff 75 f0             	pushl  -0x10(%ebp)
      e9:	e8 12 ff ff ff       	call   0 <cat>
      ee:	83 c4 10             	add    $0x10,%esp
    close(fd);
      f1:	83 ec 0c             	sub    $0xc,%esp
      f4:	ff 75 f0             	pushl  -0x10(%ebp)
      f7:	e8 92 02 00 00       	call   38e <close>
      fc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
      ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     103:	8b 45 f4             	mov    -0xc(%ebp),%eax
     106:	3b 03                	cmp    (%ebx),%eax
     108:	7c 88                	jl     92 <main+0x34>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
     10a:	e8 57 02 00 00       	call   366 <exit>

0000010f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     10f:	55                   	push   %ebp
     110:	89 e5                	mov    %esp,%ebp
     112:	57                   	push   %edi
     113:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     114:	8b 4d 08             	mov    0x8(%ebp),%ecx
     117:	8b 55 10             	mov    0x10(%ebp),%edx
     11a:	8b 45 0c             	mov    0xc(%ebp),%eax
     11d:	89 cb                	mov    %ecx,%ebx
     11f:	89 df                	mov    %ebx,%edi
     121:	89 d1                	mov    %edx,%ecx
     123:	fc                   	cld    
     124:	f3 aa                	rep stos %al,%es:(%edi)
     126:	89 ca                	mov    %ecx,%edx
     128:	89 fb                	mov    %edi,%ebx
     12a:	89 5d 08             	mov    %ebx,0x8(%ebp)
     12d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     130:	90                   	nop
     131:	5b                   	pop    %ebx
     132:	5f                   	pop    %edi
     133:	5d                   	pop    %ebp
     134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     135:	55                   	push   %ebp
     136:	89 e5                	mov    %esp,%ebp
     138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     13b:	8b 45 08             	mov    0x8(%ebp),%eax
     13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     141:	90                   	nop
     142:	8b 45 08             	mov    0x8(%ebp),%eax
     145:	8d 50 01             	lea    0x1(%eax),%edx
     148:	89 55 08             	mov    %edx,0x8(%ebp)
     14b:	8b 55 0c             	mov    0xc(%ebp),%edx
     14e:	8d 4a 01             	lea    0x1(%edx),%ecx
     151:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     154:	0f b6 12             	movzbl (%edx),%edx
     157:	88 10                	mov    %dl,(%eax)
     159:	0f b6 00             	movzbl (%eax),%eax
     15c:	84 c0                	test   %al,%al
     15e:	75 e2                	jne    142 <strcpy+0xd>
    ;
  return os;
     160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     163:	c9                   	leave  
     164:	c3                   	ret    

00000165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     165:	55                   	push   %ebp
     166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     168:	eb 08                	jmp    172 <strcmp+0xd>
    p++, q++;
     16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     172:	8b 45 08             	mov    0x8(%ebp),%eax
     175:	0f b6 00             	movzbl (%eax),%eax
     178:	84 c0                	test   %al,%al
     17a:	74 10                	je     18c <strcmp+0x27>
     17c:	8b 45 08             	mov    0x8(%ebp),%eax
     17f:	0f b6 10             	movzbl (%eax),%edx
     182:	8b 45 0c             	mov    0xc(%ebp),%eax
     185:	0f b6 00             	movzbl (%eax),%eax
     188:	38 c2                	cmp    %al,%dl
     18a:	74 de                	je     16a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     18c:	8b 45 08             	mov    0x8(%ebp),%eax
     18f:	0f b6 00             	movzbl (%eax),%eax
     192:	0f b6 d0             	movzbl %al,%edx
     195:	8b 45 0c             	mov    0xc(%ebp),%eax
     198:	0f b6 00             	movzbl (%eax),%eax
     19b:	0f b6 c0             	movzbl %al,%eax
     19e:	29 c2                	sub    %eax,%edx
     1a0:	89 d0                	mov    %edx,%eax
}
     1a2:	5d                   	pop    %ebp
     1a3:	c3                   	ret    

000001a4 <strlen>:

uint
strlen(char *s)
{
     1a4:	55                   	push   %ebp
     1a5:	89 e5                	mov    %esp,%ebp
     1a7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1b1:	eb 04                	jmp    1b7 <strlen+0x13>
     1b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1ba:	8b 45 08             	mov    0x8(%ebp),%eax
     1bd:	01 d0                	add    %edx,%eax
     1bf:	0f b6 00             	movzbl (%eax),%eax
     1c2:	84 c0                	test   %al,%al
     1c4:	75 ed                	jne    1b3 <strlen+0xf>
    ;
  return n;
     1c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1c9:	c9                   	leave  
     1ca:	c3                   	ret    

000001cb <memset>:

void*
memset(void *dst, int c, uint n)
{
     1cb:	55                   	push   %ebp
     1cc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     1ce:	8b 45 10             	mov    0x10(%ebp),%eax
     1d1:	50                   	push   %eax
     1d2:	ff 75 0c             	pushl  0xc(%ebp)
     1d5:	ff 75 08             	pushl  0x8(%ebp)
     1d8:	e8 32 ff ff ff       	call   10f <stosb>
     1dd:	83 c4 0c             	add    $0xc,%esp
  return dst;
     1e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1e3:	c9                   	leave  
     1e4:	c3                   	ret    

000001e5 <strchr>:

char*
strchr(const char *s, char c)
{
     1e5:	55                   	push   %ebp
     1e6:	89 e5                	mov    %esp,%ebp
     1e8:	83 ec 04             	sub    $0x4,%esp
     1eb:	8b 45 0c             	mov    0xc(%ebp),%eax
     1ee:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1f1:	eb 14                	jmp    207 <strchr+0x22>
    if(*s == c)
     1f3:	8b 45 08             	mov    0x8(%ebp),%eax
     1f6:	0f b6 00             	movzbl (%eax),%eax
     1f9:	3a 45 fc             	cmp    -0x4(%ebp),%al
     1fc:	75 05                	jne    203 <strchr+0x1e>
      return (char*)s;
     1fe:	8b 45 08             	mov    0x8(%ebp),%eax
     201:	eb 13                	jmp    216 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     203:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     207:	8b 45 08             	mov    0x8(%ebp),%eax
     20a:	0f b6 00             	movzbl (%eax),%eax
     20d:	84 c0                	test   %al,%al
     20f:	75 e2                	jne    1f3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     211:	b8 00 00 00 00       	mov    $0x0,%eax
}
     216:	c9                   	leave  
     217:	c3                   	ret    

00000218 <gets>:

char*
gets(char *buf, int max)
{
     218:	55                   	push   %ebp
     219:	89 e5                	mov    %esp,%ebp
     21b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     21e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     225:	eb 42                	jmp    269 <gets+0x51>
    cc = read(0, &c, 1);
     227:	83 ec 04             	sub    $0x4,%esp
     22a:	6a 01                	push   $0x1
     22c:	8d 45 ef             	lea    -0x11(%ebp),%eax
     22f:	50                   	push   %eax
     230:	6a 00                	push   $0x0
     232:	e8 47 01 00 00       	call   37e <read>
     237:	83 c4 10             	add    $0x10,%esp
     23a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     23d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     241:	7e 33                	jle    276 <gets+0x5e>
      break;
    buf[i++] = c;
     243:	8b 45 f4             	mov    -0xc(%ebp),%eax
     246:	8d 50 01             	lea    0x1(%eax),%edx
     249:	89 55 f4             	mov    %edx,-0xc(%ebp)
     24c:	89 c2                	mov    %eax,%edx
     24e:	8b 45 08             	mov    0x8(%ebp),%eax
     251:	01 c2                	add    %eax,%edx
     253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     257:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     259:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     25d:	3c 0a                	cmp    $0xa,%al
     25f:	74 16                	je     277 <gets+0x5f>
     261:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     265:	3c 0d                	cmp    $0xd,%al
     267:	74 0e                	je     277 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     269:	8b 45 f4             	mov    -0xc(%ebp),%eax
     26c:	83 c0 01             	add    $0x1,%eax
     26f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     272:	7c b3                	jl     227 <gets+0xf>
     274:	eb 01                	jmp    277 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     276:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     277:	8b 55 f4             	mov    -0xc(%ebp),%edx
     27a:	8b 45 08             	mov    0x8(%ebp),%eax
     27d:	01 d0                	add    %edx,%eax
     27f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     282:	8b 45 08             	mov    0x8(%ebp),%eax
}
     285:	c9                   	leave  
     286:	c3                   	ret    

00000287 <stat>:

int
stat(char *n, struct stat *st)
{
     287:	55                   	push   %ebp
     288:	89 e5                	mov    %esp,%ebp
     28a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     28d:	83 ec 08             	sub    $0x8,%esp
     290:	6a 00                	push   $0x0
     292:	ff 75 08             	pushl  0x8(%ebp)
     295:	e8 0c 01 00 00       	call   3a6 <open>
     29a:	83 c4 10             	add    $0x10,%esp
     29d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2a4:	79 07                	jns    2ad <stat+0x26>
    return -1;
     2a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2ab:	eb 25                	jmp    2d2 <stat+0x4b>
  r = fstat(fd, st);
     2ad:	83 ec 08             	sub    $0x8,%esp
     2b0:	ff 75 0c             	pushl  0xc(%ebp)
     2b3:	ff 75 f4             	pushl  -0xc(%ebp)
     2b6:	e8 03 01 00 00       	call   3be <fstat>
     2bb:	83 c4 10             	add    $0x10,%esp
     2be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2c1:	83 ec 0c             	sub    $0xc,%esp
     2c4:	ff 75 f4             	pushl  -0xc(%ebp)
     2c7:	e8 c2 00 00 00       	call   38e <close>
     2cc:	83 c4 10             	add    $0x10,%esp
  return r;
     2cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2d2:	c9                   	leave  
     2d3:	c3                   	ret    

000002d4 <atoi>:

int
atoi(const char *s)
{
     2d4:	55                   	push   %ebp
     2d5:	89 e5                	mov    %esp,%ebp
     2d7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2e1:	eb 25                	jmp    308 <atoi+0x34>
    n = n*10 + *s++ - '0';
     2e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2e6:	89 d0                	mov    %edx,%eax
     2e8:	c1 e0 02             	shl    $0x2,%eax
     2eb:	01 d0                	add    %edx,%eax
     2ed:	01 c0                	add    %eax,%eax
     2ef:	89 c1                	mov    %eax,%ecx
     2f1:	8b 45 08             	mov    0x8(%ebp),%eax
     2f4:	8d 50 01             	lea    0x1(%eax),%edx
     2f7:	89 55 08             	mov    %edx,0x8(%ebp)
     2fa:	0f b6 00             	movzbl (%eax),%eax
     2fd:	0f be c0             	movsbl %al,%eax
     300:	01 c8                	add    %ecx,%eax
     302:	83 e8 30             	sub    $0x30,%eax
     305:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     308:	8b 45 08             	mov    0x8(%ebp),%eax
     30b:	0f b6 00             	movzbl (%eax),%eax
     30e:	3c 2f                	cmp    $0x2f,%al
     310:	7e 0a                	jle    31c <atoi+0x48>
     312:	8b 45 08             	mov    0x8(%ebp),%eax
     315:	0f b6 00             	movzbl (%eax),%eax
     318:	3c 39                	cmp    $0x39,%al
     31a:	7e c7                	jle    2e3 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     31c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     31f:	c9                   	leave  
     320:	c3                   	ret    

00000321 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     321:	55                   	push   %ebp
     322:	89 e5                	mov    %esp,%ebp
     324:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     327:	8b 45 08             	mov    0x8(%ebp),%eax
     32a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     32d:	8b 45 0c             	mov    0xc(%ebp),%eax
     330:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     333:	eb 17                	jmp    34c <memmove+0x2b>
    *dst++ = *src++;
     335:	8b 45 fc             	mov    -0x4(%ebp),%eax
     338:	8d 50 01             	lea    0x1(%eax),%edx
     33b:	89 55 fc             	mov    %edx,-0x4(%ebp)
     33e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     341:	8d 4a 01             	lea    0x1(%edx),%ecx
     344:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     347:	0f b6 12             	movzbl (%edx),%edx
     34a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     34c:	8b 45 10             	mov    0x10(%ebp),%eax
     34f:	8d 50 ff             	lea    -0x1(%eax),%edx
     352:	89 55 10             	mov    %edx,0x10(%ebp)
     355:	85 c0                	test   %eax,%eax
     357:	7f dc                	jg     335 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     359:	8b 45 08             	mov    0x8(%ebp),%eax
}
     35c:	c9                   	leave  
     35d:	c3                   	ret    

0000035e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     35e:	b8 01 00 00 00       	mov    $0x1,%eax
     363:	cd 40                	int    $0x40
     365:	c3                   	ret    

00000366 <exit>:
SYSCALL(exit)
     366:	b8 02 00 00 00       	mov    $0x2,%eax
     36b:	cd 40                	int    $0x40
     36d:	c3                   	ret    

0000036e <wait>:
SYSCALL(wait)
     36e:	b8 03 00 00 00       	mov    $0x3,%eax
     373:	cd 40                	int    $0x40
     375:	c3                   	ret    

00000376 <pipe>:
SYSCALL(pipe)
     376:	b8 04 00 00 00       	mov    $0x4,%eax
     37b:	cd 40                	int    $0x40
     37d:	c3                   	ret    

0000037e <read>:
SYSCALL(read)
     37e:	b8 05 00 00 00       	mov    $0x5,%eax
     383:	cd 40                	int    $0x40
     385:	c3                   	ret    

00000386 <write>:
SYSCALL(write)
     386:	b8 10 00 00 00       	mov    $0x10,%eax
     38b:	cd 40                	int    $0x40
     38d:	c3                   	ret    

0000038e <close>:
SYSCALL(close)
     38e:	b8 15 00 00 00       	mov    $0x15,%eax
     393:	cd 40                	int    $0x40
     395:	c3                   	ret    

00000396 <kill>:
SYSCALL(kill)
     396:	b8 06 00 00 00       	mov    $0x6,%eax
     39b:	cd 40                	int    $0x40
     39d:	c3                   	ret    

0000039e <exec>:
SYSCALL(exec)
     39e:	b8 07 00 00 00       	mov    $0x7,%eax
     3a3:	cd 40                	int    $0x40
     3a5:	c3                   	ret    

000003a6 <open>:
SYSCALL(open)
     3a6:	b8 0f 00 00 00       	mov    $0xf,%eax
     3ab:	cd 40                	int    $0x40
     3ad:	c3                   	ret    

000003ae <mknod>:
SYSCALL(mknod)
     3ae:	b8 11 00 00 00       	mov    $0x11,%eax
     3b3:	cd 40                	int    $0x40
     3b5:	c3                   	ret    

000003b6 <unlink>:
SYSCALL(unlink)
     3b6:	b8 12 00 00 00       	mov    $0x12,%eax
     3bb:	cd 40                	int    $0x40
     3bd:	c3                   	ret    

000003be <fstat>:
SYSCALL(fstat)
     3be:	b8 08 00 00 00       	mov    $0x8,%eax
     3c3:	cd 40                	int    $0x40
     3c5:	c3                   	ret    

000003c6 <link>:
SYSCALL(link)
     3c6:	b8 13 00 00 00       	mov    $0x13,%eax
     3cb:	cd 40                	int    $0x40
     3cd:	c3                   	ret    

000003ce <mkdir>:
SYSCALL(mkdir)
     3ce:	b8 14 00 00 00       	mov    $0x14,%eax
     3d3:	cd 40                	int    $0x40
     3d5:	c3                   	ret    

000003d6 <chdir>:
SYSCALL(chdir)
     3d6:	b8 09 00 00 00       	mov    $0x9,%eax
     3db:	cd 40                	int    $0x40
     3dd:	c3                   	ret    

000003de <dup>:
SYSCALL(dup)
     3de:	b8 0a 00 00 00       	mov    $0xa,%eax
     3e3:	cd 40                	int    $0x40
     3e5:	c3                   	ret    

000003e6 <getpid>:
SYSCALL(getpid)
     3e6:	b8 0b 00 00 00       	mov    $0xb,%eax
     3eb:	cd 40                	int    $0x40
     3ed:	c3                   	ret    

000003ee <sbrk>:
SYSCALL(sbrk)
     3ee:	b8 0c 00 00 00       	mov    $0xc,%eax
     3f3:	cd 40                	int    $0x40
     3f5:	c3                   	ret    

000003f6 <sleep>:
SYSCALL(sleep)
     3f6:	b8 0d 00 00 00       	mov    $0xd,%eax
     3fb:	cd 40                	int    $0x40
     3fd:	c3                   	ret    

000003fe <uptime>:
SYSCALL(uptime)
     3fe:	b8 0e 00 00 00       	mov    $0xe,%eax
     403:	cd 40                	int    $0x40
     405:	c3                   	ret    

00000406 <paintWindow>:

SYSCALL(paintWindow)
     406:	b8 16 00 00 00       	mov    $0x16,%eax
     40b:	cd 40                	int    $0x40
     40d:	c3                   	ret    

0000040e <sendMessage>:
SYSCALL(sendMessage)
     40e:	b8 17 00 00 00       	mov    $0x17,%eax
     413:	cd 40                	int    $0x40
     415:	c3                   	ret    

00000416 <getMessage>:
SYSCALL(getMessage)
     416:	b8 19 00 00 00       	mov    $0x19,%eax
     41b:	cd 40                	int    $0x40
     41d:	c3                   	ret    

0000041e <registWindow>:
SYSCALL(registWindow)
     41e:	b8 18 00 00 00       	mov    $0x18,%eax
     423:	cd 40                	int    $0x40
     425:	c3                   	ret    

00000426 <changePosition>:
SYSCALL(changePosition)
     426:	b8 1a 00 00 00       	mov    $0x1a,%eax
     42b:	cd 40                	int    $0x40
     42d:	c3                   	ret    

0000042e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     42e:	55                   	push   %ebp
     42f:	89 e5                	mov    %esp,%ebp
     431:	83 ec 18             	sub    $0x18,%esp
     434:	8b 45 0c             	mov    0xc(%ebp),%eax
     437:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     43a:	83 ec 04             	sub    $0x4,%esp
     43d:	6a 01                	push   $0x1
     43f:	8d 45 f4             	lea    -0xc(%ebp),%eax
     442:	50                   	push   %eax
     443:	ff 75 08             	pushl  0x8(%ebp)
     446:	e8 3b ff ff ff       	call   386 <write>
     44b:	83 c4 10             	add    $0x10,%esp
}
     44e:	90                   	nop
     44f:	c9                   	leave  
     450:	c3                   	ret    

00000451 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     451:	55                   	push   %ebp
     452:	89 e5                	mov    %esp,%ebp
     454:	53                   	push   %ebx
     455:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     458:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     45f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     463:	74 17                	je     47c <printint+0x2b>
     465:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     469:	79 11                	jns    47c <printint+0x2b>
    neg = 1;
     46b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     472:	8b 45 0c             	mov    0xc(%ebp),%eax
     475:	f7 d8                	neg    %eax
     477:	89 45 ec             	mov    %eax,-0x14(%ebp)
     47a:	eb 06                	jmp    482 <printint+0x31>
  } else {
    x = xx;
     47c:	8b 45 0c             	mov    0xc(%ebp),%eax
     47f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     482:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     489:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     48c:	8d 41 01             	lea    0x1(%ecx),%eax
     48f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     492:	8b 5d 10             	mov    0x10(%ebp),%ebx
     495:	8b 45 ec             	mov    -0x14(%ebp),%eax
     498:	ba 00 00 00 00       	mov    $0x0,%edx
     49d:	f7 f3                	div    %ebx
     49f:	89 d0                	mov    %edx,%eax
     4a1:	0f b6 80 e4 29 00 00 	movzbl 0x29e4(%eax),%eax
     4a8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4ac:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4af:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4b2:	ba 00 00 00 00       	mov    $0x0,%edx
     4b7:	f7 f3                	div    %ebx
     4b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4bc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4c0:	75 c7                	jne    489 <printint+0x38>
  if(neg)
     4c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4c6:	74 2d                	je     4f5 <printint+0xa4>
    buf[i++] = '-';
     4c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4cb:	8d 50 01             	lea    0x1(%eax),%edx
     4ce:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4d1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4d6:	eb 1d                	jmp    4f5 <printint+0xa4>
    putc(fd, buf[i]);
     4d8:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4de:	01 d0                	add    %edx,%eax
     4e0:	0f b6 00             	movzbl (%eax),%eax
     4e3:	0f be c0             	movsbl %al,%eax
     4e6:	83 ec 08             	sub    $0x8,%esp
     4e9:	50                   	push   %eax
     4ea:	ff 75 08             	pushl  0x8(%ebp)
     4ed:	e8 3c ff ff ff       	call   42e <putc>
     4f2:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     4f5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     4f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4fd:	79 d9                	jns    4d8 <printint+0x87>
    putc(fd, buf[i]);
}
     4ff:	90                   	nop
     500:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     503:	c9                   	leave  
     504:	c3                   	ret    

00000505 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     505:	55                   	push   %ebp
     506:	89 e5                	mov    %esp,%ebp
     508:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     50b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     512:	8d 45 0c             	lea    0xc(%ebp),%eax
     515:	83 c0 04             	add    $0x4,%eax
     518:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     51b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     522:	e9 59 01 00 00       	jmp    680 <printf+0x17b>
    c = fmt[i] & 0xff;
     527:	8b 55 0c             	mov    0xc(%ebp),%edx
     52a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     52d:	01 d0                	add    %edx,%eax
     52f:	0f b6 00             	movzbl (%eax),%eax
     532:	0f be c0             	movsbl %al,%eax
     535:	25 ff 00 00 00       	and    $0xff,%eax
     53a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     53d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     541:	75 2c                	jne    56f <printf+0x6a>
      if(c == '%'){
     543:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     547:	75 0c                	jne    555 <printf+0x50>
        state = '%';
     549:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     550:	e9 27 01 00 00       	jmp    67c <printf+0x177>
      } else {
        putc(fd, c);
     555:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     558:	0f be c0             	movsbl %al,%eax
     55b:	83 ec 08             	sub    $0x8,%esp
     55e:	50                   	push   %eax
     55f:	ff 75 08             	pushl  0x8(%ebp)
     562:	e8 c7 fe ff ff       	call   42e <putc>
     567:	83 c4 10             	add    $0x10,%esp
     56a:	e9 0d 01 00 00       	jmp    67c <printf+0x177>
      }
    } else if(state == '%'){
     56f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     573:	0f 85 03 01 00 00    	jne    67c <printf+0x177>
      if(c == 'd'){
     579:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     57d:	75 1e                	jne    59d <printf+0x98>
        printint(fd, *ap, 10, 1);
     57f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     582:	8b 00                	mov    (%eax),%eax
     584:	6a 01                	push   $0x1
     586:	6a 0a                	push   $0xa
     588:	50                   	push   %eax
     589:	ff 75 08             	pushl  0x8(%ebp)
     58c:	e8 c0 fe ff ff       	call   451 <printint>
     591:	83 c4 10             	add    $0x10,%esp
        ap++;
     594:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     598:	e9 d8 00 00 00       	jmp    675 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     59d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5a1:	74 06                	je     5a9 <printf+0xa4>
     5a3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5a7:	75 1e                	jne    5c7 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ac:	8b 00                	mov    (%eax),%eax
     5ae:	6a 00                	push   $0x0
     5b0:	6a 10                	push   $0x10
     5b2:	50                   	push   %eax
     5b3:	ff 75 08             	pushl  0x8(%ebp)
     5b6:	e8 96 fe ff ff       	call   451 <printint>
     5bb:	83 c4 10             	add    $0x10,%esp
        ap++;
     5be:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c2:	e9 ae 00 00 00       	jmp    675 <printf+0x170>
      } else if(c == 's'){
     5c7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5cb:	75 43                	jne    610 <printf+0x10b>
        s = (char*)*ap;
     5cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d0:	8b 00                	mov    (%eax),%eax
     5d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5dd:	75 25                	jne    604 <printf+0xff>
          s = "(null)";
     5df:	c7 45 f4 ee 22 00 00 	movl   $0x22ee,-0xc(%ebp)
        while(*s != 0){
     5e6:	eb 1c                	jmp    604 <printf+0xff>
          putc(fd, *s);
     5e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5eb:	0f b6 00             	movzbl (%eax),%eax
     5ee:	0f be c0             	movsbl %al,%eax
     5f1:	83 ec 08             	sub    $0x8,%esp
     5f4:	50                   	push   %eax
     5f5:	ff 75 08             	pushl  0x8(%ebp)
     5f8:	e8 31 fe ff ff       	call   42e <putc>
     5fd:	83 c4 10             	add    $0x10,%esp
          s++;
     600:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     604:	8b 45 f4             	mov    -0xc(%ebp),%eax
     607:	0f b6 00             	movzbl (%eax),%eax
     60a:	84 c0                	test   %al,%al
     60c:	75 da                	jne    5e8 <printf+0xe3>
     60e:	eb 65                	jmp    675 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     610:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     614:	75 1d                	jne    633 <printf+0x12e>
        putc(fd, *ap);
     616:	8b 45 e8             	mov    -0x18(%ebp),%eax
     619:	8b 00                	mov    (%eax),%eax
     61b:	0f be c0             	movsbl %al,%eax
     61e:	83 ec 08             	sub    $0x8,%esp
     621:	50                   	push   %eax
     622:	ff 75 08             	pushl  0x8(%ebp)
     625:	e8 04 fe ff ff       	call   42e <putc>
     62a:	83 c4 10             	add    $0x10,%esp
        ap++;
     62d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     631:	eb 42                	jmp    675 <printf+0x170>
      } else if(c == '%'){
     633:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     637:	75 17                	jne    650 <printf+0x14b>
        putc(fd, c);
     639:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     63c:	0f be c0             	movsbl %al,%eax
     63f:	83 ec 08             	sub    $0x8,%esp
     642:	50                   	push   %eax
     643:	ff 75 08             	pushl  0x8(%ebp)
     646:	e8 e3 fd ff ff       	call   42e <putc>
     64b:	83 c4 10             	add    $0x10,%esp
     64e:	eb 25                	jmp    675 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     650:	83 ec 08             	sub    $0x8,%esp
     653:	6a 25                	push   $0x25
     655:	ff 75 08             	pushl  0x8(%ebp)
     658:	e8 d1 fd ff ff       	call   42e <putc>
     65d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     660:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     663:	0f be c0             	movsbl %al,%eax
     666:	83 ec 08             	sub    $0x8,%esp
     669:	50                   	push   %eax
     66a:	ff 75 08             	pushl  0x8(%ebp)
     66d:	e8 bc fd ff ff       	call   42e <putc>
     672:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     675:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     67c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     680:	8b 55 0c             	mov    0xc(%ebp),%edx
     683:	8b 45 f0             	mov    -0x10(%ebp),%eax
     686:	01 d0                	add    %edx,%eax
     688:	0f b6 00             	movzbl (%eax),%eax
     68b:	84 c0                	test   %al,%al
     68d:	0f 85 94 fe ff ff    	jne    527 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     693:	90                   	nop
     694:	c9                   	leave  
     695:	c3                   	ret    

00000696 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     696:	55                   	push   %ebp
     697:	89 e5                	mov    %esp,%ebp
     699:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     69c:	8b 45 08             	mov    0x8(%ebp),%eax
     69f:	83 e8 08             	sub    $0x8,%eax
     6a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6a5:	a1 28 2a 00 00       	mov    0x2a28,%eax
     6aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6ad:	eb 24                	jmp    6d3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b2:	8b 00                	mov    (%eax),%eax
     6b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6b7:	77 12                	ja     6cb <free+0x35>
     6b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6bf:	77 24                	ja     6e5 <free+0x4f>
     6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c4:	8b 00                	mov    (%eax),%eax
     6c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6c9:	77 1a                	ja     6e5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ce:	8b 00                	mov    (%eax),%eax
     6d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6d9:	76 d4                	jbe    6af <free+0x19>
     6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6de:	8b 00                	mov    (%eax),%eax
     6e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6e3:	76 ca                	jbe    6af <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     6e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e8:	8b 40 04             	mov    0x4(%eax),%eax
     6eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f5:	01 c2                	add    %eax,%edx
     6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fa:	8b 00                	mov    (%eax),%eax
     6fc:	39 c2                	cmp    %eax,%edx
     6fe:	75 24                	jne    724 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     700:	8b 45 f8             	mov    -0x8(%ebp),%eax
     703:	8b 50 04             	mov    0x4(%eax),%edx
     706:	8b 45 fc             	mov    -0x4(%ebp),%eax
     709:	8b 00                	mov    (%eax),%eax
     70b:	8b 40 04             	mov    0x4(%eax),%eax
     70e:	01 c2                	add    %eax,%edx
     710:	8b 45 f8             	mov    -0x8(%ebp),%eax
     713:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     716:	8b 45 fc             	mov    -0x4(%ebp),%eax
     719:	8b 00                	mov    (%eax),%eax
     71b:	8b 10                	mov    (%eax),%edx
     71d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     720:	89 10                	mov    %edx,(%eax)
     722:	eb 0a                	jmp    72e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     724:	8b 45 fc             	mov    -0x4(%ebp),%eax
     727:	8b 10                	mov    (%eax),%edx
     729:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     731:	8b 40 04             	mov    0x4(%eax),%eax
     734:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     73b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73e:	01 d0                	add    %edx,%eax
     740:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     743:	75 20                	jne    765 <free+0xcf>
    p->s.size += bp->s.size;
     745:	8b 45 fc             	mov    -0x4(%ebp),%eax
     748:	8b 50 04             	mov    0x4(%eax),%edx
     74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74e:	8b 40 04             	mov    0x4(%eax),%eax
     751:	01 c2                	add    %eax,%edx
     753:	8b 45 fc             	mov    -0x4(%ebp),%eax
     756:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     759:	8b 45 f8             	mov    -0x8(%ebp),%eax
     75c:	8b 10                	mov    (%eax),%edx
     75e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     761:	89 10                	mov    %edx,(%eax)
     763:	eb 08                	jmp    76d <free+0xd7>
  } else
    p->s.ptr = bp;
     765:	8b 45 fc             	mov    -0x4(%ebp),%eax
     768:	8b 55 f8             	mov    -0x8(%ebp),%edx
     76b:	89 10                	mov    %edx,(%eax)
  freep = p;
     76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     770:	a3 28 2a 00 00       	mov    %eax,0x2a28
}
     775:	90                   	nop
     776:	c9                   	leave  
     777:	c3                   	ret    

00000778 <morecore>:

static Header*
morecore(uint nu)
{
     778:	55                   	push   %ebp
     779:	89 e5                	mov    %esp,%ebp
     77b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     77e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     785:	77 07                	ja     78e <morecore+0x16>
    nu = 4096;
     787:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     78e:	8b 45 08             	mov    0x8(%ebp),%eax
     791:	c1 e0 03             	shl    $0x3,%eax
     794:	83 ec 0c             	sub    $0xc,%esp
     797:	50                   	push   %eax
     798:	e8 51 fc ff ff       	call   3ee <sbrk>
     79d:	83 c4 10             	add    $0x10,%esp
     7a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7a3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7a7:	75 07                	jne    7b0 <morecore+0x38>
    return 0;
     7a9:	b8 00 00 00 00       	mov    $0x0,%eax
     7ae:	eb 26                	jmp    7d6 <morecore+0x5e>
  hp = (Header*)p;
     7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b9:	8b 55 08             	mov    0x8(%ebp),%edx
     7bc:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c2:	83 c0 08             	add    $0x8,%eax
     7c5:	83 ec 0c             	sub    $0xc,%esp
     7c8:	50                   	push   %eax
     7c9:	e8 c8 fe ff ff       	call   696 <free>
     7ce:	83 c4 10             	add    $0x10,%esp
  return freep;
     7d1:	a1 28 2a 00 00       	mov    0x2a28,%eax
}
     7d6:	c9                   	leave  
     7d7:	c3                   	ret    

000007d8 <malloc>:

void*
malloc(uint nbytes)
{
     7d8:	55                   	push   %ebp
     7d9:	89 e5                	mov    %esp,%ebp
     7db:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7de:	8b 45 08             	mov    0x8(%ebp),%eax
     7e1:	83 c0 07             	add    $0x7,%eax
     7e4:	c1 e8 03             	shr    $0x3,%eax
     7e7:	83 c0 01             	add    $0x1,%eax
     7ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7ed:	a1 28 2a 00 00       	mov    0x2a28,%eax
     7f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7f9:	75 23                	jne    81e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7fb:	c7 45 f0 20 2a 00 00 	movl   $0x2a20,-0x10(%ebp)
     802:	8b 45 f0             	mov    -0x10(%ebp),%eax
     805:	a3 28 2a 00 00       	mov    %eax,0x2a28
     80a:	a1 28 2a 00 00       	mov    0x2a28,%eax
     80f:	a3 20 2a 00 00       	mov    %eax,0x2a20
    base.s.size = 0;
     814:	c7 05 24 2a 00 00 00 	movl   $0x0,0x2a24
     81b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     81e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     821:	8b 00                	mov    (%eax),%eax
     823:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     826:	8b 45 f4             	mov    -0xc(%ebp),%eax
     829:	8b 40 04             	mov    0x4(%eax),%eax
     82c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     82f:	72 4d                	jb     87e <malloc+0xa6>
      if(p->s.size == nunits)
     831:	8b 45 f4             	mov    -0xc(%ebp),%eax
     834:	8b 40 04             	mov    0x4(%eax),%eax
     837:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     83a:	75 0c                	jne    848 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83f:	8b 10                	mov    (%eax),%edx
     841:	8b 45 f0             	mov    -0x10(%ebp),%eax
     844:	89 10                	mov    %edx,(%eax)
     846:	eb 26                	jmp    86e <malloc+0x96>
      else {
        p->s.size -= nunits;
     848:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84b:	8b 40 04             	mov    0x4(%eax),%eax
     84e:	2b 45 ec             	sub    -0x14(%ebp),%eax
     851:	89 c2                	mov    %eax,%edx
     853:	8b 45 f4             	mov    -0xc(%ebp),%eax
     856:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     859:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85c:	8b 40 04             	mov    0x4(%eax),%eax
     85f:	c1 e0 03             	shl    $0x3,%eax
     862:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     865:	8b 45 f4             	mov    -0xc(%ebp),%eax
     868:	8b 55 ec             	mov    -0x14(%ebp),%edx
     86b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     86e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     871:	a3 28 2a 00 00       	mov    %eax,0x2a28
      return (void*)(p + 1);
     876:	8b 45 f4             	mov    -0xc(%ebp),%eax
     879:	83 c0 08             	add    $0x8,%eax
     87c:	eb 3b                	jmp    8b9 <malloc+0xe1>
    }
    if(p == freep)
     87e:	a1 28 2a 00 00       	mov    0x2a28,%eax
     883:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     886:	75 1e                	jne    8a6 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     888:	83 ec 0c             	sub    $0xc,%esp
     88b:	ff 75 ec             	pushl  -0x14(%ebp)
     88e:	e8 e5 fe ff ff       	call   778 <morecore>
     893:	83 c4 10             	add    $0x10,%esp
     896:	89 45 f4             	mov    %eax,-0xc(%ebp)
     899:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     89d:	75 07                	jne    8a6 <malloc+0xce>
        return 0;
     89f:	b8 00 00 00 00       	mov    $0x0,%eax
     8a4:	eb 13                	jmp    8b9 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8af:	8b 00                	mov    (%eax),%eax
     8b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8b4:	e9 6d ff ff ff       	jmp    826 <malloc+0x4e>
}
     8b9:	c9                   	leave  
     8ba:	c3                   	ret    

000008bb <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8bb:	55                   	push   %ebp
     8bc:	89 e5                	mov    %esp,%ebp
     8be:	83 ec 1c             	sub    $0x1c,%esp
     8c1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8c4:	8b 55 10             	mov    0x10(%ebp),%edx
     8c7:	8b 45 14             	mov    0x14(%ebp),%eax
     8ca:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8cd:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8d0:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8d3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8d7:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8da:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8de:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     8e1:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     8e5:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     8e8:	8b 45 08             	mov    0x8(%ebp),%eax
     8eb:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     8ef:	66 89 10             	mov    %dx,(%eax)
     8f2:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     8f6:	88 50 02             	mov    %dl,0x2(%eax)
}
     8f9:	8b 45 08             	mov    0x8(%ebp),%eax
     8fc:	c9                   	leave  
     8fd:	c2 04 00             	ret    $0x4

00000900 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     900:	55                   	push   %ebp
     901:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     903:	8b 45 08             	mov    0x8(%ebp),%eax
     906:	2b 45 10             	sub    0x10(%ebp),%eax
     909:	89 c2                	mov    %eax,%edx
     90b:	8b 45 08             	mov    0x8(%ebp),%eax
     90e:	2b 45 10             	sub    0x10(%ebp),%eax
     911:	0f af d0             	imul   %eax,%edx
     914:	8b 45 0c             	mov    0xc(%ebp),%eax
     917:	2b 45 14             	sub    0x14(%ebp),%eax
     91a:	89 c1                	mov    %eax,%ecx
     91c:	8b 45 0c             	mov    0xc(%ebp),%eax
     91f:	2b 45 14             	sub    0x14(%ebp),%eax
     922:	0f af c1             	imul   %ecx,%eax
     925:	01 d0                	add    %edx,%eax
}
     927:	5d                   	pop    %ebp
     928:	c3                   	ret    

00000929 <abs_int>:

static inline int abs_int(int x)
{
     929:	55                   	push   %ebp
     92a:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     92c:	8b 45 08             	mov    0x8(%ebp),%eax
     92f:	99                   	cltd   
     930:	89 d0                	mov    %edx,%eax
     932:	33 45 08             	xor    0x8(%ebp),%eax
     935:	29 d0                	sub    %edx,%eax
}
     937:	5d                   	pop    %ebp
     938:	c3                   	ret    

00000939 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     939:	55                   	push   %ebp
     93a:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     93c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     940:	79 07                	jns    949 <APGetIndex+0x10>
        return X_SMALLER;
     942:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     947:	eb 40                	jmp    989 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     949:	8b 45 08             	mov    0x8(%ebp),%eax
     94c:	8b 00                	mov    (%eax),%eax
     94e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     951:	7f 07                	jg     95a <APGetIndex+0x21>
        return X_BIGGER;
     953:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     958:	eb 2f                	jmp    989 <APGetIndex+0x50>
    if (y < 0)
     95a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     95e:	79 07                	jns    967 <APGetIndex+0x2e>
        return Y_SMALLER;
     960:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     965:	eb 22                	jmp    989 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     967:	8b 45 08             	mov    0x8(%ebp),%eax
     96a:	8b 40 04             	mov    0x4(%eax),%eax
     96d:	3b 45 10             	cmp    0x10(%ebp),%eax
     970:	7f 07                	jg     979 <APGetIndex+0x40>
        return Y_BIGGER;
     972:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     977:	eb 10                	jmp    989 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     979:	8b 45 08             	mov    0x8(%ebp),%eax
     97c:	8b 00                	mov    (%eax),%eax
     97e:	0f af 45 10          	imul   0x10(%ebp),%eax
     982:	89 c2                	mov    %eax,%edx
     984:	8b 45 0c             	mov    0xc(%ebp),%eax
     987:	01 d0                	add    %edx,%eax
}
     989:	5d                   	pop    %ebp
     98a:	c3                   	ret    

0000098b <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     98b:	55                   	push   %ebp
     98c:	89 e5                	mov    %esp,%ebp
     98e:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     991:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     998:	8b 45 cc             	mov    -0x34(%ebp),%eax
     99b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     99e:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9a5:	83 ec 08             	sub    $0x8,%esp
     9a8:	6a 00                	push   $0x0
     9aa:	ff 75 0c             	pushl  0xc(%ebp)
     9ad:	e8 f4 f9 ff ff       	call   3a6 <open>
     9b2:	83 c4 10             	add    $0x10,%esp
     9b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9bc:	79 2e                	jns    9ec <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9be:	83 ec 04             	sub    $0x4,%esp
     9c1:	ff 75 0c             	pushl  0xc(%ebp)
     9c4:	68 f5 22 00 00       	push   $0x22f5
     9c9:	6a 01                	push   $0x1
     9cb:	e8 35 fb ff ff       	call   505 <printf>
     9d0:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9d3:	8b 45 08             	mov    0x8(%ebp),%eax
     9d6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9d9:	89 10                	mov    %edx,(%eax)
     9db:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9de:	89 50 04             	mov    %edx,0x4(%eax)
     9e1:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9e4:	89 50 08             	mov    %edx,0x8(%eax)
     9e7:	e9 d2 01 00 00       	jmp    bbe <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9ec:	83 ec 04             	sub    $0x4,%esp
     9ef:	6a 0e                	push   $0xe
     9f1:	8d 45 ba             	lea    -0x46(%ebp),%eax
     9f4:	50                   	push   %eax
     9f5:	ff 75 ec             	pushl  -0x14(%ebp)
     9f8:	e8 81 f9 ff ff       	call   37e <read>
     9fd:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a00:	83 ec 04             	sub    $0x4,%esp
     a03:	6a 28                	push   $0x28
     a05:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a08:	50                   	push   %eax
     a09:	ff 75 ec             	pushl  -0x14(%ebp)
     a0c:	e8 6d f9 ff ff       	call   37e <read>
     a11:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a14:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a17:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a1a:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a1d:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a20:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a23:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a26:	0f af d0             	imul   %eax,%edx
     a29:	89 d0                	mov    %edx,%eax
     a2b:	01 c0                	add    %eax,%eax
     a2d:	01 d0                	add    %edx,%eax
     a2f:	83 ec 0c             	sub    $0xc,%esp
     a32:	50                   	push   %eax
     a33:	e8 a0 fd ff ff       	call   7d8 <malloc>
     a38:	83 c4 10             	add    $0x10,%esp
     a3b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a3e:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a42:	0f b7 c0             	movzwl %ax,%eax
     a45:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a48:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a4e:	0f af c2             	imul   %edx,%eax
     a51:	83 c0 1f             	add    $0x1f,%eax
     a54:	c1 e8 05             	shr    $0x5,%eax
     a57:	c1 e0 02             	shl    $0x2,%eax
     a5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a5d:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a63:	0f af c2             	imul   %edx,%eax
     a66:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a69:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a6c:	83 ec 0c             	sub    $0xc,%esp
     a6f:	50                   	push   %eax
     a70:	e8 63 fd ff ff       	call   7d8 <malloc>
     a75:	83 c4 10             	add    $0x10,%esp
     a78:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a7b:	83 ec 04             	sub    $0x4,%esp
     a7e:	ff 75 e0             	pushl  -0x20(%ebp)
     a81:	ff 75 dc             	pushl  -0x24(%ebp)
     a84:	ff 75 ec             	pushl  -0x14(%ebp)
     a87:	e8 f2 f8 ff ff       	call   37e <read>
     a8c:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a8f:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a93:	66 c1 e8 03          	shr    $0x3,%ax
     a97:	0f b7 c0             	movzwl %ax,%eax
     a9a:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     a9d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aa4:	e9 e5 00 00 00       	jmp    b8e <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     aa9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aaf:	29 c2                	sub    %eax,%edx
     ab1:	89 d0                	mov    %edx,%eax
     ab3:	8d 50 ff             	lea    -0x1(%eax),%edx
     ab6:	8b 45 c8             	mov    -0x38(%ebp),%eax
     ab9:	0f af c2             	imul   %edx,%eax
     abc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     abf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ac6:	e9 b1 00 00 00       	jmp    b7c <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     acb:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ace:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad4:	01 c8                	add    %ecx,%eax
     ad6:	89 c1                	mov    %eax,%ecx
     ad8:	89 c8                	mov    %ecx,%eax
     ada:	01 c0                	add    %eax,%eax
     adc:	01 c8                	add    %ecx,%eax
     ade:	01 c2                	add    %eax,%edx
     ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae3:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ae7:	89 c1                	mov    %eax,%ecx
     ae9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aec:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     af0:	01 c1                	add    %eax,%ecx
     af2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     af5:	01 c8                	add    %ecx,%eax
     af7:	8d 48 ff             	lea    -0x1(%eax),%ecx
     afa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     afd:	01 c8                	add    %ecx,%eax
     aff:	0f b6 00             	movzbl (%eax),%eax
     b02:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b05:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b08:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b0e:	01 c8                	add    %ecx,%eax
     b10:	89 c1                	mov    %eax,%ecx
     b12:	89 c8                	mov    %ecx,%eax
     b14:	01 c0                	add    %eax,%eax
     b16:	01 c8                	add    %ecx,%eax
     b18:	01 c2                	add    %eax,%edx
     b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b1d:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b21:	89 c1                	mov    %eax,%ecx
     b23:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b26:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b2a:	01 c1                	add    %eax,%ecx
     b2c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b2f:	01 c8                	add    %ecx,%eax
     b31:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b34:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b37:	01 c8                	add    %ecx,%eax
     b39:	0f b6 00             	movzbl (%eax),%eax
     b3c:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b3f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b42:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b45:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b48:	01 c8                	add    %ecx,%eax
     b4a:	89 c1                	mov    %eax,%ecx
     b4c:	89 c8                	mov    %ecx,%eax
     b4e:	01 c0                	add    %eax,%eax
     b50:	01 c8                	add    %ecx,%eax
     b52:	01 c2                	add    %eax,%edx
     b54:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b57:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b5b:	89 c1                	mov    %eax,%ecx
     b5d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b60:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b64:	01 c1                	add    %eax,%ecx
     b66:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b69:	01 c8                	add    %ecx,%eax
     b6b:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b6e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b71:	01 c8                	add    %ecx,%eax
     b73:	0f b6 00             	movzbl (%eax),%eax
     b76:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b78:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b7c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b82:	39 c2                	cmp    %eax,%edx
     b84:	0f 87 41 ff ff ff    	ja     acb <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b8a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b8e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b94:	39 c2                	cmp    %eax,%edx
     b96:	0f 87 0d ff ff ff    	ja     aa9 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     b9c:	83 ec 0c             	sub    $0xc,%esp
     b9f:	ff 75 ec             	pushl  -0x14(%ebp)
     ba2:	e8 e7 f7 ff ff       	call   38e <close>
     ba7:	83 c4 10             	add    $0x10,%esp
    return bmp;
     baa:	8b 45 08             	mov    0x8(%ebp),%eax
     bad:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bb0:	89 10                	mov    %edx,(%eax)
     bb2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bb5:	89 50 04             	mov    %edx,0x4(%eax)
     bb8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bbb:	89 50 08             	mov    %edx,0x8(%eax)
}
     bbe:	8b 45 08             	mov    0x8(%ebp),%eax
     bc1:	c9                   	leave  
     bc2:	c2 04 00             	ret    $0x4

00000bc5 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     bc5:	55                   	push   %ebp
     bc6:	89 e5                	mov    %esp,%ebp
     bc8:	53                   	push   %ebx
     bc9:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bcc:	83 ec 0c             	sub    $0xc,%esp
     bcf:	6a 1c                	push   $0x1c
     bd1:	e8 02 fc ff ff       	call   7d8 <malloc>
     bd6:	83 c4 10             	add    $0x10,%esp
     bd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdf:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     be6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     be9:	8d 45 d8             	lea    -0x28(%ebp),%eax
     bec:	6a 0c                	push   $0xc
     bee:	6a 0c                	push   $0xc
     bf0:	6a 0c                	push   $0xc
     bf2:	50                   	push   %eax
     bf3:	e8 c3 fc ff ff       	call   8bb <RGB>
     bf8:	83 c4 0c             	add    $0xc,%esp
     bfb:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     bff:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c03:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c07:	88 43 15             	mov    %al,0x15(%ebx)
     c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c10:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c14:	66 89 48 10          	mov    %cx,0x10(%eax)
     c18:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c1c:	88 50 12             	mov    %dl,0x12(%eax)
     c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c22:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c25:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c29:	66 89 48 08          	mov    %cx,0x8(%eax)
     c2d:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c31:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c34:	8b 45 08             	mov    0x8(%ebp),%eax
     c37:	89 c2                	mov    %eax,%edx
     c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3c:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c3e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c41:	89 c2                	mov    %eax,%edx
     c43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c46:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c49:	8b 55 10             	mov    0x10(%ebp),%edx
     c4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4f:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c52:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c58:	c9                   	leave  
     c59:	c3                   	ret    

00000c5a <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c5a:	55                   	push   %ebp
     c5b:	89 e5                	mov    %esp,%ebp
     c5d:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c60:	8b 45 0c             	mov    0xc(%ebp),%eax
     c63:	8b 50 08             	mov    0x8(%eax),%edx
     c66:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c69:	8b 40 0c             	mov    0xc(%eax),%eax
     c6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
     c72:	8b 55 10             	mov    0x10(%ebp),%edx
     c75:	89 50 08             	mov    %edx,0x8(%eax)
     c78:	8b 55 14             	mov    0x14(%ebp),%edx
     c7b:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c7e:	8b 45 08             	mov    0x8(%ebp),%eax
     c81:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c84:	89 10                	mov    %edx,(%eax)
     c86:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c89:	89 50 04             	mov    %edx,0x4(%eax)
}
     c8c:	8b 45 08             	mov    0x8(%ebp),%eax
     c8f:	c9                   	leave  
     c90:	c2 04 00             	ret    $0x4

00000c93 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c93:	55                   	push   %ebp
     c94:	89 e5                	mov    %esp,%ebp
     c96:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     c99:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9c:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ca0:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ca4:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ca8:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cab:	8b 45 0c             	mov    0xc(%ebp),%eax
     cae:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cb2:	66 89 50 10          	mov    %dx,0x10(%eax)
     cb6:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cba:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     cbd:	8b 45 08             	mov    0x8(%ebp),%eax
     cc0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     cc4:	66 89 10             	mov    %dx,(%eax)
     cc7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     ccb:	88 50 02             	mov    %dl,0x2(%eax)
}
     cce:	8b 45 08             	mov    0x8(%ebp),%eax
     cd1:	c9                   	leave  
     cd2:	c2 04 00             	ret    $0x4

00000cd5 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     cd5:	55                   	push   %ebp
     cd6:	89 e5                	mov    %esp,%ebp
     cd8:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     cdb:	8b 45 08             	mov    0x8(%ebp),%eax
     cde:	8b 40 0c             	mov    0xc(%eax),%eax
     ce1:	89 c2                	mov    %eax,%edx
     ce3:	c1 ea 1f             	shr    $0x1f,%edx
     ce6:	01 d0                	add    %edx,%eax
     ce8:	d1 f8                	sar    %eax
     cea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     ced:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf0:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cf4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cf7:	8b 45 10             	mov    0x10(%ebp),%eax
     cfa:	2b 45 f4             	sub    -0xc(%ebp),%eax
     cfd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d00:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d04:	0f 89 98 00 00 00    	jns    da2 <APDrawPoint+0xcd>
        i = 0;
     d0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d11:	e9 8c 00 00 00       	jmp    da2 <APDrawPoint+0xcd>
    {
        j = x - off;
     d16:	8b 45 0c             	mov    0xc(%ebp),%eax
     d19:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d1c:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d1f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d23:	79 69                	jns    d8e <APDrawPoint+0xb9>
            j = 0;
     d25:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d2c:	eb 60                	jmp    d8e <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d2e:	ff 75 fc             	pushl  -0x4(%ebp)
     d31:	ff 75 f8             	pushl  -0x8(%ebp)
     d34:	ff 75 08             	pushl  0x8(%ebp)
     d37:	e8 fd fb ff ff       	call   939 <APGetIndex>
     d3c:	83 c4 0c             	add    $0xc,%esp
     d3f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d42:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d46:	74 55                	je     d9d <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d48:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d4c:	74 67                	je     db5 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d4e:	ff 75 10             	pushl  0x10(%ebp)
     d51:	ff 75 0c             	pushl  0xc(%ebp)
     d54:	ff 75 fc             	pushl  -0x4(%ebp)
     d57:	ff 75 f8             	pushl  -0x8(%ebp)
     d5a:	e8 a1 fb ff ff       	call   900 <distance_2>
     d5f:	83 c4 10             	add    $0x10,%esp
     d62:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d65:	7f 23                	jg     d8a <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d67:	8b 45 08             	mov    0x8(%ebp),%eax
     d6a:	8b 48 18             	mov    0x18(%eax),%ecx
     d6d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d70:	89 d0                	mov    %edx,%eax
     d72:	01 c0                	add    %eax,%eax
     d74:	01 d0                	add    %edx,%eax
     d76:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d79:	8b 45 08             	mov    0x8(%ebp),%eax
     d7c:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d80:	66 89 0a             	mov    %cx,(%edx)
     d83:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d87:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d8a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d8e:	8b 55 0c             	mov    0xc(%ebp),%edx
     d91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d94:	01 d0                	add    %edx,%eax
     d96:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     d99:	7d 93                	jge    d2e <APDrawPoint+0x59>
     d9b:	eb 01                	jmp    d9e <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     d9d:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     d9e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     da2:	8b 55 10             	mov    0x10(%ebp),%edx
     da5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da8:	01 d0                	add    %edx,%eax
     daa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     dad:	0f 8d 63 ff ff ff    	jge    d16 <APDrawPoint+0x41>
     db3:	eb 01                	jmp    db6 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     db5:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     db6:	c9                   	leave  
     db7:	c3                   	ret    

00000db8 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     db8:	55                   	push   %ebp
     db9:	89 e5                	mov    %esp,%ebp
     dbb:	53                   	push   %ebx
     dbc:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     dbf:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc2:	3b 45 14             	cmp    0x14(%ebp),%eax
     dc5:	0f 85 80 00 00 00    	jne    e4b <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     dcb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dcf:	0f 88 9d 02 00 00    	js     1072 <APDrawLine+0x2ba>
     dd5:	8b 45 08             	mov    0x8(%ebp),%eax
     dd8:	8b 00                	mov    (%eax),%eax
     dda:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ddd:	0f 8e 8f 02 00 00    	jle    1072 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     de3:	8b 45 10             	mov    0x10(%ebp),%eax
     de6:	3b 45 18             	cmp    0x18(%ebp),%eax
     de9:	7e 12                	jle    dfd <APDrawLine+0x45>
        {
            int tmp = y2;
     deb:	8b 45 18             	mov    0x18(%ebp),%eax
     dee:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     df1:	8b 45 10             	mov    0x10(%ebp),%eax
     df4:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     df7:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dfa:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     dfd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e01:	79 07                	jns    e0a <APDrawLine+0x52>
     e03:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e0a:	8b 45 08             	mov    0x8(%ebp),%eax
     e0d:	8b 40 04             	mov    0x4(%eax),%eax
     e10:	3b 45 18             	cmp    0x18(%ebp),%eax
     e13:	7d 0c                	jge    e21 <APDrawLine+0x69>
     e15:	8b 45 08             	mov    0x8(%ebp),%eax
     e18:	8b 40 04             	mov    0x4(%eax),%eax
     e1b:	83 e8 01             	sub    $0x1,%eax
     e1e:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e21:	8b 45 10             	mov    0x10(%ebp),%eax
     e24:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e27:	eb 15                	jmp    e3e <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e29:	ff 75 f4             	pushl  -0xc(%ebp)
     e2c:	ff 75 0c             	pushl  0xc(%ebp)
     e2f:	ff 75 08             	pushl  0x8(%ebp)
     e32:	e8 9e fe ff ff       	call   cd5 <APDrawPoint>
     e37:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e3a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e41:	3b 45 18             	cmp    0x18(%ebp),%eax
     e44:	7e e3                	jle    e29 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e46:	e9 2b 02 00 00       	jmp    1076 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e4b:	8b 45 10             	mov    0x10(%ebp),%eax
     e4e:	3b 45 18             	cmp    0x18(%ebp),%eax
     e51:	75 7f                	jne    ed2 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e53:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e57:	0f 88 18 02 00 00    	js     1075 <APDrawLine+0x2bd>
     e5d:	8b 45 08             	mov    0x8(%ebp),%eax
     e60:	8b 40 04             	mov    0x4(%eax),%eax
     e63:	3b 45 10             	cmp    0x10(%ebp),%eax
     e66:	0f 8e 09 02 00 00    	jle    1075 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6f:	3b 45 14             	cmp    0x14(%ebp),%eax
     e72:	7e 12                	jle    e86 <APDrawLine+0xce>
        {
            int tmp = x2;
     e74:	8b 45 14             	mov    0x14(%ebp),%eax
     e77:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7d:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e80:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e83:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e8a:	79 07                	jns    e93 <APDrawLine+0xdb>
     e8c:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e93:	8b 45 08             	mov    0x8(%ebp),%eax
     e96:	8b 00                	mov    (%eax),%eax
     e98:	3b 45 14             	cmp    0x14(%ebp),%eax
     e9b:	7d 0b                	jge    ea8 <APDrawLine+0xf0>
     e9d:	8b 45 08             	mov    0x8(%ebp),%eax
     ea0:	8b 00                	mov    (%eax),%eax
     ea2:	83 e8 01             	sub    $0x1,%eax
     ea5:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     ea8:	8b 45 0c             	mov    0xc(%ebp),%eax
     eab:	89 45 f0             	mov    %eax,-0x10(%ebp)
     eae:	eb 15                	jmp    ec5 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     eb0:	ff 75 10             	pushl  0x10(%ebp)
     eb3:	ff 75 f0             	pushl  -0x10(%ebp)
     eb6:	ff 75 08             	pushl  0x8(%ebp)
     eb9:	e8 17 fe ff ff       	call   cd5 <APDrawPoint>
     ebe:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     ec1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ec5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ec8:	3b 45 14             	cmp    0x14(%ebp),%eax
     ecb:	7e e3                	jle    eb0 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     ecd:	e9 a4 01 00 00       	jmp    1076 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ed2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ed9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ee0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee3:	2b 45 14             	sub    0x14(%ebp),%eax
     ee6:	50                   	push   %eax
     ee7:	e8 3d fa ff ff       	call   929 <abs_int>
     eec:	83 c4 04             	add    $0x4,%esp
     eef:	89 c3                	mov    %eax,%ebx
     ef1:	8b 45 10             	mov    0x10(%ebp),%eax
     ef4:	2b 45 18             	sub    0x18(%ebp),%eax
     ef7:	50                   	push   %eax
     ef8:	e8 2c fa ff ff       	call   929 <abs_int>
     efd:	83 c4 04             	add    $0x4,%esp
     f00:	39 c3                	cmp    %eax,%ebx
     f02:	0f 8e b5 00 00 00    	jle    fbd <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f08:	8b 45 10             	mov    0x10(%ebp),%eax
     f0b:	2b 45 18             	sub    0x18(%ebp),%eax
     f0e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f11:	db 45 b0             	fildl  -0x50(%ebp)
     f14:	8b 45 0c             	mov    0xc(%ebp),%eax
     f17:	2b 45 14             	sub    0x14(%ebp),%eax
     f1a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f1d:	db 45 b0             	fildl  -0x50(%ebp)
     f20:	de f9                	fdivrp %st,%st(1)
     f22:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f25:	8b 45 14             	mov    0x14(%ebp),%eax
     f28:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f2b:	7e 0e                	jle    f3b <APDrawLine+0x183>
        {
            s = x1;
     f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f30:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f33:	8b 45 14             	mov    0x14(%ebp),%eax
     f36:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f39:	eb 0c                	jmp    f47 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f3b:	8b 45 14             	mov    0x14(%ebp),%eax
     f3e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f41:	8b 45 0c             	mov    0xc(%ebp),%eax
     f44:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f47:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f4b:	79 07                	jns    f54 <APDrawLine+0x19c>
     f4d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f54:	8b 45 08             	mov    0x8(%ebp),%eax
     f57:	8b 00                	mov    (%eax),%eax
     f59:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f5c:	7f 0b                	jg     f69 <APDrawLine+0x1b1>
     f5e:	8b 45 08             	mov    0x8(%ebp),%eax
     f61:	8b 00                	mov    (%eax),%eax
     f63:	83 e8 01             	sub    $0x1,%eax
     f66:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f69:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f6f:	eb 3f                	jmp    fb0 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f74:	2b 45 0c             	sub    0xc(%ebp),%eax
     f77:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7a:	db 45 b0             	fildl  -0x50(%ebp)
     f7d:	dc 4d d0             	fmull  -0x30(%ebp)
     f80:	db 45 10             	fildl  0x10(%ebp)
     f83:	de c1                	faddp  %st,%st(1)
     f85:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f88:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f8c:	b4 0c                	mov    $0xc,%ah
     f8e:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f92:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f95:	db 5d cc             	fistpl -0x34(%ebp)
     f98:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     f9b:	ff 75 cc             	pushl  -0x34(%ebp)
     f9e:	ff 75 e4             	pushl  -0x1c(%ebp)
     fa1:	ff 75 08             	pushl  0x8(%ebp)
     fa4:	e8 2c fd ff ff       	call   cd5 <APDrawPoint>
     fa9:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fac:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     fb0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fb3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fb6:	7e b9                	jle    f71 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     fb8:	e9 b9 00 00 00       	jmp    1076 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     fbd:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc0:	2b 45 14             	sub    0x14(%ebp),%eax
     fc3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc6:	db 45 b0             	fildl  -0x50(%ebp)
     fc9:	8b 45 10             	mov    0x10(%ebp),%eax
     fcc:	2b 45 18             	sub    0x18(%ebp),%eax
     fcf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fd2:	db 45 b0             	fildl  -0x50(%ebp)
     fd5:	de f9                	fdivrp %st,%st(1)
     fd7:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fda:	8b 45 10             	mov    0x10(%ebp),%eax
     fdd:	3b 45 18             	cmp    0x18(%ebp),%eax
     fe0:	7e 0e                	jle    ff0 <APDrawLine+0x238>
    {
        s = y2;
     fe2:	8b 45 18             	mov    0x18(%ebp),%eax
     fe5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     fe8:	8b 45 10             	mov    0x10(%ebp),%eax
     feb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fee:	eb 0c                	jmp    ffc <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     ff0:	8b 45 10             	mov    0x10(%ebp),%eax
     ff3:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     ff6:	8b 45 18             	mov    0x18(%ebp),%eax
     ff9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
     ffc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1000:	79 07                	jns    1009 <APDrawLine+0x251>
    1002:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1009:	8b 45 08             	mov    0x8(%ebp),%eax
    100c:	8b 40 04             	mov    0x4(%eax),%eax
    100f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1012:	7f 0c                	jg     1020 <APDrawLine+0x268>
    1014:	8b 45 08             	mov    0x8(%ebp),%eax
    1017:	8b 40 04             	mov    0x4(%eax),%eax
    101a:	83 e8 01             	sub    $0x1,%eax
    101d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1020:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1023:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1026:	eb 3f                	jmp    1067 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1028:	8b 45 e0             	mov    -0x20(%ebp),%eax
    102b:	2b 45 10             	sub    0x10(%ebp),%eax
    102e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1031:	db 45 b0             	fildl  -0x50(%ebp)
    1034:	dc 4d c0             	fmull  -0x40(%ebp)
    1037:	db 45 0c             	fildl  0xc(%ebp)
    103a:	de c1                	faddp  %st,%st(1)
    103c:	d9 7d b6             	fnstcw -0x4a(%ebp)
    103f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1043:	b4 0c                	mov    $0xc,%ah
    1045:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1049:	d9 6d b4             	fldcw  -0x4c(%ebp)
    104c:	db 5d bc             	fistpl -0x44(%ebp)
    104f:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1052:	ff 75 e0             	pushl  -0x20(%ebp)
    1055:	ff 75 bc             	pushl  -0x44(%ebp)
    1058:	ff 75 08             	pushl  0x8(%ebp)
    105b:	e8 75 fc ff ff       	call   cd5 <APDrawPoint>
    1060:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1063:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1067:	8b 45 e0             	mov    -0x20(%ebp),%eax
    106a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    106d:	7e b9                	jle    1028 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    106f:	90                   	nop
    1070:	eb 04                	jmp    1076 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1072:	90                   	nop
    1073:	eb 01                	jmp    1076 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1075:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1076:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1079:	c9                   	leave  
    107a:	c3                   	ret    

0000107b <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    107b:	55                   	push   %ebp
    107c:	89 e5                	mov    %esp,%ebp
    107e:	53                   	push   %ebx
    107f:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1082:	8b 55 10             	mov    0x10(%ebp),%edx
    1085:	8b 45 18             	mov    0x18(%ebp),%eax
    1088:	01 d0                	add    %edx,%eax
    108a:	83 e8 01             	sub    $0x1,%eax
    108d:	83 ec 04             	sub    $0x4,%esp
    1090:	50                   	push   %eax
    1091:	ff 75 0c             	pushl  0xc(%ebp)
    1094:	ff 75 10             	pushl  0x10(%ebp)
    1097:	ff 75 0c             	pushl  0xc(%ebp)
    109a:	ff 75 08             	pushl  0x8(%ebp)
    109d:	e8 16 fd ff ff       	call   db8 <APDrawLine>
    10a2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    10a8:	8b 45 14             	mov    0x14(%ebp),%eax
    10ab:	01 d0                	add    %edx,%eax
    10ad:	83 e8 01             	sub    $0x1,%eax
    10b0:	83 ec 04             	sub    $0x4,%esp
    10b3:	ff 75 10             	pushl  0x10(%ebp)
    10b6:	50                   	push   %eax
    10b7:	ff 75 10             	pushl  0x10(%ebp)
    10ba:	ff 75 0c             	pushl  0xc(%ebp)
    10bd:	ff 75 08             	pushl  0x8(%ebp)
    10c0:	e8 f3 fc ff ff       	call   db8 <APDrawLine>
    10c5:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    10c8:	8b 55 10             	mov    0x10(%ebp),%edx
    10cb:	8b 45 18             	mov    0x18(%ebp),%eax
    10ce:	01 d0                	add    %edx,%eax
    10d0:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10d3:	8b 55 0c             	mov    0xc(%ebp),%edx
    10d6:	8b 45 14             	mov    0x14(%ebp),%eax
    10d9:	01 d0                	add    %edx,%eax
    10db:	8d 50 ff             	lea    -0x1(%eax),%edx
    10de:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10e1:	8b 45 14             	mov    0x14(%ebp),%eax
    10e4:	01 d8                	add    %ebx,%eax
    10e6:	83 e8 01             	sub    $0x1,%eax
    10e9:	83 ec 04             	sub    $0x4,%esp
    10ec:	51                   	push   %ecx
    10ed:	52                   	push   %edx
    10ee:	ff 75 10             	pushl  0x10(%ebp)
    10f1:	50                   	push   %eax
    10f2:	ff 75 08             	pushl  0x8(%ebp)
    10f5:	e8 be fc ff ff       	call   db8 <APDrawLine>
    10fa:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    10fd:	8b 55 10             	mov    0x10(%ebp),%edx
    1100:	8b 45 18             	mov    0x18(%ebp),%eax
    1103:	01 d0                	add    %edx,%eax
    1105:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1108:	8b 55 0c             	mov    0xc(%ebp),%edx
    110b:	8b 45 14             	mov    0x14(%ebp),%eax
    110e:	01 d0                	add    %edx,%eax
    1110:	8d 50 ff             	lea    -0x1(%eax),%edx
    1113:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1116:	8b 45 18             	mov    0x18(%ebp),%eax
    1119:	01 d8                	add    %ebx,%eax
    111b:	83 e8 01             	sub    $0x1,%eax
    111e:	83 ec 04             	sub    $0x4,%esp
    1121:	51                   	push   %ecx
    1122:	52                   	push   %edx
    1123:	50                   	push   %eax
    1124:	ff 75 0c             	pushl  0xc(%ebp)
    1127:	ff 75 08             	pushl  0x8(%ebp)
    112a:	e8 89 fc ff ff       	call   db8 <APDrawLine>
    112f:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1132:	8b 55 0c             	mov    0xc(%ebp),%edx
    1135:	8b 45 14             	mov    0x14(%ebp),%eax
    1138:	01 d0                	add    %edx,%eax
    113a:	8d 50 ff             	lea    -0x1(%eax),%edx
    113d:	8b 45 08             	mov    0x8(%ebp),%eax
    1140:	8b 40 0c             	mov    0xc(%eax),%eax
    1143:	89 c1                	mov    %eax,%ecx
    1145:	c1 e9 1f             	shr    $0x1f,%ecx
    1148:	01 c8                	add    %ecx,%eax
    114a:	d1 f8                	sar    %eax
    114c:	29 c2                	sub    %eax,%edx
    114e:	89 d0                	mov    %edx,%eax
    1150:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1153:	8b 55 10             	mov    0x10(%ebp),%edx
    1156:	8b 45 18             	mov    0x18(%ebp),%eax
    1159:	01 d0                	add    %edx,%eax
    115b:	8d 50 ff             	lea    -0x1(%eax),%edx
    115e:	8b 45 08             	mov    0x8(%ebp),%eax
    1161:	8b 40 0c             	mov    0xc(%eax),%eax
    1164:	89 c1                	mov    %eax,%ecx
    1166:	c1 e9 1f             	shr    $0x1f,%ecx
    1169:	01 c8                	add    %ecx,%eax
    116b:	d1 f8                	sar    %eax
    116d:	29 c2                	sub    %eax,%edx
    116f:	89 d0                	mov    %edx,%eax
    1171:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	8b 40 0c             	mov    0xc(%eax),%eax
    117a:	89 c2                	mov    %eax,%edx
    117c:	c1 ea 1f             	shr    $0x1f,%edx
    117f:	01 d0                	add    %edx,%eax
    1181:	d1 f8                	sar    %eax
    1183:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1186:	8b 45 08             	mov    0x8(%ebp),%eax
    1189:	8b 40 0c             	mov    0xc(%eax),%eax
    118c:	89 c2                	mov    %eax,%edx
    118e:	c1 ea 1f             	shr    $0x1f,%edx
    1191:	01 d0                	add    %edx,%eax
    1193:	d1 f8                	sar    %eax
    1195:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1198:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    119c:	0f 88 d8 00 00 00    	js     127a <APDrawRect+0x1ff>
    11a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11a6:	0f 88 ce 00 00 00    	js     127a <APDrawRect+0x1ff>
    11ac:	8b 45 08             	mov    0x8(%ebp),%eax
    11af:	8b 00                	mov    (%eax),%eax
    11b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11b4:	0f 8e c0 00 00 00    	jle    127a <APDrawRect+0x1ff>
    11ba:	8b 45 08             	mov    0x8(%ebp),%eax
    11bd:	8b 40 04             	mov    0x4(%eax),%eax
    11c0:	3b 45 10             	cmp    0x10(%ebp),%eax
    11c3:	0f 8e b1 00 00 00    	jle    127a <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    11c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11cd:	79 07                	jns    11d6 <APDrawRect+0x15b>
    11cf:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11d6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11da:	79 07                	jns    11e3 <APDrawRect+0x168>
    11dc:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	8b 00                	mov    (%eax),%eax
    11e8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11eb:	7f 0b                	jg     11f8 <APDrawRect+0x17d>
    11ed:	8b 45 08             	mov    0x8(%ebp),%eax
    11f0:	8b 00                	mov    (%eax),%eax
    11f2:	83 e8 01             	sub    $0x1,%eax
    11f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    11f8:	8b 45 08             	mov    0x8(%ebp),%eax
    11fb:	8b 40 04             	mov    0x4(%eax),%eax
    11fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1201:	7f 0c                	jg     120f <APDrawRect+0x194>
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
    1206:	8b 40 04             	mov    0x4(%eax),%eax
    1209:	83 e8 01             	sub    $0x1,%eax
    120c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    120f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1216:	8b 45 0c             	mov    0xc(%ebp),%eax
    1219:	89 45 ec             	mov    %eax,-0x14(%ebp)
    121c:	eb 52                	jmp    1270 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    121e:	8b 45 10             	mov    0x10(%ebp),%eax
    1221:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1224:	eb 3e                	jmp    1264 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1226:	83 ec 04             	sub    $0x4,%esp
    1229:	ff 75 e8             	pushl  -0x18(%ebp)
    122c:	ff 75 ec             	pushl  -0x14(%ebp)
    122f:	ff 75 08             	pushl  0x8(%ebp)
    1232:	e8 02 f7 ff ff       	call   939 <APGetIndex>
    1237:	83 c4 10             	add    $0x10,%esp
    123a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    123d:	8b 45 08             	mov    0x8(%ebp),%eax
    1240:	8b 48 18             	mov    0x18(%eax),%ecx
    1243:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1246:	89 d0                	mov    %edx,%eax
    1248:	01 c0                	add    %eax,%eax
    124a:	01 d0                	add    %edx,%eax
    124c:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    124f:	8b 45 08             	mov    0x8(%ebp),%eax
    1252:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1256:	66 89 0a             	mov    %cx,(%edx)
    1259:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    125d:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1260:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1264:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1267:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    126a:	7e ba                	jle    1226 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    126c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1270:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1273:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1276:	7e a6                	jle    121e <APDrawRect+0x1a3>
    1278:	eb 01                	jmp    127b <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    127a:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    127b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    127e:	c9                   	leave  
    127f:	c3                   	ret    

00001280 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
}
    1283:	90                   	nop
    1284:	5d                   	pop    %ebp
    1285:	c3                   	ret    

00001286 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1286:	55                   	push   %ebp
    1287:	89 e5                	mov    %esp,%ebp
    1289:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    128c:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1290:	0f 88 8e 01 00 00    	js     1424 <APDcCopy+0x19e>
    1296:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    129a:	0f 88 84 01 00 00    	js     1424 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12a0:	8b 55 0c             	mov    0xc(%ebp),%edx
    12a3:	8b 45 20             	mov    0x20(%ebp),%eax
    12a6:	01 d0                	add    %edx,%eax
    12a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12ab:	8b 55 10             	mov    0x10(%ebp),%edx
    12ae:	8b 45 24             	mov    0x24(%ebp),%eax
    12b1:	01 d0                	add    %edx,%eax
    12b3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12b6:	8b 55 18             	mov    0x18(%ebp),%edx
    12b9:	8b 45 20             	mov    0x20(%ebp),%eax
    12bc:	01 d0                	add    %edx,%eax
    12be:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12c1:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12c4:	8b 45 24             	mov    0x24(%ebp),%eax
    12c7:	01 d0                	add    %edx,%eax
    12c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12d0:	0f 88 51 01 00 00    	js     1427 <APDcCopy+0x1a1>
    12d6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12da:	0f 88 47 01 00 00    	js     1427 <APDcCopy+0x1a1>
    12e0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12e4:	0f 88 3d 01 00 00    	js     1427 <APDcCopy+0x1a1>
    12ea:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12ee:	0f 88 33 01 00 00    	js     1427 <APDcCopy+0x1a1>
    12f4:	8b 45 14             	mov    0x14(%ebp),%eax
    12f7:	8b 00                	mov    (%eax),%eax
    12f9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12fc:	0f 8c 25 01 00 00    	jl     1427 <APDcCopy+0x1a1>
    1302:	8b 45 14             	mov    0x14(%ebp),%eax
    1305:	8b 40 04             	mov    0x4(%eax),%eax
    1308:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    130b:	0f 8c 16 01 00 00    	jl     1427 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1311:	8b 45 08             	mov    0x8(%ebp),%eax
    1314:	8b 00                	mov    (%eax),%eax
    1316:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1319:	7f 0b                	jg     1326 <APDcCopy+0xa0>
    131b:	8b 45 08             	mov    0x8(%ebp),%eax
    131e:	8b 00                	mov    (%eax),%eax
    1320:	83 e8 01             	sub    $0x1,%eax
    1323:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1326:	8b 45 08             	mov    0x8(%ebp),%eax
    1329:	8b 40 04             	mov    0x4(%eax),%eax
    132c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    132f:	7f 0c                	jg     133d <APDcCopy+0xb7>
    1331:	8b 45 08             	mov    0x8(%ebp),%eax
    1334:	8b 40 04             	mov    0x4(%eax),%eax
    1337:	83 e8 01             	sub    $0x1,%eax
    133a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    133d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1344:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    134b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1352:	e9 bc 00 00 00       	jmp    1413 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1357:	8b 45 08             	mov    0x8(%ebp),%eax
    135a:	8b 00                	mov    (%eax),%eax
    135c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    135f:	8b 55 10             	mov    0x10(%ebp),%edx
    1362:	01 ca                	add    %ecx,%edx
    1364:	0f af d0             	imul   %eax,%edx
    1367:	8b 45 0c             	mov    0xc(%ebp),%eax
    136a:	01 d0                	add    %edx,%eax
    136c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    136f:	8b 45 14             	mov    0x14(%ebp),%eax
    1372:	8b 00                	mov    (%eax),%eax
    1374:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1377:	8b 55 1c             	mov    0x1c(%ebp),%edx
    137a:	01 ca                	add    %ecx,%edx
    137c:	0f af d0             	imul   %eax,%edx
    137f:	8b 45 18             	mov    0x18(%ebp),%eax
    1382:	01 d0                	add    %edx,%eax
    1384:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1387:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    138e:	eb 74                	jmp    1404 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1390:	8b 45 14             	mov    0x14(%ebp),%eax
    1393:	8b 50 18             	mov    0x18(%eax),%edx
    1396:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1399:	8b 45 f0             	mov    -0x10(%ebp),%eax
    139c:	01 c8                	add    %ecx,%eax
    139e:	89 c1                	mov    %eax,%ecx
    13a0:	89 c8                	mov    %ecx,%eax
    13a2:	01 c0                	add    %eax,%eax
    13a4:	01 c8                	add    %ecx,%eax
    13a6:	01 d0                	add    %edx,%eax
    13a8:	0f b7 10             	movzwl (%eax),%edx
    13ab:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13af:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13b3:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13b6:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ba:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13be:	38 c2                	cmp    %al,%dl
    13c0:	75 18                	jne    13da <APDcCopy+0x154>
    13c2:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13c6:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13ca:	38 c2                	cmp    %al,%dl
    13cc:	75 0c                	jne    13da <APDcCopy+0x154>
    13ce:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13d2:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13d6:	38 c2                	cmp    %al,%dl
    13d8:	74 26                	je     1400 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13da:	8b 45 08             	mov    0x8(%ebp),%eax
    13dd:	8b 50 18             	mov    0x18(%eax),%edx
    13e0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e6:	01 c8                	add    %ecx,%eax
    13e8:	89 c1                	mov    %eax,%ecx
    13ea:	89 c8                	mov    %ecx,%eax
    13ec:	01 c0                	add    %eax,%eax
    13ee:	01 c8                	add    %ecx,%eax
    13f0:	01 d0                	add    %edx,%eax
    13f2:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13f6:	66 89 10             	mov    %dx,(%eax)
    13f9:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13fd:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1400:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1404:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1407:	2b 45 0c             	sub    0xc(%ebp),%eax
    140a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    140d:	7d 81                	jge    1390 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    140f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1413:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1416:	2b 45 10             	sub    0x10(%ebp),%eax
    1419:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    141c:	0f 8d 35 ff ff ff    	jge    1357 <APDcCopy+0xd1>
    1422:	eb 04                	jmp    1428 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1424:	90                   	nop
    1425:	eb 01                	jmp    1428 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1427:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1428:	c9                   	leave  
    1429:	c3                   	ret    

0000142a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    142a:	55                   	push   %ebp
    142b:	89 e5                	mov    %esp,%ebp
    142d:	83 ec 1c             	sub    $0x1c,%esp
    1430:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1433:	8b 55 10             	mov    0x10(%ebp),%edx
    1436:	8b 45 14             	mov    0x14(%ebp),%eax
    1439:	88 4d ec             	mov    %cl,-0x14(%ebp)
    143c:	88 55 e8             	mov    %dl,-0x18(%ebp)
    143f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1442:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1446:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1449:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    144d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1450:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1454:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1457:	8b 45 08             	mov    0x8(%ebp),%eax
    145a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    145e:	66 89 10             	mov    %dx,(%eax)
    1461:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1465:	88 50 02             	mov    %dl,0x2(%eax)
}
    1468:	8b 45 08             	mov    0x8(%ebp),%eax
    146b:	c9                   	leave  
    146c:	c2 04 00             	ret    $0x4

0000146f <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    146f:	55                   	push   %ebp
    1470:	89 e5                	mov    %esp,%ebp
    1472:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1475:	8b 45 08             	mov    0x8(%ebp),%eax
    1478:	8b 00                	mov    (%eax),%eax
    147a:	83 ec 08             	sub    $0x8,%esp
    147d:	8d 55 0c             	lea    0xc(%ebp),%edx
    1480:	52                   	push   %edx
    1481:	50                   	push   %eax
    1482:	e8 87 ef ff ff       	call   40e <sendMessage>
    1487:	83 c4 10             	add    $0x10,%esp
}
    148a:	90                   	nop
    148b:	c9                   	leave  
    148c:	c3                   	ret    

0000148d <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    148d:	55                   	push   %ebp
    148e:	89 e5                	mov    %esp,%ebp
    1490:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1493:	83 ec 0c             	sub    $0xc,%esp
    1496:	68 98 00 00 00       	push   $0x98
    149b:	e8 38 f3 ff ff       	call   7d8 <malloc>
    14a0:	83 c4 10             	add    $0x10,%esp
    14a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14aa:	75 15                	jne    14c1 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14ac:	83 ec 04             	sub    $0x4,%esp
    14af:	ff 75 08             	pushl  0x8(%ebp)
    14b2:	68 08 23 00 00       	push   $0x2308
    14b7:	6a 01                	push   $0x1
    14b9:	e8 47 f0 ff ff       	call   505 <printf>
    14be:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c4:	05 84 00 00 00       	add    $0x84,%eax
    14c9:	83 ec 08             	sub    $0x8,%esp
    14cc:	ff 75 08             	pushl  0x8(%ebp)
    14cf:	50                   	push   %eax
    14d0:	e8 60 ec ff ff       	call   135 <strcpy>
    14d5:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14db:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e5:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ef:	8b 40 3c             	mov    0x3c(%eax),%eax
    14f2:	89 c2                	mov    %eax,%edx
    14f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f7:	8b 40 40             	mov    0x40(%eax),%eax
    14fa:	0f af d0             	imul   %eax,%edx
    14fd:	89 d0                	mov    %edx,%eax
    14ff:	01 c0                	add    %eax,%eax
    1501:	01 d0                	add    %edx,%eax
    1503:	83 ec 0c             	sub    $0xc,%esp
    1506:	50                   	push   %eax
    1507:	e8 cc f2 ff ff       	call   7d8 <malloc>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	89 c2                	mov    %eax,%edx
    1511:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1514:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1517:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151a:	8b 40 54             	mov    0x54(%eax),%eax
    151d:	85 c0                	test   %eax,%eax
    151f:	75 15                	jne    1536 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1521:	83 ec 04             	sub    $0x4,%esp
    1524:	ff 75 08             	pushl  0x8(%ebp)
    1527:	68 28 23 00 00       	push   $0x2328
    152c:	6a 01                	push   $0x1
    152e:	e8 d2 ef ff ff       	call   505 <printf>
    1533:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	8b 40 3c             	mov    0x3c(%eax),%eax
    153c:	89 c2                	mov    %eax,%edx
    153e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1541:	8b 40 40             	mov    0x40(%eax),%eax
    1544:	0f af d0             	imul   %eax,%edx
    1547:	89 d0                	mov    %edx,%eax
    1549:	01 c0                	add    %eax,%eax
    154b:	01 c2                	add    %eax,%edx
    154d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1550:	8b 40 54             	mov    0x54(%eax),%eax
    1553:	83 ec 04             	sub    $0x4,%esp
    1556:	52                   	push   %edx
    1557:	68 ff ff ff 00       	push   $0xffffff
    155c:	50                   	push   %eax
    155d:	e8 69 ec ff ff       	call   1cb <memset>
    1562:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1565:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1568:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    156f:	e8 72 ee ff ff       	call   3e6 <getpid>
    1574:	89 c2                	mov    %eax,%edx
    1576:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1579:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    157c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157f:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1586:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1589:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	8b 40 58             	mov    0x58(%eax),%eax
    1596:	89 c2                	mov    %eax,%edx
    1598:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159b:	8b 40 5c             	mov    0x5c(%eax),%eax
    159e:	0f af d0             	imul   %eax,%edx
    15a1:	89 d0                	mov    %edx,%eax
    15a3:	01 c0                	add    %eax,%eax
    15a5:	01 d0                	add    %edx,%eax
    15a7:	83 ec 0c             	sub    $0xc,%esp
    15aa:	50                   	push   %eax
    15ab:	e8 28 f2 ff ff       	call   7d8 <malloc>
    15b0:	83 c4 10             	add    $0x10,%esp
    15b3:	89 c2                	mov    %eax,%edx
    15b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b8:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    15bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15be:	8b 40 70             	mov    0x70(%eax),%eax
    15c1:	85 c0                	test   %eax,%eax
    15c3:	75 15                	jne    15da <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15c5:	83 ec 04             	sub    $0x4,%esp
    15c8:	ff 75 08             	pushl  0x8(%ebp)
    15cb:	68 4c 23 00 00       	push   $0x234c
    15d0:	6a 01                	push   $0x1
    15d2:	e8 2e ef ff ff       	call   505 <printf>
    15d7:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dd:	8b 40 3c             	mov    0x3c(%eax),%eax
    15e0:	89 c2                	mov    %eax,%edx
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 40             	mov    0x40(%eax),%eax
    15e8:	0f af d0             	imul   %eax,%edx
    15eb:	89 d0                	mov    %edx,%eax
    15ed:	01 c0                	add    %eax,%eax
    15ef:	01 c2                	add    %eax,%edx
    15f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f4:	8b 40 54             	mov    0x54(%eax),%eax
    15f7:	83 ec 04             	sub    $0x4,%esp
    15fa:	52                   	push   %edx
    15fb:	68 ff 00 00 00       	push   $0xff
    1600:	50                   	push   %eax
    1601:	e8 c5 eb ff ff       	call   1cb <memset>
    1606:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1609:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160c:	8b 55 0c             	mov    0xc(%ebp),%edx
    160f:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1612:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1616:	74 49                	je     1661 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1618:	8b 45 10             	mov    0x10(%ebp),%eax
    161b:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1621:	83 ec 0c             	sub    $0xc,%esp
    1624:	50                   	push   %eax
    1625:	e8 ae f1 ff ff       	call   7d8 <malloc>
    162a:	83 c4 10             	add    $0x10,%esp
    162d:	89 c2                	mov    %eax,%edx
    162f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1632:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	8b 55 10             	mov    0x10(%ebp),%edx
    163b:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    163e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1641:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1648:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1652:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1655:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    165c:	e9 8d 00 00 00       	jmp    16ee <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1664:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    166b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166e:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1675:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1678:	8b 40 20             	mov    0x20(%eax),%eax
    167b:	89 c2                	mov    %eax,%edx
    167d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1680:	8b 40 24             	mov    0x24(%eax),%eax
    1683:	0f af d0             	imul   %eax,%edx
    1686:	89 d0                	mov    %edx,%eax
    1688:	01 c0                	add    %eax,%eax
    168a:	01 d0                	add    %edx,%eax
    168c:	83 ec 0c             	sub    $0xc,%esp
    168f:	50                   	push   %eax
    1690:	e8 43 f1 ff ff       	call   7d8 <malloc>
    1695:	83 c4 10             	add    $0x10,%esp
    1698:	89 c2                	mov    %eax,%edx
    169a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169d:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    16a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a3:	8b 40 38             	mov    0x38(%eax),%eax
    16a6:	85 c0                	test   %eax,%eax
    16a8:	75 15                	jne    16bf <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16aa:	83 ec 04             	sub    $0x4,%esp
    16ad:	ff 75 08             	pushl  0x8(%ebp)
    16b0:	68 74 23 00 00       	push   $0x2374
    16b5:	6a 01                	push   $0x1
    16b7:	e8 49 ee ff ff       	call   505 <printf>
    16bc:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c2:	8b 40 20             	mov    0x20(%eax),%eax
    16c5:	89 c2                	mov    %eax,%edx
    16c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ca:	8b 40 24             	mov    0x24(%eax),%eax
    16cd:	0f af d0             	imul   %eax,%edx
    16d0:	89 d0                	mov    %edx,%eax
    16d2:	01 c0                	add    %eax,%eax
    16d4:	01 c2                	add    %eax,%edx
    16d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d9:	8b 40 38             	mov    0x38(%eax),%eax
    16dc:	83 ec 04             	sub    $0x4,%esp
    16df:	52                   	push   %edx
    16e0:	68 ff ff ff 00       	push   $0xffffff
    16e5:	50                   	push   %eax
    16e6:	e8 e0 ea ff ff       	call   1cb <memset>
    16eb:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16f1:	c9                   	leave  
    16f2:	c3                   	ret    

000016f3 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16f3:	55                   	push   %ebp
    16f4:	89 e5                	mov    %esp,%ebp
    16f6:	57                   	push   %edi
    16f7:	56                   	push   %esi
    16f8:	53                   	push   %ebx
    16f9:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    16ff:	83 f8 03             	cmp    $0x3,%eax
    1702:	74 02                	je     1706 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1704:	eb 7c                	jmp    1782 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1706:	8b 45 08             	mov    0x8(%ebp),%eax
    1709:	8b 58 1c             	mov    0x1c(%eax),%ebx
    170c:	8b 45 08             	mov    0x8(%ebp),%eax
    170f:	8b 48 18             	mov    0x18(%eax),%ecx
    1712:	8b 45 08             	mov    0x8(%ebp),%eax
    1715:	8b 50 5c             	mov    0x5c(%eax),%edx
    1718:	8b 45 08             	mov    0x8(%ebp),%eax
    171b:	8b 40 58             	mov    0x58(%eax),%eax
    171e:	8b 75 08             	mov    0x8(%ebp),%esi
    1721:	83 c6 58             	add    $0x58,%esi
    1724:	83 ec 04             	sub    $0x4,%esp
    1727:	53                   	push   %ebx
    1728:	51                   	push   %ecx
    1729:	6a 00                	push   $0x0
    172b:	52                   	push   %edx
    172c:	50                   	push   %eax
    172d:	6a 00                	push   $0x0
    172f:	6a 00                	push   $0x0
    1731:	56                   	push   %esi
    1732:	6a 00                	push   $0x0
    1734:	6a 00                	push   $0x0
    1736:	ff 75 08             	pushl  0x8(%ebp)
    1739:	e8 c8 ec ff ff       	call   406 <paintWindow>
    173e:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1741:	8b 45 08             	mov    0x8(%ebp),%eax
    1744:	8b 70 1c             	mov    0x1c(%eax),%esi
    1747:	8b 45 08             	mov    0x8(%ebp),%eax
    174a:	8b 58 18             	mov    0x18(%eax),%ebx
    174d:	8b 45 08             	mov    0x8(%ebp),%eax
    1750:	8b 48 08             	mov    0x8(%eax),%ecx
    1753:	8b 45 08             	mov    0x8(%ebp),%eax
    1756:	8b 50 40             	mov    0x40(%eax),%edx
    1759:	8b 45 08             	mov    0x8(%ebp),%eax
    175c:	8b 40 3c             	mov    0x3c(%eax),%eax
    175f:	8b 7d 08             	mov    0x8(%ebp),%edi
    1762:	83 c7 3c             	add    $0x3c,%edi
    1765:	83 ec 04             	sub    $0x4,%esp
    1768:	56                   	push   %esi
    1769:	53                   	push   %ebx
    176a:	51                   	push   %ecx
    176b:	52                   	push   %edx
    176c:	50                   	push   %eax
    176d:	6a 00                	push   $0x0
    176f:	6a 00                	push   $0x0
    1771:	57                   	push   %edi
    1772:	6a 32                	push   $0x32
    1774:	6a 00                	push   $0x0
    1776:	ff 75 08             	pushl  0x8(%ebp)
    1779:	e8 88 ec ff ff       	call   406 <paintWindow>
    177e:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1781:	90                   	nop
        default: break;
            
            
    }
    return False;
    1782:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1787:	8d 65 f4             	lea    -0xc(%ebp),%esp
    178a:	5b                   	pop    %ebx
    178b:	5e                   	pop    %esi
    178c:	5f                   	pop    %edi
    178d:	5d                   	pop    %ebp
    178e:	c3                   	ret    

0000178f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    178f:	55                   	push   %ebp
    1790:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1792:	8b 45 0c             	mov    0xc(%ebp),%eax
    1795:	8b 50 08             	mov    0x8(%eax),%edx
    1798:	8b 45 08             	mov    0x8(%ebp),%eax
    179b:	8b 00                	mov    (%eax),%eax
    179d:	39 c2                	cmp    %eax,%edx
    179f:	74 07                	je     17a8 <APPreJudge+0x19>
        return False;
    17a1:	b8 00 00 00 00       	mov    $0x0,%eax
    17a6:	eb 05                	jmp    17ad <APPreJudge+0x1e>
    return True;
    17a8:	b8 01 00 00 00       	mov    $0x1,%eax
}
    17ad:	5d                   	pop    %ebp
    17ae:	c3                   	ret    

000017af <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17af:	55                   	push   %ebp
    17b0:	89 e5                	mov    %esp,%ebp
    17b2:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    17b5:	8b 45 08             	mov    0x8(%ebp),%eax
    17b8:	8b 55 0c             	mov    0xc(%ebp),%edx
    17bb:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    17c1:	83 ec 0c             	sub    $0xc,%esp
    17c4:	ff 75 08             	pushl  0x8(%ebp)
    17c7:	e8 52 ec ff ff       	call   41e <registWindow>
    17cc:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17cf:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17d6:	8b 45 08             	mov    0x8(%ebp),%eax
    17d9:	8b 00                	mov    (%eax),%eax
    17db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17de:	ff 75 f4             	pushl  -0xc(%ebp)
    17e1:	ff 75 f0             	pushl  -0x10(%ebp)
    17e4:	ff 75 ec             	pushl  -0x14(%ebp)
    17e7:	ff 75 08             	pushl  0x8(%ebp)
    17ea:	e8 80 fc ff ff       	call   146f <APSendMessage>
    17ef:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    17f2:	83 ec 0c             	sub    $0xc,%esp
    17f5:	ff 75 08             	pushl  0x8(%ebp)
    17f8:	e8 19 ec ff ff       	call   416 <getMessage>
    17fd:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1800:	8b 45 08             	mov    0x8(%ebp),%eax
    1803:	83 c0 74             	add    $0x74,%eax
    1806:	83 ec 08             	sub    $0x8,%esp
    1809:	50                   	push   %eax
    180a:	ff 75 08             	pushl  0x8(%ebp)
    180d:	e8 7d ff ff ff       	call   178f <APPreJudge>
    1812:	83 c4 10             	add    $0x10,%esp
    1815:	84 c0                	test   %al,%al
    1817:	74 1b                	je     1834 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1819:	8b 45 08             	mov    0x8(%ebp),%eax
    181c:	ff 70 7c             	pushl  0x7c(%eax)
    181f:	ff 70 78             	pushl  0x78(%eax)
    1822:	ff 70 74             	pushl  0x74(%eax)
    1825:	ff 75 08             	pushl  0x8(%ebp)
    1828:	8b 45 0c             	mov    0xc(%ebp),%eax
    182b:	ff d0                	call   *%eax
    182d:	83 c4 10             	add    $0x10,%esp
    1830:	84 c0                	test   %al,%al
    1832:	75 0c                	jne    1840 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1834:	8b 45 08             	mov    0x8(%ebp),%eax
    1837:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    183e:	eb b2                	jmp    17f2 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1840:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1841:	90                   	nop
    1842:	c9                   	leave  
    1843:	c3                   	ret    

00001844 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1844:	55                   	push   %ebp
    1845:	89 e5                	mov    %esp,%ebp
    1847:	57                   	push   %edi
    1848:	56                   	push   %esi
    1849:	53                   	push   %ebx
    184a:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    184d:	a1 2c 2a 00 00       	mov    0x2a2c,%eax
    1852:	85 c0                	test   %eax,%eax
    1854:	0f 85 2c 02 00 00    	jne    1a86 <APGridPaint+0x242>
    {
        iconReady = 1;
    185a:	c7 05 2c 2a 00 00 01 	movl   $0x1,0x2a2c
    1861:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1864:	8d 45 98             	lea    -0x68(%ebp),%eax
    1867:	83 ec 08             	sub    $0x8,%esp
    186a:	68 9b 23 00 00       	push   $0x239b
    186f:	50                   	push   %eax
    1870:	e8 16 f1 ff ff       	call   98b <APLoadBitmap>
    1875:	83 c4 0c             	add    $0xc,%esp
    1878:	8b 45 98             	mov    -0x68(%ebp),%eax
    187b:	a3 60 2c 00 00       	mov    %eax,0x2c60
    1880:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1883:	a3 64 2c 00 00       	mov    %eax,0x2c64
    1888:	8b 45 a0             	mov    -0x60(%ebp),%eax
    188b:	a3 68 2c 00 00       	mov    %eax,0x2c68
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1890:	83 ec 04             	sub    $0x4,%esp
    1893:	ff 35 68 2c 00 00    	pushl  0x2c68
    1899:	ff 35 64 2c 00 00    	pushl  0x2c64
    189f:	ff 35 60 2c 00 00    	pushl  0x2c60
    18a5:	e8 1b f3 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    18aa:	83 c4 10             	add    $0x10,%esp
    18ad:	a3 6c 2c 00 00       	mov    %eax,0x2c6c
        grid_river = APLoadBitmap ("grid_river.bmp");
    18b2:	8d 45 98             	lea    -0x68(%ebp),%eax
    18b5:	83 ec 08             	sub    $0x8,%esp
    18b8:	68 a9 23 00 00       	push   $0x23a9
    18bd:	50                   	push   %eax
    18be:	e8 c8 f0 ff ff       	call   98b <APLoadBitmap>
    18c3:	83 c4 0c             	add    $0xc,%esp
    18c6:	8b 45 98             	mov    -0x68(%ebp),%eax
    18c9:	a3 9c 2c 00 00       	mov    %eax,0x2c9c
    18ce:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d1:	a3 a0 2c 00 00       	mov    %eax,0x2ca0
    18d6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18d9:	a3 a4 2c 00 00       	mov    %eax,0x2ca4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    18de:	83 ec 04             	sub    $0x4,%esp
    18e1:	ff 35 a4 2c 00 00    	pushl  0x2ca4
    18e7:	ff 35 a0 2c 00 00    	pushl  0x2ca0
    18ed:	ff 35 9c 2c 00 00    	pushl  0x2c9c
    18f3:	e8 cd f2 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    18f8:	83 c4 10             	add    $0x10,%esp
    18fb:	a3 8c 2c 00 00       	mov    %eax,0x2c8c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1900:	8d 45 98             	lea    -0x68(%ebp),%eax
    1903:	83 ec 08             	sub    $0x8,%esp
    1906:	68 b8 23 00 00       	push   $0x23b8
    190b:	50                   	push   %eax
    190c:	e8 7a f0 ff ff       	call   98b <APLoadBitmap>
    1911:	83 c4 0c             	add    $0xc,%esp
    1914:	8b 45 98             	mov    -0x68(%ebp),%eax
    1917:	a3 90 2c 00 00       	mov    %eax,0x2c90
    191c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    191f:	a3 94 2c 00 00       	mov    %eax,0x2c94
    1924:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1927:	a3 98 2c 00 00       	mov    %eax,0x2c98
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    192c:	83 ec 04             	sub    $0x4,%esp
    192f:	ff 35 98 2c 00 00    	pushl  0x2c98
    1935:	ff 35 94 2c 00 00    	pushl  0x2c94
    193b:	ff 35 90 2c 00 00    	pushl  0x2c90
    1941:	e8 7f f2 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    1946:	83 c4 10             	add    $0x10,%esp
    1949:	a3 40 2c 00 00       	mov    %eax,0x2c40
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    194e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1951:	83 ec 08             	sub    $0x8,%esp
    1954:	68 c7 23 00 00       	push   $0x23c7
    1959:	50                   	push   %eax
    195a:	e8 2c f0 ff ff       	call   98b <APLoadBitmap>
    195f:	83 c4 0c             	add    $0xc,%esp
    1962:	8b 45 98             	mov    -0x68(%ebp),%eax
    1965:	a3 74 2c 00 00       	mov    %eax,0x2c74
    196a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    196d:	a3 78 2c 00 00       	mov    %eax,0x2c78
    1972:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1975:	a3 7c 2c 00 00       	mov    %eax,0x2c7c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    197a:	83 ec 04             	sub    $0x4,%esp
    197d:	ff 35 7c 2c 00 00    	pushl  0x2c7c
    1983:	ff 35 78 2c 00 00    	pushl  0x2c78
    1989:	ff 35 74 2c 00 00    	pushl  0x2c74
    198f:	e8 31 f2 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    1994:	83 c4 10             	add    $0x10,%esp
    1997:	a3 a8 2c 00 00       	mov    %eax,0x2ca8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    199c:	8d 45 98             	lea    -0x68(%ebp),%eax
    199f:	83 ec 08             	sub    $0x8,%esp
    19a2:	68 d5 23 00 00       	push   $0x23d5
    19a7:	50                   	push   %eax
    19a8:	e8 de ef ff ff       	call   98b <APLoadBitmap>
    19ad:	83 c4 0c             	add    $0xc,%esp
    19b0:	8b 45 98             	mov    -0x68(%ebp),%eax
    19b3:	a3 50 2c 00 00       	mov    %eax,0x2c50
    19b8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19bb:	a3 54 2c 00 00       	mov    %eax,0x2c54
    19c0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19c3:	a3 58 2c 00 00       	mov    %eax,0x2c58
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    19c8:	83 ec 04             	sub    $0x4,%esp
    19cb:	ff 35 58 2c 00 00    	pushl  0x2c58
    19d1:	ff 35 54 2c 00 00    	pushl  0x2c54
    19d7:	ff 35 50 2c 00 00    	pushl  0x2c50
    19dd:	e8 e3 f1 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    19e2:	83 c4 10             	add    $0x10,%esp
    19e5:	a3 70 2c 00 00       	mov    %eax,0x2c70
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    19ea:	8d 45 98             	lea    -0x68(%ebp),%eax
    19ed:	83 ec 08             	sub    $0x8,%esp
    19f0:	68 e5 23 00 00       	push   $0x23e5
    19f5:	50                   	push   %eax
    19f6:	e8 90 ef ff ff       	call   98b <APLoadBitmap>
    19fb:	83 c4 0c             	add    $0xc,%esp
    19fe:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a01:	a3 44 2c 00 00       	mov    %eax,0x2c44
    1a06:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a09:	a3 48 2c 00 00       	mov    %eax,0x2c48
    1a0e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a11:	a3 4c 2c 00 00       	mov    %eax,0x2c4c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a16:	83 ec 04             	sub    $0x4,%esp
    1a19:	ff 35 4c 2c 00 00    	pushl  0x2c4c
    1a1f:	ff 35 48 2c 00 00    	pushl  0x2c48
    1a25:	ff 35 44 2c 00 00    	pushl  0x2c44
    1a2b:	e8 95 f1 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    1a30:	83 c4 10             	add    $0x10,%esp
    1a33:	a3 5c 2c 00 00       	mov    %eax,0x2c5c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a38:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a3b:	83 ec 08             	sub    $0x8,%esp
    1a3e:	68 f7 23 00 00       	push   $0x23f7
    1a43:	50                   	push   %eax
    1a44:	e8 42 ef ff ff       	call   98b <APLoadBitmap>
    1a49:	83 c4 0c             	add    $0xc,%esp
    1a4c:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a4f:	a3 80 2c 00 00       	mov    %eax,0x2c80
    1a54:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a57:	a3 84 2c 00 00       	mov    %eax,0x2c84
    1a5c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a5f:	a3 88 2c 00 00       	mov    %eax,0x2c88
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1a64:	83 ec 04             	sub    $0x4,%esp
    1a67:	ff 35 88 2c 00 00    	pushl  0x2c88
    1a6d:	ff 35 84 2c 00 00    	pushl  0x2c84
    1a73:	ff 35 80 2c 00 00    	pushl  0x2c80
    1a79:	e8 47 f1 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    1a7e:	83 c4 10             	add    $0x10,%esp
    1a81:	a3 ac 2c 00 00       	mov    %eax,0x2cac
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a86:	8b 45 08             	mov    0x8(%ebp),%eax
    1a89:	8b 40 08             	mov    0x8(%eax),%eax
    1a8c:	85 c0                	test   %eax,%eax
    1a8e:	75 17                	jne    1aa7 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a90:	83 ec 08             	sub    $0x8,%esp
    1a93:	68 08 24 00 00       	push   $0x2408
    1a98:	6a 01                	push   $0x1
    1a9a:	e8 66 ea ff ff       	call   505 <printf>
    1a9f:	83 c4 10             	add    $0x10,%esp
        return;
    1aa2:	e9 a0 04 00 00       	jmp    1f47 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1aa7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaa:	8b 40 10             	mov    0x10(%eax),%eax
    1aad:	85 c0                	test   %eax,%eax
    1aaf:	7e 10                	jle    1ac1 <APGridPaint+0x27d>
    1ab1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab4:	8b 50 14             	mov    0x14(%eax),%edx
    1ab7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aba:	8b 40 10             	mov    0x10(%eax),%eax
    1abd:	39 c2                	cmp    %eax,%edx
    1abf:	7c 17                	jl     1ad8 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1ac1:	83 ec 08             	sub    $0x8,%esp
    1ac4:	68 2e 24 00 00       	push   $0x242e
    1ac9:	6a 01                	push   $0x1
    1acb:	e8 35 ea ff ff       	call   505 <printf>
    1ad0:	83 c4 10             	add    $0x10,%esp
        return;
    1ad3:	e9 6f 04 00 00       	jmp    1f47 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ad8:	8b 45 08             	mov    0x8(%ebp),%eax
    1adb:	8b 40 14             	mov    0x14(%eax),%eax
    1ade:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ae4:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ae7:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1aea:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1aed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1af4:	e9 96 03 00 00       	jmp    1e8f <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1af9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b00:	e9 7c 03 00 00       	jmp    1e81 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b08:	c1 e0 04             	shl    $0x4,%eax
    1b0b:	89 c2                	mov    %eax,%edx
    1b0d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b10:	01 c2                	add    %eax,%edx
    1b12:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b15:	01 d0                	add    %edx,%eax
    1b17:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1d:	8b 40 0c             	mov    0xc(%eax),%eax
    1b20:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b23:	c1 e2 02             	shl    $0x2,%edx
    1b26:	01 d0                	add    %edx,%eax
    1b28:	8b 00                	mov    (%eax),%eax
    1b2a:	83 f8 07             	cmp    $0x7,%eax
    1b2d:	0f 87 49 03 00 00    	ja     1e7c <APGridPaint+0x638>
    1b33:	8b 04 85 44 24 00 00 	mov    0x2444(,%eax,4),%eax
    1b3a:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b3c:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b3f:	6a 0c                	push   $0xc
    1b41:	6a 0c                	push   $0xc
    1b43:	6a 0c                	push   $0xc
    1b45:	50                   	push   %eax
    1b46:	e8 df f8 ff ff       	call   142a <RGB>
    1b4b:	83 c4 0c             	add    $0xc,%esp
    1b4e:	8b 1d 6c 2c 00 00    	mov    0x2c6c,%ebx
    1b54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b57:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b5a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b5d:	6b c0 32             	imul   $0x32,%eax,%eax
    1b60:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b63:	8b 45 08             	mov    0x8(%ebp),%eax
    1b66:	8d 78 3c             	lea    0x3c(%eax),%edi
    1b69:	83 ec 0c             	sub    $0xc,%esp
    1b6c:	83 ec 04             	sub    $0x4,%esp
    1b6f:	89 e0                	mov    %esp,%eax
    1b71:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b75:	66 89 30             	mov    %si,(%eax)
    1b78:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b7c:	88 50 02             	mov    %dl,0x2(%eax)
    1b7f:	6a 32                	push   $0x32
    1b81:	6a 32                	push   $0x32
    1b83:	6a 00                	push   $0x0
    1b85:	6a 00                	push   $0x0
    1b87:	53                   	push   %ebx
    1b88:	51                   	push   %ecx
    1b89:	ff 75 94             	pushl  -0x6c(%ebp)
    1b8c:	57                   	push   %edi
    1b8d:	e8 f4 f6 ff ff       	call   1286 <APDcCopy>
    1b92:	83 c4 30             	add    $0x30,%esp
                    break;
    1b95:	e9 e3 02 00 00       	jmp    1e7d <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b9a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b9d:	6a 69                	push   $0x69
    1b9f:	6a 69                	push   $0x69
    1ba1:	6a 69                	push   $0x69
    1ba3:	50                   	push   %eax
    1ba4:	e8 81 f8 ff ff       	call   142a <RGB>
    1ba9:	83 c4 0c             	add    $0xc,%esp
    1bac:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bb0:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1bb4:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bb8:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1bbb:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1bc2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bc5:	6a 69                	push   $0x69
    1bc7:	6a 69                	push   $0x69
    1bc9:	6a 69                	push   $0x69
    1bcb:	50                   	push   %eax
    1bcc:	e8 59 f8 ff ff       	call   142a <RGB>
    1bd1:	83 c4 0c             	add    $0xc,%esp
    1bd4:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bd8:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1bdc:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1be0:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1be3:	8b 45 08             	mov    0x8(%ebp),%eax
    1be6:	8d 50 3c             	lea    0x3c(%eax),%edx
    1be9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bec:	ff 75 b0             	pushl  -0x50(%ebp)
    1bef:	ff 75 ac             	pushl  -0x54(%ebp)
    1bf2:	52                   	push   %edx
    1bf3:	50                   	push   %eax
    1bf4:	e8 61 f0 ff ff       	call   c5a <APSetPen>
    1bf9:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1bfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bff:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1c02:	8d 55 98             	lea    -0x68(%ebp),%edx
    1c05:	83 ec 04             	sub    $0x4,%esp
    1c08:	83 ec 04             	sub    $0x4,%esp
    1c0b:	89 e0                	mov    %esp,%eax
    1c0d:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1c11:	66 89 08             	mov    %cx,(%eax)
    1c14:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1c18:	88 48 02             	mov    %cl,0x2(%eax)
    1c1b:	53                   	push   %ebx
    1c1c:	52                   	push   %edx
    1c1d:	e8 71 f0 ff ff       	call   c93 <APSetBrush>
    1c22:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c28:	6b d0 32             	imul   $0x32,%eax,%edx
    1c2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2e:	6b c0 32             	imul   $0x32,%eax,%eax
    1c31:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c34:	83 c1 3c             	add    $0x3c,%ecx
    1c37:	83 ec 0c             	sub    $0xc,%esp
    1c3a:	6a 32                	push   $0x32
    1c3c:	6a 32                	push   $0x32
    1c3e:	52                   	push   %edx
    1c3f:	50                   	push   %eax
    1c40:	51                   	push   %ecx
    1c41:	e8 35 f4 ff ff       	call   107b <APDrawRect>
    1c46:	83 c4 20             	add    $0x20,%esp
                    break;
    1c49:	e9 2f 02 00 00       	jmp    1e7d <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c4e:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c51:	6a 0c                	push   $0xc
    1c53:	6a 0c                	push   $0xc
    1c55:	6a 0c                	push   $0xc
    1c57:	50                   	push   %eax
    1c58:	e8 cd f7 ff ff       	call   142a <RGB>
    1c5d:	83 c4 0c             	add    $0xc,%esp
    1c60:	8b 1d ac 2c 00 00    	mov    0x2cac,%ebx
    1c66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c69:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c6f:	6b c0 32             	imul   $0x32,%eax,%eax
    1c72:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c75:	8b 45 08             	mov    0x8(%ebp),%eax
    1c78:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c7b:	83 ec 0c             	sub    $0xc,%esp
    1c7e:	83 ec 04             	sub    $0x4,%esp
    1c81:	89 e0                	mov    %esp,%eax
    1c83:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c87:	66 89 30             	mov    %si,(%eax)
    1c8a:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c8e:	88 50 02             	mov    %dl,0x2(%eax)
    1c91:	6a 32                	push   $0x32
    1c93:	6a 32                	push   $0x32
    1c95:	6a 00                	push   $0x0
    1c97:	6a 00                	push   $0x0
    1c99:	53                   	push   %ebx
    1c9a:	51                   	push   %ecx
    1c9b:	ff 75 94             	pushl  -0x6c(%ebp)
    1c9e:	57                   	push   %edi
    1c9f:	e8 e2 f5 ff ff       	call   1286 <APDcCopy>
    1ca4:	83 c4 30             	add    $0x30,%esp
                    break;
    1ca7:	e9 d1 01 00 00       	jmp    1e7d <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cac:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1caf:	6a 0c                	push   $0xc
    1cb1:	6a 0c                	push   $0xc
    1cb3:	6a 0c                	push   $0xc
    1cb5:	50                   	push   %eax
    1cb6:	e8 6f f7 ff ff       	call   142a <RGB>
    1cbb:	83 c4 0c             	add    $0xc,%esp
    1cbe:	8b 1d 8c 2c 00 00    	mov    0x2c8c,%ebx
    1cc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cc7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cca:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ccd:	6b c0 32             	imul   $0x32,%eax,%eax
    1cd0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd6:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cd9:	83 ec 0c             	sub    $0xc,%esp
    1cdc:	83 ec 04             	sub    $0x4,%esp
    1cdf:	89 e0                	mov    %esp,%eax
    1ce1:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1ce5:	66 89 30             	mov    %si,(%eax)
    1ce8:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1cec:	88 50 02             	mov    %dl,0x2(%eax)
    1cef:	6a 32                	push   $0x32
    1cf1:	6a 32                	push   $0x32
    1cf3:	6a 00                	push   $0x0
    1cf5:	6a 00                	push   $0x0
    1cf7:	53                   	push   %ebx
    1cf8:	51                   	push   %ecx
    1cf9:	ff 75 94             	pushl  -0x6c(%ebp)
    1cfc:	57                   	push   %edi
    1cfd:	e8 84 f5 ff ff       	call   1286 <APDcCopy>
    1d02:	83 c4 30             	add    $0x30,%esp
                    break;
    1d05:	e9 73 01 00 00       	jmp    1e7d <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d0a:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d0d:	6a 0c                	push   $0xc
    1d0f:	6a 0c                	push   $0xc
    1d11:	6a 0c                	push   $0xc
    1d13:	50                   	push   %eax
    1d14:	e8 11 f7 ff ff       	call   142a <RGB>
    1d19:	83 c4 0c             	add    $0xc,%esp
    1d1c:	8b 1d 70 2c 00 00    	mov    0x2c70,%ebx
    1d22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d25:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d28:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d2b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d2e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d31:	8b 45 08             	mov    0x8(%ebp),%eax
    1d34:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d37:	83 ec 0c             	sub    $0xc,%esp
    1d3a:	83 ec 04             	sub    $0x4,%esp
    1d3d:	89 e0                	mov    %esp,%eax
    1d3f:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d43:	66 89 30             	mov    %si,(%eax)
    1d46:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d4a:	88 50 02             	mov    %dl,0x2(%eax)
    1d4d:	6a 32                	push   $0x32
    1d4f:	6a 32                	push   $0x32
    1d51:	6a 00                	push   $0x0
    1d53:	6a 00                	push   $0x0
    1d55:	53                   	push   %ebx
    1d56:	51                   	push   %ecx
    1d57:	ff 75 94             	pushl  -0x6c(%ebp)
    1d5a:	57                   	push   %edi
    1d5b:	e8 26 f5 ff ff       	call   1286 <APDcCopy>
    1d60:	83 c4 30             	add    $0x30,%esp
                    break;
    1d63:	e9 15 01 00 00       	jmp    1e7d <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d68:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1d6b:	6a 0c                	push   $0xc
    1d6d:	6a 0c                	push   $0xc
    1d6f:	6a 0c                	push   $0xc
    1d71:	50                   	push   %eax
    1d72:	e8 b3 f6 ff ff       	call   142a <RGB>
    1d77:	83 c4 0c             	add    $0xc,%esp
    1d7a:	8b 1d a8 2c 00 00    	mov    0x2ca8,%ebx
    1d80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d83:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d86:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d89:	6b c0 32             	imul   $0x32,%eax,%eax
    1d8c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d92:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d95:	83 ec 0c             	sub    $0xc,%esp
    1d98:	83 ec 04             	sub    $0x4,%esp
    1d9b:	89 e0                	mov    %esp,%eax
    1d9d:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1da1:	66 89 30             	mov    %si,(%eax)
    1da4:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1da8:	88 50 02             	mov    %dl,0x2(%eax)
    1dab:	6a 32                	push   $0x32
    1dad:	6a 32                	push   $0x32
    1daf:	6a 00                	push   $0x0
    1db1:	6a 00                	push   $0x0
    1db3:	53                   	push   %ebx
    1db4:	51                   	push   %ecx
    1db5:	ff 75 94             	pushl  -0x6c(%ebp)
    1db8:	57                   	push   %edi
    1db9:	e8 c8 f4 ff ff       	call   1286 <APDcCopy>
    1dbe:	83 c4 30             	add    $0x30,%esp
                    break;
    1dc1:	e9 b7 00 00 00       	jmp    1e7d <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dc6:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1dc9:	6a 0c                	push   $0xc
    1dcb:	6a 0c                	push   $0xc
    1dcd:	6a 0c                	push   $0xc
    1dcf:	50                   	push   %eax
    1dd0:	e8 55 f6 ff ff       	call   142a <RGB>
    1dd5:	83 c4 0c             	add    $0xc,%esp
    1dd8:	8b 1d 40 2c 00 00    	mov    0x2c40,%ebx
    1dde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1de1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1de4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1de7:	6b c0 32             	imul   $0x32,%eax,%eax
    1dea:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ded:	8b 45 08             	mov    0x8(%ebp),%eax
    1df0:	8d 78 3c             	lea    0x3c(%eax),%edi
    1df3:	83 ec 0c             	sub    $0xc,%esp
    1df6:	83 ec 04             	sub    $0x4,%esp
    1df9:	89 e0                	mov    %esp,%eax
    1dfb:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1dff:	66 89 30             	mov    %si,(%eax)
    1e02:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e06:	88 50 02             	mov    %dl,0x2(%eax)
    1e09:	6a 32                	push   $0x32
    1e0b:	6a 32                	push   $0x32
    1e0d:	6a 00                	push   $0x0
    1e0f:	6a 00                	push   $0x0
    1e11:	53                   	push   %ebx
    1e12:	51                   	push   %ecx
    1e13:	ff 75 94             	pushl  -0x6c(%ebp)
    1e16:	57                   	push   %edi
    1e17:	e8 6a f4 ff ff       	call   1286 <APDcCopy>
    1e1c:	83 c4 30             	add    $0x30,%esp
                    break;
    1e1f:	eb 5c                	jmp    1e7d <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e21:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e24:	6a 0c                	push   $0xc
    1e26:	6a 0c                	push   $0xc
    1e28:	6a 0c                	push   $0xc
    1e2a:	50                   	push   %eax
    1e2b:	e8 fa f5 ff ff       	call   142a <RGB>
    1e30:	83 c4 0c             	add    $0xc,%esp
    1e33:	8b 1d 5c 2c 00 00    	mov    0x2c5c,%ebx
    1e39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e3c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e42:	6b c0 32             	imul   $0x32,%eax,%eax
    1e45:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e48:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e4e:	83 ec 0c             	sub    $0xc,%esp
    1e51:	83 ec 04             	sub    $0x4,%esp
    1e54:	89 e0                	mov    %esp,%eax
    1e56:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e5a:	66 89 30             	mov    %si,(%eax)
    1e5d:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1e61:	88 50 02             	mov    %dl,0x2(%eax)
    1e64:	6a 32                	push   $0x32
    1e66:	6a 32                	push   $0x32
    1e68:	6a 00                	push   $0x0
    1e6a:	6a 00                	push   $0x0
    1e6c:	53                   	push   %ebx
    1e6d:	51                   	push   %ecx
    1e6e:	ff 75 94             	pushl  -0x6c(%ebp)
    1e71:	57                   	push   %edi
    1e72:	e8 0f f4 ff ff       	call   1286 <APDcCopy>
    1e77:	83 c4 30             	add    $0x30,%esp
                    break;
    1e7a:	eb 01                	jmp    1e7d <APGridPaint+0x639>
                default: break;
    1e7c:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e7d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e81:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e85:	0f 8e 7a fc ff ff    	jle    1b05 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e8b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e8f:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e93:	0f 8e 60 fc ff ff    	jle    1af9 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1e99:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e9c:	68 cd 00 00 00       	push   $0xcd
    1ea1:	6a 74                	push   $0x74
    1ea3:	6a 18                	push   $0x18
    1ea5:	50                   	push   %eax
    1ea6:	e8 7f f5 ff ff       	call   142a <RGB>
    1eab:	83 c4 0c             	add    $0xc,%esp
    1eae:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1eb2:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1eb6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1eba:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1ebd:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1ec4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ec7:	68 cd 00 00 00       	push   $0xcd
    1ecc:	6a 74                	push   $0x74
    1ece:	6a 18                	push   $0x18
    1ed0:	50                   	push   %eax
    1ed1:	e8 54 f5 ff ff       	call   142a <RGB>
    1ed6:	83 c4 0c             	add    $0xc,%esp
    1ed9:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1edd:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ee1:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ee5:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1ee8:	8b 45 08             	mov    0x8(%ebp),%eax
    1eeb:	8d 50 58             	lea    0x58(%eax),%edx
    1eee:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ef1:	ff 75 bc             	pushl  -0x44(%ebp)
    1ef4:	ff 75 b8             	pushl  -0x48(%ebp)
    1ef7:	52                   	push   %edx
    1ef8:	50                   	push   %eax
    1ef9:	e8 5c ed ff ff       	call   c5a <APSetPen>
    1efe:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1f01:	8b 45 08             	mov    0x8(%ebp),%eax
    1f04:	8d 58 58             	lea    0x58(%eax),%ebx
    1f07:	8d 55 98             	lea    -0x68(%ebp),%edx
    1f0a:	83 ec 04             	sub    $0x4,%esp
    1f0d:	83 ec 04             	sub    $0x4,%esp
    1f10:	89 e0                	mov    %esp,%eax
    1f12:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1f16:	66 89 08             	mov    %cx,(%eax)
    1f19:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1f1d:	88 48 02             	mov    %cl,0x2(%eax)
    1f20:	53                   	push   %ebx
    1f21:	52                   	push   %edx
    1f22:	e8 6c ed ff ff       	call   c93 <APSetBrush>
    1f27:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1f2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f2d:	83 c0 58             	add    $0x58,%eax
    1f30:	83 ec 0c             	sub    $0xc,%esp
    1f33:	6a 32                	push   $0x32
    1f35:	68 20 03 00 00       	push   $0x320
    1f3a:	6a 00                	push   $0x0
    1f3c:	6a 00                	push   $0x0
    1f3e:	50                   	push   %eax
    1f3f:	e8 37 f1 ff ff       	call   107b <APDrawRect>
    1f44:	83 c4 20             	add    $0x20,%esp
}
    1f47:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f4a:	5b                   	pop    %ebx
    1f4b:	5e                   	pop    %esi
    1f4c:	5f                   	pop    %edi
    1f4d:	5d                   	pop    %ebp
    1f4e:	c3                   	ret    

00001f4f <random>:
//

#include "APLib.h"

int random(int seed)
{
    1f4f:	55                   	push   %ebp
    1f50:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1f52:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1f56:	7e 08                	jle    1f60 <random+0x11>
{
rand_num = seed;
    1f58:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5b:	a3 f8 29 00 00       	mov    %eax,0x29f8
}
rand_num *= 3;
    1f60:	8b 15 f8 29 00 00    	mov    0x29f8,%edx
    1f66:	89 d0                	mov    %edx,%eax
    1f68:	01 c0                	add    %eax,%eax
    1f6a:	01 d0                	add    %edx,%eax
    1f6c:	a3 f8 29 00 00       	mov    %eax,0x29f8
if (rand_num < 0)
    1f71:	a1 f8 29 00 00       	mov    0x29f8,%eax
    1f76:	85 c0                	test   %eax,%eax
    1f78:	79 0c                	jns    1f86 <random+0x37>
{
rand_num *= (-1);
    1f7a:	a1 f8 29 00 00       	mov    0x29f8,%eax
    1f7f:	f7 d8                	neg    %eax
    1f81:	a3 f8 29 00 00       	mov    %eax,0x29f8
}
return rand_num % 997;
    1f86:	8b 0d f8 29 00 00    	mov    0x29f8,%ecx
    1f8c:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1f91:	89 c8                	mov    %ecx,%eax
    1f93:	f7 ea                	imul   %edx
    1f95:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1f98:	c1 f8 09             	sar    $0x9,%eax
    1f9b:	89 c2                	mov    %eax,%edx
    1f9d:	89 c8                	mov    %ecx,%eax
    1f9f:	c1 f8 1f             	sar    $0x1f,%eax
    1fa2:	29 c2                	sub    %eax,%edx
    1fa4:	89 d0                	mov    %edx,%eax
    1fa6:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1fac:	29 c1                	sub    %eax,%ecx
    1fae:	89 c8                	mov    %ecx,%eax
}
    1fb0:	5d                   	pop    %ebp
    1fb1:	c3                   	ret    

00001fb2 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1fb2:	55                   	push   %ebp
    1fb3:	89 e5                	mov    %esp,%ebp
    1fb5:	53                   	push   %ebx
    1fb6:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1fb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1fc0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1fc4:	74 17                	je     1fdd <sprintint+0x2b>
    1fc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1fca:	79 11                	jns    1fdd <sprintint+0x2b>
        neg = 1;
    1fcc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1fd3:	8b 45 10             	mov    0x10(%ebp),%eax
    1fd6:	f7 d8                	neg    %eax
    1fd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1fdb:	eb 06                	jmp    1fe3 <sprintint+0x31>
    } else {
        x = xx;
    1fdd:	8b 45 10             	mov    0x10(%ebp),%eax
    1fe0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1fe3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1fea:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1fed:	8d 41 01             	lea    0x1(%ecx),%eax
    1ff0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1ff3:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ff6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ff9:	ba 00 00 00 00       	mov    $0x0,%edx
    1ffe:	f7 f3                	div    %ebx
    2000:	89 d0                	mov    %edx,%eax
    2002:	0f b6 80 fc 29 00 00 	movzbl 0x29fc(%eax),%eax
    2009:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    200d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2010:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2013:	ba 00 00 00 00       	mov    $0x0,%edx
    2018:	f7 f3                	div    %ebx
    201a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    201d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2021:	75 c7                	jne    1fea <sprintint+0x38>
    if(neg)
    2023:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2027:	74 0e                	je     2037 <sprintint+0x85>
        buf[i++] = '-';
    2029:	8b 45 f8             	mov    -0x8(%ebp),%eax
    202c:	8d 50 01             	lea    0x1(%eax),%edx
    202f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2032:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2037:	8b 45 f8             	mov    -0x8(%ebp),%eax
    203a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    203d:	eb 1b                	jmp    205a <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    203f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2042:	8b 00                	mov    (%eax),%eax
    2044:	8d 48 01             	lea    0x1(%eax),%ecx
    2047:	8b 55 0c             	mov    0xc(%ebp),%edx
    204a:	89 0a                	mov    %ecx,(%edx)
    204c:	89 c2                	mov    %eax,%edx
    204e:	8b 45 08             	mov    0x8(%ebp),%eax
    2051:	01 d0                	add    %edx,%eax
    2053:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2056:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    205a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    205e:	7f df                	jg     203f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2060:	eb 21                	jmp    2083 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2062:	8b 45 0c             	mov    0xc(%ebp),%eax
    2065:	8b 00                	mov    (%eax),%eax
    2067:	8d 48 01             	lea    0x1(%eax),%ecx
    206a:	8b 55 0c             	mov    0xc(%ebp),%edx
    206d:	89 0a                	mov    %ecx,(%edx)
    206f:	89 c2                	mov    %eax,%edx
    2071:	8b 45 08             	mov    0x8(%ebp),%eax
    2074:	01 c2                	add    %eax,%edx
    2076:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2079:	8b 45 f8             	mov    -0x8(%ebp),%eax
    207c:	01 c8                	add    %ecx,%eax
    207e:	0f b6 00             	movzbl (%eax),%eax
    2081:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2083:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2087:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    208b:	79 d5                	jns    2062 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    208d:	90                   	nop
    208e:	83 c4 20             	add    $0x20,%esp
    2091:	5b                   	pop    %ebx
    2092:	5d                   	pop    %ebp
    2093:	c3                   	ret    

00002094 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2094:	55                   	push   %ebp
    2095:	89 e5                	mov    %esp,%ebp
    2097:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    209a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    20a1:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    20a8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    20af:	8d 45 0c             	lea    0xc(%ebp),%eax
    20b2:	83 c0 04             	add    $0x4,%eax
    20b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    20b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    20bf:	e9 d9 01 00 00       	jmp    229d <sprintf+0x209>
        c = fmt[i] & 0xff;
    20c4:	8b 55 0c             	mov    0xc(%ebp),%edx
    20c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20ca:	01 d0                	add    %edx,%eax
    20cc:	0f b6 00             	movzbl (%eax),%eax
    20cf:	0f be c0             	movsbl %al,%eax
    20d2:	25 ff 00 00 00       	and    $0xff,%eax
    20d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    20da:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    20de:	75 2c                	jne    210c <sprintf+0x78>
            if(c == '%'){
    20e0:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20e4:	75 0c                	jne    20f2 <sprintf+0x5e>
                state = '%';
    20e6:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    20ed:	e9 a7 01 00 00       	jmp    2299 <sprintf+0x205>
            } else {
                dst[j++] = c;
    20f2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f5:	8d 50 01             	lea    0x1(%eax),%edx
    20f8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20fb:	89 c2                	mov    %eax,%edx
    20fd:	8b 45 08             	mov    0x8(%ebp),%eax
    2100:	01 d0                	add    %edx,%eax
    2102:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2105:	88 10                	mov    %dl,(%eax)
    2107:	e9 8d 01 00 00       	jmp    2299 <sprintf+0x205>
            }
        } else if(state == '%'){
    210c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2110:	0f 85 83 01 00 00    	jne    2299 <sprintf+0x205>
            if(c == 'd'){
    2116:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    211a:	75 4c                	jne    2168 <sprintf+0xd4>
                buf[bi] = '\0';
    211c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    211f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2122:	01 d0                	add    %edx,%eax
    2124:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2127:	83 ec 0c             	sub    $0xc,%esp
    212a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    212d:	50                   	push   %eax
    212e:	e8 a1 e1 ff ff       	call   2d4 <atoi>
    2133:	83 c4 10             	add    $0x10,%esp
    2136:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2139:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2140:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2143:	8b 00                	mov    (%eax),%eax
    2145:	83 ec 08             	sub    $0x8,%esp
    2148:	ff 75 d8             	pushl  -0x28(%ebp)
    214b:	6a 01                	push   $0x1
    214d:	6a 0a                	push   $0xa
    214f:	50                   	push   %eax
    2150:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2153:	50                   	push   %eax
    2154:	ff 75 08             	pushl  0x8(%ebp)
    2157:	e8 56 fe ff ff       	call   1fb2 <sprintint>
    215c:	83 c4 20             	add    $0x20,%esp
                ap++;
    215f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2163:	e9 2a 01 00 00       	jmp    2292 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2168:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    216c:	74 06                	je     2174 <sprintf+0xe0>
    216e:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2172:	75 4c                	jne    21c0 <sprintf+0x12c>
                buf[bi] = '\0';
    2174:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2177:	8b 45 f0             	mov    -0x10(%ebp),%eax
    217a:	01 d0                	add    %edx,%eax
    217c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    217f:	83 ec 0c             	sub    $0xc,%esp
    2182:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2185:	50                   	push   %eax
    2186:	e8 49 e1 ff ff       	call   2d4 <atoi>
    218b:	83 c4 10             	add    $0x10,%esp
    218e:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2191:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2198:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    219b:	8b 00                	mov    (%eax),%eax
    219d:	83 ec 08             	sub    $0x8,%esp
    21a0:	ff 75 dc             	pushl  -0x24(%ebp)
    21a3:	6a 00                	push   $0x0
    21a5:	6a 10                	push   $0x10
    21a7:	50                   	push   %eax
    21a8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21ab:	50                   	push   %eax
    21ac:	ff 75 08             	pushl  0x8(%ebp)
    21af:	e8 fe fd ff ff       	call   1fb2 <sprintint>
    21b4:	83 c4 20             	add    $0x20,%esp
                ap++;
    21b7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    21bb:	e9 d2 00 00 00       	jmp    2292 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    21c0:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    21c4:	75 46                	jne    220c <sprintf+0x178>
                s = (char*)*ap;
    21c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21c9:	8b 00                	mov    (%eax),%eax
    21cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    21ce:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    21d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21d6:	75 25                	jne    21fd <sprintf+0x169>
                    s = "(null)";
    21d8:	c7 45 f4 64 24 00 00 	movl   $0x2464,-0xc(%ebp)
                while(*s != 0){
    21df:	eb 1c                	jmp    21fd <sprintf+0x169>
                    dst[j++] = *s;
    21e1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e4:	8d 50 01             	lea    0x1(%eax),%edx
    21e7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21ea:	89 c2                	mov    %eax,%edx
    21ec:	8b 45 08             	mov    0x8(%ebp),%eax
    21ef:	01 c2                	add    %eax,%edx
    21f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    21f4:	0f b6 00             	movzbl (%eax),%eax
    21f7:	88 02                	mov    %al,(%edx)
                    s++;
    21f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    21fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2200:	0f b6 00             	movzbl (%eax),%eax
    2203:	84 c0                	test   %al,%al
    2205:	75 da                	jne    21e1 <sprintf+0x14d>
    2207:	e9 86 00 00 00       	jmp    2292 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    220c:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2210:	75 1d                	jne    222f <sprintf+0x19b>
                dst[j++] = *ap;
    2212:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2215:	8d 50 01             	lea    0x1(%eax),%edx
    2218:	89 55 c8             	mov    %edx,-0x38(%ebp)
    221b:	89 c2                	mov    %eax,%edx
    221d:	8b 45 08             	mov    0x8(%ebp),%eax
    2220:	01 c2                	add    %eax,%edx
    2222:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2225:	8b 00                	mov    (%eax),%eax
    2227:	88 02                	mov    %al,(%edx)
                ap++;
    2229:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    222d:	eb 63                	jmp    2292 <sprintf+0x1fe>
            } else if(c == '%'){
    222f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2233:	75 17                	jne    224c <sprintf+0x1b8>
                dst[j++] = c;
    2235:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2238:	8d 50 01             	lea    0x1(%eax),%edx
    223b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    223e:	89 c2                	mov    %eax,%edx
    2240:	8b 45 08             	mov    0x8(%ebp),%eax
    2243:	01 d0                	add    %edx,%eax
    2245:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2248:	88 10                	mov    %dl,(%eax)
    224a:	eb 46                	jmp    2292 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    224c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2250:	7e 18                	jle    226a <sprintf+0x1d6>
    2252:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2256:	7f 12                	jg     226a <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2258:	8b 45 f0             	mov    -0x10(%ebp),%eax
    225b:	8d 50 01             	lea    0x1(%eax),%edx
    225e:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2261:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2264:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2268:	eb 2f                	jmp    2299 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    226a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    226d:	8d 50 01             	lea    0x1(%eax),%edx
    2270:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2273:	89 c2                	mov    %eax,%edx
    2275:	8b 45 08             	mov    0x8(%ebp),%eax
    2278:	01 d0                	add    %edx,%eax
    227a:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    227d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2280:	8d 50 01             	lea    0x1(%eax),%edx
    2283:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2286:	89 c2                	mov    %eax,%edx
    2288:	8b 45 08             	mov    0x8(%ebp),%eax
    228b:	01 d0                	add    %edx,%eax
    228d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2290:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2292:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2299:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    229d:	8b 55 0c             	mov    0xc(%ebp),%edx
    22a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22a3:	01 d0                	add    %edx,%eax
    22a5:	0f b6 00             	movzbl (%eax),%eax
    22a8:	84 c0                	test   %al,%al
    22aa:	0f 85 14 fe ff ff    	jne    20c4 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    22b0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22b3:	8d 50 01             	lea    0x1(%eax),%edx
    22b6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22b9:	89 c2                	mov    %eax,%edx
    22bb:	8b 45 08             	mov    0x8(%ebp),%eax
    22be:	01 d0                	add    %edx,%eax
    22c0:	c6 00 00             	movb   $0x0,(%eax)
}
    22c3:	90                   	nop
    22c4:	c9                   	leave  
    22c5:	c3                   	ret    
