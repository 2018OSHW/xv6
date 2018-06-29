
_ls：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       7:	83 ec 0c             	sub    $0xc,%esp
       a:	ff 75 08             	pushl  0x8(%ebp)
       d:	e8 c9 03 00 00       	call   3db <strlen>
      12:	83 c4 10             	add    $0x10,%esp
      15:	89 c2                	mov    %eax,%edx
      17:	8b 45 08             	mov    0x8(%ebp),%eax
      1a:	01 d0                	add    %edx,%eax
      1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      1f:	eb 04                	jmp    25 <fmtname+0x25>
      21:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
      25:	8b 45 f4             	mov    -0xc(%ebp),%eax
      28:	3b 45 08             	cmp    0x8(%ebp),%eax
      2b:	72 0a                	jb     37 <fmtname+0x37>
      2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      30:	0f b6 00             	movzbl (%eax),%eax
      33:	3c 2f                	cmp    $0x2f,%al
      35:	75 ea                	jne    21 <fmtname+0x21>
    ;
  p++;
      37:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      3b:	83 ec 0c             	sub    $0xc,%esp
      3e:	ff 75 f4             	pushl  -0xc(%ebp)
      41:	e8 95 03 00 00       	call   3db <strlen>
      46:	83 c4 10             	add    $0x10,%esp
      49:	83 f8 1d             	cmp    $0x1d,%eax
      4c:	76 05                	jbe    53 <fmtname+0x53>
    return p;
      4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
      51:	eb 60                	jmp    b3 <fmtname+0xb3>
  memmove(buf, p, strlen(p));
      53:	83 ec 0c             	sub    $0xc,%esp
      56:	ff 75 f4             	pushl  -0xc(%ebp)
      59:	e8 7d 03 00 00       	call   3db <strlen>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	83 ec 04             	sub    $0x4,%esp
      64:	50                   	push   %eax
      65:	ff 75 f4             	pushl  -0xc(%ebp)
      68:	68 98 6b 00 00       	push   $0x6b98
      6d:	e8 e6 04 00 00       	call   558 <memmove>
      72:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      75:	83 ec 0c             	sub    $0xc,%esp
      78:	ff 75 f4             	pushl  -0xc(%ebp)
      7b:	e8 5b 03 00 00       	call   3db <strlen>
      80:	83 c4 10             	add    $0x10,%esp
      83:	ba 1e 00 00 00       	mov    $0x1e,%edx
      88:	89 d3                	mov    %edx,%ebx
      8a:	29 c3                	sub    %eax,%ebx
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	ff 75 f4             	pushl  -0xc(%ebp)
      92:	e8 44 03 00 00       	call   3db <strlen>
      97:	83 c4 10             	add    $0x10,%esp
      9a:	05 98 6b 00 00       	add    $0x6b98,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 98 6b 00 00       	mov    $0x6b98,%eax
}
      b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      b6:	c9                   	leave  
      b7:	c3                   	ret    

000000b8 <ls>:

void
ls(char *path)
{
      b8:	55                   	push   %ebp
      b9:	89 e5                	mov    %esp,%ebp
      bb:	57                   	push   %edi
      bc:	56                   	push   %esi
      bd:	53                   	push   %ebx
      be:	81 ec 4c 02 00 00    	sub    $0x24c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
      c4:	83 ec 08             	sub    $0x8,%esp
      c7:	6a 00                	push   $0x0
      c9:	ff 75 08             	pushl  0x8(%ebp)
      cc:	e8 0c 05 00 00       	call   5dd <open>
      d1:	83 c4 10             	add    $0x10,%esp
      d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      db:	79 1a                	jns    f7 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
      dd:	83 ec 04             	sub    $0x4,%esp
      e0:	ff 75 08             	pushl  0x8(%ebp)
      e3:	68 74 27 00 00       	push   $0x2774
      e8:	6a 02                	push   $0x2
      ea:	e8 6d 06 00 00       	call   75c <printf>
      ef:	83 c4 10             	add    $0x10,%esp
    return;
      f2:	e9 e3 01 00 00       	jmp    2da <ls+0x222>
  }
  
  if(fstat(fd, &st) < 0){
      f7:	83 ec 08             	sub    $0x8,%esp
      fa:	8d 85 ac fd ff ff    	lea    -0x254(%ebp),%eax
     100:	50                   	push   %eax
     101:	ff 75 e4             	pushl  -0x1c(%ebp)
     104:	e8 ec 04 00 00       	call   5f5 <fstat>
     109:	83 c4 10             	add    $0x10,%esp
     10c:	85 c0                	test   %eax,%eax
     10e:	79 28                	jns    138 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
     110:	83 ec 04             	sub    $0x4,%esp
     113:	ff 75 08             	pushl  0x8(%ebp)
     116:	68 88 27 00 00       	push   $0x2788
     11b:	6a 02                	push   $0x2
     11d:	e8 3a 06 00 00       	call   75c <printf>
     122:	83 c4 10             	add    $0x10,%esp
    close(fd);
     125:	83 ec 0c             	sub    $0xc,%esp
     128:	ff 75 e4             	pushl  -0x1c(%ebp)
     12b:	e8 95 04 00 00       	call   5c5 <close>
     130:	83 c4 10             	add    $0x10,%esp
    return;
     133:	e9 a2 01 00 00       	jmp    2da <ls+0x222>
  }
  
  switch(st.type){
     138:	0f b7 85 ac fd ff ff 	movzwl -0x254(%ebp),%eax
     13f:	98                   	cwtl   
     140:	83 f8 01             	cmp    $0x1,%eax
     143:	74 48                	je     18d <ls+0xd5>
     145:	83 f8 02             	cmp    $0x2,%eax
     148:	0f 85 7e 01 00 00    	jne    2cc <ls+0x214>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
     14e:	8b bd bc fd ff ff    	mov    -0x244(%ebp),%edi
     154:	8b b5 b4 fd ff ff    	mov    -0x24c(%ebp),%esi
     15a:	0f b7 85 ac fd ff ff 	movzwl -0x254(%ebp),%eax
     161:	0f bf d8             	movswl %ax,%ebx
     164:	83 ec 0c             	sub    $0xc,%esp
     167:	ff 75 08             	pushl  0x8(%ebp)
     16a:	e8 91 fe ff ff       	call   0 <fmtname>
     16f:	83 c4 10             	add    $0x10,%esp
     172:	83 ec 08             	sub    $0x8,%esp
     175:	57                   	push   %edi
     176:	56                   	push   %esi
     177:	53                   	push   %ebx
     178:	50                   	push   %eax
     179:	68 9c 27 00 00       	push   $0x279c
     17e:	6a 01                	push   $0x1
     180:	e8 d7 05 00 00       	call   75c <printf>
     185:	83 c4 20             	add    $0x20,%esp
    break;
     188:	e9 3f 01 00 00       	jmp    2cc <ls+0x214>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     18d:	83 ec 0c             	sub    $0xc,%esp
     190:	ff 75 08             	pushl  0x8(%ebp)
     193:	e8 43 02 00 00       	call   3db <strlen>
     198:	83 c4 10             	add    $0x10,%esp
     19b:	83 c0 20             	add    $0x20,%eax
     19e:	3d 00 02 00 00       	cmp    $0x200,%eax
     1a3:	76 17                	jbe    1bc <ls+0x104>
      printf(1, "ls: path too long\n");
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 a9 27 00 00       	push   $0x27a9
     1ad:	6a 01                	push   $0x1
     1af:	e8 a8 05 00 00       	call   75c <printf>
     1b4:	83 c4 10             	add    $0x10,%esp
      break;
     1b7:	e9 10 01 00 00       	jmp    2cc <ls+0x214>
    }
    strcpy(buf, path);
     1bc:	83 ec 08             	sub    $0x8,%esp
     1bf:	ff 75 08             	pushl  0x8(%ebp)
     1c2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1c8:	50                   	push   %eax
     1c9:	e8 9e 01 00 00       	call   36c <strcpy>
     1ce:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
     1d1:	83 ec 0c             	sub    $0xc,%esp
     1d4:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1da:	50                   	push   %eax
     1db:	e8 fb 01 00 00       	call   3db <strlen>
     1e0:	83 c4 10             	add    $0x10,%esp
     1e3:	89 c2                	mov    %eax,%edx
     1e5:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1eb:	01 d0                	add    %edx,%eax
     1ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
     1f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1f3:	8d 50 01             	lea    0x1(%eax),%edx
     1f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
     1f9:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     1fc:	e9 aa 00 00 00       	jmp    2ab <ls+0x1f3>
      if(de.inum == 0)
     201:	0f b7 85 c0 fd ff ff 	movzwl -0x240(%ebp),%eax
     208:	66 85 c0             	test   %ax,%ax
     20b:	75 05                	jne    212 <ls+0x15a>
        continue;
     20d:	e9 99 00 00 00       	jmp    2ab <ls+0x1f3>
      memmove(p, de.name, DIRSIZ);
     212:	83 ec 04             	sub    $0x4,%esp
     215:	6a 1e                	push   $0x1e
     217:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
     21d:	83 c0 02             	add    $0x2,%eax
     220:	50                   	push   %eax
     221:	ff 75 e0             	pushl  -0x20(%ebp)
     224:	e8 2f 03 00 00       	call   558 <memmove>
     229:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
     22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     22f:	83 c0 1e             	add    $0x1e,%eax
     232:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
     235:	83 ec 08             	sub    $0x8,%esp
     238:	8d 85 ac fd ff ff    	lea    -0x254(%ebp),%eax
     23e:	50                   	push   %eax
     23f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     245:	50                   	push   %eax
     246:	e8 73 02 00 00       	call   4be <stat>
     24b:	83 c4 10             	add    $0x10,%esp
     24e:	85 c0                	test   %eax,%eax
     250:	79 1b                	jns    26d <ls+0x1b5>
        printf(1, "ls: cannot stat %s\n", buf);
     252:	83 ec 04             	sub    $0x4,%esp
     255:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     25b:	50                   	push   %eax
     25c:	68 88 27 00 00       	push   $0x2788
     261:	6a 01                	push   $0x1
     263:	e8 f4 04 00 00       	call   75c <printf>
     268:	83 c4 10             	add    $0x10,%esp
        continue;
     26b:	eb 3e                	jmp    2ab <ls+0x1f3>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     26d:	8b bd bc fd ff ff    	mov    -0x244(%ebp),%edi
     273:	8b b5 b4 fd ff ff    	mov    -0x24c(%ebp),%esi
     279:	0f b7 85 ac fd ff ff 	movzwl -0x254(%ebp),%eax
     280:	0f bf d8             	movswl %ax,%ebx
     283:	83 ec 0c             	sub    $0xc,%esp
     286:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     28c:	50                   	push   %eax
     28d:	e8 6e fd ff ff       	call   0 <fmtname>
     292:	83 c4 10             	add    $0x10,%esp
     295:	83 ec 08             	sub    $0x8,%esp
     298:	57                   	push   %edi
     299:	56                   	push   %esi
     29a:	53                   	push   %ebx
     29b:	50                   	push   %eax
     29c:	68 9c 27 00 00       	push   $0x279c
     2a1:	6a 01                	push   $0x1
     2a3:	e8 b4 04 00 00       	call   75c <printf>
     2a8:	83 c4 20             	add    $0x20,%esp
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2ab:	83 ec 04             	sub    $0x4,%esp
     2ae:	6a 20                	push   $0x20
     2b0:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
     2b6:	50                   	push   %eax
     2b7:	ff 75 e4             	pushl  -0x1c(%ebp)
     2ba:	e8 f6 02 00 00       	call   5b5 <read>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	83 f8 20             	cmp    $0x20,%eax
     2c5:	0f 84 36 ff ff ff    	je     201 <ls+0x149>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
     2cb:	90                   	nop
  }
  close(fd);
     2cc:	83 ec 0c             	sub    $0xc,%esp
     2cf:	ff 75 e4             	pushl  -0x1c(%ebp)
     2d2:	e8 ee 02 00 00       	call   5c5 <close>
     2d7:	83 c4 10             	add    $0x10,%esp
}
     2da:	8d 65 f4             	lea    -0xc(%ebp),%esp
     2dd:	5b                   	pop    %ebx
     2de:	5e                   	pop    %esi
     2df:	5f                   	pop    %edi
     2e0:	5d                   	pop    %ebp
     2e1:	c3                   	ret    

000002e2 <main>:

int
main(int argc, char *argv[])
{
     2e2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2e6:	83 e4 f0             	and    $0xfffffff0,%esp
     2e9:	ff 71 fc             	pushl  -0x4(%ecx)
     2ec:	55                   	push   %ebp
     2ed:	89 e5                	mov    %esp,%ebp
     2ef:	53                   	push   %ebx
     2f0:	51                   	push   %ecx
     2f1:	83 ec 10             	sub    $0x10,%esp
     2f4:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
     2f6:	83 3b 01             	cmpl   $0x1,(%ebx)
     2f9:	7f 15                	jg     310 <main+0x2e>
    ls(".");
     2fb:	83 ec 0c             	sub    $0xc,%esp
     2fe:	68 bc 27 00 00       	push   $0x27bc
     303:	e8 b0 fd ff ff       	call   b8 <ls>
     308:	83 c4 10             	add    $0x10,%esp
    exit();
     30b:	e8 8d 02 00 00       	call   59d <exit>
  }
  for(i=1; i<argc; i++)
     310:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     317:	eb 21                	jmp    33a <main+0x58>
    ls(argv[i]);
     319:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     323:	8b 43 04             	mov    0x4(%ebx),%eax
     326:	01 d0                	add    %edx,%eax
     328:	8b 00                	mov    (%eax),%eax
     32a:	83 ec 0c             	sub    $0xc,%esp
     32d:	50                   	push   %eax
     32e:	e8 85 fd ff ff       	call   b8 <ls>
     333:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
     336:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     33a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33d:	3b 03                	cmp    (%ebx),%eax
     33f:	7c d8                	jl     319 <main+0x37>
    ls(argv[i]);
  exit();
     341:	e8 57 02 00 00       	call   59d <exit>

00000346 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     346:	55                   	push   %ebp
     347:	89 e5                	mov    %esp,%ebp
     349:	57                   	push   %edi
     34a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     34b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     34e:	8b 55 10             	mov    0x10(%ebp),%edx
     351:	8b 45 0c             	mov    0xc(%ebp),%eax
     354:	89 cb                	mov    %ecx,%ebx
     356:	89 df                	mov    %ebx,%edi
     358:	89 d1                	mov    %edx,%ecx
     35a:	fc                   	cld    
     35b:	f3 aa                	rep stos %al,%es:(%edi)
     35d:	89 ca                	mov    %ecx,%edx
     35f:	89 fb                	mov    %edi,%ebx
     361:	89 5d 08             	mov    %ebx,0x8(%ebp)
     364:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     367:	90                   	nop
     368:	5b                   	pop    %ebx
     369:	5f                   	pop    %edi
     36a:	5d                   	pop    %ebp
     36b:	c3                   	ret    

0000036c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     36c:	55                   	push   %ebp
     36d:	89 e5                	mov    %esp,%ebp
     36f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     372:	8b 45 08             	mov    0x8(%ebp),%eax
     375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     378:	90                   	nop
     379:	8b 45 08             	mov    0x8(%ebp),%eax
     37c:	8d 50 01             	lea    0x1(%eax),%edx
     37f:	89 55 08             	mov    %edx,0x8(%ebp)
     382:	8b 55 0c             	mov    0xc(%ebp),%edx
     385:	8d 4a 01             	lea    0x1(%edx),%ecx
     388:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     38b:	0f b6 12             	movzbl (%edx),%edx
     38e:	88 10                	mov    %dl,(%eax)
     390:	0f b6 00             	movzbl (%eax),%eax
     393:	84 c0                	test   %al,%al
     395:	75 e2                	jne    379 <strcpy+0xd>
    ;
  return os;
     397:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     39a:	c9                   	leave  
     39b:	c3                   	ret    

0000039c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     39f:	eb 08                	jmp    3a9 <strcmp+0xd>
    p++, q++;
     3a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3a5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     3a9:	8b 45 08             	mov    0x8(%ebp),%eax
     3ac:	0f b6 00             	movzbl (%eax),%eax
     3af:	84 c0                	test   %al,%al
     3b1:	74 10                	je     3c3 <strcmp+0x27>
     3b3:	8b 45 08             	mov    0x8(%ebp),%eax
     3b6:	0f b6 10             	movzbl (%eax),%edx
     3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3bc:	0f b6 00             	movzbl (%eax),%eax
     3bf:	38 c2                	cmp    %al,%dl
     3c1:	74 de                	je     3a1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     3c3:	8b 45 08             	mov    0x8(%ebp),%eax
     3c6:	0f b6 00             	movzbl (%eax),%eax
     3c9:	0f b6 d0             	movzbl %al,%edx
     3cc:	8b 45 0c             	mov    0xc(%ebp),%eax
     3cf:	0f b6 00             	movzbl (%eax),%eax
     3d2:	0f b6 c0             	movzbl %al,%eax
     3d5:	29 c2                	sub    %eax,%edx
     3d7:	89 d0                	mov    %edx,%eax
}
     3d9:	5d                   	pop    %ebp
     3da:	c3                   	ret    

000003db <strlen>:

uint
strlen(char *s)
{
     3db:	55                   	push   %ebp
     3dc:	89 e5                	mov    %esp,%ebp
     3de:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3e8:	eb 04                	jmp    3ee <strlen+0x13>
     3ea:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3f1:	8b 45 08             	mov    0x8(%ebp),%eax
     3f4:	01 d0                	add    %edx,%eax
     3f6:	0f b6 00             	movzbl (%eax),%eax
     3f9:	84 c0                	test   %al,%al
     3fb:	75 ed                	jne    3ea <strlen+0xf>
    ;
  return n;
     3fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     400:	c9                   	leave  
     401:	c3                   	ret    

00000402 <memset>:

void*
memset(void *dst, int c, uint n)
{
     402:	55                   	push   %ebp
     403:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     405:	8b 45 10             	mov    0x10(%ebp),%eax
     408:	50                   	push   %eax
     409:	ff 75 0c             	pushl  0xc(%ebp)
     40c:	ff 75 08             	pushl  0x8(%ebp)
     40f:	e8 32 ff ff ff       	call   346 <stosb>
     414:	83 c4 0c             	add    $0xc,%esp
  return dst;
     417:	8b 45 08             	mov    0x8(%ebp),%eax
}
     41a:	c9                   	leave  
     41b:	c3                   	ret    

0000041c <strchr>:

char*
strchr(const char *s, char c)
{
     41c:	55                   	push   %ebp
     41d:	89 e5                	mov    %esp,%ebp
     41f:	83 ec 04             	sub    $0x4,%esp
     422:	8b 45 0c             	mov    0xc(%ebp),%eax
     425:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     428:	eb 14                	jmp    43e <strchr+0x22>
    if(*s == c)
     42a:	8b 45 08             	mov    0x8(%ebp),%eax
     42d:	0f b6 00             	movzbl (%eax),%eax
     430:	3a 45 fc             	cmp    -0x4(%ebp),%al
     433:	75 05                	jne    43a <strchr+0x1e>
      return (char*)s;
     435:	8b 45 08             	mov    0x8(%ebp),%eax
     438:	eb 13                	jmp    44d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     43a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     43e:	8b 45 08             	mov    0x8(%ebp),%eax
     441:	0f b6 00             	movzbl (%eax),%eax
     444:	84 c0                	test   %al,%al
     446:	75 e2                	jne    42a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     448:	b8 00 00 00 00       	mov    $0x0,%eax
}
     44d:	c9                   	leave  
     44e:	c3                   	ret    

0000044f <gets>:

char*
gets(char *buf, int max)
{
     44f:	55                   	push   %ebp
     450:	89 e5                	mov    %esp,%ebp
     452:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     455:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     45c:	eb 42                	jmp    4a0 <gets+0x51>
    cc = read(0, &c, 1);
     45e:	83 ec 04             	sub    $0x4,%esp
     461:	6a 01                	push   $0x1
     463:	8d 45 ef             	lea    -0x11(%ebp),%eax
     466:	50                   	push   %eax
     467:	6a 00                	push   $0x0
     469:	e8 47 01 00 00       	call   5b5 <read>
     46e:	83 c4 10             	add    $0x10,%esp
     471:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     474:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     478:	7e 33                	jle    4ad <gets+0x5e>
      break;
    buf[i++] = c;
     47a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47d:	8d 50 01             	lea    0x1(%eax),%edx
     480:	89 55 f4             	mov    %edx,-0xc(%ebp)
     483:	89 c2                	mov    %eax,%edx
     485:	8b 45 08             	mov    0x8(%ebp),%eax
     488:	01 c2                	add    %eax,%edx
     48a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     48e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     490:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     494:	3c 0a                	cmp    $0xa,%al
     496:	74 16                	je     4ae <gets+0x5f>
     498:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     49c:	3c 0d                	cmp    $0xd,%al
     49e:	74 0e                	je     4ae <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     4a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a3:	83 c0 01             	add    $0x1,%eax
     4a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
     4a9:	7c b3                	jl     45e <gets+0xf>
     4ab:	eb 01                	jmp    4ae <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     4ad:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     4ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4b1:	8b 45 08             	mov    0x8(%ebp),%eax
     4b4:	01 d0                	add    %edx,%eax
     4b6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     4b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4bc:	c9                   	leave  
     4bd:	c3                   	ret    

000004be <stat>:

int
stat(char *n, struct stat *st)
{
     4be:	55                   	push   %ebp
     4bf:	89 e5                	mov    %esp,%ebp
     4c1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	6a 00                	push   $0x0
     4c9:	ff 75 08             	pushl  0x8(%ebp)
     4cc:	e8 0c 01 00 00       	call   5dd <open>
     4d1:	83 c4 10             	add    $0x10,%esp
     4d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     4d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4db:	79 07                	jns    4e4 <stat+0x26>
    return -1;
     4dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4e2:	eb 25                	jmp    509 <stat+0x4b>
  r = fstat(fd, st);
     4e4:	83 ec 08             	sub    $0x8,%esp
     4e7:	ff 75 0c             	pushl  0xc(%ebp)
     4ea:	ff 75 f4             	pushl  -0xc(%ebp)
     4ed:	e8 03 01 00 00       	call   5f5 <fstat>
     4f2:	83 c4 10             	add    $0x10,%esp
     4f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     4f8:	83 ec 0c             	sub    $0xc,%esp
     4fb:	ff 75 f4             	pushl  -0xc(%ebp)
     4fe:	e8 c2 00 00 00       	call   5c5 <close>
     503:	83 c4 10             	add    $0x10,%esp
  return r;
     506:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     509:	c9                   	leave  
     50a:	c3                   	ret    

0000050b <atoi>:

int
atoi(const char *s)
{
     50b:	55                   	push   %ebp
     50c:	89 e5                	mov    %esp,%ebp
     50e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     511:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     518:	eb 25                	jmp    53f <atoi+0x34>
    n = n*10 + *s++ - '0';
     51a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     51d:	89 d0                	mov    %edx,%eax
     51f:	c1 e0 02             	shl    $0x2,%eax
     522:	01 d0                	add    %edx,%eax
     524:	01 c0                	add    %eax,%eax
     526:	89 c1                	mov    %eax,%ecx
     528:	8b 45 08             	mov    0x8(%ebp),%eax
     52b:	8d 50 01             	lea    0x1(%eax),%edx
     52e:	89 55 08             	mov    %edx,0x8(%ebp)
     531:	0f b6 00             	movzbl (%eax),%eax
     534:	0f be c0             	movsbl %al,%eax
     537:	01 c8                	add    %ecx,%eax
     539:	83 e8 30             	sub    $0x30,%eax
     53c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     53f:	8b 45 08             	mov    0x8(%ebp),%eax
     542:	0f b6 00             	movzbl (%eax),%eax
     545:	3c 2f                	cmp    $0x2f,%al
     547:	7e 0a                	jle    553 <atoi+0x48>
     549:	8b 45 08             	mov    0x8(%ebp),%eax
     54c:	0f b6 00             	movzbl (%eax),%eax
     54f:	3c 39                	cmp    $0x39,%al
     551:	7e c7                	jle    51a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     553:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     556:	c9                   	leave  
     557:	c3                   	ret    

00000558 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     558:	55                   	push   %ebp
     559:	89 e5                	mov    %esp,%ebp
     55b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     55e:	8b 45 08             	mov    0x8(%ebp),%eax
     561:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     564:	8b 45 0c             	mov    0xc(%ebp),%eax
     567:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     56a:	eb 17                	jmp    583 <memmove+0x2b>
    *dst++ = *src++;
     56c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     56f:	8d 50 01             	lea    0x1(%eax),%edx
     572:	89 55 fc             	mov    %edx,-0x4(%ebp)
     575:	8b 55 f8             	mov    -0x8(%ebp),%edx
     578:	8d 4a 01             	lea    0x1(%edx),%ecx
     57b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     57e:	0f b6 12             	movzbl (%edx),%edx
     581:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     583:	8b 45 10             	mov    0x10(%ebp),%eax
     586:	8d 50 ff             	lea    -0x1(%eax),%edx
     589:	89 55 10             	mov    %edx,0x10(%ebp)
     58c:	85 c0                	test   %eax,%eax
     58e:	7f dc                	jg     56c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     590:	8b 45 08             	mov    0x8(%ebp),%eax
}
     593:	c9                   	leave  
     594:	c3                   	ret    

00000595 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     595:	b8 01 00 00 00       	mov    $0x1,%eax
     59a:	cd 40                	int    $0x40
     59c:	c3                   	ret    

0000059d <exit>:
SYSCALL(exit)
     59d:	b8 02 00 00 00       	mov    $0x2,%eax
     5a2:	cd 40                	int    $0x40
     5a4:	c3                   	ret    

000005a5 <wait>:
SYSCALL(wait)
     5a5:	b8 03 00 00 00       	mov    $0x3,%eax
     5aa:	cd 40                	int    $0x40
     5ac:	c3                   	ret    

000005ad <pipe>:
SYSCALL(pipe)
     5ad:	b8 04 00 00 00       	mov    $0x4,%eax
     5b2:	cd 40                	int    $0x40
     5b4:	c3                   	ret    

000005b5 <read>:
SYSCALL(read)
     5b5:	b8 05 00 00 00       	mov    $0x5,%eax
     5ba:	cd 40                	int    $0x40
     5bc:	c3                   	ret    

000005bd <write>:
SYSCALL(write)
     5bd:	b8 10 00 00 00       	mov    $0x10,%eax
     5c2:	cd 40                	int    $0x40
     5c4:	c3                   	ret    

000005c5 <close>:
SYSCALL(close)
     5c5:	b8 15 00 00 00       	mov    $0x15,%eax
     5ca:	cd 40                	int    $0x40
     5cc:	c3                   	ret    

000005cd <kill>:
SYSCALL(kill)
     5cd:	b8 06 00 00 00       	mov    $0x6,%eax
     5d2:	cd 40                	int    $0x40
     5d4:	c3                   	ret    

000005d5 <exec>:
SYSCALL(exec)
     5d5:	b8 07 00 00 00       	mov    $0x7,%eax
     5da:	cd 40                	int    $0x40
     5dc:	c3                   	ret    

000005dd <open>:
SYSCALL(open)
     5dd:	b8 0f 00 00 00       	mov    $0xf,%eax
     5e2:	cd 40                	int    $0x40
     5e4:	c3                   	ret    

000005e5 <mknod>:
SYSCALL(mknod)
     5e5:	b8 11 00 00 00       	mov    $0x11,%eax
     5ea:	cd 40                	int    $0x40
     5ec:	c3                   	ret    

000005ed <unlink>:
SYSCALL(unlink)
     5ed:	b8 12 00 00 00       	mov    $0x12,%eax
     5f2:	cd 40                	int    $0x40
     5f4:	c3                   	ret    

000005f5 <fstat>:
SYSCALL(fstat)
     5f5:	b8 08 00 00 00       	mov    $0x8,%eax
     5fa:	cd 40                	int    $0x40
     5fc:	c3                   	ret    

000005fd <link>:
SYSCALL(link)
     5fd:	b8 13 00 00 00       	mov    $0x13,%eax
     602:	cd 40                	int    $0x40
     604:	c3                   	ret    

00000605 <mkdir>:
SYSCALL(mkdir)
     605:	b8 14 00 00 00       	mov    $0x14,%eax
     60a:	cd 40                	int    $0x40
     60c:	c3                   	ret    

0000060d <chdir>:
SYSCALL(chdir)
     60d:	b8 09 00 00 00       	mov    $0x9,%eax
     612:	cd 40                	int    $0x40
     614:	c3                   	ret    

00000615 <dup>:
SYSCALL(dup)
     615:	b8 0a 00 00 00       	mov    $0xa,%eax
     61a:	cd 40                	int    $0x40
     61c:	c3                   	ret    

0000061d <getpid>:
SYSCALL(getpid)
     61d:	b8 0b 00 00 00       	mov    $0xb,%eax
     622:	cd 40                	int    $0x40
     624:	c3                   	ret    

00000625 <sbrk>:
SYSCALL(sbrk)
     625:	b8 0c 00 00 00       	mov    $0xc,%eax
     62a:	cd 40                	int    $0x40
     62c:	c3                   	ret    

0000062d <sleep>:
SYSCALL(sleep)
     62d:	b8 0d 00 00 00       	mov    $0xd,%eax
     632:	cd 40                	int    $0x40
     634:	c3                   	ret    

00000635 <uptime>:
SYSCALL(uptime)
     635:	b8 0e 00 00 00       	mov    $0xe,%eax
     63a:	cd 40                	int    $0x40
     63c:	c3                   	ret    

0000063d <paintWindow>:

SYSCALL(paintWindow)
     63d:	b8 16 00 00 00       	mov    $0x16,%eax
     642:	cd 40                	int    $0x40
     644:	c3                   	ret    

00000645 <sendMessage>:
SYSCALL(sendMessage)
     645:	b8 17 00 00 00       	mov    $0x17,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <getMessage>:
SYSCALL(getMessage)
     64d:	b8 19 00 00 00       	mov    $0x19,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <registWindow>:
SYSCALL(registWindow)
     655:	b8 18 00 00 00       	mov    $0x18,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <changePosition>:
SYSCALL(changePosition)
     65d:	b8 1a 00 00 00       	mov    $0x1a,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <setupTimer>:
SYSCALL(setupTimer)
     665:	b8 1b 00 00 00       	mov    $0x1b,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <deleteTimer>:
SYSCALL(deleteTimer)
     66d:	b8 1c 00 00 00       	mov    $0x1c,%eax
     672:	cd 40                	int    $0x40
     674:	c3                   	ret    

00000675 <getCurrentTime>:
SYSCALL(getCurrentTime)
     675:	b8 1d 00 00 00       	mov    $0x1d,%eax
     67a:	cd 40                	int    $0x40
     67c:	c3                   	ret    

0000067d <removeWindow>:
SYSCALL(removeWindow)
     67d:	b8 1e 00 00 00       	mov    $0x1e,%eax
     682:	cd 40                	int    $0x40
     684:	c3                   	ret    

00000685 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     685:	55                   	push   %ebp
     686:	89 e5                	mov    %esp,%ebp
     688:	83 ec 18             	sub    $0x18,%esp
     68b:	8b 45 0c             	mov    0xc(%ebp),%eax
     68e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     691:	83 ec 04             	sub    $0x4,%esp
     694:	6a 01                	push   $0x1
     696:	8d 45 f4             	lea    -0xc(%ebp),%eax
     699:	50                   	push   %eax
     69a:	ff 75 08             	pushl  0x8(%ebp)
     69d:	e8 1b ff ff ff       	call   5bd <write>
     6a2:	83 c4 10             	add    $0x10,%esp
}
     6a5:	90                   	nop
     6a6:	c9                   	leave  
     6a7:	c3                   	ret    

000006a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6a8:	55                   	push   %ebp
     6a9:	89 e5                	mov    %esp,%ebp
     6ab:	53                   	push   %ebx
     6ac:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6b6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6ba:	74 17                	je     6d3 <printint+0x2b>
     6bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6c0:	79 11                	jns    6d3 <printint+0x2b>
    neg = 1;
     6c2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6cc:	f7 d8                	neg    %eax
     6ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6d1:	eb 06                	jmp    6d9 <printint+0x31>
  } else {
    x = xx;
     6d3:	8b 45 0c             	mov    0xc(%ebp),%eax
     6d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6e0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6e3:	8d 41 01             	lea    0x1(%ecx),%eax
     6e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6e9:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6ef:	ba 00 00 00 00       	mov    $0x0,%edx
     6f4:	f7 f3                	div    %ebx
     6f6:	89 d0                	mov    %edx,%eax
     6f8:	0f b6 80 40 2f 00 00 	movzbl 0x2f40(%eax),%eax
     6ff:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     703:	8b 5d 10             	mov    0x10(%ebp),%ebx
     706:	8b 45 ec             	mov    -0x14(%ebp),%eax
     709:	ba 00 00 00 00       	mov    $0x0,%edx
     70e:	f7 f3                	div    %ebx
     710:	89 45 ec             	mov    %eax,-0x14(%ebp)
     713:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     717:	75 c7                	jne    6e0 <printint+0x38>
  if(neg)
     719:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     71d:	74 2d                	je     74c <printint+0xa4>
    buf[i++] = '-';
     71f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     722:	8d 50 01             	lea    0x1(%eax),%edx
     725:	89 55 f4             	mov    %edx,-0xc(%ebp)
     728:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     72d:	eb 1d                	jmp    74c <printint+0xa4>
    putc(fd, buf[i]);
     72f:	8d 55 dc             	lea    -0x24(%ebp),%edx
     732:	8b 45 f4             	mov    -0xc(%ebp),%eax
     735:	01 d0                	add    %edx,%eax
     737:	0f b6 00             	movzbl (%eax),%eax
     73a:	0f be c0             	movsbl %al,%eax
     73d:	83 ec 08             	sub    $0x8,%esp
     740:	50                   	push   %eax
     741:	ff 75 08             	pushl  0x8(%ebp)
     744:	e8 3c ff ff ff       	call   685 <putc>
     749:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     74c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     750:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     754:	79 d9                	jns    72f <printint+0x87>
    putc(fd, buf[i]);
}
     756:	90                   	nop
     757:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     75a:	c9                   	leave  
     75b:	c3                   	ret    

0000075c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     75c:	55                   	push   %ebp
     75d:	89 e5                	mov    %esp,%ebp
     75f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     762:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     769:	8d 45 0c             	lea    0xc(%ebp),%eax
     76c:	83 c0 04             	add    $0x4,%eax
     76f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     772:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     779:	e9 59 01 00 00       	jmp    8d7 <printf+0x17b>
    c = fmt[i] & 0xff;
     77e:	8b 55 0c             	mov    0xc(%ebp),%edx
     781:	8b 45 f0             	mov    -0x10(%ebp),%eax
     784:	01 d0                	add    %edx,%eax
     786:	0f b6 00             	movzbl (%eax),%eax
     789:	0f be c0             	movsbl %al,%eax
     78c:	25 ff 00 00 00       	and    $0xff,%eax
     791:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     794:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     798:	75 2c                	jne    7c6 <printf+0x6a>
      if(c == '%'){
     79a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     79e:	75 0c                	jne    7ac <printf+0x50>
        state = '%';
     7a0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7a7:	e9 27 01 00 00       	jmp    8d3 <printf+0x177>
      } else {
        putc(fd, c);
     7ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7af:	0f be c0             	movsbl %al,%eax
     7b2:	83 ec 08             	sub    $0x8,%esp
     7b5:	50                   	push   %eax
     7b6:	ff 75 08             	pushl  0x8(%ebp)
     7b9:	e8 c7 fe ff ff       	call   685 <putc>
     7be:	83 c4 10             	add    $0x10,%esp
     7c1:	e9 0d 01 00 00       	jmp    8d3 <printf+0x177>
      }
    } else if(state == '%'){
     7c6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7ca:	0f 85 03 01 00 00    	jne    8d3 <printf+0x177>
      if(c == 'd'){
     7d0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7d4:	75 1e                	jne    7f4 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7d9:	8b 00                	mov    (%eax),%eax
     7db:	6a 01                	push   $0x1
     7dd:	6a 0a                	push   $0xa
     7df:	50                   	push   %eax
     7e0:	ff 75 08             	pushl  0x8(%ebp)
     7e3:	e8 c0 fe ff ff       	call   6a8 <printint>
     7e8:	83 c4 10             	add    $0x10,%esp
        ap++;
     7eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7ef:	e9 d8 00 00 00       	jmp    8cc <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7f4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7f8:	74 06                	je     800 <printf+0xa4>
     7fa:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7fe:	75 1e                	jne    81e <printf+0xc2>
        printint(fd, *ap, 16, 0);
     800:	8b 45 e8             	mov    -0x18(%ebp),%eax
     803:	8b 00                	mov    (%eax),%eax
     805:	6a 00                	push   $0x0
     807:	6a 10                	push   $0x10
     809:	50                   	push   %eax
     80a:	ff 75 08             	pushl  0x8(%ebp)
     80d:	e8 96 fe ff ff       	call   6a8 <printint>
     812:	83 c4 10             	add    $0x10,%esp
        ap++;
     815:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     819:	e9 ae 00 00 00       	jmp    8cc <printf+0x170>
      } else if(c == 's'){
     81e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     822:	75 43                	jne    867 <printf+0x10b>
        s = (char*)*ap;
     824:	8b 45 e8             	mov    -0x18(%ebp),%eax
     827:	8b 00                	mov    (%eax),%eax
     829:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     82c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     830:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     834:	75 25                	jne    85b <printf+0xff>
          s = "(null)";
     836:	c7 45 f4 be 27 00 00 	movl   $0x27be,-0xc(%ebp)
        while(*s != 0){
     83d:	eb 1c                	jmp    85b <printf+0xff>
          putc(fd, *s);
     83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     842:	0f b6 00             	movzbl (%eax),%eax
     845:	0f be c0             	movsbl %al,%eax
     848:	83 ec 08             	sub    $0x8,%esp
     84b:	50                   	push   %eax
     84c:	ff 75 08             	pushl  0x8(%ebp)
     84f:	e8 31 fe ff ff       	call   685 <putc>
     854:	83 c4 10             	add    $0x10,%esp
          s++;
     857:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     85b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85e:	0f b6 00             	movzbl (%eax),%eax
     861:	84 c0                	test   %al,%al
     863:	75 da                	jne    83f <printf+0xe3>
     865:	eb 65                	jmp    8cc <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     867:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     86b:	75 1d                	jne    88a <printf+0x12e>
        putc(fd, *ap);
     86d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     870:	8b 00                	mov    (%eax),%eax
     872:	0f be c0             	movsbl %al,%eax
     875:	83 ec 08             	sub    $0x8,%esp
     878:	50                   	push   %eax
     879:	ff 75 08             	pushl  0x8(%ebp)
     87c:	e8 04 fe ff ff       	call   685 <putc>
     881:	83 c4 10             	add    $0x10,%esp
        ap++;
     884:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     888:	eb 42                	jmp    8cc <printf+0x170>
      } else if(c == '%'){
     88a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     88e:	75 17                	jne    8a7 <printf+0x14b>
        putc(fd, c);
     890:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     893:	0f be c0             	movsbl %al,%eax
     896:	83 ec 08             	sub    $0x8,%esp
     899:	50                   	push   %eax
     89a:	ff 75 08             	pushl  0x8(%ebp)
     89d:	e8 e3 fd ff ff       	call   685 <putc>
     8a2:	83 c4 10             	add    $0x10,%esp
     8a5:	eb 25                	jmp    8cc <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8a7:	83 ec 08             	sub    $0x8,%esp
     8aa:	6a 25                	push   $0x25
     8ac:	ff 75 08             	pushl  0x8(%ebp)
     8af:	e8 d1 fd ff ff       	call   685 <putc>
     8b4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8ba:	0f be c0             	movsbl %al,%eax
     8bd:	83 ec 08             	sub    $0x8,%esp
     8c0:	50                   	push   %eax
     8c1:	ff 75 08             	pushl  0x8(%ebp)
     8c4:	e8 bc fd ff ff       	call   685 <putc>
     8c9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8cc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8d3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8d7:	8b 55 0c             	mov    0xc(%ebp),%edx
     8da:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8dd:	01 d0                	add    %edx,%eax
     8df:	0f b6 00             	movzbl (%eax),%eax
     8e2:	84 c0                	test   %al,%al
     8e4:	0f 85 94 fe ff ff    	jne    77e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8ea:	90                   	nop
     8eb:	c9                   	leave  
     8ec:	c3                   	ret    

000008ed <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8ed:	55                   	push   %ebp
     8ee:	89 e5                	mov    %esp,%ebp
     8f0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8f3:	8b 45 08             	mov    0x8(%ebp),%eax
     8f6:	83 e8 08             	sub    $0x8,%eax
     8f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8fc:	a1 c0 6b 00 00       	mov    0x6bc0,%eax
     901:	89 45 fc             	mov    %eax,-0x4(%ebp)
     904:	eb 24                	jmp    92a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     906:	8b 45 fc             	mov    -0x4(%ebp),%eax
     909:	8b 00                	mov    (%eax),%eax
     90b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     90e:	77 12                	ja     922 <free+0x35>
     910:	8b 45 f8             	mov    -0x8(%ebp),%eax
     913:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     916:	77 24                	ja     93c <free+0x4f>
     918:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91b:	8b 00                	mov    (%eax),%eax
     91d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     920:	77 1a                	ja     93c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     922:	8b 45 fc             	mov    -0x4(%ebp),%eax
     925:	8b 00                	mov    (%eax),%eax
     927:	89 45 fc             	mov    %eax,-0x4(%ebp)
     92a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     930:	76 d4                	jbe    906 <free+0x19>
     932:	8b 45 fc             	mov    -0x4(%ebp),%eax
     935:	8b 00                	mov    (%eax),%eax
     937:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     93a:	76 ca                	jbe    906 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     93c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93f:	8b 40 04             	mov    0x4(%eax),%eax
     942:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     949:	8b 45 f8             	mov    -0x8(%ebp),%eax
     94c:	01 c2                	add    %eax,%edx
     94e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     951:	8b 00                	mov    (%eax),%eax
     953:	39 c2                	cmp    %eax,%edx
     955:	75 24                	jne    97b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     957:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95a:	8b 50 04             	mov    0x4(%eax),%edx
     95d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     960:	8b 00                	mov    (%eax),%eax
     962:	8b 40 04             	mov    0x4(%eax),%eax
     965:	01 c2                	add    %eax,%edx
     967:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     96d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     970:	8b 00                	mov    (%eax),%eax
     972:	8b 10                	mov    (%eax),%edx
     974:	8b 45 f8             	mov    -0x8(%ebp),%eax
     977:	89 10                	mov    %edx,(%eax)
     979:	eb 0a                	jmp    985 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     97b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97e:	8b 10                	mov    (%eax),%edx
     980:	8b 45 f8             	mov    -0x8(%ebp),%eax
     983:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     985:	8b 45 fc             	mov    -0x4(%ebp),%eax
     988:	8b 40 04             	mov    0x4(%eax),%eax
     98b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     992:	8b 45 fc             	mov    -0x4(%ebp),%eax
     995:	01 d0                	add    %edx,%eax
     997:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     99a:	75 20                	jne    9bc <free+0xcf>
    p->s.size += bp->s.size;
     99c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99f:	8b 50 04             	mov    0x4(%eax),%edx
     9a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a5:	8b 40 04             	mov    0x4(%eax),%eax
     9a8:	01 c2                	add    %eax,%edx
     9aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ad:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b3:	8b 10                	mov    (%eax),%edx
     9b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b8:	89 10                	mov    %edx,(%eax)
     9ba:	eb 08                	jmp    9c4 <free+0xd7>
  } else
    p->s.ptr = bp;
     9bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9bf:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9c2:	89 10                	mov    %edx,(%eax)
  freep = p;
     9c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c7:	a3 c0 6b 00 00       	mov    %eax,0x6bc0
}
     9cc:	90                   	nop
     9cd:	c9                   	leave  
     9ce:	c3                   	ret    

000009cf <morecore>:

static Header*
morecore(uint nu)
{
     9cf:	55                   	push   %ebp
     9d0:	89 e5                	mov    %esp,%ebp
     9d2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9d5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9dc:	77 07                	ja     9e5 <morecore+0x16>
    nu = 4096;
     9de:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9e5:	8b 45 08             	mov    0x8(%ebp),%eax
     9e8:	c1 e0 03             	shl    $0x3,%eax
     9eb:	83 ec 0c             	sub    $0xc,%esp
     9ee:	50                   	push   %eax
     9ef:	e8 31 fc ff ff       	call   625 <sbrk>
     9f4:	83 c4 10             	add    $0x10,%esp
     9f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9fa:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9fe:	75 07                	jne    a07 <morecore+0x38>
    return 0;
     a00:	b8 00 00 00 00       	mov    $0x0,%eax
     a05:	eb 26                	jmp    a2d <morecore+0x5e>
  hp = (Header*)p;
     a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a10:	8b 55 08             	mov    0x8(%ebp),%edx
     a13:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a16:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a19:	83 c0 08             	add    $0x8,%eax
     a1c:	83 ec 0c             	sub    $0xc,%esp
     a1f:	50                   	push   %eax
     a20:	e8 c8 fe ff ff       	call   8ed <free>
     a25:	83 c4 10             	add    $0x10,%esp
  return freep;
     a28:	a1 c0 6b 00 00       	mov    0x6bc0,%eax
}
     a2d:	c9                   	leave  
     a2e:	c3                   	ret    

00000a2f <malloc>:

void*
malloc(uint nbytes)
{
     a2f:	55                   	push   %ebp
     a30:	89 e5                	mov    %esp,%ebp
     a32:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a35:	8b 45 08             	mov    0x8(%ebp),%eax
     a38:	83 c0 07             	add    $0x7,%eax
     a3b:	c1 e8 03             	shr    $0x3,%eax
     a3e:	83 c0 01             	add    $0x1,%eax
     a41:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a44:	a1 c0 6b 00 00       	mov    0x6bc0,%eax
     a49:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a4c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a50:	75 23                	jne    a75 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a52:	c7 45 f0 b8 6b 00 00 	movl   $0x6bb8,-0x10(%ebp)
     a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a5c:	a3 c0 6b 00 00       	mov    %eax,0x6bc0
     a61:	a1 c0 6b 00 00       	mov    0x6bc0,%eax
     a66:	a3 b8 6b 00 00       	mov    %eax,0x6bb8
    base.s.size = 0;
     a6b:	c7 05 bc 6b 00 00 00 	movl   $0x0,0x6bbc
     a72:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a75:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a78:	8b 00                	mov    (%eax),%eax
     a7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a80:	8b 40 04             	mov    0x4(%eax),%eax
     a83:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a86:	72 4d                	jb     ad5 <malloc+0xa6>
      if(p->s.size == nunits)
     a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8b:	8b 40 04             	mov    0x4(%eax),%eax
     a8e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a91:	75 0c                	jne    a9f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a96:	8b 10                	mov    (%eax),%edx
     a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a9b:	89 10                	mov    %edx,(%eax)
     a9d:	eb 26                	jmp    ac5 <malloc+0x96>
      else {
        p->s.size -= nunits;
     a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa2:	8b 40 04             	mov    0x4(%eax),%eax
     aa5:	2b 45 ec             	sub    -0x14(%ebp),%eax
     aa8:	89 c2                	mov    %eax,%edx
     aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aad:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab3:	8b 40 04             	mov    0x4(%eax),%eax
     ab6:	c1 e0 03             	shl    $0x3,%eax
     ab9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abf:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ac2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac8:	a3 c0 6b 00 00       	mov    %eax,0x6bc0
      return (void*)(p + 1);
     acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad0:	83 c0 08             	add    $0x8,%eax
     ad3:	eb 3b                	jmp    b10 <malloc+0xe1>
    }
    if(p == freep)
     ad5:	a1 c0 6b 00 00       	mov    0x6bc0,%eax
     ada:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     add:	75 1e                	jne    afd <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     adf:	83 ec 0c             	sub    $0xc,%esp
     ae2:	ff 75 ec             	pushl  -0x14(%ebp)
     ae5:	e8 e5 fe ff ff       	call   9cf <morecore>
     aea:	83 c4 10             	add    $0x10,%esp
     aed:	89 45 f4             	mov    %eax,-0xc(%ebp)
     af0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     af4:	75 07                	jne    afd <malloc+0xce>
        return 0;
     af6:	b8 00 00 00 00       	mov    $0x0,%eax
     afb:	eb 13                	jmp    b10 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     afd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b00:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b06:	8b 00                	mov    (%eax),%eax
     b08:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     b0b:	e9 6d ff ff ff       	jmp    a7d <malloc+0x4e>
}
     b10:	c9                   	leave  
     b11:	c3                   	ret    

00000b12 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     b12:	55                   	push   %ebp
     b13:	89 e5                	mov    %esp,%ebp
     b15:	83 ec 1c             	sub    $0x1c,%esp
     b18:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b1b:	8b 55 10             	mov    0x10(%ebp),%edx
     b1e:	8b 45 14             	mov    0x14(%ebp),%eax
     b21:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b24:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b27:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b2a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b2e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b31:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b35:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b38:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b3c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b3f:	8b 45 08             	mov    0x8(%ebp),%eax
     b42:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b46:	66 89 10             	mov    %dx,(%eax)
     b49:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b4d:	88 50 02             	mov    %dl,0x2(%eax)
}
     b50:	8b 45 08             	mov    0x8(%ebp),%eax
     b53:	c9                   	leave  
     b54:	c2 04 00             	ret    $0x4

00000b57 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b57:	55                   	push   %ebp
     b58:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b5a:	8b 45 08             	mov    0x8(%ebp),%eax
     b5d:	2b 45 10             	sub    0x10(%ebp),%eax
     b60:	89 c2                	mov    %eax,%edx
     b62:	8b 45 08             	mov    0x8(%ebp),%eax
     b65:	2b 45 10             	sub    0x10(%ebp),%eax
     b68:	0f af d0             	imul   %eax,%edx
     b6b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b6e:	2b 45 14             	sub    0x14(%ebp),%eax
     b71:	89 c1                	mov    %eax,%ecx
     b73:	8b 45 0c             	mov    0xc(%ebp),%eax
     b76:	2b 45 14             	sub    0x14(%ebp),%eax
     b79:	0f af c1             	imul   %ecx,%eax
     b7c:	01 d0                	add    %edx,%eax
}
     b7e:	5d                   	pop    %ebp
     b7f:	c3                   	ret    

00000b80 <abs_int>:

static inline int abs_int(int x)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b83:	8b 45 08             	mov    0x8(%ebp),%eax
     b86:	99                   	cltd   
     b87:	89 d0                	mov    %edx,%eax
     b89:	33 45 08             	xor    0x8(%ebp),%eax
     b8c:	29 d0                	sub    %edx,%eax
}
     b8e:	5d                   	pop    %ebp
     b8f:	c3                   	ret    

00000b90 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b93:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b97:	79 07                	jns    ba0 <APGetIndex+0x10>
        return X_SMALLER;
     b99:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b9e:	eb 40                	jmp    be0 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     ba0:	8b 45 08             	mov    0x8(%ebp),%eax
     ba3:	8b 00                	mov    (%eax),%eax
     ba5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ba8:	7f 07                	jg     bb1 <APGetIndex+0x21>
        return X_BIGGER;
     baa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     baf:	eb 2f                	jmp    be0 <APGetIndex+0x50>
    if (y < 0)
     bb1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     bb5:	79 07                	jns    bbe <APGetIndex+0x2e>
        return Y_SMALLER;
     bb7:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     bbc:	eb 22                	jmp    be0 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     bbe:	8b 45 08             	mov    0x8(%ebp),%eax
     bc1:	8b 40 04             	mov    0x4(%eax),%eax
     bc4:	3b 45 10             	cmp    0x10(%ebp),%eax
     bc7:	7f 07                	jg     bd0 <APGetIndex+0x40>
        return Y_BIGGER;
     bc9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     bce:	eb 10                	jmp    be0 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     bd0:	8b 45 08             	mov    0x8(%ebp),%eax
     bd3:	8b 00                	mov    (%eax),%eax
     bd5:	0f af 45 10          	imul   0x10(%ebp),%eax
     bd9:	89 c2                	mov    %eax,%edx
     bdb:	8b 45 0c             	mov    0xc(%ebp),%eax
     bde:	01 d0                	add    %edx,%eax
}
     be0:	5d                   	pop    %ebp
     be1:	c3                   	ret    

00000be2 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     be2:	55                   	push   %ebp
     be3:	89 e5                	mov    %esp,%ebp
     be5:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     be8:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bef:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bf2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bf5:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bfc:	83 ec 08             	sub    $0x8,%esp
     bff:	6a 00                	push   $0x0
     c01:	ff 75 0c             	pushl  0xc(%ebp)
     c04:	e8 d4 f9 ff ff       	call   5dd <open>
     c09:	83 c4 10             	add    $0x10,%esp
     c0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     c0f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c13:	79 2e                	jns    c43 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     c15:	83 ec 04             	sub    $0x4,%esp
     c18:	ff 75 0c             	pushl  0xc(%ebp)
     c1b:	68 c5 27 00 00       	push   $0x27c5
     c20:	6a 01                	push   $0x1
     c22:	e8 35 fb ff ff       	call   75c <printf>
     c27:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c2a:	8b 45 08             	mov    0x8(%ebp),%eax
     c2d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c30:	89 10                	mov    %edx,(%eax)
     c32:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c35:	89 50 04             	mov    %edx,0x4(%eax)
     c38:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c3b:	89 50 08             	mov    %edx,0x8(%eax)
     c3e:	e9 d2 01 00 00       	jmp    e15 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c43:	83 ec 04             	sub    $0x4,%esp
     c46:	6a 0e                	push   $0xe
     c48:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c4b:	50                   	push   %eax
     c4c:	ff 75 ec             	pushl  -0x14(%ebp)
     c4f:	e8 61 f9 ff ff       	call   5b5 <read>
     c54:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c57:	83 ec 04             	sub    $0x4,%esp
     c5a:	6a 28                	push   $0x28
     c5c:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c5f:	50                   	push   %eax
     c60:	ff 75 ec             	pushl  -0x14(%ebp)
     c63:	e8 4d f9 ff ff       	call   5b5 <read>
     c68:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c6b:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c71:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c74:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c77:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c7a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c7d:	0f af d0             	imul   %eax,%edx
     c80:	89 d0                	mov    %edx,%eax
     c82:	01 c0                	add    %eax,%eax
     c84:	01 d0                	add    %edx,%eax
     c86:	83 ec 0c             	sub    $0xc,%esp
     c89:	50                   	push   %eax
     c8a:	e8 a0 fd ff ff       	call   a2f <malloc>
     c8f:	83 c4 10             	add    $0x10,%esp
     c92:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c95:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c99:	0f b7 c0             	movzwl %ax,%eax
     c9c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c9f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ca2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ca5:	0f af c2             	imul   %edx,%eax
     ca8:	83 c0 1f             	add    $0x1f,%eax
     cab:	c1 e8 05             	shr    $0x5,%eax
     cae:	c1 e0 02             	shl    $0x2,%eax
     cb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     cb4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cb7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cba:	0f af c2             	imul   %edx,%eax
     cbd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     cc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cc3:	83 ec 0c             	sub    $0xc,%esp
     cc6:	50                   	push   %eax
     cc7:	e8 63 fd ff ff       	call   a2f <malloc>
     ccc:	83 c4 10             	add    $0x10,%esp
     ccf:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     cd2:	83 ec 04             	sub    $0x4,%esp
     cd5:	ff 75 e0             	pushl  -0x20(%ebp)
     cd8:	ff 75 dc             	pushl  -0x24(%ebp)
     cdb:	ff 75 ec             	pushl  -0x14(%ebp)
     cde:	e8 d2 f8 ff ff       	call   5b5 <read>
     ce3:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     ce6:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     cea:	66 c1 e8 03          	shr    $0x3,%ax
     cee:	0f b7 c0             	movzwl %ax,%eax
     cf1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     cf4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cfb:	e9 e5 00 00 00       	jmp    de5 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     d00:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d06:	29 c2                	sub    %eax,%edx
     d08:	89 d0                	mov    %edx,%eax
     d0a:	8d 50 ff             	lea    -0x1(%eax),%edx
     d0d:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d10:	0f af c2             	imul   %edx,%eax
     d13:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d16:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d1d:	e9 b1 00 00 00       	jmp    dd3 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d22:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d25:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d2b:	01 c8                	add    %ecx,%eax
     d2d:	89 c1                	mov    %eax,%ecx
     d2f:	89 c8                	mov    %ecx,%eax
     d31:	01 c0                	add    %eax,%eax
     d33:	01 c8                	add    %ecx,%eax
     d35:	01 c2                	add    %eax,%edx
     d37:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d3a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d3e:	89 c1                	mov    %eax,%ecx
     d40:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d43:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d47:	01 c1                	add    %eax,%ecx
     d49:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d4c:	01 c8                	add    %ecx,%eax
     d4e:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d51:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d54:	01 c8                	add    %ecx,%eax
     d56:	0f b6 00             	movzbl (%eax),%eax
     d59:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d5c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d5f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d62:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d65:	01 c8                	add    %ecx,%eax
     d67:	89 c1                	mov    %eax,%ecx
     d69:	89 c8                	mov    %ecx,%eax
     d6b:	01 c0                	add    %eax,%eax
     d6d:	01 c8                	add    %ecx,%eax
     d6f:	01 c2                	add    %eax,%edx
     d71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d74:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d78:	89 c1                	mov    %eax,%ecx
     d7a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d7d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d81:	01 c1                	add    %eax,%ecx
     d83:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d86:	01 c8                	add    %ecx,%eax
     d88:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d8b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d8e:	01 c8                	add    %ecx,%eax
     d90:	0f b6 00             	movzbl (%eax),%eax
     d93:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d96:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d99:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d9f:	01 c8                	add    %ecx,%eax
     da1:	89 c1                	mov    %eax,%ecx
     da3:	89 c8                	mov    %ecx,%eax
     da5:	01 c0                	add    %eax,%eax
     da7:	01 c8                	add    %ecx,%eax
     da9:	01 c2                	add    %eax,%edx
     dab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dae:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     db2:	89 c1                	mov    %eax,%ecx
     db4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     db7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     dbb:	01 c1                	add    %eax,%ecx
     dbd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     dc0:	01 c8                	add    %ecx,%eax
     dc2:	8d 48 fd             	lea    -0x3(%eax),%ecx
     dc5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     dc8:	01 c8                	add    %ecx,%eax
     dca:	0f b6 00             	movzbl (%eax),%eax
     dcd:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     dcf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     dd3:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dd9:	39 c2                	cmp    %eax,%edx
     ddb:	0f 87 41 ff ff ff    	ja     d22 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     de1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     de5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     de8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     deb:	39 c2                	cmp    %eax,%edx
     ded:	0f 87 0d ff ff ff    	ja     d00 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     df3:	83 ec 0c             	sub    $0xc,%esp
     df6:	ff 75 ec             	pushl  -0x14(%ebp)
     df9:	e8 c7 f7 ff ff       	call   5c5 <close>
     dfe:	83 c4 10             	add    $0x10,%esp
    return bmp;
     e01:	8b 45 08             	mov    0x8(%ebp),%eax
     e04:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e07:	89 10                	mov    %edx,(%eax)
     e09:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e0c:	89 50 04             	mov    %edx,0x4(%eax)
     e0f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e12:	89 50 08             	mov    %edx,0x8(%eax)
}
     e15:	8b 45 08             	mov    0x8(%ebp),%eax
     e18:	c9                   	leave  
     e19:	c2 04 00             	ret    $0x4

00000e1c <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e1c:	55                   	push   %ebp
     e1d:	89 e5                	mov    %esp,%ebp
     e1f:	53                   	push   %ebx
     e20:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e23:	83 ec 0c             	sub    $0xc,%esp
     e26:	6a 1c                	push   $0x1c
     e28:	e8 02 fc ff ff       	call   a2f <malloc>
     e2d:	83 c4 10             	add    $0x10,%esp
     e30:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e33:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e36:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e3d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e40:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e43:	6a 0c                	push   $0xc
     e45:	6a 0c                	push   $0xc
     e47:	6a 0c                	push   $0xc
     e49:	50                   	push   %eax
     e4a:	e8 c3 fc ff ff       	call   b12 <RGB>
     e4f:	83 c4 0c             	add    $0xc,%esp
     e52:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e56:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e5a:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e5e:	88 43 15             	mov    %al,0x15(%ebx)
     e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e64:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e67:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e6b:	66 89 48 10          	mov    %cx,0x10(%eax)
     e6f:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e73:	88 50 12             	mov    %dl,0x12(%eax)
     e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e79:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e7c:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e80:	66 89 48 08          	mov    %cx,0x8(%eax)
     e84:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e88:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e8b:	8b 45 08             	mov    0x8(%ebp),%eax
     e8e:	89 c2                	mov    %eax,%edx
     e90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e93:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e95:	8b 45 0c             	mov    0xc(%ebp),%eax
     e98:	89 c2                	mov    %eax,%edx
     e9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e9d:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     ea0:	8b 55 10             	mov    0x10(%ebp),%edx
     ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea6:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     ea9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     eac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     eaf:	c9                   	leave  
     eb0:	c3                   	ret    

00000eb1 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     eb1:	55                   	push   %ebp
     eb2:	89 e5                	mov    %esp,%ebp
     eb4:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     eb7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eba:	8b 50 08             	mov    0x8(%eax),%edx
     ebd:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ec0:	8b 40 0c             	mov    0xc(%eax),%eax
     ec3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     ec6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec9:	8b 55 10             	mov    0x10(%ebp),%edx
     ecc:	89 50 08             	mov    %edx,0x8(%eax)
     ecf:	8b 55 14             	mov    0x14(%ebp),%edx
     ed2:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     edb:	89 10                	mov    %edx,(%eax)
     edd:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ee0:	89 50 04             	mov    %edx,0x4(%eax)
}
     ee3:	8b 45 08             	mov    0x8(%ebp),%eax
     ee6:	c9                   	leave  
     ee7:	c2 04 00             	ret    $0x4

00000eea <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     eea:	55                   	push   %ebp
     eeb:	89 e5                	mov    %esp,%ebp
     eed:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ef0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef3:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ef7:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     efb:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     eff:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     f02:	8b 45 0c             	mov    0xc(%ebp),%eax
     f05:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f09:	66 89 50 10          	mov    %dx,0x10(%eax)
     f0d:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f11:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f14:	8b 45 08             	mov    0x8(%ebp),%eax
     f17:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f1b:	66 89 10             	mov    %dx,(%eax)
     f1e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f22:	88 50 02             	mov    %dl,0x2(%eax)
}
     f25:	8b 45 08             	mov    0x8(%ebp),%eax
     f28:	c9                   	leave  
     f29:	c2 04 00             	ret    $0x4

00000f2c <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     f2c:	55                   	push   %ebp
     f2d:	89 e5                	mov    %esp,%ebp
     f2f:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     f32:	8b 45 0c             	mov    0xc(%ebp),%eax
     f35:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     f39:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f3d:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     f41:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     f44:	8b 45 0c             	mov    0xc(%ebp),%eax
     f47:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f4b:	66 89 50 13          	mov    %dx,0x13(%eax)
     f4f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f53:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     f56:	8b 45 08             	mov    0x8(%ebp),%eax
     f59:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f5d:	66 89 10             	mov    %dx,(%eax)
     f60:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f64:	88 50 02             	mov    %dl,0x2(%eax)
}
     f67:	8b 45 08             	mov    0x8(%ebp),%eax
     f6a:	c9                   	leave  
     f6b:	c2 04 00             	ret    $0x4

00000f6e <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f6e:	55                   	push   %ebp
     f6f:	89 e5                	mov    %esp,%ebp
     f71:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f74:	8b 45 08             	mov    0x8(%ebp),%eax
     f77:	8b 40 0c             	mov    0xc(%eax),%eax
     f7a:	89 c2                	mov    %eax,%edx
     f7c:	c1 ea 1f             	shr    $0x1f,%edx
     f7f:	01 d0                	add    %edx,%eax
     f81:	d1 f8                	sar    %eax
     f83:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f86:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f89:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f90:	8b 45 10             	mov    0x10(%ebp),%eax
     f93:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f96:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f99:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f9d:	0f 89 98 00 00 00    	jns    103b <APDrawPoint+0xcd>
        i = 0;
     fa3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     faa:	e9 8c 00 00 00       	jmp    103b <APDrawPoint+0xcd>
    {
        j = x - off;
     faf:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb2:	2b 45 f4             	sub    -0xc(%ebp),%eax
     fb5:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     fb8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     fbc:	79 69                	jns    1027 <APDrawPoint+0xb9>
            j = 0;
     fbe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     fc5:	eb 60                	jmp    1027 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     fc7:	ff 75 fc             	pushl  -0x4(%ebp)
     fca:	ff 75 f8             	pushl  -0x8(%ebp)
     fcd:	ff 75 08             	pushl  0x8(%ebp)
     fd0:	e8 bb fb ff ff       	call   b90 <APGetIndex>
     fd5:	83 c4 0c             	add    $0xc,%esp
     fd8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     fdb:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     fdf:	74 55                	je     1036 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     fe1:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     fe5:	74 67                	je     104e <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     fe7:	ff 75 10             	pushl  0x10(%ebp)
     fea:	ff 75 0c             	pushl  0xc(%ebp)
     fed:	ff 75 fc             	pushl  -0x4(%ebp)
     ff0:	ff 75 f8             	pushl  -0x8(%ebp)
     ff3:	e8 5f fb ff ff       	call   b57 <distance_2>
     ff8:	83 c4 10             	add    $0x10,%esp
     ffb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     ffe:	7f 23                	jg     1023 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    1000:	8b 45 08             	mov    0x8(%ebp),%eax
    1003:	8b 48 18             	mov    0x18(%eax),%ecx
    1006:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1009:	89 d0                	mov    %edx,%eax
    100b:	01 c0                	add    %eax,%eax
    100d:	01 d0                	add    %edx,%eax
    100f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1012:	8b 45 08             	mov    0x8(%ebp),%eax
    1015:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1019:	66 89 0a             	mov    %cx,(%edx)
    101c:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1020:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1023:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1027:	8b 55 0c             	mov    0xc(%ebp),%edx
    102a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102d:	01 d0                	add    %edx,%eax
    102f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1032:	7d 93                	jge    fc7 <APDrawPoint+0x59>
    1034:	eb 01                	jmp    1037 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1036:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1037:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    103b:	8b 55 10             	mov    0x10(%ebp),%edx
    103e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1041:	01 d0                	add    %edx,%eax
    1043:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1046:	0f 8d 63 ff ff ff    	jge    faf <APDrawPoint+0x41>
    104c:	eb 01                	jmp    104f <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    104e:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    104f:	c9                   	leave  
    1050:	c3                   	ret    

00001051 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1051:	55                   	push   %ebp
    1052:	89 e5                	mov    %esp,%ebp
    1054:	53                   	push   %ebx
    1055:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1058:	8b 45 0c             	mov    0xc(%ebp),%eax
    105b:	3b 45 14             	cmp    0x14(%ebp),%eax
    105e:	0f 85 80 00 00 00    	jne    10e4 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1064:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1068:	0f 88 9d 02 00 00    	js     130b <APDrawLine+0x2ba>
    106e:	8b 45 08             	mov    0x8(%ebp),%eax
    1071:	8b 00                	mov    (%eax),%eax
    1073:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1076:	0f 8e 8f 02 00 00    	jle    130b <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    107c:	8b 45 10             	mov    0x10(%ebp),%eax
    107f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1082:	7e 12                	jle    1096 <APDrawLine+0x45>
        {
            int tmp = y2;
    1084:	8b 45 18             	mov    0x18(%ebp),%eax
    1087:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    108a:	8b 45 10             	mov    0x10(%ebp),%eax
    108d:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1090:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1093:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1096:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    109a:	79 07                	jns    10a3 <APDrawLine+0x52>
    109c:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	8b 40 04             	mov    0x4(%eax),%eax
    10a9:	3b 45 18             	cmp    0x18(%ebp),%eax
    10ac:	7d 0c                	jge    10ba <APDrawLine+0x69>
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	8b 40 04             	mov    0x4(%eax),%eax
    10b4:	83 e8 01             	sub    $0x1,%eax
    10b7:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    10ba:	8b 45 10             	mov    0x10(%ebp),%eax
    10bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10c0:	eb 15                	jmp    10d7 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    10c2:	ff 75 f4             	pushl  -0xc(%ebp)
    10c5:	ff 75 0c             	pushl  0xc(%ebp)
    10c8:	ff 75 08             	pushl  0x8(%ebp)
    10cb:	e8 9e fe ff ff       	call   f6e <APDrawPoint>
    10d0:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10d3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10da:	3b 45 18             	cmp    0x18(%ebp),%eax
    10dd:	7e e3                	jle    10c2 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10df:	e9 2b 02 00 00       	jmp    130f <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10e4:	8b 45 10             	mov    0x10(%ebp),%eax
    10e7:	3b 45 18             	cmp    0x18(%ebp),%eax
    10ea:	75 7f                	jne    116b <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    10ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10f0:	0f 88 18 02 00 00    	js     130e <APDrawLine+0x2bd>
    10f6:	8b 45 08             	mov    0x8(%ebp),%eax
    10f9:	8b 40 04             	mov    0x4(%eax),%eax
    10fc:	3b 45 10             	cmp    0x10(%ebp),%eax
    10ff:	0f 8e 09 02 00 00    	jle    130e <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    1105:	8b 45 0c             	mov    0xc(%ebp),%eax
    1108:	3b 45 14             	cmp    0x14(%ebp),%eax
    110b:	7e 12                	jle    111f <APDrawLine+0xce>
        {
            int tmp = x2;
    110d:	8b 45 14             	mov    0x14(%ebp),%eax
    1110:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1113:	8b 45 0c             	mov    0xc(%ebp),%eax
    1116:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1119:	8b 45 d8             	mov    -0x28(%ebp),%eax
    111c:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    111f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1123:	79 07                	jns    112c <APDrawLine+0xdb>
    1125:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    112c:	8b 45 08             	mov    0x8(%ebp),%eax
    112f:	8b 00                	mov    (%eax),%eax
    1131:	3b 45 14             	cmp    0x14(%ebp),%eax
    1134:	7d 0b                	jge    1141 <APDrawLine+0xf0>
    1136:	8b 45 08             	mov    0x8(%ebp),%eax
    1139:	8b 00                	mov    (%eax),%eax
    113b:	83 e8 01             	sub    $0x1,%eax
    113e:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1141:	8b 45 0c             	mov    0xc(%ebp),%eax
    1144:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1147:	eb 15                	jmp    115e <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1149:	ff 75 10             	pushl  0x10(%ebp)
    114c:	ff 75 f0             	pushl  -0x10(%ebp)
    114f:	ff 75 08             	pushl  0x8(%ebp)
    1152:	e8 17 fe ff ff       	call   f6e <APDrawPoint>
    1157:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    115a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    115e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1161:	3b 45 14             	cmp    0x14(%ebp),%eax
    1164:	7e e3                	jle    1149 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1166:	e9 a4 01 00 00       	jmp    130f <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    116b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1172:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1179:	8b 45 0c             	mov    0xc(%ebp),%eax
    117c:	2b 45 14             	sub    0x14(%ebp),%eax
    117f:	50                   	push   %eax
    1180:	e8 fb f9 ff ff       	call   b80 <abs_int>
    1185:	83 c4 04             	add    $0x4,%esp
    1188:	89 c3                	mov    %eax,%ebx
    118a:	8b 45 10             	mov    0x10(%ebp),%eax
    118d:	2b 45 18             	sub    0x18(%ebp),%eax
    1190:	50                   	push   %eax
    1191:	e8 ea f9 ff ff       	call   b80 <abs_int>
    1196:	83 c4 04             	add    $0x4,%esp
    1199:	39 c3                	cmp    %eax,%ebx
    119b:	0f 8e b5 00 00 00    	jle    1256 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    11a1:	8b 45 10             	mov    0x10(%ebp),%eax
    11a4:	2b 45 18             	sub    0x18(%ebp),%eax
    11a7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11aa:	db 45 b0             	fildl  -0x50(%ebp)
    11ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    11b0:	2b 45 14             	sub    0x14(%ebp),%eax
    11b3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11b6:	db 45 b0             	fildl  -0x50(%ebp)
    11b9:	de f9                	fdivrp %st,%st(1)
    11bb:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    11be:	8b 45 14             	mov    0x14(%ebp),%eax
    11c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11c4:	7e 0e                	jle    11d4 <APDrawLine+0x183>
        {
            s = x1;
    11c6:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    11cc:	8b 45 14             	mov    0x14(%ebp),%eax
    11cf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11d2:	eb 0c                	jmp    11e0 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11d4:	8b 45 14             	mov    0x14(%ebp),%eax
    11d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11da:	8b 45 0c             	mov    0xc(%ebp),%eax
    11dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11e4:	79 07                	jns    11ed <APDrawLine+0x19c>
    11e6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    11ed:	8b 45 08             	mov    0x8(%ebp),%eax
    11f0:	8b 00                	mov    (%eax),%eax
    11f2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11f5:	7f 0b                	jg     1202 <APDrawLine+0x1b1>
    11f7:	8b 45 08             	mov    0x8(%ebp),%eax
    11fa:	8b 00                	mov    (%eax),%eax
    11fc:	83 e8 01             	sub    $0x1,%eax
    11ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    1202:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1205:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1208:	eb 3f                	jmp    1249 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    120a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    120d:	2b 45 0c             	sub    0xc(%ebp),%eax
    1210:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1213:	db 45 b0             	fildl  -0x50(%ebp)
    1216:	dc 4d d0             	fmull  -0x30(%ebp)
    1219:	db 45 10             	fildl  0x10(%ebp)
    121c:	de c1                	faddp  %st,%st(1)
    121e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1221:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1225:	b4 0c                	mov    $0xc,%ah
    1227:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    122b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    122e:	db 5d cc             	fistpl -0x34(%ebp)
    1231:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1234:	ff 75 cc             	pushl  -0x34(%ebp)
    1237:	ff 75 e4             	pushl  -0x1c(%ebp)
    123a:	ff 75 08             	pushl  0x8(%ebp)
    123d:	e8 2c fd ff ff       	call   f6e <APDrawPoint>
    1242:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1245:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1249:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    124c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    124f:	7e b9                	jle    120a <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1251:	e9 b9 00 00 00       	jmp    130f <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1256:	8b 45 0c             	mov    0xc(%ebp),%eax
    1259:	2b 45 14             	sub    0x14(%ebp),%eax
    125c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    125f:	db 45 b0             	fildl  -0x50(%ebp)
    1262:	8b 45 10             	mov    0x10(%ebp),%eax
    1265:	2b 45 18             	sub    0x18(%ebp),%eax
    1268:	89 45 b0             	mov    %eax,-0x50(%ebp)
    126b:	db 45 b0             	fildl  -0x50(%ebp)
    126e:	de f9                	fdivrp %st,%st(1)
    1270:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1273:	8b 45 10             	mov    0x10(%ebp),%eax
    1276:	3b 45 18             	cmp    0x18(%ebp),%eax
    1279:	7e 0e                	jle    1289 <APDrawLine+0x238>
    {
        s = y2;
    127b:	8b 45 18             	mov    0x18(%ebp),%eax
    127e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1281:	8b 45 10             	mov    0x10(%ebp),%eax
    1284:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1287:	eb 0c                	jmp    1295 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1289:	8b 45 10             	mov    0x10(%ebp),%eax
    128c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    128f:	8b 45 18             	mov    0x18(%ebp),%eax
    1292:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1295:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1299:	79 07                	jns    12a2 <APDrawLine+0x251>
    129b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    12a2:	8b 45 08             	mov    0x8(%ebp),%eax
    12a5:	8b 40 04             	mov    0x4(%eax),%eax
    12a8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12ab:	7f 0c                	jg     12b9 <APDrawLine+0x268>
    12ad:	8b 45 08             	mov    0x8(%ebp),%eax
    12b0:	8b 40 04             	mov    0x4(%eax),%eax
    12b3:	83 e8 01             	sub    $0x1,%eax
    12b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    12b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12bc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    12bf:	eb 3f                	jmp    1300 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    12c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12c4:	2b 45 10             	sub    0x10(%ebp),%eax
    12c7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12ca:	db 45 b0             	fildl  -0x50(%ebp)
    12cd:	dc 4d c0             	fmull  -0x40(%ebp)
    12d0:	db 45 0c             	fildl  0xc(%ebp)
    12d3:	de c1                	faddp  %st,%st(1)
    12d5:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12d8:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12dc:	b4 0c                	mov    $0xc,%ah
    12de:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12e2:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12e5:	db 5d bc             	fistpl -0x44(%ebp)
    12e8:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    12eb:	ff 75 e0             	pushl  -0x20(%ebp)
    12ee:	ff 75 bc             	pushl  -0x44(%ebp)
    12f1:	ff 75 08             	pushl  0x8(%ebp)
    12f4:	e8 75 fc ff ff       	call   f6e <APDrawPoint>
    12f9:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12fc:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1300:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1303:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1306:	7e b9                	jle    12c1 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    1308:	90                   	nop
    1309:	eb 04                	jmp    130f <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    130b:	90                   	nop
    130c:	eb 01                	jmp    130f <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    130e:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    130f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1312:	c9                   	leave  
    1313:	c3                   	ret    

00001314 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1314:	55                   	push   %ebp
    1315:	89 e5                	mov    %esp,%ebp
    1317:	53                   	push   %ebx
    1318:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    131b:	8b 55 10             	mov    0x10(%ebp),%edx
    131e:	8b 45 18             	mov    0x18(%ebp),%eax
    1321:	01 d0                	add    %edx,%eax
    1323:	83 e8 01             	sub    $0x1,%eax
    1326:	83 ec 04             	sub    $0x4,%esp
    1329:	50                   	push   %eax
    132a:	ff 75 0c             	pushl  0xc(%ebp)
    132d:	ff 75 10             	pushl  0x10(%ebp)
    1330:	ff 75 0c             	pushl  0xc(%ebp)
    1333:	ff 75 08             	pushl  0x8(%ebp)
    1336:	e8 16 fd ff ff       	call   1051 <APDrawLine>
    133b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    133e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1341:	8b 45 14             	mov    0x14(%ebp),%eax
    1344:	01 d0                	add    %edx,%eax
    1346:	83 e8 01             	sub    $0x1,%eax
    1349:	83 ec 04             	sub    $0x4,%esp
    134c:	ff 75 10             	pushl  0x10(%ebp)
    134f:	50                   	push   %eax
    1350:	ff 75 10             	pushl  0x10(%ebp)
    1353:	ff 75 0c             	pushl  0xc(%ebp)
    1356:	ff 75 08             	pushl  0x8(%ebp)
    1359:	e8 f3 fc ff ff       	call   1051 <APDrawLine>
    135e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1361:	8b 55 10             	mov    0x10(%ebp),%edx
    1364:	8b 45 18             	mov    0x18(%ebp),%eax
    1367:	01 d0                	add    %edx,%eax
    1369:	8d 48 ff             	lea    -0x1(%eax),%ecx
    136c:	8b 55 0c             	mov    0xc(%ebp),%edx
    136f:	8b 45 14             	mov    0x14(%ebp),%eax
    1372:	01 d0                	add    %edx,%eax
    1374:	8d 50 ff             	lea    -0x1(%eax),%edx
    1377:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    137a:	8b 45 14             	mov    0x14(%ebp),%eax
    137d:	01 d8                	add    %ebx,%eax
    137f:	83 e8 01             	sub    $0x1,%eax
    1382:	83 ec 04             	sub    $0x4,%esp
    1385:	51                   	push   %ecx
    1386:	52                   	push   %edx
    1387:	ff 75 10             	pushl  0x10(%ebp)
    138a:	50                   	push   %eax
    138b:	ff 75 08             	pushl  0x8(%ebp)
    138e:	e8 be fc ff ff       	call   1051 <APDrawLine>
    1393:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1396:	8b 55 10             	mov    0x10(%ebp),%edx
    1399:	8b 45 18             	mov    0x18(%ebp),%eax
    139c:	01 d0                	add    %edx,%eax
    139e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    13a1:	8b 55 0c             	mov    0xc(%ebp),%edx
    13a4:	8b 45 14             	mov    0x14(%ebp),%eax
    13a7:	01 d0                	add    %edx,%eax
    13a9:	8d 50 ff             	lea    -0x1(%eax),%edx
    13ac:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13af:	8b 45 18             	mov    0x18(%ebp),%eax
    13b2:	01 d8                	add    %ebx,%eax
    13b4:	83 e8 01             	sub    $0x1,%eax
    13b7:	83 ec 04             	sub    $0x4,%esp
    13ba:	51                   	push   %ecx
    13bb:	52                   	push   %edx
    13bc:	50                   	push   %eax
    13bd:	ff 75 0c             	pushl  0xc(%ebp)
    13c0:	ff 75 08             	pushl  0x8(%ebp)
    13c3:	e8 89 fc ff ff       	call   1051 <APDrawLine>
    13c8:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    13cb:	8b 55 0c             	mov    0xc(%ebp),%edx
    13ce:	8b 45 14             	mov    0x14(%ebp),%eax
    13d1:	01 d0                	add    %edx,%eax
    13d3:	8d 50 ff             	lea    -0x1(%eax),%edx
    13d6:	8b 45 08             	mov    0x8(%ebp),%eax
    13d9:	8b 40 0c             	mov    0xc(%eax),%eax
    13dc:	89 c1                	mov    %eax,%ecx
    13de:	c1 e9 1f             	shr    $0x1f,%ecx
    13e1:	01 c8                	add    %ecx,%eax
    13e3:	d1 f8                	sar    %eax
    13e5:	29 c2                	sub    %eax,%edx
    13e7:	89 d0                	mov    %edx,%eax
    13e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    13ec:	8b 55 10             	mov    0x10(%ebp),%edx
    13ef:	8b 45 18             	mov    0x18(%ebp),%eax
    13f2:	01 d0                	add    %edx,%eax
    13f4:	8d 50 ff             	lea    -0x1(%eax),%edx
    13f7:	8b 45 08             	mov    0x8(%ebp),%eax
    13fa:	8b 40 0c             	mov    0xc(%eax),%eax
    13fd:	89 c1                	mov    %eax,%ecx
    13ff:	c1 e9 1f             	shr    $0x1f,%ecx
    1402:	01 c8                	add    %ecx,%eax
    1404:	d1 f8                	sar    %eax
    1406:	29 c2                	sub    %eax,%edx
    1408:	89 d0                	mov    %edx,%eax
    140a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    140d:	8b 45 08             	mov    0x8(%ebp),%eax
    1410:	8b 40 0c             	mov    0xc(%eax),%eax
    1413:	89 c2                	mov    %eax,%edx
    1415:	c1 ea 1f             	shr    $0x1f,%edx
    1418:	01 d0                	add    %edx,%eax
    141a:	d1 f8                	sar    %eax
    141c:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    141f:	8b 45 08             	mov    0x8(%ebp),%eax
    1422:	8b 40 0c             	mov    0xc(%eax),%eax
    1425:	89 c2                	mov    %eax,%edx
    1427:	c1 ea 1f             	shr    $0x1f,%edx
    142a:	01 d0                	add    %edx,%eax
    142c:	d1 f8                	sar    %eax
    142e:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1431:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1435:	0f 88 d8 00 00 00    	js     1513 <APDrawRect+0x1ff>
    143b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    143f:	0f 88 ce 00 00 00    	js     1513 <APDrawRect+0x1ff>
    1445:	8b 45 08             	mov    0x8(%ebp),%eax
    1448:	8b 00                	mov    (%eax),%eax
    144a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    144d:	0f 8e c0 00 00 00    	jle    1513 <APDrawRect+0x1ff>
    1453:	8b 45 08             	mov    0x8(%ebp),%eax
    1456:	8b 40 04             	mov    0x4(%eax),%eax
    1459:	3b 45 10             	cmp    0x10(%ebp),%eax
    145c:	0f 8e b1 00 00 00    	jle    1513 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1462:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1466:	79 07                	jns    146f <APDrawRect+0x15b>
    1468:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    146f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1473:	79 07                	jns    147c <APDrawRect+0x168>
    1475:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    147c:	8b 45 08             	mov    0x8(%ebp),%eax
    147f:	8b 00                	mov    (%eax),%eax
    1481:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1484:	7f 0b                	jg     1491 <APDrawRect+0x17d>
    1486:	8b 45 08             	mov    0x8(%ebp),%eax
    1489:	8b 00                	mov    (%eax),%eax
    148b:	83 e8 01             	sub    $0x1,%eax
    148e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1491:	8b 45 08             	mov    0x8(%ebp),%eax
    1494:	8b 40 04             	mov    0x4(%eax),%eax
    1497:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    149a:	7f 0c                	jg     14a8 <APDrawRect+0x194>
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
    149f:	8b 40 04             	mov    0x4(%eax),%eax
    14a2:	83 e8 01             	sub    $0x1,%eax
    14a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    14a8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14af:	8b 45 0c             	mov    0xc(%ebp),%eax
    14b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14b5:	eb 52                	jmp    1509 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    14b7:	8b 45 10             	mov    0x10(%ebp),%eax
    14ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14bd:	eb 3e                	jmp    14fd <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    14bf:	83 ec 04             	sub    $0x4,%esp
    14c2:	ff 75 e8             	pushl  -0x18(%ebp)
    14c5:	ff 75 ec             	pushl  -0x14(%ebp)
    14c8:	ff 75 08             	pushl  0x8(%ebp)
    14cb:	e8 c0 f6 ff ff       	call   b90 <APGetIndex>
    14d0:	83 c4 10             	add    $0x10,%esp
    14d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14d6:	8b 45 08             	mov    0x8(%ebp),%eax
    14d9:	8b 48 18             	mov    0x18(%eax),%ecx
    14dc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14df:	89 d0                	mov    %edx,%eax
    14e1:	01 c0                	add    %eax,%eax
    14e3:	01 d0                	add    %edx,%eax
    14e5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14e8:	8b 45 08             	mov    0x8(%ebp),%eax
    14eb:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    14ef:	66 89 0a             	mov    %cx,(%edx)
    14f2:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14f6:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14f9:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1500:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1503:	7e ba                	jle    14bf <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1505:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1509:	8b 45 ec             	mov    -0x14(%ebp),%eax
    150c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    150f:	7e a6                	jle    14b7 <APDrawRect+0x1a3>
    1511:	eb 01                	jmp    1514 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1513:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1514:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1517:	c9                   	leave  
    1518:	c3                   	ret    

00001519 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1519:	55                   	push   %ebp
    151a:	89 e5                	mov    %esp,%ebp
    151c:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    151f:	83 ec 0c             	sub    $0xc,%esp
    1522:	ff 75 0c             	pushl  0xc(%ebp)
    1525:	e8 b1 ee ff ff       	call   3db <strlen>
    152a:	83 c4 10             	add    $0x10,%esp
    152d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1530:	8b 45 08             	mov    0x8(%ebp),%eax
    1533:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1537:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    153b:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    153f:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1542:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1549:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1550:	e9 bc 00 00 00       	jmp    1611 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1555:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1558:	8b 45 0c             	mov    0xc(%ebp),%eax
    155b:	01 d0                	add    %edx,%eax
    155d:	0f b6 00             	movzbl (%eax),%eax
    1560:	0f be c0             	movsbl %al,%eax
    1563:	83 e8 20             	sub    $0x20,%eax
    1566:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1569:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    156d:	0f 87 9a 00 00 00    	ja     160d <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1573:	8b 45 08             	mov    0x8(%ebp),%eax
    1576:	8b 00                	mov    (%eax),%eax
    1578:	0f af 45 14          	imul   0x14(%ebp),%eax
    157c:	89 c2                	mov    %eax,%edx
    157e:	8b 45 10             	mov    0x10(%ebp),%eax
    1581:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1584:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1587:	89 d0                	mov    %edx,%eax
    1589:	c1 e0 03             	shl    $0x3,%eax
    158c:	01 d0                	add    %edx,%eax
    158e:	01 c8                	add    %ecx,%eax
    1590:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1593:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    159a:	eb 6b                	jmp    1607 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    159c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    15a3:	eb 50                	jmp    15f5 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    15a5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    15a8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15ab:	89 d0                	mov    %edx,%eax
    15ad:	c1 e0 03             	shl    $0x3,%eax
    15b0:	01 d0                	add    %edx,%eax
    15b2:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    15b8:	01 c2                	add    %eax,%edx
    15ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15bd:	01 d0                	add    %edx,%eax
    15bf:	05 60 2f 00 00       	add    $0x2f60,%eax
    15c4:	0f b6 00             	movzbl (%eax),%eax
    15c7:	84 c0                	test   %al,%al
    15c9:	74 26                	je     15f1 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    15cb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ce:	8b 50 18             	mov    0x18(%eax),%edx
    15d1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    15d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15d7:	01 c8                	add    %ecx,%eax
    15d9:	89 c1                	mov    %eax,%ecx
    15db:	89 c8                	mov    %ecx,%eax
    15dd:	01 c0                	add    %eax,%eax
    15df:	01 c8                	add    %ecx,%eax
    15e1:	01 d0                	add    %edx,%eax
    15e3:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    15e7:	66 89 10             	mov    %dx,(%eax)
    15ea:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15ee:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    15f1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    15f5:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    15f9:	7e aa                	jle    15a5 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    15fb:	8b 45 08             	mov    0x8(%ebp),%eax
    15fe:	8b 00                	mov    (%eax),%eax
    1600:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1603:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1607:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    160b:	7e 8f                	jle    159c <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    160d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1611:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1614:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1617:	0f 82 38 ff ff ff    	jb     1555 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    161d:	90                   	nop
    161e:	c9                   	leave  
    161f:	c3                   	ret    

00001620 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1620:	55                   	push   %ebp
    1621:	89 e5                	mov    %esp,%ebp
    1623:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1626:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    162a:	0f 88 8e 01 00 00    	js     17be <APDcCopy+0x19e>
    1630:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1634:	0f 88 84 01 00 00    	js     17be <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    163a:	8b 55 0c             	mov    0xc(%ebp),%edx
    163d:	8b 45 20             	mov    0x20(%ebp),%eax
    1640:	01 d0                	add    %edx,%eax
    1642:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1645:	8b 55 10             	mov    0x10(%ebp),%edx
    1648:	8b 45 24             	mov    0x24(%ebp),%eax
    164b:	01 d0                	add    %edx,%eax
    164d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1650:	8b 55 18             	mov    0x18(%ebp),%edx
    1653:	8b 45 20             	mov    0x20(%ebp),%eax
    1656:	01 d0                	add    %edx,%eax
    1658:	89 45 ec             	mov    %eax,-0x14(%ebp)
    165b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    165e:	8b 45 24             	mov    0x24(%ebp),%eax
    1661:	01 d0                	add    %edx,%eax
    1663:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1666:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    166a:	0f 88 51 01 00 00    	js     17c1 <APDcCopy+0x1a1>
    1670:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1674:	0f 88 47 01 00 00    	js     17c1 <APDcCopy+0x1a1>
    167a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    167e:	0f 88 3d 01 00 00    	js     17c1 <APDcCopy+0x1a1>
    1684:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1688:	0f 88 33 01 00 00    	js     17c1 <APDcCopy+0x1a1>
    168e:	8b 45 14             	mov    0x14(%ebp),%eax
    1691:	8b 00                	mov    (%eax),%eax
    1693:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1696:	0f 8c 25 01 00 00    	jl     17c1 <APDcCopy+0x1a1>
    169c:	8b 45 14             	mov    0x14(%ebp),%eax
    169f:	8b 40 04             	mov    0x4(%eax),%eax
    16a2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    16a5:	0f 8c 16 01 00 00    	jl     17c1 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    16ab:	8b 45 08             	mov    0x8(%ebp),%eax
    16ae:	8b 00                	mov    (%eax),%eax
    16b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16b3:	7f 0b                	jg     16c0 <APDcCopy+0xa0>
    16b5:	8b 45 08             	mov    0x8(%ebp),%eax
    16b8:	8b 00                	mov    (%eax),%eax
    16ba:	83 e8 01             	sub    $0x1,%eax
    16bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    16c0:	8b 45 08             	mov    0x8(%ebp),%eax
    16c3:	8b 40 04             	mov    0x4(%eax),%eax
    16c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16c9:	7f 0c                	jg     16d7 <APDcCopy+0xb7>
    16cb:	8b 45 08             	mov    0x8(%ebp),%eax
    16ce:	8b 40 04             	mov    0x4(%eax),%eax
    16d1:	83 e8 01             	sub    $0x1,%eax
    16d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    16d7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    16de:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    16e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16ec:	e9 bc 00 00 00       	jmp    17ad <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    16f1:	8b 45 08             	mov    0x8(%ebp),%eax
    16f4:	8b 00                	mov    (%eax),%eax
    16f6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16f9:	8b 55 10             	mov    0x10(%ebp),%edx
    16fc:	01 ca                	add    %ecx,%edx
    16fe:	0f af d0             	imul   %eax,%edx
    1701:	8b 45 0c             	mov    0xc(%ebp),%eax
    1704:	01 d0                	add    %edx,%eax
    1706:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    1709:	8b 45 14             	mov    0x14(%ebp),%eax
    170c:	8b 00                	mov    (%eax),%eax
    170e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1711:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1714:	01 ca                	add    %ecx,%edx
    1716:	0f af d0             	imul   %eax,%edx
    1719:	8b 45 18             	mov    0x18(%ebp),%eax
    171c:	01 d0                	add    %edx,%eax
    171e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1721:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1728:	eb 74                	jmp    179e <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    172a:	8b 45 14             	mov    0x14(%ebp),%eax
    172d:	8b 50 18             	mov    0x18(%eax),%edx
    1730:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1733:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1736:	01 c8                	add    %ecx,%eax
    1738:	89 c1                	mov    %eax,%ecx
    173a:	89 c8                	mov    %ecx,%eax
    173c:	01 c0                	add    %eax,%eax
    173e:	01 c8                	add    %ecx,%eax
    1740:	01 d0                	add    %edx,%eax
    1742:	0f b7 10             	movzwl (%eax),%edx
    1745:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1749:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    174d:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1750:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1754:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1758:	38 c2                	cmp    %al,%dl
    175a:	75 18                	jne    1774 <APDcCopy+0x154>
    175c:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1760:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1764:	38 c2                	cmp    %al,%dl
    1766:	75 0c                	jne    1774 <APDcCopy+0x154>
    1768:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    176c:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1770:	38 c2                	cmp    %al,%dl
    1772:	74 26                	je     179a <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1774:	8b 45 08             	mov    0x8(%ebp),%eax
    1777:	8b 50 18             	mov    0x18(%eax),%edx
    177a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    177d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1780:	01 c8                	add    %ecx,%eax
    1782:	89 c1                	mov    %eax,%ecx
    1784:	89 c8                	mov    %ecx,%eax
    1786:	01 c0                	add    %eax,%eax
    1788:	01 c8                	add    %ecx,%eax
    178a:	01 d0                	add    %edx,%eax
    178c:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1790:	66 89 10             	mov    %dx,(%eax)
    1793:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1797:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    179a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    179e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a1:	2b 45 0c             	sub    0xc(%ebp),%eax
    17a4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    17a7:	7d 81                	jge    172a <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    17a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    17ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b0:	2b 45 10             	sub    0x10(%ebp),%eax
    17b3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17b6:	0f 8d 35 ff ff ff    	jge    16f1 <APDcCopy+0xd1>
    17bc:	eb 04                	jmp    17c2 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    17be:	90                   	nop
    17bf:	eb 01                	jmp    17c2 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    17c1:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    17c2:	c9                   	leave  
    17c3:	c3                   	ret    

000017c4 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    17c4:	55                   	push   %ebp
    17c5:	89 e5                	mov    %esp,%ebp
    17c7:	83 ec 1c             	sub    $0x1c,%esp
    17ca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    17cd:	8b 55 10             	mov    0x10(%ebp),%edx
    17d0:	8b 45 14             	mov    0x14(%ebp),%eax
    17d3:	88 4d ec             	mov    %cl,-0x14(%ebp)
    17d6:	88 55 e8             	mov    %dl,-0x18(%ebp)
    17d9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    17dc:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    17e0:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    17e3:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    17e7:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    17ea:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    17ee:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    17f1:	8b 45 08             	mov    0x8(%ebp),%eax
    17f4:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    17f8:	66 89 10             	mov    %dx,(%eax)
    17fb:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    17ff:	88 50 02             	mov    %dl,0x2(%eax)
}
    1802:	8b 45 08             	mov    0x8(%ebp),%eax
    1805:	c9                   	leave  
    1806:	c2 04 00             	ret    $0x4

00001809 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    1809:	55                   	push   %ebp
    180a:	89 e5                	mov    %esp,%ebp
    180c:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    180f:	8b 45 08             	mov    0x8(%ebp),%eax
    1812:	8b 00                	mov    (%eax),%eax
    1814:	83 ec 08             	sub    $0x8,%esp
    1817:	8d 55 0c             	lea    0xc(%ebp),%edx
    181a:	52                   	push   %edx
    181b:	50                   	push   %eax
    181c:	e8 24 ee ff ff       	call   645 <sendMessage>
    1821:	83 c4 10             	add    $0x10,%esp
}
    1824:	90                   	nop
    1825:	c9                   	leave  
    1826:	c3                   	ret    

00001827 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1827:	55                   	push   %ebp
    1828:	89 e5                	mov    %esp,%ebp
    182a:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    182d:	83 ec 0c             	sub    $0xc,%esp
    1830:	68 98 00 00 00       	push   $0x98
    1835:	e8 f5 f1 ff ff       	call   a2f <malloc>
    183a:	83 c4 10             	add    $0x10,%esp
    183d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1840:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1844:	75 15                	jne    185b <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1846:	83 ec 04             	sub    $0x4,%esp
    1849:	ff 75 08             	pushl  0x8(%ebp)
    184c:	68 d8 27 00 00       	push   $0x27d8
    1851:	6a 01                	push   $0x1
    1853:	e8 04 ef ff ff       	call   75c <printf>
    1858:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    185b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185e:	05 84 00 00 00       	add    $0x84,%eax
    1863:	83 ec 08             	sub    $0x8,%esp
    1866:	ff 75 08             	pushl  0x8(%ebp)
    1869:	50                   	push   %eax
    186a:	e8 fd ea ff ff       	call   36c <strcpy>
    186f:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1872:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1875:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187f:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1886:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1889:	8b 40 3c             	mov    0x3c(%eax),%eax
    188c:	89 c2                	mov    %eax,%edx
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	8b 40 40             	mov    0x40(%eax),%eax
    1894:	0f af d0             	imul   %eax,%edx
    1897:	89 d0                	mov    %edx,%eax
    1899:	01 c0                	add    %eax,%eax
    189b:	01 d0                	add    %edx,%eax
    189d:	83 ec 0c             	sub    $0xc,%esp
    18a0:	50                   	push   %eax
    18a1:	e8 89 f1 ff ff       	call   a2f <malloc>
    18a6:	83 c4 10             	add    $0x10,%esp
    18a9:	89 c2                	mov    %eax,%edx
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    18b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b4:	8b 40 54             	mov    0x54(%eax),%eax
    18b7:	85 c0                	test   %eax,%eax
    18b9:	75 15                	jne    18d0 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    18bb:	83 ec 04             	sub    $0x4,%esp
    18be:	ff 75 08             	pushl  0x8(%ebp)
    18c1:	68 f8 27 00 00       	push   $0x27f8
    18c6:	6a 01                	push   $0x1
    18c8:	e8 8f ee ff ff       	call   75c <printf>
    18cd:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    18d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d3:	8b 40 3c             	mov    0x3c(%eax),%eax
    18d6:	89 c2                	mov    %eax,%edx
    18d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18db:	8b 40 40             	mov    0x40(%eax),%eax
    18de:	0f af d0             	imul   %eax,%edx
    18e1:	89 d0                	mov    %edx,%eax
    18e3:	01 c0                	add    %eax,%eax
    18e5:	01 c2                	add    %eax,%edx
    18e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ea:	8b 40 54             	mov    0x54(%eax),%eax
    18ed:	83 ec 04             	sub    $0x4,%esp
    18f0:	52                   	push   %edx
    18f1:	68 ff ff ff 00       	push   $0xffffff
    18f6:	50                   	push   %eax
    18f7:	e8 06 eb ff ff       	call   402 <memset>
    18fc:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    18ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1902:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    1909:	e8 0f ed ff ff       	call   61d <getpid>
    190e:	89 c2                	mov    %eax,%edx
    1910:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1913:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1916:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1919:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1920:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1923:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    192a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192d:	8b 40 58             	mov    0x58(%eax),%eax
    1930:	89 c2                	mov    %eax,%edx
    1932:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1935:	8b 40 5c             	mov    0x5c(%eax),%eax
    1938:	0f af d0             	imul   %eax,%edx
    193b:	89 d0                	mov    %edx,%eax
    193d:	01 c0                	add    %eax,%eax
    193f:	01 d0                	add    %edx,%eax
    1941:	83 ec 0c             	sub    $0xc,%esp
    1944:	50                   	push   %eax
    1945:	e8 e5 f0 ff ff       	call   a2f <malloc>
    194a:	83 c4 10             	add    $0x10,%esp
    194d:	89 c2                	mov    %eax,%edx
    194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1952:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1955:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1958:	8b 40 70             	mov    0x70(%eax),%eax
    195b:	85 c0                	test   %eax,%eax
    195d:	75 15                	jne    1974 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    195f:	83 ec 04             	sub    $0x4,%esp
    1962:	ff 75 08             	pushl  0x8(%ebp)
    1965:	68 1c 28 00 00       	push   $0x281c
    196a:	6a 01                	push   $0x1
    196c:	e8 eb ed ff ff       	call   75c <printf>
    1971:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1974:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1977:	8b 40 3c             	mov    0x3c(%eax),%eax
    197a:	89 c2                	mov    %eax,%edx
    197c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197f:	8b 40 40             	mov    0x40(%eax),%eax
    1982:	0f af d0             	imul   %eax,%edx
    1985:	89 d0                	mov    %edx,%eax
    1987:	01 c0                	add    %eax,%eax
    1989:	01 c2                	add    %eax,%edx
    198b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    198e:	8b 40 54             	mov    0x54(%eax),%eax
    1991:	83 ec 04             	sub    $0x4,%esp
    1994:	52                   	push   %edx
    1995:	68 ff 00 00 00       	push   $0xff
    199a:	50                   	push   %eax
    199b:	e8 62 ea ff ff       	call   402 <memset>
    19a0:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    19a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a6:	8b 55 0c             	mov    0xc(%ebp),%edx
    19a9:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    19ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19b0:	74 49                	je     19fb <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    19b2:	8b 45 10             	mov    0x10(%ebp),%eax
    19b5:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    19bb:	83 ec 0c             	sub    $0xc,%esp
    19be:	50                   	push   %eax
    19bf:	e8 6b f0 ff ff       	call   a2f <malloc>
    19c4:	83 c4 10             	add    $0x10,%esp
    19c7:	89 c2                	mov    %eax,%edx
    19c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19cc:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    19cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d2:	8b 55 10             	mov    0x10(%ebp),%edx
    19d5:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    19d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19db:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    19e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e5:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    19ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ef:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    19f6:	e9 8d 00 00 00       	jmp    1a88 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    19fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fe:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a08:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a12:	8b 40 20             	mov    0x20(%eax),%eax
    1a15:	89 c2                	mov    %eax,%edx
    1a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a1a:	8b 40 24             	mov    0x24(%eax),%eax
    1a1d:	0f af d0             	imul   %eax,%edx
    1a20:	89 d0                	mov    %edx,%eax
    1a22:	01 c0                	add    %eax,%eax
    1a24:	01 d0                	add    %edx,%eax
    1a26:	83 ec 0c             	sub    $0xc,%esp
    1a29:	50                   	push   %eax
    1a2a:	e8 00 f0 ff ff       	call   a2f <malloc>
    1a2f:	83 c4 10             	add    $0x10,%esp
    1a32:	89 c2                	mov    %eax,%edx
    1a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a37:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3d:	8b 40 38             	mov    0x38(%eax),%eax
    1a40:	85 c0                	test   %eax,%eax
    1a42:	75 15                	jne    1a59 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1a44:	83 ec 04             	sub    $0x4,%esp
    1a47:	ff 75 08             	pushl  0x8(%ebp)
    1a4a:	68 44 28 00 00       	push   $0x2844
    1a4f:	6a 01                	push   $0x1
    1a51:	e8 06 ed ff ff       	call   75c <printf>
    1a56:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5c:	8b 40 20             	mov    0x20(%eax),%eax
    1a5f:	89 c2                	mov    %eax,%edx
    1a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a64:	8b 40 24             	mov    0x24(%eax),%eax
    1a67:	0f af d0             	imul   %eax,%edx
    1a6a:	89 d0                	mov    %edx,%eax
    1a6c:	01 c0                	add    %eax,%eax
    1a6e:	01 c2                	add    %eax,%edx
    1a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a73:	8b 40 38             	mov    0x38(%eax),%eax
    1a76:	83 ec 04             	sub    $0x4,%esp
    1a79:	52                   	push   %edx
    1a7a:	68 ff ff ff 00       	push   $0xffffff
    1a7f:	50                   	push   %eax
    1a80:	e8 7d e9 ff ff       	call   402 <memset>
    1a85:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1a8b:	c9                   	leave  
    1a8c:	c3                   	ret    

00001a8d <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1a8d:	55                   	push   %ebp
    1a8e:	89 e5                	mov    %esp,%ebp
    1a90:	57                   	push   %edi
    1a91:	56                   	push   %esi
    1a92:	53                   	push   %ebx
    1a93:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1a96:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a99:	83 f8 03             	cmp    $0x3,%eax
    1a9c:	74 02                	je     1aa0 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1a9e:	eb 7c                	jmp    1b1c <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1aa0:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa3:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1aa6:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa9:	8b 48 18             	mov    0x18(%eax),%ecx
    1aac:	8b 45 08             	mov    0x8(%ebp),%eax
    1aaf:	8b 50 5c             	mov    0x5c(%eax),%edx
    1ab2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab5:	8b 40 58             	mov    0x58(%eax),%eax
    1ab8:	8b 75 08             	mov    0x8(%ebp),%esi
    1abb:	83 c6 58             	add    $0x58,%esi
    1abe:	83 ec 04             	sub    $0x4,%esp
    1ac1:	53                   	push   %ebx
    1ac2:	51                   	push   %ecx
    1ac3:	6a 00                	push   $0x0
    1ac5:	52                   	push   %edx
    1ac6:	50                   	push   %eax
    1ac7:	6a 00                	push   $0x0
    1ac9:	6a 00                	push   $0x0
    1acb:	56                   	push   %esi
    1acc:	6a 00                	push   $0x0
    1ace:	6a 00                	push   $0x0
    1ad0:	ff 75 08             	pushl  0x8(%ebp)
    1ad3:	e8 65 eb ff ff       	call   63d <paintWindow>
    1ad8:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1adb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ade:	8b 70 1c             	mov    0x1c(%eax),%esi
    1ae1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae4:	8b 58 18             	mov    0x18(%eax),%ebx
    1ae7:	8b 45 08             	mov    0x8(%ebp),%eax
    1aea:	8b 48 08             	mov    0x8(%eax),%ecx
    1aed:	8b 45 08             	mov    0x8(%ebp),%eax
    1af0:	8b 50 40             	mov    0x40(%eax),%edx
    1af3:	8b 45 08             	mov    0x8(%ebp),%eax
    1af6:	8b 40 3c             	mov    0x3c(%eax),%eax
    1af9:	8b 7d 08             	mov    0x8(%ebp),%edi
    1afc:	83 c7 3c             	add    $0x3c,%edi
    1aff:	83 ec 04             	sub    $0x4,%esp
    1b02:	56                   	push   %esi
    1b03:	53                   	push   %ebx
    1b04:	51                   	push   %ecx
    1b05:	52                   	push   %edx
    1b06:	50                   	push   %eax
    1b07:	6a 00                	push   $0x0
    1b09:	6a 00                	push   $0x0
    1b0b:	57                   	push   %edi
    1b0c:	6a 32                	push   $0x32
    1b0e:	6a 00                	push   $0x0
    1b10:	ff 75 08             	pushl  0x8(%ebp)
    1b13:	e8 25 eb ff ff       	call   63d <paintWindow>
    1b18:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1b1b:	90                   	nop
        default: break;
            
            
    }
    return False;
    1b1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b21:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b24:	5b                   	pop    %ebx
    1b25:	5e                   	pop    %esi
    1b26:	5f                   	pop    %edi
    1b27:	5d                   	pop    %ebp
    1b28:	c3                   	ret    

00001b29 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1b29:	55                   	push   %ebp
    1b2a:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b2f:	8b 50 08             	mov    0x8(%eax),%edx
    1b32:	8b 45 08             	mov    0x8(%ebp),%eax
    1b35:	8b 00                	mov    (%eax),%eax
    1b37:	39 c2                	cmp    %eax,%edx
    1b39:	74 07                	je     1b42 <APPreJudge+0x19>
        return False;
    1b3b:	b8 00 00 00 00       	mov    $0x0,%eax
    1b40:	eb 05                	jmp    1b47 <APPreJudge+0x1e>
    return True;
    1b42:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1b47:	5d                   	pop    %ebp
    1b48:	c3                   	ret    

00001b49 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1b49:	55                   	push   %ebp
    1b4a:	89 e5                	mov    %esp,%ebp
    1b4c:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1b4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b52:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b55:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1b5b:	83 ec 0c             	sub    $0xc,%esp
    1b5e:	ff 75 08             	pushl  0x8(%ebp)
    1b61:	e8 ef ea ff ff       	call   655 <registWindow>
    1b66:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1b69:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1b70:	8b 45 08             	mov    0x8(%ebp),%eax
    1b73:	8b 00                	mov    (%eax),%eax
    1b75:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1b78:	ff 75 f4             	pushl  -0xc(%ebp)
    1b7b:	ff 75 f0             	pushl  -0x10(%ebp)
    1b7e:	ff 75 ec             	pushl  -0x14(%ebp)
    1b81:	ff 75 08             	pushl  0x8(%ebp)
    1b84:	e8 80 fc ff ff       	call   1809 <APSendMessage>
    1b89:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1b8c:	83 ec 0c             	sub    $0xc,%esp
    1b8f:	ff 75 08             	pushl  0x8(%ebp)
    1b92:	e8 b6 ea ff ff       	call   64d <getMessage>
    1b97:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1b9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9d:	83 c0 74             	add    $0x74,%eax
    1ba0:	83 ec 08             	sub    $0x8,%esp
    1ba3:	50                   	push   %eax
    1ba4:	ff 75 08             	pushl  0x8(%ebp)
    1ba7:	e8 7d ff ff ff       	call   1b29 <APPreJudge>
    1bac:	83 c4 10             	add    $0x10,%esp
    1baf:	84 c0                	test   %al,%al
    1bb1:	74 1b                	je     1bce <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1bb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb6:	ff 70 7c             	pushl  0x7c(%eax)
    1bb9:	ff 70 78             	pushl  0x78(%eax)
    1bbc:	ff 70 74             	pushl  0x74(%eax)
    1bbf:	ff 75 08             	pushl  0x8(%ebp)
    1bc2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bc5:	ff d0                	call   *%eax
    1bc7:	83 c4 10             	add    $0x10,%esp
    1bca:	84 c0                	test   %al,%al
    1bcc:	75 0c                	jne    1bda <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1bce:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd1:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1bd8:	eb b2                	jmp    1b8c <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1bda:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1bdb:	90                   	nop
    1bdc:	c9                   	leave  
    1bdd:	c3                   	ret    

00001bde <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1bde:	55                   	push   %ebp
    1bdf:	89 e5                	mov    %esp,%ebp
    1be1:	57                   	push   %edi
    1be2:	56                   	push   %esi
    1be3:	53                   	push   %ebx
    1be4:	83 ec 7c             	sub    $0x7c,%esp
    
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    1be7:	8d 45 88             	lea    -0x78(%ebp),%eax
    1bea:	6a 08                	push   $0x8
    1bec:	6a 08                	push   $0x8
    1bee:	6a 08                	push   $0x8
    1bf0:	50                   	push   %eax
    1bf1:	e8 ce fb ff ff       	call   17c4 <RGB>
    1bf6:	83 c4 0c             	add    $0xc,%esp
    1bf9:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1bfd:	66 89 45 bd          	mov    %ax,-0x43(%ebp)
    1c01:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1c05:	88 45 bf             	mov    %al,-0x41(%ebp)
    APSetFont(&wnd->TitleDc,font);
    1c08:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0b:	8d 58 58             	lea    0x58(%eax),%ebx
    1c0e:	8d 55 88             	lea    -0x78(%ebp),%edx
    1c11:	83 ec 04             	sub    $0x4,%esp
    1c14:	83 ec 04             	sub    $0x4,%esp
    1c17:	89 e0                	mov    %esp,%eax
    1c19:	0f b7 4d bd          	movzwl -0x43(%ebp),%ecx
    1c1d:	66 89 08             	mov    %cx,(%eax)
    1c20:	0f b6 4d bf          	movzbl -0x41(%ebp),%ecx
    1c24:	88 48 02             	mov    %cl,0x2(%eax)
    1c27:	53                   	push   %ebx
    1c28:	52                   	push   %edx
    1c29:	e8 fe f2 ff ff       	call   f2c <APSetFont>
    1c2e:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    1c31:	8b 45 08             	mov    0x8(%ebp),%eax
    1c34:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    1c3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3d:	83 c0 58             	add    $0x58,%eax
    1c40:	6a 14                	push   $0x14
    1c42:	6a 14                	push   $0x14
    1c44:	52                   	push   %edx
    1c45:	50                   	push   %eax
    1c46:	e8 ce f8 ff ff       	call   1519 <APDrawText>
    1c4b:	83 c4 10             	add    $0x10,%esp
    
    if (!iconReady)
    1c4e:	a1 c4 6b 00 00       	mov    0x6bc4,%eax
    1c53:	85 c0                	test   %eax,%eax
    1c55:	0f 85 7a 02 00 00    	jne    1ed5 <APGridPaint+0x2f7>
    {
        iconReady = 1;
    1c5b:	c7 05 c4 6b 00 00 01 	movl   $0x1,0x6bc4
    1c62:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1c65:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c68:	83 ec 08             	sub    $0x8,%esp
    1c6b:	68 6b 28 00 00       	push   $0x286b
    1c70:	50                   	push   %eax
    1c71:	e8 6c ef ff ff       	call   be2 <APLoadBitmap>
    1c76:	83 c4 0c             	add    $0xc,%esp
    1c79:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c7c:	a3 e8 6b 00 00       	mov    %eax,0x6be8
    1c81:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c84:	a3 ec 6b 00 00       	mov    %eax,0x6bec
    1c89:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c8c:	a3 f0 6b 00 00       	mov    %eax,0x6bf0
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1c91:	83 ec 04             	sub    $0x4,%esp
    1c94:	ff 35 f0 6b 00 00    	pushl  0x6bf0
    1c9a:	ff 35 ec 6b 00 00    	pushl  0x6bec
    1ca0:	ff 35 e8 6b 00 00    	pushl  0x6be8
    1ca6:	e8 71 f1 ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1cab:	83 c4 10             	add    $0x10,%esp
    1cae:	a3 f4 6b 00 00       	mov    %eax,0x6bf4
        grid_river = APLoadBitmap ("grid_river.bmp");
    1cb3:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cb6:	83 ec 08             	sub    $0x8,%esp
    1cb9:	68 79 28 00 00       	push   $0x2879
    1cbe:	50                   	push   %eax
    1cbf:	e8 1e ef ff ff       	call   be2 <APLoadBitmap>
    1cc4:	83 c4 0c             	add    $0xc,%esp
    1cc7:	8b 45 88             	mov    -0x78(%ebp),%eax
    1cca:	a3 30 6c 00 00       	mov    %eax,0x6c30
    1ccf:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1cd2:	a3 34 6c 00 00       	mov    %eax,0x6c34
    1cd7:	8b 45 90             	mov    -0x70(%ebp),%eax
    1cda:	a3 38 6c 00 00       	mov    %eax,0x6c38
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1cdf:	83 ec 04             	sub    $0x4,%esp
    1ce2:	ff 35 38 6c 00 00    	pushl  0x6c38
    1ce8:	ff 35 34 6c 00 00    	pushl  0x6c34
    1cee:	ff 35 30 6c 00 00    	pushl  0x6c30
    1cf4:	e8 23 f1 ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1cf9:	83 c4 10             	add    $0x10,%esp
    1cfc:	a3 20 6c 00 00       	mov    %eax,0x6c20
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1d01:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d04:	83 ec 08             	sub    $0x8,%esp
    1d07:	68 88 28 00 00       	push   $0x2888
    1d0c:	50                   	push   %eax
    1d0d:	e8 d0 ee ff ff       	call   be2 <APLoadBitmap>
    1d12:	83 c4 0c             	add    $0xc,%esp
    1d15:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d18:	a3 24 6c 00 00       	mov    %eax,0x6c24
    1d1d:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d20:	a3 28 6c 00 00       	mov    %eax,0x6c28
    1d25:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d28:	a3 2c 6c 00 00       	mov    %eax,0x6c2c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1d2d:	83 ec 04             	sub    $0x4,%esp
    1d30:	ff 35 2c 6c 00 00    	pushl  0x6c2c
    1d36:	ff 35 28 6c 00 00    	pushl  0x6c28
    1d3c:	ff 35 24 6c 00 00    	pushl  0x6c24
    1d42:	e8 d5 f0 ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1d47:	83 c4 10             	add    $0x10,%esp
    1d4a:	a3 c8 6b 00 00       	mov    %eax,0x6bc8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1d4f:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d52:	83 ec 08             	sub    $0x8,%esp
    1d55:	68 97 28 00 00       	push   $0x2897
    1d5a:	50                   	push   %eax
    1d5b:	e8 82 ee ff ff       	call   be2 <APLoadBitmap>
    1d60:	83 c4 0c             	add    $0xc,%esp
    1d63:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d66:	a3 fc 6b 00 00       	mov    %eax,0x6bfc
    1d6b:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d6e:	a3 00 6c 00 00       	mov    %eax,0x6c00
    1d73:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d76:	a3 04 6c 00 00       	mov    %eax,0x6c04
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1d7b:	83 ec 04             	sub    $0x4,%esp
    1d7e:	ff 35 04 6c 00 00    	pushl  0x6c04
    1d84:	ff 35 00 6c 00 00    	pushl  0x6c00
    1d8a:	ff 35 fc 6b 00 00    	pushl  0x6bfc
    1d90:	e8 87 f0 ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1d95:	83 c4 10             	add    $0x10,%esp
    1d98:	a3 40 6c 00 00       	mov    %eax,0x6c40
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1d9d:	8d 45 88             	lea    -0x78(%ebp),%eax
    1da0:	83 ec 08             	sub    $0x8,%esp
    1da3:	68 a5 28 00 00       	push   $0x28a5
    1da8:	50                   	push   %eax
    1da9:	e8 34 ee ff ff       	call   be2 <APLoadBitmap>
    1dae:	83 c4 0c             	add    $0xc,%esp
    1db1:	8b 45 88             	mov    -0x78(%ebp),%eax
    1db4:	a3 d8 6b 00 00       	mov    %eax,0x6bd8
    1db9:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1dbc:	a3 dc 6b 00 00       	mov    %eax,0x6bdc
    1dc1:	8b 45 90             	mov    -0x70(%ebp),%eax
    1dc4:	a3 e0 6b 00 00       	mov    %eax,0x6be0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1dc9:	83 ec 04             	sub    $0x4,%esp
    1dcc:	ff 35 e0 6b 00 00    	pushl  0x6be0
    1dd2:	ff 35 dc 6b 00 00    	pushl  0x6bdc
    1dd8:	ff 35 d8 6b 00 00    	pushl  0x6bd8
    1dde:	e8 39 f0 ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1de3:	83 c4 10             	add    $0x10,%esp
    1de6:	a3 f8 6b 00 00       	mov    %eax,0x6bf8
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1deb:	8d 45 88             	lea    -0x78(%ebp),%eax
    1dee:	83 ec 08             	sub    $0x8,%esp
    1df1:	68 b5 28 00 00       	push   $0x28b5
    1df6:	50                   	push   %eax
    1df7:	e8 e6 ed ff ff       	call   be2 <APLoadBitmap>
    1dfc:	83 c4 0c             	add    $0xc,%esp
    1dff:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e02:	a3 cc 6b 00 00       	mov    %eax,0x6bcc
    1e07:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1e0a:	a3 d0 6b 00 00       	mov    %eax,0x6bd0
    1e0f:	8b 45 90             	mov    -0x70(%ebp),%eax
    1e12:	a3 d4 6b 00 00       	mov    %eax,0x6bd4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1e17:	83 ec 04             	sub    $0x4,%esp
    1e1a:	ff 35 d4 6b 00 00    	pushl  0x6bd4
    1e20:	ff 35 d0 6b 00 00    	pushl  0x6bd0
    1e26:	ff 35 cc 6b 00 00    	pushl  0x6bcc
    1e2c:	e8 eb ef ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1e31:	83 c4 10             	add    $0x10,%esp
    1e34:	a3 e4 6b 00 00       	mov    %eax,0x6be4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1e39:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e3c:	83 ec 08             	sub    $0x8,%esp
    1e3f:	68 c7 28 00 00       	push   $0x28c7
    1e44:	50                   	push   %eax
    1e45:	e8 98 ed ff ff       	call   be2 <APLoadBitmap>
    1e4a:	83 c4 0c             	add    $0xc,%esp
    1e4d:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e50:	a3 14 6c 00 00       	mov    %eax,0x6c14
    1e55:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1e58:	a3 18 6c 00 00       	mov    %eax,0x6c18
    1e5d:	8b 45 90             	mov    -0x70(%ebp),%eax
    1e60:	a3 1c 6c 00 00       	mov    %eax,0x6c1c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1e65:	83 ec 04             	sub    $0x4,%esp
    1e68:	ff 35 1c 6c 00 00    	pushl  0x6c1c
    1e6e:	ff 35 18 6c 00 00    	pushl  0x6c18
    1e74:	ff 35 14 6c 00 00    	pushl  0x6c14
    1e7a:	e8 9d ef ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1e7f:	83 c4 10             	add    $0x10,%esp
    1e82:	a3 44 6c 00 00       	mov    %eax,0x6c44
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    1e87:	8d 45 88             	lea    -0x78(%ebp),%eax
    1e8a:	83 ec 08             	sub    $0x8,%esp
    1e8d:	68 d6 28 00 00       	push   $0x28d6
    1e92:	50                   	push   %eax
    1e93:	e8 4a ed ff ff       	call   be2 <APLoadBitmap>
    1e98:	83 c4 0c             	add    $0xc,%esp
    1e9b:	8b 45 88             	mov    -0x78(%ebp),%eax
    1e9e:	a3 08 6c 00 00       	mov    %eax,0x6c08
    1ea3:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ea6:	a3 0c 6c 00 00       	mov    %eax,0x6c0c
    1eab:	8b 45 90             	mov    -0x70(%ebp),%eax
    1eae:	a3 10 6c 00 00       	mov    %eax,0x6c10
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    1eb3:	83 ec 04             	sub    $0x4,%esp
    1eb6:	ff 35 10 6c 00 00    	pushl  0x6c10
    1ebc:	ff 35 0c 6c 00 00    	pushl  0x6c0c
    1ec2:	ff 35 08 6c 00 00    	pushl  0x6c08
    1ec8:	e8 4f ef ff ff       	call   e1c <APCreateCompatibleDCFromBitmap>
    1ecd:	83 c4 10             	add    $0x10,%esp
    1ed0:	a3 3c 6c 00 00       	mov    %eax,0x6c3c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1ed5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed8:	8b 40 08             	mov    0x8(%eax),%eax
    1edb:	85 c0                	test   %eax,%eax
    1edd:	75 17                	jne    1ef6 <APGridPaint+0x318>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1edf:	83 ec 08             	sub    $0x8,%esp
    1ee2:	68 e8 28 00 00       	push   $0x28e8
    1ee7:	6a 01                	push   $0x1
    1ee9:	e8 6e e8 ff ff       	call   75c <printf>
    1eee:	83 c4 10             	add    $0x10,%esp
        return;
    1ef1:	e9 fe 04 00 00       	jmp    23f4 <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1ef6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef9:	8b 40 10             	mov    0x10(%eax),%eax
    1efc:	85 c0                	test   %eax,%eax
    1efe:	7e 10                	jle    1f10 <APGridPaint+0x332>
    1f00:	8b 45 08             	mov    0x8(%ebp),%eax
    1f03:	8b 50 14             	mov    0x14(%eax),%edx
    1f06:	8b 45 08             	mov    0x8(%ebp),%eax
    1f09:	8b 40 10             	mov    0x10(%eax),%eax
    1f0c:	39 c2                	cmp    %eax,%edx
    1f0e:	7c 17                	jl     1f27 <APGridPaint+0x349>
    {
        printf(1,"Grid mode page error!");
    1f10:	83 ec 08             	sub    $0x8,%esp
    1f13:	68 0e 29 00 00       	push   $0x290e
    1f18:	6a 01                	push   $0x1
    1f1a:	e8 3d e8 ff ff       	call   75c <printf>
    1f1f:	83 c4 10             	add    $0x10,%esp
        return;
    1f22:	e9 cd 04 00 00       	jmp    23f4 <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1f27:	8b 45 08             	mov    0x8(%ebp),%eax
    1f2a:	8b 40 14             	mov    0x14(%eax),%eax
    1f2d:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1f33:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1f36:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1f39:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1f3c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1f43:	e9 f4 03 00 00       	jmp    233c <APGridPaint+0x75e>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1f48:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1f4f:	e9 da 03 00 00       	jmp    232e <APGridPaint+0x750>
        {
            index = start + GRID_W_NUMBER * j + i;
    1f54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f57:	c1 e0 04             	shl    $0x4,%eax
    1f5a:	89 c2                	mov    %eax,%edx
    1f5c:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1f5f:	01 c2                	add    %eax,%edx
    1f61:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f64:	01 d0                	add    %edx,%eax
    1f66:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1f69:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6c:	8b 40 0c             	mov    0xc(%eax),%eax
    1f6f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1f72:	c1 e2 02             	shl    $0x2,%edx
    1f75:	01 d0                	add    %edx,%eax
    1f77:	8b 00                	mov    (%eax),%eax
    1f79:	83 f8 0a             	cmp    $0xa,%eax
    1f7c:	0f 87 a7 03 00 00    	ja     2329 <APGridPaint+0x74b>
    1f82:	8b 04 85 24 29 00 00 	mov    0x2924(,%eax,4),%eax
    1f89:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f8b:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1f8e:	6a 0c                	push   $0xc
    1f90:	6a 0c                	push   $0xc
    1f92:	6a 0c                	push   $0xc
    1f94:	50                   	push   %eax
    1f95:	e8 2a f8 ff ff       	call   17c4 <RGB>
    1f9a:	83 c4 0c             	add    $0xc,%esp
    1f9d:	8b 1d f4 6b 00 00    	mov    0x6bf4,%ebx
    1fa3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fa6:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fa9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fac:	6b c0 32             	imul   $0x32,%eax,%eax
    1faf:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1fb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb5:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fb8:	83 ec 0c             	sub    $0xc,%esp
    1fbb:	83 ec 04             	sub    $0x4,%esp
    1fbe:	89 e0                	mov    %esp,%eax
    1fc0:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    1fc4:	66 89 30             	mov    %si,(%eax)
    1fc7:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    1fcb:	88 50 02             	mov    %dl,0x2(%eax)
    1fce:	6a 32                	push   $0x32
    1fd0:	6a 32                	push   $0x32
    1fd2:	6a 00                	push   $0x0
    1fd4:	6a 00                	push   $0x0
    1fd6:	53                   	push   %ebx
    1fd7:	51                   	push   %ecx
    1fd8:	ff 75 84             	pushl  -0x7c(%ebp)
    1fdb:	57                   	push   %edi
    1fdc:	e8 3f f6 ff ff       	call   1620 <APDcCopy>
    1fe1:	83 c4 30             	add    $0x30,%esp
                    break;
    1fe4:	e9 41 03 00 00       	jmp    232a <APGridPaint+0x74c>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1fe9:	8d 45 88             	lea    -0x78(%ebp),%eax
    1fec:	6a 69                	push   $0x69
    1fee:	6a 69                	push   $0x69
    1ff0:	6a 69                	push   $0x69
    1ff2:	50                   	push   %eax
    1ff3:	e8 cc f7 ff ff       	call   17c4 <RGB>
    1ff8:	83 c4 0c             	add    $0xc,%esp
    1ffb:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1fff:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    2003:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2007:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    200a:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    2011:	8d 45 88             	lea    -0x78(%ebp),%eax
    2014:	6a 69                	push   $0x69
    2016:	6a 69                	push   $0x69
    2018:	6a 69                	push   $0x69
    201a:	50                   	push   %eax
    201b:	e8 a4 f7 ff ff       	call   17c4 <RGB>
    2020:	83 c4 0c             	add    $0xc,%esp
    2023:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2027:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    202b:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    202f:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    2032:	8b 45 08             	mov    0x8(%ebp),%eax
    2035:	8d 50 3c             	lea    0x3c(%eax),%edx
    2038:	8d 45 88             	lea    -0x78(%ebp),%eax
    203b:	ff 75 ac             	pushl  -0x54(%ebp)
    203e:	ff 75 a8             	pushl  -0x58(%ebp)
    2041:	52                   	push   %edx
    2042:	50                   	push   %eax
    2043:	e8 69 ee ff ff       	call   eb1 <APSetPen>
    2048:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    204b:	8b 45 08             	mov    0x8(%ebp),%eax
    204e:	8d 58 3c             	lea    0x3c(%eax),%ebx
    2051:	8d 55 88             	lea    -0x78(%ebp),%edx
    2054:	83 ec 04             	sub    $0x4,%esp
    2057:	83 ec 04             	sub    $0x4,%esp
    205a:	89 e0                	mov    %esp,%eax
    205c:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    2060:	66 89 08             	mov    %cx,(%eax)
    2063:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    2067:	88 48 02             	mov    %cl,0x2(%eax)
    206a:	53                   	push   %ebx
    206b:	52                   	push   %edx
    206c:	e8 79 ee ff ff       	call   eea <APSetBrush>
    2071:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    2074:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2077:	6b d0 32             	imul   $0x32,%eax,%edx
    207a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    207d:	6b c0 32             	imul   $0x32,%eax,%eax
    2080:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2083:	83 c1 3c             	add    $0x3c,%ecx
    2086:	83 ec 0c             	sub    $0xc,%esp
    2089:	6a 32                	push   $0x32
    208b:	6a 32                	push   $0x32
    208d:	52                   	push   %edx
    208e:	50                   	push   %eax
    208f:	51                   	push   %ecx
    2090:	e8 7f f2 ff ff       	call   1314 <APDrawRect>
    2095:	83 c4 20             	add    $0x20,%esp
                    break;
    2098:	e9 8d 02 00 00       	jmp    232a <APGridPaint+0x74c>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    209d:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    20a0:	6a 0c                	push   $0xc
    20a2:	6a 0c                	push   $0xc
    20a4:	6a 0c                	push   $0xc
    20a6:	50                   	push   %eax
    20a7:	e8 18 f7 ff ff       	call   17c4 <RGB>
    20ac:	83 c4 0c             	add    $0xc,%esp
    20af:	8b 1d 44 6c 00 00    	mov    0x6c44,%ebx
    20b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20b8:	6b c8 32             	imul   $0x32,%eax,%ecx
    20bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20be:	6b c0 32             	imul   $0x32,%eax,%eax
    20c1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    20c4:	8b 45 08             	mov    0x8(%ebp),%eax
    20c7:	8d 78 3c             	lea    0x3c(%eax),%edi
    20ca:	83 ec 0c             	sub    $0xc,%esp
    20cd:	83 ec 04             	sub    $0x4,%esp
    20d0:	89 e0                	mov    %esp,%eax
    20d2:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    20d6:	66 89 30             	mov    %si,(%eax)
    20d9:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    20dd:	88 50 02             	mov    %dl,0x2(%eax)
    20e0:	6a 32                	push   $0x32
    20e2:	6a 32                	push   $0x32
    20e4:	6a 00                	push   $0x0
    20e6:	6a 00                	push   $0x0
    20e8:	53                   	push   %ebx
    20e9:	51                   	push   %ecx
    20ea:	ff 75 84             	pushl  -0x7c(%ebp)
    20ed:	57                   	push   %edi
    20ee:	e8 2d f5 ff ff       	call   1620 <APDcCopy>
    20f3:	83 c4 30             	add    $0x30,%esp
                    break;
    20f6:	e9 2f 02 00 00       	jmp    232a <APGridPaint+0x74c>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20fb:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    20fe:	6a 0c                	push   $0xc
    2100:	6a 0c                	push   $0xc
    2102:	6a 0c                	push   $0xc
    2104:	50                   	push   %eax
    2105:	e8 ba f6 ff ff       	call   17c4 <RGB>
    210a:	83 c4 0c             	add    $0xc,%esp
    210d:	8b 1d 20 6c 00 00    	mov    0x6c20,%ebx
    2113:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2116:	6b c8 32             	imul   $0x32,%eax,%ecx
    2119:	8b 45 e0             	mov    -0x20(%ebp),%eax
    211c:	6b c0 32             	imul   $0x32,%eax,%eax
    211f:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2122:	8b 45 08             	mov    0x8(%ebp),%eax
    2125:	8d 78 3c             	lea    0x3c(%eax),%edi
    2128:	83 ec 0c             	sub    $0xc,%esp
    212b:	83 ec 04             	sub    $0x4,%esp
    212e:	89 e0                	mov    %esp,%eax
    2130:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2134:	66 89 30             	mov    %si,(%eax)
    2137:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    213b:	88 50 02             	mov    %dl,0x2(%eax)
    213e:	6a 32                	push   $0x32
    2140:	6a 32                	push   $0x32
    2142:	6a 00                	push   $0x0
    2144:	6a 00                	push   $0x0
    2146:	53                   	push   %ebx
    2147:	51                   	push   %ecx
    2148:	ff 75 84             	pushl  -0x7c(%ebp)
    214b:	57                   	push   %edi
    214c:	e8 cf f4 ff ff       	call   1620 <APDcCopy>
    2151:	83 c4 30             	add    $0x30,%esp
                    break;
    2154:	e9 d1 01 00 00       	jmp    232a <APGridPaint+0x74c>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2159:	8d 45 c9             	lea    -0x37(%ebp),%eax
    215c:	6a 0c                	push   $0xc
    215e:	6a 0c                	push   $0xc
    2160:	6a 0c                	push   $0xc
    2162:	50                   	push   %eax
    2163:	e8 5c f6 ff ff       	call   17c4 <RGB>
    2168:	83 c4 0c             	add    $0xc,%esp
    216b:	8b 1d f8 6b 00 00    	mov    0x6bf8,%ebx
    2171:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2174:	6b c8 32             	imul   $0x32,%eax,%ecx
    2177:	8b 45 e0             	mov    -0x20(%ebp),%eax
    217a:	6b c0 32             	imul   $0x32,%eax,%eax
    217d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2180:	8b 45 08             	mov    0x8(%ebp),%eax
    2183:	8d 78 3c             	lea    0x3c(%eax),%edi
    2186:	83 ec 0c             	sub    $0xc,%esp
    2189:	83 ec 04             	sub    $0x4,%esp
    218c:	89 e0                	mov    %esp,%eax
    218e:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    2192:	66 89 30             	mov    %si,(%eax)
    2195:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2199:	88 50 02             	mov    %dl,0x2(%eax)
    219c:	6a 32                	push   $0x32
    219e:	6a 32                	push   $0x32
    21a0:	6a 00                	push   $0x0
    21a2:	6a 00                	push   $0x0
    21a4:	53                   	push   %ebx
    21a5:	51                   	push   %ecx
    21a6:	ff 75 84             	pushl  -0x7c(%ebp)
    21a9:	57                   	push   %edi
    21aa:	e8 71 f4 ff ff       	call   1620 <APDcCopy>
    21af:	83 c4 30             	add    $0x30,%esp
                    break;
    21b2:	e9 73 01 00 00       	jmp    232a <APGridPaint+0x74c>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    21b7:	8d 45 cc             	lea    -0x34(%ebp),%eax
    21ba:	6a 0c                	push   $0xc
    21bc:	6a 0c                	push   $0xc
    21be:	6a 0c                	push   $0xc
    21c0:	50                   	push   %eax
    21c1:	e8 fe f5 ff ff       	call   17c4 <RGB>
    21c6:	83 c4 0c             	add    $0xc,%esp
    21c9:	8b 1d 40 6c 00 00    	mov    0x6c40,%ebx
    21cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21d2:	6b c8 32             	imul   $0x32,%eax,%ecx
    21d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21d8:	6b c0 32             	imul   $0x32,%eax,%eax
    21db:	89 45 84             	mov    %eax,-0x7c(%ebp)
    21de:	8b 45 08             	mov    0x8(%ebp),%eax
    21e1:	8d 78 3c             	lea    0x3c(%eax),%edi
    21e4:	83 ec 0c             	sub    $0xc,%esp
    21e7:	83 ec 04             	sub    $0x4,%esp
    21ea:	89 e0                	mov    %esp,%eax
    21ec:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    21f0:	66 89 30             	mov    %si,(%eax)
    21f3:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    21f7:	88 50 02             	mov    %dl,0x2(%eax)
    21fa:	6a 32                	push   $0x32
    21fc:	6a 32                	push   $0x32
    21fe:	6a 00                	push   $0x0
    2200:	6a 00                	push   $0x0
    2202:	53                   	push   %ebx
    2203:	51                   	push   %ecx
    2204:	ff 75 84             	pushl  -0x7c(%ebp)
    2207:	57                   	push   %edi
    2208:	e8 13 f4 ff ff       	call   1620 <APDcCopy>
    220d:	83 c4 30             	add    $0x30,%esp
                    break;
    2210:	e9 15 01 00 00       	jmp    232a <APGridPaint+0x74c>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2215:	8d 45 cf             	lea    -0x31(%ebp),%eax
    2218:	6a 0c                	push   $0xc
    221a:	6a 0c                	push   $0xc
    221c:	6a 0c                	push   $0xc
    221e:	50                   	push   %eax
    221f:	e8 a0 f5 ff ff       	call   17c4 <RGB>
    2224:	83 c4 0c             	add    $0xc,%esp
    2227:	8b 1d c8 6b 00 00    	mov    0x6bc8,%ebx
    222d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2230:	6b c8 32             	imul   $0x32,%eax,%ecx
    2233:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2236:	6b c0 32             	imul   $0x32,%eax,%eax
    2239:	89 45 84             	mov    %eax,-0x7c(%ebp)
    223c:	8b 45 08             	mov    0x8(%ebp),%eax
    223f:	8d 78 3c             	lea    0x3c(%eax),%edi
    2242:	83 ec 0c             	sub    $0xc,%esp
    2245:	83 ec 04             	sub    $0x4,%esp
    2248:	89 e0                	mov    %esp,%eax
    224a:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    224e:	66 89 30             	mov    %si,(%eax)
    2251:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2255:	88 50 02             	mov    %dl,0x2(%eax)
    2258:	6a 32                	push   $0x32
    225a:	6a 32                	push   $0x32
    225c:	6a 00                	push   $0x0
    225e:	6a 00                	push   $0x0
    2260:	53                   	push   %ebx
    2261:	51                   	push   %ecx
    2262:	ff 75 84             	pushl  -0x7c(%ebp)
    2265:	57                   	push   %edi
    2266:	e8 b5 f3 ff ff       	call   1620 <APDcCopy>
    226b:	83 c4 30             	add    $0x30,%esp
                    break;
    226e:	e9 b7 00 00 00       	jmp    232a <APGridPaint+0x74c>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2273:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2276:	6a 0c                	push   $0xc
    2278:	6a 0c                	push   $0xc
    227a:	6a 0c                	push   $0xc
    227c:	50                   	push   %eax
    227d:	e8 42 f5 ff ff       	call   17c4 <RGB>
    2282:	83 c4 0c             	add    $0xc,%esp
    2285:	8b 1d e4 6b 00 00    	mov    0x6be4,%ebx
    228b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    228e:	6b c8 32             	imul   $0x32,%eax,%ecx
    2291:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2294:	6b c0 32             	imul   $0x32,%eax,%eax
    2297:	89 45 84             	mov    %eax,-0x7c(%ebp)
    229a:	8b 45 08             	mov    0x8(%ebp),%eax
    229d:	8d 78 3c             	lea    0x3c(%eax),%edi
    22a0:	83 ec 0c             	sub    $0xc,%esp
    22a3:	83 ec 04             	sub    $0x4,%esp
    22a6:	89 e0                	mov    %esp,%eax
    22a8:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    22ac:	66 89 30             	mov    %si,(%eax)
    22af:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    22b3:	88 50 02             	mov    %dl,0x2(%eax)
    22b6:	6a 32                	push   $0x32
    22b8:	6a 32                	push   $0x32
    22ba:	6a 00                	push   $0x0
    22bc:	6a 00                	push   $0x0
    22be:	53                   	push   %ebx
    22bf:	51                   	push   %ecx
    22c0:	ff 75 84             	pushl  -0x7c(%ebp)
    22c3:	57                   	push   %edi
    22c4:	e8 57 f3 ff ff       	call   1620 <APDcCopy>
    22c9:	83 c4 30             	add    $0x30,%esp
                    break;
    22cc:	eb 5c                	jmp    232a <APGridPaint+0x74c>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    22ce:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    22d1:	6a 0c                	push   $0xc
    22d3:	6a 0c                	push   $0xc
    22d5:	6a 0c                	push   $0xc
    22d7:	50                   	push   %eax
    22d8:	e8 e7 f4 ff ff       	call   17c4 <RGB>
    22dd:	83 c4 0c             	add    $0xc,%esp
    22e0:	8b 1d 3c 6c 00 00    	mov    0x6c3c,%ebx
    22e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22e9:	6b c8 32             	imul   $0x32,%eax,%ecx
    22ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
    22ef:	6b c0 32             	imul   $0x32,%eax,%eax
    22f2:	89 45 84             	mov    %eax,-0x7c(%ebp)
    22f5:	8b 45 08             	mov    0x8(%ebp),%eax
    22f8:	8d 78 3c             	lea    0x3c(%eax),%edi
    22fb:	83 ec 0c             	sub    $0xc,%esp
    22fe:	83 ec 04             	sub    $0x4,%esp
    2301:	89 e0                	mov    %esp,%eax
    2303:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2307:	66 89 30             	mov    %si,(%eax)
    230a:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    230e:	88 50 02             	mov    %dl,0x2(%eax)
    2311:	6a 32                	push   $0x32
    2313:	6a 32                	push   $0x32
    2315:	6a 00                	push   $0x0
    2317:	6a 00                	push   $0x0
    2319:	53                   	push   %ebx
    231a:	51                   	push   %ecx
    231b:	ff 75 84             	pushl  -0x7c(%ebp)
    231e:	57                   	push   %edi
    231f:	e8 fc f2 ff ff       	call   1620 <APDcCopy>
    2324:	83 c4 30             	add    $0x30,%esp
                    break;
    2327:	eb 01                	jmp    232a <APGridPaint+0x74c>
                default: break;
    2329:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    232a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    232e:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2332:	0f 8e 1c fc ff ff    	jle    1f54 <APGridPaint+0x376>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2338:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    233c:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2340:	0f 8e 02 fc ff ff    	jle    1f48 <APGridPaint+0x36a>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2346:	8d 45 88             	lea    -0x78(%ebp),%eax
    2349:	68 cd 00 00 00       	push   $0xcd
    234e:	6a 74                	push   $0x74
    2350:	6a 18                	push   $0x18
    2352:	50                   	push   %eax
    2353:	e8 6c f4 ff ff       	call   17c4 <RGB>
    2358:	83 c4 0c             	add    $0xc,%esp
    235b:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    235f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    2363:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2367:	88 45 b6             	mov    %al,-0x4a(%ebp)
    pen.size = 1;
    236a:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    2371:	8d 45 88             	lea    -0x78(%ebp),%eax
    2374:	68 cd 00 00 00       	push   $0xcd
    2379:	6a 74                	push   $0x74
    237b:	6a 18                	push   $0x18
    237d:	50                   	push   %eax
    237e:	e8 41 f4 ff ff       	call   17c4 <RGB>
    2383:	83 c4 0c             	add    $0xc,%esp
    2386:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    238a:	66 89 45 b1          	mov    %ax,-0x4f(%ebp)
    238e:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2392:	88 45 b3             	mov    %al,-0x4d(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2395:	8b 45 08             	mov    0x8(%ebp),%eax
    2398:	8d 50 58             	lea    0x58(%eax),%edx
    239b:	8d 45 88             	lea    -0x78(%ebp),%eax
    239e:	ff 75 b8             	pushl  -0x48(%ebp)
    23a1:	ff 75 b4             	pushl  -0x4c(%ebp)
    23a4:	52                   	push   %edx
    23a5:	50                   	push   %eax
    23a6:	e8 06 eb ff ff       	call   eb1 <APSetPen>
    23ab:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    23ae:	8b 45 08             	mov    0x8(%ebp),%eax
    23b1:	8d 58 58             	lea    0x58(%eax),%ebx
    23b4:	8d 55 88             	lea    -0x78(%ebp),%edx
    23b7:	83 ec 04             	sub    $0x4,%esp
    23ba:	83 ec 04             	sub    $0x4,%esp
    23bd:	89 e0                	mov    %esp,%eax
    23bf:	0f b7 4d b1          	movzwl -0x4f(%ebp),%ecx
    23c3:	66 89 08             	mov    %cx,(%eax)
    23c6:	0f b6 4d b3          	movzbl -0x4d(%ebp),%ecx
    23ca:	88 48 02             	mov    %cl,0x2(%eax)
    23cd:	53                   	push   %ebx
    23ce:	52                   	push   %edx
    23cf:	e8 16 eb ff ff       	call   eea <APSetBrush>
    23d4:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    23d7:	8b 45 08             	mov    0x8(%ebp),%eax
    23da:	83 c0 58             	add    $0x58,%eax
    23dd:	83 ec 0c             	sub    $0xc,%esp
    23e0:	6a 32                	push   $0x32
    23e2:	68 20 03 00 00       	push   $0x320
    23e7:	6a 00                	push   $0x0
    23e9:	6a 00                	push   $0x0
    23eb:	50                   	push   %eax
    23ec:	e8 23 ef ff ff       	call   1314 <APDrawRect>
    23f1:	83 c4 20             	add    $0x20,%esp
    
    
}
    23f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    23f7:	5b                   	pop    %ebx
    23f8:	5e                   	pop    %esi
    23f9:	5f                   	pop    %edi
    23fa:	5d                   	pop    %ebp
    23fb:	c3                   	ret    

000023fc <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    23fc:	55                   	push   %ebp
    23fd:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    23ff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2403:	7e 08                	jle    240d <random+0x11>
{
rand_num = seed;
    2405:	8b 45 08             	mov    0x8(%ebp),%eax
    2408:	a3 80 6b 00 00       	mov    %eax,0x6b80
}
rand_num *= 3;
    240d:	8b 15 80 6b 00 00    	mov    0x6b80,%edx
    2413:	89 d0                	mov    %edx,%eax
    2415:	01 c0                	add    %eax,%eax
    2417:	01 d0                	add    %edx,%eax
    2419:	a3 80 6b 00 00       	mov    %eax,0x6b80
if (rand_num < 0)
    241e:	a1 80 6b 00 00       	mov    0x6b80,%eax
    2423:	85 c0                	test   %eax,%eax
    2425:	79 0c                	jns    2433 <random+0x37>
{
rand_num *= (-1);
    2427:	a1 80 6b 00 00       	mov    0x6b80,%eax
    242c:	f7 d8                	neg    %eax
    242e:	a3 80 6b 00 00       	mov    %eax,0x6b80
}
return rand_num % 997;
    2433:	8b 0d 80 6b 00 00    	mov    0x6b80,%ecx
    2439:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    243e:	89 c8                	mov    %ecx,%eax
    2440:	f7 ea                	imul   %edx
    2442:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2445:	c1 f8 09             	sar    $0x9,%eax
    2448:	89 c2                	mov    %eax,%edx
    244a:	89 c8                	mov    %ecx,%eax
    244c:	c1 f8 1f             	sar    $0x1f,%eax
    244f:	29 c2                	sub    %eax,%edx
    2451:	89 d0                	mov    %edx,%eax
    2453:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    2459:	29 c1                	sub    %eax,%ecx
    245b:	89 c8                	mov    %ecx,%eax
}
    245d:	5d                   	pop    %ebp
    245e:	c3                   	ret    

0000245f <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    245f:	55                   	push   %ebp
    2460:	89 e5                	mov    %esp,%ebp
    2462:	53                   	push   %ebx
    2463:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2466:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    246d:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    2471:	74 17                	je     248a <sprintint+0x2b>
    2473:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2477:	79 11                	jns    248a <sprintint+0x2b>
        neg = 1;
    2479:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    2480:	8b 45 10             	mov    0x10(%ebp),%eax
    2483:	f7 d8                	neg    %eax
    2485:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2488:	eb 06                	jmp    2490 <sprintint+0x31>
    } else {
        x = xx;
    248a:	8b 45 10             	mov    0x10(%ebp),%eax
    248d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2490:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2497:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    249a:	8d 41 01             	lea    0x1(%ecx),%eax
    249d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    24a0:	8b 5d 14             	mov    0x14(%ebp),%ebx
    24a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24a6:	ba 00 00 00 00       	mov    $0x0,%edx
    24ab:	f7 f3                	div    %ebx
    24ad:	89 d0                	mov    %edx,%eax
    24af:	0f b6 80 84 6b 00 00 	movzbl 0x6b84(%eax),%eax
    24b6:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    24ba:	8b 5d 14             	mov    0x14(%ebp),%ebx
    24bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24c0:	ba 00 00 00 00       	mov    $0x0,%edx
    24c5:	f7 f3                	div    %ebx
    24c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    24ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    24ce:	75 c7                	jne    2497 <sprintint+0x38>
    if(neg)
    24d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24d4:	74 0e                	je     24e4 <sprintint+0x85>
        buf[i++] = '-';
    24d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    24d9:	8d 50 01             	lea    0x1(%eax),%edx
    24dc:	89 55 f8             	mov    %edx,-0x8(%ebp)
    24df:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    24e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    24e7:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    24ea:	eb 1b                	jmp    2507 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    24ec:	8b 45 0c             	mov    0xc(%ebp),%eax
    24ef:	8b 00                	mov    (%eax),%eax
    24f1:	8d 48 01             	lea    0x1(%eax),%ecx
    24f4:	8b 55 0c             	mov    0xc(%ebp),%edx
    24f7:	89 0a                	mov    %ecx,(%edx)
    24f9:	89 c2                	mov    %eax,%edx
    24fb:	8b 45 08             	mov    0x8(%ebp),%eax
    24fe:	01 d0                	add    %edx,%eax
    2500:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2503:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2507:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    250b:	7f df                	jg     24ec <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    250d:	eb 21                	jmp    2530 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    250f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2512:	8b 00                	mov    (%eax),%eax
    2514:	8d 48 01             	lea    0x1(%eax),%ecx
    2517:	8b 55 0c             	mov    0xc(%ebp),%edx
    251a:	89 0a                	mov    %ecx,(%edx)
    251c:	89 c2                	mov    %eax,%edx
    251e:	8b 45 08             	mov    0x8(%ebp),%eax
    2521:	01 c2                	add    %eax,%edx
    2523:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2526:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2529:	01 c8                	add    %ecx,%eax
    252b:	0f b6 00             	movzbl (%eax),%eax
    252e:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2530:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2534:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2538:	79 d5                	jns    250f <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    253a:	90                   	nop
    253b:	83 c4 20             	add    $0x20,%esp
    253e:	5b                   	pop    %ebx
    253f:	5d                   	pop    %ebp
    2540:	c3                   	ret    

00002541 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2541:	55                   	push   %ebp
    2542:	89 e5                	mov    %esp,%ebp
    2544:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2547:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    254e:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2555:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    255c:	8d 45 0c             	lea    0xc(%ebp),%eax
    255f:	83 c0 04             	add    $0x4,%eax
    2562:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2565:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    256c:	e9 d9 01 00 00       	jmp    274a <sprintf+0x209>
        c = fmt[i] & 0xff;
    2571:	8b 55 0c             	mov    0xc(%ebp),%edx
    2574:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2577:	01 d0                	add    %edx,%eax
    2579:	0f b6 00             	movzbl (%eax),%eax
    257c:	0f be c0             	movsbl %al,%eax
    257f:	25 ff 00 00 00       	and    $0xff,%eax
    2584:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2587:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    258b:	75 2c                	jne    25b9 <sprintf+0x78>
            if(c == '%'){
    258d:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2591:	75 0c                	jne    259f <sprintf+0x5e>
                state = '%';
    2593:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    259a:	e9 a7 01 00 00       	jmp    2746 <sprintf+0x205>
            } else {
                dst[j++] = c;
    259f:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25a2:	8d 50 01             	lea    0x1(%eax),%edx
    25a5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25a8:	89 c2                	mov    %eax,%edx
    25aa:	8b 45 08             	mov    0x8(%ebp),%eax
    25ad:	01 d0                	add    %edx,%eax
    25af:	8b 55 e0             	mov    -0x20(%ebp),%edx
    25b2:	88 10                	mov    %dl,(%eax)
    25b4:	e9 8d 01 00 00       	jmp    2746 <sprintf+0x205>
            }
        } else if(state == '%'){
    25b9:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    25bd:	0f 85 83 01 00 00    	jne    2746 <sprintf+0x205>
            if(c == 'd'){
    25c3:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    25c7:	75 4c                	jne    2615 <sprintf+0xd4>
                buf[bi] = '\0';
    25c9:	8d 55 ce             	lea    -0x32(%ebp),%edx
    25cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    25cf:	01 d0                	add    %edx,%eax
    25d1:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    25d4:	83 ec 0c             	sub    $0xc,%esp
    25d7:	8d 45 ce             	lea    -0x32(%ebp),%eax
    25da:	50                   	push   %eax
    25db:	e8 2b df ff ff       	call   50b <atoi>
    25e0:	83 c4 10             	add    $0x10,%esp
    25e3:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    25e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    25ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25f0:	8b 00                	mov    (%eax),%eax
    25f2:	83 ec 08             	sub    $0x8,%esp
    25f5:	ff 75 d8             	pushl  -0x28(%ebp)
    25f8:	6a 01                	push   $0x1
    25fa:	6a 0a                	push   $0xa
    25fc:	50                   	push   %eax
    25fd:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2600:	50                   	push   %eax
    2601:	ff 75 08             	pushl  0x8(%ebp)
    2604:	e8 56 fe ff ff       	call   245f <sprintint>
    2609:	83 c4 20             	add    $0x20,%esp
                ap++;
    260c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2610:	e9 2a 01 00 00       	jmp    273f <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2615:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2619:	74 06                	je     2621 <sprintf+0xe0>
    261b:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    261f:	75 4c                	jne    266d <sprintf+0x12c>
                buf[bi] = '\0';
    2621:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2624:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2627:	01 d0                	add    %edx,%eax
    2629:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    262c:	83 ec 0c             	sub    $0xc,%esp
    262f:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2632:	50                   	push   %eax
    2633:	e8 d3 de ff ff       	call   50b <atoi>
    2638:	83 c4 10             	add    $0x10,%esp
    263b:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    263e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2645:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2648:	8b 00                	mov    (%eax),%eax
    264a:	83 ec 08             	sub    $0x8,%esp
    264d:	ff 75 dc             	pushl  -0x24(%ebp)
    2650:	6a 00                	push   $0x0
    2652:	6a 10                	push   $0x10
    2654:	50                   	push   %eax
    2655:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2658:	50                   	push   %eax
    2659:	ff 75 08             	pushl  0x8(%ebp)
    265c:	e8 fe fd ff ff       	call   245f <sprintint>
    2661:	83 c4 20             	add    $0x20,%esp
                ap++;
    2664:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2668:	e9 d2 00 00 00       	jmp    273f <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    266d:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    2671:	75 46                	jne    26b9 <sprintf+0x178>
                s = (char*)*ap;
    2673:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2676:	8b 00                	mov    (%eax),%eax
    2678:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    267b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    267f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2683:	75 25                	jne    26aa <sprintf+0x169>
                    s = "(null)";
    2685:	c7 45 f4 50 29 00 00 	movl   $0x2950,-0xc(%ebp)
                while(*s != 0){
    268c:	eb 1c                	jmp    26aa <sprintf+0x169>
                    dst[j++] = *s;
    268e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2691:	8d 50 01             	lea    0x1(%eax),%edx
    2694:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2697:	89 c2                	mov    %eax,%edx
    2699:	8b 45 08             	mov    0x8(%ebp),%eax
    269c:	01 c2                	add    %eax,%edx
    269e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26a1:	0f b6 00             	movzbl (%eax),%eax
    26a4:	88 02                	mov    %al,(%edx)
                    s++;
    26a6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    26aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26ad:	0f b6 00             	movzbl (%eax),%eax
    26b0:	84 c0                	test   %al,%al
    26b2:	75 da                	jne    268e <sprintf+0x14d>
    26b4:	e9 86 00 00 00       	jmp    273f <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    26b9:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    26bd:	75 1d                	jne    26dc <sprintf+0x19b>
                dst[j++] = *ap;
    26bf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26c2:	8d 50 01             	lea    0x1(%eax),%edx
    26c5:	89 55 c8             	mov    %edx,-0x38(%ebp)
    26c8:	89 c2                	mov    %eax,%edx
    26ca:	8b 45 08             	mov    0x8(%ebp),%eax
    26cd:	01 c2                	add    %eax,%edx
    26cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26d2:	8b 00                	mov    (%eax),%eax
    26d4:	88 02                	mov    %al,(%edx)
                ap++;
    26d6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    26da:	eb 63                	jmp    273f <sprintf+0x1fe>
            } else if(c == '%'){
    26dc:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    26e0:	75 17                	jne    26f9 <sprintf+0x1b8>
                dst[j++] = c;
    26e2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26e5:	8d 50 01             	lea    0x1(%eax),%edx
    26e8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    26eb:	89 c2                	mov    %eax,%edx
    26ed:	8b 45 08             	mov    0x8(%ebp),%eax
    26f0:	01 d0                	add    %edx,%eax
    26f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
    26f5:	88 10                	mov    %dl,(%eax)
    26f7:	eb 46                	jmp    273f <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    26f9:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    26fd:	7e 18                	jle    2717 <sprintf+0x1d6>
    26ff:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2703:	7f 12                	jg     2717 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2705:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2708:	8d 50 01             	lea    0x1(%eax),%edx
    270b:	89 55 f0             	mov    %edx,-0x10(%ebp)
    270e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2711:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2715:	eb 2f                	jmp    2746 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2717:	8b 45 c8             	mov    -0x38(%ebp),%eax
    271a:	8d 50 01             	lea    0x1(%eax),%edx
    271d:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2720:	89 c2                	mov    %eax,%edx
    2722:	8b 45 08             	mov    0x8(%ebp),%eax
    2725:	01 d0                	add    %edx,%eax
    2727:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    272a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    272d:	8d 50 01             	lea    0x1(%eax),%edx
    2730:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2733:	89 c2                	mov    %eax,%edx
    2735:	8b 45 08             	mov    0x8(%ebp),%eax
    2738:	01 d0                	add    %edx,%eax
    273a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    273d:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    273f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2746:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    274a:	8b 55 0c             	mov    0xc(%ebp),%edx
    274d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2750:	01 d0                	add    %edx,%eax
    2752:	0f b6 00             	movzbl (%eax),%eax
    2755:	84 c0                	test   %al,%al
    2757:	0f 85 14 fe ff ff    	jne    2571 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    275d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2760:	8d 50 01             	lea    0x1(%eax),%edx
    2763:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2766:	89 c2                	mov    %eax,%edx
    2768:	8b 45 08             	mov    0x8(%ebp),%eax
    276b:	01 d0                	add    %edx,%eax
    276d:	c6 00 00             	movb   $0x0,(%eax)
}
    2770:	90                   	nop
    2771:	c9                   	leave  
    2772:	c3                   	ret    
