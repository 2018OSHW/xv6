
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
      18:	c7 45 f0 c0 2c 00 00 	movl   $0x2cc0,-0x10(%ebp)
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
      84:	81 7d f0 c0 2c 00 00 	cmpl   $0x2cc0,-0x10(%ebp)
      8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
      8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	ba c0 2c 00 00       	mov    $0x2cc0,%edx
      a2:	29 d0                	sub    %edx,%eax
      a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	ff 75 f4             	pushl  -0xc(%ebp)
      ad:	ff 75 f0             	pushl  -0x10(%ebp)
      b0:	68 c0 2c 00 00       	push   $0x2cc0
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
      ce:	05 c0 2c 00 00       	add    $0x2cc0,%eax
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
     10f:	68 e4 24 00 00       	push   $0x24e4
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
     18c:	68 04 25 00 00       	push   $0x2504
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

0000062a <sendMessage>:
SYSCALL(sendMessage)
     62a:	b8 17 00 00 00       	mov    $0x17,%eax
     62f:	cd 40                	int    $0x40
     631:	c3                   	ret    

00000632 <getMessage>:
SYSCALL(getMessage)
     632:	b8 19 00 00 00       	mov    $0x19,%eax
     637:	cd 40                	int    $0x40
     639:	c3                   	ret    

0000063a <registWindow>:
SYSCALL(registWindow)
     63a:	b8 18 00 00 00       	mov    $0x18,%eax
     63f:	cd 40                	int    $0x40
     641:	c3                   	ret    

00000642 <changePosition>:
SYSCALL(changePosition)
     642:	b8 1a 00 00 00       	mov    $0x1a,%eax
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
     6bd:	0f b6 80 70 2c 00 00 	movzbl 0x2c70(%eax),%eax
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
     7fb:	c7 45 f4 1a 25 00 00 	movl   $0x251a,-0xc(%ebp)
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
     8c1:	a1 a8 2c 00 00       	mov    0x2ca8,%eax
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
     98c:	a3 a8 2c 00 00       	mov    %eax,0x2ca8
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
     9ed:	a1 a8 2c 00 00       	mov    0x2ca8,%eax
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
     a09:	a1 a8 2c 00 00       	mov    0x2ca8,%eax
     a0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a11:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a15:	75 23                	jne    a3a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a17:	c7 45 f0 a0 2c 00 00 	movl   $0x2ca0,-0x10(%ebp)
     a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a21:	a3 a8 2c 00 00       	mov    %eax,0x2ca8
     a26:	a1 a8 2c 00 00       	mov    0x2ca8,%eax
     a2b:	a3 a0 2c 00 00       	mov    %eax,0x2ca0
    base.s.size = 0;
     a30:	c7 05 a4 2c 00 00 00 	movl   $0x0,0x2ca4
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
     a8d:	a3 a8 2c 00 00       	mov    %eax,0x2ca8
      return (void*)(p + 1);
     a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a95:	83 c0 08             	add    $0x8,%eax
     a98:	eb 3b                	jmp    ad5 <malloc+0xe1>
    }
    if(p == freep)
     a9a:	a1 a8 2c 00 00       	mov    0x2ca8,%eax
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
     be0:	68 21 25 00 00       	push   $0x2521
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

0000149c <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    149c:	55                   	push   %ebp
    149d:	89 e5                	mov    %esp,%ebp
}
    149f:	90                   	nop
    14a0:	5d                   	pop    %ebp
    14a1:	c3                   	ret    

000014a2 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14a2:	55                   	push   %ebp
    14a3:	89 e5                	mov    %esp,%ebp
    14a5:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14a8:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14ac:	0f 88 8e 01 00 00    	js     1640 <APDcCopy+0x19e>
    14b2:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14b6:	0f 88 84 01 00 00    	js     1640 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14bc:	8b 55 0c             	mov    0xc(%ebp),%edx
    14bf:	8b 45 20             	mov    0x20(%ebp),%eax
    14c2:	01 d0                	add    %edx,%eax
    14c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14c7:	8b 55 10             	mov    0x10(%ebp),%edx
    14ca:	8b 45 24             	mov    0x24(%ebp),%eax
    14cd:	01 d0                	add    %edx,%eax
    14cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14d2:	8b 55 18             	mov    0x18(%ebp),%edx
    14d5:	8b 45 20             	mov    0x20(%ebp),%eax
    14d8:	01 d0                	add    %edx,%eax
    14da:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14dd:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14e0:	8b 45 24             	mov    0x24(%ebp),%eax
    14e3:	01 d0                	add    %edx,%eax
    14e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    14e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14ec:	0f 88 51 01 00 00    	js     1643 <APDcCopy+0x1a1>
    14f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    14f6:	0f 88 47 01 00 00    	js     1643 <APDcCopy+0x1a1>
    14fc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1500:	0f 88 3d 01 00 00    	js     1643 <APDcCopy+0x1a1>
    1506:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    150a:	0f 88 33 01 00 00    	js     1643 <APDcCopy+0x1a1>
    1510:	8b 45 14             	mov    0x14(%ebp),%eax
    1513:	8b 00                	mov    (%eax),%eax
    1515:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1518:	0f 8c 25 01 00 00    	jl     1643 <APDcCopy+0x1a1>
    151e:	8b 45 14             	mov    0x14(%ebp),%eax
    1521:	8b 40 04             	mov    0x4(%eax),%eax
    1524:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1527:	0f 8c 16 01 00 00    	jl     1643 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    152d:	8b 45 08             	mov    0x8(%ebp),%eax
    1530:	8b 00                	mov    (%eax),%eax
    1532:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1535:	7f 0b                	jg     1542 <APDcCopy+0xa0>
    1537:	8b 45 08             	mov    0x8(%ebp),%eax
    153a:	8b 00                	mov    (%eax),%eax
    153c:	83 e8 01             	sub    $0x1,%eax
    153f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1542:	8b 45 08             	mov    0x8(%ebp),%eax
    1545:	8b 40 04             	mov    0x4(%eax),%eax
    1548:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    154b:	7f 0c                	jg     1559 <APDcCopy+0xb7>
    154d:	8b 45 08             	mov    0x8(%ebp),%eax
    1550:	8b 40 04             	mov    0x4(%eax),%eax
    1553:	83 e8 01             	sub    $0x1,%eax
    1556:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1559:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1560:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1567:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    156e:	e9 bc 00 00 00       	jmp    162f <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1573:	8b 45 08             	mov    0x8(%ebp),%eax
    1576:	8b 00                	mov    (%eax),%eax
    1578:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    157b:	8b 55 10             	mov    0x10(%ebp),%edx
    157e:	01 ca                	add    %ecx,%edx
    1580:	0f af d0             	imul   %eax,%edx
    1583:	8b 45 0c             	mov    0xc(%ebp),%eax
    1586:	01 d0                	add    %edx,%eax
    1588:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    158b:	8b 45 14             	mov    0x14(%ebp),%eax
    158e:	8b 00                	mov    (%eax),%eax
    1590:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1593:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1596:	01 ca                	add    %ecx,%edx
    1598:	0f af d0             	imul   %eax,%edx
    159b:	8b 45 18             	mov    0x18(%ebp),%eax
    159e:	01 d0                	add    %edx,%eax
    15a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    15a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15aa:	eb 74                	jmp    1620 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15ac:	8b 45 14             	mov    0x14(%ebp),%eax
    15af:	8b 50 18             	mov    0x18(%eax),%edx
    15b2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15b8:	01 c8                	add    %ecx,%eax
    15ba:	89 c1                	mov    %eax,%ecx
    15bc:	89 c8                	mov    %ecx,%eax
    15be:	01 c0                	add    %eax,%eax
    15c0:	01 c8                	add    %ecx,%eax
    15c2:	01 d0                	add    %edx,%eax
    15c4:	0f b7 10             	movzwl (%eax),%edx
    15c7:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15cb:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15cf:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15d2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15d6:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15da:	38 c2                	cmp    %al,%dl
    15dc:	75 18                	jne    15f6 <APDcCopy+0x154>
    15de:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15e2:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    15e6:	38 c2                	cmp    %al,%dl
    15e8:	75 0c                	jne    15f6 <APDcCopy+0x154>
    15ea:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    15ee:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    15f2:	38 c2                	cmp    %al,%dl
    15f4:	74 26                	je     161c <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    15f6:	8b 45 08             	mov    0x8(%ebp),%eax
    15f9:	8b 50 18             	mov    0x18(%eax),%edx
    15fc:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    15ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1602:	01 c8                	add    %ecx,%eax
    1604:	89 c1                	mov    %eax,%ecx
    1606:	89 c8                	mov    %ecx,%eax
    1608:	01 c0                	add    %eax,%eax
    160a:	01 c8                	add    %ecx,%eax
    160c:	01 d0                	add    %edx,%eax
    160e:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1612:	66 89 10             	mov    %dx,(%eax)
    1615:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1619:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    161c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1620:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1623:	2b 45 0c             	sub    0xc(%ebp),%eax
    1626:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1629:	7d 81                	jge    15ac <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    162b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    162f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1632:	2b 45 10             	sub    0x10(%ebp),%eax
    1635:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1638:	0f 8d 35 ff ff ff    	jge    1573 <APDcCopy+0xd1>
    163e:	eb 04                	jmp    1644 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1640:	90                   	nop
    1641:	eb 01                	jmp    1644 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1643:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1644:	c9                   	leave  
    1645:	c3                   	ret    

00001646 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1646:	55                   	push   %ebp
    1647:	89 e5                	mov    %esp,%ebp
    1649:	83 ec 1c             	sub    $0x1c,%esp
    164c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    164f:	8b 55 10             	mov    0x10(%ebp),%edx
    1652:	8b 45 14             	mov    0x14(%ebp),%eax
    1655:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1658:	88 55 e8             	mov    %dl,-0x18(%ebp)
    165b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    165e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1662:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1665:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1669:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    166c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1670:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1673:	8b 45 08             	mov    0x8(%ebp),%eax
    1676:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    167a:	66 89 10             	mov    %dx,(%eax)
    167d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1681:	88 50 02             	mov    %dl,0x2(%eax)
}
    1684:	8b 45 08             	mov    0x8(%ebp),%eax
    1687:	c9                   	leave  
    1688:	c2 04 00             	ret    $0x4

0000168b <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    168b:	55                   	push   %ebp
    168c:	89 e5                	mov    %esp,%ebp
    168e:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    1691:	8b 45 08             	mov    0x8(%ebp),%eax
    1694:	8b 00                	mov    (%eax),%eax
    1696:	83 ec 08             	sub    $0x8,%esp
    1699:	8d 55 0c             	lea    0xc(%ebp),%edx
    169c:	52                   	push   %edx
    169d:	50                   	push   %eax
    169e:	e8 87 ef ff ff       	call   62a <sendMessage>
    16a3:	83 c4 10             	add    $0x10,%esp
}
    16a6:	90                   	nop
    16a7:	c9                   	leave  
    16a8:	c3                   	ret    

000016a9 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16a9:	55                   	push   %ebp
    16aa:	89 e5                	mov    %esp,%ebp
    16ac:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16af:	83 ec 0c             	sub    $0xc,%esp
    16b2:	68 98 00 00 00       	push   $0x98
    16b7:	e8 38 f3 ff ff       	call   9f4 <malloc>
    16bc:	83 c4 10             	add    $0x10,%esp
    16bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16c6:	75 15                	jne    16dd <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16c8:	83 ec 04             	sub    $0x4,%esp
    16cb:	ff 75 08             	pushl  0x8(%ebp)
    16ce:	68 34 25 00 00       	push   $0x2534
    16d3:	6a 01                	push   $0x1
    16d5:	e8 47 f0 ff ff       	call   721 <printf>
    16da:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16e0:	05 84 00 00 00       	add    $0x84,%eax
    16e5:	83 ec 08             	sub    $0x8,%esp
    16e8:	ff 75 08             	pushl  0x8(%ebp)
    16eb:	50                   	push   %eax
    16ec:	e8 60 ec ff ff       	call   351 <strcpy>
    16f1:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    16f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f7:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    16fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1701:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1708:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170b:	8b 40 3c             	mov    0x3c(%eax),%eax
    170e:	89 c2                	mov    %eax,%edx
    1710:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1713:	8b 40 40             	mov    0x40(%eax),%eax
    1716:	0f af d0             	imul   %eax,%edx
    1719:	89 d0                	mov    %edx,%eax
    171b:	01 c0                	add    %eax,%eax
    171d:	01 d0                	add    %edx,%eax
    171f:	83 ec 0c             	sub    $0xc,%esp
    1722:	50                   	push   %eax
    1723:	e8 cc f2 ff ff       	call   9f4 <malloc>
    1728:	83 c4 10             	add    $0x10,%esp
    172b:	89 c2                	mov    %eax,%edx
    172d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1730:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1733:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1736:	8b 40 54             	mov    0x54(%eax),%eax
    1739:	85 c0                	test   %eax,%eax
    173b:	75 15                	jne    1752 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    173d:	83 ec 04             	sub    $0x4,%esp
    1740:	ff 75 08             	pushl  0x8(%ebp)
    1743:	68 54 25 00 00       	push   $0x2554
    1748:	6a 01                	push   $0x1
    174a:	e8 d2 ef ff ff       	call   721 <printf>
    174f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1752:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1755:	8b 40 3c             	mov    0x3c(%eax),%eax
    1758:	89 c2                	mov    %eax,%edx
    175a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175d:	8b 40 40             	mov    0x40(%eax),%eax
    1760:	0f af d0             	imul   %eax,%edx
    1763:	89 d0                	mov    %edx,%eax
    1765:	01 c0                	add    %eax,%eax
    1767:	01 c2                	add    %eax,%edx
    1769:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176c:	8b 40 54             	mov    0x54(%eax),%eax
    176f:	83 ec 04             	sub    $0x4,%esp
    1772:	52                   	push   %edx
    1773:	68 ff ff ff 00       	push   $0xffffff
    1778:	50                   	push   %eax
    1779:	e8 69 ec ff ff       	call   3e7 <memset>
    177e:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1781:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1784:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    178b:	e8 72 ee ff ff       	call   602 <getpid>
    1790:	89 c2                	mov    %eax,%edx
    1792:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1795:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1798:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179b:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a5:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17af:	8b 40 58             	mov    0x58(%eax),%eax
    17b2:	89 c2                	mov    %eax,%edx
    17b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b7:	8b 40 5c             	mov    0x5c(%eax),%eax
    17ba:	0f af d0             	imul   %eax,%edx
    17bd:	89 d0                	mov    %edx,%eax
    17bf:	01 c0                	add    %eax,%eax
    17c1:	01 d0                	add    %edx,%eax
    17c3:	83 ec 0c             	sub    $0xc,%esp
    17c6:	50                   	push   %eax
    17c7:	e8 28 f2 ff ff       	call   9f4 <malloc>
    17cc:	83 c4 10             	add    $0x10,%esp
    17cf:	89 c2                	mov    %eax,%edx
    17d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d4:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    17d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17da:	8b 40 70             	mov    0x70(%eax),%eax
    17dd:	85 c0                	test   %eax,%eax
    17df:	75 15                	jne    17f6 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17e1:	83 ec 04             	sub    $0x4,%esp
    17e4:	ff 75 08             	pushl  0x8(%ebp)
    17e7:	68 78 25 00 00       	push   $0x2578
    17ec:	6a 01                	push   $0x1
    17ee:	e8 2e ef ff ff       	call   721 <printf>
    17f3:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f9:	8b 40 3c             	mov    0x3c(%eax),%eax
    17fc:	89 c2                	mov    %eax,%edx
    17fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1801:	8b 40 40             	mov    0x40(%eax),%eax
    1804:	0f af d0             	imul   %eax,%edx
    1807:	89 d0                	mov    %edx,%eax
    1809:	01 c0                	add    %eax,%eax
    180b:	01 c2                	add    %eax,%edx
    180d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1810:	8b 40 54             	mov    0x54(%eax),%eax
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
    1832:	74 49                	je     187d <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1834:	8b 45 10             	mov    0x10(%ebp),%eax
    1837:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    183d:	83 ec 0c             	sub    $0xc,%esp
    1840:	50                   	push   %eax
    1841:	e8 ae f1 ff ff       	call   9f4 <malloc>
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
        r->pos_x = 0;
    1864:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1867:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1871:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1878:	e9 8d 00 00 00       	jmp    190a <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    187d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1880:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1887:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188a:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1891:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1894:	8b 40 20             	mov    0x20(%eax),%eax
    1897:	89 c2                	mov    %eax,%edx
    1899:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189c:	8b 40 24             	mov    0x24(%eax),%eax
    189f:	0f af d0             	imul   %eax,%edx
    18a2:	89 d0                	mov    %edx,%eax
    18a4:	01 c0                	add    %eax,%eax
    18a6:	01 d0                	add    %edx,%eax
    18a8:	83 ec 0c             	sub    $0xc,%esp
    18ab:	50                   	push   %eax
    18ac:	e8 43 f1 ff ff       	call   9f4 <malloc>
    18b1:	83 c4 10             	add    $0x10,%esp
    18b4:	89 c2                	mov    %eax,%edx
    18b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b9:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    18bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bf:	8b 40 38             	mov    0x38(%eax),%eax
    18c2:	85 c0                	test   %eax,%eax
    18c4:	75 15                	jne    18db <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18c6:	83 ec 04             	sub    $0x4,%esp
    18c9:	ff 75 08             	pushl  0x8(%ebp)
    18cc:	68 a0 25 00 00       	push   $0x25a0
    18d1:	6a 01                	push   $0x1
    18d3:	e8 49 ee ff ff       	call   721 <printf>
    18d8:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18de:	8b 40 20             	mov    0x20(%eax),%eax
    18e1:	89 c2                	mov    %eax,%edx
    18e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e6:	8b 40 24             	mov    0x24(%eax),%eax
    18e9:	0f af d0             	imul   %eax,%edx
    18ec:	89 d0                	mov    %edx,%eax
    18ee:	01 c0                	add    %eax,%eax
    18f0:	01 c2                	add    %eax,%edx
    18f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f5:	8b 40 38             	mov    0x38(%eax),%eax
    18f8:	83 ec 04             	sub    $0x4,%esp
    18fb:	52                   	push   %edx
    18fc:	68 ff ff ff 00       	push   $0xffffff
    1901:	50                   	push   %eax
    1902:	e8 e0 ea ff ff       	call   3e7 <memset>
    1907:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    190a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    190d:	c9                   	leave  
    190e:	c3                   	ret    

0000190f <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    190f:	55                   	push   %ebp
    1910:	89 e5                	mov    %esp,%ebp
    1912:	57                   	push   %edi
    1913:	56                   	push   %esi
    1914:	53                   	push   %ebx
    1915:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1918:	8b 45 0c             	mov    0xc(%ebp),%eax
    191b:	83 f8 03             	cmp    $0x3,%eax
    191e:	74 02                	je     1922 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1920:	eb 7c                	jmp    199e <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1922:	8b 45 08             	mov    0x8(%ebp),%eax
    1925:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1928:	8b 45 08             	mov    0x8(%ebp),%eax
    192b:	8b 48 18             	mov    0x18(%eax),%ecx
    192e:	8b 45 08             	mov    0x8(%ebp),%eax
    1931:	8b 50 5c             	mov    0x5c(%eax),%edx
    1934:	8b 45 08             	mov    0x8(%ebp),%eax
    1937:	8b 40 58             	mov    0x58(%eax),%eax
    193a:	8b 75 08             	mov    0x8(%ebp),%esi
    193d:	83 c6 58             	add    $0x58,%esi
    1940:	83 ec 04             	sub    $0x4,%esp
    1943:	53                   	push   %ebx
    1944:	51                   	push   %ecx
    1945:	6a 00                	push   $0x0
    1947:	52                   	push   %edx
    1948:	50                   	push   %eax
    1949:	6a 00                	push   $0x0
    194b:	6a 00                	push   $0x0
    194d:	56                   	push   %esi
    194e:	6a 00                	push   $0x0
    1950:	6a 00                	push   $0x0
    1952:	ff 75 08             	pushl  0x8(%ebp)
    1955:	e8 c8 ec ff ff       	call   622 <paintWindow>
    195a:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    195d:	8b 45 08             	mov    0x8(%ebp),%eax
    1960:	8b 70 1c             	mov    0x1c(%eax),%esi
    1963:	8b 45 08             	mov    0x8(%ebp),%eax
    1966:	8b 58 18             	mov    0x18(%eax),%ebx
    1969:	8b 45 08             	mov    0x8(%ebp),%eax
    196c:	8b 48 08             	mov    0x8(%eax),%ecx
    196f:	8b 45 08             	mov    0x8(%ebp),%eax
    1972:	8b 50 40             	mov    0x40(%eax),%edx
    1975:	8b 45 08             	mov    0x8(%ebp),%eax
    1978:	8b 40 3c             	mov    0x3c(%eax),%eax
    197b:	8b 7d 08             	mov    0x8(%ebp),%edi
    197e:	83 c7 3c             	add    $0x3c,%edi
    1981:	83 ec 04             	sub    $0x4,%esp
    1984:	56                   	push   %esi
    1985:	53                   	push   %ebx
    1986:	51                   	push   %ecx
    1987:	52                   	push   %edx
    1988:	50                   	push   %eax
    1989:	6a 00                	push   $0x0
    198b:	6a 00                	push   $0x0
    198d:	57                   	push   %edi
    198e:	6a 32                	push   $0x32
    1990:	6a 00                	push   $0x0
    1992:	ff 75 08             	pushl  0x8(%ebp)
    1995:	e8 88 ec ff ff       	call   622 <paintWindow>
    199a:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    199d:	90                   	nop
        default: break;
            
            
    }
    return False;
    199e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19a6:	5b                   	pop    %ebx
    19a7:	5e                   	pop    %esi
    19a8:	5f                   	pop    %edi
    19a9:	5d                   	pop    %ebp
    19aa:	c3                   	ret    

000019ab <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    19ab:	55                   	push   %ebp
    19ac:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    19ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    19b1:	8b 50 08             	mov    0x8(%eax),%edx
    19b4:	8b 45 08             	mov    0x8(%ebp),%eax
    19b7:	8b 00                	mov    (%eax),%eax
    19b9:	39 c2                	cmp    %eax,%edx
    19bb:	74 07                	je     19c4 <APPreJudge+0x19>
        return False;
    19bd:	b8 00 00 00 00       	mov    $0x0,%eax
    19c2:	eb 05                	jmp    19c9 <APPreJudge+0x1e>
    return True;
    19c4:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19c9:	5d                   	pop    %ebp
    19ca:	c3                   	ret    

000019cb <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19cb:	55                   	push   %ebp
    19cc:	89 e5                	mov    %esp,%ebp
    19ce:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19d1:	8b 45 08             	mov    0x8(%ebp),%eax
    19d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19d7:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    19dd:	83 ec 0c             	sub    $0xc,%esp
    19e0:	ff 75 08             	pushl  0x8(%ebp)
    19e3:	e8 52 ec ff ff       	call   63a <registWindow>
    19e8:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19eb:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    19f2:	8b 45 08             	mov    0x8(%ebp),%eax
    19f5:	8b 00                	mov    (%eax),%eax
    19f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    19fa:	ff 75 f4             	pushl  -0xc(%ebp)
    19fd:	ff 75 f0             	pushl  -0x10(%ebp)
    1a00:	ff 75 ec             	pushl  -0x14(%ebp)
    1a03:	ff 75 08             	pushl  0x8(%ebp)
    1a06:	e8 80 fc ff ff       	call   168b <APSendMessage>
    1a0b:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a0e:	83 ec 0c             	sub    $0xc,%esp
    1a11:	ff 75 08             	pushl  0x8(%ebp)
    1a14:	e8 19 ec ff ff       	call   632 <getMessage>
    1a19:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1f:	83 c0 74             	add    $0x74,%eax
    1a22:	83 ec 08             	sub    $0x8,%esp
    1a25:	50                   	push   %eax
    1a26:	ff 75 08             	pushl  0x8(%ebp)
    1a29:	e8 7d ff ff ff       	call   19ab <APPreJudge>
    1a2e:	83 c4 10             	add    $0x10,%esp
    1a31:	84 c0                	test   %al,%al
    1a33:	74 1b                	je     1a50 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1a35:	8b 45 08             	mov    0x8(%ebp),%eax
    1a38:	ff 70 7c             	pushl  0x7c(%eax)
    1a3b:	ff 70 78             	pushl  0x78(%eax)
    1a3e:	ff 70 74             	pushl  0x74(%eax)
    1a41:	ff 75 08             	pushl  0x8(%ebp)
    1a44:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a47:	ff d0                	call   *%eax
    1a49:	83 c4 10             	add    $0x10,%esp
    1a4c:	84 c0                	test   %al,%al
    1a4e:	75 0c                	jne    1a5c <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1a50:	8b 45 08             	mov    0x8(%ebp),%eax
    1a53:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a5a:	eb b2                	jmp    1a0e <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a5c:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a5d:	90                   	nop
    1a5e:	c9                   	leave  
    1a5f:	c3                   	ret    

00001a60 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a60:	55                   	push   %ebp
    1a61:	89 e5                	mov    %esp,%ebp
    1a63:	57                   	push   %edi
    1a64:	56                   	push   %esi
    1a65:	53                   	push   %ebx
    1a66:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a69:	a1 ac 2c 00 00       	mov    0x2cac,%eax
    1a6e:	85 c0                	test   %eax,%eax
    1a70:	0f 85 2c 02 00 00    	jne    1ca2 <APGridPaint+0x242>
    {
        iconReady = 1;
    1a76:	c7 05 ac 2c 00 00 01 	movl   $0x1,0x2cac
    1a7d:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a80:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a83:	83 ec 08             	sub    $0x8,%esp
    1a86:	68 c7 25 00 00       	push   $0x25c7
    1a8b:	50                   	push   %eax
    1a8c:	e8 16 f1 ff ff       	call   ba7 <APLoadBitmap>
    1a91:	83 c4 0c             	add    $0xc,%esp
    1a94:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a97:	a3 e0 30 00 00       	mov    %eax,0x30e0
    1a9c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a9f:	a3 e4 30 00 00       	mov    %eax,0x30e4
    1aa4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aa7:	a3 e8 30 00 00       	mov    %eax,0x30e8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1aac:	83 ec 04             	sub    $0x4,%esp
    1aaf:	ff 35 e8 30 00 00    	pushl  0x30e8
    1ab5:	ff 35 e4 30 00 00    	pushl  0x30e4
    1abb:	ff 35 e0 30 00 00    	pushl  0x30e0
    1ac1:	e8 1b f3 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1ac6:	83 c4 10             	add    $0x10,%esp
    1ac9:	a3 ec 30 00 00       	mov    %eax,0x30ec
        grid_river = APLoadBitmap ("grid_river.bmp");
    1ace:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ad1:	83 ec 08             	sub    $0x8,%esp
    1ad4:	68 d5 25 00 00       	push   $0x25d5
    1ad9:	50                   	push   %eax
    1ada:	e8 c8 f0 ff ff       	call   ba7 <APLoadBitmap>
    1adf:	83 c4 0c             	add    $0xc,%esp
    1ae2:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ae5:	a3 1c 31 00 00       	mov    %eax,0x311c
    1aea:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aed:	a3 20 31 00 00       	mov    %eax,0x3120
    1af2:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1af5:	a3 24 31 00 00       	mov    %eax,0x3124
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1afa:	83 ec 04             	sub    $0x4,%esp
    1afd:	ff 35 24 31 00 00    	pushl  0x3124
    1b03:	ff 35 20 31 00 00    	pushl  0x3120
    1b09:	ff 35 1c 31 00 00    	pushl  0x311c
    1b0f:	e8 cd f2 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1b14:	83 c4 10             	add    $0x10,%esp
    1b17:	a3 0c 31 00 00       	mov    %eax,0x310c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b1c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b1f:	83 ec 08             	sub    $0x8,%esp
    1b22:	68 e4 25 00 00       	push   $0x25e4
    1b27:	50                   	push   %eax
    1b28:	e8 7a f0 ff ff       	call   ba7 <APLoadBitmap>
    1b2d:	83 c4 0c             	add    $0xc,%esp
    1b30:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b33:	a3 10 31 00 00       	mov    %eax,0x3110
    1b38:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b3b:	a3 14 31 00 00       	mov    %eax,0x3114
    1b40:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b43:	a3 18 31 00 00       	mov    %eax,0x3118
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1b48:	83 ec 04             	sub    $0x4,%esp
    1b4b:	ff 35 18 31 00 00    	pushl  0x3118
    1b51:	ff 35 14 31 00 00    	pushl  0x3114
    1b57:	ff 35 10 31 00 00    	pushl  0x3110
    1b5d:	e8 7f f2 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1b62:	83 c4 10             	add    $0x10,%esp
    1b65:	a3 c0 30 00 00       	mov    %eax,0x30c0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b6a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b6d:	83 ec 08             	sub    $0x8,%esp
    1b70:	68 f3 25 00 00       	push   $0x25f3
    1b75:	50                   	push   %eax
    1b76:	e8 2c f0 ff ff       	call   ba7 <APLoadBitmap>
    1b7b:	83 c4 0c             	add    $0xc,%esp
    1b7e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b81:	a3 f4 30 00 00       	mov    %eax,0x30f4
    1b86:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b89:	a3 f8 30 00 00       	mov    %eax,0x30f8
    1b8e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b91:	a3 fc 30 00 00       	mov    %eax,0x30fc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b96:	83 ec 04             	sub    $0x4,%esp
    1b99:	ff 35 fc 30 00 00    	pushl  0x30fc
    1b9f:	ff 35 f8 30 00 00    	pushl  0x30f8
    1ba5:	ff 35 f4 30 00 00    	pushl  0x30f4
    1bab:	e8 31 f2 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1bb0:	83 c4 10             	add    $0x10,%esp
    1bb3:	a3 28 31 00 00       	mov    %eax,0x3128
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1bb8:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bbb:	83 ec 08             	sub    $0x8,%esp
    1bbe:	68 01 26 00 00       	push   $0x2601
    1bc3:	50                   	push   %eax
    1bc4:	e8 de ef ff ff       	call   ba7 <APLoadBitmap>
    1bc9:	83 c4 0c             	add    $0xc,%esp
    1bcc:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bcf:	a3 d0 30 00 00       	mov    %eax,0x30d0
    1bd4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bd7:	a3 d4 30 00 00       	mov    %eax,0x30d4
    1bdc:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bdf:	a3 d8 30 00 00       	mov    %eax,0x30d8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1be4:	83 ec 04             	sub    $0x4,%esp
    1be7:	ff 35 d8 30 00 00    	pushl  0x30d8
    1bed:	ff 35 d4 30 00 00    	pushl  0x30d4
    1bf3:	ff 35 d0 30 00 00    	pushl  0x30d0
    1bf9:	e8 e3 f1 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1bfe:	83 c4 10             	add    $0x10,%esp
    1c01:	a3 f0 30 00 00       	mov    %eax,0x30f0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c06:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c09:	83 ec 08             	sub    $0x8,%esp
    1c0c:	68 11 26 00 00       	push   $0x2611
    1c11:	50                   	push   %eax
    1c12:	e8 90 ef ff ff       	call   ba7 <APLoadBitmap>
    1c17:	83 c4 0c             	add    $0xc,%esp
    1c1a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c1d:	a3 c4 30 00 00       	mov    %eax,0x30c4
    1c22:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c25:	a3 c8 30 00 00       	mov    %eax,0x30c8
    1c2a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c2d:	a3 cc 30 00 00       	mov    %eax,0x30cc
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1c32:	83 ec 04             	sub    $0x4,%esp
    1c35:	ff 35 cc 30 00 00    	pushl  0x30cc
    1c3b:	ff 35 c8 30 00 00    	pushl  0x30c8
    1c41:	ff 35 c4 30 00 00    	pushl  0x30c4
    1c47:	e8 95 f1 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1c4c:	83 c4 10             	add    $0x10,%esp
    1c4f:	a3 dc 30 00 00       	mov    %eax,0x30dc
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c54:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c57:	83 ec 08             	sub    $0x8,%esp
    1c5a:	68 23 26 00 00       	push   $0x2623
    1c5f:	50                   	push   %eax
    1c60:	e8 42 ef ff ff       	call   ba7 <APLoadBitmap>
    1c65:	83 c4 0c             	add    $0xc,%esp
    1c68:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c6b:	a3 00 31 00 00       	mov    %eax,0x3100
    1c70:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c73:	a3 04 31 00 00       	mov    %eax,0x3104
    1c78:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c7b:	a3 08 31 00 00       	mov    %eax,0x3108
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c80:	83 ec 04             	sub    $0x4,%esp
    1c83:	ff 35 08 31 00 00    	pushl  0x3108
    1c89:	ff 35 04 31 00 00    	pushl  0x3104
    1c8f:	ff 35 00 31 00 00    	pushl  0x3100
    1c95:	e8 47 f1 ff ff       	call   de1 <APCreateCompatibleDCFromBitmap>
    1c9a:	83 c4 10             	add    $0x10,%esp
    1c9d:	a3 2c 31 00 00       	mov    %eax,0x312c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1ca2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca5:	8b 40 08             	mov    0x8(%eax),%eax
    1ca8:	85 c0                	test   %eax,%eax
    1caa:	75 17                	jne    1cc3 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1cac:	83 ec 08             	sub    $0x8,%esp
    1caf:	68 34 26 00 00       	push   $0x2634
    1cb4:	6a 01                	push   $0x1
    1cb6:	e8 66 ea ff ff       	call   721 <printf>
    1cbb:	83 c4 10             	add    $0x10,%esp
        return;
    1cbe:	e9 a0 04 00 00       	jmp    2163 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1cc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc6:	8b 40 10             	mov    0x10(%eax),%eax
    1cc9:	85 c0                	test   %eax,%eax
    1ccb:	7e 10                	jle    1cdd <APGridPaint+0x27d>
    1ccd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd0:	8b 50 14             	mov    0x14(%eax),%edx
    1cd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd6:	8b 40 10             	mov    0x10(%eax),%eax
    1cd9:	39 c2                	cmp    %eax,%edx
    1cdb:	7c 17                	jl     1cf4 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1cdd:	83 ec 08             	sub    $0x8,%esp
    1ce0:	68 5a 26 00 00       	push   $0x265a
    1ce5:	6a 01                	push   $0x1
    1ce7:	e8 35 ea ff ff       	call   721 <printf>
    1cec:	83 c4 10             	add    $0x10,%esp
        return;
    1cef:	e9 6f 04 00 00       	jmp    2163 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1cf4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf7:	8b 40 14             	mov    0x14(%eax),%eax
    1cfa:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1d00:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d03:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d06:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d09:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1d10:	e9 96 03 00 00       	jmp    20ab <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d15:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d1c:	e9 7c 03 00 00       	jmp    209d <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d24:	c1 e0 04             	shl    $0x4,%eax
    1d27:	89 c2                	mov    %eax,%edx
    1d29:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d2c:	01 c2                	add    %eax,%edx
    1d2e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d31:	01 d0                	add    %edx,%eax
    1d33:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d36:	8b 45 08             	mov    0x8(%ebp),%eax
    1d39:	8b 40 0c             	mov    0xc(%eax),%eax
    1d3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d3f:	c1 e2 02             	shl    $0x2,%edx
    1d42:	01 d0                	add    %edx,%eax
    1d44:	8b 00                	mov    (%eax),%eax
    1d46:	83 f8 07             	cmp    $0x7,%eax
    1d49:	0f 87 49 03 00 00    	ja     2098 <APGridPaint+0x638>
    1d4f:	8b 04 85 70 26 00 00 	mov    0x2670(,%eax,4),%eax
    1d56:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d58:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d5b:	6a 0c                	push   $0xc
    1d5d:	6a 0c                	push   $0xc
    1d5f:	6a 0c                	push   $0xc
    1d61:	50                   	push   %eax
    1d62:	e8 df f8 ff ff       	call   1646 <RGB>
    1d67:	83 c4 0c             	add    $0xc,%esp
    1d6a:	8b 1d ec 30 00 00    	mov    0x30ec,%ebx
    1d70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d73:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d76:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d79:	6b c0 32             	imul   $0x32,%eax,%eax
    1d7c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d82:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d85:	83 ec 0c             	sub    $0xc,%esp
    1d88:	83 ec 04             	sub    $0x4,%esp
    1d8b:	89 e0                	mov    %esp,%eax
    1d8d:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d91:	66 89 30             	mov    %si,(%eax)
    1d94:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d98:	88 50 02             	mov    %dl,0x2(%eax)
    1d9b:	6a 32                	push   $0x32
    1d9d:	6a 32                	push   $0x32
    1d9f:	6a 00                	push   $0x0
    1da1:	6a 00                	push   $0x0
    1da3:	53                   	push   %ebx
    1da4:	51                   	push   %ecx
    1da5:	ff 75 94             	pushl  -0x6c(%ebp)
    1da8:	57                   	push   %edi
    1da9:	e8 f4 f6 ff ff       	call   14a2 <APDcCopy>
    1dae:	83 c4 30             	add    $0x30,%esp
                    break;
    1db1:	e9 e3 02 00 00       	jmp    2099 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1db6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1db9:	6a 69                	push   $0x69
    1dbb:	6a 69                	push   $0x69
    1dbd:	6a 69                	push   $0x69
    1dbf:	50                   	push   %eax
    1dc0:	e8 81 f8 ff ff       	call   1646 <RGB>
    1dc5:	83 c4 0c             	add    $0xc,%esp
    1dc8:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1dcc:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1dd0:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dd4:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1dd7:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1dde:	8d 45 98             	lea    -0x68(%ebp),%eax
    1de1:	6a 69                	push   $0x69
    1de3:	6a 69                	push   $0x69
    1de5:	6a 69                	push   $0x69
    1de7:	50                   	push   %eax
    1de8:	e8 59 f8 ff ff       	call   1646 <RGB>
    1ded:	83 c4 0c             	add    $0xc,%esp
    1df0:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1df4:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1df8:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dfc:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1dff:	8b 45 08             	mov    0x8(%ebp),%eax
    1e02:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e05:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e08:	ff 75 b0             	pushl  -0x50(%ebp)
    1e0b:	ff 75 ac             	pushl  -0x54(%ebp)
    1e0e:	52                   	push   %edx
    1e0f:	50                   	push   %eax
    1e10:	e8 61 f0 ff ff       	call   e76 <APSetPen>
    1e15:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1e18:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1b:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e1e:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e21:	83 ec 04             	sub    $0x4,%esp
    1e24:	83 ec 04             	sub    $0x4,%esp
    1e27:	89 e0                	mov    %esp,%eax
    1e29:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1e2d:	66 89 08             	mov    %cx,(%eax)
    1e30:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1e34:	88 48 02             	mov    %cl,0x2(%eax)
    1e37:	53                   	push   %ebx
    1e38:	52                   	push   %edx
    1e39:	e8 71 f0 ff ff       	call   eaf <APSetBrush>
    1e3e:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e44:	6b d0 32             	imul   $0x32,%eax,%edx
    1e47:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e4a:	6b c0 32             	imul   $0x32,%eax,%eax
    1e4d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e50:	83 c1 3c             	add    $0x3c,%ecx
    1e53:	83 ec 0c             	sub    $0xc,%esp
    1e56:	6a 32                	push   $0x32
    1e58:	6a 32                	push   $0x32
    1e5a:	52                   	push   %edx
    1e5b:	50                   	push   %eax
    1e5c:	51                   	push   %ecx
    1e5d:	e8 35 f4 ff ff       	call   1297 <APDrawRect>
    1e62:	83 c4 20             	add    $0x20,%esp
                    break;
    1e65:	e9 2f 02 00 00       	jmp    2099 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e6a:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e6d:	6a 0c                	push   $0xc
    1e6f:	6a 0c                	push   $0xc
    1e71:	6a 0c                	push   $0xc
    1e73:	50                   	push   %eax
    1e74:	e8 cd f7 ff ff       	call   1646 <RGB>
    1e79:	83 c4 0c             	add    $0xc,%esp
    1e7c:	8b 1d 2c 31 00 00    	mov    0x312c,%ebx
    1e82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e85:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e88:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e8b:	6b c0 32             	imul   $0x32,%eax,%eax
    1e8e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e91:	8b 45 08             	mov    0x8(%ebp),%eax
    1e94:	8d 78 3c             	lea    0x3c(%eax),%edi
    1e97:	83 ec 0c             	sub    $0xc,%esp
    1e9a:	83 ec 04             	sub    $0x4,%esp
    1e9d:	89 e0                	mov    %esp,%eax
    1e9f:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1ea3:	66 89 30             	mov    %si,(%eax)
    1ea6:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1eaa:	88 50 02             	mov    %dl,0x2(%eax)
    1ead:	6a 32                	push   $0x32
    1eaf:	6a 32                	push   $0x32
    1eb1:	6a 00                	push   $0x0
    1eb3:	6a 00                	push   $0x0
    1eb5:	53                   	push   %ebx
    1eb6:	51                   	push   %ecx
    1eb7:	ff 75 94             	pushl  -0x6c(%ebp)
    1eba:	57                   	push   %edi
    1ebb:	e8 e2 f5 ff ff       	call   14a2 <APDcCopy>
    1ec0:	83 c4 30             	add    $0x30,%esp
                    break;
    1ec3:	e9 d1 01 00 00       	jmp    2099 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ec8:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ecb:	6a 0c                	push   $0xc
    1ecd:	6a 0c                	push   $0xc
    1ecf:	6a 0c                	push   $0xc
    1ed1:	50                   	push   %eax
    1ed2:	e8 6f f7 ff ff       	call   1646 <RGB>
    1ed7:	83 c4 0c             	add    $0xc,%esp
    1eda:	8b 1d 0c 31 00 00    	mov    0x310c,%ebx
    1ee0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ee3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ee6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ee9:	6b c0 32             	imul   $0x32,%eax,%eax
    1eec:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eef:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef2:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ef5:	83 ec 0c             	sub    $0xc,%esp
    1ef8:	83 ec 04             	sub    $0x4,%esp
    1efb:	89 e0                	mov    %esp,%eax
    1efd:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f01:	66 89 30             	mov    %si,(%eax)
    1f04:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f08:	88 50 02             	mov    %dl,0x2(%eax)
    1f0b:	6a 32                	push   $0x32
    1f0d:	6a 32                	push   $0x32
    1f0f:	6a 00                	push   $0x0
    1f11:	6a 00                	push   $0x0
    1f13:	53                   	push   %ebx
    1f14:	51                   	push   %ecx
    1f15:	ff 75 94             	pushl  -0x6c(%ebp)
    1f18:	57                   	push   %edi
    1f19:	e8 84 f5 ff ff       	call   14a2 <APDcCopy>
    1f1e:	83 c4 30             	add    $0x30,%esp
                    break;
    1f21:	e9 73 01 00 00       	jmp    2099 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f26:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f29:	6a 0c                	push   $0xc
    1f2b:	6a 0c                	push   $0xc
    1f2d:	6a 0c                	push   $0xc
    1f2f:	50                   	push   %eax
    1f30:	e8 11 f7 ff ff       	call   1646 <RGB>
    1f35:	83 c4 0c             	add    $0xc,%esp
    1f38:	8b 1d f0 30 00 00    	mov    0x30f0,%ebx
    1f3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f41:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f44:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f47:	6b c0 32             	imul   $0x32,%eax,%eax
    1f4a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f50:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f53:	83 ec 0c             	sub    $0xc,%esp
    1f56:	83 ec 04             	sub    $0x4,%esp
    1f59:	89 e0                	mov    %esp,%eax
    1f5b:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f5f:	66 89 30             	mov    %si,(%eax)
    1f62:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f66:	88 50 02             	mov    %dl,0x2(%eax)
    1f69:	6a 32                	push   $0x32
    1f6b:	6a 32                	push   $0x32
    1f6d:	6a 00                	push   $0x0
    1f6f:	6a 00                	push   $0x0
    1f71:	53                   	push   %ebx
    1f72:	51                   	push   %ecx
    1f73:	ff 75 94             	pushl  -0x6c(%ebp)
    1f76:	57                   	push   %edi
    1f77:	e8 26 f5 ff ff       	call   14a2 <APDcCopy>
    1f7c:	83 c4 30             	add    $0x30,%esp
                    break;
    1f7f:	e9 15 01 00 00       	jmp    2099 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f84:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f87:	6a 0c                	push   $0xc
    1f89:	6a 0c                	push   $0xc
    1f8b:	6a 0c                	push   $0xc
    1f8d:	50                   	push   %eax
    1f8e:	e8 b3 f6 ff ff       	call   1646 <RGB>
    1f93:	83 c4 0c             	add    $0xc,%esp
    1f96:	8b 1d 28 31 00 00    	mov    0x3128,%ebx
    1f9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f9f:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fa2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fa5:	6b c0 32             	imul   $0x32,%eax,%eax
    1fa8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fab:	8b 45 08             	mov    0x8(%ebp),%eax
    1fae:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fb1:	83 ec 0c             	sub    $0xc,%esp
    1fb4:	83 ec 04             	sub    $0x4,%esp
    1fb7:	89 e0                	mov    %esp,%eax
    1fb9:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1fbd:	66 89 30             	mov    %si,(%eax)
    1fc0:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1fc4:	88 50 02             	mov    %dl,0x2(%eax)
    1fc7:	6a 32                	push   $0x32
    1fc9:	6a 32                	push   $0x32
    1fcb:	6a 00                	push   $0x0
    1fcd:	6a 00                	push   $0x0
    1fcf:	53                   	push   %ebx
    1fd0:	51                   	push   %ecx
    1fd1:	ff 75 94             	pushl  -0x6c(%ebp)
    1fd4:	57                   	push   %edi
    1fd5:	e8 c8 f4 ff ff       	call   14a2 <APDcCopy>
    1fda:	83 c4 30             	add    $0x30,%esp
                    break;
    1fdd:	e9 b7 00 00 00       	jmp    2099 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fe2:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1fe5:	6a 0c                	push   $0xc
    1fe7:	6a 0c                	push   $0xc
    1fe9:	6a 0c                	push   $0xc
    1feb:	50                   	push   %eax
    1fec:	e8 55 f6 ff ff       	call   1646 <RGB>
    1ff1:	83 c4 0c             	add    $0xc,%esp
    1ff4:	8b 1d c0 30 00 00    	mov    0x30c0,%ebx
    1ffa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ffd:	6b c8 32             	imul   $0x32,%eax,%ecx
    2000:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2003:	6b c0 32             	imul   $0x32,%eax,%eax
    2006:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2009:	8b 45 08             	mov    0x8(%ebp),%eax
    200c:	8d 78 3c             	lea    0x3c(%eax),%edi
    200f:	83 ec 0c             	sub    $0xc,%esp
    2012:	83 ec 04             	sub    $0x4,%esp
    2015:	89 e0                	mov    %esp,%eax
    2017:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    201b:	66 89 30             	mov    %si,(%eax)
    201e:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2022:	88 50 02             	mov    %dl,0x2(%eax)
    2025:	6a 32                	push   $0x32
    2027:	6a 32                	push   $0x32
    2029:	6a 00                	push   $0x0
    202b:	6a 00                	push   $0x0
    202d:	53                   	push   %ebx
    202e:	51                   	push   %ecx
    202f:	ff 75 94             	pushl  -0x6c(%ebp)
    2032:	57                   	push   %edi
    2033:	e8 6a f4 ff ff       	call   14a2 <APDcCopy>
    2038:	83 c4 30             	add    $0x30,%esp
                    break;
    203b:	eb 5c                	jmp    2099 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    203d:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2040:	6a 0c                	push   $0xc
    2042:	6a 0c                	push   $0xc
    2044:	6a 0c                	push   $0xc
    2046:	50                   	push   %eax
    2047:	e8 fa f5 ff ff       	call   1646 <RGB>
    204c:	83 c4 0c             	add    $0xc,%esp
    204f:	8b 1d dc 30 00 00    	mov    0x30dc,%ebx
    2055:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2058:	6b c8 32             	imul   $0x32,%eax,%ecx
    205b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    205e:	6b c0 32             	imul   $0x32,%eax,%eax
    2061:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2064:	8b 45 08             	mov    0x8(%ebp),%eax
    2067:	8d 78 3c             	lea    0x3c(%eax),%edi
    206a:	83 ec 0c             	sub    $0xc,%esp
    206d:	83 ec 04             	sub    $0x4,%esp
    2070:	89 e0                	mov    %esp,%eax
    2072:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2076:	66 89 30             	mov    %si,(%eax)
    2079:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    207d:	88 50 02             	mov    %dl,0x2(%eax)
    2080:	6a 32                	push   $0x32
    2082:	6a 32                	push   $0x32
    2084:	6a 00                	push   $0x0
    2086:	6a 00                	push   $0x0
    2088:	53                   	push   %ebx
    2089:	51                   	push   %ecx
    208a:	ff 75 94             	pushl  -0x6c(%ebp)
    208d:	57                   	push   %edi
    208e:	e8 0f f4 ff ff       	call   14a2 <APDcCopy>
    2093:	83 c4 30             	add    $0x30,%esp
                    break;
    2096:	eb 01                	jmp    2099 <APGridPaint+0x639>
                default: break;
    2098:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2099:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    209d:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    20a1:	0f 8e 7a fc ff ff    	jle    1d21 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    20a7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    20ab:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    20af:	0f 8e 60 fc ff ff    	jle    1d15 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    20b5:	8d 45 98             	lea    -0x68(%ebp),%eax
    20b8:	68 cd 00 00 00       	push   $0xcd
    20bd:	6a 74                	push   $0x74
    20bf:	6a 18                	push   $0x18
    20c1:	50                   	push   %eax
    20c2:	e8 7f f5 ff ff       	call   1646 <RGB>
    20c7:	83 c4 0c             	add    $0xc,%esp
    20ca:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    20ce:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    20d2:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    20d6:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    20d9:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    20e0:	8d 45 98             	lea    -0x68(%ebp),%eax
    20e3:	68 cd 00 00 00       	push   $0xcd
    20e8:	6a 74                	push   $0x74
    20ea:	6a 18                	push   $0x18
    20ec:	50                   	push   %eax
    20ed:	e8 54 f5 ff ff       	call   1646 <RGB>
    20f2:	83 c4 0c             	add    $0xc,%esp
    20f5:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    20f9:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    20fd:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2101:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2104:	8b 45 08             	mov    0x8(%ebp),%eax
    2107:	8d 50 58             	lea    0x58(%eax),%edx
    210a:	8d 45 98             	lea    -0x68(%ebp),%eax
    210d:	ff 75 bc             	pushl  -0x44(%ebp)
    2110:	ff 75 b8             	pushl  -0x48(%ebp)
    2113:	52                   	push   %edx
    2114:	50                   	push   %eax
    2115:	e8 5c ed ff ff       	call   e76 <APSetPen>
    211a:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    211d:	8b 45 08             	mov    0x8(%ebp),%eax
    2120:	8d 58 58             	lea    0x58(%eax),%ebx
    2123:	8d 55 98             	lea    -0x68(%ebp),%edx
    2126:	83 ec 04             	sub    $0x4,%esp
    2129:	83 ec 04             	sub    $0x4,%esp
    212c:	89 e0                	mov    %esp,%eax
    212e:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2132:	66 89 08             	mov    %cx,(%eax)
    2135:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2139:	88 48 02             	mov    %cl,0x2(%eax)
    213c:	53                   	push   %ebx
    213d:	52                   	push   %edx
    213e:	e8 6c ed ff ff       	call   eaf <APSetBrush>
    2143:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2146:	8b 45 08             	mov    0x8(%ebp),%eax
    2149:	83 c0 58             	add    $0x58,%eax
    214c:	83 ec 0c             	sub    $0xc,%esp
    214f:	6a 32                	push   $0x32
    2151:	68 20 03 00 00       	push   $0x320
    2156:	6a 00                	push   $0x0
    2158:	6a 00                	push   $0x0
    215a:	50                   	push   %eax
    215b:	e8 37 f1 ff ff       	call   1297 <APDrawRect>
    2160:	83 c4 20             	add    $0x20,%esp
}
    2163:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2166:	5b                   	pop    %ebx
    2167:	5e                   	pop    %esi
    2168:	5f                   	pop    %edi
    2169:	5d                   	pop    %ebp
    216a:	c3                   	ret    

0000216b <random>:
//

#include "APLib.h"

int random(int seed)
{
    216b:	55                   	push   %ebp
    216c:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    216e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2172:	7e 08                	jle    217c <random+0x11>
{
rand_num = seed;
    2174:	8b 45 08             	mov    0x8(%ebp),%eax
    2177:	a3 84 2c 00 00       	mov    %eax,0x2c84
}
rand_num *= 3;
    217c:	8b 15 84 2c 00 00    	mov    0x2c84,%edx
    2182:	89 d0                	mov    %edx,%eax
    2184:	01 c0                	add    %eax,%eax
    2186:	01 d0                	add    %edx,%eax
    2188:	a3 84 2c 00 00       	mov    %eax,0x2c84
if (rand_num < 0)
    218d:	a1 84 2c 00 00       	mov    0x2c84,%eax
    2192:	85 c0                	test   %eax,%eax
    2194:	79 0c                	jns    21a2 <random+0x37>
{
rand_num *= (-1);
    2196:	a1 84 2c 00 00       	mov    0x2c84,%eax
    219b:	f7 d8                	neg    %eax
    219d:	a3 84 2c 00 00       	mov    %eax,0x2c84
}
return rand_num % 997;
    21a2:	8b 0d 84 2c 00 00    	mov    0x2c84,%ecx
    21a8:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    21ad:	89 c8                	mov    %ecx,%eax
    21af:	f7 ea                	imul   %edx
    21b1:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    21b4:	c1 f8 09             	sar    $0x9,%eax
    21b7:	89 c2                	mov    %eax,%edx
    21b9:	89 c8                	mov    %ecx,%eax
    21bb:	c1 f8 1f             	sar    $0x1f,%eax
    21be:	29 c2                	sub    %eax,%edx
    21c0:	89 d0                	mov    %edx,%eax
    21c2:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    21c8:	29 c1                	sub    %eax,%ecx
    21ca:	89 c8                	mov    %ecx,%eax
}
    21cc:	5d                   	pop    %ebp
    21cd:	c3                   	ret    

000021ce <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    21ce:	55                   	push   %ebp
    21cf:	89 e5                	mov    %esp,%ebp
    21d1:	53                   	push   %ebx
    21d2:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    21d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    21dc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    21e0:	74 17                	je     21f9 <sprintint+0x2b>
    21e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    21e6:	79 11                	jns    21f9 <sprintint+0x2b>
        neg = 1;
    21e8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    21ef:	8b 45 10             	mov    0x10(%ebp),%eax
    21f2:	f7 d8                	neg    %eax
    21f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    21f7:	eb 06                	jmp    21ff <sprintint+0x31>
    } else {
        x = xx;
    21f9:	8b 45 10             	mov    0x10(%ebp),%eax
    21fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    21ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2206:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2209:	8d 41 01             	lea    0x1(%ecx),%eax
    220c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    220f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2212:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2215:	ba 00 00 00 00       	mov    $0x0,%edx
    221a:	f7 f3                	div    %ebx
    221c:	89 d0                	mov    %edx,%eax
    221e:	0f b6 80 88 2c 00 00 	movzbl 0x2c88(%eax),%eax
    2225:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2229:	8b 5d 14             	mov    0x14(%ebp),%ebx
    222c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    222f:	ba 00 00 00 00       	mov    $0x0,%edx
    2234:	f7 f3                	div    %ebx
    2236:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2239:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    223d:	75 c7                	jne    2206 <sprintint+0x38>
    if(neg)
    223f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2243:	74 0e                	je     2253 <sprintint+0x85>
        buf[i++] = '-';
    2245:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2248:	8d 50 01             	lea    0x1(%eax),%edx
    224b:	89 55 f8             	mov    %edx,-0x8(%ebp)
    224e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2253:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2256:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2259:	eb 1b                	jmp    2276 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    225b:	8b 45 0c             	mov    0xc(%ebp),%eax
    225e:	8b 00                	mov    (%eax),%eax
    2260:	8d 48 01             	lea    0x1(%eax),%ecx
    2263:	8b 55 0c             	mov    0xc(%ebp),%edx
    2266:	89 0a                	mov    %ecx,(%edx)
    2268:	89 c2                	mov    %eax,%edx
    226a:	8b 45 08             	mov    0x8(%ebp),%eax
    226d:	01 d0                	add    %edx,%eax
    226f:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2272:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2276:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    227a:	7f df                	jg     225b <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    227c:	eb 21                	jmp    229f <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    227e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2281:	8b 00                	mov    (%eax),%eax
    2283:	8d 48 01             	lea    0x1(%eax),%ecx
    2286:	8b 55 0c             	mov    0xc(%ebp),%edx
    2289:	89 0a                	mov    %ecx,(%edx)
    228b:	89 c2                	mov    %eax,%edx
    228d:	8b 45 08             	mov    0x8(%ebp),%eax
    2290:	01 c2                	add    %eax,%edx
    2292:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2295:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2298:	01 c8                	add    %ecx,%eax
    229a:	0f b6 00             	movzbl (%eax),%eax
    229d:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    229f:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    22a3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    22a7:	79 d5                	jns    227e <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    22a9:	90                   	nop
    22aa:	83 c4 20             	add    $0x20,%esp
    22ad:	5b                   	pop    %ebx
    22ae:	5d                   	pop    %ebp
    22af:	c3                   	ret    

000022b0 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    22b0:	55                   	push   %ebp
    22b1:	89 e5                	mov    %esp,%ebp
    22b3:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    22b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    22bd:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    22c4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    22cb:	8d 45 0c             	lea    0xc(%ebp),%eax
    22ce:	83 c0 04             	add    $0x4,%eax
    22d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    22d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    22db:	e9 d9 01 00 00       	jmp    24b9 <sprintf+0x209>
        c = fmt[i] & 0xff;
    22e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    22e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22e6:	01 d0                	add    %edx,%eax
    22e8:	0f b6 00             	movzbl (%eax),%eax
    22eb:	0f be c0             	movsbl %al,%eax
    22ee:	25 ff 00 00 00       	and    $0xff,%eax
    22f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    22f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    22fa:	75 2c                	jne    2328 <sprintf+0x78>
            if(c == '%'){
    22fc:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2300:	75 0c                	jne    230e <sprintf+0x5e>
                state = '%';
    2302:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2309:	e9 a7 01 00 00       	jmp    24b5 <sprintf+0x205>
            } else {
                dst[j++] = c;
    230e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2311:	8d 50 01             	lea    0x1(%eax),%edx
    2314:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2317:	89 c2                	mov    %eax,%edx
    2319:	8b 45 08             	mov    0x8(%ebp),%eax
    231c:	01 d0                	add    %edx,%eax
    231e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2321:	88 10                	mov    %dl,(%eax)
    2323:	e9 8d 01 00 00       	jmp    24b5 <sprintf+0x205>
            }
        } else if(state == '%'){
    2328:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    232c:	0f 85 83 01 00 00    	jne    24b5 <sprintf+0x205>
            if(c == 'd'){
    2332:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2336:	75 4c                	jne    2384 <sprintf+0xd4>
                buf[bi] = '\0';
    2338:	8d 55 ce             	lea    -0x32(%ebp),%edx
    233b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    233e:	01 d0                	add    %edx,%eax
    2340:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2343:	83 ec 0c             	sub    $0xc,%esp
    2346:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2349:	50                   	push   %eax
    234a:	e8 a1 e1 ff ff       	call   4f0 <atoi>
    234f:	83 c4 10             	add    $0x10,%esp
    2352:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2355:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    235c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    235f:	8b 00                	mov    (%eax),%eax
    2361:	83 ec 08             	sub    $0x8,%esp
    2364:	ff 75 d8             	pushl  -0x28(%ebp)
    2367:	6a 01                	push   $0x1
    2369:	6a 0a                	push   $0xa
    236b:	50                   	push   %eax
    236c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    236f:	50                   	push   %eax
    2370:	ff 75 08             	pushl  0x8(%ebp)
    2373:	e8 56 fe ff ff       	call   21ce <sprintint>
    2378:	83 c4 20             	add    $0x20,%esp
                ap++;
    237b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    237f:	e9 2a 01 00 00       	jmp    24ae <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2384:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2388:	74 06                	je     2390 <sprintf+0xe0>
    238a:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    238e:	75 4c                	jne    23dc <sprintf+0x12c>
                buf[bi] = '\0';
    2390:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2393:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2396:	01 d0                	add    %edx,%eax
    2398:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    239b:	83 ec 0c             	sub    $0xc,%esp
    239e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23a1:	50                   	push   %eax
    23a2:	e8 49 e1 ff ff       	call   4f0 <atoi>
    23a7:	83 c4 10             	add    $0x10,%esp
    23aa:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    23ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    23b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23b7:	8b 00                	mov    (%eax),%eax
    23b9:	83 ec 08             	sub    $0x8,%esp
    23bc:	ff 75 dc             	pushl  -0x24(%ebp)
    23bf:	6a 00                	push   $0x0
    23c1:	6a 10                	push   $0x10
    23c3:	50                   	push   %eax
    23c4:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23c7:	50                   	push   %eax
    23c8:	ff 75 08             	pushl  0x8(%ebp)
    23cb:	e8 fe fd ff ff       	call   21ce <sprintint>
    23d0:	83 c4 20             	add    $0x20,%esp
                ap++;
    23d3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    23d7:	e9 d2 00 00 00       	jmp    24ae <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    23dc:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    23e0:	75 46                	jne    2428 <sprintf+0x178>
                s = (char*)*ap;
    23e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23e5:	8b 00                	mov    (%eax),%eax
    23e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    23ea:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    23ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23f2:	75 25                	jne    2419 <sprintf+0x169>
                    s = "(null)";
    23f4:	c7 45 f4 90 26 00 00 	movl   $0x2690,-0xc(%ebp)
                while(*s != 0){
    23fb:	eb 1c                	jmp    2419 <sprintf+0x169>
                    dst[j++] = *s;
    23fd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2400:	8d 50 01             	lea    0x1(%eax),%edx
    2403:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2406:	89 c2                	mov    %eax,%edx
    2408:	8b 45 08             	mov    0x8(%ebp),%eax
    240b:	01 c2                	add    %eax,%edx
    240d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2410:	0f b6 00             	movzbl (%eax),%eax
    2413:	88 02                	mov    %al,(%edx)
                    s++;
    2415:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2419:	8b 45 f4             	mov    -0xc(%ebp),%eax
    241c:	0f b6 00             	movzbl (%eax),%eax
    241f:	84 c0                	test   %al,%al
    2421:	75 da                	jne    23fd <sprintf+0x14d>
    2423:	e9 86 00 00 00       	jmp    24ae <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2428:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    242c:	75 1d                	jne    244b <sprintf+0x19b>
                dst[j++] = *ap;
    242e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2431:	8d 50 01             	lea    0x1(%eax),%edx
    2434:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2437:	89 c2                	mov    %eax,%edx
    2439:	8b 45 08             	mov    0x8(%ebp),%eax
    243c:	01 c2                	add    %eax,%edx
    243e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2441:	8b 00                	mov    (%eax),%eax
    2443:	88 02                	mov    %al,(%edx)
                ap++;
    2445:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2449:	eb 63                	jmp    24ae <sprintf+0x1fe>
            } else if(c == '%'){
    244b:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    244f:	75 17                	jne    2468 <sprintf+0x1b8>
                dst[j++] = c;
    2451:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2454:	8d 50 01             	lea    0x1(%eax),%edx
    2457:	89 55 c8             	mov    %edx,-0x38(%ebp)
    245a:	89 c2                	mov    %eax,%edx
    245c:	8b 45 08             	mov    0x8(%ebp),%eax
    245f:	01 d0                	add    %edx,%eax
    2461:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2464:	88 10                	mov    %dl,(%eax)
    2466:	eb 46                	jmp    24ae <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2468:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    246c:	7e 18                	jle    2486 <sprintf+0x1d6>
    246e:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2472:	7f 12                	jg     2486 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2474:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2477:	8d 50 01             	lea    0x1(%eax),%edx
    247a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    247d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2480:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2484:	eb 2f                	jmp    24b5 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2486:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2489:	8d 50 01             	lea    0x1(%eax),%edx
    248c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    248f:	89 c2                	mov    %eax,%edx
    2491:	8b 45 08             	mov    0x8(%ebp),%eax
    2494:	01 d0                	add    %edx,%eax
    2496:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2499:	8b 45 c8             	mov    -0x38(%ebp),%eax
    249c:	8d 50 01             	lea    0x1(%eax),%edx
    249f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24a2:	89 c2                	mov    %eax,%edx
    24a4:	8b 45 08             	mov    0x8(%ebp),%eax
    24a7:	01 d0                	add    %edx,%eax
    24a9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24ac:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    24ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    24b5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    24b9:	8b 55 0c             	mov    0xc(%ebp),%edx
    24bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24bf:	01 d0                	add    %edx,%eax
    24c1:	0f b6 00             	movzbl (%eax),%eax
    24c4:	84 c0                	test   %al,%al
    24c6:	0f 85 14 fe ff ff    	jne    22e0 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    24cc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24cf:	8d 50 01             	lea    0x1(%eax),%edx
    24d2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24d5:	89 c2                	mov    %eax,%edx
    24d7:	8b 45 08             	mov    0x8(%ebp),%eax
    24da:	01 d0                	add    %edx,%eax
    24dc:	c6 00 00             	movb   $0x0,(%eax)
}
    24df:	90                   	nop
    24e0:	c9                   	leave  
    24e1:	c3                   	ret    
