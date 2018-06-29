
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
      18:	c7 45 f0 a0 6b 00 00 	movl   $0x6ba0,-0x10(%ebp)
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
      84:	81 7d f0 a0 6b 00 00 	cmpl   $0x6ba0,-0x10(%ebp)
      8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
      8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
      9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9d:	ba a0 6b 00 00       	mov    $0x6ba0,%edx
      a2:	29 d0                	sub    %edx,%eax
      a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      a7:	83 ec 04             	sub    $0x4,%esp
      aa:	ff 75 f4             	pushl  -0xc(%ebp)
      ad:	ff 75 f0             	pushl  -0x10(%ebp)
      b0:	68 a0 6b 00 00       	push   $0x6ba0
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
      ce:	05 a0 6b 00 00       	add    $0x6ba0,%eax
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
     10f:	68 58 27 00 00       	push   $0x2758
     114:	6a 02                	push   $0x2
     116:	e8 26 06 00 00       	call   741 <printf>
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
     18c:	68 78 27 00 00       	push   $0x2778
     191:	6a 01                	push   $0x1
     193:	e8 a9 05 00 00       	call   741 <printf>
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

0000065a <getCurrentTime>:
SYSCALL(getCurrentTime)
     65a:	b8 1d 00 00 00       	mov    $0x1d,%eax
     65f:	cd 40                	int    $0x40
     661:	c3                   	ret    

00000662 <removeWindow>:
SYSCALL(removeWindow)
     662:	b8 1e 00 00 00       	mov    $0x1e,%eax
     667:	cd 40                	int    $0x40
     669:	c3                   	ret    

0000066a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     66a:	55                   	push   %ebp
     66b:	89 e5                	mov    %esp,%ebp
     66d:	83 ec 18             	sub    $0x18,%esp
     670:	8b 45 0c             	mov    0xc(%ebp),%eax
     673:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     676:	83 ec 04             	sub    $0x4,%esp
     679:	6a 01                	push   $0x1
     67b:	8d 45 f4             	lea    -0xc(%ebp),%eax
     67e:	50                   	push   %eax
     67f:	ff 75 08             	pushl  0x8(%ebp)
     682:	e8 1b ff ff ff       	call   5a2 <write>
     687:	83 c4 10             	add    $0x10,%esp
}
     68a:	90                   	nop
     68b:	c9                   	leave  
     68c:	c3                   	ret    

0000068d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     68d:	55                   	push   %ebp
     68e:	89 e5                	mov    %esp,%ebp
     690:	53                   	push   %ebx
     691:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     694:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     69b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     69f:	74 17                	je     6b8 <printint+0x2b>
     6a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6a5:	79 11                	jns    6b8 <printint+0x2b>
    neg = 1;
     6a7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     6b1:	f7 d8                	neg    %eax
     6b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6b6:	eb 06                	jmp    6be <printint+0x31>
  } else {
    x = xx;
     6b8:	8b 45 0c             	mov    0xc(%ebp),%eax
     6bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6c5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6c8:	8d 41 01             	lea    0x1(%ecx),%eax
     6cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6ce:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6d4:	ba 00 00 00 00       	mov    $0x0,%edx
     6d9:	f7 f3                	div    %ebx
     6db:	89 d0                	mov    %edx,%eax
     6dd:	0f b6 80 20 2f 00 00 	movzbl 0x2f20(%eax),%eax
     6e4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     6e8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6ee:	ba 00 00 00 00       	mov    $0x0,%edx
     6f3:	f7 f3                	div    %ebx
     6f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6fc:	75 c7                	jne    6c5 <printint+0x38>
  if(neg)
     6fe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     702:	74 2d                	je     731 <printint+0xa4>
    buf[i++] = '-';
     704:	8b 45 f4             	mov    -0xc(%ebp),%eax
     707:	8d 50 01             	lea    0x1(%eax),%edx
     70a:	89 55 f4             	mov    %edx,-0xc(%ebp)
     70d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     712:	eb 1d                	jmp    731 <printint+0xa4>
    putc(fd, buf[i]);
     714:	8d 55 dc             	lea    -0x24(%ebp),%edx
     717:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71a:	01 d0                	add    %edx,%eax
     71c:	0f b6 00             	movzbl (%eax),%eax
     71f:	0f be c0             	movsbl %al,%eax
     722:	83 ec 08             	sub    $0x8,%esp
     725:	50                   	push   %eax
     726:	ff 75 08             	pushl  0x8(%ebp)
     729:	e8 3c ff ff ff       	call   66a <putc>
     72e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     731:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     735:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     739:	79 d9                	jns    714 <printint+0x87>
    putc(fd, buf[i]);
}
     73b:	90                   	nop
     73c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     73f:	c9                   	leave  
     740:	c3                   	ret    

00000741 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     741:	55                   	push   %ebp
     742:	89 e5                	mov    %esp,%ebp
     744:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     747:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     74e:	8d 45 0c             	lea    0xc(%ebp),%eax
     751:	83 c0 04             	add    $0x4,%eax
     754:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     757:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     75e:	e9 59 01 00 00       	jmp    8bc <printf+0x17b>
    c = fmt[i] & 0xff;
     763:	8b 55 0c             	mov    0xc(%ebp),%edx
     766:	8b 45 f0             	mov    -0x10(%ebp),%eax
     769:	01 d0                	add    %edx,%eax
     76b:	0f b6 00             	movzbl (%eax),%eax
     76e:	0f be c0             	movsbl %al,%eax
     771:	25 ff 00 00 00       	and    $0xff,%eax
     776:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     779:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     77d:	75 2c                	jne    7ab <printf+0x6a>
      if(c == '%'){
     77f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     783:	75 0c                	jne    791 <printf+0x50>
        state = '%';
     785:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     78c:	e9 27 01 00 00       	jmp    8b8 <printf+0x177>
      } else {
        putc(fd, c);
     791:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     794:	0f be c0             	movsbl %al,%eax
     797:	83 ec 08             	sub    $0x8,%esp
     79a:	50                   	push   %eax
     79b:	ff 75 08             	pushl  0x8(%ebp)
     79e:	e8 c7 fe ff ff       	call   66a <putc>
     7a3:	83 c4 10             	add    $0x10,%esp
     7a6:	e9 0d 01 00 00       	jmp    8b8 <printf+0x177>
      }
    } else if(state == '%'){
     7ab:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7af:	0f 85 03 01 00 00    	jne    8b8 <printf+0x177>
      if(c == 'd'){
     7b5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7b9:	75 1e                	jne    7d9 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7be:	8b 00                	mov    (%eax),%eax
     7c0:	6a 01                	push   $0x1
     7c2:	6a 0a                	push   $0xa
     7c4:	50                   	push   %eax
     7c5:	ff 75 08             	pushl  0x8(%ebp)
     7c8:	e8 c0 fe ff ff       	call   68d <printint>
     7cd:	83 c4 10             	add    $0x10,%esp
        ap++;
     7d0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7d4:	e9 d8 00 00 00       	jmp    8b1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7d9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7dd:	74 06                	je     7e5 <printf+0xa4>
     7df:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7e3:	75 1e                	jne    803 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7e8:	8b 00                	mov    (%eax),%eax
     7ea:	6a 00                	push   $0x0
     7ec:	6a 10                	push   $0x10
     7ee:	50                   	push   %eax
     7ef:	ff 75 08             	pushl  0x8(%ebp)
     7f2:	e8 96 fe ff ff       	call   68d <printint>
     7f7:	83 c4 10             	add    $0x10,%esp
        ap++;
     7fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7fe:	e9 ae 00 00 00       	jmp    8b1 <printf+0x170>
      } else if(c == 's'){
     803:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     807:	75 43                	jne    84c <printf+0x10b>
        s = (char*)*ap;
     809:	8b 45 e8             	mov    -0x18(%ebp),%eax
     80c:	8b 00                	mov    (%eax),%eax
     80e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     811:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     815:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     819:	75 25                	jne    840 <printf+0xff>
          s = "(null)";
     81b:	c7 45 f4 8e 27 00 00 	movl   $0x278e,-0xc(%ebp)
        while(*s != 0){
     822:	eb 1c                	jmp    840 <printf+0xff>
          putc(fd, *s);
     824:	8b 45 f4             	mov    -0xc(%ebp),%eax
     827:	0f b6 00             	movzbl (%eax),%eax
     82a:	0f be c0             	movsbl %al,%eax
     82d:	83 ec 08             	sub    $0x8,%esp
     830:	50                   	push   %eax
     831:	ff 75 08             	pushl  0x8(%ebp)
     834:	e8 31 fe ff ff       	call   66a <putc>
     839:	83 c4 10             	add    $0x10,%esp
          s++;
     83c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     840:	8b 45 f4             	mov    -0xc(%ebp),%eax
     843:	0f b6 00             	movzbl (%eax),%eax
     846:	84 c0                	test   %al,%al
     848:	75 da                	jne    824 <printf+0xe3>
     84a:	eb 65                	jmp    8b1 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     84c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     850:	75 1d                	jne    86f <printf+0x12e>
        putc(fd, *ap);
     852:	8b 45 e8             	mov    -0x18(%ebp),%eax
     855:	8b 00                	mov    (%eax),%eax
     857:	0f be c0             	movsbl %al,%eax
     85a:	83 ec 08             	sub    $0x8,%esp
     85d:	50                   	push   %eax
     85e:	ff 75 08             	pushl  0x8(%ebp)
     861:	e8 04 fe ff ff       	call   66a <putc>
     866:	83 c4 10             	add    $0x10,%esp
        ap++;
     869:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     86d:	eb 42                	jmp    8b1 <printf+0x170>
      } else if(c == '%'){
     86f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     873:	75 17                	jne    88c <printf+0x14b>
        putc(fd, c);
     875:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     878:	0f be c0             	movsbl %al,%eax
     87b:	83 ec 08             	sub    $0x8,%esp
     87e:	50                   	push   %eax
     87f:	ff 75 08             	pushl  0x8(%ebp)
     882:	e8 e3 fd ff ff       	call   66a <putc>
     887:	83 c4 10             	add    $0x10,%esp
     88a:	eb 25                	jmp    8b1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     88c:	83 ec 08             	sub    $0x8,%esp
     88f:	6a 25                	push   $0x25
     891:	ff 75 08             	pushl  0x8(%ebp)
     894:	e8 d1 fd ff ff       	call   66a <putc>
     899:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     89c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     89f:	0f be c0             	movsbl %al,%eax
     8a2:	83 ec 08             	sub    $0x8,%esp
     8a5:	50                   	push   %eax
     8a6:	ff 75 08             	pushl  0x8(%ebp)
     8a9:	e8 bc fd ff ff       	call   66a <putc>
     8ae:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8b8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8bc:	8b 55 0c             	mov    0xc(%ebp),%edx
     8bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c2:	01 d0                	add    %edx,%eax
     8c4:	0f b6 00             	movzbl (%eax),%eax
     8c7:	84 c0                	test   %al,%al
     8c9:	0f 85 94 fe ff ff    	jne    763 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8cf:	90                   	nop
     8d0:	c9                   	leave  
     8d1:	c3                   	ret    

000008d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8d2:	55                   	push   %ebp
     8d3:	89 e5                	mov    %esp,%ebp
     8d5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8d8:	8b 45 08             	mov    0x8(%ebp),%eax
     8db:	83 e8 08             	sub    $0x8,%eax
     8de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8e1:	a1 88 6b 00 00       	mov    0x6b88,%eax
     8e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8e9:	eb 24                	jmp    90f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ee:	8b 00                	mov    (%eax),%eax
     8f0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8f3:	77 12                	ja     907 <free+0x35>
     8f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8f8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8fb:	77 24                	ja     921 <free+0x4f>
     8fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     900:	8b 00                	mov    (%eax),%eax
     902:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     905:	77 1a                	ja     921 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     907:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90a:	8b 00                	mov    (%eax),%eax
     90c:	89 45 fc             	mov    %eax,-0x4(%ebp)
     90f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     912:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     915:	76 d4                	jbe    8eb <free+0x19>
     917:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91a:	8b 00                	mov    (%eax),%eax
     91c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     91f:	76 ca                	jbe    8eb <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     921:	8b 45 f8             	mov    -0x8(%ebp),%eax
     924:	8b 40 04             	mov    0x4(%eax),%eax
     927:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     92e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     931:	01 c2                	add    %eax,%edx
     933:	8b 45 fc             	mov    -0x4(%ebp),%eax
     936:	8b 00                	mov    (%eax),%eax
     938:	39 c2                	cmp    %eax,%edx
     93a:	75 24                	jne    960 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     93c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93f:	8b 50 04             	mov    0x4(%eax),%edx
     942:	8b 45 fc             	mov    -0x4(%ebp),%eax
     945:	8b 00                	mov    (%eax),%eax
     947:	8b 40 04             	mov    0x4(%eax),%eax
     94a:	01 c2                	add    %eax,%edx
     94c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     94f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     952:	8b 45 fc             	mov    -0x4(%ebp),%eax
     955:	8b 00                	mov    (%eax),%eax
     957:	8b 10                	mov    (%eax),%edx
     959:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95c:	89 10                	mov    %edx,(%eax)
     95e:	eb 0a                	jmp    96a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     960:	8b 45 fc             	mov    -0x4(%ebp),%eax
     963:	8b 10                	mov    (%eax),%edx
     965:	8b 45 f8             	mov    -0x8(%ebp),%eax
     968:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     96a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     96d:	8b 40 04             	mov    0x4(%eax),%eax
     970:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     977:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97a:	01 d0                	add    %edx,%eax
     97c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     97f:	75 20                	jne    9a1 <free+0xcf>
    p->s.size += bp->s.size;
     981:	8b 45 fc             	mov    -0x4(%ebp),%eax
     984:	8b 50 04             	mov    0x4(%eax),%edx
     987:	8b 45 f8             	mov    -0x8(%ebp),%eax
     98a:	8b 40 04             	mov    0x4(%eax),%eax
     98d:	01 c2                	add    %eax,%edx
     98f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     992:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     995:	8b 45 f8             	mov    -0x8(%ebp),%eax
     998:	8b 10                	mov    (%eax),%edx
     99a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99d:	89 10                	mov    %edx,(%eax)
     99f:	eb 08                	jmp    9a9 <free+0xd7>
  } else
    p->s.ptr = bp;
     9a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9a7:	89 10                	mov    %edx,(%eax)
  freep = p;
     9a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ac:	a3 88 6b 00 00       	mov    %eax,0x6b88
}
     9b1:	90                   	nop
     9b2:	c9                   	leave  
     9b3:	c3                   	ret    

000009b4 <morecore>:

static Header*
morecore(uint nu)
{
     9b4:	55                   	push   %ebp
     9b5:	89 e5                	mov    %esp,%ebp
     9b7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9ba:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9c1:	77 07                	ja     9ca <morecore+0x16>
    nu = 4096;
     9c3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9ca:	8b 45 08             	mov    0x8(%ebp),%eax
     9cd:	c1 e0 03             	shl    $0x3,%eax
     9d0:	83 ec 0c             	sub    $0xc,%esp
     9d3:	50                   	push   %eax
     9d4:	e8 31 fc ff ff       	call   60a <sbrk>
     9d9:	83 c4 10             	add    $0x10,%esp
     9dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9df:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9e3:	75 07                	jne    9ec <morecore+0x38>
    return 0;
     9e5:	b8 00 00 00 00       	mov    $0x0,%eax
     9ea:	eb 26                	jmp    a12 <morecore+0x5e>
  hp = (Header*)p;
     9ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f5:	8b 55 08             	mov    0x8(%ebp),%edx
     9f8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9fe:	83 c0 08             	add    $0x8,%eax
     a01:	83 ec 0c             	sub    $0xc,%esp
     a04:	50                   	push   %eax
     a05:	e8 c8 fe ff ff       	call   8d2 <free>
     a0a:	83 c4 10             	add    $0x10,%esp
  return freep;
     a0d:	a1 88 6b 00 00       	mov    0x6b88,%eax
}
     a12:	c9                   	leave  
     a13:	c3                   	ret    

00000a14 <malloc>:

void*
malloc(uint nbytes)
{
     a14:	55                   	push   %ebp
     a15:	89 e5                	mov    %esp,%ebp
     a17:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a1a:	8b 45 08             	mov    0x8(%ebp),%eax
     a1d:	83 c0 07             	add    $0x7,%eax
     a20:	c1 e8 03             	shr    $0x3,%eax
     a23:	83 c0 01             	add    $0x1,%eax
     a26:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a29:	a1 88 6b 00 00       	mov    0x6b88,%eax
     a2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a31:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a35:	75 23                	jne    a5a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a37:	c7 45 f0 80 6b 00 00 	movl   $0x6b80,-0x10(%ebp)
     a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a41:	a3 88 6b 00 00       	mov    %eax,0x6b88
     a46:	a1 88 6b 00 00       	mov    0x6b88,%eax
     a4b:	a3 80 6b 00 00       	mov    %eax,0x6b80
    base.s.size = 0;
     a50:	c7 05 84 6b 00 00 00 	movl   $0x0,0x6b84
     a57:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a5d:	8b 00                	mov    (%eax),%eax
     a5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a65:	8b 40 04             	mov    0x4(%eax),%eax
     a68:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a6b:	72 4d                	jb     aba <malloc+0xa6>
      if(p->s.size == nunits)
     a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a70:	8b 40 04             	mov    0x4(%eax),%eax
     a73:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a76:	75 0c                	jne    a84 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7b:	8b 10                	mov    (%eax),%edx
     a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a80:	89 10                	mov    %edx,(%eax)
     a82:	eb 26                	jmp    aaa <malloc+0x96>
      else {
        p->s.size -= nunits;
     a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a87:	8b 40 04             	mov    0x4(%eax),%eax
     a8a:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a8d:	89 c2                	mov    %eax,%edx
     a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a92:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a98:	8b 40 04             	mov    0x4(%eax),%eax
     a9b:	c1 e0 03             	shl    $0x3,%eax
     a9e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa4:	8b 55 ec             	mov    -0x14(%ebp),%edx
     aa7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     aaa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aad:	a3 88 6b 00 00       	mov    %eax,0x6b88
      return (void*)(p + 1);
     ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab5:	83 c0 08             	add    $0x8,%eax
     ab8:	eb 3b                	jmp    af5 <malloc+0xe1>
    }
    if(p == freep)
     aba:	a1 88 6b 00 00       	mov    0x6b88,%eax
     abf:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ac2:	75 1e                	jne    ae2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     ac4:	83 ec 0c             	sub    $0xc,%esp
     ac7:	ff 75 ec             	pushl  -0x14(%ebp)
     aca:	e8 e5 fe ff ff       	call   9b4 <morecore>
     acf:	83 c4 10             	add    $0x10,%esp
     ad2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ad5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ad9:	75 07                	jne    ae2 <malloc+0xce>
        return 0;
     adb:	b8 00 00 00 00       	mov    $0x0,%eax
     ae0:	eb 13                	jmp    af5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ae8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aeb:	8b 00                	mov    (%eax),%eax
     aed:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     af0:	e9 6d ff ff ff       	jmp    a62 <malloc+0x4e>
}
     af5:	c9                   	leave  
     af6:	c3                   	ret    

00000af7 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     af7:	55                   	push   %ebp
     af8:	89 e5                	mov    %esp,%ebp
     afa:	83 ec 1c             	sub    $0x1c,%esp
     afd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b00:	8b 55 10             	mov    0x10(%ebp),%edx
     b03:	8b 45 14             	mov    0x14(%ebp),%eax
     b06:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b09:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b0c:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b0f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b13:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b16:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b1a:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b1d:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b21:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b24:	8b 45 08             	mov    0x8(%ebp),%eax
     b27:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b2b:	66 89 10             	mov    %dx,(%eax)
     b2e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b32:	88 50 02             	mov    %dl,0x2(%eax)
}
     b35:	8b 45 08             	mov    0x8(%ebp),%eax
     b38:	c9                   	leave  
     b39:	c2 04 00             	ret    $0x4

00000b3c <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b3c:	55                   	push   %ebp
     b3d:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b3f:	8b 45 08             	mov    0x8(%ebp),%eax
     b42:	2b 45 10             	sub    0x10(%ebp),%eax
     b45:	89 c2                	mov    %eax,%edx
     b47:	8b 45 08             	mov    0x8(%ebp),%eax
     b4a:	2b 45 10             	sub    0x10(%ebp),%eax
     b4d:	0f af d0             	imul   %eax,%edx
     b50:	8b 45 0c             	mov    0xc(%ebp),%eax
     b53:	2b 45 14             	sub    0x14(%ebp),%eax
     b56:	89 c1                	mov    %eax,%ecx
     b58:	8b 45 0c             	mov    0xc(%ebp),%eax
     b5b:	2b 45 14             	sub    0x14(%ebp),%eax
     b5e:	0f af c1             	imul   %ecx,%eax
     b61:	01 d0                	add    %edx,%eax
}
     b63:	5d                   	pop    %ebp
     b64:	c3                   	ret    

00000b65 <abs_int>:

static inline int abs_int(int x)
{
     b65:	55                   	push   %ebp
     b66:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b68:	8b 45 08             	mov    0x8(%ebp),%eax
     b6b:	99                   	cltd   
     b6c:	89 d0                	mov    %edx,%eax
     b6e:	33 45 08             	xor    0x8(%ebp),%eax
     b71:	29 d0                	sub    %edx,%eax
}
     b73:	5d                   	pop    %ebp
     b74:	c3                   	ret    

00000b75 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b75:	55                   	push   %ebp
     b76:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b78:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b7c:	79 07                	jns    b85 <APGetIndex+0x10>
        return X_SMALLER;
     b7e:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b83:	eb 40                	jmp    bc5 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     b85:	8b 45 08             	mov    0x8(%ebp),%eax
     b88:	8b 00                	mov    (%eax),%eax
     b8a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     b8d:	7f 07                	jg     b96 <APGetIndex+0x21>
        return X_BIGGER;
     b8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b94:	eb 2f                	jmp    bc5 <APGetIndex+0x50>
    if (y < 0)
     b96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     b9a:	79 07                	jns    ba3 <APGetIndex+0x2e>
        return Y_SMALLER;
     b9c:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     ba1:	eb 22                	jmp    bc5 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     ba3:	8b 45 08             	mov    0x8(%ebp),%eax
     ba6:	8b 40 04             	mov    0x4(%eax),%eax
     ba9:	3b 45 10             	cmp    0x10(%ebp),%eax
     bac:	7f 07                	jg     bb5 <APGetIndex+0x40>
        return Y_BIGGER;
     bae:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     bb3:	eb 10                	jmp    bc5 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     bb5:	8b 45 08             	mov    0x8(%ebp),%eax
     bb8:	8b 00                	mov    (%eax),%eax
     bba:	0f af 45 10          	imul   0x10(%ebp),%eax
     bbe:	89 c2                	mov    %eax,%edx
     bc0:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc3:	01 d0                	add    %edx,%eax
}
     bc5:	5d                   	pop    %ebp
     bc6:	c3                   	ret    

00000bc7 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     bc7:	55                   	push   %ebp
     bc8:	89 e5                	mov    %esp,%ebp
     bca:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bcd:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bd4:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bd7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bda:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     be1:	83 ec 08             	sub    $0x8,%esp
     be4:	6a 00                	push   $0x0
     be6:	ff 75 0c             	pushl  0xc(%ebp)
     be9:	e8 d4 f9 ff ff       	call   5c2 <open>
     bee:	83 c4 10             	add    $0x10,%esp
     bf1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bf4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bf8:	79 2e                	jns    c28 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     bfa:	83 ec 04             	sub    $0x4,%esp
     bfd:	ff 75 0c             	pushl  0xc(%ebp)
     c00:	68 95 27 00 00       	push   $0x2795
     c05:	6a 01                	push   $0x1
     c07:	e8 35 fb ff ff       	call   741 <printf>
     c0c:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c0f:	8b 45 08             	mov    0x8(%ebp),%eax
     c12:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c15:	89 10                	mov    %edx,(%eax)
     c17:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c1a:	89 50 04             	mov    %edx,0x4(%eax)
     c1d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c20:	89 50 08             	mov    %edx,0x8(%eax)
     c23:	e9 d2 01 00 00       	jmp    dfa <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c28:	83 ec 04             	sub    $0x4,%esp
     c2b:	6a 0e                	push   $0xe
     c2d:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c30:	50                   	push   %eax
     c31:	ff 75 ec             	pushl  -0x14(%ebp)
     c34:	e8 61 f9 ff ff       	call   59a <read>
     c39:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c3c:	83 ec 04             	sub    $0x4,%esp
     c3f:	6a 28                	push   $0x28
     c41:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c44:	50                   	push   %eax
     c45:	ff 75 ec             	pushl  -0x14(%ebp)
     c48:	e8 4d f9 ff ff       	call   59a <read>
     c4d:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c50:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c53:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c56:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c59:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c5c:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c5f:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c62:	0f af d0             	imul   %eax,%edx
     c65:	89 d0                	mov    %edx,%eax
     c67:	01 c0                	add    %eax,%eax
     c69:	01 d0                	add    %edx,%eax
     c6b:	83 ec 0c             	sub    $0xc,%esp
     c6e:	50                   	push   %eax
     c6f:	e8 a0 fd ff ff       	call   a14 <malloc>
     c74:	83 c4 10             	add    $0x10,%esp
     c77:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c7a:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c7e:	0f b7 c0             	movzwl %ax,%eax
     c81:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c84:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c87:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c8a:	0f af c2             	imul   %edx,%eax
     c8d:	83 c0 1f             	add    $0x1f,%eax
     c90:	c1 e8 05             	shr    $0x5,%eax
     c93:	c1 e0 02             	shl    $0x2,%eax
     c96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     c99:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c9f:	0f af c2             	imul   %edx,%eax
     ca2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     ca5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ca8:	83 ec 0c             	sub    $0xc,%esp
     cab:	50                   	push   %eax
     cac:	e8 63 fd ff ff       	call   a14 <malloc>
     cb1:	83 c4 10             	add    $0x10,%esp
     cb4:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     cb7:	83 ec 04             	sub    $0x4,%esp
     cba:	ff 75 e0             	pushl  -0x20(%ebp)
     cbd:	ff 75 dc             	pushl  -0x24(%ebp)
     cc0:	ff 75 ec             	pushl  -0x14(%ebp)
     cc3:	e8 d2 f8 ff ff       	call   59a <read>
     cc8:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     ccb:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     ccf:	66 c1 e8 03          	shr    $0x3,%ax
     cd3:	0f b7 c0             	movzwl %ax,%eax
     cd6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     cd9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ce0:	e9 e5 00 00 00       	jmp    dca <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ce5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ce8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ceb:	29 c2                	sub    %eax,%edx
     ced:	89 d0                	mov    %edx,%eax
     cef:	8d 50 ff             	lea    -0x1(%eax),%edx
     cf2:	8b 45 c8             	mov    -0x38(%ebp),%eax
     cf5:	0f af c2             	imul   %edx,%eax
     cf8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     cfb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d02:	e9 b1 00 00 00       	jmp    db8 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d07:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d0a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d10:	01 c8                	add    %ecx,%eax
     d12:	89 c1                	mov    %eax,%ecx
     d14:	89 c8                	mov    %ecx,%eax
     d16:	01 c0                	add    %eax,%eax
     d18:	01 c8                	add    %ecx,%eax
     d1a:	01 c2                	add    %eax,%edx
     d1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d23:	89 c1                	mov    %eax,%ecx
     d25:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d28:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d2c:	01 c1                	add    %eax,%ecx
     d2e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d31:	01 c8                	add    %ecx,%eax
     d33:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d36:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d39:	01 c8                	add    %ecx,%eax
     d3b:	0f b6 00             	movzbl (%eax),%eax
     d3e:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d41:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d44:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d47:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d4a:	01 c8                	add    %ecx,%eax
     d4c:	89 c1                	mov    %eax,%ecx
     d4e:	89 c8                	mov    %ecx,%eax
     d50:	01 c0                	add    %eax,%eax
     d52:	01 c8                	add    %ecx,%eax
     d54:	01 c2                	add    %eax,%edx
     d56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d59:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d5d:	89 c1                	mov    %eax,%ecx
     d5f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d62:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d66:	01 c1                	add    %eax,%ecx
     d68:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d6b:	01 c8                	add    %ecx,%eax
     d6d:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d70:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d73:	01 c8                	add    %ecx,%eax
     d75:	0f b6 00             	movzbl (%eax),%eax
     d78:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d7b:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d7e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d81:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d84:	01 c8                	add    %ecx,%eax
     d86:	89 c1                	mov    %eax,%ecx
     d88:	89 c8                	mov    %ecx,%eax
     d8a:	01 c0                	add    %eax,%eax
     d8c:	01 c8                	add    %ecx,%eax
     d8e:	01 c2                	add    %eax,%edx
     d90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d93:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d97:	89 c1                	mov    %eax,%ecx
     d99:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d9c:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     da0:	01 c1                	add    %eax,%ecx
     da2:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da5:	01 c8                	add    %ecx,%eax
     da7:	8d 48 fd             	lea    -0x3(%eax),%ecx
     daa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dad:	01 c8                	add    %ecx,%eax
     daf:	0f b6 00             	movzbl (%eax),%eax
     db2:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     db4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     db8:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dbe:	39 c2                	cmp    %eax,%edx
     dc0:	0f 87 41 ff ff ff    	ja     d07 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     dc6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dca:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd0:	39 c2                	cmp    %eax,%edx
     dd2:	0f 87 0d ff ff ff    	ja     ce5 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     dd8:	83 ec 0c             	sub    $0xc,%esp
     ddb:	ff 75 ec             	pushl  -0x14(%ebp)
     dde:	e8 c7 f7 ff ff       	call   5aa <close>
     de3:	83 c4 10             	add    $0x10,%esp
    return bmp;
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
     de9:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dec:	89 10                	mov    %edx,(%eax)
     dee:	8b 55 cc             	mov    -0x34(%ebp),%edx
     df1:	89 50 04             	mov    %edx,0x4(%eax)
     df4:	8b 55 d0             	mov    -0x30(%ebp),%edx
     df7:	89 50 08             	mov    %edx,0x8(%eax)
}
     dfa:	8b 45 08             	mov    0x8(%ebp),%eax
     dfd:	c9                   	leave  
     dfe:	c2 04 00             	ret    $0x4

00000e01 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e01:	55                   	push   %ebp
     e02:	89 e5                	mov    %esp,%ebp
     e04:	53                   	push   %ebx
     e05:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	6a 1c                	push   $0x1c
     e0d:	e8 02 fc ff ff       	call   a14 <malloc>
     e12:	83 c4 10             	add    $0x10,%esp
     e15:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e18:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e1b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e22:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e25:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e28:	6a 0c                	push   $0xc
     e2a:	6a 0c                	push   $0xc
     e2c:	6a 0c                	push   $0xc
     e2e:	50                   	push   %eax
     e2f:	e8 c3 fc ff ff       	call   af7 <RGB>
     e34:	83 c4 0c             	add    $0xc,%esp
     e37:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e3b:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e3f:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e43:	88 43 15             	mov    %al,0x15(%ebx)
     e46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e49:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e4c:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e50:	66 89 48 10          	mov    %cx,0x10(%eax)
     e54:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e58:	88 50 12             	mov    %dl,0x12(%eax)
     e5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e61:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e65:	66 89 48 08          	mov    %cx,0x8(%eax)
     e69:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e6d:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e70:	8b 45 08             	mov    0x8(%ebp),%eax
     e73:	89 c2                	mov    %eax,%edx
     e75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e78:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e7d:	89 c2                	mov    %eax,%edx
     e7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e82:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     e85:	8b 55 10             	mov    0x10(%ebp),%edx
     e88:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e8b:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     e8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e94:	c9                   	leave  
     e95:	c3                   	ret    

00000e96 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     e96:	55                   	push   %ebp
     e97:	89 e5                	mov    %esp,%ebp
     e99:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9f:	8b 50 08             	mov    0x8(%eax),%edx
     ea2:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ea5:	8b 40 0c             	mov    0xc(%eax),%eax
     ea8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     eab:	8b 45 0c             	mov    0xc(%ebp),%eax
     eae:	8b 55 10             	mov    0x10(%ebp),%edx
     eb1:	89 50 08             	mov    %edx,0x8(%eax)
     eb4:	8b 55 14             	mov    0x14(%ebp),%edx
     eb7:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     eba:	8b 45 08             	mov    0x8(%ebp),%eax
     ebd:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ec0:	89 10                	mov    %edx,(%eax)
     ec2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ec5:	89 50 04             	mov    %edx,0x4(%eax)
}
     ec8:	8b 45 08             	mov    0x8(%ebp),%eax
     ecb:	c9                   	leave  
     ecc:	c2 04 00             	ret    $0x4

00000ecf <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ecf:	55                   	push   %ebp
     ed0:	89 e5                	mov    %esp,%ebp
     ed2:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed8:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     edc:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ee0:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ee4:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ee7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eea:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     eee:	66 89 50 10          	mov    %dx,0x10(%eax)
     ef2:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     ef6:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     ef9:	8b 45 08             	mov    0x8(%ebp),%eax
     efc:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f00:	66 89 10             	mov    %dx,(%eax)
     f03:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f07:	88 50 02             	mov    %dl,0x2(%eax)
}
     f0a:	8b 45 08             	mov    0x8(%ebp),%eax
     f0d:	c9                   	leave  
     f0e:	c2 04 00             	ret    $0x4

00000f11 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     f11:	55                   	push   %ebp
     f12:	89 e5                	mov    %esp,%ebp
     f14:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     f17:	8b 45 0c             	mov    0xc(%ebp),%eax
     f1a:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     f1e:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f22:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     f26:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     f29:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2c:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f30:	66 89 50 13          	mov    %dx,0x13(%eax)
     f34:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f38:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     f3b:	8b 45 08             	mov    0x8(%ebp),%eax
     f3e:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f42:	66 89 10             	mov    %dx,(%eax)
     f45:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f49:	88 50 02             	mov    %dl,0x2(%eax)
}
     f4c:	8b 45 08             	mov    0x8(%ebp),%eax
     f4f:	c9                   	leave  
     f50:	c2 04 00             	ret    $0x4

00000f53 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f53:	55                   	push   %ebp
     f54:	89 e5                	mov    %esp,%ebp
     f56:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f59:	8b 45 08             	mov    0x8(%ebp),%eax
     f5c:	8b 40 0c             	mov    0xc(%eax),%eax
     f5f:	89 c2                	mov    %eax,%edx
     f61:	c1 ea 1f             	shr    $0x1f,%edx
     f64:	01 d0                	add    %edx,%eax
     f66:	d1 f8                	sar    %eax
     f68:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f6e:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f72:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f75:	8b 45 10             	mov    0x10(%ebp),%eax
     f78:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f7e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f82:	0f 89 98 00 00 00    	jns    1020 <APDrawPoint+0xcd>
        i = 0;
     f88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f8f:	e9 8c 00 00 00       	jmp    1020 <APDrawPoint+0xcd>
    {
        j = x - off;
     f94:	8b 45 0c             	mov    0xc(%ebp),%eax
     f97:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f9a:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f9d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     fa1:	79 69                	jns    100c <APDrawPoint+0xb9>
            j = 0;
     fa3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     faa:	eb 60                	jmp    100c <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     fac:	ff 75 fc             	pushl  -0x4(%ebp)
     faf:	ff 75 f8             	pushl  -0x8(%ebp)
     fb2:	ff 75 08             	pushl  0x8(%ebp)
     fb5:	e8 bb fb ff ff       	call   b75 <APGetIndex>
     fba:	83 c4 0c             	add    $0xc,%esp
     fbd:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     fc0:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     fc4:	74 55                	je     101b <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     fc6:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     fca:	74 67                	je     1033 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     fcc:	ff 75 10             	pushl  0x10(%ebp)
     fcf:	ff 75 0c             	pushl  0xc(%ebp)
     fd2:	ff 75 fc             	pushl  -0x4(%ebp)
     fd5:	ff 75 f8             	pushl  -0x8(%ebp)
     fd8:	e8 5f fb ff ff       	call   b3c <distance_2>
     fdd:	83 c4 10             	add    $0x10,%esp
     fe0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fe3:	7f 23                	jg     1008 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     fe5:	8b 45 08             	mov    0x8(%ebp),%eax
     fe8:	8b 48 18             	mov    0x18(%eax),%ecx
     feb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fee:	89 d0                	mov    %edx,%eax
     ff0:	01 c0                	add    %eax,%eax
     ff2:	01 d0                	add    %edx,%eax
     ff4:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     ff7:	8b 45 08             	mov    0x8(%ebp),%eax
     ffa:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     ffe:	66 89 0a             	mov    %cx,(%edx)
    1001:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1005:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1008:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    100c:	8b 55 0c             	mov    0xc(%ebp),%edx
    100f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1012:	01 d0                	add    %edx,%eax
    1014:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1017:	7d 93                	jge    fac <APDrawPoint+0x59>
    1019:	eb 01                	jmp    101c <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    101b:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    101c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1020:	8b 55 10             	mov    0x10(%ebp),%edx
    1023:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1026:	01 d0                	add    %edx,%eax
    1028:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    102b:	0f 8d 63 ff ff ff    	jge    f94 <APDrawPoint+0x41>
    1031:	eb 01                	jmp    1034 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    1033:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    1034:	c9                   	leave  
    1035:	c3                   	ret    

00001036 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1036:	55                   	push   %ebp
    1037:	89 e5                	mov    %esp,%ebp
    1039:	53                   	push   %ebx
    103a:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    103d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1040:	3b 45 14             	cmp    0x14(%ebp),%eax
    1043:	0f 85 80 00 00 00    	jne    10c9 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1049:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    104d:	0f 88 9d 02 00 00    	js     12f0 <APDrawLine+0x2ba>
    1053:	8b 45 08             	mov    0x8(%ebp),%eax
    1056:	8b 00                	mov    (%eax),%eax
    1058:	3b 45 0c             	cmp    0xc(%ebp),%eax
    105b:	0f 8e 8f 02 00 00    	jle    12f0 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1061:	8b 45 10             	mov    0x10(%ebp),%eax
    1064:	3b 45 18             	cmp    0x18(%ebp),%eax
    1067:	7e 12                	jle    107b <APDrawLine+0x45>
        {
            int tmp = y2;
    1069:	8b 45 18             	mov    0x18(%ebp),%eax
    106c:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    106f:	8b 45 10             	mov    0x10(%ebp),%eax
    1072:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1075:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1078:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    107b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    107f:	79 07                	jns    1088 <APDrawLine+0x52>
    1081:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1088:	8b 45 08             	mov    0x8(%ebp),%eax
    108b:	8b 40 04             	mov    0x4(%eax),%eax
    108e:	3b 45 18             	cmp    0x18(%ebp),%eax
    1091:	7d 0c                	jge    109f <APDrawLine+0x69>
    1093:	8b 45 08             	mov    0x8(%ebp),%eax
    1096:	8b 40 04             	mov    0x4(%eax),%eax
    1099:	83 e8 01             	sub    $0x1,%eax
    109c:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    109f:	8b 45 10             	mov    0x10(%ebp),%eax
    10a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10a5:	eb 15                	jmp    10bc <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    10a7:	ff 75 f4             	pushl  -0xc(%ebp)
    10aa:	ff 75 0c             	pushl  0xc(%ebp)
    10ad:	ff 75 08             	pushl  0x8(%ebp)
    10b0:	e8 9e fe ff ff       	call   f53 <APDrawPoint>
    10b5:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10bf:	3b 45 18             	cmp    0x18(%ebp),%eax
    10c2:	7e e3                	jle    10a7 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10c4:	e9 2b 02 00 00       	jmp    12f4 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10c9:	8b 45 10             	mov    0x10(%ebp),%eax
    10cc:	3b 45 18             	cmp    0x18(%ebp),%eax
    10cf:	75 7f                	jne    1150 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    10d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10d5:	0f 88 18 02 00 00    	js     12f3 <APDrawLine+0x2bd>
    10db:	8b 45 08             	mov    0x8(%ebp),%eax
    10de:	8b 40 04             	mov    0x4(%eax),%eax
    10e1:	3b 45 10             	cmp    0x10(%ebp),%eax
    10e4:	0f 8e 09 02 00 00    	jle    12f3 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ed:	3b 45 14             	cmp    0x14(%ebp),%eax
    10f0:	7e 12                	jle    1104 <APDrawLine+0xce>
        {
            int tmp = x2;
    10f2:	8b 45 14             	mov    0x14(%ebp),%eax
    10f5:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    10f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fb:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1101:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    1104:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1108:	79 07                	jns    1111 <APDrawLine+0xdb>
    110a:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    1111:	8b 45 08             	mov    0x8(%ebp),%eax
    1114:	8b 00                	mov    (%eax),%eax
    1116:	3b 45 14             	cmp    0x14(%ebp),%eax
    1119:	7d 0b                	jge    1126 <APDrawLine+0xf0>
    111b:	8b 45 08             	mov    0x8(%ebp),%eax
    111e:	8b 00                	mov    (%eax),%eax
    1120:	83 e8 01             	sub    $0x1,%eax
    1123:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1126:	8b 45 0c             	mov    0xc(%ebp),%eax
    1129:	89 45 f0             	mov    %eax,-0x10(%ebp)
    112c:	eb 15                	jmp    1143 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    112e:	ff 75 10             	pushl  0x10(%ebp)
    1131:	ff 75 f0             	pushl  -0x10(%ebp)
    1134:	ff 75 08             	pushl  0x8(%ebp)
    1137:	e8 17 fe ff ff       	call   f53 <APDrawPoint>
    113c:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    113f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1143:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1146:	3b 45 14             	cmp    0x14(%ebp),%eax
    1149:	7e e3                	jle    112e <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    114b:	e9 a4 01 00 00       	jmp    12f4 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1150:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1157:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    115e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1161:	2b 45 14             	sub    0x14(%ebp),%eax
    1164:	50                   	push   %eax
    1165:	e8 fb f9 ff ff       	call   b65 <abs_int>
    116a:	83 c4 04             	add    $0x4,%esp
    116d:	89 c3                	mov    %eax,%ebx
    116f:	8b 45 10             	mov    0x10(%ebp),%eax
    1172:	2b 45 18             	sub    0x18(%ebp),%eax
    1175:	50                   	push   %eax
    1176:	e8 ea f9 ff ff       	call   b65 <abs_int>
    117b:	83 c4 04             	add    $0x4,%esp
    117e:	39 c3                	cmp    %eax,%ebx
    1180:	0f 8e b5 00 00 00    	jle    123b <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1186:	8b 45 10             	mov    0x10(%ebp),%eax
    1189:	2b 45 18             	sub    0x18(%ebp),%eax
    118c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    118f:	db 45 b0             	fildl  -0x50(%ebp)
    1192:	8b 45 0c             	mov    0xc(%ebp),%eax
    1195:	2b 45 14             	sub    0x14(%ebp),%eax
    1198:	89 45 b0             	mov    %eax,-0x50(%ebp)
    119b:	db 45 b0             	fildl  -0x50(%ebp)
    119e:	de f9                	fdivrp %st,%st(1)
    11a0:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    11a3:	8b 45 14             	mov    0x14(%ebp),%eax
    11a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11a9:	7e 0e                	jle    11b9 <APDrawLine+0x183>
        {
            s = x1;
    11ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    11b1:	8b 45 14             	mov    0x14(%ebp),%eax
    11b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11b7:	eb 0c                	jmp    11c5 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11b9:	8b 45 14             	mov    0x14(%ebp),%eax
    11bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11c9:	79 07                	jns    11d2 <APDrawLine+0x19c>
    11cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    11d2:	8b 45 08             	mov    0x8(%ebp),%eax
    11d5:	8b 00                	mov    (%eax),%eax
    11d7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11da:	7f 0b                	jg     11e7 <APDrawLine+0x1b1>
    11dc:	8b 45 08             	mov    0x8(%ebp),%eax
    11df:	8b 00                	mov    (%eax),%eax
    11e1:	83 e8 01             	sub    $0x1,%eax
    11e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11ed:	eb 3f                	jmp    122e <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11f2:	2b 45 0c             	sub    0xc(%ebp),%eax
    11f5:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11f8:	db 45 b0             	fildl  -0x50(%ebp)
    11fb:	dc 4d d0             	fmull  -0x30(%ebp)
    11fe:	db 45 10             	fildl  0x10(%ebp)
    1201:	de c1                	faddp  %st,%st(1)
    1203:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1206:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    120a:	b4 0c                	mov    $0xc,%ah
    120c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1210:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1213:	db 5d cc             	fistpl -0x34(%ebp)
    1216:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1219:	ff 75 cc             	pushl  -0x34(%ebp)
    121c:	ff 75 e4             	pushl  -0x1c(%ebp)
    121f:	ff 75 08             	pushl  0x8(%ebp)
    1222:	e8 2c fd ff ff       	call   f53 <APDrawPoint>
    1227:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    122a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    122e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1231:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1234:	7e b9                	jle    11ef <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1236:	e9 b9 00 00 00       	jmp    12f4 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    123b:	8b 45 0c             	mov    0xc(%ebp),%eax
    123e:	2b 45 14             	sub    0x14(%ebp),%eax
    1241:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1244:	db 45 b0             	fildl  -0x50(%ebp)
    1247:	8b 45 10             	mov    0x10(%ebp),%eax
    124a:	2b 45 18             	sub    0x18(%ebp),%eax
    124d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1250:	db 45 b0             	fildl  -0x50(%ebp)
    1253:	de f9                	fdivrp %st,%st(1)
    1255:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1258:	8b 45 10             	mov    0x10(%ebp),%eax
    125b:	3b 45 18             	cmp    0x18(%ebp),%eax
    125e:	7e 0e                	jle    126e <APDrawLine+0x238>
    {
        s = y2;
    1260:	8b 45 18             	mov    0x18(%ebp),%eax
    1263:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1266:	8b 45 10             	mov    0x10(%ebp),%eax
    1269:	89 45 e8             	mov    %eax,-0x18(%ebp)
    126c:	eb 0c                	jmp    127a <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    126e:	8b 45 10             	mov    0x10(%ebp),%eax
    1271:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1274:	8b 45 18             	mov    0x18(%ebp),%eax
    1277:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    127a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    127e:	79 07                	jns    1287 <APDrawLine+0x251>
    1280:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1287:	8b 45 08             	mov    0x8(%ebp),%eax
    128a:	8b 40 04             	mov    0x4(%eax),%eax
    128d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1290:	7f 0c                	jg     129e <APDrawLine+0x268>
    1292:	8b 45 08             	mov    0x8(%ebp),%eax
    1295:	8b 40 04             	mov    0x4(%eax),%eax
    1298:	83 e8 01             	sub    $0x1,%eax
    129b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    129e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    12a4:	eb 3f                	jmp    12e5 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    12a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12a9:	2b 45 10             	sub    0x10(%ebp),%eax
    12ac:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12af:	db 45 b0             	fildl  -0x50(%ebp)
    12b2:	dc 4d c0             	fmull  -0x40(%ebp)
    12b5:	db 45 0c             	fildl  0xc(%ebp)
    12b8:	de c1                	faddp  %st,%st(1)
    12ba:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12bd:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12c1:	b4 0c                	mov    $0xc,%ah
    12c3:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12c7:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12ca:	db 5d bc             	fistpl -0x44(%ebp)
    12cd:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    12d0:	ff 75 e0             	pushl  -0x20(%ebp)
    12d3:	ff 75 bc             	pushl  -0x44(%ebp)
    12d6:	ff 75 08             	pushl  0x8(%ebp)
    12d9:	e8 75 fc ff ff       	call   f53 <APDrawPoint>
    12de:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12e1:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12e8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12eb:	7e b9                	jle    12a6 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12ed:	90                   	nop
    12ee:	eb 04                	jmp    12f4 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12f0:	90                   	nop
    12f1:	eb 01                	jmp    12f4 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12f3:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12f7:	c9                   	leave  
    12f8:	c3                   	ret    

000012f9 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    12f9:	55                   	push   %ebp
    12fa:	89 e5                	mov    %esp,%ebp
    12fc:	53                   	push   %ebx
    12fd:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1300:	8b 55 10             	mov    0x10(%ebp),%edx
    1303:	8b 45 18             	mov    0x18(%ebp),%eax
    1306:	01 d0                	add    %edx,%eax
    1308:	83 e8 01             	sub    $0x1,%eax
    130b:	83 ec 04             	sub    $0x4,%esp
    130e:	50                   	push   %eax
    130f:	ff 75 0c             	pushl  0xc(%ebp)
    1312:	ff 75 10             	pushl  0x10(%ebp)
    1315:	ff 75 0c             	pushl  0xc(%ebp)
    1318:	ff 75 08             	pushl  0x8(%ebp)
    131b:	e8 16 fd ff ff       	call   1036 <APDrawLine>
    1320:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    1323:	8b 55 0c             	mov    0xc(%ebp),%edx
    1326:	8b 45 14             	mov    0x14(%ebp),%eax
    1329:	01 d0                	add    %edx,%eax
    132b:	83 e8 01             	sub    $0x1,%eax
    132e:	83 ec 04             	sub    $0x4,%esp
    1331:	ff 75 10             	pushl  0x10(%ebp)
    1334:	50                   	push   %eax
    1335:	ff 75 10             	pushl  0x10(%ebp)
    1338:	ff 75 0c             	pushl  0xc(%ebp)
    133b:	ff 75 08             	pushl  0x8(%ebp)
    133e:	e8 f3 fc ff ff       	call   1036 <APDrawLine>
    1343:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1346:	8b 55 10             	mov    0x10(%ebp),%edx
    1349:	8b 45 18             	mov    0x18(%ebp),%eax
    134c:	01 d0                	add    %edx,%eax
    134e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1351:	8b 55 0c             	mov    0xc(%ebp),%edx
    1354:	8b 45 14             	mov    0x14(%ebp),%eax
    1357:	01 d0                	add    %edx,%eax
    1359:	8d 50 ff             	lea    -0x1(%eax),%edx
    135c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    135f:	8b 45 14             	mov    0x14(%ebp),%eax
    1362:	01 d8                	add    %ebx,%eax
    1364:	83 e8 01             	sub    $0x1,%eax
    1367:	83 ec 04             	sub    $0x4,%esp
    136a:	51                   	push   %ecx
    136b:	52                   	push   %edx
    136c:	ff 75 10             	pushl  0x10(%ebp)
    136f:	50                   	push   %eax
    1370:	ff 75 08             	pushl  0x8(%ebp)
    1373:	e8 be fc ff ff       	call   1036 <APDrawLine>
    1378:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    137b:	8b 55 10             	mov    0x10(%ebp),%edx
    137e:	8b 45 18             	mov    0x18(%ebp),%eax
    1381:	01 d0                	add    %edx,%eax
    1383:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1386:	8b 55 0c             	mov    0xc(%ebp),%edx
    1389:	8b 45 14             	mov    0x14(%ebp),%eax
    138c:	01 d0                	add    %edx,%eax
    138e:	8d 50 ff             	lea    -0x1(%eax),%edx
    1391:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1394:	8b 45 18             	mov    0x18(%ebp),%eax
    1397:	01 d8                	add    %ebx,%eax
    1399:	83 e8 01             	sub    $0x1,%eax
    139c:	83 ec 04             	sub    $0x4,%esp
    139f:	51                   	push   %ecx
    13a0:	52                   	push   %edx
    13a1:	50                   	push   %eax
    13a2:	ff 75 0c             	pushl  0xc(%ebp)
    13a5:	ff 75 08             	pushl  0x8(%ebp)
    13a8:	e8 89 fc ff ff       	call   1036 <APDrawLine>
    13ad:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    13b0:	8b 55 0c             	mov    0xc(%ebp),%edx
    13b3:	8b 45 14             	mov    0x14(%ebp),%eax
    13b6:	01 d0                	add    %edx,%eax
    13b8:	8d 50 ff             	lea    -0x1(%eax),%edx
    13bb:	8b 45 08             	mov    0x8(%ebp),%eax
    13be:	8b 40 0c             	mov    0xc(%eax),%eax
    13c1:	89 c1                	mov    %eax,%ecx
    13c3:	c1 e9 1f             	shr    $0x1f,%ecx
    13c6:	01 c8                	add    %ecx,%eax
    13c8:	d1 f8                	sar    %eax
    13ca:	29 c2                	sub    %eax,%edx
    13cc:	89 d0                	mov    %edx,%eax
    13ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    13d1:	8b 55 10             	mov    0x10(%ebp),%edx
    13d4:	8b 45 18             	mov    0x18(%ebp),%eax
    13d7:	01 d0                	add    %edx,%eax
    13d9:	8d 50 ff             	lea    -0x1(%eax),%edx
    13dc:	8b 45 08             	mov    0x8(%ebp),%eax
    13df:	8b 40 0c             	mov    0xc(%eax),%eax
    13e2:	89 c1                	mov    %eax,%ecx
    13e4:	c1 e9 1f             	shr    $0x1f,%ecx
    13e7:	01 c8                	add    %ecx,%eax
    13e9:	d1 f8                	sar    %eax
    13eb:	29 c2                	sub    %eax,%edx
    13ed:	89 d0                	mov    %edx,%eax
    13ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13f2:	8b 45 08             	mov    0x8(%ebp),%eax
    13f5:	8b 40 0c             	mov    0xc(%eax),%eax
    13f8:	89 c2                	mov    %eax,%edx
    13fa:	c1 ea 1f             	shr    $0x1f,%edx
    13fd:	01 d0                	add    %edx,%eax
    13ff:	d1 f8                	sar    %eax
    1401:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    1404:	8b 45 08             	mov    0x8(%ebp),%eax
    1407:	8b 40 0c             	mov    0xc(%eax),%eax
    140a:	89 c2                	mov    %eax,%edx
    140c:	c1 ea 1f             	shr    $0x1f,%edx
    140f:	01 d0                	add    %edx,%eax
    1411:	d1 f8                	sar    %eax
    1413:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1416:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    141a:	0f 88 d8 00 00 00    	js     14f8 <APDrawRect+0x1ff>
    1420:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1424:	0f 88 ce 00 00 00    	js     14f8 <APDrawRect+0x1ff>
    142a:	8b 45 08             	mov    0x8(%ebp),%eax
    142d:	8b 00                	mov    (%eax),%eax
    142f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1432:	0f 8e c0 00 00 00    	jle    14f8 <APDrawRect+0x1ff>
    1438:	8b 45 08             	mov    0x8(%ebp),%eax
    143b:	8b 40 04             	mov    0x4(%eax),%eax
    143e:	3b 45 10             	cmp    0x10(%ebp),%eax
    1441:	0f 8e b1 00 00 00    	jle    14f8 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1447:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    144b:	79 07                	jns    1454 <APDrawRect+0x15b>
    144d:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1454:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1458:	79 07                	jns    1461 <APDrawRect+0x168>
    145a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1461:	8b 45 08             	mov    0x8(%ebp),%eax
    1464:	8b 00                	mov    (%eax),%eax
    1466:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1469:	7f 0b                	jg     1476 <APDrawRect+0x17d>
    146b:	8b 45 08             	mov    0x8(%ebp),%eax
    146e:	8b 00                	mov    (%eax),%eax
    1470:	83 e8 01             	sub    $0x1,%eax
    1473:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1476:	8b 45 08             	mov    0x8(%ebp),%eax
    1479:	8b 40 04             	mov    0x4(%eax),%eax
    147c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    147f:	7f 0c                	jg     148d <APDrawRect+0x194>
    1481:	8b 45 08             	mov    0x8(%ebp),%eax
    1484:	8b 40 04             	mov    0x4(%eax),%eax
    1487:	83 e8 01             	sub    $0x1,%eax
    148a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    148d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1494:	8b 45 0c             	mov    0xc(%ebp),%eax
    1497:	89 45 ec             	mov    %eax,-0x14(%ebp)
    149a:	eb 52                	jmp    14ee <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    149c:	8b 45 10             	mov    0x10(%ebp),%eax
    149f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14a2:	eb 3e                	jmp    14e2 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    14a4:	83 ec 04             	sub    $0x4,%esp
    14a7:	ff 75 e8             	pushl  -0x18(%ebp)
    14aa:	ff 75 ec             	pushl  -0x14(%ebp)
    14ad:	ff 75 08             	pushl  0x8(%ebp)
    14b0:	e8 c0 f6 ff ff       	call   b75 <APGetIndex>
    14b5:	83 c4 10             	add    $0x10,%esp
    14b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14bb:	8b 45 08             	mov    0x8(%ebp),%eax
    14be:	8b 48 18             	mov    0x18(%eax),%ecx
    14c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14c4:	89 d0                	mov    %edx,%eax
    14c6:	01 c0                	add    %eax,%eax
    14c8:	01 d0                	add    %edx,%eax
    14ca:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14cd:	8b 45 08             	mov    0x8(%ebp),%eax
    14d0:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    14d4:	66 89 0a             	mov    %cx,(%edx)
    14d7:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14db:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14de:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14e5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14e8:	7e ba                	jle    14a4 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14ea:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14f4:	7e a6                	jle    149c <APDrawRect+0x1a3>
    14f6:	eb 01                	jmp    14f9 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    14f8:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    14f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14fc:	c9                   	leave  
    14fd:	c3                   	ret    

000014fe <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    14fe:	55                   	push   %ebp
    14ff:	89 e5                	mov    %esp,%ebp
    1501:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    1504:	83 ec 0c             	sub    $0xc,%esp
    1507:	ff 75 0c             	pushl  0xc(%ebp)
    150a:	e8 b1 ee ff ff       	call   3c0 <strlen>
    150f:	83 c4 10             	add    $0x10,%esp
    1512:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1515:	8b 45 08             	mov    0x8(%ebp),%eax
    1518:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    151c:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1520:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    1524:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1527:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    152e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1535:	e9 bc 00 00 00       	jmp    15f6 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    153a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    153d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1540:	01 d0                	add    %edx,%eax
    1542:	0f b6 00             	movzbl (%eax),%eax
    1545:	0f be c0             	movsbl %al,%eax
    1548:	83 e8 20             	sub    $0x20,%eax
    154b:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    154e:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    1552:	0f 87 9a 00 00 00    	ja     15f2 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	8b 00                	mov    (%eax),%eax
    155d:	0f af 45 14          	imul   0x14(%ebp),%eax
    1561:	89 c2                	mov    %eax,%edx
    1563:	8b 45 10             	mov    0x10(%ebp),%eax
    1566:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1569:	8b 55 f4             	mov    -0xc(%ebp),%edx
    156c:	89 d0                	mov    %edx,%eax
    156e:	c1 e0 03             	shl    $0x3,%eax
    1571:	01 d0                	add    %edx,%eax
    1573:	01 c8                	add    %ecx,%eax
    1575:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1578:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    157f:	eb 6b                	jmp    15ec <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    1581:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1588:	eb 50                	jmp    15da <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    158a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    158d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1590:	89 d0                	mov    %edx,%eax
    1592:	c1 e0 03             	shl    $0x3,%eax
    1595:	01 d0                	add    %edx,%eax
    1597:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    159d:	01 c2                	add    %eax,%edx
    159f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15a2:	01 d0                	add    %edx,%eax
    15a4:	05 40 2f 00 00       	add    $0x2f40,%eax
    15a9:	0f b6 00             	movzbl (%eax),%eax
    15ac:	84 c0                	test   %al,%al
    15ae:	74 26                	je     15d6 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    15b0:	8b 45 08             	mov    0x8(%ebp),%eax
    15b3:	8b 50 18             	mov    0x18(%eax),%edx
    15b6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    15b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15bc:	01 c8                	add    %ecx,%eax
    15be:	89 c1                	mov    %eax,%ecx
    15c0:	89 c8                	mov    %ecx,%eax
    15c2:	01 c0                	add    %eax,%eax
    15c4:	01 c8                	add    %ecx,%eax
    15c6:	01 d0                	add    %edx,%eax
    15c8:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    15cc:	66 89 10             	mov    %dx,(%eax)
    15cf:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15d3:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    15d6:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    15da:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    15de:	7e aa                	jle    158a <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    15e0:	8b 45 08             	mov    0x8(%ebp),%eax
    15e3:	8b 00                	mov    (%eax),%eax
    15e5:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    15e8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    15ec:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    15f0:	7e 8f                	jle    1581 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    15f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    15f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15f9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    15fc:	0f 82 38 ff ff ff    	jb     153a <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    1602:	90                   	nop
    1603:	c9                   	leave  
    1604:	c3                   	ret    

00001605 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1605:	55                   	push   %ebp
    1606:	89 e5                	mov    %esp,%ebp
    1608:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    160b:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    160f:	0f 88 8e 01 00 00    	js     17a3 <APDcCopy+0x19e>
    1615:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1619:	0f 88 84 01 00 00    	js     17a3 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    161f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1622:	8b 45 20             	mov    0x20(%ebp),%eax
    1625:	01 d0                	add    %edx,%eax
    1627:	89 45 fc             	mov    %eax,-0x4(%ebp)
    162a:	8b 55 10             	mov    0x10(%ebp),%edx
    162d:	8b 45 24             	mov    0x24(%ebp),%eax
    1630:	01 d0                	add    %edx,%eax
    1632:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1635:	8b 55 18             	mov    0x18(%ebp),%edx
    1638:	8b 45 20             	mov    0x20(%ebp),%eax
    163b:	01 d0                	add    %edx,%eax
    163d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1640:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1643:	8b 45 24             	mov    0x24(%ebp),%eax
    1646:	01 d0                	add    %edx,%eax
    1648:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    164b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    164f:	0f 88 51 01 00 00    	js     17a6 <APDcCopy+0x1a1>
    1655:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1659:	0f 88 47 01 00 00    	js     17a6 <APDcCopy+0x1a1>
    165f:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1663:	0f 88 3d 01 00 00    	js     17a6 <APDcCopy+0x1a1>
    1669:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    166d:	0f 88 33 01 00 00    	js     17a6 <APDcCopy+0x1a1>
    1673:	8b 45 14             	mov    0x14(%ebp),%eax
    1676:	8b 00                	mov    (%eax),%eax
    1678:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    167b:	0f 8c 25 01 00 00    	jl     17a6 <APDcCopy+0x1a1>
    1681:	8b 45 14             	mov    0x14(%ebp),%eax
    1684:	8b 40 04             	mov    0x4(%eax),%eax
    1687:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    168a:	0f 8c 16 01 00 00    	jl     17a6 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1690:	8b 45 08             	mov    0x8(%ebp),%eax
    1693:	8b 00                	mov    (%eax),%eax
    1695:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1698:	7f 0b                	jg     16a5 <APDcCopy+0xa0>
    169a:	8b 45 08             	mov    0x8(%ebp),%eax
    169d:	8b 00                	mov    (%eax),%eax
    169f:	83 e8 01             	sub    $0x1,%eax
    16a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    16a5:	8b 45 08             	mov    0x8(%ebp),%eax
    16a8:	8b 40 04             	mov    0x4(%eax),%eax
    16ab:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16ae:	7f 0c                	jg     16bc <APDcCopy+0xb7>
    16b0:	8b 45 08             	mov    0x8(%ebp),%eax
    16b3:	8b 40 04             	mov    0x4(%eax),%eax
    16b6:	83 e8 01             	sub    $0x1,%eax
    16b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    16bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    16c3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    16ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16d1:	e9 bc 00 00 00       	jmp    1792 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    16d6:	8b 45 08             	mov    0x8(%ebp),%eax
    16d9:	8b 00                	mov    (%eax),%eax
    16db:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16de:	8b 55 10             	mov    0x10(%ebp),%edx
    16e1:	01 ca                	add    %ecx,%edx
    16e3:	0f af d0             	imul   %eax,%edx
    16e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e9:	01 d0                	add    %edx,%eax
    16eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    16ee:	8b 45 14             	mov    0x14(%ebp),%eax
    16f1:	8b 00                	mov    (%eax),%eax
    16f3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16f6:	8b 55 1c             	mov    0x1c(%ebp),%edx
    16f9:	01 ca                	add    %ecx,%edx
    16fb:	0f af d0             	imul   %eax,%edx
    16fe:	8b 45 18             	mov    0x18(%ebp),%eax
    1701:	01 d0                	add    %edx,%eax
    1703:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1706:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    170d:	eb 74                	jmp    1783 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    170f:	8b 45 14             	mov    0x14(%ebp),%eax
    1712:	8b 50 18             	mov    0x18(%eax),%edx
    1715:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1718:	8b 45 f0             	mov    -0x10(%ebp),%eax
    171b:	01 c8                	add    %ecx,%eax
    171d:	89 c1                	mov    %eax,%ecx
    171f:	89 c8                	mov    %ecx,%eax
    1721:	01 c0                	add    %eax,%eax
    1723:	01 c8                	add    %ecx,%eax
    1725:	01 d0                	add    %edx,%eax
    1727:	0f b7 10             	movzwl (%eax),%edx
    172a:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    172e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1732:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1735:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1739:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    173d:	38 c2                	cmp    %al,%dl
    173f:	75 18                	jne    1759 <APDcCopy+0x154>
    1741:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1745:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1749:	38 c2                	cmp    %al,%dl
    174b:	75 0c                	jne    1759 <APDcCopy+0x154>
    174d:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1751:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1755:	38 c2                	cmp    %al,%dl
    1757:	74 26                	je     177f <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1759:	8b 45 08             	mov    0x8(%ebp),%eax
    175c:	8b 50 18             	mov    0x18(%eax),%edx
    175f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1762:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1765:	01 c8                	add    %ecx,%eax
    1767:	89 c1                	mov    %eax,%ecx
    1769:	89 c8                	mov    %ecx,%eax
    176b:	01 c0                	add    %eax,%eax
    176d:	01 c8                	add    %ecx,%eax
    176f:	01 d0                	add    %edx,%eax
    1771:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1775:	66 89 10             	mov    %dx,(%eax)
    1778:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    177c:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    177f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1783:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1786:	2b 45 0c             	sub    0xc(%ebp),%eax
    1789:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    178c:	7d 81                	jge    170f <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    178e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1792:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1795:	2b 45 10             	sub    0x10(%ebp),%eax
    1798:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    179b:	0f 8d 35 ff ff ff    	jge    16d6 <APDcCopy+0xd1>
    17a1:	eb 04                	jmp    17a7 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    17a3:	90                   	nop
    17a4:	eb 01                	jmp    17a7 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    17a6:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    17a7:	c9                   	leave  
    17a8:	c3                   	ret    

000017a9 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    17a9:	55                   	push   %ebp
    17aa:	89 e5                	mov    %esp,%ebp
    17ac:	83 ec 1c             	sub    $0x1c,%esp
    17af:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    17b2:	8b 55 10             	mov    0x10(%ebp),%edx
    17b5:	8b 45 14             	mov    0x14(%ebp),%eax
    17b8:	88 4d ec             	mov    %cl,-0x14(%ebp)
    17bb:	88 55 e8             	mov    %dl,-0x18(%ebp)
    17be:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    17c1:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    17c5:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    17c8:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    17cc:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    17cf:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    17d3:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    17d6:	8b 45 08             	mov    0x8(%ebp),%eax
    17d9:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    17dd:	66 89 10             	mov    %dx,(%eax)
    17e0:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    17e4:	88 50 02             	mov    %dl,0x2(%eax)
}
    17e7:	8b 45 08             	mov    0x8(%ebp),%eax
    17ea:	c9                   	leave  
    17eb:	c2 04 00             	ret    $0x4

000017ee <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    17ee:	55                   	push   %ebp
    17ef:	89 e5                	mov    %esp,%ebp
    17f1:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    17f4:	8b 45 08             	mov    0x8(%ebp),%eax
    17f7:	8b 00                	mov    (%eax),%eax
    17f9:	83 ec 08             	sub    $0x8,%esp
    17fc:	8d 55 0c             	lea    0xc(%ebp),%edx
    17ff:	52                   	push   %edx
    1800:	50                   	push   %eax
    1801:	e8 24 ee ff ff       	call   62a <sendMessage>
    1806:	83 c4 10             	add    $0x10,%esp
}
    1809:	90                   	nop
    180a:	c9                   	leave  
    180b:	c3                   	ret    

0000180c <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    180c:	55                   	push   %ebp
    180d:	89 e5                	mov    %esp,%ebp
    180f:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1812:	83 ec 0c             	sub    $0xc,%esp
    1815:	68 98 00 00 00       	push   $0x98
    181a:	e8 f5 f1 ff ff       	call   a14 <malloc>
    181f:	83 c4 10             	add    $0x10,%esp
    1822:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1825:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1829:	75 15                	jne    1840 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    182b:	83 ec 04             	sub    $0x4,%esp
    182e:	ff 75 08             	pushl  0x8(%ebp)
    1831:	68 a8 27 00 00       	push   $0x27a8
    1836:	6a 01                	push   $0x1
    1838:	e8 04 ef ff ff       	call   741 <printf>
    183d:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1840:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1843:	05 84 00 00 00       	add    $0x84,%eax
    1848:	83 ec 08             	sub    $0x8,%esp
    184b:	ff 75 08             	pushl  0x8(%ebp)
    184e:	50                   	push   %eax
    184f:	e8 fd ea ff ff       	call   351 <strcpy>
    1854:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1857:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185a:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1861:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1864:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    186b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186e:	8b 40 3c             	mov    0x3c(%eax),%eax
    1871:	89 c2                	mov    %eax,%edx
    1873:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1876:	8b 40 40             	mov    0x40(%eax),%eax
    1879:	0f af d0             	imul   %eax,%edx
    187c:	89 d0                	mov    %edx,%eax
    187e:	01 c0                	add    %eax,%eax
    1880:	01 d0                	add    %edx,%eax
    1882:	83 ec 0c             	sub    $0xc,%esp
    1885:	50                   	push   %eax
    1886:	e8 89 f1 ff ff       	call   a14 <malloc>
    188b:	83 c4 10             	add    $0x10,%esp
    188e:	89 c2                	mov    %eax,%edx
    1890:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1893:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    1896:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1899:	8b 40 54             	mov    0x54(%eax),%eax
    189c:	85 c0                	test   %eax,%eax
    189e:	75 15                	jne    18b5 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    18a0:	83 ec 04             	sub    $0x4,%esp
    18a3:	ff 75 08             	pushl  0x8(%ebp)
    18a6:	68 c8 27 00 00       	push   $0x27c8
    18ab:	6a 01                	push   $0x1
    18ad:	e8 8f ee ff ff       	call   741 <printf>
    18b2:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    18b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b8:	8b 40 3c             	mov    0x3c(%eax),%eax
    18bb:	89 c2                	mov    %eax,%edx
    18bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c0:	8b 40 40             	mov    0x40(%eax),%eax
    18c3:	0f af d0             	imul   %eax,%edx
    18c6:	89 d0                	mov    %edx,%eax
    18c8:	01 c0                	add    %eax,%eax
    18ca:	01 c2                	add    %eax,%edx
    18cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cf:	8b 40 54             	mov    0x54(%eax),%eax
    18d2:	83 ec 04             	sub    $0x4,%esp
    18d5:	52                   	push   %edx
    18d6:	68 ff ff ff 00       	push   $0xffffff
    18db:	50                   	push   %eax
    18dc:	e8 06 eb ff ff       	call   3e7 <memset>
    18e1:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    18e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e7:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    18ee:	e8 0f ed ff ff       	call   602 <getpid>
    18f3:	89 c2                	mov    %eax,%edx
    18f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f8:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    18fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fe:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1905:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1908:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    190f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1912:	8b 40 58             	mov    0x58(%eax),%eax
    1915:	89 c2                	mov    %eax,%edx
    1917:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191a:	8b 40 5c             	mov    0x5c(%eax),%eax
    191d:	0f af d0             	imul   %eax,%edx
    1920:	89 d0                	mov    %edx,%eax
    1922:	01 c0                	add    %eax,%eax
    1924:	01 d0                	add    %edx,%eax
    1926:	83 ec 0c             	sub    $0xc,%esp
    1929:	50                   	push   %eax
    192a:	e8 e5 f0 ff ff       	call   a14 <malloc>
    192f:	83 c4 10             	add    $0x10,%esp
    1932:	89 c2                	mov    %eax,%edx
    1934:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1937:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    193a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    193d:	8b 40 70             	mov    0x70(%eax),%eax
    1940:	85 c0                	test   %eax,%eax
    1942:	75 15                	jne    1959 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1944:	83 ec 04             	sub    $0x4,%esp
    1947:	ff 75 08             	pushl  0x8(%ebp)
    194a:	68 ec 27 00 00       	push   $0x27ec
    194f:	6a 01                	push   $0x1
    1951:	e8 eb ed ff ff       	call   741 <printf>
    1956:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1959:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195c:	8b 40 3c             	mov    0x3c(%eax),%eax
    195f:	89 c2                	mov    %eax,%edx
    1961:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1964:	8b 40 40             	mov    0x40(%eax),%eax
    1967:	0f af d0             	imul   %eax,%edx
    196a:	89 d0                	mov    %edx,%eax
    196c:	01 c0                	add    %eax,%eax
    196e:	01 c2                	add    %eax,%edx
    1970:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1973:	8b 40 54             	mov    0x54(%eax),%eax
    1976:	83 ec 04             	sub    $0x4,%esp
    1979:	52                   	push   %edx
    197a:	68 ff 00 00 00       	push   $0xff
    197f:	50                   	push   %eax
    1980:	e8 62 ea ff ff       	call   3e7 <memset>
    1985:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1988:	8b 45 f4             	mov    -0xc(%ebp),%eax
    198b:	8b 55 0c             	mov    0xc(%ebp),%edx
    198e:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1991:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1995:	74 49                	je     19e0 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1997:	8b 45 10             	mov    0x10(%ebp),%eax
    199a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    19a0:	83 ec 0c             	sub    $0xc,%esp
    19a3:	50                   	push   %eax
    19a4:	e8 6b f0 ff ff       	call   a14 <malloc>
    19a9:	83 c4 10             	add    $0x10,%esp
    19ac:	89 c2                	mov    %eax,%edx
    19ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b1:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    19b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b7:	8b 55 10             	mov    0x10(%ebp),%edx
    19ba:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    19bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    19c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ca:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    19d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    19db:	e9 8d 00 00 00       	jmp    1a6d <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    19e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e3:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    19ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ed:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    19f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f7:	8b 40 20             	mov    0x20(%eax),%eax
    19fa:	89 c2                	mov    %eax,%edx
    19fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ff:	8b 40 24             	mov    0x24(%eax),%eax
    1a02:	0f af d0             	imul   %eax,%edx
    1a05:	89 d0                	mov    %edx,%eax
    1a07:	01 c0                	add    %eax,%eax
    1a09:	01 d0                	add    %edx,%eax
    1a0b:	83 ec 0c             	sub    $0xc,%esp
    1a0e:	50                   	push   %eax
    1a0f:	e8 00 f0 ff ff       	call   a14 <malloc>
    1a14:	83 c4 10             	add    $0x10,%esp
    1a17:	89 c2                	mov    %eax,%edx
    1a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1c:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a22:	8b 40 38             	mov    0x38(%eax),%eax
    1a25:	85 c0                	test   %eax,%eax
    1a27:	75 15                	jne    1a3e <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1a29:	83 ec 04             	sub    $0x4,%esp
    1a2c:	ff 75 08             	pushl  0x8(%ebp)
    1a2f:	68 14 28 00 00       	push   $0x2814
    1a34:	6a 01                	push   $0x1
    1a36:	e8 06 ed ff ff       	call   741 <printf>
    1a3b:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a41:	8b 40 20             	mov    0x20(%eax),%eax
    1a44:	89 c2                	mov    %eax,%edx
    1a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a49:	8b 40 24             	mov    0x24(%eax),%eax
    1a4c:	0f af d0             	imul   %eax,%edx
    1a4f:	89 d0                	mov    %edx,%eax
    1a51:	01 c0                	add    %eax,%eax
    1a53:	01 c2                	add    %eax,%edx
    1a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a58:	8b 40 38             	mov    0x38(%eax),%eax
    1a5b:	83 ec 04             	sub    $0x4,%esp
    1a5e:	52                   	push   %edx
    1a5f:	68 ff ff ff 00       	push   $0xffffff
    1a64:	50                   	push   %eax
    1a65:	e8 7d e9 ff ff       	call   3e7 <memset>
    1a6a:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1a70:	c9                   	leave  
    1a71:	c3                   	ret    

00001a72 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1a72:	55                   	push   %ebp
    1a73:	89 e5                	mov    %esp,%ebp
    1a75:	57                   	push   %edi
    1a76:	56                   	push   %esi
    1a77:	53                   	push   %ebx
    1a78:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1a7b:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a7e:	83 f8 03             	cmp    $0x3,%eax
    1a81:	74 02                	je     1a85 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1a83:	eb 7c                	jmp    1b01 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1a85:	8b 45 08             	mov    0x8(%ebp),%eax
    1a88:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1a8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8e:	8b 48 18             	mov    0x18(%eax),%ecx
    1a91:	8b 45 08             	mov    0x8(%ebp),%eax
    1a94:	8b 50 5c             	mov    0x5c(%eax),%edx
    1a97:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9a:	8b 40 58             	mov    0x58(%eax),%eax
    1a9d:	8b 75 08             	mov    0x8(%ebp),%esi
    1aa0:	83 c6 58             	add    $0x58,%esi
    1aa3:	83 ec 04             	sub    $0x4,%esp
    1aa6:	53                   	push   %ebx
    1aa7:	51                   	push   %ecx
    1aa8:	6a 00                	push   $0x0
    1aaa:	52                   	push   %edx
    1aab:	50                   	push   %eax
    1aac:	6a 00                	push   $0x0
    1aae:	6a 00                	push   $0x0
    1ab0:	56                   	push   %esi
    1ab1:	6a 00                	push   $0x0
    1ab3:	6a 00                	push   $0x0
    1ab5:	ff 75 08             	pushl  0x8(%ebp)
    1ab8:	e8 65 eb ff ff       	call   622 <paintWindow>
    1abd:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1ac0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac3:	8b 70 1c             	mov    0x1c(%eax),%esi
    1ac6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac9:	8b 58 18             	mov    0x18(%eax),%ebx
    1acc:	8b 45 08             	mov    0x8(%ebp),%eax
    1acf:	8b 48 08             	mov    0x8(%eax),%ecx
    1ad2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad5:	8b 50 40             	mov    0x40(%eax),%edx
    1ad8:	8b 45 08             	mov    0x8(%ebp),%eax
    1adb:	8b 40 3c             	mov    0x3c(%eax),%eax
    1ade:	8b 7d 08             	mov    0x8(%ebp),%edi
    1ae1:	83 c7 3c             	add    $0x3c,%edi
    1ae4:	83 ec 04             	sub    $0x4,%esp
    1ae7:	56                   	push   %esi
    1ae8:	53                   	push   %ebx
    1ae9:	51                   	push   %ecx
    1aea:	52                   	push   %edx
    1aeb:	50                   	push   %eax
    1aec:	6a 00                	push   $0x0
    1aee:	6a 00                	push   $0x0
    1af0:	57                   	push   %edi
    1af1:	6a 32                	push   $0x32
    1af3:	6a 00                	push   $0x0
    1af5:	ff 75 08             	pushl  0x8(%ebp)
    1af8:	e8 25 eb ff ff       	call   622 <paintWindow>
    1afd:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1b00:	90                   	nop
        default: break;
            
            
    }
    return False;
    1b01:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b06:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b09:	5b                   	pop    %ebx
    1b0a:	5e                   	pop    %esi
    1b0b:	5f                   	pop    %edi
    1b0c:	5d                   	pop    %ebp
    1b0d:	c3                   	ret    

00001b0e <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1b0e:	55                   	push   %ebp
    1b0f:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1b11:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b14:	8b 50 08             	mov    0x8(%eax),%edx
    1b17:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1a:	8b 00                	mov    (%eax),%eax
    1b1c:	39 c2                	cmp    %eax,%edx
    1b1e:	74 07                	je     1b27 <APPreJudge+0x19>
        return False;
    1b20:	b8 00 00 00 00       	mov    $0x0,%eax
    1b25:	eb 05                	jmp    1b2c <APPreJudge+0x1e>
    return True;
    1b27:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1b2c:	5d                   	pop    %ebp
    1b2d:	c3                   	ret    

00001b2e <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1b2e:	55                   	push   %ebp
    1b2f:	89 e5                	mov    %esp,%ebp
    1b31:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1b34:	8b 45 08             	mov    0x8(%ebp),%eax
    1b37:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b3a:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1b40:	83 ec 0c             	sub    $0xc,%esp
    1b43:	ff 75 08             	pushl  0x8(%ebp)
    1b46:	e8 ef ea ff ff       	call   63a <registWindow>
    1b4b:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1b4e:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1b55:	8b 45 08             	mov    0x8(%ebp),%eax
    1b58:	8b 00                	mov    (%eax),%eax
    1b5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1b5d:	ff 75 f4             	pushl  -0xc(%ebp)
    1b60:	ff 75 f0             	pushl  -0x10(%ebp)
    1b63:	ff 75 ec             	pushl  -0x14(%ebp)
    1b66:	ff 75 08             	pushl  0x8(%ebp)
    1b69:	e8 80 fc ff ff       	call   17ee <APSendMessage>
    1b6e:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1b71:	83 ec 0c             	sub    $0xc,%esp
    1b74:	ff 75 08             	pushl  0x8(%ebp)
    1b77:	e8 b6 ea ff ff       	call   632 <getMessage>
    1b7c:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1b7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b82:	83 c0 74             	add    $0x74,%eax
    1b85:	83 ec 08             	sub    $0x8,%esp
    1b88:	50                   	push   %eax
    1b89:	ff 75 08             	pushl  0x8(%ebp)
    1b8c:	e8 7d ff ff ff       	call   1b0e <APPreJudge>
    1b91:	83 c4 10             	add    $0x10,%esp
    1b94:	84 c0                	test   %al,%al
    1b96:	74 1b                	je     1bb3 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1b98:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9b:	ff 70 7c             	pushl  0x7c(%eax)
    1b9e:	ff 70 78             	pushl  0x78(%eax)
    1ba1:	ff 70 74             	pushl  0x74(%eax)
    1ba4:	ff 75 08             	pushl  0x8(%ebp)
    1ba7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1baa:	ff d0                	call   *%eax
    1bac:	83 c4 10             	add    $0x10,%esp
    1baf:	84 c0                	test   %al,%al
    1bb1:	75 0c                	jne    1bbf <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1bb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1bbd:	eb b2                	jmp    1b71 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1bbf:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1bc0:	90                   	nop
    1bc1:	c9                   	leave  
    1bc2:	c3                   	ret    

00001bc3 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1bc3:	55                   	push   %ebp
    1bc4:	89 e5                	mov    %esp,%ebp
    1bc6:	57                   	push   %edi
    1bc7:	56                   	push   %esi
    1bc8:	53                   	push   %ebx
    1bc9:	83 ec 7c             	sub    $0x7c,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1bcc:	8d 45 88             	lea    -0x78(%ebp),%eax
    1bcf:	6a 08                	push   $0x8
    1bd1:	6a 08                	push   $0x8
    1bd3:	6a 08                	push   $0x8
    1bd5:	50                   	push   %eax
    1bd6:	e8 ce fb ff ff       	call   17a9 <RGB>
    1bdb:	83 c4 0c             	add    $0xc,%esp
    1bde:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1be2:	66 89 45 bd          	mov    %ax,-0x43(%ebp)
    1be6:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1bea:	88 45 bf             	mov    %al,-0x41(%ebp)
    APSetFont(&wnd->TitleDc,font);
    1bed:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf0:	8d 58 58             	lea    0x58(%eax),%ebx
    1bf3:	8d 55 88             	lea    -0x78(%ebp),%edx
    1bf6:	83 ec 04             	sub    $0x4,%esp
    1bf9:	83 ec 04             	sub    $0x4,%esp
    1bfc:	89 e0                	mov    %esp,%eax
    1bfe:	0f b7 4d bd          	movzwl -0x43(%ebp),%ecx
    1c02:	66 89 08             	mov    %cx,(%eax)
    1c05:	0f b6 4d bf          	movzbl -0x41(%ebp),%ecx
    1c09:	88 48 02             	mov    %cl,0x2(%eax)
    1c0c:	53                   	push   %ebx
    1c0d:	52                   	push   %edx
    1c0e:	e8 fe f2 ff ff       	call   f11 <APSetFont>
    1c13:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    1c16:	8b 45 08             	mov    0x8(%ebp),%eax
    1c19:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    1c1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c22:	83 c0 58             	add    $0x58,%eax
    1c25:	6a 14                	push   $0x14
    1c27:	6a 14                	push   $0x14
    1c29:	52                   	push   %edx
    1c2a:	50                   	push   %eax
    1c2b:	e8 ce f8 ff ff       	call   14fe <APDrawText>
    1c30:	83 c4 10             	add    $0x10,%esp
    
    if (!iconReady)
    1c33:	a1 8c 6b 00 00       	mov    0x6b8c,%eax
    1c38:	85 c0                	test   %eax,%eax
    1c3a:	0f 85 7a 02 00 00    	jne    1eba <APGridPaint+0x2f7>
    {
        iconReady = 1;
    1c40:	c7 05 8c 6b 00 00 01 	movl   $0x1,0x6b8c
    1c47:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1c4a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c4d:	83 ec 08             	sub    $0x8,%esp
    1c50:	68 3b 28 00 00       	push   $0x283b
    1c55:	50                   	push   %eax
    1c56:	e8 6c ef ff ff       	call   bc7 <APLoadBitmap>
    1c5b:	83 c4 0c             	add    $0xc,%esp
    1c5e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c61:	a3 c0 6f 00 00       	mov    %eax,0x6fc0
    1c66:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c69:	a3 c4 6f 00 00       	mov    %eax,0x6fc4
    1c6e:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c71:	a3 c8 6f 00 00       	mov    %eax,0x6fc8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1c76:	83 ec 04             	sub    $0x4,%esp
    1c79:	ff 35 c8 6f 00 00    	pushl  0x6fc8
    1c7f:	ff 35 c4 6f 00 00    	pushl  0x6fc4
    1c85:	ff 35 c0 6f 00 00    	pushl  0x6fc0
    1c8b:	e8 71 f1 ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1c90:	83 c4 10             	add    $0x10,%esp
    1c93:	a3 cc 6f 00 00       	mov    %eax,0x6fcc
        grid_river = APLoadBitmap ("grid_river.bmp");
    1c98:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c9b:	83 ec 08             	sub    $0x8,%esp
    1c9e:	68 49 28 00 00       	push   $0x2849
    1ca3:	50                   	push   %eax
    1ca4:	e8 1e ef ff ff       	call   bc7 <APLoadBitmap>
    1ca9:	83 c4 0c             	add    $0xc,%esp
    1cac:	8b 45 88             	mov    -0x78(%ebp),%eax
    1caf:	a3 08 70 00 00       	mov    %eax,0x7008
    1cb4:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1cb7:	a3 0c 70 00 00       	mov    %eax,0x700c
    1cbc:	8b 45 90             	mov    -0x70(%ebp),%eax
    1cbf:	a3 10 70 00 00       	mov    %eax,0x7010
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1cc4:	83 ec 04             	sub    $0x4,%esp
    1cc7:	ff 35 10 70 00 00    	pushl  0x7010
    1ccd:	ff 35 0c 70 00 00    	pushl  0x700c
    1cd3:	ff 35 08 70 00 00    	pushl  0x7008
    1cd9:	e8 23 f1 ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1cde:	83 c4 10             	add    $0x10,%esp
    1ce1:	a3 f8 6f 00 00       	mov    %eax,0x6ff8
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1ce6:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ce9:	83 ec 08             	sub    $0x8,%esp
    1cec:	68 58 28 00 00       	push   $0x2858
    1cf1:	50                   	push   %eax
    1cf2:	e8 d0 ee ff ff       	call   bc7 <APLoadBitmap>
    1cf7:	83 c4 0c             	add    $0xc,%esp
    1cfa:	8b 45 88             	mov    -0x78(%ebp),%eax
    1cfd:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    1d02:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d05:	a3 00 70 00 00       	mov    %eax,0x7000
    1d0a:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d0d:	a3 04 70 00 00       	mov    %eax,0x7004
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1d12:	83 ec 04             	sub    $0x4,%esp
    1d15:	ff 35 04 70 00 00    	pushl  0x7004
    1d1b:	ff 35 00 70 00 00    	pushl  0x7000
    1d21:	ff 35 fc 6f 00 00    	pushl  0x6ffc
    1d27:	e8 d5 f0 ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1d2c:	83 c4 10             	add    $0x10,%esp
    1d2f:	a3 a0 6f 00 00       	mov    %eax,0x6fa0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1d34:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d37:	83 ec 08             	sub    $0x8,%esp
    1d3a:	68 67 28 00 00       	push   $0x2867
    1d3f:	50                   	push   %eax
    1d40:	e8 82 ee ff ff       	call   bc7 <APLoadBitmap>
    1d45:	83 c4 0c             	add    $0xc,%esp
    1d48:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d4b:	a3 d4 6f 00 00       	mov    %eax,0x6fd4
    1d50:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d53:	a3 d8 6f 00 00       	mov    %eax,0x6fd8
    1d58:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d5b:	a3 dc 6f 00 00       	mov    %eax,0x6fdc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1d60:	83 ec 04             	sub    $0x4,%esp
    1d63:	ff 35 dc 6f 00 00    	pushl  0x6fdc
    1d69:	ff 35 d8 6f 00 00    	pushl  0x6fd8
    1d6f:	ff 35 d4 6f 00 00    	pushl  0x6fd4
    1d75:	e8 87 f0 ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1d7a:	83 c4 10             	add    $0x10,%esp
    1d7d:	a3 18 70 00 00       	mov    %eax,0x7018
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1d82:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d85:	83 ec 08             	sub    $0x8,%esp
    1d88:	68 75 28 00 00       	push   $0x2875
    1d8d:	50                   	push   %eax
    1d8e:	e8 34 ee ff ff       	call   bc7 <APLoadBitmap>
    1d93:	83 c4 0c             	add    $0xc,%esp
    1d96:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d99:	a3 b0 6f 00 00       	mov    %eax,0x6fb0
    1d9e:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1da1:	a3 b4 6f 00 00       	mov    %eax,0x6fb4
    1da6:	8b 45 90             	mov    -0x70(%ebp),%eax
    1da9:	a3 b8 6f 00 00       	mov    %eax,0x6fb8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1dae:	83 ec 04             	sub    $0x4,%esp
    1db1:	ff 35 b8 6f 00 00    	pushl  0x6fb8
    1db7:	ff 35 b4 6f 00 00    	pushl  0x6fb4
    1dbd:	ff 35 b0 6f 00 00    	pushl  0x6fb0
    1dc3:	e8 39 f0 ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1dc8:	83 c4 10             	add    $0x10,%esp
    1dcb:	a3 d0 6f 00 00       	mov    %eax,0x6fd0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1dd0:	8d 45 88             	lea    -0x78(%ebp),%eax
    1dd3:	83 ec 08             	sub    $0x8,%esp
    1dd6:	68 85 28 00 00       	push   $0x2885
    1ddb:	50                   	push   %eax
    1ddc:	e8 e6 ed ff ff       	call   bc7 <APLoadBitmap>
    1de1:	83 c4 0c             	add    $0xc,%esp
    1de4:	8b 45 88             	mov    -0x78(%ebp),%eax
    1de7:	a3 a4 6f 00 00       	mov    %eax,0x6fa4
    1dec:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1def:	a3 a8 6f 00 00       	mov    %eax,0x6fa8
    1df4:	8b 45 90             	mov    -0x70(%ebp),%eax
    1df7:	a3 ac 6f 00 00       	mov    %eax,0x6fac
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1dfc:	83 ec 04             	sub    $0x4,%esp
    1dff:	ff 35 ac 6f 00 00    	pushl  0x6fac
    1e05:	ff 35 a8 6f 00 00    	pushl  0x6fa8
    1e0b:	ff 35 a4 6f 00 00    	pushl  0x6fa4
    1e11:	e8 eb ef ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1e16:	83 c4 10             	add    $0x10,%esp
    1e19:	a3 bc 6f 00 00       	mov    %eax,0x6fbc
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1e1e:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e21:	83 ec 08             	sub    $0x8,%esp
    1e24:	68 97 28 00 00       	push   $0x2897
    1e29:	50                   	push   %eax
    1e2a:	e8 98 ed ff ff       	call   bc7 <APLoadBitmap>
    1e2f:	83 c4 0c             	add    $0xc,%esp
    1e32:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e35:	a3 ec 6f 00 00       	mov    %eax,0x6fec
    1e3a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1e3d:	a3 f0 6f 00 00       	mov    %eax,0x6ff0
    1e42:	8b 45 90             	mov    -0x70(%ebp),%eax
    1e45:	a3 f4 6f 00 00       	mov    %eax,0x6ff4
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1e4a:	83 ec 04             	sub    $0x4,%esp
    1e4d:	ff 35 f4 6f 00 00    	pushl  0x6ff4
    1e53:	ff 35 f0 6f 00 00    	pushl  0x6ff0
    1e59:	ff 35 ec 6f 00 00    	pushl  0x6fec
    1e5f:	e8 9d ef ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1e64:	83 c4 10             	add    $0x10,%esp
    1e67:	a3 1c 70 00 00       	mov    %eax,0x701c
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1e6c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e6f:	83 ec 08             	sub    $0x8,%esp
    1e72:	68 a6 28 00 00       	push   $0x28a6
    1e77:	50                   	push   %eax
    1e78:	e8 4a ed ff ff       	call   bc7 <APLoadBitmap>
    1e7d:	83 c4 0c             	add    $0xc,%esp
    1e80:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e83:	a3 e0 6f 00 00       	mov    %eax,0x6fe0
    1e88:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1e8b:	a3 e4 6f 00 00       	mov    %eax,0x6fe4
    1e90:	8b 45 90             	mov    -0x70(%ebp),%eax
    1e93:	a3 e8 6f 00 00       	mov    %eax,0x6fe8
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1e98:	83 ec 04             	sub    $0x4,%esp
    1e9b:	ff 35 e8 6f 00 00    	pushl  0x6fe8
    1ea1:	ff 35 e4 6f 00 00    	pushl  0x6fe4
    1ea7:	ff 35 e0 6f 00 00    	pushl  0x6fe0
    1ead:	e8 4f ef ff ff       	call   e01 <APCreateCompatibleDCFromBitmap>
    1eb2:	83 c4 10             	add    $0x10,%esp
    1eb5:	a3 14 70 00 00       	mov    %eax,0x7014
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1eba:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebd:	8b 40 08             	mov    0x8(%eax),%eax
    1ec0:	85 c0                	test   %eax,%eax
    1ec2:	75 17                	jne    1edb <APGridPaint+0x318>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1ec4:	83 ec 08             	sub    $0x8,%esp
    1ec7:	68 b8 28 00 00       	push   $0x28b8
    1ecc:	6a 01                	push   $0x1
    1ece:	e8 6e e8 ff ff       	call   741 <printf>
    1ed3:	83 c4 10             	add    $0x10,%esp
        return;
    1ed6:	e9 fe 04 00 00       	jmp    23d9 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1edb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ede:	8b 40 10             	mov    0x10(%eax),%eax
    1ee1:	85 c0                	test   %eax,%eax
    1ee3:	7e 10                	jle    1ef5 <APGridPaint+0x332>
    1ee5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee8:	8b 50 14             	mov    0x14(%eax),%edx
    1eeb:	8b 45 08             	mov    0x8(%ebp),%eax
    1eee:	8b 40 10             	mov    0x10(%eax),%eax
    1ef1:	39 c2                	cmp    %eax,%edx
    1ef3:	7c 17                	jl     1f0c <APGridPaint+0x349>
    {
        printf(1,"Grid mode page error!");
    1ef5:	83 ec 08             	sub    $0x8,%esp
    1ef8:	68 de 28 00 00       	push   $0x28de
    1efd:	6a 01                	push   $0x1
    1eff:	e8 3d e8 ff ff       	call   741 <printf>
    1f04:	83 c4 10             	add    $0x10,%esp
        return;
    1f07:	e9 cd 04 00 00       	jmp    23d9 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1f0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0f:	8b 40 14             	mov    0x14(%eax),%eax
    1f12:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1f18:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1f1b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1f1e:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f21:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1f28:	e9 f4 03 00 00       	jmp    2321 <APGridPaint+0x75e>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f2d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1f34:	e9 da 03 00 00       	jmp    2313 <APGridPaint+0x750>
        {
            index = start + GRID_W_NUMBER * j + i;
    1f39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f3c:	c1 e0 04             	shl    $0x4,%eax
    1f3f:	89 c2                	mov    %eax,%edx
    1f41:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1f44:	01 c2                	add    %eax,%edx
    1f46:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f49:	01 d0                	add    %edx,%eax
    1f4b:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1f4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f51:	8b 40 0c             	mov    0xc(%eax),%eax
    1f54:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1f57:	c1 e2 02             	shl    $0x2,%edx
    1f5a:	01 d0                	add    %edx,%eax
    1f5c:	8b 00                	mov    (%eax),%eax
    1f5e:	83 f8 0a             	cmp    $0xa,%eax
    1f61:	0f 87 a7 03 00 00    	ja     230e <APGridPaint+0x74b>
    1f67:	8b 04 85 f4 28 00 00 	mov    0x28f4(,%eax,4),%eax
    1f6e:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f70:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1f73:	6a 0c                	push   $0xc
    1f75:	6a 0c                	push   $0xc
    1f77:	6a 0c                	push   $0xc
    1f79:	50                   	push   %eax
    1f7a:	e8 2a f8 ff ff       	call   17a9 <RGB>
    1f7f:	83 c4 0c             	add    $0xc,%esp
    1f82:	8b 1d cc 6f 00 00    	mov    0x6fcc,%ebx
    1f88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f8b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f91:	6b c0 32             	imul   $0x32,%eax,%eax
    1f94:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1f97:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9a:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f9d:	83 ec 0c             	sub    $0xc,%esp
    1fa0:	83 ec 04             	sub    $0x4,%esp
    1fa3:	89 e0                	mov    %esp,%eax
    1fa5:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1fa9:	66 89 30             	mov    %si,(%eax)
    1fac:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1fb0:	88 50 02             	mov    %dl,0x2(%eax)
    1fb3:	6a 32                	push   $0x32
    1fb5:	6a 32                	push   $0x32
    1fb7:	6a 00                	push   $0x0
    1fb9:	6a 00                	push   $0x0
    1fbb:	53                   	push   %ebx
    1fbc:	51                   	push   %ecx
    1fbd:	ff 75 84             	pushl  -0x7c(%ebp)
    1fc0:	57                   	push   %edi
    1fc1:	e8 3f f6 ff ff       	call   1605 <APDcCopy>
    1fc6:	83 c4 30             	add    $0x30,%esp
                    break;
    1fc9:	e9 41 03 00 00       	jmp    230f <APGridPaint+0x74c>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1fce:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fd1:	6a 69                	push   $0x69
    1fd3:	6a 69                	push   $0x69
    1fd5:	6a 69                	push   $0x69
    1fd7:	50                   	push   %eax
    1fd8:	e8 cc f7 ff ff       	call   17a9 <RGB>
    1fdd:	83 c4 0c             	add    $0xc,%esp
    1fe0:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1fe4:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1fe8:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1fec:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1fef:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1ff6:	8d 45 88             	lea    -0x78(%ebp),%eax
    1ff9:	6a 69                	push   $0x69
    1ffb:	6a 69                	push   $0x69
    1ffd:	6a 69                	push   $0x69
    1fff:	50                   	push   %eax
    2000:	e8 a4 f7 ff ff       	call   17a9 <RGB>
    2005:	83 c4 0c             	add    $0xc,%esp
    2008:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    200c:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    2010:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2014:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2017:	8b 45 08             	mov    0x8(%ebp),%eax
    201a:	8d 50 3c             	lea    0x3c(%eax),%edx
    201d:	8d 45 88             	lea    -0x78(%ebp),%eax
    2020:	ff 75 ac             	pushl  -0x54(%ebp)
    2023:	ff 75 a8             	pushl  -0x58(%ebp)
    2026:	52                   	push   %edx
    2027:	50                   	push   %eax
    2028:	e8 69 ee ff ff       	call   e96 <APSetPen>
    202d:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    2030:	8b 45 08             	mov    0x8(%ebp),%eax
    2033:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2036:	8d 55 88             	lea    -0x78(%ebp),%edx
    2039:	83 ec 04             	sub    $0x4,%esp
    203c:	83 ec 04             	sub    $0x4,%esp
    203f:	89 e0                	mov    %esp,%eax
    2041:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    2045:	66 89 08             	mov    %cx,(%eax)
    2048:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    204c:	88 48 02             	mov    %cl,0x2(%eax)
    204f:	53                   	push   %ebx
    2050:	52                   	push   %edx
    2051:	e8 79 ee ff ff       	call   ecf <APSetBrush>
    2056:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2059:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    205c:	6b d0 32             	imul   $0x32,%eax,%edx
    205f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2062:	6b c0 32             	imul   $0x32,%eax,%eax
    2065:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2068:	83 c1 3c             	add    $0x3c,%ecx
    206b:	83 ec 0c             	sub    $0xc,%esp
    206e:	6a 32                	push   $0x32
    2070:	6a 32                	push   $0x32
    2072:	52                   	push   %edx
    2073:	50                   	push   %eax
    2074:	51                   	push   %ecx
    2075:	e8 7f f2 ff ff       	call   12f9 <APDrawRect>
    207a:	83 c4 20             	add    $0x20,%esp
                    break;
    207d:	e9 8d 02 00 00       	jmp    230f <APGridPaint+0x74c>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2082:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    2085:	6a 0c                	push   $0xc
    2087:	6a 0c                	push   $0xc
    2089:	6a 0c                	push   $0xc
    208b:	50                   	push   %eax
    208c:	e8 18 f7 ff ff       	call   17a9 <RGB>
    2091:	83 c4 0c             	add    $0xc,%esp
    2094:	8b 1d 1c 70 00 00    	mov    0x701c,%ebx
    209a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    209d:	6b c8 32             	imul   $0x32,%eax,%ecx
    20a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20a3:	6b c0 32             	imul   $0x32,%eax,%eax
    20a6:	89 45 84             	mov    %eax,-0x7c(%ebp)
    20a9:	8b 45 08             	mov    0x8(%ebp),%eax
    20ac:	8d 78 3c             	lea    0x3c(%eax),%edi
    20af:	83 ec 0c             	sub    $0xc,%esp
    20b2:	83 ec 04             	sub    $0x4,%esp
    20b5:	89 e0                	mov    %esp,%eax
    20b7:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    20bb:	66 89 30             	mov    %si,(%eax)
    20be:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    20c2:	88 50 02             	mov    %dl,0x2(%eax)
    20c5:	6a 32                	push   $0x32
    20c7:	6a 32                	push   $0x32
    20c9:	6a 00                	push   $0x0
    20cb:	6a 00                	push   $0x0
    20cd:	53                   	push   %ebx
    20ce:	51                   	push   %ecx
    20cf:	ff 75 84             	pushl  -0x7c(%ebp)
    20d2:	57                   	push   %edi
    20d3:	e8 2d f5 ff ff       	call   1605 <APDcCopy>
    20d8:	83 c4 30             	add    $0x30,%esp
                    break;
    20db:	e9 2f 02 00 00       	jmp    230f <APGridPaint+0x74c>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20e0:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    20e3:	6a 0c                	push   $0xc
    20e5:	6a 0c                	push   $0xc
    20e7:	6a 0c                	push   $0xc
    20e9:	50                   	push   %eax
    20ea:	e8 ba f6 ff ff       	call   17a9 <RGB>
    20ef:	83 c4 0c             	add    $0xc,%esp
    20f2:	8b 1d f8 6f 00 00    	mov    0x6ff8,%ebx
    20f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20fb:	6b c8 32             	imul   $0x32,%eax,%ecx
    20fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2101:	6b c0 32             	imul   $0x32,%eax,%eax
    2104:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2107:	8b 45 08             	mov    0x8(%ebp),%eax
    210a:	8d 78 3c             	lea    0x3c(%eax),%edi
    210d:	83 ec 0c             	sub    $0xc,%esp
    2110:	83 ec 04             	sub    $0x4,%esp
    2113:	89 e0                	mov    %esp,%eax
    2115:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2119:	66 89 30             	mov    %si,(%eax)
    211c:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2120:	88 50 02             	mov    %dl,0x2(%eax)
    2123:	6a 32                	push   $0x32
    2125:	6a 32                	push   $0x32
    2127:	6a 00                	push   $0x0
    2129:	6a 00                	push   $0x0
    212b:	53                   	push   %ebx
    212c:	51                   	push   %ecx
    212d:	ff 75 84             	pushl  -0x7c(%ebp)
    2130:	57                   	push   %edi
    2131:	e8 cf f4 ff ff       	call   1605 <APDcCopy>
    2136:	83 c4 30             	add    $0x30,%esp
                    break;
    2139:	e9 d1 01 00 00       	jmp    230f <APGridPaint+0x74c>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    213e:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2141:	6a 0c                	push   $0xc
    2143:	6a 0c                	push   $0xc
    2145:	6a 0c                	push   $0xc
    2147:	50                   	push   %eax
    2148:	e8 5c f6 ff ff       	call   17a9 <RGB>
    214d:	83 c4 0c             	add    $0xc,%esp
    2150:	8b 1d d0 6f 00 00    	mov    0x6fd0,%ebx
    2156:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2159:	6b c8 32             	imul   $0x32,%eax,%ecx
    215c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    215f:	6b c0 32             	imul   $0x32,%eax,%eax
    2162:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2165:	8b 45 08             	mov    0x8(%ebp),%eax
    2168:	8d 78 3c             	lea    0x3c(%eax),%edi
    216b:	83 ec 0c             	sub    $0xc,%esp
    216e:	83 ec 04             	sub    $0x4,%esp
    2171:	89 e0                	mov    %esp,%eax
    2173:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2177:	66 89 30             	mov    %si,(%eax)
    217a:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    217e:	88 50 02             	mov    %dl,0x2(%eax)
    2181:	6a 32                	push   $0x32
    2183:	6a 32                	push   $0x32
    2185:	6a 00                	push   $0x0
    2187:	6a 00                	push   $0x0
    2189:	53                   	push   %ebx
    218a:	51                   	push   %ecx
    218b:	ff 75 84             	pushl  -0x7c(%ebp)
    218e:	57                   	push   %edi
    218f:	e8 71 f4 ff ff       	call   1605 <APDcCopy>
    2194:	83 c4 30             	add    $0x30,%esp
                    break;
    2197:	e9 73 01 00 00       	jmp    230f <APGridPaint+0x74c>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    219c:	8d 45 cc             	lea    -0x34(%ebp),%eax
    219f:	6a 0c                	push   $0xc
    21a1:	6a 0c                	push   $0xc
    21a3:	6a 0c                	push   $0xc
    21a5:	50                   	push   %eax
    21a6:	e8 fe f5 ff ff       	call   17a9 <RGB>
    21ab:	83 c4 0c             	add    $0xc,%esp
    21ae:	8b 1d 18 70 00 00    	mov    0x7018,%ebx
    21b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21b7:	6b c8 32             	imul   $0x32,%eax,%ecx
    21ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21bd:	6b c0 32             	imul   $0x32,%eax,%eax
    21c0:	89 45 84             	mov    %eax,-0x7c(%ebp)
    21c3:	8b 45 08             	mov    0x8(%ebp),%eax
    21c6:	8d 78 3c             	lea    0x3c(%eax),%edi
    21c9:	83 ec 0c             	sub    $0xc,%esp
    21cc:	83 ec 04             	sub    $0x4,%esp
    21cf:	89 e0                	mov    %esp,%eax
    21d1:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    21d5:	66 89 30             	mov    %si,(%eax)
    21d8:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    21dc:	88 50 02             	mov    %dl,0x2(%eax)
    21df:	6a 32                	push   $0x32
    21e1:	6a 32                	push   $0x32
    21e3:	6a 00                	push   $0x0
    21e5:	6a 00                	push   $0x0
    21e7:	53                   	push   %ebx
    21e8:	51                   	push   %ecx
    21e9:	ff 75 84             	pushl  -0x7c(%ebp)
    21ec:	57                   	push   %edi
    21ed:	e8 13 f4 ff ff       	call   1605 <APDcCopy>
    21f2:	83 c4 30             	add    $0x30,%esp
                    break;
    21f5:	e9 15 01 00 00       	jmp    230f <APGridPaint+0x74c>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    21fa:	8d 45 cf             	lea    -0x31(%ebp),%eax
    21fd:	6a 0c                	push   $0xc
    21ff:	6a 0c                	push   $0xc
    2201:	6a 0c                	push   $0xc
    2203:	50                   	push   %eax
    2204:	e8 a0 f5 ff ff       	call   17a9 <RGB>
    2209:	83 c4 0c             	add    $0xc,%esp
    220c:	8b 1d a0 6f 00 00    	mov    0x6fa0,%ebx
    2212:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2215:	6b c8 32             	imul   $0x32,%eax,%ecx
    2218:	8b 45 e0             	mov    -0x20(%ebp),%eax
    221b:	6b c0 32             	imul   $0x32,%eax,%eax
    221e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2221:	8b 45 08             	mov    0x8(%ebp),%eax
    2224:	8d 78 3c             	lea    0x3c(%eax),%edi
    2227:	83 ec 0c             	sub    $0xc,%esp
    222a:	83 ec 04             	sub    $0x4,%esp
    222d:	89 e0                	mov    %esp,%eax
    222f:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    2233:	66 89 30             	mov    %si,(%eax)
    2236:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    223a:	88 50 02             	mov    %dl,0x2(%eax)
    223d:	6a 32                	push   $0x32
    223f:	6a 32                	push   $0x32
    2241:	6a 00                	push   $0x0
    2243:	6a 00                	push   $0x0
    2245:	53                   	push   %ebx
    2246:	51                   	push   %ecx
    2247:	ff 75 84             	pushl  -0x7c(%ebp)
    224a:	57                   	push   %edi
    224b:	e8 b5 f3 ff ff       	call   1605 <APDcCopy>
    2250:	83 c4 30             	add    $0x30,%esp
                    break;
    2253:	e9 b7 00 00 00       	jmp    230f <APGridPaint+0x74c>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2258:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    225b:	6a 0c                	push   $0xc
    225d:	6a 0c                	push   $0xc
    225f:	6a 0c                	push   $0xc
    2261:	50                   	push   %eax
    2262:	e8 42 f5 ff ff       	call   17a9 <RGB>
    2267:	83 c4 0c             	add    $0xc,%esp
    226a:	8b 1d bc 6f 00 00    	mov    0x6fbc,%ebx
    2270:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2273:	6b c8 32             	imul   $0x32,%eax,%ecx
    2276:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2279:	6b c0 32             	imul   $0x32,%eax,%eax
    227c:	89 45 84             	mov    %eax,-0x7c(%ebp)
    227f:	8b 45 08             	mov    0x8(%ebp),%eax
    2282:	8d 78 3c             	lea    0x3c(%eax),%edi
    2285:	83 ec 0c             	sub    $0xc,%esp
    2288:	83 ec 04             	sub    $0x4,%esp
    228b:	89 e0                	mov    %esp,%eax
    228d:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2291:	66 89 30             	mov    %si,(%eax)
    2294:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2298:	88 50 02             	mov    %dl,0x2(%eax)
    229b:	6a 32                	push   $0x32
    229d:	6a 32                	push   $0x32
    229f:	6a 00                	push   $0x0
    22a1:	6a 00                	push   $0x0
    22a3:	53                   	push   %ebx
    22a4:	51                   	push   %ecx
    22a5:	ff 75 84             	pushl  -0x7c(%ebp)
    22a8:	57                   	push   %edi
    22a9:	e8 57 f3 ff ff       	call   1605 <APDcCopy>
    22ae:	83 c4 30             	add    $0x30,%esp
                    break;
    22b1:	eb 5c                	jmp    230f <APGridPaint+0x74c>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    22b3:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    22b6:	6a 0c                	push   $0xc
    22b8:	6a 0c                	push   $0xc
    22ba:	6a 0c                	push   $0xc
    22bc:	50                   	push   %eax
    22bd:	e8 e7 f4 ff ff       	call   17a9 <RGB>
    22c2:	83 c4 0c             	add    $0xc,%esp
    22c5:	8b 1d 14 70 00 00    	mov    0x7014,%ebx
    22cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22ce:	6b c8 32             	imul   $0x32,%eax,%ecx
    22d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    22d4:	6b c0 32             	imul   $0x32,%eax,%eax
    22d7:	89 45 84             	mov    %eax,-0x7c(%ebp)
    22da:	8b 45 08             	mov    0x8(%ebp),%eax
    22dd:	8d 78 3c             	lea    0x3c(%eax),%edi
    22e0:	83 ec 0c             	sub    $0xc,%esp
    22e3:	83 ec 04             	sub    $0x4,%esp
    22e6:	89 e0                	mov    %esp,%eax
    22e8:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    22ec:	66 89 30             	mov    %si,(%eax)
    22ef:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    22f3:	88 50 02             	mov    %dl,0x2(%eax)
    22f6:	6a 32                	push   $0x32
    22f8:	6a 32                	push   $0x32
    22fa:	6a 00                	push   $0x0
    22fc:	6a 00                	push   $0x0
    22fe:	53                   	push   %ebx
    22ff:	51                   	push   %ecx
    2300:	ff 75 84             	pushl  -0x7c(%ebp)
    2303:	57                   	push   %edi
    2304:	e8 fc f2 ff ff       	call   1605 <APDcCopy>
    2309:	83 c4 30             	add    $0x30,%esp
                    break;
    230c:	eb 01                	jmp    230f <APGridPaint+0x74c>
                default: break;
    230e:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    230f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2313:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2317:	0f 8e 1c fc ff ff    	jle    1f39 <APGridPaint+0x376>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    231d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2321:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2325:	0f 8e 02 fc ff ff    	jle    1f2d <APGridPaint+0x36a>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    232b:	8d 45 88             	lea    -0x78(%ebp),%eax
    232e:	68 cd 00 00 00       	push   $0xcd
    2333:	6a 74                	push   $0x74
    2335:	6a 18                	push   $0x18
    2337:	50                   	push   %eax
    2338:	e8 6c f4 ff ff       	call   17a9 <RGB>
    233d:	83 c4 0c             	add    $0xc,%esp
    2340:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2344:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2348:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    234c:	88 45 b6             	mov    %al,-0x4a(%ebp)
    pen.size = 1;
    234f:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2356:	8d 45 88             	lea    -0x78(%ebp),%eax
    2359:	68 cd 00 00 00       	push   $0xcd
    235e:	6a 74                	push   $0x74
    2360:	6a 18                	push   $0x18
    2362:	50                   	push   %eax
    2363:	e8 41 f4 ff ff       	call   17a9 <RGB>
    2368:	83 c4 0c             	add    $0xc,%esp
    236b:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    236f:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    2373:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2377:	88 45 b3             	mov    %al,-0x4d(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    237a:	8b 45 08             	mov    0x8(%ebp),%eax
    237d:	8d 50 58             	lea    0x58(%eax),%edx
    2380:	8d 45 88             	lea    -0x78(%ebp),%eax
    2383:	ff 75 b8             	pushl  -0x48(%ebp)
    2386:	ff 75 b4             	pushl  -0x4c(%ebp)
    2389:	52                   	push   %edx
    238a:	50                   	push   %eax
    238b:	e8 06 eb ff ff       	call   e96 <APSetPen>
    2390:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2393:	8b 45 08             	mov    0x8(%ebp),%eax
    2396:	8d 58 58             	lea    0x58(%eax),%ebx
    2399:	8d 55 88             	lea    -0x78(%ebp),%edx
    239c:	83 ec 04             	sub    $0x4,%esp
    239f:	83 ec 04             	sub    $0x4,%esp
    23a2:	89 e0                	mov    %esp,%eax
    23a4:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    23a8:	66 89 08             	mov    %cx,(%eax)
    23ab:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    23af:	88 48 02             	mov    %cl,0x2(%eax)
    23b2:	53                   	push   %ebx
    23b3:	52                   	push   %edx
    23b4:	e8 16 eb ff ff       	call   ecf <APSetBrush>
    23b9:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    23bc:	8b 45 08             	mov    0x8(%ebp),%eax
    23bf:	83 c0 58             	add    $0x58,%eax
    23c2:	83 ec 0c             	sub    $0xc,%esp
    23c5:	6a 32                	push   $0x32
    23c7:	68 20 03 00 00       	push   $0x320
    23cc:	6a 00                	push   $0x0
    23ce:	6a 00                	push   $0x0
    23d0:	50                   	push   %eax
    23d1:	e8 23 ef ff ff       	call   12f9 <APDrawRect>
    23d6:	83 c4 20             	add    $0x20,%esp
    
    
}
    23d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    23dc:	5b                   	pop    %ebx
    23dd:	5e                   	pop    %esi
    23de:	5f                   	pop    %edi
    23df:	5d                   	pop    %ebp
    23e0:	c3                   	ret    

000023e1 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    23e1:	55                   	push   %ebp
    23e2:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    23e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    23e8:	7e 08                	jle    23f2 <random+0x11>
{
rand_num = seed;
    23ea:	8b 45 08             	mov    0x8(%ebp),%eax
    23ed:	a3 60 6b 00 00       	mov    %eax,0x6b60
}
rand_num *= 3;
    23f2:	8b 15 60 6b 00 00    	mov    0x6b60,%edx
    23f8:	89 d0                	mov    %edx,%eax
    23fa:	01 c0                	add    %eax,%eax
    23fc:	01 d0                	add    %edx,%eax
    23fe:	a3 60 6b 00 00       	mov    %eax,0x6b60
if (rand_num < 0)
    2403:	a1 60 6b 00 00       	mov    0x6b60,%eax
    2408:	85 c0                	test   %eax,%eax
    240a:	79 0c                	jns    2418 <random+0x37>
{
rand_num *= (-1);
    240c:	a1 60 6b 00 00       	mov    0x6b60,%eax
    2411:	f7 d8                	neg    %eax
    2413:	a3 60 6b 00 00       	mov    %eax,0x6b60
}
return rand_num % 997;
    2418:	8b 0d 60 6b 00 00    	mov    0x6b60,%ecx
    241e:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2423:	89 c8                	mov    %ecx,%eax
    2425:	f7 ea                	imul   %edx
    2427:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    242a:	c1 f8 09             	sar    $0x9,%eax
    242d:	89 c2                	mov    %eax,%edx
    242f:	89 c8                	mov    %ecx,%eax
    2431:	c1 f8 1f             	sar    $0x1f,%eax
    2434:	29 c2                	sub    %eax,%edx
    2436:	89 d0                	mov    %edx,%eax
    2438:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    243e:	29 c1                	sub    %eax,%ecx
    2440:	89 c8                	mov    %ecx,%eax
}
    2442:	5d                   	pop    %ebp
    2443:	c3                   	ret    

00002444 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    2444:	55                   	push   %ebp
    2445:	89 e5                	mov    %esp,%ebp
    2447:	53                   	push   %ebx
    2448:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    244b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2452:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2456:	74 17                	je     246f <sprintint+0x2b>
    2458:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    245c:	79 11                	jns    246f <sprintint+0x2b>
        neg = 1;
    245e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2465:	8b 45 10             	mov    0x10(%ebp),%eax
    2468:	f7 d8                	neg    %eax
    246a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    246d:	eb 06                	jmp    2475 <sprintint+0x31>
    } else {
        x = xx;
    246f:	8b 45 10             	mov    0x10(%ebp),%eax
    2472:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2475:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    247c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    247f:	8d 41 01             	lea    0x1(%ecx),%eax
    2482:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2485:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2488:	8b 45 f0             	mov    -0x10(%ebp),%eax
    248b:	ba 00 00 00 00       	mov    $0x0,%edx
    2490:	f7 f3                	div    %ebx
    2492:	89 d0                	mov    %edx,%eax
    2494:	0f b6 80 64 6b 00 00 	movzbl 0x6b64(%eax),%eax
    249b:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    249f:	8b 5d 14             	mov    0x14(%ebp),%ebx
    24a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24a5:	ba 00 00 00 00       	mov    $0x0,%edx
    24aa:	f7 f3                	div    %ebx
    24ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    24af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    24b3:	75 c7                	jne    247c <sprintint+0x38>
    if(neg)
    24b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24b9:	74 0e                	je     24c9 <sprintint+0x85>
        buf[i++] = '-';
    24bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    24be:	8d 50 01             	lea    0x1(%eax),%edx
    24c1:	89 55 f8             	mov    %edx,-0x8(%ebp)
    24c4:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    24c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    24cc:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    24cf:	eb 1b                	jmp    24ec <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    24d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    24d4:	8b 00                	mov    (%eax),%eax
    24d6:	8d 48 01             	lea    0x1(%eax),%ecx
    24d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    24dc:	89 0a                	mov    %ecx,(%edx)
    24de:	89 c2                	mov    %eax,%edx
    24e0:	8b 45 08             	mov    0x8(%ebp),%eax
    24e3:	01 d0                	add    %edx,%eax
    24e5:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    24e8:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    24ec:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    24f0:	7f df                	jg     24d1 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    24f2:	eb 21                	jmp    2515 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    24f4:	8b 45 0c             	mov    0xc(%ebp),%eax
    24f7:	8b 00                	mov    (%eax),%eax
    24f9:	8d 48 01             	lea    0x1(%eax),%ecx
    24fc:	8b 55 0c             	mov    0xc(%ebp),%edx
    24ff:	89 0a                	mov    %ecx,(%edx)
    2501:	89 c2                	mov    %eax,%edx
    2503:	8b 45 08             	mov    0x8(%ebp),%eax
    2506:	01 c2                	add    %eax,%edx
    2508:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    250b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    250e:	01 c8                	add    %ecx,%eax
    2510:	0f b6 00             	movzbl (%eax),%eax
    2513:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2515:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2519:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    251d:	79 d5                	jns    24f4 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    251f:	90                   	nop
    2520:	83 c4 20             	add    $0x20,%esp
    2523:	5b                   	pop    %ebx
    2524:	5d                   	pop    %ebp
    2525:	c3                   	ret    

00002526 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2526:	55                   	push   %ebp
    2527:	89 e5                	mov    %esp,%ebp
    2529:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    252c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2533:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    253a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2541:	8d 45 0c             	lea    0xc(%ebp),%eax
    2544:	83 c0 04             	add    $0x4,%eax
    2547:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    254a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2551:	e9 d9 01 00 00       	jmp    272f <sprintf+0x209>
        c = fmt[i] & 0xff;
    2556:	8b 55 0c             	mov    0xc(%ebp),%edx
    2559:	8b 45 ec             	mov    -0x14(%ebp),%eax
    255c:	01 d0                	add    %edx,%eax
    255e:	0f b6 00             	movzbl (%eax),%eax
    2561:	0f be c0             	movsbl %al,%eax
    2564:	25 ff 00 00 00       	and    $0xff,%eax
    2569:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    256c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2570:	75 2c                	jne    259e <sprintf+0x78>
            if(c == '%'){
    2572:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2576:	75 0c                	jne    2584 <sprintf+0x5e>
                state = '%';
    2578:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    257f:	e9 a7 01 00 00       	jmp    272b <sprintf+0x205>
            } else {
                dst[j++] = c;
    2584:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2587:	8d 50 01             	lea    0x1(%eax),%edx
    258a:	89 55 c8             	mov    %edx,-0x38(%ebp)
    258d:	89 c2                	mov    %eax,%edx
    258f:	8b 45 08             	mov    0x8(%ebp),%eax
    2592:	01 d0                	add    %edx,%eax
    2594:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2597:	88 10                	mov    %dl,(%eax)
    2599:	e9 8d 01 00 00       	jmp    272b <sprintf+0x205>
            }
        } else if(state == '%'){
    259e:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    25a2:	0f 85 83 01 00 00    	jne    272b <sprintf+0x205>
            if(c == 'd'){
    25a8:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    25ac:	75 4c                	jne    25fa <sprintf+0xd4>
                buf[bi] = '\0';
    25ae:	8d 55 ce             	lea    -0x32(%ebp),%edx
    25b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25b4:	01 d0                	add    %edx,%eax
    25b6:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    25b9:	83 ec 0c             	sub    $0xc,%esp
    25bc:	8d 45 ce             	lea    -0x32(%ebp),%eax
    25bf:	50                   	push   %eax
    25c0:	e8 2b df ff ff       	call   4f0 <atoi>
    25c5:	83 c4 10             	add    $0x10,%esp
    25c8:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    25cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    25d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25d5:	8b 00                	mov    (%eax),%eax
    25d7:	83 ec 08             	sub    $0x8,%esp
    25da:	ff 75 d8             	pushl  -0x28(%ebp)
    25dd:	6a 01                	push   $0x1
    25df:	6a 0a                	push   $0xa
    25e1:	50                   	push   %eax
    25e2:	8d 45 c8             	lea    -0x38(%ebp),%eax
    25e5:	50                   	push   %eax
    25e6:	ff 75 08             	pushl  0x8(%ebp)
    25e9:	e8 56 fe ff ff       	call   2444 <sprintint>
    25ee:	83 c4 20             	add    $0x20,%esp
                ap++;
    25f1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    25f5:	e9 2a 01 00 00       	jmp    2724 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    25fa:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    25fe:	74 06                	je     2606 <sprintf+0xe0>
    2600:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2604:	75 4c                	jne    2652 <sprintf+0x12c>
                buf[bi] = '\0';
    2606:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2609:	8b 45 f0             	mov    -0x10(%ebp),%eax
    260c:	01 d0                	add    %edx,%eax
    260e:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2611:	83 ec 0c             	sub    $0xc,%esp
    2614:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2617:	50                   	push   %eax
    2618:	e8 d3 de ff ff       	call   4f0 <atoi>
    261d:	83 c4 10             	add    $0x10,%esp
    2620:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2623:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    262a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    262d:	8b 00                	mov    (%eax),%eax
    262f:	83 ec 08             	sub    $0x8,%esp
    2632:	ff 75 dc             	pushl  -0x24(%ebp)
    2635:	6a 00                	push   $0x0
    2637:	6a 10                	push   $0x10
    2639:	50                   	push   %eax
    263a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    263d:	50                   	push   %eax
    263e:	ff 75 08             	pushl  0x8(%ebp)
    2641:	e8 fe fd ff ff       	call   2444 <sprintint>
    2646:	83 c4 20             	add    $0x20,%esp
                ap++;
    2649:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    264d:	e9 d2 00 00 00       	jmp    2724 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2652:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2656:	75 46                	jne    269e <sprintf+0x178>
                s = (char*)*ap;
    2658:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    265b:	8b 00                	mov    (%eax),%eax
    265d:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2660:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2664:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2668:	75 25                	jne    268f <sprintf+0x169>
                    s = "(null)";
    266a:	c7 45 f4 20 29 00 00 	movl   $0x2920,-0xc(%ebp)
                while(*s != 0){
    2671:	eb 1c                	jmp    268f <sprintf+0x169>
                    dst[j++] = *s;
    2673:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2676:	8d 50 01             	lea    0x1(%eax),%edx
    2679:	89 55 c8             	mov    %edx,-0x38(%ebp)
    267c:	89 c2                	mov    %eax,%edx
    267e:	8b 45 08             	mov    0x8(%ebp),%eax
    2681:	01 c2                	add    %eax,%edx
    2683:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2686:	0f b6 00             	movzbl (%eax),%eax
    2689:	88 02                	mov    %al,(%edx)
                    s++;
    268b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    268f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2692:	0f b6 00             	movzbl (%eax),%eax
    2695:	84 c0                	test   %al,%al
    2697:	75 da                	jne    2673 <sprintf+0x14d>
    2699:	e9 86 00 00 00       	jmp    2724 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    269e:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    26a2:	75 1d                	jne    26c1 <sprintf+0x19b>
                dst[j++] = *ap;
    26a4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26a7:	8d 50 01             	lea    0x1(%eax),%edx
    26aa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    26ad:	89 c2                	mov    %eax,%edx
    26af:	8b 45 08             	mov    0x8(%ebp),%eax
    26b2:	01 c2                	add    %eax,%edx
    26b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26b7:	8b 00                	mov    (%eax),%eax
    26b9:	88 02                	mov    %al,(%edx)
                ap++;
    26bb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    26bf:	eb 63                	jmp    2724 <sprintf+0x1fe>
            } else if(c == '%'){
    26c1:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    26c5:	75 17                	jne    26de <sprintf+0x1b8>
                dst[j++] = c;
    26c7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26ca:	8d 50 01             	lea    0x1(%eax),%edx
    26cd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    26d0:	89 c2                	mov    %eax,%edx
    26d2:	8b 45 08             	mov    0x8(%ebp),%eax
    26d5:	01 d0                	add    %edx,%eax
    26d7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    26da:	88 10                	mov    %dl,(%eax)
    26dc:	eb 46                	jmp    2724 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    26de:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    26e2:	7e 18                	jle    26fc <sprintf+0x1d6>
    26e4:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    26e8:	7f 12                	jg     26fc <sprintf+0x1d6>
            {
                buf[bi++] = c;
    26ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    26ed:	8d 50 01             	lea    0x1(%eax),%edx
    26f0:	89 55 f0             	mov    %edx,-0x10(%ebp)
    26f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    26f6:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    26fa:	eb 2f                	jmp    272b <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    26fc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26ff:	8d 50 01             	lea    0x1(%eax),%edx
    2702:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2705:	89 c2                	mov    %eax,%edx
    2707:	8b 45 08             	mov    0x8(%ebp),%eax
    270a:	01 d0                	add    %edx,%eax
    270c:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    270f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2712:	8d 50 01             	lea    0x1(%eax),%edx
    2715:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2718:	89 c2                	mov    %eax,%edx
    271a:	8b 45 08             	mov    0x8(%ebp),%eax
    271d:	01 d0                	add    %edx,%eax
    271f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2722:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2724:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    272b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    272f:	8b 55 0c             	mov    0xc(%ebp),%edx
    2732:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2735:	01 d0                	add    %edx,%eax
    2737:	0f b6 00             	movzbl (%eax),%eax
    273a:	84 c0                	test   %al,%al
    273c:	0f 85 14 fe ff ff    	jne    2556 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2742:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2745:	8d 50 01             	lea    0x1(%eax),%edx
    2748:	89 55 c8             	mov    %edx,-0x38(%ebp)
    274b:	89 c2                	mov    %eax,%edx
    274d:	8b 45 08             	mov    0x8(%ebp),%eax
    2750:	01 d0                	add    %edx,%eax
    2752:	c6 00 00             	movb   $0x0,(%eax)
}
    2755:	90                   	nop
    2756:	c9                   	leave  
    2757:	c3                   	ret    
