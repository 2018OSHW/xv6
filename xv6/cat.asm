
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
       e:	68 c0 69 00 00       	push   $0x69c0
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
      25:	68 c0 69 00 00       	push   $0x69c0
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
      47:	68 ac 25 00 00       	push   $0x25ac
      4c:	6a 01                	push   $0x1
      4e:	e8 d2 04 00 00       	call   525 <printf>
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
      cf:	68 bd 25 00 00       	push   $0x25bd
      d4:	6a 01                	push   $0x1
      d6:	e8 4a 04 00 00       	call   525 <printf>
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

0000042e <setupTimer>:
SYSCALL(setupTimer)
     42e:	b8 1b 00 00 00       	mov    $0x1b,%eax
     433:	cd 40                	int    $0x40
     435:	c3                   	ret    

00000436 <deleteTimer>:
SYSCALL(deleteTimer)
     436:	b8 1c 00 00 00       	mov    $0x1c,%eax
     43b:	cd 40                	int    $0x40
     43d:	c3                   	ret    

0000043e <getCurrentTime>:
SYSCALL(getCurrentTime)
     43e:	b8 1d 00 00 00       	mov    $0x1d,%eax
     443:	cd 40                	int    $0x40
     445:	c3                   	ret    

00000446 <removeWindow>:
SYSCALL(removeWindow)
     446:	b8 1e 00 00 00       	mov    $0x1e,%eax
     44b:	cd 40                	int    $0x40
     44d:	c3                   	ret    

0000044e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     44e:	55                   	push   %ebp
     44f:	89 e5                	mov    %esp,%ebp
     451:	83 ec 18             	sub    $0x18,%esp
     454:	8b 45 0c             	mov    0xc(%ebp),%eax
     457:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     45a:	83 ec 04             	sub    $0x4,%esp
     45d:	6a 01                	push   $0x1
     45f:	8d 45 f4             	lea    -0xc(%ebp),%eax
     462:	50                   	push   %eax
     463:	ff 75 08             	pushl  0x8(%ebp)
     466:	e8 1b ff ff ff       	call   386 <write>
     46b:	83 c4 10             	add    $0x10,%esp
}
     46e:	90                   	nop
     46f:	c9                   	leave  
     470:	c3                   	ret    

00000471 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     471:	55                   	push   %ebp
     472:	89 e5                	mov    %esp,%ebp
     474:	53                   	push   %ebx
     475:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     478:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     47f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     483:	74 17                	je     49c <printint+0x2b>
     485:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     489:	79 11                	jns    49c <printint+0x2b>
    neg = 1;
     48b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     492:	8b 45 0c             	mov    0xc(%ebp),%eax
     495:	f7 d8                	neg    %eax
     497:	89 45 ec             	mov    %eax,-0x14(%ebp)
     49a:	eb 06                	jmp    4a2 <printint+0x31>
  } else {
    x = xx;
     49c:	8b 45 0c             	mov    0xc(%ebp),%eax
     49f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4a9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4ac:	8d 41 01             	lea    0x1(%ecx),%eax
     4af:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4b2:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4b8:	ba 00 00 00 00       	mov    $0x0,%edx
     4bd:	f7 f3                	div    %ebx
     4bf:	89 d0                	mov    %edx,%eax
     4c1:	0f b6 80 40 2d 00 00 	movzbl 0x2d40(%eax),%eax
     4c8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4d2:	ba 00 00 00 00       	mov    $0x0,%edx
     4d7:	f7 f3                	div    %ebx
     4d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4e0:	75 c7                	jne    4a9 <printint+0x38>
  if(neg)
     4e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4e6:	74 2d                	je     515 <printint+0xa4>
    buf[i++] = '-';
     4e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4eb:	8d 50 01             	lea    0x1(%eax),%edx
     4ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4f1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4f6:	eb 1d                	jmp    515 <printint+0xa4>
    putc(fd, buf[i]);
     4f8:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fe:	01 d0                	add    %edx,%eax
     500:	0f b6 00             	movzbl (%eax),%eax
     503:	0f be c0             	movsbl %al,%eax
     506:	83 ec 08             	sub    $0x8,%esp
     509:	50                   	push   %eax
     50a:	ff 75 08             	pushl  0x8(%ebp)
     50d:	e8 3c ff ff ff       	call   44e <putc>
     512:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     515:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     519:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     51d:	79 d9                	jns    4f8 <printint+0x87>
    putc(fd, buf[i]);
}
     51f:	90                   	nop
     520:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     523:	c9                   	leave  
     524:	c3                   	ret    

00000525 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     525:	55                   	push   %ebp
     526:	89 e5                	mov    %esp,%ebp
     528:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     52b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     532:	8d 45 0c             	lea    0xc(%ebp),%eax
     535:	83 c0 04             	add    $0x4,%eax
     538:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     53b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     542:	e9 59 01 00 00       	jmp    6a0 <printf+0x17b>
    c = fmt[i] & 0xff;
     547:	8b 55 0c             	mov    0xc(%ebp),%edx
     54a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     54d:	01 d0                	add    %edx,%eax
     54f:	0f b6 00             	movzbl (%eax),%eax
     552:	0f be c0             	movsbl %al,%eax
     555:	25 ff 00 00 00       	and    $0xff,%eax
     55a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     55d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     561:	75 2c                	jne    58f <printf+0x6a>
      if(c == '%'){
     563:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     567:	75 0c                	jne    575 <printf+0x50>
        state = '%';
     569:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     570:	e9 27 01 00 00       	jmp    69c <printf+0x177>
      } else {
        putc(fd, c);
     575:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     578:	0f be c0             	movsbl %al,%eax
     57b:	83 ec 08             	sub    $0x8,%esp
     57e:	50                   	push   %eax
     57f:	ff 75 08             	pushl  0x8(%ebp)
     582:	e8 c7 fe ff ff       	call   44e <putc>
     587:	83 c4 10             	add    $0x10,%esp
     58a:	e9 0d 01 00 00       	jmp    69c <printf+0x177>
      }
    } else if(state == '%'){
     58f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     593:	0f 85 03 01 00 00    	jne    69c <printf+0x177>
      if(c == 'd'){
     599:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     59d:	75 1e                	jne    5bd <printf+0x98>
        printint(fd, *ap, 10, 1);
     59f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a2:	8b 00                	mov    (%eax),%eax
     5a4:	6a 01                	push   $0x1
     5a6:	6a 0a                	push   $0xa
     5a8:	50                   	push   %eax
     5a9:	ff 75 08             	pushl  0x8(%ebp)
     5ac:	e8 c0 fe ff ff       	call   471 <printint>
     5b1:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5b8:	e9 d8 00 00 00       	jmp    695 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5bd:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5c1:	74 06                	je     5c9 <printf+0xa4>
     5c3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5c7:	75 1e                	jne    5e7 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5cc:	8b 00                	mov    (%eax),%eax
     5ce:	6a 00                	push   $0x0
     5d0:	6a 10                	push   $0x10
     5d2:	50                   	push   %eax
     5d3:	ff 75 08             	pushl  0x8(%ebp)
     5d6:	e8 96 fe ff ff       	call   471 <printint>
     5db:	83 c4 10             	add    $0x10,%esp
        ap++;
     5de:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5e2:	e9 ae 00 00 00       	jmp    695 <printf+0x170>
      } else if(c == 's'){
     5e7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5eb:	75 43                	jne    630 <printf+0x10b>
        s = (char*)*ap;
     5ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5f0:	8b 00                	mov    (%eax),%eax
     5f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5fd:	75 25                	jne    624 <printf+0xff>
          s = "(null)";
     5ff:	c7 45 f4 d2 25 00 00 	movl   $0x25d2,-0xc(%ebp)
        while(*s != 0){
     606:	eb 1c                	jmp    624 <printf+0xff>
          putc(fd, *s);
     608:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60b:	0f b6 00             	movzbl (%eax),%eax
     60e:	0f be c0             	movsbl %al,%eax
     611:	83 ec 08             	sub    $0x8,%esp
     614:	50                   	push   %eax
     615:	ff 75 08             	pushl  0x8(%ebp)
     618:	e8 31 fe ff ff       	call   44e <putc>
     61d:	83 c4 10             	add    $0x10,%esp
          s++;
     620:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     624:	8b 45 f4             	mov    -0xc(%ebp),%eax
     627:	0f b6 00             	movzbl (%eax),%eax
     62a:	84 c0                	test   %al,%al
     62c:	75 da                	jne    608 <printf+0xe3>
     62e:	eb 65                	jmp    695 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     630:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     634:	75 1d                	jne    653 <printf+0x12e>
        putc(fd, *ap);
     636:	8b 45 e8             	mov    -0x18(%ebp),%eax
     639:	8b 00                	mov    (%eax),%eax
     63b:	0f be c0             	movsbl %al,%eax
     63e:	83 ec 08             	sub    $0x8,%esp
     641:	50                   	push   %eax
     642:	ff 75 08             	pushl  0x8(%ebp)
     645:	e8 04 fe ff ff       	call   44e <putc>
     64a:	83 c4 10             	add    $0x10,%esp
        ap++;
     64d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     651:	eb 42                	jmp    695 <printf+0x170>
      } else if(c == '%'){
     653:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     657:	75 17                	jne    670 <printf+0x14b>
        putc(fd, c);
     659:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     65c:	0f be c0             	movsbl %al,%eax
     65f:	83 ec 08             	sub    $0x8,%esp
     662:	50                   	push   %eax
     663:	ff 75 08             	pushl  0x8(%ebp)
     666:	e8 e3 fd ff ff       	call   44e <putc>
     66b:	83 c4 10             	add    $0x10,%esp
     66e:	eb 25                	jmp    695 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     670:	83 ec 08             	sub    $0x8,%esp
     673:	6a 25                	push   $0x25
     675:	ff 75 08             	pushl  0x8(%ebp)
     678:	e8 d1 fd ff ff       	call   44e <putc>
     67d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     680:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     683:	0f be c0             	movsbl %al,%eax
     686:	83 ec 08             	sub    $0x8,%esp
     689:	50                   	push   %eax
     68a:	ff 75 08             	pushl  0x8(%ebp)
     68d:	e8 bc fd ff ff       	call   44e <putc>
     692:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     695:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     69c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6a0:	8b 55 0c             	mov    0xc(%ebp),%edx
     6a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6a6:	01 d0                	add    %edx,%eax
     6a8:	0f b6 00             	movzbl (%eax),%eax
     6ab:	84 c0                	test   %al,%al
     6ad:	0f 85 94 fe ff ff    	jne    547 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6b3:	90                   	nop
     6b4:	c9                   	leave  
     6b5:	c3                   	ret    

000006b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6b6:	55                   	push   %ebp
     6b7:	89 e5                	mov    %esp,%ebp
     6b9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6bc:	8b 45 08             	mov    0x8(%ebp),%eax
     6bf:	83 e8 08             	sub    $0x8,%eax
     6c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6c5:	a1 a8 69 00 00       	mov    0x69a8,%eax
     6ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6cd:	eb 24                	jmp    6f3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d2:	8b 00                	mov    (%eax),%eax
     6d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6d7:	77 12                	ja     6eb <free+0x35>
     6d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6dc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6df:	77 24                	ja     705 <free+0x4f>
     6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e4:	8b 00                	mov    (%eax),%eax
     6e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6e9:	77 1a                	ja     705 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ee:	8b 00                	mov    (%eax),%eax
     6f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6f9:	76 d4                	jbe    6cf <free+0x19>
     6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fe:	8b 00                	mov    (%eax),%eax
     700:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     703:	76 ca                	jbe    6cf <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     705:	8b 45 f8             	mov    -0x8(%ebp),%eax
     708:	8b 40 04             	mov    0x4(%eax),%eax
     70b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     712:	8b 45 f8             	mov    -0x8(%ebp),%eax
     715:	01 c2                	add    %eax,%edx
     717:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71a:	8b 00                	mov    (%eax),%eax
     71c:	39 c2                	cmp    %eax,%edx
     71e:	75 24                	jne    744 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     720:	8b 45 f8             	mov    -0x8(%ebp),%eax
     723:	8b 50 04             	mov    0x4(%eax),%edx
     726:	8b 45 fc             	mov    -0x4(%ebp),%eax
     729:	8b 00                	mov    (%eax),%eax
     72b:	8b 40 04             	mov    0x4(%eax),%eax
     72e:	01 c2                	add    %eax,%edx
     730:	8b 45 f8             	mov    -0x8(%ebp),%eax
     733:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     736:	8b 45 fc             	mov    -0x4(%ebp),%eax
     739:	8b 00                	mov    (%eax),%eax
     73b:	8b 10                	mov    (%eax),%edx
     73d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     740:	89 10                	mov    %edx,(%eax)
     742:	eb 0a                	jmp    74e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     744:	8b 45 fc             	mov    -0x4(%ebp),%eax
     747:	8b 10                	mov    (%eax),%edx
     749:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     74e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     751:	8b 40 04             	mov    0x4(%eax),%eax
     754:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75e:	01 d0                	add    %edx,%eax
     760:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     763:	75 20                	jne    785 <free+0xcf>
    p->s.size += bp->s.size;
     765:	8b 45 fc             	mov    -0x4(%ebp),%eax
     768:	8b 50 04             	mov    0x4(%eax),%edx
     76b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76e:	8b 40 04             	mov    0x4(%eax),%eax
     771:	01 c2                	add    %eax,%edx
     773:	8b 45 fc             	mov    -0x4(%ebp),%eax
     776:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     779:	8b 45 f8             	mov    -0x8(%ebp),%eax
     77c:	8b 10                	mov    (%eax),%edx
     77e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     781:	89 10                	mov    %edx,(%eax)
     783:	eb 08                	jmp    78d <free+0xd7>
  } else
    p->s.ptr = bp;
     785:	8b 45 fc             	mov    -0x4(%ebp),%eax
     788:	8b 55 f8             	mov    -0x8(%ebp),%edx
     78b:	89 10                	mov    %edx,(%eax)
  freep = p;
     78d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     790:	a3 a8 69 00 00       	mov    %eax,0x69a8
}
     795:	90                   	nop
     796:	c9                   	leave  
     797:	c3                   	ret    

00000798 <morecore>:

static Header*
morecore(uint nu)
{
     798:	55                   	push   %ebp
     799:	89 e5                	mov    %esp,%ebp
     79b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     79e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7a5:	77 07                	ja     7ae <morecore+0x16>
    nu = 4096;
     7a7:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7ae:	8b 45 08             	mov    0x8(%ebp),%eax
     7b1:	c1 e0 03             	shl    $0x3,%eax
     7b4:	83 ec 0c             	sub    $0xc,%esp
     7b7:	50                   	push   %eax
     7b8:	e8 31 fc ff ff       	call   3ee <sbrk>
     7bd:	83 c4 10             	add    $0x10,%esp
     7c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7c3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7c7:	75 07                	jne    7d0 <morecore+0x38>
    return 0;
     7c9:	b8 00 00 00 00       	mov    $0x0,%eax
     7ce:	eb 26                	jmp    7f6 <morecore+0x5e>
  hp = (Header*)p;
     7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d9:	8b 55 08             	mov    0x8(%ebp),%edx
     7dc:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7df:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e2:	83 c0 08             	add    $0x8,%eax
     7e5:	83 ec 0c             	sub    $0xc,%esp
     7e8:	50                   	push   %eax
     7e9:	e8 c8 fe ff ff       	call   6b6 <free>
     7ee:	83 c4 10             	add    $0x10,%esp
  return freep;
     7f1:	a1 a8 69 00 00       	mov    0x69a8,%eax
}
     7f6:	c9                   	leave  
     7f7:	c3                   	ret    

000007f8 <malloc>:

void*
malloc(uint nbytes)
{
     7f8:	55                   	push   %ebp
     7f9:	89 e5                	mov    %esp,%ebp
     7fb:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7fe:	8b 45 08             	mov    0x8(%ebp),%eax
     801:	83 c0 07             	add    $0x7,%eax
     804:	c1 e8 03             	shr    $0x3,%eax
     807:	83 c0 01             	add    $0x1,%eax
     80a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     80d:	a1 a8 69 00 00       	mov    0x69a8,%eax
     812:	89 45 f0             	mov    %eax,-0x10(%ebp)
     815:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     819:	75 23                	jne    83e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     81b:	c7 45 f0 a0 69 00 00 	movl   $0x69a0,-0x10(%ebp)
     822:	8b 45 f0             	mov    -0x10(%ebp),%eax
     825:	a3 a8 69 00 00       	mov    %eax,0x69a8
     82a:	a1 a8 69 00 00       	mov    0x69a8,%eax
     82f:	a3 a0 69 00 00       	mov    %eax,0x69a0
    base.s.size = 0;
     834:	c7 05 a4 69 00 00 00 	movl   $0x0,0x69a4
     83b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     83e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     841:	8b 00                	mov    (%eax),%eax
     843:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     846:	8b 45 f4             	mov    -0xc(%ebp),%eax
     849:	8b 40 04             	mov    0x4(%eax),%eax
     84c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     84f:	72 4d                	jb     89e <malloc+0xa6>
      if(p->s.size == nunits)
     851:	8b 45 f4             	mov    -0xc(%ebp),%eax
     854:	8b 40 04             	mov    0x4(%eax),%eax
     857:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     85a:	75 0c                	jne    868 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     85c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85f:	8b 10                	mov    (%eax),%edx
     861:	8b 45 f0             	mov    -0x10(%ebp),%eax
     864:	89 10                	mov    %edx,(%eax)
     866:	eb 26                	jmp    88e <malloc+0x96>
      else {
        p->s.size -= nunits;
     868:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86b:	8b 40 04             	mov    0x4(%eax),%eax
     86e:	2b 45 ec             	sub    -0x14(%ebp),%eax
     871:	89 c2                	mov    %eax,%edx
     873:	8b 45 f4             	mov    -0xc(%ebp),%eax
     876:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     879:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87c:	8b 40 04             	mov    0x4(%eax),%eax
     87f:	c1 e0 03             	shl    $0x3,%eax
     882:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     885:	8b 45 f4             	mov    -0xc(%ebp),%eax
     888:	8b 55 ec             	mov    -0x14(%ebp),%edx
     88b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     88e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     891:	a3 a8 69 00 00       	mov    %eax,0x69a8
      return (void*)(p + 1);
     896:	8b 45 f4             	mov    -0xc(%ebp),%eax
     899:	83 c0 08             	add    $0x8,%eax
     89c:	eb 3b                	jmp    8d9 <malloc+0xe1>
    }
    if(p == freep)
     89e:	a1 a8 69 00 00       	mov    0x69a8,%eax
     8a3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8a6:	75 1e                	jne    8c6 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8a8:	83 ec 0c             	sub    $0xc,%esp
     8ab:	ff 75 ec             	pushl  -0x14(%ebp)
     8ae:	e8 e5 fe ff ff       	call   798 <morecore>
     8b3:	83 c4 10             	add    $0x10,%esp
     8b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8bd:	75 07                	jne    8c6 <malloc+0xce>
        return 0;
     8bf:	b8 00 00 00 00       	mov    $0x0,%eax
     8c4:	eb 13                	jmp    8d9 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cf:	8b 00                	mov    (%eax),%eax
     8d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8d4:	e9 6d ff ff ff       	jmp    846 <malloc+0x4e>
}
     8d9:	c9                   	leave  
     8da:	c3                   	ret    

000008db <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8db:	55                   	push   %ebp
     8dc:	89 e5                	mov    %esp,%ebp
     8de:	83 ec 1c             	sub    $0x1c,%esp
     8e1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8e4:	8b 55 10             	mov    0x10(%ebp),%edx
     8e7:	8b 45 14             	mov    0x14(%ebp),%eax
     8ea:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8ed:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8f0:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8f3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8f7:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8fa:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8fe:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     901:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     905:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     908:	8b 45 08             	mov    0x8(%ebp),%eax
     90b:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     90f:	66 89 10             	mov    %dx,(%eax)
     912:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     916:	88 50 02             	mov    %dl,0x2(%eax)
}
     919:	8b 45 08             	mov    0x8(%ebp),%eax
     91c:	c9                   	leave  
     91d:	c2 04 00             	ret    $0x4

00000920 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     923:	8b 45 08             	mov    0x8(%ebp),%eax
     926:	2b 45 10             	sub    0x10(%ebp),%eax
     929:	89 c2                	mov    %eax,%edx
     92b:	8b 45 08             	mov    0x8(%ebp),%eax
     92e:	2b 45 10             	sub    0x10(%ebp),%eax
     931:	0f af d0             	imul   %eax,%edx
     934:	8b 45 0c             	mov    0xc(%ebp),%eax
     937:	2b 45 14             	sub    0x14(%ebp),%eax
     93a:	89 c1                	mov    %eax,%ecx
     93c:	8b 45 0c             	mov    0xc(%ebp),%eax
     93f:	2b 45 14             	sub    0x14(%ebp),%eax
     942:	0f af c1             	imul   %ecx,%eax
     945:	01 d0                	add    %edx,%eax
}
     947:	5d                   	pop    %ebp
     948:	c3                   	ret    

00000949 <abs_int>:

static inline int abs_int(int x)
{
     949:	55                   	push   %ebp
     94a:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     94c:	8b 45 08             	mov    0x8(%ebp),%eax
     94f:	99                   	cltd   
     950:	89 d0                	mov    %edx,%eax
     952:	33 45 08             	xor    0x8(%ebp),%eax
     955:	29 d0                	sub    %edx,%eax
}
     957:	5d                   	pop    %ebp
     958:	c3                   	ret    

00000959 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     959:	55                   	push   %ebp
     95a:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     95c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     960:	79 07                	jns    969 <APGetIndex+0x10>
        return X_SMALLER;
     962:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     967:	eb 40                	jmp    9a9 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     969:	8b 45 08             	mov    0x8(%ebp),%eax
     96c:	8b 00                	mov    (%eax),%eax
     96e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     971:	7f 07                	jg     97a <APGetIndex+0x21>
        return X_BIGGER;
     973:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     978:	eb 2f                	jmp    9a9 <APGetIndex+0x50>
    if (y < 0)
     97a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     97e:	79 07                	jns    987 <APGetIndex+0x2e>
        return Y_SMALLER;
     980:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     985:	eb 22                	jmp    9a9 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     987:	8b 45 08             	mov    0x8(%ebp),%eax
     98a:	8b 40 04             	mov    0x4(%eax),%eax
     98d:	3b 45 10             	cmp    0x10(%ebp),%eax
     990:	7f 07                	jg     999 <APGetIndex+0x40>
        return Y_BIGGER;
     992:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     997:	eb 10                	jmp    9a9 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     999:	8b 45 08             	mov    0x8(%ebp),%eax
     99c:	8b 00                	mov    (%eax),%eax
     99e:	0f af 45 10          	imul   0x10(%ebp),%eax
     9a2:	89 c2                	mov    %eax,%edx
     9a4:	8b 45 0c             	mov    0xc(%ebp),%eax
     9a7:	01 d0                	add    %edx,%eax
}
     9a9:	5d                   	pop    %ebp
     9aa:	c3                   	ret    

000009ab <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     9ab:	55                   	push   %ebp
     9ac:	89 e5                	mov    %esp,%ebp
     9ae:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9b1:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9b8:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9bb:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9be:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9c5:	83 ec 08             	sub    $0x8,%esp
     9c8:	6a 00                	push   $0x0
     9ca:	ff 75 0c             	pushl  0xc(%ebp)
     9cd:	e8 d4 f9 ff ff       	call   3a6 <open>
     9d2:	83 c4 10             	add    $0x10,%esp
     9d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9dc:	79 2e                	jns    a0c <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9de:	83 ec 04             	sub    $0x4,%esp
     9e1:	ff 75 0c             	pushl  0xc(%ebp)
     9e4:	68 d9 25 00 00       	push   $0x25d9
     9e9:	6a 01                	push   $0x1
     9eb:	e8 35 fb ff ff       	call   525 <printf>
     9f0:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9f3:	8b 45 08             	mov    0x8(%ebp),%eax
     9f6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9f9:	89 10                	mov    %edx,(%eax)
     9fb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9fe:	89 50 04             	mov    %edx,0x4(%eax)
     a01:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a04:	89 50 08             	mov    %edx,0x8(%eax)
     a07:	e9 d2 01 00 00       	jmp    bde <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a0c:	83 ec 04             	sub    $0x4,%esp
     a0f:	6a 0e                	push   $0xe
     a11:	8d 45 ba             	lea    -0x46(%ebp),%eax
     a14:	50                   	push   %eax
     a15:	ff 75 ec             	pushl  -0x14(%ebp)
     a18:	e8 61 f9 ff ff       	call   37e <read>
     a1d:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a20:	83 ec 04             	sub    $0x4,%esp
     a23:	6a 28                	push   $0x28
     a25:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a28:	50                   	push   %eax
     a29:	ff 75 ec             	pushl  -0x14(%ebp)
     a2c:	e8 4d f9 ff ff       	call   37e <read>
     a31:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a34:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a37:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a3a:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a3d:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a40:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a43:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a46:	0f af d0             	imul   %eax,%edx
     a49:	89 d0                	mov    %edx,%eax
     a4b:	01 c0                	add    %eax,%eax
     a4d:	01 d0                	add    %edx,%eax
     a4f:	83 ec 0c             	sub    $0xc,%esp
     a52:	50                   	push   %eax
     a53:	e8 a0 fd ff ff       	call   7f8 <malloc>
     a58:	83 c4 10             	add    $0x10,%esp
     a5b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a5e:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a62:	0f b7 c0             	movzwl %ax,%eax
     a65:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a68:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a6e:	0f af c2             	imul   %edx,%eax
     a71:	83 c0 1f             	add    $0x1f,%eax
     a74:	c1 e8 05             	shr    $0x5,%eax
     a77:	c1 e0 02             	shl    $0x2,%eax
     a7a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a7d:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a83:	0f af c2             	imul   %edx,%eax
     a86:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a89:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a8c:	83 ec 0c             	sub    $0xc,%esp
     a8f:	50                   	push   %eax
     a90:	e8 63 fd ff ff       	call   7f8 <malloc>
     a95:	83 c4 10             	add    $0x10,%esp
     a98:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a9b:	83 ec 04             	sub    $0x4,%esp
     a9e:	ff 75 e0             	pushl  -0x20(%ebp)
     aa1:	ff 75 dc             	pushl  -0x24(%ebp)
     aa4:	ff 75 ec             	pushl  -0x14(%ebp)
     aa7:	e8 d2 f8 ff ff       	call   37e <read>
     aac:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     aaf:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     ab3:	66 c1 e8 03          	shr    $0x3,%ax
     ab7:	0f b7 c0             	movzwl %ax,%eax
     aba:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     abd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ac4:	e9 e5 00 00 00       	jmp    bae <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ac9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acf:	29 c2                	sub    %eax,%edx
     ad1:	89 d0                	mov    %edx,%eax
     ad3:	8d 50 ff             	lea    -0x1(%eax),%edx
     ad6:	8b 45 c8             	mov    -0x38(%ebp),%eax
     ad9:	0f af c2             	imul   %edx,%eax
     adc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     adf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ae6:	e9 b1 00 00 00       	jmp    b9c <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     aeb:	8b 55 d0             	mov    -0x30(%ebp),%edx
     aee:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     af1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af4:	01 c8                	add    %ecx,%eax
     af6:	89 c1                	mov    %eax,%ecx
     af8:	89 c8                	mov    %ecx,%eax
     afa:	01 c0                	add    %eax,%eax
     afc:	01 c8                	add    %ecx,%eax
     afe:	01 c2                	add    %eax,%edx
     b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b03:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b07:	89 c1                	mov    %eax,%ecx
     b09:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b0c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b10:	01 c1                	add    %eax,%ecx
     b12:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b15:	01 c8                	add    %ecx,%eax
     b17:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b1a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b1d:	01 c8                	add    %ecx,%eax
     b1f:	0f b6 00             	movzbl (%eax),%eax
     b22:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b25:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b28:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b2e:	01 c8                	add    %ecx,%eax
     b30:	89 c1                	mov    %eax,%ecx
     b32:	89 c8                	mov    %ecx,%eax
     b34:	01 c0                	add    %eax,%eax
     b36:	01 c8                	add    %ecx,%eax
     b38:	01 c2                	add    %eax,%edx
     b3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b3d:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b41:	89 c1                	mov    %eax,%ecx
     b43:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b46:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b4a:	01 c1                	add    %eax,%ecx
     b4c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b4f:	01 c8                	add    %ecx,%eax
     b51:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b54:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b57:	01 c8                	add    %ecx,%eax
     b59:	0f b6 00             	movzbl (%eax),%eax
     b5c:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b5f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b62:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b65:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b68:	01 c8                	add    %ecx,%eax
     b6a:	89 c1                	mov    %eax,%ecx
     b6c:	89 c8                	mov    %ecx,%eax
     b6e:	01 c0                	add    %eax,%eax
     b70:	01 c8                	add    %ecx,%eax
     b72:	01 c2                	add    %eax,%edx
     b74:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b77:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b7b:	89 c1                	mov    %eax,%ecx
     b7d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b80:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b84:	01 c1                	add    %eax,%ecx
     b86:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b89:	01 c8                	add    %ecx,%eax
     b8b:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b8e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b91:	01 c8                	add    %ecx,%eax
     b93:	0f b6 00             	movzbl (%eax),%eax
     b96:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b98:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b9c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ba2:	39 c2                	cmp    %eax,%edx
     ba4:	0f 87 41 ff ff ff    	ja     aeb <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     baa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bae:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb4:	39 c2                	cmp    %eax,%edx
     bb6:	0f 87 0d ff ff ff    	ja     ac9 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     bbc:	83 ec 0c             	sub    $0xc,%esp
     bbf:	ff 75 ec             	pushl  -0x14(%ebp)
     bc2:	e8 c7 f7 ff ff       	call   38e <close>
     bc7:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bca:	8b 45 08             	mov    0x8(%ebp),%eax
     bcd:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bd0:	89 10                	mov    %edx,(%eax)
     bd2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bd5:	89 50 04             	mov    %edx,0x4(%eax)
     bd8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bdb:	89 50 08             	mov    %edx,0x8(%eax)
}
     bde:	8b 45 08             	mov    0x8(%ebp),%eax
     be1:	c9                   	leave  
     be2:	c2 04 00             	ret    $0x4

00000be5 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     be5:	55                   	push   %ebp
     be6:	89 e5                	mov    %esp,%ebp
     be8:	53                   	push   %ebx
     be9:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bec:	83 ec 0c             	sub    $0xc,%esp
     bef:	6a 1c                	push   $0x1c
     bf1:	e8 02 fc ff ff       	call   7f8 <malloc>
     bf6:	83 c4 10             	add    $0x10,%esp
     bf9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bff:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c06:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c09:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c0c:	6a 0c                	push   $0xc
     c0e:	6a 0c                	push   $0xc
     c10:	6a 0c                	push   $0xc
     c12:	50                   	push   %eax
     c13:	e8 c3 fc ff ff       	call   8db <RGB>
     c18:	83 c4 0c             	add    $0xc,%esp
     c1b:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c1f:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c23:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c27:	88 43 15             	mov    %al,0x15(%ebx)
     c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c30:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c34:	66 89 48 10          	mov    %cx,0x10(%eax)
     c38:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c3c:	88 50 12             	mov    %dl,0x12(%eax)
     c3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c42:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c45:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c49:	66 89 48 08          	mov    %cx,0x8(%eax)
     c4d:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c51:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c54:	8b 45 08             	mov    0x8(%ebp),%eax
     c57:	89 c2                	mov    %eax,%edx
     c59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5c:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c61:	89 c2                	mov    %eax,%edx
     c63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c66:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c69:	8b 55 10             	mov    0x10(%ebp),%edx
     c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6f:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c78:	c9                   	leave  
     c79:	c3                   	ret    

00000c7a <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c7a:	55                   	push   %ebp
     c7b:	89 e5                	mov    %esp,%ebp
     c7d:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c80:	8b 45 0c             	mov    0xc(%ebp),%eax
     c83:	8b 50 08             	mov    0x8(%eax),%edx
     c86:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c89:	8b 40 0c             	mov    0xc(%eax),%eax
     c8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c8f:	8b 45 0c             	mov    0xc(%ebp),%eax
     c92:	8b 55 10             	mov    0x10(%ebp),%edx
     c95:	89 50 08             	mov    %edx,0x8(%eax)
     c98:	8b 55 14             	mov    0x14(%ebp),%edx
     c9b:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ca1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ca4:	89 10                	mov    %edx,(%eax)
     ca6:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ca9:	89 50 04             	mov    %edx,0x4(%eax)
}
     cac:	8b 45 08             	mov    0x8(%ebp),%eax
     caf:	c9                   	leave  
     cb0:	c2 04 00             	ret    $0x4

00000cb3 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     cb3:	55                   	push   %ebp
     cb4:	89 e5                	mov    %esp,%ebp
     cb6:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     cb9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbc:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     cc0:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cc4:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cc8:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ccb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cce:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cd2:	66 89 50 10          	mov    %dx,0x10(%eax)
     cd6:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cda:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     cdd:	8b 45 08             	mov    0x8(%ebp),%eax
     ce0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     ce4:	66 89 10             	mov    %dx,(%eax)
     ce7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     ceb:	88 50 02             	mov    %dl,0x2(%eax)
}
     cee:	8b 45 08             	mov    0x8(%ebp),%eax
     cf1:	c9                   	leave  
     cf2:	c2 04 00             	ret    $0x4

00000cf5 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     cf5:	55                   	push   %ebp
     cf6:	89 e5                	mov    %esp,%ebp
     cf8:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cfe:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     d02:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d06:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     d0a:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d10:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d14:	66 89 50 13          	mov    %dx,0x13(%eax)
     d18:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d1c:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     d1f:	8b 45 08             	mov    0x8(%ebp),%eax
     d22:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d26:	66 89 10             	mov    %dx,(%eax)
     d29:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d2d:	88 50 02             	mov    %dl,0x2(%eax)
}
     d30:	8b 45 08             	mov    0x8(%ebp),%eax
     d33:	c9                   	leave  
     d34:	c2 04 00             	ret    $0x4

00000d37 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d37:	55                   	push   %ebp
     d38:	89 e5                	mov    %esp,%ebp
     d3a:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d3d:	8b 45 08             	mov    0x8(%ebp),%eax
     d40:	8b 40 0c             	mov    0xc(%eax),%eax
     d43:	89 c2                	mov    %eax,%edx
     d45:	c1 ea 1f             	shr    $0x1f,%edx
     d48:	01 d0                	add    %edx,%eax
     d4a:	d1 f8                	sar    %eax
     d4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d52:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d56:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d59:	8b 45 10             	mov    0x10(%ebp),%eax
     d5c:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d62:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d66:	0f 89 98 00 00 00    	jns    e04 <APDrawPoint+0xcd>
        i = 0;
     d6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d73:	e9 8c 00 00 00       	jmp    e04 <APDrawPoint+0xcd>
    {
        j = x - off;
     d78:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7b:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d81:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d85:	79 69                	jns    df0 <APDrawPoint+0xb9>
            j = 0;
     d87:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d8e:	eb 60                	jmp    df0 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d90:	ff 75 fc             	pushl  -0x4(%ebp)
     d93:	ff 75 f8             	pushl  -0x8(%ebp)
     d96:	ff 75 08             	pushl  0x8(%ebp)
     d99:	e8 bb fb ff ff       	call   959 <APGetIndex>
     d9e:	83 c4 0c             	add    $0xc,%esp
     da1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     da4:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     da8:	74 55                	je     dff <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     daa:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     dae:	74 67                	je     e17 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     db0:	ff 75 10             	pushl  0x10(%ebp)
     db3:	ff 75 0c             	pushl  0xc(%ebp)
     db6:	ff 75 fc             	pushl  -0x4(%ebp)
     db9:	ff 75 f8             	pushl  -0x8(%ebp)
     dbc:	e8 5f fb ff ff       	call   920 <distance_2>
     dc1:	83 c4 10             	add    $0x10,%esp
     dc4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     dc7:	7f 23                	jg     dec <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     dc9:	8b 45 08             	mov    0x8(%ebp),%eax
     dcc:	8b 48 18             	mov    0x18(%eax),%ecx
     dcf:	8b 55 ec             	mov    -0x14(%ebp),%edx
     dd2:	89 d0                	mov    %edx,%eax
     dd4:	01 c0                	add    %eax,%eax
     dd6:	01 d0                	add    %edx,%eax
     dd8:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ddb:	8b 45 08             	mov    0x8(%ebp),%eax
     dde:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     de2:	66 89 0a             	mov    %cx,(%edx)
     de5:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     de9:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     dec:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     df0:	8b 55 0c             	mov    0xc(%ebp),%edx
     df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df6:	01 d0                	add    %edx,%eax
     df8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     dfb:	7d 93                	jge    d90 <APDrawPoint+0x59>
     dfd:	eb 01                	jmp    e00 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     dff:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e00:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e04:	8b 55 10             	mov    0x10(%ebp),%edx
     e07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e0a:	01 d0                	add    %edx,%eax
     e0c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e0f:	0f 8d 63 ff ff ff    	jge    d78 <APDrawPoint+0x41>
     e15:	eb 01                	jmp    e18 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e17:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e18:	c9                   	leave  
     e19:	c3                   	ret    

00000e1a <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e1a:	55                   	push   %ebp
     e1b:	89 e5                	mov    %esp,%ebp
     e1d:	53                   	push   %ebx
     e1e:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e21:	8b 45 0c             	mov    0xc(%ebp),%eax
     e24:	3b 45 14             	cmp    0x14(%ebp),%eax
     e27:	0f 85 80 00 00 00    	jne    ead <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e2d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e31:	0f 88 9d 02 00 00    	js     10d4 <APDrawLine+0x2ba>
     e37:	8b 45 08             	mov    0x8(%ebp),%eax
     e3a:	8b 00                	mov    (%eax),%eax
     e3c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e3f:	0f 8e 8f 02 00 00    	jle    10d4 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e45:	8b 45 10             	mov    0x10(%ebp),%eax
     e48:	3b 45 18             	cmp    0x18(%ebp),%eax
     e4b:	7e 12                	jle    e5f <APDrawLine+0x45>
        {
            int tmp = y2;
     e4d:	8b 45 18             	mov    0x18(%ebp),%eax
     e50:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e53:	8b 45 10             	mov    0x10(%ebp),%eax
     e56:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e59:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e5c:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e63:	79 07                	jns    e6c <APDrawLine+0x52>
     e65:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e6c:	8b 45 08             	mov    0x8(%ebp),%eax
     e6f:	8b 40 04             	mov    0x4(%eax),%eax
     e72:	3b 45 18             	cmp    0x18(%ebp),%eax
     e75:	7d 0c                	jge    e83 <APDrawLine+0x69>
     e77:	8b 45 08             	mov    0x8(%ebp),%eax
     e7a:	8b 40 04             	mov    0x4(%eax),%eax
     e7d:	83 e8 01             	sub    $0x1,%eax
     e80:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e83:	8b 45 10             	mov    0x10(%ebp),%eax
     e86:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e89:	eb 15                	jmp    ea0 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e8b:	ff 75 f4             	pushl  -0xc(%ebp)
     e8e:	ff 75 0c             	pushl  0xc(%ebp)
     e91:	ff 75 08             	pushl  0x8(%ebp)
     e94:	e8 9e fe ff ff       	call   d37 <APDrawPoint>
     e99:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e9c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ea0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea3:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea6:	7e e3                	jle    e8b <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     ea8:	e9 2b 02 00 00       	jmp    10d8 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     ead:	8b 45 10             	mov    0x10(%ebp),%eax
     eb0:	3b 45 18             	cmp    0x18(%ebp),%eax
     eb3:	75 7f                	jne    f34 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     eb5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eb9:	0f 88 18 02 00 00    	js     10d7 <APDrawLine+0x2bd>
     ebf:	8b 45 08             	mov    0x8(%ebp),%eax
     ec2:	8b 40 04             	mov    0x4(%eax),%eax
     ec5:	3b 45 10             	cmp    0x10(%ebp),%eax
     ec8:	0f 8e 09 02 00 00    	jle    10d7 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ece:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed1:	3b 45 14             	cmp    0x14(%ebp),%eax
     ed4:	7e 12                	jle    ee8 <APDrawLine+0xce>
        {
            int tmp = x2;
     ed6:	8b 45 14             	mov    0x14(%ebp),%eax
     ed9:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     edc:	8b 45 0c             	mov    0xc(%ebp),%eax
     edf:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ee2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ee5:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ee8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     eec:	79 07                	jns    ef5 <APDrawLine+0xdb>
     eee:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ef5:	8b 45 08             	mov    0x8(%ebp),%eax
     ef8:	8b 00                	mov    (%eax),%eax
     efa:	3b 45 14             	cmp    0x14(%ebp),%eax
     efd:	7d 0b                	jge    f0a <APDrawLine+0xf0>
     eff:	8b 45 08             	mov    0x8(%ebp),%eax
     f02:	8b 00                	mov    (%eax),%eax
     f04:	83 e8 01             	sub    $0x1,%eax
     f07:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f10:	eb 15                	jmp    f27 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f12:	ff 75 10             	pushl  0x10(%ebp)
     f15:	ff 75 f0             	pushl  -0x10(%ebp)
     f18:	ff 75 08             	pushl  0x8(%ebp)
     f1b:	e8 17 fe ff ff       	call   d37 <APDrawPoint>
     f20:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f23:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f27:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f2a:	3b 45 14             	cmp    0x14(%ebp),%eax
     f2d:	7e e3                	jle    f12 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f2f:	e9 a4 01 00 00       	jmp    10d8 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f34:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f3b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f42:	8b 45 0c             	mov    0xc(%ebp),%eax
     f45:	2b 45 14             	sub    0x14(%ebp),%eax
     f48:	50                   	push   %eax
     f49:	e8 fb f9 ff ff       	call   949 <abs_int>
     f4e:	83 c4 04             	add    $0x4,%esp
     f51:	89 c3                	mov    %eax,%ebx
     f53:	8b 45 10             	mov    0x10(%ebp),%eax
     f56:	2b 45 18             	sub    0x18(%ebp),%eax
     f59:	50                   	push   %eax
     f5a:	e8 ea f9 ff ff       	call   949 <abs_int>
     f5f:	83 c4 04             	add    $0x4,%esp
     f62:	39 c3                	cmp    %eax,%ebx
     f64:	0f 8e b5 00 00 00    	jle    101f <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f6a:	8b 45 10             	mov    0x10(%ebp),%eax
     f6d:	2b 45 18             	sub    0x18(%ebp),%eax
     f70:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f73:	db 45 b0             	fildl  -0x50(%ebp)
     f76:	8b 45 0c             	mov    0xc(%ebp),%eax
     f79:	2b 45 14             	sub    0x14(%ebp),%eax
     f7c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f7f:	db 45 b0             	fildl  -0x50(%ebp)
     f82:	de f9                	fdivrp %st,%st(1)
     f84:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f87:	8b 45 14             	mov    0x14(%ebp),%eax
     f8a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f8d:	7e 0e                	jle    f9d <APDrawLine+0x183>
        {
            s = x1;
     f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f92:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f95:	8b 45 14             	mov    0x14(%ebp),%eax
     f98:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f9b:	eb 0c                	jmp    fa9 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f9d:	8b 45 14             	mov    0x14(%ebp),%eax
     fa0:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa6:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     fa9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fad:	79 07                	jns    fb6 <APDrawLine+0x19c>
     faf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     fb6:	8b 45 08             	mov    0x8(%ebp),%eax
     fb9:	8b 00                	mov    (%eax),%eax
     fbb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fbe:	7f 0b                	jg     fcb <APDrawLine+0x1b1>
     fc0:	8b 45 08             	mov    0x8(%ebp),%eax
     fc3:	8b 00                	mov    (%eax),%eax
     fc5:	83 e8 01             	sub    $0x1,%eax
     fc8:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fcb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fd1:	eb 3f                	jmp    1012 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fd6:	2b 45 0c             	sub    0xc(%ebp),%eax
     fd9:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fdc:	db 45 b0             	fildl  -0x50(%ebp)
     fdf:	dc 4d d0             	fmull  -0x30(%ebp)
     fe2:	db 45 10             	fildl  0x10(%ebp)
     fe5:	de c1                	faddp  %st,%st(1)
     fe7:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fea:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fee:	b4 0c                	mov    $0xc,%ah
     ff0:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     ff4:	d9 6d b4             	fldcw  -0x4c(%ebp)
     ff7:	db 5d cc             	fistpl -0x34(%ebp)
     ffa:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     ffd:	ff 75 cc             	pushl  -0x34(%ebp)
    1000:	ff 75 e4             	pushl  -0x1c(%ebp)
    1003:	ff 75 08             	pushl  0x8(%ebp)
    1006:	e8 2c fd ff ff       	call   d37 <APDrawPoint>
    100b:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    100e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1012:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1015:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1018:	7e b9                	jle    fd3 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    101a:	e9 b9 00 00 00       	jmp    10d8 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    101f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1022:	2b 45 14             	sub    0x14(%ebp),%eax
    1025:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1028:	db 45 b0             	fildl  -0x50(%ebp)
    102b:	8b 45 10             	mov    0x10(%ebp),%eax
    102e:	2b 45 18             	sub    0x18(%ebp),%eax
    1031:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1034:	db 45 b0             	fildl  -0x50(%ebp)
    1037:	de f9                	fdivrp %st,%st(1)
    1039:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    103c:	8b 45 10             	mov    0x10(%ebp),%eax
    103f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1042:	7e 0e                	jle    1052 <APDrawLine+0x238>
    {
        s = y2;
    1044:	8b 45 18             	mov    0x18(%ebp),%eax
    1047:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    104a:	8b 45 10             	mov    0x10(%ebp),%eax
    104d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1050:	eb 0c                	jmp    105e <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1052:	8b 45 10             	mov    0x10(%ebp),%eax
    1055:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1058:	8b 45 18             	mov    0x18(%ebp),%eax
    105b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    105e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1062:	79 07                	jns    106b <APDrawLine+0x251>
    1064:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    106b:	8b 45 08             	mov    0x8(%ebp),%eax
    106e:	8b 40 04             	mov    0x4(%eax),%eax
    1071:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1074:	7f 0c                	jg     1082 <APDrawLine+0x268>
    1076:	8b 45 08             	mov    0x8(%ebp),%eax
    1079:	8b 40 04             	mov    0x4(%eax),%eax
    107c:	83 e8 01             	sub    $0x1,%eax
    107f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1082:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1085:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1088:	eb 3f                	jmp    10c9 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    108a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    108d:	2b 45 10             	sub    0x10(%ebp),%eax
    1090:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1093:	db 45 b0             	fildl  -0x50(%ebp)
    1096:	dc 4d c0             	fmull  -0x40(%ebp)
    1099:	db 45 0c             	fildl  0xc(%ebp)
    109c:	de c1                	faddp  %st,%st(1)
    109e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10a1:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10a5:	b4 0c                	mov    $0xc,%ah
    10a7:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10ab:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10ae:	db 5d bc             	fistpl -0x44(%ebp)
    10b1:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10b4:	ff 75 e0             	pushl  -0x20(%ebp)
    10b7:	ff 75 bc             	pushl  -0x44(%ebp)
    10ba:	ff 75 08             	pushl  0x8(%ebp)
    10bd:	e8 75 fc ff ff       	call   d37 <APDrawPoint>
    10c2:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10c5:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10cc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10cf:	7e b9                	jle    108a <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10d1:	90                   	nop
    10d2:	eb 04                	jmp    10d8 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10d4:	90                   	nop
    10d5:	eb 01                	jmp    10d8 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10d7:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10db:	c9                   	leave  
    10dc:	c3                   	ret    

000010dd <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10dd:	55                   	push   %ebp
    10de:	89 e5                	mov    %esp,%ebp
    10e0:	53                   	push   %ebx
    10e1:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10e4:	8b 55 10             	mov    0x10(%ebp),%edx
    10e7:	8b 45 18             	mov    0x18(%ebp),%eax
    10ea:	01 d0                	add    %edx,%eax
    10ec:	83 e8 01             	sub    $0x1,%eax
    10ef:	83 ec 04             	sub    $0x4,%esp
    10f2:	50                   	push   %eax
    10f3:	ff 75 0c             	pushl  0xc(%ebp)
    10f6:	ff 75 10             	pushl  0x10(%ebp)
    10f9:	ff 75 0c             	pushl  0xc(%ebp)
    10fc:	ff 75 08             	pushl  0x8(%ebp)
    10ff:	e8 16 fd ff ff       	call   e1a <APDrawLine>
    1104:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1107:	8b 55 0c             	mov    0xc(%ebp),%edx
    110a:	8b 45 14             	mov    0x14(%ebp),%eax
    110d:	01 d0                	add    %edx,%eax
    110f:	83 e8 01             	sub    $0x1,%eax
    1112:	83 ec 04             	sub    $0x4,%esp
    1115:	ff 75 10             	pushl  0x10(%ebp)
    1118:	50                   	push   %eax
    1119:	ff 75 10             	pushl  0x10(%ebp)
    111c:	ff 75 0c             	pushl  0xc(%ebp)
    111f:	ff 75 08             	pushl  0x8(%ebp)
    1122:	e8 f3 fc ff ff       	call   e1a <APDrawLine>
    1127:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    112a:	8b 55 10             	mov    0x10(%ebp),%edx
    112d:	8b 45 18             	mov    0x18(%ebp),%eax
    1130:	01 d0                	add    %edx,%eax
    1132:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1135:	8b 55 0c             	mov    0xc(%ebp),%edx
    1138:	8b 45 14             	mov    0x14(%ebp),%eax
    113b:	01 d0                	add    %edx,%eax
    113d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1140:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1143:	8b 45 14             	mov    0x14(%ebp),%eax
    1146:	01 d8                	add    %ebx,%eax
    1148:	83 e8 01             	sub    $0x1,%eax
    114b:	83 ec 04             	sub    $0x4,%esp
    114e:	51                   	push   %ecx
    114f:	52                   	push   %edx
    1150:	ff 75 10             	pushl  0x10(%ebp)
    1153:	50                   	push   %eax
    1154:	ff 75 08             	pushl  0x8(%ebp)
    1157:	e8 be fc ff ff       	call   e1a <APDrawLine>
    115c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    115f:	8b 55 10             	mov    0x10(%ebp),%edx
    1162:	8b 45 18             	mov    0x18(%ebp),%eax
    1165:	01 d0                	add    %edx,%eax
    1167:	8d 48 ff             	lea    -0x1(%eax),%ecx
    116a:	8b 55 0c             	mov    0xc(%ebp),%edx
    116d:	8b 45 14             	mov    0x14(%ebp),%eax
    1170:	01 d0                	add    %edx,%eax
    1172:	8d 50 ff             	lea    -0x1(%eax),%edx
    1175:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1178:	8b 45 18             	mov    0x18(%ebp),%eax
    117b:	01 d8                	add    %ebx,%eax
    117d:	83 e8 01             	sub    $0x1,%eax
    1180:	83 ec 04             	sub    $0x4,%esp
    1183:	51                   	push   %ecx
    1184:	52                   	push   %edx
    1185:	50                   	push   %eax
    1186:	ff 75 0c             	pushl  0xc(%ebp)
    1189:	ff 75 08             	pushl  0x8(%ebp)
    118c:	e8 89 fc ff ff       	call   e1a <APDrawLine>
    1191:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1194:	8b 55 0c             	mov    0xc(%ebp),%edx
    1197:	8b 45 14             	mov    0x14(%ebp),%eax
    119a:	01 d0                	add    %edx,%eax
    119c:	8d 50 ff             	lea    -0x1(%eax),%edx
    119f:	8b 45 08             	mov    0x8(%ebp),%eax
    11a2:	8b 40 0c             	mov    0xc(%eax),%eax
    11a5:	89 c1                	mov    %eax,%ecx
    11a7:	c1 e9 1f             	shr    $0x1f,%ecx
    11aa:	01 c8                	add    %ecx,%eax
    11ac:	d1 f8                	sar    %eax
    11ae:	29 c2                	sub    %eax,%edx
    11b0:	89 d0                	mov    %edx,%eax
    11b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11b5:	8b 55 10             	mov    0x10(%ebp),%edx
    11b8:	8b 45 18             	mov    0x18(%ebp),%eax
    11bb:	01 d0                	add    %edx,%eax
    11bd:	8d 50 ff             	lea    -0x1(%eax),%edx
    11c0:	8b 45 08             	mov    0x8(%ebp),%eax
    11c3:	8b 40 0c             	mov    0xc(%eax),%eax
    11c6:	89 c1                	mov    %eax,%ecx
    11c8:	c1 e9 1f             	shr    $0x1f,%ecx
    11cb:	01 c8                	add    %ecx,%eax
    11cd:	d1 f8                	sar    %eax
    11cf:	29 c2                	sub    %eax,%edx
    11d1:	89 d0                	mov    %edx,%eax
    11d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11d6:	8b 45 08             	mov    0x8(%ebp),%eax
    11d9:	8b 40 0c             	mov    0xc(%eax),%eax
    11dc:	89 c2                	mov    %eax,%edx
    11de:	c1 ea 1f             	shr    $0x1f,%edx
    11e1:	01 d0                	add    %edx,%eax
    11e3:	d1 f8                	sar    %eax
    11e5:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11e8:	8b 45 08             	mov    0x8(%ebp),%eax
    11eb:	8b 40 0c             	mov    0xc(%eax),%eax
    11ee:	89 c2                	mov    %eax,%edx
    11f0:	c1 ea 1f             	shr    $0x1f,%edx
    11f3:	01 d0                	add    %edx,%eax
    11f5:	d1 f8                	sar    %eax
    11f7:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11fe:	0f 88 d8 00 00 00    	js     12dc <APDrawRect+0x1ff>
    1204:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1208:	0f 88 ce 00 00 00    	js     12dc <APDrawRect+0x1ff>
    120e:	8b 45 08             	mov    0x8(%ebp),%eax
    1211:	8b 00                	mov    (%eax),%eax
    1213:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1216:	0f 8e c0 00 00 00    	jle    12dc <APDrawRect+0x1ff>
    121c:	8b 45 08             	mov    0x8(%ebp),%eax
    121f:	8b 40 04             	mov    0x4(%eax),%eax
    1222:	3b 45 10             	cmp    0x10(%ebp),%eax
    1225:	0f 8e b1 00 00 00    	jle    12dc <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    122b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    122f:	79 07                	jns    1238 <APDrawRect+0x15b>
    1231:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1238:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    123c:	79 07                	jns    1245 <APDrawRect+0x168>
    123e:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1245:	8b 45 08             	mov    0x8(%ebp),%eax
    1248:	8b 00                	mov    (%eax),%eax
    124a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    124d:	7f 0b                	jg     125a <APDrawRect+0x17d>
    124f:	8b 45 08             	mov    0x8(%ebp),%eax
    1252:	8b 00                	mov    (%eax),%eax
    1254:	83 e8 01             	sub    $0x1,%eax
    1257:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    125a:	8b 45 08             	mov    0x8(%ebp),%eax
    125d:	8b 40 04             	mov    0x4(%eax),%eax
    1260:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1263:	7f 0c                	jg     1271 <APDrawRect+0x194>
    1265:	8b 45 08             	mov    0x8(%ebp),%eax
    1268:	8b 40 04             	mov    0x4(%eax),%eax
    126b:	83 e8 01             	sub    $0x1,%eax
    126e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1271:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1278:	8b 45 0c             	mov    0xc(%ebp),%eax
    127b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    127e:	eb 52                	jmp    12d2 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1280:	8b 45 10             	mov    0x10(%ebp),%eax
    1283:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1286:	eb 3e                	jmp    12c6 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1288:	83 ec 04             	sub    $0x4,%esp
    128b:	ff 75 e8             	pushl  -0x18(%ebp)
    128e:	ff 75 ec             	pushl  -0x14(%ebp)
    1291:	ff 75 08             	pushl  0x8(%ebp)
    1294:	e8 c0 f6 ff ff       	call   959 <APGetIndex>
    1299:	83 c4 10             	add    $0x10,%esp
    129c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    129f:	8b 45 08             	mov    0x8(%ebp),%eax
    12a2:	8b 48 18             	mov    0x18(%eax),%ecx
    12a5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    12a8:	89 d0                	mov    %edx,%eax
    12aa:	01 c0                	add    %eax,%eax
    12ac:	01 d0                	add    %edx,%eax
    12ae:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12b1:	8b 45 08             	mov    0x8(%ebp),%eax
    12b4:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12b8:	66 89 0a             	mov    %cx,(%edx)
    12bb:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12bf:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12c2:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12c9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12cc:	7e ba                	jle    1288 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12ce:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12d5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12d8:	7e a6                	jle    1280 <APDrawRect+0x1a3>
    12da:	eb 01                	jmp    12dd <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12dc:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12e0:	c9                   	leave  
    12e1:	c3                   	ret    

000012e2 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    12e2:	55                   	push   %ebp
    12e3:	89 e5                	mov    %esp,%ebp
    12e5:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    12e8:	83 ec 0c             	sub    $0xc,%esp
    12eb:	ff 75 0c             	pushl  0xc(%ebp)
    12ee:	e8 b1 ee ff ff       	call   1a4 <strlen>
    12f3:	83 c4 10             	add    $0x10,%esp
    12f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    12f9:	8b 45 08             	mov    0x8(%ebp),%eax
    12fc:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1300:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1304:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1308:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    130b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1312:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1319:	e9 bc 00 00 00       	jmp    13da <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    131e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1321:	8b 45 0c             	mov    0xc(%ebp),%eax
    1324:	01 d0                	add    %edx,%eax
    1326:	0f b6 00             	movzbl (%eax),%eax
    1329:	0f be c0             	movsbl %al,%eax
    132c:	83 e8 20             	sub    $0x20,%eax
    132f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1332:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1336:	0f 87 9a 00 00 00    	ja     13d6 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    133c:	8b 45 08             	mov    0x8(%ebp),%eax
    133f:	8b 00                	mov    (%eax),%eax
    1341:	0f af 45 14          	imul   0x14(%ebp),%eax
    1345:	89 c2                	mov    %eax,%edx
    1347:	8b 45 10             	mov    0x10(%ebp),%eax
    134a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    134d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1350:	89 d0                	mov    %edx,%eax
    1352:	c1 e0 03             	shl    $0x3,%eax
    1355:	01 d0                	add    %edx,%eax
    1357:	01 c8                	add    %ecx,%eax
    1359:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    135c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1363:	eb 6b                	jmp    13d0 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1365:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    136c:	eb 50                	jmp    13be <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    136e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1371:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1374:	89 d0                	mov    %edx,%eax
    1376:	c1 e0 03             	shl    $0x3,%eax
    1379:	01 d0                	add    %edx,%eax
    137b:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1381:	01 c2                	add    %eax,%edx
    1383:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1386:	01 d0                	add    %edx,%eax
    1388:	05 60 2d 00 00       	add    $0x2d60,%eax
    138d:	0f b6 00             	movzbl (%eax),%eax
    1390:	84 c0                	test   %al,%al
    1392:	74 26                	je     13ba <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1394:	8b 45 08             	mov    0x8(%ebp),%eax
    1397:	8b 50 18             	mov    0x18(%eax),%edx
    139a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    139d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13a0:	01 c8                	add    %ecx,%eax
    13a2:	89 c1                	mov    %eax,%ecx
    13a4:	89 c8                	mov    %ecx,%eax
    13a6:	01 c0                	add    %eax,%eax
    13a8:	01 c8                	add    %ecx,%eax
    13aa:	01 d0                	add    %edx,%eax
    13ac:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13b0:	66 89 10             	mov    %dx,(%eax)
    13b3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13b7:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    13ba:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13be:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    13c2:	7e aa                	jle    136e <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    13c4:	8b 45 08             	mov    0x8(%ebp),%eax
    13c7:	8b 00                	mov    (%eax),%eax
    13c9:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    13cc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13d0:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    13d4:	7e 8f                	jle    1365 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    13d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13dd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    13e0:	0f 82 38 ff ff ff    	jb     131e <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    13e6:	90                   	nop
    13e7:	c9                   	leave  
    13e8:	c3                   	ret    

000013e9 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    13e9:	55                   	push   %ebp
    13ea:	89 e5                	mov    %esp,%ebp
    13ec:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    13ef:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    13f3:	0f 88 8e 01 00 00    	js     1587 <APDcCopy+0x19e>
    13f9:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    13fd:	0f 88 84 01 00 00    	js     1587 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1403:	8b 55 0c             	mov    0xc(%ebp),%edx
    1406:	8b 45 20             	mov    0x20(%ebp),%eax
    1409:	01 d0                	add    %edx,%eax
    140b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    140e:	8b 55 10             	mov    0x10(%ebp),%edx
    1411:	8b 45 24             	mov    0x24(%ebp),%eax
    1414:	01 d0                	add    %edx,%eax
    1416:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1419:	8b 55 18             	mov    0x18(%ebp),%edx
    141c:	8b 45 20             	mov    0x20(%ebp),%eax
    141f:	01 d0                	add    %edx,%eax
    1421:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1424:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1427:	8b 45 24             	mov    0x24(%ebp),%eax
    142a:	01 d0                	add    %edx,%eax
    142c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    142f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1433:	0f 88 51 01 00 00    	js     158a <APDcCopy+0x1a1>
    1439:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    143d:	0f 88 47 01 00 00    	js     158a <APDcCopy+0x1a1>
    1443:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1447:	0f 88 3d 01 00 00    	js     158a <APDcCopy+0x1a1>
    144d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1451:	0f 88 33 01 00 00    	js     158a <APDcCopy+0x1a1>
    1457:	8b 45 14             	mov    0x14(%ebp),%eax
    145a:	8b 00                	mov    (%eax),%eax
    145c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    145f:	0f 8c 25 01 00 00    	jl     158a <APDcCopy+0x1a1>
    1465:	8b 45 14             	mov    0x14(%ebp),%eax
    1468:	8b 40 04             	mov    0x4(%eax),%eax
    146b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    146e:	0f 8c 16 01 00 00    	jl     158a <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1474:	8b 45 08             	mov    0x8(%ebp),%eax
    1477:	8b 00                	mov    (%eax),%eax
    1479:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    147c:	7f 0b                	jg     1489 <APDcCopy+0xa0>
    147e:	8b 45 08             	mov    0x8(%ebp),%eax
    1481:	8b 00                	mov    (%eax),%eax
    1483:	83 e8 01             	sub    $0x1,%eax
    1486:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1489:	8b 45 08             	mov    0x8(%ebp),%eax
    148c:	8b 40 04             	mov    0x4(%eax),%eax
    148f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1492:	7f 0c                	jg     14a0 <APDcCopy+0xb7>
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
    1497:	8b 40 04             	mov    0x4(%eax),%eax
    149a:	83 e8 01             	sub    $0x1,%eax
    149d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    14a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    14a7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    14ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14b5:	e9 bc 00 00 00       	jmp    1576 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14ba:	8b 45 08             	mov    0x8(%ebp),%eax
    14bd:	8b 00                	mov    (%eax),%eax
    14bf:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14c2:	8b 55 10             	mov    0x10(%ebp),%edx
    14c5:	01 ca                	add    %ecx,%edx
    14c7:	0f af d0             	imul   %eax,%edx
    14ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    14cd:	01 d0                	add    %edx,%eax
    14cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    14d2:	8b 45 14             	mov    0x14(%ebp),%eax
    14d5:	8b 00                	mov    (%eax),%eax
    14d7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14da:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14dd:	01 ca                	add    %ecx,%edx
    14df:	0f af d0             	imul   %eax,%edx
    14e2:	8b 45 18             	mov    0x18(%ebp),%eax
    14e5:	01 d0                	add    %edx,%eax
    14e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    14ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14f1:	eb 74                	jmp    1567 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    14f3:	8b 45 14             	mov    0x14(%ebp),%eax
    14f6:	8b 50 18             	mov    0x18(%eax),%edx
    14f9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    14fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ff:	01 c8                	add    %ecx,%eax
    1501:	89 c1                	mov    %eax,%ecx
    1503:	89 c8                	mov    %ecx,%eax
    1505:	01 c0                	add    %eax,%eax
    1507:	01 c8                	add    %ecx,%eax
    1509:	01 d0                	add    %edx,%eax
    150b:	0f b7 10             	movzwl (%eax),%edx
    150e:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1512:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1516:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1519:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    151d:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1521:	38 c2                	cmp    %al,%dl
    1523:	75 18                	jne    153d <APDcCopy+0x154>
    1525:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1529:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    152d:	38 c2                	cmp    %al,%dl
    152f:	75 0c                	jne    153d <APDcCopy+0x154>
    1531:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1535:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1539:	38 c2                	cmp    %al,%dl
    153b:	74 26                	je     1563 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    153d:	8b 45 08             	mov    0x8(%ebp),%eax
    1540:	8b 50 18             	mov    0x18(%eax),%edx
    1543:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1546:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1549:	01 c8                	add    %ecx,%eax
    154b:	89 c1                	mov    %eax,%ecx
    154d:	89 c8                	mov    %ecx,%eax
    154f:	01 c0                	add    %eax,%eax
    1551:	01 c8                	add    %ecx,%eax
    1553:	01 d0                	add    %edx,%eax
    1555:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1559:	66 89 10             	mov    %dx,(%eax)
    155c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1560:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1563:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1567:	8b 45 fc             	mov    -0x4(%ebp),%eax
    156a:	2b 45 0c             	sub    0xc(%ebp),%eax
    156d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1570:	7d 81                	jge    14f3 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1572:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1576:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1579:	2b 45 10             	sub    0x10(%ebp),%eax
    157c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    157f:	0f 8d 35 ff ff ff    	jge    14ba <APDcCopy+0xd1>
    1585:	eb 04                	jmp    158b <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1587:	90                   	nop
    1588:	eb 01                	jmp    158b <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    158a:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    158b:	c9                   	leave  
    158c:	c3                   	ret    

0000158d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    158d:	55                   	push   %ebp
    158e:	89 e5                	mov    %esp,%ebp
    1590:	83 ec 1c             	sub    $0x1c,%esp
    1593:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1596:	8b 55 10             	mov    0x10(%ebp),%edx
    1599:	8b 45 14             	mov    0x14(%ebp),%eax
    159c:	88 4d ec             	mov    %cl,-0x14(%ebp)
    159f:	88 55 e8             	mov    %dl,-0x18(%ebp)
    15a2:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    15a5:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    15a9:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    15ac:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15b0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15b3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15b7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15ba:	8b 45 08             	mov    0x8(%ebp),%eax
    15bd:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15c1:	66 89 10             	mov    %dx,(%eax)
    15c4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15c8:	88 50 02             	mov    %dl,0x2(%eax)
}
    15cb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ce:	c9                   	leave  
    15cf:	c2 04 00             	ret    $0x4

000015d2 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    15d2:	55                   	push   %ebp
    15d3:	89 e5                	mov    %esp,%ebp
    15d5:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	8b 00                	mov    (%eax),%eax
    15dd:	83 ec 08             	sub    $0x8,%esp
    15e0:	8d 55 0c             	lea    0xc(%ebp),%edx
    15e3:	52                   	push   %edx
    15e4:	50                   	push   %eax
    15e5:	e8 24 ee ff ff       	call   40e <sendMessage>
    15ea:	83 c4 10             	add    $0x10,%esp
}
    15ed:	90                   	nop
    15ee:	c9                   	leave  
    15ef:	c3                   	ret    

000015f0 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    15f0:	55                   	push   %ebp
    15f1:	89 e5                	mov    %esp,%ebp
    15f3:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    15f6:	83 ec 0c             	sub    $0xc,%esp
    15f9:	68 9c 00 00 00       	push   $0x9c
    15fe:	e8 f5 f1 ff ff       	call   7f8 <malloc>
    1603:	83 c4 10             	add    $0x10,%esp
    1606:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1609:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    160d:	75 15                	jne    1624 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    160f:	83 ec 04             	sub    $0x4,%esp
    1612:	ff 75 08             	pushl  0x8(%ebp)
    1615:	68 ec 25 00 00       	push   $0x25ec
    161a:	6a 01                	push   $0x1
    161c:	e8 04 ef ff ff       	call   525 <printf>
    1621:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1624:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1627:	05 88 00 00 00       	add    $0x88,%eax
    162c:	83 ec 08             	sub    $0x8,%esp
    162f:	ff 75 08             	pushl  0x8(%ebp)
    1632:	50                   	push   %eax
    1633:	e8 fd ea ff ff       	call   135 <strcpy>
    1638:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    163b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163e:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1645:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1648:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    164f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1652:	8b 40 3c             	mov    0x3c(%eax),%eax
    1655:	89 c2                	mov    %eax,%edx
    1657:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165a:	8b 40 40             	mov    0x40(%eax),%eax
    165d:	0f af d0             	imul   %eax,%edx
    1660:	89 d0                	mov    %edx,%eax
    1662:	01 c0                	add    %eax,%eax
    1664:	01 d0                	add    %edx,%eax
    1666:	83 ec 0c             	sub    $0xc,%esp
    1669:	50                   	push   %eax
    166a:	e8 89 f1 ff ff       	call   7f8 <malloc>
    166f:	83 c4 10             	add    $0x10,%esp
    1672:	89 c2                	mov    %eax,%edx
    1674:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1677:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    167a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167d:	8b 40 54             	mov    0x54(%eax),%eax
    1680:	85 c0                	test   %eax,%eax
    1682:	75 15                	jne    1699 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1684:	83 ec 04             	sub    $0x4,%esp
    1687:	ff 75 08             	pushl  0x8(%ebp)
    168a:	68 0c 26 00 00       	push   $0x260c
    168f:	6a 01                	push   $0x1
    1691:	e8 8f ee ff ff       	call   525 <printf>
    1696:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1699:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169c:	8b 40 3c             	mov    0x3c(%eax),%eax
    169f:	89 c2                	mov    %eax,%edx
    16a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a4:	8b 40 40             	mov    0x40(%eax),%eax
    16a7:	0f af d0             	imul   %eax,%edx
    16aa:	89 d0                	mov    %edx,%eax
    16ac:	01 c0                	add    %eax,%eax
    16ae:	01 c2                	add    %eax,%edx
    16b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b3:	8b 40 54             	mov    0x54(%eax),%eax
    16b6:	83 ec 04             	sub    $0x4,%esp
    16b9:	52                   	push   %edx
    16ba:	68 ff ff ff 00       	push   $0xffffff
    16bf:	50                   	push   %eax
    16c0:	e8 06 eb ff ff       	call   1cb <memset>
    16c5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cb:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    16d2:	e8 0f ed ff ff       	call   3e6 <getpid>
    16d7:	89 c2                	mov    %eax,%edx
    16d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16dc:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    16df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e2:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    16e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ec:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    16f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f6:	8b 40 58             	mov    0x58(%eax),%eax
    16f9:	89 c2                	mov    %eax,%edx
    16fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fe:	8b 40 5c             	mov    0x5c(%eax),%eax
    1701:	0f af d0             	imul   %eax,%edx
    1704:	89 d0                	mov    %edx,%eax
    1706:	01 c0                	add    %eax,%eax
    1708:	01 d0                	add    %edx,%eax
    170a:	83 ec 0c             	sub    $0xc,%esp
    170d:	50                   	push   %eax
    170e:	e8 e5 f0 ff ff       	call   7f8 <malloc>
    1713:	83 c4 10             	add    $0x10,%esp
    1716:	89 c2                	mov    %eax,%edx
    1718:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171b:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    171e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1721:	8b 40 70             	mov    0x70(%eax),%eax
    1724:	85 c0                	test   %eax,%eax
    1726:	75 15                	jne    173d <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1728:	83 ec 04             	sub    $0x4,%esp
    172b:	ff 75 08             	pushl  0x8(%ebp)
    172e:	68 30 26 00 00       	push   $0x2630
    1733:	6a 01                	push   $0x1
    1735:	e8 eb ed ff ff       	call   525 <printf>
    173a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    173d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1740:	8b 40 3c             	mov    0x3c(%eax),%eax
    1743:	89 c2                	mov    %eax,%edx
    1745:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1748:	8b 40 40             	mov    0x40(%eax),%eax
    174b:	0f af d0             	imul   %eax,%edx
    174e:	89 d0                	mov    %edx,%eax
    1750:	01 c0                	add    %eax,%eax
    1752:	01 c2                	add    %eax,%edx
    1754:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1757:	8b 40 54             	mov    0x54(%eax),%eax
    175a:	83 ec 04             	sub    $0x4,%esp
    175d:	52                   	push   %edx
    175e:	68 ff 00 00 00       	push   $0xff
    1763:	50                   	push   %eax
    1764:	e8 62 ea ff ff       	call   1cb <memset>
    1769:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    176c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1772:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1775:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1779:	74 49                	je     17c4 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    177b:	8b 45 10             	mov    0x10(%ebp),%eax
    177e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1784:	83 ec 0c             	sub    $0xc,%esp
    1787:	50                   	push   %eax
    1788:	e8 6b f0 ff ff       	call   7f8 <malloc>
    178d:	83 c4 10             	add    $0x10,%esp
    1790:	89 c2                	mov    %eax,%edx
    1792:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1795:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1798:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179b:	8b 55 10             	mov    0x10(%ebp),%edx
    179e:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    17a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    17ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ae:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    17b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    17bf:	e9 8d 00 00 00       	jmp    1851 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    17c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c7:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    17ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d1:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17db:	8b 40 20             	mov    0x20(%eax),%eax
    17de:	89 c2                	mov    %eax,%edx
    17e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e3:	8b 40 24             	mov    0x24(%eax),%eax
    17e6:	0f af d0             	imul   %eax,%edx
    17e9:	89 d0                	mov    %edx,%eax
    17eb:	01 c0                	add    %eax,%eax
    17ed:	01 d0                	add    %edx,%eax
    17ef:	83 ec 0c             	sub    $0xc,%esp
    17f2:	50                   	push   %eax
    17f3:	e8 00 f0 ff ff       	call   7f8 <malloc>
    17f8:	83 c4 10             	add    $0x10,%esp
    17fb:	89 c2                	mov    %eax,%edx
    17fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1800:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1803:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1806:	8b 40 38             	mov    0x38(%eax),%eax
    1809:	85 c0                	test   %eax,%eax
    180b:	75 15                	jne    1822 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    180d:	83 ec 04             	sub    $0x4,%esp
    1810:	ff 75 08             	pushl  0x8(%ebp)
    1813:	68 58 26 00 00       	push   $0x2658
    1818:	6a 01                	push   $0x1
    181a:	e8 06 ed ff ff       	call   525 <printf>
    181f:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1822:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1825:	8b 40 20             	mov    0x20(%eax),%eax
    1828:	89 c2                	mov    %eax,%edx
    182a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182d:	8b 40 24             	mov    0x24(%eax),%eax
    1830:	0f af d0             	imul   %eax,%edx
    1833:	89 d0                	mov    %edx,%eax
    1835:	01 c0                	add    %eax,%eax
    1837:	01 c2                	add    %eax,%edx
    1839:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183c:	8b 40 38             	mov    0x38(%eax),%eax
    183f:	83 ec 04             	sub    $0x4,%esp
    1842:	52                   	push   %edx
    1843:	68 ff ff ff 00       	push   $0xffffff
    1848:	50                   	push   %eax
    1849:	e8 7d e9 ff ff       	call   1cb <memset>
    184e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1851:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1854:	c9                   	leave  
    1855:	c3                   	ret    

00001856 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1856:	55                   	push   %ebp
    1857:	89 e5                	mov    %esp,%ebp
    1859:	57                   	push   %edi
    185a:	56                   	push   %esi
    185b:	53                   	push   %ebx
    185c:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    185f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1862:	83 f8 03             	cmp    $0x3,%eax
    1865:	74 0e                	je     1875 <APWndProc+0x1f>
    1867:	83 f8 0a             	cmp    $0xa,%eax
    186a:	0f 84 82 00 00 00    	je     18f2 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    1870:	e9 cb 00 00 00       	jmp    1940 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1875:	8b 45 08             	mov    0x8(%ebp),%eax
    1878:	8b 58 1c             	mov    0x1c(%eax),%ebx
    187b:	8b 45 08             	mov    0x8(%ebp),%eax
    187e:	8b 48 18             	mov    0x18(%eax),%ecx
    1881:	8b 45 08             	mov    0x8(%ebp),%eax
    1884:	8b 50 5c             	mov    0x5c(%eax),%edx
    1887:	8b 45 08             	mov    0x8(%ebp),%eax
    188a:	8b 40 58             	mov    0x58(%eax),%eax
    188d:	8b 75 08             	mov    0x8(%ebp),%esi
    1890:	83 c6 58             	add    $0x58,%esi
    1893:	83 ec 04             	sub    $0x4,%esp
    1896:	53                   	push   %ebx
    1897:	51                   	push   %ecx
    1898:	6a 00                	push   $0x0
    189a:	52                   	push   %edx
    189b:	50                   	push   %eax
    189c:	6a 00                	push   $0x0
    189e:	6a 00                	push   $0x0
    18a0:	56                   	push   %esi
    18a1:	6a 00                	push   $0x0
    18a3:	6a 00                	push   $0x0
    18a5:	ff 75 08             	pushl  0x8(%ebp)
    18a8:	e8 59 eb ff ff       	call   406 <paintWindow>
    18ad:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    18b0:	8b 45 08             	mov    0x8(%ebp),%eax
    18b3:	8b 70 1c             	mov    0x1c(%eax),%esi
    18b6:	8b 45 08             	mov    0x8(%ebp),%eax
    18b9:	8b 58 18             	mov    0x18(%eax),%ebx
    18bc:	8b 45 08             	mov    0x8(%ebp),%eax
    18bf:	8b 48 08             	mov    0x8(%eax),%ecx
    18c2:	8b 45 08             	mov    0x8(%ebp),%eax
    18c5:	8b 50 40             	mov    0x40(%eax),%edx
    18c8:	8b 45 08             	mov    0x8(%ebp),%eax
    18cb:	8b 40 3c             	mov    0x3c(%eax),%eax
    18ce:	8b 7d 08             	mov    0x8(%ebp),%edi
    18d1:	83 c7 3c             	add    $0x3c,%edi
    18d4:	83 ec 04             	sub    $0x4,%esp
    18d7:	56                   	push   %esi
    18d8:	53                   	push   %ebx
    18d9:	51                   	push   %ecx
    18da:	52                   	push   %edx
    18db:	50                   	push   %eax
    18dc:	6a 00                	push   $0x0
    18de:	6a 00                	push   $0x0
    18e0:	57                   	push   %edi
    18e1:	6a 32                	push   $0x32
    18e3:	6a 00                	push   $0x0
    18e5:	ff 75 08             	pushl  0x8(%ebp)
    18e8:	e8 19 eb ff ff       	call   406 <paintWindow>
    18ed:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    18f0:	eb 4e                	jmp    1940 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    18f2:	8b 45 18             	mov    0x18(%ebp),%eax
    18f5:	83 ec 08             	sub    $0x8,%esp
    18f8:	50                   	push   %eax
    18f9:	ff 75 08             	pushl  0x8(%ebp)
    18fc:	e8 19 08 00 00       	call   211a <updateword>
    1901:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1904:	8b 45 08             	mov    0x8(%ebp),%eax
    1907:	8b 58 1c             	mov    0x1c(%eax),%ebx
    190a:	8b 45 08             	mov    0x8(%ebp),%eax
    190d:	8b 48 18             	mov    0x18(%eax),%ecx
    1910:	8b 45 08             	mov    0x8(%ebp),%eax
    1913:	8b 50 5c             	mov    0x5c(%eax),%edx
    1916:	8b 45 08             	mov    0x8(%ebp),%eax
    1919:	8b 40 58             	mov    0x58(%eax),%eax
    191c:	8b 75 08             	mov    0x8(%ebp),%esi
    191f:	83 c6 58             	add    $0x58,%esi
    1922:	83 ec 04             	sub    $0x4,%esp
    1925:	53                   	push   %ebx
    1926:	51                   	push   %ecx
    1927:	6a 00                	push   $0x0
    1929:	52                   	push   %edx
    192a:	50                   	push   %eax
    192b:	6a 00                	push   $0x0
    192d:	6a 00                	push   $0x0
    192f:	56                   	push   %esi
    1930:	6a 00                	push   $0x0
    1932:	6a 00                	push   $0x0
    1934:	ff 75 08             	pushl  0x8(%ebp)
    1937:	e8 ca ea ff ff       	call   406 <paintWindow>
    193c:	83 c4 30             	add    $0x30,%esp
            break;
    193f:	90                   	nop
        default: break;
            
            
    }
    return False;
    1940:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1945:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1948:	5b                   	pop    %ebx
    1949:	5e                   	pop    %esi
    194a:	5f                   	pop    %edi
    194b:	5d                   	pop    %ebp
    194c:	c3                   	ret    

0000194d <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    194d:	55                   	push   %ebp
    194e:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1950:	8b 45 0c             	mov    0xc(%ebp),%eax
    1953:	8b 50 08             	mov    0x8(%eax),%edx
    1956:	8b 45 08             	mov    0x8(%ebp),%eax
    1959:	8b 00                	mov    (%eax),%eax
    195b:	39 c2                	cmp    %eax,%edx
    195d:	74 07                	je     1966 <APPreJudge+0x19>
        return False;
    195f:	b8 00 00 00 00       	mov    $0x0,%eax
    1964:	eb 05                	jmp    196b <APPreJudge+0x1e>
    return True;
    1966:	b8 01 00 00 00       	mov    $0x1,%eax
}
    196b:	5d                   	pop    %ebp
    196c:	c3                   	ret    

0000196d <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    196d:	55                   	push   %ebp
    196e:	89 e5                	mov    %esp,%ebp
    1970:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1973:	8b 45 08             	mov    0x8(%ebp),%eax
    1976:	8b 55 0c             	mov    0xc(%ebp),%edx
    1979:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    197f:	83 ec 0c             	sub    $0xc,%esp
    1982:	ff 75 08             	pushl  0x8(%ebp)
    1985:	e8 94 ea ff ff       	call   41e <registWindow>
    198a:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    198d:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    1994:	8b 45 08             	mov    0x8(%ebp),%eax
    1997:	8b 00                	mov    (%eax),%eax
    1999:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    199c:	83 ec 0c             	sub    $0xc,%esp
    199f:	ff 75 f4             	pushl  -0xc(%ebp)
    19a2:	ff 75 f0             	pushl  -0x10(%ebp)
    19a5:	ff 75 ec             	pushl  -0x14(%ebp)
    19a8:	ff 75 e8             	pushl  -0x18(%ebp)
    19ab:	ff 75 08             	pushl  0x8(%ebp)
    19ae:	e8 1f fc ff ff       	call   15d2 <APSendMessage>
    19b3:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19b6:	83 ec 0c             	sub    $0xc,%esp
    19b9:	ff 75 08             	pushl  0x8(%ebp)
    19bc:	e8 55 ea ff ff       	call   416 <getMessage>
    19c1:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    19c4:	8b 45 08             	mov    0x8(%ebp),%eax
    19c7:	83 c0 74             	add    $0x74,%eax
    19ca:	83 ec 08             	sub    $0x8,%esp
    19cd:	50                   	push   %eax
    19ce:	ff 75 08             	pushl  0x8(%ebp)
    19d1:	e8 77 ff ff ff       	call   194d <APPreJudge>
    19d6:	83 c4 10             	add    $0x10,%esp
    19d9:	84 c0                	test   %al,%al
    19db:	74 24                	je     1a01 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    19dd:	83 ec 0c             	sub    $0xc,%esp
    19e0:	8b 45 08             	mov    0x8(%ebp),%eax
    19e3:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    19e9:	ff 70 7c             	pushl  0x7c(%eax)
    19ec:	ff 70 78             	pushl  0x78(%eax)
    19ef:	ff 70 74             	pushl  0x74(%eax)
    19f2:	ff 75 08             	pushl  0x8(%ebp)
    19f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    19f8:	ff d0                	call   *%eax
    19fa:	83 c4 20             	add    $0x20,%esp
    19fd:	84 c0                	test   %al,%al
    19ff:	75 0c                	jne    1a0d <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    1a01:	8b 45 08             	mov    0x8(%ebp),%eax
    1a04:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a0b:	eb a9                	jmp    19b6 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a0d:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a0e:	90                   	nop
    1a0f:	c9                   	leave  
    1a10:	c3                   	ret    

00001a11 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a11:	55                   	push   %ebp
    1a12:	89 e5                	mov    %esp,%ebp
    1a14:	57                   	push   %edi
    1a15:	56                   	push   %esi
    1a16:	53                   	push   %ebx
    1a17:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a1a:	a1 ac 69 00 00       	mov    0x69ac,%eax
    1a1f:	85 c0                	test   %eax,%eax
    1a21:	0f 85 7a 02 00 00    	jne    1ca1 <APGridPaint+0x290>
    {
        iconReady = 1;
    1a27:	c7 05 ac 69 00 00 01 	movl   $0x1,0x69ac
    1a2e:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a31:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a34:	83 ec 08             	sub    $0x8,%esp
    1a37:	68 7f 26 00 00       	push   $0x267f
    1a3c:	50                   	push   %eax
    1a3d:	e8 69 ef ff ff       	call   9ab <APLoadBitmap>
    1a42:	83 c4 0c             	add    $0xc,%esp
    1a45:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a48:	a3 e0 6b 00 00       	mov    %eax,0x6be0
    1a4d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a50:	a3 e4 6b 00 00       	mov    %eax,0x6be4
    1a55:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a58:	a3 e8 6b 00 00       	mov    %eax,0x6be8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a5d:	83 ec 04             	sub    $0x4,%esp
    1a60:	ff 35 e8 6b 00 00    	pushl  0x6be8
    1a66:	ff 35 e4 6b 00 00    	pushl  0x6be4
    1a6c:	ff 35 e0 6b 00 00    	pushl  0x6be0
    1a72:	e8 6e f1 ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1a77:	83 c4 10             	add    $0x10,%esp
    1a7a:	a3 ec 6b 00 00       	mov    %eax,0x6bec
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a7f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a82:	83 ec 08             	sub    $0x8,%esp
    1a85:	68 8d 26 00 00       	push   $0x268d
    1a8a:	50                   	push   %eax
    1a8b:	e8 1b ef ff ff       	call   9ab <APLoadBitmap>
    1a90:	83 c4 0c             	add    $0xc,%esp
    1a93:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a96:	a3 28 6c 00 00       	mov    %eax,0x6c28
    1a9b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a9e:	a3 2c 6c 00 00       	mov    %eax,0x6c2c
    1aa3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aa6:	a3 30 6c 00 00       	mov    %eax,0x6c30
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1aab:	83 ec 04             	sub    $0x4,%esp
    1aae:	ff 35 30 6c 00 00    	pushl  0x6c30
    1ab4:	ff 35 2c 6c 00 00    	pushl  0x6c2c
    1aba:	ff 35 28 6c 00 00    	pushl  0x6c28
    1ac0:	e8 20 f1 ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1ac5:	83 c4 10             	add    $0x10,%esp
    1ac8:	a3 18 6c 00 00       	mov    %eax,0x6c18
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1acd:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ad0:	83 ec 08             	sub    $0x8,%esp
    1ad3:	68 9c 26 00 00       	push   $0x269c
    1ad8:	50                   	push   %eax
    1ad9:	e8 cd ee ff ff       	call   9ab <APLoadBitmap>
    1ade:	83 c4 0c             	add    $0xc,%esp
    1ae1:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ae4:	a3 1c 6c 00 00       	mov    %eax,0x6c1c
    1ae9:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aec:	a3 20 6c 00 00       	mov    %eax,0x6c20
    1af1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1af4:	a3 24 6c 00 00       	mov    %eax,0x6c24
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1af9:	83 ec 04             	sub    $0x4,%esp
    1afc:	ff 35 24 6c 00 00    	pushl  0x6c24
    1b02:	ff 35 20 6c 00 00    	pushl  0x6c20
    1b08:	ff 35 1c 6c 00 00    	pushl  0x6c1c
    1b0e:	e8 d2 f0 ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1b13:	83 c4 10             	add    $0x10,%esp
    1b16:	a3 c0 6b 00 00       	mov    %eax,0x6bc0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b1b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b1e:	83 ec 08             	sub    $0x8,%esp
    1b21:	68 ab 26 00 00       	push   $0x26ab
    1b26:	50                   	push   %eax
    1b27:	e8 7f ee ff ff       	call   9ab <APLoadBitmap>
    1b2c:	83 c4 0c             	add    $0xc,%esp
    1b2f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b32:	a3 f4 6b 00 00       	mov    %eax,0x6bf4
    1b37:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b3a:	a3 f8 6b 00 00       	mov    %eax,0x6bf8
    1b3f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b42:	a3 fc 6b 00 00       	mov    %eax,0x6bfc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b47:	83 ec 04             	sub    $0x4,%esp
    1b4a:	ff 35 fc 6b 00 00    	pushl  0x6bfc
    1b50:	ff 35 f8 6b 00 00    	pushl  0x6bf8
    1b56:	ff 35 f4 6b 00 00    	pushl  0x6bf4
    1b5c:	e8 84 f0 ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1b61:	83 c4 10             	add    $0x10,%esp
    1b64:	a3 38 6c 00 00       	mov    %eax,0x6c38
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b69:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b6c:	83 ec 08             	sub    $0x8,%esp
    1b6f:	68 b9 26 00 00       	push   $0x26b9
    1b74:	50                   	push   %eax
    1b75:	e8 31 ee ff ff       	call   9ab <APLoadBitmap>
    1b7a:	83 c4 0c             	add    $0xc,%esp
    1b7d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b80:	a3 d0 6b 00 00       	mov    %eax,0x6bd0
    1b85:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b88:	a3 d4 6b 00 00       	mov    %eax,0x6bd4
    1b8d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b90:	a3 d8 6b 00 00       	mov    %eax,0x6bd8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b95:	83 ec 04             	sub    $0x4,%esp
    1b98:	ff 35 d8 6b 00 00    	pushl  0x6bd8
    1b9e:	ff 35 d4 6b 00 00    	pushl  0x6bd4
    1ba4:	ff 35 d0 6b 00 00    	pushl  0x6bd0
    1baa:	e8 36 f0 ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1baf:	83 c4 10             	add    $0x10,%esp
    1bb2:	a3 f0 6b 00 00       	mov    %eax,0x6bf0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1bb7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bba:	83 ec 08             	sub    $0x8,%esp
    1bbd:	68 c9 26 00 00       	push   $0x26c9
    1bc2:	50                   	push   %eax
    1bc3:	e8 e3 ed ff ff       	call   9ab <APLoadBitmap>
    1bc8:	83 c4 0c             	add    $0xc,%esp
    1bcb:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bce:	a3 c4 6b 00 00       	mov    %eax,0x6bc4
    1bd3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bd6:	a3 c8 6b 00 00       	mov    %eax,0x6bc8
    1bdb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bde:	a3 cc 6b 00 00       	mov    %eax,0x6bcc
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1be3:	83 ec 04             	sub    $0x4,%esp
    1be6:	ff 35 cc 6b 00 00    	pushl  0x6bcc
    1bec:	ff 35 c8 6b 00 00    	pushl  0x6bc8
    1bf2:	ff 35 c4 6b 00 00    	pushl  0x6bc4
    1bf8:	e8 e8 ef ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1bfd:	83 c4 10             	add    $0x10,%esp
    1c00:	a3 dc 6b 00 00       	mov    %eax,0x6bdc
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c05:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c08:	83 ec 08             	sub    $0x8,%esp
    1c0b:	68 db 26 00 00       	push   $0x26db
    1c10:	50                   	push   %eax
    1c11:	e8 95 ed ff ff       	call   9ab <APLoadBitmap>
    1c16:	83 c4 0c             	add    $0xc,%esp
    1c19:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c1c:	a3 0c 6c 00 00       	mov    %eax,0x6c0c
    1c21:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c24:	a3 10 6c 00 00       	mov    %eax,0x6c10
    1c29:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c2c:	a3 14 6c 00 00       	mov    %eax,0x6c14
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c31:	83 ec 04             	sub    $0x4,%esp
    1c34:	ff 35 14 6c 00 00    	pushl  0x6c14
    1c3a:	ff 35 10 6c 00 00    	pushl  0x6c10
    1c40:	ff 35 0c 6c 00 00    	pushl  0x6c0c
    1c46:	e8 9a ef ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1c4b:	83 c4 10             	add    $0x10,%esp
    1c4e:	a3 3c 6c 00 00       	mov    %eax,0x6c3c
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1c53:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c56:	83 ec 08             	sub    $0x8,%esp
    1c59:	68 ea 26 00 00       	push   $0x26ea
    1c5e:	50                   	push   %eax
    1c5f:	e8 47 ed ff ff       	call   9ab <APLoadBitmap>
    1c64:	83 c4 0c             	add    $0xc,%esp
    1c67:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c6a:	a3 00 6c 00 00       	mov    %eax,0x6c00
    1c6f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c72:	a3 04 6c 00 00       	mov    %eax,0x6c04
    1c77:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c7a:	a3 08 6c 00 00       	mov    %eax,0x6c08
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1c7f:	83 ec 04             	sub    $0x4,%esp
    1c82:	ff 35 08 6c 00 00    	pushl  0x6c08
    1c88:	ff 35 04 6c 00 00    	pushl  0x6c04
    1c8e:	ff 35 00 6c 00 00    	pushl  0x6c00
    1c94:	e8 4c ef ff ff       	call   be5 <APCreateCompatibleDCFromBitmap>
    1c99:	83 c4 10             	add    $0x10,%esp
    1c9c:	a3 34 6c 00 00       	mov    %eax,0x6c34
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1ca1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca4:	8b 40 08             	mov    0x8(%eax),%eax
    1ca7:	85 c0                	test   %eax,%eax
    1ca9:	75 17                	jne    1cc2 <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1cab:	83 ec 08             	sub    $0x8,%esp
    1cae:	68 fc 26 00 00       	push   $0x26fc
    1cb3:	6a 01                	push   $0x1
    1cb5:	e8 6b e8 ff ff       	call   525 <printf>
    1cba:	83 c4 10             	add    $0x10,%esp
        return;
    1cbd:	e9 50 04 00 00       	jmp    2112 <APGridPaint+0x701>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1cc2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc5:	8b 40 10             	mov    0x10(%eax),%eax
    1cc8:	85 c0                	test   %eax,%eax
    1cca:	7e 10                	jle    1cdc <APGridPaint+0x2cb>
    1ccc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccf:	8b 50 14             	mov    0x14(%eax),%edx
    1cd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd5:	8b 40 10             	mov    0x10(%eax),%eax
    1cd8:	39 c2                	cmp    %eax,%edx
    1cda:	7c 17                	jl     1cf3 <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    1cdc:	83 ec 08             	sub    $0x8,%esp
    1cdf:	68 22 27 00 00       	push   $0x2722
    1ce4:	6a 01                	push   $0x1
    1ce6:	e8 3a e8 ff ff       	call   525 <printf>
    1ceb:	83 c4 10             	add    $0x10,%esp
        return;
    1cee:	e9 1f 04 00 00       	jmp    2112 <APGridPaint+0x701>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1cf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf6:	8b 40 14             	mov    0x14(%eax),%eax
    1cf9:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1cff:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d02:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d05:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d08:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1d0f:	e9 f4 03 00 00       	jmp    2108 <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d14:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d1b:	e9 da 03 00 00       	jmp    20fa <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d23:	c1 e0 04             	shl    $0x4,%eax
    1d26:	89 c2                	mov    %eax,%edx
    1d28:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d2b:	01 c2                	add    %eax,%edx
    1d2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d30:	01 d0                	add    %edx,%eax
    1d32:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d35:	8b 45 08             	mov    0x8(%ebp),%eax
    1d38:	8b 40 0c             	mov    0xc(%eax),%eax
    1d3b:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d3e:	c1 e2 02             	shl    $0x2,%edx
    1d41:	01 d0                	add    %edx,%eax
    1d43:	8b 00                	mov    (%eax),%eax
    1d45:	83 f8 0a             	cmp    $0xa,%eax
    1d48:	0f 87 a7 03 00 00    	ja     20f5 <APGridPaint+0x6e4>
    1d4e:	8b 04 85 38 27 00 00 	mov    0x2738(,%eax,4),%eax
    1d55:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d57:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1d5a:	6a 0c                	push   $0xc
    1d5c:	6a 0c                	push   $0xc
    1d5e:	6a 0c                	push   $0xc
    1d60:	50                   	push   %eax
    1d61:	e8 27 f8 ff ff       	call   158d <RGB>
    1d66:	83 c4 0c             	add    $0xc,%esp
    1d69:	8b 1d ec 6b 00 00    	mov    0x6bec,%ebx
    1d6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d72:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d75:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d78:	6b c0 32             	imul   $0x32,%eax,%eax
    1d7b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d81:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d84:	83 ec 0c             	sub    $0xc,%esp
    1d87:	83 ec 04             	sub    $0x4,%esp
    1d8a:	89 e0                	mov    %esp,%eax
    1d8c:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1d90:	66 89 30             	mov    %si,(%eax)
    1d93:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1d97:	88 50 02             	mov    %dl,0x2(%eax)
    1d9a:	6a 32                	push   $0x32
    1d9c:	6a 32                	push   $0x32
    1d9e:	6a 00                	push   $0x0
    1da0:	6a 00                	push   $0x0
    1da2:	53                   	push   %ebx
    1da3:	51                   	push   %ecx
    1da4:	ff 75 94             	pushl  -0x6c(%ebp)
    1da7:	57                   	push   %edi
    1da8:	e8 3c f6 ff ff       	call   13e9 <APDcCopy>
    1dad:	83 c4 30             	add    $0x30,%esp
                    break;
    1db0:	e9 41 03 00 00       	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1db5:	8d 45 98             	lea    -0x68(%ebp),%eax
    1db8:	6a 69                	push   $0x69
    1dba:	6a 69                	push   $0x69
    1dbc:	6a 69                	push   $0x69
    1dbe:	50                   	push   %eax
    1dbf:	e8 c9 f7 ff ff       	call   158d <RGB>
    1dc4:	83 c4 0c             	add    $0xc,%esp
    1dc7:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1dcb:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1dcf:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dd3:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1dd6:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ddd:	8d 45 98             	lea    -0x68(%ebp),%eax
    1de0:	6a 69                	push   $0x69
    1de2:	6a 69                	push   $0x69
    1de4:	6a 69                	push   $0x69
    1de6:	50                   	push   %eax
    1de7:	e8 a1 f7 ff ff       	call   158d <RGB>
    1dec:	83 c4 0c             	add    $0xc,%esp
    1def:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1df3:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1df7:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dfb:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1dfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1e01:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e04:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e07:	ff 75 bc             	pushl  -0x44(%ebp)
    1e0a:	ff 75 b8             	pushl  -0x48(%ebp)
    1e0d:	52                   	push   %edx
    1e0e:	50                   	push   %eax
    1e0f:	e8 66 ee ff ff       	call   c7a <APSetPen>
    1e14:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1e17:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1a:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e1d:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e20:	83 ec 04             	sub    $0x4,%esp
    1e23:	83 ec 04             	sub    $0x4,%esp
    1e26:	89 e0                	mov    %esp,%eax
    1e28:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1e2c:	66 89 08             	mov    %cx,(%eax)
    1e2f:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1e33:	88 48 02             	mov    %cl,0x2(%eax)
    1e36:	53                   	push   %ebx
    1e37:	52                   	push   %edx
    1e38:	e8 76 ee ff ff       	call   cb3 <APSetBrush>
    1e3d:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e43:	6b d0 32             	imul   $0x32,%eax,%edx
    1e46:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e49:	6b c0 32             	imul   $0x32,%eax,%eax
    1e4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e4f:	83 c1 3c             	add    $0x3c,%ecx
    1e52:	83 ec 0c             	sub    $0xc,%esp
    1e55:	6a 32                	push   $0x32
    1e57:	6a 32                	push   $0x32
    1e59:	52                   	push   %edx
    1e5a:	50                   	push   %eax
    1e5b:	51                   	push   %ecx
    1e5c:	e8 7c f2 ff ff       	call   10dd <APDrawRect>
    1e61:	83 c4 20             	add    $0x20,%esp
                    break;
    1e64:	e9 8d 02 00 00       	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e69:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1e6c:	6a 0c                	push   $0xc
    1e6e:	6a 0c                	push   $0xc
    1e70:	6a 0c                	push   $0xc
    1e72:	50                   	push   %eax
    1e73:	e8 15 f7 ff ff       	call   158d <RGB>
    1e78:	83 c4 0c             	add    $0xc,%esp
    1e7b:	8b 1d 3c 6c 00 00    	mov    0x6c3c,%ebx
    1e81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e84:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e87:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e8a:	6b c0 32             	imul   $0x32,%eax,%eax
    1e8d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e90:	8b 45 08             	mov    0x8(%ebp),%eax
    1e93:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e96:	83 ec 0c             	sub    $0xc,%esp
    1e99:	83 ec 04             	sub    $0x4,%esp
    1e9c:	89 e0                	mov    %esp,%eax
    1e9e:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1ea2:	66 89 30             	mov    %si,(%eax)
    1ea5:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1ea9:	88 50 02             	mov    %dl,0x2(%eax)
    1eac:	6a 32                	push   $0x32
    1eae:	6a 32                	push   $0x32
    1eb0:	6a 00                	push   $0x0
    1eb2:	6a 00                	push   $0x0
    1eb4:	53                   	push   %ebx
    1eb5:	51                   	push   %ecx
    1eb6:	ff 75 94             	pushl  -0x6c(%ebp)
    1eb9:	57                   	push   %edi
    1eba:	e8 2a f5 ff ff       	call   13e9 <APDcCopy>
    1ebf:	83 c4 30             	add    $0x30,%esp
                    break;
    1ec2:	e9 2f 02 00 00       	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ec7:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1eca:	6a 0c                	push   $0xc
    1ecc:	6a 0c                	push   $0xc
    1ece:	6a 0c                	push   $0xc
    1ed0:	50                   	push   %eax
    1ed1:	e8 b7 f6 ff ff       	call   158d <RGB>
    1ed6:	83 c4 0c             	add    $0xc,%esp
    1ed9:	8b 1d 18 6c 00 00    	mov    0x6c18,%ebx
    1edf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ee2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ee5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ee8:	6b c0 32             	imul   $0x32,%eax,%eax
    1eeb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eee:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef1:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ef4:	83 ec 0c             	sub    $0xc,%esp
    1ef7:	83 ec 04             	sub    $0x4,%esp
    1efa:	89 e0                	mov    %esp,%eax
    1efc:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1f00:	66 89 30             	mov    %si,(%eax)
    1f03:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1f07:	88 50 02             	mov    %dl,0x2(%eax)
    1f0a:	6a 32                	push   $0x32
    1f0c:	6a 32                	push   $0x32
    1f0e:	6a 00                	push   $0x0
    1f10:	6a 00                	push   $0x0
    1f12:	53                   	push   %ebx
    1f13:	51                   	push   %ecx
    1f14:	ff 75 94             	pushl  -0x6c(%ebp)
    1f17:	57                   	push   %edi
    1f18:	e8 cc f4 ff ff       	call   13e9 <APDcCopy>
    1f1d:	83 c4 30             	add    $0x30,%esp
                    break;
    1f20:	e9 d1 01 00 00       	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f25:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1f28:	6a 0c                	push   $0xc
    1f2a:	6a 0c                	push   $0xc
    1f2c:	6a 0c                	push   $0xc
    1f2e:	50                   	push   %eax
    1f2f:	e8 59 f6 ff ff       	call   158d <RGB>
    1f34:	83 c4 0c             	add    $0xc,%esp
    1f37:	8b 1d f0 6b 00 00    	mov    0x6bf0,%ebx
    1f3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f40:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f43:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f46:	6b c0 32             	imul   $0x32,%eax,%eax
    1f49:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4f:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f52:	83 ec 0c             	sub    $0xc,%esp
    1f55:	83 ec 04             	sub    $0x4,%esp
    1f58:	89 e0                	mov    %esp,%eax
    1f5a:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f5e:	66 89 30             	mov    %si,(%eax)
    1f61:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f65:	88 50 02             	mov    %dl,0x2(%eax)
    1f68:	6a 32                	push   $0x32
    1f6a:	6a 32                	push   $0x32
    1f6c:	6a 00                	push   $0x0
    1f6e:	6a 00                	push   $0x0
    1f70:	53                   	push   %ebx
    1f71:	51                   	push   %ecx
    1f72:	ff 75 94             	pushl  -0x6c(%ebp)
    1f75:	57                   	push   %edi
    1f76:	e8 6e f4 ff ff       	call   13e9 <APDcCopy>
    1f7b:	83 c4 30             	add    $0x30,%esp
                    break;
    1f7e:	e9 73 01 00 00       	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f83:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f86:	6a 0c                	push   $0xc
    1f88:	6a 0c                	push   $0xc
    1f8a:	6a 0c                	push   $0xc
    1f8c:	50                   	push   %eax
    1f8d:	e8 fb f5 ff ff       	call   158d <RGB>
    1f92:	83 c4 0c             	add    $0xc,%esp
    1f95:	8b 1d 38 6c 00 00    	mov    0x6c38,%ebx
    1f9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f9e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fa1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fa4:	6b c0 32             	imul   $0x32,%eax,%eax
    1fa7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1faa:	8b 45 08             	mov    0x8(%ebp),%eax
    1fad:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fb0:	83 ec 0c             	sub    $0xc,%esp
    1fb3:	83 ec 04             	sub    $0x4,%esp
    1fb6:	89 e0                	mov    %esp,%eax
    1fb8:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1fbc:	66 89 30             	mov    %si,(%eax)
    1fbf:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1fc3:	88 50 02             	mov    %dl,0x2(%eax)
    1fc6:	6a 32                	push   $0x32
    1fc8:	6a 32                	push   $0x32
    1fca:	6a 00                	push   $0x0
    1fcc:	6a 00                	push   $0x0
    1fce:	53                   	push   %ebx
    1fcf:	51                   	push   %ecx
    1fd0:	ff 75 94             	pushl  -0x6c(%ebp)
    1fd3:	57                   	push   %edi
    1fd4:	e8 10 f4 ff ff       	call   13e9 <APDcCopy>
    1fd9:	83 c4 30             	add    $0x30,%esp
                    break;
    1fdc:	e9 15 01 00 00       	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fe1:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1fe4:	6a 0c                	push   $0xc
    1fe6:	6a 0c                	push   $0xc
    1fe8:	6a 0c                	push   $0xc
    1fea:	50                   	push   %eax
    1feb:	e8 9d f5 ff ff       	call   158d <RGB>
    1ff0:	83 c4 0c             	add    $0xc,%esp
    1ff3:	8b 1d c0 6b 00 00    	mov    0x6bc0,%ebx
    1ff9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ffc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fff:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2002:	6b c0 32             	imul   $0x32,%eax,%eax
    2005:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2008:	8b 45 08             	mov    0x8(%ebp),%eax
    200b:	8d 78 3c             	lea    0x3c(%eax),%edi
    200e:	83 ec 0c             	sub    $0xc,%esp
    2011:	83 ec 04             	sub    $0x4,%esp
    2014:	89 e0                	mov    %esp,%eax
    2016:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    201a:	66 89 30             	mov    %si,(%eax)
    201d:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2021:	88 50 02             	mov    %dl,0x2(%eax)
    2024:	6a 32                	push   $0x32
    2026:	6a 32                	push   $0x32
    2028:	6a 00                	push   $0x0
    202a:	6a 00                	push   $0x0
    202c:	53                   	push   %ebx
    202d:	51                   	push   %ecx
    202e:	ff 75 94             	pushl  -0x6c(%ebp)
    2031:	57                   	push   %edi
    2032:	e8 b2 f3 ff ff       	call   13e9 <APDcCopy>
    2037:	83 c4 30             	add    $0x30,%esp
                    break;
    203a:	e9 b7 00 00 00       	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    203f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2042:	6a 0c                	push   $0xc
    2044:	6a 0c                	push   $0xc
    2046:	6a 0c                	push   $0xc
    2048:	50                   	push   %eax
    2049:	e8 3f f5 ff ff       	call   158d <RGB>
    204e:	83 c4 0c             	add    $0xc,%esp
    2051:	8b 1d dc 6b 00 00    	mov    0x6bdc,%ebx
    2057:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    205a:	6b c8 32             	imul   $0x32,%eax,%ecx
    205d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2060:	6b c0 32             	imul   $0x32,%eax,%eax
    2063:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2066:	8b 45 08             	mov    0x8(%ebp),%eax
    2069:	8d 78 3c             	lea    0x3c(%eax),%edi
    206c:	83 ec 0c             	sub    $0xc,%esp
    206f:	83 ec 04             	sub    $0x4,%esp
    2072:	89 e0                	mov    %esp,%eax
    2074:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2078:	66 89 30             	mov    %si,(%eax)
    207b:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    207f:	88 50 02             	mov    %dl,0x2(%eax)
    2082:	6a 32                	push   $0x32
    2084:	6a 32                	push   $0x32
    2086:	6a 00                	push   $0x0
    2088:	6a 00                	push   $0x0
    208a:	53                   	push   %ebx
    208b:	51                   	push   %ecx
    208c:	ff 75 94             	pushl  -0x6c(%ebp)
    208f:	57                   	push   %edi
    2090:	e8 54 f3 ff ff       	call   13e9 <APDcCopy>
    2095:	83 c4 30             	add    $0x30,%esp
                    break;
    2098:	eb 5c                	jmp    20f6 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    209a:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    209d:	6a 0c                	push   $0xc
    209f:	6a 0c                	push   $0xc
    20a1:	6a 0c                	push   $0xc
    20a3:	50                   	push   %eax
    20a4:	e8 e4 f4 ff ff       	call   158d <RGB>
    20a9:	83 c4 0c             	add    $0xc,%esp
    20ac:	8b 1d 34 6c 00 00    	mov    0x6c34,%ebx
    20b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20b5:	6b c8 32             	imul   $0x32,%eax,%ecx
    20b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20bb:	6b c0 32             	imul   $0x32,%eax,%eax
    20be:	89 45 94             	mov    %eax,-0x6c(%ebp)
    20c1:	8b 45 08             	mov    0x8(%ebp),%eax
    20c4:	8d 78 3c             	lea    0x3c(%eax),%edi
    20c7:	83 ec 0c             	sub    $0xc,%esp
    20ca:	83 ec 04             	sub    $0x4,%esp
    20cd:	89 e0                	mov    %esp,%eax
    20cf:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    20d3:	66 89 30             	mov    %si,(%eax)
    20d6:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    20da:	88 50 02             	mov    %dl,0x2(%eax)
    20dd:	6a 32                	push   $0x32
    20df:	6a 32                	push   $0x32
    20e1:	6a 00                	push   $0x0
    20e3:	6a 00                	push   $0x0
    20e5:	53                   	push   %ebx
    20e6:	51                   	push   %ecx
    20e7:	ff 75 94             	pushl  -0x6c(%ebp)
    20ea:	57                   	push   %edi
    20eb:	e8 f9 f2 ff ff       	call   13e9 <APDcCopy>
    20f0:	83 c4 30             	add    $0x30,%esp
                    break;
    20f3:	eb 01                	jmp    20f6 <APGridPaint+0x6e5>
                default: break;
    20f5:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    20f6:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    20fa:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    20fe:	0f 8e 1c fc ff ff    	jle    1d20 <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2104:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2108:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    210c:	0f 8e 02 fc ff ff    	jle    1d14 <APGridPaint+0x303>
                default: break;
            }
        }
    }
    
}
    2112:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2115:	5b                   	pop    %ebx
    2116:	5e                   	pop    %esi
    2117:	5f                   	pop    %edi
    2118:	5d                   	pop    %ebp
    2119:	c3                   	ret    

0000211a <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    211a:	55                   	push   %ebp
    211b:	89 e5                	mov    %esp,%ebp
    211d:	53                   	push   %ebx
    211e:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2121:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2124:	68 cd 00 00 00       	push   $0xcd
    2129:	6a 74                	push   $0x74
    212b:	6a 18                	push   $0x18
    212d:	50                   	push   %eax
    212e:	e8 5a f4 ff ff       	call   158d <RGB>
    2133:	83 c4 0c             	add    $0xc,%esp
    2136:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    213a:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    213e:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2142:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    2145:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    214c:	8d 45 d8             	lea    -0x28(%ebp),%eax
    214f:	68 cd 00 00 00       	push   $0xcd
    2154:	6a 74                	push   $0x74
    2156:	6a 18                	push   $0x18
    2158:	50                   	push   %eax
    2159:	e8 2f f4 ff ff       	call   158d <RGB>
    215e:	83 c4 0c             	add    $0xc,%esp
    2161:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2165:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    2169:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    216d:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    2170:	8b 45 08             	mov    0x8(%ebp),%eax
    2173:	8d 50 58             	lea    0x58(%eax),%edx
    2176:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2179:	ff 75 f4             	pushl  -0xc(%ebp)
    217c:	ff 75 f0             	pushl  -0x10(%ebp)
    217f:	52                   	push   %edx
    2180:	50                   	push   %eax
    2181:	e8 f4 ea ff ff       	call   c7a <APSetPen>
    2186:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    2189:	8b 45 08             	mov    0x8(%ebp),%eax
    218c:	8d 58 58             	lea    0x58(%eax),%ebx
    218f:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2192:	83 ec 04             	sub    $0x4,%esp
    2195:	83 ec 04             	sub    $0x4,%esp
    2198:	89 e0                	mov    %esp,%eax
    219a:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    219e:	66 89 08             	mov    %cx,(%eax)
    21a1:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    21a5:	88 48 02             	mov    %cl,0x2(%eax)
    21a8:	53                   	push   %ebx
    21a9:	52                   	push   %edx
    21aa:	e8 04 eb ff ff       	call   cb3 <APSetBrush>
    21af:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    21b2:	8b 45 08             	mov    0x8(%ebp),%eax
    21b5:	83 c0 58             	add    $0x58,%eax
    21b8:	83 ec 0c             	sub    $0xc,%esp
    21bb:	6a 32                	push   $0x32
    21bd:	68 20 03 00 00       	push   $0x320
    21c2:	6a 00                	push   $0x0
    21c4:	6a 00                	push   $0x0
    21c6:	50                   	push   %eax
    21c7:	e8 11 ef ff ff       	call   10dd <APDrawRect>
    21cc:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    21cf:	8d 45 d8             	lea    -0x28(%ebp),%eax
    21d2:	6a 08                	push   $0x8
    21d4:	6a 08                	push   $0x8
    21d6:	6a 08                	push   $0x8
    21d8:	50                   	push   %eax
    21d9:	e8 af f3 ff ff       	call   158d <RGB>
    21de:	83 c4 0c             	add    $0xc,%esp
    21e1:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    21e5:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    21e9:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    21ed:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    21f0:	8b 45 08             	mov    0x8(%ebp),%eax
    21f3:	8d 58 58             	lea    0x58(%eax),%ebx
    21f6:	8d 55 d8             	lea    -0x28(%ebp),%edx
    21f9:	83 ec 04             	sub    $0x4,%esp
    21fc:	83 ec 04             	sub    $0x4,%esp
    21ff:	89 e0                	mov    %esp,%eax
    2201:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    2205:	66 89 08             	mov    %cx,(%eax)
    2208:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    220c:	88 48 02             	mov    %cl,0x2(%eax)
    220f:	53                   	push   %ebx
    2210:	52                   	push   %edx
    2211:	e8 df ea ff ff       	call   cf5 <APSetFont>
    2216:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    2219:	8b 45 08             	mov    0x8(%ebp),%eax
    221c:	83 c0 58             	add    $0x58,%eax
    221f:	6a 14                	push   $0x14
    2221:	6a 0a                	push   $0xa
    2223:	ff 75 0c             	pushl  0xc(%ebp)
    2226:	50                   	push   %eax
    2227:	e8 b6 f0 ff ff       	call   12e2 <APDrawText>
    222c:	83 c4 10             	add    $0x10,%esp
}
    222f:	90                   	nop
    2230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2233:	c9                   	leave  
    2234:	c3                   	ret    

00002235 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2235:	55                   	push   %ebp
    2236:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2238:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    223c:	7e 08                	jle    2246 <random+0x11>
{
rand_num = seed;
    223e:	8b 45 08             	mov    0x8(%ebp),%eax
    2241:	a3 80 69 00 00       	mov    %eax,0x6980
}
rand_num *= 3;
    2246:	8b 15 80 69 00 00    	mov    0x6980,%edx
    224c:	89 d0                	mov    %edx,%eax
    224e:	01 c0                	add    %eax,%eax
    2250:	01 d0                	add    %edx,%eax
    2252:	a3 80 69 00 00       	mov    %eax,0x6980
if (rand_num < 0)
    2257:	a1 80 69 00 00       	mov    0x6980,%eax
    225c:	85 c0                	test   %eax,%eax
    225e:	79 0c                	jns    226c <random+0x37>
{
rand_num *= (-1);
    2260:	a1 80 69 00 00       	mov    0x6980,%eax
    2265:	f7 d8                	neg    %eax
    2267:	a3 80 69 00 00       	mov    %eax,0x6980
}
return rand_num % 997;
    226c:	8b 0d 80 69 00 00    	mov    0x6980,%ecx
    2272:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2277:	89 c8                	mov    %ecx,%eax
    2279:	f7 ea                	imul   %edx
    227b:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    227e:	c1 f8 09             	sar    $0x9,%eax
    2281:	89 c2                	mov    %eax,%edx
    2283:	89 c8                	mov    %ecx,%eax
    2285:	c1 f8 1f             	sar    $0x1f,%eax
    2288:	29 c2                	sub    %eax,%edx
    228a:	89 d0                	mov    %edx,%eax
    228c:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2292:	29 c1                	sub    %eax,%ecx
    2294:	89 c8                	mov    %ecx,%eax
}
    2296:	5d                   	pop    %ebp
    2297:	c3                   	ret    

00002298 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2298:	55                   	push   %ebp
    2299:	89 e5                	mov    %esp,%ebp
    229b:	53                   	push   %ebx
    229c:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    229f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    22a6:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    22aa:	74 17                	je     22c3 <sprintint+0x2b>
    22ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    22b0:	79 11                	jns    22c3 <sprintint+0x2b>
        neg = 1;
    22b2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    22b9:	8b 45 10             	mov    0x10(%ebp),%eax
    22bc:	f7 d8                	neg    %eax
    22be:	89 45 f0             	mov    %eax,-0x10(%ebp)
    22c1:	eb 06                	jmp    22c9 <sprintint+0x31>
    } else {
        x = xx;
    22c3:	8b 45 10             	mov    0x10(%ebp),%eax
    22c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    22c9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    22d0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    22d3:	8d 41 01             	lea    0x1(%ecx),%eax
    22d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    22d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
    22dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22df:	ba 00 00 00 00       	mov    $0x0,%edx
    22e4:	f7 f3                	div    %ebx
    22e6:	89 d0                	mov    %edx,%eax
    22e8:	0f b6 80 84 69 00 00 	movzbl 0x6984(%eax),%eax
    22ef:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    22f3:	8b 5d 14             	mov    0x14(%ebp),%ebx
    22f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22f9:	ba 00 00 00 00       	mov    $0x0,%edx
    22fe:	f7 f3                	div    %ebx
    2300:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2303:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2307:	75 c7                	jne    22d0 <sprintint+0x38>
    if(neg)
    2309:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    230d:	74 0e                	je     231d <sprintint+0x85>
        buf[i++] = '-';
    230f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2312:	8d 50 01             	lea    0x1(%eax),%edx
    2315:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2318:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    231d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2320:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2323:	eb 1b                	jmp    2340 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2325:	8b 45 0c             	mov    0xc(%ebp),%eax
    2328:	8b 00                	mov    (%eax),%eax
    232a:	8d 48 01             	lea    0x1(%eax),%ecx
    232d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2330:	89 0a                	mov    %ecx,(%edx)
    2332:	89 c2                	mov    %eax,%edx
    2334:	8b 45 08             	mov    0x8(%ebp),%eax
    2337:	01 d0                	add    %edx,%eax
    2339:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    233c:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2340:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2344:	7f df                	jg     2325 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2346:	eb 21                	jmp    2369 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2348:	8b 45 0c             	mov    0xc(%ebp),%eax
    234b:	8b 00                	mov    (%eax),%eax
    234d:	8d 48 01             	lea    0x1(%eax),%ecx
    2350:	8b 55 0c             	mov    0xc(%ebp),%edx
    2353:	89 0a                	mov    %ecx,(%edx)
    2355:	89 c2                	mov    %eax,%edx
    2357:	8b 45 08             	mov    0x8(%ebp),%eax
    235a:	01 c2                	add    %eax,%edx
    235c:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    235f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2362:	01 c8                	add    %ecx,%eax
    2364:	0f b6 00             	movzbl (%eax),%eax
    2367:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2369:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    236d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2371:	79 d5                	jns    2348 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2373:	90                   	nop
    2374:	83 c4 20             	add    $0x20,%esp
    2377:	5b                   	pop    %ebx
    2378:	5d                   	pop    %ebp
    2379:	c3                   	ret    

0000237a <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    237a:	55                   	push   %ebp
    237b:	89 e5                	mov    %esp,%ebp
    237d:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2380:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2387:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    238e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2395:	8d 45 0c             	lea    0xc(%ebp),%eax
    2398:	83 c0 04             	add    $0x4,%eax
    239b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    239e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    23a5:	e9 d9 01 00 00       	jmp    2583 <sprintf+0x209>
        c = fmt[i] & 0xff;
    23aa:	8b 55 0c             	mov    0xc(%ebp),%edx
    23ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23b0:	01 d0                	add    %edx,%eax
    23b2:	0f b6 00             	movzbl (%eax),%eax
    23b5:	0f be c0             	movsbl %al,%eax
    23b8:	25 ff 00 00 00       	and    $0xff,%eax
    23bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    23c0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    23c4:	75 2c                	jne    23f2 <sprintf+0x78>
            if(c == '%'){
    23c6:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    23ca:	75 0c                	jne    23d8 <sprintf+0x5e>
                state = '%';
    23cc:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    23d3:	e9 a7 01 00 00       	jmp    257f <sprintf+0x205>
            } else {
                dst[j++] = c;
    23d8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23db:	8d 50 01             	lea    0x1(%eax),%edx
    23de:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23e1:	89 c2                	mov    %eax,%edx
    23e3:	8b 45 08             	mov    0x8(%ebp),%eax
    23e6:	01 d0                	add    %edx,%eax
    23e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23eb:	88 10                	mov    %dl,(%eax)
    23ed:	e9 8d 01 00 00       	jmp    257f <sprintf+0x205>
            }
        } else if(state == '%'){
    23f2:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    23f6:	0f 85 83 01 00 00    	jne    257f <sprintf+0x205>
            if(c == 'd'){
    23fc:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2400:	75 4c                	jne    244e <sprintf+0xd4>
                buf[bi] = '\0';
    2402:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2405:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2408:	01 d0                	add    %edx,%eax
    240a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    240d:	83 ec 0c             	sub    $0xc,%esp
    2410:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2413:	50                   	push   %eax
    2414:	e8 bb de ff ff       	call   2d4 <atoi>
    2419:	83 c4 10             	add    $0x10,%esp
    241c:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    241f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2426:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2429:	8b 00                	mov    (%eax),%eax
    242b:	83 ec 08             	sub    $0x8,%esp
    242e:	ff 75 d8             	pushl  -0x28(%ebp)
    2431:	6a 01                	push   $0x1
    2433:	6a 0a                	push   $0xa
    2435:	50                   	push   %eax
    2436:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2439:	50                   	push   %eax
    243a:	ff 75 08             	pushl  0x8(%ebp)
    243d:	e8 56 fe ff ff       	call   2298 <sprintint>
    2442:	83 c4 20             	add    $0x20,%esp
                ap++;
    2445:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2449:	e9 2a 01 00 00       	jmp    2578 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    244e:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2452:	74 06                	je     245a <sprintf+0xe0>
    2454:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2458:	75 4c                	jne    24a6 <sprintf+0x12c>
                buf[bi] = '\0';
    245a:	8d 55 ce             	lea    -0x32(%ebp),%edx
    245d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2460:	01 d0                	add    %edx,%eax
    2462:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2465:	83 ec 0c             	sub    $0xc,%esp
    2468:	8d 45 ce             	lea    -0x32(%ebp),%eax
    246b:	50                   	push   %eax
    246c:	e8 63 de ff ff       	call   2d4 <atoi>
    2471:	83 c4 10             	add    $0x10,%esp
    2474:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2477:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    247e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2481:	8b 00                	mov    (%eax),%eax
    2483:	83 ec 08             	sub    $0x8,%esp
    2486:	ff 75 dc             	pushl  -0x24(%ebp)
    2489:	6a 00                	push   $0x0
    248b:	6a 10                	push   $0x10
    248d:	50                   	push   %eax
    248e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2491:	50                   	push   %eax
    2492:	ff 75 08             	pushl  0x8(%ebp)
    2495:	e8 fe fd ff ff       	call   2298 <sprintint>
    249a:	83 c4 20             	add    $0x20,%esp
                ap++;
    249d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    24a1:	e9 d2 00 00 00       	jmp    2578 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    24a6:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    24aa:	75 46                	jne    24f2 <sprintf+0x178>
                s = (char*)*ap;
    24ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    24af:	8b 00                	mov    (%eax),%eax
    24b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    24b4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    24b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24bc:	75 25                	jne    24e3 <sprintf+0x169>
                    s = "(null)";
    24be:	c7 45 f4 64 27 00 00 	movl   $0x2764,-0xc(%ebp)
                while(*s != 0){
    24c5:	eb 1c                	jmp    24e3 <sprintf+0x169>
                    dst[j++] = *s;
    24c7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24ca:	8d 50 01             	lea    0x1(%eax),%edx
    24cd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24d0:	89 c2                	mov    %eax,%edx
    24d2:	8b 45 08             	mov    0x8(%ebp),%eax
    24d5:	01 c2                	add    %eax,%edx
    24d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24da:	0f b6 00             	movzbl (%eax),%eax
    24dd:	88 02                	mov    %al,(%edx)
                    s++;
    24df:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    24e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    24e6:	0f b6 00             	movzbl (%eax),%eax
    24e9:	84 c0                	test   %al,%al
    24eb:	75 da                	jne    24c7 <sprintf+0x14d>
    24ed:	e9 86 00 00 00       	jmp    2578 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    24f2:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    24f6:	75 1d                	jne    2515 <sprintf+0x19b>
                dst[j++] = *ap;
    24f8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24fb:	8d 50 01             	lea    0x1(%eax),%edx
    24fe:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2501:	89 c2                	mov    %eax,%edx
    2503:	8b 45 08             	mov    0x8(%ebp),%eax
    2506:	01 c2                	add    %eax,%edx
    2508:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    250b:	8b 00                	mov    (%eax),%eax
    250d:	88 02                	mov    %al,(%edx)
                ap++;
    250f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2513:	eb 63                	jmp    2578 <sprintf+0x1fe>
            } else if(c == '%'){
    2515:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2519:	75 17                	jne    2532 <sprintf+0x1b8>
                dst[j++] = c;
    251b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    251e:	8d 50 01             	lea    0x1(%eax),%edx
    2521:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2524:	89 c2                	mov    %eax,%edx
    2526:	8b 45 08             	mov    0x8(%ebp),%eax
    2529:	01 d0                	add    %edx,%eax
    252b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    252e:	88 10                	mov    %dl,(%eax)
    2530:	eb 46                	jmp    2578 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2532:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2536:	7e 18                	jle    2550 <sprintf+0x1d6>
    2538:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    253c:	7f 12                	jg     2550 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    253e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2541:	8d 50 01             	lea    0x1(%eax),%edx
    2544:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2547:	8b 55 e0             	mov    -0x20(%ebp),%edx
    254a:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    254e:	eb 2f                	jmp    257f <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2550:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2553:	8d 50 01             	lea    0x1(%eax),%edx
    2556:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2559:	89 c2                	mov    %eax,%edx
    255b:	8b 45 08             	mov    0x8(%ebp),%eax
    255e:	01 d0                	add    %edx,%eax
    2560:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2563:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2566:	8d 50 01             	lea    0x1(%eax),%edx
    2569:	89 55 c8             	mov    %edx,-0x38(%ebp)
    256c:	89 c2                	mov    %eax,%edx
    256e:	8b 45 08             	mov    0x8(%ebp),%eax
    2571:	01 d0                	add    %edx,%eax
    2573:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2576:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2578:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    257f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2583:	8b 55 0c             	mov    0xc(%ebp),%edx
    2586:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2589:	01 d0                	add    %edx,%eax
    258b:	0f b6 00             	movzbl (%eax),%eax
    258e:	84 c0                	test   %al,%al
    2590:	0f 85 14 fe ff ff    	jne    23aa <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2596:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2599:	8d 50 01             	lea    0x1(%eax),%edx
    259c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    259f:	89 c2                	mov    %eax,%edx
    25a1:	8b 45 08             	mov    0x8(%ebp),%eax
    25a4:	01 d0                	add    %edx,%eax
    25a6:	c6 00 00             	movb   $0x0,(%eax)
}
    25a9:	90                   	nop
    25aa:	c9                   	leave  
    25ab:	c3                   	ret    
