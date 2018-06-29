
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
      68:	68 b0 2c 00 00       	push   $0x2cb0
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
      9a:	05 b0 2c 00 00       	add    $0x2cb0,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 b0 2c 00 00       	mov    $0x2cb0,%eax
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
      e3:	68 10 25 00 00       	push   $0x2510
      e8:	6a 02                	push   $0x2
      ea:	e8 5d 06 00 00       	call   74c <printf>
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
     116:	68 24 25 00 00       	push   $0x2524
     11b:	6a 02                	push   $0x2
     11d:	e8 2a 06 00 00       	call   74c <printf>
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
     179:	68 38 25 00 00       	push   $0x2538
     17e:	6a 01                	push   $0x1
     180:	e8 c7 05 00 00       	call   74c <printf>
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
     1a8:	68 45 25 00 00       	push   $0x2545
     1ad:	6a 01                	push   $0x1
     1af:	e8 98 05 00 00       	call   74c <printf>
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
     25c:	68 24 25 00 00       	push   $0x2524
     261:	6a 01                	push   $0x1
     263:	e8 e4 04 00 00       	call   74c <printf>
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
     29c:	68 38 25 00 00       	push   $0x2538
     2a1:	6a 01                	push   $0x1
     2a3:	e8 a4 04 00 00       	call   74c <printf>
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
     2fe:	68 58 25 00 00       	push   $0x2558
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

00000675 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     675:	55                   	push   %ebp
     676:	89 e5                	mov    %esp,%ebp
     678:	83 ec 18             	sub    $0x18,%esp
     67b:	8b 45 0c             	mov    0xc(%ebp),%eax
     67e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     681:	83 ec 04             	sub    $0x4,%esp
     684:	6a 01                	push   $0x1
     686:	8d 45 f4             	lea    -0xc(%ebp),%eax
     689:	50                   	push   %eax
     68a:	ff 75 08             	pushl  0x8(%ebp)
     68d:	e8 2b ff ff ff       	call   5bd <write>
     692:	83 c4 10             	add    $0x10,%esp
}
     695:	90                   	nop
     696:	c9                   	leave  
     697:	c3                   	ret    

00000698 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     698:	55                   	push   %ebp
     699:	89 e5                	mov    %esp,%ebp
     69b:	53                   	push   %ebx
     69c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     69f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6a6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6aa:	74 17                	je     6c3 <printint+0x2b>
     6ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6b0:	79 11                	jns    6c3 <printint+0x2b>
    neg = 1;
     6b2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6bc:	f7 d8                	neg    %eax
     6be:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6c1:	eb 06                	jmp    6c9 <printint+0x31>
  } else {
    x = xx;
     6c3:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6d0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     6d3:	8d 41 01             	lea    0x1(%ecx),%eax
     6d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6d9:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6df:	ba 00 00 00 00       	mov    $0x0,%edx
     6e4:	f7 f3                	div    %ebx
     6e6:	89 d0                	mov    %edx,%eax
     6e8:	0f b6 80 84 2c 00 00 	movzbl 0x2c84(%eax),%eax
     6ef:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     6f3:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6f9:	ba 00 00 00 00       	mov    $0x0,%edx
     6fe:	f7 f3                	div    %ebx
     700:	89 45 ec             	mov    %eax,-0x14(%ebp)
     703:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     707:	75 c7                	jne    6d0 <printint+0x38>
  if(neg)
     709:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     70d:	74 2d                	je     73c <printint+0xa4>
    buf[i++] = '-';
     70f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     712:	8d 50 01             	lea    0x1(%eax),%edx
     715:	89 55 f4             	mov    %edx,-0xc(%ebp)
     718:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     71d:	eb 1d                	jmp    73c <printint+0xa4>
    putc(fd, buf[i]);
     71f:	8d 55 dc             	lea    -0x24(%ebp),%edx
     722:	8b 45 f4             	mov    -0xc(%ebp),%eax
     725:	01 d0                	add    %edx,%eax
     727:	0f b6 00             	movzbl (%eax),%eax
     72a:	0f be c0             	movsbl %al,%eax
     72d:	83 ec 08             	sub    $0x8,%esp
     730:	50                   	push   %eax
     731:	ff 75 08             	pushl  0x8(%ebp)
     734:	e8 3c ff ff ff       	call   675 <putc>
     739:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     73c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     740:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     744:	79 d9                	jns    71f <printint+0x87>
    putc(fd, buf[i]);
}
     746:	90                   	nop
     747:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     74a:	c9                   	leave  
     74b:	c3                   	ret    

0000074c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     74c:	55                   	push   %ebp
     74d:	89 e5                	mov    %esp,%ebp
     74f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     752:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     759:	8d 45 0c             	lea    0xc(%ebp),%eax
     75c:	83 c0 04             	add    $0x4,%eax
     75f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     762:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     769:	e9 59 01 00 00       	jmp    8c7 <printf+0x17b>
    c = fmt[i] & 0xff;
     76e:	8b 55 0c             	mov    0xc(%ebp),%edx
     771:	8b 45 f0             	mov    -0x10(%ebp),%eax
     774:	01 d0                	add    %edx,%eax
     776:	0f b6 00             	movzbl (%eax),%eax
     779:	0f be c0             	movsbl %al,%eax
     77c:	25 ff 00 00 00       	and    $0xff,%eax
     781:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     784:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     788:	75 2c                	jne    7b6 <printf+0x6a>
      if(c == '%'){
     78a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     78e:	75 0c                	jne    79c <printf+0x50>
        state = '%';
     790:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     797:	e9 27 01 00 00       	jmp    8c3 <printf+0x177>
      } else {
        putc(fd, c);
     79c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     79f:	0f be c0             	movsbl %al,%eax
     7a2:	83 ec 08             	sub    $0x8,%esp
     7a5:	50                   	push   %eax
     7a6:	ff 75 08             	pushl  0x8(%ebp)
     7a9:	e8 c7 fe ff ff       	call   675 <putc>
     7ae:	83 c4 10             	add    $0x10,%esp
     7b1:	e9 0d 01 00 00       	jmp    8c3 <printf+0x177>
      }
    } else if(state == '%'){
     7b6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7ba:	0f 85 03 01 00 00    	jne    8c3 <printf+0x177>
      if(c == 'd'){
     7c0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7c4:	75 1e                	jne    7e4 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7c9:	8b 00                	mov    (%eax),%eax
     7cb:	6a 01                	push   $0x1
     7cd:	6a 0a                	push   $0xa
     7cf:	50                   	push   %eax
     7d0:	ff 75 08             	pushl  0x8(%ebp)
     7d3:	e8 c0 fe ff ff       	call   698 <printint>
     7d8:	83 c4 10             	add    $0x10,%esp
        ap++;
     7db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7df:	e9 d8 00 00 00       	jmp    8bc <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7e4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7e8:	74 06                	je     7f0 <printf+0xa4>
     7ea:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7ee:	75 1e                	jne    80e <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7f3:	8b 00                	mov    (%eax),%eax
     7f5:	6a 00                	push   $0x0
     7f7:	6a 10                	push   $0x10
     7f9:	50                   	push   %eax
     7fa:	ff 75 08             	pushl  0x8(%ebp)
     7fd:	e8 96 fe ff ff       	call   698 <printint>
     802:	83 c4 10             	add    $0x10,%esp
        ap++;
     805:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     809:	e9 ae 00 00 00       	jmp    8bc <printf+0x170>
      } else if(c == 's'){
     80e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     812:	75 43                	jne    857 <printf+0x10b>
        s = (char*)*ap;
     814:	8b 45 e8             	mov    -0x18(%ebp),%eax
     817:	8b 00                	mov    (%eax),%eax
     819:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     81c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     820:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     824:	75 25                	jne    84b <printf+0xff>
          s = "(null)";
     826:	c7 45 f4 5a 25 00 00 	movl   $0x255a,-0xc(%ebp)
        while(*s != 0){
     82d:	eb 1c                	jmp    84b <printf+0xff>
          putc(fd, *s);
     82f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     832:	0f b6 00             	movzbl (%eax),%eax
     835:	0f be c0             	movsbl %al,%eax
     838:	83 ec 08             	sub    $0x8,%esp
     83b:	50                   	push   %eax
     83c:	ff 75 08             	pushl  0x8(%ebp)
     83f:	e8 31 fe ff ff       	call   675 <putc>
     844:	83 c4 10             	add    $0x10,%esp
          s++;
     847:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84e:	0f b6 00             	movzbl (%eax),%eax
     851:	84 c0                	test   %al,%al
     853:	75 da                	jne    82f <printf+0xe3>
     855:	eb 65                	jmp    8bc <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     857:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     85b:	75 1d                	jne    87a <printf+0x12e>
        putc(fd, *ap);
     85d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     860:	8b 00                	mov    (%eax),%eax
     862:	0f be c0             	movsbl %al,%eax
     865:	83 ec 08             	sub    $0x8,%esp
     868:	50                   	push   %eax
     869:	ff 75 08             	pushl  0x8(%ebp)
     86c:	e8 04 fe ff ff       	call   675 <putc>
     871:	83 c4 10             	add    $0x10,%esp
        ap++;
     874:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     878:	eb 42                	jmp    8bc <printf+0x170>
      } else if(c == '%'){
     87a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     87e:	75 17                	jne    897 <printf+0x14b>
        putc(fd, c);
     880:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     883:	0f be c0             	movsbl %al,%eax
     886:	83 ec 08             	sub    $0x8,%esp
     889:	50                   	push   %eax
     88a:	ff 75 08             	pushl  0x8(%ebp)
     88d:	e8 e3 fd ff ff       	call   675 <putc>
     892:	83 c4 10             	add    $0x10,%esp
     895:	eb 25                	jmp    8bc <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     897:	83 ec 08             	sub    $0x8,%esp
     89a:	6a 25                	push   $0x25
     89c:	ff 75 08             	pushl  0x8(%ebp)
     89f:	e8 d1 fd ff ff       	call   675 <putc>
     8a4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8aa:	0f be c0             	movsbl %al,%eax
     8ad:	83 ec 08             	sub    $0x8,%esp
     8b0:	50                   	push   %eax
     8b1:	ff 75 08             	pushl  0x8(%ebp)
     8b4:	e8 bc fd ff ff       	call   675 <putc>
     8b9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     8c3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8c7:	8b 55 0c             	mov    0xc(%ebp),%edx
     8ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8cd:	01 d0                	add    %edx,%eax
     8cf:	0f b6 00             	movzbl (%eax),%eax
     8d2:	84 c0                	test   %al,%al
     8d4:	0f 85 94 fe ff ff    	jne    76e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     8da:	90                   	nop
     8db:	c9                   	leave  
     8dc:	c3                   	ret    

000008dd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8dd:	55                   	push   %ebp
     8de:	89 e5                	mov    %esp,%ebp
     8e0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8e3:	8b 45 08             	mov    0x8(%ebp),%eax
     8e6:	83 e8 08             	sub    $0x8,%eax
     8e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8ec:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
     8f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8f4:	eb 24                	jmp    91a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f9:	8b 00                	mov    (%eax),%eax
     8fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8fe:	77 12                	ja     912 <free+0x35>
     900:	8b 45 f8             	mov    -0x8(%ebp),%eax
     903:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     906:	77 24                	ja     92c <free+0x4f>
     908:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90b:	8b 00                	mov    (%eax),%eax
     90d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     910:	77 1a                	ja     92c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     912:	8b 45 fc             	mov    -0x4(%ebp),%eax
     915:	8b 00                	mov    (%eax),%eax
     917:	89 45 fc             	mov    %eax,-0x4(%ebp)
     91a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     91d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     920:	76 d4                	jbe    8f6 <free+0x19>
     922:	8b 45 fc             	mov    -0x4(%ebp),%eax
     925:	8b 00                	mov    (%eax),%eax
     927:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     92a:	76 ca                	jbe    8f6 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     92c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92f:	8b 40 04             	mov    0x4(%eax),%eax
     932:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     939:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93c:	01 c2                	add    %eax,%edx
     93e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     941:	8b 00                	mov    (%eax),%eax
     943:	39 c2                	cmp    %eax,%edx
     945:	75 24                	jne    96b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     947:	8b 45 f8             	mov    -0x8(%ebp),%eax
     94a:	8b 50 04             	mov    0x4(%eax),%edx
     94d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     950:	8b 00                	mov    (%eax),%eax
     952:	8b 40 04             	mov    0x4(%eax),%eax
     955:	01 c2                	add    %eax,%edx
     957:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     95d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     960:	8b 00                	mov    (%eax),%eax
     962:	8b 10                	mov    (%eax),%edx
     964:	8b 45 f8             	mov    -0x8(%ebp),%eax
     967:	89 10                	mov    %edx,(%eax)
     969:	eb 0a                	jmp    975 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     96b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     96e:	8b 10                	mov    (%eax),%edx
     970:	8b 45 f8             	mov    -0x8(%ebp),%eax
     973:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     975:	8b 45 fc             	mov    -0x4(%ebp),%eax
     978:	8b 40 04             	mov    0x4(%eax),%eax
     97b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     982:	8b 45 fc             	mov    -0x4(%ebp),%eax
     985:	01 d0                	add    %edx,%eax
     987:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     98a:	75 20                	jne    9ac <free+0xcf>
    p->s.size += bp->s.size;
     98c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98f:	8b 50 04             	mov    0x4(%eax),%edx
     992:	8b 45 f8             	mov    -0x8(%ebp),%eax
     995:	8b 40 04             	mov    0x4(%eax),%eax
     998:	01 c2                	add    %eax,%edx
     99a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a3:	8b 10                	mov    (%eax),%edx
     9a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a8:	89 10                	mov    %edx,(%eax)
     9aa:	eb 08                	jmp    9b4 <free+0xd7>
  } else
    p->s.ptr = bp;
     9ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9af:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9b2:	89 10                	mov    %edx,(%eax)
  freep = p;
     9b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b7:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
}
     9bc:	90                   	nop
     9bd:	c9                   	leave  
     9be:	c3                   	ret    

000009bf <morecore>:

static Header*
morecore(uint nu)
{
     9bf:	55                   	push   %ebp
     9c0:	89 e5                	mov    %esp,%ebp
     9c2:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9c5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9cc:	77 07                	ja     9d5 <morecore+0x16>
    nu = 4096;
     9ce:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9d5:	8b 45 08             	mov    0x8(%ebp),%eax
     9d8:	c1 e0 03             	shl    $0x3,%eax
     9db:	83 ec 0c             	sub    $0xc,%esp
     9de:	50                   	push   %eax
     9df:	e8 41 fc ff ff       	call   625 <sbrk>
     9e4:	83 c4 10             	add    $0x10,%esp
     9e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9ea:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9ee:	75 07                	jne    9f7 <morecore+0x38>
    return 0;
     9f0:	b8 00 00 00 00       	mov    $0x0,%eax
     9f5:	eb 26                	jmp    a1d <morecore+0x5e>
  hp = (Header*)p;
     9f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a00:	8b 55 08             	mov    0x8(%ebp),%edx
     a03:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a06:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a09:	83 c0 08             	add    $0x8,%eax
     a0c:	83 ec 0c             	sub    $0xc,%esp
     a0f:	50                   	push   %eax
     a10:	e8 c8 fe ff ff       	call   8dd <free>
     a15:	83 c4 10             	add    $0x10,%esp
  return freep;
     a18:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
}
     a1d:	c9                   	leave  
     a1e:	c3                   	ret    

00000a1f <malloc>:

void*
malloc(uint nbytes)
{
     a1f:	55                   	push   %ebp
     a20:	89 e5                	mov    %esp,%ebp
     a22:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a25:	8b 45 08             	mov    0x8(%ebp),%eax
     a28:	83 c0 07             	add    $0x7,%eax
     a2b:	c1 e8 03             	shr    $0x3,%eax
     a2e:	83 c0 01             	add    $0x1,%eax
     a31:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a34:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
     a39:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a3c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a40:	75 23                	jne    a65 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a42:	c7 45 f0 c0 2c 00 00 	movl   $0x2cc0,-0x10(%ebp)
     a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4c:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
     a51:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
     a56:	a3 c0 2c 00 00       	mov    %eax,0x2cc0
    base.s.size = 0;
     a5b:	c7 05 c4 2c 00 00 00 	movl   $0x0,0x2cc4
     a62:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a68:	8b 00                	mov    (%eax),%eax
     a6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a70:	8b 40 04             	mov    0x4(%eax),%eax
     a73:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a76:	72 4d                	jb     ac5 <malloc+0xa6>
      if(p->s.size == nunits)
     a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7b:	8b 40 04             	mov    0x4(%eax),%eax
     a7e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     a81:	75 0c                	jne    a8f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a86:	8b 10                	mov    (%eax),%edx
     a88:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a8b:	89 10                	mov    %edx,(%eax)
     a8d:	eb 26                	jmp    ab5 <malloc+0x96>
      else {
        p->s.size -= nunits;
     a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a92:	8b 40 04             	mov    0x4(%eax),%eax
     a95:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a98:	89 c2                	mov    %eax,%edx
     a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa3:	8b 40 04             	mov    0x4(%eax),%eax
     aa6:	c1 e0 03             	shl    $0x3,%eax
     aa9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     aac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aaf:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ab2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ab5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab8:	a3 c8 2c 00 00       	mov    %eax,0x2cc8
      return (void*)(p + 1);
     abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac0:	83 c0 08             	add    $0x8,%eax
     ac3:	eb 3b                	jmp    b00 <malloc+0xe1>
    }
    if(p == freep)
     ac5:	a1 c8 2c 00 00       	mov    0x2cc8,%eax
     aca:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     acd:	75 1e                	jne    aed <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	ff 75 ec             	pushl  -0x14(%ebp)
     ad5:	e8 e5 fe ff ff       	call   9bf <morecore>
     ada:	83 c4 10             	add    $0x10,%esp
     add:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ae0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ae4:	75 07                	jne    aed <malloc+0xce>
        return 0;
     ae6:	b8 00 00 00 00       	mov    $0x0,%eax
     aeb:	eb 13                	jmp    b00 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af6:	8b 00                	mov    (%eax),%eax
     af8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     afb:	e9 6d ff ff ff       	jmp    a6d <malloc+0x4e>
}
     b00:	c9                   	leave  
     b01:	c3                   	ret    

00000b02 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
     b02:	55                   	push   %ebp
     b03:	89 e5                	mov    %esp,%ebp
     b05:	83 ec 1c             	sub    $0x1c,%esp
     b08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b0b:	8b 55 10             	mov    0x10(%ebp),%edx
     b0e:	8b 45 14             	mov    0x14(%ebp),%eax
     b11:	88 4d ec             	mov    %cl,-0x14(%ebp)
     b14:	88 55 e8             	mov    %dl,-0x18(%ebp)
     b17:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
     b1a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
     b1e:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
     b21:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     b25:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
     b28:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
     b2c:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
     b2f:	8b 45 08             	mov    0x8(%ebp),%eax
     b32:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     b36:	66 89 10             	mov    %dx,(%eax)
     b39:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     b3d:	88 50 02             	mov    %dl,0x2(%eax)
}
     b40:	8b 45 08             	mov    0x8(%ebp),%eax
     b43:	c9                   	leave  
     b44:	c2 04 00             	ret    $0x4

00000b47 <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
     b47:	55                   	push   %ebp
     b48:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
     b4a:	8b 45 08             	mov    0x8(%ebp),%eax
     b4d:	2b 45 10             	sub    0x10(%ebp),%eax
     b50:	89 c2                	mov    %eax,%edx
     b52:	8b 45 08             	mov    0x8(%ebp),%eax
     b55:	2b 45 10             	sub    0x10(%ebp),%eax
     b58:	0f af d0             	imul   %eax,%edx
     b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
     b5e:	2b 45 14             	sub    0x14(%ebp),%eax
     b61:	89 c1                	mov    %eax,%ecx
     b63:	8b 45 0c             	mov    0xc(%ebp),%eax
     b66:	2b 45 14             	sub    0x14(%ebp),%eax
     b69:	0f af c1             	imul   %ecx,%eax
     b6c:	01 d0                	add    %edx,%eax
}
     b6e:	5d                   	pop    %ebp
     b6f:	c3                   	ret    

00000b70 <abs_int>:

static inline int abs_int(int x)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
     b73:	8b 45 08             	mov    0x8(%ebp),%eax
     b76:	99                   	cltd   
     b77:	89 d0                	mov    %edx,%eax
     b79:	33 45 08             	xor    0x8(%ebp),%eax
     b7c:	29 d0                	sub    %edx,%eax
}
     b7e:	5d                   	pop    %ebp
     b7f:	c3                   	ret    

00000b80 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
    if (x < 0)
     b83:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b87:	79 07                	jns    b90 <APGetIndex+0x10>
        return X_SMALLER;
     b89:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
     b8e:	eb 40                	jmp    bd0 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
     b90:	8b 45 08             	mov    0x8(%ebp),%eax
     b93:	8b 00                	mov    (%eax),%eax
     b95:	3b 45 0c             	cmp    0xc(%ebp),%eax
     b98:	7f 07                	jg     ba1 <APGetIndex+0x21>
        return X_BIGGER;
     b9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b9f:	eb 2f                	jmp    bd0 <APGetIndex+0x50>
    if (y < 0)
     ba1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ba5:	79 07                	jns    bae <APGetIndex+0x2e>
        return Y_SMALLER;
     ba7:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
     bac:	eb 22                	jmp    bd0 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
     bae:	8b 45 08             	mov    0x8(%ebp),%eax
     bb1:	8b 40 04             	mov    0x4(%eax),%eax
     bb4:	3b 45 10             	cmp    0x10(%ebp),%eax
     bb7:	7f 07                	jg     bc0 <APGetIndex+0x40>
        return Y_BIGGER;
     bb9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     bbe:	eb 10                	jmp    bd0 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
     bc0:	8b 45 08             	mov    0x8(%ebp),%eax
     bc3:	8b 00                	mov    (%eax),%eax
     bc5:	0f af 45 10          	imul   0x10(%ebp),%eax
     bc9:	89 c2                	mov    %eax,%edx
     bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
     bce:	01 d0                	add    %edx,%eax
}
     bd0:	5d                   	pop    %ebp
     bd1:	c3                   	ret    

00000bd2 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
     bd2:	55                   	push   %ebp
     bd3:	89 e5                	mov    %esp,%ebp
     bd5:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bd8:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bdf:	8b 45 cc             	mov    -0x34(%ebp),%eax
     be2:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     be5:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bec:	83 ec 08             	sub    $0x8,%esp
     bef:	6a 00                	push   $0x0
     bf1:	ff 75 0c             	pushl  0xc(%ebp)
     bf4:	e8 e4 f9 ff ff       	call   5dd <open>
     bf9:	83 c4 10             	add    $0x10,%esp
     bfc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c03:	79 2e                	jns    c33 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
     c05:	83 ec 04             	sub    $0x4,%esp
     c08:	ff 75 0c             	pushl  0xc(%ebp)
     c0b:	68 61 25 00 00       	push   $0x2561
     c10:	6a 01                	push   $0x1
     c12:	e8 35 fb ff ff       	call   74c <printf>
     c17:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c1a:	8b 45 08             	mov    0x8(%ebp),%eax
     c1d:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c20:	89 10                	mov    %edx,(%eax)
     c22:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c25:	89 50 04             	mov    %edx,0x4(%eax)
     c28:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c2b:	89 50 08             	mov    %edx,0x8(%eax)
     c2e:	e9 d2 01 00 00       	jmp    e05 <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c33:	83 ec 04             	sub    $0x4,%esp
     c36:	6a 0e                	push   $0xe
     c38:	8d 45 ba             	lea    -0x46(%ebp),%eax
     c3b:	50                   	push   %eax
     c3c:	ff 75 ec             	pushl  -0x14(%ebp)
     c3f:	e8 71 f9 ff ff       	call   5b5 <read>
     c44:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c47:	83 ec 04             	sub    $0x4,%esp
     c4a:	6a 28                	push   $0x28
     c4c:	8d 45 92             	lea    -0x6e(%ebp),%eax
     c4f:	50                   	push   %eax
     c50:	ff 75 ec             	pushl  -0x14(%ebp)
     c53:	e8 5d f9 ff ff       	call   5b5 <read>
     c58:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c5b:	8b 45 96             	mov    -0x6a(%ebp),%eax
     c5e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c61:	8b 45 9a             	mov    -0x66(%ebp),%eax
     c64:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     c67:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c6a:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c6d:	0f af d0             	imul   %eax,%edx
     c70:	89 d0                	mov    %edx,%eax
     c72:	01 c0                	add    %eax,%eax
     c74:	01 d0                	add    %edx,%eax
     c76:	83 ec 0c             	sub    $0xc,%esp
     c79:	50                   	push   %eax
     c7a:	e8 a0 fd ff ff       	call   a1f <malloc>
     c7f:	83 c4 10             	add    $0x10,%esp
     c82:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     c85:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     c89:	0f b7 c0             	movzwl %ax,%eax
     c8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     c8f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c92:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c95:	0f af c2             	imul   %edx,%eax
     c98:	83 c0 1f             	add    $0x1f,%eax
     c9b:	c1 e8 05             	shr    $0x5,%eax
     c9e:	c1 e0 02             	shl    $0x2,%eax
     ca1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     ca4:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ca7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     caa:	0f af c2             	imul   %edx,%eax
     cad:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     cb0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cb3:	83 ec 0c             	sub    $0xc,%esp
     cb6:	50                   	push   %eax
     cb7:	e8 63 fd ff ff       	call   a1f <malloc>
     cbc:	83 c4 10             	add    $0x10,%esp
     cbf:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     cc2:	83 ec 04             	sub    $0x4,%esp
     cc5:	ff 75 e0             	pushl  -0x20(%ebp)
     cc8:	ff 75 dc             	pushl  -0x24(%ebp)
     ccb:	ff 75 ec             	pushl  -0x14(%ebp)
     cce:	e8 e2 f8 ff ff       	call   5b5 <read>
     cd3:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     cd6:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
     cda:	66 c1 e8 03          	shr    $0x3,%ax
     cde:	0f b7 c0             	movzwl %ax,%eax
     ce1:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     ce4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ceb:	e9 e5 00 00 00       	jmp    dd5 <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     cf0:	8b 55 cc             	mov    -0x34(%ebp),%edx
     cf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf6:	29 c2                	sub    %eax,%edx
     cf8:	89 d0                	mov    %edx,%eax
     cfa:	8d 50 ff             	lea    -0x1(%eax),%edx
     cfd:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d00:	0f af c2             	imul   %edx,%eax
     d03:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d06:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d0d:	e9 b1 00 00 00       	jmp    dc3 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d12:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d15:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d18:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d1b:	01 c8                	add    %ecx,%eax
     d1d:	89 c1                	mov    %eax,%ecx
     d1f:	89 c8                	mov    %ecx,%eax
     d21:	01 c0                	add    %eax,%eax
     d23:	01 c8                	add    %ecx,%eax
     d25:	01 c2                	add    %eax,%edx
     d27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d2a:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d2e:	89 c1                	mov    %eax,%ecx
     d30:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d33:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d37:	01 c1                	add    %eax,%ecx
     d39:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d3c:	01 c8                	add    %ecx,%eax
     d3e:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d41:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d44:	01 c8                	add    %ecx,%eax
     d46:	0f b6 00             	movzbl (%eax),%eax
     d49:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d4c:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d4f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d52:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d55:	01 c8                	add    %ecx,%eax
     d57:	89 c1                	mov    %eax,%ecx
     d59:	89 c8                	mov    %ecx,%eax
     d5b:	01 c0                	add    %eax,%eax
     d5d:	01 c8                	add    %ecx,%eax
     d5f:	01 c2                	add    %eax,%edx
     d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d64:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d68:	89 c1                	mov    %eax,%ecx
     d6a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d6d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d71:	01 c1                	add    %eax,%ecx
     d73:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d76:	01 c8                	add    %ecx,%eax
     d78:	8d 48 fe             	lea    -0x2(%eax),%ecx
     d7b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d7e:	01 c8                	add    %ecx,%eax
     d80:	0f b6 00             	movzbl (%eax),%eax
     d83:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     d86:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d89:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d8f:	01 c8                	add    %ecx,%eax
     d91:	89 c1                	mov    %eax,%ecx
     d93:	89 c8                	mov    %ecx,%eax
     d95:	01 c0                	add    %eax,%eax
     d97:	01 c8                	add    %ecx,%eax
     d99:	01 c2                	add    %eax,%edx
     d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9e:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     da2:	89 c1                	mov    %eax,%ecx
     da4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     dab:	01 c1                	add    %eax,%ecx
     dad:	8b 45 d8             	mov    -0x28(%ebp),%eax
     db0:	01 c8                	add    %ecx,%eax
     db2:	8d 48 fd             	lea    -0x3(%eax),%ecx
     db5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     db8:	01 c8                	add    %ecx,%eax
     dba:	0f b6 00             	movzbl (%eax),%eax
     dbd:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     dbf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     dc3:	8b 55 c8             	mov    -0x38(%ebp),%edx
     dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dc9:	39 c2                	cmp    %eax,%edx
     dcb:	0f 87 41 ff ff ff    	ja     d12 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     dd1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dd5:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ddb:	39 c2                	cmp    %eax,%edx
     ddd:	0f 87 0d ff ff ff    	ja     cf0 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     de3:	83 ec 0c             	sub    $0xc,%esp
     de6:	ff 75 ec             	pushl  -0x14(%ebp)
     de9:	e8 d7 f7 ff ff       	call   5c5 <close>
     dee:	83 c4 10             	add    $0x10,%esp
    return bmp;
     df1:	8b 45 08             	mov    0x8(%ebp),%eax
     df4:	8b 55 c8             	mov    -0x38(%ebp),%edx
     df7:	89 10                	mov    %edx,(%eax)
     df9:	8b 55 cc             	mov    -0x34(%ebp),%edx
     dfc:	89 50 04             	mov    %edx,0x4(%eax)
     dff:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e02:	89 50 08             	mov    %edx,0x8(%eax)
}
     e05:	8b 45 08             	mov    0x8(%ebp),%eax
     e08:	c9                   	leave  
     e09:	c2 04 00             	ret    $0x4

00000e0c <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e0c:	55                   	push   %ebp
     e0d:	89 e5                	mov    %esp,%ebp
     e0f:	53                   	push   %ebx
     e10:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e13:	83 ec 0c             	sub    $0xc,%esp
     e16:	6a 1c                	push   $0x1c
     e18:	e8 02 fc ff ff       	call   a1f <malloc>
     e1d:	83 c4 10             	add    $0x10,%esp
     e20:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e23:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e26:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e2d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e30:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e33:	6a 0c                	push   $0xc
     e35:	6a 0c                	push   $0xc
     e37:	6a 0c                	push   $0xc
     e39:	50                   	push   %eax
     e3a:	e8 c3 fc ff ff       	call   b02 <RGB>
     e3f:	83 c4 0c             	add    $0xc,%esp
     e42:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e46:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e4a:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e4e:	88 43 15             	mov    %al,0x15(%ebx)
     e51:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e54:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e57:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e5b:	66 89 48 10          	mov    %cx,0x10(%eax)
     e5f:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     e63:	88 50 12             	mov    %dl,0x12(%eax)
     e66:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e69:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e6c:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     e70:	66 89 48 08          	mov    %cx,0x8(%eax)
     e74:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     e78:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     e7b:	8b 45 08             	mov    0x8(%ebp),%eax
     e7e:	89 c2                	mov    %eax,%edx
     e80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e83:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     e85:	8b 45 0c             	mov    0xc(%ebp),%eax
     e88:	89 c2                	mov    %eax,%edx
     e8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e8d:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     e90:	8b 55 10             	mov    0x10(%ebp),%edx
     e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e96:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
     e99:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e9c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e9f:	c9                   	leave  
     ea0:	c3                   	ret    

00000ea1 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     ea1:	55                   	push   %ebp
     ea2:	89 e5                	mov    %esp,%ebp
     ea4:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eaa:	8b 50 08             	mov    0x8(%eax),%edx
     ead:	89 55 f8             	mov    %edx,-0x8(%ebp)
     eb0:	8b 40 0c             	mov    0xc(%eax),%eax
     eb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb9:	8b 55 10             	mov    0x10(%ebp),%edx
     ebc:	89 50 08             	mov    %edx,0x8(%eax)
     ebf:	8b 55 14             	mov    0x14(%ebp),%edx
     ec2:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     ec5:	8b 45 08             	mov    0x8(%ebp),%eax
     ec8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ecb:	89 10                	mov    %edx,(%eax)
     ecd:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ed0:	89 50 04             	mov    %edx,0x4(%eax)
}
     ed3:	8b 45 08             	mov    0x8(%ebp),%eax
     ed6:	c9                   	leave  
     ed7:	c2 04 00             	ret    $0x4

00000eda <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     eda:	55                   	push   %ebp
     edb:	89 e5                	mov    %esp,%ebp
     edd:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     ee0:	8b 45 0c             	mov    0xc(%ebp),%eax
     ee3:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     ee7:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     eeb:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     eef:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     ef2:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef5:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     ef9:	66 89 50 10          	mov    %dx,0x10(%eax)
     efd:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f01:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f04:	8b 45 08             	mov    0x8(%ebp),%eax
     f07:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f0b:	66 89 10             	mov    %dx,(%eax)
     f0e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f12:	88 50 02             	mov    %dl,0x2(%eax)
}
     f15:	8b 45 08             	mov    0x8(%ebp),%eax
     f18:	c9                   	leave  
     f19:	c2 04 00             	ret    $0x4

00000f1c <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f1c:	55                   	push   %ebp
     f1d:	89 e5                	mov    %esp,%ebp
     f1f:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f22:	8b 45 08             	mov    0x8(%ebp),%eax
     f25:	8b 40 0c             	mov    0xc(%eax),%eax
     f28:	89 c2                	mov    %eax,%edx
     f2a:	c1 ea 1f             	shr    $0x1f,%edx
     f2d:	01 d0                	add    %edx,%eax
     f2f:	d1 f8                	sar    %eax
     f31:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f34:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f37:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f3e:	8b 45 10             	mov    0x10(%ebp),%eax
     f41:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f44:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f47:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f4b:	0f 89 98 00 00 00    	jns    fe9 <APDrawPoint+0xcd>
        i = 0;
     f51:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f58:	e9 8c 00 00 00       	jmp    fe9 <APDrawPoint+0xcd>
    {
        j = x - off;
     f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f60:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f63:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     f66:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     f6a:	79 69                	jns    fd5 <APDrawPoint+0xb9>
            j = 0;
     f6c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     f73:	eb 60                	jmp    fd5 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     f75:	ff 75 fc             	pushl  -0x4(%ebp)
     f78:	ff 75 f8             	pushl  -0x8(%ebp)
     f7b:	ff 75 08             	pushl  0x8(%ebp)
     f7e:	e8 fd fb ff ff       	call   b80 <APGetIndex>
     f83:	83 c4 0c             	add    $0xc,%esp
     f86:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     f89:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     f8d:	74 55                	je     fe4 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     f8f:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     f93:	74 67                	je     ffc <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     f95:	ff 75 10             	pushl  0x10(%ebp)
     f98:	ff 75 0c             	pushl  0xc(%ebp)
     f9b:	ff 75 fc             	pushl  -0x4(%ebp)
     f9e:	ff 75 f8             	pushl  -0x8(%ebp)
     fa1:	e8 a1 fb ff ff       	call   b47 <distance_2>
     fa6:	83 c4 10             	add    $0x10,%esp
     fa9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fac:	7f 23                	jg     fd1 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     fae:	8b 45 08             	mov    0x8(%ebp),%eax
     fb1:	8b 48 18             	mov    0x18(%eax),%ecx
     fb4:	8b 55 ec             	mov    -0x14(%ebp),%edx
     fb7:	89 d0                	mov    %edx,%eax
     fb9:	01 c0                	add    %eax,%eax
     fbb:	01 d0                	add    %edx,%eax
     fbd:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     fc0:	8b 45 08             	mov    0x8(%ebp),%eax
     fc3:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
     fc7:	66 89 0a             	mov    %cx,(%edx)
     fca:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
     fce:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
     fd1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     fd5:	8b 55 0c             	mov    0xc(%ebp),%edx
     fd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fdb:	01 d0                	add    %edx,%eax
     fdd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     fe0:	7d 93                	jge    f75 <APDrawPoint+0x59>
     fe2:	eb 01                	jmp    fe5 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
     fe4:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
     fe5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     fe9:	8b 55 10             	mov    0x10(%ebp),%edx
     fec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fef:	01 d0                	add    %edx,%eax
     ff1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     ff4:	0f 8d 63 ff ff ff    	jge    f5d <APDrawPoint+0x41>
     ffa:	eb 01                	jmp    ffd <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
     ffc:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
     ffd:	c9                   	leave  
     ffe:	c3                   	ret    

00000fff <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
     fff:	55                   	push   %ebp
    1000:	89 e5                	mov    %esp,%ebp
    1002:	53                   	push   %ebx
    1003:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1006:	8b 45 0c             	mov    0xc(%ebp),%eax
    1009:	3b 45 14             	cmp    0x14(%ebp),%eax
    100c:	0f 85 80 00 00 00    	jne    1092 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1012:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1016:	0f 88 9d 02 00 00    	js     12b9 <APDrawLine+0x2ba>
    101c:	8b 45 08             	mov    0x8(%ebp),%eax
    101f:	8b 00                	mov    (%eax),%eax
    1021:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1024:	0f 8e 8f 02 00 00    	jle    12b9 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    102a:	8b 45 10             	mov    0x10(%ebp),%eax
    102d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1030:	7e 12                	jle    1044 <APDrawLine+0x45>
        {
            int tmp = y2;
    1032:	8b 45 18             	mov    0x18(%ebp),%eax
    1035:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1038:	8b 45 10             	mov    0x10(%ebp),%eax
    103b:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    103e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1041:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1044:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1048:	79 07                	jns    1051 <APDrawLine+0x52>
    104a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1051:	8b 45 08             	mov    0x8(%ebp),%eax
    1054:	8b 40 04             	mov    0x4(%eax),%eax
    1057:	3b 45 18             	cmp    0x18(%ebp),%eax
    105a:	7d 0c                	jge    1068 <APDrawLine+0x69>
    105c:	8b 45 08             	mov    0x8(%ebp),%eax
    105f:	8b 40 04             	mov    0x4(%eax),%eax
    1062:	83 e8 01             	sub    $0x1,%eax
    1065:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    1068:	8b 45 10             	mov    0x10(%ebp),%eax
    106b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    106e:	eb 15                	jmp    1085 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    1070:	ff 75 f4             	pushl  -0xc(%ebp)
    1073:	ff 75 0c             	pushl  0xc(%ebp)
    1076:	ff 75 08             	pushl  0x8(%ebp)
    1079:	e8 9e fe ff ff       	call   f1c <APDrawPoint>
    107e:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    1081:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1085:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1088:	3b 45 18             	cmp    0x18(%ebp),%eax
    108b:	7e e3                	jle    1070 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    108d:	e9 2b 02 00 00       	jmp    12bd <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    1092:	8b 45 10             	mov    0x10(%ebp),%eax
    1095:	3b 45 18             	cmp    0x18(%ebp),%eax
    1098:	75 7f                	jne    1119 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    109a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    109e:	0f 88 18 02 00 00    	js     12bc <APDrawLine+0x2bd>
    10a4:	8b 45 08             	mov    0x8(%ebp),%eax
    10a7:	8b 40 04             	mov    0x4(%eax),%eax
    10aa:	3b 45 10             	cmp    0x10(%ebp),%eax
    10ad:	0f 8e 09 02 00 00    	jle    12bc <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b6:	3b 45 14             	cmp    0x14(%ebp),%eax
    10b9:	7e 12                	jle    10cd <APDrawLine+0xce>
        {
            int tmp = x2;
    10bb:	8b 45 14             	mov    0x14(%ebp),%eax
    10be:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    10c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10c4:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    10c7:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10ca:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    10cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10d1:	79 07                	jns    10da <APDrawLine+0xdb>
    10d3:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    10da:	8b 45 08             	mov    0x8(%ebp),%eax
    10dd:	8b 00                	mov    (%eax),%eax
    10df:	3b 45 14             	cmp    0x14(%ebp),%eax
    10e2:	7d 0b                	jge    10ef <APDrawLine+0xf0>
    10e4:	8b 45 08             	mov    0x8(%ebp),%eax
    10e7:	8b 00                	mov    (%eax),%eax
    10e9:	83 e8 01             	sub    $0x1,%eax
    10ec:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    10ef:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    10f5:	eb 15                	jmp    110c <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    10f7:	ff 75 10             	pushl  0x10(%ebp)
    10fa:	ff 75 f0             	pushl  -0x10(%ebp)
    10fd:	ff 75 08             	pushl  0x8(%ebp)
    1100:	e8 17 fe ff ff       	call   f1c <APDrawPoint>
    1105:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1108:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    110c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    110f:	3b 45 14             	cmp    0x14(%ebp),%eax
    1112:	7e e3                	jle    10f7 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1114:	e9 a4 01 00 00       	jmp    12bd <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1119:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1120:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1127:	8b 45 0c             	mov    0xc(%ebp),%eax
    112a:	2b 45 14             	sub    0x14(%ebp),%eax
    112d:	50                   	push   %eax
    112e:	e8 3d fa ff ff       	call   b70 <abs_int>
    1133:	83 c4 04             	add    $0x4,%esp
    1136:	89 c3                	mov    %eax,%ebx
    1138:	8b 45 10             	mov    0x10(%ebp),%eax
    113b:	2b 45 18             	sub    0x18(%ebp),%eax
    113e:	50                   	push   %eax
    113f:	e8 2c fa ff ff       	call   b70 <abs_int>
    1144:	83 c4 04             	add    $0x4,%esp
    1147:	39 c3                	cmp    %eax,%ebx
    1149:	0f 8e b5 00 00 00    	jle    1204 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    114f:	8b 45 10             	mov    0x10(%ebp),%eax
    1152:	2b 45 18             	sub    0x18(%ebp),%eax
    1155:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1158:	db 45 b0             	fildl  -0x50(%ebp)
    115b:	8b 45 0c             	mov    0xc(%ebp),%eax
    115e:	2b 45 14             	sub    0x14(%ebp),%eax
    1161:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1164:	db 45 b0             	fildl  -0x50(%ebp)
    1167:	de f9                	fdivrp %st,%st(1)
    1169:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    116c:	8b 45 14             	mov    0x14(%ebp),%eax
    116f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1172:	7e 0e                	jle    1182 <APDrawLine+0x183>
        {
            s = x1;
    1174:	8b 45 0c             	mov    0xc(%ebp),%eax
    1177:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    117a:	8b 45 14             	mov    0x14(%ebp),%eax
    117d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1180:	eb 0c                	jmp    118e <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    1182:	8b 45 14             	mov    0x14(%ebp),%eax
    1185:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    1188:	8b 45 0c             	mov    0xc(%ebp),%eax
    118b:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    118e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1192:	79 07                	jns    119b <APDrawLine+0x19c>
    1194:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    119b:	8b 45 08             	mov    0x8(%ebp),%eax
    119e:	8b 00                	mov    (%eax),%eax
    11a0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11a3:	7f 0b                	jg     11b0 <APDrawLine+0x1b1>
    11a5:	8b 45 08             	mov    0x8(%ebp),%eax
    11a8:	8b 00                	mov    (%eax),%eax
    11aa:	83 e8 01             	sub    $0x1,%eax
    11ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11b6:	eb 3f                	jmp    11f7 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11bb:	2b 45 0c             	sub    0xc(%ebp),%eax
    11be:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11c1:	db 45 b0             	fildl  -0x50(%ebp)
    11c4:	dc 4d d0             	fmull  -0x30(%ebp)
    11c7:	db 45 10             	fildl  0x10(%ebp)
    11ca:	de c1                	faddp  %st,%st(1)
    11cc:	d9 7d b6             	fnstcw -0x4a(%ebp)
    11cf:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    11d3:	b4 0c                	mov    $0xc,%ah
    11d5:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    11d9:	d9 6d b4             	fldcw  -0x4c(%ebp)
    11dc:	db 5d cc             	fistpl -0x34(%ebp)
    11df:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    11e2:	ff 75 cc             	pushl  -0x34(%ebp)
    11e5:	ff 75 e4             	pushl  -0x1c(%ebp)
    11e8:	ff 75 08             	pushl  0x8(%ebp)
    11eb:	e8 2c fd ff ff       	call   f1c <APDrawPoint>
    11f0:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    11f3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    11f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11fa:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11fd:	7e b9                	jle    11b8 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    11ff:	e9 b9 00 00 00       	jmp    12bd <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1204:	8b 45 0c             	mov    0xc(%ebp),%eax
    1207:	2b 45 14             	sub    0x14(%ebp),%eax
    120a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    120d:	db 45 b0             	fildl  -0x50(%ebp)
    1210:	8b 45 10             	mov    0x10(%ebp),%eax
    1213:	2b 45 18             	sub    0x18(%ebp),%eax
    1216:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1219:	db 45 b0             	fildl  -0x50(%ebp)
    121c:	de f9                	fdivrp %st,%st(1)
    121e:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1221:	8b 45 10             	mov    0x10(%ebp),%eax
    1224:	3b 45 18             	cmp    0x18(%ebp),%eax
    1227:	7e 0e                	jle    1237 <APDrawLine+0x238>
    {
        s = y2;
    1229:	8b 45 18             	mov    0x18(%ebp),%eax
    122c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    122f:	8b 45 10             	mov    0x10(%ebp),%eax
    1232:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1235:	eb 0c                	jmp    1243 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1237:	8b 45 10             	mov    0x10(%ebp),%eax
    123a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    123d:	8b 45 18             	mov    0x18(%ebp),%eax
    1240:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1243:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1247:	79 07                	jns    1250 <APDrawLine+0x251>
    1249:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1250:	8b 45 08             	mov    0x8(%ebp),%eax
    1253:	8b 40 04             	mov    0x4(%eax),%eax
    1256:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1259:	7f 0c                	jg     1267 <APDrawLine+0x268>
    125b:	8b 45 08             	mov    0x8(%ebp),%eax
    125e:	8b 40 04             	mov    0x4(%eax),%eax
    1261:	83 e8 01             	sub    $0x1,%eax
    1264:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    1267:	8b 45 ec             	mov    -0x14(%ebp),%eax
    126a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    126d:	eb 3f                	jmp    12ae <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    126f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1272:	2b 45 10             	sub    0x10(%ebp),%eax
    1275:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1278:	db 45 b0             	fildl  -0x50(%ebp)
    127b:	dc 4d c0             	fmull  -0x40(%ebp)
    127e:	db 45 0c             	fildl  0xc(%ebp)
    1281:	de c1                	faddp  %st,%st(1)
    1283:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1286:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    128a:	b4 0c                	mov    $0xc,%ah
    128c:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1290:	d9 6d b4             	fldcw  -0x4c(%ebp)
    1293:	db 5d bc             	fistpl -0x44(%ebp)
    1296:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    1299:	ff 75 e0             	pushl  -0x20(%ebp)
    129c:	ff 75 bc             	pushl  -0x44(%ebp)
    129f:	ff 75 08             	pushl  0x8(%ebp)
    12a2:	e8 75 fc ff ff       	call   f1c <APDrawPoint>
    12a7:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12aa:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12b1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12b4:	7e b9                	jle    126f <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12b6:	90                   	nop
    12b7:	eb 04                	jmp    12bd <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12b9:	90                   	nop
    12ba:	eb 01                	jmp    12bd <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12bc:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    12c0:	c9                   	leave  
    12c1:	c3                   	ret    

000012c2 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    12c2:	55                   	push   %ebp
    12c3:	89 e5                	mov    %esp,%ebp
    12c5:	53                   	push   %ebx
    12c6:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    12c9:	8b 55 10             	mov    0x10(%ebp),%edx
    12cc:	8b 45 18             	mov    0x18(%ebp),%eax
    12cf:	01 d0                	add    %edx,%eax
    12d1:	83 e8 01             	sub    $0x1,%eax
    12d4:	83 ec 04             	sub    $0x4,%esp
    12d7:	50                   	push   %eax
    12d8:	ff 75 0c             	pushl  0xc(%ebp)
    12db:	ff 75 10             	pushl  0x10(%ebp)
    12de:	ff 75 0c             	pushl  0xc(%ebp)
    12e1:	ff 75 08             	pushl  0x8(%ebp)
    12e4:	e8 16 fd ff ff       	call   fff <APDrawLine>
    12e9:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    12ec:	8b 55 0c             	mov    0xc(%ebp),%edx
    12ef:	8b 45 14             	mov    0x14(%ebp),%eax
    12f2:	01 d0                	add    %edx,%eax
    12f4:	83 e8 01             	sub    $0x1,%eax
    12f7:	83 ec 04             	sub    $0x4,%esp
    12fa:	ff 75 10             	pushl  0x10(%ebp)
    12fd:	50                   	push   %eax
    12fe:	ff 75 10             	pushl  0x10(%ebp)
    1301:	ff 75 0c             	pushl  0xc(%ebp)
    1304:	ff 75 08             	pushl  0x8(%ebp)
    1307:	e8 f3 fc ff ff       	call   fff <APDrawLine>
    130c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    130f:	8b 55 10             	mov    0x10(%ebp),%edx
    1312:	8b 45 18             	mov    0x18(%ebp),%eax
    1315:	01 d0                	add    %edx,%eax
    1317:	8d 48 ff             	lea    -0x1(%eax),%ecx
    131a:	8b 55 0c             	mov    0xc(%ebp),%edx
    131d:	8b 45 14             	mov    0x14(%ebp),%eax
    1320:	01 d0                	add    %edx,%eax
    1322:	8d 50 ff             	lea    -0x1(%eax),%edx
    1325:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1328:	8b 45 14             	mov    0x14(%ebp),%eax
    132b:	01 d8                	add    %ebx,%eax
    132d:	83 e8 01             	sub    $0x1,%eax
    1330:	83 ec 04             	sub    $0x4,%esp
    1333:	51                   	push   %ecx
    1334:	52                   	push   %edx
    1335:	ff 75 10             	pushl  0x10(%ebp)
    1338:	50                   	push   %eax
    1339:	ff 75 08             	pushl  0x8(%ebp)
    133c:	e8 be fc ff ff       	call   fff <APDrawLine>
    1341:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1344:	8b 55 10             	mov    0x10(%ebp),%edx
    1347:	8b 45 18             	mov    0x18(%ebp),%eax
    134a:	01 d0                	add    %edx,%eax
    134c:	8d 48 ff             	lea    -0x1(%eax),%ecx
    134f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1352:	8b 45 14             	mov    0x14(%ebp),%eax
    1355:	01 d0                	add    %edx,%eax
    1357:	8d 50 ff             	lea    -0x1(%eax),%edx
    135a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    135d:	8b 45 18             	mov    0x18(%ebp),%eax
    1360:	01 d8                	add    %ebx,%eax
    1362:	83 e8 01             	sub    $0x1,%eax
    1365:	83 ec 04             	sub    $0x4,%esp
    1368:	51                   	push   %ecx
    1369:	52                   	push   %edx
    136a:	50                   	push   %eax
    136b:	ff 75 0c             	pushl  0xc(%ebp)
    136e:	ff 75 08             	pushl  0x8(%ebp)
    1371:	e8 89 fc ff ff       	call   fff <APDrawLine>
    1376:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    1379:	8b 55 0c             	mov    0xc(%ebp),%edx
    137c:	8b 45 14             	mov    0x14(%ebp),%eax
    137f:	01 d0                	add    %edx,%eax
    1381:	8d 50 ff             	lea    -0x1(%eax),%edx
    1384:	8b 45 08             	mov    0x8(%ebp),%eax
    1387:	8b 40 0c             	mov    0xc(%eax),%eax
    138a:	89 c1                	mov    %eax,%ecx
    138c:	c1 e9 1f             	shr    $0x1f,%ecx
    138f:	01 c8                	add    %ecx,%eax
    1391:	d1 f8                	sar    %eax
    1393:	29 c2                	sub    %eax,%edx
    1395:	89 d0                	mov    %edx,%eax
    1397:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    139a:	8b 55 10             	mov    0x10(%ebp),%edx
    139d:	8b 45 18             	mov    0x18(%ebp),%eax
    13a0:	01 d0                	add    %edx,%eax
    13a2:	8d 50 ff             	lea    -0x1(%eax),%edx
    13a5:	8b 45 08             	mov    0x8(%ebp),%eax
    13a8:	8b 40 0c             	mov    0xc(%eax),%eax
    13ab:	89 c1                	mov    %eax,%ecx
    13ad:	c1 e9 1f             	shr    $0x1f,%ecx
    13b0:	01 c8                	add    %ecx,%eax
    13b2:	d1 f8                	sar    %eax
    13b4:	29 c2                	sub    %eax,%edx
    13b6:	89 d0                	mov    %edx,%eax
    13b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13bb:	8b 45 08             	mov    0x8(%ebp),%eax
    13be:	8b 40 0c             	mov    0xc(%eax),%eax
    13c1:	89 c2                	mov    %eax,%edx
    13c3:	c1 ea 1f             	shr    $0x1f,%edx
    13c6:	01 d0                	add    %edx,%eax
    13c8:	d1 f8                	sar    %eax
    13ca:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    13cd:	8b 45 08             	mov    0x8(%ebp),%eax
    13d0:	8b 40 0c             	mov    0xc(%eax),%eax
    13d3:	89 c2                	mov    %eax,%edx
    13d5:	c1 ea 1f             	shr    $0x1f,%edx
    13d8:	01 d0                	add    %edx,%eax
    13da:	d1 f8                	sar    %eax
    13dc:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    13df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13e3:	0f 88 d8 00 00 00    	js     14c1 <APDrawRect+0x1ff>
    13e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13ed:	0f 88 ce 00 00 00    	js     14c1 <APDrawRect+0x1ff>
    13f3:	8b 45 08             	mov    0x8(%ebp),%eax
    13f6:	8b 00                	mov    (%eax),%eax
    13f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
    13fb:	0f 8e c0 00 00 00    	jle    14c1 <APDrawRect+0x1ff>
    1401:	8b 45 08             	mov    0x8(%ebp),%eax
    1404:	8b 40 04             	mov    0x4(%eax),%eax
    1407:	3b 45 10             	cmp    0x10(%ebp),%eax
    140a:	0f 8e b1 00 00 00    	jle    14c1 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1410:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1414:	79 07                	jns    141d <APDrawRect+0x15b>
    1416:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    141d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1421:	79 07                	jns    142a <APDrawRect+0x168>
    1423:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    142a:	8b 45 08             	mov    0x8(%ebp),%eax
    142d:	8b 00                	mov    (%eax),%eax
    142f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1432:	7f 0b                	jg     143f <APDrawRect+0x17d>
    1434:	8b 45 08             	mov    0x8(%ebp),%eax
    1437:	8b 00                	mov    (%eax),%eax
    1439:	83 e8 01             	sub    $0x1,%eax
    143c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    143f:	8b 45 08             	mov    0x8(%ebp),%eax
    1442:	8b 40 04             	mov    0x4(%eax),%eax
    1445:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1448:	7f 0c                	jg     1456 <APDrawRect+0x194>
    144a:	8b 45 08             	mov    0x8(%ebp),%eax
    144d:	8b 40 04             	mov    0x4(%eax),%eax
    1450:	83 e8 01             	sub    $0x1,%eax
    1453:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1456:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    145d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1460:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1463:	eb 52                	jmp    14b7 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    1465:	8b 45 10             	mov    0x10(%ebp),%eax
    1468:	89 45 e8             	mov    %eax,-0x18(%ebp)
    146b:	eb 3e                	jmp    14ab <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    146d:	83 ec 04             	sub    $0x4,%esp
    1470:	ff 75 e8             	pushl  -0x18(%ebp)
    1473:	ff 75 ec             	pushl  -0x14(%ebp)
    1476:	ff 75 08             	pushl  0x8(%ebp)
    1479:	e8 02 f7 ff ff       	call   b80 <APGetIndex>
    147e:	83 c4 10             	add    $0x10,%esp
    1481:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    1484:	8b 45 08             	mov    0x8(%ebp),%eax
    1487:	8b 48 18             	mov    0x18(%eax),%ecx
    148a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    148d:	89 d0                	mov    %edx,%eax
    148f:	01 c0                	add    %eax,%eax
    1491:	01 d0                	add    %edx,%eax
    1493:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1496:	8b 45 08             	mov    0x8(%ebp),%eax
    1499:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    149d:	66 89 0a             	mov    %cx,(%edx)
    14a0:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14a4:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14a7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14ae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14b1:	7e ba                	jle    146d <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14b3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14ba:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14bd:	7e a6                	jle    1465 <APDrawRect+0x1a3>
    14bf:	eb 01                	jmp    14c2 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    14c1:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    14c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14c5:	c9                   	leave  
    14c6:	c3                   	ret    

000014c7 <APDrawText>:

void APDrawText(AHdc hdc, char * str, int x, int y)
{
    14c7:	55                   	push   %ebp
    14c8:	89 e5                	mov    %esp,%ebp
}
    14ca:	90                   	nop
    14cb:	5d                   	pop    %ebp
    14cc:	c3                   	ret    

000014cd <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    14cd:	55                   	push   %ebp
    14ce:	89 e5                	mov    %esp,%ebp
    14d0:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    14d3:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    14d7:	0f 88 8e 01 00 00    	js     166b <APDcCopy+0x19e>
    14dd:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    14e1:	0f 88 84 01 00 00    	js     166b <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    14e7:	8b 55 0c             	mov    0xc(%ebp),%edx
    14ea:	8b 45 20             	mov    0x20(%ebp),%eax
    14ed:	01 d0                	add    %edx,%eax
    14ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14f2:	8b 55 10             	mov    0x10(%ebp),%edx
    14f5:	8b 45 24             	mov    0x24(%ebp),%eax
    14f8:	01 d0                	add    %edx,%eax
    14fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    14fd:	8b 55 18             	mov    0x18(%ebp),%edx
    1500:	8b 45 20             	mov    0x20(%ebp),%eax
    1503:	01 d0                	add    %edx,%eax
    1505:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1508:	8b 55 1c             	mov    0x1c(%ebp),%edx
    150b:	8b 45 24             	mov    0x24(%ebp),%eax
    150e:	01 d0                	add    %edx,%eax
    1510:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1513:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1517:	0f 88 51 01 00 00    	js     166e <APDcCopy+0x1a1>
    151d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1521:	0f 88 47 01 00 00    	js     166e <APDcCopy+0x1a1>
    1527:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    152b:	0f 88 3d 01 00 00    	js     166e <APDcCopy+0x1a1>
    1531:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1535:	0f 88 33 01 00 00    	js     166e <APDcCopy+0x1a1>
    153b:	8b 45 14             	mov    0x14(%ebp),%eax
    153e:	8b 00                	mov    (%eax),%eax
    1540:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1543:	0f 8c 25 01 00 00    	jl     166e <APDcCopy+0x1a1>
    1549:	8b 45 14             	mov    0x14(%ebp),%eax
    154c:	8b 40 04             	mov    0x4(%eax),%eax
    154f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1552:	0f 8c 16 01 00 00    	jl     166e <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    1558:	8b 45 08             	mov    0x8(%ebp),%eax
    155b:	8b 00                	mov    (%eax),%eax
    155d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1560:	7f 0b                	jg     156d <APDcCopy+0xa0>
    1562:	8b 45 08             	mov    0x8(%ebp),%eax
    1565:	8b 00                	mov    (%eax),%eax
    1567:	83 e8 01             	sub    $0x1,%eax
    156a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    156d:	8b 45 08             	mov    0x8(%ebp),%eax
    1570:	8b 40 04             	mov    0x4(%eax),%eax
    1573:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1576:	7f 0c                	jg     1584 <APDcCopy+0xb7>
    1578:	8b 45 08             	mov    0x8(%ebp),%eax
    157b:	8b 40 04             	mov    0x4(%eax),%eax
    157e:	83 e8 01             	sub    $0x1,%eax
    1581:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    1584:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    158b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    1592:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1599:	e9 bc 00 00 00       	jmp    165a <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    159e:	8b 45 08             	mov    0x8(%ebp),%eax
    15a1:	8b 00                	mov    (%eax),%eax
    15a3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15a6:	8b 55 10             	mov    0x10(%ebp),%edx
    15a9:	01 ca                	add    %ecx,%edx
    15ab:	0f af d0             	imul   %eax,%edx
    15ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    15b1:	01 d0                	add    %edx,%eax
    15b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    15b6:	8b 45 14             	mov    0x14(%ebp),%eax
    15b9:	8b 00                	mov    (%eax),%eax
    15bb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15be:	8b 55 1c             	mov    0x1c(%ebp),%edx
    15c1:	01 ca                	add    %ecx,%edx
    15c3:	0f af d0             	imul   %eax,%edx
    15c6:	8b 45 18             	mov    0x18(%ebp),%eax
    15c9:	01 d0                	add    %edx,%eax
    15cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    15ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15d5:	eb 74                	jmp    164b <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    15d7:	8b 45 14             	mov    0x14(%ebp),%eax
    15da:	8b 50 18             	mov    0x18(%eax),%edx
    15dd:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    15e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e3:	01 c8                	add    %ecx,%eax
    15e5:	89 c1                	mov    %eax,%ecx
    15e7:	89 c8                	mov    %ecx,%eax
    15e9:	01 c0                	add    %eax,%eax
    15eb:	01 c8                	add    %ecx,%eax
    15ed:	01 d0                	add    %edx,%eax
    15ef:	0f b7 10             	movzwl (%eax),%edx
    15f2:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    15f6:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    15fa:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    15fd:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1601:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1605:	38 c2                	cmp    %al,%dl
    1607:	75 18                	jne    1621 <APDcCopy+0x154>
    1609:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    160d:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1611:	38 c2                	cmp    %al,%dl
    1613:	75 0c                	jne    1621 <APDcCopy+0x154>
    1615:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1619:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    161d:	38 c2                	cmp    %al,%dl
    161f:	74 26                	je     1647 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1621:	8b 45 08             	mov    0x8(%ebp),%eax
    1624:	8b 50 18             	mov    0x18(%eax),%edx
    1627:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    162a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    162d:	01 c8                	add    %ecx,%eax
    162f:	89 c1                	mov    %eax,%ecx
    1631:	89 c8                	mov    %ecx,%eax
    1633:	01 c0                	add    %eax,%eax
    1635:	01 c8                	add    %ecx,%eax
    1637:	01 d0                	add    %edx,%eax
    1639:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    163d:	66 89 10             	mov    %dx,(%eax)
    1640:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1644:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    1647:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    164b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    164e:	2b 45 0c             	sub    0xc(%ebp),%eax
    1651:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1654:	7d 81                	jge    15d7 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1656:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    165a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    165d:	2b 45 10             	sub    0x10(%ebp),%eax
    1660:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1663:	0f 8d 35 ff ff ff    	jge    159e <APDcCopy+0xd1>
    1669:	eb 04                	jmp    166f <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    166b:	90                   	nop
    166c:	eb 01                	jmp    166f <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    166e:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    166f:	c9                   	leave  
    1670:	c3                   	ret    

00001671 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    1671:	55                   	push   %ebp
    1672:	89 e5                	mov    %esp,%ebp
    1674:	83 ec 1c             	sub    $0x1c,%esp
    1677:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    167a:	8b 55 10             	mov    0x10(%ebp),%edx
    167d:	8b 45 14             	mov    0x14(%ebp),%eax
    1680:	88 4d ec             	mov    %cl,-0x14(%ebp)
    1683:	88 55 e8             	mov    %dl,-0x18(%ebp)
    1686:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    1689:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    168d:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    1690:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    1694:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    1697:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    169b:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    169e:	8b 45 08             	mov    0x8(%ebp),%eax
    16a1:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    16a5:	66 89 10             	mov    %dx,(%eax)
    16a8:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    16ac:	88 50 02             	mov    %dl,0x2(%eax)
}
    16af:	8b 45 08             	mov    0x8(%ebp),%eax
    16b2:	c9                   	leave  
    16b3:	c2 04 00             	ret    $0x4

000016b6 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    16b6:	55                   	push   %ebp
    16b7:	89 e5                	mov    %esp,%ebp
    16b9:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    16bc:	8b 45 08             	mov    0x8(%ebp),%eax
    16bf:	8b 00                	mov    (%eax),%eax
    16c1:	83 ec 08             	sub    $0x8,%esp
    16c4:	8d 55 0c             	lea    0xc(%ebp),%edx
    16c7:	52                   	push   %edx
    16c8:	50                   	push   %eax
    16c9:	e8 77 ef ff ff       	call   645 <sendMessage>
    16ce:	83 c4 10             	add    $0x10,%esp
}
    16d1:	90                   	nop
    16d2:	c9                   	leave  
    16d3:	c3                   	ret    

000016d4 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    16d4:	55                   	push   %ebp
    16d5:	89 e5                	mov    %esp,%ebp
    16d7:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    16da:	83 ec 0c             	sub    $0xc,%esp
    16dd:	68 98 00 00 00       	push   $0x98
    16e2:	e8 38 f3 ff ff       	call   a1f <malloc>
    16e7:	83 c4 10             	add    $0x10,%esp
    16ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    16ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16f1:	75 15                	jne    1708 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    16f3:	83 ec 04             	sub    $0x4,%esp
    16f6:	ff 75 08             	pushl  0x8(%ebp)
    16f9:	68 74 25 00 00       	push   $0x2574
    16fe:	6a 01                	push   $0x1
    1700:	e8 47 f0 ff ff       	call   74c <printf>
    1705:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1708:	8b 45 f4             	mov    -0xc(%ebp),%eax
    170b:	05 84 00 00 00       	add    $0x84,%eax
    1710:	83 ec 08             	sub    $0x8,%esp
    1713:	ff 75 08             	pushl  0x8(%ebp)
    1716:	50                   	push   %eax
    1717:	e8 50 ec ff ff       	call   36c <strcpy>
    171c:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    171f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1722:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1729:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172c:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1733:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1736:	8b 40 3c             	mov    0x3c(%eax),%eax
    1739:	89 c2                	mov    %eax,%edx
    173b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    173e:	8b 40 40             	mov    0x40(%eax),%eax
    1741:	0f af d0             	imul   %eax,%edx
    1744:	89 d0                	mov    %edx,%eax
    1746:	01 c0                	add    %eax,%eax
    1748:	01 d0                	add    %edx,%eax
    174a:	83 ec 0c             	sub    $0xc,%esp
    174d:	50                   	push   %eax
    174e:	e8 cc f2 ff ff       	call   a1f <malloc>
    1753:	83 c4 10             	add    $0x10,%esp
    1756:	89 c2                	mov    %eax,%edx
    1758:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175b:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    175e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1761:	8b 40 54             	mov    0x54(%eax),%eax
    1764:	85 c0                	test   %eax,%eax
    1766:	75 15                	jne    177d <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    1768:	83 ec 04             	sub    $0x4,%esp
    176b:	ff 75 08             	pushl  0x8(%ebp)
    176e:	68 94 25 00 00       	push   $0x2594
    1773:	6a 01                	push   $0x1
    1775:	e8 d2 ef ff ff       	call   74c <printf>
    177a:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    177d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1780:	8b 40 3c             	mov    0x3c(%eax),%eax
    1783:	89 c2                	mov    %eax,%edx
    1785:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1788:	8b 40 40             	mov    0x40(%eax),%eax
    178b:	0f af d0             	imul   %eax,%edx
    178e:	89 d0                	mov    %edx,%eax
    1790:	01 c0                	add    %eax,%eax
    1792:	01 c2                	add    %eax,%edx
    1794:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1797:	8b 40 54             	mov    0x54(%eax),%eax
    179a:	83 ec 04             	sub    $0x4,%esp
    179d:	52                   	push   %edx
    179e:	68 ff ff ff 00       	push   $0xffffff
    17a3:	50                   	push   %eax
    17a4:	e8 59 ec ff ff       	call   402 <memset>
    17a9:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    17ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17af:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    17b6:	e8 62 ee ff ff       	call   61d <getpid>
    17bb:	89 c2                	mov    %eax,%edx
    17bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c0:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    17c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c6:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    17cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d0:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    17d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17da:	8b 40 58             	mov    0x58(%eax),%eax
    17dd:	89 c2                	mov    %eax,%edx
    17df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e2:	8b 40 5c             	mov    0x5c(%eax),%eax
    17e5:	0f af d0             	imul   %eax,%edx
    17e8:	89 d0                	mov    %edx,%eax
    17ea:	01 c0                	add    %eax,%eax
    17ec:	01 d0                	add    %edx,%eax
    17ee:	83 ec 0c             	sub    $0xc,%esp
    17f1:	50                   	push   %eax
    17f2:	e8 28 f2 ff ff       	call   a1f <malloc>
    17f7:	83 c4 10             	add    $0x10,%esp
    17fa:	89 c2                	mov    %eax,%edx
    17fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ff:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1802:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1805:	8b 40 70             	mov    0x70(%eax),%eax
    1808:	85 c0                	test   %eax,%eax
    180a:	75 15                	jne    1821 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    180c:	83 ec 04             	sub    $0x4,%esp
    180f:	ff 75 08             	pushl  0x8(%ebp)
    1812:	68 b8 25 00 00       	push   $0x25b8
    1817:	6a 01                	push   $0x1
    1819:	e8 2e ef ff ff       	call   74c <printf>
    181e:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1821:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1824:	8b 40 3c             	mov    0x3c(%eax),%eax
    1827:	89 c2                	mov    %eax,%edx
    1829:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182c:	8b 40 40             	mov    0x40(%eax),%eax
    182f:	0f af d0             	imul   %eax,%edx
    1832:	89 d0                	mov    %edx,%eax
    1834:	01 c0                	add    %eax,%eax
    1836:	01 c2                	add    %eax,%edx
    1838:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183b:	8b 40 54             	mov    0x54(%eax),%eax
    183e:	83 ec 04             	sub    $0x4,%esp
    1841:	52                   	push   %edx
    1842:	68 ff 00 00 00       	push   $0xff
    1847:	50                   	push   %eax
    1848:	e8 b5 eb ff ff       	call   402 <memset>
    184d:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1850:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1853:	8b 55 0c             	mov    0xc(%ebp),%edx
    1856:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1859:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    185d:	74 49                	je     18a8 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    185f:	8b 45 10             	mov    0x10(%ebp),%eax
    1862:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    1868:	83 ec 0c             	sub    $0xc,%esp
    186b:	50                   	push   %eax
    186c:	e8 ae f1 ff ff       	call   a1f <malloc>
    1871:	83 c4 10             	add    $0x10,%esp
    1874:	89 c2                	mov    %eax,%edx
    1876:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1879:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    187f:	8b 55 10             	mov    0x10(%ebp),%edx
    1882:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    1885:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1888:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    188f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1892:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    1899:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    18a3:	e9 8d 00 00 00       	jmp    1935 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    18a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ab:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    18b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b5:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18bf:	8b 40 20             	mov    0x20(%eax),%eax
    18c2:	89 c2                	mov    %eax,%edx
    18c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c7:	8b 40 24             	mov    0x24(%eax),%eax
    18ca:	0f af d0             	imul   %eax,%edx
    18cd:	89 d0                	mov    %edx,%eax
    18cf:	01 c0                	add    %eax,%eax
    18d1:	01 d0                	add    %edx,%eax
    18d3:	83 ec 0c             	sub    $0xc,%esp
    18d6:	50                   	push   %eax
    18d7:	e8 43 f1 ff ff       	call   a1f <malloc>
    18dc:	83 c4 10             	add    $0x10,%esp
    18df:	89 c2                	mov    %eax,%edx
    18e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e4:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    18e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ea:	8b 40 38             	mov    0x38(%eax),%eax
    18ed:	85 c0                	test   %eax,%eax
    18ef:	75 15                	jne    1906 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    18f1:	83 ec 04             	sub    $0x4,%esp
    18f4:	ff 75 08             	pushl  0x8(%ebp)
    18f7:	68 e0 25 00 00       	push   $0x25e0
    18fc:	6a 01                	push   $0x1
    18fe:	e8 49 ee ff ff       	call   74c <printf>
    1903:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1906:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1909:	8b 40 20             	mov    0x20(%eax),%eax
    190c:	89 c2                	mov    %eax,%edx
    190e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1911:	8b 40 24             	mov    0x24(%eax),%eax
    1914:	0f af d0             	imul   %eax,%edx
    1917:	89 d0                	mov    %edx,%eax
    1919:	01 c0                	add    %eax,%eax
    191b:	01 c2                	add    %eax,%edx
    191d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1920:	8b 40 38             	mov    0x38(%eax),%eax
    1923:	83 ec 04             	sub    $0x4,%esp
    1926:	52                   	push   %edx
    1927:	68 ff ff ff 00       	push   $0xffffff
    192c:	50                   	push   %eax
    192d:	e8 d0 ea ff ff       	call   402 <memset>
    1932:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1935:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1938:	c9                   	leave  
    1939:	c3                   	ret    

0000193a <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    193a:	55                   	push   %ebp
    193b:	89 e5                	mov    %esp,%ebp
    193d:	57                   	push   %edi
    193e:	56                   	push   %esi
    193f:	53                   	push   %ebx
    1940:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1943:	8b 45 0c             	mov    0xc(%ebp),%eax
    1946:	83 f8 03             	cmp    $0x3,%eax
    1949:	74 02                	je     194d <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    194b:	eb 7c                	jmp    19c9 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    194d:	8b 45 08             	mov    0x8(%ebp),%eax
    1950:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1953:	8b 45 08             	mov    0x8(%ebp),%eax
    1956:	8b 48 18             	mov    0x18(%eax),%ecx
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
    195c:	8b 50 5c             	mov    0x5c(%eax),%edx
    195f:	8b 45 08             	mov    0x8(%ebp),%eax
    1962:	8b 40 58             	mov    0x58(%eax),%eax
    1965:	8b 75 08             	mov    0x8(%ebp),%esi
    1968:	83 c6 58             	add    $0x58,%esi
    196b:	83 ec 04             	sub    $0x4,%esp
    196e:	53                   	push   %ebx
    196f:	51                   	push   %ecx
    1970:	6a 00                	push   $0x0
    1972:	52                   	push   %edx
    1973:	50                   	push   %eax
    1974:	6a 00                	push   $0x0
    1976:	6a 00                	push   $0x0
    1978:	56                   	push   %esi
    1979:	6a 00                	push   $0x0
    197b:	6a 00                	push   $0x0
    197d:	ff 75 08             	pushl  0x8(%ebp)
    1980:	e8 b8 ec ff ff       	call   63d <paintWindow>
    1985:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1988:	8b 45 08             	mov    0x8(%ebp),%eax
    198b:	8b 70 1c             	mov    0x1c(%eax),%esi
    198e:	8b 45 08             	mov    0x8(%ebp),%eax
    1991:	8b 58 18             	mov    0x18(%eax),%ebx
    1994:	8b 45 08             	mov    0x8(%ebp),%eax
    1997:	8b 48 08             	mov    0x8(%eax),%ecx
    199a:	8b 45 08             	mov    0x8(%ebp),%eax
    199d:	8b 50 40             	mov    0x40(%eax),%edx
    19a0:	8b 45 08             	mov    0x8(%ebp),%eax
    19a3:	8b 40 3c             	mov    0x3c(%eax),%eax
    19a6:	8b 7d 08             	mov    0x8(%ebp),%edi
    19a9:	83 c7 3c             	add    $0x3c,%edi
    19ac:	83 ec 04             	sub    $0x4,%esp
    19af:	56                   	push   %esi
    19b0:	53                   	push   %ebx
    19b1:	51                   	push   %ecx
    19b2:	52                   	push   %edx
    19b3:	50                   	push   %eax
    19b4:	6a 00                	push   $0x0
    19b6:	6a 00                	push   $0x0
    19b8:	57                   	push   %edi
    19b9:	6a 32                	push   $0x32
    19bb:	6a 00                	push   $0x0
    19bd:	ff 75 08             	pushl  0x8(%ebp)
    19c0:	e8 78 ec ff ff       	call   63d <paintWindow>
    19c5:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    19c8:	90                   	nop
        default: break;
            
            
    }
    return False;
    19c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19d1:	5b                   	pop    %ebx
    19d2:	5e                   	pop    %esi
    19d3:	5f                   	pop    %edi
    19d4:	5d                   	pop    %ebp
    19d5:	c3                   	ret    

000019d6 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    19d6:	55                   	push   %ebp
    19d7:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    19d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    19dc:	8b 50 08             	mov    0x8(%eax),%edx
    19df:	8b 45 08             	mov    0x8(%ebp),%eax
    19e2:	8b 00                	mov    (%eax),%eax
    19e4:	39 c2                	cmp    %eax,%edx
    19e6:	74 07                	je     19ef <APPreJudge+0x19>
        return False;
    19e8:	b8 00 00 00 00       	mov    $0x0,%eax
    19ed:	eb 05                	jmp    19f4 <APPreJudge+0x1e>
    return True;
    19ef:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19f4:	5d                   	pop    %ebp
    19f5:	c3                   	ret    

000019f6 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19f6:	55                   	push   %ebp
    19f7:	89 e5                	mov    %esp,%ebp
    19f9:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19fc:	8b 45 08             	mov    0x8(%ebp),%eax
    19ff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a02:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1a08:	83 ec 0c             	sub    $0xc,%esp
    1a0b:	ff 75 08             	pushl  0x8(%ebp)
    1a0e:	e8 42 ec ff ff       	call   655 <registWindow>
    1a13:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1a16:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1a1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a20:	8b 00                	mov    (%eax),%eax
    1a22:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1a25:	ff 75 f4             	pushl  -0xc(%ebp)
    1a28:	ff 75 f0             	pushl  -0x10(%ebp)
    1a2b:	ff 75 ec             	pushl  -0x14(%ebp)
    1a2e:	ff 75 08             	pushl  0x8(%ebp)
    1a31:	e8 80 fc ff ff       	call   16b6 <APSendMessage>
    1a36:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a39:	83 ec 0c             	sub    $0xc,%esp
    1a3c:	ff 75 08             	pushl  0x8(%ebp)
    1a3f:	e8 09 ec ff ff       	call   64d <getMessage>
    1a44:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a47:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4a:	83 c0 74             	add    $0x74,%eax
    1a4d:	83 ec 08             	sub    $0x8,%esp
    1a50:	50                   	push   %eax
    1a51:	ff 75 08             	pushl  0x8(%ebp)
    1a54:	e8 7d ff ff ff       	call   19d6 <APPreJudge>
    1a59:	83 c4 10             	add    $0x10,%esp
    1a5c:	84 c0                	test   %al,%al
    1a5e:	74 1b                	je     1a7b <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1a60:	8b 45 08             	mov    0x8(%ebp),%eax
    1a63:	ff 70 7c             	pushl  0x7c(%eax)
    1a66:	ff 70 78             	pushl  0x78(%eax)
    1a69:	ff 70 74             	pushl  0x74(%eax)
    1a6c:	ff 75 08             	pushl  0x8(%ebp)
    1a6f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a72:	ff d0                	call   *%eax
    1a74:	83 c4 10             	add    $0x10,%esp
    1a77:	84 c0                	test   %al,%al
    1a79:	75 0c                	jne    1a87 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1a7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7e:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1a85:	eb b2                	jmp    1a39 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a87:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a88:	90                   	nop
    1a89:	c9                   	leave  
    1a8a:	c3                   	ret    

00001a8b <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a8b:	55                   	push   %ebp
    1a8c:	89 e5                	mov    %esp,%ebp
    1a8e:	57                   	push   %edi
    1a8f:	56                   	push   %esi
    1a90:	53                   	push   %ebx
    1a91:	83 ec 6c             	sub    $0x6c,%esp
    if (!iconReady)
    1a94:	a1 cc 2c 00 00       	mov    0x2ccc,%eax
    1a99:	85 c0                	test   %eax,%eax
    1a9b:	0f 85 2c 02 00 00    	jne    1ccd <APGridPaint+0x242>
    {
        iconReady = 1;
    1aa1:	c7 05 cc 2c 00 00 01 	movl   $0x1,0x2ccc
    1aa8:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1aab:	8d 45 98             	lea    -0x68(%ebp),%eax
    1aae:	83 ec 08             	sub    $0x8,%esp
    1ab1:	68 07 26 00 00       	push   $0x2607
    1ab6:	50                   	push   %eax
    1ab7:	e8 16 f1 ff ff       	call   bd2 <APLoadBitmap>
    1abc:	83 c4 0c             	add    $0xc,%esp
    1abf:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ac2:	a3 f0 2c 00 00       	mov    %eax,0x2cf0
    1ac7:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1aca:	a3 f4 2c 00 00       	mov    %eax,0x2cf4
    1acf:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ad2:	a3 f8 2c 00 00       	mov    %eax,0x2cf8
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1ad7:	83 ec 04             	sub    $0x4,%esp
    1ada:	ff 35 f8 2c 00 00    	pushl  0x2cf8
    1ae0:	ff 35 f4 2c 00 00    	pushl  0x2cf4
    1ae6:	ff 35 f0 2c 00 00    	pushl  0x2cf0
    1aec:	e8 1b f3 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1af1:	83 c4 10             	add    $0x10,%esp
    1af4:	a3 fc 2c 00 00       	mov    %eax,0x2cfc
        grid_river = APLoadBitmap ("grid_river.bmp");
    1af9:	8d 45 98             	lea    -0x68(%ebp),%eax
    1afc:	83 ec 08             	sub    $0x8,%esp
    1aff:	68 15 26 00 00       	push   $0x2615
    1b04:	50                   	push   %eax
    1b05:	e8 c8 f0 ff ff       	call   bd2 <APLoadBitmap>
    1b0a:	83 c4 0c             	add    $0xc,%esp
    1b0d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b10:	a3 2c 2d 00 00       	mov    %eax,0x2d2c
    1b15:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b18:	a3 30 2d 00 00       	mov    %eax,0x2d30
    1b1d:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b20:	a3 34 2d 00 00       	mov    %eax,0x2d34
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1b25:	83 ec 04             	sub    $0x4,%esp
    1b28:	ff 35 34 2d 00 00    	pushl  0x2d34
    1b2e:	ff 35 30 2d 00 00    	pushl  0x2d30
    1b34:	ff 35 2c 2d 00 00    	pushl  0x2d2c
    1b3a:	e8 cd f2 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1b3f:	83 c4 10             	add    $0x10,%esp
    1b42:	a3 1c 2d 00 00       	mov    %eax,0x2d1c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1b47:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b4a:	83 ec 08             	sub    $0x8,%esp
    1b4d:	68 24 26 00 00       	push   $0x2624
    1b52:	50                   	push   %eax
    1b53:	e8 7a f0 ff ff       	call   bd2 <APLoadBitmap>
    1b58:	83 c4 0c             	add    $0xc,%esp
    1b5b:	8b 45 98             	mov    -0x68(%ebp),%eax
    1b5e:	a3 20 2d 00 00       	mov    %eax,0x2d20
    1b63:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1b66:	a3 24 2d 00 00       	mov    %eax,0x2d24
    1b6b:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1b6e:	a3 28 2d 00 00       	mov    %eax,0x2d28
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1b73:	83 ec 04             	sub    $0x4,%esp
    1b76:	ff 35 28 2d 00 00    	pushl  0x2d28
    1b7c:	ff 35 24 2d 00 00    	pushl  0x2d24
    1b82:	ff 35 20 2d 00 00    	pushl  0x2d20
    1b88:	e8 7f f2 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1b8d:	83 c4 10             	add    $0x10,%esp
    1b90:	a3 d0 2c 00 00       	mov    %eax,0x2cd0
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1b95:	8d 45 98             	lea    -0x68(%ebp),%eax
    1b98:	83 ec 08             	sub    $0x8,%esp
    1b9b:	68 33 26 00 00       	push   $0x2633
    1ba0:	50                   	push   %eax
    1ba1:	e8 2c f0 ff ff       	call   bd2 <APLoadBitmap>
    1ba6:	83 c4 0c             	add    $0xc,%esp
    1ba9:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bac:	a3 04 2d 00 00       	mov    %eax,0x2d04
    1bb1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1bb4:	a3 08 2d 00 00       	mov    %eax,0x2d08
    1bb9:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1bbc:	a3 0c 2d 00 00       	mov    %eax,0x2d0c
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1bc1:	83 ec 04             	sub    $0x4,%esp
    1bc4:	ff 35 0c 2d 00 00    	pushl  0x2d0c
    1bca:	ff 35 08 2d 00 00    	pushl  0x2d08
    1bd0:	ff 35 04 2d 00 00    	pushl  0x2d04
    1bd6:	e8 31 f2 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1bdb:	83 c4 10             	add    $0x10,%esp
    1bde:	a3 38 2d 00 00       	mov    %eax,0x2d38
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1be3:	8d 45 98             	lea    -0x68(%ebp),%eax
    1be6:	83 ec 08             	sub    $0x8,%esp
    1be9:	68 41 26 00 00       	push   $0x2641
    1bee:	50                   	push   %eax
    1bef:	e8 de ef ff ff       	call   bd2 <APLoadBitmap>
    1bf4:	83 c4 0c             	add    $0xc,%esp
    1bf7:	8b 45 98             	mov    -0x68(%ebp),%eax
    1bfa:	a3 e0 2c 00 00       	mov    %eax,0x2ce0
    1bff:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c02:	a3 e4 2c 00 00       	mov    %eax,0x2ce4
    1c07:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c0a:	a3 e8 2c 00 00       	mov    %eax,0x2ce8
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1c0f:	83 ec 04             	sub    $0x4,%esp
    1c12:	ff 35 e8 2c 00 00    	pushl  0x2ce8
    1c18:	ff 35 e4 2c 00 00    	pushl  0x2ce4
    1c1e:	ff 35 e0 2c 00 00    	pushl  0x2ce0
    1c24:	e8 e3 f1 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1c29:	83 c4 10             	add    $0x10,%esp
    1c2c:	a3 00 2d 00 00       	mov    %eax,0x2d00
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1c31:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c34:	83 ec 08             	sub    $0x8,%esp
    1c37:	68 51 26 00 00       	push   $0x2651
    1c3c:	50                   	push   %eax
    1c3d:	e8 90 ef ff ff       	call   bd2 <APLoadBitmap>
    1c42:	83 c4 0c             	add    $0xc,%esp
    1c45:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c48:	a3 d4 2c 00 00       	mov    %eax,0x2cd4
    1c4d:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c50:	a3 d8 2c 00 00       	mov    %eax,0x2cd8
    1c55:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1c58:	a3 dc 2c 00 00       	mov    %eax,0x2cdc
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1c5d:	83 ec 04             	sub    $0x4,%esp
    1c60:	ff 35 dc 2c 00 00    	pushl  0x2cdc
    1c66:	ff 35 d8 2c 00 00    	pushl  0x2cd8
    1c6c:	ff 35 d4 2c 00 00    	pushl  0x2cd4
    1c72:	e8 95 f1 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1c77:	83 c4 10             	add    $0x10,%esp
    1c7a:	a3 ec 2c 00 00       	mov    %eax,0x2cec
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1c7f:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c82:	83 ec 08             	sub    $0x8,%esp
    1c85:	68 63 26 00 00       	push   $0x2663
    1c8a:	50                   	push   %eax
    1c8b:	e8 42 ef ff ff       	call   bd2 <APLoadBitmap>
    1c90:	83 c4 0c             	add    $0xc,%esp
    1c93:	8b 45 98             	mov    -0x68(%ebp),%eax
    1c96:	a3 10 2d 00 00       	mov    %eax,0x2d10
    1c9b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1c9e:	a3 14 2d 00 00       	mov    %eax,0x2d14
    1ca3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ca6:	a3 18 2d 00 00       	mov    %eax,0x2d18
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1cab:	83 ec 04             	sub    $0x4,%esp
    1cae:	ff 35 18 2d 00 00    	pushl  0x2d18
    1cb4:	ff 35 14 2d 00 00    	pushl  0x2d14
    1cba:	ff 35 10 2d 00 00    	pushl  0x2d10
    1cc0:	e8 47 f1 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1cc5:	83 c4 10             	add    $0x10,%esp
    1cc8:	a3 3c 2d 00 00       	mov    %eax,0x2d3c
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1ccd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd0:	8b 40 08             	mov    0x8(%eax),%eax
    1cd3:	85 c0                	test   %eax,%eax
    1cd5:	75 17                	jne    1cee <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1cd7:	83 ec 08             	sub    $0x8,%esp
    1cda:	68 74 26 00 00       	push   $0x2674
    1cdf:	6a 01                	push   $0x1
    1ce1:	e8 66 ea ff ff       	call   74c <printf>
    1ce6:	83 c4 10             	add    $0x10,%esp
        return;
    1ce9:	e9 a0 04 00 00       	jmp    218e <APGridPaint+0x703>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1cee:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf1:	8b 40 10             	mov    0x10(%eax),%eax
    1cf4:	85 c0                	test   %eax,%eax
    1cf6:	7e 10                	jle    1d08 <APGridPaint+0x27d>
    1cf8:	8b 45 08             	mov    0x8(%ebp),%eax
    1cfb:	8b 50 14             	mov    0x14(%eax),%edx
    1cfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1d01:	8b 40 10             	mov    0x10(%eax),%eax
    1d04:	39 c2                	cmp    %eax,%edx
    1d06:	7c 17                	jl     1d1f <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1d08:	83 ec 08             	sub    $0x8,%esp
    1d0b:	68 9a 26 00 00       	push   $0x269a
    1d10:	6a 01                	push   $0x1
    1d12:	e8 35 ea ff ff       	call   74c <printf>
    1d17:	83 c4 10             	add    $0x10,%esp
        return;
    1d1a:	e9 6f 04 00 00       	jmp    218e <APGridPaint+0x703>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1d1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d22:	8b 40 14             	mov    0x14(%eax),%eax
    1d25:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1d2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1d2e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d31:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1d34:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1d3b:	e9 96 03 00 00       	jmp    20d6 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1d40:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1d47:	e9 7c 03 00 00       	jmp    20c8 <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1d4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d4f:	c1 e0 04             	shl    $0x4,%eax
    1d52:	89 c2                	mov    %eax,%edx
    1d54:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1d57:	01 c2                	add    %eax,%edx
    1d59:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d5c:	01 d0                	add    %edx,%eax
    1d5e:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1d61:	8b 45 08             	mov    0x8(%ebp),%eax
    1d64:	8b 40 0c             	mov    0xc(%eax),%eax
    1d67:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1d6a:	c1 e2 02             	shl    $0x2,%edx
    1d6d:	01 d0                	add    %edx,%eax
    1d6f:	8b 00                	mov    (%eax),%eax
    1d71:	83 f8 07             	cmp    $0x7,%eax
    1d74:	0f 87 49 03 00 00    	ja     20c3 <APGridPaint+0x638>
    1d7a:	8b 04 85 b0 26 00 00 	mov    0x26b0(,%eax,4),%eax
    1d81:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1d83:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1d86:	6a 0c                	push   $0xc
    1d88:	6a 0c                	push   $0xc
    1d8a:	6a 0c                	push   $0xc
    1d8c:	50                   	push   %eax
    1d8d:	e8 df f8 ff ff       	call   1671 <RGB>
    1d92:	83 c4 0c             	add    $0xc,%esp
    1d95:	8b 1d fc 2c 00 00    	mov    0x2cfc,%ebx
    1d9b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d9e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1da1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1da4:	6b c0 32             	imul   $0x32,%eax,%eax
    1da7:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1daa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dad:	8d 78 3c             	lea    0x3c(%eax),%edi
    1db0:	83 ec 0c             	sub    $0xc,%esp
    1db3:	83 ec 04             	sub    $0x4,%esp
    1db6:	89 e0                	mov    %esp,%eax
    1db8:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1dbc:	66 89 30             	mov    %si,(%eax)
    1dbf:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1dc3:	88 50 02             	mov    %dl,0x2(%eax)
    1dc6:	6a 32                	push   $0x32
    1dc8:	6a 32                	push   $0x32
    1dca:	6a 00                	push   $0x0
    1dcc:	6a 00                	push   $0x0
    1dce:	53                   	push   %ebx
    1dcf:	51                   	push   %ecx
    1dd0:	ff 75 94             	pushl  -0x6c(%ebp)
    1dd3:	57                   	push   %edi
    1dd4:	e8 f4 f6 ff ff       	call   14cd <APDcCopy>
    1dd9:	83 c4 30             	add    $0x30,%esp
                    break;
    1ddc:	e9 e3 02 00 00       	jmp    20c4 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1de1:	8d 45 98             	lea    -0x68(%ebp),%eax
    1de4:	6a 69                	push   $0x69
    1de6:	6a 69                	push   $0x69
    1de8:	6a 69                	push   $0x69
    1dea:	50                   	push   %eax
    1deb:	e8 81 f8 ff ff       	call   1671 <RGB>
    1df0:	83 c4 0c             	add    $0xc,%esp
    1df3:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1df7:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
    1dfb:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1dff:	88 45 ae             	mov    %al,-0x52(%ebp)
                    pen.size = 1;
    1e02:	c7 45 b0 01 00 00 00 	movl   $0x1,-0x50(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1e09:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e0c:	6a 69                	push   $0x69
    1e0e:	6a 69                	push   $0x69
    1e10:	6a 69                	push   $0x69
    1e12:	50                   	push   %eax
    1e13:	e8 59 f8 ff ff       	call   1671 <RGB>
    1e18:	83 c4 0c             	add    $0xc,%esp
    1e1b:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    1e1f:	66 89 45 a9          	mov    %ax,-0x57(%ebp)
    1e23:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    1e27:	88 45 ab             	mov    %al,-0x55(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1e2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2d:	8d 50 3c             	lea    0x3c(%eax),%edx
    1e30:	8d 45 98             	lea    -0x68(%ebp),%eax
    1e33:	ff 75 b0             	pushl  -0x50(%ebp)
    1e36:	ff 75 ac             	pushl  -0x54(%ebp)
    1e39:	52                   	push   %edx
    1e3a:	50                   	push   %eax
    1e3b:	e8 61 f0 ff ff       	call   ea1 <APSetPen>
    1e40:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1e43:	8b 45 08             	mov    0x8(%ebp),%eax
    1e46:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1e49:	8d 55 98             	lea    -0x68(%ebp),%edx
    1e4c:	83 ec 04             	sub    $0x4,%esp
    1e4f:	83 ec 04             	sub    $0x4,%esp
    1e52:	89 e0                	mov    %esp,%eax
    1e54:	0f b7 4d a9          	movzwl -0x57(%ebp),%ecx
    1e58:	66 89 08             	mov    %cx,(%eax)
    1e5b:	0f b6 4d ab          	movzbl -0x55(%ebp),%ecx
    1e5f:	88 48 02             	mov    %cl,0x2(%eax)
    1e62:	53                   	push   %ebx
    1e63:	52                   	push   %edx
    1e64:	e8 71 f0 ff ff       	call   eda <APSetBrush>
    1e69:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1e6c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e6f:	6b d0 32             	imul   $0x32,%eax,%edx
    1e72:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e75:	6b c0 32             	imul   $0x32,%eax,%eax
    1e78:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e7b:	83 c1 3c             	add    $0x3c,%ecx
    1e7e:	83 ec 0c             	sub    $0xc,%esp
    1e81:	6a 32                	push   $0x32
    1e83:	6a 32                	push   $0x32
    1e85:	52                   	push   %edx
    1e86:	50                   	push   %eax
    1e87:	51                   	push   %ecx
    1e88:	e8 35 f4 ff ff       	call   12c2 <APDrawRect>
    1e8d:	83 c4 20             	add    $0x20,%esp
                    break;
    1e90:	e9 2f 02 00 00       	jmp    20c4 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1e95:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1e98:	6a 0c                	push   $0xc
    1e9a:	6a 0c                	push   $0xc
    1e9c:	6a 0c                	push   $0xc
    1e9e:	50                   	push   %eax
    1e9f:	e8 cd f7 ff ff       	call   1671 <RGB>
    1ea4:	83 c4 0c             	add    $0xc,%esp
    1ea7:	8b 1d 3c 2d 00 00    	mov    0x2d3c,%ebx
    1ead:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1eb0:	6b c8 32             	imul   $0x32,%eax,%ecx
    1eb3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1eb6:	6b c0 32             	imul   $0x32,%eax,%eax
    1eb9:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1ebc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebf:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ec2:	83 ec 0c             	sub    $0xc,%esp
    1ec5:	83 ec 04             	sub    $0x4,%esp
    1ec8:	89 e0                	mov    %esp,%eax
    1eca:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    1ece:	66 89 30             	mov    %si,(%eax)
    1ed1:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    1ed5:	88 50 02             	mov    %dl,0x2(%eax)
    1ed8:	6a 32                	push   $0x32
    1eda:	6a 32                	push   $0x32
    1edc:	6a 00                	push   $0x0
    1ede:	6a 00                	push   $0x0
    1ee0:	53                   	push   %ebx
    1ee1:	51                   	push   %ecx
    1ee2:	ff 75 94             	pushl  -0x6c(%ebp)
    1ee5:	57                   	push   %edi
    1ee6:	e8 e2 f5 ff ff       	call   14cd <APDcCopy>
    1eeb:	83 c4 30             	add    $0x30,%esp
                    break;
    1eee:	e9 d1 01 00 00       	jmp    20c4 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ef3:	8d 45 c9             	lea    -0x37(%ebp),%eax
    1ef6:	6a 0c                	push   $0xc
    1ef8:	6a 0c                	push   $0xc
    1efa:	6a 0c                	push   $0xc
    1efc:	50                   	push   %eax
    1efd:	e8 6f f7 ff ff       	call   1671 <RGB>
    1f02:	83 c4 0c             	add    $0xc,%esp
    1f05:	8b 1d 1c 2d 00 00    	mov    0x2d1c,%ebx
    1f0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f0e:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f11:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f14:	6b c0 32             	imul   $0x32,%eax,%eax
    1f17:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1d:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f20:	83 ec 0c             	sub    $0xc,%esp
    1f23:	83 ec 04             	sub    $0x4,%esp
    1f26:	89 e0                	mov    %esp,%eax
    1f28:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    1f2c:	66 89 30             	mov    %si,(%eax)
    1f2f:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    1f33:	88 50 02             	mov    %dl,0x2(%eax)
    1f36:	6a 32                	push   $0x32
    1f38:	6a 32                	push   $0x32
    1f3a:	6a 00                	push   $0x0
    1f3c:	6a 00                	push   $0x0
    1f3e:	53                   	push   %ebx
    1f3f:	51                   	push   %ecx
    1f40:	ff 75 94             	pushl  -0x6c(%ebp)
    1f43:	57                   	push   %edi
    1f44:	e8 84 f5 ff ff       	call   14cd <APDcCopy>
    1f49:	83 c4 30             	add    $0x30,%esp
                    break;
    1f4c:	e9 73 01 00 00       	jmp    20c4 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1f51:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1f54:	6a 0c                	push   $0xc
    1f56:	6a 0c                	push   $0xc
    1f58:	6a 0c                	push   $0xc
    1f5a:	50                   	push   %eax
    1f5b:	e8 11 f7 ff ff       	call   1671 <RGB>
    1f60:	83 c4 0c             	add    $0xc,%esp
    1f63:	8b 1d 00 2d 00 00    	mov    0x2d00,%ebx
    1f69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f6c:	6b c8 32             	imul   $0x32,%eax,%ecx
    1f6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1f72:	6b c0 32             	imul   $0x32,%eax,%eax
    1f75:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1f78:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7b:	8d 78 3c             	lea    0x3c(%eax),%edi
    1f7e:	83 ec 0c             	sub    $0xc,%esp
    1f81:	83 ec 04             	sub    $0x4,%esp
    1f84:	89 e0                	mov    %esp,%eax
    1f86:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    1f8a:	66 89 30             	mov    %si,(%eax)
    1f8d:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    1f91:	88 50 02             	mov    %dl,0x2(%eax)
    1f94:	6a 32                	push   $0x32
    1f96:	6a 32                	push   $0x32
    1f98:	6a 00                	push   $0x0
    1f9a:	6a 00                	push   $0x0
    1f9c:	53                   	push   %ebx
    1f9d:	51                   	push   %ecx
    1f9e:	ff 75 94             	pushl  -0x6c(%ebp)
    1fa1:	57                   	push   %edi
    1fa2:	e8 26 f5 ff ff       	call   14cd <APDcCopy>
    1fa7:	83 c4 30             	add    $0x30,%esp
                    break;
    1faa:	e9 15 01 00 00       	jmp    20c4 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1faf:	8d 45 cf             	lea    -0x31(%ebp),%eax
    1fb2:	6a 0c                	push   $0xc
    1fb4:	6a 0c                	push   $0xc
    1fb6:	6a 0c                	push   $0xc
    1fb8:	50                   	push   %eax
    1fb9:	e8 b3 f6 ff ff       	call   1671 <RGB>
    1fbe:	83 c4 0c             	add    $0xc,%esp
    1fc1:	8b 1d 38 2d 00 00    	mov    0x2d38,%ebx
    1fc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fca:	6b c8 32             	imul   $0x32,%eax,%ecx
    1fcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fd0:	6b c0 32             	imul   $0x32,%eax,%eax
    1fd3:	89 45 94             	mov    %eax,-0x6c(%ebp)
    1fd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd9:	8d 78 3c             	lea    0x3c(%eax),%edi
    1fdc:	83 ec 0c             	sub    $0xc,%esp
    1fdf:	83 ec 04             	sub    $0x4,%esp
    1fe2:	89 e0                	mov    %esp,%eax
    1fe4:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    1fe8:	66 89 30             	mov    %si,(%eax)
    1feb:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    1fef:	88 50 02             	mov    %dl,0x2(%eax)
    1ff2:	6a 32                	push   $0x32
    1ff4:	6a 32                	push   $0x32
    1ff6:	6a 00                	push   $0x0
    1ff8:	6a 00                	push   $0x0
    1ffa:	53                   	push   %ebx
    1ffb:	51                   	push   %ecx
    1ffc:	ff 75 94             	pushl  -0x6c(%ebp)
    1fff:	57                   	push   %edi
    2000:	e8 c8 f4 ff ff       	call   14cd <APDcCopy>
    2005:	83 c4 30             	add    $0x30,%esp
                    break;
    2008:	e9 b7 00 00 00       	jmp    20c4 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    200d:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2010:	6a 0c                	push   $0xc
    2012:	6a 0c                	push   $0xc
    2014:	6a 0c                	push   $0xc
    2016:	50                   	push   %eax
    2017:	e8 55 f6 ff ff       	call   1671 <RGB>
    201c:	83 c4 0c             	add    $0xc,%esp
    201f:	8b 1d d0 2c 00 00    	mov    0x2cd0,%ebx
    2025:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2028:	6b c8 32             	imul   $0x32,%eax,%ecx
    202b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    202e:	6b c0 32             	imul   $0x32,%eax,%eax
    2031:	89 45 94             	mov    %eax,-0x6c(%ebp)
    2034:	8b 45 08             	mov    0x8(%ebp),%eax
    2037:	8d 78 3c             	lea    0x3c(%eax),%edi
    203a:	83 ec 0c             	sub    $0xc,%esp
    203d:	83 ec 04             	sub    $0x4,%esp
    2040:	89 e0                	mov    %esp,%eax
    2042:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2046:	66 89 30             	mov    %si,(%eax)
    2049:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    204d:	88 50 02             	mov    %dl,0x2(%eax)
    2050:	6a 32                	push   $0x32
    2052:	6a 32                	push   $0x32
    2054:	6a 00                	push   $0x0
    2056:	6a 00                	push   $0x0
    2058:	53                   	push   %ebx
    2059:	51                   	push   %ecx
    205a:	ff 75 94             	pushl  -0x6c(%ebp)
    205d:	57                   	push   %edi
    205e:	e8 6a f4 ff ff       	call   14cd <APDcCopy>
    2063:	83 c4 30             	add    $0x30,%esp
                    break;
    2066:	eb 5c                	jmp    20c4 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2068:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    206b:	6a 0c                	push   $0xc
    206d:	6a 0c                	push   $0xc
    206f:	6a 0c                	push   $0xc
    2071:	50                   	push   %eax
    2072:	e8 fa f5 ff ff       	call   1671 <RGB>
    2077:	83 c4 0c             	add    $0xc,%esp
    207a:	8b 1d ec 2c 00 00    	mov    0x2cec,%ebx
    2080:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2083:	6b c8 32             	imul   $0x32,%eax,%ecx
    2086:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2089:	6b c0 32             	imul   $0x32,%eax,%eax
    208c:	89 45 94             	mov    %eax,-0x6c(%ebp)
    208f:	8b 45 08             	mov    0x8(%ebp),%eax
    2092:	8d 78 3c             	lea    0x3c(%eax),%edi
    2095:	83 ec 0c             	sub    $0xc,%esp
    2098:	83 ec 04             	sub    $0x4,%esp
    209b:	89 e0                	mov    %esp,%eax
    209d:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    20a1:	66 89 30             	mov    %si,(%eax)
    20a4:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    20a8:	88 50 02             	mov    %dl,0x2(%eax)
    20ab:	6a 32                	push   $0x32
    20ad:	6a 32                	push   $0x32
    20af:	6a 00                	push   $0x0
    20b1:	6a 00                	push   $0x0
    20b3:	53                   	push   %ebx
    20b4:	51                   	push   %ecx
    20b5:	ff 75 94             	pushl  -0x6c(%ebp)
    20b8:	57                   	push   %edi
    20b9:	e8 0f f4 ff ff       	call   14cd <APDcCopy>
    20be:	83 c4 30             	add    $0x30,%esp
                    break;
    20c1:	eb 01                	jmp    20c4 <APGridPaint+0x639>
                default: break;
    20c3:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    20c4:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    20c8:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    20cc:	0f 8e 7a fc ff ff    	jle    1d4c <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    20d2:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    20d6:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    20da:	0f 8e 60 fc ff ff    	jle    1d40 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    20e0:	8d 45 98             	lea    -0x68(%ebp),%eax
    20e3:	68 cd 00 00 00       	push   $0xcd
    20e8:	6a 74                	push   $0x74
    20ea:	6a 18                	push   $0x18
    20ec:	50                   	push   %eax
    20ed:	e8 7f f5 ff ff       	call   1671 <RGB>
    20f2:	83 c4 0c             	add    $0xc,%esp
    20f5:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    20f9:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    20fd:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    2101:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2104:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    210b:	8d 45 98             	lea    -0x68(%ebp),%eax
    210e:	68 cd 00 00 00       	push   $0xcd
    2113:	6a 74                	push   $0x74
    2115:	6a 18                	push   $0x18
    2117:	50                   	push   %eax
    2118:	e8 54 f5 ff ff       	call   1671 <RGB>
    211d:	83 c4 0c             	add    $0xc,%esp
    2120:	0f b7 45 98          	movzwl -0x68(%ebp),%eax
    2124:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    2128:	0f b6 45 9a          	movzbl -0x66(%ebp),%eax
    212c:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    212f:	8b 45 08             	mov    0x8(%ebp),%eax
    2132:	8d 50 58             	lea    0x58(%eax),%edx
    2135:	8d 45 98             	lea    -0x68(%ebp),%eax
    2138:	ff 75 bc             	pushl  -0x44(%ebp)
    213b:	ff 75 b8             	pushl  -0x48(%ebp)
    213e:	52                   	push   %edx
    213f:	50                   	push   %eax
    2140:	e8 5c ed ff ff       	call   ea1 <APSetPen>
    2145:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    2148:	8b 45 08             	mov    0x8(%ebp),%eax
    214b:	8d 58 58             	lea    0x58(%eax),%ebx
    214e:	8d 55 98             	lea    -0x68(%ebp),%edx
    2151:	83 ec 04             	sub    $0x4,%esp
    2154:	83 ec 04             	sub    $0x4,%esp
    2157:	89 e0                	mov    %esp,%eax
    2159:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    215d:	66 89 08             	mov    %cx,(%eax)
    2160:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    2164:	88 48 02             	mov    %cl,0x2(%eax)
    2167:	53                   	push   %ebx
    2168:	52                   	push   %edx
    2169:	e8 6c ed ff ff       	call   eda <APSetBrush>
    216e:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    2171:	8b 45 08             	mov    0x8(%ebp),%eax
    2174:	83 c0 58             	add    $0x58,%eax
    2177:	83 ec 0c             	sub    $0xc,%esp
    217a:	6a 32                	push   $0x32
    217c:	68 20 03 00 00       	push   $0x320
    2181:	6a 00                	push   $0x0
    2183:	6a 00                	push   $0x0
    2185:	50                   	push   %eax
    2186:	e8 37 f1 ff ff       	call   12c2 <APDrawRect>
    218b:	83 c4 20             	add    $0x20,%esp
}
    218e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2191:	5b                   	pop    %ebx
    2192:	5e                   	pop    %esi
    2193:	5f                   	pop    %edi
    2194:	5d                   	pop    %ebp
    2195:	c3                   	ret    

00002196 <random>:
//

#include "APLib.h"

int random(int seed)
{
    2196:	55                   	push   %ebp
    2197:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2199:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    219d:	7e 08                	jle    21a7 <random+0x11>
{
rand_num = seed;
    219f:	8b 45 08             	mov    0x8(%ebp),%eax
    21a2:	a3 98 2c 00 00       	mov    %eax,0x2c98
}
rand_num *= 3;
    21a7:	8b 15 98 2c 00 00    	mov    0x2c98,%edx
    21ad:	89 d0                	mov    %edx,%eax
    21af:	01 c0                	add    %eax,%eax
    21b1:	01 d0                	add    %edx,%eax
    21b3:	a3 98 2c 00 00       	mov    %eax,0x2c98
if (rand_num < 0)
    21b8:	a1 98 2c 00 00       	mov    0x2c98,%eax
    21bd:	85 c0                	test   %eax,%eax
    21bf:	79 0c                	jns    21cd <random+0x37>
{
rand_num *= (-1);
    21c1:	a1 98 2c 00 00       	mov    0x2c98,%eax
    21c6:	f7 d8                	neg    %eax
    21c8:	a3 98 2c 00 00       	mov    %eax,0x2c98
}
return rand_num % 997;
    21cd:	8b 0d 98 2c 00 00    	mov    0x2c98,%ecx
    21d3:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    21d8:	89 c8                	mov    %ecx,%eax
    21da:	f7 ea                	imul   %edx
    21dc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    21df:	c1 f8 09             	sar    $0x9,%eax
    21e2:	89 c2                	mov    %eax,%edx
    21e4:	89 c8                	mov    %ecx,%eax
    21e6:	c1 f8 1f             	sar    $0x1f,%eax
    21e9:	29 c2                	sub    %eax,%edx
    21eb:	89 d0                	mov    %edx,%eax
    21ed:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    21f3:	29 c1                	sub    %eax,%ecx
    21f5:	89 c8                	mov    %ecx,%eax
}
    21f7:	5d                   	pop    %ebp
    21f8:	c3                   	ret    

000021f9 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    21f9:	55                   	push   %ebp
    21fa:	89 e5                	mov    %esp,%ebp
    21fc:	53                   	push   %ebx
    21fd:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    2200:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    2207:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    220b:	74 17                	je     2224 <sprintint+0x2b>
    220d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    2211:	79 11                	jns    2224 <sprintint+0x2b>
        neg = 1;
    2213:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    221a:	8b 45 10             	mov    0x10(%ebp),%eax
    221d:	f7 d8                	neg    %eax
    221f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2222:	eb 06                	jmp    222a <sprintint+0x31>
    } else {
        x = xx;
    2224:	8b 45 10             	mov    0x10(%ebp),%eax
    2227:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    222a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    2231:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    2234:	8d 41 01             	lea    0x1(%ecx),%eax
    2237:	89 45 f8             	mov    %eax,-0x8(%ebp)
    223a:	8b 5d 14             	mov    0x14(%ebp),%ebx
    223d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2240:	ba 00 00 00 00       	mov    $0x0,%edx
    2245:	f7 f3                	div    %ebx
    2247:	89 d0                	mov    %edx,%eax
    2249:	0f b6 80 9c 2c 00 00 	movzbl 0x2c9c(%eax),%eax
    2250:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    2254:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2257:	8b 45 f0             	mov    -0x10(%ebp),%eax
    225a:	ba 00 00 00 00       	mov    $0x0,%edx
    225f:	f7 f3                	div    %ebx
    2261:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2264:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2268:	75 c7                	jne    2231 <sprintint+0x38>
    if(neg)
    226a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    226e:	74 0e                	je     227e <sprintint+0x85>
        buf[i++] = '-';
    2270:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2273:	8d 50 01             	lea    0x1(%eax),%edx
    2276:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2279:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    227e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2281:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    2284:	eb 1b                	jmp    22a1 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2286:	8b 45 0c             	mov    0xc(%ebp),%eax
    2289:	8b 00                	mov    (%eax),%eax
    228b:	8d 48 01             	lea    0x1(%eax),%ecx
    228e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2291:	89 0a                	mov    %ecx,(%edx)
    2293:	89 c2                	mov    %eax,%edx
    2295:	8b 45 08             	mov    0x8(%ebp),%eax
    2298:	01 d0                	add    %edx,%eax
    229a:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    229d:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    22a1:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    22a5:	7f df                	jg     2286 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22a7:	eb 21                	jmp    22ca <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    22a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    22ac:	8b 00                	mov    (%eax),%eax
    22ae:	8d 48 01             	lea    0x1(%eax),%ecx
    22b1:	8b 55 0c             	mov    0xc(%ebp),%edx
    22b4:	89 0a                	mov    %ecx,(%edx)
    22b6:	89 c2                	mov    %eax,%edx
    22b8:	8b 45 08             	mov    0x8(%ebp),%eax
    22bb:	01 c2                	add    %eax,%edx
    22bd:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    22c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    22c3:	01 c8                	add    %ecx,%eax
    22c5:	0f b6 00             	movzbl (%eax),%eax
    22c8:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    22ca:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    22ce:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    22d2:	79 d5                	jns    22a9 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    22d4:	90                   	nop
    22d5:	83 c4 20             	add    $0x20,%esp
    22d8:	5b                   	pop    %ebx
    22d9:	5d                   	pop    %ebp
    22da:	c3                   	ret    

000022db <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    22db:	55                   	push   %ebp
    22dc:	89 e5                	mov    %esp,%ebp
    22de:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    22e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    22e8:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    22ef:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    22f6:	8d 45 0c             	lea    0xc(%ebp),%eax
    22f9:	83 c0 04             	add    $0x4,%eax
    22fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    22ff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    2306:	e9 d9 01 00 00       	jmp    24e4 <sprintf+0x209>
        c = fmt[i] & 0xff;
    230b:	8b 55 0c             	mov    0xc(%ebp),%edx
    230e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2311:	01 d0                	add    %edx,%eax
    2313:	0f b6 00             	movzbl (%eax),%eax
    2316:	0f be c0             	movsbl %al,%eax
    2319:	25 ff 00 00 00       	and    $0xff,%eax
    231e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    2321:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2325:	75 2c                	jne    2353 <sprintf+0x78>
            if(c == '%'){
    2327:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    232b:	75 0c                	jne    2339 <sprintf+0x5e>
                state = '%';
    232d:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    2334:	e9 a7 01 00 00       	jmp    24e0 <sprintf+0x205>
            } else {
                dst[j++] = c;
    2339:	8b 45 c8             	mov    -0x38(%ebp),%eax
    233c:	8d 50 01             	lea    0x1(%eax),%edx
    233f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2342:	89 c2                	mov    %eax,%edx
    2344:	8b 45 08             	mov    0x8(%ebp),%eax
    2347:	01 d0                	add    %edx,%eax
    2349:	8b 55 e0             	mov    -0x20(%ebp),%edx
    234c:	88 10                	mov    %dl,(%eax)
    234e:	e9 8d 01 00 00       	jmp    24e0 <sprintf+0x205>
            }
        } else if(state == '%'){
    2353:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2357:	0f 85 83 01 00 00    	jne    24e0 <sprintf+0x205>
            if(c == 'd'){
    235d:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    2361:	75 4c                	jne    23af <sprintf+0xd4>
                buf[bi] = '\0';
    2363:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2366:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2369:	01 d0                	add    %edx,%eax
    236b:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    236e:	83 ec 0c             	sub    $0xc,%esp
    2371:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2374:	50                   	push   %eax
    2375:	e8 91 e1 ff ff       	call   50b <atoi>
    237a:	83 c4 10             	add    $0x10,%esp
    237d:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    2380:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2387:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    238a:	8b 00                	mov    (%eax),%eax
    238c:	83 ec 08             	sub    $0x8,%esp
    238f:	ff 75 d8             	pushl  -0x28(%ebp)
    2392:	6a 01                	push   $0x1
    2394:	6a 0a                	push   $0xa
    2396:	50                   	push   %eax
    2397:	8d 45 c8             	lea    -0x38(%ebp),%eax
    239a:	50                   	push   %eax
    239b:	ff 75 08             	pushl  0x8(%ebp)
    239e:	e8 56 fe ff ff       	call   21f9 <sprintint>
    23a3:	83 c4 20             	add    $0x20,%esp
                ap++;
    23a6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    23aa:	e9 2a 01 00 00       	jmp    24d9 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    23af:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    23b3:	74 06                	je     23bb <sprintf+0xe0>
    23b5:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    23b9:	75 4c                	jne    2407 <sprintf+0x12c>
                buf[bi] = '\0';
    23bb:	8d 55 ce             	lea    -0x32(%ebp),%edx
    23be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23c1:	01 d0                	add    %edx,%eax
    23c3:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    23c6:	83 ec 0c             	sub    $0xc,%esp
    23c9:	8d 45 ce             	lea    -0x32(%ebp),%eax
    23cc:	50                   	push   %eax
    23cd:	e8 39 e1 ff ff       	call   50b <atoi>
    23d2:	83 c4 10             	add    $0x10,%esp
    23d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    23d8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    23df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23e2:	8b 00                	mov    (%eax),%eax
    23e4:	83 ec 08             	sub    $0x8,%esp
    23e7:	ff 75 dc             	pushl  -0x24(%ebp)
    23ea:	6a 00                	push   $0x0
    23ec:	6a 10                	push   $0x10
    23ee:	50                   	push   %eax
    23ef:	8d 45 c8             	lea    -0x38(%ebp),%eax
    23f2:	50                   	push   %eax
    23f3:	ff 75 08             	pushl  0x8(%ebp)
    23f6:	e8 fe fd ff ff       	call   21f9 <sprintint>
    23fb:	83 c4 20             	add    $0x20,%esp
                ap++;
    23fe:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2402:	e9 d2 00 00 00       	jmp    24d9 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2407:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    240b:	75 46                	jne    2453 <sprintf+0x178>
                s = (char*)*ap;
    240d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2410:	8b 00                	mov    (%eax),%eax
    2412:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2415:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    2419:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    241d:	75 25                	jne    2444 <sprintf+0x169>
                    s = "(null)";
    241f:	c7 45 f4 d0 26 00 00 	movl   $0x26d0,-0xc(%ebp)
                while(*s != 0){
    2426:	eb 1c                	jmp    2444 <sprintf+0x169>
                    dst[j++] = *s;
    2428:	8b 45 c8             	mov    -0x38(%ebp),%eax
    242b:	8d 50 01             	lea    0x1(%eax),%edx
    242e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2431:	89 c2                	mov    %eax,%edx
    2433:	8b 45 08             	mov    0x8(%ebp),%eax
    2436:	01 c2                	add    %eax,%edx
    2438:	8b 45 f4             	mov    -0xc(%ebp),%eax
    243b:	0f b6 00             	movzbl (%eax),%eax
    243e:	88 02                	mov    %al,(%edx)
                    s++;
    2440:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    2444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2447:	0f b6 00             	movzbl (%eax),%eax
    244a:	84 c0                	test   %al,%al
    244c:	75 da                	jne    2428 <sprintf+0x14d>
    244e:	e9 86 00 00 00       	jmp    24d9 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    2453:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2457:	75 1d                	jne    2476 <sprintf+0x19b>
                dst[j++] = *ap;
    2459:	8b 45 c8             	mov    -0x38(%ebp),%eax
    245c:	8d 50 01             	lea    0x1(%eax),%edx
    245f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2462:	89 c2                	mov    %eax,%edx
    2464:	8b 45 08             	mov    0x8(%ebp),%eax
    2467:	01 c2                	add    %eax,%edx
    2469:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    246c:	8b 00                	mov    (%eax),%eax
    246e:	88 02                	mov    %al,(%edx)
                ap++;
    2470:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2474:	eb 63                	jmp    24d9 <sprintf+0x1fe>
            } else if(c == '%'){
    2476:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    247a:	75 17                	jne    2493 <sprintf+0x1b8>
                dst[j++] = c;
    247c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    247f:	8d 50 01             	lea    0x1(%eax),%edx
    2482:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2485:	89 c2                	mov    %eax,%edx
    2487:	8b 45 08             	mov    0x8(%ebp),%eax
    248a:	01 d0                	add    %edx,%eax
    248c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    248f:	88 10                	mov    %dl,(%eax)
    2491:	eb 46                	jmp    24d9 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2493:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2497:	7e 18                	jle    24b1 <sprintf+0x1d6>
    2499:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    249d:	7f 12                	jg     24b1 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    249f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24a2:	8d 50 01             	lea    0x1(%eax),%edx
    24a5:	89 55 f0             	mov    %edx,-0x10(%ebp)
    24a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24ab:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    24af:	eb 2f                	jmp    24e0 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    24b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24b4:	8d 50 01             	lea    0x1(%eax),%edx
    24b7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24ba:	89 c2                	mov    %eax,%edx
    24bc:	8b 45 08             	mov    0x8(%ebp),%eax
    24bf:	01 d0                	add    %edx,%eax
    24c1:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    24c4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24c7:	8d 50 01             	lea    0x1(%eax),%edx
    24ca:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24cd:	89 c2                	mov    %eax,%edx
    24cf:	8b 45 08             	mov    0x8(%ebp),%eax
    24d2:	01 d0                	add    %edx,%eax
    24d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24d7:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    24d9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    24e0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    24e4:	8b 55 0c             	mov    0xc(%ebp),%edx
    24e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24ea:	01 d0                	add    %edx,%eax
    24ec:	0f b6 00             	movzbl (%eax),%eax
    24ef:	84 c0                	test   %al,%al
    24f1:	0f 85 14 fe ff ff    	jne    230b <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    24f7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24fa:	8d 50 01             	lea    0x1(%eax),%edx
    24fd:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2500:	89 c2                	mov    %eax,%edx
    2502:	8b 45 08             	mov    0x8(%ebp),%eax
    2505:	01 d0                	add    %edx,%eax
    2507:	c6 00 00             	movb   $0x0,(%eax)
}
    250a:	90                   	nop
    250b:	c9                   	leave  
    250c:	c3                   	ret    
