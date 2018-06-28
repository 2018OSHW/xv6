
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
     10f:	68 6c 23 00 00       	push   $0x236c
     114:	6a 02                	push   $0x2
     116:	e8 0e 06 00 00       	call   729 <printf>
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
     18c:	68 8c 23 00 00       	push   $0x238c
     191:	6a 01                	push   $0x1
     193:	e8 91 05 00 00       	call   729 <printf>
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

0000064a <changePosition>:
SYSCALL(changePosition)
     64a:	b8 1b 00 00 00       	mov    $0x1b,%eax
     64f:	cd 40                	int    $0x40
     651:	c3                   	ret    

00000652 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     652:	55                   	push   %ebp
     653:	89 e5                	mov    %esp,%ebp
     655:	83 ec 18             	sub    $0x18,%esp
     658:	8b 45 0c             	mov    0xc(%ebp),%eax
     65b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     65e:	83 ec 04             	sub    $0x4,%esp
     661:	6a 01                	push   $0x1
     663:	8d 45 f4             	lea    -0xc(%ebp),%eax
     666:	50                   	push   %eax
     667:	ff 75 08             	pushl  0x8(%ebp)
     66a:	e8 33 ff ff ff       	call   5a2 <write>
     66f:	83 c4 10             	add    $0x10,%esp
}
     672:	90                   	nop
     673:	c9                   	leave  
     674:	c3                   	ret    

00000675 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     675:	55                   	push   %ebp
     676:	89 e5                	mov    %esp,%ebp
     678:	53                   	push   %ebx
     679:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     67c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     683:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     687:	74 17                	je     6a0 <printint+0x2b>
     689:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     68d:	79 11                	jns    6a0 <printint+0x2b>
    neg = 1;
     68f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     696:	8b 45 0c             	mov    0xc(%ebp),%eax
     699:	f7 d8                	neg    %eax
     69b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     69e:	eb 06                	jmp    6a6 <printint+0x31>
  } else {
    x = xx;
     6a0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6ad:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6b0:	8d 41 01             	lea    0x1(%ecx),%eax
     6b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6b6:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6bc:	ba 00 00 00 00       	mov    $0x0,%edx
     6c1:	f7 f3                	div    %ebx
     6c3:	89 d0                	mov    %edx,%eax
     6c5:	0f b6 80 b0 2a 00 00 	movzbl 0x2ab0(%eax),%eax
     6cc:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     6d0:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6d6:	ba 00 00 00 00       	mov    $0x0,%edx
     6db:	f7 f3                	div    %ebx
     6dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6e4:	75 c7                	jne    6ad <printint+0x38>
  if(neg)
     6e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6ea:	74 2d                	je     719 <printint+0xa4>
    buf[i++] = '-';
     6ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ef:	8d 50 01             	lea    0x1(%eax),%edx
     6f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6f5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     6fa:	eb 1d                	jmp    719 <printint+0xa4>
    putc(fd, buf[i]);
     6fc:	8d 55 dc             	lea    -0x24(%ebp),%edx
     6ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     702:	01 d0                	add    %edx,%eax
     704:	0f b6 00             	movzbl (%eax),%eax
     707:	0f be c0             	movsbl %al,%eax
     70a:	83 ec 08             	sub    $0x8,%esp
     70d:	50                   	push   %eax
     70e:	ff 75 08             	pushl  0x8(%ebp)
     711:	e8 3c ff ff ff       	call   652 <putc>
     716:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     719:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     71d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     721:	79 d9                	jns    6fc <printint+0x87>
    putc(fd, buf[i]);
}
     723:	90                   	nop
     724:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     727:	c9                   	leave  
     728:	c3                   	ret    

00000729 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     729:	55                   	push   %ebp
     72a:	89 e5                	mov    %esp,%ebp
     72c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     72f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     736:	8d 45 0c             	lea    0xc(%ebp),%eax
     739:	83 c0 04             	add    $0x4,%eax
     73c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     73f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     746:	e9 59 01 00 00       	jmp    8a4 <printf+0x17b>
    c = fmt[i] & 0xff;
     74b:	8b 55 0c             	mov    0xc(%ebp),%edx
     74e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     751:	01 d0                	add    %edx,%eax
     753:	0f b6 00             	movzbl (%eax),%eax
     756:	0f be c0             	movsbl %al,%eax
     759:	25 ff 00 00 00       	and    $0xff,%eax
     75e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     761:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     765:	75 2c                	jne    793 <printf+0x6a>
      if(c == '%'){
     767:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     76b:	75 0c                	jne    779 <printf+0x50>
        state = '%';
     76d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     774:	e9 27 01 00 00       	jmp    8a0 <printf+0x177>
      } else {
        putc(fd, c);
     779:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     77c:	0f be c0             	movsbl %al,%eax
     77f:	83 ec 08             	sub    $0x8,%esp
     782:	50                   	push   %eax
     783:	ff 75 08             	pushl  0x8(%ebp)
     786:	e8 c7 fe ff ff       	call   652 <putc>
     78b:	83 c4 10             	add    $0x10,%esp
     78e:	e9 0d 01 00 00       	jmp    8a0 <printf+0x177>
      }
    } else if(state == '%'){
     793:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     797:	0f 85 03 01 00 00    	jne    8a0 <printf+0x177>
      if(c == 'd'){
     79d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7a1:	75 1e                	jne    7c1 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7a6:	8b 00                	mov    (%eax),%eax
     7a8:	6a 01                	push   $0x1
     7aa:	6a 0a                	push   $0xa
     7ac:	50                   	push   %eax
     7ad:	ff 75 08             	pushl  0x8(%ebp)
     7b0:	e8 c0 fe ff ff       	call   675 <printint>
     7b5:	83 c4 10             	add    $0x10,%esp
        ap++;
     7b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7bc:	e9 d8 00 00 00       	jmp    899 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7c1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7c5:	74 06                	je     7cd <printf+0xa4>
     7c7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7cb:	75 1e                	jne    7eb <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7d0:	8b 00                	mov    (%eax),%eax
     7d2:	6a 00                	push   $0x0
     7d4:	6a 10                	push   $0x10
     7d6:	50                   	push   %eax
     7d7:	ff 75 08             	pushl  0x8(%ebp)
     7da:	e8 96 fe ff ff       	call   675 <printint>
     7df:	83 c4 10             	add    $0x10,%esp
        ap++;
     7e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7e6:	e9 ae 00 00 00       	jmp    899 <printf+0x170>
      } else if(c == 's'){
     7eb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     7ef:	75 43                	jne    834 <printf+0x10b>
        s = (char*)*ap;
     7f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7f4:	8b 00                	mov    (%eax),%eax
     7f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     7f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     7fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     801:	75 25                	jne    828 <printf+0xff>
          s = "(null)";
     803:	c7 45 f4 a2 23 00 00 	movl   $0x23a2,-0xc(%ebp)
        while(*s != 0){
     80a:	eb 1c                	jmp    828 <printf+0xff>
          putc(fd, *s);
     80c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80f:	0f b6 00             	movzbl (%eax),%eax
     812:	0f be c0             	movsbl %al,%eax
     815:	83 ec 08             	sub    $0x8,%esp
     818:	50                   	push   %eax
     819:	ff 75 08             	pushl  0x8(%ebp)
     81c:	e8 31 fe ff ff       	call   652 <putc>
     821:	83 c4 10             	add    $0x10,%esp
          s++;
     824:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     828:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82b:	0f b6 00             	movzbl (%eax),%eax
     82e:	84 c0                	test   %al,%al
     830:	75 da                	jne    80c <printf+0xe3>
     832:	eb 65                	jmp    899 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     834:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     838:	75 1d                	jne    857 <printf+0x12e>
        putc(fd, *ap);
     83a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     83d:	8b 00                	mov    (%eax),%eax
     83f:	0f be c0             	movsbl %al,%eax
     842:	83 ec 08             	sub    $0x8,%esp
     845:	50                   	push   %eax
     846:	ff 75 08             	pushl  0x8(%ebp)
     849:	e8 04 fe ff ff       	call   652 <putc>
     84e:	83 c4 10             	add    $0x10,%esp
        ap++;
     851:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     855:	eb 42                	jmp    899 <printf+0x170>
      } else if(c == '%'){
     857:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     85b:	75 17                	jne    874 <printf+0x14b>
        putc(fd, c);
     85d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     860:	0f be c0             	movsbl %al,%eax
     863:	83 ec 08             	sub    $0x8,%esp
     866:	50                   	push   %eax
     867:	ff 75 08             	pushl  0x8(%ebp)
     86a:	e8 e3 fd ff ff       	call   652 <putc>
     86f:	83 c4 10             	add    $0x10,%esp
     872:	eb 25                	jmp    899 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     874:	83 ec 08             	sub    $0x8,%esp
     877:	6a 25                	push   $0x25
     879:	ff 75 08             	pushl  0x8(%ebp)
     87c:	e8 d1 fd ff ff       	call   652 <putc>
     881:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     884:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     887:	0f be c0             	movsbl %al,%eax
     88a:	83 ec 08             	sub    $0x8,%esp
     88d:	50                   	push   %eax
     88e:	ff 75 08             	pushl  0x8(%ebp)
     891:	e8 bc fd ff ff       	call   652 <putc>
     896:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     899:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8a0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8a4:	8b 55 0c             	mov    0xc(%ebp),%edx
     8a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8aa:	01 d0                	add    %edx,%eax
     8ac:	0f b6 00             	movzbl (%eax),%eax
     8af:	84 c0                	test   %al,%al
     8b1:	0f 85 94 fe ff ff    	jne    74b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8b7:	90                   	nop
     8b8:	c9                   	leave  
     8b9:	c3                   	ret    

000008ba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8ba:	55                   	push   %ebp
     8bb:	89 e5                	mov    %esp,%ebp
     8bd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8c0:	8b 45 08             	mov    0x8(%ebp),%eax
     8c3:	83 e8 08             	sub    $0x8,%eax
     8c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8c9:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     8ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8d1:	eb 24                	jmp    8f7 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8d6:	8b 00                	mov    (%eax),%eax
     8d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8db:	77 12                	ja     8ef <free+0x35>
     8dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8e3:	77 24                	ja     909 <free+0x4f>
     8e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8e8:	8b 00                	mov    (%eax),%eax
     8ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     8ed:	77 1a                	ja     909 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f2:	8b 00                	mov    (%eax),%eax
     8f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8fd:	76 d4                	jbe    8d3 <free+0x19>
     8ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     902:	8b 00                	mov    (%eax),%eax
     904:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     907:	76 ca                	jbe    8d3 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     909:	8b 45 f8             	mov    -0x8(%ebp),%eax
     90c:	8b 40 04             	mov    0x4(%eax),%eax
     90f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     916:	8b 45 f8             	mov    -0x8(%ebp),%eax
     919:	01 c2                	add    %eax,%edx
     91b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91e:	8b 00                	mov    (%eax),%eax
     920:	39 c2                	cmp    %eax,%edx
     922:	75 24                	jne    948 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     924:	8b 45 f8             	mov    -0x8(%ebp),%eax
     927:	8b 50 04             	mov    0x4(%eax),%edx
     92a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     92d:	8b 00                	mov    (%eax),%eax
     92f:	8b 40 04             	mov    0x4(%eax),%eax
     932:	01 c2                	add    %eax,%edx
     934:	8b 45 f8             	mov    -0x8(%ebp),%eax
     937:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     93a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     93d:	8b 00                	mov    (%eax),%eax
     93f:	8b 10                	mov    (%eax),%edx
     941:	8b 45 f8             	mov    -0x8(%ebp),%eax
     944:	89 10                	mov    %edx,(%eax)
     946:	eb 0a                	jmp    952 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     948:	8b 45 fc             	mov    -0x4(%ebp),%eax
     94b:	8b 10                	mov    (%eax),%edx
     94d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     950:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     952:	8b 45 fc             	mov    -0x4(%ebp),%eax
     955:	8b 40 04             	mov    0x4(%eax),%eax
     958:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     95f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     962:	01 d0                	add    %edx,%eax
     964:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     967:	75 20                	jne    989 <free+0xcf>
    p->s.size += bp->s.size;
     969:	8b 45 fc             	mov    -0x4(%ebp),%eax
     96c:	8b 50 04             	mov    0x4(%eax),%edx
     96f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     972:	8b 40 04             	mov    0x4(%eax),%eax
     975:	01 c2                	add    %eax,%edx
     977:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     97d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     980:	8b 10                	mov    (%eax),%edx
     982:	8b 45 fc             	mov    -0x4(%ebp),%eax
     985:	89 10                	mov    %edx,(%eax)
     987:	eb 08                	jmp    991 <free+0xd7>
  } else
    p->s.ptr = bp;
     989:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     98f:	89 10                	mov    %edx,(%eax)
  freep = p;
     991:	8b 45 fc             	mov    -0x4(%ebp),%eax
     994:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
}
     999:	90                   	nop
     99a:	c9                   	leave  
     99b:	c3                   	ret    

0000099c <morecore>:

static Header*
morecore(uint nu)
{
     99c:	55                   	push   %ebp
     99d:	89 e5                	mov    %esp,%ebp
     99f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9a2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9a9:	77 07                	ja     9b2 <morecore+0x16>
    nu = 4096;
     9ab:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9b2:	8b 45 08             	mov    0x8(%ebp),%eax
     9b5:	c1 e0 03             	shl    $0x3,%eax
     9b8:	83 ec 0c             	sub    $0xc,%esp
     9bb:	50                   	push   %eax
     9bc:	e8 49 fc ff ff       	call   60a <sbrk>
     9c1:	83 c4 10             	add    $0x10,%esp
     9c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9c7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9cb:	75 07                	jne    9d4 <morecore+0x38>
    return 0;
     9cd:	b8 00 00 00 00       	mov    $0x0,%eax
     9d2:	eb 26                	jmp    9fa <morecore+0x5e>
  hp = (Header*)p;
     9d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9da:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9dd:	8b 55 08             	mov    0x8(%ebp),%edx
     9e0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9e6:	83 c0 08             	add    $0x8,%eax
     9e9:	83 ec 0c             	sub    $0xc,%esp
     9ec:	50                   	push   %eax
     9ed:	e8 c8 fe ff ff       	call   8ba <free>
     9f2:	83 c4 10             	add    $0x10,%esp
  return freep;
     9f5:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
}
     9fa:	c9                   	leave  
     9fb:	c3                   	ret    

000009fc <malloc>:

void*
malloc(uint nbytes)
{
     9fc:	55                   	push   %ebp
     9fd:	89 e5                	mov    %esp,%ebp
     9ff:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a02:	8b 45 08             	mov    0x8(%ebp),%eax
     a05:	83 c0 07             	add    $0x7,%eax
     a08:	c1 e8 03             	shr    $0x3,%eax
     a0b:	83 c0 01             	add    $0x1,%eax
     a0e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a11:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     a16:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a19:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a1d:	75 23                	jne    a42 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a1f:	c7 45 f0 e0 2a 00 00 	movl   $0x2ae0,-0x10(%ebp)
     a26:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a29:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
     a2e:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     a33:	a3 e0 2a 00 00       	mov    %eax,0x2ae0
    base.s.size = 0;
     a38:	c7 05 e4 2a 00 00 00 	movl   $0x0,0x2ae4
     a3f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a42:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a45:	8b 00                	mov    (%eax),%eax
     a47:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4d:	8b 40 04             	mov    0x4(%eax),%eax
     a50:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a53:	72 4d                	jb     aa2 <malloc+0xa6>
      if(p->s.size == nunits)
     a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a58:	8b 40 04             	mov    0x4(%eax),%eax
     a5b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a5e:	75 0c                	jne    a6c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a63:	8b 10                	mov    (%eax),%edx
     a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a68:	89 10                	mov    %edx,(%eax)
     a6a:	eb 26                	jmp    a92 <malloc+0x96>
      else {
        p->s.size -= nunits;
     a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a6f:	8b 40 04             	mov    0x4(%eax),%eax
     a72:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a75:	89 c2                	mov    %eax,%edx
     a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a80:	8b 40 04             	mov    0x4(%eax),%eax
     a83:	c1 e0 03             	shl    $0x3,%eax
     a86:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a8f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     a92:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a95:	a3 e8 2a 00 00       	mov    %eax,0x2ae8
      return (void*)(p + 1);
     a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9d:	83 c0 08             	add    $0x8,%eax
     aa0:	eb 3b                	jmp    add <malloc+0xe1>
    }
    if(p == freep)
     aa2:	a1 e8 2a 00 00       	mov    0x2ae8,%eax
     aa7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     aaa:	75 1e                	jne    aca <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     aac:	83 ec 0c             	sub    $0xc,%esp
     aaf:	ff 75 ec             	pushl  -0x14(%ebp)
     ab2:	e8 e5 fe ff ff       	call   99c <morecore>
     ab7:	83 c4 10             	add    $0x10,%esp
     aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
     abd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ac1:	75 07                	jne    aca <malloc+0xce>
        return 0;
     ac3:	b8 00 00 00 00       	mov    $0x0,%eax
     ac8:	eb 13                	jmp    add <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acd:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ad0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad3:	8b 00                	mov    (%eax),%eax
     ad5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     ad8:	e9 6d ff ff ff       	jmp    a4a <malloc+0x4e>
}
     add:	c9                   	leave  
     ade:	c3                   	ret    

00000adf <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     adf:	55                   	push   %ebp
     ae0:	89 e5                	mov    %esp,%ebp
     ae2:	83 ec 1c             	sub    $0x1c,%esp
     ae5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     ae8:	8b 55 10             	mov    0x10(%ebp),%edx
     aeb:	8b 45 14             	mov    0x14(%ebp),%eax
     aee:	88 4d ec             	mov    %cl,-0x14(%ebp)
     af1:	88 55 e8             	mov    %dl,-0x18(%ebp)
     af4:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     af7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     afb:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     afe:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b02:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b05:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b09:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b0c:	8b 45 08             	mov    0x8(%ebp),%eax
     b0f:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b13:	66 89 10             	mov    %dx,(%eax)
     b16:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b1a:	88 50 02             	mov    %dl,0x2(%eax)
}
     b1d:	8b 45 08             	mov    0x8(%ebp),%eax
     b20:	c9                   	leave  
     b21:	c2 04 00             	ret    $0x4

00000b24 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b24:	55                   	push   %ebp
     b25:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b27:	8b 45 08             	mov    0x8(%ebp),%eax
     b2a:	2b 45 10             	sub    0x10(%ebp),%eax
     b2d:	89 c2                	mov    %eax,%edx
     b2f:	8b 45 08             	mov    0x8(%ebp),%eax
     b32:	2b 45 10             	sub    0x10(%ebp),%eax
     b35:	0f af d0             	imul   %eax,%edx
     b38:	8b 45 0c             	mov    0xc(%ebp),%eax
     b3b:	2b 45 14             	sub    0x14(%ebp),%eax
     b3e:	89 c1                	mov    %eax,%ecx
     b40:	8b 45 0c             	mov    0xc(%ebp),%eax
     b43:	2b 45 14             	sub    0x14(%ebp),%eax
     b46:	0f af c1             	imul   %ecx,%eax
     b49:	01 d0                	add    %edx,%eax
}
     b4b:	5d                   	pop    %ebp
     b4c:	c3                   	ret    

00000b4d <abs_int>:

static inline int abs_int(int x)
{
     b4d:	55                   	push   %ebp
     b4e:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b50:	8b 45 08             	mov    0x8(%ebp),%eax
     b53:	99                   	cltd   
     b54:	89 d0                	mov    %edx,%eax
     b56:	33 45 08             	xor    0x8(%ebp),%eax
     b59:	29 d0                	sub    %edx,%eax
}
     b5b:	5d                   	pop    %ebp
     b5c:	c3                   	ret    

00000b5d <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b5d:	55                   	push   %ebp
     b5e:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b64:	79 07                	jns    b6d <APGetIndex+0x10>
        return X_SMALLER;
     b66:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b6b:	eb 40                	jmp    bad <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     b6d:	8b 45 08             	mov    0x8(%ebp),%eax
     b70:	8b 00                	mov    (%eax),%eax
     b72:	3b 45 0c             	cmp    0xc(%ebp),%eax
     b75:	7f 07                	jg     b7e <APGetIndex+0x21>
        return X_BIGGER;
     b77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b7c:	eb 2f                	jmp    bad <APGetIndex+0x50>
    if (y < 0)
     b7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     b82:	79 07                	jns    b8b <APGetIndex+0x2e>
        return Y_SMALLER;
     b84:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     b89:	eb 22                	jmp    bad <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     b8b:	8b 45 08             	mov    0x8(%ebp),%eax
     b8e:	8b 40 04             	mov    0x4(%eax),%eax
     b91:	3b 45 10             	cmp    0x10(%ebp),%eax
     b94:	7f 07                	jg     b9d <APGetIndex+0x40>
        return Y_BIGGER;
     b96:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     b9b:	eb 10                	jmp    bad <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     b9d:	8b 45 08             	mov    0x8(%ebp),%eax
     ba0:	8b 00                	mov    (%eax),%eax
     ba2:	0f af 45 10          	imul   0x10(%ebp),%eax
     ba6:	89 c2                	mov    %eax,%edx
     ba8:	8b 45 0c             	mov    0xc(%ebp),%eax
     bab:	01 d0                	add    %edx,%eax
}
     bad:	5d                   	pop    %ebp
     bae:	c3                   	ret    

00000baf <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     baf:	55                   	push   %ebp
     bb0:	89 e5                	mov    %esp,%ebp
     bb2:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bb5:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bbc:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bbf:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bc2:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bc9:	83 ec 08             	sub    $0x8,%esp
     bcc:	6a 00                	push   $0x0
     bce:	ff 75 0c             	pushl  0xc(%ebp)
     bd1:	e8 ec f9 ff ff       	call   5c2 <open>
     bd6:	83 c4 10             	add    $0x10,%esp
     bd9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bdc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     be0:	79 2e                	jns    c10 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     be2:	83 ec 04             	sub    $0x4,%esp
     be5:	ff 75 0c             	pushl  0xc(%ebp)
     be8:	68 a9 23 00 00       	push   $0x23a9
     bed:	6a 01                	push   $0x1
     bef:	e8 35 fb ff ff       	call   729 <printf>
     bf4:	83 c4 10             	add    $0x10,%esp
        return bmp;
     bf7:	8b 45 08             	mov    0x8(%ebp),%eax
     bfa:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bfd:	89 10                	mov    %edx,(%eax)
     bff:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c02:	89 50 04             	mov    %edx,0x4(%eax)
     c05:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c08:	89 50 08             	mov    %edx,0x8(%eax)
     c0b:	e9 d2 01 00 00       	jmp    de2 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c10:	83 ec 04             	sub    $0x4,%esp
     c13:	6a 0e                	push   $0xe
     c15:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c18:	50                   	push   %eax
     c19:	ff 75 ec             	pushl  -0x14(%ebp)
     c1c:	e8 79 f9 ff ff       	call   59a <read>
     c21:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c24:	83 ec 04             	sub    $0x4,%esp
     c27:	6a 28                	push   $0x28
     c29:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c2c:	50                   	push   %eax
     c2d:	ff 75 ec             	pushl  -0x14(%ebp)
     c30:	e8 65 f9 ff ff       	call   59a <read>
     c35:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c38:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c3b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c3e:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c41:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c44:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c47:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c4a:	0f af d0             	imul   %eax,%edx
     c4d:	89 d0                	mov    %edx,%eax
     c4f:	01 c0                	add    %eax,%eax
     c51:	01 d0                	add    %edx,%eax
     c53:	83 ec 0c             	sub    $0xc,%esp
     c56:	50                   	push   %eax
     c57:	e8 a0 fd ff ff       	call   9fc <malloc>
     c5c:	83 c4 10             	add    $0x10,%esp
     c5f:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c62:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c66:	0f b7 c0             	movzwl %ax,%eax
     c69:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c6c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c72:	0f af c2             	imul   %edx,%eax
     c75:	83 c0 1f             	add    $0x1f,%eax
     c78:	c1 e8 05             	shr    $0x5,%eax
     c7b:	c1 e0 02             	shl    $0x2,%eax
     c7e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     c81:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c84:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c87:	0f af c2             	imul   %edx,%eax
     c8a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     c8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c90:	83 ec 0c             	sub    $0xc,%esp
     c93:	50                   	push   %eax
     c94:	e8 63 fd ff ff       	call   9fc <malloc>
     c99:	83 c4 10             	add    $0x10,%esp
     c9c:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     c9f:	83 ec 04             	sub    $0x4,%esp
     ca2:	ff 75 e0             	pushl  -0x20(%ebp)
     ca5:	ff 75 dc             	pushl  -0x24(%ebp)
     ca8:	ff 75 ec             	pushl  -0x14(%ebp)
     cab:	e8 ea f8 ff ff       	call   59a <read>
     cb0:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     cb3:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     cb7:	66 c1 e8 03          	shr    $0x3,%ax
     cbb:	0f b7 c0             	movzwl %ax,%eax
     cbe:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     cc1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cc8:	e9 e5 00 00 00       	jmp    db2 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ccd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd3:	29 c2                	sub    %eax,%edx
     cd5:	89 d0                	mov    %edx,%eax
     cd7:	8d 50 ff             	lea    -0x1(%eax),%edx
     cda:	8b 45 c8             	mov    -0x38(%ebp),%eax
     cdd:	0f af c2             	imul   %edx,%eax
     ce0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     ce3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cea:	e9 b1 00 00 00       	jmp    da0 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     cef:	8b 55 d0             	mov    -0x30(%ebp),%edx
     cf2:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     cf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cf8:	01 c8                	add    %ecx,%eax
     cfa:	89 c1                	mov    %eax,%ecx
     cfc:	89 c8                	mov    %ecx,%eax
     cfe:	01 c0                	add    %eax,%eax
     d00:	01 c8                	add    %ecx,%eax
     d02:	01 c2                	add    %eax,%edx
     d04:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d07:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d0b:	89 c1                	mov    %eax,%ecx
     d0d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d10:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d14:	01 c1                	add    %eax,%ecx
     d16:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d19:	01 c8                	add    %ecx,%eax
     d1b:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d1e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d21:	01 c8                	add    %ecx,%eax
     d23:	0f b6 00             	movzbl (%eax),%eax
     d26:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d29:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d2c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d32:	01 c8                	add    %ecx,%eax
     d34:	89 c1                	mov    %eax,%ecx
     d36:	89 c8                	mov    %ecx,%eax
     d38:	01 c0                	add    %eax,%eax
     d3a:	01 c8                	add    %ecx,%eax
     d3c:	01 c2                	add    %eax,%edx
     d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d41:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d45:	89 c1                	mov    %eax,%ecx
     d47:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d4a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d4e:	01 c1                	add    %eax,%ecx
     d50:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d53:	01 c8                	add    %ecx,%eax
     d55:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d58:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d5b:	01 c8                	add    %ecx,%eax
     d5d:	0f b6 00             	movzbl (%eax),%eax
     d60:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d63:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d66:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d69:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d6c:	01 c8                	add    %ecx,%eax
     d6e:	89 c1                	mov    %eax,%ecx
     d70:	89 c8                	mov    %ecx,%eax
     d72:	01 c0                	add    %eax,%eax
     d74:	01 c8                	add    %ecx,%eax
     d76:	01 c2                	add    %eax,%edx
     d78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d7b:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d7f:	89 c1                	mov    %eax,%ecx
     d81:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d84:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d88:	01 c1                	add    %eax,%ecx
     d8a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d8d:	01 c8                	add    %ecx,%eax
     d8f:	8d 48 fd             	lea    -0x3(%eax),%ecx
     d92:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d95:	01 c8                	add    %ecx,%eax
     d97:	0f b6 00             	movzbl (%eax),%eax
     d9a:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     d9c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     da0:	8b 55 c8             	mov    -0x38(%ebp),%edx
     da3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     da6:	39 c2                	cmp    %eax,%edx
     da8:	0f 87 41 ff ff ff    	ja     cef <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     dae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     db2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     db5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db8:	39 c2                	cmp    %eax,%edx
     dba:	0f 87 0d ff ff ff    	ja     ccd <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     dc0:	83 ec 0c             	sub    $0xc,%esp
     dc3:	ff 75 ec             	pushl  -0x14(%ebp)
     dc6:	e8 df f7 ff ff       	call   5aa <close>
     dcb:	83 c4 10             	add    $0x10,%esp
    return bmp;
     dce:	8b 45 08             	mov    0x8(%ebp),%eax
     dd1:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dd4:	89 10                	mov    %edx,(%eax)
     dd6:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dd9:	89 50 04             	mov    %edx,0x4(%eax)
     ddc:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ddf:	89 50 08             	mov    %edx,0x8(%eax)
}
     de2:	8b 45 08             	mov    0x8(%ebp),%eax
     de5:	c9                   	leave  
     de6:	c2 04 00             	ret    $0x4

00000de9 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     de9:	55                   	push   %ebp
     dea:	89 e5                	mov    %esp,%ebp
     dec:	53                   	push   %ebx
     ded:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     df0:	83 ec 0c             	sub    $0xc,%esp
     df3:	6a 1c                	push   $0x1c
     df5:	e8 02 fc ff ff       	call   9fc <malloc>
     dfa:	83 c4 10             	add    $0x10,%esp
     dfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e03:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e0a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e0d:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e10:	6a 0c                	push   $0xc
     e12:	6a 0c                	push   $0xc
     e14:	6a 0c                	push   $0xc
     e16:	50                   	push   %eax
     e17:	e8 c3 fc ff ff       	call   adf <RGB>
     e1c:	83 c4 0c             	add    $0xc,%esp
     e1f:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e23:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e27:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e2b:	88 43 15             	mov    %al,0x15(%ebx)
     e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e31:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e34:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e38:	66 89 48 10          	mov    %cx,0x10(%eax)
     e3c:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e40:	88 50 12             	mov    %dl,0x12(%eax)
     e43:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e46:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e49:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e4d:	66 89 48 08          	mov    %cx,0x8(%eax)
     e51:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e55:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e58:	8b 45 08             	mov    0x8(%ebp),%eax
     e5b:	89 c2                	mov    %eax,%edx
     e5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e60:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e62:	8b 45 0c             	mov    0xc(%ebp),%eax
     e65:	89 c2                	mov    %eax,%edx
     e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e6a:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     e6d:	8b 55 10             	mov    0x10(%ebp),%edx
     e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e73:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e7c:	c9                   	leave  
     e7d:	c3                   	ret    

00000e7e <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     e7e:	55                   	push   %ebp
     e7f:	89 e5                	mov    %esp,%ebp
     e81:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     e84:	8b 45 0c             	mov    0xc(%ebp),%eax
     e87:	8b 50 08             	mov    0x8(%eax),%edx
     e8a:	89 55 f8             	mov    %edx,-0x8(%ebp)
     e8d:	8b 40 0c             	mov    0xc(%eax),%eax
     e90:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     e93:	8b 45 0c             	mov    0xc(%ebp),%eax
     e96:	8b 55 10             	mov    0x10(%ebp),%edx
     e99:	89 50 08             	mov    %edx,0x8(%eax)
     e9c:	8b 55 14             	mov    0x14(%ebp),%edx
     e9f:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     ea2:	8b 45 08             	mov    0x8(%ebp),%eax
     ea5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ea8:	89 10                	mov    %edx,(%eax)
     eaa:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ead:	89 50 04             	mov    %edx,0x4(%eax)
}
     eb0:	8b 45 08             	mov    0x8(%ebp),%eax
     eb3:	c9                   	leave  
     eb4:	c2 04 00             	ret    $0x4

00000eb7 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     eb7:	55                   	push   %ebp
     eb8:	89 e5                	mov    %esp,%ebp
     eba:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec0:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ec4:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ec8:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ecc:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ecf:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed2:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     ed6:	66 89 50 10          	mov    %dx,0x10(%eax)
     eda:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     ede:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     ee1:	8b 45 08             	mov    0x8(%ebp),%eax
     ee4:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     ee8:	66 89 10             	mov    %dx,(%eax)
     eeb:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     eef:	88 50 02             	mov    %dl,0x2(%eax)
}
     ef2:	8b 45 08             	mov    0x8(%ebp),%eax
     ef5:	c9                   	leave  
     ef6:	c2 04 00             	ret    $0x4

00000ef9 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     ef9:	55                   	push   %ebp
     efa:	89 e5                	mov    %esp,%ebp
     efc:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     eff:	8b 45 08             	mov    0x8(%ebp),%eax
     f02:	8b 40 0c             	mov    0xc(%eax),%eax
     f05:	89 c2                	mov    %eax,%edx
     f07:	c1 ea 1f             	shr    $0x1f,%edx
     f0a:	01 d0                	add    %edx,%eax
     f0c:	d1 f8                	sar    %eax
     f0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f14:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f18:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f1b:	8b 45 10             	mov    0x10(%ebp),%eax
     f1e:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f21:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f24:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f28:	0f 89 98 00 00 00    	jns    fc6 <APDrawPoint+0xcd>
        i = 0;
     f2e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f35:	e9 8c 00 00 00       	jmp    fc6 <APDrawPoint+0xcd>
    {
        j = x - off;
     f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f3d:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f40:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f43:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f47:	79 69                	jns    fb2 <APDrawPoint+0xb9>
            j = 0;
     f49:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f50:	eb 60                	jmp    fb2 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f52:	ff 75 fc             	pushl  -0x4(%ebp)
     f55:	ff 75 f8             	pushl  -0x8(%ebp)
     f58:	ff 75 08             	pushl  0x8(%ebp)
     f5b:	e8 fd fb ff ff       	call   b5d <APGetIndex>
     f60:	83 c4 0c             	add    $0xc,%esp
     f63:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     f66:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     f6a:	74 55                	je     fc1 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     f6c:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     f70:	74 67                	je     fd9 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     f72:	ff 75 10             	pushl  0x10(%ebp)
     f75:	ff 75 0c             	pushl  0xc(%ebp)
     f78:	ff 75 fc             	pushl  -0x4(%ebp)
     f7b:	ff 75 f8             	pushl  -0x8(%ebp)
     f7e:	e8 a1 fb ff ff       	call   b24 <distance_2>
     f83:	83 c4 10             	add    $0x10,%esp
     f86:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     f89:	7f 23                	jg     fae <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     f8b:	8b 45 08             	mov    0x8(%ebp),%eax
     f8e:	8b 48 18             	mov    0x18(%eax),%ecx
     f91:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f94:	89 d0                	mov    %edx,%eax
     f96:	01 c0                	add    %eax,%eax
     f98:	01 d0                	add    %edx,%eax
     f9a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     f9d:	8b 45 08             	mov    0x8(%ebp),%eax
     fa0:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     fa4:	66 89 0a             	mov    %cx,(%edx)
     fa7:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     fab:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     fae:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     fb2:	8b 55 0c             	mov    0xc(%ebp),%edx
     fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb8:	01 d0                	add    %edx,%eax
     fba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     fbd:	7d 93                	jge    f52 <APDrawPoint+0x59>
     fbf:	eb 01                	jmp    fc2 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     fc1:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     fc2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     fc6:	8b 55 10             	mov    0x10(%ebp),%edx
     fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fcc:	01 d0                	add    %edx,%eax
     fce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     fd1:	0f 8d 63 ff ff ff    	jge    f3a <APDrawPoint+0x41>
     fd7:	eb 01                	jmp    fda <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     fd9:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     fda:	c9                   	leave  
     fdb:	c3                   	ret    

00000fdc <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     fdc:	55                   	push   %ebp
     fdd:	89 e5                	mov    %esp,%ebp
     fdf:	53                   	push   %ebx
     fe0:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe6:	3b 45 14             	cmp    0x14(%ebp),%eax
     fe9:	0f 85 80 00 00 00    	jne    106f <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     fef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ff3:	0f 88 9d 02 00 00    	js     1296 <APDrawLine+0x2ba>
     ff9:	8b 45 08             	mov    0x8(%ebp),%eax
     ffc:	8b 00                	mov    (%eax),%eax
     ffe:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1001:	0f 8e 8f 02 00 00    	jle    1296 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1007:	8b 45 10             	mov    0x10(%ebp),%eax
    100a:	3b 45 18             	cmp    0x18(%ebp),%eax
    100d:	7e 12                	jle    1021 <APDrawLine+0x45>
        {
            int tmp = y2;
    100f:	8b 45 18             	mov    0x18(%ebp),%eax
    1012:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1015:	8b 45 10             	mov    0x10(%ebp),%eax
    1018:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    101b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    101e:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1021:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1025:	79 07                	jns    102e <APDrawLine+0x52>
    1027:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    102e:	8b 45 08             	mov    0x8(%ebp),%eax
    1031:	8b 40 04             	mov    0x4(%eax),%eax
    1034:	3b 45 18             	cmp    0x18(%ebp),%eax
    1037:	7d 0c                	jge    1045 <APDrawLine+0x69>
    1039:	8b 45 08             	mov    0x8(%ebp),%eax
    103c:	8b 40 04             	mov    0x4(%eax),%eax
    103f:	83 e8 01             	sub    $0x1,%eax
    1042:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1045:	8b 45 10             	mov    0x10(%ebp),%eax
    1048:	89 45 f4             	mov    %eax,-0xc(%ebp)
    104b:	eb 15                	jmp    1062 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    104d:	ff 75 f4             	pushl  -0xc(%ebp)
    1050:	ff 75 0c             	pushl  0xc(%ebp)
    1053:	ff 75 08             	pushl  0x8(%ebp)
    1056:	e8 9e fe ff ff       	call   ef9 <APDrawPoint>
    105b:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    105e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1062:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1065:	3b 45 18             	cmp    0x18(%ebp),%eax
    1068:	7e e3                	jle    104d <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    106a:	e9 2b 02 00 00       	jmp    129a <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    106f:	8b 45 10             	mov    0x10(%ebp),%eax
    1072:	3b 45 18             	cmp    0x18(%ebp),%eax
    1075:	75 7f                	jne    10f6 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1077:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    107b:	0f 88 18 02 00 00    	js     1299 <APDrawLine+0x2bd>
    1081:	8b 45 08             	mov    0x8(%ebp),%eax
    1084:	8b 40 04             	mov    0x4(%eax),%eax
    1087:	3b 45 10             	cmp    0x10(%ebp),%eax
    108a:	0f 8e 09 02 00 00    	jle    1299 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1090:	8b 45 0c             	mov    0xc(%ebp),%eax
    1093:	3b 45 14             	cmp    0x14(%ebp),%eax
    1096:	7e 12                	jle    10aa <APDrawLine+0xce>
        {
            int tmp = x2;
    1098:	8b 45 14             	mov    0x14(%ebp),%eax
    109b:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    109e:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a1:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10a7:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10ae:	79 07                	jns    10b7 <APDrawLine+0xdb>
    10b0:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    10b7:	8b 45 08             	mov    0x8(%ebp),%eax
    10ba:	8b 00                	mov    (%eax),%eax
    10bc:	3b 45 14             	cmp    0x14(%ebp),%eax
    10bf:	7d 0b                	jge    10cc <APDrawLine+0xf0>
    10c1:	8b 45 08             	mov    0x8(%ebp),%eax
    10c4:	8b 00                	mov    (%eax),%eax
    10c6:	83 e8 01             	sub    $0x1,%eax
    10c9:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    10cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    10cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10d2:	eb 15                	jmp    10e9 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    10d4:	ff 75 10             	pushl  0x10(%ebp)
    10d7:	ff 75 f0             	pushl  -0x10(%ebp)
    10da:	ff 75 08             	pushl  0x8(%ebp)
    10dd:	e8 17 fe ff ff       	call   ef9 <APDrawPoint>
    10e2:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    10e5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    10e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10ec:	3b 45 14             	cmp    0x14(%ebp),%eax
    10ef:	7e e3                	jle    10d4 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    10f1:	e9 a4 01 00 00       	jmp    129a <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    10f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    10fd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1104:	8b 45 0c             	mov    0xc(%ebp),%eax
    1107:	2b 45 14             	sub    0x14(%ebp),%eax
    110a:	50                   	push   %eax
    110b:	e8 3d fa ff ff       	call   b4d <abs_int>
    1110:	83 c4 04             	add    $0x4,%esp
    1113:	89 c3                	mov    %eax,%ebx
    1115:	8b 45 10             	mov    0x10(%ebp),%eax
    1118:	2b 45 18             	sub    0x18(%ebp),%eax
    111b:	50                   	push   %eax
    111c:	e8 2c fa ff ff       	call   b4d <abs_int>
    1121:	83 c4 04             	add    $0x4,%esp
    1124:	39 c3                	cmp    %eax,%ebx
    1126:	0f 8e b5 00 00 00    	jle    11e1 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    112c:	8b 45 10             	mov    0x10(%ebp),%eax
    112f:	2b 45 18             	sub    0x18(%ebp),%eax
    1132:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1135:	db 45 b0             	fildl  -0x50(%ebp)
    1138:	8b 45 0c             	mov    0xc(%ebp),%eax
    113b:	2b 45 14             	sub    0x14(%ebp),%eax
    113e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1141:	db 45 b0             	fildl  -0x50(%ebp)
    1144:	de f9                	fdivrp %st,%st(1)
    1146:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1149:	8b 45 14             	mov    0x14(%ebp),%eax
    114c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    114f:	7e 0e                	jle    115f <APDrawLine+0x183>
        {
            s = x1;
    1151:	8b 45 0c             	mov    0xc(%ebp),%eax
    1154:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1157:	8b 45 14             	mov    0x14(%ebp),%eax
    115a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    115d:	eb 0c                	jmp    116b <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    115f:	8b 45 14             	mov    0x14(%ebp),%eax
    1162:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1165:	8b 45 0c             	mov    0xc(%ebp),%eax
    1168:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    116b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    116f:	79 07                	jns    1178 <APDrawLine+0x19c>
    1171:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1178:	8b 45 08             	mov    0x8(%ebp),%eax
    117b:	8b 00                	mov    (%eax),%eax
    117d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1180:	7f 0b                	jg     118d <APDrawLine+0x1b1>
    1182:	8b 45 08             	mov    0x8(%ebp),%eax
    1185:	8b 00                	mov    (%eax),%eax
    1187:	83 e8 01             	sub    $0x1,%eax
    118a:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    118d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1190:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1193:	eb 3f                	jmp    11d4 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    1195:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1198:	2b 45 0c             	sub    0xc(%ebp),%eax
    119b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    119e:	db 45 b0             	fildl  -0x50(%ebp)
    11a1:	dc 4d d0             	fmull  -0x30(%ebp)
    11a4:	db 45 10             	fildl  0x10(%ebp)
    11a7:	de c1                	faddp  %st,%st(1)
    11a9:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11ac:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11b0:	b4 0c                	mov    $0xc,%ah
    11b2:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11b6:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11b9:	db 5d cc             	fistpl -0x34(%ebp)
    11bc:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    11bf:	ff 75 cc             	pushl  -0x34(%ebp)
    11c2:	ff 75 e4             	pushl  -0x1c(%ebp)
    11c5:	ff 75 08             	pushl  0x8(%ebp)
    11c8:	e8 2c fd ff ff       	call   ef9 <APDrawPoint>
    11cd:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    11d0:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    11d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11d7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11da:	7e b9                	jle    1195 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    11dc:	e9 b9 00 00 00       	jmp    129a <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    11e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    11e4:	2b 45 14             	sub    0x14(%ebp),%eax
    11e7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11ea:	db 45 b0             	fildl  -0x50(%ebp)
    11ed:	8b 45 10             	mov    0x10(%ebp),%eax
    11f0:	2b 45 18             	sub    0x18(%ebp),%eax
    11f3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11f6:	db 45 b0             	fildl  -0x50(%ebp)
    11f9:	de f9                	fdivrp %st,%st(1)
    11fb:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    11fe:	8b 45 10             	mov    0x10(%ebp),%eax
    1201:	3b 45 18             	cmp    0x18(%ebp),%eax
    1204:	7e 0e                	jle    1214 <APDrawLine+0x238>
    {
        s = y2;
    1206:	8b 45 18             	mov    0x18(%ebp),%eax
    1209:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    120c:	8b 45 10             	mov    0x10(%ebp),%eax
    120f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1212:	eb 0c                	jmp    1220 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1214:	8b 45 10             	mov    0x10(%ebp),%eax
    1217:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    121a:	8b 45 18             	mov    0x18(%ebp),%eax
    121d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1220:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1224:	79 07                	jns    122d <APDrawLine+0x251>
    1226:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    122d:	8b 45 08             	mov    0x8(%ebp),%eax
    1230:	8b 40 04             	mov    0x4(%eax),%eax
    1233:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1236:	7f 0c                	jg     1244 <APDrawLine+0x268>
    1238:	8b 45 08             	mov    0x8(%ebp),%eax
    123b:	8b 40 04             	mov    0x4(%eax),%eax
    123e:	83 e8 01             	sub    $0x1,%eax
    1241:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1244:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1247:	89 45 e0             	mov    %eax,-0x20(%ebp)
    124a:	eb 3f                	jmp    128b <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    124c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    124f:	2b 45 10             	sub    0x10(%ebp),%eax
    1252:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1255:	db 45 b0             	fildl  -0x50(%ebp)
    1258:	dc 4d c0             	fmull  -0x40(%ebp)
    125b:	db 45 0c             	fildl  0xc(%ebp)
    125e:	de c1                	faddp  %st,%st(1)
    1260:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1263:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1267:	b4 0c                	mov    $0xc,%ah
    1269:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    126d:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1270:	db 5d bc             	fistpl -0x44(%ebp)
    1273:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1276:	ff 75 e0             	pushl  -0x20(%ebp)
    1279:	ff 75 bc             	pushl  -0x44(%ebp)
    127c:	ff 75 08             	pushl  0x8(%ebp)
    127f:	e8 75 fc ff ff       	call   ef9 <APDrawPoint>
    1284:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    1287:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    128b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    128e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1291:	7e b9                	jle    124c <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1293:	90                   	nop
    1294:	eb 04                	jmp    129a <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    1296:	90                   	nop
    1297:	eb 01                	jmp    129a <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    1299:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    129a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    129d:	c9                   	leave  
    129e:	c3                   	ret    

0000129f <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    129f:	55                   	push   %ebp
    12a0:	89 e5                	mov    %esp,%ebp
    12a2:	53                   	push   %ebx
    12a3:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    12a6:	8b 55 10             	mov    0x10(%ebp),%edx
    12a9:	8b 45 18             	mov    0x18(%ebp),%eax
    12ac:	01 d0                	add    %edx,%eax
    12ae:	83 e8 01             	sub    $0x1,%eax
    12b1:	83 ec 04             	sub    $0x4,%esp
    12b4:	50                   	push   %eax
    12b5:	ff 75 0c             	pushl  0xc(%ebp)
    12b8:	ff 75 10             	pushl  0x10(%ebp)
    12bb:	ff 75 0c             	pushl  0xc(%ebp)
    12be:	ff 75 08             	pushl  0x8(%ebp)
    12c1:	e8 16 fd ff ff       	call   fdc <APDrawLine>
    12c6:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    12c9:	8b 55 0c             	mov    0xc(%ebp),%edx
    12cc:	8b 45 14             	mov    0x14(%ebp),%eax
    12cf:	01 d0                	add    %edx,%eax
    12d1:	83 e8 01             	sub    $0x1,%eax
    12d4:	83 ec 04             	sub    $0x4,%esp
    12d7:	ff 75 10             	pushl  0x10(%ebp)
    12da:	50                   	push   %eax
    12db:	ff 75 10             	pushl  0x10(%ebp)
    12de:	ff 75 0c             	pushl  0xc(%ebp)
    12e1:	ff 75 08             	pushl  0x8(%ebp)
    12e4:	e8 f3 fc ff ff       	call   fdc <APDrawLine>
    12e9:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    12ec:	8b 55 10             	mov    0x10(%ebp),%edx
    12ef:	8b 45 18             	mov    0x18(%ebp),%eax
    12f2:	01 d0                	add    %edx,%eax
    12f4:	8d 48 ff             	lea    -0x1(%eax),%ecx
    12f7:	8b 55 0c             	mov    0xc(%ebp),%edx
    12fa:	8b 45 14             	mov    0x14(%ebp),%eax
    12fd:	01 d0                	add    %edx,%eax
    12ff:	8d 50 ff             	lea    -0x1(%eax),%edx
    1302:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1305:	8b 45 14             	mov    0x14(%ebp),%eax
    1308:	01 d8                	add    %ebx,%eax
    130a:	83 e8 01             	sub    $0x1,%eax
    130d:	83 ec 04             	sub    $0x4,%esp
    1310:	51                   	push   %ecx
    1311:	52                   	push   %edx
    1312:	ff 75 10             	pushl  0x10(%ebp)
    1315:	50                   	push   %eax
    1316:	ff 75 08             	pushl  0x8(%ebp)
    1319:	e8 be fc ff ff       	call   fdc <APDrawLine>
    131e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1321:	8b 55 10             	mov    0x10(%ebp),%edx
    1324:	8b 45 18             	mov    0x18(%ebp),%eax
    1327:	01 d0                	add    %edx,%eax
    1329:	8d 48 ff             	lea    -0x1(%eax),%ecx
    132c:	8b 55 0c             	mov    0xc(%ebp),%edx
    132f:	8b 45 14             	mov    0x14(%ebp),%eax
    1332:	01 d0                	add    %edx,%eax
    1334:	8d 50 ff             	lea    -0x1(%eax),%edx
    1337:	8b 5d 10             	mov    0x10(%ebp),%ebx
    133a:	8b 45 18             	mov    0x18(%ebp),%eax
    133d:	01 d8                	add    %ebx,%eax
    133f:	83 e8 01             	sub    $0x1,%eax
    1342:	83 ec 04             	sub    $0x4,%esp
    1345:	51                   	push   %ecx
    1346:	52                   	push   %edx
    1347:	50                   	push   %eax
    1348:	ff 75 0c             	pushl  0xc(%ebp)
    134b:	ff 75 08             	pushl  0x8(%ebp)
    134e:	e8 89 fc ff ff       	call   fdc <APDrawLine>
    1353:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1356:	8b 55 0c             	mov    0xc(%ebp),%edx
    1359:	8b 45 14             	mov    0x14(%ebp),%eax
    135c:	01 d0                	add    %edx,%eax
    135e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1361:	8b 45 08             	mov    0x8(%ebp),%eax
    1364:	8b 40 0c             	mov    0xc(%eax),%eax
    1367:	89 c1                	mov    %eax,%ecx
    1369:	c1 e9 1f             	shr    $0x1f,%ecx
    136c:	01 c8                	add    %ecx,%eax
    136e:	d1 f8                	sar    %eax
    1370:	29 c2                	sub    %eax,%edx
    1372:	89 d0                	mov    %edx,%eax
    1374:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1377:	8b 55 10             	mov    0x10(%ebp),%edx
    137a:	8b 45 18             	mov    0x18(%ebp),%eax
    137d:	01 d0                	add    %edx,%eax
    137f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1382:	8b 45 08             	mov    0x8(%ebp),%eax
    1385:	8b 40 0c             	mov    0xc(%eax),%eax
    1388:	89 c1                	mov    %eax,%ecx
    138a:	c1 e9 1f             	shr    $0x1f,%ecx
    138d:	01 c8                	add    %ecx,%eax
    138f:	d1 f8                	sar    %eax
    1391:	29 c2                	sub    %eax,%edx
    1393:	89 d0                	mov    %edx,%eax
    1395:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    1398:	8b 45 08             	mov    0x8(%ebp),%eax
    139b:	8b 40 0c             	mov    0xc(%eax),%eax
    139e:	89 c2                	mov    %eax,%edx
    13a0:	c1 ea 1f             	shr    $0x1f,%edx
    13a3:	01 d0                	add    %edx,%eax
    13a5:	d1 f8                	sar    %eax
    13a7:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13aa:	8b 45 08             	mov    0x8(%ebp),%eax
    13ad:	8b 40 0c             	mov    0xc(%eax),%eax
    13b0:	89 c2                	mov    %eax,%edx
    13b2:	c1 ea 1f             	shr    $0x1f,%edx
    13b5:	01 d0                	add    %edx,%eax
    13b7:	d1 f8                	sar    %eax
    13b9:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    13bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13c0:	0f 88 d8 00 00 00    	js     149e <APDrawRect+0x1ff>
    13c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13ca:	0f 88 ce 00 00 00    	js     149e <APDrawRect+0x1ff>
    13d0:	8b 45 08             	mov    0x8(%ebp),%eax
    13d3:	8b 00                	mov    (%eax),%eax
    13d5:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13d8:	0f 8e c0 00 00 00    	jle    149e <APDrawRect+0x1ff>
    13de:	8b 45 08             	mov    0x8(%ebp),%eax
    13e1:	8b 40 04             	mov    0x4(%eax),%eax
    13e4:	3b 45 10             	cmp    0x10(%ebp),%eax
    13e7:	0f 8e b1 00 00 00    	jle    149e <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    13ed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13f1:	79 07                	jns    13fa <APDrawRect+0x15b>
    13f3:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    13fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13fe:	79 07                	jns    1407 <APDrawRect+0x168>
    1400:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1407:	8b 45 08             	mov    0x8(%ebp),%eax
    140a:	8b 00                	mov    (%eax),%eax
    140c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    140f:	7f 0b                	jg     141c <APDrawRect+0x17d>
    1411:	8b 45 08             	mov    0x8(%ebp),%eax
    1414:	8b 00                	mov    (%eax),%eax
    1416:	83 e8 01             	sub    $0x1,%eax
    1419:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    141c:	8b 45 08             	mov    0x8(%ebp),%eax
    141f:	8b 40 04             	mov    0x4(%eax),%eax
    1422:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1425:	7f 0c                	jg     1433 <APDrawRect+0x194>
    1427:	8b 45 08             	mov    0x8(%ebp),%eax
    142a:	8b 40 04             	mov    0x4(%eax),%eax
    142d:	83 e8 01             	sub    $0x1,%eax
    1430:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1433:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    143a:	8b 45 0c             	mov    0xc(%ebp),%eax
    143d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1440:	eb 52                	jmp    1494 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1442:	8b 45 10             	mov    0x10(%ebp),%eax
    1445:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1448:	eb 3e                	jmp    1488 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    144a:	83 ec 04             	sub    $0x4,%esp
    144d:	ff 75 e8             	pushl  -0x18(%ebp)
    1450:	ff 75 ec             	pushl  -0x14(%ebp)
    1453:	ff 75 08             	pushl  0x8(%ebp)
    1456:	e8 02 f7 ff ff       	call   b5d <APGetIndex>
    145b:	83 c4 10             	add    $0x10,%esp
    145e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1461:	8b 45 08             	mov    0x8(%ebp),%eax
    1464:	8b 48 18             	mov    0x18(%eax),%ecx
    1467:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    146a:	89 d0                	mov    %edx,%eax
    146c:	01 c0                	add    %eax,%eax
    146e:	01 d0                	add    %edx,%eax
    1470:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1473:	8b 45 08             	mov    0x8(%ebp),%eax
    1476:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    147a:	66 89 0a             	mov    %cx,(%edx)
    147d:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1481:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1484:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1488:	8b 45 e8             	mov    -0x18(%ebp),%eax
    148b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    148e:	7e ba                	jle    144a <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1490:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1494:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1497:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    149a:	7e a6                	jle    1442 <APDrawRect+0x1a3>
    149c:	eb 01                	jmp    149f <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    149e:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    149f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14a2:	c9                   	leave  
    14a3:	c3                   	ret    

000014a4 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14a4:	55                   	push   %ebp
    14a5:	89 e5                	mov    %esp,%ebp
    14a7:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14aa:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14ae:	0f 88 8e 01 00 00    	js     1642 <APDcCopy+0x19e>
    14b4:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14b8:	0f 88 84 01 00 00    	js     1642 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14be:	8b 55 0c             	mov    0xc(%ebp),%edx
    14c1:	8b 45 20             	mov    0x20(%ebp),%eax
    14c4:	01 d0                	add    %edx,%eax
    14c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14c9:	8b 55 10             	mov    0x10(%ebp),%edx
    14cc:	8b 45 24             	mov    0x24(%ebp),%eax
    14cf:	01 d0                	add    %edx,%eax
    14d1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14d4:	8b 55 18             	mov    0x18(%ebp),%edx
    14d7:	8b 45 20             	mov    0x20(%ebp),%eax
    14da:	01 d0                	add    %edx,%eax
    14dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14df:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14e2:	8b 45 24             	mov    0x24(%ebp),%eax
    14e5:	01 d0                	add    %edx,%eax
    14e7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    14ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14ee:	0f 88 51 01 00 00    	js     1645 <APDcCopy+0x1a1>
    14f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14f8:	0f 88 47 01 00 00    	js     1645 <APDcCopy+0x1a1>
    14fe:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1502:	0f 88 3d 01 00 00    	js     1645 <APDcCopy+0x1a1>
    1508:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    150c:	0f 88 33 01 00 00    	js     1645 <APDcCopy+0x1a1>
    1512:	8b 45 14             	mov    0x14(%ebp),%eax
    1515:	8b 00                	mov    (%eax),%eax
    1517:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    151a:	0f 8c 25 01 00 00    	jl     1645 <APDcCopy+0x1a1>
    1520:	8b 45 14             	mov    0x14(%ebp),%eax
    1523:	8b 40 04             	mov    0x4(%eax),%eax
    1526:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1529:	0f 8c 16 01 00 00    	jl     1645 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    152f:	8b 45 08             	mov    0x8(%ebp),%eax
    1532:	8b 00                	mov    (%eax),%eax
    1534:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1537:	7f 0b                	jg     1544 <APDcCopy+0xa0>
    1539:	8b 45 08             	mov    0x8(%ebp),%eax
    153c:	8b 00                	mov    (%eax),%eax
    153e:	83 e8 01             	sub    $0x1,%eax
    1541:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1544:	8b 45 08             	mov    0x8(%ebp),%eax
    1547:	8b 40 04             	mov    0x4(%eax),%eax
    154a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    154d:	7f 0c                	jg     155b <APDcCopy+0xb7>
    154f:	8b 45 08             	mov    0x8(%ebp),%eax
    1552:	8b 40 04             	mov    0x4(%eax),%eax
    1555:	83 e8 01             	sub    $0x1,%eax
    1558:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    155b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1562:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1569:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1570:	e9 bc 00 00 00       	jmp    1631 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1575:	8b 45 08             	mov    0x8(%ebp),%eax
    1578:	8b 00                	mov    (%eax),%eax
    157a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    157d:	8b 55 10             	mov    0x10(%ebp),%edx
    1580:	01 ca                	add    %ecx,%edx
    1582:	0f af d0             	imul   %eax,%edx
    1585:	8b 45 0c             	mov    0xc(%ebp),%eax
    1588:	01 d0                	add    %edx,%eax
    158a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    158d:	8b 45 14             	mov    0x14(%ebp),%eax
    1590:	8b 00                	mov    (%eax),%eax
    1592:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1595:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1598:	01 ca                	add    %ecx,%edx
    159a:	0f af d0             	imul   %eax,%edx
    159d:	8b 45 18             	mov    0x18(%ebp),%eax
    15a0:	01 d0                	add    %edx,%eax
    15a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    15a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15ac:	eb 74                	jmp    1622 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15ae:	8b 45 14             	mov    0x14(%ebp),%eax
    15b1:	8b 50 18             	mov    0x18(%eax),%edx
    15b4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ba:	01 c8                	add    %ecx,%eax
    15bc:	89 c1                	mov    %eax,%ecx
    15be:	89 c8                	mov    %ecx,%eax
    15c0:	01 c0                	add    %eax,%eax
    15c2:	01 c8                	add    %ecx,%eax
    15c4:	01 d0                	add    %edx,%eax
    15c6:	0f b7 10             	movzwl (%eax),%edx
    15c9:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15cd:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15d1:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15d4:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15d8:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15dc:	38 c2                	cmp    %al,%dl
    15de:	75 18                	jne    15f8 <APDcCopy+0x154>
    15e0:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15e4:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    15e8:	38 c2                	cmp    %al,%dl
    15ea:	75 0c                	jne    15f8 <APDcCopy+0x154>
    15ec:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    15f0:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    15f4:	38 c2                	cmp    %al,%dl
    15f6:	74 26                	je     161e <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    15f8:	8b 45 08             	mov    0x8(%ebp),%eax
    15fb:	8b 50 18             	mov    0x18(%eax),%edx
    15fe:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1601:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1604:	01 c8                	add    %ecx,%eax
    1606:	89 c1                	mov    %eax,%ecx
    1608:	89 c8                	mov    %ecx,%eax
    160a:	01 c0                	add    %eax,%eax
    160c:	01 c8                	add    %ecx,%eax
    160e:	01 d0                	add    %edx,%eax
    1610:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1614:	66 89 10             	mov    %dx,(%eax)
    1617:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    161b:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    161e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1622:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1625:	2b 45 0c             	sub    0xc(%ebp),%eax
    1628:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    162b:	7d 81                	jge    15ae <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    162d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1631:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1634:	2b 45 10             	sub    0x10(%ebp),%eax
    1637:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    163a:	0f 8d 35 ff ff ff    	jge    1575 <APDcCopy+0xd1>
    1640:	eb 04                	jmp    1646 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1642:	90                   	nop
    1643:	eb 01                	jmp    1646 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1645:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1646:	c9                   	leave  
    1647:	c3                   	ret    

00001648 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1648:	55                   	push   %ebp
    1649:	89 e5                	mov    %esp,%ebp
    164b:	83 ec 1c             	sub    $0x1c,%esp
    164e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1651:	8b 55 10             	mov    0x10(%ebp),%edx
    1654:	8b 45 14             	mov    0x14(%ebp),%eax
    1657:	88 4d ec             	mov    %cl,-0x14(%ebp)
    165a:	88 55 e8             	mov    %dl,-0x18(%ebp)
    165d:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1660:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1664:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1667:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    166b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    166e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1672:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1675:	8b 45 08             	mov    0x8(%ebp),%eax
    1678:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    167c:	66 89 10             	mov    %dx,(%eax)
    167f:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1683:	88 50 02             	mov    %dl,0x2(%eax)
}
    1686:	8b 45 08             	mov    0x8(%ebp),%eax
    1689:	c9                   	leave  
    168a:	c2 04 00             	ret    $0x4

0000168d <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    168d:	55                   	push   %ebp
    168e:	89 e5                	mov    %esp,%ebp
    1690:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1693:	8b 45 08             	mov    0x8(%ebp),%eax
    1696:	8b 00                	mov    (%eax),%eax
    1698:	83 ec 08             	sub    $0x8,%esp
    169b:	8d 55 0c             	lea    0xc(%ebp),%edx
    169e:	52                   	push   %edx
    169f:	50                   	push   %eax
    16a0:	e8 8d ef ff ff       	call   632 <sendMessage>
    16a5:	83 c4 10             	add    $0x10,%esp
}
    16a8:	90                   	nop
    16a9:	c9                   	leave  
    16aa:	c3                   	ret    

000016ab <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16ab:	55                   	push   %ebp
    16ac:	89 e5                	mov    %esp,%ebp
    16ae:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16b1:	83 ec 0c             	sub    $0xc,%esp
    16b4:	68 90 00 00 00       	push   $0x90
    16b9:	e8 3e f3 ff ff       	call   9fc <malloc>
    16be:	83 c4 10             	add    $0x10,%esp
    16c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16c8:	75 15                	jne    16df <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16ca:	83 ec 04             	sub    $0x4,%esp
    16cd:	ff 75 08             	pushl  0x8(%ebp)
    16d0:	68 bc 23 00 00       	push   $0x23bc
    16d5:	6a 01                	push   $0x1
    16d7:	e8 4d f0 ff ff       	call   729 <printf>
    16dc:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e2:	83 c0 7c             	add    $0x7c,%eax
    16e5:	83 ec 08             	sub    $0x8,%esp
    16e8:	ff 75 08             	pushl  0x8(%ebp)
    16eb:	50                   	push   %eax
    16ec:	e8 60 ec ff ff       	call   351 <strcpy>
    16f1:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    16f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f7:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    16fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1701:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1708:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170b:	8b 40 34             	mov    0x34(%eax),%eax
    170e:	89 c2                	mov    %eax,%edx
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	8b 40 38             	mov    0x38(%eax),%eax
    1716:	0f af d0             	imul   %eax,%edx
    1719:	89 d0                	mov    %edx,%eax
    171b:	01 c0                	add    %eax,%eax
    171d:	01 d0                	add    %edx,%eax
    171f:	83 ec 0c             	sub    $0xc,%esp
    1722:	50                   	push   %eax
    1723:	e8 d4 f2 ff ff       	call   9fc <malloc>
    1728:	83 c4 10             	add    $0x10,%esp
    172b:	89 c2                	mov    %eax,%edx
    172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1730:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1733:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1736:	8b 40 4c             	mov    0x4c(%eax),%eax
    1739:	85 c0                	test   %eax,%eax
    173b:	75 15                	jne    1752 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    173d:	83 ec 04             	sub    $0x4,%esp
    1740:	ff 75 08             	pushl  0x8(%ebp)
    1743:	68 dc 23 00 00       	push   $0x23dc
    1748:	6a 01                	push   $0x1
    174a:	e8 da ef ff ff       	call   729 <printf>
    174f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1752:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1755:	8b 40 34             	mov    0x34(%eax),%eax
    1758:	89 c2                	mov    %eax,%edx
    175a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175d:	8b 40 38             	mov    0x38(%eax),%eax
    1760:	0f af d0             	imul   %eax,%edx
    1763:	89 d0                	mov    %edx,%eax
    1765:	01 c0                	add    %eax,%eax
    1767:	01 c2                	add    %eax,%edx
    1769:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176c:	8b 40 4c             	mov    0x4c(%eax),%eax
    176f:	83 ec 04             	sub    $0x4,%esp
    1772:	52                   	push   %edx
    1773:	68 ff ff ff 00       	push   $0xffffff
    1778:	50                   	push   %eax
    1779:	e8 69 ec ff ff       	call   3e7 <memset>
    177e:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1781:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1784:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    178b:	e8 72 ee ff ff       	call   602 <getpid>
    1790:	89 c2                	mov    %eax,%edx
    1792:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1795:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1798:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179b:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a5:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17af:	8b 40 50             	mov    0x50(%eax),%eax
    17b2:	89 c2                	mov    %eax,%edx
    17b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b7:	8b 40 54             	mov    0x54(%eax),%eax
    17ba:	0f af d0             	imul   %eax,%edx
    17bd:	89 d0                	mov    %edx,%eax
    17bf:	01 c0                	add    %eax,%eax
    17c1:	01 d0                	add    %edx,%eax
    17c3:	83 ec 0c             	sub    $0xc,%esp
    17c6:	50                   	push   %eax
    17c7:	e8 30 f2 ff ff       	call   9fc <malloc>
    17cc:	83 c4 10             	add    $0x10,%esp
    17cf:	89 c2                	mov    %eax,%edx
    17d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d4:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    17d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17da:	8b 40 68             	mov    0x68(%eax),%eax
    17dd:	85 c0                	test   %eax,%eax
    17df:	75 15                	jne    17f6 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17e1:	83 ec 04             	sub    $0x4,%esp
    17e4:	ff 75 08             	pushl  0x8(%ebp)
    17e7:	68 00 24 00 00       	push   $0x2400
    17ec:	6a 01                	push   $0x1
    17ee:	e8 36 ef ff ff       	call   729 <printf>
    17f3:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f9:	8b 40 34             	mov    0x34(%eax),%eax
    17fc:	89 c2                	mov    %eax,%edx
    17fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1801:	8b 40 38             	mov    0x38(%eax),%eax
    1804:	0f af d0             	imul   %eax,%edx
    1807:	89 d0                	mov    %edx,%eax
    1809:	01 c0                	add    %eax,%eax
    180b:	01 c2                	add    %eax,%edx
    180d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1810:	8b 40 4c             	mov    0x4c(%eax),%eax
    1813:	83 ec 04             	sub    $0x4,%esp
    1816:	52                   	push   %edx
    1817:	68 ff 00 00 00       	push   $0xff
    181c:	50                   	push   %eax
    181d:	e8 c5 eb ff ff       	call   3e7 <memset>
    1822:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1828:	8b 55 0c             	mov    0xc(%ebp),%edx
    182b:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    182e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1832:	74 35                	je     1869 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1834:	8b 45 10             	mov    0x10(%ebp),%eax
    1837:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    183d:	83 ec 0c             	sub    $0xc,%esp
    1840:	50                   	push   %eax
    1841:	e8 b6 f1 ff ff       	call   9fc <malloc>
    1846:	83 c4 10             	add    $0x10,%esp
    1849:	89 c2                	mov    %eax,%edx
    184b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184e:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1851:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1854:	8b 55 10             	mov    0x10(%ebp),%edx
    1857:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    185a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1864:	e9 8d 00 00 00       	jmp    18f6 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1869:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186c:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1873:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1876:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    187d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1880:	8b 40 18             	mov    0x18(%eax),%eax
    1883:	89 c2                	mov    %eax,%edx
    1885:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1888:	8b 40 1c             	mov    0x1c(%eax),%eax
    188b:	0f af d0             	imul   %eax,%edx
    188e:	89 d0                	mov    %edx,%eax
    1890:	01 c0                	add    %eax,%eax
    1892:	01 d0                	add    %edx,%eax
    1894:	83 ec 0c             	sub    $0xc,%esp
    1897:	50                   	push   %eax
    1898:	e8 5f f1 ff ff       	call   9fc <malloc>
    189d:	83 c4 10             	add    $0x10,%esp
    18a0:	89 c2                	mov    %eax,%edx
    18a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a5:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    18a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ab:	8b 40 30             	mov    0x30(%eax),%eax
    18ae:	85 c0                	test   %eax,%eax
    18b0:	75 15                	jne    18c7 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18b2:	83 ec 04             	sub    $0x4,%esp
    18b5:	ff 75 08             	pushl  0x8(%ebp)
    18b8:	68 28 24 00 00       	push   $0x2428
    18bd:	6a 01                	push   $0x1
    18bf:	e8 65 ee ff ff       	call   729 <printf>
    18c4:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ca:	8b 40 18             	mov    0x18(%eax),%eax
    18cd:	89 c2                	mov    %eax,%edx
    18cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d2:	8b 40 1c             	mov    0x1c(%eax),%eax
    18d5:	0f af d0             	imul   %eax,%edx
    18d8:	89 d0                	mov    %edx,%eax
    18da:	01 c0                	add    %eax,%eax
    18dc:	01 c2                	add    %eax,%edx
    18de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e1:	8b 40 30             	mov    0x30(%eax),%eax
    18e4:	83 ec 04             	sub    $0x4,%esp
    18e7:	52                   	push   %edx
    18e8:	68 ff ff ff 00       	push   $0xffffff
    18ed:	50                   	push   %eax
    18ee:	e8 f4 ea ff ff       	call   3e7 <memset>
    18f3:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    18f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    18f9:	c9                   	leave  
    18fa:	c3                   	ret    

000018fb <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    18fb:	55                   	push   %ebp
    18fc:	89 e5                	mov    %esp,%ebp
    18fe:	53                   	push   %ebx
    18ff:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1902:	8b 45 0c             	mov    0xc(%ebp),%eax
    1905:	83 f8 03             	cmp    $0x3,%eax
    1908:	74 02                	je     190c <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    190a:	eb 33                	jmp    193f <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    190c:	8b 45 08             	mov    0x8(%ebp),%eax
    190f:	8b 48 08             	mov    0x8(%eax),%ecx
    1912:	8b 45 08             	mov    0x8(%ebp),%eax
    1915:	8b 50 38             	mov    0x38(%eax),%edx
    1918:	8b 45 08             	mov    0x8(%ebp),%eax
    191b:	8b 40 34             	mov    0x34(%eax),%eax
    191e:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1921:	83 c3 34             	add    $0x34,%ebx
    1924:	83 ec 0c             	sub    $0xc,%esp
    1927:	51                   	push   %ecx
    1928:	52                   	push   %edx
    1929:	50                   	push   %eax
    192a:	6a 00                	push   $0x0
    192c:	6a 00                	push   $0x0
    192e:	53                   	push   %ebx
    192f:	6a 32                	push   $0x32
    1931:	6a 00                	push   $0x0
    1933:	ff 75 08             	pushl  0x8(%ebp)
    1936:	e8 e7 ec ff ff       	call   622 <paintWindow>
    193b:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    193e:	90                   	nop
        default: break;
            
            
    }
    return False;
    193f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1944:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1947:	c9                   	leave  
    1948:	c3                   	ret    

00001949 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1949:	55                   	push   %ebp
    194a:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    194c:	8b 45 0c             	mov    0xc(%ebp),%eax
    194f:	8b 50 08             	mov    0x8(%eax),%edx
    1952:	8b 45 08             	mov    0x8(%ebp),%eax
    1955:	8b 00                	mov    (%eax),%eax
    1957:	39 c2                	cmp    %eax,%edx
    1959:	74 07                	je     1962 <APPreJudge+0x19>
        return False;
    195b:	b8 00 00 00 00       	mov    $0x0,%eax
    1960:	eb 05                	jmp    1967 <APPreJudge+0x1e>
    return True;
    1962:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1967:	5d                   	pop    %ebp
    1968:	c3                   	ret    

00001969 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1969:	55                   	push   %ebp
    196a:	89 e5                	mov    %esp,%ebp
    196c:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    196f:	8b 45 08             	mov    0x8(%ebp),%eax
    1972:	8b 55 0c             	mov    0xc(%ebp),%edx
    1975:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1978:	83 ec 0c             	sub    $0xc,%esp
    197b:	ff 75 08             	pushl  0x8(%ebp)
    197e:	e8 bf ec ff ff       	call   642 <registWindow>
    1983:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1986:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    198d:	8b 45 08             	mov    0x8(%ebp),%eax
    1990:	8b 00                	mov    (%eax),%eax
    1992:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1995:	ff 75 f4             	pushl  -0xc(%ebp)
    1998:	ff 75 f0             	pushl  -0x10(%ebp)
    199b:	ff 75 ec             	pushl  -0x14(%ebp)
    199e:	ff 75 08             	pushl  0x8(%ebp)
    19a1:	e8 e7 fc ff ff       	call   168d <APSendMessage>
    19a6:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19a9:	83 ec 0c             	sub    $0xc,%esp
    19ac:	ff 75 08             	pushl  0x8(%ebp)
    19af:	e8 86 ec ff ff       	call   63a <getMessage>
    19b4:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	83 c0 6c             	add    $0x6c,%eax
    19bd:	83 ec 08             	sub    $0x8,%esp
    19c0:	50                   	push   %eax
    19c1:	ff 75 08             	pushl  0x8(%ebp)
    19c4:	e8 80 ff ff ff       	call   1949 <APPreJudge>
    19c9:	83 c4 10             	add    $0x10,%esp
    19cc:	84 c0                	test   %al,%al
    19ce:	74 1b                	je     19eb <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    19d0:	8b 45 08             	mov    0x8(%ebp),%eax
    19d3:	ff 70 74             	pushl  0x74(%eax)
    19d6:	ff 70 70             	pushl  0x70(%eax)
    19d9:	ff 70 6c             	pushl  0x6c(%eax)
    19dc:	ff 75 08             	pushl  0x8(%ebp)
    19df:	8b 45 0c             	mov    0xc(%ebp),%eax
    19e2:	ff d0                	call   *%eax
    19e4:	83 c4 10             	add    $0x10,%esp
    19e7:	84 c0                	test   %al,%al
    19e9:	75 0c                	jne    19f7 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    19f5:	eb b2                	jmp    19a9 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    19f7:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    19f8:	90                   	nop
    19f9:	c9                   	leave  
    19fa:	c3                   	ret    

000019fb <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    19fb:	55                   	push   %ebp
    19fc:	89 e5                	mov    %esp,%ebp
    19fe:	57                   	push   %edi
    19ff:	56                   	push   %esi
    1a00:	53                   	push   %ebx
    1a01:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a04:	a1 ec 2a 00 00       	mov    0x2aec,%eax
    1a09:	85 c0                	test   %eax,%eax
    1a0b:	0f 85 2c 02 00 00    	jne    1c3d <APGridPaint+0x242>
    {
        iconReady = 1;
    1a11:	c7 05 ec 2a 00 00 01 	movl   $0x1,0x2aec
    1a18:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a1b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a1e:	83 ec 08             	sub    $0x8,%esp
    1a21:	68 4f 24 00 00       	push   $0x244f
    1a26:	50                   	push   %eax
    1a27:	e8 83 f1 ff ff       	call   baf <APLoadBitmap>
    1a2c:	83 c4 0c             	add    $0xc,%esp
    1a2f:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a32:	a3 20 2f 00 00       	mov    %eax,0x2f20
    1a37:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a3a:	a3 24 2f 00 00       	mov    %eax,0x2f24
    1a3f:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a42:	a3 28 2f 00 00       	mov    %eax,0x2f28
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a47:	83 ec 04             	sub    $0x4,%esp
    1a4a:	ff 35 28 2f 00 00    	pushl  0x2f28
    1a50:	ff 35 24 2f 00 00    	pushl  0x2f24
    1a56:	ff 35 20 2f 00 00    	pushl  0x2f20
    1a5c:	e8 88 f3 ff ff       	call   de9 <APCreateCompatibleDCFromBitmap>
    1a61:	83 c4 10             	add    $0x10,%esp
    1a64:	a3 2c 2f 00 00       	mov    %eax,0x2f2c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a69:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a6c:	83 ec 08             	sub    $0x8,%esp
    1a6f:	68 5d 24 00 00       	push   $0x245d
    1a74:	50                   	push   %eax
    1a75:	e8 35 f1 ff ff       	call   baf <APLoadBitmap>
    1a7a:	83 c4 0c             	add    $0xc,%esp
    1a7d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a80:	a3 5c 2f 00 00       	mov    %eax,0x2f5c
    1a85:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a88:	a3 60 2f 00 00       	mov    %eax,0x2f60
    1a8d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a90:	a3 64 2f 00 00       	mov    %eax,0x2f64
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1a95:	83 ec 04             	sub    $0x4,%esp
    1a98:	ff 35 64 2f 00 00    	pushl  0x2f64
    1a9e:	ff 35 60 2f 00 00    	pushl  0x2f60
    1aa4:	ff 35 5c 2f 00 00    	pushl  0x2f5c
    1aaa:	e8 3a f3 ff ff       	call   de9 <APCreateCompatibleDCFromBitmap>
    1aaf:	83 c4 10             	add    $0x10,%esp
    1ab2:	a3 4c 2f 00 00       	mov    %eax,0x2f4c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1ab7:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aba:	83 ec 08             	sub    $0x8,%esp
    1abd:	68 6c 24 00 00       	push   $0x246c
    1ac2:	50                   	push   %eax
    1ac3:	e8 e7 f0 ff ff       	call   baf <APLoadBitmap>
    1ac8:	83 c4 0c             	add    $0xc,%esp
    1acb:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ace:	a3 50 2f 00 00       	mov    %eax,0x2f50
    1ad3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ad6:	a3 54 2f 00 00       	mov    %eax,0x2f54
    1adb:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ade:	a3 58 2f 00 00       	mov    %eax,0x2f58
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1ae3:	83 ec 04             	sub    $0x4,%esp
    1ae6:	ff 35 58 2f 00 00    	pushl  0x2f58
    1aec:	ff 35 54 2f 00 00    	pushl  0x2f54
    1af2:	ff 35 50 2f 00 00    	pushl  0x2f50
    1af8:	e8 ec f2 ff ff       	call   de9 <APCreateCompatibleDCFromBitmap>
    1afd:	83 c4 10             	add    $0x10,%esp
    1b00:	a3 00 2f 00 00       	mov    %eax,0x2f00
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b05:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b08:	83 ec 08             	sub    $0x8,%esp
    1b0b:	68 7b 24 00 00       	push   $0x247b
    1b10:	50                   	push   %eax
    1b11:	e8 99 f0 ff ff       	call   baf <APLoadBitmap>
    1b16:	83 c4 0c             	add    $0xc,%esp
    1b19:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b1c:	a3 34 2f 00 00       	mov    %eax,0x2f34
    1b21:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b24:	a3 38 2f 00 00       	mov    %eax,0x2f38
    1b29:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b2c:	a3 3c 2f 00 00       	mov    %eax,0x2f3c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b31:	83 ec 04             	sub    $0x4,%esp
    1b34:	ff 35 3c 2f 00 00    	pushl  0x2f3c
    1b3a:	ff 35 38 2f 00 00    	pushl  0x2f38
    1b40:	ff 35 34 2f 00 00    	pushl  0x2f34
    1b46:	e8 9e f2 ff ff       	call   de9 <APCreateCompatibleDCFromBitmap>
    1b4b:	83 c4 10             	add    $0x10,%esp
    1b4e:	a3 68 2f 00 00       	mov    %eax,0x2f68
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b53:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b56:	83 ec 08             	sub    $0x8,%esp
    1b59:	68 89 24 00 00       	push   $0x2489
    1b5e:	50                   	push   %eax
    1b5f:	e8 4b f0 ff ff       	call   baf <APLoadBitmap>
    1b64:	83 c4 0c             	add    $0xc,%esp
    1b67:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b6a:	a3 10 2f 00 00       	mov    %eax,0x2f10
    1b6f:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b72:	a3 14 2f 00 00       	mov    %eax,0x2f14
    1b77:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b7a:	a3 18 2f 00 00       	mov    %eax,0x2f18
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b7f:	83 ec 04             	sub    $0x4,%esp
    1b82:	ff 35 18 2f 00 00    	pushl  0x2f18
    1b88:	ff 35 14 2f 00 00    	pushl  0x2f14
    1b8e:	ff 35 10 2f 00 00    	pushl  0x2f10
    1b94:	e8 50 f2 ff ff       	call   de9 <APCreateCompatibleDCFromBitmap>
    1b99:	83 c4 10             	add    $0x10,%esp
    1b9c:	a3 30 2f 00 00       	mov    %eax,0x2f30
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1ba1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ba4:	83 ec 08             	sub    $0x8,%esp
    1ba7:	68 99 24 00 00       	push   $0x2499
    1bac:	50                   	push   %eax
    1bad:	e8 fd ef ff ff       	call   baf <APLoadBitmap>
    1bb2:	83 c4 0c             	add    $0xc,%esp
    1bb5:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bb8:	a3 04 2f 00 00       	mov    %eax,0x2f04
    1bbd:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bc0:	a3 08 2f 00 00       	mov    %eax,0x2f08
    1bc5:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bc8:	a3 0c 2f 00 00       	mov    %eax,0x2f0c
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1bcd:	83 ec 04             	sub    $0x4,%esp
    1bd0:	ff 35 0c 2f 00 00    	pushl  0x2f0c
    1bd6:	ff 35 08 2f 00 00    	pushl  0x2f08
    1bdc:	ff 35 04 2f 00 00    	pushl  0x2f04
    1be2:	e8 02 f2 ff ff       	call   de9 <APCreateCompatibleDCFromBitmap>
    1be7:	83 c4 10             	add    $0x10,%esp
    1bea:	a3 1c 2f 00 00       	mov    %eax,0x2f1c
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1bef:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bf2:	83 ec 08             	sub    $0x8,%esp
    1bf5:	68 ab 24 00 00       	push   $0x24ab
    1bfa:	50                   	push   %eax
    1bfb:	e8 af ef ff ff       	call   baf <APLoadBitmap>
    1c00:	83 c4 0c             	add    $0xc,%esp
    1c03:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c06:	a3 40 2f 00 00       	mov    %eax,0x2f40
    1c0b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c0e:	a3 44 2f 00 00       	mov    %eax,0x2f44
    1c13:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c16:	a3 48 2f 00 00       	mov    %eax,0x2f48
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c1b:	83 ec 04             	sub    $0x4,%esp
    1c1e:	ff 35 48 2f 00 00    	pushl  0x2f48
    1c24:	ff 35 44 2f 00 00    	pushl  0x2f44
    1c2a:	ff 35 40 2f 00 00    	pushl  0x2f40
    1c30:	e8 b4 f1 ff ff       	call   de9 <APCreateCompatibleDCFromBitmap>
    1c35:	83 c4 10             	add    $0x10,%esp
    1c38:	a3 6c 2f 00 00       	mov    %eax,0x2f6c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c40:	8b 40 08             	mov    0x8(%eax),%eax
    1c43:	85 c0                	test   %eax,%eax
    1c45:	75 17                	jne    1c5e <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c47:	83 ec 08             	sub    $0x8,%esp
    1c4a:	68 bc 24 00 00       	push   $0x24bc
    1c4f:	6a 01                	push   $0x1
    1c51:	e8 d3 ea ff ff       	call   729 <printf>
    1c56:	83 c4 10             	add    $0x10,%esp
        return;
    1c59:	e9 f2 03 00 00       	jmp    2050 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c5e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c61:	8b 40 10             	mov    0x10(%eax),%eax
    1c64:	85 c0                	test   %eax,%eax
    1c66:	7e 10                	jle    1c78 <APGridPaint+0x27d>
    1c68:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6b:	8b 50 14             	mov    0x14(%eax),%edx
    1c6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c71:	8b 40 10             	mov    0x10(%eax),%eax
    1c74:	39 c2                	cmp    %eax,%edx
    1c76:	7c 17                	jl     1c8f <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1c78:	83 ec 08             	sub    $0x8,%esp
    1c7b:	68 e2 24 00 00       	push   $0x24e2
    1c80:	6a 01                	push   $0x1
    1c82:	e8 a2 ea ff ff       	call   729 <printf>
    1c87:	83 c4 10             	add    $0x10,%esp
        return;
    1c8a:	e9 c1 03 00 00       	jmp    2050 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1c8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c92:	8b 40 14             	mov    0x14(%eax),%eax
    1c95:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1c9b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1c9e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1ca1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1ca4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1cab:	e9 96 03 00 00       	jmp    2046 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1cb0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1cb7:	e9 7c 03 00 00       	jmp    2038 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1cbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cbf:	c1 e0 04             	shl    $0x4,%eax
    1cc2:	89 c2                	mov    %eax,%edx
    1cc4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1cc7:	01 c2                	add    %eax,%edx
    1cc9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ccc:	01 d0                	add    %edx,%eax
    1cce:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1cd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd4:	8b 40 0c             	mov    0xc(%eax),%eax
    1cd7:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1cda:	c1 e2 02             	shl    $0x2,%edx
    1cdd:	01 d0                	add    %edx,%eax
    1cdf:	8b 00                	mov    (%eax),%eax
    1ce1:	83 f8 07             	cmp    $0x7,%eax
    1ce4:	0f 87 49 03 00 00    	ja     2033 <APGridPaint+0x638>
    1cea:	8b 04 85 f8 24 00 00 	mov    0x24f8(,%eax,4),%eax
    1cf1:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1cf3:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1cf6:	6a 0c                	push   $0xc
    1cf8:	6a 0c                	push   $0xc
    1cfa:	6a 0c                	push   $0xc
    1cfc:	50                   	push   %eax
    1cfd:	e8 46 f9 ff ff       	call   1648 <RGB>
    1d02:	83 c4 0c             	add    $0xc,%esp
    1d05:	8b 1d 2c 2f 00 00    	mov    0x2f2c,%ebx
    1d0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d0e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d11:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d14:	6b c0 32             	imul   $0x32,%eax,%eax
    1d17:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1d:	8d 78 34             	lea    0x34(%eax),%edi
    1d20:	83 ec 0c             	sub    $0xc,%esp
    1d23:	83 ec 04             	sub    $0x4,%esp
    1d26:	89 e0                	mov    %esp,%eax
    1d28:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d2c:	66 89 30             	mov    %si,(%eax)
    1d2f:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d33:	88 50 02             	mov    %dl,0x2(%eax)
    1d36:	6a 32                	push   $0x32
    1d38:	6a 32                	push   $0x32
    1d3a:	6a 00                	push   $0x0
    1d3c:	6a 00                	push   $0x0
    1d3e:	53                   	push   %ebx
    1d3f:	51                   	push   %ecx
    1d40:	ff 75 94             	pushl  -0x6c(%ebp)
    1d43:	57                   	push   %edi
    1d44:	e8 5b f7 ff ff       	call   14a4 <APDcCopy>
    1d49:	83 c4 30             	add    $0x30,%esp
                    break;
    1d4c:	e9 e3 02 00 00       	jmp    2034 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d51:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d54:	6a 69                	push   $0x69
    1d56:	6a 69                	push   $0x69
    1d58:	6a 69                	push   $0x69
    1d5a:	50                   	push   %eax
    1d5b:	e8 e8 f8 ff ff       	call   1648 <RGB>
    1d60:	83 c4 0c             	add    $0xc,%esp
    1d63:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d67:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1d6b:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d6f:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1d72:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d79:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d7c:	6a 69                	push   $0x69
    1d7e:	6a 69                	push   $0x69
    1d80:	6a 69                	push   $0x69
    1d82:	50                   	push   %eax
    1d83:	e8 c0 f8 ff ff       	call   1648 <RGB>
    1d88:	83 c4 0c             	add    $0xc,%esp
    1d8b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d8f:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1d93:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d97:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9d:	8d 50 34             	lea    0x34(%eax),%edx
    1da0:	8d 45 98             	lea    -0x68(%ebp),%eax
    1da3:	ff 75 bc             	pushl  -0x44(%ebp)
    1da6:	ff 75 b8             	pushl  -0x48(%ebp)
    1da9:	52                   	push   %edx
    1daa:	50                   	push   %eax
    1dab:	e8 ce f0 ff ff       	call   e7e <APSetPen>
    1db0:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1db3:	8b 45 08             	mov    0x8(%ebp),%eax
    1db6:	8d 58 34             	lea    0x34(%eax),%ebx
    1db9:	8d 55 98             	lea    -0x68(%ebp),%edx
    1dbc:	83 ec 04             	sub    $0x4,%esp
    1dbf:	83 ec 04             	sub    $0x4,%esp
    1dc2:	89 e0                	mov    %esp,%eax
    1dc4:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1dc8:	66 89 08             	mov    %cx,(%eax)
    1dcb:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1dcf:	88 48 02             	mov    %cl,0x2(%eax)
    1dd2:	53                   	push   %ebx
    1dd3:	52                   	push   %edx
    1dd4:	e8 de f0 ff ff       	call   eb7 <APSetBrush>
    1dd9:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ddc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ddf:	6b d0 32             	imul   $0x32,%eax,%edx
    1de2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1de5:	6b c0 32             	imul   $0x32,%eax,%eax
    1de8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1deb:	83 c1 34             	add    $0x34,%ecx
    1dee:	83 ec 0c             	sub    $0xc,%esp
    1df1:	6a 32                	push   $0x32
    1df3:	6a 32                	push   $0x32
    1df5:	52                   	push   %edx
    1df6:	50                   	push   %eax
    1df7:	51                   	push   %ecx
    1df8:	e8 a2 f4 ff ff       	call   129f <APDrawRect>
    1dfd:	83 c4 20             	add    $0x20,%esp
                    break;
    1e00:	e9 2f 02 00 00       	jmp    2034 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e05:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e08:	6a 0c                	push   $0xc
    1e0a:	6a 0c                	push   $0xc
    1e0c:	6a 0c                	push   $0xc
    1e0e:	50                   	push   %eax
    1e0f:	e8 34 f8 ff ff       	call   1648 <RGB>
    1e14:	83 c4 0c             	add    $0xc,%esp
    1e17:	8b 1d 6c 2f 00 00    	mov    0x2f6c,%ebx
    1e1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e20:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e23:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e26:	6b c0 32             	imul   $0x32,%eax,%eax
    1e29:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2f:	8d 78 34             	lea    0x34(%eax),%edi
    1e32:	83 ec 0c             	sub    $0xc,%esp
    1e35:	83 ec 04             	sub    $0x4,%esp
    1e38:	89 e0                	mov    %esp,%eax
    1e3a:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e3e:	66 89 30             	mov    %si,(%eax)
    1e41:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e45:	88 50 02             	mov    %dl,0x2(%eax)
    1e48:	6a 32                	push   $0x32
    1e4a:	6a 32                	push   $0x32
    1e4c:	6a 00                	push   $0x0
    1e4e:	6a 00                	push   $0x0
    1e50:	53                   	push   %ebx
    1e51:	51                   	push   %ecx
    1e52:	ff 75 94             	pushl  -0x6c(%ebp)
    1e55:	57                   	push   %edi
    1e56:	e8 49 f6 ff ff       	call   14a4 <APDcCopy>
    1e5b:	83 c4 30             	add    $0x30,%esp
                    break;
    1e5e:	e9 d1 01 00 00       	jmp    2034 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e63:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e66:	6a 0c                	push   $0xc
    1e68:	6a 0c                	push   $0xc
    1e6a:	6a 0c                	push   $0xc
    1e6c:	50                   	push   %eax
    1e6d:	e8 d6 f7 ff ff       	call   1648 <RGB>
    1e72:	83 c4 0c             	add    $0xc,%esp
    1e75:	8b 1d 4c 2f 00 00    	mov    0x2f4c,%ebx
    1e7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e7e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e81:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e84:	6b c0 32             	imul   $0x32,%eax,%eax
    1e87:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8d:	8d 78 34             	lea    0x34(%eax),%edi
    1e90:	83 ec 0c             	sub    $0xc,%esp
    1e93:	83 ec 04             	sub    $0x4,%esp
    1e96:	89 e0                	mov    %esp,%eax
    1e98:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1e9c:	66 89 30             	mov    %si,(%eax)
    1e9f:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1ea3:	88 50 02             	mov    %dl,0x2(%eax)
    1ea6:	6a 32                	push   $0x32
    1ea8:	6a 32                	push   $0x32
    1eaa:	6a 00                	push   $0x0
    1eac:	6a 00                	push   $0x0
    1eae:	53                   	push   %ebx
    1eaf:	51                   	push   %ecx
    1eb0:	ff 75 94             	pushl  -0x6c(%ebp)
    1eb3:	57                   	push   %edi
    1eb4:	e8 eb f5 ff ff       	call   14a4 <APDcCopy>
    1eb9:	83 c4 30             	add    $0x30,%esp
                    break;
    1ebc:	e9 73 01 00 00       	jmp    2034 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ec1:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ec4:	6a 0c                	push   $0xc
    1ec6:	6a 0c                	push   $0xc
    1ec8:	6a 0c                	push   $0xc
    1eca:	50                   	push   %eax
    1ecb:	e8 78 f7 ff ff       	call   1648 <RGB>
    1ed0:	83 c4 0c             	add    $0xc,%esp
    1ed3:	8b 1d 30 2f 00 00    	mov    0x2f30,%ebx
    1ed9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1edc:	6b c8 32             	imul   $0x32,%eax,%ecx
    1edf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ee2:	6b c0 32             	imul   $0x32,%eax,%eax
    1ee5:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ee8:	8b 45 08             	mov    0x8(%ebp),%eax
    1eeb:	8d 78 34             	lea    0x34(%eax),%edi
    1eee:	83 ec 0c             	sub    $0xc,%esp
    1ef1:	83 ec 04             	sub    $0x4,%esp
    1ef4:	89 e0                	mov    %esp,%eax
    1ef6:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1efa:	66 89 30             	mov    %si,(%eax)
    1efd:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f01:	88 50 02             	mov    %dl,0x2(%eax)
    1f04:	6a 32                	push   $0x32
    1f06:	6a 32                	push   $0x32
    1f08:	6a 00                	push   $0x0
    1f0a:	6a 00                	push   $0x0
    1f0c:	53                   	push   %ebx
    1f0d:	51                   	push   %ecx
    1f0e:	ff 75 94             	pushl  -0x6c(%ebp)
    1f11:	57                   	push   %edi
    1f12:	e8 8d f5 ff ff       	call   14a4 <APDcCopy>
    1f17:	83 c4 30             	add    $0x30,%esp
                    break;
    1f1a:	e9 15 01 00 00       	jmp    2034 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f1f:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f22:	6a 0c                	push   $0xc
    1f24:	6a 0c                	push   $0xc
    1f26:	6a 0c                	push   $0xc
    1f28:	50                   	push   %eax
    1f29:	e8 1a f7 ff ff       	call   1648 <RGB>
    1f2e:	83 c4 0c             	add    $0xc,%esp
    1f31:	8b 1d 68 2f 00 00    	mov    0x2f68,%ebx
    1f37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f3a:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f40:	6b c0 32             	imul   $0x32,%eax,%eax
    1f43:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f46:	8b 45 08             	mov    0x8(%ebp),%eax
    1f49:	8d 78 34             	lea    0x34(%eax),%edi
    1f4c:	83 ec 0c             	sub    $0xc,%esp
    1f4f:	83 ec 04             	sub    $0x4,%esp
    1f52:	89 e0                	mov    %esp,%eax
    1f54:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f58:	66 89 30             	mov    %si,(%eax)
    1f5b:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f5f:	88 50 02             	mov    %dl,0x2(%eax)
    1f62:	6a 32                	push   $0x32
    1f64:	6a 32                	push   $0x32
    1f66:	6a 00                	push   $0x0
    1f68:	6a 00                	push   $0x0
    1f6a:	53                   	push   %ebx
    1f6b:	51                   	push   %ecx
    1f6c:	ff 75 94             	pushl  -0x6c(%ebp)
    1f6f:	57                   	push   %edi
    1f70:	e8 2f f5 ff ff       	call   14a4 <APDcCopy>
    1f75:	83 c4 30             	add    $0x30,%esp
                    break;
    1f78:	e9 b7 00 00 00       	jmp    2034 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f7d:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f80:	6a 0c                	push   $0xc
    1f82:	6a 0c                	push   $0xc
    1f84:	6a 0c                	push   $0xc
    1f86:	50                   	push   %eax
    1f87:	e8 bc f6 ff ff       	call   1648 <RGB>
    1f8c:	83 c4 0c             	add    $0xc,%esp
    1f8f:	8b 1d 00 2f 00 00    	mov    0x2f00,%ebx
    1f95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f98:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f9e:	6b c0 32             	imul   $0x32,%eax,%eax
    1fa1:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fa4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa7:	8d 78 34             	lea    0x34(%eax),%edi
    1faa:	83 ec 0c             	sub    $0xc,%esp
    1fad:	83 ec 04             	sub    $0x4,%esp
    1fb0:	89 e0                	mov    %esp,%eax
    1fb2:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1fb6:	66 89 30             	mov    %si,(%eax)
    1fb9:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1fbd:	88 50 02             	mov    %dl,0x2(%eax)
    1fc0:	6a 32                	push   $0x32
    1fc2:	6a 32                	push   $0x32
    1fc4:	6a 00                	push   $0x0
    1fc6:	6a 00                	push   $0x0
    1fc8:	53                   	push   %ebx
    1fc9:	51                   	push   %ecx
    1fca:	ff 75 94             	pushl  -0x6c(%ebp)
    1fcd:	57                   	push   %edi
    1fce:	e8 d1 f4 ff ff       	call   14a4 <APDcCopy>
    1fd3:	83 c4 30             	add    $0x30,%esp
                    break;
    1fd6:	eb 5c                	jmp    2034 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fd8:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1fdb:	6a 0c                	push   $0xc
    1fdd:	6a 0c                	push   $0xc
    1fdf:	6a 0c                	push   $0xc
    1fe1:	50                   	push   %eax
    1fe2:	e8 61 f6 ff ff       	call   1648 <RGB>
    1fe7:	83 c4 0c             	add    $0xc,%esp
    1fea:	8b 1d 1c 2f 00 00    	mov    0x2f1c,%ebx
    1ff0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ff3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ff6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ff9:	6b c0 32             	imul   $0x32,%eax,%eax
    1ffc:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fff:	8b 45 08             	mov    0x8(%ebp),%eax
    2002:	8d 78 34             	lea    0x34(%eax),%edi
    2005:	83 ec 0c             	sub    $0xc,%esp
    2008:	83 ec 04             	sub    $0x4,%esp
    200b:	89 e0                	mov    %esp,%eax
    200d:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2011:	66 89 30             	mov    %si,(%eax)
    2014:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2018:	88 50 02             	mov    %dl,0x2(%eax)
    201b:	6a 32                	push   $0x32
    201d:	6a 32                	push   $0x32
    201f:	6a 00                	push   $0x0
    2021:	6a 00                	push   $0x0
    2023:	53                   	push   %ebx
    2024:	51                   	push   %ecx
    2025:	ff 75 94             	pushl  -0x6c(%ebp)
    2028:	57                   	push   %edi
    2029:	e8 76 f4 ff ff       	call   14a4 <APDcCopy>
    202e:	83 c4 30             	add    $0x30,%esp
                    break;
    2031:	eb 01                	jmp    2034 <APGridPaint+0x639>
                default: break;
    2033:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2034:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2038:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    203c:	0f 8e 7a fc ff ff    	jle    1cbc <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2042:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2046:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    204a:	0f 8e 60 fc ff ff    	jle    1cb0 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    2050:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2053:	5b                   	pop    %ebx
    2054:	5e                   	pop    %esi
    2055:	5f                   	pop    %edi
    2056:	5d                   	pop    %ebp
    2057:	c3                   	ret    

00002058 <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2058:	55                   	push   %ebp
    2059:	89 e5                	mov    %esp,%ebp
    205b:	53                   	push   %ebx
    205c:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    205f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2066:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    206a:	74 17                	je     2083 <sprintint+0x2b>
    206c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2070:	79 11                	jns    2083 <sprintint+0x2b>
        neg = 1;
    2072:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2079:	8b 45 10             	mov    0x10(%ebp),%eax
    207c:	f7 d8                	neg    %eax
    207e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2081:	eb 06                	jmp    2089 <sprintint+0x31>
    } else {
        x = xx;
    2083:	8b 45 10             	mov    0x10(%ebp),%eax
    2086:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2089:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2090:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2093:	8d 41 01             	lea    0x1(%ecx),%eax
    2096:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2099:	8b 5d 14             	mov    0x14(%ebp),%ebx
    209c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    209f:	ba 00 00 00 00       	mov    $0x0,%edx
    20a4:	f7 f3                	div    %ebx
    20a6:	89 d0                	mov    %edx,%eax
    20a8:	0f b6 80 c4 2a 00 00 	movzbl 0x2ac4(%eax),%eax
    20af:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    20b3:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20b9:	ba 00 00 00 00       	mov    $0x0,%edx
    20be:	f7 f3                	div    %ebx
    20c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    20c7:	75 c7                	jne    2090 <sprintint+0x38>
    if(neg)
    20c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20cd:	74 0e                	je     20dd <sprintint+0x85>
        buf[i++] = '-';
    20cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20d2:	8d 50 01             	lea    0x1(%eax),%edx
    20d5:	89 55 f8             	mov    %edx,-0x8(%ebp)
    20d8:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    20dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20e0:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    20e3:	eb 1b                	jmp    2100 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    20e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    20e8:	8b 00                	mov    (%eax),%eax
    20ea:	8d 48 01             	lea    0x1(%eax),%ecx
    20ed:	8b 55 0c             	mov    0xc(%ebp),%edx
    20f0:	89 0a                	mov    %ecx,(%edx)
    20f2:	89 c2                	mov    %eax,%edx
    20f4:	8b 45 08             	mov    0x8(%ebp),%eax
    20f7:	01 d0                	add    %edx,%eax
    20f9:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    20fc:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2100:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2104:	7f df                	jg     20e5 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2106:	eb 21                	jmp    2129 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2108:	8b 45 0c             	mov    0xc(%ebp),%eax
    210b:	8b 00                	mov    (%eax),%eax
    210d:	8d 48 01             	lea    0x1(%eax),%ecx
    2110:	8b 55 0c             	mov    0xc(%ebp),%edx
    2113:	89 0a                	mov    %ecx,(%edx)
    2115:	89 c2                	mov    %eax,%edx
    2117:	8b 45 08             	mov    0x8(%ebp),%eax
    211a:	01 c2                	add    %eax,%edx
    211c:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    211f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2122:	01 c8                	add    %ecx,%eax
    2124:	0f b6 00             	movzbl (%eax),%eax
    2127:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2129:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    212d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2131:	79 d5                	jns    2108 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2133:	90                   	nop
    2134:	83 c4 20             	add    $0x20,%esp
    2137:	5b                   	pop    %ebx
    2138:	5d                   	pop    %ebp
    2139:	c3                   	ret    

0000213a <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    213a:	55                   	push   %ebp
    213b:	89 e5                	mov    %esp,%ebp
    213d:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2140:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2147:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    214e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2155:	8d 45 0c             	lea    0xc(%ebp),%eax
    2158:	83 c0 04             	add    $0x4,%eax
    215b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    215e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2165:	e9 d9 01 00 00       	jmp    2343 <sprintf+0x209>
        c = fmt[i] & 0xff;
    216a:	8b 55 0c             	mov    0xc(%ebp),%edx
    216d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2170:	01 d0                	add    %edx,%eax
    2172:	0f b6 00             	movzbl (%eax),%eax
    2175:	0f be c0             	movsbl %al,%eax
    2178:	25 ff 00 00 00       	and    $0xff,%eax
    217d:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2180:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2184:	75 2c                	jne    21b2 <sprintf+0x78>
            if(c == '%'){
    2186:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    218a:	75 0c                	jne    2198 <sprintf+0x5e>
                state = '%';
    218c:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2193:	e9 a7 01 00 00       	jmp    233f <sprintf+0x205>
            } else {
                dst[j++] = c;
    2198:	8b 45 c8             	mov    -0x38(%ebp),%eax
    219b:	8d 50 01             	lea    0x1(%eax),%edx
    219e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21a1:	89 c2                	mov    %eax,%edx
    21a3:	8b 45 08             	mov    0x8(%ebp),%eax
    21a6:	01 d0                	add    %edx,%eax
    21a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21ab:	88 10                	mov    %dl,(%eax)
    21ad:	e9 8d 01 00 00       	jmp    233f <sprintf+0x205>
            }
        } else if(state == '%'){
    21b2:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    21b6:	0f 85 83 01 00 00    	jne    233f <sprintf+0x205>
            if(c == 'd'){
    21bc:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    21c0:	75 4c                	jne    220e <sprintf+0xd4>
                buf[bi] = '\0';
    21c2:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21c8:	01 d0                	add    %edx,%eax
    21ca:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21cd:	83 ec 0c             	sub    $0xc,%esp
    21d0:	8d 45 ce             	lea    -0x32(%ebp),%eax
    21d3:	50                   	push   %eax
    21d4:	e8 17 e3 ff ff       	call   4f0 <atoi>
    21d9:	83 c4 10             	add    $0x10,%esp
    21dc:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    21df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    21e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21e9:	8b 00                	mov    (%eax),%eax
    21eb:	83 ec 08             	sub    $0x8,%esp
    21ee:	ff 75 d8             	pushl  -0x28(%ebp)
    21f1:	6a 01                	push   $0x1
    21f3:	6a 0a                	push   $0xa
    21f5:	50                   	push   %eax
    21f6:	8d 45 c8             	lea    -0x38(%ebp),%eax
    21f9:	50                   	push   %eax
    21fa:	ff 75 08             	pushl  0x8(%ebp)
    21fd:	e8 56 fe ff ff       	call   2058 <sprintint>
    2202:	83 c4 20             	add    $0x20,%esp
                ap++;
    2205:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2209:	e9 2a 01 00 00       	jmp    2338 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    220e:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2212:	74 06                	je     221a <sprintf+0xe0>
    2214:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2218:	75 4c                	jne    2266 <sprintf+0x12c>
                buf[bi] = '\0';
    221a:	8d 55 ce             	lea    -0x32(%ebp),%edx
    221d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2220:	01 d0                	add    %edx,%eax
    2222:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2225:	83 ec 0c             	sub    $0xc,%esp
    2228:	8d 45 ce             	lea    -0x32(%ebp),%eax
    222b:	50                   	push   %eax
    222c:	e8 bf e2 ff ff       	call   4f0 <atoi>
    2231:	83 c4 10             	add    $0x10,%esp
    2234:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2237:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    223e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2241:	8b 00                	mov    (%eax),%eax
    2243:	83 ec 08             	sub    $0x8,%esp
    2246:	ff 75 dc             	pushl  -0x24(%ebp)
    2249:	6a 00                	push   $0x0
    224b:	6a 10                	push   $0x10
    224d:	50                   	push   %eax
    224e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2251:	50                   	push   %eax
    2252:	ff 75 08             	pushl  0x8(%ebp)
    2255:	e8 fe fd ff ff       	call   2058 <sprintint>
    225a:	83 c4 20             	add    $0x20,%esp
                ap++;
    225d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2261:	e9 d2 00 00 00       	jmp    2338 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2266:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    226a:	75 46                	jne    22b2 <sprintf+0x178>
                s = (char*)*ap;
    226c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    226f:	8b 00                	mov    (%eax),%eax
    2271:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2274:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2278:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    227c:	75 25                	jne    22a3 <sprintf+0x169>
                    s = "(null)";
    227e:	c7 45 f4 18 25 00 00 	movl   $0x2518,-0xc(%ebp)
                while(*s != 0){
    2285:	eb 1c                	jmp    22a3 <sprintf+0x169>
                    dst[j++] = *s;
    2287:	8b 45 c8             	mov    -0x38(%ebp),%eax
    228a:	8d 50 01             	lea    0x1(%eax),%edx
    228d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2290:	89 c2                	mov    %eax,%edx
    2292:	8b 45 08             	mov    0x8(%ebp),%eax
    2295:	01 c2                	add    %eax,%edx
    2297:	8b 45 f4             	mov    -0xc(%ebp),%eax
    229a:	0f b6 00             	movzbl (%eax),%eax
    229d:	88 02                	mov    %al,(%edx)
                    s++;
    229f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    22a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22a6:	0f b6 00             	movzbl (%eax),%eax
    22a9:	84 c0                	test   %al,%al
    22ab:	75 da                	jne    2287 <sprintf+0x14d>
    22ad:	e9 86 00 00 00       	jmp    2338 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    22b2:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    22b6:	75 1d                	jne    22d5 <sprintf+0x19b>
                dst[j++] = *ap;
    22b8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22bb:	8d 50 01             	lea    0x1(%eax),%edx
    22be:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22c1:	89 c2                	mov    %eax,%edx
    22c3:	8b 45 08             	mov    0x8(%ebp),%eax
    22c6:	01 c2                	add    %eax,%edx
    22c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22cb:	8b 00                	mov    (%eax),%eax
    22cd:	88 02                	mov    %al,(%edx)
                ap++;
    22cf:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    22d3:	eb 63                	jmp    2338 <sprintf+0x1fe>
            } else if(c == '%'){
    22d5:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    22d9:	75 17                	jne    22f2 <sprintf+0x1b8>
                dst[j++] = c;
    22db:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22de:	8d 50 01             	lea    0x1(%eax),%edx
    22e1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22e4:	89 c2                	mov    %eax,%edx
    22e6:	8b 45 08             	mov    0x8(%ebp),%eax
    22e9:	01 d0                	add    %edx,%eax
    22eb:	8b 55 e0             	mov    -0x20(%ebp),%edx
    22ee:	88 10                	mov    %dl,(%eax)
    22f0:	eb 46                	jmp    2338 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    22f2:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    22f6:	7e 18                	jle    2310 <sprintf+0x1d6>
    22f8:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    22fc:	7f 12                	jg     2310 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    22fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2301:	8d 50 01             	lea    0x1(%eax),%edx
    2304:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2307:	8b 55 e0             	mov    -0x20(%ebp),%edx
    230a:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    230e:	eb 2f                	jmp    233f <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2310:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2313:	8d 50 01             	lea    0x1(%eax),%edx
    2316:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2319:	89 c2                	mov    %eax,%edx
    231b:	8b 45 08             	mov    0x8(%ebp),%eax
    231e:	01 d0                	add    %edx,%eax
    2320:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2323:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2326:	8d 50 01             	lea    0x1(%eax),%edx
    2329:	89 55 c8             	mov    %edx,-0x38(%ebp)
    232c:	89 c2                	mov    %eax,%edx
    232e:	8b 45 08             	mov    0x8(%ebp),%eax
    2331:	01 d0                	add    %edx,%eax
    2333:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2336:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2338:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    233f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2343:	8b 55 0c             	mov    0xc(%ebp),%edx
    2346:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2349:	01 d0                	add    %edx,%eax
    234b:	0f b6 00             	movzbl (%eax),%eax
    234e:	84 c0                	test   %al,%al
    2350:	0f 85 14 fe ff ff    	jne    216a <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2356:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2359:	8d 50 01             	lea    0x1(%eax),%edx
    235c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    235f:	89 c2                	mov    %eax,%edx
    2361:	8b 45 08             	mov    0x8(%ebp),%eax
    2364:	01 d0                	add    %edx,%eax
    2366:	c6 00 00             	movb   $0x0,(%eax)
}
    2369:	90                   	nop
    236a:	c9                   	leave  
    236b:	c3                   	ret    
