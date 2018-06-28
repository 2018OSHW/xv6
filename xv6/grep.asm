
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
      18:	c7 45 f0 e0 28 00 00 	movl   $0x28e0,-0x10(%ebp)
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
      84:	81 7d f0 e0 28 00 00 	cmpl   $0x28e0,-0x10(%ebp)
      8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
      8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	ba e0 28 00 00       	mov    $0x28e0,%edx
      a2:	29 d0                	sub    %edx,%eax
      a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	ff 75 f4             	pushl  -0xc(%ebp)
      ad:	ff 75 f0             	pushl  -0x10(%ebp)
      b0:	68 e0 28 00 00       	push   $0x28e0
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
      ce:	05 e0 28 00 00       	add    $0x28e0,%eax
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
     10f:	68 64 21 00 00       	push   $0x2164
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
     18c:	68 84 21 00 00       	push   $0x2184
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
     6bd:	0f b6 80 8c 28 00 00 	movzbl 0x288c(%eax),%eax
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
     7fb:	c7 45 f4 9a 21 00 00 	movl   $0x219a,-0xc(%ebp)
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
     8c1:	a1 c8 28 00 00       	mov    0x28c8,%eax
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
     98c:	a3 c8 28 00 00       	mov    %eax,0x28c8
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
     9ed:	a1 c8 28 00 00       	mov    0x28c8,%eax
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
     a09:	a1 c8 28 00 00       	mov    0x28c8,%eax
     a0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a11:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a15:	75 23                	jne    a3a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a17:	c7 45 f0 c0 28 00 00 	movl   $0x28c0,-0x10(%ebp)
     a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a21:	a3 c8 28 00 00       	mov    %eax,0x28c8
     a26:	a1 c8 28 00 00       	mov    0x28c8,%eax
     a2b:	a3 c0 28 00 00       	mov    %eax,0x28c0
    base.s.size = 0;
     a30:	c7 05 c4 28 00 00 00 	movl   $0x0,0x28c4
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
     a8d:	a3 c8 28 00 00       	mov    %eax,0x28c8
      return (void*)(p + 1);
     a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a95:	83 c0 08             	add    $0x8,%eax
     a98:	eb 3b                	jmp    ad5 <malloc+0xe1>
    }
    if(p == freep)
     a9a:	a1 c8 28 00 00       	mov    0x28c8,%eax
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
     baa:	56                   	push   %esi
     bab:	53                   	push   %ebx
     bac:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     baf:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bb6:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bb9:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bbc:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bc3:	83 ec 08             	sub    $0x8,%esp
     bc6:	6a 00                	push   $0x0
     bc8:	ff 75 0c             	pushl  0xc(%ebp)
     bcb:	e8 f2 f9 ff ff       	call   5c2 <open>
     bd0:	83 c4 10             	add    $0x10,%esp
     bd3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bd6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bda:	79 2e                	jns    c0a <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     bdc:	83 ec 04             	sub    $0x4,%esp
     bdf:	ff 75 0c             	pushl  0xc(%ebp)
     be2:	68 a4 21 00 00       	push   $0x21a4
     be7:	6a 01                	push   $0x1
     be9:	e8 33 fb ff ff       	call   721 <printf>
     bee:	83 c4 10             	add    $0x10,%esp
        return bmp;
     bf1:	8b 45 08             	mov    0x8(%ebp),%eax
     bf4:	8b 55 c8             	mov    -0x38(%ebp),%edx
     bf7:	89 10                	mov    %edx,(%eax)
     bf9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     bfc:	89 50 04             	mov    %edx,0x4(%eax)
     bff:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c02:	89 50 08             	mov    %edx,0x8(%eax)
     c05:	e9 1b 02 00 00       	jmp    e25 <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c0a:	83 ec 04             	sub    $0x4,%esp
     c0d:	6a 10                	push   $0x10
     c0f:	8d 45 b8             	lea    -0x48(%ebp),%eax
     c12:	50                   	push   %eax
     c13:	ff 75 ec             	pushl  -0x14(%ebp)
     c16:	e8 7f f9 ff ff       	call   59a <read>
     c1b:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     c1e:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     c22:	0f b7 f0             	movzwl %ax,%esi
     c25:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     c29:	0f b7 d8             	movzwl %ax,%ebx
     c2c:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     c2f:	8b 55 bc             	mov    -0x44(%ebp),%edx
     c32:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     c36:	0f b7 c0             	movzwl %ax,%eax
     c39:	83 ec 04             	sub    $0x4,%esp
     c3c:	56                   	push   %esi
     c3d:	53                   	push   %ebx
     c3e:	51                   	push   %ecx
     c3f:	52                   	push   %edx
     c40:	50                   	push   %eax
     c41:	68 b4 21 00 00       	push   $0x21b4
     c46:	6a 01                	push   $0x1
     c48:	e8 d4 fa ff ff       	call   721 <printf>
     c4d:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c50:	83 ec 04             	sub    $0x4,%esp
     c53:	6a 28                	push   $0x28
     c55:	8d 45 90             	lea    -0x70(%ebp),%eax
     c58:	50                   	push   %eax
     c59:	ff 75 ec             	pushl  -0x14(%ebp)
     c5c:	e8 39 f9 ff ff       	call   59a <read>
     c61:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c64:	8b 45 94             	mov    -0x6c(%ebp),%eax
     c67:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c6a:	8b 45 98             	mov    -0x68(%ebp),%eax
     c6d:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     c70:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c73:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c76:	52                   	push   %edx
     c77:	50                   	push   %eax
     c78:	68 c4 21 00 00       	push   $0x21c4
     c7d:	6a 01                	push   $0x1
     c7f:	e8 9d fa ff ff       	call   721 <printf>
     c84:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c87:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c8a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c8d:	0f af d0             	imul   %eax,%edx
     c90:	89 d0                	mov    %edx,%eax
     c92:	01 c0                	add    %eax,%eax
     c94:	01 d0                	add    %edx,%eax
     c96:	83 ec 0c             	sub    $0xc,%esp
     c99:	50                   	push   %eax
     c9a:	e8 55 fd ff ff       	call   9f4 <malloc>
     c9f:	83 c4 10             	add    $0x10,%esp
     ca2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     ca5:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     ca9:	0f b7 c0             	movzwl %ax,%eax
     cac:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     caf:	8b 55 c8             	mov    -0x38(%ebp),%edx
     cb2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cb5:	0f af c2             	imul   %edx,%eax
     cb8:	83 c0 1f             	add    $0x1f,%eax
     cbb:	c1 e8 05             	shr    $0x5,%eax
     cbe:	c1 e0 02             	shl    $0x2,%eax
     cc1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     cc4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cca:	0f af c2             	imul   %edx,%eax
     ccd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     cd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cd3:	83 ec 0c             	sub    $0xc,%esp
     cd6:	50                   	push   %eax
     cd7:	e8 18 fd ff ff       	call   9f4 <malloc>
     cdc:	83 c4 10             	add    $0x10,%esp
     cdf:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ce2:	83 ec 04             	sub    $0x4,%esp
     ce5:	ff 75 e0             	pushl  -0x20(%ebp)
     ce8:	ff 75 dc             	pushl  -0x24(%ebp)
     ceb:	ff 75 ec             	pushl  -0x14(%ebp)
     cee:	e8 a7 f8 ff ff       	call   59a <read>
     cf3:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     cf6:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     cfa:	66 c1 e8 03          	shr    $0x3,%ax
     cfe:	0f b7 c0             	movzwl %ax,%eax
     d01:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     d04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d0b:	e9 e5 00 00 00       	jmp    df5 <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     d10:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d16:	29 c2                	sub    %eax,%edx
     d18:	89 d0                	mov    %edx,%eax
     d1a:	8d 50 ff             	lea    -0x1(%eax),%edx
     d1d:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d20:	0f af c2             	imul   %edx,%eax
     d23:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d26:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d2d:	e9 b1 00 00 00       	jmp    de3 <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d32:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d35:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d38:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d3b:	01 c8                	add    %ecx,%eax
     d3d:	89 c1                	mov    %eax,%ecx
     d3f:	89 c8                	mov    %ecx,%eax
     d41:	01 c0                	add    %eax,%eax
     d43:	01 c8                	add    %ecx,%eax
     d45:	01 c2                	add    %eax,%edx
     d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d4e:	89 c1                	mov    %eax,%ecx
     d50:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d53:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d57:	01 c1                	add    %eax,%ecx
     d59:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d5c:	01 c8                	add    %ecx,%eax
     d5e:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d61:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d64:	01 c8                	add    %ecx,%eax
     d66:	0f b6 00             	movzbl (%eax),%eax
     d69:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d6c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d6f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d72:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d75:	01 c8                	add    %ecx,%eax
     d77:	89 c1                	mov    %eax,%ecx
     d79:	89 c8                	mov    %ecx,%eax
     d7b:	01 c0                	add    %eax,%eax
     d7d:	01 c8                	add    %ecx,%eax
     d7f:	01 c2                	add    %eax,%edx
     d81:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d84:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d88:	89 c1                	mov    %eax,%ecx
     d8a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d8d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d91:	01 c1                	add    %eax,%ecx
     d93:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d96:	01 c8                	add    %ecx,%eax
     d98:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d9b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d9e:	01 c8                	add    %ecx,%eax
     da0:	0f b6 00             	movzbl (%eax),%eax
     da3:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     da6:	8b 55 d0             	mov    -0x30(%ebp),%edx
     da9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     dac:	8b 45 f0             	mov    -0x10(%ebp),%eax
     daf:	01 c8                	add    %ecx,%eax
     db1:	89 c1                	mov    %eax,%ecx
     db3:	89 c8                	mov    %ecx,%eax
     db5:	01 c0                	add    %eax,%eax
     db7:	01 c8                	add    %ecx,%eax
     db9:	01 c2                	add    %eax,%edx
     dbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dbe:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     dc2:	89 c1                	mov    %eax,%ecx
     dc4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dc7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     dcb:	01 c1                	add    %eax,%ecx
     dcd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dd0:	01 c8                	add    %ecx,%eax
     dd2:	8d 48 fd             	lea    -0x3(%eax),%ecx
     dd5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dd8:	01 c8                	add    %ecx,%eax
     dda:	0f b6 00             	movzbl (%eax),%eax
     ddd:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     ddf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     de3:	8b 55 c8             	mov    -0x38(%ebp),%edx
     de6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     de9:	39 c2                	cmp    %eax,%edx
     deb:	0f 87 41 ff ff ff    	ja     d32 <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     df1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     df5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfb:	39 c2                	cmp    %eax,%edx
     dfd:	0f 87 0d ff ff ff    	ja     d10 <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     e03:	83 ec 0c             	sub    $0xc,%esp
     e06:	ff 75 ec             	pushl  -0x14(%ebp)
     e09:	e8 9c f7 ff ff       	call   5aa <close>
     e0e:	83 c4 10             	add    $0x10,%esp
    return bmp;
     e11:	8b 45 08             	mov    0x8(%ebp),%eax
     e14:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e17:	89 10                	mov    %edx,(%eax)
     e19:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e1c:	89 50 04             	mov    %edx,0x4(%eax)
     e1f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e22:	89 50 08             	mov    %edx,0x8(%eax)
}
     e25:	8b 45 08             	mov    0x8(%ebp),%eax
     e28:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e2b:	5b                   	pop    %ebx
     e2c:	5e                   	pop    %esi
     e2d:	5d                   	pop    %ebp
     e2e:	c2 04 00             	ret    $0x4

00000e31 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e31:	55                   	push   %ebp
     e32:	89 e5                	mov    %esp,%ebp
     e34:	53                   	push   %ebx
     e35:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e38:	83 ec 0c             	sub    $0xc,%esp
     e3b:	6a 1c                	push   $0x1c
     e3d:	e8 b2 fb ff ff       	call   9f4 <malloc>
     e42:	83 c4 10             	add    $0x10,%esp
     e45:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e48:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e52:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e55:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e58:	6a 0c                	push   $0xc
     e5a:	6a 0c                	push   $0xc
     e5c:	6a 0c                	push   $0xc
     e5e:	50                   	push   %eax
     e5f:	e8 73 fc ff ff       	call   ad7 <RGB>
     e64:	83 c4 0c             	add    $0xc,%esp
     e67:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e6b:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e6f:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e73:	88 43 15             	mov    %al,0x15(%ebx)
     e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e79:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e7c:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e80:	66 89 48 10          	mov    %cx,0x10(%eax)
     e84:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e88:	88 50 12             	mov    %dl,0x12(%eax)
     e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e91:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e95:	66 89 48 08          	mov    %cx,0x8(%eax)
     e99:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e9d:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ea0:	8b 45 08             	mov    0x8(%ebp),%eax
     ea3:	89 c2                	mov    %eax,%edx
     ea5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea8:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
     ead:	89 c2                	mov    %eax,%edx
     eaf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eb2:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     eb5:	8b 55 10             	mov    0x10(%ebp),%edx
     eb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ebb:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     ebe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ec1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ec4:	c9                   	leave  
     ec5:	c3                   	ret    

00000ec6 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     ec6:	55                   	push   %ebp
     ec7:	89 e5                	mov    %esp,%ebp
     ec9:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecf:	8b 50 08             	mov    0x8(%eax),%edx
     ed2:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ed5:	8b 40 0c             	mov    0xc(%eax),%eax
     ed8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     edb:	8b 45 0c             	mov    0xc(%ebp),%eax
     ede:	8b 55 10             	mov    0x10(%ebp),%edx
     ee1:	89 50 08             	mov    %edx,0x8(%eax)
     ee4:	8b 55 14             	mov    0x14(%ebp),%edx
     ee7:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     eea:	8b 45 08             	mov    0x8(%ebp),%eax
     eed:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ef0:	89 10                	mov    %edx,(%eax)
     ef2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ef5:	89 50 04             	mov    %edx,0x4(%eax)
}
     ef8:	8b 45 08             	mov    0x8(%ebp),%eax
     efb:	c9                   	leave  
     efc:	c2 04 00             	ret    $0x4

00000eff <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     eff:	55                   	push   %ebp
     f00:	89 e5                	mov    %esp,%ebp
     f02:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     f05:	8b 45 0c             	mov    0xc(%ebp),%eax
     f08:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     f0c:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f10:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     f14:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     f17:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1a:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f1e:	66 89 50 10          	mov    %dx,0x10(%eax)
     f22:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f26:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f29:	8b 45 08             	mov    0x8(%ebp),%eax
     f2c:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f30:	66 89 10             	mov    %dx,(%eax)
     f33:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f37:	88 50 02             	mov    %dl,0x2(%eax)
}
     f3a:	8b 45 08             	mov    0x8(%ebp),%eax
     f3d:	c9                   	leave  
     f3e:	c2 04 00             	ret    $0x4

00000f41 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f41:	55                   	push   %ebp
     f42:	89 e5                	mov    %esp,%ebp
     f44:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f47:	8b 45 08             	mov    0x8(%ebp),%eax
     f4a:	8b 40 0c             	mov    0xc(%eax),%eax
     f4d:	89 c2                	mov    %eax,%edx
     f4f:	c1 ea 1f             	shr    $0x1f,%edx
     f52:	01 d0                	add    %edx,%eax
     f54:	d1 f8                	sar    %eax
     f56:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f5c:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f60:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f63:	8b 45 10             	mov    0x10(%ebp),%eax
     f66:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f69:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f6c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f70:	0f 89 98 00 00 00    	jns    100e <APDrawPoint+0xcd>
        i = 0;
     f76:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f7d:	e9 8c 00 00 00       	jmp    100e <APDrawPoint+0xcd>
    {
        j = x - off;
     f82:	8b 45 0c             	mov    0xc(%ebp),%eax
     f85:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f88:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f8b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f8f:	79 69                	jns    ffa <APDrawPoint+0xb9>
            j = 0;
     f91:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f98:	eb 60                	jmp    ffa <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f9a:	ff 75 fc             	pushl  -0x4(%ebp)
     f9d:	ff 75 f8             	pushl  -0x8(%ebp)
     fa0:	ff 75 08             	pushl  0x8(%ebp)
     fa3:	e8 ad fb ff ff       	call   b55 <APGetIndex>
     fa8:	83 c4 0c             	add    $0xc,%esp
     fab:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     fae:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     fb2:	74 55                	je     1009 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     fb4:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     fb8:	74 67                	je     1021 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     fba:	ff 75 10             	pushl  0x10(%ebp)
     fbd:	ff 75 0c             	pushl  0xc(%ebp)
     fc0:	ff 75 fc             	pushl  -0x4(%ebp)
     fc3:	ff 75 f8             	pushl  -0x8(%ebp)
     fc6:	e8 51 fb ff ff       	call   b1c <distance_2>
     fcb:	83 c4 10             	add    $0x10,%esp
     fce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fd1:	7f 23                	jg     ff6 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     fd3:	8b 45 08             	mov    0x8(%ebp),%eax
     fd6:	8b 48 18             	mov    0x18(%eax),%ecx
     fd9:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fdc:	89 d0                	mov    %edx,%eax
     fde:	01 c0                	add    %eax,%eax
     fe0:	01 d0                	add    %edx,%eax
     fe2:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     fe5:	8b 45 08             	mov    0x8(%ebp),%eax
     fe8:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     fec:	66 89 0a             	mov    %cx,(%edx)
     fef:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     ff3:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ff6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     ffa:	8b 55 0c             	mov    0xc(%ebp),%edx
     ffd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1000:	01 d0                	add    %edx,%eax
    1002:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1005:	7d 93                	jge    f9a <APDrawPoint+0x59>
    1007:	eb 01                	jmp    100a <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1009:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    100a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    100e:	8b 55 10             	mov    0x10(%ebp),%edx
    1011:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1014:	01 d0                	add    %edx,%eax
    1016:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1019:	0f 8d 63 ff ff ff    	jge    f82 <APDrawPoint+0x41>
    101f:	eb 01                	jmp    1022 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1021:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1022:	c9                   	leave  
    1023:	c3                   	ret    

00001024 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1024:	55                   	push   %ebp
    1025:	89 e5                	mov    %esp,%ebp
    1027:	53                   	push   %ebx
    1028:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    102b:	8b 45 0c             	mov    0xc(%ebp),%eax
    102e:	3b 45 14             	cmp    0x14(%ebp),%eax
    1031:	0f 85 80 00 00 00    	jne    10b7 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1037:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    103b:	0f 88 9d 02 00 00    	js     12de <APDrawLine+0x2ba>
    1041:	8b 45 08             	mov    0x8(%ebp),%eax
    1044:	8b 00                	mov    (%eax),%eax
    1046:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1049:	0f 8e 8f 02 00 00    	jle    12de <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    104f:	8b 45 10             	mov    0x10(%ebp),%eax
    1052:	3b 45 18             	cmp    0x18(%ebp),%eax
    1055:	7e 12                	jle    1069 <APDrawLine+0x45>
        {
            int tmp = y2;
    1057:	8b 45 18             	mov    0x18(%ebp),%eax
    105a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    105d:	8b 45 10             	mov    0x10(%ebp),%eax
    1060:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1063:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1066:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1069:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    106d:	79 07                	jns    1076 <APDrawLine+0x52>
    106f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1076:	8b 45 08             	mov    0x8(%ebp),%eax
    1079:	8b 40 04             	mov    0x4(%eax),%eax
    107c:	3b 45 18             	cmp    0x18(%ebp),%eax
    107f:	7d 0c                	jge    108d <APDrawLine+0x69>
    1081:	8b 45 08             	mov    0x8(%ebp),%eax
    1084:	8b 40 04             	mov    0x4(%eax),%eax
    1087:	83 e8 01             	sub    $0x1,%eax
    108a:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    108d:	8b 45 10             	mov    0x10(%ebp),%eax
    1090:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1093:	eb 15                	jmp    10aa <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1095:	ff 75 f4             	pushl  -0xc(%ebp)
    1098:	ff 75 0c             	pushl  0xc(%ebp)
    109b:	ff 75 08             	pushl  0x8(%ebp)
    109e:	e8 9e fe ff ff       	call   f41 <APDrawPoint>
    10a3:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10a6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ad:	3b 45 18             	cmp    0x18(%ebp),%eax
    10b0:	7e e3                	jle    1095 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10b2:	e9 2b 02 00 00       	jmp    12e2 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10b7:	8b 45 10             	mov    0x10(%ebp),%eax
    10ba:	3b 45 18             	cmp    0x18(%ebp),%eax
    10bd:	75 7f                	jne    113e <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    10bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10c3:	0f 88 18 02 00 00    	js     12e1 <APDrawLine+0x2bd>
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	8b 40 04             	mov    0x4(%eax),%eax
    10cf:	3b 45 10             	cmp    0x10(%ebp),%eax
    10d2:	0f 8e 09 02 00 00    	jle    12e1 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    10db:	3b 45 14             	cmp    0x14(%ebp),%eax
    10de:	7e 12                	jle    10f2 <APDrawLine+0xce>
        {
            int tmp = x2;
    10e0:	8b 45 14             	mov    0x14(%ebp),%eax
    10e3:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    10e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e9:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10ef:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10f6:	79 07                	jns    10ff <APDrawLine+0xdb>
    10f8:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    10ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1102:	8b 00                	mov    (%eax),%eax
    1104:	3b 45 14             	cmp    0x14(%ebp),%eax
    1107:	7d 0b                	jge    1114 <APDrawLine+0xf0>
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
    110c:	8b 00                	mov    (%eax),%eax
    110e:	83 e8 01             	sub    $0x1,%eax
    1111:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1114:	8b 45 0c             	mov    0xc(%ebp),%eax
    1117:	89 45 f0             	mov    %eax,-0x10(%ebp)
    111a:	eb 15                	jmp    1131 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    111c:	ff 75 10             	pushl  0x10(%ebp)
    111f:	ff 75 f0             	pushl  -0x10(%ebp)
    1122:	ff 75 08             	pushl  0x8(%ebp)
    1125:	e8 17 fe ff ff       	call   f41 <APDrawPoint>
    112a:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    112d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1131:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1134:	3b 45 14             	cmp    0x14(%ebp),%eax
    1137:	7e e3                	jle    111c <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1139:	e9 a4 01 00 00       	jmp    12e2 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    113e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1145:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    114c:	8b 45 0c             	mov    0xc(%ebp),%eax
    114f:	2b 45 14             	sub    0x14(%ebp),%eax
    1152:	50                   	push   %eax
    1153:	e8 ed f9 ff ff       	call   b45 <abs_int>
    1158:	83 c4 04             	add    $0x4,%esp
    115b:	89 c3                	mov    %eax,%ebx
    115d:	8b 45 10             	mov    0x10(%ebp),%eax
    1160:	2b 45 18             	sub    0x18(%ebp),%eax
    1163:	50                   	push   %eax
    1164:	e8 dc f9 ff ff       	call   b45 <abs_int>
    1169:	83 c4 04             	add    $0x4,%esp
    116c:	39 c3                	cmp    %eax,%ebx
    116e:	0f 8e b5 00 00 00    	jle    1229 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1174:	8b 45 10             	mov    0x10(%ebp),%eax
    1177:	2b 45 18             	sub    0x18(%ebp),%eax
    117a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    117d:	db 45 b0             	fildl  -0x50(%ebp)
    1180:	8b 45 0c             	mov    0xc(%ebp),%eax
    1183:	2b 45 14             	sub    0x14(%ebp),%eax
    1186:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1189:	db 45 b0             	fildl  -0x50(%ebp)
    118c:	de f9                	fdivrp %st,%st(1)
    118e:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1191:	8b 45 14             	mov    0x14(%ebp),%eax
    1194:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1197:	7e 0e                	jle    11a7 <APDrawLine+0x183>
        {
            s = x1;
    1199:	8b 45 0c             	mov    0xc(%ebp),%eax
    119c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    119f:	8b 45 14             	mov    0x14(%ebp),%eax
    11a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11a5:	eb 0c                	jmp    11b3 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11a7:	8b 45 14             	mov    0x14(%ebp),%eax
    11aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    11b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11b7:	79 07                	jns    11c0 <APDrawLine+0x19c>
    11b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    11c0:	8b 45 08             	mov    0x8(%ebp),%eax
    11c3:	8b 00                	mov    (%eax),%eax
    11c5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11c8:	7f 0b                	jg     11d5 <APDrawLine+0x1b1>
    11ca:	8b 45 08             	mov    0x8(%ebp),%eax
    11cd:	8b 00                	mov    (%eax),%eax
    11cf:	83 e8 01             	sub    $0x1,%eax
    11d2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11db:	eb 3f                	jmp    121c <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11e0:	2b 45 0c             	sub    0xc(%ebp),%eax
    11e3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11e6:	db 45 b0             	fildl  -0x50(%ebp)
    11e9:	dc 4d d0             	fmull  -0x30(%ebp)
    11ec:	db 45 10             	fildl  0x10(%ebp)
    11ef:	de c1                	faddp  %st,%st(1)
    11f1:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11f4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11f8:	b4 0c                	mov    $0xc,%ah
    11fa:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11fe:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1201:	db 5d cc             	fistpl -0x34(%ebp)
    1204:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1207:	ff 75 cc             	pushl  -0x34(%ebp)
    120a:	ff 75 e4             	pushl  -0x1c(%ebp)
    120d:	ff 75 08             	pushl  0x8(%ebp)
    1210:	e8 2c fd ff ff       	call   f41 <APDrawPoint>
    1215:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1218:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    121c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    121f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1222:	7e b9                	jle    11dd <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1224:	e9 b9 00 00 00       	jmp    12e2 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1229:	8b 45 0c             	mov    0xc(%ebp),%eax
    122c:	2b 45 14             	sub    0x14(%ebp),%eax
    122f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1232:	db 45 b0             	fildl  -0x50(%ebp)
    1235:	8b 45 10             	mov    0x10(%ebp),%eax
    1238:	2b 45 18             	sub    0x18(%ebp),%eax
    123b:	89 45 b0             	mov    %eax,-0x50(%ebp)
    123e:	db 45 b0             	fildl  -0x50(%ebp)
    1241:	de f9                	fdivrp %st,%st(1)
    1243:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1246:	8b 45 10             	mov    0x10(%ebp),%eax
    1249:	3b 45 18             	cmp    0x18(%ebp),%eax
    124c:	7e 0e                	jle    125c <APDrawLine+0x238>
    {
        s = y2;
    124e:	8b 45 18             	mov    0x18(%ebp),%eax
    1251:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1254:	8b 45 10             	mov    0x10(%ebp),%eax
    1257:	89 45 e8             	mov    %eax,-0x18(%ebp)
    125a:	eb 0c                	jmp    1268 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    125c:	8b 45 10             	mov    0x10(%ebp),%eax
    125f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1262:	8b 45 18             	mov    0x18(%ebp),%eax
    1265:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1268:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    126c:	79 07                	jns    1275 <APDrawLine+0x251>
    126e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1275:	8b 45 08             	mov    0x8(%ebp),%eax
    1278:	8b 40 04             	mov    0x4(%eax),%eax
    127b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    127e:	7f 0c                	jg     128c <APDrawLine+0x268>
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
    1283:	8b 40 04             	mov    0x4(%eax),%eax
    1286:	83 e8 01             	sub    $0x1,%eax
    1289:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    128c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    128f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1292:	eb 3f                	jmp    12d3 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1294:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1297:	2b 45 10             	sub    0x10(%ebp),%eax
    129a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    129d:	db 45 b0             	fildl  -0x50(%ebp)
    12a0:	dc 4d c0             	fmull  -0x40(%ebp)
    12a3:	db 45 0c             	fildl  0xc(%ebp)
    12a6:	de c1                	faddp  %st,%st(1)
    12a8:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12ab:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12af:	b4 0c                	mov    $0xc,%ah
    12b1:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12b5:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12b8:	db 5d bc             	fistpl -0x44(%ebp)
    12bb:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    12be:	ff 75 e0             	pushl  -0x20(%ebp)
    12c1:	ff 75 bc             	pushl  -0x44(%ebp)
    12c4:	ff 75 08             	pushl  0x8(%ebp)
    12c7:	e8 75 fc ff ff       	call   f41 <APDrawPoint>
    12cc:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12cf:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12d6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12d9:	7e b9                	jle    1294 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12db:	90                   	nop
    12dc:	eb 04                	jmp    12e2 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12de:	90                   	nop
    12df:	eb 01                	jmp    12e2 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12e1:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12e5:	c9                   	leave  
    12e6:	c3                   	ret    

000012e7 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    12e7:	55                   	push   %ebp
    12e8:	89 e5                	mov    %esp,%ebp
    12ea:	53                   	push   %ebx
    12eb:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    12ee:	8b 55 10             	mov    0x10(%ebp),%edx
    12f1:	8b 45 18             	mov    0x18(%ebp),%eax
    12f4:	01 d0                	add    %edx,%eax
    12f6:	83 e8 01             	sub    $0x1,%eax
    12f9:	83 ec 04             	sub    $0x4,%esp
    12fc:	50                   	push   %eax
    12fd:	ff 75 0c             	pushl  0xc(%ebp)
    1300:	ff 75 10             	pushl  0x10(%ebp)
    1303:	ff 75 0c             	pushl  0xc(%ebp)
    1306:	ff 75 08             	pushl  0x8(%ebp)
    1309:	e8 16 fd ff ff       	call   1024 <APDrawLine>
    130e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1311:	8b 55 0c             	mov    0xc(%ebp),%edx
    1314:	8b 45 14             	mov    0x14(%ebp),%eax
    1317:	01 d0                	add    %edx,%eax
    1319:	83 e8 01             	sub    $0x1,%eax
    131c:	83 ec 04             	sub    $0x4,%esp
    131f:	ff 75 10             	pushl  0x10(%ebp)
    1322:	50                   	push   %eax
    1323:	ff 75 10             	pushl  0x10(%ebp)
    1326:	ff 75 0c             	pushl  0xc(%ebp)
    1329:	ff 75 08             	pushl  0x8(%ebp)
    132c:	e8 f3 fc ff ff       	call   1024 <APDrawLine>
    1331:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1334:	8b 55 10             	mov    0x10(%ebp),%edx
    1337:	8b 45 18             	mov    0x18(%ebp),%eax
    133a:	01 d0                	add    %edx,%eax
    133c:	8d 48 ff             	lea    -0x1(%eax),%ecx
    133f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1342:	8b 45 14             	mov    0x14(%ebp),%eax
    1345:	01 d0                	add    %edx,%eax
    1347:	8d 50 ff             	lea    -0x1(%eax),%edx
    134a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    134d:	8b 45 14             	mov    0x14(%ebp),%eax
    1350:	01 d8                	add    %ebx,%eax
    1352:	83 e8 01             	sub    $0x1,%eax
    1355:	83 ec 04             	sub    $0x4,%esp
    1358:	51                   	push   %ecx
    1359:	52                   	push   %edx
    135a:	ff 75 10             	pushl  0x10(%ebp)
    135d:	50                   	push   %eax
    135e:	ff 75 08             	pushl  0x8(%ebp)
    1361:	e8 be fc ff ff       	call   1024 <APDrawLine>
    1366:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1369:	8b 55 10             	mov    0x10(%ebp),%edx
    136c:	8b 45 18             	mov    0x18(%ebp),%eax
    136f:	01 d0                	add    %edx,%eax
    1371:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1374:	8b 55 0c             	mov    0xc(%ebp),%edx
    1377:	8b 45 14             	mov    0x14(%ebp),%eax
    137a:	01 d0                	add    %edx,%eax
    137c:	8d 50 ff             	lea    -0x1(%eax),%edx
    137f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1382:	8b 45 18             	mov    0x18(%ebp),%eax
    1385:	01 d8                	add    %ebx,%eax
    1387:	83 e8 01             	sub    $0x1,%eax
    138a:	83 ec 04             	sub    $0x4,%esp
    138d:	51                   	push   %ecx
    138e:	52                   	push   %edx
    138f:	50                   	push   %eax
    1390:	ff 75 0c             	pushl  0xc(%ebp)
    1393:	ff 75 08             	pushl  0x8(%ebp)
    1396:	e8 89 fc ff ff       	call   1024 <APDrawLine>
    139b:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    139e:	8b 55 0c             	mov    0xc(%ebp),%edx
    13a1:	8b 45 14             	mov    0x14(%ebp),%eax
    13a4:	01 d0                	add    %edx,%eax
    13a6:	8d 50 ff             	lea    -0x1(%eax),%edx
    13a9:	8b 45 08             	mov    0x8(%ebp),%eax
    13ac:	8b 40 0c             	mov    0xc(%eax),%eax
    13af:	89 c1                	mov    %eax,%ecx
    13b1:	c1 e9 1f             	shr    $0x1f,%ecx
    13b4:	01 c8                	add    %ecx,%eax
    13b6:	d1 f8                	sar    %eax
    13b8:	29 c2                	sub    %eax,%edx
    13ba:	89 d0                	mov    %edx,%eax
    13bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    13bf:	8b 55 10             	mov    0x10(%ebp),%edx
    13c2:	8b 45 18             	mov    0x18(%ebp),%eax
    13c5:	01 d0                	add    %edx,%eax
    13c7:	8d 50 ff             	lea    -0x1(%eax),%edx
    13ca:	8b 45 08             	mov    0x8(%ebp),%eax
    13cd:	8b 40 0c             	mov    0xc(%eax),%eax
    13d0:	89 c1                	mov    %eax,%ecx
    13d2:	c1 e9 1f             	shr    $0x1f,%ecx
    13d5:	01 c8                	add    %ecx,%eax
    13d7:	d1 f8                	sar    %eax
    13d9:	29 c2                	sub    %eax,%edx
    13db:	89 d0                	mov    %edx,%eax
    13dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13e0:	8b 45 08             	mov    0x8(%ebp),%eax
    13e3:	8b 40 0c             	mov    0xc(%eax),%eax
    13e6:	89 c2                	mov    %eax,%edx
    13e8:	c1 ea 1f             	shr    $0x1f,%edx
    13eb:	01 d0                	add    %edx,%eax
    13ed:	d1 f8                	sar    %eax
    13ef:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13f2:	8b 45 08             	mov    0x8(%ebp),%eax
    13f5:	8b 40 0c             	mov    0xc(%eax),%eax
    13f8:	89 c2                	mov    %eax,%edx
    13fa:	c1 ea 1f             	shr    $0x1f,%edx
    13fd:	01 d0                	add    %edx,%eax
    13ff:	d1 f8                	sar    %eax
    1401:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1404:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1408:	0f 88 d8 00 00 00    	js     14e6 <APDrawRect+0x1ff>
    140e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1412:	0f 88 ce 00 00 00    	js     14e6 <APDrawRect+0x1ff>
    1418:	8b 45 08             	mov    0x8(%ebp),%eax
    141b:	8b 00                	mov    (%eax),%eax
    141d:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1420:	0f 8e c0 00 00 00    	jle    14e6 <APDrawRect+0x1ff>
    1426:	8b 45 08             	mov    0x8(%ebp),%eax
    1429:	8b 40 04             	mov    0x4(%eax),%eax
    142c:	3b 45 10             	cmp    0x10(%ebp),%eax
    142f:	0f 8e b1 00 00 00    	jle    14e6 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1435:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1439:	79 07                	jns    1442 <APDrawRect+0x15b>
    143b:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1442:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1446:	79 07                	jns    144f <APDrawRect+0x168>
    1448:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    144f:	8b 45 08             	mov    0x8(%ebp),%eax
    1452:	8b 00                	mov    (%eax),%eax
    1454:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1457:	7f 0b                	jg     1464 <APDrawRect+0x17d>
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	8b 00                	mov    (%eax),%eax
    145e:	83 e8 01             	sub    $0x1,%eax
    1461:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1464:	8b 45 08             	mov    0x8(%ebp),%eax
    1467:	8b 40 04             	mov    0x4(%eax),%eax
    146a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    146d:	7f 0c                	jg     147b <APDrawRect+0x194>
    146f:	8b 45 08             	mov    0x8(%ebp),%eax
    1472:	8b 40 04             	mov    0x4(%eax),%eax
    1475:	83 e8 01             	sub    $0x1,%eax
    1478:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    147b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1482:	8b 45 0c             	mov    0xc(%ebp),%eax
    1485:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1488:	eb 52                	jmp    14dc <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    148a:	8b 45 10             	mov    0x10(%ebp),%eax
    148d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1490:	eb 3e                	jmp    14d0 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1492:	83 ec 04             	sub    $0x4,%esp
    1495:	ff 75 e8             	pushl  -0x18(%ebp)
    1498:	ff 75 ec             	pushl  -0x14(%ebp)
    149b:	ff 75 08             	pushl  0x8(%ebp)
    149e:	e8 b2 f6 ff ff       	call   b55 <APGetIndex>
    14a3:	83 c4 10             	add    $0x10,%esp
    14a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14a9:	8b 45 08             	mov    0x8(%ebp),%eax
    14ac:	8b 48 18             	mov    0x18(%eax),%ecx
    14af:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14b2:	89 d0                	mov    %edx,%eax
    14b4:	01 c0                	add    %eax,%eax
    14b6:	01 d0                	add    %edx,%eax
    14b8:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14bb:	8b 45 08             	mov    0x8(%ebp),%eax
    14be:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    14c2:	66 89 0a             	mov    %cx,(%edx)
    14c5:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14c9:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14cc:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14d3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14d6:	7e ba                	jle    1492 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14d8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14df:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14e2:	7e a6                	jle    148a <APDrawRect+0x1a3>
    14e4:	eb 01                	jmp    14e7 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    14e6:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    14e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14ea:	c9                   	leave  
    14eb:	c3                   	ret    

000014ec <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14ec:	55                   	push   %ebp
    14ed:	89 e5                	mov    %esp,%ebp
    14ef:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14f2:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14f6:	0f 88 8e 01 00 00    	js     168a <APDcCopy+0x19e>
    14fc:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1500:	0f 88 84 01 00 00    	js     168a <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1506:	8b 55 0c             	mov    0xc(%ebp),%edx
    1509:	8b 45 20             	mov    0x20(%ebp),%eax
    150c:	01 d0                	add    %edx,%eax
    150e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1511:	8b 55 10             	mov    0x10(%ebp),%edx
    1514:	8b 45 24             	mov    0x24(%ebp),%eax
    1517:	01 d0                	add    %edx,%eax
    1519:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    151c:	8b 55 18             	mov    0x18(%ebp),%edx
    151f:	8b 45 20             	mov    0x20(%ebp),%eax
    1522:	01 d0                	add    %edx,%eax
    1524:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1527:	8b 55 1c             	mov    0x1c(%ebp),%edx
    152a:	8b 45 24             	mov    0x24(%ebp),%eax
    152d:	01 d0                	add    %edx,%eax
    152f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    1532:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1536:	0f 88 51 01 00 00    	js     168d <APDcCopy+0x1a1>
    153c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1540:	0f 88 47 01 00 00    	js     168d <APDcCopy+0x1a1>
    1546:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    154a:	0f 88 3d 01 00 00    	js     168d <APDcCopy+0x1a1>
    1550:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1554:	0f 88 33 01 00 00    	js     168d <APDcCopy+0x1a1>
    155a:	8b 45 14             	mov    0x14(%ebp),%eax
    155d:	8b 00                	mov    (%eax),%eax
    155f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1562:	0f 8e 25 01 00 00    	jle    168d <APDcCopy+0x1a1>
    1568:	8b 45 14             	mov    0x14(%ebp),%eax
    156b:	8b 40 04             	mov    0x4(%eax),%eax
    156e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1571:	0f 8e 16 01 00 00    	jle    168d <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    1577:	8b 45 08             	mov    0x8(%ebp),%eax
    157a:	8b 00                	mov    (%eax),%eax
    157c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    157f:	7d 0b                	jge    158c <APDcCopy+0xa0>
    1581:	8b 45 08             	mov    0x8(%ebp),%eax
    1584:	8b 00                	mov    (%eax),%eax
    1586:	83 e8 01             	sub    $0x1,%eax
    1589:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    158c:	8b 45 08             	mov    0x8(%ebp),%eax
    158f:	8b 40 04             	mov    0x4(%eax),%eax
    1592:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1595:	7d 0c                	jge    15a3 <APDcCopy+0xb7>
    1597:	8b 45 08             	mov    0x8(%ebp),%eax
    159a:	8b 40 04             	mov    0x4(%eax),%eax
    159d:	83 e8 01             	sub    $0x1,%eax
    15a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    15a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    15aa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    15b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    15b8:	e9 bc 00 00 00       	jmp    1679 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    15bd:	8b 45 08             	mov    0x8(%ebp),%eax
    15c0:	8b 00                	mov    (%eax),%eax
    15c2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15c5:	8b 55 10             	mov    0x10(%ebp),%edx
    15c8:	01 ca                	add    %ecx,%edx
    15ca:	0f af d0             	imul   %eax,%edx
    15cd:	8b 45 0c             	mov    0xc(%ebp),%eax
    15d0:	01 d0                	add    %edx,%eax
    15d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    15d5:	8b 45 14             	mov    0x14(%ebp),%eax
    15d8:	8b 00                	mov    (%eax),%eax
    15da:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15dd:	8b 55 1c             	mov    0x1c(%ebp),%edx
    15e0:	01 ca                	add    %ecx,%edx
    15e2:	0f af d0             	imul   %eax,%edx
    15e5:	8b 45 18             	mov    0x18(%ebp),%eax
    15e8:	01 d0                	add    %edx,%eax
    15ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    15ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15f4:	eb 74                	jmp    166a <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15f6:	8b 45 14             	mov    0x14(%ebp),%eax
    15f9:	8b 50 18             	mov    0x18(%eax),%edx
    15fc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1602:	01 c8                	add    %ecx,%eax
    1604:	89 c1                	mov    %eax,%ecx
    1606:	89 c8                	mov    %ecx,%eax
    1608:	01 c0                	add    %eax,%eax
    160a:	01 c8                	add    %ecx,%eax
    160c:	01 d0                	add    %edx,%eax
    160e:	0f b7 10             	movzwl (%eax),%edx
    1611:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1615:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1619:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    161c:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1620:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1624:	38 c2                	cmp    %al,%dl
    1626:	75 18                	jne    1640 <APDcCopy+0x154>
    1628:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    162c:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1630:	38 c2                	cmp    %al,%dl
    1632:	75 0c                	jne    1640 <APDcCopy+0x154>
    1634:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1638:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    163c:	38 c2                	cmp    %al,%dl
    163e:	74 26                	je     1666 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1640:	8b 45 08             	mov    0x8(%ebp),%eax
    1643:	8b 50 18             	mov    0x18(%eax),%edx
    1646:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1649:	8b 45 f0             	mov    -0x10(%ebp),%eax
    164c:	01 c8                	add    %ecx,%eax
    164e:	89 c1                	mov    %eax,%ecx
    1650:	89 c8                	mov    %ecx,%eax
    1652:	01 c0                	add    %eax,%eax
    1654:	01 c8                	add    %ecx,%eax
    1656:	01 d0                	add    %edx,%eax
    1658:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    165c:	66 89 10             	mov    %dx,(%eax)
    165f:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1663:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    1666:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    166a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    166d:	2b 45 0c             	sub    0xc(%ebp),%eax
    1670:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1673:	7f 81                	jg     15f6 <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    1675:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1679:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167c:	2b 45 10             	sub    0x10(%ebp),%eax
    167f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1682:	0f 8f 35 ff ff ff    	jg     15bd <APDcCopy+0xd1>
    1688:	eb 04                	jmp    168e <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    168a:	90                   	nop
    168b:	eb 01                	jmp    168e <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    168d:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    168e:	c9                   	leave  
    168f:	c3                   	ret    

00001690 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1690:	55                   	push   %ebp
    1691:	89 e5                	mov    %esp,%ebp
    1693:	83 ec 1c             	sub    $0x1c,%esp
    1696:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1699:	8b 55 10             	mov    0x10(%ebp),%edx
    169c:	8b 45 14             	mov    0x14(%ebp),%eax
    169f:	88 4d ec             	mov    %cl,-0x14(%ebp)
    16a2:	88 55 e8             	mov    %dl,-0x18(%ebp)
    16a5:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    16a8:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    16ac:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    16af:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    16b3:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    16b6:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    16ba:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    16bd:	8b 45 08             	mov    0x8(%ebp),%eax
    16c0:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    16c4:	66 89 10             	mov    %dx,(%eax)
    16c7:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    16cb:	88 50 02             	mov    %dl,0x2(%eax)
}
    16ce:	8b 45 08             	mov    0x8(%ebp),%eax
    16d1:	c9                   	leave  
    16d2:	c2 04 00             	ret    $0x4

000016d5 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    16d5:	55                   	push   %ebp
    16d6:	89 e5                	mov    %esp,%ebp
    16d8:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    16db:	8b 45 08             	mov    0x8(%ebp),%eax
    16de:	8b 00                	mov    (%eax),%eax
    16e0:	83 ec 08             	sub    $0x8,%esp
    16e3:	8d 55 0c             	lea    0xc(%ebp),%edx
    16e6:	52                   	push   %edx
    16e7:	50                   	push   %eax
    16e8:	e8 45 ef ff ff       	call   632 <sendMessage>
    16ed:	83 c4 10             	add    $0x10,%esp
}
    16f0:	90                   	nop
    16f1:	c9                   	leave  
    16f2:	c3                   	ret    

000016f3 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16f3:	55                   	push   %ebp
    16f4:	89 e5                	mov    %esp,%ebp
    16f6:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16f9:	83 ec 0c             	sub    $0xc,%esp
    16fc:	68 90 00 00 00       	push   $0x90
    1701:	e8 ee f2 ff ff       	call   9f4 <malloc>
    1706:	83 c4 10             	add    $0x10,%esp
    1709:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    170c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1710:	75 15                	jne    1727 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1712:	83 ec 04             	sub    $0x4,%esp
    1715:	ff 75 08             	pushl  0x8(%ebp)
    1718:	68 e8 21 00 00       	push   $0x21e8
    171d:	6a 01                	push   $0x1
    171f:	e8 fd ef ff ff       	call   721 <printf>
    1724:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1727:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172a:	83 c0 7c             	add    $0x7c,%eax
    172d:	83 ec 08             	sub    $0x8,%esp
    1730:	ff 75 08             	pushl  0x8(%ebp)
    1733:	50                   	push   %eax
    1734:	e8 18 ec ff ff       	call   351 <strcpy>
    1739:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    173c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173f:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1746:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1749:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1750:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1753:	8b 40 34             	mov    0x34(%eax),%eax
    1756:	89 c2                	mov    %eax,%edx
    1758:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175b:	8b 40 38             	mov    0x38(%eax),%eax
    175e:	0f af d0             	imul   %eax,%edx
    1761:	89 d0                	mov    %edx,%eax
    1763:	01 c0                	add    %eax,%eax
    1765:	01 d0                	add    %edx,%eax
    1767:	83 ec 0c             	sub    $0xc,%esp
    176a:	50                   	push   %eax
    176b:	e8 84 f2 ff ff       	call   9f4 <malloc>
    1770:	83 c4 10             	add    $0x10,%esp
    1773:	89 c2                	mov    %eax,%edx
    1775:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1778:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    177b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177e:	8b 40 4c             	mov    0x4c(%eax),%eax
    1781:	85 c0                	test   %eax,%eax
    1783:	75 15                	jne    179a <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1785:	83 ec 04             	sub    $0x4,%esp
    1788:	ff 75 08             	pushl  0x8(%ebp)
    178b:	68 08 22 00 00       	push   $0x2208
    1790:	6a 01                	push   $0x1
    1792:	e8 8a ef ff ff       	call   721 <printf>
    1797:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    179a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179d:	8b 40 34             	mov    0x34(%eax),%eax
    17a0:	89 c2                	mov    %eax,%edx
    17a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a5:	8b 40 38             	mov    0x38(%eax),%eax
    17a8:	0f af d0             	imul   %eax,%edx
    17ab:	89 d0                	mov    %edx,%eax
    17ad:	01 c0                	add    %eax,%eax
    17af:	01 c2                	add    %eax,%edx
    17b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b4:	8b 40 4c             	mov    0x4c(%eax),%eax
    17b7:	83 ec 04             	sub    $0x4,%esp
    17ba:	52                   	push   %edx
    17bb:	68 ff ff ff 00       	push   $0xffffff
    17c0:	50                   	push   %eax
    17c1:	e8 21 ec ff ff       	call   3e7 <memset>
    17c6:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    17c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cc:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    17d3:	e8 2a ee ff ff       	call   602 <getpid>
    17d8:	89 c2                	mov    %eax,%edx
    17da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17dd:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    17e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e3:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ed:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f7:	8b 40 50             	mov    0x50(%eax),%eax
    17fa:	89 c2                	mov    %eax,%edx
    17fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ff:	8b 40 54             	mov    0x54(%eax),%eax
    1802:	0f af d0             	imul   %eax,%edx
    1805:	89 d0                	mov    %edx,%eax
    1807:	01 c0                	add    %eax,%eax
    1809:	01 d0                	add    %edx,%eax
    180b:	83 ec 0c             	sub    $0xc,%esp
    180e:	50                   	push   %eax
    180f:	e8 e0 f1 ff ff       	call   9f4 <malloc>
    1814:	83 c4 10             	add    $0x10,%esp
    1817:	89 c2                	mov    %eax,%edx
    1819:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181c:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    181f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1822:	8b 40 68             	mov    0x68(%eax),%eax
    1825:	85 c0                	test   %eax,%eax
    1827:	75 15                	jne    183e <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1829:	83 ec 04             	sub    $0x4,%esp
    182c:	ff 75 08             	pushl  0x8(%ebp)
    182f:	68 2c 22 00 00       	push   $0x222c
    1834:	6a 01                	push   $0x1
    1836:	e8 e6 ee ff ff       	call   721 <printf>
    183b:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    183e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1841:	8b 40 34             	mov    0x34(%eax),%eax
    1844:	89 c2                	mov    %eax,%edx
    1846:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1849:	8b 40 38             	mov    0x38(%eax),%eax
    184c:	0f af d0             	imul   %eax,%edx
    184f:	89 d0                	mov    %edx,%eax
    1851:	01 c0                	add    %eax,%eax
    1853:	01 c2                	add    %eax,%edx
    1855:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1858:	8b 40 4c             	mov    0x4c(%eax),%eax
    185b:	83 ec 04             	sub    $0x4,%esp
    185e:	52                   	push   %edx
    185f:	68 ff 00 00 00       	push   $0xff
    1864:	50                   	push   %eax
    1865:	e8 7d eb ff ff       	call   3e7 <memset>
    186a:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    186d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1870:	8b 55 0c             	mov    0xc(%ebp),%edx
    1873:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1876:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    187a:	74 35                	je     18b1 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    187c:	8b 45 10             	mov    0x10(%ebp),%eax
    187f:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1885:	83 ec 0c             	sub    $0xc,%esp
    1888:	50                   	push   %eax
    1889:	e8 66 f1 ff ff       	call   9f4 <malloc>
    188e:	83 c4 10             	add    $0x10,%esp
    1891:	89 c2                	mov    %eax,%edx
    1893:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1896:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1899:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189c:	8b 55 10             	mov    0x10(%ebp),%edx
    189f:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    18a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a5:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    18ac:	e9 8d 00 00 00       	jmp    193e <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    18b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b4:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    18bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18be:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c8:	8b 40 18             	mov    0x18(%eax),%eax
    18cb:	89 c2                	mov    %eax,%edx
    18cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d0:	8b 40 1c             	mov    0x1c(%eax),%eax
    18d3:	0f af d0             	imul   %eax,%edx
    18d6:	89 d0                	mov    %edx,%eax
    18d8:	01 c0                	add    %eax,%eax
    18da:	01 d0                	add    %edx,%eax
    18dc:	83 ec 0c             	sub    $0xc,%esp
    18df:	50                   	push   %eax
    18e0:	e8 0f f1 ff ff       	call   9f4 <malloc>
    18e5:	83 c4 10             	add    $0x10,%esp
    18e8:	89 c2                	mov    %eax,%edx
    18ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ed:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    18f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f3:	8b 40 30             	mov    0x30(%eax),%eax
    18f6:	85 c0                	test   %eax,%eax
    18f8:	75 15                	jne    190f <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18fa:	83 ec 04             	sub    $0x4,%esp
    18fd:	ff 75 08             	pushl  0x8(%ebp)
    1900:	68 54 22 00 00       	push   $0x2254
    1905:	6a 01                	push   $0x1
    1907:	e8 15 ee ff ff       	call   721 <printf>
    190c:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    190f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1912:	8b 40 18             	mov    0x18(%eax),%eax
    1915:	89 c2                	mov    %eax,%edx
    1917:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191a:	8b 40 1c             	mov    0x1c(%eax),%eax
    191d:	0f af d0             	imul   %eax,%edx
    1920:	89 d0                	mov    %edx,%eax
    1922:	01 c0                	add    %eax,%eax
    1924:	01 c2                	add    %eax,%edx
    1926:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1929:	8b 40 30             	mov    0x30(%eax),%eax
    192c:	83 ec 04             	sub    $0x4,%esp
    192f:	52                   	push   %edx
    1930:	68 ff ff ff 00       	push   $0xffffff
    1935:	50                   	push   %eax
    1936:	e8 ac ea ff ff       	call   3e7 <memset>
    193b:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    193e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1941:	c9                   	leave  
    1942:	c3                   	ret    

00001943 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1943:	55                   	push   %ebp
    1944:	89 e5                	mov    %esp,%ebp
    1946:	53                   	push   %ebx
    1947:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    194a:	8b 45 0c             	mov    0xc(%ebp),%eax
    194d:	83 f8 03             	cmp    $0x3,%eax
    1950:	74 02                	je     1954 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1952:	eb 33                	jmp    1987 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1954:	8b 45 08             	mov    0x8(%ebp),%eax
    1957:	8b 48 08             	mov    0x8(%eax),%ecx
    195a:	8b 45 08             	mov    0x8(%ebp),%eax
    195d:	8b 50 38             	mov    0x38(%eax),%edx
    1960:	8b 45 08             	mov    0x8(%ebp),%eax
    1963:	8b 40 34             	mov    0x34(%eax),%eax
    1966:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1969:	83 c3 34             	add    $0x34,%ebx
    196c:	83 ec 0c             	sub    $0xc,%esp
    196f:	51                   	push   %ecx
    1970:	52                   	push   %edx
    1971:	50                   	push   %eax
    1972:	6a 00                	push   $0x0
    1974:	6a 00                	push   $0x0
    1976:	53                   	push   %ebx
    1977:	6a 32                	push   $0x32
    1979:	6a 00                	push   $0x0
    197b:	ff 75 08             	pushl  0x8(%ebp)
    197e:	e8 9f ec ff ff       	call   622 <paintWindow>
    1983:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1986:	90                   	nop
        default: break;
            
            
    }
    return False;
    1987:	b8 00 00 00 00       	mov    $0x0,%eax
}
    198c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    198f:	c9                   	leave  
    1990:	c3                   	ret    

00001991 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1991:	55                   	push   %ebp
    1992:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1994:	8b 45 0c             	mov    0xc(%ebp),%eax
    1997:	8b 50 08             	mov    0x8(%eax),%edx
    199a:	8b 45 08             	mov    0x8(%ebp),%eax
    199d:	8b 00                	mov    (%eax),%eax
    199f:	39 c2                	cmp    %eax,%edx
    19a1:	74 07                	je     19aa <APPreJudge+0x19>
        return False;
    19a3:	b8 00 00 00 00       	mov    $0x0,%eax
    19a8:	eb 05                	jmp    19af <APPreJudge+0x1e>
    return True;
    19aa:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19af:	5d                   	pop    %ebp
    19b0:	c3                   	ret    

000019b1 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19b1:	55                   	push   %ebp
    19b2:	89 e5                	mov    %esp,%ebp
    19b4:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    19bd:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    19c0:	83 ec 0c             	sub    $0xc,%esp
    19c3:	ff 75 08             	pushl  0x8(%ebp)
    19c6:	e8 77 ec ff ff       	call   642 <registWindow>
    19cb:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19ce:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    19d5:	8b 45 08             	mov    0x8(%ebp),%eax
    19d8:	8b 00                	mov    (%eax),%eax
    19da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    19dd:	ff 75 f4             	pushl  -0xc(%ebp)
    19e0:	ff 75 f0             	pushl  -0x10(%ebp)
    19e3:	ff 75 ec             	pushl  -0x14(%ebp)
    19e6:	ff 75 08             	pushl  0x8(%ebp)
    19e9:	e8 e7 fc ff ff       	call   16d5 <APSendMessage>
    19ee:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19f1:	83 ec 0c             	sub    $0xc,%esp
    19f4:	ff 75 08             	pushl  0x8(%ebp)
    19f7:	e8 3e ec ff ff       	call   63a <getMessage>
    19fc:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    19ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1a02:	83 c0 6c             	add    $0x6c,%eax
    1a05:	83 ec 08             	sub    $0x8,%esp
    1a08:	50                   	push   %eax
    1a09:	ff 75 08             	pushl  0x8(%ebp)
    1a0c:	e8 80 ff ff ff       	call   1991 <APPreJudge>
    1a11:	83 c4 10             	add    $0x10,%esp
    1a14:	84 c0                	test   %al,%al
    1a16:	74 1b                	je     1a33 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1a18:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1b:	ff 70 74             	pushl  0x74(%eax)
    1a1e:	ff 70 70             	pushl  0x70(%eax)
    1a21:	ff 70 6c             	pushl  0x6c(%eax)
    1a24:	ff 75 08             	pushl  0x8(%ebp)
    1a27:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a2a:	ff d0                	call   *%eax
    1a2c:	83 c4 10             	add    $0x10,%esp
    1a2f:	84 c0                	test   %al,%al
    1a31:	75 0c                	jne    1a3f <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1a3d:	eb b2                	jmp    19f1 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a3f:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a40:	90                   	nop
    1a41:	c9                   	leave  
    1a42:	c3                   	ret    

00001a43 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a43:	55                   	push   %ebp
    1a44:	89 e5                	mov    %esp,%ebp
    1a46:	57                   	push   %edi
    1a47:	56                   	push   %esi
    1a48:	53                   	push   %ebx
    1a49:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1a4c:	a1 cc 28 00 00       	mov    0x28cc,%eax
    1a51:	85 c0                	test   %eax,%eax
    1a53:	75 7c                	jne    1ad1 <APGridPaint+0x8e>
    {
        iconReady = 1;
    1a55:	c7 05 cc 28 00 00 01 	movl   $0x1,0x28cc
    1a5c:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1a5f:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a62:	83 ec 08             	sub    $0x8,%esp
    1a65:	68 7b 22 00 00       	push   $0x227b
    1a6a:	50                   	push   %eax
    1a6b:	e8 37 f1 ff ff       	call   ba7 <APLoadBitmap>
    1a70:	83 c4 0c             	add    $0xc,%esp
    1a73:	8b 45 b8             	mov    -0x48(%ebp),%eax
    1a76:	a3 e0 2c 00 00       	mov    %eax,0x2ce0
    1a7b:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1a7e:	a3 e4 2c 00 00       	mov    %eax,0x2ce4
    1a83:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1a86:	a3 e8 2c 00 00       	mov    %eax,0x2ce8
        printf(1,"bitmap loaded!\n");
    1a8b:	83 ec 08             	sub    $0x8,%esp
    1a8e:	68 85 22 00 00       	push   $0x2285
    1a93:	6a 01                	push   $0x1
    1a95:	e8 87 ec ff ff       	call   721 <printf>
    1a9a:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a9d:	83 ec 04             	sub    $0x4,%esp
    1aa0:	ff 35 e8 2c 00 00    	pushl  0x2ce8
    1aa6:	ff 35 e4 2c 00 00    	pushl  0x2ce4
    1aac:	ff 35 e0 2c 00 00    	pushl  0x2ce0
    1ab2:	e8 7a f3 ff ff       	call   e31 <APCreateCompatibleDCFromBitmap>
    1ab7:	83 c4 10             	add    $0x10,%esp
    1aba:	a3 ec 2c 00 00       	mov    %eax,0x2cec
        printf(1,"bitmap DC created!\n");
    1abf:	83 ec 08             	sub    $0x8,%esp
    1ac2:	68 95 22 00 00       	push   $0x2295
    1ac7:	6a 01                	push   $0x1
    1ac9:	e8 53 ec ff ff       	call   721 <printf>
    1ace:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    1ad1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad4:	8b 40 08             	mov    0x8(%eax),%eax
    1ad7:	85 c0                	test   %eax,%eax
    1ad9:	75 17                	jne    1af2 <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1adb:	83 ec 08             	sub    $0x8,%esp
    1ade:	68 ac 22 00 00       	push   $0x22ac
    1ae3:	6a 01                	push   $0x1
    1ae5:	e8 37 ec ff ff       	call   721 <printf>
    1aea:	83 c4 10             	add    $0x10,%esp
        return;
    1aed:	e9 55 03 00 00       	jmp    1e47 <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1af2:	8b 45 08             	mov    0x8(%ebp),%eax
    1af5:	8b 40 10             	mov    0x10(%eax),%eax
    1af8:	85 c0                	test   %eax,%eax
    1afa:	7e 10                	jle    1b0c <APGridPaint+0xc9>
    1afc:	8b 45 08             	mov    0x8(%ebp),%eax
    1aff:	8b 50 14             	mov    0x14(%eax),%edx
    1b02:	8b 45 08             	mov    0x8(%ebp),%eax
    1b05:	8b 40 10             	mov    0x10(%eax),%eax
    1b08:	39 c2                	cmp    %eax,%edx
    1b0a:	7c 17                	jl     1b23 <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1b0c:	83 ec 08             	sub    $0x8,%esp
    1b0f:	68 d2 22 00 00       	push   $0x22d2
    1b14:	6a 01                	push   $0x1
    1b16:	e8 06 ec ff ff       	call   721 <printf>
    1b1b:	83 c4 10             	add    $0x10,%esp
        return;
    1b1e:	e9 24 03 00 00       	jmp    1e47 <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b23:	8b 45 08             	mov    0x8(%ebp),%eax
    1b26:	8b 40 14             	mov    0x14(%eax),%eax
    1b29:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b2f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b32:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b35:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b38:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b3f:	e9 f9 02 00 00       	jmp    1e3d <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b44:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b4b:	e9 df 02 00 00       	jmp    1e2f <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b53:	c1 e0 04             	shl    $0x4,%eax
    1b56:	89 c2                	mov    %eax,%edx
    1b58:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b5b:	01 c2                	add    %eax,%edx
    1b5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b60:	01 d0                	add    %edx,%eax
    1b62:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b65:	8b 45 08             	mov    0x8(%ebp),%eax
    1b68:	8b 40 0c             	mov    0xc(%eax),%eax
    1b6b:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b6e:	c1 e2 02             	shl    $0x2,%edx
    1b71:	01 d0                	add    %edx,%eax
    1b73:	8b 00                	mov    (%eax),%eax
    1b75:	83 f8 01             	cmp    $0x1,%eax
    1b78:	0f 84 83 00 00 00    	je     1c01 <APGridPaint+0x1be>
    1b7e:	83 f8 01             	cmp    $0x1,%eax
    1b81:	7f 09                	jg     1b8c <APGridPaint+0x149>
    1b83:	85 c0                	test   %eax,%eax
    1b85:	74 1c                	je     1ba3 <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1b87:	e9 9f 02 00 00       	jmp    1e2b <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b8c:	83 f8 02             	cmp    $0x2,%eax
    1b8f:	0f 84 20 01 00 00    	je     1cb5 <APGridPaint+0x272>
    1b95:	83 f8 03             	cmp    $0x3,%eax
    1b98:	0f 84 d1 01 00 00    	je     1d6f <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1b9e:	e9 88 02 00 00       	jmp    1e2b <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ba3:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ba6:	6a 0c                	push   $0xc
    1ba8:	6a 0c                	push   $0xc
    1baa:	6a 0c                	push   $0xc
    1bac:	50                   	push   %eax
    1bad:	e8 de fa ff ff       	call   1690 <RGB>
    1bb2:	83 c4 0c             	add    $0xc,%esp
    1bb5:	8b 1d ec 2c 00 00    	mov    0x2cec,%ebx
    1bbb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bbe:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bc4:	6b c0 32             	imul   $0x32,%eax,%eax
    1bc7:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    1bca:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcd:	8d 78 34             	lea    0x34(%eax),%edi
    1bd0:	83 ec 0c             	sub    $0xc,%esp
    1bd3:	83 ec 04             	sub    $0x4,%esp
    1bd6:	89 e0                	mov    %esp,%eax
    1bd8:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1bdc:	66 89 30             	mov    %si,(%eax)
    1bdf:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1be3:	88 50 02             	mov    %dl,0x2(%eax)
    1be6:	6a 32                	push   $0x32
    1be8:	6a 32                	push   $0x32
    1bea:	6a 00                	push   $0x0
    1bec:	6a 00                	push   $0x0
    1bee:	53                   	push   %ebx
    1bef:	51                   	push   %ecx
    1bf0:	ff 75 b4             	pushl  -0x4c(%ebp)
    1bf3:	57                   	push   %edi
    1bf4:	e8 f3 f8 ff ff       	call   14ec <APDcCopy>
    1bf9:	83 c4 30             	add    $0x30,%esp
                    break;
    1bfc:	e9 2a 02 00 00       	jmp    1e2b <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c01:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c04:	6a 69                	push   $0x69
    1c06:	6a 69                	push   $0x69
    1c08:	6a 69                	push   $0x69
    1c0a:	50                   	push   %eax
    1c0b:	e8 80 fa ff ff       	call   1690 <RGB>
    1c10:	83 c4 0c             	add    $0xc,%esp
    1c13:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1c17:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1c1b:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1c1f:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1c22:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c29:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c2c:	6a 69                	push   $0x69
    1c2e:	6a 69                	push   $0x69
    1c30:	6a 69                	push   $0x69
    1c32:	50                   	push   %eax
    1c33:	e8 58 fa ff ff       	call   1690 <RGB>
    1c38:	83 c4 0c             	add    $0xc,%esp
    1c3b:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1c3f:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1c43:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1c47:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4d:	8d 50 34             	lea    0x34(%eax),%edx
    1c50:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c53:	ff 75 d0             	pushl  -0x30(%ebp)
    1c56:	ff 75 cc             	pushl  -0x34(%ebp)
    1c59:	52                   	push   %edx
    1c5a:	50                   	push   %eax
    1c5b:	e8 66 f2 ff ff       	call   ec6 <APSetPen>
    1c60:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c63:	8b 45 08             	mov    0x8(%ebp),%eax
    1c66:	8d 58 34             	lea    0x34(%eax),%ebx
    1c69:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1c6c:	83 ec 04             	sub    $0x4,%esp
    1c6f:	83 ec 04             	sub    $0x4,%esp
    1c72:	89 e0                	mov    %esp,%eax
    1c74:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1c78:	66 89 08             	mov    %cx,(%eax)
    1c7b:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1c7f:	88 48 02             	mov    %cl,0x2(%eax)
    1c82:	53                   	push   %ebx
    1c83:	52                   	push   %edx
    1c84:	e8 76 f2 ff ff       	call   eff <APSetBrush>
    1c89:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1c8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c8f:	6b d0 32             	imul   $0x32,%eax,%edx
    1c92:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c95:	6b c0 32             	imul   $0x32,%eax,%eax
    1c98:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c9b:	83 c1 34             	add    $0x34,%ecx
    1c9e:	83 ec 0c             	sub    $0xc,%esp
    1ca1:	6a 32                	push   $0x32
    1ca3:	6a 32                	push   $0x32
    1ca5:	52                   	push   %edx
    1ca6:	50                   	push   %eax
    1ca7:	51                   	push   %ecx
    1ca8:	e8 3a f6 ff ff       	call   12e7 <APDrawRect>
    1cad:	83 c4 20             	add    $0x20,%esp
                    break;
    1cb0:	e9 76 01 00 00       	jmp    1e2b <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1cb5:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1cb8:	6a 00                	push   $0x0
    1cba:	68 80 00 00 00       	push   $0x80
    1cbf:	6a 00                	push   $0x0
    1cc1:	50                   	push   %eax
    1cc2:	e8 c9 f9 ff ff       	call   1690 <RGB>
    1cc7:	83 c4 0c             	add    $0xc,%esp
    1cca:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1cce:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1cd2:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1cd6:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1cd9:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1ce0:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1ce3:	6a 00                	push   $0x0
    1ce5:	68 80 00 00 00       	push   $0x80
    1cea:	6a 00                	push   $0x0
    1cec:	50                   	push   %eax
    1ced:	e8 9e f9 ff ff       	call   1690 <RGB>
    1cf2:	83 c4 0c             	add    $0xc,%esp
    1cf5:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1cf9:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1cfd:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1d01:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d04:	8b 45 08             	mov    0x8(%ebp),%eax
    1d07:	8d 50 34             	lea    0x34(%eax),%edx
    1d0a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1d0d:	ff 75 d0             	pushl  -0x30(%ebp)
    1d10:	ff 75 cc             	pushl  -0x34(%ebp)
    1d13:	52                   	push   %edx
    1d14:	50                   	push   %eax
    1d15:	e8 ac f1 ff ff       	call   ec6 <APSetPen>
    1d1a:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d20:	8d 58 34             	lea    0x34(%eax),%ebx
    1d23:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1d26:	83 ec 04             	sub    $0x4,%esp
    1d29:	83 ec 04             	sub    $0x4,%esp
    1d2c:	89 e0                	mov    %esp,%eax
    1d2e:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1d32:	66 89 08             	mov    %cx,(%eax)
    1d35:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1d39:	88 48 02             	mov    %cl,0x2(%eax)
    1d3c:	53                   	push   %ebx
    1d3d:	52                   	push   %edx
    1d3e:	e8 bc f1 ff ff       	call   eff <APSetBrush>
    1d43:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d49:	6b d0 32             	imul   $0x32,%eax,%edx
    1d4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d4f:	6b c0 32             	imul   $0x32,%eax,%eax
    1d52:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d55:	83 c1 34             	add    $0x34,%ecx
    1d58:	83 ec 0c             	sub    $0xc,%esp
    1d5b:	6a 32                	push   $0x32
    1d5d:	6a 32                	push   $0x32
    1d5f:	52                   	push   %edx
    1d60:	50                   	push   %eax
    1d61:	51                   	push   %ecx
    1d62:	e8 80 f5 ff ff       	call   12e7 <APDrawRect>
    1d67:	83 c4 20             	add    $0x20,%esp
                    break;
    1d6a:	e9 bc 00 00 00       	jmp    1e2b <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1d6f:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1d72:	68 ff 00 00 00       	push   $0xff
    1d77:	68 bf 00 00 00       	push   $0xbf
    1d7c:	6a 00                	push   $0x0
    1d7e:	50                   	push   %eax
    1d7f:	e8 0c f9 ff ff       	call   1690 <RGB>
    1d84:	83 c4 0c             	add    $0xc,%esp
    1d87:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1d8b:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1d8f:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1d93:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1d96:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1d9d:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1da0:	68 ff 00 00 00       	push   $0xff
    1da5:	68 bf 00 00 00       	push   $0xbf
    1daa:	6a 00                	push   $0x0
    1dac:	50                   	push   %eax
    1dad:	e8 de f8 ff ff       	call   1690 <RGB>
    1db2:	83 c4 0c             	add    $0xc,%esp
    1db5:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1db9:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1dbd:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1dc1:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1dc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc7:	8d 50 34             	lea    0x34(%eax),%edx
    1dca:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1dcd:	ff 75 d0             	pushl  -0x30(%ebp)
    1dd0:	ff 75 cc             	pushl  -0x34(%ebp)
    1dd3:	52                   	push   %edx
    1dd4:	50                   	push   %eax
    1dd5:	e8 ec f0 ff ff       	call   ec6 <APSetPen>
    1dda:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1ddd:	8b 45 08             	mov    0x8(%ebp),%eax
    1de0:	8d 58 34             	lea    0x34(%eax),%ebx
    1de3:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1de6:	83 ec 04             	sub    $0x4,%esp
    1de9:	83 ec 04             	sub    $0x4,%esp
    1dec:	89 e0                	mov    %esp,%eax
    1dee:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1df2:	66 89 08             	mov    %cx,(%eax)
    1df5:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1df9:	88 48 02             	mov    %cl,0x2(%eax)
    1dfc:	53                   	push   %ebx
    1dfd:	52                   	push   %edx
    1dfe:	e8 fc f0 ff ff       	call   eff <APSetBrush>
    1e03:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1e06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e09:	6b d0 32             	imul   $0x32,%eax,%edx
    1e0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e0f:	6b c0 32             	imul   $0x32,%eax,%eax
    1e12:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e15:	83 c1 34             	add    $0x34,%ecx
    1e18:	83 ec 0c             	sub    $0xc,%esp
    1e1b:	6a 32                	push   $0x32
    1e1d:	6a 32                	push   $0x32
    1e1f:	52                   	push   %edx
    1e20:	50                   	push   %eax
    1e21:	51                   	push   %ecx
    1e22:	e8 c0 f4 ff ff       	call   12e7 <APDrawRect>
    1e27:	83 c4 20             	add    $0x20,%esp
                    break;
    1e2a:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e2b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e2f:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e33:	0f 8e 17 fd ff ff    	jle    1b50 <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e39:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e3d:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e41:	0f 8e fd fc ff ff    	jle    1b44 <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1e47:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e4a:	5b                   	pop    %ebx
    1e4b:	5e                   	pop    %esi
    1e4c:	5f                   	pop    %edi
    1e4d:	5d                   	pop    %ebp
    1e4e:	c3                   	ret    

00001e4f <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e4f:	55                   	push   %ebp
    1e50:	89 e5                	mov    %esp,%ebp
    1e52:	53                   	push   %ebx
    1e53:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e56:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e5d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e61:	74 17                	je     1e7a <sprintint+0x2b>
    1e63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e67:	79 11                	jns    1e7a <sprintint+0x2b>
        neg = 1;
    1e69:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e70:	8b 45 10             	mov    0x10(%ebp),%eax
    1e73:	f7 d8                	neg    %eax
    1e75:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e78:	eb 06                	jmp    1e80 <sprintint+0x31>
    } else {
        x = xx;
    1e7a:	8b 45 10             	mov    0x10(%ebp),%eax
    1e7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e80:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1e87:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1e8a:	8d 41 01             	lea    0x1(%ecx),%eax
    1e8d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1e90:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1e93:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e96:	ba 00 00 00 00       	mov    $0x0,%edx
    1e9b:	f7 f3                	div    %ebx
    1e9d:	89 d0                	mov    %edx,%eax
    1e9f:	0f b6 80 a0 28 00 00 	movzbl 0x28a0(%eax),%eax
    1ea6:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1eaa:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ead:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1eb0:	ba 00 00 00 00       	mov    $0x0,%edx
    1eb5:	f7 f3                	div    %ebx
    1eb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1eba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ebe:	75 c7                	jne    1e87 <sprintint+0x38>
    if(neg)
    1ec0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ec4:	74 0e                	je     1ed4 <sprintint+0x85>
        buf[i++] = '-';
    1ec6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ec9:	8d 50 01             	lea    0x1(%eax),%edx
    1ecc:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1ecf:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1ed4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ed7:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1eda:	eb 1b                	jmp    1ef7 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1edc:	8b 45 0c             	mov    0xc(%ebp),%eax
    1edf:	8b 00                	mov    (%eax),%eax
    1ee1:	8d 48 01             	lea    0x1(%eax),%ecx
    1ee4:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ee7:	89 0a                	mov    %ecx,(%edx)
    1ee9:	89 c2                	mov    %eax,%edx
    1eeb:	8b 45 08             	mov    0x8(%ebp),%eax
    1eee:	01 d0                	add    %edx,%eax
    1ef0:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1ef3:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1ef7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1efb:	7f df                	jg     1edc <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1efd:	eb 21                	jmp    1f20 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1eff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f02:	8b 00                	mov    (%eax),%eax
    1f04:	8d 48 01             	lea    0x1(%eax),%ecx
    1f07:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f0a:	89 0a                	mov    %ecx,(%edx)
    1f0c:	89 c2                	mov    %eax,%edx
    1f0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f11:	01 c2                	add    %eax,%edx
    1f13:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1f16:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f19:	01 c8                	add    %ecx,%eax
    1f1b:	0f b6 00             	movzbl (%eax),%eax
    1f1e:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f20:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1f24:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1f28:	79 d5                	jns    1eff <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1f2a:	90                   	nop
    1f2b:	83 c4 20             	add    $0x20,%esp
    1f2e:	5b                   	pop    %ebx
    1f2f:	5d                   	pop    %ebp
    1f30:	c3                   	ret    

00001f31 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1f31:	55                   	push   %ebp
    1f32:	89 e5                	mov    %esp,%ebp
    1f34:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1f37:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1f3e:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1f45:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f4c:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f4f:	83 c0 04             	add    $0x4,%eax
    1f52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f55:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f5c:	e9 d9 01 00 00       	jmp    213a <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f61:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f64:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f67:	01 d0                	add    %edx,%eax
    1f69:	0f b6 00             	movzbl (%eax),%eax
    1f6c:	0f be c0             	movsbl %al,%eax
    1f6f:	25 ff 00 00 00       	and    $0xff,%eax
    1f74:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f77:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f7b:	75 2c                	jne    1fa9 <sprintf+0x78>
            if(c == '%'){
    1f7d:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f81:	75 0c                	jne    1f8f <sprintf+0x5e>
                state = '%';
    1f83:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1f8a:	e9 a7 01 00 00       	jmp    2136 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1f8f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1f92:	8d 50 01             	lea    0x1(%eax),%edx
    1f95:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1f98:	89 c2                	mov    %eax,%edx
    1f9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9d:	01 d0                	add    %edx,%eax
    1f9f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1fa2:	88 10                	mov    %dl,(%eax)
    1fa4:	e9 8d 01 00 00       	jmp    2136 <sprintf+0x205>
            }
        } else if(state == '%'){
    1fa9:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1fad:	0f 85 83 01 00 00    	jne    2136 <sprintf+0x205>
            if(c == 'd'){
    1fb3:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1fb7:	75 4c                	jne    2005 <sprintf+0xd4>
                buf[bi] = '\0';
    1fb9:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fbf:	01 d0                	add    %edx,%eax
    1fc1:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fc4:	83 ec 0c             	sub    $0xc,%esp
    1fc7:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1fca:	50                   	push   %eax
    1fcb:	e8 20 e5 ff ff       	call   4f0 <atoi>
    1fd0:	83 c4 10             	add    $0x10,%esp
    1fd3:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1fd6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1fdd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fe0:	8b 00                	mov    (%eax),%eax
    1fe2:	83 ec 08             	sub    $0x8,%esp
    1fe5:	ff 75 d8             	pushl  -0x28(%ebp)
    1fe8:	6a 01                	push   $0x1
    1fea:	6a 0a                	push   $0xa
    1fec:	50                   	push   %eax
    1fed:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1ff0:	50                   	push   %eax
    1ff1:	ff 75 08             	pushl  0x8(%ebp)
    1ff4:	e8 56 fe ff ff       	call   1e4f <sprintint>
    1ff9:	83 c4 20             	add    $0x20,%esp
                ap++;
    1ffc:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2000:	e9 2a 01 00 00       	jmp    212f <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2005:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2009:	74 06                	je     2011 <sprintf+0xe0>
    200b:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    200f:	75 4c                	jne    205d <sprintf+0x12c>
                buf[bi] = '\0';
    2011:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2014:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2017:	01 d0                	add    %edx,%eax
    2019:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    201c:	83 ec 0c             	sub    $0xc,%esp
    201f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2022:	50                   	push   %eax
    2023:	e8 c8 e4 ff ff       	call   4f0 <atoi>
    2028:	83 c4 10             	add    $0x10,%esp
    202b:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    202e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2035:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2038:	8b 00                	mov    (%eax),%eax
    203a:	83 ec 08             	sub    $0x8,%esp
    203d:	ff 75 dc             	pushl  -0x24(%ebp)
    2040:	6a 00                	push   $0x0
    2042:	6a 10                	push   $0x10
    2044:	50                   	push   %eax
    2045:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2048:	50                   	push   %eax
    2049:	ff 75 08             	pushl  0x8(%ebp)
    204c:	e8 fe fd ff ff       	call   1e4f <sprintint>
    2051:	83 c4 20             	add    $0x20,%esp
                ap++;
    2054:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2058:	e9 d2 00 00 00       	jmp    212f <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    205d:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2061:	75 46                	jne    20a9 <sprintf+0x178>
                s = (char*)*ap;
    2063:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2066:	8b 00                	mov    (%eax),%eax
    2068:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    206b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    206f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2073:	75 25                	jne    209a <sprintf+0x169>
                    s = "(null)";
    2075:	c7 45 f4 e8 22 00 00 	movl   $0x22e8,-0xc(%ebp)
                while(*s != 0){
    207c:	eb 1c                	jmp    209a <sprintf+0x169>
                    dst[j++] = *s;
    207e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2081:	8d 50 01             	lea    0x1(%eax),%edx
    2084:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2087:	89 c2                	mov    %eax,%edx
    2089:	8b 45 08             	mov    0x8(%ebp),%eax
    208c:	01 c2                	add    %eax,%edx
    208e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2091:	0f b6 00             	movzbl (%eax),%eax
    2094:	88 02                	mov    %al,(%edx)
                    s++;
    2096:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    209a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    209d:	0f b6 00             	movzbl (%eax),%eax
    20a0:	84 c0                	test   %al,%al
    20a2:	75 da                	jne    207e <sprintf+0x14d>
    20a4:	e9 86 00 00 00       	jmp    212f <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    20a9:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    20ad:	75 1d                	jne    20cc <sprintf+0x19b>
                dst[j++] = *ap;
    20af:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20b2:	8d 50 01             	lea    0x1(%eax),%edx
    20b5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20b8:	89 c2                	mov    %eax,%edx
    20ba:	8b 45 08             	mov    0x8(%ebp),%eax
    20bd:	01 c2                	add    %eax,%edx
    20bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20c2:	8b 00                	mov    (%eax),%eax
    20c4:	88 02                	mov    %al,(%edx)
                ap++;
    20c6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20ca:	eb 63                	jmp    212f <sprintf+0x1fe>
            } else if(c == '%'){
    20cc:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20d0:	75 17                	jne    20e9 <sprintf+0x1b8>
                dst[j++] = c;
    20d2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20d5:	8d 50 01             	lea    0x1(%eax),%edx
    20d8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20db:	89 c2                	mov    %eax,%edx
    20dd:	8b 45 08             	mov    0x8(%ebp),%eax
    20e0:	01 d0                	add    %edx,%eax
    20e2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    20e5:	88 10                	mov    %dl,(%eax)
    20e7:	eb 46                	jmp    212f <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    20e9:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    20ed:	7e 18                	jle    2107 <sprintf+0x1d6>
    20ef:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    20f3:	7f 12                	jg     2107 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    20f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20f8:	8d 50 01             	lea    0x1(%eax),%edx
    20fb:	89 55 f0             	mov    %edx,-0x10(%ebp)
    20fe:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2101:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2105:	eb 2f                	jmp    2136 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2107:	8b 45 c8             	mov    -0x38(%ebp),%eax
    210a:	8d 50 01             	lea    0x1(%eax),%edx
    210d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2110:	89 c2                	mov    %eax,%edx
    2112:	8b 45 08             	mov    0x8(%ebp),%eax
    2115:	01 d0                	add    %edx,%eax
    2117:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    211a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    211d:	8d 50 01             	lea    0x1(%eax),%edx
    2120:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2123:	89 c2                	mov    %eax,%edx
    2125:	8b 45 08             	mov    0x8(%ebp),%eax
    2128:	01 d0                	add    %edx,%eax
    212a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    212d:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    212f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2136:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    213a:	8b 55 0c             	mov    0xc(%ebp),%edx
    213d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2140:	01 d0                	add    %edx,%eax
    2142:	0f b6 00             	movzbl (%eax),%eax
    2145:	84 c0                	test   %al,%al
    2147:	0f 85 14 fe ff ff    	jne    1f61 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    214d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2150:	8d 50 01             	lea    0x1(%eax),%edx
    2153:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2156:	89 c2                	mov    %eax,%edx
    2158:	8b 45 08             	mov    0x8(%ebp),%eax
    215b:	01 d0                	add    %edx,%eax
    215d:	c6 00 00             	movb   $0x0,(%eax)
}
    2160:	90                   	nop
    2161:	c9                   	leave  
    2162:	c3                   	ret    
