
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
      2b:	68 f8 21 00 00       	push   $0x21f8
      30:	6a 01                	push   $0x1
      32:	e8 19 05 00 00       	call   550 <printf>
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
      78:	68 0b 22 00 00       	push   $0x220b
      7d:	6a 01                	push   $0x1
      7f:	e8 cc 04 00 00       	call   550 <printf>
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
      ea:	68 15 22 00 00       	push   $0x2215
      ef:	6a 01                	push   $0x1
      f1:	e8 5a 04 00 00       	call   550 <printf>
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

00000471 <changePosition>:
SYSCALL(changePosition)
     471:	b8 1b 00 00 00       	mov    $0x1b,%eax
     476:	cd 40                	int    $0x40
     478:	c3                   	ret    

00000479 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     479:	55                   	push   %ebp
     47a:	89 e5                	mov    %esp,%ebp
     47c:	83 ec 18             	sub    $0x18,%esp
     47f:	8b 45 0c             	mov    0xc(%ebp),%eax
     482:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     485:	83 ec 04             	sub    $0x4,%esp
     488:	6a 01                	push   $0x1
     48a:	8d 45 f4             	lea    -0xc(%ebp),%eax
     48d:	50                   	push   %eax
     48e:	ff 75 08             	pushl  0x8(%ebp)
     491:	e8 33 ff ff ff       	call   3c9 <write>
     496:	83 c4 10             	add    $0x10,%esp
}
     499:	90                   	nop
     49a:	c9                   	leave  
     49b:	c3                   	ret    

0000049c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     49c:	55                   	push   %ebp
     49d:	89 e5                	mov    %esp,%ebp
     49f:	53                   	push   %ebx
     4a0:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     4a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     4aa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     4ae:	74 17                	je     4c7 <printint+0x2b>
     4b0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     4b4:	79 11                	jns    4c7 <printint+0x2b>
    neg = 1;
     4b6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     4bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     4c0:	f7 d8                	neg    %eax
     4c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4c5:	eb 06                	jmp    4cd <printint+0x31>
  } else {
    x = xx;
     4c7:	8b 45 0c             	mov    0xc(%ebp),%eax
     4ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4d4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     4d7:	8d 41 01             	lea    0x1(%ecx),%eax
     4da:	89 45 f4             	mov    %eax,-0xc(%ebp)
     4dd:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4e3:	ba 00 00 00 00       	mov    $0x0,%edx
     4e8:	f7 f3                	div    %ebx
     4ea:	89 d0                	mov    %edx,%eax
     4ec:	0f b6 80 c4 28 00 00 	movzbl 0x28c4(%eax),%eax
     4f3:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     4f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
     4fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4fd:	ba 00 00 00 00       	mov    $0x0,%edx
     502:	f7 f3                	div    %ebx
     504:	89 45 ec             	mov    %eax,-0x14(%ebp)
     507:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     50b:	75 c7                	jne    4d4 <printint+0x38>
  if(neg)
     50d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     511:	74 2d                	je     540 <printint+0xa4>
    buf[i++] = '-';
     513:	8b 45 f4             	mov    -0xc(%ebp),%eax
     516:	8d 50 01             	lea    0x1(%eax),%edx
     519:	89 55 f4             	mov    %edx,-0xc(%ebp)
     51c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     521:	eb 1d                	jmp    540 <printint+0xa4>
    putc(fd, buf[i]);
     523:	8d 55 dc             	lea    -0x24(%ebp),%edx
     526:	8b 45 f4             	mov    -0xc(%ebp),%eax
     529:	01 d0                	add    %edx,%eax
     52b:	0f b6 00             	movzbl (%eax),%eax
     52e:	0f be c0             	movsbl %al,%eax
     531:	83 ec 08             	sub    $0x8,%esp
     534:	50                   	push   %eax
     535:	ff 75 08             	pushl  0x8(%ebp)
     538:	e8 3c ff ff ff       	call   479 <putc>
     53d:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     540:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     544:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     548:	79 d9                	jns    523 <printint+0x87>
    putc(fd, buf[i]);
}
     54a:	90                   	nop
     54b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     54e:	c9                   	leave  
     54f:	c3                   	ret    

00000550 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     550:	55                   	push   %ebp
     551:	89 e5                	mov    %esp,%ebp
     553:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     556:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     55d:	8d 45 0c             	lea    0xc(%ebp),%eax
     560:	83 c0 04             	add    $0x4,%eax
     563:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     566:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     56d:	e9 59 01 00 00       	jmp    6cb <printf+0x17b>
    c = fmt[i] & 0xff;
     572:	8b 55 0c             	mov    0xc(%ebp),%edx
     575:	8b 45 f0             	mov    -0x10(%ebp),%eax
     578:	01 d0                	add    %edx,%eax
     57a:	0f b6 00             	movzbl (%eax),%eax
     57d:	0f be c0             	movsbl %al,%eax
     580:	25 ff 00 00 00       	and    $0xff,%eax
     585:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     588:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     58c:	75 2c                	jne    5ba <printf+0x6a>
      if(c == '%'){
     58e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     592:	75 0c                	jne    5a0 <printf+0x50>
        state = '%';
     594:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     59b:	e9 27 01 00 00       	jmp    6c7 <printf+0x177>
      } else {
        putc(fd, c);
     5a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a3:	0f be c0             	movsbl %al,%eax
     5a6:	83 ec 08             	sub    $0x8,%esp
     5a9:	50                   	push   %eax
     5aa:	ff 75 08             	pushl  0x8(%ebp)
     5ad:	e8 c7 fe ff ff       	call   479 <putc>
     5b2:	83 c4 10             	add    $0x10,%esp
     5b5:	e9 0d 01 00 00       	jmp    6c7 <printf+0x177>
      }
    } else if(state == '%'){
     5ba:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     5be:	0f 85 03 01 00 00    	jne    6c7 <printf+0x177>
      if(c == 'd'){
     5c4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5c8:	75 1e                	jne    5e8 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5cd:	8b 00                	mov    (%eax),%eax
     5cf:	6a 01                	push   $0x1
     5d1:	6a 0a                	push   $0xa
     5d3:	50                   	push   %eax
     5d4:	ff 75 08             	pushl  0x8(%ebp)
     5d7:	e8 c0 fe ff ff       	call   49c <printint>
     5dc:	83 c4 10             	add    $0x10,%esp
        ap++;
     5df:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5e3:	e9 d8 00 00 00       	jmp    6c0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5e8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5ec:	74 06                	je     5f4 <printf+0xa4>
     5ee:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5f2:	75 1e                	jne    612 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5f7:	8b 00                	mov    (%eax),%eax
     5f9:	6a 00                	push   $0x0
     5fb:	6a 10                	push   $0x10
     5fd:	50                   	push   %eax
     5fe:	ff 75 08             	pushl  0x8(%ebp)
     601:	e8 96 fe ff ff       	call   49c <printint>
     606:	83 c4 10             	add    $0x10,%esp
        ap++;
     609:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     60d:	e9 ae 00 00 00       	jmp    6c0 <printf+0x170>
      } else if(c == 's'){
     612:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     616:	75 43                	jne    65b <printf+0x10b>
        s = (char*)*ap;
     618:	8b 45 e8             	mov    -0x18(%ebp),%eax
     61b:	8b 00                	mov    (%eax),%eax
     61d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     620:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     624:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     628:	75 25                	jne    64f <printf+0xff>
          s = "(null)";
     62a:	c7 45 f4 1b 22 00 00 	movl   $0x221b,-0xc(%ebp)
        while(*s != 0){
     631:	eb 1c                	jmp    64f <printf+0xff>
          putc(fd, *s);
     633:	8b 45 f4             	mov    -0xc(%ebp),%eax
     636:	0f b6 00             	movzbl (%eax),%eax
     639:	0f be c0             	movsbl %al,%eax
     63c:	83 ec 08             	sub    $0x8,%esp
     63f:	50                   	push   %eax
     640:	ff 75 08             	pushl  0x8(%ebp)
     643:	e8 31 fe ff ff       	call   479 <putc>
     648:	83 c4 10             	add    $0x10,%esp
          s++;
     64b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     64f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     652:	0f b6 00             	movzbl (%eax),%eax
     655:	84 c0                	test   %al,%al
     657:	75 da                	jne    633 <printf+0xe3>
     659:	eb 65                	jmp    6c0 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     65b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     65f:	75 1d                	jne    67e <printf+0x12e>
        putc(fd, *ap);
     661:	8b 45 e8             	mov    -0x18(%ebp),%eax
     664:	8b 00                	mov    (%eax),%eax
     666:	0f be c0             	movsbl %al,%eax
     669:	83 ec 08             	sub    $0x8,%esp
     66c:	50                   	push   %eax
     66d:	ff 75 08             	pushl  0x8(%ebp)
     670:	e8 04 fe ff ff       	call   479 <putc>
     675:	83 c4 10             	add    $0x10,%esp
        ap++;
     678:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     67c:	eb 42                	jmp    6c0 <printf+0x170>
      } else if(c == '%'){
     67e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     682:	75 17                	jne    69b <printf+0x14b>
        putc(fd, c);
     684:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     687:	0f be c0             	movsbl %al,%eax
     68a:	83 ec 08             	sub    $0x8,%esp
     68d:	50                   	push   %eax
     68e:	ff 75 08             	pushl  0x8(%ebp)
     691:	e8 e3 fd ff ff       	call   479 <putc>
     696:	83 c4 10             	add    $0x10,%esp
     699:	eb 25                	jmp    6c0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     69b:	83 ec 08             	sub    $0x8,%esp
     69e:	6a 25                	push   $0x25
     6a0:	ff 75 08             	pushl  0x8(%ebp)
     6a3:	e8 d1 fd ff ff       	call   479 <putc>
     6a8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     6ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6ae:	0f be c0             	movsbl %al,%eax
     6b1:	83 ec 08             	sub    $0x8,%esp
     6b4:	50                   	push   %eax
     6b5:	ff 75 08             	pushl  0x8(%ebp)
     6b8:	e8 bc fd ff ff       	call   479 <putc>
     6bd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     6c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6c7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6cb:	8b 55 0c             	mov    0xc(%ebp),%edx
     6ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6d1:	01 d0                	add    %edx,%eax
     6d3:	0f b6 00             	movzbl (%eax),%eax
     6d6:	84 c0                	test   %al,%al
     6d8:	0f 85 94 fe ff ff    	jne    572 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6de:	90                   	nop
     6df:	c9                   	leave  
     6e0:	c3                   	ret    

000006e1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6e1:	55                   	push   %ebp
     6e2:	89 e5                	mov    %esp,%ebp
     6e4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6e7:	8b 45 08             	mov    0x8(%ebp),%eax
     6ea:	83 e8 08             	sub    $0x8,%eax
     6ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6f0:	a1 f8 28 00 00       	mov    0x28f8,%eax
     6f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6f8:	eb 24                	jmp    71e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fd:	8b 00                	mov    (%eax),%eax
     6ff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     702:	77 12                	ja     716 <free+0x35>
     704:	8b 45 f8             	mov    -0x8(%ebp),%eax
     707:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     70a:	77 24                	ja     730 <free+0x4f>
     70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70f:	8b 00                	mov    (%eax),%eax
     711:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     714:	77 1a                	ja     730 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     716:	8b 45 fc             	mov    -0x4(%ebp),%eax
     719:	8b 00                	mov    (%eax),%eax
     71b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     71e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     721:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     724:	76 d4                	jbe    6fa <free+0x19>
     726:	8b 45 fc             	mov    -0x4(%ebp),%eax
     729:	8b 00                	mov    (%eax),%eax
     72b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     72e:	76 ca                	jbe    6fa <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     730:	8b 45 f8             	mov    -0x8(%ebp),%eax
     733:	8b 40 04             	mov    0x4(%eax),%eax
     736:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     73d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     740:	01 c2                	add    %eax,%edx
     742:	8b 45 fc             	mov    -0x4(%ebp),%eax
     745:	8b 00                	mov    (%eax),%eax
     747:	39 c2                	cmp    %eax,%edx
     749:	75 24                	jne    76f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74e:	8b 50 04             	mov    0x4(%eax),%edx
     751:	8b 45 fc             	mov    -0x4(%ebp),%eax
     754:	8b 00                	mov    (%eax),%eax
     756:	8b 40 04             	mov    0x4(%eax),%eax
     759:	01 c2                	add    %eax,%edx
     75b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     75e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     761:	8b 45 fc             	mov    -0x4(%ebp),%eax
     764:	8b 00                	mov    (%eax),%eax
     766:	8b 10                	mov    (%eax),%edx
     768:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76b:	89 10                	mov    %edx,(%eax)
     76d:	eb 0a                	jmp    779 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     772:	8b 10                	mov    (%eax),%edx
     774:	8b 45 f8             	mov    -0x8(%ebp),%eax
     777:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     779:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77c:	8b 40 04             	mov    0x4(%eax),%eax
     77f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     786:	8b 45 fc             	mov    -0x4(%ebp),%eax
     789:	01 d0                	add    %edx,%eax
     78b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     78e:	75 20                	jne    7b0 <free+0xcf>
    p->s.size += bp->s.size;
     790:	8b 45 fc             	mov    -0x4(%ebp),%eax
     793:	8b 50 04             	mov    0x4(%eax),%edx
     796:	8b 45 f8             	mov    -0x8(%ebp),%eax
     799:	8b 40 04             	mov    0x4(%eax),%eax
     79c:	01 c2                	add    %eax,%edx
     79e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     7a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a7:	8b 10                	mov    (%eax),%edx
     7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7ac:	89 10                	mov    %edx,(%eax)
     7ae:	eb 08                	jmp    7b8 <free+0xd7>
  } else
    p->s.ptr = bp;
     7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7b6:	89 10                	mov    %edx,(%eax)
  freep = p;
     7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7bb:	a3 f8 28 00 00       	mov    %eax,0x28f8
}
     7c0:	90                   	nop
     7c1:	c9                   	leave  
     7c2:	c3                   	ret    

000007c3 <morecore>:

static Header*
morecore(uint nu)
{
     7c3:	55                   	push   %ebp
     7c4:	89 e5                	mov    %esp,%ebp
     7c6:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7c9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7d0:	77 07                	ja     7d9 <morecore+0x16>
    nu = 4096;
     7d2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7d9:	8b 45 08             	mov    0x8(%ebp),%eax
     7dc:	c1 e0 03             	shl    $0x3,%eax
     7df:	83 ec 0c             	sub    $0xc,%esp
     7e2:	50                   	push   %eax
     7e3:	e8 49 fc ff ff       	call   431 <sbrk>
     7e8:	83 c4 10             	add    $0x10,%esp
     7eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7ee:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7f2:	75 07                	jne    7fb <morecore+0x38>
    return 0;
     7f4:	b8 00 00 00 00       	mov    $0x0,%eax
     7f9:	eb 26                	jmp    821 <morecore+0x5e>
  hp = (Header*)p;
     7fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     801:	8b 45 f0             	mov    -0x10(%ebp),%eax
     804:	8b 55 08             	mov    0x8(%ebp),%edx
     807:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     80a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     80d:	83 c0 08             	add    $0x8,%eax
     810:	83 ec 0c             	sub    $0xc,%esp
     813:	50                   	push   %eax
     814:	e8 c8 fe ff ff       	call   6e1 <free>
     819:	83 c4 10             	add    $0x10,%esp
  return freep;
     81c:	a1 f8 28 00 00       	mov    0x28f8,%eax
}
     821:	c9                   	leave  
     822:	c3                   	ret    

00000823 <malloc>:

void*
malloc(uint nbytes)
{
     823:	55                   	push   %ebp
     824:	89 e5                	mov    %esp,%ebp
     826:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     829:	8b 45 08             	mov    0x8(%ebp),%eax
     82c:	83 c0 07             	add    $0x7,%eax
     82f:	c1 e8 03             	shr    $0x3,%eax
     832:	83 c0 01             	add    $0x1,%eax
     835:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     838:	a1 f8 28 00 00       	mov    0x28f8,%eax
     83d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     840:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     844:	75 23                	jne    869 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     846:	c7 45 f0 f0 28 00 00 	movl   $0x28f0,-0x10(%ebp)
     84d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     850:	a3 f8 28 00 00       	mov    %eax,0x28f8
     855:	a1 f8 28 00 00       	mov    0x28f8,%eax
     85a:	a3 f0 28 00 00       	mov    %eax,0x28f0
    base.s.size = 0;
     85f:	c7 05 f4 28 00 00 00 	movl   $0x0,0x28f4
     866:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     869:	8b 45 f0             	mov    -0x10(%ebp),%eax
     86c:	8b 00                	mov    (%eax),%eax
     86e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     871:	8b 45 f4             	mov    -0xc(%ebp),%eax
     874:	8b 40 04             	mov    0x4(%eax),%eax
     877:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     87a:	72 4d                	jb     8c9 <malloc+0xa6>
      if(p->s.size == nunits)
     87c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87f:	8b 40 04             	mov    0x4(%eax),%eax
     882:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     885:	75 0c                	jne    893 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     887:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88a:	8b 10                	mov    (%eax),%edx
     88c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     88f:	89 10                	mov    %edx,(%eax)
     891:	eb 26                	jmp    8b9 <malloc+0x96>
      else {
        p->s.size -= nunits;
     893:	8b 45 f4             	mov    -0xc(%ebp),%eax
     896:	8b 40 04             	mov    0x4(%eax),%eax
     899:	2b 45 ec             	sub    -0x14(%ebp),%eax
     89c:	89 c2                	mov    %eax,%edx
     89e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     8a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a7:	8b 40 04             	mov    0x4(%eax),%eax
     8aa:	c1 e0 03             	shl    $0x3,%eax
     8ad:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     8b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     8b6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     8b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8bc:	a3 f8 28 00 00       	mov    %eax,0x28f8
      return (void*)(p + 1);
     8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c4:	83 c0 08             	add    $0x8,%eax
     8c7:	eb 3b                	jmp    904 <malloc+0xe1>
    }
    if(p == freep)
     8c9:	a1 f8 28 00 00       	mov    0x28f8,%eax
     8ce:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8d1:	75 1e                	jne    8f1 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8d3:	83 ec 0c             	sub    $0xc,%esp
     8d6:	ff 75 ec             	pushl  -0x14(%ebp)
     8d9:	e8 e5 fe ff ff       	call   7c3 <morecore>
     8de:	83 c4 10             	add    $0x10,%esp
     8e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8e8:	75 07                	jne    8f1 <malloc+0xce>
        return 0;
     8ea:	b8 00 00 00 00       	mov    $0x0,%eax
     8ef:	eb 13                	jmp    904 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8fa:	8b 00                	mov    (%eax),%eax
     8fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8ff:	e9 6d ff ff ff       	jmp    871 <malloc+0x4e>
}
     904:	c9                   	leave  
     905:	c3                   	ret    

00000906 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     906:	55                   	push   %ebp
     907:	89 e5                	mov    %esp,%ebp
     909:	83 ec 1c             	sub    $0x1c,%esp
     90c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     90f:	8b 55 10             	mov    0x10(%ebp),%edx
     912:	8b 45 14             	mov    0x14(%ebp),%eax
     915:	88 4d ec             	mov    %cl,-0x14(%ebp)
     918:	88 55 e8             	mov    %dl,-0x18(%ebp)
     91b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     91e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     922:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     925:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     929:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     92c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     930:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     933:	8b 45 08             	mov    0x8(%ebp),%eax
     936:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     93a:	66 89 10             	mov    %dx,(%eax)
     93d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     941:	88 50 02             	mov    %dl,0x2(%eax)
}
     944:	8b 45 08             	mov    0x8(%ebp),%eax
     947:	c9                   	leave  
     948:	c2 04 00             	ret    $0x4

0000094b <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     94b:	55                   	push   %ebp
     94c:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     94e:	8b 45 08             	mov    0x8(%ebp),%eax
     951:	2b 45 10             	sub    0x10(%ebp),%eax
     954:	89 c2                	mov    %eax,%edx
     956:	8b 45 08             	mov    0x8(%ebp),%eax
     959:	2b 45 10             	sub    0x10(%ebp),%eax
     95c:	0f af d0             	imul   %eax,%edx
     95f:	8b 45 0c             	mov    0xc(%ebp),%eax
     962:	2b 45 14             	sub    0x14(%ebp),%eax
     965:	89 c1                	mov    %eax,%ecx
     967:	8b 45 0c             	mov    0xc(%ebp),%eax
     96a:	2b 45 14             	sub    0x14(%ebp),%eax
     96d:	0f af c1             	imul   %ecx,%eax
     970:	01 d0                	add    %edx,%eax
}
     972:	5d                   	pop    %ebp
     973:	c3                   	ret    

00000974 <abs_int>:

static inline int abs_int(int x)
{
     974:	55                   	push   %ebp
     975:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     977:	8b 45 08             	mov    0x8(%ebp),%eax
     97a:	99                   	cltd   
     97b:	89 d0                	mov    %edx,%eax
     97d:	33 45 08             	xor    0x8(%ebp),%eax
     980:	29 d0                	sub    %edx,%eax
}
     982:	5d                   	pop    %ebp
     983:	c3                   	ret    

00000984 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     984:	55                   	push   %ebp
     985:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     987:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     98b:	79 07                	jns    994 <APGetIndex+0x10>
        return X_SMALLER;
     98d:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     992:	eb 40                	jmp    9d4 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     994:	8b 45 08             	mov    0x8(%ebp),%eax
     997:	8b 00                	mov    (%eax),%eax
     999:	3b 45 0c             	cmp    0xc(%ebp),%eax
     99c:	7f 07                	jg     9a5 <APGetIndex+0x21>
        return X_BIGGER;
     99e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     9a3:	eb 2f                	jmp    9d4 <APGetIndex+0x50>
    if (y < 0)
     9a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     9a9:	79 07                	jns    9b2 <APGetIndex+0x2e>
        return Y_SMALLER;
     9ab:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     9b0:	eb 22                	jmp    9d4 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     9b2:	8b 45 08             	mov    0x8(%ebp),%eax
     9b5:	8b 40 04             	mov    0x4(%eax),%eax
     9b8:	3b 45 10             	cmp    0x10(%ebp),%eax
     9bb:	7f 07                	jg     9c4 <APGetIndex+0x40>
        return Y_BIGGER;
     9bd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     9c2:	eb 10                	jmp    9d4 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     9c4:	8b 45 08             	mov    0x8(%ebp),%eax
     9c7:	8b 00                	mov    (%eax),%eax
     9c9:	0f af 45 10          	imul   0x10(%ebp),%eax
     9cd:	89 c2                	mov    %eax,%edx
     9cf:	8b 45 0c             	mov    0xc(%ebp),%eax
     9d2:	01 d0                	add    %edx,%eax
}
     9d4:	5d                   	pop    %ebp
     9d5:	c3                   	ret    

000009d6 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     9d6:	55                   	push   %ebp
     9d7:	89 e5                	mov    %esp,%ebp
     9d9:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     9dc:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     9e3:	8b 45 cc             	mov    -0x34(%ebp),%eax
     9e6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     9e9:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     9f0:	83 ec 08             	sub    $0x8,%esp
     9f3:	6a 00                	push   $0x0
     9f5:	ff 75 0c             	pushl  0xc(%ebp)
     9f8:	e8 ec f9 ff ff       	call   3e9 <open>
     9fd:	83 c4 10             	add    $0x10,%esp
     a00:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     a03:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     a07:	79 2e                	jns    a37 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     a09:	83 ec 04             	sub    $0x4,%esp
     a0c:	ff 75 0c             	pushl  0xc(%ebp)
     a0f:	68 22 22 00 00       	push   $0x2222
     a14:	6a 01                	push   $0x1
     a16:	e8 35 fb ff ff       	call   550 <printf>
     a1b:	83 c4 10             	add    $0x10,%esp
        return bmp;
     a1e:	8b 45 08             	mov    0x8(%ebp),%eax
     a21:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a24:	89 10                	mov    %edx,(%eax)
     a26:	8b 55 cc             	mov    -0x34(%ebp),%edx
     a29:	89 50 04             	mov    %edx,0x4(%eax)
     a2c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a2f:	89 50 08             	mov    %edx,0x8(%eax)
     a32:	e9 d2 01 00 00       	jmp    c09 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     a37:	83 ec 04             	sub    $0x4,%esp
     a3a:	6a 0e                	push   $0xe
     a3c:	8d 45 ba             	lea    -0x46(%ebp),%eax
     a3f:	50                   	push   %eax
     a40:	ff 75 ec             	pushl  -0x14(%ebp)
     a43:	e8 79 f9 ff ff       	call   3c1 <read>
     a48:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     a4b:	83 ec 04             	sub    $0x4,%esp
     a4e:	6a 28                	push   $0x28
     a50:	8d 45 92             	lea    -0x6e(%ebp),%eax
     a53:	50                   	push   %eax
     a54:	ff 75 ec             	pushl  -0x14(%ebp)
     a57:	e8 65 f9 ff ff       	call   3c1 <read>
     a5c:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     a5f:	8b 45 96             	mov    -0x6a(%ebp),%eax
     a62:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     a65:	8b 45 9a             	mov    -0x66(%ebp),%eax
     a68:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     a6b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a6e:	8b 45 cc             	mov    -0x34(%ebp),%eax
     a71:	0f af d0             	imul   %eax,%edx
     a74:	89 d0                	mov    %edx,%eax
     a76:	01 c0                	add    %eax,%eax
     a78:	01 d0                	add    %edx,%eax
     a7a:	83 ec 0c             	sub    $0xc,%esp
     a7d:	50                   	push   %eax
     a7e:	e8 a0 fd ff ff       	call   823 <malloc>
     a83:	83 c4 10             	add    $0x10,%esp
     a86:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     a89:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     a8d:	0f b7 c0             	movzwl %ax,%eax
     a90:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     a93:	8b 55 c8             	mov    -0x38(%ebp),%edx
     a96:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a99:	0f af c2             	imul   %edx,%eax
     a9c:	83 c0 1f             	add    $0x1f,%eax
     a9f:	c1 e8 05             	shr    $0x5,%eax
     aa2:	c1 e0 02             	shl    $0x2,%eax
     aa5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     aa8:	8b 55 cc             	mov    -0x34(%ebp),%edx
     aab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     aae:	0f af c2             	imul   %edx,%eax
     ab1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     ab4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ab7:	83 ec 0c             	sub    $0xc,%esp
     aba:	50                   	push   %eax
     abb:	e8 63 fd ff ff       	call   823 <malloc>
     ac0:	83 c4 10             	add    $0x10,%esp
     ac3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ac6:	83 ec 04             	sub    $0x4,%esp
     ac9:	ff 75 e0             	pushl  -0x20(%ebp)
     acc:	ff 75 dc             	pushl  -0x24(%ebp)
     acf:	ff 75 ec             	pushl  -0x14(%ebp)
     ad2:	e8 ea f8 ff ff       	call   3c1 <read>
     ad7:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     ada:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     ade:	66 c1 e8 03          	shr    $0x3,%ax
     ae2:	0f b7 c0             	movzwl %ax,%eax
     ae5:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     ae8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aef:	e9 e5 00 00 00       	jmp    bd9 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     af4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afa:	29 c2                	sub    %eax,%edx
     afc:	89 d0                	mov    %edx,%eax
     afe:	8d 50 ff             	lea    -0x1(%eax),%edx
     b01:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b04:	0f af c2             	imul   %edx,%eax
     b07:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     b0a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b11:	e9 b1 00 00 00       	jmp    bc7 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     b16:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b19:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b1f:	01 c8                	add    %ecx,%eax
     b21:	89 c1                	mov    %eax,%ecx
     b23:	89 c8                	mov    %ecx,%eax
     b25:	01 c0                	add    %eax,%eax
     b27:	01 c8                	add    %ecx,%eax
     b29:	01 c2                	add    %eax,%edx
     b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b32:	89 c1                	mov    %eax,%ecx
     b34:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b37:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b3b:	01 c1                	add    %eax,%ecx
     b3d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b40:	01 c8                	add    %ecx,%eax
     b42:	8d 48 ff             	lea    -0x1(%eax),%ecx
     b45:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b48:	01 c8                	add    %ecx,%eax
     b4a:	0f b6 00             	movzbl (%eax),%eax
     b4d:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     b50:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b53:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b56:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b59:	01 c8                	add    %ecx,%eax
     b5b:	89 c1                	mov    %eax,%ecx
     b5d:	89 c8                	mov    %ecx,%eax
     b5f:	01 c0                	add    %eax,%eax
     b61:	01 c8                	add    %ecx,%eax
     b63:	01 c2                	add    %eax,%edx
     b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b68:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     b6c:	89 c1                	mov    %eax,%ecx
     b6e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b71:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     b75:	01 c1                	add    %eax,%ecx
     b77:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b7a:	01 c8                	add    %ecx,%eax
     b7c:	8d 48 fe             	lea    -0x2(%eax),%ecx
     b7f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b82:	01 c8                	add    %ecx,%eax
     b84:	0f b6 00             	movzbl (%eax),%eax
     b87:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     b8a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     b8d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     b90:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b93:	01 c8                	add    %ecx,%eax
     b95:	89 c1                	mov    %eax,%ecx
     b97:	89 c8                	mov    %ecx,%eax
     b99:	01 c0                	add    %eax,%eax
     b9b:	01 c8                	add    %ecx,%eax
     b9d:	01 c2                	add    %eax,%edx
     b9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba2:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ba6:	89 c1                	mov    %eax,%ecx
     ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bab:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     baf:	01 c1                	add    %eax,%ecx
     bb1:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bb4:	01 c8                	add    %ecx,%eax
     bb6:	8d 48 fd             	lea    -0x3(%eax),%ecx
     bb9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bbc:	01 c8                	add    %ecx,%eax
     bbe:	0f b6 00             	movzbl (%eax),%eax
     bc1:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     bc3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bc7:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bcd:	39 c2                	cmp    %eax,%edx
     bcf:	0f 87 41 ff ff ff    	ja     b16 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     bd5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bd9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdf:	39 c2                	cmp    %eax,%edx
     be1:	0f 87 0d ff ff ff    	ja     af4 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     be7:	83 ec 0c             	sub    $0xc,%esp
     bea:	ff 75 ec             	pushl  -0x14(%ebp)
     bed:	e8 df f7 ff ff       	call   3d1 <close>
     bf2:	83 c4 10             	add    $0x10,%esp
    return bmp;
     bf5:	8b 45 08             	mov    0x8(%ebp),%eax
     bf8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bfb:	89 10                	mov    %edx,(%eax)
     bfd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c00:	89 50 04             	mov    %edx,0x4(%eax)
     c03:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c06:	89 50 08             	mov    %edx,0x8(%eax)
}
     c09:	8b 45 08             	mov    0x8(%ebp),%eax
     c0c:	c9                   	leave  
     c0d:	c2 04 00             	ret    $0x4

00000c10 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	53                   	push   %ebx
     c14:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     c17:	83 ec 0c             	sub    $0xc,%esp
     c1a:	6a 1c                	push   $0x1c
     c1c:	e8 02 fc ff ff       	call   823 <malloc>
     c21:	83 c4 10             	add    $0x10,%esp
     c24:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     c31:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     c34:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c37:	6a 0c                	push   $0xc
     c39:	6a 0c                	push   $0xc
     c3b:	6a 0c                	push   $0xc
     c3d:	50                   	push   %eax
     c3e:	e8 c3 fc ff ff       	call   906 <RGB>
     c43:	83 c4 0c             	add    $0xc,%esp
     c46:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     c4a:	66 89 43 13          	mov    %ax,0x13(%ebx)
     c4e:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     c52:	88 43 15             	mov    %al,0x15(%ebx)
     c55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c58:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c5b:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     c5f:	66 89 48 10          	mov    %cx,0x10(%eax)
     c63:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     c67:	88 50 12             	mov    %dl,0x12(%eax)
     c6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c70:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     c74:	66 89 48 08          	mov    %cx,0x8(%eax)
     c78:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     c7c:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     c7f:	8b 45 08             	mov    0x8(%ebp),%eax
     c82:	89 c2                	mov    %eax,%edx
     c84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c87:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     c89:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8c:	89 c2                	mov    %eax,%edx
     c8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c91:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     c94:	8b 55 10             	mov    0x10(%ebp),%edx
     c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c9a:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ca0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ca3:	c9                   	leave  
     ca4:	c3                   	ret    

00000ca5 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     ca5:	55                   	push   %ebp
     ca6:	89 e5                	mov    %esp,%ebp
     ca8:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     cab:	8b 45 0c             	mov    0xc(%ebp),%eax
     cae:	8b 50 08             	mov    0x8(%eax),%edx
     cb1:	89 55 f8             	mov    %edx,-0x8(%ebp)
     cb4:	8b 40 0c             	mov    0xc(%eax),%eax
     cb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     cba:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbd:	8b 55 10             	mov    0x10(%ebp),%edx
     cc0:	89 50 08             	mov    %edx,0x8(%eax)
     cc3:	8b 55 14             	mov    0x14(%ebp),%edx
     cc6:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     cc9:	8b 45 08             	mov    0x8(%ebp),%eax
     ccc:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ccf:	89 10                	mov    %edx,(%eax)
     cd1:	8b 55 fc             	mov    -0x4(%ebp),%edx
     cd4:	89 50 04             	mov    %edx,0x4(%eax)
}
     cd7:	8b 45 08             	mov    0x8(%ebp),%eax
     cda:	c9                   	leave  
     cdb:	c2 04 00             	ret    $0x4

00000cde <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     cde:	55                   	push   %ebp
     cdf:	89 e5                	mov    %esp,%ebp
     ce1:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ce4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ce7:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ceb:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     cef:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     cf3:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     cf6:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf9:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     cfd:	66 89 50 10          	mov    %dx,0x10(%eax)
     d01:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     d05:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     d08:	8b 45 08             	mov    0x8(%ebp),%eax
     d0b:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     d0f:	66 89 10             	mov    %dx,(%eax)
     d12:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     d16:	88 50 02             	mov    %dl,0x2(%eax)
}
     d19:	8b 45 08             	mov    0x8(%ebp),%eax
     d1c:	c9                   	leave  
     d1d:	c2 04 00             	ret    $0x4

00000d20 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     d26:	8b 45 08             	mov    0x8(%ebp),%eax
     d29:	8b 40 0c             	mov    0xc(%eax),%eax
     d2c:	89 c2                	mov    %eax,%edx
     d2e:	c1 ea 1f             	shr    $0x1f,%edx
     d31:	01 d0                	add    %edx,%eax
     d33:	d1 f8                	sar    %eax
     d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     d38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d3b:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     d42:	8b 45 10             	mov    0x10(%ebp),%eax
     d45:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d48:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     d4b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     d4f:	0f 89 98 00 00 00    	jns    ded <APDrawPoint+0xcd>
        i = 0;
     d55:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     d5c:	e9 8c 00 00 00       	jmp    ded <APDrawPoint+0xcd>
    {
        j = x - off;
     d61:	8b 45 0c             	mov    0xc(%ebp),%eax
     d64:	2b 45 f4             	sub    -0xc(%ebp),%eax
     d67:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     d6a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     d6e:	79 69                	jns    dd9 <APDrawPoint+0xb9>
            j = 0;
     d70:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     d77:	eb 60                	jmp    dd9 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     d79:	ff 75 fc             	pushl  -0x4(%ebp)
     d7c:	ff 75 f8             	pushl  -0x8(%ebp)
     d7f:	ff 75 08             	pushl  0x8(%ebp)
     d82:	e8 fd fb ff ff       	call   984 <APGetIndex>
     d87:	83 c4 0c             	add    $0xc,%esp
     d8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     d8d:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     d91:	74 55                	je     de8 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     d93:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     d97:	74 67                	je     e00 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     d99:	ff 75 10             	pushl  0x10(%ebp)
     d9c:	ff 75 0c             	pushl  0xc(%ebp)
     d9f:	ff 75 fc             	pushl  -0x4(%ebp)
     da2:	ff 75 f8             	pushl  -0x8(%ebp)
     da5:	e8 a1 fb ff ff       	call   94b <distance_2>
     daa:	83 c4 10             	add    $0x10,%esp
     dad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     db0:	7f 23                	jg     dd5 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     db2:	8b 45 08             	mov    0x8(%ebp),%eax
     db5:	8b 48 18             	mov    0x18(%eax),%ecx
     db8:	8b 55 ec             	mov    -0x14(%ebp),%edx
     dbb:	89 d0                	mov    %edx,%eax
     dbd:	01 c0                	add    %eax,%eax
     dbf:	01 d0                	add    %edx,%eax
     dc1:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     dc4:	8b 45 08             	mov    0x8(%ebp),%eax
     dc7:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     dcb:	66 89 0a             	mov    %cx,(%edx)
     dce:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     dd2:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     dd5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     dd9:	8b 55 0c             	mov    0xc(%ebp),%edx
     ddc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ddf:	01 d0                	add    %edx,%eax
     de1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     de4:	7d 93                	jge    d79 <APDrawPoint+0x59>
     de6:	eb 01                	jmp    de9 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     de8:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     de9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     ded:	8b 55 10             	mov    0x10(%ebp),%edx
     df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df3:	01 d0                	add    %edx,%eax
     df5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     df8:	0f 8d 63 ff ff ff    	jge    d61 <APDrawPoint+0x41>
     dfe:	eb 01                	jmp    e01 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     e00:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     e01:	c9                   	leave  
     e02:	c3                   	ret    

00000e03 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     e03:	55                   	push   %ebp
     e04:	89 e5                	mov    %esp,%ebp
     e06:	53                   	push   %ebx
     e07:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0d:	3b 45 14             	cmp    0x14(%ebp),%eax
     e10:	0f 85 80 00 00 00    	jne    e96 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     e16:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e1a:	0f 88 9d 02 00 00    	js     10bd <APDrawLine+0x2ba>
     e20:	8b 45 08             	mov    0x8(%ebp),%eax
     e23:	8b 00                	mov    (%eax),%eax
     e25:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e28:	0f 8e 8f 02 00 00    	jle    10bd <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     e2e:	8b 45 10             	mov    0x10(%ebp),%eax
     e31:	3b 45 18             	cmp    0x18(%ebp),%eax
     e34:	7e 12                	jle    e48 <APDrawLine+0x45>
        {
            int tmp = y2;
     e36:	8b 45 18             	mov    0x18(%ebp),%eax
     e39:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
     e3c:	8b 45 10             	mov    0x10(%ebp),%eax
     e3f:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
     e42:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e45:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
     e48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e4c:	79 07                	jns    e55 <APDrawLine+0x52>
     e4e:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
     e55:	8b 45 08             	mov    0x8(%ebp),%eax
     e58:	8b 40 04             	mov    0x4(%eax),%eax
     e5b:	3b 45 18             	cmp    0x18(%ebp),%eax
     e5e:	7d 0c                	jge    e6c <APDrawLine+0x69>
     e60:	8b 45 08             	mov    0x8(%ebp),%eax
     e63:	8b 40 04             	mov    0x4(%eax),%eax
     e66:	83 e8 01             	sub    $0x1,%eax
     e69:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
     e6c:	8b 45 10             	mov    0x10(%ebp),%eax
     e6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e72:	eb 15                	jmp    e89 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
     e74:	ff 75 f4             	pushl  -0xc(%ebp)
     e77:	ff 75 0c             	pushl  0xc(%ebp)
     e7a:	ff 75 08             	pushl  0x8(%ebp)
     e7d:	e8 9e fe ff ff       	call   d20 <APDrawPoint>
     e82:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
     e85:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e8c:	3b 45 18             	cmp    0x18(%ebp),%eax
     e8f:	7e e3                	jle    e74 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
     e91:	e9 2b 02 00 00       	jmp    10c1 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
     e96:	8b 45 10             	mov    0x10(%ebp),%eax
     e99:	3b 45 18             	cmp    0x18(%ebp),%eax
     e9c:	75 7f                	jne    f1d <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
     e9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ea2:	0f 88 18 02 00 00    	js     10c0 <APDrawLine+0x2bd>
     ea8:	8b 45 08             	mov    0x8(%ebp),%eax
     eab:	8b 40 04             	mov    0x4(%eax),%eax
     eae:	3b 45 10             	cmp    0x10(%ebp),%eax
     eb1:	0f 8e 09 02 00 00    	jle    10c0 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
     eb7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eba:	3b 45 14             	cmp    0x14(%ebp),%eax
     ebd:	7e 12                	jle    ed1 <APDrawLine+0xce>
        {
            int tmp = x2;
     ebf:	8b 45 14             	mov    0x14(%ebp),%eax
     ec2:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
     ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec8:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
     ecb:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ece:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
     ed1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ed5:	79 07                	jns    ede <APDrawLine+0xdb>
     ed7:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
     ede:	8b 45 08             	mov    0x8(%ebp),%eax
     ee1:	8b 00                	mov    (%eax),%eax
     ee3:	3b 45 14             	cmp    0x14(%ebp),%eax
     ee6:	7d 0b                	jge    ef3 <APDrawLine+0xf0>
     ee8:	8b 45 08             	mov    0x8(%ebp),%eax
     eeb:	8b 00                	mov    (%eax),%eax
     eed:	83 e8 01             	sub    $0x1,%eax
     ef0:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
     ef3:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ef9:	eb 15                	jmp    f10 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
     efb:	ff 75 10             	pushl  0x10(%ebp)
     efe:	ff 75 f0             	pushl  -0x10(%ebp)
     f01:	ff 75 08             	pushl  0x8(%ebp)
     f04:	e8 17 fe ff ff       	call   d20 <APDrawPoint>
     f09:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
     f0c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f10:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f13:	3b 45 14             	cmp    0x14(%ebp),%eax
     f16:	7e e3                	jle    efb <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
     f18:	e9 a4 01 00 00       	jmp    10c1 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
     f1d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f24:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
     f2b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2e:	2b 45 14             	sub    0x14(%ebp),%eax
     f31:	50                   	push   %eax
     f32:	e8 3d fa ff ff       	call   974 <abs_int>
     f37:	83 c4 04             	add    $0x4,%esp
     f3a:	89 c3                	mov    %eax,%ebx
     f3c:	8b 45 10             	mov    0x10(%ebp),%eax
     f3f:	2b 45 18             	sub    0x18(%ebp),%eax
     f42:	50                   	push   %eax
     f43:	e8 2c fa ff ff       	call   974 <abs_int>
     f48:	83 c4 04             	add    $0x4,%esp
     f4b:	39 c3                	cmp    %eax,%ebx
     f4d:	0f 8e b5 00 00 00    	jle    1008 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
     f53:	8b 45 10             	mov    0x10(%ebp),%eax
     f56:	2b 45 18             	sub    0x18(%ebp),%eax
     f59:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f5c:	db 45 b0             	fildl  -0x50(%ebp)
     f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
     f62:	2b 45 14             	sub    0x14(%ebp),%eax
     f65:	89 45 b0             	mov    %eax,-0x50(%ebp)
     f68:	db 45 b0             	fildl  -0x50(%ebp)
     f6b:	de f9                	fdivrp %st,%st(1)
     f6d:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
     f70:	8b 45 14             	mov    0x14(%ebp),%eax
     f73:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f76:	7e 0e                	jle    f86 <APDrawLine+0x183>
        {
            s = x1;
     f78:	8b 45 0c             	mov    0xc(%ebp),%eax
     f7b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
     f7e:	8b 45 14             	mov    0x14(%ebp),%eax
     f81:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f84:	eb 0c                	jmp    f92 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
     f86:	8b 45 14             	mov    0x14(%ebp),%eax
     f89:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
     f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
     f8f:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
     f92:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     f96:	79 07                	jns    f9f <APDrawLine+0x19c>
     f98:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
     f9f:	8b 45 08             	mov    0x8(%ebp),%eax
     fa2:	8b 00                	mov    (%eax),%eax
     fa4:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     fa7:	7f 0b                	jg     fb4 <APDrawLine+0x1b1>
     fa9:	8b 45 08             	mov    0x8(%ebp),%eax
     fac:	8b 00                	mov    (%eax),%eax
     fae:	83 e8 01             	sub    $0x1,%eax
     fb1:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
     fb4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fb7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     fba:	eb 3f                	jmp    ffb <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
     fbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     fbf:	2b 45 0c             	sub    0xc(%ebp),%eax
     fc2:	89 45 b0             	mov    %eax,-0x50(%ebp)
     fc5:	db 45 b0             	fildl  -0x50(%ebp)
     fc8:	dc 4d d0             	fmull  -0x30(%ebp)
     fcb:	db 45 10             	fildl  0x10(%ebp)
     fce:	de c1                	faddp  %st,%st(1)
     fd0:	d9 7d b6             	fnstcw -0x4a(%ebp)
     fd3:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
     fd7:	b4 0c                	mov    $0xc,%ah
     fd9:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
     fdd:	d9 6d b4             	fldcw  -0x4c(%ebp)
     fe0:	db 5d cc             	fistpl -0x34(%ebp)
     fe3:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
     fe6:	ff 75 cc             	pushl  -0x34(%ebp)
     fe9:	ff 75 e4             	pushl  -0x1c(%ebp)
     fec:	ff 75 08             	pushl  0x8(%ebp)
     fef:	e8 2c fd ff ff       	call   d20 <APDrawPoint>
     ff4:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
     ff7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     ffb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ffe:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1001:	7e b9                	jle    fbc <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1003:	e9 b9 00 00 00       	jmp    10c1 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1008:	8b 45 0c             	mov    0xc(%ebp),%eax
    100b:	2b 45 14             	sub    0x14(%ebp),%eax
    100e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1011:	db 45 b0             	fildl  -0x50(%ebp)
    1014:	8b 45 10             	mov    0x10(%ebp),%eax
    1017:	2b 45 18             	sub    0x18(%ebp),%eax
    101a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    101d:	db 45 b0             	fildl  -0x50(%ebp)
    1020:	de f9                	fdivrp %st,%st(1)
    1022:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1025:	8b 45 10             	mov    0x10(%ebp),%eax
    1028:	3b 45 18             	cmp    0x18(%ebp),%eax
    102b:	7e 0e                	jle    103b <APDrawLine+0x238>
    {
        s = y2;
    102d:	8b 45 18             	mov    0x18(%ebp),%eax
    1030:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1033:	8b 45 10             	mov    0x10(%ebp),%eax
    1036:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1039:	eb 0c                	jmp    1047 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    103b:	8b 45 10             	mov    0x10(%ebp),%eax
    103e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1041:	8b 45 18             	mov    0x18(%ebp),%eax
    1044:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1047:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    104b:	79 07                	jns    1054 <APDrawLine+0x251>
    104d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1054:	8b 45 08             	mov    0x8(%ebp),%eax
    1057:	8b 40 04             	mov    0x4(%eax),%eax
    105a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    105d:	7f 0c                	jg     106b <APDrawLine+0x268>
    105f:	8b 45 08             	mov    0x8(%ebp),%eax
    1062:	8b 40 04             	mov    0x4(%eax),%eax
    1065:	83 e8 01             	sub    $0x1,%eax
    1068:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    106b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    106e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1071:	eb 3f                	jmp    10b2 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1073:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1076:	2b 45 10             	sub    0x10(%ebp),%eax
    1079:	89 45 b0             	mov    %eax,-0x50(%ebp)
    107c:	db 45 b0             	fildl  -0x50(%ebp)
    107f:	dc 4d c0             	fmull  -0x40(%ebp)
    1082:	db 45 0c             	fildl  0xc(%ebp)
    1085:	de c1                	faddp  %st,%st(1)
    1087:	d9 7d b6             	fnstcw -0x4a(%ebp)
    108a:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    108e:	b4 0c                	mov    $0xc,%ah
    1090:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1094:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1097:	db 5d bc             	fistpl -0x44(%ebp)
    109a:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    109d:	ff 75 e0             	pushl  -0x20(%ebp)
    10a0:	ff 75 bc             	pushl  -0x44(%ebp)
    10a3:	ff 75 08             	pushl  0x8(%ebp)
    10a6:	e8 75 fc ff ff       	call   d20 <APDrawPoint>
    10ab:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    10ae:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    10b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    10b5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    10b8:	7e b9                	jle    1073 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    10ba:	90                   	nop
    10bb:	eb 04                	jmp    10c1 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    10bd:	90                   	nop
    10be:	eb 01                	jmp    10c1 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    10c0:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    10c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10c4:	c9                   	leave  
    10c5:	c3                   	ret    

000010c6 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    10c6:	55                   	push   %ebp
    10c7:	89 e5                	mov    %esp,%ebp
    10c9:	53                   	push   %ebx
    10ca:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    10cd:	8b 55 10             	mov    0x10(%ebp),%edx
    10d0:	8b 45 18             	mov    0x18(%ebp),%eax
    10d3:	01 d0                	add    %edx,%eax
    10d5:	83 e8 01             	sub    $0x1,%eax
    10d8:	83 ec 04             	sub    $0x4,%esp
    10db:	50                   	push   %eax
    10dc:	ff 75 0c             	pushl  0xc(%ebp)
    10df:	ff 75 10             	pushl  0x10(%ebp)
    10e2:	ff 75 0c             	pushl  0xc(%ebp)
    10e5:	ff 75 08             	pushl  0x8(%ebp)
    10e8:	e8 16 fd ff ff       	call   e03 <APDrawLine>
    10ed:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    10f0:	8b 55 0c             	mov    0xc(%ebp),%edx
    10f3:	8b 45 14             	mov    0x14(%ebp),%eax
    10f6:	01 d0                	add    %edx,%eax
    10f8:	83 e8 01             	sub    $0x1,%eax
    10fb:	83 ec 04             	sub    $0x4,%esp
    10fe:	ff 75 10             	pushl  0x10(%ebp)
    1101:	50                   	push   %eax
    1102:	ff 75 10             	pushl  0x10(%ebp)
    1105:	ff 75 0c             	pushl  0xc(%ebp)
    1108:	ff 75 08             	pushl  0x8(%ebp)
    110b:	e8 f3 fc ff ff       	call   e03 <APDrawLine>
    1110:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1113:	8b 55 10             	mov    0x10(%ebp),%edx
    1116:	8b 45 18             	mov    0x18(%ebp),%eax
    1119:	01 d0                	add    %edx,%eax
    111b:	8d 48 ff             	lea    -0x1(%eax),%ecx
    111e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1121:	8b 45 14             	mov    0x14(%ebp),%eax
    1124:	01 d0                	add    %edx,%eax
    1126:	8d 50 ff             	lea    -0x1(%eax),%edx
    1129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    112c:	8b 45 14             	mov    0x14(%ebp),%eax
    112f:	01 d8                	add    %ebx,%eax
    1131:	83 e8 01             	sub    $0x1,%eax
    1134:	83 ec 04             	sub    $0x4,%esp
    1137:	51                   	push   %ecx
    1138:	52                   	push   %edx
    1139:	ff 75 10             	pushl  0x10(%ebp)
    113c:	50                   	push   %eax
    113d:	ff 75 08             	pushl  0x8(%ebp)
    1140:	e8 be fc ff ff       	call   e03 <APDrawLine>
    1145:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1148:	8b 55 10             	mov    0x10(%ebp),%edx
    114b:	8b 45 18             	mov    0x18(%ebp),%eax
    114e:	01 d0                	add    %edx,%eax
    1150:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1153:	8b 55 0c             	mov    0xc(%ebp),%edx
    1156:	8b 45 14             	mov    0x14(%ebp),%eax
    1159:	01 d0                	add    %edx,%eax
    115b:	8d 50 ff             	lea    -0x1(%eax),%edx
    115e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1161:	8b 45 18             	mov    0x18(%ebp),%eax
    1164:	01 d8                	add    %ebx,%eax
    1166:	83 e8 01             	sub    $0x1,%eax
    1169:	83 ec 04             	sub    $0x4,%esp
    116c:	51                   	push   %ecx
    116d:	52                   	push   %edx
    116e:	50                   	push   %eax
    116f:	ff 75 0c             	pushl  0xc(%ebp)
    1172:	ff 75 08             	pushl  0x8(%ebp)
    1175:	e8 89 fc ff ff       	call   e03 <APDrawLine>
    117a:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    117d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1180:	8b 45 14             	mov    0x14(%ebp),%eax
    1183:	01 d0                	add    %edx,%eax
    1185:	8d 50 ff             	lea    -0x1(%eax),%edx
    1188:	8b 45 08             	mov    0x8(%ebp),%eax
    118b:	8b 40 0c             	mov    0xc(%eax),%eax
    118e:	89 c1                	mov    %eax,%ecx
    1190:	c1 e9 1f             	shr    $0x1f,%ecx
    1193:	01 c8                	add    %ecx,%eax
    1195:	d1 f8                	sar    %eax
    1197:	29 c2                	sub    %eax,%edx
    1199:	89 d0                	mov    %edx,%eax
    119b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    119e:	8b 55 10             	mov    0x10(%ebp),%edx
    11a1:	8b 45 18             	mov    0x18(%ebp),%eax
    11a4:	01 d0                	add    %edx,%eax
    11a6:	8d 50 ff             	lea    -0x1(%eax),%edx
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
    11ac:	8b 40 0c             	mov    0xc(%eax),%eax
    11af:	89 c1                	mov    %eax,%ecx
    11b1:	c1 e9 1f             	shr    $0x1f,%ecx
    11b4:	01 c8                	add    %ecx,%eax
    11b6:	d1 f8                	sar    %eax
    11b8:	29 c2                	sub    %eax,%edx
    11ba:	89 d0                	mov    %edx,%eax
    11bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    11bf:	8b 45 08             	mov    0x8(%ebp),%eax
    11c2:	8b 40 0c             	mov    0xc(%eax),%eax
    11c5:	89 c2                	mov    %eax,%edx
    11c7:	c1 ea 1f             	shr    $0x1f,%edx
    11ca:	01 d0                	add    %edx,%eax
    11cc:	d1 f8                	sar    %eax
    11ce:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    11d1:	8b 45 08             	mov    0x8(%ebp),%eax
    11d4:	8b 40 0c             	mov    0xc(%eax),%eax
    11d7:	89 c2                	mov    %eax,%edx
    11d9:	c1 ea 1f             	shr    $0x1f,%edx
    11dc:	01 d0                	add    %edx,%eax
    11de:	d1 f8                	sar    %eax
    11e0:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    11e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11e7:	0f 88 d8 00 00 00    	js     12c5 <APDrawRect+0x1ff>
    11ed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11f1:	0f 88 ce 00 00 00    	js     12c5 <APDrawRect+0x1ff>
    11f7:	8b 45 08             	mov    0x8(%ebp),%eax
    11fa:	8b 00                	mov    (%eax),%eax
    11fc:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11ff:	0f 8e c0 00 00 00    	jle    12c5 <APDrawRect+0x1ff>
    1205:	8b 45 08             	mov    0x8(%ebp),%eax
    1208:	8b 40 04             	mov    0x4(%eax),%eax
    120b:	3b 45 10             	cmp    0x10(%ebp),%eax
    120e:	0f 8e b1 00 00 00    	jle    12c5 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1214:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1218:	79 07                	jns    1221 <APDrawRect+0x15b>
    121a:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1221:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1225:	79 07                	jns    122e <APDrawRect+0x168>
    1227:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    122e:	8b 45 08             	mov    0x8(%ebp),%eax
    1231:	8b 00                	mov    (%eax),%eax
    1233:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1236:	7f 0b                	jg     1243 <APDrawRect+0x17d>
    1238:	8b 45 08             	mov    0x8(%ebp),%eax
    123b:	8b 00                	mov    (%eax),%eax
    123d:	83 e8 01             	sub    $0x1,%eax
    1240:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1243:	8b 45 08             	mov    0x8(%ebp),%eax
    1246:	8b 40 04             	mov    0x4(%eax),%eax
    1249:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    124c:	7f 0c                	jg     125a <APDrawRect+0x194>
    124e:	8b 45 08             	mov    0x8(%ebp),%eax
    1251:	8b 40 04             	mov    0x4(%eax),%eax
    1254:	83 e8 01             	sub    $0x1,%eax
    1257:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    125a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1261:	8b 45 0c             	mov    0xc(%ebp),%eax
    1264:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1267:	eb 52                	jmp    12bb <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1269:	8b 45 10             	mov    0x10(%ebp),%eax
    126c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    126f:	eb 3e                	jmp    12af <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1271:	83 ec 04             	sub    $0x4,%esp
    1274:	ff 75 e8             	pushl  -0x18(%ebp)
    1277:	ff 75 ec             	pushl  -0x14(%ebp)
    127a:	ff 75 08             	pushl  0x8(%ebp)
    127d:	e8 02 f7 ff ff       	call   984 <APGetIndex>
    1282:	83 c4 10             	add    $0x10,%esp
    1285:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1288:	8b 45 08             	mov    0x8(%ebp),%eax
    128b:	8b 48 18             	mov    0x18(%eax),%ecx
    128e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1291:	89 d0                	mov    %edx,%eax
    1293:	01 c0                	add    %eax,%eax
    1295:	01 d0                	add    %edx,%eax
    1297:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    129a:	8b 45 08             	mov    0x8(%ebp),%eax
    129d:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    12a1:	66 89 0a             	mov    %cx,(%edx)
    12a4:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    12a8:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    12ab:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12af:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12b2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    12b5:	7e ba                	jle    1271 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    12b7:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    12bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    12c1:	7e a6                	jle    1269 <APDrawRect+0x1a3>
    12c3:	eb 01                	jmp    12c6 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    12c5:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    12c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12c9:	c9                   	leave  
    12ca:	c3                   	ret    

000012cb <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    12cb:	55                   	push   %ebp
    12cc:	89 e5                	mov    %esp,%ebp
    12ce:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    12d1:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    12d5:	0f 88 8e 01 00 00    	js     1469 <APDcCopy+0x19e>
    12db:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    12df:	0f 88 84 01 00 00    	js     1469 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    12e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    12e8:	8b 45 20             	mov    0x20(%ebp),%eax
    12eb:	01 d0                	add    %edx,%eax
    12ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
    12f0:	8b 55 10             	mov    0x10(%ebp),%edx
    12f3:	8b 45 24             	mov    0x24(%ebp),%eax
    12f6:	01 d0                	add    %edx,%eax
    12f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    12fb:	8b 55 18             	mov    0x18(%ebp),%edx
    12fe:	8b 45 20             	mov    0x20(%ebp),%eax
    1301:	01 d0                	add    %edx,%eax
    1303:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1306:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1309:	8b 45 24             	mov    0x24(%ebp),%eax
    130c:	01 d0                	add    %edx,%eax
    130e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1311:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1315:	0f 88 51 01 00 00    	js     146c <APDcCopy+0x1a1>
    131b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    131f:	0f 88 47 01 00 00    	js     146c <APDcCopy+0x1a1>
    1325:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1329:	0f 88 3d 01 00 00    	js     146c <APDcCopy+0x1a1>
    132f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1333:	0f 88 33 01 00 00    	js     146c <APDcCopy+0x1a1>
    1339:	8b 45 14             	mov    0x14(%ebp),%eax
    133c:	8b 00                	mov    (%eax),%eax
    133e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1341:	0f 8c 25 01 00 00    	jl     146c <APDcCopy+0x1a1>
    1347:	8b 45 14             	mov    0x14(%ebp),%eax
    134a:	8b 40 04             	mov    0x4(%eax),%eax
    134d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1350:	0f 8c 16 01 00 00    	jl     146c <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1356:	8b 45 08             	mov    0x8(%ebp),%eax
    1359:	8b 00                	mov    (%eax),%eax
    135b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    135e:	7f 0b                	jg     136b <APDcCopy+0xa0>
    1360:	8b 45 08             	mov    0x8(%ebp),%eax
    1363:	8b 00                	mov    (%eax),%eax
    1365:	83 e8 01             	sub    $0x1,%eax
    1368:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    136b:	8b 45 08             	mov    0x8(%ebp),%eax
    136e:	8b 40 04             	mov    0x4(%eax),%eax
    1371:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1374:	7f 0c                	jg     1382 <APDcCopy+0xb7>
    1376:	8b 45 08             	mov    0x8(%ebp),%eax
    1379:	8b 40 04             	mov    0x4(%eax),%eax
    137c:	83 e8 01             	sub    $0x1,%eax
    137f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1382:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1389:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1390:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1397:	e9 bc 00 00 00       	jmp    1458 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    139c:	8b 45 08             	mov    0x8(%ebp),%eax
    139f:	8b 00                	mov    (%eax),%eax
    13a1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13a4:	8b 55 10             	mov    0x10(%ebp),%edx
    13a7:	01 ca                	add    %ecx,%edx
    13a9:	0f af d0             	imul   %eax,%edx
    13ac:	8b 45 0c             	mov    0xc(%ebp),%eax
    13af:	01 d0                	add    %edx,%eax
    13b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    13b4:	8b 45 14             	mov    0x14(%ebp),%eax
    13b7:	8b 00                	mov    (%eax),%eax
    13b9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13bc:	8b 55 1c             	mov    0x1c(%ebp),%edx
    13bf:	01 ca                	add    %ecx,%edx
    13c1:	0f af d0             	imul   %eax,%edx
    13c4:	8b 45 18             	mov    0x18(%ebp),%eax
    13c7:	01 d0                	add    %edx,%eax
    13c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    13cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13d3:	eb 74                	jmp    1449 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    13d5:	8b 45 14             	mov    0x14(%ebp),%eax
    13d8:	8b 50 18             	mov    0x18(%eax),%edx
    13db:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    13de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13e1:	01 c8                	add    %ecx,%eax
    13e3:	89 c1                	mov    %eax,%ecx
    13e5:	89 c8                	mov    %ecx,%eax
    13e7:	01 c0                	add    %eax,%eax
    13e9:	01 c8                	add    %ecx,%eax
    13eb:	01 d0                	add    %edx,%eax
    13ed:	0f b7 10             	movzwl (%eax),%edx
    13f0:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    13f4:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    13f8:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    13fb:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    13ff:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1403:	38 c2                	cmp    %al,%dl
    1405:	75 18                	jne    141f <APDcCopy+0x154>
    1407:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    140b:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    140f:	38 c2                	cmp    %al,%dl
    1411:	75 0c                	jne    141f <APDcCopy+0x154>
    1413:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1417:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    141b:	38 c2                	cmp    %al,%dl
    141d:	74 26                	je     1445 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    141f:	8b 45 08             	mov    0x8(%ebp),%eax
    1422:	8b 50 18             	mov    0x18(%eax),%edx
    1425:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1428:	8b 45 f0             	mov    -0x10(%ebp),%eax
    142b:	01 c8                	add    %ecx,%eax
    142d:	89 c1                	mov    %eax,%ecx
    142f:	89 c8                	mov    %ecx,%eax
    1431:	01 c0                	add    %eax,%eax
    1433:	01 c8                	add    %ecx,%eax
    1435:	01 d0                	add    %edx,%eax
    1437:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    143b:	66 89 10             	mov    %dx,(%eax)
    143e:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1442:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1445:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1449:	8b 45 fc             	mov    -0x4(%ebp),%eax
    144c:	2b 45 0c             	sub    0xc(%ebp),%eax
    144f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1452:	7d 81                	jge    13d5 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1454:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1458:	8b 45 f8             	mov    -0x8(%ebp),%eax
    145b:	2b 45 10             	sub    0x10(%ebp),%eax
    145e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1461:	0f 8d 35 ff ff ff    	jge    139c <APDcCopy+0xd1>
    1467:	eb 04                	jmp    146d <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1469:	90                   	nop
    146a:	eb 01                	jmp    146d <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    146c:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    146d:	c9                   	leave  
    146e:	c3                   	ret    

0000146f <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    146f:	55                   	push   %ebp
    1470:	89 e5                	mov    %esp,%ebp
    1472:	83 ec 1c             	sub    $0x1c,%esp
    1475:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1478:	8b 55 10             	mov    0x10(%ebp),%edx
    147b:	8b 45 14             	mov    0x14(%ebp),%eax
    147e:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1481:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1484:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1487:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    148b:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    148e:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1492:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1495:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1499:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
    149f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    14a3:	66 89 10             	mov    %dx,(%eax)
    14a6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    14aa:	88 50 02             	mov    %dl,0x2(%eax)
}
    14ad:	8b 45 08             	mov    0x8(%ebp),%eax
    14b0:	c9                   	leave  
    14b1:	c2 04 00             	ret    $0x4

000014b4 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    14b4:	55                   	push   %ebp
    14b5:	89 e5                	mov    %esp,%ebp
    14b7:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    14ba:	8b 45 08             	mov    0x8(%ebp),%eax
    14bd:	8b 00                	mov    (%eax),%eax
    14bf:	83 ec 08             	sub    $0x8,%esp
    14c2:	8d 55 0c             	lea    0xc(%ebp),%edx
    14c5:	52                   	push   %edx
    14c6:	50                   	push   %eax
    14c7:	e8 8d ef ff ff       	call   459 <sendMessage>
    14cc:	83 c4 10             	add    $0x10,%esp
}
    14cf:	90                   	nop
    14d0:	c9                   	leave  
    14d1:	c3                   	ret    

000014d2 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    14d2:	55                   	push   %ebp
    14d3:	89 e5                	mov    %esp,%ebp
    14d5:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    14d8:	83 ec 0c             	sub    $0xc,%esp
    14db:	68 90 00 00 00       	push   $0x90
    14e0:	e8 3e f3 ff ff       	call   823 <malloc>
    14e5:	83 c4 10             	add    $0x10,%esp
    14e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    14eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14ef:	75 15                	jne    1506 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    14f1:	83 ec 04             	sub    $0x4,%esp
    14f4:	ff 75 08             	pushl  0x8(%ebp)
    14f7:	68 34 22 00 00       	push   $0x2234
    14fc:	6a 01                	push   $0x1
    14fe:	e8 4d f0 ff ff       	call   550 <printf>
    1503:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1506:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1509:	83 c0 7c             	add    $0x7c,%eax
    150c:	83 ec 08             	sub    $0x8,%esp
    150f:	ff 75 08             	pushl  0x8(%ebp)
    1512:	50                   	push   %eax
    1513:	e8 60 ec ff ff       	call   178 <strcpy>
    1518:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    151b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151e:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1525:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1528:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1532:	8b 40 34             	mov    0x34(%eax),%eax
    1535:	89 c2                	mov    %eax,%edx
    1537:	8b 45 f4             	mov    -0xc(%ebp),%eax
    153a:	8b 40 38             	mov    0x38(%eax),%eax
    153d:	0f af d0             	imul   %eax,%edx
    1540:	89 d0                	mov    %edx,%eax
    1542:	01 c0                	add    %eax,%eax
    1544:	01 d0                	add    %edx,%eax
    1546:	83 ec 0c             	sub    $0xc,%esp
    1549:	50                   	push   %eax
    154a:	e8 d4 f2 ff ff       	call   823 <malloc>
    154f:	83 c4 10             	add    $0x10,%esp
    1552:	89 c2                	mov    %eax,%edx
    1554:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1557:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    155a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    155d:	8b 40 4c             	mov    0x4c(%eax),%eax
    1560:	85 c0                	test   %eax,%eax
    1562:	75 15                	jne    1579 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1564:	83 ec 04             	sub    $0x4,%esp
    1567:	ff 75 08             	pushl  0x8(%ebp)
    156a:	68 54 22 00 00       	push   $0x2254
    156f:	6a 01                	push   $0x1
    1571:	e8 da ef ff ff       	call   550 <printf>
    1576:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1579:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157c:	8b 40 34             	mov    0x34(%eax),%eax
    157f:	89 c2                	mov    %eax,%edx
    1581:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1584:	8b 40 38             	mov    0x38(%eax),%eax
    1587:	0f af d0             	imul   %eax,%edx
    158a:	89 d0                	mov    %edx,%eax
    158c:	01 c0                	add    %eax,%eax
    158e:	01 c2                	add    %eax,%edx
    1590:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1593:	8b 40 4c             	mov    0x4c(%eax),%eax
    1596:	83 ec 04             	sub    $0x4,%esp
    1599:	52                   	push   %edx
    159a:	68 ff ff ff 00       	push   $0xffffff
    159f:	50                   	push   %eax
    15a0:	e8 69 ec ff ff       	call   20e <memset>
    15a5:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    15a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ab:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    15b2:	e8 72 ee ff ff       	call   429 <getpid>
    15b7:	89 c2                	mov    %eax,%edx
    15b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bc:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    15bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15c2:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    15c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15cc:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    15d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15d6:	8b 40 50             	mov    0x50(%eax),%eax
    15d9:	89 c2                	mov    %eax,%edx
    15db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15de:	8b 40 54             	mov    0x54(%eax),%eax
    15e1:	0f af d0             	imul   %eax,%edx
    15e4:	89 d0                	mov    %edx,%eax
    15e6:	01 c0                	add    %eax,%eax
    15e8:	01 d0                	add    %edx,%eax
    15ea:	83 ec 0c             	sub    $0xc,%esp
    15ed:	50                   	push   %eax
    15ee:	e8 30 f2 ff ff       	call   823 <malloc>
    15f3:	83 c4 10             	add    $0x10,%esp
    15f6:	89 c2                	mov    %eax,%edx
    15f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15fb:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    15fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1601:	8b 40 68             	mov    0x68(%eax),%eax
    1604:	85 c0                	test   %eax,%eax
    1606:	75 15                	jne    161d <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1608:	83 ec 04             	sub    $0x4,%esp
    160b:	ff 75 08             	pushl  0x8(%ebp)
    160e:	68 78 22 00 00       	push   $0x2278
    1613:	6a 01                	push   $0x1
    1615:	e8 36 ef ff ff       	call   550 <printf>
    161a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    161d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1620:	8b 40 34             	mov    0x34(%eax),%eax
    1623:	89 c2                	mov    %eax,%edx
    1625:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1628:	8b 40 38             	mov    0x38(%eax),%eax
    162b:	0f af d0             	imul   %eax,%edx
    162e:	89 d0                	mov    %edx,%eax
    1630:	01 c0                	add    %eax,%eax
    1632:	01 c2                	add    %eax,%edx
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	8b 40 4c             	mov    0x4c(%eax),%eax
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
    1659:	74 35                	je     1690 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    165b:	8b 45 10             	mov    0x10(%ebp),%eax
    165e:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1664:	83 ec 0c             	sub    $0xc,%esp
    1667:	50                   	push   %eax
    1668:	e8 b6 f1 ff ff       	call   823 <malloc>
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
    168b:	e9 8d 00 00 00       	jmp    171d <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1690:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1693:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    169a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    169d:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a7:	8b 40 18             	mov    0x18(%eax),%eax
    16aa:	89 c2                	mov    %eax,%edx
    16ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16af:	8b 40 1c             	mov    0x1c(%eax),%eax
    16b2:	0f af d0             	imul   %eax,%edx
    16b5:	89 d0                	mov    %edx,%eax
    16b7:	01 c0                	add    %eax,%eax
    16b9:	01 d0                	add    %edx,%eax
    16bb:	83 ec 0c             	sub    $0xc,%esp
    16be:	50                   	push   %eax
    16bf:	e8 5f f1 ff ff       	call   823 <malloc>
    16c4:	83 c4 10             	add    $0x10,%esp
    16c7:	89 c2                	mov    %eax,%edx
    16c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16cc:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    16cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d2:	8b 40 30             	mov    0x30(%eax),%eax
    16d5:	85 c0                	test   %eax,%eax
    16d7:	75 15                	jne    16ee <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    16d9:	83 ec 04             	sub    $0x4,%esp
    16dc:	ff 75 08             	pushl  0x8(%ebp)
    16df:	68 a0 22 00 00       	push   $0x22a0
    16e4:	6a 01                	push   $0x1
    16e6:	e8 65 ee ff ff       	call   550 <printf>
    16eb:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    16ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f1:	8b 40 18             	mov    0x18(%eax),%eax
    16f4:	89 c2                	mov    %eax,%edx
    16f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f9:	8b 40 1c             	mov    0x1c(%eax),%eax
    16fc:	0f af d0             	imul   %eax,%edx
    16ff:	89 d0                	mov    %edx,%eax
    1701:	01 c0                	add    %eax,%eax
    1703:	01 c2                	add    %eax,%edx
    1705:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1708:	8b 40 30             	mov    0x30(%eax),%eax
    170b:	83 ec 04             	sub    $0x4,%esp
    170e:	52                   	push   %edx
    170f:	68 ff ff ff 00       	push   $0xffffff
    1714:	50                   	push   %eax
    1715:	e8 f4 ea ff ff       	call   20e <memset>
    171a:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    171d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1720:	c9                   	leave  
    1721:	c3                   	ret    

00001722 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1722:	55                   	push   %ebp
    1723:	89 e5                	mov    %esp,%ebp
    1725:	53                   	push   %ebx
    1726:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1729:	8b 45 0c             	mov    0xc(%ebp),%eax
    172c:	83 f8 03             	cmp    $0x3,%eax
    172f:	74 02                	je     1733 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1731:	eb 33                	jmp    1766 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1733:	8b 45 08             	mov    0x8(%ebp),%eax
    1736:	8b 48 08             	mov    0x8(%eax),%ecx
    1739:	8b 45 08             	mov    0x8(%ebp),%eax
    173c:	8b 50 38             	mov    0x38(%eax),%edx
    173f:	8b 45 08             	mov    0x8(%ebp),%eax
    1742:	8b 40 34             	mov    0x34(%eax),%eax
    1745:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1748:	83 c3 34             	add    $0x34,%ebx
    174b:	83 ec 0c             	sub    $0xc,%esp
    174e:	51                   	push   %ecx
    174f:	52                   	push   %edx
    1750:	50                   	push   %eax
    1751:	6a 00                	push   $0x0
    1753:	6a 00                	push   $0x0
    1755:	53                   	push   %ebx
    1756:	6a 32                	push   $0x32
    1758:	6a 00                	push   $0x0
    175a:	ff 75 08             	pushl  0x8(%ebp)
    175d:	e8 e7 ec ff ff       	call   449 <paintWindow>
    1762:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1765:	90                   	nop
        default: break;
            
            
    }
    return False;
    1766:	b8 00 00 00 00       	mov    $0x0,%eax
}
    176b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    176e:	c9                   	leave  
    176f:	c3                   	ret    

00001770 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1770:	55                   	push   %ebp
    1771:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1773:	8b 45 0c             	mov    0xc(%ebp),%eax
    1776:	8b 50 08             	mov    0x8(%eax),%edx
    1779:	8b 45 08             	mov    0x8(%ebp),%eax
    177c:	8b 00                	mov    (%eax),%eax
    177e:	39 c2                	cmp    %eax,%edx
    1780:	74 07                	je     1789 <APPreJudge+0x19>
        return False;
    1782:	b8 00 00 00 00       	mov    $0x0,%eax
    1787:	eb 05                	jmp    178e <APPreJudge+0x1e>
    return True;
    1789:	b8 01 00 00 00       	mov    $0x1,%eax
}
    178e:	5d                   	pop    %ebp
    178f:	c3                   	ret    

00001790 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1790:	55                   	push   %ebp
    1791:	89 e5                	mov    %esp,%ebp
    1793:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1796:	8b 45 08             	mov    0x8(%ebp),%eax
    1799:	8b 55 0c             	mov    0xc(%ebp),%edx
    179c:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    179f:	83 ec 0c             	sub    $0xc,%esp
    17a2:	ff 75 08             	pushl  0x8(%ebp)
    17a5:	e8 bf ec ff ff       	call   469 <registWindow>
    17aa:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    17ad:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    17b4:	8b 45 08             	mov    0x8(%ebp),%eax
    17b7:	8b 00                	mov    (%eax),%eax
    17b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    17bc:	ff 75 f4             	pushl  -0xc(%ebp)
    17bf:	ff 75 f0             	pushl  -0x10(%ebp)
    17c2:	ff 75 ec             	pushl  -0x14(%ebp)
    17c5:	ff 75 08             	pushl  0x8(%ebp)
    17c8:	e8 e7 fc ff ff       	call   14b4 <APSendMessage>
    17cd:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    17d0:	83 ec 0c             	sub    $0xc,%esp
    17d3:	ff 75 08             	pushl  0x8(%ebp)
    17d6:	e8 86 ec ff ff       	call   461 <getMessage>
    17db:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    17de:	8b 45 08             	mov    0x8(%ebp),%eax
    17e1:	83 c0 6c             	add    $0x6c,%eax
    17e4:	83 ec 08             	sub    $0x8,%esp
    17e7:	50                   	push   %eax
    17e8:	ff 75 08             	pushl  0x8(%ebp)
    17eb:	e8 80 ff ff ff       	call   1770 <APPreJudge>
    17f0:	83 c4 10             	add    $0x10,%esp
    17f3:	84 c0                	test   %al,%al
    17f5:	74 1b                	je     1812 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    17f7:	8b 45 08             	mov    0x8(%ebp),%eax
    17fa:	ff 70 74             	pushl  0x74(%eax)
    17fd:	ff 70 70             	pushl  0x70(%eax)
    1800:	ff 70 6c             	pushl  0x6c(%eax)
    1803:	ff 75 08             	pushl  0x8(%ebp)
    1806:	8b 45 0c             	mov    0xc(%ebp),%eax
    1809:	ff d0                	call   *%eax
    180b:	83 c4 10             	add    $0x10,%esp
    180e:	84 c0                	test   %al,%al
    1810:	75 0c                	jne    181e <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1812:	8b 45 08             	mov    0x8(%ebp),%eax
    1815:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    181c:	eb b2                	jmp    17d0 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    181e:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    181f:	90                   	nop
    1820:	c9                   	leave  
    1821:	c3                   	ret    

00001822 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1822:	55                   	push   %ebp
    1823:	89 e5                	mov    %esp,%ebp
    1825:	57                   	push   %edi
    1826:	56                   	push   %esi
    1827:	53                   	push   %ebx
    1828:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    182b:	a1 fc 28 00 00       	mov    0x28fc,%eax
    1830:	85 c0                	test   %eax,%eax
    1832:	0f 85 2c 02 00 00    	jne    1a64 <APGridPaint+0x242>
    {
        iconReady = 1;
    1838:	c7 05 fc 28 00 00 01 	movl   $0x1,0x28fc
    183f:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1842:	8d 45 98             	lea    -0x68(%ebp),%eax
    1845:	83 ec 08             	sub    $0x8,%esp
    1848:	68 c7 22 00 00       	push   $0x22c7
    184d:	50                   	push   %eax
    184e:	e8 83 f1 ff ff       	call   9d6 <APLoadBitmap>
    1853:	83 c4 0c             	add    $0xc,%esp
    1856:	8b 45 98             	mov    -0x68(%ebp),%eax
    1859:	a3 20 29 00 00       	mov    %eax,0x2920
    185e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1861:	a3 24 29 00 00       	mov    %eax,0x2924
    1866:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1869:	a3 28 29 00 00       	mov    %eax,0x2928
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    186e:	83 ec 04             	sub    $0x4,%esp
    1871:	ff 35 28 29 00 00    	pushl  0x2928
    1877:	ff 35 24 29 00 00    	pushl  0x2924
    187d:	ff 35 20 29 00 00    	pushl  0x2920
    1883:	e8 88 f3 ff ff       	call   c10 <APCreateCompatibleDCFromBitmap>
    1888:	83 c4 10             	add    $0x10,%esp
    188b:	a3 2c 29 00 00       	mov    %eax,0x292c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1890:	8d 45 98             	lea    -0x68(%ebp),%eax
    1893:	83 ec 08             	sub    $0x8,%esp
    1896:	68 d5 22 00 00       	push   $0x22d5
    189b:	50                   	push   %eax
    189c:	e8 35 f1 ff ff       	call   9d6 <APLoadBitmap>
    18a1:	83 c4 0c             	add    $0xc,%esp
    18a4:	8b 45 98             	mov    -0x68(%ebp),%eax
    18a7:	a3 5c 29 00 00       	mov    %eax,0x295c
    18ac:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18af:	a3 60 29 00 00       	mov    %eax,0x2960
    18b4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    18b7:	a3 64 29 00 00       	mov    %eax,0x2964
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    18bc:	83 ec 04             	sub    $0x4,%esp
    18bf:	ff 35 64 29 00 00    	pushl  0x2964
    18c5:	ff 35 60 29 00 00    	pushl  0x2960
    18cb:	ff 35 5c 29 00 00    	pushl  0x295c
    18d1:	e8 3a f3 ff ff       	call   c10 <APCreateCompatibleDCFromBitmap>
    18d6:	83 c4 10             	add    $0x10,%esp
    18d9:	a3 4c 29 00 00       	mov    %eax,0x294c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    18de:	8d 45 98             	lea    -0x68(%ebp),%eax
    18e1:	83 ec 08             	sub    $0x8,%esp
    18e4:	68 e4 22 00 00       	push   $0x22e4
    18e9:	50                   	push   %eax
    18ea:	e8 e7 f0 ff ff       	call   9d6 <APLoadBitmap>
    18ef:	83 c4 0c             	add    $0xc,%esp
    18f2:	8b 45 98             	mov    -0x68(%ebp),%eax
    18f5:	a3 50 29 00 00       	mov    %eax,0x2950
    18fa:	8b 45 9c             	mov    -0x64(%ebp),%eax
    18fd:	a3 54 29 00 00       	mov    %eax,0x2954
    1902:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1905:	a3 58 29 00 00       	mov    %eax,0x2958
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    190a:	83 ec 04             	sub    $0x4,%esp
    190d:	ff 35 58 29 00 00    	pushl  0x2958
    1913:	ff 35 54 29 00 00    	pushl  0x2954
    1919:	ff 35 50 29 00 00    	pushl  0x2950
    191f:	e8 ec f2 ff ff       	call   c10 <APCreateCompatibleDCFromBitmap>
    1924:	83 c4 10             	add    $0x10,%esp
    1927:	a3 00 29 00 00       	mov    %eax,0x2900
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    192c:	8d 45 98             	lea    -0x68(%ebp),%eax
    192f:	83 ec 08             	sub    $0x8,%esp
    1932:	68 f3 22 00 00       	push   $0x22f3
    1937:	50                   	push   %eax
    1938:	e8 99 f0 ff ff       	call   9d6 <APLoadBitmap>
    193d:	83 c4 0c             	add    $0xc,%esp
    1940:	8b 45 98             	mov    -0x68(%ebp),%eax
    1943:	a3 34 29 00 00       	mov    %eax,0x2934
    1948:	8b 45 9c             	mov    -0x64(%ebp),%eax
    194b:	a3 38 29 00 00       	mov    %eax,0x2938
    1950:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1953:	a3 3c 29 00 00       	mov    %eax,0x293c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1958:	83 ec 04             	sub    $0x4,%esp
    195b:	ff 35 3c 29 00 00    	pushl  0x293c
    1961:	ff 35 38 29 00 00    	pushl  0x2938
    1967:	ff 35 34 29 00 00    	pushl  0x2934
    196d:	e8 9e f2 ff ff       	call   c10 <APCreateCompatibleDCFromBitmap>
    1972:	83 c4 10             	add    $0x10,%esp
    1975:	a3 68 29 00 00       	mov    %eax,0x2968
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    197a:	8d 45 98             	lea    -0x68(%ebp),%eax
    197d:	83 ec 08             	sub    $0x8,%esp
    1980:	68 01 23 00 00       	push   $0x2301
    1985:	50                   	push   %eax
    1986:	e8 4b f0 ff ff       	call   9d6 <APLoadBitmap>
    198b:	83 c4 0c             	add    $0xc,%esp
    198e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1991:	a3 10 29 00 00       	mov    %eax,0x2910
    1996:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1999:	a3 14 29 00 00       	mov    %eax,0x2914
    199e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19a1:	a3 18 29 00 00       	mov    %eax,0x2918
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    19a6:	83 ec 04             	sub    $0x4,%esp
    19a9:	ff 35 18 29 00 00    	pushl  0x2918
    19af:	ff 35 14 29 00 00    	pushl  0x2914
    19b5:	ff 35 10 29 00 00    	pushl  0x2910
    19bb:	e8 50 f2 ff ff       	call   c10 <APCreateCompatibleDCFromBitmap>
    19c0:	83 c4 10             	add    $0x10,%esp
    19c3:	a3 30 29 00 00       	mov    %eax,0x2930
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    19c8:	8d 45 98             	lea    -0x68(%ebp),%eax
    19cb:	83 ec 08             	sub    $0x8,%esp
    19ce:	68 11 23 00 00       	push   $0x2311
    19d3:	50                   	push   %eax
    19d4:	e8 fd ef ff ff       	call   9d6 <APLoadBitmap>
    19d9:	83 c4 0c             	add    $0xc,%esp
    19dc:	8b 45 98             	mov    -0x68(%ebp),%eax
    19df:	a3 04 29 00 00       	mov    %eax,0x2904
    19e4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    19e7:	a3 08 29 00 00       	mov    %eax,0x2908
    19ec:	8b 45 a0             	mov    -0x60(%ebp),%eax
    19ef:	a3 0c 29 00 00       	mov    %eax,0x290c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    19f4:	83 ec 04             	sub    $0x4,%esp
    19f7:	ff 35 0c 29 00 00    	pushl  0x290c
    19fd:	ff 35 08 29 00 00    	pushl  0x2908
    1a03:	ff 35 04 29 00 00    	pushl  0x2904
    1a09:	e8 02 f2 ff ff       	call   c10 <APCreateCompatibleDCFromBitmap>
    1a0e:	83 c4 10             	add    $0x10,%esp
    1a11:	a3 1c 29 00 00       	mov    %eax,0x291c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1a16:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a19:	83 ec 08             	sub    $0x8,%esp
    1a1c:	68 23 23 00 00       	push   $0x2323
    1a21:	50                   	push   %eax
    1a22:	e8 af ef ff ff       	call   9d6 <APLoadBitmap>
    1a27:	83 c4 0c             	add    $0xc,%esp
    1a2a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a2d:	a3 40 29 00 00       	mov    %eax,0x2940
    1a32:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a35:	a3 44 29 00 00       	mov    %eax,0x2944
    1a3a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a3d:	a3 48 29 00 00       	mov    %eax,0x2948
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1a42:	83 ec 04             	sub    $0x4,%esp
    1a45:	ff 35 48 29 00 00    	pushl  0x2948
    1a4b:	ff 35 44 29 00 00    	pushl  0x2944
    1a51:	ff 35 40 29 00 00    	pushl  0x2940
    1a57:	e8 b4 f1 ff ff       	call   c10 <APCreateCompatibleDCFromBitmap>
    1a5c:	83 c4 10             	add    $0x10,%esp
    1a5f:	a3 6c 29 00 00       	mov    %eax,0x296c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1a64:	8b 45 08             	mov    0x8(%ebp),%eax
    1a67:	8b 40 08             	mov    0x8(%eax),%eax
    1a6a:	85 c0                	test   %eax,%eax
    1a6c:	75 17                	jne    1a85 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1a6e:	83 ec 08             	sub    $0x8,%esp
    1a71:	68 34 23 00 00       	push   $0x2334
    1a76:	6a 01                	push   $0x1
    1a78:	e8 d3 ea ff ff       	call   550 <printf>
    1a7d:	83 c4 10             	add    $0x10,%esp
        return;
    1a80:	e9 f2 03 00 00       	jmp    1e77 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1a85:	8b 45 08             	mov    0x8(%ebp),%eax
    1a88:	8b 40 10             	mov    0x10(%eax),%eax
    1a8b:	85 c0                	test   %eax,%eax
    1a8d:	7e 10                	jle    1a9f <APGridPaint+0x27d>
    1a8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a92:	8b 50 14             	mov    0x14(%eax),%edx
    1a95:	8b 45 08             	mov    0x8(%ebp),%eax
    1a98:	8b 40 10             	mov    0x10(%eax),%eax
    1a9b:	39 c2                	cmp    %eax,%edx
    1a9d:	7c 17                	jl     1ab6 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1a9f:	83 ec 08             	sub    $0x8,%esp
    1aa2:	68 5a 23 00 00       	push   $0x235a
    1aa7:	6a 01                	push   $0x1
    1aa9:	e8 a2 ea ff ff       	call   550 <printf>
    1aae:	83 c4 10             	add    $0x10,%esp
        return;
    1ab1:	e9 c1 03 00 00       	jmp    1e77 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ab6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab9:	8b 40 14             	mov    0x14(%eax),%eax
    1abc:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1ac2:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1ac5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ac8:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1acb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1ad2:	e9 96 03 00 00       	jmp    1e6d <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ad7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1ade:	e9 7c 03 00 00       	jmp    1e5f <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1ae3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ae6:	c1 e0 04             	shl    $0x4,%eax
    1ae9:	89 c2                	mov    %eax,%edx
    1aeb:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1aee:	01 c2                	add    %eax,%edx
    1af0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1af3:	01 d0                	add    %edx,%eax
    1af5:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1af8:	8b 45 08             	mov    0x8(%ebp),%eax
    1afb:	8b 40 0c             	mov    0xc(%eax),%eax
    1afe:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b01:	c1 e2 02             	shl    $0x2,%edx
    1b04:	01 d0                	add    %edx,%eax
    1b06:	8b 00                	mov    (%eax),%eax
    1b08:	83 f8 07             	cmp    $0x7,%eax
    1b0b:	0f 87 49 03 00 00    	ja     1e5a <APGridPaint+0x638>
    1b11:	8b 04 85 70 23 00 00 	mov    0x2370(,%eax,4),%eax
    1b18:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1b1a:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1b1d:	6a 0c                	push   $0xc
    1b1f:	6a 0c                	push   $0xc
    1b21:	6a 0c                	push   $0xc
    1b23:	50                   	push   %eax
    1b24:	e8 46 f9 ff ff       	call   146f <RGB>
    1b29:	83 c4 0c             	add    $0xc,%esp
    1b2c:	8b 1d 2c 29 00 00    	mov    0x292c,%ebx
    1b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b35:	6b c8 32             	imul   $0x32,%eax,%ecx
    1b38:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b3b:	6b c0 32             	imul   $0x32,%eax,%eax
    1b3e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1b41:	8b 45 08             	mov    0x8(%ebp),%eax
    1b44:	8d 78 34             	lea    0x34(%eax),%edi
    1b47:	83 ec 0c             	sub    $0xc,%esp
    1b4a:	83 ec 04             	sub    $0x4,%esp
    1b4d:	89 e0                	mov    %esp,%eax
    1b4f:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1b53:	66 89 30             	mov    %si,(%eax)
    1b56:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1b5a:	88 50 02             	mov    %dl,0x2(%eax)
    1b5d:	6a 32                	push   $0x32
    1b5f:	6a 32                	push   $0x32
    1b61:	6a 00                	push   $0x0
    1b63:	6a 00                	push   $0x0
    1b65:	53                   	push   %ebx
    1b66:	51                   	push   %ecx
    1b67:	ff 75 94             	pushl  -0x6c(%ebp)
    1b6a:	57                   	push   %edi
    1b6b:	e8 5b f7 ff ff       	call   12cb <APDcCopy>
    1b70:	83 c4 30             	add    $0x30,%esp
                    break;
    1b73:	e9 e3 02 00 00       	jmp    1e5b <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1b78:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b7b:	6a 69                	push   $0x69
    1b7d:	6a 69                	push   $0x69
    1b7f:	6a 69                	push   $0x69
    1b81:	50                   	push   %eax
    1b82:	e8 e8 f8 ff ff       	call   146f <RGB>
    1b87:	83 c4 0c             	add    $0xc,%esp
    1b8a:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1b8e:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1b92:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1b96:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1b99:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ba0:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ba3:	6a 69                	push   $0x69
    1ba5:	6a 69                	push   $0x69
    1ba7:	6a 69                	push   $0x69
    1ba9:	50                   	push   %eax
    1baa:	e8 c0 f8 ff ff       	call   146f <RGB>
    1baf:	83 c4 0c             	add    $0xc,%esp
    1bb2:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1bb6:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1bba:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1bbe:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1bc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc4:	8d 50 34             	lea    0x34(%eax),%edx
    1bc7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bca:	ff 75 bc             	pushl  -0x44(%ebp)
    1bcd:	ff 75 b8             	pushl  -0x48(%ebp)
    1bd0:	52                   	push   %edx
    1bd1:	50                   	push   %eax
    1bd2:	e8 ce f0 ff ff       	call   ca5 <APSetPen>
    1bd7:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1bda:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdd:	8d 58 34             	lea    0x34(%eax),%ebx
    1be0:	8d 55 98             	lea    -0x68(%ebp),%edx
    1be3:	83 ec 04             	sub    $0x4,%esp
    1be6:	83 ec 04             	sub    $0x4,%esp
    1be9:	89 e0                	mov    %esp,%eax
    1beb:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1bef:	66 89 08             	mov    %cx,(%eax)
    1bf2:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1bf6:	88 48 02             	mov    %cl,0x2(%eax)
    1bf9:	53                   	push   %ebx
    1bfa:	52                   	push   %edx
    1bfb:	e8 de f0 ff ff       	call   cde <APSetBrush>
    1c00:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c06:	6b d0 32             	imul   $0x32,%eax,%edx
    1c09:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c0c:	6b c0 32             	imul   $0x32,%eax,%eax
    1c0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c12:	83 c1 34             	add    $0x34,%ecx
    1c15:	83 ec 0c             	sub    $0xc,%esp
    1c18:	6a 32                	push   $0x32
    1c1a:	6a 32                	push   $0x32
    1c1c:	52                   	push   %edx
    1c1d:	50                   	push   %eax
    1c1e:	51                   	push   %ecx
    1c1f:	e8 a2 f4 ff ff       	call   10c6 <APDrawRect>
    1c24:	83 c4 20             	add    $0x20,%esp
                    break;
    1c27:	e9 2f 02 00 00       	jmp    1e5b <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c2c:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1c2f:	6a 0c                	push   $0xc
    1c31:	6a 0c                	push   $0xc
    1c33:	6a 0c                	push   $0xc
    1c35:	50                   	push   %eax
    1c36:	e8 34 f8 ff ff       	call   146f <RGB>
    1c3b:	83 c4 0c             	add    $0xc,%esp
    1c3e:	8b 1d 6c 29 00 00    	mov    0x296c,%ebx
    1c44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c47:	6b c8 32             	imul   $0x32,%eax,%ecx
    1c4a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c4d:	6b c0 32             	imul   $0x32,%eax,%eax
    1c50:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1c53:	8b 45 08             	mov    0x8(%ebp),%eax
    1c56:	8d 78 34             	lea    0x34(%eax),%edi
    1c59:	83 ec 0c             	sub    $0xc,%esp
    1c5c:	83 ec 04             	sub    $0x4,%esp
    1c5f:	89 e0                	mov    %esp,%eax
    1c61:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1c65:	66 89 30             	mov    %si,(%eax)
    1c68:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1c6c:	88 50 02             	mov    %dl,0x2(%eax)
    1c6f:	6a 32                	push   $0x32
    1c71:	6a 32                	push   $0x32
    1c73:	6a 00                	push   $0x0
    1c75:	6a 00                	push   $0x0
    1c77:	53                   	push   %ebx
    1c78:	51                   	push   %ecx
    1c79:	ff 75 94             	pushl  -0x6c(%ebp)
    1c7c:	57                   	push   %edi
    1c7d:	e8 49 f6 ff ff       	call   12cb <APDcCopy>
    1c82:	83 c4 30             	add    $0x30,%esp
                    break;
    1c85:	e9 d1 01 00 00       	jmp    1e5b <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1c8a:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1c8d:	6a 0c                	push   $0xc
    1c8f:	6a 0c                	push   $0xc
    1c91:	6a 0c                	push   $0xc
    1c93:	50                   	push   %eax
    1c94:	e8 d6 f7 ff ff       	call   146f <RGB>
    1c99:	83 c4 0c             	add    $0xc,%esp
    1c9c:	8b 1d 4c 29 00 00    	mov    0x294c,%ebx
    1ca2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ca5:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ca8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cab:	6b c0 32             	imul   $0x32,%eax,%eax
    1cae:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1cb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb4:	8d 78 34             	lea    0x34(%eax),%edi
    1cb7:	83 ec 0c             	sub    $0xc,%esp
    1cba:	83 ec 04             	sub    $0x4,%esp
    1cbd:	89 e0                	mov    %esp,%eax
    1cbf:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1cc3:	66 89 30             	mov    %si,(%eax)
    1cc6:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1cca:	88 50 02             	mov    %dl,0x2(%eax)
    1ccd:	6a 32                	push   $0x32
    1ccf:	6a 32                	push   $0x32
    1cd1:	6a 00                	push   $0x0
    1cd3:	6a 00                	push   $0x0
    1cd5:	53                   	push   %ebx
    1cd6:	51                   	push   %ecx
    1cd7:	ff 75 94             	pushl  -0x6c(%ebp)
    1cda:	57                   	push   %edi
    1cdb:	e8 eb f5 ff ff       	call   12cb <APDcCopy>
    1ce0:	83 c4 30             	add    $0x30,%esp
                    break;
    1ce3:	e9 73 01 00 00       	jmp    1e5b <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ce8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ceb:	6a 0c                	push   $0xc
    1ced:	6a 0c                	push   $0xc
    1cef:	6a 0c                	push   $0xc
    1cf1:	50                   	push   %eax
    1cf2:	e8 78 f7 ff ff       	call   146f <RGB>
    1cf7:	83 c4 0c             	add    $0xc,%esp
    1cfa:	8b 1d 30 29 00 00    	mov    0x2930,%ebx
    1d00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d03:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d06:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d09:	6b c0 32             	imul   $0x32,%eax,%eax
    1d0c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d12:	8d 78 34             	lea    0x34(%eax),%edi
    1d15:	83 ec 0c             	sub    $0xc,%esp
    1d18:	83 ec 04             	sub    $0x4,%esp
    1d1b:	89 e0                	mov    %esp,%eax
    1d1d:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1d21:	66 89 30             	mov    %si,(%eax)
    1d24:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1d28:	88 50 02             	mov    %dl,0x2(%eax)
    1d2b:	6a 32                	push   $0x32
    1d2d:	6a 32                	push   $0x32
    1d2f:	6a 00                	push   $0x0
    1d31:	6a 00                	push   $0x0
    1d33:	53                   	push   %ebx
    1d34:	51                   	push   %ecx
    1d35:	ff 75 94             	pushl  -0x6c(%ebp)
    1d38:	57                   	push   %edi
    1d39:	e8 8d f5 ff ff       	call   12cb <APDcCopy>
    1d3e:	83 c4 30             	add    $0x30,%esp
                    break;
    1d41:	e9 15 01 00 00       	jmp    1e5b <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d46:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1d49:	6a 0c                	push   $0xc
    1d4b:	6a 0c                	push   $0xc
    1d4d:	6a 0c                	push   $0xc
    1d4f:	50                   	push   %eax
    1d50:	e8 1a f7 ff ff       	call   146f <RGB>
    1d55:	83 c4 0c             	add    $0xc,%esp
    1d58:	8b 1d 68 29 00 00    	mov    0x2968,%ebx
    1d5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d61:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d64:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d67:	6b c0 32             	imul   $0x32,%eax,%eax
    1d6a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d70:	8d 78 34             	lea    0x34(%eax),%edi
    1d73:	83 ec 0c             	sub    $0xc,%esp
    1d76:	83 ec 04             	sub    $0x4,%esp
    1d79:	89 e0                	mov    %esp,%eax
    1d7b:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1d7f:	66 89 30             	mov    %si,(%eax)
    1d82:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1d86:	88 50 02             	mov    %dl,0x2(%eax)
    1d89:	6a 32                	push   $0x32
    1d8b:	6a 32                	push   $0x32
    1d8d:	6a 00                	push   $0x0
    1d8f:	6a 00                	push   $0x0
    1d91:	53                   	push   %ebx
    1d92:	51                   	push   %ecx
    1d93:	ff 75 94             	pushl  -0x6c(%ebp)
    1d96:	57                   	push   %edi
    1d97:	e8 2f f5 ff ff       	call   12cb <APDcCopy>
    1d9c:	83 c4 30             	add    $0x30,%esp
                    break;
    1d9f:	e9 b7 00 00 00       	jmp    1e5b <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1da4:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1da7:	6a 0c                	push   $0xc
    1da9:	6a 0c                	push   $0xc
    1dab:	6a 0c                	push   $0xc
    1dad:	50                   	push   %eax
    1dae:	e8 bc f6 ff ff       	call   146f <RGB>
    1db3:	83 c4 0c             	add    $0xc,%esp
    1db6:	8b 1d 00 29 00 00    	mov    0x2900,%ebx
    1dbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dbf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1dc2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1dc5:	6b c0 32             	imul   $0x32,%eax,%eax
    1dc8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1dcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dce:	8d 78 34             	lea    0x34(%eax),%edi
    1dd1:	83 ec 0c             	sub    $0xc,%esp
    1dd4:	83 ec 04             	sub    $0x4,%esp
    1dd7:	89 e0                	mov    %esp,%eax
    1dd9:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1ddd:	66 89 30             	mov    %si,(%eax)
    1de0:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1de4:	88 50 02             	mov    %dl,0x2(%eax)
    1de7:	6a 32                	push   $0x32
    1de9:	6a 32                	push   $0x32
    1deb:	6a 00                	push   $0x0
    1ded:	6a 00                	push   $0x0
    1def:	53                   	push   %ebx
    1df0:	51                   	push   %ecx
    1df1:	ff 75 94             	pushl  -0x6c(%ebp)
    1df4:	57                   	push   %edi
    1df5:	e8 d1 f4 ff ff       	call   12cb <APDcCopy>
    1dfa:	83 c4 30             	add    $0x30,%esp
                    break;
    1dfd:	eb 5c                	jmp    1e5b <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dff:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1e02:	6a 0c                	push   $0xc
    1e04:	6a 0c                	push   $0xc
    1e06:	6a 0c                	push   $0xc
    1e08:	50                   	push   %eax
    1e09:	e8 61 f6 ff ff       	call   146f <RGB>
    1e0e:	83 c4 0c             	add    $0xc,%esp
    1e11:	8b 1d 1c 29 00 00    	mov    0x291c,%ebx
    1e17:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e1a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e1d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e20:	6b c0 32             	imul   $0x32,%eax,%eax
    1e23:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	8d 78 34             	lea    0x34(%eax),%edi
    1e2c:	83 ec 0c             	sub    $0xc,%esp
    1e2f:	83 ec 04             	sub    $0x4,%esp
    1e32:	89 e0                	mov    %esp,%eax
    1e34:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1e38:	66 89 30             	mov    %si,(%eax)
    1e3b:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1e3f:	88 50 02             	mov    %dl,0x2(%eax)
    1e42:	6a 32                	push   $0x32
    1e44:	6a 32                	push   $0x32
    1e46:	6a 00                	push   $0x0
    1e48:	6a 00                	push   $0x0
    1e4a:	53                   	push   %ebx
    1e4b:	51                   	push   %ecx
    1e4c:	ff 75 94             	pushl  -0x6c(%ebp)
    1e4f:	57                   	push   %edi
    1e50:	e8 76 f4 ff ff       	call   12cb <APDcCopy>
    1e55:	83 c4 30             	add    $0x30,%esp
                    break;
    1e58:	eb 01                	jmp    1e5b <APGridPaint+0x639>
                default: break;
    1e5a:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e5b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e5f:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e63:	0f 8e 7a fc ff ff    	jle    1ae3 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e69:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e6d:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e71:	0f 8e 60 fc ff ff    	jle    1ad7 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    1e77:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e7a:	5b                   	pop    %ebx
    1e7b:	5e                   	pop    %esi
    1e7c:	5f                   	pop    %edi
    1e7d:	5d                   	pop    %ebp
    1e7e:	c3                   	ret    

00001e7f <random>:
//

#include "APLib.h"

int random(int seed)
{
    1e7f:	55                   	push   %ebp
    1e80:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    1e82:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1e86:	7e 08                	jle    1e90 <random+0x11>
{
rand_num = seed;
    1e88:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8b:	a3 d8 28 00 00       	mov    %eax,0x28d8
}
rand_num *= 3;
    1e90:	8b 15 d8 28 00 00    	mov    0x28d8,%edx
    1e96:	89 d0                	mov    %edx,%eax
    1e98:	01 c0                	add    %eax,%eax
    1e9a:	01 d0                	add    %edx,%eax
    1e9c:	a3 d8 28 00 00       	mov    %eax,0x28d8
if (rand_num < 0)
    1ea1:	a1 d8 28 00 00       	mov    0x28d8,%eax
    1ea6:	85 c0                	test   %eax,%eax
    1ea8:	79 0c                	jns    1eb6 <random+0x37>
{
rand_num *= (-1);
    1eaa:	a1 d8 28 00 00       	mov    0x28d8,%eax
    1eaf:	f7 d8                	neg    %eax
    1eb1:	a3 d8 28 00 00       	mov    %eax,0x28d8
}
return rand_num % 997;
    1eb6:	8b 0d d8 28 00 00    	mov    0x28d8,%ecx
    1ebc:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    1ec1:	89 c8                	mov    %ecx,%eax
    1ec3:	f7 ea                	imul   %edx
    1ec5:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    1ec8:	c1 f8 09             	sar    $0x9,%eax
    1ecb:	89 c2                	mov    %eax,%edx
    1ecd:	89 c8                	mov    %ecx,%eax
    1ecf:	c1 f8 1f             	sar    $0x1f,%eax
    1ed2:	29 c2                	sub    %eax,%edx
    1ed4:	89 d0                	mov    %edx,%eax
    1ed6:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    1edc:	29 c1                	sub    %eax,%ecx
    1ede:	89 c8                	mov    %ecx,%eax
}
    1ee0:	5d                   	pop    %ebp
    1ee1:	c3                   	ret    

00001ee2 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1ee2:	55                   	push   %ebp
    1ee3:	89 e5                	mov    %esp,%ebp
    1ee5:	53                   	push   %ebx
    1ee6:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1ee9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1ef0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1ef4:	74 17                	je     1f0d <sprintint+0x2b>
    1ef6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1efa:	79 11                	jns    1f0d <sprintint+0x2b>
        neg = 1;
    1efc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1f03:	8b 45 10             	mov    0x10(%ebp),%eax
    1f06:	f7 d8                	neg    %eax
    1f08:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f0b:	eb 06                	jmp    1f13 <sprintint+0x31>
    } else {
        x = xx;
    1f0d:	8b 45 10             	mov    0x10(%ebp),%eax
    1f10:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1f13:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1f1a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1f1d:	8d 41 01             	lea    0x1(%ecx),%eax
    1f20:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1f23:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f26:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f29:	ba 00 00 00 00       	mov    $0x0,%edx
    1f2e:	f7 f3                	div    %ebx
    1f30:	89 d0                	mov    %edx,%eax
    1f32:	0f b6 80 dc 28 00 00 	movzbl 0x28dc(%eax),%eax
    1f39:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1f3d:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1f40:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f43:	ba 00 00 00 00       	mov    $0x0,%edx
    1f48:	f7 f3                	div    %ebx
    1f4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1f4d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f51:	75 c7                	jne    1f1a <sprintint+0x38>
    if(neg)
    1f53:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f57:	74 0e                	je     1f67 <sprintint+0x85>
        buf[i++] = '-';
    1f59:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f5c:	8d 50 01             	lea    0x1(%eax),%edx
    1f5f:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1f62:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1f67:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f6a:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1f6d:	eb 1b                	jmp    1f8a <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f72:	8b 00                	mov    (%eax),%eax
    1f74:	8d 48 01             	lea    0x1(%eax),%ecx
    1f77:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f7a:	89 0a                	mov    %ecx,(%edx)
    1f7c:	89 c2                	mov    %eax,%edx
    1f7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f81:	01 d0                	add    %edx,%eax
    1f83:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f86:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f8a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f8e:	7f df                	jg     1f6f <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f90:	eb 21                	jmp    1fb3 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f92:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f95:	8b 00                	mov    (%eax),%eax
    1f97:	8d 48 01             	lea    0x1(%eax),%ecx
    1f9a:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f9d:	89 0a                	mov    %ecx,(%edx)
    1f9f:	89 c2                	mov    %eax,%edx
    1fa1:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa4:	01 c2                	add    %eax,%edx
    1fa6:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1fa9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1fac:	01 c8                	add    %ecx,%eax
    1fae:	0f b6 00             	movzbl (%eax),%eax
    1fb1:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1fb3:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1fb7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1fbb:	79 d5                	jns    1f92 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1fbd:	90                   	nop
    1fbe:	83 c4 20             	add    $0x20,%esp
    1fc1:	5b                   	pop    %ebx
    1fc2:	5d                   	pop    %ebp
    1fc3:	c3                   	ret    

00001fc4 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1fc4:	55                   	push   %ebp
    1fc5:	89 e5                	mov    %esp,%ebp
    1fc7:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1fca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1fd1:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1fd8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1fdf:	8d 45 0c             	lea    0xc(%ebp),%eax
    1fe2:	83 c0 04             	add    $0x4,%eax
    1fe5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1fe8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1fef:	e9 d9 01 00 00       	jmp    21cd <sprintf+0x209>
        c = fmt[i] & 0xff;
    1ff4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ff7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ffa:	01 d0                	add    %edx,%eax
    1ffc:	0f b6 00             	movzbl (%eax),%eax
    1fff:	0f be c0             	movsbl %al,%eax
    2002:	25 ff 00 00 00       	and    $0xff,%eax
    2007:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    200a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    200e:	75 2c                	jne    203c <sprintf+0x78>
            if(c == '%'){
    2010:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2014:	75 0c                	jne    2022 <sprintf+0x5e>
                state = '%';
    2016:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    201d:	e9 a7 01 00 00       	jmp    21c9 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2022:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2025:	8d 50 01             	lea    0x1(%eax),%edx
    2028:	89 55 c8             	mov    %edx,-0x38(%ebp)
    202b:	89 c2                	mov    %eax,%edx
    202d:	8b 45 08             	mov    0x8(%ebp),%eax
    2030:	01 d0                	add    %edx,%eax
    2032:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2035:	88 10                	mov    %dl,(%eax)
    2037:	e9 8d 01 00 00       	jmp    21c9 <sprintf+0x205>
            }
        } else if(state == '%'){
    203c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2040:	0f 85 83 01 00 00    	jne    21c9 <sprintf+0x205>
            if(c == 'd'){
    2046:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    204a:	75 4c                	jne    2098 <sprintf+0xd4>
                buf[bi] = '\0';
    204c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    204f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2052:	01 d0                	add    %edx,%eax
    2054:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2057:	83 ec 0c             	sub    $0xc,%esp
    205a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    205d:	50                   	push   %eax
    205e:	e8 b4 e2 ff ff       	call   317 <atoi>
    2063:	83 c4 10             	add    $0x10,%esp
    2066:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2069:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2070:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2073:	8b 00                	mov    (%eax),%eax
    2075:	83 ec 08             	sub    $0x8,%esp
    2078:	ff 75 d8             	pushl  -0x28(%ebp)
    207b:	6a 01                	push   $0x1
    207d:	6a 0a                	push   $0xa
    207f:	50                   	push   %eax
    2080:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2083:	50                   	push   %eax
    2084:	ff 75 08             	pushl  0x8(%ebp)
    2087:	e8 56 fe ff ff       	call   1ee2 <sprintint>
    208c:	83 c4 20             	add    $0x20,%esp
                ap++;
    208f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2093:	e9 2a 01 00 00       	jmp    21c2 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2098:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    209c:	74 06                	je     20a4 <sprintf+0xe0>
    209e:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    20a2:	75 4c                	jne    20f0 <sprintf+0x12c>
                buf[bi] = '\0';
    20a4:	8d 55 ce             	lea    -0x32(%ebp),%edx
    20a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20aa:	01 d0                	add    %edx,%eax
    20ac:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    20af:	83 ec 0c             	sub    $0xc,%esp
    20b2:	8d 45 ce             	lea    -0x32(%ebp),%eax
    20b5:	50                   	push   %eax
    20b6:	e8 5c e2 ff ff       	call   317 <atoi>
    20bb:	83 c4 10             	add    $0x10,%esp
    20be:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    20c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    20c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20cb:	8b 00                	mov    (%eax),%eax
    20cd:	83 ec 08             	sub    $0x8,%esp
    20d0:	ff 75 dc             	pushl  -0x24(%ebp)
    20d3:	6a 00                	push   $0x0
    20d5:	6a 10                	push   $0x10
    20d7:	50                   	push   %eax
    20d8:	8d 45 c8             	lea    -0x38(%ebp),%eax
    20db:	50                   	push   %eax
    20dc:	ff 75 08             	pushl  0x8(%ebp)
    20df:	e8 fe fd ff ff       	call   1ee2 <sprintint>
    20e4:	83 c4 20             	add    $0x20,%esp
                ap++;
    20e7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    20eb:	e9 d2 00 00 00       	jmp    21c2 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    20f0:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    20f4:	75 46                	jne    213c <sprintf+0x178>
                s = (char*)*ap;
    20f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f9:	8b 00                	mov    (%eax),%eax
    20fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    20fe:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2102:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2106:	75 25                	jne    212d <sprintf+0x169>
                    s = "(null)";
    2108:	c7 45 f4 90 23 00 00 	movl   $0x2390,-0xc(%ebp)
                while(*s != 0){
    210f:	eb 1c                	jmp    212d <sprintf+0x169>
                    dst[j++] = *s;
    2111:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2114:	8d 50 01             	lea    0x1(%eax),%edx
    2117:	89 55 c8             	mov    %edx,-0x38(%ebp)
    211a:	89 c2                	mov    %eax,%edx
    211c:	8b 45 08             	mov    0x8(%ebp),%eax
    211f:	01 c2                	add    %eax,%edx
    2121:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2124:	0f b6 00             	movzbl (%eax),%eax
    2127:	88 02                	mov    %al,(%edx)
                    s++;
    2129:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    212d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2130:	0f b6 00             	movzbl (%eax),%eax
    2133:	84 c0                	test   %al,%al
    2135:	75 da                	jne    2111 <sprintf+0x14d>
    2137:	e9 86 00 00 00       	jmp    21c2 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    213c:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2140:	75 1d                	jne    215f <sprintf+0x19b>
                dst[j++] = *ap;
    2142:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2145:	8d 50 01             	lea    0x1(%eax),%edx
    2148:	89 55 c8             	mov    %edx,-0x38(%ebp)
    214b:	89 c2                	mov    %eax,%edx
    214d:	8b 45 08             	mov    0x8(%ebp),%eax
    2150:	01 c2                	add    %eax,%edx
    2152:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2155:	8b 00                	mov    (%eax),%eax
    2157:	88 02                	mov    %al,(%edx)
                ap++;
    2159:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    215d:	eb 63                	jmp    21c2 <sprintf+0x1fe>
            } else if(c == '%'){
    215f:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2163:	75 17                	jne    217c <sprintf+0x1b8>
                dst[j++] = c;
    2165:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2168:	8d 50 01             	lea    0x1(%eax),%edx
    216b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    216e:	89 c2                	mov    %eax,%edx
    2170:	8b 45 08             	mov    0x8(%ebp),%eax
    2173:	01 d0                	add    %edx,%eax
    2175:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2178:	88 10                	mov    %dl,(%eax)
    217a:	eb 46                	jmp    21c2 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    217c:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2180:	7e 18                	jle    219a <sprintf+0x1d6>
    2182:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2186:	7f 12                	jg     219a <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2188:	8b 45 f0             	mov    -0x10(%ebp),%eax
    218b:	8d 50 01             	lea    0x1(%eax),%edx
    218e:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2191:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2194:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2198:	eb 2f                	jmp    21c9 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    219a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219d:	8d 50 01             	lea    0x1(%eax),%edx
    21a0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a3:	89 c2                	mov    %eax,%edx
    21a5:	8b 45 08             	mov    0x8(%ebp),%eax
    21a8:	01 d0                	add    %edx,%eax
    21aa:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    21ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21b0:	8d 50 01             	lea    0x1(%eax),%edx
    21b3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21b6:	89 c2                	mov    %eax,%edx
    21b8:	8b 45 08             	mov    0x8(%ebp),%eax
    21bb:	01 d0                	add    %edx,%eax
    21bd:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21c0:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    21c2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    21c9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    21cd:	8b 55 0c             	mov    0xc(%ebp),%edx
    21d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21d3:	01 d0                	add    %edx,%eax
    21d5:	0f b6 00             	movzbl (%eax),%eax
    21d8:	84 c0                	test   %al,%al
    21da:	0f 85 14 fe ff ff    	jne    1ff4 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    21e0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21e3:	8d 50 01             	lea    0x1(%eax),%edx
    21e6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21e9:	89 c2                	mov    %eax,%edx
    21eb:	8b 45 08             	mov    0x8(%ebp),%eax
    21ee:	01 d0                	add    %edx,%eax
    21f0:	c6 00 00             	movb   $0x0,(%eax)
}
    21f3:	90                   	nop
    21f4:	c9                   	leave  
    21f5:	c3                   	ret    
