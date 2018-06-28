
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
       e:	68 80 28 00 00       	push   $0x2880
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
      25:	68 80 28 00 00       	push   $0x2880
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
      47:	68 48 21 00 00       	push   $0x2148
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
      cf:	68 59 21 00 00       	push   $0x2159
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

0000040e <initStringFigure>:
SYSCALL(initStringFigure)
     40e:	b8 17 00 00 00       	mov    $0x17,%eax
     413:	cd 40                	int    $0x40
     415:	c3                   	ret    

00000416 <sendMessage>:
SYSCALL(sendMessage)
     416:	b8 18 00 00 00       	mov    $0x18,%eax
     41b:	cd 40                	int    $0x40
     41d:	c3                   	ret    

0000041e <getMessage>:
SYSCALL(getMessage)
     41e:	b8 1a 00 00 00       	mov    $0x1a,%eax
     423:	cd 40                	int    $0x40
     425:	c3                   	ret    

00000426 <registWindow>:
SYSCALL(registWindow)
     426:	b8 19 00 00 00       	mov    $0x19,%eax
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
     4a1:	0f b6 80 1c 28 00 00 	movzbl 0x281c(%eax),%eax
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
     5df:	c7 45 f4 6e 21 00 00 	movl   $0x216e,-0xc(%ebp)
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
     6a5:	a1 68 28 00 00       	mov    0x2868,%eax
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
     770:	a3 68 28 00 00       	mov    %eax,0x2868
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
     7d1:	a1 68 28 00 00       	mov    0x2868,%eax
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
     7ed:	a1 68 28 00 00       	mov    0x2868,%eax
     7f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7f9:	75 23                	jne    81e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7fb:	c7 45 f0 60 28 00 00 	movl   $0x2860,-0x10(%ebp)
     802:	8b 45 f0             	mov    -0x10(%ebp),%eax
     805:	a3 68 28 00 00       	mov    %eax,0x2868
     80a:	a1 68 28 00 00       	mov    0x2868,%eax
     80f:	a3 60 28 00 00       	mov    %eax,0x2860
    base.s.size = 0;
     814:	c7 05 64 28 00 00 00 	movl   $0x0,0x2864
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
     871:	a3 68 28 00 00       	mov    %eax,0x2868
      return (void*)(p + 1);
     876:	8b 45 f4             	mov    -0xc(%ebp),%eax
     879:	83 c0 08             	add    $0x8,%eax
     87c:	eb 3b                	jmp    8b9 <malloc+0xe1>
    }
    if(p == freep)
     87e:	a1 68 28 00 00       	mov    0x2868,%eax
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
     9c4:	68 75 21 00 00       	push   $0x2175
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

00001280 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1286:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    128a:	0f 88 8e 01 00 00    	js     141e <APDcCopy+0x19e>
    1290:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1294:	0f 88 84 01 00 00    	js     141e <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    129a:	8b 55 0c             	mov    0xc(%ebp),%edx
    129d:	8b 45 20             	mov    0x20(%ebp),%eax
    12a0:	01 d0                	add    %edx,%eax
    12a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12a5:	8b 55 10             	mov    0x10(%ebp),%edx
    12a8:	8b 45 24             	mov    0x24(%ebp),%eax
    12ab:	01 d0                	add    %edx,%eax
    12ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12b0:	8b 55 18             	mov    0x18(%ebp),%edx
    12b3:	8b 45 20             	mov    0x20(%ebp),%eax
    12b6:	01 d0                	add    %edx,%eax
    12b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12bb:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12be:	8b 45 24             	mov    0x24(%ebp),%eax
    12c1:	01 d0                	add    %edx,%eax
    12c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12ca:	0f 88 51 01 00 00    	js     1421 <APDcCopy+0x1a1>
    12d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12d4:	0f 88 47 01 00 00    	js     1421 <APDcCopy+0x1a1>
    12da:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12de:	0f 88 3d 01 00 00    	js     1421 <APDcCopy+0x1a1>
    12e4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12e8:	0f 88 33 01 00 00    	js     1421 <APDcCopy+0x1a1>
    12ee:	8b 45 14             	mov    0x14(%ebp),%eax
    12f1:	8b 00                	mov    (%eax),%eax
    12f3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12f6:	0f 8c 25 01 00 00    	jl     1421 <APDcCopy+0x1a1>
    12fc:	8b 45 14             	mov    0x14(%ebp),%eax
    12ff:	8b 40 04             	mov    0x4(%eax),%eax
    1302:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1305:	0f 8c 16 01 00 00    	jl     1421 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    130b:	8b 45 08             	mov    0x8(%ebp),%eax
    130e:	8b 00                	mov    (%eax),%eax
    1310:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1313:	7f 0b                	jg     1320 <APDcCopy+0xa0>
    1315:	8b 45 08             	mov    0x8(%ebp),%eax
    1318:	8b 00                	mov    (%eax),%eax
    131a:	83 e8 01             	sub    $0x1,%eax
    131d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1320:	8b 45 08             	mov    0x8(%ebp),%eax
    1323:	8b 40 04             	mov    0x4(%eax),%eax
    1326:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1329:	7f 0c                	jg     1337 <APDcCopy+0xb7>
    132b:	8b 45 08             	mov    0x8(%ebp),%eax
    132e:	8b 40 04             	mov    0x4(%eax),%eax
    1331:	83 e8 01             	sub    $0x1,%eax
    1334:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1337:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    133e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1345:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    134c:	e9 bc 00 00 00       	jmp    140d <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1351:	8b 45 08             	mov    0x8(%ebp),%eax
    1354:	8b 00                	mov    (%eax),%eax
    1356:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1359:	8b 55 10             	mov    0x10(%ebp),%edx
    135c:	01 ca                	add    %ecx,%edx
    135e:	0f af d0             	imul   %eax,%edx
    1361:	8b 45 0c             	mov    0xc(%ebp),%eax
    1364:	01 d0                	add    %edx,%eax
    1366:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1369:	8b 45 14             	mov    0x14(%ebp),%eax
    136c:	8b 00                	mov    (%eax),%eax
    136e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1371:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1374:	01 ca                	add    %ecx,%edx
    1376:	0f af d0             	imul   %eax,%edx
    1379:	8b 45 18             	mov    0x18(%ebp),%eax
    137c:	01 d0                	add    %edx,%eax
    137e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1381:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1388:	eb 74                	jmp    13fe <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    138a:	8b 45 14             	mov    0x14(%ebp),%eax
    138d:	8b 50 18             	mov    0x18(%eax),%edx
    1390:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1393:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1396:	01 c8                	add    %ecx,%eax
    1398:	89 c1                	mov    %eax,%ecx
    139a:	89 c8                	mov    %ecx,%eax
    139c:	01 c0                	add    %eax,%eax
    139e:	01 c8                	add    %ecx,%eax
    13a0:	01 d0                	add    %edx,%eax
    13a2:	0f b7 10             	movzwl (%eax),%edx
    13a5:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13a9:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13ad:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13b0:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13b4:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13b8:	38 c2                	cmp    %al,%dl
    13ba:	75 18                	jne    13d4 <APDcCopy+0x154>
    13bc:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13c0:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13c4:	38 c2                	cmp    %al,%dl
    13c6:	75 0c                	jne    13d4 <APDcCopy+0x154>
    13c8:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13cc:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13d0:	38 c2                	cmp    %al,%dl
    13d2:	74 26                	je     13fa <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13d4:	8b 45 08             	mov    0x8(%ebp),%eax
    13d7:	8b 50 18             	mov    0x18(%eax),%edx
    13da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e0:	01 c8                	add    %ecx,%eax
    13e2:	89 c1                	mov    %eax,%ecx
    13e4:	89 c8                	mov    %ecx,%eax
    13e6:	01 c0                	add    %eax,%eax
    13e8:	01 c8                	add    %ecx,%eax
    13ea:	01 d0                	add    %edx,%eax
    13ec:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13f0:	66 89 10             	mov    %dx,(%eax)
    13f3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13f7:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    13fa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1401:	2b 45 0c             	sub    0xc(%ebp),%eax
    1404:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1407:	7d 81                	jge    138a <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1409:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    140d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1410:	2b 45 10             	sub    0x10(%ebp),%eax
    1413:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1416:	0f 8d 35 ff ff ff    	jge    1351 <APDcCopy+0xd1>
    141c:	eb 04                	jmp    1422 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    141e:	90                   	nop
    141f:	eb 01                	jmp    1422 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1421:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1422:	c9                   	leave  
    1423:	c3                   	ret    

00001424 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1424:	55                   	push   %ebp
    1425:	89 e5                	mov    %esp,%ebp
    1427:	83 ec 1c             	sub    $0x1c,%esp
    142a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    142d:	8b 55 10             	mov    0x10(%ebp),%edx
    1430:	8b 45 14             	mov    0x14(%ebp),%eax
    1433:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1436:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1439:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    143c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1440:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1443:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1447:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    144a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    144e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1451:	8b 45 08             	mov    0x8(%ebp),%eax
    1454:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1458:	66 89 10             	mov    %dx,(%eax)
    145b:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    145f:	88 50 02             	mov    %dl,0x2(%eax)
}
    1462:	8b 45 08             	mov    0x8(%ebp),%eax
    1465:	c9                   	leave  
    1466:	c2 04 00             	ret    $0x4

00001469 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1469:	55                   	push   %ebp
    146a:	89 e5                	mov    %esp,%ebp
    146c:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    146f:	8b 45 08             	mov    0x8(%ebp),%eax
    1472:	8b 00                	mov    (%eax),%eax
    1474:	83 ec 08             	sub    $0x8,%esp
    1477:	8d 55 0c             	lea    0xc(%ebp),%edx
    147a:	52                   	push   %edx
    147b:	50                   	push   %eax
    147c:	e8 95 ef ff ff       	call   416 <sendMessage>
    1481:	83 c4 10             	add    $0x10,%esp
}
    1484:	90                   	nop
    1485:	c9                   	leave  
    1486:	c3                   	ret    

00001487 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1487:	55                   	push   %ebp
    1488:	89 e5                	mov    %esp,%ebp
    148a:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    148d:	83 ec 0c             	sub    $0xc,%esp
    1490:	68 90 00 00 00       	push   $0x90
    1495:	e8 3e f3 ff ff       	call   7d8 <malloc>
    149a:	83 c4 10             	add    $0x10,%esp
    149d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14a4:	75 15                	jne    14bb <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14a6:	83 ec 04             	sub    $0x4,%esp
    14a9:	ff 75 08             	pushl  0x8(%ebp)
    14ac:	68 88 21 00 00       	push   $0x2188
    14b1:	6a 01                	push   $0x1
    14b3:	e8 4d f0 ff ff       	call   505 <printf>
    14b8:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14be:	83 c0 7c             	add    $0x7c,%eax
    14c1:	83 ec 08             	sub    $0x8,%esp
    14c4:	ff 75 08             	pushl  0x8(%ebp)
    14c7:	50                   	push   %eax
    14c8:	e8 68 ec ff ff       	call   135 <strcpy>
    14cd:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d3:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14dd:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e7:	8b 40 34             	mov    0x34(%eax),%eax
    14ea:	89 c2                	mov    %eax,%edx
    14ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ef:	8b 40 38             	mov    0x38(%eax),%eax
    14f2:	0f af d0             	imul   %eax,%edx
    14f5:	89 d0                	mov    %edx,%eax
    14f7:	01 c0                	add    %eax,%eax
    14f9:	01 d0                	add    %edx,%eax
    14fb:	83 ec 0c             	sub    $0xc,%esp
    14fe:	50                   	push   %eax
    14ff:	e8 d4 f2 ff ff       	call   7d8 <malloc>
    1504:	83 c4 10             	add    $0x10,%esp
    1507:	89 c2                	mov    %eax,%edx
    1509:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150c:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    150f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1512:	8b 40 4c             	mov    0x4c(%eax),%eax
    1515:	85 c0                	test   %eax,%eax
    1517:	75 15                	jne    152e <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1519:	83 ec 04             	sub    $0x4,%esp
    151c:	ff 75 08             	pushl  0x8(%ebp)
    151f:	68 a8 21 00 00       	push   $0x21a8
    1524:	6a 01                	push   $0x1
    1526:	e8 da ef ff ff       	call   505 <printf>
    152b:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    152e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1531:	8b 40 34             	mov    0x34(%eax),%eax
    1534:	89 c2                	mov    %eax,%edx
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	8b 40 38             	mov    0x38(%eax),%eax
    153c:	0f af d0             	imul   %eax,%edx
    153f:	89 d0                	mov    %edx,%eax
    1541:	01 c0                	add    %eax,%eax
    1543:	01 c2                	add    %eax,%edx
    1545:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1548:	8b 40 4c             	mov    0x4c(%eax),%eax
    154b:	83 ec 04             	sub    $0x4,%esp
    154e:	52                   	push   %edx
    154f:	68 ff ff ff 00       	push   $0xffffff
    1554:	50                   	push   %eax
    1555:	e8 71 ec ff ff       	call   1cb <memset>
    155a:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    155d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1560:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1567:	e8 7a ee ff ff       	call   3e6 <getpid>
    156c:	89 c2                	mov    %eax,%edx
    156e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1571:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1574:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1577:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1588:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158b:	8b 40 50             	mov    0x50(%eax),%eax
    158e:	89 c2                	mov    %eax,%edx
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	8b 40 54             	mov    0x54(%eax),%eax
    1596:	0f af d0             	imul   %eax,%edx
    1599:	89 d0                	mov    %edx,%eax
    159b:	01 c0                	add    %eax,%eax
    159d:	01 d0                	add    %edx,%eax
    159f:	83 ec 0c             	sub    $0xc,%esp
    15a2:	50                   	push   %eax
    15a3:	e8 30 f2 ff ff       	call   7d8 <malloc>
    15a8:	83 c4 10             	add    $0x10,%esp
    15ab:	89 c2                	mov    %eax,%edx
    15ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b0:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    15b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b6:	8b 40 68             	mov    0x68(%eax),%eax
    15b9:	85 c0                	test   %eax,%eax
    15bb:	75 15                	jne    15d2 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15bd:	83 ec 04             	sub    $0x4,%esp
    15c0:	ff 75 08             	pushl  0x8(%ebp)
    15c3:	68 cc 21 00 00       	push   $0x21cc
    15c8:	6a 01                	push   $0x1
    15ca:	e8 36 ef ff ff       	call   505 <printf>
    15cf:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d5:	8b 40 34             	mov    0x34(%eax),%eax
    15d8:	89 c2                	mov    %eax,%edx
    15da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dd:	8b 40 38             	mov    0x38(%eax),%eax
    15e0:	0f af d0             	imul   %eax,%edx
    15e3:	89 d0                	mov    %edx,%eax
    15e5:	01 c0                	add    %eax,%eax
    15e7:	01 c2                	add    %eax,%edx
    15e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ec:	8b 40 4c             	mov    0x4c(%eax),%eax
    15ef:	83 ec 04             	sub    $0x4,%esp
    15f2:	52                   	push   %edx
    15f3:	68 ff 00 00 00       	push   $0xff
    15f8:	50                   	push   %eax
    15f9:	e8 cd eb ff ff       	call   1cb <memset>
    15fe:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1601:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1604:	8b 55 0c             	mov    0xc(%ebp),%edx
    1607:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    160a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    160e:	74 35                	je     1645 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1610:	8b 45 10             	mov    0x10(%ebp),%eax
    1613:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1619:	83 ec 0c             	sub    $0xc,%esp
    161c:	50                   	push   %eax
    161d:	e8 b6 f1 ff ff       	call   7d8 <malloc>
    1622:	83 c4 10             	add    $0x10,%esp
    1625:	89 c2                	mov    %eax,%edx
    1627:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162a:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    162d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1630:	8b 55 10             	mov    0x10(%ebp),%edx
    1633:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1636:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1639:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1640:	e9 8d 00 00 00       	jmp    16d2 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1645:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1648:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    164f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1652:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1659:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165c:	8b 40 18             	mov    0x18(%eax),%eax
    165f:	89 c2                	mov    %eax,%edx
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1664:	8b 40 1c             	mov    0x1c(%eax),%eax
    1667:	0f af d0             	imul   %eax,%edx
    166a:	89 d0                	mov    %edx,%eax
    166c:	01 c0                	add    %eax,%eax
    166e:	01 d0                	add    %edx,%eax
    1670:	83 ec 0c             	sub    $0xc,%esp
    1673:	50                   	push   %eax
    1674:	e8 5f f1 ff ff       	call   7d8 <malloc>
    1679:	83 c4 10             	add    $0x10,%esp
    167c:	89 c2                	mov    %eax,%edx
    167e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1681:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1684:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1687:	8b 40 30             	mov    0x30(%eax),%eax
    168a:	85 c0                	test   %eax,%eax
    168c:	75 15                	jne    16a3 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    168e:	83 ec 04             	sub    $0x4,%esp
    1691:	ff 75 08             	pushl  0x8(%ebp)
    1694:	68 f4 21 00 00       	push   $0x21f4
    1699:	6a 01                	push   $0x1
    169b:	e8 65 ee ff ff       	call   505 <printf>
    16a0:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a6:	8b 40 18             	mov    0x18(%eax),%eax
    16a9:	89 c2                	mov    %eax,%edx
    16ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ae:	8b 40 1c             	mov    0x1c(%eax),%eax
    16b1:	0f af d0             	imul   %eax,%edx
    16b4:	89 d0                	mov    %edx,%eax
    16b6:	01 c0                	add    %eax,%eax
    16b8:	01 c2                	add    %eax,%edx
    16ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bd:	8b 40 30             	mov    0x30(%eax),%eax
    16c0:	83 ec 04             	sub    $0x4,%esp
    16c3:	52                   	push   %edx
    16c4:	68 ff ff ff 00       	push   $0xffffff
    16c9:	50                   	push   %eax
    16ca:	e8 fc ea ff ff       	call   1cb <memset>
    16cf:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16d5:	c9                   	leave  
    16d6:	c3                   	ret    

000016d7 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16d7:	55                   	push   %ebp
    16d8:	89 e5                	mov    %esp,%ebp
    16da:	53                   	push   %ebx
    16db:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16de:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e1:	83 f8 03             	cmp    $0x3,%eax
    16e4:	74 02                	je     16e8 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    16e6:	eb 33                	jmp    171b <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    16e8:	8b 45 08             	mov    0x8(%ebp),%eax
    16eb:	8b 48 08             	mov    0x8(%eax),%ecx
    16ee:	8b 45 08             	mov    0x8(%ebp),%eax
    16f1:	8b 50 38             	mov    0x38(%eax),%edx
    16f4:	8b 45 08             	mov    0x8(%ebp),%eax
    16f7:	8b 40 34             	mov    0x34(%eax),%eax
    16fa:	8b 5d 08             	mov    0x8(%ebp),%ebx
    16fd:	83 c3 34             	add    $0x34,%ebx
    1700:	83 ec 0c             	sub    $0xc,%esp
    1703:	51                   	push   %ecx
    1704:	52                   	push   %edx
    1705:	50                   	push   %eax
    1706:	6a 00                	push   $0x0
    1708:	6a 00                	push   $0x0
    170a:	53                   	push   %ebx
    170b:	6a 32                	push   $0x32
    170d:	6a 00                	push   $0x0
    170f:	ff 75 08             	pushl  0x8(%ebp)
    1712:	e8 ef ec ff ff       	call   406 <paintWindow>
    1717:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    171a:	90                   	nop
        default: break;
            
            
    }
    return False;
    171b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1720:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1723:	c9                   	leave  
    1724:	c3                   	ret    

00001725 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1725:	55                   	push   %ebp
    1726:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1728:	8b 45 0c             	mov    0xc(%ebp),%eax
    172b:	8b 50 08             	mov    0x8(%eax),%edx
    172e:	8b 45 08             	mov    0x8(%ebp),%eax
    1731:	8b 00                	mov    (%eax),%eax
    1733:	39 c2                	cmp    %eax,%edx
    1735:	74 07                	je     173e <APPreJudge+0x19>
        return False;
    1737:	b8 00 00 00 00       	mov    $0x0,%eax
    173c:	eb 05                	jmp    1743 <APPreJudge+0x1e>
    return True;
    173e:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1743:	5d                   	pop    %ebp
    1744:	c3                   	ret    

00001745 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1745:	55                   	push   %ebp
    1746:	89 e5                	mov    %esp,%ebp
    1748:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    174b:	8b 45 08             	mov    0x8(%ebp),%eax
    174e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1751:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1754:	83 ec 0c             	sub    $0xc,%esp
    1757:	ff 75 08             	pushl  0x8(%ebp)
    175a:	e8 c7 ec ff ff       	call   426 <registWindow>
    175f:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1762:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1769:	8b 45 08             	mov    0x8(%ebp),%eax
    176c:	8b 00                	mov    (%eax),%eax
    176e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1771:	ff 75 f4             	pushl  -0xc(%ebp)
    1774:	ff 75 f0             	pushl  -0x10(%ebp)
    1777:	ff 75 ec             	pushl  -0x14(%ebp)
    177a:	ff 75 08             	pushl  0x8(%ebp)
    177d:	e8 e7 fc ff ff       	call   1469 <APSendMessage>
    1782:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1785:	83 ec 0c             	sub    $0xc,%esp
    1788:	ff 75 08             	pushl  0x8(%ebp)
    178b:	e8 8e ec ff ff       	call   41e <getMessage>
    1790:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1793:	8b 45 08             	mov    0x8(%ebp),%eax
    1796:	83 c0 6c             	add    $0x6c,%eax
    1799:	83 ec 08             	sub    $0x8,%esp
    179c:	50                   	push   %eax
    179d:	ff 75 08             	pushl  0x8(%ebp)
    17a0:	e8 80 ff ff ff       	call   1725 <APPreJudge>
    17a5:	83 c4 10             	add    $0x10,%esp
    17a8:	84 c0                	test   %al,%al
    17aa:	74 1b                	je     17c7 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    17ac:	8b 45 08             	mov    0x8(%ebp),%eax
    17af:	ff 70 74             	pushl  0x74(%eax)
    17b2:	ff 70 70             	pushl  0x70(%eax)
    17b5:	ff 70 6c             	pushl  0x6c(%eax)
    17b8:	ff 75 08             	pushl  0x8(%ebp)
    17bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    17be:	ff d0                	call   *%eax
    17c0:	83 c4 10             	add    $0x10,%esp
    17c3:	84 c0                	test   %al,%al
    17c5:	75 0c                	jne    17d3 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    17c7:	8b 45 08             	mov    0x8(%ebp),%eax
    17ca:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    17d1:	eb b2                	jmp    1785 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17d3:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17d4:	90                   	nop
    17d5:	c9                   	leave  
    17d6:	c3                   	ret    

000017d7 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17d7:	55                   	push   %ebp
    17d8:	89 e5                	mov    %esp,%ebp
    17da:	57                   	push   %edi
    17db:	56                   	push   %esi
    17dc:	53                   	push   %ebx
    17dd:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17e0:	a1 6c 28 00 00       	mov    0x286c,%eax
    17e5:	85 c0                	test   %eax,%eax
    17e7:	0f 85 2c 02 00 00    	jne    1a19 <APGridPaint+0x242>
    {
        iconReady = 1;
    17ed:	c7 05 6c 28 00 00 01 	movl   $0x1,0x286c
    17f4:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17f7:	8d 45 98             	lea    -0x68(%ebp),%eax
    17fa:	83 ec 08             	sub    $0x8,%esp
    17fd:	68 1b 22 00 00       	push   $0x221b
    1802:	50                   	push   %eax
    1803:	e8 83 f1 ff ff       	call   98b <APLoadBitmap>
    1808:	83 c4 0c             	add    $0xc,%esp
    180b:	8b 45 98             	mov    -0x68(%ebp),%eax
    180e:	a3 a0 2a 00 00       	mov    %eax,0x2aa0
    1813:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1816:	a3 a4 2a 00 00       	mov    %eax,0x2aa4
    181b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    181e:	a3 a8 2a 00 00       	mov    %eax,0x2aa8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1823:	83 ec 04             	sub    $0x4,%esp
    1826:	ff 35 a8 2a 00 00    	pushl  0x2aa8
    182c:	ff 35 a4 2a 00 00    	pushl  0x2aa4
    1832:	ff 35 a0 2a 00 00    	pushl  0x2aa0
    1838:	e8 88 f3 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    183d:	83 c4 10             	add    $0x10,%esp
    1840:	a3 ac 2a 00 00       	mov    %eax,0x2aac
        grid_river = APLoadBitmap ("grid_river.bmp");
    1845:	8d 45 98             	lea    -0x68(%ebp),%eax
    1848:	83 ec 08             	sub    $0x8,%esp
    184b:	68 29 22 00 00       	push   $0x2229
    1850:	50                   	push   %eax
    1851:	e8 35 f1 ff ff       	call   98b <APLoadBitmap>
    1856:	83 c4 0c             	add    $0xc,%esp
    1859:	8b 45 98             	mov    -0x68(%ebp),%eax
    185c:	a3 dc 2a 00 00       	mov    %eax,0x2adc
    1861:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1864:	a3 e0 2a 00 00       	mov    %eax,0x2ae0
    1869:	8b 45 a0             	mov    -0x60(%ebp),%eax
    186c:	a3 e4 2a 00 00       	mov    %eax,0x2ae4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1871:	83 ec 04             	sub    $0x4,%esp
    1874:	ff 35 e4 2a 00 00    	pushl  0x2ae4
    187a:	ff 35 e0 2a 00 00    	pushl  0x2ae0
    1880:	ff 35 dc 2a 00 00    	pushl  0x2adc
    1886:	e8 3a f3 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    188b:	83 c4 10             	add    $0x10,%esp
    188e:	a3 cc 2a 00 00       	mov    %eax,0x2acc
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1893:	8d 45 98             	lea    -0x68(%ebp),%eax
    1896:	83 ec 08             	sub    $0x8,%esp
    1899:	68 38 22 00 00       	push   $0x2238
    189e:	50                   	push   %eax
    189f:	e8 e7 f0 ff ff       	call   98b <APLoadBitmap>
    18a4:	83 c4 0c             	add    $0xc,%esp
    18a7:	8b 45 98             	mov    -0x68(%ebp),%eax
    18aa:	a3 d0 2a 00 00       	mov    %eax,0x2ad0
    18af:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18b2:	a3 d4 2a 00 00       	mov    %eax,0x2ad4
    18b7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18ba:	a3 d8 2a 00 00       	mov    %eax,0x2ad8
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    18bf:	83 ec 04             	sub    $0x4,%esp
    18c2:	ff 35 d8 2a 00 00    	pushl  0x2ad8
    18c8:	ff 35 d4 2a 00 00    	pushl  0x2ad4
    18ce:	ff 35 d0 2a 00 00    	pushl  0x2ad0
    18d4:	e8 ec f2 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    18d9:	83 c4 10             	add    $0x10,%esp
    18dc:	a3 80 2a 00 00       	mov    %eax,0x2a80
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18e1:	8d 45 98             	lea    -0x68(%ebp),%eax
    18e4:	83 ec 08             	sub    $0x8,%esp
    18e7:	68 47 22 00 00       	push   $0x2247
    18ec:	50                   	push   %eax
    18ed:	e8 99 f0 ff ff       	call   98b <APLoadBitmap>
    18f2:	83 c4 0c             	add    $0xc,%esp
    18f5:	8b 45 98             	mov    -0x68(%ebp),%eax
    18f8:	a3 b4 2a 00 00       	mov    %eax,0x2ab4
    18fd:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1900:	a3 b8 2a 00 00       	mov    %eax,0x2ab8
    1905:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1908:	a3 bc 2a 00 00       	mov    %eax,0x2abc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    190d:	83 ec 04             	sub    $0x4,%esp
    1910:	ff 35 bc 2a 00 00    	pushl  0x2abc
    1916:	ff 35 b8 2a 00 00    	pushl  0x2ab8
    191c:	ff 35 b4 2a 00 00    	pushl  0x2ab4
    1922:	e8 9e f2 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    1927:	83 c4 10             	add    $0x10,%esp
    192a:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    192f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1932:	83 ec 08             	sub    $0x8,%esp
    1935:	68 55 22 00 00       	push   $0x2255
    193a:	50                   	push   %eax
    193b:	e8 4b f0 ff ff       	call   98b <APLoadBitmap>
    1940:	83 c4 0c             	add    $0xc,%esp
    1943:	8b 45 98             	mov    -0x68(%ebp),%eax
    1946:	a3 90 2a 00 00       	mov    %eax,0x2a90
    194b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    194e:	a3 94 2a 00 00       	mov    %eax,0x2a94
    1953:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1956:	a3 98 2a 00 00       	mov    %eax,0x2a98
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    195b:	83 ec 04             	sub    $0x4,%esp
    195e:	ff 35 98 2a 00 00    	pushl  0x2a98
    1964:	ff 35 94 2a 00 00    	pushl  0x2a94
    196a:	ff 35 90 2a 00 00    	pushl  0x2a90
    1970:	e8 50 f2 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    1975:	83 c4 10             	add    $0x10,%esp
    1978:	a3 b0 2a 00 00       	mov    %eax,0x2ab0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    197d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1980:	83 ec 08             	sub    $0x8,%esp
    1983:	68 65 22 00 00       	push   $0x2265
    1988:	50                   	push   %eax
    1989:	e8 fd ef ff ff       	call   98b <APLoadBitmap>
    198e:	83 c4 0c             	add    $0xc,%esp
    1991:	8b 45 98             	mov    -0x68(%ebp),%eax
    1994:	a3 84 2a 00 00       	mov    %eax,0x2a84
    1999:	8b 45 9c             	mov    -0x64(%ebp),%eax
    199c:	a3 88 2a 00 00       	mov    %eax,0x2a88
    19a1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19a4:	a3 8c 2a 00 00       	mov    %eax,0x2a8c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    19a9:	83 ec 04             	sub    $0x4,%esp
    19ac:	ff 35 8c 2a 00 00    	pushl  0x2a8c
    19b2:	ff 35 88 2a 00 00    	pushl  0x2a88
    19b8:	ff 35 84 2a 00 00    	pushl  0x2a84
    19be:	e8 02 f2 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    19c3:	83 c4 10             	add    $0x10,%esp
    19c6:	a3 9c 2a 00 00       	mov    %eax,0x2a9c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19cb:	8d 45 98             	lea    -0x68(%ebp),%eax
    19ce:	83 ec 08             	sub    $0x8,%esp
    19d1:	68 77 22 00 00       	push   $0x2277
    19d6:	50                   	push   %eax
    19d7:	e8 af ef ff ff       	call   98b <APLoadBitmap>
    19dc:	83 c4 0c             	add    $0xc,%esp
    19df:	8b 45 98             	mov    -0x68(%ebp),%eax
    19e2:	a3 c0 2a 00 00       	mov    %eax,0x2ac0
    19e7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19ea:	a3 c4 2a 00 00       	mov    %eax,0x2ac4
    19ef:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19f2:	a3 c8 2a 00 00       	mov    %eax,0x2ac8
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19f7:	83 ec 04             	sub    $0x4,%esp
    19fa:	ff 35 c8 2a 00 00    	pushl  0x2ac8
    1a00:	ff 35 c4 2a 00 00    	pushl  0x2ac4
    1a06:	ff 35 c0 2a 00 00    	pushl  0x2ac0
    1a0c:	e8 b4 f1 ff ff       	call   bc5 <APCreateCompatibleDCFromBitmap>
    1a11:	83 c4 10             	add    $0x10,%esp
    1a14:	a3 ec 2a 00 00       	mov    %eax,0x2aec
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a19:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1c:	8b 40 08             	mov    0x8(%eax),%eax
    1a1f:	85 c0                	test   %eax,%eax
    1a21:	75 17                	jne    1a3a <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a23:	83 ec 08             	sub    $0x8,%esp
    1a26:	68 88 22 00 00       	push   $0x2288
    1a2b:	6a 01                	push   $0x1
    1a2d:	e8 d3 ea ff ff       	call   505 <printf>
    1a32:	83 c4 10             	add    $0x10,%esp
        return;
    1a35:	e9 f2 03 00 00       	jmp    1e2c <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3d:	8b 40 10             	mov    0x10(%eax),%eax
    1a40:	85 c0                	test   %eax,%eax
    1a42:	7e 10                	jle    1a54 <APGridPaint+0x27d>
    1a44:	8b 45 08             	mov    0x8(%ebp),%eax
    1a47:	8b 50 14             	mov    0x14(%eax),%edx
    1a4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4d:	8b 40 10             	mov    0x10(%eax),%eax
    1a50:	39 c2                	cmp    %eax,%edx
    1a52:	7c 17                	jl     1a6b <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a54:	83 ec 08             	sub    $0x8,%esp
    1a57:	68 ae 22 00 00       	push   $0x22ae
    1a5c:	6a 01                	push   $0x1
    1a5e:	e8 a2 ea ff ff       	call   505 <printf>
    1a63:	83 c4 10             	add    $0x10,%esp
        return;
    1a66:	e9 c1 03 00 00       	jmp    1e2c <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6e:	8b 40 14             	mov    0x14(%eax),%eax
    1a71:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a77:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a7a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a7d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a80:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a87:	e9 96 03 00 00       	jmp    1e22 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a8c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a93:	e9 7c 03 00 00       	jmp    1e14 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1a98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a9b:	c1 e0 04             	shl    $0x4,%eax
    1a9e:	89 c2                	mov    %eax,%edx
    1aa0:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1aa3:	01 c2                	add    %eax,%edx
    1aa5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1aa8:	01 d0                	add    %edx,%eax
    1aaa:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1aad:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab0:	8b 40 0c             	mov    0xc(%eax),%eax
    1ab3:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1ab6:	c1 e2 02             	shl    $0x2,%edx
    1ab9:	01 d0                	add    %edx,%eax
    1abb:	8b 00                	mov    (%eax),%eax
    1abd:	83 f8 07             	cmp    $0x7,%eax
    1ac0:	0f 87 49 03 00 00    	ja     1e0f <APGridPaint+0x638>
    1ac6:	8b 04 85 c4 22 00 00 	mov    0x22c4(,%eax,4),%eax
    1acd:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1acf:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ad2:	6a 0c                	push   $0xc
    1ad4:	6a 0c                	push   $0xc
    1ad6:	6a 0c                	push   $0xc
    1ad8:	50                   	push   %eax
    1ad9:	e8 46 f9 ff ff       	call   1424 <RGB>
    1ade:	83 c4 0c             	add    $0xc,%esp
    1ae1:	8b 1d ac 2a 00 00    	mov    0x2aac,%ebx
    1ae7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1aea:	6b c8 32             	imul   $0x32,%eax,%ecx
    1aed:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1af0:	6b c0 32             	imul   $0x32,%eax,%eax
    1af3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1af6:	8b 45 08             	mov    0x8(%ebp),%eax
    1af9:	8d 78 34             	lea    0x34(%eax),%edi
    1afc:	83 ec 0c             	sub    $0xc,%esp
    1aff:	83 ec 04             	sub    $0x4,%esp
    1b02:	89 e0                	mov    %esp,%eax
    1b04:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b08:	66 89 30             	mov    %si,(%eax)
    1b0b:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b0f:	88 50 02             	mov    %dl,0x2(%eax)
    1b12:	6a 32                	push   $0x32
    1b14:	6a 32                	push   $0x32
    1b16:	6a 00                	push   $0x0
    1b18:	6a 00                	push   $0x0
    1b1a:	53                   	push   %ebx
    1b1b:	51                   	push   %ecx
    1b1c:	ff 75 94             	pushl  -0x6c(%ebp)
    1b1f:	57                   	push   %edi
    1b20:	e8 5b f7 ff ff       	call   1280 <APDcCopy>
    1b25:	83 c4 30             	add    $0x30,%esp
                    break;
    1b28:	e9 e3 02 00 00       	jmp    1e10 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b2d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b30:	6a 69                	push   $0x69
    1b32:	6a 69                	push   $0x69
    1b34:	6a 69                	push   $0x69
    1b36:	50                   	push   %eax
    1b37:	e8 e8 f8 ff ff       	call   1424 <RGB>
    1b3c:	83 c4 0c             	add    $0xc,%esp
    1b3f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b43:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1b47:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b4b:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1b4e:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b55:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b58:	6a 69                	push   $0x69
    1b5a:	6a 69                	push   $0x69
    1b5c:	6a 69                	push   $0x69
    1b5e:	50                   	push   %eax
    1b5f:	e8 c0 f8 ff ff       	call   1424 <RGB>
    1b64:	83 c4 0c             	add    $0xc,%esp
    1b67:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b6b:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1b6f:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b73:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b76:	8b 45 08             	mov    0x8(%ebp),%eax
    1b79:	8d 50 34             	lea    0x34(%eax),%edx
    1b7c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b7f:	ff 75 bc             	pushl  -0x44(%ebp)
    1b82:	ff 75 b8             	pushl  -0x48(%ebp)
    1b85:	52                   	push   %edx
    1b86:	50                   	push   %eax
    1b87:	e8 ce f0 ff ff       	call   c5a <APSetPen>
    1b8c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b92:	8d 58 34             	lea    0x34(%eax),%ebx
    1b95:	8d 55 98             	lea    -0x68(%ebp),%edx
    1b98:	83 ec 04             	sub    $0x4,%esp
    1b9b:	83 ec 04             	sub    $0x4,%esp
    1b9e:	89 e0                	mov    %esp,%eax
    1ba0:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1ba4:	66 89 08             	mov    %cx,(%eax)
    1ba7:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1bab:	88 48 02             	mov    %cl,0x2(%eax)
    1bae:	53                   	push   %ebx
    1baf:	52                   	push   %edx
    1bb0:	e8 de f0 ff ff       	call   c93 <APSetBrush>
    1bb5:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1bb8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bbb:	6b d0 32             	imul   $0x32,%eax,%edx
    1bbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bc1:	6b c0 32             	imul   $0x32,%eax,%eax
    1bc4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bc7:	83 c1 34             	add    $0x34,%ecx
    1bca:	83 ec 0c             	sub    $0xc,%esp
    1bcd:	6a 32                	push   $0x32
    1bcf:	6a 32                	push   $0x32
    1bd1:	52                   	push   %edx
    1bd2:	50                   	push   %eax
    1bd3:	51                   	push   %ecx
    1bd4:	e8 a2 f4 ff ff       	call   107b <APDrawRect>
    1bd9:	83 c4 20             	add    $0x20,%esp
                    break;
    1bdc:	e9 2f 02 00 00       	jmp    1e10 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1be1:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1be4:	6a 0c                	push   $0xc
    1be6:	6a 0c                	push   $0xc
    1be8:	6a 0c                	push   $0xc
    1bea:	50                   	push   %eax
    1beb:	e8 34 f8 ff ff       	call   1424 <RGB>
    1bf0:	83 c4 0c             	add    $0xc,%esp
    1bf3:	8b 1d ec 2a 00 00    	mov    0x2aec,%ebx
    1bf9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bfc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bff:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c02:	6b c0 32             	imul   $0x32,%eax,%eax
    1c05:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c08:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0b:	8d 78 34             	lea    0x34(%eax),%edi
    1c0e:	83 ec 0c             	sub    $0xc,%esp
    1c11:	83 ec 04             	sub    $0x4,%esp
    1c14:	89 e0                	mov    %esp,%eax
    1c16:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c1a:	66 89 30             	mov    %si,(%eax)
    1c1d:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c21:	88 50 02             	mov    %dl,0x2(%eax)
    1c24:	6a 32                	push   $0x32
    1c26:	6a 32                	push   $0x32
    1c28:	6a 00                	push   $0x0
    1c2a:	6a 00                	push   $0x0
    1c2c:	53                   	push   %ebx
    1c2d:	51                   	push   %ecx
    1c2e:	ff 75 94             	pushl  -0x6c(%ebp)
    1c31:	57                   	push   %edi
    1c32:	e8 49 f6 ff ff       	call   1280 <APDcCopy>
    1c37:	83 c4 30             	add    $0x30,%esp
                    break;
    1c3a:	e9 d1 01 00 00       	jmp    1e10 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c3f:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c42:	6a 0c                	push   $0xc
    1c44:	6a 0c                	push   $0xc
    1c46:	6a 0c                	push   $0xc
    1c48:	50                   	push   %eax
    1c49:	e8 d6 f7 ff ff       	call   1424 <RGB>
    1c4e:	83 c4 0c             	add    $0xc,%esp
    1c51:	8b 1d cc 2a 00 00    	mov    0x2acc,%ebx
    1c57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c5a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c60:	6b c0 32             	imul   $0x32,%eax,%eax
    1c63:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c66:	8b 45 08             	mov    0x8(%ebp),%eax
    1c69:	8d 78 34             	lea    0x34(%eax),%edi
    1c6c:	83 ec 0c             	sub    $0xc,%esp
    1c6f:	83 ec 04             	sub    $0x4,%esp
    1c72:	89 e0                	mov    %esp,%eax
    1c74:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c78:	66 89 30             	mov    %si,(%eax)
    1c7b:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c7f:	88 50 02             	mov    %dl,0x2(%eax)
    1c82:	6a 32                	push   $0x32
    1c84:	6a 32                	push   $0x32
    1c86:	6a 00                	push   $0x0
    1c88:	6a 00                	push   $0x0
    1c8a:	53                   	push   %ebx
    1c8b:	51                   	push   %ecx
    1c8c:	ff 75 94             	pushl  -0x6c(%ebp)
    1c8f:	57                   	push   %edi
    1c90:	e8 eb f5 ff ff       	call   1280 <APDcCopy>
    1c95:	83 c4 30             	add    $0x30,%esp
                    break;
    1c98:	e9 73 01 00 00       	jmp    1e10 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c9d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ca0:	6a 0c                	push   $0xc
    1ca2:	6a 0c                	push   $0xc
    1ca4:	6a 0c                	push   $0xc
    1ca6:	50                   	push   %eax
    1ca7:	e8 78 f7 ff ff       	call   1424 <RGB>
    1cac:	83 c4 0c             	add    $0xc,%esp
    1caf:	8b 1d b0 2a 00 00    	mov    0x2ab0,%ebx
    1cb5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cb8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cbe:	6b c0 32             	imul   $0x32,%eax,%eax
    1cc1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc7:	8d 78 34             	lea    0x34(%eax),%edi
    1cca:	83 ec 0c             	sub    $0xc,%esp
    1ccd:	83 ec 04             	sub    $0x4,%esp
    1cd0:	89 e0                	mov    %esp,%eax
    1cd2:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cd6:	66 89 30             	mov    %si,(%eax)
    1cd9:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1cdd:	88 50 02             	mov    %dl,0x2(%eax)
    1ce0:	6a 32                	push   $0x32
    1ce2:	6a 32                	push   $0x32
    1ce4:	6a 00                	push   $0x0
    1ce6:	6a 00                	push   $0x0
    1ce8:	53                   	push   %ebx
    1ce9:	51                   	push   %ecx
    1cea:	ff 75 94             	pushl  -0x6c(%ebp)
    1ced:	57                   	push   %edi
    1cee:	e8 8d f5 ff ff       	call   1280 <APDcCopy>
    1cf3:	83 c4 30             	add    $0x30,%esp
                    break;
    1cf6:	e9 15 01 00 00       	jmp    1e10 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cfb:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1cfe:	6a 0c                	push   $0xc
    1d00:	6a 0c                	push   $0xc
    1d02:	6a 0c                	push   $0xc
    1d04:	50                   	push   %eax
    1d05:	e8 1a f7 ff ff       	call   1424 <RGB>
    1d0a:	83 c4 0c             	add    $0xc,%esp
    1d0d:	8b 1d e8 2a 00 00    	mov    0x2ae8,%ebx
    1d13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d16:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d19:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d1c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d1f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d22:	8b 45 08             	mov    0x8(%ebp),%eax
    1d25:	8d 78 34             	lea    0x34(%eax),%edi
    1d28:	83 ec 0c             	sub    $0xc,%esp
    1d2b:	83 ec 04             	sub    $0x4,%esp
    1d2e:	89 e0                	mov    %esp,%eax
    1d30:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d34:	66 89 30             	mov    %si,(%eax)
    1d37:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d3b:	88 50 02             	mov    %dl,0x2(%eax)
    1d3e:	6a 32                	push   $0x32
    1d40:	6a 32                	push   $0x32
    1d42:	6a 00                	push   $0x0
    1d44:	6a 00                	push   $0x0
    1d46:	53                   	push   %ebx
    1d47:	51                   	push   %ecx
    1d48:	ff 75 94             	pushl  -0x6c(%ebp)
    1d4b:	57                   	push   %edi
    1d4c:	e8 2f f5 ff ff       	call   1280 <APDcCopy>
    1d51:	83 c4 30             	add    $0x30,%esp
                    break;
    1d54:	e9 b7 00 00 00       	jmp    1e10 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d59:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d5c:	6a 0c                	push   $0xc
    1d5e:	6a 0c                	push   $0xc
    1d60:	6a 0c                	push   $0xc
    1d62:	50                   	push   %eax
    1d63:	e8 bc f6 ff ff       	call   1424 <RGB>
    1d68:	83 c4 0c             	add    $0xc,%esp
    1d6b:	8b 1d 80 2a 00 00    	mov    0x2a80,%ebx
    1d71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d74:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d77:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d7a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d7d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d80:	8b 45 08             	mov    0x8(%ebp),%eax
    1d83:	8d 78 34             	lea    0x34(%eax),%edi
    1d86:	83 ec 0c             	sub    $0xc,%esp
    1d89:	83 ec 04             	sub    $0x4,%esp
    1d8c:	89 e0                	mov    %esp,%eax
    1d8e:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d92:	66 89 30             	mov    %si,(%eax)
    1d95:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1d99:	88 50 02             	mov    %dl,0x2(%eax)
    1d9c:	6a 32                	push   $0x32
    1d9e:	6a 32                	push   $0x32
    1da0:	6a 00                	push   $0x0
    1da2:	6a 00                	push   $0x0
    1da4:	53                   	push   %ebx
    1da5:	51                   	push   %ecx
    1da6:	ff 75 94             	pushl  -0x6c(%ebp)
    1da9:	57                   	push   %edi
    1daa:	e8 d1 f4 ff ff       	call   1280 <APDcCopy>
    1daf:	83 c4 30             	add    $0x30,%esp
                    break;
    1db2:	eb 5c                	jmp    1e10 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1db4:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1db7:	6a 0c                	push   $0xc
    1db9:	6a 0c                	push   $0xc
    1dbb:	6a 0c                	push   $0xc
    1dbd:	50                   	push   %eax
    1dbe:	e8 61 f6 ff ff       	call   1424 <RGB>
    1dc3:	83 c4 0c             	add    $0xc,%esp
    1dc6:	8b 1d 9c 2a 00 00    	mov    0x2a9c,%ebx
    1dcc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dcf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dd2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dd5:	6b c0 32             	imul   $0x32,%eax,%eax
    1dd8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ddb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dde:	8d 78 34             	lea    0x34(%eax),%edi
    1de1:	83 ec 0c             	sub    $0xc,%esp
    1de4:	83 ec 04             	sub    $0x4,%esp
    1de7:	89 e0                	mov    %esp,%eax
    1de9:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1ded:	66 89 30             	mov    %si,(%eax)
    1df0:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1df4:	88 50 02             	mov    %dl,0x2(%eax)
    1df7:	6a 32                	push   $0x32
    1df9:	6a 32                	push   $0x32
    1dfb:	6a 00                	push   $0x0
    1dfd:	6a 00                	push   $0x0
    1dff:	53                   	push   %ebx
    1e00:	51                   	push   %ecx
    1e01:	ff 75 94             	pushl  -0x6c(%ebp)
    1e04:	57                   	push   %edi
    1e05:	e8 76 f4 ff ff       	call   1280 <APDcCopy>
    1e0a:	83 c4 30             	add    $0x30,%esp
                    break;
    1e0d:	eb 01                	jmp    1e10 <APGridPaint+0x639>
                default: break;
    1e0f:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e10:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e14:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e18:	0f 8e 7a fc ff ff    	jle    1a98 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e1e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e22:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e26:	0f 8e 60 fc ff ff    	jle    1a8c <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1e2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e2f:	5b                   	pop    %ebx
    1e30:	5e                   	pop    %esi
    1e31:	5f                   	pop    %edi
    1e32:	5d                   	pop    %ebp
    1e33:	c3                   	ret    

00001e34 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e34:	55                   	push   %ebp
    1e35:	89 e5                	mov    %esp,%ebp
    1e37:	53                   	push   %ebx
    1e38:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e42:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e46:	74 17                	je     1e5f <sprintint+0x2b>
    1e48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e4c:	79 11                	jns    1e5f <sprintint+0x2b>
        neg = 1;
    1e4e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e55:	8b 45 10             	mov    0x10(%ebp),%eax
    1e58:	f7 d8                	neg    %eax
    1e5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e5d:	eb 06                	jmp    1e65 <sprintint+0x31>
    } else {
        x = xx;
    1e5f:	8b 45 10             	mov    0x10(%ebp),%eax
    1e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e65:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1e6c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1e6f:	8d 41 01             	lea    0x1(%ecx),%eax
    1e72:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e75:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e78:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e7b:	ba 00 00 00 00       	mov    $0x0,%edx
    1e80:	f7 f3                	div    %ebx
    1e82:	89 d0                	mov    %edx,%eax
    1e84:	0f b6 80 30 28 00 00 	movzbl 0x2830(%eax),%eax
    1e8b:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e8f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e92:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e95:	ba 00 00 00 00       	mov    $0x0,%edx
    1e9a:	f7 f3                	div    %ebx
    1e9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e9f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ea3:	75 c7                	jne    1e6c <sprintint+0x38>
    if(neg)
    1ea5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ea9:	74 0e                	je     1eb9 <sprintint+0x85>
        buf[i++] = '-';
    1eab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1eae:	8d 50 01             	lea    0x1(%eax),%edx
    1eb1:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1eb4:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1eb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ebc:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1ebf:	eb 1b                	jmp    1edc <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ec4:	8b 00                	mov    (%eax),%eax
    1ec6:	8d 48 01             	lea    0x1(%eax),%ecx
    1ec9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ecc:	89 0a                	mov    %ecx,(%edx)
    1ece:	89 c2                	mov    %eax,%edx
    1ed0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed3:	01 d0                	add    %edx,%eax
    1ed5:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1ed8:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1edc:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1ee0:	7f df                	jg     1ec1 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ee2:	eb 21                	jmp    1f05 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1ee4:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ee7:	8b 00                	mov    (%eax),%eax
    1ee9:	8d 48 01             	lea    0x1(%eax),%ecx
    1eec:	8b 55 0c             	mov    0xc(%ebp),%edx
    1eef:	89 0a                	mov    %ecx,(%edx)
    1ef1:	89 c2                	mov    %eax,%edx
    1ef3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef6:	01 c2                	add    %eax,%edx
    1ef8:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1efb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1efe:	01 c8                	add    %ecx,%eax
    1f00:	0f b6 00             	movzbl (%eax),%eax
    1f03:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f05:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1f09:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1f0d:	79 d5                	jns    1ee4 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1f0f:	90                   	nop
    1f10:	83 c4 20             	add    $0x20,%esp
    1f13:	5b                   	pop    %ebx
    1f14:	5d                   	pop    %ebp
    1f15:	c3                   	ret    

00001f16 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1f16:	55                   	push   %ebp
    1f17:	89 e5                	mov    %esp,%ebp
    1f19:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1f1c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1f23:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1f2a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f31:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f34:	83 c0 04             	add    $0x4,%eax
    1f37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f3a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f41:	e9 d9 01 00 00       	jmp    211f <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f46:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f49:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f4c:	01 d0                	add    %edx,%eax
    1f4e:	0f b6 00             	movzbl (%eax),%eax
    1f51:	0f be c0             	movsbl %al,%eax
    1f54:	25 ff 00 00 00       	and    $0xff,%eax
    1f59:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f5c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f60:	75 2c                	jne    1f8e <sprintf+0x78>
            if(c == '%'){
    1f62:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f66:	75 0c                	jne    1f74 <sprintf+0x5e>
                state = '%';
    1f68:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1f6f:	e9 a7 01 00 00       	jmp    211b <sprintf+0x205>
            } else {
                dst[j++] = c;
    1f74:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f77:	8d 50 01             	lea    0x1(%eax),%edx
    1f7a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f7d:	89 c2                	mov    %eax,%edx
    1f7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f82:	01 d0                	add    %edx,%eax
    1f84:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f87:	88 10                	mov    %dl,(%eax)
    1f89:	e9 8d 01 00 00       	jmp    211b <sprintf+0x205>
            }
        } else if(state == '%'){
    1f8e:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f92:	0f 85 83 01 00 00    	jne    211b <sprintf+0x205>
            if(c == 'd'){
    1f98:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1f9c:	75 4c                	jne    1fea <sprintf+0xd4>
                buf[bi] = '\0';
    1f9e:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fa4:	01 d0                	add    %edx,%eax
    1fa6:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fa9:	83 ec 0c             	sub    $0xc,%esp
    1fac:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1faf:	50                   	push   %eax
    1fb0:	e8 1f e3 ff ff       	call   2d4 <atoi>
    1fb5:	83 c4 10             	add    $0x10,%esp
    1fb8:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1fbb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1fc2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fc5:	8b 00                	mov    (%eax),%eax
    1fc7:	83 ec 08             	sub    $0x8,%esp
    1fca:	ff 75 d8             	pushl  -0x28(%ebp)
    1fcd:	6a 01                	push   $0x1
    1fcf:	6a 0a                	push   $0xa
    1fd1:	50                   	push   %eax
    1fd2:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fd5:	50                   	push   %eax
    1fd6:	ff 75 08             	pushl  0x8(%ebp)
    1fd9:	e8 56 fe ff ff       	call   1e34 <sprintint>
    1fde:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fe1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fe5:	e9 2a 01 00 00       	jmp    2114 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1fea:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1fee:	74 06                	je     1ff6 <sprintf+0xe0>
    1ff0:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1ff4:	75 4c                	jne    2042 <sprintf+0x12c>
                buf[bi] = '\0';
    1ff6:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1ff9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ffc:	01 d0                	add    %edx,%eax
    1ffe:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2001:	83 ec 0c             	sub    $0xc,%esp
    2004:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2007:	50                   	push   %eax
    2008:	e8 c7 e2 ff ff       	call   2d4 <atoi>
    200d:	83 c4 10             	add    $0x10,%esp
    2010:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2013:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    201a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    201d:	8b 00                	mov    (%eax),%eax
    201f:	83 ec 08             	sub    $0x8,%esp
    2022:	ff 75 dc             	pushl  -0x24(%ebp)
    2025:	6a 00                	push   $0x0
    2027:	6a 10                	push   $0x10
    2029:	50                   	push   %eax
    202a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    202d:	50                   	push   %eax
    202e:	ff 75 08             	pushl  0x8(%ebp)
    2031:	e8 fe fd ff ff       	call   1e34 <sprintint>
    2036:	83 c4 20             	add    $0x20,%esp
                ap++;
    2039:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    203d:	e9 d2 00 00 00       	jmp    2114 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2042:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2046:	75 46                	jne    208e <sprintf+0x178>
                s = (char*)*ap;
    2048:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    204b:	8b 00                	mov    (%eax),%eax
    204d:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2050:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2054:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2058:	75 25                	jne    207f <sprintf+0x169>
                    s = "(null)";
    205a:	c7 45 f4 e4 22 00 00 	movl   $0x22e4,-0xc(%ebp)
                while(*s != 0){
    2061:	eb 1c                	jmp    207f <sprintf+0x169>
                    dst[j++] = *s;
    2063:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2066:	8d 50 01             	lea    0x1(%eax),%edx
    2069:	89 55 c8             	mov    %edx,-0x38(%ebp)
    206c:	89 c2                	mov    %eax,%edx
    206e:	8b 45 08             	mov    0x8(%ebp),%eax
    2071:	01 c2                	add    %eax,%edx
    2073:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2076:	0f b6 00             	movzbl (%eax),%eax
    2079:	88 02                	mov    %al,(%edx)
                    s++;
    207b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    207f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2082:	0f b6 00             	movzbl (%eax),%eax
    2085:	84 c0                	test   %al,%al
    2087:	75 da                	jne    2063 <sprintf+0x14d>
    2089:	e9 86 00 00 00       	jmp    2114 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    208e:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2092:	75 1d                	jne    20b1 <sprintf+0x19b>
                dst[j++] = *ap;
    2094:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2097:	8d 50 01             	lea    0x1(%eax),%edx
    209a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    209d:	89 c2                	mov    %eax,%edx
    209f:	8b 45 08             	mov    0x8(%ebp),%eax
    20a2:	01 c2                	add    %eax,%edx
    20a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20a7:	8b 00                	mov    (%eax),%eax
    20a9:	88 02                	mov    %al,(%edx)
                ap++;
    20ab:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20af:	eb 63                	jmp    2114 <sprintf+0x1fe>
            } else if(c == '%'){
    20b1:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20b5:	75 17                	jne    20ce <sprintf+0x1b8>
                dst[j++] = c;
    20b7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20ba:	8d 50 01             	lea    0x1(%eax),%edx
    20bd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c0:	89 c2                	mov    %eax,%edx
    20c2:	8b 45 08             	mov    0x8(%ebp),%eax
    20c5:	01 d0                	add    %edx,%eax
    20c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20ca:	88 10                	mov    %dl,(%eax)
    20cc:	eb 46                	jmp    2114 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    20ce:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    20d2:	7e 18                	jle    20ec <sprintf+0x1d6>
    20d4:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    20d8:	7f 12                	jg     20ec <sprintf+0x1d6>
            {
                buf[bi++] = c;
    20da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20dd:	8d 50 01             	lea    0x1(%eax),%edx
    20e0:	89 55 f0             	mov    %edx,-0x10(%ebp)
    20e3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20e6:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    20ea:	eb 2f                	jmp    211b <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    20ec:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20ef:	8d 50 01             	lea    0x1(%eax),%edx
    20f2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20f5:	89 c2                	mov    %eax,%edx
    20f7:	8b 45 08             	mov    0x8(%ebp),%eax
    20fa:	01 d0                	add    %edx,%eax
    20fc:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    20ff:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2102:	8d 50 01             	lea    0x1(%eax),%edx
    2105:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2108:	89 c2                	mov    %eax,%edx
    210a:	8b 45 08             	mov    0x8(%ebp),%eax
    210d:	01 d0                	add    %edx,%eax
    210f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2112:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2114:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    211b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    211f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2122:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2125:	01 d0                	add    %edx,%eax
    2127:	0f b6 00             	movzbl (%eax),%eax
    212a:	84 c0                	test   %al,%al
    212c:	0f 85 14 fe ff ff    	jne    1f46 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2132:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2135:	8d 50 01             	lea    0x1(%eax),%edx
    2138:	89 55 c8             	mov    %edx,-0x38(%ebp)
    213b:	89 c2                	mov    %eax,%edx
    213d:	8b 45 08             	mov    0x8(%ebp),%eax
    2140:	01 d0                	add    %edx,%eax
    2142:	c6 00 00             	movb   $0x0,(%eax)
}
    2145:	90                   	nop
    2146:	c9                   	leave  
    2147:	c3                   	ret    
