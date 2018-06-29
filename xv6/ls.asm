
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
      68:	68 b8 6a 00 00       	push   $0x6ab8
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
      9a:	05 b8 6a 00 00       	add    $0x6ab8,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 b8 6a 00 00       	mov    $0x6ab8,%eax
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
      e3:	68 b8 26 00 00       	push   $0x26b8
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
     116:	68 cc 26 00 00       	push   $0x26cc
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
     179:	68 e0 26 00 00       	push   $0x26e0
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
     1a8:	68 ed 26 00 00       	push   $0x26ed
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
     25c:	68 cc 26 00 00       	push   $0x26cc
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
     29c:	68 e0 26 00 00       	push   $0x26e0
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
     2fe:	68 00 27 00 00       	push   $0x2700
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
     6e8:	0f b6 80 60 2e 00 00 	movzbl 0x2e60(%eax),%eax
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
     826:	c7 45 f4 02 27 00 00 	movl   $0x2702,-0xc(%ebp)
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
     8ec:	a1 d0 6a 00 00       	mov    0x6ad0,%eax
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
     9b7:	a3 d0 6a 00 00       	mov    %eax,0x6ad0
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
     a18:	a1 d0 6a 00 00       	mov    0x6ad0,%eax
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
     a34:	a1 d0 6a 00 00       	mov    0x6ad0,%eax
     a39:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a3c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a40:	75 23                	jne    a65 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a42:	c7 45 f0 c8 6a 00 00 	movl   $0x6ac8,-0x10(%ebp)
     a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4c:	a3 d0 6a 00 00       	mov    %eax,0x6ad0
     a51:	a1 d0 6a 00 00       	mov    0x6ad0,%eax
     a56:	a3 c8 6a 00 00       	mov    %eax,0x6ac8
    base.s.size = 0;
     a5b:	c7 05 cc 6a 00 00 00 	movl   $0x0,0x6acc
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
     ab8:	a3 d0 6a 00 00       	mov    %eax,0x6ad0
      return (void*)(p + 1);
     abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac0:	83 c0 08             	add    $0x8,%eax
     ac3:	eb 3b                	jmp    b00 <malloc+0xe1>
    }
    if(p == freep)
     ac5:	a1 d0 6a 00 00       	mov    0x6ad0,%eax
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
     c0b:	68 09 27 00 00       	push   $0x2709
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

00000f1c <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
     f1c:	55                   	push   %ebp
     f1d:	89 e5                	mov    %esp,%ebp
     f1f:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
     f22:	8b 45 0c             	mov    0xc(%ebp),%eax
     f25:	0f b7 50 13          	movzwl 0x13(%eax),%edx
     f29:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f2d:	0f b6 40 15          	movzbl 0x15(%eax),%eax
     f31:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
     f34:	8b 45 0c             	mov    0xc(%ebp),%eax
     f37:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f3b:	66 89 50 13          	mov    %dx,0x13(%eax)
     f3f:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f43:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
     f46:	8b 45 08             	mov    0x8(%ebp),%eax
     f49:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f4d:	66 89 10             	mov    %dx,(%eax)
     f50:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f54:	88 50 02             	mov    %dl,0x2(%eax)
}
     f57:	8b 45 08             	mov    0x8(%ebp),%eax
     f5a:	c9                   	leave  
     f5b:	c2 04 00             	ret    $0x4

00000f5e <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f5e:	55                   	push   %ebp
     f5f:	89 e5                	mov    %esp,%ebp
     f61:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f64:	8b 45 08             	mov    0x8(%ebp),%eax
     f67:	8b 40 0c             	mov    0xc(%eax),%eax
     f6a:	89 c2                	mov    %eax,%edx
     f6c:	c1 ea 1f             	shr    $0x1f,%edx
     f6f:	01 d0                	add    %edx,%eax
     f71:	d1 f8                	sar    %eax
     f73:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f76:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f79:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f80:	8b 45 10             	mov    0x10(%ebp),%eax
     f83:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f86:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f89:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f8d:	0f 89 98 00 00 00    	jns    102b <APDrawPoint+0xcd>
        i = 0;
     f93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f9a:	e9 8c 00 00 00       	jmp    102b <APDrawPoint+0xcd>
    {
        j = x - off;
     f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa2:	2b 45 f4             	sub    -0xc(%ebp),%eax
     fa5:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     fa8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     fac:	79 69                	jns    1017 <APDrawPoint+0xb9>
            j = 0;
     fae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     fb5:	eb 60                	jmp    1017 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     fb7:	ff 75 fc             	pushl  -0x4(%ebp)
     fba:	ff 75 f8             	pushl  -0x8(%ebp)
     fbd:	ff 75 08             	pushl  0x8(%ebp)
     fc0:	e8 bb fb ff ff       	call   b80 <APGetIndex>
     fc5:	83 c4 0c             	add    $0xc,%esp
     fc8:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     fcb:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     fcf:	74 55                	je     1026 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     fd1:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     fd5:	74 67                	je     103e <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     fd7:	ff 75 10             	pushl  0x10(%ebp)
     fda:	ff 75 0c             	pushl  0xc(%ebp)
     fdd:	ff 75 fc             	pushl  -0x4(%ebp)
     fe0:	ff 75 f8             	pushl  -0x8(%ebp)
     fe3:	e8 5f fb ff ff       	call   b47 <distance_2>
     fe8:	83 c4 10             	add    $0x10,%esp
     feb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fee:	7f 23                	jg     1013 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     ff0:	8b 45 08             	mov    0x8(%ebp),%eax
     ff3:	8b 48 18             	mov    0x18(%eax),%ecx
     ff6:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ff9:	89 d0                	mov    %edx,%eax
     ffb:	01 c0                	add    %eax,%eax
     ffd:	01 d0                	add    %edx,%eax
     fff:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1002:	8b 45 08             	mov    0x8(%ebp),%eax
    1005:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1009:	66 89 0a             	mov    %cx,(%edx)
    100c:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    1010:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1013:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1017:	8b 55 0c             	mov    0xc(%ebp),%edx
    101a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101d:	01 d0                	add    %edx,%eax
    101f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1022:	7d 93                	jge    fb7 <APDrawPoint+0x59>
    1024:	eb 01                	jmp    1027 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1026:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1027:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    102b:	8b 55 10             	mov    0x10(%ebp),%edx
    102e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1031:	01 d0                	add    %edx,%eax
    1033:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1036:	0f 8d 63 ff ff ff    	jge    f9f <APDrawPoint+0x41>
    103c:	eb 01                	jmp    103f <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    103e:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    103f:	c9                   	leave  
    1040:	c3                   	ret    

00001041 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    1041:	55                   	push   %ebp
    1042:	89 e5                	mov    %esp,%ebp
    1044:	53                   	push   %ebx
    1045:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1048:	8b 45 0c             	mov    0xc(%ebp),%eax
    104b:	3b 45 14             	cmp    0x14(%ebp),%eax
    104e:	0f 85 80 00 00 00    	jne    10d4 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1054:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1058:	0f 88 9d 02 00 00    	js     12fb <APDrawLine+0x2ba>
    105e:	8b 45 08             	mov    0x8(%ebp),%eax
    1061:	8b 00                	mov    (%eax),%eax
    1063:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1066:	0f 8e 8f 02 00 00    	jle    12fb <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    106c:	8b 45 10             	mov    0x10(%ebp),%eax
    106f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1072:	7e 12                	jle    1086 <APDrawLine+0x45>
        {
            int tmp = y2;
    1074:	8b 45 18             	mov    0x18(%ebp),%eax
    1077:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    107a:	8b 45 10             	mov    0x10(%ebp),%eax
    107d:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    1080:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1083:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1086:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    108a:	79 07                	jns    1093 <APDrawLine+0x52>
    108c:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1093:	8b 45 08             	mov    0x8(%ebp),%eax
    1096:	8b 40 04             	mov    0x4(%eax),%eax
    1099:	3b 45 18             	cmp    0x18(%ebp),%eax
    109c:	7d 0c                	jge    10aa <APDrawLine+0x69>
    109e:	8b 45 08             	mov    0x8(%ebp),%eax
    10a1:	8b 40 04             	mov    0x4(%eax),%eax
    10a4:	83 e8 01             	sub    $0x1,%eax
    10a7:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    10aa:	8b 45 10             	mov    0x10(%ebp),%eax
    10ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10b0:	eb 15                	jmp    10c7 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    10b2:	ff 75 f4             	pushl  -0xc(%ebp)
    10b5:	ff 75 0c             	pushl  0xc(%ebp)
    10b8:	ff 75 08             	pushl  0x8(%ebp)
    10bb:	e8 9e fe ff ff       	call   f5e <APDrawPoint>
    10c0:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10c3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ca:	3b 45 18             	cmp    0x18(%ebp),%eax
    10cd:	7e e3                	jle    10b2 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10cf:	e9 2b 02 00 00       	jmp    12ff <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10d4:	8b 45 10             	mov    0x10(%ebp),%eax
    10d7:	3b 45 18             	cmp    0x18(%ebp),%eax
    10da:	75 7f                	jne    115b <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    10dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10e0:	0f 88 18 02 00 00    	js     12fe <APDrawLine+0x2bd>
    10e6:	8b 45 08             	mov    0x8(%ebp),%eax
    10e9:	8b 40 04             	mov    0x4(%eax),%eax
    10ec:	3b 45 10             	cmp    0x10(%ebp),%eax
    10ef:	0f 8e 09 02 00 00    	jle    12fe <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f8:	3b 45 14             	cmp    0x14(%ebp),%eax
    10fb:	7e 12                	jle    110f <APDrawLine+0xce>
        {
            int tmp = x2;
    10fd:	8b 45 14             	mov    0x14(%ebp),%eax
    1100:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1103:	8b 45 0c             	mov    0xc(%ebp),%eax
    1106:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1109:	8b 45 d8             	mov    -0x28(%ebp),%eax
    110c:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    110f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1113:	79 07                	jns    111c <APDrawLine+0xdb>
    1115:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    111c:	8b 45 08             	mov    0x8(%ebp),%eax
    111f:	8b 00                	mov    (%eax),%eax
    1121:	3b 45 14             	cmp    0x14(%ebp),%eax
    1124:	7d 0b                	jge    1131 <APDrawLine+0xf0>
    1126:	8b 45 08             	mov    0x8(%ebp),%eax
    1129:	8b 00                	mov    (%eax),%eax
    112b:	83 e8 01             	sub    $0x1,%eax
    112e:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    1131:	8b 45 0c             	mov    0xc(%ebp),%eax
    1134:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1137:	eb 15                	jmp    114e <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1139:	ff 75 10             	pushl  0x10(%ebp)
    113c:	ff 75 f0             	pushl  -0x10(%ebp)
    113f:	ff 75 08             	pushl  0x8(%ebp)
    1142:	e8 17 fe ff ff       	call   f5e <APDrawPoint>
    1147:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    114a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    114e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1151:	3b 45 14             	cmp    0x14(%ebp),%eax
    1154:	7e e3                	jle    1139 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1156:	e9 a4 01 00 00       	jmp    12ff <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    115b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1162:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1169:	8b 45 0c             	mov    0xc(%ebp),%eax
    116c:	2b 45 14             	sub    0x14(%ebp),%eax
    116f:	50                   	push   %eax
    1170:	e8 fb f9 ff ff       	call   b70 <abs_int>
    1175:	83 c4 04             	add    $0x4,%esp
    1178:	89 c3                	mov    %eax,%ebx
    117a:	8b 45 10             	mov    0x10(%ebp),%eax
    117d:	2b 45 18             	sub    0x18(%ebp),%eax
    1180:	50                   	push   %eax
    1181:	e8 ea f9 ff ff       	call   b70 <abs_int>
    1186:	83 c4 04             	add    $0x4,%esp
    1189:	39 c3                	cmp    %eax,%ebx
    118b:	0f 8e b5 00 00 00    	jle    1246 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    1191:	8b 45 10             	mov    0x10(%ebp),%eax
    1194:	2b 45 18             	sub    0x18(%ebp),%eax
    1197:	89 45 b0             	mov    %eax,-0x50(%ebp)
    119a:	db 45 b0             	fildl  -0x50(%ebp)
    119d:	8b 45 0c             	mov    0xc(%ebp),%eax
    11a0:	2b 45 14             	sub    0x14(%ebp),%eax
    11a3:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11a6:	db 45 b0             	fildl  -0x50(%ebp)
    11a9:	de f9                	fdivrp %st,%st(1)
    11ab:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    11ae:	8b 45 14             	mov    0x14(%ebp),%eax
    11b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11b4:	7e 0e                	jle    11c4 <APDrawLine+0x183>
        {
            s = x1;
    11b6:	8b 45 0c             	mov    0xc(%ebp),%eax
    11b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    11bc:	8b 45 14             	mov    0x14(%ebp),%eax
    11bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11c2:	eb 0c                	jmp    11d0 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11c4:	8b 45 14             	mov    0x14(%ebp),%eax
    11c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cd:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11d4:	79 07                	jns    11dd <APDrawLine+0x19c>
    11d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    11dd:	8b 45 08             	mov    0x8(%ebp),%eax
    11e0:	8b 00                	mov    (%eax),%eax
    11e2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11e5:	7f 0b                	jg     11f2 <APDrawLine+0x1b1>
    11e7:	8b 45 08             	mov    0x8(%ebp),%eax
    11ea:	8b 00                	mov    (%eax),%eax
    11ec:	83 e8 01             	sub    $0x1,%eax
    11ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11f8:	eb 3f                	jmp    1239 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11fd:	2b 45 0c             	sub    0xc(%ebp),%eax
    1200:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1203:	db 45 b0             	fildl  -0x50(%ebp)
    1206:	dc 4d d0             	fmull  -0x30(%ebp)
    1209:	db 45 10             	fildl  0x10(%ebp)
    120c:	de c1                	faddp  %st,%st(1)
    120e:	d9 7d b6             	fnstcw -0x4a(%ebp)
    1211:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1215:	b4 0c                	mov    $0xc,%ah
    1217:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    121b:	d9 6d b4             	fldcw  -0x4c(%ebp)
    121e:	db 5d cc             	fistpl -0x34(%ebp)
    1221:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1224:	ff 75 cc             	pushl  -0x34(%ebp)
    1227:	ff 75 e4             	pushl  -0x1c(%ebp)
    122a:	ff 75 08             	pushl  0x8(%ebp)
    122d:	e8 2c fd ff ff       	call   f5e <APDrawPoint>
    1232:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1235:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1239:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    123c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    123f:	7e b9                	jle    11fa <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    1241:	e9 b9 00 00 00       	jmp    12ff <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1246:	8b 45 0c             	mov    0xc(%ebp),%eax
    1249:	2b 45 14             	sub    0x14(%ebp),%eax
    124c:	89 45 b0             	mov    %eax,-0x50(%ebp)
    124f:	db 45 b0             	fildl  -0x50(%ebp)
    1252:	8b 45 10             	mov    0x10(%ebp),%eax
    1255:	2b 45 18             	sub    0x18(%ebp),%eax
    1258:	89 45 b0             	mov    %eax,-0x50(%ebp)
    125b:	db 45 b0             	fildl  -0x50(%ebp)
    125e:	de f9                	fdivrp %st,%st(1)
    1260:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1263:	8b 45 10             	mov    0x10(%ebp),%eax
    1266:	3b 45 18             	cmp    0x18(%ebp),%eax
    1269:	7e 0e                	jle    1279 <APDrawLine+0x238>
    {
        s = y2;
    126b:	8b 45 18             	mov    0x18(%ebp),%eax
    126e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    1271:	8b 45 10             	mov    0x10(%ebp),%eax
    1274:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1277:	eb 0c                	jmp    1285 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1279:	8b 45 10             	mov    0x10(%ebp),%eax
    127c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    127f:	8b 45 18             	mov    0x18(%ebp),%eax
    1282:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1285:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1289:	79 07                	jns    1292 <APDrawLine+0x251>
    128b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1292:	8b 45 08             	mov    0x8(%ebp),%eax
    1295:	8b 40 04             	mov    0x4(%eax),%eax
    1298:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    129b:	7f 0c                	jg     12a9 <APDrawLine+0x268>
    129d:	8b 45 08             	mov    0x8(%ebp),%eax
    12a0:	8b 40 04             	mov    0x4(%eax),%eax
    12a3:	83 e8 01             	sub    $0x1,%eax
    12a6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    12a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12ac:	89 45 e0             	mov    %eax,-0x20(%ebp)
    12af:	eb 3f                	jmp    12f0 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    12b1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12b4:	2b 45 10             	sub    0x10(%ebp),%eax
    12b7:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12ba:	db 45 b0             	fildl  -0x50(%ebp)
    12bd:	dc 4d c0             	fmull  -0x40(%ebp)
    12c0:	db 45 0c             	fildl  0xc(%ebp)
    12c3:	de c1                	faddp  %st,%st(1)
    12c5:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12c8:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12cc:	b4 0c                	mov    $0xc,%ah
    12ce:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12d2:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12d5:	db 5d bc             	fistpl -0x44(%ebp)
    12d8:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    12db:	ff 75 e0             	pushl  -0x20(%ebp)
    12de:	ff 75 bc             	pushl  -0x44(%ebp)
    12e1:	ff 75 08             	pushl  0x8(%ebp)
    12e4:	e8 75 fc ff ff       	call   f5e <APDrawPoint>
    12e9:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12ec:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12f3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12f6:	7e b9                	jle    12b1 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12f8:	90                   	nop
    12f9:	eb 04                	jmp    12ff <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12fb:	90                   	nop
    12fc:	eb 01                	jmp    12ff <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12fe:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1302:	c9                   	leave  
    1303:	c3                   	ret    

00001304 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1304:	55                   	push   %ebp
    1305:	89 e5                	mov    %esp,%ebp
    1307:	53                   	push   %ebx
    1308:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    130b:	8b 55 10             	mov    0x10(%ebp),%edx
    130e:	8b 45 18             	mov    0x18(%ebp),%eax
    1311:	01 d0                	add    %edx,%eax
    1313:	83 e8 01             	sub    $0x1,%eax
    1316:	83 ec 04             	sub    $0x4,%esp
    1319:	50                   	push   %eax
    131a:	ff 75 0c             	pushl  0xc(%ebp)
    131d:	ff 75 10             	pushl  0x10(%ebp)
    1320:	ff 75 0c             	pushl  0xc(%ebp)
    1323:	ff 75 08             	pushl  0x8(%ebp)
    1326:	e8 16 fd ff ff       	call   1041 <APDrawLine>
    132b:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    132e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1331:	8b 45 14             	mov    0x14(%ebp),%eax
    1334:	01 d0                	add    %edx,%eax
    1336:	83 e8 01             	sub    $0x1,%eax
    1339:	83 ec 04             	sub    $0x4,%esp
    133c:	ff 75 10             	pushl  0x10(%ebp)
    133f:	50                   	push   %eax
    1340:	ff 75 10             	pushl  0x10(%ebp)
    1343:	ff 75 0c             	pushl  0xc(%ebp)
    1346:	ff 75 08             	pushl  0x8(%ebp)
    1349:	e8 f3 fc ff ff       	call   1041 <APDrawLine>
    134e:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    1351:	8b 55 10             	mov    0x10(%ebp),%edx
    1354:	8b 45 18             	mov    0x18(%ebp),%eax
    1357:	01 d0                	add    %edx,%eax
    1359:	8d 48 ff             	lea    -0x1(%eax),%ecx
    135c:	8b 55 0c             	mov    0xc(%ebp),%edx
    135f:	8b 45 14             	mov    0x14(%ebp),%eax
    1362:	01 d0                	add    %edx,%eax
    1364:	8d 50 ff             	lea    -0x1(%eax),%edx
    1367:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    136a:	8b 45 14             	mov    0x14(%ebp),%eax
    136d:	01 d8                	add    %ebx,%eax
    136f:	83 e8 01             	sub    $0x1,%eax
    1372:	83 ec 04             	sub    $0x4,%esp
    1375:	51                   	push   %ecx
    1376:	52                   	push   %edx
    1377:	ff 75 10             	pushl  0x10(%ebp)
    137a:	50                   	push   %eax
    137b:	ff 75 08             	pushl  0x8(%ebp)
    137e:	e8 be fc ff ff       	call   1041 <APDrawLine>
    1383:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1386:	8b 55 10             	mov    0x10(%ebp),%edx
    1389:	8b 45 18             	mov    0x18(%ebp),%eax
    138c:	01 d0                	add    %edx,%eax
    138e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1391:	8b 55 0c             	mov    0xc(%ebp),%edx
    1394:	8b 45 14             	mov    0x14(%ebp),%eax
    1397:	01 d0                	add    %edx,%eax
    1399:	8d 50 ff             	lea    -0x1(%eax),%edx
    139c:	8b 5d 10             	mov    0x10(%ebp),%ebx
    139f:	8b 45 18             	mov    0x18(%ebp),%eax
    13a2:	01 d8                	add    %ebx,%eax
    13a4:	83 e8 01             	sub    $0x1,%eax
    13a7:	83 ec 04             	sub    $0x4,%esp
    13aa:	51                   	push   %ecx
    13ab:	52                   	push   %edx
    13ac:	50                   	push   %eax
    13ad:	ff 75 0c             	pushl  0xc(%ebp)
    13b0:	ff 75 08             	pushl  0x8(%ebp)
    13b3:	e8 89 fc ff ff       	call   1041 <APDrawLine>
    13b8:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    13bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    13be:	8b 45 14             	mov    0x14(%ebp),%eax
    13c1:	01 d0                	add    %edx,%eax
    13c3:	8d 50 ff             	lea    -0x1(%eax),%edx
    13c6:	8b 45 08             	mov    0x8(%ebp),%eax
    13c9:	8b 40 0c             	mov    0xc(%eax),%eax
    13cc:	89 c1                	mov    %eax,%ecx
    13ce:	c1 e9 1f             	shr    $0x1f,%ecx
    13d1:	01 c8                	add    %ecx,%eax
    13d3:	d1 f8                	sar    %eax
    13d5:	29 c2                	sub    %eax,%edx
    13d7:	89 d0                	mov    %edx,%eax
    13d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    13dc:	8b 55 10             	mov    0x10(%ebp),%edx
    13df:	8b 45 18             	mov    0x18(%ebp),%eax
    13e2:	01 d0                	add    %edx,%eax
    13e4:	8d 50 ff             	lea    -0x1(%eax),%edx
    13e7:	8b 45 08             	mov    0x8(%ebp),%eax
    13ea:	8b 40 0c             	mov    0xc(%eax),%eax
    13ed:	89 c1                	mov    %eax,%ecx
    13ef:	c1 e9 1f             	shr    $0x1f,%ecx
    13f2:	01 c8                	add    %ecx,%eax
    13f4:	d1 f8                	sar    %eax
    13f6:	29 c2                	sub    %eax,%edx
    13f8:	89 d0                	mov    %edx,%eax
    13fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1400:	8b 40 0c             	mov    0xc(%eax),%eax
    1403:	89 c2                	mov    %eax,%edx
    1405:	c1 ea 1f             	shr    $0x1f,%edx
    1408:	01 d0                	add    %edx,%eax
    140a:	d1 f8                	sar    %eax
    140c:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    140f:	8b 45 08             	mov    0x8(%ebp),%eax
    1412:	8b 40 0c             	mov    0xc(%eax),%eax
    1415:	89 c2                	mov    %eax,%edx
    1417:	c1 ea 1f             	shr    $0x1f,%edx
    141a:	01 d0                	add    %edx,%eax
    141c:	d1 f8                	sar    %eax
    141e:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    1421:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1425:	0f 88 d8 00 00 00    	js     1503 <APDrawRect+0x1ff>
    142b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    142f:	0f 88 ce 00 00 00    	js     1503 <APDrawRect+0x1ff>
    1435:	8b 45 08             	mov    0x8(%ebp),%eax
    1438:	8b 00                	mov    (%eax),%eax
    143a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    143d:	0f 8e c0 00 00 00    	jle    1503 <APDrawRect+0x1ff>
    1443:	8b 45 08             	mov    0x8(%ebp),%eax
    1446:	8b 40 04             	mov    0x4(%eax),%eax
    1449:	3b 45 10             	cmp    0x10(%ebp),%eax
    144c:	0f 8e b1 00 00 00    	jle    1503 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1452:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1456:	79 07                	jns    145f <APDrawRect+0x15b>
    1458:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    145f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1463:	79 07                	jns    146c <APDrawRect+0x168>
    1465:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    146c:	8b 45 08             	mov    0x8(%ebp),%eax
    146f:	8b 00                	mov    (%eax),%eax
    1471:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1474:	7f 0b                	jg     1481 <APDrawRect+0x17d>
    1476:	8b 45 08             	mov    0x8(%ebp),%eax
    1479:	8b 00                	mov    (%eax),%eax
    147b:	83 e8 01             	sub    $0x1,%eax
    147e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    1481:	8b 45 08             	mov    0x8(%ebp),%eax
    1484:	8b 40 04             	mov    0x4(%eax),%eax
    1487:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    148a:	7f 0c                	jg     1498 <APDrawRect+0x194>
    148c:	8b 45 08             	mov    0x8(%ebp),%eax
    148f:	8b 40 04             	mov    0x4(%eax),%eax
    1492:	83 e8 01             	sub    $0x1,%eax
    1495:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1498:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    149f:	8b 45 0c             	mov    0xc(%ebp),%eax
    14a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14a5:	eb 52                	jmp    14f9 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    14a7:	8b 45 10             	mov    0x10(%ebp),%eax
    14aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14ad:	eb 3e                	jmp    14ed <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    14af:	83 ec 04             	sub    $0x4,%esp
    14b2:	ff 75 e8             	pushl  -0x18(%ebp)
    14b5:	ff 75 ec             	pushl  -0x14(%ebp)
    14b8:	ff 75 08             	pushl  0x8(%ebp)
    14bb:	e8 c0 f6 ff ff       	call   b80 <APGetIndex>
    14c0:	83 c4 10             	add    $0x10,%esp
    14c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14c6:	8b 45 08             	mov    0x8(%ebp),%eax
    14c9:	8b 48 18             	mov    0x18(%eax),%ecx
    14cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14cf:	89 d0                	mov    %edx,%eax
    14d1:	01 c0                	add    %eax,%eax
    14d3:	01 d0                	add    %edx,%eax
    14d5:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14d8:	8b 45 08             	mov    0x8(%ebp),%eax
    14db:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    14df:	66 89 0a             	mov    %cx,(%edx)
    14e2:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14e6:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14e9:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14f0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14f3:	7e ba                	jle    14af <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14f5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14ff:	7e a6                	jle    14a7 <APDrawRect+0x1a3>
    1501:	eb 01                	jmp    1504 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1503:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1504:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1507:	c9                   	leave  
    1508:	c3                   	ret    

00001509 <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    1509:	55                   	push   %ebp
    150a:	89 e5                	mov    %esp,%ebp
    150c:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    150f:	83 ec 0c             	sub    $0xc,%esp
    1512:	ff 75 0c             	pushl  0xc(%ebp)
    1515:	e8 c1 ee ff ff       	call   3db <strlen>
    151a:	83 c4 10             	add    $0x10,%esp
    151d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    1520:	8b 45 08             	mov    0x8(%ebp),%eax
    1523:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    1527:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    152b:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    152f:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    1532:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    1539:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1540:	e9 bc 00 00 00       	jmp    1601 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    1545:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1548:	8b 45 0c             	mov    0xc(%ebp),%eax
    154b:	01 d0                	add    %edx,%eax
    154d:	0f b6 00             	movzbl (%eax),%eax
    1550:	0f be c0             	movsbl %al,%eax
    1553:	83 e8 20             	sub    $0x20,%eax
    1556:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    1559:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    155d:	0f 87 9a 00 00 00    	ja     15fd <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    1563:	8b 45 08             	mov    0x8(%ebp),%eax
    1566:	8b 00                	mov    (%eax),%eax
    1568:	0f af 45 14          	imul   0x14(%ebp),%eax
    156c:	89 c2                	mov    %eax,%edx
    156e:	8b 45 10             	mov    0x10(%ebp),%eax
    1571:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    1574:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1577:	89 d0                	mov    %edx,%eax
    1579:	c1 e0 03             	shl    $0x3,%eax
    157c:	01 d0                	add    %edx,%eax
    157e:	01 c8                	add    %ecx,%eax
    1580:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    1583:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    158a:	eb 6b                	jmp    15f7 <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    158c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1593:	eb 50                	jmp    15e5 <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    1595:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1598:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    159b:	89 d0                	mov    %edx,%eax
    159d:	c1 e0 03             	shl    $0x3,%eax
    15a0:	01 d0                	add    %edx,%eax
    15a2:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    15a8:	01 c2                	add    %eax,%edx
    15aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15ad:	01 d0                	add    %edx,%eax
    15af:	05 80 2e 00 00       	add    $0x2e80,%eax
    15b4:	0f b6 00             	movzbl (%eax),%eax
    15b7:	84 c0                	test   %al,%al
    15b9:	74 26                	je     15e1 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    15bb:	8b 45 08             	mov    0x8(%ebp),%eax
    15be:	8b 50 18             	mov    0x18(%eax),%edx
    15c1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    15c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c7:	01 c8                	add    %ecx,%eax
    15c9:	89 c1                	mov    %eax,%ecx
    15cb:	89 c8                	mov    %ecx,%eax
    15cd:	01 c0                	add    %eax,%eax
    15cf:	01 c8                	add    %ecx,%eax
    15d1:	01 d0                	add    %edx,%eax
    15d3:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    15d7:	66 89 10             	mov    %dx,(%eax)
    15da:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    15de:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    15e1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    15e5:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    15e9:	7e aa                	jle    1595 <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    15eb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ee:	8b 00                	mov    (%eax),%eax
    15f0:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    15f3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    15f7:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    15fb:	7e 8f                	jle    158c <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    15fd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1601:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1604:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1607:	0f 82 38 ff ff ff    	jb     1545 <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    160d:	90                   	nop
    160e:	c9                   	leave  
    160f:	c3                   	ret    

00001610 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1610:	55                   	push   %ebp
    1611:	89 e5                	mov    %esp,%ebp
    1613:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    1616:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    161a:	0f 88 8e 01 00 00    	js     17ae <APDcCopy+0x19e>
    1620:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    1624:	0f 88 84 01 00 00    	js     17ae <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    162a:	8b 55 0c             	mov    0xc(%ebp),%edx
    162d:	8b 45 20             	mov    0x20(%ebp),%eax
    1630:	01 d0                	add    %edx,%eax
    1632:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1635:	8b 55 10             	mov    0x10(%ebp),%edx
    1638:	8b 45 24             	mov    0x24(%ebp),%eax
    163b:	01 d0                	add    %edx,%eax
    163d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    1640:	8b 55 18             	mov    0x18(%ebp),%edx
    1643:	8b 45 20             	mov    0x20(%ebp),%eax
    1646:	01 d0                	add    %edx,%eax
    1648:	89 45 ec             	mov    %eax,-0x14(%ebp)
    164b:	8b 55 1c             	mov    0x1c(%ebp),%edx
    164e:	8b 45 24             	mov    0x24(%ebp),%eax
    1651:	01 d0                	add    %edx,%eax
    1653:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    1656:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    165a:	0f 88 51 01 00 00    	js     17b1 <APDcCopy+0x1a1>
    1660:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1664:	0f 88 47 01 00 00    	js     17b1 <APDcCopy+0x1a1>
    166a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    166e:	0f 88 3d 01 00 00    	js     17b1 <APDcCopy+0x1a1>
    1674:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1678:	0f 88 33 01 00 00    	js     17b1 <APDcCopy+0x1a1>
    167e:	8b 45 14             	mov    0x14(%ebp),%eax
    1681:	8b 00                	mov    (%eax),%eax
    1683:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1686:	0f 8c 25 01 00 00    	jl     17b1 <APDcCopy+0x1a1>
    168c:	8b 45 14             	mov    0x14(%ebp),%eax
    168f:	8b 40 04             	mov    0x4(%eax),%eax
    1692:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1695:	0f 8c 16 01 00 00    	jl     17b1 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    169b:	8b 45 08             	mov    0x8(%ebp),%eax
    169e:	8b 00                	mov    (%eax),%eax
    16a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16a3:	7f 0b                	jg     16b0 <APDcCopy+0xa0>
    16a5:	8b 45 08             	mov    0x8(%ebp),%eax
    16a8:	8b 00                	mov    (%eax),%eax
    16aa:	83 e8 01             	sub    $0x1,%eax
    16ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    16b0:	8b 45 08             	mov    0x8(%ebp),%eax
    16b3:	8b 40 04             	mov    0x4(%eax),%eax
    16b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16b9:	7f 0c                	jg     16c7 <APDcCopy+0xb7>
    16bb:	8b 45 08             	mov    0x8(%ebp),%eax
    16be:	8b 40 04             	mov    0x4(%eax),%eax
    16c1:	83 e8 01             	sub    $0x1,%eax
    16c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    16c7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    16ce:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    16d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16dc:	e9 bc 00 00 00       	jmp    179d <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    16e1:	8b 45 08             	mov    0x8(%ebp),%eax
    16e4:	8b 00                	mov    (%eax),%eax
    16e6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16e9:	8b 55 10             	mov    0x10(%ebp),%edx
    16ec:	01 ca                	add    %ecx,%edx
    16ee:	0f af d0             	imul   %eax,%edx
    16f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    16f4:	01 d0                	add    %edx,%eax
    16f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    16f9:	8b 45 14             	mov    0x14(%ebp),%eax
    16fc:	8b 00                	mov    (%eax),%eax
    16fe:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1701:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1704:	01 ca                	add    %ecx,%edx
    1706:	0f af d0             	imul   %eax,%edx
    1709:	8b 45 18             	mov    0x18(%ebp),%eax
    170c:	01 d0                	add    %edx,%eax
    170e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    1711:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1718:	eb 74                	jmp    178e <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    171a:	8b 45 14             	mov    0x14(%ebp),%eax
    171d:	8b 50 18             	mov    0x18(%eax),%edx
    1720:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1723:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1726:	01 c8                	add    %ecx,%eax
    1728:	89 c1                	mov    %eax,%ecx
    172a:	89 c8                	mov    %ecx,%eax
    172c:	01 c0                	add    %eax,%eax
    172e:	01 c8                	add    %ecx,%eax
    1730:	01 d0                	add    %edx,%eax
    1732:	0f b7 10             	movzwl (%eax),%edx
    1735:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1739:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    173d:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1740:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1744:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    1748:	38 c2                	cmp    %al,%dl
    174a:	75 18                	jne    1764 <APDcCopy+0x154>
    174c:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1750:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    1754:	38 c2                	cmp    %al,%dl
    1756:	75 0c                	jne    1764 <APDcCopy+0x154>
    1758:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    175c:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1760:	38 c2                	cmp    %al,%dl
    1762:	74 26                	je     178a <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    1764:	8b 45 08             	mov    0x8(%ebp),%eax
    1767:	8b 50 18             	mov    0x18(%eax),%edx
    176a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    176d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1770:	01 c8                	add    %ecx,%eax
    1772:	89 c1                	mov    %eax,%ecx
    1774:	89 c8                	mov    %ecx,%eax
    1776:	01 c0                	add    %eax,%eax
    1778:	01 c8                	add    %ecx,%eax
    177a:	01 d0                	add    %edx,%eax
    177c:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1780:	66 89 10             	mov    %dx,(%eax)
    1783:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    1787:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    178a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    178e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1791:	2b 45 0c             	sub    0xc(%ebp),%eax
    1794:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1797:	7d 81                	jge    171a <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    1799:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    179d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a0:	2b 45 10             	sub    0x10(%ebp),%eax
    17a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    17a6:	0f 8d 35 ff ff ff    	jge    16e1 <APDcCopy+0xd1>
    17ac:	eb 04                	jmp    17b2 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    17ae:	90                   	nop
    17af:	eb 01                	jmp    17b2 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    17b1:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    17b2:	c9                   	leave  
    17b3:	c3                   	ret    

000017b4 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    17b4:	55                   	push   %ebp
    17b5:	89 e5                	mov    %esp,%ebp
    17b7:	83 ec 1c             	sub    $0x1c,%esp
    17ba:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    17bd:	8b 55 10             	mov    0x10(%ebp),%edx
    17c0:	8b 45 14             	mov    0x14(%ebp),%eax
    17c3:	88 4d ec             	mov    %cl,-0x14(%ebp)
    17c6:	88 55 e8             	mov    %dl,-0x18(%ebp)
    17c9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    17cc:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    17d0:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    17d3:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    17d7:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    17da:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    17de:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    17e1:	8b 45 08             	mov    0x8(%ebp),%eax
    17e4:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    17e8:	66 89 10             	mov    %dx,(%eax)
    17eb:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    17ef:	88 50 02             	mov    %dl,0x2(%eax)
}
    17f2:	8b 45 08             	mov    0x8(%ebp),%eax
    17f5:	c9                   	leave  
    17f6:	c2 04 00             	ret    $0x4

000017f9 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    17f9:	55                   	push   %ebp
    17fa:	89 e5                	mov    %esp,%ebp
    17fc:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    17ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1802:	8b 00                	mov    (%eax),%eax
    1804:	83 ec 08             	sub    $0x8,%esp
    1807:	8d 55 0c             	lea    0xc(%ebp),%edx
    180a:	52                   	push   %edx
    180b:	50                   	push   %eax
    180c:	e8 34 ee ff ff       	call   645 <sendMessage>
    1811:	83 c4 10             	add    $0x10,%esp
}
    1814:	90                   	nop
    1815:	c9                   	leave  
    1816:	c3                   	ret    

00001817 <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    1817:	55                   	push   %ebp
    1818:	89 e5                	mov    %esp,%ebp
    181a:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    181d:	83 ec 0c             	sub    $0xc,%esp
    1820:	68 98 00 00 00       	push   $0x98
    1825:	e8 f5 f1 ff ff       	call   a1f <malloc>
    182a:	83 c4 10             	add    $0x10,%esp
    182d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1830:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1834:	75 15                	jne    184b <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    1836:	83 ec 04             	sub    $0x4,%esp
    1839:	ff 75 08             	pushl  0x8(%ebp)
    183c:	68 1c 27 00 00       	push   $0x271c
    1841:	6a 01                	push   $0x1
    1843:	e8 04 ef ff ff       	call   74c <printf>
    1848:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    184b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    184e:	05 84 00 00 00       	add    $0x84,%eax
    1853:	83 ec 08             	sub    $0x8,%esp
    1856:	ff 75 08             	pushl  0x8(%ebp)
    1859:	50                   	push   %eax
    185a:	e8 0d eb ff ff       	call   36c <strcpy>
    185f:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1862:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1865:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    186c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    186f:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1876:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1879:	8b 40 3c             	mov    0x3c(%eax),%eax
    187c:	89 c2                	mov    %eax,%edx
    187e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1881:	8b 40 40             	mov    0x40(%eax),%eax
    1884:	0f af d0             	imul   %eax,%edx
    1887:	89 d0                	mov    %edx,%eax
    1889:	01 c0                	add    %eax,%eax
    188b:	01 d0                	add    %edx,%eax
    188d:	83 ec 0c             	sub    $0xc,%esp
    1890:	50                   	push   %eax
    1891:	e8 89 f1 ff ff       	call   a1f <malloc>
    1896:	83 c4 10             	add    $0x10,%esp
    1899:	89 c2                	mov    %eax,%edx
    189b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189e:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    18a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a4:	8b 40 54             	mov    0x54(%eax),%eax
    18a7:	85 c0                	test   %eax,%eax
    18a9:	75 15                	jne    18c0 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    18ab:	83 ec 04             	sub    $0x4,%esp
    18ae:	ff 75 08             	pushl  0x8(%ebp)
    18b1:	68 3c 27 00 00       	push   $0x273c
    18b6:	6a 01                	push   $0x1
    18b8:	e8 8f ee ff ff       	call   74c <printf>
    18bd:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    18c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c3:	8b 40 3c             	mov    0x3c(%eax),%eax
    18c6:	89 c2                	mov    %eax,%edx
    18c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cb:	8b 40 40             	mov    0x40(%eax),%eax
    18ce:	0f af d0             	imul   %eax,%edx
    18d1:	89 d0                	mov    %edx,%eax
    18d3:	01 c0                	add    %eax,%eax
    18d5:	01 c2                	add    %eax,%edx
    18d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18da:	8b 40 54             	mov    0x54(%eax),%eax
    18dd:	83 ec 04             	sub    $0x4,%esp
    18e0:	52                   	push   %edx
    18e1:	68 ff ff ff 00       	push   $0xffffff
    18e6:	50                   	push   %eax
    18e7:	e8 16 eb ff ff       	call   402 <memset>
    18ec:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    18ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f2:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    18f9:	e8 1f ed ff ff       	call   61d <getpid>
    18fe:	89 c2                	mov    %eax,%edx
    1900:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1903:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    1906:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1909:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1910:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1913:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    191a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191d:	8b 40 58             	mov    0x58(%eax),%eax
    1920:	89 c2                	mov    %eax,%edx
    1922:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1925:	8b 40 5c             	mov    0x5c(%eax),%eax
    1928:	0f af d0             	imul   %eax,%edx
    192b:	89 d0                	mov    %edx,%eax
    192d:	01 c0                	add    %eax,%eax
    192f:	01 d0                	add    %edx,%eax
    1931:	83 ec 0c             	sub    $0xc,%esp
    1934:	50                   	push   %eax
    1935:	e8 e5 f0 ff ff       	call   a1f <malloc>
    193a:	83 c4 10             	add    $0x10,%esp
    193d:	89 c2                	mov    %eax,%edx
    193f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1942:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    1945:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1948:	8b 40 70             	mov    0x70(%eax),%eax
    194b:	85 c0                	test   %eax,%eax
    194d:	75 15                	jne    1964 <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    194f:	83 ec 04             	sub    $0x4,%esp
    1952:	ff 75 08             	pushl  0x8(%ebp)
    1955:	68 60 27 00 00       	push   $0x2760
    195a:	6a 01                	push   $0x1
    195c:	e8 eb ed ff ff       	call   74c <printf>
    1961:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1964:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1967:	8b 40 3c             	mov    0x3c(%eax),%eax
    196a:	89 c2                	mov    %eax,%edx
    196c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    196f:	8b 40 40             	mov    0x40(%eax),%eax
    1972:	0f af d0             	imul   %eax,%edx
    1975:	89 d0                	mov    %edx,%eax
    1977:	01 c0                	add    %eax,%eax
    1979:	01 c2                	add    %eax,%edx
    197b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197e:	8b 40 54             	mov    0x54(%eax),%eax
    1981:	83 ec 04             	sub    $0x4,%esp
    1984:	52                   	push   %edx
    1985:	68 ff 00 00 00       	push   $0xff
    198a:	50                   	push   %eax
    198b:	e8 72 ea ff ff       	call   402 <memset>
    1990:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1993:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1996:	8b 55 0c             	mov    0xc(%ebp),%edx
    1999:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    199c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19a0:	74 49                	je     19eb <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    19a2:	8b 45 10             	mov    0x10(%ebp),%eax
    19a5:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    19ab:	83 ec 0c             	sub    $0xc,%esp
    19ae:	50                   	push   %eax
    19af:	e8 6b f0 ff ff       	call   a1f <malloc>
    19b4:	83 c4 10             	add    $0x10,%esp
    19b7:	89 c2                	mov    %eax,%edx
    19b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19bc:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    19bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c2:	8b 55 10             	mov    0x10(%ebp),%edx
    19c5:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    19c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19cb:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    19d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d5:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    19dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19df:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    19e6:	e9 8d 00 00 00       	jmp    1a78 <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    19eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ee:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    19f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f8:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    19ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a02:	8b 40 20             	mov    0x20(%eax),%eax
    1a05:	89 c2                	mov    %eax,%edx
    1a07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0a:	8b 40 24             	mov    0x24(%eax),%eax
    1a0d:	0f af d0             	imul   %eax,%edx
    1a10:	89 d0                	mov    %edx,%eax
    1a12:	01 c0                	add    %eax,%eax
    1a14:	01 d0                	add    %edx,%eax
    1a16:	83 ec 0c             	sub    $0xc,%esp
    1a19:	50                   	push   %eax
    1a1a:	e8 00 f0 ff ff       	call   a1f <malloc>
    1a1f:	83 c4 10             	add    $0x10,%esp
    1a22:	89 c2                	mov    %eax,%edx
    1a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a27:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    1a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2d:	8b 40 38             	mov    0x38(%eax),%eax
    1a30:	85 c0                	test   %eax,%eax
    1a32:	75 15                	jne    1a49 <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1a34:	83 ec 04             	sub    $0x4,%esp
    1a37:	ff 75 08             	pushl  0x8(%ebp)
    1a3a:	68 88 27 00 00       	push   $0x2788
    1a3f:	6a 01                	push   $0x1
    1a41:	e8 06 ed ff ff       	call   74c <printf>
    1a46:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    1a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a4c:	8b 40 20             	mov    0x20(%eax),%eax
    1a4f:	89 c2                	mov    %eax,%edx
    1a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a54:	8b 40 24             	mov    0x24(%eax),%eax
    1a57:	0f af d0             	imul   %eax,%edx
    1a5a:	89 d0                	mov    %edx,%eax
    1a5c:	01 c0                	add    %eax,%eax
    1a5e:	01 c2                	add    %eax,%edx
    1a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a63:	8b 40 38             	mov    0x38(%eax),%eax
    1a66:	83 ec 04             	sub    $0x4,%esp
    1a69:	52                   	push   %edx
    1a6a:	68 ff ff ff 00       	push   $0xffffff
    1a6f:	50                   	push   %eax
    1a70:	e8 8d e9 ff ff       	call   402 <memset>
    1a75:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1a7b:	c9                   	leave  
    1a7c:	c3                   	ret    

00001a7d <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    1a7d:	55                   	push   %ebp
    1a7e:	89 e5                	mov    %esp,%ebp
    1a80:	57                   	push   %edi
    1a81:	56                   	push   %esi
    1a82:	53                   	push   %ebx
    1a83:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1a86:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a89:	83 f8 03             	cmp    $0x3,%eax
    1a8c:	74 02                	je     1a90 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    1a8e:	eb 7c                	jmp    1b0c <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    1a90:	8b 45 08             	mov    0x8(%ebp),%eax
    1a93:	8b 58 1c             	mov    0x1c(%eax),%ebx
    1a96:	8b 45 08             	mov    0x8(%ebp),%eax
    1a99:	8b 48 18             	mov    0x18(%eax),%ecx
    1a9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9f:	8b 50 5c             	mov    0x5c(%eax),%edx
    1aa2:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa5:	8b 40 58             	mov    0x58(%eax),%eax
    1aa8:	8b 75 08             	mov    0x8(%ebp),%esi
    1aab:	83 c6 58             	add    $0x58,%esi
    1aae:	83 ec 04             	sub    $0x4,%esp
    1ab1:	53                   	push   %ebx
    1ab2:	51                   	push   %ecx
    1ab3:	6a 00                	push   $0x0
    1ab5:	52                   	push   %edx
    1ab6:	50                   	push   %eax
    1ab7:	6a 00                	push   $0x0
    1ab9:	6a 00                	push   $0x0
    1abb:	56                   	push   %esi
    1abc:	6a 00                	push   $0x0
    1abe:	6a 00                	push   $0x0
    1ac0:	ff 75 08             	pushl  0x8(%ebp)
    1ac3:	e8 75 eb ff ff       	call   63d <paintWindow>
    1ac8:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    1acb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ace:	8b 70 1c             	mov    0x1c(%eax),%esi
    1ad1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad4:	8b 58 18             	mov    0x18(%eax),%ebx
    1ad7:	8b 45 08             	mov    0x8(%ebp),%eax
    1ada:	8b 48 08             	mov    0x8(%eax),%ecx
    1add:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae0:	8b 50 40             	mov    0x40(%eax),%edx
    1ae3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae6:	8b 40 3c             	mov    0x3c(%eax),%eax
    1ae9:	8b 7d 08             	mov    0x8(%ebp),%edi
    1aec:	83 c7 3c             	add    $0x3c,%edi
    1aef:	83 ec 04             	sub    $0x4,%esp
    1af2:	56                   	push   %esi
    1af3:	53                   	push   %ebx
    1af4:	51                   	push   %ecx
    1af5:	52                   	push   %edx
    1af6:	50                   	push   %eax
    1af7:	6a 00                	push   $0x0
    1af9:	6a 00                	push   $0x0
    1afb:	57                   	push   %edi
    1afc:	6a 32                	push   $0x32
    1afe:	6a 00                	push   $0x0
    1b00:	ff 75 08             	pushl  0x8(%ebp)
    1b03:	e8 35 eb ff ff       	call   63d <paintWindow>
    1b08:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    1b0b:	90                   	nop
        default: break;
            
            
    }
    return False;
    1b0c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1b11:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b14:	5b                   	pop    %ebx
    1b15:	5e                   	pop    %esi
    1b16:	5f                   	pop    %edi
    1b17:	5d                   	pop    %ebp
    1b18:	c3                   	ret    

00001b19 <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    1b19:	55                   	push   %ebp
    1b1a:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    1b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b1f:	8b 50 08             	mov    0x8(%eax),%edx
    1b22:	8b 45 08             	mov    0x8(%ebp),%eax
    1b25:	8b 00                	mov    (%eax),%eax
    1b27:	39 c2                	cmp    %eax,%edx
    1b29:	74 07                	je     1b32 <APPreJudge+0x19>
        return False;
    1b2b:	b8 00 00 00 00       	mov    $0x0,%eax
    1b30:	eb 05                	jmp    1b37 <APPreJudge+0x1e>
    return True;
    1b32:	b8 01 00 00 00       	mov    $0x1,%eax
}
    1b37:	5d                   	pop    %ebp
    1b38:	c3                   	ret    

00001b39 <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    1b39:	55                   	push   %ebp
    1b3a:	89 e5                	mov    %esp,%ebp
    1b3c:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    1b3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b42:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b45:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    1b4b:	83 ec 0c             	sub    $0xc,%esp
    1b4e:	ff 75 08             	pushl  0x8(%ebp)
    1b51:	e8 ff ea ff ff       	call   655 <registWindow>
    1b56:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    1b59:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    1b60:	8b 45 08             	mov    0x8(%ebp),%eax
    1b63:	8b 00                	mov    (%eax),%eax
    1b65:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    1b68:	ff 75 f4             	pushl  -0xc(%ebp)
    1b6b:	ff 75 f0             	pushl  -0x10(%ebp)
    1b6e:	ff 75 ec             	pushl  -0x14(%ebp)
    1b71:	ff 75 08             	pushl  0x8(%ebp)
    1b74:	e8 80 fc ff ff       	call   17f9 <APSendMessage>
    1b79:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1b7c:	83 ec 0c             	sub    $0xc,%esp
    1b7f:	ff 75 08             	pushl  0x8(%ebp)
    1b82:	e8 c6 ea ff ff       	call   64d <getMessage>
    1b87:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1b8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8d:	83 c0 74             	add    $0x74,%eax
    1b90:	83 ec 08             	sub    $0x8,%esp
    1b93:	50                   	push   %eax
    1b94:	ff 75 08             	pushl  0x8(%ebp)
    1b97:	e8 7d ff ff ff       	call   1b19 <APPreJudge>
    1b9c:	83 c4 10             	add    $0x10,%esp
    1b9f:	84 c0                	test   %al,%al
    1ba1:	74 1b                	je     1bbe <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    1ba3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba6:	ff 70 7c             	pushl  0x7c(%eax)
    1ba9:	ff 70 78             	pushl  0x78(%eax)
    1bac:	ff 70 74             	pushl  0x74(%eax)
    1baf:	ff 75 08             	pushl  0x8(%ebp)
    1bb2:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bb5:	ff d0                	call   *%eax
    1bb7:	83 c4 10             	add    $0x10,%esp
    1bba:	84 c0                	test   %al,%al
    1bbc:	75 0c                	jne    1bca <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    1bbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc1:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    1bc8:	eb b2                	jmp    1b7c <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1bca:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1bcb:	90                   	nop
    1bcc:	c9                   	leave  
    1bcd:	c3                   	ret    

00001bce <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1bce:	55                   	push   %ebp
    1bcf:	89 e5                	mov    %esp,%ebp
    1bd1:	57                   	push   %edi
    1bd2:	56                   	push   %esi
    1bd3:	53                   	push   %ebx
    1bd4:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    1bd7:	a1 d4 6a 00 00       	mov    0x6ad4,%eax
    1bdc:	85 c0                	test   %eax,%eax
    1bde:	0f 85 2c 02 00 00    	jne    1e10 <APGridPaint+0x242>
    {
        iconReady = 1;
    1be4:	c7 05 d4 6a 00 00 01 	movl   $0x1,0x6ad4
    1beb:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    1bee:	8d 45 88             	lea    -0x78(%ebp),%eax
    1bf1:	83 ec 08             	sub    $0x8,%esp
    1bf4:	68 af 27 00 00       	push   $0x27af
    1bf9:	50                   	push   %eax
    1bfa:	e8 d3 ef ff ff       	call   bd2 <APLoadBitmap>
    1bff:	83 c4 0c             	add    $0xc,%esp
    1c02:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c05:	a3 f8 6a 00 00       	mov    %eax,0x6af8
    1c0a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c0d:	a3 fc 6a 00 00       	mov    %eax,0x6afc
    1c12:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c15:	a3 00 6b 00 00       	mov    %eax,0x6b00
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1c1a:	83 ec 04             	sub    $0x4,%esp
    1c1d:	ff 35 00 6b 00 00    	pushl  0x6b00
    1c23:	ff 35 fc 6a 00 00    	pushl  0x6afc
    1c29:	ff 35 f8 6a 00 00    	pushl  0x6af8
    1c2f:	e8 d8 f1 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1c34:	83 c4 10             	add    $0x10,%esp
    1c37:	a3 04 6b 00 00       	mov    %eax,0x6b04
        grid_river = APLoadBitmap ("grid_river.bmp");
    1c3c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c3f:	83 ec 08             	sub    $0x8,%esp
    1c42:	68 bd 27 00 00       	push   $0x27bd
    1c47:	50                   	push   %eax
    1c48:	e8 85 ef ff ff       	call   bd2 <APLoadBitmap>
    1c4d:	83 c4 0c             	add    $0xc,%esp
    1c50:	8b 45 88             	mov    -0x78(%ebp),%eax
    1c53:	a3 34 6b 00 00       	mov    %eax,0x6b34
    1c58:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1c5b:	a3 38 6b 00 00       	mov    %eax,0x6b38
    1c60:	8b 45 90             	mov    -0x70(%ebp),%eax
    1c63:	a3 3c 6b 00 00       	mov    %eax,0x6b3c
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    1c68:	83 ec 04             	sub    $0x4,%esp
    1c6b:	ff 35 3c 6b 00 00    	pushl  0x6b3c
    1c71:	ff 35 38 6b 00 00    	pushl  0x6b38
    1c77:	ff 35 34 6b 00 00    	pushl  0x6b34
    1c7d:	e8 8a f1 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1c82:	83 c4 10             	add    $0x10,%esp
    1c85:	a3 24 6b 00 00       	mov    %eax,0x6b24
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    1c8a:	8d 45 88             	lea    -0x78(%ebp),%eax
    1c8d:	83 ec 08             	sub    $0x8,%esp
    1c90:	68 cc 27 00 00       	push   $0x27cc
    1c95:	50                   	push   %eax
    1c96:	e8 37 ef ff ff       	call   bd2 <APLoadBitmap>
    1c9b:	83 c4 0c             	add    $0xc,%esp
    1c9e:	8b 45 88             	mov    -0x78(%ebp),%eax
    1ca1:	a3 28 6b 00 00       	mov    %eax,0x6b28
    1ca6:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1ca9:	a3 2c 6b 00 00       	mov    %eax,0x6b2c
    1cae:	8b 45 90             	mov    -0x70(%ebp),%eax
    1cb1:	a3 30 6b 00 00       	mov    %eax,0x6b30
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    1cb6:	83 ec 04             	sub    $0x4,%esp
    1cb9:	ff 35 30 6b 00 00    	pushl  0x6b30
    1cbf:	ff 35 2c 6b 00 00    	pushl  0x6b2c
    1cc5:	ff 35 28 6b 00 00    	pushl  0x6b28
    1ccb:	e8 3c f1 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1cd0:	83 c4 10             	add    $0x10,%esp
    1cd3:	a3 d8 6a 00 00       	mov    %eax,0x6ad8
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    1cd8:	8d 45 88             	lea    -0x78(%ebp),%eax
    1cdb:	83 ec 08             	sub    $0x8,%esp
    1cde:	68 db 27 00 00       	push   $0x27db
    1ce3:	50                   	push   %eax
    1ce4:	e8 e9 ee ff ff       	call   bd2 <APLoadBitmap>
    1ce9:	83 c4 0c             	add    $0xc,%esp
    1cec:	8b 45 88             	mov    -0x78(%ebp),%eax
    1cef:	a3 0c 6b 00 00       	mov    %eax,0x6b0c
    1cf4:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1cf7:	a3 10 6b 00 00       	mov    %eax,0x6b10
    1cfc:	8b 45 90             	mov    -0x70(%ebp),%eax
    1cff:	a3 14 6b 00 00       	mov    %eax,0x6b14
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    1d04:	83 ec 04             	sub    $0x4,%esp
    1d07:	ff 35 14 6b 00 00    	pushl  0x6b14
    1d0d:	ff 35 10 6b 00 00    	pushl  0x6b10
    1d13:	ff 35 0c 6b 00 00    	pushl  0x6b0c
    1d19:	e8 ee f0 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1d1e:	83 c4 10             	add    $0x10,%esp
    1d21:	a3 40 6b 00 00       	mov    %eax,0x6b40
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    1d26:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d29:	83 ec 08             	sub    $0x8,%esp
    1d2c:	68 e9 27 00 00       	push   $0x27e9
    1d31:	50                   	push   %eax
    1d32:	e8 9b ee ff ff       	call   bd2 <APLoadBitmap>
    1d37:	83 c4 0c             	add    $0xc,%esp
    1d3a:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d3d:	a3 e8 6a 00 00       	mov    %eax,0x6ae8
    1d42:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d45:	a3 ec 6a 00 00       	mov    %eax,0x6aec
    1d4a:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d4d:	a3 f0 6a 00 00       	mov    %eax,0x6af0
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    1d52:	83 ec 04             	sub    $0x4,%esp
    1d55:	ff 35 f0 6a 00 00    	pushl  0x6af0
    1d5b:	ff 35 ec 6a 00 00    	pushl  0x6aec
    1d61:	ff 35 e8 6a 00 00    	pushl  0x6ae8
    1d67:	e8 a0 f0 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1d6c:	83 c4 10             	add    $0x10,%esp
    1d6f:	a3 08 6b 00 00       	mov    %eax,0x6b08
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    1d74:	8d 45 88             	lea    -0x78(%ebp),%eax
    1d77:	83 ec 08             	sub    $0x8,%esp
    1d7a:	68 f9 27 00 00       	push   $0x27f9
    1d7f:	50                   	push   %eax
    1d80:	e8 4d ee ff ff       	call   bd2 <APLoadBitmap>
    1d85:	83 c4 0c             	add    $0xc,%esp
    1d88:	8b 45 88             	mov    -0x78(%ebp),%eax
    1d8b:	a3 dc 6a 00 00       	mov    %eax,0x6adc
    1d90:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1d93:	a3 e0 6a 00 00       	mov    %eax,0x6ae0
    1d98:	8b 45 90             	mov    -0x70(%ebp),%eax
    1d9b:	a3 e4 6a 00 00       	mov    %eax,0x6ae4
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    1da0:	83 ec 04             	sub    $0x4,%esp
    1da3:	ff 35 e4 6a 00 00    	pushl  0x6ae4
    1da9:	ff 35 e0 6a 00 00    	pushl  0x6ae0
    1daf:	ff 35 dc 6a 00 00    	pushl  0x6adc
    1db5:	e8 52 f0 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1dba:	83 c4 10             	add    $0x10,%esp
    1dbd:	a3 f4 6a 00 00       	mov    %eax,0x6af4
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    1dc2:	8d 45 88             	lea    -0x78(%ebp),%eax
    1dc5:	83 ec 08             	sub    $0x8,%esp
    1dc8:	68 0b 28 00 00       	push   $0x280b
    1dcd:	50                   	push   %eax
    1dce:	e8 ff ed ff ff       	call   bd2 <APLoadBitmap>
    1dd3:	83 c4 0c             	add    $0xc,%esp
    1dd6:	8b 45 88             	mov    -0x78(%ebp),%eax
    1dd9:	a3 18 6b 00 00       	mov    %eax,0x6b18
    1dde:	8b 45 8c             	mov    -0x74(%ebp),%eax
    1de1:	a3 1c 6b 00 00       	mov    %eax,0x6b1c
    1de6:	8b 45 90             	mov    -0x70(%ebp),%eax
    1de9:	a3 20 6b 00 00       	mov    %eax,0x6b20
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    1dee:	83 ec 04             	sub    $0x4,%esp
    1df1:	ff 35 20 6b 00 00    	pushl  0x6b20
    1df7:	ff 35 1c 6b 00 00    	pushl  0x6b1c
    1dfd:	ff 35 18 6b 00 00    	pushl  0x6b18
    1e03:	e8 04 f0 ff ff       	call   e0c <APCreateCompatibleDCFromBitmap>
    1e08:	83 c4 10             	add    $0x10,%esp
    1e0b:	a3 44 6b 00 00       	mov    %eax,0x6b44
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    1e10:	8b 45 08             	mov    0x8(%ebp),%eax
    1e13:	8b 40 08             	mov    0x8(%eax),%eax
    1e16:	85 c0                	test   %eax,%eax
    1e18:	75 17                	jne    1e31 <APGridPaint+0x263>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1e1a:	83 ec 08             	sub    $0x8,%esp
    1e1d:	68 1c 28 00 00       	push   $0x281c
    1e22:	6a 01                	push   $0x1
    1e24:	e8 23 e9 ff ff       	call   74c <printf>
    1e29:	83 c4 10             	add    $0x10,%esp
        return;
    1e2c:	e9 07 05 00 00       	jmp    2338 <APGridPaint+0x76a>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1e31:	8b 45 08             	mov    0x8(%ebp),%eax
    1e34:	8b 40 10             	mov    0x10(%eax),%eax
    1e37:	85 c0                	test   %eax,%eax
    1e39:	7e 10                	jle    1e4b <APGridPaint+0x27d>
    1e3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3e:	8b 50 14             	mov    0x14(%eax),%edx
    1e41:	8b 45 08             	mov    0x8(%ebp),%eax
    1e44:	8b 40 10             	mov    0x10(%eax),%eax
    1e47:	39 c2                	cmp    %eax,%edx
    1e49:	7c 17                	jl     1e62 <APGridPaint+0x294>
    {
        printf(1,"Grid mode page error!");
    1e4b:	83 ec 08             	sub    $0x8,%esp
    1e4e:	68 42 28 00 00       	push   $0x2842
    1e53:	6a 01                	push   $0x1
    1e55:	e8 f2 e8 ff ff       	call   74c <printf>
    1e5a:	83 c4 10             	add    $0x10,%esp
        return;
    1e5d:	e9 d6 04 00 00       	jmp    2338 <APGridPaint+0x76a>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1e62:	8b 45 08             	mov    0x8(%ebp),%eax
    1e65:	8b 40 14             	mov    0x14(%eax),%eax
    1e68:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1e6e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1e71:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1e74:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e77:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1e7e:	e9 96 03 00 00       	jmp    2219 <APGridPaint+0x64b>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e83:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1e8a:	e9 7c 03 00 00       	jmp    220b <APGridPaint+0x63d>
        {
            index = start + GRID_W_NUMBER * j + i;
    1e8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e92:	c1 e0 04             	shl    $0x4,%eax
    1e95:	89 c2                	mov    %eax,%edx
    1e97:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1e9a:	01 c2                	add    %eax,%edx
    1e9c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e9f:	01 d0                	add    %edx,%eax
    1ea1:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1ea4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea7:	8b 40 0c             	mov    0xc(%eax),%eax
    1eaa:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1ead:	c1 e2 02             	shl    $0x2,%edx
    1eb0:	01 d0                	add    %edx,%eax
    1eb2:	8b 00                	mov    (%eax),%eax
    1eb4:	83 f8 07             	cmp    $0x7,%eax
    1eb7:	0f 87 49 03 00 00    	ja     2206 <APGridPaint+0x638>
    1ebd:	8b 04 85 58 28 00 00 	mov    0x2858(,%eax,4),%eax
    1ec4:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1ec6:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    1ec9:	6a 0c                	push   $0xc
    1ecb:	6a 0c                	push   $0xc
    1ecd:	6a 0c                	push   $0xc
    1ecf:	50                   	push   %eax
    1ed0:	e8 df f8 ff ff       	call   17b4 <RGB>
    1ed5:	83 c4 0c             	add    $0xc,%esp
    1ed8:	8b 1d 04 6b 00 00    	mov    0x6b04,%ebx
    1ede:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ee1:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ee4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ee7:	6b c0 32             	imul   $0x32,%eax,%eax
    1eea:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1eed:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef0:	8d 78 3c             	lea    0x3c(%eax),%edi
    1ef3:	83 ec 0c             	sub    $0xc,%esp
    1ef6:	83 ec 04             	sub    $0x4,%esp
    1ef9:	89 e0                	mov    %esp,%eax
    1efb:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    1eff:	66 89 30             	mov    %si,(%eax)
    1f02:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    1f06:	88 50 02             	mov    %dl,0x2(%eax)
    1f09:	6a 32                	push   $0x32
    1f0b:	6a 32                	push   $0x32
    1f0d:	6a 00                	push   $0x0
    1f0f:	6a 00                	push   $0x0
    1f11:	53                   	push   %ebx
    1f12:	51                   	push   %ecx
    1f13:	ff 75 84             	pushl  -0x7c(%ebp)
    1f16:	57                   	push   %edi
    1f17:	e8 f4 f6 ff ff       	call   1610 <APDcCopy>
    1f1c:	83 c4 30             	add    $0x30,%esp
                    break;
    1f1f:	e9 e3 02 00 00       	jmp    2207 <APGridPaint+0x639>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1f24:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f27:	6a 69                	push   $0x69
    1f29:	6a 69                	push   $0x69
    1f2b:	6a 69                	push   $0x69
    1f2d:	50                   	push   %eax
    1f2e:	e8 81 f8 ff ff       	call   17b4 <RGB>
    1f33:	83 c4 0c             	add    $0xc,%esp
    1f36:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f3a:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    1f3e:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f42:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    1f45:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1f4c:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f4f:	6a 69                	push   $0x69
    1f51:	6a 69                	push   $0x69
    1f53:	6a 69                	push   $0x69
    1f55:	50                   	push   %eax
    1f56:	e8 59 f8 ff ff       	call   17b4 <RGB>
    1f5b:	83 c4 0c             	add    $0xc,%esp
    1f5e:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    1f62:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    1f66:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    1f6a:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1f6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1f70:	8d 50 3c             	lea    0x3c(%eax),%edx
    1f73:	8d 45 88             	lea    -0x78(%ebp),%eax
    1f76:	ff 75 ac             	pushl  -0x54(%ebp)
    1f79:	ff 75 a8             	pushl  -0x58(%ebp)
    1f7c:	52                   	push   %edx
    1f7d:	50                   	push   %eax
    1f7e:	e8 1e ef ff ff       	call   ea1 <APSetPen>
    1f83:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1f86:	8b 45 08             	mov    0x8(%ebp),%eax
    1f89:	8d 58 3c             	lea    0x3c(%eax),%ebx
    1f8c:	8d 55 88             	lea    -0x78(%ebp),%edx
    1f8f:	83 ec 04             	sub    $0x4,%esp
    1f92:	83 ec 04             	sub    $0x4,%esp
    1f95:	89 e0                	mov    %esp,%eax
    1f97:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    1f9b:	66 89 08             	mov    %cx,(%eax)
    1f9e:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    1fa2:	88 48 02             	mov    %cl,0x2(%eax)
    1fa5:	53                   	push   %ebx
    1fa6:	52                   	push   %edx
    1fa7:	e8 2e ef ff ff       	call   eda <APSetBrush>
    1fac:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1faf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1fb2:	6b d0 32             	imul   $0x32,%eax,%edx
    1fb5:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1fb8:	6b c0 32             	imul   $0x32,%eax,%eax
    1fbb:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1fbe:	83 c1 3c             	add    $0x3c,%ecx
    1fc1:	83 ec 0c             	sub    $0xc,%esp
    1fc4:	6a 32                	push   $0x32
    1fc6:	6a 32                	push   $0x32
    1fc8:	52                   	push   %edx
    1fc9:	50                   	push   %eax
    1fca:	51                   	push   %ecx
    1fcb:	e8 34 f3 ff ff       	call   1304 <APDrawRect>
    1fd0:	83 c4 20             	add    $0x20,%esp
                    break;
    1fd3:	e9 2f 02 00 00       	jmp    2207 <APGridPaint+0x639>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1fd8:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    1fdb:	6a 0c                	push   $0xc
    1fdd:	6a 0c                	push   $0xc
    1fdf:	6a 0c                	push   $0xc
    1fe1:	50                   	push   %eax
    1fe2:	e8 cd f7 ff ff       	call   17b4 <RGB>
    1fe7:	83 c4 0c             	add    $0xc,%esp
    1fea:	8b 1d 44 6b 00 00    	mov    0x6b44,%ebx
    1ff0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ff3:	6b c8 32             	imul   $0x32,%eax,%ecx
    1ff6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1ff9:	6b c0 32             	imul   $0x32,%eax,%eax
    1ffc:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1fff:	8b 45 08             	mov    0x8(%ebp),%eax
    2002:	8d 78 3c             	lea    0x3c(%eax),%edi
    2005:	83 ec 0c             	sub    $0xc,%esp
    2008:	83 ec 04             	sub    $0x4,%esp
    200b:	89 e0                	mov    %esp,%eax
    200d:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    2011:	66 89 30             	mov    %si,(%eax)
    2014:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    2018:	88 50 02             	mov    %dl,0x2(%eax)
    201b:	6a 32                	push   $0x32
    201d:	6a 32                	push   $0x32
    201f:	6a 00                	push   $0x0
    2021:	6a 00                	push   $0x0
    2023:	53                   	push   %ebx
    2024:	51                   	push   %ecx
    2025:	ff 75 84             	pushl  -0x7c(%ebp)
    2028:	57                   	push   %edi
    2029:	e8 e2 f5 ff ff       	call   1610 <APDcCopy>
    202e:	83 c4 30             	add    $0x30,%esp
                    break;
    2031:	e9 d1 01 00 00       	jmp    2207 <APGridPaint+0x639>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2036:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2039:	6a 0c                	push   $0xc
    203b:	6a 0c                	push   $0xc
    203d:	6a 0c                	push   $0xc
    203f:	50                   	push   %eax
    2040:	e8 6f f7 ff ff       	call   17b4 <RGB>
    2045:	83 c4 0c             	add    $0xc,%esp
    2048:	8b 1d 24 6b 00 00    	mov    0x6b24,%ebx
    204e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2051:	6b c8 32             	imul   $0x32,%eax,%ecx
    2054:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2057:	6b c0 32             	imul   $0x32,%eax,%eax
    205a:	89 45 84             	mov    %eax,-0x7c(%ebp)
    205d:	8b 45 08             	mov    0x8(%ebp),%eax
    2060:	8d 78 3c             	lea    0x3c(%eax),%edi
    2063:	83 ec 0c             	sub    $0xc,%esp
    2066:	83 ec 04             	sub    $0x4,%esp
    2069:	89 e0                	mov    %esp,%eax
    206b:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    206f:	66 89 30             	mov    %si,(%eax)
    2072:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    2076:	88 50 02             	mov    %dl,0x2(%eax)
    2079:	6a 32                	push   $0x32
    207b:	6a 32                	push   $0x32
    207d:	6a 00                	push   $0x0
    207f:	6a 00                	push   $0x0
    2081:	53                   	push   %ebx
    2082:	51                   	push   %ecx
    2083:	ff 75 84             	pushl  -0x7c(%ebp)
    2086:	57                   	push   %edi
    2087:	e8 84 f5 ff ff       	call   1610 <APDcCopy>
    208c:	83 c4 30             	add    $0x30,%esp
                    break;
    208f:	e9 73 01 00 00       	jmp    2207 <APGridPaint+0x639>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2094:	8d 45 cc             	lea    -0x34(%ebp),%eax
    2097:	6a 0c                	push   $0xc
    2099:	6a 0c                	push   $0xc
    209b:	6a 0c                	push   $0xc
    209d:	50                   	push   %eax
    209e:	e8 11 f7 ff ff       	call   17b4 <RGB>
    20a3:	83 c4 0c             	add    $0xc,%esp
    20a6:	8b 1d 08 6b 00 00    	mov    0x6b08,%ebx
    20ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20af:	6b c8 32             	imul   $0x32,%eax,%ecx
    20b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    20b5:	6b c0 32             	imul   $0x32,%eax,%eax
    20b8:	89 45 84             	mov    %eax,-0x7c(%ebp)
    20bb:	8b 45 08             	mov    0x8(%ebp),%eax
    20be:	8d 78 3c             	lea    0x3c(%eax),%edi
    20c1:	83 ec 0c             	sub    $0xc,%esp
    20c4:	83 ec 04             	sub    $0x4,%esp
    20c7:	89 e0                	mov    %esp,%eax
    20c9:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    20cd:	66 89 30             	mov    %si,(%eax)
    20d0:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    20d4:	88 50 02             	mov    %dl,0x2(%eax)
    20d7:	6a 32                	push   $0x32
    20d9:	6a 32                	push   $0x32
    20db:	6a 00                	push   $0x0
    20dd:	6a 00                	push   $0x0
    20df:	53                   	push   %ebx
    20e0:	51                   	push   %ecx
    20e1:	ff 75 84             	pushl  -0x7c(%ebp)
    20e4:	57                   	push   %edi
    20e5:	e8 26 f5 ff ff       	call   1610 <APDcCopy>
    20ea:	83 c4 30             	add    $0x30,%esp
                    break;
    20ed:	e9 15 01 00 00       	jmp    2207 <APGridPaint+0x639>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    20f2:	8d 45 cf             	lea    -0x31(%ebp),%eax
    20f5:	6a 0c                	push   $0xc
    20f7:	6a 0c                	push   $0xc
    20f9:	6a 0c                	push   $0xc
    20fb:	50                   	push   %eax
    20fc:	e8 b3 f6 ff ff       	call   17b4 <RGB>
    2101:	83 c4 0c             	add    $0xc,%esp
    2104:	8b 1d 40 6b 00 00    	mov    0x6b40,%ebx
    210a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    210d:	6b c8 32             	imul   $0x32,%eax,%ecx
    2110:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2113:	6b c0 32             	imul   $0x32,%eax,%eax
    2116:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2119:	8b 45 08             	mov    0x8(%ebp),%eax
    211c:	8d 78 3c             	lea    0x3c(%eax),%edi
    211f:	83 ec 0c             	sub    $0xc,%esp
    2122:	83 ec 04             	sub    $0x4,%esp
    2125:	89 e0                	mov    %esp,%eax
    2127:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    212b:	66 89 30             	mov    %si,(%eax)
    212e:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    2132:	88 50 02             	mov    %dl,0x2(%eax)
    2135:	6a 32                	push   $0x32
    2137:	6a 32                	push   $0x32
    2139:	6a 00                	push   $0x0
    213b:	6a 00                	push   $0x0
    213d:	53                   	push   %ebx
    213e:	51                   	push   %ecx
    213f:	ff 75 84             	pushl  -0x7c(%ebp)
    2142:	57                   	push   %edi
    2143:	e8 c8 f4 ff ff       	call   1610 <APDcCopy>
    2148:	83 c4 30             	add    $0x30,%esp
                    break;
    214b:	e9 b7 00 00 00       	jmp    2207 <APGridPaint+0x639>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    2150:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    2153:	6a 0c                	push   $0xc
    2155:	6a 0c                	push   $0xc
    2157:	6a 0c                	push   $0xc
    2159:	50                   	push   %eax
    215a:	e8 55 f6 ff ff       	call   17b4 <RGB>
    215f:	83 c4 0c             	add    $0xc,%esp
    2162:	8b 1d d8 6a 00 00    	mov    0x6ad8,%ebx
    2168:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    216b:	6b c8 32             	imul   $0x32,%eax,%ecx
    216e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2171:	6b c0 32             	imul   $0x32,%eax,%eax
    2174:	89 45 84             	mov    %eax,-0x7c(%ebp)
    2177:	8b 45 08             	mov    0x8(%ebp),%eax
    217a:	8d 78 3c             	lea    0x3c(%eax),%edi
    217d:	83 ec 0c             	sub    $0xc,%esp
    2180:	83 ec 04             	sub    $0x4,%esp
    2183:	89 e0                	mov    %esp,%eax
    2185:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    2189:	66 89 30             	mov    %si,(%eax)
    218c:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    2190:	88 50 02             	mov    %dl,0x2(%eax)
    2193:	6a 32                	push   $0x32
    2195:	6a 32                	push   $0x32
    2197:	6a 00                	push   $0x0
    2199:	6a 00                	push   $0x0
    219b:	53                   	push   %ebx
    219c:	51                   	push   %ecx
    219d:	ff 75 84             	pushl  -0x7c(%ebp)
    21a0:	57                   	push   %edi
    21a1:	e8 6a f4 ff ff       	call   1610 <APDcCopy>
    21a6:	83 c4 30             	add    $0x30,%esp
                    break;
    21a9:	eb 5c                	jmp    2207 <APGridPaint+0x639>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    21ab:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    21ae:	6a 0c                	push   $0xc
    21b0:	6a 0c                	push   $0xc
    21b2:	6a 0c                	push   $0xc
    21b4:	50                   	push   %eax
    21b5:	e8 fa f5 ff ff       	call   17b4 <RGB>
    21ba:	83 c4 0c             	add    $0xc,%esp
    21bd:	8b 1d f4 6a 00 00    	mov    0x6af4,%ebx
    21c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21c6:	6b c8 32             	imul   $0x32,%eax,%ecx
    21c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
    21cc:	6b c0 32             	imul   $0x32,%eax,%eax
    21cf:	89 45 84             	mov    %eax,-0x7c(%ebp)
    21d2:	8b 45 08             	mov    0x8(%ebp),%eax
    21d5:	8d 78 3c             	lea    0x3c(%eax),%edi
    21d8:	83 ec 0c             	sub    $0xc,%esp
    21db:	83 ec 04             	sub    $0x4,%esp
    21de:	89 e0                	mov    %esp,%eax
    21e0:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    21e4:	66 89 30             	mov    %si,(%eax)
    21e7:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    21eb:	88 50 02             	mov    %dl,0x2(%eax)
    21ee:	6a 32                	push   $0x32
    21f0:	6a 32                	push   $0x32
    21f2:	6a 00                	push   $0x0
    21f4:	6a 00                	push   $0x0
    21f6:	53                   	push   %ebx
    21f7:	51                   	push   %ecx
    21f8:	ff 75 84             	pushl  -0x7c(%ebp)
    21fb:	57                   	push   %edi
    21fc:	e8 0f f4 ff ff       	call   1610 <APDcCopy>
    2201:	83 c4 30             	add    $0x30,%esp
                    break;
    2204:	eb 01                	jmp    2207 <APGridPaint+0x639>
                default: break;
    2206:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    2207:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    220b:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    220f:	0f 8e 7a fc ff ff    	jle    1e8f <APGridPaint+0x2c1>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    2215:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    2219:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    221d:	0f 8e 60 fc ff ff    	jle    1e83 <APGridPaint+0x2b5>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    2223:	8d 45 88             	lea    -0x78(%ebp),%eax
    2226:	68 cd 00 00 00       	push   $0xcd
    222b:	6a 74                	push   $0x74
    222d:	6a 18                	push   $0x18
    222f:	50                   	push   %eax
    2230:	e8 7f f5 ff ff       	call   17b4 <RGB>
    2235:	83 c4 0c             	add    $0xc,%esp
    2238:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    223c:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    2240:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    2244:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    2247:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    224e:	8d 45 88             	lea    -0x78(%ebp),%eax
    2251:	68 cd 00 00 00       	push   $0xcd
    2256:	6a 74                	push   $0x74
    2258:	6a 18                	push   $0x18
    225a:	50                   	push   %eax
    225b:	e8 54 f5 ff ff       	call   17b4 <RGB>
    2260:	83 c4 0c             	add    $0xc,%esp
    2263:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    2267:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    226b:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    226f:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    2272:	8b 45 08             	mov    0x8(%ebp),%eax
    2275:	8d 50 58             	lea    0x58(%eax),%edx
    2278:	8d 45 88             	lea    -0x78(%ebp),%eax
    227b:	ff 75 bc             	pushl  -0x44(%ebp)
    227e:	ff 75 b8             	pushl  -0x48(%ebp)
    2281:	52                   	push   %edx
    2282:	50                   	push   %eax
    2283:	e8 19 ec ff ff       	call   ea1 <APSetPen>
    2288:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    228b:	8b 45 08             	mov    0x8(%ebp),%eax
    228e:	8d 58 58             	lea    0x58(%eax),%ebx
    2291:	8d 55 88             	lea    -0x78(%ebp),%edx
    2294:	83 ec 04             	sub    $0x4,%esp
    2297:	83 ec 04             	sub    $0x4,%esp
    229a:	89 e0                	mov    %esp,%eax
    229c:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    22a0:	66 89 08             	mov    %cx,(%eax)
    22a3:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    22a7:	88 48 02             	mov    %cl,0x2(%eax)
    22aa:	53                   	push   %ebx
    22ab:	52                   	push   %edx
    22ac:	e8 29 ec ff ff       	call   eda <APSetBrush>
    22b1:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    22b4:	8b 45 08             	mov    0x8(%ebp),%eax
    22b7:	83 c0 58             	add    $0x58,%eax
    22ba:	83 ec 0c             	sub    $0xc,%esp
    22bd:	6a 32                	push   $0x32
    22bf:	68 20 03 00 00       	push   $0x320
    22c4:	6a 00                	push   $0x0
    22c6:	6a 00                	push   $0x0
    22c8:	50                   	push   %eax
    22c9:	e8 36 f0 ff ff       	call   1304 <APDrawRect>
    22ce:	83 c4 20             	add    $0x20,%esp
    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    22d1:	8d 45 88             	lea    -0x78(%ebp),%eax
    22d4:	6a 08                	push   $0x8
    22d6:	6a 08                	push   $0x8
    22d8:	6a 08                	push   $0x8
    22da:	50                   	push   %eax
    22db:	e8 d4 f4 ff ff       	call   17b4 <RGB>
    22e0:	83 c4 0c             	add    $0xc,%esp
    22e3:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    22e7:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    22eb:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    22ef:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    22f2:	8b 45 08             	mov    0x8(%ebp),%eax
    22f5:	8d 58 58             	lea    0x58(%eax),%ebx
    22f8:	8d 55 88             	lea    -0x78(%ebp),%edx
    22fb:	83 ec 04             	sub    $0x4,%esp
    22fe:	83 ec 04             	sub    $0x4,%esp
    2301:	89 e0                	mov    %esp,%eax
    2303:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    2307:	66 89 08             	mov    %cx,(%eax)
    230a:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    230e:	88 48 02             	mov    %cl,0x2(%eax)
    2311:	53                   	push   %ebx
    2312:	52                   	push   %edx
    2313:	e8 04 ec ff ff       	call   f1c <APSetFont>
    2318:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    231b:	8b 45 08             	mov    0x8(%ebp),%eax
    231e:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    2324:	8b 45 08             	mov    0x8(%ebp),%eax
    2327:	83 c0 58             	add    $0x58,%eax
    232a:	6a 14                	push   $0x14
    232c:	6a 14                	push   $0x14
    232e:	52                   	push   %edx
    232f:	50                   	push   %eax
    2330:	e8 d4 f1 ff ff       	call   1509 <APDrawText>
    2335:	83 c4 10             	add    $0x10,%esp
}
    2338:	8d 65 f4             	lea    -0xc(%ebp),%esp
    233b:	5b                   	pop    %ebx
    233c:	5e                   	pop    %esi
    233d:	5f                   	pop    %edi
    233e:	5d                   	pop    %ebp
    233f:	c3                   	ret    

00002340 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    2340:	55                   	push   %ebp
    2341:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    2343:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    2347:	7e 08                	jle    2351 <random+0x11>
{
rand_num = seed;
    2349:	8b 45 08             	mov    0x8(%ebp),%eax
    234c:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
}
rand_num *= 3;
    2351:	8b 15 a0 6a 00 00    	mov    0x6aa0,%edx
    2357:	89 d0                	mov    %edx,%eax
    2359:	01 c0                	add    %eax,%eax
    235b:	01 d0                	add    %edx,%eax
    235d:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
if (rand_num < 0)
    2362:	a1 a0 6a 00 00       	mov    0x6aa0,%eax
    2367:	85 c0                	test   %eax,%eax
    2369:	79 0c                	jns    2377 <random+0x37>
{
rand_num *= (-1);
    236b:	a1 a0 6a 00 00       	mov    0x6aa0,%eax
    2370:	f7 d8                	neg    %eax
    2372:	a3 a0 6a 00 00       	mov    %eax,0x6aa0
}
return rand_num % 997;
    2377:	8b 0d a0 6a 00 00    	mov    0x6aa0,%ecx
    237d:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    2382:	89 c8                	mov    %ecx,%eax
    2384:	f7 ea                	imul   %edx
    2386:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    2389:	c1 f8 09             	sar    $0x9,%eax
    238c:	89 c2                	mov    %eax,%edx
    238e:	89 c8                	mov    %ecx,%eax
    2390:	c1 f8 1f             	sar    $0x1f,%eax
    2393:	29 c2                	sub    %eax,%edx
    2395:	89 d0                	mov    %edx,%eax
    2397:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    239d:	29 c1                	sub    %eax,%ecx
    239f:	89 c8                	mov    %ecx,%eax
}
    23a1:	5d                   	pop    %ebp
    23a2:	c3                   	ret    

000023a3 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    23a3:	55                   	push   %ebp
    23a4:	89 e5                	mov    %esp,%ebp
    23a6:	53                   	push   %ebx
    23a7:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    23aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    23b1:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    23b5:	74 17                	je     23ce <sprintint+0x2b>
    23b7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    23bb:	79 11                	jns    23ce <sprintint+0x2b>
        neg = 1;
    23bd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    23c4:	8b 45 10             	mov    0x10(%ebp),%eax
    23c7:	f7 d8                	neg    %eax
    23c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    23cc:	eb 06                	jmp    23d4 <sprintint+0x31>
    } else {
        x = xx;
    23ce:	8b 45 10             	mov    0x10(%ebp),%eax
    23d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    23d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    23db:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    23de:	8d 41 01             	lea    0x1(%ecx),%eax
    23e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    23e4:	8b 5d 14             	mov    0x14(%ebp),%ebx
    23e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    23ea:	ba 00 00 00 00       	mov    $0x0,%edx
    23ef:	f7 f3                	div    %ebx
    23f1:	89 d0                	mov    %edx,%eax
    23f3:	0f b6 80 a4 6a 00 00 	movzbl 0x6aa4(%eax),%eax
    23fa:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    23fe:	8b 5d 14             	mov    0x14(%ebp),%ebx
    2401:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2404:	ba 00 00 00 00       	mov    $0x0,%edx
    2409:	f7 f3                	div    %ebx
    240b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    240e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2412:	75 c7                	jne    23db <sprintint+0x38>
    if(neg)
    2414:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2418:	74 0e                	je     2428 <sprintint+0x85>
        buf[i++] = '-';
    241a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    241d:	8d 50 01             	lea    0x1(%eax),%edx
    2420:	89 55 f8             	mov    %edx,-0x8(%ebp)
    2423:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    2428:	8b 45 f8             	mov    -0x8(%ebp),%eax
    242b:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    242e:	eb 1b                	jmp    244b <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    2430:	8b 45 0c             	mov    0xc(%ebp),%eax
    2433:	8b 00                	mov    (%eax),%eax
    2435:	8d 48 01             	lea    0x1(%eax),%ecx
    2438:	8b 55 0c             	mov    0xc(%ebp),%edx
    243b:	89 0a                	mov    %ecx,(%edx)
    243d:	89 c2                	mov    %eax,%edx
    243f:	8b 45 08             	mov    0x8(%ebp),%eax
    2442:	01 d0                	add    %edx,%eax
    2444:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    2447:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    244b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    244f:	7f df                	jg     2430 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2451:	eb 21                	jmp    2474 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    2453:	8b 45 0c             	mov    0xc(%ebp),%eax
    2456:	8b 00                	mov    (%eax),%eax
    2458:	8d 48 01             	lea    0x1(%eax),%ecx
    245b:	8b 55 0c             	mov    0xc(%ebp),%edx
    245e:	89 0a                	mov    %ecx,(%edx)
    2460:	89 c2                	mov    %eax,%edx
    2462:	8b 45 08             	mov    0x8(%ebp),%eax
    2465:	01 c2                	add    %eax,%edx
    2467:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    246a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    246d:	01 c8                	add    %ecx,%eax
    246f:	0f b6 00             	movzbl (%eax),%eax
    2472:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    2474:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    2478:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    247c:	79 d5                	jns    2453 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    247e:	90                   	nop
    247f:	83 c4 20             	add    $0x20,%esp
    2482:	5b                   	pop    %ebx
    2483:	5d                   	pop    %ebp
    2484:	c3                   	ret    

00002485 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    2485:	55                   	push   %ebp
    2486:	89 e5                	mov    %esp,%ebp
    2488:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    248b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    2492:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    2499:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    24a0:	8d 45 0c             	lea    0xc(%ebp),%eax
    24a3:	83 c0 04             	add    $0x4,%eax
    24a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    24a9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    24b0:	e9 d9 01 00 00       	jmp    268e <sprintf+0x209>
        c = fmt[i] & 0xff;
    24b5:	8b 55 0c             	mov    0xc(%ebp),%edx
    24b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    24bb:	01 d0                	add    %edx,%eax
    24bd:	0f b6 00             	movzbl (%eax),%eax
    24c0:	0f be c0             	movsbl %al,%eax
    24c3:	25 ff 00 00 00       	and    $0xff,%eax
    24c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    24cb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    24cf:	75 2c                	jne    24fd <sprintf+0x78>
            if(c == '%'){
    24d1:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    24d5:	75 0c                	jne    24e3 <sprintf+0x5e>
                state = '%';
    24d7:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    24de:	e9 a7 01 00 00       	jmp    268a <sprintf+0x205>
            } else {
                dst[j++] = c;
    24e3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    24e6:	8d 50 01             	lea    0x1(%eax),%edx
    24e9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    24ec:	89 c2                	mov    %eax,%edx
    24ee:	8b 45 08             	mov    0x8(%ebp),%eax
    24f1:	01 d0                	add    %edx,%eax
    24f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    24f6:	88 10                	mov    %dl,(%eax)
    24f8:	e9 8d 01 00 00       	jmp    268a <sprintf+0x205>
            }
        } else if(state == '%'){
    24fd:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    2501:	0f 85 83 01 00 00    	jne    268a <sprintf+0x205>
            if(c == 'd'){
    2507:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    250b:	75 4c                	jne    2559 <sprintf+0xd4>
                buf[bi] = '\0';
    250d:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2510:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2513:	01 d0                	add    %edx,%eax
    2515:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2518:	83 ec 0c             	sub    $0xc,%esp
    251b:	8d 45 ce             	lea    -0x32(%ebp),%eax
    251e:	50                   	push   %eax
    251f:	e8 e7 df ff ff       	call   50b <atoi>
    2524:	83 c4 10             	add    $0x10,%esp
    2527:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    252a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    2531:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2534:	8b 00                	mov    (%eax),%eax
    2536:	83 ec 08             	sub    $0x8,%esp
    2539:	ff 75 d8             	pushl  -0x28(%ebp)
    253c:	6a 01                	push   $0x1
    253e:	6a 0a                	push   $0xa
    2540:	50                   	push   %eax
    2541:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2544:	50                   	push   %eax
    2545:	ff 75 08             	pushl  0x8(%ebp)
    2548:	e8 56 fe ff ff       	call   23a3 <sprintint>
    254d:	83 c4 20             	add    $0x20,%esp
                ap++;
    2550:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2554:	e9 2a 01 00 00       	jmp    2683 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2559:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    255d:	74 06                	je     2565 <sprintf+0xe0>
    255f:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    2563:	75 4c                	jne    25b1 <sprintf+0x12c>
                buf[bi] = '\0';
    2565:	8d 55 ce             	lea    -0x32(%ebp),%edx
    2568:	8b 45 f0             	mov    -0x10(%ebp),%eax
    256b:	01 d0                	add    %edx,%eax
    256d:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2570:	83 ec 0c             	sub    $0xc,%esp
    2573:	8d 45 ce             	lea    -0x32(%ebp),%eax
    2576:	50                   	push   %eax
    2577:	e8 8f df ff ff       	call   50b <atoi>
    257c:	83 c4 10             	add    $0x10,%esp
    257f:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2582:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2589:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    258c:	8b 00                	mov    (%eax),%eax
    258e:	83 ec 08             	sub    $0x8,%esp
    2591:	ff 75 dc             	pushl  -0x24(%ebp)
    2594:	6a 00                	push   $0x0
    2596:	6a 10                	push   $0x10
    2598:	50                   	push   %eax
    2599:	8d 45 c8             	lea    -0x38(%ebp),%eax
    259c:	50                   	push   %eax
    259d:	ff 75 08             	pushl  0x8(%ebp)
    25a0:	e8 fe fd ff ff       	call   23a3 <sprintint>
    25a5:	83 c4 20             	add    $0x20,%esp
                ap++;
    25a8:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    25ac:	e9 d2 00 00 00       	jmp    2683 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    25b1:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    25b5:	75 46                	jne    25fd <sprintf+0x178>
                s = (char*)*ap;
    25b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    25ba:	8b 00                	mov    (%eax),%eax
    25bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    25bf:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    25c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    25c7:	75 25                	jne    25ee <sprintf+0x169>
                    s = "(null)";
    25c9:	c7 45 f4 78 28 00 00 	movl   $0x2878,-0xc(%ebp)
                while(*s != 0){
    25d0:	eb 1c                	jmp    25ee <sprintf+0x169>
                    dst[j++] = *s;
    25d2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    25d5:	8d 50 01             	lea    0x1(%eax),%edx
    25d8:	89 55 c8             	mov    %edx,-0x38(%ebp)
    25db:	89 c2                	mov    %eax,%edx
    25dd:	8b 45 08             	mov    0x8(%ebp),%eax
    25e0:	01 c2                	add    %eax,%edx
    25e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25e5:	0f b6 00             	movzbl (%eax),%eax
    25e8:	88 02                	mov    %al,(%edx)
                    s++;
    25ea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    25ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25f1:	0f b6 00             	movzbl (%eax),%eax
    25f4:	84 c0                	test   %al,%al
    25f6:	75 da                	jne    25d2 <sprintf+0x14d>
    25f8:	e9 86 00 00 00       	jmp    2683 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    25fd:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    2601:	75 1d                	jne    2620 <sprintf+0x19b>
                dst[j++] = *ap;
    2603:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2606:	8d 50 01             	lea    0x1(%eax),%edx
    2609:	89 55 c8             	mov    %edx,-0x38(%ebp)
    260c:	89 c2                	mov    %eax,%edx
    260e:	8b 45 08             	mov    0x8(%ebp),%eax
    2611:	01 c2                	add    %eax,%edx
    2613:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2616:	8b 00                	mov    (%eax),%eax
    2618:	88 02                	mov    %al,(%edx)
                ap++;
    261a:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    261e:	eb 63                	jmp    2683 <sprintf+0x1fe>
            } else if(c == '%'){
    2620:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    2624:	75 17                	jne    263d <sprintf+0x1b8>
                dst[j++] = c;
    2626:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2629:	8d 50 01             	lea    0x1(%eax),%edx
    262c:	89 55 c8             	mov    %edx,-0x38(%ebp)
    262f:	89 c2                	mov    %eax,%edx
    2631:	8b 45 08             	mov    0x8(%ebp),%eax
    2634:	01 d0                	add    %edx,%eax
    2636:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2639:	88 10                	mov    %dl,(%eax)
    263b:	eb 46                	jmp    2683 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    263d:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2641:	7e 18                	jle    265b <sprintf+0x1d6>
    2643:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    2647:	7f 12                	jg     265b <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2649:	8b 45 f0             	mov    -0x10(%ebp),%eax
    264c:	8d 50 01             	lea    0x1(%eax),%edx
    264f:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2652:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2655:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2659:	eb 2f                	jmp    268a <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    265b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    265e:	8d 50 01             	lea    0x1(%eax),%edx
    2661:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2664:	89 c2                	mov    %eax,%edx
    2666:	8b 45 08             	mov    0x8(%ebp),%eax
    2669:	01 d0                	add    %edx,%eax
    266b:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    266e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2671:	8d 50 01             	lea    0x1(%eax),%edx
    2674:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2677:	89 c2                	mov    %eax,%edx
    2679:	8b 45 08             	mov    0x8(%ebp),%eax
    267c:	01 d0                	add    %edx,%eax
    267e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2681:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    2683:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    268a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    268e:	8b 55 0c             	mov    0xc(%ebp),%edx
    2691:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2694:	01 d0                	add    %edx,%eax
    2696:	0f b6 00             	movzbl (%eax),%eax
    2699:	84 c0                	test   %al,%al
    269b:	0f 85 14 fe ff ff    	jne    24b5 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    26a1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    26a4:	8d 50 01             	lea    0x1(%eax),%edx
    26a7:	89 55 c8             	mov    %edx,-0x38(%ebp)
    26aa:	89 c2                	mov    %eax,%edx
    26ac:	8b 45 08             	mov    0x8(%ebp),%eax
    26af:	01 d0                	add    %edx,%eax
    26b1:	c6 00 00             	movb   $0x0,(%eax)
}
    26b4:	90                   	nop
    26b5:	c9                   	leave  
    26b6:	c3                   	ret    
