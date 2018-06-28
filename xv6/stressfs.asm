
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
      2b:	68 8c 21 00 00       	push   $0x218c
      30:	6a 01                	push   $0x1
      32:	e8 11 05 00 00       	call   548 <printf>
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
      78:	68 9f 21 00 00       	push   $0x219f
      7d:	6a 01                	push   $0x1
      7f:	e8 c4 04 00 00       	call   548 <printf>
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
      ea:	68 a9 21 00 00       	push   $0x21a9
      ef:	6a 01                	push   $0x1
      f1:	e8 52 04 00 00       	call   548 <printf>
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

00000451 <initStringFigure>:
SYSCALL(initStringFigure)
     451:	b8 17 00 00 00       	mov    $0x17,%eax
     456:	cd 40                	int    $0x40
     458:	c3                   	ret    

00000459 <sendMessage>:
SYSCALL(sendMessage)
     459:	b8 18 00 00 00       	mov    $0x18,%eax
     45e:	cd 40                	int    $0x40
     460:	c3                   	ret    

00000461 <getMessage>:
SYSCALL(getMessage)
     461:	b8 1a 00 00 00       	mov    $0x1a,%eax
     466:	cd 40                	int    $0x40
     468:	c3                   	ret    

00000469 <registWindow>:
SYSCALL(registWindow)
     469:	b8 19 00 00 00       	mov    $0x19,%eax
     46e:	cd 40                	int    $0x40
     470:	c3                   	ret    

00000471 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     471:	55                   	push   %ebp
     472:	89 e5                	mov    %esp,%ebp
     474:	83 ec 18             	sub    $0x18,%esp
     477:	8b 45 0c             	mov    0xc(%ebp),%eax
     47a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     47d:	83 ec 04             	sub    $0x4,%esp
     480:	6a 01                	push   $0x1
     482:	8d 45 f4             	lea    -0xc(%ebp),%eax
     485:	50                   	push   %eax
     486:	ff 75 08             	pushl  0x8(%ebp)
     489:	e8 3b ff ff ff       	call   3c9 <write>
     48e:	83 c4 10             	add    $0x10,%esp
}
     491:	90                   	nop
     492:	c9                   	leave  
     493:	c3                   	ret    

00000494 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     494:	55                   	push   %ebp
     495:	89 e5                	mov    %esp,%ebp
     497:	53                   	push   %ebx
     498:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     49b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     4a2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     4a6:	74 17                	je     4bf <printint+0x2b>
     4a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4ac:	79 11                	jns    4bf <printint+0x2b>
    neg = 1;
     4ae:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     4b5:	8b 45 0c             	mov    0xc(%ebp),%eax
     4b8:	f7 d8                	neg    %eax
     4ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4bd:	eb 06                	jmp    4c5 <printint+0x31>
  } else {
    x = xx;
     4bf:	8b 45 0c             	mov    0xc(%ebp),%eax
     4c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4cc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4cf:	8d 41 01             	lea    0x1(%ecx),%eax
     4d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4db:	ba 00 00 00 00       	mov    $0x0,%edx
     4e0:	f7 f3                	div    %ebx
     4e2:	89 d0                	mov    %edx,%eax
     4e4:	0f b6 80 38 28 00 00 	movzbl 0x2838(%eax),%eax
     4eb:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4ef:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4f5:	ba 00 00 00 00       	mov    $0x0,%edx
     4fa:	f7 f3                	div    %ebx
     4fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     503:	75 c7                	jne    4cc <printint+0x38>
  if(neg)
     505:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     509:	74 2d                	je     538 <printint+0xa4>
    buf[i++] = '-';
     50b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     50e:	8d 50 01             	lea    0x1(%eax),%edx
     511:	89 55 f4             	mov    %edx,-0xc(%ebp)
     514:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     519:	eb 1d                	jmp    538 <printint+0xa4>
    putc(fd, buf[i]);
     51b:	8d 55 dc             	lea    -0x24(%ebp),%edx
     51e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     521:	01 d0                	add    %edx,%eax
     523:	0f b6 00             	movzbl (%eax),%eax
     526:	0f be c0             	movsbl %al,%eax
     529:	83 ec 08             	sub    $0x8,%esp
     52c:	50                   	push   %eax
     52d:	ff 75 08             	pushl  0x8(%ebp)
     530:	e8 3c ff ff ff       	call   471 <putc>
     535:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     538:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     53c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     540:	79 d9                	jns    51b <printint+0x87>
    putc(fd, buf[i]);
}
     542:	90                   	nop
     543:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     546:	c9                   	leave  
     547:	c3                   	ret    

00000548 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     548:	55                   	push   %ebp
     549:	89 e5                	mov    %esp,%ebp
     54b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     54e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     555:	8d 45 0c             	lea    0xc(%ebp),%eax
     558:	83 c0 04             	add    $0x4,%eax
     55b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     55e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     565:	e9 59 01 00 00       	jmp    6c3 <printf+0x17b>
    c = fmt[i] & 0xff;
     56a:	8b 55 0c             	mov    0xc(%ebp),%edx
     56d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     570:	01 d0                	add    %edx,%eax
     572:	0f b6 00             	movzbl (%eax),%eax
     575:	0f be c0             	movsbl %al,%eax
     578:	25 ff 00 00 00       	and    $0xff,%eax
     57d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     580:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     584:	75 2c                	jne    5b2 <printf+0x6a>
      if(c == '%'){
     586:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     58a:	75 0c                	jne    598 <printf+0x50>
        state = '%';
     58c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     593:	e9 27 01 00 00       	jmp    6bf <printf+0x177>
      } else {
        putc(fd, c);
     598:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     59b:	0f be c0             	movsbl %al,%eax
     59e:	83 ec 08             	sub    $0x8,%esp
     5a1:	50                   	push   %eax
     5a2:	ff 75 08             	pushl  0x8(%ebp)
     5a5:	e8 c7 fe ff ff       	call   471 <putc>
     5aa:	83 c4 10             	add    $0x10,%esp
     5ad:	e9 0d 01 00 00       	jmp    6bf <printf+0x177>
      }
    } else if(state == '%'){
     5b2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     5b6:	0f 85 03 01 00 00    	jne    6bf <printf+0x177>
      if(c == 'd'){
     5bc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5c0:	75 1e                	jne    5e0 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5c5:	8b 00                	mov    (%eax),%eax
     5c7:	6a 01                	push   $0x1
     5c9:	6a 0a                	push   $0xa
     5cb:	50                   	push   %eax
     5cc:	ff 75 08             	pushl  0x8(%ebp)
     5cf:	e8 c0 fe ff ff       	call   494 <printint>
     5d4:	83 c4 10             	add    $0x10,%esp
        ap++;
     5d7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5db:	e9 d8 00 00 00       	jmp    6b8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5e0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5e4:	74 06                	je     5ec <printf+0xa4>
     5e6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5ea:	75 1e                	jne    60a <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ef:	8b 00                	mov    (%eax),%eax
     5f1:	6a 00                	push   $0x0
     5f3:	6a 10                	push   $0x10
     5f5:	50                   	push   %eax
     5f6:	ff 75 08             	pushl  0x8(%ebp)
     5f9:	e8 96 fe ff ff       	call   494 <printint>
     5fe:	83 c4 10             	add    $0x10,%esp
        ap++;
     601:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     605:	e9 ae 00 00 00       	jmp    6b8 <printf+0x170>
      } else if(c == 's'){
     60a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     60e:	75 43                	jne    653 <printf+0x10b>
        s = (char*)*ap;
     610:	8b 45 e8             	mov    -0x18(%ebp),%eax
     613:	8b 00                	mov    (%eax),%eax
     615:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     618:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     61c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     620:	75 25                	jne    647 <printf+0xff>
          s = "(null)";
     622:	c7 45 f4 af 21 00 00 	movl   $0x21af,-0xc(%ebp)
        while(*s != 0){
     629:	eb 1c                	jmp    647 <printf+0xff>
          putc(fd, *s);
     62b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     62e:	0f b6 00             	movzbl (%eax),%eax
     631:	0f be c0             	movsbl %al,%eax
     634:	83 ec 08             	sub    $0x8,%esp
     637:	50                   	push   %eax
     638:	ff 75 08             	pushl  0x8(%ebp)
     63b:	e8 31 fe ff ff       	call   471 <putc>
     640:	83 c4 10             	add    $0x10,%esp
          s++;
     643:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     647:	8b 45 f4             	mov    -0xc(%ebp),%eax
     64a:	0f b6 00             	movzbl (%eax),%eax
     64d:	84 c0                	test   %al,%al
     64f:	75 da                	jne    62b <printf+0xe3>
     651:	eb 65                	jmp    6b8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     653:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     657:	75 1d                	jne    676 <printf+0x12e>
        putc(fd, *ap);
     659:	8b 45 e8             	mov    -0x18(%ebp),%eax
     65c:	8b 00                	mov    (%eax),%eax
     65e:	0f be c0             	movsbl %al,%eax
     661:	83 ec 08             	sub    $0x8,%esp
     664:	50                   	push   %eax
     665:	ff 75 08             	pushl  0x8(%ebp)
     668:	e8 04 fe ff ff       	call   471 <putc>
     66d:	83 c4 10             	add    $0x10,%esp
        ap++;
     670:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     674:	eb 42                	jmp    6b8 <printf+0x170>
      } else if(c == '%'){
     676:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     67a:	75 17                	jne    693 <printf+0x14b>
        putc(fd, c);
     67c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     67f:	0f be c0             	movsbl %al,%eax
     682:	83 ec 08             	sub    $0x8,%esp
     685:	50                   	push   %eax
     686:	ff 75 08             	pushl  0x8(%ebp)
     689:	e8 e3 fd ff ff       	call   471 <putc>
     68e:	83 c4 10             	add    $0x10,%esp
     691:	eb 25                	jmp    6b8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     693:	83 ec 08             	sub    $0x8,%esp
     696:	6a 25                	push   $0x25
     698:	ff 75 08             	pushl  0x8(%ebp)
     69b:	e8 d1 fd ff ff       	call   471 <putc>
     6a0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     6a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6a6:	0f be c0             	movsbl %al,%eax
     6a9:	83 ec 08             	sub    $0x8,%esp
     6ac:	50                   	push   %eax
     6ad:	ff 75 08             	pushl  0x8(%ebp)
     6b0:	e8 bc fd ff ff       	call   471 <putc>
     6b5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     6b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6bf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6c3:	8b 55 0c             	mov    0xc(%ebp),%edx
     6c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6c9:	01 d0                	add    %edx,%eax
     6cb:	0f b6 00             	movzbl (%eax),%eax
     6ce:	84 c0                	test   %al,%al
     6d0:	0f 85 94 fe ff ff    	jne    56a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6d6:	90                   	nop
     6d7:	c9                   	leave  
     6d8:	c3                   	ret    

000006d9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6d9:	55                   	push   %ebp
     6da:	89 e5                	mov    %esp,%ebp
     6dc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6df:	8b 45 08             	mov    0x8(%ebp),%eax
     6e2:	83 e8 08             	sub    $0x8,%eax
     6e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6e8:	a1 68 28 00 00       	mov    0x2868,%eax
     6ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6f0:	eb 24                	jmp    716 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f5:	8b 00                	mov    (%eax),%eax
     6f7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6fa:	77 12                	ja     70e <free+0x35>
     6fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     702:	77 24                	ja     728 <free+0x4f>
     704:	8b 45 fc             	mov    -0x4(%ebp),%eax
     707:	8b 00                	mov    (%eax),%eax
     709:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     70c:	77 1a                	ja     728 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     711:	8b 00                	mov    (%eax),%eax
     713:	89 45 fc             	mov    %eax,-0x4(%ebp)
     716:	8b 45 f8             	mov    -0x8(%ebp),%eax
     719:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     71c:	76 d4                	jbe    6f2 <free+0x19>
     71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     721:	8b 00                	mov    (%eax),%eax
     723:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     726:	76 ca                	jbe    6f2 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     728:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72b:	8b 40 04             	mov    0x4(%eax),%eax
     72e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     735:	8b 45 f8             	mov    -0x8(%ebp),%eax
     738:	01 c2                	add    %eax,%edx
     73a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73d:	8b 00                	mov    (%eax),%eax
     73f:	39 c2                	cmp    %eax,%edx
     741:	75 24                	jne    767 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     743:	8b 45 f8             	mov    -0x8(%ebp),%eax
     746:	8b 50 04             	mov    0x4(%eax),%edx
     749:	8b 45 fc             	mov    -0x4(%ebp),%eax
     74c:	8b 00                	mov    (%eax),%eax
     74e:	8b 40 04             	mov    0x4(%eax),%eax
     751:	01 c2                	add    %eax,%edx
     753:	8b 45 f8             	mov    -0x8(%ebp),%eax
     756:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     759:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75c:	8b 00                	mov    (%eax),%eax
     75e:	8b 10                	mov    (%eax),%edx
     760:	8b 45 f8             	mov    -0x8(%ebp),%eax
     763:	89 10                	mov    %edx,(%eax)
     765:	eb 0a                	jmp    771 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     767:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76a:	8b 10                	mov    (%eax),%edx
     76c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     771:	8b 45 fc             	mov    -0x4(%ebp),%eax
     774:	8b 40 04             	mov    0x4(%eax),%eax
     777:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     77e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     781:	01 d0                	add    %edx,%eax
     783:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     786:	75 20                	jne    7a8 <free+0xcf>
    p->s.size += bp->s.size;
     788:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78b:	8b 50 04             	mov    0x4(%eax),%edx
     78e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     791:	8b 40 04             	mov    0x4(%eax),%eax
     794:	01 c2                	add    %eax,%edx
     796:	8b 45 fc             	mov    -0x4(%ebp),%eax
     799:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     79c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     79f:	8b 10                	mov    (%eax),%edx
     7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a4:	89 10                	mov    %edx,(%eax)
     7a6:	eb 08                	jmp    7b0 <free+0xd7>
  } else
    p->s.ptr = bp;
     7a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7ae:	89 10                	mov    %edx,(%eax)
  freep = p;
     7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b3:	a3 68 28 00 00       	mov    %eax,0x2868
}
     7b8:	90                   	nop
     7b9:	c9                   	leave  
     7ba:	c3                   	ret    

000007bb <morecore>:

static Header*
morecore(uint nu)
{
     7bb:	55                   	push   %ebp
     7bc:	89 e5                	mov    %esp,%ebp
     7be:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7c1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7c8:	77 07                	ja     7d1 <morecore+0x16>
    nu = 4096;
     7ca:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7d1:	8b 45 08             	mov    0x8(%ebp),%eax
     7d4:	c1 e0 03             	shl    $0x3,%eax
     7d7:	83 ec 0c             	sub    $0xc,%esp
     7da:	50                   	push   %eax
     7db:	e8 51 fc ff ff       	call   431 <sbrk>
     7e0:	83 c4 10             	add    $0x10,%esp
     7e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7e6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7ea:	75 07                	jne    7f3 <morecore+0x38>
    return 0;
     7ec:	b8 00 00 00 00       	mov    $0x0,%eax
     7f1:	eb 26                	jmp    819 <morecore+0x5e>
  hp = (Header*)p;
     7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7fc:	8b 55 08             	mov    0x8(%ebp),%edx
     7ff:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     802:	8b 45 f0             	mov    -0x10(%ebp),%eax
     805:	83 c0 08             	add    $0x8,%eax
     808:	83 ec 0c             	sub    $0xc,%esp
     80b:	50                   	push   %eax
     80c:	e8 c8 fe ff ff       	call   6d9 <free>
     811:	83 c4 10             	add    $0x10,%esp
  return freep;
     814:	a1 68 28 00 00       	mov    0x2868,%eax
}
     819:	c9                   	leave  
     81a:	c3                   	ret    

0000081b <malloc>:

void*
malloc(uint nbytes)
{
     81b:	55                   	push   %ebp
     81c:	89 e5                	mov    %esp,%ebp
     81e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     821:	8b 45 08             	mov    0x8(%ebp),%eax
     824:	83 c0 07             	add    $0x7,%eax
     827:	c1 e8 03             	shr    $0x3,%eax
     82a:	83 c0 01             	add    $0x1,%eax
     82d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     830:	a1 68 28 00 00       	mov    0x2868,%eax
     835:	89 45 f0             	mov    %eax,-0x10(%ebp)
     838:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     83c:	75 23                	jne    861 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     83e:	c7 45 f0 60 28 00 00 	movl   $0x2860,-0x10(%ebp)
     845:	8b 45 f0             	mov    -0x10(%ebp),%eax
     848:	a3 68 28 00 00       	mov    %eax,0x2868
     84d:	a1 68 28 00 00       	mov    0x2868,%eax
     852:	a3 60 28 00 00       	mov    %eax,0x2860
    base.s.size = 0;
     857:	c7 05 64 28 00 00 00 	movl   $0x0,0x2864
     85e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     861:	8b 45 f0             	mov    -0x10(%ebp),%eax
     864:	8b 00                	mov    (%eax),%eax
     866:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     869:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86c:	8b 40 04             	mov    0x4(%eax),%eax
     86f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     872:	72 4d                	jb     8c1 <malloc+0xa6>
      if(p->s.size == nunits)
     874:	8b 45 f4             	mov    -0xc(%ebp),%eax
     877:	8b 40 04             	mov    0x4(%eax),%eax
     87a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     87d:	75 0c                	jne    88b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     87f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     882:	8b 10                	mov    (%eax),%edx
     884:	8b 45 f0             	mov    -0x10(%ebp),%eax
     887:	89 10                	mov    %edx,(%eax)
     889:	eb 26                	jmp    8b1 <malloc+0x96>
      else {
        p->s.size -= nunits;
     88b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88e:	8b 40 04             	mov    0x4(%eax),%eax
     891:	2b 45 ec             	sub    -0x14(%ebp),%eax
     894:	89 c2                	mov    %eax,%edx
     896:	8b 45 f4             	mov    -0xc(%ebp),%eax
     899:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     89c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89f:	8b 40 04             	mov    0x4(%eax),%eax
     8a2:	c1 e0 03             	shl    $0x3,%eax
     8a5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     8a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
     8ae:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     8b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8b4:	a3 68 28 00 00       	mov    %eax,0x2868
      return (void*)(p + 1);
     8b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bc:	83 c0 08             	add    $0x8,%eax
     8bf:	eb 3b                	jmp    8fc <malloc+0xe1>
    }
    if(p == freep)
     8c1:	a1 68 28 00 00       	mov    0x2868,%eax
     8c6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8c9:	75 1e                	jne    8e9 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8cb:	83 ec 0c             	sub    $0xc,%esp
     8ce:	ff 75 ec             	pushl  -0x14(%ebp)
     8d1:	e8 e5 fe ff ff       	call   7bb <morecore>
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8e0:	75 07                	jne    8e9 <malloc+0xce>
        return 0;
     8e2:	b8 00 00 00 00       	mov    $0x0,%eax
     8e7:	eb 13                	jmp    8fc <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f2:	8b 00                	mov    (%eax),%eax
     8f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8f7:	e9 6d ff ff ff       	jmp    869 <malloc+0x4e>
}
     8fc:	c9                   	leave  
     8fd:	c3                   	ret    

000008fe <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     8fe:	55                   	push   %ebp
     8ff:	89 e5                	mov    %esp,%ebp
     901:	83 ec 1c             	sub    $0x1c,%esp
     904:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     907:	8b 55 10             	mov    0x10(%ebp),%edx
     90a:	8b 45 14             	mov    0x14(%ebp),%eax
     90d:	88 4d ec             	mov    %cl,-0x14(%ebp)
     910:	88 55 e8             	mov    %dl,-0x18(%ebp)
     913:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     916:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     91a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     91d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     921:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     924:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     928:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     92b:	8b 45 08             	mov    0x8(%ebp),%eax
     92e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     932:	66 89 10             	mov    %dx,(%eax)
     935:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     939:	88 50 02             	mov    %dl,0x2(%eax)
}
     93c:	8b 45 08             	mov    0x8(%ebp),%eax
     93f:	c9                   	leave  
     940:	c2 04 00             	ret    $0x4

00000943 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     943:	55                   	push   %ebp
     944:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     946:	8b 45 08             	mov    0x8(%ebp),%eax
     949:	2b 45 10             	sub    0x10(%ebp),%eax
     94c:	89 c2                	mov    %eax,%edx
     94e:	8b 45 08             	mov    0x8(%ebp),%eax
     951:	2b 45 10             	sub    0x10(%ebp),%eax
     954:	0f af d0             	imul   %eax,%edx
     957:	8b 45 0c             	mov    0xc(%ebp),%eax
     95a:	2b 45 14             	sub    0x14(%ebp),%eax
     95d:	89 c1                	mov    %eax,%ecx
     95f:	8b 45 0c             	mov    0xc(%ebp),%eax
     962:	2b 45 14             	sub    0x14(%ebp),%eax
     965:	0f af c1             	imul   %ecx,%eax
     968:	01 d0                	add    %edx,%eax
}
     96a:	5d                   	pop    %ebp
     96b:	c3                   	ret    

0000096c <abs_int>:

static inline int abs_int(int x)
{
     96c:	55                   	push   %ebp
     96d:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     96f:	8b 45 08             	mov    0x8(%ebp),%eax
     972:	99                   	cltd   
     973:	89 d0                	mov    %edx,%eax
     975:	33 45 08             	xor    0x8(%ebp),%eax
     978:	29 d0                	sub    %edx,%eax
}
     97a:	5d                   	pop    %ebp
     97b:	c3                   	ret    

0000097c <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     97c:	55                   	push   %ebp
     97d:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     97f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     983:	79 07                	jns    98c <APGetIndex+0x10>
        return X_SMALLER;
     985:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     98a:	eb 40                	jmp    9cc <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     98c:	8b 45 08             	mov    0x8(%ebp),%eax
     98f:	8b 00                	mov    (%eax),%eax
     991:	3b 45 0c             	cmp    0xc(%ebp),%eax
     994:	7f 07                	jg     99d <APGetIndex+0x21>
        return X_BIGGER;
     996:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     99b:	eb 2f                	jmp    9cc <APGetIndex+0x50>
    if (y < 0)
     99d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     9a1:	79 07                	jns    9aa <APGetIndex+0x2e>
        return Y_SMALLER;
     9a3:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     9a8:	eb 22                	jmp    9cc <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     9aa:	8b 45 08             	mov    0x8(%ebp),%eax
     9ad:	8b 40 04             	mov    0x4(%eax),%eax
     9b0:	3b 45 10             	cmp    0x10(%ebp),%eax
     9b3:	7f 07                	jg     9bc <APGetIndex+0x40>
        return Y_BIGGER;
     9b5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     9ba:	eb 10                	jmp    9cc <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     9bc:	8b 45 08             	mov    0x8(%ebp),%eax
     9bf:	8b 00                	mov    (%eax),%eax
     9c1:	0f af 45 10          	imul   0x10(%ebp),%eax
     9c5:	89 c2                	mov    %eax,%edx
     9c7:	8b 45 0c             	mov    0xc(%ebp),%eax
     9ca:	01 d0                	add    %edx,%eax
}
     9cc:	5d                   	pop    %ebp
     9cd:	c3                   	ret    

000009ce <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     9ce:	55                   	push   %ebp
     9cf:	89 e5                	mov    %esp,%ebp
     9d1:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9d4:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9db:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9de:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9e1:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9e8:	83 ec 08             	sub    $0x8,%esp
     9eb:	6a 00                	push   $0x0
     9ed:	ff 75 0c             	pushl  0xc(%ebp)
     9f0:	e8 f4 f9 ff ff       	call   3e9 <open>
     9f5:	83 c4 10             	add    $0x10,%esp
     9f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     9ff:	79 2e                	jns    a2f <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a01:	83 ec 04             	sub    $0x4,%esp
     a04:	ff 75 0c             	pushl  0xc(%ebp)
     a07:	68 b6 21 00 00       	push   $0x21b6
     a0c:	6a 01                	push   $0x1
     a0e:	e8 35 fb ff ff       	call   548 <printf>
     a13:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a16:	8b 45 08             	mov    0x8(%ebp),%eax
     a19:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a1c:	89 10                	mov    %edx,(%eax)
     a1e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a21:	89 50 04             	mov    %edx,0x4(%eax)
     a24:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a27:	89 50 08             	mov    %edx,0x8(%eax)
     a2a:	e9 d2 01 00 00       	jmp    c01 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a2f:	83 ec 04             	sub    $0x4,%esp
     a32:	6a 0e                	push   $0xe
     a34:	8d 45 ba             	lea    -0x46(%ebp),%eax
     a37:	50                   	push   %eax
     a38:	ff 75 ec             	pushl  -0x14(%ebp)
     a3b:	e8 81 f9 ff ff       	call   3c1 <read>
     a40:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a43:	83 ec 04             	sub    $0x4,%esp
     a46:	6a 28                	push   $0x28
     a48:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a4b:	50                   	push   %eax
     a4c:	ff 75 ec             	pushl  -0x14(%ebp)
     a4f:	e8 6d f9 ff ff       	call   3c1 <read>
     a54:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a57:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a5a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a5d:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a60:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a63:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a66:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a69:	0f af d0             	imul   %eax,%edx
     a6c:	89 d0                	mov    %edx,%eax
     a6e:	01 c0                	add    %eax,%eax
     a70:	01 d0                	add    %edx,%eax
     a72:	83 ec 0c             	sub    $0xc,%esp
     a75:	50                   	push   %eax
     a76:	e8 a0 fd ff ff       	call   81b <malloc>
     a7b:	83 c4 10             	add    $0x10,%esp
     a7e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a81:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a85:	0f b7 c0             	movzwl %ax,%eax
     a88:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a8b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a91:	0f af c2             	imul   %edx,%eax
     a94:	83 c0 1f             	add    $0x1f,%eax
     a97:	c1 e8 05             	shr    $0x5,%eax
     a9a:	c1 e0 02             	shl    $0x2,%eax
     a9d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     aa0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aa3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     aa6:	0f af c2             	imul   %edx,%eax
     aa9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     aac:	8b 45 e0             	mov    -0x20(%ebp),%eax
     aaf:	83 ec 0c             	sub    $0xc,%esp
     ab2:	50                   	push   %eax
     ab3:	e8 63 fd ff ff       	call   81b <malloc>
     ab8:	83 c4 10             	add    $0x10,%esp
     abb:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     abe:	83 ec 04             	sub    $0x4,%esp
     ac1:	ff 75 e0             	pushl  -0x20(%ebp)
     ac4:	ff 75 dc             	pushl  -0x24(%ebp)
     ac7:	ff 75 ec             	pushl  -0x14(%ebp)
     aca:	e8 f2 f8 ff ff       	call   3c1 <read>
     acf:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     ad2:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     ad6:	66 c1 e8 03          	shr    $0x3,%ax
     ada:	0f b7 c0             	movzwl %ax,%eax
     add:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     ae0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ae7:	e9 e5 00 00 00       	jmp    bd1 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     aec:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af2:	29 c2                	sub    %eax,%edx
     af4:	89 d0                	mov    %edx,%eax
     af6:	8d 50 ff             	lea    -0x1(%eax),%edx
     af9:	8b 45 c8             	mov    -0x38(%ebp),%eax
     afc:	0f af c2             	imul   %edx,%eax
     aff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b02:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b09:	e9 b1 00 00 00       	jmp    bbf <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b0e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b11:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b14:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b17:	01 c8                	add    %ecx,%eax
     b19:	89 c1                	mov    %eax,%ecx
     b1b:	89 c8                	mov    %ecx,%eax
     b1d:	01 c0                	add    %eax,%eax
     b1f:	01 c8                	add    %ecx,%eax
     b21:	01 c2                	add    %eax,%edx
     b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b26:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b2a:	89 c1                	mov    %eax,%ecx
     b2c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b2f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b33:	01 c1                	add    %eax,%ecx
     b35:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b38:	01 c8                	add    %ecx,%eax
     b3a:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b3d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b40:	01 c8                	add    %ecx,%eax
     b42:	0f b6 00             	movzbl (%eax),%eax
     b45:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b48:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b4b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b51:	01 c8                	add    %ecx,%eax
     b53:	89 c1                	mov    %eax,%ecx
     b55:	89 c8                	mov    %ecx,%eax
     b57:	01 c0                	add    %eax,%eax
     b59:	01 c8                	add    %ecx,%eax
     b5b:	01 c2                	add    %eax,%edx
     b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b60:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b64:	89 c1                	mov    %eax,%ecx
     b66:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b69:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b6d:	01 c1                	add    %eax,%ecx
     b6f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b72:	01 c8                	add    %ecx,%eax
     b74:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b77:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b7a:	01 c8                	add    %ecx,%eax
     b7c:	0f b6 00             	movzbl (%eax),%eax
     b7f:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b82:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b85:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b8b:	01 c8                	add    %ecx,%eax
     b8d:	89 c1                	mov    %eax,%ecx
     b8f:	89 c8                	mov    %ecx,%eax
     b91:	01 c0                	add    %eax,%eax
     b93:	01 c8                	add    %ecx,%eax
     b95:	01 c2                	add    %eax,%edx
     b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b9a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b9e:	89 c1                	mov    %eax,%ecx
     ba0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ba3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     ba7:	01 c1                	add    %eax,%ecx
     ba9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bac:	01 c8                	add    %ecx,%eax
     bae:	8d 48 fd             	lea    -0x3(%eax),%ecx
     bb1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bb4:	01 c8                	add    %ecx,%eax
     bb6:	0f b6 00             	movzbl (%eax),%eax
     bb9:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     bbb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bbf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc5:	39 c2                	cmp    %eax,%edx
     bc7:	0f 87 41 ff ff ff    	ja     b0e <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     bcd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bd1:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd7:	39 c2                	cmp    %eax,%edx
     bd9:	0f 87 0d ff ff ff    	ja     aec <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     bdf:	83 ec 0c             	sub    $0xc,%esp
     be2:	ff 75 ec             	pushl  -0x14(%ebp)
     be5:	e8 e7 f7 ff ff       	call   3d1 <close>
     bea:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bed:	8b 45 08             	mov    0x8(%ebp),%eax
     bf0:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bf3:	89 10                	mov    %edx,(%eax)
     bf5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bf8:	89 50 04             	mov    %edx,0x4(%eax)
     bfb:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bfe:	89 50 08             	mov    %edx,0x8(%eax)
}
     c01:	8b 45 08             	mov    0x8(%ebp),%eax
     c04:	c9                   	leave  
     c05:	c2 04 00             	ret    $0x4

00000c08 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c08:	55                   	push   %ebp
     c09:	89 e5                	mov    %esp,%ebp
     c0b:	53                   	push   %ebx
     c0c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c0f:	83 ec 0c             	sub    $0xc,%esp
     c12:	6a 1c                	push   $0x1c
     c14:	e8 02 fc ff ff       	call   81b <malloc>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c22:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c29:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c2c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c2f:	6a 0c                	push   $0xc
     c31:	6a 0c                	push   $0xc
     c33:	6a 0c                	push   $0xc
     c35:	50                   	push   %eax
     c36:	e8 c3 fc ff ff       	call   8fe <RGB>
     c3b:	83 c4 0c             	add    $0xc,%esp
     c3e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c42:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c46:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c4a:	88 43 15             	mov    %al,0x15(%ebx)
     c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c50:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c53:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c57:	66 89 48 10          	mov    %cx,0x10(%eax)
     c5b:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c5f:	88 50 12             	mov    %dl,0x12(%eax)
     c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c65:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c68:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c6c:	66 89 48 08          	mov    %cx,0x8(%eax)
     c70:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c74:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c77:	8b 45 08             	mov    0x8(%ebp),%eax
     c7a:	89 c2                	mov    %eax,%edx
     c7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c7f:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c81:	8b 45 0c             	mov    0xc(%ebp),%eax
     c84:	89 c2                	mov    %eax,%edx
     c86:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c89:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c8c:	8b 55 10             	mov    0x10(%ebp),%edx
     c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c92:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c95:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c98:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c9b:	c9                   	leave  
     c9c:	c3                   	ret    

00000c9d <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     c9d:	55                   	push   %ebp
     c9e:	89 e5                	mov    %esp,%ebp
     ca0:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     ca3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ca6:	8b 50 08             	mov    0x8(%eax),%edx
     ca9:	89 55 f8             	mov    %edx,-0x8(%ebp)
     cac:	8b 40 0c             	mov    0xc(%eax),%eax
     caf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb5:	8b 55 10             	mov    0x10(%ebp),%edx
     cb8:	89 50 08             	mov    %edx,0x8(%eax)
     cbb:	8b 55 14             	mov    0x14(%ebp),%edx
     cbe:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     cc1:	8b 45 08             	mov    0x8(%ebp),%eax
     cc4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     cc7:	89 10                	mov    %edx,(%eax)
     cc9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ccc:	89 50 04             	mov    %edx,0x4(%eax)
}
     ccf:	8b 45 08             	mov    0x8(%ebp),%eax
     cd2:	c9                   	leave  
     cd3:	c2 04 00             	ret    $0x4

00000cd6 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     cd6:	55                   	push   %ebp
     cd7:	89 e5                	mov    %esp,%ebp
     cd9:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     cdc:	8b 45 0c             	mov    0xc(%ebp),%eax
     cdf:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ce3:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ce7:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ceb:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cee:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf1:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cf5:	66 89 50 10          	mov    %dx,0x10(%eax)
     cf9:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     cfd:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d00:	8b 45 08             	mov    0x8(%ebp),%eax
     d03:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d07:	66 89 10             	mov    %dx,(%eax)
     d0a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d0e:	88 50 02             	mov    %dl,0x2(%eax)
}
     d11:	8b 45 08             	mov    0x8(%ebp),%eax
     d14:	c9                   	leave  
     d15:	c2 04 00             	ret    $0x4

00000d18 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d18:	55                   	push   %ebp
     d19:	89 e5                	mov    %esp,%ebp
     d1b:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d1e:	8b 45 08             	mov    0x8(%ebp),%eax
     d21:	8b 40 0c             	mov    0xc(%eax),%eax
     d24:	89 c2                	mov    %eax,%edx
     d26:	c1 ea 1f             	shr    $0x1f,%edx
     d29:	01 d0                	add    %edx,%eax
     d2b:	d1 f8                	sar    %eax
     d2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d33:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d37:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d3a:	8b 45 10             	mov    0x10(%ebp),%eax
     d3d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d40:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d43:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d47:	0f 89 98 00 00 00    	jns    de5 <APDrawPoint+0xcd>
        i = 0;
     d4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d54:	e9 8c 00 00 00       	jmp    de5 <APDrawPoint+0xcd>
    {
        j = x - off;
     d59:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5c:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d62:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d66:	79 69                	jns    dd1 <APDrawPoint+0xb9>
            j = 0;
     d68:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d6f:	eb 60                	jmp    dd1 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d71:	ff 75 fc             	pushl  -0x4(%ebp)
     d74:	ff 75 f8             	pushl  -0x8(%ebp)
     d77:	ff 75 08             	pushl  0x8(%ebp)
     d7a:	e8 fd fb ff ff       	call   97c <APGetIndex>
     d7f:	83 c4 0c             	add    $0xc,%esp
     d82:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d85:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d89:	74 55                	je     de0 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d8b:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d8f:	74 67                	je     df8 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d91:	ff 75 10             	pushl  0x10(%ebp)
     d94:	ff 75 0c             	pushl  0xc(%ebp)
     d97:	ff 75 fc             	pushl  -0x4(%ebp)
     d9a:	ff 75 f8             	pushl  -0x8(%ebp)
     d9d:	e8 a1 fb ff ff       	call   943 <distance_2>
     da2:	83 c4 10             	add    $0x10,%esp
     da5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     da8:	7f 23                	jg     dcd <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     daa:	8b 45 08             	mov    0x8(%ebp),%eax
     dad:	8b 48 18             	mov    0x18(%eax),%ecx
     db0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     db3:	89 d0                	mov    %edx,%eax
     db5:	01 c0                	add    %eax,%eax
     db7:	01 d0                	add    %edx,%eax
     db9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dbc:	8b 45 08             	mov    0x8(%ebp),%eax
     dbf:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dc3:	66 89 0a             	mov    %cx,(%edx)
     dc6:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     dca:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     dcd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     dd1:	8b 55 0c             	mov    0xc(%ebp),%edx
     dd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd7:	01 d0                	add    %edx,%eax
     dd9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     ddc:	7d 93                	jge    d71 <APDrawPoint+0x59>
     dde:	eb 01                	jmp    de1 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     de0:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     de1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     de5:	8b 55 10             	mov    0x10(%ebp),%edx
     de8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     deb:	01 d0                	add    %edx,%eax
     ded:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     df0:	0f 8d 63 ff ff ff    	jge    d59 <APDrawPoint+0x41>
     df6:	eb 01                	jmp    df9 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     df8:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     df9:	c9                   	leave  
     dfa:	c3                   	ret    

00000dfb <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     dfb:	55                   	push   %ebp
     dfc:	89 e5                	mov    %esp,%ebp
     dfe:	53                   	push   %ebx
     dff:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e02:	8b 45 0c             	mov    0xc(%ebp),%eax
     e05:	3b 45 14             	cmp    0x14(%ebp),%eax
     e08:	0f 85 80 00 00 00    	jne    e8e <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e0e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e12:	0f 88 9d 02 00 00    	js     10b5 <APDrawLine+0x2ba>
     e18:	8b 45 08             	mov    0x8(%ebp),%eax
     e1b:	8b 00                	mov    (%eax),%eax
     e1d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e20:	0f 8e 8f 02 00 00    	jle    10b5 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e26:	8b 45 10             	mov    0x10(%ebp),%eax
     e29:	3b 45 18             	cmp    0x18(%ebp),%eax
     e2c:	7e 12                	jle    e40 <APDrawLine+0x45>
        {
            int tmp = y2;
     e2e:	8b 45 18             	mov    0x18(%ebp),%eax
     e31:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e34:	8b 45 10             	mov    0x10(%ebp),%eax
     e37:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e3d:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e40:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e44:	79 07                	jns    e4d <APDrawLine+0x52>
     e46:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e4d:	8b 45 08             	mov    0x8(%ebp),%eax
     e50:	8b 40 04             	mov    0x4(%eax),%eax
     e53:	3b 45 18             	cmp    0x18(%ebp),%eax
     e56:	7d 0c                	jge    e64 <APDrawLine+0x69>
     e58:	8b 45 08             	mov    0x8(%ebp),%eax
     e5b:	8b 40 04             	mov    0x4(%eax),%eax
     e5e:	83 e8 01             	sub    $0x1,%eax
     e61:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e64:	8b 45 10             	mov    0x10(%ebp),%eax
     e67:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e6a:	eb 15                	jmp    e81 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e6c:	ff 75 f4             	pushl  -0xc(%ebp)
     e6f:	ff 75 0c             	pushl  0xc(%ebp)
     e72:	ff 75 08             	pushl  0x8(%ebp)
     e75:	e8 9e fe ff ff       	call   d18 <APDrawPoint>
     e7a:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e7d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e84:	3b 45 18             	cmp    0x18(%ebp),%eax
     e87:	7e e3                	jle    e6c <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e89:	e9 2b 02 00 00       	jmp    10b9 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e8e:	8b 45 10             	mov    0x10(%ebp),%eax
     e91:	3b 45 18             	cmp    0x18(%ebp),%eax
     e94:	75 7f                	jne    f15 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e9a:	0f 88 18 02 00 00    	js     10b8 <APDrawLine+0x2bd>
     ea0:	8b 45 08             	mov    0x8(%ebp),%eax
     ea3:	8b 40 04             	mov    0x4(%eax),%eax
     ea6:	3b 45 10             	cmp    0x10(%ebp),%eax
     ea9:	0f 8e 09 02 00 00    	jle    10b8 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb2:	3b 45 14             	cmp    0x14(%ebp),%eax
     eb5:	7e 12                	jle    ec9 <APDrawLine+0xce>
        {
            int tmp = x2;
     eb7:	8b 45 14             	mov    0x14(%ebp),%eax
     eba:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec0:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ec3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ec6:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ec9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ecd:	79 07                	jns    ed6 <APDrawLine+0xdb>
     ecf:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ed6:	8b 45 08             	mov    0x8(%ebp),%eax
     ed9:	8b 00                	mov    (%eax),%eax
     edb:	3b 45 14             	cmp    0x14(%ebp),%eax
     ede:	7d 0b                	jge    eeb <APDrawLine+0xf0>
     ee0:	8b 45 08             	mov    0x8(%ebp),%eax
     ee3:	8b 00                	mov    (%eax),%eax
     ee5:	83 e8 01             	sub    $0x1,%eax
     ee8:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
     eee:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ef1:	eb 15                	jmp    f08 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     ef3:	ff 75 10             	pushl  0x10(%ebp)
     ef6:	ff 75 f0             	pushl  -0x10(%ebp)
     ef9:	ff 75 08             	pushl  0x8(%ebp)
     efc:	e8 17 fe ff ff       	call   d18 <APDrawPoint>
     f01:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f04:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f08:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f0b:	3b 45 14             	cmp    0x14(%ebp),%eax
     f0e:	7e e3                	jle    ef3 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f10:	e9 a4 01 00 00       	jmp    10b9 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f15:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f1c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f23:	8b 45 0c             	mov    0xc(%ebp),%eax
     f26:	2b 45 14             	sub    0x14(%ebp),%eax
     f29:	50                   	push   %eax
     f2a:	e8 3d fa ff ff       	call   96c <abs_int>
     f2f:	83 c4 04             	add    $0x4,%esp
     f32:	89 c3                	mov    %eax,%ebx
     f34:	8b 45 10             	mov    0x10(%ebp),%eax
     f37:	2b 45 18             	sub    0x18(%ebp),%eax
     f3a:	50                   	push   %eax
     f3b:	e8 2c fa ff ff       	call   96c <abs_int>
     f40:	83 c4 04             	add    $0x4,%esp
     f43:	39 c3                	cmp    %eax,%ebx
     f45:	0f 8e b5 00 00 00    	jle    1000 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f4b:	8b 45 10             	mov    0x10(%ebp),%eax
     f4e:	2b 45 18             	sub    0x18(%ebp),%eax
     f51:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f54:	db 45 b0             	fildl  -0x50(%ebp)
     f57:	8b 45 0c             	mov    0xc(%ebp),%eax
     f5a:	2b 45 14             	sub    0x14(%ebp),%eax
     f5d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f60:	db 45 b0             	fildl  -0x50(%ebp)
     f63:	de f9                	fdivrp %st,%st(1)
     f65:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f68:	8b 45 14             	mov    0x14(%ebp),%eax
     f6b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f6e:	7e 0e                	jle    f7e <APDrawLine+0x183>
        {
            s = x1;
     f70:	8b 45 0c             	mov    0xc(%ebp),%eax
     f73:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f76:	8b 45 14             	mov    0x14(%ebp),%eax
     f79:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f7c:	eb 0c                	jmp    f8a <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f7e:	8b 45 14             	mov    0x14(%ebp),%eax
     f81:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f84:	8b 45 0c             	mov    0xc(%ebp),%eax
     f87:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f8a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f8e:	79 07                	jns    f97 <APDrawLine+0x19c>
     f90:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f97:	8b 45 08             	mov    0x8(%ebp),%eax
     f9a:	8b 00                	mov    (%eax),%eax
     f9c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     f9f:	7f 0b                	jg     fac <APDrawLine+0x1b1>
     fa1:	8b 45 08             	mov    0x8(%ebp),%eax
     fa4:	8b 00                	mov    (%eax),%eax
     fa6:	83 e8 01             	sub    $0x1,%eax
     fa9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fac:	8b 45 ec             	mov    -0x14(%ebp),%eax
     faf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fb2:	eb 3f                	jmp    ff3 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fb7:	2b 45 0c             	sub    0xc(%ebp),%eax
     fba:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fbd:	db 45 b0             	fildl  -0x50(%ebp)
     fc0:	dc 4d d0             	fmull  -0x30(%ebp)
     fc3:	db 45 10             	fildl  0x10(%ebp)
     fc6:	de c1                	faddp  %st,%st(1)
     fc8:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fcb:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fcf:	b4 0c                	mov    $0xc,%ah
     fd1:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fd5:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fd8:	db 5d cc             	fistpl -0x34(%ebp)
     fdb:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fde:	ff 75 cc             	pushl  -0x34(%ebp)
     fe1:	ff 75 e4             	pushl  -0x1c(%ebp)
     fe4:	ff 75 08             	pushl  0x8(%ebp)
     fe7:	e8 2c fd ff ff       	call   d18 <APDrawPoint>
     fec:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fef:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     ff3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ff6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ff9:	7e b9                	jle    fb4 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
     ffb:	e9 b9 00 00 00       	jmp    10b9 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1000:	8b 45 0c             	mov    0xc(%ebp),%eax
    1003:	2b 45 14             	sub    0x14(%ebp),%eax
    1006:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1009:	db 45 b0             	fildl  -0x50(%ebp)
    100c:	8b 45 10             	mov    0x10(%ebp),%eax
    100f:	2b 45 18             	sub    0x18(%ebp),%eax
    1012:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1015:	db 45 b0             	fildl  -0x50(%ebp)
    1018:	de f9                	fdivrp %st,%st(1)
    101a:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    101d:	8b 45 10             	mov    0x10(%ebp),%eax
    1020:	3b 45 18             	cmp    0x18(%ebp),%eax
    1023:	7e 0e                	jle    1033 <APDrawLine+0x238>
    {
        s = y2;
    1025:	8b 45 18             	mov    0x18(%ebp),%eax
    1028:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    102b:	8b 45 10             	mov    0x10(%ebp),%eax
    102e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1031:	eb 0c                	jmp    103f <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1033:	8b 45 10             	mov    0x10(%ebp),%eax
    1036:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1039:	8b 45 18             	mov    0x18(%ebp),%eax
    103c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    103f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1043:	79 07                	jns    104c <APDrawLine+0x251>
    1045:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    104c:	8b 45 08             	mov    0x8(%ebp),%eax
    104f:	8b 40 04             	mov    0x4(%eax),%eax
    1052:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1055:	7f 0c                	jg     1063 <APDrawLine+0x268>
    1057:	8b 45 08             	mov    0x8(%ebp),%eax
    105a:	8b 40 04             	mov    0x4(%eax),%eax
    105d:	83 e8 01             	sub    $0x1,%eax
    1060:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1063:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1066:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1069:	eb 3f                	jmp    10aa <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    106b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    106e:	2b 45 10             	sub    0x10(%ebp),%eax
    1071:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1074:	db 45 b0             	fildl  -0x50(%ebp)
    1077:	dc 4d c0             	fmull  -0x40(%ebp)
    107a:	db 45 0c             	fildl  0xc(%ebp)
    107d:	de c1                	faddp  %st,%st(1)
    107f:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1082:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1086:	b4 0c                	mov    $0xc,%ah
    1088:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    108c:	d9 6d b4             	fldcw  -0x4c(%ebp)
    108f:	db 5d bc             	fistpl -0x44(%ebp)
    1092:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1095:	ff 75 e0             	pushl  -0x20(%ebp)
    1098:	ff 75 bc             	pushl  -0x44(%ebp)
    109b:	ff 75 08             	pushl  0x8(%ebp)
    109e:	e8 75 fc ff ff       	call   d18 <APDrawPoint>
    10a3:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10a6:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10ad:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10b0:	7e b9                	jle    106b <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10b2:	90                   	nop
    10b3:	eb 04                	jmp    10b9 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10b5:	90                   	nop
    10b6:	eb 01                	jmp    10b9 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10b8:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10bc:	c9                   	leave  
    10bd:	c3                   	ret    

000010be <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10be:	55                   	push   %ebp
    10bf:	89 e5                	mov    %esp,%ebp
    10c1:	53                   	push   %ebx
    10c2:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10c5:	8b 55 10             	mov    0x10(%ebp),%edx
    10c8:	8b 45 18             	mov    0x18(%ebp),%eax
    10cb:	01 d0                	add    %edx,%eax
    10cd:	83 e8 01             	sub    $0x1,%eax
    10d0:	83 ec 04             	sub    $0x4,%esp
    10d3:	50                   	push   %eax
    10d4:	ff 75 0c             	pushl  0xc(%ebp)
    10d7:	ff 75 10             	pushl  0x10(%ebp)
    10da:	ff 75 0c             	pushl  0xc(%ebp)
    10dd:	ff 75 08             	pushl  0x8(%ebp)
    10e0:	e8 16 fd ff ff       	call   dfb <APDrawLine>
    10e5:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    10eb:	8b 45 14             	mov    0x14(%ebp),%eax
    10ee:	01 d0                	add    %edx,%eax
    10f0:	83 e8 01             	sub    $0x1,%eax
    10f3:	83 ec 04             	sub    $0x4,%esp
    10f6:	ff 75 10             	pushl  0x10(%ebp)
    10f9:	50                   	push   %eax
    10fa:	ff 75 10             	pushl  0x10(%ebp)
    10fd:	ff 75 0c             	pushl  0xc(%ebp)
    1100:	ff 75 08             	pushl  0x8(%ebp)
    1103:	e8 f3 fc ff ff       	call   dfb <APDrawLine>
    1108:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    110b:	8b 55 10             	mov    0x10(%ebp),%edx
    110e:	8b 45 18             	mov    0x18(%ebp),%eax
    1111:	01 d0                	add    %edx,%eax
    1113:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1116:	8b 55 0c             	mov    0xc(%ebp),%edx
    1119:	8b 45 14             	mov    0x14(%ebp),%eax
    111c:	01 d0                	add    %edx,%eax
    111e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1121:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1124:	8b 45 14             	mov    0x14(%ebp),%eax
    1127:	01 d8                	add    %ebx,%eax
    1129:	83 e8 01             	sub    $0x1,%eax
    112c:	83 ec 04             	sub    $0x4,%esp
    112f:	51                   	push   %ecx
    1130:	52                   	push   %edx
    1131:	ff 75 10             	pushl  0x10(%ebp)
    1134:	50                   	push   %eax
    1135:	ff 75 08             	pushl  0x8(%ebp)
    1138:	e8 be fc ff ff       	call   dfb <APDrawLine>
    113d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1140:	8b 55 10             	mov    0x10(%ebp),%edx
    1143:	8b 45 18             	mov    0x18(%ebp),%eax
    1146:	01 d0                	add    %edx,%eax
    1148:	8d 48 ff             	lea    -0x1(%eax),%ecx
    114b:	8b 55 0c             	mov    0xc(%ebp),%edx
    114e:	8b 45 14             	mov    0x14(%ebp),%eax
    1151:	01 d0                	add    %edx,%eax
    1153:	8d 50 ff             	lea    -0x1(%eax),%edx
    1156:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1159:	8b 45 18             	mov    0x18(%ebp),%eax
    115c:	01 d8                	add    %ebx,%eax
    115e:	83 e8 01             	sub    $0x1,%eax
    1161:	83 ec 04             	sub    $0x4,%esp
    1164:	51                   	push   %ecx
    1165:	52                   	push   %edx
    1166:	50                   	push   %eax
    1167:	ff 75 0c             	pushl  0xc(%ebp)
    116a:	ff 75 08             	pushl  0x8(%ebp)
    116d:	e8 89 fc ff ff       	call   dfb <APDrawLine>
    1172:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1175:	8b 55 0c             	mov    0xc(%ebp),%edx
    1178:	8b 45 14             	mov    0x14(%ebp),%eax
    117b:	01 d0                	add    %edx,%eax
    117d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1180:	8b 45 08             	mov    0x8(%ebp),%eax
    1183:	8b 40 0c             	mov    0xc(%eax),%eax
    1186:	89 c1                	mov    %eax,%ecx
    1188:	c1 e9 1f             	shr    $0x1f,%ecx
    118b:	01 c8                	add    %ecx,%eax
    118d:	d1 f8                	sar    %eax
    118f:	29 c2                	sub    %eax,%edx
    1191:	89 d0                	mov    %edx,%eax
    1193:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1196:	8b 55 10             	mov    0x10(%ebp),%edx
    1199:	8b 45 18             	mov    0x18(%ebp),%eax
    119c:	01 d0                	add    %edx,%eax
    119e:	8d 50 ff             	lea    -0x1(%eax),%edx
    11a1:	8b 45 08             	mov    0x8(%ebp),%eax
    11a4:	8b 40 0c             	mov    0xc(%eax),%eax
    11a7:	89 c1                	mov    %eax,%ecx
    11a9:	c1 e9 1f             	shr    $0x1f,%ecx
    11ac:	01 c8                	add    %ecx,%eax
    11ae:	d1 f8                	sar    %eax
    11b0:	29 c2                	sub    %eax,%edx
    11b2:	89 d0                	mov    %edx,%eax
    11b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11b7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ba:	8b 40 0c             	mov    0xc(%eax),%eax
    11bd:	89 c2                	mov    %eax,%edx
    11bf:	c1 ea 1f             	shr    $0x1f,%edx
    11c2:	01 d0                	add    %edx,%eax
    11c4:	d1 f8                	sar    %eax
    11c6:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11c9:	8b 45 08             	mov    0x8(%ebp),%eax
    11cc:	8b 40 0c             	mov    0xc(%eax),%eax
    11cf:	89 c2                	mov    %eax,%edx
    11d1:	c1 ea 1f             	shr    $0x1f,%edx
    11d4:	01 d0                	add    %edx,%eax
    11d6:	d1 f8                	sar    %eax
    11d8:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11df:	0f 88 d8 00 00 00    	js     12bd <APDrawRect+0x1ff>
    11e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11e9:	0f 88 ce 00 00 00    	js     12bd <APDrawRect+0x1ff>
    11ef:	8b 45 08             	mov    0x8(%ebp),%eax
    11f2:	8b 00                	mov    (%eax),%eax
    11f4:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11f7:	0f 8e c0 00 00 00    	jle    12bd <APDrawRect+0x1ff>
    11fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1200:	8b 40 04             	mov    0x4(%eax),%eax
    1203:	3b 45 10             	cmp    0x10(%ebp),%eax
    1206:	0f 8e b1 00 00 00    	jle    12bd <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    120c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1210:	79 07                	jns    1219 <APDrawRect+0x15b>
    1212:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1219:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    121d:	79 07                	jns    1226 <APDrawRect+0x168>
    121f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1226:	8b 45 08             	mov    0x8(%ebp),%eax
    1229:	8b 00                	mov    (%eax),%eax
    122b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    122e:	7f 0b                	jg     123b <APDrawRect+0x17d>
    1230:	8b 45 08             	mov    0x8(%ebp),%eax
    1233:	8b 00                	mov    (%eax),%eax
    1235:	83 e8 01             	sub    $0x1,%eax
    1238:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    123b:	8b 45 08             	mov    0x8(%ebp),%eax
    123e:	8b 40 04             	mov    0x4(%eax),%eax
    1241:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1244:	7f 0c                	jg     1252 <APDrawRect+0x194>
    1246:	8b 45 08             	mov    0x8(%ebp),%eax
    1249:	8b 40 04             	mov    0x4(%eax),%eax
    124c:	83 e8 01             	sub    $0x1,%eax
    124f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1252:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1259:	8b 45 0c             	mov    0xc(%ebp),%eax
    125c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    125f:	eb 52                	jmp    12b3 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1261:	8b 45 10             	mov    0x10(%ebp),%eax
    1264:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1267:	eb 3e                	jmp    12a7 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1269:	83 ec 04             	sub    $0x4,%esp
    126c:	ff 75 e8             	pushl  -0x18(%ebp)
    126f:	ff 75 ec             	pushl  -0x14(%ebp)
    1272:	ff 75 08             	pushl  0x8(%ebp)
    1275:	e8 02 f7 ff ff       	call   97c <APGetIndex>
    127a:	83 c4 10             	add    $0x10,%esp
    127d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
    1283:	8b 48 18             	mov    0x18(%eax),%ecx
    1286:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1289:	89 d0                	mov    %edx,%eax
    128b:	01 c0                	add    %eax,%eax
    128d:	01 d0                	add    %edx,%eax
    128f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1292:	8b 45 08             	mov    0x8(%ebp),%eax
    1295:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1299:	66 89 0a             	mov    %cx,(%edx)
    129c:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12a0:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12a3:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12ad:	7e ba                	jle    1269 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12af:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12b6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12b9:	7e a6                	jle    1261 <APDrawRect+0x1a3>
    12bb:	eb 01                	jmp    12be <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12bd:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12c1:	c9                   	leave  
    12c2:	c3                   	ret    

000012c3 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    12c3:	55                   	push   %ebp
    12c4:	89 e5                	mov    %esp,%ebp
    12c6:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    12c9:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    12cd:	0f 88 8e 01 00 00    	js     1461 <APDcCopy+0x19e>
    12d3:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    12d7:	0f 88 84 01 00 00    	js     1461 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12dd:	8b 55 0c             	mov    0xc(%ebp),%edx
    12e0:	8b 45 20             	mov    0x20(%ebp),%eax
    12e3:	01 d0                	add    %edx,%eax
    12e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12e8:	8b 55 10             	mov    0x10(%ebp),%edx
    12eb:	8b 45 24             	mov    0x24(%ebp),%eax
    12ee:	01 d0                	add    %edx,%eax
    12f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12f3:	8b 55 18             	mov    0x18(%ebp),%edx
    12f6:	8b 45 20             	mov    0x20(%ebp),%eax
    12f9:	01 d0                	add    %edx,%eax
    12fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12fe:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1301:	8b 45 24             	mov    0x24(%ebp),%eax
    1304:	01 d0                	add    %edx,%eax
    1306:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1309:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    130d:	0f 88 51 01 00 00    	js     1464 <APDcCopy+0x1a1>
    1313:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1317:	0f 88 47 01 00 00    	js     1464 <APDcCopy+0x1a1>
    131d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1321:	0f 88 3d 01 00 00    	js     1464 <APDcCopy+0x1a1>
    1327:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    132b:	0f 88 33 01 00 00    	js     1464 <APDcCopy+0x1a1>
    1331:	8b 45 14             	mov    0x14(%ebp),%eax
    1334:	8b 00                	mov    (%eax),%eax
    1336:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1339:	0f 8c 25 01 00 00    	jl     1464 <APDcCopy+0x1a1>
    133f:	8b 45 14             	mov    0x14(%ebp),%eax
    1342:	8b 40 04             	mov    0x4(%eax),%eax
    1345:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1348:	0f 8c 16 01 00 00    	jl     1464 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    134e:	8b 45 08             	mov    0x8(%ebp),%eax
    1351:	8b 00                	mov    (%eax),%eax
    1353:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1356:	7f 0b                	jg     1363 <APDcCopy+0xa0>
    1358:	8b 45 08             	mov    0x8(%ebp),%eax
    135b:	8b 00                	mov    (%eax),%eax
    135d:	83 e8 01             	sub    $0x1,%eax
    1360:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1363:	8b 45 08             	mov    0x8(%ebp),%eax
    1366:	8b 40 04             	mov    0x4(%eax),%eax
    1369:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    136c:	7f 0c                	jg     137a <APDcCopy+0xb7>
    136e:	8b 45 08             	mov    0x8(%ebp),%eax
    1371:	8b 40 04             	mov    0x4(%eax),%eax
    1374:	83 e8 01             	sub    $0x1,%eax
    1377:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    137a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1381:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1388:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    138f:	e9 bc 00 00 00       	jmp    1450 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1394:	8b 45 08             	mov    0x8(%ebp),%eax
    1397:	8b 00                	mov    (%eax),%eax
    1399:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    139c:	8b 55 10             	mov    0x10(%ebp),%edx
    139f:	01 ca                	add    %ecx,%edx
    13a1:	0f af d0             	imul   %eax,%edx
    13a4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a7:	01 d0                	add    %edx,%eax
    13a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13ac:	8b 45 14             	mov    0x14(%ebp),%eax
    13af:	8b 00                	mov    (%eax),%eax
    13b1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13b4:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13b7:	01 ca                	add    %ecx,%edx
    13b9:	0f af d0             	imul   %eax,%edx
    13bc:	8b 45 18             	mov    0x18(%ebp),%eax
    13bf:	01 d0                	add    %edx,%eax
    13c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    13c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13cb:	eb 74                	jmp    1441 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    13cd:	8b 45 14             	mov    0x14(%ebp),%eax
    13d0:	8b 50 18             	mov    0x18(%eax),%edx
    13d3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13d9:	01 c8                	add    %ecx,%eax
    13db:	89 c1                	mov    %eax,%ecx
    13dd:	89 c8                	mov    %ecx,%eax
    13df:	01 c0                	add    %eax,%eax
    13e1:	01 c8                	add    %ecx,%eax
    13e3:	01 d0                	add    %edx,%eax
    13e5:	0f b7 10             	movzwl (%eax),%edx
    13e8:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13ec:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13f0:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13f3:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13f7:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    13fb:	38 c2                	cmp    %al,%dl
    13fd:	75 18                	jne    1417 <APDcCopy+0x154>
    13ff:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1403:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1407:	38 c2                	cmp    %al,%dl
    1409:	75 0c                	jne    1417 <APDcCopy+0x154>
    140b:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    140f:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1413:	38 c2                	cmp    %al,%dl
    1415:	74 26                	je     143d <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1417:	8b 45 08             	mov    0x8(%ebp),%eax
    141a:	8b 50 18             	mov    0x18(%eax),%edx
    141d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1420:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1423:	01 c8                	add    %ecx,%eax
    1425:	89 c1                	mov    %eax,%ecx
    1427:	89 c8                	mov    %ecx,%eax
    1429:	01 c0                	add    %eax,%eax
    142b:	01 c8                	add    %ecx,%eax
    142d:	01 d0                	add    %edx,%eax
    142f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1433:	66 89 10             	mov    %dx,(%eax)
    1436:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    143a:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    143d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1441:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1444:	2b 45 0c             	sub    0xc(%ebp),%eax
    1447:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    144a:	7d 81                	jge    13cd <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    144c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1450:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1453:	2b 45 10             	sub    0x10(%ebp),%eax
    1456:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1459:	0f 8d 35 ff ff ff    	jge    1394 <APDcCopy+0xd1>
    145f:	eb 04                	jmp    1465 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1461:	90                   	nop
    1462:	eb 01                	jmp    1465 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1464:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1465:	c9                   	leave  
    1466:	c3                   	ret    

00001467 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1467:	55                   	push   %ebp
    1468:	89 e5                	mov    %esp,%ebp
    146a:	83 ec 1c             	sub    $0x1c,%esp
    146d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1470:	8b 55 10             	mov    0x10(%ebp),%edx
    1473:	8b 45 14             	mov    0x14(%ebp),%eax
    1476:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1479:	88 55 e8             	mov    %dl,-0x18(%ebp)
    147c:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    147f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1483:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1486:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    148a:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    148d:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1491:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1494:	8b 45 08             	mov    0x8(%ebp),%eax
    1497:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    149b:	66 89 10             	mov    %dx,(%eax)
    149e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14a2:	88 50 02             	mov    %dl,0x2(%eax)
}
    14a5:	8b 45 08             	mov    0x8(%ebp),%eax
    14a8:	c9                   	leave  
    14a9:	c2 04 00             	ret    $0x4

000014ac <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14ac:	55                   	push   %ebp
    14ad:	89 e5                	mov    %esp,%ebp
    14af:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14b2:	8b 45 08             	mov    0x8(%ebp),%eax
    14b5:	8b 00                	mov    (%eax),%eax
    14b7:	83 ec 08             	sub    $0x8,%esp
    14ba:	8d 55 0c             	lea    0xc(%ebp),%edx
    14bd:	52                   	push   %edx
    14be:	50                   	push   %eax
    14bf:	e8 95 ef ff ff       	call   459 <sendMessage>
    14c4:	83 c4 10             	add    $0x10,%esp
}
    14c7:	90                   	nop
    14c8:	c9                   	leave  
    14c9:	c3                   	ret    

000014ca <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    14ca:	55                   	push   %ebp
    14cb:	89 e5                	mov    %esp,%ebp
    14cd:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    14d0:	83 ec 0c             	sub    $0xc,%esp
    14d3:	68 90 00 00 00       	push   $0x90
    14d8:	e8 3e f3 ff ff       	call   81b <malloc>
    14dd:	83 c4 10             	add    $0x10,%esp
    14e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14e7:	75 15                	jne    14fe <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14e9:	83 ec 04             	sub    $0x4,%esp
    14ec:	ff 75 08             	pushl  0x8(%ebp)
    14ef:	68 c8 21 00 00       	push   $0x21c8
    14f4:	6a 01                	push   $0x1
    14f6:	e8 4d f0 ff ff       	call   548 <printf>
    14fb:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    14fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1501:	83 c0 7c             	add    $0x7c,%eax
    1504:	83 ec 08             	sub    $0x8,%esp
    1507:	ff 75 08             	pushl  0x8(%ebp)
    150a:	50                   	push   %eax
    150b:	e8 68 ec ff ff       	call   178 <strcpy>
    1510:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1513:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1516:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    151d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1520:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1527:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152a:	8b 40 34             	mov    0x34(%eax),%eax
    152d:	89 c2                	mov    %eax,%edx
    152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1532:	8b 40 38             	mov    0x38(%eax),%eax
    1535:	0f af d0             	imul   %eax,%edx
    1538:	89 d0                	mov    %edx,%eax
    153a:	01 c0                	add    %eax,%eax
    153c:	01 d0                	add    %edx,%eax
    153e:	83 ec 0c             	sub    $0xc,%esp
    1541:	50                   	push   %eax
    1542:	e8 d4 f2 ff ff       	call   81b <malloc>
    1547:	83 c4 10             	add    $0x10,%esp
    154a:	89 c2                	mov    %eax,%edx
    154c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154f:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1552:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1555:	8b 40 4c             	mov    0x4c(%eax),%eax
    1558:	85 c0                	test   %eax,%eax
    155a:	75 15                	jne    1571 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    155c:	83 ec 04             	sub    $0x4,%esp
    155f:	ff 75 08             	pushl  0x8(%ebp)
    1562:	68 e8 21 00 00       	push   $0x21e8
    1567:	6a 01                	push   $0x1
    1569:	e8 da ef ff ff       	call   548 <printf>
    156e:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1571:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1574:	8b 40 34             	mov    0x34(%eax),%eax
    1577:	89 c2                	mov    %eax,%edx
    1579:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157c:	8b 40 38             	mov    0x38(%eax),%eax
    157f:	0f af d0             	imul   %eax,%edx
    1582:	89 d0                	mov    %edx,%eax
    1584:	01 c0                	add    %eax,%eax
    1586:	01 c2                	add    %eax,%edx
    1588:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158b:	8b 40 4c             	mov    0x4c(%eax),%eax
    158e:	83 ec 04             	sub    $0x4,%esp
    1591:	52                   	push   %edx
    1592:	68 ff ff ff 00       	push   $0xffffff
    1597:	50                   	push   %eax
    1598:	e8 71 ec ff ff       	call   20e <memset>
    159d:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a3:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    15aa:	e8 7a ee ff ff       	call   429 <getpid>
    15af:	89 c2                	mov    %eax,%edx
    15b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b4:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ba:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    15c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c4:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    15cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ce:	8b 40 50             	mov    0x50(%eax),%eax
    15d1:	89 c2                	mov    %eax,%edx
    15d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d6:	8b 40 54             	mov    0x54(%eax),%eax
    15d9:	0f af d0             	imul   %eax,%edx
    15dc:	89 d0                	mov    %edx,%eax
    15de:	01 c0                	add    %eax,%eax
    15e0:	01 d0                	add    %edx,%eax
    15e2:	83 ec 0c             	sub    $0xc,%esp
    15e5:	50                   	push   %eax
    15e6:	e8 30 f2 ff ff       	call   81b <malloc>
    15eb:	83 c4 10             	add    $0x10,%esp
    15ee:	89 c2                	mov    %eax,%edx
    15f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f3:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	8b 40 68             	mov    0x68(%eax),%eax
    15fc:	85 c0                	test   %eax,%eax
    15fe:	75 15                	jne    1615 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1600:	83 ec 04             	sub    $0x4,%esp
    1603:	ff 75 08             	pushl  0x8(%ebp)
    1606:	68 0c 22 00 00       	push   $0x220c
    160b:	6a 01                	push   $0x1
    160d:	e8 36 ef ff ff       	call   548 <printf>
    1612:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1615:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1618:	8b 40 34             	mov    0x34(%eax),%eax
    161b:	89 c2                	mov    %eax,%edx
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	8b 40 38             	mov    0x38(%eax),%eax
    1623:	0f af d0             	imul   %eax,%edx
    1626:	89 d0                	mov    %edx,%eax
    1628:	01 c0                	add    %eax,%eax
    162a:	01 c2                	add    %eax,%edx
    162c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    162f:	8b 40 4c             	mov    0x4c(%eax),%eax
    1632:	83 ec 04             	sub    $0x4,%esp
    1635:	52                   	push   %edx
    1636:	68 ff 00 00 00       	push   $0xff
    163b:	50                   	push   %eax
    163c:	e8 cd eb ff ff       	call   20e <memset>
    1641:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	8b 55 0c             	mov    0xc(%ebp),%edx
    164a:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    164d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1651:	74 35                	je     1688 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1653:	8b 45 10             	mov    0x10(%ebp),%eax
    1656:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    165c:	83 ec 0c             	sub    $0xc,%esp
    165f:	50                   	push   %eax
    1660:	e8 b6 f1 ff ff       	call   81b <malloc>
    1665:	83 c4 10             	add    $0x10,%esp
    1668:	89 c2                	mov    %eax,%edx
    166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166d:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1670:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1673:	8b 55 10             	mov    0x10(%ebp),%edx
    1676:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1679:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1683:	e9 8d 00 00 00       	jmp    1715 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1688:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168b:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1692:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1695:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    169c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169f:	8b 40 18             	mov    0x18(%eax),%eax
    16a2:	89 c2                	mov    %eax,%edx
    16a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a7:	8b 40 1c             	mov    0x1c(%eax),%eax
    16aa:	0f af d0             	imul   %eax,%edx
    16ad:	89 d0                	mov    %edx,%eax
    16af:	01 c0                	add    %eax,%eax
    16b1:	01 d0                	add    %edx,%eax
    16b3:	83 ec 0c             	sub    $0xc,%esp
    16b6:	50                   	push   %eax
    16b7:	e8 5f f1 ff ff       	call   81b <malloc>
    16bc:	83 c4 10             	add    $0x10,%esp
    16bf:	89 c2                	mov    %eax,%edx
    16c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c4:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    16c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ca:	8b 40 30             	mov    0x30(%eax),%eax
    16cd:	85 c0                	test   %eax,%eax
    16cf:	75 15                	jne    16e6 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16d1:	83 ec 04             	sub    $0x4,%esp
    16d4:	ff 75 08             	pushl  0x8(%ebp)
    16d7:	68 34 22 00 00       	push   $0x2234
    16dc:	6a 01                	push   $0x1
    16de:	e8 65 ee ff ff       	call   548 <printf>
    16e3:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e9:	8b 40 18             	mov    0x18(%eax),%eax
    16ec:	89 c2                	mov    %eax,%edx
    16ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f1:	8b 40 1c             	mov    0x1c(%eax),%eax
    16f4:	0f af d0             	imul   %eax,%edx
    16f7:	89 d0                	mov    %edx,%eax
    16f9:	01 c0                	add    %eax,%eax
    16fb:	01 c2                	add    %eax,%edx
    16fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1700:	8b 40 30             	mov    0x30(%eax),%eax
    1703:	83 ec 04             	sub    $0x4,%esp
    1706:	52                   	push   %edx
    1707:	68 ff ff ff 00       	push   $0xffffff
    170c:	50                   	push   %eax
    170d:	e8 fc ea ff ff       	call   20e <memset>
    1712:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1715:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1718:	c9                   	leave  
    1719:	c3                   	ret    

0000171a <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    171a:	55                   	push   %ebp
    171b:	89 e5                	mov    %esp,%ebp
    171d:	53                   	push   %ebx
    171e:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1721:	8b 45 0c             	mov    0xc(%ebp),%eax
    1724:	83 f8 03             	cmp    $0x3,%eax
    1727:	74 02                	je     172b <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1729:	eb 33                	jmp    175e <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    172b:	8b 45 08             	mov    0x8(%ebp),%eax
    172e:	8b 48 08             	mov    0x8(%eax),%ecx
    1731:	8b 45 08             	mov    0x8(%ebp),%eax
    1734:	8b 50 38             	mov    0x38(%eax),%edx
    1737:	8b 45 08             	mov    0x8(%ebp),%eax
    173a:	8b 40 34             	mov    0x34(%eax),%eax
    173d:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1740:	83 c3 34             	add    $0x34,%ebx
    1743:	83 ec 0c             	sub    $0xc,%esp
    1746:	51                   	push   %ecx
    1747:	52                   	push   %edx
    1748:	50                   	push   %eax
    1749:	6a 00                	push   $0x0
    174b:	6a 00                	push   $0x0
    174d:	53                   	push   %ebx
    174e:	6a 32                	push   $0x32
    1750:	6a 00                	push   $0x0
    1752:	ff 75 08             	pushl  0x8(%ebp)
    1755:	e8 ef ec ff ff       	call   449 <paintWindow>
    175a:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    175d:	90                   	nop
        default: break;
            
            
    }
    return False;
    175e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1763:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1766:	c9                   	leave  
    1767:	c3                   	ret    

00001768 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1768:	55                   	push   %ebp
    1769:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    176b:	8b 45 0c             	mov    0xc(%ebp),%eax
    176e:	8b 50 08             	mov    0x8(%eax),%edx
    1771:	8b 45 08             	mov    0x8(%ebp),%eax
    1774:	8b 00                	mov    (%eax),%eax
    1776:	39 c2                	cmp    %eax,%edx
    1778:	74 07                	je     1781 <APPreJudge+0x19>
        return False;
    177a:	b8 00 00 00 00       	mov    $0x0,%eax
    177f:	eb 05                	jmp    1786 <APPreJudge+0x1e>
    return True;
    1781:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1786:	5d                   	pop    %ebp
    1787:	c3                   	ret    

00001788 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1788:	55                   	push   %ebp
    1789:	89 e5                	mov    %esp,%ebp
    178b:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    178e:	8b 45 08             	mov    0x8(%ebp),%eax
    1791:	8b 55 0c             	mov    0xc(%ebp),%edx
    1794:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1797:	83 ec 0c             	sub    $0xc,%esp
    179a:	ff 75 08             	pushl  0x8(%ebp)
    179d:	e8 c7 ec ff ff       	call   469 <registWindow>
    17a2:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17a5:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17ac:	8b 45 08             	mov    0x8(%ebp),%eax
    17af:	8b 00                	mov    (%eax),%eax
    17b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17b4:	ff 75 f4             	pushl  -0xc(%ebp)
    17b7:	ff 75 f0             	pushl  -0x10(%ebp)
    17ba:	ff 75 ec             	pushl  -0x14(%ebp)
    17bd:	ff 75 08             	pushl  0x8(%ebp)
    17c0:	e8 e7 fc ff ff       	call   14ac <APSendMessage>
    17c5:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    17c8:	83 ec 0c             	sub    $0xc,%esp
    17cb:	ff 75 08             	pushl  0x8(%ebp)
    17ce:	e8 8e ec ff ff       	call   461 <getMessage>
    17d3:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    17d6:	8b 45 08             	mov    0x8(%ebp),%eax
    17d9:	83 c0 6c             	add    $0x6c,%eax
    17dc:	83 ec 08             	sub    $0x8,%esp
    17df:	50                   	push   %eax
    17e0:	ff 75 08             	pushl  0x8(%ebp)
    17e3:	e8 80 ff ff ff       	call   1768 <APPreJudge>
    17e8:	83 c4 10             	add    $0x10,%esp
    17eb:	84 c0                	test   %al,%al
    17ed:	74 1b                	je     180a <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    17ef:	8b 45 08             	mov    0x8(%ebp),%eax
    17f2:	ff 70 74             	pushl  0x74(%eax)
    17f5:	ff 70 70             	pushl  0x70(%eax)
    17f8:	ff 70 6c             	pushl  0x6c(%eax)
    17fb:	ff 75 08             	pushl  0x8(%ebp)
    17fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1801:	ff d0                	call   *%eax
    1803:	83 c4 10             	add    $0x10,%esp
    1806:	84 c0                	test   %al,%al
    1808:	75 0c                	jne    1816 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    180a:	8b 45 08             	mov    0x8(%ebp),%eax
    180d:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1814:	eb b2                	jmp    17c8 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1816:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1817:	90                   	nop
    1818:	c9                   	leave  
    1819:	c3                   	ret    

0000181a <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    181a:	55                   	push   %ebp
    181b:	89 e5                	mov    %esp,%ebp
    181d:	57                   	push   %edi
    181e:	56                   	push   %esi
    181f:	53                   	push   %ebx
    1820:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1823:	a1 6c 28 00 00       	mov    0x286c,%eax
    1828:	85 c0                	test   %eax,%eax
    182a:	0f 85 2c 02 00 00    	jne    1a5c <APGridPaint+0x242>
    {
        iconReady = 1;
    1830:	c7 05 6c 28 00 00 01 	movl   $0x1,0x286c
    1837:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    183a:	8d 45 98             	lea    -0x68(%ebp),%eax
    183d:	83 ec 08             	sub    $0x8,%esp
    1840:	68 5b 22 00 00       	push   $0x225b
    1845:	50                   	push   %eax
    1846:	e8 83 f1 ff ff       	call   9ce <APLoadBitmap>
    184b:	83 c4 0c             	add    $0xc,%esp
    184e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1851:	a3 90 28 00 00       	mov    %eax,0x2890
    1856:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1859:	a3 94 28 00 00       	mov    %eax,0x2894
    185e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1861:	a3 98 28 00 00       	mov    %eax,0x2898
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1866:	83 ec 04             	sub    $0x4,%esp
    1869:	ff 35 98 28 00 00    	pushl  0x2898
    186f:	ff 35 94 28 00 00    	pushl  0x2894
    1875:	ff 35 90 28 00 00    	pushl  0x2890
    187b:	e8 88 f3 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    1880:	83 c4 10             	add    $0x10,%esp
    1883:	a3 9c 28 00 00       	mov    %eax,0x289c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1888:	8d 45 98             	lea    -0x68(%ebp),%eax
    188b:	83 ec 08             	sub    $0x8,%esp
    188e:	68 69 22 00 00       	push   $0x2269
    1893:	50                   	push   %eax
    1894:	e8 35 f1 ff ff       	call   9ce <APLoadBitmap>
    1899:	83 c4 0c             	add    $0xc,%esp
    189c:	8b 45 98             	mov    -0x68(%ebp),%eax
    189f:	a3 cc 28 00 00       	mov    %eax,0x28cc
    18a4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18a7:	a3 d0 28 00 00       	mov    %eax,0x28d0
    18ac:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18af:	a3 d4 28 00 00       	mov    %eax,0x28d4
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    18b4:	83 ec 04             	sub    $0x4,%esp
    18b7:	ff 35 d4 28 00 00    	pushl  0x28d4
    18bd:	ff 35 d0 28 00 00    	pushl  0x28d0
    18c3:	ff 35 cc 28 00 00    	pushl  0x28cc
    18c9:	e8 3a f3 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    18ce:	83 c4 10             	add    $0x10,%esp
    18d1:	a3 bc 28 00 00       	mov    %eax,0x28bc
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    18d6:	8d 45 98             	lea    -0x68(%ebp),%eax
    18d9:	83 ec 08             	sub    $0x8,%esp
    18dc:	68 78 22 00 00       	push   $0x2278
    18e1:	50                   	push   %eax
    18e2:	e8 e7 f0 ff ff       	call   9ce <APLoadBitmap>
    18e7:	83 c4 0c             	add    $0xc,%esp
    18ea:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ed:	a3 c0 28 00 00       	mov    %eax,0x28c0
    18f2:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18f5:	a3 c4 28 00 00       	mov    %eax,0x28c4
    18fa:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18fd:	a3 c8 28 00 00       	mov    %eax,0x28c8
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1902:	83 ec 04             	sub    $0x4,%esp
    1905:	ff 35 c8 28 00 00    	pushl  0x28c8
    190b:	ff 35 c4 28 00 00    	pushl  0x28c4
    1911:	ff 35 c0 28 00 00    	pushl  0x28c0
    1917:	e8 ec f2 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    191c:	83 c4 10             	add    $0x10,%esp
    191f:	a3 70 28 00 00       	mov    %eax,0x2870
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1924:	8d 45 98             	lea    -0x68(%ebp),%eax
    1927:	83 ec 08             	sub    $0x8,%esp
    192a:	68 87 22 00 00       	push   $0x2287
    192f:	50                   	push   %eax
    1930:	e8 99 f0 ff ff       	call   9ce <APLoadBitmap>
    1935:	83 c4 0c             	add    $0xc,%esp
    1938:	8b 45 98             	mov    -0x68(%ebp),%eax
    193b:	a3 a4 28 00 00       	mov    %eax,0x28a4
    1940:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1943:	a3 a8 28 00 00       	mov    %eax,0x28a8
    1948:	8b 45 a0             	mov    -0x60(%ebp),%eax
    194b:	a3 ac 28 00 00       	mov    %eax,0x28ac
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1950:	83 ec 04             	sub    $0x4,%esp
    1953:	ff 35 ac 28 00 00    	pushl  0x28ac
    1959:	ff 35 a8 28 00 00    	pushl  0x28a8
    195f:	ff 35 a4 28 00 00    	pushl  0x28a4
    1965:	e8 9e f2 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    196a:	83 c4 10             	add    $0x10,%esp
    196d:	a3 d8 28 00 00       	mov    %eax,0x28d8
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1972:	8d 45 98             	lea    -0x68(%ebp),%eax
    1975:	83 ec 08             	sub    $0x8,%esp
    1978:	68 95 22 00 00       	push   $0x2295
    197d:	50                   	push   %eax
    197e:	e8 4b f0 ff ff       	call   9ce <APLoadBitmap>
    1983:	83 c4 0c             	add    $0xc,%esp
    1986:	8b 45 98             	mov    -0x68(%ebp),%eax
    1989:	a3 80 28 00 00       	mov    %eax,0x2880
    198e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1991:	a3 84 28 00 00       	mov    %eax,0x2884
    1996:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1999:	a3 88 28 00 00       	mov    %eax,0x2888
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    199e:	83 ec 04             	sub    $0x4,%esp
    19a1:	ff 35 88 28 00 00    	pushl  0x2888
    19a7:	ff 35 84 28 00 00    	pushl  0x2884
    19ad:	ff 35 80 28 00 00    	pushl  0x2880
    19b3:	e8 50 f2 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    19b8:	83 c4 10             	add    $0x10,%esp
    19bb:	a3 a0 28 00 00       	mov    %eax,0x28a0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    19c0:	8d 45 98             	lea    -0x68(%ebp),%eax
    19c3:	83 ec 08             	sub    $0x8,%esp
    19c6:	68 a5 22 00 00       	push   $0x22a5
    19cb:	50                   	push   %eax
    19cc:	e8 fd ef ff ff       	call   9ce <APLoadBitmap>
    19d1:	83 c4 0c             	add    $0xc,%esp
    19d4:	8b 45 98             	mov    -0x68(%ebp),%eax
    19d7:	a3 74 28 00 00       	mov    %eax,0x2874
    19dc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19df:	a3 78 28 00 00       	mov    %eax,0x2878
    19e4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19e7:	a3 7c 28 00 00       	mov    %eax,0x287c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    19ec:	83 ec 04             	sub    $0x4,%esp
    19ef:	ff 35 7c 28 00 00    	pushl  0x287c
    19f5:	ff 35 78 28 00 00    	pushl  0x2878
    19fb:	ff 35 74 28 00 00    	pushl  0x2874
    1a01:	e8 02 f2 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    1a06:	83 c4 10             	add    $0x10,%esp
    1a09:	a3 8c 28 00 00       	mov    %eax,0x288c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a0e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a11:	83 ec 08             	sub    $0x8,%esp
    1a14:	68 b7 22 00 00       	push   $0x22b7
    1a19:	50                   	push   %eax
    1a1a:	e8 af ef ff ff       	call   9ce <APLoadBitmap>
    1a1f:	83 c4 0c             	add    $0xc,%esp
    1a22:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a25:	a3 b0 28 00 00       	mov    %eax,0x28b0
    1a2a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a2d:	a3 b4 28 00 00       	mov    %eax,0x28b4
    1a32:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a35:	a3 b8 28 00 00       	mov    %eax,0x28b8
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1a3a:	83 ec 04             	sub    $0x4,%esp
    1a3d:	ff 35 b8 28 00 00    	pushl  0x28b8
    1a43:	ff 35 b4 28 00 00    	pushl  0x28b4
    1a49:	ff 35 b0 28 00 00    	pushl  0x28b0
    1a4f:	e8 b4 f1 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    1a54:	83 c4 10             	add    $0x10,%esp
    1a57:	a3 dc 28 00 00       	mov    %eax,0x28dc
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a5f:	8b 40 08             	mov    0x8(%eax),%eax
    1a62:	85 c0                	test   %eax,%eax
    1a64:	75 17                	jne    1a7d <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a66:	83 ec 08             	sub    $0x8,%esp
    1a69:	68 c8 22 00 00       	push   $0x22c8
    1a6e:	6a 01                	push   $0x1
    1a70:	e8 d3 ea ff ff       	call   548 <printf>
    1a75:	83 c4 10             	add    $0x10,%esp
        return;
    1a78:	e9 f2 03 00 00       	jmp    1e6f <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a80:	8b 40 10             	mov    0x10(%eax),%eax
    1a83:	85 c0                	test   %eax,%eax
    1a85:	7e 10                	jle    1a97 <APGridPaint+0x27d>
    1a87:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8a:	8b 50 14             	mov    0x14(%eax),%edx
    1a8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a90:	8b 40 10             	mov    0x10(%eax),%eax
    1a93:	39 c2                	cmp    %eax,%edx
    1a95:	7c 17                	jl     1aae <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a97:	83 ec 08             	sub    $0x8,%esp
    1a9a:	68 ee 22 00 00       	push   $0x22ee
    1a9f:	6a 01                	push   $0x1
    1aa1:	e8 a2 ea ff ff       	call   548 <printf>
    1aa6:	83 c4 10             	add    $0x10,%esp
        return;
    1aa9:	e9 c1 03 00 00       	jmp    1e6f <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1aae:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab1:	8b 40 14             	mov    0x14(%eax),%eax
    1ab4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1aba:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1abd:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ac0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ac3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1aca:	e9 96 03 00 00       	jmp    1e65 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1acf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1ad6:	e9 7c 03 00 00       	jmp    1e57 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1adb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ade:	c1 e0 04             	shl    $0x4,%eax
    1ae1:	89 c2                	mov    %eax,%edx
    1ae3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1ae6:	01 c2                	add    %eax,%edx
    1ae8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1aeb:	01 d0                	add    %edx,%eax
    1aed:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1af0:	8b 45 08             	mov    0x8(%ebp),%eax
    1af3:	8b 40 0c             	mov    0xc(%eax),%eax
    1af6:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1af9:	c1 e2 02             	shl    $0x2,%edx
    1afc:	01 d0                	add    %edx,%eax
    1afe:	8b 00                	mov    (%eax),%eax
    1b00:	83 f8 07             	cmp    $0x7,%eax
    1b03:	0f 87 49 03 00 00    	ja     1e52 <APGridPaint+0x638>
    1b09:	8b 04 85 04 23 00 00 	mov    0x2304(,%eax,4),%eax
    1b10:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b12:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b15:	6a 0c                	push   $0xc
    1b17:	6a 0c                	push   $0xc
    1b19:	6a 0c                	push   $0xc
    1b1b:	50                   	push   %eax
    1b1c:	e8 46 f9 ff ff       	call   1467 <RGB>
    1b21:	83 c4 0c             	add    $0xc,%esp
    1b24:	8b 1d 9c 28 00 00    	mov    0x289c,%ebx
    1b2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b2d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b30:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b33:	6b c0 32             	imul   $0x32,%eax,%eax
    1b36:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b39:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3c:	8d 78 34             	lea    0x34(%eax),%edi
    1b3f:	83 ec 0c             	sub    $0xc,%esp
    1b42:	83 ec 04             	sub    $0x4,%esp
    1b45:	89 e0                	mov    %esp,%eax
    1b47:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b4b:	66 89 30             	mov    %si,(%eax)
    1b4e:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b52:	88 50 02             	mov    %dl,0x2(%eax)
    1b55:	6a 32                	push   $0x32
    1b57:	6a 32                	push   $0x32
    1b59:	6a 00                	push   $0x0
    1b5b:	6a 00                	push   $0x0
    1b5d:	53                   	push   %ebx
    1b5e:	51                   	push   %ecx
    1b5f:	ff 75 94             	pushl  -0x6c(%ebp)
    1b62:	57                   	push   %edi
    1b63:	e8 5b f7 ff ff       	call   12c3 <APDcCopy>
    1b68:	83 c4 30             	add    $0x30,%esp
                    break;
    1b6b:	e9 e3 02 00 00       	jmp    1e53 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b70:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b73:	6a 69                	push   $0x69
    1b75:	6a 69                	push   $0x69
    1b77:	6a 69                	push   $0x69
    1b79:	50                   	push   %eax
    1b7a:	e8 e8 f8 ff ff       	call   1467 <RGB>
    1b7f:	83 c4 0c             	add    $0xc,%esp
    1b82:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b86:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1b8a:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b8e:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1b91:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1b98:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b9b:	6a 69                	push   $0x69
    1b9d:	6a 69                	push   $0x69
    1b9f:	6a 69                	push   $0x69
    1ba1:	50                   	push   %eax
    1ba2:	e8 c0 f8 ff ff       	call   1467 <RGB>
    1ba7:	83 c4 0c             	add    $0xc,%esp
    1baa:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bae:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1bb2:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bb6:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1bb9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbc:	8d 50 34             	lea    0x34(%eax),%edx
    1bbf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bc2:	ff 75 bc             	pushl  -0x44(%ebp)
    1bc5:	ff 75 b8             	pushl  -0x48(%ebp)
    1bc8:	52                   	push   %edx
    1bc9:	50                   	push   %eax
    1bca:	e8 ce f0 ff ff       	call   c9d <APSetPen>
    1bcf:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1bd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd5:	8d 58 34             	lea    0x34(%eax),%ebx
    1bd8:	8d 55 98             	lea    -0x68(%ebp),%edx
    1bdb:	83 ec 04             	sub    $0x4,%esp
    1bde:	83 ec 04             	sub    $0x4,%esp
    1be1:	89 e0                	mov    %esp,%eax
    1be3:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1be7:	66 89 08             	mov    %cx,(%eax)
    1bea:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1bee:	88 48 02             	mov    %cl,0x2(%eax)
    1bf1:	53                   	push   %ebx
    1bf2:	52                   	push   %edx
    1bf3:	e8 de f0 ff ff       	call   cd6 <APSetBrush>
    1bf8:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1bfb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bfe:	6b d0 32             	imul   $0x32,%eax,%edx
    1c01:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c04:	6b c0 32             	imul   $0x32,%eax,%eax
    1c07:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c0a:	83 c1 34             	add    $0x34,%ecx
    1c0d:	83 ec 0c             	sub    $0xc,%esp
    1c10:	6a 32                	push   $0x32
    1c12:	6a 32                	push   $0x32
    1c14:	52                   	push   %edx
    1c15:	50                   	push   %eax
    1c16:	51                   	push   %ecx
    1c17:	e8 a2 f4 ff ff       	call   10be <APDrawRect>
    1c1c:	83 c4 20             	add    $0x20,%esp
                    break;
    1c1f:	e9 2f 02 00 00       	jmp    1e53 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c24:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c27:	6a 0c                	push   $0xc
    1c29:	6a 0c                	push   $0xc
    1c2b:	6a 0c                	push   $0xc
    1c2d:	50                   	push   %eax
    1c2e:	e8 34 f8 ff ff       	call   1467 <RGB>
    1c33:	83 c4 0c             	add    $0xc,%esp
    1c36:	8b 1d dc 28 00 00    	mov    0x28dc,%ebx
    1c3c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c3f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c42:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c45:	6b c0 32             	imul   $0x32,%eax,%eax
    1c48:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c4b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4e:	8d 78 34             	lea    0x34(%eax),%edi
    1c51:	83 ec 0c             	sub    $0xc,%esp
    1c54:	83 ec 04             	sub    $0x4,%esp
    1c57:	89 e0                	mov    %esp,%eax
    1c59:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c5d:	66 89 30             	mov    %si,(%eax)
    1c60:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c64:	88 50 02             	mov    %dl,0x2(%eax)
    1c67:	6a 32                	push   $0x32
    1c69:	6a 32                	push   $0x32
    1c6b:	6a 00                	push   $0x0
    1c6d:	6a 00                	push   $0x0
    1c6f:	53                   	push   %ebx
    1c70:	51                   	push   %ecx
    1c71:	ff 75 94             	pushl  -0x6c(%ebp)
    1c74:	57                   	push   %edi
    1c75:	e8 49 f6 ff ff       	call   12c3 <APDcCopy>
    1c7a:	83 c4 30             	add    $0x30,%esp
                    break;
    1c7d:	e9 d1 01 00 00       	jmp    1e53 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c82:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c85:	6a 0c                	push   $0xc
    1c87:	6a 0c                	push   $0xc
    1c89:	6a 0c                	push   $0xc
    1c8b:	50                   	push   %eax
    1c8c:	e8 d6 f7 ff ff       	call   1467 <RGB>
    1c91:	83 c4 0c             	add    $0xc,%esp
    1c94:	8b 1d bc 28 00 00    	mov    0x28bc,%ebx
    1c9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c9d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ca0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ca3:	6b c0 32             	imul   $0x32,%eax,%eax
    1ca6:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ca9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cac:	8d 78 34             	lea    0x34(%eax),%edi
    1caf:	83 ec 0c             	sub    $0xc,%esp
    1cb2:	83 ec 04             	sub    $0x4,%esp
    1cb5:	89 e0                	mov    %esp,%eax
    1cb7:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1cbb:	66 89 30             	mov    %si,(%eax)
    1cbe:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1cc2:	88 50 02             	mov    %dl,0x2(%eax)
    1cc5:	6a 32                	push   $0x32
    1cc7:	6a 32                	push   $0x32
    1cc9:	6a 00                	push   $0x0
    1ccb:	6a 00                	push   $0x0
    1ccd:	53                   	push   %ebx
    1cce:	51                   	push   %ecx
    1ccf:	ff 75 94             	pushl  -0x6c(%ebp)
    1cd2:	57                   	push   %edi
    1cd3:	e8 eb f5 ff ff       	call   12c3 <APDcCopy>
    1cd8:	83 c4 30             	add    $0x30,%esp
                    break;
    1cdb:	e9 73 01 00 00       	jmp    1e53 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ce0:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ce3:	6a 0c                	push   $0xc
    1ce5:	6a 0c                	push   $0xc
    1ce7:	6a 0c                	push   $0xc
    1ce9:	50                   	push   %eax
    1cea:	e8 78 f7 ff ff       	call   1467 <RGB>
    1cef:	83 c4 0c             	add    $0xc,%esp
    1cf2:	8b 1d a0 28 00 00    	mov    0x28a0,%ebx
    1cf8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cfb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d01:	6b c0 32             	imul   $0x32,%eax,%eax
    1d04:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d07:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0a:	8d 78 34             	lea    0x34(%eax),%edi
    1d0d:	83 ec 0c             	sub    $0xc,%esp
    1d10:	83 ec 04             	sub    $0x4,%esp
    1d13:	89 e0                	mov    %esp,%eax
    1d15:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d19:	66 89 30             	mov    %si,(%eax)
    1d1c:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d20:	88 50 02             	mov    %dl,0x2(%eax)
    1d23:	6a 32                	push   $0x32
    1d25:	6a 32                	push   $0x32
    1d27:	6a 00                	push   $0x0
    1d29:	6a 00                	push   $0x0
    1d2b:	53                   	push   %ebx
    1d2c:	51                   	push   %ecx
    1d2d:	ff 75 94             	pushl  -0x6c(%ebp)
    1d30:	57                   	push   %edi
    1d31:	e8 8d f5 ff ff       	call   12c3 <APDcCopy>
    1d36:	83 c4 30             	add    $0x30,%esp
                    break;
    1d39:	e9 15 01 00 00       	jmp    1e53 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d3e:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1d41:	6a 0c                	push   $0xc
    1d43:	6a 0c                	push   $0xc
    1d45:	6a 0c                	push   $0xc
    1d47:	50                   	push   %eax
    1d48:	e8 1a f7 ff ff       	call   1467 <RGB>
    1d4d:	83 c4 0c             	add    $0xc,%esp
    1d50:	8b 1d d8 28 00 00    	mov    0x28d8,%ebx
    1d56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d59:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d5c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5f:	6b c0 32             	imul   $0x32,%eax,%eax
    1d62:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d65:	8b 45 08             	mov    0x8(%ebp),%eax
    1d68:	8d 78 34             	lea    0x34(%eax),%edi
    1d6b:	83 ec 0c             	sub    $0xc,%esp
    1d6e:	83 ec 04             	sub    $0x4,%esp
    1d71:	89 e0                	mov    %esp,%eax
    1d73:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d77:	66 89 30             	mov    %si,(%eax)
    1d7a:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d7e:	88 50 02             	mov    %dl,0x2(%eax)
    1d81:	6a 32                	push   $0x32
    1d83:	6a 32                	push   $0x32
    1d85:	6a 00                	push   $0x0
    1d87:	6a 00                	push   $0x0
    1d89:	53                   	push   %ebx
    1d8a:	51                   	push   %ecx
    1d8b:	ff 75 94             	pushl  -0x6c(%ebp)
    1d8e:	57                   	push   %edi
    1d8f:	e8 2f f5 ff ff       	call   12c3 <APDcCopy>
    1d94:	83 c4 30             	add    $0x30,%esp
                    break;
    1d97:	e9 b7 00 00 00       	jmp    1e53 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d9c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1d9f:	6a 0c                	push   $0xc
    1da1:	6a 0c                	push   $0xc
    1da3:	6a 0c                	push   $0xc
    1da5:	50                   	push   %eax
    1da6:	e8 bc f6 ff ff       	call   1467 <RGB>
    1dab:	83 c4 0c             	add    $0xc,%esp
    1dae:	8b 1d 70 28 00 00    	mov    0x2870,%ebx
    1db4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1db7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dba:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dbd:	6b c0 32             	imul   $0x32,%eax,%eax
    1dc0:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc6:	8d 78 34             	lea    0x34(%eax),%edi
    1dc9:	83 ec 0c             	sub    $0xc,%esp
    1dcc:	83 ec 04             	sub    $0x4,%esp
    1dcf:	89 e0                	mov    %esp,%eax
    1dd1:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1dd5:	66 89 30             	mov    %si,(%eax)
    1dd8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1ddc:	88 50 02             	mov    %dl,0x2(%eax)
    1ddf:	6a 32                	push   $0x32
    1de1:	6a 32                	push   $0x32
    1de3:	6a 00                	push   $0x0
    1de5:	6a 00                	push   $0x0
    1de7:	53                   	push   %ebx
    1de8:	51                   	push   %ecx
    1de9:	ff 75 94             	pushl  -0x6c(%ebp)
    1dec:	57                   	push   %edi
    1ded:	e8 d1 f4 ff ff       	call   12c3 <APDcCopy>
    1df2:	83 c4 30             	add    $0x30,%esp
                    break;
    1df5:	eb 5c                	jmp    1e53 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1df7:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1dfa:	6a 0c                	push   $0xc
    1dfc:	6a 0c                	push   $0xc
    1dfe:	6a 0c                	push   $0xc
    1e00:	50                   	push   %eax
    1e01:	e8 61 f6 ff ff       	call   1467 <RGB>
    1e06:	83 c4 0c             	add    $0xc,%esp
    1e09:	8b 1d 8c 28 00 00    	mov    0x288c,%ebx
    1e0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e12:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e15:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e18:	6b c0 32             	imul   $0x32,%eax,%eax
    1e1b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e21:	8d 78 34             	lea    0x34(%eax),%edi
    1e24:	83 ec 0c             	sub    $0xc,%esp
    1e27:	83 ec 04             	sub    $0x4,%esp
    1e2a:	89 e0                	mov    %esp,%eax
    1e2c:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e30:	66 89 30             	mov    %si,(%eax)
    1e33:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1e37:	88 50 02             	mov    %dl,0x2(%eax)
    1e3a:	6a 32                	push   $0x32
    1e3c:	6a 32                	push   $0x32
    1e3e:	6a 00                	push   $0x0
    1e40:	6a 00                	push   $0x0
    1e42:	53                   	push   %ebx
    1e43:	51                   	push   %ecx
    1e44:	ff 75 94             	pushl  -0x6c(%ebp)
    1e47:	57                   	push   %edi
    1e48:	e8 76 f4 ff ff       	call   12c3 <APDcCopy>
    1e4d:	83 c4 30             	add    $0x30,%esp
                    break;
    1e50:	eb 01                	jmp    1e53 <APGridPaint+0x639>
                default: break;
    1e52:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e53:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e57:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e5b:	0f 8e 7a fc ff ff    	jle    1adb <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e61:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e65:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e69:	0f 8e 60 fc ff ff    	jle    1acf <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1e6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e72:	5b                   	pop    %ebx
    1e73:	5e                   	pop    %esi
    1e74:	5f                   	pop    %edi
    1e75:	5d                   	pop    %ebp
    1e76:	c3                   	ret    

00001e77 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e77:	55                   	push   %ebp
    1e78:	89 e5                	mov    %esp,%ebp
    1e7a:	53                   	push   %ebx
    1e7b:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e85:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e89:	74 17                	je     1ea2 <sprintint+0x2b>
    1e8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e8f:	79 11                	jns    1ea2 <sprintint+0x2b>
        neg = 1;
    1e91:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e98:	8b 45 10             	mov    0x10(%ebp),%eax
    1e9b:	f7 d8                	neg    %eax
    1e9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ea0:	eb 06                	jmp    1ea8 <sprintint+0x31>
    } else {
        x = xx;
    1ea2:	8b 45 10             	mov    0x10(%ebp),%eax
    1ea5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1ea8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1eaf:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1eb2:	8d 41 01             	lea    0x1(%ecx),%eax
    1eb5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1eb8:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ebb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ebe:	ba 00 00 00 00       	mov    $0x0,%edx
    1ec3:	f7 f3                	div    %ebx
    1ec5:	89 d0                	mov    %edx,%eax
    1ec7:	0f b6 80 4c 28 00 00 	movzbl 0x284c(%eax),%eax
    1ece:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1ed2:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ed5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ed8:	ba 00 00 00 00       	mov    $0x0,%edx
    1edd:	f7 f3                	div    %ebx
    1edf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ee2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ee6:	75 c7                	jne    1eaf <sprintint+0x38>
    if(neg)
    1ee8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1eec:	74 0e                	je     1efc <sprintint+0x85>
        buf[i++] = '-';
    1eee:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ef1:	8d 50 01             	lea    0x1(%eax),%edx
    1ef4:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1ef7:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1efc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1eff:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f02:	eb 1b                	jmp    1f1f <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f04:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f07:	8b 00                	mov    (%eax),%eax
    1f09:	8d 48 01             	lea    0x1(%eax),%ecx
    1f0c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f0f:	89 0a                	mov    %ecx,(%edx)
    1f11:	89 c2                	mov    %eax,%edx
    1f13:	8b 45 08             	mov    0x8(%ebp),%eax
    1f16:	01 d0                	add    %edx,%eax
    1f18:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f1b:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f1f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f23:	7f df                	jg     1f04 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f25:	eb 21                	jmp    1f48 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f27:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f2a:	8b 00                	mov    (%eax),%eax
    1f2c:	8d 48 01             	lea    0x1(%eax),%ecx
    1f2f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f32:	89 0a                	mov    %ecx,(%edx)
    1f34:	89 c2                	mov    %eax,%edx
    1f36:	8b 45 08             	mov    0x8(%ebp),%eax
    1f39:	01 c2                	add    %eax,%edx
    1f3b:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1f3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f41:	01 c8                	add    %ecx,%eax
    1f43:	0f b6 00             	movzbl (%eax),%eax
    1f46:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f48:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1f4c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1f50:	79 d5                	jns    1f27 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1f52:	90                   	nop
    1f53:	83 c4 20             	add    $0x20,%esp
    1f56:	5b                   	pop    %ebx
    1f57:	5d                   	pop    %ebp
    1f58:	c3                   	ret    

00001f59 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1f59:	55                   	push   %ebp
    1f5a:	89 e5                	mov    %esp,%ebp
    1f5c:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1f5f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1f66:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1f6d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f74:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f77:	83 c0 04             	add    $0x4,%eax
    1f7a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f7d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f84:	e9 d9 01 00 00       	jmp    2162 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f89:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f8f:	01 d0                	add    %edx,%eax
    1f91:	0f b6 00             	movzbl (%eax),%eax
    1f94:	0f be c0             	movsbl %al,%eax
    1f97:	25 ff 00 00 00       	and    $0xff,%eax
    1f9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f9f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1fa3:	75 2c                	jne    1fd1 <sprintf+0x78>
            if(c == '%'){
    1fa5:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1fa9:	75 0c                	jne    1fb7 <sprintf+0x5e>
                state = '%';
    1fab:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1fb2:	e9 a7 01 00 00       	jmp    215e <sprintf+0x205>
            } else {
                dst[j++] = c;
    1fb7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fba:	8d 50 01             	lea    0x1(%eax),%edx
    1fbd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fc0:	89 c2                	mov    %eax,%edx
    1fc2:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc5:	01 d0                	add    %edx,%eax
    1fc7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1fca:	88 10                	mov    %dl,(%eax)
    1fcc:	e9 8d 01 00 00       	jmp    215e <sprintf+0x205>
            }
        } else if(state == '%'){
    1fd1:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1fd5:	0f 85 83 01 00 00    	jne    215e <sprintf+0x205>
            if(c == 'd'){
    1fdb:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1fdf:	75 4c                	jne    202d <sprintf+0xd4>
                buf[bi] = '\0';
    1fe1:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fe4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fe7:	01 d0                	add    %edx,%eax
    1fe9:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fec:	83 ec 0c             	sub    $0xc,%esp
    1fef:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1ff2:	50                   	push   %eax
    1ff3:	e8 1f e3 ff ff       	call   317 <atoi>
    1ff8:	83 c4 10             	add    $0x10,%esp
    1ffb:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1ffe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2005:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2008:	8b 00                	mov    (%eax),%eax
    200a:	83 ec 08             	sub    $0x8,%esp
    200d:	ff 75 d8             	pushl  -0x28(%ebp)
    2010:	6a 01                	push   $0x1
    2012:	6a 0a                	push   $0xa
    2014:	50                   	push   %eax
    2015:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2018:	50                   	push   %eax
    2019:	ff 75 08             	pushl  0x8(%ebp)
    201c:	e8 56 fe ff ff       	call   1e77 <sprintint>
    2021:	83 c4 20             	add    $0x20,%esp
                ap++;
    2024:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2028:	e9 2a 01 00 00       	jmp    2157 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    202d:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2031:	74 06                	je     2039 <sprintf+0xe0>
    2033:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2037:	75 4c                	jne    2085 <sprintf+0x12c>
                buf[bi] = '\0';
    2039:	8d 55 ce             	lea    -0x32(%ebp),%edx
    203c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    203f:	01 d0                	add    %edx,%eax
    2041:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2044:	83 ec 0c             	sub    $0xc,%esp
    2047:	8d 45 ce             	lea    -0x32(%ebp),%eax
    204a:	50                   	push   %eax
    204b:	e8 c7 e2 ff ff       	call   317 <atoi>
    2050:	83 c4 10             	add    $0x10,%esp
    2053:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2056:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    205d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2060:	8b 00                	mov    (%eax),%eax
    2062:	83 ec 08             	sub    $0x8,%esp
    2065:	ff 75 dc             	pushl  -0x24(%ebp)
    2068:	6a 00                	push   $0x0
    206a:	6a 10                	push   $0x10
    206c:	50                   	push   %eax
    206d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2070:	50                   	push   %eax
    2071:	ff 75 08             	pushl  0x8(%ebp)
    2074:	e8 fe fd ff ff       	call   1e77 <sprintint>
    2079:	83 c4 20             	add    $0x20,%esp
                ap++;
    207c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2080:	e9 d2 00 00 00       	jmp    2157 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2085:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2089:	75 46                	jne    20d1 <sprintf+0x178>
                s = (char*)*ap;
    208b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    208e:	8b 00                	mov    (%eax),%eax
    2090:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2093:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2097:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    209b:	75 25                	jne    20c2 <sprintf+0x169>
                    s = "(null)";
    209d:	c7 45 f4 24 23 00 00 	movl   $0x2324,-0xc(%ebp)
                while(*s != 0){
    20a4:	eb 1c                	jmp    20c2 <sprintf+0x169>
                    dst[j++] = *s;
    20a6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20a9:	8d 50 01             	lea    0x1(%eax),%edx
    20ac:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20af:	89 c2                	mov    %eax,%edx
    20b1:	8b 45 08             	mov    0x8(%ebp),%eax
    20b4:	01 c2                	add    %eax,%edx
    20b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20b9:	0f b6 00             	movzbl (%eax),%eax
    20bc:	88 02                	mov    %al,(%edx)
                    s++;
    20be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    20c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20c5:	0f b6 00             	movzbl (%eax),%eax
    20c8:	84 c0                	test   %al,%al
    20ca:	75 da                	jne    20a6 <sprintf+0x14d>
    20cc:	e9 86 00 00 00       	jmp    2157 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    20d1:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    20d5:	75 1d                	jne    20f4 <sprintf+0x19b>
                dst[j++] = *ap;
    20d7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20da:	8d 50 01             	lea    0x1(%eax),%edx
    20dd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20e0:	89 c2                	mov    %eax,%edx
    20e2:	8b 45 08             	mov    0x8(%ebp),%eax
    20e5:	01 c2                	add    %eax,%edx
    20e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20ea:	8b 00                	mov    (%eax),%eax
    20ec:	88 02                	mov    %al,(%edx)
                ap++;
    20ee:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20f2:	eb 63                	jmp    2157 <sprintf+0x1fe>
            } else if(c == '%'){
    20f4:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20f8:	75 17                	jne    2111 <sprintf+0x1b8>
                dst[j++] = c;
    20fa:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20fd:	8d 50 01             	lea    0x1(%eax),%edx
    2100:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2103:	89 c2                	mov    %eax,%edx
    2105:	8b 45 08             	mov    0x8(%ebp),%eax
    2108:	01 d0                	add    %edx,%eax
    210a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    210d:	88 10                	mov    %dl,(%eax)
    210f:	eb 46                	jmp    2157 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2111:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2115:	7e 18                	jle    212f <sprintf+0x1d6>
    2117:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    211b:	7f 12                	jg     212f <sprintf+0x1d6>
            {
                buf[bi++] = c;
    211d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2120:	8d 50 01             	lea    0x1(%eax),%edx
    2123:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2126:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2129:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    212d:	eb 2f                	jmp    215e <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    212f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2132:	8d 50 01             	lea    0x1(%eax),%edx
    2135:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2138:	89 c2                	mov    %eax,%edx
    213a:	8b 45 08             	mov    0x8(%ebp),%eax
    213d:	01 d0                	add    %edx,%eax
    213f:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2142:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2145:	8d 50 01             	lea    0x1(%eax),%edx
    2148:	89 55 c8             	mov    %edx,-0x38(%ebp)
    214b:	89 c2                	mov    %eax,%edx
    214d:	8b 45 08             	mov    0x8(%ebp),%eax
    2150:	01 d0                	add    %edx,%eax
    2152:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2155:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2157:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    215e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2162:	8b 55 0c             	mov    0xc(%ebp),%edx
    2165:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2168:	01 d0                	add    %edx,%eax
    216a:	0f b6 00             	movzbl (%eax),%eax
    216d:	84 c0                	test   %al,%al
    216f:	0f 85 14 fe ff ff    	jne    1f89 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2175:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2178:	8d 50 01             	lea    0x1(%eax),%edx
    217b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    217e:	89 c2                	mov    %eax,%edx
    2180:	8b 45 08             	mov    0x8(%ebp),%eax
    2183:	01 d0                	add    %edx,%eax
    2185:	c6 00 00             	movb   $0x0,(%eax)
}
    2188:	90                   	nop
    2189:	c9                   	leave  
    218a:	c3                   	ret    
