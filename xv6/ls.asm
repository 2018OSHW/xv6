
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
      68:	68 d4 2a 00 00       	push   $0x2ad4
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
      9a:	05 d4 2a 00 00       	add    $0x2ad4,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 d4 2a 00 00       	mov    $0x2ad4,%eax
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
      e3:	68 80 23 00 00       	push   $0x2380
      e8:	6a 02                	push   $0x2
      ea:	e8 4d 06 00 00       	call   73c <printf>
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
     116:	68 94 23 00 00       	push   $0x2394
     11b:	6a 02                	push   $0x2
     11d:	e8 1a 06 00 00       	call   73c <printf>
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
     179:	68 a8 23 00 00       	push   $0x23a8
     17e:	6a 01                	push   $0x1
     180:	e8 b7 05 00 00       	call   73c <printf>
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
     1a8:	68 b5 23 00 00       	push   $0x23b5
     1ad:	6a 01                	push   $0x1
     1af:	e8 88 05 00 00       	call   73c <printf>
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
     25c:	68 94 23 00 00       	push   $0x2394
     261:	6a 01                	push   $0x1
     263:	e8 d4 04 00 00       	call   73c <printf>
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
     29c:	68 a8 23 00 00       	push   $0x23a8
     2a1:	6a 01                	push   $0x1
     2a3:	e8 94 04 00 00       	call   73c <printf>
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
     2fe:	68 c8 23 00 00       	push   $0x23c8
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

00000665 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     665:	55                   	push   %ebp
     666:	89 e5                	mov    %esp,%ebp
     668:	83 ec 18             	sub    $0x18,%esp
     66b:	8b 45 0c             	mov    0xc(%ebp),%eax
     66e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     671:	83 ec 04             	sub    $0x4,%esp
     674:	6a 01                	push   $0x1
     676:	8d 45 f4             	lea    -0xc(%ebp),%eax
     679:	50                   	push   %eax
     67a:	ff 75 08             	pushl  0x8(%ebp)
     67d:	e8 3b ff ff ff       	call   5bd <write>
     682:	83 c4 10             	add    $0x10,%esp
}
     685:	90                   	nop
     686:	c9                   	leave  
     687:	c3                   	ret    

00000688 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     688:	55                   	push   %ebp
     689:	89 e5                	mov    %esp,%ebp
     68b:	53                   	push   %ebx
     68c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     68f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     696:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     69a:	74 17                	je     6b3 <printint+0x2b>
     69c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6a0:	79 11                	jns    6b3 <printint+0x2b>
    neg = 1;
     6a2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6ac:	f7 d8                	neg    %eax
     6ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6b1:	eb 06                	jmp    6b9 <printint+0x31>
  } else {
    x = xx;
     6b3:	8b 45 0c             	mov    0xc(%ebp),%eax
     6b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6c0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6c3:	8d 41 01             	lea    0x1(%ecx),%eax
     6c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6c9:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6cf:	ba 00 00 00 00       	mov    $0x0,%edx
     6d4:	f7 f3                	div    %ebx
     6d6:	89 d0                	mov    %edx,%eax
     6d8:	0f b6 80 ac 2a 00 00 	movzbl 0x2aac(%eax),%eax
     6df:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     6e3:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6e9:	ba 00 00 00 00       	mov    $0x0,%edx
     6ee:	f7 f3                	div    %ebx
     6f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6f7:	75 c7                	jne    6c0 <printint+0x38>
  if(neg)
     6f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6fd:	74 2d                	je     72c <printint+0xa4>
    buf[i++] = '-';
     6ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     702:	8d 50 01             	lea    0x1(%eax),%edx
     705:	89 55 f4             	mov    %edx,-0xc(%ebp)
     708:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     70d:	eb 1d                	jmp    72c <printint+0xa4>
    putc(fd, buf[i]);
     70f:	8d 55 dc             	lea    -0x24(%ebp),%edx
     712:	8b 45 f4             	mov    -0xc(%ebp),%eax
     715:	01 d0                	add    %edx,%eax
     717:	0f b6 00             	movzbl (%eax),%eax
     71a:	0f be c0             	movsbl %al,%eax
     71d:	83 ec 08             	sub    $0x8,%esp
     720:	50                   	push   %eax
     721:	ff 75 08             	pushl  0x8(%ebp)
     724:	e8 3c ff ff ff       	call   665 <putc>
     729:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     72c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     730:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     734:	79 d9                	jns    70f <printint+0x87>
    putc(fd, buf[i]);
}
     736:	90                   	nop
     737:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     73a:	c9                   	leave  
     73b:	c3                   	ret    

0000073c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     73c:	55                   	push   %ebp
     73d:	89 e5                	mov    %esp,%ebp
     73f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     742:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     749:	8d 45 0c             	lea    0xc(%ebp),%eax
     74c:	83 c0 04             	add    $0x4,%eax
     74f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     752:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     759:	e9 59 01 00 00       	jmp    8b7 <printf+0x17b>
    c = fmt[i] & 0xff;
     75e:	8b 55 0c             	mov    0xc(%ebp),%edx
     761:	8b 45 f0             	mov    -0x10(%ebp),%eax
     764:	01 d0                	add    %edx,%eax
     766:	0f b6 00             	movzbl (%eax),%eax
     769:	0f be c0             	movsbl %al,%eax
     76c:	25 ff 00 00 00       	and    $0xff,%eax
     771:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     774:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     778:	75 2c                	jne    7a6 <printf+0x6a>
      if(c == '%'){
     77a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     77e:	75 0c                	jne    78c <printf+0x50>
        state = '%';
     780:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     787:	e9 27 01 00 00       	jmp    8b3 <printf+0x177>
      } else {
        putc(fd, c);
     78c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     78f:	0f be c0             	movsbl %al,%eax
     792:	83 ec 08             	sub    $0x8,%esp
     795:	50                   	push   %eax
     796:	ff 75 08             	pushl  0x8(%ebp)
     799:	e8 c7 fe ff ff       	call   665 <putc>
     79e:	83 c4 10             	add    $0x10,%esp
     7a1:	e9 0d 01 00 00       	jmp    8b3 <printf+0x177>
      }
    } else if(state == '%'){
     7a6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7aa:	0f 85 03 01 00 00    	jne    8b3 <printf+0x177>
      if(c == 'd'){
     7b0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7b4:	75 1e                	jne    7d4 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7b9:	8b 00                	mov    (%eax),%eax
     7bb:	6a 01                	push   $0x1
     7bd:	6a 0a                	push   $0xa
     7bf:	50                   	push   %eax
     7c0:	ff 75 08             	pushl  0x8(%ebp)
     7c3:	e8 c0 fe ff ff       	call   688 <printint>
     7c8:	83 c4 10             	add    $0x10,%esp
        ap++;
     7cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7cf:	e9 d8 00 00 00       	jmp    8ac <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7d4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7d8:	74 06                	je     7e0 <printf+0xa4>
     7da:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7de:	75 1e                	jne    7fe <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7e3:	8b 00                	mov    (%eax),%eax
     7e5:	6a 00                	push   $0x0
     7e7:	6a 10                	push   $0x10
     7e9:	50                   	push   %eax
     7ea:	ff 75 08             	pushl  0x8(%ebp)
     7ed:	e8 96 fe ff ff       	call   688 <printint>
     7f2:	83 c4 10             	add    $0x10,%esp
        ap++;
     7f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7f9:	e9 ae 00 00 00       	jmp    8ac <printf+0x170>
      } else if(c == 's'){
     7fe:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     802:	75 43                	jne    847 <printf+0x10b>
        s = (char*)*ap;
     804:	8b 45 e8             	mov    -0x18(%ebp),%eax
     807:	8b 00                	mov    (%eax),%eax
     809:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     80c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     810:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     814:	75 25                	jne    83b <printf+0xff>
          s = "(null)";
     816:	c7 45 f4 ca 23 00 00 	movl   $0x23ca,-0xc(%ebp)
        while(*s != 0){
     81d:	eb 1c                	jmp    83b <printf+0xff>
          putc(fd, *s);
     81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     822:	0f b6 00             	movzbl (%eax),%eax
     825:	0f be c0             	movsbl %al,%eax
     828:	83 ec 08             	sub    $0x8,%esp
     82b:	50                   	push   %eax
     82c:	ff 75 08             	pushl  0x8(%ebp)
     82f:	e8 31 fe ff ff       	call   665 <putc>
     834:	83 c4 10             	add    $0x10,%esp
          s++;
     837:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     83b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83e:	0f b6 00             	movzbl (%eax),%eax
     841:	84 c0                	test   %al,%al
     843:	75 da                	jne    81f <printf+0xe3>
     845:	eb 65                	jmp    8ac <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     847:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     84b:	75 1d                	jne    86a <printf+0x12e>
        putc(fd, *ap);
     84d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     850:	8b 00                	mov    (%eax),%eax
     852:	0f be c0             	movsbl %al,%eax
     855:	83 ec 08             	sub    $0x8,%esp
     858:	50                   	push   %eax
     859:	ff 75 08             	pushl  0x8(%ebp)
     85c:	e8 04 fe ff ff       	call   665 <putc>
     861:	83 c4 10             	add    $0x10,%esp
        ap++;
     864:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     868:	eb 42                	jmp    8ac <printf+0x170>
      } else if(c == '%'){
     86a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     86e:	75 17                	jne    887 <printf+0x14b>
        putc(fd, c);
     870:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     873:	0f be c0             	movsbl %al,%eax
     876:	83 ec 08             	sub    $0x8,%esp
     879:	50                   	push   %eax
     87a:	ff 75 08             	pushl  0x8(%ebp)
     87d:	e8 e3 fd ff ff       	call   665 <putc>
     882:	83 c4 10             	add    $0x10,%esp
     885:	eb 25                	jmp    8ac <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     887:	83 ec 08             	sub    $0x8,%esp
     88a:	6a 25                	push   $0x25
     88c:	ff 75 08             	pushl  0x8(%ebp)
     88f:	e8 d1 fd ff ff       	call   665 <putc>
     894:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     897:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     89a:	0f be c0             	movsbl %al,%eax
     89d:	83 ec 08             	sub    $0x8,%esp
     8a0:	50                   	push   %eax
     8a1:	ff 75 08             	pushl  0x8(%ebp)
     8a4:	e8 bc fd ff ff       	call   665 <putc>
     8a9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8b3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8b7:	8b 55 0c             	mov    0xc(%ebp),%edx
     8ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8bd:	01 d0                	add    %edx,%eax
     8bf:	0f b6 00             	movzbl (%eax),%eax
     8c2:	84 c0                	test   %al,%al
     8c4:	0f 85 94 fe ff ff    	jne    75e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8ca:	90                   	nop
     8cb:	c9                   	leave  
     8cc:	c3                   	ret    

000008cd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8cd:	55                   	push   %ebp
     8ce:	89 e5                	mov    %esp,%ebp
     8d0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8d3:	8b 45 08             	mov    0x8(%ebp),%eax
     8d6:	83 e8 08             	sub    $0x8,%eax
     8d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8dc:	a1 ec 2a 00 00       	mov    0x2aec,%eax
     8e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8e4:	eb 24                	jmp    90a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8e9:	8b 00                	mov    (%eax),%eax
     8eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8ee:	77 12                	ja     902 <free+0x35>
     8f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8f6:	77 24                	ja     91c <free+0x4f>
     8f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8fb:	8b 00                	mov    (%eax),%eax
     8fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     900:	77 1a                	ja     91c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     902:	8b 45 fc             	mov    -0x4(%ebp),%eax
     905:	8b 00                	mov    (%eax),%eax
     907:	89 45 fc             	mov    %eax,-0x4(%ebp)
     90a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     90d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     910:	76 d4                	jbe    8e6 <free+0x19>
     912:	8b 45 fc             	mov    -0x4(%ebp),%eax
     915:	8b 00                	mov    (%eax),%eax
     917:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     91a:	76 ca                	jbe    8e6 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     91c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     91f:	8b 40 04             	mov    0x4(%eax),%eax
     922:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     929:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92c:	01 c2                	add    %eax,%edx
     92e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     931:	8b 00                	mov    (%eax),%eax
     933:	39 c2                	cmp    %eax,%edx
     935:	75 24                	jne    95b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     937:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93a:	8b 50 04             	mov    0x4(%eax),%edx
     93d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     940:	8b 00                	mov    (%eax),%eax
     942:	8b 40 04             	mov    0x4(%eax),%eax
     945:	01 c2                	add    %eax,%edx
     947:	8b 45 f8             	mov    -0x8(%ebp),%eax
     94a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     94d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     950:	8b 00                	mov    (%eax),%eax
     952:	8b 10                	mov    (%eax),%edx
     954:	8b 45 f8             	mov    -0x8(%ebp),%eax
     957:	89 10                	mov    %edx,(%eax)
     959:	eb 0a                	jmp    965 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     95b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95e:	8b 10                	mov    (%eax),%edx
     960:	8b 45 f8             	mov    -0x8(%ebp),%eax
     963:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     965:	8b 45 fc             	mov    -0x4(%ebp),%eax
     968:	8b 40 04             	mov    0x4(%eax),%eax
     96b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     972:	8b 45 fc             	mov    -0x4(%ebp),%eax
     975:	01 d0                	add    %edx,%eax
     977:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     97a:	75 20                	jne    99c <free+0xcf>
    p->s.size += bp->s.size;
     97c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97f:	8b 50 04             	mov    0x4(%eax),%edx
     982:	8b 45 f8             	mov    -0x8(%ebp),%eax
     985:	8b 40 04             	mov    0x4(%eax),%eax
     988:	01 c2                	add    %eax,%edx
     98a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     990:	8b 45 f8             	mov    -0x8(%ebp),%eax
     993:	8b 10                	mov    (%eax),%edx
     995:	8b 45 fc             	mov    -0x4(%ebp),%eax
     998:	89 10                	mov    %edx,(%eax)
     99a:	eb 08                	jmp    9a4 <free+0xd7>
  } else
    p->s.ptr = bp;
     99c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99f:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9a2:	89 10                	mov    %edx,(%eax)
  freep = p;
     9a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a7:	a3 ec 2a 00 00       	mov    %eax,0x2aec
}
     9ac:	90                   	nop
     9ad:	c9                   	leave  
     9ae:	c3                   	ret    

000009af <morecore>:

static Header*
morecore(uint nu)
{
     9af:	55                   	push   %ebp
     9b0:	89 e5                	mov    %esp,%ebp
     9b2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9b5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9bc:	77 07                	ja     9c5 <morecore+0x16>
    nu = 4096;
     9be:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9c5:	8b 45 08             	mov    0x8(%ebp),%eax
     9c8:	c1 e0 03             	shl    $0x3,%eax
     9cb:	83 ec 0c             	sub    $0xc,%esp
     9ce:	50                   	push   %eax
     9cf:	e8 51 fc ff ff       	call   625 <sbrk>
     9d4:	83 c4 10             	add    $0x10,%esp
     9d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9da:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9de:	75 07                	jne    9e7 <morecore+0x38>
    return 0;
     9e0:	b8 00 00 00 00       	mov    $0x0,%eax
     9e5:	eb 26                	jmp    a0d <morecore+0x5e>
  hp = (Header*)p;
     9e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f0:	8b 55 08             	mov    0x8(%ebp),%edx
     9f3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f9:	83 c0 08             	add    $0x8,%eax
     9fc:	83 ec 0c             	sub    $0xc,%esp
     9ff:	50                   	push   %eax
     a00:	e8 c8 fe ff ff       	call   8cd <free>
     a05:	83 c4 10             	add    $0x10,%esp
  return freep;
     a08:	a1 ec 2a 00 00       	mov    0x2aec,%eax
}
     a0d:	c9                   	leave  
     a0e:	c3                   	ret    

00000a0f <malloc>:

void*
malloc(uint nbytes)
{
     a0f:	55                   	push   %ebp
     a10:	89 e5                	mov    %esp,%ebp
     a12:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a15:	8b 45 08             	mov    0x8(%ebp),%eax
     a18:	83 c0 07             	add    $0x7,%eax
     a1b:	c1 e8 03             	shr    $0x3,%eax
     a1e:	83 c0 01             	add    $0x1,%eax
     a21:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a24:	a1 ec 2a 00 00       	mov    0x2aec,%eax
     a29:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a2c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a30:	75 23                	jne    a55 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a32:	c7 45 f0 e4 2a 00 00 	movl   $0x2ae4,-0x10(%ebp)
     a39:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3c:	a3 ec 2a 00 00       	mov    %eax,0x2aec
     a41:	a1 ec 2a 00 00       	mov    0x2aec,%eax
     a46:	a3 e4 2a 00 00       	mov    %eax,0x2ae4
    base.s.size = 0;
     a4b:	c7 05 e8 2a 00 00 00 	movl   $0x0,0x2ae8
     a52:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a58:	8b 00                	mov    (%eax),%eax
     a5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a60:	8b 40 04             	mov    0x4(%eax),%eax
     a63:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a66:	72 4d                	jb     ab5 <malloc+0xa6>
      if(p->s.size == nunits)
     a68:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a6b:	8b 40 04             	mov    0x4(%eax),%eax
     a6e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a71:	75 0c                	jne    a7f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a76:	8b 10                	mov    (%eax),%edx
     a78:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a7b:	89 10                	mov    %edx,(%eax)
     a7d:	eb 26                	jmp    aa5 <malloc+0x96>
      else {
        p->s.size -= nunits;
     a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a82:	8b 40 04             	mov    0x4(%eax),%eax
     a85:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a88:	89 c2                	mov    %eax,%edx
     a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a93:	8b 40 04             	mov    0x4(%eax),%eax
     a96:	c1 e0 03             	shl    $0x3,%eax
     a99:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     a9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9f:	8b 55 ec             	mov    -0x14(%ebp),%edx
     aa2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     aa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa8:	a3 ec 2a 00 00       	mov    %eax,0x2aec
      return (void*)(p + 1);
     aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab0:	83 c0 08             	add    $0x8,%eax
     ab3:	eb 3b                	jmp    af0 <malloc+0xe1>
    }
    if(p == freep)
     ab5:	a1 ec 2a 00 00       	mov    0x2aec,%eax
     aba:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     abd:	75 1e                	jne    add <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     abf:	83 ec 0c             	sub    $0xc,%esp
     ac2:	ff 75 ec             	pushl  -0x14(%ebp)
     ac5:	e8 e5 fe ff ff       	call   9af <morecore>
     aca:	83 c4 10             	add    $0x10,%esp
     acd:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ad0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ad4:	75 07                	jne    add <malloc+0xce>
        return 0;
     ad6:	b8 00 00 00 00       	mov    $0x0,%eax
     adb:	eb 13                	jmp    af0 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     add:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae6:	8b 00                	mov    (%eax),%eax
     ae8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     aeb:	e9 6d ff ff ff       	jmp    a5d <malloc+0x4e>
}
     af0:	c9                   	leave  
     af1:	c3                   	ret    

00000af2 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     af2:	55                   	push   %ebp
     af3:	89 e5                	mov    %esp,%ebp
     af5:	83 ec 1c             	sub    $0x1c,%esp
     af8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     afb:	8b 55 10             	mov    0x10(%ebp),%edx
     afe:	8b 45 14             	mov    0x14(%ebp),%eax
     b01:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b04:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b07:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b0a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b0e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b11:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b15:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b18:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b1c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b1f:	8b 45 08             	mov    0x8(%ebp),%eax
     b22:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b26:	66 89 10             	mov    %dx,(%eax)
     b29:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b2d:	88 50 02             	mov    %dl,0x2(%eax)
}
     b30:	8b 45 08             	mov    0x8(%ebp),%eax
     b33:	c9                   	leave  
     b34:	c2 04 00             	ret    $0x4

00000b37 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b37:	55                   	push   %ebp
     b38:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b3a:	8b 45 08             	mov    0x8(%ebp),%eax
     b3d:	2b 45 10             	sub    0x10(%ebp),%eax
     b40:	89 c2                	mov    %eax,%edx
     b42:	8b 45 08             	mov    0x8(%ebp),%eax
     b45:	2b 45 10             	sub    0x10(%ebp),%eax
     b48:	0f af d0             	imul   %eax,%edx
     b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b4e:	2b 45 14             	sub    0x14(%ebp),%eax
     b51:	89 c1                	mov    %eax,%ecx
     b53:	8b 45 0c             	mov    0xc(%ebp),%eax
     b56:	2b 45 14             	sub    0x14(%ebp),%eax
     b59:	0f af c1             	imul   %ecx,%eax
     b5c:	01 d0                	add    %edx,%eax
}
     b5e:	5d                   	pop    %ebp
     b5f:	c3                   	ret    

00000b60 <abs_int>:

static inline int abs_int(int x)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b63:	8b 45 08             	mov    0x8(%ebp),%eax
     b66:	99                   	cltd   
     b67:	89 d0                	mov    %edx,%eax
     b69:	33 45 08             	xor    0x8(%ebp),%eax
     b6c:	29 d0                	sub    %edx,%eax
}
     b6e:	5d                   	pop    %ebp
     b6f:	c3                   	ret    

00000b70 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b73:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b77:	79 07                	jns    b80 <APGetIndex+0x10>
        return X_SMALLER;
     b79:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b7e:	eb 40                	jmp    bc0 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     b80:	8b 45 08             	mov    0x8(%ebp),%eax
     b83:	8b 00                	mov    (%eax),%eax
     b85:	3b 45 0c             	cmp    0xc(%ebp),%eax
     b88:	7f 07                	jg     b91 <APGetIndex+0x21>
        return X_BIGGER;
     b8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b8f:	eb 2f                	jmp    bc0 <APGetIndex+0x50>
    if (y < 0)
     b91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     b95:	79 07                	jns    b9e <APGetIndex+0x2e>
        return Y_SMALLER;
     b97:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     b9c:	eb 22                	jmp    bc0 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     b9e:	8b 45 08             	mov    0x8(%ebp),%eax
     ba1:	8b 40 04             	mov    0x4(%eax),%eax
     ba4:	3b 45 10             	cmp    0x10(%ebp),%eax
     ba7:	7f 07                	jg     bb0 <APGetIndex+0x40>
        return Y_BIGGER;
     ba9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     bae:	eb 10                	jmp    bc0 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     bb0:	8b 45 08             	mov    0x8(%ebp),%eax
     bb3:	8b 00                	mov    (%eax),%eax
     bb5:	0f af 45 10          	imul   0x10(%ebp),%eax
     bb9:	89 c2                	mov    %eax,%edx
     bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
     bbe:	01 d0                	add    %edx,%eax
}
     bc0:	5d                   	pop    %ebp
     bc1:	c3                   	ret    

00000bc2 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     bc2:	55                   	push   %ebp
     bc3:	89 e5                	mov    %esp,%ebp
     bc5:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bc8:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bcf:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bd2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bd5:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bdc:	83 ec 08             	sub    $0x8,%esp
     bdf:	6a 00                	push   $0x0
     be1:	ff 75 0c             	pushl  0xc(%ebp)
     be4:	e8 f4 f9 ff ff       	call   5dd <open>
     be9:	83 c4 10             	add    $0x10,%esp
     bec:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bf3:	79 2e                	jns    c23 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     bf5:	83 ec 04             	sub    $0x4,%esp
     bf8:	ff 75 0c             	pushl  0xc(%ebp)
     bfb:	68 d1 23 00 00       	push   $0x23d1
     c00:	6a 01                	push   $0x1
     c02:	e8 35 fb ff ff       	call   73c <printf>
     c07:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c0a:	8b 45 08             	mov    0x8(%ebp),%eax
     c0d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c10:	89 10                	mov    %edx,(%eax)
     c12:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c15:	89 50 04             	mov    %edx,0x4(%eax)
     c18:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c1b:	89 50 08             	mov    %edx,0x8(%eax)
     c1e:	e9 d2 01 00 00       	jmp    df5 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c23:	83 ec 04             	sub    $0x4,%esp
     c26:	6a 0e                	push   $0xe
     c28:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c2b:	50                   	push   %eax
     c2c:	ff 75 ec             	pushl  -0x14(%ebp)
     c2f:	e8 81 f9 ff ff       	call   5b5 <read>
     c34:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c37:	83 ec 04             	sub    $0x4,%esp
     c3a:	6a 28                	push   $0x28
     c3c:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c3f:	50                   	push   %eax
     c40:	ff 75 ec             	pushl  -0x14(%ebp)
     c43:	e8 6d f9 ff ff       	call   5b5 <read>
     c48:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c4b:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c4e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c51:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c54:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c57:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c5a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c5d:	0f af d0             	imul   %eax,%edx
     c60:	89 d0                	mov    %edx,%eax
     c62:	01 c0                	add    %eax,%eax
     c64:	01 d0                	add    %edx,%eax
     c66:	83 ec 0c             	sub    $0xc,%esp
     c69:	50                   	push   %eax
     c6a:	e8 a0 fd ff ff       	call   a0f <malloc>
     c6f:	83 c4 10             	add    $0x10,%esp
     c72:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c75:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c79:	0f b7 c0             	movzwl %ax,%eax
     c7c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c7f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c82:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c85:	0f af c2             	imul   %edx,%eax
     c88:	83 c0 1f             	add    $0x1f,%eax
     c8b:	c1 e8 05             	shr    $0x5,%eax
     c8e:	c1 e0 02             	shl    $0x2,%eax
     c91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     c94:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c97:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c9a:	0f af c2             	imul   %edx,%eax
     c9d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     ca0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ca3:	83 ec 0c             	sub    $0xc,%esp
     ca6:	50                   	push   %eax
     ca7:	e8 63 fd ff ff       	call   a0f <malloc>
     cac:	83 c4 10             	add    $0x10,%esp
     caf:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     cb2:	83 ec 04             	sub    $0x4,%esp
     cb5:	ff 75 e0             	pushl  -0x20(%ebp)
     cb8:	ff 75 dc             	pushl  -0x24(%ebp)
     cbb:	ff 75 ec             	pushl  -0x14(%ebp)
     cbe:	e8 f2 f8 ff ff       	call   5b5 <read>
     cc3:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     cc6:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     cca:	66 c1 e8 03          	shr    $0x3,%ax
     cce:	0f b7 c0             	movzwl %ax,%eax
     cd1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     cd4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cdb:	e9 e5 00 00 00       	jmp    dc5 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     ce0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce6:	29 c2                	sub    %eax,%edx
     ce8:	89 d0                	mov    %edx,%eax
     cea:	8d 50 ff             	lea    -0x1(%eax),%edx
     ced:	8b 45 c8             	mov    -0x38(%ebp),%eax
     cf0:	0f af c2             	imul   %edx,%eax
     cf3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     cf6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cfd:	e9 b1 00 00 00       	jmp    db3 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d02:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d05:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d08:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d0b:	01 c8                	add    %ecx,%eax
     d0d:	89 c1                	mov    %eax,%ecx
     d0f:	89 c8                	mov    %ecx,%eax
     d11:	01 c0                	add    %eax,%eax
     d13:	01 c8                	add    %ecx,%eax
     d15:	01 c2                	add    %eax,%edx
     d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d1e:	89 c1                	mov    %eax,%ecx
     d20:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d23:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d27:	01 c1                	add    %eax,%ecx
     d29:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d2c:	01 c8                	add    %ecx,%eax
     d2e:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d31:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d34:	01 c8                	add    %ecx,%eax
     d36:	0f b6 00             	movzbl (%eax),%eax
     d39:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d3c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d3f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d42:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d45:	01 c8                	add    %ecx,%eax
     d47:	89 c1                	mov    %eax,%ecx
     d49:	89 c8                	mov    %ecx,%eax
     d4b:	01 c0                	add    %eax,%eax
     d4d:	01 c8                	add    %ecx,%eax
     d4f:	01 c2                	add    %eax,%edx
     d51:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d54:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d58:	89 c1                	mov    %eax,%ecx
     d5a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d5d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d61:	01 c1                	add    %eax,%ecx
     d63:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d66:	01 c8                	add    %ecx,%eax
     d68:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d6b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d6e:	01 c8                	add    %ecx,%eax
     d70:	0f b6 00             	movzbl (%eax),%eax
     d73:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d76:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d79:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d7f:	01 c8                	add    %ecx,%eax
     d81:	89 c1                	mov    %eax,%ecx
     d83:	89 c8                	mov    %ecx,%eax
     d85:	01 c0                	add    %eax,%eax
     d87:	01 c8                	add    %ecx,%eax
     d89:	01 c2                	add    %eax,%edx
     d8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d8e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d92:	89 c1                	mov    %eax,%ecx
     d94:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d97:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d9b:	01 c1                	add    %eax,%ecx
     d9d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da0:	01 c8                	add    %ecx,%eax
     da2:	8d 48 fd             	lea    -0x3(%eax),%ecx
     da5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     da8:	01 c8                	add    %ecx,%eax
     daa:	0f b6 00             	movzbl (%eax),%eax
     dad:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     daf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     db3:	8b 55 c8             	mov    -0x38(%ebp),%edx
     db6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     db9:	39 c2                	cmp    %eax,%edx
     dbb:	0f 87 41 ff ff ff    	ja     d02 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     dc1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dc5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dcb:	39 c2                	cmp    %eax,%edx
     dcd:	0f 87 0d ff ff ff    	ja     ce0 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     dd3:	83 ec 0c             	sub    $0xc,%esp
     dd6:	ff 75 ec             	pushl  -0x14(%ebp)
     dd9:	e8 e7 f7 ff ff       	call   5c5 <close>
     dde:	83 c4 10             	add    $0x10,%esp
    return bmp;
     de1:	8b 45 08             	mov    0x8(%ebp),%eax
     de4:	8b 55 c8             	mov    -0x38(%ebp),%edx
     de7:	89 10                	mov    %edx,(%eax)
     de9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dec:	89 50 04             	mov    %edx,0x4(%eax)
     def:	8b 55 d0             	mov    -0x30(%ebp),%edx
     df2:	89 50 08             	mov    %edx,0x8(%eax)
}
     df5:	8b 45 08             	mov    0x8(%ebp),%eax
     df8:	c9                   	leave  
     df9:	c2 04 00             	ret    $0x4

00000dfc <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     dfc:	55                   	push   %ebp
     dfd:	89 e5                	mov    %esp,%ebp
     dff:	53                   	push   %ebx
     e00:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e03:	83 ec 0c             	sub    $0xc,%esp
     e06:	6a 1c                	push   $0x1c
     e08:	e8 02 fc ff ff       	call   a0f <malloc>
     e0d:	83 c4 10             	add    $0x10,%esp
     e10:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e16:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e1d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e20:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e23:	6a 0c                	push   $0xc
     e25:	6a 0c                	push   $0xc
     e27:	6a 0c                	push   $0xc
     e29:	50                   	push   %eax
     e2a:	e8 c3 fc ff ff       	call   af2 <RGB>
     e2f:	83 c4 0c             	add    $0xc,%esp
     e32:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e36:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e3a:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e3e:	88 43 15             	mov    %al,0x15(%ebx)
     e41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e44:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e47:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e4b:	66 89 48 10          	mov    %cx,0x10(%eax)
     e4f:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e53:	88 50 12             	mov    %dl,0x12(%eax)
     e56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e59:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e5c:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e60:	66 89 48 08          	mov    %cx,0x8(%eax)
     e64:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e68:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e6b:	8b 45 08             	mov    0x8(%ebp),%eax
     e6e:	89 c2                	mov    %eax,%edx
     e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e73:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e75:	8b 45 0c             	mov    0xc(%ebp),%eax
     e78:	89 c2                	mov    %eax,%edx
     e7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e7d:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     e80:	8b 55 10             	mov    0x10(%ebp),%edx
     e83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e86:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e8c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e8f:	c9                   	leave  
     e90:	c3                   	ret    

00000e91 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     e91:	55                   	push   %ebp
     e92:	89 e5                	mov    %esp,%ebp
     e94:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     e97:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9a:	8b 50 08             	mov    0x8(%eax),%edx
     e9d:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ea0:	8b 40 0c             	mov    0xc(%eax),%eax
     ea3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ea9:	8b 55 10             	mov    0x10(%ebp),%edx
     eac:	89 50 08             	mov    %edx,0x8(%eax)
     eaf:	8b 55 14             	mov    0x14(%ebp),%edx
     eb2:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     eb5:	8b 45 08             	mov    0x8(%ebp),%eax
     eb8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ebb:	89 10                	mov    %edx,(%eax)
     ebd:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ec0:	89 50 04             	mov    %edx,0x4(%eax)
}
     ec3:	8b 45 08             	mov    0x8(%ebp),%eax
     ec6:	c9                   	leave  
     ec7:	c2 04 00             	ret    $0x4

00000eca <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     eca:	55                   	push   %ebp
     ecb:	89 e5                	mov    %esp,%ebp
     ecd:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ed0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed3:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ed7:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     edb:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     edf:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee5:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     ee9:	66 89 50 10          	mov    %dx,0x10(%eax)
     eed:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     ef1:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     ef4:	8b 45 08             	mov    0x8(%ebp),%eax
     ef7:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     efb:	66 89 10             	mov    %dx,(%eax)
     efe:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f02:	88 50 02             	mov    %dl,0x2(%eax)
}
     f05:	8b 45 08             	mov    0x8(%ebp),%eax
     f08:	c9                   	leave  
     f09:	c2 04 00             	ret    $0x4

00000f0c <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f0c:	55                   	push   %ebp
     f0d:	89 e5                	mov    %esp,%ebp
     f0f:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f12:	8b 45 08             	mov    0x8(%ebp),%eax
     f15:	8b 40 0c             	mov    0xc(%eax),%eax
     f18:	89 c2                	mov    %eax,%edx
     f1a:	c1 ea 1f             	shr    $0x1f,%edx
     f1d:	01 d0                	add    %edx,%eax
     f1f:	d1 f8                	sar    %eax
     f21:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f24:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f27:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f2e:	8b 45 10             	mov    0x10(%ebp),%eax
     f31:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f34:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f37:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f3b:	0f 89 98 00 00 00    	jns    fd9 <APDrawPoint+0xcd>
        i = 0;
     f41:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f48:	e9 8c 00 00 00       	jmp    fd9 <APDrawPoint+0xcd>
    {
        j = x - off;
     f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f50:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f53:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f56:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f5a:	79 69                	jns    fc5 <APDrawPoint+0xb9>
            j = 0;
     f5c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f63:	eb 60                	jmp    fc5 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f65:	ff 75 fc             	pushl  -0x4(%ebp)
     f68:	ff 75 f8             	pushl  -0x8(%ebp)
     f6b:	ff 75 08             	pushl  0x8(%ebp)
     f6e:	e8 fd fb ff ff       	call   b70 <APGetIndex>
     f73:	83 c4 0c             	add    $0xc,%esp
     f76:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     f79:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     f7d:	74 55                	je     fd4 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     f7f:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     f83:	74 67                	je     fec <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     f85:	ff 75 10             	pushl  0x10(%ebp)
     f88:	ff 75 0c             	pushl  0xc(%ebp)
     f8b:	ff 75 fc             	pushl  -0x4(%ebp)
     f8e:	ff 75 f8             	pushl  -0x8(%ebp)
     f91:	e8 a1 fb ff ff       	call   b37 <distance_2>
     f96:	83 c4 10             	add    $0x10,%esp
     f99:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     f9c:	7f 23                	jg     fc1 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     f9e:	8b 45 08             	mov    0x8(%ebp),%eax
     fa1:	8b 48 18             	mov    0x18(%eax),%ecx
     fa4:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fa7:	89 d0                	mov    %edx,%eax
     fa9:	01 c0                	add    %eax,%eax
     fab:	01 d0                	add    %edx,%eax
     fad:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     fb0:	8b 45 08             	mov    0x8(%ebp),%eax
     fb3:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     fb7:	66 89 0a             	mov    %cx,(%edx)
     fba:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     fbe:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     fc1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     fc5:	8b 55 0c             	mov    0xc(%ebp),%edx
     fc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fcb:	01 d0                	add    %edx,%eax
     fcd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     fd0:	7d 93                	jge    f65 <APDrawPoint+0x59>
     fd2:	eb 01                	jmp    fd5 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     fd4:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     fd5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     fd9:	8b 55 10             	mov    0x10(%ebp),%edx
     fdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fdf:	01 d0                	add    %edx,%eax
     fe1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     fe4:	0f 8d 63 ff ff ff    	jge    f4d <APDrawPoint+0x41>
     fea:	eb 01                	jmp    fed <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     fec:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     fed:	c9                   	leave  
     fee:	c3                   	ret    

00000fef <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     fef:	55                   	push   %ebp
     ff0:	89 e5                	mov    %esp,%ebp
     ff2:	53                   	push   %ebx
     ff3:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
     ff6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ff9:	3b 45 14             	cmp    0x14(%ebp),%eax
     ffc:	0f 85 80 00 00 00    	jne    1082 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1002:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1006:	0f 88 9d 02 00 00    	js     12a9 <APDrawLine+0x2ba>
    100c:	8b 45 08             	mov    0x8(%ebp),%eax
    100f:	8b 00                	mov    (%eax),%eax
    1011:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1014:	0f 8e 8f 02 00 00    	jle    12a9 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    101a:	8b 45 10             	mov    0x10(%ebp),%eax
    101d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1020:	7e 12                	jle    1034 <APDrawLine+0x45>
        {
            int tmp = y2;
    1022:	8b 45 18             	mov    0x18(%ebp),%eax
    1025:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1028:	8b 45 10             	mov    0x10(%ebp),%eax
    102b:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    102e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1031:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1034:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1038:	79 07                	jns    1041 <APDrawLine+0x52>
    103a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1041:	8b 45 08             	mov    0x8(%ebp),%eax
    1044:	8b 40 04             	mov    0x4(%eax),%eax
    1047:	3b 45 18             	cmp    0x18(%ebp),%eax
    104a:	7d 0c                	jge    1058 <APDrawLine+0x69>
    104c:	8b 45 08             	mov    0x8(%ebp),%eax
    104f:	8b 40 04             	mov    0x4(%eax),%eax
    1052:	83 e8 01             	sub    $0x1,%eax
    1055:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1058:	8b 45 10             	mov    0x10(%ebp),%eax
    105b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    105e:	eb 15                	jmp    1075 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1060:	ff 75 f4             	pushl  -0xc(%ebp)
    1063:	ff 75 0c             	pushl  0xc(%ebp)
    1066:	ff 75 08             	pushl  0x8(%ebp)
    1069:	e8 9e fe ff ff       	call   f0c <APDrawPoint>
    106e:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1071:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1075:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1078:	3b 45 18             	cmp    0x18(%ebp),%eax
    107b:	7e e3                	jle    1060 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    107d:	e9 2b 02 00 00       	jmp    12ad <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1082:	8b 45 10             	mov    0x10(%ebp),%eax
    1085:	3b 45 18             	cmp    0x18(%ebp),%eax
    1088:	75 7f                	jne    1109 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    108a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    108e:	0f 88 18 02 00 00    	js     12ac <APDrawLine+0x2bd>
    1094:	8b 45 08             	mov    0x8(%ebp),%eax
    1097:	8b 40 04             	mov    0x4(%eax),%eax
    109a:	3b 45 10             	cmp    0x10(%ebp),%eax
    109d:	0f 8e 09 02 00 00    	jle    12ac <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a6:	3b 45 14             	cmp    0x14(%ebp),%eax
    10a9:	7e 12                	jle    10bd <APDrawLine+0xce>
        {
            int tmp = x2;
    10ab:	8b 45 14             	mov    0x14(%ebp),%eax
    10ae:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    10b1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b4:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10ba:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10c1:	79 07                	jns    10ca <APDrawLine+0xdb>
    10c3:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	8b 00                	mov    (%eax),%eax
    10cf:	3b 45 14             	cmp    0x14(%ebp),%eax
    10d2:	7d 0b                	jge    10df <APDrawLine+0xf0>
    10d4:	8b 45 08             	mov    0x8(%ebp),%eax
    10d7:	8b 00                	mov    (%eax),%eax
    10d9:	83 e8 01             	sub    $0x1,%eax
    10dc:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    10df:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10e5:	eb 15                	jmp    10fc <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    10e7:	ff 75 10             	pushl  0x10(%ebp)
    10ea:	ff 75 f0             	pushl  -0x10(%ebp)
    10ed:	ff 75 08             	pushl  0x8(%ebp)
    10f0:	e8 17 fe ff ff       	call   f0c <APDrawPoint>
    10f5:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    10f8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    10fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10ff:	3b 45 14             	cmp    0x14(%ebp),%eax
    1102:	7e e3                	jle    10e7 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1104:	e9 a4 01 00 00       	jmp    12ad <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1109:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1110:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1117:	8b 45 0c             	mov    0xc(%ebp),%eax
    111a:	2b 45 14             	sub    0x14(%ebp),%eax
    111d:	50                   	push   %eax
    111e:	e8 3d fa ff ff       	call   b60 <abs_int>
    1123:	83 c4 04             	add    $0x4,%esp
    1126:	89 c3                	mov    %eax,%ebx
    1128:	8b 45 10             	mov    0x10(%ebp),%eax
    112b:	2b 45 18             	sub    0x18(%ebp),%eax
    112e:	50                   	push   %eax
    112f:	e8 2c fa ff ff       	call   b60 <abs_int>
    1134:	83 c4 04             	add    $0x4,%esp
    1137:	39 c3                	cmp    %eax,%ebx
    1139:	0f 8e b5 00 00 00    	jle    11f4 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    113f:	8b 45 10             	mov    0x10(%ebp),%eax
    1142:	2b 45 18             	sub    0x18(%ebp),%eax
    1145:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1148:	db 45 b0             	fildl  -0x50(%ebp)
    114b:	8b 45 0c             	mov    0xc(%ebp),%eax
    114e:	2b 45 14             	sub    0x14(%ebp),%eax
    1151:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1154:	db 45 b0             	fildl  -0x50(%ebp)
    1157:	de f9                	fdivrp %st,%st(1)
    1159:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    115c:	8b 45 14             	mov    0x14(%ebp),%eax
    115f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1162:	7e 0e                	jle    1172 <APDrawLine+0x183>
        {
            s = x1;
    1164:	8b 45 0c             	mov    0xc(%ebp),%eax
    1167:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    116a:	8b 45 14             	mov    0x14(%ebp),%eax
    116d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1170:	eb 0c                	jmp    117e <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1172:	8b 45 14             	mov    0x14(%ebp),%eax
    1175:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1178:	8b 45 0c             	mov    0xc(%ebp),%eax
    117b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    117e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1182:	79 07                	jns    118b <APDrawLine+0x19c>
    1184:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    118b:	8b 45 08             	mov    0x8(%ebp),%eax
    118e:	8b 00                	mov    (%eax),%eax
    1190:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1193:	7f 0b                	jg     11a0 <APDrawLine+0x1b1>
    1195:	8b 45 08             	mov    0x8(%ebp),%eax
    1198:	8b 00                	mov    (%eax),%eax
    119a:	83 e8 01             	sub    $0x1,%eax
    119d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11a6:	eb 3f                	jmp    11e7 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11ab:	2b 45 0c             	sub    0xc(%ebp),%eax
    11ae:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11b1:	db 45 b0             	fildl  -0x50(%ebp)
    11b4:	dc 4d d0             	fmull  -0x30(%ebp)
    11b7:	db 45 10             	fildl  0x10(%ebp)
    11ba:	de c1                	faddp  %st,%st(1)
    11bc:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11bf:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11c3:	b4 0c                	mov    $0xc,%ah
    11c5:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11c9:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11cc:	db 5d cc             	fistpl -0x34(%ebp)
    11cf:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    11d2:	ff 75 cc             	pushl  -0x34(%ebp)
    11d5:	ff 75 e4             	pushl  -0x1c(%ebp)
    11d8:	ff 75 08             	pushl  0x8(%ebp)
    11db:	e8 2c fd ff ff       	call   f0c <APDrawPoint>
    11e0:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    11e3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    11e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11ea:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11ed:	7e b9                	jle    11a8 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    11ef:	e9 b9 00 00 00       	jmp    12ad <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    11f4:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f7:	2b 45 14             	sub    0x14(%ebp),%eax
    11fa:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11fd:	db 45 b0             	fildl  -0x50(%ebp)
    1200:	8b 45 10             	mov    0x10(%ebp),%eax
    1203:	2b 45 18             	sub    0x18(%ebp),%eax
    1206:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1209:	db 45 b0             	fildl  -0x50(%ebp)
    120c:	de f9                	fdivrp %st,%st(1)
    120e:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1211:	8b 45 10             	mov    0x10(%ebp),%eax
    1214:	3b 45 18             	cmp    0x18(%ebp),%eax
    1217:	7e 0e                	jle    1227 <APDrawLine+0x238>
    {
        s = y2;
    1219:	8b 45 18             	mov    0x18(%ebp),%eax
    121c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    121f:	8b 45 10             	mov    0x10(%ebp),%eax
    1222:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1225:	eb 0c                	jmp    1233 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1227:	8b 45 10             	mov    0x10(%ebp),%eax
    122a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    122d:	8b 45 18             	mov    0x18(%ebp),%eax
    1230:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1233:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1237:	79 07                	jns    1240 <APDrawLine+0x251>
    1239:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1240:	8b 45 08             	mov    0x8(%ebp),%eax
    1243:	8b 40 04             	mov    0x4(%eax),%eax
    1246:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1249:	7f 0c                	jg     1257 <APDrawLine+0x268>
    124b:	8b 45 08             	mov    0x8(%ebp),%eax
    124e:	8b 40 04             	mov    0x4(%eax),%eax
    1251:	83 e8 01             	sub    $0x1,%eax
    1254:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1257:	8b 45 ec             	mov    -0x14(%ebp),%eax
    125a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    125d:	eb 3f                	jmp    129e <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    125f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1262:	2b 45 10             	sub    0x10(%ebp),%eax
    1265:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1268:	db 45 b0             	fildl  -0x50(%ebp)
    126b:	dc 4d c0             	fmull  -0x40(%ebp)
    126e:	db 45 0c             	fildl  0xc(%ebp)
    1271:	de c1                	faddp  %st,%st(1)
    1273:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1276:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    127a:	b4 0c                	mov    $0xc,%ah
    127c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1280:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1283:	db 5d bc             	fistpl -0x44(%ebp)
    1286:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1289:	ff 75 e0             	pushl  -0x20(%ebp)
    128c:	ff 75 bc             	pushl  -0x44(%ebp)
    128f:	ff 75 08             	pushl  0x8(%ebp)
    1292:	e8 75 fc ff ff       	call   f0c <APDrawPoint>
    1297:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    129a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    129e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12a1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12a4:	7e b9                	jle    125f <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12a6:	90                   	nop
    12a7:	eb 04                	jmp    12ad <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12a9:	90                   	nop
    12aa:	eb 01                	jmp    12ad <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12ac:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12b0:	c9                   	leave  
    12b1:	c3                   	ret    

000012b2 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    12b2:	55                   	push   %ebp
    12b3:	89 e5                	mov    %esp,%ebp
    12b5:	53                   	push   %ebx
    12b6:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    12b9:	8b 55 10             	mov    0x10(%ebp),%edx
    12bc:	8b 45 18             	mov    0x18(%ebp),%eax
    12bf:	01 d0                	add    %edx,%eax
    12c1:	83 e8 01             	sub    $0x1,%eax
    12c4:	83 ec 04             	sub    $0x4,%esp
    12c7:	50                   	push   %eax
    12c8:	ff 75 0c             	pushl  0xc(%ebp)
    12cb:	ff 75 10             	pushl  0x10(%ebp)
    12ce:	ff 75 0c             	pushl  0xc(%ebp)
    12d1:	ff 75 08             	pushl  0x8(%ebp)
    12d4:	e8 16 fd ff ff       	call   fef <APDrawLine>
    12d9:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    12dc:	8b 55 0c             	mov    0xc(%ebp),%edx
    12df:	8b 45 14             	mov    0x14(%ebp),%eax
    12e2:	01 d0                	add    %edx,%eax
    12e4:	83 e8 01             	sub    $0x1,%eax
    12e7:	83 ec 04             	sub    $0x4,%esp
    12ea:	ff 75 10             	pushl  0x10(%ebp)
    12ed:	50                   	push   %eax
    12ee:	ff 75 10             	pushl  0x10(%ebp)
    12f1:	ff 75 0c             	pushl  0xc(%ebp)
    12f4:	ff 75 08             	pushl  0x8(%ebp)
    12f7:	e8 f3 fc ff ff       	call   fef <APDrawLine>
    12fc:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    12ff:	8b 55 10             	mov    0x10(%ebp),%edx
    1302:	8b 45 18             	mov    0x18(%ebp),%eax
    1305:	01 d0                	add    %edx,%eax
    1307:	8d 48 ff             	lea    -0x1(%eax),%ecx
    130a:	8b 55 0c             	mov    0xc(%ebp),%edx
    130d:	8b 45 14             	mov    0x14(%ebp),%eax
    1310:	01 d0                	add    %edx,%eax
    1312:	8d 50 ff             	lea    -0x1(%eax),%edx
    1315:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1318:	8b 45 14             	mov    0x14(%ebp),%eax
    131b:	01 d8                	add    %ebx,%eax
    131d:	83 e8 01             	sub    $0x1,%eax
    1320:	83 ec 04             	sub    $0x4,%esp
    1323:	51                   	push   %ecx
    1324:	52                   	push   %edx
    1325:	ff 75 10             	pushl  0x10(%ebp)
    1328:	50                   	push   %eax
    1329:	ff 75 08             	pushl  0x8(%ebp)
    132c:	e8 be fc ff ff       	call   fef <APDrawLine>
    1331:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1334:	8b 55 10             	mov    0x10(%ebp),%edx
    1337:	8b 45 18             	mov    0x18(%ebp),%eax
    133a:	01 d0                	add    %edx,%eax
    133c:	8d 48 ff             	lea    -0x1(%eax),%ecx
    133f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1342:	8b 45 14             	mov    0x14(%ebp),%eax
    1345:	01 d0                	add    %edx,%eax
    1347:	8d 50 ff             	lea    -0x1(%eax),%edx
    134a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    134d:	8b 45 18             	mov    0x18(%ebp),%eax
    1350:	01 d8                	add    %ebx,%eax
    1352:	83 e8 01             	sub    $0x1,%eax
    1355:	83 ec 04             	sub    $0x4,%esp
    1358:	51                   	push   %ecx
    1359:	52                   	push   %edx
    135a:	50                   	push   %eax
    135b:	ff 75 0c             	pushl  0xc(%ebp)
    135e:	ff 75 08             	pushl  0x8(%ebp)
    1361:	e8 89 fc ff ff       	call   fef <APDrawLine>
    1366:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1369:	8b 55 0c             	mov    0xc(%ebp),%edx
    136c:	8b 45 14             	mov    0x14(%ebp),%eax
    136f:	01 d0                	add    %edx,%eax
    1371:	8d 50 ff             	lea    -0x1(%eax),%edx
    1374:	8b 45 08             	mov    0x8(%ebp),%eax
    1377:	8b 40 0c             	mov    0xc(%eax),%eax
    137a:	89 c1                	mov    %eax,%ecx
    137c:	c1 e9 1f             	shr    $0x1f,%ecx
    137f:	01 c8                	add    %ecx,%eax
    1381:	d1 f8                	sar    %eax
    1383:	29 c2                	sub    %eax,%edx
    1385:	89 d0                	mov    %edx,%eax
    1387:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    138a:	8b 55 10             	mov    0x10(%ebp),%edx
    138d:	8b 45 18             	mov    0x18(%ebp),%eax
    1390:	01 d0                	add    %edx,%eax
    1392:	8d 50 ff             	lea    -0x1(%eax),%edx
    1395:	8b 45 08             	mov    0x8(%ebp),%eax
    1398:	8b 40 0c             	mov    0xc(%eax),%eax
    139b:	89 c1                	mov    %eax,%ecx
    139d:	c1 e9 1f             	shr    $0x1f,%ecx
    13a0:	01 c8                	add    %ecx,%eax
    13a2:	d1 f8                	sar    %eax
    13a4:	29 c2                	sub    %eax,%edx
    13a6:	89 d0                	mov    %edx,%eax
    13a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13ab:	8b 45 08             	mov    0x8(%ebp),%eax
    13ae:	8b 40 0c             	mov    0xc(%eax),%eax
    13b1:	89 c2                	mov    %eax,%edx
    13b3:	c1 ea 1f             	shr    $0x1f,%edx
    13b6:	01 d0                	add    %edx,%eax
    13b8:	d1 f8                	sar    %eax
    13ba:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13bd:	8b 45 08             	mov    0x8(%ebp),%eax
    13c0:	8b 40 0c             	mov    0xc(%eax),%eax
    13c3:	89 c2                	mov    %eax,%edx
    13c5:	c1 ea 1f             	shr    $0x1f,%edx
    13c8:	01 d0                	add    %edx,%eax
    13ca:	d1 f8                	sar    %eax
    13cc:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    13cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13d3:	0f 88 d8 00 00 00    	js     14b1 <APDrawRect+0x1ff>
    13d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13dd:	0f 88 ce 00 00 00    	js     14b1 <APDrawRect+0x1ff>
    13e3:	8b 45 08             	mov    0x8(%ebp),%eax
    13e6:	8b 00                	mov    (%eax),%eax
    13e8:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13eb:	0f 8e c0 00 00 00    	jle    14b1 <APDrawRect+0x1ff>
    13f1:	8b 45 08             	mov    0x8(%ebp),%eax
    13f4:	8b 40 04             	mov    0x4(%eax),%eax
    13f7:	3b 45 10             	cmp    0x10(%ebp),%eax
    13fa:	0f 8e b1 00 00 00    	jle    14b1 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1400:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1404:	79 07                	jns    140d <APDrawRect+0x15b>
    1406:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    140d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1411:	79 07                	jns    141a <APDrawRect+0x168>
    1413:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    141a:	8b 45 08             	mov    0x8(%ebp),%eax
    141d:	8b 00                	mov    (%eax),%eax
    141f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1422:	7f 0b                	jg     142f <APDrawRect+0x17d>
    1424:	8b 45 08             	mov    0x8(%ebp),%eax
    1427:	8b 00                	mov    (%eax),%eax
    1429:	83 e8 01             	sub    $0x1,%eax
    142c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    142f:	8b 45 08             	mov    0x8(%ebp),%eax
    1432:	8b 40 04             	mov    0x4(%eax),%eax
    1435:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1438:	7f 0c                	jg     1446 <APDrawRect+0x194>
    143a:	8b 45 08             	mov    0x8(%ebp),%eax
    143d:	8b 40 04             	mov    0x4(%eax),%eax
    1440:	83 e8 01             	sub    $0x1,%eax
    1443:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1446:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    144d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1450:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1453:	eb 52                	jmp    14a7 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1455:	8b 45 10             	mov    0x10(%ebp),%eax
    1458:	89 45 e8             	mov    %eax,-0x18(%ebp)
    145b:	eb 3e                	jmp    149b <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    145d:	83 ec 04             	sub    $0x4,%esp
    1460:	ff 75 e8             	pushl  -0x18(%ebp)
    1463:	ff 75 ec             	pushl  -0x14(%ebp)
    1466:	ff 75 08             	pushl  0x8(%ebp)
    1469:	e8 02 f7 ff ff       	call   b70 <APGetIndex>
    146e:	83 c4 10             	add    $0x10,%esp
    1471:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1474:	8b 45 08             	mov    0x8(%ebp),%eax
    1477:	8b 48 18             	mov    0x18(%eax),%ecx
    147a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    147d:	89 d0                	mov    %edx,%eax
    147f:	01 c0                	add    %eax,%eax
    1481:	01 d0                	add    %edx,%eax
    1483:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1486:	8b 45 08             	mov    0x8(%ebp),%eax
    1489:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    148d:	66 89 0a             	mov    %cx,(%edx)
    1490:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    1494:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    1497:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    149b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    149e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14a1:	7e ba                	jle    145d <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14a3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14aa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14ad:	7e a6                	jle    1455 <APDrawRect+0x1a3>
    14af:	eb 01                	jmp    14b2 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    14b1:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    14b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14b5:	c9                   	leave  
    14b6:	c3                   	ret    

000014b7 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14b7:	55                   	push   %ebp
    14b8:	89 e5                	mov    %esp,%ebp
    14ba:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14bd:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14c1:	0f 88 8e 01 00 00    	js     1655 <APDcCopy+0x19e>
    14c7:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14cb:	0f 88 84 01 00 00    	js     1655 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14d1:	8b 55 0c             	mov    0xc(%ebp),%edx
    14d4:	8b 45 20             	mov    0x20(%ebp),%eax
    14d7:	01 d0                	add    %edx,%eax
    14d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14dc:	8b 55 10             	mov    0x10(%ebp),%edx
    14df:	8b 45 24             	mov    0x24(%ebp),%eax
    14e2:	01 d0                	add    %edx,%eax
    14e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14e7:	8b 55 18             	mov    0x18(%ebp),%edx
    14ea:	8b 45 20             	mov    0x20(%ebp),%eax
    14ed:	01 d0                	add    %edx,%eax
    14ef:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14f2:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14f5:	8b 45 24             	mov    0x24(%ebp),%eax
    14f8:	01 d0                	add    %edx,%eax
    14fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    14fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1501:	0f 88 51 01 00 00    	js     1658 <APDcCopy+0x1a1>
    1507:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    150b:	0f 88 47 01 00 00    	js     1658 <APDcCopy+0x1a1>
    1511:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1515:	0f 88 3d 01 00 00    	js     1658 <APDcCopy+0x1a1>
    151b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    151f:	0f 88 33 01 00 00    	js     1658 <APDcCopy+0x1a1>
    1525:	8b 45 14             	mov    0x14(%ebp),%eax
    1528:	8b 00                	mov    (%eax),%eax
    152a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    152d:	0f 8c 25 01 00 00    	jl     1658 <APDcCopy+0x1a1>
    1533:	8b 45 14             	mov    0x14(%ebp),%eax
    1536:	8b 40 04             	mov    0x4(%eax),%eax
    1539:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    153c:	0f 8c 16 01 00 00    	jl     1658 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1542:	8b 45 08             	mov    0x8(%ebp),%eax
    1545:	8b 00                	mov    (%eax),%eax
    1547:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    154a:	7f 0b                	jg     1557 <APDcCopy+0xa0>
    154c:	8b 45 08             	mov    0x8(%ebp),%eax
    154f:	8b 00                	mov    (%eax),%eax
    1551:	83 e8 01             	sub    $0x1,%eax
    1554:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    1557:	8b 45 08             	mov    0x8(%ebp),%eax
    155a:	8b 40 04             	mov    0x4(%eax),%eax
    155d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1560:	7f 0c                	jg     156e <APDcCopy+0xb7>
    1562:	8b 45 08             	mov    0x8(%ebp),%eax
    1565:	8b 40 04             	mov    0x4(%eax),%eax
    1568:	83 e8 01             	sub    $0x1,%eax
    156b:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    156e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1575:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    157c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1583:	e9 bc 00 00 00       	jmp    1644 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    1588:	8b 45 08             	mov    0x8(%ebp),%eax
    158b:	8b 00                	mov    (%eax),%eax
    158d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1590:	8b 55 10             	mov    0x10(%ebp),%edx
    1593:	01 ca                	add    %ecx,%edx
    1595:	0f af d0             	imul   %eax,%edx
    1598:	8b 45 0c             	mov    0xc(%ebp),%eax
    159b:	01 d0                	add    %edx,%eax
    159d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    15a0:	8b 45 14             	mov    0x14(%ebp),%eax
    15a3:	8b 00                	mov    (%eax),%eax
    15a5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15a8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    15ab:	01 ca                	add    %ecx,%edx
    15ad:	0f af d0             	imul   %eax,%edx
    15b0:	8b 45 18             	mov    0x18(%ebp),%eax
    15b3:	01 d0                	add    %edx,%eax
    15b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    15b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15bf:	eb 74                	jmp    1635 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15c1:	8b 45 14             	mov    0x14(%ebp),%eax
    15c4:	8b 50 18             	mov    0x18(%eax),%edx
    15c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15cd:	01 c8                	add    %ecx,%eax
    15cf:	89 c1                	mov    %eax,%ecx
    15d1:	89 c8                	mov    %ecx,%eax
    15d3:	01 c0                	add    %eax,%eax
    15d5:	01 c8                	add    %ecx,%eax
    15d7:	01 d0                	add    %edx,%eax
    15d9:	0f b7 10             	movzwl (%eax),%edx
    15dc:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15e0:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15e4:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15e7:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15eb:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15ef:	38 c2                	cmp    %al,%dl
    15f1:	75 18                	jne    160b <APDcCopy+0x154>
    15f3:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15f7:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    15fb:	38 c2                	cmp    %al,%dl
    15fd:	75 0c                	jne    160b <APDcCopy+0x154>
    15ff:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1603:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1607:	38 c2                	cmp    %al,%dl
    1609:	74 26                	je     1631 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    160b:	8b 45 08             	mov    0x8(%ebp),%eax
    160e:	8b 50 18             	mov    0x18(%eax),%edx
    1611:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1614:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1617:	01 c8                	add    %ecx,%eax
    1619:	89 c1                	mov    %eax,%ecx
    161b:	89 c8                	mov    %ecx,%eax
    161d:	01 c0                	add    %eax,%eax
    161f:	01 c8                	add    %ecx,%eax
    1621:	01 d0                	add    %edx,%eax
    1623:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1627:	66 89 10             	mov    %dx,(%eax)
    162a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    162e:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1631:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1635:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1638:	2b 45 0c             	sub    0xc(%ebp),%eax
    163b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    163e:	7d 81                	jge    15c1 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1640:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1644:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1647:	2b 45 10             	sub    0x10(%ebp),%eax
    164a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    164d:	0f 8d 35 ff ff ff    	jge    1588 <APDcCopy+0xd1>
    1653:	eb 04                	jmp    1659 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    1655:	90                   	nop
    1656:	eb 01                	jmp    1659 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    1658:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    1659:	c9                   	leave  
    165a:	c3                   	ret    

0000165b <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    165b:	55                   	push   %ebp
    165c:	89 e5                	mov    %esp,%ebp
    165e:	83 ec 1c             	sub    $0x1c,%esp
    1661:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1664:	8b 55 10             	mov    0x10(%ebp),%edx
    1667:	8b 45 14             	mov    0x14(%ebp),%eax
    166a:	88 4d ec             	mov    %cl,-0x14(%ebp)
    166d:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1670:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1673:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    1677:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    167a:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    167e:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1681:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    1685:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    1688:	8b 45 08             	mov    0x8(%ebp),%eax
    168b:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    168f:	66 89 10             	mov    %dx,(%eax)
    1692:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    1696:	88 50 02             	mov    %dl,0x2(%eax)
}
    1699:	8b 45 08             	mov    0x8(%ebp),%eax
    169c:	c9                   	leave  
    169d:	c2 04 00             	ret    $0x4

000016a0 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    16a0:	55                   	push   %ebp
    16a1:	89 e5                	mov    %esp,%ebp
    16a3:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    16a6:	8b 45 08             	mov    0x8(%ebp),%eax
    16a9:	8b 00                	mov    (%eax),%eax
    16ab:	83 ec 08             	sub    $0x8,%esp
    16ae:	8d 55 0c             	lea    0xc(%ebp),%edx
    16b1:	52                   	push   %edx
    16b2:	50                   	push   %eax
    16b3:	e8 95 ef ff ff       	call   64d <sendMessage>
    16b8:	83 c4 10             	add    $0x10,%esp
}
    16bb:	90                   	nop
    16bc:	c9                   	leave  
    16bd:	c3                   	ret    

000016be <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16be:	55                   	push   %ebp
    16bf:	89 e5                	mov    %esp,%ebp
    16c1:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16c4:	83 ec 0c             	sub    $0xc,%esp
    16c7:	68 90 00 00 00       	push   $0x90
    16cc:	e8 3e f3 ff ff       	call   a0f <malloc>
    16d1:	83 c4 10             	add    $0x10,%esp
    16d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16db:	75 15                	jne    16f2 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16dd:	83 ec 04             	sub    $0x4,%esp
    16e0:	ff 75 08             	pushl  0x8(%ebp)
    16e3:	68 e4 23 00 00       	push   $0x23e4
    16e8:	6a 01                	push   $0x1
    16ea:	e8 4d f0 ff ff       	call   73c <printf>
    16ef:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f5:	83 c0 7c             	add    $0x7c,%eax
    16f8:	83 ec 08             	sub    $0x8,%esp
    16fb:	ff 75 08             	pushl  0x8(%ebp)
    16fe:	50                   	push   %eax
    16ff:	e8 68 ec ff ff       	call   36c <strcpy>
    1704:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1707:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170a:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1711:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1714:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    171b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171e:	8b 40 34             	mov    0x34(%eax),%eax
    1721:	89 c2                	mov    %eax,%edx
    1723:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1726:	8b 40 38             	mov    0x38(%eax),%eax
    1729:	0f af d0             	imul   %eax,%edx
    172c:	89 d0                	mov    %edx,%eax
    172e:	01 c0                	add    %eax,%eax
    1730:	01 d0                	add    %edx,%eax
    1732:	83 ec 0c             	sub    $0xc,%esp
    1735:	50                   	push   %eax
    1736:	e8 d4 f2 ff ff       	call   a0f <malloc>
    173b:	83 c4 10             	add    $0x10,%esp
    173e:	89 c2                	mov    %eax,%edx
    1740:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1743:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1746:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1749:	8b 40 4c             	mov    0x4c(%eax),%eax
    174c:	85 c0                	test   %eax,%eax
    174e:	75 15                	jne    1765 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    1750:	83 ec 04             	sub    $0x4,%esp
    1753:	ff 75 08             	pushl  0x8(%ebp)
    1756:	68 04 24 00 00       	push   $0x2404
    175b:	6a 01                	push   $0x1
    175d:	e8 da ef ff ff       	call   73c <printf>
    1762:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1765:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1768:	8b 40 34             	mov    0x34(%eax),%eax
    176b:	89 c2                	mov    %eax,%edx
    176d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1770:	8b 40 38             	mov    0x38(%eax),%eax
    1773:	0f af d0             	imul   %eax,%edx
    1776:	89 d0                	mov    %edx,%eax
    1778:	01 c0                	add    %eax,%eax
    177a:	01 c2                	add    %eax,%edx
    177c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    177f:	8b 40 4c             	mov    0x4c(%eax),%eax
    1782:	83 ec 04             	sub    $0x4,%esp
    1785:	52                   	push   %edx
    1786:	68 ff ff ff 00       	push   $0xffffff
    178b:	50                   	push   %eax
    178c:	e8 71 ec ff ff       	call   402 <memset>
    1791:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    1794:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1797:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    179e:	e8 7a ee ff ff       	call   61d <getpid>
    17a3:	89 c2                	mov    %eax,%edx
    17a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17a8:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    17ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ae:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b8:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c2:	8b 40 50             	mov    0x50(%eax),%eax
    17c5:	89 c2                	mov    %eax,%edx
    17c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ca:	8b 40 54             	mov    0x54(%eax),%eax
    17cd:	0f af d0             	imul   %eax,%edx
    17d0:	89 d0                	mov    %edx,%eax
    17d2:	01 c0                	add    %eax,%eax
    17d4:	01 d0                	add    %edx,%eax
    17d6:	83 ec 0c             	sub    $0xc,%esp
    17d9:	50                   	push   %eax
    17da:	e8 30 f2 ff ff       	call   a0f <malloc>
    17df:	83 c4 10             	add    $0x10,%esp
    17e2:	89 c2                	mov    %eax,%edx
    17e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e7:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    17ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ed:	8b 40 68             	mov    0x68(%eax),%eax
    17f0:	85 c0                	test   %eax,%eax
    17f2:	75 15                	jne    1809 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17f4:	83 ec 04             	sub    $0x4,%esp
    17f7:	ff 75 08             	pushl  0x8(%ebp)
    17fa:	68 28 24 00 00       	push   $0x2428
    17ff:	6a 01                	push   $0x1
    1801:	e8 36 ef ff ff       	call   73c <printf>
    1806:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1809:	8b 45 f4             	mov    -0xc(%ebp),%eax
    180c:	8b 40 34             	mov    0x34(%eax),%eax
    180f:	89 c2                	mov    %eax,%edx
    1811:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1814:	8b 40 38             	mov    0x38(%eax),%eax
    1817:	0f af d0             	imul   %eax,%edx
    181a:	89 d0                	mov    %edx,%eax
    181c:	01 c0                	add    %eax,%eax
    181e:	01 c2                	add    %eax,%edx
    1820:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1823:	8b 40 4c             	mov    0x4c(%eax),%eax
    1826:	83 ec 04             	sub    $0x4,%esp
    1829:	52                   	push   %edx
    182a:	68 ff 00 00 00       	push   $0xff
    182f:	50                   	push   %eax
    1830:	e8 cd eb ff ff       	call   402 <memset>
    1835:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1838:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183b:	8b 55 0c             	mov    0xc(%ebp),%edx
    183e:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1841:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1845:	74 35                	je     187c <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1847:	8b 45 10             	mov    0x10(%ebp),%eax
    184a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1850:	83 ec 0c             	sub    $0xc,%esp
    1853:	50                   	push   %eax
    1854:	e8 b6 f1 ff ff       	call   a0f <malloc>
    1859:	83 c4 10             	add    $0x10,%esp
    185c:	89 c2                	mov    %eax,%edx
    185e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1861:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    1864:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1867:	8b 55 10             	mov    0x10(%ebp),%edx
    186a:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    186d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1870:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    1877:	e9 8d 00 00 00       	jmp    1909 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187f:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    1886:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1889:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1890:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1893:	8b 40 18             	mov    0x18(%eax),%eax
    1896:	89 c2                	mov    %eax,%edx
    1898:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189b:	8b 40 1c             	mov    0x1c(%eax),%eax
    189e:	0f af d0             	imul   %eax,%edx
    18a1:	89 d0                	mov    %edx,%eax
    18a3:	01 c0                	add    %eax,%eax
    18a5:	01 d0                	add    %edx,%eax
    18a7:	83 ec 0c             	sub    $0xc,%esp
    18aa:	50                   	push   %eax
    18ab:	e8 5f f1 ff ff       	call   a0f <malloc>
    18b0:	83 c4 10             	add    $0x10,%esp
    18b3:	89 c2                	mov    %eax,%edx
    18b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b8:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    18bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18be:	8b 40 30             	mov    0x30(%eax),%eax
    18c1:	85 c0                	test   %eax,%eax
    18c3:	75 15                	jne    18da <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18c5:	83 ec 04             	sub    $0x4,%esp
    18c8:	ff 75 08             	pushl  0x8(%ebp)
    18cb:	68 50 24 00 00       	push   $0x2450
    18d0:	6a 01                	push   $0x1
    18d2:	e8 65 ee ff ff       	call   73c <printf>
    18d7:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18dd:	8b 40 18             	mov    0x18(%eax),%eax
    18e0:	89 c2                	mov    %eax,%edx
    18e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e5:	8b 40 1c             	mov    0x1c(%eax),%eax
    18e8:	0f af d0             	imul   %eax,%edx
    18eb:	89 d0                	mov    %edx,%eax
    18ed:	01 c0                	add    %eax,%eax
    18ef:	01 c2                	add    %eax,%edx
    18f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f4:	8b 40 30             	mov    0x30(%eax),%eax
    18f7:	83 ec 04             	sub    $0x4,%esp
    18fa:	52                   	push   %edx
    18fb:	68 ff ff ff 00       	push   $0xffffff
    1900:	50                   	push   %eax
    1901:	e8 fc ea ff ff       	call   402 <memset>
    1906:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1909:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    190c:	c9                   	leave  
    190d:	c3                   	ret    

0000190e <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    190e:	55                   	push   %ebp
    190f:	89 e5                	mov    %esp,%ebp
    1911:	53                   	push   %ebx
    1912:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1915:	8b 45 0c             	mov    0xc(%ebp),%eax
    1918:	83 f8 03             	cmp    $0x3,%eax
    191b:	74 02                	je     191f <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    191d:	eb 33                	jmp    1952 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    191f:	8b 45 08             	mov    0x8(%ebp),%eax
    1922:	8b 48 08             	mov    0x8(%eax),%ecx
    1925:	8b 45 08             	mov    0x8(%ebp),%eax
    1928:	8b 50 38             	mov    0x38(%eax),%edx
    192b:	8b 45 08             	mov    0x8(%ebp),%eax
    192e:	8b 40 34             	mov    0x34(%eax),%eax
    1931:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1934:	83 c3 34             	add    $0x34,%ebx
    1937:	83 ec 0c             	sub    $0xc,%esp
    193a:	51                   	push   %ecx
    193b:	52                   	push   %edx
    193c:	50                   	push   %eax
    193d:	6a 00                	push   $0x0
    193f:	6a 00                	push   $0x0
    1941:	53                   	push   %ebx
    1942:	6a 32                	push   $0x32
    1944:	6a 00                	push   $0x0
    1946:	ff 75 08             	pushl  0x8(%ebp)
    1949:	e8 ef ec ff ff       	call   63d <paintWindow>
    194e:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1951:	90                   	nop
        default: break;
            
            
    }
    return False;
    1952:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1957:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    195a:	c9                   	leave  
    195b:	c3                   	ret    

0000195c <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    195c:	55                   	push   %ebp
    195d:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    195f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1962:	8b 50 08             	mov    0x8(%eax),%edx
    1965:	8b 45 08             	mov    0x8(%ebp),%eax
    1968:	8b 00                	mov    (%eax),%eax
    196a:	39 c2                	cmp    %eax,%edx
    196c:	74 07                	je     1975 <APPreJudge+0x19>
        return False;
    196e:	b8 00 00 00 00       	mov    $0x0,%eax
    1973:	eb 05                	jmp    197a <APPreJudge+0x1e>
    return True;
    1975:	b8 01 00 00 00       	mov    $0x1,%eax
}
    197a:	5d                   	pop    %ebp
    197b:	c3                   	ret    

0000197c <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    197c:	55                   	push   %ebp
    197d:	89 e5                	mov    %esp,%ebp
    197f:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1982:	8b 45 08             	mov    0x8(%ebp),%eax
    1985:	8b 55 0c             	mov    0xc(%ebp),%edx
    1988:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    198b:	83 ec 0c             	sub    $0xc,%esp
    198e:	ff 75 08             	pushl  0x8(%ebp)
    1991:	e8 c7 ec ff ff       	call   65d <registWindow>
    1996:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1999:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    19a0:	8b 45 08             	mov    0x8(%ebp),%eax
    19a3:	8b 00                	mov    (%eax),%eax
    19a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    19a8:	ff 75 f4             	pushl  -0xc(%ebp)
    19ab:	ff 75 f0             	pushl  -0x10(%ebp)
    19ae:	ff 75 ec             	pushl  -0x14(%ebp)
    19b1:	ff 75 08             	pushl  0x8(%ebp)
    19b4:	e8 e7 fc ff ff       	call   16a0 <APSendMessage>
    19b9:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    19bc:	83 ec 0c             	sub    $0xc,%esp
    19bf:	ff 75 08             	pushl  0x8(%ebp)
    19c2:	e8 8e ec ff ff       	call   655 <getMessage>
    19c7:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    19ca:	8b 45 08             	mov    0x8(%ebp),%eax
    19cd:	83 c0 6c             	add    $0x6c,%eax
    19d0:	83 ec 08             	sub    $0x8,%esp
    19d3:	50                   	push   %eax
    19d4:	ff 75 08             	pushl  0x8(%ebp)
    19d7:	e8 80 ff ff ff       	call   195c <APPreJudge>
    19dc:	83 c4 10             	add    $0x10,%esp
    19df:	84 c0                	test   %al,%al
    19e1:	74 1b                	je     19fe <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    19e3:	8b 45 08             	mov    0x8(%ebp),%eax
    19e6:	ff 70 74             	pushl  0x74(%eax)
    19e9:	ff 70 70             	pushl  0x70(%eax)
    19ec:	ff 70 6c             	pushl  0x6c(%eax)
    19ef:	ff 75 08             	pushl  0x8(%ebp)
    19f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    19f5:	ff d0                	call   *%eax
    19f7:	83 c4 10             	add    $0x10,%esp
    19fa:	84 c0                	test   %al,%al
    19fc:	75 0c                	jne    1a0a <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    19fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1a01:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1a08:	eb b2                	jmp    19bc <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a0a:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a0b:	90                   	nop
    1a0c:	c9                   	leave  
    1a0d:	c3                   	ret    

00001a0e <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a0e:	55                   	push   %ebp
    1a0f:	89 e5                	mov    %esp,%ebp
    1a11:	57                   	push   %edi
    1a12:	56                   	push   %esi
    1a13:	53                   	push   %ebx
    1a14:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a17:	a1 f0 2a 00 00       	mov    0x2af0,%eax
    1a1c:	85 c0                	test   %eax,%eax
    1a1e:	0f 85 2c 02 00 00    	jne    1c50 <APGridPaint+0x242>
    {
        iconReady = 1;
    1a24:	c7 05 f0 2a 00 00 01 	movl   $0x1,0x2af0
    1a2b:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a2e:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a31:	83 ec 08             	sub    $0x8,%esp
    1a34:	68 77 24 00 00       	push   $0x2477
    1a39:	50                   	push   %eax
    1a3a:	e8 83 f1 ff ff       	call   bc2 <APLoadBitmap>
    1a3f:	83 c4 0c             	add    $0xc,%esp
    1a42:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a45:	a3 14 2b 00 00       	mov    %eax,0x2b14
    1a4a:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a4d:	a3 18 2b 00 00       	mov    %eax,0x2b18
    1a52:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1a55:	a3 1c 2b 00 00       	mov    %eax,0x2b1c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1a5a:	83 ec 04             	sub    $0x4,%esp
    1a5d:	ff 35 1c 2b 00 00    	pushl  0x2b1c
    1a63:	ff 35 18 2b 00 00    	pushl  0x2b18
    1a69:	ff 35 14 2b 00 00    	pushl  0x2b14
    1a6f:	e8 88 f3 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1a74:	83 c4 10             	add    $0x10,%esp
    1a77:	a3 20 2b 00 00       	mov    %eax,0x2b20
        grid_river = APLoadBitmap ("grid_river.bmp");
    1a7c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a7f:	83 ec 08             	sub    $0x8,%esp
    1a82:	68 85 24 00 00       	push   $0x2485
    1a87:	50                   	push   %eax
    1a88:	e8 35 f1 ff ff       	call   bc2 <APLoadBitmap>
    1a8d:	83 c4 0c             	add    $0xc,%esp
    1a90:	8b 45 98             	mov    -0x68(%ebp),%eax
    1a93:	a3 50 2b 00 00       	mov    %eax,0x2b50
    1a98:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1a9b:	a3 54 2b 00 00       	mov    %eax,0x2b54
    1aa0:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1aa3:	a3 58 2b 00 00       	mov    %eax,0x2b58
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1aa8:	83 ec 04             	sub    $0x4,%esp
    1aab:	ff 35 58 2b 00 00    	pushl  0x2b58
    1ab1:	ff 35 54 2b 00 00    	pushl  0x2b54
    1ab7:	ff 35 50 2b 00 00    	pushl  0x2b50
    1abd:	e8 3a f3 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1ac2:	83 c4 10             	add    $0x10,%esp
    1ac5:	a3 40 2b 00 00       	mov    %eax,0x2b40
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1aca:	8d 45 98             	lea    -0x68(%ebp),%eax
    1acd:	83 ec 08             	sub    $0x8,%esp
    1ad0:	68 94 24 00 00       	push   $0x2494
    1ad5:	50                   	push   %eax
    1ad6:	e8 e7 f0 ff ff       	call   bc2 <APLoadBitmap>
    1adb:	83 c4 0c             	add    $0xc,%esp
    1ade:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ae1:	a3 44 2b 00 00       	mov    %eax,0x2b44
    1ae6:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ae9:	a3 48 2b 00 00       	mov    %eax,0x2b48
    1aee:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1af1:	a3 4c 2b 00 00       	mov    %eax,0x2b4c
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1af6:	83 ec 04             	sub    $0x4,%esp
    1af9:	ff 35 4c 2b 00 00    	pushl  0x2b4c
    1aff:	ff 35 48 2b 00 00    	pushl  0x2b48
    1b05:	ff 35 44 2b 00 00    	pushl  0x2b44
    1b0b:	e8 ec f2 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1b10:	83 c4 10             	add    $0x10,%esp
    1b13:	a3 f4 2a 00 00       	mov    %eax,0x2af4
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b18:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b1b:	83 ec 08             	sub    $0x8,%esp
    1b1e:	68 a3 24 00 00       	push   $0x24a3
    1b23:	50                   	push   %eax
    1b24:	e8 99 f0 ff ff       	call   bc2 <APLoadBitmap>
    1b29:	83 c4 0c             	add    $0xc,%esp
    1b2c:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b2f:	a3 28 2b 00 00       	mov    %eax,0x2b28
    1b34:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b37:	a3 2c 2b 00 00       	mov    %eax,0x2b2c
    1b3c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b3f:	a3 30 2b 00 00       	mov    %eax,0x2b30
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1b44:	83 ec 04             	sub    $0x4,%esp
    1b47:	ff 35 30 2b 00 00    	pushl  0x2b30
    1b4d:	ff 35 2c 2b 00 00    	pushl  0x2b2c
    1b53:	ff 35 28 2b 00 00    	pushl  0x2b28
    1b59:	e8 9e f2 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1b5e:	83 c4 10             	add    $0x10,%esp
    1b61:	a3 5c 2b 00 00       	mov    %eax,0x2b5c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1b66:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b69:	83 ec 08             	sub    $0x8,%esp
    1b6c:	68 b1 24 00 00       	push   $0x24b1
    1b71:	50                   	push   %eax
    1b72:	e8 4b f0 ff ff       	call   bc2 <APLoadBitmap>
    1b77:	83 c4 0c             	add    $0xc,%esp
    1b7a:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b7d:	a3 04 2b 00 00       	mov    %eax,0x2b04
    1b82:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b85:	a3 08 2b 00 00       	mov    %eax,0x2b08
    1b8a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b8d:	a3 0c 2b 00 00       	mov    %eax,0x2b0c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1b92:	83 ec 04             	sub    $0x4,%esp
    1b95:	ff 35 0c 2b 00 00    	pushl  0x2b0c
    1b9b:	ff 35 08 2b 00 00    	pushl  0x2b08
    1ba1:	ff 35 04 2b 00 00    	pushl  0x2b04
    1ba7:	e8 50 f2 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1bac:	83 c4 10             	add    $0x10,%esp
    1baf:	a3 24 2b 00 00       	mov    %eax,0x2b24
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1bb4:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bb7:	83 ec 08             	sub    $0x8,%esp
    1bba:	68 c1 24 00 00       	push   $0x24c1
    1bbf:	50                   	push   %eax
    1bc0:	e8 fd ef ff ff       	call   bc2 <APLoadBitmap>
    1bc5:	83 c4 0c             	add    $0xc,%esp
    1bc8:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bcb:	a3 f8 2a 00 00       	mov    %eax,0x2af8
    1bd0:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bd3:	a3 fc 2a 00 00       	mov    %eax,0x2afc
    1bd8:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bdb:	a3 00 2b 00 00       	mov    %eax,0x2b00
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1be0:	83 ec 04             	sub    $0x4,%esp
    1be3:	ff 35 00 2b 00 00    	pushl  0x2b00
    1be9:	ff 35 fc 2a 00 00    	pushl  0x2afc
    1bef:	ff 35 f8 2a 00 00    	pushl  0x2af8
    1bf5:	e8 02 f2 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1bfa:	83 c4 10             	add    $0x10,%esp
    1bfd:	a3 10 2b 00 00       	mov    %eax,0x2b10
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c02:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c05:	83 ec 08             	sub    $0x8,%esp
    1c08:	68 d3 24 00 00       	push   $0x24d3
    1c0d:	50                   	push   %eax
    1c0e:	e8 af ef ff ff       	call   bc2 <APLoadBitmap>
    1c13:	83 c4 0c             	add    $0xc,%esp
    1c16:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c19:	a3 34 2b 00 00       	mov    %eax,0x2b34
    1c1e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c21:	a3 38 2b 00 00       	mov    %eax,0x2b38
    1c26:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c29:	a3 3c 2b 00 00       	mov    %eax,0x2b3c
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c2e:	83 ec 04             	sub    $0x4,%esp
    1c31:	ff 35 3c 2b 00 00    	pushl  0x2b3c
    1c37:	ff 35 38 2b 00 00    	pushl  0x2b38
    1c3d:	ff 35 34 2b 00 00    	pushl  0x2b34
    1c43:	e8 b4 f1 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1c48:	83 c4 10             	add    $0x10,%esp
    1c4b:	a3 60 2b 00 00       	mov    %eax,0x2b60
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1c50:	8b 45 08             	mov    0x8(%ebp),%eax
    1c53:	8b 40 08             	mov    0x8(%eax),%eax
    1c56:	85 c0                	test   %eax,%eax
    1c58:	75 17                	jne    1c71 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1c5a:	83 ec 08             	sub    $0x8,%esp
    1c5d:	68 e4 24 00 00       	push   $0x24e4
    1c62:	6a 01                	push   $0x1
    1c64:	e8 d3 ea ff ff       	call   73c <printf>
    1c69:	83 c4 10             	add    $0x10,%esp
        return;
    1c6c:	e9 f2 03 00 00       	jmp    2063 <APGridPaint+0x655>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1c71:	8b 45 08             	mov    0x8(%ebp),%eax
    1c74:	8b 40 10             	mov    0x10(%eax),%eax
    1c77:	85 c0                	test   %eax,%eax
    1c79:	7e 10                	jle    1c8b <APGridPaint+0x27d>
    1c7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7e:	8b 50 14             	mov    0x14(%eax),%edx
    1c81:	8b 45 08             	mov    0x8(%ebp),%eax
    1c84:	8b 40 10             	mov    0x10(%eax),%eax
    1c87:	39 c2                	cmp    %eax,%edx
    1c89:	7c 17                	jl     1ca2 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1c8b:	83 ec 08             	sub    $0x8,%esp
    1c8e:	68 0a 25 00 00       	push   $0x250a
    1c93:	6a 01                	push   $0x1
    1c95:	e8 a2 ea ff ff       	call   73c <printf>
    1c9a:	83 c4 10             	add    $0x10,%esp
        return;
    1c9d:	e9 c1 03 00 00       	jmp    2063 <APGridPaint+0x655>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1ca2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca5:	8b 40 14             	mov    0x14(%eax),%eax
    1ca8:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1cae:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1cb1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1cb4:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1cb7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1cbe:	e9 96 03 00 00       	jmp    2059 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1cc3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1cca:	e9 7c 03 00 00       	jmp    204b <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1ccf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1cd2:	c1 e0 04             	shl    $0x4,%eax
    1cd5:	89 c2                	mov    %eax,%edx
    1cd7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1cda:	01 c2                	add    %eax,%edx
    1cdc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cdf:	01 d0                	add    %edx,%eax
    1ce1:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1ce4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce7:	8b 40 0c             	mov    0xc(%eax),%eax
    1cea:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1ced:	c1 e2 02             	shl    $0x2,%edx
    1cf0:	01 d0                	add    %edx,%eax
    1cf2:	8b 00                	mov    (%eax),%eax
    1cf4:	83 f8 07             	cmp    $0x7,%eax
    1cf7:	0f 87 49 03 00 00    	ja     2046 <APGridPaint+0x638>
    1cfd:	8b 04 85 20 25 00 00 	mov    0x2520(,%eax,4),%eax
    1d04:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d06:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d09:	6a 0c                	push   $0xc
    1d0b:	6a 0c                	push   $0xc
    1d0d:	6a 0c                	push   $0xc
    1d0f:	50                   	push   %eax
    1d10:	e8 46 f9 ff ff       	call   165b <RGB>
    1d15:	83 c4 0c             	add    $0xc,%esp
    1d18:	8b 1d 20 2b 00 00    	mov    0x2b20,%ebx
    1d1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d21:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d24:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d27:	6b c0 32             	imul   $0x32,%eax,%eax
    1d2a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d30:	8d 78 34             	lea    0x34(%eax),%edi
    1d33:	83 ec 0c             	sub    $0xc,%esp
    1d36:	83 ec 04             	sub    $0x4,%esp
    1d39:	89 e0                	mov    %esp,%eax
    1d3b:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1d3f:	66 89 30             	mov    %si,(%eax)
    1d42:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1d46:	88 50 02             	mov    %dl,0x2(%eax)
    1d49:	6a 32                	push   $0x32
    1d4b:	6a 32                	push   $0x32
    1d4d:	6a 00                	push   $0x0
    1d4f:	6a 00                	push   $0x0
    1d51:	53                   	push   %ebx
    1d52:	51                   	push   %ecx
    1d53:	ff 75 94             	pushl  -0x6c(%ebp)
    1d56:	57                   	push   %edi
    1d57:	e8 5b f7 ff ff       	call   14b7 <APDcCopy>
    1d5c:	83 c4 30             	add    $0x30,%esp
                    break;
    1d5f:	e9 e3 02 00 00       	jmp    2047 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1d64:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d67:	6a 69                	push   $0x69
    1d69:	6a 69                	push   $0x69
    1d6b:	6a 69                	push   $0x69
    1d6d:	50                   	push   %eax
    1d6e:	e8 e8 f8 ff ff       	call   165b <RGB>
    1d73:	83 c4 0c             	add    $0xc,%esp
    1d76:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1d7a:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    1d7e:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1d82:	88 45 ba             	mov    %al,-0x46(%ebp)
                    pen.size = 1;
    1d85:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1d8c:	8d 45 98             	lea    -0x68(%ebp),%eax
    1d8f:	6a 69                	push   $0x69
    1d91:	6a 69                	push   $0x69
    1d93:	6a 69                	push   $0x69
    1d95:	50                   	push   %eax
    1d96:	e8 c0 f8 ff ff       	call   165b <RGB>
    1d9b:	83 c4 0c             	add    $0xc,%esp
    1d9e:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1da2:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    1da6:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1daa:	88 45 b7             	mov    %al,-0x49(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1dad:	8b 45 08             	mov    0x8(%ebp),%eax
    1db0:	8d 50 34             	lea    0x34(%eax),%edx
    1db3:	8d 45 98             	lea    -0x68(%ebp),%eax
    1db6:	ff 75 bc             	pushl  -0x44(%ebp)
    1db9:	ff 75 b8             	pushl  -0x48(%ebp)
    1dbc:	52                   	push   %edx
    1dbd:	50                   	push   %eax
    1dbe:	e8 ce f0 ff ff       	call   e91 <APSetPen>
    1dc3:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1dc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc9:	8d 58 34             	lea    0x34(%eax),%ebx
    1dcc:	8d 55 98             	lea    -0x68(%ebp),%edx
    1dcf:	83 ec 04             	sub    $0x4,%esp
    1dd2:	83 ec 04             	sub    $0x4,%esp
    1dd5:	89 e0                	mov    %esp,%eax
    1dd7:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    1ddb:	66 89 08             	mov    %cx,(%eax)
    1dde:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    1de2:	88 48 02             	mov    %cl,0x2(%eax)
    1de5:	53                   	push   %ebx
    1de6:	52                   	push   %edx
    1de7:	e8 de f0 ff ff       	call   eca <APSetBrush>
    1dec:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1def:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1df2:	6b d0 32             	imul   $0x32,%eax,%edx
    1df5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1df8:	6b c0 32             	imul   $0x32,%eax,%eax
    1dfb:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1dfe:	83 c1 34             	add    $0x34,%ecx
    1e01:	83 ec 0c             	sub    $0xc,%esp
    1e04:	6a 32                	push   $0x32
    1e06:	6a 32                	push   $0x32
    1e08:	52                   	push   %edx
    1e09:	50                   	push   %eax
    1e0a:	51                   	push   %ecx
    1e0b:	e8 a2 f4 ff ff       	call   12b2 <APDrawRect>
    1e10:	83 c4 20             	add    $0x20,%esp
                    break;
    1e13:	e9 2f 02 00 00       	jmp    2047 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e18:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e1b:	6a 0c                	push   $0xc
    1e1d:	6a 0c                	push   $0xc
    1e1f:	6a 0c                	push   $0xc
    1e21:	50                   	push   %eax
    1e22:	e8 34 f8 ff ff       	call   165b <RGB>
    1e27:	83 c4 0c             	add    $0xc,%esp
    1e2a:	8b 1d 60 2b 00 00    	mov    0x2b60,%ebx
    1e30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e33:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e36:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e39:	6b c0 32             	imul   $0x32,%eax,%eax
    1e3c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e42:	8d 78 34             	lea    0x34(%eax),%edi
    1e45:	83 ec 0c             	sub    $0xc,%esp
    1e48:	83 ec 04             	sub    $0x4,%esp
    1e4b:	89 e0                	mov    %esp,%eax
    1e4d:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1e51:	66 89 30             	mov    %si,(%eax)
    1e54:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1e58:	88 50 02             	mov    %dl,0x2(%eax)
    1e5b:	6a 32                	push   $0x32
    1e5d:	6a 32                	push   $0x32
    1e5f:	6a 00                	push   $0x0
    1e61:	6a 00                	push   $0x0
    1e63:	53                   	push   %ebx
    1e64:	51                   	push   %ecx
    1e65:	ff 75 94             	pushl  -0x6c(%ebp)
    1e68:	57                   	push   %edi
    1e69:	e8 49 f6 ff ff       	call   14b7 <APDcCopy>
    1e6e:	83 c4 30             	add    $0x30,%esp
                    break;
    1e71:	e9 d1 01 00 00       	jmp    2047 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e76:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1e79:	6a 0c                	push   $0xc
    1e7b:	6a 0c                	push   $0xc
    1e7d:	6a 0c                	push   $0xc
    1e7f:	50                   	push   %eax
    1e80:	e8 d6 f7 ff ff       	call   165b <RGB>
    1e85:	83 c4 0c             	add    $0xc,%esp
    1e88:	8b 1d 40 2b 00 00    	mov    0x2b40,%ebx
    1e8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e91:	6b c8 32             	imul   $0x32,%eax,%ecx
    1e94:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e97:	6b c0 32             	imul   $0x32,%eax,%eax
    1e9a:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1e9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea0:	8d 78 34             	lea    0x34(%eax),%edi
    1ea3:	83 ec 0c             	sub    $0xc,%esp
    1ea6:	83 ec 04             	sub    $0x4,%esp
    1ea9:	89 e0                	mov    %esp,%eax
    1eab:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1eaf:	66 89 30             	mov    %si,(%eax)
    1eb2:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1eb6:	88 50 02             	mov    %dl,0x2(%eax)
    1eb9:	6a 32                	push   $0x32
    1ebb:	6a 32                	push   $0x32
    1ebd:	6a 00                	push   $0x0
    1ebf:	6a 00                	push   $0x0
    1ec1:	53                   	push   %ebx
    1ec2:	51                   	push   %ecx
    1ec3:	ff 75 94             	pushl  -0x6c(%ebp)
    1ec6:	57                   	push   %edi
    1ec7:	e8 eb f5 ff ff       	call   14b7 <APDcCopy>
    1ecc:	83 c4 30             	add    $0x30,%esp
                    break;
    1ecf:	e9 73 01 00 00       	jmp    2047 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ed4:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1ed7:	6a 0c                	push   $0xc
    1ed9:	6a 0c                	push   $0xc
    1edb:	6a 0c                	push   $0xc
    1edd:	50                   	push   %eax
    1ede:	e8 78 f7 ff ff       	call   165b <RGB>
    1ee3:	83 c4 0c             	add    $0xc,%esp
    1ee6:	8b 1d 24 2b 00 00    	mov    0x2b24,%ebx
    1eec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eef:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ef2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ef5:	6b c0 32             	imul   $0x32,%eax,%eax
    1ef8:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1efb:	8b 45 08             	mov    0x8(%ebp),%eax
    1efe:	8d 78 34             	lea    0x34(%eax),%edi
    1f01:	83 ec 0c             	sub    $0xc,%esp
    1f04:	83 ec 04             	sub    $0x4,%esp
    1f07:	89 e0                	mov    %esp,%eax
    1f09:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f0d:	66 89 30             	mov    %si,(%eax)
    1f10:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f14:	88 50 02             	mov    %dl,0x2(%eax)
    1f17:	6a 32                	push   $0x32
    1f19:	6a 32                	push   $0x32
    1f1b:	6a 00                	push   $0x0
    1f1d:	6a 00                	push   $0x0
    1f1f:	53                   	push   %ebx
    1f20:	51                   	push   %ecx
    1f21:	ff 75 94             	pushl  -0x6c(%ebp)
    1f24:	57                   	push   %edi
    1f25:	e8 8d f5 ff ff       	call   14b7 <APDcCopy>
    1f2a:	83 c4 30             	add    $0x30,%esp
                    break;
    1f2d:	e9 15 01 00 00       	jmp    2047 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f32:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1f35:	6a 0c                	push   $0xc
    1f37:	6a 0c                	push   $0xc
    1f39:	6a 0c                	push   $0xc
    1f3b:	50                   	push   %eax
    1f3c:	e8 1a f7 ff ff       	call   165b <RGB>
    1f41:	83 c4 0c             	add    $0xc,%esp
    1f44:	8b 1d 5c 2b 00 00    	mov    0x2b5c,%ebx
    1f4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f4d:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f50:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f53:	6b c0 32             	imul   $0x32,%eax,%eax
    1f56:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f59:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5c:	8d 78 34             	lea    0x34(%eax),%edi
    1f5f:	83 ec 0c             	sub    $0xc,%esp
    1f62:	83 ec 04             	sub    $0x4,%esp
    1f65:	89 e0                	mov    %esp,%eax
    1f67:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1f6b:	66 89 30             	mov    %si,(%eax)
    1f6e:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1f72:	88 50 02             	mov    %dl,0x2(%eax)
    1f75:	6a 32                	push   $0x32
    1f77:	6a 32                	push   $0x32
    1f79:	6a 00                	push   $0x0
    1f7b:	6a 00                	push   $0x0
    1f7d:	53                   	push   %ebx
    1f7e:	51                   	push   %ecx
    1f7f:	ff 75 94             	pushl  -0x6c(%ebp)
    1f82:	57                   	push   %edi
    1f83:	e8 2f f5 ff ff       	call   14b7 <APDcCopy>
    1f88:	83 c4 30             	add    $0x30,%esp
                    break;
    1f8b:	e9 b7 00 00 00       	jmp    2047 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f90:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    1f93:	6a 0c                	push   $0xc
    1f95:	6a 0c                	push   $0xc
    1f97:	6a 0c                	push   $0xc
    1f99:	50                   	push   %eax
    1f9a:	e8 bc f6 ff ff       	call   165b <RGB>
    1f9f:	83 c4 0c             	add    $0xc,%esp
    1fa2:	8b 1d f4 2a 00 00    	mov    0x2af4,%ebx
    1fa8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fab:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fae:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fb1:	6b c0 32             	imul   $0x32,%eax,%eax
    1fb4:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1fba:	8d 78 34             	lea    0x34(%eax),%edi
    1fbd:	83 ec 0c             	sub    $0xc,%esp
    1fc0:	83 ec 04             	sub    $0x4,%esp
    1fc3:	89 e0                	mov    %esp,%eax
    1fc5:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    1fc9:	66 89 30             	mov    %si,(%eax)
    1fcc:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    1fd0:	88 50 02             	mov    %dl,0x2(%eax)
    1fd3:	6a 32                	push   $0x32
    1fd5:	6a 32                	push   $0x32
    1fd7:	6a 00                	push   $0x0
    1fd9:	6a 00                	push   $0x0
    1fdb:	53                   	push   %ebx
    1fdc:	51                   	push   %ecx
    1fdd:	ff 75 94             	pushl  -0x6c(%ebp)
    1fe0:	57                   	push   %edi
    1fe1:	e8 d1 f4 ff ff       	call   14b7 <APDcCopy>
    1fe6:	83 c4 30             	add    $0x30,%esp
                    break;
    1fe9:	eb 5c                	jmp    2047 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1feb:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1fee:	6a 0c                	push   $0xc
    1ff0:	6a 0c                	push   $0xc
    1ff2:	6a 0c                	push   $0xc
    1ff4:	50                   	push   %eax
    1ff5:	e8 61 f6 ff ff       	call   165b <RGB>
    1ffa:	83 c4 0c             	add    $0xc,%esp
    1ffd:	8b 1d 10 2b 00 00    	mov    0x2b10,%ebx
    2003:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2006:	6b c8 32             	imul   $0x32,%eax,%ecx
    2009:	8b 45 e0             	mov    -0x20(%ebp),%eax
    200c:	6b c0 32             	imul   $0x32,%eax,%eax
    200f:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2012:	8b 45 08             	mov    0x8(%ebp),%eax
    2015:	8d 78 34             	lea    0x34(%eax),%edi
    2018:	83 ec 0c             	sub    $0xc,%esp
    201b:	83 ec 04             	sub    $0x4,%esp
    201e:	89 e0                	mov    %esp,%eax
    2020:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2024:	66 89 30             	mov    %si,(%eax)
    2027:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    202b:	88 50 02             	mov    %dl,0x2(%eax)
    202e:	6a 32                	push   $0x32
    2030:	6a 32                	push   $0x32
    2032:	6a 00                	push   $0x0
    2034:	6a 00                	push   $0x0
    2036:	53                   	push   %ebx
    2037:	51                   	push   %ecx
    2038:	ff 75 94             	pushl  -0x6c(%ebp)
    203b:	57                   	push   %edi
    203c:	e8 76 f4 ff ff       	call   14b7 <APDcCopy>
    2041:	83 c4 30             	add    $0x30,%esp
                    break;
    2044:	eb 01                	jmp    2047 <APGridPaint+0x639>
                default: break;
    2046:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2047:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    204b:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    204f:	0f 8e 7a fc ff ff    	jle    1ccf <APGridPaint+0x2c1>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2055:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2059:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    205d:	0f 8e 60 fc ff ff    	jle    1cc3 <APGridPaint+0x2b5>
                    break;
                default: break;
            }
        }
    }
}
    2063:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2066:	5b                   	pop    %ebx
    2067:	5e                   	pop    %esi
    2068:	5f                   	pop    %edi
    2069:	5d                   	pop    %ebp
    206a:	c3                   	ret    

0000206b <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    206b:	55                   	push   %ebp
    206c:	89 e5                	mov    %esp,%ebp
    206e:	53                   	push   %ebx
    206f:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2072:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2079:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    207d:	74 17                	je     2096 <sprintint+0x2b>
    207f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2083:	79 11                	jns    2096 <sprintint+0x2b>
        neg = 1;
    2085:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    208c:	8b 45 10             	mov    0x10(%ebp),%eax
    208f:	f7 d8                	neg    %eax
    2091:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2094:	eb 06                	jmp    209c <sprintint+0x31>
    } else {
        x = xx;
    2096:	8b 45 10             	mov    0x10(%ebp),%eax
    2099:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    209c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    20a3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    20a6:	8d 41 01             	lea    0x1(%ecx),%eax
    20a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
    20ac:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20b2:	ba 00 00 00 00       	mov    $0x0,%edx
    20b7:	f7 f3                	div    %ebx
    20b9:	89 d0                	mov    %edx,%eax
    20bb:	0f b6 80 c0 2a 00 00 	movzbl 0x2ac0(%eax),%eax
    20c2:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    20c6:	8b 5d 14             	mov    0x14(%ebp),%ebx
    20c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20cc:	ba 00 00 00 00       	mov    $0x0,%edx
    20d1:	f7 f3                	div    %ebx
    20d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    20d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    20da:	75 c7                	jne    20a3 <sprintint+0x38>
    if(neg)
    20dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20e0:	74 0e                	je     20f0 <sprintint+0x85>
        buf[i++] = '-';
    20e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20e5:	8d 50 01             	lea    0x1(%eax),%edx
    20e8:	89 55 f8             	mov    %edx,-0x8(%ebp)
    20eb:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    20f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    20f3:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    20f6:	eb 1b                	jmp    2113 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    20f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    20fb:	8b 00                	mov    (%eax),%eax
    20fd:	8d 48 01             	lea    0x1(%eax),%ecx
    2100:	8b 55 0c             	mov    0xc(%ebp),%edx
    2103:	89 0a                	mov    %ecx,(%edx)
    2105:	89 c2                	mov    %eax,%edx
    2107:	8b 45 08             	mov    0x8(%ebp),%eax
    210a:	01 d0                	add    %edx,%eax
    210c:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    210f:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2113:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2117:	7f df                	jg     20f8 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2119:	eb 21                	jmp    213c <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    211b:	8b 45 0c             	mov    0xc(%ebp),%eax
    211e:	8b 00                	mov    (%eax),%eax
    2120:	8d 48 01             	lea    0x1(%eax),%ecx
    2123:	8b 55 0c             	mov    0xc(%ebp),%edx
    2126:	89 0a                	mov    %ecx,(%edx)
    2128:	89 c2                	mov    %eax,%edx
    212a:	8b 45 08             	mov    0x8(%ebp),%eax
    212d:	01 c2                	add    %eax,%edx
    212f:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    2132:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2135:	01 c8                	add    %ecx,%eax
    2137:	0f b6 00             	movzbl (%eax),%eax
    213a:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    213c:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2140:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    2144:	79 d5                	jns    211b <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    2146:	90                   	nop
    2147:	83 c4 20             	add    $0x20,%esp
    214a:	5b                   	pop    %ebx
    214b:	5d                   	pop    %ebp
    214c:	c3                   	ret    

0000214d <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    214d:	55                   	push   %ebp
    214e:	89 e5                	mov    %esp,%ebp
    2150:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    2153:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    215a:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2161:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    2168:	8d 45 0c             	lea    0xc(%ebp),%eax
    216b:	83 c0 04             	add    $0x4,%eax
    216e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    2171:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2178:	e9 d9 01 00 00       	jmp    2356 <sprintf+0x209>
        c = fmt[i] & 0xff;
    217d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2180:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2183:	01 d0                	add    %edx,%eax
    2185:	0f b6 00             	movzbl (%eax),%eax
    2188:	0f be c0             	movsbl %al,%eax
    218b:	25 ff 00 00 00       	and    $0xff,%eax
    2190:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2193:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2197:	75 2c                	jne    21c5 <sprintf+0x78>
            if(c == '%'){
    2199:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    219d:	75 0c                	jne    21ab <sprintf+0x5e>
                state = '%';
    219f:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    21a6:	e9 a7 01 00 00       	jmp    2352 <sprintf+0x205>
            } else {
                dst[j++] = c;
    21ab:	8b 45 c8             	mov    -0x38(%ebp),%eax
    21ae:	8d 50 01             	lea    0x1(%eax),%edx
    21b1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    21b4:	89 c2                	mov    %eax,%edx
    21b6:	8b 45 08             	mov    0x8(%ebp),%eax
    21b9:	01 d0                	add    %edx,%eax
    21bb:	8b 55 e0             	mov    -0x20(%ebp),%edx
    21be:	88 10                	mov    %dl,(%eax)
    21c0:	e9 8d 01 00 00       	jmp    2352 <sprintf+0x205>
            }
        } else if(state == '%'){
    21c5:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    21c9:	0f 85 83 01 00 00    	jne    2352 <sprintf+0x205>
            if(c == 'd'){
    21cf:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    21d3:	75 4c                	jne    2221 <sprintf+0xd4>
                buf[bi] = '\0';
    21d5:	8d 55 ce             	lea    -0x32(%ebp),%edx
    21d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    21db:	01 d0                	add    %edx,%eax
    21dd:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    21e0:	83 ec 0c             	sub    $0xc,%esp
    21e3:	8d 45 ce             	lea    -0x32(%ebp),%eax
    21e6:	50                   	push   %eax
    21e7:	e8 1f e3 ff ff       	call   50b <atoi>
    21ec:	83 c4 10             	add    $0x10,%esp
    21ef:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    21f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    21f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21fc:	8b 00                	mov    (%eax),%eax
    21fe:	83 ec 08             	sub    $0x8,%esp
    2201:	ff 75 d8             	pushl  -0x28(%ebp)
    2204:	6a 01                	push   $0x1
    2206:	6a 0a                	push   $0xa
    2208:	50                   	push   %eax
    2209:	8d 45 c8             	lea    -0x38(%ebp),%eax
    220c:	50                   	push   %eax
    220d:	ff 75 08             	pushl  0x8(%ebp)
    2210:	e8 56 fe ff ff       	call   206b <sprintint>
    2215:	83 c4 20             	add    $0x20,%esp
                ap++;
    2218:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    221c:	e9 2a 01 00 00       	jmp    234b <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2221:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2225:	74 06                	je     222d <sprintf+0xe0>
    2227:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    222b:	75 4c                	jne    2279 <sprintf+0x12c>
                buf[bi] = '\0';
    222d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2230:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2233:	01 d0                	add    %edx,%eax
    2235:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2238:	83 ec 0c             	sub    $0xc,%esp
    223b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    223e:	50                   	push   %eax
    223f:	e8 c7 e2 ff ff       	call   50b <atoi>
    2244:	83 c4 10             	add    $0x10,%esp
    2247:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    224a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2251:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2254:	8b 00                	mov    (%eax),%eax
    2256:	83 ec 08             	sub    $0x8,%esp
    2259:	ff 75 dc             	pushl  -0x24(%ebp)
    225c:	6a 00                	push   $0x0
    225e:	6a 10                	push   $0x10
    2260:	50                   	push   %eax
    2261:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2264:	50                   	push   %eax
    2265:	ff 75 08             	pushl  0x8(%ebp)
    2268:	e8 fe fd ff ff       	call   206b <sprintint>
    226d:	83 c4 20             	add    $0x20,%esp
                ap++;
    2270:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2274:	e9 d2 00 00 00       	jmp    234b <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2279:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    227d:	75 46                	jne    22c5 <sprintf+0x178>
                s = (char*)*ap;
    227f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2282:	8b 00                	mov    (%eax),%eax
    2284:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2287:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    228b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    228f:	75 25                	jne    22b6 <sprintf+0x169>
                    s = "(null)";
    2291:	c7 45 f4 40 25 00 00 	movl   $0x2540,-0xc(%ebp)
                while(*s != 0){
    2298:	eb 1c                	jmp    22b6 <sprintf+0x169>
                    dst[j++] = *s;
    229a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    229d:	8d 50 01             	lea    0x1(%eax),%edx
    22a0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22a3:	89 c2                	mov    %eax,%edx
    22a5:	8b 45 08             	mov    0x8(%ebp),%eax
    22a8:	01 c2                	add    %eax,%edx
    22aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22ad:	0f b6 00             	movzbl (%eax),%eax
    22b0:	88 02                	mov    %al,(%edx)
                    s++;
    22b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    22b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22b9:	0f b6 00             	movzbl (%eax),%eax
    22bc:	84 c0                	test   %al,%al
    22be:	75 da                	jne    229a <sprintf+0x14d>
    22c0:	e9 86 00 00 00       	jmp    234b <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    22c5:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    22c9:	75 1d                	jne    22e8 <sprintf+0x19b>
                dst[j++] = *ap;
    22cb:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22ce:	8d 50 01             	lea    0x1(%eax),%edx
    22d1:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22d4:	89 c2                	mov    %eax,%edx
    22d6:	8b 45 08             	mov    0x8(%ebp),%eax
    22d9:	01 c2                	add    %eax,%edx
    22db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    22de:	8b 00                	mov    (%eax),%eax
    22e0:	88 02                	mov    %al,(%edx)
                ap++;
    22e2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    22e6:	eb 63                	jmp    234b <sprintf+0x1fe>
            } else if(c == '%'){
    22e8:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    22ec:	75 17                	jne    2305 <sprintf+0x1b8>
                dst[j++] = c;
    22ee:	8b 45 c8             	mov    -0x38(%ebp),%eax
    22f1:	8d 50 01             	lea    0x1(%eax),%edx
    22f4:	89 55 c8             	mov    %edx,-0x38(%ebp)
    22f7:	89 c2                	mov    %eax,%edx
    22f9:	8b 45 08             	mov    0x8(%ebp),%eax
    22fc:	01 d0                	add    %edx,%eax
    22fe:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2301:	88 10                	mov    %dl,(%eax)
    2303:	eb 46                	jmp    234b <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2305:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2309:	7e 18                	jle    2323 <sprintf+0x1d6>
    230b:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    230f:	7f 12                	jg     2323 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2311:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2314:	8d 50 01             	lea    0x1(%eax),%edx
    2317:	89 55 f0             	mov    %edx,-0x10(%ebp)
    231a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    231d:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2321:	eb 2f                	jmp    2352 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2323:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2326:	8d 50 01             	lea    0x1(%eax),%edx
    2329:	89 55 c8             	mov    %edx,-0x38(%ebp)
    232c:	89 c2                	mov    %eax,%edx
    232e:	8b 45 08             	mov    0x8(%ebp),%eax
    2331:	01 d0                	add    %edx,%eax
    2333:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2336:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2339:	8d 50 01             	lea    0x1(%eax),%edx
    233c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    233f:	89 c2                	mov    %eax,%edx
    2341:	8b 45 08             	mov    0x8(%ebp),%eax
    2344:	01 d0                	add    %edx,%eax
    2346:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2349:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    234b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2352:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2356:	8b 55 0c             	mov    0xc(%ebp),%edx
    2359:	8b 45 ec             	mov    -0x14(%ebp),%eax
    235c:	01 d0                	add    %edx,%eax
    235e:	0f b6 00             	movzbl (%eax),%eax
    2361:	84 c0                	test   %al,%al
    2363:	0f 85 14 fe ff ff    	jne    217d <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2369:	8b 45 c8             	mov    -0x38(%ebp),%eax
    236c:	8d 50 01             	lea    0x1(%eax),%edx
    236f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2372:	89 c2                	mov    %eax,%edx
    2374:	8b 45 08             	mov    0x8(%ebp),%eax
    2377:	01 d0                	add    %edx,%eax
    2379:	c6 00 00             	movb   $0x0,(%eax)
}
    237c:	90                   	nop
    237d:	c9                   	leave  
    237e:	c3                   	ret    
