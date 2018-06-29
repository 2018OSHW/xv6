
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
      47:	68 d8 22 00 00       	push   $0x22d8
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
      cf:	68 e9 22 00 00       	push   $0x22e9
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
     4b1:	0f b6 80 f4 29 00 00 	movzbl 0x29f4(%eax),%eax
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
     5ef:	c7 45 f4 fe 22 00 00 	movl   $0x22fe,-0xc(%ebp)
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
     6b5:	a1 28 2a 00 00       	mov    0x2a28,%eax
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
     780:	a3 28 2a 00 00       	mov    %eax,0x2a28
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
     7e1:	a1 28 2a 00 00       	mov    0x2a28,%eax
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
     7fd:	a1 28 2a 00 00       	mov    0x2a28,%eax
     802:	89 45 f0             	mov    %eax,-0x10(%ebp)
     805:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     809:	75 23                	jne    82e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     80b:	c7 45 f0 20 2a 00 00 	movl   $0x2a20,-0x10(%ebp)
     812:	8b 45 f0             	mov    -0x10(%ebp),%eax
     815:	a3 28 2a 00 00       	mov    %eax,0x2a28
     81a:	a1 28 2a 00 00       	mov    0x2a28,%eax
     81f:	a3 20 2a 00 00       	mov    %eax,0x2a20
    base.s.size = 0;
     824:	c7 05 24 2a 00 00 00 	movl   $0x0,0x2a24
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
     881:	a3 28 2a 00 00       	mov    %eax,0x2a28
      return (void*)(p + 1);
     886:	8b 45 f4             	mov    -0xc(%ebp),%eax
     889:	83 c0 08             	add    $0x8,%eax
     88c:	eb 3b                	jmp    8c9 <malloc+0xe1>
    }
    if(p == freep)
     88e:	a1 28 2a 00 00       	mov    0x2a28,%eax
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
     9d4:	68 05 23 00 00       	push   $0x2305
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

00000ce5 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     ce5:	55                   	push   %ebp
     ce6:	89 e5                	mov    %esp,%ebp
     ce8:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ceb:	8b 45 08             	mov    0x8(%ebp),%eax
     cee:	8b 40 0c             	mov    0xc(%eax),%eax
     cf1:	89 c2                	mov    %eax,%edx
     cf3:	c1 ea 1f             	shr    $0x1f,%edx
     cf6:	01 d0                	add    %edx,%eax
     cf8:	d1 f8                	sar    %eax
     cfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d00:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d07:	8b 45 10             	mov    0x10(%ebp),%eax
     d0a:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d10:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d14:	0f 89 98 00 00 00    	jns    db2 <APDrawPoint+0xcd>
        i = 0;
     d1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d21:	e9 8c 00 00 00       	jmp    db2 <APDrawPoint+0xcd>
    {
        j = x - off;
     d26:	8b 45 0c             	mov    0xc(%ebp),%eax
     d29:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d2f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d33:	79 69                	jns    d9e <APDrawPoint+0xb9>
            j = 0;
     d35:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d3c:	eb 60                	jmp    d9e <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d3e:	ff 75 fc             	pushl  -0x4(%ebp)
     d41:	ff 75 f8             	pushl  -0x8(%ebp)
     d44:	ff 75 08             	pushl  0x8(%ebp)
     d47:	e8 fd fb ff ff       	call   949 <APGetIndex>
     d4c:	83 c4 0c             	add    $0xc,%esp
     d4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d52:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d56:	74 55                	je     dad <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d58:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d5c:	74 67                	je     dc5 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d5e:	ff 75 10             	pushl  0x10(%ebp)
     d61:	ff 75 0c             	pushl  0xc(%ebp)
     d64:	ff 75 fc             	pushl  -0x4(%ebp)
     d67:	ff 75 f8             	pushl  -0x8(%ebp)
     d6a:	e8 a1 fb ff ff       	call   910 <distance_2>
     d6f:	83 c4 10             	add    $0x10,%esp
     d72:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d75:	7f 23                	jg     d9a <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     d77:	8b 45 08             	mov    0x8(%ebp),%eax
     d7a:	8b 48 18             	mov    0x18(%eax),%ecx
     d7d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     d80:	89 d0                	mov    %edx,%eax
     d82:	01 c0                	add    %eax,%eax
     d84:	01 d0                	add    %edx,%eax
     d86:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     d89:	8b 45 08             	mov    0x8(%ebp),%eax
     d8c:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     d90:	66 89 0a             	mov    %cx,(%edx)
     d93:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     d97:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     d9a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     d9e:	8b 55 0c             	mov    0xc(%ebp),%edx
     da1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da4:	01 d0                	add    %edx,%eax
     da6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     da9:	7d 93                	jge    d3e <APDrawPoint+0x59>
     dab:	eb 01                	jmp    dae <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     dad:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     dae:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     db2:	8b 55 10             	mov    0x10(%ebp),%edx
     db5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db8:	01 d0                	add    %edx,%eax
     dba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     dbd:	0f 8d 63 ff ff ff    	jge    d26 <APDrawPoint+0x41>
     dc3:	eb 01                	jmp    dc6 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     dc5:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     dc6:	c9                   	leave  
     dc7:	c3                   	ret    

00000dc8 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     dc8:	55                   	push   %ebp
     dc9:	89 e5                	mov    %esp,%ebp
     dcb:	53                   	push   %ebx
     dcc:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd2:	3b 45 14             	cmp    0x14(%ebp),%eax
     dd5:	0f 85 80 00 00 00    	jne    e5b <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     ddb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ddf:	0f 88 9d 02 00 00    	js     1082 <APDrawLine+0x2ba>
     de5:	8b 45 08             	mov    0x8(%ebp),%eax
     de8:	8b 00                	mov    (%eax),%eax
     dea:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ded:	0f 8e 8f 02 00 00    	jle    1082 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     df3:	8b 45 10             	mov    0x10(%ebp),%eax
     df6:	3b 45 18             	cmp    0x18(%ebp),%eax
     df9:	7e 12                	jle    e0d <APDrawLine+0x45>
        {
            int tmp = y2;
     dfb:	8b 45 18             	mov    0x18(%ebp),%eax
     dfe:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e01:	8b 45 10             	mov    0x10(%ebp),%eax
     e04:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e07:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e0a:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e11:	79 07                	jns    e1a <APDrawLine+0x52>
     e13:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e1a:	8b 45 08             	mov    0x8(%ebp),%eax
     e1d:	8b 40 04             	mov    0x4(%eax),%eax
     e20:	3b 45 18             	cmp    0x18(%ebp),%eax
     e23:	7d 0c                	jge    e31 <APDrawLine+0x69>
     e25:	8b 45 08             	mov    0x8(%ebp),%eax
     e28:	8b 40 04             	mov    0x4(%eax),%eax
     e2b:	83 e8 01             	sub    $0x1,%eax
     e2e:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e31:	8b 45 10             	mov    0x10(%ebp),%eax
     e34:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e37:	eb 15                	jmp    e4e <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e39:	ff 75 f4             	pushl  -0xc(%ebp)
     e3c:	ff 75 0c             	pushl  0xc(%ebp)
     e3f:	ff 75 08             	pushl  0x8(%ebp)
     e42:	e8 9e fe ff ff       	call   ce5 <APDrawPoint>
     e47:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e4a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e51:	3b 45 18             	cmp    0x18(%ebp),%eax
     e54:	7e e3                	jle    e39 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e56:	e9 2b 02 00 00       	jmp    1086 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e5b:	8b 45 10             	mov    0x10(%ebp),%eax
     e5e:	3b 45 18             	cmp    0x18(%ebp),%eax
     e61:	75 7f                	jne    ee2 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e67:	0f 88 18 02 00 00    	js     1085 <APDrawLine+0x2bd>
     e6d:	8b 45 08             	mov    0x8(%ebp),%eax
     e70:	8b 40 04             	mov    0x4(%eax),%eax
     e73:	3b 45 10             	cmp    0x10(%ebp),%eax
     e76:	0f 8e 09 02 00 00    	jle    1085 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7f:	3b 45 14             	cmp    0x14(%ebp),%eax
     e82:	7e 12                	jle    e96 <APDrawLine+0xce>
        {
            int tmp = x2;
     e84:	8b 45 14             	mov    0x14(%ebp),%eax
     e87:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     e8a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8d:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     e90:	8b 45 d8             	mov    -0x28(%ebp),%eax
     e93:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     e96:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e9a:	79 07                	jns    ea3 <APDrawLine+0xdb>
     e9c:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ea3:	8b 45 08             	mov    0x8(%ebp),%eax
     ea6:	8b 00                	mov    (%eax),%eax
     ea8:	3b 45 14             	cmp    0x14(%ebp),%eax
     eab:	7d 0b                	jge    eb8 <APDrawLine+0xf0>
     ead:	8b 45 08             	mov    0x8(%ebp),%eax
     eb0:	8b 00                	mov    (%eax),%eax
     eb2:	83 e8 01             	sub    $0x1,%eax
     eb5:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     eb8:	8b 45 0c             	mov    0xc(%ebp),%eax
     ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ebe:	eb 15                	jmp    ed5 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     ec0:	ff 75 10             	pushl  0x10(%ebp)
     ec3:	ff 75 f0             	pushl  -0x10(%ebp)
     ec6:	ff 75 08             	pushl  0x8(%ebp)
     ec9:	e8 17 fe ff ff       	call   ce5 <APDrawPoint>
     ece:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     ed1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     ed5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ed8:	3b 45 14             	cmp    0x14(%ebp),%eax
     edb:	7e e3                	jle    ec0 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     edd:	e9 a4 01 00 00       	jmp    1086 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     ee2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ee9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     ef0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef3:	2b 45 14             	sub    0x14(%ebp),%eax
     ef6:	50                   	push   %eax
     ef7:	e8 3d fa ff ff       	call   939 <abs_int>
     efc:	83 c4 04             	add    $0x4,%esp
     eff:	89 c3                	mov    %eax,%ebx
     f01:	8b 45 10             	mov    0x10(%ebp),%eax
     f04:	2b 45 18             	sub    0x18(%ebp),%eax
     f07:	50                   	push   %eax
     f08:	e8 2c fa ff ff       	call   939 <abs_int>
     f0d:	83 c4 04             	add    $0x4,%esp
     f10:	39 c3                	cmp    %eax,%ebx
     f12:	0f 8e b5 00 00 00    	jle    fcd <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f18:	8b 45 10             	mov    0x10(%ebp),%eax
     f1b:	2b 45 18             	sub    0x18(%ebp),%eax
     f1e:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f21:	db 45 b0             	fildl  -0x50(%ebp)
     f24:	8b 45 0c             	mov    0xc(%ebp),%eax
     f27:	2b 45 14             	sub    0x14(%ebp),%eax
     f2a:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f2d:	db 45 b0             	fildl  -0x50(%ebp)
     f30:	de f9                	fdivrp %st,%st(1)
     f32:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f35:	8b 45 14             	mov    0x14(%ebp),%eax
     f38:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f3b:	7e 0e                	jle    f4b <APDrawLine+0x183>
        {
            s = x1;
     f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f40:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f43:	8b 45 14             	mov    0x14(%ebp),%eax
     f46:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f49:	eb 0c                	jmp    f57 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f4b:	8b 45 14             	mov    0x14(%ebp),%eax
     f4e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f51:	8b 45 0c             	mov    0xc(%ebp),%eax
     f54:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f57:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f5b:	79 07                	jns    f64 <APDrawLine+0x19c>
     f5d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f64:	8b 45 08             	mov    0x8(%ebp),%eax
     f67:	8b 00                	mov    (%eax),%eax
     f69:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f6c:	7f 0b                	jg     f79 <APDrawLine+0x1b1>
     f6e:	8b 45 08             	mov    0x8(%ebp),%eax
     f71:	8b 00                	mov    (%eax),%eax
     f73:	83 e8 01             	sub    $0x1,%eax
     f76:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     f79:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f7f:	eb 3f                	jmp    fc0 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     f81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f84:	2b 45 0c             	sub    0xc(%ebp),%eax
     f87:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f8a:	db 45 b0             	fildl  -0x50(%ebp)
     f8d:	dc 4d d0             	fmull  -0x30(%ebp)
     f90:	db 45 10             	fildl  0x10(%ebp)
     f93:	de c1                	faddp  %st,%st(1)
     f95:	d9 7d b6             	fnstcw -0x4a(%ebp)
     f98:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     f9c:	b4 0c                	mov    $0xc,%ah
     f9e:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fa2:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fa5:	db 5d cc             	fistpl -0x34(%ebp)
     fa8:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fab:	ff 75 cc             	pushl  -0x34(%ebp)
     fae:	ff 75 e4             	pushl  -0x1c(%ebp)
     fb1:	ff 75 08             	pushl  0x8(%ebp)
     fb4:	e8 2c fd ff ff       	call   ce5 <APDrawPoint>
     fb9:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fbc:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     fc0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fc3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fc6:	7e b9                	jle    f81 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     fc8:	e9 b9 00 00 00       	jmp    1086 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
     fcd:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd0:	2b 45 14             	sub    0x14(%ebp),%eax
     fd3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fd6:	db 45 b0             	fildl  -0x50(%ebp)
     fd9:	8b 45 10             	mov    0x10(%ebp),%eax
     fdc:	2b 45 18             	sub    0x18(%ebp),%eax
     fdf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fe2:	db 45 b0             	fildl  -0x50(%ebp)
     fe5:	de f9                	fdivrp %st,%st(1)
     fe7:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
     fea:	8b 45 10             	mov    0x10(%ebp),%eax
     fed:	3b 45 18             	cmp    0x18(%ebp),%eax
     ff0:	7e 0e                	jle    1000 <APDrawLine+0x238>
    {
        s = y2;
     ff2:	8b 45 18             	mov    0x18(%ebp),%eax
     ff5:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
     ff8:	8b 45 10             	mov    0x10(%ebp),%eax
     ffb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ffe:	eb 0c                	jmp    100c <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1000:	8b 45 10             	mov    0x10(%ebp),%eax
    1003:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1006:	8b 45 18             	mov    0x18(%ebp),%eax
    1009:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    100c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1010:	79 07                	jns    1019 <APDrawLine+0x251>
    1012:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1019:	8b 45 08             	mov    0x8(%ebp),%eax
    101c:	8b 40 04             	mov    0x4(%eax),%eax
    101f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1022:	7f 0c                	jg     1030 <APDrawLine+0x268>
    1024:	8b 45 08             	mov    0x8(%ebp),%eax
    1027:	8b 40 04             	mov    0x4(%eax),%eax
    102a:	83 e8 01             	sub    $0x1,%eax
    102d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1030:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1033:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1036:	eb 3f                	jmp    1077 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1038:	8b 45 e0             	mov    -0x20(%ebp),%eax
    103b:	2b 45 10             	sub    0x10(%ebp),%eax
    103e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1041:	db 45 b0             	fildl  -0x50(%ebp)
    1044:	dc 4d c0             	fmull  -0x40(%ebp)
    1047:	db 45 0c             	fildl  0xc(%ebp)
    104a:	de c1                	faddp  %st,%st(1)
    104c:	d9 7d b6             	fnstcw -0x4a(%ebp)
    104f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1053:	b4 0c                	mov    $0xc,%ah
    1055:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1059:	d9 6d b4             	fldcw  -0x4c(%ebp)
    105c:	db 5d bc             	fistpl -0x44(%ebp)
    105f:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1062:	ff 75 e0             	pushl  -0x20(%ebp)
    1065:	ff 75 bc             	pushl  -0x44(%ebp)
    1068:	ff 75 08             	pushl  0x8(%ebp)
    106b:	e8 75 fc ff ff       	call   ce5 <APDrawPoint>
    1070:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1073:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1077:	8b 45 e0             	mov    -0x20(%ebp),%eax
    107a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    107d:	7e b9                	jle    1038 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    107f:	90                   	nop
    1080:	eb 04                	jmp    1086 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1082:	90                   	nop
    1083:	eb 01                	jmp    1086 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1085:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1086:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1089:	c9                   	leave  
    108a:	c3                   	ret    

0000108b <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    108b:	55                   	push   %ebp
    108c:	89 e5                	mov    %esp,%ebp
    108e:	53                   	push   %ebx
    108f:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1092:	8b 55 10             	mov    0x10(%ebp),%edx
    1095:	8b 45 18             	mov    0x18(%ebp),%eax
    1098:	01 d0                	add    %edx,%eax
    109a:	83 e8 01             	sub    $0x1,%eax
    109d:	83 ec 04             	sub    $0x4,%esp
    10a0:	50                   	push   %eax
    10a1:	ff 75 0c             	pushl  0xc(%ebp)
    10a4:	ff 75 10             	pushl  0x10(%ebp)
    10a7:	ff 75 0c             	pushl  0xc(%ebp)
    10aa:	ff 75 08             	pushl  0x8(%ebp)
    10ad:	e8 16 fd ff ff       	call   dc8 <APDrawLine>
    10b2:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10b5:	8b 55 0c             	mov    0xc(%ebp),%edx
    10b8:	8b 45 14             	mov    0x14(%ebp),%eax
    10bb:	01 d0                	add    %edx,%eax
    10bd:	83 e8 01             	sub    $0x1,%eax
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	ff 75 10             	pushl  0x10(%ebp)
    10c6:	50                   	push   %eax
    10c7:	ff 75 10             	pushl  0x10(%ebp)
    10ca:	ff 75 0c             	pushl  0xc(%ebp)
    10cd:	ff 75 08             	pushl  0x8(%ebp)
    10d0:	e8 f3 fc ff ff       	call   dc8 <APDrawLine>
    10d5:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    10d8:	8b 55 10             	mov    0x10(%ebp),%edx
    10db:	8b 45 18             	mov    0x18(%ebp),%eax
    10de:	01 d0                	add    %edx,%eax
    10e0:	8d 48 ff             	lea    -0x1(%eax),%ecx
    10e3:	8b 55 0c             	mov    0xc(%ebp),%edx
    10e6:	8b 45 14             	mov    0x14(%ebp),%eax
    10e9:	01 d0                	add    %edx,%eax
    10eb:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ee:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    10f1:	8b 45 14             	mov    0x14(%ebp),%eax
    10f4:	01 d8                	add    %ebx,%eax
    10f6:	83 e8 01             	sub    $0x1,%eax
    10f9:	83 ec 04             	sub    $0x4,%esp
    10fc:	51                   	push   %ecx
    10fd:	52                   	push   %edx
    10fe:	ff 75 10             	pushl  0x10(%ebp)
    1101:	50                   	push   %eax
    1102:	ff 75 08             	pushl  0x8(%ebp)
    1105:	e8 be fc ff ff       	call   dc8 <APDrawLine>
    110a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    110d:	8b 55 10             	mov    0x10(%ebp),%edx
    1110:	8b 45 18             	mov    0x18(%ebp),%eax
    1113:	01 d0                	add    %edx,%eax
    1115:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1118:	8b 55 0c             	mov    0xc(%ebp),%edx
    111b:	8b 45 14             	mov    0x14(%ebp),%eax
    111e:	01 d0                	add    %edx,%eax
    1120:	8d 50 ff             	lea    -0x1(%eax),%edx
    1123:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1126:	8b 45 18             	mov    0x18(%ebp),%eax
    1129:	01 d8                	add    %ebx,%eax
    112b:	83 e8 01             	sub    $0x1,%eax
    112e:	83 ec 04             	sub    $0x4,%esp
    1131:	51                   	push   %ecx
    1132:	52                   	push   %edx
    1133:	50                   	push   %eax
    1134:	ff 75 0c             	pushl  0xc(%ebp)
    1137:	ff 75 08             	pushl  0x8(%ebp)
    113a:	e8 89 fc ff ff       	call   dc8 <APDrawLine>
    113f:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1142:	8b 55 0c             	mov    0xc(%ebp),%edx
    1145:	8b 45 14             	mov    0x14(%ebp),%eax
    1148:	01 d0                	add    %edx,%eax
    114a:	8d 50 ff             	lea    -0x1(%eax),%edx
    114d:	8b 45 08             	mov    0x8(%ebp),%eax
    1150:	8b 40 0c             	mov    0xc(%eax),%eax
    1153:	89 c1                	mov    %eax,%ecx
    1155:	c1 e9 1f             	shr    $0x1f,%ecx
    1158:	01 c8                	add    %ecx,%eax
    115a:	d1 f8                	sar    %eax
    115c:	29 c2                	sub    %eax,%edx
    115e:	89 d0                	mov    %edx,%eax
    1160:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1163:	8b 55 10             	mov    0x10(%ebp),%edx
    1166:	8b 45 18             	mov    0x18(%ebp),%eax
    1169:	01 d0                	add    %edx,%eax
    116b:	8d 50 ff             	lea    -0x1(%eax),%edx
    116e:	8b 45 08             	mov    0x8(%ebp),%eax
    1171:	8b 40 0c             	mov    0xc(%eax),%eax
    1174:	89 c1                	mov    %eax,%ecx
    1176:	c1 e9 1f             	shr    $0x1f,%ecx
    1179:	01 c8                	add    %ecx,%eax
    117b:	d1 f8                	sar    %eax
    117d:	29 c2                	sub    %eax,%edx
    117f:	89 d0                	mov    %edx,%eax
    1181:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1184:	8b 45 08             	mov    0x8(%ebp),%eax
    1187:	8b 40 0c             	mov    0xc(%eax),%eax
    118a:	89 c2                	mov    %eax,%edx
    118c:	c1 ea 1f             	shr    $0x1f,%edx
    118f:	01 d0                	add    %edx,%eax
    1191:	d1 f8                	sar    %eax
    1193:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1196:	8b 45 08             	mov    0x8(%ebp),%eax
    1199:	8b 40 0c             	mov    0xc(%eax),%eax
    119c:	89 c2                	mov    %eax,%edx
    119e:	c1 ea 1f             	shr    $0x1f,%edx
    11a1:	01 d0                	add    %edx,%eax
    11a3:	d1 f8                	sar    %eax
    11a5:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11ac:	0f 88 d8 00 00 00    	js     128a <APDrawRect+0x1ff>
    11b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11b6:	0f 88 ce 00 00 00    	js     128a <APDrawRect+0x1ff>
    11bc:	8b 45 08             	mov    0x8(%ebp),%eax
    11bf:	8b 00                	mov    (%eax),%eax
    11c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11c4:	0f 8e c0 00 00 00    	jle    128a <APDrawRect+0x1ff>
    11ca:	8b 45 08             	mov    0x8(%ebp),%eax
    11cd:	8b 40 04             	mov    0x4(%eax),%eax
    11d0:	3b 45 10             	cmp    0x10(%ebp),%eax
    11d3:	0f 8e b1 00 00 00    	jle    128a <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    11d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    11dd:	79 07                	jns    11e6 <APDrawRect+0x15b>
    11df:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    11e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    11ea:	79 07                	jns    11f3 <APDrawRect+0x168>
    11ec:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    11f3:	8b 45 08             	mov    0x8(%ebp),%eax
    11f6:	8b 00                	mov    (%eax),%eax
    11f8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    11fb:	7f 0b                	jg     1208 <APDrawRect+0x17d>
    11fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1200:	8b 00                	mov    (%eax),%eax
    1202:	83 e8 01             	sub    $0x1,%eax
    1205:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1208:	8b 45 08             	mov    0x8(%ebp),%eax
    120b:	8b 40 04             	mov    0x4(%eax),%eax
    120e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1211:	7f 0c                	jg     121f <APDrawRect+0x194>
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	8b 40 04             	mov    0x4(%eax),%eax
    1219:	83 e8 01             	sub    $0x1,%eax
    121c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    121f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1226:	8b 45 0c             	mov    0xc(%ebp),%eax
    1229:	89 45 ec             	mov    %eax,-0x14(%ebp)
    122c:	eb 52                	jmp    1280 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    122e:	8b 45 10             	mov    0x10(%ebp),%eax
    1231:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1234:	eb 3e                	jmp    1274 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1236:	83 ec 04             	sub    $0x4,%esp
    1239:	ff 75 e8             	pushl  -0x18(%ebp)
    123c:	ff 75 ec             	pushl  -0x14(%ebp)
    123f:	ff 75 08             	pushl  0x8(%ebp)
    1242:	e8 02 f7 ff ff       	call   949 <APGetIndex>
    1247:	83 c4 10             	add    $0x10,%esp
    124a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	8b 48 18             	mov    0x18(%eax),%ecx
    1253:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1256:	89 d0                	mov    %edx,%eax
    1258:	01 c0                	add    %eax,%eax
    125a:	01 d0                	add    %edx,%eax
    125c:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    125f:	8b 45 08             	mov    0x8(%ebp),%eax
    1262:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1266:	66 89 0a             	mov    %cx,(%edx)
    1269:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    126d:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1270:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1274:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1277:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    127a:	7e ba                	jle    1236 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    127c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1280:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1283:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1286:	7e a6                	jle    122e <APDrawRect+0x1a3>
    1288:	eb 01                	jmp    128b <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    128a:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    128b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    128e:	c9                   	leave  
    128f:	c3                   	ret    

00001290 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
}
    1293:	90                   	nop
    1294:	5d                   	pop    %ebp
    1295:	c3                   	ret    

00001296 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1296:	55                   	push   %ebp
    1297:	89 e5                	mov    %esp,%ebp
    1299:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    129c:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    12a0:	0f 88 8e 01 00 00    	js     1434 <APDcCopy+0x19e>
    12a6:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    12aa:	0f 88 84 01 00 00    	js     1434 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12b0:	8b 55 0c             	mov    0xc(%ebp),%edx
    12b3:	8b 45 20             	mov    0x20(%ebp),%eax
    12b6:	01 d0                	add    %edx,%eax
    12b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12bb:	8b 55 10             	mov    0x10(%ebp),%edx
    12be:	8b 45 24             	mov    0x24(%ebp),%eax
    12c1:	01 d0                	add    %edx,%eax
    12c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12c6:	8b 55 18             	mov    0x18(%ebp),%edx
    12c9:	8b 45 20             	mov    0x20(%ebp),%eax
    12cc:	01 d0                	add    %edx,%eax
    12ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12d1:	8b 55 1c             	mov    0x1c(%ebp),%edx
    12d4:	8b 45 24             	mov    0x24(%ebp),%eax
    12d7:	01 d0                	add    %edx,%eax
    12d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    12dc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    12e0:	0f 88 51 01 00 00    	js     1437 <APDcCopy+0x1a1>
    12e6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    12ea:	0f 88 47 01 00 00    	js     1437 <APDcCopy+0x1a1>
    12f0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    12f4:	0f 88 3d 01 00 00    	js     1437 <APDcCopy+0x1a1>
    12fa:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    12fe:	0f 88 33 01 00 00    	js     1437 <APDcCopy+0x1a1>
    1304:	8b 45 14             	mov    0x14(%ebp),%eax
    1307:	8b 00                	mov    (%eax),%eax
    1309:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    130c:	0f 8c 25 01 00 00    	jl     1437 <APDcCopy+0x1a1>
    1312:	8b 45 14             	mov    0x14(%ebp),%eax
    1315:	8b 40 04             	mov    0x4(%eax),%eax
    1318:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    131b:	0f 8c 16 01 00 00    	jl     1437 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1321:	8b 45 08             	mov    0x8(%ebp),%eax
    1324:	8b 00                	mov    (%eax),%eax
    1326:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1329:	7f 0b                	jg     1336 <APDcCopy+0xa0>
    132b:	8b 45 08             	mov    0x8(%ebp),%eax
    132e:	8b 00                	mov    (%eax),%eax
    1330:	83 e8 01             	sub    $0x1,%eax
    1333:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1336:	8b 45 08             	mov    0x8(%ebp),%eax
    1339:	8b 40 04             	mov    0x4(%eax),%eax
    133c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    133f:	7f 0c                	jg     134d <APDcCopy+0xb7>
    1341:	8b 45 08             	mov    0x8(%ebp),%eax
    1344:	8b 40 04             	mov    0x4(%eax),%eax
    1347:	83 e8 01             	sub    $0x1,%eax
    134a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    134d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1354:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    135b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1362:	e9 bc 00 00 00       	jmp    1423 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1367:	8b 45 08             	mov    0x8(%ebp),%eax
    136a:	8b 00                	mov    (%eax),%eax
    136c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    136f:	8b 55 10             	mov    0x10(%ebp),%edx
    1372:	01 ca                	add    %ecx,%edx
    1374:	0f af d0             	imul   %eax,%edx
    1377:	8b 45 0c             	mov    0xc(%ebp),%eax
    137a:	01 d0                	add    %edx,%eax
    137c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    137f:	8b 45 14             	mov    0x14(%ebp),%eax
    1382:	8b 00                	mov    (%eax),%eax
    1384:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1387:	8b 55 1c             	mov    0x1c(%ebp),%edx
    138a:	01 ca                	add    %ecx,%edx
    138c:	0f af d0             	imul   %eax,%edx
    138f:	8b 45 18             	mov    0x18(%ebp),%eax
    1392:	01 d0                	add    %edx,%eax
    1394:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1397:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    139e:	eb 74                	jmp    1414 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    13a0:	8b 45 14             	mov    0x14(%ebp),%eax
    13a3:	8b 50 18             	mov    0x18(%eax),%edx
    13a6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13ac:	01 c8                	add    %ecx,%eax
    13ae:	89 c1                	mov    %eax,%ecx
    13b0:	89 c8                	mov    %ecx,%eax
    13b2:	01 c0                	add    %eax,%eax
    13b4:	01 c8                	add    %ecx,%eax
    13b6:	01 d0                	add    %edx,%eax
    13b8:	0f b7 10             	movzwl (%eax),%edx
    13bb:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13bf:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13c3:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13c6:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ca:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13ce:	38 c2                	cmp    %al,%dl
    13d0:	75 18                	jne    13ea <APDcCopy+0x154>
    13d2:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    13d6:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    13da:	38 c2                	cmp    %al,%dl
    13dc:	75 0c                	jne    13ea <APDcCopy+0x154>
    13de:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    13e2:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    13e6:	38 c2                	cmp    %al,%dl
    13e8:	74 26                	je     1410 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    13ea:	8b 45 08             	mov    0x8(%ebp),%eax
    13ed:	8b 50 18             	mov    0x18(%eax),%edx
    13f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13f6:	01 c8                	add    %ecx,%eax
    13f8:	89 c1                	mov    %eax,%ecx
    13fa:	89 c8                	mov    %ecx,%eax
    13fc:	01 c0                	add    %eax,%eax
    13fe:	01 c8                	add    %ecx,%eax
    1400:	01 d0                	add    %edx,%eax
    1402:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1406:	66 89 10             	mov    %dx,(%eax)
    1409:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    140d:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1410:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1414:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1417:	2b 45 0c             	sub    0xc(%ebp),%eax
    141a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    141d:	7d 81                	jge    13a0 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    141f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1423:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1426:	2b 45 10             	sub    0x10(%ebp),%eax
    1429:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    142c:	0f 8d 35 ff ff ff    	jge    1367 <APDcCopy+0xd1>
    1432:	eb 04                	jmp    1438 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1434:	90                   	nop
    1435:	eb 01                	jmp    1438 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1437:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1438:	c9                   	leave  
    1439:	c3                   	ret    

0000143a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    143a:	55                   	push   %ebp
    143b:	89 e5                	mov    %esp,%ebp
    143d:	83 ec 1c             	sub    $0x1c,%esp
    1440:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1443:	8b 55 10             	mov    0x10(%ebp),%edx
    1446:	8b 45 14             	mov    0x14(%ebp),%eax
    1449:	88 4d ec             	mov    %cl,-0x14(%ebp)
    144c:	88 55 e8             	mov    %dl,-0x18(%ebp)
    144f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1452:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1456:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1459:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    145d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1460:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1464:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1467:	8b 45 08             	mov    0x8(%ebp),%eax
    146a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    146e:	66 89 10             	mov    %dx,(%eax)
    1471:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1475:	88 50 02             	mov    %dl,0x2(%eax)
}
    1478:	8b 45 08             	mov    0x8(%ebp),%eax
    147b:	c9                   	leave  
    147c:	c2 04 00             	ret    $0x4

0000147f <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    147f:	55                   	push   %ebp
    1480:	89 e5                	mov    %esp,%ebp
    1482:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1485:	8b 45 08             	mov    0x8(%ebp),%eax
    1488:	8b 00                	mov    (%eax),%eax
    148a:	83 ec 08             	sub    $0x8,%esp
    148d:	8d 55 0c             	lea    0xc(%ebp),%edx
    1490:	52                   	push   %edx
    1491:	50                   	push   %eax
    1492:	e8 77 ef ff ff       	call   40e <sendMessage>
    1497:	83 c4 10             	add    $0x10,%esp
}
    149a:	90                   	nop
    149b:	c9                   	leave  
    149c:	c3                   	ret    

0000149d <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    149d:	55                   	push   %ebp
    149e:	89 e5                	mov    %esp,%ebp
    14a0:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    14a3:	83 ec 0c             	sub    $0xc,%esp
    14a6:	68 98 00 00 00       	push   $0x98
    14ab:	e8 38 f3 ff ff       	call   7e8 <malloc>
    14b0:	83 c4 10             	add    $0x10,%esp
    14b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14ba:	75 15                	jne    14d1 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14bc:	83 ec 04             	sub    $0x4,%esp
    14bf:	ff 75 08             	pushl  0x8(%ebp)
    14c2:	68 18 23 00 00       	push   $0x2318
    14c7:	6a 01                	push   $0x1
    14c9:	e8 47 f0 ff ff       	call   515 <printf>
    14ce:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d4:	05 84 00 00 00       	add    $0x84,%eax
    14d9:	83 ec 08             	sub    $0x8,%esp
    14dc:	ff 75 08             	pushl  0x8(%ebp)
    14df:	50                   	push   %eax
    14e0:	e8 50 ec ff ff       	call   135 <strcpy>
    14e5:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    14e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14eb:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    14f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14f5:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    14fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ff:	8b 40 3c             	mov    0x3c(%eax),%eax
    1502:	89 c2                	mov    %eax,%edx
    1504:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1507:	8b 40 40             	mov    0x40(%eax),%eax
    150a:	0f af d0             	imul   %eax,%edx
    150d:	89 d0                	mov    %edx,%eax
    150f:	01 c0                	add    %eax,%eax
    1511:	01 d0                	add    %edx,%eax
    1513:	83 ec 0c             	sub    $0xc,%esp
    1516:	50                   	push   %eax
    1517:	e8 cc f2 ff ff       	call   7e8 <malloc>
    151c:	83 c4 10             	add    $0x10,%esp
    151f:	89 c2                	mov    %eax,%edx
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1527:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152a:	8b 40 54             	mov    0x54(%eax),%eax
    152d:	85 c0                	test   %eax,%eax
    152f:	75 15                	jne    1546 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1531:	83 ec 04             	sub    $0x4,%esp
    1534:	ff 75 08             	pushl  0x8(%ebp)
    1537:	68 38 23 00 00       	push   $0x2338
    153c:	6a 01                	push   $0x1
    153e:	e8 d2 ef ff ff       	call   515 <printf>
    1543:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1546:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1549:	8b 40 3c             	mov    0x3c(%eax),%eax
    154c:	89 c2                	mov    %eax,%edx
    154e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1551:	8b 40 40             	mov    0x40(%eax),%eax
    1554:	0f af d0             	imul   %eax,%edx
    1557:	89 d0                	mov    %edx,%eax
    1559:	01 c0                	add    %eax,%eax
    155b:	01 c2                	add    %eax,%edx
    155d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1560:	8b 40 54             	mov    0x54(%eax),%eax
    1563:	83 ec 04             	sub    $0x4,%esp
    1566:	52                   	push   %edx
    1567:	68 ff ff ff 00       	push   $0xffffff
    156c:	50                   	push   %eax
    156d:	e8 59 ec ff ff       	call   1cb <memset>
    1572:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1575:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1578:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    157f:	e8 62 ee ff ff       	call   3e6 <getpid>
    1584:	89 c2                	mov    %eax,%edx
    1586:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1589:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    158c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158f:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1596:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1599:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    15a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a3:	8b 40 58             	mov    0x58(%eax),%eax
    15a6:	89 c2                	mov    %eax,%edx
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	8b 40 5c             	mov    0x5c(%eax),%eax
    15ae:	0f af d0             	imul   %eax,%edx
    15b1:	89 d0                	mov    %edx,%eax
    15b3:	01 c0                	add    %eax,%eax
    15b5:	01 d0                	add    %edx,%eax
    15b7:	83 ec 0c             	sub    $0xc,%esp
    15ba:	50                   	push   %eax
    15bb:	e8 28 f2 ff ff       	call   7e8 <malloc>
    15c0:	83 c4 10             	add    $0x10,%esp
    15c3:	89 c2                	mov    %eax,%edx
    15c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c8:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    15cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ce:	8b 40 70             	mov    0x70(%eax),%eax
    15d1:	85 c0                	test   %eax,%eax
    15d3:	75 15                	jne    15ea <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    15d5:	83 ec 04             	sub    $0x4,%esp
    15d8:	ff 75 08             	pushl  0x8(%ebp)
    15db:	68 5c 23 00 00       	push   $0x235c
    15e0:	6a 01                	push   $0x1
    15e2:	e8 2e ef ff ff       	call   515 <printf>
    15e7:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ed:	8b 40 3c             	mov    0x3c(%eax),%eax
    15f0:	89 c2                	mov    %eax,%edx
    15f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f5:	8b 40 40             	mov    0x40(%eax),%eax
    15f8:	0f af d0             	imul   %eax,%edx
    15fb:	89 d0                	mov    %edx,%eax
    15fd:	01 c0                	add    %eax,%eax
    15ff:	01 c2                	add    %eax,%edx
    1601:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1604:	8b 40 54             	mov    0x54(%eax),%eax
    1607:	83 ec 04             	sub    $0x4,%esp
    160a:	52                   	push   %edx
    160b:	68 ff 00 00 00       	push   $0xff
    1610:	50                   	push   %eax
    1611:	e8 b5 eb ff ff       	call   1cb <memset>
    1616:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1619:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161c:	8b 55 0c             	mov    0xc(%ebp),%edx
    161f:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1622:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1626:	74 49                	je     1671 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1628:	8b 45 10             	mov    0x10(%ebp),%eax
    162b:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1631:	83 ec 0c             	sub    $0xc,%esp
    1634:	50                   	push   %eax
    1635:	e8 ae f1 ff ff       	call   7e8 <malloc>
    163a:	83 c4 10             	add    $0x10,%esp
    163d:	89 c2                	mov    %eax,%edx
    163f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1642:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1645:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1648:	8b 55 10             	mov    0x10(%ebp),%edx
    164b:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    164e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1651:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1658:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1662:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1665:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    166c:	e9 8d 00 00 00       	jmp    16fe <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1671:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1674:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    167b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167e:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1685:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1688:	8b 40 20             	mov    0x20(%eax),%eax
    168b:	89 c2                	mov    %eax,%edx
    168d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1690:	8b 40 24             	mov    0x24(%eax),%eax
    1693:	0f af d0             	imul   %eax,%edx
    1696:	89 d0                	mov    %edx,%eax
    1698:	01 c0                	add    %eax,%eax
    169a:	01 d0                	add    %edx,%eax
    169c:	83 ec 0c             	sub    $0xc,%esp
    169f:	50                   	push   %eax
    16a0:	e8 43 f1 ff ff       	call   7e8 <malloc>
    16a5:	83 c4 10             	add    $0x10,%esp
    16a8:	89 c2                	mov    %eax,%edx
    16aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ad:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    16b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b3:	8b 40 38             	mov    0x38(%eax),%eax
    16b6:	85 c0                	test   %eax,%eax
    16b8:	75 15                	jne    16cf <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16ba:	83 ec 04             	sub    $0x4,%esp
    16bd:	ff 75 08             	pushl  0x8(%ebp)
    16c0:	68 84 23 00 00       	push   $0x2384
    16c5:	6a 01                	push   $0x1
    16c7:	e8 49 ee ff ff       	call   515 <printf>
    16cc:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d2:	8b 40 20             	mov    0x20(%eax),%eax
    16d5:	89 c2                	mov    %eax,%edx
    16d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16da:	8b 40 24             	mov    0x24(%eax),%eax
    16dd:	0f af d0             	imul   %eax,%edx
    16e0:	89 d0                	mov    %edx,%eax
    16e2:	01 c0                	add    %eax,%eax
    16e4:	01 c2                	add    %eax,%edx
    16e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e9:	8b 40 38             	mov    0x38(%eax),%eax
    16ec:	83 ec 04             	sub    $0x4,%esp
    16ef:	52                   	push   %edx
    16f0:	68 ff ff ff 00       	push   $0xffffff
    16f5:	50                   	push   %eax
    16f6:	e8 d0 ea ff ff       	call   1cb <memset>
    16fb:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    16fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1701:	c9                   	leave  
    1702:	c3                   	ret    

00001703 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1703:	55                   	push   %ebp
    1704:	89 e5                	mov    %esp,%ebp
    1706:	57                   	push   %edi
    1707:	56                   	push   %esi
    1708:	53                   	push   %ebx
    1709:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    170c:	8b 45 0c             	mov    0xc(%ebp),%eax
    170f:	83 f8 03             	cmp    $0x3,%eax
    1712:	74 02                	je     1716 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1714:	eb 7c                	jmp    1792 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1716:	8b 45 08             	mov    0x8(%ebp),%eax
    1719:	8b 58 1c             	mov    0x1c(%eax),%ebx
    171c:	8b 45 08             	mov    0x8(%ebp),%eax
    171f:	8b 48 18             	mov    0x18(%eax),%ecx
    1722:	8b 45 08             	mov    0x8(%ebp),%eax
    1725:	8b 50 5c             	mov    0x5c(%eax),%edx
    1728:	8b 45 08             	mov    0x8(%ebp),%eax
    172b:	8b 40 58             	mov    0x58(%eax),%eax
    172e:	8b 75 08             	mov    0x8(%ebp),%esi
    1731:	83 c6 58             	add    $0x58,%esi
    1734:	83 ec 04             	sub    $0x4,%esp
    1737:	53                   	push   %ebx
    1738:	51                   	push   %ecx
    1739:	6a 00                	push   $0x0
    173b:	52                   	push   %edx
    173c:	50                   	push   %eax
    173d:	6a 00                	push   $0x0
    173f:	6a 00                	push   $0x0
    1741:	56                   	push   %esi
    1742:	6a 00                	push   $0x0
    1744:	6a 00                	push   $0x0
    1746:	ff 75 08             	pushl  0x8(%ebp)
    1749:	e8 b8 ec ff ff       	call   406 <paintWindow>
    174e:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1751:	8b 45 08             	mov    0x8(%ebp),%eax
    1754:	8b 70 1c             	mov    0x1c(%eax),%esi
    1757:	8b 45 08             	mov    0x8(%ebp),%eax
    175a:	8b 58 18             	mov    0x18(%eax),%ebx
    175d:	8b 45 08             	mov    0x8(%ebp),%eax
    1760:	8b 48 08             	mov    0x8(%eax),%ecx
    1763:	8b 45 08             	mov    0x8(%ebp),%eax
    1766:	8b 50 40             	mov    0x40(%eax),%edx
    1769:	8b 45 08             	mov    0x8(%ebp),%eax
    176c:	8b 40 3c             	mov    0x3c(%eax),%eax
    176f:	8b 7d 08             	mov    0x8(%ebp),%edi
    1772:	83 c7 3c             	add    $0x3c,%edi
    1775:	83 ec 04             	sub    $0x4,%esp
    1778:	56                   	push   %esi
    1779:	53                   	push   %ebx
    177a:	51                   	push   %ecx
    177b:	52                   	push   %edx
    177c:	50                   	push   %eax
    177d:	6a 00                	push   $0x0
    177f:	6a 00                	push   $0x0
    1781:	57                   	push   %edi
    1782:	6a 32                	push   $0x32
    1784:	6a 00                	push   $0x0
    1786:	ff 75 08             	pushl  0x8(%ebp)
    1789:	e8 78 ec ff ff       	call   406 <paintWindow>
    178e:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1791:	90                   	nop
        default: break;
            
            
    }
    return False;
    1792:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1797:	8d 65 f4             	lea    -0xc(%ebp),%esp
    179a:	5b                   	pop    %ebx
    179b:	5e                   	pop    %esi
    179c:	5f                   	pop    %edi
    179d:	5d                   	pop    %ebp
    179e:	c3                   	ret    

0000179f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    179f:	55                   	push   %ebp
    17a0:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    17a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    17a5:	8b 50 08             	mov    0x8(%eax),%edx
    17a8:	8b 45 08             	mov    0x8(%ebp),%eax
    17ab:	8b 00                	mov    (%eax),%eax
    17ad:	39 c2                	cmp    %eax,%edx
    17af:	74 07                	je     17b8 <APPreJudge+0x19>
        return False;
    17b1:	b8 00 00 00 00       	mov    $0x0,%eax
    17b6:	eb 05                	jmp    17bd <APPreJudge+0x1e>
    return True;
    17b8:	b8 01 00 00 00       	mov    $0x1,%eax
}
    17bd:	5d                   	pop    %ebp
    17be:	c3                   	ret    

000017bf <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17bf:	55                   	push   %ebp
    17c0:	89 e5                	mov    %esp,%ebp
    17c2:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    17c5:	8b 45 08             	mov    0x8(%ebp),%eax
    17c8:	8b 55 0c             	mov    0xc(%ebp),%edx
    17cb:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    17d1:	83 ec 0c             	sub    $0xc,%esp
    17d4:	ff 75 08             	pushl  0x8(%ebp)
    17d7:	e8 42 ec ff ff       	call   41e <registWindow>
    17dc:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17df:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17e6:	8b 45 08             	mov    0x8(%ebp),%eax
    17e9:	8b 00                	mov    (%eax),%eax
    17eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17ee:	ff 75 f4             	pushl  -0xc(%ebp)
    17f1:	ff 75 f0             	pushl  -0x10(%ebp)
    17f4:	ff 75 ec             	pushl  -0x14(%ebp)
    17f7:	ff 75 08             	pushl  0x8(%ebp)
    17fa:	e8 80 fc ff ff       	call   147f <APSendMessage>
    17ff:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1802:	83 ec 0c             	sub    $0xc,%esp
    1805:	ff 75 08             	pushl  0x8(%ebp)
    1808:	e8 09 ec ff ff       	call   416 <getMessage>
    180d:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1810:	8b 45 08             	mov    0x8(%ebp),%eax
    1813:	83 c0 74             	add    $0x74,%eax
    1816:	83 ec 08             	sub    $0x8,%esp
    1819:	50                   	push   %eax
    181a:	ff 75 08             	pushl  0x8(%ebp)
    181d:	e8 7d ff ff ff       	call   179f <APPreJudge>
    1822:	83 c4 10             	add    $0x10,%esp
    1825:	84 c0                	test   %al,%al
    1827:	74 1b                	je     1844 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1829:	8b 45 08             	mov    0x8(%ebp),%eax
    182c:	ff 70 7c             	pushl  0x7c(%eax)
    182f:	ff 70 78             	pushl  0x78(%eax)
    1832:	ff 70 74             	pushl  0x74(%eax)
    1835:	ff 75 08             	pushl  0x8(%ebp)
    1838:	8b 45 0c             	mov    0xc(%ebp),%eax
    183b:	ff d0                	call   *%eax
    183d:	83 c4 10             	add    $0x10,%esp
    1840:	84 c0                	test   %al,%al
    1842:	75 0c                	jne    1850 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1844:	8b 45 08             	mov    0x8(%ebp),%eax
    1847:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    184e:	eb b2                	jmp    1802 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1850:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1851:	90                   	nop
    1852:	c9                   	leave  
    1853:	c3                   	ret    

00001854 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1854:	55                   	push   %ebp
    1855:	89 e5                	mov    %esp,%ebp
    1857:	57                   	push   %edi
    1858:	56                   	push   %esi
    1859:	53                   	push   %ebx
    185a:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    185d:	a1 2c 2a 00 00       	mov    0x2a2c,%eax
    1862:	85 c0                	test   %eax,%eax
    1864:	0f 85 2c 02 00 00    	jne    1a96 <APGridPaint+0x242>
    {
        iconReady = 1;
    186a:	c7 05 2c 2a 00 00 01 	movl   $0x1,0x2a2c
    1871:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1874:	8d 45 98             	lea    -0x68(%ebp),%eax
    1877:	83 ec 08             	sub    $0x8,%esp
    187a:	68 ab 23 00 00       	push   $0x23ab
    187f:	50                   	push   %eax
    1880:	e8 16 f1 ff ff       	call   99b <APLoadBitmap>
    1885:	83 c4 0c             	add    $0xc,%esp
    1888:	8b 45 98             	mov    -0x68(%ebp),%eax
    188b:	a3 60 2c 00 00       	mov    %eax,0x2c60
    1890:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1893:	a3 64 2c 00 00       	mov    %eax,0x2c64
    1898:	8b 45 a0             	mov    -0x60(%ebp),%eax
    189b:	a3 68 2c 00 00       	mov    %eax,0x2c68
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    18a0:	83 ec 04             	sub    $0x4,%esp
    18a3:	ff 35 68 2c 00 00    	pushl  0x2c68
    18a9:	ff 35 64 2c 00 00    	pushl  0x2c64
    18af:	ff 35 60 2c 00 00    	pushl  0x2c60
    18b5:	e8 1b f3 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    18ba:	83 c4 10             	add    $0x10,%esp
    18bd:	a3 6c 2c 00 00       	mov    %eax,0x2c6c
        grid_river = APLoadBitmap ("grid_river.bmp");
    18c2:	8d 45 98             	lea    -0x68(%ebp),%eax
    18c5:	83 ec 08             	sub    $0x8,%esp
    18c8:	68 b9 23 00 00       	push   $0x23b9
    18cd:	50                   	push   %eax
    18ce:	e8 c8 f0 ff ff       	call   99b <APLoadBitmap>
    18d3:	83 c4 0c             	add    $0xc,%esp
    18d6:	8b 45 98             	mov    -0x68(%ebp),%eax
    18d9:	a3 9c 2c 00 00       	mov    %eax,0x2c9c
    18de:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18e1:	a3 a0 2c 00 00       	mov    %eax,0x2ca0
    18e6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18e9:	a3 a4 2c 00 00       	mov    %eax,0x2ca4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    18ee:	83 ec 04             	sub    $0x4,%esp
    18f1:	ff 35 a4 2c 00 00    	pushl  0x2ca4
    18f7:	ff 35 a0 2c 00 00    	pushl  0x2ca0
    18fd:	ff 35 9c 2c 00 00    	pushl  0x2c9c
    1903:	e8 cd f2 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1908:	83 c4 10             	add    $0x10,%esp
    190b:	a3 8c 2c 00 00       	mov    %eax,0x2c8c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1910:	8d 45 98             	lea    -0x68(%ebp),%eax
    1913:	83 ec 08             	sub    $0x8,%esp
    1916:	68 c8 23 00 00       	push   $0x23c8
    191b:	50                   	push   %eax
    191c:	e8 7a f0 ff ff       	call   99b <APLoadBitmap>
    1921:	83 c4 0c             	add    $0xc,%esp
    1924:	8b 45 98             	mov    -0x68(%ebp),%eax
    1927:	a3 90 2c 00 00       	mov    %eax,0x2c90
    192c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    192f:	a3 94 2c 00 00       	mov    %eax,0x2c94
    1934:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1937:	a3 98 2c 00 00       	mov    %eax,0x2c98
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    193c:	83 ec 04             	sub    $0x4,%esp
    193f:	ff 35 98 2c 00 00    	pushl  0x2c98
    1945:	ff 35 94 2c 00 00    	pushl  0x2c94
    194b:	ff 35 90 2c 00 00    	pushl  0x2c90
    1951:	e8 7f f2 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1956:	83 c4 10             	add    $0x10,%esp
    1959:	a3 40 2c 00 00       	mov    %eax,0x2c40
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    195e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1961:	83 ec 08             	sub    $0x8,%esp
    1964:	68 d7 23 00 00       	push   $0x23d7
    1969:	50                   	push   %eax
    196a:	e8 2c f0 ff ff       	call   99b <APLoadBitmap>
    196f:	83 c4 0c             	add    $0xc,%esp
    1972:	8b 45 98             	mov    -0x68(%ebp),%eax
    1975:	a3 74 2c 00 00       	mov    %eax,0x2c74
    197a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    197d:	a3 78 2c 00 00       	mov    %eax,0x2c78
    1982:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1985:	a3 7c 2c 00 00       	mov    %eax,0x2c7c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    198a:	83 ec 04             	sub    $0x4,%esp
    198d:	ff 35 7c 2c 00 00    	pushl  0x2c7c
    1993:	ff 35 78 2c 00 00    	pushl  0x2c78
    1999:	ff 35 74 2c 00 00    	pushl  0x2c74
    199f:	e8 31 f2 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    19a4:	83 c4 10             	add    $0x10,%esp
    19a7:	a3 a8 2c 00 00       	mov    %eax,0x2ca8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    19ac:	8d 45 98             	lea    -0x68(%ebp),%eax
    19af:	83 ec 08             	sub    $0x8,%esp
    19b2:	68 e5 23 00 00       	push   $0x23e5
    19b7:	50                   	push   %eax
    19b8:	e8 de ef ff ff       	call   99b <APLoadBitmap>
    19bd:	83 c4 0c             	add    $0xc,%esp
    19c0:	8b 45 98             	mov    -0x68(%ebp),%eax
    19c3:	a3 50 2c 00 00       	mov    %eax,0x2c50
    19c8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19cb:	a3 54 2c 00 00       	mov    %eax,0x2c54
    19d0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19d3:	a3 58 2c 00 00       	mov    %eax,0x2c58
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    19d8:	83 ec 04             	sub    $0x4,%esp
    19db:	ff 35 58 2c 00 00    	pushl  0x2c58
    19e1:	ff 35 54 2c 00 00    	pushl  0x2c54
    19e7:	ff 35 50 2c 00 00    	pushl  0x2c50
    19ed:	e8 e3 f1 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    19f2:	83 c4 10             	add    $0x10,%esp
    19f5:	a3 70 2c 00 00       	mov    %eax,0x2c70
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    19fa:	8d 45 98             	lea    -0x68(%ebp),%eax
    19fd:	83 ec 08             	sub    $0x8,%esp
    1a00:	68 f5 23 00 00       	push   $0x23f5
    1a05:	50                   	push   %eax
    1a06:	e8 90 ef ff ff       	call   99b <APLoadBitmap>
    1a0b:	83 c4 0c             	add    $0xc,%esp
    1a0e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a11:	a3 44 2c 00 00       	mov    %eax,0x2c44
    1a16:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a19:	a3 48 2c 00 00       	mov    %eax,0x2c48
    1a1e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a21:	a3 4c 2c 00 00       	mov    %eax,0x2c4c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a26:	83 ec 04             	sub    $0x4,%esp
    1a29:	ff 35 4c 2c 00 00    	pushl  0x2c4c
    1a2f:	ff 35 48 2c 00 00    	pushl  0x2c48
    1a35:	ff 35 44 2c 00 00    	pushl  0x2c44
    1a3b:	e8 95 f1 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1a40:	83 c4 10             	add    $0x10,%esp
    1a43:	a3 5c 2c 00 00       	mov    %eax,0x2c5c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a48:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a4b:	83 ec 08             	sub    $0x8,%esp
    1a4e:	68 07 24 00 00       	push   $0x2407
    1a53:	50                   	push   %eax
    1a54:	e8 42 ef ff ff       	call   99b <APLoadBitmap>
    1a59:	83 c4 0c             	add    $0xc,%esp
    1a5c:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a5f:	a3 80 2c 00 00       	mov    %eax,0x2c80
    1a64:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a67:	a3 84 2c 00 00       	mov    %eax,0x2c84
    1a6c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a6f:	a3 88 2c 00 00       	mov    %eax,0x2c88
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1a74:	83 ec 04             	sub    $0x4,%esp
    1a77:	ff 35 88 2c 00 00    	pushl  0x2c88
    1a7d:	ff 35 84 2c 00 00    	pushl  0x2c84
    1a83:	ff 35 80 2c 00 00    	pushl  0x2c80
    1a89:	e8 47 f1 ff ff       	call   bd5 <APCreateCompatibleDCFromBitmap>
    1a8e:	83 c4 10             	add    $0x10,%esp
    1a91:	a3 ac 2c 00 00       	mov    %eax,0x2cac
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a96:	8b 45 08             	mov    0x8(%ebp),%eax
    1a99:	8b 40 08             	mov    0x8(%eax),%eax
    1a9c:	85 c0                	test   %eax,%eax
    1a9e:	75 17                	jne    1ab7 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1aa0:	83 ec 08             	sub    $0x8,%esp
    1aa3:	68 18 24 00 00       	push   $0x2418
    1aa8:	6a 01                	push   $0x1
    1aaa:	e8 66 ea ff ff       	call   515 <printf>
    1aaf:	83 c4 10             	add    $0x10,%esp
        return;
    1ab2:	e9 a0 04 00 00       	jmp    1f57 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1ab7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aba:	8b 40 10             	mov    0x10(%eax),%eax
    1abd:	85 c0                	test   %eax,%eax
    1abf:	7e 10                	jle    1ad1 <APGridPaint+0x27d>
    1ac1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac4:	8b 50 14             	mov    0x14(%eax),%edx
    1ac7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aca:	8b 40 10             	mov    0x10(%eax),%eax
    1acd:	39 c2                	cmp    %eax,%edx
    1acf:	7c 17                	jl     1ae8 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1ad1:	83 ec 08             	sub    $0x8,%esp
    1ad4:	68 3e 24 00 00       	push   $0x243e
    1ad9:	6a 01                	push   $0x1
    1adb:	e8 35 ea ff ff       	call   515 <printf>
    1ae0:	83 c4 10             	add    $0x10,%esp
        return;
    1ae3:	e9 6f 04 00 00       	jmp    1f57 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ae8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aeb:	8b 40 14             	mov    0x14(%eax),%eax
    1aee:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1af4:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1af7:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1afa:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1afd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b04:	e9 96 03 00 00       	jmp    1e9f <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b09:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b10:	e9 7c 03 00 00       	jmp    1e91 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b15:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b18:	c1 e0 04             	shl    $0x4,%eax
    1b1b:	89 c2                	mov    %eax,%edx
    1b1d:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b20:	01 c2                	add    %eax,%edx
    1b22:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b25:	01 d0                	add    %edx,%eax
    1b27:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2d:	8b 40 0c             	mov    0xc(%eax),%eax
    1b30:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b33:	c1 e2 02             	shl    $0x2,%edx
    1b36:	01 d0                	add    %edx,%eax
    1b38:	8b 00                	mov    (%eax),%eax
    1b3a:	83 f8 07             	cmp    $0x7,%eax
    1b3d:	0f 87 49 03 00 00    	ja     1e8c <APGridPaint+0x638>
    1b43:	8b 04 85 54 24 00 00 	mov    0x2454(,%eax,4),%eax
    1b4a:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b4c:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b4f:	6a 0c                	push   $0xc
    1b51:	6a 0c                	push   $0xc
    1b53:	6a 0c                	push   $0xc
    1b55:	50                   	push   %eax
    1b56:	e8 df f8 ff ff       	call   143a <RGB>
    1b5b:	83 c4 0c             	add    $0xc,%esp
    1b5e:	8b 1d 6c 2c 00 00    	mov    0x2c6c,%ebx
    1b64:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b67:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b6d:	6b c0 32             	imul   $0x32,%eax,%eax
    1b70:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b73:	8b 45 08             	mov    0x8(%ebp),%eax
    1b76:	8d 78 3c             	lea    0x3c(%eax),%edi
    1b79:	83 ec 0c             	sub    $0xc,%esp
    1b7c:	83 ec 04             	sub    $0x4,%esp
    1b7f:	89 e0                	mov    %esp,%eax
    1b81:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b85:	66 89 30             	mov    %si,(%eax)
    1b88:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b8c:	88 50 02             	mov    %dl,0x2(%eax)
    1b8f:	6a 32                	push   $0x32
    1b91:	6a 32                	push   $0x32
    1b93:	6a 00                	push   $0x0
    1b95:	6a 00                	push   $0x0
    1b97:	53                   	push   %ebx
    1b98:	51                   	push   %ecx
    1b99:	ff 75 94             	pushl  -0x6c(%ebp)
    1b9c:	57                   	push   %edi
    1b9d:	e8 f4 f6 ff ff       	call   1296 <APDcCopy>
    1ba2:	83 c4 30             	add    $0x30,%esp
                    break;
    1ba5:	e9 e3 02 00 00       	jmp    1e8d <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1baa:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bad:	6a 69                	push   $0x69
    1baf:	6a 69                	push   $0x69
    1bb1:	6a 69                	push   $0x69
    1bb3:	50                   	push   %eax
    1bb4:	e8 81 f8 ff ff       	call   143a <RGB>
    1bb9:	83 c4 0c             	add    $0xc,%esp
    1bbc:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bc0:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1bc4:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bc8:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1bcb:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1bd2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bd5:	6a 69                	push   $0x69
    1bd7:	6a 69                	push   $0x69
    1bd9:	6a 69                	push   $0x69
    1bdb:	50                   	push   %eax
    1bdc:	e8 59 f8 ff ff       	call   143a <RGB>
    1be1:	83 c4 0c             	add    $0xc,%esp
    1be4:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1be8:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1bec:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bf0:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1bf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf6:	8d 50 3c             	lea    0x3c(%eax),%edx
    1bf9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bfc:	ff 75 b0             	pushl  -0x50(%ebp)
    1bff:	ff 75 ac             	pushl  -0x54(%ebp)
    1c02:	52                   	push   %edx
    1c03:	50                   	push   %eax
    1c04:	e8 61 f0 ff ff       	call   c6a <APSetPen>
    1c09:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0f:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1c12:	8d 55 98             	lea    -0x68(%ebp),%edx
    1c15:	83 ec 04             	sub    $0x4,%esp
    1c18:	83 ec 04             	sub    $0x4,%esp
    1c1b:	89 e0                	mov    %esp,%eax
    1c1d:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1c21:	66 89 08             	mov    %cx,(%eax)
    1c24:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1c28:	88 48 02             	mov    %cl,0x2(%eax)
    1c2b:	53                   	push   %ebx
    1c2c:	52                   	push   %edx
    1c2d:	e8 71 f0 ff ff       	call   ca3 <APSetBrush>
    1c32:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c35:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c38:	6b d0 32             	imul   $0x32,%eax,%edx
    1c3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c3e:	6b c0 32             	imul   $0x32,%eax,%eax
    1c41:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c44:	83 c1 3c             	add    $0x3c,%ecx
    1c47:	83 ec 0c             	sub    $0xc,%esp
    1c4a:	6a 32                	push   $0x32
    1c4c:	6a 32                	push   $0x32
    1c4e:	52                   	push   %edx
    1c4f:	50                   	push   %eax
    1c50:	51                   	push   %ecx
    1c51:	e8 35 f4 ff ff       	call   108b <APDrawRect>
    1c56:	83 c4 20             	add    $0x20,%esp
                    break;
    1c59:	e9 2f 02 00 00       	jmp    1e8d <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c5e:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c61:	6a 0c                	push   $0xc
    1c63:	6a 0c                	push   $0xc
    1c65:	6a 0c                	push   $0xc
    1c67:	50                   	push   %eax
    1c68:	e8 cd f7 ff ff       	call   143a <RGB>
    1c6d:	83 c4 0c             	add    $0xc,%esp
    1c70:	8b 1d ac 2c 00 00    	mov    0x2cac,%ebx
    1c76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c79:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c7c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c7f:	6b c0 32             	imul   $0x32,%eax,%eax
    1c82:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c85:	8b 45 08             	mov    0x8(%ebp),%eax
    1c88:	8d 78 3c             	lea    0x3c(%eax),%edi
    1c8b:	83 ec 0c             	sub    $0xc,%esp
    1c8e:	83 ec 04             	sub    $0x4,%esp
    1c91:	89 e0                	mov    %esp,%eax
    1c93:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c97:	66 89 30             	mov    %si,(%eax)
    1c9a:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c9e:	88 50 02             	mov    %dl,0x2(%eax)
    1ca1:	6a 32                	push   $0x32
    1ca3:	6a 32                	push   $0x32
    1ca5:	6a 00                	push   $0x0
    1ca7:	6a 00                	push   $0x0
    1ca9:	53                   	push   %ebx
    1caa:	51                   	push   %ecx
    1cab:	ff 75 94             	pushl  -0x6c(%ebp)
    1cae:	57                   	push   %edi
    1caf:	e8 e2 f5 ff ff       	call   1296 <APDcCopy>
    1cb4:	83 c4 30             	add    $0x30,%esp
                    break;
    1cb7:	e9 d1 01 00 00       	jmp    1e8d <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cbc:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1cbf:	6a 0c                	push   $0xc
    1cc1:	6a 0c                	push   $0xc
    1cc3:	6a 0c                	push   $0xc
    1cc5:	50                   	push   %eax
    1cc6:	e8 6f f7 ff ff       	call   143a <RGB>
    1ccb:	83 c4 0c             	add    $0xc,%esp
    1cce:	8b 1d 8c 2c 00 00    	mov    0x2c8c,%ebx
    1cd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cda:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cdd:	6b c0 32             	imul   $0x32,%eax,%eax
    1ce0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ce3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce6:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ce9:	83 ec 0c             	sub    $0xc,%esp
    1cec:	83 ec 04             	sub    $0x4,%esp
    1cef:	89 e0                	mov    %esp,%eax
    1cf1:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1cf5:	66 89 30             	mov    %si,(%eax)
    1cf8:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1cfc:	88 50 02             	mov    %dl,0x2(%eax)
    1cff:	6a 32                	push   $0x32
    1d01:	6a 32                	push   $0x32
    1d03:	6a 00                	push   $0x0
    1d05:	6a 00                	push   $0x0
    1d07:	53                   	push   %ebx
    1d08:	51                   	push   %ecx
    1d09:	ff 75 94             	pushl  -0x6c(%ebp)
    1d0c:	57                   	push   %edi
    1d0d:	e8 84 f5 ff ff       	call   1296 <APDcCopy>
    1d12:	83 c4 30             	add    $0x30,%esp
                    break;
    1d15:	e9 73 01 00 00       	jmp    1e8d <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d1a:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d1d:	6a 0c                	push   $0xc
    1d1f:	6a 0c                	push   $0xc
    1d21:	6a 0c                	push   $0xc
    1d23:	50                   	push   %eax
    1d24:	e8 11 f7 ff ff       	call   143a <RGB>
    1d29:	83 c4 0c             	add    $0xc,%esp
    1d2c:	8b 1d 70 2c 00 00    	mov    0x2c70,%ebx
    1d32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d35:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d38:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d3b:	6b c0 32             	imul   $0x32,%eax,%eax
    1d3e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d41:	8b 45 08             	mov    0x8(%ebp),%eax
    1d44:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d47:	83 ec 0c             	sub    $0xc,%esp
    1d4a:	83 ec 04             	sub    $0x4,%esp
    1d4d:	89 e0                	mov    %esp,%eax
    1d4f:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d53:	66 89 30             	mov    %si,(%eax)
    1d56:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d5a:	88 50 02             	mov    %dl,0x2(%eax)
    1d5d:	6a 32                	push   $0x32
    1d5f:	6a 32                	push   $0x32
    1d61:	6a 00                	push   $0x0
    1d63:	6a 00                	push   $0x0
    1d65:	53                   	push   %ebx
    1d66:	51                   	push   %ecx
    1d67:	ff 75 94             	pushl  -0x6c(%ebp)
    1d6a:	57                   	push   %edi
    1d6b:	e8 26 f5 ff ff       	call   1296 <APDcCopy>
    1d70:	83 c4 30             	add    $0x30,%esp
                    break;
    1d73:	e9 15 01 00 00       	jmp    1e8d <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d78:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1d7b:	6a 0c                	push   $0xc
    1d7d:	6a 0c                	push   $0xc
    1d7f:	6a 0c                	push   $0xc
    1d81:	50                   	push   %eax
    1d82:	e8 b3 f6 ff ff       	call   143a <RGB>
    1d87:	83 c4 0c             	add    $0xc,%esp
    1d8a:	8b 1d a8 2c 00 00    	mov    0x2ca8,%ebx
    1d90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d93:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d96:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d99:	6b c0 32             	imul   $0x32,%eax,%eax
    1d9c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1da2:	8d 78 3c             	lea    0x3c(%eax),%edi
    1da5:	83 ec 0c             	sub    $0xc,%esp
    1da8:	83 ec 04             	sub    $0x4,%esp
    1dab:	89 e0                	mov    %esp,%eax
    1dad:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1db1:	66 89 30             	mov    %si,(%eax)
    1db4:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1db8:	88 50 02             	mov    %dl,0x2(%eax)
    1dbb:	6a 32                	push   $0x32
    1dbd:	6a 32                	push   $0x32
    1dbf:	6a 00                	push   $0x0
    1dc1:	6a 00                	push   $0x0
    1dc3:	53                   	push   %ebx
    1dc4:	51                   	push   %ecx
    1dc5:	ff 75 94             	pushl  -0x6c(%ebp)
    1dc8:	57                   	push   %edi
    1dc9:	e8 c8 f4 ff ff       	call   1296 <APDcCopy>
    1dce:	83 c4 30             	add    $0x30,%esp
                    break;
    1dd1:	e9 b7 00 00 00       	jmp    1e8d <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dd6:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1dd9:	6a 0c                	push   $0xc
    1ddb:	6a 0c                	push   $0xc
    1ddd:	6a 0c                	push   $0xc
    1ddf:	50                   	push   %eax
    1de0:	e8 55 f6 ff ff       	call   143a <RGB>
    1de5:	83 c4 0c             	add    $0xc,%esp
    1de8:	8b 1d 40 2c 00 00    	mov    0x2c40,%ebx
    1dee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1df1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1df4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1df7:	6b c0 32             	imul   $0x32,%eax,%eax
    1dfa:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dfd:	8b 45 08             	mov    0x8(%ebp),%eax
    1e00:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e03:	83 ec 0c             	sub    $0xc,%esp
    1e06:	83 ec 04             	sub    $0x4,%esp
    1e09:	89 e0                	mov    %esp,%eax
    1e0b:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1e0f:	66 89 30             	mov    %si,(%eax)
    1e12:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e16:	88 50 02             	mov    %dl,0x2(%eax)
    1e19:	6a 32                	push   $0x32
    1e1b:	6a 32                	push   $0x32
    1e1d:	6a 00                	push   $0x0
    1e1f:	6a 00                	push   $0x0
    1e21:	53                   	push   %ebx
    1e22:	51                   	push   %ecx
    1e23:	ff 75 94             	pushl  -0x6c(%ebp)
    1e26:	57                   	push   %edi
    1e27:	e8 6a f4 ff ff       	call   1296 <APDcCopy>
    1e2c:	83 c4 30             	add    $0x30,%esp
                    break;
    1e2f:	eb 5c                	jmp    1e8d <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e31:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e34:	6a 0c                	push   $0xc
    1e36:	6a 0c                	push   $0xc
    1e38:	6a 0c                	push   $0xc
    1e3a:	50                   	push   %eax
    1e3b:	e8 fa f5 ff ff       	call   143a <RGB>
    1e40:	83 c4 0c             	add    $0xc,%esp
    1e43:	8b 1d 5c 2c 00 00    	mov    0x2c5c,%ebx
    1e49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e4c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e4f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e52:	6b c0 32             	imul   $0x32,%eax,%eax
    1e55:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e58:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e5e:	83 ec 0c             	sub    $0xc,%esp
    1e61:	83 ec 04             	sub    $0x4,%esp
    1e64:	89 e0                	mov    %esp,%eax
    1e66:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e6a:	66 89 30             	mov    %si,(%eax)
    1e6d:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1e71:	88 50 02             	mov    %dl,0x2(%eax)
    1e74:	6a 32                	push   $0x32
    1e76:	6a 32                	push   $0x32
    1e78:	6a 00                	push   $0x0
    1e7a:	6a 00                	push   $0x0
    1e7c:	53                   	push   %ebx
    1e7d:	51                   	push   %ecx
    1e7e:	ff 75 94             	pushl  -0x6c(%ebp)
    1e81:	57                   	push   %edi
    1e82:	e8 0f f4 ff ff       	call   1296 <APDcCopy>
    1e87:	83 c4 30             	add    $0x30,%esp
                    break;
    1e8a:	eb 01                	jmp    1e8d <APGridPaint+0x639>
                default: break;
    1e8c:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e8d:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e91:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e95:	0f 8e 7a fc ff ff    	jle    1b15 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e9b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e9f:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1ea3:	0f 8e 60 fc ff ff    	jle    1b09 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1ea9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1eac:	68 cd 00 00 00       	push   $0xcd
    1eb1:	6a 74                	push   $0x74
    1eb3:	6a 18                	push   $0x18
    1eb5:	50                   	push   %eax
    1eb6:	e8 7f f5 ff ff       	call   143a <RGB>
    1ebb:	83 c4 0c             	add    $0xc,%esp
    1ebe:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ec2:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ec6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1eca:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1ecd:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1ed4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ed7:	68 cd 00 00 00       	push   $0xcd
    1edc:	6a 74                	push   $0x74
    1ede:	6a 18                	push   $0x18
    1ee0:	50                   	push   %eax
    1ee1:	e8 54 f5 ff ff       	call   143a <RGB>
    1ee6:	83 c4 0c             	add    $0xc,%esp
    1ee9:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1eed:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1ef1:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1ef5:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1ef8:	8b 45 08             	mov    0x8(%ebp),%eax
    1efb:	8d 50 58             	lea    0x58(%eax),%edx
    1efe:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f01:	ff 75 bc             	pushl  -0x44(%ebp)
    1f04:	ff 75 b8             	pushl  -0x48(%ebp)
    1f07:	52                   	push   %edx
    1f08:	50                   	push   %eax
    1f09:	e8 5c ed ff ff       	call   c6a <APSetPen>
    1f0e:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1f11:	8b 45 08             	mov    0x8(%ebp),%eax
    1f14:	8d 58 58             	lea    0x58(%eax),%ebx
    1f17:	8d 55 98             	lea    -0x68(%ebp),%edx
    1f1a:	83 ec 04             	sub    $0x4,%esp
    1f1d:	83 ec 04             	sub    $0x4,%esp
    1f20:	89 e0                	mov    %esp,%eax
    1f22:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1f26:	66 89 08             	mov    %cx,(%eax)
    1f29:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1f2d:	88 48 02             	mov    %cl,0x2(%eax)
    1f30:	53                   	push   %ebx
    1f31:	52                   	push   %edx
    1f32:	e8 6c ed ff ff       	call   ca3 <APSetBrush>
    1f37:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1f3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f3d:	83 c0 58             	add    $0x58,%eax
    1f40:	83 ec 0c             	sub    $0xc,%esp
    1f43:	6a 32                	push   $0x32
    1f45:	68 20 03 00 00       	push   $0x320
    1f4a:	6a 00                	push   $0x0
    1f4c:	6a 00                	push   $0x0
    1f4e:	50                   	push   %eax
    1f4f:	e8 37 f1 ff ff       	call   108b <APDrawRect>
    1f54:	83 c4 20             	add    $0x20,%esp
}
    1f57:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f5a:	5b                   	pop    %ebx
    1f5b:	5e                   	pop    %esi
    1f5c:	5f                   	pop    %edi
    1f5d:	5d                   	pop    %ebp
    1f5e:	c3                   	ret    

00001f5f <random>:
//

#include "APLib.h"

int random(int seed)
{
    1f5f:	55                   	push   %ebp
    1f60:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1f62:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1f66:	7e 08                	jle    1f70 <random+0x11>
{
rand_num = seed;
    1f68:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6b:	a3 08 2a 00 00       	mov    %eax,0x2a08
}
rand_num *= 3;
    1f70:	8b 15 08 2a 00 00    	mov    0x2a08,%edx
    1f76:	89 d0                	mov    %edx,%eax
    1f78:	01 c0                	add    %eax,%eax
    1f7a:	01 d0                	add    %edx,%eax
    1f7c:	a3 08 2a 00 00       	mov    %eax,0x2a08
if (rand_num < 0)
    1f81:	a1 08 2a 00 00       	mov    0x2a08,%eax
    1f86:	85 c0                	test   %eax,%eax
    1f88:	79 0c                	jns    1f96 <random+0x37>
{
rand_num *= (-1);
    1f8a:	a1 08 2a 00 00       	mov    0x2a08,%eax
    1f8f:	f7 d8                	neg    %eax
    1f91:	a3 08 2a 00 00       	mov    %eax,0x2a08
}
return rand_num % 997;
    1f96:	8b 0d 08 2a 00 00    	mov    0x2a08,%ecx
    1f9c:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1fa1:	89 c8                	mov    %ecx,%eax
    1fa3:	f7 ea                	imul   %edx
    1fa5:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1fa8:	c1 f8 09             	sar    $0x9,%eax
    1fab:	89 c2                	mov    %eax,%edx
    1fad:	89 c8                	mov    %ecx,%eax
    1faf:	c1 f8 1f             	sar    $0x1f,%eax
    1fb2:	29 c2                	sub    %eax,%edx
    1fb4:	89 d0                	mov    %edx,%eax
    1fb6:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1fbc:	29 c1                	sub    %eax,%ecx
    1fbe:	89 c8                	mov    %ecx,%eax
}
    1fc0:	5d                   	pop    %ebp
    1fc1:	c3                   	ret    

00001fc2 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1fc2:	55                   	push   %ebp
    1fc3:	89 e5                	mov    %esp,%ebp
    1fc5:	53                   	push   %ebx
    1fc6:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1fc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1fd0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1fd4:	74 17                	je     1fed <sprintint+0x2b>
    1fd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1fda:	79 11                	jns    1fed <sprintint+0x2b>
        neg = 1;
    1fdc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1fe3:	8b 45 10             	mov    0x10(%ebp),%eax
    1fe6:	f7 d8                	neg    %eax
    1fe8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1feb:	eb 06                	jmp    1ff3 <sprintint+0x31>
    } else {
        x = xx;
    1fed:	8b 45 10             	mov    0x10(%ebp),%eax
    1ff0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1ff3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1ffa:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1ffd:	8d 41 01             	lea    0x1(%ecx),%eax
    2000:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2003:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2006:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2009:	ba 00 00 00 00       	mov    $0x0,%edx
    200e:	f7 f3                	div    %ebx
    2010:	89 d0                	mov    %edx,%eax
    2012:	0f b6 80 0c 2a 00 00 	movzbl 0x2a0c(%eax),%eax
    2019:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    201d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2020:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2023:	ba 00 00 00 00       	mov    $0x0,%edx
    2028:	f7 f3                	div    %ebx
    202a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    202d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2031:	75 c7                	jne    1ffa <sprintint+0x38>
    if(neg)
    2033:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2037:	74 0e                	je     2047 <sprintint+0x85>
        buf[i++] = '-';
    2039:	8b 45 f8             	mov    -0x8(%ebp),%eax
    203c:	8d 50 01             	lea    0x1(%eax),%edx
    203f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2042:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2047:	8b 45 f8             	mov    -0x8(%ebp),%eax
    204a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    204d:	eb 1b                	jmp    206a <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    204f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2052:	8b 00                	mov    (%eax),%eax
    2054:	8d 48 01             	lea    0x1(%eax),%ecx
    2057:	8b 55 0c             	mov    0xc(%ebp),%edx
    205a:	89 0a                	mov    %ecx,(%edx)
    205c:	89 c2                	mov    %eax,%edx
    205e:	8b 45 08             	mov    0x8(%ebp),%eax
    2061:	01 d0                	add    %edx,%eax
    2063:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2066:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    206a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    206e:	7f df                	jg     204f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2070:	eb 21                	jmp    2093 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2072:	8b 45 0c             	mov    0xc(%ebp),%eax
    2075:	8b 00                	mov    (%eax),%eax
    2077:	8d 48 01             	lea    0x1(%eax),%ecx
    207a:	8b 55 0c             	mov    0xc(%ebp),%edx
    207d:	89 0a                	mov    %ecx,(%edx)
    207f:	89 c2                	mov    %eax,%edx
    2081:	8b 45 08             	mov    0x8(%ebp),%eax
    2084:	01 c2                	add    %eax,%edx
    2086:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2089:	8b 45 f8             	mov    -0x8(%ebp),%eax
    208c:	01 c8                	add    %ecx,%eax
    208e:	0f b6 00             	movzbl (%eax),%eax
    2091:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2093:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2097:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    209b:	79 d5                	jns    2072 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    209d:	90                   	nop
    209e:	83 c4 20             	add    $0x20,%esp
    20a1:	5b                   	pop    %ebx
    20a2:	5d                   	pop    %ebp
    20a3:	c3                   	ret    

000020a4 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    20a4:	55                   	push   %ebp
    20a5:	89 e5                	mov    %esp,%ebp
    20a7:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    20aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    20b1:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    20b8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    20bf:	8d 45 0c             	lea    0xc(%ebp),%eax
    20c2:	83 c0 04             	add    $0x4,%eax
    20c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    20c8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    20cf:	e9 d9 01 00 00       	jmp    22ad <sprintf+0x209>
        c = fmt[i] & 0xff;
    20d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    20d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    20da:	01 d0                	add    %edx,%eax
    20dc:	0f b6 00             	movzbl (%eax),%eax
    20df:	0f be c0             	movsbl %al,%eax
    20e2:	25 ff 00 00 00       	and    $0xff,%eax
    20e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    20ea:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    20ee:	75 2c                	jne    211c <sprintf+0x78>
            if(c == '%'){
    20f0:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20f4:	75 0c                	jne    2102 <sprintf+0x5e>
                state = '%';
    20f6:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    20fd:	e9 a7 01 00 00       	jmp    22a9 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2102:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2105:	8d 50 01             	lea    0x1(%eax),%edx
    2108:	89 55 c8             	mov    %edx,-0x38(%ebp)
    210b:	89 c2                	mov    %eax,%edx
    210d:	8b 45 08             	mov    0x8(%ebp),%eax
    2110:	01 d0                	add    %edx,%eax
    2112:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2115:	88 10                	mov    %dl,(%eax)
    2117:	e9 8d 01 00 00       	jmp    22a9 <sprintf+0x205>
            }
        } else if(state == '%'){
    211c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2120:	0f 85 83 01 00 00    	jne    22a9 <sprintf+0x205>
            if(c == 'd'){
    2126:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    212a:	75 4c                	jne    2178 <sprintf+0xd4>
                buf[bi] = '\0';
    212c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    212f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2132:	01 d0                	add    %edx,%eax
    2134:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2137:	83 ec 0c             	sub    $0xc,%esp
    213a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    213d:	50                   	push   %eax
    213e:	e8 91 e1 ff ff       	call   2d4 <atoi>
    2143:	83 c4 10             	add    $0x10,%esp
    2146:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2149:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2150:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2153:	8b 00                	mov    (%eax),%eax
    2155:	83 ec 08             	sub    $0x8,%esp
    2158:	ff 75 d8             	pushl  -0x28(%ebp)
    215b:	6a 01                	push   $0x1
    215d:	6a 0a                	push   $0xa
    215f:	50                   	push   %eax
    2160:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2163:	50                   	push   %eax
    2164:	ff 75 08             	pushl  0x8(%ebp)
    2167:	e8 56 fe ff ff       	call   1fc2 <sprintint>
    216c:	83 c4 20             	add    $0x20,%esp
                ap++;
    216f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2173:	e9 2a 01 00 00       	jmp    22a2 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2178:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    217c:	74 06                	je     2184 <sprintf+0xe0>
    217e:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2182:	75 4c                	jne    21d0 <sprintf+0x12c>
                buf[bi] = '\0';
    2184:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2187:	8b 45 f0             	mov    -0x10(%ebp),%eax
    218a:	01 d0                	add    %edx,%eax
    218c:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    218f:	83 ec 0c             	sub    $0xc,%esp
    2192:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2195:	50                   	push   %eax
    2196:	e8 39 e1 ff ff       	call   2d4 <atoi>
    219b:	83 c4 10             	add    $0x10,%esp
    219e:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    21a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    21a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21ab:	8b 00                	mov    (%eax),%eax
    21ad:	83 ec 08             	sub    $0x8,%esp
    21b0:	ff 75 dc             	pushl  -0x24(%ebp)
    21b3:	6a 00                	push   $0x0
    21b5:	6a 10                	push   $0x10
    21b7:	50                   	push   %eax
    21b8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21bb:	50                   	push   %eax
    21bc:	ff 75 08             	pushl  0x8(%ebp)
    21bf:	e8 fe fd ff ff       	call   1fc2 <sprintint>
    21c4:	83 c4 20             	add    $0x20,%esp
                ap++;
    21c7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    21cb:	e9 d2 00 00 00       	jmp    22a2 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    21d0:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    21d4:	75 46                	jne    221c <sprintf+0x178>
                s = (char*)*ap;
    21d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21d9:	8b 00                	mov    (%eax),%eax
    21db:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    21de:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    21e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    21e6:	75 25                	jne    220d <sprintf+0x169>
                    s = "(null)";
    21e8:	c7 45 f4 74 24 00 00 	movl   $0x2474,-0xc(%ebp)
                while(*s != 0){
    21ef:	eb 1c                	jmp    220d <sprintf+0x169>
                    dst[j++] = *s;
    21f1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21f4:	8d 50 01             	lea    0x1(%eax),%edx
    21f7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21fa:	89 c2                	mov    %eax,%edx
    21fc:	8b 45 08             	mov    0x8(%ebp),%eax
    21ff:	01 c2                	add    %eax,%edx
    2201:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2204:	0f b6 00             	movzbl (%eax),%eax
    2207:	88 02                	mov    %al,(%edx)
                    s++;
    2209:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    220d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2210:	0f b6 00             	movzbl (%eax),%eax
    2213:	84 c0                	test   %al,%al
    2215:	75 da                	jne    21f1 <sprintf+0x14d>
    2217:	e9 86 00 00 00       	jmp    22a2 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    221c:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2220:	75 1d                	jne    223f <sprintf+0x19b>
                dst[j++] = *ap;
    2222:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2225:	8d 50 01             	lea    0x1(%eax),%edx
    2228:	89 55 c8             	mov    %edx,-0x38(%ebp)
    222b:	89 c2                	mov    %eax,%edx
    222d:	8b 45 08             	mov    0x8(%ebp),%eax
    2230:	01 c2                	add    %eax,%edx
    2232:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2235:	8b 00                	mov    (%eax),%eax
    2237:	88 02                	mov    %al,(%edx)
                ap++;
    2239:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    223d:	eb 63                	jmp    22a2 <sprintf+0x1fe>
            } else if(c == '%'){
    223f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2243:	75 17                	jne    225c <sprintf+0x1b8>
                dst[j++] = c;
    2245:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2248:	8d 50 01             	lea    0x1(%eax),%edx
    224b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    224e:	89 c2                	mov    %eax,%edx
    2250:	8b 45 08             	mov    0x8(%ebp),%eax
    2253:	01 d0                	add    %edx,%eax
    2255:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2258:	88 10                	mov    %dl,(%eax)
    225a:	eb 46                	jmp    22a2 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    225c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2260:	7e 18                	jle    227a <sprintf+0x1d6>
    2262:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2266:	7f 12                	jg     227a <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2268:	8b 45 f0             	mov    -0x10(%ebp),%eax
    226b:	8d 50 01             	lea    0x1(%eax),%edx
    226e:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2271:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2274:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2278:	eb 2f                	jmp    22a9 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    227a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    227d:	8d 50 01             	lea    0x1(%eax),%edx
    2280:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2283:	89 c2                	mov    %eax,%edx
    2285:	8b 45 08             	mov    0x8(%ebp),%eax
    2288:	01 d0                	add    %edx,%eax
    228a:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    228d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2290:	8d 50 01             	lea    0x1(%eax),%edx
    2293:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2296:	89 c2                	mov    %eax,%edx
    2298:	8b 45 08             	mov    0x8(%ebp),%eax
    229b:	01 d0                	add    %edx,%eax
    229d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22a0:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    22a2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    22a9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    22ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    22b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22b3:	01 d0                	add    %edx,%eax
    22b5:	0f b6 00             	movzbl (%eax),%eax
    22b8:	84 c0                	test   %al,%al
    22ba:	0f 85 14 fe ff ff    	jne    20d4 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    22c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22c3:	8d 50 01             	lea    0x1(%eax),%edx
    22c6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22c9:	89 c2                	mov    %eax,%edx
    22cb:	8b 45 08             	mov    0x8(%ebp),%eax
    22ce:	01 d0                	add    %edx,%eax
    22d0:	c6 00 00             	movb   $0x0,(%eax)
}
    22d3:	90                   	nop
    22d4:	c9                   	leave  
    22d5:	c3                   	ret    
