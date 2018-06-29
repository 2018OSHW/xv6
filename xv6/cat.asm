
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
       e:	68 40 68 00 00       	push   $0x6840
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
      25:	68 40 68 00 00       	push   $0x6840
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
      47:	68 80 24 00 00       	push   $0x2480
      4c:	6a 01                	push   $0x1
      4e:	e8 c2 04 00 00       	call   515 <printf>
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
      cf:	68 91 24 00 00       	push   $0x2491
      d4:	6a 01                	push   $0x1
      d6:	e8 3a 04 00 00       	call   515 <printf>
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

0000043e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     43e:	55                   	push   %ebp
     43f:	89 e5                	mov    %esp,%ebp
     441:	83 ec 18             	sub    $0x18,%esp
     444:	8b 45 0c             	mov    0xc(%ebp),%eax
     447:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     44a:	83 ec 04             	sub    $0x4,%esp
     44d:	6a 01                	push   $0x1
     44f:	8d 45 f4             	lea    -0xc(%ebp),%eax
     452:	50                   	push   %eax
     453:	ff 75 08             	pushl  0x8(%ebp)
     456:	e8 2b ff ff ff       	call   386 <write>
     45b:	83 c4 10             	add    $0x10,%esp
}
     45e:	90                   	nop
     45f:	c9                   	leave  
     460:	c3                   	ret    

00000461 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     461:	55                   	push   %ebp
     462:	89 e5                	mov    %esp,%ebp
     464:	53                   	push   %ebx
     465:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     468:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     46f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     473:	74 17                	je     48c <printint+0x2b>
     475:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     479:	79 11                	jns    48c <printint+0x2b>
    neg = 1;
     47b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     482:	8b 45 0c             	mov    0xc(%ebp),%eax
     485:	f7 d8                	neg    %eax
     487:	89 45 ec             	mov    %eax,-0x14(%ebp)
     48a:	eb 06                	jmp    492 <printint+0x31>
  } else {
    x = xx;
     48c:	8b 45 0c             	mov    0xc(%ebp),%eax
     48f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     492:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     499:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     49c:	8d 41 01             	lea    0x1(%ecx),%eax
     49f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4a2:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4a8:	ba 00 00 00 00       	mov    $0x0,%edx
     4ad:	f7 f3                	div    %ebx
     4af:	89 d0                	mov    %edx,%eax
     4b1:	0f b6 80 c0 2b 00 00 	movzbl 0x2bc0(%eax),%eax
     4b8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4c2:	ba 00 00 00 00       	mov    $0x0,%edx
     4c7:	f7 f3                	div    %ebx
     4c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4d0:	75 c7                	jne    499 <printint+0x38>
  if(neg)
     4d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4d6:	74 2d                	je     505 <printint+0xa4>
    buf[i++] = '-';
     4d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4db:	8d 50 01             	lea    0x1(%eax),%edx
     4de:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4e1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4e6:	eb 1d                	jmp    505 <printint+0xa4>
    putc(fd, buf[i]);
     4e8:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ee:	01 d0                	add    %edx,%eax
     4f0:	0f b6 00             	movzbl (%eax),%eax
     4f3:	0f be c0             	movsbl %al,%eax
     4f6:	83 ec 08             	sub    $0x8,%esp
     4f9:	50                   	push   %eax
     4fa:	ff 75 08             	pushl  0x8(%ebp)
     4fd:	e8 3c ff ff ff       	call   43e <putc>
     502:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     505:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     509:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     50d:	79 d9                	jns    4e8 <printint+0x87>
    putc(fd, buf[i]);
}
     50f:	90                   	nop
     510:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     513:	c9                   	leave  
     514:	c3                   	ret    

00000515 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     515:	55                   	push   %ebp
     516:	89 e5                	mov    %esp,%ebp
     518:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     51b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     522:	8d 45 0c             	lea    0xc(%ebp),%eax
     525:	83 c0 04             	add    $0x4,%eax
     528:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     52b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     532:	e9 59 01 00 00       	jmp    690 <printf+0x17b>
    c = fmt[i] & 0xff;
     537:	8b 55 0c             	mov    0xc(%ebp),%edx
     53a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     53d:	01 d0                	add    %edx,%eax
     53f:	0f b6 00             	movzbl (%eax),%eax
     542:	0f be c0             	movsbl %al,%eax
     545:	25 ff 00 00 00       	and    $0xff,%eax
     54a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     54d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     551:	75 2c                	jne    57f <printf+0x6a>
      if(c == '%'){
     553:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     557:	75 0c                	jne    565 <printf+0x50>
        state = '%';
     559:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     560:	e9 27 01 00 00       	jmp    68c <printf+0x177>
      } else {
        putc(fd, c);
     565:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     568:	0f be c0             	movsbl %al,%eax
     56b:	83 ec 08             	sub    $0x8,%esp
     56e:	50                   	push   %eax
     56f:	ff 75 08             	pushl  0x8(%ebp)
     572:	e8 c7 fe ff ff       	call   43e <putc>
     577:	83 c4 10             	add    $0x10,%esp
     57a:	e9 0d 01 00 00       	jmp    68c <printf+0x177>
      }
    } else if(state == '%'){
     57f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     583:	0f 85 03 01 00 00    	jne    68c <printf+0x177>
      if(c == 'd'){
     589:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     58d:	75 1e                	jne    5ad <printf+0x98>
        printint(fd, *ap, 10, 1);
     58f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     592:	8b 00                	mov    (%eax),%eax
     594:	6a 01                	push   $0x1
     596:	6a 0a                	push   $0xa
     598:	50                   	push   %eax
     599:	ff 75 08             	pushl  0x8(%ebp)
     59c:	e8 c0 fe ff ff       	call   461 <printint>
     5a1:	83 c4 10             	add    $0x10,%esp
        ap++;
     5a4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5a8:	e9 d8 00 00 00       	jmp    685 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5ad:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5b1:	74 06                	je     5b9 <printf+0xa4>
     5b3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5b7:	75 1e                	jne    5d7 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5bc:	8b 00                	mov    (%eax),%eax
     5be:	6a 00                	push   $0x0
     5c0:	6a 10                	push   $0x10
     5c2:	50                   	push   %eax
     5c3:	ff 75 08             	pushl  0x8(%ebp)
     5c6:	e8 96 fe ff ff       	call   461 <printint>
     5cb:	83 c4 10             	add    $0x10,%esp
        ap++;
     5ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5d2:	e9 ae 00 00 00       	jmp    685 <printf+0x170>
      } else if(c == 's'){
     5d7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5db:	75 43                	jne    620 <printf+0x10b>
        s = (char*)*ap;
     5dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5e0:	8b 00                	mov    (%eax),%eax
     5e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5ed:	75 25                	jne    614 <printf+0xff>
          s = "(null)";
     5ef:	c7 45 f4 a6 24 00 00 	movl   $0x24a6,-0xc(%ebp)
        while(*s != 0){
     5f6:	eb 1c                	jmp    614 <printf+0xff>
          putc(fd, *s);
     5f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fb:	0f b6 00             	movzbl (%eax),%eax
     5fe:	0f be c0             	movsbl %al,%eax
     601:	83 ec 08             	sub    $0x8,%esp
     604:	50                   	push   %eax
     605:	ff 75 08             	pushl  0x8(%ebp)
     608:	e8 31 fe ff ff       	call   43e <putc>
     60d:	83 c4 10             	add    $0x10,%esp
          s++;
     610:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     614:	8b 45 f4             	mov    -0xc(%ebp),%eax
     617:	0f b6 00             	movzbl (%eax),%eax
     61a:	84 c0                	test   %al,%al
     61c:	75 da                	jne    5f8 <printf+0xe3>
     61e:	eb 65                	jmp    685 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     620:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     624:	75 1d                	jne    643 <printf+0x12e>
        putc(fd, *ap);
     626:	8b 45 e8             	mov    -0x18(%ebp),%eax
     629:	8b 00                	mov    (%eax),%eax
     62b:	0f be c0             	movsbl %al,%eax
     62e:	83 ec 08             	sub    $0x8,%esp
     631:	50                   	push   %eax
     632:	ff 75 08             	pushl  0x8(%ebp)
     635:	e8 04 fe ff ff       	call   43e <putc>
     63a:	83 c4 10             	add    $0x10,%esp
        ap++;
     63d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     641:	eb 42                	jmp    685 <printf+0x170>
      } else if(c == '%'){
     643:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     647:	75 17                	jne    660 <printf+0x14b>
        putc(fd, c);
     649:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     64c:	0f be c0             	movsbl %al,%eax
     64f:	83 ec 08             	sub    $0x8,%esp
     652:	50                   	push   %eax
     653:	ff 75 08             	pushl  0x8(%ebp)
     656:	e8 e3 fd ff ff       	call   43e <putc>
     65b:	83 c4 10             	add    $0x10,%esp
     65e:	eb 25                	jmp    685 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     660:	83 ec 08             	sub    $0x8,%esp
     663:	6a 25                	push   $0x25
     665:	ff 75 08             	pushl  0x8(%ebp)
     668:	e8 d1 fd ff ff       	call   43e <putc>
     66d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     670:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     673:	0f be c0             	movsbl %al,%eax
     676:	83 ec 08             	sub    $0x8,%esp
     679:	50                   	push   %eax
     67a:	ff 75 08             	pushl  0x8(%ebp)
     67d:	e8 bc fd ff ff       	call   43e <putc>
     682:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     685:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     68c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     690:	8b 55 0c             	mov    0xc(%ebp),%edx
     693:	8b 45 f0             	mov    -0x10(%ebp),%eax
     696:	01 d0                	add    %edx,%eax
     698:	0f b6 00             	movzbl (%eax),%eax
     69b:	84 c0                	test   %al,%al
     69d:	0f 85 94 fe ff ff    	jne    537 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6a3:	90                   	nop
     6a4:	c9                   	leave  
     6a5:	c3                   	ret    

000006a6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6a6:	55                   	push   %ebp
     6a7:	89 e5                	mov    %esp,%ebp
     6a9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6ac:	8b 45 08             	mov    0x8(%ebp),%eax
     6af:	83 e8 08             	sub    $0x8,%eax
     6b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6b5:	a1 28 68 00 00       	mov    0x6828,%eax
     6ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6bd:	eb 24                	jmp    6e3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c2:	8b 00                	mov    (%eax),%eax
     6c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6c7:	77 12                	ja     6db <free+0x35>
     6c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6cf:	77 24                	ja     6f5 <free+0x4f>
     6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d4:	8b 00                	mov    (%eax),%eax
     6d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6d9:	77 1a                	ja     6f5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6de:	8b 00                	mov    (%eax),%eax
     6e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6e9:	76 d4                	jbe    6bf <free+0x19>
     6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ee:	8b 00                	mov    (%eax),%eax
     6f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     6f3:	76 ca                	jbe    6bf <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     6f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f8:	8b 40 04             	mov    0x4(%eax),%eax
     6fb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     702:	8b 45 f8             	mov    -0x8(%ebp),%eax
     705:	01 c2                	add    %eax,%edx
     707:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70a:	8b 00                	mov    (%eax),%eax
     70c:	39 c2                	cmp    %eax,%edx
     70e:	75 24                	jne    734 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     710:	8b 45 f8             	mov    -0x8(%ebp),%eax
     713:	8b 50 04             	mov    0x4(%eax),%edx
     716:	8b 45 fc             	mov    -0x4(%ebp),%eax
     719:	8b 00                	mov    (%eax),%eax
     71b:	8b 40 04             	mov    0x4(%eax),%eax
     71e:	01 c2                	add    %eax,%edx
     720:	8b 45 f8             	mov    -0x8(%ebp),%eax
     723:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     726:	8b 45 fc             	mov    -0x4(%ebp),%eax
     729:	8b 00                	mov    (%eax),%eax
     72b:	8b 10                	mov    (%eax),%edx
     72d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     730:	89 10                	mov    %edx,(%eax)
     732:	eb 0a                	jmp    73e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     734:	8b 45 fc             	mov    -0x4(%ebp),%eax
     737:	8b 10                	mov    (%eax),%edx
     739:	8b 45 f8             	mov    -0x8(%ebp),%eax
     73c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     741:	8b 40 04             	mov    0x4(%eax),%eax
     744:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     74b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     74e:	01 d0                	add    %edx,%eax
     750:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     753:	75 20                	jne    775 <free+0xcf>
    p->s.size += bp->s.size;
     755:	8b 45 fc             	mov    -0x4(%ebp),%eax
     758:	8b 50 04             	mov    0x4(%eax),%edx
     75b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     75e:	8b 40 04             	mov    0x4(%eax),%eax
     761:	01 c2                	add    %eax,%edx
     763:	8b 45 fc             	mov    -0x4(%ebp),%eax
     766:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     769:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76c:	8b 10                	mov    (%eax),%edx
     76e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     771:	89 10                	mov    %edx,(%eax)
     773:	eb 08                	jmp    77d <free+0xd7>
  } else
    p->s.ptr = bp;
     775:	8b 45 fc             	mov    -0x4(%ebp),%eax
     778:	8b 55 f8             	mov    -0x8(%ebp),%edx
     77b:	89 10                	mov    %edx,(%eax)
  freep = p;
     77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     780:	a3 28 68 00 00       	mov    %eax,0x6828
}
     785:	90                   	nop
     786:	c9                   	leave  
     787:	c3                   	ret    

00000788 <morecore>:

static Header*
morecore(uint nu)
{
     788:	55                   	push   %ebp
     789:	89 e5                	mov    %esp,%ebp
     78b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     78e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     795:	77 07                	ja     79e <morecore+0x16>
    nu = 4096;
     797:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     79e:	8b 45 08             	mov    0x8(%ebp),%eax
     7a1:	c1 e0 03             	shl    $0x3,%eax
     7a4:	83 ec 0c             	sub    $0xc,%esp
     7a7:	50                   	push   %eax
     7a8:	e8 41 fc ff ff       	call   3ee <sbrk>
     7ad:	83 c4 10             	add    $0x10,%esp
     7b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7b3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7b7:	75 07                	jne    7c0 <morecore+0x38>
    return 0;
     7b9:	b8 00 00 00 00       	mov    $0x0,%eax
     7be:	eb 26                	jmp    7e6 <morecore+0x5e>
  hp = (Header*)p;
     7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c9:	8b 55 08             	mov    0x8(%ebp),%edx
     7cc:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d2:	83 c0 08             	add    $0x8,%eax
     7d5:	83 ec 0c             	sub    $0xc,%esp
     7d8:	50                   	push   %eax
     7d9:	e8 c8 fe ff ff       	call   6a6 <free>
     7de:	83 c4 10             	add    $0x10,%esp
  return freep;
     7e1:	a1 28 68 00 00       	mov    0x6828,%eax
}
     7e6:	c9                   	leave  
     7e7:	c3                   	ret    

000007e8 <malloc>:

void*
malloc(uint nbytes)
{
     7e8:	55                   	push   %ebp
     7e9:	89 e5                	mov    %esp,%ebp
     7eb:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7ee:	8b 45 08             	mov    0x8(%ebp),%eax
     7f1:	83 c0 07             	add    $0x7,%eax
     7f4:	c1 e8 03             	shr    $0x3,%eax
     7f7:	83 c0 01             	add    $0x1,%eax
     7fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7fd:	a1 28 68 00 00       	mov    0x6828,%eax
     802:	89 45 f0             	mov    %eax,-0x10(%ebp)
     805:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     809:	75 23                	jne    82e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     80b:	c7 45 f0 20 68 00 00 	movl   $0x6820,-0x10(%ebp)
     812:	8b 45 f0             	mov    -0x10(%ebp),%eax
     815:	a3 28 68 00 00       	mov    %eax,0x6828
     81a:	a1 28 68 00 00       	mov    0x6828,%eax
     81f:	a3 20 68 00 00       	mov    %eax,0x6820
    base.s.size = 0;
     824:	c7 05 24 68 00 00 00 	movl   $0x0,0x6824
     82b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     831:	8b 00                	mov    (%eax),%eax
     833:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     836:	8b 45 f4             	mov    -0xc(%ebp),%eax
     839:	8b 40 04             	mov    0x4(%eax),%eax
     83c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     83f:	72 4d                	jb     88e <malloc+0xa6>
      if(p->s.size == nunits)
     841:	8b 45 f4             	mov    -0xc(%ebp),%eax
     844:	8b 40 04             	mov    0x4(%eax),%eax
     847:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     84a:	75 0c                	jne    858 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     84c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84f:	8b 10                	mov    (%eax),%edx
     851:	8b 45 f0             	mov    -0x10(%ebp),%eax
     854:	89 10                	mov    %edx,(%eax)
     856:	eb 26                	jmp    87e <malloc+0x96>
      else {
        p->s.size -= nunits;
     858:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85b:	8b 40 04             	mov    0x4(%eax),%eax
     85e:	2b 45 ec             	sub    -0x14(%ebp),%eax
     861:	89 c2                	mov    %eax,%edx
     863:	8b 45 f4             	mov    -0xc(%ebp),%eax
     866:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     869:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86c:	8b 40 04             	mov    0x4(%eax),%eax
     86f:	c1 e0 03             	shl    $0x3,%eax
     872:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     875:	8b 45 f4             	mov    -0xc(%ebp),%eax
     878:	8b 55 ec             	mov    -0x14(%ebp),%edx
     87b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     87e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     881:	a3 28 68 00 00       	mov    %eax,0x6828
      return (void*)(p + 1);
     886:	8b 45 f4             	mov    -0xc(%ebp),%eax
     889:	83 c0 08             	add    $0x8,%eax
     88c:	eb 3b                	jmp    8c9 <malloc+0xe1>
    }
    if(p == freep)
     88e:	a1 28 68 00 00       	mov    0x6828,%eax
     893:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     896:	75 1e                	jne    8b6 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     898:	83 ec 0c             	sub    $0xc,%esp
     89b:	ff 75 ec             	pushl  -0x14(%ebp)
     89e:	e8 e5 fe ff ff       	call   788 <morecore>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8ad:	75 07                	jne    8b6 <malloc+0xce>
        return 0;
     8af:	b8 00 00 00 00       	mov    $0x0,%eax
     8b4:	eb 13                	jmp    8c9 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bf:	8b 00                	mov    (%eax),%eax
     8c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8c4:	e9 6d ff ff ff       	jmp    836 <malloc+0x4e>
}
     8c9:	c9                   	leave  
     8ca:	c3                   	ret    

000008cb <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8cb:	55                   	push   %ebp
     8cc:	89 e5                	mov    %esp,%ebp
     8ce:	83 ec 1c             	sub    $0x1c,%esp
     8d1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     8d4:	8b 55 10             	mov    0x10(%ebp),%edx
     8d7:	8b 45 14             	mov    0x14(%ebp),%eax
     8da:	88 4d ec             	mov    %cl,-0x14(%ebp)
     8dd:	88 55 e8             	mov    %dl,-0x18(%ebp)
     8e0:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     8e3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     8e7:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     8ea:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     8ee:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     8f1:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     8f5:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     8f8:	8b 45 08             	mov    0x8(%ebp),%eax
     8fb:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     8ff:	66 89 10             	mov    %dx,(%eax)
     902:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     906:	88 50 02             	mov    %dl,0x2(%eax)
}
     909:	8b 45 08             	mov    0x8(%ebp),%eax
     90c:	c9                   	leave  
     90d:	c2 04 00             	ret    $0x4

00000910 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     913:	8b 45 08             	mov    0x8(%ebp),%eax
     916:	2b 45 10             	sub    0x10(%ebp),%eax
     919:	89 c2                	mov    %eax,%edx
     91b:	8b 45 08             	mov    0x8(%ebp),%eax
     91e:	2b 45 10             	sub    0x10(%ebp),%eax
     921:	0f af d0             	imul   %eax,%edx
     924:	8b 45 0c             	mov    0xc(%ebp),%eax
     927:	2b 45 14             	sub    0x14(%ebp),%eax
     92a:	89 c1                	mov    %eax,%ecx
     92c:	8b 45 0c             	mov    0xc(%ebp),%eax
     92f:	2b 45 14             	sub    0x14(%ebp),%eax
     932:	0f af c1             	imul   %ecx,%eax
     935:	01 d0                	add    %edx,%eax
}
     937:	5d                   	pop    %ebp
     938:	c3                   	ret    

00000939 <abs_int>:

static inline int abs_int(int x)
{
     939:	55                   	push   %ebp
     93a:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     93c:	8b 45 08             	mov    0x8(%ebp),%eax
     93f:	99                   	cltd   
     940:	89 d0                	mov    %edx,%eax
     942:	33 45 08             	xor    0x8(%ebp),%eax
     945:	29 d0                	sub    %edx,%eax
}
     947:	5d                   	pop    %ebp
     948:	c3                   	ret    

00000949 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     949:	55                   	push   %ebp
     94a:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     94c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     950:	79 07                	jns    959 <APGetIndex+0x10>
        return X_SMALLER;
     952:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     957:	eb 40                	jmp    999 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     959:	8b 45 08             	mov    0x8(%ebp),%eax
     95c:	8b 00                	mov    (%eax),%eax
     95e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     961:	7f 07                	jg     96a <APGetIndex+0x21>
        return X_BIGGER;
     963:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     968:	eb 2f                	jmp    999 <APGetIndex+0x50>
    if (y < 0)
     96a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     96e:	79 07                	jns    977 <APGetIndex+0x2e>
        return Y_SMALLER;
     970:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     975:	eb 22                	jmp    999 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     977:	8b 45 08             	mov    0x8(%ebp),%eax
     97a:	8b 40 04             	mov    0x4(%eax),%eax
     97d:	3b 45 10             	cmp    0x10(%ebp),%eax
     980:	7f 07                	jg     989 <APGetIndex+0x40>
        return Y_BIGGER;
     982:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     987:	eb 10                	jmp    999 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     989:	8b 45 08             	mov    0x8(%ebp),%eax
     98c:	8b 00                	mov    (%eax),%eax
     98e:	0f af 45 10          	imul   0x10(%ebp),%eax
     992:	89 c2                	mov    %eax,%edx
     994:	8b 45 0c             	mov    0xc(%ebp),%eax
     997:	01 d0                	add    %edx,%eax
}
     999:	5d                   	pop    %ebp
     99a:	c3                   	ret    

0000099b <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     99b:	55                   	push   %ebp
     99c:	89 e5                	mov    %esp,%ebp
     99e:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9a1:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9a8:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9ab:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9ae:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9b5:	83 ec 08             	sub    $0x8,%esp
     9b8:	6a 00                	push   $0x0
     9ba:	ff 75 0c             	pushl  0xc(%ebp)
     9bd:	e8 e4 f9 ff ff       	call   3a6 <open>
     9c2:	83 c4 10             	add    $0x10,%esp
     9c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9cc:	79 2e                	jns    9fc <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     9ce:	83 ec 04             	sub    $0x4,%esp
     9d1:	ff 75 0c             	pushl  0xc(%ebp)
     9d4:	68 ad 24 00 00       	push   $0x24ad
     9d9:	6a 01                	push   $0x1
     9db:	e8 35 fb ff ff       	call   515 <printf>
     9e0:	83 c4 10             	add    $0x10,%esp
        return bmp;
     9e3:	8b 45 08             	mov    0x8(%ebp),%eax
     9e6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     9e9:	89 10                	mov    %edx,(%eax)
     9eb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     9ee:	89 50 04             	mov    %edx,0x4(%eax)
     9f1:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9f4:	89 50 08             	mov    %edx,0x8(%eax)
     9f7:	e9 d2 01 00 00       	jmp    bce <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     9fc:	83 ec 04             	sub    $0x4,%esp
     9ff:	6a 0e                	push   $0xe
     a01:	8d 45 ba             	lea    -0x46(%ebp),%eax
     a04:	50                   	push   %eax
     a05:	ff 75 ec             	pushl  -0x14(%ebp)
     a08:	e8 71 f9 ff ff       	call   37e <read>
     a0d:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a10:	83 ec 04             	sub    $0x4,%esp
     a13:	6a 28                	push   $0x28
     a15:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a18:	50                   	push   %eax
     a19:	ff 75 ec             	pushl  -0x14(%ebp)
     a1c:	e8 5d f9 ff ff       	call   37e <read>
     a21:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a24:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a27:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a2a:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a2d:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a30:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a33:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a36:	0f af d0             	imul   %eax,%edx
     a39:	89 d0                	mov    %edx,%eax
     a3b:	01 c0                	add    %eax,%eax
     a3d:	01 d0                	add    %edx,%eax
     a3f:	83 ec 0c             	sub    $0xc,%esp
     a42:	50                   	push   %eax
     a43:	e8 a0 fd ff ff       	call   7e8 <malloc>
     a48:	83 c4 10             	add    $0x10,%esp
     a4b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a4e:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a52:	0f b7 c0             	movzwl %ax,%eax
     a55:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a58:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a5e:	0f af c2             	imul   %edx,%eax
     a61:	83 c0 1f             	add    $0x1f,%eax
     a64:	c1 e8 05             	shr    $0x5,%eax
     a67:	c1 e0 02             	shl    $0x2,%eax
     a6a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     a6d:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a73:	0f af c2             	imul   %edx,%eax
     a76:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     a79:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a7c:	83 ec 0c             	sub    $0xc,%esp
     a7f:	50                   	push   %eax
     a80:	e8 63 fd ff ff       	call   7e8 <malloc>
     a85:	83 c4 10             	add    $0x10,%esp
     a88:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     a8b:	83 ec 04             	sub    $0x4,%esp
     a8e:	ff 75 e0             	pushl  -0x20(%ebp)
     a91:	ff 75 dc             	pushl  -0x24(%ebp)
     a94:	ff 75 ec             	pushl  -0x14(%ebp)
     a97:	e8 e2 f8 ff ff       	call   37e <read>
     a9c:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     a9f:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     aa3:	66 c1 e8 03          	shr    $0x3,%ax
     aa7:	0f b7 c0             	movzwl %ax,%eax
     aaa:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     aad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ab4:	e9 e5 00 00 00       	jmp    b9e <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ab9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abf:	29 c2                	sub    %eax,%edx
     ac1:	89 d0                	mov    %edx,%eax
     ac3:	8d 50 ff             	lea    -0x1(%eax),%edx
     ac6:	8b 45 c8             	mov    -0x38(%ebp),%eax
     ac9:	0f af c2             	imul   %edx,%eax
     acc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     acf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ad6:	e9 b1 00 00 00       	jmp    b8c <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     adb:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ade:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ae1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ae4:	01 c8                	add    %ecx,%eax
     ae6:	89 c1                	mov    %eax,%ecx
     ae8:	89 c8                	mov    %ecx,%eax
     aea:	01 c0                	add    %eax,%eax
     aec:	01 c8                	add    %ecx,%eax
     aee:	01 c2                	add    %eax,%edx
     af0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af3:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     af7:	89 c1                	mov    %eax,%ecx
     af9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     afc:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b00:	01 c1                	add    %eax,%ecx
     b02:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b05:	01 c8                	add    %ecx,%eax
     b07:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b0a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b0d:	01 c8                	add    %ecx,%eax
     b0f:	0f b6 00             	movzbl (%eax),%eax
     b12:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b15:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b18:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b1e:	01 c8                	add    %ecx,%eax
     b20:	89 c1                	mov    %eax,%ecx
     b22:	89 c8                	mov    %ecx,%eax
     b24:	01 c0                	add    %eax,%eax
     b26:	01 c8                	add    %ecx,%eax
     b28:	01 c2                	add    %eax,%edx
     b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2d:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b31:	89 c1                	mov    %eax,%ecx
     b33:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b36:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b3a:	01 c1                	add    %eax,%ecx
     b3c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b3f:	01 c8                	add    %ecx,%eax
     b41:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b44:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b47:	01 c8                	add    %ecx,%eax
     b49:	0f b6 00             	movzbl (%eax),%eax
     b4c:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b4f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b52:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b55:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b58:	01 c8                	add    %ecx,%eax
     b5a:	89 c1                	mov    %eax,%ecx
     b5c:	89 c8                	mov    %ecx,%eax
     b5e:	01 c0                	add    %eax,%eax
     b60:	01 c8                	add    %ecx,%eax
     b62:	01 c2                	add    %eax,%edx
     b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b67:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b6b:	89 c1                	mov    %eax,%ecx
     b6d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b70:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b74:	01 c1                	add    %eax,%ecx
     b76:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b79:	01 c8                	add    %ecx,%eax
     b7b:	8d 48 fd             	lea    -0x3(%eax),%ecx
     b7e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b81:	01 c8                	add    %ecx,%eax
     b83:	0f b6 00             	movzbl (%eax),%eax
     b86:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     b88:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b8c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b92:	39 c2                	cmp    %eax,%edx
     b94:	0f 87 41 ff ff ff    	ja     adb <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     b9a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b9e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba4:	39 c2                	cmp    %eax,%edx
     ba6:	0f 87 0d ff ff ff    	ja     ab9 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     bac:	83 ec 0c             	sub    $0xc,%esp
     baf:	ff 75 ec             	pushl  -0x14(%ebp)
     bb2:	e8 d7 f7 ff ff       	call   38e <close>
     bb7:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bba:	8b 45 08             	mov    0x8(%ebp),%eax
     bbd:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bc0:	89 10                	mov    %edx,(%eax)
     bc2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bc5:	89 50 04             	mov    %edx,0x4(%eax)
     bc8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bcb:	89 50 08             	mov    %edx,0x8(%eax)
}
     bce:	8b 45 08             	mov    0x8(%ebp),%eax
     bd1:	c9                   	leave  
     bd2:	c2 04 00             	ret    $0x4

00000bd5 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     bd5:	55                   	push   %ebp
     bd6:	89 e5                	mov    %esp,%ebp
     bd8:	53                   	push   %ebx
     bd9:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     bdc:	83 ec 0c             	sub    $0xc,%esp
     bdf:	6a 1c                	push   $0x1c
     be1:	e8 02 fc ff ff       	call   7e8 <malloc>
     be6:	83 c4 10             	add    $0x10,%esp
     be9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     bec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bef:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     bf6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     bf9:	8d 45 d8             	lea    -0x28(%ebp),%eax
     bfc:	6a 0c                	push   $0xc
     bfe:	6a 0c                	push   $0xc
     c00:	6a 0c                	push   $0xc
     c02:	50                   	push   %eax
     c03:	e8 c3 fc ff ff       	call   8cb <RGB>
     c08:	83 c4 0c             	add    $0xc,%esp
     c0b:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c0f:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c13:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c17:	88 43 15             	mov    %al,0x15(%ebx)
     c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c20:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c24:	66 89 48 10          	mov    %cx,0x10(%eax)
     c28:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c2c:	88 50 12             	mov    %dl,0x12(%eax)
     c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c32:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c35:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c39:	66 89 48 08          	mov    %cx,0x8(%eax)
     c3d:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c41:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c44:	8b 45 08             	mov    0x8(%ebp),%eax
     c47:	89 c2                	mov    %eax,%edx
     c49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c4c:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     c51:	89 c2                	mov    %eax,%edx
     c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c56:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c59:	8b 55 10             	mov    0x10(%ebp),%edx
     c5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5f:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c68:	c9                   	leave  
     c69:	c3                   	ret    

00000c6a <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c6a:	55                   	push   %ebp
     c6b:	89 e5                	mov    %esp,%ebp
     c6d:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     c70:	8b 45 0c             	mov    0xc(%ebp),%eax
     c73:	8b 50 08             	mov    0x8(%eax),%edx
     c76:	89 55 f8             	mov    %edx,-0x8(%ebp)
     c79:	8b 40 0c             	mov    0xc(%eax),%eax
     c7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
     c82:	8b 55 10             	mov    0x10(%ebp),%edx
     c85:	89 50 08             	mov    %edx,0x8(%eax)
     c88:	8b 55 14             	mov    0x14(%ebp),%edx
     c8b:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     c8e:	8b 45 08             	mov    0x8(%ebp),%eax
     c91:	8b 55 f8             	mov    -0x8(%ebp),%edx
     c94:	89 10                	mov    %edx,(%eax)
     c96:	8b 55 fc             	mov    -0x4(%ebp),%edx
     c99:	89 50 04             	mov    %edx,0x4(%eax)
}
     c9c:	8b 45 08             	mov    0x8(%ebp),%eax
     c9f:	c9                   	leave  
     ca0:	c2 04 00             	ret    $0x4

00000ca3 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ca3:	55                   	push   %ebp
     ca4:	89 e5                	mov    %esp,%ebp
     ca6:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cac:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     cb0:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cb4:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cb8:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cbb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbe:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cc2:	66 89 50 10          	mov    %dx,0x10(%eax)
     cc6:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cca:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     ccd:	8b 45 08             	mov    0x8(%ebp),%eax
     cd0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     cd4:	66 89 10             	mov    %dx,(%eax)
     cd7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     cdb:	88 50 02             	mov    %dl,0x2(%eax)
}
     cde:	8b 45 08             	mov    0x8(%ebp),%eax
     ce1:	c9                   	leave  
     ce2:	c2 04 00             	ret    $0x4

00000ce5 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     ce5:	55                   	push   %ebp
     ce6:	89 e5                	mov    %esp,%ebp
     ce8:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     ceb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cee:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     cf2:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cf6:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     cfa:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
     d00:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d04:	66 89 50 13          	mov    %dx,0x13(%eax)
     d08:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d0c:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     d0f:	8b 45 08             	mov    0x8(%ebp),%eax
     d12:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d16:	66 89 10             	mov    %dx,(%eax)
     d19:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d1d:	88 50 02             	mov    %dl,0x2(%eax)
}
     d20:	8b 45 08             	mov    0x8(%ebp),%eax
     d23:	c9                   	leave  
     d24:	c2 04 00             	ret    $0x4

00000d27 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d27:	55                   	push   %ebp
     d28:	89 e5                	mov    %esp,%ebp
     d2a:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d2d:	8b 45 08             	mov    0x8(%ebp),%eax
     d30:	8b 40 0c             	mov    0xc(%eax),%eax
     d33:	89 c2                	mov    %eax,%edx
     d35:	c1 ea 1f             	shr    $0x1f,%edx
     d38:	01 d0                	add    %edx,%eax
     d3a:	d1 f8                	sar    %eax
     d3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d42:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d46:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d49:	8b 45 10             	mov    0x10(%ebp),%eax
     d4c:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d4f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d52:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d56:	0f 89 98 00 00 00    	jns    df4 <APDrawPoint+0xcd>
        i = 0;
     d5c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d63:	e9 8c 00 00 00       	jmp    df4 <APDrawPoint+0xcd>
    {
        j = x - off;
     d68:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6b:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d71:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d75:	79 69                	jns    de0 <APDrawPoint+0xb9>
            j = 0;
     d77:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d7e:	eb 60                	jmp    de0 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d80:	ff 75 fc             	pushl  -0x4(%ebp)
     d83:	ff 75 f8             	pushl  -0x8(%ebp)
     d86:	ff 75 08             	pushl  0x8(%ebp)
     d89:	e8 bb fb ff ff       	call   949 <APGetIndex>
     d8e:	83 c4 0c             	add    $0xc,%esp
     d91:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d94:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d98:	74 55                	je     def <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d9a:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d9e:	74 67                	je     e07 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     da0:	ff 75 10             	pushl  0x10(%ebp)
     da3:	ff 75 0c             	pushl  0xc(%ebp)
     da6:	ff 75 fc             	pushl  -0x4(%ebp)
     da9:	ff 75 f8             	pushl  -0x8(%ebp)
     dac:	e8 5f fb ff ff       	call   910 <distance_2>
     db1:	83 c4 10             	add    $0x10,%esp
     db4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     db7:	7f 23                	jg     ddc <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     db9:	8b 45 08             	mov    0x8(%ebp),%eax
     dbc:	8b 48 18             	mov    0x18(%eax),%ecx
     dbf:	8b 55 ec             	mov    -0x14(%ebp),%edx
     dc2:	89 d0                	mov    %edx,%eax
     dc4:	01 c0                	add    %eax,%eax
     dc6:	01 d0                	add    %edx,%eax
     dc8:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dcb:	8b 45 08             	mov    0x8(%ebp),%eax
     dce:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dd2:	66 89 0a             	mov    %cx,(%edx)
     dd5:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     dd9:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ddc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     de0:	8b 55 0c             	mov    0xc(%ebp),%edx
     de3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de6:	01 d0                	add    %edx,%eax
     de8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     deb:	7d 93                	jge    d80 <APDrawPoint+0x59>
     ded:	eb 01                	jmp    df0 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     def:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     df0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     df4:	8b 55 10             	mov    0x10(%ebp),%edx
     df7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfa:	01 d0                	add    %edx,%eax
     dfc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     dff:	0f 8d 63 ff ff ff    	jge    d68 <APDrawPoint+0x41>
     e05:	eb 01                	jmp    e08 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e07:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e08:	c9                   	leave  
     e09:	c3                   	ret    

00000e0a <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e0a:	55                   	push   %ebp
     e0b:	89 e5                	mov    %esp,%ebp
     e0d:	53                   	push   %ebx
     e0e:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e11:	8b 45 0c             	mov    0xc(%ebp),%eax
     e14:	3b 45 14             	cmp    0x14(%ebp),%eax
     e17:	0f 85 80 00 00 00    	jne    e9d <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e1d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e21:	0f 88 9d 02 00 00    	js     10c4 <APDrawLine+0x2ba>
     e27:	8b 45 08             	mov    0x8(%ebp),%eax
     e2a:	8b 00                	mov    (%eax),%eax
     e2c:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e2f:	0f 8e 8f 02 00 00    	jle    10c4 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e35:	8b 45 10             	mov    0x10(%ebp),%eax
     e38:	3b 45 18             	cmp    0x18(%ebp),%eax
     e3b:	7e 12                	jle    e4f <APDrawLine+0x45>
        {
            int tmp = y2;
     e3d:	8b 45 18             	mov    0x18(%ebp),%eax
     e40:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e43:	8b 45 10             	mov    0x10(%ebp),%eax
     e46:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e49:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e4c:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e53:	79 07                	jns    e5c <APDrawLine+0x52>
     e55:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e5c:	8b 45 08             	mov    0x8(%ebp),%eax
     e5f:	8b 40 04             	mov    0x4(%eax),%eax
     e62:	3b 45 18             	cmp    0x18(%ebp),%eax
     e65:	7d 0c                	jge    e73 <APDrawLine+0x69>
     e67:	8b 45 08             	mov    0x8(%ebp),%eax
     e6a:	8b 40 04             	mov    0x4(%eax),%eax
     e6d:	83 e8 01             	sub    $0x1,%eax
     e70:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e73:	8b 45 10             	mov    0x10(%ebp),%eax
     e76:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e79:	eb 15                	jmp    e90 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e7b:	ff 75 f4             	pushl  -0xc(%ebp)
     e7e:	ff 75 0c             	pushl  0xc(%ebp)
     e81:	ff 75 08             	pushl  0x8(%ebp)
     e84:	e8 9e fe ff ff       	call   d27 <APDrawPoint>
     e89:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e8c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e93:	3b 45 18             	cmp    0x18(%ebp),%eax
     e96:	7e e3                	jle    e7b <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e98:	e9 2b 02 00 00       	jmp    10c8 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e9d:	8b 45 10             	mov    0x10(%ebp),%eax
     ea0:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea3:	75 7f                	jne    f24 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ea5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ea9:	0f 88 18 02 00 00    	js     10c7 <APDrawLine+0x2bd>
     eaf:	8b 45 08             	mov    0x8(%ebp),%eax
     eb2:	8b 40 04             	mov    0x4(%eax),%eax
     eb5:	3b 45 10             	cmp    0x10(%ebp),%eax
     eb8:	0f 8e 09 02 00 00    	jle    10c7 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec1:	3b 45 14             	cmp    0x14(%ebp),%eax
     ec4:	7e 12                	jle    ed8 <APDrawLine+0xce>
        {
            int tmp = x2;
     ec6:	8b 45 14             	mov    0x14(%ebp),%eax
     ec9:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecf:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ed2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ed5:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ed8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     edc:	79 07                	jns    ee5 <APDrawLine+0xdb>
     ede:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ee5:	8b 45 08             	mov    0x8(%ebp),%eax
     ee8:	8b 00                	mov    (%eax),%eax
     eea:	3b 45 14             	cmp    0x14(%ebp),%eax
     eed:	7d 0b                	jge    efa <APDrawLine+0xf0>
     eef:	8b 45 08             	mov    0x8(%ebp),%eax
     ef2:	8b 00                	mov    (%eax),%eax
     ef4:	83 e8 01             	sub    $0x1,%eax
     ef7:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     efa:	8b 45 0c             	mov    0xc(%ebp),%eax
     efd:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f00:	eb 15                	jmp    f17 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f02:	ff 75 10             	pushl  0x10(%ebp)
     f05:	ff 75 f0             	pushl  -0x10(%ebp)
     f08:	ff 75 08             	pushl  0x8(%ebp)
     f0b:	e8 17 fe ff ff       	call   d27 <APDrawPoint>
     f10:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f13:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f17:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f1a:	3b 45 14             	cmp    0x14(%ebp),%eax
     f1d:	7e e3                	jle    f02 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f1f:	e9 a4 01 00 00       	jmp    10c8 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f24:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f2b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f32:	8b 45 0c             	mov    0xc(%ebp),%eax
     f35:	2b 45 14             	sub    0x14(%ebp),%eax
     f38:	50                   	push   %eax
     f39:	e8 fb f9 ff ff       	call   939 <abs_int>
     f3e:	83 c4 04             	add    $0x4,%esp
     f41:	89 c3                	mov    %eax,%ebx
     f43:	8b 45 10             	mov    0x10(%ebp),%eax
     f46:	2b 45 18             	sub    0x18(%ebp),%eax
     f49:	50                   	push   %eax
     f4a:	e8 ea f9 ff ff       	call   939 <abs_int>
     f4f:	83 c4 04             	add    $0x4,%esp
     f52:	39 c3                	cmp    %eax,%ebx
     f54:	0f 8e b5 00 00 00    	jle    100f <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f5a:	8b 45 10             	mov    0x10(%ebp),%eax
     f5d:	2b 45 18             	sub    0x18(%ebp),%eax
     f60:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f63:	db 45 b0             	fildl  -0x50(%ebp)
     f66:	8b 45 0c             	mov    0xc(%ebp),%eax
     f69:	2b 45 14             	sub    0x14(%ebp),%eax
     f6c:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f6f:	db 45 b0             	fildl  -0x50(%ebp)
     f72:	de f9                	fdivrp %st,%st(1)
     f74:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f77:	8b 45 14             	mov    0x14(%ebp),%eax
     f7a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f7d:	7e 0e                	jle    f8d <APDrawLine+0x183>
        {
            s = x1;
     f7f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f82:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f85:	8b 45 14             	mov    0x14(%ebp),%eax
     f88:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f8b:	eb 0c                	jmp    f99 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f8d:	8b 45 14             	mov    0x14(%ebp),%eax
     f90:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f93:	8b 45 0c             	mov    0xc(%ebp),%eax
     f96:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f99:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f9d:	79 07                	jns    fa6 <APDrawLine+0x19c>
     f9f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     fa6:	8b 45 08             	mov    0x8(%ebp),%eax
     fa9:	8b 00                	mov    (%eax),%eax
     fab:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fae:	7f 0b                	jg     fbb <APDrawLine+0x1b1>
     fb0:	8b 45 08             	mov    0x8(%ebp),%eax
     fb3:	8b 00                	mov    (%eax),%eax
     fb5:	83 e8 01             	sub    $0x1,%eax
     fb8:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fc1:	eb 3f                	jmp    1002 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fc3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fc6:	2b 45 0c             	sub    0xc(%ebp),%eax
     fc9:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fcc:	db 45 b0             	fildl  -0x50(%ebp)
     fcf:	dc 4d d0             	fmull  -0x30(%ebp)
     fd2:	db 45 10             	fildl  0x10(%ebp)
     fd5:	de c1                	faddp  %st,%st(1)
     fd7:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fda:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fde:	b4 0c                	mov    $0xc,%ah
     fe0:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fe4:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fe7:	db 5d cc             	fistpl -0x34(%ebp)
     fea:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fed:	ff 75 cc             	pushl  -0x34(%ebp)
     ff0:	ff 75 e4             	pushl  -0x1c(%ebp)
     ff3:	ff 75 08             	pushl  0x8(%ebp)
     ff6:	e8 2c fd ff ff       	call   d27 <APDrawPoint>
     ffb:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     ffe:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1002:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1005:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1008:	7e b9                	jle    fc3 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    100a:	e9 b9 00 00 00       	jmp    10c8 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    100f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1012:	2b 45 14             	sub    0x14(%ebp),%eax
    1015:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1018:	db 45 b0             	fildl  -0x50(%ebp)
    101b:	8b 45 10             	mov    0x10(%ebp),%eax
    101e:	2b 45 18             	sub    0x18(%ebp),%eax
    1021:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1024:	db 45 b0             	fildl  -0x50(%ebp)
    1027:	de f9                	fdivrp %st,%st(1)
    1029:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    102c:	8b 45 10             	mov    0x10(%ebp),%eax
    102f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1032:	7e 0e                	jle    1042 <APDrawLine+0x238>
    {
        s = y2;
    1034:	8b 45 18             	mov    0x18(%ebp),%eax
    1037:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    103a:	8b 45 10             	mov    0x10(%ebp),%eax
    103d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1040:	eb 0c                	jmp    104e <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1042:	8b 45 10             	mov    0x10(%ebp),%eax
    1045:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1048:	8b 45 18             	mov    0x18(%ebp),%eax
    104b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    104e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1052:	79 07                	jns    105b <APDrawLine+0x251>
    1054:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    105b:	8b 45 08             	mov    0x8(%ebp),%eax
    105e:	8b 40 04             	mov    0x4(%eax),%eax
    1061:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1064:	7f 0c                	jg     1072 <APDrawLine+0x268>
    1066:	8b 45 08             	mov    0x8(%ebp),%eax
    1069:	8b 40 04             	mov    0x4(%eax),%eax
    106c:	83 e8 01             	sub    $0x1,%eax
    106f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1072:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1075:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1078:	eb 3f                	jmp    10b9 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    107a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    107d:	2b 45 10             	sub    0x10(%ebp),%eax
    1080:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1083:	db 45 b0             	fildl  -0x50(%ebp)
    1086:	dc 4d c0             	fmull  -0x40(%ebp)
    1089:	db 45 0c             	fildl  0xc(%ebp)
    108c:	de c1                	faddp  %st,%st(1)
    108e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1091:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1095:	b4 0c                	mov    $0xc,%ah
    1097:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    109b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    109e:	db 5d bc             	fistpl -0x44(%ebp)
    10a1:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10a4:	ff 75 e0             	pushl  -0x20(%ebp)
    10a7:	ff 75 bc             	pushl  -0x44(%ebp)
    10aa:	ff 75 08             	pushl  0x8(%ebp)
    10ad:	e8 75 fc ff ff       	call   d27 <APDrawPoint>
    10b2:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10b5:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10bc:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10bf:	7e b9                	jle    107a <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10c1:	90                   	nop
    10c2:	eb 04                	jmp    10c8 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10c4:	90                   	nop
    10c5:	eb 01                	jmp    10c8 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10c7:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10cb:	c9                   	leave  
    10cc:	c3                   	ret    

000010cd <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10cd:	55                   	push   %ebp
    10ce:	89 e5                	mov    %esp,%ebp
    10d0:	53                   	push   %ebx
    10d1:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10d4:	8b 55 10             	mov    0x10(%ebp),%edx
    10d7:	8b 45 18             	mov    0x18(%ebp),%eax
    10da:	01 d0                	add    %edx,%eax
    10dc:	83 e8 01             	sub    $0x1,%eax
    10df:	83 ec 04             	sub    $0x4,%esp
    10e2:	50                   	push   %eax
    10e3:	ff 75 0c             	pushl  0xc(%ebp)
    10e6:	ff 75 10             	pushl  0x10(%ebp)
    10e9:	ff 75 0c             	pushl  0xc(%ebp)
    10ec:	ff 75 08             	pushl  0x8(%ebp)
    10ef:	e8 16 fd ff ff       	call   e0a <APDrawLine>
    10f4:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    10fa:	8b 45 14             	mov    0x14(%ebp),%eax
    10fd:	01 d0                	add    %edx,%eax
    10ff:	83 e8 01             	sub    $0x1,%eax
    1102:	83 ec 04             	sub    $0x4,%esp
    1105:	ff 75 10             	pushl  0x10(%ebp)
    1108:	50                   	push   %eax
    1109:	ff 75 10             	pushl  0x10(%ebp)
    110c:	ff 75 0c             	pushl  0xc(%ebp)
    110f:	ff 75 08             	pushl  0x8(%ebp)
    1112:	e8 f3 fc ff ff       	call   e0a <APDrawLine>
    1117:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    111a:	8b 55 10             	mov    0x10(%ebp),%edx
    111d:	8b 45 18             	mov    0x18(%ebp),%eax
    1120:	01 d0                	add    %edx,%eax
    1122:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1125:	8b 55 0c             	mov    0xc(%ebp),%edx
    1128:	8b 45 14             	mov    0x14(%ebp),%eax
    112b:	01 d0                	add    %edx,%eax
    112d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1130:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1133:	8b 45 14             	mov    0x14(%ebp),%eax
    1136:	01 d8                	add    %ebx,%eax
    1138:	83 e8 01             	sub    $0x1,%eax
    113b:	83 ec 04             	sub    $0x4,%esp
    113e:	51                   	push   %ecx
    113f:	52                   	push   %edx
    1140:	ff 75 10             	pushl  0x10(%ebp)
    1143:	50                   	push   %eax
    1144:	ff 75 08             	pushl  0x8(%ebp)
    1147:	e8 be fc ff ff       	call   e0a <APDrawLine>
    114c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    114f:	8b 55 10             	mov    0x10(%ebp),%edx
    1152:	8b 45 18             	mov    0x18(%ebp),%eax
    1155:	01 d0                	add    %edx,%eax
    1157:	8d 48 ff             	lea    -0x1(%eax),%ecx
    115a:	8b 55 0c             	mov    0xc(%ebp),%edx
    115d:	8b 45 14             	mov    0x14(%ebp),%eax
    1160:	01 d0                	add    %edx,%eax
    1162:	8d 50 ff             	lea    -0x1(%eax),%edx
    1165:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1168:	8b 45 18             	mov    0x18(%ebp),%eax
    116b:	01 d8                	add    %ebx,%eax
    116d:	83 e8 01             	sub    $0x1,%eax
    1170:	83 ec 04             	sub    $0x4,%esp
    1173:	51                   	push   %ecx
    1174:	52                   	push   %edx
    1175:	50                   	push   %eax
    1176:	ff 75 0c             	pushl  0xc(%ebp)
    1179:	ff 75 08             	pushl  0x8(%ebp)
    117c:	e8 89 fc ff ff       	call   e0a <APDrawLine>
    1181:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1184:	8b 55 0c             	mov    0xc(%ebp),%edx
    1187:	8b 45 14             	mov    0x14(%ebp),%eax
    118a:	01 d0                	add    %edx,%eax
    118c:	8d 50 ff             	lea    -0x1(%eax),%edx
    118f:	8b 45 08             	mov    0x8(%ebp),%eax
    1192:	8b 40 0c             	mov    0xc(%eax),%eax
    1195:	89 c1                	mov    %eax,%ecx
    1197:	c1 e9 1f             	shr    $0x1f,%ecx
    119a:	01 c8                	add    %ecx,%eax
    119c:	d1 f8                	sar    %eax
    119e:	29 c2                	sub    %eax,%edx
    11a0:	89 d0                	mov    %edx,%eax
    11a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11a5:	8b 55 10             	mov    0x10(%ebp),%edx
    11a8:	8b 45 18             	mov    0x18(%ebp),%eax
    11ab:	01 d0                	add    %edx,%eax
    11ad:	8d 50 ff             	lea    -0x1(%eax),%edx
    11b0:	8b 45 08             	mov    0x8(%ebp),%eax
    11b3:	8b 40 0c             	mov    0xc(%eax),%eax
    11b6:	89 c1                	mov    %eax,%ecx
    11b8:	c1 e9 1f             	shr    $0x1f,%ecx
    11bb:	01 c8                	add    %ecx,%eax
    11bd:	d1 f8                	sar    %eax
    11bf:	29 c2                	sub    %eax,%edx
    11c1:	89 d0                	mov    %edx,%eax
    11c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11c6:	8b 45 08             	mov    0x8(%ebp),%eax
    11c9:	8b 40 0c             	mov    0xc(%eax),%eax
    11cc:	89 c2                	mov    %eax,%edx
    11ce:	c1 ea 1f             	shr    $0x1f,%edx
    11d1:	01 d0                	add    %edx,%eax
    11d3:	d1 f8                	sar    %eax
    11d5:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11d8:	8b 45 08             	mov    0x8(%ebp),%eax
    11db:	8b 40 0c             	mov    0xc(%eax),%eax
    11de:	89 c2                	mov    %eax,%edx
    11e0:	c1 ea 1f             	shr    $0x1f,%edx
    11e3:	01 d0                	add    %edx,%eax
    11e5:	d1 f8                	sar    %eax
    11e7:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11ee:	0f 88 d8 00 00 00    	js     12cc <APDrawRect+0x1ff>
    11f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11f8:	0f 88 ce 00 00 00    	js     12cc <APDrawRect+0x1ff>
    11fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1201:	8b 00                	mov    (%eax),%eax
    1203:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1206:	0f 8e c0 00 00 00    	jle    12cc <APDrawRect+0x1ff>
    120c:	8b 45 08             	mov    0x8(%ebp),%eax
    120f:	8b 40 04             	mov    0x4(%eax),%eax
    1212:	3b 45 10             	cmp    0x10(%ebp),%eax
    1215:	0f 8e b1 00 00 00    	jle    12cc <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    121b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    121f:	79 07                	jns    1228 <APDrawRect+0x15b>
    1221:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1228:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    122c:	79 07                	jns    1235 <APDrawRect+0x168>
    122e:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1235:	8b 45 08             	mov    0x8(%ebp),%eax
    1238:	8b 00                	mov    (%eax),%eax
    123a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    123d:	7f 0b                	jg     124a <APDrawRect+0x17d>
    123f:	8b 45 08             	mov    0x8(%ebp),%eax
    1242:	8b 00                	mov    (%eax),%eax
    1244:	83 e8 01             	sub    $0x1,%eax
    1247:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    124a:	8b 45 08             	mov    0x8(%ebp),%eax
    124d:	8b 40 04             	mov    0x4(%eax),%eax
    1250:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1253:	7f 0c                	jg     1261 <APDrawRect+0x194>
    1255:	8b 45 08             	mov    0x8(%ebp),%eax
    1258:	8b 40 04             	mov    0x4(%eax),%eax
    125b:	83 e8 01             	sub    $0x1,%eax
    125e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1261:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1268:	8b 45 0c             	mov    0xc(%ebp),%eax
    126b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    126e:	eb 52                	jmp    12c2 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1270:	8b 45 10             	mov    0x10(%ebp),%eax
    1273:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1276:	eb 3e                	jmp    12b6 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1278:	83 ec 04             	sub    $0x4,%esp
    127b:	ff 75 e8             	pushl  -0x18(%ebp)
    127e:	ff 75 ec             	pushl  -0x14(%ebp)
    1281:	ff 75 08             	pushl  0x8(%ebp)
    1284:	e8 c0 f6 ff ff       	call   949 <APGetIndex>
    1289:	83 c4 10             	add    $0x10,%esp
    128c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    128f:	8b 45 08             	mov    0x8(%ebp),%eax
    1292:	8b 48 18             	mov    0x18(%eax),%ecx
    1295:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1298:	89 d0                	mov    %edx,%eax
    129a:	01 c0                	add    %eax,%eax
    129c:	01 d0                	add    %edx,%eax
    129e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12a1:	8b 45 08             	mov    0x8(%ebp),%eax
    12a4:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12a8:	66 89 0a             	mov    %cx,(%edx)
    12ab:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12af:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12b2:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12b9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12bc:	7e ba                	jle    1278 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12be:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12c5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12c8:	7e a6                	jle    1270 <APDrawRect+0x1a3>
    12ca:	eb 01                	jmp    12cd <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12cc:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12d0:	c9                   	leave  
    12d1:	c3                   	ret    

000012d2 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    12d2:	55                   	push   %ebp
    12d3:	89 e5                	mov    %esp,%ebp
    12d5:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    12d8:	83 ec 0c             	sub    $0xc,%esp
    12db:	ff 75 0c             	pushl  0xc(%ebp)
    12de:	e8 c1 ee ff ff       	call   1a4 <strlen>
    12e3:	83 c4 10             	add    $0x10,%esp
    12e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    12e9:	8b 45 08             	mov    0x8(%ebp),%eax
    12ec:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    12f0:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    12f4:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    12f8:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    12fb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1302:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1309:	e9 bc 00 00 00       	jmp    13ca <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    130e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1311:	8b 45 0c             	mov    0xc(%ebp),%eax
    1314:	01 d0                	add    %edx,%eax
    1316:	0f b6 00             	movzbl (%eax),%eax
    1319:	0f be c0             	movsbl %al,%eax
    131c:	83 e8 20             	sub    $0x20,%eax
    131f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1322:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1326:	0f 87 9a 00 00 00    	ja     13c6 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    132c:	8b 45 08             	mov    0x8(%ebp),%eax
    132f:	8b 00                	mov    (%eax),%eax
    1331:	0f af 45 14          	imul   0x14(%ebp),%eax
    1335:	89 c2                	mov    %eax,%edx
    1337:	8b 45 10             	mov    0x10(%ebp),%eax
    133a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    133d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1340:	89 d0                	mov    %edx,%eax
    1342:	c1 e0 03             	shl    $0x3,%eax
    1345:	01 d0                	add    %edx,%eax
    1347:	01 c8                	add    %ecx,%eax
    1349:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    134c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1353:	eb 6b                	jmp    13c0 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1355:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    135c:	eb 50                	jmp    13ae <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    135e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1361:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1364:	89 d0                	mov    %edx,%eax
    1366:	c1 e0 03             	shl    $0x3,%eax
    1369:	01 d0                	add    %edx,%eax
    136b:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    1371:	01 c2                	add    %eax,%edx
    1373:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1376:	01 d0                	add    %edx,%eax
    1378:	05 e0 2b 00 00       	add    $0x2be0,%eax
    137d:	0f b6 00             	movzbl (%eax),%eax
    1380:	84 c0                	test   %al,%al
    1382:	74 26                	je     13aa <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    1384:	8b 45 08             	mov    0x8(%ebp),%eax
    1387:	8b 50 18             	mov    0x18(%eax),%edx
    138a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    138d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1390:	01 c8                	add    %ecx,%eax
    1392:	89 c1                	mov    %eax,%ecx
    1394:	89 c8                	mov    %ecx,%eax
    1396:	01 c0                	add    %eax,%eax
    1398:	01 c8                	add    %ecx,%eax
    139a:	01 d0                	add    %edx,%eax
    139c:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13a0:	66 89 10             	mov    %dx,(%eax)
    13a3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13a7:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    13aa:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13ae:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    13b2:	7e aa                	jle    135e <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    13b4:	8b 45 08             	mov    0x8(%ebp),%eax
    13b7:	8b 00                	mov    (%eax),%eax
    13b9:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    13bc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    13c0:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    13c4:	7e 8f                	jle    1355 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    13c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13cd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    13d0:	0f 82 38 ff ff ff    	jb     130e <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    13d6:	90                   	nop
    13d7:	c9                   	leave  
    13d8:	c3                   	ret    

000013d9 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    13d9:	55                   	push   %ebp
    13da:	89 e5                	mov    %esp,%ebp
    13dc:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    13df:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    13e3:	0f 88 8e 01 00 00    	js     1577 <APDcCopy+0x19e>
    13e9:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    13ed:	0f 88 84 01 00 00    	js     1577 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    13f3:	8b 55 0c             	mov    0xc(%ebp),%edx
    13f6:	8b 45 20             	mov    0x20(%ebp),%eax
    13f9:	01 d0                	add    %edx,%eax
    13fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13fe:	8b 55 10             	mov    0x10(%ebp),%edx
    1401:	8b 45 24             	mov    0x24(%ebp),%eax
    1404:	01 d0                	add    %edx,%eax
    1406:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1409:	8b 55 18             	mov    0x18(%ebp),%edx
    140c:	8b 45 20             	mov    0x20(%ebp),%eax
    140f:	01 d0                	add    %edx,%eax
    1411:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1414:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1417:	8b 45 24             	mov    0x24(%ebp),%eax
    141a:	01 d0                	add    %edx,%eax
    141c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    141f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1423:	0f 88 51 01 00 00    	js     157a <APDcCopy+0x1a1>
    1429:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    142d:	0f 88 47 01 00 00    	js     157a <APDcCopy+0x1a1>
    1433:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1437:	0f 88 3d 01 00 00    	js     157a <APDcCopy+0x1a1>
    143d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1441:	0f 88 33 01 00 00    	js     157a <APDcCopy+0x1a1>
    1447:	8b 45 14             	mov    0x14(%ebp),%eax
    144a:	8b 00                	mov    (%eax),%eax
    144c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    144f:	0f 8c 25 01 00 00    	jl     157a <APDcCopy+0x1a1>
    1455:	8b 45 14             	mov    0x14(%ebp),%eax
    1458:	8b 40 04             	mov    0x4(%eax),%eax
    145b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    145e:	0f 8c 16 01 00 00    	jl     157a <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1464:	8b 45 08             	mov    0x8(%ebp),%eax
    1467:	8b 00                	mov    (%eax),%eax
    1469:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    146c:	7f 0b                	jg     1479 <APDcCopy+0xa0>
    146e:	8b 45 08             	mov    0x8(%ebp),%eax
    1471:	8b 00                	mov    (%eax),%eax
    1473:	83 e8 01             	sub    $0x1,%eax
    1476:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1479:	8b 45 08             	mov    0x8(%ebp),%eax
    147c:	8b 40 04             	mov    0x4(%eax),%eax
    147f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1482:	7f 0c                	jg     1490 <APDcCopy+0xb7>
    1484:	8b 45 08             	mov    0x8(%ebp),%eax
    1487:	8b 40 04             	mov    0x4(%eax),%eax
    148a:	83 e8 01             	sub    $0x1,%eax
    148d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1490:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1497:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    149e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14a5:	e9 bc 00 00 00       	jmp    1566 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14aa:	8b 45 08             	mov    0x8(%ebp),%eax
    14ad:	8b 00                	mov    (%eax),%eax
    14af:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14b2:	8b 55 10             	mov    0x10(%ebp),%edx
    14b5:	01 ca                	add    %ecx,%edx
    14b7:	0f af d0             	imul   %eax,%edx
    14ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    14bd:	01 d0                	add    %edx,%eax
    14bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    14c2:	8b 45 14             	mov    0x14(%ebp),%eax
    14c5:	8b 00                	mov    (%eax),%eax
    14c7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14ca:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14cd:	01 ca                	add    %ecx,%edx
    14cf:	0f af d0             	imul   %eax,%edx
    14d2:	8b 45 18             	mov    0x18(%ebp),%eax
    14d5:	01 d0                	add    %edx,%eax
    14d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    14da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14e1:	eb 74                	jmp    1557 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    14e3:	8b 45 14             	mov    0x14(%ebp),%eax
    14e6:	8b 50 18             	mov    0x18(%eax),%edx
    14e9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    14ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ef:	01 c8                	add    %ecx,%eax
    14f1:	89 c1                	mov    %eax,%ecx
    14f3:	89 c8                	mov    %ecx,%eax
    14f5:	01 c0                	add    %eax,%eax
    14f7:	01 c8                	add    %ecx,%eax
    14f9:	01 d0                	add    %edx,%eax
    14fb:	0f b7 10             	movzwl (%eax),%edx
    14fe:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1502:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1506:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1509:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    150d:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1511:	38 c2                	cmp    %al,%dl
    1513:	75 18                	jne    152d <APDcCopy+0x154>
    1515:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1519:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    151d:	38 c2                	cmp    %al,%dl
    151f:	75 0c                	jne    152d <APDcCopy+0x154>
    1521:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1525:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1529:	38 c2                	cmp    %al,%dl
    152b:	74 26                	je     1553 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    152d:	8b 45 08             	mov    0x8(%ebp),%eax
    1530:	8b 50 18             	mov    0x18(%eax),%edx
    1533:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1536:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1539:	01 c8                	add    %ecx,%eax
    153b:	89 c1                	mov    %eax,%ecx
    153d:	89 c8                	mov    %ecx,%eax
    153f:	01 c0                	add    %eax,%eax
    1541:	01 c8                	add    %ecx,%eax
    1543:	01 d0                	add    %edx,%eax
    1545:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1549:	66 89 10             	mov    %dx,(%eax)
    154c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1550:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1553:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1557:	8b 45 fc             	mov    -0x4(%ebp),%eax
    155a:	2b 45 0c             	sub    0xc(%ebp),%eax
    155d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1560:	7d 81                	jge    14e3 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1562:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1566:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1569:	2b 45 10             	sub    0x10(%ebp),%eax
    156c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    156f:	0f 8d 35 ff ff ff    	jge    14aa <APDcCopy+0xd1>
    1575:	eb 04                	jmp    157b <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1577:	90                   	nop
    1578:	eb 01                	jmp    157b <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    157a:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    157b:	c9                   	leave  
    157c:	c3                   	ret    

0000157d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    157d:	55                   	push   %ebp
    157e:	89 e5                	mov    %esp,%ebp
    1580:	83 ec 1c             	sub    $0x1c,%esp
    1583:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1586:	8b 55 10             	mov    0x10(%ebp),%edx
    1589:	8b 45 14             	mov    0x14(%ebp),%eax
    158c:	88 4d ec             	mov    %cl,-0x14(%ebp)
    158f:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1592:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1595:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1599:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    159c:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15a0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15a3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15a7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15aa:	8b 45 08             	mov    0x8(%ebp),%eax
    15ad:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15b1:	66 89 10             	mov    %dx,(%eax)
    15b4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15b8:	88 50 02             	mov    %dl,0x2(%eax)
}
    15bb:	8b 45 08             	mov    0x8(%ebp),%eax
    15be:	c9                   	leave  
    15bf:	c2 04 00             	ret    $0x4

000015c2 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    15c2:	55                   	push   %ebp
    15c3:	89 e5                	mov    %esp,%ebp
    15c5:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    15c8:	8b 45 08             	mov    0x8(%ebp),%eax
    15cb:	8b 00                	mov    (%eax),%eax
    15cd:	83 ec 08             	sub    $0x8,%esp
    15d0:	8d 55 0c             	lea    0xc(%ebp),%edx
    15d3:	52                   	push   %edx
    15d4:	50                   	push   %eax
    15d5:	e8 34 ee ff ff       	call   40e <sendMessage>
    15da:	83 c4 10             	add    $0x10,%esp
}
    15dd:	90                   	nop
    15de:	c9                   	leave  
    15df:	c3                   	ret    

000015e0 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    15e6:	83 ec 0c             	sub    $0xc,%esp
    15e9:	68 98 00 00 00       	push   $0x98
    15ee:	e8 f5 f1 ff ff       	call   7e8 <malloc>
    15f3:	83 c4 10             	add    $0x10,%esp
    15f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    15f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15fd:	75 15                	jne    1614 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    15ff:	83 ec 04             	sub    $0x4,%esp
    1602:	ff 75 08             	pushl  0x8(%ebp)
    1605:	68 c0 24 00 00       	push   $0x24c0
    160a:	6a 01                	push   $0x1
    160c:	e8 04 ef ff ff       	call   515 <printf>
    1611:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1614:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1617:	05 84 00 00 00       	add    $0x84,%eax
    161c:	83 ec 08             	sub    $0x8,%esp
    161f:	ff 75 08             	pushl  0x8(%ebp)
    1622:	50                   	push   %eax
    1623:	e8 0d eb ff ff       	call   135 <strcpy>
    1628:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    162b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162e:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    163f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1642:	8b 40 3c             	mov    0x3c(%eax),%eax
    1645:	89 c2                	mov    %eax,%edx
    1647:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164a:	8b 40 40             	mov    0x40(%eax),%eax
    164d:	0f af d0             	imul   %eax,%edx
    1650:	89 d0                	mov    %edx,%eax
    1652:	01 c0                	add    %eax,%eax
    1654:	01 d0                	add    %edx,%eax
    1656:	83 ec 0c             	sub    $0xc,%esp
    1659:	50                   	push   %eax
    165a:	e8 89 f1 ff ff       	call   7e8 <malloc>
    165f:	83 c4 10             	add    $0x10,%esp
    1662:	89 c2                	mov    %eax,%edx
    1664:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1667:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166d:	8b 40 54             	mov    0x54(%eax),%eax
    1670:	85 c0                	test   %eax,%eax
    1672:	75 15                	jne    1689 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1674:	83 ec 04             	sub    $0x4,%esp
    1677:	ff 75 08             	pushl  0x8(%ebp)
    167a:	68 e0 24 00 00       	push   $0x24e0
    167f:	6a 01                	push   $0x1
    1681:	e8 8f ee ff ff       	call   515 <printf>
    1686:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1689:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168c:	8b 40 3c             	mov    0x3c(%eax),%eax
    168f:	89 c2                	mov    %eax,%edx
    1691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1694:	8b 40 40             	mov    0x40(%eax),%eax
    1697:	0f af d0             	imul   %eax,%edx
    169a:	89 d0                	mov    %edx,%eax
    169c:	01 c0                	add    %eax,%eax
    169e:	01 c2                	add    %eax,%edx
    16a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a3:	8b 40 54             	mov    0x54(%eax),%eax
    16a6:	83 ec 04             	sub    $0x4,%esp
    16a9:	52                   	push   %edx
    16aa:	68 ff ff ff 00       	push   $0xffffff
    16af:	50                   	push   %eax
    16b0:	e8 16 eb ff ff       	call   1cb <memset>
    16b5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bb:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    16c2:	e8 1f ed ff ff       	call   3e6 <getpid>
    16c7:	89 c2                	mov    %eax,%edx
    16c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cc:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    16cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d2:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    16d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16dc:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    16e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e6:	8b 40 58             	mov    0x58(%eax),%eax
    16e9:	89 c2                	mov    %eax,%edx
    16eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ee:	8b 40 5c             	mov    0x5c(%eax),%eax
    16f1:	0f af d0             	imul   %eax,%edx
    16f4:	89 d0                	mov    %edx,%eax
    16f6:	01 c0                	add    %eax,%eax
    16f8:	01 d0                	add    %edx,%eax
    16fa:	83 ec 0c             	sub    $0xc,%esp
    16fd:	50                   	push   %eax
    16fe:	e8 e5 f0 ff ff       	call   7e8 <malloc>
    1703:	83 c4 10             	add    $0x10,%esp
    1706:	89 c2                	mov    %eax,%edx
    1708:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170b:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    170e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1711:	8b 40 70             	mov    0x70(%eax),%eax
    1714:	85 c0                	test   %eax,%eax
    1716:	75 15                	jne    172d <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1718:	83 ec 04             	sub    $0x4,%esp
    171b:	ff 75 08             	pushl  0x8(%ebp)
    171e:	68 04 25 00 00       	push   $0x2504
    1723:	6a 01                	push   $0x1
    1725:	e8 eb ed ff ff       	call   515 <printf>
    172a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1730:	8b 40 3c             	mov    0x3c(%eax),%eax
    1733:	89 c2                	mov    %eax,%edx
    1735:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1738:	8b 40 40             	mov    0x40(%eax),%eax
    173b:	0f af d0             	imul   %eax,%edx
    173e:	89 d0                	mov    %edx,%eax
    1740:	01 c0                	add    %eax,%eax
    1742:	01 c2                	add    %eax,%edx
    1744:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1747:	8b 40 54             	mov    0x54(%eax),%eax
    174a:	83 ec 04             	sub    $0x4,%esp
    174d:	52                   	push   %edx
    174e:	68 ff 00 00 00       	push   $0xff
    1753:	50                   	push   %eax
    1754:	e8 72 ea ff ff       	call   1cb <memset>
    1759:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    175c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1762:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1765:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1769:	74 49                	je     17b4 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    176b:	8b 45 10             	mov    0x10(%ebp),%eax
    176e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1774:	83 ec 0c             	sub    $0xc,%esp
    1777:	50                   	push   %eax
    1778:	e8 6b f0 ff ff       	call   7e8 <malloc>
    177d:	83 c4 10             	add    $0x10,%esp
    1780:	89 c2                	mov    %eax,%edx
    1782:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1785:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1788:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178b:	8b 55 10             	mov    0x10(%ebp),%edx
    178e:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1791:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1794:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    179b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    17a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    17af:	e9 8d 00 00 00       	jmp    1841 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    17b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b7:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    17be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c1:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    17c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cb:	8b 40 20             	mov    0x20(%eax),%eax
    17ce:	89 c2                	mov    %eax,%edx
    17d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d3:	8b 40 24             	mov    0x24(%eax),%eax
    17d6:	0f af d0             	imul   %eax,%edx
    17d9:	89 d0                	mov    %edx,%eax
    17db:	01 c0                	add    %eax,%eax
    17dd:	01 d0                	add    %edx,%eax
    17df:	83 ec 0c             	sub    $0xc,%esp
    17e2:	50                   	push   %eax
    17e3:	e8 00 f0 ff ff       	call   7e8 <malloc>
    17e8:	83 c4 10             	add    $0x10,%esp
    17eb:	89 c2                	mov    %eax,%edx
    17ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f0:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    17f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f6:	8b 40 38             	mov    0x38(%eax),%eax
    17f9:	85 c0                	test   %eax,%eax
    17fb:	75 15                	jne    1812 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    17fd:	83 ec 04             	sub    $0x4,%esp
    1800:	ff 75 08             	pushl  0x8(%ebp)
    1803:	68 2c 25 00 00       	push   $0x252c
    1808:	6a 01                	push   $0x1
    180a:	e8 06 ed ff ff       	call   515 <printf>
    180f:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1812:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1815:	8b 40 20             	mov    0x20(%eax),%eax
    1818:	89 c2                	mov    %eax,%edx
    181a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181d:	8b 40 24             	mov    0x24(%eax),%eax
    1820:	0f af d0             	imul   %eax,%edx
    1823:	89 d0                	mov    %edx,%eax
    1825:	01 c0                	add    %eax,%eax
    1827:	01 c2                	add    %eax,%edx
    1829:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182c:	8b 40 38             	mov    0x38(%eax),%eax
    182f:	83 ec 04             	sub    $0x4,%esp
    1832:	52                   	push   %edx
    1833:	68 ff ff ff 00       	push   $0xffffff
    1838:	50                   	push   %eax
    1839:	e8 8d e9 ff ff       	call   1cb <memset>
    183e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1841:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1844:	c9                   	leave  
    1845:	c3                   	ret    

00001846 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1846:	55                   	push   %ebp
    1847:	89 e5                	mov    %esp,%ebp
    1849:	57                   	push   %edi
    184a:	56                   	push   %esi
    184b:	53                   	push   %ebx
    184c:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    184f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1852:	83 f8 03             	cmp    $0x3,%eax
    1855:	74 02                	je     1859 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1857:	eb 7c                	jmp    18d5 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1859:	8b 45 08             	mov    0x8(%ebp),%eax
    185c:	8b 58 1c             	mov    0x1c(%eax),%ebx
    185f:	8b 45 08             	mov    0x8(%ebp),%eax
    1862:	8b 48 18             	mov    0x18(%eax),%ecx
    1865:	8b 45 08             	mov    0x8(%ebp),%eax
    1868:	8b 50 5c             	mov    0x5c(%eax),%edx
    186b:	8b 45 08             	mov    0x8(%ebp),%eax
    186e:	8b 40 58             	mov    0x58(%eax),%eax
    1871:	8b 75 08             	mov    0x8(%ebp),%esi
    1874:	83 c6 58             	add    $0x58,%esi
    1877:	83 ec 04             	sub    $0x4,%esp
    187a:	53                   	push   %ebx
    187b:	51                   	push   %ecx
    187c:	6a 00                	push   $0x0
    187e:	52                   	push   %edx
    187f:	50                   	push   %eax
    1880:	6a 00                	push   $0x0
    1882:	6a 00                	push   $0x0
    1884:	56                   	push   %esi
    1885:	6a 00                	push   $0x0
    1887:	6a 00                	push   $0x0
    1889:	ff 75 08             	pushl  0x8(%ebp)
    188c:	e8 75 eb ff ff       	call   406 <paintWindow>
    1891:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1894:	8b 45 08             	mov    0x8(%ebp),%eax
    1897:	8b 70 1c             	mov    0x1c(%eax),%esi
    189a:	8b 45 08             	mov    0x8(%ebp),%eax
    189d:	8b 58 18             	mov    0x18(%eax),%ebx
    18a0:	8b 45 08             	mov    0x8(%ebp),%eax
    18a3:	8b 48 08             	mov    0x8(%eax),%ecx
    18a6:	8b 45 08             	mov    0x8(%ebp),%eax
    18a9:	8b 50 40             	mov    0x40(%eax),%edx
    18ac:	8b 45 08             	mov    0x8(%ebp),%eax
    18af:	8b 40 3c             	mov    0x3c(%eax),%eax
    18b2:	8b 7d 08             	mov    0x8(%ebp),%edi
    18b5:	83 c7 3c             	add    $0x3c,%edi
    18b8:	83 ec 04             	sub    $0x4,%esp
    18bb:	56                   	push   %esi
    18bc:	53                   	push   %ebx
    18bd:	51                   	push   %ecx
    18be:	52                   	push   %edx
    18bf:	50                   	push   %eax
    18c0:	6a 00                	push   $0x0
    18c2:	6a 00                	push   $0x0
    18c4:	57                   	push   %edi
    18c5:	6a 32                	push   $0x32
    18c7:	6a 00                	push   $0x0
    18c9:	ff 75 08             	pushl  0x8(%ebp)
    18cc:	e8 35 eb ff ff       	call   406 <paintWindow>
    18d1:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    18d4:	90                   	nop
        default: break;
            
            
    }
    return False;
    18d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    18da:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18dd:	5b                   	pop    %ebx
    18de:	5e                   	pop    %esi
    18df:	5f                   	pop    %edi
    18e0:	5d                   	pop    %ebp
    18e1:	c3                   	ret    

000018e2 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    18e2:	55                   	push   %ebp
    18e3:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    18e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e8:	8b 50 08             	mov    0x8(%eax),%edx
    18eb:	8b 45 08             	mov    0x8(%ebp),%eax
    18ee:	8b 00                	mov    (%eax),%eax
    18f0:	39 c2                	cmp    %eax,%edx
    18f2:	74 07                	je     18fb <APPreJudge+0x19>
        return False;
    18f4:	b8 00 00 00 00       	mov    $0x0,%eax
    18f9:	eb 05                	jmp    1900 <APPreJudge+0x1e>
    return True;
    18fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1900:	5d                   	pop    %ebp
    1901:	c3                   	ret    

00001902 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1902:	55                   	push   %ebp
    1903:	89 e5                	mov    %esp,%ebp
    1905:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1908:	8b 45 08             	mov    0x8(%ebp),%eax
    190b:	8b 55 0c             	mov    0xc(%ebp),%edx
    190e:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1914:	83 ec 0c             	sub    $0xc,%esp
    1917:	ff 75 08             	pushl  0x8(%ebp)
    191a:	e8 ff ea ff ff       	call   41e <registWindow>
    191f:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1922:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1929:	8b 45 08             	mov    0x8(%ebp),%eax
    192c:	8b 00                	mov    (%eax),%eax
    192e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1931:	ff 75 f4             	pushl  -0xc(%ebp)
    1934:	ff 75 f0             	pushl  -0x10(%ebp)
    1937:	ff 75 ec             	pushl  -0x14(%ebp)
    193a:	ff 75 08             	pushl  0x8(%ebp)
    193d:	e8 80 fc ff ff       	call   15c2 <APSendMessage>
    1942:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1945:	83 ec 0c             	sub    $0xc,%esp
    1948:	ff 75 08             	pushl  0x8(%ebp)
    194b:	e8 c6 ea ff ff       	call   416 <getMessage>
    1950:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1953:	8b 45 08             	mov    0x8(%ebp),%eax
    1956:	83 c0 74             	add    $0x74,%eax
    1959:	83 ec 08             	sub    $0x8,%esp
    195c:	50                   	push   %eax
    195d:	ff 75 08             	pushl  0x8(%ebp)
    1960:	e8 7d ff ff ff       	call   18e2 <APPreJudge>
    1965:	83 c4 10             	add    $0x10,%esp
    1968:	84 c0                	test   %al,%al
    196a:	74 1b                	je     1987 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    196c:	8b 45 08             	mov    0x8(%ebp),%eax
    196f:	ff 70 7c             	pushl  0x7c(%eax)
    1972:	ff 70 78             	pushl  0x78(%eax)
    1975:	ff 70 74             	pushl  0x74(%eax)
    1978:	ff 75 08             	pushl  0x8(%ebp)
    197b:	8b 45 0c             	mov    0xc(%ebp),%eax
    197e:	ff d0                	call   *%eax
    1980:	83 c4 10             	add    $0x10,%esp
    1983:	84 c0                	test   %al,%al
    1985:	75 0c                	jne    1993 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1987:	8b 45 08             	mov    0x8(%ebp),%eax
    198a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1991:	eb b2                	jmp    1945 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1993:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1994:	90                   	nop
    1995:	c9                   	leave  
    1996:	c3                   	ret    

00001997 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1997:	55                   	push   %ebp
    1998:	89 e5                	mov    %esp,%ebp
    199a:	57                   	push   %edi
    199b:	56                   	push   %esi
    199c:	53                   	push   %ebx
    199d:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    19a0:	a1 2c 68 00 00       	mov    0x682c,%eax
    19a5:	85 c0                	test   %eax,%eax
    19a7:	0f 85 2c 02 00 00    	jne    1bd9 <APGridPaint+0x242>
    {
        iconReady = 1;
    19ad:	c7 05 2c 68 00 00 01 	movl   $0x1,0x682c
    19b4:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    19b7:	8d 45 88             	lea    -0x78(%ebp),%eax
    19ba:	83 ec 08             	sub    $0x8,%esp
    19bd:	68 53 25 00 00       	push   $0x2553
    19c2:	50                   	push   %eax
    19c3:	e8 d3 ef ff ff       	call   99b <APLoadBitmap>
    19c8:	83 c4 0c             	add    $0xc,%esp
    19cb:	8b 45 88             	mov    -0x78(%ebp),%eax
    19ce:	a3 60 6a 00 00       	mov    %eax,0x6a60
    19d3:	8b 45 8c             	mov    -0x74(%ebp),%eax
    19d6:	a3 64 6a 00 00       	mov    %eax,0x6a64
    19db:	8b 45 90             	mov    -0x70(%ebp),%eax
    19de:	a3 68 6a 00 00       	mov    %eax,0x6a68
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    19e3:	83 ec 04             	sub    $0x4,%esp
    19e6:	ff 35 68 6a 00 00    	pushl  0x6a68
    19ec:	ff 35 64 6a 00 00    	pushl  0x6a64
    19f2:	ff 35 60 6a 00 00    	pushl  0x6a60
    19f8:	e8 d8 f1 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    19fd:	83 c4 10             	add    $0x10,%esp
    1a00:	a3 6c 6a 00 00       	mov    %eax,0x6a6c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a05:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a08:	83 ec 08             	sub    $0x8,%esp
    1a0b:	68 61 25 00 00       	push   $0x2561
    1a10:	50                   	push   %eax
    1a11:	e8 85 ef ff ff       	call   99b <APLoadBitmap>
    1a16:	83 c4 0c             	add    $0xc,%esp
    1a19:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a1c:	a3 9c 6a 00 00       	mov    %eax,0x6a9c
    1a21:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a24:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
    1a29:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a2c:	a3 a4 6a 00 00       	mov    %eax,0x6aa4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a31:	83 ec 04             	sub    $0x4,%esp
    1a34:	ff 35 a4 6a 00 00    	pushl  0x6aa4
    1a3a:	ff 35 a0 6a 00 00    	pushl  0x6aa0
    1a40:	ff 35 9c 6a 00 00    	pushl  0x6a9c
    1a46:	e8 8a f1 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1a4b:	83 c4 10             	add    $0x10,%esp
    1a4e:	a3 8c 6a 00 00       	mov    %eax,0x6a8c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1a53:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a56:	83 ec 08             	sub    $0x8,%esp
    1a59:	68 70 25 00 00       	push   $0x2570
    1a5e:	50                   	push   %eax
    1a5f:	e8 37 ef ff ff       	call   99b <APLoadBitmap>
    1a64:	83 c4 0c             	add    $0xc,%esp
    1a67:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a6a:	a3 90 6a 00 00       	mov    %eax,0x6a90
    1a6f:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a72:	a3 94 6a 00 00       	mov    %eax,0x6a94
    1a77:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a7a:	a3 98 6a 00 00       	mov    %eax,0x6a98
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1a7f:	83 ec 04             	sub    $0x4,%esp
    1a82:	ff 35 98 6a 00 00    	pushl  0x6a98
    1a88:	ff 35 94 6a 00 00    	pushl  0x6a94
    1a8e:	ff 35 90 6a 00 00    	pushl  0x6a90
    1a94:	e8 3c f1 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1a99:	83 c4 10             	add    $0x10,%esp
    1a9c:	a3 40 6a 00 00       	mov    %eax,0x6a40
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1aa1:	8d 45 88             	lea    -0x78(%ebp),%eax
    1aa4:	83 ec 08             	sub    $0x8,%esp
    1aa7:	68 7f 25 00 00       	push   $0x257f
    1aac:	50                   	push   %eax
    1aad:	e8 e9 ee ff ff       	call   99b <APLoadBitmap>
    1ab2:	83 c4 0c             	add    $0xc,%esp
    1ab5:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ab8:	a3 74 6a 00 00       	mov    %eax,0x6a74
    1abd:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ac0:	a3 78 6a 00 00       	mov    %eax,0x6a78
    1ac5:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ac8:	a3 7c 6a 00 00       	mov    %eax,0x6a7c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1acd:	83 ec 04             	sub    $0x4,%esp
    1ad0:	ff 35 7c 6a 00 00    	pushl  0x6a7c
    1ad6:	ff 35 78 6a 00 00    	pushl  0x6a78
    1adc:	ff 35 74 6a 00 00    	pushl  0x6a74
    1ae2:	e8 ee f0 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1ae7:	83 c4 10             	add    $0x10,%esp
    1aea:	a3 a8 6a 00 00       	mov    %eax,0x6aa8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1aef:	8d 45 88             	lea    -0x78(%ebp),%eax
    1af2:	83 ec 08             	sub    $0x8,%esp
    1af5:	68 8d 25 00 00       	push   $0x258d
    1afa:	50                   	push   %eax
    1afb:	e8 9b ee ff ff       	call   99b <APLoadBitmap>
    1b00:	83 c4 0c             	add    $0xc,%esp
    1b03:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b06:	a3 50 6a 00 00       	mov    %eax,0x6a50
    1b0b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b0e:	a3 54 6a 00 00       	mov    %eax,0x6a54
    1b13:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b16:	a3 58 6a 00 00       	mov    %eax,0x6a58
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b1b:	83 ec 04             	sub    $0x4,%esp
    1b1e:	ff 35 58 6a 00 00    	pushl  0x6a58
    1b24:	ff 35 54 6a 00 00    	pushl  0x6a54
    1b2a:	ff 35 50 6a 00 00    	pushl  0x6a50
    1b30:	e8 a0 f0 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1b35:	83 c4 10             	add    $0x10,%esp
    1b38:	a3 70 6a 00 00       	mov    %eax,0x6a70
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1b3d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b40:	83 ec 08             	sub    $0x8,%esp
    1b43:	68 9d 25 00 00       	push   $0x259d
    1b48:	50                   	push   %eax
    1b49:	e8 4d ee ff ff       	call   99b <APLoadBitmap>
    1b4e:	83 c4 0c             	add    $0xc,%esp
    1b51:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b54:	a3 44 6a 00 00       	mov    %eax,0x6a44
    1b59:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b5c:	a3 48 6a 00 00       	mov    %eax,0x6a48
    1b61:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b64:	a3 4c 6a 00 00       	mov    %eax,0x6a4c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1b69:	83 ec 04             	sub    $0x4,%esp
    1b6c:	ff 35 4c 6a 00 00    	pushl  0x6a4c
    1b72:	ff 35 48 6a 00 00    	pushl  0x6a48
    1b78:	ff 35 44 6a 00 00    	pushl  0x6a44
    1b7e:	e8 52 f0 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1b83:	83 c4 10             	add    $0x10,%esp
    1b86:	a3 5c 6a 00 00       	mov    %eax,0x6a5c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1b8b:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b8e:	83 ec 08             	sub    $0x8,%esp
    1b91:	68 af 25 00 00       	push   $0x25af
    1b96:	50                   	push   %eax
    1b97:	e8 ff ed ff ff       	call   99b <APLoadBitmap>
    1b9c:	83 c4 0c             	add    $0xc,%esp
    1b9f:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ba2:	a3 80 6a 00 00       	mov    %eax,0x6a80
    1ba7:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1baa:	a3 84 6a 00 00       	mov    %eax,0x6a84
    1baf:	8b 45 90             	mov    -0x70(%ebp),%eax
    1bb2:	a3 88 6a 00 00       	mov    %eax,0x6a88
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1bb7:	83 ec 04             	sub    $0x4,%esp
    1bba:	ff 35 88 6a 00 00    	pushl  0x6a88
    1bc0:	ff 35 84 6a 00 00    	pushl  0x6a84
    1bc6:	ff 35 80 6a 00 00    	pushl  0x6a80
    1bcc:	e8 04 f0 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1bd1:	83 c4 10             	add    $0x10,%esp
    1bd4:	a3 ac 6a 00 00       	mov    %eax,0x6aac
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1bd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdc:	8b 40 08             	mov    0x8(%eax),%eax
    1bdf:	85 c0                	test   %eax,%eax
    1be1:	75 17                	jne    1bfa <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1be3:	83 ec 08             	sub    $0x8,%esp
    1be6:	68 c0 25 00 00       	push   $0x25c0
    1beb:	6a 01                	push   $0x1
    1bed:	e8 23 e9 ff ff       	call   515 <printf>
    1bf2:	83 c4 10             	add    $0x10,%esp
        return;
    1bf5:	e9 07 05 00 00       	jmp    2101 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1bfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfd:	8b 40 10             	mov    0x10(%eax),%eax
    1c00:	85 c0                	test   %eax,%eax
    1c02:	7e 10                	jle    1c14 <APGridPaint+0x27d>
    1c04:	8b 45 08             	mov    0x8(%ebp),%eax
    1c07:	8b 50 14             	mov    0x14(%eax),%edx
    1c0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0d:	8b 40 10             	mov    0x10(%eax),%eax
    1c10:	39 c2                	cmp    %eax,%edx
    1c12:	7c 17                	jl     1c2b <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1c14:	83 ec 08             	sub    $0x8,%esp
    1c17:	68 e6 25 00 00       	push   $0x25e6
    1c1c:	6a 01                	push   $0x1
    1c1e:	e8 f2 e8 ff ff       	call   515 <printf>
    1c23:	83 c4 10             	add    $0x10,%esp
        return;
    1c26:	e9 d6 04 00 00       	jmp    2101 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1c2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2e:	8b 40 14             	mov    0x14(%eax),%eax
    1c31:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1c37:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1c3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c3d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c40:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c47:	e9 96 03 00 00       	jmp    1fe2 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c4c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1c53:	e9 7c 03 00 00       	jmp    1fd4 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1c58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c5b:	c1 e0 04             	shl    $0x4,%eax
    1c5e:	89 c2                	mov    %eax,%edx
    1c60:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1c63:	01 c2                	add    %eax,%edx
    1c65:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c68:	01 d0                	add    %edx,%eax
    1c6a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1c6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c70:	8b 40 0c             	mov    0xc(%eax),%eax
    1c73:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1c76:	c1 e2 02             	shl    $0x2,%edx
    1c79:	01 d0                	add    %edx,%eax
    1c7b:	8b 00                	mov    (%eax),%eax
    1c7d:	83 f8 07             	cmp    $0x7,%eax
    1c80:	0f 87 49 03 00 00    	ja     1fcf <APGridPaint+0x638>
    1c86:	8b 04 85 fc 25 00 00 	mov    0x25fc(,%eax,4),%eax
    1c8d:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c8f:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1c92:	6a 0c                	push   $0xc
    1c94:	6a 0c                	push   $0xc
    1c96:	6a 0c                	push   $0xc
    1c98:	50                   	push   %eax
    1c99:	e8 df f8 ff ff       	call   157d <RGB>
    1c9e:	83 c4 0c             	add    $0xc,%esp
    1ca1:	8b 1d 6c 6a 00 00    	mov    0x6a6c,%ebx
    1ca7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1caa:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb0:	6b c0 32             	imul   $0x32,%eax,%eax
    1cb3:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1cb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cbc:	83 ec 0c             	sub    $0xc,%esp
    1cbf:	83 ec 04             	sub    $0x4,%esp
    1cc2:	89 e0                	mov    %esp,%eax
    1cc4:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1cc8:	66 89 30             	mov    %si,(%eax)
    1ccb:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1ccf:	88 50 02             	mov    %dl,0x2(%eax)
    1cd2:	6a 32                	push   $0x32
    1cd4:	6a 32                	push   $0x32
    1cd6:	6a 00                	push   $0x0
    1cd8:	6a 00                	push   $0x0
    1cda:	53                   	push   %ebx
    1cdb:	51                   	push   %ecx
    1cdc:	ff 75 84             	pushl  -0x7c(%ebp)
    1cdf:	57                   	push   %edi
    1ce0:	e8 f4 f6 ff ff       	call   13d9 <APDcCopy>
    1ce5:	83 c4 30             	add    $0x30,%esp
                    break;
    1ce8:	e9 e3 02 00 00       	jmp    1fd0 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1ced:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cf0:	6a 69                	push   $0x69
    1cf2:	6a 69                	push   $0x69
    1cf4:	6a 69                	push   $0x69
    1cf6:	50                   	push   %eax
    1cf7:	e8 81 f8 ff ff       	call   157d <RGB>
    1cfc:	83 c4 0c             	add    $0xc,%esp
    1cff:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1d03:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1d07:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1d0b:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1d0e:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d15:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d18:	6a 69                	push   $0x69
    1d1a:	6a 69                	push   $0x69
    1d1c:	6a 69                	push   $0x69
    1d1e:	50                   	push   %eax
    1d1f:	e8 59 f8 ff ff       	call   157d <RGB>
    1d24:	83 c4 0c             	add    $0xc,%esp
    1d27:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1d2b:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1d2f:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1d33:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d36:	8b 45 08             	mov    0x8(%ebp),%eax
    1d39:	8d 50 3c             	lea    0x3c(%eax),%edx
    1d3c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d3f:	ff 75 ac             	pushl  -0x54(%ebp)
    1d42:	ff 75 a8             	pushl  -0x58(%ebp)
    1d45:	52                   	push   %edx
    1d46:	50                   	push   %eax
    1d47:	e8 1e ef ff ff       	call   c6a <APSetPen>
    1d4c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d52:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1d55:	8d 55 88             	lea    -0x78(%ebp),%edx
    1d58:	83 ec 04             	sub    $0x4,%esp
    1d5b:	83 ec 04             	sub    $0x4,%esp
    1d5e:	89 e0                	mov    %esp,%eax
    1d60:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1d64:	66 89 08             	mov    %cx,(%eax)
    1d67:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1d6b:	88 48 02             	mov    %cl,0x2(%eax)
    1d6e:	53                   	push   %ebx
    1d6f:	52                   	push   %edx
    1d70:	e8 2e ef ff ff       	call   ca3 <APSetBrush>
    1d75:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d7b:	6b d0 32             	imul   $0x32,%eax,%edx
    1d7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d81:	6b c0 32             	imul   $0x32,%eax,%eax
    1d84:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d87:	83 c1 3c             	add    $0x3c,%ecx
    1d8a:	83 ec 0c             	sub    $0xc,%esp
    1d8d:	6a 32                	push   $0x32
    1d8f:	6a 32                	push   $0x32
    1d91:	52                   	push   %edx
    1d92:	50                   	push   %eax
    1d93:	51                   	push   %ecx
    1d94:	e8 34 f3 ff ff       	call   10cd <APDrawRect>
    1d99:	83 c4 20             	add    $0x20,%esp
                    break;
    1d9c:	e9 2f 02 00 00       	jmp    1fd0 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1da1:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1da4:	6a 0c                	push   $0xc
    1da6:	6a 0c                	push   $0xc
    1da8:	6a 0c                	push   $0xc
    1daa:	50                   	push   %eax
    1dab:	e8 cd f7 ff ff       	call   157d <RGB>
    1db0:	83 c4 0c             	add    $0xc,%esp
    1db3:	8b 1d ac 6a 00 00    	mov    0x6aac,%ebx
    1db9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dbc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dbf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dc2:	6b c0 32             	imul   $0x32,%eax,%eax
    1dc5:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1dc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dcb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1dce:	83 ec 0c             	sub    $0xc,%esp
    1dd1:	83 ec 04             	sub    $0x4,%esp
    1dd4:	89 e0                	mov    %esp,%eax
    1dd6:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1dda:	66 89 30             	mov    %si,(%eax)
    1ddd:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1de1:	88 50 02             	mov    %dl,0x2(%eax)
    1de4:	6a 32                	push   $0x32
    1de6:	6a 32                	push   $0x32
    1de8:	6a 00                	push   $0x0
    1dea:	6a 00                	push   $0x0
    1dec:	53                   	push   %ebx
    1ded:	51                   	push   %ecx
    1dee:	ff 75 84             	pushl  -0x7c(%ebp)
    1df1:	57                   	push   %edi
    1df2:	e8 e2 f5 ff ff       	call   13d9 <APDcCopy>
    1df7:	83 c4 30             	add    $0x30,%esp
                    break;
    1dfa:	e9 d1 01 00 00       	jmp    1fd0 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dff:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e02:	6a 0c                	push   $0xc
    1e04:	6a 0c                	push   $0xc
    1e06:	6a 0c                	push   $0xc
    1e08:	50                   	push   %eax
    1e09:	e8 6f f7 ff ff       	call   157d <RGB>
    1e0e:	83 c4 0c             	add    $0xc,%esp
    1e11:	8b 1d 8c 6a 00 00    	mov    0x6a8c,%ebx
    1e17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e1a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e1d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e20:	6b c0 32             	imul   $0x32,%eax,%eax
    1e23:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e2c:	83 ec 0c             	sub    $0xc,%esp
    1e2f:	83 ec 04             	sub    $0x4,%esp
    1e32:	89 e0                	mov    %esp,%eax
    1e34:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1e38:	66 89 30             	mov    %si,(%eax)
    1e3b:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1e3f:	88 50 02             	mov    %dl,0x2(%eax)
    1e42:	6a 32                	push   $0x32
    1e44:	6a 32                	push   $0x32
    1e46:	6a 00                	push   $0x0
    1e48:	6a 00                	push   $0x0
    1e4a:	53                   	push   %ebx
    1e4b:	51                   	push   %ecx
    1e4c:	ff 75 84             	pushl  -0x7c(%ebp)
    1e4f:	57                   	push   %edi
    1e50:	e8 84 f5 ff ff       	call   13d9 <APDcCopy>
    1e55:	83 c4 30             	add    $0x30,%esp
                    break;
    1e58:	e9 73 01 00 00       	jmp    1fd0 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e5d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1e60:	6a 0c                	push   $0xc
    1e62:	6a 0c                	push   $0xc
    1e64:	6a 0c                	push   $0xc
    1e66:	50                   	push   %eax
    1e67:	e8 11 f7 ff ff       	call   157d <RGB>
    1e6c:	83 c4 0c             	add    $0xc,%esp
    1e6f:	8b 1d 70 6a 00 00    	mov    0x6a70,%ebx
    1e75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e78:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e7e:	6b c0 32             	imul   $0x32,%eax,%eax
    1e81:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e84:	8b 45 08             	mov    0x8(%ebp),%eax
    1e87:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e8a:	83 ec 0c             	sub    $0xc,%esp
    1e8d:	83 ec 04             	sub    $0x4,%esp
    1e90:	89 e0                	mov    %esp,%eax
    1e92:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1e96:	66 89 30             	mov    %si,(%eax)
    1e99:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1e9d:	88 50 02             	mov    %dl,0x2(%eax)
    1ea0:	6a 32                	push   $0x32
    1ea2:	6a 32                	push   $0x32
    1ea4:	6a 00                	push   $0x0
    1ea6:	6a 00                	push   $0x0
    1ea8:	53                   	push   %ebx
    1ea9:	51                   	push   %ecx
    1eaa:	ff 75 84             	pushl  -0x7c(%ebp)
    1ead:	57                   	push   %edi
    1eae:	e8 26 f5 ff ff       	call   13d9 <APDcCopy>
    1eb3:	83 c4 30             	add    $0x30,%esp
                    break;
    1eb6:	e9 15 01 00 00       	jmp    1fd0 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ebb:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1ebe:	6a 0c                	push   $0xc
    1ec0:	6a 0c                	push   $0xc
    1ec2:	6a 0c                	push   $0xc
    1ec4:	50                   	push   %eax
    1ec5:	e8 b3 f6 ff ff       	call   157d <RGB>
    1eca:	83 c4 0c             	add    $0xc,%esp
    1ecd:	8b 1d a8 6a 00 00    	mov    0x6aa8,%ebx
    1ed3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ed6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ed9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1edc:	6b c0 32             	imul   $0x32,%eax,%eax
    1edf:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ee2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ee8:	83 ec 0c             	sub    $0xc,%esp
    1eeb:	83 ec 04             	sub    $0x4,%esp
    1eee:	89 e0                	mov    %esp,%eax
    1ef0:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1ef4:	66 89 30             	mov    %si,(%eax)
    1ef7:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1efb:	88 50 02             	mov    %dl,0x2(%eax)
    1efe:	6a 32                	push   $0x32
    1f00:	6a 32                	push   $0x32
    1f02:	6a 00                	push   $0x0
    1f04:	6a 00                	push   $0x0
    1f06:	53                   	push   %ebx
    1f07:	51                   	push   %ecx
    1f08:	ff 75 84             	pushl  -0x7c(%ebp)
    1f0b:	57                   	push   %edi
    1f0c:	e8 c8 f4 ff ff       	call   13d9 <APDcCopy>
    1f11:	83 c4 30             	add    $0x30,%esp
                    break;
    1f14:	e9 b7 00 00 00       	jmp    1fd0 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f19:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f1c:	6a 0c                	push   $0xc
    1f1e:	6a 0c                	push   $0xc
    1f20:	6a 0c                	push   $0xc
    1f22:	50                   	push   %eax
    1f23:	e8 55 f6 ff ff       	call   157d <RGB>
    1f28:	83 c4 0c             	add    $0xc,%esp
    1f2b:	8b 1d 40 6a 00 00    	mov    0x6a40,%ebx
    1f31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f34:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f37:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f3a:	6b c0 32             	imul   $0x32,%eax,%eax
    1f3d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f40:	8b 45 08             	mov    0x8(%ebp),%eax
    1f43:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f46:	83 ec 0c             	sub    $0xc,%esp
    1f49:	83 ec 04             	sub    $0x4,%esp
    1f4c:	89 e0                	mov    %esp,%eax
    1f4e:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1f52:	66 89 30             	mov    %si,(%eax)
    1f55:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1f59:	88 50 02             	mov    %dl,0x2(%eax)
    1f5c:	6a 32                	push   $0x32
    1f5e:	6a 32                	push   $0x32
    1f60:	6a 00                	push   $0x0
    1f62:	6a 00                	push   $0x0
    1f64:	53                   	push   %ebx
    1f65:	51                   	push   %ecx
    1f66:	ff 75 84             	pushl  -0x7c(%ebp)
    1f69:	57                   	push   %edi
    1f6a:	e8 6a f4 ff ff       	call   13d9 <APDcCopy>
    1f6f:	83 c4 30             	add    $0x30,%esp
                    break;
    1f72:	eb 5c                	jmp    1fd0 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f74:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1f77:	6a 0c                	push   $0xc
    1f79:	6a 0c                	push   $0xc
    1f7b:	6a 0c                	push   $0xc
    1f7d:	50                   	push   %eax
    1f7e:	e8 fa f5 ff ff       	call   157d <RGB>
    1f83:	83 c4 0c             	add    $0xc,%esp
    1f86:	8b 1d 5c 6a 00 00    	mov    0x6a5c,%ebx
    1f8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f8f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f92:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f95:	6b c0 32             	imul   $0x32,%eax,%eax
    1f98:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fa1:	83 ec 0c             	sub    $0xc,%esp
    1fa4:	83 ec 04             	sub    $0x4,%esp
    1fa7:	89 e0                	mov    %esp,%eax
    1fa9:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1fad:	66 89 30             	mov    %si,(%eax)
    1fb0:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1fb4:	88 50 02             	mov    %dl,0x2(%eax)
    1fb7:	6a 32                	push   $0x32
    1fb9:	6a 32                	push   $0x32
    1fbb:	6a 00                	push   $0x0
    1fbd:	6a 00                	push   $0x0
    1fbf:	53                   	push   %ebx
    1fc0:	51                   	push   %ecx
    1fc1:	ff 75 84             	pushl  -0x7c(%ebp)
    1fc4:	57                   	push   %edi
    1fc5:	e8 0f f4 ff ff       	call   13d9 <APDcCopy>
    1fca:	83 c4 30             	add    $0x30,%esp
                    break;
    1fcd:	eb 01                	jmp    1fd0 <APGridPaint+0x639>
                default: break;
    1fcf:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1fd0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1fd4:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1fd8:	0f 8e 7a fc ff ff    	jle    1c58 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1fde:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1fe2:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1fe6:	0f 8e 60 fc ff ff    	jle    1c4c <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1fec:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fef:	68 cd 00 00 00       	push   $0xcd
    1ff4:	6a 74                	push   $0x74
    1ff6:	6a 18                	push   $0x18
    1ff8:	50                   	push   %eax
    1ff9:	e8 7f f5 ff ff       	call   157d <RGB>
    1ffe:	83 c4 0c             	add    $0xc,%esp
    2001:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2005:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2009:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    200d:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2010:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2017:	8d 45 88             	lea    -0x78(%ebp),%eax
    201a:	68 cd 00 00 00       	push   $0xcd
    201f:	6a 74                	push   $0x74
    2021:	6a 18                	push   $0x18
    2023:	50                   	push   %eax
    2024:	e8 54 f5 ff ff       	call   157d <RGB>
    2029:	83 c4 0c             	add    $0xc,%esp
    202c:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2030:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2034:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2038:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    203b:	8b 45 08             	mov    0x8(%ebp),%eax
    203e:	8d 50 58             	lea    0x58(%eax),%edx
    2041:	8d 45 88             	lea    -0x78(%ebp),%eax
    2044:	ff 75 bc             	pushl  -0x44(%ebp)
    2047:	ff 75 b8             	pushl  -0x48(%ebp)
    204a:	52                   	push   %edx
    204b:	50                   	push   %eax
    204c:	e8 19 ec ff ff       	call   c6a <APSetPen>
    2051:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2054:	8b 45 08             	mov    0x8(%ebp),%eax
    2057:	8d 58 58             	lea    0x58(%eax),%ebx
    205a:	8d 55 88             	lea    -0x78(%ebp),%edx
    205d:	83 ec 04             	sub    $0x4,%esp
    2060:	83 ec 04             	sub    $0x4,%esp
    2063:	89 e0                	mov    %esp,%eax
    2065:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2069:	66 89 08             	mov    %cx,(%eax)
    206c:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2070:	88 48 02             	mov    %cl,0x2(%eax)
    2073:	53                   	push   %ebx
    2074:	52                   	push   %edx
    2075:	e8 29 ec ff ff       	call   ca3 <APSetBrush>
    207a:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    207d:	8b 45 08             	mov    0x8(%ebp),%eax
    2080:	83 c0 58             	add    $0x58,%eax
    2083:	83 ec 0c             	sub    $0xc,%esp
    2086:	6a 32                	push   $0x32
    2088:	68 20 03 00 00       	push   $0x320
    208d:	6a 00                	push   $0x0
    208f:	6a 00                	push   $0x0
    2091:	50                   	push   %eax
    2092:	e8 36 f0 ff ff       	call   10cd <APDrawRect>
    2097:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    209a:	8d 45 88             	lea    -0x78(%ebp),%eax
    209d:	6a 08                	push   $0x8
    209f:	6a 08                	push   $0x8
    20a1:	6a 08                	push   $0x8
    20a3:	50                   	push   %eax
    20a4:	e8 d4 f4 ff ff       	call   157d <RGB>
    20a9:	83 c4 0c             	add    $0xc,%esp
    20ac:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20b0:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    20b4:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20b8:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    20bb:	8b 45 08             	mov    0x8(%ebp),%eax
    20be:	8d 58 58             	lea    0x58(%eax),%ebx
    20c1:	8d 55 88             	lea    -0x78(%ebp),%edx
    20c4:	83 ec 04             	sub    $0x4,%esp
    20c7:	83 ec 04             	sub    $0x4,%esp
    20ca:	89 e0                	mov    %esp,%eax
    20cc:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    20d0:	66 89 08             	mov    %cx,(%eax)
    20d3:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    20d7:	88 48 02             	mov    %cl,0x2(%eax)
    20da:	53                   	push   %ebx
    20db:	52                   	push   %edx
    20dc:	e8 04 ec ff ff       	call   ce5 <APSetFont>
    20e1:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    20e4:	8b 45 08             	mov    0x8(%ebp),%eax
    20e7:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    20ed:	8b 45 08             	mov    0x8(%ebp),%eax
    20f0:	83 c0 58             	add    $0x58,%eax
    20f3:	6a 14                	push   $0x14
    20f5:	6a 14                	push   $0x14
    20f7:	52                   	push   %edx
    20f8:	50                   	push   %eax
    20f9:	e8 d4 f1 ff ff       	call   12d2 <APDrawText>
    20fe:	83 c4 10             	add    $0x10,%esp
}
    2101:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2104:	5b                   	pop    %ebx
    2105:	5e                   	pop    %esi
    2106:	5f                   	pop    %edi
    2107:	5d                   	pop    %ebp
    2108:	c3                   	ret    

00002109 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2109:	55                   	push   %ebp
    210a:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    210c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2110:	7e 08                	jle    211a <random+0x11>
{
rand_num = seed;
    2112:	8b 45 08             	mov    0x8(%ebp),%eax
    2115:	a3 00 68 00 00       	mov    %eax,0x6800
}
rand_num *= 3;
    211a:	8b 15 00 68 00 00    	mov    0x6800,%edx
    2120:	89 d0                	mov    %edx,%eax
    2122:	01 c0                	add    %eax,%eax
    2124:	01 d0                	add    %edx,%eax
    2126:	a3 00 68 00 00       	mov    %eax,0x6800
if (rand_num < 0)
    212b:	a1 00 68 00 00       	mov    0x6800,%eax
    2130:	85 c0                	test   %eax,%eax
    2132:	79 0c                	jns    2140 <random+0x37>
{
rand_num *= (-1);
    2134:	a1 00 68 00 00       	mov    0x6800,%eax
    2139:	f7 d8                	neg    %eax
    213b:	a3 00 68 00 00       	mov    %eax,0x6800
}
return rand_num % 997;
    2140:	8b 0d 00 68 00 00    	mov    0x6800,%ecx
    2146:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    214b:	89 c8                	mov    %ecx,%eax
    214d:	f7 ea                	imul   %edx
    214f:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2152:	c1 f8 09             	sar    $0x9,%eax
    2155:	89 c2                	mov    %eax,%edx
    2157:	89 c8                	mov    %ecx,%eax
    2159:	c1 f8 1f             	sar    $0x1f,%eax
    215c:	29 c2                	sub    %eax,%edx
    215e:	89 d0                	mov    %edx,%eax
    2160:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2166:	29 c1                	sub    %eax,%ecx
    2168:	89 c8                	mov    %ecx,%eax
}
    216a:	5d                   	pop    %ebp
    216b:	c3                   	ret    

0000216c <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    216c:	55                   	push   %ebp
    216d:	89 e5                	mov    %esp,%ebp
    216f:	53                   	push   %ebx
    2170:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2173:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    217a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    217e:	74 17                	je     2197 <sprintint+0x2b>
    2180:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2184:	79 11                	jns    2197 <sprintint+0x2b>
        neg = 1;
    2186:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    218d:	8b 45 10             	mov    0x10(%ebp),%eax
    2190:	f7 d8                	neg    %eax
    2192:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2195:	eb 06                	jmp    219d <sprintint+0x31>
    } else {
        x = xx;
    2197:	8b 45 10             	mov    0x10(%ebp),%eax
    219a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    219d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    21a4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    21a7:	8d 41 01             	lea    0x1(%ecx),%eax
    21aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
    21ad:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21b3:	ba 00 00 00 00       	mov    $0x0,%edx
    21b8:	f7 f3                	div    %ebx
    21ba:	89 d0                	mov    %edx,%eax
    21bc:	0f b6 80 04 68 00 00 	movzbl 0x6804(%eax),%eax
    21c3:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    21c7:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21cd:	ba 00 00 00 00       	mov    $0x0,%edx
    21d2:	f7 f3                	div    %ebx
    21d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21d7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    21db:	75 c7                	jne    21a4 <sprintint+0x38>
    if(neg)
    21dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21e1:	74 0e                	je     21f1 <sprintint+0x85>
        buf[i++] = '-';
    21e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21e6:	8d 50 01             	lea    0x1(%eax),%edx
    21e9:	89 55 f8             	mov    %edx,-0x8(%ebp)
    21ec:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    21f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21f4:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    21f7:	eb 1b                	jmp    2214 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    21f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    21fc:	8b 00                	mov    (%eax),%eax
    21fe:	8d 48 01             	lea    0x1(%eax),%ecx
    2201:	8b 55 0c             	mov    0xc(%ebp),%edx
    2204:	89 0a                	mov    %ecx,(%edx)
    2206:	89 c2                	mov    %eax,%edx
    2208:	8b 45 08             	mov    0x8(%ebp),%eax
    220b:	01 d0                	add    %edx,%eax
    220d:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2210:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2214:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2218:	7f df                	jg     21f9 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    221a:	eb 21                	jmp    223d <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    221c:	8b 45 0c             	mov    0xc(%ebp),%eax
    221f:	8b 00                	mov    (%eax),%eax
    2221:	8d 48 01             	lea    0x1(%eax),%ecx
    2224:	8b 55 0c             	mov    0xc(%ebp),%edx
    2227:	89 0a                	mov    %ecx,(%edx)
    2229:	89 c2                	mov    %eax,%edx
    222b:	8b 45 08             	mov    0x8(%ebp),%eax
    222e:	01 c2                	add    %eax,%edx
    2230:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2233:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2236:	01 c8                	add    %ecx,%eax
    2238:	0f b6 00             	movzbl (%eax),%eax
    223b:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    223d:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2241:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2245:	79 d5                	jns    221c <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2247:	90                   	nop
    2248:	83 c4 20             	add    $0x20,%esp
    224b:	5b                   	pop    %ebx
    224c:	5d                   	pop    %ebp
    224d:	c3                   	ret    

0000224e <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    224e:	55                   	push   %ebp
    224f:	89 e5                	mov    %esp,%ebp
    2251:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2254:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    225b:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2262:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2269:	8d 45 0c             	lea    0xc(%ebp),%eax
    226c:	83 c0 04             	add    $0x4,%eax
    226f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2272:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2279:	e9 d9 01 00 00       	jmp    2457 <sprintf+0x209>
        c = fmt[i] & 0xff;
    227e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2281:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2284:	01 d0                	add    %edx,%eax
    2286:	0f b6 00             	movzbl (%eax),%eax
    2289:	0f be c0             	movsbl %al,%eax
    228c:	25 ff 00 00 00       	and    $0xff,%eax
    2291:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2294:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2298:	75 2c                	jne    22c6 <sprintf+0x78>
            if(c == '%'){
    229a:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    229e:	75 0c                	jne    22ac <sprintf+0x5e>
                state = '%';
    22a0:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    22a7:	e9 a7 01 00 00       	jmp    2453 <sprintf+0x205>
            } else {
                dst[j++] = c;
    22ac:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22af:	8d 50 01             	lea    0x1(%eax),%edx
    22b2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22b5:	89 c2                	mov    %eax,%edx
    22b7:	8b 45 08             	mov    0x8(%ebp),%eax
    22ba:	01 d0                	add    %edx,%eax
    22bc:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22bf:	88 10                	mov    %dl,(%eax)
    22c1:	e9 8d 01 00 00       	jmp    2453 <sprintf+0x205>
            }
        } else if(state == '%'){
    22c6:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    22ca:	0f 85 83 01 00 00    	jne    2453 <sprintf+0x205>
            if(c == 'd'){
    22d0:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    22d4:	75 4c                	jne    2322 <sprintf+0xd4>
                buf[bi] = '\0';
    22d6:	8d 55 ce             	lea    -0x32(%ebp),%edx
    22d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22dc:	01 d0                	add    %edx,%eax
    22de:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    22e1:	83 ec 0c             	sub    $0xc,%esp
    22e4:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22e7:	50                   	push   %eax
    22e8:	e8 e7 df ff ff       	call   2d4 <atoi>
    22ed:	83 c4 10             	add    $0x10,%esp
    22f0:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    22f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    22fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22fd:	8b 00                	mov    (%eax),%eax
    22ff:	83 ec 08             	sub    $0x8,%esp
    2302:	ff 75 d8             	pushl  -0x28(%ebp)
    2305:	6a 01                	push   $0x1
    2307:	6a 0a                	push   $0xa
    2309:	50                   	push   %eax
    230a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    230d:	50                   	push   %eax
    230e:	ff 75 08             	pushl  0x8(%ebp)
    2311:	e8 56 fe ff ff       	call   216c <sprintint>
    2316:	83 c4 20             	add    $0x20,%esp
                ap++;
    2319:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    231d:	e9 2a 01 00 00       	jmp    244c <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2322:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2326:	74 06                	je     232e <sprintf+0xe0>
    2328:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    232c:	75 4c                	jne    237a <sprintf+0x12c>
                buf[bi] = '\0';
    232e:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2331:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2334:	01 d0                	add    %edx,%eax
    2336:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2339:	83 ec 0c             	sub    $0xc,%esp
    233c:	8d 45 ce             	lea    -0x32(%ebp),%eax
    233f:	50                   	push   %eax
    2340:	e8 8f df ff ff       	call   2d4 <atoi>
    2345:	83 c4 10             	add    $0x10,%esp
    2348:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    234b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2352:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2355:	8b 00                	mov    (%eax),%eax
    2357:	83 ec 08             	sub    $0x8,%esp
    235a:	ff 75 dc             	pushl  -0x24(%ebp)
    235d:	6a 00                	push   $0x0
    235f:	6a 10                	push   $0x10
    2361:	50                   	push   %eax
    2362:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2365:	50                   	push   %eax
    2366:	ff 75 08             	pushl  0x8(%ebp)
    2369:	e8 fe fd ff ff       	call   216c <sprintint>
    236e:	83 c4 20             	add    $0x20,%esp
                ap++;
    2371:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2375:	e9 d2 00 00 00       	jmp    244c <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    237a:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    237e:	75 46                	jne    23c6 <sprintf+0x178>
                s = (char*)*ap;
    2380:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2383:	8b 00                	mov    (%eax),%eax
    2385:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2388:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    238c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2390:	75 25                	jne    23b7 <sprintf+0x169>
                    s = "(null)";
    2392:	c7 45 f4 1c 26 00 00 	movl   $0x261c,-0xc(%ebp)
                while(*s != 0){
    2399:	eb 1c                	jmp    23b7 <sprintf+0x169>
                    dst[j++] = *s;
    239b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    239e:	8d 50 01             	lea    0x1(%eax),%edx
    23a1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23a4:	89 c2                	mov    %eax,%edx
    23a6:	8b 45 08             	mov    0x8(%ebp),%eax
    23a9:	01 c2                	add    %eax,%edx
    23ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23ae:	0f b6 00             	movzbl (%eax),%eax
    23b1:	88 02                	mov    %al,(%edx)
                    s++;
    23b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    23b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23ba:	0f b6 00             	movzbl (%eax),%eax
    23bd:	84 c0                	test   %al,%al
    23bf:	75 da                	jne    239b <sprintf+0x14d>
    23c1:	e9 86 00 00 00       	jmp    244c <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    23c6:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    23ca:	75 1d                	jne    23e9 <sprintf+0x19b>
                dst[j++] = *ap;
    23cc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23cf:	8d 50 01             	lea    0x1(%eax),%edx
    23d2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23d5:	89 c2                	mov    %eax,%edx
    23d7:	8b 45 08             	mov    0x8(%ebp),%eax
    23da:	01 c2                	add    %eax,%edx
    23dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23df:	8b 00                	mov    (%eax),%eax
    23e1:	88 02                	mov    %al,(%edx)
                ap++;
    23e3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23e7:	eb 63                	jmp    244c <sprintf+0x1fe>
            } else if(c == '%'){
    23e9:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    23ed:	75 17                	jne    2406 <sprintf+0x1b8>
                dst[j++] = c;
    23ef:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23f2:	8d 50 01             	lea    0x1(%eax),%edx
    23f5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23f8:	89 c2                	mov    %eax,%edx
    23fa:	8b 45 08             	mov    0x8(%ebp),%eax
    23fd:	01 d0                	add    %edx,%eax
    23ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2402:	88 10                	mov    %dl,(%eax)
    2404:	eb 46                	jmp    244c <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2406:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    240a:	7e 18                	jle    2424 <sprintf+0x1d6>
    240c:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2410:	7f 12                	jg     2424 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2412:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2415:	8d 50 01             	lea    0x1(%eax),%edx
    2418:	89 55 f0             	mov    %edx,-0x10(%ebp)
    241b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    241e:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2422:	eb 2f                	jmp    2453 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2424:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2427:	8d 50 01             	lea    0x1(%eax),%edx
    242a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    242d:	89 c2                	mov    %eax,%edx
    242f:	8b 45 08             	mov    0x8(%ebp),%eax
    2432:	01 d0                	add    %edx,%eax
    2434:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2437:	8b 45 c8             	mov    -0x38(%ebp),%eax
    243a:	8d 50 01             	lea    0x1(%eax),%edx
    243d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2440:	89 c2                	mov    %eax,%edx
    2442:	8b 45 08             	mov    0x8(%ebp),%eax
    2445:	01 d0                	add    %edx,%eax
    2447:	8b 55 e0             	mov    -0x20(%ebp),%edx
    244a:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    244c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2453:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2457:	8b 55 0c             	mov    0xc(%ebp),%edx
    245a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    245d:	01 d0                	add    %edx,%eax
    245f:	0f b6 00             	movzbl (%eax),%eax
    2462:	84 c0                	test   %al,%al
    2464:	0f 85 14 fe ff ff    	jne    227e <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    246a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    246d:	8d 50 01             	lea    0x1(%eax),%edx
    2470:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2473:	89 c2                	mov    %eax,%edx
    2475:	8b 45 08             	mov    0x8(%ebp),%eax
    2478:	01 d0                	add    %edx,%eax
    247a:	c6 00 00             	movb   $0x0,(%eax)
}
    247d:	90                   	nop
    247e:	c9                   	leave  
    247f:	c3                   	ret    
