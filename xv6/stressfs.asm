
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
      2b:	68 1c 23 00 00       	push   $0x231c
      30:	6a 01                	push   $0x1
      32:	e8 21 05 00 00       	call   558 <printf>
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
      78:	68 2f 23 00 00       	push   $0x232f
      7d:	6a 01                	push   $0x1
      7f:	e8 d4 04 00 00       	call   558 <printf>
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
      ea:	68 39 23 00 00       	push   $0x2339
      ef:	6a 01                	push   $0x1
      f1:	e8 62 04 00 00       	call   558 <printf>
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

00000481 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     481:	55                   	push   %ebp
     482:	89 e5                	mov    %esp,%ebp
     484:	83 ec 18             	sub    $0x18,%esp
     487:	8b 45 0c             	mov    0xc(%ebp),%eax
     48a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     48d:	83 ec 04             	sub    $0x4,%esp
     490:	6a 01                	push   $0x1
     492:	8d 45 f4             	lea    -0xc(%ebp),%eax
     495:	50                   	push   %eax
     496:	ff 75 08             	pushl  0x8(%ebp)
     499:	e8 2b ff ff ff       	call   3c9 <write>
     49e:	83 c4 10             	add    $0x10,%esp
}
     4a1:	90                   	nop
     4a2:	c9                   	leave  
     4a3:	c3                   	ret    

000004a4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     4a4:	55                   	push   %ebp
     4a5:	89 e5                	mov    %esp,%ebp
     4a7:	53                   	push   %ebx
     4a8:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     4ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     4b2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     4b6:	74 17                	je     4cf <printint+0x2b>
     4b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4bc:	79 11                	jns    4cf <printint+0x2b>
    neg = 1;
     4be:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     4c5:	8b 45 0c             	mov    0xc(%ebp),%eax
     4c8:	f7 d8                	neg    %eax
     4ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4cd:	eb 06                	jmp    4d5 <printint+0x31>
  } else {
    x = xx;
     4cf:	8b 45 0c             	mov    0xc(%ebp),%eax
     4d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4dc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4df:	8d 41 01             	lea    0x1(%ecx),%eax
     4e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4e5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4eb:	ba 00 00 00 00       	mov    $0x0,%edx
     4f0:	f7 f3                	div    %ebx
     4f2:	89 d0                	mov    %edx,%eax
     4f4:	0f b6 80 10 2a 00 00 	movzbl 0x2a10(%eax),%eax
     4fb:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4ff:	8b 5d 10             	mov    0x10(%ebp),%ebx
     502:	8b 45 ec             	mov    -0x14(%ebp),%eax
     505:	ba 00 00 00 00       	mov    $0x0,%edx
     50a:	f7 f3                	div    %ebx
     50c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     50f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     513:	75 c7                	jne    4dc <printint+0x38>
  if(neg)
     515:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     519:	74 2d                	je     548 <printint+0xa4>
    buf[i++] = '-';
     51b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     51e:	8d 50 01             	lea    0x1(%eax),%edx
     521:	89 55 f4             	mov    %edx,-0xc(%ebp)
     524:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     529:	eb 1d                	jmp    548 <printint+0xa4>
    putc(fd, buf[i]);
     52b:	8d 55 dc             	lea    -0x24(%ebp),%edx
     52e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     531:	01 d0                	add    %edx,%eax
     533:	0f b6 00             	movzbl (%eax),%eax
     536:	0f be c0             	movsbl %al,%eax
     539:	83 ec 08             	sub    $0x8,%esp
     53c:	50                   	push   %eax
     53d:	ff 75 08             	pushl  0x8(%ebp)
     540:	e8 3c ff ff ff       	call   481 <putc>
     545:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     548:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     54c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     550:	79 d9                	jns    52b <printint+0x87>
    putc(fd, buf[i]);
}
     552:	90                   	nop
     553:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     556:	c9                   	leave  
     557:	c3                   	ret    

00000558 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     558:	55                   	push   %ebp
     559:	89 e5                	mov    %esp,%ebp
     55b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     55e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     565:	8d 45 0c             	lea    0xc(%ebp),%eax
     568:	83 c0 04             	add    $0x4,%eax
     56b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     56e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     575:	e9 59 01 00 00       	jmp    6d3 <printf+0x17b>
    c = fmt[i] & 0xff;
     57a:	8b 55 0c             	mov    0xc(%ebp),%edx
     57d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     580:	01 d0                	add    %edx,%eax
     582:	0f b6 00             	movzbl (%eax),%eax
     585:	0f be c0             	movsbl %al,%eax
     588:	25 ff 00 00 00       	and    $0xff,%eax
     58d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     590:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     594:	75 2c                	jne    5c2 <printf+0x6a>
      if(c == '%'){
     596:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     59a:	75 0c                	jne    5a8 <printf+0x50>
        state = '%';
     59c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     5a3:	e9 27 01 00 00       	jmp    6cf <printf+0x177>
      } else {
        putc(fd, c);
     5a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5ab:	0f be c0             	movsbl %al,%eax
     5ae:	83 ec 08             	sub    $0x8,%esp
     5b1:	50                   	push   %eax
     5b2:	ff 75 08             	pushl  0x8(%ebp)
     5b5:	e8 c7 fe ff ff       	call   481 <putc>
     5ba:	83 c4 10             	add    $0x10,%esp
     5bd:	e9 0d 01 00 00       	jmp    6cf <printf+0x177>
      }
    } else if(state == '%'){
     5c2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     5c6:	0f 85 03 01 00 00    	jne    6cf <printf+0x177>
      if(c == 'd'){
     5cc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5d0:	75 1e                	jne    5f0 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d5:	8b 00                	mov    (%eax),%eax
     5d7:	6a 01                	push   $0x1
     5d9:	6a 0a                	push   $0xa
     5db:	50                   	push   %eax
     5dc:	ff 75 08             	pushl  0x8(%ebp)
     5df:	e8 c0 fe ff ff       	call   4a4 <printint>
     5e4:	83 c4 10             	add    $0x10,%esp
        ap++;
     5e7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5eb:	e9 d8 00 00 00       	jmp    6c8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5f0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5f4:	74 06                	je     5fc <printf+0xa4>
     5f6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5fa:	75 1e                	jne    61a <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5ff:	8b 00                	mov    (%eax),%eax
     601:	6a 00                	push   $0x0
     603:	6a 10                	push   $0x10
     605:	50                   	push   %eax
     606:	ff 75 08             	pushl  0x8(%ebp)
     609:	e8 96 fe ff ff       	call   4a4 <printint>
     60e:	83 c4 10             	add    $0x10,%esp
        ap++;
     611:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     615:	e9 ae 00 00 00       	jmp    6c8 <printf+0x170>
      } else if(c == 's'){
     61a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     61e:	75 43                	jne    663 <printf+0x10b>
        s = (char*)*ap;
     620:	8b 45 e8             	mov    -0x18(%ebp),%eax
     623:	8b 00                	mov    (%eax),%eax
     625:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     628:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     62c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     630:	75 25                	jne    657 <printf+0xff>
          s = "(null)";
     632:	c7 45 f4 3f 23 00 00 	movl   $0x233f,-0xc(%ebp)
        while(*s != 0){
     639:	eb 1c                	jmp    657 <printf+0xff>
          putc(fd, *s);
     63b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63e:	0f b6 00             	movzbl (%eax),%eax
     641:	0f be c0             	movsbl %al,%eax
     644:	83 ec 08             	sub    $0x8,%esp
     647:	50                   	push   %eax
     648:	ff 75 08             	pushl  0x8(%ebp)
     64b:	e8 31 fe ff ff       	call   481 <putc>
     650:	83 c4 10             	add    $0x10,%esp
          s++;
     653:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     657:	8b 45 f4             	mov    -0xc(%ebp),%eax
     65a:	0f b6 00             	movzbl (%eax),%eax
     65d:	84 c0                	test   %al,%al
     65f:	75 da                	jne    63b <printf+0xe3>
     661:	eb 65                	jmp    6c8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     663:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     667:	75 1d                	jne    686 <printf+0x12e>
        putc(fd, *ap);
     669:	8b 45 e8             	mov    -0x18(%ebp),%eax
     66c:	8b 00                	mov    (%eax),%eax
     66e:	0f be c0             	movsbl %al,%eax
     671:	83 ec 08             	sub    $0x8,%esp
     674:	50                   	push   %eax
     675:	ff 75 08             	pushl  0x8(%ebp)
     678:	e8 04 fe ff ff       	call   481 <putc>
     67d:	83 c4 10             	add    $0x10,%esp
        ap++;
     680:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     684:	eb 42                	jmp    6c8 <printf+0x170>
      } else if(c == '%'){
     686:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     68a:	75 17                	jne    6a3 <printf+0x14b>
        putc(fd, c);
     68c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     68f:	0f be c0             	movsbl %al,%eax
     692:	83 ec 08             	sub    $0x8,%esp
     695:	50                   	push   %eax
     696:	ff 75 08             	pushl  0x8(%ebp)
     699:	e8 e3 fd ff ff       	call   481 <putc>
     69e:	83 c4 10             	add    $0x10,%esp
     6a1:	eb 25                	jmp    6c8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     6a3:	83 ec 08             	sub    $0x8,%esp
     6a6:	6a 25                	push   $0x25
     6a8:	ff 75 08             	pushl  0x8(%ebp)
     6ab:	e8 d1 fd ff ff       	call   481 <putc>
     6b0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     6b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6b6:	0f be c0             	movsbl %al,%eax
     6b9:	83 ec 08             	sub    $0x8,%esp
     6bc:	50                   	push   %eax
     6bd:	ff 75 08             	pushl  0x8(%ebp)
     6c0:	e8 bc fd ff ff       	call   481 <putc>
     6c5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     6c8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6cf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6d3:	8b 55 0c             	mov    0xc(%ebp),%edx
     6d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6d9:	01 d0                	add    %edx,%eax
     6db:	0f b6 00             	movzbl (%eax),%eax
     6de:	84 c0                	test   %al,%al
     6e0:	0f 85 94 fe ff ff    	jne    57a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6e6:	90                   	nop
     6e7:	c9                   	leave  
     6e8:	c3                   	ret    

000006e9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6e9:	55                   	push   %ebp
     6ea:	89 e5                	mov    %esp,%ebp
     6ec:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6ef:	8b 45 08             	mov    0x8(%ebp),%eax
     6f2:	83 e8 08             	sub    $0x8,%eax
     6f5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6f8:	a1 44 2a 00 00       	mov    0x2a44,%eax
     6fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
     700:	eb 24                	jmp    726 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     702:	8b 45 fc             	mov    -0x4(%ebp),%eax
     705:	8b 00                	mov    (%eax),%eax
     707:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     70a:	77 12                	ja     71e <free+0x35>
     70c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     70f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     712:	77 24                	ja     738 <free+0x4f>
     714:	8b 45 fc             	mov    -0x4(%ebp),%eax
     717:	8b 00                	mov    (%eax),%eax
     719:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     71c:	77 1a                	ja     738 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     721:	8b 00                	mov    (%eax),%eax
     723:	89 45 fc             	mov    %eax,-0x4(%ebp)
     726:	8b 45 f8             	mov    -0x8(%ebp),%eax
     729:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     72c:	76 d4                	jbe    702 <free+0x19>
     72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     731:	8b 00                	mov    (%eax),%eax
     733:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     736:	76 ca                	jbe    702 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     738:	8b 45 f8             	mov    -0x8(%ebp),%eax
     73b:	8b 40 04             	mov    0x4(%eax),%eax
     73e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     745:	8b 45 f8             	mov    -0x8(%ebp),%eax
     748:	01 c2                	add    %eax,%edx
     74a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     74d:	8b 00                	mov    (%eax),%eax
     74f:	39 c2                	cmp    %eax,%edx
     751:	75 24                	jne    777 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     753:	8b 45 f8             	mov    -0x8(%ebp),%eax
     756:	8b 50 04             	mov    0x4(%eax),%edx
     759:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75c:	8b 00                	mov    (%eax),%eax
     75e:	8b 40 04             	mov    0x4(%eax),%eax
     761:	01 c2                	add    %eax,%edx
     763:	8b 45 f8             	mov    -0x8(%ebp),%eax
     766:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     769:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76c:	8b 00                	mov    (%eax),%eax
     76e:	8b 10                	mov    (%eax),%edx
     770:	8b 45 f8             	mov    -0x8(%ebp),%eax
     773:	89 10                	mov    %edx,(%eax)
     775:	eb 0a                	jmp    781 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     777:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77a:	8b 10                	mov    (%eax),%edx
     77c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     77f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     781:	8b 45 fc             	mov    -0x4(%ebp),%eax
     784:	8b 40 04             	mov    0x4(%eax),%eax
     787:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     791:	01 d0                	add    %edx,%eax
     793:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     796:	75 20                	jne    7b8 <free+0xcf>
    p->s.size += bp->s.size;
     798:	8b 45 fc             	mov    -0x4(%ebp),%eax
     79b:	8b 50 04             	mov    0x4(%eax),%edx
     79e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a1:	8b 40 04             	mov    0x4(%eax),%eax
     7a4:	01 c2                	add    %eax,%edx
     7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7af:	8b 10                	mov    (%eax),%edx
     7b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b4:	89 10                	mov    %edx,(%eax)
     7b6:	eb 08                	jmp    7c0 <free+0xd7>
  } else
    p->s.ptr = bp;
     7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7bb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7be:	89 10                	mov    %edx,(%eax)
  freep = p;
     7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7c3:	a3 44 2a 00 00       	mov    %eax,0x2a44
}
     7c8:	90                   	nop
     7c9:	c9                   	leave  
     7ca:	c3                   	ret    

000007cb <morecore>:

static Header*
morecore(uint nu)
{
     7cb:	55                   	push   %ebp
     7cc:	89 e5                	mov    %esp,%ebp
     7ce:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7d1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7d8:	77 07                	ja     7e1 <morecore+0x16>
    nu = 4096;
     7da:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7e1:	8b 45 08             	mov    0x8(%ebp),%eax
     7e4:	c1 e0 03             	shl    $0x3,%eax
     7e7:	83 ec 0c             	sub    $0xc,%esp
     7ea:	50                   	push   %eax
     7eb:	e8 41 fc ff ff       	call   431 <sbrk>
     7f0:	83 c4 10             	add    $0x10,%esp
     7f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7f6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7fa:	75 07                	jne    803 <morecore+0x38>
    return 0;
     7fc:	b8 00 00 00 00       	mov    $0x0,%eax
     801:	eb 26                	jmp    829 <morecore+0x5e>
  hp = (Header*)p;
     803:	8b 45 f4             	mov    -0xc(%ebp),%eax
     806:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     809:	8b 45 f0             	mov    -0x10(%ebp),%eax
     80c:	8b 55 08             	mov    0x8(%ebp),%edx
     80f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     812:	8b 45 f0             	mov    -0x10(%ebp),%eax
     815:	83 c0 08             	add    $0x8,%eax
     818:	83 ec 0c             	sub    $0xc,%esp
     81b:	50                   	push   %eax
     81c:	e8 c8 fe ff ff       	call   6e9 <free>
     821:	83 c4 10             	add    $0x10,%esp
  return freep;
     824:	a1 44 2a 00 00       	mov    0x2a44,%eax
}
     829:	c9                   	leave  
     82a:	c3                   	ret    

0000082b <malloc>:

void*
malloc(uint nbytes)
{
     82b:	55                   	push   %ebp
     82c:	89 e5                	mov    %esp,%ebp
     82e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     831:	8b 45 08             	mov    0x8(%ebp),%eax
     834:	83 c0 07             	add    $0x7,%eax
     837:	c1 e8 03             	shr    $0x3,%eax
     83a:	83 c0 01             	add    $0x1,%eax
     83d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     840:	a1 44 2a 00 00       	mov    0x2a44,%eax
     845:	89 45 f0             	mov    %eax,-0x10(%ebp)
     848:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     84c:	75 23                	jne    871 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     84e:	c7 45 f0 3c 2a 00 00 	movl   $0x2a3c,-0x10(%ebp)
     855:	8b 45 f0             	mov    -0x10(%ebp),%eax
     858:	a3 44 2a 00 00       	mov    %eax,0x2a44
     85d:	a1 44 2a 00 00       	mov    0x2a44,%eax
     862:	a3 3c 2a 00 00       	mov    %eax,0x2a3c
    base.s.size = 0;
     867:	c7 05 40 2a 00 00 00 	movl   $0x0,0x2a40
     86e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     871:	8b 45 f0             	mov    -0x10(%ebp),%eax
     874:	8b 00                	mov    (%eax),%eax
     876:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     879:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87c:	8b 40 04             	mov    0x4(%eax),%eax
     87f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     882:	72 4d                	jb     8d1 <malloc+0xa6>
      if(p->s.size == nunits)
     884:	8b 45 f4             	mov    -0xc(%ebp),%eax
     887:	8b 40 04             	mov    0x4(%eax),%eax
     88a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     88d:	75 0c                	jne    89b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     88f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     892:	8b 10                	mov    (%eax),%edx
     894:	8b 45 f0             	mov    -0x10(%ebp),%eax
     897:	89 10                	mov    %edx,(%eax)
     899:	eb 26                	jmp    8c1 <malloc+0x96>
      else {
        p->s.size -= nunits;
     89b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89e:	8b 40 04             	mov    0x4(%eax),%eax
     8a1:	2b 45 ec             	sub    -0x14(%ebp),%eax
     8a4:	89 c2                	mov    %eax,%edx
     8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8af:	8b 40 04             	mov    0x4(%eax),%eax
     8b2:	c1 e0 03             	shl    $0x3,%eax
     8b5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     8b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     8be:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     8c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c4:	a3 44 2a 00 00       	mov    %eax,0x2a44
      return (void*)(p + 1);
     8c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cc:	83 c0 08             	add    $0x8,%eax
     8cf:	eb 3b                	jmp    90c <malloc+0xe1>
    }
    if(p == freep)
     8d1:	a1 44 2a 00 00       	mov    0x2a44,%eax
     8d6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8d9:	75 1e                	jne    8f9 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8db:	83 ec 0c             	sub    $0xc,%esp
     8de:	ff 75 ec             	pushl  -0x14(%ebp)
     8e1:	e8 e5 fe ff ff       	call   7cb <morecore>
     8e6:	83 c4 10             	add    $0x10,%esp
     8e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8f0:	75 07                	jne    8f9 <malloc+0xce>
        return 0;
     8f2:	b8 00 00 00 00       	mov    $0x0,%eax
     8f7:	eb 13                	jmp    90c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     902:	8b 00                	mov    (%eax),%eax
     904:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     907:	e9 6d ff ff ff       	jmp    879 <malloc+0x4e>
}
     90c:	c9                   	leave  
     90d:	c3                   	ret    

0000090e <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     90e:	55                   	push   %ebp
     90f:	89 e5                	mov    %esp,%ebp
     911:	83 ec 1c             	sub    $0x1c,%esp
     914:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     917:	8b 55 10             	mov    0x10(%ebp),%edx
     91a:	8b 45 14             	mov    0x14(%ebp),%eax
     91d:	88 4d ec             	mov    %cl,-0x14(%ebp)
     920:	88 55 e8             	mov    %dl,-0x18(%ebp)
     923:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     926:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     92a:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     92d:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     931:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     934:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     938:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     93b:	8b 45 08             	mov    0x8(%ebp),%eax
     93e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     942:	66 89 10             	mov    %dx,(%eax)
     945:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     949:	88 50 02             	mov    %dl,0x2(%eax)
}
     94c:	8b 45 08             	mov    0x8(%ebp),%eax
     94f:	c9                   	leave  
     950:	c2 04 00             	ret    $0x4

00000953 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     953:	55                   	push   %ebp
     954:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     956:	8b 45 08             	mov    0x8(%ebp),%eax
     959:	2b 45 10             	sub    0x10(%ebp),%eax
     95c:	89 c2                	mov    %eax,%edx
     95e:	8b 45 08             	mov    0x8(%ebp),%eax
     961:	2b 45 10             	sub    0x10(%ebp),%eax
     964:	0f af d0             	imul   %eax,%edx
     967:	8b 45 0c             	mov    0xc(%ebp),%eax
     96a:	2b 45 14             	sub    0x14(%ebp),%eax
     96d:	89 c1                	mov    %eax,%ecx
     96f:	8b 45 0c             	mov    0xc(%ebp),%eax
     972:	2b 45 14             	sub    0x14(%ebp),%eax
     975:	0f af c1             	imul   %ecx,%eax
     978:	01 d0                	add    %edx,%eax
}
     97a:	5d                   	pop    %ebp
     97b:	c3                   	ret    

0000097c <abs_int>:

static inline int abs_int(int x)
{
     97c:	55                   	push   %ebp
     97d:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     97f:	8b 45 08             	mov    0x8(%ebp),%eax
     982:	99                   	cltd   
     983:	89 d0                	mov    %edx,%eax
     985:	33 45 08             	xor    0x8(%ebp),%eax
     988:	29 d0                	sub    %edx,%eax
}
     98a:	5d                   	pop    %ebp
     98b:	c3                   	ret    

0000098c <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     98c:	55                   	push   %ebp
     98d:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     98f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     993:	79 07                	jns    99c <APGetIndex+0x10>
        return X_SMALLER;
     995:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     99a:	eb 40                	jmp    9dc <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     99c:	8b 45 08             	mov    0x8(%ebp),%eax
     99f:	8b 00                	mov    (%eax),%eax
     9a1:	3b 45 0c             	cmp    0xc(%ebp),%eax
     9a4:	7f 07                	jg     9ad <APGetIndex+0x21>
        return X_BIGGER;
     9a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     9ab:	eb 2f                	jmp    9dc <APGetIndex+0x50>
    if (y < 0)
     9ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     9b1:	79 07                	jns    9ba <APGetIndex+0x2e>
        return Y_SMALLER;
     9b3:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     9b8:	eb 22                	jmp    9dc <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     9ba:	8b 45 08             	mov    0x8(%ebp),%eax
     9bd:	8b 40 04             	mov    0x4(%eax),%eax
     9c0:	3b 45 10             	cmp    0x10(%ebp),%eax
     9c3:	7f 07                	jg     9cc <APGetIndex+0x40>
        return Y_BIGGER;
     9c5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     9ca:	eb 10                	jmp    9dc <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     9cc:	8b 45 08             	mov    0x8(%ebp),%eax
     9cf:	8b 00                	mov    (%eax),%eax
     9d1:	0f af 45 10          	imul   0x10(%ebp),%eax
     9d5:	89 c2                	mov    %eax,%edx
     9d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     9da:	01 d0                	add    %edx,%eax
}
     9dc:	5d                   	pop    %ebp
     9dd:	c3                   	ret    

000009de <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     9de:	55                   	push   %ebp
     9df:	89 e5                	mov    %esp,%ebp
     9e1:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9e4:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9eb:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9ee:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9f1:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9f8:	83 ec 08             	sub    $0x8,%esp
     9fb:	6a 00                	push   $0x0
     9fd:	ff 75 0c             	pushl  0xc(%ebp)
     a00:	e8 e4 f9 ff ff       	call   3e9 <open>
     a05:	83 c4 10             	add    $0x10,%esp
     a08:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a0b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a0f:	79 2e                	jns    a3f <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a11:	83 ec 04             	sub    $0x4,%esp
     a14:	ff 75 0c             	pushl  0xc(%ebp)
     a17:	68 46 23 00 00       	push   $0x2346
     a1c:	6a 01                	push   $0x1
     a1e:	e8 35 fb ff ff       	call   558 <printf>
     a23:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a26:	8b 45 08             	mov    0x8(%ebp),%eax
     a29:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a2c:	89 10                	mov    %edx,(%eax)
     a2e:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a31:	89 50 04             	mov    %edx,0x4(%eax)
     a34:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a37:	89 50 08             	mov    %edx,0x8(%eax)
     a3a:	e9 d2 01 00 00       	jmp    c11 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a3f:	83 ec 04             	sub    $0x4,%esp
     a42:	6a 0e                	push   $0xe
     a44:	8d 45 ba             	lea    -0x46(%ebp),%eax
     a47:	50                   	push   %eax
     a48:	ff 75 ec             	pushl  -0x14(%ebp)
     a4b:	e8 71 f9 ff ff       	call   3c1 <read>
     a50:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a53:	83 ec 04             	sub    $0x4,%esp
     a56:	6a 28                	push   $0x28
     a58:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a5b:	50                   	push   %eax
     a5c:	ff 75 ec             	pushl  -0x14(%ebp)
     a5f:	e8 5d f9 ff ff       	call   3c1 <read>
     a64:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a67:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a6a:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a6d:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a70:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a73:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a76:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a79:	0f af d0             	imul   %eax,%edx
     a7c:	89 d0                	mov    %edx,%eax
     a7e:	01 c0                	add    %eax,%eax
     a80:	01 d0                	add    %edx,%eax
     a82:	83 ec 0c             	sub    $0xc,%esp
     a85:	50                   	push   %eax
     a86:	e8 a0 fd ff ff       	call   82b <malloc>
     a8b:	83 c4 10             	add    $0x10,%esp
     a8e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a91:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a95:	0f b7 c0             	movzwl %ax,%eax
     a98:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a9b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aa1:	0f af c2             	imul   %edx,%eax
     aa4:	83 c0 1f             	add    $0x1f,%eax
     aa7:	c1 e8 05             	shr    $0x5,%eax
     aaa:	c1 e0 02             	shl    $0x2,%eax
     aad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     ab0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ab3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ab6:	0f af c2             	imul   %edx,%eax
     ab9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     abc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     abf:	83 ec 0c             	sub    $0xc,%esp
     ac2:	50                   	push   %eax
     ac3:	e8 63 fd ff ff       	call   82b <malloc>
     ac8:	83 c4 10             	add    $0x10,%esp
     acb:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ace:	83 ec 04             	sub    $0x4,%esp
     ad1:	ff 75 e0             	pushl  -0x20(%ebp)
     ad4:	ff 75 dc             	pushl  -0x24(%ebp)
     ad7:	ff 75 ec             	pushl  -0x14(%ebp)
     ada:	e8 e2 f8 ff ff       	call   3c1 <read>
     adf:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     ae2:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     ae6:	66 c1 e8 03          	shr    $0x3,%ax
     aea:	0f b7 c0             	movzwl %ax,%eax
     aed:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     af0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     af7:	e9 e5 00 00 00       	jmp    be1 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     afc:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b02:	29 c2                	sub    %eax,%edx
     b04:	89 d0                	mov    %edx,%eax
     b06:	8d 50 ff             	lea    -0x1(%eax),%edx
     b09:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b0c:	0f af c2             	imul   %edx,%eax
     b0f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b12:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b19:	e9 b1 00 00 00       	jmp    bcf <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b1e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b21:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b24:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b27:	01 c8                	add    %ecx,%eax
     b29:	89 c1                	mov    %eax,%ecx
     b2b:	89 c8                	mov    %ecx,%eax
     b2d:	01 c0                	add    %eax,%eax
     b2f:	01 c8                	add    %ecx,%eax
     b31:	01 c2                	add    %eax,%edx
     b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b36:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b3a:	89 c1                	mov    %eax,%ecx
     b3c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b3f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b43:	01 c1                	add    %eax,%ecx
     b45:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b48:	01 c8                	add    %ecx,%eax
     b4a:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b50:	01 c8                	add    %ecx,%eax
     b52:	0f b6 00             	movzbl (%eax),%eax
     b55:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b58:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b5b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b61:	01 c8                	add    %ecx,%eax
     b63:	89 c1                	mov    %eax,%ecx
     b65:	89 c8                	mov    %ecx,%eax
     b67:	01 c0                	add    %eax,%eax
     b69:	01 c8                	add    %ecx,%eax
     b6b:	01 c2                	add    %eax,%edx
     b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b70:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b74:	89 c1                	mov    %eax,%ecx
     b76:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b79:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b7d:	01 c1                	add    %eax,%ecx
     b7f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b82:	01 c8                	add    %ecx,%eax
     b84:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b87:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b8a:	01 c8                	add    %ecx,%eax
     b8c:	0f b6 00             	movzbl (%eax),%eax
     b8f:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b92:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b95:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b98:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b9b:	01 c8                	add    %ecx,%eax
     b9d:	89 c1                	mov    %eax,%ecx
     b9f:	89 c8                	mov    %ecx,%eax
     ba1:	01 c0                	add    %eax,%eax
     ba3:	01 c8                	add    %ecx,%eax
     ba5:	01 c2                	add    %eax,%edx
     ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     baa:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     bae:	89 c1                	mov    %eax,%ecx
     bb0:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bb3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     bb7:	01 c1                	add    %eax,%ecx
     bb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bbc:	01 c8                	add    %ecx,%eax
     bbe:	8d 48 fd             	lea    -0x3(%eax),%ecx
     bc1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bc4:	01 c8                	add    %ecx,%eax
     bc6:	0f b6 00             	movzbl (%eax),%eax
     bc9:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     bcb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bcf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd5:	39 c2                	cmp    %eax,%edx
     bd7:	0f 87 41 ff ff ff    	ja     b1e <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     bdd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     be1:	8b 55 cc             	mov    -0x34(%ebp),%edx
     be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be7:	39 c2                	cmp    %eax,%edx
     be9:	0f 87 0d ff ff ff    	ja     afc <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     bef:	83 ec 0c             	sub    $0xc,%esp
     bf2:	ff 75 ec             	pushl  -0x14(%ebp)
     bf5:	e8 d7 f7 ff ff       	call   3d1 <close>
     bfa:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bfd:	8b 45 08             	mov    0x8(%ebp),%eax
     c00:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c03:	89 10                	mov    %edx,(%eax)
     c05:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c08:	89 50 04             	mov    %edx,0x4(%eax)
     c0b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c0e:	89 50 08             	mov    %edx,0x8(%eax)
}
     c11:	8b 45 08             	mov    0x8(%ebp),%eax
     c14:	c9                   	leave  
     c15:	c2 04 00             	ret    $0x4

00000c18 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c18:	55                   	push   %ebp
     c19:	89 e5                	mov    %esp,%ebp
     c1b:	53                   	push   %ebx
     c1c:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c1f:	83 ec 0c             	sub    $0xc,%esp
     c22:	6a 1c                	push   $0x1c
     c24:	e8 02 fc ff ff       	call   82b <malloc>
     c29:	83 c4 10             	add    $0x10,%esp
     c2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c32:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c39:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c3c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c3f:	6a 0c                	push   $0xc
     c41:	6a 0c                	push   $0xc
     c43:	6a 0c                	push   $0xc
     c45:	50                   	push   %eax
     c46:	e8 c3 fc ff ff       	call   90e <RGB>
     c4b:	83 c4 0c             	add    $0xc,%esp
     c4e:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c52:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c56:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c5a:	88 43 15             	mov    %al,0x15(%ebx)
     c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c60:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c63:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c67:	66 89 48 10          	mov    %cx,0x10(%eax)
     c6b:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c6f:	88 50 12             	mov    %dl,0x12(%eax)
     c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c75:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c78:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c7c:	66 89 48 08          	mov    %cx,0x8(%eax)
     c80:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c84:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c87:	8b 45 08             	mov    0x8(%ebp),%eax
     c8a:	89 c2                	mov    %eax,%edx
     c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8f:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c91:	8b 45 0c             	mov    0xc(%ebp),%eax
     c94:	89 c2                	mov    %eax,%edx
     c96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c99:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c9c:	8b 55 10             	mov    0x10(%ebp),%edx
     c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca2:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ca8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     cab:	c9                   	leave  
     cac:	c3                   	ret    

00000cad <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     cad:	55                   	push   %ebp
     cae:	89 e5                	mov    %esp,%ebp
     cb0:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
     cb6:	8b 50 08             	mov    0x8(%eax),%edx
     cb9:	89 55 f8             	mov    %edx,-0x8(%ebp)
     cbc:	8b 40 0c             	mov    0xc(%eax),%eax
     cbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     cc2:	8b 45 0c             	mov    0xc(%ebp),%eax
     cc5:	8b 55 10             	mov    0x10(%ebp),%edx
     cc8:	89 50 08             	mov    %edx,0x8(%eax)
     ccb:	8b 55 14             	mov    0x14(%ebp),%edx
     cce:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     cd1:	8b 45 08             	mov    0x8(%ebp),%eax
     cd4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     cd7:	89 10                	mov    %edx,(%eax)
     cd9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     cdc:	89 50 04             	mov    %edx,0x4(%eax)
}
     cdf:	8b 45 08             	mov    0x8(%ebp),%eax
     ce2:	c9                   	leave  
     ce3:	c2 04 00             	ret    $0x4

00000ce6 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ce6:	55                   	push   %ebp
     ce7:	89 e5                	mov    %esp,%ebp
     ce9:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     cec:	8b 45 0c             	mov    0xc(%ebp),%eax
     cef:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     cf3:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cf7:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cfb:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
     d01:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d05:	66 89 50 10          	mov    %dx,0x10(%eax)
     d09:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d0d:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d10:	8b 45 08             	mov    0x8(%ebp),%eax
     d13:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d17:	66 89 10             	mov    %dx,(%eax)
     d1a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d1e:	88 50 02             	mov    %dl,0x2(%eax)
}
     d21:	8b 45 08             	mov    0x8(%ebp),%eax
     d24:	c9                   	leave  
     d25:	c2 04 00             	ret    $0x4

00000d28 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d28:	55                   	push   %ebp
     d29:	89 e5                	mov    %esp,%ebp
     d2b:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d2e:	8b 45 08             	mov    0x8(%ebp),%eax
     d31:	8b 40 0c             	mov    0xc(%eax),%eax
     d34:	89 c2                	mov    %eax,%edx
     d36:	c1 ea 1f             	shr    $0x1f,%edx
     d39:	01 d0                	add    %edx,%eax
     d3b:	d1 f8                	sar    %eax
     d3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d43:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d47:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d4a:	8b 45 10             	mov    0x10(%ebp),%eax
     d4d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d50:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d53:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d57:	0f 89 98 00 00 00    	jns    df5 <APDrawPoint+0xcd>
        i = 0;
     d5d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d64:	e9 8c 00 00 00       	jmp    df5 <APDrawPoint+0xcd>
    {
        j = x - off;
     d69:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6c:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d6f:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d72:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d76:	79 69                	jns    de1 <APDrawPoint+0xb9>
            j = 0;
     d78:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d7f:	eb 60                	jmp    de1 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d81:	ff 75 fc             	pushl  -0x4(%ebp)
     d84:	ff 75 f8             	pushl  -0x8(%ebp)
     d87:	ff 75 08             	pushl  0x8(%ebp)
     d8a:	e8 fd fb ff ff       	call   98c <APGetIndex>
     d8f:	83 c4 0c             	add    $0xc,%esp
     d92:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d95:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d99:	74 55                	je     df0 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d9b:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d9f:	74 67                	je     e08 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     da1:	ff 75 10             	pushl  0x10(%ebp)
     da4:	ff 75 0c             	pushl  0xc(%ebp)
     da7:	ff 75 fc             	pushl  -0x4(%ebp)
     daa:	ff 75 f8             	pushl  -0x8(%ebp)
     dad:	e8 a1 fb ff ff       	call   953 <distance_2>
     db2:	83 c4 10             	add    $0x10,%esp
     db5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     db8:	7f 23                	jg     ddd <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     dba:	8b 45 08             	mov    0x8(%ebp),%eax
     dbd:	8b 48 18             	mov    0x18(%eax),%ecx
     dc0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     dc3:	89 d0                	mov    %edx,%eax
     dc5:	01 c0                	add    %eax,%eax
     dc7:	01 d0                	add    %edx,%eax
     dc9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dcc:	8b 45 08             	mov    0x8(%ebp),%eax
     dcf:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dd3:	66 89 0a             	mov    %cx,(%edx)
     dd6:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     dda:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ddd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     de1:	8b 55 0c             	mov    0xc(%ebp),%edx
     de4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de7:	01 d0                	add    %edx,%eax
     de9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     dec:	7d 93                	jge    d81 <APDrawPoint+0x59>
     dee:	eb 01                	jmp    df1 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     df0:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     df1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     df5:	8b 55 10             	mov    0x10(%ebp),%edx
     df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfb:	01 d0                	add    %edx,%eax
     dfd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e00:	0f 8d 63 ff ff ff    	jge    d69 <APDrawPoint+0x41>
     e06:	eb 01                	jmp    e09 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e08:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e09:	c9                   	leave  
     e0a:	c3                   	ret    

00000e0b <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e0b:	55                   	push   %ebp
     e0c:	89 e5                	mov    %esp,%ebp
     e0e:	53                   	push   %ebx
     e0f:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e12:	8b 45 0c             	mov    0xc(%ebp),%eax
     e15:	3b 45 14             	cmp    0x14(%ebp),%eax
     e18:	0f 85 80 00 00 00    	jne    e9e <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e1e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e22:	0f 88 9d 02 00 00    	js     10c5 <APDrawLine+0x2ba>
     e28:	8b 45 08             	mov    0x8(%ebp),%eax
     e2b:	8b 00                	mov    (%eax),%eax
     e2d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e30:	0f 8e 8f 02 00 00    	jle    10c5 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e36:	8b 45 10             	mov    0x10(%ebp),%eax
     e39:	3b 45 18             	cmp    0x18(%ebp),%eax
     e3c:	7e 12                	jle    e50 <APDrawLine+0x45>
        {
            int tmp = y2;
     e3e:	8b 45 18             	mov    0x18(%ebp),%eax
     e41:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e44:	8b 45 10             	mov    0x10(%ebp),%eax
     e47:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e4a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e4d:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e50:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e54:	79 07                	jns    e5d <APDrawLine+0x52>
     e56:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e5d:	8b 45 08             	mov    0x8(%ebp),%eax
     e60:	8b 40 04             	mov    0x4(%eax),%eax
     e63:	3b 45 18             	cmp    0x18(%ebp),%eax
     e66:	7d 0c                	jge    e74 <APDrawLine+0x69>
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	8b 40 04             	mov    0x4(%eax),%eax
     e6e:	83 e8 01             	sub    $0x1,%eax
     e71:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e74:	8b 45 10             	mov    0x10(%ebp),%eax
     e77:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e7a:	eb 15                	jmp    e91 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e7c:	ff 75 f4             	pushl  -0xc(%ebp)
     e7f:	ff 75 0c             	pushl  0xc(%ebp)
     e82:	ff 75 08             	pushl  0x8(%ebp)
     e85:	e8 9e fe ff ff       	call   d28 <APDrawPoint>
     e8a:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e8d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e94:	3b 45 18             	cmp    0x18(%ebp),%eax
     e97:	7e e3                	jle    e7c <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e99:	e9 2b 02 00 00       	jmp    10c9 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e9e:	8b 45 10             	mov    0x10(%ebp),%eax
     ea1:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea4:	75 7f                	jne    f25 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ea6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eaa:	0f 88 18 02 00 00    	js     10c8 <APDrawLine+0x2bd>
     eb0:	8b 45 08             	mov    0x8(%ebp),%eax
     eb3:	8b 40 04             	mov    0x4(%eax),%eax
     eb6:	3b 45 10             	cmp    0x10(%ebp),%eax
     eb9:	0f 8e 09 02 00 00    	jle    10c8 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec2:	3b 45 14             	cmp    0x14(%ebp),%eax
     ec5:	7e 12                	jle    ed9 <APDrawLine+0xce>
        {
            int tmp = x2;
     ec7:	8b 45 14             	mov    0x14(%ebp),%eax
     eca:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ecd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed0:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ed3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ed6:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ed9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     edd:	79 07                	jns    ee6 <APDrawLine+0xdb>
     edf:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ee6:	8b 45 08             	mov    0x8(%ebp),%eax
     ee9:	8b 00                	mov    (%eax),%eax
     eeb:	3b 45 14             	cmp    0x14(%ebp),%eax
     eee:	7d 0b                	jge    efb <APDrawLine+0xf0>
     ef0:	8b 45 08             	mov    0x8(%ebp),%eax
     ef3:	8b 00                	mov    (%eax),%eax
     ef5:	83 e8 01             	sub    $0x1,%eax
     ef8:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     efb:	8b 45 0c             	mov    0xc(%ebp),%eax
     efe:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f01:	eb 15                	jmp    f18 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f03:	ff 75 10             	pushl  0x10(%ebp)
     f06:	ff 75 f0             	pushl  -0x10(%ebp)
     f09:	ff 75 08             	pushl  0x8(%ebp)
     f0c:	e8 17 fe ff ff       	call   d28 <APDrawPoint>
     f11:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f14:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f18:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f1b:	3b 45 14             	cmp    0x14(%ebp),%eax
     f1e:	7e e3                	jle    f03 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f20:	e9 a4 01 00 00       	jmp    10c9 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f25:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f2c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f33:	8b 45 0c             	mov    0xc(%ebp),%eax
     f36:	2b 45 14             	sub    0x14(%ebp),%eax
     f39:	50                   	push   %eax
     f3a:	e8 3d fa ff ff       	call   97c <abs_int>
     f3f:	83 c4 04             	add    $0x4,%esp
     f42:	89 c3                	mov    %eax,%ebx
     f44:	8b 45 10             	mov    0x10(%ebp),%eax
     f47:	2b 45 18             	sub    0x18(%ebp),%eax
     f4a:	50                   	push   %eax
     f4b:	e8 2c fa ff ff       	call   97c <abs_int>
     f50:	83 c4 04             	add    $0x4,%esp
     f53:	39 c3                	cmp    %eax,%ebx
     f55:	0f 8e b5 00 00 00    	jle    1010 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f5b:	8b 45 10             	mov    0x10(%ebp),%eax
     f5e:	2b 45 18             	sub    0x18(%ebp),%eax
     f61:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f64:	db 45 b0             	fildl  -0x50(%ebp)
     f67:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6a:	2b 45 14             	sub    0x14(%ebp),%eax
     f6d:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f70:	db 45 b0             	fildl  -0x50(%ebp)
     f73:	de f9                	fdivrp %st,%st(1)
     f75:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f78:	8b 45 14             	mov    0x14(%ebp),%eax
     f7b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f7e:	7e 0e                	jle    f8e <APDrawLine+0x183>
        {
            s = x1;
     f80:	8b 45 0c             	mov    0xc(%ebp),%eax
     f83:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f86:	8b 45 14             	mov    0x14(%ebp),%eax
     f89:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f8c:	eb 0c                	jmp    f9a <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f8e:	8b 45 14             	mov    0x14(%ebp),%eax
     f91:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f94:	8b 45 0c             	mov    0xc(%ebp),%eax
     f97:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f9e:	79 07                	jns    fa7 <APDrawLine+0x19c>
     fa0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     fa7:	8b 45 08             	mov    0x8(%ebp),%eax
     faa:	8b 00                	mov    (%eax),%eax
     fac:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     faf:	7f 0b                	jg     fbc <APDrawLine+0x1b1>
     fb1:	8b 45 08             	mov    0x8(%ebp),%eax
     fb4:	8b 00                	mov    (%eax),%eax
     fb6:	83 e8 01             	sub    $0x1,%eax
     fb9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fbf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fc2:	eb 3f                	jmp    1003 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fc4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fc7:	2b 45 0c             	sub    0xc(%ebp),%eax
     fca:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fcd:	db 45 b0             	fildl  -0x50(%ebp)
     fd0:	dc 4d d0             	fmull  -0x30(%ebp)
     fd3:	db 45 10             	fildl  0x10(%ebp)
     fd6:	de c1                	faddp  %st,%st(1)
     fd8:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fdb:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fdf:	b4 0c                	mov    $0xc,%ah
     fe1:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fe5:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fe8:	db 5d cc             	fistpl -0x34(%ebp)
     feb:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fee:	ff 75 cc             	pushl  -0x34(%ebp)
     ff1:	ff 75 e4             	pushl  -0x1c(%ebp)
     ff4:	ff 75 08             	pushl  0x8(%ebp)
     ff7:	e8 2c fd ff ff       	call   d28 <APDrawPoint>
     ffc:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     fff:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1003:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1006:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1009:	7e b9                	jle    fc4 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    100b:	e9 b9 00 00 00       	jmp    10c9 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1010:	8b 45 0c             	mov    0xc(%ebp),%eax
    1013:	2b 45 14             	sub    0x14(%ebp),%eax
    1016:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1019:	db 45 b0             	fildl  -0x50(%ebp)
    101c:	8b 45 10             	mov    0x10(%ebp),%eax
    101f:	2b 45 18             	sub    0x18(%ebp),%eax
    1022:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1025:	db 45 b0             	fildl  -0x50(%ebp)
    1028:	de f9                	fdivrp %st,%st(1)
    102a:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    102d:	8b 45 10             	mov    0x10(%ebp),%eax
    1030:	3b 45 18             	cmp    0x18(%ebp),%eax
    1033:	7e 0e                	jle    1043 <APDrawLine+0x238>
    {
        s = y2;
    1035:	8b 45 18             	mov    0x18(%ebp),%eax
    1038:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    103b:	8b 45 10             	mov    0x10(%ebp),%eax
    103e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1041:	eb 0c                	jmp    104f <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1043:	8b 45 10             	mov    0x10(%ebp),%eax
    1046:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1049:	8b 45 18             	mov    0x18(%ebp),%eax
    104c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    104f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1053:	79 07                	jns    105c <APDrawLine+0x251>
    1055:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    105c:	8b 45 08             	mov    0x8(%ebp),%eax
    105f:	8b 40 04             	mov    0x4(%eax),%eax
    1062:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1065:	7f 0c                	jg     1073 <APDrawLine+0x268>
    1067:	8b 45 08             	mov    0x8(%ebp),%eax
    106a:	8b 40 04             	mov    0x4(%eax),%eax
    106d:	83 e8 01             	sub    $0x1,%eax
    1070:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1073:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1076:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1079:	eb 3f                	jmp    10ba <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    107b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    107e:	2b 45 10             	sub    0x10(%ebp),%eax
    1081:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1084:	db 45 b0             	fildl  -0x50(%ebp)
    1087:	dc 4d c0             	fmull  -0x40(%ebp)
    108a:	db 45 0c             	fildl  0xc(%ebp)
    108d:	de c1                	faddp  %st,%st(1)
    108f:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1092:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1096:	b4 0c                	mov    $0xc,%ah
    1098:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    109c:	d9 6d b4             	fldcw  -0x4c(%ebp)
    109f:	db 5d bc             	fistpl -0x44(%ebp)
    10a2:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10a5:	ff 75 e0             	pushl  -0x20(%ebp)
    10a8:	ff 75 bc             	pushl  -0x44(%ebp)
    10ab:	ff 75 08             	pushl  0x8(%ebp)
    10ae:	e8 75 fc ff ff       	call   d28 <APDrawPoint>
    10b3:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10b6:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10bd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10c0:	7e b9                	jle    107b <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10c2:	90                   	nop
    10c3:	eb 04                	jmp    10c9 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10c5:	90                   	nop
    10c6:	eb 01                	jmp    10c9 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10c8:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10cc:	c9                   	leave  
    10cd:	c3                   	ret    

000010ce <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10ce:	55                   	push   %ebp
    10cf:	89 e5                	mov    %esp,%ebp
    10d1:	53                   	push   %ebx
    10d2:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10d5:	8b 55 10             	mov    0x10(%ebp),%edx
    10d8:	8b 45 18             	mov    0x18(%ebp),%eax
    10db:	01 d0                	add    %edx,%eax
    10dd:	83 e8 01             	sub    $0x1,%eax
    10e0:	83 ec 04             	sub    $0x4,%esp
    10e3:	50                   	push   %eax
    10e4:	ff 75 0c             	pushl  0xc(%ebp)
    10e7:	ff 75 10             	pushl  0x10(%ebp)
    10ea:	ff 75 0c             	pushl  0xc(%ebp)
    10ed:	ff 75 08             	pushl  0x8(%ebp)
    10f0:	e8 16 fd ff ff       	call   e0b <APDrawLine>
    10f5:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10f8:	8b 55 0c             	mov    0xc(%ebp),%edx
    10fb:	8b 45 14             	mov    0x14(%ebp),%eax
    10fe:	01 d0                	add    %edx,%eax
    1100:	83 e8 01             	sub    $0x1,%eax
    1103:	83 ec 04             	sub    $0x4,%esp
    1106:	ff 75 10             	pushl  0x10(%ebp)
    1109:	50                   	push   %eax
    110a:	ff 75 10             	pushl  0x10(%ebp)
    110d:	ff 75 0c             	pushl  0xc(%ebp)
    1110:	ff 75 08             	pushl  0x8(%ebp)
    1113:	e8 f3 fc ff ff       	call   e0b <APDrawLine>
    1118:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    111b:	8b 55 10             	mov    0x10(%ebp),%edx
    111e:	8b 45 18             	mov    0x18(%ebp),%eax
    1121:	01 d0                	add    %edx,%eax
    1123:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1126:	8b 55 0c             	mov    0xc(%ebp),%edx
    1129:	8b 45 14             	mov    0x14(%ebp),%eax
    112c:	01 d0                	add    %edx,%eax
    112e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1131:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1134:	8b 45 14             	mov    0x14(%ebp),%eax
    1137:	01 d8                	add    %ebx,%eax
    1139:	83 e8 01             	sub    $0x1,%eax
    113c:	83 ec 04             	sub    $0x4,%esp
    113f:	51                   	push   %ecx
    1140:	52                   	push   %edx
    1141:	ff 75 10             	pushl  0x10(%ebp)
    1144:	50                   	push   %eax
    1145:	ff 75 08             	pushl  0x8(%ebp)
    1148:	e8 be fc ff ff       	call   e0b <APDrawLine>
    114d:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1150:	8b 55 10             	mov    0x10(%ebp),%edx
    1153:	8b 45 18             	mov    0x18(%ebp),%eax
    1156:	01 d0                	add    %edx,%eax
    1158:	8d 48 ff             	lea    -0x1(%eax),%ecx
    115b:	8b 55 0c             	mov    0xc(%ebp),%edx
    115e:	8b 45 14             	mov    0x14(%ebp),%eax
    1161:	01 d0                	add    %edx,%eax
    1163:	8d 50 ff             	lea    -0x1(%eax),%edx
    1166:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1169:	8b 45 18             	mov    0x18(%ebp),%eax
    116c:	01 d8                	add    %ebx,%eax
    116e:	83 e8 01             	sub    $0x1,%eax
    1171:	83 ec 04             	sub    $0x4,%esp
    1174:	51                   	push   %ecx
    1175:	52                   	push   %edx
    1176:	50                   	push   %eax
    1177:	ff 75 0c             	pushl  0xc(%ebp)
    117a:	ff 75 08             	pushl  0x8(%ebp)
    117d:	e8 89 fc ff ff       	call   e0b <APDrawLine>
    1182:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1185:	8b 55 0c             	mov    0xc(%ebp),%edx
    1188:	8b 45 14             	mov    0x14(%ebp),%eax
    118b:	01 d0                	add    %edx,%eax
    118d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1190:	8b 45 08             	mov    0x8(%ebp),%eax
    1193:	8b 40 0c             	mov    0xc(%eax),%eax
    1196:	89 c1                	mov    %eax,%ecx
    1198:	c1 e9 1f             	shr    $0x1f,%ecx
    119b:	01 c8                	add    %ecx,%eax
    119d:	d1 f8                	sar    %eax
    119f:	29 c2                	sub    %eax,%edx
    11a1:	89 d0                	mov    %edx,%eax
    11a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11a6:	8b 55 10             	mov    0x10(%ebp),%edx
    11a9:	8b 45 18             	mov    0x18(%ebp),%eax
    11ac:	01 d0                	add    %edx,%eax
    11ae:	8d 50 ff             	lea    -0x1(%eax),%edx
    11b1:	8b 45 08             	mov    0x8(%ebp),%eax
    11b4:	8b 40 0c             	mov    0xc(%eax),%eax
    11b7:	89 c1                	mov    %eax,%ecx
    11b9:	c1 e9 1f             	shr    $0x1f,%ecx
    11bc:	01 c8                	add    %ecx,%eax
    11be:	d1 f8                	sar    %eax
    11c0:	29 c2                	sub    %eax,%edx
    11c2:	89 d0                	mov    %edx,%eax
    11c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11c7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ca:	8b 40 0c             	mov    0xc(%eax),%eax
    11cd:	89 c2                	mov    %eax,%edx
    11cf:	c1 ea 1f             	shr    $0x1f,%edx
    11d2:	01 d0                	add    %edx,%eax
    11d4:	d1 f8                	sar    %eax
    11d6:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11d9:	8b 45 08             	mov    0x8(%ebp),%eax
    11dc:	8b 40 0c             	mov    0xc(%eax),%eax
    11df:	89 c2                	mov    %eax,%edx
    11e1:	c1 ea 1f             	shr    $0x1f,%edx
    11e4:	01 d0                	add    %edx,%eax
    11e6:	d1 f8                	sar    %eax
    11e8:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11ef:	0f 88 d8 00 00 00    	js     12cd <APDrawRect+0x1ff>
    11f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11f9:	0f 88 ce 00 00 00    	js     12cd <APDrawRect+0x1ff>
    11ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1202:	8b 00                	mov    (%eax),%eax
    1204:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1207:	0f 8e c0 00 00 00    	jle    12cd <APDrawRect+0x1ff>
    120d:	8b 45 08             	mov    0x8(%ebp),%eax
    1210:	8b 40 04             	mov    0x4(%eax),%eax
    1213:	3b 45 10             	cmp    0x10(%ebp),%eax
    1216:	0f 8e b1 00 00 00    	jle    12cd <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    121c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1220:	79 07                	jns    1229 <APDrawRect+0x15b>
    1222:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1229:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    122d:	79 07                	jns    1236 <APDrawRect+0x168>
    122f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1236:	8b 45 08             	mov    0x8(%ebp),%eax
    1239:	8b 00                	mov    (%eax),%eax
    123b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    123e:	7f 0b                	jg     124b <APDrawRect+0x17d>
    1240:	8b 45 08             	mov    0x8(%ebp),%eax
    1243:	8b 00                	mov    (%eax),%eax
    1245:	83 e8 01             	sub    $0x1,%eax
    1248:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    124b:	8b 45 08             	mov    0x8(%ebp),%eax
    124e:	8b 40 04             	mov    0x4(%eax),%eax
    1251:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1254:	7f 0c                	jg     1262 <APDrawRect+0x194>
    1256:	8b 45 08             	mov    0x8(%ebp),%eax
    1259:	8b 40 04             	mov    0x4(%eax),%eax
    125c:	83 e8 01             	sub    $0x1,%eax
    125f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1262:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1269:	8b 45 0c             	mov    0xc(%ebp),%eax
    126c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    126f:	eb 52                	jmp    12c3 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1271:	8b 45 10             	mov    0x10(%ebp),%eax
    1274:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1277:	eb 3e                	jmp    12b7 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1279:	83 ec 04             	sub    $0x4,%esp
    127c:	ff 75 e8             	pushl  -0x18(%ebp)
    127f:	ff 75 ec             	pushl  -0x14(%ebp)
    1282:	ff 75 08             	pushl  0x8(%ebp)
    1285:	e8 02 f7 ff ff       	call   98c <APGetIndex>
    128a:	83 c4 10             	add    $0x10,%esp
    128d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	8b 48 18             	mov    0x18(%eax),%ecx
    1296:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1299:	89 d0                	mov    %edx,%eax
    129b:	01 c0                	add    %eax,%eax
    129d:	01 d0                	add    %edx,%eax
    129f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12a2:	8b 45 08             	mov    0x8(%ebp),%eax
    12a5:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12a9:	66 89 0a             	mov    %cx,(%edx)
    12ac:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12b0:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12b3:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12ba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12bd:	7e ba                	jle    1279 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12bf:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12c6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12c9:	7e a6                	jle    1271 <APDrawRect+0x1a3>
    12cb:	eb 01                	jmp    12ce <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12cd:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12d1:	c9                   	leave  
    12d2:	c3                   	ret    

000012d3 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    12d3:	55                   	push   %ebp
    12d4:	89 e5                	mov    %esp,%ebp
}
    12d6:	90                   	nop
    12d7:	5d                   	pop    %ebp
    12d8:	c3                   	ret    

000012d9 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    12d9:	55                   	push   %ebp
    12da:	89 e5                	mov    %esp,%ebp
    12dc:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    12df:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    12e3:	0f 88 8e 01 00 00    	js     1477 <APDcCopy+0x19e>
    12e9:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    12ed:	0f 88 84 01 00 00    	js     1477 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12f3:	8b 55 0c             	mov    0xc(%ebp),%edx
    12f6:	8b 45 20             	mov    0x20(%ebp),%eax
    12f9:	01 d0                	add    %edx,%eax
    12fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12fe:	8b 55 10             	mov    0x10(%ebp),%edx
    1301:	8b 45 24             	mov    0x24(%ebp),%eax
    1304:	01 d0                	add    %edx,%eax
    1306:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1309:	8b 55 18             	mov    0x18(%ebp),%edx
    130c:	8b 45 20             	mov    0x20(%ebp),%eax
    130f:	01 d0                	add    %edx,%eax
    1311:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1314:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1317:	8b 45 24             	mov    0x24(%ebp),%eax
    131a:	01 d0                	add    %edx,%eax
    131c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    131f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1323:	0f 88 51 01 00 00    	js     147a <APDcCopy+0x1a1>
    1329:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    132d:	0f 88 47 01 00 00    	js     147a <APDcCopy+0x1a1>
    1333:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1337:	0f 88 3d 01 00 00    	js     147a <APDcCopy+0x1a1>
    133d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1341:	0f 88 33 01 00 00    	js     147a <APDcCopy+0x1a1>
    1347:	8b 45 14             	mov    0x14(%ebp),%eax
    134a:	8b 00                	mov    (%eax),%eax
    134c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    134f:	0f 8c 25 01 00 00    	jl     147a <APDcCopy+0x1a1>
    1355:	8b 45 14             	mov    0x14(%ebp),%eax
    1358:	8b 40 04             	mov    0x4(%eax),%eax
    135b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    135e:	0f 8c 16 01 00 00    	jl     147a <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1364:	8b 45 08             	mov    0x8(%ebp),%eax
    1367:	8b 00                	mov    (%eax),%eax
    1369:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    136c:	7f 0b                	jg     1379 <APDcCopy+0xa0>
    136e:	8b 45 08             	mov    0x8(%ebp),%eax
    1371:	8b 00                	mov    (%eax),%eax
    1373:	83 e8 01             	sub    $0x1,%eax
    1376:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1379:	8b 45 08             	mov    0x8(%ebp),%eax
    137c:	8b 40 04             	mov    0x4(%eax),%eax
    137f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1382:	7f 0c                	jg     1390 <APDcCopy+0xb7>
    1384:	8b 45 08             	mov    0x8(%ebp),%eax
    1387:	8b 40 04             	mov    0x4(%eax),%eax
    138a:	83 e8 01             	sub    $0x1,%eax
    138d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1390:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1397:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    139e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13a5:	e9 bc 00 00 00       	jmp    1466 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    13aa:	8b 45 08             	mov    0x8(%ebp),%eax
    13ad:	8b 00                	mov    (%eax),%eax
    13af:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13b2:	8b 55 10             	mov    0x10(%ebp),%edx
    13b5:	01 ca                	add    %ecx,%edx
    13b7:	0f af d0             	imul   %eax,%edx
    13ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    13bd:	01 d0                	add    %edx,%eax
    13bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13c2:	8b 45 14             	mov    0x14(%ebp),%eax
    13c5:	8b 00                	mov    (%eax),%eax
    13c7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13ca:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13cd:	01 ca                	add    %ecx,%edx
    13cf:	0f af d0             	imul   %eax,%edx
    13d2:	8b 45 18             	mov    0x18(%ebp),%eax
    13d5:	01 d0                	add    %edx,%eax
    13d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    13da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13e1:	eb 74                	jmp    1457 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    13e3:	8b 45 14             	mov    0x14(%ebp),%eax
    13e6:	8b 50 18             	mov    0x18(%eax),%edx
    13e9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13ef:	01 c8                	add    %ecx,%eax
    13f1:	89 c1                	mov    %eax,%ecx
    13f3:	89 c8                	mov    %ecx,%eax
    13f5:	01 c0                	add    %eax,%eax
    13f7:	01 c8                	add    %ecx,%eax
    13f9:	01 d0                	add    %edx,%eax
    13fb:	0f b7 10             	movzwl (%eax),%edx
    13fe:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1402:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1406:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1409:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    140d:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1411:	38 c2                	cmp    %al,%dl
    1413:	75 18                	jne    142d <APDcCopy+0x154>
    1415:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1419:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    141d:	38 c2                	cmp    %al,%dl
    141f:	75 0c                	jne    142d <APDcCopy+0x154>
    1421:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1425:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1429:	38 c2                	cmp    %al,%dl
    142b:	74 26                	je     1453 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    142d:	8b 45 08             	mov    0x8(%ebp),%eax
    1430:	8b 50 18             	mov    0x18(%eax),%edx
    1433:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1436:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1439:	01 c8                	add    %ecx,%eax
    143b:	89 c1                	mov    %eax,%ecx
    143d:	89 c8                	mov    %ecx,%eax
    143f:	01 c0                	add    %eax,%eax
    1441:	01 c8                	add    %ecx,%eax
    1443:	01 d0                	add    %edx,%eax
    1445:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1449:	66 89 10             	mov    %dx,(%eax)
    144c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1450:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1453:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1457:	8b 45 fc             	mov    -0x4(%ebp),%eax
    145a:	2b 45 0c             	sub    0xc(%ebp),%eax
    145d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1460:	7d 81                	jge    13e3 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1462:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1466:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1469:	2b 45 10             	sub    0x10(%ebp),%eax
    146c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    146f:	0f 8d 35 ff ff ff    	jge    13aa <APDcCopy+0xd1>
    1475:	eb 04                	jmp    147b <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1477:	90                   	nop
    1478:	eb 01                	jmp    147b <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    147a:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    147b:	c9                   	leave  
    147c:	c3                   	ret    

0000147d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    147d:	55                   	push   %ebp
    147e:	89 e5                	mov    %esp,%ebp
    1480:	83 ec 1c             	sub    $0x1c,%esp
    1483:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1486:	8b 55 10             	mov    0x10(%ebp),%edx
    1489:	8b 45 14             	mov    0x14(%ebp),%eax
    148c:	88 4d ec             	mov    %cl,-0x14(%ebp)
    148f:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1492:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1495:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1499:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    149c:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    14a0:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    14a3:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    14a7:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    14aa:	8b 45 08             	mov    0x8(%ebp),%eax
    14ad:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14b1:	66 89 10             	mov    %dx,(%eax)
    14b4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14b8:	88 50 02             	mov    %dl,0x2(%eax)
}
    14bb:	8b 45 08             	mov    0x8(%ebp),%eax
    14be:	c9                   	leave  
    14bf:	c2 04 00             	ret    $0x4

000014c2 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14c2:	55                   	push   %ebp
    14c3:	89 e5                	mov    %esp,%ebp
    14c5:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14c8:	8b 45 08             	mov    0x8(%ebp),%eax
    14cb:	8b 00                	mov    (%eax),%eax
    14cd:	83 ec 08             	sub    $0x8,%esp
    14d0:	8d 55 0c             	lea    0xc(%ebp),%edx
    14d3:	52                   	push   %edx
    14d4:	50                   	push   %eax
    14d5:	e8 77 ef ff ff       	call   451 <sendMessage>
    14da:	83 c4 10             	add    $0x10,%esp
}
    14dd:	90                   	nop
    14de:	c9                   	leave  
    14df:	c3                   	ret    

000014e0 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    14e6:	83 ec 0c             	sub    $0xc,%esp
    14e9:	68 98 00 00 00       	push   $0x98
    14ee:	e8 38 f3 ff ff       	call   82b <malloc>
    14f3:	83 c4 10             	add    $0x10,%esp
    14f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14fd:	75 15                	jne    1514 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14ff:	83 ec 04             	sub    $0x4,%esp
    1502:	ff 75 08             	pushl  0x8(%ebp)
    1505:	68 58 23 00 00       	push   $0x2358
    150a:	6a 01                	push   $0x1
    150c:	e8 47 f0 ff ff       	call   558 <printf>
    1511:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1514:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1517:	05 84 00 00 00       	add    $0x84,%eax
    151c:	83 ec 08             	sub    $0x8,%esp
    151f:	ff 75 08             	pushl  0x8(%ebp)
    1522:	50                   	push   %eax
    1523:	e8 50 ec ff ff       	call   178 <strcpy>
    1528:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    152b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    152e:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1535:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1538:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    153f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1542:	8b 40 3c             	mov    0x3c(%eax),%eax
    1545:	89 c2                	mov    %eax,%edx
    1547:	8b 45 f4             	mov    -0xc(%ebp),%eax
    154a:	8b 40 40             	mov    0x40(%eax),%eax
    154d:	0f af d0             	imul   %eax,%edx
    1550:	89 d0                	mov    %edx,%eax
    1552:	01 c0                	add    %eax,%eax
    1554:	01 d0                	add    %edx,%eax
    1556:	83 ec 0c             	sub    $0xc,%esp
    1559:	50                   	push   %eax
    155a:	e8 cc f2 ff ff       	call   82b <malloc>
    155f:	83 c4 10             	add    $0x10,%esp
    1562:	89 c2                	mov    %eax,%edx
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    156a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156d:	8b 40 54             	mov    0x54(%eax),%eax
    1570:	85 c0                	test   %eax,%eax
    1572:	75 15                	jne    1589 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1574:	83 ec 04             	sub    $0x4,%esp
    1577:	ff 75 08             	pushl  0x8(%ebp)
    157a:	68 78 23 00 00       	push   $0x2378
    157f:	6a 01                	push   $0x1
    1581:	e8 d2 ef ff ff       	call   558 <printf>
    1586:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1589:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158c:	8b 40 3c             	mov    0x3c(%eax),%eax
    158f:	89 c2                	mov    %eax,%edx
    1591:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1594:	8b 40 40             	mov    0x40(%eax),%eax
    1597:	0f af d0             	imul   %eax,%edx
    159a:	89 d0                	mov    %edx,%eax
    159c:	01 c0                	add    %eax,%eax
    159e:	01 c2                	add    %eax,%edx
    15a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15a3:	8b 40 54             	mov    0x54(%eax),%eax
    15a6:	83 ec 04             	sub    $0x4,%esp
    15a9:	52                   	push   %edx
    15aa:	68 ff ff ff 00       	push   $0xffffff
    15af:	50                   	push   %eax
    15b0:	e8 59 ec ff ff       	call   20e <memset>
    15b5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bb:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    15c2:	e8 62 ee ff ff       	call   429 <getpid>
    15c7:	89 c2                	mov    %eax,%edx
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d2:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    15d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15dc:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    15e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e6:	8b 40 58             	mov    0x58(%eax),%eax
    15e9:	89 c2                	mov    %eax,%edx
    15eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ee:	8b 40 5c             	mov    0x5c(%eax),%eax
    15f1:	0f af d0             	imul   %eax,%edx
    15f4:	89 d0                	mov    %edx,%eax
    15f6:	01 c0                	add    %eax,%eax
    15f8:	01 d0                	add    %edx,%eax
    15fa:	83 ec 0c             	sub    $0xc,%esp
    15fd:	50                   	push   %eax
    15fe:	e8 28 f2 ff ff       	call   82b <malloc>
    1603:	83 c4 10             	add    $0x10,%esp
    1606:	89 c2                	mov    %eax,%edx
    1608:	8b 45 f4             	mov    -0xc(%ebp),%eax
    160b:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    160e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1611:	8b 40 70             	mov    0x70(%eax),%eax
    1614:	85 c0                	test   %eax,%eax
    1616:	75 15                	jne    162d <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1618:	83 ec 04             	sub    $0x4,%esp
    161b:	ff 75 08             	pushl  0x8(%ebp)
    161e:	68 9c 23 00 00       	push   $0x239c
    1623:	6a 01                	push   $0x1
    1625:	e8 2e ef ff ff       	call   558 <printf>
    162a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    162d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1630:	8b 40 3c             	mov    0x3c(%eax),%eax
    1633:	89 c2                	mov    %eax,%edx
    1635:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1638:	8b 40 40             	mov    0x40(%eax),%eax
    163b:	0f af d0             	imul   %eax,%edx
    163e:	89 d0                	mov    %edx,%eax
    1640:	01 c0                	add    %eax,%eax
    1642:	01 c2                	add    %eax,%edx
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	8b 40 54             	mov    0x54(%eax),%eax
    164a:	83 ec 04             	sub    $0x4,%esp
    164d:	52                   	push   %edx
    164e:	68 ff 00 00 00       	push   $0xff
    1653:	50                   	push   %eax
    1654:	e8 b5 eb ff ff       	call   20e <memset>
    1659:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    165c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1662:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1665:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1669:	74 49                	je     16b4 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    166b:	8b 45 10             	mov    0x10(%ebp),%eax
    166e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1674:	83 ec 0c             	sub    $0xc,%esp
    1677:	50                   	push   %eax
    1678:	e8 ae f1 ff ff       	call   82b <malloc>
    167d:	83 c4 10             	add    $0x10,%esp
    1680:	89 c2                	mov    %eax,%edx
    1682:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1685:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1688:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168b:	8b 55 10             	mov    0x10(%ebp),%edx
    168e:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1694:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    169b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    16a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    16af:	e9 8d 00 00 00       	jmp    1741 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    16b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b7:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    16be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c1:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cb:	8b 40 20             	mov    0x20(%eax),%eax
    16ce:	89 c2                	mov    %eax,%edx
    16d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d3:	8b 40 24             	mov    0x24(%eax),%eax
    16d6:	0f af d0             	imul   %eax,%edx
    16d9:	89 d0                	mov    %edx,%eax
    16db:	01 c0                	add    %eax,%eax
    16dd:	01 d0                	add    %edx,%eax
    16df:	83 ec 0c             	sub    $0xc,%esp
    16e2:	50                   	push   %eax
    16e3:	e8 43 f1 ff ff       	call   82b <malloc>
    16e8:	83 c4 10             	add    $0x10,%esp
    16eb:	89 c2                	mov    %eax,%edx
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    16f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f6:	8b 40 38             	mov    0x38(%eax),%eax
    16f9:	85 c0                	test   %eax,%eax
    16fb:	75 15                	jne    1712 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16fd:	83 ec 04             	sub    $0x4,%esp
    1700:	ff 75 08             	pushl  0x8(%ebp)
    1703:	68 c4 23 00 00       	push   $0x23c4
    1708:	6a 01                	push   $0x1
    170a:	e8 49 ee ff ff       	call   558 <printf>
    170f:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1712:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1715:	8b 40 20             	mov    0x20(%eax),%eax
    1718:	89 c2                	mov    %eax,%edx
    171a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171d:	8b 40 24             	mov    0x24(%eax),%eax
    1720:	0f af d0             	imul   %eax,%edx
    1723:	89 d0                	mov    %edx,%eax
    1725:	01 c0                	add    %eax,%eax
    1727:	01 c2                	add    %eax,%edx
    1729:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172c:	8b 40 38             	mov    0x38(%eax),%eax
    172f:	83 ec 04             	sub    $0x4,%esp
    1732:	52                   	push   %edx
    1733:	68 ff ff ff 00       	push   $0xffffff
    1738:	50                   	push   %eax
    1739:	e8 d0 ea ff ff       	call   20e <memset>
    173e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1741:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1744:	c9                   	leave  
    1745:	c3                   	ret    

00001746 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1746:	55                   	push   %ebp
    1747:	89 e5                	mov    %esp,%ebp
    1749:	57                   	push   %edi
    174a:	56                   	push   %esi
    174b:	53                   	push   %ebx
    174c:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    174f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1752:	83 f8 03             	cmp    $0x3,%eax
    1755:	74 02                	je     1759 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1757:	eb 7c                	jmp    17d5 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1759:	8b 45 08             	mov    0x8(%ebp),%eax
    175c:	8b 58 1c             	mov    0x1c(%eax),%ebx
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
    1762:	8b 48 18             	mov    0x18(%eax),%ecx
    1765:	8b 45 08             	mov    0x8(%ebp),%eax
    1768:	8b 50 5c             	mov    0x5c(%eax),%edx
    176b:	8b 45 08             	mov    0x8(%ebp),%eax
    176e:	8b 40 58             	mov    0x58(%eax),%eax
    1771:	8b 75 08             	mov    0x8(%ebp),%esi
    1774:	83 c6 58             	add    $0x58,%esi
    1777:	83 ec 04             	sub    $0x4,%esp
    177a:	53                   	push   %ebx
    177b:	51                   	push   %ecx
    177c:	6a 00                	push   $0x0
    177e:	52                   	push   %edx
    177f:	50                   	push   %eax
    1780:	6a 00                	push   $0x0
    1782:	6a 00                	push   $0x0
    1784:	56                   	push   %esi
    1785:	6a 00                	push   $0x0
    1787:	6a 00                	push   $0x0
    1789:	ff 75 08             	pushl  0x8(%ebp)
    178c:	e8 b8 ec ff ff       	call   449 <paintWindow>
    1791:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1794:	8b 45 08             	mov    0x8(%ebp),%eax
    1797:	8b 70 1c             	mov    0x1c(%eax),%esi
    179a:	8b 45 08             	mov    0x8(%ebp),%eax
    179d:	8b 58 18             	mov    0x18(%eax),%ebx
    17a0:	8b 45 08             	mov    0x8(%ebp),%eax
    17a3:	8b 48 08             	mov    0x8(%eax),%ecx
    17a6:	8b 45 08             	mov    0x8(%ebp),%eax
    17a9:	8b 50 40             	mov    0x40(%eax),%edx
    17ac:	8b 45 08             	mov    0x8(%ebp),%eax
    17af:	8b 40 3c             	mov    0x3c(%eax),%eax
    17b2:	8b 7d 08             	mov    0x8(%ebp),%edi
    17b5:	83 c7 3c             	add    $0x3c,%edi
    17b8:	83 ec 04             	sub    $0x4,%esp
    17bb:	56                   	push   %esi
    17bc:	53                   	push   %ebx
    17bd:	51                   	push   %ecx
    17be:	52                   	push   %edx
    17bf:	50                   	push   %eax
    17c0:	6a 00                	push   $0x0
    17c2:	6a 00                	push   $0x0
    17c4:	57                   	push   %edi
    17c5:	6a 32                	push   $0x32
    17c7:	6a 00                	push   $0x0
    17c9:	ff 75 08             	pushl  0x8(%ebp)
    17cc:	e8 78 ec ff ff       	call   449 <paintWindow>
    17d1:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    17d4:	90                   	nop
        default: break;
            
            
    }
    return False;
    17d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17da:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17dd:	5b                   	pop    %ebx
    17de:	5e                   	pop    %esi
    17df:	5f                   	pop    %edi
    17e0:	5d                   	pop    %ebp
    17e1:	c3                   	ret    

000017e2 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    17e2:	55                   	push   %ebp
    17e3:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    17e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e8:	8b 50 08             	mov    0x8(%eax),%edx
    17eb:	8b 45 08             	mov    0x8(%ebp),%eax
    17ee:	8b 00                	mov    (%eax),%eax
    17f0:	39 c2                	cmp    %eax,%edx
    17f2:	74 07                	je     17fb <APPreJudge+0x19>
        return False;
    17f4:	b8 00 00 00 00       	mov    $0x0,%eax
    17f9:	eb 05                	jmp    1800 <APPreJudge+0x1e>
    return True;
    17fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1800:	5d                   	pop    %ebp
    1801:	c3                   	ret    

00001802 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1802:	55                   	push   %ebp
    1803:	89 e5                	mov    %esp,%ebp
    1805:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1808:	8b 45 08             	mov    0x8(%ebp),%eax
    180b:	8b 55 0c             	mov    0xc(%ebp),%edx
    180e:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1814:	83 ec 0c             	sub    $0xc,%esp
    1817:	ff 75 08             	pushl  0x8(%ebp)
    181a:	e8 42 ec ff ff       	call   461 <registWindow>
    181f:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1822:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1829:	8b 45 08             	mov    0x8(%ebp),%eax
    182c:	8b 00                	mov    (%eax),%eax
    182e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1831:	ff 75 f4             	pushl  -0xc(%ebp)
    1834:	ff 75 f0             	pushl  -0x10(%ebp)
    1837:	ff 75 ec             	pushl  -0x14(%ebp)
    183a:	ff 75 08             	pushl  0x8(%ebp)
    183d:	e8 80 fc ff ff       	call   14c2 <APSendMessage>
    1842:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1845:	83 ec 0c             	sub    $0xc,%esp
    1848:	ff 75 08             	pushl  0x8(%ebp)
    184b:	e8 09 ec ff ff       	call   459 <getMessage>
    1850:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1853:	8b 45 08             	mov    0x8(%ebp),%eax
    1856:	83 c0 74             	add    $0x74,%eax
    1859:	83 ec 08             	sub    $0x8,%esp
    185c:	50                   	push   %eax
    185d:	ff 75 08             	pushl  0x8(%ebp)
    1860:	e8 7d ff ff ff       	call   17e2 <APPreJudge>
    1865:	83 c4 10             	add    $0x10,%esp
    1868:	84 c0                	test   %al,%al
    186a:	74 1b                	je     1887 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    186c:	8b 45 08             	mov    0x8(%ebp),%eax
    186f:	ff 70 7c             	pushl  0x7c(%eax)
    1872:	ff 70 78             	pushl  0x78(%eax)
    1875:	ff 70 74             	pushl  0x74(%eax)
    1878:	ff 75 08             	pushl  0x8(%ebp)
    187b:	8b 45 0c             	mov    0xc(%ebp),%eax
    187e:	ff d0                	call   *%eax
    1880:	83 c4 10             	add    $0x10,%esp
    1883:	84 c0                	test   %al,%al
    1885:	75 0c                	jne    1893 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1887:	8b 45 08             	mov    0x8(%ebp),%eax
    188a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1891:	eb b2                	jmp    1845 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1893:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1894:	90                   	nop
    1895:	c9                   	leave  
    1896:	c3                   	ret    

00001897 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1897:	55                   	push   %ebp
    1898:	89 e5                	mov    %esp,%ebp
    189a:	57                   	push   %edi
    189b:	56                   	push   %esi
    189c:	53                   	push   %ebx
    189d:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    18a0:	a1 48 2a 00 00       	mov    0x2a48,%eax
    18a5:	85 c0                	test   %eax,%eax
    18a7:	0f 85 2c 02 00 00    	jne    1ad9 <APGridPaint+0x242>
    {
        iconReady = 1;
    18ad:	c7 05 48 2a 00 00 01 	movl   $0x1,0x2a48
    18b4:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    18b7:	8d 45 98             	lea    -0x68(%ebp),%eax
    18ba:	83 ec 08             	sub    $0x8,%esp
    18bd:	68 eb 23 00 00       	push   $0x23eb
    18c2:	50                   	push   %eax
    18c3:	e8 16 f1 ff ff       	call   9de <APLoadBitmap>
    18c8:	83 c4 0c             	add    $0xc,%esp
    18cb:	8b 45 98             	mov    -0x68(%ebp),%eax
    18ce:	a3 6c 2a 00 00       	mov    %eax,0x2a6c
    18d3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18d6:	a3 70 2a 00 00       	mov    %eax,0x2a70
    18db:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18de:	a3 74 2a 00 00       	mov    %eax,0x2a74
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    18e3:	83 ec 04             	sub    $0x4,%esp
    18e6:	ff 35 74 2a 00 00    	pushl  0x2a74
    18ec:	ff 35 70 2a 00 00    	pushl  0x2a70
    18f2:	ff 35 6c 2a 00 00    	pushl  0x2a6c
    18f8:	e8 1b f3 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    18fd:	83 c4 10             	add    $0x10,%esp
    1900:	a3 78 2a 00 00       	mov    %eax,0x2a78
        grid_river = APLoadBitmap ("grid_river.bmp");
    1905:	8d 45 98             	lea    -0x68(%ebp),%eax
    1908:	83 ec 08             	sub    $0x8,%esp
    190b:	68 f9 23 00 00       	push   $0x23f9
    1910:	50                   	push   %eax
    1911:	e8 c8 f0 ff ff       	call   9de <APLoadBitmap>
    1916:	83 c4 0c             	add    $0xc,%esp
    1919:	8b 45 98             	mov    -0x68(%ebp),%eax
    191c:	a3 a8 2a 00 00       	mov    %eax,0x2aa8
    1921:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1924:	a3 ac 2a 00 00       	mov    %eax,0x2aac
    1929:	8b 45 a0             	mov    -0x60(%ebp),%eax
    192c:	a3 b0 2a 00 00       	mov    %eax,0x2ab0
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1931:	83 ec 04             	sub    $0x4,%esp
    1934:	ff 35 b0 2a 00 00    	pushl  0x2ab0
    193a:	ff 35 ac 2a 00 00    	pushl  0x2aac
    1940:	ff 35 a8 2a 00 00    	pushl  0x2aa8
    1946:	e8 cd f2 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    194b:	83 c4 10             	add    $0x10,%esp
    194e:	a3 98 2a 00 00       	mov    %eax,0x2a98
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1953:	8d 45 98             	lea    -0x68(%ebp),%eax
    1956:	83 ec 08             	sub    $0x8,%esp
    1959:	68 08 24 00 00       	push   $0x2408
    195e:	50                   	push   %eax
    195f:	e8 7a f0 ff ff       	call   9de <APLoadBitmap>
    1964:	83 c4 0c             	add    $0xc,%esp
    1967:	8b 45 98             	mov    -0x68(%ebp),%eax
    196a:	a3 9c 2a 00 00       	mov    %eax,0x2a9c
    196f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1972:	a3 a0 2a 00 00       	mov    %eax,0x2aa0
    1977:	8b 45 a0             	mov    -0x60(%ebp),%eax
    197a:	a3 a4 2a 00 00       	mov    %eax,0x2aa4
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    197f:	83 ec 04             	sub    $0x4,%esp
    1982:	ff 35 a4 2a 00 00    	pushl  0x2aa4
    1988:	ff 35 a0 2a 00 00    	pushl  0x2aa0
    198e:	ff 35 9c 2a 00 00    	pushl  0x2a9c
    1994:	e8 7f f2 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1999:	83 c4 10             	add    $0x10,%esp
    199c:	a3 4c 2a 00 00       	mov    %eax,0x2a4c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    19a1:	8d 45 98             	lea    -0x68(%ebp),%eax
    19a4:	83 ec 08             	sub    $0x8,%esp
    19a7:	68 17 24 00 00       	push   $0x2417
    19ac:	50                   	push   %eax
    19ad:	e8 2c f0 ff ff       	call   9de <APLoadBitmap>
    19b2:	83 c4 0c             	add    $0xc,%esp
    19b5:	8b 45 98             	mov    -0x68(%ebp),%eax
    19b8:	a3 80 2a 00 00       	mov    %eax,0x2a80
    19bd:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19c0:	a3 84 2a 00 00       	mov    %eax,0x2a84
    19c5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19c8:	a3 88 2a 00 00       	mov    %eax,0x2a88
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    19cd:	83 ec 04             	sub    $0x4,%esp
    19d0:	ff 35 88 2a 00 00    	pushl  0x2a88
    19d6:	ff 35 84 2a 00 00    	pushl  0x2a84
    19dc:	ff 35 80 2a 00 00    	pushl  0x2a80
    19e2:	e8 31 f2 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    19e7:	83 c4 10             	add    $0x10,%esp
    19ea:	a3 b4 2a 00 00       	mov    %eax,0x2ab4
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    19ef:	8d 45 98             	lea    -0x68(%ebp),%eax
    19f2:	83 ec 08             	sub    $0x8,%esp
    19f5:	68 25 24 00 00       	push   $0x2425
    19fa:	50                   	push   %eax
    19fb:	e8 de ef ff ff       	call   9de <APLoadBitmap>
    1a00:	83 c4 0c             	add    $0xc,%esp
    1a03:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a06:	a3 5c 2a 00 00       	mov    %eax,0x2a5c
    1a0b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a0e:	a3 60 2a 00 00       	mov    %eax,0x2a60
    1a13:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a16:	a3 64 2a 00 00       	mov    %eax,0x2a64
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a1b:	83 ec 04             	sub    $0x4,%esp
    1a1e:	ff 35 64 2a 00 00    	pushl  0x2a64
    1a24:	ff 35 60 2a 00 00    	pushl  0x2a60
    1a2a:	ff 35 5c 2a 00 00    	pushl  0x2a5c
    1a30:	e8 e3 f1 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1a35:	83 c4 10             	add    $0x10,%esp
    1a38:	a3 7c 2a 00 00       	mov    %eax,0x2a7c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a3d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a40:	83 ec 08             	sub    $0x8,%esp
    1a43:	68 35 24 00 00       	push   $0x2435
    1a48:	50                   	push   %eax
    1a49:	e8 90 ef ff ff       	call   9de <APLoadBitmap>
    1a4e:	83 c4 0c             	add    $0xc,%esp
    1a51:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a54:	a3 50 2a 00 00       	mov    %eax,0x2a50
    1a59:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a5c:	a3 54 2a 00 00       	mov    %eax,0x2a54
    1a61:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a64:	a3 58 2a 00 00       	mov    %eax,0x2a58
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a69:	83 ec 04             	sub    $0x4,%esp
    1a6c:	ff 35 58 2a 00 00    	pushl  0x2a58
    1a72:	ff 35 54 2a 00 00    	pushl  0x2a54
    1a78:	ff 35 50 2a 00 00    	pushl  0x2a50
    1a7e:	e8 95 f1 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1a83:	83 c4 10             	add    $0x10,%esp
    1a86:	a3 68 2a 00 00       	mov    %eax,0x2a68
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a8b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a8e:	83 ec 08             	sub    $0x8,%esp
    1a91:	68 47 24 00 00       	push   $0x2447
    1a96:	50                   	push   %eax
    1a97:	e8 42 ef ff ff       	call   9de <APLoadBitmap>
    1a9c:	83 c4 0c             	add    $0xc,%esp
    1a9f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1aa2:	a3 8c 2a 00 00       	mov    %eax,0x2a8c
    1aa7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aaa:	a3 90 2a 00 00       	mov    %eax,0x2a90
    1aaf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ab2:	a3 94 2a 00 00       	mov    %eax,0x2a94
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1ab7:	83 ec 04             	sub    $0x4,%esp
    1aba:	ff 35 94 2a 00 00    	pushl  0x2a94
    1ac0:	ff 35 90 2a 00 00    	pushl  0x2a90
    1ac6:	ff 35 8c 2a 00 00    	pushl  0x2a8c
    1acc:	e8 47 f1 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1ad1:	83 c4 10             	add    $0x10,%esp
    1ad4:	a3 b8 2a 00 00       	mov    %eax,0x2ab8
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1ad9:	8b 45 08             	mov    0x8(%ebp),%eax
    1adc:	8b 40 08             	mov    0x8(%eax),%eax
    1adf:	85 c0                	test   %eax,%eax
    1ae1:	75 17                	jne    1afa <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1ae3:	83 ec 08             	sub    $0x8,%esp
    1ae6:	68 58 24 00 00       	push   $0x2458
    1aeb:	6a 01                	push   $0x1
    1aed:	e8 66 ea ff ff       	call   558 <printf>
    1af2:	83 c4 10             	add    $0x10,%esp
        return;
    1af5:	e9 a0 04 00 00       	jmp    1f9a <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1afa:	8b 45 08             	mov    0x8(%ebp),%eax
    1afd:	8b 40 10             	mov    0x10(%eax),%eax
    1b00:	85 c0                	test   %eax,%eax
    1b02:	7e 10                	jle    1b14 <APGridPaint+0x27d>
    1b04:	8b 45 08             	mov    0x8(%ebp),%eax
    1b07:	8b 50 14             	mov    0x14(%eax),%edx
    1b0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0d:	8b 40 10             	mov    0x10(%eax),%eax
    1b10:	39 c2                	cmp    %eax,%edx
    1b12:	7c 17                	jl     1b2b <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b14:	83 ec 08             	sub    $0x8,%esp
    1b17:	68 7e 24 00 00       	push   $0x247e
    1b1c:	6a 01                	push   $0x1
    1b1e:	e8 35 ea ff ff       	call   558 <printf>
    1b23:	83 c4 10             	add    $0x10,%esp
        return;
    1b26:	e9 6f 04 00 00       	jmp    1f9a <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2e:	8b 40 14             	mov    0x14(%eax),%eax
    1b31:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b37:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b3d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b40:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b47:	e9 96 03 00 00       	jmp    1ee2 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b4c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b53:	e9 7c 03 00 00       	jmp    1ed4 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b5b:	c1 e0 04             	shl    $0x4,%eax
    1b5e:	89 c2                	mov    %eax,%edx
    1b60:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b63:	01 c2                	add    %eax,%edx
    1b65:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b68:	01 d0                	add    %edx,%eax
    1b6a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b70:	8b 40 0c             	mov    0xc(%eax),%eax
    1b73:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b76:	c1 e2 02             	shl    $0x2,%edx
    1b79:	01 d0                	add    %edx,%eax
    1b7b:	8b 00                	mov    (%eax),%eax
    1b7d:	83 f8 07             	cmp    $0x7,%eax
    1b80:	0f 87 49 03 00 00    	ja     1ecf <APGridPaint+0x638>
    1b86:	8b 04 85 94 24 00 00 	mov    0x2494(,%eax,4),%eax
    1b8d:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b8f:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b92:	6a 0c                	push   $0xc
    1b94:	6a 0c                	push   $0xc
    1b96:	6a 0c                	push   $0xc
    1b98:	50                   	push   %eax
    1b99:	e8 df f8 ff ff       	call   147d <RGB>
    1b9e:	83 c4 0c             	add    $0xc,%esp
    1ba1:	8b 1d 78 2a 00 00    	mov    0x2a78,%ebx
    1ba7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1baa:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bb0:	6b c0 32             	imul   $0x32,%eax,%eax
    1bb3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1bb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bbc:	83 ec 0c             	sub    $0xc,%esp
    1bbf:	83 ec 04             	sub    $0x4,%esp
    1bc2:	89 e0                	mov    %esp,%eax
    1bc4:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1bc8:	66 89 30             	mov    %si,(%eax)
    1bcb:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1bcf:	88 50 02             	mov    %dl,0x2(%eax)
    1bd2:	6a 32                	push   $0x32
    1bd4:	6a 32                	push   $0x32
    1bd6:	6a 00                	push   $0x0
    1bd8:	6a 00                	push   $0x0
    1bda:	53                   	push   %ebx
    1bdb:	51                   	push   %ecx
    1bdc:	ff 75 94             	pushl  -0x6c(%ebp)
    1bdf:	57                   	push   %edi
    1be0:	e8 f4 f6 ff ff       	call   12d9 <APDcCopy>
    1be5:	83 c4 30             	add    $0x30,%esp
                    break;
    1be8:	e9 e3 02 00 00       	jmp    1ed0 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1bed:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bf0:	6a 69                	push   $0x69
    1bf2:	6a 69                	push   $0x69
    1bf4:	6a 69                	push   $0x69
    1bf6:	50                   	push   %eax
    1bf7:	e8 81 f8 ff ff       	call   147d <RGB>
    1bfc:	83 c4 0c             	add    $0xc,%esp
    1bff:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c03:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1c07:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c0b:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1c0e:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c15:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c18:	6a 69                	push   $0x69
    1c1a:	6a 69                	push   $0x69
    1c1c:	6a 69                	push   $0x69
    1c1e:	50                   	push   %eax
    1c1f:	e8 59 f8 ff ff       	call   147d <RGB>
    1c24:	83 c4 0c             	add    $0xc,%esp
    1c27:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c2b:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1c2f:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c33:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c36:	8b 45 08             	mov    0x8(%ebp),%eax
    1c39:	8d 50 3c             	lea    0x3c(%eax),%edx
    1c3c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c3f:	ff 75 b0             	pushl  -0x50(%ebp)
    1c42:	ff 75 ac             	pushl  -0x54(%ebp)
    1c45:	52                   	push   %edx
    1c46:	50                   	push   %eax
    1c47:	e8 61 f0 ff ff       	call   cad <APSetPen>
    1c4c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c52:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1c55:	8d 55 98             	lea    -0x68(%ebp),%edx
    1c58:	83 ec 04             	sub    $0x4,%esp
    1c5b:	83 ec 04             	sub    $0x4,%esp
    1c5e:	89 e0                	mov    %esp,%eax
    1c60:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1c64:	66 89 08             	mov    %cx,(%eax)
    1c67:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1c6b:	88 48 02             	mov    %cl,0x2(%eax)
    1c6e:	53                   	push   %ebx
    1c6f:	52                   	push   %edx
    1c70:	e8 71 f0 ff ff       	call   ce6 <APSetBrush>
    1c75:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c78:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c7b:	6b d0 32             	imul   $0x32,%eax,%edx
    1c7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c81:	6b c0 32             	imul   $0x32,%eax,%eax
    1c84:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c87:	83 c1 3c             	add    $0x3c,%ecx
    1c8a:	83 ec 0c             	sub    $0xc,%esp
    1c8d:	6a 32                	push   $0x32
    1c8f:	6a 32                	push   $0x32
    1c91:	52                   	push   %edx
    1c92:	50                   	push   %eax
    1c93:	51                   	push   %ecx
    1c94:	e8 35 f4 ff ff       	call   10ce <APDrawRect>
    1c99:	83 c4 20             	add    $0x20,%esp
                    break;
    1c9c:	e9 2f 02 00 00       	jmp    1ed0 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ca1:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1ca4:	6a 0c                	push   $0xc
    1ca6:	6a 0c                	push   $0xc
    1ca8:	6a 0c                	push   $0xc
    1caa:	50                   	push   %eax
    1cab:	e8 cd f7 ff ff       	call   147d <RGB>
    1cb0:	83 c4 0c             	add    $0xc,%esp
    1cb3:	8b 1d b8 2a 00 00    	mov    0x2ab8,%ebx
    1cb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cbc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cbf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cc2:	6b c0 32             	imul   $0x32,%eax,%eax
    1cc5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cce:	83 ec 0c             	sub    $0xc,%esp
    1cd1:	83 ec 04             	sub    $0x4,%esp
    1cd4:	89 e0                	mov    %esp,%eax
    1cd6:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1cda:	66 89 30             	mov    %si,(%eax)
    1cdd:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ce1:	88 50 02             	mov    %dl,0x2(%eax)
    1ce4:	6a 32                	push   $0x32
    1ce6:	6a 32                	push   $0x32
    1ce8:	6a 00                	push   $0x0
    1cea:	6a 00                	push   $0x0
    1cec:	53                   	push   %ebx
    1ced:	51                   	push   %ecx
    1cee:	ff 75 94             	pushl  -0x6c(%ebp)
    1cf1:	57                   	push   %edi
    1cf2:	e8 e2 f5 ff ff       	call   12d9 <APDcCopy>
    1cf7:	83 c4 30             	add    $0x30,%esp
                    break;
    1cfa:	e9 d1 01 00 00       	jmp    1ed0 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cff:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1d02:	6a 0c                	push   $0xc
    1d04:	6a 0c                	push   $0xc
    1d06:	6a 0c                	push   $0xc
    1d08:	50                   	push   %eax
    1d09:	e8 6f f7 ff ff       	call   147d <RGB>
    1d0e:	83 c4 0c             	add    $0xc,%esp
    1d11:	8b 1d 98 2a 00 00    	mov    0x2a98,%ebx
    1d17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d1a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d1d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d20:	6b c0 32             	imul   $0x32,%eax,%eax
    1d23:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d26:	8b 45 08             	mov    0x8(%ebp),%eax
    1d29:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d2c:	83 ec 0c             	sub    $0xc,%esp
    1d2f:	83 ec 04             	sub    $0x4,%esp
    1d32:	89 e0                	mov    %esp,%eax
    1d34:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d38:	66 89 30             	mov    %si,(%eax)
    1d3b:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1d3f:	88 50 02             	mov    %dl,0x2(%eax)
    1d42:	6a 32                	push   $0x32
    1d44:	6a 32                	push   $0x32
    1d46:	6a 00                	push   $0x0
    1d48:	6a 00                	push   $0x0
    1d4a:	53                   	push   %ebx
    1d4b:	51                   	push   %ecx
    1d4c:	ff 75 94             	pushl  -0x6c(%ebp)
    1d4f:	57                   	push   %edi
    1d50:	e8 84 f5 ff ff       	call   12d9 <APDcCopy>
    1d55:	83 c4 30             	add    $0x30,%esp
                    break;
    1d58:	e9 73 01 00 00       	jmp    1ed0 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d5d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d60:	6a 0c                	push   $0xc
    1d62:	6a 0c                	push   $0xc
    1d64:	6a 0c                	push   $0xc
    1d66:	50                   	push   %eax
    1d67:	e8 11 f7 ff ff       	call   147d <RGB>
    1d6c:	83 c4 0c             	add    $0xc,%esp
    1d6f:	8b 1d 7c 2a 00 00    	mov    0x2a7c,%ebx
    1d75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d78:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d7e:	6b c0 32             	imul   $0x32,%eax,%eax
    1d81:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d84:	8b 45 08             	mov    0x8(%ebp),%eax
    1d87:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d8a:	83 ec 0c             	sub    $0xc,%esp
    1d8d:	83 ec 04             	sub    $0x4,%esp
    1d90:	89 e0                	mov    %esp,%eax
    1d92:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d96:	66 89 30             	mov    %si,(%eax)
    1d99:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d9d:	88 50 02             	mov    %dl,0x2(%eax)
    1da0:	6a 32                	push   $0x32
    1da2:	6a 32                	push   $0x32
    1da4:	6a 00                	push   $0x0
    1da6:	6a 00                	push   $0x0
    1da8:	53                   	push   %ebx
    1da9:	51                   	push   %ecx
    1daa:	ff 75 94             	pushl  -0x6c(%ebp)
    1dad:	57                   	push   %edi
    1dae:	e8 26 f5 ff ff       	call   12d9 <APDcCopy>
    1db3:	83 c4 30             	add    $0x30,%esp
                    break;
    1db6:	e9 15 01 00 00       	jmp    1ed0 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dbb:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1dbe:	6a 0c                	push   $0xc
    1dc0:	6a 0c                	push   $0xc
    1dc2:	6a 0c                	push   $0xc
    1dc4:	50                   	push   %eax
    1dc5:	e8 b3 f6 ff ff       	call   147d <RGB>
    1dca:	83 c4 0c             	add    $0xc,%esp
    1dcd:	8b 1d b4 2a 00 00    	mov    0x2ab4,%ebx
    1dd3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dd6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ddc:	6b c0 32             	imul   $0x32,%eax,%eax
    1ddf:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1de2:	8b 45 08             	mov    0x8(%ebp),%eax
    1de5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1de8:	83 ec 0c             	sub    $0xc,%esp
    1deb:	83 ec 04             	sub    $0x4,%esp
    1dee:	89 e0                	mov    %esp,%eax
    1df0:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1df4:	66 89 30             	mov    %si,(%eax)
    1df7:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1dfb:	88 50 02             	mov    %dl,0x2(%eax)
    1dfe:	6a 32                	push   $0x32
    1e00:	6a 32                	push   $0x32
    1e02:	6a 00                	push   $0x0
    1e04:	6a 00                	push   $0x0
    1e06:	53                   	push   %ebx
    1e07:	51                   	push   %ecx
    1e08:	ff 75 94             	pushl  -0x6c(%ebp)
    1e0b:	57                   	push   %edi
    1e0c:	e8 c8 f4 ff ff       	call   12d9 <APDcCopy>
    1e11:	83 c4 30             	add    $0x30,%esp
                    break;
    1e14:	e9 b7 00 00 00       	jmp    1ed0 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e19:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e1c:	6a 0c                	push   $0xc
    1e1e:	6a 0c                	push   $0xc
    1e20:	6a 0c                	push   $0xc
    1e22:	50                   	push   %eax
    1e23:	e8 55 f6 ff ff       	call   147d <RGB>
    1e28:	83 c4 0c             	add    $0xc,%esp
    1e2b:	8b 1d 4c 2a 00 00    	mov    0x2a4c,%ebx
    1e31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e34:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e37:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e3a:	6b c0 32             	imul   $0x32,%eax,%eax
    1e3d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e40:	8b 45 08             	mov    0x8(%ebp),%eax
    1e43:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e46:	83 ec 0c             	sub    $0xc,%esp
    1e49:	83 ec 04             	sub    $0x4,%esp
    1e4c:	89 e0                	mov    %esp,%eax
    1e4e:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1e52:	66 89 30             	mov    %si,(%eax)
    1e55:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e59:	88 50 02             	mov    %dl,0x2(%eax)
    1e5c:	6a 32                	push   $0x32
    1e5e:	6a 32                	push   $0x32
    1e60:	6a 00                	push   $0x0
    1e62:	6a 00                	push   $0x0
    1e64:	53                   	push   %ebx
    1e65:	51                   	push   %ecx
    1e66:	ff 75 94             	pushl  -0x6c(%ebp)
    1e69:	57                   	push   %edi
    1e6a:	e8 6a f4 ff ff       	call   12d9 <APDcCopy>
    1e6f:	83 c4 30             	add    $0x30,%esp
                    break;
    1e72:	eb 5c                	jmp    1ed0 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e74:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e77:	6a 0c                	push   $0xc
    1e79:	6a 0c                	push   $0xc
    1e7b:	6a 0c                	push   $0xc
    1e7d:	50                   	push   %eax
    1e7e:	e8 fa f5 ff ff       	call   147d <RGB>
    1e83:	83 c4 0c             	add    $0xc,%esp
    1e86:	8b 1d 68 2a 00 00    	mov    0x2a68,%ebx
    1e8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e8f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e92:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e95:	6b c0 32             	imul   $0x32,%eax,%eax
    1e98:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	83 ec 04             	sub    $0x4,%esp
    1ea7:	89 e0                	mov    %esp,%eax
    1ea9:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1ead:	66 89 30             	mov    %si,(%eax)
    1eb0:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1eb4:	88 50 02             	mov    %dl,0x2(%eax)
    1eb7:	6a 32                	push   $0x32
    1eb9:	6a 32                	push   $0x32
    1ebb:	6a 00                	push   $0x0
    1ebd:	6a 00                	push   $0x0
    1ebf:	53                   	push   %ebx
    1ec0:	51                   	push   %ecx
    1ec1:	ff 75 94             	pushl  -0x6c(%ebp)
    1ec4:	57                   	push   %edi
    1ec5:	e8 0f f4 ff ff       	call   12d9 <APDcCopy>
    1eca:	83 c4 30             	add    $0x30,%esp
                    break;
    1ecd:	eb 01                	jmp    1ed0 <APGridPaint+0x639>
                default: break;
    1ecf:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ed0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1ed4:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1ed8:	0f 8e 7a fc ff ff    	jle    1b58 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ede:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1ee2:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1ee6:	0f 8e 60 fc ff ff    	jle    1b4c <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1eec:	8d 45 98             	lea    -0x68(%ebp),%eax
    1eef:	68 cd 00 00 00       	push   $0xcd
    1ef4:	6a 74                	push   $0x74
    1ef6:	6a 18                	push   $0x18
    1ef8:	50                   	push   %eax
    1ef9:	e8 7f f5 ff ff       	call   147d <RGB>
    1efe:	83 c4 0c             	add    $0xc,%esp
    1f01:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1f05:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1f09:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1f0d:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f10:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f17:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f1a:	68 cd 00 00 00       	push   $0xcd
    1f1f:	6a 74                	push   $0x74
    1f21:	6a 18                	push   $0x18
    1f23:	50                   	push   %eax
    1f24:	e8 54 f5 ff ff       	call   147d <RGB>
    1f29:	83 c4 0c             	add    $0xc,%esp
    1f2c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1f30:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1f34:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1f38:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1f3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f3e:	8d 50 58             	lea    0x58(%eax),%edx
    1f41:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f44:	ff 75 bc             	pushl  -0x44(%ebp)
    1f47:	ff 75 b8             	pushl  -0x48(%ebp)
    1f4a:	52                   	push   %edx
    1f4b:	50                   	push   %eax
    1f4c:	e8 5c ed ff ff       	call   cad <APSetPen>
    1f51:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1f54:	8b 45 08             	mov    0x8(%ebp),%eax
    1f57:	8d 58 58             	lea    0x58(%eax),%ebx
    1f5a:	8d 55 98             	lea    -0x68(%ebp),%edx
    1f5d:	83 ec 04             	sub    $0x4,%esp
    1f60:	83 ec 04             	sub    $0x4,%esp
    1f63:	89 e0                	mov    %esp,%eax
    1f65:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1f69:	66 89 08             	mov    %cx,(%eax)
    1f6c:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1f70:	88 48 02             	mov    %cl,0x2(%eax)
    1f73:	53                   	push   %ebx
    1f74:	52                   	push   %edx
    1f75:	e8 6c ed ff ff       	call   ce6 <APSetBrush>
    1f7a:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1f7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f80:	83 c0 58             	add    $0x58,%eax
    1f83:	83 ec 0c             	sub    $0xc,%esp
    1f86:	6a 32                	push   $0x32
    1f88:	68 20 03 00 00       	push   $0x320
    1f8d:	6a 00                	push   $0x0
    1f8f:	6a 00                	push   $0x0
    1f91:	50                   	push   %eax
    1f92:	e8 37 f1 ff ff       	call   10ce <APDrawRect>
    1f97:	83 c4 20             	add    $0x20,%esp
}
    1f9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f9d:	5b                   	pop    %ebx
    1f9e:	5e                   	pop    %esi
    1f9f:	5f                   	pop    %edi
    1fa0:	5d                   	pop    %ebp
    1fa1:	c3                   	ret    

00001fa2 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1fa2:	55                   	push   %ebp
    1fa3:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1fa5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1fa9:	7e 08                	jle    1fb3 <random+0x11>
{
rand_num = seed;
    1fab:	8b 45 08             	mov    0x8(%ebp),%eax
    1fae:	a3 24 2a 00 00       	mov    %eax,0x2a24
}
rand_num *= 3;
    1fb3:	8b 15 24 2a 00 00    	mov    0x2a24,%edx
    1fb9:	89 d0                	mov    %edx,%eax
    1fbb:	01 c0                	add    %eax,%eax
    1fbd:	01 d0                	add    %edx,%eax
    1fbf:	a3 24 2a 00 00       	mov    %eax,0x2a24
if (rand_num < 0)
    1fc4:	a1 24 2a 00 00       	mov    0x2a24,%eax
    1fc9:	85 c0                	test   %eax,%eax
    1fcb:	79 0c                	jns    1fd9 <random+0x37>
{
rand_num *= (-1);
    1fcd:	a1 24 2a 00 00       	mov    0x2a24,%eax
    1fd2:	f7 d8                	neg    %eax
    1fd4:	a3 24 2a 00 00       	mov    %eax,0x2a24
}
return rand_num % 997;
    1fd9:	8b 0d 24 2a 00 00    	mov    0x2a24,%ecx
    1fdf:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1fe4:	89 c8                	mov    %ecx,%eax
    1fe6:	f7 ea                	imul   %edx
    1fe8:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1feb:	c1 f8 09             	sar    $0x9,%eax
    1fee:	89 c2                	mov    %eax,%edx
    1ff0:	89 c8                	mov    %ecx,%eax
    1ff2:	c1 f8 1f             	sar    $0x1f,%eax
    1ff5:	29 c2                	sub    %eax,%edx
    1ff7:	89 d0                	mov    %edx,%eax
    1ff9:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1fff:	29 c1                	sub    %eax,%ecx
    2001:	89 c8                	mov    %ecx,%eax
}
    2003:	5d                   	pop    %ebp
    2004:	c3                   	ret    

00002005 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2005:	55                   	push   %ebp
    2006:	89 e5                	mov    %esp,%ebp
    2008:	53                   	push   %ebx
    2009:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    200c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2013:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2017:	74 17                	je     2030 <sprintint+0x2b>
    2019:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    201d:	79 11                	jns    2030 <sprintint+0x2b>
        neg = 1;
    201f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2026:	8b 45 10             	mov    0x10(%ebp),%eax
    2029:	f7 d8                	neg    %eax
    202b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    202e:	eb 06                	jmp    2036 <sprintint+0x31>
    } else {
        x = xx;
    2030:	8b 45 10             	mov    0x10(%ebp),%eax
    2033:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2036:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    203d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2040:	8d 41 01             	lea    0x1(%ecx),%eax
    2043:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2046:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2049:	8b 45 f0             	mov    -0x10(%ebp),%eax
    204c:	ba 00 00 00 00       	mov    $0x0,%edx
    2051:	f7 f3                	div    %ebx
    2053:	89 d0                	mov    %edx,%eax
    2055:	0f b6 80 28 2a 00 00 	movzbl 0x2a28(%eax),%eax
    205c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2060:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2063:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2066:	ba 00 00 00 00       	mov    $0x0,%edx
    206b:	f7 f3                	div    %ebx
    206d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2070:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2074:	75 c7                	jne    203d <sprintint+0x38>
    if(neg)
    2076:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    207a:	74 0e                	je     208a <sprintint+0x85>
        buf[i++] = '-';
    207c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    207f:	8d 50 01             	lea    0x1(%eax),%edx
    2082:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2085:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    208a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    208d:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2090:	eb 1b                	jmp    20ad <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2092:	8b 45 0c             	mov    0xc(%ebp),%eax
    2095:	8b 00                	mov    (%eax),%eax
    2097:	8d 48 01             	lea    0x1(%eax),%ecx
    209a:	8b 55 0c             	mov    0xc(%ebp),%edx
    209d:	89 0a                	mov    %ecx,(%edx)
    209f:	89 c2                	mov    %eax,%edx
    20a1:	8b 45 08             	mov    0x8(%ebp),%eax
    20a4:	01 d0                	add    %edx,%eax
    20a6:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    20a9:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    20ad:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    20b1:	7f df                	jg     2092 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    20b3:	eb 21                	jmp    20d6 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    20b5:	8b 45 0c             	mov    0xc(%ebp),%eax
    20b8:	8b 00                	mov    (%eax),%eax
    20ba:	8d 48 01             	lea    0x1(%eax),%ecx
    20bd:	8b 55 0c             	mov    0xc(%ebp),%edx
    20c0:	89 0a                	mov    %ecx,(%edx)
    20c2:	89 c2                	mov    %eax,%edx
    20c4:	8b 45 08             	mov    0x8(%ebp),%eax
    20c7:	01 c2                	add    %eax,%edx
    20c9:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    20cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20cf:	01 c8                	add    %ecx,%eax
    20d1:	0f b6 00             	movzbl (%eax),%eax
    20d4:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    20d6:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    20da:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    20de:	79 d5                	jns    20b5 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    20e0:	90                   	nop
    20e1:	83 c4 20             	add    $0x20,%esp
    20e4:	5b                   	pop    %ebx
    20e5:	5d                   	pop    %ebp
    20e6:	c3                   	ret    

000020e7 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    20e7:	55                   	push   %ebp
    20e8:	89 e5                	mov    %esp,%ebp
    20ea:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    20ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    20f4:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    20fb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2102:	8d 45 0c             	lea    0xc(%ebp),%eax
    2105:	83 c0 04             	add    $0x4,%eax
    2108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    210b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2112:	e9 d9 01 00 00       	jmp    22f0 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2117:	8b 55 0c             	mov    0xc(%ebp),%edx
    211a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    211d:	01 d0                	add    %edx,%eax
    211f:	0f b6 00             	movzbl (%eax),%eax
    2122:	0f be c0             	movsbl %al,%eax
    2125:	25 ff 00 00 00       	and    $0xff,%eax
    212a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    212d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2131:	75 2c                	jne    215f <sprintf+0x78>
            if(c == '%'){
    2133:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2137:	75 0c                	jne    2145 <sprintf+0x5e>
                state = '%';
    2139:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2140:	e9 a7 01 00 00       	jmp    22ec <sprintf+0x205>
            } else {
                dst[j++] = c;
    2145:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2148:	8d 50 01             	lea    0x1(%eax),%edx
    214b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    214e:	89 c2                	mov    %eax,%edx
    2150:	8b 45 08             	mov    0x8(%ebp),%eax
    2153:	01 d0                	add    %edx,%eax
    2155:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2158:	88 10                	mov    %dl,(%eax)
    215a:	e9 8d 01 00 00       	jmp    22ec <sprintf+0x205>
            }
        } else if(state == '%'){
    215f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2163:	0f 85 83 01 00 00    	jne    22ec <sprintf+0x205>
            if(c == 'd'){
    2169:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    216d:	75 4c                	jne    21bb <sprintf+0xd4>
                buf[bi] = '\0';
    216f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2172:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2175:	01 d0                	add    %edx,%eax
    2177:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    217a:	83 ec 0c             	sub    $0xc,%esp
    217d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2180:	50                   	push   %eax
    2181:	e8 91 e1 ff ff       	call   317 <atoi>
    2186:	83 c4 10             	add    $0x10,%esp
    2189:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    218c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2193:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2196:	8b 00                	mov    (%eax),%eax
    2198:	83 ec 08             	sub    $0x8,%esp
    219b:	ff 75 d8             	pushl  -0x28(%ebp)
    219e:	6a 01                	push   $0x1
    21a0:	6a 0a                	push   $0xa
    21a2:	50                   	push   %eax
    21a3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21a6:	50                   	push   %eax
    21a7:	ff 75 08             	pushl  0x8(%ebp)
    21aa:	e8 56 fe ff ff       	call   2005 <sprintint>
    21af:	83 c4 20             	add    $0x20,%esp
                ap++;
    21b2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21b6:	e9 2a 01 00 00       	jmp    22e5 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    21bb:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    21bf:	74 06                	je     21c7 <sprintf+0xe0>
    21c1:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    21c5:	75 4c                	jne    2213 <sprintf+0x12c>
                buf[bi] = '\0';
    21c7:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21cd:	01 d0                	add    %edx,%eax
    21cf:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21d2:	83 ec 0c             	sub    $0xc,%esp
    21d5:	8d 45 ce             	lea    -0x32(%ebp),%eax
    21d8:	50                   	push   %eax
    21d9:	e8 39 e1 ff ff       	call   317 <atoi>
    21de:	83 c4 10             	add    $0x10,%esp
    21e1:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    21e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    21eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21ee:	8b 00                	mov    (%eax),%eax
    21f0:	83 ec 08             	sub    $0x8,%esp
    21f3:	ff 75 dc             	pushl  -0x24(%ebp)
    21f6:	6a 00                	push   $0x0
    21f8:	6a 10                	push   $0x10
    21fa:	50                   	push   %eax
    21fb:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21fe:	50                   	push   %eax
    21ff:	ff 75 08             	pushl  0x8(%ebp)
    2202:	e8 fe fd ff ff       	call   2005 <sprintint>
    2207:	83 c4 20             	add    $0x20,%esp
                ap++;
    220a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    220e:	e9 d2 00 00 00       	jmp    22e5 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2213:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2217:	75 46                	jne    225f <sprintf+0x178>
                s = (char*)*ap;
    2219:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    221c:	8b 00                	mov    (%eax),%eax
    221e:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2221:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2225:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2229:	75 25                	jne    2250 <sprintf+0x169>
                    s = "(null)";
    222b:	c7 45 f4 b4 24 00 00 	movl   $0x24b4,-0xc(%ebp)
                while(*s != 0){
    2232:	eb 1c                	jmp    2250 <sprintf+0x169>
                    dst[j++] = *s;
    2234:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2237:	8d 50 01             	lea    0x1(%eax),%edx
    223a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    223d:	89 c2                	mov    %eax,%edx
    223f:	8b 45 08             	mov    0x8(%ebp),%eax
    2242:	01 c2                	add    %eax,%edx
    2244:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2247:	0f b6 00             	movzbl (%eax),%eax
    224a:	88 02                	mov    %al,(%edx)
                    s++;
    224c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2250:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2253:	0f b6 00             	movzbl (%eax),%eax
    2256:	84 c0                	test   %al,%al
    2258:	75 da                	jne    2234 <sprintf+0x14d>
    225a:	e9 86 00 00 00       	jmp    22e5 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    225f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2263:	75 1d                	jne    2282 <sprintf+0x19b>
                dst[j++] = *ap;
    2265:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2268:	8d 50 01             	lea    0x1(%eax),%edx
    226b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    226e:	89 c2                	mov    %eax,%edx
    2270:	8b 45 08             	mov    0x8(%ebp),%eax
    2273:	01 c2                	add    %eax,%edx
    2275:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2278:	8b 00                	mov    (%eax),%eax
    227a:	88 02                	mov    %al,(%edx)
                ap++;
    227c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2280:	eb 63                	jmp    22e5 <sprintf+0x1fe>
            } else if(c == '%'){
    2282:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2286:	75 17                	jne    229f <sprintf+0x1b8>
                dst[j++] = c;
    2288:	8b 45 c8             	mov    -0x38(%ebp),%eax
    228b:	8d 50 01             	lea    0x1(%eax),%edx
    228e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2291:	89 c2                	mov    %eax,%edx
    2293:	8b 45 08             	mov    0x8(%ebp),%eax
    2296:	01 d0                	add    %edx,%eax
    2298:	8b 55 e0             	mov    -0x20(%ebp),%edx
    229b:	88 10                	mov    %dl,(%eax)
    229d:	eb 46                	jmp    22e5 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    229f:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    22a3:	7e 18                	jle    22bd <sprintf+0x1d6>
    22a5:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    22a9:	7f 12                	jg     22bd <sprintf+0x1d6>
            {
                buf[bi++] = c;
    22ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22ae:	8d 50 01             	lea    0x1(%eax),%edx
    22b1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    22b4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22b7:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    22bb:	eb 2f                	jmp    22ec <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    22bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22c0:	8d 50 01             	lea    0x1(%eax),%edx
    22c3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22c6:	89 c2                	mov    %eax,%edx
    22c8:	8b 45 08             	mov    0x8(%ebp),%eax
    22cb:	01 d0                	add    %edx,%eax
    22cd:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    22d0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22d3:	8d 50 01             	lea    0x1(%eax),%edx
    22d6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22d9:	89 c2                	mov    %eax,%edx
    22db:	8b 45 08             	mov    0x8(%ebp),%eax
    22de:	01 d0                	add    %edx,%eax
    22e0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22e3:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    22e5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    22ec:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    22f0:	8b 55 0c             	mov    0xc(%ebp),%edx
    22f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22f6:	01 d0                	add    %edx,%eax
    22f8:	0f b6 00             	movzbl (%eax),%eax
    22fb:	84 c0                	test   %al,%al
    22fd:	0f 85 14 fe ff ff    	jne    2117 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2303:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2306:	8d 50 01             	lea    0x1(%eax),%edx
    2309:	89 55 c8             	mov    %edx,-0x38(%ebp)
    230c:	89 c2                	mov    %eax,%edx
    230e:	8b 45 08             	mov    0x8(%ebp),%eax
    2311:	01 d0                	add    %edx,%eax
    2313:	c6 00 00             	movb   $0x0,(%eax)
}
    2316:	90                   	nop
    2317:	c9                   	leave  
    2318:	c3                   	ret    
