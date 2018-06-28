
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
      2b:	68 8c 1f 00 00       	push   $0x1f8c
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
      78:	68 9f 1f 00 00       	push   $0x1f9f
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
      ea:	68 a9 1f 00 00       	push   $0x1fa9
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
     4e4:	0f b6 80 1c 26 00 00 	movzbl 0x261c(%eax),%eax
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
     622:	c7 45 f4 af 1f 00 00 	movl   $0x1faf,-0xc(%ebp)
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
     6e8:	a1 4c 26 00 00       	mov    0x264c,%eax
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
     7b3:	a3 4c 26 00 00       	mov    %eax,0x264c
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
     814:	a1 4c 26 00 00       	mov    0x264c,%eax
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
     830:	a1 4c 26 00 00       	mov    0x264c,%eax
     835:	89 45 f0             	mov    %eax,-0x10(%ebp)
     838:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     83c:	75 23                	jne    861 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     83e:	c7 45 f0 44 26 00 00 	movl   $0x2644,-0x10(%ebp)
     845:	8b 45 f0             	mov    -0x10(%ebp),%eax
     848:	a3 4c 26 00 00       	mov    %eax,0x264c
     84d:	a1 4c 26 00 00       	mov    0x264c,%eax
     852:	a3 44 26 00 00       	mov    %eax,0x2644
    base.s.size = 0;
     857:	c7 05 48 26 00 00 00 	movl   $0x0,0x2648
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
     8b4:	a3 4c 26 00 00       	mov    %eax,0x264c
      return (void*)(p + 1);
     8b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bc:	83 c0 08             	add    $0x8,%eax
     8bf:	eb 3b                	jmp    8fc <malloc+0xe1>
    }
    if(p == freep)
     8c1:	a1 4c 26 00 00       	mov    0x264c,%eax
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
     9d1:	56                   	push   %esi
     9d2:	53                   	push   %ebx
     9d3:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9d6:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9dd:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9e0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9e3:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9ea:	83 ec 08             	sub    $0x8,%esp
     9ed:	6a 00                	push   $0x0
     9ef:	ff 75 0c             	pushl  0xc(%ebp)
     9f2:	e8 f2 f9 ff ff       	call   3e9 <open>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     9fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a01:	79 2e                	jns    a31 <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     a03:	83 ec 04             	sub    $0x4,%esp
     a06:	ff 75 0c             	pushl  0xc(%ebp)
     a09:	68 b8 1f 00 00       	push   $0x1fb8
     a0e:	6a 01                	push   $0x1
     a10:	e8 33 fb ff ff       	call   548 <printf>
     a15:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a18:	8b 45 08             	mov    0x8(%ebp),%eax
     a1b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a1e:	89 10                	mov    %edx,(%eax)
     a20:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a23:	89 50 04             	mov    %edx,0x4(%eax)
     a26:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a29:	89 50 08             	mov    %edx,0x8(%eax)
     a2c:	e9 1b 02 00 00       	jmp    c4c <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a31:	83 ec 04             	sub    $0x4,%esp
     a34:	6a 10                	push   $0x10
     a36:	8d 45 b8             	lea    -0x48(%ebp),%eax
     a39:	50                   	push   %eax
     a3a:	ff 75 ec             	pushl  -0x14(%ebp)
     a3d:	e8 7f f9 ff ff       	call   3c1 <read>
     a42:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     a45:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     a49:	0f b7 f0             	movzwl %ax,%esi
     a4c:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     a50:	0f b7 d8             	movzwl %ax,%ebx
     a53:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     a56:	8b 55 bc             	mov    -0x44(%ebp),%edx
     a59:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     a5d:	0f b7 c0             	movzwl %ax,%eax
     a60:	83 ec 04             	sub    $0x4,%esp
     a63:	56                   	push   %esi
     a64:	53                   	push   %ebx
     a65:	51                   	push   %ecx
     a66:	52                   	push   %edx
     a67:	50                   	push   %eax
     a68:	68 c8 1f 00 00       	push   $0x1fc8
     a6d:	6a 01                	push   $0x1
     a6f:	e8 d4 fa ff ff       	call   548 <printf>
     a74:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a77:	83 ec 04             	sub    $0x4,%esp
     a7a:	6a 28                	push   $0x28
     a7c:	8d 45 90             	lea    -0x70(%ebp),%eax
     a7f:	50                   	push   %eax
     a80:	ff 75 ec             	pushl  -0x14(%ebp)
     a83:	e8 39 f9 ff ff       	call   3c1 <read>
     a88:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a8b:	8b 45 94             	mov    -0x6c(%ebp),%eax
     a8e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a91:	8b 45 98             	mov    -0x68(%ebp),%eax
     a94:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     a97:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a9a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a9d:	52                   	push   %edx
     a9e:	50                   	push   %eax
     a9f:	68 d8 1f 00 00       	push   $0x1fd8
     aa4:	6a 01                	push   $0x1
     aa6:	e8 9d fa ff ff       	call   548 <printf>
     aab:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     aae:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ab1:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ab4:	0f af d0             	imul   %eax,%edx
     ab7:	89 d0                	mov    %edx,%eax
     ab9:	01 c0                	add    %eax,%eax
     abb:	01 d0                	add    %edx,%eax
     abd:	83 ec 0c             	sub    $0xc,%esp
     ac0:	50                   	push   %eax
     ac1:	e8 55 fd ff ff       	call   81b <malloc>
     ac6:	83 c4 10             	add    $0x10,%esp
     ac9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     acc:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     ad0:	0f b7 c0             	movzwl %ax,%eax
     ad3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     ad6:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ad9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     adc:	0f af c2             	imul   %edx,%eax
     adf:	83 c0 1f             	add    $0x1f,%eax
     ae2:	c1 e8 05             	shr    $0x5,%eax
     ae5:	c1 e0 02             	shl    $0x2,%eax
     ae8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     aeb:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     af1:	0f af c2             	imul   %edx,%eax
     af4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     af7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     afa:	83 ec 0c             	sub    $0xc,%esp
     afd:	50                   	push   %eax
     afe:	e8 18 fd ff ff       	call   81b <malloc>
     b03:	83 c4 10             	add    $0x10,%esp
     b06:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     b09:	83 ec 04             	sub    $0x4,%esp
     b0c:	ff 75 e0             	pushl  -0x20(%ebp)
     b0f:	ff 75 dc             	pushl  -0x24(%ebp)
     b12:	ff 75 ec             	pushl  -0x14(%ebp)
     b15:	e8 a7 f8 ff ff       	call   3c1 <read>
     b1a:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     b1d:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     b21:	66 c1 e8 03          	shr    $0x3,%ax
     b25:	0f b7 c0             	movzwl %ax,%eax
     b28:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     b2b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b32:	e9 e5 00 00 00       	jmp    c1c <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     b37:	8b 55 cc             	mov    -0x34(%ebp),%edx
     b3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b3d:	29 c2                	sub    %eax,%edx
     b3f:	89 d0                	mov    %edx,%eax
     b41:	8d 50 ff             	lea    -0x1(%eax),%edx
     b44:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b47:	0f af c2             	imul   %edx,%eax
     b4a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b4d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b54:	e9 b1 00 00 00       	jmp    c0a <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b59:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b5c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b62:	01 c8                	add    %ecx,%eax
     b64:	89 c1                	mov    %eax,%ecx
     b66:	89 c8                	mov    %ecx,%eax
     b68:	01 c0                	add    %eax,%eax
     b6a:	01 c8                	add    %ecx,%eax
     b6c:	01 c2                	add    %eax,%edx
     b6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b71:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b75:	89 c1                	mov    %eax,%ecx
     b77:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b7a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b7e:	01 c1                	add    %eax,%ecx
     b80:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b83:	01 c8                	add    %ecx,%eax
     b85:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b88:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b8b:	01 c8                	add    %ecx,%eax
     b8d:	0f b6 00             	movzbl (%eax),%eax
     b90:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b93:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b96:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b99:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b9c:	01 c8                	add    %ecx,%eax
     b9e:	89 c1                	mov    %eax,%ecx
     ba0:	89 c8                	mov    %ecx,%eax
     ba2:	01 c0                	add    %eax,%eax
     ba4:	01 c8                	add    %ecx,%eax
     ba6:	01 c2                	add    %eax,%edx
     ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bab:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     baf:	89 c1                	mov    %eax,%ecx
     bb1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bb4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bb8:	01 c1                	add    %eax,%ecx
     bba:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bbd:	01 c8                	add    %ecx,%eax
     bbf:	8d 48 fe             	lea    -0x2(%eax),%ecx
     bc2:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bc5:	01 c8                	add    %ecx,%eax
     bc7:	0f b6 00             	movzbl (%eax),%eax
     bca:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     bcd:	8b 55 d0             	mov    -0x30(%ebp),%edx
     bd0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     bd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd6:	01 c8                	add    %ecx,%eax
     bd8:	89 c1                	mov    %eax,%ecx
     bda:	89 c8                	mov    %ecx,%eax
     bdc:	01 c0                	add    %eax,%eax
     bde:	01 c8                	add    %ecx,%eax
     be0:	01 c2                	add    %eax,%edx
     be2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be5:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     be9:	89 c1                	mov    %eax,%ecx
     beb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bee:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bf2:	01 c1                	add    %eax,%ecx
     bf4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bf7:	01 c8                	add    %ecx,%eax
     bf9:	8d 48 fd             	lea    -0x3(%eax),%ecx
     bfc:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bff:	01 c8                	add    %ecx,%eax
     c01:	0f b6 00             	movzbl (%eax),%eax
     c04:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     c06:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     c0a:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c10:	39 c2                	cmp    %eax,%edx
     c12:	0f 87 41 ff ff ff    	ja     b59 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     c18:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c1c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c22:	39 c2                	cmp    %eax,%edx
     c24:	0f 87 0d ff ff ff    	ja     b37 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     c2a:	83 ec 0c             	sub    $0xc,%esp
     c2d:	ff 75 ec             	pushl  -0x14(%ebp)
     c30:	e8 9c f7 ff ff       	call   3d1 <close>
     c35:	83 c4 10             	add    $0x10,%esp
    return bmp;
     c38:	8b 45 08             	mov    0x8(%ebp),%eax
     c3b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c3e:	89 10                	mov    %edx,(%eax)
     c40:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c43:	89 50 04             	mov    %edx,0x4(%eax)
     c46:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c49:	89 50 08             	mov    %edx,0x8(%eax)
}
     c4c:	8b 45 08             	mov    0x8(%ebp),%eax
     c4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c52:	5b                   	pop    %ebx
     c53:	5e                   	pop    %esi
     c54:	5d                   	pop    %ebp
     c55:	c2 04 00             	ret    $0x4

00000c58 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c58:	55                   	push   %ebp
     c59:	89 e5                	mov    %esp,%ebp
     c5b:	53                   	push   %ebx
     c5c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c5f:	83 ec 0c             	sub    $0xc,%esp
     c62:	6a 1c                	push   $0x1c
     c64:	e8 b2 fb ff ff       	call   81b <malloc>
     c69:	83 c4 10             	add    $0x10,%esp
     c6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c72:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c79:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c7c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c7f:	6a 0c                	push   $0xc
     c81:	6a 0c                	push   $0xc
     c83:	6a 0c                	push   $0xc
     c85:	50                   	push   %eax
     c86:	e8 73 fc ff ff       	call   8fe <RGB>
     c8b:	83 c4 0c             	add    $0xc,%esp
     c8e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c92:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c96:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c9a:	88 43 15             	mov    %al,0x15(%ebx)
     c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ca3:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     ca7:	66 89 48 10          	mov    %cx,0x10(%eax)
     cab:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     caf:	88 50 12             	mov    %dl,0x12(%eax)
     cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cb8:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     cbc:	66 89 48 08          	mov    %cx,0x8(%eax)
     cc0:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     cc4:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     cc7:	8b 45 08             	mov    0x8(%ebp),%eax
     cca:	89 c2                	mov    %eax,%edx
     ccc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccf:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
     cd4:	89 c2                	mov    %eax,%edx
     cd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd9:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     cdc:	8b 55 10             	mov    0x10(%ebp),%edx
     cdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce2:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     ce5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ce8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ceb:	c9                   	leave  
     cec:	c3                   	ret    

00000ced <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     ced:	55                   	push   %ebp
     cee:	89 e5                	mov    %esp,%ebp
     cf0:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     cf3:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf6:	8b 50 08             	mov    0x8(%eax),%edx
     cf9:	89 55 f8             	mov    %edx,-0x8(%ebp)
     cfc:	8b 40 0c             	mov    0xc(%eax),%eax
     cff:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     d02:	8b 45 0c             	mov    0xc(%ebp),%eax
     d05:	8b 55 10             	mov    0x10(%ebp),%edx
     d08:	89 50 08             	mov    %edx,0x8(%eax)
     d0b:	8b 55 14             	mov    0x14(%ebp),%edx
     d0e:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     d11:	8b 45 08             	mov    0x8(%ebp),%eax
     d14:	8b 55 f8             	mov    -0x8(%ebp),%edx
     d17:	89 10                	mov    %edx,(%eax)
     d19:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d1c:	89 50 04             	mov    %edx,0x4(%eax)
}
     d1f:	8b 45 08             	mov    0x8(%ebp),%eax
     d22:	c9                   	leave  
     d23:	c2 04 00             	ret    $0x4

00000d26 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     d26:	55                   	push   %ebp
     d27:	89 e5                	mov    %esp,%ebp
     d29:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d2f:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     d33:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d37:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     d3b:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     d3e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d41:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d45:	66 89 50 10          	mov    %dx,0x10(%eax)
     d49:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d4d:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d50:	8b 45 08             	mov    0x8(%ebp),%eax
     d53:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d57:	66 89 10             	mov    %dx,(%eax)
     d5a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d5e:	88 50 02             	mov    %dl,0x2(%eax)
}
     d61:	8b 45 08             	mov    0x8(%ebp),%eax
     d64:	c9                   	leave  
     d65:	c2 04 00             	ret    $0x4

00000d68 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d68:	55                   	push   %ebp
     d69:	89 e5                	mov    %esp,%ebp
     d6b:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d6e:	8b 45 08             	mov    0x8(%ebp),%eax
     d71:	8b 40 0c             	mov    0xc(%eax),%eax
     d74:	89 c2                	mov    %eax,%edx
     d76:	c1 ea 1f             	shr    $0x1f,%edx
     d79:	01 d0                	add    %edx,%eax
     d7b:	d1 f8                	sar    %eax
     d7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d83:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d87:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d8a:	8b 45 10             	mov    0x10(%ebp),%eax
     d8d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d90:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d93:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d97:	0f 89 98 00 00 00    	jns    e35 <APDrawPoint+0xcd>
        i = 0;
     d9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     da4:	e9 8c 00 00 00       	jmp    e35 <APDrawPoint+0xcd>
    {
        j = x - off;
     da9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dac:	2b 45 f4             	sub    -0xc(%ebp),%eax
     daf:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     db2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     db6:	79 69                	jns    e21 <APDrawPoint+0xb9>
            j = 0;
     db8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     dbf:	eb 60                	jmp    e21 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     dc1:	ff 75 fc             	pushl  -0x4(%ebp)
     dc4:	ff 75 f8             	pushl  -0x8(%ebp)
     dc7:	ff 75 08             	pushl  0x8(%ebp)
     dca:	e8 ad fb ff ff       	call   97c <APGetIndex>
     dcf:	83 c4 0c             	add    $0xc,%esp
     dd2:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     dd5:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     dd9:	74 55                	je     e30 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ddb:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     ddf:	74 67                	je     e48 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     de1:	ff 75 10             	pushl  0x10(%ebp)
     de4:	ff 75 0c             	pushl  0xc(%ebp)
     de7:	ff 75 fc             	pushl  -0x4(%ebp)
     dea:	ff 75 f8             	pushl  -0x8(%ebp)
     ded:	e8 51 fb ff ff       	call   943 <distance_2>
     df2:	83 c4 10             	add    $0x10,%esp
     df5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     df8:	7f 23                	jg     e1d <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     dfa:	8b 45 08             	mov    0x8(%ebp),%eax
     dfd:	8b 48 18             	mov    0x18(%eax),%ecx
     e00:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e03:	89 d0                	mov    %edx,%eax
     e05:	01 c0                	add    %eax,%eax
     e07:	01 d0                	add    %edx,%eax
     e09:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e0c:	8b 45 08             	mov    0x8(%ebp),%eax
     e0f:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e13:	66 89 0a             	mov    %cx,(%edx)
     e16:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e1a:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e1d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e21:	8b 55 0c             	mov    0xc(%ebp),%edx
     e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e27:	01 d0                	add    %edx,%eax
     e29:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e2c:	7d 93                	jge    dc1 <APDrawPoint+0x59>
     e2e:	eb 01                	jmp    e31 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e30:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e31:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e35:	8b 55 10             	mov    0x10(%ebp),%edx
     e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3b:	01 d0                	add    %edx,%eax
     e3d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e40:	0f 8d 63 ff ff ff    	jge    da9 <APDrawPoint+0x41>
     e46:	eb 01                	jmp    e49 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e48:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e49:	c9                   	leave  
     e4a:	c3                   	ret    

00000e4b <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e4b:	55                   	push   %ebp
     e4c:	89 e5                	mov    %esp,%ebp
     e4e:	53                   	push   %ebx
     e4f:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e52:	8b 45 0c             	mov    0xc(%ebp),%eax
     e55:	3b 45 14             	cmp    0x14(%ebp),%eax
     e58:	0f 85 80 00 00 00    	jne    ede <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e5e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e62:	0f 88 9d 02 00 00    	js     1105 <APDrawLine+0x2ba>
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	8b 00                	mov    (%eax),%eax
     e6d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e70:	0f 8e 8f 02 00 00    	jle    1105 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e76:	8b 45 10             	mov    0x10(%ebp),%eax
     e79:	3b 45 18             	cmp    0x18(%ebp),%eax
     e7c:	7e 12                	jle    e90 <APDrawLine+0x45>
        {
            int tmp = y2;
     e7e:	8b 45 18             	mov    0x18(%ebp),%eax
     e81:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e84:	8b 45 10             	mov    0x10(%ebp),%eax
     e87:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e8a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e8d:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e94:	79 07                	jns    e9d <APDrawLine+0x52>
     e96:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e9d:	8b 45 08             	mov    0x8(%ebp),%eax
     ea0:	8b 40 04             	mov    0x4(%eax),%eax
     ea3:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea6:	7d 0c                	jge    eb4 <APDrawLine+0x69>
     ea8:	8b 45 08             	mov    0x8(%ebp),%eax
     eab:	8b 40 04             	mov    0x4(%eax),%eax
     eae:	83 e8 01             	sub    $0x1,%eax
     eb1:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     eb4:	8b 45 10             	mov    0x10(%ebp),%eax
     eb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     eba:	eb 15                	jmp    ed1 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     ebc:	ff 75 f4             	pushl  -0xc(%ebp)
     ebf:	ff 75 0c             	pushl  0xc(%ebp)
     ec2:	ff 75 08             	pushl  0x8(%ebp)
     ec5:	e8 9e fe ff ff       	call   d68 <APDrawPoint>
     eca:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     ecd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ed1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed4:	3b 45 18             	cmp    0x18(%ebp),%eax
     ed7:	7e e3                	jle    ebc <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     ed9:	e9 2b 02 00 00       	jmp    1109 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     ede:	8b 45 10             	mov    0x10(%ebp),%eax
     ee1:	3b 45 18             	cmp    0x18(%ebp),%eax
     ee4:	75 7f                	jne    f65 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ee6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eea:	0f 88 18 02 00 00    	js     1108 <APDrawLine+0x2bd>
     ef0:	8b 45 08             	mov    0x8(%ebp),%eax
     ef3:	8b 40 04             	mov    0x4(%eax),%eax
     ef6:	3b 45 10             	cmp    0x10(%ebp),%eax
     ef9:	0f 8e 09 02 00 00    	jle    1108 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     eff:	8b 45 0c             	mov    0xc(%ebp),%eax
     f02:	3b 45 14             	cmp    0x14(%ebp),%eax
     f05:	7e 12                	jle    f19 <APDrawLine+0xce>
        {
            int tmp = x2;
     f07:	8b 45 14             	mov    0x14(%ebp),%eax
     f0a:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f10:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f13:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f16:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f19:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f1d:	79 07                	jns    f26 <APDrawLine+0xdb>
     f1f:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f26:	8b 45 08             	mov    0x8(%ebp),%eax
     f29:	8b 00                	mov    (%eax),%eax
     f2b:	3b 45 14             	cmp    0x14(%ebp),%eax
     f2e:	7d 0b                	jge    f3b <APDrawLine+0xf0>
     f30:	8b 45 08             	mov    0x8(%ebp),%eax
     f33:	8b 00                	mov    (%eax),%eax
     f35:	83 e8 01             	sub    $0x1,%eax
     f38:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     f3b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f41:	eb 15                	jmp    f58 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f43:	ff 75 10             	pushl  0x10(%ebp)
     f46:	ff 75 f0             	pushl  -0x10(%ebp)
     f49:	ff 75 08             	pushl  0x8(%ebp)
     f4c:	e8 17 fe ff ff       	call   d68 <APDrawPoint>
     f51:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f54:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f58:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f5b:	3b 45 14             	cmp    0x14(%ebp),%eax
     f5e:	7e e3                	jle    f43 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f60:	e9 a4 01 00 00       	jmp    1109 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f65:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f6c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f73:	8b 45 0c             	mov    0xc(%ebp),%eax
     f76:	2b 45 14             	sub    0x14(%ebp),%eax
     f79:	50                   	push   %eax
     f7a:	e8 ed f9 ff ff       	call   96c <abs_int>
     f7f:	83 c4 04             	add    $0x4,%esp
     f82:	89 c3                	mov    %eax,%ebx
     f84:	8b 45 10             	mov    0x10(%ebp),%eax
     f87:	2b 45 18             	sub    0x18(%ebp),%eax
     f8a:	50                   	push   %eax
     f8b:	e8 dc f9 ff ff       	call   96c <abs_int>
     f90:	83 c4 04             	add    $0x4,%esp
     f93:	39 c3                	cmp    %eax,%ebx
     f95:	0f 8e b5 00 00 00    	jle    1050 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f9b:	8b 45 10             	mov    0x10(%ebp),%eax
     f9e:	2b 45 18             	sub    0x18(%ebp),%eax
     fa1:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa4:	db 45 b0             	fildl  -0x50(%ebp)
     fa7:	8b 45 0c             	mov    0xc(%ebp),%eax
     faa:	2b 45 14             	sub    0x14(%ebp),%eax
     fad:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fb0:	db 45 b0             	fildl  -0x50(%ebp)
     fb3:	de f9                	fdivrp %st,%st(1)
     fb5:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     fb8:	8b 45 14             	mov    0x14(%ebp),%eax
     fbb:	3b 45 0c             	cmp    0xc(%ebp),%eax
     fbe:	7e 0e                	jle    fce <APDrawLine+0x183>
        {
            s = x1;
     fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     fc6:	8b 45 14             	mov    0x14(%ebp),%eax
     fc9:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fcc:	eb 0c                	jmp    fda <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     fce:	8b 45 14             	mov    0x14(%ebp),%eax
     fd1:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd7:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     fda:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fde:	79 07                	jns    fe7 <APDrawLine+0x19c>
     fe0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     fe7:	8b 45 08             	mov    0x8(%ebp),%eax
     fea:	8b 00                	mov    (%eax),%eax
     fec:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fef:	7f 0b                	jg     ffc <APDrawLine+0x1b1>
     ff1:	8b 45 08             	mov    0x8(%ebp),%eax
     ff4:	8b 00                	mov    (%eax),%eax
     ff6:	83 e8 01             	sub    $0x1,%eax
     ff9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ffc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1002:	eb 3f                	jmp    1043 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1004:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1007:	2b 45 0c             	sub    0xc(%ebp),%eax
    100a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    100d:	db 45 b0             	fildl  -0x50(%ebp)
    1010:	dc 4d d0             	fmull  -0x30(%ebp)
    1013:	db 45 10             	fildl  0x10(%ebp)
    1016:	de c1                	faddp  %st,%st(1)
    1018:	d9 7d b6             	fnstcw -0x4a(%ebp)
    101b:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    101f:	b4 0c                	mov    $0xc,%ah
    1021:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1025:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1028:	db 5d cc             	fistpl -0x34(%ebp)
    102b:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    102e:	ff 75 cc             	pushl  -0x34(%ebp)
    1031:	ff 75 e4             	pushl  -0x1c(%ebp)
    1034:	ff 75 08             	pushl  0x8(%ebp)
    1037:	e8 2c fd ff ff       	call   d68 <APDrawPoint>
    103c:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    103f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1043:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1046:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1049:	7e b9                	jle    1004 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    104b:	e9 b9 00 00 00       	jmp    1109 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1050:	8b 45 0c             	mov    0xc(%ebp),%eax
    1053:	2b 45 14             	sub    0x14(%ebp),%eax
    1056:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1059:	db 45 b0             	fildl  -0x50(%ebp)
    105c:	8b 45 10             	mov    0x10(%ebp),%eax
    105f:	2b 45 18             	sub    0x18(%ebp),%eax
    1062:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1065:	db 45 b0             	fildl  -0x50(%ebp)
    1068:	de f9                	fdivrp %st,%st(1)
    106a:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    106d:	8b 45 10             	mov    0x10(%ebp),%eax
    1070:	3b 45 18             	cmp    0x18(%ebp),%eax
    1073:	7e 0e                	jle    1083 <APDrawLine+0x238>
    {
        s = y2;
    1075:	8b 45 18             	mov    0x18(%ebp),%eax
    1078:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    107b:	8b 45 10             	mov    0x10(%ebp),%eax
    107e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1081:	eb 0c                	jmp    108f <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1083:	8b 45 10             	mov    0x10(%ebp),%eax
    1086:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1089:	8b 45 18             	mov    0x18(%ebp),%eax
    108c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    108f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1093:	79 07                	jns    109c <APDrawLine+0x251>
    1095:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    109c:	8b 45 08             	mov    0x8(%ebp),%eax
    109f:	8b 40 04             	mov    0x4(%eax),%eax
    10a2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10a5:	7f 0c                	jg     10b3 <APDrawLine+0x268>
    10a7:	8b 45 08             	mov    0x8(%ebp),%eax
    10aa:	8b 40 04             	mov    0x4(%eax),%eax
    10ad:	83 e8 01             	sub    $0x1,%eax
    10b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    10b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10b9:	eb 3f                	jmp    10fa <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    10bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10be:	2b 45 10             	sub    0x10(%ebp),%eax
    10c1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10c4:	db 45 b0             	fildl  -0x50(%ebp)
    10c7:	dc 4d c0             	fmull  -0x40(%ebp)
    10ca:	db 45 0c             	fildl  0xc(%ebp)
    10cd:	de c1                	faddp  %st,%st(1)
    10cf:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10d2:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10d6:	b4 0c                	mov    $0xc,%ah
    10d8:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10dc:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10df:	db 5d bc             	fistpl -0x44(%ebp)
    10e2:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10e5:	ff 75 e0             	pushl  -0x20(%ebp)
    10e8:	ff 75 bc             	pushl  -0x44(%ebp)
    10eb:	ff 75 08             	pushl  0x8(%ebp)
    10ee:	e8 75 fc ff ff       	call   d68 <APDrawPoint>
    10f3:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10f6:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10fd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1100:	7e b9                	jle    10bb <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1102:	90                   	nop
    1103:	eb 04                	jmp    1109 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1105:	90                   	nop
    1106:	eb 01                	jmp    1109 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1108:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1109:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    110c:	c9                   	leave  
    110d:	c3                   	ret    

0000110e <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    110e:	55                   	push   %ebp
    110f:	89 e5                	mov    %esp,%ebp
    1111:	53                   	push   %ebx
    1112:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1115:	8b 55 10             	mov    0x10(%ebp),%edx
    1118:	8b 45 18             	mov    0x18(%ebp),%eax
    111b:	01 d0                	add    %edx,%eax
    111d:	83 e8 01             	sub    $0x1,%eax
    1120:	83 ec 04             	sub    $0x4,%esp
    1123:	50                   	push   %eax
    1124:	ff 75 0c             	pushl  0xc(%ebp)
    1127:	ff 75 10             	pushl  0x10(%ebp)
    112a:	ff 75 0c             	pushl  0xc(%ebp)
    112d:	ff 75 08             	pushl  0x8(%ebp)
    1130:	e8 16 fd ff ff       	call   e4b <APDrawLine>
    1135:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1138:	8b 55 0c             	mov    0xc(%ebp),%edx
    113b:	8b 45 14             	mov    0x14(%ebp),%eax
    113e:	01 d0                	add    %edx,%eax
    1140:	83 e8 01             	sub    $0x1,%eax
    1143:	83 ec 04             	sub    $0x4,%esp
    1146:	ff 75 10             	pushl  0x10(%ebp)
    1149:	50                   	push   %eax
    114a:	ff 75 10             	pushl  0x10(%ebp)
    114d:	ff 75 0c             	pushl  0xc(%ebp)
    1150:	ff 75 08             	pushl  0x8(%ebp)
    1153:	e8 f3 fc ff ff       	call   e4b <APDrawLine>
    1158:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    115b:	8b 55 10             	mov    0x10(%ebp),%edx
    115e:	8b 45 18             	mov    0x18(%ebp),%eax
    1161:	01 d0                	add    %edx,%eax
    1163:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1166:	8b 55 0c             	mov    0xc(%ebp),%edx
    1169:	8b 45 14             	mov    0x14(%ebp),%eax
    116c:	01 d0                	add    %edx,%eax
    116e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1171:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1174:	8b 45 14             	mov    0x14(%ebp),%eax
    1177:	01 d8                	add    %ebx,%eax
    1179:	83 e8 01             	sub    $0x1,%eax
    117c:	83 ec 04             	sub    $0x4,%esp
    117f:	51                   	push   %ecx
    1180:	52                   	push   %edx
    1181:	ff 75 10             	pushl  0x10(%ebp)
    1184:	50                   	push   %eax
    1185:	ff 75 08             	pushl  0x8(%ebp)
    1188:	e8 be fc ff ff       	call   e4b <APDrawLine>
    118d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1190:	8b 55 10             	mov    0x10(%ebp),%edx
    1193:	8b 45 18             	mov    0x18(%ebp),%eax
    1196:	01 d0                	add    %edx,%eax
    1198:	8d 48 ff             	lea    -0x1(%eax),%ecx
    119b:	8b 55 0c             	mov    0xc(%ebp),%edx
    119e:	8b 45 14             	mov    0x14(%ebp),%eax
    11a1:	01 d0                	add    %edx,%eax
    11a3:	8d 50 ff             	lea    -0x1(%eax),%edx
    11a6:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11a9:	8b 45 18             	mov    0x18(%ebp),%eax
    11ac:	01 d8                	add    %ebx,%eax
    11ae:	83 e8 01             	sub    $0x1,%eax
    11b1:	83 ec 04             	sub    $0x4,%esp
    11b4:	51                   	push   %ecx
    11b5:	52                   	push   %edx
    11b6:	50                   	push   %eax
    11b7:	ff 75 0c             	pushl  0xc(%ebp)
    11ba:	ff 75 08             	pushl  0x8(%ebp)
    11bd:	e8 89 fc ff ff       	call   e4b <APDrawLine>
    11c2:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    11c5:	8b 55 0c             	mov    0xc(%ebp),%edx
    11c8:	8b 45 14             	mov    0x14(%ebp),%eax
    11cb:	01 d0                	add    %edx,%eax
    11cd:	8d 50 ff             	lea    -0x1(%eax),%edx
    11d0:	8b 45 08             	mov    0x8(%ebp),%eax
    11d3:	8b 40 0c             	mov    0xc(%eax),%eax
    11d6:	89 c1                	mov    %eax,%ecx
    11d8:	c1 e9 1f             	shr    $0x1f,%ecx
    11db:	01 c8                	add    %ecx,%eax
    11dd:	d1 f8                	sar    %eax
    11df:	29 c2                	sub    %eax,%edx
    11e1:	89 d0                	mov    %edx,%eax
    11e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11e6:	8b 55 10             	mov    0x10(%ebp),%edx
    11e9:	8b 45 18             	mov    0x18(%ebp),%eax
    11ec:	01 d0                	add    %edx,%eax
    11ee:	8d 50 ff             	lea    -0x1(%eax),%edx
    11f1:	8b 45 08             	mov    0x8(%ebp),%eax
    11f4:	8b 40 0c             	mov    0xc(%eax),%eax
    11f7:	89 c1                	mov    %eax,%ecx
    11f9:	c1 e9 1f             	shr    $0x1f,%ecx
    11fc:	01 c8                	add    %ecx,%eax
    11fe:	d1 f8                	sar    %eax
    1200:	29 c2                	sub    %eax,%edx
    1202:	89 d0                	mov    %edx,%eax
    1204:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1207:	8b 45 08             	mov    0x8(%ebp),%eax
    120a:	8b 40 0c             	mov    0xc(%eax),%eax
    120d:	89 c2                	mov    %eax,%edx
    120f:	c1 ea 1f             	shr    $0x1f,%edx
    1212:	01 d0                	add    %edx,%eax
    1214:	d1 f8                	sar    %eax
    1216:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	8b 40 0c             	mov    0xc(%eax),%eax
    121f:	89 c2                	mov    %eax,%edx
    1221:	c1 ea 1f             	shr    $0x1f,%edx
    1224:	01 d0                	add    %edx,%eax
    1226:	d1 f8                	sar    %eax
    1228:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    122b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    122f:	0f 88 d8 00 00 00    	js     130d <APDrawRect+0x1ff>
    1235:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1239:	0f 88 ce 00 00 00    	js     130d <APDrawRect+0x1ff>
    123f:	8b 45 08             	mov    0x8(%ebp),%eax
    1242:	8b 00                	mov    (%eax),%eax
    1244:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1247:	0f 8e c0 00 00 00    	jle    130d <APDrawRect+0x1ff>
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	8b 40 04             	mov    0x4(%eax),%eax
    1253:	3b 45 10             	cmp    0x10(%ebp),%eax
    1256:	0f 8e b1 00 00 00    	jle    130d <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    125c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1260:	79 07                	jns    1269 <APDrawRect+0x15b>
    1262:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1269:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    126d:	79 07                	jns    1276 <APDrawRect+0x168>
    126f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1276:	8b 45 08             	mov    0x8(%ebp),%eax
    1279:	8b 00                	mov    (%eax),%eax
    127b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    127e:	7f 0b                	jg     128b <APDrawRect+0x17d>
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
    1283:	8b 00                	mov    (%eax),%eax
    1285:	83 e8 01             	sub    $0x1,%eax
    1288:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    128b:	8b 45 08             	mov    0x8(%ebp),%eax
    128e:	8b 40 04             	mov    0x4(%eax),%eax
    1291:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1294:	7f 0c                	jg     12a2 <APDrawRect+0x194>
    1296:	8b 45 08             	mov    0x8(%ebp),%eax
    1299:	8b 40 04             	mov    0x4(%eax),%eax
    129c:	83 e8 01             	sub    $0x1,%eax
    129f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    12a2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12af:	eb 52                	jmp    1303 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    12b1:	8b 45 10             	mov    0x10(%ebp),%eax
    12b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    12b7:	eb 3e                	jmp    12f7 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    12b9:	83 ec 04             	sub    $0x4,%esp
    12bc:	ff 75 e8             	pushl  -0x18(%ebp)
    12bf:	ff 75 ec             	pushl  -0x14(%ebp)
    12c2:	ff 75 08             	pushl  0x8(%ebp)
    12c5:	e8 b2 f6 ff ff       	call   97c <APGetIndex>
    12ca:	83 c4 10             	add    $0x10,%esp
    12cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    12d0:	8b 45 08             	mov    0x8(%ebp),%eax
    12d3:	8b 48 18             	mov    0x18(%eax),%ecx
    12d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    12d9:	89 d0                	mov    %edx,%eax
    12db:	01 c0                	add    %eax,%eax
    12dd:	01 d0                	add    %edx,%eax
    12df:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12e2:	8b 45 08             	mov    0x8(%ebp),%eax
    12e5:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12e9:	66 89 0a             	mov    %cx,(%edx)
    12ec:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12f0:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12f3:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12fa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12fd:	7e ba                	jle    12b9 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12ff:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1303:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1306:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1309:	7e a6                	jle    12b1 <APDrawRect+0x1a3>
    130b:	eb 01                	jmp    130e <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    130d:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    130e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1311:	c9                   	leave  
    1312:	c3                   	ret    

00001313 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1313:	55                   	push   %ebp
    1314:	89 e5                	mov    %esp,%ebp
    1316:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1319:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    131d:	0f 88 8e 01 00 00    	js     14b1 <APDcCopy+0x19e>
    1323:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1327:	0f 88 84 01 00 00    	js     14b1 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    132d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1330:	8b 45 20             	mov    0x20(%ebp),%eax
    1333:	01 d0                	add    %edx,%eax
    1335:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1338:	8b 55 10             	mov    0x10(%ebp),%edx
    133b:	8b 45 24             	mov    0x24(%ebp),%eax
    133e:	01 d0                	add    %edx,%eax
    1340:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1343:	8b 55 18             	mov    0x18(%ebp),%edx
    1346:	8b 45 20             	mov    0x20(%ebp),%eax
    1349:	01 d0                	add    %edx,%eax
    134b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    134e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1351:	8b 45 24             	mov    0x24(%ebp),%eax
    1354:	01 d0                	add    %edx,%eax
    1356:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1359:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    135d:	0f 88 51 01 00 00    	js     14b4 <APDcCopy+0x1a1>
    1363:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1367:	0f 88 47 01 00 00    	js     14b4 <APDcCopy+0x1a1>
    136d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1371:	0f 88 3d 01 00 00    	js     14b4 <APDcCopy+0x1a1>
    1377:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    137b:	0f 88 33 01 00 00    	js     14b4 <APDcCopy+0x1a1>
    1381:	8b 45 14             	mov    0x14(%ebp),%eax
    1384:	8b 00                	mov    (%eax),%eax
    1386:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1389:	0f 8e 25 01 00 00    	jle    14b4 <APDcCopy+0x1a1>
    138f:	8b 45 14             	mov    0x14(%ebp),%eax
    1392:	8b 40 04             	mov    0x4(%eax),%eax
    1395:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1398:	0f 8e 16 01 00 00    	jle    14b4 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    139e:	8b 45 08             	mov    0x8(%ebp),%eax
    13a1:	8b 00                	mov    (%eax),%eax
    13a3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13a6:	7d 0b                	jge    13b3 <APDcCopy+0xa0>
    13a8:	8b 45 08             	mov    0x8(%ebp),%eax
    13ab:	8b 00                	mov    (%eax),%eax
    13ad:	83 e8 01             	sub    $0x1,%eax
    13b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    13b3:	8b 45 08             	mov    0x8(%ebp),%eax
    13b6:	8b 40 04             	mov    0x4(%eax),%eax
    13b9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13bc:	7d 0c                	jge    13ca <APDcCopy+0xb7>
    13be:	8b 45 08             	mov    0x8(%ebp),%eax
    13c1:	8b 40 04             	mov    0x4(%eax),%eax
    13c4:	83 e8 01             	sub    $0x1,%eax
    13c7:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    13ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    13d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    13d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13df:	e9 bc 00 00 00       	jmp    14a0 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    13e4:	8b 45 08             	mov    0x8(%ebp),%eax
    13e7:	8b 00                	mov    (%eax),%eax
    13e9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13ec:	8b 55 10             	mov    0x10(%ebp),%edx
    13ef:	01 ca                	add    %ecx,%edx
    13f1:	0f af d0             	imul   %eax,%edx
    13f4:	8b 45 0c             	mov    0xc(%ebp),%eax
    13f7:	01 d0                	add    %edx,%eax
    13f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13fc:	8b 45 14             	mov    0x14(%ebp),%eax
    13ff:	8b 00                	mov    (%eax),%eax
    1401:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1404:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1407:	01 ca                	add    %ecx,%edx
    1409:	0f af d0             	imul   %eax,%edx
    140c:	8b 45 18             	mov    0x18(%ebp),%eax
    140f:	01 d0                	add    %edx,%eax
    1411:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    1414:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    141b:	eb 74                	jmp    1491 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    141d:	8b 45 14             	mov    0x14(%ebp),%eax
    1420:	8b 50 18             	mov    0x18(%eax),%edx
    1423:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1426:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1429:	01 c8                	add    %ecx,%eax
    142b:	89 c1                	mov    %eax,%ecx
    142d:	89 c8                	mov    %ecx,%eax
    142f:	01 c0                	add    %eax,%eax
    1431:	01 c8                	add    %ecx,%eax
    1433:	01 d0                	add    %edx,%eax
    1435:	0f b7 10             	movzwl (%eax),%edx
    1438:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    143c:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1440:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1443:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1447:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    144b:	38 c2                	cmp    %al,%dl
    144d:	75 18                	jne    1467 <APDcCopy+0x154>
    144f:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1453:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1457:	38 c2                	cmp    %al,%dl
    1459:	75 0c                	jne    1467 <APDcCopy+0x154>
    145b:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    145f:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1463:	38 c2                	cmp    %al,%dl
    1465:	74 26                	je     148d <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1467:	8b 45 08             	mov    0x8(%ebp),%eax
    146a:	8b 50 18             	mov    0x18(%eax),%edx
    146d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1470:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1473:	01 c8                	add    %ecx,%eax
    1475:	89 c1                	mov    %eax,%ecx
    1477:	89 c8                	mov    %ecx,%eax
    1479:	01 c0                	add    %eax,%eax
    147b:	01 c8                	add    %ecx,%eax
    147d:	01 d0                	add    %edx,%eax
    147f:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1483:	66 89 10             	mov    %dx,(%eax)
    1486:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    148a:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    148d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1491:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1494:	2b 45 0c             	sub    0xc(%ebp),%eax
    1497:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    149a:	7f 81                	jg     141d <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    149c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14a3:	2b 45 10             	sub    0x10(%ebp),%eax
    14a6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14a9:	0f 8f 35 ff ff ff    	jg     13e4 <APDcCopy+0xd1>
    14af:	eb 04                	jmp    14b5 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    14b1:	90                   	nop
    14b2:	eb 01                	jmp    14b5 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    14b4:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    14b5:	c9                   	leave  
    14b6:	c3                   	ret    

000014b7 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    14b7:	55                   	push   %ebp
    14b8:	89 e5                	mov    %esp,%ebp
    14ba:	83 ec 1c             	sub    $0x1c,%esp
    14bd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    14c0:	8b 55 10             	mov    0x10(%ebp),%edx
    14c3:	8b 45 14             	mov    0x14(%ebp),%eax
    14c6:	88 4d ec             	mov    %cl,-0x14(%ebp)
    14c9:	88 55 e8             	mov    %dl,-0x18(%ebp)
    14cc:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    14cf:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    14d3:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    14d6:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    14da:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    14dd:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    14e1:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    14e4:	8b 45 08             	mov    0x8(%ebp),%eax
    14e7:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14eb:	66 89 10             	mov    %dx,(%eax)
    14ee:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14f2:	88 50 02             	mov    %dl,0x2(%eax)
}
    14f5:	8b 45 08             	mov    0x8(%ebp),%eax
    14f8:	c9                   	leave  
    14f9:	c2 04 00             	ret    $0x4

000014fc <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14fc:	55                   	push   %ebp
    14fd:	89 e5                	mov    %esp,%ebp
    14ff:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1502:	8b 45 08             	mov    0x8(%ebp),%eax
    1505:	8b 00                	mov    (%eax),%eax
    1507:	83 ec 08             	sub    $0x8,%esp
    150a:	8d 55 0c             	lea    0xc(%ebp),%edx
    150d:	52                   	push   %edx
    150e:	50                   	push   %eax
    150f:	e8 45 ef ff ff       	call   459 <sendMessage>
    1514:	83 c4 10             	add    $0x10,%esp
}
    1517:	90                   	nop
    1518:	c9                   	leave  
    1519:	c3                   	ret    

0000151a <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    151a:	55                   	push   %ebp
    151b:	89 e5                	mov    %esp,%ebp
    151d:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1520:	83 ec 0c             	sub    $0xc,%esp
    1523:	68 90 00 00 00       	push   $0x90
    1528:	e8 ee f2 ff ff       	call   81b <malloc>
    152d:	83 c4 10             	add    $0x10,%esp
    1530:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1533:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1537:	75 15                	jne    154e <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1539:	83 ec 04             	sub    $0x4,%esp
    153c:	ff 75 08             	pushl  0x8(%ebp)
    153f:	68 fc 1f 00 00       	push   $0x1ffc
    1544:	6a 01                	push   $0x1
    1546:	e8 fd ef ff ff       	call   548 <printf>
    154b:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    154e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1551:	83 c0 7c             	add    $0x7c,%eax
    1554:	83 ec 08             	sub    $0x8,%esp
    1557:	ff 75 08             	pushl  0x8(%ebp)
    155a:	50                   	push   %eax
    155b:	e8 18 ec ff ff       	call   178 <strcpy>
    1560:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1563:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1566:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    156d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1570:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1577:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157a:	8b 40 34             	mov    0x34(%eax),%eax
    157d:	89 c2                	mov    %eax,%edx
    157f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1582:	8b 40 38             	mov    0x38(%eax),%eax
    1585:	0f af d0             	imul   %eax,%edx
    1588:	89 d0                	mov    %edx,%eax
    158a:	01 c0                	add    %eax,%eax
    158c:	01 d0                	add    %edx,%eax
    158e:	83 ec 0c             	sub    $0xc,%esp
    1591:	50                   	push   %eax
    1592:	e8 84 f2 ff ff       	call   81b <malloc>
    1597:	83 c4 10             	add    $0x10,%esp
    159a:	89 c2                	mov    %eax,%edx
    159c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159f:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    15a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a5:	8b 40 4c             	mov    0x4c(%eax),%eax
    15a8:	85 c0                	test   %eax,%eax
    15aa:	75 15                	jne    15c1 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    15ac:	83 ec 04             	sub    $0x4,%esp
    15af:	ff 75 08             	pushl  0x8(%ebp)
    15b2:	68 1c 20 00 00       	push   $0x201c
    15b7:	6a 01                	push   $0x1
    15b9:	e8 8a ef ff ff       	call   548 <printf>
    15be:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    15c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c4:	8b 40 34             	mov    0x34(%eax),%eax
    15c7:	89 c2                	mov    %eax,%edx
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	8b 40 38             	mov    0x38(%eax),%eax
    15cf:	0f af d0             	imul   %eax,%edx
    15d2:	89 d0                	mov    %edx,%eax
    15d4:	01 c0                	add    %eax,%eax
    15d6:	01 c2                	add    %eax,%edx
    15d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15db:	8b 40 4c             	mov    0x4c(%eax),%eax
    15de:	83 ec 04             	sub    $0x4,%esp
    15e1:	52                   	push   %edx
    15e2:	68 ff ff ff 00       	push   $0xffffff
    15e7:	50                   	push   %eax
    15e8:	e8 21 ec ff ff       	call   20e <memset>
    15ed:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f3:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    15fa:	e8 2a ee ff ff       	call   429 <getpid>
    15ff:	89 c2                	mov    %eax,%edx
    1601:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1604:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1607:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160a:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1611:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1614:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    161e:	8b 40 50             	mov    0x50(%eax),%eax
    1621:	89 c2                	mov    %eax,%edx
    1623:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1626:	8b 40 54             	mov    0x54(%eax),%eax
    1629:	0f af d0             	imul   %eax,%edx
    162c:	89 d0                	mov    %edx,%eax
    162e:	01 c0                	add    %eax,%eax
    1630:	01 d0                	add    %edx,%eax
    1632:	83 ec 0c             	sub    $0xc,%esp
    1635:	50                   	push   %eax
    1636:	e8 e0 f1 ff ff       	call   81b <malloc>
    163b:	83 c4 10             	add    $0x10,%esp
    163e:	89 c2                	mov    %eax,%edx
    1640:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1643:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    1646:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1649:	8b 40 68             	mov    0x68(%eax),%eax
    164c:	85 c0                	test   %eax,%eax
    164e:	75 15                	jne    1665 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1650:	83 ec 04             	sub    $0x4,%esp
    1653:	ff 75 08             	pushl  0x8(%ebp)
    1656:	68 40 20 00 00       	push   $0x2040
    165b:	6a 01                	push   $0x1
    165d:	e8 e6 ee ff ff       	call   548 <printf>
    1662:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1665:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1668:	8b 40 34             	mov    0x34(%eax),%eax
    166b:	89 c2                	mov    %eax,%edx
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	8b 40 38             	mov    0x38(%eax),%eax
    1673:	0f af d0             	imul   %eax,%edx
    1676:	89 d0                	mov    %edx,%eax
    1678:	01 c0                	add    %eax,%eax
    167a:	01 c2                	add    %eax,%edx
    167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167f:	8b 40 4c             	mov    0x4c(%eax),%eax
    1682:	83 ec 04             	sub    $0x4,%esp
    1685:	52                   	push   %edx
    1686:	68 ff 00 00 00       	push   $0xff
    168b:	50                   	push   %eax
    168c:	e8 7d eb ff ff       	call   20e <memset>
    1691:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1694:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1697:	8b 55 0c             	mov    0xc(%ebp),%edx
    169a:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    169d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    16a1:	74 35                	je     16d8 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    16a3:	8b 45 10             	mov    0x10(%ebp),%eax
    16a6:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    16ac:	83 ec 0c             	sub    $0xc,%esp
    16af:	50                   	push   %eax
    16b0:	e8 66 f1 ff ff       	call   81b <malloc>
    16b5:	83 c4 10             	add    $0x10,%esp
    16b8:	89 c2                	mov    %eax,%edx
    16ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bd:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    16c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c3:	8b 55 10             	mov    0x10(%ebp),%edx
    16c6:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    16c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cc:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    16d3:	e9 8d 00 00 00       	jmp    1765 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    16d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16db:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    16e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e5:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ef:	8b 40 18             	mov    0x18(%eax),%eax
    16f2:	89 c2                	mov    %eax,%edx
    16f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f7:	8b 40 1c             	mov    0x1c(%eax),%eax
    16fa:	0f af d0             	imul   %eax,%edx
    16fd:	89 d0                	mov    %edx,%eax
    16ff:	01 c0                	add    %eax,%eax
    1701:	01 d0                	add    %edx,%eax
    1703:	83 ec 0c             	sub    $0xc,%esp
    1706:	50                   	push   %eax
    1707:	e8 0f f1 ff ff       	call   81b <malloc>
    170c:	83 c4 10             	add    $0x10,%esp
    170f:	89 c2                	mov    %eax,%edx
    1711:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1714:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    1717:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171a:	8b 40 30             	mov    0x30(%eax),%eax
    171d:	85 c0                	test   %eax,%eax
    171f:	75 15                	jne    1736 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1721:	83 ec 04             	sub    $0x4,%esp
    1724:	ff 75 08             	pushl  0x8(%ebp)
    1727:	68 68 20 00 00       	push   $0x2068
    172c:	6a 01                	push   $0x1
    172e:	e8 15 ee ff ff       	call   548 <printf>
    1733:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1736:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1739:	8b 40 18             	mov    0x18(%eax),%eax
    173c:	89 c2                	mov    %eax,%edx
    173e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1741:	8b 40 1c             	mov    0x1c(%eax),%eax
    1744:	0f af d0             	imul   %eax,%edx
    1747:	89 d0                	mov    %edx,%eax
    1749:	01 c0                	add    %eax,%eax
    174b:	01 c2                	add    %eax,%edx
    174d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1750:	8b 40 30             	mov    0x30(%eax),%eax
    1753:	83 ec 04             	sub    $0x4,%esp
    1756:	52                   	push   %edx
    1757:	68 ff ff ff 00       	push   $0xffffff
    175c:	50                   	push   %eax
    175d:	e8 ac ea ff ff       	call   20e <memset>
    1762:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1765:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1768:	c9                   	leave  
    1769:	c3                   	ret    

0000176a <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    176a:	55                   	push   %ebp
    176b:	89 e5                	mov    %esp,%ebp
    176d:	53                   	push   %ebx
    176e:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1771:	8b 45 0c             	mov    0xc(%ebp),%eax
    1774:	83 f8 03             	cmp    $0x3,%eax
    1777:	74 02                	je     177b <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1779:	eb 33                	jmp    17ae <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    177b:	8b 45 08             	mov    0x8(%ebp),%eax
    177e:	8b 48 08             	mov    0x8(%eax),%ecx
    1781:	8b 45 08             	mov    0x8(%ebp),%eax
    1784:	8b 50 38             	mov    0x38(%eax),%edx
    1787:	8b 45 08             	mov    0x8(%ebp),%eax
    178a:	8b 40 34             	mov    0x34(%eax),%eax
    178d:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1790:	83 c3 34             	add    $0x34,%ebx
    1793:	83 ec 0c             	sub    $0xc,%esp
    1796:	51                   	push   %ecx
    1797:	52                   	push   %edx
    1798:	50                   	push   %eax
    1799:	6a 00                	push   $0x0
    179b:	6a 00                	push   $0x0
    179d:	53                   	push   %ebx
    179e:	6a 32                	push   $0x32
    17a0:	6a 00                	push   $0x0
    17a2:	ff 75 08             	pushl  0x8(%ebp)
    17a5:	e8 9f ec ff ff       	call   449 <paintWindow>
    17aa:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    17ad:	90                   	nop
        default: break;
            
            
    }
    return False;
    17ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    17b6:	c9                   	leave  
    17b7:	c3                   	ret    

000017b8 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    17b8:	55                   	push   %ebp
    17b9:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    17bb:	8b 45 0c             	mov    0xc(%ebp),%eax
    17be:	8b 50 08             	mov    0x8(%eax),%edx
    17c1:	8b 45 08             	mov    0x8(%ebp),%eax
    17c4:	8b 00                	mov    (%eax),%eax
    17c6:	39 c2                	cmp    %eax,%edx
    17c8:	74 07                	je     17d1 <APPreJudge+0x19>
        return False;
    17ca:	b8 00 00 00 00       	mov    $0x0,%eax
    17cf:	eb 05                	jmp    17d6 <APPreJudge+0x1e>
    return True;
    17d1:	b8 01 00 00 00       	mov    $0x1,%eax
}
    17d6:	5d                   	pop    %ebp
    17d7:	c3                   	ret    

000017d8 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17d8:	55                   	push   %ebp
    17d9:	89 e5                	mov    %esp,%ebp
    17db:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    17de:	8b 45 08             	mov    0x8(%ebp),%eax
    17e1:	8b 55 0c             	mov    0xc(%ebp),%edx
    17e4:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    17e7:	83 ec 0c             	sub    $0xc,%esp
    17ea:	ff 75 08             	pushl  0x8(%ebp)
    17ed:	e8 77 ec ff ff       	call   469 <registWindow>
    17f2:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17f5:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17fc:	8b 45 08             	mov    0x8(%ebp),%eax
    17ff:	8b 00                	mov    (%eax),%eax
    1801:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1804:	ff 75 f4             	pushl  -0xc(%ebp)
    1807:	ff 75 f0             	pushl  -0x10(%ebp)
    180a:	ff 75 ec             	pushl  -0x14(%ebp)
    180d:	ff 75 08             	pushl  0x8(%ebp)
    1810:	e8 e7 fc ff ff       	call   14fc <APSendMessage>
    1815:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1818:	83 ec 0c             	sub    $0xc,%esp
    181b:	ff 75 08             	pushl  0x8(%ebp)
    181e:	e8 3e ec ff ff       	call   461 <getMessage>
    1823:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1826:	8b 45 08             	mov    0x8(%ebp),%eax
    1829:	83 c0 6c             	add    $0x6c,%eax
    182c:	83 ec 08             	sub    $0x8,%esp
    182f:	50                   	push   %eax
    1830:	ff 75 08             	pushl  0x8(%ebp)
    1833:	e8 80 ff ff ff       	call   17b8 <APPreJudge>
    1838:	83 c4 10             	add    $0x10,%esp
    183b:	84 c0                	test   %al,%al
    183d:	74 1b                	je     185a <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    183f:	8b 45 08             	mov    0x8(%ebp),%eax
    1842:	ff 70 74             	pushl  0x74(%eax)
    1845:	ff 70 70             	pushl  0x70(%eax)
    1848:	ff 70 6c             	pushl  0x6c(%eax)
    184b:	ff 75 08             	pushl  0x8(%ebp)
    184e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1851:	ff d0                	call   *%eax
    1853:	83 c4 10             	add    $0x10,%esp
    1856:	84 c0                	test   %al,%al
    1858:	75 0c                	jne    1866 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    185a:	8b 45 08             	mov    0x8(%ebp),%eax
    185d:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1864:	eb b2                	jmp    1818 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1866:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1867:	90                   	nop
    1868:	c9                   	leave  
    1869:	c3                   	ret    

0000186a <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    186a:	55                   	push   %ebp
    186b:	89 e5                	mov    %esp,%ebp
    186d:	57                   	push   %edi
    186e:	56                   	push   %esi
    186f:	53                   	push   %ebx
    1870:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1873:	a1 50 26 00 00       	mov    0x2650,%eax
    1878:	85 c0                	test   %eax,%eax
    187a:	75 7c                	jne    18f8 <APGridPaint+0x8e>
    {
        iconReady = 1;
    187c:	c7 05 50 26 00 00 01 	movl   $0x1,0x2650
    1883:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1886:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1889:	83 ec 08             	sub    $0x8,%esp
    188c:	68 8f 20 00 00       	push   $0x208f
    1891:	50                   	push   %eax
    1892:	e8 37 f1 ff ff       	call   9ce <APLoadBitmap>
    1897:	83 c4 0c             	add    $0xc,%esp
    189a:	8b 45 b8             	mov    -0x48(%ebp),%eax
    189d:	a3 54 26 00 00       	mov    %eax,0x2654
    18a2:	8b 45 bc             	mov    -0x44(%ebp),%eax
    18a5:	a3 58 26 00 00       	mov    %eax,0x2658
    18aa:	8b 45 c0             	mov    -0x40(%ebp),%eax
    18ad:	a3 5c 26 00 00       	mov    %eax,0x265c
        printf(1,"bitmap loaded!\n");
    18b2:	83 ec 08             	sub    $0x8,%esp
    18b5:	68 99 20 00 00       	push   $0x2099
    18ba:	6a 01                	push   $0x1
    18bc:	e8 87 ec ff ff       	call   548 <printf>
    18c1:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    18c4:	83 ec 04             	sub    $0x4,%esp
    18c7:	ff 35 5c 26 00 00    	pushl  0x265c
    18cd:	ff 35 58 26 00 00    	pushl  0x2658
    18d3:	ff 35 54 26 00 00    	pushl  0x2654
    18d9:	e8 7a f3 ff ff       	call   c58 <APCreateCompatibleDCFromBitmap>
    18de:	83 c4 10             	add    $0x10,%esp
    18e1:	a3 60 26 00 00       	mov    %eax,0x2660
        printf(1,"bitmap DC created!\n");
    18e6:	83 ec 08             	sub    $0x8,%esp
    18e9:	68 a9 20 00 00       	push   $0x20a9
    18ee:	6a 01                	push   $0x1
    18f0:	e8 53 ec ff ff       	call   548 <printf>
    18f5:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    18f8:	8b 45 08             	mov    0x8(%ebp),%eax
    18fb:	8b 40 08             	mov    0x8(%eax),%eax
    18fe:	85 c0                	test   %eax,%eax
    1900:	75 17                	jne    1919 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1902:	83 ec 08             	sub    $0x8,%esp
    1905:	68 c0 20 00 00       	push   $0x20c0
    190a:	6a 01                	push   $0x1
    190c:	e8 37 ec ff ff       	call   548 <printf>
    1911:	83 c4 10             	add    $0x10,%esp
        return;
    1914:	e9 55 03 00 00       	jmp    1c6e <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1919:	8b 45 08             	mov    0x8(%ebp),%eax
    191c:	8b 40 10             	mov    0x10(%eax),%eax
    191f:	85 c0                	test   %eax,%eax
    1921:	7e 10                	jle    1933 <APGridPaint+0xc9>
    1923:	8b 45 08             	mov    0x8(%ebp),%eax
    1926:	8b 50 14             	mov    0x14(%eax),%edx
    1929:	8b 45 08             	mov    0x8(%ebp),%eax
    192c:	8b 40 10             	mov    0x10(%eax),%eax
    192f:	39 c2                	cmp    %eax,%edx
    1931:	7c 17                	jl     194a <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1933:	83 ec 08             	sub    $0x8,%esp
    1936:	68 e6 20 00 00       	push   $0x20e6
    193b:	6a 01                	push   $0x1
    193d:	e8 06 ec ff ff       	call   548 <printf>
    1942:	83 c4 10             	add    $0x10,%esp
        return;
    1945:	e9 24 03 00 00       	jmp    1c6e <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    194a:	8b 45 08             	mov    0x8(%ebp),%eax
    194d:	8b 40 14             	mov    0x14(%eax),%eax
    1950:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1956:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1959:	8b 45 dc             	mov    -0x24(%ebp),%eax
    195c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    195f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1966:	e9 f9 02 00 00       	jmp    1c64 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    196b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1972:	e9 df 02 00 00       	jmp    1c56 <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1977:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    197a:	c1 e0 04             	shl    $0x4,%eax
    197d:	89 c2                	mov    %eax,%edx
    197f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1982:	01 c2                	add    %eax,%edx
    1984:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1987:	01 d0                	add    %edx,%eax
    1989:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    198c:	8b 45 08             	mov    0x8(%ebp),%eax
    198f:	8b 40 0c             	mov    0xc(%eax),%eax
    1992:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1995:	c1 e2 02             	shl    $0x2,%edx
    1998:	01 d0                	add    %edx,%eax
    199a:	8b 00                	mov    (%eax),%eax
    199c:	83 f8 01             	cmp    $0x1,%eax
    199f:	0f 84 83 00 00 00    	je     1a28 <APGridPaint+0x1be>
    19a5:	83 f8 01             	cmp    $0x1,%eax
    19a8:	7f 09                	jg     19b3 <APGridPaint+0x149>
    19aa:	85 c0                	test   %eax,%eax
    19ac:	74 1c                	je     19ca <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    19ae:	e9 9f 02 00 00       	jmp    1c52 <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    19b3:	83 f8 02             	cmp    $0x2,%eax
    19b6:	0f 84 20 01 00 00    	je     1adc <APGridPaint+0x272>
    19bc:	83 f8 03             	cmp    $0x3,%eax
    19bf:	0f 84 d1 01 00 00    	je     1b96 <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    19c5:	e9 88 02 00 00       	jmp    1c52 <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    19ca:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    19cd:	6a 0c                	push   $0xc
    19cf:	6a 0c                	push   $0xc
    19d1:	6a 0c                	push   $0xc
    19d3:	50                   	push   %eax
    19d4:	e8 de fa ff ff       	call   14b7 <RGB>
    19d9:	83 c4 0c             	add    $0xc,%esp
    19dc:	8b 1d 60 26 00 00    	mov    0x2660,%ebx
    19e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19e5:	6b c8 32             	imul   $0x32,%eax,%ecx
    19e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    19eb:	6b c0 32             	imul   $0x32,%eax,%eax
    19ee:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    19f1:	8b 45 08             	mov    0x8(%ebp),%eax
    19f4:	8d 78 34             	lea    0x34(%eax),%edi
    19f7:	83 ec 0c             	sub    $0xc,%esp
    19fa:	83 ec 04             	sub    $0x4,%esp
    19fd:	89 e0                	mov    %esp,%eax
    19ff:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1a03:	66 89 30             	mov    %si,(%eax)
    1a06:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1a0a:	88 50 02             	mov    %dl,0x2(%eax)
    1a0d:	6a 32                	push   $0x32
    1a0f:	6a 32                	push   $0x32
    1a11:	6a 00                	push   $0x0
    1a13:	6a 00                	push   $0x0
    1a15:	53                   	push   %ebx
    1a16:	51                   	push   %ecx
    1a17:	ff 75 b4             	pushl  -0x4c(%ebp)
    1a1a:	57                   	push   %edi
    1a1b:	e8 f3 f8 ff ff       	call   1313 <APDcCopy>
    1a20:	83 c4 30             	add    $0x30,%esp
                    break;
    1a23:	e9 2a 02 00 00       	jmp    1c52 <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1a28:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a2b:	6a 69                	push   $0x69
    1a2d:	6a 69                	push   $0x69
    1a2f:	6a 69                	push   $0x69
    1a31:	50                   	push   %eax
    1a32:	e8 80 fa ff ff       	call   14b7 <RGB>
    1a37:	83 c4 0c             	add    $0xc,%esp
    1a3a:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a3e:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1a42:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a46:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1a49:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1a50:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a53:	6a 69                	push   $0x69
    1a55:	6a 69                	push   $0x69
    1a57:	6a 69                	push   $0x69
    1a59:	50                   	push   %eax
    1a5a:	e8 58 fa ff ff       	call   14b7 <RGB>
    1a5f:	83 c4 0c             	add    $0xc,%esp
    1a62:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1a66:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1a6a:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1a6e:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1a71:	8b 45 08             	mov    0x8(%ebp),%eax
    1a74:	8d 50 34             	lea    0x34(%eax),%edx
    1a77:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a7a:	ff 75 d0             	pushl  -0x30(%ebp)
    1a7d:	ff 75 cc             	pushl  -0x34(%ebp)
    1a80:	52                   	push   %edx
    1a81:	50                   	push   %eax
    1a82:	e8 66 f2 ff ff       	call   ced <APSetPen>
    1a87:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1a8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8d:	8d 58 34             	lea    0x34(%eax),%ebx
    1a90:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1a93:	83 ec 04             	sub    $0x4,%esp
    1a96:	83 ec 04             	sub    $0x4,%esp
    1a99:	89 e0                	mov    %esp,%eax
    1a9b:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1a9f:	66 89 08             	mov    %cx,(%eax)
    1aa2:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1aa6:	88 48 02             	mov    %cl,0x2(%eax)
    1aa9:	53                   	push   %ebx
    1aaa:	52                   	push   %edx
    1aab:	e8 76 f2 ff ff       	call   d26 <APSetBrush>
    1ab0:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ab3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ab6:	6b d0 32             	imul   $0x32,%eax,%edx
    1ab9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1abc:	6b c0 32             	imul   $0x32,%eax,%eax
    1abf:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ac2:	83 c1 34             	add    $0x34,%ecx
    1ac5:	83 ec 0c             	sub    $0xc,%esp
    1ac8:	6a 32                	push   $0x32
    1aca:	6a 32                	push   $0x32
    1acc:	52                   	push   %edx
    1acd:	50                   	push   %eax
    1ace:	51                   	push   %ecx
    1acf:	e8 3a f6 ff ff       	call   110e <APDrawRect>
    1ad4:	83 c4 20             	add    $0x20,%esp
                    break;
    1ad7:	e9 76 01 00 00       	jmp    1c52 <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1adc:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1adf:	6a 00                	push   $0x0
    1ae1:	68 80 00 00 00       	push   $0x80
    1ae6:	6a 00                	push   $0x0
    1ae8:	50                   	push   %eax
    1ae9:	e8 c9 f9 ff ff       	call   14b7 <RGB>
    1aee:	83 c4 0c             	add    $0xc,%esp
    1af1:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1af5:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1af9:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1afd:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1b00:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1b07:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b0a:	6a 00                	push   $0x0
    1b0c:	68 80 00 00 00       	push   $0x80
    1b11:	6a 00                	push   $0x0
    1b13:	50                   	push   %eax
    1b14:	e8 9e f9 ff ff       	call   14b7 <RGB>
    1b19:	83 c4 0c             	add    $0xc,%esp
    1b1c:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1b20:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1b24:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1b28:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1b2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2e:	8d 50 34             	lea    0x34(%eax),%edx
    1b31:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b34:	ff 75 d0             	pushl  -0x30(%ebp)
    1b37:	ff 75 cc             	pushl  -0x34(%ebp)
    1b3a:	52                   	push   %edx
    1b3b:	50                   	push   %eax
    1b3c:	e8 ac f1 ff ff       	call   ced <APSetPen>
    1b41:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1b44:	8b 45 08             	mov    0x8(%ebp),%eax
    1b47:	8d 58 34             	lea    0x34(%eax),%ebx
    1b4a:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1b4d:	83 ec 04             	sub    $0x4,%esp
    1b50:	83 ec 04             	sub    $0x4,%esp
    1b53:	89 e0                	mov    %esp,%eax
    1b55:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1b59:	66 89 08             	mov    %cx,(%eax)
    1b5c:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1b60:	88 48 02             	mov    %cl,0x2(%eax)
    1b63:	53                   	push   %ebx
    1b64:	52                   	push   %edx
    1b65:	e8 bc f1 ff ff       	call   d26 <APSetBrush>
    1b6a:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1b6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b70:	6b d0 32             	imul   $0x32,%eax,%edx
    1b73:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b76:	6b c0 32             	imul   $0x32,%eax,%eax
    1b79:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b7c:	83 c1 34             	add    $0x34,%ecx
    1b7f:	83 ec 0c             	sub    $0xc,%esp
    1b82:	6a 32                	push   $0x32
    1b84:	6a 32                	push   $0x32
    1b86:	52                   	push   %edx
    1b87:	50                   	push   %eax
    1b88:	51                   	push   %ecx
    1b89:	e8 80 f5 ff ff       	call   110e <APDrawRect>
    1b8e:	83 c4 20             	add    $0x20,%esp
                    break;
    1b91:	e9 bc 00 00 00       	jmp    1c52 <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1b96:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1b99:	68 ff 00 00 00       	push   $0xff
    1b9e:	68 bf 00 00 00       	push   $0xbf
    1ba3:	6a 00                	push   $0x0
    1ba5:	50                   	push   %eax
    1ba6:	e8 0c f9 ff ff       	call   14b7 <RGB>
    1bab:	83 c4 0c             	add    $0xc,%esp
    1bae:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1bb2:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1bb6:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1bba:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1bbd:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1bc4:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1bc7:	68 ff 00 00 00       	push   $0xff
    1bcc:	68 bf 00 00 00       	push   $0xbf
    1bd1:	6a 00                	push   $0x0
    1bd3:	50                   	push   %eax
    1bd4:	e8 de f8 ff ff       	call   14b7 <RGB>
    1bd9:	83 c4 0c             	add    $0xc,%esp
    1bdc:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1be0:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1be4:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1be8:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1beb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bee:	8d 50 34             	lea    0x34(%eax),%edx
    1bf1:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1bf4:	ff 75 d0             	pushl  -0x30(%ebp)
    1bf7:	ff 75 cc             	pushl  -0x34(%ebp)
    1bfa:	52                   	push   %edx
    1bfb:	50                   	push   %eax
    1bfc:	e8 ec f0 ff ff       	call   ced <APSetPen>
    1c01:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c04:	8b 45 08             	mov    0x8(%ebp),%eax
    1c07:	8d 58 34             	lea    0x34(%eax),%ebx
    1c0a:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1c0d:	83 ec 04             	sub    $0x4,%esp
    1c10:	83 ec 04             	sub    $0x4,%esp
    1c13:	89 e0                	mov    %esp,%eax
    1c15:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1c19:	66 89 08             	mov    %cx,(%eax)
    1c1c:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1c20:	88 48 02             	mov    %cl,0x2(%eax)
    1c23:	53                   	push   %ebx
    1c24:	52                   	push   %edx
    1c25:	e8 fc f0 ff ff       	call   d26 <APSetBrush>
    1c2a:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1c2d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c30:	6b d0 32             	imul   $0x32,%eax,%edx
    1c33:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c36:	6b c0 32             	imul   $0x32,%eax,%eax
    1c39:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c3c:	83 c1 34             	add    $0x34,%ecx
    1c3f:	83 ec 0c             	sub    $0xc,%esp
    1c42:	6a 32                	push   $0x32
    1c44:	6a 32                	push   $0x32
    1c46:	52                   	push   %edx
    1c47:	50                   	push   %eax
    1c48:	51                   	push   %ecx
    1c49:	e8 c0 f4 ff ff       	call   110e <APDrawRect>
    1c4e:	83 c4 20             	add    $0x20,%esp
                    break;
    1c51:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c52:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1c56:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1c5a:	0f 8e 17 fd ff ff    	jle    1977 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c60:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1c64:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1c68:	0f 8e fd fc ff ff    	jle    196b <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1c6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c71:	5b                   	pop    %ebx
    1c72:	5e                   	pop    %esi
    1c73:	5f                   	pop    %edi
    1c74:	5d                   	pop    %ebp
    1c75:	c3                   	ret    

00001c76 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1c76:	55                   	push   %ebp
    1c77:	89 e5                	mov    %esp,%ebp
    1c79:	53                   	push   %ebx
    1c7a:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1c7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1c84:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1c88:	74 17                	je     1ca1 <sprintint+0x2b>
    1c8a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1c8e:	79 11                	jns    1ca1 <sprintint+0x2b>
        neg = 1;
    1c90:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1c97:	8b 45 10             	mov    0x10(%ebp),%eax
    1c9a:	f7 d8                	neg    %eax
    1c9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c9f:	eb 06                	jmp    1ca7 <sprintint+0x31>
    } else {
        x = xx;
    1ca1:	8b 45 10             	mov    0x10(%ebp),%eax
    1ca4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1ca7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1cae:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1cb1:	8d 41 01             	lea    0x1(%ecx),%eax
    1cb4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1cb7:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1cba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cbd:	ba 00 00 00 00       	mov    $0x0,%edx
    1cc2:	f7 f3                	div    %ebx
    1cc4:	89 d0                	mov    %edx,%eax
    1cc6:	0f b6 80 30 26 00 00 	movzbl 0x2630(%eax),%eax
    1ccd:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1cd1:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1cd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cd7:	ba 00 00 00 00       	mov    $0x0,%edx
    1cdc:	f7 f3                	div    %ebx
    1cde:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ce1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ce5:	75 c7                	jne    1cae <sprintint+0x38>
    if(neg)
    1ce7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ceb:	74 0e                	je     1cfb <sprintint+0x85>
        buf[i++] = '-';
    1ced:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cf0:	8d 50 01             	lea    0x1(%eax),%edx
    1cf3:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1cf6:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1cfb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cfe:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1d01:	eb 1b                	jmp    1d1e <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1d03:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d06:	8b 00                	mov    (%eax),%eax
    1d08:	8d 48 01             	lea    0x1(%eax),%ecx
    1d0b:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d0e:	89 0a                	mov    %ecx,(%edx)
    1d10:	89 c2                	mov    %eax,%edx
    1d12:	8b 45 08             	mov    0x8(%ebp),%eax
    1d15:	01 d0                	add    %edx,%eax
    1d17:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1d1a:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1d1e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1d22:	7f df                	jg     1d03 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1d24:	eb 21                	jmp    1d47 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1d26:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d29:	8b 00                	mov    (%eax),%eax
    1d2b:	8d 48 01             	lea    0x1(%eax),%ecx
    1d2e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d31:	89 0a                	mov    %ecx,(%edx)
    1d33:	89 c2                	mov    %eax,%edx
    1d35:	8b 45 08             	mov    0x8(%ebp),%eax
    1d38:	01 c2                	add    %eax,%edx
    1d3a:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1d3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1d40:	01 c8                	add    %ecx,%eax
    1d42:	0f b6 00             	movzbl (%eax),%eax
    1d45:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1d47:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1d4b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1d4f:	79 d5                	jns    1d26 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1d51:	90                   	nop
    1d52:	83 c4 20             	add    $0x20,%esp
    1d55:	5b                   	pop    %ebx
    1d56:	5d                   	pop    %ebp
    1d57:	c3                   	ret    

00001d58 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1d58:	55                   	push   %ebp
    1d59:	89 e5                	mov    %esp,%ebp
    1d5b:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1d5e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1d65:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1d6c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1d73:	8d 45 0c             	lea    0xc(%ebp),%eax
    1d76:	83 c0 04             	add    $0x4,%eax
    1d79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1d7c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1d83:	e9 d9 01 00 00       	jmp    1f61 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1d88:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d8b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d8e:	01 d0                	add    %edx,%eax
    1d90:	0f b6 00             	movzbl (%eax),%eax
    1d93:	0f be c0             	movsbl %al,%eax
    1d96:	25 ff 00 00 00       	and    $0xff,%eax
    1d9b:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1d9e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1da2:	75 2c                	jne    1dd0 <sprintf+0x78>
            if(c == '%'){
    1da4:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1da8:	75 0c                	jne    1db6 <sprintf+0x5e>
                state = '%';
    1daa:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1db1:	e9 a7 01 00 00       	jmp    1f5d <sprintf+0x205>
            } else {
                dst[j++] = c;
    1db6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1db9:	8d 50 01             	lea    0x1(%eax),%edx
    1dbc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1dbf:	89 c2                	mov    %eax,%edx
    1dc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc4:	01 d0                	add    %edx,%eax
    1dc6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1dc9:	88 10                	mov    %dl,(%eax)
    1dcb:	e9 8d 01 00 00       	jmp    1f5d <sprintf+0x205>
            }
        } else if(state == '%'){
    1dd0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1dd4:	0f 85 83 01 00 00    	jne    1f5d <sprintf+0x205>
            if(c == 'd'){
    1dda:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1dde:	75 4c                	jne    1e2c <sprintf+0xd4>
                buf[bi] = '\0';
    1de0:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1de3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1de6:	01 d0                	add    %edx,%eax
    1de8:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1deb:	83 ec 0c             	sub    $0xc,%esp
    1dee:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1df1:	50                   	push   %eax
    1df2:	e8 20 e5 ff ff       	call   317 <atoi>
    1df7:	83 c4 10             	add    $0x10,%esp
    1dfa:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1dfd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1e04:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e07:	8b 00                	mov    (%eax),%eax
    1e09:	83 ec 08             	sub    $0x8,%esp
    1e0c:	ff 75 d8             	pushl  -0x28(%ebp)
    1e0f:	6a 01                	push   $0x1
    1e11:	6a 0a                	push   $0xa
    1e13:	50                   	push   %eax
    1e14:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1e17:	50                   	push   %eax
    1e18:	ff 75 08             	pushl  0x8(%ebp)
    1e1b:	e8 56 fe ff ff       	call   1c76 <sprintint>
    1e20:	83 c4 20             	add    $0x20,%esp
                ap++;
    1e23:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1e27:	e9 2a 01 00 00       	jmp    1f56 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    1e2c:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    1e30:	74 06                	je     1e38 <sprintf+0xe0>
    1e32:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    1e36:	75 4c                	jne    1e84 <sprintf+0x12c>
                buf[bi] = '\0';
    1e38:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1e3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e3e:	01 d0                	add    %edx,%eax
    1e40:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1e43:	83 ec 0c             	sub    $0xc,%esp
    1e46:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1e49:	50                   	push   %eax
    1e4a:	e8 c8 e4 ff ff       	call   317 <atoi>
    1e4f:	83 c4 10             	add    $0x10,%esp
    1e52:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    1e55:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    1e5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e5f:	8b 00                	mov    (%eax),%eax
    1e61:	83 ec 08             	sub    $0x8,%esp
    1e64:	ff 75 dc             	pushl  -0x24(%ebp)
    1e67:	6a 00                	push   $0x0
    1e69:	6a 10                	push   $0x10
    1e6b:	50                   	push   %eax
    1e6c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1e6f:	50                   	push   %eax
    1e70:	ff 75 08             	pushl  0x8(%ebp)
    1e73:	e8 fe fd ff ff       	call   1c76 <sprintint>
    1e78:	83 c4 20             	add    $0x20,%esp
                ap++;
    1e7b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    1e7f:	e9 d2 00 00 00       	jmp    1f56 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    1e84:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    1e88:	75 46                	jne    1ed0 <sprintf+0x178>
                s = (char*)*ap;
    1e8a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e8d:	8b 00                	mov    (%eax),%eax
    1e8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    1e92:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    1e96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e9a:	75 25                	jne    1ec1 <sprintf+0x169>
                    s = "(null)";
    1e9c:	c7 45 f4 fc 20 00 00 	movl   $0x20fc,-0xc(%ebp)
                while(*s != 0){
    1ea3:	eb 1c                	jmp    1ec1 <sprintf+0x169>
                    dst[j++] = *s;
    1ea5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ea8:	8d 50 01             	lea    0x1(%eax),%edx
    1eab:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1eae:	89 c2                	mov    %eax,%edx
    1eb0:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb3:	01 c2                	add    %eax,%edx
    1eb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb8:	0f b6 00             	movzbl (%eax),%eax
    1ebb:	88 02                	mov    %al,(%edx)
                    s++;
    1ebd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    1ec1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ec4:	0f b6 00             	movzbl (%eax),%eax
    1ec7:	84 c0                	test   %al,%al
    1ec9:	75 da                	jne    1ea5 <sprintf+0x14d>
    1ecb:	e9 86 00 00 00       	jmp    1f56 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    1ed0:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    1ed4:	75 1d                	jne    1ef3 <sprintf+0x19b>
                dst[j++] = *ap;
    1ed6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1ed9:	8d 50 01             	lea    0x1(%eax),%edx
    1edc:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1edf:	89 c2                	mov    %eax,%edx
    1ee1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee4:	01 c2                	add    %eax,%edx
    1ee6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ee9:	8b 00                	mov    (%eax),%eax
    1eeb:	88 02                	mov    %al,(%edx)
                ap++;
    1eed:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    1ef1:	eb 63                	jmp    1f56 <sprintf+0x1fe>
            } else if(c == '%'){
    1ef3:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1ef7:	75 17                	jne    1f10 <sprintf+0x1b8>
                dst[j++] = c;
    1ef9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1efc:	8d 50 01             	lea    0x1(%eax),%edx
    1eff:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f02:	89 c2                	mov    %eax,%edx
    1f04:	8b 45 08             	mov    0x8(%ebp),%eax
    1f07:	01 d0                	add    %edx,%eax
    1f09:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f0c:	88 10                	mov    %dl,(%eax)
    1f0e:	eb 46                	jmp    1f56 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    1f10:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    1f14:	7e 18                	jle    1f2e <sprintf+0x1d6>
    1f16:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    1f1a:	7f 12                	jg     1f2e <sprintf+0x1d6>
            {
                buf[bi++] = c;
    1f1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f1f:	8d 50 01             	lea    0x1(%eax),%edx
    1f22:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1f25:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f28:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    1f2c:	eb 2f                	jmp    1f5d <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    1f2e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f31:	8d 50 01             	lea    0x1(%eax),%edx
    1f34:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f37:	89 c2                	mov    %eax,%edx
    1f39:	8b 45 08             	mov    0x8(%ebp),%eax
    1f3c:	01 d0                	add    %edx,%eax
    1f3e:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    1f41:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f44:	8d 50 01             	lea    0x1(%eax),%edx
    1f47:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f4a:	89 c2                	mov    %eax,%edx
    1f4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4f:	01 d0                	add    %edx,%eax
    1f51:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1f54:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    1f56:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    1f5d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1f61:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f64:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f67:	01 d0                	add    %edx,%eax
    1f69:	0f b6 00             	movzbl (%eax),%eax
    1f6c:	84 c0                	test   %al,%al
    1f6e:	0f 85 14 fe ff ff    	jne    1d88 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    1f74:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f77:	8d 50 01             	lea    0x1(%eax),%edx
    1f7a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f7d:	89 c2                	mov    %eax,%edx
    1f7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f82:	01 d0                	add    %edx,%eax
    1f84:	c6 00 00             	movb   $0x0,(%eax)
}
    1f87:	90                   	nop
    1f88:	c9                   	leave  
    1f89:	c3                   	ret    
