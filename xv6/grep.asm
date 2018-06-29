
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
      18:	c7 45 f0 e0 6a 00 00 	movl   $0x6ae0,-0x10(%ebp)
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
      84:	81 7d f0 e0 6a 00 00 	cmpl   $0x6ae0,-0x10(%ebp)
      8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
      8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	ba e0 6a 00 00       	mov    $0x6ae0,%edx
      a2:	29 d0                	sub    %edx,%eax
      a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	ff 75 f4             	pushl  -0xc(%ebp)
      ad:	ff 75 f0             	pushl  -0x10(%ebp)
      b0:	68 e0 6a 00 00       	push   $0x6ae0
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
      ce:	05 e0 6a 00 00       	add    $0x6ae0,%eax
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
     10f:	68 9c 26 00 00       	push   $0x269c
     114:	6a 02                	push   $0x2
     116:	e8 16 06 00 00       	call   731 <printf>
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
     18c:	68 bc 26 00 00       	push   $0x26bc
     191:	6a 01                	push   $0x1
     193:	e8 99 05 00 00       	call   731 <printf>
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

0000064a <setupTimer>:
SYSCALL(setupTimer)
     64a:	b8 1b 00 00 00       	mov    $0x1b,%eax
     64f:	cd 40                	int    $0x40
     651:	c3                   	ret    

00000652 <deleteTimer>:
SYSCALL(deleteTimer)
     652:	b8 1c 00 00 00       	mov    $0x1c,%eax
     657:	cd 40                	int    $0x40
     659:	c3                   	ret    

0000065a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     65a:	55                   	push   %ebp
     65b:	89 e5                	mov    %esp,%ebp
     65d:	83 ec 18             	sub    $0x18,%esp
     660:	8b 45 0c             	mov    0xc(%ebp),%eax
     663:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     666:	83 ec 04             	sub    $0x4,%esp
     669:	6a 01                	push   $0x1
     66b:	8d 45 f4             	lea    -0xc(%ebp),%eax
     66e:	50                   	push   %eax
     66f:	ff 75 08             	pushl  0x8(%ebp)
     672:	e8 2b ff ff ff       	call   5a2 <write>
     677:	83 c4 10             	add    $0x10,%esp
}
     67a:	90                   	nop
     67b:	c9                   	leave  
     67c:	c3                   	ret    

0000067d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     67d:	55                   	push   %ebp
     67e:	89 e5                	mov    %esp,%ebp
     680:	53                   	push   %ebx
     681:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     684:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     68b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     68f:	74 17                	je     6a8 <printint+0x2b>
     691:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     695:	79 11                	jns    6a8 <printint+0x2b>
    neg = 1;
     697:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     69e:	8b 45 0c             	mov    0xc(%ebp),%eax
     6a1:	f7 d8                	neg    %eax
     6a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6a6:	eb 06                	jmp    6ae <printint+0x31>
  } else {
    x = xx;
     6a8:	8b 45 0c             	mov    0xc(%ebp),%eax
     6ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6b8:	8d 41 01             	lea    0x1(%ecx),%eax
     6bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6be:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6c4:	ba 00 00 00 00       	mov    $0x0,%edx
     6c9:	f7 f3                	div    %ebx
     6cb:	89 d0                	mov    %edx,%eax
     6cd:	0f b6 80 60 2e 00 00 	movzbl 0x2e60(%eax),%eax
     6d4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     6d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6db:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6de:	ba 00 00 00 00       	mov    $0x0,%edx
     6e3:	f7 f3                	div    %ebx
     6e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6ec:	75 c7                	jne    6b5 <printint+0x38>
  if(neg)
     6ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6f2:	74 2d                	je     721 <printint+0xa4>
    buf[i++] = '-';
     6f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f7:	8d 50 01             	lea    0x1(%eax),%edx
     6fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6fd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     702:	eb 1d                	jmp    721 <printint+0xa4>
    putc(fd, buf[i]);
     704:	8d 55 dc             	lea    -0x24(%ebp),%edx
     707:	8b 45 f4             	mov    -0xc(%ebp),%eax
     70a:	01 d0                	add    %edx,%eax
     70c:	0f b6 00             	movzbl (%eax),%eax
     70f:	0f be c0             	movsbl %al,%eax
     712:	83 ec 08             	sub    $0x8,%esp
     715:	50                   	push   %eax
     716:	ff 75 08             	pushl  0x8(%ebp)
     719:	e8 3c ff ff ff       	call   65a <putc>
     71e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     721:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     725:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     729:	79 d9                	jns    704 <printint+0x87>
    putc(fd, buf[i]);
}
     72b:	90                   	nop
     72c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     72f:	c9                   	leave  
     730:	c3                   	ret    

00000731 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     731:	55                   	push   %ebp
     732:	89 e5                	mov    %esp,%ebp
     734:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     737:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     73e:	8d 45 0c             	lea    0xc(%ebp),%eax
     741:	83 c0 04             	add    $0x4,%eax
     744:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     747:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     74e:	e9 59 01 00 00       	jmp    8ac <printf+0x17b>
    c = fmt[i] & 0xff;
     753:	8b 55 0c             	mov    0xc(%ebp),%edx
     756:	8b 45 f0             	mov    -0x10(%ebp),%eax
     759:	01 d0                	add    %edx,%eax
     75b:	0f b6 00             	movzbl (%eax),%eax
     75e:	0f be c0             	movsbl %al,%eax
     761:	25 ff 00 00 00       	and    $0xff,%eax
     766:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     769:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     76d:	75 2c                	jne    79b <printf+0x6a>
      if(c == '%'){
     76f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     773:	75 0c                	jne    781 <printf+0x50>
        state = '%';
     775:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     77c:	e9 27 01 00 00       	jmp    8a8 <printf+0x177>
      } else {
        putc(fd, c);
     781:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     784:	0f be c0             	movsbl %al,%eax
     787:	83 ec 08             	sub    $0x8,%esp
     78a:	50                   	push   %eax
     78b:	ff 75 08             	pushl  0x8(%ebp)
     78e:	e8 c7 fe ff ff       	call   65a <putc>
     793:	83 c4 10             	add    $0x10,%esp
     796:	e9 0d 01 00 00       	jmp    8a8 <printf+0x177>
      }
    } else if(state == '%'){
     79b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     79f:	0f 85 03 01 00 00    	jne    8a8 <printf+0x177>
      if(c == 'd'){
     7a5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7a9:	75 1e                	jne    7c9 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7ae:	8b 00                	mov    (%eax),%eax
     7b0:	6a 01                	push   $0x1
     7b2:	6a 0a                	push   $0xa
     7b4:	50                   	push   %eax
     7b5:	ff 75 08             	pushl  0x8(%ebp)
     7b8:	e8 c0 fe ff ff       	call   67d <printint>
     7bd:	83 c4 10             	add    $0x10,%esp
        ap++;
     7c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7c4:	e9 d8 00 00 00       	jmp    8a1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7c9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7cd:	74 06                	je     7d5 <printf+0xa4>
     7cf:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7d3:	75 1e                	jne    7f3 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7d8:	8b 00                	mov    (%eax),%eax
     7da:	6a 00                	push   $0x0
     7dc:	6a 10                	push   $0x10
     7de:	50                   	push   %eax
     7df:	ff 75 08             	pushl  0x8(%ebp)
     7e2:	e8 96 fe ff ff       	call   67d <printint>
     7e7:	83 c4 10             	add    $0x10,%esp
        ap++;
     7ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7ee:	e9 ae 00 00 00       	jmp    8a1 <printf+0x170>
      } else if(c == 's'){
     7f3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     7f7:	75 43                	jne    83c <printf+0x10b>
        s = (char*)*ap;
     7f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7fc:	8b 00                	mov    (%eax),%eax
     7fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     801:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     805:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     809:	75 25                	jne    830 <printf+0xff>
          s = "(null)";
     80b:	c7 45 f4 d2 26 00 00 	movl   $0x26d2,-0xc(%ebp)
        while(*s != 0){
     812:	eb 1c                	jmp    830 <printf+0xff>
          putc(fd, *s);
     814:	8b 45 f4             	mov    -0xc(%ebp),%eax
     817:	0f b6 00             	movzbl (%eax),%eax
     81a:	0f be c0             	movsbl %al,%eax
     81d:	83 ec 08             	sub    $0x8,%esp
     820:	50                   	push   %eax
     821:	ff 75 08             	pushl  0x8(%ebp)
     824:	e8 31 fe ff ff       	call   65a <putc>
     829:	83 c4 10             	add    $0x10,%esp
          s++;
     82c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     830:	8b 45 f4             	mov    -0xc(%ebp),%eax
     833:	0f b6 00             	movzbl (%eax),%eax
     836:	84 c0                	test   %al,%al
     838:	75 da                	jne    814 <printf+0xe3>
     83a:	eb 65                	jmp    8a1 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     83c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     840:	75 1d                	jne    85f <printf+0x12e>
        putc(fd, *ap);
     842:	8b 45 e8             	mov    -0x18(%ebp),%eax
     845:	8b 00                	mov    (%eax),%eax
     847:	0f be c0             	movsbl %al,%eax
     84a:	83 ec 08             	sub    $0x8,%esp
     84d:	50                   	push   %eax
     84e:	ff 75 08             	pushl  0x8(%ebp)
     851:	e8 04 fe ff ff       	call   65a <putc>
     856:	83 c4 10             	add    $0x10,%esp
        ap++;
     859:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     85d:	eb 42                	jmp    8a1 <printf+0x170>
      } else if(c == '%'){
     85f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     863:	75 17                	jne    87c <printf+0x14b>
        putc(fd, c);
     865:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     868:	0f be c0             	movsbl %al,%eax
     86b:	83 ec 08             	sub    $0x8,%esp
     86e:	50                   	push   %eax
     86f:	ff 75 08             	pushl  0x8(%ebp)
     872:	e8 e3 fd ff ff       	call   65a <putc>
     877:	83 c4 10             	add    $0x10,%esp
     87a:	eb 25                	jmp    8a1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     87c:	83 ec 08             	sub    $0x8,%esp
     87f:	6a 25                	push   $0x25
     881:	ff 75 08             	pushl  0x8(%ebp)
     884:	e8 d1 fd ff ff       	call   65a <putc>
     889:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     88c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     88f:	0f be c0             	movsbl %al,%eax
     892:	83 ec 08             	sub    $0x8,%esp
     895:	50                   	push   %eax
     896:	ff 75 08             	pushl  0x8(%ebp)
     899:	e8 bc fd ff ff       	call   65a <putc>
     89e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8a8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8ac:	8b 55 0c             	mov    0xc(%ebp),%edx
     8af:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8b2:	01 d0                	add    %edx,%eax
     8b4:	0f b6 00             	movzbl (%eax),%eax
     8b7:	84 c0                	test   %al,%al
     8b9:	0f 85 94 fe ff ff    	jne    753 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8bf:	90                   	nop
     8c0:	c9                   	leave  
     8c1:	c3                   	ret    

000008c2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8c2:	55                   	push   %ebp
     8c3:	89 e5                	mov    %esp,%ebp
     8c5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8c8:	8b 45 08             	mov    0x8(%ebp),%eax
     8cb:	83 e8 08             	sub    $0x8,%eax
     8ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8d1:	a1 c8 6a 00 00       	mov    0x6ac8,%eax
     8d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8d9:	eb 24                	jmp    8ff <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8de:	8b 00                	mov    (%eax),%eax
     8e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8e3:	77 12                	ja     8f7 <free+0x35>
     8e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8e8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8eb:	77 24                	ja     911 <free+0x4f>
     8ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f0:	8b 00                	mov    (%eax),%eax
     8f2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     8f5:	77 1a                	ja     911 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8fa:	8b 00                	mov    (%eax),%eax
     8fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
     902:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     905:	76 d4                	jbe    8db <free+0x19>
     907:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90a:	8b 00                	mov    (%eax),%eax
     90c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     90f:	76 ca                	jbe    8db <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     911:	8b 45 f8             	mov    -0x8(%ebp),%eax
     914:	8b 40 04             	mov    0x4(%eax),%eax
     917:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     91e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     921:	01 c2                	add    %eax,%edx
     923:	8b 45 fc             	mov    -0x4(%ebp),%eax
     926:	8b 00                	mov    (%eax),%eax
     928:	39 c2                	cmp    %eax,%edx
     92a:	75 24                	jne    950 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     92c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92f:	8b 50 04             	mov    0x4(%eax),%edx
     932:	8b 45 fc             	mov    -0x4(%ebp),%eax
     935:	8b 00                	mov    (%eax),%eax
     937:	8b 40 04             	mov    0x4(%eax),%eax
     93a:	01 c2                	add    %eax,%edx
     93c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     942:	8b 45 fc             	mov    -0x4(%ebp),%eax
     945:	8b 00                	mov    (%eax),%eax
     947:	8b 10                	mov    (%eax),%edx
     949:	8b 45 f8             	mov    -0x8(%ebp),%eax
     94c:	89 10                	mov    %edx,(%eax)
     94e:	eb 0a                	jmp    95a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     950:	8b 45 fc             	mov    -0x4(%ebp),%eax
     953:	8b 10                	mov    (%eax),%edx
     955:	8b 45 f8             	mov    -0x8(%ebp),%eax
     958:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     95a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95d:	8b 40 04             	mov    0x4(%eax),%eax
     960:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     967:	8b 45 fc             	mov    -0x4(%ebp),%eax
     96a:	01 d0                	add    %edx,%eax
     96c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     96f:	75 20                	jne    991 <free+0xcf>
    p->s.size += bp->s.size;
     971:	8b 45 fc             	mov    -0x4(%ebp),%eax
     974:	8b 50 04             	mov    0x4(%eax),%edx
     977:	8b 45 f8             	mov    -0x8(%ebp),%eax
     97a:	8b 40 04             	mov    0x4(%eax),%eax
     97d:	01 c2                	add    %eax,%edx
     97f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     982:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     985:	8b 45 f8             	mov    -0x8(%ebp),%eax
     988:	8b 10                	mov    (%eax),%edx
     98a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98d:	89 10                	mov    %edx,(%eax)
     98f:	eb 08                	jmp    999 <free+0xd7>
  } else
    p->s.ptr = bp;
     991:	8b 45 fc             	mov    -0x4(%ebp),%eax
     994:	8b 55 f8             	mov    -0x8(%ebp),%edx
     997:	89 10                	mov    %edx,(%eax)
  freep = p;
     999:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99c:	a3 c8 6a 00 00       	mov    %eax,0x6ac8
}
     9a1:	90                   	nop
     9a2:	c9                   	leave  
     9a3:	c3                   	ret    

000009a4 <morecore>:

static Header*
morecore(uint nu)
{
     9a4:	55                   	push   %ebp
     9a5:	89 e5                	mov    %esp,%ebp
     9a7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9aa:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9b1:	77 07                	ja     9ba <morecore+0x16>
    nu = 4096;
     9b3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9ba:	8b 45 08             	mov    0x8(%ebp),%eax
     9bd:	c1 e0 03             	shl    $0x3,%eax
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	50                   	push   %eax
     9c4:	e8 41 fc ff ff       	call   60a <sbrk>
     9c9:	83 c4 10             	add    $0x10,%esp
     9cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9cf:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9d3:	75 07                	jne    9dc <morecore+0x38>
    return 0;
     9d5:	b8 00 00 00 00       	mov    $0x0,%eax
     9da:	eb 26                	jmp    a02 <morecore+0x5e>
  hp = (Header*)p;
     9dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9e5:	8b 55 08             	mov    0x8(%ebp),%edx
     9e8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9ee:	83 c0 08             	add    $0x8,%eax
     9f1:	83 ec 0c             	sub    $0xc,%esp
     9f4:	50                   	push   %eax
     9f5:	e8 c8 fe ff ff       	call   8c2 <free>
     9fa:	83 c4 10             	add    $0x10,%esp
  return freep;
     9fd:	a1 c8 6a 00 00       	mov    0x6ac8,%eax
}
     a02:	c9                   	leave  
     a03:	c3                   	ret    

00000a04 <malloc>:

void*
malloc(uint nbytes)
{
     a04:	55                   	push   %ebp
     a05:	89 e5                	mov    %esp,%ebp
     a07:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a0a:	8b 45 08             	mov    0x8(%ebp),%eax
     a0d:	83 c0 07             	add    $0x7,%eax
     a10:	c1 e8 03             	shr    $0x3,%eax
     a13:	83 c0 01             	add    $0x1,%eax
     a16:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a19:	a1 c8 6a 00 00       	mov    0x6ac8,%eax
     a1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a21:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a25:	75 23                	jne    a4a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a27:	c7 45 f0 c0 6a 00 00 	movl   $0x6ac0,-0x10(%ebp)
     a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a31:	a3 c8 6a 00 00       	mov    %eax,0x6ac8
     a36:	a1 c8 6a 00 00       	mov    0x6ac8,%eax
     a3b:	a3 c0 6a 00 00       	mov    %eax,0x6ac0
    base.s.size = 0;
     a40:	c7 05 c4 6a 00 00 00 	movl   $0x0,0x6ac4
     a47:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4d:	8b 00                	mov    (%eax),%eax
     a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a55:	8b 40 04             	mov    0x4(%eax),%eax
     a58:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a5b:	72 4d                	jb     aaa <malloc+0xa6>
      if(p->s.size == nunits)
     a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a60:	8b 40 04             	mov    0x4(%eax),%eax
     a63:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a66:	75 0c                	jne    a74 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a68:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a6b:	8b 10                	mov    (%eax),%edx
     a6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a70:	89 10                	mov    %edx,(%eax)
     a72:	eb 26                	jmp    a9a <malloc+0x96>
      else {
        p->s.size -= nunits;
     a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a77:	8b 40 04             	mov    0x4(%eax),%eax
     a7a:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a7d:	89 c2                	mov    %eax,%edx
     a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a82:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a88:	8b 40 04             	mov    0x4(%eax),%eax
     a8b:	c1 e0 03             	shl    $0x3,%eax
     a8e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a94:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a97:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     a9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a9d:	a3 c8 6a 00 00       	mov    %eax,0x6ac8
      return (void*)(p + 1);
     aa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa5:	83 c0 08             	add    $0x8,%eax
     aa8:	eb 3b                	jmp    ae5 <malloc+0xe1>
    }
    if(p == freep)
     aaa:	a1 c8 6a 00 00       	mov    0x6ac8,%eax
     aaf:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ab2:	75 1e                	jne    ad2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     ab4:	83 ec 0c             	sub    $0xc,%esp
     ab7:	ff 75 ec             	pushl  -0x14(%ebp)
     aba:	e8 e5 fe ff ff       	call   9a4 <morecore>
     abf:	83 c4 10             	add    $0x10,%esp
     ac2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ac5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ac9:	75 07                	jne    ad2 <malloc+0xce>
        return 0;
     acb:	b8 00 00 00 00       	mov    $0x0,%eax
     ad0:	eb 13                	jmp    ae5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adb:	8b 00                	mov    (%eax),%eax
     add:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     ae0:	e9 6d ff ff ff       	jmp    a52 <malloc+0x4e>
}
     ae5:	c9                   	leave  
     ae6:	c3                   	ret    

00000ae7 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     ae7:	55                   	push   %ebp
     ae8:	89 e5                	mov    %esp,%ebp
     aea:	83 ec 1c             	sub    $0x1c,%esp
     aed:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     af0:	8b 55 10             	mov    0x10(%ebp),%edx
     af3:	8b 45 14             	mov    0x14(%ebp),%eax
     af6:	88 4d ec             	mov    %cl,-0x14(%ebp)
     af9:	88 55 e8             	mov    %dl,-0x18(%ebp)
     afc:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     aff:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b03:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b06:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b0a:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b0d:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b11:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b14:	8b 45 08             	mov    0x8(%ebp),%eax
     b17:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b1b:	66 89 10             	mov    %dx,(%eax)
     b1e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b22:	88 50 02             	mov    %dl,0x2(%eax)
}
     b25:	8b 45 08             	mov    0x8(%ebp),%eax
     b28:	c9                   	leave  
     b29:	c2 04 00             	ret    $0x4

00000b2c <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b2c:	55                   	push   %ebp
     b2d:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b2f:	8b 45 08             	mov    0x8(%ebp),%eax
     b32:	2b 45 10             	sub    0x10(%ebp),%eax
     b35:	89 c2                	mov    %eax,%edx
     b37:	8b 45 08             	mov    0x8(%ebp),%eax
     b3a:	2b 45 10             	sub    0x10(%ebp),%eax
     b3d:	0f af d0             	imul   %eax,%edx
     b40:	8b 45 0c             	mov    0xc(%ebp),%eax
     b43:	2b 45 14             	sub    0x14(%ebp),%eax
     b46:	89 c1                	mov    %eax,%ecx
     b48:	8b 45 0c             	mov    0xc(%ebp),%eax
     b4b:	2b 45 14             	sub    0x14(%ebp),%eax
     b4e:	0f af c1             	imul   %ecx,%eax
     b51:	01 d0                	add    %edx,%eax
}
     b53:	5d                   	pop    %ebp
     b54:	c3                   	ret    

00000b55 <abs_int>:

static inline int abs_int(int x)
{
     b55:	55                   	push   %ebp
     b56:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b58:	8b 45 08             	mov    0x8(%ebp),%eax
     b5b:	99                   	cltd   
     b5c:	89 d0                	mov    %edx,%eax
     b5e:	33 45 08             	xor    0x8(%ebp),%eax
     b61:	29 d0                	sub    %edx,%eax
}
     b63:	5d                   	pop    %ebp
     b64:	c3                   	ret    

00000b65 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b65:	55                   	push   %ebp
     b66:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b6c:	79 07                	jns    b75 <APGetIndex+0x10>
        return X_SMALLER;
     b6e:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b73:	eb 40                	jmp    bb5 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     b75:	8b 45 08             	mov    0x8(%ebp),%eax
     b78:	8b 00                	mov    (%eax),%eax
     b7a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     b7d:	7f 07                	jg     b86 <APGetIndex+0x21>
        return X_BIGGER;
     b7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b84:	eb 2f                	jmp    bb5 <APGetIndex+0x50>
    if (y < 0)
     b86:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     b8a:	79 07                	jns    b93 <APGetIndex+0x2e>
        return Y_SMALLER;
     b8c:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     b91:	eb 22                	jmp    bb5 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     b93:	8b 45 08             	mov    0x8(%ebp),%eax
     b96:	8b 40 04             	mov    0x4(%eax),%eax
     b99:	3b 45 10             	cmp    0x10(%ebp),%eax
     b9c:	7f 07                	jg     ba5 <APGetIndex+0x40>
        return Y_BIGGER;
     b9e:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     ba3:	eb 10                	jmp    bb5 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     ba5:	8b 45 08             	mov    0x8(%ebp),%eax
     ba8:	8b 00                	mov    (%eax),%eax
     baa:	0f af 45 10          	imul   0x10(%ebp),%eax
     bae:	89 c2                	mov    %eax,%edx
     bb0:	8b 45 0c             	mov    0xc(%ebp),%eax
     bb3:	01 d0                	add    %edx,%eax
}
     bb5:	5d                   	pop    %ebp
     bb6:	c3                   	ret    

00000bb7 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     bb7:	55                   	push   %ebp
     bb8:	89 e5                	mov    %esp,%ebp
     bba:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bbd:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bc4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bc7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bca:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bd1:	83 ec 08             	sub    $0x8,%esp
     bd4:	6a 00                	push   $0x0
     bd6:	ff 75 0c             	pushl  0xc(%ebp)
     bd9:	e8 e4 f9 ff ff       	call   5c2 <open>
     bde:	83 c4 10             	add    $0x10,%esp
     be1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     be4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     be8:	79 2e                	jns    c18 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     bea:	83 ec 04             	sub    $0x4,%esp
     bed:	ff 75 0c             	pushl  0xc(%ebp)
     bf0:	68 d9 26 00 00       	push   $0x26d9
     bf5:	6a 01                	push   $0x1
     bf7:	e8 35 fb ff ff       	call   731 <printf>
     bfc:	83 c4 10             	add    $0x10,%esp
        return bmp;
     bff:	8b 45 08             	mov    0x8(%ebp),%eax
     c02:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c05:	89 10                	mov    %edx,(%eax)
     c07:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c0a:	89 50 04             	mov    %edx,0x4(%eax)
     c0d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c10:	89 50 08             	mov    %edx,0x8(%eax)
     c13:	e9 d2 01 00 00       	jmp    dea <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c18:	83 ec 04             	sub    $0x4,%esp
     c1b:	6a 0e                	push   $0xe
     c1d:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c20:	50                   	push   %eax
     c21:	ff 75 ec             	pushl  -0x14(%ebp)
     c24:	e8 71 f9 ff ff       	call   59a <read>
     c29:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c2c:	83 ec 04             	sub    $0x4,%esp
     c2f:	6a 28                	push   $0x28
     c31:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c34:	50                   	push   %eax
     c35:	ff 75 ec             	pushl  -0x14(%ebp)
     c38:	e8 5d f9 ff ff       	call   59a <read>
     c3d:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c40:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c43:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c46:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c49:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c4c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c4f:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c52:	0f af d0             	imul   %eax,%edx
     c55:	89 d0                	mov    %edx,%eax
     c57:	01 c0                	add    %eax,%eax
     c59:	01 d0                	add    %edx,%eax
     c5b:	83 ec 0c             	sub    $0xc,%esp
     c5e:	50                   	push   %eax
     c5f:	e8 a0 fd ff ff       	call   a04 <malloc>
     c64:	83 c4 10             	add    $0x10,%esp
     c67:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c6a:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c6e:	0f b7 c0             	movzwl %ax,%eax
     c71:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c74:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c77:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c7a:	0f af c2             	imul   %edx,%eax
     c7d:	83 c0 1f             	add    $0x1f,%eax
     c80:	c1 e8 05             	shr    $0x5,%eax
     c83:	c1 e0 02             	shl    $0x2,%eax
     c86:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     c89:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c8c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c8f:	0f af c2             	imul   %edx,%eax
     c92:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     c95:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c98:	83 ec 0c             	sub    $0xc,%esp
     c9b:	50                   	push   %eax
     c9c:	e8 63 fd ff ff       	call   a04 <malloc>
     ca1:	83 c4 10             	add    $0x10,%esp
     ca4:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     ca7:	83 ec 04             	sub    $0x4,%esp
     caa:	ff 75 e0             	pushl  -0x20(%ebp)
     cad:	ff 75 dc             	pushl  -0x24(%ebp)
     cb0:	ff 75 ec             	pushl  -0x14(%ebp)
     cb3:	e8 e2 f8 ff ff       	call   59a <read>
     cb8:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     cbb:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     cbf:	66 c1 e8 03          	shr    $0x3,%ax
     cc3:	0f b7 c0             	movzwl %ax,%eax
     cc6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     cc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cd0:	e9 e5 00 00 00       	jmp    dba <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     cd5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cdb:	29 c2                	sub    %eax,%edx
     cdd:	89 d0                	mov    %edx,%eax
     cdf:	8d 50 ff             	lea    -0x1(%eax),%edx
     ce2:	8b 45 c8             	mov    -0x38(%ebp),%eax
     ce5:	0f af c2             	imul   %edx,%eax
     ce8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     ceb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cf2:	e9 b1 00 00 00       	jmp    da8 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     cf7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     cfa:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     cfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d00:	01 c8                	add    %ecx,%eax
     d02:	89 c1                	mov    %eax,%ecx
     d04:	89 c8                	mov    %ecx,%eax
     d06:	01 c0                	add    %eax,%eax
     d08:	01 c8                	add    %ecx,%eax
     d0a:	01 c2                	add    %eax,%edx
     d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d0f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d13:	89 c1                	mov    %eax,%ecx
     d15:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d18:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d1c:	01 c1                	add    %eax,%ecx
     d1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d21:	01 c8                	add    %ecx,%eax
     d23:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d26:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d29:	01 c8                	add    %ecx,%eax
     d2b:	0f b6 00             	movzbl (%eax),%eax
     d2e:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d31:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d34:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d37:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d3a:	01 c8                	add    %ecx,%eax
     d3c:	89 c1                	mov    %eax,%ecx
     d3e:	89 c8                	mov    %ecx,%eax
     d40:	01 c0                	add    %eax,%eax
     d42:	01 c8                	add    %ecx,%eax
     d44:	01 c2                	add    %eax,%edx
     d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d49:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d4d:	89 c1                	mov    %eax,%ecx
     d4f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d52:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d56:	01 c1                	add    %eax,%ecx
     d58:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d5b:	01 c8                	add    %ecx,%eax
     d5d:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d60:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d63:	01 c8                	add    %ecx,%eax
     d65:	0f b6 00             	movzbl (%eax),%eax
     d68:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d6b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d6e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d71:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d74:	01 c8                	add    %ecx,%eax
     d76:	89 c1                	mov    %eax,%ecx
     d78:	89 c8                	mov    %ecx,%eax
     d7a:	01 c0                	add    %eax,%eax
     d7c:	01 c8                	add    %ecx,%eax
     d7e:	01 c2                	add    %eax,%edx
     d80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d83:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d87:	89 c1                	mov    %eax,%ecx
     d89:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d8c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d90:	01 c1                	add    %eax,%ecx
     d92:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d95:	01 c8                	add    %ecx,%eax
     d97:	8d 48 fd             	lea    -0x3(%eax),%ecx
     d9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d9d:	01 c8                	add    %ecx,%eax
     d9f:	0f b6 00             	movzbl (%eax),%eax
     da2:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     da4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     da8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dae:	39 c2                	cmp    %eax,%edx
     db0:	0f 87 41 ff ff ff    	ja     cf7 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     db6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dba:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dc0:	39 c2                	cmp    %eax,%edx
     dc2:	0f 87 0d ff ff ff    	ja     cd5 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     dc8:	83 ec 0c             	sub    $0xc,%esp
     dcb:	ff 75 ec             	pushl  -0x14(%ebp)
     dce:	e8 d7 f7 ff ff       	call   5aa <close>
     dd3:	83 c4 10             	add    $0x10,%esp
    return bmp;
     dd6:	8b 45 08             	mov    0x8(%ebp),%eax
     dd9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ddc:	89 10                	mov    %edx,(%eax)
     dde:	8b 55 cc             	mov    -0x34(%ebp),%edx
     de1:	89 50 04             	mov    %edx,0x4(%eax)
     de4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     de7:	89 50 08             	mov    %edx,0x8(%eax)
}
     dea:	8b 45 08             	mov    0x8(%ebp),%eax
     ded:	c9                   	leave  
     dee:	c2 04 00             	ret    $0x4

00000df1 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     df1:	55                   	push   %ebp
     df2:	89 e5                	mov    %esp,%ebp
     df4:	53                   	push   %ebx
     df5:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     df8:	83 ec 0c             	sub    $0xc,%esp
     dfb:	6a 1c                	push   $0x1c
     dfd:	e8 02 fc ff ff       	call   a04 <malloc>
     e02:	83 c4 10             	add    $0x10,%esp
     e05:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e0b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e12:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e15:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e18:	6a 0c                	push   $0xc
     e1a:	6a 0c                	push   $0xc
     e1c:	6a 0c                	push   $0xc
     e1e:	50                   	push   %eax
     e1f:	e8 c3 fc ff ff       	call   ae7 <RGB>
     e24:	83 c4 0c             	add    $0xc,%esp
     e27:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e2b:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e2f:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e33:	88 43 15             	mov    %al,0x15(%ebx)
     e36:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e39:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e3c:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e40:	66 89 48 10          	mov    %cx,0x10(%eax)
     e44:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e48:	88 50 12             	mov    %dl,0x12(%eax)
     e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e51:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e55:	66 89 48 08          	mov    %cx,0x8(%eax)
     e59:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e5d:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e60:	8b 45 08             	mov    0x8(%ebp),%eax
     e63:	89 c2                	mov    %eax,%edx
     e65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e68:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e6d:	89 c2                	mov    %eax,%edx
     e6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e72:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     e75:	8b 55 10             	mov    0x10(%ebp),%edx
     e78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e7b:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     e7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e84:	c9                   	leave  
     e85:	c3                   	ret    

00000e86 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     e86:	55                   	push   %ebp
     e87:	89 e5                	mov    %esp,%ebp
     e89:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     e8c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e8f:	8b 50 08             	mov    0x8(%eax),%edx
     e92:	89 55 f8             	mov    %edx,-0x8(%ebp)
     e95:	8b 40 0c             	mov    0xc(%eax),%eax
     e98:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9e:	8b 55 10             	mov    0x10(%ebp),%edx
     ea1:	89 50 08             	mov    %edx,0x8(%eax)
     ea4:	8b 55 14             	mov    0x14(%ebp),%edx
     ea7:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     eaa:	8b 45 08             	mov    0x8(%ebp),%eax
     ead:	8b 55 f8             	mov    -0x8(%ebp),%edx
     eb0:	89 10                	mov    %edx,(%eax)
     eb2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     eb5:	89 50 04             	mov    %edx,0x4(%eax)
}
     eb8:	8b 45 08             	mov    0x8(%ebp),%eax
     ebb:	c9                   	leave  
     ebc:	c2 04 00             	ret    $0x4

00000ebf <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ebf:	55                   	push   %ebp
     ec0:	89 e5                	mov    %esp,%ebp
     ec2:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec8:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ecc:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ed0:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ed4:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ed7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eda:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     ede:	66 89 50 10          	mov    %dx,0x10(%eax)
     ee2:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     ee6:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     ee9:	8b 45 08             	mov    0x8(%ebp),%eax
     eec:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     ef0:	66 89 10             	mov    %dx,(%eax)
     ef3:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     ef7:	88 50 02             	mov    %dl,0x2(%eax)
}
     efa:	8b 45 08             	mov    0x8(%ebp),%eax
     efd:	c9                   	leave  
     efe:	c2 04 00             	ret    $0x4

00000f01 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     f01:	55                   	push   %ebp
     f02:	89 e5                	mov    %esp,%ebp
     f04:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     f07:	8b 45 0c             	mov    0xc(%ebp),%eax
     f0a:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     f0e:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f12:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     f16:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     f19:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1c:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f20:	66 89 50 13          	mov    %dx,0x13(%eax)
     f24:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f28:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     f2b:	8b 45 08             	mov    0x8(%ebp),%eax
     f2e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f32:	66 89 10             	mov    %dx,(%eax)
     f35:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f39:	88 50 02             	mov    %dl,0x2(%eax)
}
     f3c:	8b 45 08             	mov    0x8(%ebp),%eax
     f3f:	c9                   	leave  
     f40:	c2 04 00             	ret    $0x4

00000f43 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f43:	55                   	push   %ebp
     f44:	89 e5                	mov    %esp,%ebp
     f46:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f49:	8b 45 08             	mov    0x8(%ebp),%eax
     f4c:	8b 40 0c             	mov    0xc(%eax),%eax
     f4f:	89 c2                	mov    %eax,%edx
     f51:	c1 ea 1f             	shr    $0x1f,%edx
     f54:	01 d0                	add    %edx,%eax
     f56:	d1 f8                	sar    %eax
     f58:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f5e:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f62:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f65:	8b 45 10             	mov    0x10(%ebp),%eax
     f68:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f6e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f72:	0f 89 98 00 00 00    	jns    1010 <APDrawPoint+0xcd>
        i = 0;
     f78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f7f:	e9 8c 00 00 00       	jmp    1010 <APDrawPoint+0xcd>
    {
        j = x - off;
     f84:	8b 45 0c             	mov    0xc(%ebp),%eax
     f87:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f8d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f91:	79 69                	jns    ffc <APDrawPoint+0xb9>
            j = 0;
     f93:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f9a:	eb 60                	jmp    ffc <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f9c:	ff 75 fc             	pushl  -0x4(%ebp)
     f9f:	ff 75 f8             	pushl  -0x8(%ebp)
     fa2:	ff 75 08             	pushl  0x8(%ebp)
     fa5:	e8 bb fb ff ff       	call   b65 <APGetIndex>
     faa:	83 c4 0c             	add    $0xc,%esp
     fad:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     fb0:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     fb4:	74 55                	je     100b <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     fb6:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     fba:	74 67                	je     1023 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     fbc:	ff 75 10             	pushl  0x10(%ebp)
     fbf:	ff 75 0c             	pushl  0xc(%ebp)
     fc2:	ff 75 fc             	pushl  -0x4(%ebp)
     fc5:	ff 75 f8             	pushl  -0x8(%ebp)
     fc8:	e8 5f fb ff ff       	call   b2c <distance_2>
     fcd:	83 c4 10             	add    $0x10,%esp
     fd0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fd3:	7f 23                	jg     ff8 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     fd5:	8b 45 08             	mov    0x8(%ebp),%eax
     fd8:	8b 48 18             	mov    0x18(%eax),%ecx
     fdb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fde:	89 d0                	mov    %edx,%eax
     fe0:	01 c0                	add    %eax,%eax
     fe2:	01 d0                	add    %edx,%eax
     fe4:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     fe7:	8b 45 08             	mov    0x8(%ebp),%eax
     fea:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     fee:	66 89 0a             	mov    %cx,(%edx)
     ff1:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     ff5:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     ff8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     ffc:	8b 55 0c             	mov    0xc(%ebp),%edx
     fff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1002:	01 d0                	add    %edx,%eax
    1004:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1007:	7d 93                	jge    f9c <APDrawPoint+0x59>
    1009:	eb 01                	jmp    100c <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    100b:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    100c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1010:	8b 55 10             	mov    0x10(%ebp),%edx
    1013:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1016:	01 d0                	add    %edx,%eax
    1018:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    101b:	0f 8d 63 ff ff ff    	jge    f84 <APDrawPoint+0x41>
    1021:	eb 01                	jmp    1024 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1023:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1024:	c9                   	leave  
    1025:	c3                   	ret    

00001026 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1026:	55                   	push   %ebp
    1027:	89 e5                	mov    %esp,%ebp
    1029:	53                   	push   %ebx
    102a:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    102d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1030:	3b 45 14             	cmp    0x14(%ebp),%eax
    1033:	0f 85 80 00 00 00    	jne    10b9 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1039:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    103d:	0f 88 9d 02 00 00    	js     12e0 <APDrawLine+0x2ba>
    1043:	8b 45 08             	mov    0x8(%ebp),%eax
    1046:	8b 00                	mov    (%eax),%eax
    1048:	3b 45 0c             	cmp    0xc(%ebp),%eax
    104b:	0f 8e 8f 02 00 00    	jle    12e0 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1051:	8b 45 10             	mov    0x10(%ebp),%eax
    1054:	3b 45 18             	cmp    0x18(%ebp),%eax
    1057:	7e 12                	jle    106b <APDrawLine+0x45>
        {
            int tmp = y2;
    1059:	8b 45 18             	mov    0x18(%ebp),%eax
    105c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    105f:	8b 45 10             	mov    0x10(%ebp),%eax
    1062:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1065:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1068:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    106b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    106f:	79 07                	jns    1078 <APDrawLine+0x52>
    1071:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1078:	8b 45 08             	mov    0x8(%ebp),%eax
    107b:	8b 40 04             	mov    0x4(%eax),%eax
    107e:	3b 45 18             	cmp    0x18(%ebp),%eax
    1081:	7d 0c                	jge    108f <APDrawLine+0x69>
    1083:	8b 45 08             	mov    0x8(%ebp),%eax
    1086:	8b 40 04             	mov    0x4(%eax),%eax
    1089:	83 e8 01             	sub    $0x1,%eax
    108c:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    108f:	8b 45 10             	mov    0x10(%ebp),%eax
    1092:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1095:	eb 15                	jmp    10ac <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1097:	ff 75 f4             	pushl  -0xc(%ebp)
    109a:	ff 75 0c             	pushl  0xc(%ebp)
    109d:	ff 75 08             	pushl  0x8(%ebp)
    10a0:	e8 9e fe ff ff       	call   f43 <APDrawPoint>
    10a5:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10af:	3b 45 18             	cmp    0x18(%ebp),%eax
    10b2:	7e e3                	jle    1097 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10b4:	e9 2b 02 00 00       	jmp    12e4 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10b9:	8b 45 10             	mov    0x10(%ebp),%eax
    10bc:	3b 45 18             	cmp    0x18(%ebp),%eax
    10bf:	75 7f                	jne    1140 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    10c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10c5:	0f 88 18 02 00 00    	js     12e3 <APDrawLine+0x2bd>
    10cb:	8b 45 08             	mov    0x8(%ebp),%eax
    10ce:	8b 40 04             	mov    0x4(%eax),%eax
    10d1:	3b 45 10             	cmp    0x10(%ebp),%eax
    10d4:	0f 8e 09 02 00 00    	jle    12e3 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10da:	8b 45 0c             	mov    0xc(%ebp),%eax
    10dd:	3b 45 14             	cmp    0x14(%ebp),%eax
    10e0:	7e 12                	jle    10f4 <APDrawLine+0xce>
        {
            int tmp = x2;
    10e2:	8b 45 14             	mov    0x14(%ebp),%eax
    10e5:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    10e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    10eb:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10ee:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10f1:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10f8:	79 07                	jns    1101 <APDrawLine+0xdb>
    10fa:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1101:	8b 45 08             	mov    0x8(%ebp),%eax
    1104:	8b 00                	mov    (%eax),%eax
    1106:	3b 45 14             	cmp    0x14(%ebp),%eax
    1109:	7d 0b                	jge    1116 <APDrawLine+0xf0>
    110b:	8b 45 08             	mov    0x8(%ebp),%eax
    110e:	8b 00                	mov    (%eax),%eax
    1110:	83 e8 01             	sub    $0x1,%eax
    1113:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1116:	8b 45 0c             	mov    0xc(%ebp),%eax
    1119:	89 45 f0             	mov    %eax,-0x10(%ebp)
    111c:	eb 15                	jmp    1133 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    111e:	ff 75 10             	pushl  0x10(%ebp)
    1121:	ff 75 f0             	pushl  -0x10(%ebp)
    1124:	ff 75 08             	pushl  0x8(%ebp)
    1127:	e8 17 fe ff ff       	call   f43 <APDrawPoint>
    112c:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    112f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1133:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1136:	3b 45 14             	cmp    0x14(%ebp),%eax
    1139:	7e e3                	jle    111e <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    113b:	e9 a4 01 00 00       	jmp    12e4 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1140:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1147:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    114e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1151:	2b 45 14             	sub    0x14(%ebp),%eax
    1154:	50                   	push   %eax
    1155:	e8 fb f9 ff ff       	call   b55 <abs_int>
    115a:	83 c4 04             	add    $0x4,%esp
    115d:	89 c3                	mov    %eax,%ebx
    115f:	8b 45 10             	mov    0x10(%ebp),%eax
    1162:	2b 45 18             	sub    0x18(%ebp),%eax
    1165:	50                   	push   %eax
    1166:	e8 ea f9 ff ff       	call   b55 <abs_int>
    116b:	83 c4 04             	add    $0x4,%esp
    116e:	39 c3                	cmp    %eax,%ebx
    1170:	0f 8e b5 00 00 00    	jle    122b <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1176:	8b 45 10             	mov    0x10(%ebp),%eax
    1179:	2b 45 18             	sub    0x18(%ebp),%eax
    117c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    117f:	db 45 b0             	fildl  -0x50(%ebp)
    1182:	8b 45 0c             	mov    0xc(%ebp),%eax
    1185:	2b 45 14             	sub    0x14(%ebp),%eax
    1188:	89 45 b0             	mov    %eax,-0x50(%ebp)
    118b:	db 45 b0             	fildl  -0x50(%ebp)
    118e:	de f9                	fdivrp %st,%st(1)
    1190:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1193:	8b 45 14             	mov    0x14(%ebp),%eax
    1196:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1199:	7e 0e                	jle    11a9 <APDrawLine+0x183>
        {
            s = x1;
    119b:	8b 45 0c             	mov    0xc(%ebp),%eax
    119e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    11a1:	8b 45 14             	mov    0x14(%ebp),%eax
    11a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11a7:	eb 0c                	jmp    11b5 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11a9:	8b 45 14             	mov    0x14(%ebp),%eax
    11ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11af:	8b 45 0c             	mov    0xc(%ebp),%eax
    11b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11b9:	79 07                	jns    11c2 <APDrawLine+0x19c>
    11bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    11c2:	8b 45 08             	mov    0x8(%ebp),%eax
    11c5:	8b 00                	mov    (%eax),%eax
    11c7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11ca:	7f 0b                	jg     11d7 <APDrawLine+0x1b1>
    11cc:	8b 45 08             	mov    0x8(%ebp),%eax
    11cf:	8b 00                	mov    (%eax),%eax
    11d1:	83 e8 01             	sub    $0x1,%eax
    11d4:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11dd:	eb 3f                	jmp    121e <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11e2:	2b 45 0c             	sub    0xc(%ebp),%eax
    11e5:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11e8:	db 45 b0             	fildl  -0x50(%ebp)
    11eb:	dc 4d d0             	fmull  -0x30(%ebp)
    11ee:	db 45 10             	fildl  0x10(%ebp)
    11f1:	de c1                	faddp  %st,%st(1)
    11f3:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11f6:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11fa:	b4 0c                	mov    $0xc,%ah
    11fc:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1200:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1203:	db 5d cc             	fistpl -0x34(%ebp)
    1206:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1209:	ff 75 cc             	pushl  -0x34(%ebp)
    120c:	ff 75 e4             	pushl  -0x1c(%ebp)
    120f:	ff 75 08             	pushl  0x8(%ebp)
    1212:	e8 2c fd ff ff       	call   f43 <APDrawPoint>
    1217:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    121a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    121e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1221:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1224:	7e b9                	jle    11df <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1226:	e9 b9 00 00 00       	jmp    12e4 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    122b:	8b 45 0c             	mov    0xc(%ebp),%eax
    122e:	2b 45 14             	sub    0x14(%ebp),%eax
    1231:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1234:	db 45 b0             	fildl  -0x50(%ebp)
    1237:	8b 45 10             	mov    0x10(%ebp),%eax
    123a:	2b 45 18             	sub    0x18(%ebp),%eax
    123d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1240:	db 45 b0             	fildl  -0x50(%ebp)
    1243:	de f9                	fdivrp %st,%st(1)
    1245:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1248:	8b 45 10             	mov    0x10(%ebp),%eax
    124b:	3b 45 18             	cmp    0x18(%ebp),%eax
    124e:	7e 0e                	jle    125e <APDrawLine+0x238>
    {
        s = y2;
    1250:	8b 45 18             	mov    0x18(%ebp),%eax
    1253:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1256:	8b 45 10             	mov    0x10(%ebp),%eax
    1259:	89 45 e8             	mov    %eax,-0x18(%ebp)
    125c:	eb 0c                	jmp    126a <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    125e:	8b 45 10             	mov    0x10(%ebp),%eax
    1261:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1264:	8b 45 18             	mov    0x18(%ebp),%eax
    1267:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    126a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    126e:	79 07                	jns    1277 <APDrawLine+0x251>
    1270:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1277:	8b 45 08             	mov    0x8(%ebp),%eax
    127a:	8b 40 04             	mov    0x4(%eax),%eax
    127d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1280:	7f 0c                	jg     128e <APDrawLine+0x268>
    1282:	8b 45 08             	mov    0x8(%ebp),%eax
    1285:	8b 40 04             	mov    0x4(%eax),%eax
    1288:	83 e8 01             	sub    $0x1,%eax
    128b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    128e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1291:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1294:	eb 3f                	jmp    12d5 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1296:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1299:	2b 45 10             	sub    0x10(%ebp),%eax
    129c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    129f:	db 45 b0             	fildl  -0x50(%ebp)
    12a2:	dc 4d c0             	fmull  -0x40(%ebp)
    12a5:	db 45 0c             	fildl  0xc(%ebp)
    12a8:	de c1                	faddp  %st,%st(1)
    12aa:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12ad:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12b1:	b4 0c                	mov    $0xc,%ah
    12b3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12b7:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12ba:	db 5d bc             	fistpl -0x44(%ebp)
    12bd:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    12c0:	ff 75 e0             	pushl  -0x20(%ebp)
    12c3:	ff 75 bc             	pushl  -0x44(%ebp)
    12c6:	ff 75 08             	pushl  0x8(%ebp)
    12c9:	e8 75 fc ff ff       	call   f43 <APDrawPoint>
    12ce:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12d1:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12d8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12db:	7e b9                	jle    1296 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12dd:	90                   	nop
    12de:	eb 04                	jmp    12e4 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12e0:	90                   	nop
    12e1:	eb 01                	jmp    12e4 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12e3:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12e7:	c9                   	leave  
    12e8:	c3                   	ret    

000012e9 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    12e9:	55                   	push   %ebp
    12ea:	89 e5                	mov    %esp,%ebp
    12ec:	53                   	push   %ebx
    12ed:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    12f0:	8b 55 10             	mov    0x10(%ebp),%edx
    12f3:	8b 45 18             	mov    0x18(%ebp),%eax
    12f6:	01 d0                	add    %edx,%eax
    12f8:	83 e8 01             	sub    $0x1,%eax
    12fb:	83 ec 04             	sub    $0x4,%esp
    12fe:	50                   	push   %eax
    12ff:	ff 75 0c             	pushl  0xc(%ebp)
    1302:	ff 75 10             	pushl  0x10(%ebp)
    1305:	ff 75 0c             	pushl  0xc(%ebp)
    1308:	ff 75 08             	pushl  0x8(%ebp)
    130b:	e8 16 fd ff ff       	call   1026 <APDrawLine>
    1310:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1313:	8b 55 0c             	mov    0xc(%ebp),%edx
    1316:	8b 45 14             	mov    0x14(%ebp),%eax
    1319:	01 d0                	add    %edx,%eax
    131b:	83 e8 01             	sub    $0x1,%eax
    131e:	83 ec 04             	sub    $0x4,%esp
    1321:	ff 75 10             	pushl  0x10(%ebp)
    1324:	50                   	push   %eax
    1325:	ff 75 10             	pushl  0x10(%ebp)
    1328:	ff 75 0c             	pushl  0xc(%ebp)
    132b:	ff 75 08             	pushl  0x8(%ebp)
    132e:	e8 f3 fc ff ff       	call   1026 <APDrawLine>
    1333:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1336:	8b 55 10             	mov    0x10(%ebp),%edx
    1339:	8b 45 18             	mov    0x18(%ebp),%eax
    133c:	01 d0                	add    %edx,%eax
    133e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1341:	8b 55 0c             	mov    0xc(%ebp),%edx
    1344:	8b 45 14             	mov    0x14(%ebp),%eax
    1347:	01 d0                	add    %edx,%eax
    1349:	8d 50 ff             	lea    -0x1(%eax),%edx
    134c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    134f:	8b 45 14             	mov    0x14(%ebp),%eax
    1352:	01 d8                	add    %ebx,%eax
    1354:	83 e8 01             	sub    $0x1,%eax
    1357:	83 ec 04             	sub    $0x4,%esp
    135a:	51                   	push   %ecx
    135b:	52                   	push   %edx
    135c:	ff 75 10             	pushl  0x10(%ebp)
    135f:	50                   	push   %eax
    1360:	ff 75 08             	pushl  0x8(%ebp)
    1363:	e8 be fc ff ff       	call   1026 <APDrawLine>
    1368:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    136b:	8b 55 10             	mov    0x10(%ebp),%edx
    136e:	8b 45 18             	mov    0x18(%ebp),%eax
    1371:	01 d0                	add    %edx,%eax
    1373:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1376:	8b 55 0c             	mov    0xc(%ebp),%edx
    1379:	8b 45 14             	mov    0x14(%ebp),%eax
    137c:	01 d0                	add    %edx,%eax
    137e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1381:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1384:	8b 45 18             	mov    0x18(%ebp),%eax
    1387:	01 d8                	add    %ebx,%eax
    1389:	83 e8 01             	sub    $0x1,%eax
    138c:	83 ec 04             	sub    $0x4,%esp
    138f:	51                   	push   %ecx
    1390:	52                   	push   %edx
    1391:	50                   	push   %eax
    1392:	ff 75 0c             	pushl  0xc(%ebp)
    1395:	ff 75 08             	pushl  0x8(%ebp)
    1398:	e8 89 fc ff ff       	call   1026 <APDrawLine>
    139d:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    13a0:	8b 55 0c             	mov    0xc(%ebp),%edx
    13a3:	8b 45 14             	mov    0x14(%ebp),%eax
    13a6:	01 d0                	add    %edx,%eax
    13a8:	8d 50 ff             	lea    -0x1(%eax),%edx
    13ab:	8b 45 08             	mov    0x8(%ebp),%eax
    13ae:	8b 40 0c             	mov    0xc(%eax),%eax
    13b1:	89 c1                	mov    %eax,%ecx
    13b3:	c1 e9 1f             	shr    $0x1f,%ecx
    13b6:	01 c8                	add    %ecx,%eax
    13b8:	d1 f8                	sar    %eax
    13ba:	29 c2                	sub    %eax,%edx
    13bc:	89 d0                	mov    %edx,%eax
    13be:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    13c1:	8b 55 10             	mov    0x10(%ebp),%edx
    13c4:	8b 45 18             	mov    0x18(%ebp),%eax
    13c7:	01 d0                	add    %edx,%eax
    13c9:	8d 50 ff             	lea    -0x1(%eax),%edx
    13cc:	8b 45 08             	mov    0x8(%ebp),%eax
    13cf:	8b 40 0c             	mov    0xc(%eax),%eax
    13d2:	89 c1                	mov    %eax,%ecx
    13d4:	c1 e9 1f             	shr    $0x1f,%ecx
    13d7:	01 c8                	add    %ecx,%eax
    13d9:	d1 f8                	sar    %eax
    13db:	29 c2                	sub    %eax,%edx
    13dd:	89 d0                	mov    %edx,%eax
    13df:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13e2:	8b 45 08             	mov    0x8(%ebp),%eax
    13e5:	8b 40 0c             	mov    0xc(%eax),%eax
    13e8:	89 c2                	mov    %eax,%edx
    13ea:	c1 ea 1f             	shr    $0x1f,%edx
    13ed:	01 d0                	add    %edx,%eax
    13ef:	d1 f8                	sar    %eax
    13f1:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13f4:	8b 45 08             	mov    0x8(%ebp),%eax
    13f7:	8b 40 0c             	mov    0xc(%eax),%eax
    13fa:	89 c2                	mov    %eax,%edx
    13fc:	c1 ea 1f             	shr    $0x1f,%edx
    13ff:	01 d0                	add    %edx,%eax
    1401:	d1 f8                	sar    %eax
    1403:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1406:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    140a:	0f 88 d8 00 00 00    	js     14e8 <APDrawRect+0x1ff>
    1410:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1414:	0f 88 ce 00 00 00    	js     14e8 <APDrawRect+0x1ff>
    141a:	8b 45 08             	mov    0x8(%ebp),%eax
    141d:	8b 00                	mov    (%eax),%eax
    141f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1422:	0f 8e c0 00 00 00    	jle    14e8 <APDrawRect+0x1ff>
    1428:	8b 45 08             	mov    0x8(%ebp),%eax
    142b:	8b 40 04             	mov    0x4(%eax),%eax
    142e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1431:	0f 8e b1 00 00 00    	jle    14e8 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1437:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    143b:	79 07                	jns    1444 <APDrawRect+0x15b>
    143d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1444:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1448:	79 07                	jns    1451 <APDrawRect+0x168>
    144a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1451:	8b 45 08             	mov    0x8(%ebp),%eax
    1454:	8b 00                	mov    (%eax),%eax
    1456:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1459:	7f 0b                	jg     1466 <APDrawRect+0x17d>
    145b:	8b 45 08             	mov    0x8(%ebp),%eax
    145e:	8b 00                	mov    (%eax),%eax
    1460:	83 e8 01             	sub    $0x1,%eax
    1463:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1466:	8b 45 08             	mov    0x8(%ebp),%eax
    1469:	8b 40 04             	mov    0x4(%eax),%eax
    146c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    146f:	7f 0c                	jg     147d <APDrawRect+0x194>
    1471:	8b 45 08             	mov    0x8(%ebp),%eax
    1474:	8b 40 04             	mov    0x4(%eax),%eax
    1477:	83 e8 01             	sub    $0x1,%eax
    147a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    147d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1484:	8b 45 0c             	mov    0xc(%ebp),%eax
    1487:	89 45 ec             	mov    %eax,-0x14(%ebp)
    148a:	eb 52                	jmp    14de <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    148c:	8b 45 10             	mov    0x10(%ebp),%eax
    148f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1492:	eb 3e                	jmp    14d2 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1494:	83 ec 04             	sub    $0x4,%esp
    1497:	ff 75 e8             	pushl  -0x18(%ebp)
    149a:	ff 75 ec             	pushl  -0x14(%ebp)
    149d:	ff 75 08             	pushl  0x8(%ebp)
    14a0:	e8 c0 f6 ff ff       	call   b65 <APGetIndex>
    14a5:	83 c4 10             	add    $0x10,%esp
    14a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14ab:	8b 45 08             	mov    0x8(%ebp),%eax
    14ae:	8b 48 18             	mov    0x18(%eax),%ecx
    14b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14b4:	89 d0                	mov    %edx,%eax
    14b6:	01 c0                	add    %eax,%eax
    14b8:	01 d0                	add    %edx,%eax
    14ba:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14bd:	8b 45 08             	mov    0x8(%ebp),%eax
    14c0:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    14c4:	66 89 0a             	mov    %cx,(%edx)
    14c7:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14cb:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14ce:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14d5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14d8:	7e ba                	jle    1494 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14da:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14de:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14e1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14e4:	7e a6                	jle    148c <APDrawRect+0x1a3>
    14e6:	eb 01                	jmp    14e9 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    14e8:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    14e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14ec:	c9                   	leave  
    14ed:	c3                   	ret    

000014ee <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    14ee:	55                   	push   %ebp
    14ef:	89 e5                	mov    %esp,%ebp
    14f1:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    14f4:	83 ec 0c             	sub    $0xc,%esp
    14f7:	ff 75 0c             	pushl  0xc(%ebp)
    14fa:	e8 c1 ee ff ff       	call   3c0 <strlen>
    14ff:	83 c4 10             	add    $0x10,%esp
    1502:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1505:	8b 45 08             	mov    0x8(%ebp),%eax
    1508:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    150c:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1510:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1514:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1517:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    151e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1525:	e9 bc 00 00 00       	jmp    15e6 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    152a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    152d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1530:	01 d0                	add    %edx,%eax
    1532:	0f b6 00             	movzbl (%eax),%eax
    1535:	0f be c0             	movsbl %al,%eax
    1538:	83 e8 20             	sub    $0x20,%eax
    153b:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    153e:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1542:	0f 87 9a 00 00 00    	ja     15e2 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1548:	8b 45 08             	mov    0x8(%ebp),%eax
    154b:	8b 00                	mov    (%eax),%eax
    154d:	0f af 45 14          	imul   0x14(%ebp),%eax
    1551:	89 c2                	mov    %eax,%edx
    1553:	8b 45 10             	mov    0x10(%ebp),%eax
    1556:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1559:	8b 55 f4             	mov    -0xc(%ebp),%edx
    155c:	89 d0                	mov    %edx,%eax
    155e:	c1 e0 03             	shl    $0x3,%eax
    1561:	01 d0                	add    %edx,%eax
    1563:	01 c8                	add    %ecx,%eax
    1565:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1568:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    156f:	eb 6b                	jmp    15dc <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1571:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1578:	eb 50                	jmp    15ca <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    157a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    157d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1580:	89 d0                	mov    %edx,%eax
    1582:	c1 e0 03             	shl    $0x3,%eax
    1585:	01 d0                	add    %edx,%eax
    1587:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    158d:	01 c2                	add    %eax,%edx
    158f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1592:	01 d0                	add    %edx,%eax
    1594:	05 80 2e 00 00       	add    $0x2e80,%eax
    1599:	0f b6 00             	movzbl (%eax),%eax
    159c:	84 c0                	test   %al,%al
    159e:	74 26                	je     15c6 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    15a0:	8b 45 08             	mov    0x8(%ebp),%eax
    15a3:	8b 50 18             	mov    0x18(%eax),%edx
    15a6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    15a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ac:	01 c8                	add    %ecx,%eax
    15ae:	89 c1                	mov    %eax,%ecx
    15b0:	89 c8                	mov    %ecx,%eax
    15b2:	01 c0                	add    %eax,%eax
    15b4:	01 c8                	add    %ecx,%eax
    15b6:	01 d0                	add    %edx,%eax
    15b8:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    15bc:	66 89 10             	mov    %dx,(%eax)
    15bf:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15c3:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    15c6:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    15ca:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    15ce:	7e aa                	jle    157a <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
    15d3:	8b 00                	mov    (%eax),%eax
    15d5:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    15d8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    15dc:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    15e0:	7e 8f                	jle    1571 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    15e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    15e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15e9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    15ec:	0f 82 38 ff ff ff    	jb     152a <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    15f2:	90                   	nop
    15f3:	c9                   	leave  
    15f4:	c3                   	ret    

000015f5 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    15f5:	55                   	push   %ebp
    15f6:	89 e5                	mov    %esp,%ebp
    15f8:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    15fb:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    15ff:	0f 88 8e 01 00 00    	js     1793 <APDcCopy+0x19e>
    1605:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1609:	0f 88 84 01 00 00    	js     1793 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    160f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1612:	8b 45 20             	mov    0x20(%ebp),%eax
    1615:	01 d0                	add    %edx,%eax
    1617:	89 45 fc             	mov    %eax,-0x4(%ebp)
    161a:	8b 55 10             	mov    0x10(%ebp),%edx
    161d:	8b 45 24             	mov    0x24(%ebp),%eax
    1620:	01 d0                	add    %edx,%eax
    1622:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1625:	8b 55 18             	mov    0x18(%ebp),%edx
    1628:	8b 45 20             	mov    0x20(%ebp),%eax
    162b:	01 d0                	add    %edx,%eax
    162d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1630:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1633:	8b 45 24             	mov    0x24(%ebp),%eax
    1636:	01 d0                	add    %edx,%eax
    1638:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    163b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    163f:	0f 88 51 01 00 00    	js     1796 <APDcCopy+0x1a1>
    1645:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1649:	0f 88 47 01 00 00    	js     1796 <APDcCopy+0x1a1>
    164f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1653:	0f 88 3d 01 00 00    	js     1796 <APDcCopy+0x1a1>
    1659:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    165d:	0f 88 33 01 00 00    	js     1796 <APDcCopy+0x1a1>
    1663:	8b 45 14             	mov    0x14(%ebp),%eax
    1666:	8b 00                	mov    (%eax),%eax
    1668:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    166b:	0f 8c 25 01 00 00    	jl     1796 <APDcCopy+0x1a1>
    1671:	8b 45 14             	mov    0x14(%ebp),%eax
    1674:	8b 40 04             	mov    0x4(%eax),%eax
    1677:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    167a:	0f 8c 16 01 00 00    	jl     1796 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1680:	8b 45 08             	mov    0x8(%ebp),%eax
    1683:	8b 00                	mov    (%eax),%eax
    1685:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1688:	7f 0b                	jg     1695 <APDcCopy+0xa0>
    168a:	8b 45 08             	mov    0x8(%ebp),%eax
    168d:	8b 00                	mov    (%eax),%eax
    168f:	83 e8 01             	sub    $0x1,%eax
    1692:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1695:	8b 45 08             	mov    0x8(%ebp),%eax
    1698:	8b 40 04             	mov    0x4(%eax),%eax
    169b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    169e:	7f 0c                	jg     16ac <APDcCopy+0xb7>
    16a0:	8b 45 08             	mov    0x8(%ebp),%eax
    16a3:	8b 40 04             	mov    0x4(%eax),%eax
    16a6:	83 e8 01             	sub    $0x1,%eax
    16a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    16ac:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    16b3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    16ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16c1:	e9 bc 00 00 00       	jmp    1782 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    16c6:	8b 45 08             	mov    0x8(%ebp),%eax
    16c9:	8b 00                	mov    (%eax),%eax
    16cb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16ce:	8b 55 10             	mov    0x10(%ebp),%edx
    16d1:	01 ca                	add    %ecx,%edx
    16d3:	0f af d0             	imul   %eax,%edx
    16d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    16d9:	01 d0                	add    %edx,%eax
    16db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    16de:	8b 45 14             	mov    0x14(%ebp),%eax
    16e1:	8b 00                	mov    (%eax),%eax
    16e3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16e6:	8b 55 1c             	mov    0x1c(%ebp),%edx
    16e9:	01 ca                	add    %ecx,%edx
    16eb:	0f af d0             	imul   %eax,%edx
    16ee:	8b 45 18             	mov    0x18(%ebp),%eax
    16f1:	01 d0                	add    %edx,%eax
    16f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    16f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16fd:	eb 74                	jmp    1773 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    16ff:	8b 45 14             	mov    0x14(%ebp),%eax
    1702:	8b 50 18             	mov    0x18(%eax),%edx
    1705:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1708:	8b 45 f0             	mov    -0x10(%ebp),%eax
    170b:	01 c8                	add    %ecx,%eax
    170d:	89 c1                	mov    %eax,%ecx
    170f:	89 c8                	mov    %ecx,%eax
    1711:	01 c0                	add    %eax,%eax
    1713:	01 c8                	add    %ecx,%eax
    1715:	01 d0                	add    %edx,%eax
    1717:	0f b7 10             	movzwl (%eax),%edx
    171a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    171e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1722:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1725:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1729:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    172d:	38 c2                	cmp    %al,%dl
    172f:	75 18                	jne    1749 <APDcCopy+0x154>
    1731:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1735:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1739:	38 c2                	cmp    %al,%dl
    173b:	75 0c                	jne    1749 <APDcCopy+0x154>
    173d:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1741:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1745:	38 c2                	cmp    %al,%dl
    1747:	74 26                	je     176f <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1749:	8b 45 08             	mov    0x8(%ebp),%eax
    174c:	8b 50 18             	mov    0x18(%eax),%edx
    174f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1752:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1755:	01 c8                	add    %ecx,%eax
    1757:	89 c1                	mov    %eax,%ecx
    1759:	89 c8                	mov    %ecx,%eax
    175b:	01 c0                	add    %eax,%eax
    175d:	01 c8                	add    %ecx,%eax
    175f:	01 d0                	add    %edx,%eax
    1761:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1765:	66 89 10             	mov    %dx,(%eax)
    1768:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    176c:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    176f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1773:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1776:	2b 45 0c             	sub    0xc(%ebp),%eax
    1779:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    177c:	7d 81                	jge    16ff <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    177e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1782:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1785:	2b 45 10             	sub    0x10(%ebp),%eax
    1788:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    178b:	0f 8d 35 ff ff ff    	jge    16c6 <APDcCopy+0xd1>
    1791:	eb 04                	jmp    1797 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1793:	90                   	nop
    1794:	eb 01                	jmp    1797 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1796:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1797:	c9                   	leave  
    1798:	c3                   	ret    

00001799 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1799:	55                   	push   %ebp
    179a:	89 e5                	mov    %esp,%ebp
    179c:	83 ec 1c             	sub    $0x1c,%esp
    179f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    17a2:	8b 55 10             	mov    0x10(%ebp),%edx
    17a5:	8b 45 14             	mov    0x14(%ebp),%eax
    17a8:	88 4d ec             	mov    %cl,-0x14(%ebp)
    17ab:	88 55 e8             	mov    %dl,-0x18(%ebp)
    17ae:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    17b1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    17b5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    17b8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    17bc:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    17bf:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    17c3:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    17c6:	8b 45 08             	mov    0x8(%ebp),%eax
    17c9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    17cd:	66 89 10             	mov    %dx,(%eax)
    17d0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    17d4:	88 50 02             	mov    %dl,0x2(%eax)
}
    17d7:	8b 45 08             	mov    0x8(%ebp),%eax
    17da:	c9                   	leave  
    17db:	c2 04 00             	ret    $0x4

000017de <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    17de:	55                   	push   %ebp
    17df:	89 e5                	mov    %esp,%ebp
    17e1:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    17e4:	8b 45 08             	mov    0x8(%ebp),%eax
    17e7:	8b 00                	mov    (%eax),%eax
    17e9:	83 ec 08             	sub    $0x8,%esp
    17ec:	8d 55 0c             	lea    0xc(%ebp),%edx
    17ef:	52                   	push   %edx
    17f0:	50                   	push   %eax
    17f1:	e8 34 ee ff ff       	call   62a <sendMessage>
    17f6:	83 c4 10             	add    $0x10,%esp
}
    17f9:	90                   	nop
    17fa:	c9                   	leave  
    17fb:	c3                   	ret    

000017fc <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    17fc:	55                   	push   %ebp
    17fd:	89 e5                	mov    %esp,%ebp
    17ff:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1802:	83 ec 0c             	sub    $0xc,%esp
    1805:	68 98 00 00 00       	push   $0x98
    180a:	e8 f5 f1 ff ff       	call   a04 <malloc>
    180f:	83 c4 10             	add    $0x10,%esp
    1812:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1815:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1819:	75 15                	jne    1830 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    181b:	83 ec 04             	sub    $0x4,%esp
    181e:	ff 75 08             	pushl  0x8(%ebp)
    1821:	68 ec 26 00 00       	push   $0x26ec
    1826:	6a 01                	push   $0x1
    1828:	e8 04 ef ff ff       	call   731 <printf>
    182d:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1830:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1833:	05 84 00 00 00       	add    $0x84,%eax
    1838:	83 ec 08             	sub    $0x8,%esp
    183b:	ff 75 08             	pushl  0x8(%ebp)
    183e:	50                   	push   %eax
    183f:	e8 0d eb ff ff       	call   351 <strcpy>
    1844:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1847:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184a:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1851:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1854:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    185b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1861:	89 c2                	mov    %eax,%edx
    1863:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1866:	8b 40 40             	mov    0x40(%eax),%eax
    1869:	0f af d0             	imul   %eax,%edx
    186c:	89 d0                	mov    %edx,%eax
    186e:	01 c0                	add    %eax,%eax
    1870:	01 d0                	add    %edx,%eax
    1872:	83 ec 0c             	sub    $0xc,%esp
    1875:	50                   	push   %eax
    1876:	e8 89 f1 ff ff       	call   a04 <malloc>
    187b:	83 c4 10             	add    $0x10,%esp
    187e:	89 c2                	mov    %eax,%edx
    1880:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1883:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1886:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1889:	8b 40 54             	mov    0x54(%eax),%eax
    188c:	85 c0                	test   %eax,%eax
    188e:	75 15                	jne    18a5 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1890:	83 ec 04             	sub    $0x4,%esp
    1893:	ff 75 08             	pushl  0x8(%ebp)
    1896:	68 0c 27 00 00       	push   $0x270c
    189b:	6a 01                	push   $0x1
    189d:	e8 8f ee ff ff       	call   731 <printf>
    18a2:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    18a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a8:	8b 40 3c             	mov    0x3c(%eax),%eax
    18ab:	89 c2                	mov    %eax,%edx
    18ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b0:	8b 40 40             	mov    0x40(%eax),%eax
    18b3:	0f af d0             	imul   %eax,%edx
    18b6:	89 d0                	mov    %edx,%eax
    18b8:	01 c0                	add    %eax,%eax
    18ba:	01 c2                	add    %eax,%edx
    18bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bf:	8b 40 54             	mov    0x54(%eax),%eax
    18c2:	83 ec 04             	sub    $0x4,%esp
    18c5:	52                   	push   %edx
    18c6:	68 ff ff ff 00       	push   $0xffffff
    18cb:	50                   	push   %eax
    18cc:	e8 16 eb ff ff       	call   3e7 <memset>
    18d1:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    18d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d7:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    18de:	e8 1f ed ff ff       	call   602 <getpid>
    18e3:	89 c2                	mov    %eax,%edx
    18e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e8:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    18eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ee:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    18f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f8:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    18ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1902:	8b 40 58             	mov    0x58(%eax),%eax
    1905:	89 c2                	mov    %eax,%edx
    1907:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190a:	8b 40 5c             	mov    0x5c(%eax),%eax
    190d:	0f af d0             	imul   %eax,%edx
    1910:	89 d0                	mov    %edx,%eax
    1912:	01 c0                	add    %eax,%eax
    1914:	01 d0                	add    %edx,%eax
    1916:	83 ec 0c             	sub    $0xc,%esp
    1919:	50                   	push   %eax
    191a:	e8 e5 f0 ff ff       	call   a04 <malloc>
    191f:	83 c4 10             	add    $0x10,%esp
    1922:	89 c2                	mov    %eax,%edx
    1924:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1927:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    192a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192d:	8b 40 70             	mov    0x70(%eax),%eax
    1930:	85 c0                	test   %eax,%eax
    1932:	75 15                	jne    1949 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1934:	83 ec 04             	sub    $0x4,%esp
    1937:	ff 75 08             	pushl  0x8(%ebp)
    193a:	68 30 27 00 00       	push   $0x2730
    193f:	6a 01                	push   $0x1
    1941:	e8 eb ed ff ff       	call   731 <printf>
    1946:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1949:	8b 45 f4             	mov    -0xc(%ebp),%eax
    194c:	8b 40 3c             	mov    0x3c(%eax),%eax
    194f:	89 c2                	mov    %eax,%edx
    1951:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1954:	8b 40 40             	mov    0x40(%eax),%eax
    1957:	0f af d0             	imul   %eax,%edx
    195a:	89 d0                	mov    %edx,%eax
    195c:	01 c0                	add    %eax,%eax
    195e:	01 c2                	add    %eax,%edx
    1960:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1963:	8b 40 54             	mov    0x54(%eax),%eax
    1966:	83 ec 04             	sub    $0x4,%esp
    1969:	52                   	push   %edx
    196a:	68 ff 00 00 00       	push   $0xff
    196f:	50                   	push   %eax
    1970:	e8 72 ea ff ff       	call   3e7 <memset>
    1975:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1978:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197b:	8b 55 0c             	mov    0xc(%ebp),%edx
    197e:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1981:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1985:	74 49                	je     19d0 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1987:	8b 45 10             	mov    0x10(%ebp),%eax
    198a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1990:	83 ec 0c             	sub    $0xc,%esp
    1993:	50                   	push   %eax
    1994:	e8 6b f0 ff ff       	call   a04 <malloc>
    1999:	83 c4 10             	add    $0x10,%esp
    199c:	89 c2                	mov    %eax,%edx
    199e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a1:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    19a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a7:	8b 55 10             	mov    0x10(%ebp),%edx
    19aa:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    19ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    19b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ba:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    19c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    19cb:	e9 8d 00 00 00       	jmp    1a5d <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    19d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d3:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    19da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19dd:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    19e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e7:	8b 40 20             	mov    0x20(%eax),%eax
    19ea:	89 c2                	mov    %eax,%edx
    19ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ef:	8b 40 24             	mov    0x24(%eax),%eax
    19f2:	0f af d0             	imul   %eax,%edx
    19f5:	89 d0                	mov    %edx,%eax
    19f7:	01 c0                	add    %eax,%eax
    19f9:	01 d0                	add    %edx,%eax
    19fb:	83 ec 0c             	sub    $0xc,%esp
    19fe:	50                   	push   %eax
    19ff:	e8 00 f0 ff ff       	call   a04 <malloc>
    1a04:	83 c4 10             	add    $0x10,%esp
    1a07:	89 c2                	mov    %eax,%edx
    1a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0c:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a12:	8b 40 38             	mov    0x38(%eax),%eax
    1a15:	85 c0                	test   %eax,%eax
    1a17:	75 15                	jne    1a2e <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1a19:	83 ec 04             	sub    $0x4,%esp
    1a1c:	ff 75 08             	pushl  0x8(%ebp)
    1a1f:	68 58 27 00 00       	push   $0x2758
    1a24:	6a 01                	push   $0x1
    1a26:	e8 06 ed ff ff       	call   731 <printf>
    1a2b:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a31:	8b 40 20             	mov    0x20(%eax),%eax
    1a34:	89 c2                	mov    %eax,%edx
    1a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a39:	8b 40 24             	mov    0x24(%eax),%eax
    1a3c:	0f af d0             	imul   %eax,%edx
    1a3f:	89 d0                	mov    %edx,%eax
    1a41:	01 c0                	add    %eax,%eax
    1a43:	01 c2                	add    %eax,%edx
    1a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a48:	8b 40 38             	mov    0x38(%eax),%eax
    1a4b:	83 ec 04             	sub    $0x4,%esp
    1a4e:	52                   	push   %edx
    1a4f:	68 ff ff ff 00       	push   $0xffffff
    1a54:	50                   	push   %eax
    1a55:	e8 8d e9 ff ff       	call   3e7 <memset>
    1a5a:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1a60:	c9                   	leave  
    1a61:	c3                   	ret    

00001a62 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1a62:	55                   	push   %ebp
    1a63:	89 e5                	mov    %esp,%ebp
    1a65:	57                   	push   %edi
    1a66:	56                   	push   %esi
    1a67:	53                   	push   %ebx
    1a68:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1a6b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a6e:	83 f8 03             	cmp    $0x3,%eax
    1a71:	74 02                	je     1a75 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1a73:	eb 7c                	jmp    1af1 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1a75:	8b 45 08             	mov    0x8(%ebp),%eax
    1a78:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1a7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7e:	8b 48 18             	mov    0x18(%eax),%ecx
    1a81:	8b 45 08             	mov    0x8(%ebp),%eax
    1a84:	8b 50 5c             	mov    0x5c(%eax),%edx
    1a87:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8a:	8b 40 58             	mov    0x58(%eax),%eax
    1a8d:	8b 75 08             	mov    0x8(%ebp),%esi
    1a90:	83 c6 58             	add    $0x58,%esi
    1a93:	83 ec 04             	sub    $0x4,%esp
    1a96:	53                   	push   %ebx
    1a97:	51                   	push   %ecx
    1a98:	6a 00                	push   $0x0
    1a9a:	52                   	push   %edx
    1a9b:	50                   	push   %eax
    1a9c:	6a 00                	push   $0x0
    1a9e:	6a 00                	push   $0x0
    1aa0:	56                   	push   %esi
    1aa1:	6a 00                	push   $0x0
    1aa3:	6a 00                	push   $0x0
    1aa5:	ff 75 08             	pushl  0x8(%ebp)
    1aa8:	e8 75 eb ff ff       	call   622 <paintWindow>
    1aad:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1ab0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab3:	8b 70 1c             	mov    0x1c(%eax),%esi
    1ab6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab9:	8b 58 18             	mov    0x18(%eax),%ebx
    1abc:	8b 45 08             	mov    0x8(%ebp),%eax
    1abf:	8b 48 08             	mov    0x8(%eax),%ecx
    1ac2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac5:	8b 50 40             	mov    0x40(%eax),%edx
    1ac8:	8b 45 08             	mov    0x8(%ebp),%eax
    1acb:	8b 40 3c             	mov    0x3c(%eax),%eax
    1ace:	8b 7d 08             	mov    0x8(%ebp),%edi
    1ad1:	83 c7 3c             	add    $0x3c,%edi
    1ad4:	83 ec 04             	sub    $0x4,%esp
    1ad7:	56                   	push   %esi
    1ad8:	53                   	push   %ebx
    1ad9:	51                   	push   %ecx
    1ada:	52                   	push   %edx
    1adb:	50                   	push   %eax
    1adc:	6a 00                	push   $0x0
    1ade:	6a 00                	push   $0x0
    1ae0:	57                   	push   %edi
    1ae1:	6a 32                	push   $0x32
    1ae3:	6a 00                	push   $0x0
    1ae5:	ff 75 08             	pushl  0x8(%ebp)
    1ae8:	e8 35 eb ff ff       	call   622 <paintWindow>
    1aed:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1af0:	90                   	nop
        default: break;
            
            
    }
    return False;
    1af1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1af6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1af9:	5b                   	pop    %ebx
    1afa:	5e                   	pop    %esi
    1afb:	5f                   	pop    %edi
    1afc:	5d                   	pop    %ebp
    1afd:	c3                   	ret    

00001afe <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1afe:	55                   	push   %ebp
    1aff:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1b01:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b04:	8b 50 08             	mov    0x8(%eax),%edx
    1b07:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0a:	8b 00                	mov    (%eax),%eax
    1b0c:	39 c2                	cmp    %eax,%edx
    1b0e:	74 07                	je     1b17 <APPreJudge+0x19>
        return False;
    1b10:	b8 00 00 00 00       	mov    $0x0,%eax
    1b15:	eb 05                	jmp    1b1c <APPreJudge+0x1e>
    return True;
    1b17:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1b1c:	5d                   	pop    %ebp
    1b1d:	c3                   	ret    

00001b1e <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1b1e:	55                   	push   %ebp
    1b1f:	89 e5                	mov    %esp,%ebp
    1b21:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1b24:	8b 45 08             	mov    0x8(%ebp),%eax
    1b27:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b2a:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1b30:	83 ec 0c             	sub    $0xc,%esp
    1b33:	ff 75 08             	pushl  0x8(%ebp)
    1b36:	e8 ff ea ff ff       	call   63a <registWindow>
    1b3b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1b3e:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1b45:	8b 45 08             	mov    0x8(%ebp),%eax
    1b48:	8b 00                	mov    (%eax),%eax
    1b4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1b4d:	ff 75 f4             	pushl  -0xc(%ebp)
    1b50:	ff 75 f0             	pushl  -0x10(%ebp)
    1b53:	ff 75 ec             	pushl  -0x14(%ebp)
    1b56:	ff 75 08             	pushl  0x8(%ebp)
    1b59:	e8 80 fc ff ff       	call   17de <APSendMessage>
    1b5e:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1b61:	83 ec 0c             	sub    $0xc,%esp
    1b64:	ff 75 08             	pushl  0x8(%ebp)
    1b67:	e8 c6 ea ff ff       	call   632 <getMessage>
    1b6c:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1b6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b72:	83 c0 74             	add    $0x74,%eax
    1b75:	83 ec 08             	sub    $0x8,%esp
    1b78:	50                   	push   %eax
    1b79:	ff 75 08             	pushl  0x8(%ebp)
    1b7c:	e8 7d ff ff ff       	call   1afe <APPreJudge>
    1b81:	83 c4 10             	add    $0x10,%esp
    1b84:	84 c0                	test   %al,%al
    1b86:	74 1b                	je     1ba3 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1b88:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8b:	ff 70 7c             	pushl  0x7c(%eax)
    1b8e:	ff 70 78             	pushl  0x78(%eax)
    1b91:	ff 70 74             	pushl  0x74(%eax)
    1b94:	ff 75 08             	pushl  0x8(%ebp)
    1b97:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b9a:	ff d0                	call   *%eax
    1b9c:	83 c4 10             	add    $0x10,%esp
    1b9f:	84 c0                	test   %al,%al
    1ba1:	75 0c                	jne    1baf <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1ba3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1bad:	eb b2                	jmp    1b61 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1baf:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1bb0:	90                   	nop
    1bb1:	c9                   	leave  
    1bb2:	c3                   	ret    

00001bb3 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1bb3:	55                   	push   %ebp
    1bb4:	89 e5                	mov    %esp,%ebp
    1bb6:	57                   	push   %edi
    1bb7:	56                   	push   %esi
    1bb8:	53                   	push   %ebx
    1bb9:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1bbc:	a1 cc 6a 00 00       	mov    0x6acc,%eax
    1bc1:	85 c0                	test   %eax,%eax
    1bc3:	0f 85 2c 02 00 00    	jne    1df5 <APGridPaint+0x242>
    {
        iconReady = 1;
    1bc9:	c7 05 cc 6a 00 00 01 	movl   $0x1,0x6acc
    1bd0:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1bd3:	8d 45 88             	lea    -0x78(%ebp),%eax
    1bd6:	83 ec 08             	sub    $0x8,%esp
    1bd9:	68 7f 27 00 00       	push   $0x277f
    1bde:	50                   	push   %eax
    1bdf:	e8 d3 ef ff ff       	call   bb7 <APLoadBitmap>
    1be4:	83 c4 0c             	add    $0xc,%esp
    1be7:	8b 45 88             	mov    -0x78(%ebp),%eax
    1bea:	a3 00 6f 00 00       	mov    %eax,0x6f00
    1bef:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1bf2:	a3 04 6f 00 00       	mov    %eax,0x6f04
    1bf7:	8b 45 90             	mov    -0x70(%ebp),%eax
    1bfa:	a3 08 6f 00 00       	mov    %eax,0x6f08
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1bff:	83 ec 04             	sub    $0x4,%esp
    1c02:	ff 35 08 6f 00 00    	pushl  0x6f08
    1c08:	ff 35 04 6f 00 00    	pushl  0x6f04
    1c0e:	ff 35 00 6f 00 00    	pushl  0x6f00
    1c14:	e8 d8 f1 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1c19:	83 c4 10             	add    $0x10,%esp
    1c1c:	a3 0c 6f 00 00       	mov    %eax,0x6f0c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1c21:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c24:	83 ec 08             	sub    $0x8,%esp
    1c27:	68 8d 27 00 00       	push   $0x278d
    1c2c:	50                   	push   %eax
    1c2d:	e8 85 ef ff ff       	call   bb7 <APLoadBitmap>
    1c32:	83 c4 0c             	add    $0xc,%esp
    1c35:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c38:	a3 3c 6f 00 00       	mov    %eax,0x6f3c
    1c3d:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c40:	a3 40 6f 00 00       	mov    %eax,0x6f40
    1c45:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c48:	a3 44 6f 00 00       	mov    %eax,0x6f44
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1c4d:	83 ec 04             	sub    $0x4,%esp
    1c50:	ff 35 44 6f 00 00    	pushl  0x6f44
    1c56:	ff 35 40 6f 00 00    	pushl  0x6f40
    1c5c:	ff 35 3c 6f 00 00    	pushl  0x6f3c
    1c62:	e8 8a f1 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1c67:	83 c4 10             	add    $0x10,%esp
    1c6a:	a3 2c 6f 00 00       	mov    %eax,0x6f2c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1c6f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c72:	83 ec 08             	sub    $0x8,%esp
    1c75:	68 9c 27 00 00       	push   $0x279c
    1c7a:	50                   	push   %eax
    1c7b:	e8 37 ef ff ff       	call   bb7 <APLoadBitmap>
    1c80:	83 c4 0c             	add    $0xc,%esp
    1c83:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c86:	a3 30 6f 00 00       	mov    %eax,0x6f30
    1c8b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c8e:	a3 34 6f 00 00       	mov    %eax,0x6f34
    1c93:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c96:	a3 38 6f 00 00       	mov    %eax,0x6f38
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1c9b:	83 ec 04             	sub    $0x4,%esp
    1c9e:	ff 35 38 6f 00 00    	pushl  0x6f38
    1ca4:	ff 35 34 6f 00 00    	pushl  0x6f34
    1caa:	ff 35 30 6f 00 00    	pushl  0x6f30
    1cb0:	e8 3c f1 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1cb5:	83 c4 10             	add    $0x10,%esp
    1cb8:	a3 e0 6e 00 00       	mov    %eax,0x6ee0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1cbd:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cc0:	83 ec 08             	sub    $0x8,%esp
    1cc3:	68 ab 27 00 00       	push   $0x27ab
    1cc8:	50                   	push   %eax
    1cc9:	e8 e9 ee ff ff       	call   bb7 <APLoadBitmap>
    1cce:	83 c4 0c             	add    $0xc,%esp
    1cd1:	8b 45 88             	mov    -0x78(%ebp),%eax
    1cd4:	a3 14 6f 00 00       	mov    %eax,0x6f14
    1cd9:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1cdc:	a3 18 6f 00 00       	mov    %eax,0x6f18
    1ce1:	8b 45 90             	mov    -0x70(%ebp),%eax
    1ce4:	a3 1c 6f 00 00       	mov    %eax,0x6f1c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1ce9:	83 ec 04             	sub    $0x4,%esp
    1cec:	ff 35 1c 6f 00 00    	pushl  0x6f1c
    1cf2:	ff 35 18 6f 00 00    	pushl  0x6f18
    1cf8:	ff 35 14 6f 00 00    	pushl  0x6f14
    1cfe:	e8 ee f0 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1d03:	83 c4 10             	add    $0x10,%esp
    1d06:	a3 48 6f 00 00       	mov    %eax,0x6f48
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1d0b:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d0e:	83 ec 08             	sub    $0x8,%esp
    1d11:	68 b9 27 00 00       	push   $0x27b9
    1d16:	50                   	push   %eax
    1d17:	e8 9b ee ff ff       	call   bb7 <APLoadBitmap>
    1d1c:	83 c4 0c             	add    $0xc,%esp
    1d1f:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d22:	a3 f0 6e 00 00       	mov    %eax,0x6ef0
    1d27:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d2a:	a3 f4 6e 00 00       	mov    %eax,0x6ef4
    1d2f:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d32:	a3 f8 6e 00 00       	mov    %eax,0x6ef8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1d37:	83 ec 04             	sub    $0x4,%esp
    1d3a:	ff 35 f8 6e 00 00    	pushl  0x6ef8
    1d40:	ff 35 f4 6e 00 00    	pushl  0x6ef4
    1d46:	ff 35 f0 6e 00 00    	pushl  0x6ef0
    1d4c:	e8 a0 f0 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1d51:	83 c4 10             	add    $0x10,%esp
    1d54:	a3 10 6f 00 00       	mov    %eax,0x6f10
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1d59:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d5c:	83 ec 08             	sub    $0x8,%esp
    1d5f:	68 c9 27 00 00       	push   $0x27c9
    1d64:	50                   	push   %eax
    1d65:	e8 4d ee ff ff       	call   bb7 <APLoadBitmap>
    1d6a:	83 c4 0c             	add    $0xc,%esp
    1d6d:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d70:	a3 e4 6e 00 00       	mov    %eax,0x6ee4
    1d75:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d78:	a3 e8 6e 00 00       	mov    %eax,0x6ee8
    1d7d:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d80:	a3 ec 6e 00 00       	mov    %eax,0x6eec
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1d85:	83 ec 04             	sub    $0x4,%esp
    1d88:	ff 35 ec 6e 00 00    	pushl  0x6eec
    1d8e:	ff 35 e8 6e 00 00    	pushl  0x6ee8
    1d94:	ff 35 e4 6e 00 00    	pushl  0x6ee4
    1d9a:	e8 52 f0 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1d9f:	83 c4 10             	add    $0x10,%esp
    1da2:	a3 fc 6e 00 00       	mov    %eax,0x6efc
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1da7:	8d 45 88             	lea    -0x78(%ebp),%eax
    1daa:	83 ec 08             	sub    $0x8,%esp
    1dad:	68 db 27 00 00       	push   $0x27db
    1db2:	50                   	push   %eax
    1db3:	e8 ff ed ff ff       	call   bb7 <APLoadBitmap>
    1db8:	83 c4 0c             	add    $0xc,%esp
    1dbb:	8b 45 88             	mov    -0x78(%ebp),%eax
    1dbe:	a3 20 6f 00 00       	mov    %eax,0x6f20
    1dc3:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1dc6:	a3 24 6f 00 00       	mov    %eax,0x6f24
    1dcb:	8b 45 90             	mov    -0x70(%ebp),%eax
    1dce:	a3 28 6f 00 00       	mov    %eax,0x6f28
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1dd3:	83 ec 04             	sub    $0x4,%esp
    1dd6:	ff 35 28 6f 00 00    	pushl  0x6f28
    1ddc:	ff 35 24 6f 00 00    	pushl  0x6f24
    1de2:	ff 35 20 6f 00 00    	pushl  0x6f20
    1de8:	e8 04 f0 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1ded:	83 c4 10             	add    $0x10,%esp
    1df0:	a3 4c 6f 00 00       	mov    %eax,0x6f4c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1df5:	8b 45 08             	mov    0x8(%ebp),%eax
    1df8:	8b 40 08             	mov    0x8(%eax),%eax
    1dfb:	85 c0                	test   %eax,%eax
    1dfd:	75 17                	jne    1e16 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1dff:	83 ec 08             	sub    $0x8,%esp
    1e02:	68 ec 27 00 00       	push   $0x27ec
    1e07:	6a 01                	push   $0x1
    1e09:	e8 23 e9 ff ff       	call   731 <printf>
    1e0e:	83 c4 10             	add    $0x10,%esp
        return;
    1e11:	e9 07 05 00 00       	jmp    231d <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1e16:	8b 45 08             	mov    0x8(%ebp),%eax
    1e19:	8b 40 10             	mov    0x10(%eax),%eax
    1e1c:	85 c0                	test   %eax,%eax
    1e1e:	7e 10                	jle    1e30 <APGridPaint+0x27d>
    1e20:	8b 45 08             	mov    0x8(%ebp),%eax
    1e23:	8b 50 14             	mov    0x14(%eax),%edx
    1e26:	8b 45 08             	mov    0x8(%ebp),%eax
    1e29:	8b 40 10             	mov    0x10(%eax),%eax
    1e2c:	39 c2                	cmp    %eax,%edx
    1e2e:	7c 17                	jl     1e47 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1e30:	83 ec 08             	sub    $0x8,%esp
    1e33:	68 12 28 00 00       	push   $0x2812
    1e38:	6a 01                	push   $0x1
    1e3a:	e8 f2 e8 ff ff       	call   731 <printf>
    1e3f:	83 c4 10             	add    $0x10,%esp
        return;
    1e42:	e9 d6 04 00 00       	jmp    231d <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1e47:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4a:	8b 40 14             	mov    0x14(%eax),%eax
    1e4d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1e53:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1e56:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1e59:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e5c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1e63:	e9 96 03 00 00       	jmp    21fe <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e68:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1e6f:	e9 7c 03 00 00       	jmp    21f0 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1e74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e77:	c1 e0 04             	shl    $0x4,%eax
    1e7a:	89 c2                	mov    %eax,%edx
    1e7c:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1e7f:	01 c2                	add    %eax,%edx
    1e81:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e84:	01 d0                	add    %edx,%eax
    1e86:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1e89:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8c:	8b 40 0c             	mov    0xc(%eax),%eax
    1e8f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1e92:	c1 e2 02             	shl    $0x2,%edx
    1e95:	01 d0                	add    %edx,%eax
    1e97:	8b 00                	mov    (%eax),%eax
    1e99:	83 f8 07             	cmp    $0x7,%eax
    1e9c:	0f 87 49 03 00 00    	ja     21eb <APGridPaint+0x638>
    1ea2:	8b 04 85 28 28 00 00 	mov    0x2828(,%eax,4),%eax
    1ea9:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1eab:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1eae:	6a 0c                	push   $0xc
    1eb0:	6a 0c                	push   $0xc
    1eb2:	6a 0c                	push   $0xc
    1eb4:	50                   	push   %eax
    1eb5:	e8 df f8 ff ff       	call   1799 <RGB>
    1eba:	83 c4 0c             	add    $0xc,%esp
    1ebd:	8b 1d 0c 6f 00 00    	mov    0x6f0c,%ebx
    1ec3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ec6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ec9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ecc:	6b c0 32             	imul   $0x32,%eax,%eax
    1ecf:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1ed2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ed8:	83 ec 0c             	sub    $0xc,%esp
    1edb:	83 ec 04             	sub    $0x4,%esp
    1ede:	89 e0                	mov    %esp,%eax
    1ee0:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1ee4:	66 89 30             	mov    %si,(%eax)
    1ee7:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1eeb:	88 50 02             	mov    %dl,0x2(%eax)
    1eee:	6a 32                	push   $0x32
    1ef0:	6a 32                	push   $0x32
    1ef2:	6a 00                	push   $0x0
    1ef4:	6a 00                	push   $0x0
    1ef6:	53                   	push   %ebx
    1ef7:	51                   	push   %ecx
    1ef8:	ff 75 84             	pushl  -0x7c(%ebp)
    1efb:	57                   	push   %edi
    1efc:	e8 f4 f6 ff ff       	call   15f5 <APDcCopy>
    1f01:	83 c4 30             	add    $0x30,%esp
                    break;
    1f04:	e9 e3 02 00 00       	jmp    21ec <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1f09:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f0c:	6a 69                	push   $0x69
    1f0e:	6a 69                	push   $0x69
    1f10:	6a 69                	push   $0x69
    1f12:	50                   	push   %eax
    1f13:	e8 81 f8 ff ff       	call   1799 <RGB>
    1f18:	83 c4 0c             	add    $0xc,%esp
    1f1b:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f1f:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1f23:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f27:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1f2a:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1f31:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f34:	6a 69                	push   $0x69
    1f36:	6a 69                	push   $0x69
    1f38:	6a 69                	push   $0x69
    1f3a:	50                   	push   %eax
    1f3b:	e8 59 f8 ff ff       	call   1799 <RGB>
    1f40:	83 c4 0c             	add    $0xc,%esp
    1f43:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f47:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1f4b:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f4f:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1f52:	8b 45 08             	mov    0x8(%ebp),%eax
    1f55:	8d 50 3c             	lea    0x3c(%eax),%edx
    1f58:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f5b:	ff 75 ac             	pushl  -0x54(%ebp)
    1f5e:	ff 75 a8             	pushl  -0x58(%ebp)
    1f61:	52                   	push   %edx
    1f62:	50                   	push   %eax
    1f63:	e8 1e ef ff ff       	call   e86 <APSetPen>
    1f68:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1f6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6e:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1f71:	8d 55 88             	lea    -0x78(%ebp),%edx
    1f74:	83 ec 04             	sub    $0x4,%esp
    1f77:	83 ec 04             	sub    $0x4,%esp
    1f7a:	89 e0                	mov    %esp,%eax
    1f7c:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1f80:	66 89 08             	mov    %cx,(%eax)
    1f83:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1f87:	88 48 02             	mov    %cl,0x2(%eax)
    1f8a:	53                   	push   %ebx
    1f8b:	52                   	push   %edx
    1f8c:	e8 2e ef ff ff       	call   ebf <APSetBrush>
    1f91:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1f94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f97:	6b d0 32             	imul   $0x32,%eax,%edx
    1f9a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f9d:	6b c0 32             	imul   $0x32,%eax,%eax
    1fa0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1fa3:	83 c1 3c             	add    $0x3c,%ecx
    1fa6:	83 ec 0c             	sub    $0xc,%esp
    1fa9:	6a 32                	push   $0x32
    1fab:	6a 32                	push   $0x32
    1fad:	52                   	push   %edx
    1fae:	50                   	push   %eax
    1faf:	51                   	push   %ecx
    1fb0:	e8 34 f3 ff ff       	call   12e9 <APDrawRect>
    1fb5:	83 c4 20             	add    $0x20,%esp
                    break;
    1fb8:	e9 2f 02 00 00       	jmp    21ec <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fbd:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1fc0:	6a 0c                	push   $0xc
    1fc2:	6a 0c                	push   $0xc
    1fc4:	6a 0c                	push   $0xc
    1fc6:	50                   	push   %eax
    1fc7:	e8 cd f7 ff ff       	call   1799 <RGB>
    1fcc:	83 c4 0c             	add    $0xc,%esp
    1fcf:	8b 1d 4c 6f 00 00    	mov    0x6f4c,%ebx
    1fd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fd8:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fdb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fde:	6b c0 32             	imul   $0x32,%eax,%eax
    1fe1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1fe4:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe7:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fea:	83 ec 0c             	sub    $0xc,%esp
    1fed:	83 ec 04             	sub    $0x4,%esp
    1ff0:	89 e0                	mov    %esp,%eax
    1ff2:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1ff6:	66 89 30             	mov    %si,(%eax)
    1ff9:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ffd:	88 50 02             	mov    %dl,0x2(%eax)
    2000:	6a 32                	push   $0x32
    2002:	6a 32                	push   $0x32
    2004:	6a 00                	push   $0x0
    2006:	6a 00                	push   $0x0
    2008:	53                   	push   %ebx
    2009:	51                   	push   %ecx
    200a:	ff 75 84             	pushl  -0x7c(%ebp)
    200d:	57                   	push   %edi
    200e:	e8 e2 f5 ff ff       	call   15f5 <APDcCopy>
    2013:	83 c4 30             	add    $0x30,%esp
                    break;
    2016:	e9 d1 01 00 00       	jmp    21ec <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    201b:	8d 45 c9             	lea    -0x37(%ebp),%eax
    201e:	6a 0c                	push   $0xc
    2020:	6a 0c                	push   $0xc
    2022:	6a 0c                	push   $0xc
    2024:	50                   	push   %eax
    2025:	e8 6f f7 ff ff       	call   1799 <RGB>
    202a:	83 c4 0c             	add    $0xc,%esp
    202d:	8b 1d 2c 6f 00 00    	mov    0x6f2c,%ebx
    2033:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2036:	6b c8 32             	imul   $0x32,%eax,%ecx
    2039:	8b 45 e0             	mov    -0x20(%ebp),%eax
    203c:	6b c0 32             	imul   $0x32,%eax,%eax
    203f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2042:	8b 45 08             	mov    0x8(%ebp),%eax
    2045:	8d 78 3c             	lea    0x3c(%eax),%edi
    2048:	83 ec 0c             	sub    $0xc,%esp
    204b:	83 ec 04             	sub    $0x4,%esp
    204e:	89 e0                	mov    %esp,%eax
    2050:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2054:	66 89 30             	mov    %si,(%eax)
    2057:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    205b:	88 50 02             	mov    %dl,0x2(%eax)
    205e:	6a 32                	push   $0x32
    2060:	6a 32                	push   $0x32
    2062:	6a 00                	push   $0x0
    2064:	6a 00                	push   $0x0
    2066:	53                   	push   %ebx
    2067:	51                   	push   %ecx
    2068:	ff 75 84             	pushl  -0x7c(%ebp)
    206b:	57                   	push   %edi
    206c:	e8 84 f5 ff ff       	call   15f5 <APDcCopy>
    2071:	83 c4 30             	add    $0x30,%esp
                    break;
    2074:	e9 73 01 00 00       	jmp    21ec <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2079:	8d 45 cc             	lea    -0x34(%ebp),%eax
    207c:	6a 0c                	push   $0xc
    207e:	6a 0c                	push   $0xc
    2080:	6a 0c                	push   $0xc
    2082:	50                   	push   %eax
    2083:	e8 11 f7 ff ff       	call   1799 <RGB>
    2088:	83 c4 0c             	add    $0xc,%esp
    208b:	8b 1d 10 6f 00 00    	mov    0x6f10,%ebx
    2091:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2094:	6b c8 32             	imul   $0x32,%eax,%ecx
    2097:	8b 45 e0             	mov    -0x20(%ebp),%eax
    209a:	6b c0 32             	imul   $0x32,%eax,%eax
    209d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    20a0:	8b 45 08             	mov    0x8(%ebp),%eax
    20a3:	8d 78 3c             	lea    0x3c(%eax),%edi
    20a6:	83 ec 0c             	sub    $0xc,%esp
    20a9:	83 ec 04             	sub    $0x4,%esp
    20ac:	89 e0                	mov    %esp,%eax
    20ae:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    20b2:	66 89 30             	mov    %si,(%eax)
    20b5:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    20b9:	88 50 02             	mov    %dl,0x2(%eax)
    20bc:	6a 32                	push   $0x32
    20be:	6a 32                	push   $0x32
    20c0:	6a 00                	push   $0x0
    20c2:	6a 00                	push   $0x0
    20c4:	53                   	push   %ebx
    20c5:	51                   	push   %ecx
    20c6:	ff 75 84             	pushl  -0x7c(%ebp)
    20c9:	57                   	push   %edi
    20ca:	e8 26 f5 ff ff       	call   15f5 <APDcCopy>
    20cf:	83 c4 30             	add    $0x30,%esp
                    break;
    20d2:	e9 15 01 00 00       	jmp    21ec <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20d7:	8d 45 cf             	lea    -0x31(%ebp),%eax
    20da:	6a 0c                	push   $0xc
    20dc:	6a 0c                	push   $0xc
    20de:	6a 0c                	push   $0xc
    20e0:	50                   	push   %eax
    20e1:	e8 b3 f6 ff ff       	call   1799 <RGB>
    20e6:	83 c4 0c             	add    $0xc,%esp
    20e9:	8b 1d 48 6f 00 00    	mov    0x6f48,%ebx
    20ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20f2:	6b c8 32             	imul   $0x32,%eax,%ecx
    20f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20f8:	6b c0 32             	imul   $0x32,%eax,%eax
    20fb:	89 45 84             	mov    %eax,-0x7c(%ebp)
    20fe:	8b 45 08             	mov    0x8(%ebp),%eax
    2101:	8d 78 3c             	lea    0x3c(%eax),%edi
    2104:	83 ec 0c             	sub    $0xc,%esp
    2107:	83 ec 04             	sub    $0x4,%esp
    210a:	89 e0                	mov    %esp,%eax
    210c:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2110:	66 89 30             	mov    %si,(%eax)
    2113:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2117:	88 50 02             	mov    %dl,0x2(%eax)
    211a:	6a 32                	push   $0x32
    211c:	6a 32                	push   $0x32
    211e:	6a 00                	push   $0x0
    2120:	6a 00                	push   $0x0
    2122:	53                   	push   %ebx
    2123:	51                   	push   %ecx
    2124:	ff 75 84             	pushl  -0x7c(%ebp)
    2127:	57                   	push   %edi
    2128:	e8 c8 f4 ff ff       	call   15f5 <APDcCopy>
    212d:	83 c4 30             	add    $0x30,%esp
                    break;
    2130:	e9 b7 00 00 00       	jmp    21ec <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2135:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2138:	6a 0c                	push   $0xc
    213a:	6a 0c                	push   $0xc
    213c:	6a 0c                	push   $0xc
    213e:	50                   	push   %eax
    213f:	e8 55 f6 ff ff       	call   1799 <RGB>
    2144:	83 c4 0c             	add    $0xc,%esp
    2147:	8b 1d e0 6e 00 00    	mov    0x6ee0,%ebx
    214d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2150:	6b c8 32             	imul   $0x32,%eax,%ecx
    2153:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2156:	6b c0 32             	imul   $0x32,%eax,%eax
    2159:	89 45 84             	mov    %eax,-0x7c(%ebp)
    215c:	8b 45 08             	mov    0x8(%ebp),%eax
    215f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2162:	83 ec 0c             	sub    $0xc,%esp
    2165:	83 ec 04             	sub    $0x4,%esp
    2168:	89 e0                	mov    %esp,%eax
    216a:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    216e:	66 89 30             	mov    %si,(%eax)
    2171:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2175:	88 50 02             	mov    %dl,0x2(%eax)
    2178:	6a 32                	push   $0x32
    217a:	6a 32                	push   $0x32
    217c:	6a 00                	push   $0x0
    217e:	6a 00                	push   $0x0
    2180:	53                   	push   %ebx
    2181:	51                   	push   %ecx
    2182:	ff 75 84             	pushl  -0x7c(%ebp)
    2185:	57                   	push   %edi
    2186:	e8 6a f4 ff ff       	call   15f5 <APDcCopy>
    218b:	83 c4 30             	add    $0x30,%esp
                    break;
    218e:	eb 5c                	jmp    21ec <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2190:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2193:	6a 0c                	push   $0xc
    2195:	6a 0c                	push   $0xc
    2197:	6a 0c                	push   $0xc
    2199:	50                   	push   %eax
    219a:	e8 fa f5 ff ff       	call   1799 <RGB>
    219f:	83 c4 0c             	add    $0xc,%esp
    21a2:	8b 1d fc 6e 00 00    	mov    0x6efc,%ebx
    21a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21ab:	6b c8 32             	imul   $0x32,%eax,%ecx
    21ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21b1:	6b c0 32             	imul   $0x32,%eax,%eax
    21b4:	89 45 84             	mov    %eax,-0x7c(%ebp)
    21b7:	8b 45 08             	mov    0x8(%ebp),%eax
    21ba:	8d 78 3c             	lea    0x3c(%eax),%edi
    21bd:	83 ec 0c             	sub    $0xc,%esp
    21c0:	83 ec 04             	sub    $0x4,%esp
    21c3:	89 e0                	mov    %esp,%eax
    21c5:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    21c9:	66 89 30             	mov    %si,(%eax)
    21cc:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    21d0:	88 50 02             	mov    %dl,0x2(%eax)
    21d3:	6a 32                	push   $0x32
    21d5:	6a 32                	push   $0x32
    21d7:	6a 00                	push   $0x0
    21d9:	6a 00                	push   $0x0
    21db:	53                   	push   %ebx
    21dc:	51                   	push   %ecx
    21dd:	ff 75 84             	pushl  -0x7c(%ebp)
    21e0:	57                   	push   %edi
    21e1:	e8 0f f4 ff ff       	call   15f5 <APDcCopy>
    21e6:	83 c4 30             	add    $0x30,%esp
                    break;
    21e9:	eb 01                	jmp    21ec <APGridPaint+0x639>
                default: break;
    21eb:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    21ec:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    21f0:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    21f4:	0f 8e 7a fc ff ff    	jle    1e74 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    21fa:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    21fe:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2202:	0f 8e 60 fc ff ff    	jle    1e68 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2208:	8d 45 88             	lea    -0x78(%ebp),%eax
    220b:	68 cd 00 00 00       	push   $0xcd
    2210:	6a 74                	push   $0x74
    2212:	6a 18                	push   $0x18
    2214:	50                   	push   %eax
    2215:	e8 7f f5 ff ff       	call   1799 <RGB>
    221a:	83 c4 0c             	add    $0xc,%esp
    221d:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2221:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2225:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2229:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    222c:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2233:	8d 45 88             	lea    -0x78(%ebp),%eax
    2236:	68 cd 00 00 00       	push   $0xcd
    223b:	6a 74                	push   $0x74
    223d:	6a 18                	push   $0x18
    223f:	50                   	push   %eax
    2240:	e8 54 f5 ff ff       	call   1799 <RGB>
    2245:	83 c4 0c             	add    $0xc,%esp
    2248:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    224c:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2250:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2254:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2257:	8b 45 08             	mov    0x8(%ebp),%eax
    225a:	8d 50 58             	lea    0x58(%eax),%edx
    225d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2260:	ff 75 bc             	pushl  -0x44(%ebp)
    2263:	ff 75 b8             	pushl  -0x48(%ebp)
    2266:	52                   	push   %edx
    2267:	50                   	push   %eax
    2268:	e8 19 ec ff ff       	call   e86 <APSetPen>
    226d:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2270:	8b 45 08             	mov    0x8(%ebp),%eax
    2273:	8d 58 58             	lea    0x58(%eax),%ebx
    2276:	8d 55 88             	lea    -0x78(%ebp),%edx
    2279:	83 ec 04             	sub    $0x4,%esp
    227c:	83 ec 04             	sub    $0x4,%esp
    227f:	89 e0                	mov    %esp,%eax
    2281:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2285:	66 89 08             	mov    %cx,(%eax)
    2288:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    228c:	88 48 02             	mov    %cl,0x2(%eax)
    228f:	53                   	push   %ebx
    2290:	52                   	push   %edx
    2291:	e8 29 ec ff ff       	call   ebf <APSetBrush>
    2296:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2299:	8b 45 08             	mov    0x8(%ebp),%eax
    229c:	83 c0 58             	add    $0x58,%eax
    229f:	83 ec 0c             	sub    $0xc,%esp
    22a2:	6a 32                	push   $0x32
    22a4:	68 20 03 00 00       	push   $0x320
    22a9:	6a 00                	push   $0x0
    22ab:	6a 00                	push   $0x0
    22ad:	50                   	push   %eax
    22ae:	e8 36 f0 ff ff       	call   12e9 <APDrawRect>
    22b3:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    22b6:	8d 45 88             	lea    -0x78(%ebp),%eax
    22b9:	6a 08                	push   $0x8
    22bb:	6a 08                	push   $0x8
    22bd:	6a 08                	push   $0x8
    22bf:	50                   	push   %eax
    22c0:	e8 d4 f4 ff ff       	call   1799 <RGB>
    22c5:	83 c4 0c             	add    $0xc,%esp
    22c8:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    22cc:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    22d0:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    22d4:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    22d7:	8b 45 08             	mov    0x8(%ebp),%eax
    22da:	8d 58 58             	lea    0x58(%eax),%ebx
    22dd:	8d 55 88             	lea    -0x78(%ebp),%edx
    22e0:	83 ec 04             	sub    $0x4,%esp
    22e3:	83 ec 04             	sub    $0x4,%esp
    22e6:	89 e0                	mov    %esp,%eax
    22e8:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    22ec:	66 89 08             	mov    %cx,(%eax)
    22ef:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    22f3:	88 48 02             	mov    %cl,0x2(%eax)
    22f6:	53                   	push   %ebx
    22f7:	52                   	push   %edx
    22f8:	e8 04 ec ff ff       	call   f01 <APSetFont>
    22fd:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    2300:	8b 45 08             	mov    0x8(%ebp),%eax
    2303:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2309:	8b 45 08             	mov    0x8(%ebp),%eax
    230c:	83 c0 58             	add    $0x58,%eax
    230f:	6a 14                	push   $0x14
    2311:	6a 14                	push   $0x14
    2313:	52                   	push   %edx
    2314:	50                   	push   %eax
    2315:	e8 d4 f1 ff ff       	call   14ee <APDrawText>
    231a:	83 c4 10             	add    $0x10,%esp
}
    231d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2320:	5b                   	pop    %ebx
    2321:	5e                   	pop    %esi
    2322:	5f                   	pop    %edi
    2323:	5d                   	pop    %ebp
    2324:	c3                   	ret    

00002325 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2325:	55                   	push   %ebp
    2326:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2328:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    232c:	7e 08                	jle    2336 <random+0x11>
{
rand_num = seed;
    232e:	8b 45 08             	mov    0x8(%ebp),%eax
    2331:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
}
rand_num *= 3;
    2336:	8b 15 a0 6a 00 00    	mov    0x6aa0,%edx
    233c:	89 d0                	mov    %edx,%eax
    233e:	01 c0                	add    %eax,%eax
    2340:	01 d0                	add    %edx,%eax
    2342:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
if (rand_num < 0)
    2347:	a1 a0 6a 00 00       	mov    0x6aa0,%eax
    234c:	85 c0                	test   %eax,%eax
    234e:	79 0c                	jns    235c <random+0x37>
{
rand_num *= (-1);
    2350:	a1 a0 6a 00 00       	mov    0x6aa0,%eax
    2355:	f7 d8                	neg    %eax
    2357:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
}
return rand_num % 997;
    235c:	8b 0d a0 6a 00 00    	mov    0x6aa0,%ecx
    2362:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2367:	89 c8                	mov    %ecx,%eax
    2369:	f7 ea                	imul   %edx
    236b:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    236e:	c1 f8 09             	sar    $0x9,%eax
    2371:	89 c2                	mov    %eax,%edx
    2373:	89 c8                	mov    %ecx,%eax
    2375:	c1 f8 1f             	sar    $0x1f,%eax
    2378:	29 c2                	sub    %eax,%edx
    237a:	89 d0                	mov    %edx,%eax
    237c:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2382:	29 c1                	sub    %eax,%ecx
    2384:	89 c8                	mov    %ecx,%eax
}
    2386:	5d                   	pop    %ebp
    2387:	c3                   	ret    

00002388 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2388:	55                   	push   %ebp
    2389:	89 e5                	mov    %esp,%ebp
    238b:	53                   	push   %ebx
    238c:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    238f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2396:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    239a:	74 17                	je     23b3 <sprintint+0x2b>
    239c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    23a0:	79 11                	jns    23b3 <sprintint+0x2b>
        neg = 1;
    23a2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    23a9:	8b 45 10             	mov    0x10(%ebp),%eax
    23ac:	f7 d8                	neg    %eax
    23ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23b1:	eb 06                	jmp    23b9 <sprintint+0x31>
    } else {
        x = xx;
    23b3:	8b 45 10             	mov    0x10(%ebp),%eax
    23b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    23b9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    23c0:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    23c3:	8d 41 01             	lea    0x1(%ecx),%eax
    23c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    23c9:	8b 5d 14             	mov    0x14(%ebp),%ebx
    23cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23cf:	ba 00 00 00 00       	mov    $0x0,%edx
    23d4:	f7 f3                	div    %ebx
    23d6:	89 d0                	mov    %edx,%eax
    23d8:	0f b6 80 a4 6a 00 00 	movzbl 0x6aa4(%eax),%eax
    23df:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    23e3:	8b 5d 14             	mov    0x14(%ebp),%ebx
    23e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23e9:	ba 00 00 00 00       	mov    $0x0,%edx
    23ee:	f7 f3                	div    %ebx
    23f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    23f7:	75 c7                	jne    23c0 <sprintint+0x38>
    if(neg)
    23f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    23fd:	74 0e                	je     240d <sprintint+0x85>
        buf[i++] = '-';
    23ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2402:	8d 50 01             	lea    0x1(%eax),%edx
    2405:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2408:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    240d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2410:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2413:	eb 1b                	jmp    2430 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2415:	8b 45 0c             	mov    0xc(%ebp),%eax
    2418:	8b 00                	mov    (%eax),%eax
    241a:	8d 48 01             	lea    0x1(%eax),%ecx
    241d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2420:	89 0a                	mov    %ecx,(%edx)
    2422:	89 c2                	mov    %eax,%edx
    2424:	8b 45 08             	mov    0x8(%ebp),%eax
    2427:	01 d0                	add    %edx,%eax
    2429:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    242c:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2430:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2434:	7f df                	jg     2415 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2436:	eb 21                	jmp    2459 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2438:	8b 45 0c             	mov    0xc(%ebp),%eax
    243b:	8b 00                	mov    (%eax),%eax
    243d:	8d 48 01             	lea    0x1(%eax),%ecx
    2440:	8b 55 0c             	mov    0xc(%ebp),%edx
    2443:	89 0a                	mov    %ecx,(%edx)
    2445:	89 c2                	mov    %eax,%edx
    2447:	8b 45 08             	mov    0x8(%ebp),%eax
    244a:	01 c2                	add    %eax,%edx
    244c:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    244f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2452:	01 c8                	add    %ecx,%eax
    2454:	0f b6 00             	movzbl (%eax),%eax
    2457:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2459:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    245d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2461:	79 d5                	jns    2438 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2463:	90                   	nop
    2464:	83 c4 20             	add    $0x20,%esp
    2467:	5b                   	pop    %ebx
    2468:	5d                   	pop    %ebp
    2469:	c3                   	ret    

0000246a <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    246a:	55                   	push   %ebp
    246b:	89 e5                	mov    %esp,%ebp
    246d:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2470:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2477:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    247e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2485:	8d 45 0c             	lea    0xc(%ebp),%eax
    2488:	83 c0 04             	add    $0x4,%eax
    248b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    248e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2495:	e9 d9 01 00 00       	jmp    2673 <sprintf+0x209>
        c = fmt[i] & 0xff;
    249a:	8b 55 0c             	mov    0xc(%ebp),%edx
    249d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24a0:	01 d0                	add    %edx,%eax
    24a2:	0f b6 00             	movzbl (%eax),%eax
    24a5:	0f be c0             	movsbl %al,%eax
    24a8:	25 ff 00 00 00       	and    $0xff,%eax
    24ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    24b0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    24b4:	75 2c                	jne    24e2 <sprintf+0x78>
            if(c == '%'){
    24b6:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    24ba:	75 0c                	jne    24c8 <sprintf+0x5e>
                state = '%';
    24bc:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    24c3:	e9 a7 01 00 00       	jmp    266f <sprintf+0x205>
            } else {
                dst[j++] = c;
    24c8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24cb:	8d 50 01             	lea    0x1(%eax),%edx
    24ce:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24d1:	89 c2                	mov    %eax,%edx
    24d3:	8b 45 08             	mov    0x8(%ebp),%eax
    24d6:	01 d0                	add    %edx,%eax
    24d8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24db:	88 10                	mov    %dl,(%eax)
    24dd:	e9 8d 01 00 00       	jmp    266f <sprintf+0x205>
            }
        } else if(state == '%'){
    24e2:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    24e6:	0f 85 83 01 00 00    	jne    266f <sprintf+0x205>
            if(c == 'd'){
    24ec:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    24f0:	75 4c                	jne    253e <sprintf+0xd4>
                buf[bi] = '\0';
    24f2:	8d 55 ce             	lea    -0x32(%ebp),%edx
    24f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24f8:	01 d0                	add    %edx,%eax
    24fa:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    24fd:	83 ec 0c             	sub    $0xc,%esp
    2500:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2503:	50                   	push   %eax
    2504:	e8 e7 df ff ff       	call   4f0 <atoi>
    2509:	83 c4 10             	add    $0x10,%esp
    250c:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    250f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2516:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2519:	8b 00                	mov    (%eax),%eax
    251b:	83 ec 08             	sub    $0x8,%esp
    251e:	ff 75 d8             	pushl  -0x28(%ebp)
    2521:	6a 01                	push   $0x1
    2523:	6a 0a                	push   $0xa
    2525:	50                   	push   %eax
    2526:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2529:	50                   	push   %eax
    252a:	ff 75 08             	pushl  0x8(%ebp)
    252d:	e8 56 fe ff ff       	call   2388 <sprintint>
    2532:	83 c4 20             	add    $0x20,%esp
                ap++;
    2535:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2539:	e9 2a 01 00 00       	jmp    2668 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    253e:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2542:	74 06                	je     254a <sprintf+0xe0>
    2544:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2548:	75 4c                	jne    2596 <sprintf+0x12c>
                buf[bi] = '\0';
    254a:	8d 55 ce             	lea    -0x32(%ebp),%edx
    254d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2550:	01 d0                	add    %edx,%eax
    2552:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2555:	83 ec 0c             	sub    $0xc,%esp
    2558:	8d 45 ce             	lea    -0x32(%ebp),%eax
    255b:	50                   	push   %eax
    255c:	e8 8f df ff ff       	call   4f0 <atoi>
    2561:	83 c4 10             	add    $0x10,%esp
    2564:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2567:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    256e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2571:	8b 00                	mov    (%eax),%eax
    2573:	83 ec 08             	sub    $0x8,%esp
    2576:	ff 75 dc             	pushl  -0x24(%ebp)
    2579:	6a 00                	push   $0x0
    257b:	6a 10                	push   $0x10
    257d:	50                   	push   %eax
    257e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2581:	50                   	push   %eax
    2582:	ff 75 08             	pushl  0x8(%ebp)
    2585:	e8 fe fd ff ff       	call   2388 <sprintint>
    258a:	83 c4 20             	add    $0x20,%esp
                ap++;
    258d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2591:	e9 d2 00 00 00       	jmp    2668 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2596:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    259a:	75 46                	jne    25e2 <sprintf+0x178>
                s = (char*)*ap;
    259c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    259f:	8b 00                	mov    (%eax),%eax
    25a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    25a4:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    25a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    25ac:	75 25                	jne    25d3 <sprintf+0x169>
                    s = "(null)";
    25ae:	c7 45 f4 48 28 00 00 	movl   $0x2848,-0xc(%ebp)
                while(*s != 0){
    25b5:	eb 1c                	jmp    25d3 <sprintf+0x169>
                    dst[j++] = *s;
    25b7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25ba:	8d 50 01             	lea    0x1(%eax),%edx
    25bd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25c0:	89 c2                	mov    %eax,%edx
    25c2:	8b 45 08             	mov    0x8(%ebp),%eax
    25c5:	01 c2                	add    %eax,%edx
    25c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25ca:	0f b6 00             	movzbl (%eax),%eax
    25cd:	88 02                	mov    %al,(%edx)
                    s++;
    25cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    25d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25d6:	0f b6 00             	movzbl (%eax),%eax
    25d9:	84 c0                	test   %al,%al
    25db:	75 da                	jne    25b7 <sprintf+0x14d>
    25dd:	e9 86 00 00 00       	jmp    2668 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    25e2:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    25e6:	75 1d                	jne    2605 <sprintf+0x19b>
                dst[j++] = *ap;
    25e8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25eb:	8d 50 01             	lea    0x1(%eax),%edx
    25ee:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25f1:	89 c2                	mov    %eax,%edx
    25f3:	8b 45 08             	mov    0x8(%ebp),%eax
    25f6:	01 c2                	add    %eax,%edx
    25f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25fb:	8b 00                	mov    (%eax),%eax
    25fd:	88 02                	mov    %al,(%edx)
                ap++;
    25ff:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2603:	eb 63                	jmp    2668 <sprintf+0x1fe>
            } else if(c == '%'){
    2605:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2609:	75 17                	jne    2622 <sprintf+0x1b8>
                dst[j++] = c;
    260b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    260e:	8d 50 01             	lea    0x1(%eax),%edx
    2611:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2614:	89 c2                	mov    %eax,%edx
    2616:	8b 45 08             	mov    0x8(%ebp),%eax
    2619:	01 d0                	add    %edx,%eax
    261b:	8b 55 e0             	mov    -0x20(%ebp),%edx
    261e:	88 10                	mov    %dl,(%eax)
    2620:	eb 46                	jmp    2668 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2622:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2626:	7e 18                	jle    2640 <sprintf+0x1d6>
    2628:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    262c:	7f 12                	jg     2640 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    262e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2631:	8d 50 01             	lea    0x1(%eax),%edx
    2634:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2637:	8b 55 e0             	mov    -0x20(%ebp),%edx
    263a:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    263e:	eb 2f                	jmp    266f <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2640:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2643:	8d 50 01             	lea    0x1(%eax),%edx
    2646:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2649:	89 c2                	mov    %eax,%edx
    264b:	8b 45 08             	mov    0x8(%ebp),%eax
    264e:	01 d0                	add    %edx,%eax
    2650:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2653:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2656:	8d 50 01             	lea    0x1(%eax),%edx
    2659:	89 55 c8             	mov    %edx,-0x38(%ebp)
    265c:	89 c2                	mov    %eax,%edx
    265e:	8b 45 08             	mov    0x8(%ebp),%eax
    2661:	01 d0                	add    %edx,%eax
    2663:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2666:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2668:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    266f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2673:	8b 55 0c             	mov    0xc(%ebp),%edx
    2676:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2679:	01 d0                	add    %edx,%eax
    267b:	0f b6 00             	movzbl (%eax),%eax
    267e:	84 c0                	test   %al,%al
    2680:	0f 85 14 fe ff ff    	jne    249a <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2686:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2689:	8d 50 01             	lea    0x1(%eax),%edx
    268c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    268f:	89 c2                	mov    %eax,%edx
    2691:	8b 45 08             	mov    0x8(%ebp),%eax
    2694:	01 d0                	add    %edx,%eax
    2696:	c6 00 00             	movb   $0x0,(%eax)
}
    2699:	90                   	nop
    269a:	c9                   	leave  
    269b:	c3                   	ret    
