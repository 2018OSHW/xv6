
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
      2b:	68 0c 23 00 00       	push   $0x230c
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
      78:	68 1f 23 00 00       	push   $0x231f
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
      ea:	68 29 23 00 00       	push   $0x2329
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
     4e4:	0f b6 80 00 2a 00 00 	movzbl 0x2a00(%eax),%eax
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
     622:	c7 45 f4 2f 23 00 00 	movl   $0x232f,-0xc(%ebp)
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
     6e8:	a1 34 2a 00 00       	mov    0x2a34,%eax
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
     7b3:	a3 34 2a 00 00       	mov    %eax,0x2a34
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
     814:	a1 34 2a 00 00       	mov    0x2a34,%eax
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
     830:	a1 34 2a 00 00       	mov    0x2a34,%eax
     835:	89 45 f0             	mov    %eax,-0x10(%ebp)
     838:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     83c:	75 23                	jne    861 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     83e:	c7 45 f0 2c 2a 00 00 	movl   $0x2a2c,-0x10(%ebp)
     845:	8b 45 f0             	mov    -0x10(%ebp),%eax
     848:	a3 34 2a 00 00       	mov    %eax,0x2a34
     84d:	a1 34 2a 00 00       	mov    0x2a34,%eax
     852:	a3 2c 2a 00 00       	mov    %eax,0x2a2c
    base.s.size = 0;
     857:	c7 05 30 2a 00 00 00 	movl   $0x0,0x2a30
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
     8b4:	a3 34 2a 00 00       	mov    %eax,0x2a34
      return (void*)(p + 1);
     8b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bc:	83 c0 08             	add    $0x8,%eax
     8bf:	eb 3b                	jmp    8fc <malloc+0xe1>
    }
    if(p == freep)
     8c1:	a1 34 2a 00 00       	mov    0x2a34,%eax
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
     a07:	68 36 23 00 00       	push   $0x2336
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

000012c3 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    12c3:	55                   	push   %ebp
    12c4:	89 e5                	mov    %esp,%ebp
}
    12c6:	90                   	nop
    12c7:	5d                   	pop    %ebp
    12c8:	c3                   	ret    

000012c9 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    12c9:	55                   	push   %ebp
    12ca:	89 e5                	mov    %esp,%ebp
    12cc:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    12cf:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    12d3:	0f 88 8e 01 00 00    	js     1467 <APDcCopy+0x19e>
    12d9:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    12dd:	0f 88 84 01 00 00    	js     1467 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12e3:	8b 55 0c             	mov    0xc(%ebp),%edx
    12e6:	8b 45 20             	mov    0x20(%ebp),%eax
    12e9:	01 d0                	add    %edx,%eax
    12eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12ee:	8b 55 10             	mov    0x10(%ebp),%edx
    12f1:	8b 45 24             	mov    0x24(%ebp),%eax
    12f4:	01 d0                	add    %edx,%eax
    12f6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12f9:	8b 55 18             	mov    0x18(%ebp),%edx
    12fc:	8b 45 20             	mov    0x20(%ebp),%eax
    12ff:	01 d0                	add    %edx,%eax
    1301:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1304:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1307:	8b 45 24             	mov    0x24(%ebp),%eax
    130a:	01 d0                	add    %edx,%eax
    130c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    130f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1313:	0f 88 51 01 00 00    	js     146a <APDcCopy+0x1a1>
    1319:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    131d:	0f 88 47 01 00 00    	js     146a <APDcCopy+0x1a1>
    1323:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1327:	0f 88 3d 01 00 00    	js     146a <APDcCopy+0x1a1>
    132d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1331:	0f 88 33 01 00 00    	js     146a <APDcCopy+0x1a1>
    1337:	8b 45 14             	mov    0x14(%ebp),%eax
    133a:	8b 00                	mov    (%eax),%eax
    133c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    133f:	0f 8c 25 01 00 00    	jl     146a <APDcCopy+0x1a1>
    1345:	8b 45 14             	mov    0x14(%ebp),%eax
    1348:	8b 40 04             	mov    0x4(%eax),%eax
    134b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    134e:	0f 8c 16 01 00 00    	jl     146a <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1354:	8b 45 08             	mov    0x8(%ebp),%eax
    1357:	8b 00                	mov    (%eax),%eax
    1359:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    135c:	7f 0b                	jg     1369 <APDcCopy+0xa0>
    135e:	8b 45 08             	mov    0x8(%ebp),%eax
    1361:	8b 00                	mov    (%eax),%eax
    1363:	83 e8 01             	sub    $0x1,%eax
    1366:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1369:	8b 45 08             	mov    0x8(%ebp),%eax
    136c:	8b 40 04             	mov    0x4(%eax),%eax
    136f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1372:	7f 0c                	jg     1380 <APDcCopy+0xb7>
    1374:	8b 45 08             	mov    0x8(%ebp),%eax
    1377:	8b 40 04             	mov    0x4(%eax),%eax
    137a:	83 e8 01             	sub    $0x1,%eax
    137d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1380:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1387:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    138e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1395:	e9 bc 00 00 00       	jmp    1456 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    139a:	8b 45 08             	mov    0x8(%ebp),%eax
    139d:	8b 00                	mov    (%eax),%eax
    139f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13a2:	8b 55 10             	mov    0x10(%ebp),%edx
    13a5:	01 ca                	add    %ecx,%edx
    13a7:	0f af d0             	imul   %eax,%edx
    13aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ad:	01 d0                	add    %edx,%eax
    13af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13b2:	8b 45 14             	mov    0x14(%ebp),%eax
    13b5:	8b 00                	mov    (%eax),%eax
    13b7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13ba:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13bd:	01 ca                	add    %ecx,%edx
    13bf:	0f af d0             	imul   %eax,%edx
    13c2:	8b 45 18             	mov    0x18(%ebp),%eax
    13c5:	01 d0                	add    %edx,%eax
    13c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    13ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13d1:	eb 74                	jmp    1447 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    13d3:	8b 45 14             	mov    0x14(%ebp),%eax
    13d6:	8b 50 18             	mov    0x18(%eax),%edx
    13d9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13df:	01 c8                	add    %ecx,%eax
    13e1:	89 c1                	mov    %eax,%ecx
    13e3:	89 c8                	mov    %ecx,%eax
    13e5:	01 c0                	add    %eax,%eax
    13e7:	01 c8                	add    %ecx,%eax
    13e9:	01 d0                	add    %edx,%eax
    13eb:	0f b7 10             	movzwl (%eax),%edx
    13ee:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13f2:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13f6:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13f9:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13fd:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1401:	38 c2                	cmp    %al,%dl
    1403:	75 18                	jne    141d <APDcCopy+0x154>
    1405:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1409:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    140d:	38 c2                	cmp    %al,%dl
    140f:	75 0c                	jne    141d <APDcCopy+0x154>
    1411:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1415:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1419:	38 c2                	cmp    %al,%dl
    141b:	74 26                	je     1443 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    141d:	8b 45 08             	mov    0x8(%ebp),%eax
    1420:	8b 50 18             	mov    0x18(%eax),%edx
    1423:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1426:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1429:	01 c8                	add    %ecx,%eax
    142b:	89 c1                	mov    %eax,%ecx
    142d:	89 c8                	mov    %ecx,%eax
    142f:	01 c0                	add    %eax,%eax
    1431:	01 c8                	add    %ecx,%eax
    1433:	01 d0                	add    %edx,%eax
    1435:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1439:	66 89 10             	mov    %dx,(%eax)
    143c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1440:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1443:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1447:	8b 45 fc             	mov    -0x4(%ebp),%eax
    144a:	2b 45 0c             	sub    0xc(%ebp),%eax
    144d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1450:	7d 81                	jge    13d3 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1452:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1456:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1459:	2b 45 10             	sub    0x10(%ebp),%eax
    145c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    145f:	0f 8d 35 ff ff ff    	jge    139a <APDcCopy+0xd1>
    1465:	eb 04                	jmp    146b <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1467:	90                   	nop
    1468:	eb 01                	jmp    146b <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    146a:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    146b:	c9                   	leave  
    146c:	c3                   	ret    

0000146d <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    146d:	55                   	push   %ebp
    146e:	89 e5                	mov    %esp,%ebp
    1470:	83 ec 1c             	sub    $0x1c,%esp
    1473:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1476:	8b 55 10             	mov    0x10(%ebp),%edx
    1479:	8b 45 14             	mov    0x14(%ebp),%eax
    147c:	88 4d ec             	mov    %cl,-0x14(%ebp)
    147f:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1482:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1485:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1489:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    148c:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1490:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1493:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1497:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    149a:	8b 45 08             	mov    0x8(%ebp),%eax
    149d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14a1:	66 89 10             	mov    %dx,(%eax)
    14a4:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14a8:	88 50 02             	mov    %dl,0x2(%eax)
}
    14ab:	8b 45 08             	mov    0x8(%ebp),%eax
    14ae:	c9                   	leave  
    14af:	c2 04 00             	ret    $0x4

000014b2 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14b2:	55                   	push   %ebp
    14b3:	89 e5                	mov    %esp,%ebp
    14b5:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14b8:	8b 45 08             	mov    0x8(%ebp),%eax
    14bb:	8b 00                	mov    (%eax),%eax
    14bd:	83 ec 08             	sub    $0x8,%esp
    14c0:	8d 55 0c             	lea    0xc(%ebp),%edx
    14c3:	52                   	push   %edx
    14c4:	50                   	push   %eax
    14c5:	e8 87 ef ff ff       	call   451 <sendMessage>
    14ca:	83 c4 10             	add    $0x10,%esp
}
    14cd:	90                   	nop
    14ce:	c9                   	leave  
    14cf:	c3                   	ret    

000014d0 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    14d0:	55                   	push   %ebp
    14d1:	89 e5                	mov    %esp,%ebp
    14d3:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    14d6:	83 ec 0c             	sub    $0xc,%esp
    14d9:	68 98 00 00 00       	push   $0x98
    14de:	e8 38 f3 ff ff       	call   81b <malloc>
    14e3:	83 c4 10             	add    $0x10,%esp
    14e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14ed:	75 15                	jne    1504 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14ef:	83 ec 04             	sub    $0x4,%esp
    14f2:	ff 75 08             	pushl  0x8(%ebp)
    14f5:	68 48 23 00 00       	push   $0x2348
    14fa:	6a 01                	push   $0x1
    14fc:	e8 47 f0 ff ff       	call   548 <printf>
    1501:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1504:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1507:	05 84 00 00 00       	add    $0x84,%eax
    150c:	83 ec 08             	sub    $0x8,%esp
    150f:	ff 75 08             	pushl  0x8(%ebp)
    1512:	50                   	push   %eax
    1513:	e8 60 ec ff ff       	call   178 <strcpy>
    1518:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    151b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151e:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1525:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1528:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1532:	8b 40 3c             	mov    0x3c(%eax),%eax
    1535:	89 c2                	mov    %eax,%edx
    1537:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153a:	8b 40 40             	mov    0x40(%eax),%eax
    153d:	0f af d0             	imul   %eax,%edx
    1540:	89 d0                	mov    %edx,%eax
    1542:	01 c0                	add    %eax,%eax
    1544:	01 d0                	add    %edx,%eax
    1546:	83 ec 0c             	sub    $0xc,%esp
    1549:	50                   	push   %eax
    154a:	e8 cc f2 ff ff       	call   81b <malloc>
    154f:	83 c4 10             	add    $0x10,%esp
    1552:	89 c2                	mov    %eax,%edx
    1554:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1557:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    155a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155d:	8b 40 54             	mov    0x54(%eax),%eax
    1560:	85 c0                	test   %eax,%eax
    1562:	75 15                	jne    1579 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1564:	83 ec 04             	sub    $0x4,%esp
    1567:	ff 75 08             	pushl  0x8(%ebp)
    156a:	68 68 23 00 00       	push   $0x2368
    156f:	6a 01                	push   $0x1
    1571:	e8 d2 ef ff ff       	call   548 <printf>
    1576:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1579:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157c:	8b 40 3c             	mov    0x3c(%eax),%eax
    157f:	89 c2                	mov    %eax,%edx
    1581:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1584:	8b 40 40             	mov    0x40(%eax),%eax
    1587:	0f af d0             	imul   %eax,%edx
    158a:	89 d0                	mov    %edx,%eax
    158c:	01 c0                	add    %eax,%eax
    158e:	01 c2                	add    %eax,%edx
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	8b 40 54             	mov    0x54(%eax),%eax
    1596:	83 ec 04             	sub    $0x4,%esp
    1599:	52                   	push   %edx
    159a:	68 ff ff ff 00       	push   $0xffffff
    159f:	50                   	push   %eax
    15a0:	e8 69 ec ff ff       	call   20e <memset>
    15a5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    15b2:	e8 72 ee ff ff       	call   429 <getpid>
    15b7:	89 c2                	mov    %eax,%edx
    15b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bc:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c2:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    15d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d6:	8b 40 58             	mov    0x58(%eax),%eax
    15d9:	89 c2                	mov    %eax,%edx
    15db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15de:	8b 40 5c             	mov    0x5c(%eax),%eax
    15e1:	0f af d0             	imul   %eax,%edx
    15e4:	89 d0                	mov    %edx,%eax
    15e6:	01 c0                	add    %eax,%eax
    15e8:	01 d0                	add    %edx,%eax
    15ea:	83 ec 0c             	sub    $0xc,%esp
    15ed:	50                   	push   %eax
    15ee:	e8 28 f2 ff ff       	call   81b <malloc>
    15f3:	83 c4 10             	add    $0x10,%esp
    15f6:	89 c2                	mov    %eax,%edx
    15f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fb:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    15fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1601:	8b 40 70             	mov    0x70(%eax),%eax
    1604:	85 c0                	test   %eax,%eax
    1606:	75 15                	jne    161d <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1608:	83 ec 04             	sub    $0x4,%esp
    160b:	ff 75 08             	pushl  0x8(%ebp)
    160e:	68 8c 23 00 00       	push   $0x238c
    1613:	6a 01                	push   $0x1
    1615:	e8 2e ef ff ff       	call   548 <printf>
    161a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	8b 40 3c             	mov    0x3c(%eax),%eax
    1623:	89 c2                	mov    %eax,%edx
    1625:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1628:	8b 40 40             	mov    0x40(%eax),%eax
    162b:	0f af d0             	imul   %eax,%edx
    162e:	89 d0                	mov    %edx,%eax
    1630:	01 c0                	add    %eax,%eax
    1632:	01 c2                	add    %eax,%edx
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	8b 40 54             	mov    0x54(%eax),%eax
    163a:	83 ec 04             	sub    $0x4,%esp
    163d:	52                   	push   %edx
    163e:	68 ff 00 00 00       	push   $0xff
    1643:	50                   	push   %eax
    1644:	e8 c5 eb ff ff       	call   20e <memset>
    1649:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    164c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1652:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1655:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1659:	74 49                	je     16a4 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    165b:	8b 45 10             	mov    0x10(%ebp),%eax
    165e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1664:	83 ec 0c             	sub    $0xc,%esp
    1667:	50                   	push   %eax
    1668:	e8 ae f1 ff ff       	call   81b <malloc>
    166d:	83 c4 10             	add    $0x10,%esp
    1670:	89 c2                	mov    %eax,%edx
    1672:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1675:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1678:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167b:	8b 55 10             	mov    0x10(%ebp),%edx
    167e:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1681:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1684:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    168b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    168e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1695:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1698:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    169f:	e9 8d 00 00 00       	jmp    1731 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    16a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a7:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    16ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b1:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16bb:	8b 40 20             	mov    0x20(%eax),%eax
    16be:	89 c2                	mov    %eax,%edx
    16c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16c3:	8b 40 24             	mov    0x24(%eax),%eax
    16c6:	0f af d0             	imul   %eax,%edx
    16c9:	89 d0                	mov    %edx,%eax
    16cb:	01 c0                	add    %eax,%eax
    16cd:	01 d0                	add    %edx,%eax
    16cf:	83 ec 0c             	sub    $0xc,%esp
    16d2:	50                   	push   %eax
    16d3:	e8 43 f1 ff ff       	call   81b <malloc>
    16d8:	83 c4 10             	add    $0x10,%esp
    16db:	89 c2                	mov    %eax,%edx
    16dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e0:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    16e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e6:	8b 40 38             	mov    0x38(%eax),%eax
    16e9:	85 c0                	test   %eax,%eax
    16eb:	75 15                	jne    1702 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16ed:	83 ec 04             	sub    $0x4,%esp
    16f0:	ff 75 08             	pushl  0x8(%ebp)
    16f3:	68 b4 23 00 00       	push   $0x23b4
    16f8:	6a 01                	push   $0x1
    16fa:	e8 49 ee ff ff       	call   548 <printf>
    16ff:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1702:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1705:	8b 40 20             	mov    0x20(%eax),%eax
    1708:	89 c2                	mov    %eax,%edx
    170a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170d:	8b 40 24             	mov    0x24(%eax),%eax
    1710:	0f af d0             	imul   %eax,%edx
    1713:	89 d0                	mov    %edx,%eax
    1715:	01 c0                	add    %eax,%eax
    1717:	01 c2                	add    %eax,%edx
    1719:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171c:	8b 40 38             	mov    0x38(%eax),%eax
    171f:	83 ec 04             	sub    $0x4,%esp
    1722:	52                   	push   %edx
    1723:	68 ff ff ff 00       	push   $0xffffff
    1728:	50                   	push   %eax
    1729:	e8 e0 ea ff ff       	call   20e <memset>
    172e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1731:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1734:	c9                   	leave  
    1735:	c3                   	ret    

00001736 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1736:	55                   	push   %ebp
    1737:	89 e5                	mov    %esp,%ebp
    1739:	57                   	push   %edi
    173a:	56                   	push   %esi
    173b:	53                   	push   %ebx
    173c:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    173f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1742:	83 f8 03             	cmp    $0x3,%eax
    1745:	74 02                	je     1749 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1747:	eb 7c                	jmp    17c5 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1749:	8b 45 08             	mov    0x8(%ebp),%eax
    174c:	8b 58 1c             	mov    0x1c(%eax),%ebx
    174f:	8b 45 08             	mov    0x8(%ebp),%eax
    1752:	8b 48 18             	mov    0x18(%eax),%ecx
    1755:	8b 45 08             	mov    0x8(%ebp),%eax
    1758:	8b 50 5c             	mov    0x5c(%eax),%edx
    175b:	8b 45 08             	mov    0x8(%ebp),%eax
    175e:	8b 40 58             	mov    0x58(%eax),%eax
    1761:	8b 75 08             	mov    0x8(%ebp),%esi
    1764:	83 c6 58             	add    $0x58,%esi
    1767:	83 ec 04             	sub    $0x4,%esp
    176a:	53                   	push   %ebx
    176b:	51                   	push   %ecx
    176c:	6a 00                	push   $0x0
    176e:	52                   	push   %edx
    176f:	50                   	push   %eax
    1770:	6a 00                	push   $0x0
    1772:	6a 00                	push   $0x0
    1774:	56                   	push   %esi
    1775:	6a 00                	push   $0x0
    1777:	6a 00                	push   $0x0
    1779:	ff 75 08             	pushl  0x8(%ebp)
    177c:	e8 c8 ec ff ff       	call   449 <paintWindow>
    1781:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1784:	8b 45 08             	mov    0x8(%ebp),%eax
    1787:	8b 70 1c             	mov    0x1c(%eax),%esi
    178a:	8b 45 08             	mov    0x8(%ebp),%eax
    178d:	8b 58 18             	mov    0x18(%eax),%ebx
    1790:	8b 45 08             	mov    0x8(%ebp),%eax
    1793:	8b 48 08             	mov    0x8(%eax),%ecx
    1796:	8b 45 08             	mov    0x8(%ebp),%eax
    1799:	8b 50 40             	mov    0x40(%eax),%edx
    179c:	8b 45 08             	mov    0x8(%ebp),%eax
    179f:	8b 40 3c             	mov    0x3c(%eax),%eax
    17a2:	8b 7d 08             	mov    0x8(%ebp),%edi
    17a5:	83 c7 3c             	add    $0x3c,%edi
    17a8:	83 ec 04             	sub    $0x4,%esp
    17ab:	56                   	push   %esi
    17ac:	53                   	push   %ebx
    17ad:	51                   	push   %ecx
    17ae:	52                   	push   %edx
    17af:	50                   	push   %eax
    17b0:	6a 00                	push   $0x0
    17b2:	6a 00                	push   $0x0
    17b4:	57                   	push   %edi
    17b5:	6a 32                	push   $0x32
    17b7:	6a 00                	push   $0x0
    17b9:	ff 75 08             	pushl  0x8(%ebp)
    17bc:	e8 88 ec ff ff       	call   449 <paintWindow>
    17c1:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    17c4:	90                   	nop
        default: break;
            
            
    }
    return False;
    17c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17cd:	5b                   	pop    %ebx
    17ce:	5e                   	pop    %esi
    17cf:	5f                   	pop    %edi
    17d0:	5d                   	pop    %ebp
    17d1:	c3                   	ret    

000017d2 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    17d2:	55                   	push   %ebp
    17d3:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    17d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17d8:	8b 50 08             	mov    0x8(%eax),%edx
    17db:	8b 45 08             	mov    0x8(%ebp),%eax
    17de:	8b 00                	mov    (%eax),%eax
    17e0:	39 c2                	cmp    %eax,%edx
    17e2:	74 07                	je     17eb <APPreJudge+0x19>
        return False;
    17e4:	b8 00 00 00 00       	mov    $0x0,%eax
    17e9:	eb 05                	jmp    17f0 <APPreJudge+0x1e>
    return True;
    17eb:	b8 01 00 00 00       	mov    $0x1,%eax
}
    17f0:	5d                   	pop    %ebp
    17f1:	c3                   	ret    

000017f2 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    17f2:	55                   	push   %ebp
    17f3:	89 e5                	mov    %esp,%ebp
    17f5:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    17f8:	8b 45 08             	mov    0x8(%ebp),%eax
    17fb:	8b 55 0c             	mov    0xc(%ebp),%edx
    17fe:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1804:	83 ec 0c             	sub    $0xc,%esp
    1807:	ff 75 08             	pushl  0x8(%ebp)
    180a:	e8 52 ec ff ff       	call   461 <registWindow>
    180f:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1812:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1819:	8b 45 08             	mov    0x8(%ebp),%eax
    181c:	8b 00                	mov    (%eax),%eax
    181e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1821:	ff 75 f4             	pushl  -0xc(%ebp)
    1824:	ff 75 f0             	pushl  -0x10(%ebp)
    1827:	ff 75 ec             	pushl  -0x14(%ebp)
    182a:	ff 75 08             	pushl  0x8(%ebp)
    182d:	e8 80 fc ff ff       	call   14b2 <APSendMessage>
    1832:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1835:	83 ec 0c             	sub    $0xc,%esp
    1838:	ff 75 08             	pushl  0x8(%ebp)
    183b:	e8 19 ec ff ff       	call   459 <getMessage>
    1840:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1843:	8b 45 08             	mov    0x8(%ebp),%eax
    1846:	83 c0 74             	add    $0x74,%eax
    1849:	83 ec 08             	sub    $0x8,%esp
    184c:	50                   	push   %eax
    184d:	ff 75 08             	pushl  0x8(%ebp)
    1850:	e8 7d ff ff ff       	call   17d2 <APPreJudge>
    1855:	83 c4 10             	add    $0x10,%esp
    1858:	84 c0                	test   %al,%al
    185a:	74 1b                	je     1877 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    185c:	8b 45 08             	mov    0x8(%ebp),%eax
    185f:	ff 70 7c             	pushl  0x7c(%eax)
    1862:	ff 70 78             	pushl  0x78(%eax)
    1865:	ff 70 74             	pushl  0x74(%eax)
    1868:	ff 75 08             	pushl  0x8(%ebp)
    186b:	8b 45 0c             	mov    0xc(%ebp),%eax
    186e:	ff d0                	call   *%eax
    1870:	83 c4 10             	add    $0x10,%esp
    1873:	84 c0                	test   %al,%al
    1875:	75 0c                	jne    1883 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1877:	8b 45 08             	mov    0x8(%ebp),%eax
    187a:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1881:	eb b2                	jmp    1835 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1883:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1884:	90                   	nop
    1885:	c9                   	leave  
    1886:	c3                   	ret    

00001887 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1887:	55                   	push   %ebp
    1888:	89 e5                	mov    %esp,%ebp
    188a:	57                   	push   %edi
    188b:	56                   	push   %esi
    188c:	53                   	push   %ebx
    188d:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1890:	a1 38 2a 00 00       	mov    0x2a38,%eax
    1895:	85 c0                	test   %eax,%eax
    1897:	0f 85 2c 02 00 00    	jne    1ac9 <APGridPaint+0x242>
    {
        iconReady = 1;
    189d:	c7 05 38 2a 00 00 01 	movl   $0x1,0x2a38
    18a4:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    18a7:	8d 45 98             	lea    -0x68(%ebp),%eax
    18aa:	83 ec 08             	sub    $0x8,%esp
    18ad:	68 db 23 00 00       	push   $0x23db
    18b2:	50                   	push   %eax
    18b3:	e8 16 f1 ff ff       	call   9ce <APLoadBitmap>
    18b8:	83 c4 0c             	add    $0xc,%esp
    18bb:	8b 45 98             	mov    -0x68(%ebp),%eax
    18be:	a3 5c 2a 00 00       	mov    %eax,0x2a5c
    18c3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18c6:	a3 60 2a 00 00       	mov    %eax,0x2a60
    18cb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18ce:	a3 64 2a 00 00       	mov    %eax,0x2a64
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    18d3:	83 ec 04             	sub    $0x4,%esp
    18d6:	ff 35 64 2a 00 00    	pushl  0x2a64
    18dc:	ff 35 60 2a 00 00    	pushl  0x2a60
    18e2:	ff 35 5c 2a 00 00    	pushl  0x2a5c
    18e8:	e8 1b f3 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    18ed:	83 c4 10             	add    $0x10,%esp
    18f0:	a3 68 2a 00 00       	mov    %eax,0x2a68
        grid_river = APLoadBitmap ("grid_river.bmp");
    18f5:	8d 45 98             	lea    -0x68(%ebp),%eax
    18f8:	83 ec 08             	sub    $0x8,%esp
    18fb:	68 e9 23 00 00       	push   $0x23e9
    1900:	50                   	push   %eax
    1901:	e8 c8 f0 ff ff       	call   9ce <APLoadBitmap>
    1906:	83 c4 0c             	add    $0xc,%esp
    1909:	8b 45 98             	mov    -0x68(%ebp),%eax
    190c:	a3 98 2a 00 00       	mov    %eax,0x2a98
    1911:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1914:	a3 9c 2a 00 00       	mov    %eax,0x2a9c
    1919:	8b 45 a0             	mov    -0x60(%ebp),%eax
    191c:	a3 a0 2a 00 00       	mov    %eax,0x2aa0
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1921:	83 ec 04             	sub    $0x4,%esp
    1924:	ff 35 a0 2a 00 00    	pushl  0x2aa0
    192a:	ff 35 9c 2a 00 00    	pushl  0x2a9c
    1930:	ff 35 98 2a 00 00    	pushl  0x2a98
    1936:	e8 cd f2 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    193b:	83 c4 10             	add    $0x10,%esp
    193e:	a3 88 2a 00 00       	mov    %eax,0x2a88
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1943:	8d 45 98             	lea    -0x68(%ebp),%eax
    1946:	83 ec 08             	sub    $0x8,%esp
    1949:	68 f8 23 00 00       	push   $0x23f8
    194e:	50                   	push   %eax
    194f:	e8 7a f0 ff ff       	call   9ce <APLoadBitmap>
    1954:	83 c4 0c             	add    $0xc,%esp
    1957:	8b 45 98             	mov    -0x68(%ebp),%eax
    195a:	a3 8c 2a 00 00       	mov    %eax,0x2a8c
    195f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1962:	a3 90 2a 00 00       	mov    %eax,0x2a90
    1967:	8b 45 a0             	mov    -0x60(%ebp),%eax
    196a:	a3 94 2a 00 00       	mov    %eax,0x2a94
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    196f:	83 ec 04             	sub    $0x4,%esp
    1972:	ff 35 94 2a 00 00    	pushl  0x2a94
    1978:	ff 35 90 2a 00 00    	pushl  0x2a90
    197e:	ff 35 8c 2a 00 00    	pushl  0x2a8c
    1984:	e8 7f f2 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    1989:	83 c4 10             	add    $0x10,%esp
    198c:	a3 3c 2a 00 00       	mov    %eax,0x2a3c
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1991:	8d 45 98             	lea    -0x68(%ebp),%eax
    1994:	83 ec 08             	sub    $0x8,%esp
    1997:	68 07 24 00 00       	push   $0x2407
    199c:	50                   	push   %eax
    199d:	e8 2c f0 ff ff       	call   9ce <APLoadBitmap>
    19a2:	83 c4 0c             	add    $0xc,%esp
    19a5:	8b 45 98             	mov    -0x68(%ebp),%eax
    19a8:	a3 70 2a 00 00       	mov    %eax,0x2a70
    19ad:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19b0:	a3 74 2a 00 00       	mov    %eax,0x2a74
    19b5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19b8:	a3 78 2a 00 00       	mov    %eax,0x2a78
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    19bd:	83 ec 04             	sub    $0x4,%esp
    19c0:	ff 35 78 2a 00 00    	pushl  0x2a78
    19c6:	ff 35 74 2a 00 00    	pushl  0x2a74
    19cc:	ff 35 70 2a 00 00    	pushl  0x2a70
    19d2:	e8 31 f2 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    19d7:	83 c4 10             	add    $0x10,%esp
    19da:	a3 a4 2a 00 00       	mov    %eax,0x2aa4
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    19df:	8d 45 98             	lea    -0x68(%ebp),%eax
    19e2:	83 ec 08             	sub    $0x8,%esp
    19e5:	68 15 24 00 00       	push   $0x2415
    19ea:	50                   	push   %eax
    19eb:	e8 de ef ff ff       	call   9ce <APLoadBitmap>
    19f0:	83 c4 0c             	add    $0xc,%esp
    19f3:	8b 45 98             	mov    -0x68(%ebp),%eax
    19f6:	a3 4c 2a 00 00       	mov    %eax,0x2a4c
    19fb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19fe:	a3 50 2a 00 00       	mov    %eax,0x2a50
    1a03:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a06:	a3 54 2a 00 00       	mov    %eax,0x2a54
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1a0b:	83 ec 04             	sub    $0x4,%esp
    1a0e:	ff 35 54 2a 00 00    	pushl  0x2a54
    1a14:	ff 35 50 2a 00 00    	pushl  0x2a50
    1a1a:	ff 35 4c 2a 00 00    	pushl  0x2a4c
    1a20:	e8 e3 f1 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    1a25:	83 c4 10             	add    $0x10,%esp
    1a28:	a3 6c 2a 00 00       	mov    %eax,0x2a6c
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1a2d:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a30:	83 ec 08             	sub    $0x8,%esp
    1a33:	68 25 24 00 00       	push   $0x2425
    1a38:	50                   	push   %eax
    1a39:	e8 90 ef ff ff       	call   9ce <APLoadBitmap>
    1a3e:	83 c4 0c             	add    $0xc,%esp
    1a41:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a44:	a3 40 2a 00 00       	mov    %eax,0x2a40
    1a49:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a4c:	a3 44 2a 00 00       	mov    %eax,0x2a44
    1a51:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a54:	a3 48 2a 00 00       	mov    %eax,0x2a48
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1a59:	83 ec 04             	sub    $0x4,%esp
    1a5c:	ff 35 48 2a 00 00    	pushl  0x2a48
    1a62:	ff 35 44 2a 00 00    	pushl  0x2a44
    1a68:	ff 35 40 2a 00 00    	pushl  0x2a40
    1a6e:	e8 95 f1 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    1a73:	83 c4 10             	add    $0x10,%esp
    1a76:	a3 58 2a 00 00       	mov    %eax,0x2a58
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a7b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a7e:	83 ec 08             	sub    $0x8,%esp
    1a81:	68 37 24 00 00       	push   $0x2437
    1a86:	50                   	push   %eax
    1a87:	e8 42 ef ff ff       	call   9ce <APLoadBitmap>
    1a8c:	83 c4 0c             	add    $0xc,%esp
    1a8f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a92:	a3 7c 2a 00 00       	mov    %eax,0x2a7c
    1a97:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a9a:	a3 80 2a 00 00       	mov    %eax,0x2a80
    1a9f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aa2:	a3 84 2a 00 00       	mov    %eax,0x2a84
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1aa7:	83 ec 04             	sub    $0x4,%esp
    1aaa:	ff 35 84 2a 00 00    	pushl  0x2a84
    1ab0:	ff 35 80 2a 00 00    	pushl  0x2a80
    1ab6:	ff 35 7c 2a 00 00    	pushl  0x2a7c
    1abc:	e8 47 f1 ff ff       	call   c08 <APCreateCompatibleDCFromBitmap>
    1ac1:	83 c4 10             	add    $0x10,%esp
    1ac4:	a3 a8 2a 00 00       	mov    %eax,0x2aa8
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1ac9:	8b 45 08             	mov    0x8(%ebp),%eax
    1acc:	8b 40 08             	mov    0x8(%eax),%eax
    1acf:	85 c0                	test   %eax,%eax
    1ad1:	75 17                	jne    1aea <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1ad3:	83 ec 08             	sub    $0x8,%esp
    1ad6:	68 48 24 00 00       	push   $0x2448
    1adb:	6a 01                	push   $0x1
    1add:	e8 66 ea ff ff       	call   548 <printf>
    1ae2:	83 c4 10             	add    $0x10,%esp
        return;
    1ae5:	e9 a0 04 00 00       	jmp    1f8a <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1aea:	8b 45 08             	mov    0x8(%ebp),%eax
    1aed:	8b 40 10             	mov    0x10(%eax),%eax
    1af0:	85 c0                	test   %eax,%eax
    1af2:	7e 10                	jle    1b04 <APGridPaint+0x27d>
    1af4:	8b 45 08             	mov    0x8(%ebp),%eax
    1af7:	8b 50 14             	mov    0x14(%eax),%edx
    1afa:	8b 45 08             	mov    0x8(%ebp),%eax
    1afd:	8b 40 10             	mov    0x10(%eax),%eax
    1b00:	39 c2                	cmp    %eax,%edx
    1b02:	7c 17                	jl     1b1b <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1b04:	83 ec 08             	sub    $0x8,%esp
    1b07:	68 6e 24 00 00       	push   $0x246e
    1b0c:	6a 01                	push   $0x1
    1b0e:	e8 35 ea ff ff       	call   548 <printf>
    1b13:	83 c4 10             	add    $0x10,%esp
        return;
    1b16:	e9 6f 04 00 00       	jmp    1f8a <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1e:	8b 40 14             	mov    0x14(%eax),%eax
    1b21:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b27:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b2a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b2d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b30:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b37:	e9 96 03 00 00       	jmp    1ed2 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b3c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b43:	e9 7c 03 00 00       	jmp    1ec4 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b48:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b4b:	c1 e0 04             	shl    $0x4,%eax
    1b4e:	89 c2                	mov    %eax,%edx
    1b50:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b53:	01 c2                	add    %eax,%edx
    1b55:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b58:	01 d0                	add    %edx,%eax
    1b5a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b60:	8b 40 0c             	mov    0xc(%eax),%eax
    1b63:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b66:	c1 e2 02             	shl    $0x2,%edx
    1b69:	01 d0                	add    %edx,%eax
    1b6b:	8b 00                	mov    (%eax),%eax
    1b6d:	83 f8 07             	cmp    $0x7,%eax
    1b70:	0f 87 49 03 00 00    	ja     1ebf <APGridPaint+0x638>
    1b76:	8b 04 85 84 24 00 00 	mov    0x2484(,%eax,4),%eax
    1b7d:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b7f:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b82:	6a 0c                	push   $0xc
    1b84:	6a 0c                	push   $0xc
    1b86:	6a 0c                	push   $0xc
    1b88:	50                   	push   %eax
    1b89:	e8 df f8 ff ff       	call   146d <RGB>
    1b8e:	83 c4 0c             	add    $0xc,%esp
    1b91:	8b 1d 68 2a 00 00    	mov    0x2a68,%ebx
    1b97:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b9a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b9d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ba0:	6b c0 32             	imul   $0x32,%eax,%eax
    1ba3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ba6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1bac:	83 ec 0c             	sub    $0xc,%esp
    1baf:	83 ec 04             	sub    $0x4,%esp
    1bb2:	89 e0                	mov    %esp,%eax
    1bb4:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1bb8:	66 89 30             	mov    %si,(%eax)
    1bbb:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1bbf:	88 50 02             	mov    %dl,0x2(%eax)
    1bc2:	6a 32                	push   $0x32
    1bc4:	6a 32                	push   $0x32
    1bc6:	6a 00                	push   $0x0
    1bc8:	6a 00                	push   $0x0
    1bca:	53                   	push   %ebx
    1bcb:	51                   	push   %ecx
    1bcc:	ff 75 94             	pushl  -0x6c(%ebp)
    1bcf:	57                   	push   %edi
    1bd0:	e8 f4 f6 ff ff       	call   12c9 <APDcCopy>
    1bd5:	83 c4 30             	add    $0x30,%esp
                    break;
    1bd8:	e9 e3 02 00 00       	jmp    1ec0 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1bdd:	8d 45 98             	lea    -0x68(%ebp),%eax
    1be0:	6a 69                	push   $0x69
    1be2:	6a 69                	push   $0x69
    1be4:	6a 69                	push   $0x69
    1be6:	50                   	push   %eax
    1be7:	e8 81 f8 ff ff       	call   146d <RGB>
    1bec:	83 c4 0c             	add    $0xc,%esp
    1bef:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bf3:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1bf7:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bfb:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1bfe:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c05:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c08:	6a 69                	push   $0x69
    1c0a:	6a 69                	push   $0x69
    1c0c:	6a 69                	push   $0x69
    1c0e:	50                   	push   %eax
    1c0f:	e8 59 f8 ff ff       	call   146d <RGB>
    1c14:	83 c4 0c             	add    $0xc,%esp
    1c17:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1c1b:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1c1f:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1c23:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c26:	8b 45 08             	mov    0x8(%ebp),%eax
    1c29:	8d 50 3c             	lea    0x3c(%eax),%edx
    1c2c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c2f:	ff 75 b0             	pushl  -0x50(%ebp)
    1c32:	ff 75 ac             	pushl  -0x54(%ebp)
    1c35:	52                   	push   %edx
    1c36:	50                   	push   %eax
    1c37:	e8 61 f0 ff ff       	call   c9d <APSetPen>
    1c3c:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c42:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1c45:	8d 55 98             	lea    -0x68(%ebp),%edx
    1c48:	83 ec 04             	sub    $0x4,%esp
    1c4b:	83 ec 04             	sub    $0x4,%esp
    1c4e:	89 e0                	mov    %esp,%eax
    1c50:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1c54:	66 89 08             	mov    %cx,(%eax)
    1c57:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1c5b:	88 48 02             	mov    %cl,0x2(%eax)
    1c5e:	53                   	push   %ebx
    1c5f:	52                   	push   %edx
    1c60:	e8 71 f0 ff ff       	call   cd6 <APSetBrush>
    1c65:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c6b:	6b d0 32             	imul   $0x32,%eax,%edx
    1c6e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c71:	6b c0 32             	imul   $0x32,%eax,%eax
    1c74:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c77:	83 c1 3c             	add    $0x3c,%ecx
    1c7a:	83 ec 0c             	sub    $0xc,%esp
    1c7d:	6a 32                	push   $0x32
    1c7f:	6a 32                	push   $0x32
    1c81:	52                   	push   %edx
    1c82:	50                   	push   %eax
    1c83:	51                   	push   %ecx
    1c84:	e8 35 f4 ff ff       	call   10be <APDrawRect>
    1c89:	83 c4 20             	add    $0x20,%esp
                    break;
    1c8c:	e9 2f 02 00 00       	jmp    1ec0 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c91:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c94:	6a 0c                	push   $0xc
    1c96:	6a 0c                	push   $0xc
    1c98:	6a 0c                	push   $0xc
    1c9a:	50                   	push   %eax
    1c9b:	e8 cd f7 ff ff       	call   146d <RGB>
    1ca0:	83 c4 0c             	add    $0xc,%esp
    1ca3:	8b 1d a8 2a 00 00    	mov    0x2aa8,%ebx
    1ca9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cac:	6b c8 32             	imul   $0x32,%eax,%ecx
    1caf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb2:	6b c0 32             	imul   $0x32,%eax,%eax
    1cb5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cb8:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbb:	8d 78 3c             	lea    0x3c(%eax),%edi
    1cbe:	83 ec 0c             	sub    $0xc,%esp
    1cc1:	83 ec 04             	sub    $0x4,%esp
    1cc4:	89 e0                	mov    %esp,%eax
    1cc6:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1cca:	66 89 30             	mov    %si,(%eax)
    1ccd:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1cd1:	88 50 02             	mov    %dl,0x2(%eax)
    1cd4:	6a 32                	push   $0x32
    1cd6:	6a 32                	push   $0x32
    1cd8:	6a 00                	push   $0x0
    1cda:	6a 00                	push   $0x0
    1cdc:	53                   	push   %ebx
    1cdd:	51                   	push   %ecx
    1cde:	ff 75 94             	pushl  -0x6c(%ebp)
    1ce1:	57                   	push   %edi
    1ce2:	e8 e2 f5 ff ff       	call   12c9 <APDcCopy>
    1ce7:	83 c4 30             	add    $0x30,%esp
                    break;
    1cea:	e9 d1 01 00 00       	jmp    1ec0 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cef:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1cf2:	6a 0c                	push   $0xc
    1cf4:	6a 0c                	push   $0xc
    1cf6:	6a 0c                	push   $0xc
    1cf8:	50                   	push   %eax
    1cf9:	e8 6f f7 ff ff       	call   146d <RGB>
    1cfe:	83 c4 0c             	add    $0xc,%esp
    1d01:	8b 1d 88 2a 00 00    	mov    0x2a88,%ebx
    1d07:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d0a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d10:	6b c0 32             	imul   $0x32,%eax,%eax
    1d13:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d16:	8b 45 08             	mov    0x8(%ebp),%eax
    1d19:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d1c:	83 ec 0c             	sub    $0xc,%esp
    1d1f:	83 ec 04             	sub    $0x4,%esp
    1d22:	89 e0                	mov    %esp,%eax
    1d24:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1d28:	66 89 30             	mov    %si,(%eax)
    1d2b:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1d2f:	88 50 02             	mov    %dl,0x2(%eax)
    1d32:	6a 32                	push   $0x32
    1d34:	6a 32                	push   $0x32
    1d36:	6a 00                	push   $0x0
    1d38:	6a 00                	push   $0x0
    1d3a:	53                   	push   %ebx
    1d3b:	51                   	push   %ecx
    1d3c:	ff 75 94             	pushl  -0x6c(%ebp)
    1d3f:	57                   	push   %edi
    1d40:	e8 84 f5 ff ff       	call   12c9 <APDcCopy>
    1d45:	83 c4 30             	add    $0x30,%esp
                    break;
    1d48:	e9 73 01 00 00       	jmp    1ec0 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d4d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1d50:	6a 0c                	push   $0xc
    1d52:	6a 0c                	push   $0xc
    1d54:	6a 0c                	push   $0xc
    1d56:	50                   	push   %eax
    1d57:	e8 11 f7 ff ff       	call   146d <RGB>
    1d5c:	83 c4 0c             	add    $0xc,%esp
    1d5f:	8b 1d 6c 2a 00 00    	mov    0x2a6c,%ebx
    1d65:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d68:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d6e:	6b c0 32             	imul   $0x32,%eax,%eax
    1d71:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d74:	8b 45 08             	mov    0x8(%ebp),%eax
    1d77:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d7a:	83 ec 0c             	sub    $0xc,%esp
    1d7d:	83 ec 04             	sub    $0x4,%esp
    1d80:	89 e0                	mov    %esp,%eax
    1d82:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d86:	66 89 30             	mov    %si,(%eax)
    1d89:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d8d:	88 50 02             	mov    %dl,0x2(%eax)
    1d90:	6a 32                	push   $0x32
    1d92:	6a 32                	push   $0x32
    1d94:	6a 00                	push   $0x0
    1d96:	6a 00                	push   $0x0
    1d98:	53                   	push   %ebx
    1d99:	51                   	push   %ecx
    1d9a:	ff 75 94             	pushl  -0x6c(%ebp)
    1d9d:	57                   	push   %edi
    1d9e:	e8 26 f5 ff ff       	call   12c9 <APDcCopy>
    1da3:	83 c4 30             	add    $0x30,%esp
                    break;
    1da6:	e9 15 01 00 00       	jmp    1ec0 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dab:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1dae:	6a 0c                	push   $0xc
    1db0:	6a 0c                	push   $0xc
    1db2:	6a 0c                	push   $0xc
    1db4:	50                   	push   %eax
    1db5:	e8 b3 f6 ff ff       	call   146d <RGB>
    1dba:	83 c4 0c             	add    $0xc,%esp
    1dbd:	8b 1d a4 2a 00 00    	mov    0x2aa4,%ebx
    1dc3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dc6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dc9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dcc:	6b c0 32             	imul   $0x32,%eax,%eax
    1dcf:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1dd8:	83 ec 0c             	sub    $0xc,%esp
    1ddb:	83 ec 04             	sub    $0x4,%esp
    1dde:	89 e0                	mov    %esp,%eax
    1de0:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1de4:	66 89 30             	mov    %si,(%eax)
    1de7:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1deb:	88 50 02             	mov    %dl,0x2(%eax)
    1dee:	6a 32                	push   $0x32
    1df0:	6a 32                	push   $0x32
    1df2:	6a 00                	push   $0x0
    1df4:	6a 00                	push   $0x0
    1df6:	53                   	push   %ebx
    1df7:	51                   	push   %ecx
    1df8:	ff 75 94             	pushl  -0x6c(%ebp)
    1dfb:	57                   	push   %edi
    1dfc:	e8 c8 f4 ff ff       	call   12c9 <APDcCopy>
    1e01:	83 c4 30             	add    $0x30,%esp
                    break;
    1e04:	e9 b7 00 00 00       	jmp    1ec0 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e09:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1e0c:	6a 0c                	push   $0xc
    1e0e:	6a 0c                	push   $0xc
    1e10:	6a 0c                	push   $0xc
    1e12:	50                   	push   %eax
    1e13:	e8 55 f6 ff ff       	call   146d <RGB>
    1e18:	83 c4 0c             	add    $0xc,%esp
    1e1b:	8b 1d 3c 2a 00 00    	mov    0x2a3c,%ebx
    1e21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e24:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e27:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e2a:	6b c0 32             	imul   $0x32,%eax,%eax
    1e2d:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e30:	8b 45 08             	mov    0x8(%ebp),%eax
    1e33:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e36:	83 ec 0c             	sub    $0xc,%esp
    1e39:	83 ec 04             	sub    $0x4,%esp
    1e3c:	89 e0                	mov    %esp,%eax
    1e3e:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1e42:	66 89 30             	mov    %si,(%eax)
    1e45:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1e49:	88 50 02             	mov    %dl,0x2(%eax)
    1e4c:	6a 32                	push   $0x32
    1e4e:	6a 32                	push   $0x32
    1e50:	6a 00                	push   $0x0
    1e52:	6a 00                	push   $0x0
    1e54:	53                   	push   %ebx
    1e55:	51                   	push   %ecx
    1e56:	ff 75 94             	pushl  -0x6c(%ebp)
    1e59:	57                   	push   %edi
    1e5a:	e8 6a f4 ff ff       	call   12c9 <APDcCopy>
    1e5f:	83 c4 30             	add    $0x30,%esp
                    break;
    1e62:	eb 5c                	jmp    1ec0 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e64:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e67:	6a 0c                	push   $0xc
    1e69:	6a 0c                	push   $0xc
    1e6b:	6a 0c                	push   $0xc
    1e6d:	50                   	push   %eax
    1e6e:	e8 fa f5 ff ff       	call   146d <RGB>
    1e73:	83 c4 0c             	add    $0xc,%esp
    1e76:	8b 1d 58 2a 00 00    	mov    0x2a58,%ebx
    1e7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e7f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e82:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e85:	6b c0 32             	imul   $0x32,%eax,%eax
    1e88:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8e:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e91:	83 ec 0c             	sub    $0xc,%esp
    1e94:	83 ec 04             	sub    $0x4,%esp
    1e97:	89 e0                	mov    %esp,%eax
    1e99:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e9d:	66 89 30             	mov    %si,(%eax)
    1ea0:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1ea4:	88 50 02             	mov    %dl,0x2(%eax)
    1ea7:	6a 32                	push   $0x32
    1ea9:	6a 32                	push   $0x32
    1eab:	6a 00                	push   $0x0
    1ead:	6a 00                	push   $0x0
    1eaf:	53                   	push   %ebx
    1eb0:	51                   	push   %ecx
    1eb1:	ff 75 94             	pushl  -0x6c(%ebp)
    1eb4:	57                   	push   %edi
    1eb5:	e8 0f f4 ff ff       	call   12c9 <APDcCopy>
    1eba:	83 c4 30             	add    $0x30,%esp
                    break;
    1ebd:	eb 01                	jmp    1ec0 <APGridPaint+0x639>
                default: break;
    1ebf:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ec0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1ec4:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1ec8:	0f 8e 7a fc ff ff    	jle    1b48 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ece:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1ed2:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1ed6:	0f 8e 60 fc ff ff    	jle    1b3c <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    1edc:	8d 45 98             	lea    -0x68(%ebp),%eax
    1edf:	68 cd 00 00 00       	push   $0xcd
    1ee4:	6a 74                	push   $0x74
    1ee6:	6a 18                	push   $0x18
    1ee8:	50                   	push   %eax
    1ee9:	e8 7f f5 ff ff       	call   146d <RGB>
    1eee:	83 c4 0c             	add    $0xc,%esp
    1ef1:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ef5:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1ef9:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1efd:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    1f00:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    1f07:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f0a:	68 cd 00 00 00       	push   $0xcd
    1f0f:	6a 74                	push   $0x74
    1f11:	6a 18                	push   $0x18
    1f13:	50                   	push   %eax
    1f14:	e8 54 f5 ff ff       	call   146d <RGB>
    1f19:	83 c4 0c             	add    $0xc,%esp
    1f1c:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1f20:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1f24:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1f28:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    1f2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f2e:	8d 50 58             	lea    0x58(%eax),%edx
    1f31:	8d 45 98             	lea    -0x68(%ebp),%eax
    1f34:	ff 75 bc             	pushl  -0x44(%ebp)
    1f37:	ff 75 b8             	pushl  -0x48(%ebp)
    1f3a:	52                   	push   %edx
    1f3b:	50                   	push   %eax
    1f3c:	e8 5c ed ff ff       	call   c9d <APSetPen>
    1f41:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    1f44:	8b 45 08             	mov    0x8(%ebp),%eax
    1f47:	8d 58 58             	lea    0x58(%eax),%ebx
    1f4a:	8d 55 98             	lea    -0x68(%ebp),%edx
    1f4d:	83 ec 04             	sub    $0x4,%esp
    1f50:	83 ec 04             	sub    $0x4,%esp
    1f53:	89 e0                	mov    %esp,%eax
    1f55:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1f59:	66 89 08             	mov    %cx,(%eax)
    1f5c:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1f60:	88 48 02             	mov    %cl,0x2(%eax)
    1f63:	53                   	push   %ebx
    1f64:	52                   	push   %edx
    1f65:	e8 6c ed ff ff       	call   cd6 <APSetBrush>
    1f6a:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    1f6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f70:	83 c0 58             	add    $0x58,%eax
    1f73:	83 ec 0c             	sub    $0xc,%esp
    1f76:	6a 32                	push   $0x32
    1f78:	68 20 03 00 00       	push   $0x320
    1f7d:	6a 00                	push   $0x0
    1f7f:	6a 00                	push   $0x0
    1f81:	50                   	push   %eax
    1f82:	e8 37 f1 ff ff       	call   10be <APDrawRect>
    1f87:	83 c4 20             	add    $0x20,%esp
}
    1f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1f8d:	5b                   	pop    %ebx
    1f8e:	5e                   	pop    %esi
    1f8f:	5f                   	pop    %edi
    1f90:	5d                   	pop    %ebp
    1f91:	c3                   	ret    

00001f92 <random>:
//

#include "APLib.h"

int random(int seed)
{
    1f92:	55                   	push   %ebp
    1f93:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1f95:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1f99:	7e 08                	jle    1fa3 <random+0x11>
{
rand_num = seed;
    1f9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9e:	a3 14 2a 00 00       	mov    %eax,0x2a14
}
rand_num *= 3;
    1fa3:	8b 15 14 2a 00 00    	mov    0x2a14,%edx
    1fa9:	89 d0                	mov    %edx,%eax
    1fab:	01 c0                	add    %eax,%eax
    1fad:	01 d0                	add    %edx,%eax
    1faf:	a3 14 2a 00 00       	mov    %eax,0x2a14
if (rand_num < 0)
    1fb4:	a1 14 2a 00 00       	mov    0x2a14,%eax
    1fb9:	85 c0                	test   %eax,%eax
    1fbb:	79 0c                	jns    1fc9 <random+0x37>
{
rand_num *= (-1);
    1fbd:	a1 14 2a 00 00       	mov    0x2a14,%eax
    1fc2:	f7 d8                	neg    %eax
    1fc4:	a3 14 2a 00 00       	mov    %eax,0x2a14
}
return rand_num % 997;
    1fc9:	8b 0d 14 2a 00 00    	mov    0x2a14,%ecx
    1fcf:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1fd4:	89 c8                	mov    %ecx,%eax
    1fd6:	f7 ea                	imul   %edx
    1fd8:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1fdb:	c1 f8 09             	sar    $0x9,%eax
    1fde:	89 c2                	mov    %eax,%edx
    1fe0:	89 c8                	mov    %ecx,%eax
    1fe2:	c1 f8 1f             	sar    $0x1f,%eax
    1fe5:	29 c2                	sub    %eax,%edx
    1fe7:	89 d0                	mov    %edx,%eax
    1fe9:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1fef:	29 c1                	sub    %eax,%ecx
    1ff1:	89 c8                	mov    %ecx,%eax
}
    1ff3:	5d                   	pop    %ebp
    1ff4:	c3                   	ret    

00001ff5 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1ff5:	55                   	push   %ebp
    1ff6:	89 e5                	mov    %esp,%ebp
    1ff8:	53                   	push   %ebx
    1ff9:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ffc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2003:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2007:	74 17                	je     2020 <sprintint+0x2b>
    2009:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    200d:	79 11                	jns    2020 <sprintint+0x2b>
        neg = 1;
    200f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2016:	8b 45 10             	mov    0x10(%ebp),%eax
    2019:	f7 d8                	neg    %eax
    201b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    201e:	eb 06                	jmp    2026 <sprintint+0x31>
    } else {
        x = xx;
    2020:	8b 45 10             	mov    0x10(%ebp),%eax
    2023:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2026:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    202d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2030:	8d 41 01             	lea    0x1(%ecx),%eax
    2033:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2036:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2039:	8b 45 f0             	mov    -0x10(%ebp),%eax
    203c:	ba 00 00 00 00       	mov    $0x0,%edx
    2041:	f7 f3                	div    %ebx
    2043:	89 d0                	mov    %edx,%eax
    2045:	0f b6 80 18 2a 00 00 	movzbl 0x2a18(%eax),%eax
    204c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2050:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2053:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2056:	ba 00 00 00 00       	mov    $0x0,%edx
    205b:	f7 f3                	div    %ebx
    205d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2060:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2064:	75 c7                	jne    202d <sprintint+0x38>
    if(neg)
    2066:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    206a:	74 0e                	je     207a <sprintint+0x85>
        buf[i++] = '-';
    206c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    206f:	8d 50 01             	lea    0x1(%eax),%edx
    2072:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2075:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    207a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    207d:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2080:	eb 1b                	jmp    209d <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2082:	8b 45 0c             	mov    0xc(%ebp),%eax
    2085:	8b 00                	mov    (%eax),%eax
    2087:	8d 48 01             	lea    0x1(%eax),%ecx
    208a:	8b 55 0c             	mov    0xc(%ebp),%edx
    208d:	89 0a                	mov    %ecx,(%edx)
    208f:	89 c2                	mov    %eax,%edx
    2091:	8b 45 08             	mov    0x8(%ebp),%eax
    2094:	01 d0                	add    %edx,%eax
    2096:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2099:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    209d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    20a1:	7f df                	jg     2082 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    20a3:	eb 21                	jmp    20c6 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    20a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    20a8:	8b 00                	mov    (%eax),%eax
    20aa:	8d 48 01             	lea    0x1(%eax),%ecx
    20ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    20b0:	89 0a                	mov    %ecx,(%edx)
    20b2:	89 c2                	mov    %eax,%edx
    20b4:	8b 45 08             	mov    0x8(%ebp),%eax
    20b7:	01 c2                	add    %eax,%edx
    20b9:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    20bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20bf:	01 c8                	add    %ecx,%eax
    20c1:	0f b6 00             	movzbl (%eax),%eax
    20c4:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    20c6:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    20ca:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    20ce:	79 d5                	jns    20a5 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    20d0:	90                   	nop
    20d1:	83 c4 20             	add    $0x20,%esp
    20d4:	5b                   	pop    %ebx
    20d5:	5d                   	pop    %ebp
    20d6:	c3                   	ret    

000020d7 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    20d7:	55                   	push   %ebp
    20d8:	89 e5                	mov    %esp,%ebp
    20da:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    20dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    20e4:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    20eb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    20f2:	8d 45 0c             	lea    0xc(%ebp),%eax
    20f5:	83 c0 04             	add    $0x4,%eax
    20f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    20fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2102:	e9 d9 01 00 00       	jmp    22e0 <sprintf+0x209>
        c = fmt[i] & 0xff;
    2107:	8b 55 0c             	mov    0xc(%ebp),%edx
    210a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    210d:	01 d0                	add    %edx,%eax
    210f:	0f b6 00             	movzbl (%eax),%eax
    2112:	0f be c0             	movsbl %al,%eax
    2115:	25 ff 00 00 00       	and    $0xff,%eax
    211a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    211d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2121:	75 2c                	jne    214f <sprintf+0x78>
            if(c == '%'){
    2123:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2127:	75 0c                	jne    2135 <sprintf+0x5e>
                state = '%';
    2129:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2130:	e9 a7 01 00 00       	jmp    22dc <sprintf+0x205>
            } else {
                dst[j++] = c;
    2135:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2138:	8d 50 01             	lea    0x1(%eax),%edx
    213b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    213e:	89 c2                	mov    %eax,%edx
    2140:	8b 45 08             	mov    0x8(%ebp),%eax
    2143:	01 d0                	add    %edx,%eax
    2145:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2148:	88 10                	mov    %dl,(%eax)
    214a:	e9 8d 01 00 00       	jmp    22dc <sprintf+0x205>
            }
        } else if(state == '%'){
    214f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2153:	0f 85 83 01 00 00    	jne    22dc <sprintf+0x205>
            if(c == 'd'){
    2159:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    215d:	75 4c                	jne    21ab <sprintf+0xd4>
                buf[bi] = '\0';
    215f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2162:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2165:	01 d0                	add    %edx,%eax
    2167:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    216a:	83 ec 0c             	sub    $0xc,%esp
    216d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2170:	50                   	push   %eax
    2171:	e8 a1 e1 ff ff       	call   317 <atoi>
    2176:	83 c4 10             	add    $0x10,%esp
    2179:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    217c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2183:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2186:	8b 00                	mov    (%eax),%eax
    2188:	83 ec 08             	sub    $0x8,%esp
    218b:	ff 75 d8             	pushl  -0x28(%ebp)
    218e:	6a 01                	push   $0x1
    2190:	6a 0a                	push   $0xa
    2192:	50                   	push   %eax
    2193:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2196:	50                   	push   %eax
    2197:	ff 75 08             	pushl  0x8(%ebp)
    219a:	e8 56 fe ff ff       	call   1ff5 <sprintint>
    219f:	83 c4 20             	add    $0x20,%esp
                ap++;
    21a2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    21a6:	e9 2a 01 00 00       	jmp    22d5 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    21ab:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    21af:	74 06                	je     21b7 <sprintf+0xe0>
    21b1:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    21b5:	75 4c                	jne    2203 <sprintf+0x12c>
                buf[bi] = '\0';
    21b7:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21bd:	01 d0                	add    %edx,%eax
    21bf:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21c2:	83 ec 0c             	sub    $0xc,%esp
    21c5:	8d 45 ce             	lea    -0x32(%ebp),%eax
    21c8:	50                   	push   %eax
    21c9:	e8 49 e1 ff ff       	call   317 <atoi>
    21ce:	83 c4 10             	add    $0x10,%esp
    21d1:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    21d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    21db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21de:	8b 00                	mov    (%eax),%eax
    21e0:	83 ec 08             	sub    $0x8,%esp
    21e3:	ff 75 dc             	pushl  -0x24(%ebp)
    21e6:	6a 00                	push   $0x0
    21e8:	6a 10                	push   $0x10
    21ea:	50                   	push   %eax
    21eb:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21ee:	50                   	push   %eax
    21ef:	ff 75 08             	pushl  0x8(%ebp)
    21f2:	e8 fe fd ff ff       	call   1ff5 <sprintint>
    21f7:	83 c4 20             	add    $0x20,%esp
                ap++;
    21fa:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    21fe:	e9 d2 00 00 00       	jmp    22d5 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2203:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2207:	75 46                	jne    224f <sprintf+0x178>
                s = (char*)*ap;
    2209:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    220c:	8b 00                	mov    (%eax),%eax
    220e:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2211:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2215:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2219:	75 25                	jne    2240 <sprintf+0x169>
                    s = "(null)";
    221b:	c7 45 f4 a4 24 00 00 	movl   $0x24a4,-0xc(%ebp)
                while(*s != 0){
    2222:	eb 1c                	jmp    2240 <sprintf+0x169>
                    dst[j++] = *s;
    2224:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2227:	8d 50 01             	lea    0x1(%eax),%edx
    222a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    222d:	89 c2                	mov    %eax,%edx
    222f:	8b 45 08             	mov    0x8(%ebp),%eax
    2232:	01 c2                	add    %eax,%edx
    2234:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2237:	0f b6 00             	movzbl (%eax),%eax
    223a:	88 02                	mov    %al,(%edx)
                    s++;
    223c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2240:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2243:	0f b6 00             	movzbl (%eax),%eax
    2246:	84 c0                	test   %al,%al
    2248:	75 da                	jne    2224 <sprintf+0x14d>
    224a:	e9 86 00 00 00       	jmp    22d5 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    224f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2253:	75 1d                	jne    2272 <sprintf+0x19b>
                dst[j++] = *ap;
    2255:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2258:	8d 50 01             	lea    0x1(%eax),%edx
    225b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    225e:	89 c2                	mov    %eax,%edx
    2260:	8b 45 08             	mov    0x8(%ebp),%eax
    2263:	01 c2                	add    %eax,%edx
    2265:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2268:	8b 00                	mov    (%eax),%eax
    226a:	88 02                	mov    %al,(%edx)
                ap++;
    226c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2270:	eb 63                	jmp    22d5 <sprintf+0x1fe>
            } else if(c == '%'){
    2272:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2276:	75 17                	jne    228f <sprintf+0x1b8>
                dst[j++] = c;
    2278:	8b 45 c8             	mov    -0x38(%ebp),%eax
    227b:	8d 50 01             	lea    0x1(%eax),%edx
    227e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2281:	89 c2                	mov    %eax,%edx
    2283:	8b 45 08             	mov    0x8(%ebp),%eax
    2286:	01 d0                	add    %edx,%eax
    2288:	8b 55 e0             	mov    -0x20(%ebp),%edx
    228b:	88 10                	mov    %dl,(%eax)
    228d:	eb 46                	jmp    22d5 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    228f:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2293:	7e 18                	jle    22ad <sprintf+0x1d6>
    2295:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2299:	7f 12                	jg     22ad <sprintf+0x1d6>
            {
                buf[bi++] = c;
    229b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    229e:	8d 50 01             	lea    0x1(%eax),%edx
    22a1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    22a4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22a7:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    22ab:	eb 2f                	jmp    22dc <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    22ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22b0:	8d 50 01             	lea    0x1(%eax),%edx
    22b3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22b6:	89 c2                	mov    %eax,%edx
    22b8:	8b 45 08             	mov    0x8(%ebp),%eax
    22bb:	01 d0                	add    %edx,%eax
    22bd:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    22c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22c3:	8d 50 01             	lea    0x1(%eax),%edx
    22c6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22c9:	89 c2                	mov    %eax,%edx
    22cb:	8b 45 08             	mov    0x8(%ebp),%eax
    22ce:	01 d0                	add    %edx,%eax
    22d0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22d3:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    22d5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    22dc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    22e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    22e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22e6:	01 d0                	add    %edx,%eax
    22e8:	0f b6 00             	movzbl (%eax),%eax
    22eb:	84 c0                	test   %al,%al
    22ed:	0f 85 14 fe ff ff    	jne    2107 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    22f3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22f6:	8d 50 01             	lea    0x1(%eax),%edx
    22f9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22fc:	89 c2                	mov    %eax,%edx
    22fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2301:	01 d0                	add    %edx,%eax
    2303:	c6 00 00             	movb   $0x0,(%eax)
}
    2306:	90                   	nop
    2307:	c9                   	leave  
    2308:	c3                   	ret    
