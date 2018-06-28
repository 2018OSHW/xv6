
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
       e:	68 60 26 00 00       	push   $0x2660
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
      25:	68 60 26 00 00       	push   $0x2660
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
      47:	68 48 1f 00 00       	push   $0x1f48
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
      cf:	68 59 1f 00 00       	push   $0x1f59
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
     4a1:	0f b6 80 00 26 00 00 	movzbl 0x2600(%eax),%eax
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
     5df:	c7 45 f4 6e 1f 00 00 	movl   $0x1f6e,-0xc(%ebp)
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
     6a5:	a1 48 26 00 00       	mov    0x2648,%eax
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
     770:	a3 48 26 00 00       	mov    %eax,0x2648
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
     7d1:	a1 48 26 00 00       	mov    0x2648,%eax
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
     7ed:	a1 48 26 00 00       	mov    0x2648,%eax
     7f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7f9:	75 23                	jne    81e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7fb:	c7 45 f0 40 26 00 00 	movl   $0x2640,-0x10(%ebp)
     802:	8b 45 f0             	mov    -0x10(%ebp),%eax
     805:	a3 48 26 00 00       	mov    %eax,0x2648
     80a:	a1 48 26 00 00       	mov    0x2648,%eax
     80f:	a3 40 26 00 00       	mov    %eax,0x2640
    base.s.size = 0;
     814:	c7 05 44 26 00 00 00 	movl   $0x0,0x2644
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
     871:	a3 48 26 00 00       	mov    %eax,0x2648
      return (void*)(p + 1);
     876:	8b 45 f4             	mov    -0xc(%ebp),%eax
     879:	83 c0 08             	add    $0x8,%eax
     87c:	eb 3b                	jmp    8b9 <malloc+0xe1>
    }
    if(p == freep)
     87e:	a1 48 26 00 00       	mov    0x2648,%eax
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
     98e:	56                   	push   %esi
     98f:	53                   	push   %ebx
     990:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     993:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     99a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     99d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9a0:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9a7:	83 ec 08             	sub    $0x8,%esp
     9aa:	6a 00                	push   $0x0
     9ac:	ff 75 0c             	pushl  0xc(%ebp)
     9af:	e8 f2 f9 ff ff       	call   3a6 <open>
     9b4:	83 c4 10             	add    $0x10,%esp
     9b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9ba:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9be:	79 2e                	jns    9ee <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     9c0:	83 ec 04             	sub    $0x4,%esp
     9c3:	ff 75 0c             	pushl  0xc(%ebp)
     9c6:	68 78 1f 00 00       	push   $0x1f78
     9cb:	6a 01                	push   $0x1
     9cd:	e8 33 fb ff ff       	call   505 <printf>
     9d2:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9d5:	8b 45 08             	mov    0x8(%ebp),%eax
     9d8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9db:	89 10                	mov    %edx,(%eax)
     9dd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e0:	89 50 04             	mov    %edx,0x4(%eax)
     9e3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9e6:	89 50 08             	mov    %edx,0x8(%eax)
     9e9:	e9 1b 02 00 00       	jmp    c09 <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9ee:	83 ec 04             	sub    $0x4,%esp
     9f1:	6a 10                	push   $0x10
     9f3:	8d 45 b8             	lea    -0x48(%ebp),%eax
     9f6:	50                   	push   %eax
     9f7:	ff 75 ec             	pushl  -0x14(%ebp)
     9fa:	e8 7f f9 ff ff       	call   37e <read>
     9ff:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     a02:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     a06:	0f b7 f0             	movzwl %ax,%esi
     a09:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     a0d:	0f b7 d8             	movzwl %ax,%ebx
     a10:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     a13:	8b 55 bc             	mov    -0x44(%ebp),%edx
     a16:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     a1a:	0f b7 c0             	movzwl %ax,%eax
     a1d:	83 ec 04             	sub    $0x4,%esp
     a20:	56                   	push   %esi
     a21:	53                   	push   %ebx
     a22:	51                   	push   %ecx
     a23:	52                   	push   %edx
     a24:	50                   	push   %eax
     a25:	68 88 1f 00 00       	push   $0x1f88
     a2a:	6a 01                	push   $0x1
     a2c:	e8 d4 fa ff ff       	call   505 <printf>
     a31:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a34:	83 ec 04             	sub    $0x4,%esp
     a37:	6a 28                	push   $0x28
     a39:	8d 45 90             	lea    -0x70(%ebp),%eax
     a3c:	50                   	push   %eax
     a3d:	ff 75 ec             	pushl  -0x14(%ebp)
     a40:	e8 39 f9 ff ff       	call   37e <read>
     a45:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a48:	8b 45 94             	mov    -0x6c(%ebp),%eax
     a4b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a4e:	8b 45 98             	mov    -0x68(%ebp),%eax
     a51:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     a54:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a57:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a5a:	52                   	push   %edx
     a5b:	50                   	push   %eax
     a5c:	68 98 1f 00 00       	push   $0x1f98
     a61:	6a 01                	push   $0x1
     a63:	e8 9d fa ff ff       	call   505 <printf>
     a68:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a6b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a6e:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a71:	0f af d0             	imul   %eax,%edx
     a74:	89 d0                	mov    %edx,%eax
     a76:	01 c0                	add    %eax,%eax
     a78:	01 d0                	add    %edx,%eax
     a7a:	83 ec 0c             	sub    $0xc,%esp
     a7d:	50                   	push   %eax
     a7e:	e8 55 fd ff ff       	call   7d8 <malloc>
     a83:	83 c4 10             	add    $0x10,%esp
     a86:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a89:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     a8d:	0f b7 c0             	movzwl %ax,%eax
     a90:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a93:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a96:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a99:	0f af c2             	imul   %edx,%eax
     a9c:	83 c0 1f             	add    $0x1f,%eax
     a9f:	c1 e8 05             	shr    $0x5,%eax
     aa2:	c1 e0 02             	shl    $0x2,%eax
     aa5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     aa8:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     aae:	0f af c2             	imul   %edx,%eax
     ab1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     ab4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ab7:	83 ec 0c             	sub    $0xc,%esp
     aba:	50                   	push   %eax
     abb:	e8 18 fd ff ff       	call   7d8 <malloc>
     ac0:	83 c4 10             	add    $0x10,%esp
     ac3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ac6:	83 ec 04             	sub    $0x4,%esp
     ac9:	ff 75 e0             	pushl  -0x20(%ebp)
     acc:	ff 75 dc             	pushl  -0x24(%ebp)
     acf:	ff 75 ec             	pushl  -0x14(%ebp)
     ad2:	e8 a7 f8 ff ff       	call   37e <read>
     ad7:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     ada:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     ade:	66 c1 e8 03          	shr    $0x3,%ax
     ae2:	0f b7 c0             	movzwl %ax,%eax
     ae5:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     ae8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aef:	e9 e5 00 00 00       	jmp    bd9 <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     af4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afa:	29 c2                	sub    %eax,%edx
     afc:	89 d0                	mov    %edx,%eax
     afe:	8d 50 ff             	lea    -0x1(%eax),%edx
     b01:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b04:	0f af c2             	imul   %edx,%eax
     b07:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b0a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b11:	e9 b1 00 00 00       	jmp    bc7 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b16:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b19:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b1f:	01 c8                	add    %ecx,%eax
     b21:	89 c1                	mov    %eax,%ecx
     b23:	89 c8                	mov    %ecx,%eax
     b25:	01 c0                	add    %eax,%eax
     b27:	01 c8                	add    %ecx,%eax
     b29:	01 c2                	add    %eax,%edx
     b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b32:	89 c1                	mov    %eax,%ecx
     b34:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b37:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b3b:	01 c1                	add    %eax,%ecx
     b3d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b40:	01 c8                	add    %ecx,%eax
     b42:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b45:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b48:	01 c8                	add    %ecx,%eax
     b4a:	0f b6 00             	movzbl (%eax),%eax
     b4d:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b50:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b53:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b56:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b59:	01 c8                	add    %ecx,%eax
     b5b:	89 c1                	mov    %eax,%ecx
     b5d:	89 c8                	mov    %ecx,%eax
     b5f:	01 c0                	add    %eax,%eax
     b61:	01 c8                	add    %ecx,%eax
     b63:	01 c2                	add    %eax,%edx
     b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b68:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b6c:	89 c1                	mov    %eax,%ecx
     b6e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b71:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b75:	01 c1                	add    %eax,%ecx
     b77:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b7a:	01 c8                	add    %ecx,%eax
     b7c:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b7f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b82:	01 c8                	add    %ecx,%eax
     b84:	0f b6 00             	movzbl (%eax),%eax
     b87:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b8a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b8d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b90:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b93:	01 c8                	add    %ecx,%eax
     b95:	89 c1                	mov    %eax,%ecx
     b97:	89 c8                	mov    %ecx,%eax
     b99:	01 c0                	add    %eax,%eax
     b9b:	01 c8                	add    %ecx,%eax
     b9d:	01 c2                	add    %eax,%edx
     b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba2:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ba6:	89 c1                	mov    %eax,%ecx
     ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bab:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     baf:	01 c1                	add    %eax,%ecx
     bb1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bb4:	01 c8                	add    %ecx,%eax
     bb6:	8d 48 fd             	lea    -0x3(%eax),%ecx
     bb9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bbc:	01 c8                	add    %ecx,%eax
     bbe:	0f b6 00             	movzbl (%eax),%eax
     bc1:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     bc3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bc7:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bcd:	39 c2                	cmp    %eax,%edx
     bcf:	0f 87 41 ff ff ff    	ja     b16 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     bd5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bd9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdf:	39 c2                	cmp    %eax,%edx
     be1:	0f 87 0d ff ff ff    	ja     af4 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     be7:	83 ec 0c             	sub    $0xc,%esp
     bea:	ff 75 ec             	pushl  -0x14(%ebp)
     bed:	e8 9c f7 ff ff       	call   38e <close>
     bf2:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bf5:	8b 45 08             	mov    0x8(%ebp),%eax
     bf8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bfb:	89 10                	mov    %edx,(%eax)
     bfd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c00:	89 50 04             	mov    %edx,0x4(%eax)
     c03:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c06:	89 50 08             	mov    %edx,0x8(%eax)
}
     c09:	8b 45 08             	mov    0x8(%ebp),%eax
     c0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c0f:	5b                   	pop    %ebx
     c10:	5e                   	pop    %esi
     c11:	5d                   	pop    %ebp
     c12:	c2 04 00             	ret    $0x4

00000c15 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c15:	55                   	push   %ebp
     c16:	89 e5                	mov    %esp,%ebp
     c18:	53                   	push   %ebx
     c19:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c1c:	83 ec 0c             	sub    $0xc,%esp
     c1f:	6a 1c                	push   $0x1c
     c21:	e8 b2 fb ff ff       	call   7d8 <malloc>
     c26:	83 c4 10             	add    $0x10,%esp
     c29:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c36:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c39:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c3c:	6a 0c                	push   $0xc
     c3e:	6a 0c                	push   $0xc
     c40:	6a 0c                	push   $0xc
     c42:	50                   	push   %eax
     c43:	e8 73 fc ff ff       	call   8bb <RGB>
     c48:	83 c4 0c             	add    $0xc,%esp
     c4b:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c4f:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c53:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c57:	88 43 15             	mov    %al,0x15(%ebx)
     c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c60:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c64:	66 89 48 10          	mov    %cx,0x10(%eax)
     c68:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c6c:	88 50 12             	mov    %dl,0x12(%eax)
     c6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c72:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c75:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c79:	66 89 48 08          	mov    %cx,0x8(%eax)
     c7d:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c81:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c84:	8b 45 08             	mov    0x8(%ebp),%eax
     c87:	89 c2                	mov    %eax,%edx
     c89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8c:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c91:	89 c2                	mov    %eax,%edx
     c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c96:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c99:	8b 55 10             	mov    0x10(%ebp),%edx
     c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c9f:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ca5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ca8:	c9                   	leave  
     ca9:	c3                   	ret    

00000caa <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     caa:	55                   	push   %ebp
     cab:	89 e5                	mov    %esp,%ebp
     cad:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb3:	8b 50 08             	mov    0x8(%eax),%edx
     cb6:	89 55 f8             	mov    %edx,-0x8(%ebp)
     cb9:	8b 40 0c             	mov    0xc(%eax),%eax
     cbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc2:	8b 55 10             	mov    0x10(%ebp),%edx
     cc5:	89 50 08             	mov    %edx,0x8(%eax)
     cc8:	8b 55 14             	mov    0x14(%ebp),%edx
     ccb:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     cce:	8b 45 08             	mov    0x8(%ebp),%eax
     cd1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     cd4:	89 10                	mov    %edx,(%eax)
     cd6:	8b 55 fc             	mov    -0x4(%ebp),%edx
     cd9:	89 50 04             	mov    %edx,0x4(%eax)
}
     cdc:	8b 45 08             	mov    0x8(%ebp),%eax
     cdf:	c9                   	leave  
     ce0:	c2 04 00             	ret    $0x4

00000ce3 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ce3:	55                   	push   %ebp
     ce4:	89 e5                	mov    %esp,%ebp
     ce6:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cec:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     cf0:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cf4:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cf8:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cfe:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d02:	66 89 50 10          	mov    %dx,0x10(%eax)
     d06:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d0a:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d0d:	8b 45 08             	mov    0x8(%ebp),%eax
     d10:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d14:	66 89 10             	mov    %dx,(%eax)
     d17:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d1b:	88 50 02             	mov    %dl,0x2(%eax)
}
     d1e:	8b 45 08             	mov    0x8(%ebp),%eax
     d21:	c9                   	leave  
     d22:	c2 04 00             	ret    $0x4

00000d25 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d25:	55                   	push   %ebp
     d26:	89 e5                	mov    %esp,%ebp
     d28:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d2b:	8b 45 08             	mov    0x8(%ebp),%eax
     d2e:	8b 40 0c             	mov    0xc(%eax),%eax
     d31:	89 c2                	mov    %eax,%edx
     d33:	c1 ea 1f             	shr    $0x1f,%edx
     d36:	01 d0                	add    %edx,%eax
     d38:	d1 f8                	sar    %eax
     d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d40:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d44:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d47:	8b 45 10             	mov    0x10(%ebp),%eax
     d4a:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d4d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d50:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d54:	0f 89 98 00 00 00    	jns    df2 <APDrawPoint+0xcd>
        i = 0;
     d5a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d61:	e9 8c 00 00 00       	jmp    df2 <APDrawPoint+0xcd>
    {
        j = x - off;
     d66:	8b 45 0c             	mov    0xc(%ebp),%eax
     d69:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d6c:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d6f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d73:	79 69                	jns    dde <APDrawPoint+0xb9>
            j = 0;
     d75:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d7c:	eb 60                	jmp    dde <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d7e:	ff 75 fc             	pushl  -0x4(%ebp)
     d81:	ff 75 f8             	pushl  -0x8(%ebp)
     d84:	ff 75 08             	pushl  0x8(%ebp)
     d87:	e8 ad fb ff ff       	call   939 <APGetIndex>
     d8c:	83 c4 0c             	add    $0xc,%esp
     d8f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d92:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d96:	74 55                	je     ded <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d98:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d9c:	74 67                	je     e05 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d9e:	ff 75 10             	pushl  0x10(%ebp)
     da1:	ff 75 0c             	pushl  0xc(%ebp)
     da4:	ff 75 fc             	pushl  -0x4(%ebp)
     da7:	ff 75 f8             	pushl  -0x8(%ebp)
     daa:	e8 51 fb ff ff       	call   900 <distance_2>
     daf:	83 c4 10             	add    $0x10,%esp
     db2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     db5:	7f 23                	jg     dda <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     db7:	8b 45 08             	mov    0x8(%ebp),%eax
     dba:	8b 48 18             	mov    0x18(%eax),%ecx
     dbd:	8b 55 ec             	mov    -0x14(%ebp),%edx
     dc0:	89 d0                	mov    %edx,%eax
     dc2:	01 c0                	add    %eax,%eax
     dc4:	01 d0                	add    %edx,%eax
     dc6:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dc9:	8b 45 08             	mov    0x8(%ebp),%eax
     dcc:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dd0:	66 89 0a             	mov    %cx,(%edx)
     dd3:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     dd7:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     dda:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     dde:	8b 55 0c             	mov    0xc(%ebp),%edx
     de1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de4:	01 d0                	add    %edx,%eax
     de6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     de9:	7d 93                	jge    d7e <APDrawPoint+0x59>
     deb:	eb 01                	jmp    dee <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     ded:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     dee:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     df2:	8b 55 10             	mov    0x10(%ebp),%edx
     df5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df8:	01 d0                	add    %edx,%eax
     dfa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     dfd:	0f 8d 63 ff ff ff    	jge    d66 <APDrawPoint+0x41>
     e03:	eb 01                	jmp    e06 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e05:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e06:	c9                   	leave  
     e07:	c3                   	ret    

00000e08 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e08:	55                   	push   %ebp
     e09:	89 e5                	mov    %esp,%ebp
     e0b:	53                   	push   %ebx
     e0c:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e12:	3b 45 14             	cmp    0x14(%ebp),%eax
     e15:	0f 85 80 00 00 00    	jne    e9b <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e1f:	0f 88 9d 02 00 00    	js     10c2 <APDrawLine+0x2ba>
     e25:	8b 45 08             	mov    0x8(%ebp),%eax
     e28:	8b 00                	mov    (%eax),%eax
     e2a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e2d:	0f 8e 8f 02 00 00    	jle    10c2 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e33:	8b 45 10             	mov    0x10(%ebp),%eax
     e36:	3b 45 18             	cmp    0x18(%ebp),%eax
     e39:	7e 12                	jle    e4d <APDrawLine+0x45>
        {
            int tmp = y2;
     e3b:	8b 45 18             	mov    0x18(%ebp),%eax
     e3e:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e41:	8b 45 10             	mov    0x10(%ebp),%eax
     e44:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e47:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e4a:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e51:	79 07                	jns    e5a <APDrawLine+0x52>
     e53:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e5a:	8b 45 08             	mov    0x8(%ebp),%eax
     e5d:	8b 40 04             	mov    0x4(%eax),%eax
     e60:	3b 45 18             	cmp    0x18(%ebp),%eax
     e63:	7d 0c                	jge    e71 <APDrawLine+0x69>
     e65:	8b 45 08             	mov    0x8(%ebp),%eax
     e68:	8b 40 04             	mov    0x4(%eax),%eax
     e6b:	83 e8 01             	sub    $0x1,%eax
     e6e:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e71:	8b 45 10             	mov    0x10(%ebp),%eax
     e74:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e77:	eb 15                	jmp    e8e <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e79:	ff 75 f4             	pushl  -0xc(%ebp)
     e7c:	ff 75 0c             	pushl  0xc(%ebp)
     e7f:	ff 75 08             	pushl  0x8(%ebp)
     e82:	e8 9e fe ff ff       	call   d25 <APDrawPoint>
     e87:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e8a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e91:	3b 45 18             	cmp    0x18(%ebp),%eax
     e94:	7e e3                	jle    e79 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e96:	e9 2b 02 00 00       	jmp    10c6 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e9b:	8b 45 10             	mov    0x10(%ebp),%eax
     e9e:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea1:	75 7f                	jne    f22 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ea3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ea7:	0f 88 18 02 00 00    	js     10c5 <APDrawLine+0x2bd>
     ead:	8b 45 08             	mov    0x8(%ebp),%eax
     eb0:	8b 40 04             	mov    0x4(%eax),%eax
     eb3:	3b 45 10             	cmp    0x10(%ebp),%eax
     eb6:	0f 8e 09 02 00 00    	jle    10c5 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ebf:	3b 45 14             	cmp    0x14(%ebp),%eax
     ec2:	7e 12                	jle    ed6 <APDrawLine+0xce>
        {
            int tmp = x2;
     ec4:	8b 45 14             	mov    0x14(%ebp),%eax
     ec7:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     eca:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecd:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ed0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ed3:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ed6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     eda:	79 07                	jns    ee3 <APDrawLine+0xdb>
     edc:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ee3:	8b 45 08             	mov    0x8(%ebp),%eax
     ee6:	8b 00                	mov    (%eax),%eax
     ee8:	3b 45 14             	cmp    0x14(%ebp),%eax
     eeb:	7d 0b                	jge    ef8 <APDrawLine+0xf0>
     eed:	8b 45 08             	mov    0x8(%ebp),%eax
     ef0:	8b 00                	mov    (%eax),%eax
     ef2:	83 e8 01             	sub    $0x1,%eax
     ef5:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
     efb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     efe:	eb 15                	jmp    f15 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f00:	ff 75 10             	pushl  0x10(%ebp)
     f03:	ff 75 f0             	pushl  -0x10(%ebp)
     f06:	ff 75 08             	pushl  0x8(%ebp)
     f09:	e8 17 fe ff ff       	call   d25 <APDrawPoint>
     f0e:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f11:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f15:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f18:	3b 45 14             	cmp    0x14(%ebp),%eax
     f1b:	7e e3                	jle    f00 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f1d:	e9 a4 01 00 00       	jmp    10c6 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f22:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f29:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f30:	8b 45 0c             	mov    0xc(%ebp),%eax
     f33:	2b 45 14             	sub    0x14(%ebp),%eax
     f36:	50                   	push   %eax
     f37:	e8 ed f9 ff ff       	call   929 <abs_int>
     f3c:	83 c4 04             	add    $0x4,%esp
     f3f:	89 c3                	mov    %eax,%ebx
     f41:	8b 45 10             	mov    0x10(%ebp),%eax
     f44:	2b 45 18             	sub    0x18(%ebp),%eax
     f47:	50                   	push   %eax
     f48:	e8 dc f9 ff ff       	call   929 <abs_int>
     f4d:	83 c4 04             	add    $0x4,%esp
     f50:	39 c3                	cmp    %eax,%ebx
     f52:	0f 8e b5 00 00 00    	jle    100d <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f58:	8b 45 10             	mov    0x10(%ebp),%eax
     f5b:	2b 45 18             	sub    0x18(%ebp),%eax
     f5e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f61:	db 45 b0             	fildl  -0x50(%ebp)
     f64:	8b 45 0c             	mov    0xc(%ebp),%eax
     f67:	2b 45 14             	sub    0x14(%ebp),%eax
     f6a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f6d:	db 45 b0             	fildl  -0x50(%ebp)
     f70:	de f9                	fdivrp %st,%st(1)
     f72:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f75:	8b 45 14             	mov    0x14(%ebp),%eax
     f78:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f7b:	7e 0e                	jle    f8b <APDrawLine+0x183>
        {
            s = x1;
     f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f80:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f83:	8b 45 14             	mov    0x14(%ebp),%eax
     f86:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f89:	eb 0c                	jmp    f97 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f8b:	8b 45 14             	mov    0x14(%ebp),%eax
     f8e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f91:	8b 45 0c             	mov    0xc(%ebp),%eax
     f94:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f97:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f9b:	79 07                	jns    fa4 <APDrawLine+0x19c>
     f9d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     fa4:	8b 45 08             	mov    0x8(%ebp),%eax
     fa7:	8b 00                	mov    (%eax),%eax
     fa9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fac:	7f 0b                	jg     fb9 <APDrawLine+0x1b1>
     fae:	8b 45 08             	mov    0x8(%ebp),%eax
     fb1:	8b 00                	mov    (%eax),%eax
     fb3:	83 e8 01             	sub    $0x1,%eax
     fb6:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fbc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fbf:	eb 3f                	jmp    1000 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fc4:	2b 45 0c             	sub    0xc(%ebp),%eax
     fc7:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fca:	db 45 b0             	fildl  -0x50(%ebp)
     fcd:	dc 4d d0             	fmull  -0x30(%ebp)
     fd0:	db 45 10             	fildl  0x10(%ebp)
     fd3:	de c1                	faddp  %st,%st(1)
     fd5:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fd8:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fdc:	b4 0c                	mov    $0xc,%ah
     fde:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fe2:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fe5:	db 5d cc             	fistpl -0x34(%ebp)
     fe8:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     feb:	ff 75 cc             	pushl  -0x34(%ebp)
     fee:	ff 75 e4             	pushl  -0x1c(%ebp)
     ff1:	ff 75 08             	pushl  0x8(%ebp)
     ff4:	e8 2c fd ff ff       	call   d25 <APDrawPoint>
     ff9:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     ffc:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1000:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1003:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1006:	7e b9                	jle    fc1 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1008:	e9 b9 00 00 00       	jmp    10c6 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    100d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1010:	2b 45 14             	sub    0x14(%ebp),%eax
    1013:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1016:	db 45 b0             	fildl  -0x50(%ebp)
    1019:	8b 45 10             	mov    0x10(%ebp),%eax
    101c:	2b 45 18             	sub    0x18(%ebp),%eax
    101f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1022:	db 45 b0             	fildl  -0x50(%ebp)
    1025:	de f9                	fdivrp %st,%st(1)
    1027:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    102a:	8b 45 10             	mov    0x10(%ebp),%eax
    102d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1030:	7e 0e                	jle    1040 <APDrawLine+0x238>
    {
        s = y2;
    1032:	8b 45 18             	mov    0x18(%ebp),%eax
    1035:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1038:	8b 45 10             	mov    0x10(%ebp),%eax
    103b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    103e:	eb 0c                	jmp    104c <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1040:	8b 45 10             	mov    0x10(%ebp),%eax
    1043:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1046:	8b 45 18             	mov    0x18(%ebp),%eax
    1049:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    104c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1050:	79 07                	jns    1059 <APDrawLine+0x251>
    1052:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1059:	8b 45 08             	mov    0x8(%ebp),%eax
    105c:	8b 40 04             	mov    0x4(%eax),%eax
    105f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1062:	7f 0c                	jg     1070 <APDrawLine+0x268>
    1064:	8b 45 08             	mov    0x8(%ebp),%eax
    1067:	8b 40 04             	mov    0x4(%eax),%eax
    106a:	83 e8 01             	sub    $0x1,%eax
    106d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1070:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1073:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1076:	eb 3f                	jmp    10b7 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1078:	8b 45 e0             	mov    -0x20(%ebp),%eax
    107b:	2b 45 10             	sub    0x10(%ebp),%eax
    107e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1081:	db 45 b0             	fildl  -0x50(%ebp)
    1084:	dc 4d c0             	fmull  -0x40(%ebp)
    1087:	db 45 0c             	fildl  0xc(%ebp)
    108a:	de c1                	faddp  %st,%st(1)
    108c:	d9 7d b6             	fnstcw -0x4a(%ebp)
    108f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1093:	b4 0c                	mov    $0xc,%ah
    1095:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1099:	d9 6d b4             	fldcw  -0x4c(%ebp)
    109c:	db 5d bc             	fistpl -0x44(%ebp)
    109f:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10a2:	ff 75 e0             	pushl  -0x20(%ebp)
    10a5:	ff 75 bc             	pushl  -0x44(%ebp)
    10a8:	ff 75 08             	pushl  0x8(%ebp)
    10ab:	e8 75 fc ff ff       	call   d25 <APDrawPoint>
    10b0:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10b3:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10ba:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10bd:	7e b9                	jle    1078 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10bf:	90                   	nop
    10c0:	eb 04                	jmp    10c6 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10c2:	90                   	nop
    10c3:	eb 01                	jmp    10c6 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10c5:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10c9:	c9                   	leave  
    10ca:	c3                   	ret    

000010cb <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10cb:	55                   	push   %ebp
    10cc:	89 e5                	mov    %esp,%ebp
    10ce:	53                   	push   %ebx
    10cf:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10d2:	8b 55 10             	mov    0x10(%ebp),%edx
    10d5:	8b 45 18             	mov    0x18(%ebp),%eax
    10d8:	01 d0                	add    %edx,%eax
    10da:	83 e8 01             	sub    $0x1,%eax
    10dd:	83 ec 04             	sub    $0x4,%esp
    10e0:	50                   	push   %eax
    10e1:	ff 75 0c             	pushl  0xc(%ebp)
    10e4:	ff 75 10             	pushl  0x10(%ebp)
    10e7:	ff 75 0c             	pushl  0xc(%ebp)
    10ea:	ff 75 08             	pushl  0x8(%ebp)
    10ed:	e8 16 fd ff ff       	call   e08 <APDrawLine>
    10f2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10f5:	8b 55 0c             	mov    0xc(%ebp),%edx
    10f8:	8b 45 14             	mov    0x14(%ebp),%eax
    10fb:	01 d0                	add    %edx,%eax
    10fd:	83 e8 01             	sub    $0x1,%eax
    1100:	83 ec 04             	sub    $0x4,%esp
    1103:	ff 75 10             	pushl  0x10(%ebp)
    1106:	50                   	push   %eax
    1107:	ff 75 10             	pushl  0x10(%ebp)
    110a:	ff 75 0c             	pushl  0xc(%ebp)
    110d:	ff 75 08             	pushl  0x8(%ebp)
    1110:	e8 f3 fc ff ff       	call   e08 <APDrawLine>
    1115:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1118:	8b 55 10             	mov    0x10(%ebp),%edx
    111b:	8b 45 18             	mov    0x18(%ebp),%eax
    111e:	01 d0                	add    %edx,%eax
    1120:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1123:	8b 55 0c             	mov    0xc(%ebp),%edx
    1126:	8b 45 14             	mov    0x14(%ebp),%eax
    1129:	01 d0                	add    %edx,%eax
    112b:	8d 50 ff             	lea    -0x1(%eax),%edx
    112e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1131:	8b 45 14             	mov    0x14(%ebp),%eax
    1134:	01 d8                	add    %ebx,%eax
    1136:	83 e8 01             	sub    $0x1,%eax
    1139:	83 ec 04             	sub    $0x4,%esp
    113c:	51                   	push   %ecx
    113d:	52                   	push   %edx
    113e:	ff 75 10             	pushl  0x10(%ebp)
    1141:	50                   	push   %eax
    1142:	ff 75 08             	pushl  0x8(%ebp)
    1145:	e8 be fc ff ff       	call   e08 <APDrawLine>
    114a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    114d:	8b 55 10             	mov    0x10(%ebp),%edx
    1150:	8b 45 18             	mov    0x18(%ebp),%eax
    1153:	01 d0                	add    %edx,%eax
    1155:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1158:	8b 55 0c             	mov    0xc(%ebp),%edx
    115b:	8b 45 14             	mov    0x14(%ebp),%eax
    115e:	01 d0                	add    %edx,%eax
    1160:	8d 50 ff             	lea    -0x1(%eax),%edx
    1163:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1166:	8b 45 18             	mov    0x18(%ebp),%eax
    1169:	01 d8                	add    %ebx,%eax
    116b:	83 e8 01             	sub    $0x1,%eax
    116e:	83 ec 04             	sub    $0x4,%esp
    1171:	51                   	push   %ecx
    1172:	52                   	push   %edx
    1173:	50                   	push   %eax
    1174:	ff 75 0c             	pushl  0xc(%ebp)
    1177:	ff 75 08             	pushl  0x8(%ebp)
    117a:	e8 89 fc ff ff       	call   e08 <APDrawLine>
    117f:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1182:	8b 55 0c             	mov    0xc(%ebp),%edx
    1185:	8b 45 14             	mov    0x14(%ebp),%eax
    1188:	01 d0                	add    %edx,%eax
    118a:	8d 50 ff             	lea    -0x1(%eax),%edx
    118d:	8b 45 08             	mov    0x8(%ebp),%eax
    1190:	8b 40 0c             	mov    0xc(%eax),%eax
    1193:	89 c1                	mov    %eax,%ecx
    1195:	c1 e9 1f             	shr    $0x1f,%ecx
    1198:	01 c8                	add    %ecx,%eax
    119a:	d1 f8                	sar    %eax
    119c:	29 c2                	sub    %eax,%edx
    119e:	89 d0                	mov    %edx,%eax
    11a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11a3:	8b 55 10             	mov    0x10(%ebp),%edx
    11a6:	8b 45 18             	mov    0x18(%ebp),%eax
    11a9:	01 d0                	add    %edx,%eax
    11ab:	8d 50 ff             	lea    -0x1(%eax),%edx
    11ae:	8b 45 08             	mov    0x8(%ebp),%eax
    11b1:	8b 40 0c             	mov    0xc(%eax),%eax
    11b4:	89 c1                	mov    %eax,%ecx
    11b6:	c1 e9 1f             	shr    $0x1f,%ecx
    11b9:	01 c8                	add    %ecx,%eax
    11bb:	d1 f8                	sar    %eax
    11bd:	29 c2                	sub    %eax,%edx
    11bf:	89 d0                	mov    %edx,%eax
    11c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11c4:	8b 45 08             	mov    0x8(%ebp),%eax
    11c7:	8b 40 0c             	mov    0xc(%eax),%eax
    11ca:	89 c2                	mov    %eax,%edx
    11cc:	c1 ea 1f             	shr    $0x1f,%edx
    11cf:	01 d0                	add    %edx,%eax
    11d1:	d1 f8                	sar    %eax
    11d3:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11d6:	8b 45 08             	mov    0x8(%ebp),%eax
    11d9:	8b 40 0c             	mov    0xc(%eax),%eax
    11dc:	89 c2                	mov    %eax,%edx
    11de:	c1 ea 1f             	shr    $0x1f,%edx
    11e1:	01 d0                	add    %edx,%eax
    11e3:	d1 f8                	sar    %eax
    11e5:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11ec:	0f 88 d8 00 00 00    	js     12ca <APDrawRect+0x1ff>
    11f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11f6:	0f 88 ce 00 00 00    	js     12ca <APDrawRect+0x1ff>
    11fc:	8b 45 08             	mov    0x8(%ebp),%eax
    11ff:	8b 00                	mov    (%eax),%eax
    1201:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1204:	0f 8e c0 00 00 00    	jle    12ca <APDrawRect+0x1ff>
    120a:	8b 45 08             	mov    0x8(%ebp),%eax
    120d:	8b 40 04             	mov    0x4(%eax),%eax
    1210:	3b 45 10             	cmp    0x10(%ebp),%eax
    1213:	0f 8e b1 00 00 00    	jle    12ca <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1219:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    121d:	79 07                	jns    1226 <APDrawRect+0x15b>
    121f:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1226:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    122a:	79 07                	jns    1233 <APDrawRect+0x168>
    122c:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1233:	8b 45 08             	mov    0x8(%ebp),%eax
    1236:	8b 00                	mov    (%eax),%eax
    1238:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    123b:	7f 0b                	jg     1248 <APDrawRect+0x17d>
    123d:	8b 45 08             	mov    0x8(%ebp),%eax
    1240:	8b 00                	mov    (%eax),%eax
    1242:	83 e8 01             	sub    $0x1,%eax
    1245:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	8b 40 04             	mov    0x4(%eax),%eax
    124e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1251:	7f 0c                	jg     125f <APDrawRect+0x194>
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	8b 40 04             	mov    0x4(%eax),%eax
    1259:	83 e8 01             	sub    $0x1,%eax
    125c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    125f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1266:	8b 45 0c             	mov    0xc(%ebp),%eax
    1269:	89 45 ec             	mov    %eax,-0x14(%ebp)
    126c:	eb 52                	jmp    12c0 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    126e:	8b 45 10             	mov    0x10(%ebp),%eax
    1271:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1274:	eb 3e                	jmp    12b4 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1276:	83 ec 04             	sub    $0x4,%esp
    1279:	ff 75 e8             	pushl  -0x18(%ebp)
    127c:	ff 75 ec             	pushl  -0x14(%ebp)
    127f:	ff 75 08             	pushl  0x8(%ebp)
    1282:	e8 b2 f6 ff ff       	call   939 <APGetIndex>
    1287:	83 c4 10             	add    $0x10,%esp
    128a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    128d:	8b 45 08             	mov    0x8(%ebp),%eax
    1290:	8b 48 18             	mov    0x18(%eax),%ecx
    1293:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1296:	89 d0                	mov    %edx,%eax
    1298:	01 c0                	add    %eax,%eax
    129a:	01 d0                	add    %edx,%eax
    129c:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    129f:	8b 45 08             	mov    0x8(%ebp),%eax
    12a2:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12a6:	66 89 0a             	mov    %cx,(%edx)
    12a9:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12ad:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12b0:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12b7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12ba:	7e ba                	jle    1276 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12bc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12c3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12c6:	7e a6                	jle    126e <APDrawRect+0x1a3>
    12c8:	eb 01                	jmp    12cb <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12ca:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12ce:	c9                   	leave  
    12cf:	c3                   	ret    

000012d0 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    12d6:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    12da:	0f 88 8e 01 00 00    	js     146e <APDcCopy+0x19e>
    12e0:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    12e4:	0f 88 84 01 00 00    	js     146e <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12ea:	8b 55 0c             	mov    0xc(%ebp),%edx
    12ed:	8b 45 20             	mov    0x20(%ebp),%eax
    12f0:	01 d0                	add    %edx,%eax
    12f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12f5:	8b 55 10             	mov    0x10(%ebp),%edx
    12f8:	8b 45 24             	mov    0x24(%ebp),%eax
    12fb:	01 d0                	add    %edx,%eax
    12fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1300:	8b 55 18             	mov    0x18(%ebp),%edx
    1303:	8b 45 20             	mov    0x20(%ebp),%eax
    1306:	01 d0                	add    %edx,%eax
    1308:	89 45 ec             	mov    %eax,-0x14(%ebp)
    130b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    130e:	8b 45 24             	mov    0x24(%ebp),%eax
    1311:	01 d0                	add    %edx,%eax
    1313:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1316:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    131a:	0f 88 51 01 00 00    	js     1471 <APDcCopy+0x1a1>
    1320:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1324:	0f 88 47 01 00 00    	js     1471 <APDcCopy+0x1a1>
    132a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    132e:	0f 88 3d 01 00 00    	js     1471 <APDcCopy+0x1a1>
    1334:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1338:	0f 88 33 01 00 00    	js     1471 <APDcCopy+0x1a1>
    133e:	8b 45 14             	mov    0x14(%ebp),%eax
    1341:	8b 00                	mov    (%eax),%eax
    1343:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1346:	0f 8e 25 01 00 00    	jle    1471 <APDcCopy+0x1a1>
    134c:	8b 45 14             	mov    0x14(%ebp),%eax
    134f:	8b 40 04             	mov    0x4(%eax),%eax
    1352:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1355:	0f 8e 16 01 00 00    	jle    1471 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    135b:	8b 45 08             	mov    0x8(%ebp),%eax
    135e:	8b 00                	mov    (%eax),%eax
    1360:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1363:	7d 0b                	jge    1370 <APDcCopy+0xa0>
    1365:	8b 45 08             	mov    0x8(%ebp),%eax
    1368:	8b 00                	mov    (%eax),%eax
    136a:	83 e8 01             	sub    $0x1,%eax
    136d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    1370:	8b 45 08             	mov    0x8(%ebp),%eax
    1373:	8b 40 04             	mov    0x4(%eax),%eax
    1376:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1379:	7d 0c                	jge    1387 <APDcCopy+0xb7>
    137b:	8b 45 08             	mov    0x8(%ebp),%eax
    137e:	8b 40 04             	mov    0x4(%eax),%eax
    1381:	83 e8 01             	sub    $0x1,%eax
    1384:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1387:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    138e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    1395:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    139c:	e9 bc 00 00 00       	jmp    145d <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    13a1:	8b 45 08             	mov    0x8(%ebp),%eax
    13a4:	8b 00                	mov    (%eax),%eax
    13a6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13a9:	8b 55 10             	mov    0x10(%ebp),%edx
    13ac:	01 ca                	add    %ecx,%edx
    13ae:	0f af d0             	imul   %eax,%edx
    13b1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b4:	01 d0                	add    %edx,%eax
    13b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13b9:	8b 45 14             	mov    0x14(%ebp),%eax
    13bc:	8b 00                	mov    (%eax),%eax
    13be:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13c1:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13c4:	01 ca                	add    %ecx,%edx
    13c6:	0f af d0             	imul   %eax,%edx
    13c9:	8b 45 18             	mov    0x18(%ebp),%eax
    13cc:	01 d0                	add    %edx,%eax
    13ce:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    13d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13d8:	eb 74                	jmp    144e <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    13da:	8b 45 14             	mov    0x14(%ebp),%eax
    13dd:	8b 50 18             	mov    0x18(%eax),%edx
    13e0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e6:	01 c8                	add    %ecx,%eax
    13e8:	89 c1                	mov    %eax,%ecx
    13ea:	89 c8                	mov    %ecx,%eax
    13ec:	01 c0                	add    %eax,%eax
    13ee:	01 c8                	add    %ecx,%eax
    13f0:	01 d0                	add    %edx,%eax
    13f2:	0f b7 10             	movzwl (%eax),%edx
    13f5:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13f9:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13fd:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1400:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1404:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1408:	38 c2                	cmp    %al,%dl
    140a:	75 18                	jne    1424 <APDcCopy+0x154>
    140c:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1410:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1414:	38 c2                	cmp    %al,%dl
    1416:	75 0c                	jne    1424 <APDcCopy+0x154>
    1418:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    141c:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1420:	38 c2                	cmp    %al,%dl
    1422:	74 26                	je     144a <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1424:	8b 45 08             	mov    0x8(%ebp),%eax
    1427:	8b 50 18             	mov    0x18(%eax),%edx
    142a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    142d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1430:	01 c8                	add    %ecx,%eax
    1432:	89 c1                	mov    %eax,%ecx
    1434:	89 c8                	mov    %ecx,%eax
    1436:	01 c0                	add    %eax,%eax
    1438:	01 c8                	add    %ecx,%eax
    143a:	01 d0                	add    %edx,%eax
    143c:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1440:	66 89 10             	mov    %dx,(%eax)
    1443:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1447:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    144a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    144e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1451:	2b 45 0c             	sub    0xc(%ebp),%eax
    1454:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1457:	7f 81                	jg     13da <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    1459:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    145d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1460:	2b 45 10             	sub    0x10(%ebp),%eax
    1463:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1466:	0f 8f 35 ff ff ff    	jg     13a1 <APDcCopy+0xd1>
    146c:	eb 04                	jmp    1472 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    146e:	90                   	nop
    146f:	eb 01                	jmp    1472 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    1471:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1472:	c9                   	leave  
    1473:	c3                   	ret    

00001474 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1474:	55                   	push   %ebp
    1475:	89 e5                	mov    %esp,%ebp
    1477:	83 ec 1c             	sub    $0x1c,%esp
    147a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    147d:	8b 55 10             	mov    0x10(%ebp),%edx
    1480:	8b 45 14             	mov    0x14(%ebp),%eax
    1483:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1486:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1489:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    148c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1490:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1493:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1497:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    149a:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    149e:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    14a1:	8b 45 08             	mov    0x8(%ebp),%eax
    14a4:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14a8:	66 89 10             	mov    %dx,(%eax)
    14ab:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14af:	88 50 02             	mov    %dl,0x2(%eax)
}
    14b2:	8b 45 08             	mov    0x8(%ebp),%eax
    14b5:	c9                   	leave  
    14b6:	c2 04 00             	ret    $0x4

000014b9 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14b9:	55                   	push   %ebp
    14ba:	89 e5                	mov    %esp,%ebp
    14bc:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14bf:	8b 45 08             	mov    0x8(%ebp),%eax
    14c2:	8b 00                	mov    (%eax),%eax
    14c4:	83 ec 08             	sub    $0x8,%esp
    14c7:	8d 55 0c             	lea    0xc(%ebp),%edx
    14ca:	52                   	push   %edx
    14cb:	50                   	push   %eax
    14cc:	e8 45 ef ff ff       	call   416 <sendMessage>
    14d1:	83 c4 10             	add    $0x10,%esp
}
    14d4:	90                   	nop
    14d5:	c9                   	leave  
    14d6:	c3                   	ret    

000014d7 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    14d7:	55                   	push   %ebp
    14d8:	89 e5                	mov    %esp,%ebp
    14da:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    14dd:	83 ec 0c             	sub    $0xc,%esp
    14e0:	68 90 00 00 00       	push   $0x90
    14e5:	e8 ee f2 ff ff       	call   7d8 <malloc>
    14ea:	83 c4 10             	add    $0x10,%esp
    14ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14f4:	75 15                	jne    150b <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14f6:	83 ec 04             	sub    $0x4,%esp
    14f9:	ff 75 08             	pushl  0x8(%ebp)
    14fc:	68 bc 1f 00 00       	push   $0x1fbc
    1501:	6a 01                	push   $0x1
    1503:	e8 fd ef ff ff       	call   505 <printf>
    1508:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    150b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    150e:	83 c0 7c             	add    $0x7c,%eax
    1511:	83 ec 08             	sub    $0x8,%esp
    1514:	ff 75 08             	pushl  0x8(%ebp)
    1517:	50                   	push   %eax
    1518:	e8 18 ec ff ff       	call   135 <strcpy>
    151d:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1520:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1523:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    152a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152d:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1534:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1537:	8b 40 34             	mov    0x34(%eax),%eax
    153a:	89 c2                	mov    %eax,%edx
    153c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153f:	8b 40 38             	mov    0x38(%eax),%eax
    1542:	0f af d0             	imul   %eax,%edx
    1545:	89 d0                	mov    %edx,%eax
    1547:	01 c0                	add    %eax,%eax
    1549:	01 d0                	add    %edx,%eax
    154b:	83 ec 0c             	sub    $0xc,%esp
    154e:	50                   	push   %eax
    154f:	e8 84 f2 ff ff       	call   7d8 <malloc>
    1554:	83 c4 10             	add    $0x10,%esp
    1557:	89 c2                	mov    %eax,%edx
    1559:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155c:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    155f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1562:	8b 40 4c             	mov    0x4c(%eax),%eax
    1565:	85 c0                	test   %eax,%eax
    1567:	75 15                	jne    157e <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1569:	83 ec 04             	sub    $0x4,%esp
    156c:	ff 75 08             	pushl  0x8(%ebp)
    156f:	68 dc 1f 00 00       	push   $0x1fdc
    1574:	6a 01                	push   $0x1
    1576:	e8 8a ef ff ff       	call   505 <printf>
    157b:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1581:	8b 40 34             	mov    0x34(%eax),%eax
    1584:	89 c2                	mov    %eax,%edx
    1586:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1589:	8b 40 38             	mov    0x38(%eax),%eax
    158c:	0f af d0             	imul   %eax,%edx
    158f:	89 d0                	mov    %edx,%eax
    1591:	01 c0                	add    %eax,%eax
    1593:	01 c2                	add    %eax,%edx
    1595:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1598:	8b 40 4c             	mov    0x4c(%eax),%eax
    159b:	83 ec 04             	sub    $0x4,%esp
    159e:	52                   	push   %edx
    159f:	68 ff ff ff 00       	push   $0xffffff
    15a4:	50                   	push   %eax
    15a5:	e8 21 ec ff ff       	call   1cb <memset>
    15aa:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b0:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    15b7:	e8 2a ee ff ff       	call   3e6 <getpid>
    15bc:	89 c2                	mov    %eax,%edx
    15be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c1:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c7:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    15ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d1:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15db:	8b 40 50             	mov    0x50(%eax),%eax
    15de:	89 c2                	mov    %eax,%edx
    15e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e3:	8b 40 54             	mov    0x54(%eax),%eax
    15e6:	0f af d0             	imul   %eax,%edx
    15e9:	89 d0                	mov    %edx,%eax
    15eb:	01 c0                	add    %eax,%eax
    15ed:	01 d0                	add    %edx,%eax
    15ef:	83 ec 0c             	sub    $0xc,%esp
    15f2:	50                   	push   %eax
    15f3:	e8 e0 f1 ff ff       	call   7d8 <malloc>
    15f8:	83 c4 10             	add    $0x10,%esp
    15fb:	89 c2                	mov    %eax,%edx
    15fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1600:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1603:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1606:	8b 40 68             	mov    0x68(%eax),%eax
    1609:	85 c0                	test   %eax,%eax
    160b:	75 15                	jne    1622 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    160d:	83 ec 04             	sub    $0x4,%esp
    1610:	ff 75 08             	pushl  0x8(%ebp)
    1613:	68 00 20 00 00       	push   $0x2000
    1618:	6a 01                	push   $0x1
    161a:	e8 e6 ee ff ff       	call   505 <printf>
    161f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1622:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1625:	8b 40 34             	mov    0x34(%eax),%eax
    1628:	89 c2                	mov    %eax,%edx
    162a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162d:	8b 40 38             	mov    0x38(%eax),%eax
    1630:	0f af d0             	imul   %eax,%edx
    1633:	89 d0                	mov    %edx,%eax
    1635:	01 c0                	add    %eax,%eax
    1637:	01 c2                	add    %eax,%edx
    1639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163c:	8b 40 4c             	mov    0x4c(%eax),%eax
    163f:	83 ec 04             	sub    $0x4,%esp
    1642:	52                   	push   %edx
    1643:	68 ff 00 00 00       	push   $0xff
    1648:	50                   	push   %eax
    1649:	e8 7d eb ff ff       	call   1cb <memset>
    164e:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1651:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1654:	8b 55 0c             	mov    0xc(%ebp),%edx
    1657:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    165a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    165e:	74 35                	je     1695 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1660:	8b 45 10             	mov    0x10(%ebp),%eax
    1663:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1669:	83 ec 0c             	sub    $0xc,%esp
    166c:	50                   	push   %eax
    166d:	e8 66 f1 ff ff       	call   7d8 <malloc>
    1672:	83 c4 10             	add    $0x10,%esp
    1675:	89 c2                	mov    %eax,%edx
    1677:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167a:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    167d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1680:	8b 55 10             	mov    0x10(%ebp),%edx
    1683:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1686:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1689:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1690:	e9 8d 00 00 00       	jmp    1722 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1695:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1698:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    169f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a2:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ac:	8b 40 18             	mov    0x18(%eax),%eax
    16af:	89 c2                	mov    %eax,%edx
    16b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b4:	8b 40 1c             	mov    0x1c(%eax),%eax
    16b7:	0f af d0             	imul   %eax,%edx
    16ba:	89 d0                	mov    %edx,%eax
    16bc:	01 c0                	add    %eax,%eax
    16be:	01 d0                	add    %edx,%eax
    16c0:	83 ec 0c             	sub    $0xc,%esp
    16c3:	50                   	push   %eax
    16c4:	e8 0f f1 ff ff       	call   7d8 <malloc>
    16c9:	83 c4 10             	add    $0x10,%esp
    16cc:	89 c2                	mov    %eax,%edx
    16ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d1:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    16d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d7:	8b 40 30             	mov    0x30(%eax),%eax
    16da:	85 c0                	test   %eax,%eax
    16dc:	75 15                	jne    16f3 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16de:	83 ec 04             	sub    $0x4,%esp
    16e1:	ff 75 08             	pushl  0x8(%ebp)
    16e4:	68 28 20 00 00       	push   $0x2028
    16e9:	6a 01                	push   $0x1
    16eb:	e8 15 ee ff ff       	call   505 <printf>
    16f0:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f6:	8b 40 18             	mov    0x18(%eax),%eax
    16f9:	89 c2                	mov    %eax,%edx
    16fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fe:	8b 40 1c             	mov    0x1c(%eax),%eax
    1701:	0f af d0             	imul   %eax,%edx
    1704:	89 d0                	mov    %edx,%eax
    1706:	01 c0                	add    %eax,%eax
    1708:	01 c2                	add    %eax,%edx
    170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170d:	8b 40 30             	mov    0x30(%eax),%eax
    1710:	83 ec 04             	sub    $0x4,%esp
    1713:	52                   	push   %edx
    1714:	68 ff ff ff 00       	push   $0xffffff
    1719:	50                   	push   %eax
    171a:	e8 ac ea ff ff       	call   1cb <memset>
    171f:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1722:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1725:	c9                   	leave  
    1726:	c3                   	ret    

00001727 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1727:	55                   	push   %ebp
    1728:	89 e5                	mov    %esp,%ebp
    172a:	53                   	push   %ebx
    172b:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    172e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1731:	83 f8 03             	cmp    $0x3,%eax
    1734:	74 02                	je     1738 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1736:	eb 33                	jmp    176b <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1738:	8b 45 08             	mov    0x8(%ebp),%eax
    173b:	8b 48 08             	mov    0x8(%eax),%ecx
    173e:	8b 45 08             	mov    0x8(%ebp),%eax
    1741:	8b 50 38             	mov    0x38(%eax),%edx
    1744:	8b 45 08             	mov    0x8(%ebp),%eax
    1747:	8b 40 34             	mov    0x34(%eax),%eax
    174a:	8b 5d 08             	mov    0x8(%ebp),%ebx
    174d:	83 c3 34             	add    $0x34,%ebx
    1750:	83 ec 0c             	sub    $0xc,%esp
    1753:	51                   	push   %ecx
    1754:	52                   	push   %edx
    1755:	50                   	push   %eax
    1756:	6a 00                	push   $0x0
    1758:	6a 00                	push   $0x0
    175a:	53                   	push   %ebx
    175b:	6a 32                	push   $0x32
    175d:	6a 00                	push   $0x0
    175f:	ff 75 08             	pushl  0x8(%ebp)
    1762:	e8 9f ec ff ff       	call   406 <paintWindow>
    1767:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    176a:	90                   	nop
        default: break;
            
            
    }
    return False;
    176b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1770:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1773:	c9                   	leave  
    1774:	c3                   	ret    

00001775 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1775:	55                   	push   %ebp
    1776:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1778:	8b 45 0c             	mov    0xc(%ebp),%eax
    177b:	8b 50 08             	mov    0x8(%eax),%edx
    177e:	8b 45 08             	mov    0x8(%ebp),%eax
    1781:	8b 00                	mov    (%eax),%eax
    1783:	39 c2                	cmp    %eax,%edx
    1785:	74 07                	je     178e <APPreJudge+0x19>
        return False;
    1787:	b8 00 00 00 00       	mov    $0x0,%eax
    178c:	eb 05                	jmp    1793 <APPreJudge+0x1e>
    return True;
    178e:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1793:	5d                   	pop    %ebp
    1794:	c3                   	ret    

00001795 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1795:	55                   	push   %ebp
    1796:	89 e5                	mov    %esp,%ebp
    1798:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    179b:	8b 45 08             	mov    0x8(%ebp),%eax
    179e:	8b 55 0c             	mov    0xc(%ebp),%edx
    17a1:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    17a4:	83 ec 0c             	sub    $0xc,%esp
    17a7:	ff 75 08             	pushl  0x8(%ebp)
    17aa:	e8 77 ec ff ff       	call   426 <registWindow>
    17af:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17b2:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17b9:	8b 45 08             	mov    0x8(%ebp),%eax
    17bc:	8b 00                	mov    (%eax),%eax
    17be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17c1:	ff 75 f4             	pushl  -0xc(%ebp)
    17c4:	ff 75 f0             	pushl  -0x10(%ebp)
    17c7:	ff 75 ec             	pushl  -0x14(%ebp)
    17ca:	ff 75 08             	pushl  0x8(%ebp)
    17cd:	e8 e7 fc ff ff       	call   14b9 <APSendMessage>
    17d2:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    17d5:	83 ec 0c             	sub    $0xc,%esp
    17d8:	ff 75 08             	pushl  0x8(%ebp)
    17db:	e8 3e ec ff ff       	call   41e <getMessage>
    17e0:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    17e3:	8b 45 08             	mov    0x8(%ebp),%eax
    17e6:	83 c0 6c             	add    $0x6c,%eax
    17e9:	83 ec 08             	sub    $0x8,%esp
    17ec:	50                   	push   %eax
    17ed:	ff 75 08             	pushl  0x8(%ebp)
    17f0:	e8 80 ff ff ff       	call   1775 <APPreJudge>
    17f5:	83 c4 10             	add    $0x10,%esp
    17f8:	84 c0                	test   %al,%al
    17fa:	74 1b                	je     1817 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    17fc:	8b 45 08             	mov    0x8(%ebp),%eax
    17ff:	ff 70 74             	pushl  0x74(%eax)
    1802:	ff 70 70             	pushl  0x70(%eax)
    1805:	ff 70 6c             	pushl  0x6c(%eax)
    1808:	ff 75 08             	pushl  0x8(%ebp)
    180b:	8b 45 0c             	mov    0xc(%ebp),%eax
    180e:	ff d0                	call   *%eax
    1810:	83 c4 10             	add    $0x10,%esp
    1813:	84 c0                	test   %al,%al
    1815:	75 0c                	jne    1823 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1817:	8b 45 08             	mov    0x8(%ebp),%eax
    181a:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1821:	eb b2                	jmp    17d5 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1823:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1824:	90                   	nop
    1825:	c9                   	leave  
    1826:	c3                   	ret    

00001827 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1827:	55                   	push   %ebp
    1828:	89 e5                	mov    %esp,%ebp
    182a:	57                   	push   %edi
    182b:	56                   	push   %esi
    182c:	53                   	push   %ebx
    182d:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1830:	a1 4c 26 00 00       	mov    0x264c,%eax
    1835:	85 c0                	test   %eax,%eax
    1837:	75 7c                	jne    18b5 <APGridPaint+0x8e>
    {
        iconReady = 1;
    1839:	c7 05 4c 26 00 00 01 	movl   $0x1,0x264c
    1840:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1843:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1846:	83 ec 08             	sub    $0x8,%esp
    1849:	68 4f 20 00 00       	push   $0x204f
    184e:	50                   	push   %eax
    184f:	e8 37 f1 ff ff       	call   98b <APLoadBitmap>
    1854:	83 c4 0c             	add    $0xc,%esp
    1857:	8b 45 b8             	mov    -0x48(%ebp),%eax
    185a:	a3 60 28 00 00       	mov    %eax,0x2860
    185f:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1862:	a3 64 28 00 00       	mov    %eax,0x2864
    1867:	8b 45 c0             	mov    -0x40(%ebp),%eax
    186a:	a3 68 28 00 00       	mov    %eax,0x2868
        printf(1,"bitmap loaded!\n");
    186f:	83 ec 08             	sub    $0x8,%esp
    1872:	68 59 20 00 00       	push   $0x2059
    1877:	6a 01                	push   $0x1
    1879:	e8 87 ec ff ff       	call   505 <printf>
    187e:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1881:	83 ec 04             	sub    $0x4,%esp
    1884:	ff 35 68 28 00 00    	pushl  0x2868
    188a:	ff 35 64 28 00 00    	pushl  0x2864
    1890:	ff 35 60 28 00 00    	pushl  0x2860
    1896:	e8 7a f3 ff ff       	call   c15 <APCreateCompatibleDCFromBitmap>
    189b:	83 c4 10             	add    $0x10,%esp
    189e:	a3 6c 28 00 00       	mov    %eax,0x286c
        printf(1,"bitmap DC created!\n");
    18a3:	83 ec 08             	sub    $0x8,%esp
    18a6:	68 69 20 00 00       	push   $0x2069
    18ab:	6a 01                	push   $0x1
    18ad:	e8 53 ec ff ff       	call   505 <printf>
    18b2:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    18b5:	8b 45 08             	mov    0x8(%ebp),%eax
    18b8:	8b 40 08             	mov    0x8(%eax),%eax
    18bb:	85 c0                	test   %eax,%eax
    18bd:	75 17                	jne    18d6 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    18bf:	83 ec 08             	sub    $0x8,%esp
    18c2:	68 80 20 00 00       	push   $0x2080
    18c7:	6a 01                	push   $0x1
    18c9:	e8 37 ec ff ff       	call   505 <printf>
    18ce:	83 c4 10             	add    $0x10,%esp
        return;
    18d1:	e9 55 03 00 00       	jmp    1c2b <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    18d6:	8b 45 08             	mov    0x8(%ebp),%eax
    18d9:	8b 40 10             	mov    0x10(%eax),%eax
    18dc:	85 c0                	test   %eax,%eax
    18de:	7e 10                	jle    18f0 <APGridPaint+0xc9>
    18e0:	8b 45 08             	mov    0x8(%ebp),%eax
    18e3:	8b 50 14             	mov    0x14(%eax),%edx
    18e6:	8b 45 08             	mov    0x8(%ebp),%eax
    18e9:	8b 40 10             	mov    0x10(%eax),%eax
    18ec:	39 c2                	cmp    %eax,%edx
    18ee:	7c 17                	jl     1907 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    18f0:	83 ec 08             	sub    $0x8,%esp
    18f3:	68 a6 20 00 00       	push   $0x20a6
    18f8:	6a 01                	push   $0x1
    18fa:	e8 06 ec ff ff       	call   505 <printf>
    18ff:	83 c4 10             	add    $0x10,%esp
        return;
    1902:	e9 24 03 00 00       	jmp    1c2b <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1907:	8b 45 08             	mov    0x8(%ebp),%eax
    190a:	8b 40 14             	mov    0x14(%eax),%eax
    190d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1913:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1916:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1919:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    191c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1923:	e9 f9 02 00 00       	jmp    1c21 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1928:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    192f:	e9 df 02 00 00       	jmp    1c13 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1934:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1937:	c1 e0 04             	shl    $0x4,%eax
    193a:	89 c2                	mov    %eax,%edx
    193c:	8b 45 d8             	mov    -0x28(%ebp),%eax
    193f:	01 c2                	add    %eax,%edx
    1941:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1944:	01 d0                	add    %edx,%eax
    1946:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1949:	8b 45 08             	mov    0x8(%ebp),%eax
    194c:	8b 40 0c             	mov    0xc(%eax),%eax
    194f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1952:	c1 e2 02             	shl    $0x2,%edx
    1955:	01 d0                	add    %edx,%eax
    1957:	8b 00                	mov    (%eax),%eax
    1959:	83 f8 01             	cmp    $0x1,%eax
    195c:	0f 84 83 00 00 00    	je     19e5 <APGridPaint+0x1be>
    1962:	83 f8 01             	cmp    $0x1,%eax
    1965:	7f 09                	jg     1970 <APGridPaint+0x149>
    1967:	85 c0                	test   %eax,%eax
    1969:	74 1c                	je     1987 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    196b:	e9 9f 02 00 00       	jmp    1c0f <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1970:	83 f8 02             	cmp    $0x2,%eax
    1973:	0f 84 20 01 00 00    	je     1a99 <APGridPaint+0x272>
    1979:	83 f8 03             	cmp    $0x3,%eax
    197c:	0f 84 d1 01 00 00    	je     1b53 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1982:	e9 88 02 00 00       	jmp    1c0f <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1987:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    198a:	6a 0c                	push   $0xc
    198c:	6a 0c                	push   $0xc
    198e:	6a 0c                	push   $0xc
    1990:	50                   	push   %eax
    1991:	e8 de fa ff ff       	call   1474 <RGB>
    1996:	83 c4 0c             	add    $0xc,%esp
    1999:	8b 1d 6c 28 00 00    	mov    0x286c,%ebx
    199f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19a2:	6b c8 32             	imul   $0x32,%eax,%ecx
    19a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19a8:	6b c0 32             	imul   $0x32,%eax,%eax
    19ab:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    19ae:	8b 45 08             	mov    0x8(%ebp),%eax
    19b1:	8d 78 34             	lea    0x34(%eax),%edi
    19b4:	83 ec 0c             	sub    $0xc,%esp
    19b7:	83 ec 04             	sub    $0x4,%esp
    19ba:	89 e0                	mov    %esp,%eax
    19bc:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    19c0:	66 89 30             	mov    %si,(%eax)
    19c3:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    19c7:	88 50 02             	mov    %dl,0x2(%eax)
    19ca:	6a 32                	push   $0x32
    19cc:	6a 32                	push   $0x32
    19ce:	6a 00                	push   $0x0
    19d0:	6a 00                	push   $0x0
    19d2:	53                   	push   %ebx
    19d3:	51                   	push   %ecx
    19d4:	ff 75 b4             	pushl  -0x4c(%ebp)
    19d7:	57                   	push   %edi
    19d8:	e8 f3 f8 ff ff       	call   12d0 <APDcCopy>
    19dd:	83 c4 30             	add    $0x30,%esp
                    break;
    19e0:	e9 2a 02 00 00       	jmp    1c0f <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    19e5:	8d 45 b8             	lea    -0x48(%ebp),%eax
    19e8:	6a 69                	push   $0x69
    19ea:	6a 69                	push   $0x69
    19ec:	6a 69                	push   $0x69
    19ee:	50                   	push   %eax
    19ef:	e8 80 fa ff ff       	call   1474 <RGB>
    19f4:	83 c4 0c             	add    $0xc,%esp
    19f7:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    19fb:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    19ff:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a03:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1a06:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1a0d:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a10:	6a 69                	push   $0x69
    1a12:	6a 69                	push   $0x69
    1a14:	6a 69                	push   $0x69
    1a16:	50                   	push   %eax
    1a17:	e8 58 fa ff ff       	call   1474 <RGB>
    1a1c:	83 c4 0c             	add    $0xc,%esp
    1a1f:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a23:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1a27:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a2b:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a31:	8d 50 34             	lea    0x34(%eax),%edx
    1a34:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a37:	ff 75 d0             	pushl  -0x30(%ebp)
    1a3a:	ff 75 cc             	pushl  -0x34(%ebp)
    1a3d:	52                   	push   %edx
    1a3e:	50                   	push   %eax
    1a3f:	e8 66 f2 ff ff       	call   caa <APSetPen>
    1a44:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	8d 58 34             	lea    0x34(%eax),%ebx
    1a4d:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a50:	83 ec 04             	sub    $0x4,%esp
    1a53:	83 ec 04             	sub    $0x4,%esp
    1a56:	89 e0                	mov    %esp,%eax
    1a58:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a5c:	66 89 08             	mov    %cx,(%eax)
    1a5f:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1a63:	88 48 02             	mov    %cl,0x2(%eax)
    1a66:	53                   	push   %ebx
    1a67:	52                   	push   %edx
    1a68:	e8 76 f2 ff ff       	call   ce3 <APSetBrush>
    1a6d:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1a70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a73:	6b d0 32             	imul   $0x32,%eax,%edx
    1a76:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a79:	6b c0 32             	imul   $0x32,%eax,%eax
    1a7c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a7f:	83 c1 34             	add    $0x34,%ecx
    1a82:	83 ec 0c             	sub    $0xc,%esp
    1a85:	6a 32                	push   $0x32
    1a87:	6a 32                	push   $0x32
    1a89:	52                   	push   %edx
    1a8a:	50                   	push   %eax
    1a8b:	51                   	push   %ecx
    1a8c:	e8 3a f6 ff ff       	call   10cb <APDrawRect>
    1a91:	83 c4 20             	add    $0x20,%esp
                    break;
    1a94:	e9 76 01 00 00       	jmp    1c0f <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1a99:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a9c:	6a 00                	push   $0x0
    1a9e:	68 80 00 00 00       	push   $0x80
    1aa3:	6a 00                	push   $0x0
    1aa5:	50                   	push   %eax
    1aa6:	e8 c9 f9 ff ff       	call   1474 <RGB>
    1aab:	83 c4 0c             	add    $0xc,%esp
    1aae:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1ab2:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1ab6:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1aba:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1abd:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1ac4:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ac7:	6a 00                	push   $0x0
    1ac9:	68 80 00 00 00       	push   $0x80
    1ace:	6a 00                	push   $0x0
    1ad0:	50                   	push   %eax
    1ad1:	e8 9e f9 ff ff       	call   1474 <RGB>
    1ad6:	83 c4 0c             	add    $0xc,%esp
    1ad9:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1add:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1ae1:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ae5:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ae8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aeb:	8d 50 34             	lea    0x34(%eax),%edx
    1aee:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1af1:	ff 75 d0             	pushl  -0x30(%ebp)
    1af4:	ff 75 cc             	pushl  -0x34(%ebp)
    1af7:	52                   	push   %edx
    1af8:	50                   	push   %eax
    1af9:	e8 ac f1 ff ff       	call   caa <APSetPen>
    1afe:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b01:	8b 45 08             	mov    0x8(%ebp),%eax
    1b04:	8d 58 34             	lea    0x34(%eax),%ebx
    1b07:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1b0a:	83 ec 04             	sub    $0x4,%esp
    1b0d:	83 ec 04             	sub    $0x4,%esp
    1b10:	89 e0                	mov    %esp,%eax
    1b12:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b16:	66 89 08             	mov    %cx,(%eax)
    1b19:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b1d:	88 48 02             	mov    %cl,0x2(%eax)
    1b20:	53                   	push   %ebx
    1b21:	52                   	push   %edx
    1b22:	e8 bc f1 ff ff       	call   ce3 <APSetBrush>
    1b27:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b2d:	6b d0 32             	imul   $0x32,%eax,%edx
    1b30:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b33:	6b c0 32             	imul   $0x32,%eax,%eax
    1b36:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b39:	83 c1 34             	add    $0x34,%ecx
    1b3c:	83 ec 0c             	sub    $0xc,%esp
    1b3f:	6a 32                	push   $0x32
    1b41:	6a 32                	push   $0x32
    1b43:	52                   	push   %edx
    1b44:	50                   	push   %eax
    1b45:	51                   	push   %ecx
    1b46:	e8 80 f5 ff ff       	call   10cb <APDrawRect>
    1b4b:	83 c4 20             	add    $0x20,%esp
                    break;
    1b4e:	e9 bc 00 00 00       	jmp    1c0f <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1b53:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b56:	68 ff 00 00 00       	push   $0xff
    1b5b:	68 bf 00 00 00       	push   $0xbf
    1b60:	6a 00                	push   $0x0
    1b62:	50                   	push   %eax
    1b63:	e8 0c f9 ff ff       	call   1474 <RGB>
    1b68:	83 c4 0c             	add    $0xc,%esp
    1b6b:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b6f:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1b73:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b77:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1b7a:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1b81:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b84:	68 ff 00 00 00       	push   $0xff
    1b89:	68 bf 00 00 00       	push   $0xbf
    1b8e:	6a 00                	push   $0x0
    1b90:	50                   	push   %eax
    1b91:	e8 de f8 ff ff       	call   1474 <RGB>
    1b96:	83 c4 0c             	add    $0xc,%esp
    1b99:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b9d:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1ba1:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ba5:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ba8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bab:	8d 50 34             	lea    0x34(%eax),%edx
    1bae:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1bb1:	ff 75 d0             	pushl  -0x30(%ebp)
    1bb4:	ff 75 cc             	pushl  -0x34(%ebp)
    1bb7:	52                   	push   %edx
    1bb8:	50                   	push   %eax
    1bb9:	e8 ec f0 ff ff       	call   caa <APSetPen>
    1bbe:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1bc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc4:	8d 58 34             	lea    0x34(%eax),%ebx
    1bc7:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1bca:	83 ec 04             	sub    $0x4,%esp
    1bcd:	83 ec 04             	sub    $0x4,%esp
    1bd0:	89 e0                	mov    %esp,%eax
    1bd2:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1bd6:	66 89 08             	mov    %cx,(%eax)
    1bd9:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1bdd:	88 48 02             	mov    %cl,0x2(%eax)
    1be0:	53                   	push   %ebx
    1be1:	52                   	push   %edx
    1be2:	e8 fc f0 ff ff       	call   ce3 <APSetBrush>
    1be7:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1bea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bed:	6b d0 32             	imul   $0x32,%eax,%edx
    1bf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bf3:	6b c0 32             	imul   $0x32,%eax,%eax
    1bf6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bf9:	83 c1 34             	add    $0x34,%ecx
    1bfc:	83 ec 0c             	sub    $0xc,%esp
    1bff:	6a 32                	push   $0x32
    1c01:	6a 32                	push   $0x32
    1c03:	52                   	push   %edx
    1c04:	50                   	push   %eax
    1c05:	51                   	push   %ecx
    1c06:	e8 c0 f4 ff ff       	call   10cb <APDrawRect>
    1c0b:	83 c4 20             	add    $0x20,%esp
                    break;
    1c0e:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c0f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1c13:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1c17:	0f 8e 17 fd ff ff    	jle    1934 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c1d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1c21:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1c25:	0f 8e fd fc ff ff    	jle    1928 <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1c2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c2e:	5b                   	pop    %ebx
    1c2f:	5e                   	pop    %esi
    1c30:	5f                   	pop    %edi
    1c31:	5d                   	pop    %ebp
    1c32:	c3                   	ret    

00001c33 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1c33:	55                   	push   %ebp
    1c34:	89 e5                	mov    %esp,%ebp
    1c36:	53                   	push   %ebx
    1c37:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1c3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1c41:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1c45:	74 17                	je     1c5e <sprintint+0x2b>
    1c47:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1c4b:	79 11                	jns    1c5e <sprintint+0x2b>
        neg = 1;
    1c4d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1c54:	8b 45 10             	mov    0x10(%ebp),%eax
    1c57:	f7 d8                	neg    %eax
    1c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c5c:	eb 06                	jmp    1c64 <sprintint+0x31>
    } else {
        x = xx;
    1c5e:	8b 45 10             	mov    0x10(%ebp),%eax
    1c61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1c64:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1c6b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1c6e:	8d 41 01             	lea    0x1(%ecx),%eax
    1c71:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1c74:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1c77:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c7a:	ba 00 00 00 00       	mov    $0x0,%edx
    1c7f:	f7 f3                	div    %ebx
    1c81:	89 d0                	mov    %edx,%eax
    1c83:	0f b6 80 14 26 00 00 	movzbl 0x2614(%eax),%eax
    1c8a:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1c8e:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1c91:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c94:	ba 00 00 00 00       	mov    $0x0,%edx
    1c99:	f7 f3                	div    %ebx
    1c9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ca2:	75 c7                	jne    1c6b <sprintint+0x38>
    if(neg)
    1ca4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ca8:	74 0e                	je     1cb8 <sprintint+0x85>
        buf[i++] = '-';
    1caa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cad:	8d 50 01             	lea    0x1(%eax),%edx
    1cb0:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1cb3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1cb8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cbb:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1cbe:	eb 1b                	jmp    1cdb <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1cc0:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cc3:	8b 00                	mov    (%eax),%eax
    1cc5:	8d 48 01             	lea    0x1(%eax),%ecx
    1cc8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ccb:	89 0a                	mov    %ecx,(%edx)
    1ccd:	89 c2                	mov    %eax,%edx
    1ccf:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd2:	01 d0                	add    %edx,%eax
    1cd4:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1cd7:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1cdb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1cdf:	7f df                	jg     1cc0 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1ce1:	eb 21                	jmp    1d04 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ce6:	8b 00                	mov    (%eax),%eax
    1ce8:	8d 48 01             	lea    0x1(%eax),%ecx
    1ceb:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cee:	89 0a                	mov    %ecx,(%edx)
    1cf0:	89 c2                	mov    %eax,%edx
    1cf2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf5:	01 c2                	add    %eax,%edx
    1cf7:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1cfa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cfd:	01 c8                	add    %ecx,%eax
    1cff:	0f b6 00             	movzbl (%eax),%eax
    1d02:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1d04:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1d08:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1d0c:	79 d5                	jns    1ce3 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1d0e:	90                   	nop
    1d0f:	83 c4 20             	add    $0x20,%esp
    1d12:	5b                   	pop    %ebx
    1d13:	5d                   	pop    %ebp
    1d14:	c3                   	ret    

00001d15 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1d15:	55                   	push   %ebp
    1d16:	89 e5                	mov    %esp,%ebp
    1d18:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1d1b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1d22:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1d29:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1d30:	8d 45 0c             	lea    0xc(%ebp),%eax
    1d33:	83 c0 04             	add    $0x4,%eax
    1d36:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1d39:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1d40:	e9 d9 01 00 00       	jmp    1f1e <sprintf+0x209>
        c = fmt[i] & 0xff;
    1d45:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d48:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d4b:	01 d0                	add    %edx,%eax
    1d4d:	0f b6 00             	movzbl (%eax),%eax
    1d50:	0f be c0             	movsbl %al,%eax
    1d53:	25 ff 00 00 00       	and    $0xff,%eax
    1d58:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1d5b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1d5f:	75 2c                	jne    1d8d <sprintf+0x78>
            if(c == '%'){
    1d61:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1d65:	75 0c                	jne    1d73 <sprintf+0x5e>
                state = '%';
    1d67:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1d6e:	e9 a7 01 00 00       	jmp    1f1a <sprintf+0x205>
            } else {
                dst[j++] = c;
    1d73:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1d76:	8d 50 01             	lea    0x1(%eax),%edx
    1d79:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1d7c:	89 c2                	mov    %eax,%edx
    1d7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d81:	01 d0                	add    %edx,%eax
    1d83:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1d86:	88 10                	mov    %dl,(%eax)
    1d88:	e9 8d 01 00 00       	jmp    1f1a <sprintf+0x205>
            }
        } else if(state == '%'){
    1d8d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1d91:	0f 85 83 01 00 00    	jne    1f1a <sprintf+0x205>
            if(c == 'd'){
    1d97:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1d9b:	75 4c                	jne    1de9 <sprintf+0xd4>
                buf[bi] = '\0';
    1d9d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1da0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1da3:	01 d0                	add    %edx,%eax
    1da5:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1da8:	83 ec 0c             	sub    $0xc,%esp
    1dab:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1dae:	50                   	push   %eax
    1daf:	e8 20 e5 ff ff       	call   2d4 <atoi>
    1db4:	83 c4 10             	add    $0x10,%esp
    1db7:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1dba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1dc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dc4:	8b 00                	mov    (%eax),%eax
    1dc6:	83 ec 08             	sub    $0x8,%esp
    1dc9:	ff 75 d8             	pushl  -0x28(%ebp)
    1dcc:	6a 01                	push   $0x1
    1dce:	6a 0a                	push   $0xa
    1dd0:	50                   	push   %eax
    1dd1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1dd4:	50                   	push   %eax
    1dd5:	ff 75 08             	pushl  0x8(%ebp)
    1dd8:	e8 56 fe ff ff       	call   1c33 <sprintint>
    1ddd:	83 c4 20             	add    $0x20,%esp
                ap++;
    1de0:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1de4:	e9 2a 01 00 00       	jmp    1f13 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1de9:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1ded:	74 06                	je     1df5 <sprintf+0xe0>
    1def:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1df3:	75 4c                	jne    1e41 <sprintf+0x12c>
                buf[bi] = '\0';
    1df5:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1df8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dfb:	01 d0                	add    %edx,%eax
    1dfd:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1e00:	83 ec 0c             	sub    $0xc,%esp
    1e03:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1e06:	50                   	push   %eax
    1e07:	e8 c8 e4 ff ff       	call   2d4 <atoi>
    1e0c:	83 c4 10             	add    $0x10,%esp
    1e0f:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1e12:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1e19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e1c:	8b 00                	mov    (%eax),%eax
    1e1e:	83 ec 08             	sub    $0x8,%esp
    1e21:	ff 75 dc             	pushl  -0x24(%ebp)
    1e24:	6a 00                	push   $0x0
    1e26:	6a 10                	push   $0x10
    1e28:	50                   	push   %eax
    1e29:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1e2c:	50                   	push   %eax
    1e2d:	ff 75 08             	pushl  0x8(%ebp)
    1e30:	e8 fe fd ff ff       	call   1c33 <sprintint>
    1e35:	83 c4 20             	add    $0x20,%esp
                ap++;
    1e38:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1e3c:	e9 d2 00 00 00       	jmp    1f13 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1e41:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1e45:	75 46                	jne    1e8d <sprintf+0x178>
                s = (char*)*ap;
    1e47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e4a:	8b 00                	mov    (%eax),%eax
    1e4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1e4f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1e53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e57:	75 25                	jne    1e7e <sprintf+0x169>
                    s = "(null)";
    1e59:	c7 45 f4 bc 20 00 00 	movl   $0x20bc,-0xc(%ebp)
                while(*s != 0){
    1e60:	eb 1c                	jmp    1e7e <sprintf+0x169>
                    dst[j++] = *s;
    1e62:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e65:	8d 50 01             	lea    0x1(%eax),%edx
    1e68:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e6b:	89 c2                	mov    %eax,%edx
    1e6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e70:	01 c2                	add    %eax,%edx
    1e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e75:	0f b6 00             	movzbl (%eax),%eax
    1e78:	88 02                	mov    %al,(%edx)
                    s++;
    1e7a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e81:	0f b6 00             	movzbl (%eax),%eax
    1e84:	84 c0                	test   %al,%al
    1e86:	75 da                	jne    1e62 <sprintf+0x14d>
    1e88:	e9 86 00 00 00       	jmp    1f13 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1e8d:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1e91:	75 1d                	jne    1eb0 <sprintf+0x19b>
                dst[j++] = *ap;
    1e93:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1e96:	8d 50 01             	lea    0x1(%eax),%edx
    1e99:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1e9c:	89 c2                	mov    %eax,%edx
    1e9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea1:	01 c2                	add    %eax,%edx
    1ea3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ea6:	8b 00                	mov    (%eax),%eax
    1ea8:	88 02                	mov    %al,(%edx)
                ap++;
    1eaa:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1eae:	eb 63                	jmp    1f13 <sprintf+0x1fe>
            } else if(c == '%'){
    1eb0:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1eb4:	75 17                	jne    1ecd <sprintf+0x1b8>
                dst[j++] = c;
    1eb6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1eb9:	8d 50 01             	lea    0x1(%eax),%edx
    1ebc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ebf:	89 c2                	mov    %eax,%edx
    1ec1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec4:	01 d0                	add    %edx,%eax
    1ec6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ec9:	88 10                	mov    %dl,(%eax)
    1ecb:	eb 46                	jmp    1f13 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1ecd:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1ed1:	7e 18                	jle    1eeb <sprintf+0x1d6>
    1ed3:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1ed7:	7f 12                	jg     1eeb <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1ed9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1edc:	8d 50 01             	lea    0x1(%eax),%edx
    1edf:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1ee2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1ee5:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1ee9:	eb 2f                	jmp    1f1a <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1eeb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1eee:	8d 50 01             	lea    0x1(%eax),%edx
    1ef1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1ef4:	89 c2                	mov    %eax,%edx
    1ef6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef9:	01 d0                	add    %edx,%eax
    1efb:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1efe:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f01:	8d 50 01             	lea    0x1(%eax),%edx
    1f04:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f07:	89 c2                	mov    %eax,%edx
    1f09:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0c:	01 d0                	add    %edx,%eax
    1f0e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f11:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1f13:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1f1a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1f1e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f21:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f24:	01 d0                	add    %edx,%eax
    1f26:	0f b6 00             	movzbl (%eax),%eax
    1f29:	84 c0                	test   %al,%al
    1f2b:	0f 85 14 fe ff ff    	jne    1d45 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1f31:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f34:	8d 50 01             	lea    0x1(%eax),%edx
    1f37:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f3a:	89 c2                	mov    %eax,%edx
    1f3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f3f:	01 d0                	add    %edx,%eax
    1f41:	c6 00 00             	movb   $0x0,(%eax)
}
    1f44:	90                   	nop
    1f45:	c9                   	leave  
    1f46:	c3                   	ret    
