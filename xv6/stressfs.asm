
_stressfs：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
      14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
      1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
      22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
      28:	83 ec 08             	sub    $0x8,%esp
      2b:	68 9c 26 00 00       	push   $0x269c
      30:	6a 01                	push   $0x1
      32:	e8 31 05 00 00       	call   568 <printf>
      37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
      3a:	83 ec 04             	sub    $0x4,%esp
      3d:	68 00 02 00 00       	push   $0x200
      42:	6a 61                	push   $0x61
      44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
      4a:	50                   	push   %eax
      4b:	e8 be 01 00 00       	call   20e <memset>
      50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
      53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      5a:	eb 0d                	jmp    69 <main+0x69>
    if(fork() > 0)
      5c:	e8 40 03 00 00       	call   3a1 <fork>
      61:	85 c0                	test   %eax,%eax
      63:	7f 0c                	jg     71 <main+0x71>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
      65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      69:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
      6d:	7e ed                	jle    5c <main+0x5c>
      6f:	eb 01                	jmp    72 <main+0x72>
    if(fork() > 0)
      break;
      71:	90                   	nop

  printf(1, "write %d\n", i);
      72:	83 ec 04             	sub    $0x4,%esp
      75:	ff 75 f4             	pushl  -0xc(%ebp)
      78:	68 af 26 00 00       	push   $0x26af
      7d:	6a 01                	push   $0x1
      7f:	e8 e4 04 00 00       	call   568 <printf>
      84:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
      87:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
      8b:	89 c2                	mov    %eax,%edx
      8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      90:	01 d0                	add    %edx,%eax
      92:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
      95:	83 ec 08             	sub    $0x8,%esp
      98:	68 02 02 00 00       	push   $0x202
      9d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
      a0:	50                   	push   %eax
      a1:	e8 43 03 00 00       	call   3e9 <open>
      a6:	83 c4 10             	add    $0x10,%esp
      a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
      ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      b3:	eb 1e                	jmp    d3 <main+0xd3>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
      b5:	83 ec 04             	sub    $0x4,%esp
      b8:	68 00 02 00 00       	push   $0x200
      bd:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
      c3:	50                   	push   %eax
      c4:	ff 75 f0             	pushl  -0x10(%ebp)
      c7:	e8 fd 02 00 00       	call   3c9 <write>
      cc:	83 c4 10             	add    $0x10,%esp

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
      cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      d3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
      d7:	7e dc                	jle    b5 <main+0xb5>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	ff 75 f0             	pushl  -0x10(%ebp)
      df:	e8 ed 02 00 00       	call   3d1 <close>
      e4:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
      e7:	83 ec 08             	sub    $0x8,%esp
      ea:	68 b9 26 00 00       	push   $0x26b9
      ef:	6a 01                	push   $0x1
      f1:	e8 72 04 00 00       	call   568 <printf>
      f6:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
      f9:	83 ec 08             	sub    $0x8,%esp
      fc:	6a 00                	push   $0x0
      fe:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     101:	50                   	push   %eax
     102:	e8 e2 02 00 00       	call   3e9 <open>
     107:	83 c4 10             	add    $0x10,%esp
     10a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
     10d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     114:	eb 1e                	jmp    134 <main+0x134>
    read(fd, data, sizeof(data));
     116:	83 ec 04             	sub    $0x4,%esp
     119:	68 00 02 00 00       	push   $0x200
     11e:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
     124:	50                   	push   %eax
     125:	ff 75 f0             	pushl  -0x10(%ebp)
     128:	e8 94 02 00 00       	call   3c1 <read>
     12d:	83 c4 10             	add    $0x10,%esp
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
     130:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     134:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
     138:	7e dc                	jle    116 <main+0x116>
    read(fd, data, sizeof(data));
  close(fd);
     13a:	83 ec 0c             	sub    $0xc,%esp
     13d:	ff 75 f0             	pushl  -0x10(%ebp)
     140:	e8 8c 02 00 00       	call   3d1 <close>
     145:	83 c4 10             	add    $0x10,%esp

  wait();
     148:	e8 64 02 00 00       	call   3b1 <wait>
  
  exit();
     14d:	e8 57 02 00 00       	call   3a9 <exit>

00000152 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     152:	55                   	push   %ebp
     153:	89 e5                	mov    %esp,%ebp
     155:	57                   	push   %edi
     156:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     157:	8b 4d 08             	mov    0x8(%ebp),%ecx
     15a:	8b 55 10             	mov    0x10(%ebp),%edx
     15d:	8b 45 0c             	mov    0xc(%ebp),%eax
     160:	89 cb                	mov    %ecx,%ebx
     162:	89 df                	mov    %ebx,%edi
     164:	89 d1                	mov    %edx,%ecx
     166:	fc                   	cld    
     167:	f3 aa                	rep stos %al,%es:(%edi)
     169:	89 ca                	mov    %ecx,%edx
     16b:	89 fb                	mov    %edi,%ebx
     16d:	89 5d 08             	mov    %ebx,0x8(%ebp)
     170:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     173:	90                   	nop
     174:	5b                   	pop    %ebx
     175:	5f                   	pop    %edi
     176:	5d                   	pop    %ebp
     177:	c3                   	ret    

00000178 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     178:	55                   	push   %ebp
     179:	89 e5                	mov    %esp,%ebp
     17b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     17e:	8b 45 08             	mov    0x8(%ebp),%eax
     181:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     184:	90                   	nop
     185:	8b 45 08             	mov    0x8(%ebp),%eax
     188:	8d 50 01             	lea    0x1(%eax),%edx
     18b:	89 55 08             	mov    %edx,0x8(%ebp)
     18e:	8b 55 0c             	mov    0xc(%ebp),%edx
     191:	8d 4a 01             	lea    0x1(%edx),%ecx
     194:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     197:	0f b6 12             	movzbl (%edx),%edx
     19a:	88 10                	mov    %dl,(%eax)
     19c:	0f b6 00             	movzbl (%eax),%eax
     19f:	84 c0                	test   %al,%al
     1a1:	75 e2                	jne    185 <strcpy+0xd>
    ;
  return os;
     1a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1a6:	c9                   	leave  
     1a7:	c3                   	ret    

000001a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1a8:	55                   	push   %ebp
     1a9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     1ab:	eb 08                	jmp    1b5 <strcmp+0xd>
    p++, q++;
     1ad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1b1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     1b5:	8b 45 08             	mov    0x8(%ebp),%eax
     1b8:	0f b6 00             	movzbl (%eax),%eax
     1bb:	84 c0                	test   %al,%al
     1bd:	74 10                	je     1cf <strcmp+0x27>
     1bf:	8b 45 08             	mov    0x8(%ebp),%eax
     1c2:	0f b6 10             	movzbl (%eax),%edx
     1c5:	8b 45 0c             	mov    0xc(%ebp),%eax
     1c8:	0f b6 00             	movzbl (%eax),%eax
     1cb:	38 c2                	cmp    %al,%dl
     1cd:	74 de                	je     1ad <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     1cf:	8b 45 08             	mov    0x8(%ebp),%eax
     1d2:	0f b6 00             	movzbl (%eax),%eax
     1d5:	0f b6 d0             	movzbl %al,%edx
     1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
     1db:	0f b6 00             	movzbl (%eax),%eax
     1de:	0f b6 c0             	movzbl %al,%eax
     1e1:	29 c2                	sub    %eax,%edx
     1e3:	89 d0                	mov    %edx,%eax
}
     1e5:	5d                   	pop    %ebp
     1e6:	c3                   	ret    

000001e7 <strlen>:

uint
strlen(char *s)
{
     1e7:	55                   	push   %ebp
     1e8:	89 e5                	mov    %esp,%ebp
     1ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1f4:	eb 04                	jmp    1fa <strlen+0x13>
     1f6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1fd:	8b 45 08             	mov    0x8(%ebp),%eax
     200:	01 d0                	add    %edx,%eax
     202:	0f b6 00             	movzbl (%eax),%eax
     205:	84 c0                	test   %al,%al
     207:	75 ed                	jne    1f6 <strlen+0xf>
    ;
  return n;
     209:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     20c:	c9                   	leave  
     20d:	c3                   	ret    

0000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
     20e:	55                   	push   %ebp
     20f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     211:	8b 45 10             	mov    0x10(%ebp),%eax
     214:	50                   	push   %eax
     215:	ff 75 0c             	pushl  0xc(%ebp)
     218:	ff 75 08             	pushl  0x8(%ebp)
     21b:	e8 32 ff ff ff       	call   152 <stosb>
     220:	83 c4 0c             	add    $0xc,%esp
  return dst;
     223:	8b 45 08             	mov    0x8(%ebp),%eax
}
     226:	c9                   	leave  
     227:	c3                   	ret    

00000228 <strchr>:

char*
strchr(const char *s, char c)
{
     228:	55                   	push   %ebp
     229:	89 e5                	mov    %esp,%ebp
     22b:	83 ec 04             	sub    $0x4,%esp
     22e:	8b 45 0c             	mov    0xc(%ebp),%eax
     231:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     234:	eb 14                	jmp    24a <strchr+0x22>
    if(*s == c)
     236:	8b 45 08             	mov    0x8(%ebp),%eax
     239:	0f b6 00             	movzbl (%eax),%eax
     23c:	3a 45 fc             	cmp    -0x4(%ebp),%al
     23f:	75 05                	jne    246 <strchr+0x1e>
      return (char*)s;
     241:	8b 45 08             	mov    0x8(%ebp),%eax
     244:	eb 13                	jmp    259 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     246:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     24a:	8b 45 08             	mov    0x8(%ebp),%eax
     24d:	0f b6 00             	movzbl (%eax),%eax
     250:	84 c0                	test   %al,%al
     252:	75 e2                	jne    236 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     254:	b8 00 00 00 00       	mov    $0x0,%eax
}
     259:	c9                   	leave  
     25a:	c3                   	ret    

0000025b <gets>:

char*
gets(char *buf, int max)
{
     25b:	55                   	push   %ebp
     25c:	89 e5                	mov    %esp,%ebp
     25e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     261:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     268:	eb 42                	jmp    2ac <gets+0x51>
    cc = read(0, &c, 1);
     26a:	83 ec 04             	sub    $0x4,%esp
     26d:	6a 01                	push   $0x1
     26f:	8d 45 ef             	lea    -0x11(%ebp),%eax
     272:	50                   	push   %eax
     273:	6a 00                	push   $0x0
     275:	e8 47 01 00 00       	call   3c1 <read>
     27a:	83 c4 10             	add    $0x10,%esp
     27d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     284:	7e 33                	jle    2b9 <gets+0x5e>
      break;
    buf[i++] = c;
     286:	8b 45 f4             	mov    -0xc(%ebp),%eax
     289:	8d 50 01             	lea    0x1(%eax),%edx
     28c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     28f:	89 c2                	mov    %eax,%edx
     291:	8b 45 08             	mov    0x8(%ebp),%eax
     294:	01 c2                	add    %eax,%edx
     296:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     29a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     29c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2a0:	3c 0a                	cmp    $0xa,%al
     2a2:	74 16                	je     2ba <gets+0x5f>
     2a4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2a8:	3c 0d                	cmp    $0xd,%al
     2aa:	74 0e                	je     2ba <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2af:	83 c0 01             	add    $0x1,%eax
     2b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
     2b5:	7c b3                	jl     26a <gets+0xf>
     2b7:	eb 01                	jmp    2ba <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     2b9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     2ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
     2c0:	01 d0                	add    %edx,%eax
     2c2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     2c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2c8:	c9                   	leave  
     2c9:	c3                   	ret    

000002ca <stat>:

int
stat(char *n, struct stat *st)
{
     2ca:	55                   	push   %ebp
     2cb:	89 e5                	mov    %esp,%ebp
     2cd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2d0:	83 ec 08             	sub    $0x8,%esp
     2d3:	6a 00                	push   $0x0
     2d5:	ff 75 08             	pushl  0x8(%ebp)
     2d8:	e8 0c 01 00 00       	call   3e9 <open>
     2dd:	83 c4 10             	add    $0x10,%esp
     2e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e7:	79 07                	jns    2f0 <stat+0x26>
    return -1;
     2e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2ee:	eb 25                	jmp    315 <stat+0x4b>
  r = fstat(fd, st);
     2f0:	83 ec 08             	sub    $0x8,%esp
     2f3:	ff 75 0c             	pushl  0xc(%ebp)
     2f6:	ff 75 f4             	pushl  -0xc(%ebp)
     2f9:	e8 03 01 00 00       	call   401 <fstat>
     2fe:	83 c4 10             	add    $0x10,%esp
     301:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     304:	83 ec 0c             	sub    $0xc,%esp
     307:	ff 75 f4             	pushl  -0xc(%ebp)
     30a:	e8 c2 00 00 00       	call   3d1 <close>
     30f:	83 c4 10             	add    $0x10,%esp
  return r;
     312:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     315:	c9                   	leave  
     316:	c3                   	ret    

00000317 <atoi>:

int
atoi(const char *s)
{
     317:	55                   	push   %ebp
     318:	89 e5                	mov    %esp,%ebp
     31a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     31d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     324:	eb 25                	jmp    34b <atoi+0x34>
    n = n*10 + *s++ - '0';
     326:	8b 55 fc             	mov    -0x4(%ebp),%edx
     329:	89 d0                	mov    %edx,%eax
     32b:	c1 e0 02             	shl    $0x2,%eax
     32e:	01 d0                	add    %edx,%eax
     330:	01 c0                	add    %eax,%eax
     332:	89 c1                	mov    %eax,%ecx
     334:	8b 45 08             	mov    0x8(%ebp),%eax
     337:	8d 50 01             	lea    0x1(%eax),%edx
     33a:	89 55 08             	mov    %edx,0x8(%ebp)
     33d:	0f b6 00             	movzbl (%eax),%eax
     340:	0f be c0             	movsbl %al,%eax
     343:	01 c8                	add    %ecx,%eax
     345:	83 e8 30             	sub    $0x30,%eax
     348:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     34b:	8b 45 08             	mov    0x8(%ebp),%eax
     34e:	0f b6 00             	movzbl (%eax),%eax
     351:	3c 2f                	cmp    $0x2f,%al
     353:	7e 0a                	jle    35f <atoi+0x48>
     355:	8b 45 08             	mov    0x8(%ebp),%eax
     358:	0f b6 00             	movzbl (%eax),%eax
     35b:	3c 39                	cmp    $0x39,%al
     35d:	7e c7                	jle    326 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     35f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     362:	c9                   	leave  
     363:	c3                   	ret    

00000364 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     364:	55                   	push   %ebp
     365:	89 e5                	mov    %esp,%ebp
     367:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     36a:	8b 45 08             	mov    0x8(%ebp),%eax
     36d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     370:	8b 45 0c             	mov    0xc(%ebp),%eax
     373:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     376:	eb 17                	jmp    38f <memmove+0x2b>
    *dst++ = *src++;
     378:	8b 45 fc             	mov    -0x4(%ebp),%eax
     37b:	8d 50 01             	lea    0x1(%eax),%edx
     37e:	89 55 fc             	mov    %edx,-0x4(%ebp)
     381:	8b 55 f8             	mov    -0x8(%ebp),%edx
     384:	8d 4a 01             	lea    0x1(%edx),%ecx
     387:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     38a:	0f b6 12             	movzbl (%edx),%edx
     38d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     38f:	8b 45 10             	mov    0x10(%ebp),%eax
     392:	8d 50 ff             	lea    -0x1(%eax),%edx
     395:	89 55 10             	mov    %edx,0x10(%ebp)
     398:	85 c0                	test   %eax,%eax
     39a:	7f dc                	jg     378 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     39c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     39f:	c9                   	leave  
     3a0:	c3                   	ret    

000003a1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     3a1:	b8 01 00 00 00       	mov    $0x1,%eax
     3a6:	cd 40                	int    $0x40
     3a8:	c3                   	ret    

000003a9 <exit>:
SYSCALL(exit)
     3a9:	b8 02 00 00 00       	mov    $0x2,%eax
     3ae:	cd 40                	int    $0x40
     3b0:	c3                   	ret    

000003b1 <wait>:
SYSCALL(wait)
     3b1:	b8 03 00 00 00       	mov    $0x3,%eax
     3b6:	cd 40                	int    $0x40
     3b8:	c3                   	ret    

000003b9 <pipe>:
SYSCALL(pipe)
     3b9:	b8 04 00 00 00       	mov    $0x4,%eax
     3be:	cd 40                	int    $0x40
     3c0:	c3                   	ret    

000003c1 <read>:
SYSCALL(read)
     3c1:	b8 05 00 00 00       	mov    $0x5,%eax
     3c6:	cd 40                	int    $0x40
     3c8:	c3                   	ret    

000003c9 <write>:
SYSCALL(write)
     3c9:	b8 10 00 00 00       	mov    $0x10,%eax
     3ce:	cd 40                	int    $0x40
     3d0:	c3                   	ret    

000003d1 <close>:
SYSCALL(close)
     3d1:	b8 15 00 00 00       	mov    $0x15,%eax
     3d6:	cd 40                	int    $0x40
     3d8:	c3                   	ret    

000003d9 <kill>:
SYSCALL(kill)
     3d9:	b8 06 00 00 00       	mov    $0x6,%eax
     3de:	cd 40                	int    $0x40
     3e0:	c3                   	ret    

000003e1 <exec>:
SYSCALL(exec)
     3e1:	b8 07 00 00 00       	mov    $0x7,%eax
     3e6:	cd 40                	int    $0x40
     3e8:	c3                   	ret    

000003e9 <open>:
SYSCALL(open)
     3e9:	b8 0f 00 00 00       	mov    $0xf,%eax
     3ee:	cd 40                	int    $0x40
     3f0:	c3                   	ret    

000003f1 <mknod>:
SYSCALL(mknod)
     3f1:	b8 11 00 00 00       	mov    $0x11,%eax
     3f6:	cd 40                	int    $0x40
     3f8:	c3                   	ret    

000003f9 <unlink>:
SYSCALL(unlink)
     3f9:	b8 12 00 00 00       	mov    $0x12,%eax
     3fe:	cd 40                	int    $0x40
     400:	c3                   	ret    

00000401 <fstat>:
SYSCALL(fstat)
     401:	b8 08 00 00 00       	mov    $0x8,%eax
     406:	cd 40                	int    $0x40
     408:	c3                   	ret    

00000409 <link>:
SYSCALL(link)
     409:	b8 13 00 00 00       	mov    $0x13,%eax
     40e:	cd 40                	int    $0x40
     410:	c3                   	ret    

00000411 <mkdir>:
SYSCALL(mkdir)
     411:	b8 14 00 00 00       	mov    $0x14,%eax
     416:	cd 40                	int    $0x40
     418:	c3                   	ret    

00000419 <chdir>:
SYSCALL(chdir)
     419:	b8 09 00 00 00       	mov    $0x9,%eax
     41e:	cd 40                	int    $0x40
     420:	c3                   	ret    

00000421 <dup>:
SYSCALL(dup)
     421:	b8 0a 00 00 00       	mov    $0xa,%eax
     426:	cd 40                	int    $0x40
     428:	c3                   	ret    

00000429 <getpid>:
SYSCALL(getpid)
     429:	b8 0b 00 00 00       	mov    $0xb,%eax
     42e:	cd 40                	int    $0x40
     430:	c3                   	ret    

00000431 <sbrk>:
SYSCALL(sbrk)
     431:	b8 0c 00 00 00       	mov    $0xc,%eax
     436:	cd 40                	int    $0x40
     438:	c3                   	ret    

00000439 <sleep>:
SYSCALL(sleep)
     439:	b8 0d 00 00 00       	mov    $0xd,%eax
     43e:	cd 40                	int    $0x40
     440:	c3                   	ret    

00000441 <uptime>:
SYSCALL(uptime)
     441:	b8 0e 00 00 00       	mov    $0xe,%eax
     446:	cd 40                	int    $0x40
     448:	c3                   	ret    

00000449 <paintWindow>:

SYSCALL(paintWindow)
     449:	b8 16 00 00 00       	mov    $0x16,%eax
     44e:	cd 40                	int    $0x40
     450:	c3                   	ret    

00000451 <sendMessage>:
SYSCALL(sendMessage)
     451:	b8 17 00 00 00       	mov    $0x17,%eax
     456:	cd 40                	int    $0x40
     458:	c3                   	ret    

00000459 <getMessage>:
SYSCALL(getMessage)
     459:	b8 19 00 00 00       	mov    $0x19,%eax
     45e:	cd 40                	int    $0x40
     460:	c3                   	ret    

00000461 <registWindow>:
SYSCALL(registWindow)
     461:	b8 18 00 00 00       	mov    $0x18,%eax
     466:	cd 40                	int    $0x40
     468:	c3                   	ret    

00000469 <changePosition>:
SYSCALL(changePosition)
     469:	b8 1a 00 00 00       	mov    $0x1a,%eax
     46e:	cd 40                	int    $0x40
     470:	c3                   	ret    

00000471 <setupTimer>:
SYSCALL(setupTimer)
     471:	b8 1b 00 00 00       	mov    $0x1b,%eax
     476:	cd 40                	int    $0x40
     478:	c3                   	ret    

00000479 <deleteTimer>:
SYSCALL(deleteTimer)
     479:	b8 1c 00 00 00       	mov    $0x1c,%eax
     47e:	cd 40                	int    $0x40
     480:	c3                   	ret    

00000481 <getCurrentTime>:
SYSCALL(getCurrentTime)
     481:	b8 1d 00 00 00       	mov    $0x1d,%eax
     486:	cd 40                	int    $0x40
     488:	c3                   	ret    

00000489 <removeWindow>:
SYSCALL(removeWindow)
     489:	b8 1e 00 00 00       	mov    $0x1e,%eax
     48e:	cd 40                	int    $0x40
     490:	c3                   	ret    

00000491 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     491:	55                   	push   %ebp
     492:	89 e5                	mov    %esp,%ebp
     494:	83 ec 18             	sub    $0x18,%esp
     497:	8b 45 0c             	mov    0xc(%ebp),%eax
     49a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     49d:	83 ec 04             	sub    $0x4,%esp
     4a0:	6a 01                	push   $0x1
     4a2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     4a5:	50                   	push   %eax
     4a6:	ff 75 08             	pushl  0x8(%ebp)
     4a9:	e8 1b ff ff ff       	call   3c9 <write>
     4ae:	83 c4 10             	add    $0x10,%esp
}
     4b1:	90                   	nop
     4b2:	c9                   	leave  
     4b3:	c3                   	ret    

000004b4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     4b4:	55                   	push   %ebp
     4b5:	89 e5                	mov    %esp,%ebp
     4b7:	53                   	push   %ebx
     4b8:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     4bb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     4c2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     4c6:	74 17                	je     4df <printint+0x2b>
     4c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4cc:	79 11                	jns    4df <printint+0x2b>
    neg = 1;
     4ce:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     4d5:	8b 45 0c             	mov    0xc(%ebp),%eax
     4d8:	f7 d8                	neg    %eax
     4da:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4dd:	eb 06                	jmp    4e5 <printint+0x31>
  } else {
    x = xx;
     4df:	8b 45 0c             	mov    0xc(%ebp),%eax
     4e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4ec:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4ef:	8d 41 01             	lea    0x1(%ecx),%eax
     4f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4fb:	ba 00 00 00 00       	mov    $0x0,%edx
     500:	f7 f3                	div    %ebx
     502:	89 d0                	mov    %edx,%eax
     504:	0f b6 80 00 2e 00 00 	movzbl 0x2e00(%eax),%eax
     50b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     50f:	8b 5d 10             	mov    0x10(%ebp),%ebx
     512:	8b 45 ec             	mov    -0x14(%ebp),%eax
     515:	ba 00 00 00 00       	mov    $0x0,%edx
     51a:	f7 f3                	div    %ebx
     51c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     51f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     523:	75 c7                	jne    4ec <printint+0x38>
  if(neg)
     525:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     529:	74 2d                	je     558 <printint+0xa4>
    buf[i++] = '-';
     52b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     52e:	8d 50 01             	lea    0x1(%eax),%edx
     531:	89 55 f4             	mov    %edx,-0xc(%ebp)
     534:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     539:	eb 1d                	jmp    558 <printint+0xa4>
    putc(fd, buf[i]);
     53b:	8d 55 dc             	lea    -0x24(%ebp),%edx
     53e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     541:	01 d0                	add    %edx,%eax
     543:	0f b6 00             	movzbl (%eax),%eax
     546:	0f be c0             	movsbl %al,%eax
     549:	83 ec 08             	sub    $0x8,%esp
     54c:	50                   	push   %eax
     54d:	ff 75 08             	pushl  0x8(%ebp)
     550:	e8 3c ff ff ff       	call   491 <putc>
     555:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     558:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     55c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     560:	79 d9                	jns    53b <printint+0x87>
    putc(fd, buf[i]);
}
     562:	90                   	nop
     563:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     566:	c9                   	leave  
     567:	c3                   	ret    

00000568 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     568:	55                   	push   %ebp
     569:	89 e5                	mov    %esp,%ebp
     56b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     56e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     575:	8d 45 0c             	lea    0xc(%ebp),%eax
     578:	83 c0 04             	add    $0x4,%eax
     57b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     57e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     585:	e9 59 01 00 00       	jmp    6e3 <printf+0x17b>
    c = fmt[i] & 0xff;
     58a:	8b 55 0c             	mov    0xc(%ebp),%edx
     58d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     590:	01 d0                	add    %edx,%eax
     592:	0f b6 00             	movzbl (%eax),%eax
     595:	0f be c0             	movsbl %al,%eax
     598:	25 ff 00 00 00       	and    $0xff,%eax
     59d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     5a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5a4:	75 2c                	jne    5d2 <printf+0x6a>
      if(c == '%'){
     5a6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5aa:	75 0c                	jne    5b8 <printf+0x50>
        state = '%';
     5ac:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     5b3:	e9 27 01 00 00       	jmp    6df <printf+0x177>
      } else {
        putc(fd, c);
     5b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5bb:	0f be c0             	movsbl %al,%eax
     5be:	83 ec 08             	sub    $0x8,%esp
     5c1:	50                   	push   %eax
     5c2:	ff 75 08             	pushl  0x8(%ebp)
     5c5:	e8 c7 fe ff ff       	call   491 <putc>
     5ca:	83 c4 10             	add    $0x10,%esp
     5cd:	e9 0d 01 00 00       	jmp    6df <printf+0x177>
      }
    } else if(state == '%'){
     5d2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     5d6:	0f 85 03 01 00 00    	jne    6df <printf+0x177>
      if(c == 'd'){
     5dc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5e0:	75 1e                	jne    600 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5e5:	8b 00                	mov    (%eax),%eax
     5e7:	6a 01                	push   $0x1
     5e9:	6a 0a                	push   $0xa
     5eb:	50                   	push   %eax
     5ec:	ff 75 08             	pushl  0x8(%ebp)
     5ef:	e8 c0 fe ff ff       	call   4b4 <printint>
     5f4:	83 c4 10             	add    $0x10,%esp
        ap++;
     5f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5fb:	e9 d8 00 00 00       	jmp    6d8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     600:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     604:	74 06                	je     60c <printf+0xa4>
     606:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     60a:	75 1e                	jne    62a <printf+0xc2>
        printint(fd, *ap, 16, 0);
     60c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     60f:	8b 00                	mov    (%eax),%eax
     611:	6a 00                	push   $0x0
     613:	6a 10                	push   $0x10
     615:	50                   	push   %eax
     616:	ff 75 08             	pushl  0x8(%ebp)
     619:	e8 96 fe ff ff       	call   4b4 <printint>
     61e:	83 c4 10             	add    $0x10,%esp
        ap++;
     621:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     625:	e9 ae 00 00 00       	jmp    6d8 <printf+0x170>
      } else if(c == 's'){
     62a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     62e:	75 43                	jne    673 <printf+0x10b>
        s = (char*)*ap;
     630:	8b 45 e8             	mov    -0x18(%ebp),%eax
     633:	8b 00                	mov    (%eax),%eax
     635:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     638:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     63c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     640:	75 25                	jne    667 <printf+0xff>
          s = "(null)";
     642:	c7 45 f4 bf 26 00 00 	movl   $0x26bf,-0xc(%ebp)
        while(*s != 0){
     649:	eb 1c                	jmp    667 <printf+0xff>
          putc(fd, *s);
     64b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     64e:	0f b6 00             	movzbl (%eax),%eax
     651:	0f be c0             	movsbl %al,%eax
     654:	83 ec 08             	sub    $0x8,%esp
     657:	50                   	push   %eax
     658:	ff 75 08             	pushl  0x8(%ebp)
     65b:	e8 31 fe ff ff       	call   491 <putc>
     660:	83 c4 10             	add    $0x10,%esp
          s++;
     663:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     667:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66a:	0f b6 00             	movzbl (%eax),%eax
     66d:	84 c0                	test   %al,%al
     66f:	75 da                	jne    64b <printf+0xe3>
     671:	eb 65                	jmp    6d8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     673:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     677:	75 1d                	jne    696 <printf+0x12e>
        putc(fd, *ap);
     679:	8b 45 e8             	mov    -0x18(%ebp),%eax
     67c:	8b 00                	mov    (%eax),%eax
     67e:	0f be c0             	movsbl %al,%eax
     681:	83 ec 08             	sub    $0x8,%esp
     684:	50                   	push   %eax
     685:	ff 75 08             	pushl  0x8(%ebp)
     688:	e8 04 fe ff ff       	call   491 <putc>
     68d:	83 c4 10             	add    $0x10,%esp
        ap++;
     690:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     694:	eb 42                	jmp    6d8 <printf+0x170>
      } else if(c == '%'){
     696:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     69a:	75 17                	jne    6b3 <printf+0x14b>
        putc(fd, c);
     69c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     69f:	0f be c0             	movsbl %al,%eax
     6a2:	83 ec 08             	sub    $0x8,%esp
     6a5:	50                   	push   %eax
     6a6:	ff 75 08             	pushl  0x8(%ebp)
     6a9:	e8 e3 fd ff ff       	call   491 <putc>
     6ae:	83 c4 10             	add    $0x10,%esp
     6b1:	eb 25                	jmp    6d8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     6b3:	83 ec 08             	sub    $0x8,%esp
     6b6:	6a 25                	push   $0x25
     6b8:	ff 75 08             	pushl  0x8(%ebp)
     6bb:	e8 d1 fd ff ff       	call   491 <putc>
     6c0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     6c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6c6:	0f be c0             	movsbl %al,%eax
     6c9:	83 ec 08             	sub    $0x8,%esp
     6cc:	50                   	push   %eax
     6cd:	ff 75 08             	pushl  0x8(%ebp)
     6d0:	e8 bc fd ff ff       	call   491 <putc>
     6d5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     6d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6df:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6e3:	8b 55 0c             	mov    0xc(%ebp),%edx
     6e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6e9:	01 d0                	add    %edx,%eax
     6eb:	0f b6 00             	movzbl (%eax),%eax
     6ee:	84 c0                	test   %al,%al
     6f0:	0f 85 94 fe ff ff    	jne    58a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6f6:	90                   	nop
     6f7:	c9                   	leave  
     6f8:	c3                   	ret    

000006f9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6f9:	55                   	push   %ebp
     6fa:	89 e5                	mov    %esp,%ebp
     6fc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6ff:	8b 45 08             	mov    0x8(%ebp),%eax
     702:	83 e8 08             	sub    $0x8,%eax
     705:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     708:	a1 60 6a 00 00       	mov    0x6a60,%eax
     70d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     710:	eb 24                	jmp    736 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     712:	8b 45 fc             	mov    -0x4(%ebp),%eax
     715:	8b 00                	mov    (%eax),%eax
     717:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     71a:	77 12                	ja     72e <free+0x35>
     71c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     71f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     722:	77 24                	ja     748 <free+0x4f>
     724:	8b 45 fc             	mov    -0x4(%ebp),%eax
     727:	8b 00                	mov    (%eax),%eax
     729:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     72c:	77 1a                	ja     748 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     731:	8b 00                	mov    (%eax),%eax
     733:	89 45 fc             	mov    %eax,-0x4(%ebp)
     736:	8b 45 f8             	mov    -0x8(%ebp),%eax
     739:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     73c:	76 d4                	jbe    712 <free+0x19>
     73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     741:	8b 00                	mov    (%eax),%eax
     743:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     746:	76 ca                	jbe    712 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     748:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74b:	8b 40 04             	mov    0x4(%eax),%eax
     74e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     755:	8b 45 f8             	mov    -0x8(%ebp),%eax
     758:	01 c2                	add    %eax,%edx
     75a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75d:	8b 00                	mov    (%eax),%eax
     75f:	39 c2                	cmp    %eax,%edx
     761:	75 24                	jne    787 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     763:	8b 45 f8             	mov    -0x8(%ebp),%eax
     766:	8b 50 04             	mov    0x4(%eax),%edx
     769:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76c:	8b 00                	mov    (%eax),%eax
     76e:	8b 40 04             	mov    0x4(%eax),%eax
     771:	01 c2                	add    %eax,%edx
     773:	8b 45 f8             	mov    -0x8(%ebp),%eax
     776:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     779:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77c:	8b 00                	mov    (%eax),%eax
     77e:	8b 10                	mov    (%eax),%edx
     780:	8b 45 f8             	mov    -0x8(%ebp),%eax
     783:	89 10                	mov    %edx,(%eax)
     785:	eb 0a                	jmp    791 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     787:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78a:	8b 10                	mov    (%eax),%edx
     78c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     78f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     791:	8b 45 fc             	mov    -0x4(%ebp),%eax
     794:	8b 40 04             	mov    0x4(%eax),%eax
     797:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     79e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a1:	01 d0                	add    %edx,%eax
     7a3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     7a6:	75 20                	jne    7c8 <free+0xcf>
    p->s.size += bp->s.size;
     7a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ab:	8b 50 04             	mov    0x4(%eax),%edx
     7ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7b1:	8b 40 04             	mov    0x4(%eax),%eax
     7b4:	01 c2                	add    %eax,%edx
     7b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     7bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7bf:	8b 10                	mov    (%eax),%edx
     7c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c4:	89 10                	mov    %edx,(%eax)
     7c6:	eb 08                	jmp    7d0 <free+0xd7>
  } else
    p->s.ptr = bp;
     7c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7cb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7ce:	89 10                	mov    %edx,(%eax)
  freep = p;
     7d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7d3:	a3 60 6a 00 00       	mov    %eax,0x6a60
}
     7d8:	90                   	nop
     7d9:	c9                   	leave  
     7da:	c3                   	ret    

000007db <morecore>:

static Header*
morecore(uint nu)
{
     7db:	55                   	push   %ebp
     7dc:	89 e5                	mov    %esp,%ebp
     7de:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7e8:	77 07                	ja     7f1 <morecore+0x16>
    nu = 4096;
     7ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7f1:	8b 45 08             	mov    0x8(%ebp),%eax
     7f4:	c1 e0 03             	shl    $0x3,%eax
     7f7:	83 ec 0c             	sub    $0xc,%esp
     7fa:	50                   	push   %eax
     7fb:	e8 31 fc ff ff       	call   431 <sbrk>
     800:	83 c4 10             	add    $0x10,%esp
     803:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     806:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     80a:	75 07                	jne    813 <morecore+0x38>
    return 0;
     80c:	b8 00 00 00 00       	mov    $0x0,%eax
     811:	eb 26                	jmp    839 <morecore+0x5e>
  hp = (Header*)p;
     813:	8b 45 f4             	mov    -0xc(%ebp),%eax
     816:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     819:	8b 45 f0             	mov    -0x10(%ebp),%eax
     81c:	8b 55 08             	mov    0x8(%ebp),%edx
     81f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     822:	8b 45 f0             	mov    -0x10(%ebp),%eax
     825:	83 c0 08             	add    $0x8,%eax
     828:	83 ec 0c             	sub    $0xc,%esp
     82b:	50                   	push   %eax
     82c:	e8 c8 fe ff ff       	call   6f9 <free>
     831:	83 c4 10             	add    $0x10,%esp
  return freep;
     834:	a1 60 6a 00 00       	mov    0x6a60,%eax
}
     839:	c9                   	leave  
     83a:	c3                   	ret    

0000083b <malloc>:

void*
malloc(uint nbytes)
{
     83b:	55                   	push   %ebp
     83c:	89 e5                	mov    %esp,%ebp
     83e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     841:	8b 45 08             	mov    0x8(%ebp),%eax
     844:	83 c0 07             	add    $0x7,%eax
     847:	c1 e8 03             	shr    $0x3,%eax
     84a:	83 c0 01             	add    $0x1,%eax
     84d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     850:	a1 60 6a 00 00       	mov    0x6a60,%eax
     855:	89 45 f0             	mov    %eax,-0x10(%ebp)
     858:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     85c:	75 23                	jne    881 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     85e:	c7 45 f0 58 6a 00 00 	movl   $0x6a58,-0x10(%ebp)
     865:	8b 45 f0             	mov    -0x10(%ebp),%eax
     868:	a3 60 6a 00 00       	mov    %eax,0x6a60
     86d:	a1 60 6a 00 00       	mov    0x6a60,%eax
     872:	a3 58 6a 00 00       	mov    %eax,0x6a58
    base.s.size = 0;
     877:	c7 05 5c 6a 00 00 00 	movl   $0x0,0x6a5c
     87e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     881:	8b 45 f0             	mov    -0x10(%ebp),%eax
     884:	8b 00                	mov    (%eax),%eax
     886:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     889:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88c:	8b 40 04             	mov    0x4(%eax),%eax
     88f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     892:	72 4d                	jb     8e1 <malloc+0xa6>
      if(p->s.size == nunits)
     894:	8b 45 f4             	mov    -0xc(%ebp),%eax
     897:	8b 40 04             	mov    0x4(%eax),%eax
     89a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     89d:	75 0c                	jne    8ab <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a2:	8b 10                	mov    (%eax),%edx
     8a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a7:	89 10                	mov    %edx,(%eax)
     8a9:	eb 26                	jmp    8d1 <malloc+0x96>
      else {
        p->s.size -= nunits;
     8ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ae:	8b 40 04             	mov    0x4(%eax),%eax
     8b1:	2b 45 ec             	sub    -0x14(%ebp),%eax
     8b4:	89 c2                	mov    %eax,%edx
     8b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bf:	8b 40 04             	mov    0x4(%eax),%eax
     8c2:	c1 e0 03             	shl    $0x3,%eax
     8c5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     8c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     8ce:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     8d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d4:	a3 60 6a 00 00       	mov    %eax,0x6a60
      return (void*)(p + 1);
     8d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8dc:	83 c0 08             	add    $0x8,%eax
     8df:	eb 3b                	jmp    91c <malloc+0xe1>
    }
    if(p == freep)
     8e1:	a1 60 6a 00 00       	mov    0x6a60,%eax
     8e6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8e9:	75 1e                	jne    909 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8eb:	83 ec 0c             	sub    $0xc,%esp
     8ee:	ff 75 ec             	pushl  -0x14(%ebp)
     8f1:	e8 e5 fe ff ff       	call   7db <morecore>
     8f6:	83 c4 10             	add    $0x10,%esp
     8f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     900:	75 07                	jne    909 <malloc+0xce>
        return 0;
     902:	b8 00 00 00 00       	mov    $0x0,%eax
     907:	eb 13                	jmp    91c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     909:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     90f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     912:	8b 00                	mov    (%eax),%eax
     914:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     917:	e9 6d ff ff ff       	jmp    889 <malloc+0x4e>
}
     91c:	c9                   	leave  
     91d:	c3                   	ret    

0000091e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     91e:	55                   	push   %ebp
     91f:	89 e5                	mov    %esp,%ebp
     921:	83 ec 1c             	sub    $0x1c,%esp
     924:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     927:	8b 55 10             	mov    0x10(%ebp),%edx
     92a:	8b 45 14             	mov    0x14(%ebp),%eax
     92d:	88 4d ec             	mov    %cl,-0x14(%ebp)
     930:	88 55 e8             	mov    %dl,-0x18(%ebp)
     933:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     936:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     93a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     93d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     941:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     944:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     948:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     94b:	8b 45 08             	mov    0x8(%ebp),%eax
     94e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     952:	66 89 10             	mov    %dx,(%eax)
     955:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     959:	88 50 02             	mov    %dl,0x2(%eax)
}
     95c:	8b 45 08             	mov    0x8(%ebp),%eax
     95f:	c9                   	leave  
     960:	c2 04 00             	ret    $0x4

00000963 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     963:	55                   	push   %ebp
     964:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     966:	8b 45 08             	mov    0x8(%ebp),%eax
     969:	2b 45 10             	sub    0x10(%ebp),%eax
     96c:	89 c2                	mov    %eax,%edx
     96e:	8b 45 08             	mov    0x8(%ebp),%eax
     971:	2b 45 10             	sub    0x10(%ebp),%eax
     974:	0f af d0             	imul   %eax,%edx
     977:	8b 45 0c             	mov    0xc(%ebp),%eax
     97a:	2b 45 14             	sub    0x14(%ebp),%eax
     97d:	89 c1                	mov    %eax,%ecx
     97f:	8b 45 0c             	mov    0xc(%ebp),%eax
     982:	2b 45 14             	sub    0x14(%ebp),%eax
     985:	0f af c1             	imul   %ecx,%eax
     988:	01 d0                	add    %edx,%eax
}
     98a:	5d                   	pop    %ebp
     98b:	c3                   	ret    

0000098c <abs_int>:

static inline int abs_int(int x)
{
     98c:	55                   	push   %ebp
     98d:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     98f:	8b 45 08             	mov    0x8(%ebp),%eax
     992:	99                   	cltd   
     993:	89 d0                	mov    %edx,%eax
     995:	33 45 08             	xor    0x8(%ebp),%eax
     998:	29 d0                	sub    %edx,%eax
}
     99a:	5d                   	pop    %ebp
     99b:	c3                   	ret    

0000099c <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     99c:	55                   	push   %ebp
     99d:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     99f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9a3:	79 07                	jns    9ac <APGetIndex+0x10>
        return X_SMALLER;
     9a5:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     9aa:	eb 40                	jmp    9ec <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     9ac:	8b 45 08             	mov    0x8(%ebp),%eax
     9af:	8b 00                	mov    (%eax),%eax
     9b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     9b4:	7f 07                	jg     9bd <APGetIndex+0x21>
        return X_BIGGER;
     9b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     9bb:	eb 2f                	jmp    9ec <APGetIndex+0x50>
    if (y < 0)
     9bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     9c1:	79 07                	jns    9ca <APGetIndex+0x2e>
        return Y_SMALLER;
     9c3:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     9c8:	eb 22                	jmp    9ec <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     9ca:	8b 45 08             	mov    0x8(%ebp),%eax
     9cd:	8b 40 04             	mov    0x4(%eax),%eax
     9d0:	3b 45 10             	cmp    0x10(%ebp),%eax
     9d3:	7f 07                	jg     9dc <APGetIndex+0x40>
        return Y_BIGGER;
     9d5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     9da:	eb 10                	jmp    9ec <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     9dc:	8b 45 08             	mov    0x8(%ebp),%eax
     9df:	8b 00                	mov    (%eax),%eax
     9e1:	0f af 45 10          	imul   0x10(%ebp),%eax
     9e5:	89 c2                	mov    %eax,%edx
     9e7:	8b 45 0c             	mov    0xc(%ebp),%eax
     9ea:	01 d0                	add    %edx,%eax
}
     9ec:	5d                   	pop    %ebp
     9ed:	c3                   	ret    

000009ee <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     9ee:	55                   	push   %ebp
     9ef:	89 e5                	mov    %esp,%ebp
     9f1:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9f4:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9fb:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9fe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     a01:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     a08:	83 ec 08             	sub    $0x8,%esp
     a0b:	6a 00                	push   $0x0
     a0d:	ff 75 0c             	pushl  0xc(%ebp)
     a10:	e8 d4 f9 ff ff       	call   3e9 <open>
     a15:	83 c4 10             	add    $0x10,%esp
     a18:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a1b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a1f:	79 2e                	jns    a4f <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a21:	83 ec 04             	sub    $0x4,%esp
     a24:	ff 75 0c             	pushl  0xc(%ebp)
     a27:	68 c6 26 00 00       	push   $0x26c6
     a2c:	6a 01                	push   $0x1
     a2e:	e8 35 fb ff ff       	call   568 <printf>
     a33:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a36:	8b 45 08             	mov    0x8(%ebp),%eax
     a39:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a3c:	89 10                	mov    %edx,(%eax)
     a3e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a41:	89 50 04             	mov    %edx,0x4(%eax)
     a44:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a47:	89 50 08             	mov    %edx,0x8(%eax)
     a4a:	e9 d2 01 00 00       	jmp    c21 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a4f:	83 ec 04             	sub    $0x4,%esp
     a52:	6a 0e                	push   $0xe
     a54:	8d 45 ba             	lea    -0x46(%ebp),%eax
     a57:	50                   	push   %eax
     a58:	ff 75 ec             	pushl  -0x14(%ebp)
     a5b:	e8 61 f9 ff ff       	call   3c1 <read>
     a60:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a63:	83 ec 04             	sub    $0x4,%esp
     a66:	6a 28                	push   $0x28
     a68:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a6b:	50                   	push   %eax
     a6c:	ff 75 ec             	pushl  -0x14(%ebp)
     a6f:	e8 4d f9 ff ff       	call   3c1 <read>
     a74:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a77:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a7a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a7d:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a80:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a83:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a86:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a89:	0f af d0             	imul   %eax,%edx
     a8c:	89 d0                	mov    %edx,%eax
     a8e:	01 c0                	add    %eax,%eax
     a90:	01 d0                	add    %edx,%eax
     a92:	83 ec 0c             	sub    $0xc,%esp
     a95:	50                   	push   %eax
     a96:	e8 a0 fd ff ff       	call   83b <malloc>
     a9b:	83 c4 10             	add    $0x10,%esp
     a9e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     aa1:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     aa5:	0f b7 c0             	movzwl %ax,%eax
     aa8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     aab:	8b 55 c8             	mov    -0x38(%ebp),%edx
     aae:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ab1:	0f af c2             	imul   %edx,%eax
     ab4:	83 c0 1f             	add    $0x1f,%eax
     ab7:	c1 e8 05             	shr    $0x5,%eax
     aba:	c1 e0 02             	shl    $0x2,%eax
     abd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     ac0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ac3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ac6:	0f af c2             	imul   %edx,%eax
     ac9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     acc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	50                   	push   %eax
     ad3:	e8 63 fd ff ff       	call   83b <malloc>
     ad8:	83 c4 10             	add    $0x10,%esp
     adb:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ade:	83 ec 04             	sub    $0x4,%esp
     ae1:	ff 75 e0             	pushl  -0x20(%ebp)
     ae4:	ff 75 dc             	pushl  -0x24(%ebp)
     ae7:	ff 75 ec             	pushl  -0x14(%ebp)
     aea:	e8 d2 f8 ff ff       	call   3c1 <read>
     aef:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     af2:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     af6:	66 c1 e8 03          	shr    $0x3,%ax
     afa:	0f b7 c0             	movzwl %ax,%eax
     afd:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     b00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b07:	e9 e5 00 00 00       	jmp    bf1 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     b0c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b12:	29 c2                	sub    %eax,%edx
     b14:	89 d0                	mov    %edx,%eax
     b16:	8d 50 ff             	lea    -0x1(%eax),%edx
     b19:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b1c:	0f af c2             	imul   %edx,%eax
     b1f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b29:	e9 b1 00 00 00       	jmp    bdf <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b2e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b31:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b34:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b37:	01 c8                	add    %ecx,%eax
     b39:	89 c1                	mov    %eax,%ecx
     b3b:	89 c8                	mov    %ecx,%eax
     b3d:	01 c0                	add    %eax,%eax
     b3f:	01 c8                	add    %ecx,%eax
     b41:	01 c2                	add    %eax,%edx
     b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b46:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b4a:	89 c1                	mov    %eax,%ecx
     b4c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b4f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b53:	01 c1                	add    %eax,%ecx
     b55:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b58:	01 c8                	add    %ecx,%eax
     b5a:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b5d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b60:	01 c8                	add    %ecx,%eax
     b62:	0f b6 00             	movzbl (%eax),%eax
     b65:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b68:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b6b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b71:	01 c8                	add    %ecx,%eax
     b73:	89 c1                	mov    %eax,%ecx
     b75:	89 c8                	mov    %ecx,%eax
     b77:	01 c0                	add    %eax,%eax
     b79:	01 c8                	add    %ecx,%eax
     b7b:	01 c2                	add    %eax,%edx
     b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b80:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b84:	89 c1                	mov    %eax,%ecx
     b86:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b89:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b8d:	01 c1                	add    %eax,%ecx
     b8f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b92:	01 c8                	add    %ecx,%eax
     b94:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b97:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b9a:	01 c8                	add    %ecx,%eax
     b9c:	0f b6 00             	movzbl (%eax),%eax
     b9f:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     ba2:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ba5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bab:	01 c8                	add    %ecx,%eax
     bad:	89 c1                	mov    %eax,%ecx
     baf:	89 c8                	mov    %ecx,%eax
     bb1:	01 c0                	add    %eax,%eax
     bb3:	01 c8                	add    %ecx,%eax
     bb5:	01 c2                	add    %eax,%edx
     bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bba:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     bbe:	89 c1                	mov    %eax,%ecx
     bc0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bc3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bc7:	01 c1                	add    %eax,%ecx
     bc9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bcc:	01 c8                	add    %ecx,%eax
     bce:	8d 48 fd             	lea    -0x3(%eax),%ecx
     bd1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bd4:	01 c8                	add    %ecx,%eax
     bd6:	0f b6 00             	movzbl (%eax),%eax
     bd9:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     bdb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bdf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     be2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     be5:	39 c2                	cmp    %eax,%edx
     be7:	0f 87 41 ff ff ff    	ja     b2e <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     bed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bf1:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf7:	39 c2                	cmp    %eax,%edx
     bf9:	0f 87 0d ff ff ff    	ja     b0c <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     bff:	83 ec 0c             	sub    $0xc,%esp
     c02:	ff 75 ec             	pushl  -0x14(%ebp)
     c05:	e8 c7 f7 ff ff       	call   3d1 <close>
     c0a:	83 c4 10             	add    $0x10,%esp
    return bmp;
     c0d:	8b 45 08             	mov    0x8(%ebp),%eax
     c10:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c13:	89 10                	mov    %edx,(%eax)
     c15:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c18:	89 50 04             	mov    %edx,0x4(%eax)
     c1b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c1e:	89 50 08             	mov    %edx,0x8(%eax)
}
     c21:	8b 45 08             	mov    0x8(%ebp),%eax
     c24:	c9                   	leave  
     c25:	c2 04 00             	ret    $0x4

00000c28 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c28:	55                   	push   %ebp
     c29:	89 e5                	mov    %esp,%ebp
     c2b:	53                   	push   %ebx
     c2c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c2f:	83 ec 0c             	sub    $0xc,%esp
     c32:	6a 1c                	push   $0x1c
     c34:	e8 02 fc ff ff       	call   83b <malloc>
     c39:	83 c4 10             	add    $0x10,%esp
     c3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c42:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c49:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c4c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c4f:	6a 0c                	push   $0xc
     c51:	6a 0c                	push   $0xc
     c53:	6a 0c                	push   $0xc
     c55:	50                   	push   %eax
     c56:	e8 c3 fc ff ff       	call   91e <RGB>
     c5b:	83 c4 0c             	add    $0xc,%esp
     c5e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c62:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c66:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c6a:	88 43 15             	mov    %al,0x15(%ebx)
     c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c70:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c73:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c77:	66 89 48 10          	mov    %cx,0x10(%eax)
     c7b:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c7f:	88 50 12             	mov    %dl,0x12(%eax)
     c82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c85:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c88:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c8c:	66 89 48 08          	mov    %cx,0x8(%eax)
     c90:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c94:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c97:	8b 45 08             	mov    0x8(%ebp),%eax
     c9a:	89 c2                	mov    %eax,%edx
     c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c9f:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ca1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca4:	89 c2                	mov    %eax,%edx
     ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca9:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     cac:	8b 55 10             	mov    0x10(%ebp),%edx
     caf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb2:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     cb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     cb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cbb:	c9                   	leave  
     cbc:	c3                   	ret    

00000cbd <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     cbd:	55                   	push   %ebp
     cbe:	89 e5                	mov    %esp,%ebp
     cc0:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     cc3:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc6:	8b 50 08             	mov    0x8(%eax),%edx
     cc9:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ccc:	8b 40 0c             	mov    0xc(%eax),%eax
     ccf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     cd2:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd5:	8b 55 10             	mov    0x10(%ebp),%edx
     cd8:	89 50 08             	mov    %edx,0x8(%eax)
     cdb:	8b 55 14             	mov    0x14(%ebp),%edx
     cde:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     ce1:	8b 45 08             	mov    0x8(%ebp),%eax
     ce4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ce7:	89 10                	mov    %edx,(%eax)
     ce9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     cec:	89 50 04             	mov    %edx,0x4(%eax)
}
     cef:	8b 45 08             	mov    0x8(%ebp),%eax
     cf2:	c9                   	leave  
     cf3:	c2 04 00             	ret    $0x4

00000cf6 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     cf6:	55                   	push   %ebp
     cf7:	89 e5                	mov    %esp,%ebp
     cf9:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
     cff:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     d03:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d07:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     d0b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     d0e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d11:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d15:	66 89 50 10          	mov    %dx,0x10(%eax)
     d19:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d1d:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d20:	8b 45 08             	mov    0x8(%ebp),%eax
     d23:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d27:	66 89 10             	mov    %dx,(%eax)
     d2a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d2e:	88 50 02             	mov    %dl,0x2(%eax)
}
     d31:	8b 45 08             	mov    0x8(%ebp),%eax
     d34:	c9                   	leave  
     d35:	c2 04 00             	ret    $0x4

00000d38 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     d38:	55                   	push   %ebp
     d39:	89 e5                	mov    %esp,%ebp
     d3b:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     d3e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d41:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     d45:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d49:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     d4d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     d50:	8b 45 0c             	mov    0xc(%ebp),%eax
     d53:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d57:	66 89 50 13          	mov    %dx,0x13(%eax)
     d5b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d5f:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     d62:	8b 45 08             	mov    0x8(%ebp),%eax
     d65:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d69:	66 89 10             	mov    %dx,(%eax)
     d6c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d70:	88 50 02             	mov    %dl,0x2(%eax)
}
     d73:	8b 45 08             	mov    0x8(%ebp),%eax
     d76:	c9                   	leave  
     d77:	c2 04 00             	ret    $0x4

00000d7a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d7a:	55                   	push   %ebp
     d7b:	89 e5                	mov    %esp,%ebp
     d7d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d80:	8b 45 08             	mov    0x8(%ebp),%eax
     d83:	8b 40 0c             	mov    0xc(%eax),%eax
     d86:	89 c2                	mov    %eax,%edx
     d88:	c1 ea 1f             	shr    $0x1f,%edx
     d8b:	01 d0                	add    %edx,%eax
     d8d:	d1 f8                	sar    %eax
     d8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d95:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d99:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d9c:	8b 45 10             	mov    0x10(%ebp),%eax
     d9f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     da2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     da5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     da9:	0f 89 98 00 00 00    	jns    e47 <APDrawPoint+0xcd>
        i = 0;
     daf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     db6:	e9 8c 00 00 00       	jmp    e47 <APDrawPoint+0xcd>
    {
        j = x - off;
     dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbe:	2b 45 f4             	sub    -0xc(%ebp),%eax
     dc1:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     dc4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     dc8:	79 69                	jns    e33 <APDrawPoint+0xb9>
            j = 0;
     dca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     dd1:	eb 60                	jmp    e33 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     dd3:	ff 75 fc             	pushl  -0x4(%ebp)
     dd6:	ff 75 f8             	pushl  -0x8(%ebp)
     dd9:	ff 75 08             	pushl  0x8(%ebp)
     ddc:	e8 bb fb ff ff       	call   99c <APGetIndex>
     de1:	83 c4 0c             	add    $0xc,%esp
     de4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     de7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     deb:	74 55                	je     e42 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ded:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     df1:	74 67                	je     e5a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     df3:	ff 75 10             	pushl  0x10(%ebp)
     df6:	ff 75 0c             	pushl  0xc(%ebp)
     df9:	ff 75 fc             	pushl  -0x4(%ebp)
     dfc:	ff 75 f8             	pushl  -0x8(%ebp)
     dff:	e8 5f fb ff ff       	call   963 <distance_2>
     e04:	83 c4 10             	add    $0x10,%esp
     e07:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e0a:	7f 23                	jg     e2f <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     e0c:	8b 45 08             	mov    0x8(%ebp),%eax
     e0f:	8b 48 18             	mov    0x18(%eax),%ecx
     e12:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e15:	89 d0                	mov    %edx,%eax
     e17:	01 c0                	add    %eax,%eax
     e19:	01 d0                	add    %edx,%eax
     e1b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e1e:	8b 45 08             	mov    0x8(%ebp),%eax
     e21:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e25:	66 89 0a             	mov    %cx,(%edx)
     e28:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e2c:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e2f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e33:	8b 55 0c             	mov    0xc(%ebp),%edx
     e36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e39:	01 d0                	add    %edx,%eax
     e3b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e3e:	7d 93                	jge    dd3 <APDrawPoint+0x59>
     e40:	eb 01                	jmp    e43 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e42:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e43:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e47:	8b 55 10             	mov    0x10(%ebp),%edx
     e4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4d:	01 d0                	add    %edx,%eax
     e4f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e52:	0f 8d 63 ff ff ff    	jge    dbb <APDrawPoint+0x41>
     e58:	eb 01                	jmp    e5b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e5a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e5b:	c9                   	leave  
     e5c:	c3                   	ret    

00000e5d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e5d:	55                   	push   %ebp
     e5e:	89 e5                	mov    %esp,%ebp
     e60:	53                   	push   %ebx
     e61:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e64:	8b 45 0c             	mov    0xc(%ebp),%eax
     e67:	3b 45 14             	cmp    0x14(%ebp),%eax
     e6a:	0f 85 80 00 00 00    	jne    ef0 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e74:	0f 88 9d 02 00 00    	js     1117 <APDrawLine+0x2ba>
     e7a:	8b 45 08             	mov    0x8(%ebp),%eax
     e7d:	8b 00                	mov    (%eax),%eax
     e7f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e82:	0f 8e 8f 02 00 00    	jle    1117 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e88:	8b 45 10             	mov    0x10(%ebp),%eax
     e8b:	3b 45 18             	cmp    0x18(%ebp),%eax
     e8e:	7e 12                	jle    ea2 <APDrawLine+0x45>
        {
            int tmp = y2;
     e90:	8b 45 18             	mov    0x18(%ebp),%eax
     e93:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e96:	8b 45 10             	mov    0x10(%ebp),%eax
     e99:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e9c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e9f:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     ea2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ea6:	79 07                	jns    eaf <APDrawLine+0x52>
     ea8:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     eaf:	8b 45 08             	mov    0x8(%ebp),%eax
     eb2:	8b 40 04             	mov    0x4(%eax),%eax
     eb5:	3b 45 18             	cmp    0x18(%ebp),%eax
     eb8:	7d 0c                	jge    ec6 <APDrawLine+0x69>
     eba:	8b 45 08             	mov    0x8(%ebp),%eax
     ebd:	8b 40 04             	mov    0x4(%eax),%eax
     ec0:	83 e8 01             	sub    $0x1,%eax
     ec3:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     ec6:	8b 45 10             	mov    0x10(%ebp),%eax
     ec9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ecc:	eb 15                	jmp    ee3 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     ece:	ff 75 f4             	pushl  -0xc(%ebp)
     ed1:	ff 75 0c             	pushl  0xc(%ebp)
     ed4:	ff 75 08             	pushl  0x8(%ebp)
     ed7:	e8 9e fe ff ff       	call   d7a <APDrawPoint>
     edc:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     edf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ee6:	3b 45 18             	cmp    0x18(%ebp),%eax
     ee9:	7e e3                	jle    ece <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     eeb:	e9 2b 02 00 00       	jmp    111b <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     ef0:	8b 45 10             	mov    0x10(%ebp),%eax
     ef3:	3b 45 18             	cmp    0x18(%ebp),%eax
     ef6:	75 7f                	jne    f77 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ef8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     efc:	0f 88 18 02 00 00    	js     111a <APDrawLine+0x2bd>
     f02:	8b 45 08             	mov    0x8(%ebp),%eax
     f05:	8b 40 04             	mov    0x4(%eax),%eax
     f08:	3b 45 10             	cmp    0x10(%ebp),%eax
     f0b:	0f 8e 09 02 00 00    	jle    111a <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f11:	8b 45 0c             	mov    0xc(%ebp),%eax
     f14:	3b 45 14             	cmp    0x14(%ebp),%eax
     f17:	7e 12                	jle    f2b <APDrawLine+0xce>
        {
            int tmp = x2;
     f19:	8b 45 14             	mov    0x14(%ebp),%eax
     f1c:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f1f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f22:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f25:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f28:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f2b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f2f:	79 07                	jns    f38 <APDrawLine+0xdb>
     f31:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f38:	8b 45 08             	mov    0x8(%ebp),%eax
     f3b:	8b 00                	mov    (%eax),%eax
     f3d:	3b 45 14             	cmp    0x14(%ebp),%eax
     f40:	7d 0b                	jge    f4d <APDrawLine+0xf0>
     f42:	8b 45 08             	mov    0x8(%ebp),%eax
     f45:	8b 00                	mov    (%eax),%eax
     f47:	83 e8 01             	sub    $0x1,%eax
     f4a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f50:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f53:	eb 15                	jmp    f6a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f55:	ff 75 10             	pushl  0x10(%ebp)
     f58:	ff 75 f0             	pushl  -0x10(%ebp)
     f5b:	ff 75 08             	pushl  0x8(%ebp)
     f5e:	e8 17 fe ff ff       	call   d7a <APDrawPoint>
     f63:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f66:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f6d:	3b 45 14             	cmp    0x14(%ebp),%eax
     f70:	7e e3                	jle    f55 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f72:	e9 a4 01 00 00       	jmp    111b <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f77:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f7e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f85:	8b 45 0c             	mov    0xc(%ebp),%eax
     f88:	2b 45 14             	sub    0x14(%ebp),%eax
     f8b:	50                   	push   %eax
     f8c:	e8 fb f9 ff ff       	call   98c <abs_int>
     f91:	83 c4 04             	add    $0x4,%esp
     f94:	89 c3                	mov    %eax,%ebx
     f96:	8b 45 10             	mov    0x10(%ebp),%eax
     f99:	2b 45 18             	sub    0x18(%ebp),%eax
     f9c:	50                   	push   %eax
     f9d:	e8 ea f9 ff ff       	call   98c <abs_int>
     fa2:	83 c4 04             	add    $0x4,%esp
     fa5:	39 c3                	cmp    %eax,%ebx
     fa7:	0f 8e b5 00 00 00    	jle    1062 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     fad:	8b 45 10             	mov    0x10(%ebp),%eax
     fb0:	2b 45 18             	sub    0x18(%ebp),%eax
     fb3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fb6:	db 45 b0             	fildl  -0x50(%ebp)
     fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
     fbc:	2b 45 14             	sub    0x14(%ebp),%eax
     fbf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc2:	db 45 b0             	fildl  -0x50(%ebp)
     fc5:	de f9                	fdivrp %st,%st(1)
     fc7:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     fca:	8b 45 14             	mov    0x14(%ebp),%eax
     fcd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     fd0:	7e 0e                	jle    fe0 <APDrawLine+0x183>
        {
            s = x1;
     fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     fd8:	8b 45 14             	mov    0x14(%ebp),%eax
     fdb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fde:	eb 0c                	jmp    fec <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     fe0:	8b 45 14             	mov    0x14(%ebp),%eax
     fe3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     fec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ff0:	79 07                	jns    ff9 <APDrawLine+0x19c>
     ff2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     ff9:	8b 45 08             	mov    0x8(%ebp),%eax
     ffc:	8b 00                	mov    (%eax),%eax
     ffe:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1001:	7f 0b                	jg     100e <APDrawLine+0x1b1>
    1003:	8b 45 08             	mov    0x8(%ebp),%eax
    1006:	8b 00                	mov    (%eax),%eax
    1008:	83 e8 01             	sub    $0x1,%eax
    100b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    100e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1011:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1014:	eb 3f                	jmp    1055 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1019:	2b 45 0c             	sub    0xc(%ebp),%eax
    101c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    101f:	db 45 b0             	fildl  -0x50(%ebp)
    1022:	dc 4d d0             	fmull  -0x30(%ebp)
    1025:	db 45 10             	fildl  0x10(%ebp)
    1028:	de c1                	faddp  %st,%st(1)
    102a:	d9 7d b6             	fnstcw -0x4a(%ebp)
    102d:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1031:	b4 0c                	mov    $0xc,%ah
    1033:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1037:	d9 6d b4             	fldcw  -0x4c(%ebp)
    103a:	db 5d cc             	fistpl -0x34(%ebp)
    103d:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1040:	ff 75 cc             	pushl  -0x34(%ebp)
    1043:	ff 75 e4             	pushl  -0x1c(%ebp)
    1046:	ff 75 08             	pushl  0x8(%ebp)
    1049:	e8 2c fd ff ff       	call   d7a <APDrawPoint>
    104e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1051:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1055:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1058:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    105b:	7e b9                	jle    1016 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    105d:	e9 b9 00 00 00       	jmp    111b <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1062:	8b 45 0c             	mov    0xc(%ebp),%eax
    1065:	2b 45 14             	sub    0x14(%ebp),%eax
    1068:	89 45 b0             	mov    %eax,-0x50(%ebp)
    106b:	db 45 b0             	fildl  -0x50(%ebp)
    106e:	8b 45 10             	mov    0x10(%ebp),%eax
    1071:	2b 45 18             	sub    0x18(%ebp),%eax
    1074:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1077:	db 45 b0             	fildl  -0x50(%ebp)
    107a:	de f9                	fdivrp %st,%st(1)
    107c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    107f:	8b 45 10             	mov    0x10(%ebp),%eax
    1082:	3b 45 18             	cmp    0x18(%ebp),%eax
    1085:	7e 0e                	jle    1095 <APDrawLine+0x238>
    {
        s = y2;
    1087:	8b 45 18             	mov    0x18(%ebp),%eax
    108a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    108d:	8b 45 10             	mov    0x10(%ebp),%eax
    1090:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1093:	eb 0c                	jmp    10a1 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1095:	8b 45 10             	mov    0x10(%ebp),%eax
    1098:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    109b:	8b 45 18             	mov    0x18(%ebp),%eax
    109e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    10a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10a5:	79 07                	jns    10ae <APDrawLine+0x251>
    10a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	8b 40 04             	mov    0x4(%eax),%eax
    10b4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10b7:	7f 0c                	jg     10c5 <APDrawLine+0x268>
    10b9:	8b 45 08             	mov    0x8(%ebp),%eax
    10bc:	8b 40 04             	mov    0x4(%eax),%eax
    10bf:	83 e8 01             	sub    $0x1,%eax
    10c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    10c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10cb:	eb 3f                	jmp    110c <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    10cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10d0:	2b 45 10             	sub    0x10(%ebp),%eax
    10d3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10d6:	db 45 b0             	fildl  -0x50(%ebp)
    10d9:	dc 4d c0             	fmull  -0x40(%ebp)
    10dc:	db 45 0c             	fildl  0xc(%ebp)
    10df:	de c1                	faddp  %st,%st(1)
    10e1:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10e4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10e8:	b4 0c                	mov    $0xc,%ah
    10ea:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10ee:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10f1:	db 5d bc             	fistpl -0x44(%ebp)
    10f4:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10f7:	ff 75 e0             	pushl  -0x20(%ebp)
    10fa:	ff 75 bc             	pushl  -0x44(%ebp)
    10fd:	ff 75 08             	pushl  0x8(%ebp)
    1100:	e8 75 fc ff ff       	call   d7a <APDrawPoint>
    1105:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1108:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    110c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    110f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1112:	7e b9                	jle    10cd <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1114:	90                   	nop
    1115:	eb 04                	jmp    111b <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1117:	90                   	nop
    1118:	eb 01                	jmp    111b <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    111a:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    111b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    111e:	c9                   	leave  
    111f:	c3                   	ret    

00001120 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	53                   	push   %ebx
    1124:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1127:	8b 55 10             	mov    0x10(%ebp),%edx
    112a:	8b 45 18             	mov    0x18(%ebp),%eax
    112d:	01 d0                	add    %edx,%eax
    112f:	83 e8 01             	sub    $0x1,%eax
    1132:	83 ec 04             	sub    $0x4,%esp
    1135:	50                   	push   %eax
    1136:	ff 75 0c             	pushl  0xc(%ebp)
    1139:	ff 75 10             	pushl  0x10(%ebp)
    113c:	ff 75 0c             	pushl  0xc(%ebp)
    113f:	ff 75 08             	pushl  0x8(%ebp)
    1142:	e8 16 fd ff ff       	call   e5d <APDrawLine>
    1147:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    114a:	8b 55 0c             	mov    0xc(%ebp),%edx
    114d:	8b 45 14             	mov    0x14(%ebp),%eax
    1150:	01 d0                	add    %edx,%eax
    1152:	83 e8 01             	sub    $0x1,%eax
    1155:	83 ec 04             	sub    $0x4,%esp
    1158:	ff 75 10             	pushl  0x10(%ebp)
    115b:	50                   	push   %eax
    115c:	ff 75 10             	pushl  0x10(%ebp)
    115f:	ff 75 0c             	pushl  0xc(%ebp)
    1162:	ff 75 08             	pushl  0x8(%ebp)
    1165:	e8 f3 fc ff ff       	call   e5d <APDrawLine>
    116a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    116d:	8b 55 10             	mov    0x10(%ebp),%edx
    1170:	8b 45 18             	mov    0x18(%ebp),%eax
    1173:	01 d0                	add    %edx,%eax
    1175:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1178:	8b 55 0c             	mov    0xc(%ebp),%edx
    117b:	8b 45 14             	mov    0x14(%ebp),%eax
    117e:	01 d0                	add    %edx,%eax
    1180:	8d 50 ff             	lea    -0x1(%eax),%edx
    1183:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1186:	8b 45 14             	mov    0x14(%ebp),%eax
    1189:	01 d8                	add    %ebx,%eax
    118b:	83 e8 01             	sub    $0x1,%eax
    118e:	83 ec 04             	sub    $0x4,%esp
    1191:	51                   	push   %ecx
    1192:	52                   	push   %edx
    1193:	ff 75 10             	pushl  0x10(%ebp)
    1196:	50                   	push   %eax
    1197:	ff 75 08             	pushl  0x8(%ebp)
    119a:	e8 be fc ff ff       	call   e5d <APDrawLine>
    119f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    11a2:	8b 55 10             	mov    0x10(%ebp),%edx
    11a5:	8b 45 18             	mov    0x18(%ebp),%eax
    11a8:	01 d0                	add    %edx,%eax
    11aa:	8d 48 ff             	lea    -0x1(%eax),%ecx
    11ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    11b0:	8b 45 14             	mov    0x14(%ebp),%eax
    11b3:	01 d0                	add    %edx,%eax
    11b5:	8d 50 ff             	lea    -0x1(%eax),%edx
    11b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11bb:	8b 45 18             	mov    0x18(%ebp),%eax
    11be:	01 d8                	add    %ebx,%eax
    11c0:	83 e8 01             	sub    $0x1,%eax
    11c3:	83 ec 04             	sub    $0x4,%esp
    11c6:	51                   	push   %ecx
    11c7:	52                   	push   %edx
    11c8:	50                   	push   %eax
    11c9:	ff 75 0c             	pushl  0xc(%ebp)
    11cc:	ff 75 08             	pushl  0x8(%ebp)
    11cf:	e8 89 fc ff ff       	call   e5d <APDrawLine>
    11d4:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    11d7:	8b 55 0c             	mov    0xc(%ebp),%edx
    11da:	8b 45 14             	mov    0x14(%ebp),%eax
    11dd:	01 d0                	add    %edx,%eax
    11df:	8d 50 ff             	lea    -0x1(%eax),%edx
    11e2:	8b 45 08             	mov    0x8(%ebp),%eax
    11e5:	8b 40 0c             	mov    0xc(%eax),%eax
    11e8:	89 c1                	mov    %eax,%ecx
    11ea:	c1 e9 1f             	shr    $0x1f,%ecx
    11ed:	01 c8                	add    %ecx,%eax
    11ef:	d1 f8                	sar    %eax
    11f1:	29 c2                	sub    %eax,%edx
    11f3:	89 d0                	mov    %edx,%eax
    11f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11f8:	8b 55 10             	mov    0x10(%ebp),%edx
    11fb:	8b 45 18             	mov    0x18(%ebp),%eax
    11fe:	01 d0                	add    %edx,%eax
    1200:	8d 50 ff             	lea    -0x1(%eax),%edx
    1203:	8b 45 08             	mov    0x8(%ebp),%eax
    1206:	8b 40 0c             	mov    0xc(%eax),%eax
    1209:	89 c1                	mov    %eax,%ecx
    120b:	c1 e9 1f             	shr    $0x1f,%ecx
    120e:	01 c8                	add    %ecx,%eax
    1210:	d1 f8                	sar    %eax
    1212:	29 c2                	sub    %eax,%edx
    1214:	89 d0                	mov    %edx,%eax
    1216:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	8b 40 0c             	mov    0xc(%eax),%eax
    121f:	89 c2                	mov    %eax,%edx
    1221:	c1 ea 1f             	shr    $0x1f,%edx
    1224:	01 d0                	add    %edx,%eax
    1226:	d1 f8                	sar    %eax
    1228:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    122b:	8b 45 08             	mov    0x8(%ebp),%eax
    122e:	8b 40 0c             	mov    0xc(%eax),%eax
    1231:	89 c2                	mov    %eax,%edx
    1233:	c1 ea 1f             	shr    $0x1f,%edx
    1236:	01 d0                	add    %edx,%eax
    1238:	d1 f8                	sar    %eax
    123a:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    123d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1241:	0f 88 d8 00 00 00    	js     131f <APDrawRect+0x1ff>
    1247:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    124b:	0f 88 ce 00 00 00    	js     131f <APDrawRect+0x1ff>
    1251:	8b 45 08             	mov    0x8(%ebp),%eax
    1254:	8b 00                	mov    (%eax),%eax
    1256:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1259:	0f 8e c0 00 00 00    	jle    131f <APDrawRect+0x1ff>
    125f:	8b 45 08             	mov    0x8(%ebp),%eax
    1262:	8b 40 04             	mov    0x4(%eax),%eax
    1265:	3b 45 10             	cmp    0x10(%ebp),%eax
    1268:	0f 8e b1 00 00 00    	jle    131f <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    126e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1272:	79 07                	jns    127b <APDrawRect+0x15b>
    1274:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    127b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    127f:	79 07                	jns    1288 <APDrawRect+0x168>
    1281:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1288:	8b 45 08             	mov    0x8(%ebp),%eax
    128b:	8b 00                	mov    (%eax),%eax
    128d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1290:	7f 0b                	jg     129d <APDrawRect+0x17d>
    1292:	8b 45 08             	mov    0x8(%ebp),%eax
    1295:	8b 00                	mov    (%eax),%eax
    1297:	83 e8 01             	sub    $0x1,%eax
    129a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    129d:	8b 45 08             	mov    0x8(%ebp),%eax
    12a0:	8b 40 04             	mov    0x4(%eax),%eax
    12a3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12a6:	7f 0c                	jg     12b4 <APDrawRect+0x194>
    12a8:	8b 45 08             	mov    0x8(%ebp),%eax
    12ab:	8b 40 04             	mov    0x4(%eax),%eax
    12ae:	83 e8 01             	sub    $0x1,%eax
    12b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    12b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    12be:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12c1:	eb 52                	jmp    1315 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    12c3:	8b 45 10             	mov    0x10(%ebp),%eax
    12c6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    12c9:	eb 3e                	jmp    1309 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    12cb:	83 ec 04             	sub    $0x4,%esp
    12ce:	ff 75 e8             	pushl  -0x18(%ebp)
    12d1:	ff 75 ec             	pushl  -0x14(%ebp)
    12d4:	ff 75 08             	pushl  0x8(%ebp)
    12d7:	e8 c0 f6 ff ff       	call   99c <APGetIndex>
    12dc:	83 c4 10             	add    $0x10,%esp
    12df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    12e2:	8b 45 08             	mov    0x8(%ebp),%eax
    12e5:	8b 48 18             	mov    0x18(%eax),%ecx
    12e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    12eb:	89 d0                	mov    %edx,%eax
    12ed:	01 c0                	add    %eax,%eax
    12ef:	01 d0                	add    %edx,%eax
    12f1:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12f4:	8b 45 08             	mov    0x8(%ebp),%eax
    12f7:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12fb:	66 89 0a             	mov    %cx,(%edx)
    12fe:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1302:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1305:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1309:	8b 45 e8             	mov    -0x18(%ebp),%eax
    130c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    130f:	7e ba                	jle    12cb <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1311:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1315:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1318:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    131b:	7e a6                	jle    12c3 <APDrawRect+0x1a3>
    131d:	eb 01                	jmp    1320 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    131f:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1320:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1323:	c9                   	leave  
    1324:	c3                   	ret    

00001325 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1325:	55                   	push   %ebp
    1326:	89 e5                	mov    %esp,%ebp
    1328:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    132b:	83 ec 0c             	sub    $0xc,%esp
    132e:	ff 75 0c             	pushl  0xc(%ebp)
    1331:	e8 b1 ee ff ff       	call   1e7 <strlen>
    1336:	83 c4 10             	add    $0x10,%esp
    1339:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    133c:	8b 45 08             	mov    0x8(%ebp),%eax
    133f:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1343:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1347:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    134b:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    134e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1355:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    135c:	e9 bc 00 00 00       	jmp    141d <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1361:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1364:	8b 45 0c             	mov    0xc(%ebp),%eax
    1367:	01 d0                	add    %edx,%eax
    1369:	0f b6 00             	movzbl (%eax),%eax
    136c:	0f be c0             	movsbl %al,%eax
    136f:	83 e8 20             	sub    $0x20,%eax
    1372:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1375:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1379:	0f 87 9a 00 00 00    	ja     1419 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    137f:	8b 45 08             	mov    0x8(%ebp),%eax
    1382:	8b 00                	mov    (%eax),%eax
    1384:	0f af 45 14          	imul   0x14(%ebp),%eax
    1388:	89 c2                	mov    %eax,%edx
    138a:	8b 45 10             	mov    0x10(%ebp),%eax
    138d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1390:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1393:	89 d0                	mov    %edx,%eax
    1395:	c1 e0 03             	shl    $0x3,%eax
    1398:	01 d0                	add    %edx,%eax
    139a:	01 c8                	add    %ecx,%eax
    139c:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    139f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    13a6:	eb 6b                	jmp    1413 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    13a8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    13af:	eb 50                	jmp    1401 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    13b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13b4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13b7:	89 d0                	mov    %edx,%eax
    13b9:	c1 e0 03             	shl    $0x3,%eax
    13bc:	01 d0                	add    %edx,%eax
    13be:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    13c4:	01 c2                	add    %eax,%edx
    13c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13c9:	01 d0                	add    %edx,%eax
    13cb:	05 20 2e 00 00       	add    $0x2e20,%eax
    13d0:	0f b6 00             	movzbl (%eax),%eax
    13d3:	84 c0                	test   %al,%al
    13d5:	74 26                	je     13fd <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	8b 50 18             	mov    0x18(%eax),%edx
    13dd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    13e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13e3:	01 c8                	add    %ecx,%eax
    13e5:	89 c1                	mov    %eax,%ecx
    13e7:	89 c8                	mov    %ecx,%eax
    13e9:	01 c0                	add    %eax,%eax
    13eb:	01 c8                	add    %ecx,%eax
    13ed:	01 d0                	add    %edx,%eax
    13ef:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13f3:	66 89 10             	mov    %dx,(%eax)
    13f6:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13fa:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    13fd:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1401:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    1405:	7e aa                	jle    13b1 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    1407:	8b 45 08             	mov    0x8(%ebp),%eax
    140a:	8b 00                	mov    (%eax),%eax
    140c:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    140f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1413:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1417:	7e 8f                	jle    13a8 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1419:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    141d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1420:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1423:	0f 82 38 ff ff ff    	jb     1361 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1429:	90                   	nop
    142a:	c9                   	leave  
    142b:	c3                   	ret    

0000142c <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    142c:	55                   	push   %ebp
    142d:	89 e5                	mov    %esp,%ebp
    142f:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1432:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1436:	0f 88 8e 01 00 00    	js     15ca <APDcCopy+0x19e>
    143c:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1440:	0f 88 84 01 00 00    	js     15ca <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1446:	8b 55 0c             	mov    0xc(%ebp),%edx
    1449:	8b 45 20             	mov    0x20(%ebp),%eax
    144c:	01 d0                	add    %edx,%eax
    144e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1451:	8b 55 10             	mov    0x10(%ebp),%edx
    1454:	8b 45 24             	mov    0x24(%ebp),%eax
    1457:	01 d0                	add    %edx,%eax
    1459:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    145c:	8b 55 18             	mov    0x18(%ebp),%edx
    145f:	8b 45 20             	mov    0x20(%ebp),%eax
    1462:	01 d0                	add    %edx,%eax
    1464:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1467:	8b 55 1c             	mov    0x1c(%ebp),%edx
    146a:	8b 45 24             	mov    0x24(%ebp),%eax
    146d:	01 d0                	add    %edx,%eax
    146f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1472:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1476:	0f 88 51 01 00 00    	js     15cd <APDcCopy+0x1a1>
    147c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1480:	0f 88 47 01 00 00    	js     15cd <APDcCopy+0x1a1>
    1486:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    148a:	0f 88 3d 01 00 00    	js     15cd <APDcCopy+0x1a1>
    1490:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1494:	0f 88 33 01 00 00    	js     15cd <APDcCopy+0x1a1>
    149a:	8b 45 14             	mov    0x14(%ebp),%eax
    149d:	8b 00                	mov    (%eax),%eax
    149f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    14a2:	0f 8c 25 01 00 00    	jl     15cd <APDcCopy+0x1a1>
    14a8:	8b 45 14             	mov    0x14(%ebp),%eax
    14ab:	8b 40 04             	mov    0x4(%eax),%eax
    14ae:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    14b1:	0f 8c 16 01 00 00    	jl     15cd <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    14b7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ba:	8b 00                	mov    (%eax),%eax
    14bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14bf:	7f 0b                	jg     14cc <APDcCopy+0xa0>
    14c1:	8b 45 08             	mov    0x8(%ebp),%eax
    14c4:	8b 00                	mov    (%eax),%eax
    14c6:	83 e8 01             	sub    $0x1,%eax
    14c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    14cc:	8b 45 08             	mov    0x8(%ebp),%eax
    14cf:	8b 40 04             	mov    0x4(%eax),%eax
    14d2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14d5:	7f 0c                	jg     14e3 <APDcCopy+0xb7>
    14d7:	8b 45 08             	mov    0x8(%ebp),%eax
    14da:	8b 40 04             	mov    0x4(%eax),%eax
    14dd:	83 e8 01             	sub    $0x1,%eax
    14e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    14e3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    14ea:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    14f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14f8:	e9 bc 00 00 00       	jmp    15b9 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1500:	8b 00                	mov    (%eax),%eax
    1502:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1505:	8b 55 10             	mov    0x10(%ebp),%edx
    1508:	01 ca                	add    %ecx,%edx
    150a:	0f af d0             	imul   %eax,%edx
    150d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1510:	01 d0                	add    %edx,%eax
    1512:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1515:	8b 45 14             	mov    0x14(%ebp),%eax
    1518:	8b 00                	mov    (%eax),%eax
    151a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    151d:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1520:	01 ca                	add    %ecx,%edx
    1522:	0f af d0             	imul   %eax,%edx
    1525:	8b 45 18             	mov    0x18(%ebp),%eax
    1528:	01 d0                	add    %edx,%eax
    152a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    152d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1534:	eb 74                	jmp    15aa <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1536:	8b 45 14             	mov    0x14(%ebp),%eax
    1539:	8b 50 18             	mov    0x18(%eax),%edx
    153c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    153f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1542:	01 c8                	add    %ecx,%eax
    1544:	89 c1                	mov    %eax,%ecx
    1546:	89 c8                	mov    %ecx,%eax
    1548:	01 c0                	add    %eax,%eax
    154a:	01 c8                	add    %ecx,%eax
    154c:	01 d0                	add    %edx,%eax
    154e:	0f b7 10             	movzwl (%eax),%edx
    1551:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1555:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1559:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    155c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1560:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1564:	38 c2                	cmp    %al,%dl
    1566:	75 18                	jne    1580 <APDcCopy+0x154>
    1568:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    156c:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1570:	38 c2                	cmp    %al,%dl
    1572:	75 0c                	jne    1580 <APDcCopy+0x154>
    1574:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1578:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    157c:	38 c2                	cmp    %al,%dl
    157e:	74 26                	je     15a6 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1580:	8b 45 08             	mov    0x8(%ebp),%eax
    1583:	8b 50 18             	mov    0x18(%eax),%edx
    1586:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1589:	8b 45 f0             	mov    -0x10(%ebp),%eax
    158c:	01 c8                	add    %ecx,%eax
    158e:	89 c1                	mov    %eax,%ecx
    1590:	89 c8                	mov    %ecx,%eax
    1592:	01 c0                	add    %eax,%eax
    1594:	01 c8                	add    %ecx,%eax
    1596:	01 d0                	add    %edx,%eax
    1598:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    159c:	66 89 10             	mov    %dx,(%eax)
    159f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15a3:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    15a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    15aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15ad:	2b 45 0c             	sub    0xc(%ebp),%eax
    15b0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    15b3:	7d 81                	jge    1536 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    15b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    15b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15bc:	2b 45 10             	sub    0x10(%ebp),%eax
    15bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    15c2:	0f 8d 35 ff ff ff    	jge    14fd <APDcCopy+0xd1>
    15c8:	eb 04                	jmp    15ce <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    15ca:	90                   	nop
    15cb:	eb 01                	jmp    15ce <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    15cd:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    15ce:	c9                   	leave  
    15cf:	c3                   	ret    

000015d0 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	83 ec 1c             	sub    $0x1c,%esp
    15d6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    15d9:	8b 55 10             	mov    0x10(%ebp),%edx
    15dc:	8b 45 14             	mov    0x14(%ebp),%eax
    15df:	88 4d ec             	mov    %cl,-0x14(%ebp)
    15e2:	88 55 e8             	mov    %dl,-0x18(%ebp)
    15e5:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    15e8:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    15ec:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    15ef:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15f3:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15f6:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15fa:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1600:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1604:	66 89 10             	mov    %dx,(%eax)
    1607:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    160b:	88 50 02             	mov    %dl,0x2(%eax)
}
    160e:	8b 45 08             	mov    0x8(%ebp),%eax
    1611:	c9                   	leave  
    1612:	c2 04 00             	ret    $0x4

00001615 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1615:	55                   	push   %ebp
    1616:	89 e5                	mov    %esp,%ebp
    1618:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    161b:	8b 45 08             	mov    0x8(%ebp),%eax
    161e:	8b 00                	mov    (%eax),%eax
    1620:	83 ec 08             	sub    $0x8,%esp
    1623:	8d 55 0c             	lea    0xc(%ebp),%edx
    1626:	52                   	push   %edx
    1627:	50                   	push   %eax
    1628:	e8 24 ee ff ff       	call   451 <sendMessage>
    162d:	83 c4 10             	add    $0x10,%esp
}
    1630:	90                   	nop
    1631:	c9                   	leave  
    1632:	c3                   	ret    

00001633 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1633:	55                   	push   %ebp
    1634:	89 e5                	mov    %esp,%ebp
    1636:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1639:	83 ec 0c             	sub    $0xc,%esp
    163c:	68 9c 00 00 00       	push   $0x9c
    1641:	e8 f5 f1 ff ff       	call   83b <malloc>
    1646:	83 c4 10             	add    $0x10,%esp
    1649:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    164c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1650:	75 15                	jne    1667 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1652:	83 ec 04             	sub    $0x4,%esp
    1655:	ff 75 08             	pushl  0x8(%ebp)
    1658:	68 d8 26 00 00       	push   $0x26d8
    165d:	6a 01                	push   $0x1
    165f:	e8 04 ef ff ff       	call   568 <printf>
    1664:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1667:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166a:	05 88 00 00 00       	add    $0x88,%eax
    166f:	83 ec 08             	sub    $0x8,%esp
    1672:	ff 75 08             	pushl  0x8(%ebp)
    1675:	50                   	push   %eax
    1676:	e8 fd ea ff ff       	call   178 <strcpy>
    167b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    167e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1681:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1688:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168b:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1692:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1695:	8b 40 3c             	mov    0x3c(%eax),%eax
    1698:	89 c2                	mov    %eax,%edx
    169a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169d:	8b 40 40             	mov    0x40(%eax),%eax
    16a0:	0f af d0             	imul   %eax,%edx
    16a3:	89 d0                	mov    %edx,%eax
    16a5:	01 c0                	add    %eax,%eax
    16a7:	01 d0                	add    %edx,%eax
    16a9:	83 ec 0c             	sub    $0xc,%esp
    16ac:	50                   	push   %eax
    16ad:	e8 89 f1 ff ff       	call   83b <malloc>
    16b2:	83 c4 10             	add    $0x10,%esp
    16b5:	89 c2                	mov    %eax,%edx
    16b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ba:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    16bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c0:	8b 40 54             	mov    0x54(%eax),%eax
    16c3:	85 c0                	test   %eax,%eax
    16c5:	75 15                	jne    16dc <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    16c7:	83 ec 04             	sub    $0x4,%esp
    16ca:	ff 75 08             	pushl  0x8(%ebp)
    16cd:	68 f8 26 00 00       	push   $0x26f8
    16d2:	6a 01                	push   $0x1
    16d4:	e8 8f ee ff ff       	call   568 <printf>
    16d9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16df:	8b 40 3c             	mov    0x3c(%eax),%eax
    16e2:	89 c2                	mov    %eax,%edx
    16e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e7:	8b 40 40             	mov    0x40(%eax),%eax
    16ea:	0f af d0             	imul   %eax,%edx
    16ed:	89 d0                	mov    %edx,%eax
    16ef:	01 c0                	add    %eax,%eax
    16f1:	01 c2                	add    %eax,%edx
    16f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f6:	8b 40 54             	mov    0x54(%eax),%eax
    16f9:	83 ec 04             	sub    $0x4,%esp
    16fc:	52                   	push   %edx
    16fd:	68 ff ff ff 00       	push   $0xffffff
    1702:	50                   	push   %eax
    1703:	e8 06 eb ff ff       	call   20e <memset>
    1708:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    170b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170e:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1715:	e8 0f ed ff ff       	call   429 <getpid>
    171a:	89 c2                	mov    %eax,%edx
    171c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171f:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1722:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1725:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    172c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172f:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1736:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1739:	8b 40 58             	mov    0x58(%eax),%eax
    173c:	89 c2                	mov    %eax,%edx
    173e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1741:	8b 40 5c             	mov    0x5c(%eax),%eax
    1744:	0f af d0             	imul   %eax,%edx
    1747:	89 d0                	mov    %edx,%eax
    1749:	01 c0                	add    %eax,%eax
    174b:	01 d0                	add    %edx,%eax
    174d:	83 ec 0c             	sub    $0xc,%esp
    1750:	50                   	push   %eax
    1751:	e8 e5 f0 ff ff       	call   83b <malloc>
    1756:	83 c4 10             	add    $0x10,%esp
    1759:	89 c2                	mov    %eax,%edx
    175b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175e:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1761:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1764:	8b 40 70             	mov    0x70(%eax),%eax
    1767:	85 c0                	test   %eax,%eax
    1769:	75 15                	jne    1780 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    176b:	83 ec 04             	sub    $0x4,%esp
    176e:	ff 75 08             	pushl  0x8(%ebp)
    1771:	68 1c 27 00 00       	push   $0x271c
    1776:	6a 01                	push   $0x1
    1778:	e8 eb ed ff ff       	call   568 <printf>
    177d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1780:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1783:	8b 40 3c             	mov    0x3c(%eax),%eax
    1786:	89 c2                	mov    %eax,%edx
    1788:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178b:	8b 40 40             	mov    0x40(%eax),%eax
    178e:	0f af d0             	imul   %eax,%edx
    1791:	89 d0                	mov    %edx,%eax
    1793:	01 c0                	add    %eax,%eax
    1795:	01 c2                	add    %eax,%edx
    1797:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179a:	8b 40 54             	mov    0x54(%eax),%eax
    179d:	83 ec 04             	sub    $0x4,%esp
    17a0:	52                   	push   %edx
    17a1:	68 ff 00 00 00       	push   $0xff
    17a6:	50                   	push   %eax
    17a7:	e8 62 ea ff ff       	call   20e <memset>
    17ac:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    17af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b2:	8b 55 0c             	mov    0xc(%ebp),%edx
    17b5:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    17b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    17bc:	74 49                	je     1807 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    17be:	8b 45 10             	mov    0x10(%ebp),%eax
    17c1:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    17c7:	83 ec 0c             	sub    $0xc,%esp
    17ca:	50                   	push   %eax
    17cb:	e8 6b f0 ff ff       	call   83b <malloc>
    17d0:	83 c4 10             	add    $0x10,%esp
    17d3:	89 c2                	mov    %eax,%edx
    17d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d8:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    17db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17de:	8b 55 10             	mov    0x10(%ebp),%edx
    17e1:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    17e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    17ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f1:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    17f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1802:	e9 8d 00 00 00       	jmp    1894 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1807:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180a:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1811:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1814:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    181b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181e:	8b 40 20             	mov    0x20(%eax),%eax
    1821:	89 c2                	mov    %eax,%edx
    1823:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1826:	8b 40 24             	mov    0x24(%eax),%eax
    1829:	0f af d0             	imul   %eax,%edx
    182c:	89 d0                	mov    %edx,%eax
    182e:	01 c0                	add    %eax,%eax
    1830:	01 d0                	add    %edx,%eax
    1832:	83 ec 0c             	sub    $0xc,%esp
    1835:	50                   	push   %eax
    1836:	e8 00 f0 ff ff       	call   83b <malloc>
    183b:	83 c4 10             	add    $0x10,%esp
    183e:	89 c2                	mov    %eax,%edx
    1840:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1843:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1846:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1849:	8b 40 38             	mov    0x38(%eax),%eax
    184c:	85 c0                	test   %eax,%eax
    184e:	75 15                	jne    1865 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1850:	83 ec 04             	sub    $0x4,%esp
    1853:	ff 75 08             	pushl  0x8(%ebp)
    1856:	68 44 27 00 00       	push   $0x2744
    185b:	6a 01                	push   $0x1
    185d:	e8 06 ed ff ff       	call   568 <printf>
    1862:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1865:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1868:	8b 40 20             	mov    0x20(%eax),%eax
    186b:	89 c2                	mov    %eax,%edx
    186d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1870:	8b 40 24             	mov    0x24(%eax),%eax
    1873:	0f af d0             	imul   %eax,%edx
    1876:	89 d0                	mov    %edx,%eax
    1878:	01 c0                	add    %eax,%eax
    187a:	01 c2                	add    %eax,%edx
    187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187f:	8b 40 38             	mov    0x38(%eax),%eax
    1882:	83 ec 04             	sub    $0x4,%esp
    1885:	52                   	push   %edx
    1886:	68 ff ff ff 00       	push   $0xffffff
    188b:	50                   	push   %eax
    188c:	e8 7d e9 ff ff       	call   20e <memset>
    1891:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1894:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1897:	c9                   	leave  
    1898:	c3                   	ret    

00001899 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1899:	55                   	push   %ebp
    189a:	89 e5                	mov    %esp,%ebp
    189c:	57                   	push   %edi
    189d:	56                   	push   %esi
    189e:	53                   	push   %ebx
    189f:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    18a2:	8b 45 0c             	mov    0xc(%ebp),%eax
    18a5:	83 f8 03             	cmp    $0x3,%eax
    18a8:	74 0e                	je     18b8 <APWndProc+0x1f>
    18aa:	83 f8 0a             	cmp    $0xa,%eax
    18ad:	0f 84 82 00 00 00    	je     1935 <APWndProc+0x9c>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            break;
        default: break;
    18b3:	e9 cb 00 00 00       	jmp    1983 <APWndProc+0xea>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    18b8:	8b 45 08             	mov    0x8(%ebp),%eax
    18bb:	8b 58 1c             	mov    0x1c(%eax),%ebx
    18be:	8b 45 08             	mov    0x8(%ebp),%eax
    18c1:	8b 48 18             	mov    0x18(%eax),%ecx
    18c4:	8b 45 08             	mov    0x8(%ebp),%eax
    18c7:	8b 50 5c             	mov    0x5c(%eax),%edx
    18ca:	8b 45 08             	mov    0x8(%ebp),%eax
    18cd:	8b 40 58             	mov    0x58(%eax),%eax
    18d0:	8b 75 08             	mov    0x8(%ebp),%esi
    18d3:	83 c6 58             	add    $0x58,%esi
    18d6:	83 ec 04             	sub    $0x4,%esp
    18d9:	53                   	push   %ebx
    18da:	51                   	push   %ecx
    18db:	6a 00                	push   $0x0
    18dd:	52                   	push   %edx
    18de:	50                   	push   %eax
    18df:	6a 00                	push   $0x0
    18e1:	6a 00                	push   $0x0
    18e3:	56                   	push   %esi
    18e4:	6a 00                	push   $0x0
    18e6:	6a 00                	push   $0x0
    18e8:	ff 75 08             	pushl  0x8(%ebp)
    18eb:	e8 59 eb ff ff       	call   449 <paintWindow>
    18f0:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    18f3:	8b 45 08             	mov    0x8(%ebp),%eax
    18f6:	8b 70 1c             	mov    0x1c(%eax),%esi
    18f9:	8b 45 08             	mov    0x8(%ebp),%eax
    18fc:	8b 58 18             	mov    0x18(%eax),%ebx
    18ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1902:	8b 48 08             	mov    0x8(%eax),%ecx
    1905:	8b 45 08             	mov    0x8(%ebp),%eax
    1908:	8b 50 40             	mov    0x40(%eax),%edx
    190b:	8b 45 08             	mov    0x8(%ebp),%eax
    190e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1911:	8b 7d 08             	mov    0x8(%ebp),%edi
    1914:	83 c7 3c             	add    $0x3c,%edi
    1917:	83 ec 04             	sub    $0x4,%esp
    191a:	56                   	push   %esi
    191b:	53                   	push   %ebx
    191c:	51                   	push   %ecx
    191d:	52                   	push   %edx
    191e:	50                   	push   %eax
    191f:	6a 00                	push   $0x0
    1921:	6a 00                	push   $0x0
    1923:	57                   	push   %edi
    1924:	6a 32                	push   $0x32
    1926:	6a 00                	push   $0x0
    1928:	ff 75 08             	pushl  0x8(%ebp)
    192b:	e8 19 eb ff ff       	call   449 <paintWindow>
    1930:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1933:	eb 4e                	jmp    1983 <APWndProc+0xea>
        case MSG_WORD:
            //printf(1,"in MSG_WORD, word is %s",msg.word);
            updateword(hwnd,msg.word);
    1935:	8b 45 18             	mov    0x18(%ebp),%eax
    1938:	83 ec 08             	sub    $0x8,%esp
    193b:	50                   	push   %eax
    193c:	ff 75 08             	pushl  0x8(%ebp)
    193f:	e8 c5 08 00 00       	call   2209 <updateword>
    1944:	83 c4 10             	add    $0x10,%esp
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1947:	8b 45 08             	mov    0x8(%ebp),%eax
    194a:	8b 58 1c             	mov    0x1c(%eax),%ebx
    194d:	8b 45 08             	mov    0x8(%ebp),%eax
    1950:	8b 48 18             	mov    0x18(%eax),%ecx
    1953:	8b 45 08             	mov    0x8(%ebp),%eax
    1956:	8b 50 5c             	mov    0x5c(%eax),%edx
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
    195c:	8b 40 58             	mov    0x58(%eax),%eax
    195f:	8b 75 08             	mov    0x8(%ebp),%esi
    1962:	83 c6 58             	add    $0x58,%esi
    1965:	83 ec 04             	sub    $0x4,%esp
    1968:	53                   	push   %ebx
    1969:	51                   	push   %ecx
    196a:	6a 00                	push   $0x0
    196c:	52                   	push   %edx
    196d:	50                   	push   %eax
    196e:	6a 00                	push   $0x0
    1970:	6a 00                	push   $0x0
    1972:	56                   	push   %esi
    1973:	6a 00                	push   $0x0
    1975:	6a 00                	push   $0x0
    1977:	ff 75 08             	pushl  0x8(%ebp)
    197a:	e8 ca ea ff ff       	call   449 <paintWindow>
    197f:	83 c4 30             	add    $0x30,%esp
            break;
    1982:	90                   	nop
        default: break;
            
            
    }
    return False;
    1983:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1988:	8d 65 f4             	lea    -0xc(%ebp),%esp
    198b:	5b                   	pop    %ebx
    198c:	5e                   	pop    %esi
    198d:	5f                   	pop    %edi
    198e:	5d                   	pop    %ebp
    198f:	c3                   	ret    

00001990 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1990:	55                   	push   %ebp
    1991:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1993:	8b 45 0c             	mov    0xc(%ebp),%eax
    1996:	8b 50 08             	mov    0x8(%eax),%edx
    1999:	8b 45 08             	mov    0x8(%ebp),%eax
    199c:	8b 00                	mov    (%eax),%eax
    199e:	39 c2                	cmp    %eax,%edx
    19a0:	74 07                	je     19a9 <APPreJudge+0x19>
        return False;
    19a2:	b8 00 00 00 00       	mov    $0x0,%eax
    19a7:	eb 05                	jmp    19ae <APPreJudge+0x1e>
    return True;
    19a9:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19ae:	5d                   	pop    %ebp
    19af:	c3                   	ret    

000019b0 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19b0:	55                   	push   %ebp
    19b1:	89 e5                	mov    %esp,%ebp
    19b3:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19b6:	8b 45 08             	mov    0x8(%ebp),%eax
    19b9:	8b 55 0c             	mov    0xc(%ebp),%edx
    19bc:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    //--------add window to list
    registWindow(hwnd);
    19c2:	83 ec 0c             	sub    $0xc,%esp
    19c5:	ff 75 08             	pushl  0x8(%ebp)
    19c8:	e8 94 ea ff ff       	call   461 <registWindow>
    19cd:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19d0:	c7 45 e8 02 00 00 00 	movl   $0x2,-0x18(%ebp)
    msg.wndID = hwnd->id;
    19d7:	8b 45 08             	mov    0x8(%ebp),%eax
    19da:	8b 00                	mov    (%eax),%eax
    19dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    APSendMessage(hwnd,msg);
    19df:	83 ec 0c             	sub    $0xc,%esp
    19e2:	ff 75 f4             	pushl  -0xc(%ebp)
    19e5:	ff 75 f0             	pushl  -0x10(%ebp)
    19e8:	ff 75 ec             	pushl  -0x14(%ebp)
    19eb:	ff 75 e8             	pushl  -0x18(%ebp)
    19ee:	ff 75 08             	pushl  0x8(%ebp)
    19f1:	e8 1f fc ff ff       	call   1615 <APSendMessage>
    19f6:	83 c4 20             	add    $0x20,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19f9:	83 ec 0c             	sub    $0xc,%esp
    19fc:	ff 75 08             	pushl  0x8(%ebp)
    19ff:	e8 55 ea ff ff       	call   459 <getMessage>
    1a04:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a07:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0a:	83 c0 74             	add    $0x74,%eax
    1a0d:	83 ec 08             	sub    $0x8,%esp
    1a10:	50                   	push   %eax
    1a11:	ff 75 08             	pushl  0x8(%ebp)
    1a14:	e8 77 ff ff ff       	call   1990 <APPreJudge>
    1a19:	83 c4 10             	add    $0x10,%esp
    1a1c:	84 c0                	test   %al,%al
    1a1e:	74 24                	je     1a44 <APWndExec+0x94>
            if (wndProc(hwnd, hwnd->msg))
    1a20:	83 ec 0c             	sub    $0xc,%esp
    1a23:	8b 45 08             	mov    0x8(%ebp),%eax
    1a26:	ff b0 80 00 00 00    	pushl  0x80(%eax)
    1a2c:	ff 70 7c             	pushl  0x7c(%eax)
    1a2f:	ff 70 78             	pushl  0x78(%eax)
    1a32:	ff 70 74             	pushl  0x74(%eax)
    1a35:	ff 75 08             	pushl  0x8(%ebp)
    1a38:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a3b:	ff d0                	call   *%eax
    1a3d:	83 c4 20             	add    $0x20,%esp
    1a40:	84 c0                	test   %al,%al
    1a42:	75 0c                	jne    1a50 <APWndExec+0xa0>
                break;
        hwnd->msg.type = MSG_NULL;
    1a44:	8b 45 08             	mov    0x8(%ebp),%eax
    1a47:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a4e:	eb a9                	jmp    19f9 <APWndExec+0x49>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a50:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a51:	90                   	nop
    1a52:	c9                   	leave  
    1a53:	c3                   	ret    

00001a54 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a54:	55                   	push   %ebp
    1a55:	89 e5                	mov    %esp,%ebp
    1a57:	57                   	push   %edi
    1a58:	56                   	push   %esi
    1a59:	53                   	push   %ebx
    1a5a:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a5d:	a1 64 6a 00 00       	mov    0x6a64,%eax
    1a62:	85 c0                	test   %eax,%eax
    1a64:	0f 85 c8 02 00 00    	jne    1d32 <APGridPaint+0x2de>
    {
        iconReady = 1;
    1a6a:	c7 05 64 6a 00 00 01 	movl   $0x1,0x6a64
    1a71:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a74:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a77:	83 ec 08             	sub    $0x8,%esp
    1a7a:	68 6b 27 00 00       	push   $0x276b
    1a7f:	50                   	push   %eax
    1a80:	e8 69 ef ff ff       	call   9ee <APLoadBitmap>
    1a85:	83 c4 0c             	add    $0xc,%esp
    1a88:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a8b:	a3 94 6a 00 00       	mov    %eax,0x6a94
    1a90:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a93:	a3 98 6a 00 00       	mov    %eax,0x6a98
    1a98:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a9b:	a3 9c 6a 00 00       	mov    %eax,0x6a9c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1aa0:	83 ec 04             	sub    $0x4,%esp
    1aa3:	ff 35 9c 6a 00 00    	pushl  0x6a9c
    1aa9:	ff 35 98 6a 00 00    	pushl  0x6a98
    1aaf:	ff 35 94 6a 00 00    	pushl  0x6a94
    1ab5:	e8 6e f1 ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1aba:	83 c4 10             	add    $0x10,%esp
    1abd:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
        grid_river = APLoadBitmap ("grid_river.bmp");
    1ac2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ac5:	83 ec 08             	sub    $0x8,%esp
    1ac8:	68 79 27 00 00       	push   $0x2779
    1acd:	50                   	push   %eax
    1ace:	e8 1b ef ff ff       	call   9ee <APLoadBitmap>
    1ad3:	83 c4 0c             	add    $0xc,%esp
    1ad6:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ad9:	a3 e0 6a 00 00       	mov    %eax,0x6ae0
    1ade:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ae1:	a3 e4 6a 00 00       	mov    %eax,0x6ae4
    1ae6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ae9:	a3 e8 6a 00 00       	mov    %eax,0x6ae8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1aee:	83 ec 04             	sub    $0x4,%esp
    1af1:	ff 35 e8 6a 00 00    	pushl  0x6ae8
    1af7:	ff 35 e4 6a 00 00    	pushl  0x6ae4
    1afd:	ff 35 e0 6a 00 00    	pushl  0x6ae0
    1b03:	e8 20 f1 ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1b08:	83 c4 10             	add    $0x10,%esp
    1b0b:	a3 d0 6a 00 00       	mov    %eax,0x6ad0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b10:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b13:	83 ec 08             	sub    $0x8,%esp
    1b16:	68 88 27 00 00       	push   $0x2788
    1b1b:	50                   	push   %eax
    1b1c:	e8 cd ee ff ff       	call   9ee <APLoadBitmap>
    1b21:	83 c4 0c             	add    $0xc,%esp
    1b24:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b27:	a3 d4 6a 00 00       	mov    %eax,0x6ad4
    1b2c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b2f:	a3 d8 6a 00 00       	mov    %eax,0x6ad8
    1b34:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b37:	a3 dc 6a 00 00       	mov    %eax,0x6adc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1b3c:	83 ec 04             	sub    $0x4,%esp
    1b3f:	ff 35 dc 6a 00 00    	pushl  0x6adc
    1b45:	ff 35 d8 6a 00 00    	pushl  0x6ad8
    1b4b:	ff 35 d4 6a 00 00    	pushl  0x6ad4
    1b51:	e8 d2 f0 ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1b56:	83 c4 10             	add    $0x10,%esp
    1b59:	a3 68 6a 00 00       	mov    %eax,0x6a68
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1b5e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b61:	83 ec 08             	sub    $0x8,%esp
    1b64:	68 97 27 00 00       	push   $0x2797
    1b69:	50                   	push   %eax
    1b6a:	e8 7f ee ff ff       	call   9ee <APLoadBitmap>
    1b6f:	83 c4 0c             	add    $0xc,%esp
    1b72:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b75:	a3 6c 6a 00 00       	mov    %eax,0x6a6c
    1b7a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b7d:	a3 70 6a 00 00       	mov    %eax,0x6a70
    1b82:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b85:	a3 74 6a 00 00       	mov    %eax,0x6a74
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1b8a:	83 ec 04             	sub    $0x4,%esp
    1b8d:	ff 35 74 6a 00 00    	pushl  0x6a74
    1b93:	ff 35 70 6a 00 00    	pushl  0x6a70
    1b99:	ff 35 6c 6a 00 00    	pushl  0x6a6c
    1b9f:	e8 84 f0 ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1ba4:	83 c4 10             	add    $0x10,%esp
    1ba7:	a3 90 6a 00 00       	mov    %eax,0x6a90
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1bac:	8d 45 98             	lea    -0x68(%ebp),%eax
    1baf:	83 ec 08             	sub    $0x8,%esp
    1bb2:	68 a9 27 00 00       	push   $0x27a9
    1bb7:	50                   	push   %eax
    1bb8:	e8 31 ee ff ff       	call   9ee <APLoadBitmap>
    1bbd:	83 c4 0c             	add    $0xc,%esp
    1bc0:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bc3:	a3 ac 6a 00 00       	mov    %eax,0x6aac
    1bc8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bcb:	a3 b0 6a 00 00       	mov    %eax,0x6ab0
    1bd0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bd3:	a3 b4 6a 00 00       	mov    %eax,0x6ab4
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1bd8:	83 ec 04             	sub    $0x4,%esp
    1bdb:	ff 35 b4 6a 00 00    	pushl  0x6ab4
    1be1:	ff 35 b0 6a 00 00    	pushl  0x6ab0
    1be7:	ff 35 ac 6a 00 00    	pushl  0x6aac
    1bed:	e8 36 f0 ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1bf2:	83 c4 10             	add    $0x10,%esp
    1bf5:	a3 f0 6a 00 00       	mov    %eax,0x6af0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1bfa:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bfd:	83 ec 08             	sub    $0x8,%esp
    1c00:	68 b7 27 00 00       	push   $0x27b7
    1c05:	50                   	push   %eax
    1c06:	e8 e3 ed ff ff       	call   9ee <APLoadBitmap>
    1c0b:	83 c4 0c             	add    $0xc,%esp
    1c0e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c11:	a3 84 6a 00 00       	mov    %eax,0x6a84
    1c16:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c19:	a3 88 6a 00 00       	mov    %eax,0x6a88
    1c1e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c21:	a3 8c 6a 00 00       	mov    %eax,0x6a8c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1c26:	83 ec 04             	sub    $0x4,%esp
    1c29:	ff 35 8c 6a 00 00    	pushl  0x6a8c
    1c2f:	ff 35 88 6a 00 00    	pushl  0x6a88
    1c35:	ff 35 84 6a 00 00    	pushl  0x6a84
    1c3b:	e8 e8 ef ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1c40:	83 c4 10             	add    $0x10,%esp
    1c43:	a3 a4 6a 00 00       	mov    %eax,0x6aa4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c48:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c4b:	83 ec 08             	sub    $0x8,%esp
    1c4e:	68 c7 27 00 00       	push   $0x27c7
    1c53:	50                   	push   %eax
    1c54:	e8 95 ed ff ff       	call   9ee <APLoadBitmap>
    1c59:	83 c4 0c             	add    $0xc,%esp
    1c5c:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c5f:	a3 c4 6a 00 00       	mov    %eax,0x6ac4
    1c64:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c67:	a3 c8 6a 00 00       	mov    %eax,0x6ac8
    1c6c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c6f:	a3 cc 6a 00 00       	mov    %eax,0x6acc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c74:	83 ec 04             	sub    $0x4,%esp
    1c77:	ff 35 cc 6a 00 00    	pushl  0x6acc
    1c7d:	ff 35 c8 6a 00 00    	pushl  0x6ac8
    1c83:	ff 35 c4 6a 00 00    	pushl  0x6ac4
    1c89:	e8 9a ef ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1c8e:	83 c4 10             	add    $0x10,%esp
    1c91:	a3 f4 6a 00 00       	mov    %eax,0x6af4
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1c96:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c99:	83 ec 08             	sub    $0x8,%esp
    1c9c:	68 d6 27 00 00       	push   $0x27d6
    1ca1:	50                   	push   %eax
    1ca2:	e8 47 ed ff ff       	call   9ee <APLoadBitmap>
    1ca7:	83 c4 0c             	add    $0xc,%esp
    1caa:	8b 45 98             	mov    -0x68(%ebp),%eax
    1cad:	a3 b8 6a 00 00       	mov    %eax,0x6ab8
    1cb2:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1cb5:	a3 bc 6a 00 00       	mov    %eax,0x6abc
    1cba:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1cbd:	a3 c0 6a 00 00       	mov    %eax,0x6ac0
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1cc2:	83 ec 04             	sub    $0x4,%esp
    1cc5:	ff 35 c0 6a 00 00    	pushl  0x6ac0
    1ccb:	ff 35 bc 6a 00 00    	pushl  0x6abc
    1cd1:	ff 35 b8 6a 00 00    	pushl  0x6ab8
    1cd7:	e8 4c ef ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1cdc:	83 c4 10             	add    $0x10,%esp
    1cdf:	a3 ec 6a 00 00       	mov    %eax,0x6aec
        grid_tower = APLoadBitmap ("grid_tower.bmp");
    1ce4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ce7:	83 ec 08             	sub    $0x8,%esp
    1cea:	68 e5 27 00 00       	push   $0x27e5
    1cef:	50                   	push   %eax
    1cf0:	e8 f9 ec ff ff       	call   9ee <APLoadBitmap>
    1cf5:	83 c4 0c             	add    $0xc,%esp
    1cf8:	8b 45 98             	mov    -0x68(%ebp),%eax
    1cfb:	a3 78 6a 00 00       	mov    %eax,0x6a78
    1d00:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1d03:	a3 7c 6a 00 00       	mov    %eax,0x6a7c
    1d08:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1d0b:	a3 80 6a 00 00       	mov    %eax,0x6a80
        g_tower = APCreateCompatibleDCFromBitmap(grid_tower);
    1d10:	83 ec 04             	sub    $0x4,%esp
    1d13:	ff 35 80 6a 00 00    	pushl  0x6a80
    1d19:	ff 35 7c 6a 00 00    	pushl  0x6a7c
    1d1f:	ff 35 78 6a 00 00    	pushl  0x6a78
    1d25:	e8 fe ee ff ff       	call   c28 <APCreateCompatibleDCFromBitmap>
    1d2a:	83 c4 10             	add    $0x10,%esp
    1d2d:	a3 a8 6a 00 00       	mov    %eax,0x6aa8
   
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1d32:	8b 45 08             	mov    0x8(%ebp),%eax
    1d35:	8b 40 08             	mov    0x8(%eax),%eax
    1d38:	85 c0                	test   %eax,%eax
    1d3a:	75 17                	jne    1d53 <APGridPaint+0x2ff>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1d3c:	83 ec 08             	sub    $0x8,%esp
    1d3f:	68 f4 27 00 00       	push   $0x27f4
    1d44:	6a 01                	push   $0x1
    1d46:	e8 1d e8 ff ff       	call   568 <printf>
    1d4b:	83 c4 10             	add    $0x10,%esp
        return;
    1d4e:	e9 ae 04 00 00       	jmp    2201 <APGridPaint+0x7ad>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1d53:	8b 45 08             	mov    0x8(%ebp),%eax
    1d56:	8b 40 10             	mov    0x10(%eax),%eax
    1d59:	85 c0                	test   %eax,%eax
    1d5b:	7e 10                	jle    1d6d <APGridPaint+0x319>
    1d5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d60:	8b 50 14             	mov    0x14(%eax),%edx
    1d63:	8b 45 08             	mov    0x8(%ebp),%eax
    1d66:	8b 40 10             	mov    0x10(%eax),%eax
    1d69:	39 c2                	cmp    %eax,%edx
    1d6b:	7c 17                	jl     1d84 <APGridPaint+0x330>
    {
        printf(1,"Grid mode page error!");
    1d6d:	83 ec 08             	sub    $0x8,%esp
    1d70:	68 1a 28 00 00       	push   $0x281a
    1d75:	6a 01                	push   $0x1
    1d77:	e8 ec e7 ff ff       	call   568 <printf>
    1d7c:	83 c4 10             	add    $0x10,%esp
        return;
    1d7f:	e9 7d 04 00 00       	jmp    2201 <APGridPaint+0x7ad>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1d84:	8b 45 08             	mov    0x8(%ebp),%eax
    1d87:	8b 40 14             	mov    0x14(%eax),%eax
    1d8a:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1d90:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d93:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d96:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d99:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1da0:	e9 52 04 00 00       	jmp    21f7 <APGridPaint+0x7a3>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1da5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1dac:	e9 38 04 00 00       	jmp    21e9 <APGridPaint+0x795>
        {
            index = start + GRID_W_NUMBER * j + i;
    1db1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1db4:	c1 e0 04             	shl    $0x4,%eax
    1db7:	89 c2                	mov    %eax,%edx
    1db9:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1dbc:	01 c2                	add    %eax,%edx
    1dbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dc1:	01 d0                	add    %edx,%eax
    1dc3:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1dc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc9:	8b 40 0c             	mov    0xc(%eax),%eax
    1dcc:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1dcf:	c1 e2 02             	shl    $0x2,%edx
    1dd2:	01 d0                	add    %edx,%eax
    1dd4:	8b 00                	mov    (%eax),%eax
    1dd6:	83 f8 0b             	cmp    $0xb,%eax
    1dd9:	0f 87 05 04 00 00    	ja     21e4 <APGridPaint+0x790>
    1ddf:	8b 04 85 30 28 00 00 	mov    0x2830(,%eax,4),%eax
    1de6:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1de8:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1deb:	6a 0c                	push   $0xc
    1ded:	6a 0c                	push   $0xc
    1def:	6a 0c                	push   $0xc
    1df1:	50                   	push   %eax
    1df2:	e8 d9 f7 ff ff       	call   15d0 <RGB>
    1df7:	83 c4 0c             	add    $0xc,%esp
    1dfa:	8b 1d a0 6a 00 00    	mov    0x6aa0,%ebx
    1e00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e03:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e06:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e09:	6b c0 32             	imul   $0x32,%eax,%eax
    1e0c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e12:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e15:	83 ec 0c             	sub    $0xc,%esp
    1e18:	83 ec 04             	sub    $0x4,%esp
    1e1b:	89 e0                	mov    %esp,%eax
    1e1d:	0f b7 75 bd          	movzwl -0x43(%ebp),%esi
    1e21:	66 89 30             	mov    %si,(%eax)
    1e24:	0f b6 55 bf          	movzbl -0x41(%ebp),%edx
    1e28:	88 50 02             	mov    %dl,0x2(%eax)
    1e2b:	6a 32                	push   $0x32
    1e2d:	6a 32                	push   $0x32
    1e2f:	6a 00                	push   $0x0
    1e31:	6a 00                	push   $0x0
    1e33:	53                   	push   %ebx
    1e34:	51                   	push   %ecx
    1e35:	ff 75 94             	pushl  -0x6c(%ebp)
    1e38:	57                   	push   %edi
    1e39:	e8 ee f5 ff ff       	call   142c <APDcCopy>
    1e3e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e41:	e9 9f 03 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1e46:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e49:	6a 69                	push   $0x69
    1e4b:	6a 69                	push   $0x69
    1e4d:	6a 69                	push   $0x69
    1e4f:	50                   	push   %eax
    1e50:	e8 7b f7 ff ff       	call   15d0 <RGB>
    1e55:	83 c4 0c             	add    $0xc,%esp
    1e58:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e5c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1e60:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e64:	88 45 b6             	mov    %al,-0x4a(%ebp)
                    pen.size = 1;
    1e67:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1e6e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e71:	6a 69                	push   $0x69
    1e73:	6a 69                	push   $0x69
    1e75:	6a 69                	push   $0x69
    1e77:	50                   	push   %eax
    1e78:	e8 53 f7 ff ff       	call   15d0 <RGB>
    1e7d:	83 c4 0c             	add    $0xc,%esp
    1e80:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e84:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    1e88:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e8c:	88 45 b3             	mov    %al,-0x4d(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1e8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e92:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e95:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e98:	ff 75 b8             	pushl  -0x48(%ebp)
    1e9b:	ff 75 b4             	pushl  -0x4c(%ebp)
    1e9e:	52                   	push   %edx
    1e9f:	50                   	push   %eax
    1ea0:	e8 18 ee ff ff       	call   cbd <APSetPen>
    1ea5:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ea8:	8b 45 08             	mov    0x8(%ebp),%eax
    1eab:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1eae:	8d 55 98             	lea    -0x68(%ebp),%edx
    1eb1:	83 ec 04             	sub    $0x4,%esp
    1eb4:	83 ec 04             	sub    $0x4,%esp
    1eb7:	89 e0                	mov    %esp,%eax
    1eb9:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    1ebd:	66 89 08             	mov    %cx,(%eax)
    1ec0:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    1ec4:	88 48 02             	mov    %cl,0x2(%eax)
    1ec7:	53                   	push   %ebx
    1ec8:	52                   	push   %edx
    1ec9:	e8 28 ee ff ff       	call   cf6 <APSetBrush>
    1ece:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ed1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ed4:	6b d0 32             	imul   $0x32,%eax,%edx
    1ed7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eda:	6b c0 32             	imul   $0x32,%eax,%eax
    1edd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ee0:	83 c1 3c             	add    $0x3c,%ecx
    1ee3:	83 ec 0c             	sub    $0xc,%esp
    1ee6:	6a 32                	push   $0x32
    1ee8:	6a 32                	push   $0x32
    1eea:	52                   	push   %edx
    1eeb:	50                   	push   %eax
    1eec:	51                   	push   %ecx
    1eed:	e8 2e f2 ff ff       	call   1120 <APDrawRect>
    1ef2:	83 c4 20             	add    $0x20,%esp
                    break;
    1ef5:	e9 eb 02 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1efa:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1efd:	6a 0c                	push   $0xc
    1eff:	6a 0c                	push   $0xc
    1f01:	6a 0c                	push   $0xc
    1f03:	50                   	push   %eax
    1f04:	e8 c7 f6 ff ff       	call   15d0 <RGB>
    1f09:	83 c4 0c             	add    $0xc,%esp
    1f0c:	8b 1d f4 6a 00 00    	mov    0x6af4,%ebx
    1f12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f15:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f18:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f1b:	6b c0 32             	imul   $0x32,%eax,%eax
    1f1e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f21:	8b 45 08             	mov    0x8(%ebp),%eax
    1f24:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f27:	83 ec 0c             	sub    $0xc,%esp
    1f2a:	83 ec 04             	sub    $0x4,%esp
    1f2d:	89 e0                	mov    %esp,%eax
    1f2f:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1f33:	66 89 30             	mov    %si,(%eax)
    1f36:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1f3a:	88 50 02             	mov    %dl,0x2(%eax)
    1f3d:	6a 32                	push   $0x32
    1f3f:	6a 32                	push   $0x32
    1f41:	6a 00                	push   $0x0
    1f43:	6a 00                	push   $0x0
    1f45:	53                   	push   %ebx
    1f46:	51                   	push   %ecx
    1f47:	ff 75 94             	pushl  -0x6c(%ebp)
    1f4a:	57                   	push   %edi
    1f4b:	e8 dc f4 ff ff       	call   142c <APDcCopy>
    1f50:	83 c4 30             	add    $0x30,%esp
                    break;
    1f53:	e9 8d 02 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f58:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1f5b:	6a 0c                	push   $0xc
    1f5d:	6a 0c                	push   $0xc
    1f5f:	6a 0c                	push   $0xc
    1f61:	50                   	push   %eax
    1f62:	e8 69 f6 ff ff       	call   15d0 <RGB>
    1f67:	83 c4 0c             	add    $0xc,%esp
    1f6a:	8b 1d d0 6a 00 00    	mov    0x6ad0,%ebx
    1f70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f73:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f76:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f79:	6b c0 32             	imul   $0x32,%eax,%eax
    1f7c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f82:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f85:	83 ec 0c             	sub    $0xc,%esp
    1f88:	83 ec 04             	sub    $0x4,%esp
    1f8b:	89 e0                	mov    %esp,%eax
    1f8d:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1f91:	66 89 30             	mov    %si,(%eax)
    1f94:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1f98:	88 50 02             	mov    %dl,0x2(%eax)
    1f9b:	6a 32                	push   $0x32
    1f9d:	6a 32                	push   $0x32
    1f9f:	6a 00                	push   $0x0
    1fa1:	6a 00                	push   $0x0
    1fa3:	53                   	push   %ebx
    1fa4:	51                   	push   %ecx
    1fa5:	ff 75 94             	pushl  -0x6c(%ebp)
    1fa8:	57                   	push   %edi
    1fa9:	e8 7e f4 ff ff       	call   142c <APDcCopy>
    1fae:	83 c4 30             	add    $0x30,%esp
                    break;
    1fb1:	e9 2f 02 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fb6:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1fb9:	6a 0c                	push   $0xc
    1fbb:	6a 0c                	push   $0xc
    1fbd:	6a 0c                	push   $0xc
    1fbf:	50                   	push   %eax
    1fc0:	e8 0b f6 ff ff       	call   15d0 <RGB>
    1fc5:	83 c4 0c             	add    $0xc,%esp
    1fc8:	8b 1d a4 6a 00 00    	mov    0x6aa4,%ebx
    1fce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fd1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fd7:	6b c0 32             	imul   $0x32,%eax,%eax
    1fda:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fdd:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe0:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fe3:	83 ec 0c             	sub    $0xc,%esp
    1fe6:	83 ec 04             	sub    $0x4,%esp
    1fe9:	89 e0                	mov    %esp,%eax
    1feb:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1fef:	66 89 30             	mov    %si,(%eax)
    1ff2:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ff6:	88 50 02             	mov    %dl,0x2(%eax)
    1ff9:	6a 32                	push   $0x32
    1ffb:	6a 32                	push   $0x32
    1ffd:	6a 00                	push   $0x0
    1fff:	6a 00                	push   $0x0
    2001:	53                   	push   %ebx
    2002:	51                   	push   %ecx
    2003:	ff 75 94             	pushl  -0x6c(%ebp)
    2006:	57                   	push   %edi
    2007:	e8 20 f4 ff ff       	call   142c <APDcCopy>
    200c:	83 c4 30             	add    $0x30,%esp
                    break;
    200f:	e9 d1 01 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2014:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2017:	6a 0c                	push   $0xc
    2019:	6a 0c                	push   $0xc
    201b:	6a 0c                	push   $0xc
    201d:	50                   	push   %eax
    201e:	e8 ad f5 ff ff       	call   15d0 <RGB>
    2023:	83 c4 0c             	add    $0xc,%esp
    2026:	8b 1d f0 6a 00 00    	mov    0x6af0,%ebx
    202c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    202f:	6b c8 32             	imul   $0x32,%eax,%ecx
    2032:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2035:	6b c0 32             	imul   $0x32,%eax,%eax
    2038:	89 45 94             	mov    %eax,-0x6c(%ebp)
    203b:	8b 45 08             	mov    0x8(%ebp),%eax
    203e:	8d 78 3c             	lea    0x3c(%eax),%edi
    2041:	83 ec 0c             	sub    $0xc,%esp
    2044:	83 ec 04             	sub    $0x4,%esp
    2047:	89 e0                	mov    %esp,%eax
    2049:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    204d:	66 89 30             	mov    %si,(%eax)
    2050:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2054:	88 50 02             	mov    %dl,0x2(%eax)
    2057:	6a 32                	push   $0x32
    2059:	6a 32                	push   $0x32
    205b:	6a 00                	push   $0x0
    205d:	6a 00                	push   $0x0
    205f:	53                   	push   %ebx
    2060:	51                   	push   %ecx
    2061:	ff 75 94             	pushl  -0x6c(%ebp)
    2064:	57                   	push   %edi
    2065:	e8 c2 f3 ff ff       	call   142c <APDcCopy>
    206a:	83 c4 30             	add    $0x30,%esp
                    break;
    206d:	e9 73 01 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2072:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2075:	6a 0c                	push   $0xc
    2077:	6a 0c                	push   $0xc
    2079:	6a 0c                	push   $0xc
    207b:	50                   	push   %eax
    207c:	e8 4f f5 ff ff       	call   15d0 <RGB>
    2081:	83 c4 0c             	add    $0xc,%esp
    2084:	8b 1d 68 6a 00 00    	mov    0x6a68,%ebx
    208a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    208d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2090:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2093:	6b c0 32             	imul   $0x32,%eax,%eax
    2096:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2099:	8b 45 08             	mov    0x8(%ebp),%eax
    209c:	8d 78 3c             	lea    0x3c(%eax),%edi
    209f:	83 ec 0c             	sub    $0xc,%esp
    20a2:	83 ec 04             	sub    $0x4,%esp
    20a5:	89 e0                	mov    %esp,%eax
    20a7:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    20ab:	66 89 30             	mov    %si,(%eax)
    20ae:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    20b2:	88 50 02             	mov    %dl,0x2(%eax)
    20b5:	6a 32                	push   $0x32
    20b7:	6a 32                	push   $0x32
    20b9:	6a 00                	push   $0x0
    20bb:	6a 00                	push   $0x0
    20bd:	53                   	push   %ebx
    20be:	51                   	push   %ecx
    20bf:	ff 75 94             	pushl  -0x6c(%ebp)
    20c2:	57                   	push   %edi
    20c3:	e8 64 f3 ff ff       	call   142c <APDcCopy>
    20c8:	83 c4 30             	add    $0x30,%esp
                    break;
    20cb:	e9 15 01 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20d0:	8d 45 cf             	lea    -0x31(%ebp),%eax
    20d3:	6a 0c                	push   $0xc
    20d5:	6a 0c                	push   $0xc
    20d7:	6a 0c                	push   $0xc
    20d9:	50                   	push   %eax
    20da:	e8 f1 f4 ff ff       	call   15d0 <RGB>
    20df:	83 c4 0c             	add    $0xc,%esp
    20e2:	8b 1d 90 6a 00 00    	mov    0x6a90,%ebx
    20e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20eb:	6b c8 32             	imul   $0x32,%eax,%ecx
    20ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20f1:	6b c0 32             	imul   $0x32,%eax,%eax
    20f4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    20f7:	8b 45 08             	mov    0x8(%ebp),%eax
    20fa:	8d 78 3c             	lea    0x3c(%eax),%edi
    20fd:	83 ec 0c             	sub    $0xc,%esp
    2100:	83 ec 04             	sub    $0x4,%esp
    2103:	89 e0                	mov    %esp,%eax
    2105:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2109:	66 89 30             	mov    %si,(%eax)
    210c:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2110:	88 50 02             	mov    %dl,0x2(%eax)
    2113:	6a 32                	push   $0x32
    2115:	6a 32                	push   $0x32
    2117:	6a 00                	push   $0x0
    2119:	6a 00                	push   $0x0
    211b:	53                   	push   %ebx
    211c:	51                   	push   %ecx
    211d:	ff 75 94             	pushl  -0x6c(%ebp)
    2120:	57                   	push   %edi
    2121:	e8 06 f3 ff ff       	call   142c <APDcCopy>
    2126:	83 c4 30             	add    $0x30,%esp
                    break;
    2129:	e9 b7 00 00 00       	jmp    21e5 <APGridPaint+0x791>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    212e:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2131:	6a 0c                	push   $0xc
    2133:	6a 0c                	push   $0xc
    2135:	6a 0c                	push   $0xc
    2137:	50                   	push   %eax
    2138:	e8 93 f4 ff ff       	call   15d0 <RGB>
    213d:	83 c4 0c             	add    $0xc,%esp
    2140:	8b 1d ec 6a 00 00    	mov    0x6aec,%ebx
    2146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2149:	6b c8 32             	imul   $0x32,%eax,%ecx
    214c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    214f:	6b c0 32             	imul   $0x32,%eax,%eax
    2152:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2155:	8b 45 08             	mov    0x8(%ebp),%eax
    2158:	8d 78 3c             	lea    0x3c(%eax),%edi
    215b:	83 ec 0c             	sub    $0xc,%esp
    215e:	83 ec 04             	sub    $0x4,%esp
    2161:	89 e0                	mov    %esp,%eax
    2163:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2167:	66 89 30             	mov    %si,(%eax)
    216a:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    216e:	88 50 02             	mov    %dl,0x2(%eax)
    2171:	6a 32                	push   $0x32
    2173:	6a 32                	push   $0x32
    2175:	6a 00                	push   $0x0
    2177:	6a 00                	push   $0x0
    2179:	53                   	push   %ebx
    217a:	51                   	push   %ecx
    217b:	ff 75 94             	pushl  -0x6c(%ebp)
    217e:	57                   	push   %edi
    217f:	e8 a8 f2 ff ff       	call   142c <APDcCopy>
    2184:	83 c4 30             	add    $0x30,%esp
                    break;
    2187:	eb 5c                	jmp    21e5 <APGridPaint+0x791>
                case GRID_PROGRAM_TOWER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_tower,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2189:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    218c:	6a 0c                	push   $0xc
    218e:	6a 0c                	push   $0xc
    2190:	6a 0c                	push   $0xc
    2192:	50                   	push   %eax
    2193:	e8 38 f4 ff ff       	call   15d0 <RGB>
    2198:	83 c4 0c             	add    $0xc,%esp
    219b:	8b 1d a8 6a 00 00    	mov    0x6aa8,%ebx
    21a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21a4:	6b c8 32             	imul   $0x32,%eax,%ecx
    21a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21aa:	6b c0 32             	imul   $0x32,%eax,%eax
    21ad:	89 45 94             	mov    %eax,-0x6c(%ebp)
    21b0:	8b 45 08             	mov    0x8(%ebp),%eax
    21b3:	8d 78 3c             	lea    0x3c(%eax),%edi
    21b6:	83 ec 0c             	sub    $0xc,%esp
    21b9:	83 ec 04             	sub    $0x4,%esp
    21bc:	89 e0                	mov    %esp,%eax
    21be:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    21c2:	66 89 30             	mov    %si,(%eax)
    21c5:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    21c9:	88 50 02             	mov    %dl,0x2(%eax)
    21cc:	6a 32                	push   $0x32
    21ce:	6a 32                	push   $0x32
    21d0:	6a 00                	push   $0x0
    21d2:	6a 00                	push   $0x0
    21d4:	53                   	push   %ebx
    21d5:	51                   	push   %ecx
    21d6:	ff 75 94             	pushl  -0x6c(%ebp)
    21d9:	57                   	push   %edi
    21da:	e8 4d f2 ff ff       	call   142c <APDcCopy>
    21df:	83 c4 30             	add    $0x30,%esp
                    break;
    21e2:	eb 01                	jmp    21e5 <APGridPaint+0x791>
                default: break;
    21e4:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    21e5:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    21e9:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    21ed:	0f 8e be fb ff ff    	jle    1db1 <APGridPaint+0x35d>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    21f3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    21f7:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    21fb:	0f 8e a4 fb ff ff    	jle    1da5 <APGridPaint+0x351>
                    break;
                default: break;
            }
        }
    }
}
    2201:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2204:	5b                   	pop    %ebx
    2205:	5e                   	pop    %esi
    2206:	5f                   	pop    %edi
    2207:	5d                   	pop    %ebp
    2208:	c3                   	ret    

00002209 <updateword>:


void updateword(AHwnd hwnd,char* str)
{
    2209:	55                   	push   %ebp
    220a:	89 e5                	mov    %esp,%ebp
    220c:	53                   	push   %ebx
    220d:	83 ec 24             	sub    $0x24,%esp
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2210:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2213:	68 cd 00 00 00       	push   $0xcd
    2218:	6a 74                	push   $0x74
    221a:	6a 18                	push   $0x18
    221c:	50                   	push   %eax
    221d:	e8 ae f3 ff ff       	call   15d0 <RGB>
    2222:	83 c4 0c             	add    $0xc,%esp
    2225:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2229:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
    222d:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    2231:	88 45 f2             	mov    %al,-0xe(%ebp)
    pen.size = 1;
    2234:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    223b:	8d 45 d8             	lea    -0x28(%ebp),%eax
    223e:	68 cd 00 00 00       	push   $0xcd
    2243:	6a 74                	push   $0x74
    2245:	6a 18                	push   $0x18
    2247:	50                   	push   %eax
    2248:	e8 83 f3 ff ff       	call   15d0 <RGB>
    224d:	83 c4 0c             	add    $0xc,%esp
    2250:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    2254:	66 89 45 ed          	mov    %ax,-0x13(%ebp)
    2258:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    225c:	88 45 ef             	mov    %al,-0x11(%ebp)
    APSetPen(&hwnd->TitleDc,pen);
    225f:	8b 45 08             	mov    0x8(%ebp),%eax
    2262:	8d 50 58             	lea    0x58(%eax),%edx
    2265:	8d 45 d8             	lea    -0x28(%ebp),%eax
    2268:	ff 75 f4             	pushl  -0xc(%ebp)
    226b:	ff 75 f0             	pushl  -0x10(%ebp)
    226e:	52                   	push   %edx
    226f:	50                   	push   %eax
    2270:	e8 48 ea ff ff       	call   cbd <APSetPen>
    2275:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&hwnd->TitleDc,brush);
    2278:	8b 45 08             	mov    0x8(%ebp),%eax
    227b:	8d 58 58             	lea    0x58(%eax),%ebx
    227e:	8d 55 d8             	lea    -0x28(%ebp),%edx
    2281:	83 ec 04             	sub    $0x4,%esp
    2284:	83 ec 04             	sub    $0x4,%esp
    2287:	89 e0                	mov    %esp,%eax
    2289:	0f b7 4d ed          	movzwl -0x13(%ebp),%ecx
    228d:	66 89 08             	mov    %cx,(%eax)
    2290:	0f b6 4d ef          	movzbl -0x11(%ebp),%ecx
    2294:	88 48 02             	mov    %cl,0x2(%eax)
    2297:	53                   	push   %ebx
    2298:	52                   	push   %edx
    2299:	e8 58 ea ff ff       	call   cf6 <APSetBrush>
    229e:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&hwnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    22a1:	8b 45 08             	mov    0x8(%ebp),%eax
    22a4:	83 c0 58             	add    $0x58,%eax
    22a7:	83 ec 0c             	sub    $0xc,%esp
    22aa:	6a 32                	push   $0x32
    22ac:	68 20 03 00 00       	push   $0x320
    22b1:	6a 00                	push   $0x0
    22b3:	6a 00                	push   $0x0
    22b5:	50                   	push   %eax
    22b6:	e8 65 ee ff ff       	call   1120 <APDrawRect>
    22bb:	83 c4 20             	add    $0x20,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    22be:	8d 45 d8             	lea    -0x28(%ebp),%eax
    22c1:	6a 08                	push   $0x8
    22c3:	6a 08                	push   $0x8
    22c5:	6a 08                	push   $0x8
    22c7:	50                   	push   %eax
    22c8:	e8 03 f3 ff ff       	call   15d0 <RGB>
    22cd:	83 c4 0c             	add    $0xc,%esp
    22d0:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    22d4:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    22d8:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    22dc:	88 45 ec             	mov    %al,-0x14(%ebp)
    APSetFont(&hwnd->TitleDc,font);
    22df:	8b 45 08             	mov    0x8(%ebp),%eax
    22e2:	8d 58 58             	lea    0x58(%eax),%ebx
    22e5:	8d 55 d8             	lea    -0x28(%ebp),%edx
    22e8:	83 ec 04             	sub    $0x4,%esp
    22eb:	83 ec 04             	sub    $0x4,%esp
    22ee:	89 e0                	mov    %esp,%eax
    22f0:	0f b7 4d ea          	movzwl -0x16(%ebp),%ecx
    22f4:	66 89 08             	mov    %cx,(%eax)
    22f7:	0f b6 4d ec          	movzbl -0x14(%ebp),%ecx
    22fb:	88 48 02             	mov    %cl,0x2(%eax)
    22fe:	53                   	push   %ebx
    22ff:	52                   	push   %edx
    2300:	e8 33 ea ff ff       	call   d38 <APSetFont>
    2305:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&hwnd->TitleDc,str,10,20);
    2308:	8b 45 08             	mov    0x8(%ebp),%eax
    230b:	83 c0 58             	add    $0x58,%eax
    230e:	6a 14                	push   $0x14
    2310:	6a 0a                	push   $0xa
    2312:	ff 75 0c             	pushl  0xc(%ebp)
    2315:	50                   	push   %eax
    2316:	e8 0a f0 ff ff       	call   1325 <APDrawText>
    231b:	83 c4 10             	add    $0x10,%esp
}
    231e:	90                   	nop
    231f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2322:	c9                   	leave  
    2323:	c3                   	ret    

00002324 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2324:	55                   	push   %ebp
    2325:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2327:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    232b:	7e 08                	jle    2335 <random+0x11>
{
rand_num = seed;
    232d:	8b 45 08             	mov    0x8(%ebp),%eax
    2330:	a3 40 6a 00 00       	mov    %eax,0x6a40
}
rand_num *= 3;
    2335:	8b 15 40 6a 00 00    	mov    0x6a40,%edx
    233b:	89 d0                	mov    %edx,%eax
    233d:	01 c0                	add    %eax,%eax
    233f:	01 d0                	add    %edx,%eax
    2341:	a3 40 6a 00 00       	mov    %eax,0x6a40
if (rand_num < 0)
    2346:	a1 40 6a 00 00       	mov    0x6a40,%eax
    234b:	85 c0                	test   %eax,%eax
    234d:	79 0c                	jns    235b <random+0x37>
{
rand_num *= (-1);
    234f:	a1 40 6a 00 00       	mov    0x6a40,%eax
    2354:	f7 d8                	neg    %eax
    2356:	a3 40 6a 00 00       	mov    %eax,0x6a40
}
return rand_num % 997;
    235b:	8b 0d 40 6a 00 00    	mov    0x6a40,%ecx
    2361:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2366:	89 c8                	mov    %ecx,%eax
    2368:	f7 ea                	imul   %edx
    236a:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    236d:	c1 f8 09             	sar    $0x9,%eax
    2370:	89 c2                	mov    %eax,%edx
    2372:	89 c8                	mov    %ecx,%eax
    2374:	c1 f8 1f             	sar    $0x1f,%eax
    2377:	29 c2                	sub    %eax,%edx
    2379:	89 d0                	mov    %edx,%eax
    237b:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2381:	29 c1                	sub    %eax,%ecx
    2383:	89 c8                	mov    %ecx,%eax
}
    2385:	5d                   	pop    %ebp
    2386:	c3                   	ret    

00002387 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2387:	55                   	push   %ebp
    2388:	89 e5                	mov    %esp,%ebp
    238a:	53                   	push   %ebx
    238b:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    238e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2395:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2399:	74 17                	je     23b2 <sprintint+0x2b>
    239b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    239f:	79 11                	jns    23b2 <sprintint+0x2b>
        neg = 1;
    23a1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    23a8:	8b 45 10             	mov    0x10(%ebp),%eax
    23ab:	f7 d8                	neg    %eax
    23ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23b0:	eb 06                	jmp    23b8 <sprintint+0x31>
    } else {
        x = xx;
    23b2:	8b 45 10             	mov    0x10(%ebp),%eax
    23b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    23b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    23bf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    23c2:	8d 41 01             	lea    0x1(%ecx),%eax
    23c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    23c8:	8b 5d 14             	mov    0x14(%ebp),%ebx
    23cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23ce:	ba 00 00 00 00       	mov    $0x0,%edx
    23d3:	f7 f3                	div    %ebx
    23d5:	89 d0                	mov    %edx,%eax
    23d7:	0f b6 80 44 6a 00 00 	movzbl 0x6a44(%eax),%eax
    23de:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    23e2:	8b 5d 14             	mov    0x14(%ebp),%ebx
    23e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23e8:	ba 00 00 00 00       	mov    $0x0,%edx
    23ed:	f7 f3                	div    %ebx
    23ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    23f6:	75 c7                	jne    23bf <sprintint+0x38>
    if(neg)
    23f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23fc:	74 0e                	je     240c <sprintint+0x85>
        buf[i++] = '-';
    23fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2401:	8d 50 01             	lea    0x1(%eax),%edx
    2404:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2407:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    240c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    240f:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2412:	eb 1b                	jmp    242f <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2414:	8b 45 0c             	mov    0xc(%ebp),%eax
    2417:	8b 00                	mov    (%eax),%eax
    2419:	8d 48 01             	lea    0x1(%eax),%ecx
    241c:	8b 55 0c             	mov    0xc(%ebp),%edx
    241f:	89 0a                	mov    %ecx,(%edx)
    2421:	89 c2                	mov    %eax,%edx
    2423:	8b 45 08             	mov    0x8(%ebp),%eax
    2426:	01 d0                	add    %edx,%eax
    2428:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    242b:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    242f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2433:	7f df                	jg     2414 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2435:	eb 21                	jmp    2458 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2437:	8b 45 0c             	mov    0xc(%ebp),%eax
    243a:	8b 00                	mov    (%eax),%eax
    243c:	8d 48 01             	lea    0x1(%eax),%ecx
    243f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2442:	89 0a                	mov    %ecx,(%edx)
    2444:	89 c2                	mov    %eax,%edx
    2446:	8b 45 08             	mov    0x8(%ebp),%eax
    2449:	01 c2                	add    %eax,%edx
    244b:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    244e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2451:	01 c8                	add    %ecx,%eax
    2453:	0f b6 00             	movzbl (%eax),%eax
    2456:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2458:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    245c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2460:	79 d5                	jns    2437 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2462:	90                   	nop
    2463:	83 c4 20             	add    $0x20,%esp
    2466:	5b                   	pop    %ebx
    2467:	5d                   	pop    %ebp
    2468:	c3                   	ret    

00002469 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2469:	55                   	push   %ebp
    246a:	89 e5                	mov    %esp,%ebp
    246c:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    246f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2476:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    247d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2484:	8d 45 0c             	lea    0xc(%ebp),%eax
    2487:	83 c0 04             	add    $0x4,%eax
    248a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    248d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2494:	e9 d9 01 00 00       	jmp    2672 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2499:	8b 55 0c             	mov    0xc(%ebp),%edx
    249c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    249f:	01 d0                	add    %edx,%eax
    24a1:	0f b6 00             	movzbl (%eax),%eax
    24a4:	0f be c0             	movsbl %al,%eax
    24a7:	25 ff 00 00 00       	and    $0xff,%eax
    24ac:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    24af:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    24b3:	75 2c                	jne    24e1 <sprintf+0x78>
            if(c == '%'){
    24b5:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    24b9:	75 0c                	jne    24c7 <sprintf+0x5e>
                state = '%';
    24bb:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    24c2:	e9 a7 01 00 00       	jmp    266e <sprintf+0x205>
            } else {
                dst[j++] = c;
    24c7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24ca:	8d 50 01             	lea    0x1(%eax),%edx
    24cd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24d0:	89 c2                	mov    %eax,%edx
    24d2:	8b 45 08             	mov    0x8(%ebp),%eax
    24d5:	01 d0                	add    %edx,%eax
    24d7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24da:	88 10                	mov    %dl,(%eax)
    24dc:	e9 8d 01 00 00       	jmp    266e <sprintf+0x205>
            }
        } else if(state == '%'){
    24e1:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    24e5:	0f 85 83 01 00 00    	jne    266e <sprintf+0x205>
            if(c == 'd'){
    24eb:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    24ef:	75 4c                	jne    253d <sprintf+0xd4>
                buf[bi] = '\0';
    24f1:	8d 55 ce             	lea    -0x32(%ebp),%edx
    24f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24f7:	01 d0                	add    %edx,%eax
    24f9:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    24fc:	83 ec 0c             	sub    $0xc,%esp
    24ff:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2502:	50                   	push   %eax
    2503:	e8 0f de ff ff       	call   317 <atoi>
    2508:	83 c4 10             	add    $0x10,%esp
    250b:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    250e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2515:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2518:	8b 00                	mov    (%eax),%eax
    251a:	83 ec 08             	sub    $0x8,%esp
    251d:	ff 75 d8             	pushl  -0x28(%ebp)
    2520:	6a 01                	push   $0x1
    2522:	6a 0a                	push   $0xa
    2524:	50                   	push   %eax
    2525:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2528:	50                   	push   %eax
    2529:	ff 75 08             	pushl  0x8(%ebp)
    252c:	e8 56 fe ff ff       	call   2387 <sprintint>
    2531:	83 c4 20             	add    $0x20,%esp
                ap++;
    2534:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2538:	e9 2a 01 00 00       	jmp    2667 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    253d:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2541:	74 06                	je     2549 <sprintf+0xe0>
    2543:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2547:	75 4c                	jne    2595 <sprintf+0x12c>
                buf[bi] = '\0';
    2549:	8d 55 ce             	lea    -0x32(%ebp),%edx
    254c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    254f:	01 d0                	add    %edx,%eax
    2551:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2554:	83 ec 0c             	sub    $0xc,%esp
    2557:	8d 45 ce             	lea    -0x32(%ebp),%eax
    255a:	50                   	push   %eax
    255b:	e8 b7 dd ff ff       	call   317 <atoi>
    2560:	83 c4 10             	add    $0x10,%esp
    2563:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2566:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    256d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2570:	8b 00                	mov    (%eax),%eax
    2572:	83 ec 08             	sub    $0x8,%esp
    2575:	ff 75 dc             	pushl  -0x24(%ebp)
    2578:	6a 00                	push   $0x0
    257a:	6a 10                	push   $0x10
    257c:	50                   	push   %eax
    257d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2580:	50                   	push   %eax
    2581:	ff 75 08             	pushl  0x8(%ebp)
    2584:	e8 fe fd ff ff       	call   2387 <sprintint>
    2589:	83 c4 20             	add    $0x20,%esp
                ap++;
    258c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2590:	e9 d2 00 00 00       	jmp    2667 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2595:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2599:	75 46                	jne    25e1 <sprintf+0x178>
                s = (char*)*ap;
    259b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    259e:	8b 00                	mov    (%eax),%eax
    25a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    25a3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    25a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    25ab:	75 25                	jne    25d2 <sprintf+0x169>
                    s = "(null)";
    25ad:	c7 45 f4 60 28 00 00 	movl   $0x2860,-0xc(%ebp)
                while(*s != 0){
    25b4:	eb 1c                	jmp    25d2 <sprintf+0x169>
                    dst[j++] = *s;
    25b6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25b9:	8d 50 01             	lea    0x1(%eax),%edx
    25bc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25bf:	89 c2                	mov    %eax,%edx
    25c1:	8b 45 08             	mov    0x8(%ebp),%eax
    25c4:	01 c2                	add    %eax,%edx
    25c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25c9:	0f b6 00             	movzbl (%eax),%eax
    25cc:	88 02                	mov    %al,(%edx)
                    s++;
    25ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    25d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25d5:	0f b6 00             	movzbl (%eax),%eax
    25d8:	84 c0                	test   %al,%al
    25da:	75 da                	jne    25b6 <sprintf+0x14d>
    25dc:	e9 86 00 00 00       	jmp    2667 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    25e1:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    25e5:	75 1d                	jne    2604 <sprintf+0x19b>
                dst[j++] = *ap;
    25e7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25ea:	8d 50 01             	lea    0x1(%eax),%edx
    25ed:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25f0:	89 c2                	mov    %eax,%edx
    25f2:	8b 45 08             	mov    0x8(%ebp),%eax
    25f5:	01 c2                	add    %eax,%edx
    25f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25fa:	8b 00                	mov    (%eax),%eax
    25fc:	88 02                	mov    %al,(%edx)
                ap++;
    25fe:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2602:	eb 63                	jmp    2667 <sprintf+0x1fe>
            } else if(c == '%'){
    2604:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2608:	75 17                	jne    2621 <sprintf+0x1b8>
                dst[j++] = c;
    260a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    260d:	8d 50 01             	lea    0x1(%eax),%edx
    2610:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2613:	89 c2                	mov    %eax,%edx
    2615:	8b 45 08             	mov    0x8(%ebp),%eax
    2618:	01 d0                	add    %edx,%eax
    261a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    261d:	88 10                	mov    %dl,(%eax)
    261f:	eb 46                	jmp    2667 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2621:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2625:	7e 18                	jle    263f <sprintf+0x1d6>
    2627:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    262b:	7f 12                	jg     263f <sprintf+0x1d6>
            {
                buf[bi++] = c;
    262d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2630:	8d 50 01             	lea    0x1(%eax),%edx
    2633:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2636:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2639:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    263d:	eb 2f                	jmp    266e <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    263f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2642:	8d 50 01             	lea    0x1(%eax),%edx
    2645:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2648:	89 c2                	mov    %eax,%edx
    264a:	8b 45 08             	mov    0x8(%ebp),%eax
    264d:	01 d0                	add    %edx,%eax
    264f:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2652:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2655:	8d 50 01             	lea    0x1(%eax),%edx
    2658:	89 55 c8             	mov    %edx,-0x38(%ebp)
    265b:	89 c2                	mov    %eax,%edx
    265d:	8b 45 08             	mov    0x8(%ebp),%eax
    2660:	01 d0                	add    %edx,%eax
    2662:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2665:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2667:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    266e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2672:	8b 55 0c             	mov    0xc(%ebp),%edx
    2675:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2678:	01 d0                	add    %edx,%eax
    267a:	0f b6 00             	movzbl (%eax),%eax
    267d:	84 c0                	test   %al,%al
    267f:	0f 85 14 fe ff ff    	jne    2499 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2685:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2688:	8d 50 01             	lea    0x1(%eax),%edx
    268b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    268e:	89 c2                	mov    %eax,%edx
    2690:	8b 45 08             	mov    0x8(%ebp),%eax
    2693:	01 d0                	add    %edx,%eax
    2695:	c6 00 00             	movb   $0x0,(%eax)
}
    2698:	90                   	nop
    2699:	c9                   	leave  
    269a:	c3                   	ret    
