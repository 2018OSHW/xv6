
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
      2b:	68 c4 24 00 00       	push   $0x24c4
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
      78:	68 d7 24 00 00       	push   $0x24d7
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
      ea:	68 e1 24 00 00       	push   $0x24e1
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
     4f4:	0f b6 80 e0 2b 00 00 	movzbl 0x2be0(%eax),%eax
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
     632:	c7 45 f4 e7 24 00 00 	movl   $0x24e7,-0xc(%ebp)
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
     6f8:	a1 40 68 00 00       	mov    0x6840,%eax
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
     7c3:	a3 40 68 00 00       	mov    %eax,0x6840
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
     824:	a1 40 68 00 00       	mov    0x6840,%eax
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
     840:	a1 40 68 00 00       	mov    0x6840,%eax
     845:	89 45 f0             	mov    %eax,-0x10(%ebp)
     848:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     84c:	75 23                	jne    871 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     84e:	c7 45 f0 38 68 00 00 	movl   $0x6838,-0x10(%ebp)
     855:	8b 45 f0             	mov    -0x10(%ebp),%eax
     858:	a3 40 68 00 00       	mov    %eax,0x6840
     85d:	a1 40 68 00 00       	mov    0x6840,%eax
     862:	a3 38 68 00 00       	mov    %eax,0x6838
    base.s.size = 0;
     867:	c7 05 3c 68 00 00 00 	movl   $0x0,0x683c
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
     8c4:	a3 40 68 00 00       	mov    %eax,0x6840
      return (void*)(p + 1);
     8c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cc:	83 c0 08             	add    $0x8,%eax
     8cf:	eb 3b                	jmp    90c <malloc+0xe1>
    }
    if(p == freep)
     8d1:	a1 40 68 00 00       	mov    0x6840,%eax
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
     a17:	68 ee 24 00 00       	push   $0x24ee
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

00000d28 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     d28:	55                   	push   %ebp
     d29:	89 e5                	mov    %esp,%ebp
     d2b:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     d2e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d31:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     d35:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     d39:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     d3d:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     d40:	8b 45 0c             	mov    0xc(%ebp),%eax
     d43:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     d47:	66 89 50 13          	mov    %dx,0x13(%eax)
     d4b:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d4f:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     d52:	8b 45 08             	mov    0x8(%ebp),%eax
     d55:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d59:	66 89 10             	mov    %dx,(%eax)
     d5c:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d60:	88 50 02             	mov    %dl,0x2(%eax)
}
     d63:	8b 45 08             	mov    0x8(%ebp),%eax
     d66:	c9                   	leave  
     d67:	c2 04 00             	ret    $0x4

00000d6a <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d6a:	55                   	push   %ebp
     d6b:	89 e5                	mov    %esp,%ebp
     d6d:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d70:	8b 45 08             	mov    0x8(%ebp),%eax
     d73:	8b 40 0c             	mov    0xc(%eax),%eax
     d76:	89 c2                	mov    %eax,%edx
     d78:	c1 ea 1f             	shr    $0x1f,%edx
     d7b:	01 d0                	add    %edx,%eax
     d7d:	d1 f8                	sar    %eax
     d7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d85:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d89:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d8c:	8b 45 10             	mov    0x10(%ebp),%eax
     d8f:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d92:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d95:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d99:	0f 89 98 00 00 00    	jns    e37 <APDrawPoint+0xcd>
        i = 0;
     d9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     da6:	e9 8c 00 00 00       	jmp    e37 <APDrawPoint+0xcd>
    {
        j = x - off;
     dab:	8b 45 0c             	mov    0xc(%ebp),%eax
     dae:	2b 45 f4             	sub    -0xc(%ebp),%eax
     db1:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     db4:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     db8:	79 69                	jns    e23 <APDrawPoint+0xb9>
            j = 0;
     dba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     dc1:	eb 60                	jmp    e23 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     dc3:	ff 75 fc             	pushl  -0x4(%ebp)
     dc6:	ff 75 f8             	pushl  -0x8(%ebp)
     dc9:	ff 75 08             	pushl  0x8(%ebp)
     dcc:	e8 bb fb ff ff       	call   98c <APGetIndex>
     dd1:	83 c4 0c             	add    $0xc,%esp
     dd4:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     dd7:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     ddb:	74 55                	je     e32 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     ddd:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     de1:	74 67                	je     e4a <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     de3:	ff 75 10             	pushl  0x10(%ebp)
     de6:	ff 75 0c             	pushl  0xc(%ebp)
     de9:	ff 75 fc             	pushl  -0x4(%ebp)
     dec:	ff 75 f8             	pushl  -0x8(%ebp)
     def:	e8 5f fb ff ff       	call   953 <distance_2>
     df4:	83 c4 10             	add    $0x10,%esp
     df7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     dfa:	7f 23                	jg     e1f <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     dfc:	8b 45 08             	mov    0x8(%ebp),%eax
     dff:	8b 48 18             	mov    0x18(%eax),%ecx
     e02:	8b 55 ec             	mov    -0x14(%ebp),%edx
     e05:	89 d0                	mov    %edx,%eax
     e07:	01 c0                	add    %eax,%eax
     e09:	01 d0                	add    %edx,%eax
     e0b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     e0e:	8b 45 08             	mov    0x8(%ebp),%eax
     e11:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     e15:	66 89 0a             	mov    %cx,(%edx)
     e18:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     e1c:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     e1f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e23:	8b 55 0c             	mov    0xc(%ebp),%edx
     e26:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e29:	01 d0                	add    %edx,%eax
     e2b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     e2e:	7d 93                	jge    dc3 <APDrawPoint+0x59>
     e30:	eb 01                	jmp    e33 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     e32:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     e33:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     e37:	8b 55 10             	mov    0x10(%ebp),%edx
     e3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3d:	01 d0                	add    %edx,%eax
     e3f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     e42:	0f 8d 63 ff ff ff    	jge    dab <APDrawPoint+0x41>
     e48:	eb 01                	jmp    e4b <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e4a:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e4b:	c9                   	leave  
     e4c:	c3                   	ret    

00000e4d <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e4d:	55                   	push   %ebp
     e4e:	89 e5                	mov    %esp,%ebp
     e50:	53                   	push   %ebx
     e51:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e54:	8b 45 0c             	mov    0xc(%ebp),%eax
     e57:	3b 45 14             	cmp    0x14(%ebp),%eax
     e5a:	0f 85 80 00 00 00    	jne    ee0 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e64:	0f 88 9d 02 00 00    	js     1107 <APDrawLine+0x2ba>
     e6a:	8b 45 08             	mov    0x8(%ebp),%eax
     e6d:	8b 00                	mov    (%eax),%eax
     e6f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e72:	0f 8e 8f 02 00 00    	jle    1107 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e78:	8b 45 10             	mov    0x10(%ebp),%eax
     e7b:	3b 45 18             	cmp    0x18(%ebp),%eax
     e7e:	7e 12                	jle    e92 <APDrawLine+0x45>
        {
            int tmp = y2;
     e80:	8b 45 18             	mov    0x18(%ebp),%eax
     e83:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e86:	8b 45 10             	mov    0x10(%ebp),%eax
     e89:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e8f:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e96:	79 07                	jns    e9f <APDrawLine+0x52>
     e98:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e9f:	8b 45 08             	mov    0x8(%ebp),%eax
     ea2:	8b 40 04             	mov    0x4(%eax),%eax
     ea5:	3b 45 18             	cmp    0x18(%ebp),%eax
     ea8:	7d 0c                	jge    eb6 <APDrawLine+0x69>
     eaa:	8b 45 08             	mov    0x8(%ebp),%eax
     ead:	8b 40 04             	mov    0x4(%eax),%eax
     eb0:	83 e8 01             	sub    $0x1,%eax
     eb3:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     eb6:	8b 45 10             	mov    0x10(%ebp),%eax
     eb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ebc:	eb 15                	jmp    ed3 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     ebe:	ff 75 f4             	pushl  -0xc(%ebp)
     ec1:	ff 75 0c             	pushl  0xc(%ebp)
     ec4:	ff 75 08             	pushl  0x8(%ebp)
     ec7:	e8 9e fe ff ff       	call   d6a <APDrawPoint>
     ecc:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     ecf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ed3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed6:	3b 45 18             	cmp    0x18(%ebp),%eax
     ed9:	7e e3                	jle    ebe <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     edb:	e9 2b 02 00 00       	jmp    110b <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     ee0:	8b 45 10             	mov    0x10(%ebp),%eax
     ee3:	3b 45 18             	cmp    0x18(%ebp),%eax
     ee6:	75 7f                	jne    f67 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     ee8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     eec:	0f 88 18 02 00 00    	js     110a <APDrawLine+0x2bd>
     ef2:	8b 45 08             	mov    0x8(%ebp),%eax
     ef5:	8b 40 04             	mov    0x4(%eax),%eax
     ef8:	3b 45 10             	cmp    0x10(%ebp),%eax
     efb:	0f 8e 09 02 00 00    	jle    110a <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     f01:	8b 45 0c             	mov    0xc(%ebp),%eax
     f04:	3b 45 14             	cmp    0x14(%ebp),%eax
     f07:	7e 12                	jle    f1b <APDrawLine+0xce>
        {
            int tmp = x2;
     f09:	8b 45 14             	mov    0x14(%ebp),%eax
     f0c:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     f0f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f12:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     f15:	8b 45 d8             	mov    -0x28(%ebp),%eax
     f18:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     f1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f1f:	79 07                	jns    f28 <APDrawLine+0xdb>
     f21:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     f28:	8b 45 08             	mov    0x8(%ebp),%eax
     f2b:	8b 00                	mov    (%eax),%eax
     f2d:	3b 45 14             	cmp    0x14(%ebp),%eax
     f30:	7d 0b                	jge    f3d <APDrawLine+0xf0>
     f32:	8b 45 08             	mov    0x8(%ebp),%eax
     f35:	8b 00                	mov    (%eax),%eax
     f37:	83 e8 01             	sub    $0x1,%eax
     f3a:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f40:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f43:	eb 15                	jmp    f5a <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     f45:	ff 75 10             	pushl  0x10(%ebp)
     f48:	ff 75 f0             	pushl  -0x10(%ebp)
     f4b:	ff 75 08             	pushl  0x8(%ebp)
     f4e:	e8 17 fe ff ff       	call   d6a <APDrawPoint>
     f53:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f56:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f5d:	3b 45 14             	cmp    0x14(%ebp),%eax
     f60:	7e e3                	jle    f45 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f62:	e9 a4 01 00 00       	jmp    110b <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f67:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f6e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f75:	8b 45 0c             	mov    0xc(%ebp),%eax
     f78:	2b 45 14             	sub    0x14(%ebp),%eax
     f7b:	50                   	push   %eax
     f7c:	e8 fb f9 ff ff       	call   97c <abs_int>
     f81:	83 c4 04             	add    $0x4,%esp
     f84:	89 c3                	mov    %eax,%ebx
     f86:	8b 45 10             	mov    0x10(%ebp),%eax
     f89:	2b 45 18             	sub    0x18(%ebp),%eax
     f8c:	50                   	push   %eax
     f8d:	e8 ea f9 ff ff       	call   97c <abs_int>
     f92:	83 c4 04             	add    $0x4,%esp
     f95:	39 c3                	cmp    %eax,%ebx
     f97:	0f 8e b5 00 00 00    	jle    1052 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f9d:	8b 45 10             	mov    0x10(%ebp),%eax
     fa0:	2b 45 18             	sub    0x18(%ebp),%eax
     fa3:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fa6:	db 45 b0             	fildl  -0x50(%ebp)
     fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
     fac:	2b 45 14             	sub    0x14(%ebp),%eax
     faf:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fb2:	db 45 b0             	fildl  -0x50(%ebp)
     fb5:	de f9                	fdivrp %st,%st(1)
     fb7:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     fba:	8b 45 14             	mov    0x14(%ebp),%eax
     fbd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     fc0:	7e 0e                	jle    fd0 <APDrawLine+0x183>
        {
            s = x1;
     fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
     fc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     fc8:	8b 45 14             	mov    0x14(%ebp),%eax
     fcb:	89 45 e8             	mov    %eax,-0x18(%ebp)
     fce:	eb 0c                	jmp    fdc <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     fd0:	8b 45 14             	mov    0x14(%ebp),%eax
     fd3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     fd6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd9:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     fdc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fe0:	79 07                	jns    fe9 <APDrawLine+0x19c>
     fe2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     fe9:	8b 45 08             	mov    0x8(%ebp),%eax
     fec:	8b 00                	mov    (%eax),%eax
     fee:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     ff1:	7f 0b                	jg     ffe <APDrawLine+0x1b1>
     ff3:	8b 45 08             	mov    0x8(%ebp),%eax
     ff6:	8b 00                	mov    (%eax),%eax
     ff8:	83 e8 01             	sub    $0x1,%eax
     ffb:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     ffe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1001:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1004:	eb 3f                	jmp    1045 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1006:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1009:	2b 45 0c             	sub    0xc(%ebp),%eax
    100c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    100f:	db 45 b0             	fildl  -0x50(%ebp)
    1012:	dc 4d d0             	fmull  -0x30(%ebp)
    1015:	db 45 10             	fildl  0x10(%ebp)
    1018:	de c1                	faddp  %st,%st(1)
    101a:	d9 7d b6             	fnstcw -0x4a(%ebp)
    101d:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1021:	b4 0c                	mov    $0xc,%ah
    1023:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1027:	d9 6d b4             	fldcw  -0x4c(%ebp)
    102a:	db 5d cc             	fistpl -0x34(%ebp)
    102d:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1030:	ff 75 cc             	pushl  -0x34(%ebp)
    1033:	ff 75 e4             	pushl  -0x1c(%ebp)
    1036:	ff 75 08             	pushl  0x8(%ebp)
    1039:	e8 2c fd ff ff       	call   d6a <APDrawPoint>
    103e:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1041:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1045:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1048:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    104b:	7e b9                	jle    1006 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    104d:	e9 b9 00 00 00       	jmp    110b <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1052:	8b 45 0c             	mov    0xc(%ebp),%eax
    1055:	2b 45 14             	sub    0x14(%ebp),%eax
    1058:	89 45 b0             	mov    %eax,-0x50(%ebp)
    105b:	db 45 b0             	fildl  -0x50(%ebp)
    105e:	8b 45 10             	mov    0x10(%ebp),%eax
    1061:	2b 45 18             	sub    0x18(%ebp),%eax
    1064:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1067:	db 45 b0             	fildl  -0x50(%ebp)
    106a:	de f9                	fdivrp %st,%st(1)
    106c:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    106f:	8b 45 10             	mov    0x10(%ebp),%eax
    1072:	3b 45 18             	cmp    0x18(%ebp),%eax
    1075:	7e 0e                	jle    1085 <APDrawLine+0x238>
    {
        s = y2;
    1077:	8b 45 18             	mov    0x18(%ebp),%eax
    107a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    107d:	8b 45 10             	mov    0x10(%ebp),%eax
    1080:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1083:	eb 0c                	jmp    1091 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1085:	8b 45 10             	mov    0x10(%ebp),%eax
    1088:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    108b:	8b 45 18             	mov    0x18(%ebp),%eax
    108e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1091:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1095:	79 07                	jns    109e <APDrawLine+0x251>
    1097:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    109e:	8b 45 08             	mov    0x8(%ebp),%eax
    10a1:	8b 40 04             	mov    0x4(%eax),%eax
    10a4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10a7:	7f 0c                	jg     10b5 <APDrawLine+0x268>
    10a9:	8b 45 08             	mov    0x8(%ebp),%eax
    10ac:	8b 40 04             	mov    0x4(%eax),%eax
    10af:	83 e8 01             	sub    $0x1,%eax
    10b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    10b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10b8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10bb:	eb 3f                	jmp    10fc <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    10bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10c0:	2b 45 10             	sub    0x10(%ebp),%eax
    10c3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    10c6:	db 45 b0             	fildl  -0x50(%ebp)
    10c9:	dc 4d c0             	fmull  -0x40(%ebp)
    10cc:	db 45 0c             	fildl  0xc(%ebp)
    10cf:	de c1                	faddp  %st,%st(1)
    10d1:	d9 7d b6             	fnstcw -0x4a(%ebp)
    10d4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    10d8:	b4 0c                	mov    $0xc,%ah
    10da:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    10de:	d9 6d b4             	fldcw  -0x4c(%ebp)
    10e1:	db 5d bc             	fistpl -0x44(%ebp)
    10e4:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    10e7:	ff 75 e0             	pushl  -0x20(%ebp)
    10ea:	ff 75 bc             	pushl  -0x44(%ebp)
    10ed:	ff 75 08             	pushl  0x8(%ebp)
    10f0:	e8 75 fc ff ff       	call   d6a <APDrawPoint>
    10f5:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10f8:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10ff:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1102:	7e b9                	jle    10bd <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1104:	90                   	nop
    1105:	eb 04                	jmp    110b <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1107:	90                   	nop
    1108:	eb 01                	jmp    110b <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    110a:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    110b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    110e:	c9                   	leave  
    110f:	c3                   	ret    

00001110 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	53                   	push   %ebx
    1114:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1117:	8b 55 10             	mov    0x10(%ebp),%edx
    111a:	8b 45 18             	mov    0x18(%ebp),%eax
    111d:	01 d0                	add    %edx,%eax
    111f:	83 e8 01             	sub    $0x1,%eax
    1122:	83 ec 04             	sub    $0x4,%esp
    1125:	50                   	push   %eax
    1126:	ff 75 0c             	pushl  0xc(%ebp)
    1129:	ff 75 10             	pushl  0x10(%ebp)
    112c:	ff 75 0c             	pushl  0xc(%ebp)
    112f:	ff 75 08             	pushl  0x8(%ebp)
    1132:	e8 16 fd ff ff       	call   e4d <APDrawLine>
    1137:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    113a:	8b 55 0c             	mov    0xc(%ebp),%edx
    113d:	8b 45 14             	mov    0x14(%ebp),%eax
    1140:	01 d0                	add    %edx,%eax
    1142:	83 e8 01             	sub    $0x1,%eax
    1145:	83 ec 04             	sub    $0x4,%esp
    1148:	ff 75 10             	pushl  0x10(%ebp)
    114b:	50                   	push   %eax
    114c:	ff 75 10             	pushl  0x10(%ebp)
    114f:	ff 75 0c             	pushl  0xc(%ebp)
    1152:	ff 75 08             	pushl  0x8(%ebp)
    1155:	e8 f3 fc ff ff       	call   e4d <APDrawLine>
    115a:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    115d:	8b 55 10             	mov    0x10(%ebp),%edx
    1160:	8b 45 18             	mov    0x18(%ebp),%eax
    1163:	01 d0                	add    %edx,%eax
    1165:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1168:	8b 55 0c             	mov    0xc(%ebp),%edx
    116b:	8b 45 14             	mov    0x14(%ebp),%eax
    116e:	01 d0                	add    %edx,%eax
    1170:	8d 50 ff             	lea    -0x1(%eax),%edx
    1173:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1176:	8b 45 14             	mov    0x14(%ebp),%eax
    1179:	01 d8                	add    %ebx,%eax
    117b:	83 e8 01             	sub    $0x1,%eax
    117e:	83 ec 04             	sub    $0x4,%esp
    1181:	51                   	push   %ecx
    1182:	52                   	push   %edx
    1183:	ff 75 10             	pushl  0x10(%ebp)
    1186:	50                   	push   %eax
    1187:	ff 75 08             	pushl  0x8(%ebp)
    118a:	e8 be fc ff ff       	call   e4d <APDrawLine>
    118f:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1192:	8b 55 10             	mov    0x10(%ebp),%edx
    1195:	8b 45 18             	mov    0x18(%ebp),%eax
    1198:	01 d0                	add    %edx,%eax
    119a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    119d:	8b 55 0c             	mov    0xc(%ebp),%edx
    11a0:	8b 45 14             	mov    0x14(%ebp),%eax
    11a3:	01 d0                	add    %edx,%eax
    11a5:	8d 50 ff             	lea    -0x1(%eax),%edx
    11a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    11ab:	8b 45 18             	mov    0x18(%ebp),%eax
    11ae:	01 d8                	add    %ebx,%eax
    11b0:	83 e8 01             	sub    $0x1,%eax
    11b3:	83 ec 04             	sub    $0x4,%esp
    11b6:	51                   	push   %ecx
    11b7:	52                   	push   %edx
    11b8:	50                   	push   %eax
    11b9:	ff 75 0c             	pushl  0xc(%ebp)
    11bc:	ff 75 08             	pushl  0x8(%ebp)
    11bf:	e8 89 fc ff ff       	call   e4d <APDrawLine>
    11c4:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    11c7:	8b 55 0c             	mov    0xc(%ebp),%edx
    11ca:	8b 45 14             	mov    0x14(%ebp),%eax
    11cd:	01 d0                	add    %edx,%eax
    11cf:	8d 50 ff             	lea    -0x1(%eax),%edx
    11d2:	8b 45 08             	mov    0x8(%ebp),%eax
    11d5:	8b 40 0c             	mov    0xc(%eax),%eax
    11d8:	89 c1                	mov    %eax,%ecx
    11da:	c1 e9 1f             	shr    $0x1f,%ecx
    11dd:	01 c8                	add    %ecx,%eax
    11df:	d1 f8                	sar    %eax
    11e1:	29 c2                	sub    %eax,%edx
    11e3:	89 d0                	mov    %edx,%eax
    11e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    11e8:	8b 55 10             	mov    0x10(%ebp),%edx
    11eb:	8b 45 18             	mov    0x18(%ebp),%eax
    11ee:	01 d0                	add    %edx,%eax
    11f0:	8d 50 ff             	lea    -0x1(%eax),%edx
    11f3:	8b 45 08             	mov    0x8(%ebp),%eax
    11f6:	8b 40 0c             	mov    0xc(%eax),%eax
    11f9:	89 c1                	mov    %eax,%ecx
    11fb:	c1 e9 1f             	shr    $0x1f,%ecx
    11fe:	01 c8                	add    %ecx,%eax
    1200:	d1 f8                	sar    %eax
    1202:	29 c2                	sub    %eax,%edx
    1204:	89 d0                	mov    %edx,%eax
    1206:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1209:	8b 45 08             	mov    0x8(%ebp),%eax
    120c:	8b 40 0c             	mov    0xc(%eax),%eax
    120f:	89 c2                	mov    %eax,%edx
    1211:	c1 ea 1f             	shr    $0x1f,%edx
    1214:	01 d0                	add    %edx,%eax
    1216:	d1 f8                	sar    %eax
    1218:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    121b:	8b 45 08             	mov    0x8(%ebp),%eax
    121e:	8b 40 0c             	mov    0xc(%eax),%eax
    1221:	89 c2                	mov    %eax,%edx
    1223:	c1 ea 1f             	shr    $0x1f,%edx
    1226:	01 d0                	add    %edx,%eax
    1228:	d1 f8                	sar    %eax
    122a:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    122d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1231:	0f 88 d8 00 00 00    	js     130f <APDrawRect+0x1ff>
    1237:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    123b:	0f 88 ce 00 00 00    	js     130f <APDrawRect+0x1ff>
    1241:	8b 45 08             	mov    0x8(%ebp),%eax
    1244:	8b 00                	mov    (%eax),%eax
    1246:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1249:	0f 8e c0 00 00 00    	jle    130f <APDrawRect+0x1ff>
    124f:	8b 45 08             	mov    0x8(%ebp),%eax
    1252:	8b 40 04             	mov    0x4(%eax),%eax
    1255:	3b 45 10             	cmp    0x10(%ebp),%eax
    1258:	0f 8e b1 00 00 00    	jle    130f <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    125e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1262:	79 07                	jns    126b <APDrawRect+0x15b>
    1264:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    126b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    126f:	79 07                	jns    1278 <APDrawRect+0x168>
    1271:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1278:	8b 45 08             	mov    0x8(%ebp),%eax
    127b:	8b 00                	mov    (%eax),%eax
    127d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1280:	7f 0b                	jg     128d <APDrawRect+0x17d>
    1282:	8b 45 08             	mov    0x8(%ebp),%eax
    1285:	8b 00                	mov    (%eax),%eax
    1287:	83 e8 01             	sub    $0x1,%eax
    128a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    128d:	8b 45 08             	mov    0x8(%ebp),%eax
    1290:	8b 40 04             	mov    0x4(%eax),%eax
    1293:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1296:	7f 0c                	jg     12a4 <APDrawRect+0x194>
    1298:	8b 45 08             	mov    0x8(%ebp),%eax
    129b:	8b 40 04             	mov    0x4(%eax),%eax
    129e:	83 e8 01             	sub    $0x1,%eax
    12a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    12a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12b1:	eb 52                	jmp    1305 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    12b3:	8b 45 10             	mov    0x10(%ebp),%eax
    12b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    12b9:	eb 3e                	jmp    12f9 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    12bb:	83 ec 04             	sub    $0x4,%esp
    12be:	ff 75 e8             	pushl  -0x18(%ebp)
    12c1:	ff 75 ec             	pushl  -0x14(%ebp)
    12c4:	ff 75 08             	pushl  0x8(%ebp)
    12c7:	e8 c0 f6 ff ff       	call   98c <APGetIndex>
    12cc:	83 c4 10             	add    $0x10,%esp
    12cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    12d2:	8b 45 08             	mov    0x8(%ebp),%eax
    12d5:	8b 48 18             	mov    0x18(%eax),%ecx
    12d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    12db:	89 d0                	mov    %edx,%eax
    12dd:	01 c0                	add    %eax,%eax
    12df:	01 d0                	add    %edx,%eax
    12e1:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    12e4:	8b 45 08             	mov    0x8(%ebp),%eax
    12e7:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12eb:	66 89 0a             	mov    %cx,(%edx)
    12ee:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12f2:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12f5:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12fc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12ff:	7e ba                	jle    12bb <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1301:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1305:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1308:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    130b:	7e a6                	jle    12b3 <APDrawRect+0x1a3>
    130d:	eb 01                	jmp    1310 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    130f:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1310:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1313:	c9                   	leave  
    1314:	c3                   	ret    

00001315 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1315:	55                   	push   %ebp
    1316:	89 e5                	mov    %esp,%ebp
    1318:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    131b:	83 ec 0c             	sub    $0xc,%esp
    131e:	ff 75 0c             	pushl  0xc(%ebp)
    1321:	e8 c1 ee ff ff       	call   1e7 <strlen>
    1326:	83 c4 10             	add    $0x10,%esp
    1329:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    132c:	8b 45 08             	mov    0x8(%ebp),%eax
    132f:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1333:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1337:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    133b:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    133e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1345:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    134c:	e9 bc 00 00 00       	jmp    140d <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1351:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1354:	8b 45 0c             	mov    0xc(%ebp),%eax
    1357:	01 d0                	add    %edx,%eax
    1359:	0f b6 00             	movzbl (%eax),%eax
    135c:	0f be c0             	movsbl %al,%eax
    135f:	83 e8 20             	sub    $0x20,%eax
    1362:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1365:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1369:	0f 87 9a 00 00 00    	ja     1409 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
    1372:	8b 00                	mov    (%eax),%eax
    1374:	0f af 45 14          	imul   0x14(%ebp),%eax
    1378:	89 c2                	mov    %eax,%edx
    137a:	8b 45 10             	mov    0x10(%ebp),%eax
    137d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1380:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1383:	89 d0                	mov    %edx,%eax
    1385:	c1 e0 03             	shl    $0x3,%eax
    1388:	01 d0                	add    %edx,%eax
    138a:	01 c8                	add    %ecx,%eax
    138c:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    138f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1396:	eb 6b                	jmp    1403 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1398:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    139f:	eb 50                	jmp    13f1 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    13a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13a4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13a7:	89 d0                	mov    %edx,%eax
    13a9:	c1 e0 03             	shl    $0x3,%eax
    13ac:	01 d0                	add    %edx,%eax
    13ae:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    13b4:	01 c2                	add    %eax,%edx
    13b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13b9:	01 d0                	add    %edx,%eax
    13bb:	05 00 2c 00 00       	add    $0x2c00,%eax
    13c0:	0f b6 00             	movzbl (%eax),%eax
    13c3:	84 c0                	test   %al,%al
    13c5:	74 26                	je     13ed <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    13c7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ca:	8b 50 18             	mov    0x18(%eax),%edx
    13cd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    13d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13d3:	01 c8                	add    %ecx,%eax
    13d5:	89 c1                	mov    %eax,%ecx
    13d7:	89 c8                	mov    %ecx,%eax
    13d9:	01 c0                	add    %eax,%eax
    13db:	01 c8                	add    %ecx,%eax
    13dd:	01 d0                	add    %edx,%eax
    13df:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    13e3:	66 89 10             	mov    %dx,(%eax)
    13e6:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ea:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    13ed:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    13f1:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    13f5:	7e aa                	jle    13a1 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    13f7:	8b 45 08             	mov    0x8(%ebp),%eax
    13fa:	8b 00                	mov    (%eax),%eax
    13fc:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    13ff:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1403:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    1407:	7e 8f                	jle    1398 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    1409:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    140d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1410:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1413:	0f 82 38 ff ff ff    	jb     1351 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1419:	90                   	nop
    141a:	c9                   	leave  
    141b:	c3                   	ret    

0000141c <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    141c:	55                   	push   %ebp
    141d:	89 e5                	mov    %esp,%ebp
    141f:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1422:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1426:	0f 88 8e 01 00 00    	js     15ba <APDcCopy+0x19e>
    142c:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1430:	0f 88 84 01 00 00    	js     15ba <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1436:	8b 55 0c             	mov    0xc(%ebp),%edx
    1439:	8b 45 20             	mov    0x20(%ebp),%eax
    143c:	01 d0                	add    %edx,%eax
    143e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1441:	8b 55 10             	mov    0x10(%ebp),%edx
    1444:	8b 45 24             	mov    0x24(%ebp),%eax
    1447:	01 d0                	add    %edx,%eax
    1449:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    144c:	8b 55 18             	mov    0x18(%ebp),%edx
    144f:	8b 45 20             	mov    0x20(%ebp),%eax
    1452:	01 d0                	add    %edx,%eax
    1454:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1457:	8b 55 1c             	mov    0x1c(%ebp),%edx
    145a:	8b 45 24             	mov    0x24(%ebp),%eax
    145d:	01 d0                	add    %edx,%eax
    145f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1462:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1466:	0f 88 51 01 00 00    	js     15bd <APDcCopy+0x1a1>
    146c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1470:	0f 88 47 01 00 00    	js     15bd <APDcCopy+0x1a1>
    1476:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    147a:	0f 88 3d 01 00 00    	js     15bd <APDcCopy+0x1a1>
    1480:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1484:	0f 88 33 01 00 00    	js     15bd <APDcCopy+0x1a1>
    148a:	8b 45 14             	mov    0x14(%ebp),%eax
    148d:	8b 00                	mov    (%eax),%eax
    148f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1492:	0f 8c 25 01 00 00    	jl     15bd <APDcCopy+0x1a1>
    1498:	8b 45 14             	mov    0x14(%ebp),%eax
    149b:	8b 40 04             	mov    0x4(%eax),%eax
    149e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    14a1:	0f 8c 16 01 00 00    	jl     15bd <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    14a7:	8b 45 08             	mov    0x8(%ebp),%eax
    14aa:	8b 00                	mov    (%eax),%eax
    14ac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14af:	7f 0b                	jg     14bc <APDcCopy+0xa0>
    14b1:	8b 45 08             	mov    0x8(%ebp),%eax
    14b4:	8b 00                	mov    (%eax),%eax
    14b6:	83 e8 01             	sub    $0x1,%eax
    14b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    14bc:	8b 45 08             	mov    0x8(%ebp),%eax
    14bf:	8b 40 04             	mov    0x4(%eax),%eax
    14c2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14c5:	7f 0c                	jg     14d3 <APDcCopy+0xb7>
    14c7:	8b 45 08             	mov    0x8(%ebp),%eax
    14ca:	8b 40 04             	mov    0x4(%eax),%eax
    14cd:	83 e8 01             	sub    $0x1,%eax
    14d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    14d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    14da:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    14e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14e8:	e9 bc 00 00 00       	jmp    15a9 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    14ed:	8b 45 08             	mov    0x8(%ebp),%eax
    14f0:	8b 00                	mov    (%eax),%eax
    14f2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    14f5:	8b 55 10             	mov    0x10(%ebp),%edx
    14f8:	01 ca                	add    %ecx,%edx
    14fa:	0f af d0             	imul   %eax,%edx
    14fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1500:	01 d0                	add    %edx,%eax
    1502:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1505:	8b 45 14             	mov    0x14(%ebp),%eax
    1508:	8b 00                	mov    (%eax),%eax
    150a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    150d:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1510:	01 ca                	add    %ecx,%edx
    1512:	0f af d0             	imul   %eax,%edx
    1515:	8b 45 18             	mov    0x18(%ebp),%eax
    1518:	01 d0                	add    %edx,%eax
    151a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    151d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1524:	eb 74                	jmp    159a <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1526:	8b 45 14             	mov    0x14(%ebp),%eax
    1529:	8b 50 18             	mov    0x18(%eax),%edx
    152c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    152f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1532:	01 c8                	add    %ecx,%eax
    1534:	89 c1                	mov    %eax,%ecx
    1536:	89 c8                	mov    %ecx,%eax
    1538:	01 c0                	add    %eax,%eax
    153a:	01 c8                	add    %ecx,%eax
    153c:	01 d0                	add    %edx,%eax
    153e:	0f b7 10             	movzwl (%eax),%edx
    1541:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1545:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1549:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    154c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1550:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1554:	38 c2                	cmp    %al,%dl
    1556:	75 18                	jne    1570 <APDcCopy+0x154>
    1558:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    155c:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1560:	38 c2                	cmp    %al,%dl
    1562:	75 0c                	jne    1570 <APDcCopy+0x154>
    1564:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1568:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    156c:	38 c2                	cmp    %al,%dl
    156e:	74 26                	je     1596 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1570:	8b 45 08             	mov    0x8(%ebp),%eax
    1573:	8b 50 18             	mov    0x18(%eax),%edx
    1576:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1579:	8b 45 f0             	mov    -0x10(%ebp),%eax
    157c:	01 c8                	add    %ecx,%eax
    157e:	89 c1                	mov    %eax,%ecx
    1580:	89 c8                	mov    %ecx,%eax
    1582:	01 c0                	add    %eax,%eax
    1584:	01 c8                	add    %ecx,%eax
    1586:	01 d0                	add    %edx,%eax
    1588:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    158c:	66 89 10             	mov    %dx,(%eax)
    158f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1593:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1596:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    159a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    159d:	2b 45 0c             	sub    0xc(%ebp),%eax
    15a0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    15a3:	7d 81                	jge    1526 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    15a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    15a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15ac:	2b 45 10             	sub    0x10(%ebp),%eax
    15af:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    15b2:	0f 8d 35 ff ff ff    	jge    14ed <APDcCopy+0xd1>
    15b8:	eb 04                	jmp    15be <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    15ba:	90                   	nop
    15bb:	eb 01                	jmp    15be <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    15bd:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    15be:	c9                   	leave  
    15bf:	c3                   	ret    

000015c0 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	83 ec 1c             	sub    $0x1c,%esp
    15c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    15c9:	8b 55 10             	mov    0x10(%ebp),%edx
    15cc:	8b 45 14             	mov    0x14(%ebp),%eax
    15cf:	88 4d ec             	mov    %cl,-0x14(%ebp)
    15d2:	88 55 e8             	mov    %dl,-0x18(%ebp)
    15d5:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    15d8:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    15dc:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    15df:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    15e3:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    15e6:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    15ea:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    15ed:	8b 45 08             	mov    0x8(%ebp),%eax
    15f0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    15f4:	66 89 10             	mov    %dx,(%eax)
    15f7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    15fb:	88 50 02             	mov    %dl,0x2(%eax)
}
    15fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1601:	c9                   	leave  
    1602:	c2 04 00             	ret    $0x4

00001605 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1605:	55                   	push   %ebp
    1606:	89 e5                	mov    %esp,%ebp
    1608:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    160b:	8b 45 08             	mov    0x8(%ebp),%eax
    160e:	8b 00                	mov    (%eax),%eax
    1610:	83 ec 08             	sub    $0x8,%esp
    1613:	8d 55 0c             	lea    0xc(%ebp),%edx
    1616:	52                   	push   %edx
    1617:	50                   	push   %eax
    1618:	e8 34 ee ff ff       	call   451 <sendMessage>
    161d:	83 c4 10             	add    $0x10,%esp
}
    1620:	90                   	nop
    1621:	c9                   	leave  
    1622:	c3                   	ret    

00001623 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1623:	55                   	push   %ebp
    1624:	89 e5                	mov    %esp,%ebp
    1626:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1629:	83 ec 0c             	sub    $0xc,%esp
    162c:	68 98 00 00 00       	push   $0x98
    1631:	e8 f5 f1 ff ff       	call   82b <malloc>
    1636:	83 c4 10             	add    $0x10,%esp
    1639:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    163c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1640:	75 15                	jne    1657 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1642:	83 ec 04             	sub    $0x4,%esp
    1645:	ff 75 08             	pushl  0x8(%ebp)
    1648:	68 00 25 00 00       	push   $0x2500
    164d:	6a 01                	push   $0x1
    164f:	e8 04 ef ff ff       	call   558 <printf>
    1654:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1657:	8b 45 f4             	mov    -0xc(%ebp),%eax
    165a:	05 84 00 00 00       	add    $0x84,%eax
    165f:	83 ec 08             	sub    $0x8,%esp
    1662:	ff 75 08             	pushl  0x8(%ebp)
    1665:	50                   	push   %eax
    1666:	e8 0d eb ff ff       	call   178 <strcpy>
    166b:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    166e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1671:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1678:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167b:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1682:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1685:	8b 40 3c             	mov    0x3c(%eax),%eax
    1688:	89 c2                	mov    %eax,%edx
    168a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168d:	8b 40 40             	mov    0x40(%eax),%eax
    1690:	0f af d0             	imul   %eax,%edx
    1693:	89 d0                	mov    %edx,%eax
    1695:	01 c0                	add    %eax,%eax
    1697:	01 d0                	add    %edx,%eax
    1699:	83 ec 0c             	sub    $0xc,%esp
    169c:	50                   	push   %eax
    169d:	e8 89 f1 ff ff       	call   82b <malloc>
    16a2:	83 c4 10             	add    $0x10,%esp
    16a5:	89 c2                	mov    %eax,%edx
    16a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16aa:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    16ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b0:	8b 40 54             	mov    0x54(%eax),%eax
    16b3:	85 c0                	test   %eax,%eax
    16b5:	75 15                	jne    16cc <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    16b7:	83 ec 04             	sub    $0x4,%esp
    16ba:	ff 75 08             	pushl  0x8(%ebp)
    16bd:	68 20 25 00 00       	push   $0x2520
    16c2:	6a 01                	push   $0x1
    16c4:	e8 8f ee ff ff       	call   558 <printf>
    16c9:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    16cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cf:	8b 40 3c             	mov    0x3c(%eax),%eax
    16d2:	89 c2                	mov    %eax,%edx
    16d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d7:	8b 40 40             	mov    0x40(%eax),%eax
    16da:	0f af d0             	imul   %eax,%edx
    16dd:	89 d0                	mov    %edx,%eax
    16df:	01 c0                	add    %eax,%eax
    16e1:	01 c2                	add    %eax,%edx
    16e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e6:	8b 40 54             	mov    0x54(%eax),%eax
    16e9:	83 ec 04             	sub    $0x4,%esp
    16ec:	52                   	push   %edx
    16ed:	68 ff ff ff 00       	push   $0xffffff
    16f2:	50                   	push   %eax
    16f3:	e8 16 eb ff ff       	call   20e <memset>
    16f8:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    16fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fe:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1705:	e8 1f ed ff ff       	call   429 <getpid>
    170a:	89 c2                	mov    %eax,%edx
    170c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170f:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1712:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1715:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    171c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171f:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    1726:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1729:	8b 40 58             	mov    0x58(%eax),%eax
    172c:	89 c2                	mov    %eax,%edx
    172e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1731:	8b 40 5c             	mov    0x5c(%eax),%eax
    1734:	0f af d0             	imul   %eax,%edx
    1737:	89 d0                	mov    %edx,%eax
    1739:	01 c0                	add    %eax,%eax
    173b:	01 d0                	add    %edx,%eax
    173d:	83 ec 0c             	sub    $0xc,%esp
    1740:	50                   	push   %eax
    1741:	e8 e5 f0 ff ff       	call   82b <malloc>
    1746:	83 c4 10             	add    $0x10,%esp
    1749:	89 c2                	mov    %eax,%edx
    174b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174e:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1751:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1754:	8b 40 70             	mov    0x70(%eax),%eax
    1757:	85 c0                	test   %eax,%eax
    1759:	75 15                	jne    1770 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    175b:	83 ec 04             	sub    $0x4,%esp
    175e:	ff 75 08             	pushl  0x8(%ebp)
    1761:	68 44 25 00 00       	push   $0x2544
    1766:	6a 01                	push   $0x1
    1768:	e8 eb ed ff ff       	call   558 <printf>
    176d:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1770:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1773:	8b 40 3c             	mov    0x3c(%eax),%eax
    1776:	89 c2                	mov    %eax,%edx
    1778:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177b:	8b 40 40             	mov    0x40(%eax),%eax
    177e:	0f af d0             	imul   %eax,%edx
    1781:	89 d0                	mov    %edx,%eax
    1783:	01 c0                	add    %eax,%eax
    1785:	01 c2                	add    %eax,%edx
    1787:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178a:	8b 40 54             	mov    0x54(%eax),%eax
    178d:	83 ec 04             	sub    $0x4,%esp
    1790:	52                   	push   %edx
    1791:	68 ff 00 00 00       	push   $0xff
    1796:	50                   	push   %eax
    1797:	e8 72 ea ff ff       	call   20e <memset>
    179c:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    179f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a2:	8b 55 0c             	mov    0xc(%ebp),%edx
    17a5:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    17a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    17ac:	74 49                	je     17f7 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    17ae:	8b 45 10             	mov    0x10(%ebp),%eax
    17b1:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    17b7:	83 ec 0c             	sub    $0xc,%esp
    17ba:	50                   	push   %eax
    17bb:	e8 6b f0 ff ff       	call   82b <malloc>
    17c0:	83 c4 10             	add    $0x10,%esp
    17c3:	89 c2                	mov    %eax,%edx
    17c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c8:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    17cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ce:	8b 55 10             	mov    0x10(%ebp),%edx
    17d1:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    17d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    17de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e1:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    17e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17eb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    17f2:	e9 8d 00 00 00       	jmp    1884 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    17f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fa:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1801:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1804:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    180b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180e:	8b 40 20             	mov    0x20(%eax),%eax
    1811:	89 c2                	mov    %eax,%edx
    1813:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1816:	8b 40 24             	mov    0x24(%eax),%eax
    1819:	0f af d0             	imul   %eax,%edx
    181c:	89 d0                	mov    %edx,%eax
    181e:	01 c0                	add    %eax,%eax
    1820:	01 d0                	add    %edx,%eax
    1822:	83 ec 0c             	sub    $0xc,%esp
    1825:	50                   	push   %eax
    1826:	e8 00 f0 ff ff       	call   82b <malloc>
    182b:	83 c4 10             	add    $0x10,%esp
    182e:	89 c2                	mov    %eax,%edx
    1830:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1833:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1836:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1839:	8b 40 38             	mov    0x38(%eax),%eax
    183c:	85 c0                	test   %eax,%eax
    183e:	75 15                	jne    1855 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1840:	83 ec 04             	sub    $0x4,%esp
    1843:	ff 75 08             	pushl  0x8(%ebp)
    1846:	68 6c 25 00 00       	push   $0x256c
    184b:	6a 01                	push   $0x1
    184d:	e8 06 ed ff ff       	call   558 <printf>
    1852:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1855:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1858:	8b 40 20             	mov    0x20(%eax),%eax
    185b:	89 c2                	mov    %eax,%edx
    185d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1860:	8b 40 24             	mov    0x24(%eax),%eax
    1863:	0f af d0             	imul   %eax,%edx
    1866:	89 d0                	mov    %edx,%eax
    1868:	01 c0                	add    %eax,%eax
    186a:	01 c2                	add    %eax,%edx
    186c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186f:	8b 40 38             	mov    0x38(%eax),%eax
    1872:	83 ec 04             	sub    $0x4,%esp
    1875:	52                   	push   %edx
    1876:	68 ff ff ff 00       	push   $0xffffff
    187b:	50                   	push   %eax
    187c:	e8 8d e9 ff ff       	call   20e <memset>
    1881:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1884:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1887:	c9                   	leave  
    1888:	c3                   	ret    

00001889 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1889:	55                   	push   %ebp
    188a:	89 e5                	mov    %esp,%ebp
    188c:	57                   	push   %edi
    188d:	56                   	push   %esi
    188e:	53                   	push   %ebx
    188f:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1892:	8b 45 0c             	mov    0xc(%ebp),%eax
    1895:	83 f8 03             	cmp    $0x3,%eax
    1898:	74 02                	je     189c <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    189a:	eb 7c                	jmp    1918 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    189c:	8b 45 08             	mov    0x8(%ebp),%eax
    189f:	8b 58 1c             	mov    0x1c(%eax),%ebx
    18a2:	8b 45 08             	mov    0x8(%ebp),%eax
    18a5:	8b 48 18             	mov    0x18(%eax),%ecx
    18a8:	8b 45 08             	mov    0x8(%ebp),%eax
    18ab:	8b 50 5c             	mov    0x5c(%eax),%edx
    18ae:	8b 45 08             	mov    0x8(%ebp),%eax
    18b1:	8b 40 58             	mov    0x58(%eax),%eax
    18b4:	8b 75 08             	mov    0x8(%ebp),%esi
    18b7:	83 c6 58             	add    $0x58,%esi
    18ba:	83 ec 04             	sub    $0x4,%esp
    18bd:	53                   	push   %ebx
    18be:	51                   	push   %ecx
    18bf:	6a 00                	push   $0x0
    18c1:	52                   	push   %edx
    18c2:	50                   	push   %eax
    18c3:	6a 00                	push   $0x0
    18c5:	6a 00                	push   $0x0
    18c7:	56                   	push   %esi
    18c8:	6a 00                	push   $0x0
    18ca:	6a 00                	push   $0x0
    18cc:	ff 75 08             	pushl  0x8(%ebp)
    18cf:	e8 75 eb ff ff       	call   449 <paintWindow>
    18d4:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    18d7:	8b 45 08             	mov    0x8(%ebp),%eax
    18da:	8b 70 1c             	mov    0x1c(%eax),%esi
    18dd:	8b 45 08             	mov    0x8(%ebp),%eax
    18e0:	8b 58 18             	mov    0x18(%eax),%ebx
    18e3:	8b 45 08             	mov    0x8(%ebp),%eax
    18e6:	8b 48 08             	mov    0x8(%eax),%ecx
    18e9:	8b 45 08             	mov    0x8(%ebp),%eax
    18ec:	8b 50 40             	mov    0x40(%eax),%edx
    18ef:	8b 45 08             	mov    0x8(%ebp),%eax
    18f2:	8b 40 3c             	mov    0x3c(%eax),%eax
    18f5:	8b 7d 08             	mov    0x8(%ebp),%edi
    18f8:	83 c7 3c             	add    $0x3c,%edi
    18fb:	83 ec 04             	sub    $0x4,%esp
    18fe:	56                   	push   %esi
    18ff:	53                   	push   %ebx
    1900:	51                   	push   %ecx
    1901:	52                   	push   %edx
    1902:	50                   	push   %eax
    1903:	6a 00                	push   $0x0
    1905:	6a 00                	push   $0x0
    1907:	57                   	push   %edi
    1908:	6a 32                	push   $0x32
    190a:	6a 00                	push   $0x0
    190c:	ff 75 08             	pushl  0x8(%ebp)
    190f:	e8 35 eb ff ff       	call   449 <paintWindow>
    1914:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1917:	90                   	nop
        default: break;
            
            
    }
    return False;
    1918:	b8 00 00 00 00       	mov    $0x0,%eax
}
    191d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1920:	5b                   	pop    %ebx
    1921:	5e                   	pop    %esi
    1922:	5f                   	pop    %edi
    1923:	5d                   	pop    %ebp
    1924:	c3                   	ret    

00001925 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1925:	55                   	push   %ebp
    1926:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1928:	8b 45 0c             	mov    0xc(%ebp),%eax
    192b:	8b 50 08             	mov    0x8(%eax),%edx
    192e:	8b 45 08             	mov    0x8(%ebp),%eax
    1931:	8b 00                	mov    (%eax),%eax
    1933:	39 c2                	cmp    %eax,%edx
    1935:	74 07                	je     193e <APPreJudge+0x19>
        return False;
    1937:	b8 00 00 00 00       	mov    $0x0,%eax
    193c:	eb 05                	jmp    1943 <APPreJudge+0x1e>
    return True;
    193e:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1943:	5d                   	pop    %ebp
    1944:	c3                   	ret    

00001945 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1945:	55                   	push   %ebp
    1946:	89 e5                	mov    %esp,%ebp
    1948:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    194b:	8b 45 08             	mov    0x8(%ebp),%eax
    194e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1951:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1957:	83 ec 0c             	sub    $0xc,%esp
    195a:	ff 75 08             	pushl  0x8(%ebp)
    195d:	e8 ff ea ff ff       	call   461 <registWindow>
    1962:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1965:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    196c:	8b 45 08             	mov    0x8(%ebp),%eax
    196f:	8b 00                	mov    (%eax),%eax
    1971:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1974:	ff 75 f4             	pushl  -0xc(%ebp)
    1977:	ff 75 f0             	pushl  -0x10(%ebp)
    197a:	ff 75 ec             	pushl  -0x14(%ebp)
    197d:	ff 75 08             	pushl  0x8(%ebp)
    1980:	e8 80 fc ff ff       	call   1605 <APSendMessage>
    1985:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1988:	83 ec 0c             	sub    $0xc,%esp
    198b:	ff 75 08             	pushl  0x8(%ebp)
    198e:	e8 c6 ea ff ff       	call   459 <getMessage>
    1993:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1996:	8b 45 08             	mov    0x8(%ebp),%eax
    1999:	83 c0 74             	add    $0x74,%eax
    199c:	83 ec 08             	sub    $0x8,%esp
    199f:	50                   	push   %eax
    19a0:	ff 75 08             	pushl  0x8(%ebp)
    19a3:	e8 7d ff ff ff       	call   1925 <APPreJudge>
    19a8:	83 c4 10             	add    $0x10,%esp
    19ab:	84 c0                	test   %al,%al
    19ad:	74 1b                	je     19ca <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	ff 70 7c             	pushl  0x7c(%eax)
    19b5:	ff 70 78             	pushl  0x78(%eax)
    19b8:	ff 70 74             	pushl  0x74(%eax)
    19bb:	ff 75 08             	pushl  0x8(%ebp)
    19be:	8b 45 0c             	mov    0xc(%ebp),%eax
    19c1:	ff d0                	call   *%eax
    19c3:	83 c4 10             	add    $0x10,%esp
    19c6:	84 c0                	test   %al,%al
    19c8:	75 0c                	jne    19d6 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    19ca:	8b 45 08             	mov    0x8(%ebp),%eax
    19cd:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    19d4:	eb b2                	jmp    1988 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    19d6:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    19d7:	90                   	nop
    19d8:	c9                   	leave  
    19d9:	c3                   	ret    

000019da <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    19da:	55                   	push   %ebp
    19db:	89 e5                	mov    %esp,%ebp
    19dd:	57                   	push   %edi
    19de:	56                   	push   %esi
    19df:	53                   	push   %ebx
    19e0:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    19e3:	a1 44 68 00 00       	mov    0x6844,%eax
    19e8:	85 c0                	test   %eax,%eax
    19ea:	0f 85 2c 02 00 00    	jne    1c1c <APGridPaint+0x242>
    {
        iconReady = 1;
    19f0:	c7 05 44 68 00 00 01 	movl   $0x1,0x6844
    19f7:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    19fa:	8d 45 88             	lea    -0x78(%ebp),%eax
    19fd:	83 ec 08             	sub    $0x8,%esp
    1a00:	68 93 25 00 00       	push   $0x2593
    1a05:	50                   	push   %eax
    1a06:	e8 d3 ef ff ff       	call   9de <APLoadBitmap>
    1a0b:	83 c4 0c             	add    $0xc,%esp
    1a0e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a11:	a3 68 68 00 00       	mov    %eax,0x6868
    1a16:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a19:	a3 6c 68 00 00       	mov    %eax,0x686c
    1a1e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a21:	a3 70 68 00 00       	mov    %eax,0x6870
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a26:	83 ec 04             	sub    $0x4,%esp
    1a29:	ff 35 70 68 00 00    	pushl  0x6870
    1a2f:	ff 35 6c 68 00 00    	pushl  0x686c
    1a35:	ff 35 68 68 00 00    	pushl  0x6868
    1a3b:	e8 d8 f1 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1a40:	83 c4 10             	add    $0x10,%esp
    1a43:	a3 74 68 00 00       	mov    %eax,0x6874
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a48:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a4b:	83 ec 08             	sub    $0x8,%esp
    1a4e:	68 a1 25 00 00       	push   $0x25a1
    1a53:	50                   	push   %eax
    1a54:	e8 85 ef ff ff       	call   9de <APLoadBitmap>
    1a59:	83 c4 0c             	add    $0xc,%esp
    1a5c:	8b 45 88             	mov    -0x78(%ebp),%eax
    1a5f:	a3 a4 68 00 00       	mov    %eax,0x68a4
    1a64:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1a67:	a3 a8 68 00 00       	mov    %eax,0x68a8
    1a6c:	8b 45 90             	mov    -0x70(%ebp),%eax
    1a6f:	a3 ac 68 00 00       	mov    %eax,0x68ac
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a74:	83 ec 04             	sub    $0x4,%esp
    1a77:	ff 35 ac 68 00 00    	pushl  0x68ac
    1a7d:	ff 35 a8 68 00 00    	pushl  0x68a8
    1a83:	ff 35 a4 68 00 00    	pushl  0x68a4
    1a89:	e8 8a f1 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1a8e:	83 c4 10             	add    $0x10,%esp
    1a91:	a3 94 68 00 00       	mov    %eax,0x6894
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1a96:	8d 45 88             	lea    -0x78(%ebp),%eax
    1a99:	83 ec 08             	sub    $0x8,%esp
    1a9c:	68 b0 25 00 00       	push   $0x25b0
    1aa1:	50                   	push   %eax
    1aa2:	e8 37 ef ff ff       	call   9de <APLoadBitmap>
    1aa7:	83 c4 0c             	add    $0xc,%esp
    1aaa:	8b 45 88             	mov    -0x78(%ebp),%eax
    1aad:	a3 98 68 00 00       	mov    %eax,0x6898
    1ab2:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ab5:	a3 9c 68 00 00       	mov    %eax,0x689c
    1aba:	8b 45 90             	mov    -0x70(%ebp),%eax
    1abd:	a3 a0 68 00 00       	mov    %eax,0x68a0
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1ac2:	83 ec 04             	sub    $0x4,%esp
    1ac5:	ff 35 a0 68 00 00    	pushl  0x68a0
    1acb:	ff 35 9c 68 00 00    	pushl  0x689c
    1ad1:	ff 35 98 68 00 00    	pushl  0x6898
    1ad7:	e8 3c f1 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1adc:	83 c4 10             	add    $0x10,%esp
    1adf:	a3 48 68 00 00       	mov    %eax,0x6848
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1ae4:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ae7:	83 ec 08             	sub    $0x8,%esp
    1aea:	68 bf 25 00 00       	push   $0x25bf
    1aef:	50                   	push   %eax
    1af0:	e8 e9 ee ff ff       	call   9de <APLoadBitmap>
    1af5:	83 c4 0c             	add    $0xc,%esp
    1af8:	8b 45 88             	mov    -0x78(%ebp),%eax
    1afb:	a3 7c 68 00 00       	mov    %eax,0x687c
    1b00:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b03:	a3 80 68 00 00       	mov    %eax,0x6880
    1b08:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b0b:	a3 84 68 00 00       	mov    %eax,0x6884
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b10:	83 ec 04             	sub    $0x4,%esp
    1b13:	ff 35 84 68 00 00    	pushl  0x6884
    1b19:	ff 35 80 68 00 00    	pushl  0x6880
    1b1f:	ff 35 7c 68 00 00    	pushl  0x687c
    1b25:	e8 ee f0 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1b2a:	83 c4 10             	add    $0x10,%esp
    1b2d:	a3 b0 68 00 00       	mov    %eax,0x68b0
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b32:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b35:	83 ec 08             	sub    $0x8,%esp
    1b38:	68 cd 25 00 00       	push   $0x25cd
    1b3d:	50                   	push   %eax
    1b3e:	e8 9b ee ff ff       	call   9de <APLoadBitmap>
    1b43:	83 c4 0c             	add    $0xc,%esp
    1b46:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b49:	a3 58 68 00 00       	mov    %eax,0x6858
    1b4e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b51:	a3 5c 68 00 00       	mov    %eax,0x685c
    1b56:	8b 45 90             	mov    -0x70(%ebp),%eax
    1b59:	a3 60 68 00 00       	mov    %eax,0x6860
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b5e:	83 ec 04             	sub    $0x4,%esp
    1b61:	ff 35 60 68 00 00    	pushl  0x6860
    1b67:	ff 35 5c 68 00 00    	pushl  0x685c
    1b6d:	ff 35 58 68 00 00    	pushl  0x6858
    1b73:	e8 a0 f0 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1b78:	83 c4 10             	add    $0x10,%esp
    1b7b:	a3 78 68 00 00       	mov    %eax,0x6878
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1b80:	8d 45 88             	lea    -0x78(%ebp),%eax
    1b83:	83 ec 08             	sub    $0x8,%esp
    1b86:	68 dd 25 00 00       	push   $0x25dd
    1b8b:	50                   	push   %eax
    1b8c:	e8 4d ee ff ff       	call   9de <APLoadBitmap>
    1b91:	83 c4 0c             	add    $0xc,%esp
    1b94:	8b 45 88             	mov    -0x78(%ebp),%eax
    1b97:	a3 4c 68 00 00       	mov    %eax,0x684c
    1b9c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1b9f:	a3 50 68 00 00       	mov    %eax,0x6850
    1ba4:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ba7:	a3 54 68 00 00       	mov    %eax,0x6854
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1bac:	83 ec 04             	sub    $0x4,%esp
    1baf:	ff 35 54 68 00 00    	pushl  0x6854
    1bb5:	ff 35 50 68 00 00    	pushl  0x6850
    1bbb:	ff 35 4c 68 00 00    	pushl  0x684c
    1bc1:	e8 52 f0 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1bc6:	83 c4 10             	add    $0x10,%esp
    1bc9:	a3 64 68 00 00       	mov    %eax,0x6864
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1bce:	8d 45 88             	lea    -0x78(%ebp),%eax
    1bd1:	83 ec 08             	sub    $0x8,%esp
    1bd4:	68 ef 25 00 00       	push   $0x25ef
    1bd9:	50                   	push   %eax
    1bda:	e8 ff ed ff ff       	call   9de <APLoadBitmap>
    1bdf:	83 c4 0c             	add    $0xc,%esp
    1be2:	8b 45 88             	mov    -0x78(%ebp),%eax
    1be5:	a3 88 68 00 00       	mov    %eax,0x6888
    1bea:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1bed:	a3 8c 68 00 00       	mov    %eax,0x688c
    1bf2:	8b 45 90             	mov    -0x70(%ebp),%eax
    1bf5:	a3 90 68 00 00       	mov    %eax,0x6890
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1bfa:	83 ec 04             	sub    $0x4,%esp
    1bfd:	ff 35 90 68 00 00    	pushl  0x6890
    1c03:	ff 35 8c 68 00 00    	pushl  0x688c
    1c09:	ff 35 88 68 00 00    	pushl  0x6888
    1c0f:	e8 04 f0 ff ff       	call   c18 <APCreateCompatibleDCFromBitmap>
    1c14:	83 c4 10             	add    $0x10,%esp
    1c17:	a3 b4 68 00 00       	mov    %eax,0x68b4
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1f:	8b 40 08             	mov    0x8(%eax),%eax
    1c22:	85 c0                	test   %eax,%eax
    1c24:	75 17                	jne    1c3d <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c26:	83 ec 08             	sub    $0x8,%esp
    1c29:	68 00 26 00 00       	push   $0x2600
    1c2e:	6a 01                	push   $0x1
    1c30:	e8 23 e9 ff ff       	call   558 <printf>
    1c35:	83 c4 10             	add    $0x10,%esp
        return;
    1c38:	e9 07 05 00 00       	jmp    2144 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c40:	8b 40 10             	mov    0x10(%eax),%eax
    1c43:	85 c0                	test   %eax,%eax
    1c45:	7e 10                	jle    1c57 <APGridPaint+0x27d>
    1c47:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4a:	8b 50 14             	mov    0x14(%eax),%edx
    1c4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c50:	8b 40 10             	mov    0x10(%eax),%eax
    1c53:	39 c2                	cmp    %eax,%edx
    1c55:	7c 17                	jl     1c6e <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1c57:	83 ec 08             	sub    $0x8,%esp
    1c5a:	68 26 26 00 00       	push   $0x2626
    1c5f:	6a 01                	push   $0x1
    1c61:	e8 f2 e8 ff ff       	call   558 <printf>
    1c66:	83 c4 10             	add    $0x10,%esp
        return;
    1c69:	e9 d6 04 00 00       	jmp    2144 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c71:	8b 40 14             	mov    0x14(%eax),%eax
    1c74:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1c7a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1c7d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c80:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c83:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1c8a:	e9 96 03 00 00       	jmp    2025 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1c8f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1c96:	e9 7c 03 00 00       	jmp    2017 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1c9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c9e:	c1 e0 04             	shl    $0x4,%eax
    1ca1:	89 c2                	mov    %eax,%edx
    1ca3:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1ca6:	01 c2                	add    %eax,%edx
    1ca8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cab:	01 d0                	add    %edx,%eax
    1cad:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1cb0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb3:	8b 40 0c             	mov    0xc(%eax),%eax
    1cb6:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1cb9:	c1 e2 02             	shl    $0x2,%edx
    1cbc:	01 d0                	add    %edx,%eax
    1cbe:	8b 00                	mov    (%eax),%eax
    1cc0:	83 f8 07             	cmp    $0x7,%eax
    1cc3:	0f 87 49 03 00 00    	ja     2012 <APGridPaint+0x638>
    1cc9:	8b 04 85 3c 26 00 00 	mov    0x263c(,%eax,4),%eax
    1cd0:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cd2:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1cd5:	6a 0c                	push   $0xc
    1cd7:	6a 0c                	push   $0xc
    1cd9:	6a 0c                	push   $0xc
    1cdb:	50                   	push   %eax
    1cdc:	e8 df f8 ff ff       	call   15c0 <RGB>
    1ce1:	83 c4 0c             	add    $0xc,%esp
    1ce4:	8b 1d 74 68 00 00    	mov    0x6874,%ebx
    1cea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ced:	6b c8 32             	imul   $0x32,%eax,%ecx
    1cf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cf3:	6b c0 32             	imul   $0x32,%eax,%eax
    1cf6:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1cf9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfc:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cff:	83 ec 0c             	sub    $0xc,%esp
    1d02:	83 ec 04             	sub    $0x4,%esp
    1d05:	89 e0                	mov    %esp,%eax
    1d07:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d0b:	66 89 30             	mov    %si,(%eax)
    1d0e:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d12:	88 50 02             	mov    %dl,0x2(%eax)
    1d15:	6a 32                	push   $0x32
    1d17:	6a 32                	push   $0x32
    1d19:	6a 00                	push   $0x0
    1d1b:	6a 00                	push   $0x0
    1d1d:	53                   	push   %ebx
    1d1e:	51                   	push   %ecx
    1d1f:	ff 75 84             	pushl  -0x7c(%ebp)
    1d22:	57                   	push   %edi
    1d23:	e8 f4 f6 ff ff       	call   141c <APDcCopy>
    1d28:	83 c4 30             	add    $0x30,%esp
                    break;
    1d2b:	e9 e3 02 00 00       	jmp    2013 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d30:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d33:	6a 69                	push   $0x69
    1d35:	6a 69                	push   $0x69
    1d37:	6a 69                	push   $0x69
    1d39:	50                   	push   %eax
    1d3a:	e8 81 f8 ff ff       	call   15c0 <RGB>
    1d3f:	83 c4 0c             	add    $0xc,%esp
    1d42:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1d46:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1d4a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1d4e:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1d51:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d58:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d5b:	6a 69                	push   $0x69
    1d5d:	6a 69                	push   $0x69
    1d5f:	6a 69                	push   $0x69
    1d61:	50                   	push   %eax
    1d62:	e8 59 f8 ff ff       	call   15c0 <RGB>
    1d67:	83 c4 0c             	add    $0xc,%esp
    1d6a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1d6e:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1d72:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1d76:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d79:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7c:	8d 50 3c             	lea    0x3c(%eax),%edx
    1d7f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d82:	ff 75 ac             	pushl  -0x54(%ebp)
    1d85:	ff 75 a8             	pushl  -0x58(%ebp)
    1d88:	52                   	push   %edx
    1d89:	50                   	push   %eax
    1d8a:	e8 1e ef ff ff       	call   cad <APSetPen>
    1d8f:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d92:	8b 45 08             	mov    0x8(%ebp),%eax
    1d95:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1d98:	8d 55 88             	lea    -0x78(%ebp),%edx
    1d9b:	83 ec 04             	sub    $0x4,%esp
    1d9e:	83 ec 04             	sub    $0x4,%esp
    1da1:	89 e0                	mov    %esp,%eax
    1da3:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1da7:	66 89 08             	mov    %cx,(%eax)
    1daa:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1dae:	88 48 02             	mov    %cl,0x2(%eax)
    1db1:	53                   	push   %ebx
    1db2:	52                   	push   %edx
    1db3:	e8 2e ef ff ff       	call   ce6 <APSetBrush>
    1db8:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1dbb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dbe:	6b d0 32             	imul   $0x32,%eax,%edx
    1dc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dc4:	6b c0 32             	imul   $0x32,%eax,%eax
    1dc7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1dca:	83 c1 3c             	add    $0x3c,%ecx
    1dcd:	83 ec 0c             	sub    $0xc,%esp
    1dd0:	6a 32                	push   $0x32
    1dd2:	6a 32                	push   $0x32
    1dd4:	52                   	push   %edx
    1dd5:	50                   	push   %eax
    1dd6:	51                   	push   %ecx
    1dd7:	e8 34 f3 ff ff       	call   1110 <APDrawRect>
    1ddc:	83 c4 20             	add    $0x20,%esp
                    break;
    1ddf:	e9 2f 02 00 00       	jmp    2013 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1de4:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1de7:	6a 0c                	push   $0xc
    1de9:	6a 0c                	push   $0xc
    1deb:	6a 0c                	push   $0xc
    1ded:	50                   	push   %eax
    1dee:	e8 cd f7 ff ff       	call   15c0 <RGB>
    1df3:	83 c4 0c             	add    $0xc,%esp
    1df6:	8b 1d b4 68 00 00    	mov    0x68b4,%ebx
    1dfc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dff:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e02:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e05:	6b c0 32             	imul   $0x32,%eax,%eax
    1e08:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e11:	83 ec 0c             	sub    $0xc,%esp
    1e14:	83 ec 04             	sub    $0x4,%esp
    1e17:	89 e0                	mov    %esp,%eax
    1e19:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e1d:	66 89 30             	mov    %si,(%eax)
    1e20:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e24:	88 50 02             	mov    %dl,0x2(%eax)
    1e27:	6a 32                	push   $0x32
    1e29:	6a 32                	push   $0x32
    1e2b:	6a 00                	push   $0x0
    1e2d:	6a 00                	push   $0x0
    1e2f:	53                   	push   %ebx
    1e30:	51                   	push   %ecx
    1e31:	ff 75 84             	pushl  -0x7c(%ebp)
    1e34:	57                   	push   %edi
    1e35:	e8 e2 f5 ff ff       	call   141c <APDcCopy>
    1e3a:	83 c4 30             	add    $0x30,%esp
                    break;
    1e3d:	e9 d1 01 00 00       	jmp    2013 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e42:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e45:	6a 0c                	push   $0xc
    1e47:	6a 0c                	push   $0xc
    1e49:	6a 0c                	push   $0xc
    1e4b:	50                   	push   %eax
    1e4c:	e8 6f f7 ff ff       	call   15c0 <RGB>
    1e51:	83 c4 0c             	add    $0xc,%esp
    1e54:	8b 1d 94 68 00 00    	mov    0x6894,%ebx
    1e5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e5d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e60:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e63:	6b c0 32             	imul   $0x32,%eax,%eax
    1e66:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1e69:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6c:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e6f:	83 ec 0c             	sub    $0xc,%esp
    1e72:	83 ec 04             	sub    $0x4,%esp
    1e75:	89 e0                	mov    %esp,%eax
    1e77:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1e7b:	66 89 30             	mov    %si,(%eax)
    1e7e:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1e82:	88 50 02             	mov    %dl,0x2(%eax)
    1e85:	6a 32                	push   $0x32
    1e87:	6a 32                	push   $0x32
    1e89:	6a 00                	push   $0x0
    1e8b:	6a 00                	push   $0x0
    1e8d:	53                   	push   %ebx
    1e8e:	51                   	push   %ecx
    1e8f:	ff 75 84             	pushl  -0x7c(%ebp)
    1e92:	57                   	push   %edi
    1e93:	e8 84 f5 ff ff       	call   141c <APDcCopy>
    1e98:	83 c4 30             	add    $0x30,%esp
                    break;
    1e9b:	e9 73 01 00 00       	jmp    2013 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ea0:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ea3:	6a 0c                	push   $0xc
    1ea5:	6a 0c                	push   $0xc
    1ea7:	6a 0c                	push   $0xc
    1ea9:	50                   	push   %eax
    1eaa:	e8 11 f7 ff ff       	call   15c0 <RGB>
    1eaf:	83 c4 0c             	add    $0xc,%esp
    1eb2:	8b 1d 78 68 00 00    	mov    0x6878,%ebx
    1eb8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ebb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ebe:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ec1:	6b c0 32             	imul   $0x32,%eax,%eax
    1ec4:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ec7:	8b 45 08             	mov    0x8(%ebp),%eax
    1eca:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ecd:	83 ec 0c             	sub    $0xc,%esp
    1ed0:	83 ec 04             	sub    $0x4,%esp
    1ed3:	89 e0                	mov    %esp,%eax
    1ed5:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1ed9:	66 89 30             	mov    %si,(%eax)
    1edc:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ee0:	88 50 02             	mov    %dl,0x2(%eax)
    1ee3:	6a 32                	push   $0x32
    1ee5:	6a 32                	push   $0x32
    1ee7:	6a 00                	push   $0x0
    1ee9:	6a 00                	push   $0x0
    1eeb:	53                   	push   %ebx
    1eec:	51                   	push   %ecx
    1eed:	ff 75 84             	pushl  -0x7c(%ebp)
    1ef0:	57                   	push   %edi
    1ef1:	e8 26 f5 ff ff       	call   141c <APDcCopy>
    1ef6:	83 c4 30             	add    $0x30,%esp
                    break;
    1ef9:	e9 15 01 00 00       	jmp    2013 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1efe:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f01:	6a 0c                	push   $0xc
    1f03:	6a 0c                	push   $0xc
    1f05:	6a 0c                	push   $0xc
    1f07:	50                   	push   %eax
    1f08:	e8 b3 f6 ff ff       	call   15c0 <RGB>
    1f0d:	83 c4 0c             	add    $0xc,%esp
    1f10:	8b 1d b0 68 00 00    	mov    0x68b0,%ebx
    1f16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f19:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f1f:	6b c0 32             	imul   $0x32,%eax,%eax
    1f22:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f25:	8b 45 08             	mov    0x8(%ebp),%eax
    1f28:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f2b:	83 ec 0c             	sub    $0xc,%esp
    1f2e:	83 ec 04             	sub    $0x4,%esp
    1f31:	89 e0                	mov    %esp,%eax
    1f33:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f37:	66 89 30             	mov    %si,(%eax)
    1f3a:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f3e:	88 50 02             	mov    %dl,0x2(%eax)
    1f41:	6a 32                	push   $0x32
    1f43:	6a 32                	push   $0x32
    1f45:	6a 00                	push   $0x0
    1f47:	6a 00                	push   $0x0
    1f49:	53                   	push   %ebx
    1f4a:	51                   	push   %ecx
    1f4b:	ff 75 84             	pushl  -0x7c(%ebp)
    1f4e:	57                   	push   %edi
    1f4f:	e8 c8 f4 ff ff       	call   141c <APDcCopy>
    1f54:	83 c4 30             	add    $0x30,%esp
                    break;
    1f57:	e9 b7 00 00 00       	jmp    2013 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f5c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f5f:	6a 0c                	push   $0xc
    1f61:	6a 0c                	push   $0xc
    1f63:	6a 0c                	push   $0xc
    1f65:	50                   	push   %eax
    1f66:	e8 55 f6 ff ff       	call   15c0 <RGB>
    1f6b:	83 c4 0c             	add    $0xc,%esp
    1f6e:	8b 1d 48 68 00 00    	mov    0x6848,%ebx
    1f74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f77:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f7d:	6b c0 32             	imul   $0x32,%eax,%eax
    1f80:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f83:	8b 45 08             	mov    0x8(%ebp),%eax
    1f86:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f89:	83 ec 0c             	sub    $0xc,%esp
    1f8c:	83 ec 04             	sub    $0x4,%esp
    1f8f:	89 e0                	mov    %esp,%eax
    1f91:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1f95:	66 89 30             	mov    %si,(%eax)
    1f98:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1f9c:	88 50 02             	mov    %dl,0x2(%eax)
    1f9f:	6a 32                	push   $0x32
    1fa1:	6a 32                	push   $0x32
    1fa3:	6a 00                	push   $0x0
    1fa5:	6a 00                	push   $0x0
    1fa7:	53                   	push   %ebx
    1fa8:	51                   	push   %ecx
    1fa9:	ff 75 84             	pushl  -0x7c(%ebp)
    1fac:	57                   	push   %edi
    1fad:	e8 6a f4 ff ff       	call   141c <APDcCopy>
    1fb2:	83 c4 30             	add    $0x30,%esp
                    break;
    1fb5:	eb 5c                	jmp    2013 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fb7:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1fba:	6a 0c                	push   $0xc
    1fbc:	6a 0c                	push   $0xc
    1fbe:	6a 0c                	push   $0xc
    1fc0:	50                   	push   %eax
    1fc1:	e8 fa f5 ff ff       	call   15c0 <RGB>
    1fc6:	83 c4 0c             	add    $0xc,%esp
    1fc9:	8b 1d 64 68 00 00    	mov    0x6864,%ebx
    1fcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fd2:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fd5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fd8:	6b c0 32             	imul   $0x32,%eax,%eax
    1fdb:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1fde:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe1:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fe4:	83 ec 0c             	sub    $0xc,%esp
    1fe7:	83 ec 04             	sub    $0x4,%esp
    1fea:	89 e0                	mov    %esp,%eax
    1fec:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1ff0:	66 89 30             	mov    %si,(%eax)
    1ff3:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1ff7:	88 50 02             	mov    %dl,0x2(%eax)
    1ffa:	6a 32                	push   $0x32
    1ffc:	6a 32                	push   $0x32
    1ffe:	6a 00                	push   $0x0
    2000:	6a 00                	push   $0x0
    2002:	53                   	push   %ebx
    2003:	51                   	push   %ecx
    2004:	ff 75 84             	pushl  -0x7c(%ebp)
    2007:	57                   	push   %edi
    2008:	e8 0f f4 ff ff       	call   141c <APDcCopy>
    200d:	83 c4 30             	add    $0x30,%esp
                    break;
    2010:	eb 01                	jmp    2013 <APGridPaint+0x639>
                default: break;
    2012:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2013:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2017:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    201b:	0f 8e 7a fc ff ff    	jle    1c9b <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2021:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2025:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2029:	0f 8e 60 fc ff ff    	jle    1c8f <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    202f:	8d 45 88             	lea    -0x78(%ebp),%eax
    2032:	68 cd 00 00 00       	push   $0xcd
    2037:	6a 74                	push   $0x74
    2039:	6a 18                	push   $0x18
    203b:	50                   	push   %eax
    203c:	e8 7f f5 ff ff       	call   15c0 <RGB>
    2041:	83 c4 0c             	add    $0xc,%esp
    2044:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2048:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    204c:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2050:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2053:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    205a:	8d 45 88             	lea    -0x78(%ebp),%eax
    205d:	68 cd 00 00 00       	push   $0xcd
    2062:	6a 74                	push   $0x74
    2064:	6a 18                	push   $0x18
    2066:	50                   	push   %eax
    2067:	e8 54 f5 ff ff       	call   15c0 <RGB>
    206c:	83 c4 0c             	add    $0xc,%esp
    206f:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2073:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2077:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    207b:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    207e:	8b 45 08             	mov    0x8(%ebp),%eax
    2081:	8d 50 58             	lea    0x58(%eax),%edx
    2084:	8d 45 88             	lea    -0x78(%ebp),%eax
    2087:	ff 75 bc             	pushl  -0x44(%ebp)
    208a:	ff 75 b8             	pushl  -0x48(%ebp)
    208d:	52                   	push   %edx
    208e:	50                   	push   %eax
    208f:	e8 19 ec ff ff       	call   cad <APSetPen>
    2094:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2097:	8b 45 08             	mov    0x8(%ebp),%eax
    209a:	8d 58 58             	lea    0x58(%eax),%ebx
    209d:	8d 55 88             	lea    -0x78(%ebp),%edx
    20a0:	83 ec 04             	sub    $0x4,%esp
    20a3:	83 ec 04             	sub    $0x4,%esp
    20a6:	89 e0                	mov    %esp,%eax
    20a8:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    20ac:	66 89 08             	mov    %cx,(%eax)
    20af:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    20b3:	88 48 02             	mov    %cl,0x2(%eax)
    20b6:	53                   	push   %ebx
    20b7:	52                   	push   %edx
    20b8:	e8 29 ec ff ff       	call   ce6 <APSetBrush>
    20bd:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    20c0:	8b 45 08             	mov    0x8(%ebp),%eax
    20c3:	83 c0 58             	add    $0x58,%eax
    20c6:	83 ec 0c             	sub    $0xc,%esp
    20c9:	6a 32                	push   $0x32
    20cb:	68 20 03 00 00       	push   $0x320
    20d0:	6a 00                	push   $0x0
    20d2:	6a 00                	push   $0x0
    20d4:	50                   	push   %eax
    20d5:	e8 36 f0 ff ff       	call   1110 <APDrawRect>
    20da:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    20dd:	8d 45 88             	lea    -0x78(%ebp),%eax
    20e0:	6a 08                	push   $0x8
    20e2:	6a 08                	push   $0x8
    20e4:	6a 08                	push   $0x8
    20e6:	50                   	push   %eax
    20e7:	e8 d4 f4 ff ff       	call   15c0 <RGB>
    20ec:	83 c4 0c             	add    $0xc,%esp
    20ef:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    20f3:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    20f7:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    20fb:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    20fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2101:	8d 58 58             	lea    0x58(%eax),%ebx
    2104:	8d 55 88             	lea    -0x78(%ebp),%edx
    2107:	83 ec 04             	sub    $0x4,%esp
    210a:	83 ec 04             	sub    $0x4,%esp
    210d:	89 e0                	mov    %esp,%eax
    210f:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2113:	66 89 08             	mov    %cx,(%eax)
    2116:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    211a:	88 48 02             	mov    %cl,0x2(%eax)
    211d:	53                   	push   %ebx
    211e:	52                   	push   %edx
    211f:	e8 04 ec ff ff       	call   d28 <APSetFont>
    2124:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2127:	8b 45 08             	mov    0x8(%ebp),%eax
    212a:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2130:	8b 45 08             	mov    0x8(%ebp),%eax
    2133:	83 c0 58             	add    $0x58,%eax
    2136:	6a 14                	push   $0x14
    2138:	6a 14                	push   $0x14
    213a:	52                   	push   %edx
    213b:	50                   	push   %eax
    213c:	e8 d4 f1 ff ff       	call   1315 <APDrawText>
    2141:	83 c4 10             	add    $0x10,%esp
}
    2144:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2147:	5b                   	pop    %ebx
    2148:	5e                   	pop    %esi
    2149:	5f                   	pop    %edi
    214a:	5d                   	pop    %ebp
    214b:	c3                   	ret    

0000214c <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    214c:	55                   	push   %ebp
    214d:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    214f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2153:	7e 08                	jle    215d <random+0x11>
{
rand_num = seed;
    2155:	8b 45 08             	mov    0x8(%ebp),%eax
    2158:	a3 20 68 00 00       	mov    %eax,0x6820
}
rand_num *= 3;
    215d:	8b 15 20 68 00 00    	mov    0x6820,%edx
    2163:	89 d0                	mov    %edx,%eax
    2165:	01 c0                	add    %eax,%eax
    2167:	01 d0                	add    %edx,%eax
    2169:	a3 20 68 00 00       	mov    %eax,0x6820
if (rand_num < 0)
    216e:	a1 20 68 00 00       	mov    0x6820,%eax
    2173:	85 c0                	test   %eax,%eax
    2175:	79 0c                	jns    2183 <random+0x37>
{
rand_num *= (-1);
    2177:	a1 20 68 00 00       	mov    0x6820,%eax
    217c:	f7 d8                	neg    %eax
    217e:	a3 20 68 00 00       	mov    %eax,0x6820
}
return rand_num % 997;
    2183:	8b 0d 20 68 00 00    	mov    0x6820,%ecx
    2189:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    218e:	89 c8                	mov    %ecx,%eax
    2190:	f7 ea                	imul   %edx
    2192:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2195:	c1 f8 09             	sar    $0x9,%eax
    2198:	89 c2                	mov    %eax,%edx
    219a:	89 c8                	mov    %ecx,%eax
    219c:	c1 f8 1f             	sar    $0x1f,%eax
    219f:	29 c2                	sub    %eax,%edx
    21a1:	89 d0                	mov    %edx,%eax
    21a3:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    21a9:	29 c1                	sub    %eax,%ecx
    21ab:	89 c8                	mov    %ecx,%eax
}
    21ad:	5d                   	pop    %ebp
    21ae:	c3                   	ret    

000021af <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    21af:	55                   	push   %ebp
    21b0:	89 e5                	mov    %esp,%ebp
    21b2:	53                   	push   %ebx
    21b3:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    21b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    21bd:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    21c1:	74 17                	je     21da <sprintint+0x2b>
    21c3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    21c7:	79 11                	jns    21da <sprintint+0x2b>
        neg = 1;
    21c9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    21d0:	8b 45 10             	mov    0x10(%ebp),%eax
    21d3:	f7 d8                	neg    %eax
    21d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21d8:	eb 06                	jmp    21e0 <sprintint+0x31>
    } else {
        x = xx;
    21da:	8b 45 10             	mov    0x10(%ebp),%eax
    21dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    21e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    21e7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    21ea:	8d 41 01             	lea    0x1(%ecx),%eax
    21ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
    21f0:	8b 5d 14             	mov    0x14(%ebp),%ebx
    21f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21f6:	ba 00 00 00 00       	mov    $0x0,%edx
    21fb:	f7 f3                	div    %ebx
    21fd:	89 d0                	mov    %edx,%eax
    21ff:	0f b6 80 24 68 00 00 	movzbl 0x6824(%eax),%eax
    2206:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    220a:	8b 5d 14             	mov    0x14(%ebp),%ebx
    220d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2210:	ba 00 00 00 00       	mov    $0x0,%edx
    2215:	f7 f3                	div    %ebx
    2217:	89 45 f0             	mov    %eax,-0x10(%ebp)
    221a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    221e:	75 c7                	jne    21e7 <sprintint+0x38>
    if(neg)
    2220:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2224:	74 0e                	je     2234 <sprintint+0x85>
        buf[i++] = '-';
    2226:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2229:	8d 50 01             	lea    0x1(%eax),%edx
    222c:	89 55 f8             	mov    %edx,-0x8(%ebp)
    222f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2234:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2237:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    223a:	eb 1b                	jmp    2257 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    223c:	8b 45 0c             	mov    0xc(%ebp),%eax
    223f:	8b 00                	mov    (%eax),%eax
    2241:	8d 48 01             	lea    0x1(%eax),%ecx
    2244:	8b 55 0c             	mov    0xc(%ebp),%edx
    2247:	89 0a                	mov    %ecx,(%edx)
    2249:	89 c2                	mov    %eax,%edx
    224b:	8b 45 08             	mov    0x8(%ebp),%eax
    224e:	01 d0                	add    %edx,%eax
    2250:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2253:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2257:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    225b:	7f df                	jg     223c <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    225d:	eb 21                	jmp    2280 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    225f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2262:	8b 00                	mov    (%eax),%eax
    2264:	8d 48 01             	lea    0x1(%eax),%ecx
    2267:	8b 55 0c             	mov    0xc(%ebp),%edx
    226a:	89 0a                	mov    %ecx,(%edx)
    226c:	89 c2                	mov    %eax,%edx
    226e:	8b 45 08             	mov    0x8(%ebp),%eax
    2271:	01 c2                	add    %eax,%edx
    2273:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2276:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2279:	01 c8                	add    %ecx,%eax
    227b:	0f b6 00             	movzbl (%eax),%eax
    227e:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2280:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2284:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2288:	79 d5                	jns    225f <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    228a:	90                   	nop
    228b:	83 c4 20             	add    $0x20,%esp
    228e:	5b                   	pop    %ebx
    228f:	5d                   	pop    %ebp
    2290:	c3                   	ret    

00002291 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2291:	55                   	push   %ebp
    2292:	89 e5                	mov    %esp,%ebp
    2294:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2297:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    229e:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    22a5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    22ac:	8d 45 0c             	lea    0xc(%ebp),%eax
    22af:	83 c0 04             	add    $0x4,%eax
    22b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    22b5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    22bc:	e9 d9 01 00 00       	jmp    249a <sprintf+0x209>
        c = fmt[i] & 0xff;
    22c1:	8b 55 0c             	mov    0xc(%ebp),%edx
    22c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22c7:	01 d0                	add    %edx,%eax
    22c9:	0f b6 00             	movzbl (%eax),%eax
    22cc:	0f be c0             	movsbl %al,%eax
    22cf:	25 ff 00 00 00       	and    $0xff,%eax
    22d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    22d7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    22db:	75 2c                	jne    2309 <sprintf+0x78>
            if(c == '%'){
    22dd:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    22e1:	75 0c                	jne    22ef <sprintf+0x5e>
                state = '%';
    22e3:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    22ea:	e9 a7 01 00 00       	jmp    2496 <sprintf+0x205>
            } else {
                dst[j++] = c;
    22ef:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22f2:	8d 50 01             	lea    0x1(%eax),%edx
    22f5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22f8:	89 c2                	mov    %eax,%edx
    22fa:	8b 45 08             	mov    0x8(%ebp),%eax
    22fd:	01 d0                	add    %edx,%eax
    22ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2302:	88 10                	mov    %dl,(%eax)
    2304:	e9 8d 01 00 00       	jmp    2496 <sprintf+0x205>
            }
        } else if(state == '%'){
    2309:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    230d:	0f 85 83 01 00 00    	jne    2496 <sprintf+0x205>
            if(c == 'd'){
    2313:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2317:	75 4c                	jne    2365 <sprintf+0xd4>
                buf[bi] = '\0';
    2319:	8d 55 ce             	lea    -0x32(%ebp),%edx
    231c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    231f:	01 d0                	add    %edx,%eax
    2321:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2324:	83 ec 0c             	sub    $0xc,%esp
    2327:	8d 45 ce             	lea    -0x32(%ebp),%eax
    232a:	50                   	push   %eax
    232b:	e8 e7 df ff ff       	call   317 <atoi>
    2330:	83 c4 10             	add    $0x10,%esp
    2333:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2336:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    233d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2340:	8b 00                	mov    (%eax),%eax
    2342:	83 ec 08             	sub    $0x8,%esp
    2345:	ff 75 d8             	pushl  -0x28(%ebp)
    2348:	6a 01                	push   $0x1
    234a:	6a 0a                	push   $0xa
    234c:	50                   	push   %eax
    234d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2350:	50                   	push   %eax
    2351:	ff 75 08             	pushl  0x8(%ebp)
    2354:	e8 56 fe ff ff       	call   21af <sprintint>
    2359:	83 c4 20             	add    $0x20,%esp
                ap++;
    235c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2360:	e9 2a 01 00 00       	jmp    248f <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2365:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2369:	74 06                	je     2371 <sprintf+0xe0>
    236b:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    236f:	75 4c                	jne    23bd <sprintf+0x12c>
                buf[bi] = '\0';
    2371:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2374:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2377:	01 d0                	add    %edx,%eax
    2379:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    237c:	83 ec 0c             	sub    $0xc,%esp
    237f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2382:	50                   	push   %eax
    2383:	e8 8f df ff ff       	call   317 <atoi>
    2388:	83 c4 10             	add    $0x10,%esp
    238b:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    238e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2395:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2398:	8b 00                	mov    (%eax),%eax
    239a:	83 ec 08             	sub    $0x8,%esp
    239d:	ff 75 dc             	pushl  -0x24(%ebp)
    23a0:	6a 00                	push   $0x0
    23a2:	6a 10                	push   $0x10
    23a4:	50                   	push   %eax
    23a5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23a8:	50                   	push   %eax
    23a9:	ff 75 08             	pushl  0x8(%ebp)
    23ac:	e8 fe fd ff ff       	call   21af <sprintint>
    23b1:	83 c4 20             	add    $0x20,%esp
                ap++;
    23b4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    23b8:	e9 d2 00 00 00       	jmp    248f <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    23bd:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    23c1:	75 46                	jne    2409 <sprintf+0x178>
                s = (char*)*ap;
    23c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23c6:	8b 00                	mov    (%eax),%eax
    23c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    23cb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    23cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23d3:	75 25                	jne    23fa <sprintf+0x169>
                    s = "(null)";
    23d5:	c7 45 f4 5c 26 00 00 	movl   $0x265c,-0xc(%ebp)
                while(*s != 0){
    23dc:	eb 1c                	jmp    23fa <sprintf+0x169>
                    dst[j++] = *s;
    23de:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23e1:	8d 50 01             	lea    0x1(%eax),%edx
    23e4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23e7:	89 c2                	mov    %eax,%edx
    23e9:	8b 45 08             	mov    0x8(%ebp),%eax
    23ec:	01 c2                	add    %eax,%edx
    23ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23f1:	0f b6 00             	movzbl (%eax),%eax
    23f4:	88 02                	mov    %al,(%edx)
                    s++;
    23f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    23fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    23fd:	0f b6 00             	movzbl (%eax),%eax
    2400:	84 c0                	test   %al,%al
    2402:	75 da                	jne    23de <sprintf+0x14d>
    2404:	e9 86 00 00 00       	jmp    248f <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2409:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    240d:	75 1d                	jne    242c <sprintf+0x19b>
                dst[j++] = *ap;
    240f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2412:	8d 50 01             	lea    0x1(%eax),%edx
    2415:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2418:	89 c2                	mov    %eax,%edx
    241a:	8b 45 08             	mov    0x8(%ebp),%eax
    241d:	01 c2                	add    %eax,%edx
    241f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2422:	8b 00                	mov    (%eax),%eax
    2424:	88 02                	mov    %al,(%edx)
                ap++;
    2426:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    242a:	eb 63                	jmp    248f <sprintf+0x1fe>
            } else if(c == '%'){
    242c:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2430:	75 17                	jne    2449 <sprintf+0x1b8>
                dst[j++] = c;
    2432:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2435:	8d 50 01             	lea    0x1(%eax),%edx
    2438:	89 55 c8             	mov    %edx,-0x38(%ebp)
    243b:	89 c2                	mov    %eax,%edx
    243d:	8b 45 08             	mov    0x8(%ebp),%eax
    2440:	01 d0                	add    %edx,%eax
    2442:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2445:	88 10                	mov    %dl,(%eax)
    2447:	eb 46                	jmp    248f <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2449:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    244d:	7e 18                	jle    2467 <sprintf+0x1d6>
    244f:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2453:	7f 12                	jg     2467 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2455:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2458:	8d 50 01             	lea    0x1(%eax),%edx
    245b:	89 55 f0             	mov    %edx,-0x10(%ebp)
    245e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2461:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2465:	eb 2f                	jmp    2496 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2467:	8b 45 c8             	mov    -0x38(%ebp),%eax
    246a:	8d 50 01             	lea    0x1(%eax),%edx
    246d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2470:	89 c2                	mov    %eax,%edx
    2472:	8b 45 08             	mov    0x8(%ebp),%eax
    2475:	01 d0                	add    %edx,%eax
    2477:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    247a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    247d:	8d 50 01             	lea    0x1(%eax),%edx
    2480:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2483:	89 c2                	mov    %eax,%edx
    2485:	8b 45 08             	mov    0x8(%ebp),%eax
    2488:	01 d0                	add    %edx,%eax
    248a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    248d:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    248f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2496:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    249a:	8b 55 0c             	mov    0xc(%ebp),%edx
    249d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24a0:	01 d0                	add    %edx,%eax
    24a2:	0f b6 00             	movzbl (%eax),%eax
    24a5:	84 c0                	test   %al,%al
    24a7:	0f 85 14 fe ff ff    	jne    22c1 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    24ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24b0:	8d 50 01             	lea    0x1(%eax),%edx
    24b3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24b6:	89 c2                	mov    %eax,%edx
    24b8:	8b 45 08             	mov    0x8(%ebp),%eax
    24bb:	01 d0                	add    %edx,%eax
    24bd:	c6 00 00             	movb   $0x0,(%eax)
}
    24c0:	90                   	nop
    24c1:	c9                   	leave  
    24c2:	c3                   	ret    
