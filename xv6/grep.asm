
_grep：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
       6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
       d:	e9 ab 00 00 00       	jmp    bd <grep+0xbd>
    m += n;
      12:	8b 45 ec             	mov    -0x14(%ebp),%eax
      15:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
      18:	c7 45 f0 00 2b 00 00 	movl   $0x2b00,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
      1f:	eb 4a                	jmp    6b <grep+0x6b>
      *q = 0;
      21:	8b 45 e8             	mov    -0x18(%ebp),%eax
      24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
      27:	83 ec 08             	sub    $0x8,%esp
      2a:	ff 75 f0             	pushl  -0x10(%ebp)
      2d:	ff 75 08             	pushl  0x8(%ebp)
      30:	e8 9a 01 00 00       	call   1cf <match>
      35:	83 c4 10             	add    $0x10,%esp
      38:	85 c0                	test   %eax,%eax
      3a:	74 26                	je     62 <grep+0x62>
        *q = '\n';
      3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
      3f:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
      42:	8b 45 e8             	mov    -0x18(%ebp),%eax
      45:	83 c0 01             	add    $0x1,%eax
      48:	89 c2                	mov    %eax,%edx
      4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      4d:	29 c2                	sub    %eax,%edx
      4f:	89 d0                	mov    %edx,%eax
      51:	83 ec 04             	sub    $0x4,%esp
      54:	50                   	push   %eax
      55:	ff 75 f0             	pushl  -0x10(%ebp)
      58:	6a 01                	push   $0x1
      5a:	e8 43 05 00 00       	call   5a2 <write>
      5f:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
      62:	8b 45 e8             	mov    -0x18(%ebp),%eax
      65:	83 c0 01             	add    $0x1,%eax
      68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
      6b:	83 ec 08             	sub    $0x8,%esp
      6e:	6a 0a                	push   $0xa
      70:	ff 75 f0             	pushl  -0x10(%ebp)
      73:	e8 89 03 00 00       	call   401 <strchr>
      78:	83 c4 10             	add    $0x10,%esp
      7b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      7e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
      82:	75 9d                	jne    21 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      84:	81 7d f0 00 2b 00 00 	cmpl   $0x2b00,-0x10(%ebp)
      8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
      8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	ba 00 2b 00 00       	mov    $0x2b00,%edx
      a2:	29 d0                	sub    %edx,%eax
      a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	ff 75 f4             	pushl  -0xc(%ebp)
      ad:	ff 75 f0             	pushl  -0x10(%ebp)
      b0:	68 00 2b 00 00       	push   $0x2b00
      b5:	e8 83 04 00 00       	call   53d <memmove>
      ba:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
      bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c0:	ba 00 04 00 00       	mov    $0x400,%edx
      c5:	29 c2                	sub    %eax,%edx
      c7:	89 d0                	mov    %edx,%eax
      c9:	89 c2                	mov    %eax,%edx
      cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
      ce:	05 00 2b 00 00       	add    $0x2b00,%eax
      d3:	83 ec 04             	sub    $0x4,%esp
      d6:	52                   	push   %edx
      d7:	50                   	push   %eax
      d8:	ff 75 0c             	pushl  0xc(%ebp)
      db:	e8 ba 04 00 00       	call   59a <read>
      e0:	83 c4 10             	add    $0x10,%esp
      e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
      e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      ea:	0f 8f 22 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
      f0:	90                   	nop
      f1:	c9                   	leave  
      f2:	c3                   	ret    

000000f3 <main>:

int
main(int argc, char *argv[])
{
      f3:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      f7:	83 e4 f0             	and    $0xfffffff0,%esp
      fa:	ff 71 fc             	pushl  -0x4(%ecx)
      fd:	55                   	push   %ebp
      fe:	89 e5                	mov    %esp,%ebp
     100:	53                   	push   %ebx
     101:	51                   	push   %ecx
     102:	83 ec 10             	sub    $0x10,%esp
     105:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
     107:	83 3b 01             	cmpl   $0x1,(%ebx)
     10a:	7f 17                	jg     123 <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
     10c:	83 ec 08             	sub    $0x8,%esp
     10f:	68 64 23 00 00       	push   $0x2364
     114:	6a 02                	push   $0x2
     116:	e8 06 06 00 00       	call   721 <printf>
     11b:	83 c4 10             	add    $0x10,%esp
    exit();
     11e:	e8 5f 04 00 00       	call   582 <exit>
  }
  pattern = argv[1];
     123:	8b 43 04             	mov    0x4(%ebx),%eax
     126:	8b 40 04             	mov    0x4(%eax),%eax
     129:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
     12c:	83 3b 02             	cmpl   $0x2,(%ebx)
     12f:	7f 15                	jg     146 <main+0x53>
    grep(pattern, 0);
     131:	83 ec 08             	sub    $0x8,%esp
     134:	6a 00                	push   $0x0
     136:	ff 75 f0             	pushl  -0x10(%ebp)
     139:	e8 c2 fe ff ff       	call   0 <grep>
     13e:	83 c4 10             	add    $0x10,%esp
    exit();
     141:	e8 3c 04 00 00       	call   582 <exit>
  }

  for(i = 2; i < argc; i++){
     146:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
     14d:	eb 74                	jmp    1c3 <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
     14f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     152:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     159:	8b 43 04             	mov    0x4(%ebx),%eax
     15c:	01 d0                	add    %edx,%eax
     15e:	8b 00                	mov    (%eax),%eax
     160:	83 ec 08             	sub    $0x8,%esp
     163:	6a 00                	push   $0x0
     165:	50                   	push   %eax
     166:	e8 57 04 00 00       	call   5c2 <open>
     16b:	83 c4 10             	add    $0x10,%esp
     16e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     171:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     175:	79 29                	jns    1a0 <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
     177:	8b 45 f4             	mov    -0xc(%ebp),%eax
     17a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     181:	8b 43 04             	mov    0x4(%ebx),%eax
     184:	01 d0                	add    %edx,%eax
     186:	8b 00                	mov    (%eax),%eax
     188:	83 ec 04             	sub    $0x4,%esp
     18b:	50                   	push   %eax
     18c:	68 84 23 00 00       	push   $0x2384
     191:	6a 01                	push   $0x1
     193:	e8 89 05 00 00       	call   721 <printf>
     198:	83 c4 10             	add    $0x10,%esp
      exit();
     19b:	e8 e2 03 00 00       	call   582 <exit>
    }
    grep(pattern, fd);
     1a0:	83 ec 08             	sub    $0x8,%esp
     1a3:	ff 75 ec             	pushl  -0x14(%ebp)
     1a6:	ff 75 f0             	pushl  -0x10(%ebp)
     1a9:	e8 52 fe ff ff       	call   0 <grep>
     1ae:	83 c4 10             	add    $0x10,%esp
    close(fd);
     1b1:	83 ec 0c             	sub    $0xc,%esp
     1b4:	ff 75 ec             	pushl  -0x14(%ebp)
     1b7:	e8 ee 03 00 00       	call   5aa <close>
     1bc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
     1bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c6:	3b 03                	cmp    (%ebx),%eax
     1c8:	7c 85                	jl     14f <main+0x5c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
     1ca:	e8 b3 03 00 00       	call   582 <exit>

000001cf <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     1cf:	55                   	push   %ebp
     1d0:	89 e5                	mov    %esp,%ebp
     1d2:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
     1d5:	8b 45 08             	mov    0x8(%ebp),%eax
     1d8:	0f b6 00             	movzbl (%eax),%eax
     1db:	3c 5e                	cmp    $0x5e,%al
     1dd:	75 17                	jne    1f6 <match+0x27>
    return matchhere(re+1, text);
     1df:	8b 45 08             	mov    0x8(%ebp),%eax
     1e2:	83 c0 01             	add    $0x1,%eax
     1e5:	83 ec 08             	sub    $0x8,%esp
     1e8:	ff 75 0c             	pushl  0xc(%ebp)
     1eb:	50                   	push   %eax
     1ec:	e8 38 00 00 00       	call   229 <matchhere>
     1f1:	83 c4 10             	add    $0x10,%esp
     1f4:	eb 31                	jmp    227 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
     1f6:	83 ec 08             	sub    $0x8,%esp
     1f9:	ff 75 0c             	pushl  0xc(%ebp)
     1fc:	ff 75 08             	pushl  0x8(%ebp)
     1ff:	e8 25 00 00 00       	call   229 <matchhere>
     204:	83 c4 10             	add    $0x10,%esp
     207:	85 c0                	test   %eax,%eax
     209:	74 07                	je     212 <match+0x43>
      return 1;
     20b:	b8 01 00 00 00       	mov    $0x1,%eax
     210:	eb 15                	jmp    227 <match+0x58>
  }while(*text++ != '\0');
     212:	8b 45 0c             	mov    0xc(%ebp),%eax
     215:	8d 50 01             	lea    0x1(%eax),%edx
     218:	89 55 0c             	mov    %edx,0xc(%ebp)
     21b:	0f b6 00             	movzbl (%eax),%eax
     21e:	84 c0                	test   %al,%al
     220:	75 d4                	jne    1f6 <match+0x27>
  return 0;
     222:	b8 00 00 00 00       	mov    $0x0,%eax
}
     227:	c9                   	leave  
     228:	c3                   	ret    

00000229 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     229:	55                   	push   %ebp
     22a:	89 e5                	mov    %esp,%ebp
     22c:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
     22f:	8b 45 08             	mov    0x8(%ebp),%eax
     232:	0f b6 00             	movzbl (%eax),%eax
     235:	84 c0                	test   %al,%al
     237:	75 0a                	jne    243 <matchhere+0x1a>
    return 1;
     239:	b8 01 00 00 00       	mov    $0x1,%eax
     23e:	e9 99 00 00 00       	jmp    2dc <matchhere+0xb3>
  if(re[1] == '*')
     243:	8b 45 08             	mov    0x8(%ebp),%eax
     246:	83 c0 01             	add    $0x1,%eax
     249:	0f b6 00             	movzbl (%eax),%eax
     24c:	3c 2a                	cmp    $0x2a,%al
     24e:	75 21                	jne    271 <matchhere+0x48>
    return matchstar(re[0], re+2, text);
     250:	8b 45 08             	mov    0x8(%ebp),%eax
     253:	8d 50 02             	lea    0x2(%eax),%edx
     256:	8b 45 08             	mov    0x8(%ebp),%eax
     259:	0f b6 00             	movzbl (%eax),%eax
     25c:	0f be c0             	movsbl %al,%eax
     25f:	83 ec 04             	sub    $0x4,%esp
     262:	ff 75 0c             	pushl  0xc(%ebp)
     265:	52                   	push   %edx
     266:	50                   	push   %eax
     267:	e8 72 00 00 00       	call   2de <matchstar>
     26c:	83 c4 10             	add    $0x10,%esp
     26f:	eb 6b                	jmp    2dc <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
     271:	8b 45 08             	mov    0x8(%ebp),%eax
     274:	0f b6 00             	movzbl (%eax),%eax
     277:	3c 24                	cmp    $0x24,%al
     279:	75 1d                	jne    298 <matchhere+0x6f>
     27b:	8b 45 08             	mov    0x8(%ebp),%eax
     27e:	83 c0 01             	add    $0x1,%eax
     281:	0f b6 00             	movzbl (%eax),%eax
     284:	84 c0                	test   %al,%al
     286:	75 10                	jne    298 <matchhere+0x6f>
    return *text == '\0';
     288:	8b 45 0c             	mov    0xc(%ebp),%eax
     28b:	0f b6 00             	movzbl (%eax),%eax
     28e:	84 c0                	test   %al,%al
     290:	0f 94 c0             	sete   %al
     293:	0f b6 c0             	movzbl %al,%eax
     296:	eb 44                	jmp    2dc <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     298:	8b 45 0c             	mov    0xc(%ebp),%eax
     29b:	0f b6 00             	movzbl (%eax),%eax
     29e:	84 c0                	test   %al,%al
     2a0:	74 35                	je     2d7 <matchhere+0xae>
     2a2:	8b 45 08             	mov    0x8(%ebp),%eax
     2a5:	0f b6 00             	movzbl (%eax),%eax
     2a8:	3c 2e                	cmp    $0x2e,%al
     2aa:	74 10                	je     2bc <matchhere+0x93>
     2ac:	8b 45 08             	mov    0x8(%ebp),%eax
     2af:	0f b6 10             	movzbl (%eax),%edx
     2b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b5:	0f b6 00             	movzbl (%eax),%eax
     2b8:	38 c2                	cmp    %al,%dl
     2ba:	75 1b                	jne    2d7 <matchhere+0xae>
    return matchhere(re+1, text+1);
     2bc:	8b 45 0c             	mov    0xc(%ebp),%eax
     2bf:	8d 50 01             	lea    0x1(%eax),%edx
     2c2:	8b 45 08             	mov    0x8(%ebp),%eax
     2c5:	83 c0 01             	add    $0x1,%eax
     2c8:	83 ec 08             	sub    $0x8,%esp
     2cb:	52                   	push   %edx
     2cc:	50                   	push   %eax
     2cd:	e8 57 ff ff ff       	call   229 <matchhere>
     2d2:	83 c4 10             	add    $0x10,%esp
     2d5:	eb 05                	jmp    2dc <matchhere+0xb3>
  return 0;
     2d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2dc:	c9                   	leave  
     2dd:	c3                   	ret    

000002de <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     2de:	55                   	push   %ebp
     2df:	89 e5                	mov    %esp,%ebp
     2e1:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     2e4:	83 ec 08             	sub    $0x8,%esp
     2e7:	ff 75 10             	pushl  0x10(%ebp)
     2ea:	ff 75 0c             	pushl  0xc(%ebp)
     2ed:	e8 37 ff ff ff       	call   229 <matchhere>
     2f2:	83 c4 10             	add    $0x10,%esp
     2f5:	85 c0                	test   %eax,%eax
     2f7:	74 07                	je     300 <matchstar+0x22>
      return 1;
     2f9:	b8 01 00 00 00       	mov    $0x1,%eax
     2fe:	eb 29                	jmp    329 <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
     300:	8b 45 10             	mov    0x10(%ebp),%eax
     303:	0f b6 00             	movzbl (%eax),%eax
     306:	84 c0                	test   %al,%al
     308:	74 1a                	je     324 <matchstar+0x46>
     30a:	8b 45 10             	mov    0x10(%ebp),%eax
     30d:	8d 50 01             	lea    0x1(%eax),%edx
     310:	89 55 10             	mov    %edx,0x10(%ebp)
     313:	0f b6 00             	movzbl (%eax),%eax
     316:	0f be c0             	movsbl %al,%eax
     319:	3b 45 08             	cmp    0x8(%ebp),%eax
     31c:	74 c6                	je     2e4 <matchstar+0x6>
     31e:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
     322:	74 c0                	je     2e4 <matchstar+0x6>
  return 0;
     324:	b8 00 00 00 00       	mov    $0x0,%eax
}
     329:	c9                   	leave  
     32a:	c3                   	ret    

0000032b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     32b:	55                   	push   %ebp
     32c:	89 e5                	mov    %esp,%ebp
     32e:	57                   	push   %edi
     32f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     330:	8b 4d 08             	mov    0x8(%ebp),%ecx
     333:	8b 55 10             	mov    0x10(%ebp),%edx
     336:	8b 45 0c             	mov    0xc(%ebp),%eax
     339:	89 cb                	mov    %ecx,%ebx
     33b:	89 df                	mov    %ebx,%edi
     33d:	89 d1                	mov    %edx,%ecx
     33f:	fc                   	cld    
     340:	f3 aa                	rep stos %al,%es:(%edi)
     342:	89 ca                	mov    %ecx,%edx
     344:	89 fb                	mov    %edi,%ebx
     346:	89 5d 08             	mov    %ebx,0x8(%ebp)
     349:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     34c:	90                   	nop
     34d:	5b                   	pop    %ebx
     34e:	5f                   	pop    %edi
     34f:	5d                   	pop    %ebp
     350:	c3                   	ret    

00000351 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     351:	55                   	push   %ebp
     352:	89 e5                	mov    %esp,%ebp
     354:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     357:	8b 45 08             	mov    0x8(%ebp),%eax
     35a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     35d:	90                   	nop
     35e:	8b 45 08             	mov    0x8(%ebp),%eax
     361:	8d 50 01             	lea    0x1(%eax),%edx
     364:	89 55 08             	mov    %edx,0x8(%ebp)
     367:	8b 55 0c             	mov    0xc(%ebp),%edx
     36a:	8d 4a 01             	lea    0x1(%edx),%ecx
     36d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     370:	0f b6 12             	movzbl (%edx),%edx
     373:	88 10                	mov    %dl,(%eax)
     375:	0f b6 00             	movzbl (%eax),%eax
     378:	84 c0                	test   %al,%al
     37a:	75 e2                	jne    35e <strcpy+0xd>
    ;
  return os;
     37c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     37f:	c9                   	leave  
     380:	c3                   	ret    

00000381 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     381:	55                   	push   %ebp
     382:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     384:	eb 08                	jmp    38e <strcmp+0xd>
    p++, q++;
     386:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     38a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     38e:	8b 45 08             	mov    0x8(%ebp),%eax
     391:	0f b6 00             	movzbl (%eax),%eax
     394:	84 c0                	test   %al,%al
     396:	74 10                	je     3a8 <strcmp+0x27>
     398:	8b 45 08             	mov    0x8(%ebp),%eax
     39b:	0f b6 10             	movzbl (%eax),%edx
     39e:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a1:	0f b6 00             	movzbl (%eax),%eax
     3a4:	38 c2                	cmp    %al,%dl
     3a6:	74 de                	je     386 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     3a8:	8b 45 08             	mov    0x8(%ebp),%eax
     3ab:	0f b6 00             	movzbl (%eax),%eax
     3ae:	0f b6 d0             	movzbl %al,%edx
     3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b4:	0f b6 00             	movzbl (%eax),%eax
     3b7:	0f b6 c0             	movzbl %al,%eax
     3ba:	29 c2                	sub    %eax,%edx
     3bc:	89 d0                	mov    %edx,%eax
}
     3be:	5d                   	pop    %ebp
     3bf:	c3                   	ret    

000003c0 <strlen>:

uint
strlen(char *s)
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3cd:	eb 04                	jmp    3d3 <strlen+0x13>
     3cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3d6:	8b 45 08             	mov    0x8(%ebp),%eax
     3d9:	01 d0                	add    %edx,%eax
     3db:	0f b6 00             	movzbl (%eax),%eax
     3de:	84 c0                	test   %al,%al
     3e0:	75 ed                	jne    3cf <strlen+0xf>
    ;
  return n;
     3e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3e5:	c9                   	leave  
     3e6:	c3                   	ret    

000003e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
     3e7:	55                   	push   %ebp
     3e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     3ea:	8b 45 10             	mov    0x10(%ebp),%eax
     3ed:	50                   	push   %eax
     3ee:	ff 75 0c             	pushl  0xc(%ebp)
     3f1:	ff 75 08             	pushl  0x8(%ebp)
     3f4:	e8 32 ff ff ff       	call   32b <stosb>
     3f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
     3fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3ff:	c9                   	leave  
     400:	c3                   	ret    

00000401 <strchr>:

char*
strchr(const char *s, char c)
{
     401:	55                   	push   %ebp
     402:	89 e5                	mov    %esp,%ebp
     404:	83 ec 04             	sub    $0x4,%esp
     407:	8b 45 0c             	mov    0xc(%ebp),%eax
     40a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     40d:	eb 14                	jmp    423 <strchr+0x22>
    if(*s == c)
     40f:	8b 45 08             	mov    0x8(%ebp),%eax
     412:	0f b6 00             	movzbl (%eax),%eax
     415:	3a 45 fc             	cmp    -0x4(%ebp),%al
     418:	75 05                	jne    41f <strchr+0x1e>
      return (char*)s;
     41a:	8b 45 08             	mov    0x8(%ebp),%eax
     41d:	eb 13                	jmp    432 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     41f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     423:	8b 45 08             	mov    0x8(%ebp),%eax
     426:	0f b6 00             	movzbl (%eax),%eax
     429:	84 c0                	test   %al,%al
     42b:	75 e2                	jne    40f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     42d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     432:	c9                   	leave  
     433:	c3                   	ret    

00000434 <gets>:

char*
gets(char *buf, int max)
{
     434:	55                   	push   %ebp
     435:	89 e5                	mov    %esp,%ebp
     437:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     43a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     441:	eb 42                	jmp    485 <gets+0x51>
    cc = read(0, &c, 1);
     443:	83 ec 04             	sub    $0x4,%esp
     446:	6a 01                	push   $0x1
     448:	8d 45 ef             	lea    -0x11(%ebp),%eax
     44b:	50                   	push   %eax
     44c:	6a 00                	push   $0x0
     44e:	e8 47 01 00 00       	call   59a <read>
     453:	83 c4 10             	add    $0x10,%esp
     456:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     459:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     45d:	7e 33                	jle    492 <gets+0x5e>
      break;
    buf[i++] = c;
     45f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     462:	8d 50 01             	lea    0x1(%eax),%edx
     465:	89 55 f4             	mov    %edx,-0xc(%ebp)
     468:	89 c2                	mov    %eax,%edx
     46a:	8b 45 08             	mov    0x8(%ebp),%eax
     46d:	01 c2                	add    %eax,%edx
     46f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     473:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     475:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     479:	3c 0a                	cmp    $0xa,%al
     47b:	74 16                	je     493 <gets+0x5f>
     47d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     481:	3c 0d                	cmp    $0xd,%al
     483:	74 0e                	je     493 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     485:	8b 45 f4             	mov    -0xc(%ebp),%eax
     488:	83 c0 01             	add    $0x1,%eax
     48b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     48e:	7c b3                	jl     443 <gets+0xf>
     490:	eb 01                	jmp    493 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     492:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     493:	8b 55 f4             	mov    -0xc(%ebp),%edx
     496:	8b 45 08             	mov    0x8(%ebp),%eax
     499:	01 d0                	add    %edx,%eax
     49b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     49e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4a1:	c9                   	leave  
     4a2:	c3                   	ret    

000004a3 <stat>:

int
stat(char *n, struct stat *st)
{
     4a3:	55                   	push   %ebp
     4a4:	89 e5                	mov    %esp,%ebp
     4a6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     4a9:	83 ec 08             	sub    $0x8,%esp
     4ac:	6a 00                	push   $0x0
     4ae:	ff 75 08             	pushl  0x8(%ebp)
     4b1:	e8 0c 01 00 00       	call   5c2 <open>
     4b6:	83 c4 10             	add    $0x10,%esp
     4b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     4bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4c0:	79 07                	jns    4c9 <stat+0x26>
    return -1;
     4c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4c7:	eb 25                	jmp    4ee <stat+0x4b>
  r = fstat(fd, st);
     4c9:	83 ec 08             	sub    $0x8,%esp
     4cc:	ff 75 0c             	pushl  0xc(%ebp)
     4cf:	ff 75 f4             	pushl  -0xc(%ebp)
     4d2:	e8 03 01 00 00       	call   5da <fstat>
     4d7:	83 c4 10             	add    $0x10,%esp
     4da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     4dd:	83 ec 0c             	sub    $0xc,%esp
     4e0:	ff 75 f4             	pushl  -0xc(%ebp)
     4e3:	e8 c2 00 00 00       	call   5aa <close>
     4e8:	83 c4 10             	add    $0x10,%esp
  return r;
     4eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     4ee:	c9                   	leave  
     4ef:	c3                   	ret    

000004f0 <atoi>:

int
atoi(const char *s)
{
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     4f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     4fd:	eb 25                	jmp    524 <atoi+0x34>
    n = n*10 + *s++ - '0';
     4ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
     502:	89 d0                	mov    %edx,%eax
     504:	c1 e0 02             	shl    $0x2,%eax
     507:	01 d0                	add    %edx,%eax
     509:	01 c0                	add    %eax,%eax
     50b:	89 c1                	mov    %eax,%ecx
     50d:	8b 45 08             	mov    0x8(%ebp),%eax
     510:	8d 50 01             	lea    0x1(%eax),%edx
     513:	89 55 08             	mov    %edx,0x8(%ebp)
     516:	0f b6 00             	movzbl (%eax),%eax
     519:	0f be c0             	movsbl %al,%eax
     51c:	01 c8                	add    %ecx,%eax
     51e:	83 e8 30             	sub    $0x30,%eax
     521:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     524:	8b 45 08             	mov    0x8(%ebp),%eax
     527:	0f b6 00             	movzbl (%eax),%eax
     52a:	3c 2f                	cmp    $0x2f,%al
     52c:	7e 0a                	jle    538 <atoi+0x48>
     52e:	8b 45 08             	mov    0x8(%ebp),%eax
     531:	0f b6 00             	movzbl (%eax),%eax
     534:	3c 39                	cmp    $0x39,%al
     536:	7e c7                	jle    4ff <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     538:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     53b:	c9                   	leave  
     53c:	c3                   	ret    

0000053d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     53d:	55                   	push   %ebp
     53e:	89 e5                	mov    %esp,%ebp
     540:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     543:	8b 45 08             	mov    0x8(%ebp),%eax
     546:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     549:	8b 45 0c             	mov    0xc(%ebp),%eax
     54c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     54f:	eb 17                	jmp    568 <memmove+0x2b>
    *dst++ = *src++;
     551:	8b 45 fc             	mov    -0x4(%ebp),%eax
     554:	8d 50 01             	lea    0x1(%eax),%edx
     557:	89 55 fc             	mov    %edx,-0x4(%ebp)
     55a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     55d:	8d 4a 01             	lea    0x1(%edx),%ecx
     560:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     563:	0f b6 12             	movzbl (%edx),%edx
     566:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     568:	8b 45 10             	mov    0x10(%ebp),%eax
     56b:	8d 50 ff             	lea    -0x1(%eax),%edx
     56e:	89 55 10             	mov    %edx,0x10(%ebp)
     571:	85 c0                	test   %eax,%eax
     573:	7f dc                	jg     551 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     575:	8b 45 08             	mov    0x8(%ebp),%eax
}
     578:	c9                   	leave  
     579:	c3                   	ret    

0000057a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     57a:	b8 01 00 00 00       	mov    $0x1,%eax
     57f:	cd 40                	int    $0x40
     581:	c3                   	ret    

00000582 <exit>:
SYSCALL(exit)
     582:	b8 02 00 00 00       	mov    $0x2,%eax
     587:	cd 40                	int    $0x40
     589:	c3                   	ret    

0000058a <wait>:
SYSCALL(wait)
     58a:	b8 03 00 00 00       	mov    $0x3,%eax
     58f:	cd 40                	int    $0x40
     591:	c3                   	ret    

00000592 <pipe>:
SYSCALL(pipe)
     592:	b8 04 00 00 00       	mov    $0x4,%eax
     597:	cd 40                	int    $0x40
     599:	c3                   	ret    

0000059a <read>:
SYSCALL(read)
     59a:	b8 05 00 00 00       	mov    $0x5,%eax
     59f:	cd 40                	int    $0x40
     5a1:	c3                   	ret    

000005a2 <write>:
SYSCALL(write)
     5a2:	b8 10 00 00 00       	mov    $0x10,%eax
     5a7:	cd 40                	int    $0x40
     5a9:	c3                   	ret    

000005aa <close>:
SYSCALL(close)
     5aa:	b8 15 00 00 00       	mov    $0x15,%eax
     5af:	cd 40                	int    $0x40
     5b1:	c3                   	ret    

000005b2 <kill>:
SYSCALL(kill)
     5b2:	b8 06 00 00 00       	mov    $0x6,%eax
     5b7:	cd 40                	int    $0x40
     5b9:	c3                   	ret    

000005ba <exec>:
SYSCALL(exec)
     5ba:	b8 07 00 00 00       	mov    $0x7,%eax
     5bf:	cd 40                	int    $0x40
     5c1:	c3                   	ret    

000005c2 <open>:
SYSCALL(open)
     5c2:	b8 0f 00 00 00       	mov    $0xf,%eax
     5c7:	cd 40                	int    $0x40
     5c9:	c3                   	ret    

000005ca <mknod>:
SYSCALL(mknod)
     5ca:	b8 11 00 00 00       	mov    $0x11,%eax
     5cf:	cd 40                	int    $0x40
     5d1:	c3                   	ret    

000005d2 <unlink>:
SYSCALL(unlink)
     5d2:	b8 12 00 00 00       	mov    $0x12,%eax
     5d7:	cd 40                	int    $0x40
     5d9:	c3                   	ret    

000005da <fstat>:
SYSCALL(fstat)
     5da:	b8 08 00 00 00       	mov    $0x8,%eax
     5df:	cd 40                	int    $0x40
     5e1:	c3                   	ret    

000005e2 <link>:
SYSCALL(link)
     5e2:	b8 13 00 00 00       	mov    $0x13,%eax
     5e7:	cd 40                	int    $0x40
     5e9:	c3                   	ret    

000005ea <mkdir>:
SYSCALL(mkdir)
     5ea:	b8 14 00 00 00       	mov    $0x14,%eax
     5ef:	cd 40                	int    $0x40
     5f1:	c3                   	ret    

000005f2 <chdir>:
SYSCALL(chdir)
     5f2:	b8 09 00 00 00       	mov    $0x9,%eax
     5f7:	cd 40                	int    $0x40
     5f9:	c3                   	ret    

000005fa <dup>:
SYSCALL(dup)
     5fa:	b8 0a 00 00 00       	mov    $0xa,%eax
     5ff:	cd 40                	int    $0x40
     601:	c3                   	ret    

00000602 <getpid>:
SYSCALL(getpid)
     602:	b8 0b 00 00 00       	mov    $0xb,%eax
     607:	cd 40                	int    $0x40
     609:	c3                   	ret    

0000060a <sbrk>:
SYSCALL(sbrk)
     60a:	b8 0c 00 00 00       	mov    $0xc,%eax
     60f:	cd 40                	int    $0x40
     611:	c3                   	ret    

00000612 <sleep>:
SYSCALL(sleep)
     612:	b8 0d 00 00 00       	mov    $0xd,%eax
     617:	cd 40                	int    $0x40
     619:	c3                   	ret    

0000061a <uptime>:
SYSCALL(uptime)
     61a:	b8 0e 00 00 00       	mov    $0xe,%eax
     61f:	cd 40                	int    $0x40
     621:	c3                   	ret    

00000622 <paintWindow>:

SYSCALL(paintWindow)
     622:	b8 16 00 00 00       	mov    $0x16,%eax
     627:	cd 40                	int    $0x40
     629:	c3                   	ret    

0000062a <initStringFigure>:
SYSCALL(initStringFigure)
     62a:	b8 17 00 00 00       	mov    $0x17,%eax
     62f:	cd 40                	int    $0x40
     631:	c3                   	ret    

00000632 <sendMessage>:
SYSCALL(sendMessage)
     632:	b8 18 00 00 00       	mov    $0x18,%eax
     637:	cd 40                	int    $0x40
     639:	c3                   	ret    

0000063a <getMessage>:
SYSCALL(getMessage)
     63a:	b8 1a 00 00 00       	mov    $0x1a,%eax
     63f:	cd 40                	int    $0x40
     641:	c3                   	ret    

00000642 <registWindow>:
SYSCALL(registWindow)
     642:	b8 19 00 00 00       	mov    $0x19,%eax
     647:	cd 40                	int    $0x40
     649:	c3                   	ret    

0000064a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     64a:	55                   	push   %ebp
     64b:	89 e5                	mov    %esp,%ebp
     64d:	83 ec 18             	sub    $0x18,%esp
     650:	8b 45 0c             	mov    0xc(%ebp),%eax
     653:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     656:	83 ec 04             	sub    $0x4,%esp
     659:	6a 01                	push   $0x1
     65b:	8d 45 f4             	lea    -0xc(%ebp),%eax
     65e:	50                   	push   %eax
     65f:	ff 75 08             	pushl  0x8(%ebp)
     662:	e8 3b ff ff ff       	call   5a2 <write>
     667:	83 c4 10             	add    $0x10,%esp
}
     66a:	90                   	nop
     66b:	c9                   	leave  
     66c:	c3                   	ret    

0000066d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     66d:	55                   	push   %ebp
     66e:	89 e5                	mov    %esp,%ebp
     670:	53                   	push   %ebx
     671:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     674:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     67b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     67f:	74 17                	je     698 <printint+0x2b>
     681:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     685:	79 11                	jns    698 <printint+0x2b>
    neg = 1;
     687:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     68e:	8b 45 0c             	mov    0xc(%ebp),%eax
     691:	f7 d8                	neg    %eax
     693:	89 45 ec             	mov    %eax,-0x14(%ebp)
     696:	eb 06                	jmp    69e <printint+0x31>
  } else {
    x = xx;
     698:	8b 45 0c             	mov    0xc(%ebp),%eax
     69b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     69e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6a5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6a8:	8d 41 01             	lea    0x1(%ecx),%eax
     6ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6ae:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6b4:	ba 00 00 00 00       	mov    $0x0,%edx
     6b9:	f7 f3                	div    %ebx
     6bb:	89 d0                	mov    %edx,%eax
     6bd:	0f b6 80 a8 2a 00 00 	movzbl 0x2aa8(%eax),%eax
     6c4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     6c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6ce:	ba 00 00 00 00       	mov    $0x0,%edx
     6d3:	f7 f3                	div    %ebx
     6d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6dc:	75 c7                	jne    6a5 <printint+0x38>
  if(neg)
     6de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6e2:	74 2d                	je     711 <printint+0xa4>
    buf[i++] = '-';
     6e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e7:	8d 50 01             	lea    0x1(%eax),%edx
     6ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6ed:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     6f2:	eb 1d                	jmp    711 <printint+0xa4>
    putc(fd, buf[i]);
     6f4:	8d 55 dc             	lea    -0x24(%ebp),%edx
     6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6fa:	01 d0                	add    %edx,%eax
     6fc:	0f b6 00             	movzbl (%eax),%eax
     6ff:	0f be c0             	movsbl %al,%eax
     702:	83 ec 08             	sub    $0x8,%esp
     705:	50                   	push   %eax
     706:	ff 75 08             	pushl  0x8(%ebp)
     709:	e8 3c ff ff ff       	call   64a <putc>
     70e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     711:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     715:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     719:	79 d9                	jns    6f4 <printint+0x87>
    putc(fd, buf[i]);
}
     71b:	90                   	nop
     71c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     71f:	c9                   	leave  
     720:	c3                   	ret    

00000721 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     721:	55                   	push   %ebp
     722:	89 e5                	mov    %esp,%ebp
     724:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     727:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     72e:	8d 45 0c             	lea    0xc(%ebp),%eax
     731:	83 c0 04             	add    $0x4,%eax
     734:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     737:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     73e:	e9 59 01 00 00       	jmp    89c <printf+0x17b>
    c = fmt[i] & 0xff;
     743:	8b 55 0c             	mov    0xc(%ebp),%edx
     746:	8b 45 f0             	mov    -0x10(%ebp),%eax
     749:	01 d0                	add    %edx,%eax
     74b:	0f b6 00             	movzbl (%eax),%eax
     74e:	0f be c0             	movsbl %al,%eax
     751:	25 ff 00 00 00       	and    $0xff,%eax
     756:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     759:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     75d:	75 2c                	jne    78b <printf+0x6a>
      if(c == '%'){
     75f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     763:	75 0c                	jne    771 <printf+0x50>
        state = '%';
     765:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     76c:	e9 27 01 00 00       	jmp    898 <printf+0x177>
      } else {
        putc(fd, c);
     771:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     774:	0f be c0             	movsbl %al,%eax
     777:	83 ec 08             	sub    $0x8,%esp
     77a:	50                   	push   %eax
     77b:	ff 75 08             	pushl  0x8(%ebp)
     77e:	e8 c7 fe ff ff       	call   64a <putc>
     783:	83 c4 10             	add    $0x10,%esp
     786:	e9 0d 01 00 00       	jmp    898 <printf+0x177>
      }
    } else if(state == '%'){
     78b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     78f:	0f 85 03 01 00 00    	jne    898 <printf+0x177>
      if(c == 'd'){
     795:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     799:	75 1e                	jne    7b9 <printf+0x98>
        printint(fd, *ap, 10, 1);
     79b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     79e:	8b 00                	mov    (%eax),%eax
     7a0:	6a 01                	push   $0x1
     7a2:	6a 0a                	push   $0xa
     7a4:	50                   	push   %eax
     7a5:	ff 75 08             	pushl  0x8(%ebp)
     7a8:	e8 c0 fe ff ff       	call   66d <printint>
     7ad:	83 c4 10             	add    $0x10,%esp
        ap++;
     7b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7b4:	e9 d8 00 00 00       	jmp    891 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7b9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7bd:	74 06                	je     7c5 <printf+0xa4>
     7bf:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7c3:	75 1e                	jne    7e3 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7c8:	8b 00                	mov    (%eax),%eax
     7ca:	6a 00                	push   $0x0
     7cc:	6a 10                	push   $0x10
     7ce:	50                   	push   %eax
     7cf:	ff 75 08             	pushl  0x8(%ebp)
     7d2:	e8 96 fe ff ff       	call   66d <printint>
     7d7:	83 c4 10             	add    $0x10,%esp
        ap++;
     7da:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7de:	e9 ae 00 00 00       	jmp    891 <printf+0x170>
      } else if(c == 's'){
     7e3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     7e7:	75 43                	jne    82c <printf+0x10b>
        s = (char*)*ap;
     7e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7ec:	8b 00                	mov    (%eax),%eax
     7ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     7f1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     7f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7f9:	75 25                	jne    820 <printf+0xff>
          s = "(null)";
     7fb:	c7 45 f4 9a 23 00 00 	movl   $0x239a,-0xc(%ebp)
        while(*s != 0){
     802:	eb 1c                	jmp    820 <printf+0xff>
          putc(fd, *s);
     804:	8b 45 f4             	mov    -0xc(%ebp),%eax
     807:	0f b6 00             	movzbl (%eax),%eax
     80a:	0f be c0             	movsbl %al,%eax
     80d:	83 ec 08             	sub    $0x8,%esp
     810:	50                   	push   %eax
     811:	ff 75 08             	pushl  0x8(%ebp)
     814:	e8 31 fe ff ff       	call   64a <putc>
     819:	83 c4 10             	add    $0x10,%esp
          s++;
     81c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     820:	8b 45 f4             	mov    -0xc(%ebp),%eax
     823:	0f b6 00             	movzbl (%eax),%eax
     826:	84 c0                	test   %al,%al
     828:	75 da                	jne    804 <printf+0xe3>
     82a:	eb 65                	jmp    891 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     82c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     830:	75 1d                	jne    84f <printf+0x12e>
        putc(fd, *ap);
     832:	8b 45 e8             	mov    -0x18(%ebp),%eax
     835:	8b 00                	mov    (%eax),%eax
     837:	0f be c0             	movsbl %al,%eax
     83a:	83 ec 08             	sub    $0x8,%esp
     83d:	50                   	push   %eax
     83e:	ff 75 08             	pushl  0x8(%ebp)
     841:	e8 04 fe ff ff       	call   64a <putc>
     846:	83 c4 10             	add    $0x10,%esp
        ap++;
     849:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     84d:	eb 42                	jmp    891 <printf+0x170>
      } else if(c == '%'){
     84f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     853:	75 17                	jne    86c <printf+0x14b>
        putc(fd, c);
     855:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     858:	0f be c0             	movsbl %al,%eax
     85b:	83 ec 08             	sub    $0x8,%esp
     85e:	50                   	push   %eax
     85f:	ff 75 08             	pushl  0x8(%ebp)
     862:	e8 e3 fd ff ff       	call   64a <putc>
     867:	83 c4 10             	add    $0x10,%esp
     86a:	eb 25                	jmp    891 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     86c:	83 ec 08             	sub    $0x8,%esp
     86f:	6a 25                	push   $0x25
     871:	ff 75 08             	pushl  0x8(%ebp)
     874:	e8 d1 fd ff ff       	call   64a <putc>
     879:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     87c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     87f:	0f be c0             	movsbl %al,%eax
     882:	83 ec 08             	sub    $0x8,%esp
     885:	50                   	push   %eax
     886:	ff 75 08             	pushl  0x8(%ebp)
     889:	e8 bc fd ff ff       	call   64a <putc>
     88e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     891:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     898:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     89c:	8b 55 0c             	mov    0xc(%ebp),%edx
     89f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a2:	01 d0                	add    %edx,%eax
     8a4:	0f b6 00             	movzbl (%eax),%eax
     8a7:	84 c0                	test   %al,%al
     8a9:	0f 85 94 fe ff ff    	jne    743 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8af:	90                   	nop
     8b0:	c9                   	leave  
     8b1:	c3                   	ret    

000008b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8b2:	55                   	push   %ebp
     8b3:	89 e5                	mov    %esp,%ebp
     8b5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8b8:	8b 45 08             	mov    0x8(%ebp),%eax
     8bb:	83 e8 08             	sub    $0x8,%eax
     8be:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8c1:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     8c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8c9:	eb 24                	jmp    8ef <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ce:	8b 00                	mov    (%eax),%eax
     8d0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8d3:	77 12                	ja     8e7 <free+0x35>
     8d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8db:	77 24                	ja     901 <free+0x4f>
     8dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8e0:	8b 00                	mov    (%eax),%eax
     8e2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     8e5:	77 1a                	ja     901 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ea:	8b 00                	mov    (%eax),%eax
     8ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8f5:	76 d4                	jbe    8cb <free+0x19>
     8f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8fa:	8b 00                	mov    (%eax),%eax
     8fc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     8ff:	76 ca                	jbe    8cb <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     901:	8b 45 f8             	mov    -0x8(%ebp),%eax
     904:	8b 40 04             	mov    0x4(%eax),%eax
     907:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     90e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     911:	01 c2                	add    %eax,%edx
     913:	8b 45 fc             	mov    -0x4(%ebp),%eax
     916:	8b 00                	mov    (%eax),%eax
     918:	39 c2                	cmp    %eax,%edx
     91a:	75 24                	jne    940 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     91c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     91f:	8b 50 04             	mov    0x4(%eax),%edx
     922:	8b 45 fc             	mov    -0x4(%ebp),%eax
     925:	8b 00                	mov    (%eax),%eax
     927:	8b 40 04             	mov    0x4(%eax),%eax
     92a:	01 c2                	add    %eax,%edx
     92c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     932:	8b 45 fc             	mov    -0x4(%ebp),%eax
     935:	8b 00                	mov    (%eax),%eax
     937:	8b 10                	mov    (%eax),%edx
     939:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93c:	89 10                	mov    %edx,(%eax)
     93e:	eb 0a                	jmp    94a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     940:	8b 45 fc             	mov    -0x4(%ebp),%eax
     943:	8b 10                	mov    (%eax),%edx
     945:	8b 45 f8             	mov    -0x8(%ebp),%eax
     948:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     94a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     94d:	8b 40 04             	mov    0x4(%eax),%eax
     950:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     957:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95a:	01 d0                	add    %edx,%eax
     95c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     95f:	75 20                	jne    981 <free+0xcf>
    p->s.size += bp->s.size;
     961:	8b 45 fc             	mov    -0x4(%ebp),%eax
     964:	8b 50 04             	mov    0x4(%eax),%edx
     967:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96a:	8b 40 04             	mov    0x4(%eax),%eax
     96d:	01 c2                	add    %eax,%edx
     96f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     972:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     975:	8b 45 f8             	mov    -0x8(%ebp),%eax
     978:	8b 10                	mov    (%eax),%edx
     97a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97d:	89 10                	mov    %edx,(%eax)
     97f:	eb 08                	jmp    989 <free+0xd7>
  } else
    p->s.ptr = bp;
     981:	8b 45 fc             	mov    -0x4(%ebp),%eax
     984:	8b 55 f8             	mov    -0x8(%ebp),%edx
     987:	89 10                	mov    %edx,(%eax)
  freep = p;
     989:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98c:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
}
     991:	90                   	nop
     992:	c9                   	leave  
     993:	c3                   	ret    

00000994 <morecore>:

static Header*
morecore(uint nu)
{
     994:	55                   	push   %ebp
     995:	89 e5                	mov    %esp,%ebp
     997:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     99a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9a1:	77 07                	ja     9aa <morecore+0x16>
    nu = 4096;
     9a3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9aa:	8b 45 08             	mov    0x8(%ebp),%eax
     9ad:	c1 e0 03             	shl    $0x3,%eax
     9b0:	83 ec 0c             	sub    $0xc,%esp
     9b3:	50                   	push   %eax
     9b4:	e8 51 fc ff ff       	call   60a <sbrk>
     9b9:	83 c4 10             	add    $0x10,%esp
     9bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9bf:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9c3:	75 07                	jne    9cc <morecore+0x38>
    return 0;
     9c5:	b8 00 00 00 00       	mov    $0x0,%eax
     9ca:	eb 26                	jmp    9f2 <morecore+0x5e>
  hp = (Header*)p;
     9cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9d5:	8b 55 08             	mov    0x8(%ebp),%edx
     9d8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9db:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9de:	83 c0 08             	add    $0x8,%eax
     9e1:	83 ec 0c             	sub    $0xc,%esp
     9e4:	50                   	push   %eax
     9e5:	e8 c8 fe ff ff       	call   8b2 <free>
     9ea:	83 c4 10             	add    $0x10,%esp
  return freep;
     9ed:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
}
     9f2:	c9                   	leave  
     9f3:	c3                   	ret    

000009f4 <malloc>:

void*
malloc(uint nbytes)
{
     9f4:	55                   	push   %ebp
     9f5:	89 e5                	mov    %esp,%ebp
     9f7:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     9fa:	8b 45 08             	mov    0x8(%ebp),%eax
     9fd:	83 c0 07             	add    $0x7,%eax
     a00:	c1 e8 03             	shr    $0x3,%eax
     a03:	83 c0 01             	add    $0x1,%eax
     a06:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a09:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     a0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a11:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a15:	75 23                	jne    a3a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a17:	c7 45 f0 e0 2a 00 00 	movl   $0x2ae0,-0x10(%ebp)
     a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a21:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
     a26:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     a2b:	a3 e0 2a 00 00       	mov    %eax,0x2ae0
    base.s.size = 0;
     a30:	c7 05 e4 2a 00 00 00 	movl   $0x0,0x2ae4
     a37:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3d:	8b 00                	mov    (%eax),%eax
     a3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a42:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a45:	8b 40 04             	mov    0x4(%eax),%eax
     a48:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a4b:	72 4d                	jb     a9a <malloc+0xa6>
      if(p->s.size == nunits)
     a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a50:	8b 40 04             	mov    0x4(%eax),%eax
     a53:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a56:	75 0c                	jne    a64 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5b:	8b 10                	mov    (%eax),%edx
     a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a60:	89 10                	mov    %edx,(%eax)
     a62:	eb 26                	jmp    a8a <malloc+0x96>
      else {
        p->s.size -= nunits;
     a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a67:	8b 40 04             	mov    0x4(%eax),%eax
     a6a:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a6d:	89 c2                	mov    %eax,%edx
     a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a72:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a78:	8b 40 04             	mov    0x4(%eax),%eax
     a7b:	c1 e0 03             	shl    $0x3,%eax
     a7e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a84:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a87:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a8d:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
      return (void*)(p + 1);
     a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a95:	83 c0 08             	add    $0x8,%eax
     a98:	eb 3b                	jmp    ad5 <malloc+0xe1>
    }
    if(p == freep)
     a9a:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     a9f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     aa2:	75 1e                	jne    ac2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     aa4:	83 ec 0c             	sub    $0xc,%esp
     aa7:	ff 75 ec             	pushl  -0x14(%ebp)
     aaa:	e8 e5 fe ff ff       	call   994 <morecore>
     aaf:	83 c4 10             	add    $0x10,%esp
     ab2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ab5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ab9:	75 07                	jne    ac2 <malloc+0xce>
        return 0;
     abb:	b8 00 00 00 00       	mov    $0x0,%eax
     ac0:	eb 13                	jmp    ad5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acb:	8b 00                	mov    (%eax),%eax
     acd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     ad0:	e9 6d ff ff ff       	jmp    a42 <malloc+0x4e>
}
     ad5:	c9                   	leave  
     ad6:	c3                   	ret    

00000ad7 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     ad7:	55                   	push   %ebp
     ad8:	89 e5                	mov    %esp,%ebp
     ada:	83 ec 1c             	sub    $0x1c,%esp
     add:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     ae0:	8b 55 10             	mov    0x10(%ebp),%edx
     ae3:	8b 45 14             	mov    0x14(%ebp),%eax
     ae6:	88 4d ec             	mov    %cl,-0x14(%ebp)
     ae9:	88 55 e8             	mov    %dl,-0x18(%ebp)
     aec:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     aef:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     af3:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     af6:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     afa:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     afd:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b01:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b04:	8b 45 08             	mov    0x8(%ebp),%eax
     b07:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b0b:	66 89 10             	mov    %dx,(%eax)
     b0e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b12:	88 50 02             	mov    %dl,0x2(%eax)
}
     b15:	8b 45 08             	mov    0x8(%ebp),%eax
     b18:	c9                   	leave  
     b19:	c2 04 00             	ret    $0x4

00000b1c <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b1c:	55                   	push   %ebp
     b1d:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b1f:	8b 45 08             	mov    0x8(%ebp),%eax
     b22:	2b 45 10             	sub    0x10(%ebp),%eax
     b25:	89 c2                	mov    %eax,%edx
     b27:	8b 45 08             	mov    0x8(%ebp),%eax
     b2a:	2b 45 10             	sub    0x10(%ebp),%eax
     b2d:	0f af d0             	imul   %eax,%edx
     b30:	8b 45 0c             	mov    0xc(%ebp),%eax
     b33:	2b 45 14             	sub    0x14(%ebp),%eax
     b36:	89 c1                	mov    %eax,%ecx
     b38:	8b 45 0c             	mov    0xc(%ebp),%eax
     b3b:	2b 45 14             	sub    0x14(%ebp),%eax
     b3e:	0f af c1             	imul   %ecx,%eax
     b41:	01 d0                	add    %edx,%eax
}
     b43:	5d                   	pop    %ebp
     b44:	c3                   	ret    

00000b45 <abs_int>:

static inline int abs_int(int x)
{
     b45:	55                   	push   %ebp
     b46:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b48:	8b 45 08             	mov    0x8(%ebp),%eax
     b4b:	99                   	cltd   
     b4c:	89 d0                	mov    %edx,%eax
     b4e:	33 45 08             	xor    0x8(%ebp),%eax
     b51:	29 d0                	sub    %edx,%eax
}
     b53:	5d                   	pop    %ebp
     b54:	c3                   	ret    

00000b55 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b55:	55                   	push   %ebp
     b56:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b58:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b5c:	79 07                	jns    b65 <APGetIndex+0x10>
        return X_SMALLER;
     b5e:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b63:	eb 40                	jmp    ba5 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     b65:	8b 45 08             	mov    0x8(%ebp),%eax
     b68:	8b 00                	mov    (%eax),%eax
     b6a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     b6d:	7f 07                	jg     b76 <APGetIndex+0x21>
        return X_BIGGER;
     b6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b74:	eb 2f                	jmp    ba5 <APGetIndex+0x50>
    if (y < 0)
     b76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     b7a:	79 07                	jns    b83 <APGetIndex+0x2e>
        return Y_SMALLER;
     b7c:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     b81:	eb 22                	jmp    ba5 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     b83:	8b 45 08             	mov    0x8(%ebp),%eax
     b86:	8b 40 04             	mov    0x4(%eax),%eax
     b89:	3b 45 10             	cmp    0x10(%ebp),%eax
     b8c:	7f 07                	jg     b95 <APGetIndex+0x40>
        return Y_BIGGER;
     b8e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     b93:	eb 10                	jmp    ba5 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     b95:	8b 45 08             	mov    0x8(%ebp),%eax
     b98:	8b 00                	mov    (%eax),%eax
     b9a:	0f af 45 10          	imul   0x10(%ebp),%eax
     b9e:	89 c2                	mov    %eax,%edx
     ba0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba3:	01 d0                	add    %edx,%eax
}
     ba5:	5d                   	pop    %ebp
     ba6:	c3                   	ret    

00000ba7 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     ba7:	55                   	push   %ebp
     ba8:	89 e5                	mov    %esp,%ebp
     baa:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bad:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bb4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bb7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bba:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bc1:	83 ec 08             	sub    $0x8,%esp
     bc4:	6a 00                	push   $0x0
     bc6:	ff 75 0c             	pushl  0xc(%ebp)
     bc9:	e8 f4 f9 ff ff       	call   5c2 <open>
     bce:	83 c4 10             	add    $0x10,%esp
     bd1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bd4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bd8:	79 2e                	jns    c08 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     bda:	83 ec 04             	sub    $0x4,%esp
     bdd:	ff 75 0c             	pushl  0xc(%ebp)
     be0:	68 a1 23 00 00       	push   $0x23a1
     be5:	6a 01                	push   $0x1
     be7:	e8 35 fb ff ff       	call   721 <printf>
     bec:	83 c4 10             	add    $0x10,%esp
        return bmp;
     bef:	8b 45 08             	mov    0x8(%ebp),%eax
     bf2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bf5:	89 10                	mov    %edx,(%eax)
     bf7:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bfa:	89 50 04             	mov    %edx,0x4(%eax)
     bfd:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c00:	89 50 08             	mov    %edx,0x8(%eax)
     c03:	e9 d2 01 00 00       	jmp    dda <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c08:	83 ec 04             	sub    $0x4,%esp
     c0b:	6a 0e                	push   $0xe
     c0d:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c10:	50                   	push   %eax
     c11:	ff 75 ec             	pushl  -0x14(%ebp)
     c14:	e8 81 f9 ff ff       	call   59a <read>
     c19:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c1c:	83 ec 04             	sub    $0x4,%esp
     c1f:	6a 28                	push   $0x28
     c21:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c24:	50                   	push   %eax
     c25:	ff 75 ec             	pushl  -0x14(%ebp)
     c28:	e8 6d f9 ff ff       	call   59a <read>
     c2d:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c30:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c33:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c36:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c39:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c3c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c3f:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c42:	0f af d0             	imul   %eax,%edx
     c45:	89 d0                	mov    %edx,%eax
     c47:	01 c0                	add    %eax,%eax
     c49:	01 d0                	add    %edx,%eax
     c4b:	83 ec 0c             	sub    $0xc,%esp
     c4e:	50                   	push   %eax
     c4f:	e8 a0 fd ff ff       	call   9f4 <malloc>
     c54:	83 c4 10             	add    $0x10,%esp
     c57:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c5a:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c5e:	0f b7 c0             	movzwl %ax,%eax
     c61:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c64:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c67:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c6a:	0f af c2             	imul   %edx,%eax
     c6d:	83 c0 1f             	add    $0x1f,%eax
     c70:	c1 e8 05             	shr    $0x5,%eax
     c73:	c1 e0 02             	shl    $0x2,%eax
     c76:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     c79:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c7f:	0f af c2             	imul   %edx,%eax
     c82:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     c85:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c88:	83 ec 0c             	sub    $0xc,%esp
     c8b:	50                   	push   %eax
     c8c:	e8 63 fd ff ff       	call   9f4 <malloc>
     c91:	83 c4 10             	add    $0x10,%esp
     c94:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     c97:	83 ec 04             	sub    $0x4,%esp
     c9a:	ff 75 e0             	pushl  -0x20(%ebp)
     c9d:	ff 75 dc             	pushl  -0x24(%ebp)
     ca0:	ff 75 ec             	pushl  -0x14(%ebp)
     ca3:	e8 f2 f8 ff ff       	call   59a <read>
     ca8:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     cab:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     caf:	66 c1 e8 03          	shr    $0x3,%ax
     cb3:	0f b7 c0             	movzwl %ax,%eax
     cb6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     cb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cc0:	e9 e5 00 00 00       	jmp    daa <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     cc5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccb:	29 c2                	sub    %eax,%edx
     ccd:	89 d0                	mov    %edx,%eax
     ccf:	8d 50 ff             	lea    -0x1(%eax),%edx
     cd2:	8b 45 c8             	mov    -0x38(%ebp),%eax
     cd5:	0f af c2             	imul   %edx,%eax
     cd8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     cdb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ce2:	e9 b1 00 00 00       	jmp    d98 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     ce7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     cea:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     ced:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cf0:	01 c8                	add    %ecx,%eax
     cf2:	89 c1                	mov    %eax,%ecx
     cf4:	89 c8                	mov    %ecx,%eax
     cf6:	01 c0                	add    %eax,%eax
     cf8:	01 c8                	add    %ecx,%eax
     cfa:	01 c2                	add    %eax,%edx
     cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cff:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d03:	89 c1                	mov    %eax,%ecx
     d05:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d08:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d0c:	01 c1                	add    %eax,%ecx
     d0e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d11:	01 c8                	add    %ecx,%eax
     d13:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d16:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d19:	01 c8                	add    %ecx,%eax
     d1b:	0f b6 00             	movzbl (%eax),%eax
     d1e:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d21:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d24:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d27:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d2a:	01 c8                	add    %ecx,%eax
     d2c:	89 c1                	mov    %eax,%ecx
     d2e:	89 c8                	mov    %ecx,%eax
     d30:	01 c0                	add    %eax,%eax
     d32:	01 c8                	add    %ecx,%eax
     d34:	01 c2                	add    %eax,%edx
     d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d39:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d3d:	89 c1                	mov    %eax,%ecx
     d3f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d42:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d46:	01 c1                	add    %eax,%ecx
     d48:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d4b:	01 c8                	add    %ecx,%eax
     d4d:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d50:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d53:	01 c8                	add    %ecx,%eax
     d55:	0f b6 00             	movzbl (%eax),%eax
     d58:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d5b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d5e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d61:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d64:	01 c8                	add    %ecx,%eax
     d66:	89 c1                	mov    %eax,%ecx
     d68:	89 c8                	mov    %ecx,%eax
     d6a:	01 c0                	add    %eax,%eax
     d6c:	01 c8                	add    %ecx,%eax
     d6e:	01 c2                	add    %eax,%edx
     d70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d73:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d77:	89 c1                	mov    %eax,%ecx
     d79:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d7c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d80:	01 c1                	add    %eax,%ecx
     d82:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d85:	01 c8                	add    %ecx,%eax
     d87:	8d 48 fd             	lea    -0x3(%eax),%ecx
     d8a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d8d:	01 c8                	add    %ecx,%eax
     d8f:	0f b6 00             	movzbl (%eax),%eax
     d92:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     d94:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     d98:	8b 55 c8             	mov    -0x38(%ebp),%edx
     d9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d9e:	39 c2                	cmp    %eax,%edx
     da0:	0f 87 41 ff ff ff    	ja     ce7 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     da6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     daa:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db0:	39 c2                	cmp    %eax,%edx
     db2:	0f 87 0d ff ff ff    	ja     cc5 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     db8:	83 ec 0c             	sub    $0xc,%esp
     dbb:	ff 75 ec             	pushl  -0x14(%ebp)
     dbe:	e8 e7 f7 ff ff       	call   5aa <close>
     dc3:	83 c4 10             	add    $0x10,%esp
    return bmp;
     dc6:	8b 45 08             	mov    0x8(%ebp),%eax
     dc9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dcc:	89 10                	mov    %edx,(%eax)
     dce:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dd1:	89 50 04             	mov    %edx,0x4(%eax)
     dd4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     dd7:	89 50 08             	mov    %edx,0x8(%eax)
}
     dda:	8b 45 08             	mov    0x8(%ebp),%eax
     ddd:	c9                   	leave  
     dde:	c2 04 00             	ret    $0x4

00000de1 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     de1:	55                   	push   %ebp
     de2:	89 e5                	mov    %esp,%ebp
     de4:	53                   	push   %ebx
     de5:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     de8:	83 ec 0c             	sub    $0xc,%esp
     deb:	6a 1c                	push   $0x1c
     ded:	e8 02 fc ff ff       	call   9f4 <malloc>
     df2:	83 c4 10             	add    $0x10,%esp
     df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfb:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e02:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e05:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e08:	6a 0c                	push   $0xc
     e0a:	6a 0c                	push   $0xc
     e0c:	6a 0c                	push   $0xc
     e0e:	50                   	push   %eax
     e0f:	e8 c3 fc ff ff       	call   ad7 <RGB>
     e14:	83 c4 0c             	add    $0xc,%esp
     e17:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e1b:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e1f:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e23:	88 43 15             	mov    %al,0x15(%ebx)
     e26:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e29:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e2c:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e30:	66 89 48 10          	mov    %cx,0x10(%eax)
     e34:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e38:	88 50 12             	mov    %dl,0x12(%eax)
     e3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e41:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e45:	66 89 48 08          	mov    %cx,0x8(%eax)
     e49:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e4d:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e50:	8b 45 08             	mov    0x8(%ebp),%eax
     e53:	89 c2                	mov    %eax,%edx
     e55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e58:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e5a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e5d:	89 c2                	mov    %eax,%edx
     e5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e62:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     e65:	8b 55 10             	mov    0x10(%ebp),%edx
     e68:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e6b:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     e6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e74:	c9                   	leave  
     e75:	c3                   	ret    

00000e76 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     e76:	55                   	push   %ebp
     e77:	89 e5                	mov    %esp,%ebp
     e79:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7f:	8b 50 08             	mov    0x8(%eax),%edx
     e82:	89 55 f8             	mov    %edx,-0x8(%ebp)
     e85:	8b 40 0c             	mov    0xc(%eax),%eax
     e88:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8e:	8b 55 10             	mov    0x10(%ebp),%edx
     e91:	89 50 08             	mov    %edx,0x8(%eax)
     e94:	8b 55 14             	mov    0x14(%ebp),%edx
     e97:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     e9a:	8b 45 08             	mov    0x8(%ebp),%eax
     e9d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ea0:	89 10                	mov    %edx,(%eax)
     ea2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ea5:	89 50 04             	mov    %edx,0x4(%eax)
}
     ea8:	8b 45 08             	mov    0x8(%ebp),%eax
     eab:	c9                   	leave  
     eac:	c2 04 00             	ret    $0x4

00000eaf <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     eaf:	55                   	push   %ebp
     eb0:	89 e5                	mov    %esp,%ebp
     eb2:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb8:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ebc:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ec0:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ec4:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eca:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     ece:	66 89 50 10          	mov    %dx,0x10(%eax)
     ed2:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     ed6:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     ed9:	8b 45 08             	mov    0x8(%ebp),%eax
     edc:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     ee0:	66 89 10             	mov    %dx,(%eax)
     ee3:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     ee7:	88 50 02             	mov    %dl,0x2(%eax)
}
     eea:	8b 45 08             	mov    0x8(%ebp),%eax
     eed:	c9                   	leave  
     eee:	c2 04 00             	ret    $0x4

00000ef1 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     ef1:	55                   	push   %ebp
     ef2:	89 e5                	mov    %esp,%ebp
     ef4:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     ef7:	8b 45 08             	mov    0x8(%ebp),%eax
     efa:	8b 40 0c             	mov    0xc(%eax),%eax
     efd:	89 c2                	mov    %eax,%edx
     eff:	c1 ea 1f             	shr    $0x1f,%edx
     f02:	01 d0                	add    %edx,%eax
     f04:	d1 f8                	sar    %eax
     f06:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f09:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f0c:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f10:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f13:	8b 45 10             	mov    0x10(%ebp),%eax
     f16:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f19:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f1c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f20:	0f 89 98 00 00 00    	jns    fbe <APDrawPoint+0xcd>
        i = 0;
     f26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f2d:	e9 8c 00 00 00       	jmp    fbe <APDrawPoint+0xcd>
    {
        j = x - off;
     f32:	8b 45 0c             	mov    0xc(%ebp),%eax
     f35:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f38:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f3b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f3f:	79 69                	jns    faa <APDrawPoint+0xb9>
            j = 0;
     f41:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f48:	eb 60                	jmp    faa <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f4a:	ff 75 fc             	pushl  -0x4(%ebp)
     f4d:	ff 75 f8             	pushl  -0x8(%ebp)
     f50:	ff 75 08             	pushl  0x8(%ebp)
     f53:	e8 fd fb ff ff       	call   b55 <APGetIndex>
     f58:	83 c4 0c             	add    $0xc,%esp
     f5b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     f5e:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     f62:	74 55                	je     fb9 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     f64:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     f68:	74 67                	je     fd1 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     f6a:	ff 75 10             	pushl  0x10(%ebp)
     f6d:	ff 75 0c             	pushl  0xc(%ebp)
     f70:	ff 75 fc             	pushl  -0x4(%ebp)
     f73:	ff 75 f8             	pushl  -0x8(%ebp)
     f76:	e8 a1 fb ff ff       	call   b1c <distance_2>
     f7b:	83 c4 10             	add    $0x10,%esp
     f7e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     f81:	7f 23                	jg     fa6 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     f83:	8b 45 08             	mov    0x8(%ebp),%eax
     f86:	8b 48 18             	mov    0x18(%eax),%ecx
     f89:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f8c:	89 d0                	mov    %edx,%eax
     f8e:	01 c0                	add    %eax,%eax
     f90:	01 d0                	add    %edx,%eax
     f92:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     f95:	8b 45 08             	mov    0x8(%ebp),%eax
     f98:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     f9c:	66 89 0a             	mov    %cx,(%edx)
     f9f:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     fa3:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     fa6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     faa:	8b 55 0c             	mov    0xc(%ebp),%edx
     fad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb0:	01 d0                	add    %edx,%eax
     fb2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     fb5:	7d 93                	jge    f4a <APDrawPoint+0x59>
     fb7:	eb 01                	jmp    fba <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     fb9:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     fba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     fbe:	8b 55 10             	mov    0x10(%ebp),%edx
     fc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc4:	01 d0                	add    %edx,%eax
     fc6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     fc9:	0f 8d 63 ff ff ff    	jge    f32 <APDrawPoint+0x41>
     fcf:	eb 01                	jmp    fd2 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     fd1:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     fd2:	c9                   	leave  
     fd3:	c3                   	ret    

00000fd4 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     fd4:	55                   	push   %ebp
     fd5:	89 e5                	mov    %esp,%ebp
     fd7:	53                   	push   %ebx
     fd8:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fde:	3b 45 14             	cmp    0x14(%ebp),%eax
     fe1:	0f 85 80 00 00 00    	jne    1067 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     fe7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     feb:	0f 88 9d 02 00 00    	js     128e <APDrawLine+0x2ba>
     ff1:	8b 45 08             	mov    0x8(%ebp),%eax
     ff4:	8b 00                	mov    (%eax),%eax
     ff6:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ff9:	0f 8e 8f 02 00 00    	jle    128e <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
     fff:	8b 45 10             	mov    0x10(%ebp),%eax
    1002:	3b 45 18             	cmp    0x18(%ebp),%eax
    1005:	7e 12                	jle    1019 <APDrawLine+0x45>
        {
            int tmp = y2;
    1007:	8b 45 18             	mov    0x18(%ebp),%eax
    100a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    100d:	8b 45 10             	mov    0x10(%ebp),%eax
    1010:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1013:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1016:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1019:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    101d:	79 07                	jns    1026 <APDrawLine+0x52>
    101f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
    1029:	8b 40 04             	mov    0x4(%eax),%eax
    102c:	3b 45 18             	cmp    0x18(%ebp),%eax
    102f:	7d 0c                	jge    103d <APDrawLine+0x69>
    1031:	8b 45 08             	mov    0x8(%ebp),%eax
    1034:	8b 40 04             	mov    0x4(%eax),%eax
    1037:	83 e8 01             	sub    $0x1,%eax
    103a:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    103d:	8b 45 10             	mov    0x10(%ebp),%eax
    1040:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1043:	eb 15                	jmp    105a <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1045:	ff 75 f4             	pushl  -0xc(%ebp)
    1048:	ff 75 0c             	pushl  0xc(%ebp)
    104b:	ff 75 08             	pushl  0x8(%ebp)
    104e:	e8 9e fe ff ff       	call   ef1 <APDrawPoint>
    1053:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1056:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    105a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    105d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1060:	7e e3                	jle    1045 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1062:	e9 2b 02 00 00       	jmp    1292 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1067:	8b 45 10             	mov    0x10(%ebp),%eax
    106a:	3b 45 18             	cmp    0x18(%ebp),%eax
    106d:	75 7f                	jne    10ee <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    106f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1073:	0f 88 18 02 00 00    	js     1291 <APDrawLine+0x2bd>
    1079:	8b 45 08             	mov    0x8(%ebp),%eax
    107c:	8b 40 04             	mov    0x4(%eax),%eax
    107f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1082:	0f 8e 09 02 00 00    	jle    1291 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1088:	8b 45 0c             	mov    0xc(%ebp),%eax
    108b:	3b 45 14             	cmp    0x14(%ebp),%eax
    108e:	7e 12                	jle    10a2 <APDrawLine+0xce>
        {
            int tmp = x2;
    1090:	8b 45 14             	mov    0x14(%ebp),%eax
    1093:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1096:	8b 45 0c             	mov    0xc(%ebp),%eax
    1099:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    109c:	8b 45 d8             	mov    -0x28(%ebp),%eax
    109f:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10a6:	79 07                	jns    10af <APDrawLine+0xdb>
    10a8:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    10af:	8b 45 08             	mov    0x8(%ebp),%eax
    10b2:	8b 00                	mov    (%eax),%eax
    10b4:	3b 45 14             	cmp    0x14(%ebp),%eax
    10b7:	7d 0b                	jge    10c4 <APDrawLine+0xf0>
    10b9:	8b 45 08             	mov    0x8(%ebp),%eax
    10bc:	8b 00                	mov    (%eax),%eax
    10be:	83 e8 01             	sub    $0x1,%eax
    10c1:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    10c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10ca:	eb 15                	jmp    10e1 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    10cc:	ff 75 10             	pushl  0x10(%ebp)
    10cf:	ff 75 f0             	pushl  -0x10(%ebp)
    10d2:	ff 75 08             	pushl  0x8(%ebp)
    10d5:	e8 17 fe ff ff       	call   ef1 <APDrawPoint>
    10da:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    10dd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    10e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10e4:	3b 45 14             	cmp    0x14(%ebp),%eax
    10e7:	7e e3                	jle    10cc <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    10e9:	e9 a4 01 00 00       	jmp    1292 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    10ee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    10f5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    10fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ff:	2b 45 14             	sub    0x14(%ebp),%eax
    1102:	50                   	push   %eax
    1103:	e8 3d fa ff ff       	call   b45 <abs_int>
    1108:	83 c4 04             	add    $0x4,%esp
    110b:	89 c3                	mov    %eax,%ebx
    110d:	8b 45 10             	mov    0x10(%ebp),%eax
    1110:	2b 45 18             	sub    0x18(%ebp),%eax
    1113:	50                   	push   %eax
    1114:	e8 2c fa ff ff       	call   b45 <abs_int>
    1119:	83 c4 04             	add    $0x4,%esp
    111c:	39 c3                	cmp    %eax,%ebx
    111e:	0f 8e b5 00 00 00    	jle    11d9 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1124:	8b 45 10             	mov    0x10(%ebp),%eax
    1127:	2b 45 18             	sub    0x18(%ebp),%eax
    112a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    112d:	db 45 b0             	fildl  -0x50(%ebp)
    1130:	8b 45 0c             	mov    0xc(%ebp),%eax
    1133:	2b 45 14             	sub    0x14(%ebp),%eax
    1136:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1139:	db 45 b0             	fildl  -0x50(%ebp)
    113c:	de f9                	fdivrp %st,%st(1)
    113e:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1141:	8b 45 14             	mov    0x14(%ebp),%eax
    1144:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1147:	7e 0e                	jle    1157 <APDrawLine+0x183>
        {
            s = x1;
    1149:	8b 45 0c             	mov    0xc(%ebp),%eax
    114c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    114f:	8b 45 14             	mov    0x14(%ebp),%eax
    1152:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1155:	eb 0c                	jmp    1163 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1157:	8b 45 14             	mov    0x14(%ebp),%eax
    115a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    115d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1160:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1163:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1167:	79 07                	jns    1170 <APDrawLine+0x19c>
    1169:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1170:	8b 45 08             	mov    0x8(%ebp),%eax
    1173:	8b 00                	mov    (%eax),%eax
    1175:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1178:	7f 0b                	jg     1185 <APDrawLine+0x1b1>
    117a:	8b 45 08             	mov    0x8(%ebp),%eax
    117d:	8b 00                	mov    (%eax),%eax
    117f:	83 e8 01             	sub    $0x1,%eax
    1182:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1185:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1188:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    118b:	eb 3f                	jmp    11cc <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    118d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1190:	2b 45 0c             	sub    0xc(%ebp),%eax
    1193:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1196:	db 45 b0             	fildl  -0x50(%ebp)
    1199:	dc 4d d0             	fmull  -0x30(%ebp)
    119c:	db 45 10             	fildl  0x10(%ebp)
    119f:	de c1                	faddp  %st,%st(1)
    11a1:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11a4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11a8:	b4 0c                	mov    $0xc,%ah
    11aa:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11ae:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11b1:	db 5d cc             	fistpl -0x34(%ebp)
    11b4:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    11b7:	ff 75 cc             	pushl  -0x34(%ebp)
    11ba:	ff 75 e4             	pushl  -0x1c(%ebp)
    11bd:	ff 75 08             	pushl  0x8(%ebp)
    11c0:	e8 2c fd ff ff       	call   ef1 <APDrawPoint>
    11c5:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    11c8:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    11cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11cf:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11d2:	7e b9                	jle    118d <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    11d4:	e9 b9 00 00 00       	jmp    1292 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    11d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11dc:	2b 45 14             	sub    0x14(%ebp),%eax
    11df:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11e2:	db 45 b0             	fildl  -0x50(%ebp)
    11e5:	8b 45 10             	mov    0x10(%ebp),%eax
    11e8:	2b 45 18             	sub    0x18(%ebp),%eax
    11eb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11ee:	db 45 b0             	fildl  -0x50(%ebp)
    11f1:	de f9                	fdivrp %st,%st(1)
    11f3:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    11f6:	8b 45 10             	mov    0x10(%ebp),%eax
    11f9:	3b 45 18             	cmp    0x18(%ebp),%eax
    11fc:	7e 0e                	jle    120c <APDrawLine+0x238>
    {
        s = y2;
    11fe:	8b 45 18             	mov    0x18(%ebp),%eax
    1201:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1204:	8b 45 10             	mov    0x10(%ebp),%eax
    1207:	89 45 e8             	mov    %eax,-0x18(%ebp)
    120a:	eb 0c                	jmp    1218 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    120c:	8b 45 10             	mov    0x10(%ebp),%eax
    120f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1212:	8b 45 18             	mov    0x18(%ebp),%eax
    1215:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1218:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    121c:	79 07                	jns    1225 <APDrawLine+0x251>
    121e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1225:	8b 45 08             	mov    0x8(%ebp),%eax
    1228:	8b 40 04             	mov    0x4(%eax),%eax
    122b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    122e:	7f 0c                	jg     123c <APDrawLine+0x268>
    1230:	8b 45 08             	mov    0x8(%ebp),%eax
    1233:	8b 40 04             	mov    0x4(%eax),%eax
    1236:	83 e8 01             	sub    $0x1,%eax
    1239:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    123c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    123f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1242:	eb 3f                	jmp    1283 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1244:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1247:	2b 45 10             	sub    0x10(%ebp),%eax
    124a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    124d:	db 45 b0             	fildl  -0x50(%ebp)
    1250:	dc 4d c0             	fmull  -0x40(%ebp)
    1253:	db 45 0c             	fildl  0xc(%ebp)
    1256:	de c1                	faddp  %st,%st(1)
    1258:	d9 7d b6             	fnstcw -0x4a(%ebp)
    125b:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    125f:	b4 0c                	mov    $0xc,%ah
    1261:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1265:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1268:	db 5d bc             	fistpl -0x44(%ebp)
    126b:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    126e:	ff 75 e0             	pushl  -0x20(%ebp)
    1271:	ff 75 bc             	pushl  -0x44(%ebp)
    1274:	ff 75 08             	pushl  0x8(%ebp)
    1277:	e8 75 fc ff ff       	call   ef1 <APDrawPoint>
    127c:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    127f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1283:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1286:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1289:	7e b9                	jle    1244 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    128b:	90                   	nop
    128c:	eb 04                	jmp    1292 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    128e:	90                   	nop
    128f:	eb 01                	jmp    1292 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1291:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    1292:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1295:	c9                   	leave  
    1296:	c3                   	ret    

00001297 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1297:	55                   	push   %ebp
    1298:	89 e5                	mov    %esp,%ebp
    129a:	53                   	push   %ebx
    129b:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    129e:	8b 55 10             	mov    0x10(%ebp),%edx
    12a1:	8b 45 18             	mov    0x18(%ebp),%eax
    12a4:	01 d0                	add    %edx,%eax
    12a6:	83 e8 01             	sub    $0x1,%eax
    12a9:	83 ec 04             	sub    $0x4,%esp
    12ac:	50                   	push   %eax
    12ad:	ff 75 0c             	pushl  0xc(%ebp)
    12b0:	ff 75 10             	pushl  0x10(%ebp)
    12b3:	ff 75 0c             	pushl  0xc(%ebp)
    12b6:	ff 75 08             	pushl  0x8(%ebp)
    12b9:	e8 16 fd ff ff       	call   fd4 <APDrawLine>
    12be:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    12c1:	8b 55 0c             	mov    0xc(%ebp),%edx
    12c4:	8b 45 14             	mov    0x14(%ebp),%eax
    12c7:	01 d0                	add    %edx,%eax
    12c9:	83 e8 01             	sub    $0x1,%eax
    12cc:	83 ec 04             	sub    $0x4,%esp
    12cf:	ff 75 10             	pushl  0x10(%ebp)
    12d2:	50                   	push   %eax
    12d3:	ff 75 10             	pushl  0x10(%ebp)
    12d6:	ff 75 0c             	pushl  0xc(%ebp)
    12d9:	ff 75 08             	pushl  0x8(%ebp)
    12dc:	e8 f3 fc ff ff       	call   fd4 <APDrawLine>
    12e1:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    12e4:	8b 55 10             	mov    0x10(%ebp),%edx
    12e7:	8b 45 18             	mov    0x18(%ebp),%eax
    12ea:	01 d0                	add    %edx,%eax
    12ec:	8d 48 ff             	lea    -0x1(%eax),%ecx
    12ef:	8b 55 0c             	mov    0xc(%ebp),%edx
    12f2:	8b 45 14             	mov    0x14(%ebp),%eax
    12f5:	01 d0                	add    %edx,%eax
    12f7:	8d 50 ff             	lea    -0x1(%eax),%edx
    12fa:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    12fd:	8b 45 14             	mov    0x14(%ebp),%eax
    1300:	01 d8                	add    %ebx,%eax
    1302:	83 e8 01             	sub    $0x1,%eax
    1305:	83 ec 04             	sub    $0x4,%esp
    1308:	51                   	push   %ecx
    1309:	52                   	push   %edx
    130a:	ff 75 10             	pushl  0x10(%ebp)
    130d:	50                   	push   %eax
    130e:	ff 75 08             	pushl  0x8(%ebp)
    1311:	e8 be fc ff ff       	call   fd4 <APDrawLine>
    1316:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1319:	8b 55 10             	mov    0x10(%ebp),%edx
    131c:	8b 45 18             	mov    0x18(%ebp),%eax
    131f:	01 d0                	add    %edx,%eax
    1321:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1324:	8b 55 0c             	mov    0xc(%ebp),%edx
    1327:	8b 45 14             	mov    0x14(%ebp),%eax
    132a:	01 d0                	add    %edx,%eax
    132c:	8d 50 ff             	lea    -0x1(%eax),%edx
    132f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1332:	8b 45 18             	mov    0x18(%ebp),%eax
    1335:	01 d8                	add    %ebx,%eax
    1337:	83 e8 01             	sub    $0x1,%eax
    133a:	83 ec 04             	sub    $0x4,%esp
    133d:	51                   	push   %ecx
    133e:	52                   	push   %edx
    133f:	50                   	push   %eax
    1340:	ff 75 0c             	pushl  0xc(%ebp)
    1343:	ff 75 08             	pushl  0x8(%ebp)
    1346:	e8 89 fc ff ff       	call   fd4 <APDrawLine>
    134b:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    134e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1351:	8b 45 14             	mov    0x14(%ebp),%eax
    1354:	01 d0                	add    %edx,%eax
    1356:	8d 50 ff             	lea    -0x1(%eax),%edx
    1359:	8b 45 08             	mov    0x8(%ebp),%eax
    135c:	8b 40 0c             	mov    0xc(%eax),%eax
    135f:	89 c1                	mov    %eax,%ecx
    1361:	c1 e9 1f             	shr    $0x1f,%ecx
    1364:	01 c8                	add    %ecx,%eax
    1366:	d1 f8                	sar    %eax
    1368:	29 c2                	sub    %eax,%edx
    136a:	89 d0                	mov    %edx,%eax
    136c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    136f:	8b 55 10             	mov    0x10(%ebp),%edx
    1372:	8b 45 18             	mov    0x18(%ebp),%eax
    1375:	01 d0                	add    %edx,%eax
    1377:	8d 50 ff             	lea    -0x1(%eax),%edx
    137a:	8b 45 08             	mov    0x8(%ebp),%eax
    137d:	8b 40 0c             	mov    0xc(%eax),%eax
    1380:	89 c1                	mov    %eax,%ecx
    1382:	c1 e9 1f             	shr    $0x1f,%ecx
    1385:	01 c8                	add    %ecx,%eax
    1387:	d1 f8                	sar    %eax
    1389:	29 c2                	sub    %eax,%edx
    138b:	89 d0                	mov    %edx,%eax
    138d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1390:	8b 45 08             	mov    0x8(%ebp),%eax
    1393:	8b 40 0c             	mov    0xc(%eax),%eax
    1396:	89 c2                	mov    %eax,%edx
    1398:	c1 ea 1f             	shr    $0x1f,%edx
    139b:	01 d0                	add    %edx,%eax
    139d:	d1 f8                	sar    %eax
    139f:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13a2:	8b 45 08             	mov    0x8(%ebp),%eax
    13a5:	8b 40 0c             	mov    0xc(%eax),%eax
    13a8:	89 c2                	mov    %eax,%edx
    13aa:	c1 ea 1f             	shr    $0x1f,%edx
    13ad:	01 d0                	add    %edx,%eax
    13af:	d1 f8                	sar    %eax
    13b1:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    13b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13b8:	0f 88 d8 00 00 00    	js     1496 <APDrawRect+0x1ff>
    13be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13c2:	0f 88 ce 00 00 00    	js     1496 <APDrawRect+0x1ff>
    13c8:	8b 45 08             	mov    0x8(%ebp),%eax
    13cb:	8b 00                	mov    (%eax),%eax
    13cd:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13d0:	0f 8e c0 00 00 00    	jle    1496 <APDrawRect+0x1ff>
    13d6:	8b 45 08             	mov    0x8(%ebp),%eax
    13d9:	8b 40 04             	mov    0x4(%eax),%eax
    13dc:	3b 45 10             	cmp    0x10(%ebp),%eax
    13df:	0f 8e b1 00 00 00    	jle    1496 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    13e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13e9:	79 07                	jns    13f2 <APDrawRect+0x15b>
    13eb:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    13f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13f6:	79 07                	jns    13ff <APDrawRect+0x168>
    13f8:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    13ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1402:	8b 00                	mov    (%eax),%eax
    1404:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1407:	7f 0b                	jg     1414 <APDrawRect+0x17d>
    1409:	8b 45 08             	mov    0x8(%ebp),%eax
    140c:	8b 00                	mov    (%eax),%eax
    140e:	83 e8 01             	sub    $0x1,%eax
    1411:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1414:	8b 45 08             	mov    0x8(%ebp),%eax
    1417:	8b 40 04             	mov    0x4(%eax),%eax
    141a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    141d:	7f 0c                	jg     142b <APDrawRect+0x194>
    141f:	8b 45 08             	mov    0x8(%ebp),%eax
    1422:	8b 40 04             	mov    0x4(%eax),%eax
    1425:	83 e8 01             	sub    $0x1,%eax
    1428:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    142b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1432:	8b 45 0c             	mov    0xc(%ebp),%eax
    1435:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1438:	eb 52                	jmp    148c <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    143a:	8b 45 10             	mov    0x10(%ebp),%eax
    143d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1440:	eb 3e                	jmp    1480 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1442:	83 ec 04             	sub    $0x4,%esp
    1445:	ff 75 e8             	pushl  -0x18(%ebp)
    1448:	ff 75 ec             	pushl  -0x14(%ebp)
    144b:	ff 75 08             	pushl  0x8(%ebp)
    144e:	e8 02 f7 ff ff       	call   b55 <APGetIndex>
    1453:	83 c4 10             	add    $0x10,%esp
    1456:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	8b 48 18             	mov    0x18(%eax),%ecx
    145f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1462:	89 d0                	mov    %edx,%eax
    1464:	01 c0                	add    %eax,%eax
    1466:	01 d0                	add    %edx,%eax
    1468:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    146b:	8b 45 08             	mov    0x8(%ebp),%eax
    146e:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1472:	66 89 0a             	mov    %cx,(%edx)
    1475:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1479:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    147c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1480:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1483:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1486:	7e ba                	jle    1442 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1488:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    148c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    148f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1492:	7e a6                	jle    143a <APDrawRect+0x1a3>
    1494:	eb 01                	jmp    1497 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1496:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1497:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    149a:	c9                   	leave  
    149b:	c3                   	ret    

0000149c <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    149c:	55                   	push   %ebp
    149d:	89 e5                	mov    %esp,%ebp
    149f:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14a2:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14a6:	0f 88 8e 01 00 00    	js     163a <APDcCopy+0x19e>
    14ac:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14b0:	0f 88 84 01 00 00    	js     163a <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14b6:	8b 55 0c             	mov    0xc(%ebp),%edx
    14b9:	8b 45 20             	mov    0x20(%ebp),%eax
    14bc:	01 d0                	add    %edx,%eax
    14be:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14c1:	8b 55 10             	mov    0x10(%ebp),%edx
    14c4:	8b 45 24             	mov    0x24(%ebp),%eax
    14c7:	01 d0                	add    %edx,%eax
    14c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14cc:	8b 55 18             	mov    0x18(%ebp),%edx
    14cf:	8b 45 20             	mov    0x20(%ebp),%eax
    14d2:	01 d0                	add    %edx,%eax
    14d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14d7:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14da:	8b 45 24             	mov    0x24(%ebp),%eax
    14dd:	01 d0                	add    %edx,%eax
    14df:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    14e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14e6:	0f 88 51 01 00 00    	js     163d <APDcCopy+0x1a1>
    14ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14f0:	0f 88 47 01 00 00    	js     163d <APDcCopy+0x1a1>
    14f6:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    14fa:	0f 88 3d 01 00 00    	js     163d <APDcCopy+0x1a1>
    1500:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1504:	0f 88 33 01 00 00    	js     163d <APDcCopy+0x1a1>
    150a:	8b 45 14             	mov    0x14(%ebp),%eax
    150d:	8b 00                	mov    (%eax),%eax
    150f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1512:	0f 8c 25 01 00 00    	jl     163d <APDcCopy+0x1a1>
    1518:	8b 45 14             	mov    0x14(%ebp),%eax
    151b:	8b 40 04             	mov    0x4(%eax),%eax
    151e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1521:	0f 8c 16 01 00 00    	jl     163d <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1527:	8b 45 08             	mov    0x8(%ebp),%eax
    152a:	8b 00                	mov    (%eax),%eax
    152c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    152f:	7f 0b                	jg     153c <APDcCopy+0xa0>
    1531:	8b 45 08             	mov    0x8(%ebp),%eax
    1534:	8b 00                	mov    (%eax),%eax
    1536:	83 e8 01             	sub    $0x1,%eax
    1539:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    153c:	8b 45 08             	mov    0x8(%ebp),%eax
    153f:	8b 40 04             	mov    0x4(%eax),%eax
    1542:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1545:	7f 0c                	jg     1553 <APDcCopy+0xb7>
    1547:	8b 45 08             	mov    0x8(%ebp),%eax
    154a:	8b 40 04             	mov    0x4(%eax),%eax
    154d:	83 e8 01             	sub    $0x1,%eax
    1550:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1553:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    155a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1561:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1568:	e9 bc 00 00 00       	jmp    1629 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    156d:	8b 45 08             	mov    0x8(%ebp),%eax
    1570:	8b 00                	mov    (%eax),%eax
    1572:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1575:	8b 55 10             	mov    0x10(%ebp),%edx
    1578:	01 ca                	add    %ecx,%edx
    157a:	0f af d0             	imul   %eax,%edx
    157d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1580:	01 d0                	add    %edx,%eax
    1582:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1585:	8b 45 14             	mov    0x14(%ebp),%eax
    1588:	8b 00                	mov    (%eax),%eax
    158a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    158d:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1590:	01 ca                	add    %ecx,%edx
    1592:	0f af d0             	imul   %eax,%edx
    1595:	8b 45 18             	mov    0x18(%ebp),%eax
    1598:	01 d0                	add    %edx,%eax
    159a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    159d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15a4:	eb 74                	jmp    161a <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15a6:	8b 45 14             	mov    0x14(%ebp),%eax
    15a9:	8b 50 18             	mov    0x18(%eax),%edx
    15ac:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15b2:	01 c8                	add    %ecx,%eax
    15b4:	89 c1                	mov    %eax,%ecx
    15b6:	89 c8                	mov    %ecx,%eax
    15b8:	01 c0                	add    %eax,%eax
    15ba:	01 c8                	add    %ecx,%eax
    15bc:	01 d0                	add    %edx,%eax
    15be:	0f b7 10             	movzwl (%eax),%edx
    15c1:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15c5:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15c9:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15cc:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15d0:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15d4:	38 c2                	cmp    %al,%dl
    15d6:	75 18                	jne    15f0 <APDcCopy+0x154>
    15d8:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15dc:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    15e0:	38 c2                	cmp    %al,%dl
    15e2:	75 0c                	jne    15f0 <APDcCopy+0x154>
    15e4:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    15e8:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    15ec:	38 c2                	cmp    %al,%dl
    15ee:	74 26                	je     1616 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    15f0:	8b 45 08             	mov    0x8(%ebp),%eax
    15f3:	8b 50 18             	mov    0x18(%eax),%edx
    15f6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    15f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15fc:	01 c8                	add    %ecx,%eax
    15fe:	89 c1                	mov    %eax,%ecx
    1600:	89 c8                	mov    %ecx,%eax
    1602:	01 c0                	add    %eax,%eax
    1604:	01 c8                	add    %ecx,%eax
    1606:	01 d0                	add    %edx,%eax
    1608:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    160c:	66 89 10             	mov    %dx,(%eax)
    160f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1613:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1616:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    161a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    161d:	2b 45 0c             	sub    0xc(%ebp),%eax
    1620:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1623:	7d 81                	jge    15a6 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1625:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1629:	8b 45 f8             	mov    -0x8(%ebp),%eax
    162c:	2b 45 10             	sub    0x10(%ebp),%eax
    162f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1632:	0f 8d 35 ff ff ff    	jge    156d <APDcCopy+0xd1>
    1638:	eb 04                	jmp    163e <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    163a:	90                   	nop
    163b:	eb 01                	jmp    163e <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    163d:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    163e:	c9                   	leave  
    163f:	c3                   	ret    

00001640 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1640:	55                   	push   %ebp
    1641:	89 e5                	mov    %esp,%ebp
    1643:	83 ec 1c             	sub    $0x1c,%esp
    1646:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1649:	8b 55 10             	mov    0x10(%ebp),%edx
    164c:	8b 45 14             	mov    0x14(%ebp),%eax
    164f:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1652:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1655:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1658:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    165c:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    165f:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1663:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1666:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    166a:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    166d:	8b 45 08             	mov    0x8(%ebp),%eax
    1670:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1674:	66 89 10             	mov    %dx,(%eax)
    1677:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    167b:	88 50 02             	mov    %dl,0x2(%eax)
}
    167e:	8b 45 08             	mov    0x8(%ebp),%eax
    1681:	c9                   	leave  
    1682:	c2 04 00             	ret    $0x4

00001685 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1685:	55                   	push   %ebp
    1686:	89 e5                	mov    %esp,%ebp
    1688:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    168b:	8b 45 08             	mov    0x8(%ebp),%eax
    168e:	8b 00                	mov    (%eax),%eax
    1690:	83 ec 08             	sub    $0x8,%esp
    1693:	8d 55 0c             	lea    0xc(%ebp),%edx
    1696:	52                   	push   %edx
    1697:	50                   	push   %eax
    1698:	e8 95 ef ff ff       	call   632 <sendMessage>
    169d:	83 c4 10             	add    $0x10,%esp
}
    16a0:	90                   	nop
    16a1:	c9                   	leave  
    16a2:	c3                   	ret    

000016a3 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16a3:	55                   	push   %ebp
    16a4:	89 e5                	mov    %esp,%ebp
    16a6:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16a9:	83 ec 0c             	sub    $0xc,%esp
    16ac:	68 90 00 00 00       	push   $0x90
    16b1:	e8 3e f3 ff ff       	call   9f4 <malloc>
    16b6:	83 c4 10             	add    $0x10,%esp
    16b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16c0:	75 15                	jne    16d7 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16c2:	83 ec 04             	sub    $0x4,%esp
    16c5:	ff 75 08             	pushl  0x8(%ebp)
    16c8:	68 b4 23 00 00       	push   $0x23b4
    16cd:	6a 01                	push   $0x1
    16cf:	e8 4d f0 ff ff       	call   721 <printf>
    16d4:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16da:	83 c0 7c             	add    $0x7c,%eax
    16dd:	83 ec 08             	sub    $0x8,%esp
    16e0:	ff 75 08             	pushl  0x8(%ebp)
    16e3:	50                   	push   %eax
    16e4:	e8 68 ec ff ff       	call   351 <strcpy>
    16e9:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    16ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ef:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    16f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f9:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1700:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1703:	8b 40 34             	mov    0x34(%eax),%eax
    1706:	89 c2                	mov    %eax,%edx
    1708:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170b:	8b 40 38             	mov    0x38(%eax),%eax
    170e:	0f af d0             	imul   %eax,%edx
    1711:	89 d0                	mov    %edx,%eax
    1713:	01 c0                	add    %eax,%eax
    1715:	01 d0                	add    %edx,%eax
    1717:	83 ec 0c             	sub    $0xc,%esp
    171a:	50                   	push   %eax
    171b:	e8 d4 f2 ff ff       	call   9f4 <malloc>
    1720:	83 c4 10             	add    $0x10,%esp
    1723:	89 c2                	mov    %eax,%edx
    1725:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1728:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172e:	8b 40 4c             	mov    0x4c(%eax),%eax
    1731:	85 c0                	test   %eax,%eax
    1733:	75 15                	jne    174a <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1735:	83 ec 04             	sub    $0x4,%esp
    1738:	ff 75 08             	pushl  0x8(%ebp)
    173b:	68 d4 23 00 00       	push   $0x23d4
    1740:	6a 01                	push   $0x1
    1742:	e8 da ef ff ff       	call   721 <printf>
    1747:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174d:	8b 40 34             	mov    0x34(%eax),%eax
    1750:	89 c2                	mov    %eax,%edx
    1752:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1755:	8b 40 38             	mov    0x38(%eax),%eax
    1758:	0f af d0             	imul   %eax,%edx
    175b:	89 d0                	mov    %edx,%eax
    175d:	01 c0                	add    %eax,%eax
    175f:	01 c2                	add    %eax,%edx
    1761:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1764:	8b 40 4c             	mov    0x4c(%eax),%eax
    1767:	83 ec 04             	sub    $0x4,%esp
    176a:	52                   	push   %edx
    176b:	68 ff ff ff 00       	push   $0xffffff
    1770:	50                   	push   %eax
    1771:	e8 71 ec ff ff       	call   3e7 <memset>
    1776:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1779:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177c:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    1783:	e8 7a ee ff ff       	call   602 <getpid>
    1788:	89 c2                	mov    %eax,%edx
    178a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    178d:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1790:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1793:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    179a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179d:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a7:	8b 40 50             	mov    0x50(%eax),%eax
    17aa:	89 c2                	mov    %eax,%edx
    17ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17af:	8b 40 54             	mov    0x54(%eax),%eax
    17b2:	0f af d0             	imul   %eax,%edx
    17b5:	89 d0                	mov    %edx,%eax
    17b7:	01 c0                	add    %eax,%eax
    17b9:	01 d0                	add    %edx,%eax
    17bb:	83 ec 0c             	sub    $0xc,%esp
    17be:	50                   	push   %eax
    17bf:	e8 30 f2 ff ff       	call   9f4 <malloc>
    17c4:	83 c4 10             	add    $0x10,%esp
    17c7:	89 c2                	mov    %eax,%edx
    17c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cc:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    17cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d2:	8b 40 68             	mov    0x68(%eax),%eax
    17d5:	85 c0                	test   %eax,%eax
    17d7:	75 15                	jne    17ee <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17d9:	83 ec 04             	sub    $0x4,%esp
    17dc:	ff 75 08             	pushl  0x8(%ebp)
    17df:	68 f8 23 00 00       	push   $0x23f8
    17e4:	6a 01                	push   $0x1
    17e6:	e8 36 ef ff ff       	call   721 <printf>
    17eb:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f1:	8b 40 34             	mov    0x34(%eax),%eax
    17f4:	89 c2                	mov    %eax,%edx
    17f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f9:	8b 40 38             	mov    0x38(%eax),%eax
    17fc:	0f af d0             	imul   %eax,%edx
    17ff:	89 d0                	mov    %edx,%eax
    1801:	01 c0                	add    %eax,%eax
    1803:	01 c2                	add    %eax,%edx
    1805:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1808:	8b 40 4c             	mov    0x4c(%eax),%eax
    180b:	83 ec 04             	sub    $0x4,%esp
    180e:	52                   	push   %edx
    180f:	68 ff 00 00 00       	push   $0xff
    1814:	50                   	push   %eax
    1815:	e8 cd eb ff ff       	call   3e7 <memset>
    181a:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    181d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1820:	8b 55 0c             	mov    0xc(%ebp),%edx
    1823:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1826:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    182a:	74 35                	je     1861 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    182c:	8b 45 10             	mov    0x10(%ebp),%eax
    182f:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1835:	83 ec 0c             	sub    $0xc,%esp
    1838:	50                   	push   %eax
    1839:	e8 b6 f1 ff ff       	call   9f4 <malloc>
    183e:	83 c4 10             	add    $0x10,%esp
    1841:	89 c2                	mov    %eax,%edx
    1843:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1846:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1849:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184c:	8b 55 10             	mov    0x10(%ebp),%edx
    184f:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1852:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1855:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    185c:	e9 8d 00 00 00       	jmp    18ee <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1861:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1864:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    186b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186e:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1875:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1878:	8b 40 18             	mov    0x18(%eax),%eax
    187b:	89 c2                	mov    %eax,%edx
    187d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1880:	8b 40 1c             	mov    0x1c(%eax),%eax
    1883:	0f af d0             	imul   %eax,%edx
    1886:	89 d0                	mov    %edx,%eax
    1888:	01 c0                	add    %eax,%eax
    188a:	01 d0                	add    %edx,%eax
    188c:	83 ec 0c             	sub    $0xc,%esp
    188f:	50                   	push   %eax
    1890:	e8 5f f1 ff ff       	call   9f4 <malloc>
    1895:	83 c4 10             	add    $0x10,%esp
    1898:	89 c2                	mov    %eax,%edx
    189a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189d:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    18a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a3:	8b 40 30             	mov    0x30(%eax),%eax
    18a6:	85 c0                	test   %eax,%eax
    18a8:	75 15                	jne    18bf <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18aa:	83 ec 04             	sub    $0x4,%esp
    18ad:	ff 75 08             	pushl  0x8(%ebp)
    18b0:	68 20 24 00 00       	push   $0x2420
    18b5:	6a 01                	push   $0x1
    18b7:	e8 65 ee ff ff       	call   721 <printf>
    18bc:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c2:	8b 40 18             	mov    0x18(%eax),%eax
    18c5:	89 c2                	mov    %eax,%edx
    18c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ca:	8b 40 1c             	mov    0x1c(%eax),%eax
    18cd:	0f af d0             	imul   %eax,%edx
    18d0:	89 d0                	mov    %edx,%eax
    18d2:	01 c0                	add    %eax,%eax
    18d4:	01 c2                	add    %eax,%edx
    18d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d9:	8b 40 30             	mov    0x30(%eax),%eax
    18dc:	83 ec 04             	sub    $0x4,%esp
    18df:	52                   	push   %edx
    18e0:	68 ff ff ff 00       	push   $0xffffff
    18e5:	50                   	push   %eax
    18e6:	e8 fc ea ff ff       	call   3e7 <memset>
    18eb:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    18ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    18f1:	c9                   	leave  
    18f2:	c3                   	ret    

000018f3 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    18f3:	55                   	push   %ebp
    18f4:	89 e5                	mov    %esp,%ebp
    18f6:	53                   	push   %ebx
    18f7:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    18fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    18fd:	83 f8 03             	cmp    $0x3,%eax
    1900:	74 02                	je     1904 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1902:	eb 33                	jmp    1937 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1904:	8b 45 08             	mov    0x8(%ebp),%eax
    1907:	8b 48 08             	mov    0x8(%eax),%ecx
    190a:	8b 45 08             	mov    0x8(%ebp),%eax
    190d:	8b 50 38             	mov    0x38(%eax),%edx
    1910:	8b 45 08             	mov    0x8(%ebp),%eax
    1913:	8b 40 34             	mov    0x34(%eax),%eax
    1916:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1919:	83 c3 34             	add    $0x34,%ebx
    191c:	83 ec 0c             	sub    $0xc,%esp
    191f:	51                   	push   %ecx
    1920:	52                   	push   %edx
    1921:	50                   	push   %eax
    1922:	6a 00                	push   $0x0
    1924:	6a 00                	push   $0x0
    1926:	53                   	push   %ebx
    1927:	6a 32                	push   $0x32
    1929:	6a 00                	push   $0x0
    192b:	ff 75 08             	pushl  0x8(%ebp)
    192e:	e8 ef ec ff ff       	call   622 <paintWindow>
    1933:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1936:	90                   	nop
        default: break;
            
            
    }
    return False;
    1937:	b8 00 00 00 00       	mov    $0x0,%eax
}
    193c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    193f:	c9                   	leave  
    1940:	c3                   	ret    

00001941 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1941:	55                   	push   %ebp
    1942:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1944:	8b 45 0c             	mov    0xc(%ebp),%eax
    1947:	8b 50 08             	mov    0x8(%eax),%edx
    194a:	8b 45 08             	mov    0x8(%ebp),%eax
    194d:	8b 00                	mov    (%eax),%eax
    194f:	39 c2                	cmp    %eax,%edx
    1951:	74 07                	je     195a <APPreJudge+0x19>
        return False;
    1953:	b8 00 00 00 00       	mov    $0x0,%eax
    1958:	eb 05                	jmp    195f <APPreJudge+0x1e>
    return True;
    195a:	b8 01 00 00 00       	mov    $0x1,%eax
}
    195f:	5d                   	pop    %ebp
    1960:	c3                   	ret    

00001961 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1961:	55                   	push   %ebp
    1962:	89 e5                	mov    %esp,%ebp
    1964:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1967:	8b 45 08             	mov    0x8(%ebp),%eax
    196a:	8b 55 0c             	mov    0xc(%ebp),%edx
    196d:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1970:	83 ec 0c             	sub    $0xc,%esp
    1973:	ff 75 08             	pushl  0x8(%ebp)
    1976:	e8 c7 ec ff ff       	call   642 <registWindow>
    197b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    197e:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1985:	8b 45 08             	mov    0x8(%ebp),%eax
    1988:	8b 00                	mov    (%eax),%eax
    198a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    198d:	ff 75 f4             	pushl  -0xc(%ebp)
    1990:	ff 75 f0             	pushl  -0x10(%ebp)
    1993:	ff 75 ec             	pushl  -0x14(%ebp)
    1996:	ff 75 08             	pushl  0x8(%ebp)
    1999:	e8 e7 fc ff ff       	call   1685 <APSendMessage>
    199e:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19a1:	83 ec 0c             	sub    $0xc,%esp
    19a4:	ff 75 08             	pushl  0x8(%ebp)
    19a7:	e8 8e ec ff ff       	call   63a <getMessage>
    19ac:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    19af:	8b 45 08             	mov    0x8(%ebp),%eax
    19b2:	83 c0 6c             	add    $0x6c,%eax
    19b5:	83 ec 08             	sub    $0x8,%esp
    19b8:	50                   	push   %eax
    19b9:	ff 75 08             	pushl  0x8(%ebp)
    19bc:	e8 80 ff ff ff       	call   1941 <APPreJudge>
    19c1:	83 c4 10             	add    $0x10,%esp
    19c4:	84 c0                	test   %al,%al
    19c6:	74 1b                	je     19e3 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    19c8:	8b 45 08             	mov    0x8(%ebp),%eax
    19cb:	ff 70 74             	pushl  0x74(%eax)
    19ce:	ff 70 70             	pushl  0x70(%eax)
    19d1:	ff 70 6c             	pushl  0x6c(%eax)
    19d4:	ff 75 08             	pushl  0x8(%ebp)
    19d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    19da:	ff d0                	call   *%eax
    19dc:	83 c4 10             	add    $0x10,%esp
    19df:	84 c0                	test   %al,%al
    19e1:	75 0c                	jne    19ef <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    19e3:	8b 45 08             	mov    0x8(%ebp),%eax
    19e6:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    19ed:	eb b2                	jmp    19a1 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    19ef:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    19f0:	90                   	nop
    19f1:	c9                   	leave  
    19f2:	c3                   	ret    

000019f3 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    19f3:	55                   	push   %ebp
    19f4:	89 e5                	mov    %esp,%ebp
    19f6:	57                   	push   %edi
    19f7:	56                   	push   %esi
    19f8:	53                   	push   %ebx
    19f9:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    19fc:	a1 ec 2a 00 00       	mov    0x2aec,%eax
    1a01:	85 c0                	test   %eax,%eax
    1a03:	0f 85 2c 02 00 00    	jne    1c35 <APGridPaint+0x242>
    {
        iconReady = 1;
    1a09:	c7 05 ec 2a 00 00 01 	movl   $0x1,0x2aec
    1a10:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a13:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a16:	83 ec 08             	sub    $0x8,%esp
    1a19:	68 47 24 00 00       	push   $0x2447
    1a1e:	50                   	push   %eax
    1a1f:	e8 83 f1 ff ff       	call   ba7 <APLoadBitmap>
    1a24:	83 c4 0c             	add    $0xc,%esp
    1a27:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a2a:	a3 20 2f 00 00       	mov    %eax,0x2f20
    1a2f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a32:	a3 24 2f 00 00       	mov    %eax,0x2f24
    1a37:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a3a:	a3 28 2f 00 00       	mov    %eax,0x2f28
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a3f:	83 ec 04             	sub    $0x4,%esp
    1a42:	ff 35 28 2f 00 00    	pushl  0x2f28
    1a48:	ff 35 24 2f 00 00    	pushl  0x2f24
    1a4e:	ff 35 20 2f 00 00    	pushl  0x2f20
    1a54:	e8 88 f3 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1a59:	83 c4 10             	add    $0x10,%esp
    1a5c:	a3 2c 2f 00 00       	mov    %eax,0x2f2c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a61:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a64:	83 ec 08             	sub    $0x8,%esp
    1a67:	68 55 24 00 00       	push   $0x2455
    1a6c:	50                   	push   %eax
    1a6d:	e8 35 f1 ff ff       	call   ba7 <APLoadBitmap>
    1a72:	83 c4 0c             	add    $0xc,%esp
    1a75:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a78:	a3 5c 2f 00 00       	mov    %eax,0x2f5c
    1a7d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a80:	a3 60 2f 00 00       	mov    %eax,0x2f60
    1a85:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a88:	a3 64 2f 00 00       	mov    %eax,0x2f64
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a8d:	83 ec 04             	sub    $0x4,%esp
    1a90:	ff 35 64 2f 00 00    	pushl  0x2f64
    1a96:	ff 35 60 2f 00 00    	pushl  0x2f60
    1a9c:	ff 35 5c 2f 00 00    	pushl  0x2f5c
    1aa2:	e8 3a f3 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1aa7:	83 c4 10             	add    $0x10,%esp
    1aaa:	a3 4c 2f 00 00       	mov    %eax,0x2f4c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1aaf:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ab2:	83 ec 08             	sub    $0x8,%esp
    1ab5:	68 64 24 00 00       	push   $0x2464
    1aba:	50                   	push   %eax
    1abb:	e8 e7 f0 ff ff       	call   ba7 <APLoadBitmap>
    1ac0:	83 c4 0c             	add    $0xc,%esp
    1ac3:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ac6:	a3 50 2f 00 00       	mov    %eax,0x2f50
    1acb:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ace:	a3 54 2f 00 00       	mov    %eax,0x2f54
    1ad3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ad6:	a3 58 2f 00 00       	mov    %eax,0x2f58
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1adb:	83 ec 04             	sub    $0x4,%esp
    1ade:	ff 35 58 2f 00 00    	pushl  0x2f58
    1ae4:	ff 35 54 2f 00 00    	pushl  0x2f54
    1aea:	ff 35 50 2f 00 00    	pushl  0x2f50
    1af0:	e8 ec f2 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1af5:	83 c4 10             	add    $0x10,%esp
    1af8:	a3 00 2f 00 00       	mov    %eax,0x2f00
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1afd:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b00:	83 ec 08             	sub    $0x8,%esp
    1b03:	68 73 24 00 00       	push   $0x2473
    1b08:	50                   	push   %eax
    1b09:	e8 99 f0 ff ff       	call   ba7 <APLoadBitmap>
    1b0e:	83 c4 0c             	add    $0xc,%esp
    1b11:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b14:	a3 34 2f 00 00       	mov    %eax,0x2f34
    1b19:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b1c:	a3 38 2f 00 00       	mov    %eax,0x2f38
    1b21:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b24:	a3 3c 2f 00 00       	mov    %eax,0x2f3c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b29:	83 ec 04             	sub    $0x4,%esp
    1b2c:	ff 35 3c 2f 00 00    	pushl  0x2f3c
    1b32:	ff 35 38 2f 00 00    	pushl  0x2f38
    1b38:	ff 35 34 2f 00 00    	pushl  0x2f34
    1b3e:	e8 9e f2 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1b43:	83 c4 10             	add    $0x10,%esp
    1b46:	a3 68 2f 00 00       	mov    %eax,0x2f68
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b4b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b4e:	83 ec 08             	sub    $0x8,%esp
    1b51:	68 81 24 00 00       	push   $0x2481
    1b56:	50                   	push   %eax
    1b57:	e8 4b f0 ff ff       	call   ba7 <APLoadBitmap>
    1b5c:	83 c4 0c             	add    $0xc,%esp
    1b5f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b62:	a3 10 2f 00 00       	mov    %eax,0x2f10
    1b67:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b6a:	a3 14 2f 00 00       	mov    %eax,0x2f14
    1b6f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b72:	a3 18 2f 00 00       	mov    %eax,0x2f18
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b77:	83 ec 04             	sub    $0x4,%esp
    1b7a:	ff 35 18 2f 00 00    	pushl  0x2f18
    1b80:	ff 35 14 2f 00 00    	pushl  0x2f14
    1b86:	ff 35 10 2f 00 00    	pushl  0x2f10
    1b8c:	e8 50 f2 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1b91:	83 c4 10             	add    $0x10,%esp
    1b94:	a3 30 2f 00 00       	mov    %eax,0x2f30
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1b99:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b9c:	83 ec 08             	sub    $0x8,%esp
    1b9f:	68 91 24 00 00       	push   $0x2491
    1ba4:	50                   	push   %eax
    1ba5:	e8 fd ef ff ff       	call   ba7 <APLoadBitmap>
    1baa:	83 c4 0c             	add    $0xc,%esp
    1bad:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bb0:	a3 04 2f 00 00       	mov    %eax,0x2f04
    1bb5:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bb8:	a3 08 2f 00 00       	mov    %eax,0x2f08
    1bbd:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bc0:	a3 0c 2f 00 00       	mov    %eax,0x2f0c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1bc5:	83 ec 04             	sub    $0x4,%esp
    1bc8:	ff 35 0c 2f 00 00    	pushl  0x2f0c
    1bce:	ff 35 08 2f 00 00    	pushl  0x2f08
    1bd4:	ff 35 04 2f 00 00    	pushl  0x2f04
    1bda:	e8 02 f2 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1bdf:	83 c4 10             	add    $0x10,%esp
    1be2:	a3 1c 2f 00 00       	mov    %eax,0x2f1c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1be7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bea:	83 ec 08             	sub    $0x8,%esp
    1bed:	68 a3 24 00 00       	push   $0x24a3
    1bf2:	50                   	push   %eax
    1bf3:	e8 af ef ff ff       	call   ba7 <APLoadBitmap>
    1bf8:	83 c4 0c             	add    $0xc,%esp
    1bfb:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bfe:	a3 40 2f 00 00       	mov    %eax,0x2f40
    1c03:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c06:	a3 44 2f 00 00       	mov    %eax,0x2f44
    1c0b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c0e:	a3 48 2f 00 00       	mov    %eax,0x2f48
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c13:	83 ec 04             	sub    $0x4,%esp
    1c16:	ff 35 48 2f 00 00    	pushl  0x2f48
    1c1c:	ff 35 44 2f 00 00    	pushl  0x2f44
    1c22:	ff 35 40 2f 00 00    	pushl  0x2f40
    1c28:	e8 b4 f1 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1c2d:	83 c4 10             	add    $0x10,%esp
    1c30:	a3 6c 2f 00 00       	mov    %eax,0x2f6c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c35:	8b 45 08             	mov    0x8(%ebp),%eax
    1c38:	8b 40 08             	mov    0x8(%eax),%eax
    1c3b:	85 c0                	test   %eax,%eax
    1c3d:	75 17                	jne    1c56 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c3f:	83 ec 08             	sub    $0x8,%esp
    1c42:	68 b4 24 00 00       	push   $0x24b4
    1c47:	6a 01                	push   $0x1
    1c49:	e8 d3 ea ff ff       	call   721 <printf>
    1c4e:	83 c4 10             	add    $0x10,%esp
        return;
    1c51:	e9 f2 03 00 00       	jmp    2048 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c56:	8b 45 08             	mov    0x8(%ebp),%eax
    1c59:	8b 40 10             	mov    0x10(%eax),%eax
    1c5c:	85 c0                	test   %eax,%eax
    1c5e:	7e 10                	jle    1c70 <APGridPaint+0x27d>
    1c60:	8b 45 08             	mov    0x8(%ebp),%eax
    1c63:	8b 50 14             	mov    0x14(%eax),%edx
    1c66:	8b 45 08             	mov    0x8(%ebp),%eax
    1c69:	8b 40 10             	mov    0x10(%eax),%eax
    1c6c:	39 c2                	cmp    %eax,%edx
    1c6e:	7c 17                	jl     1c87 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1c70:	83 ec 08             	sub    $0x8,%esp
    1c73:	68 da 24 00 00       	push   $0x24da
    1c78:	6a 01                	push   $0x1
    1c7a:	e8 a2 ea ff ff       	call   721 <printf>
    1c7f:	83 c4 10             	add    $0x10,%esp
        return;
    1c82:	e9 c1 03 00 00       	jmp    2048 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1c87:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8a:	8b 40 14             	mov    0x14(%eax),%eax
    1c8d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1c93:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1c96:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1c99:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1c9c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1ca3:	e9 96 03 00 00       	jmp    203e <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ca8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1caf:	e9 7c 03 00 00       	jmp    2030 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1cb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cb7:	c1 e0 04             	shl    $0x4,%eax
    1cba:	89 c2                	mov    %eax,%edx
    1cbc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1cbf:	01 c2                	add    %eax,%edx
    1cc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cc4:	01 d0                	add    %edx,%eax
    1cc6:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1cc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccc:	8b 40 0c             	mov    0xc(%eax),%eax
    1ccf:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1cd2:	c1 e2 02             	shl    $0x2,%edx
    1cd5:	01 d0                	add    %edx,%eax
    1cd7:	8b 00                	mov    (%eax),%eax
    1cd9:	83 f8 07             	cmp    $0x7,%eax
    1cdc:	0f 87 49 03 00 00    	ja     202b <APGridPaint+0x638>
    1ce2:	8b 04 85 f0 24 00 00 	mov    0x24f0(,%eax,4),%eax
    1ce9:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ceb:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1cee:	6a 0c                	push   $0xc
    1cf0:	6a 0c                	push   $0xc
    1cf2:	6a 0c                	push   $0xc
    1cf4:	50                   	push   %eax
    1cf5:	e8 46 f9 ff ff       	call   1640 <RGB>
    1cfa:	83 c4 0c             	add    $0xc,%esp
    1cfd:	8b 1d 2c 2f 00 00    	mov    0x2f2c,%ebx
    1d03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d06:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d09:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d0c:	6b c0 32             	imul   $0x32,%eax,%eax
    1d0f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d12:	8b 45 08             	mov    0x8(%ebp),%eax
    1d15:	8d 78 34             	lea    0x34(%eax),%edi
    1d18:	83 ec 0c             	sub    $0xc,%esp
    1d1b:	83 ec 04             	sub    $0x4,%esp
    1d1e:	89 e0                	mov    %esp,%eax
    1d20:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d24:	66 89 30             	mov    %si,(%eax)
    1d27:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d2b:	88 50 02             	mov    %dl,0x2(%eax)
    1d2e:	6a 32                	push   $0x32
    1d30:	6a 32                	push   $0x32
    1d32:	6a 00                	push   $0x0
    1d34:	6a 00                	push   $0x0
    1d36:	53                   	push   %ebx
    1d37:	51                   	push   %ecx
    1d38:	ff 75 94             	pushl  -0x6c(%ebp)
    1d3b:	57                   	push   %edi
    1d3c:	e8 5b f7 ff ff       	call   149c <APDcCopy>
    1d41:	83 c4 30             	add    $0x30,%esp
                    break;
    1d44:	e9 e3 02 00 00       	jmp    202c <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d49:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d4c:	6a 69                	push   $0x69
    1d4e:	6a 69                	push   $0x69
    1d50:	6a 69                	push   $0x69
    1d52:	50                   	push   %eax
    1d53:	e8 e8 f8 ff ff       	call   1640 <RGB>
    1d58:	83 c4 0c             	add    $0xc,%esp
    1d5b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d5f:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1d63:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d67:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1d6a:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d71:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d74:	6a 69                	push   $0x69
    1d76:	6a 69                	push   $0x69
    1d78:	6a 69                	push   $0x69
    1d7a:	50                   	push   %eax
    1d7b:	e8 c0 f8 ff ff       	call   1640 <RGB>
    1d80:	83 c4 0c             	add    $0xc,%esp
    1d83:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d87:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1d8b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d8f:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d92:	8b 45 08             	mov    0x8(%ebp),%eax
    1d95:	8d 50 34             	lea    0x34(%eax),%edx
    1d98:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d9b:	ff 75 bc             	pushl  -0x44(%ebp)
    1d9e:	ff 75 b8             	pushl  -0x48(%ebp)
    1da1:	52                   	push   %edx
    1da2:	50                   	push   %eax
    1da3:	e8 ce f0 ff ff       	call   e76 <APSetPen>
    1da8:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1dab:	8b 45 08             	mov    0x8(%ebp),%eax
    1dae:	8d 58 34             	lea    0x34(%eax),%ebx
    1db1:	8d 55 98             	lea    -0x68(%ebp),%edx
    1db4:	83 ec 04             	sub    $0x4,%esp
    1db7:	83 ec 04             	sub    $0x4,%esp
    1dba:	89 e0                	mov    %esp,%eax
    1dbc:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1dc0:	66 89 08             	mov    %cx,(%eax)
    1dc3:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1dc7:	88 48 02             	mov    %cl,0x2(%eax)
    1dca:	53                   	push   %ebx
    1dcb:	52                   	push   %edx
    1dcc:	e8 de f0 ff ff       	call   eaf <APSetBrush>
    1dd1:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1dd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dd7:	6b d0 32             	imul   $0x32,%eax,%edx
    1dda:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ddd:	6b c0 32             	imul   $0x32,%eax,%eax
    1de0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1de3:	83 c1 34             	add    $0x34,%ecx
    1de6:	83 ec 0c             	sub    $0xc,%esp
    1de9:	6a 32                	push   $0x32
    1deb:	6a 32                	push   $0x32
    1ded:	52                   	push   %edx
    1dee:	50                   	push   %eax
    1def:	51                   	push   %ecx
    1df0:	e8 a2 f4 ff ff       	call   1297 <APDrawRect>
    1df5:	83 c4 20             	add    $0x20,%esp
                    break;
    1df8:	e9 2f 02 00 00       	jmp    202c <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1dfd:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e00:	6a 0c                	push   $0xc
    1e02:	6a 0c                	push   $0xc
    1e04:	6a 0c                	push   $0xc
    1e06:	50                   	push   %eax
    1e07:	e8 34 f8 ff ff       	call   1640 <RGB>
    1e0c:	83 c4 0c             	add    $0xc,%esp
    1e0f:	8b 1d 6c 2f 00 00    	mov    0x2f6c,%ebx
    1e15:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e18:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e1e:	6b c0 32             	imul   $0x32,%eax,%eax
    1e21:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e24:	8b 45 08             	mov    0x8(%ebp),%eax
    1e27:	8d 78 34             	lea    0x34(%eax),%edi
    1e2a:	83 ec 0c             	sub    $0xc,%esp
    1e2d:	83 ec 04             	sub    $0x4,%esp
    1e30:	89 e0                	mov    %esp,%eax
    1e32:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e36:	66 89 30             	mov    %si,(%eax)
    1e39:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e3d:	88 50 02             	mov    %dl,0x2(%eax)
    1e40:	6a 32                	push   $0x32
    1e42:	6a 32                	push   $0x32
    1e44:	6a 00                	push   $0x0
    1e46:	6a 00                	push   $0x0
    1e48:	53                   	push   %ebx
    1e49:	51                   	push   %ecx
    1e4a:	ff 75 94             	pushl  -0x6c(%ebp)
    1e4d:	57                   	push   %edi
    1e4e:	e8 49 f6 ff ff       	call   149c <APDcCopy>
    1e53:	83 c4 30             	add    $0x30,%esp
                    break;
    1e56:	e9 d1 01 00 00       	jmp    202c <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e5b:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e5e:	6a 0c                	push   $0xc
    1e60:	6a 0c                	push   $0xc
    1e62:	6a 0c                	push   $0xc
    1e64:	50                   	push   %eax
    1e65:	e8 d6 f7 ff ff       	call   1640 <RGB>
    1e6a:	83 c4 0c             	add    $0xc,%esp
    1e6d:	8b 1d 4c 2f 00 00    	mov    0x2f4c,%ebx
    1e73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e76:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e79:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e7c:	6b c0 32             	imul   $0x32,%eax,%eax
    1e7f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e82:	8b 45 08             	mov    0x8(%ebp),%eax
    1e85:	8d 78 34             	lea    0x34(%eax),%edi
    1e88:	83 ec 0c             	sub    $0xc,%esp
    1e8b:	83 ec 04             	sub    $0x4,%esp
    1e8e:	89 e0                	mov    %esp,%eax
    1e90:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1e94:	66 89 30             	mov    %si,(%eax)
    1e97:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1e9b:	88 50 02             	mov    %dl,0x2(%eax)
    1e9e:	6a 32                	push   $0x32
    1ea0:	6a 32                	push   $0x32
    1ea2:	6a 00                	push   $0x0
    1ea4:	6a 00                	push   $0x0
    1ea6:	53                   	push   %ebx
    1ea7:	51                   	push   %ecx
    1ea8:	ff 75 94             	pushl  -0x6c(%ebp)
    1eab:	57                   	push   %edi
    1eac:	e8 eb f5 ff ff       	call   149c <APDcCopy>
    1eb1:	83 c4 30             	add    $0x30,%esp
                    break;
    1eb4:	e9 73 01 00 00       	jmp    202c <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1eb9:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ebc:	6a 0c                	push   $0xc
    1ebe:	6a 0c                	push   $0xc
    1ec0:	6a 0c                	push   $0xc
    1ec2:	50                   	push   %eax
    1ec3:	e8 78 f7 ff ff       	call   1640 <RGB>
    1ec8:	83 c4 0c             	add    $0xc,%esp
    1ecb:	8b 1d 30 2f 00 00    	mov    0x2f30,%ebx
    1ed1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ed4:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ed7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eda:	6b c0 32             	imul   $0x32,%eax,%eax
    1edd:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ee0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee3:	8d 78 34             	lea    0x34(%eax),%edi
    1ee6:	83 ec 0c             	sub    $0xc,%esp
    1ee9:	83 ec 04             	sub    $0x4,%esp
    1eec:	89 e0                	mov    %esp,%eax
    1eee:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1ef2:	66 89 30             	mov    %si,(%eax)
    1ef5:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1ef9:	88 50 02             	mov    %dl,0x2(%eax)
    1efc:	6a 32                	push   $0x32
    1efe:	6a 32                	push   $0x32
    1f00:	6a 00                	push   $0x0
    1f02:	6a 00                	push   $0x0
    1f04:	53                   	push   %ebx
    1f05:	51                   	push   %ecx
    1f06:	ff 75 94             	pushl  -0x6c(%ebp)
    1f09:	57                   	push   %edi
    1f0a:	e8 8d f5 ff ff       	call   149c <APDcCopy>
    1f0f:	83 c4 30             	add    $0x30,%esp
                    break;
    1f12:	e9 15 01 00 00       	jmp    202c <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f17:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f1a:	6a 0c                	push   $0xc
    1f1c:	6a 0c                	push   $0xc
    1f1e:	6a 0c                	push   $0xc
    1f20:	50                   	push   %eax
    1f21:	e8 1a f7 ff ff       	call   1640 <RGB>
    1f26:	83 c4 0c             	add    $0xc,%esp
    1f29:	8b 1d 68 2f 00 00    	mov    0x2f68,%ebx
    1f2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f32:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f35:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f38:	6b c0 32             	imul   $0x32,%eax,%eax
    1f3b:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f41:	8d 78 34             	lea    0x34(%eax),%edi
    1f44:	83 ec 0c             	sub    $0xc,%esp
    1f47:	83 ec 04             	sub    $0x4,%esp
    1f4a:	89 e0                	mov    %esp,%eax
    1f4c:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f50:	66 89 30             	mov    %si,(%eax)
    1f53:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f57:	88 50 02             	mov    %dl,0x2(%eax)
    1f5a:	6a 32                	push   $0x32
    1f5c:	6a 32                	push   $0x32
    1f5e:	6a 00                	push   $0x0
    1f60:	6a 00                	push   $0x0
    1f62:	53                   	push   %ebx
    1f63:	51                   	push   %ecx
    1f64:	ff 75 94             	pushl  -0x6c(%ebp)
    1f67:	57                   	push   %edi
    1f68:	e8 2f f5 ff ff       	call   149c <APDcCopy>
    1f6d:	83 c4 30             	add    $0x30,%esp
                    break;
    1f70:	e9 b7 00 00 00       	jmp    202c <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f75:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f78:	6a 0c                	push   $0xc
    1f7a:	6a 0c                	push   $0xc
    1f7c:	6a 0c                	push   $0xc
    1f7e:	50                   	push   %eax
    1f7f:	e8 bc f6 ff ff       	call   1640 <RGB>
    1f84:	83 c4 0c             	add    $0xc,%esp
    1f87:	8b 1d 00 2f 00 00    	mov    0x2f00,%ebx
    1f8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f90:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f93:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f96:	6b c0 32             	imul   $0x32,%eax,%eax
    1f99:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9f:	8d 78 34             	lea    0x34(%eax),%edi
    1fa2:	83 ec 0c             	sub    $0xc,%esp
    1fa5:	83 ec 04             	sub    $0x4,%esp
    1fa8:	89 e0                	mov    %esp,%eax
    1faa:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1fae:	66 89 30             	mov    %si,(%eax)
    1fb1:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1fb5:	88 50 02             	mov    %dl,0x2(%eax)
    1fb8:	6a 32                	push   $0x32
    1fba:	6a 32                	push   $0x32
    1fbc:	6a 00                	push   $0x0
    1fbe:	6a 00                	push   $0x0
    1fc0:	53                   	push   %ebx
    1fc1:	51                   	push   %ecx
    1fc2:	ff 75 94             	pushl  -0x6c(%ebp)
    1fc5:	57                   	push   %edi
    1fc6:	e8 d1 f4 ff ff       	call   149c <APDcCopy>
    1fcb:	83 c4 30             	add    $0x30,%esp
                    break;
    1fce:	eb 5c                	jmp    202c <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fd0:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1fd3:	6a 0c                	push   $0xc
    1fd5:	6a 0c                	push   $0xc
    1fd7:	6a 0c                	push   $0xc
    1fd9:	50                   	push   %eax
    1fda:	e8 61 f6 ff ff       	call   1640 <RGB>
    1fdf:	83 c4 0c             	add    $0xc,%esp
    1fe2:	8b 1d 1c 2f 00 00    	mov    0x2f1c,%ebx
    1fe8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1feb:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fee:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ff1:	6b c0 32             	imul   $0x32,%eax,%eax
    1ff4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ff7:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffa:	8d 78 34             	lea    0x34(%eax),%edi
    1ffd:	83 ec 0c             	sub    $0xc,%esp
    2000:	83 ec 04             	sub    $0x4,%esp
    2003:	89 e0                	mov    %esp,%eax
    2005:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2009:	66 89 30             	mov    %si,(%eax)
    200c:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2010:	88 50 02             	mov    %dl,0x2(%eax)
    2013:	6a 32                	push   $0x32
    2015:	6a 32                	push   $0x32
    2017:	6a 00                	push   $0x0
    2019:	6a 00                	push   $0x0
    201b:	53                   	push   %ebx
    201c:	51                   	push   %ecx
    201d:	ff 75 94             	pushl  -0x6c(%ebp)
    2020:	57                   	push   %edi
    2021:	e8 76 f4 ff ff       	call   149c <APDcCopy>
    2026:	83 c4 30             	add    $0x30,%esp
                    break;
    2029:	eb 01                	jmp    202c <APGridPaint+0x639>
                default: break;
    202b:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    202c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2030:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2034:	0f 8e 7a fc ff ff    	jle    1cb4 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    203a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    203e:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2042:	0f 8e 60 fc ff ff    	jle    1ca8 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    2048:	8d 65 f4             	lea    -0xc(%ebp),%esp
    204b:	5b                   	pop    %ebx
    204c:	5e                   	pop    %esi
    204d:	5f                   	pop    %edi
    204e:	5d                   	pop    %ebp
    204f:	c3                   	ret    

00002050 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2050:	55                   	push   %ebp
    2051:	89 e5                	mov    %esp,%ebp
    2053:	53                   	push   %ebx
    2054:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2057:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    205e:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2062:	74 17                	je     207b <sprintint+0x2b>
    2064:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2068:	79 11                	jns    207b <sprintint+0x2b>
        neg = 1;
    206a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2071:	8b 45 10             	mov    0x10(%ebp),%eax
    2074:	f7 d8                	neg    %eax
    2076:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2079:	eb 06                	jmp    2081 <sprintint+0x31>
    } else {
        x = xx;
    207b:	8b 45 10             	mov    0x10(%ebp),%eax
    207e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2081:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2088:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    208b:	8d 41 01             	lea    0x1(%ecx),%eax
    208e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2091:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2094:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2097:	ba 00 00 00 00       	mov    $0x0,%edx
    209c:	f7 f3                	div    %ebx
    209e:	89 d0                	mov    %edx,%eax
    20a0:	0f b6 80 bc 2a 00 00 	movzbl 0x2abc(%eax),%eax
    20a7:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    20ab:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20b1:	ba 00 00 00 00       	mov    $0x0,%edx
    20b6:	f7 f3                	div    %ebx
    20b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    20bf:	75 c7                	jne    2088 <sprintint+0x38>
    if(neg)
    20c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20c5:	74 0e                	je     20d5 <sprintint+0x85>
        buf[i++] = '-';
    20c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20ca:	8d 50 01             	lea    0x1(%eax),%edx
    20cd:	89 55 f8             	mov    %edx,-0x8(%ebp)
    20d0:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    20d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20d8:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    20db:	eb 1b                	jmp    20f8 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    20dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    20e0:	8b 00                	mov    (%eax),%eax
    20e2:	8d 48 01             	lea    0x1(%eax),%ecx
    20e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    20e8:	89 0a                	mov    %ecx,(%edx)
    20ea:	89 c2                	mov    %eax,%edx
    20ec:	8b 45 08             	mov    0x8(%ebp),%eax
    20ef:	01 d0                	add    %edx,%eax
    20f1:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    20f4:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    20f8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    20fc:	7f df                	jg     20dd <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    20fe:	eb 21                	jmp    2121 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2100:	8b 45 0c             	mov    0xc(%ebp),%eax
    2103:	8b 00                	mov    (%eax),%eax
    2105:	8d 48 01             	lea    0x1(%eax),%ecx
    2108:	8b 55 0c             	mov    0xc(%ebp),%edx
    210b:	89 0a                	mov    %ecx,(%edx)
    210d:	89 c2                	mov    %eax,%edx
    210f:	8b 45 08             	mov    0x8(%ebp),%eax
    2112:	01 c2                	add    %eax,%edx
    2114:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2117:	8b 45 f8             	mov    -0x8(%ebp),%eax
    211a:	01 c8                	add    %ecx,%eax
    211c:	0f b6 00             	movzbl (%eax),%eax
    211f:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2121:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2125:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2129:	79 d5                	jns    2100 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    212b:	90                   	nop
    212c:	83 c4 20             	add    $0x20,%esp
    212f:	5b                   	pop    %ebx
    2130:	5d                   	pop    %ebp
    2131:	c3                   	ret    

00002132 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2132:	55                   	push   %ebp
    2133:	89 e5                	mov    %esp,%ebp
    2135:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2138:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    213f:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2146:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    214d:	8d 45 0c             	lea    0xc(%ebp),%eax
    2150:	83 c0 04             	add    $0x4,%eax
    2153:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2156:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    215d:	e9 d9 01 00 00       	jmp    233b <sprintf+0x209>
        c = fmt[i] & 0xff;
    2162:	8b 55 0c             	mov    0xc(%ebp),%edx
    2165:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2168:	01 d0                	add    %edx,%eax
    216a:	0f b6 00             	movzbl (%eax),%eax
    216d:	0f be c0             	movsbl %al,%eax
    2170:	25 ff 00 00 00       	and    $0xff,%eax
    2175:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2178:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    217c:	75 2c                	jne    21aa <sprintf+0x78>
            if(c == '%'){
    217e:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2182:	75 0c                	jne    2190 <sprintf+0x5e>
                state = '%';
    2184:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    218b:	e9 a7 01 00 00       	jmp    2337 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2190:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2193:	8d 50 01             	lea    0x1(%eax),%edx
    2196:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2199:	89 c2                	mov    %eax,%edx
    219b:	8b 45 08             	mov    0x8(%ebp),%eax
    219e:	01 d0                	add    %edx,%eax
    21a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21a3:	88 10                	mov    %dl,(%eax)
    21a5:	e9 8d 01 00 00       	jmp    2337 <sprintf+0x205>
            }
        } else if(state == '%'){
    21aa:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    21ae:	0f 85 83 01 00 00    	jne    2337 <sprintf+0x205>
            if(c == 'd'){
    21b4:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    21b8:	75 4c                	jne    2206 <sprintf+0xd4>
                buf[bi] = '\0';
    21ba:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21c0:	01 d0                	add    %edx,%eax
    21c2:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21c5:	83 ec 0c             	sub    $0xc,%esp
    21c8:	8d 45 ce             	lea    -0x32(%ebp),%eax
    21cb:	50                   	push   %eax
    21cc:	e8 1f e3 ff ff       	call   4f0 <atoi>
    21d1:	83 c4 10             	add    $0x10,%esp
    21d4:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    21d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    21de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21e1:	8b 00                	mov    (%eax),%eax
    21e3:	83 ec 08             	sub    $0x8,%esp
    21e6:	ff 75 d8             	pushl  -0x28(%ebp)
    21e9:	6a 01                	push   $0x1
    21eb:	6a 0a                	push   $0xa
    21ed:	50                   	push   %eax
    21ee:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21f1:	50                   	push   %eax
    21f2:	ff 75 08             	pushl  0x8(%ebp)
    21f5:	e8 56 fe ff ff       	call   2050 <sprintint>
    21fa:	83 c4 20             	add    $0x20,%esp
                ap++;
    21fd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2201:	e9 2a 01 00 00       	jmp    2330 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2206:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    220a:	74 06                	je     2212 <sprintf+0xe0>
    220c:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2210:	75 4c                	jne    225e <sprintf+0x12c>
                buf[bi] = '\0';
    2212:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2215:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2218:	01 d0                	add    %edx,%eax
    221a:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    221d:	83 ec 0c             	sub    $0xc,%esp
    2220:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2223:	50                   	push   %eax
    2224:	e8 c7 e2 ff ff       	call   4f0 <atoi>
    2229:	83 c4 10             	add    $0x10,%esp
    222c:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    222f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2236:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2239:	8b 00                	mov    (%eax),%eax
    223b:	83 ec 08             	sub    $0x8,%esp
    223e:	ff 75 dc             	pushl  -0x24(%ebp)
    2241:	6a 00                	push   $0x0
    2243:	6a 10                	push   $0x10
    2245:	50                   	push   %eax
    2246:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2249:	50                   	push   %eax
    224a:	ff 75 08             	pushl  0x8(%ebp)
    224d:	e8 fe fd ff ff       	call   2050 <sprintint>
    2252:	83 c4 20             	add    $0x20,%esp
                ap++;
    2255:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2259:	e9 d2 00 00 00       	jmp    2330 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    225e:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2262:	75 46                	jne    22aa <sprintf+0x178>
                s = (char*)*ap;
    2264:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2267:	8b 00                	mov    (%eax),%eax
    2269:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    226c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2270:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2274:	75 25                	jne    229b <sprintf+0x169>
                    s = "(null)";
    2276:	c7 45 f4 10 25 00 00 	movl   $0x2510,-0xc(%ebp)
                while(*s != 0){
    227d:	eb 1c                	jmp    229b <sprintf+0x169>
                    dst[j++] = *s;
    227f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2282:	8d 50 01             	lea    0x1(%eax),%edx
    2285:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2288:	89 c2                	mov    %eax,%edx
    228a:	8b 45 08             	mov    0x8(%ebp),%eax
    228d:	01 c2                	add    %eax,%edx
    228f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2292:	0f b6 00             	movzbl (%eax),%eax
    2295:	88 02                	mov    %al,(%edx)
                    s++;
    2297:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    229b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    229e:	0f b6 00             	movzbl (%eax),%eax
    22a1:	84 c0                	test   %al,%al
    22a3:	75 da                	jne    227f <sprintf+0x14d>
    22a5:	e9 86 00 00 00       	jmp    2330 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    22aa:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    22ae:	75 1d                	jne    22cd <sprintf+0x19b>
                dst[j++] = *ap;
    22b0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22b3:	8d 50 01             	lea    0x1(%eax),%edx
    22b6:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22b9:	89 c2                	mov    %eax,%edx
    22bb:	8b 45 08             	mov    0x8(%ebp),%eax
    22be:	01 c2                	add    %eax,%edx
    22c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22c3:	8b 00                	mov    (%eax),%eax
    22c5:	88 02                	mov    %al,(%edx)
                ap++;
    22c7:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    22cb:	eb 63                	jmp    2330 <sprintf+0x1fe>
            } else if(c == '%'){
    22cd:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    22d1:	75 17                	jne    22ea <sprintf+0x1b8>
                dst[j++] = c;
    22d3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22d6:	8d 50 01             	lea    0x1(%eax),%edx
    22d9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22dc:	89 c2                	mov    %eax,%edx
    22de:	8b 45 08             	mov    0x8(%ebp),%eax
    22e1:	01 d0                	add    %edx,%eax
    22e3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22e6:	88 10                	mov    %dl,(%eax)
    22e8:	eb 46                	jmp    2330 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    22ea:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    22ee:	7e 18                	jle    2308 <sprintf+0x1d6>
    22f0:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    22f4:	7f 12                	jg     2308 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    22f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    22f9:	8d 50 01             	lea    0x1(%eax),%edx
    22fc:	89 55 f0             	mov    %edx,-0x10(%ebp)
    22ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2302:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2306:	eb 2f                	jmp    2337 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2308:	8b 45 c8             	mov    -0x38(%ebp),%eax
    230b:	8d 50 01             	lea    0x1(%eax),%edx
    230e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2311:	89 c2                	mov    %eax,%edx
    2313:	8b 45 08             	mov    0x8(%ebp),%eax
    2316:	01 d0                	add    %edx,%eax
    2318:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    231b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    231e:	8d 50 01             	lea    0x1(%eax),%edx
    2321:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2324:	89 c2                	mov    %eax,%edx
    2326:	8b 45 08             	mov    0x8(%ebp),%eax
    2329:	01 d0                	add    %edx,%eax
    232b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    232e:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2330:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2337:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    233b:	8b 55 0c             	mov    0xc(%ebp),%edx
    233e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2341:	01 d0                	add    %edx,%eax
    2343:	0f b6 00             	movzbl (%eax),%eax
    2346:	84 c0                	test   %al,%al
    2348:	0f 85 14 fe ff ff    	jne    2162 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    234e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2351:	8d 50 01             	lea    0x1(%eax),%edx
    2354:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2357:	89 c2                	mov    %eax,%edx
    2359:	8b 45 08             	mov    0x8(%ebp),%eax
    235c:	01 d0                	add    %edx,%eax
    235e:	c6 00 00             	movb   $0x0,(%eax)
}
    2361:	90                   	nop
    2362:	c9                   	leave  
    2363:	c3                   	ret    
