
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
      68:	68 a0 2c 00 00       	push   $0x2ca0
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
      9a:	05 a0 2c 00 00       	add    $0x2ca0,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 a0 2c 00 00       	mov    $0x2ca0,%eax
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
      e3:	68 00 25 00 00       	push   $0x2500
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
     116:	68 14 25 00 00       	push   $0x2514
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
     179:	68 28 25 00 00       	push   $0x2528
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
     1a8:	68 35 25 00 00       	push   $0x2535
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
     25c:	68 14 25 00 00       	push   $0x2514
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
     29c:	68 28 25 00 00       	push   $0x2528
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
     2fe:	68 48 25 00 00       	push   $0x2548
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
     6d8:	0f b6 80 74 2c 00 00 	movzbl 0x2c74(%eax),%eax
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
     816:	c7 45 f4 4a 25 00 00 	movl   $0x254a,-0xc(%ebp)
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
     8dc:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
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
     9a7:	a3 b8 2c 00 00       	mov    %eax,0x2cb8
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
     a08:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
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
     a24:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
     a29:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a2c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a30:	75 23                	jne    a55 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a32:	c7 45 f0 b0 2c 00 00 	movl   $0x2cb0,-0x10(%ebp)
     a39:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3c:	a3 b8 2c 00 00       	mov    %eax,0x2cb8
     a41:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
     a46:	a3 b0 2c 00 00       	mov    %eax,0x2cb0
    base.s.size = 0;
     a4b:	c7 05 b4 2c 00 00 00 	movl   $0x0,0x2cb4
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
     aa8:	a3 b8 2c 00 00       	mov    %eax,0x2cb8
      return (void*)(p + 1);
     aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab0:	83 c0 08             	add    $0x8,%eax
     ab3:	eb 3b                	jmp    af0 <malloc+0xe1>
    }
    if(p == freep)
     ab5:	a1 b8 2c 00 00       	mov    0x2cb8,%eax
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
     bfb:	68 51 25 00 00       	push   $0x2551
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

000014b7 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    14b7:	55                   	push   %ebp
    14b8:	89 e5                	mov    %esp,%ebp
}
    14ba:	90                   	nop
    14bb:	5d                   	pop    %ebp
    14bc:	c3                   	ret    

000014bd <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14bd:	55                   	push   %ebp
    14be:	89 e5                	mov    %esp,%ebp
    14c0:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14c3:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14c7:	0f 88 8e 01 00 00    	js     165b <APDcCopy+0x19e>
    14cd:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14d1:	0f 88 84 01 00 00    	js     165b <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14d7:	8b 55 0c             	mov    0xc(%ebp),%edx
    14da:	8b 45 20             	mov    0x20(%ebp),%eax
    14dd:	01 d0                	add    %edx,%eax
    14df:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14e2:	8b 55 10             	mov    0x10(%ebp),%edx
    14e5:	8b 45 24             	mov    0x24(%ebp),%eax
    14e8:	01 d0                	add    %edx,%eax
    14ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14ed:	8b 55 18             	mov    0x18(%ebp),%edx
    14f0:	8b 45 20             	mov    0x20(%ebp),%eax
    14f3:	01 d0                	add    %edx,%eax
    14f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14f8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    14fb:	8b 45 24             	mov    0x24(%ebp),%eax
    14fe:	01 d0                	add    %edx,%eax
    1500:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1503:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1507:	0f 88 51 01 00 00    	js     165e <APDcCopy+0x1a1>
    150d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1511:	0f 88 47 01 00 00    	js     165e <APDcCopy+0x1a1>
    1517:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    151b:	0f 88 3d 01 00 00    	js     165e <APDcCopy+0x1a1>
    1521:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1525:	0f 88 33 01 00 00    	js     165e <APDcCopy+0x1a1>
    152b:	8b 45 14             	mov    0x14(%ebp),%eax
    152e:	8b 00                	mov    (%eax),%eax
    1530:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1533:	0f 8c 25 01 00 00    	jl     165e <APDcCopy+0x1a1>
    1539:	8b 45 14             	mov    0x14(%ebp),%eax
    153c:	8b 40 04             	mov    0x4(%eax),%eax
    153f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1542:	0f 8c 16 01 00 00    	jl     165e <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1548:	8b 45 08             	mov    0x8(%ebp),%eax
    154b:	8b 00                	mov    (%eax),%eax
    154d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1550:	7f 0b                	jg     155d <APDcCopy+0xa0>
    1552:	8b 45 08             	mov    0x8(%ebp),%eax
    1555:	8b 00                	mov    (%eax),%eax
    1557:	83 e8 01             	sub    $0x1,%eax
    155a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    155d:	8b 45 08             	mov    0x8(%ebp),%eax
    1560:	8b 40 04             	mov    0x4(%eax),%eax
    1563:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1566:	7f 0c                	jg     1574 <APDcCopy+0xb7>
    1568:	8b 45 08             	mov    0x8(%ebp),%eax
    156b:	8b 40 04             	mov    0x4(%eax),%eax
    156e:	83 e8 01             	sub    $0x1,%eax
    1571:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1574:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    157b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1582:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1589:	e9 bc 00 00 00       	jmp    164a <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    158e:	8b 45 08             	mov    0x8(%ebp),%eax
    1591:	8b 00                	mov    (%eax),%eax
    1593:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1596:	8b 55 10             	mov    0x10(%ebp),%edx
    1599:	01 ca                	add    %ecx,%edx
    159b:	0f af d0             	imul   %eax,%edx
    159e:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a1:	01 d0                	add    %edx,%eax
    15a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    15a6:	8b 45 14             	mov    0x14(%ebp),%eax
    15a9:	8b 00                	mov    (%eax),%eax
    15ab:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15ae:	8b 55 1c             	mov    0x1c(%ebp),%edx
    15b1:	01 ca                	add    %ecx,%edx
    15b3:	0f af d0             	imul   %eax,%edx
    15b6:	8b 45 18             	mov    0x18(%ebp),%eax
    15b9:	01 d0                	add    %edx,%eax
    15bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    15be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15c5:	eb 74                	jmp    163b <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15c7:	8b 45 14             	mov    0x14(%ebp),%eax
    15ca:	8b 50 18             	mov    0x18(%eax),%edx
    15cd:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15d3:	01 c8                	add    %ecx,%eax
    15d5:	89 c1                	mov    %eax,%ecx
    15d7:	89 c8                	mov    %ecx,%eax
    15d9:	01 c0                	add    %eax,%eax
    15db:	01 c8                	add    %ecx,%eax
    15dd:	01 d0                	add    %edx,%eax
    15df:	0f b7 10             	movzwl (%eax),%edx
    15e2:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15e6:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15ea:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15ed:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15f1:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    15f5:	38 c2                	cmp    %al,%dl
    15f7:	75 18                	jne    1611 <APDcCopy+0x154>
    15f9:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    15fd:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1601:	38 c2                	cmp    %al,%dl
    1603:	75 0c                	jne    1611 <APDcCopy+0x154>
    1605:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1609:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    160d:	38 c2                	cmp    %al,%dl
    160f:	74 26                	je     1637 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1611:	8b 45 08             	mov    0x8(%ebp),%eax
    1614:	8b 50 18             	mov    0x18(%eax),%edx
    1617:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    161a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161d:	01 c8                	add    %ecx,%eax
    161f:	89 c1                	mov    %eax,%ecx
    1621:	89 c8                	mov    %ecx,%eax
    1623:	01 c0                	add    %eax,%eax
    1625:	01 c8                	add    %ecx,%eax
    1627:	01 d0                	add    %edx,%eax
    1629:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    162d:	66 89 10             	mov    %dx,(%eax)
    1630:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1634:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1637:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    163b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    163e:	2b 45 0c             	sub    0xc(%ebp),%eax
    1641:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1644:	7d 81                	jge    15c7 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1646:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    164a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    164d:	2b 45 10             	sub    0x10(%ebp),%eax
    1650:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1653:	0f 8d 35 ff ff ff    	jge    158e <APDcCopy+0xd1>
    1659:	eb 04                	jmp    165f <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    165b:	90                   	nop
    165c:	eb 01                	jmp    165f <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    165e:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    165f:	c9                   	leave  
    1660:	c3                   	ret    

00001661 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1661:	55                   	push   %ebp
    1662:	89 e5                	mov    %esp,%ebp
    1664:	83 ec 1c             	sub    $0x1c,%esp
    1667:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    166a:	8b 55 10             	mov    0x10(%ebp),%edx
    166d:	8b 45 14             	mov    0x14(%ebp),%eax
    1670:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1673:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1676:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1679:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    167d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1680:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1684:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1687:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    168b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    168e:	8b 45 08             	mov    0x8(%ebp),%eax
    1691:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    1695:	66 89 10             	mov    %dx,(%eax)
    1698:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    169c:	88 50 02             	mov    %dl,0x2(%eax)
}
    169f:	8b 45 08             	mov    0x8(%ebp),%eax
    16a2:	c9                   	leave  
    16a3:	c2 04 00             	ret    $0x4

000016a6 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    16a6:	55                   	push   %ebp
    16a7:	89 e5                	mov    %esp,%ebp
    16a9:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    16ac:	8b 45 08             	mov    0x8(%ebp),%eax
    16af:	8b 00                	mov    (%eax),%eax
    16b1:	83 ec 08             	sub    $0x8,%esp
    16b4:	8d 55 0c             	lea    0xc(%ebp),%edx
    16b7:	52                   	push   %edx
    16b8:	50                   	push   %eax
    16b9:	e8 87 ef ff ff       	call   645 <sendMessage>
    16be:	83 c4 10             	add    $0x10,%esp
}
    16c1:	90                   	nop
    16c2:	c9                   	leave  
    16c3:	c3                   	ret    

000016c4 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16c4:	55                   	push   %ebp
    16c5:	89 e5                	mov    %esp,%ebp
    16c7:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16ca:	83 ec 0c             	sub    $0xc,%esp
    16cd:	68 98 00 00 00       	push   $0x98
    16d2:	e8 38 f3 ff ff       	call   a0f <malloc>
    16d7:	83 c4 10             	add    $0x10,%esp
    16da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16e1:	75 15                	jne    16f8 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16e3:	83 ec 04             	sub    $0x4,%esp
    16e6:	ff 75 08             	pushl  0x8(%ebp)
    16e9:	68 64 25 00 00       	push   $0x2564
    16ee:	6a 01                	push   $0x1
    16f0:	e8 47 f0 ff ff       	call   73c <printf>
    16f5:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    16f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fb:	05 84 00 00 00       	add    $0x84,%eax
    1700:	83 ec 08             	sub    $0x8,%esp
    1703:	ff 75 08             	pushl  0x8(%ebp)
    1706:	50                   	push   %eax
    1707:	e8 60 ec ff ff       	call   36c <strcpy>
    170c:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1712:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1719:	8b 45 f4             	mov    -0xc(%ebp),%eax
    171c:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1723:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1726:	8b 40 3c             	mov    0x3c(%eax),%eax
    1729:	89 c2                	mov    %eax,%edx
    172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172e:	8b 40 40             	mov    0x40(%eax),%eax
    1731:	0f af d0             	imul   %eax,%edx
    1734:	89 d0                	mov    %edx,%eax
    1736:	01 c0                	add    %eax,%eax
    1738:	01 d0                	add    %edx,%eax
    173a:	83 ec 0c             	sub    $0xc,%esp
    173d:	50                   	push   %eax
    173e:	e8 cc f2 ff ff       	call   a0f <malloc>
    1743:	83 c4 10             	add    $0x10,%esp
    1746:	89 c2                	mov    %eax,%edx
    1748:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174b:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    174e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1751:	8b 40 54             	mov    0x54(%eax),%eax
    1754:	85 c0                	test   %eax,%eax
    1756:	75 15                	jne    176d <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1758:	83 ec 04             	sub    $0x4,%esp
    175b:	ff 75 08             	pushl  0x8(%ebp)
    175e:	68 84 25 00 00       	push   $0x2584
    1763:	6a 01                	push   $0x1
    1765:	e8 d2 ef ff ff       	call   73c <printf>
    176a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    176d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1770:	8b 40 3c             	mov    0x3c(%eax),%eax
    1773:	89 c2                	mov    %eax,%edx
    1775:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1778:	8b 40 40             	mov    0x40(%eax),%eax
    177b:	0f af d0             	imul   %eax,%edx
    177e:	89 d0                	mov    %edx,%eax
    1780:	01 c0                	add    %eax,%eax
    1782:	01 c2                	add    %eax,%edx
    1784:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1787:	8b 40 54             	mov    0x54(%eax),%eax
    178a:	83 ec 04             	sub    $0x4,%esp
    178d:	52                   	push   %edx
    178e:	68 ff ff ff 00       	push   $0xffffff
    1793:	50                   	push   %eax
    1794:	e8 69 ec ff ff       	call   402 <memset>
    1799:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    179f:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    17a6:	e8 72 ee ff ff       	call   61d <getpid>
    17ab:	89 c2                	mov    %eax,%edx
    17ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b0:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    17b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b6:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c0:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ca:	8b 40 58             	mov    0x58(%eax),%eax
    17cd:	89 c2                	mov    %eax,%edx
    17cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d2:	8b 40 5c             	mov    0x5c(%eax),%eax
    17d5:	0f af d0             	imul   %eax,%edx
    17d8:	89 d0                	mov    %edx,%eax
    17da:	01 c0                	add    %eax,%eax
    17dc:	01 d0                	add    %edx,%eax
    17de:	83 ec 0c             	sub    $0xc,%esp
    17e1:	50                   	push   %eax
    17e2:	e8 28 f2 ff ff       	call   a0f <malloc>
    17e7:	83 c4 10             	add    $0x10,%esp
    17ea:	89 c2                	mov    %eax,%edx
    17ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ef:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    17f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f5:	8b 40 70             	mov    0x70(%eax),%eax
    17f8:	85 c0                	test   %eax,%eax
    17fa:	75 15                	jne    1811 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    17fc:	83 ec 04             	sub    $0x4,%esp
    17ff:	ff 75 08             	pushl  0x8(%ebp)
    1802:	68 a8 25 00 00       	push   $0x25a8
    1807:	6a 01                	push   $0x1
    1809:	e8 2e ef ff ff       	call   73c <printf>
    180e:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1811:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1814:	8b 40 3c             	mov    0x3c(%eax),%eax
    1817:	89 c2                	mov    %eax,%edx
    1819:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181c:	8b 40 40             	mov    0x40(%eax),%eax
    181f:	0f af d0             	imul   %eax,%edx
    1822:	89 d0                	mov    %edx,%eax
    1824:	01 c0                	add    %eax,%eax
    1826:	01 c2                	add    %eax,%edx
    1828:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182b:	8b 40 54             	mov    0x54(%eax),%eax
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
    184d:	74 49                	je     1898 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    184f:	8b 45 10             	mov    0x10(%ebp),%eax
    1852:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1858:	83 ec 0c             	sub    $0xc,%esp
    185b:	50                   	push   %eax
    185c:	e8 ae f1 ff ff       	call   a0f <malloc>
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
        r->pos_x = 0;
    187f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1882:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1889:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    1893:	e9 8d 00 00 00       	jmp    1925 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    1898:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189b:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    18a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a5:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18af:	8b 40 20             	mov    0x20(%eax),%eax
    18b2:	89 c2                	mov    %eax,%edx
    18b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b7:	8b 40 24             	mov    0x24(%eax),%eax
    18ba:	0f af d0             	imul   %eax,%edx
    18bd:	89 d0                	mov    %edx,%eax
    18bf:	01 c0                	add    %eax,%eax
    18c1:	01 d0                	add    %edx,%eax
    18c3:	83 ec 0c             	sub    $0xc,%esp
    18c6:	50                   	push   %eax
    18c7:	e8 43 f1 ff ff       	call   a0f <malloc>
    18cc:	83 c4 10             	add    $0x10,%esp
    18cf:	89 c2                	mov    %eax,%edx
    18d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d4:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    18d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18da:	8b 40 38             	mov    0x38(%eax),%eax
    18dd:	85 c0                	test   %eax,%eax
    18df:	75 15                	jne    18f6 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18e1:	83 ec 04             	sub    $0x4,%esp
    18e4:	ff 75 08             	pushl  0x8(%ebp)
    18e7:	68 d0 25 00 00       	push   $0x25d0
    18ec:	6a 01                	push   $0x1
    18ee:	e8 49 ee ff ff       	call   73c <printf>
    18f3:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f9:	8b 40 20             	mov    0x20(%eax),%eax
    18fc:	89 c2                	mov    %eax,%edx
    18fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1901:	8b 40 24             	mov    0x24(%eax),%eax
    1904:	0f af d0             	imul   %eax,%edx
    1907:	89 d0                	mov    %edx,%eax
    1909:	01 c0                	add    %eax,%eax
    190b:	01 c2                	add    %eax,%edx
    190d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1910:	8b 40 38             	mov    0x38(%eax),%eax
    1913:	83 ec 04             	sub    $0x4,%esp
    1916:	52                   	push   %edx
    1917:	68 ff ff ff 00       	push   $0xffffff
    191c:	50                   	push   %eax
    191d:	e8 e0 ea ff ff       	call   402 <memset>
    1922:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1925:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1928:	c9                   	leave  
    1929:	c3                   	ret    

0000192a <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    192a:	55                   	push   %ebp
    192b:	89 e5                	mov    %esp,%ebp
    192d:	57                   	push   %edi
    192e:	56                   	push   %esi
    192f:	53                   	push   %ebx
    1930:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1933:	8b 45 0c             	mov    0xc(%ebp),%eax
    1936:	83 f8 03             	cmp    $0x3,%eax
    1939:	74 02                	je     193d <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    193b:	eb 7c                	jmp    19b9 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    193d:	8b 45 08             	mov    0x8(%ebp),%eax
    1940:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1943:	8b 45 08             	mov    0x8(%ebp),%eax
    1946:	8b 48 18             	mov    0x18(%eax),%ecx
    1949:	8b 45 08             	mov    0x8(%ebp),%eax
    194c:	8b 50 5c             	mov    0x5c(%eax),%edx
    194f:	8b 45 08             	mov    0x8(%ebp),%eax
    1952:	8b 40 58             	mov    0x58(%eax),%eax
    1955:	8b 75 08             	mov    0x8(%ebp),%esi
    1958:	83 c6 58             	add    $0x58,%esi
    195b:	83 ec 04             	sub    $0x4,%esp
    195e:	53                   	push   %ebx
    195f:	51                   	push   %ecx
    1960:	6a 00                	push   $0x0
    1962:	52                   	push   %edx
    1963:	50                   	push   %eax
    1964:	6a 00                	push   $0x0
    1966:	6a 00                	push   $0x0
    1968:	56                   	push   %esi
    1969:	6a 00                	push   $0x0
    196b:	6a 00                	push   $0x0
    196d:	ff 75 08             	pushl  0x8(%ebp)
    1970:	e8 c8 ec ff ff       	call   63d <paintWindow>
    1975:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1978:	8b 45 08             	mov    0x8(%ebp),%eax
    197b:	8b 70 1c             	mov    0x1c(%eax),%esi
    197e:	8b 45 08             	mov    0x8(%ebp),%eax
    1981:	8b 58 18             	mov    0x18(%eax),%ebx
    1984:	8b 45 08             	mov    0x8(%ebp),%eax
    1987:	8b 48 08             	mov    0x8(%eax),%ecx
    198a:	8b 45 08             	mov    0x8(%ebp),%eax
    198d:	8b 50 40             	mov    0x40(%eax),%edx
    1990:	8b 45 08             	mov    0x8(%ebp),%eax
    1993:	8b 40 3c             	mov    0x3c(%eax),%eax
    1996:	8b 7d 08             	mov    0x8(%ebp),%edi
    1999:	83 c7 3c             	add    $0x3c,%edi
    199c:	83 ec 04             	sub    $0x4,%esp
    199f:	56                   	push   %esi
    19a0:	53                   	push   %ebx
    19a1:	51                   	push   %ecx
    19a2:	52                   	push   %edx
    19a3:	50                   	push   %eax
    19a4:	6a 00                	push   $0x0
    19a6:	6a 00                	push   $0x0
    19a8:	57                   	push   %edi
    19a9:	6a 32                	push   $0x32
    19ab:	6a 00                	push   $0x0
    19ad:	ff 75 08             	pushl  0x8(%ebp)
    19b0:	e8 88 ec ff ff       	call   63d <paintWindow>
    19b5:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    19b8:	90                   	nop
        default: break;
            
            
    }
    return False;
    19b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19be:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19c1:	5b                   	pop    %ebx
    19c2:	5e                   	pop    %esi
    19c3:	5f                   	pop    %edi
    19c4:	5d                   	pop    %ebp
    19c5:	c3                   	ret    

000019c6 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    19c6:	55                   	push   %ebp
    19c7:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    19c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    19cc:	8b 50 08             	mov    0x8(%eax),%edx
    19cf:	8b 45 08             	mov    0x8(%ebp),%eax
    19d2:	8b 00                	mov    (%eax),%eax
    19d4:	39 c2                	cmp    %eax,%edx
    19d6:	74 07                	je     19df <APPreJudge+0x19>
        return False;
    19d8:	b8 00 00 00 00       	mov    $0x0,%eax
    19dd:	eb 05                	jmp    19e4 <APPreJudge+0x1e>
    return True;
    19df:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19e4:	5d                   	pop    %ebp
    19e5:	c3                   	ret    

000019e6 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19e6:	55                   	push   %ebp
    19e7:	89 e5                	mov    %esp,%ebp
    19e9:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19ec:	8b 45 08             	mov    0x8(%ebp),%eax
    19ef:	8b 55 0c             	mov    0xc(%ebp),%edx
    19f2:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    19f8:	83 ec 0c             	sub    $0xc,%esp
    19fb:	ff 75 08             	pushl  0x8(%ebp)
    19fe:	e8 52 ec ff ff       	call   655 <registWindow>
    1a03:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1a06:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1a0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a10:	8b 00                	mov    (%eax),%eax
    1a12:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1a15:	ff 75 f4             	pushl  -0xc(%ebp)
    1a18:	ff 75 f0             	pushl  -0x10(%ebp)
    1a1b:	ff 75 ec             	pushl  -0x14(%ebp)
    1a1e:	ff 75 08             	pushl  0x8(%ebp)
    1a21:	e8 80 fc ff ff       	call   16a6 <APSendMessage>
    1a26:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a29:	83 ec 0c             	sub    $0xc,%esp
    1a2c:	ff 75 08             	pushl  0x8(%ebp)
    1a2f:	e8 19 ec ff ff       	call   64d <getMessage>
    1a34:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a37:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3a:	83 c0 74             	add    $0x74,%eax
    1a3d:	83 ec 08             	sub    $0x8,%esp
    1a40:	50                   	push   %eax
    1a41:	ff 75 08             	pushl  0x8(%ebp)
    1a44:	e8 7d ff ff ff       	call   19c6 <APPreJudge>
    1a49:	83 c4 10             	add    $0x10,%esp
    1a4c:	84 c0                	test   %al,%al
    1a4e:	74 1b                	je     1a6b <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1a50:	8b 45 08             	mov    0x8(%ebp),%eax
    1a53:	ff 70 7c             	pushl  0x7c(%eax)
    1a56:	ff 70 78             	pushl  0x78(%eax)
    1a59:	ff 70 74             	pushl  0x74(%eax)
    1a5c:	ff 75 08             	pushl  0x8(%ebp)
    1a5f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a62:	ff d0                	call   *%eax
    1a64:	83 c4 10             	add    $0x10,%esp
    1a67:	84 c0                	test   %al,%al
    1a69:	75 0c                	jne    1a77 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1a6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6e:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a75:	eb b2                	jmp    1a29 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a77:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a78:	90                   	nop
    1a79:	c9                   	leave  
    1a7a:	c3                   	ret    

00001a7b <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a7b:	55                   	push   %ebp
    1a7c:	89 e5                	mov    %esp,%ebp
    1a7e:	57                   	push   %edi
    1a7f:	56                   	push   %esi
    1a80:	53                   	push   %ebx
    1a81:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a84:	a1 bc 2c 00 00       	mov    0x2cbc,%eax
    1a89:	85 c0                	test   %eax,%eax
    1a8b:	0f 85 2c 02 00 00    	jne    1cbd <APGridPaint+0x242>
    {
        iconReady = 1;
    1a91:	c7 05 bc 2c 00 00 01 	movl   $0x1,0x2cbc
    1a98:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1a9b:	8d 45 98             	lea    -0x68(%ebp),%eax
    1a9e:	83 ec 08             	sub    $0x8,%esp
    1aa1:	68 f7 25 00 00       	push   $0x25f7
    1aa6:	50                   	push   %eax
    1aa7:	e8 16 f1 ff ff       	call   bc2 <APLoadBitmap>
    1aac:	83 c4 0c             	add    $0xc,%esp
    1aaf:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ab2:	a3 e0 2c 00 00       	mov    %eax,0x2ce0
    1ab7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aba:	a3 e4 2c 00 00       	mov    %eax,0x2ce4
    1abf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ac2:	a3 e8 2c 00 00       	mov    %eax,0x2ce8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1ac7:	83 ec 04             	sub    $0x4,%esp
    1aca:	ff 35 e8 2c 00 00    	pushl  0x2ce8
    1ad0:	ff 35 e4 2c 00 00    	pushl  0x2ce4
    1ad6:	ff 35 e0 2c 00 00    	pushl  0x2ce0
    1adc:	e8 1b f3 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1ae1:	83 c4 10             	add    $0x10,%esp
    1ae4:	a3 ec 2c 00 00       	mov    %eax,0x2cec
        grid_river = APLoadBitmap ("grid_river.bmp");
    1ae9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aec:	83 ec 08             	sub    $0x8,%esp
    1aef:	68 05 26 00 00       	push   $0x2605
    1af4:	50                   	push   %eax
    1af5:	e8 c8 f0 ff ff       	call   bc2 <APLoadBitmap>
    1afa:	83 c4 0c             	add    $0xc,%esp
    1afd:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b00:	a3 1c 2d 00 00       	mov    %eax,0x2d1c
    1b05:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b08:	a3 20 2d 00 00       	mov    %eax,0x2d20
    1b0d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b10:	a3 24 2d 00 00       	mov    %eax,0x2d24
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1b15:	83 ec 04             	sub    $0x4,%esp
    1b18:	ff 35 24 2d 00 00    	pushl  0x2d24
    1b1e:	ff 35 20 2d 00 00    	pushl  0x2d20
    1b24:	ff 35 1c 2d 00 00    	pushl  0x2d1c
    1b2a:	e8 cd f2 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1b2f:	83 c4 10             	add    $0x10,%esp
    1b32:	a3 0c 2d 00 00       	mov    %eax,0x2d0c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b37:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b3a:	83 ec 08             	sub    $0x8,%esp
    1b3d:	68 14 26 00 00       	push   $0x2614
    1b42:	50                   	push   %eax
    1b43:	e8 7a f0 ff ff       	call   bc2 <APLoadBitmap>
    1b48:	83 c4 0c             	add    $0xc,%esp
    1b4b:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b4e:	a3 10 2d 00 00       	mov    %eax,0x2d10
    1b53:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b56:	a3 14 2d 00 00       	mov    %eax,0x2d14
    1b5b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b5e:	a3 18 2d 00 00       	mov    %eax,0x2d18
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1b63:	83 ec 04             	sub    $0x4,%esp
    1b66:	ff 35 18 2d 00 00    	pushl  0x2d18
    1b6c:	ff 35 14 2d 00 00    	pushl  0x2d14
    1b72:	ff 35 10 2d 00 00    	pushl  0x2d10
    1b78:	e8 7f f2 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1b7d:	83 c4 10             	add    $0x10,%esp
    1b80:	a3 c0 2c 00 00       	mov    %eax,0x2cc0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b85:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b88:	83 ec 08             	sub    $0x8,%esp
    1b8b:	68 23 26 00 00       	push   $0x2623
    1b90:	50                   	push   %eax
    1b91:	e8 2c f0 ff ff       	call   bc2 <APLoadBitmap>
    1b96:	83 c4 0c             	add    $0xc,%esp
    1b99:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b9c:	a3 f4 2c 00 00       	mov    %eax,0x2cf4
    1ba1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ba4:	a3 f8 2c 00 00       	mov    %eax,0x2cf8
    1ba9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bac:	a3 fc 2c 00 00       	mov    %eax,0x2cfc
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1bb1:	83 ec 04             	sub    $0x4,%esp
    1bb4:	ff 35 fc 2c 00 00    	pushl  0x2cfc
    1bba:	ff 35 f8 2c 00 00    	pushl  0x2cf8
    1bc0:	ff 35 f4 2c 00 00    	pushl  0x2cf4
    1bc6:	e8 31 f2 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1bcb:	83 c4 10             	add    $0x10,%esp
    1bce:	a3 28 2d 00 00       	mov    %eax,0x2d28
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1bd3:	8d 45 98             	lea    -0x68(%ebp),%eax
    1bd6:	83 ec 08             	sub    $0x8,%esp
    1bd9:	68 31 26 00 00       	push   $0x2631
    1bde:	50                   	push   %eax
    1bdf:	e8 de ef ff ff       	call   bc2 <APLoadBitmap>
    1be4:	83 c4 0c             	add    $0xc,%esp
    1be7:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bea:	a3 d0 2c 00 00       	mov    %eax,0x2cd0
    1bef:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bf2:	a3 d4 2c 00 00       	mov    %eax,0x2cd4
    1bf7:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bfa:	a3 d8 2c 00 00       	mov    %eax,0x2cd8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1bff:	83 ec 04             	sub    $0x4,%esp
    1c02:	ff 35 d8 2c 00 00    	pushl  0x2cd8
    1c08:	ff 35 d4 2c 00 00    	pushl  0x2cd4
    1c0e:	ff 35 d0 2c 00 00    	pushl  0x2cd0
    1c14:	e8 e3 f1 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1c19:	83 c4 10             	add    $0x10,%esp
    1c1c:	a3 f0 2c 00 00       	mov    %eax,0x2cf0
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c21:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c24:	83 ec 08             	sub    $0x8,%esp
    1c27:	68 41 26 00 00       	push   $0x2641
    1c2c:	50                   	push   %eax
    1c2d:	e8 90 ef ff ff       	call   bc2 <APLoadBitmap>
    1c32:	83 c4 0c             	add    $0xc,%esp
    1c35:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c38:	a3 c4 2c 00 00       	mov    %eax,0x2cc4
    1c3d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c40:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
    1c45:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c48:	a3 cc 2c 00 00       	mov    %eax,0x2ccc
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1c4d:	83 ec 04             	sub    $0x4,%esp
    1c50:	ff 35 cc 2c 00 00    	pushl  0x2ccc
    1c56:	ff 35 c8 2c 00 00    	pushl  0x2cc8
    1c5c:	ff 35 c4 2c 00 00    	pushl  0x2cc4
    1c62:	e8 95 f1 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1c67:	83 c4 10             	add    $0x10,%esp
    1c6a:	a3 dc 2c 00 00       	mov    %eax,0x2cdc
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c6f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c72:	83 ec 08             	sub    $0x8,%esp
    1c75:	68 53 26 00 00       	push   $0x2653
    1c7a:	50                   	push   %eax
    1c7b:	e8 42 ef ff ff       	call   bc2 <APLoadBitmap>
    1c80:	83 c4 0c             	add    $0xc,%esp
    1c83:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c86:	a3 00 2d 00 00       	mov    %eax,0x2d00
    1c8b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c8e:	a3 04 2d 00 00       	mov    %eax,0x2d04
    1c93:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c96:	a3 08 2d 00 00       	mov    %eax,0x2d08
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1c9b:	83 ec 04             	sub    $0x4,%esp
    1c9e:	ff 35 08 2d 00 00    	pushl  0x2d08
    1ca4:	ff 35 04 2d 00 00    	pushl  0x2d04
    1caa:	ff 35 00 2d 00 00    	pushl  0x2d00
    1cb0:	e8 47 f1 ff ff       	call   dfc <APCreateCompatibleDCFromBitmap>
    1cb5:	83 c4 10             	add    $0x10,%esp
    1cb8:	a3 2c 2d 00 00       	mov    %eax,0x2d2c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1cbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc0:	8b 40 08             	mov    0x8(%eax),%eax
    1cc3:	85 c0                	test   %eax,%eax
    1cc5:	75 17                	jne    1cde <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1cc7:	83 ec 08             	sub    $0x8,%esp
    1cca:	68 64 26 00 00       	push   $0x2664
    1ccf:	6a 01                	push   $0x1
    1cd1:	e8 66 ea ff ff       	call   73c <printf>
    1cd6:	83 c4 10             	add    $0x10,%esp
        return;
    1cd9:	e9 a0 04 00 00       	jmp    217e <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1cde:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce1:	8b 40 10             	mov    0x10(%eax),%eax
    1ce4:	85 c0                	test   %eax,%eax
    1ce6:	7e 10                	jle    1cf8 <APGridPaint+0x27d>
    1ce8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ceb:	8b 50 14             	mov    0x14(%eax),%edx
    1cee:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf1:	8b 40 10             	mov    0x10(%eax),%eax
    1cf4:	39 c2                	cmp    %eax,%edx
    1cf6:	7c 17                	jl     1d0f <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1cf8:	83 ec 08             	sub    $0x8,%esp
    1cfb:	68 8a 26 00 00       	push   $0x268a
    1d00:	6a 01                	push   $0x1
    1d02:	e8 35 ea ff ff       	call   73c <printf>
    1d07:	83 c4 10             	add    $0x10,%esp
        return;
    1d0a:	e9 6f 04 00 00       	jmp    217e <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1d0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d12:	8b 40 14             	mov    0x14(%eax),%eax
    1d15:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1d1b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d1e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d21:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d24:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1d2b:	e9 96 03 00 00       	jmp    20c6 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d30:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d37:	e9 7c 03 00 00       	jmp    20b8 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d3c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d3f:	c1 e0 04             	shl    $0x4,%eax
    1d42:	89 c2                	mov    %eax,%edx
    1d44:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d47:	01 c2                	add    %eax,%edx
    1d49:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d4c:	01 d0                	add    %edx,%eax
    1d4e:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d51:	8b 45 08             	mov    0x8(%ebp),%eax
    1d54:	8b 40 0c             	mov    0xc(%eax),%eax
    1d57:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d5a:	c1 e2 02             	shl    $0x2,%edx
    1d5d:	01 d0                	add    %edx,%eax
    1d5f:	8b 00                	mov    (%eax),%eax
    1d61:	83 f8 07             	cmp    $0x7,%eax
    1d64:	0f 87 49 03 00 00    	ja     20b3 <APGridPaint+0x638>
    1d6a:	8b 04 85 a0 26 00 00 	mov    0x26a0(,%eax,4),%eax
    1d71:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d73:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d76:	6a 0c                	push   $0xc
    1d78:	6a 0c                	push   $0xc
    1d7a:	6a 0c                	push   $0xc
    1d7c:	50                   	push   %eax
    1d7d:	e8 df f8 ff ff       	call   1661 <RGB>
    1d82:	83 c4 0c             	add    $0xc,%esp
    1d85:	8b 1d ec 2c 00 00    	mov    0x2cec,%ebx
    1d8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d8e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1d91:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d94:	6b c0 32             	imul   $0x32,%eax,%eax
    1d97:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1d9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9d:	8d 78 3c             	lea    0x3c(%eax),%edi
    1da0:	83 ec 0c             	sub    $0xc,%esp
    1da3:	83 ec 04             	sub    $0x4,%esp
    1da6:	89 e0                	mov    %esp,%eax
    1da8:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1dac:	66 89 30             	mov    %si,(%eax)
    1daf:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1db3:	88 50 02             	mov    %dl,0x2(%eax)
    1db6:	6a 32                	push   $0x32
    1db8:	6a 32                	push   $0x32
    1dba:	6a 00                	push   $0x0
    1dbc:	6a 00                	push   $0x0
    1dbe:	53                   	push   %ebx
    1dbf:	51                   	push   %ecx
    1dc0:	ff 75 94             	pushl  -0x6c(%ebp)
    1dc3:	57                   	push   %edi
    1dc4:	e8 f4 f6 ff ff       	call   14bd <APDcCopy>
    1dc9:	83 c4 30             	add    $0x30,%esp
                    break;
    1dcc:	e9 e3 02 00 00       	jmp    20b4 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1dd1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dd4:	6a 69                	push   $0x69
    1dd6:	6a 69                	push   $0x69
    1dd8:	6a 69                	push   $0x69
    1dda:	50                   	push   %eax
    1ddb:	e8 81 f8 ff ff       	call   1661 <RGB>
    1de0:	83 c4 0c             	add    $0xc,%esp
    1de3:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1de7:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1deb:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1def:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1df2:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1df9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1dfc:	6a 69                	push   $0x69
    1dfe:	6a 69                	push   $0x69
    1e00:	6a 69                	push   $0x69
    1e02:	50                   	push   %eax
    1e03:	e8 59 f8 ff ff       	call   1661 <RGB>
    1e08:	83 c4 0c             	add    $0xc,%esp
    1e0b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e0f:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1e13:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e17:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1e1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1d:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e20:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e23:	ff 75 b0             	pushl  -0x50(%ebp)
    1e26:	ff 75 ac             	pushl  -0x54(%ebp)
    1e29:	52                   	push   %edx
    1e2a:	50                   	push   %eax
    1e2b:	e8 61 f0 ff ff       	call   e91 <APSetPen>
    1e30:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1e33:	8b 45 08             	mov    0x8(%ebp),%eax
    1e36:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e39:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e3c:	83 ec 04             	sub    $0x4,%esp
    1e3f:	83 ec 04             	sub    $0x4,%esp
    1e42:	89 e0                	mov    %esp,%eax
    1e44:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1e48:	66 89 08             	mov    %cx,(%eax)
    1e4b:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1e4f:	88 48 02             	mov    %cl,0x2(%eax)
    1e52:	53                   	push   %ebx
    1e53:	52                   	push   %edx
    1e54:	e8 71 f0 ff ff       	call   eca <APSetBrush>
    1e59:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e5f:	6b d0 32             	imul   $0x32,%eax,%edx
    1e62:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e65:	6b c0 32             	imul   $0x32,%eax,%eax
    1e68:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e6b:	83 c1 3c             	add    $0x3c,%ecx
    1e6e:	83 ec 0c             	sub    $0xc,%esp
    1e71:	6a 32                	push   $0x32
    1e73:	6a 32                	push   $0x32
    1e75:	52                   	push   %edx
    1e76:	50                   	push   %eax
    1e77:	51                   	push   %ecx
    1e78:	e8 35 f4 ff ff       	call   12b2 <APDrawRect>
    1e7d:	83 c4 20             	add    $0x20,%esp
                    break;
    1e80:	e9 2f 02 00 00       	jmp    20b4 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e85:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e88:	6a 0c                	push   $0xc
    1e8a:	6a 0c                	push   $0xc
    1e8c:	6a 0c                	push   $0xc
    1e8e:	50                   	push   %eax
    1e8f:	e8 cd f7 ff ff       	call   1661 <RGB>
    1e94:	83 c4 0c             	add    $0xc,%esp
    1e97:	8b 1d 2c 2d 00 00    	mov    0x2d2c,%ebx
    1e9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ea0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ea3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ea6:	6b c0 32             	imul   $0x32,%eax,%eax
    1ea9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1eac:	8b 45 08             	mov    0x8(%ebp),%eax
    1eaf:	8d 78 3c             	lea    0x3c(%eax),%edi
    1eb2:	83 ec 0c             	sub    $0xc,%esp
    1eb5:	83 ec 04             	sub    $0x4,%esp
    1eb8:	89 e0                	mov    %esp,%eax
    1eba:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1ebe:	66 89 30             	mov    %si,(%eax)
    1ec1:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ec5:	88 50 02             	mov    %dl,0x2(%eax)
    1ec8:	6a 32                	push   $0x32
    1eca:	6a 32                	push   $0x32
    1ecc:	6a 00                	push   $0x0
    1ece:	6a 00                	push   $0x0
    1ed0:	53                   	push   %ebx
    1ed1:	51                   	push   %ecx
    1ed2:	ff 75 94             	pushl  -0x6c(%ebp)
    1ed5:	57                   	push   %edi
    1ed6:	e8 e2 f5 ff ff       	call   14bd <APDcCopy>
    1edb:	83 c4 30             	add    $0x30,%esp
                    break;
    1ede:	e9 d1 01 00 00       	jmp    20b4 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ee3:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ee6:	6a 0c                	push   $0xc
    1ee8:	6a 0c                	push   $0xc
    1eea:	6a 0c                	push   $0xc
    1eec:	50                   	push   %eax
    1eed:	e8 6f f7 ff ff       	call   1661 <RGB>
    1ef2:	83 c4 0c             	add    $0xc,%esp
    1ef5:	8b 1d 0c 2d 00 00    	mov    0x2d0c,%ebx
    1efb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1efe:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f01:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f04:	6b c0 32             	imul   $0x32,%eax,%eax
    1f07:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f0a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0d:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f10:	83 ec 0c             	sub    $0xc,%esp
    1f13:	83 ec 04             	sub    $0x4,%esp
    1f16:	89 e0                	mov    %esp,%eax
    1f18:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f1c:	66 89 30             	mov    %si,(%eax)
    1f1f:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f23:	88 50 02             	mov    %dl,0x2(%eax)
    1f26:	6a 32                	push   $0x32
    1f28:	6a 32                	push   $0x32
    1f2a:	6a 00                	push   $0x0
    1f2c:	6a 00                	push   $0x0
    1f2e:	53                   	push   %ebx
    1f2f:	51                   	push   %ecx
    1f30:	ff 75 94             	pushl  -0x6c(%ebp)
    1f33:	57                   	push   %edi
    1f34:	e8 84 f5 ff ff       	call   14bd <APDcCopy>
    1f39:	83 c4 30             	add    $0x30,%esp
                    break;
    1f3c:	e9 73 01 00 00       	jmp    20b4 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f41:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f44:	6a 0c                	push   $0xc
    1f46:	6a 0c                	push   $0xc
    1f48:	6a 0c                	push   $0xc
    1f4a:	50                   	push   %eax
    1f4b:	e8 11 f7 ff ff       	call   1661 <RGB>
    1f50:	83 c4 0c             	add    $0xc,%esp
    1f53:	8b 1d f0 2c 00 00    	mov    0x2cf0,%ebx
    1f59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f5c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f5f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f62:	6b c0 32             	imul   $0x32,%eax,%eax
    1f65:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f68:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f6e:	83 ec 0c             	sub    $0xc,%esp
    1f71:	83 ec 04             	sub    $0x4,%esp
    1f74:	89 e0                	mov    %esp,%eax
    1f76:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f7a:	66 89 30             	mov    %si,(%eax)
    1f7d:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f81:	88 50 02             	mov    %dl,0x2(%eax)
    1f84:	6a 32                	push   $0x32
    1f86:	6a 32                	push   $0x32
    1f88:	6a 00                	push   $0x0
    1f8a:	6a 00                	push   $0x0
    1f8c:	53                   	push   %ebx
    1f8d:	51                   	push   %ecx
    1f8e:	ff 75 94             	pushl  -0x6c(%ebp)
    1f91:	57                   	push   %edi
    1f92:	e8 26 f5 ff ff       	call   14bd <APDcCopy>
    1f97:	83 c4 30             	add    $0x30,%esp
                    break;
    1f9a:	e9 15 01 00 00       	jmp    20b4 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f9f:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1fa2:	6a 0c                	push   $0xc
    1fa4:	6a 0c                	push   $0xc
    1fa6:	6a 0c                	push   $0xc
    1fa8:	50                   	push   %eax
    1fa9:	e8 b3 f6 ff ff       	call   1661 <RGB>
    1fae:	83 c4 0c             	add    $0xc,%esp
    1fb1:	8b 1d 28 2d 00 00    	mov    0x2d28,%ebx
    1fb7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fba:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fbd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fc0:	6b c0 32             	imul   $0x32,%eax,%eax
    1fc3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fcc:	83 ec 0c             	sub    $0xc,%esp
    1fcf:	83 ec 04             	sub    $0x4,%esp
    1fd2:	89 e0                	mov    %esp,%eax
    1fd4:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1fd8:	66 89 30             	mov    %si,(%eax)
    1fdb:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1fdf:	88 50 02             	mov    %dl,0x2(%eax)
    1fe2:	6a 32                	push   $0x32
    1fe4:	6a 32                	push   $0x32
    1fe6:	6a 00                	push   $0x0
    1fe8:	6a 00                	push   $0x0
    1fea:	53                   	push   %ebx
    1feb:	51                   	push   %ecx
    1fec:	ff 75 94             	pushl  -0x6c(%ebp)
    1fef:	57                   	push   %edi
    1ff0:	e8 c8 f4 ff ff       	call   14bd <APDcCopy>
    1ff5:	83 c4 30             	add    $0x30,%esp
                    break;
    1ff8:	e9 b7 00 00 00       	jmp    20b4 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ffd:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2000:	6a 0c                	push   $0xc
    2002:	6a 0c                	push   $0xc
    2004:	6a 0c                	push   $0xc
    2006:	50                   	push   %eax
    2007:	e8 55 f6 ff ff       	call   1661 <RGB>
    200c:	83 c4 0c             	add    $0xc,%esp
    200f:	8b 1d c0 2c 00 00    	mov    0x2cc0,%ebx
    2015:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2018:	6b c8 32             	imul   $0x32,%eax,%ecx
    201b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    201e:	6b c0 32             	imul   $0x32,%eax,%eax
    2021:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2024:	8b 45 08             	mov    0x8(%ebp),%eax
    2027:	8d 78 3c             	lea    0x3c(%eax),%edi
    202a:	83 ec 0c             	sub    $0xc,%esp
    202d:	83 ec 04             	sub    $0x4,%esp
    2030:	89 e0                	mov    %esp,%eax
    2032:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2036:	66 89 30             	mov    %si,(%eax)
    2039:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    203d:	88 50 02             	mov    %dl,0x2(%eax)
    2040:	6a 32                	push   $0x32
    2042:	6a 32                	push   $0x32
    2044:	6a 00                	push   $0x0
    2046:	6a 00                	push   $0x0
    2048:	53                   	push   %ebx
    2049:	51                   	push   %ecx
    204a:	ff 75 94             	pushl  -0x6c(%ebp)
    204d:	57                   	push   %edi
    204e:	e8 6a f4 ff ff       	call   14bd <APDcCopy>
    2053:	83 c4 30             	add    $0x30,%esp
                    break;
    2056:	eb 5c                	jmp    20b4 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2058:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    205b:	6a 0c                	push   $0xc
    205d:	6a 0c                	push   $0xc
    205f:	6a 0c                	push   $0xc
    2061:	50                   	push   %eax
    2062:	e8 fa f5 ff ff       	call   1661 <RGB>
    2067:	83 c4 0c             	add    $0xc,%esp
    206a:	8b 1d dc 2c 00 00    	mov    0x2cdc,%ebx
    2070:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2073:	6b c8 32             	imul   $0x32,%eax,%ecx
    2076:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2079:	6b c0 32             	imul   $0x32,%eax,%eax
    207c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    207f:	8b 45 08             	mov    0x8(%ebp),%eax
    2082:	8d 78 3c             	lea    0x3c(%eax),%edi
    2085:	83 ec 0c             	sub    $0xc,%esp
    2088:	83 ec 04             	sub    $0x4,%esp
    208b:	89 e0                	mov    %esp,%eax
    208d:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    2091:	66 89 30             	mov    %si,(%eax)
    2094:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    2098:	88 50 02             	mov    %dl,0x2(%eax)
    209b:	6a 32                	push   $0x32
    209d:	6a 32                	push   $0x32
    209f:	6a 00                	push   $0x0
    20a1:	6a 00                	push   $0x0
    20a3:	53                   	push   %ebx
    20a4:	51                   	push   %ecx
    20a5:	ff 75 94             	pushl  -0x6c(%ebp)
    20a8:	57                   	push   %edi
    20a9:	e8 0f f4 ff ff       	call   14bd <APDcCopy>
    20ae:	83 c4 30             	add    $0x30,%esp
                    break;
    20b1:	eb 01                	jmp    20b4 <APGridPaint+0x639>
                default: break;
    20b3:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    20b4:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    20b8:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    20bc:	0f 8e 7a fc ff ff    	jle    1d3c <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    20c2:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    20c6:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    20ca:	0f 8e 60 fc ff ff    	jle    1d30 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    20d0:	8d 45 98             	lea    -0x68(%ebp),%eax
    20d3:	68 cd 00 00 00       	push   $0xcd
    20d8:	6a 74                	push   $0x74
    20da:	6a 18                	push   $0x18
    20dc:	50                   	push   %eax
    20dd:	e8 7f f5 ff ff       	call   1661 <RGB>
    20e2:	83 c4 0c             	add    $0xc,%esp
    20e5:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    20e9:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    20ed:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    20f1:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    20f4:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    20fb:	8d 45 98             	lea    -0x68(%ebp),%eax
    20fe:	68 cd 00 00 00       	push   $0xcd
    2103:	6a 74                	push   $0x74
    2105:	6a 18                	push   $0x18
    2107:	50                   	push   %eax
    2108:	e8 54 f5 ff ff       	call   1661 <RGB>
    210d:	83 c4 0c             	add    $0xc,%esp
    2110:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2114:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2118:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    211c:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    211f:	8b 45 08             	mov    0x8(%ebp),%eax
    2122:	8d 50 58             	lea    0x58(%eax),%edx
    2125:	8d 45 98             	lea    -0x68(%ebp),%eax
    2128:	ff 75 bc             	pushl  -0x44(%ebp)
    212b:	ff 75 b8             	pushl  -0x48(%ebp)
    212e:	52                   	push   %edx
    212f:	50                   	push   %eax
    2130:	e8 5c ed ff ff       	call   e91 <APSetPen>
    2135:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2138:	8b 45 08             	mov    0x8(%ebp),%eax
    213b:	8d 58 58             	lea    0x58(%eax),%ebx
    213e:	8d 55 98             	lea    -0x68(%ebp),%edx
    2141:	83 ec 04             	sub    $0x4,%esp
    2144:	83 ec 04             	sub    $0x4,%esp
    2147:	89 e0                	mov    %esp,%eax
    2149:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    214d:	66 89 08             	mov    %cx,(%eax)
    2150:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2154:	88 48 02             	mov    %cl,0x2(%eax)
    2157:	53                   	push   %ebx
    2158:	52                   	push   %edx
    2159:	e8 6c ed ff ff       	call   eca <APSetBrush>
    215e:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2161:	8b 45 08             	mov    0x8(%ebp),%eax
    2164:	83 c0 58             	add    $0x58,%eax
    2167:	83 ec 0c             	sub    $0xc,%esp
    216a:	6a 32                	push   $0x32
    216c:	68 20 03 00 00       	push   $0x320
    2171:	6a 00                	push   $0x0
    2173:	6a 00                	push   $0x0
    2175:	50                   	push   %eax
    2176:	e8 37 f1 ff ff       	call   12b2 <APDrawRect>
    217b:	83 c4 20             	add    $0x20,%esp
}
    217e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2181:	5b                   	pop    %ebx
    2182:	5e                   	pop    %esi
    2183:	5f                   	pop    %edi
    2184:	5d                   	pop    %ebp
    2185:	c3                   	ret    

00002186 <random>:
//

#include "APLib.h"

int random(int seed)
{
    2186:	55                   	push   %ebp
    2187:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2189:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    218d:	7e 08                	jle    2197 <random+0x11>
{
rand_num = seed;
    218f:	8b 45 08             	mov    0x8(%ebp),%eax
    2192:	a3 88 2c 00 00       	mov    %eax,0x2c88
}
rand_num *= 3;
    2197:	8b 15 88 2c 00 00    	mov    0x2c88,%edx
    219d:	89 d0                	mov    %edx,%eax
    219f:	01 c0                	add    %eax,%eax
    21a1:	01 d0                	add    %edx,%eax
    21a3:	a3 88 2c 00 00       	mov    %eax,0x2c88
if (rand_num < 0)
    21a8:	a1 88 2c 00 00       	mov    0x2c88,%eax
    21ad:	85 c0                	test   %eax,%eax
    21af:	79 0c                	jns    21bd <random+0x37>
{
rand_num *= (-1);
    21b1:	a1 88 2c 00 00       	mov    0x2c88,%eax
    21b6:	f7 d8                	neg    %eax
    21b8:	a3 88 2c 00 00       	mov    %eax,0x2c88
}
return rand_num % 997;
    21bd:	8b 0d 88 2c 00 00    	mov    0x2c88,%ecx
    21c3:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    21c8:	89 c8                	mov    %ecx,%eax
    21ca:	f7 ea                	imul   %edx
    21cc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    21cf:	c1 f8 09             	sar    $0x9,%eax
    21d2:	89 c2                	mov    %eax,%edx
    21d4:	89 c8                	mov    %ecx,%eax
    21d6:	c1 f8 1f             	sar    $0x1f,%eax
    21d9:	29 c2                	sub    %eax,%edx
    21db:	89 d0                	mov    %edx,%eax
    21dd:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    21e3:	29 c1                	sub    %eax,%ecx
    21e5:	89 c8                	mov    %ecx,%eax
}
    21e7:	5d                   	pop    %ebp
    21e8:	c3                   	ret    

000021e9 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    21e9:	55                   	push   %ebp
    21ea:	89 e5                	mov    %esp,%ebp
    21ec:	53                   	push   %ebx
    21ed:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    21f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    21f7:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    21fb:	74 17                	je     2214 <sprintint+0x2b>
    21fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2201:	79 11                	jns    2214 <sprintint+0x2b>
        neg = 1;
    2203:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    220a:	8b 45 10             	mov    0x10(%ebp),%eax
    220d:	f7 d8                	neg    %eax
    220f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2212:	eb 06                	jmp    221a <sprintint+0x31>
    } else {
        x = xx;
    2214:	8b 45 10             	mov    0x10(%ebp),%eax
    2217:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    221a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2221:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2224:	8d 41 01             	lea    0x1(%ecx),%eax
    2227:	89 45 f8             	mov    %eax,-0x8(%ebp)
    222a:	8b 5d 14             	mov    0x14(%ebp),%ebx
    222d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2230:	ba 00 00 00 00       	mov    $0x0,%edx
    2235:	f7 f3                	div    %ebx
    2237:	89 d0                	mov    %edx,%eax
    2239:	0f b6 80 8c 2c 00 00 	movzbl 0x2c8c(%eax),%eax
    2240:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2244:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2247:	8b 45 f0             	mov    -0x10(%ebp),%eax
    224a:	ba 00 00 00 00       	mov    $0x0,%edx
    224f:	f7 f3                	div    %ebx
    2251:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2254:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2258:	75 c7                	jne    2221 <sprintint+0x38>
    if(neg)
    225a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    225e:	74 0e                	je     226e <sprintint+0x85>
        buf[i++] = '-';
    2260:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2263:	8d 50 01             	lea    0x1(%eax),%edx
    2266:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2269:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    226e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2271:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2274:	eb 1b                	jmp    2291 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2276:	8b 45 0c             	mov    0xc(%ebp),%eax
    2279:	8b 00                	mov    (%eax),%eax
    227b:	8d 48 01             	lea    0x1(%eax),%ecx
    227e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2281:	89 0a                	mov    %ecx,(%edx)
    2283:	89 c2                	mov    %eax,%edx
    2285:	8b 45 08             	mov    0x8(%ebp),%eax
    2288:	01 d0                	add    %edx,%eax
    228a:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    228d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    2291:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    2295:	7f df                	jg     2276 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2297:	eb 21                	jmp    22ba <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2299:	8b 45 0c             	mov    0xc(%ebp),%eax
    229c:	8b 00                	mov    (%eax),%eax
    229e:	8d 48 01             	lea    0x1(%eax),%ecx
    22a1:	8b 55 0c             	mov    0xc(%ebp),%edx
    22a4:	89 0a                	mov    %ecx,(%edx)
    22a6:	89 c2                	mov    %eax,%edx
    22a8:	8b 45 08             	mov    0x8(%ebp),%eax
    22ab:	01 c2                	add    %eax,%edx
    22ad:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    22b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22b3:	01 c8                	add    %ecx,%eax
    22b5:	0f b6 00             	movzbl (%eax),%eax
    22b8:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22ba:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    22be:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    22c2:	79 d5                	jns    2299 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    22c4:	90                   	nop
    22c5:	83 c4 20             	add    $0x20,%esp
    22c8:	5b                   	pop    %ebx
    22c9:	5d                   	pop    %ebp
    22ca:	c3                   	ret    

000022cb <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    22cb:	55                   	push   %ebp
    22cc:	89 e5                	mov    %esp,%ebp
    22ce:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    22d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    22d8:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    22df:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    22e6:	8d 45 0c             	lea    0xc(%ebp),%eax
    22e9:	83 c0 04             	add    $0x4,%eax
    22ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    22ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    22f6:	e9 d9 01 00 00       	jmp    24d4 <sprintf+0x209>
        c = fmt[i] & 0xff;
    22fb:	8b 55 0c             	mov    0xc(%ebp),%edx
    22fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2301:	01 d0                	add    %edx,%eax
    2303:	0f b6 00             	movzbl (%eax),%eax
    2306:	0f be c0             	movsbl %al,%eax
    2309:	25 ff 00 00 00       	and    $0xff,%eax
    230e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2311:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2315:	75 2c                	jne    2343 <sprintf+0x78>
            if(c == '%'){
    2317:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    231b:	75 0c                	jne    2329 <sprintf+0x5e>
                state = '%';
    231d:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2324:	e9 a7 01 00 00       	jmp    24d0 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2329:	8b 45 c8             	mov    -0x38(%ebp),%eax
    232c:	8d 50 01             	lea    0x1(%eax),%edx
    232f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2332:	89 c2                	mov    %eax,%edx
    2334:	8b 45 08             	mov    0x8(%ebp),%eax
    2337:	01 d0                	add    %edx,%eax
    2339:	8b 55 e0             	mov    -0x20(%ebp),%edx
    233c:	88 10                	mov    %dl,(%eax)
    233e:	e9 8d 01 00 00       	jmp    24d0 <sprintf+0x205>
            }
        } else if(state == '%'){
    2343:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2347:	0f 85 83 01 00 00    	jne    24d0 <sprintf+0x205>
            if(c == 'd'){
    234d:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2351:	75 4c                	jne    239f <sprintf+0xd4>
                buf[bi] = '\0';
    2353:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2356:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2359:	01 d0                	add    %edx,%eax
    235b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    235e:	83 ec 0c             	sub    $0xc,%esp
    2361:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2364:	50                   	push   %eax
    2365:	e8 a1 e1 ff ff       	call   50b <atoi>
    236a:	83 c4 10             	add    $0x10,%esp
    236d:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2370:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2377:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    237a:	8b 00                	mov    (%eax),%eax
    237c:	83 ec 08             	sub    $0x8,%esp
    237f:	ff 75 d8             	pushl  -0x28(%ebp)
    2382:	6a 01                	push   $0x1
    2384:	6a 0a                	push   $0xa
    2386:	50                   	push   %eax
    2387:	8d 45 c8             	lea    -0x38(%ebp),%eax
    238a:	50                   	push   %eax
    238b:	ff 75 08             	pushl  0x8(%ebp)
    238e:	e8 56 fe ff ff       	call   21e9 <sprintint>
    2393:	83 c4 20             	add    $0x20,%esp
                ap++;
    2396:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    239a:	e9 2a 01 00 00       	jmp    24c9 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    239f:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    23a3:	74 06                	je     23ab <sprintf+0xe0>
    23a5:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    23a9:	75 4c                	jne    23f7 <sprintf+0x12c>
                buf[bi] = '\0';
    23ab:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23b1:	01 d0                	add    %edx,%eax
    23b3:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23b6:	83 ec 0c             	sub    $0xc,%esp
    23b9:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23bc:	50                   	push   %eax
    23bd:	e8 49 e1 ff ff       	call   50b <atoi>
    23c2:	83 c4 10             	add    $0x10,%esp
    23c5:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    23c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    23cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23d2:	8b 00                	mov    (%eax),%eax
    23d4:	83 ec 08             	sub    $0x8,%esp
    23d7:	ff 75 dc             	pushl  -0x24(%ebp)
    23da:	6a 00                	push   $0x0
    23dc:	6a 10                	push   $0x10
    23de:	50                   	push   %eax
    23df:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23e2:	50                   	push   %eax
    23e3:	ff 75 08             	pushl  0x8(%ebp)
    23e6:	e8 fe fd ff ff       	call   21e9 <sprintint>
    23eb:	83 c4 20             	add    $0x20,%esp
                ap++;
    23ee:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    23f2:	e9 d2 00 00 00       	jmp    24c9 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    23f7:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    23fb:	75 46                	jne    2443 <sprintf+0x178>
                s = (char*)*ap;
    23fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2400:	8b 00                	mov    (%eax),%eax
    2402:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2405:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2409:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    240d:	75 25                	jne    2434 <sprintf+0x169>
                    s = "(null)";
    240f:	c7 45 f4 c0 26 00 00 	movl   $0x26c0,-0xc(%ebp)
                while(*s != 0){
    2416:	eb 1c                	jmp    2434 <sprintf+0x169>
                    dst[j++] = *s;
    2418:	8b 45 c8             	mov    -0x38(%ebp),%eax
    241b:	8d 50 01             	lea    0x1(%eax),%edx
    241e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2421:	89 c2                	mov    %eax,%edx
    2423:	8b 45 08             	mov    0x8(%ebp),%eax
    2426:	01 c2                	add    %eax,%edx
    2428:	8b 45 f4             	mov    -0xc(%ebp),%eax
    242b:	0f b6 00             	movzbl (%eax),%eax
    242e:	88 02                	mov    %al,(%edx)
                    s++;
    2430:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2434:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2437:	0f b6 00             	movzbl (%eax),%eax
    243a:	84 c0                	test   %al,%al
    243c:	75 da                	jne    2418 <sprintf+0x14d>
    243e:	e9 86 00 00 00       	jmp    24c9 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2443:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2447:	75 1d                	jne    2466 <sprintf+0x19b>
                dst[j++] = *ap;
    2449:	8b 45 c8             	mov    -0x38(%ebp),%eax
    244c:	8d 50 01             	lea    0x1(%eax),%edx
    244f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2452:	89 c2                	mov    %eax,%edx
    2454:	8b 45 08             	mov    0x8(%ebp),%eax
    2457:	01 c2                	add    %eax,%edx
    2459:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    245c:	8b 00                	mov    (%eax),%eax
    245e:	88 02                	mov    %al,(%edx)
                ap++;
    2460:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2464:	eb 63                	jmp    24c9 <sprintf+0x1fe>
            } else if(c == '%'){
    2466:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    246a:	75 17                	jne    2483 <sprintf+0x1b8>
                dst[j++] = c;
    246c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    246f:	8d 50 01             	lea    0x1(%eax),%edx
    2472:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2475:	89 c2                	mov    %eax,%edx
    2477:	8b 45 08             	mov    0x8(%ebp),%eax
    247a:	01 d0                	add    %edx,%eax
    247c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    247f:	88 10                	mov    %dl,(%eax)
    2481:	eb 46                	jmp    24c9 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2483:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2487:	7e 18                	jle    24a1 <sprintf+0x1d6>
    2489:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    248d:	7f 12                	jg     24a1 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    248f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2492:	8d 50 01             	lea    0x1(%eax),%edx
    2495:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2498:	8b 55 e0             	mov    -0x20(%ebp),%edx
    249b:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    249f:	eb 2f                	jmp    24d0 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    24a1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24a4:	8d 50 01             	lea    0x1(%eax),%edx
    24a7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24aa:	89 c2                	mov    %eax,%edx
    24ac:	8b 45 08             	mov    0x8(%ebp),%eax
    24af:	01 d0                	add    %edx,%eax
    24b1:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    24b4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24b7:	8d 50 01             	lea    0x1(%eax),%edx
    24ba:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24bd:	89 c2                	mov    %eax,%edx
    24bf:	8b 45 08             	mov    0x8(%ebp),%eax
    24c2:	01 d0                	add    %edx,%eax
    24c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24c7:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    24c9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    24d0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    24d4:	8b 55 0c             	mov    0xc(%ebp),%edx
    24d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24da:	01 d0                	add    %edx,%eax
    24dc:	0f b6 00             	movzbl (%eax),%eax
    24df:	84 c0                	test   %al,%al
    24e1:	0f 85 14 fe ff ff    	jne    22fb <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    24e7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24ea:	8d 50 01             	lea    0x1(%eax),%edx
    24ed:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24f0:	89 c2                	mov    %eax,%edx
    24f2:	8b 45 08             	mov    0x8(%ebp),%eax
    24f5:	01 d0                	add    %edx,%eax
    24f7:	c6 00 00             	movb   $0x0,(%eax)
}
    24fa:	90                   	nop
    24fb:	c9                   	leave  
    24fc:	c3                   	ret    
