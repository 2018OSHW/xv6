
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
      47:	68 50 21 00 00       	push   $0x2150
      4c:	6a 01                	push   $0x1
      4e:	e8 ba 04 00 00       	call   50d <printf>
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
      cf:	68 61 21 00 00       	push   $0x2161
      d4:	6a 01                	push   $0x1
      d6:	e8 32 04 00 00       	call   50d <printf>
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

0000042e <changePosition>:
SYSCALL(changePosition)
     42e:	b8 1b 00 00 00       	mov    $0x1b,%eax
     433:	cd 40                	int    $0x40
     435:	c3                   	ret    

00000436 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     436:	55                   	push   %ebp
     437:	89 e5                	mov    %esp,%ebp
     439:	83 ec 18             	sub    $0x18,%esp
     43c:	8b 45 0c             	mov    0xc(%ebp),%eax
     43f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     442:	83 ec 04             	sub    $0x4,%esp
     445:	6a 01                	push   $0x1
     447:	8d 45 f4             	lea    -0xc(%ebp),%eax
     44a:	50                   	push   %eax
     44b:	ff 75 08             	pushl  0x8(%ebp)
     44e:	e8 33 ff ff ff       	call   386 <write>
     453:	83 c4 10             	add    $0x10,%esp
}
     456:	90                   	nop
     457:	c9                   	leave  
     458:	c3                   	ret    

00000459 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     459:	55                   	push   %ebp
     45a:	89 e5                	mov    %esp,%ebp
     45c:	53                   	push   %ebx
     45d:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     460:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     467:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     46b:	74 17                	je     484 <printint+0x2b>
     46d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     471:	79 11                	jns    484 <printint+0x2b>
    neg = 1;
     473:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     47a:	8b 45 0c             	mov    0xc(%ebp),%eax
     47d:	f7 d8                	neg    %eax
     47f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     482:	eb 06                	jmp    48a <printint+0x31>
  } else {
    x = xx;
     484:	8b 45 0c             	mov    0xc(%ebp),%eax
     487:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     48a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     491:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     494:	8d 41 01             	lea    0x1(%ecx),%eax
     497:	89 45 f4             	mov    %eax,-0xc(%ebp)
     49a:	8b 5d 10             	mov    0x10(%ebp),%ebx
     49d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4a0:	ba 00 00 00 00       	mov    $0x0,%edx
     4a5:	f7 f3                	div    %ebx
     4a7:	89 d0                	mov    %edx,%eax
     4a9:	0f b6 80 24 28 00 00 	movzbl 0x2824(%eax),%eax
     4b0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4b4:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4ba:	ba 00 00 00 00       	mov    $0x0,%edx
     4bf:	f7 f3                	div    %ebx
     4c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4c8:	75 c7                	jne    491 <printint+0x38>
  if(neg)
     4ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4ce:	74 2d                	je     4fd <printint+0xa4>
    buf[i++] = '-';
     4d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4d3:	8d 50 01             	lea    0x1(%eax),%edx
     4d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4d9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4de:	eb 1d                	jmp    4fd <printint+0xa4>
    putc(fd, buf[i]);
     4e0:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e6:	01 d0                	add    %edx,%eax
     4e8:	0f b6 00             	movzbl (%eax),%eax
     4eb:	0f be c0             	movsbl %al,%eax
     4ee:	83 ec 08             	sub    $0x8,%esp
     4f1:	50                   	push   %eax
     4f2:	ff 75 08             	pushl  0x8(%ebp)
     4f5:	e8 3c ff ff ff       	call   436 <putc>
     4fa:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     4fd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     501:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     505:	79 d9                	jns    4e0 <printint+0x87>
    putc(fd, buf[i]);
}
     507:	90                   	nop
     508:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     50b:	c9                   	leave  
     50c:	c3                   	ret    

0000050d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     50d:	55                   	push   %ebp
     50e:	89 e5                	mov    %esp,%ebp
     510:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     513:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     51a:	8d 45 0c             	lea    0xc(%ebp),%eax
     51d:	83 c0 04             	add    $0x4,%eax
     520:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     523:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     52a:	e9 59 01 00 00       	jmp    688 <printf+0x17b>
    c = fmt[i] & 0xff;
     52f:	8b 55 0c             	mov    0xc(%ebp),%edx
     532:	8b 45 f0             	mov    -0x10(%ebp),%eax
     535:	01 d0                	add    %edx,%eax
     537:	0f b6 00             	movzbl (%eax),%eax
     53a:	0f be c0             	movsbl %al,%eax
     53d:	25 ff 00 00 00       	and    $0xff,%eax
     542:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     545:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     549:	75 2c                	jne    577 <printf+0x6a>
      if(c == '%'){
     54b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     54f:	75 0c                	jne    55d <printf+0x50>
        state = '%';
     551:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     558:	e9 27 01 00 00       	jmp    684 <printf+0x177>
      } else {
        putc(fd, c);
     55d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     560:	0f be c0             	movsbl %al,%eax
     563:	83 ec 08             	sub    $0x8,%esp
     566:	50                   	push   %eax
     567:	ff 75 08             	pushl  0x8(%ebp)
     56a:	e8 c7 fe ff ff       	call   436 <putc>
     56f:	83 c4 10             	add    $0x10,%esp
     572:	e9 0d 01 00 00       	jmp    684 <printf+0x177>
      }
    } else if(state == '%'){
     577:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     57b:	0f 85 03 01 00 00    	jne    684 <printf+0x177>
      if(c == 'd'){
     581:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     585:	75 1e                	jne    5a5 <printf+0x98>
        printint(fd, *ap, 10, 1);
     587:	8b 45 e8             	mov    -0x18(%ebp),%eax
     58a:	8b 00                	mov    (%eax),%eax
     58c:	6a 01                	push   $0x1
     58e:	6a 0a                	push   $0xa
     590:	50                   	push   %eax
     591:	ff 75 08             	pushl  0x8(%ebp)
     594:	e8 c0 fe ff ff       	call   459 <printint>
     599:	83 c4 10             	add    $0x10,%esp
        ap++;
     59c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5a0:	e9 d8 00 00 00       	jmp    67d <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5a5:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5a9:	74 06                	je     5b1 <printf+0xa4>
     5ab:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5af:	75 1e                	jne    5cf <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5b4:	8b 00                	mov    (%eax),%eax
     5b6:	6a 00                	push   $0x0
     5b8:	6a 10                	push   $0x10
     5ba:	50                   	push   %eax
     5bb:	ff 75 08             	pushl  0x8(%ebp)
     5be:	e8 96 fe ff ff       	call   459 <printint>
     5c3:	83 c4 10             	add    $0x10,%esp
        ap++;
     5c6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ca:	e9 ae 00 00 00       	jmp    67d <printf+0x170>
      } else if(c == 's'){
     5cf:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5d3:	75 43                	jne    618 <printf+0x10b>
        s = (char*)*ap;
     5d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d8:	8b 00                	mov    (%eax),%eax
     5da:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5e5:	75 25                	jne    60c <printf+0xff>
          s = "(null)";
     5e7:	c7 45 f4 76 21 00 00 	movl   $0x2176,-0xc(%ebp)
        while(*s != 0){
     5ee:	eb 1c                	jmp    60c <printf+0xff>
          putc(fd, *s);
     5f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f3:	0f b6 00             	movzbl (%eax),%eax
     5f6:	0f be c0             	movsbl %al,%eax
     5f9:	83 ec 08             	sub    $0x8,%esp
     5fc:	50                   	push   %eax
     5fd:	ff 75 08             	pushl  0x8(%ebp)
     600:	e8 31 fe ff ff       	call   436 <putc>
     605:	83 c4 10             	add    $0x10,%esp
          s++;
     608:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     60c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60f:	0f b6 00             	movzbl (%eax),%eax
     612:	84 c0                	test   %al,%al
     614:	75 da                	jne    5f0 <printf+0xe3>
     616:	eb 65                	jmp    67d <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     618:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     61c:	75 1d                	jne    63b <printf+0x12e>
        putc(fd, *ap);
     61e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     621:	8b 00                	mov    (%eax),%eax
     623:	0f be c0             	movsbl %al,%eax
     626:	83 ec 08             	sub    $0x8,%esp
     629:	50                   	push   %eax
     62a:	ff 75 08             	pushl  0x8(%ebp)
     62d:	e8 04 fe ff ff       	call   436 <putc>
     632:	83 c4 10             	add    $0x10,%esp
        ap++;
     635:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     639:	eb 42                	jmp    67d <printf+0x170>
      } else if(c == '%'){
     63b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     63f:	75 17                	jne    658 <printf+0x14b>
        putc(fd, c);
     641:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     644:	0f be c0             	movsbl %al,%eax
     647:	83 ec 08             	sub    $0x8,%esp
     64a:	50                   	push   %eax
     64b:	ff 75 08             	pushl  0x8(%ebp)
     64e:	e8 e3 fd ff ff       	call   436 <putc>
     653:	83 c4 10             	add    $0x10,%esp
     656:	eb 25                	jmp    67d <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     658:	83 ec 08             	sub    $0x8,%esp
     65b:	6a 25                	push   $0x25
     65d:	ff 75 08             	pushl  0x8(%ebp)
     660:	e8 d1 fd ff ff       	call   436 <putc>
     665:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     668:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     66b:	0f be c0             	movsbl %al,%eax
     66e:	83 ec 08             	sub    $0x8,%esp
     671:	50                   	push   %eax
     672:	ff 75 08             	pushl  0x8(%ebp)
     675:	e8 bc fd ff ff       	call   436 <putc>
     67a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     67d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     684:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     688:	8b 55 0c             	mov    0xc(%ebp),%edx
     68b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     68e:	01 d0                	add    %edx,%eax
     690:	0f b6 00             	movzbl (%eax),%eax
     693:	84 c0                	test   %al,%al
     695:	0f 85 94 fe ff ff    	jne    52f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     69b:	90                   	nop
     69c:	c9                   	leave  
     69d:	c3                   	ret    

0000069e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     69e:	55                   	push   %ebp
     69f:	89 e5                	mov    %esp,%ebp
     6a1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6a4:	8b 45 08             	mov    0x8(%ebp),%eax
     6a7:	83 e8 08             	sub    $0x8,%eax
     6aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6ad:	a1 68 28 00 00       	mov    0x2868,%eax
     6b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6b5:	eb 24                	jmp    6db <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ba:	8b 00                	mov    (%eax),%eax
     6bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6bf:	77 12                	ja     6d3 <free+0x35>
     6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6c7:	77 24                	ja     6ed <free+0x4f>
     6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cc:	8b 00                	mov    (%eax),%eax
     6ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6d1:	77 1a                	ja     6ed <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	8b 00                	mov    (%eax),%eax
     6d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6e1:	76 d4                	jbe    6b7 <free+0x19>
     6e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e6:	8b 00                	mov    (%eax),%eax
     6e8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6eb:	76 ca                	jbe    6b7 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     6ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f0:	8b 40 04             	mov    0x4(%eax),%eax
     6f3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fd:	01 c2                	add    %eax,%edx
     6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     702:	8b 00                	mov    (%eax),%eax
     704:	39 c2                	cmp    %eax,%edx
     706:	75 24                	jne    72c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     708:	8b 45 f8             	mov    -0x8(%ebp),%eax
     70b:	8b 50 04             	mov    0x4(%eax),%edx
     70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     711:	8b 00                	mov    (%eax),%eax
     713:	8b 40 04             	mov    0x4(%eax),%eax
     716:	01 c2                	add    %eax,%edx
     718:	8b 45 f8             	mov    -0x8(%ebp),%eax
     71b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     721:	8b 00                	mov    (%eax),%eax
     723:	8b 10                	mov    (%eax),%edx
     725:	8b 45 f8             	mov    -0x8(%ebp),%eax
     728:	89 10                	mov    %edx,(%eax)
     72a:	eb 0a                	jmp    736 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     72c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     72f:	8b 10                	mov    (%eax),%edx
     731:	8b 45 f8             	mov    -0x8(%ebp),%eax
     734:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     736:	8b 45 fc             	mov    -0x4(%ebp),%eax
     739:	8b 40 04             	mov    0x4(%eax),%eax
     73c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     743:	8b 45 fc             	mov    -0x4(%ebp),%eax
     746:	01 d0                	add    %edx,%eax
     748:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     74b:	75 20                	jne    76d <free+0xcf>
    p->s.size += bp->s.size;
     74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     750:	8b 50 04             	mov    0x4(%eax),%edx
     753:	8b 45 f8             	mov    -0x8(%ebp),%eax
     756:	8b 40 04             	mov    0x4(%eax),%eax
     759:	01 c2                	add    %eax,%edx
     75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     761:	8b 45 f8             	mov    -0x8(%ebp),%eax
     764:	8b 10                	mov    (%eax),%edx
     766:	8b 45 fc             	mov    -0x4(%ebp),%eax
     769:	89 10                	mov    %edx,(%eax)
     76b:	eb 08                	jmp    775 <free+0xd7>
  } else
    p->s.ptr = bp;
     76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     770:	8b 55 f8             	mov    -0x8(%ebp),%edx
     773:	89 10                	mov    %edx,(%eax)
  freep = p;
     775:	8b 45 fc             	mov    -0x4(%ebp),%eax
     778:	a3 68 28 00 00       	mov    %eax,0x2868
}
     77d:	90                   	nop
     77e:	c9                   	leave  
     77f:	c3                   	ret    

00000780 <morecore>:

static Header*
morecore(uint nu)
{
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     786:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     78d:	77 07                	ja     796 <morecore+0x16>
    nu = 4096;
     78f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     796:	8b 45 08             	mov    0x8(%ebp),%eax
     799:	c1 e0 03             	shl    $0x3,%eax
     79c:	83 ec 0c             	sub    $0xc,%esp
     79f:	50                   	push   %eax
     7a0:	e8 49 fc ff ff       	call   3ee <sbrk>
     7a5:	83 c4 10             	add    $0x10,%esp
     7a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7ab:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7af:	75 07                	jne    7b8 <morecore+0x38>
    return 0;
     7b1:	b8 00 00 00 00       	mov    $0x0,%eax
     7b6:	eb 26                	jmp    7de <morecore+0x5e>
  hp = (Header*)p;
     7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7be:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c1:	8b 55 08             	mov    0x8(%ebp),%edx
     7c4:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ca:	83 c0 08             	add    $0x8,%eax
     7cd:	83 ec 0c             	sub    $0xc,%esp
     7d0:	50                   	push   %eax
     7d1:	e8 c8 fe ff ff       	call   69e <free>
     7d6:	83 c4 10             	add    $0x10,%esp
  return freep;
     7d9:	a1 68 28 00 00       	mov    0x2868,%eax
}
     7de:	c9                   	leave  
     7df:	c3                   	ret    

000007e0 <malloc>:

void*
malloc(uint nbytes)
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7e6:	8b 45 08             	mov    0x8(%ebp),%eax
     7e9:	83 c0 07             	add    $0x7,%eax
     7ec:	c1 e8 03             	shr    $0x3,%eax
     7ef:	83 c0 01             	add    $0x1,%eax
     7f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7f5:	a1 68 28 00 00       	mov    0x2868,%eax
     7fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7fd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     801:	75 23                	jne    826 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     803:	c7 45 f0 60 28 00 00 	movl   $0x2860,-0x10(%ebp)
     80a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     80d:	a3 68 28 00 00       	mov    %eax,0x2868
     812:	a1 68 28 00 00       	mov    0x2868,%eax
     817:	a3 60 28 00 00       	mov    %eax,0x2860
    base.s.size = 0;
     81c:	c7 05 64 28 00 00 00 	movl   $0x0,0x2864
     823:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     826:	8b 45 f0             	mov    -0x10(%ebp),%eax
     829:	8b 00                	mov    (%eax),%eax
     82b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     82e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     831:	8b 40 04             	mov    0x4(%eax),%eax
     834:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     837:	72 4d                	jb     886 <malloc+0xa6>
      if(p->s.size == nunits)
     839:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83c:	8b 40 04             	mov    0x4(%eax),%eax
     83f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     842:	75 0c                	jne    850 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     844:	8b 45 f4             	mov    -0xc(%ebp),%eax
     847:	8b 10                	mov    (%eax),%edx
     849:	8b 45 f0             	mov    -0x10(%ebp),%eax
     84c:	89 10                	mov    %edx,(%eax)
     84e:	eb 26                	jmp    876 <malloc+0x96>
      else {
        p->s.size -= nunits;
     850:	8b 45 f4             	mov    -0xc(%ebp),%eax
     853:	8b 40 04             	mov    0x4(%eax),%eax
     856:	2b 45 ec             	sub    -0x14(%ebp),%eax
     859:	89 c2                	mov    %eax,%edx
     85b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     861:	8b 45 f4             	mov    -0xc(%ebp),%eax
     864:	8b 40 04             	mov    0x4(%eax),%eax
     867:	c1 e0 03             	shl    $0x3,%eax
     86a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     86d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     870:	8b 55 ec             	mov    -0x14(%ebp),%edx
     873:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     876:	8b 45 f0             	mov    -0x10(%ebp),%eax
     879:	a3 68 28 00 00       	mov    %eax,0x2868
      return (void*)(p + 1);
     87e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     881:	83 c0 08             	add    $0x8,%eax
     884:	eb 3b                	jmp    8c1 <malloc+0xe1>
    }
    if(p == freep)
     886:	a1 68 28 00 00       	mov    0x2868,%eax
     88b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     88e:	75 1e                	jne    8ae <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     890:	83 ec 0c             	sub    $0xc,%esp
     893:	ff 75 ec             	pushl  -0x14(%ebp)
     896:	e8 e5 fe ff ff       	call   780 <morecore>
     89b:	83 c4 10             	add    $0x10,%esp
     89e:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8a5:	75 07                	jne    8ae <malloc+0xce>
        return 0;
     8a7:	b8 00 00 00 00       	mov    $0x0,%eax
     8ac:	eb 13                	jmp    8c1 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b7:	8b 00                	mov    (%eax),%eax
     8b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8bc:	e9 6d ff ff ff       	jmp    82e <malloc+0x4e>
}
     8c1:	c9                   	leave  
     8c2:	c3                   	ret    

000008c3 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8c3:	55                   	push   %ebp
     8c4:	89 e5                	mov    %esp,%ebp
     8c6:	83 ec 1c             	sub    $0x1c,%esp
     8c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8cc:	8b 55 10             	mov    0x10(%ebp),%edx
     8cf:	8b 45 14             	mov    0x14(%ebp),%eax
     8d2:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8d5:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8d8:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8db:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8df:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8e2:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8e6:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     8e9:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     8ed:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     8f0:	8b 45 08             	mov    0x8(%ebp),%eax
     8f3:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     8f7:	66 89 10             	mov    %dx,(%eax)
     8fa:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     8fe:	88 50 02             	mov    %dl,0x2(%eax)
}
     901:	8b 45 08             	mov    0x8(%ebp),%eax
     904:	c9                   	leave  
     905:	c2 04 00             	ret    $0x4

00000908 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     908:	55                   	push   %ebp
     909:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     90b:	8b 45 08             	mov    0x8(%ebp),%eax
     90e:	2b 45 10             	sub    0x10(%ebp),%eax
     911:	89 c2                	mov    %eax,%edx
     913:	8b 45 08             	mov    0x8(%ebp),%eax
     916:	2b 45 10             	sub    0x10(%ebp),%eax
     919:	0f af d0             	imul   %eax,%edx
     91c:	8b 45 0c             	mov    0xc(%ebp),%eax
     91f:	2b 45 14             	sub    0x14(%ebp),%eax
     922:	89 c1                	mov    %eax,%ecx
     924:	8b 45 0c             	mov    0xc(%ebp),%eax
     927:	2b 45 14             	sub    0x14(%ebp),%eax
     92a:	0f af c1             	imul   %ecx,%eax
     92d:	01 d0                	add    %edx,%eax
}
     92f:	5d                   	pop    %ebp
     930:	c3                   	ret    

00000931 <abs_int>:

static inline int abs_int(int x)
{
     931:	55                   	push   %ebp
     932:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     934:	8b 45 08             	mov    0x8(%ebp),%eax
     937:	99                   	cltd   
     938:	89 d0                	mov    %edx,%eax
     93a:	33 45 08             	xor    0x8(%ebp),%eax
     93d:	29 d0                	sub    %edx,%eax
}
     93f:	5d                   	pop    %ebp
     940:	c3                   	ret    

00000941 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     941:	55                   	push   %ebp
     942:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     944:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     948:	79 07                	jns    951 <APGetIndex+0x10>
        return X_SMALLER;
     94a:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     94f:	eb 40                	jmp    991 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     951:	8b 45 08             	mov    0x8(%ebp),%eax
     954:	8b 00                	mov    (%eax),%eax
     956:	3b 45 0c             	cmp    0xc(%ebp),%eax
     959:	7f 07                	jg     962 <APGetIndex+0x21>
        return X_BIGGER;
     95b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     960:	eb 2f                	jmp    991 <APGetIndex+0x50>
    if (y < 0)
     962:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     966:	79 07                	jns    96f <APGetIndex+0x2e>
        return Y_SMALLER;
     968:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     96d:	eb 22                	jmp    991 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     96f:	8b 45 08             	mov    0x8(%ebp),%eax
     972:	8b 40 04             	mov    0x4(%eax),%eax
     975:	3b 45 10             	cmp    0x10(%ebp),%eax
     978:	7f 07                	jg     981 <APGetIndex+0x40>
        return Y_BIGGER;
     97a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     97f:	eb 10                	jmp    991 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     981:	8b 45 08             	mov    0x8(%ebp),%eax
     984:	8b 00                	mov    (%eax),%eax
     986:	0f af 45 10          	imul   0x10(%ebp),%eax
     98a:	89 c2                	mov    %eax,%edx
     98c:	8b 45 0c             	mov    0xc(%ebp),%eax
     98f:	01 d0                	add    %edx,%eax
}
     991:	5d                   	pop    %ebp
     992:	c3                   	ret    

00000993 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     993:	55                   	push   %ebp
     994:	89 e5                	mov    %esp,%ebp
     996:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     999:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9a0:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9a3:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9a6:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9ad:	83 ec 08             	sub    $0x8,%esp
     9b0:	6a 00                	push   $0x0
     9b2:	ff 75 0c             	pushl  0xc(%ebp)
     9b5:	e8 ec f9 ff ff       	call   3a6 <open>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9c4:	79 2e                	jns    9f4 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9c6:	83 ec 04             	sub    $0x4,%esp
     9c9:	ff 75 0c             	pushl  0xc(%ebp)
     9cc:	68 7d 21 00 00       	push   $0x217d
     9d1:	6a 01                	push   $0x1
     9d3:	e8 35 fb ff ff       	call   50d <printf>
     9d8:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9db:	8b 45 08             	mov    0x8(%ebp),%eax
     9de:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9e1:	89 10                	mov    %edx,(%eax)
     9e3:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9e6:	89 50 04             	mov    %edx,0x4(%eax)
     9e9:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9ec:	89 50 08             	mov    %edx,0x8(%eax)
     9ef:	e9 d2 01 00 00       	jmp    bc6 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9f4:	83 ec 04             	sub    $0x4,%esp
     9f7:	6a 0e                	push   $0xe
     9f9:	8d 45 ba             	lea    -0x46(%ebp),%eax
     9fc:	50                   	push   %eax
     9fd:	ff 75 ec             	pushl  -0x14(%ebp)
     a00:	e8 79 f9 ff ff       	call   37e <read>
     a05:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a08:	83 ec 04             	sub    $0x4,%esp
     a0b:	6a 28                	push   $0x28
     a0d:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a10:	50                   	push   %eax
     a11:	ff 75 ec             	pushl  -0x14(%ebp)
     a14:	e8 65 f9 ff ff       	call   37e <read>
     a19:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a1c:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a1f:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a22:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a25:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a28:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a2b:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a2e:	0f af d0             	imul   %eax,%edx
     a31:	89 d0                	mov    %edx,%eax
     a33:	01 c0                	add    %eax,%eax
     a35:	01 d0                	add    %edx,%eax
     a37:	83 ec 0c             	sub    $0xc,%esp
     a3a:	50                   	push   %eax
     a3b:	e8 a0 fd ff ff       	call   7e0 <malloc>
     a40:	83 c4 10             	add    $0x10,%esp
     a43:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a46:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a4a:	0f b7 c0             	movzwl %ax,%eax
     a4d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a50:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a53:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a56:	0f af c2             	imul   %edx,%eax
     a59:	83 c0 1f             	add    $0x1f,%eax
     a5c:	c1 e8 05             	shr    $0x5,%eax
     a5f:	c1 e0 02             	shl    $0x2,%eax
     a62:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a65:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a6b:	0f af c2             	imul   %edx,%eax
     a6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a71:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a74:	83 ec 0c             	sub    $0xc,%esp
     a77:	50                   	push   %eax
     a78:	e8 63 fd ff ff       	call   7e0 <malloc>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a83:	83 ec 04             	sub    $0x4,%esp
     a86:	ff 75 e0             	pushl  -0x20(%ebp)
     a89:	ff 75 dc             	pushl  -0x24(%ebp)
     a8c:	ff 75 ec             	pushl  -0x14(%ebp)
     a8f:	e8 ea f8 ff ff       	call   37e <read>
     a94:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a97:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a9b:	66 c1 e8 03          	shr    $0x3,%ax
     a9f:	0f b7 c0             	movzwl %ax,%eax
     aa2:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     aa5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aac:	e9 e5 00 00 00       	jmp    b96 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ab1:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab7:	29 c2                	sub    %eax,%edx
     ab9:	89 d0                	mov    %edx,%eax
     abb:	8d 50 ff             	lea    -0x1(%eax),%edx
     abe:	8b 45 c8             	mov    -0x38(%ebp),%eax
     ac1:	0f af c2             	imul   %edx,%eax
     ac4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     ac7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ace:	e9 b1 00 00 00       	jmp    b84 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     ad3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ad6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ad9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     adc:	01 c8                	add    %ecx,%eax
     ade:	89 c1                	mov    %eax,%ecx
     ae0:	89 c8                	mov    %ecx,%eax
     ae2:	01 c0                	add    %eax,%eax
     ae4:	01 c8                	add    %ecx,%eax
     ae6:	01 c2                	add    %eax,%edx
     ae8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aeb:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     aef:	89 c1                	mov    %eax,%ecx
     af1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     af4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     af8:	01 c1                	add    %eax,%ecx
     afa:	8b 45 d8             	mov    -0x28(%ebp),%eax
     afd:	01 c8                	add    %ecx,%eax
     aff:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b02:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b05:	01 c8                	add    %ecx,%eax
     b07:	0f b6 00             	movzbl (%eax),%eax
     b0a:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b0d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b10:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b13:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b16:	01 c8                	add    %ecx,%eax
     b18:	89 c1                	mov    %eax,%ecx
     b1a:	89 c8                	mov    %ecx,%eax
     b1c:	01 c0                	add    %eax,%eax
     b1e:	01 c8                	add    %ecx,%eax
     b20:	01 c2                	add    %eax,%edx
     b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b25:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b29:	89 c1                	mov    %eax,%ecx
     b2b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b2e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b32:	01 c1                	add    %eax,%ecx
     b34:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b37:	01 c8                	add    %ecx,%eax
     b39:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b3c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b3f:	01 c8                	add    %ecx,%eax
     b41:	0f b6 00             	movzbl (%eax),%eax
     b44:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b47:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b4a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b50:	01 c8                	add    %ecx,%eax
     b52:	89 c1                	mov    %eax,%ecx
     b54:	89 c8                	mov    %ecx,%eax
     b56:	01 c0                	add    %eax,%eax
     b58:	01 c8                	add    %ecx,%eax
     b5a:	01 c2                	add    %eax,%edx
     b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b63:	89 c1                	mov    %eax,%ecx
     b65:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b68:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b6c:	01 c1                	add    %eax,%ecx
     b6e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b71:	01 c8                	add    %ecx,%eax
     b73:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b76:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b79:	01 c8                	add    %ecx,%eax
     b7b:	0f b6 00             	movzbl (%eax),%eax
     b7e:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b80:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b84:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b87:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b8a:	39 c2                	cmp    %eax,%edx
     b8c:	0f 87 41 ff ff ff    	ja     ad3 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b92:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b96:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9c:	39 c2                	cmp    %eax,%edx
     b9e:	0f 87 0d ff ff ff    	ja     ab1 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     ba4:	83 ec 0c             	sub    $0xc,%esp
     ba7:	ff 75 ec             	pushl  -0x14(%ebp)
     baa:	e8 df f7 ff ff       	call   38e <close>
     baf:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bb2:	8b 45 08             	mov    0x8(%ebp),%eax
     bb5:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bb8:	89 10                	mov    %edx,(%eax)
     bba:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bbd:	89 50 04             	mov    %edx,0x4(%eax)
     bc0:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bc3:	89 50 08             	mov    %edx,0x8(%eax)
}
     bc6:	8b 45 08             	mov    0x8(%ebp),%eax
     bc9:	c9                   	leave  
     bca:	c2 04 00             	ret    $0x4

00000bcd <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     bcd:	55                   	push   %ebp
     bce:	89 e5                	mov    %esp,%ebp
     bd0:	53                   	push   %ebx
     bd1:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bd4:	83 ec 0c             	sub    $0xc,%esp
     bd7:	6a 1c                	push   $0x1c
     bd9:	e8 02 fc ff ff       	call   7e0 <malloc>
     bde:	83 c4 10             	add    $0x10,%esp
     be1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be7:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     bee:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     bf1:	8d 45 d8             	lea    -0x28(%ebp),%eax
     bf4:	6a 0c                	push   $0xc
     bf6:	6a 0c                	push   $0xc
     bf8:	6a 0c                	push   $0xc
     bfa:	50                   	push   %eax
     bfb:	e8 c3 fc ff ff       	call   8c3 <RGB>
     c00:	83 c4 0c             	add    $0xc,%esp
     c03:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c07:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c0b:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c0f:	88 43 15             	mov    %al,0x15(%ebx)
     c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c15:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c18:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c1c:	66 89 48 10          	mov    %cx,0x10(%eax)
     c20:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c24:	88 50 12             	mov    %dl,0x12(%eax)
     c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c2d:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c31:	66 89 48 08          	mov    %cx,0x8(%eax)
     c35:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c39:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c3c:	8b 45 08             	mov    0x8(%ebp),%eax
     c3f:	89 c2                	mov    %eax,%edx
     c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c44:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c46:	8b 45 0c             	mov    0xc(%ebp),%eax
     c49:	89 c2                	mov    %eax,%edx
     c4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4e:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c51:	8b 55 10             	mov    0x10(%ebp),%edx
     c54:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c57:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c60:	c9                   	leave  
     c61:	c3                   	ret    

00000c62 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c62:	55                   	push   %ebp
     c63:	89 e5                	mov    %esp,%ebp
     c65:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c68:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6b:	8b 50 08             	mov    0x8(%eax),%edx
     c6e:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c71:	8b 40 0c             	mov    0xc(%eax),%eax
     c74:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c77:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7a:	8b 55 10             	mov    0x10(%ebp),%edx
     c7d:	89 50 08             	mov    %edx,0x8(%eax)
     c80:	8b 55 14             	mov    0x14(%ebp),%edx
     c83:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c86:	8b 45 08             	mov    0x8(%ebp),%eax
     c89:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c8c:	89 10                	mov    %edx,(%eax)
     c8e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c91:	89 50 04             	mov    %edx,0x4(%eax)
}
     c94:	8b 45 08             	mov    0x8(%ebp),%eax
     c97:	c9                   	leave  
     c98:	c2 04 00             	ret    $0x4

00000c9b <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     c9b:	55                   	push   %ebp
     c9c:	89 e5                	mov    %esp,%ebp
     c9e:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ca1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca4:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ca8:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cac:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cb0:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb6:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cba:	66 89 50 10          	mov    %dx,0x10(%eax)
     cbe:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cc2:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     cc5:	8b 45 08             	mov    0x8(%ebp),%eax
     cc8:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     ccc:	66 89 10             	mov    %dx,(%eax)
     ccf:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     cd3:	88 50 02             	mov    %dl,0x2(%eax)
}
     cd6:	8b 45 08             	mov    0x8(%ebp),%eax
     cd9:	c9                   	leave  
     cda:	c2 04 00             	ret    $0x4

00000cdd <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     cdd:	55                   	push   %ebp
     cde:	89 e5                	mov    %esp,%ebp
     ce0:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ce3:	8b 45 08             	mov    0x8(%ebp),%eax
     ce6:	8b 40 0c             	mov    0xc(%eax),%eax
     ce9:	89 c2                	mov    %eax,%edx
     ceb:	c1 ea 1f             	shr    $0x1f,%edx
     cee:	01 d0                	add    %edx,%eax
     cf0:	d1 f8                	sar    %eax
     cf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf8:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     cfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     cff:	8b 45 10             	mov    0x10(%ebp),%eax
     d02:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d05:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d08:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d0c:	0f 89 98 00 00 00    	jns    daa <APDrawPoint+0xcd>
        i = 0;
     d12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d19:	e9 8c 00 00 00       	jmp    daa <APDrawPoint+0xcd>
    {
        j = x - off;
     d1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d21:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d24:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d27:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d2b:	79 69                	jns    d96 <APDrawPoint+0xb9>
            j = 0;
     d2d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d34:	eb 60                	jmp    d96 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d36:	ff 75 fc             	pushl  -0x4(%ebp)
     d39:	ff 75 f8             	pushl  -0x8(%ebp)
     d3c:	ff 75 08             	pushl  0x8(%ebp)
     d3f:	e8 fd fb ff ff       	call   941 <APGetIndex>
     d44:	83 c4 0c             	add    $0xc,%esp
     d47:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d4a:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d4e:	74 55                	je     da5 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d50:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d54:	74 67                	je     dbd <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d56:	ff 75 10             	pushl  0x10(%ebp)
     d59:	ff 75 0c             	pushl  0xc(%ebp)
     d5c:	ff 75 fc             	pushl  -0x4(%ebp)
     d5f:	ff 75 f8             	pushl  -0x8(%ebp)
     d62:	e8 a1 fb ff ff       	call   908 <distance_2>
     d67:	83 c4 10             	add    $0x10,%esp
     d6a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d6d:	7f 23                	jg     d92 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d6f:	8b 45 08             	mov    0x8(%ebp),%eax
     d72:	8b 48 18             	mov    0x18(%eax),%ecx
     d75:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d78:	89 d0                	mov    %edx,%eax
     d7a:	01 c0                	add    %eax,%eax
     d7c:	01 d0                	add    %edx,%eax
     d7e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d81:	8b 45 08             	mov    0x8(%ebp),%eax
     d84:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d88:	66 89 0a             	mov    %cx,(%edx)
     d8b:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d8f:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d92:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d96:	8b 55 0c             	mov    0xc(%ebp),%edx
     d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9c:	01 d0                	add    %edx,%eax
     d9e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     da1:	7d 93                	jge    d36 <APDrawPoint+0x59>
     da3:	eb 01                	jmp    da6 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     da5:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     da6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     daa:	8b 55 10             	mov    0x10(%ebp),%edx
     dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db0:	01 d0                	add    %edx,%eax
     db2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     db5:	0f 8d 63 ff ff ff    	jge    d1e <APDrawPoint+0x41>
     dbb:	eb 01                	jmp    dbe <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     dbd:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     dbe:	c9                   	leave  
     dbf:	c3                   	ret    

00000dc0 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	53                   	push   %ebx
     dc4:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     dc7:	8b 45 0c             	mov    0xc(%ebp),%eax
     dca:	3b 45 14             	cmp    0x14(%ebp),%eax
     dcd:	0f 85 80 00 00 00    	jne    e53 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     dd3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dd7:	0f 88 9d 02 00 00    	js     107a <APDrawLine+0x2ba>
     ddd:	8b 45 08             	mov    0x8(%ebp),%eax
     de0:	8b 00                	mov    (%eax),%eax
     de2:	3b 45 0c             	cmp    0xc(%ebp),%eax
     de5:	0f 8e 8f 02 00 00    	jle    107a <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     deb:	8b 45 10             	mov    0x10(%ebp),%eax
     dee:	3b 45 18             	cmp    0x18(%ebp),%eax
     df1:	7e 12                	jle    e05 <APDrawLine+0x45>
        {
            int tmp = y2;
     df3:	8b 45 18             	mov    0x18(%ebp),%eax
     df6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     df9:	8b 45 10             	mov    0x10(%ebp),%eax
     dfc:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     dff:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e02:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e09:	79 07                	jns    e12 <APDrawLine+0x52>
     e0b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e12:	8b 45 08             	mov    0x8(%ebp),%eax
     e15:	8b 40 04             	mov    0x4(%eax),%eax
     e18:	3b 45 18             	cmp    0x18(%ebp),%eax
     e1b:	7d 0c                	jge    e29 <APDrawLine+0x69>
     e1d:	8b 45 08             	mov    0x8(%ebp),%eax
     e20:	8b 40 04             	mov    0x4(%eax),%eax
     e23:	83 e8 01             	sub    $0x1,%eax
     e26:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e29:	8b 45 10             	mov    0x10(%ebp),%eax
     e2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e2f:	eb 15                	jmp    e46 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e31:	ff 75 f4             	pushl  -0xc(%ebp)
     e34:	ff 75 0c             	pushl  0xc(%ebp)
     e37:	ff 75 08             	pushl  0x8(%ebp)
     e3a:	e8 9e fe ff ff       	call   cdd <APDrawPoint>
     e3f:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e42:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e49:	3b 45 18             	cmp    0x18(%ebp),%eax
     e4c:	7e e3                	jle    e31 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e4e:	e9 2b 02 00 00       	jmp    107e <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e53:	8b 45 10             	mov    0x10(%ebp),%eax
     e56:	3b 45 18             	cmp    0x18(%ebp),%eax
     e59:	75 7f                	jne    eda <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e5b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e5f:	0f 88 18 02 00 00    	js     107d <APDrawLine+0x2bd>
     e65:	8b 45 08             	mov    0x8(%ebp),%eax
     e68:	8b 40 04             	mov    0x4(%eax),%eax
     e6b:	3b 45 10             	cmp    0x10(%ebp),%eax
     e6e:	0f 8e 09 02 00 00    	jle    107d <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e74:	8b 45 0c             	mov    0xc(%ebp),%eax
     e77:	3b 45 14             	cmp    0x14(%ebp),%eax
     e7a:	7e 12                	jle    e8e <APDrawLine+0xce>
        {
            int tmp = x2;
     e7c:	8b 45 14             	mov    0x14(%ebp),%eax
     e7f:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e82:	8b 45 0c             	mov    0xc(%ebp),%eax
     e85:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e88:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e8b:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e8e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e92:	79 07                	jns    e9b <APDrawLine+0xdb>
     e94:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     e9b:	8b 45 08             	mov    0x8(%ebp),%eax
     e9e:	8b 00                	mov    (%eax),%eax
     ea0:	3b 45 14             	cmp    0x14(%ebp),%eax
     ea3:	7d 0b                	jge    eb0 <APDrawLine+0xf0>
     ea5:	8b 45 08             	mov    0x8(%ebp),%eax
     ea8:	8b 00                	mov    (%eax),%eax
     eaa:	83 e8 01             	sub    $0x1,%eax
     ead:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     eb6:	eb 15                	jmp    ecd <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     eb8:	ff 75 10             	pushl  0x10(%ebp)
     ebb:	ff 75 f0             	pushl  -0x10(%ebp)
     ebe:	ff 75 08             	pushl  0x8(%ebp)
     ec1:	e8 17 fe ff ff       	call   cdd <APDrawPoint>
     ec6:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     ec9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ecd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ed0:	3b 45 14             	cmp    0x14(%ebp),%eax
     ed3:	7e e3                	jle    eb8 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     ed5:	e9 a4 01 00 00       	jmp    107e <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     eda:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ee1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ee8:	8b 45 0c             	mov    0xc(%ebp),%eax
     eeb:	2b 45 14             	sub    0x14(%ebp),%eax
     eee:	50                   	push   %eax
     eef:	e8 3d fa ff ff       	call   931 <abs_int>
     ef4:	83 c4 04             	add    $0x4,%esp
     ef7:	89 c3                	mov    %eax,%ebx
     ef9:	8b 45 10             	mov    0x10(%ebp),%eax
     efc:	2b 45 18             	sub    0x18(%ebp),%eax
     eff:	50                   	push   %eax
     f00:	e8 2c fa ff ff       	call   931 <abs_int>
     f05:	83 c4 04             	add    $0x4,%esp
     f08:	39 c3                	cmp    %eax,%ebx
     f0a:	0f 8e b5 00 00 00    	jle    fc5 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f10:	8b 45 10             	mov    0x10(%ebp),%eax
     f13:	2b 45 18             	sub    0x18(%ebp),%eax
     f16:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f19:	db 45 b0             	fildl  -0x50(%ebp)
     f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1f:	2b 45 14             	sub    0x14(%ebp),%eax
     f22:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f25:	db 45 b0             	fildl  -0x50(%ebp)
     f28:	de f9                	fdivrp %st,%st(1)
     f2a:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f2d:	8b 45 14             	mov    0x14(%ebp),%eax
     f30:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f33:	7e 0e                	jle    f43 <APDrawLine+0x183>
        {
            s = x1;
     f35:	8b 45 0c             	mov    0xc(%ebp),%eax
     f38:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f3b:	8b 45 14             	mov    0x14(%ebp),%eax
     f3e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f41:	eb 0c                	jmp    f4f <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f43:	8b 45 14             	mov    0x14(%ebp),%eax
     f46:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f49:	8b 45 0c             	mov    0xc(%ebp),%eax
     f4c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f4f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f53:	79 07                	jns    f5c <APDrawLine+0x19c>
     f55:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f5c:	8b 45 08             	mov    0x8(%ebp),%eax
     f5f:	8b 00                	mov    (%eax),%eax
     f61:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f64:	7f 0b                	jg     f71 <APDrawLine+0x1b1>
     f66:	8b 45 08             	mov    0x8(%ebp),%eax
     f69:	8b 00                	mov    (%eax),%eax
     f6b:	83 e8 01             	sub    $0x1,%eax
     f6e:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f71:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f74:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f77:	eb 3f                	jmp    fb8 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f7c:	2b 45 0c             	sub    0xc(%ebp),%eax
     f7f:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f82:	db 45 b0             	fildl  -0x50(%ebp)
     f85:	dc 4d d0             	fmull  -0x30(%ebp)
     f88:	db 45 10             	fildl  0x10(%ebp)
     f8b:	de c1                	faddp  %st,%st(1)
     f8d:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f90:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f94:	b4 0c                	mov    $0xc,%ah
     f96:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     f9a:	d9 6d b4             	fldcw  -0x4c(%ebp)
     f9d:	db 5d cc             	fistpl -0x34(%ebp)
     fa0:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fa3:	ff 75 cc             	pushl  -0x34(%ebp)
     fa6:	ff 75 e4             	pushl  -0x1c(%ebp)
     fa9:	ff 75 08             	pushl  0x8(%ebp)
     fac:	e8 2c fd ff ff       	call   cdd <APDrawPoint>
     fb1:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fb4:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     fb8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fbb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fbe:	7e b9                	jle    f79 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     fc0:	e9 b9 00 00 00       	jmp    107e <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     fc5:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc8:	2b 45 14             	sub    0x14(%ebp),%eax
     fcb:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fce:	db 45 b0             	fildl  -0x50(%ebp)
     fd1:	8b 45 10             	mov    0x10(%ebp),%eax
     fd4:	2b 45 18             	sub    0x18(%ebp),%eax
     fd7:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fda:	db 45 b0             	fildl  -0x50(%ebp)
     fdd:	de f9                	fdivrp %st,%st(1)
     fdf:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fe2:	8b 45 10             	mov    0x10(%ebp),%eax
     fe5:	3b 45 18             	cmp    0x18(%ebp),%eax
     fe8:	7e 0e                	jle    ff8 <APDrawLine+0x238>
    {
        s = y2;
     fea:	8b 45 18             	mov    0x18(%ebp),%eax
     fed:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     ff0:	8b 45 10             	mov    0x10(%ebp),%eax
     ff3:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ff6:	eb 0c                	jmp    1004 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
     ff8:	8b 45 10             	mov    0x10(%ebp),%eax
     ffb:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
     ffe:	8b 45 18             	mov    0x18(%ebp),%eax
    1001:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1004:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1008:	79 07                	jns    1011 <APDrawLine+0x251>
    100a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1011:	8b 45 08             	mov    0x8(%ebp),%eax
    1014:	8b 40 04             	mov    0x4(%eax),%eax
    1017:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    101a:	7f 0c                	jg     1028 <APDrawLine+0x268>
    101c:	8b 45 08             	mov    0x8(%ebp),%eax
    101f:	8b 40 04             	mov    0x4(%eax),%eax
    1022:	83 e8 01             	sub    $0x1,%eax
    1025:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1028:	8b 45 ec             	mov    -0x14(%ebp),%eax
    102b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    102e:	eb 3f                	jmp    106f <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1030:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1033:	2b 45 10             	sub    0x10(%ebp),%eax
    1036:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1039:	db 45 b0             	fildl  -0x50(%ebp)
    103c:	dc 4d c0             	fmull  -0x40(%ebp)
    103f:	db 45 0c             	fildl  0xc(%ebp)
    1042:	de c1                	faddp  %st,%st(1)
    1044:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1047:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    104b:	b4 0c                	mov    $0xc,%ah
    104d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1051:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1054:	db 5d bc             	fistpl -0x44(%ebp)
    1057:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    105a:	ff 75 e0             	pushl  -0x20(%ebp)
    105d:	ff 75 bc             	pushl  -0x44(%ebp)
    1060:	ff 75 08             	pushl  0x8(%ebp)
    1063:	e8 75 fc ff ff       	call   cdd <APDrawPoint>
    1068:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    106b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    106f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1072:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1075:	7e b9                	jle    1030 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1077:	90                   	nop
    1078:	eb 04                	jmp    107e <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    107a:	90                   	nop
    107b:	eb 01                	jmp    107e <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    107d:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    107e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1081:	c9                   	leave  
    1082:	c3                   	ret    

00001083 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1083:	55                   	push   %ebp
    1084:	89 e5                	mov    %esp,%ebp
    1086:	53                   	push   %ebx
    1087:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    108a:	8b 55 10             	mov    0x10(%ebp),%edx
    108d:	8b 45 18             	mov    0x18(%ebp),%eax
    1090:	01 d0                	add    %edx,%eax
    1092:	83 e8 01             	sub    $0x1,%eax
    1095:	83 ec 04             	sub    $0x4,%esp
    1098:	50                   	push   %eax
    1099:	ff 75 0c             	pushl  0xc(%ebp)
    109c:	ff 75 10             	pushl  0x10(%ebp)
    109f:	ff 75 0c             	pushl  0xc(%ebp)
    10a2:	ff 75 08             	pushl  0x8(%ebp)
    10a5:	e8 16 fd ff ff       	call   dc0 <APDrawLine>
    10aa:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b0:	8b 45 14             	mov    0x14(%ebp),%eax
    10b3:	01 d0                	add    %edx,%eax
    10b5:	83 e8 01             	sub    $0x1,%eax
    10b8:	83 ec 04             	sub    $0x4,%esp
    10bb:	ff 75 10             	pushl  0x10(%ebp)
    10be:	50                   	push   %eax
    10bf:	ff 75 10             	pushl  0x10(%ebp)
    10c2:	ff 75 0c             	pushl  0xc(%ebp)
    10c5:	ff 75 08             	pushl  0x8(%ebp)
    10c8:	e8 f3 fc ff ff       	call   dc0 <APDrawLine>
    10cd:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    10d0:	8b 55 10             	mov    0x10(%ebp),%edx
    10d3:	8b 45 18             	mov    0x18(%ebp),%eax
    10d6:	01 d0                	add    %edx,%eax
    10d8:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10db:	8b 55 0c             	mov    0xc(%ebp),%edx
    10de:	8b 45 14             	mov    0x14(%ebp),%eax
    10e1:	01 d0                	add    %edx,%eax
    10e3:	8d 50 ff             	lea    -0x1(%eax),%edx
    10e6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10e9:	8b 45 14             	mov    0x14(%ebp),%eax
    10ec:	01 d8                	add    %ebx,%eax
    10ee:	83 e8 01             	sub    $0x1,%eax
    10f1:	83 ec 04             	sub    $0x4,%esp
    10f4:	51                   	push   %ecx
    10f5:	52                   	push   %edx
    10f6:	ff 75 10             	pushl  0x10(%ebp)
    10f9:	50                   	push   %eax
    10fa:	ff 75 08             	pushl  0x8(%ebp)
    10fd:	e8 be fc ff ff       	call   dc0 <APDrawLine>
    1102:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1105:	8b 55 10             	mov    0x10(%ebp),%edx
    1108:	8b 45 18             	mov    0x18(%ebp),%eax
    110b:	01 d0                	add    %edx,%eax
    110d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1110:	8b 55 0c             	mov    0xc(%ebp),%edx
    1113:	8b 45 14             	mov    0x14(%ebp),%eax
    1116:	01 d0                	add    %edx,%eax
    1118:	8d 50 ff             	lea    -0x1(%eax),%edx
    111b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    111e:	8b 45 18             	mov    0x18(%ebp),%eax
    1121:	01 d8                	add    %ebx,%eax
    1123:	83 e8 01             	sub    $0x1,%eax
    1126:	83 ec 04             	sub    $0x4,%esp
    1129:	51                   	push   %ecx
    112a:	52                   	push   %edx
    112b:	50                   	push   %eax
    112c:	ff 75 0c             	pushl  0xc(%ebp)
    112f:	ff 75 08             	pushl  0x8(%ebp)
    1132:	e8 89 fc ff ff       	call   dc0 <APDrawLine>
    1137:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    113a:	8b 55 0c             	mov    0xc(%ebp),%edx
    113d:	8b 45 14             	mov    0x14(%ebp),%eax
    1140:	01 d0                	add    %edx,%eax
    1142:	8d 50 ff             	lea    -0x1(%eax),%edx
    1145:	8b 45 08             	mov    0x8(%ebp),%eax
    1148:	8b 40 0c             	mov    0xc(%eax),%eax
    114b:	89 c1                	mov    %eax,%ecx
    114d:	c1 e9 1f             	shr    $0x1f,%ecx
    1150:	01 c8                	add    %ecx,%eax
    1152:	d1 f8                	sar    %eax
    1154:	29 c2                	sub    %eax,%edx
    1156:	89 d0                	mov    %edx,%eax
    1158:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    115b:	8b 55 10             	mov    0x10(%ebp),%edx
    115e:	8b 45 18             	mov    0x18(%ebp),%eax
    1161:	01 d0                	add    %edx,%eax
    1163:	8d 50 ff             	lea    -0x1(%eax),%edx
    1166:	8b 45 08             	mov    0x8(%ebp),%eax
    1169:	8b 40 0c             	mov    0xc(%eax),%eax
    116c:	89 c1                	mov    %eax,%ecx
    116e:	c1 e9 1f             	shr    $0x1f,%ecx
    1171:	01 c8                	add    %ecx,%eax
    1173:	d1 f8                	sar    %eax
    1175:	29 c2                	sub    %eax,%edx
    1177:	89 d0                	mov    %edx,%eax
    1179:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    117c:	8b 45 08             	mov    0x8(%ebp),%eax
    117f:	8b 40 0c             	mov    0xc(%eax),%eax
    1182:	89 c2                	mov    %eax,%edx
    1184:	c1 ea 1f             	shr    $0x1f,%edx
    1187:	01 d0                	add    %edx,%eax
    1189:	d1 f8                	sar    %eax
    118b:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    118e:	8b 45 08             	mov    0x8(%ebp),%eax
    1191:	8b 40 0c             	mov    0xc(%eax),%eax
    1194:	89 c2                	mov    %eax,%edx
    1196:	c1 ea 1f             	shr    $0x1f,%edx
    1199:	01 d0                	add    %edx,%eax
    119b:	d1 f8                	sar    %eax
    119d:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11a4:	0f 88 d8 00 00 00    	js     1282 <APDrawRect+0x1ff>
    11aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11ae:	0f 88 ce 00 00 00    	js     1282 <APDrawRect+0x1ff>
    11b4:	8b 45 08             	mov    0x8(%ebp),%eax
    11b7:	8b 00                	mov    (%eax),%eax
    11b9:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11bc:	0f 8e c0 00 00 00    	jle    1282 <APDrawRect+0x1ff>
    11c2:	8b 45 08             	mov    0x8(%ebp),%eax
    11c5:	8b 40 04             	mov    0x4(%eax),%eax
    11c8:	3b 45 10             	cmp    0x10(%ebp),%eax
    11cb:	0f 8e b1 00 00 00    	jle    1282 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    11d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11d5:	79 07                	jns    11de <APDrawRect+0x15b>
    11d7:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11e2:	79 07                	jns    11eb <APDrawRect+0x168>
    11e4:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11eb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ee:	8b 00                	mov    (%eax),%eax
    11f0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11f3:	7f 0b                	jg     1200 <APDrawRect+0x17d>
    11f5:	8b 45 08             	mov    0x8(%ebp),%eax
    11f8:	8b 00                	mov    (%eax),%eax
    11fa:	83 e8 01             	sub    $0x1,%eax
    11fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1200:	8b 45 08             	mov    0x8(%ebp),%eax
    1203:	8b 40 04             	mov    0x4(%eax),%eax
    1206:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1209:	7f 0c                	jg     1217 <APDrawRect+0x194>
    120b:	8b 45 08             	mov    0x8(%ebp),%eax
    120e:	8b 40 04             	mov    0x4(%eax),%eax
    1211:	83 e8 01             	sub    $0x1,%eax
    1214:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1217:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    121e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1221:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1224:	eb 52                	jmp    1278 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1226:	8b 45 10             	mov    0x10(%ebp),%eax
    1229:	89 45 e8             	mov    %eax,-0x18(%ebp)
    122c:	eb 3e                	jmp    126c <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    122e:	83 ec 04             	sub    $0x4,%esp
    1231:	ff 75 e8             	pushl  -0x18(%ebp)
    1234:	ff 75 ec             	pushl  -0x14(%ebp)
    1237:	ff 75 08             	pushl  0x8(%ebp)
    123a:	e8 02 f7 ff ff       	call   941 <APGetIndex>
    123f:	83 c4 10             	add    $0x10,%esp
    1242:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1245:	8b 45 08             	mov    0x8(%ebp),%eax
    1248:	8b 48 18             	mov    0x18(%eax),%ecx
    124b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    124e:	89 d0                	mov    %edx,%eax
    1250:	01 c0                	add    %eax,%eax
    1252:	01 d0                	add    %edx,%eax
    1254:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    125e:	66 89 0a             	mov    %cx,(%edx)
    1261:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1265:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1268:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    126c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    126f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1272:	7e ba                	jle    122e <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1274:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1278:	8b 45 ec             	mov    -0x14(%ebp),%eax
    127b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    127e:	7e a6                	jle    1226 <APDrawRect+0x1a3>
    1280:	eb 01                	jmp    1283 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1282:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1283:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1286:	c9                   	leave  
    1287:	c3                   	ret    

00001288 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1288:	55                   	push   %ebp
    1289:	89 e5                	mov    %esp,%ebp
    128b:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    128e:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1292:	0f 88 8e 01 00 00    	js     1426 <APDcCopy+0x19e>
    1298:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    129c:	0f 88 84 01 00 00    	js     1426 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12a2:	8b 55 0c             	mov    0xc(%ebp),%edx
    12a5:	8b 45 20             	mov    0x20(%ebp),%eax
    12a8:	01 d0                	add    %edx,%eax
    12aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12ad:	8b 55 10             	mov    0x10(%ebp),%edx
    12b0:	8b 45 24             	mov    0x24(%ebp),%eax
    12b3:	01 d0                	add    %edx,%eax
    12b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12b8:	8b 55 18             	mov    0x18(%ebp),%edx
    12bb:	8b 45 20             	mov    0x20(%ebp),%eax
    12be:	01 d0                	add    %edx,%eax
    12c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12c3:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12c6:	8b 45 24             	mov    0x24(%ebp),%eax
    12c9:	01 d0                	add    %edx,%eax
    12cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12ce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12d2:	0f 88 51 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12dc:	0f 88 47 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12e2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12e6:	0f 88 3d 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12ec:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12f0:	0f 88 33 01 00 00    	js     1429 <APDcCopy+0x1a1>
    12f6:	8b 45 14             	mov    0x14(%ebp),%eax
    12f9:	8b 00                	mov    (%eax),%eax
    12fb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12fe:	0f 8c 25 01 00 00    	jl     1429 <APDcCopy+0x1a1>
    1304:	8b 45 14             	mov    0x14(%ebp),%eax
    1307:	8b 40 04             	mov    0x4(%eax),%eax
    130a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    130d:	0f 8c 16 01 00 00    	jl     1429 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1313:	8b 45 08             	mov    0x8(%ebp),%eax
    1316:	8b 00                	mov    (%eax),%eax
    1318:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    131b:	7f 0b                	jg     1328 <APDcCopy+0xa0>
    131d:	8b 45 08             	mov    0x8(%ebp),%eax
    1320:	8b 00                	mov    (%eax),%eax
    1322:	83 e8 01             	sub    $0x1,%eax
    1325:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1328:	8b 45 08             	mov    0x8(%ebp),%eax
    132b:	8b 40 04             	mov    0x4(%eax),%eax
    132e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1331:	7f 0c                	jg     133f <APDcCopy+0xb7>
    1333:	8b 45 08             	mov    0x8(%ebp),%eax
    1336:	8b 40 04             	mov    0x4(%eax),%eax
    1339:	83 e8 01             	sub    $0x1,%eax
    133c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    133f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1346:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    134d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1354:	e9 bc 00 00 00       	jmp    1415 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1359:	8b 45 08             	mov    0x8(%ebp),%eax
    135c:	8b 00                	mov    (%eax),%eax
    135e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1361:	8b 55 10             	mov    0x10(%ebp),%edx
    1364:	01 ca                	add    %ecx,%edx
    1366:	0f af d0             	imul   %eax,%edx
    1369:	8b 45 0c             	mov    0xc(%ebp),%eax
    136c:	01 d0                	add    %edx,%eax
    136e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1371:	8b 45 14             	mov    0x14(%ebp),%eax
    1374:	8b 00                	mov    (%eax),%eax
    1376:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1379:	8b 55 1c             	mov    0x1c(%ebp),%edx
    137c:	01 ca                	add    %ecx,%edx
    137e:	0f af d0             	imul   %eax,%edx
    1381:	8b 45 18             	mov    0x18(%ebp),%eax
    1384:	01 d0                	add    %edx,%eax
    1386:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1389:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1390:	eb 74                	jmp    1406 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1392:	8b 45 14             	mov    0x14(%ebp),%eax
    1395:	8b 50 18             	mov    0x18(%eax),%edx
    1398:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    139b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    139e:	01 c8                	add    %ecx,%eax
    13a0:	89 c1                	mov    %eax,%ecx
    13a2:	89 c8                	mov    %ecx,%eax
    13a4:	01 c0                	add    %eax,%eax
    13a6:	01 c8                	add    %ecx,%eax
    13a8:	01 d0                	add    %edx,%eax
    13aa:	0f b7 10             	movzwl (%eax),%edx
    13ad:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13b1:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13b5:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13b8:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13bc:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13c0:	38 c2                	cmp    %al,%dl
    13c2:	75 18                	jne    13dc <APDcCopy+0x154>
    13c4:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13c8:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13cc:	38 c2                	cmp    %al,%dl
    13ce:	75 0c                	jne    13dc <APDcCopy+0x154>
    13d0:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13d4:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13d8:	38 c2                	cmp    %al,%dl
    13da:	74 26                	je     1402 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13dc:	8b 45 08             	mov    0x8(%ebp),%eax
    13df:	8b 50 18             	mov    0x18(%eax),%edx
    13e2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e8:	01 c8                	add    %ecx,%eax
    13ea:	89 c1                	mov    %eax,%ecx
    13ec:	89 c8                	mov    %ecx,%eax
    13ee:	01 c0                	add    %eax,%eax
    13f0:	01 c8                	add    %ecx,%eax
    13f2:	01 d0                	add    %edx,%eax
    13f4:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13f8:	66 89 10             	mov    %dx,(%eax)
    13fb:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ff:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1402:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1406:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1409:	2b 45 0c             	sub    0xc(%ebp),%eax
    140c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    140f:	7d 81                	jge    1392 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1411:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1415:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1418:	2b 45 10             	sub    0x10(%ebp),%eax
    141b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    141e:	0f 8d 35 ff ff ff    	jge    1359 <APDcCopy+0xd1>
    1424:	eb 04                	jmp    142a <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1426:	90                   	nop
    1427:	eb 01                	jmp    142a <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1429:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    142a:	c9                   	leave  
    142b:	c3                   	ret    

0000142c <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    142c:	55                   	push   %ebp
    142d:	89 e5                	mov    %esp,%ebp
    142f:	83 ec 1c             	sub    $0x1c,%esp
    1432:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1435:	8b 55 10             	mov    0x10(%ebp),%edx
    1438:	8b 45 14             	mov    0x14(%ebp),%eax
    143b:	88 4d ec             	mov    %cl,-0x14(%ebp)
    143e:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1441:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1444:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1448:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    144b:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    144f:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1452:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1456:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1460:	66 89 10             	mov    %dx,(%eax)
    1463:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1467:	88 50 02             	mov    %dl,0x2(%eax)
}
    146a:	8b 45 08             	mov    0x8(%ebp),%eax
    146d:	c9                   	leave  
    146e:	c2 04 00             	ret    $0x4

00001471 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1471:	55                   	push   %ebp
    1472:	89 e5                	mov    %esp,%ebp
    1474:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1477:	8b 45 08             	mov    0x8(%ebp),%eax
    147a:	8b 00                	mov    (%eax),%eax
    147c:	83 ec 08             	sub    $0x8,%esp
    147f:	8d 55 0c             	lea    0xc(%ebp),%edx
    1482:	52                   	push   %edx
    1483:	50                   	push   %eax
    1484:	e8 8d ef ff ff       	call   416 <sendMessage>
    1489:	83 c4 10             	add    $0x10,%esp
}
    148c:	90                   	nop
    148d:	c9                   	leave  
    148e:	c3                   	ret    

0000148f <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    148f:	55                   	push   %ebp
    1490:	89 e5                	mov    %esp,%ebp
    1492:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1495:	83 ec 0c             	sub    $0xc,%esp
    1498:	68 90 00 00 00       	push   $0x90
    149d:	e8 3e f3 ff ff       	call   7e0 <malloc>
    14a2:	83 c4 10             	add    $0x10,%esp
    14a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14ac:	75 15                	jne    14c3 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14ae:	83 ec 04             	sub    $0x4,%esp
    14b1:	ff 75 08             	pushl  0x8(%ebp)
    14b4:	68 90 21 00 00       	push   $0x2190
    14b9:	6a 01                	push   $0x1
    14bb:	e8 4d f0 ff ff       	call   50d <printf>
    14c0:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c6:	83 c0 7c             	add    $0x7c,%eax
    14c9:	83 ec 08             	sub    $0x8,%esp
    14cc:	ff 75 08             	pushl  0x8(%ebp)
    14cf:	50                   	push   %eax
    14d0:	e8 60 ec ff ff       	call   135 <strcpy>
    14d5:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14db:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e5:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ef:	8b 40 34             	mov    0x34(%eax),%eax
    14f2:	89 c2                	mov    %eax,%edx
    14f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f7:	8b 40 38             	mov    0x38(%eax),%eax
    14fa:	0f af d0             	imul   %eax,%edx
    14fd:	89 d0                	mov    %edx,%eax
    14ff:	01 c0                	add    %eax,%eax
    1501:	01 d0                	add    %edx,%eax
    1503:	83 ec 0c             	sub    $0xc,%esp
    1506:	50                   	push   %eax
    1507:	e8 d4 f2 ff ff       	call   7e0 <malloc>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	89 c2                	mov    %eax,%edx
    1511:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1514:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1517:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151a:	8b 40 4c             	mov    0x4c(%eax),%eax
    151d:	85 c0                	test   %eax,%eax
    151f:	75 15                	jne    1536 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1521:	83 ec 04             	sub    $0x4,%esp
    1524:	ff 75 08             	pushl  0x8(%ebp)
    1527:	68 b0 21 00 00       	push   $0x21b0
    152c:	6a 01                	push   $0x1
    152e:	e8 da ef ff ff       	call   50d <printf>
    1533:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1539:	8b 40 34             	mov    0x34(%eax),%eax
    153c:	89 c2                	mov    %eax,%edx
    153e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1541:	8b 40 38             	mov    0x38(%eax),%eax
    1544:	0f af d0             	imul   %eax,%edx
    1547:	89 d0                	mov    %edx,%eax
    1549:	01 c0                	add    %eax,%eax
    154b:	01 c2                	add    %eax,%edx
    154d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1550:	8b 40 4c             	mov    0x4c(%eax),%eax
    1553:	83 ec 04             	sub    $0x4,%esp
    1556:	52                   	push   %edx
    1557:	68 ff ff ff 00       	push   $0xffffff
    155c:	50                   	push   %eax
    155d:	e8 69 ec ff ff       	call   1cb <memset>
    1562:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1565:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1568:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    156f:	e8 72 ee ff ff       	call   3e6 <getpid>
    1574:	89 c2                	mov    %eax,%edx
    1576:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1579:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    157c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157f:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1586:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1589:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	8b 40 50             	mov    0x50(%eax),%eax
    1596:	89 c2                	mov    %eax,%edx
    1598:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159b:	8b 40 54             	mov    0x54(%eax),%eax
    159e:	0f af d0             	imul   %eax,%edx
    15a1:	89 d0                	mov    %edx,%eax
    15a3:	01 c0                	add    %eax,%eax
    15a5:	01 d0                	add    %edx,%eax
    15a7:	83 ec 0c             	sub    $0xc,%esp
    15aa:	50                   	push   %eax
    15ab:	e8 30 f2 ff ff       	call   7e0 <malloc>
    15b0:	83 c4 10             	add    $0x10,%esp
    15b3:	89 c2                	mov    %eax,%edx
    15b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b8:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    15bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15be:	8b 40 68             	mov    0x68(%eax),%eax
    15c1:	85 c0                	test   %eax,%eax
    15c3:	75 15                	jne    15da <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15c5:	83 ec 04             	sub    $0x4,%esp
    15c8:	ff 75 08             	pushl  0x8(%ebp)
    15cb:	68 d4 21 00 00       	push   $0x21d4
    15d0:	6a 01                	push   $0x1
    15d2:	e8 36 ef ff ff       	call   50d <printf>
    15d7:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dd:	8b 40 34             	mov    0x34(%eax),%eax
    15e0:	89 c2                	mov    %eax,%edx
    15e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e5:	8b 40 38             	mov    0x38(%eax),%eax
    15e8:	0f af d0             	imul   %eax,%edx
    15eb:	89 d0                	mov    %edx,%eax
    15ed:	01 c0                	add    %eax,%eax
    15ef:	01 c2                	add    %eax,%edx
    15f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f4:	8b 40 4c             	mov    0x4c(%eax),%eax
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
    1616:	74 35                	je     164d <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1618:	8b 45 10             	mov    0x10(%ebp),%eax
    161b:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1621:	83 ec 0c             	sub    $0xc,%esp
    1624:	50                   	push   %eax
    1625:	e8 b6 f1 ff ff       	call   7e0 <malloc>
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
    1648:	e9 8d 00 00 00       	jmp    16da <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    164d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1650:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1657:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165a:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1661:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1664:	8b 40 18             	mov    0x18(%eax),%eax
    1667:	89 c2                	mov    %eax,%edx
    1669:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166c:	8b 40 1c             	mov    0x1c(%eax),%eax
    166f:	0f af d0             	imul   %eax,%edx
    1672:	89 d0                	mov    %edx,%eax
    1674:	01 c0                	add    %eax,%eax
    1676:	01 d0                	add    %edx,%eax
    1678:	83 ec 0c             	sub    $0xc,%esp
    167b:	50                   	push   %eax
    167c:	e8 5f f1 ff ff       	call   7e0 <malloc>
    1681:	83 c4 10             	add    $0x10,%esp
    1684:	89 c2                	mov    %eax,%edx
    1686:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1689:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    168c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168f:	8b 40 30             	mov    0x30(%eax),%eax
    1692:	85 c0                	test   %eax,%eax
    1694:	75 15                	jne    16ab <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1696:	83 ec 04             	sub    $0x4,%esp
    1699:	ff 75 08             	pushl  0x8(%ebp)
    169c:	68 fc 21 00 00       	push   $0x21fc
    16a1:	6a 01                	push   $0x1
    16a3:	e8 65 ee ff ff       	call   50d <printf>
    16a8:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ae:	8b 40 18             	mov    0x18(%eax),%eax
    16b1:	89 c2                	mov    %eax,%edx
    16b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b6:	8b 40 1c             	mov    0x1c(%eax),%eax
    16b9:	0f af d0             	imul   %eax,%edx
    16bc:	89 d0                	mov    %edx,%eax
    16be:	01 c0                	add    %eax,%eax
    16c0:	01 c2                	add    %eax,%edx
    16c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c5:	8b 40 30             	mov    0x30(%eax),%eax
    16c8:	83 ec 04             	sub    $0x4,%esp
    16cb:	52                   	push   %edx
    16cc:	68 ff ff ff 00       	push   $0xffffff
    16d1:	50                   	push   %eax
    16d2:	e8 f4 ea ff ff       	call   1cb <memset>
    16d7:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16da:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16dd:	c9                   	leave  
    16de:	c3                   	ret    

000016df <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    16df:	55                   	push   %ebp
    16e0:	89 e5                	mov    %esp,%ebp
    16e2:	53                   	push   %ebx
    16e3:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    16e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e9:	83 f8 03             	cmp    $0x3,%eax
    16ec:	74 02                	je     16f0 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    16ee:	eb 33                	jmp    1723 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    16f0:	8b 45 08             	mov    0x8(%ebp),%eax
    16f3:	8b 48 08             	mov    0x8(%eax),%ecx
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
    16f9:	8b 50 38             	mov    0x38(%eax),%edx
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	8b 40 34             	mov    0x34(%eax),%eax
    1702:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1705:	83 c3 34             	add    $0x34,%ebx
    1708:	83 ec 0c             	sub    $0xc,%esp
    170b:	51                   	push   %ecx
    170c:	52                   	push   %edx
    170d:	50                   	push   %eax
    170e:	6a 00                	push   $0x0
    1710:	6a 00                	push   $0x0
    1712:	53                   	push   %ebx
    1713:	6a 32                	push   $0x32
    1715:	6a 00                	push   $0x0
    1717:	ff 75 08             	pushl  0x8(%ebp)
    171a:	e8 e7 ec ff ff       	call   406 <paintWindow>
    171f:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1722:	90                   	nop
        default: break;
            
            
    }
    return False;
    1723:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1728:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    172b:	c9                   	leave  
    172c:	c3                   	ret    

0000172d <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    172d:	55                   	push   %ebp
    172e:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1730:	8b 45 0c             	mov    0xc(%ebp),%eax
    1733:	8b 50 08             	mov    0x8(%eax),%edx
    1736:	8b 45 08             	mov    0x8(%ebp),%eax
    1739:	8b 00                	mov    (%eax),%eax
    173b:	39 c2                	cmp    %eax,%edx
    173d:	74 07                	je     1746 <APPreJudge+0x19>
        return False;
    173f:	b8 00 00 00 00       	mov    $0x0,%eax
    1744:	eb 05                	jmp    174b <APPreJudge+0x1e>
    return True;
    1746:	b8 01 00 00 00       	mov    $0x1,%eax
}
    174b:	5d                   	pop    %ebp
    174c:	c3                   	ret    

0000174d <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    174d:	55                   	push   %ebp
    174e:	89 e5                	mov    %esp,%ebp
    1750:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1753:	8b 45 08             	mov    0x8(%ebp),%eax
    1756:	8b 55 0c             	mov    0xc(%ebp),%edx
    1759:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    175c:	83 ec 0c             	sub    $0xc,%esp
    175f:	ff 75 08             	pushl  0x8(%ebp)
    1762:	e8 bf ec ff ff       	call   426 <registWindow>
    1767:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    176a:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1771:	8b 45 08             	mov    0x8(%ebp),%eax
    1774:	8b 00                	mov    (%eax),%eax
    1776:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1779:	ff 75 f4             	pushl  -0xc(%ebp)
    177c:	ff 75 f0             	pushl  -0x10(%ebp)
    177f:	ff 75 ec             	pushl  -0x14(%ebp)
    1782:	ff 75 08             	pushl  0x8(%ebp)
    1785:	e8 e7 fc ff ff       	call   1471 <APSendMessage>
    178a:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    178d:	83 ec 0c             	sub    $0xc,%esp
    1790:	ff 75 08             	pushl  0x8(%ebp)
    1793:	e8 86 ec ff ff       	call   41e <getMessage>
    1798:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    179b:	8b 45 08             	mov    0x8(%ebp),%eax
    179e:	83 c0 6c             	add    $0x6c,%eax
    17a1:	83 ec 08             	sub    $0x8,%esp
    17a4:	50                   	push   %eax
    17a5:	ff 75 08             	pushl  0x8(%ebp)
    17a8:	e8 80 ff ff ff       	call   172d <APPreJudge>
    17ad:	83 c4 10             	add    $0x10,%esp
    17b0:	84 c0                	test   %al,%al
    17b2:	74 1b                	je     17cf <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    17b4:	8b 45 08             	mov    0x8(%ebp),%eax
    17b7:	ff 70 74             	pushl  0x74(%eax)
    17ba:	ff 70 70             	pushl  0x70(%eax)
    17bd:	ff 70 6c             	pushl  0x6c(%eax)
    17c0:	ff 75 08             	pushl  0x8(%ebp)
    17c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    17c6:	ff d0                	call   *%eax
    17c8:	83 c4 10             	add    $0x10,%esp
    17cb:	84 c0                	test   %al,%al
    17cd:	75 0c                	jne    17db <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    17cf:	8b 45 08             	mov    0x8(%ebp),%eax
    17d2:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    17d9:	eb b2                	jmp    178d <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    17db:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    17dc:	90                   	nop
    17dd:	c9                   	leave  
    17de:	c3                   	ret    

000017df <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    17df:	55                   	push   %ebp
    17e0:	89 e5                	mov    %esp,%ebp
    17e2:	57                   	push   %edi
    17e3:	56                   	push   %esi
    17e4:	53                   	push   %ebx
    17e5:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    17e8:	a1 6c 28 00 00       	mov    0x286c,%eax
    17ed:	85 c0                	test   %eax,%eax
    17ef:	0f 85 2c 02 00 00    	jne    1a21 <APGridPaint+0x242>
    {
        iconReady = 1;
    17f5:	c7 05 6c 28 00 00 01 	movl   $0x1,0x286c
    17fc:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    17ff:	8d 45 98             	lea    -0x68(%ebp),%eax
    1802:	83 ec 08             	sub    $0x8,%esp
    1805:	68 23 22 00 00       	push   $0x2223
    180a:	50                   	push   %eax
    180b:	e8 83 f1 ff ff       	call   993 <APLoadBitmap>
    1810:	83 c4 0c             	add    $0xc,%esp
    1813:	8b 45 98             	mov    -0x68(%ebp),%eax
    1816:	a3 a0 2a 00 00       	mov    %eax,0x2aa0
    181b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    181e:	a3 a4 2a 00 00       	mov    %eax,0x2aa4
    1823:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1826:	a3 a8 2a 00 00       	mov    %eax,0x2aa8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    182b:	83 ec 04             	sub    $0x4,%esp
    182e:	ff 35 a8 2a 00 00    	pushl  0x2aa8
    1834:	ff 35 a4 2a 00 00    	pushl  0x2aa4
    183a:	ff 35 a0 2a 00 00    	pushl  0x2aa0
    1840:	e8 88 f3 ff ff       	call   bcd <APCreateCompatibleDCFromBitmap>
    1845:	83 c4 10             	add    $0x10,%esp
    1848:	a3 ac 2a 00 00       	mov    %eax,0x2aac
        grid_river = APLoadBitmap ("grid_river.bmp");
    184d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1850:	83 ec 08             	sub    $0x8,%esp
    1853:	68 31 22 00 00       	push   $0x2231
    1858:	50                   	push   %eax
    1859:	e8 35 f1 ff ff       	call   993 <APLoadBitmap>
    185e:	83 c4 0c             	add    $0xc,%esp
    1861:	8b 45 98             	mov    -0x68(%ebp),%eax
    1864:	a3 dc 2a 00 00       	mov    %eax,0x2adc
    1869:	8b 45 9c             	mov    -0x64(%ebp),%eax
    186c:	a3 e0 2a 00 00       	mov    %eax,0x2ae0
    1871:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1874:	a3 e4 2a 00 00       	mov    %eax,0x2ae4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1879:	83 ec 04             	sub    $0x4,%esp
    187c:	ff 35 e4 2a 00 00    	pushl  0x2ae4
    1882:	ff 35 e0 2a 00 00    	pushl  0x2ae0
    1888:	ff 35 dc 2a 00 00    	pushl  0x2adc
    188e:	e8 3a f3 ff ff       	call   bcd <APCreateCompatibleDCFromBitmap>
    1893:	83 c4 10             	add    $0x10,%esp
    1896:	a3 cc 2a 00 00       	mov    %eax,0x2acc
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    189b:	8d 45 98             	lea    -0x68(%ebp),%eax
    189e:	83 ec 08             	sub    $0x8,%esp
    18a1:	68 40 22 00 00       	push   $0x2240
    18a6:	50                   	push   %eax
    18a7:	e8 e7 f0 ff ff       	call   993 <APLoadBitmap>
    18ac:	83 c4 0c             	add    $0xc,%esp
    18af:	8b 45 98             	mov    -0x68(%ebp),%eax
    18b2:	a3 d0 2a 00 00       	mov    %eax,0x2ad0
    18b7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18ba:	a3 d4 2a 00 00       	mov    %eax,0x2ad4
    18bf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18c2:	a3 d8 2a 00 00       	mov    %eax,0x2ad8
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    18c7:	83 ec 04             	sub    $0x4,%esp
    18ca:	ff 35 d8 2a 00 00    	pushl  0x2ad8
    18d0:	ff 35 d4 2a 00 00    	pushl  0x2ad4
    18d6:	ff 35 d0 2a 00 00    	pushl  0x2ad0
    18dc:	e8 ec f2 ff ff       	call   bcd <APCreateCompatibleDCFromBitmap>
    18e1:	83 c4 10             	add    $0x10,%esp
    18e4:	a3 80 2a 00 00       	mov    %eax,0x2a80
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    18e9:	8d 45 98             	lea    -0x68(%ebp),%eax
    18ec:	83 ec 08             	sub    $0x8,%esp
    18ef:	68 4f 22 00 00       	push   $0x224f
    18f4:	50                   	push   %eax
    18f5:	e8 99 f0 ff ff       	call   993 <APLoadBitmap>
    18fa:	83 c4 0c             	add    $0xc,%esp
    18fd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1900:	a3 b4 2a 00 00       	mov    %eax,0x2ab4
    1905:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1908:	a3 b8 2a 00 00       	mov    %eax,0x2ab8
    190d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1910:	a3 bc 2a 00 00       	mov    %eax,0x2abc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1915:	83 ec 04             	sub    $0x4,%esp
    1918:	ff 35 bc 2a 00 00    	pushl  0x2abc
    191e:	ff 35 b8 2a 00 00    	pushl  0x2ab8
    1924:	ff 35 b4 2a 00 00    	pushl  0x2ab4
    192a:	e8 9e f2 ff ff       	call   bcd <APCreateCompatibleDCFromBitmap>
    192f:	83 c4 10             	add    $0x10,%esp
    1932:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1937:	8d 45 98             	lea    -0x68(%ebp),%eax
    193a:	83 ec 08             	sub    $0x8,%esp
    193d:	68 5d 22 00 00       	push   $0x225d
    1942:	50                   	push   %eax
    1943:	e8 4b f0 ff ff       	call   993 <APLoadBitmap>
    1948:	83 c4 0c             	add    $0xc,%esp
    194b:	8b 45 98             	mov    -0x68(%ebp),%eax
    194e:	a3 90 2a 00 00       	mov    %eax,0x2a90
    1953:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1956:	a3 94 2a 00 00       	mov    %eax,0x2a94
    195b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    195e:	a3 98 2a 00 00       	mov    %eax,0x2a98
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1963:	83 ec 04             	sub    $0x4,%esp
    1966:	ff 35 98 2a 00 00    	pushl  0x2a98
    196c:	ff 35 94 2a 00 00    	pushl  0x2a94
    1972:	ff 35 90 2a 00 00    	pushl  0x2a90
    1978:	e8 50 f2 ff ff       	call   bcd <APCreateCompatibleDCFromBitmap>
    197d:	83 c4 10             	add    $0x10,%esp
    1980:	a3 b0 2a 00 00       	mov    %eax,0x2ab0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1985:	8d 45 98             	lea    -0x68(%ebp),%eax
    1988:	83 ec 08             	sub    $0x8,%esp
    198b:	68 6d 22 00 00       	push   $0x226d
    1990:	50                   	push   %eax
    1991:	e8 fd ef ff ff       	call   993 <APLoadBitmap>
    1996:	83 c4 0c             	add    $0xc,%esp
    1999:	8b 45 98             	mov    -0x68(%ebp),%eax
    199c:	a3 84 2a 00 00       	mov    %eax,0x2a84
    19a1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19a4:	a3 88 2a 00 00       	mov    %eax,0x2a88
    19a9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19ac:	a3 8c 2a 00 00       	mov    %eax,0x2a8c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    19b1:	83 ec 04             	sub    $0x4,%esp
    19b4:	ff 35 8c 2a 00 00    	pushl  0x2a8c
    19ba:	ff 35 88 2a 00 00    	pushl  0x2a88
    19c0:	ff 35 84 2a 00 00    	pushl  0x2a84
    19c6:	e8 02 f2 ff ff       	call   bcd <APCreateCompatibleDCFromBitmap>
    19cb:	83 c4 10             	add    $0x10,%esp
    19ce:	a3 9c 2a 00 00       	mov    %eax,0x2a9c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    19d3:	8d 45 98             	lea    -0x68(%ebp),%eax
    19d6:	83 ec 08             	sub    $0x8,%esp
    19d9:	68 7f 22 00 00       	push   $0x227f
    19de:	50                   	push   %eax
    19df:	e8 af ef ff ff       	call   993 <APLoadBitmap>
    19e4:	83 c4 0c             	add    $0xc,%esp
    19e7:	8b 45 98             	mov    -0x68(%ebp),%eax
    19ea:	a3 c0 2a 00 00       	mov    %eax,0x2ac0
    19ef:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19f2:	a3 c4 2a 00 00       	mov    %eax,0x2ac4
    19f7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19fa:	a3 c8 2a 00 00       	mov    %eax,0x2ac8
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    19ff:	83 ec 04             	sub    $0x4,%esp
    1a02:	ff 35 c8 2a 00 00    	pushl  0x2ac8
    1a08:	ff 35 c4 2a 00 00    	pushl  0x2ac4
    1a0e:	ff 35 c0 2a 00 00    	pushl  0x2ac0
    1a14:	e8 b4 f1 ff ff       	call   bcd <APCreateCompatibleDCFromBitmap>
    1a19:	83 c4 10             	add    $0x10,%esp
    1a1c:	a3 ec 2a 00 00       	mov    %eax,0x2aec
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a21:	8b 45 08             	mov    0x8(%ebp),%eax
    1a24:	8b 40 08             	mov    0x8(%eax),%eax
    1a27:	85 c0                	test   %eax,%eax
    1a29:	75 17                	jne    1a42 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a2b:	83 ec 08             	sub    $0x8,%esp
    1a2e:	68 90 22 00 00       	push   $0x2290
    1a33:	6a 01                	push   $0x1
    1a35:	e8 d3 ea ff ff       	call   50d <printf>
    1a3a:	83 c4 10             	add    $0x10,%esp
        return;
    1a3d:	e9 f2 03 00 00       	jmp    1e34 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a42:	8b 45 08             	mov    0x8(%ebp),%eax
    1a45:	8b 40 10             	mov    0x10(%eax),%eax
    1a48:	85 c0                	test   %eax,%eax
    1a4a:	7e 10                	jle    1a5c <APGridPaint+0x27d>
    1a4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4f:	8b 50 14             	mov    0x14(%eax),%edx
    1a52:	8b 45 08             	mov    0x8(%ebp),%eax
    1a55:	8b 40 10             	mov    0x10(%eax),%eax
    1a58:	39 c2                	cmp    %eax,%edx
    1a5a:	7c 17                	jl     1a73 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a5c:	83 ec 08             	sub    $0x8,%esp
    1a5f:	68 b6 22 00 00       	push   $0x22b6
    1a64:	6a 01                	push   $0x1
    1a66:	e8 a2 ea ff ff       	call   50d <printf>
    1a6b:	83 c4 10             	add    $0x10,%esp
        return;
    1a6e:	e9 c1 03 00 00       	jmp    1e34 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1a73:	8b 45 08             	mov    0x8(%ebp),%eax
    1a76:	8b 40 14             	mov    0x14(%eax),%eax
    1a79:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1a7f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1a82:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a85:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1a88:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1a8f:	e9 96 03 00 00       	jmp    1e2a <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1a94:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1a9b:	e9 7c 03 00 00       	jmp    1e1c <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1aa0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1aa3:	c1 e0 04             	shl    $0x4,%eax
    1aa6:	89 c2                	mov    %eax,%edx
    1aa8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1aab:	01 c2                	add    %eax,%edx
    1aad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ab0:	01 d0                	add    %edx,%eax
    1ab2:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1ab5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab8:	8b 40 0c             	mov    0xc(%eax),%eax
    1abb:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1abe:	c1 e2 02             	shl    $0x2,%edx
    1ac1:	01 d0                	add    %edx,%eax
    1ac3:	8b 00                	mov    (%eax),%eax
    1ac5:	83 f8 07             	cmp    $0x7,%eax
    1ac8:	0f 87 49 03 00 00    	ja     1e17 <APGridPaint+0x638>
    1ace:	8b 04 85 cc 22 00 00 	mov    0x22cc(,%eax,4),%eax
    1ad5:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ad7:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ada:	6a 0c                	push   $0xc
    1adc:	6a 0c                	push   $0xc
    1ade:	6a 0c                	push   $0xc
    1ae0:	50                   	push   %eax
    1ae1:	e8 46 f9 ff ff       	call   142c <RGB>
    1ae6:	83 c4 0c             	add    $0xc,%esp
    1ae9:	8b 1d ac 2a 00 00    	mov    0x2aac,%ebx
    1aef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1af2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1af5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1af8:	6b c0 32             	imul   $0x32,%eax,%eax
    1afb:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1afe:	8b 45 08             	mov    0x8(%ebp),%eax
    1b01:	8d 78 34             	lea    0x34(%eax),%edi
    1b04:	83 ec 0c             	sub    $0xc,%esp
    1b07:	83 ec 04             	sub    $0x4,%esp
    1b0a:	89 e0                	mov    %esp,%eax
    1b0c:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b10:	66 89 30             	mov    %si,(%eax)
    1b13:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b17:	88 50 02             	mov    %dl,0x2(%eax)
    1b1a:	6a 32                	push   $0x32
    1b1c:	6a 32                	push   $0x32
    1b1e:	6a 00                	push   $0x0
    1b20:	6a 00                	push   $0x0
    1b22:	53                   	push   %ebx
    1b23:	51                   	push   %ecx
    1b24:	ff 75 94             	pushl  -0x6c(%ebp)
    1b27:	57                   	push   %edi
    1b28:	e8 5b f7 ff ff       	call   1288 <APDcCopy>
    1b2d:	83 c4 30             	add    $0x30,%esp
                    break;
    1b30:	e9 e3 02 00 00       	jmp    1e18 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b35:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b38:	6a 69                	push   $0x69
    1b3a:	6a 69                	push   $0x69
    1b3c:	6a 69                	push   $0x69
    1b3e:	50                   	push   %eax
    1b3f:	e8 e8 f8 ff ff       	call   142c <RGB>
    1b44:	83 c4 0c             	add    $0xc,%esp
    1b47:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b4b:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1b4f:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b53:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1b56:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b5d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b60:	6a 69                	push   $0x69
    1b62:	6a 69                	push   $0x69
    1b64:	6a 69                	push   $0x69
    1b66:	50                   	push   %eax
    1b67:	e8 c0 f8 ff ff       	call   142c <RGB>
    1b6c:	83 c4 0c             	add    $0xc,%esp
    1b6f:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b73:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1b77:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b7b:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b81:	8d 50 34             	lea    0x34(%eax),%edx
    1b84:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b87:	ff 75 bc             	pushl  -0x44(%ebp)
    1b8a:	ff 75 b8             	pushl  -0x48(%ebp)
    1b8d:	52                   	push   %edx
    1b8e:	50                   	push   %eax
    1b8f:	e8 ce f0 ff ff       	call   c62 <APSetPen>
    1b94:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b97:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9a:	8d 58 34             	lea    0x34(%eax),%ebx
    1b9d:	8d 55 98             	lea    -0x68(%ebp),%edx
    1ba0:	83 ec 04             	sub    $0x4,%esp
    1ba3:	83 ec 04             	sub    $0x4,%esp
    1ba6:	89 e0                	mov    %esp,%eax
    1ba8:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1bac:	66 89 08             	mov    %cx,(%eax)
    1baf:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1bb3:	88 48 02             	mov    %cl,0x2(%eax)
    1bb6:	53                   	push   %ebx
    1bb7:	52                   	push   %edx
    1bb8:	e8 de f0 ff ff       	call   c9b <APSetBrush>
    1bbd:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1bc0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bc3:	6b d0 32             	imul   $0x32,%eax,%edx
    1bc6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bc9:	6b c0 32             	imul   $0x32,%eax,%eax
    1bcc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bcf:	83 c1 34             	add    $0x34,%ecx
    1bd2:	83 ec 0c             	sub    $0xc,%esp
    1bd5:	6a 32                	push   $0x32
    1bd7:	6a 32                	push   $0x32
    1bd9:	52                   	push   %edx
    1bda:	50                   	push   %eax
    1bdb:	51                   	push   %ecx
    1bdc:	e8 a2 f4 ff ff       	call   1083 <APDrawRect>
    1be1:	83 c4 20             	add    $0x20,%esp
                    break;
    1be4:	e9 2f 02 00 00       	jmp    1e18 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1be9:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1bec:	6a 0c                	push   $0xc
    1bee:	6a 0c                	push   $0xc
    1bf0:	6a 0c                	push   $0xc
    1bf2:	50                   	push   %eax
    1bf3:	e8 34 f8 ff ff       	call   142c <RGB>
    1bf8:	83 c4 0c             	add    $0xc,%esp
    1bfb:	8b 1d ec 2a 00 00    	mov    0x2aec,%ebx
    1c01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c04:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c07:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c0a:	6b c0 32             	imul   $0x32,%eax,%eax
    1c0d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c10:	8b 45 08             	mov    0x8(%ebp),%eax
    1c13:	8d 78 34             	lea    0x34(%eax),%edi
    1c16:	83 ec 0c             	sub    $0xc,%esp
    1c19:	83 ec 04             	sub    $0x4,%esp
    1c1c:	89 e0                	mov    %esp,%eax
    1c1e:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c22:	66 89 30             	mov    %si,(%eax)
    1c25:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c29:	88 50 02             	mov    %dl,0x2(%eax)
    1c2c:	6a 32                	push   $0x32
    1c2e:	6a 32                	push   $0x32
    1c30:	6a 00                	push   $0x0
    1c32:	6a 00                	push   $0x0
    1c34:	53                   	push   %ebx
    1c35:	51                   	push   %ecx
    1c36:	ff 75 94             	pushl  -0x6c(%ebp)
    1c39:	57                   	push   %edi
    1c3a:	e8 49 f6 ff ff       	call   1288 <APDcCopy>
    1c3f:	83 c4 30             	add    $0x30,%esp
                    break;
    1c42:	e9 d1 01 00 00       	jmp    1e18 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c47:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c4a:	6a 0c                	push   $0xc
    1c4c:	6a 0c                	push   $0xc
    1c4e:	6a 0c                	push   $0xc
    1c50:	50                   	push   %eax
    1c51:	e8 d6 f7 ff ff       	call   142c <RGB>
    1c56:	83 c4 0c             	add    $0xc,%esp
    1c59:	8b 1d cc 2a 00 00    	mov    0x2acc,%ebx
    1c5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c62:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c65:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c68:	6b c0 32             	imul   $0x32,%eax,%eax
    1c6b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c71:	8d 78 34             	lea    0x34(%eax),%edi
    1c74:	83 ec 0c             	sub    $0xc,%esp
    1c77:	83 ec 04             	sub    $0x4,%esp
    1c7a:	89 e0                	mov    %esp,%eax
    1c7c:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1c80:	66 89 30             	mov    %si,(%eax)
    1c83:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1c87:	88 50 02             	mov    %dl,0x2(%eax)
    1c8a:	6a 32                	push   $0x32
    1c8c:	6a 32                	push   $0x32
    1c8e:	6a 00                	push   $0x0
    1c90:	6a 00                	push   $0x0
    1c92:	53                   	push   %ebx
    1c93:	51                   	push   %ecx
    1c94:	ff 75 94             	pushl  -0x6c(%ebp)
    1c97:	57                   	push   %edi
    1c98:	e8 eb f5 ff ff       	call   1288 <APDcCopy>
    1c9d:	83 c4 30             	add    $0x30,%esp
                    break;
    1ca0:	e9 73 01 00 00       	jmp    1e18 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ca5:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ca8:	6a 0c                	push   $0xc
    1caa:	6a 0c                	push   $0xc
    1cac:	6a 0c                	push   $0xc
    1cae:	50                   	push   %eax
    1caf:	e8 78 f7 ff ff       	call   142c <RGB>
    1cb4:	83 c4 0c             	add    $0xc,%esp
    1cb7:	8b 1d b0 2a 00 00    	mov    0x2ab0,%ebx
    1cbd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cc0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cc6:	6b c0 32             	imul   $0x32,%eax,%eax
    1cc9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ccc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccf:	8d 78 34             	lea    0x34(%eax),%edi
    1cd2:	83 ec 0c             	sub    $0xc,%esp
    1cd5:	83 ec 04             	sub    $0x4,%esp
    1cd8:	89 e0                	mov    %esp,%eax
    1cda:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1cde:	66 89 30             	mov    %si,(%eax)
    1ce1:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ce5:	88 50 02             	mov    %dl,0x2(%eax)
    1ce8:	6a 32                	push   $0x32
    1cea:	6a 32                	push   $0x32
    1cec:	6a 00                	push   $0x0
    1cee:	6a 00                	push   $0x0
    1cf0:	53                   	push   %ebx
    1cf1:	51                   	push   %ecx
    1cf2:	ff 75 94             	pushl  -0x6c(%ebp)
    1cf5:	57                   	push   %edi
    1cf6:	e8 8d f5 ff ff       	call   1288 <APDcCopy>
    1cfb:	83 c4 30             	add    $0x30,%esp
                    break;
    1cfe:	e9 15 01 00 00       	jmp    1e18 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d03:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1d06:	6a 0c                	push   $0xc
    1d08:	6a 0c                	push   $0xc
    1d0a:	6a 0c                	push   $0xc
    1d0c:	50                   	push   %eax
    1d0d:	e8 1a f7 ff ff       	call   142c <RGB>
    1d12:	83 c4 0c             	add    $0xc,%esp
    1d15:	8b 1d e8 2a 00 00    	mov    0x2ae8,%ebx
    1d1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d1e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d21:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d24:	6b c0 32             	imul   $0x32,%eax,%eax
    1d27:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2d:	8d 78 34             	lea    0x34(%eax),%edi
    1d30:	83 ec 0c             	sub    $0xc,%esp
    1d33:	83 ec 04             	sub    $0x4,%esp
    1d36:	89 e0                	mov    %esp,%eax
    1d38:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d3c:	66 89 30             	mov    %si,(%eax)
    1d3f:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d43:	88 50 02             	mov    %dl,0x2(%eax)
    1d46:	6a 32                	push   $0x32
    1d48:	6a 32                	push   $0x32
    1d4a:	6a 00                	push   $0x0
    1d4c:	6a 00                	push   $0x0
    1d4e:	53                   	push   %ebx
    1d4f:	51                   	push   %ecx
    1d50:	ff 75 94             	pushl  -0x6c(%ebp)
    1d53:	57                   	push   %edi
    1d54:	e8 2f f5 ff ff       	call   1288 <APDcCopy>
    1d59:	83 c4 30             	add    $0x30,%esp
                    break;
    1d5c:	e9 b7 00 00 00       	jmp    1e18 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d61:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d64:	6a 0c                	push   $0xc
    1d66:	6a 0c                	push   $0xc
    1d68:	6a 0c                	push   $0xc
    1d6a:	50                   	push   %eax
    1d6b:	e8 bc f6 ff ff       	call   142c <RGB>
    1d70:	83 c4 0c             	add    $0xc,%esp
    1d73:	8b 1d 80 2a 00 00    	mov    0x2a80,%ebx
    1d79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d7c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d82:	6b c0 32             	imul   $0x32,%eax,%eax
    1d85:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d88:	8b 45 08             	mov    0x8(%ebp),%eax
    1d8b:	8d 78 34             	lea    0x34(%eax),%edi
    1d8e:	83 ec 0c             	sub    $0xc,%esp
    1d91:	83 ec 04             	sub    $0x4,%esp
    1d94:	89 e0                	mov    %esp,%eax
    1d96:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1d9a:	66 89 30             	mov    %si,(%eax)
    1d9d:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1da1:	88 50 02             	mov    %dl,0x2(%eax)
    1da4:	6a 32                	push   $0x32
    1da6:	6a 32                	push   $0x32
    1da8:	6a 00                	push   $0x0
    1daa:	6a 00                	push   $0x0
    1dac:	53                   	push   %ebx
    1dad:	51                   	push   %ecx
    1dae:	ff 75 94             	pushl  -0x6c(%ebp)
    1db1:	57                   	push   %edi
    1db2:	e8 d1 f4 ff ff       	call   1288 <APDcCopy>
    1db7:	83 c4 30             	add    $0x30,%esp
                    break;
    1dba:	eb 5c                	jmp    1e18 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dbc:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1dbf:	6a 0c                	push   $0xc
    1dc1:	6a 0c                	push   $0xc
    1dc3:	6a 0c                	push   $0xc
    1dc5:	50                   	push   %eax
    1dc6:	e8 61 f6 ff ff       	call   142c <RGB>
    1dcb:	83 c4 0c             	add    $0xc,%esp
    1dce:	8b 1d 9c 2a 00 00    	mov    0x2a9c,%ebx
    1dd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dd7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dda:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ddd:	6b c0 32             	imul   $0x32,%eax,%eax
    1de0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1de3:	8b 45 08             	mov    0x8(%ebp),%eax
    1de6:	8d 78 34             	lea    0x34(%eax),%edi
    1de9:	83 ec 0c             	sub    $0xc,%esp
    1dec:	83 ec 04             	sub    $0x4,%esp
    1def:	89 e0                	mov    %esp,%eax
    1df1:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1df5:	66 89 30             	mov    %si,(%eax)
    1df8:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1dfc:	88 50 02             	mov    %dl,0x2(%eax)
    1dff:	6a 32                	push   $0x32
    1e01:	6a 32                	push   $0x32
    1e03:	6a 00                	push   $0x0
    1e05:	6a 00                	push   $0x0
    1e07:	53                   	push   %ebx
    1e08:	51                   	push   %ecx
    1e09:	ff 75 94             	pushl  -0x6c(%ebp)
    1e0c:	57                   	push   %edi
    1e0d:	e8 76 f4 ff ff       	call   1288 <APDcCopy>
    1e12:	83 c4 30             	add    $0x30,%esp
                    break;
    1e15:	eb 01                	jmp    1e18 <APGridPaint+0x639>
                default: break;
    1e17:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e18:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e1c:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e20:	0f 8e 7a fc ff ff    	jle    1aa0 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e26:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e2a:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e2e:	0f 8e 60 fc ff ff    	jle    1a94 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1e34:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e37:	5b                   	pop    %ebx
    1e38:	5e                   	pop    %esi
    1e39:	5f                   	pop    %edi
    1e3a:	5d                   	pop    %ebp
    1e3b:	c3                   	ret    

00001e3c <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e3c:	55                   	push   %ebp
    1e3d:	89 e5                	mov    %esp,%ebp
    1e3f:	53                   	push   %ebx
    1e40:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e4a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e4e:	74 17                	je     1e67 <sprintint+0x2b>
    1e50:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e54:	79 11                	jns    1e67 <sprintint+0x2b>
        neg = 1;
    1e56:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e5d:	8b 45 10             	mov    0x10(%ebp),%eax
    1e60:	f7 d8                	neg    %eax
    1e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e65:	eb 06                	jmp    1e6d <sprintint+0x31>
    } else {
        x = xx;
    1e67:	8b 45 10             	mov    0x10(%ebp),%eax
    1e6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e6d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1e74:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1e77:	8d 41 01             	lea    0x1(%ecx),%eax
    1e7a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e7d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e80:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e83:	ba 00 00 00 00       	mov    $0x0,%edx
    1e88:	f7 f3                	div    %ebx
    1e8a:	89 d0                	mov    %edx,%eax
    1e8c:	0f b6 80 38 28 00 00 	movzbl 0x2838(%eax),%eax
    1e93:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1e97:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e9d:	ba 00 00 00 00       	mov    $0x0,%edx
    1ea2:	f7 f3                	div    %ebx
    1ea4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ea7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1eab:	75 c7                	jne    1e74 <sprintint+0x38>
    if(neg)
    1ead:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1eb1:	74 0e                	je     1ec1 <sprintint+0x85>
        buf[i++] = '-';
    1eb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1eb6:	8d 50 01             	lea    0x1(%eax),%edx
    1eb9:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1ebc:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1ec1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ec4:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1ec7:	eb 1b                	jmp    1ee4 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ecc:	8b 00                	mov    (%eax),%eax
    1ece:	8d 48 01             	lea    0x1(%eax),%ecx
    1ed1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ed4:	89 0a                	mov    %ecx,(%edx)
    1ed6:	89 c2                	mov    %eax,%edx
    1ed8:	8b 45 08             	mov    0x8(%ebp),%eax
    1edb:	01 d0                	add    %edx,%eax
    1edd:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1ee0:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1ee4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1ee8:	7f df                	jg     1ec9 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1eea:	eb 21                	jmp    1f0d <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1eec:	8b 45 0c             	mov    0xc(%ebp),%eax
    1eef:	8b 00                	mov    (%eax),%eax
    1ef1:	8d 48 01             	lea    0x1(%eax),%ecx
    1ef4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ef7:	89 0a                	mov    %ecx,(%edx)
    1ef9:	89 c2                	mov    %eax,%edx
    1efb:	8b 45 08             	mov    0x8(%ebp),%eax
    1efe:	01 c2                	add    %eax,%edx
    1f00:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1f03:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f06:	01 c8                	add    %ecx,%eax
    1f08:	0f b6 00             	movzbl (%eax),%eax
    1f0b:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f0d:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1f11:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1f15:	79 d5                	jns    1eec <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1f17:	90                   	nop
    1f18:	83 c4 20             	add    $0x20,%esp
    1f1b:	5b                   	pop    %ebx
    1f1c:	5d                   	pop    %ebp
    1f1d:	c3                   	ret    

00001f1e <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1f1e:	55                   	push   %ebp
    1f1f:	89 e5                	mov    %esp,%ebp
    1f21:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1f24:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1f2b:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1f32:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f39:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f3c:	83 c0 04             	add    $0x4,%eax
    1f3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f42:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f49:	e9 d9 01 00 00       	jmp    2127 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f4e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f51:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f54:	01 d0                	add    %edx,%eax
    1f56:	0f b6 00             	movzbl (%eax),%eax
    1f59:	0f be c0             	movsbl %al,%eax
    1f5c:	25 ff 00 00 00       	and    $0xff,%eax
    1f61:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f64:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f68:	75 2c                	jne    1f96 <sprintf+0x78>
            if(c == '%'){
    1f6a:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f6e:	75 0c                	jne    1f7c <sprintf+0x5e>
                state = '%';
    1f70:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1f77:	e9 a7 01 00 00       	jmp    2123 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1f7c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f7f:	8d 50 01             	lea    0x1(%eax),%edx
    1f82:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f85:	89 c2                	mov    %eax,%edx
    1f87:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8a:	01 d0                	add    %edx,%eax
    1f8c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f8f:	88 10                	mov    %dl,(%eax)
    1f91:	e9 8d 01 00 00       	jmp    2123 <sprintf+0x205>
            }
        } else if(state == '%'){
    1f96:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1f9a:	0f 85 83 01 00 00    	jne    2123 <sprintf+0x205>
            if(c == 'd'){
    1fa0:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1fa4:	75 4c                	jne    1ff2 <sprintf+0xd4>
                buf[bi] = '\0';
    1fa6:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fac:	01 d0                	add    %edx,%eax
    1fae:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fb1:	83 ec 0c             	sub    $0xc,%esp
    1fb4:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1fb7:	50                   	push   %eax
    1fb8:	e8 17 e3 ff ff       	call   2d4 <atoi>
    1fbd:	83 c4 10             	add    $0x10,%esp
    1fc0:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1fc3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1fca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fcd:	8b 00                	mov    (%eax),%eax
    1fcf:	83 ec 08             	sub    $0x8,%esp
    1fd2:	ff 75 d8             	pushl  -0x28(%ebp)
    1fd5:	6a 01                	push   $0x1
    1fd7:	6a 0a                	push   $0xa
    1fd9:	50                   	push   %eax
    1fda:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1fdd:	50                   	push   %eax
    1fde:	ff 75 08             	pushl  0x8(%ebp)
    1fe1:	e8 56 fe ff ff       	call   1e3c <sprintint>
    1fe6:	83 c4 20             	add    $0x20,%esp
                ap++;
    1fe9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1fed:	e9 2a 01 00 00       	jmp    211c <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1ff2:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1ff6:	74 06                	je     1ffe <sprintf+0xe0>
    1ff8:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1ffc:	75 4c                	jne    204a <sprintf+0x12c>
                buf[bi] = '\0';
    1ffe:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2001:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2004:	01 d0                	add    %edx,%eax
    2006:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2009:	83 ec 0c             	sub    $0xc,%esp
    200c:	8d 45 ce             	lea    -0x32(%ebp),%eax
    200f:	50                   	push   %eax
    2010:	e8 bf e2 ff ff       	call   2d4 <atoi>
    2015:	83 c4 10             	add    $0x10,%esp
    2018:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    201b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2022:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2025:	8b 00                	mov    (%eax),%eax
    2027:	83 ec 08             	sub    $0x8,%esp
    202a:	ff 75 dc             	pushl  -0x24(%ebp)
    202d:	6a 00                	push   $0x0
    202f:	6a 10                	push   $0x10
    2031:	50                   	push   %eax
    2032:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2035:	50                   	push   %eax
    2036:	ff 75 08             	pushl  0x8(%ebp)
    2039:	e8 fe fd ff ff       	call   1e3c <sprintint>
    203e:	83 c4 20             	add    $0x20,%esp
                ap++;
    2041:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2045:	e9 d2 00 00 00       	jmp    211c <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    204a:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    204e:	75 46                	jne    2096 <sprintf+0x178>
                s = (char*)*ap;
    2050:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2053:	8b 00                	mov    (%eax),%eax
    2055:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2058:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    205c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2060:	75 25                	jne    2087 <sprintf+0x169>
                    s = "(null)";
    2062:	c7 45 f4 ec 22 00 00 	movl   $0x22ec,-0xc(%ebp)
                while(*s != 0){
    2069:	eb 1c                	jmp    2087 <sprintf+0x169>
                    dst[j++] = *s;
    206b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    206e:	8d 50 01             	lea    0x1(%eax),%edx
    2071:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2074:	89 c2                	mov    %eax,%edx
    2076:	8b 45 08             	mov    0x8(%ebp),%eax
    2079:	01 c2                	add    %eax,%edx
    207b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    207e:	0f b6 00             	movzbl (%eax),%eax
    2081:	88 02                	mov    %al,(%edx)
                    s++;
    2083:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2087:	8b 45 f4             	mov    -0xc(%ebp),%eax
    208a:	0f b6 00             	movzbl (%eax),%eax
    208d:	84 c0                	test   %al,%al
    208f:	75 da                	jne    206b <sprintf+0x14d>
    2091:	e9 86 00 00 00       	jmp    211c <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2096:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    209a:	75 1d                	jne    20b9 <sprintf+0x19b>
                dst[j++] = *ap;
    209c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    209f:	8d 50 01             	lea    0x1(%eax),%edx
    20a2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20a5:	89 c2                	mov    %eax,%edx
    20a7:	8b 45 08             	mov    0x8(%ebp),%eax
    20aa:	01 c2                	add    %eax,%edx
    20ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20af:	8b 00                	mov    (%eax),%eax
    20b1:	88 02                	mov    %al,(%edx)
                ap++;
    20b3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20b7:	eb 63                	jmp    211c <sprintf+0x1fe>
            } else if(c == '%'){
    20b9:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20bd:	75 17                	jne    20d6 <sprintf+0x1b8>
                dst[j++] = c;
    20bf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20c2:	8d 50 01             	lea    0x1(%eax),%edx
    20c5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20c8:	89 c2                	mov    %eax,%edx
    20ca:	8b 45 08             	mov    0x8(%ebp),%eax
    20cd:	01 d0                	add    %edx,%eax
    20cf:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20d2:	88 10                	mov    %dl,(%eax)
    20d4:	eb 46                	jmp    211c <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    20d6:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    20da:	7e 18                	jle    20f4 <sprintf+0x1d6>
    20dc:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    20e0:	7f 12                	jg     20f4 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    20e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20e5:	8d 50 01             	lea    0x1(%eax),%edx
    20e8:	89 55 f0             	mov    %edx,-0x10(%ebp)
    20eb:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20ee:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    20f2:	eb 2f                	jmp    2123 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    20f4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f7:	8d 50 01             	lea    0x1(%eax),%edx
    20fa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20fd:	89 c2                	mov    %eax,%edx
    20ff:	8b 45 08             	mov    0x8(%ebp),%eax
    2102:	01 d0                	add    %edx,%eax
    2104:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2107:	8b 45 c8             	mov    -0x38(%ebp),%eax
    210a:	8d 50 01             	lea    0x1(%eax),%edx
    210d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2110:	89 c2                	mov    %eax,%edx
    2112:	8b 45 08             	mov    0x8(%ebp),%eax
    2115:	01 d0                	add    %edx,%eax
    2117:	8b 55 e0             	mov    -0x20(%ebp),%edx
    211a:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    211c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2123:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2127:	8b 55 0c             	mov    0xc(%ebp),%edx
    212a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    212d:	01 d0                	add    %edx,%eax
    212f:	0f b6 00             	movzbl (%eax),%eax
    2132:	84 c0                	test   %al,%al
    2134:	0f 85 14 fe ff ff    	jne    1f4e <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    213a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    213d:	8d 50 01             	lea    0x1(%eax),%edx
    2140:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2143:	89 c2                	mov    %eax,%edx
    2145:	8b 45 08             	mov    0x8(%ebp),%eax
    2148:	01 d0                	add    %edx,%eax
    214a:	c6 00 00             	movb   $0x0,(%eax)
}
    214d:	90                   	nop
    214e:	c9                   	leave  
    214f:	c3                   	ret    
