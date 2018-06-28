
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
      49:	83 f8 0d             	cmp    $0xd,%eax
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
      68:	68 64 2b 00 00       	push   $0x2b64
      6d:	e8 e6 04 00 00       	call   558 <memmove>
      72:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      75:	83 ec 0c             	sub    $0xc,%esp
      78:	ff 75 f4             	pushl  -0xc(%ebp)
      7b:	e8 5b 03 00 00       	call   3db <strlen>
      80:	83 c4 10             	add    $0x10,%esp
      83:	ba 0e 00 00 00       	mov    $0xe,%edx
      88:	89 d3                	mov    %edx,%ebx
      8a:	29 c3                	sub    %eax,%ebx
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	ff 75 f4             	pushl  -0xc(%ebp)
      92:	e8 44 03 00 00       	call   3db <strlen>
      97:	83 c4 10             	add    $0x10,%esp
      9a:	05 64 2b 00 00       	add    $0x2b64,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 64 2b 00 00       	mov    $0x2b64,%eax
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
      be:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
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
      e3:	68 ec 23 00 00       	push   $0x23ec
      e8:	6a 02                	push   $0x2
      ea:	e8 55 06 00 00       	call   744 <printf>
      ef:	83 c4 10             	add    $0x10,%esp
    return;
      f2:	e9 e3 01 00 00       	jmp    2da <ls+0x222>
  }
  
  if(fstat(fd, &st) < 0){
      f7:	83 ec 08             	sub    $0x8,%esp
      fa:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
     100:	50                   	push   %eax
     101:	ff 75 e4             	pushl  -0x1c(%ebp)
     104:	e8 ec 04 00 00       	call   5f5 <fstat>
     109:	83 c4 10             	add    $0x10,%esp
     10c:	85 c0                	test   %eax,%eax
     10e:	79 28                	jns    138 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
     110:	83 ec 04             	sub    $0x4,%esp
     113:	ff 75 08             	pushl  0x8(%ebp)
     116:	68 00 24 00 00       	push   $0x2400
     11b:	6a 02                	push   $0x2
     11d:	e8 22 06 00 00       	call   744 <printf>
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
     138:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     13f:	98                   	cwtl   
     140:	83 f8 01             	cmp    $0x1,%eax
     143:	74 48                	je     18d <ls+0xd5>
     145:	83 f8 02             	cmp    $0x2,%eax
     148:	0f 85 7e 01 00 00    	jne    2cc <ls+0x214>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
     14e:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     154:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     15a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
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
     179:	68 14 24 00 00       	push   $0x2414
     17e:	6a 01                	push   $0x1
     180:	e8 bf 05 00 00       	call   744 <printf>
     185:	83 c4 20             	add    $0x20,%esp
    break;
     188:	e9 3f 01 00 00       	jmp    2cc <ls+0x214>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     18d:	83 ec 0c             	sub    $0xc,%esp
     190:	ff 75 08             	pushl  0x8(%ebp)
     193:	e8 43 02 00 00       	call   3db <strlen>
     198:	83 c4 10             	add    $0x10,%esp
     19b:	83 c0 10             	add    $0x10,%eax
     19e:	3d 00 02 00 00       	cmp    $0x200,%eax
     1a3:	76 17                	jbe    1bc <ls+0x104>
      printf(1, "ls: path too long\n");
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 21 24 00 00       	push   $0x2421
     1ad:	6a 01                	push   $0x1
     1af:	e8 90 05 00 00       	call   744 <printf>
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
     201:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
     208:	66 85 c0             	test   %ax,%ax
     20b:	75 05                	jne    212 <ls+0x15a>
        continue;
     20d:	e9 99 00 00 00       	jmp    2ab <ls+0x1f3>
      memmove(p, de.name, DIRSIZ);
     212:	83 ec 04             	sub    $0x4,%esp
     215:	6a 0e                	push   $0xe
     217:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     21d:	83 c0 02             	add    $0x2,%eax
     220:	50                   	push   %eax
     221:	ff 75 e0             	pushl  -0x20(%ebp)
     224:	e8 2f 03 00 00       	call   558 <memmove>
     229:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
     22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     22f:	83 c0 0e             	add    $0xe,%eax
     232:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
     235:	83 ec 08             	sub    $0x8,%esp
     238:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
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
     25c:	68 00 24 00 00       	push   $0x2400
     261:	6a 01                	push   $0x1
     263:	e8 dc 04 00 00       	call   744 <printf>
     268:	83 c4 10             	add    $0x10,%esp
        continue;
     26b:	eb 3e                	jmp    2ab <ls+0x1f3>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     26d:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     273:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     279:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
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
     29c:	68 14 24 00 00       	push   $0x2414
     2a1:	6a 01                	push   $0x1
     2a3:	e8 9c 04 00 00       	call   744 <printf>
     2a8:	83 c4 20             	add    $0x20,%esp
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2ab:	83 ec 04             	sub    $0x4,%esp
     2ae:	6a 10                	push   $0x10
     2b0:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     2b6:	50                   	push   %eax
     2b7:	ff 75 e4             	pushl  -0x1c(%ebp)
     2ba:	e8 f6 02 00 00       	call   5b5 <read>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	83 f8 10             	cmp    $0x10,%eax
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
     2fe:	68 34 24 00 00       	push   $0x2434
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

00000645 <initStringFigure>:
SYSCALL(initStringFigure)
     645:	b8 17 00 00 00       	mov    $0x17,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <sendMessage>:
SYSCALL(sendMessage)
     64d:	b8 18 00 00 00       	mov    $0x18,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <getMessage>:
SYSCALL(getMessage)
     655:	b8 1a 00 00 00       	mov    $0x1a,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <registWindow>:
SYSCALL(registWindow)
     65d:	b8 19 00 00 00       	mov    $0x19,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <changePosition>:
SYSCALL(changePosition)
     665:	b8 1b 00 00 00       	mov    $0x1b,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     66d:	55                   	push   %ebp
     66e:	89 e5                	mov    %esp,%ebp
     670:	83 ec 18             	sub    $0x18,%esp
     673:	8b 45 0c             	mov    0xc(%ebp),%eax
     676:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     679:	83 ec 04             	sub    $0x4,%esp
     67c:	6a 01                	push   $0x1
     67e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     681:	50                   	push   %eax
     682:	ff 75 08             	pushl  0x8(%ebp)
     685:	e8 33 ff ff ff       	call   5bd <write>
     68a:	83 c4 10             	add    $0x10,%esp
}
     68d:	90                   	nop
     68e:	c9                   	leave  
     68f:	c3                   	ret    

00000690 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	53                   	push   %ebx
     694:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     697:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     69e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6a2:	74 17                	je     6bb <printint+0x2b>
     6a4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6a8:	79 11                	jns    6bb <printint+0x2b>
    neg = 1;
     6aa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6b1:	8b 45 0c             	mov    0xc(%ebp),%eax
     6b4:	f7 d8                	neg    %eax
     6b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6b9:	eb 06                	jmp    6c1 <printint+0x31>
  } else {
    x = xx;
     6bb:	8b 45 0c             	mov    0xc(%ebp),%eax
     6be:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6c8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6cb:	8d 41 01             	lea    0x1(%ecx),%eax
     6ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6d1:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6d7:	ba 00 00 00 00       	mov    $0x0,%edx
     6dc:	f7 f3                	div    %ebx
     6de:	89 d0                	mov    %edx,%eax
     6e0:	0f b6 80 38 2b 00 00 	movzbl 0x2b38(%eax),%eax
     6e7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     6eb:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6f1:	ba 00 00 00 00       	mov    $0x0,%edx
     6f6:	f7 f3                	div    %ebx
     6f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6ff:	75 c7                	jne    6c8 <printint+0x38>
  if(neg)
     701:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     705:	74 2d                	je     734 <printint+0xa4>
    buf[i++] = '-';
     707:	8b 45 f4             	mov    -0xc(%ebp),%eax
     70a:	8d 50 01             	lea    0x1(%eax),%edx
     70d:	89 55 f4             	mov    %edx,-0xc(%ebp)
     710:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     715:	eb 1d                	jmp    734 <printint+0xa4>
    putc(fd, buf[i]);
     717:	8d 55 dc             	lea    -0x24(%ebp),%edx
     71a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71d:	01 d0                	add    %edx,%eax
     71f:	0f b6 00             	movzbl (%eax),%eax
     722:	0f be c0             	movsbl %al,%eax
     725:	83 ec 08             	sub    $0x8,%esp
     728:	50                   	push   %eax
     729:	ff 75 08             	pushl  0x8(%ebp)
     72c:	e8 3c ff ff ff       	call   66d <putc>
     731:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     734:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     738:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     73c:	79 d9                	jns    717 <printint+0x87>
    putc(fd, buf[i]);
}
     73e:	90                   	nop
     73f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     742:	c9                   	leave  
     743:	c3                   	ret    

00000744 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     744:	55                   	push   %ebp
     745:	89 e5                	mov    %esp,%ebp
     747:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     74a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     751:	8d 45 0c             	lea    0xc(%ebp),%eax
     754:	83 c0 04             	add    $0x4,%eax
     757:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     75a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     761:	e9 59 01 00 00       	jmp    8bf <printf+0x17b>
    c = fmt[i] & 0xff;
     766:	8b 55 0c             	mov    0xc(%ebp),%edx
     769:	8b 45 f0             	mov    -0x10(%ebp),%eax
     76c:	01 d0                	add    %edx,%eax
     76e:	0f b6 00             	movzbl (%eax),%eax
     771:	0f be c0             	movsbl %al,%eax
     774:	25 ff 00 00 00       	and    $0xff,%eax
     779:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     77c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     780:	75 2c                	jne    7ae <printf+0x6a>
      if(c == '%'){
     782:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     786:	75 0c                	jne    794 <printf+0x50>
        state = '%';
     788:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     78f:	e9 27 01 00 00       	jmp    8bb <printf+0x177>
      } else {
        putc(fd, c);
     794:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     797:	0f be c0             	movsbl %al,%eax
     79a:	83 ec 08             	sub    $0x8,%esp
     79d:	50                   	push   %eax
     79e:	ff 75 08             	pushl  0x8(%ebp)
     7a1:	e8 c7 fe ff ff       	call   66d <putc>
     7a6:	83 c4 10             	add    $0x10,%esp
     7a9:	e9 0d 01 00 00       	jmp    8bb <printf+0x177>
      }
    } else if(state == '%'){
     7ae:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7b2:	0f 85 03 01 00 00    	jne    8bb <printf+0x177>
      if(c == 'd'){
     7b8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7bc:	75 1e                	jne    7dc <printf+0x98>
        printint(fd, *ap, 10, 1);
     7be:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7c1:	8b 00                	mov    (%eax),%eax
     7c3:	6a 01                	push   $0x1
     7c5:	6a 0a                	push   $0xa
     7c7:	50                   	push   %eax
     7c8:	ff 75 08             	pushl  0x8(%ebp)
     7cb:	e8 c0 fe ff ff       	call   690 <printint>
     7d0:	83 c4 10             	add    $0x10,%esp
        ap++;
     7d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7d7:	e9 d8 00 00 00       	jmp    8b4 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7dc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7e0:	74 06                	je     7e8 <printf+0xa4>
     7e2:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7e6:	75 1e                	jne    806 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7eb:	8b 00                	mov    (%eax),%eax
     7ed:	6a 00                	push   $0x0
     7ef:	6a 10                	push   $0x10
     7f1:	50                   	push   %eax
     7f2:	ff 75 08             	pushl  0x8(%ebp)
     7f5:	e8 96 fe ff ff       	call   690 <printint>
     7fa:	83 c4 10             	add    $0x10,%esp
        ap++;
     7fd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     801:	e9 ae 00 00 00       	jmp    8b4 <printf+0x170>
      } else if(c == 's'){
     806:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     80a:	75 43                	jne    84f <printf+0x10b>
        s = (char*)*ap;
     80c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     80f:	8b 00                	mov    (%eax),%eax
     811:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     814:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     818:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     81c:	75 25                	jne    843 <printf+0xff>
          s = "(null)";
     81e:	c7 45 f4 36 24 00 00 	movl   $0x2436,-0xc(%ebp)
        while(*s != 0){
     825:	eb 1c                	jmp    843 <printf+0xff>
          putc(fd, *s);
     827:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82a:	0f b6 00             	movzbl (%eax),%eax
     82d:	0f be c0             	movsbl %al,%eax
     830:	83 ec 08             	sub    $0x8,%esp
     833:	50                   	push   %eax
     834:	ff 75 08             	pushl  0x8(%ebp)
     837:	e8 31 fe ff ff       	call   66d <putc>
     83c:	83 c4 10             	add    $0x10,%esp
          s++;
     83f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     843:	8b 45 f4             	mov    -0xc(%ebp),%eax
     846:	0f b6 00             	movzbl (%eax),%eax
     849:	84 c0                	test   %al,%al
     84b:	75 da                	jne    827 <printf+0xe3>
     84d:	eb 65                	jmp    8b4 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     84f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     853:	75 1d                	jne    872 <printf+0x12e>
        putc(fd, *ap);
     855:	8b 45 e8             	mov    -0x18(%ebp),%eax
     858:	8b 00                	mov    (%eax),%eax
     85a:	0f be c0             	movsbl %al,%eax
     85d:	83 ec 08             	sub    $0x8,%esp
     860:	50                   	push   %eax
     861:	ff 75 08             	pushl  0x8(%ebp)
     864:	e8 04 fe ff ff       	call   66d <putc>
     869:	83 c4 10             	add    $0x10,%esp
        ap++;
     86c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     870:	eb 42                	jmp    8b4 <printf+0x170>
      } else if(c == '%'){
     872:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     876:	75 17                	jne    88f <printf+0x14b>
        putc(fd, c);
     878:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     87b:	0f be c0             	movsbl %al,%eax
     87e:	83 ec 08             	sub    $0x8,%esp
     881:	50                   	push   %eax
     882:	ff 75 08             	pushl  0x8(%ebp)
     885:	e8 e3 fd ff ff       	call   66d <putc>
     88a:	83 c4 10             	add    $0x10,%esp
     88d:	eb 25                	jmp    8b4 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     88f:	83 ec 08             	sub    $0x8,%esp
     892:	6a 25                	push   $0x25
     894:	ff 75 08             	pushl  0x8(%ebp)
     897:	e8 d1 fd ff ff       	call   66d <putc>
     89c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     89f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8a2:	0f be c0             	movsbl %al,%eax
     8a5:	83 ec 08             	sub    $0x8,%esp
     8a8:	50                   	push   %eax
     8a9:	ff 75 08             	pushl  0x8(%ebp)
     8ac:	e8 bc fd ff ff       	call   66d <putc>
     8b1:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8bb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8bf:	8b 55 0c             	mov    0xc(%ebp),%edx
     8c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c5:	01 d0                	add    %edx,%eax
     8c7:	0f b6 00             	movzbl (%eax),%eax
     8ca:	84 c0                	test   %al,%al
     8cc:	0f 85 94 fe ff ff    	jne    766 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8d2:	90                   	nop
     8d3:	c9                   	leave  
     8d4:	c3                   	ret    

000008d5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8d5:	55                   	push   %ebp
     8d6:	89 e5                	mov    %esp,%ebp
     8d8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8db:	8b 45 08             	mov    0x8(%ebp),%eax
     8de:	83 e8 08             	sub    $0x8,%eax
     8e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8e4:	a1 7c 2b 00 00       	mov    0x2b7c,%eax
     8e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8ec:	eb 24                	jmp    912 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f1:	8b 00                	mov    (%eax),%eax
     8f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8f6:	77 12                	ja     90a <free+0x35>
     8f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8fe:	77 24                	ja     924 <free+0x4f>
     900:	8b 45 fc             	mov    -0x4(%ebp),%eax
     903:	8b 00                	mov    (%eax),%eax
     905:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     908:	77 1a                	ja     924 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     90a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90d:	8b 00                	mov    (%eax),%eax
     90f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     912:	8b 45 f8             	mov    -0x8(%ebp),%eax
     915:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     918:	76 d4                	jbe    8ee <free+0x19>
     91a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91d:	8b 00                	mov    (%eax),%eax
     91f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     922:	76 ca                	jbe    8ee <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     924:	8b 45 f8             	mov    -0x8(%ebp),%eax
     927:	8b 40 04             	mov    0x4(%eax),%eax
     92a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     931:	8b 45 f8             	mov    -0x8(%ebp),%eax
     934:	01 c2                	add    %eax,%edx
     936:	8b 45 fc             	mov    -0x4(%ebp),%eax
     939:	8b 00                	mov    (%eax),%eax
     93b:	39 c2                	cmp    %eax,%edx
     93d:	75 24                	jne    963 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     93f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     942:	8b 50 04             	mov    0x4(%eax),%edx
     945:	8b 45 fc             	mov    -0x4(%ebp),%eax
     948:	8b 00                	mov    (%eax),%eax
     94a:	8b 40 04             	mov    0x4(%eax),%eax
     94d:	01 c2                	add    %eax,%edx
     94f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     952:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     955:	8b 45 fc             	mov    -0x4(%ebp),%eax
     958:	8b 00                	mov    (%eax),%eax
     95a:	8b 10                	mov    (%eax),%edx
     95c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95f:	89 10                	mov    %edx,(%eax)
     961:	eb 0a                	jmp    96d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     963:	8b 45 fc             	mov    -0x4(%ebp),%eax
     966:	8b 10                	mov    (%eax),%edx
     968:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     96d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     970:	8b 40 04             	mov    0x4(%eax),%eax
     973:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     97a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97d:	01 d0                	add    %edx,%eax
     97f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     982:	75 20                	jne    9a4 <free+0xcf>
    p->s.size += bp->s.size;
     984:	8b 45 fc             	mov    -0x4(%ebp),%eax
     987:	8b 50 04             	mov    0x4(%eax),%edx
     98a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     98d:	8b 40 04             	mov    0x4(%eax),%eax
     990:	01 c2                	add    %eax,%edx
     992:	8b 45 fc             	mov    -0x4(%ebp),%eax
     995:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     998:	8b 45 f8             	mov    -0x8(%ebp),%eax
     99b:	8b 10                	mov    (%eax),%edx
     99d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a0:	89 10                	mov    %edx,(%eax)
     9a2:	eb 08                	jmp    9ac <free+0xd7>
  } else
    p->s.ptr = bp;
     9a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9aa:	89 10                	mov    %edx,(%eax)
  freep = p;
     9ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9af:	a3 7c 2b 00 00       	mov    %eax,0x2b7c
}
     9b4:	90                   	nop
     9b5:	c9                   	leave  
     9b6:	c3                   	ret    

000009b7 <morecore>:

static Header*
morecore(uint nu)
{
     9b7:	55                   	push   %ebp
     9b8:	89 e5                	mov    %esp,%ebp
     9ba:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9bd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9c4:	77 07                	ja     9cd <morecore+0x16>
    nu = 4096;
     9c6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9cd:	8b 45 08             	mov    0x8(%ebp),%eax
     9d0:	c1 e0 03             	shl    $0x3,%eax
     9d3:	83 ec 0c             	sub    $0xc,%esp
     9d6:	50                   	push   %eax
     9d7:	e8 49 fc ff ff       	call   625 <sbrk>
     9dc:	83 c4 10             	add    $0x10,%esp
     9df:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9e2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9e6:	75 07                	jne    9ef <morecore+0x38>
    return 0;
     9e8:	b8 00 00 00 00       	mov    $0x0,%eax
     9ed:	eb 26                	jmp    a15 <morecore+0x5e>
  hp = (Header*)p;
     9ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f8:	8b 55 08             	mov    0x8(%ebp),%edx
     9fb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a01:	83 c0 08             	add    $0x8,%eax
     a04:	83 ec 0c             	sub    $0xc,%esp
     a07:	50                   	push   %eax
     a08:	e8 c8 fe ff ff       	call   8d5 <free>
     a0d:	83 c4 10             	add    $0x10,%esp
  return freep;
     a10:	a1 7c 2b 00 00       	mov    0x2b7c,%eax
}
     a15:	c9                   	leave  
     a16:	c3                   	ret    

00000a17 <malloc>:

void*
malloc(uint nbytes)
{
     a17:	55                   	push   %ebp
     a18:	89 e5                	mov    %esp,%ebp
     a1a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a1d:	8b 45 08             	mov    0x8(%ebp),%eax
     a20:	83 c0 07             	add    $0x7,%eax
     a23:	c1 e8 03             	shr    $0x3,%eax
     a26:	83 c0 01             	add    $0x1,%eax
     a29:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a2c:	a1 7c 2b 00 00       	mov    0x2b7c,%eax
     a31:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a34:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a38:	75 23                	jne    a5d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a3a:	c7 45 f0 74 2b 00 00 	movl   $0x2b74,-0x10(%ebp)
     a41:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a44:	a3 7c 2b 00 00       	mov    %eax,0x2b7c
     a49:	a1 7c 2b 00 00       	mov    0x2b7c,%eax
     a4e:	a3 74 2b 00 00       	mov    %eax,0x2b74
    base.s.size = 0;
     a53:	c7 05 78 2b 00 00 00 	movl   $0x0,0x2b78
     a5a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a60:	8b 00                	mov    (%eax),%eax
     a62:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a68:	8b 40 04             	mov    0x4(%eax),%eax
     a6b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a6e:	72 4d                	jb     abd <malloc+0xa6>
      if(p->s.size == nunits)
     a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a73:	8b 40 04             	mov    0x4(%eax),%eax
     a76:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a79:	75 0c                	jne    a87 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7e:	8b 10                	mov    (%eax),%edx
     a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a83:	89 10                	mov    %edx,(%eax)
     a85:	eb 26                	jmp    aad <malloc+0x96>
      else {
        p->s.size -= nunits;
     a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8a:	8b 40 04             	mov    0x4(%eax),%eax
     a8d:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a90:	89 c2                	mov    %eax,%edx
     a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a95:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9b:	8b 40 04             	mov    0x4(%eax),%eax
     a9e:	c1 e0 03             	shl    $0x3,%eax
     aa1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa7:	8b 55 ec             	mov    -0x14(%ebp),%edx
     aaa:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab0:	a3 7c 2b 00 00       	mov    %eax,0x2b7c
      return (void*)(p + 1);
     ab5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab8:	83 c0 08             	add    $0x8,%eax
     abb:	eb 3b                	jmp    af8 <malloc+0xe1>
    }
    if(p == freep)
     abd:	a1 7c 2b 00 00       	mov    0x2b7c,%eax
     ac2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ac5:	75 1e                	jne    ae5 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     ac7:	83 ec 0c             	sub    $0xc,%esp
     aca:	ff 75 ec             	pushl  -0x14(%ebp)
     acd:	e8 e5 fe ff ff       	call   9b7 <morecore>
     ad2:	83 c4 10             	add    $0x10,%esp
     ad5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ad8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     adc:	75 07                	jne    ae5 <malloc+0xce>
        return 0;
     ade:	b8 00 00 00 00       	mov    $0x0,%eax
     ae3:	eb 13                	jmp    af8 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae8:	89 45 f0             	mov    %eax,-0x10(%ebp)
     aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aee:	8b 00                	mov    (%eax),%eax
     af0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     af3:	e9 6d ff ff ff       	jmp    a65 <malloc+0x4e>
}
     af8:	c9                   	leave  
     af9:	c3                   	ret    

00000afa <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     afa:	55                   	push   %ebp
     afb:	89 e5                	mov    %esp,%ebp
     afd:	83 ec 1c             	sub    $0x1c,%esp
     b00:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b03:	8b 55 10             	mov    0x10(%ebp),%edx
     b06:	8b 45 14             	mov    0x14(%ebp),%eax
     b09:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b0c:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b0f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b12:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b16:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b19:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b1d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b20:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b24:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b27:	8b 45 08             	mov    0x8(%ebp),%eax
     b2a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b2e:	66 89 10             	mov    %dx,(%eax)
     b31:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b35:	88 50 02             	mov    %dl,0x2(%eax)
}
     b38:	8b 45 08             	mov    0x8(%ebp),%eax
     b3b:	c9                   	leave  
     b3c:	c2 04 00             	ret    $0x4

00000b3f <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b3f:	55                   	push   %ebp
     b40:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b42:	8b 45 08             	mov    0x8(%ebp),%eax
     b45:	2b 45 10             	sub    0x10(%ebp),%eax
     b48:	89 c2                	mov    %eax,%edx
     b4a:	8b 45 08             	mov    0x8(%ebp),%eax
     b4d:	2b 45 10             	sub    0x10(%ebp),%eax
     b50:	0f af d0             	imul   %eax,%edx
     b53:	8b 45 0c             	mov    0xc(%ebp),%eax
     b56:	2b 45 14             	sub    0x14(%ebp),%eax
     b59:	89 c1                	mov    %eax,%ecx
     b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b5e:	2b 45 14             	sub    0x14(%ebp),%eax
     b61:	0f af c1             	imul   %ecx,%eax
     b64:	01 d0                	add    %edx,%eax
}
     b66:	5d                   	pop    %ebp
     b67:	c3                   	ret    

00000b68 <abs_int>:

static inline int abs_int(int x)
{
     b68:	55                   	push   %ebp
     b69:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b6b:	8b 45 08             	mov    0x8(%ebp),%eax
     b6e:	99                   	cltd   
     b6f:	89 d0                	mov    %edx,%eax
     b71:	33 45 08             	xor    0x8(%ebp),%eax
     b74:	29 d0                	sub    %edx,%eax
}
     b76:	5d                   	pop    %ebp
     b77:	c3                   	ret    

00000b78 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b78:	55                   	push   %ebp
     b79:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b7b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b7f:	79 07                	jns    b88 <APGetIndex+0x10>
        return X_SMALLER;
     b81:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b86:	eb 40                	jmp    bc8 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     b88:	8b 45 08             	mov    0x8(%ebp),%eax
     b8b:	8b 00                	mov    (%eax),%eax
     b8d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     b90:	7f 07                	jg     b99 <APGetIndex+0x21>
        return X_BIGGER;
     b92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b97:	eb 2f                	jmp    bc8 <APGetIndex+0x50>
    if (y < 0)
     b99:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     b9d:	79 07                	jns    ba6 <APGetIndex+0x2e>
        return Y_SMALLER;
     b9f:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     ba4:	eb 22                	jmp    bc8 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     ba6:	8b 45 08             	mov    0x8(%ebp),%eax
     ba9:	8b 40 04             	mov    0x4(%eax),%eax
     bac:	3b 45 10             	cmp    0x10(%ebp),%eax
     baf:	7f 07                	jg     bb8 <APGetIndex+0x40>
        return Y_BIGGER;
     bb1:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     bb6:	eb 10                	jmp    bc8 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     bb8:	8b 45 08             	mov    0x8(%ebp),%eax
     bbb:	8b 00                	mov    (%eax),%eax
     bbd:	0f af 45 10          	imul   0x10(%ebp),%eax
     bc1:	89 c2                	mov    %eax,%edx
     bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
     bc6:	01 d0                	add    %edx,%eax
}
     bc8:	5d                   	pop    %ebp
     bc9:	c3                   	ret    

00000bca <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     bca:	55                   	push   %ebp
     bcb:	89 e5                	mov    %esp,%ebp
     bcd:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bd0:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bd7:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bda:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bdd:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     be4:	83 ec 08             	sub    $0x8,%esp
     be7:	6a 00                	push   $0x0
     be9:	ff 75 0c             	pushl  0xc(%ebp)
     bec:	e8 ec f9 ff ff       	call   5dd <open>
     bf1:	83 c4 10             	add    $0x10,%esp
     bf4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bf7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bfb:	79 2e                	jns    c2b <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     bfd:	83 ec 04             	sub    $0x4,%esp
     c00:	ff 75 0c             	pushl  0xc(%ebp)
     c03:	68 3d 24 00 00       	push   $0x243d
     c08:	6a 01                	push   $0x1
     c0a:	e8 35 fb ff ff       	call   744 <printf>
     c0f:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c12:	8b 45 08             	mov    0x8(%ebp),%eax
     c15:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c18:	89 10                	mov    %edx,(%eax)
     c1a:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c1d:	89 50 04             	mov    %edx,0x4(%eax)
     c20:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c23:	89 50 08             	mov    %edx,0x8(%eax)
     c26:	e9 d2 01 00 00       	jmp    dfd <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c2b:	83 ec 04             	sub    $0x4,%esp
     c2e:	6a 0e                	push   $0xe
     c30:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c33:	50                   	push   %eax
     c34:	ff 75 ec             	pushl  -0x14(%ebp)
     c37:	e8 79 f9 ff ff       	call   5b5 <read>
     c3c:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c3f:	83 ec 04             	sub    $0x4,%esp
     c42:	6a 28                	push   $0x28
     c44:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c47:	50                   	push   %eax
     c48:	ff 75 ec             	pushl  -0x14(%ebp)
     c4b:	e8 65 f9 ff ff       	call   5b5 <read>
     c50:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c53:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c56:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c59:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c5c:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c5f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c62:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c65:	0f af d0             	imul   %eax,%edx
     c68:	89 d0                	mov    %edx,%eax
     c6a:	01 c0                	add    %eax,%eax
     c6c:	01 d0                	add    %edx,%eax
     c6e:	83 ec 0c             	sub    $0xc,%esp
     c71:	50                   	push   %eax
     c72:	e8 a0 fd ff ff       	call   a17 <malloc>
     c77:	83 c4 10             	add    $0x10,%esp
     c7a:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c7d:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c81:	0f b7 c0             	movzwl %ax,%eax
     c84:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c87:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c8d:	0f af c2             	imul   %edx,%eax
     c90:	83 c0 1f             	add    $0x1f,%eax
     c93:	c1 e8 05             	shr    $0x5,%eax
     c96:	c1 e0 02             	shl    $0x2,%eax
     c99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     c9c:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ca2:	0f af c2             	imul   %edx,%eax
     ca5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     ca8:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cab:	83 ec 0c             	sub    $0xc,%esp
     cae:	50                   	push   %eax
     caf:	e8 63 fd ff ff       	call   a17 <malloc>
     cb4:	83 c4 10             	add    $0x10,%esp
     cb7:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     cba:	83 ec 04             	sub    $0x4,%esp
     cbd:	ff 75 e0             	pushl  -0x20(%ebp)
     cc0:	ff 75 dc             	pushl  -0x24(%ebp)
     cc3:	ff 75 ec             	pushl  -0x14(%ebp)
     cc6:	e8 ea f8 ff ff       	call   5b5 <read>
     ccb:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     cce:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     cd2:	66 c1 e8 03          	shr    $0x3,%ax
     cd6:	0f b7 c0             	movzwl %ax,%eax
     cd9:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     cdc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ce3:	e9 e5 00 00 00       	jmp    dcd <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ce8:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cee:	29 c2                	sub    %eax,%edx
     cf0:	89 d0                	mov    %edx,%eax
     cf2:	8d 50 ff             	lea    -0x1(%eax),%edx
     cf5:	8b 45 c8             	mov    -0x38(%ebp),%eax
     cf8:	0f af c2             	imul   %edx,%eax
     cfb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     cfe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d05:	e9 b1 00 00 00       	jmp    dbb <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d0a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d0d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d10:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d13:	01 c8                	add    %ecx,%eax
     d15:	89 c1                	mov    %eax,%ecx
     d17:	89 c8                	mov    %ecx,%eax
     d19:	01 c0                	add    %eax,%eax
     d1b:	01 c8                	add    %ecx,%eax
     d1d:	01 c2                	add    %eax,%edx
     d1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d22:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d26:	89 c1                	mov    %eax,%ecx
     d28:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d2b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d2f:	01 c1                	add    %eax,%ecx
     d31:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d34:	01 c8                	add    %ecx,%eax
     d36:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d39:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d3c:	01 c8                	add    %ecx,%eax
     d3e:	0f b6 00             	movzbl (%eax),%eax
     d41:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d44:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d47:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d4d:	01 c8                	add    %ecx,%eax
     d4f:	89 c1                	mov    %eax,%ecx
     d51:	89 c8                	mov    %ecx,%eax
     d53:	01 c0                	add    %eax,%eax
     d55:	01 c8                	add    %ecx,%eax
     d57:	01 c2                	add    %eax,%edx
     d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d60:	89 c1                	mov    %eax,%ecx
     d62:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d65:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d69:	01 c1                	add    %eax,%ecx
     d6b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d6e:	01 c8                	add    %ecx,%eax
     d70:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d73:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d76:	01 c8                	add    %ecx,%eax
     d78:	0f b6 00             	movzbl (%eax),%eax
     d7b:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d7e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d81:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d84:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d87:	01 c8                	add    %ecx,%eax
     d89:	89 c1                	mov    %eax,%ecx
     d8b:	89 c8                	mov    %ecx,%eax
     d8d:	01 c0                	add    %eax,%eax
     d8f:	01 c8                	add    %ecx,%eax
     d91:	01 c2                	add    %eax,%edx
     d93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d96:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d9a:	89 c1                	mov    %eax,%ecx
     d9c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d9f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     da3:	01 c1                	add    %eax,%ecx
     da5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da8:	01 c8                	add    %ecx,%eax
     daa:	8d 48 fd             	lea    -0x3(%eax),%ecx
     dad:	8b 45 dc             	mov    -0x24(%ebp),%eax
     db0:	01 c8                	add    %ecx,%eax
     db2:	0f b6 00             	movzbl (%eax),%eax
     db5:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     db7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     dbb:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dbe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dc1:	39 c2                	cmp    %eax,%edx
     dc3:	0f 87 41 ff ff ff    	ja     d0a <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     dc9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dcd:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd3:	39 c2                	cmp    %eax,%edx
     dd5:	0f 87 0d ff ff ff    	ja     ce8 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     ddb:	83 ec 0c             	sub    $0xc,%esp
     dde:	ff 75 ec             	pushl  -0x14(%ebp)
     de1:	e8 df f7 ff ff       	call   5c5 <close>
     de6:	83 c4 10             	add    $0x10,%esp
    return bmp;
     de9:	8b 45 08             	mov    0x8(%ebp),%eax
     dec:	8b 55 c8             	mov    -0x38(%ebp),%edx
     def:	89 10                	mov    %edx,(%eax)
     df1:	8b 55 cc             	mov    -0x34(%ebp),%edx
     df4:	89 50 04             	mov    %edx,0x4(%eax)
     df7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     dfa:	89 50 08             	mov    %edx,0x8(%eax)
}
     dfd:	8b 45 08             	mov    0x8(%ebp),%eax
     e00:	c9                   	leave  
     e01:	c2 04 00             	ret    $0x4

00000e04 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e04:	55                   	push   %ebp
     e05:	89 e5                	mov    %esp,%ebp
     e07:	53                   	push   %ebx
     e08:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e0b:	83 ec 0c             	sub    $0xc,%esp
     e0e:	6a 1c                	push   $0x1c
     e10:	e8 02 fc ff ff       	call   a17 <malloc>
     e15:	83 c4 10             	add    $0x10,%esp
     e18:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e1e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e25:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e28:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e2b:	6a 0c                	push   $0xc
     e2d:	6a 0c                	push   $0xc
     e2f:	6a 0c                	push   $0xc
     e31:	50                   	push   %eax
     e32:	e8 c3 fc ff ff       	call   afa <RGB>
     e37:	83 c4 0c             	add    $0xc,%esp
     e3a:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e3e:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e42:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e46:	88 43 15             	mov    %al,0x15(%ebx)
     e49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e4f:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e53:	66 89 48 10          	mov    %cx,0x10(%eax)
     e57:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e5b:	88 50 12             	mov    %dl,0x12(%eax)
     e5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e61:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e64:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e68:	66 89 48 08          	mov    %cx,0x8(%eax)
     e6c:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e70:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e73:	8b 45 08             	mov    0x8(%ebp),%eax
     e76:	89 c2                	mov    %eax,%edx
     e78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e7b:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e80:	89 c2                	mov    %eax,%edx
     e82:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e85:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     e88:	8b 55 10             	mov    0x10(%ebp),%edx
     e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e8e:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     e91:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e97:	c9                   	leave  
     e98:	c3                   	ret    

00000e99 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     e99:	55                   	push   %ebp
     e9a:	89 e5                	mov    %esp,%ebp
     e9c:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea2:	8b 50 08             	mov    0x8(%eax),%edx
     ea5:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ea8:	8b 40 0c             	mov    0xc(%eax),%eax
     eab:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     eae:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb1:	8b 55 10             	mov    0x10(%ebp),%edx
     eb4:	89 50 08             	mov    %edx,0x8(%eax)
     eb7:	8b 55 14             	mov    0x14(%ebp),%edx
     eba:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     ebd:	8b 45 08             	mov    0x8(%ebp),%eax
     ec0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ec3:	89 10                	mov    %edx,(%eax)
     ec5:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ec8:	89 50 04             	mov    %edx,0x4(%eax)
}
     ecb:	8b 45 08             	mov    0x8(%ebp),%eax
     ece:	c9                   	leave  
     ecf:	c2 04 00             	ret    $0x4

00000ed2 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     ed2:	55                   	push   %ebp
     ed3:	89 e5                	mov    %esp,%ebp
     ed5:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
     edb:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     edf:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     ee3:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     ee7:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     eea:	8b 45 0c             	mov    0xc(%ebp),%eax
     eed:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     ef1:	66 89 50 10          	mov    %dx,0x10(%eax)
     ef5:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     ef9:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     efc:	8b 45 08             	mov    0x8(%ebp),%eax
     eff:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f03:	66 89 10             	mov    %dx,(%eax)
     f06:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f0a:	88 50 02             	mov    %dl,0x2(%eax)
}
     f0d:	8b 45 08             	mov    0x8(%ebp),%eax
     f10:	c9                   	leave  
     f11:	c2 04 00             	ret    $0x4

00000f14 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f14:	55                   	push   %ebp
     f15:	89 e5                	mov    %esp,%ebp
     f17:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f1a:	8b 45 08             	mov    0x8(%ebp),%eax
     f1d:	8b 40 0c             	mov    0xc(%eax),%eax
     f20:	89 c2                	mov    %eax,%edx
     f22:	c1 ea 1f             	shr    $0x1f,%edx
     f25:	01 d0                	add    %edx,%eax
     f27:	d1 f8                	sar    %eax
     f29:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f2f:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f33:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f36:	8b 45 10             	mov    0x10(%ebp),%eax
     f39:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f3f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f43:	0f 89 98 00 00 00    	jns    fe1 <APDrawPoint+0xcd>
        i = 0;
     f49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f50:	e9 8c 00 00 00       	jmp    fe1 <APDrawPoint+0xcd>
    {
        j = x - off;
     f55:	8b 45 0c             	mov    0xc(%ebp),%eax
     f58:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f5b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f5e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f62:	79 69                	jns    fcd <APDrawPoint+0xb9>
            j = 0;
     f64:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f6b:	eb 60                	jmp    fcd <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f6d:	ff 75 fc             	pushl  -0x4(%ebp)
     f70:	ff 75 f8             	pushl  -0x8(%ebp)
     f73:	ff 75 08             	pushl  0x8(%ebp)
     f76:	e8 fd fb ff ff       	call   b78 <APGetIndex>
     f7b:	83 c4 0c             	add    $0xc,%esp
     f7e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     f81:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     f85:	74 55                	je     fdc <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     f87:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     f8b:	74 67                	je     ff4 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     f8d:	ff 75 10             	pushl  0x10(%ebp)
     f90:	ff 75 0c             	pushl  0xc(%ebp)
     f93:	ff 75 fc             	pushl  -0x4(%ebp)
     f96:	ff 75 f8             	pushl  -0x8(%ebp)
     f99:	e8 a1 fb ff ff       	call   b3f <distance_2>
     f9e:	83 c4 10             	add    $0x10,%esp
     fa1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fa4:	7f 23                	jg     fc9 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     fa6:	8b 45 08             	mov    0x8(%ebp),%eax
     fa9:	8b 48 18             	mov    0x18(%eax),%ecx
     fac:	8b 55 ec             	mov    -0x14(%ebp),%edx
     faf:	89 d0                	mov    %edx,%eax
     fb1:	01 c0                	add    %eax,%eax
     fb3:	01 d0                	add    %edx,%eax
     fb5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     fb8:	8b 45 08             	mov    0x8(%ebp),%eax
     fbb:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     fbf:	66 89 0a             	mov    %cx,(%edx)
     fc2:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     fc6:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     fc9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     fcd:	8b 55 0c             	mov    0xc(%ebp),%edx
     fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd3:	01 d0                	add    %edx,%eax
     fd5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     fd8:	7d 93                	jge    f6d <APDrawPoint+0x59>
     fda:	eb 01                	jmp    fdd <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     fdc:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     fdd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     fe1:	8b 55 10             	mov    0x10(%ebp),%edx
     fe4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fe7:	01 d0                	add    %edx,%eax
     fe9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     fec:	0f 8d 63 ff ff ff    	jge    f55 <APDrawPoint+0x41>
     ff2:	eb 01                	jmp    ff5 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     ff4:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     ff5:	c9                   	leave  
     ff6:	c3                   	ret    

00000ff7 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     ff7:	55                   	push   %ebp
     ff8:	89 e5                	mov    %esp,%ebp
     ffa:	53                   	push   %ebx
     ffb:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1001:	3b 45 14             	cmp    0x14(%ebp),%eax
    1004:	0f 85 80 00 00 00    	jne    108a <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    100a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    100e:	0f 88 9d 02 00 00    	js     12b1 <APDrawLine+0x2ba>
    1014:	8b 45 08             	mov    0x8(%ebp),%eax
    1017:	8b 00                	mov    (%eax),%eax
    1019:	3b 45 0c             	cmp    0xc(%ebp),%eax
    101c:	0f 8e 8f 02 00 00    	jle    12b1 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    1022:	8b 45 10             	mov    0x10(%ebp),%eax
    1025:	3b 45 18             	cmp    0x18(%ebp),%eax
    1028:	7e 12                	jle    103c <APDrawLine+0x45>
        {
            int tmp = y2;
    102a:	8b 45 18             	mov    0x18(%ebp),%eax
    102d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1030:	8b 45 10             	mov    0x10(%ebp),%eax
    1033:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1036:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1039:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    103c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1040:	79 07                	jns    1049 <APDrawLine+0x52>
    1042:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1049:	8b 45 08             	mov    0x8(%ebp),%eax
    104c:	8b 40 04             	mov    0x4(%eax),%eax
    104f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1052:	7d 0c                	jge    1060 <APDrawLine+0x69>
    1054:	8b 45 08             	mov    0x8(%ebp),%eax
    1057:	8b 40 04             	mov    0x4(%eax),%eax
    105a:	83 e8 01             	sub    $0x1,%eax
    105d:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1060:	8b 45 10             	mov    0x10(%ebp),%eax
    1063:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1066:	eb 15                	jmp    107d <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1068:	ff 75 f4             	pushl  -0xc(%ebp)
    106b:	ff 75 0c             	pushl  0xc(%ebp)
    106e:	ff 75 08             	pushl  0x8(%ebp)
    1071:	e8 9e fe ff ff       	call   f14 <APDrawPoint>
    1076:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1079:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    107d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1080:	3b 45 18             	cmp    0x18(%ebp),%eax
    1083:	7e e3                	jle    1068 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    1085:	e9 2b 02 00 00       	jmp    12b5 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    108a:	8b 45 10             	mov    0x10(%ebp),%eax
    108d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1090:	75 7f                	jne    1111 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    1092:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1096:	0f 88 18 02 00 00    	js     12b4 <APDrawLine+0x2bd>
    109c:	8b 45 08             	mov    0x8(%ebp),%eax
    109f:	8b 40 04             	mov    0x4(%eax),%eax
    10a2:	3b 45 10             	cmp    0x10(%ebp),%eax
    10a5:	0f 8e 09 02 00 00    	jle    12b4 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ae:	3b 45 14             	cmp    0x14(%ebp),%eax
    10b1:	7e 12                	jle    10c5 <APDrawLine+0xce>
        {
            int tmp = x2;
    10b3:	8b 45 14             	mov    0x14(%ebp),%eax
    10b6:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    10b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    10bc:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10bf:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10c2:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10c9:	79 07                	jns    10d2 <APDrawLine+0xdb>
    10cb:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    10d2:	8b 45 08             	mov    0x8(%ebp),%eax
    10d5:	8b 00                	mov    (%eax),%eax
    10d7:	3b 45 14             	cmp    0x14(%ebp),%eax
    10da:	7d 0b                	jge    10e7 <APDrawLine+0xf0>
    10dc:	8b 45 08             	mov    0x8(%ebp),%eax
    10df:	8b 00                	mov    (%eax),%eax
    10e1:	83 e8 01             	sub    $0x1,%eax
    10e4:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    10e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10ed:	eb 15                	jmp    1104 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    10ef:	ff 75 10             	pushl  0x10(%ebp)
    10f2:	ff 75 f0             	pushl  -0x10(%ebp)
    10f5:	ff 75 08             	pushl  0x8(%ebp)
    10f8:	e8 17 fe ff ff       	call   f14 <APDrawPoint>
    10fd:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1100:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1104:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1107:	3b 45 14             	cmp    0x14(%ebp),%eax
    110a:	7e e3                	jle    10ef <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    110c:	e9 a4 01 00 00       	jmp    12b5 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1111:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1118:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    111f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1122:	2b 45 14             	sub    0x14(%ebp),%eax
    1125:	50                   	push   %eax
    1126:	e8 3d fa ff ff       	call   b68 <abs_int>
    112b:	83 c4 04             	add    $0x4,%esp
    112e:	89 c3                	mov    %eax,%ebx
    1130:	8b 45 10             	mov    0x10(%ebp),%eax
    1133:	2b 45 18             	sub    0x18(%ebp),%eax
    1136:	50                   	push   %eax
    1137:	e8 2c fa ff ff       	call   b68 <abs_int>
    113c:	83 c4 04             	add    $0x4,%esp
    113f:	39 c3                	cmp    %eax,%ebx
    1141:	0f 8e b5 00 00 00    	jle    11fc <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1147:	8b 45 10             	mov    0x10(%ebp),%eax
    114a:	2b 45 18             	sub    0x18(%ebp),%eax
    114d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1150:	db 45 b0             	fildl  -0x50(%ebp)
    1153:	8b 45 0c             	mov    0xc(%ebp),%eax
    1156:	2b 45 14             	sub    0x14(%ebp),%eax
    1159:	89 45 b0             	mov    %eax,-0x50(%ebp)
    115c:	db 45 b0             	fildl  -0x50(%ebp)
    115f:	de f9                	fdivrp %st,%st(1)
    1161:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    1164:	8b 45 14             	mov    0x14(%ebp),%eax
    1167:	3b 45 0c             	cmp    0xc(%ebp),%eax
    116a:	7e 0e                	jle    117a <APDrawLine+0x183>
        {
            s = x1;
    116c:	8b 45 0c             	mov    0xc(%ebp),%eax
    116f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    1172:	8b 45 14             	mov    0x14(%ebp),%eax
    1175:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1178:	eb 0c                	jmp    1186 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    117a:	8b 45 14             	mov    0x14(%ebp),%eax
    117d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1180:	8b 45 0c             	mov    0xc(%ebp),%eax
    1183:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    1186:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    118a:	79 07                	jns    1193 <APDrawLine+0x19c>
    118c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    1193:	8b 45 08             	mov    0x8(%ebp),%eax
    1196:	8b 00                	mov    (%eax),%eax
    1198:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    119b:	7f 0b                	jg     11a8 <APDrawLine+0x1b1>
    119d:	8b 45 08             	mov    0x8(%ebp),%eax
    11a0:	8b 00                	mov    (%eax),%eax
    11a2:	83 e8 01             	sub    $0x1,%eax
    11a5:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11ae:	eb 3f                	jmp    11ef <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11b3:	2b 45 0c             	sub    0xc(%ebp),%eax
    11b6:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11b9:	db 45 b0             	fildl  -0x50(%ebp)
    11bc:	dc 4d d0             	fmull  -0x30(%ebp)
    11bf:	db 45 10             	fildl  0x10(%ebp)
    11c2:	de c1                	faddp  %st,%st(1)
    11c4:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11c7:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11cb:	b4 0c                	mov    $0xc,%ah
    11cd:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11d1:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11d4:	db 5d cc             	fistpl -0x34(%ebp)
    11d7:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    11da:	ff 75 cc             	pushl  -0x34(%ebp)
    11dd:	ff 75 e4             	pushl  -0x1c(%ebp)
    11e0:	ff 75 08             	pushl  0x8(%ebp)
    11e3:	e8 2c fd ff ff       	call   f14 <APDrawPoint>
    11e8:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    11eb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    11ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11f2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11f5:	7e b9                	jle    11b0 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    11f7:	e9 b9 00 00 00       	jmp    12b5 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    11fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ff:	2b 45 14             	sub    0x14(%ebp),%eax
    1202:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1205:	db 45 b0             	fildl  -0x50(%ebp)
    1208:	8b 45 10             	mov    0x10(%ebp),%eax
    120b:	2b 45 18             	sub    0x18(%ebp),%eax
    120e:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1211:	db 45 b0             	fildl  -0x50(%ebp)
    1214:	de f9                	fdivrp %st,%st(1)
    1216:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1219:	8b 45 10             	mov    0x10(%ebp),%eax
    121c:	3b 45 18             	cmp    0x18(%ebp),%eax
    121f:	7e 0e                	jle    122f <APDrawLine+0x238>
    {
        s = y2;
    1221:	8b 45 18             	mov    0x18(%ebp),%eax
    1224:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1227:	8b 45 10             	mov    0x10(%ebp),%eax
    122a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    122d:	eb 0c                	jmp    123b <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    122f:	8b 45 10             	mov    0x10(%ebp),%eax
    1232:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    1235:	8b 45 18             	mov    0x18(%ebp),%eax
    1238:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    123b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    123f:	79 07                	jns    1248 <APDrawLine+0x251>
    1241:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1248:	8b 45 08             	mov    0x8(%ebp),%eax
    124b:	8b 40 04             	mov    0x4(%eax),%eax
    124e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1251:	7f 0c                	jg     125f <APDrawLine+0x268>
    1253:	8b 45 08             	mov    0x8(%ebp),%eax
    1256:	8b 40 04             	mov    0x4(%eax),%eax
    1259:	83 e8 01             	sub    $0x1,%eax
    125c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    125f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1262:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1265:	eb 3f                	jmp    12a6 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    1267:	8b 45 e0             	mov    -0x20(%ebp),%eax
    126a:	2b 45 10             	sub    0x10(%ebp),%eax
    126d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1270:	db 45 b0             	fildl  -0x50(%ebp)
    1273:	dc 4d c0             	fmull  -0x40(%ebp)
    1276:	db 45 0c             	fildl  0xc(%ebp)
    1279:	de c1                	faddp  %st,%st(1)
    127b:	d9 7d b6             	fnstcw -0x4a(%ebp)
    127e:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1282:	b4 0c                	mov    $0xc,%ah
    1284:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1288:	d9 6d b4             	fldcw  -0x4c(%ebp)
    128b:	db 5d bc             	fistpl -0x44(%ebp)
    128e:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1291:	ff 75 e0             	pushl  -0x20(%ebp)
    1294:	ff 75 bc             	pushl  -0x44(%ebp)
    1297:	ff 75 08             	pushl  0x8(%ebp)
    129a:	e8 75 fc ff ff       	call   f14 <APDrawPoint>
    129f:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12a2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12a9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12ac:	7e b9                	jle    1267 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12ae:	90                   	nop
    12af:	eb 04                	jmp    12b5 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12b1:	90                   	nop
    12b2:	eb 01                	jmp    12b5 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12b4:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12b8:	c9                   	leave  
    12b9:	c3                   	ret    

000012ba <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    12ba:	55                   	push   %ebp
    12bb:	89 e5                	mov    %esp,%ebp
    12bd:	53                   	push   %ebx
    12be:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    12c1:	8b 55 10             	mov    0x10(%ebp),%edx
    12c4:	8b 45 18             	mov    0x18(%ebp),%eax
    12c7:	01 d0                	add    %edx,%eax
    12c9:	83 e8 01             	sub    $0x1,%eax
    12cc:	83 ec 04             	sub    $0x4,%esp
    12cf:	50                   	push   %eax
    12d0:	ff 75 0c             	pushl  0xc(%ebp)
    12d3:	ff 75 10             	pushl  0x10(%ebp)
    12d6:	ff 75 0c             	pushl  0xc(%ebp)
    12d9:	ff 75 08             	pushl  0x8(%ebp)
    12dc:	e8 16 fd ff ff       	call   ff7 <APDrawLine>
    12e1:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    12e4:	8b 55 0c             	mov    0xc(%ebp),%edx
    12e7:	8b 45 14             	mov    0x14(%ebp),%eax
    12ea:	01 d0                	add    %edx,%eax
    12ec:	83 e8 01             	sub    $0x1,%eax
    12ef:	83 ec 04             	sub    $0x4,%esp
    12f2:	ff 75 10             	pushl  0x10(%ebp)
    12f5:	50                   	push   %eax
    12f6:	ff 75 10             	pushl  0x10(%ebp)
    12f9:	ff 75 0c             	pushl  0xc(%ebp)
    12fc:	ff 75 08             	pushl  0x8(%ebp)
    12ff:	e8 f3 fc ff ff       	call   ff7 <APDrawLine>
    1304:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1307:	8b 55 10             	mov    0x10(%ebp),%edx
    130a:	8b 45 18             	mov    0x18(%ebp),%eax
    130d:	01 d0                	add    %edx,%eax
    130f:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1312:	8b 55 0c             	mov    0xc(%ebp),%edx
    1315:	8b 45 14             	mov    0x14(%ebp),%eax
    1318:	01 d0                	add    %edx,%eax
    131a:	8d 50 ff             	lea    -0x1(%eax),%edx
    131d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1320:	8b 45 14             	mov    0x14(%ebp),%eax
    1323:	01 d8                	add    %ebx,%eax
    1325:	83 e8 01             	sub    $0x1,%eax
    1328:	83 ec 04             	sub    $0x4,%esp
    132b:	51                   	push   %ecx
    132c:	52                   	push   %edx
    132d:	ff 75 10             	pushl  0x10(%ebp)
    1330:	50                   	push   %eax
    1331:	ff 75 08             	pushl  0x8(%ebp)
    1334:	e8 be fc ff ff       	call   ff7 <APDrawLine>
    1339:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    133c:	8b 55 10             	mov    0x10(%ebp),%edx
    133f:	8b 45 18             	mov    0x18(%ebp),%eax
    1342:	01 d0                	add    %edx,%eax
    1344:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1347:	8b 55 0c             	mov    0xc(%ebp),%edx
    134a:	8b 45 14             	mov    0x14(%ebp),%eax
    134d:	01 d0                	add    %edx,%eax
    134f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1352:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1355:	8b 45 18             	mov    0x18(%ebp),%eax
    1358:	01 d8                	add    %ebx,%eax
    135a:	83 e8 01             	sub    $0x1,%eax
    135d:	83 ec 04             	sub    $0x4,%esp
    1360:	51                   	push   %ecx
    1361:	52                   	push   %edx
    1362:	50                   	push   %eax
    1363:	ff 75 0c             	pushl  0xc(%ebp)
    1366:	ff 75 08             	pushl  0x8(%ebp)
    1369:	e8 89 fc ff ff       	call   ff7 <APDrawLine>
    136e:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1371:	8b 55 0c             	mov    0xc(%ebp),%edx
    1374:	8b 45 14             	mov    0x14(%ebp),%eax
    1377:	01 d0                	add    %edx,%eax
    1379:	8d 50 ff             	lea    -0x1(%eax),%edx
    137c:	8b 45 08             	mov    0x8(%ebp),%eax
    137f:	8b 40 0c             	mov    0xc(%eax),%eax
    1382:	89 c1                	mov    %eax,%ecx
    1384:	c1 e9 1f             	shr    $0x1f,%ecx
    1387:	01 c8                	add    %ecx,%eax
    1389:	d1 f8                	sar    %eax
    138b:	29 c2                	sub    %eax,%edx
    138d:	89 d0                	mov    %edx,%eax
    138f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    1392:	8b 55 10             	mov    0x10(%ebp),%edx
    1395:	8b 45 18             	mov    0x18(%ebp),%eax
    1398:	01 d0                	add    %edx,%eax
    139a:	8d 50 ff             	lea    -0x1(%eax),%edx
    139d:	8b 45 08             	mov    0x8(%ebp),%eax
    13a0:	8b 40 0c             	mov    0xc(%eax),%eax
    13a3:	89 c1                	mov    %eax,%ecx
    13a5:	c1 e9 1f             	shr    $0x1f,%ecx
    13a8:	01 c8                	add    %ecx,%eax
    13aa:	d1 f8                	sar    %eax
    13ac:	29 c2                	sub    %eax,%edx
    13ae:	89 d0                	mov    %edx,%eax
    13b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13b3:	8b 45 08             	mov    0x8(%ebp),%eax
    13b6:	8b 40 0c             	mov    0xc(%eax),%eax
    13b9:	89 c2                	mov    %eax,%edx
    13bb:	c1 ea 1f             	shr    $0x1f,%edx
    13be:	01 d0                	add    %edx,%eax
    13c0:	d1 f8                	sar    %eax
    13c2:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13c5:	8b 45 08             	mov    0x8(%ebp),%eax
    13c8:	8b 40 0c             	mov    0xc(%eax),%eax
    13cb:	89 c2                	mov    %eax,%edx
    13cd:	c1 ea 1f             	shr    $0x1f,%edx
    13d0:	01 d0                	add    %edx,%eax
    13d2:	d1 f8                	sar    %eax
    13d4:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    13d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13db:	0f 88 d8 00 00 00    	js     14b9 <APDrawRect+0x1ff>
    13e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13e5:	0f 88 ce 00 00 00    	js     14b9 <APDrawRect+0x1ff>
    13eb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ee:	8b 00                	mov    (%eax),%eax
    13f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13f3:	0f 8e c0 00 00 00    	jle    14b9 <APDrawRect+0x1ff>
    13f9:	8b 45 08             	mov    0x8(%ebp),%eax
    13fc:	8b 40 04             	mov    0x4(%eax),%eax
    13ff:	3b 45 10             	cmp    0x10(%ebp),%eax
    1402:	0f 8e b1 00 00 00    	jle    14b9 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1408:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    140c:	79 07                	jns    1415 <APDrawRect+0x15b>
    140e:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    1415:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1419:	79 07                	jns    1422 <APDrawRect+0x168>
    141b:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    1422:	8b 45 08             	mov    0x8(%ebp),%eax
    1425:	8b 00                	mov    (%eax),%eax
    1427:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    142a:	7f 0b                	jg     1437 <APDrawRect+0x17d>
    142c:	8b 45 08             	mov    0x8(%ebp),%eax
    142f:	8b 00                	mov    (%eax),%eax
    1431:	83 e8 01             	sub    $0x1,%eax
    1434:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1437:	8b 45 08             	mov    0x8(%ebp),%eax
    143a:	8b 40 04             	mov    0x4(%eax),%eax
    143d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1440:	7f 0c                	jg     144e <APDrawRect+0x194>
    1442:	8b 45 08             	mov    0x8(%ebp),%eax
    1445:	8b 40 04             	mov    0x4(%eax),%eax
    1448:	83 e8 01             	sub    $0x1,%eax
    144b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    144e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    1455:	8b 45 0c             	mov    0xc(%ebp),%eax
    1458:	89 45 ec             	mov    %eax,-0x14(%ebp)
    145b:	eb 52                	jmp    14af <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    145d:	8b 45 10             	mov    0x10(%ebp),%eax
    1460:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1463:	eb 3e                	jmp    14a3 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    1465:	83 ec 04             	sub    $0x4,%esp
    1468:	ff 75 e8             	pushl  -0x18(%ebp)
    146b:	ff 75 ec             	pushl  -0x14(%ebp)
    146e:	ff 75 08             	pushl  0x8(%ebp)
    1471:	e8 02 f7 ff ff       	call   b78 <APGetIndex>
    1476:	83 c4 10             	add    $0x10,%esp
    1479:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    147c:	8b 45 08             	mov    0x8(%ebp),%eax
    147f:	8b 48 18             	mov    0x18(%eax),%ecx
    1482:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1485:	89 d0                	mov    %edx,%eax
    1487:	01 c0                	add    %eax,%eax
    1489:	01 d0                	add    %edx,%eax
    148b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    148e:	8b 45 08             	mov    0x8(%ebp),%eax
    1491:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    1495:	66 89 0a             	mov    %cx,(%edx)
    1498:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    149c:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    149f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14a9:	7e ba                	jle    1465 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14ab:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14af:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14b5:	7e a6                	jle    145d <APDrawRect+0x1a3>
    14b7:	eb 01                	jmp    14ba <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    14b9:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    14ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14bd:	c9                   	leave  
    14be:	c3                   	ret    

000014bf <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14bf:	55                   	push   %ebp
    14c0:	89 e5                	mov    %esp,%ebp
    14c2:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14c5:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14c9:	0f 88 8e 01 00 00    	js     165d <APDcCopy+0x19e>
    14cf:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14d3:	0f 88 84 01 00 00    	js     165d <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14d9:	8b 55 0c             	mov    0xc(%ebp),%edx
    14dc:	8b 45 20             	mov    0x20(%ebp),%eax
    14df:	01 d0                	add    %edx,%eax
    14e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14e4:	8b 55 10             	mov    0x10(%ebp),%edx
    14e7:	8b 45 24             	mov    0x24(%ebp),%eax
    14ea:	01 d0                	add    %edx,%eax
    14ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14ef:	8b 55 18             	mov    0x18(%ebp),%edx
    14f2:	8b 45 20             	mov    0x20(%ebp),%eax
    14f5:	01 d0                	add    %edx,%eax
    14f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14fa:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14fd:	8b 45 24             	mov    0x24(%ebp),%eax
    1500:	01 d0                	add    %edx,%eax
    1502:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1505:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1509:	0f 88 51 01 00 00    	js     1660 <APDcCopy+0x1a1>
    150f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1513:	0f 88 47 01 00 00    	js     1660 <APDcCopy+0x1a1>
    1519:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    151d:	0f 88 3d 01 00 00    	js     1660 <APDcCopy+0x1a1>
    1523:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1527:	0f 88 33 01 00 00    	js     1660 <APDcCopy+0x1a1>
    152d:	8b 45 14             	mov    0x14(%ebp),%eax
    1530:	8b 00                	mov    (%eax),%eax
    1532:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1535:	0f 8c 25 01 00 00    	jl     1660 <APDcCopy+0x1a1>
    153b:	8b 45 14             	mov    0x14(%ebp),%eax
    153e:	8b 40 04             	mov    0x4(%eax),%eax
    1541:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1544:	0f 8c 16 01 00 00    	jl     1660 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    154a:	8b 45 08             	mov    0x8(%ebp),%eax
    154d:	8b 00                	mov    (%eax),%eax
    154f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1552:	7f 0b                	jg     155f <APDcCopy+0xa0>
    1554:	8b 45 08             	mov    0x8(%ebp),%eax
    1557:	8b 00                	mov    (%eax),%eax
    1559:	83 e8 01             	sub    $0x1,%eax
    155c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    155f:	8b 45 08             	mov    0x8(%ebp),%eax
    1562:	8b 40 04             	mov    0x4(%eax),%eax
    1565:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1568:	7f 0c                	jg     1576 <APDcCopy+0xb7>
    156a:	8b 45 08             	mov    0x8(%ebp),%eax
    156d:	8b 40 04             	mov    0x4(%eax),%eax
    1570:	83 e8 01             	sub    $0x1,%eax
    1573:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1576:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    157d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1584:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    158b:	e9 bc 00 00 00       	jmp    164c <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1590:	8b 45 08             	mov    0x8(%ebp),%eax
    1593:	8b 00                	mov    (%eax),%eax
    1595:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1598:	8b 55 10             	mov    0x10(%ebp),%edx
    159b:	01 ca                	add    %ecx,%edx
    159d:	0f af d0             	imul   %eax,%edx
    15a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a3:	01 d0                	add    %edx,%eax
    15a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    15a8:	8b 45 14             	mov    0x14(%ebp),%eax
    15ab:	8b 00                	mov    (%eax),%eax
    15ad:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15b0:	8b 55 1c             	mov    0x1c(%ebp),%edx
    15b3:	01 ca                	add    %ecx,%edx
    15b5:	0f af d0             	imul   %eax,%edx
    15b8:	8b 45 18             	mov    0x18(%ebp),%eax
    15bb:	01 d0                	add    %edx,%eax
    15bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    15c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15c7:	eb 74                	jmp    163d <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15c9:	8b 45 14             	mov    0x14(%ebp),%eax
    15cc:	8b 50 18             	mov    0x18(%eax),%edx
    15cf:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15d5:	01 c8                	add    %ecx,%eax
    15d7:	89 c1                	mov    %eax,%ecx
    15d9:	89 c8                	mov    %ecx,%eax
    15db:	01 c0                	add    %eax,%eax
    15dd:	01 c8                	add    %ecx,%eax
    15df:	01 d0                	add    %edx,%eax
    15e1:	0f b7 10             	movzwl (%eax),%edx
    15e4:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15e8:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15ec:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15ef:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15f3:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15f7:	38 c2                	cmp    %al,%dl
    15f9:	75 18                	jne    1613 <APDcCopy+0x154>
    15fb:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15ff:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1603:	38 c2                	cmp    %al,%dl
    1605:	75 0c                	jne    1613 <APDcCopy+0x154>
    1607:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    160b:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    160f:	38 c2                	cmp    %al,%dl
    1611:	74 26                	je     1639 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1613:	8b 45 08             	mov    0x8(%ebp),%eax
    1616:	8b 50 18             	mov    0x18(%eax),%edx
    1619:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    161c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161f:	01 c8                	add    %ecx,%eax
    1621:	89 c1                	mov    %eax,%ecx
    1623:	89 c8                	mov    %ecx,%eax
    1625:	01 c0                	add    %eax,%eax
    1627:	01 c8                	add    %ecx,%eax
    1629:	01 d0                	add    %edx,%eax
    162b:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    162f:	66 89 10             	mov    %dx,(%eax)
    1632:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1636:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1639:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    163d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1640:	2b 45 0c             	sub    0xc(%ebp),%eax
    1643:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1646:	7d 81                	jge    15c9 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1648:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    164c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164f:	2b 45 10             	sub    0x10(%ebp),%eax
    1652:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1655:	0f 8d 35 ff ff ff    	jge    1590 <APDcCopy+0xd1>
    165b:	eb 04                	jmp    1661 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    165d:	90                   	nop
    165e:	eb 01                	jmp    1661 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1660:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1661:	c9                   	leave  
    1662:	c3                   	ret    

00001663 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1663:	55                   	push   %ebp
    1664:	89 e5                	mov    %esp,%ebp
    1666:	83 ec 1c             	sub    $0x1c,%esp
    1669:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    166c:	8b 55 10             	mov    0x10(%ebp),%edx
    166f:	8b 45 14             	mov    0x14(%ebp),%eax
    1672:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1675:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1678:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    167b:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    167f:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1682:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1686:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1689:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    168d:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1690:	8b 45 08             	mov    0x8(%ebp),%eax
    1693:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1697:	66 89 10             	mov    %dx,(%eax)
    169a:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    169e:	88 50 02             	mov    %dl,0x2(%eax)
}
    16a1:	8b 45 08             	mov    0x8(%ebp),%eax
    16a4:	c9                   	leave  
    16a5:	c2 04 00             	ret    $0x4

000016a8 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    16a8:	55                   	push   %ebp
    16a9:	89 e5                	mov    %esp,%ebp
    16ab:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    16ae:	8b 45 08             	mov    0x8(%ebp),%eax
    16b1:	8b 00                	mov    (%eax),%eax
    16b3:	83 ec 08             	sub    $0x8,%esp
    16b6:	8d 55 0c             	lea    0xc(%ebp),%edx
    16b9:	52                   	push   %edx
    16ba:	50                   	push   %eax
    16bb:	e8 8d ef ff ff       	call   64d <sendMessage>
    16c0:	83 c4 10             	add    $0x10,%esp
}
    16c3:	90                   	nop
    16c4:	c9                   	leave  
    16c5:	c3                   	ret    

000016c6 <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16c6:	55                   	push   %ebp
    16c7:	89 e5                	mov    %esp,%ebp
    16c9:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16cc:	83 ec 0c             	sub    $0xc,%esp
    16cf:	68 90 00 00 00       	push   $0x90
    16d4:	e8 3e f3 ff ff       	call   a17 <malloc>
    16d9:	83 c4 10             	add    $0x10,%esp
    16dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16e3:	75 15                	jne    16fa <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16e5:	83 ec 04             	sub    $0x4,%esp
    16e8:	ff 75 08             	pushl  0x8(%ebp)
    16eb:	68 50 24 00 00       	push   $0x2450
    16f0:	6a 01                	push   $0x1
    16f2:	e8 4d f0 ff ff       	call   744 <printf>
    16f7:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fd:	83 c0 7c             	add    $0x7c,%eax
    1700:	83 ec 08             	sub    $0x8,%esp
    1703:	ff 75 08             	pushl  0x8(%ebp)
    1706:	50                   	push   %eax
    1707:	e8 60 ec ff ff       	call   36c <strcpy>
    170c:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1712:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1719:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171c:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1723:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1726:	8b 40 34             	mov    0x34(%eax),%eax
    1729:	89 c2                	mov    %eax,%edx
    172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172e:	8b 40 38             	mov    0x38(%eax),%eax
    1731:	0f af d0             	imul   %eax,%edx
    1734:	89 d0                	mov    %edx,%eax
    1736:	01 c0                	add    %eax,%eax
    1738:	01 d0                	add    %edx,%eax
    173a:	83 ec 0c             	sub    $0xc,%esp
    173d:	50                   	push   %eax
    173e:	e8 d4 f2 ff ff       	call   a17 <malloc>
    1743:	83 c4 10             	add    $0x10,%esp
    1746:	89 c2                	mov    %eax,%edx
    1748:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174b:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    174e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1751:	8b 40 4c             	mov    0x4c(%eax),%eax
    1754:	85 c0                	test   %eax,%eax
    1756:	75 15                	jne    176d <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1758:	83 ec 04             	sub    $0x4,%esp
    175b:	ff 75 08             	pushl  0x8(%ebp)
    175e:	68 70 24 00 00       	push   $0x2470
    1763:	6a 01                	push   $0x1
    1765:	e8 da ef ff ff       	call   744 <printf>
    176a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    176d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1770:	8b 40 34             	mov    0x34(%eax),%eax
    1773:	89 c2                	mov    %eax,%edx
    1775:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1778:	8b 40 38             	mov    0x38(%eax),%eax
    177b:	0f af d0             	imul   %eax,%edx
    177e:	89 d0                	mov    %edx,%eax
    1780:	01 c0                	add    %eax,%eax
    1782:	01 c2                	add    %eax,%edx
    1784:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1787:	8b 40 4c             	mov    0x4c(%eax),%eax
    178a:	83 ec 04             	sub    $0x4,%esp
    178d:	52                   	push   %edx
    178e:	68 ff ff ff 00       	push   $0xffffff
    1793:	50                   	push   %eax
    1794:	e8 69 ec ff ff       	call   402 <memset>
    1799:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179f:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    17a6:	e8 72 ee ff ff       	call   61d <getpid>
    17ab:	89 c2                	mov    %eax,%edx
    17ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b0:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    17b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b6:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c0:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ca:	8b 40 50             	mov    0x50(%eax),%eax
    17cd:	89 c2                	mov    %eax,%edx
    17cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d2:	8b 40 54             	mov    0x54(%eax),%eax
    17d5:	0f af d0             	imul   %eax,%edx
    17d8:	89 d0                	mov    %edx,%eax
    17da:	01 c0                	add    %eax,%eax
    17dc:	01 d0                	add    %edx,%eax
    17de:	83 ec 0c             	sub    $0xc,%esp
    17e1:	50                   	push   %eax
    17e2:	e8 30 f2 ff ff       	call   a17 <malloc>
    17e7:	83 c4 10             	add    $0x10,%esp
    17ea:	89 c2                	mov    %eax,%edx
    17ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ef:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	8b 40 68             	mov    0x68(%eax),%eax
    17f8:	85 c0                	test   %eax,%eax
    17fa:	75 15                	jne    1811 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17fc:	83 ec 04             	sub    $0x4,%esp
    17ff:	ff 75 08             	pushl  0x8(%ebp)
    1802:	68 94 24 00 00       	push   $0x2494
    1807:	6a 01                	push   $0x1
    1809:	e8 36 ef ff ff       	call   744 <printf>
    180e:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1811:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1814:	8b 40 34             	mov    0x34(%eax),%eax
    1817:	89 c2                	mov    %eax,%edx
    1819:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181c:	8b 40 38             	mov    0x38(%eax),%eax
    181f:	0f af d0             	imul   %eax,%edx
    1822:	89 d0                	mov    %edx,%eax
    1824:	01 c0                	add    %eax,%eax
    1826:	01 c2                	add    %eax,%edx
    1828:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182b:	8b 40 4c             	mov    0x4c(%eax),%eax
    182e:	83 ec 04             	sub    $0x4,%esp
    1831:	52                   	push   %edx
    1832:	68 ff 00 00 00       	push   $0xff
    1837:	50                   	push   %eax
    1838:	e8 c5 eb ff ff       	call   402 <memset>
    183d:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1840:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1843:	8b 55 0c             	mov    0xc(%ebp),%edx
    1846:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1849:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    184d:	74 35                	je     1884 <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    184f:	8b 45 10             	mov    0x10(%ebp),%eax
    1852:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1858:	83 ec 0c             	sub    $0xc,%esp
    185b:	50                   	push   %eax
    185c:	e8 b6 f1 ff ff       	call   a17 <malloc>
    1861:	83 c4 10             	add    $0x10,%esp
    1864:	89 c2                	mov    %eax,%edx
    1866:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1869:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    186c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186f:	8b 55 10             	mov    0x10(%ebp),%edx
    1872:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1875:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1878:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    187f:	e9 8d 00 00 00       	jmp    1911 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1884:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1887:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    188e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1891:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1898:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189b:	8b 40 18             	mov    0x18(%eax),%eax
    189e:	89 c2                	mov    %eax,%edx
    18a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a3:	8b 40 1c             	mov    0x1c(%eax),%eax
    18a6:	0f af d0             	imul   %eax,%edx
    18a9:	89 d0                	mov    %edx,%eax
    18ab:	01 c0                	add    %eax,%eax
    18ad:	01 d0                	add    %edx,%eax
    18af:	83 ec 0c             	sub    $0xc,%esp
    18b2:	50                   	push   %eax
    18b3:	e8 5f f1 ff ff       	call   a17 <malloc>
    18b8:	83 c4 10             	add    $0x10,%esp
    18bb:	89 c2                	mov    %eax,%edx
    18bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c0:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    18c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c6:	8b 40 30             	mov    0x30(%eax),%eax
    18c9:	85 c0                	test   %eax,%eax
    18cb:	75 15                	jne    18e2 <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18cd:	83 ec 04             	sub    $0x4,%esp
    18d0:	ff 75 08             	pushl  0x8(%ebp)
    18d3:	68 bc 24 00 00       	push   $0x24bc
    18d8:	6a 01                	push   $0x1
    18da:	e8 65 ee ff ff       	call   744 <printf>
    18df:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e5:	8b 40 18             	mov    0x18(%eax),%eax
    18e8:	89 c2                	mov    %eax,%edx
    18ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ed:	8b 40 1c             	mov    0x1c(%eax),%eax
    18f0:	0f af d0             	imul   %eax,%edx
    18f3:	89 d0                	mov    %edx,%eax
    18f5:	01 c0                	add    %eax,%eax
    18f7:	01 c2                	add    %eax,%edx
    18f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18fc:	8b 40 30             	mov    0x30(%eax),%eax
    18ff:	83 ec 04             	sub    $0x4,%esp
    1902:	52                   	push   %edx
    1903:	68 ff ff ff 00       	push   $0xffffff
    1908:	50                   	push   %eax
    1909:	e8 f4 ea ff ff       	call   402 <memset>
    190e:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1911:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1914:	c9                   	leave  
    1915:	c3                   	ret    

00001916 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1916:	55                   	push   %ebp
    1917:	89 e5                	mov    %esp,%ebp
    1919:	53                   	push   %ebx
    191a:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    191d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1920:	83 f8 03             	cmp    $0x3,%eax
    1923:	74 02                	je     1927 <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1925:	eb 33                	jmp    195a <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    1927:	8b 45 08             	mov    0x8(%ebp),%eax
    192a:	8b 48 08             	mov    0x8(%eax),%ecx
    192d:	8b 45 08             	mov    0x8(%ebp),%eax
    1930:	8b 50 38             	mov    0x38(%eax),%edx
    1933:	8b 45 08             	mov    0x8(%ebp),%eax
    1936:	8b 40 34             	mov    0x34(%eax),%eax
    1939:	8b 5d 08             	mov    0x8(%ebp),%ebx
    193c:	83 c3 34             	add    $0x34,%ebx
    193f:	83 ec 0c             	sub    $0xc,%esp
    1942:	51                   	push   %ecx
    1943:	52                   	push   %edx
    1944:	50                   	push   %eax
    1945:	6a 00                	push   $0x0
    1947:	6a 00                	push   $0x0
    1949:	53                   	push   %ebx
    194a:	6a 32                	push   $0x32
    194c:	6a 00                	push   $0x0
    194e:	ff 75 08             	pushl  0x8(%ebp)
    1951:	e8 e7 ec ff ff       	call   63d <paintWindow>
    1956:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1959:	90                   	nop
        default: break;
            
            
    }
    return False;
    195a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    195f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1962:	c9                   	leave  
    1963:	c3                   	ret    

00001964 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1964:	55                   	push   %ebp
    1965:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1967:	8b 45 0c             	mov    0xc(%ebp),%eax
    196a:	8b 50 08             	mov    0x8(%eax),%edx
    196d:	8b 45 08             	mov    0x8(%ebp),%eax
    1970:	8b 00                	mov    (%eax),%eax
    1972:	39 c2                	cmp    %eax,%edx
    1974:	74 07                	je     197d <APPreJudge+0x19>
        return False;
    1976:	b8 00 00 00 00       	mov    $0x0,%eax
    197b:	eb 05                	jmp    1982 <APPreJudge+0x1e>
    return True;
    197d:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1982:	5d                   	pop    %ebp
    1983:	c3                   	ret    

00001984 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1984:	55                   	push   %ebp
    1985:	89 e5                	mov    %esp,%ebp
    1987:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    198a:	8b 45 08             	mov    0x8(%ebp),%eax
    198d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1990:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    1993:	83 ec 0c             	sub    $0xc,%esp
    1996:	ff 75 08             	pushl  0x8(%ebp)
    1999:	e8 bf ec ff ff       	call   65d <registWindow>
    199e:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19a1:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    19a8:	8b 45 08             	mov    0x8(%ebp),%eax
    19ab:	8b 00                	mov    (%eax),%eax
    19ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    19b0:	ff 75 f4             	pushl  -0xc(%ebp)
    19b3:	ff 75 f0             	pushl  -0x10(%ebp)
    19b6:	ff 75 ec             	pushl  -0x14(%ebp)
    19b9:	ff 75 08             	pushl  0x8(%ebp)
    19bc:	e8 e7 fc ff ff       	call   16a8 <APSendMessage>
    19c1:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19c4:	83 ec 0c             	sub    $0xc,%esp
    19c7:	ff 75 08             	pushl  0x8(%ebp)
    19ca:	e8 86 ec ff ff       	call   655 <getMessage>
    19cf:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	83 c0 6c             	add    $0x6c,%eax
    19d8:	83 ec 08             	sub    $0x8,%esp
    19db:	50                   	push   %eax
    19dc:	ff 75 08             	pushl  0x8(%ebp)
    19df:	e8 80 ff ff ff       	call   1964 <APPreJudge>
    19e4:	83 c4 10             	add    $0x10,%esp
    19e7:	84 c0                	test   %al,%al
    19e9:	74 1b                	je     1a06 <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    19eb:	8b 45 08             	mov    0x8(%ebp),%eax
    19ee:	ff 70 74             	pushl  0x74(%eax)
    19f1:	ff 70 70             	pushl  0x70(%eax)
    19f4:	ff 70 6c             	pushl  0x6c(%eax)
    19f7:	ff 75 08             	pushl  0x8(%ebp)
    19fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    19fd:	ff d0                	call   *%eax
    19ff:	83 c4 10             	add    $0x10,%esp
    1a02:	84 c0                	test   %al,%al
    1a04:	75 0c                	jne    1a12 <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1a06:	8b 45 08             	mov    0x8(%ebp),%eax
    1a09:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1a10:	eb b2                	jmp    19c4 <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a12:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a13:	90                   	nop
    1a14:	c9                   	leave  
    1a15:	c3                   	ret    

00001a16 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a16:	55                   	push   %ebp
    1a17:	89 e5                	mov    %esp,%ebp
    1a19:	57                   	push   %edi
    1a1a:	56                   	push   %esi
    1a1b:	53                   	push   %ebx
    1a1c:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a1f:	a1 80 2b 00 00       	mov    0x2b80,%eax
    1a24:	85 c0                	test   %eax,%eax
    1a26:	0f 85 2c 02 00 00    	jne    1c58 <APGridPaint+0x242>
    {
        iconReady = 1;
    1a2c:	c7 05 80 2b 00 00 01 	movl   $0x1,0x2b80
    1a33:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a36:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a39:	83 ec 08             	sub    $0x8,%esp
    1a3c:	68 e3 24 00 00       	push   $0x24e3
    1a41:	50                   	push   %eax
    1a42:	e8 83 f1 ff ff       	call   bca <APLoadBitmap>
    1a47:	83 c4 0c             	add    $0xc,%esp
    1a4a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a4d:	a3 a4 2b 00 00       	mov    %eax,0x2ba4
    1a52:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a55:	a3 a8 2b 00 00       	mov    %eax,0x2ba8
    1a5a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a5d:	a3 ac 2b 00 00       	mov    %eax,0x2bac
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a62:	83 ec 04             	sub    $0x4,%esp
    1a65:	ff 35 ac 2b 00 00    	pushl  0x2bac
    1a6b:	ff 35 a8 2b 00 00    	pushl  0x2ba8
    1a71:	ff 35 a4 2b 00 00    	pushl  0x2ba4
    1a77:	e8 88 f3 ff ff       	call   e04 <APCreateCompatibleDCFromBitmap>
    1a7c:	83 c4 10             	add    $0x10,%esp
    1a7f:	a3 b0 2b 00 00       	mov    %eax,0x2bb0
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a84:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a87:	83 ec 08             	sub    $0x8,%esp
    1a8a:	68 f1 24 00 00       	push   $0x24f1
    1a8f:	50                   	push   %eax
    1a90:	e8 35 f1 ff ff       	call   bca <APLoadBitmap>
    1a95:	83 c4 0c             	add    $0xc,%esp
    1a98:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a9b:	a3 e0 2b 00 00       	mov    %eax,0x2be0
    1aa0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aa3:	a3 e4 2b 00 00       	mov    %eax,0x2be4
    1aa8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aab:	a3 e8 2b 00 00       	mov    %eax,0x2be8
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1ab0:	83 ec 04             	sub    $0x4,%esp
    1ab3:	ff 35 e8 2b 00 00    	pushl  0x2be8
    1ab9:	ff 35 e4 2b 00 00    	pushl  0x2be4
    1abf:	ff 35 e0 2b 00 00    	pushl  0x2be0
    1ac5:	e8 3a f3 ff ff       	call   e04 <APCreateCompatibleDCFromBitmap>
    1aca:	83 c4 10             	add    $0x10,%esp
    1acd:	a3 d0 2b 00 00       	mov    %eax,0x2bd0
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1ad2:	8d 45 98             	lea    -0x68(%ebp),%eax
    1ad5:	83 ec 08             	sub    $0x8,%esp
    1ad8:	68 00 25 00 00       	push   $0x2500
    1add:	50                   	push   %eax
    1ade:	e8 e7 f0 ff ff       	call   bca <APLoadBitmap>
    1ae3:	83 c4 0c             	add    $0xc,%esp
    1ae6:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ae9:	a3 d4 2b 00 00       	mov    %eax,0x2bd4
    1aee:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1af1:	a3 d8 2b 00 00       	mov    %eax,0x2bd8
    1af6:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1af9:	a3 dc 2b 00 00       	mov    %eax,0x2bdc
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1afe:	83 ec 04             	sub    $0x4,%esp
    1b01:	ff 35 dc 2b 00 00    	pushl  0x2bdc
    1b07:	ff 35 d8 2b 00 00    	pushl  0x2bd8
    1b0d:	ff 35 d4 2b 00 00    	pushl  0x2bd4
    1b13:	e8 ec f2 ff ff       	call   e04 <APCreateCompatibleDCFromBitmap>
    1b18:	83 c4 10             	add    $0x10,%esp
    1b1b:	a3 84 2b 00 00       	mov    %eax,0x2b84
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b20:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b23:	83 ec 08             	sub    $0x8,%esp
    1b26:	68 0f 25 00 00       	push   $0x250f
    1b2b:	50                   	push   %eax
    1b2c:	e8 99 f0 ff ff       	call   bca <APLoadBitmap>
    1b31:	83 c4 0c             	add    $0xc,%esp
    1b34:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b37:	a3 b8 2b 00 00       	mov    %eax,0x2bb8
    1b3c:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b3f:	a3 bc 2b 00 00       	mov    %eax,0x2bbc
    1b44:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b47:	a3 c0 2b 00 00       	mov    %eax,0x2bc0
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b4c:	83 ec 04             	sub    $0x4,%esp
    1b4f:	ff 35 c0 2b 00 00    	pushl  0x2bc0
    1b55:	ff 35 bc 2b 00 00    	pushl  0x2bbc
    1b5b:	ff 35 b8 2b 00 00    	pushl  0x2bb8
    1b61:	e8 9e f2 ff ff       	call   e04 <APCreateCompatibleDCFromBitmap>
    1b66:	83 c4 10             	add    $0x10,%esp
    1b69:	a3 ec 2b 00 00       	mov    %eax,0x2bec
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b6e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b71:	83 ec 08             	sub    $0x8,%esp
    1b74:	68 1d 25 00 00       	push   $0x251d
    1b79:	50                   	push   %eax
    1b7a:	e8 4b f0 ff ff       	call   bca <APLoadBitmap>
    1b7f:	83 c4 0c             	add    $0xc,%esp
    1b82:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b85:	a3 94 2b 00 00       	mov    %eax,0x2b94
    1b8a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b8d:	a3 98 2b 00 00       	mov    %eax,0x2b98
    1b92:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b95:	a3 9c 2b 00 00       	mov    %eax,0x2b9c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b9a:	83 ec 04             	sub    $0x4,%esp
    1b9d:	ff 35 9c 2b 00 00    	pushl  0x2b9c
    1ba3:	ff 35 98 2b 00 00    	pushl  0x2b98
    1ba9:	ff 35 94 2b 00 00    	pushl  0x2b94
    1baf:	e8 50 f2 ff ff       	call   e04 <APCreateCompatibleDCFromBitmap>
    1bb4:	83 c4 10             	add    $0x10,%esp
    1bb7:	a3 b4 2b 00 00       	mov    %eax,0x2bb4
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1bbc:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bbf:	83 ec 08             	sub    $0x8,%esp
    1bc2:	68 2d 25 00 00       	push   $0x252d
    1bc7:	50                   	push   %eax
    1bc8:	e8 fd ef ff ff       	call   bca <APLoadBitmap>
    1bcd:	83 c4 0c             	add    $0xc,%esp
    1bd0:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bd3:	a3 88 2b 00 00       	mov    %eax,0x2b88
    1bd8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bdb:	a3 8c 2b 00 00       	mov    %eax,0x2b8c
    1be0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1be3:	a3 90 2b 00 00       	mov    %eax,0x2b90
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1be8:	83 ec 04             	sub    $0x4,%esp
    1beb:	ff 35 90 2b 00 00    	pushl  0x2b90
    1bf1:	ff 35 8c 2b 00 00    	pushl  0x2b8c
    1bf7:	ff 35 88 2b 00 00    	pushl  0x2b88
    1bfd:	e8 02 f2 ff ff       	call   e04 <APCreateCompatibleDCFromBitmap>
    1c02:	83 c4 10             	add    $0x10,%esp
    1c05:	a3 a0 2b 00 00       	mov    %eax,0x2ba0
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c0a:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c0d:	83 ec 08             	sub    $0x8,%esp
    1c10:	68 3f 25 00 00       	push   $0x253f
    1c15:	50                   	push   %eax
    1c16:	e8 af ef ff ff       	call   bca <APLoadBitmap>
    1c1b:	83 c4 0c             	add    $0xc,%esp
    1c1e:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c21:	a3 c4 2b 00 00       	mov    %eax,0x2bc4
    1c26:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c29:	a3 c8 2b 00 00       	mov    %eax,0x2bc8
    1c2e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c31:	a3 cc 2b 00 00       	mov    %eax,0x2bcc
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c36:	83 ec 04             	sub    $0x4,%esp
    1c39:	ff 35 cc 2b 00 00    	pushl  0x2bcc
    1c3f:	ff 35 c8 2b 00 00    	pushl  0x2bc8
    1c45:	ff 35 c4 2b 00 00    	pushl  0x2bc4
    1c4b:	e8 b4 f1 ff ff       	call   e04 <APCreateCompatibleDCFromBitmap>
    1c50:	83 c4 10             	add    $0x10,%esp
    1c53:	a3 f0 2b 00 00       	mov    %eax,0x2bf0
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c58:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5b:	8b 40 08             	mov    0x8(%eax),%eax
    1c5e:	85 c0                	test   %eax,%eax
    1c60:	75 17                	jne    1c79 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c62:	83 ec 08             	sub    $0x8,%esp
    1c65:	68 50 25 00 00       	push   $0x2550
    1c6a:	6a 01                	push   $0x1
    1c6c:	e8 d3 ea ff ff       	call   744 <printf>
    1c71:	83 c4 10             	add    $0x10,%esp
        return;
    1c74:	e9 f2 03 00 00       	jmp    206b <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c79:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7c:	8b 40 10             	mov    0x10(%eax),%eax
    1c7f:	85 c0                	test   %eax,%eax
    1c81:	7e 10                	jle    1c93 <APGridPaint+0x27d>
    1c83:	8b 45 08             	mov    0x8(%ebp),%eax
    1c86:	8b 50 14             	mov    0x14(%eax),%edx
    1c89:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8c:	8b 40 10             	mov    0x10(%eax),%eax
    1c8f:	39 c2                	cmp    %eax,%edx
    1c91:	7c 17                	jl     1caa <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1c93:	83 ec 08             	sub    $0x8,%esp
    1c96:	68 76 25 00 00       	push   $0x2576
    1c9b:	6a 01                	push   $0x1
    1c9d:	e8 a2 ea ff ff       	call   744 <printf>
    1ca2:	83 c4 10             	add    $0x10,%esp
        return;
    1ca5:	e9 c1 03 00 00       	jmp    206b <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1caa:	8b 45 08             	mov    0x8(%ebp),%eax
    1cad:	8b 40 14             	mov    0x14(%eax),%eax
    1cb0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1cb6:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1cb9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1cbc:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1cbf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1cc6:	e9 96 03 00 00       	jmp    2061 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1ccb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1cd2:	e9 7c 03 00 00       	jmp    2053 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1cd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cda:	c1 e0 04             	shl    $0x4,%eax
    1cdd:	89 c2                	mov    %eax,%edx
    1cdf:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1ce2:	01 c2                	add    %eax,%edx
    1ce4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ce7:	01 d0                	add    %edx,%eax
    1ce9:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1cec:	8b 45 08             	mov    0x8(%ebp),%eax
    1cef:	8b 40 0c             	mov    0xc(%eax),%eax
    1cf2:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1cf5:	c1 e2 02             	shl    $0x2,%edx
    1cf8:	01 d0                	add    %edx,%eax
    1cfa:	8b 00                	mov    (%eax),%eax
    1cfc:	83 f8 07             	cmp    $0x7,%eax
    1cff:	0f 87 49 03 00 00    	ja     204e <APGridPaint+0x638>
    1d05:	8b 04 85 8c 25 00 00 	mov    0x258c(,%eax,4),%eax
    1d0c:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d0e:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d11:	6a 0c                	push   $0xc
    1d13:	6a 0c                	push   $0xc
    1d15:	6a 0c                	push   $0xc
    1d17:	50                   	push   %eax
    1d18:	e8 46 f9 ff ff       	call   1663 <RGB>
    1d1d:	83 c4 0c             	add    $0xc,%esp
    1d20:	8b 1d b0 2b 00 00    	mov    0x2bb0,%ebx
    1d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d29:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d2f:	6b c0 32             	imul   $0x32,%eax,%eax
    1d32:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d35:	8b 45 08             	mov    0x8(%ebp),%eax
    1d38:	8d 78 34             	lea    0x34(%eax),%edi
    1d3b:	83 ec 0c             	sub    $0xc,%esp
    1d3e:	83 ec 04             	sub    $0x4,%esp
    1d41:	89 e0                	mov    %esp,%eax
    1d43:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d47:	66 89 30             	mov    %si,(%eax)
    1d4a:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d4e:	88 50 02             	mov    %dl,0x2(%eax)
    1d51:	6a 32                	push   $0x32
    1d53:	6a 32                	push   $0x32
    1d55:	6a 00                	push   $0x0
    1d57:	6a 00                	push   $0x0
    1d59:	53                   	push   %ebx
    1d5a:	51                   	push   %ecx
    1d5b:	ff 75 94             	pushl  -0x6c(%ebp)
    1d5e:	57                   	push   %edi
    1d5f:	e8 5b f7 ff ff       	call   14bf <APDcCopy>
    1d64:	83 c4 30             	add    $0x30,%esp
                    break;
    1d67:	e9 e3 02 00 00       	jmp    204f <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d6c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d6f:	6a 69                	push   $0x69
    1d71:	6a 69                	push   $0x69
    1d73:	6a 69                	push   $0x69
    1d75:	50                   	push   %eax
    1d76:	e8 e8 f8 ff ff       	call   1663 <RGB>
    1d7b:	83 c4 0c             	add    $0xc,%esp
    1d7e:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d82:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1d86:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d8a:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1d8d:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d94:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d97:	6a 69                	push   $0x69
    1d99:	6a 69                	push   $0x69
    1d9b:	6a 69                	push   $0x69
    1d9d:	50                   	push   %eax
    1d9e:	e8 c0 f8 ff ff       	call   1663 <RGB>
    1da3:	83 c4 0c             	add    $0xc,%esp
    1da6:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1daa:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1dae:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1db2:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1db5:	8b 45 08             	mov    0x8(%ebp),%eax
    1db8:	8d 50 34             	lea    0x34(%eax),%edx
    1dbb:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dbe:	ff 75 bc             	pushl  -0x44(%ebp)
    1dc1:	ff 75 b8             	pushl  -0x48(%ebp)
    1dc4:	52                   	push   %edx
    1dc5:	50                   	push   %eax
    1dc6:	e8 ce f0 ff ff       	call   e99 <APSetPen>
    1dcb:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1dce:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd1:	8d 58 34             	lea    0x34(%eax),%ebx
    1dd4:	8d 55 98             	lea    -0x68(%ebp),%edx
    1dd7:	83 ec 04             	sub    $0x4,%esp
    1dda:	83 ec 04             	sub    $0x4,%esp
    1ddd:	89 e0                	mov    %esp,%eax
    1ddf:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1de3:	66 89 08             	mov    %cx,(%eax)
    1de6:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1dea:	88 48 02             	mov    %cl,0x2(%eax)
    1ded:	53                   	push   %ebx
    1dee:	52                   	push   %edx
    1def:	e8 de f0 ff ff       	call   ed2 <APSetBrush>
    1df4:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1df7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1dfa:	6b d0 32             	imul   $0x32,%eax,%edx
    1dfd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e00:	6b c0 32             	imul   $0x32,%eax,%eax
    1e03:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e06:	83 c1 34             	add    $0x34,%ecx
    1e09:	83 ec 0c             	sub    $0xc,%esp
    1e0c:	6a 32                	push   $0x32
    1e0e:	6a 32                	push   $0x32
    1e10:	52                   	push   %edx
    1e11:	50                   	push   %eax
    1e12:	51                   	push   %ecx
    1e13:	e8 a2 f4 ff ff       	call   12ba <APDrawRect>
    1e18:	83 c4 20             	add    $0x20,%esp
                    break;
    1e1b:	e9 2f 02 00 00       	jmp    204f <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e20:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e23:	6a 0c                	push   $0xc
    1e25:	6a 0c                	push   $0xc
    1e27:	6a 0c                	push   $0xc
    1e29:	50                   	push   %eax
    1e2a:	e8 34 f8 ff ff       	call   1663 <RGB>
    1e2f:	83 c4 0c             	add    $0xc,%esp
    1e32:	8b 1d f0 2b 00 00    	mov    0x2bf0,%ebx
    1e38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e3b:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e41:	6b c0 32             	imul   $0x32,%eax,%eax
    1e44:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e47:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4a:	8d 78 34             	lea    0x34(%eax),%edi
    1e4d:	83 ec 0c             	sub    $0xc,%esp
    1e50:	83 ec 04             	sub    $0x4,%esp
    1e53:	89 e0                	mov    %esp,%eax
    1e55:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e59:	66 89 30             	mov    %si,(%eax)
    1e5c:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e60:	88 50 02             	mov    %dl,0x2(%eax)
    1e63:	6a 32                	push   $0x32
    1e65:	6a 32                	push   $0x32
    1e67:	6a 00                	push   $0x0
    1e69:	6a 00                	push   $0x0
    1e6b:	53                   	push   %ebx
    1e6c:	51                   	push   %ecx
    1e6d:	ff 75 94             	pushl  -0x6c(%ebp)
    1e70:	57                   	push   %edi
    1e71:	e8 49 f6 ff ff       	call   14bf <APDcCopy>
    1e76:	83 c4 30             	add    $0x30,%esp
                    break;
    1e79:	e9 d1 01 00 00       	jmp    204f <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e7e:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e81:	6a 0c                	push   $0xc
    1e83:	6a 0c                	push   $0xc
    1e85:	6a 0c                	push   $0xc
    1e87:	50                   	push   %eax
    1e88:	e8 d6 f7 ff ff       	call   1663 <RGB>
    1e8d:	83 c4 0c             	add    $0xc,%esp
    1e90:	8b 1d d0 2b 00 00    	mov    0x2bd0,%ebx
    1e96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e99:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e9f:	6b c0 32             	imul   $0x32,%eax,%eax
    1ea2:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ea5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea8:	8d 78 34             	lea    0x34(%eax),%edi
    1eab:	83 ec 0c             	sub    $0xc,%esp
    1eae:	83 ec 04             	sub    $0x4,%esp
    1eb1:	89 e0                	mov    %esp,%eax
    1eb3:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1eb7:	66 89 30             	mov    %si,(%eax)
    1eba:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1ebe:	88 50 02             	mov    %dl,0x2(%eax)
    1ec1:	6a 32                	push   $0x32
    1ec3:	6a 32                	push   $0x32
    1ec5:	6a 00                	push   $0x0
    1ec7:	6a 00                	push   $0x0
    1ec9:	53                   	push   %ebx
    1eca:	51                   	push   %ecx
    1ecb:	ff 75 94             	pushl  -0x6c(%ebp)
    1ece:	57                   	push   %edi
    1ecf:	e8 eb f5 ff ff       	call   14bf <APDcCopy>
    1ed4:	83 c4 30             	add    $0x30,%esp
                    break;
    1ed7:	e9 73 01 00 00       	jmp    204f <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1edc:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1edf:	6a 0c                	push   $0xc
    1ee1:	6a 0c                	push   $0xc
    1ee3:	6a 0c                	push   $0xc
    1ee5:	50                   	push   %eax
    1ee6:	e8 78 f7 ff ff       	call   1663 <RGB>
    1eeb:	83 c4 0c             	add    $0xc,%esp
    1eee:	8b 1d b4 2b 00 00    	mov    0x2bb4,%ebx
    1ef4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ef7:	6b c8 32             	imul   $0x32,%eax,%ecx
    1efa:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1efd:	6b c0 32             	imul   $0x32,%eax,%eax
    1f00:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f03:	8b 45 08             	mov    0x8(%ebp),%eax
    1f06:	8d 78 34             	lea    0x34(%eax),%edi
    1f09:	83 ec 0c             	sub    $0xc,%esp
    1f0c:	83 ec 04             	sub    $0x4,%esp
    1f0f:	89 e0                	mov    %esp,%eax
    1f11:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f15:	66 89 30             	mov    %si,(%eax)
    1f18:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f1c:	88 50 02             	mov    %dl,0x2(%eax)
    1f1f:	6a 32                	push   $0x32
    1f21:	6a 32                	push   $0x32
    1f23:	6a 00                	push   $0x0
    1f25:	6a 00                	push   $0x0
    1f27:	53                   	push   %ebx
    1f28:	51                   	push   %ecx
    1f29:	ff 75 94             	pushl  -0x6c(%ebp)
    1f2c:	57                   	push   %edi
    1f2d:	e8 8d f5 ff ff       	call   14bf <APDcCopy>
    1f32:	83 c4 30             	add    $0x30,%esp
                    break;
    1f35:	e9 15 01 00 00       	jmp    204f <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f3a:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f3d:	6a 0c                	push   $0xc
    1f3f:	6a 0c                	push   $0xc
    1f41:	6a 0c                	push   $0xc
    1f43:	50                   	push   %eax
    1f44:	e8 1a f7 ff ff       	call   1663 <RGB>
    1f49:	83 c4 0c             	add    $0xc,%esp
    1f4c:	8b 1d ec 2b 00 00    	mov    0x2bec,%ebx
    1f52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f55:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f58:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f5b:	6b c0 32             	imul   $0x32,%eax,%eax
    1f5e:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f61:	8b 45 08             	mov    0x8(%ebp),%eax
    1f64:	8d 78 34             	lea    0x34(%eax),%edi
    1f67:	83 ec 0c             	sub    $0xc,%esp
    1f6a:	83 ec 04             	sub    $0x4,%esp
    1f6d:	89 e0                	mov    %esp,%eax
    1f6f:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f73:	66 89 30             	mov    %si,(%eax)
    1f76:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f7a:	88 50 02             	mov    %dl,0x2(%eax)
    1f7d:	6a 32                	push   $0x32
    1f7f:	6a 32                	push   $0x32
    1f81:	6a 00                	push   $0x0
    1f83:	6a 00                	push   $0x0
    1f85:	53                   	push   %ebx
    1f86:	51                   	push   %ecx
    1f87:	ff 75 94             	pushl  -0x6c(%ebp)
    1f8a:	57                   	push   %edi
    1f8b:	e8 2f f5 ff ff       	call   14bf <APDcCopy>
    1f90:	83 c4 30             	add    $0x30,%esp
                    break;
    1f93:	e9 b7 00 00 00       	jmp    204f <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f98:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f9b:	6a 0c                	push   $0xc
    1f9d:	6a 0c                	push   $0xc
    1f9f:	6a 0c                	push   $0xc
    1fa1:	50                   	push   %eax
    1fa2:	e8 bc f6 ff ff       	call   1663 <RGB>
    1fa7:	83 c4 0c             	add    $0xc,%esp
    1faa:	8b 1d 84 2b 00 00    	mov    0x2b84,%ebx
    1fb0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fb3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fb6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fb9:	6b c0 32             	imul   $0x32,%eax,%eax
    1fbc:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fbf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc2:	8d 78 34             	lea    0x34(%eax),%edi
    1fc5:	83 ec 0c             	sub    $0xc,%esp
    1fc8:	83 ec 04             	sub    $0x4,%esp
    1fcb:	89 e0                	mov    %esp,%eax
    1fcd:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1fd1:	66 89 30             	mov    %si,(%eax)
    1fd4:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1fd8:	88 50 02             	mov    %dl,0x2(%eax)
    1fdb:	6a 32                	push   $0x32
    1fdd:	6a 32                	push   $0x32
    1fdf:	6a 00                	push   $0x0
    1fe1:	6a 00                	push   $0x0
    1fe3:	53                   	push   %ebx
    1fe4:	51                   	push   %ecx
    1fe5:	ff 75 94             	pushl  -0x6c(%ebp)
    1fe8:	57                   	push   %edi
    1fe9:	e8 d1 f4 ff ff       	call   14bf <APDcCopy>
    1fee:	83 c4 30             	add    $0x30,%esp
                    break;
    1ff1:	eb 5c                	jmp    204f <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ff3:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1ff6:	6a 0c                	push   $0xc
    1ff8:	6a 0c                	push   $0xc
    1ffa:	6a 0c                	push   $0xc
    1ffc:	50                   	push   %eax
    1ffd:	e8 61 f6 ff ff       	call   1663 <RGB>
    2002:	83 c4 0c             	add    $0xc,%esp
    2005:	8b 1d a0 2b 00 00    	mov    0x2ba0,%ebx
    200b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    200e:	6b c8 32             	imul   $0x32,%eax,%ecx
    2011:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2014:	6b c0 32             	imul   $0x32,%eax,%eax
    2017:	89 45 94             	mov    %eax,-0x6c(%ebp)
    201a:	8b 45 08             	mov    0x8(%ebp),%eax
    201d:	8d 78 34             	lea    0x34(%eax),%edi
    2020:	83 ec 0c             	sub    $0xc,%esp
    2023:	83 ec 04             	sub    $0x4,%esp
    2026:	89 e0                	mov    %esp,%eax
    2028:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    202c:	66 89 30             	mov    %si,(%eax)
    202f:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2033:	88 50 02             	mov    %dl,0x2(%eax)
    2036:	6a 32                	push   $0x32
    2038:	6a 32                	push   $0x32
    203a:	6a 00                	push   $0x0
    203c:	6a 00                	push   $0x0
    203e:	53                   	push   %ebx
    203f:	51                   	push   %ecx
    2040:	ff 75 94             	pushl  -0x6c(%ebp)
    2043:	57                   	push   %edi
    2044:	e8 76 f4 ff ff       	call   14bf <APDcCopy>
    2049:	83 c4 30             	add    $0x30,%esp
                    break;
    204c:	eb 01                	jmp    204f <APGridPaint+0x639>
                default: break;
    204e:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    204f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    2053:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    2057:	0f 8e 7a fc ff ff    	jle    1cd7 <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    205d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2061:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    2065:	0f 8e 60 fc ff ff    	jle    1ccb <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    206b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    206e:	5b                   	pop    %ebx
    206f:	5e                   	pop    %esi
    2070:	5f                   	pop    %edi
    2071:	5d                   	pop    %ebp
    2072:	c3                   	ret    

00002073 <random>:
//

#include "APLib.h"

int random(int seed)
{
    2073:	55                   	push   %ebp
    2074:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2076:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    207a:	7e 08                	jle    2084 <random+0x11>
{
rand_num = seed;
    207c:	8b 45 08             	mov    0x8(%ebp),%eax
    207f:	a3 4c 2b 00 00       	mov    %eax,0x2b4c
}
rand_num *= 3;
    2084:	8b 15 4c 2b 00 00    	mov    0x2b4c,%edx
    208a:	89 d0                	mov    %edx,%eax
    208c:	01 c0                	add    %eax,%eax
    208e:	01 d0                	add    %edx,%eax
    2090:	a3 4c 2b 00 00       	mov    %eax,0x2b4c
if (rand_num < 0)
    2095:	a1 4c 2b 00 00       	mov    0x2b4c,%eax
    209a:	85 c0                	test   %eax,%eax
    209c:	79 0c                	jns    20aa <random+0x37>
{
rand_num *= (-1);
    209e:	a1 4c 2b 00 00       	mov    0x2b4c,%eax
    20a3:	f7 d8                	neg    %eax
    20a5:	a3 4c 2b 00 00       	mov    %eax,0x2b4c
}
return rand_num % 997;
    20aa:	8b 0d 4c 2b 00 00    	mov    0x2b4c,%ecx
    20b0:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    20b5:	89 c8                	mov    %ecx,%eax
    20b7:	f7 ea                	imul   %edx
    20b9:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    20bc:	c1 f8 09             	sar    $0x9,%eax
    20bf:	89 c2                	mov    %eax,%edx
    20c1:	89 c8                	mov    %ecx,%eax
    20c3:	c1 f8 1f             	sar    $0x1f,%eax
    20c6:	29 c2                	sub    %eax,%edx
    20c8:	89 d0                	mov    %edx,%eax
    20ca:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    20d0:	29 c1                	sub    %eax,%ecx
    20d2:	89 c8                	mov    %ecx,%eax
}
    20d4:	5d                   	pop    %ebp
    20d5:	c3                   	ret    

000020d6 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    20d6:	55                   	push   %ebp
    20d7:	89 e5                	mov    %esp,%ebp
    20d9:	53                   	push   %ebx
    20da:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    20dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    20e4:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    20e8:	74 17                	je     2101 <sprintint+0x2b>
    20ea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    20ee:	79 11                	jns    2101 <sprintint+0x2b>
        neg = 1;
    20f0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    20f7:	8b 45 10             	mov    0x10(%ebp),%eax
    20fa:	f7 d8                	neg    %eax
    20fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20ff:	eb 06                	jmp    2107 <sprintint+0x31>
    } else {
        x = xx;
    2101:	8b 45 10             	mov    0x10(%ebp),%eax
    2104:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    2107:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    210e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2111:	8d 41 01             	lea    0x1(%ecx),%eax
    2114:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2117:	8b 5d 14             	mov    0x14(%ebp),%ebx
    211a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    211d:	ba 00 00 00 00       	mov    $0x0,%edx
    2122:	f7 f3                	div    %ebx
    2124:	89 d0                	mov    %edx,%eax
    2126:	0f b6 80 50 2b 00 00 	movzbl 0x2b50(%eax),%eax
    212d:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2131:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2134:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2137:	ba 00 00 00 00       	mov    $0x0,%edx
    213c:	f7 f3                	div    %ebx
    213e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2141:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2145:	75 c7                	jne    210e <sprintint+0x38>
    if(neg)
    2147:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    214b:	74 0e                	je     215b <sprintint+0x85>
        buf[i++] = '-';
    214d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2150:	8d 50 01             	lea    0x1(%eax),%edx
    2153:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2156:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    215b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    215e:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2161:	eb 1b                	jmp    217e <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2163:	8b 45 0c             	mov    0xc(%ebp),%eax
    2166:	8b 00                	mov    (%eax),%eax
    2168:	8d 48 01             	lea    0x1(%eax),%ecx
    216b:	8b 55 0c             	mov    0xc(%ebp),%edx
    216e:	89 0a                	mov    %ecx,(%edx)
    2170:	89 c2                	mov    %eax,%edx
    2172:	8b 45 08             	mov    0x8(%ebp),%eax
    2175:	01 d0                	add    %edx,%eax
    2177:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    217a:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    217e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2182:	7f df                	jg     2163 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2184:	eb 21                	jmp    21a7 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2186:	8b 45 0c             	mov    0xc(%ebp),%eax
    2189:	8b 00                	mov    (%eax),%eax
    218b:	8d 48 01             	lea    0x1(%eax),%ecx
    218e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2191:	89 0a                	mov    %ecx,(%edx)
    2193:	89 c2                	mov    %eax,%edx
    2195:	8b 45 08             	mov    0x8(%ebp),%eax
    2198:	01 c2                	add    %eax,%edx
    219a:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    219d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    21a0:	01 c8                	add    %ecx,%eax
    21a2:	0f b6 00             	movzbl (%eax),%eax
    21a5:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    21a7:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    21ab:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    21af:	79 d5                	jns    2186 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    21b1:	90                   	nop
    21b2:	83 c4 20             	add    $0x20,%esp
    21b5:	5b                   	pop    %ebx
    21b6:	5d                   	pop    %ebp
    21b7:	c3                   	ret    

000021b8 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    21b8:	55                   	push   %ebp
    21b9:	89 e5                	mov    %esp,%ebp
    21bb:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    21be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    21c5:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    21cc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    21d3:	8d 45 0c             	lea    0xc(%ebp),%eax
    21d6:	83 c0 04             	add    $0x4,%eax
    21d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    21dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    21e3:	e9 d9 01 00 00       	jmp    23c1 <sprintf+0x209>
        c = fmt[i] & 0xff;
    21e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    21eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    21ee:	01 d0                	add    %edx,%eax
    21f0:	0f b6 00             	movzbl (%eax),%eax
    21f3:	0f be c0             	movsbl %al,%eax
    21f6:	25 ff 00 00 00       	and    $0xff,%eax
    21fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    21fe:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2202:	75 2c                	jne    2230 <sprintf+0x78>
            if(c == '%'){
    2204:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2208:	75 0c                	jne    2216 <sprintf+0x5e>
                state = '%';
    220a:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2211:	e9 a7 01 00 00       	jmp    23bd <sprintf+0x205>
            } else {
                dst[j++] = c;
    2216:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2219:	8d 50 01             	lea    0x1(%eax),%edx
    221c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    221f:	89 c2                	mov    %eax,%edx
    2221:	8b 45 08             	mov    0x8(%ebp),%eax
    2224:	01 d0                	add    %edx,%eax
    2226:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2229:	88 10                	mov    %dl,(%eax)
    222b:	e9 8d 01 00 00       	jmp    23bd <sprintf+0x205>
            }
        } else if(state == '%'){
    2230:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2234:	0f 85 83 01 00 00    	jne    23bd <sprintf+0x205>
            if(c == 'd'){
    223a:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    223e:	75 4c                	jne    228c <sprintf+0xd4>
                buf[bi] = '\0';
    2240:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2243:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2246:	01 d0                	add    %edx,%eax
    2248:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    224b:	83 ec 0c             	sub    $0xc,%esp
    224e:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2251:	50                   	push   %eax
    2252:	e8 b4 e2 ff ff       	call   50b <atoi>
    2257:	83 c4 10             	add    $0x10,%esp
    225a:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    225d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2264:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2267:	8b 00                	mov    (%eax),%eax
    2269:	83 ec 08             	sub    $0x8,%esp
    226c:	ff 75 d8             	pushl  -0x28(%ebp)
    226f:	6a 01                	push   $0x1
    2271:	6a 0a                	push   $0xa
    2273:	50                   	push   %eax
    2274:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2277:	50                   	push   %eax
    2278:	ff 75 08             	pushl  0x8(%ebp)
    227b:	e8 56 fe ff ff       	call   20d6 <sprintint>
    2280:	83 c4 20             	add    $0x20,%esp
                ap++;
    2283:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2287:	e9 2a 01 00 00       	jmp    23b6 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    228c:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2290:	74 06                	je     2298 <sprintf+0xe0>
    2292:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2296:	75 4c                	jne    22e4 <sprintf+0x12c>
                buf[bi] = '\0';
    2298:	8d 55 ce             	lea    -0x32(%ebp),%edx
    229b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    229e:	01 d0                	add    %edx,%eax
    22a0:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    22a3:	83 ec 0c             	sub    $0xc,%esp
    22a6:	8d 45 ce             	lea    -0x32(%ebp),%eax
    22a9:	50                   	push   %eax
    22aa:	e8 5c e2 ff ff       	call   50b <atoi>
    22af:	83 c4 10             	add    $0x10,%esp
    22b2:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    22b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    22bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22bf:	8b 00                	mov    (%eax),%eax
    22c1:	83 ec 08             	sub    $0x8,%esp
    22c4:	ff 75 dc             	pushl  -0x24(%ebp)
    22c7:	6a 00                	push   $0x0
    22c9:	6a 10                	push   $0x10
    22cb:	50                   	push   %eax
    22cc:	8d 45 c8             	lea    -0x38(%ebp),%eax
    22cf:	50                   	push   %eax
    22d0:	ff 75 08             	pushl  0x8(%ebp)
    22d3:	e8 fe fd ff ff       	call   20d6 <sprintint>
    22d8:	83 c4 20             	add    $0x20,%esp
                ap++;
    22db:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    22df:	e9 d2 00 00 00       	jmp    23b6 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    22e4:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    22e8:	75 46                	jne    2330 <sprintf+0x178>
                s = (char*)*ap;
    22ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22ed:	8b 00                	mov    (%eax),%eax
    22ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    22f2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    22f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22fa:	75 25                	jne    2321 <sprintf+0x169>
                    s = "(null)";
    22fc:	c7 45 f4 ac 25 00 00 	movl   $0x25ac,-0xc(%ebp)
                while(*s != 0){
    2303:	eb 1c                	jmp    2321 <sprintf+0x169>
                    dst[j++] = *s;
    2305:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2308:	8d 50 01             	lea    0x1(%eax),%edx
    230b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    230e:	89 c2                	mov    %eax,%edx
    2310:	8b 45 08             	mov    0x8(%ebp),%eax
    2313:	01 c2                	add    %eax,%edx
    2315:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2318:	0f b6 00             	movzbl (%eax),%eax
    231b:	88 02                	mov    %al,(%edx)
                    s++;
    231d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2321:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2324:	0f b6 00             	movzbl (%eax),%eax
    2327:	84 c0                	test   %al,%al
    2329:	75 da                	jne    2305 <sprintf+0x14d>
    232b:	e9 86 00 00 00       	jmp    23b6 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2330:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2334:	75 1d                	jne    2353 <sprintf+0x19b>
                dst[j++] = *ap;
    2336:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2339:	8d 50 01             	lea    0x1(%eax),%edx
    233c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    233f:	89 c2                	mov    %eax,%edx
    2341:	8b 45 08             	mov    0x8(%ebp),%eax
    2344:	01 c2                	add    %eax,%edx
    2346:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2349:	8b 00                	mov    (%eax),%eax
    234b:	88 02                	mov    %al,(%edx)
                ap++;
    234d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2351:	eb 63                	jmp    23b6 <sprintf+0x1fe>
            } else if(c == '%'){
    2353:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2357:	75 17                	jne    2370 <sprintf+0x1b8>
                dst[j++] = c;
    2359:	8b 45 c8             	mov    -0x38(%ebp),%eax
    235c:	8d 50 01             	lea    0x1(%eax),%edx
    235f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2362:	89 c2                	mov    %eax,%edx
    2364:	8b 45 08             	mov    0x8(%ebp),%eax
    2367:	01 d0                	add    %edx,%eax
    2369:	8b 55 e0             	mov    -0x20(%ebp),%edx
    236c:	88 10                	mov    %dl,(%eax)
    236e:	eb 46                	jmp    23b6 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2370:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2374:	7e 18                	jle    238e <sprintf+0x1d6>
    2376:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    237a:	7f 12                	jg     238e <sprintf+0x1d6>
            {
                buf[bi++] = c;
    237c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    237f:	8d 50 01             	lea    0x1(%eax),%edx
    2382:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2385:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2388:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    238c:	eb 2f                	jmp    23bd <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    238e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2391:	8d 50 01             	lea    0x1(%eax),%edx
    2394:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2397:	89 c2                	mov    %eax,%edx
    2399:	8b 45 08             	mov    0x8(%ebp),%eax
    239c:	01 d0                	add    %edx,%eax
    239e:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    23a1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23a4:	8d 50 01             	lea    0x1(%eax),%edx
    23a7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23aa:	89 c2                	mov    %eax,%edx
    23ac:	8b 45 08             	mov    0x8(%ebp),%eax
    23af:	01 d0                	add    %edx,%eax
    23b1:	8b 55 e0             	mov    -0x20(%ebp),%edx
    23b4:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    23b6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    23bd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    23c1:	8b 55 0c             	mov    0xc(%ebp),%edx
    23c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    23c7:	01 d0                	add    %edx,%eax
    23c9:	0f b6 00             	movzbl (%eax),%eax
    23cc:	84 c0                	test   %al,%al
    23ce:	0f 85 14 fe ff ff    	jne    21e8 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    23d4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    23d7:	8d 50 01             	lea    0x1(%eax),%edx
    23da:	89 55 c8             	mov    %edx,-0x38(%ebp)
    23dd:	89 c2                	mov    %eax,%edx
    23df:	8b 45 08             	mov    0x8(%ebp),%eax
    23e2:	01 d0                	add    %edx,%eax
    23e4:	c6 00 00             	movb   $0x0,(%eax)
}
    23e7:	90                   	nop
    23e8:	c9                   	leave  
    23e9:	c3                   	ret    
