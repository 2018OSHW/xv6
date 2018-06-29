
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
      18:	c7 45 f0 e0 2c 00 00 	movl   $0x2ce0,-0x10(%ebp)
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
      84:	81 7d f0 e0 2c 00 00 	cmpl   $0x2ce0,-0x10(%ebp)
      8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
      8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	ba e0 2c 00 00       	mov    $0x2ce0,%edx
      a2:	29 d0                	sub    %edx,%eax
      a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	ff 75 f4             	pushl  -0xc(%ebp)
      ad:	ff 75 f0             	pushl  -0x10(%ebp)
      b0:	68 e0 2c 00 00       	push   $0x2ce0
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
      ce:	05 e0 2c 00 00       	add    $0x2ce0,%eax
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
     10f:	68 f4 24 00 00       	push   $0x24f4
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
     18c:	68 14 25 00 00       	push   $0x2514
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
     6cd:	0f b6 80 80 2c 00 00 	movzbl 0x2c80(%eax),%eax
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
     80b:	c7 45 f4 2a 25 00 00 	movl   $0x252a,-0xc(%ebp)
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
     8d1:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
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
     99c:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
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
     9fd:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
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
     a19:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
     a1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a21:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a25:	75 23                	jne    a4a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a27:	c7 45 f0 c0 2c 00 00 	movl   $0x2cc0,-0x10(%ebp)
     a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a31:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
     a36:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
     a3b:	a3 c0 2c 00 00       	mov    %eax,0x2cc0
    base.s.size = 0;
     a40:	c7 05 c4 2c 00 00 00 	movl   $0x0,0x2cc4
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
     a9d:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
      return (void*)(p + 1);
     aa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa5:	83 c0 08             	add    $0x8,%eax
     aa8:	eb 3b                	jmp    ae5 <malloc+0xe1>
    }
    if(p == freep)
     aaa:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
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
     bf0:	68 31 25 00 00       	push   $0x2531
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

00000f01 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f01:	55                   	push   %ebp
     f02:	89 e5                	mov    %esp,%ebp
     f04:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f07:	8b 45 08             	mov    0x8(%ebp),%eax
     f0a:	8b 40 0c             	mov    0xc(%eax),%eax
     f0d:	89 c2                	mov    %eax,%edx
     f0f:	c1 ea 1f             	shr    $0x1f,%edx
     f12:	01 d0                	add    %edx,%eax
     f14:	d1 f8                	sar    %eax
     f16:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f19:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f1c:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f20:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f23:	8b 45 10             	mov    0x10(%ebp),%eax
     f26:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f29:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f2c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f30:	0f 89 98 00 00 00    	jns    fce <APDrawPoint+0xcd>
        i = 0;
     f36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f3d:	e9 8c 00 00 00       	jmp    fce <APDrawPoint+0xcd>
    {
        j = x - off;
     f42:	8b 45 0c             	mov    0xc(%ebp),%eax
     f45:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f48:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f4b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f4f:	79 69                	jns    fba <APDrawPoint+0xb9>
            j = 0;
     f51:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f58:	eb 60                	jmp    fba <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f5a:	ff 75 fc             	pushl  -0x4(%ebp)
     f5d:	ff 75 f8             	pushl  -0x8(%ebp)
     f60:	ff 75 08             	pushl  0x8(%ebp)
     f63:	e8 fd fb ff ff       	call   b65 <APGetIndex>
     f68:	83 c4 0c             	add    $0xc,%esp
     f6b:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     f6e:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     f72:	74 55                	je     fc9 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     f74:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     f78:	74 67                	je     fe1 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     f7a:	ff 75 10             	pushl  0x10(%ebp)
     f7d:	ff 75 0c             	pushl  0xc(%ebp)
     f80:	ff 75 fc             	pushl  -0x4(%ebp)
     f83:	ff 75 f8             	pushl  -0x8(%ebp)
     f86:	e8 a1 fb ff ff       	call   b2c <distance_2>
     f8b:	83 c4 10             	add    $0x10,%esp
     f8e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     f91:	7f 23                	jg     fb6 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     f93:	8b 45 08             	mov    0x8(%ebp),%eax
     f96:	8b 48 18             	mov    0x18(%eax),%ecx
     f99:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f9c:	89 d0                	mov    %edx,%eax
     f9e:	01 c0                	add    %eax,%eax
     fa0:	01 d0                	add    %edx,%eax
     fa2:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     fa5:	8b 45 08             	mov    0x8(%ebp),%eax
     fa8:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     fac:	66 89 0a             	mov    %cx,(%edx)
     faf:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     fb3:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     fb6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     fba:	8b 55 0c             	mov    0xc(%ebp),%edx
     fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc0:	01 d0                	add    %edx,%eax
     fc2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     fc5:	7d 93                	jge    f5a <APDrawPoint+0x59>
     fc7:	eb 01                	jmp    fca <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     fc9:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     fca:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     fce:	8b 55 10             	mov    0x10(%ebp),%edx
     fd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd4:	01 d0                	add    %edx,%eax
     fd6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     fd9:	0f 8d 63 ff ff ff    	jge    f42 <APDrawPoint+0x41>
     fdf:	eb 01                	jmp    fe2 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     fe1:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     fe2:	c9                   	leave  
     fe3:	c3                   	ret    

00000fe4 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     fe4:	55                   	push   %ebp
     fe5:	89 e5                	mov    %esp,%ebp
     fe7:	53                   	push   %ebx
     fe8:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     feb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fee:	3b 45 14             	cmp    0x14(%ebp),%eax
     ff1:	0f 85 80 00 00 00    	jne    1077 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
     ff7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ffb:	0f 88 9d 02 00 00    	js     129e <APDrawLine+0x2ba>
    1001:	8b 45 08             	mov    0x8(%ebp),%eax
    1004:	8b 00                	mov    (%eax),%eax
    1006:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1009:	0f 8e 8f 02 00 00    	jle    129e <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    100f:	8b 45 10             	mov    0x10(%ebp),%eax
    1012:	3b 45 18             	cmp    0x18(%ebp),%eax
    1015:	7e 12                	jle    1029 <APDrawLine+0x45>
        {
            int tmp = y2;
    1017:	8b 45 18             	mov    0x18(%ebp),%eax
    101a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    101d:	8b 45 10             	mov    0x10(%ebp),%eax
    1020:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1023:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1026:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1029:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    102d:	79 07                	jns    1036 <APDrawLine+0x52>
    102f:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1036:	8b 45 08             	mov    0x8(%ebp),%eax
    1039:	8b 40 04             	mov    0x4(%eax),%eax
    103c:	3b 45 18             	cmp    0x18(%ebp),%eax
    103f:	7d 0c                	jge    104d <APDrawLine+0x69>
    1041:	8b 45 08             	mov    0x8(%ebp),%eax
    1044:	8b 40 04             	mov    0x4(%eax),%eax
    1047:	83 e8 01             	sub    $0x1,%eax
    104a:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    104d:	8b 45 10             	mov    0x10(%ebp),%eax
    1050:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1053:	eb 15                	jmp    106a <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1055:	ff 75 f4             	pushl  -0xc(%ebp)
    1058:	ff 75 0c             	pushl  0xc(%ebp)
    105b:	ff 75 08             	pushl  0x8(%ebp)
    105e:	e8 9e fe ff ff       	call   f01 <APDrawPoint>
    1063:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1066:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    106a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1070:	7e e3                	jle    1055 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1072:	e9 2b 02 00 00       	jmp    12a2 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1077:	8b 45 10             	mov    0x10(%ebp),%eax
    107a:	3b 45 18             	cmp    0x18(%ebp),%eax
    107d:	75 7f                	jne    10fe <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    107f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1083:	0f 88 18 02 00 00    	js     12a1 <APDrawLine+0x2bd>
    1089:	8b 45 08             	mov    0x8(%ebp),%eax
    108c:	8b 40 04             	mov    0x4(%eax),%eax
    108f:	3b 45 10             	cmp    0x10(%ebp),%eax
    1092:	0f 8e 09 02 00 00    	jle    12a1 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1098:	8b 45 0c             	mov    0xc(%ebp),%eax
    109b:	3b 45 14             	cmp    0x14(%ebp),%eax
    109e:	7e 12                	jle    10b2 <APDrawLine+0xce>
        {
            int tmp = x2;
    10a0:	8b 45 14             	mov    0x14(%ebp),%eax
    10a3:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    10a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a9:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10ac:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10af:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10b6:	79 07                	jns    10bf <APDrawLine+0xdb>
    10b8:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    10bf:	8b 45 08             	mov    0x8(%ebp),%eax
    10c2:	8b 00                	mov    (%eax),%eax
    10c4:	3b 45 14             	cmp    0x14(%ebp),%eax
    10c7:	7d 0b                	jge    10d4 <APDrawLine+0xf0>
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
    10cc:	8b 00                	mov    (%eax),%eax
    10ce:	83 e8 01             	sub    $0x1,%eax
    10d1:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    10d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    10d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10da:	eb 15                	jmp    10f1 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    10dc:	ff 75 10             	pushl  0x10(%ebp)
    10df:	ff 75 f0             	pushl  -0x10(%ebp)
    10e2:	ff 75 08             	pushl  0x8(%ebp)
    10e5:	e8 17 fe ff ff       	call   f01 <APDrawPoint>
    10ea:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    10ed:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    10f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10f4:	3b 45 14             	cmp    0x14(%ebp),%eax
    10f7:	7e e3                	jle    10dc <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    10f9:	e9 a4 01 00 00       	jmp    12a2 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    10fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1105:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    110c:	8b 45 0c             	mov    0xc(%ebp),%eax
    110f:	2b 45 14             	sub    0x14(%ebp),%eax
    1112:	50                   	push   %eax
    1113:	e8 3d fa ff ff       	call   b55 <abs_int>
    1118:	83 c4 04             	add    $0x4,%esp
    111b:	89 c3                	mov    %eax,%ebx
    111d:	8b 45 10             	mov    0x10(%ebp),%eax
    1120:	2b 45 18             	sub    0x18(%ebp),%eax
    1123:	50                   	push   %eax
    1124:	e8 2c fa ff ff       	call   b55 <abs_int>
    1129:	83 c4 04             	add    $0x4,%esp
    112c:	39 c3                	cmp    %eax,%ebx
    112e:	0f 8e b5 00 00 00    	jle    11e9 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1134:	8b 45 10             	mov    0x10(%ebp),%eax
    1137:	2b 45 18             	sub    0x18(%ebp),%eax
    113a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    113d:	db 45 b0             	fildl  -0x50(%ebp)
    1140:	8b 45 0c             	mov    0xc(%ebp),%eax
    1143:	2b 45 14             	sub    0x14(%ebp),%eax
    1146:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1149:	db 45 b0             	fildl  -0x50(%ebp)
    114c:	de f9                	fdivrp %st,%st(1)
    114e:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1151:	8b 45 14             	mov    0x14(%ebp),%eax
    1154:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1157:	7e 0e                	jle    1167 <APDrawLine+0x183>
        {
            s = x1;
    1159:	8b 45 0c             	mov    0xc(%ebp),%eax
    115c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    115f:	8b 45 14             	mov    0x14(%ebp),%eax
    1162:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1165:	eb 0c                	jmp    1173 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1167:	8b 45 14             	mov    0x14(%ebp),%eax
    116a:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    116d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1170:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1173:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1177:	79 07                	jns    1180 <APDrawLine+0x19c>
    1179:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1180:	8b 45 08             	mov    0x8(%ebp),%eax
    1183:	8b 00                	mov    (%eax),%eax
    1185:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1188:	7f 0b                	jg     1195 <APDrawLine+0x1b1>
    118a:	8b 45 08             	mov    0x8(%ebp),%eax
    118d:	8b 00                	mov    (%eax),%eax
    118f:	83 e8 01             	sub    $0x1,%eax
    1192:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1195:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1198:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    119b:	eb 3f                	jmp    11dc <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    119d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11a0:	2b 45 0c             	sub    0xc(%ebp),%eax
    11a3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11a6:	db 45 b0             	fildl  -0x50(%ebp)
    11a9:	dc 4d d0             	fmull  -0x30(%ebp)
    11ac:	db 45 10             	fildl  0x10(%ebp)
    11af:	de c1                	faddp  %st,%st(1)
    11b1:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11b4:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11b8:	b4 0c                	mov    $0xc,%ah
    11ba:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11be:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11c1:	db 5d cc             	fistpl -0x34(%ebp)
    11c4:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    11c7:	ff 75 cc             	pushl  -0x34(%ebp)
    11ca:	ff 75 e4             	pushl  -0x1c(%ebp)
    11cd:	ff 75 08             	pushl  0x8(%ebp)
    11d0:	e8 2c fd ff ff       	call   f01 <APDrawPoint>
    11d5:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    11d8:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    11dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11df:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11e2:	7e b9                	jle    119d <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    11e4:	e9 b9 00 00 00       	jmp    12a2 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    11e9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ec:	2b 45 14             	sub    0x14(%ebp),%eax
    11ef:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11f2:	db 45 b0             	fildl  -0x50(%ebp)
    11f5:	8b 45 10             	mov    0x10(%ebp),%eax
    11f8:	2b 45 18             	sub    0x18(%ebp),%eax
    11fb:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11fe:	db 45 b0             	fildl  -0x50(%ebp)
    1201:	de f9                	fdivrp %st,%st(1)
    1203:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1206:	8b 45 10             	mov    0x10(%ebp),%eax
    1209:	3b 45 18             	cmp    0x18(%ebp),%eax
    120c:	7e 0e                	jle    121c <APDrawLine+0x238>
    {
        s = y2;
    120e:	8b 45 18             	mov    0x18(%ebp),%eax
    1211:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1214:	8b 45 10             	mov    0x10(%ebp),%eax
    1217:	89 45 e8             	mov    %eax,-0x18(%ebp)
    121a:	eb 0c                	jmp    1228 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    121c:	8b 45 10             	mov    0x10(%ebp),%eax
    121f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1222:	8b 45 18             	mov    0x18(%ebp),%eax
    1225:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1228:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    122c:	79 07                	jns    1235 <APDrawLine+0x251>
    122e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1235:	8b 45 08             	mov    0x8(%ebp),%eax
    1238:	8b 40 04             	mov    0x4(%eax),%eax
    123b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    123e:	7f 0c                	jg     124c <APDrawLine+0x268>
    1240:	8b 45 08             	mov    0x8(%ebp),%eax
    1243:	8b 40 04             	mov    0x4(%eax),%eax
    1246:	83 e8 01             	sub    $0x1,%eax
    1249:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    124c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    124f:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1252:	eb 3f                	jmp    1293 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1254:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1257:	2b 45 10             	sub    0x10(%ebp),%eax
    125a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    125d:	db 45 b0             	fildl  -0x50(%ebp)
    1260:	dc 4d c0             	fmull  -0x40(%ebp)
    1263:	db 45 0c             	fildl  0xc(%ebp)
    1266:	de c1                	faddp  %st,%st(1)
    1268:	d9 7d b6             	fnstcw -0x4a(%ebp)
    126b:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    126f:	b4 0c                	mov    $0xc,%ah
    1271:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1275:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1278:	db 5d bc             	fistpl -0x44(%ebp)
    127b:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    127e:	ff 75 e0             	pushl  -0x20(%ebp)
    1281:	ff 75 bc             	pushl  -0x44(%ebp)
    1284:	ff 75 08             	pushl  0x8(%ebp)
    1287:	e8 75 fc ff ff       	call   f01 <APDrawPoint>
    128c:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    128f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1293:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1296:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1299:	7e b9                	jle    1254 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    129b:	90                   	nop
    129c:	eb 04                	jmp    12a2 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    129e:	90                   	nop
    129f:	eb 01                	jmp    12a2 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12a1:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12a5:	c9                   	leave  
    12a6:	c3                   	ret    

000012a7 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    12a7:	55                   	push   %ebp
    12a8:	89 e5                	mov    %esp,%ebp
    12aa:	53                   	push   %ebx
    12ab:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    12ae:	8b 55 10             	mov    0x10(%ebp),%edx
    12b1:	8b 45 18             	mov    0x18(%ebp),%eax
    12b4:	01 d0                	add    %edx,%eax
    12b6:	83 e8 01             	sub    $0x1,%eax
    12b9:	83 ec 04             	sub    $0x4,%esp
    12bc:	50                   	push   %eax
    12bd:	ff 75 0c             	pushl  0xc(%ebp)
    12c0:	ff 75 10             	pushl  0x10(%ebp)
    12c3:	ff 75 0c             	pushl  0xc(%ebp)
    12c6:	ff 75 08             	pushl  0x8(%ebp)
    12c9:	e8 16 fd ff ff       	call   fe4 <APDrawLine>
    12ce:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    12d1:	8b 55 0c             	mov    0xc(%ebp),%edx
    12d4:	8b 45 14             	mov    0x14(%ebp),%eax
    12d7:	01 d0                	add    %edx,%eax
    12d9:	83 e8 01             	sub    $0x1,%eax
    12dc:	83 ec 04             	sub    $0x4,%esp
    12df:	ff 75 10             	pushl  0x10(%ebp)
    12e2:	50                   	push   %eax
    12e3:	ff 75 10             	pushl  0x10(%ebp)
    12e6:	ff 75 0c             	pushl  0xc(%ebp)
    12e9:	ff 75 08             	pushl  0x8(%ebp)
    12ec:	e8 f3 fc ff ff       	call   fe4 <APDrawLine>
    12f1:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    12f4:	8b 55 10             	mov    0x10(%ebp),%edx
    12f7:	8b 45 18             	mov    0x18(%ebp),%eax
    12fa:	01 d0                	add    %edx,%eax
    12fc:	8d 48 ff             	lea    -0x1(%eax),%ecx
    12ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1302:	8b 45 14             	mov    0x14(%ebp),%eax
    1305:	01 d0                	add    %edx,%eax
    1307:	8d 50 ff             	lea    -0x1(%eax),%edx
    130a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    130d:	8b 45 14             	mov    0x14(%ebp),%eax
    1310:	01 d8                	add    %ebx,%eax
    1312:	83 e8 01             	sub    $0x1,%eax
    1315:	83 ec 04             	sub    $0x4,%esp
    1318:	51                   	push   %ecx
    1319:	52                   	push   %edx
    131a:	ff 75 10             	pushl  0x10(%ebp)
    131d:	50                   	push   %eax
    131e:	ff 75 08             	pushl  0x8(%ebp)
    1321:	e8 be fc ff ff       	call   fe4 <APDrawLine>
    1326:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1329:	8b 55 10             	mov    0x10(%ebp),%edx
    132c:	8b 45 18             	mov    0x18(%ebp),%eax
    132f:	01 d0                	add    %edx,%eax
    1331:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1334:	8b 55 0c             	mov    0xc(%ebp),%edx
    1337:	8b 45 14             	mov    0x14(%ebp),%eax
    133a:	01 d0                	add    %edx,%eax
    133c:	8d 50 ff             	lea    -0x1(%eax),%edx
    133f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1342:	8b 45 18             	mov    0x18(%ebp),%eax
    1345:	01 d8                	add    %ebx,%eax
    1347:	83 e8 01             	sub    $0x1,%eax
    134a:	83 ec 04             	sub    $0x4,%esp
    134d:	51                   	push   %ecx
    134e:	52                   	push   %edx
    134f:	50                   	push   %eax
    1350:	ff 75 0c             	pushl  0xc(%ebp)
    1353:	ff 75 08             	pushl  0x8(%ebp)
    1356:	e8 89 fc ff ff       	call   fe4 <APDrawLine>
    135b:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    135e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1361:	8b 45 14             	mov    0x14(%ebp),%eax
    1364:	01 d0                	add    %edx,%eax
    1366:	8d 50 ff             	lea    -0x1(%eax),%edx
    1369:	8b 45 08             	mov    0x8(%ebp),%eax
    136c:	8b 40 0c             	mov    0xc(%eax),%eax
    136f:	89 c1                	mov    %eax,%ecx
    1371:	c1 e9 1f             	shr    $0x1f,%ecx
    1374:	01 c8                	add    %ecx,%eax
    1376:	d1 f8                	sar    %eax
    1378:	29 c2                	sub    %eax,%edx
    137a:	89 d0                	mov    %edx,%eax
    137c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    137f:	8b 55 10             	mov    0x10(%ebp),%edx
    1382:	8b 45 18             	mov    0x18(%ebp),%eax
    1385:	01 d0                	add    %edx,%eax
    1387:	8d 50 ff             	lea    -0x1(%eax),%edx
    138a:	8b 45 08             	mov    0x8(%ebp),%eax
    138d:	8b 40 0c             	mov    0xc(%eax),%eax
    1390:	89 c1                	mov    %eax,%ecx
    1392:	c1 e9 1f             	shr    $0x1f,%ecx
    1395:	01 c8                	add    %ecx,%eax
    1397:	d1 f8                	sar    %eax
    1399:	29 c2                	sub    %eax,%edx
    139b:	89 d0                	mov    %edx,%eax
    139d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13a0:	8b 45 08             	mov    0x8(%ebp),%eax
    13a3:	8b 40 0c             	mov    0xc(%eax),%eax
    13a6:	89 c2                	mov    %eax,%edx
    13a8:	c1 ea 1f             	shr    $0x1f,%edx
    13ab:	01 d0                	add    %edx,%eax
    13ad:	d1 f8                	sar    %eax
    13af:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13b2:	8b 45 08             	mov    0x8(%ebp),%eax
    13b5:	8b 40 0c             	mov    0xc(%eax),%eax
    13b8:	89 c2                	mov    %eax,%edx
    13ba:	c1 ea 1f             	shr    $0x1f,%edx
    13bd:	01 d0                	add    %edx,%eax
    13bf:	d1 f8                	sar    %eax
    13c1:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    13c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13c8:	0f 88 d8 00 00 00    	js     14a6 <APDrawRect+0x1ff>
    13ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13d2:	0f 88 ce 00 00 00    	js     14a6 <APDrawRect+0x1ff>
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	8b 00                	mov    (%eax),%eax
    13dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13e0:	0f 8e c0 00 00 00    	jle    14a6 <APDrawRect+0x1ff>
    13e6:	8b 45 08             	mov    0x8(%ebp),%eax
    13e9:	8b 40 04             	mov    0x4(%eax),%eax
    13ec:	3b 45 10             	cmp    0x10(%ebp),%eax
    13ef:	0f 8e b1 00 00 00    	jle    14a6 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    13f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    13f9:	79 07                	jns    1402 <APDrawRect+0x15b>
    13fb:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1402:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1406:	79 07                	jns    140f <APDrawRect+0x168>
    1408:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
    1412:	8b 00                	mov    (%eax),%eax
    1414:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1417:	7f 0b                	jg     1424 <APDrawRect+0x17d>
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
    141c:	8b 00                	mov    (%eax),%eax
    141e:	83 e8 01             	sub    $0x1,%eax
    1421:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1424:	8b 45 08             	mov    0x8(%ebp),%eax
    1427:	8b 40 04             	mov    0x4(%eax),%eax
    142a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    142d:	7f 0c                	jg     143b <APDrawRect+0x194>
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
    1432:	8b 40 04             	mov    0x4(%eax),%eax
    1435:	83 e8 01             	sub    $0x1,%eax
    1438:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    143b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1442:	8b 45 0c             	mov    0xc(%ebp),%eax
    1445:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1448:	eb 52                	jmp    149c <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    144a:	8b 45 10             	mov    0x10(%ebp),%eax
    144d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1450:	eb 3e                	jmp    1490 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1452:	83 ec 04             	sub    $0x4,%esp
    1455:	ff 75 e8             	pushl  -0x18(%ebp)
    1458:	ff 75 ec             	pushl  -0x14(%ebp)
    145b:	ff 75 08             	pushl  0x8(%ebp)
    145e:	e8 02 f7 ff ff       	call   b65 <APGetIndex>
    1463:	83 c4 10             	add    $0x10,%esp
    1466:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1469:	8b 45 08             	mov    0x8(%ebp),%eax
    146c:	8b 48 18             	mov    0x18(%eax),%ecx
    146f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1472:	89 d0                	mov    %edx,%eax
    1474:	01 c0                	add    %eax,%eax
    1476:	01 d0                	add    %edx,%eax
    1478:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    147b:	8b 45 08             	mov    0x8(%ebp),%eax
    147e:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1482:	66 89 0a             	mov    %cx,(%edx)
    1485:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1489:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    148c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1490:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1493:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1496:	7e ba                	jle    1452 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1498:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    149c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    149f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14a2:	7e a6                	jle    144a <APDrawRect+0x1a3>
    14a4:	eb 01                	jmp    14a7 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    14a6:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    14a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14aa:	c9                   	leave  
    14ab:	c3                   	ret    

000014ac <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    14ac:	55                   	push   %ebp
    14ad:	89 e5                	mov    %esp,%ebp
}
    14af:	90                   	nop
    14b0:	5d                   	pop    %ebp
    14b1:	c3                   	ret    

000014b2 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14b2:	55                   	push   %ebp
    14b3:	89 e5                	mov    %esp,%ebp
    14b5:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14b8:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14bc:	0f 88 8e 01 00 00    	js     1650 <APDcCopy+0x19e>
    14c2:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14c6:	0f 88 84 01 00 00    	js     1650 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14cc:	8b 55 0c             	mov    0xc(%ebp),%edx
    14cf:	8b 45 20             	mov    0x20(%ebp),%eax
    14d2:	01 d0                	add    %edx,%eax
    14d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14d7:	8b 55 10             	mov    0x10(%ebp),%edx
    14da:	8b 45 24             	mov    0x24(%ebp),%eax
    14dd:	01 d0                	add    %edx,%eax
    14df:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14e2:	8b 55 18             	mov    0x18(%ebp),%edx
    14e5:	8b 45 20             	mov    0x20(%ebp),%eax
    14e8:	01 d0                	add    %edx,%eax
    14ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14ed:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14f0:	8b 45 24             	mov    0x24(%ebp),%eax
    14f3:	01 d0                	add    %edx,%eax
    14f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    14f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14fc:	0f 88 51 01 00 00    	js     1653 <APDcCopy+0x1a1>
    1502:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1506:	0f 88 47 01 00 00    	js     1653 <APDcCopy+0x1a1>
    150c:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1510:	0f 88 3d 01 00 00    	js     1653 <APDcCopy+0x1a1>
    1516:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    151a:	0f 88 33 01 00 00    	js     1653 <APDcCopy+0x1a1>
    1520:	8b 45 14             	mov    0x14(%ebp),%eax
    1523:	8b 00                	mov    (%eax),%eax
    1525:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1528:	0f 8c 25 01 00 00    	jl     1653 <APDcCopy+0x1a1>
    152e:	8b 45 14             	mov    0x14(%ebp),%eax
    1531:	8b 40 04             	mov    0x4(%eax),%eax
    1534:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1537:	0f 8c 16 01 00 00    	jl     1653 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    153d:	8b 45 08             	mov    0x8(%ebp),%eax
    1540:	8b 00                	mov    (%eax),%eax
    1542:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1545:	7f 0b                	jg     1552 <APDcCopy+0xa0>
    1547:	8b 45 08             	mov    0x8(%ebp),%eax
    154a:	8b 00                	mov    (%eax),%eax
    154c:	83 e8 01             	sub    $0x1,%eax
    154f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1552:	8b 45 08             	mov    0x8(%ebp),%eax
    1555:	8b 40 04             	mov    0x4(%eax),%eax
    1558:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    155b:	7f 0c                	jg     1569 <APDcCopy+0xb7>
    155d:	8b 45 08             	mov    0x8(%ebp),%eax
    1560:	8b 40 04             	mov    0x4(%eax),%eax
    1563:	83 e8 01             	sub    $0x1,%eax
    1566:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1569:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1570:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1577:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    157e:	e9 bc 00 00 00       	jmp    163f <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1583:	8b 45 08             	mov    0x8(%ebp),%eax
    1586:	8b 00                	mov    (%eax),%eax
    1588:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    158b:	8b 55 10             	mov    0x10(%ebp),%edx
    158e:	01 ca                	add    %ecx,%edx
    1590:	0f af d0             	imul   %eax,%edx
    1593:	8b 45 0c             	mov    0xc(%ebp),%eax
    1596:	01 d0                	add    %edx,%eax
    1598:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    159b:	8b 45 14             	mov    0x14(%ebp),%eax
    159e:	8b 00                	mov    (%eax),%eax
    15a0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15a3:	8b 55 1c             	mov    0x1c(%ebp),%edx
    15a6:	01 ca                	add    %ecx,%edx
    15a8:	0f af d0             	imul   %eax,%edx
    15ab:	8b 45 18             	mov    0x18(%ebp),%eax
    15ae:	01 d0                	add    %edx,%eax
    15b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    15b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15ba:	eb 74                	jmp    1630 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15bc:	8b 45 14             	mov    0x14(%ebp),%eax
    15bf:	8b 50 18             	mov    0x18(%eax),%edx
    15c2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15c8:	01 c8                	add    %ecx,%eax
    15ca:	89 c1                	mov    %eax,%ecx
    15cc:	89 c8                	mov    %ecx,%eax
    15ce:	01 c0                	add    %eax,%eax
    15d0:	01 c8                	add    %ecx,%eax
    15d2:	01 d0                	add    %edx,%eax
    15d4:	0f b7 10             	movzwl (%eax),%edx
    15d7:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15db:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15df:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15e2:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15e6:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15ea:	38 c2                	cmp    %al,%dl
    15ec:	75 18                	jne    1606 <APDcCopy+0x154>
    15ee:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15f2:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    15f6:	38 c2                	cmp    %al,%dl
    15f8:	75 0c                	jne    1606 <APDcCopy+0x154>
    15fa:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    15fe:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1602:	38 c2                	cmp    %al,%dl
    1604:	74 26                	je     162c <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1606:	8b 45 08             	mov    0x8(%ebp),%eax
    1609:	8b 50 18             	mov    0x18(%eax),%edx
    160c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    160f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1612:	01 c8                	add    %ecx,%eax
    1614:	89 c1                	mov    %eax,%ecx
    1616:	89 c8                	mov    %ecx,%eax
    1618:	01 c0                	add    %eax,%eax
    161a:	01 c8                	add    %ecx,%eax
    161c:	01 d0                	add    %edx,%eax
    161e:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1622:	66 89 10             	mov    %dx,(%eax)
    1625:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1629:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    162c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1630:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1633:	2b 45 0c             	sub    0xc(%ebp),%eax
    1636:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1639:	7d 81                	jge    15bc <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    163b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    163f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1642:	2b 45 10             	sub    0x10(%ebp),%eax
    1645:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1648:	0f 8d 35 ff ff ff    	jge    1583 <APDcCopy+0xd1>
    164e:	eb 04                	jmp    1654 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1650:	90                   	nop
    1651:	eb 01                	jmp    1654 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1653:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1654:	c9                   	leave  
    1655:	c3                   	ret    

00001656 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1656:	55                   	push   %ebp
    1657:	89 e5                	mov    %esp,%ebp
    1659:	83 ec 1c             	sub    $0x1c,%esp
    165c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    165f:	8b 55 10             	mov    0x10(%ebp),%edx
    1662:	8b 45 14             	mov    0x14(%ebp),%eax
    1665:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1668:	88 55 e8             	mov    %dl,-0x18(%ebp)
    166b:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    166e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1672:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1675:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1679:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    167c:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1680:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1683:	8b 45 08             	mov    0x8(%ebp),%eax
    1686:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    168a:	66 89 10             	mov    %dx,(%eax)
    168d:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1691:	88 50 02             	mov    %dl,0x2(%eax)
}
    1694:	8b 45 08             	mov    0x8(%ebp),%eax
    1697:	c9                   	leave  
    1698:	c2 04 00             	ret    $0x4

0000169b <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    169b:	55                   	push   %ebp
    169c:	89 e5                	mov    %esp,%ebp
    169e:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    16a1:	8b 45 08             	mov    0x8(%ebp),%eax
    16a4:	8b 00                	mov    (%eax),%eax
    16a6:	83 ec 08             	sub    $0x8,%esp
    16a9:	8d 55 0c             	lea    0xc(%ebp),%edx
    16ac:	52                   	push   %edx
    16ad:	50                   	push   %eax
    16ae:	e8 77 ef ff ff       	call   62a <sendMessage>
    16b3:	83 c4 10             	add    $0x10,%esp
}
    16b6:	90                   	nop
    16b7:	c9                   	leave  
    16b8:	c3                   	ret    

000016b9 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16b9:	55                   	push   %ebp
    16ba:	89 e5                	mov    %esp,%ebp
    16bc:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16bf:	83 ec 0c             	sub    $0xc,%esp
    16c2:	68 98 00 00 00       	push   $0x98
    16c7:	e8 38 f3 ff ff       	call   a04 <malloc>
    16cc:	83 c4 10             	add    $0x10,%esp
    16cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16d6:	75 15                	jne    16ed <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16d8:	83 ec 04             	sub    $0x4,%esp
    16db:	ff 75 08             	pushl  0x8(%ebp)
    16de:	68 44 25 00 00       	push   $0x2544
    16e3:	6a 01                	push   $0x1
    16e5:	e8 47 f0 ff ff       	call   731 <printf>
    16ea:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f0:	05 84 00 00 00       	add    $0x84,%eax
    16f5:	83 ec 08             	sub    $0x8,%esp
    16f8:	ff 75 08             	pushl  0x8(%ebp)
    16fb:	50                   	push   %eax
    16fc:	e8 50 ec ff ff       	call   351 <strcpy>
    1701:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1704:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1707:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    170e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1711:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1718:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171b:	8b 40 3c             	mov    0x3c(%eax),%eax
    171e:	89 c2                	mov    %eax,%edx
    1720:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1723:	8b 40 40             	mov    0x40(%eax),%eax
    1726:	0f af d0             	imul   %eax,%edx
    1729:	89 d0                	mov    %edx,%eax
    172b:	01 c0                	add    %eax,%eax
    172d:	01 d0                	add    %edx,%eax
    172f:	83 ec 0c             	sub    $0xc,%esp
    1732:	50                   	push   %eax
    1733:	e8 cc f2 ff ff       	call   a04 <malloc>
    1738:	83 c4 10             	add    $0x10,%esp
    173b:	89 c2                	mov    %eax,%edx
    173d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1740:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1743:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1746:	8b 40 54             	mov    0x54(%eax),%eax
    1749:	85 c0                	test   %eax,%eax
    174b:	75 15                	jne    1762 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    174d:	83 ec 04             	sub    $0x4,%esp
    1750:	ff 75 08             	pushl  0x8(%ebp)
    1753:	68 64 25 00 00       	push   $0x2564
    1758:	6a 01                	push   $0x1
    175a:	e8 d2 ef ff ff       	call   731 <printf>
    175f:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1762:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1765:	8b 40 3c             	mov    0x3c(%eax),%eax
    1768:	89 c2                	mov    %eax,%edx
    176a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176d:	8b 40 40             	mov    0x40(%eax),%eax
    1770:	0f af d0             	imul   %eax,%edx
    1773:	89 d0                	mov    %edx,%eax
    1775:	01 c0                	add    %eax,%eax
    1777:	01 c2                	add    %eax,%edx
    1779:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177c:	8b 40 54             	mov    0x54(%eax),%eax
    177f:	83 ec 04             	sub    $0x4,%esp
    1782:	52                   	push   %edx
    1783:	68 ff ff ff 00       	push   $0xffffff
    1788:	50                   	push   %eax
    1789:	e8 59 ec ff ff       	call   3e7 <memset>
    178e:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1791:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1794:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    179b:	e8 62 ee ff ff       	call   602 <getpid>
    17a0:	89 c2                	mov    %eax,%edx
    17a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a5:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    17a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ab:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b5:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bf:	8b 40 58             	mov    0x58(%eax),%eax
    17c2:	89 c2                	mov    %eax,%edx
    17c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c7:	8b 40 5c             	mov    0x5c(%eax),%eax
    17ca:	0f af d0             	imul   %eax,%edx
    17cd:	89 d0                	mov    %edx,%eax
    17cf:	01 c0                	add    %eax,%eax
    17d1:	01 d0                	add    %edx,%eax
    17d3:	83 ec 0c             	sub    $0xc,%esp
    17d6:	50                   	push   %eax
    17d7:	e8 28 f2 ff ff       	call   a04 <malloc>
    17dc:	83 c4 10             	add    $0x10,%esp
    17df:	89 c2                	mov    %eax,%edx
    17e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e4:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    17e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ea:	8b 40 70             	mov    0x70(%eax),%eax
    17ed:	85 c0                	test   %eax,%eax
    17ef:	75 15                	jne    1806 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17f1:	83 ec 04             	sub    $0x4,%esp
    17f4:	ff 75 08             	pushl  0x8(%ebp)
    17f7:	68 88 25 00 00       	push   $0x2588
    17fc:	6a 01                	push   $0x1
    17fe:	e8 2e ef ff ff       	call   731 <printf>
    1803:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1806:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1809:	8b 40 3c             	mov    0x3c(%eax),%eax
    180c:	89 c2                	mov    %eax,%edx
    180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1811:	8b 40 40             	mov    0x40(%eax),%eax
    1814:	0f af d0             	imul   %eax,%edx
    1817:	89 d0                	mov    %edx,%eax
    1819:	01 c0                	add    %eax,%eax
    181b:	01 c2                	add    %eax,%edx
    181d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1820:	8b 40 54             	mov    0x54(%eax),%eax
    1823:	83 ec 04             	sub    $0x4,%esp
    1826:	52                   	push   %edx
    1827:	68 ff 00 00 00       	push   $0xff
    182c:	50                   	push   %eax
    182d:	e8 b5 eb ff ff       	call   3e7 <memset>
    1832:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1835:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1838:	8b 55 0c             	mov    0xc(%ebp),%edx
    183b:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    183e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1842:	74 49                	je     188d <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1844:	8b 45 10             	mov    0x10(%ebp),%eax
    1847:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    184d:	83 ec 0c             	sub    $0xc,%esp
    1850:	50                   	push   %eax
    1851:	e8 ae f1 ff ff       	call   a04 <malloc>
    1856:	83 c4 10             	add    $0x10,%esp
    1859:	89 c2                	mov    %eax,%edx
    185b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185e:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1861:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1864:	8b 55 10             	mov    0x10(%ebp),%edx
    1867:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    186a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    1874:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1877:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    187e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1881:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1888:	e9 8d 00 00 00       	jmp    191a <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    188d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1890:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1897:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189a:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a4:	8b 40 20             	mov    0x20(%eax),%eax
    18a7:	89 c2                	mov    %eax,%edx
    18a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ac:	8b 40 24             	mov    0x24(%eax),%eax
    18af:	0f af d0             	imul   %eax,%edx
    18b2:	89 d0                	mov    %edx,%eax
    18b4:	01 c0                	add    %eax,%eax
    18b6:	01 d0                	add    %edx,%eax
    18b8:	83 ec 0c             	sub    $0xc,%esp
    18bb:	50                   	push   %eax
    18bc:	e8 43 f1 ff ff       	call   a04 <malloc>
    18c1:	83 c4 10             	add    $0x10,%esp
    18c4:	89 c2                	mov    %eax,%edx
    18c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c9:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    18cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cf:	8b 40 38             	mov    0x38(%eax),%eax
    18d2:	85 c0                	test   %eax,%eax
    18d4:	75 15                	jne    18eb <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18d6:	83 ec 04             	sub    $0x4,%esp
    18d9:	ff 75 08             	pushl  0x8(%ebp)
    18dc:	68 b0 25 00 00       	push   $0x25b0
    18e1:	6a 01                	push   $0x1
    18e3:	e8 49 ee ff ff       	call   731 <printf>
    18e8:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ee:	8b 40 20             	mov    0x20(%eax),%eax
    18f1:	89 c2                	mov    %eax,%edx
    18f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f6:	8b 40 24             	mov    0x24(%eax),%eax
    18f9:	0f af d0             	imul   %eax,%edx
    18fc:	89 d0                	mov    %edx,%eax
    18fe:	01 c0                	add    %eax,%eax
    1900:	01 c2                	add    %eax,%edx
    1902:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1905:	8b 40 38             	mov    0x38(%eax),%eax
    1908:	83 ec 04             	sub    $0x4,%esp
    190b:	52                   	push   %edx
    190c:	68 ff ff ff 00       	push   $0xffffff
    1911:	50                   	push   %eax
    1912:	e8 d0 ea ff ff       	call   3e7 <memset>
    1917:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    191a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    191d:	c9                   	leave  
    191e:	c3                   	ret    

0000191f <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    191f:	55                   	push   %ebp
    1920:	89 e5                	mov    %esp,%ebp
    1922:	57                   	push   %edi
    1923:	56                   	push   %esi
    1924:	53                   	push   %ebx
    1925:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1928:	8b 45 0c             	mov    0xc(%ebp),%eax
    192b:	83 f8 03             	cmp    $0x3,%eax
    192e:	74 02                	je     1932 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1930:	eb 7c                	jmp    19ae <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1932:	8b 45 08             	mov    0x8(%ebp),%eax
    1935:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1938:	8b 45 08             	mov    0x8(%ebp),%eax
    193b:	8b 48 18             	mov    0x18(%eax),%ecx
    193e:	8b 45 08             	mov    0x8(%ebp),%eax
    1941:	8b 50 5c             	mov    0x5c(%eax),%edx
    1944:	8b 45 08             	mov    0x8(%ebp),%eax
    1947:	8b 40 58             	mov    0x58(%eax),%eax
    194a:	8b 75 08             	mov    0x8(%ebp),%esi
    194d:	83 c6 58             	add    $0x58,%esi
    1950:	83 ec 04             	sub    $0x4,%esp
    1953:	53                   	push   %ebx
    1954:	51                   	push   %ecx
    1955:	6a 00                	push   $0x0
    1957:	52                   	push   %edx
    1958:	50                   	push   %eax
    1959:	6a 00                	push   $0x0
    195b:	6a 00                	push   $0x0
    195d:	56                   	push   %esi
    195e:	6a 00                	push   $0x0
    1960:	6a 00                	push   $0x0
    1962:	ff 75 08             	pushl  0x8(%ebp)
    1965:	e8 b8 ec ff ff       	call   622 <paintWindow>
    196a:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    196d:	8b 45 08             	mov    0x8(%ebp),%eax
    1970:	8b 70 1c             	mov    0x1c(%eax),%esi
    1973:	8b 45 08             	mov    0x8(%ebp),%eax
    1976:	8b 58 18             	mov    0x18(%eax),%ebx
    1979:	8b 45 08             	mov    0x8(%ebp),%eax
    197c:	8b 48 08             	mov    0x8(%eax),%ecx
    197f:	8b 45 08             	mov    0x8(%ebp),%eax
    1982:	8b 50 40             	mov    0x40(%eax),%edx
    1985:	8b 45 08             	mov    0x8(%ebp),%eax
    1988:	8b 40 3c             	mov    0x3c(%eax),%eax
    198b:	8b 7d 08             	mov    0x8(%ebp),%edi
    198e:	83 c7 3c             	add    $0x3c,%edi
    1991:	83 ec 04             	sub    $0x4,%esp
    1994:	56                   	push   %esi
    1995:	53                   	push   %ebx
    1996:	51                   	push   %ecx
    1997:	52                   	push   %edx
    1998:	50                   	push   %eax
    1999:	6a 00                	push   $0x0
    199b:	6a 00                	push   $0x0
    199d:	57                   	push   %edi
    199e:	6a 32                	push   $0x32
    19a0:	6a 00                	push   $0x0
    19a2:	ff 75 08             	pushl  0x8(%ebp)
    19a5:	e8 78 ec ff ff       	call   622 <paintWindow>
    19aa:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    19ad:	90                   	nop
        default: break;
            
            
    }
    return False;
    19ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19b6:	5b                   	pop    %ebx
    19b7:	5e                   	pop    %esi
    19b8:	5f                   	pop    %edi
    19b9:	5d                   	pop    %ebp
    19ba:	c3                   	ret    

000019bb <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    19bb:	55                   	push   %ebp
    19bc:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    19be:	8b 45 0c             	mov    0xc(%ebp),%eax
    19c1:	8b 50 08             	mov    0x8(%eax),%edx
    19c4:	8b 45 08             	mov    0x8(%ebp),%eax
    19c7:	8b 00                	mov    (%eax),%eax
    19c9:	39 c2                	cmp    %eax,%edx
    19cb:	74 07                	je     19d4 <APPreJudge+0x19>
        return False;
    19cd:	b8 00 00 00 00       	mov    $0x0,%eax
    19d2:	eb 05                	jmp    19d9 <APPreJudge+0x1e>
    return True;
    19d4:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19d9:	5d                   	pop    %ebp
    19da:	c3                   	ret    

000019db <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19db:	55                   	push   %ebp
    19dc:	89 e5                	mov    %esp,%ebp
    19de:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19e1:	8b 45 08             	mov    0x8(%ebp),%eax
    19e4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19e7:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    19ed:	83 ec 0c             	sub    $0xc,%esp
    19f0:	ff 75 08             	pushl  0x8(%ebp)
    19f3:	e8 42 ec ff ff       	call   63a <registWindow>
    19f8:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19fb:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	8b 00                	mov    (%eax),%eax
    1a07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1a0a:	ff 75 f4             	pushl  -0xc(%ebp)
    1a0d:	ff 75 f0             	pushl  -0x10(%ebp)
    1a10:	ff 75 ec             	pushl  -0x14(%ebp)
    1a13:	ff 75 08             	pushl  0x8(%ebp)
    1a16:	e8 80 fc ff ff       	call   169b <APSendMessage>
    1a1b:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a1e:	83 ec 0c             	sub    $0xc,%esp
    1a21:	ff 75 08             	pushl  0x8(%ebp)
    1a24:	e8 09 ec ff ff       	call   632 <getMessage>
    1a29:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2f:	83 c0 74             	add    $0x74,%eax
    1a32:	83 ec 08             	sub    $0x8,%esp
    1a35:	50                   	push   %eax
    1a36:	ff 75 08             	pushl  0x8(%ebp)
    1a39:	e8 7d ff ff ff       	call   19bb <APPreJudge>
    1a3e:	83 c4 10             	add    $0x10,%esp
    1a41:	84 c0                	test   %al,%al
    1a43:	74 1b                	je     1a60 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1a45:	8b 45 08             	mov    0x8(%ebp),%eax
    1a48:	ff 70 7c             	pushl  0x7c(%eax)
    1a4b:	ff 70 78             	pushl  0x78(%eax)
    1a4e:	ff 70 74             	pushl  0x74(%eax)
    1a51:	ff 75 08             	pushl  0x8(%ebp)
    1a54:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a57:	ff d0                	call   *%eax
    1a59:	83 c4 10             	add    $0x10,%esp
    1a5c:	84 c0                	test   %al,%al
    1a5e:	75 0c                	jne    1a6c <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1a60:	8b 45 08             	mov    0x8(%ebp),%eax
    1a63:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a6a:	eb b2                	jmp    1a1e <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a6c:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a6d:	90                   	nop
    1a6e:	c9                   	leave  
    1a6f:	c3                   	ret    

00001a70 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a70:	55                   	push   %ebp
    1a71:	89 e5                	mov    %esp,%ebp
    1a73:	57                   	push   %edi
    1a74:	56                   	push   %esi
    1a75:	53                   	push   %ebx
    1a76:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a79:	a1 cc 2c 00 00       	mov    0x2ccc,%eax
    1a7e:	85 c0                	test   %eax,%eax
    1a80:	0f 85 2c 02 00 00    	jne    1cb2 <APGridPaint+0x242>
    {
        iconReady = 1;
    1a86:	c7 05 cc 2c 00 00 01 	movl   $0x1,0x2ccc
    1a8d:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a90:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a93:	83 ec 08             	sub    $0x8,%esp
    1a96:	68 d7 25 00 00       	push   $0x25d7
    1a9b:	50                   	push   %eax
    1a9c:	e8 16 f1 ff ff       	call   bb7 <APLoadBitmap>
    1aa1:	83 c4 0c             	add    $0xc,%esp
    1aa4:	8b 45 98             	mov    -0x68(%ebp),%eax
    1aa7:	a3 00 31 00 00       	mov    %eax,0x3100
    1aac:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aaf:	a3 04 31 00 00       	mov    %eax,0x3104
    1ab4:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ab7:	a3 08 31 00 00       	mov    %eax,0x3108
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1abc:	83 ec 04             	sub    $0x4,%esp
    1abf:	ff 35 08 31 00 00    	pushl  0x3108
    1ac5:	ff 35 04 31 00 00    	pushl  0x3104
    1acb:	ff 35 00 31 00 00    	pushl  0x3100
    1ad1:	e8 1b f3 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1ad6:	83 c4 10             	add    $0x10,%esp
    1ad9:	a3 0c 31 00 00       	mov    %eax,0x310c
        grid_river = APLoadBitmap ("grid_river.bmp");
    1ade:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ae1:	83 ec 08             	sub    $0x8,%esp
    1ae4:	68 e5 25 00 00       	push   $0x25e5
    1ae9:	50                   	push   %eax
    1aea:	e8 c8 f0 ff ff       	call   bb7 <APLoadBitmap>
    1aef:	83 c4 0c             	add    $0xc,%esp
    1af2:	8b 45 98             	mov    -0x68(%ebp),%eax
    1af5:	a3 3c 31 00 00       	mov    %eax,0x313c
    1afa:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1afd:	a3 40 31 00 00       	mov    %eax,0x3140
    1b02:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b05:	a3 44 31 00 00       	mov    %eax,0x3144
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1b0a:	83 ec 04             	sub    $0x4,%esp
    1b0d:	ff 35 44 31 00 00    	pushl  0x3144
    1b13:	ff 35 40 31 00 00    	pushl  0x3140
    1b19:	ff 35 3c 31 00 00    	pushl  0x313c
    1b1f:	e8 cd f2 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1b24:	83 c4 10             	add    $0x10,%esp
    1b27:	a3 2c 31 00 00       	mov    %eax,0x312c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b2c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b2f:	83 ec 08             	sub    $0x8,%esp
    1b32:	68 f4 25 00 00       	push   $0x25f4
    1b37:	50                   	push   %eax
    1b38:	e8 7a f0 ff ff       	call   bb7 <APLoadBitmap>
    1b3d:	83 c4 0c             	add    $0xc,%esp
    1b40:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b43:	a3 30 31 00 00       	mov    %eax,0x3130
    1b48:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b4b:	a3 34 31 00 00       	mov    %eax,0x3134
    1b50:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b53:	a3 38 31 00 00       	mov    %eax,0x3138
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1b58:	83 ec 04             	sub    $0x4,%esp
    1b5b:	ff 35 38 31 00 00    	pushl  0x3138
    1b61:	ff 35 34 31 00 00    	pushl  0x3134
    1b67:	ff 35 30 31 00 00    	pushl  0x3130
    1b6d:	e8 7f f2 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1b72:	83 c4 10             	add    $0x10,%esp
    1b75:	a3 e0 30 00 00       	mov    %eax,0x30e0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b7a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b7d:	83 ec 08             	sub    $0x8,%esp
    1b80:	68 03 26 00 00       	push   $0x2603
    1b85:	50                   	push   %eax
    1b86:	e8 2c f0 ff ff       	call   bb7 <APLoadBitmap>
    1b8b:	83 c4 0c             	add    $0xc,%esp
    1b8e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b91:	a3 14 31 00 00       	mov    %eax,0x3114
    1b96:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b99:	a3 18 31 00 00       	mov    %eax,0x3118
    1b9e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ba1:	a3 1c 31 00 00       	mov    %eax,0x311c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1ba6:	83 ec 04             	sub    $0x4,%esp
    1ba9:	ff 35 1c 31 00 00    	pushl  0x311c
    1baf:	ff 35 18 31 00 00    	pushl  0x3118
    1bb5:	ff 35 14 31 00 00    	pushl  0x3114
    1bbb:	e8 31 f2 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1bc0:	83 c4 10             	add    $0x10,%esp
    1bc3:	a3 48 31 00 00       	mov    %eax,0x3148
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1bc8:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bcb:	83 ec 08             	sub    $0x8,%esp
    1bce:	68 11 26 00 00       	push   $0x2611
    1bd3:	50                   	push   %eax
    1bd4:	e8 de ef ff ff       	call   bb7 <APLoadBitmap>
    1bd9:	83 c4 0c             	add    $0xc,%esp
    1bdc:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bdf:	a3 f0 30 00 00       	mov    %eax,0x30f0
    1be4:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1be7:	a3 f4 30 00 00       	mov    %eax,0x30f4
    1bec:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bef:	a3 f8 30 00 00       	mov    %eax,0x30f8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1bf4:	83 ec 04             	sub    $0x4,%esp
    1bf7:	ff 35 f8 30 00 00    	pushl  0x30f8
    1bfd:	ff 35 f4 30 00 00    	pushl  0x30f4
    1c03:	ff 35 f0 30 00 00    	pushl  0x30f0
    1c09:	e8 e3 f1 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1c0e:	83 c4 10             	add    $0x10,%esp
    1c11:	a3 10 31 00 00       	mov    %eax,0x3110
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c16:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c19:	83 ec 08             	sub    $0x8,%esp
    1c1c:	68 21 26 00 00       	push   $0x2621
    1c21:	50                   	push   %eax
    1c22:	e8 90 ef ff ff       	call   bb7 <APLoadBitmap>
    1c27:	83 c4 0c             	add    $0xc,%esp
    1c2a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c2d:	a3 e4 30 00 00       	mov    %eax,0x30e4
    1c32:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c35:	a3 e8 30 00 00       	mov    %eax,0x30e8
    1c3a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c3d:	a3 ec 30 00 00       	mov    %eax,0x30ec
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1c42:	83 ec 04             	sub    $0x4,%esp
    1c45:	ff 35 ec 30 00 00    	pushl  0x30ec
    1c4b:	ff 35 e8 30 00 00    	pushl  0x30e8
    1c51:	ff 35 e4 30 00 00    	pushl  0x30e4
    1c57:	e8 95 f1 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1c5c:	83 c4 10             	add    $0x10,%esp
    1c5f:	a3 fc 30 00 00       	mov    %eax,0x30fc
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c64:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c67:	83 ec 08             	sub    $0x8,%esp
    1c6a:	68 33 26 00 00       	push   $0x2633
    1c6f:	50                   	push   %eax
    1c70:	e8 42 ef ff ff       	call   bb7 <APLoadBitmap>
    1c75:	83 c4 0c             	add    $0xc,%esp
    1c78:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c7b:	a3 20 31 00 00       	mov    %eax,0x3120
    1c80:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c83:	a3 24 31 00 00       	mov    %eax,0x3124
    1c88:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c8b:	a3 28 31 00 00       	mov    %eax,0x3128
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c90:	83 ec 04             	sub    $0x4,%esp
    1c93:	ff 35 28 31 00 00    	pushl  0x3128
    1c99:	ff 35 24 31 00 00    	pushl  0x3124
    1c9f:	ff 35 20 31 00 00    	pushl  0x3120
    1ca5:	e8 47 f1 ff ff       	call   df1 <APCreateCompatibleDCFromBitmap>
    1caa:	83 c4 10             	add    $0x10,%esp
    1cad:	a3 4c 31 00 00       	mov    %eax,0x314c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1cb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb5:	8b 40 08             	mov    0x8(%eax),%eax
    1cb8:	85 c0                	test   %eax,%eax
    1cba:	75 17                	jne    1cd3 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1cbc:	83 ec 08             	sub    $0x8,%esp
    1cbf:	68 44 26 00 00       	push   $0x2644
    1cc4:	6a 01                	push   $0x1
    1cc6:	e8 66 ea ff ff       	call   731 <printf>
    1ccb:	83 c4 10             	add    $0x10,%esp
        return;
    1cce:	e9 a0 04 00 00       	jmp    2173 <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1cd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd6:	8b 40 10             	mov    0x10(%eax),%eax
    1cd9:	85 c0                	test   %eax,%eax
    1cdb:	7e 10                	jle    1ced <APGridPaint+0x27d>
    1cdd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce0:	8b 50 14             	mov    0x14(%eax),%edx
    1ce3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce6:	8b 40 10             	mov    0x10(%eax),%eax
    1ce9:	39 c2                	cmp    %eax,%edx
    1ceb:	7c 17                	jl     1d04 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1ced:	83 ec 08             	sub    $0x8,%esp
    1cf0:	68 6a 26 00 00       	push   $0x266a
    1cf5:	6a 01                	push   $0x1
    1cf7:	e8 35 ea ff ff       	call   731 <printf>
    1cfc:	83 c4 10             	add    $0x10,%esp
        return;
    1cff:	e9 6f 04 00 00       	jmp    2173 <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1d04:	8b 45 08             	mov    0x8(%ebp),%eax
    1d07:	8b 40 14             	mov    0x14(%eax),%eax
    1d0a:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1d10:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d13:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d16:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1d20:	e9 96 03 00 00       	jmp    20bb <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d25:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d2c:	e9 7c 03 00 00       	jmp    20ad <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d34:	c1 e0 04             	shl    $0x4,%eax
    1d37:	89 c2                	mov    %eax,%edx
    1d39:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d3c:	01 c2                	add    %eax,%edx
    1d3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d41:	01 d0                	add    %edx,%eax
    1d43:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d46:	8b 45 08             	mov    0x8(%ebp),%eax
    1d49:	8b 40 0c             	mov    0xc(%eax),%eax
    1d4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d4f:	c1 e2 02             	shl    $0x2,%edx
    1d52:	01 d0                	add    %edx,%eax
    1d54:	8b 00                	mov    (%eax),%eax
    1d56:	83 f8 07             	cmp    $0x7,%eax
    1d59:	0f 87 49 03 00 00    	ja     20a8 <APGridPaint+0x638>
    1d5f:	8b 04 85 80 26 00 00 	mov    0x2680(,%eax,4),%eax
    1d66:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d68:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d6b:	6a 0c                	push   $0xc
    1d6d:	6a 0c                	push   $0xc
    1d6f:	6a 0c                	push   $0xc
    1d71:	50                   	push   %eax
    1d72:	e8 df f8 ff ff       	call   1656 <RGB>
    1d77:	83 c4 0c             	add    $0xc,%esp
    1d7a:	8b 1d 0c 31 00 00    	mov    0x310c,%ebx
    1d80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d83:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d86:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d89:	6b c0 32             	imul   $0x32,%eax,%eax
    1d8c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d92:	8d 78 3c             	lea    0x3c(%eax),%edi
    1d95:	83 ec 0c             	sub    $0xc,%esp
    1d98:	83 ec 04             	sub    $0x4,%esp
    1d9b:	89 e0                	mov    %esp,%eax
    1d9d:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1da1:	66 89 30             	mov    %si,(%eax)
    1da4:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1da8:	88 50 02             	mov    %dl,0x2(%eax)
    1dab:	6a 32                	push   $0x32
    1dad:	6a 32                	push   $0x32
    1daf:	6a 00                	push   $0x0
    1db1:	6a 00                	push   $0x0
    1db3:	53                   	push   %ebx
    1db4:	51                   	push   %ecx
    1db5:	ff 75 94             	pushl  -0x6c(%ebp)
    1db8:	57                   	push   %edi
    1db9:	e8 f4 f6 ff ff       	call   14b2 <APDcCopy>
    1dbe:	83 c4 30             	add    $0x30,%esp
                    break;
    1dc1:	e9 e3 02 00 00       	jmp    20a9 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1dc6:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dc9:	6a 69                	push   $0x69
    1dcb:	6a 69                	push   $0x69
    1dcd:	6a 69                	push   $0x69
    1dcf:	50                   	push   %eax
    1dd0:	e8 81 f8 ff ff       	call   1656 <RGB>
    1dd5:	83 c4 0c             	add    $0xc,%esp
    1dd8:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1ddc:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1de0:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1de4:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1de7:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1dee:	8d 45 98             	lea    -0x68(%ebp),%eax
    1df1:	6a 69                	push   $0x69
    1df3:	6a 69                	push   $0x69
    1df5:	6a 69                	push   $0x69
    1df7:	50                   	push   %eax
    1df8:	e8 59 f8 ff ff       	call   1656 <RGB>
    1dfd:	83 c4 0c             	add    $0xc,%esp
    1e00:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e04:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1e08:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e0c:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1e0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e12:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e15:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e18:	ff 75 b0             	pushl  -0x50(%ebp)
    1e1b:	ff 75 ac             	pushl  -0x54(%ebp)
    1e1e:	52                   	push   %edx
    1e1f:	50                   	push   %eax
    1e20:	e8 61 f0 ff ff       	call   e86 <APSetPen>
    1e25:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1e28:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2b:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e2e:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e31:	83 ec 04             	sub    $0x4,%esp
    1e34:	83 ec 04             	sub    $0x4,%esp
    1e37:	89 e0                	mov    %esp,%eax
    1e39:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1e3d:	66 89 08             	mov    %cx,(%eax)
    1e40:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1e44:	88 48 02             	mov    %cl,0x2(%eax)
    1e47:	53                   	push   %ebx
    1e48:	52                   	push   %edx
    1e49:	e8 71 f0 ff ff       	call   ebf <APSetBrush>
    1e4e:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e54:	6b d0 32             	imul   $0x32,%eax,%edx
    1e57:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e5a:	6b c0 32             	imul   $0x32,%eax,%eax
    1e5d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e60:	83 c1 3c             	add    $0x3c,%ecx
    1e63:	83 ec 0c             	sub    $0xc,%esp
    1e66:	6a 32                	push   $0x32
    1e68:	6a 32                	push   $0x32
    1e6a:	52                   	push   %edx
    1e6b:	50                   	push   %eax
    1e6c:	51                   	push   %ecx
    1e6d:	e8 35 f4 ff ff       	call   12a7 <APDrawRect>
    1e72:	83 c4 20             	add    $0x20,%esp
                    break;
    1e75:	e9 2f 02 00 00       	jmp    20a9 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e7a:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e7d:	6a 0c                	push   $0xc
    1e7f:	6a 0c                	push   $0xc
    1e81:	6a 0c                	push   $0xc
    1e83:	50                   	push   %eax
    1e84:	e8 cd f7 ff ff       	call   1656 <RGB>
    1e89:	83 c4 0c             	add    $0xc,%esp
    1e8c:	8b 1d 4c 31 00 00    	mov    0x314c,%ebx
    1e92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e95:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e98:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e9b:	6b c0 32             	imul   $0x32,%eax,%eax
    1e9e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ea1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea4:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ea7:	83 ec 0c             	sub    $0xc,%esp
    1eaa:	83 ec 04             	sub    $0x4,%esp
    1ead:	89 e0                	mov    %esp,%eax
    1eaf:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1eb3:	66 89 30             	mov    %si,(%eax)
    1eb6:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1eba:	88 50 02             	mov    %dl,0x2(%eax)
    1ebd:	6a 32                	push   $0x32
    1ebf:	6a 32                	push   $0x32
    1ec1:	6a 00                	push   $0x0
    1ec3:	6a 00                	push   $0x0
    1ec5:	53                   	push   %ebx
    1ec6:	51                   	push   %ecx
    1ec7:	ff 75 94             	pushl  -0x6c(%ebp)
    1eca:	57                   	push   %edi
    1ecb:	e8 e2 f5 ff ff       	call   14b2 <APDcCopy>
    1ed0:	83 c4 30             	add    $0x30,%esp
                    break;
    1ed3:	e9 d1 01 00 00       	jmp    20a9 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ed8:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1edb:	6a 0c                	push   $0xc
    1edd:	6a 0c                	push   $0xc
    1edf:	6a 0c                	push   $0xc
    1ee1:	50                   	push   %eax
    1ee2:	e8 6f f7 ff ff       	call   1656 <RGB>
    1ee7:	83 c4 0c             	add    $0xc,%esp
    1eea:	8b 1d 2c 31 00 00    	mov    0x312c,%ebx
    1ef0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ef6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ef9:	6b c0 32             	imul   $0x32,%eax,%eax
    1efc:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eff:	8b 45 08             	mov    0x8(%ebp),%eax
    1f02:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f05:	83 ec 0c             	sub    $0xc,%esp
    1f08:	83 ec 04             	sub    $0x4,%esp
    1f0b:	89 e0                	mov    %esp,%eax
    1f0d:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f11:	66 89 30             	mov    %si,(%eax)
    1f14:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f18:	88 50 02             	mov    %dl,0x2(%eax)
    1f1b:	6a 32                	push   $0x32
    1f1d:	6a 32                	push   $0x32
    1f1f:	6a 00                	push   $0x0
    1f21:	6a 00                	push   $0x0
    1f23:	53                   	push   %ebx
    1f24:	51                   	push   %ecx
    1f25:	ff 75 94             	pushl  -0x6c(%ebp)
    1f28:	57                   	push   %edi
    1f29:	e8 84 f5 ff ff       	call   14b2 <APDcCopy>
    1f2e:	83 c4 30             	add    $0x30,%esp
                    break;
    1f31:	e9 73 01 00 00       	jmp    20a9 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f36:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f39:	6a 0c                	push   $0xc
    1f3b:	6a 0c                	push   $0xc
    1f3d:	6a 0c                	push   $0xc
    1f3f:	50                   	push   %eax
    1f40:	e8 11 f7 ff ff       	call   1656 <RGB>
    1f45:	83 c4 0c             	add    $0xc,%esp
    1f48:	8b 1d 10 31 00 00    	mov    0x3110,%ebx
    1f4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f51:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f54:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f57:	6b c0 32             	imul   $0x32,%eax,%eax
    1f5a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f60:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f63:	83 ec 0c             	sub    $0xc,%esp
    1f66:	83 ec 04             	sub    $0x4,%esp
    1f69:	89 e0                	mov    %esp,%eax
    1f6b:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f6f:	66 89 30             	mov    %si,(%eax)
    1f72:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f76:	88 50 02             	mov    %dl,0x2(%eax)
    1f79:	6a 32                	push   $0x32
    1f7b:	6a 32                	push   $0x32
    1f7d:	6a 00                	push   $0x0
    1f7f:	6a 00                	push   $0x0
    1f81:	53                   	push   %ebx
    1f82:	51                   	push   %ecx
    1f83:	ff 75 94             	pushl  -0x6c(%ebp)
    1f86:	57                   	push   %edi
    1f87:	e8 26 f5 ff ff       	call   14b2 <APDcCopy>
    1f8c:	83 c4 30             	add    $0x30,%esp
                    break;
    1f8f:	e9 15 01 00 00       	jmp    20a9 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f94:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f97:	6a 0c                	push   $0xc
    1f99:	6a 0c                	push   $0xc
    1f9b:	6a 0c                	push   $0xc
    1f9d:	50                   	push   %eax
    1f9e:	e8 b3 f6 ff ff       	call   1656 <RGB>
    1fa3:	83 c4 0c             	add    $0xc,%esp
    1fa6:	8b 1d 48 31 00 00    	mov    0x3148,%ebx
    1fac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1faf:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fb2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fb5:	6b c0 32             	imul   $0x32,%eax,%eax
    1fb8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbe:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fc1:	83 ec 0c             	sub    $0xc,%esp
    1fc4:	83 ec 04             	sub    $0x4,%esp
    1fc7:	89 e0                	mov    %esp,%eax
    1fc9:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1fcd:	66 89 30             	mov    %si,(%eax)
    1fd0:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1fd4:	88 50 02             	mov    %dl,0x2(%eax)
    1fd7:	6a 32                	push   $0x32
    1fd9:	6a 32                	push   $0x32
    1fdb:	6a 00                	push   $0x0
    1fdd:	6a 00                	push   $0x0
    1fdf:	53                   	push   %ebx
    1fe0:	51                   	push   %ecx
    1fe1:	ff 75 94             	pushl  -0x6c(%ebp)
    1fe4:	57                   	push   %edi
    1fe5:	e8 c8 f4 ff ff       	call   14b2 <APDcCopy>
    1fea:	83 c4 30             	add    $0x30,%esp
                    break;
    1fed:	e9 b7 00 00 00       	jmp    20a9 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ff2:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1ff5:	6a 0c                	push   $0xc
    1ff7:	6a 0c                	push   $0xc
    1ff9:	6a 0c                	push   $0xc
    1ffb:	50                   	push   %eax
    1ffc:	e8 55 f6 ff ff       	call   1656 <RGB>
    2001:	83 c4 0c             	add    $0xc,%esp
    2004:	8b 1d e0 30 00 00    	mov    0x30e0,%ebx
    200a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    200d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2010:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2013:	6b c0 32             	imul   $0x32,%eax,%eax
    2016:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2019:	8b 45 08             	mov    0x8(%ebp),%eax
    201c:	8d 78 3c             	lea    0x3c(%eax),%edi
    201f:	83 ec 0c             	sub    $0xc,%esp
    2022:	83 ec 04             	sub    $0x4,%esp
    2025:	89 e0                	mov    %esp,%eax
    2027:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    202b:	66 89 30             	mov    %si,(%eax)
    202e:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2032:	88 50 02             	mov    %dl,0x2(%eax)
    2035:	6a 32                	push   $0x32
    2037:	6a 32                	push   $0x32
    2039:	6a 00                	push   $0x0
    203b:	6a 00                	push   $0x0
    203d:	53                   	push   %ebx
    203e:	51                   	push   %ecx
    203f:	ff 75 94             	pushl  -0x6c(%ebp)
    2042:	57                   	push   %edi
    2043:	e8 6a f4 ff ff       	call   14b2 <APDcCopy>
    2048:	83 c4 30             	add    $0x30,%esp
                    break;
    204b:	eb 5c                	jmp    20a9 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    204d:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    2050:	6a 0c                	push   $0xc
    2052:	6a 0c                	push   $0xc
    2054:	6a 0c                	push   $0xc
    2056:	50                   	push   %eax
    2057:	e8 fa f5 ff ff       	call   1656 <RGB>
    205c:	83 c4 0c             	add    $0xc,%esp
    205f:	8b 1d fc 30 00 00    	mov    0x30fc,%ebx
    2065:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2068:	6b c8 32             	imul   $0x32,%eax,%ecx
    206b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    206e:	6b c0 32             	imul   $0x32,%eax,%eax
    2071:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2074:	8b 45 08             	mov    0x8(%ebp),%eax
    2077:	8d 78 3c             	lea    0x3c(%eax),%edi
    207a:	83 ec 0c             	sub    $0xc,%esp
    207d:	83 ec 04             	sub    $0x4,%esp
    2080:	89 e0                	mov    %esp,%eax
    2082:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2086:	66 89 30             	mov    %si,(%eax)
    2089:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    208d:	88 50 02             	mov    %dl,0x2(%eax)
    2090:	6a 32                	push   $0x32
    2092:	6a 32                	push   $0x32
    2094:	6a 00                	push   $0x0
    2096:	6a 00                	push   $0x0
    2098:	53                   	push   %ebx
    2099:	51                   	push   %ecx
    209a:	ff 75 94             	pushl  -0x6c(%ebp)
    209d:	57                   	push   %edi
    209e:	e8 0f f4 ff ff       	call   14b2 <APDcCopy>
    20a3:	83 c4 30             	add    $0x30,%esp
                    break;
    20a6:	eb 01                	jmp    20a9 <APGridPaint+0x639>
                default: break;
    20a8:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    20a9:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    20ad:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    20b1:	0f 8e 7a fc ff ff    	jle    1d31 <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    20b7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    20bb:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    20bf:	0f 8e 60 fc ff ff    	jle    1d25 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    20c5:	8d 45 98             	lea    -0x68(%ebp),%eax
    20c8:	68 cd 00 00 00       	push   $0xcd
    20cd:	6a 74                	push   $0x74
    20cf:	6a 18                	push   $0x18
    20d1:	50                   	push   %eax
    20d2:	e8 7f f5 ff ff       	call   1656 <RGB>
    20d7:	83 c4 0c             	add    $0xc,%esp
    20da:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    20de:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    20e2:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    20e6:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    20e9:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    20f0:	8d 45 98             	lea    -0x68(%ebp),%eax
    20f3:	68 cd 00 00 00       	push   $0xcd
    20f8:	6a 74                	push   $0x74
    20fa:	6a 18                	push   $0x18
    20fc:	50                   	push   %eax
    20fd:	e8 54 f5 ff ff       	call   1656 <RGB>
    2102:	83 c4 0c             	add    $0xc,%esp
    2105:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2109:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    210d:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2111:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2114:	8b 45 08             	mov    0x8(%ebp),%eax
    2117:	8d 50 58             	lea    0x58(%eax),%edx
    211a:	8d 45 98             	lea    -0x68(%ebp),%eax
    211d:	ff 75 bc             	pushl  -0x44(%ebp)
    2120:	ff 75 b8             	pushl  -0x48(%ebp)
    2123:	52                   	push   %edx
    2124:	50                   	push   %eax
    2125:	e8 5c ed ff ff       	call   e86 <APSetPen>
    212a:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    212d:	8b 45 08             	mov    0x8(%ebp),%eax
    2130:	8d 58 58             	lea    0x58(%eax),%ebx
    2133:	8d 55 98             	lea    -0x68(%ebp),%edx
    2136:	83 ec 04             	sub    $0x4,%esp
    2139:	83 ec 04             	sub    $0x4,%esp
    213c:	89 e0                	mov    %esp,%eax
    213e:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    2142:	66 89 08             	mov    %cx,(%eax)
    2145:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2149:	88 48 02             	mov    %cl,0x2(%eax)
    214c:	53                   	push   %ebx
    214d:	52                   	push   %edx
    214e:	e8 6c ed ff ff       	call   ebf <APSetBrush>
    2153:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2156:	8b 45 08             	mov    0x8(%ebp),%eax
    2159:	83 c0 58             	add    $0x58,%eax
    215c:	83 ec 0c             	sub    $0xc,%esp
    215f:	6a 32                	push   $0x32
    2161:	68 20 03 00 00       	push   $0x320
    2166:	6a 00                	push   $0x0
    2168:	6a 00                	push   $0x0
    216a:	50                   	push   %eax
    216b:	e8 37 f1 ff ff       	call   12a7 <APDrawRect>
    2170:	83 c4 20             	add    $0x20,%esp
}
    2173:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2176:	5b                   	pop    %ebx
    2177:	5e                   	pop    %esi
    2178:	5f                   	pop    %edi
    2179:	5d                   	pop    %ebp
    217a:	c3                   	ret    

0000217b <random>:
//

#include "APLib.h"

int random(int seed)
{
    217b:	55                   	push   %ebp
    217c:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    217e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2182:	7e 08                	jle    218c <random+0x11>
{
rand_num = seed;
    2184:	8b 45 08             	mov    0x8(%ebp),%eax
    2187:	a3 94 2c 00 00       	mov    %eax,0x2c94
}
rand_num *= 3;
    218c:	8b 15 94 2c 00 00    	mov    0x2c94,%edx
    2192:	89 d0                	mov    %edx,%eax
    2194:	01 c0                	add    %eax,%eax
    2196:	01 d0                	add    %edx,%eax
    2198:	a3 94 2c 00 00       	mov    %eax,0x2c94
if (rand_num < 0)
    219d:	a1 94 2c 00 00       	mov    0x2c94,%eax
    21a2:	85 c0                	test   %eax,%eax
    21a4:	79 0c                	jns    21b2 <random+0x37>
{
rand_num *= (-1);
    21a6:	a1 94 2c 00 00       	mov    0x2c94,%eax
    21ab:	f7 d8                	neg    %eax
    21ad:	a3 94 2c 00 00       	mov    %eax,0x2c94
}
return rand_num % 997;
    21b2:	8b 0d 94 2c 00 00    	mov    0x2c94,%ecx
    21b8:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    21bd:	89 c8                	mov    %ecx,%eax
    21bf:	f7 ea                	imul   %edx
    21c1:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    21c4:	c1 f8 09             	sar    $0x9,%eax
    21c7:	89 c2                	mov    %eax,%edx
    21c9:	89 c8                	mov    %ecx,%eax
    21cb:	c1 f8 1f             	sar    $0x1f,%eax
    21ce:	29 c2                	sub    %eax,%edx
    21d0:	89 d0                	mov    %edx,%eax
    21d2:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    21d8:	29 c1                	sub    %eax,%ecx
    21da:	89 c8                	mov    %ecx,%eax
}
    21dc:	5d                   	pop    %ebp
    21dd:	c3                   	ret    

000021de <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    21de:	55                   	push   %ebp
    21df:	89 e5                	mov    %esp,%ebp
    21e1:	53                   	push   %ebx
    21e2:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    21e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    21ec:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    21f0:	74 17                	je     2209 <sprintint+0x2b>
    21f2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    21f6:	79 11                	jns    2209 <sprintint+0x2b>
        neg = 1;
    21f8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    21ff:	8b 45 10             	mov    0x10(%ebp),%eax
    2202:	f7 d8                	neg    %eax
    2204:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2207:	eb 06                	jmp    220f <sprintint+0x31>
    } else {
        x = xx;
    2209:	8b 45 10             	mov    0x10(%ebp),%eax
    220c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    220f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2216:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2219:	8d 41 01             	lea    0x1(%ecx),%eax
    221c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    221f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2222:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2225:	ba 00 00 00 00       	mov    $0x0,%edx
    222a:	f7 f3                	div    %ebx
    222c:	89 d0                	mov    %edx,%eax
    222e:	0f b6 80 98 2c 00 00 	movzbl 0x2c98(%eax),%eax
    2235:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2239:	8b 5d 14             	mov    0x14(%ebp),%ebx
    223c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    223f:	ba 00 00 00 00       	mov    $0x0,%edx
    2244:	f7 f3                	div    %ebx
    2246:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2249:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    224d:	75 c7                	jne    2216 <sprintint+0x38>
    if(neg)
    224f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2253:	74 0e                	je     2263 <sprintint+0x85>
        buf[i++] = '-';
    2255:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2258:	8d 50 01             	lea    0x1(%eax),%edx
    225b:	89 55 f8             	mov    %edx,-0x8(%ebp)
    225e:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2263:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2266:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2269:	eb 1b                	jmp    2286 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    226b:	8b 45 0c             	mov    0xc(%ebp),%eax
    226e:	8b 00                	mov    (%eax),%eax
    2270:	8d 48 01             	lea    0x1(%eax),%ecx
    2273:	8b 55 0c             	mov    0xc(%ebp),%edx
    2276:	89 0a                	mov    %ecx,(%edx)
    2278:	89 c2                	mov    %eax,%edx
    227a:	8b 45 08             	mov    0x8(%ebp),%eax
    227d:	01 d0                	add    %edx,%eax
    227f:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2282:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2286:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    228a:	7f df                	jg     226b <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    228c:	eb 21                	jmp    22af <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    228e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2291:	8b 00                	mov    (%eax),%eax
    2293:	8d 48 01             	lea    0x1(%eax),%ecx
    2296:	8b 55 0c             	mov    0xc(%ebp),%edx
    2299:	89 0a                	mov    %ecx,(%edx)
    229b:	89 c2                	mov    %eax,%edx
    229d:	8b 45 08             	mov    0x8(%ebp),%eax
    22a0:	01 c2                	add    %eax,%edx
    22a2:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    22a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22a8:	01 c8                	add    %ecx,%eax
    22aa:	0f b6 00             	movzbl (%eax),%eax
    22ad:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22af:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    22b3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    22b7:	79 d5                	jns    228e <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    22b9:	90                   	nop
    22ba:	83 c4 20             	add    $0x20,%esp
    22bd:	5b                   	pop    %ebx
    22be:	5d                   	pop    %ebp
    22bf:	c3                   	ret    

000022c0 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    22c0:	55                   	push   %ebp
    22c1:	89 e5                	mov    %esp,%ebp
    22c3:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    22c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    22cd:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    22d4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    22db:	8d 45 0c             	lea    0xc(%ebp),%eax
    22de:	83 c0 04             	add    $0x4,%eax
    22e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    22e4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    22eb:	e9 d9 01 00 00       	jmp    24c9 <sprintf+0x209>
        c = fmt[i] & 0xff;
    22f0:	8b 55 0c             	mov    0xc(%ebp),%edx
    22f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    22f6:	01 d0                	add    %edx,%eax
    22f8:	0f b6 00             	movzbl (%eax),%eax
    22fb:	0f be c0             	movsbl %al,%eax
    22fe:	25 ff 00 00 00       	and    $0xff,%eax
    2303:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2306:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    230a:	75 2c                	jne    2338 <sprintf+0x78>
            if(c == '%'){
    230c:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2310:	75 0c                	jne    231e <sprintf+0x5e>
                state = '%';
    2312:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2319:	e9 a7 01 00 00       	jmp    24c5 <sprintf+0x205>
            } else {
                dst[j++] = c;
    231e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2321:	8d 50 01             	lea    0x1(%eax),%edx
    2324:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2327:	89 c2                	mov    %eax,%edx
    2329:	8b 45 08             	mov    0x8(%ebp),%eax
    232c:	01 d0                	add    %edx,%eax
    232e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2331:	88 10                	mov    %dl,(%eax)
    2333:	e9 8d 01 00 00       	jmp    24c5 <sprintf+0x205>
            }
        } else if(state == '%'){
    2338:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    233c:	0f 85 83 01 00 00    	jne    24c5 <sprintf+0x205>
            if(c == 'd'){
    2342:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2346:	75 4c                	jne    2394 <sprintf+0xd4>
                buf[bi] = '\0';
    2348:	8d 55 ce             	lea    -0x32(%ebp),%edx
    234b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    234e:	01 d0                	add    %edx,%eax
    2350:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2353:	83 ec 0c             	sub    $0xc,%esp
    2356:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2359:	50                   	push   %eax
    235a:	e8 91 e1 ff ff       	call   4f0 <atoi>
    235f:	83 c4 10             	add    $0x10,%esp
    2362:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2365:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    236c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    236f:	8b 00                	mov    (%eax),%eax
    2371:	83 ec 08             	sub    $0x8,%esp
    2374:	ff 75 d8             	pushl  -0x28(%ebp)
    2377:	6a 01                	push   $0x1
    2379:	6a 0a                	push   $0xa
    237b:	50                   	push   %eax
    237c:	8d 45 c8             	lea    -0x38(%ebp),%eax
    237f:	50                   	push   %eax
    2380:	ff 75 08             	pushl  0x8(%ebp)
    2383:	e8 56 fe ff ff       	call   21de <sprintint>
    2388:	83 c4 20             	add    $0x20,%esp
                ap++;
    238b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    238f:	e9 2a 01 00 00       	jmp    24be <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2394:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2398:	74 06                	je     23a0 <sprintf+0xe0>
    239a:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    239e:	75 4c                	jne    23ec <sprintf+0x12c>
                buf[bi] = '\0';
    23a0:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23a6:	01 d0                	add    %edx,%eax
    23a8:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23ab:	83 ec 0c             	sub    $0xc,%esp
    23ae:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23b1:	50                   	push   %eax
    23b2:	e8 39 e1 ff ff       	call   4f0 <atoi>
    23b7:	83 c4 10             	add    $0x10,%esp
    23ba:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    23bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    23c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23c7:	8b 00                	mov    (%eax),%eax
    23c9:	83 ec 08             	sub    $0x8,%esp
    23cc:	ff 75 dc             	pushl  -0x24(%ebp)
    23cf:	6a 00                	push   $0x0
    23d1:	6a 10                	push   $0x10
    23d3:	50                   	push   %eax
    23d4:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23d7:	50                   	push   %eax
    23d8:	ff 75 08             	pushl  0x8(%ebp)
    23db:	e8 fe fd ff ff       	call   21de <sprintint>
    23e0:	83 c4 20             	add    $0x20,%esp
                ap++;
    23e3:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    23e7:	e9 d2 00 00 00       	jmp    24be <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    23ec:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    23f0:	75 46                	jne    2438 <sprintf+0x178>
                s = (char*)*ap;
    23f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23f5:	8b 00                	mov    (%eax),%eax
    23f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    23fa:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    23fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2402:	75 25                	jne    2429 <sprintf+0x169>
                    s = "(null)";
    2404:	c7 45 f4 a0 26 00 00 	movl   $0x26a0,-0xc(%ebp)
                while(*s != 0){
    240b:	eb 1c                	jmp    2429 <sprintf+0x169>
                    dst[j++] = *s;
    240d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2410:	8d 50 01             	lea    0x1(%eax),%edx
    2413:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2416:	89 c2                	mov    %eax,%edx
    2418:	8b 45 08             	mov    0x8(%ebp),%eax
    241b:	01 c2                	add    %eax,%edx
    241d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2420:	0f b6 00             	movzbl (%eax),%eax
    2423:	88 02                	mov    %al,(%edx)
                    s++;
    2425:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2429:	8b 45 f4             	mov    -0xc(%ebp),%eax
    242c:	0f b6 00             	movzbl (%eax),%eax
    242f:	84 c0                	test   %al,%al
    2431:	75 da                	jne    240d <sprintf+0x14d>
    2433:	e9 86 00 00 00       	jmp    24be <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2438:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    243c:	75 1d                	jne    245b <sprintf+0x19b>
                dst[j++] = *ap;
    243e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2441:	8d 50 01             	lea    0x1(%eax),%edx
    2444:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2447:	89 c2                	mov    %eax,%edx
    2449:	8b 45 08             	mov    0x8(%ebp),%eax
    244c:	01 c2                	add    %eax,%edx
    244e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2451:	8b 00                	mov    (%eax),%eax
    2453:	88 02                	mov    %al,(%edx)
                ap++;
    2455:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2459:	eb 63                	jmp    24be <sprintf+0x1fe>
            } else if(c == '%'){
    245b:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    245f:	75 17                	jne    2478 <sprintf+0x1b8>
                dst[j++] = c;
    2461:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2464:	8d 50 01             	lea    0x1(%eax),%edx
    2467:	89 55 c8             	mov    %edx,-0x38(%ebp)
    246a:	89 c2                	mov    %eax,%edx
    246c:	8b 45 08             	mov    0x8(%ebp),%eax
    246f:	01 d0                	add    %edx,%eax
    2471:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2474:	88 10                	mov    %dl,(%eax)
    2476:	eb 46                	jmp    24be <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2478:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    247c:	7e 18                	jle    2496 <sprintf+0x1d6>
    247e:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2482:	7f 12                	jg     2496 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2484:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2487:	8d 50 01             	lea    0x1(%eax),%edx
    248a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    248d:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2490:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2494:	eb 2f                	jmp    24c5 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2496:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2499:	8d 50 01             	lea    0x1(%eax),%edx
    249c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    249f:	89 c2                	mov    %eax,%edx
    24a1:	8b 45 08             	mov    0x8(%ebp),%eax
    24a4:	01 d0                	add    %edx,%eax
    24a6:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    24a9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24ac:	8d 50 01             	lea    0x1(%eax),%edx
    24af:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24b2:	89 c2                	mov    %eax,%edx
    24b4:	8b 45 08             	mov    0x8(%ebp),%eax
    24b7:	01 d0                	add    %edx,%eax
    24b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24bc:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    24be:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    24c5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    24c9:	8b 55 0c             	mov    0xc(%ebp),%edx
    24cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24cf:	01 d0                	add    %edx,%eax
    24d1:	0f b6 00             	movzbl (%eax),%eax
    24d4:	84 c0                	test   %al,%al
    24d6:	0f 85 14 fe ff ff    	jne    22f0 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    24dc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24df:	8d 50 01             	lea    0x1(%eax),%edx
    24e2:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24e5:	89 c2                	mov    %eax,%edx
    24e7:	8b 45 08             	mov    0x8(%ebp),%eax
    24ea:	01 d0                	add    %edx,%eax
    24ec:	c6 00 00             	movb   $0x0,(%eax)
}
    24ef:	90                   	nop
    24f0:	c9                   	leave  
    24f1:	c3                   	ret    
