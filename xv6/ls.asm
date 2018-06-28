
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
      68:	68 b8 28 00 00       	push   $0x28b8
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
      9a:	05 b8 28 00 00       	add    $0x28b8,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 57 03 00 00       	call   402 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 b8 28 00 00       	mov    $0x28b8,%eax
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
      e3:	68 80 21 00 00       	push   $0x2180
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
     116:	68 94 21 00 00       	push   $0x2194
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
     179:	68 a8 21 00 00       	push   $0x21a8
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
     1a8:	68 b5 21 00 00       	push   $0x21b5
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
     25c:	68 94 21 00 00       	push   $0x2194
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
     29c:	68 a8 21 00 00       	push   $0x21a8
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
     2fe:	68 c8 21 00 00       	push   $0x21c8
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
     6d8:	0f b6 80 90 28 00 00 	movzbl 0x2890(%eax),%eax
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
     816:	c7 45 f4 ca 21 00 00 	movl   $0x21ca,-0xc(%ebp)
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
     8dc:	a1 d0 28 00 00       	mov    0x28d0,%eax
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
     9a7:	a3 d0 28 00 00       	mov    %eax,0x28d0
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
     a08:	a1 d0 28 00 00       	mov    0x28d0,%eax
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
     a24:	a1 d0 28 00 00       	mov    0x28d0,%eax
     a29:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a2c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a30:	75 23                	jne    a55 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a32:	c7 45 f0 c8 28 00 00 	movl   $0x28c8,-0x10(%ebp)
     a39:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3c:	a3 d0 28 00 00       	mov    %eax,0x28d0
     a41:	a1 d0 28 00 00       	mov    0x28d0,%eax
     a46:	a3 c8 28 00 00       	mov    %eax,0x28c8
    base.s.size = 0;
     a4b:	c7 05 cc 28 00 00 00 	movl   $0x0,0x28cc
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
     aa8:	a3 d0 28 00 00       	mov    %eax,0x28d0
      return (void*)(p + 1);
     aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab0:	83 c0 08             	add    $0x8,%eax
     ab3:	eb 3b                	jmp    af0 <malloc+0xe1>
    }
    if(p == freep)
     ab5:	a1 d0 28 00 00       	mov    0x28d0,%eax
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
     bc5:	56                   	push   %esi
     bc6:	53                   	push   %ebx
     bc7:	83 ec 70             	sub    $0x70,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
     bca:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
     bd1:	8b 45 cc             	mov    -0x34(%ebp),%eax
     bd4:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
     bd7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
     bde:	83 ec 08             	sub    $0x8,%esp
     be1:	6a 00                	push   $0x0
     be3:	ff 75 0c             	pushl  0xc(%ebp)
     be6:	e8 f2 f9 ff ff       	call   5dd <open>
     beb:	83 c4 10             	add    $0x10,%esp
     bee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
     bf1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bf5:	79 2e                	jns    c25 <APLoadBitmap+0x63>
    {
        printf(1, "Cannot open %s\n", filename);
     bf7:	83 ec 04             	sub    $0x4,%esp
     bfa:	ff 75 0c             	pushl  0xc(%ebp)
     bfd:	68 d4 21 00 00       	push   $0x21d4
     c02:	6a 01                	push   $0x1
     c04:	e8 33 fb ff ff       	call   73c <printf>
     c09:	83 c4 10             	add    $0x10,%esp
        return bmp;
     c0c:	8b 45 08             	mov    0x8(%ebp),%eax
     c0f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c12:	89 10                	mov    %edx,(%eax)
     c14:	8b 55 cc             	mov    -0x34(%ebp),%edx
     c17:	89 50 04             	mov    %edx,0x4(%eax)
     c1a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     c1d:	89 50 08             	mov    %edx,0x8(%eax)
     c20:	e9 1b 02 00 00       	jmp    e40 <APLoadBitmap+0x27e>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
     c25:	83 ec 04             	sub    $0x4,%esp
     c28:	6a 10                	push   $0x10
     c2a:	8d 45 b8             	lea    -0x48(%ebp),%eax
     c2d:	50                   	push   %eax
     c2e:	ff 75 ec             	pushl  -0x14(%ebp)
     c31:	e8 7f f9 ff ff       	call   5b5 <read>
     c36:	83 c4 10             	add    $0x10,%esp
    printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
     c39:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
     c3d:	0f b7 f0             	movzwl %ax,%esi
     c40:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
     c44:	0f b7 d8             	movzwl %ax,%ebx
     c47:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     c4a:	8b 55 bc             	mov    -0x44(%ebp),%edx
     c4d:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
     c51:	0f b7 c0             	movzwl %ax,%eax
     c54:	83 ec 04             	sub    $0x4,%esp
     c57:	56                   	push   %esi
     c58:	53                   	push   %ebx
     c59:	51                   	push   %ecx
     c5a:	52                   	push   %edx
     c5b:	50                   	push   %eax
     c5c:	68 e4 21 00 00       	push   $0x21e4
     c61:	6a 01                	push   $0x1
     c63:	e8 d4 fa ff ff       	call   73c <printf>
     c68:	83 c4 20             	add    $0x20,%esp
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
     c6b:	83 ec 04             	sub    $0x4,%esp
     c6e:	6a 28                	push   $0x28
     c70:	8d 45 90             	lea    -0x70(%ebp),%eax
     c73:	50                   	push   %eax
     c74:	ff 75 ec             	pushl  -0x14(%ebp)
     c77:	e8 39 f9 ff ff       	call   5b5 <read>
     c7c:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
     c7f:	8b 45 94             	mov    -0x6c(%ebp),%eax
     c82:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
     c85:	8b 45 98             	mov    -0x68(%ebp),%eax
     c88:	89 45 cc             	mov    %eax,-0x34(%ebp)
    printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
     c8b:	8b 55 c8             	mov    -0x38(%ebp),%edx
     c8e:	8b 45 cc             	mov    -0x34(%ebp),%eax
     c91:	52                   	push   %edx
     c92:	50                   	push   %eax
     c93:	68 f4 21 00 00       	push   $0x21f4
     c98:	6a 01                	push   $0x1
     c9a:	e8 9d fa ff ff       	call   73c <printf>
     c9f:	83 c4 10             	add    $0x10,%esp
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
     ca2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ca5:	8b 45 cc             	mov    -0x34(%ebp),%eax
     ca8:	0f af d0             	imul   %eax,%edx
     cab:	89 d0                	mov    %edx,%eax
     cad:	01 c0                	add    %eax,%eax
     caf:	01 d0                	add    %edx,%eax
     cb1:	83 ec 0c             	sub    $0xc,%esp
     cb4:	50                   	push   %eax
     cb5:	e8 55 fd ff ff       	call   a0f <malloc>
     cba:	83 c4 10             	add    $0x10,%esp
     cbd:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
     cc0:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     cc4:	0f b7 c0             	movzwl %ax,%eax
     cc7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
     cca:	8b 55 c8             	mov    -0x38(%ebp),%edx
     ccd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cd0:	0f af c2             	imul   %edx,%eax
     cd3:	83 c0 1f             	add    $0x1f,%eax
     cd6:	c1 e8 05             	shr    $0x5,%eax
     cd9:	c1 e0 02             	shl    $0x2,%eax
     cdc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
     cdf:	8b 55 cc             	mov    -0x34(%ebp),%edx
     ce2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ce5:	0f af c2             	imul   %edx,%eax
     ce8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
     ceb:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cee:	83 ec 0c             	sub    $0xc,%esp
     cf1:	50                   	push   %eax
     cf2:	e8 18 fd ff ff       	call   a0f <malloc>
     cf7:	83 c4 10             	add    $0x10,%esp
     cfa:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
     cfd:	83 ec 04             	sub    $0x4,%esp
     d00:	ff 75 e0             	pushl  -0x20(%ebp)
     d03:	ff 75 dc             	pushl  -0x24(%ebp)
     d06:	ff 75 ec             	pushl  -0x14(%ebp)
     d09:	e8 a7 f8 ff ff       	call   5b5 <read>
     d0e:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
     d11:	0f b7 45 9e          	movzwl -0x62(%ebp),%eax
     d15:	66 c1 e8 03          	shr    $0x3,%ax
     d19:	0f b7 c0             	movzwl %ax,%eax
     d1c:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
     d1f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d26:	e9 e5 00 00 00       	jmp    e10 <APLoadBitmap+0x24e>
    {
        int off = (bmp.height - j - 1) * bmp.width;
     d2b:	8b 55 cc             	mov    -0x34(%ebp),%edx
     d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d31:	29 c2                	sub    %eax,%edx
     d33:	89 d0                	mov    %edx,%eax
     d35:	8d 50 ff             	lea    -0x1(%eax),%edx
     d38:	8b 45 c8             	mov    -0x38(%ebp),%eax
     d3b:	0f af c2             	imul   %edx,%eax
     d3e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
     d41:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     d48:	e9 b1 00 00 00       	jmp    dfe <APLoadBitmap+0x23c>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
     d4d:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d50:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d53:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d56:	01 c8                	add    %ecx,%eax
     d58:	89 c1                	mov    %eax,%ecx
     d5a:	89 c8                	mov    %ecx,%eax
     d5c:	01 c0                	add    %eax,%eax
     d5e:	01 c8                	add    %ecx,%eax
     d60:	01 c2                	add    %eax,%edx
     d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d65:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     d69:	89 c1                	mov    %eax,%ecx
     d6b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d6e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     d72:	01 c1                	add    %eax,%ecx
     d74:	8b 45 d8             	mov    -0x28(%ebp),%eax
     d77:	01 c8                	add    %ecx,%eax
     d79:	8d 48 ff             	lea    -0x1(%eax),%ecx
     d7c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d7f:	01 c8                	add    %ecx,%eax
     d81:	0f b6 00             	movzbl (%eax),%eax
     d84:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
     d87:	8b 55 d0             	mov    -0x30(%ebp),%edx
     d8a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     d8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d90:	01 c8                	add    %ecx,%eax
     d92:	89 c1                	mov    %eax,%ecx
     d94:	89 c8                	mov    %ecx,%eax
     d96:	01 c0                	add    %eax,%eax
     d98:	01 c8                	add    %ecx,%eax
     d9a:	01 c2                	add    %eax,%edx
     d9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9f:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     da3:	89 c1                	mov    %eax,%ecx
     da5:	8b 45 d8             	mov    -0x28(%ebp),%eax
     da8:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     dac:	01 c1                	add    %eax,%ecx
     dae:	8b 45 d8             	mov    -0x28(%ebp),%eax
     db1:	01 c8                	add    %ecx,%eax
     db3:	8d 48 fe             	lea    -0x2(%eax),%ecx
     db6:	8b 45 dc             	mov    -0x24(%ebp),%eax
     db9:	01 c8                	add    %ecx,%eax
     dbb:	0f b6 00             	movzbl (%eax),%eax
     dbe:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
     dc1:	8b 55 d0             	mov    -0x30(%ebp),%edx
     dc4:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dca:	01 c8                	add    %ecx,%eax
     dcc:	89 c1                	mov    %eax,%ecx
     dce:	89 c8                	mov    %ecx,%eax
     dd0:	01 c0                	add    %eax,%eax
     dd2:	01 c8                	add    %ecx,%eax
     dd4:	01 c2                	add    %eax,%edx
     dd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd9:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
     ddd:	89 c1                	mov    %eax,%ecx
     ddf:	8b 45 d8             	mov    -0x28(%ebp),%eax
     de2:	0f af 45 f0          	imul   -0x10(%ebp),%eax
     de6:	01 c1                	add    %eax,%ecx
     de8:	8b 45 d8             	mov    -0x28(%ebp),%eax
     deb:	01 c8                	add    %ecx,%eax
     ded:	8d 48 fd             	lea    -0x3(%eax),%ecx
     df0:	8b 45 dc             	mov    -0x24(%ebp),%eax
     df3:	01 c8                	add    %ecx,%eax
     df5:	0f b6 00             	movzbl (%eax),%eax
     df8:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
     dfa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     dfe:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e01:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e04:	39 c2                	cmp    %eax,%edx
     e06:	0f 87 41 ff ff ff    	ja     d4d <APLoadBitmap+0x18b>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
     e0c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e10:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e16:	39 c2                	cmp    %eax,%edx
     e18:	0f 87 0d ff ff ff    	ja     d2b <APLoadBitmap+0x169>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
     e1e:	83 ec 0c             	sub    $0xc,%esp
     e21:	ff 75 ec             	pushl  -0x14(%ebp)
     e24:	e8 9c f7 ff ff       	call   5c5 <close>
     e29:	83 c4 10             	add    $0x10,%esp
    return bmp;
     e2c:	8b 45 08             	mov    0x8(%ebp),%eax
     e2f:	8b 55 c8             	mov    -0x38(%ebp),%edx
     e32:	89 10                	mov    %edx,(%eax)
     e34:	8b 55 cc             	mov    -0x34(%ebp),%edx
     e37:	89 50 04             	mov    %edx,0x4(%eax)
     e3a:	8b 55 d0             	mov    -0x30(%ebp),%edx
     e3d:	89 50 08             	mov    %edx,0x8(%eax)
}
     e40:	8b 45 08             	mov    0x8(%ebp),%eax
     e43:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e46:	5b                   	pop    %ebx
     e47:	5e                   	pop    %esi
     e48:	5d                   	pop    %ebp
     e49:	c2 04 00             	ret    $0x4

00000e4c <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
     e4c:	55                   	push   %ebp
     e4d:	89 e5                	mov    %esp,%ebp
     e4f:	53                   	push   %ebx
     e50:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
     e53:	83 ec 0c             	sub    $0xc,%esp
     e56:	6a 1c                	push   $0x1c
     e58:	e8 b2 fb ff ff       	call   a0f <malloc>
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
     e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e66:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
     e6d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     e70:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e73:	6a 0c                	push   $0xc
     e75:	6a 0c                	push   $0xc
     e77:	6a 0c                	push   $0xc
     e79:	50                   	push   %eax
     e7a:	e8 73 fc ff ff       	call   af2 <RGB>
     e7f:	83 c4 0c             	add    $0xc,%esp
     e82:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
     e86:	66 89 43 13          	mov    %ax,0x13(%ebx)
     e8a:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
     e8e:	88 43 15             	mov    %al,0x15(%ebx)
     e91:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e94:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e97:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
     e9b:	66 89 48 10          	mov    %cx,0x10(%eax)
     e9f:	0f b6 52 15          	movzbl 0x15(%edx),%edx
     ea3:	88 50 12             	mov    %dl,0x12(%eax)
     ea6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     eac:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
     eb0:	66 89 48 08          	mov    %cx,0x8(%eax)
     eb4:	0f b6 52 12          	movzbl 0x12(%edx),%edx
     eb8:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
     ebb:	8b 45 08             	mov    0x8(%ebp),%eax
     ebe:	89 c2                	mov    %eax,%edx
     ec0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec3:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
     ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec8:	89 c2                	mov    %eax,%edx
     eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ecd:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
     ed0:	8b 55 10             	mov    0x10(%ebp),%edx
     ed3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed6:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "%d %d\n", hdc->size.cx, hdc->size.cy);
    return hdc;
     ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     edc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     edf:	c9                   	leave  
     ee0:	c3                   	ret    

00000ee1 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
     ee1:	55                   	push   %ebp
     ee2:	89 e5                	mov    %esp,%ebp
     ee4:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
     ee7:	8b 45 0c             	mov    0xc(%ebp),%eax
     eea:	8b 50 08             	mov    0x8(%eax),%edx
     eed:	89 55 f8             	mov    %edx,-0x8(%ebp)
     ef0:	8b 40 0c             	mov    0xc(%eax),%eax
     ef3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
     ef6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef9:	8b 55 10             	mov    0x10(%ebp),%edx
     efc:	89 50 08             	mov    %edx,0x8(%eax)
     eff:	8b 55 14             	mov    0x14(%ebp),%edx
     f02:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
     f05:	8b 45 08             	mov    0x8(%ebp),%eax
     f08:	8b 55 f8             	mov    -0x8(%ebp),%edx
     f0b:	89 10                	mov    %edx,(%eax)
     f0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     f10:	89 50 04             	mov    %edx,0x4(%eax)
}
     f13:	8b 45 08             	mov    0x8(%ebp),%eax
     f16:	c9                   	leave  
     f17:	c2 04 00             	ret    $0x4

00000f1a <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
     f1a:	55                   	push   %ebp
     f1b:	89 e5                	mov    %esp,%ebp
     f1d:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
     f20:	8b 45 0c             	mov    0xc(%ebp),%eax
     f23:	0f b7 50 10          	movzwl 0x10(%eax),%edx
     f27:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
     f2b:	0f b6 40 12          	movzbl 0x12(%eax),%eax
     f2f:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
     f32:	8b 45 0c             	mov    0xc(%ebp),%eax
     f35:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
     f39:	66 89 50 10          	mov    %dx,0x10(%eax)
     f3d:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
     f41:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
     f44:	8b 45 08             	mov    0x8(%ebp),%eax
     f47:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
     f4b:	66 89 10             	mov    %dx,(%eax)
     f4e:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
     f52:	88 50 02             	mov    %dl,0x2(%eax)
}
     f55:	8b 45 08             	mov    0x8(%ebp),%eax
     f58:	c9                   	leave  
     f59:	c2 04 00             	ret    $0x4

00000f5c <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
     f5c:	55                   	push   %ebp
     f5d:	89 e5                	mov    %esp,%ebp
     f5f:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
     f62:	8b 45 08             	mov    0x8(%ebp),%eax
     f65:	8b 40 0c             	mov    0xc(%eax),%eax
     f68:	89 c2                	mov    %eax,%edx
     f6a:	c1 ea 1f             	shr    $0x1f,%edx
     f6d:	01 d0                	add    %edx,%eax
     f6f:	d1 f8                	sar    %eax
     f71:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
     f74:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f77:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     f7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
     f7e:	8b 45 10             	mov    0x10(%ebp),%eax
     f81:	2b 45 f4             	sub    -0xc(%ebp),%eax
     f84:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
     f87:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     f8b:	0f 89 98 00 00 00    	jns    1029 <APDrawPoint+0xcd>
        i = 0;
     f91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
     f98:	e9 8c 00 00 00       	jmp    1029 <APDrawPoint+0xcd>
    {
        j = x - off;
     f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa0:	2b 45 f4             	sub    -0xc(%ebp),%eax
     fa3:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
     fa6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
     faa:	79 69                	jns    1015 <APDrawPoint+0xb9>
            j = 0;
     fac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
     fb3:	eb 60                	jmp    1015 <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
     fb5:	ff 75 fc             	pushl  -0x4(%ebp)
     fb8:	ff 75 f8             	pushl  -0x8(%ebp)
     fbb:	ff 75 08             	pushl  0x8(%ebp)
     fbe:	e8 ad fb ff ff       	call   b70 <APGetIndex>
     fc3:	83 c4 0c             	add    $0xc,%esp
     fc6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
     fc9:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
     fcd:	74 55                	je     1024 <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
     fcf:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
     fd3:	74 67                	je     103c <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
     fd5:	ff 75 10             	pushl  0x10(%ebp)
     fd8:	ff 75 0c             	pushl  0xc(%ebp)
     fdb:	ff 75 fc             	pushl  -0x4(%ebp)
     fde:	ff 75 f8             	pushl  -0x8(%ebp)
     fe1:	e8 51 fb ff ff       	call   b37 <distance_2>
     fe6:	83 c4 10             	add    $0x10,%esp
     fe9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     fec:	7f 23                	jg     1011 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
     fee:	8b 45 08             	mov    0x8(%ebp),%eax
     ff1:	8b 48 18             	mov    0x18(%eax),%ecx
     ff4:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ff7:	89 d0                	mov    %edx,%eax
     ff9:	01 c0                	add    %eax,%eax
     ffb:	01 d0                	add    %edx,%eax
     ffd:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    1000:	8b 45 08             	mov    0x8(%ebp),%eax
    1003:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    1007:	66 89 0a             	mov    %cx,(%edx)
    100a:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    100e:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    1011:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1015:	8b 55 0c             	mov    0xc(%ebp),%edx
    1018:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101b:	01 d0                	add    %edx,%eax
    101d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1020:	7d 93                	jge    fb5 <APDrawPoint+0x59>
    1022:	eb 01                	jmp    1025 <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    1024:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    1025:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1029:	8b 55 10             	mov    0x10(%ebp),%edx
    102c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102f:	01 d0                	add    %edx,%eax
    1031:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1034:	0f 8d 63 ff ff ff    	jge    f9d <APDrawPoint+0x41>
    103a:	eb 01                	jmp    103d <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    103c:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    103d:	c9                   	leave  
    103e:	c3                   	ret    

0000103f <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    103f:	55                   	push   %ebp
    1040:	89 e5                	mov    %esp,%ebp
    1042:	53                   	push   %ebx
    1043:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    1046:	8b 45 0c             	mov    0xc(%ebp),%eax
    1049:	3b 45 14             	cmp    0x14(%ebp),%eax
    104c:	0f 85 80 00 00 00    	jne    10d2 <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    1052:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1056:	0f 88 9d 02 00 00    	js     12f9 <APDrawLine+0x2ba>
    105c:	8b 45 08             	mov    0x8(%ebp),%eax
    105f:	8b 00                	mov    (%eax),%eax
    1061:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1064:	0f 8e 8f 02 00 00    	jle    12f9 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    106a:	8b 45 10             	mov    0x10(%ebp),%eax
    106d:	3b 45 18             	cmp    0x18(%ebp),%eax
    1070:	7e 12                	jle    1084 <APDrawLine+0x45>
        {
            int tmp = y2;
    1072:	8b 45 18             	mov    0x18(%ebp),%eax
    1075:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    1078:	8b 45 10             	mov    0x10(%ebp),%eax
    107b:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    107e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1081:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    1084:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1088:	79 07                	jns    1091 <APDrawLine+0x52>
    108a:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    1091:	8b 45 08             	mov    0x8(%ebp),%eax
    1094:	8b 40 04             	mov    0x4(%eax),%eax
    1097:	3b 45 18             	cmp    0x18(%ebp),%eax
    109a:	7d 0c                	jge    10a8 <APDrawLine+0x69>
    109c:	8b 45 08             	mov    0x8(%ebp),%eax
    109f:	8b 40 04             	mov    0x4(%eax),%eax
    10a2:	83 e8 01             	sub    $0x1,%eax
    10a5:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    10a8:	8b 45 10             	mov    0x10(%ebp),%eax
    10ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    10ae:	eb 15                	jmp    10c5 <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    10b0:	ff 75 f4             	pushl  -0xc(%ebp)
    10b3:	ff 75 0c             	pushl  0xc(%ebp)
    10b6:	ff 75 08             	pushl  0x8(%ebp)
    10b9:	e8 9e fe ff ff       	call   f5c <APDrawPoint>
    10be:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    10c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10c8:	3b 45 18             	cmp    0x18(%ebp),%eax
    10cb:	7e e3                	jle    10b0 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    10cd:	e9 2b 02 00 00       	jmp    12fd <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    10d2:	8b 45 10             	mov    0x10(%ebp),%eax
    10d5:	3b 45 18             	cmp    0x18(%ebp),%eax
    10d8:	75 7f                	jne    1159 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    10da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    10de:	0f 88 18 02 00 00    	js     12fc <APDrawLine+0x2bd>
    10e4:	8b 45 08             	mov    0x8(%ebp),%eax
    10e7:	8b 40 04             	mov    0x4(%eax),%eax
    10ea:	3b 45 10             	cmp    0x10(%ebp),%eax
    10ed:	0f 8e 09 02 00 00    	jle    12fc <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    10f3:	8b 45 0c             	mov    0xc(%ebp),%eax
    10f6:	3b 45 14             	cmp    0x14(%ebp),%eax
    10f9:	7e 12                	jle    110d <APDrawLine+0xce>
        {
            int tmp = x2;
    10fb:	8b 45 14             	mov    0x14(%ebp),%eax
    10fe:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    1101:	8b 45 0c             	mov    0xc(%ebp),%eax
    1104:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    1107:	8b 45 d8             	mov    -0x28(%ebp),%eax
    110a:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    110d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1111:	79 07                	jns    111a <APDrawLine+0xdb>
    1113:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    111a:	8b 45 08             	mov    0x8(%ebp),%eax
    111d:	8b 00                	mov    (%eax),%eax
    111f:	3b 45 14             	cmp    0x14(%ebp),%eax
    1122:	7d 0b                	jge    112f <APDrawLine+0xf0>
    1124:	8b 45 08             	mov    0x8(%ebp),%eax
    1127:	8b 00                	mov    (%eax),%eax
    1129:	83 e8 01             	sub    $0x1,%eax
    112c:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    112f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1132:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1135:	eb 15                	jmp    114c <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    1137:	ff 75 10             	pushl  0x10(%ebp)
    113a:	ff 75 f0             	pushl  -0x10(%ebp)
    113d:	ff 75 08             	pushl  0x8(%ebp)
    1140:	e8 17 fe ff ff       	call   f5c <APDrawPoint>
    1145:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    1148:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    114c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    114f:	3b 45 14             	cmp    0x14(%ebp),%eax
    1152:	7e e3                	jle    1137 <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    1154:	e9 a4 01 00 00       	jmp    12fd <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    1159:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1160:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    1167:	8b 45 0c             	mov    0xc(%ebp),%eax
    116a:	2b 45 14             	sub    0x14(%ebp),%eax
    116d:	50                   	push   %eax
    116e:	e8 ed f9 ff ff       	call   b60 <abs_int>
    1173:	83 c4 04             	add    $0x4,%esp
    1176:	89 c3                	mov    %eax,%ebx
    1178:	8b 45 10             	mov    0x10(%ebp),%eax
    117b:	2b 45 18             	sub    0x18(%ebp),%eax
    117e:	50                   	push   %eax
    117f:	e8 dc f9 ff ff       	call   b60 <abs_int>
    1184:	83 c4 04             	add    $0x4,%esp
    1187:	39 c3                	cmp    %eax,%ebx
    1189:	0f 8e b5 00 00 00    	jle    1244 <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    118f:	8b 45 10             	mov    0x10(%ebp),%eax
    1192:	2b 45 18             	sub    0x18(%ebp),%eax
    1195:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1198:	db 45 b0             	fildl  -0x50(%ebp)
    119b:	8b 45 0c             	mov    0xc(%ebp),%eax
    119e:	2b 45 14             	sub    0x14(%ebp),%eax
    11a1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    11a4:	db 45 b0             	fildl  -0x50(%ebp)
    11a7:	de f9                	fdivrp %st,%st(1)
    11a9:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    11ac:	8b 45 14             	mov    0x14(%ebp),%eax
    11af:	3b 45 0c             	cmp    0xc(%ebp),%eax
    11b2:	7e 0e                	jle    11c2 <APDrawLine+0x183>
        {
            s = x1;
    11b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    11b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    11ba:	8b 45 14             	mov    0x14(%ebp),%eax
    11bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    11c0:	eb 0c                	jmp    11ce <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    11c2:	8b 45 14             	mov    0x14(%ebp),%eax
    11c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    11c8:	8b 45 0c             	mov    0xc(%ebp),%eax
    11cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    11ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11d2:	79 07                	jns    11db <APDrawLine+0x19c>
    11d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    11db:	8b 45 08             	mov    0x8(%ebp),%eax
    11de:	8b 00                	mov    (%eax),%eax
    11e0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    11e3:	7f 0b                	jg     11f0 <APDrawLine+0x1b1>
    11e5:	8b 45 08             	mov    0x8(%ebp),%eax
    11e8:	8b 00                	mov    (%eax),%eax
    11ea:	83 e8 01             	sub    $0x1,%eax
    11ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    11f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    11f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11f6:	eb 3f                	jmp    1237 <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    11f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11fb:	2b 45 0c             	sub    0xc(%ebp),%eax
    11fe:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1201:	db 45 b0             	fildl  -0x50(%ebp)
    1204:	dc 4d d0             	fmull  -0x30(%ebp)
    1207:	db 45 10             	fildl  0x10(%ebp)
    120a:	de c1                	faddp  %st,%st(1)
    120c:	d9 7d b6             	fnstcw -0x4a(%ebp)
    120f:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    1213:	b4 0c                	mov    $0xc,%ah
    1215:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    1219:	d9 6d b4             	fldcw  -0x4c(%ebp)
    121c:	db 5d cc             	fistpl -0x34(%ebp)
    121f:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    1222:	ff 75 cc             	pushl  -0x34(%ebp)
    1225:	ff 75 e4             	pushl  -0x1c(%ebp)
    1228:	ff 75 08             	pushl  0x8(%ebp)
    122b:	e8 2c fd ff ff       	call   f5c <APDrawPoint>
    1230:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    1233:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1237:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    123a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    123d:	7e b9                	jle    11f8 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    123f:	e9 b9 00 00 00       	jmp    12fd <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    1244:	8b 45 0c             	mov    0xc(%ebp),%eax
    1247:	2b 45 14             	sub    0x14(%ebp),%eax
    124a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    124d:	db 45 b0             	fildl  -0x50(%ebp)
    1250:	8b 45 10             	mov    0x10(%ebp),%eax
    1253:	2b 45 18             	sub    0x18(%ebp),%eax
    1256:	89 45 b0             	mov    %eax,-0x50(%ebp)
    1259:	db 45 b0             	fildl  -0x50(%ebp)
    125c:	de f9                	fdivrp %st,%st(1)
    125e:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    1261:	8b 45 10             	mov    0x10(%ebp),%eax
    1264:	3b 45 18             	cmp    0x18(%ebp),%eax
    1267:	7e 0e                	jle    1277 <APDrawLine+0x238>
    {
        s = y2;
    1269:	8b 45 18             	mov    0x18(%ebp),%eax
    126c:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    126f:	8b 45 10             	mov    0x10(%ebp),%eax
    1272:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1275:	eb 0c                	jmp    1283 <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    1277:	8b 45 10             	mov    0x10(%ebp),%eax
    127a:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    127d:	8b 45 18             	mov    0x18(%ebp),%eax
    1280:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    1283:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1287:	79 07                	jns    1290 <APDrawLine+0x251>
    1289:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    1290:	8b 45 08             	mov    0x8(%ebp),%eax
    1293:	8b 40 04             	mov    0x4(%eax),%eax
    1296:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    1299:	7f 0c                	jg     12a7 <APDrawLine+0x268>
    129b:	8b 45 08             	mov    0x8(%ebp),%eax
    129e:	8b 40 04             	mov    0x4(%eax),%eax
    12a1:	83 e8 01             	sub    $0x1,%eax
    12a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    12a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
    12ad:	eb 3f                	jmp    12ee <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    12af:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12b2:	2b 45 10             	sub    0x10(%ebp),%eax
    12b5:	89 45 b0             	mov    %eax,-0x50(%ebp)
    12b8:	db 45 b0             	fildl  -0x50(%ebp)
    12bb:	dc 4d c0             	fmull  -0x40(%ebp)
    12be:	db 45 0c             	fildl  0xc(%ebp)
    12c1:	de c1                	faddp  %st,%st(1)
    12c3:	d9 7d b6             	fnstcw -0x4a(%ebp)
    12c6:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    12ca:	b4 0c                	mov    $0xc,%ah
    12cc:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    12d0:	d9 6d b4             	fldcw  -0x4c(%ebp)
    12d3:	db 5d bc             	fistpl -0x44(%ebp)
    12d6:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    12d9:	ff 75 e0             	pushl  -0x20(%ebp)
    12dc:	ff 75 bc             	pushl  -0x44(%ebp)
    12df:	ff 75 08             	pushl  0x8(%ebp)
    12e2:	e8 75 fc ff ff       	call   f5c <APDrawPoint>
    12e7:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    12ea:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    12ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
    12f1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    12f4:	7e b9                	jle    12af <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    12f6:	90                   	nop
    12f7:	eb 04                	jmp    12fd <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    12f9:	90                   	nop
    12fa:	eb 01                	jmp    12fd <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    12fc:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    12fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1300:	c9                   	leave  
    1301:	c3                   	ret    

00001302 <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    1302:	55                   	push   %ebp
    1303:	89 e5                	mov    %esp,%ebp
    1305:	53                   	push   %ebx
    1306:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    1309:	8b 55 10             	mov    0x10(%ebp),%edx
    130c:	8b 45 18             	mov    0x18(%ebp),%eax
    130f:	01 d0                	add    %edx,%eax
    1311:	83 e8 01             	sub    $0x1,%eax
    1314:	83 ec 04             	sub    $0x4,%esp
    1317:	50                   	push   %eax
    1318:	ff 75 0c             	pushl  0xc(%ebp)
    131b:	ff 75 10             	pushl  0x10(%ebp)
    131e:	ff 75 0c             	pushl  0xc(%ebp)
    1321:	ff 75 08             	pushl  0x8(%ebp)
    1324:	e8 16 fd ff ff       	call   103f <APDrawLine>
    1329:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    132c:	8b 55 0c             	mov    0xc(%ebp),%edx
    132f:	8b 45 14             	mov    0x14(%ebp),%eax
    1332:	01 d0                	add    %edx,%eax
    1334:	83 e8 01             	sub    $0x1,%eax
    1337:	83 ec 04             	sub    $0x4,%esp
    133a:	ff 75 10             	pushl  0x10(%ebp)
    133d:	50                   	push   %eax
    133e:	ff 75 10             	pushl  0x10(%ebp)
    1341:	ff 75 0c             	pushl  0xc(%ebp)
    1344:	ff 75 08             	pushl  0x8(%ebp)
    1347:	e8 f3 fc ff ff       	call   103f <APDrawLine>
    134c:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    134f:	8b 55 10             	mov    0x10(%ebp),%edx
    1352:	8b 45 18             	mov    0x18(%ebp),%eax
    1355:	01 d0                	add    %edx,%eax
    1357:	8d 48 ff             	lea    -0x1(%eax),%ecx
    135a:	8b 55 0c             	mov    0xc(%ebp),%edx
    135d:	8b 45 14             	mov    0x14(%ebp),%eax
    1360:	01 d0                	add    %edx,%eax
    1362:	8d 50 ff             	lea    -0x1(%eax),%edx
    1365:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    1368:	8b 45 14             	mov    0x14(%ebp),%eax
    136b:	01 d8                	add    %ebx,%eax
    136d:	83 e8 01             	sub    $0x1,%eax
    1370:	83 ec 04             	sub    $0x4,%esp
    1373:	51                   	push   %ecx
    1374:	52                   	push   %edx
    1375:	ff 75 10             	pushl  0x10(%ebp)
    1378:	50                   	push   %eax
    1379:	ff 75 08             	pushl  0x8(%ebp)
    137c:	e8 be fc ff ff       	call   103f <APDrawLine>
    1381:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    1384:	8b 55 10             	mov    0x10(%ebp),%edx
    1387:	8b 45 18             	mov    0x18(%ebp),%eax
    138a:	01 d0                	add    %edx,%eax
    138c:	8d 48 ff             	lea    -0x1(%eax),%ecx
    138f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1392:	8b 45 14             	mov    0x14(%ebp),%eax
    1395:	01 d0                	add    %edx,%eax
    1397:	8d 50 ff             	lea    -0x1(%eax),%edx
    139a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    139d:	8b 45 18             	mov    0x18(%ebp),%eax
    13a0:	01 d8                	add    %ebx,%eax
    13a2:	83 e8 01             	sub    $0x1,%eax
    13a5:	83 ec 04             	sub    $0x4,%esp
    13a8:	51                   	push   %ecx
    13a9:	52                   	push   %edx
    13aa:	50                   	push   %eax
    13ab:	ff 75 0c             	pushl  0xc(%ebp)
    13ae:	ff 75 08             	pushl  0x8(%ebp)
    13b1:	e8 89 fc ff ff       	call   103f <APDrawLine>
    13b6:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    13b9:	8b 55 0c             	mov    0xc(%ebp),%edx
    13bc:	8b 45 14             	mov    0x14(%ebp),%eax
    13bf:	01 d0                	add    %edx,%eax
    13c1:	8d 50 ff             	lea    -0x1(%eax),%edx
    13c4:	8b 45 08             	mov    0x8(%ebp),%eax
    13c7:	8b 40 0c             	mov    0xc(%eax),%eax
    13ca:	89 c1                	mov    %eax,%ecx
    13cc:	c1 e9 1f             	shr    $0x1f,%ecx
    13cf:	01 c8                	add    %ecx,%eax
    13d1:	d1 f8                	sar    %eax
    13d3:	29 c2                	sub    %eax,%edx
    13d5:	89 d0                	mov    %edx,%eax
    13d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    13da:	8b 55 10             	mov    0x10(%ebp),%edx
    13dd:	8b 45 18             	mov    0x18(%ebp),%eax
    13e0:	01 d0                	add    %edx,%eax
    13e2:	8d 50 ff             	lea    -0x1(%eax),%edx
    13e5:	8b 45 08             	mov    0x8(%ebp),%eax
    13e8:	8b 40 0c             	mov    0xc(%eax),%eax
    13eb:	89 c1                	mov    %eax,%ecx
    13ed:	c1 e9 1f             	shr    $0x1f,%ecx
    13f0:	01 c8                	add    %ecx,%eax
    13f2:	d1 f8                	sar    %eax
    13f4:	29 c2                	sub    %eax,%edx
    13f6:	89 d0                	mov    %edx,%eax
    13f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    13fb:	8b 45 08             	mov    0x8(%ebp),%eax
    13fe:	8b 40 0c             	mov    0xc(%eax),%eax
    1401:	89 c2                	mov    %eax,%edx
    1403:	c1 ea 1f             	shr    $0x1f,%edx
    1406:	01 d0                	add    %edx,%eax
    1408:	d1 f8                	sar    %eax
    140a:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    140d:	8b 45 08             	mov    0x8(%ebp),%eax
    1410:	8b 40 0c             	mov    0xc(%eax),%eax
    1413:	89 c2                	mov    %eax,%edx
    1415:	c1 ea 1f             	shr    $0x1f,%edx
    1418:	01 d0                	add    %edx,%eax
    141a:	d1 f8                	sar    %eax
    141c:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    141f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1423:	0f 88 d8 00 00 00    	js     1501 <APDrawRect+0x1ff>
    1429:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    142d:	0f 88 ce 00 00 00    	js     1501 <APDrawRect+0x1ff>
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	8b 00                	mov    (%eax),%eax
    1438:	3b 45 0c             	cmp    0xc(%ebp),%eax
    143b:	0f 8e c0 00 00 00    	jle    1501 <APDrawRect+0x1ff>
    1441:	8b 45 08             	mov    0x8(%ebp),%eax
    1444:	8b 40 04             	mov    0x4(%eax),%eax
    1447:	3b 45 10             	cmp    0x10(%ebp),%eax
    144a:	0f 8e b1 00 00 00    	jle    1501 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    1450:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1454:	79 07                	jns    145d <APDrawRect+0x15b>
    1456:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    145d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1461:	79 07                	jns    146a <APDrawRect+0x168>
    1463:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    146a:	8b 45 08             	mov    0x8(%ebp),%eax
    146d:	8b 00                	mov    (%eax),%eax
    146f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1472:	7f 0b                	jg     147f <APDrawRect+0x17d>
    1474:	8b 45 08             	mov    0x8(%ebp),%eax
    1477:	8b 00                	mov    (%eax),%eax
    1479:	83 e8 01             	sub    $0x1,%eax
    147c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    147f:	8b 45 08             	mov    0x8(%ebp),%eax
    1482:	8b 40 04             	mov    0x4(%eax),%eax
    1485:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1488:	7f 0c                	jg     1496 <APDrawRect+0x194>
    148a:	8b 45 08             	mov    0x8(%ebp),%eax
    148d:	8b 40 04             	mov    0x4(%eax),%eax
    1490:	83 e8 01             	sub    $0x1,%eax
    1493:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    1496:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    149d:	8b 45 0c             	mov    0xc(%ebp),%eax
    14a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    14a3:	eb 52                	jmp    14f7 <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    14a5:	8b 45 10             	mov    0x10(%ebp),%eax
    14a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14ab:	eb 3e                	jmp    14eb <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    14ad:	83 ec 04             	sub    $0x4,%esp
    14b0:	ff 75 e8             	pushl  -0x18(%ebp)
    14b3:	ff 75 ec             	pushl  -0x14(%ebp)
    14b6:	ff 75 08             	pushl  0x8(%ebp)
    14b9:	e8 b2 f6 ff ff       	call   b70 <APGetIndex>
    14be:	83 c4 10             	add    $0x10,%esp
    14c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    14c4:	8b 45 08             	mov    0x8(%ebp),%eax
    14c7:	8b 48 18             	mov    0x18(%eax),%ecx
    14ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    14cd:	89 d0                	mov    %edx,%eax
    14cf:	01 c0                	add    %eax,%eax
    14d1:	01 d0                	add    %edx,%eax
    14d3:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    14d6:	8b 45 08             	mov    0x8(%ebp),%eax
    14d9:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    14dd:	66 89 0a             	mov    %cx,(%edx)
    14e0:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    14e4:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    14e7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    14eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    14f1:	7e ba                	jle    14ad <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    14f3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14fa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    14fd:	7e a6                	jle    14a5 <APDrawRect+0x1a3>
    14ff:	eb 01                	jmp    1502 <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    1501:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    1502:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1505:	c9                   	leave  
    1506:	c3                   	ret    

00001507 <APDcCopy>:

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    1507:	55                   	push   %ebp
    1508:	89 e5                	mov    %esp,%ebp
    150a:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    150d:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    1511:	0f 88 8e 01 00 00    	js     16a5 <APDcCopy+0x19e>
    1517:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    151b:	0f 88 84 01 00 00    	js     16a5 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    1521:	8b 55 0c             	mov    0xc(%ebp),%edx
    1524:	8b 45 20             	mov    0x20(%ebp),%eax
    1527:	01 d0                	add    %edx,%eax
    1529:	89 45 fc             	mov    %eax,-0x4(%ebp)
    152c:	8b 55 10             	mov    0x10(%ebp),%edx
    152f:	8b 45 24             	mov    0x24(%ebp),%eax
    1532:	01 d0                	add    %edx,%eax
    1534:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w, y_r = y + h;
    1537:	8b 55 18             	mov    0x18(%ebp),%edx
    153a:	8b 45 20             	mov    0x20(%ebp),%eax
    153d:	01 d0                	add    %edx,%eax
    153f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1542:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1545:	8b 45 24             	mov    0x24(%ebp),%eax
    1548:	01 d0                	add    %edx,%eax
    154a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
    154d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1551:	0f 88 51 01 00 00    	js     16a8 <APDcCopy+0x1a1>
    1557:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    155b:	0f 88 47 01 00 00    	js     16a8 <APDcCopy+0x1a1>
    1561:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1565:	0f 88 3d 01 00 00    	js     16a8 <APDcCopy+0x1a1>
    156b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    156f:	0f 88 33 01 00 00    	js     16a8 <APDcCopy+0x1a1>
    1575:	8b 45 14             	mov    0x14(%ebp),%eax
    1578:	8b 00                	mov    (%eax),%eax
    157a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    157d:	0f 8e 25 01 00 00    	jle    16a8 <APDcCopy+0x1a1>
    1583:	8b 45 14             	mov    0x14(%ebp),%eax
    1586:	8b 40 04             	mov    0x4(%eax),%eax
    1589:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    158c:	0f 8e 16 01 00 00    	jle    16a8 <APDcCopy+0x1a1>
        return;
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    1592:	8b 45 08             	mov    0x8(%ebp),%eax
    1595:	8b 00                	mov    (%eax),%eax
    1597:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    159a:	7d 0b                	jge    15a7 <APDcCopy+0xa0>
    159c:	8b 45 08             	mov    0x8(%ebp),%eax
    159f:	8b 00                	mov    (%eax),%eax
    15a1:	83 e8 01             	sub    $0x1,%eax
    15a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    15a7:	8b 45 08             	mov    0x8(%ebp),%eax
    15aa:	8b 40 04             	mov    0x4(%eax),%eax
    15ad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    15b0:	7d 0c                	jge    15be <APDcCopy+0xb7>
    15b2:	8b 45 08             	mov    0x8(%ebp),%eax
    15b5:	8b 40 04             	mov    0x4(%eax),%eax
    15b8:	83 e8 01             	sub    $0x1,%eax
    15bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    15be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    15c5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j < wy_r - wy; j++)
    15cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    15d3:	e9 bc 00 00 00       	jmp    1694 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	8b 00                	mov    (%eax),%eax
    15dd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15e0:	8b 55 10             	mov    0x10(%ebp),%edx
    15e3:	01 ca                	add    %ecx,%edx
    15e5:	0f af d0             	imul   %eax,%edx
    15e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    15eb:	01 d0                	add    %edx,%eax
    15ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    15f0:	8b 45 14             	mov    0x14(%ebp),%eax
    15f3:	8b 00                	mov    (%eax),%eax
    15f5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    15f8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    15fb:	01 ca                	add    %ecx,%edx
    15fd:	0f af d0             	imul   %eax,%edx
    1600:	8b 45 18             	mov    0x18(%ebp),%eax
    1603:	01 d0                	add    %edx,%eax
    1605:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i < wx_r - wx; i++)
    1608:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    160f:	eb 74                	jmp    1685 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    1611:	8b 45 14             	mov    0x14(%ebp),%eax
    1614:	8b 50 18             	mov    0x18(%eax),%edx
    1617:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    161a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161d:	01 c8                	add    %ecx,%eax
    161f:	89 c1                	mov    %eax,%ecx
    1621:	89 c8                	mov    %ecx,%eax
    1623:	01 c0                	add    %eax,%eax
    1625:	01 c8                	add    %ecx,%eax
    1627:	01 d0                	add    %edx,%eax
    1629:	0f b7 10             	movzwl (%eax),%edx
    162c:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    1630:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1634:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    1637:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    163b:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    163f:	38 c2                	cmp    %al,%dl
    1641:	75 18                	jne    165b <APDcCopy+0x154>
    1643:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    1647:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    164b:	38 c2                	cmp    %al,%dl
    164d:	75 0c                	jne    165b <APDcCopy+0x154>
    164f:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    1653:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    1657:	38 c2                	cmp    %al,%dl
    1659:	74 26                	je     1681 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    165b:	8b 45 08             	mov    0x8(%ebp),%eax
    165e:	8b 50 18             	mov    0x18(%eax),%edx
    1661:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1664:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1667:	01 c8                	add    %ecx,%eax
    1669:	89 c1                	mov    %eax,%ecx
    166b:	89 c8                	mov    %ecx,%eax
    166d:	01 c0                	add    %eax,%eax
    166f:	01 c8                	add    %ecx,%eax
    1671:	01 d0                	add    %edx,%eax
    1673:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    1677:	66 89 10             	mov    %dx,(%eax)
    167a:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    167e:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i < wx_r - wx; i++)
    1681:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1685:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1688:	2b 45 0c             	sub    0xc(%ebp),%eax
    168b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    168e:	7f 81                	jg     1611 <APDcCopy+0x10a>
    
    if (wx_r > dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r > dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j < wy_r - wy; j++)
    1690:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1694:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1697:	2b 45 10             	sub    0x10(%ebp),%eax
    169a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    169d:	0f 8f 35 ff ff ff    	jg     15d8 <APDcCopy+0xd1>
    16a3:	eb 04                	jmp    16a9 <APDcCopy+0x1a2>
}

//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    16a5:	90                   	nop
    16a6:	eb 01                	jmp    16a9 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w, y_r = y + h;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r >= src->size.cx || y_r >= src->size.cy)
        return;
    16a8:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    16a9:	c9                   	leave  
    16aa:	c3                   	ret    

000016ab <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    16ab:	55                   	push   %ebp
    16ac:	89 e5                	mov    %esp,%ebp
    16ae:	83 ec 1c             	sub    $0x1c,%esp
    16b1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    16b4:	8b 55 10             	mov    0x10(%ebp),%edx
    16b7:	8b 45 14             	mov    0x14(%ebp),%eax
    16ba:	88 4d ec             	mov    %cl,-0x14(%ebp)
    16bd:	88 55 e8             	mov    %dl,-0x18(%ebp)
    16c0:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    16c3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    16c7:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    16ca:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    16ce:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    16d1:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    16d5:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    16d8:	8b 45 08             	mov    0x8(%ebp),%eax
    16db:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    16df:	66 89 10             	mov    %dx,(%eax)
    16e2:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    16e6:	88 50 02             	mov    %dl,0x2(%eax)
}
    16e9:	8b 45 08             	mov    0x8(%ebp),%eax
    16ec:	c9                   	leave  
    16ed:	c2 04 00             	ret    $0x4

000016f0 <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    16f6:	8b 45 08             	mov    0x8(%ebp),%eax
    16f9:	8b 00                	mov    (%eax),%eax
    16fb:	83 ec 08             	sub    $0x8,%esp
    16fe:	8d 55 0c             	lea    0xc(%ebp),%edx
    1701:	52                   	push   %edx
    1702:	50                   	push   %eax
    1703:	e8 45 ef ff ff       	call   64d <sendMessage>
    1708:	83 c4 10             	add    $0x10,%esp
}
    170b:	90                   	nop
    170c:	c9                   	leave  
    170d:	c3                   	ret    

0000170e <APCreateWindow>:



AHwnd APCreateWindow(char * title,int is_map,int page)
{
    170e:	55                   	push   %ebp
    170f:	89 e5                	mov    %esp,%ebp
    1711:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    1714:	83 ec 0c             	sub    $0xc,%esp
    1717:	68 90 00 00 00       	push   $0x90
    171c:	e8 ee f2 ff ff       	call   a0f <malloc>
    1721:	83 c4 10             	add    $0x10,%esp
    1724:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    1727:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    172b:	75 15                	jne    1742 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    172d:	83 ec 04             	sub    $0x4,%esp
    1730:	ff 75 08             	pushl  0x8(%ebp)
    1733:	68 18 22 00 00       	push   $0x2218
    1738:	6a 01                	push   $0x1
    173a:	e8 fd ef ff ff       	call   73c <printf>
    173f:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    1742:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1745:	83 c0 7c             	add    $0x7c,%eax
    1748:	83 ec 08             	sub    $0x8,%esp
    174b:	ff 75 08             	pushl  0x8(%ebp)
    174e:	50                   	push   %eax
    174f:	e8 18 ec ff ff       	call   36c <strcpy>
    1754:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    1757:	8b 45 f4             	mov    -0xc(%ebp),%eax
    175a:	c7 40 34 20 03 00 00 	movl   $0x320,0x34(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    1761:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1764:	c7 40 38 26 02 00 00 	movl   $0x226,0x38(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    176b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176e:	8b 40 34             	mov    0x34(%eax),%eax
    1771:	89 c2                	mov    %eax,%edx
    1773:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1776:	8b 40 38             	mov    0x38(%eax),%eax
    1779:	0f af d0             	imul   %eax,%edx
    177c:	89 d0                	mov    %edx,%eax
    177e:	01 c0                	add    %eax,%eax
    1780:	01 d0                	add    %edx,%eax
    1782:	83 ec 0c             	sub    $0xc,%esp
    1785:	50                   	push   %eax
    1786:	e8 84 f2 ff ff       	call   a0f <malloc>
    178b:	83 c4 10             	add    $0x10,%esp
    178e:	89 c2                	mov    %eax,%edx
    1790:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1793:	89 50 4c             	mov    %edx,0x4c(%eax)
    if (r->Dc.content == 0)
    1796:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1799:	8b 40 4c             	mov    0x4c(%eax),%eax
    179c:	85 c0                	test   %eax,%eax
    179e:	75 15                	jne    17b5 <APCreateWindow+0xa7>
        printf(1,"$s window - Dc creation failed!\n",title);
    17a0:	83 ec 04             	sub    $0x4,%esp
    17a3:	ff 75 08             	pushl  0x8(%ebp)
    17a6:	68 38 22 00 00       	push   $0x2238
    17ab:	6a 01                	push   $0x1
    17ad:	e8 8a ef ff ff       	call   73c <printf>
    17b2:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    17b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17b8:	8b 40 34             	mov    0x34(%eax),%eax
    17bb:	89 c2                	mov    %eax,%edx
    17bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17c0:	8b 40 38             	mov    0x38(%eax),%eax
    17c3:	0f af d0             	imul   %eax,%edx
    17c6:	89 d0                	mov    %edx,%eax
    17c8:	01 c0                	add    %eax,%eax
    17ca:	01 c2                	add    %eax,%edx
    17cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17cf:	8b 40 4c             	mov    0x4c(%eax),%eax
    17d2:	83 ec 04             	sub    $0x4,%esp
    17d5:	52                   	push   %edx
    17d6:	68 ff ff ff 00       	push   $0xffffff
    17db:	50                   	push   %eax
    17dc:	e8 21 ec ff ff       	call   402 <memset>
    17e1:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    17e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17e7:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    r->pid = getpid();
    17ee:	e8 2a ee ff ff       	call   61d <getpid>
    17f3:	89 c2                	mov    %eax,%edx
    17f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17f8:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    17fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fe:	c7 40 50 20 03 00 00 	movl   $0x320,0x50(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    1805:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1808:	c7 40 54 32 00 00 00 	movl   $0x32,0x54(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    180f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1812:	8b 40 50             	mov    0x50(%eax),%eax
    1815:	89 c2                	mov    %eax,%edx
    1817:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181a:	8b 40 54             	mov    0x54(%eax),%eax
    181d:	0f af d0             	imul   %eax,%edx
    1820:	89 d0                	mov    %edx,%eax
    1822:	01 c0                	add    %eax,%eax
    1824:	01 d0                	add    %edx,%eax
    1826:	83 ec 0c             	sub    $0xc,%esp
    1829:	50                   	push   %eax
    182a:	e8 e0 f1 ff ff       	call   a0f <malloc>
    182f:	83 c4 10             	add    $0x10,%esp
    1832:	89 c2                	mov    %eax,%edx
    1834:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1837:	89 50 68             	mov    %edx,0x68(%eax)
    if (r->TitleDc.content == 0)
    183a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183d:	8b 40 68             	mov    0x68(%eax),%eax
    1840:	85 c0                	test   %eax,%eax
    1842:	75 15                	jne    1859 <APCreateWindow+0x14b>
        printf(1,"%s window - Title DC creation failed!\n",title);
    1844:	83 ec 04             	sub    $0x4,%esp
    1847:	ff 75 08             	pushl  0x8(%ebp)
    184a:	68 5c 22 00 00       	push   $0x225c
    184f:	6a 01                	push   $0x1
    1851:	e8 e6 ee ff ff       	call   73c <printf>
    1856:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    1859:	8b 45 f4             	mov    -0xc(%ebp),%eax
    185c:	8b 40 34             	mov    0x34(%eax),%eax
    185f:	89 c2                	mov    %eax,%edx
    1861:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1864:	8b 40 38             	mov    0x38(%eax),%eax
    1867:	0f af d0             	imul   %eax,%edx
    186a:	89 d0                	mov    %edx,%eax
    186c:	01 c0                	add    %eax,%eax
    186e:	01 c2                	add    %eax,%edx
    1870:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1873:	8b 40 4c             	mov    0x4c(%eax),%eax
    1876:	83 ec 04             	sub    $0x4,%esp
    1879:	52                   	push   %edx
    187a:	68 ff 00 00 00       	push   $0xff
    187f:	50                   	push   %eax
    1880:	e8 7d eb ff ff       	call   402 <memset>
    1885:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    1888:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188b:	8b 55 0c             	mov    0xc(%ebp),%edx
    188e:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    1891:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1895:	74 35                	je     18cc <APCreateWindow+0x1be>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    1897:	8b 45 10             	mov    0x10(%ebp),%eax
    189a:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    18a0:	83 ec 0c             	sub    $0xc,%esp
    18a3:	50                   	push   %eax
    18a4:	e8 66 f1 ff ff       	call   a0f <malloc>
    18a9:	83 c4 10             	add    $0x10,%esp
    18ac:	89 c2                	mov    %eax,%edx
    18ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b1:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    18b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b7:	8b 55 10             	mov    0x10(%ebp),%edx
    18ba:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    18bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c0:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    18c7:	e9 8d 00 00 00       	jmp    1959 <APCreateWindow+0x24b>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    18cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cf:	c7 40 18 20 03 00 00 	movl   $0x320,0x18(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    18d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d9:	c7 40 1c 40 06 00 00 	movl   $0x640,0x1c(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    18e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e3:	8b 40 18             	mov    0x18(%eax),%eax
    18e6:	89 c2                	mov    %eax,%edx
    18e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18eb:	8b 40 1c             	mov    0x1c(%eax),%eax
    18ee:	0f af d0             	imul   %eax,%edx
    18f1:	89 d0                	mov    %edx,%eax
    18f3:	01 c0                	add    %eax,%eax
    18f5:	01 d0                	add    %edx,%eax
    18f7:	83 ec 0c             	sub    $0xc,%esp
    18fa:	50                   	push   %eax
    18fb:	e8 0f f1 ff ff       	call   a0f <malloc>
    1900:	83 c4 10             	add    $0x10,%esp
    1903:	89 c2                	mov    %eax,%edx
    1905:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1908:	89 50 30             	mov    %edx,0x30(%eax)
        if (r->wholeDc.content == 0)
    190b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190e:	8b 40 30             	mov    0x30(%eax),%eax
    1911:	85 c0                	test   %eax,%eax
    1913:	75 15                	jne    192a <APCreateWindow+0x21c>
            printf(1,"%s window - whole DC creation failed!\n",title);
    1915:	83 ec 04             	sub    $0x4,%esp
    1918:	ff 75 08             	pushl  0x8(%ebp)
    191b:	68 84 22 00 00       	push   $0x2284
    1920:	6a 01                	push   $0x1
    1922:	e8 15 ee ff ff       	call   73c <printf>
    1927:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    192a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192d:	8b 40 18             	mov    0x18(%eax),%eax
    1930:	89 c2                	mov    %eax,%edx
    1932:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1935:	8b 40 1c             	mov    0x1c(%eax),%eax
    1938:	0f af d0             	imul   %eax,%edx
    193b:	89 d0                	mov    %edx,%eax
    193d:	01 c0                	add    %eax,%eax
    193f:	01 c2                	add    %eax,%edx
    1941:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1944:	8b 40 30             	mov    0x30(%eax),%eax
    1947:	83 ec 04             	sub    $0x4,%esp
    194a:	52                   	push   %edx
    194b:	68 ff ff ff 00       	push   $0xffffff
    1950:	50                   	push   %eax
    1951:	e8 ac ea ff ff       	call   402 <memset>
    1956:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    1959:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    195c:	c9                   	leave  
    195d:	c3                   	ret    

0000195e <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    195e:	55                   	push   %ebp
    195f:	89 e5                	mov    %esp,%ebp
    1961:	53                   	push   %ebx
    1962:	83 ec 04             	sub    $0x4,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    1965:	8b 45 0c             	mov    0xc(%ebp),%eax
    1968:	83 f8 03             	cmp    $0x3,%eax
    196b:	74 02                	je     196f <APWndProc+0x11>
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    196d:	eb 33                	jmp    19a2 <APWndProc+0x44>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid);
    196f:	8b 45 08             	mov    0x8(%ebp),%eax
    1972:	8b 48 08             	mov    0x8(%eax),%ecx
    1975:	8b 45 08             	mov    0x8(%ebp),%eax
    1978:	8b 50 38             	mov    0x38(%eax),%edx
    197b:	8b 45 08             	mov    0x8(%ebp),%eax
    197e:	8b 40 34             	mov    0x34(%eax),%eax
    1981:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1984:	83 c3 34             	add    $0x34,%ebx
    1987:	83 ec 0c             	sub    $0xc,%esp
    198a:	51                   	push   %ecx
    198b:	52                   	push   %edx
    198c:	50                   	push   %eax
    198d:	6a 00                	push   $0x0
    198f:	6a 00                	push   $0x0
    1991:	53                   	push   %ebx
    1992:	6a 32                	push   $0x32
    1994:	6a 00                	push   $0x0
    1996:	ff 75 08             	pushl  0x8(%ebp)
    1999:	e8 9f ec ff ff       	call   63d <paintWindow>
    199e:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    19a1:	90                   	nop
        default: break;
            
            
    }
    return False;
    19a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    19aa:	c9                   	leave  
    19ab:	c3                   	ret    

000019ac <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    19ac:	55                   	push   %ebp
    19ad:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    19af:	8b 45 0c             	mov    0xc(%ebp),%eax
    19b2:	8b 50 08             	mov    0x8(%eax),%edx
    19b5:	8b 45 08             	mov    0x8(%ebp),%eax
    19b8:	8b 00                	mov    (%eax),%eax
    19ba:	39 c2                	cmp    %eax,%edx
    19bc:	74 07                	je     19c5 <APPreJudge+0x19>
        return False;
    19be:	b8 00 00 00 00       	mov    $0x0,%eax
    19c3:	eb 05                	jmp    19ca <APPreJudge+0x1e>
    return True;
    19c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
    19ca:	5d                   	pop    %ebp
    19cb:	c3                   	ret    

000019cc <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    19cc:	55                   	push   %ebp
    19cd:	89 e5                	mov    %esp,%ebp
    19cf:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    19d2:	8b 45 08             	mov    0x8(%ebp),%eax
    19d5:	8b 55 0c             	mov    0xc(%ebp),%edx
    19d8:	89 50 78             	mov    %edx,0x78(%eax)
    //--------add window to list
    registWindow(hwnd);
    19db:	83 ec 0c             	sub    $0xc,%esp
    19de:	ff 75 08             	pushl  0x8(%ebp)
    19e1:	e8 77 ec ff ff       	call   65d <registWindow>
    19e6:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    19e9:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    19f0:	8b 45 08             	mov    0x8(%ebp),%eax
    19f3:	8b 00                	mov    (%eax),%eax
    19f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    19f8:	ff 75 f4             	pushl  -0xc(%ebp)
    19fb:	ff 75 f0             	pushl  -0x10(%ebp)
    19fe:	ff 75 ec             	pushl  -0x14(%ebp)
    1a01:	ff 75 08             	pushl  0x8(%ebp)
    1a04:	e8 e7 fc ff ff       	call   16f0 <APSendMessage>
    1a09:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    1a0c:	83 ec 0c             	sub    $0xc,%esp
    1a0f:	ff 75 08             	pushl  0x8(%ebp)
    1a12:	e8 3e ec ff ff       	call   655 <getMessage>
    1a17:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    1a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1d:	83 c0 6c             	add    $0x6c,%eax
    1a20:	83 ec 08             	sub    $0x8,%esp
    1a23:	50                   	push   %eax
    1a24:	ff 75 08             	pushl  0x8(%ebp)
    1a27:	e8 80 ff ff ff       	call   19ac <APPreJudge>
    1a2c:	83 c4 10             	add    $0x10,%esp
    1a2f:	84 c0                	test   %al,%al
    1a31:	74 1b                	je     1a4e <APWndExec+0x82>
            if (wndProc(hwnd, hwnd->msg))
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	ff 70 74             	pushl  0x74(%eax)
    1a39:	ff 70 70             	pushl  0x70(%eax)
    1a3c:	ff 70 6c             	pushl  0x6c(%eax)
    1a3f:	ff 75 08             	pushl  0x8(%ebp)
    1a42:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a45:	ff d0                	call   *%eax
    1a47:	83 c4 10             	add    $0x10,%esp
    1a4a:	84 c0                	test   %al,%al
    1a4c:	75 0c                	jne    1a5a <APWndExec+0x8e>
                break;
        hwnd->msg.type = MSG_NULL;
    1a4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a51:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)
    }
    1a58:	eb b2                	jmp    1a0c <APWndExec+0x40>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    1a5a:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    1a5b:	90                   	nop
    1a5c:	c9                   	leave  
    1a5d:	c3                   	ret    

00001a5e <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    1a5e:	55                   	push   %ebp
    1a5f:	89 e5                	mov    %esp,%ebp
    1a61:	57                   	push   %edi
    1a62:	56                   	push   %esi
    1a63:	53                   	push   %ebx
    1a64:	83 ec 4c             	sub    $0x4c,%esp
    if (!iconReady)
    1a67:	a1 d4 28 00 00       	mov    0x28d4,%eax
    1a6c:	85 c0                	test   %eax,%eax
    1a6e:	75 7c                	jne    1aec <APGridPaint+0x8e>
    {
        iconReady = 1;
    1a70:	c7 05 d4 28 00 00 01 	movl   $0x1,0x28d4
    1a77:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("Snake.bmp");
    1a7a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1a7d:	83 ec 08             	sub    $0x8,%esp
    1a80:	68 ab 22 00 00       	push   $0x22ab
    1a85:	50                   	push   %eax
    1a86:	e8 37 f1 ff ff       	call   bc2 <APLoadBitmap>
    1a8b:	83 c4 0c             	add    $0xc,%esp
    1a8e:	8b 45 b8             	mov    -0x48(%ebp),%eax
    1a91:	a3 d8 28 00 00       	mov    %eax,0x28d8
    1a96:	8b 45 bc             	mov    -0x44(%ebp),%eax
    1a99:	a3 dc 28 00 00       	mov    %eax,0x28dc
    1a9e:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1aa1:	a3 e0 28 00 00       	mov    %eax,0x28e0
        printf(1,"bitmap loaded!\n");
    1aa6:	83 ec 08             	sub    $0x8,%esp
    1aa9:	68 b5 22 00 00       	push   $0x22b5
    1aae:	6a 01                	push   $0x1
    1ab0:	e8 87 ec ff ff       	call   73c <printf>
    1ab5:	83 c4 10             	add    $0x10,%esp
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    1ab8:	83 ec 04             	sub    $0x4,%esp
    1abb:	ff 35 e0 28 00 00    	pushl  0x28e0
    1ac1:	ff 35 dc 28 00 00    	pushl  0x28dc
    1ac7:	ff 35 d8 28 00 00    	pushl  0x28d8
    1acd:	e8 7a f3 ff ff       	call   e4c <APCreateCompatibleDCFromBitmap>
    1ad2:	83 c4 10             	add    $0x10,%esp
    1ad5:	a3 e4 28 00 00       	mov    %eax,0x28e4
        printf(1,"bitmap DC created!\n");
    1ada:	83 ec 08             	sub    $0x8,%esp
    1add:	68 c5 22 00 00       	push   $0x22c5
    1ae2:	6a 01                	push   $0x1
    1ae4:	e8 53 ec ff ff       	call   73c <printf>
    1ae9:	83 c4 10             	add    $0x10,%esp
    }
    
    if (!wnd->is_grid)
    1aec:	8b 45 08             	mov    0x8(%ebp),%eax
    1aef:	8b 40 08             	mov    0x8(%eax),%eax
    1af2:	85 c0                	test   %eax,%eax
    1af4:	75 17                	jne    1b0d <APGridPaint+0xaf>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    1af6:	83 ec 08             	sub    $0x8,%esp
    1af9:	68 dc 22 00 00       	push   $0x22dc
    1afe:	6a 01                	push   $0x1
    1b00:	e8 37 ec ff ff       	call   73c <printf>
    1b05:	83 c4 10             	add    $0x10,%esp
        return;
    1b08:	e9 55 03 00 00       	jmp    1e62 <APGridPaint+0x404>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    1b0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b10:	8b 40 10             	mov    0x10(%eax),%eax
    1b13:	85 c0                	test   %eax,%eax
    1b15:	7e 10                	jle    1b27 <APGridPaint+0xc9>
    1b17:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1a:	8b 50 14             	mov    0x14(%eax),%edx
    1b1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b20:	8b 40 10             	mov    0x10(%eax),%eax
    1b23:	39 c2                	cmp    %eax,%edx
    1b25:	7c 17                	jl     1b3e <APGridPaint+0xe0>
    {
        printf(1,"Grid mode page error!");
    1b27:	83 ec 08             	sub    $0x8,%esp
    1b2a:	68 02 23 00 00       	push   $0x2302
    1b2f:	6a 01                	push   $0x1
    1b31:	e8 06 ec ff ff       	call   73c <printf>
    1b36:	83 c4 10             	add    $0x10,%esp
        return;
    1b39:	e9 24 03 00 00       	jmp    1e62 <APGridPaint+0x404>
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    1b3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b41:	8b 40 14             	mov    0x14(%eax),%eax
    1b44:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    1b4a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1b4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1b50:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1b53:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1b5a:	e9 f9 02 00 00       	jmp    1e58 <APGridPaint+0x3fa>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1b5f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    1b66:	e9 df 02 00 00       	jmp    1e4a <APGridPaint+0x3ec>
        {
            index = start + GRID_W_NUMBER * j + i;
    1b6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b6e:	c1 e0 04             	shl    $0x4,%eax
    1b71:	89 c2                	mov    %eax,%edx
    1b73:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b76:	01 c2                	add    %eax,%edx
    1b78:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1b7b:	01 d0                	add    %edx,%eax
    1b7d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1b80:	8b 45 08             	mov    0x8(%ebp),%eax
    1b83:	8b 40 0c             	mov    0xc(%eax),%eax
    1b86:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1b89:	c1 e2 02             	shl    $0x2,%edx
    1b8c:	01 d0                	add    %edx,%eax
    1b8e:	8b 00                	mov    (%eax),%eax
    1b90:	83 f8 01             	cmp    $0x1,%eax
    1b93:	0f 84 83 00 00 00    	je     1c1c <APGridPaint+0x1be>
    1b99:	83 f8 01             	cmp    $0x1,%eax
    1b9c:	7f 09                	jg     1ba7 <APGridPaint+0x149>
    1b9e:	85 c0                	test   %eax,%eax
    1ba0:	74 1c                	je     1bbe <APGridPaint+0x160>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1ba2:	e9 9f 02 00 00       	jmp    1e46 <APGridPaint+0x3e8>
        for (int i = 0; i < GRID_W_NUMBER;i++)
        {
            index = start + GRID_W_NUMBER * j + i;
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    1ba7:	83 f8 02             	cmp    $0x2,%eax
    1baa:	0f 84 20 01 00 00    	je     1cd0 <APGridPaint+0x272>
    1bb0:	83 f8 03             	cmp    $0x3,%eax
    1bb3:	0f 84 d1 01 00 00    	je     1d8a <APGridPaint+0x32c>
                    brush.color = RGB(0x00,0xbf,0xff);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
                    break;
                default: break;
    1bb9:	e9 88 02 00 00       	jmp    1e46 <APGridPaint+0x3e8>
                    pen.size = 1;
                    brush.color = RGB(0xd2,0x69,0x1e);
                    APSetPen(&wnd->Dc,pen);
                    APSetBrush(&wnd->Dc,brush);
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);*/
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    1bbe:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    1bc1:	6a 0c                	push   $0xc
    1bc3:	6a 0c                	push   $0xc
    1bc5:	6a 0c                	push   $0xc
    1bc7:	50                   	push   %eax
    1bc8:	e8 de fa ff ff       	call   16ab <RGB>
    1bcd:	83 c4 0c             	add    $0xc,%esp
    1bd0:	8b 1d e4 28 00 00    	mov    0x28e4,%ebx
    1bd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bd9:	6b c8 32             	imul   $0x32,%eax,%ecx
    1bdc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bdf:	6b c0 32             	imul   $0x32,%eax,%eax
    1be2:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    1be5:	8b 45 08             	mov    0x8(%ebp),%eax
    1be8:	8d 78 34             	lea    0x34(%eax),%edi
    1beb:	83 ec 0c             	sub    $0xc,%esp
    1bee:	83 ec 04             	sub    $0x4,%esp
    1bf1:	89 e0                	mov    %esp,%eax
    1bf3:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    1bf7:	66 89 30             	mov    %si,(%eax)
    1bfa:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    1bfe:	88 50 02             	mov    %dl,0x2(%eax)
    1c01:	6a 32                	push   $0x32
    1c03:	6a 32                	push   $0x32
    1c05:	6a 00                	push   $0x0
    1c07:	6a 00                	push   $0x0
    1c09:	53                   	push   %ebx
    1c0a:	51                   	push   %ecx
    1c0b:	ff 75 b4             	pushl  -0x4c(%ebp)
    1c0e:	57                   	push   %edi
    1c0f:	e8 f3 f8 ff ff       	call   1507 <APDcCopy>
    1c14:	83 c4 30             	add    $0x30,%esp
                    break;
    1c17:	e9 2a 02 00 00       	jmp    1e46 <APGridPaint+0x3e8>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    1c1c:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c1f:	6a 69                	push   $0x69
    1c21:	6a 69                	push   $0x69
    1c23:	6a 69                	push   $0x69
    1c25:	50                   	push   %eax
    1c26:	e8 80 fa ff ff       	call   16ab <RGB>
    1c2b:	83 c4 0c             	add    $0xc,%esp
    1c2e:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1c32:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1c36:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1c3a:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1c3d:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    1c44:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c47:	6a 69                	push   $0x69
    1c49:	6a 69                	push   $0x69
    1c4b:	6a 69                	push   $0x69
    1c4d:	50                   	push   %eax
    1c4e:	e8 58 fa ff ff       	call   16ab <RGB>
    1c53:	83 c4 0c             	add    $0xc,%esp
    1c56:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1c5a:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1c5e:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1c62:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1c65:	8b 45 08             	mov    0x8(%ebp),%eax
    1c68:	8d 50 34             	lea    0x34(%eax),%edx
    1c6b:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1c6e:	ff 75 d0             	pushl  -0x30(%ebp)
    1c71:	ff 75 cc             	pushl  -0x34(%ebp)
    1c74:	52                   	push   %edx
    1c75:	50                   	push   %eax
    1c76:	e8 66 f2 ff ff       	call   ee1 <APSetPen>
    1c7b:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1c7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c81:	8d 58 34             	lea    0x34(%eax),%ebx
    1c84:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1c87:	83 ec 04             	sub    $0x4,%esp
    1c8a:	83 ec 04             	sub    $0x4,%esp
    1c8d:	89 e0                	mov    %esp,%eax
    1c8f:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1c93:	66 89 08             	mov    %cx,(%eax)
    1c96:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1c9a:	88 48 02             	mov    %cl,0x2(%eax)
    1c9d:	53                   	push   %ebx
    1c9e:	52                   	push   %edx
    1c9f:	e8 76 f2 ff ff       	call   f1a <APSetBrush>
    1ca4:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1ca7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1caa:	6b d0 32             	imul   $0x32,%eax,%edx
    1cad:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1cb0:	6b c0 32             	imul   $0x32,%eax,%eax
    1cb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cb6:	83 c1 34             	add    $0x34,%ecx
    1cb9:	83 ec 0c             	sub    $0xc,%esp
    1cbc:	6a 32                	push   $0x32
    1cbe:	6a 32                	push   $0x32
    1cc0:	52                   	push   %edx
    1cc1:	50                   	push   %eax
    1cc2:	51                   	push   %ecx
    1cc3:	e8 3a f6 ff ff       	call   1302 <APDrawRect>
    1cc8:	83 c4 20             	add    $0x20,%esp
                    break;
    1ccb:	e9 76 01 00 00       	jmp    1e46 <APGridPaint+0x3e8>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    pen.color = RGB(0x00,0x80,0x00);
    1cd0:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1cd3:	6a 00                	push   $0x0
    1cd5:	68 80 00 00 00       	push   $0x80
    1cda:	6a 00                	push   $0x0
    1cdc:	50                   	push   %eax
    1cdd:	e8 c9 f9 ff ff       	call   16ab <RGB>
    1ce2:	83 c4 0c             	add    $0xc,%esp
    1ce5:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1ce9:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1ced:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1cf1:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1cf4:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0x80,0x00);
    1cfb:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1cfe:	6a 00                	push   $0x0
    1d00:	68 80 00 00 00       	push   $0x80
    1d05:	6a 00                	push   $0x0
    1d07:	50                   	push   %eax
    1d08:	e8 9e f9 ff ff       	call   16ab <RGB>
    1d0d:	83 c4 0c             	add    $0xc,%esp
    1d10:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1d14:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1d18:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1d1c:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1d1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d22:	8d 50 34             	lea    0x34(%eax),%edx
    1d25:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1d28:	ff 75 d0             	pushl  -0x30(%ebp)
    1d2b:	ff 75 cc             	pushl  -0x34(%ebp)
    1d2e:	52                   	push   %edx
    1d2f:	50                   	push   %eax
    1d30:	e8 ac f1 ff ff       	call   ee1 <APSetPen>
    1d35:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1d38:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3b:	8d 58 34             	lea    0x34(%eax),%ebx
    1d3e:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1d41:	83 ec 04             	sub    $0x4,%esp
    1d44:	83 ec 04             	sub    $0x4,%esp
    1d47:	89 e0                	mov    %esp,%eax
    1d49:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1d4d:	66 89 08             	mov    %cx,(%eax)
    1d50:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1d54:	88 48 02             	mov    %cl,0x2(%eax)
    1d57:	53                   	push   %ebx
    1d58:	52                   	push   %edx
    1d59:	e8 bc f1 ff ff       	call   f1a <APSetBrush>
    1d5e:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    1d61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d64:	6b d0 32             	imul   $0x32,%eax,%edx
    1d67:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d6a:	6b c0 32             	imul   $0x32,%eax,%eax
    1d6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d70:	83 c1 34             	add    $0x34,%ecx
    1d73:	83 ec 0c             	sub    $0xc,%esp
    1d76:	6a 32                	push   $0x32
    1d78:	6a 32                	push   $0x32
    1d7a:	52                   	push   %edx
    1d7b:	50                   	push   %eax
    1d7c:	51                   	push   %ecx
    1d7d:	e8 80 f5 ff ff       	call   1302 <APDrawRect>
    1d82:	83 c4 20             	add    $0x20,%esp
                    break;
    1d85:	e9 bc 00 00 00       	jmp    1e46 <APGridPaint+0x3e8>
                case GRID_RIVER:
                    //printf(1,"Grid_River");
                    pen.color = RGB(0x00,0xbf,0xff);
    1d8a:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1d8d:	68 ff 00 00 00       	push   $0xff
    1d92:	68 bf 00 00 00       	push   $0xbf
    1d97:	6a 00                	push   $0x0
    1d99:	50                   	push   %eax
    1d9a:	e8 0c f9 ff ff       	call   16ab <RGB>
    1d9f:	83 c4 0c             	add    $0xc,%esp
    1da2:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1da6:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
    1daa:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1dae:	88 45 ce             	mov    %al,-0x32(%ebp)
                    pen.size = 1;
    1db1:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
                    brush.color = RGB(0x00,0xbf,0xff);
    1db8:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1dbb:	68 ff 00 00 00       	push   $0xff
    1dc0:	68 bf 00 00 00       	push   $0xbf
    1dc5:	6a 00                	push   $0x0
    1dc7:	50                   	push   %eax
    1dc8:	e8 de f8 ff ff       	call   16ab <RGB>
    1dcd:	83 c4 0c             	add    $0xc,%esp
    1dd0:	0f b7 45 b8          	movzwl -0x48(%ebp),%eax
    1dd4:	66 89 45 c9          	mov    %ax,-0x37(%ebp)
    1dd8:	0f b6 45 ba          	movzbl -0x46(%ebp),%eax
    1ddc:	88 45 cb             	mov    %al,-0x35(%ebp)
                    APSetPen(&wnd->Dc,pen);
    1ddf:	8b 45 08             	mov    0x8(%ebp),%eax
    1de2:	8d 50 34             	lea    0x34(%eax),%edx
    1de5:	8d 45 b8             	lea    -0x48(%ebp),%eax
    1de8:	ff 75 d0             	pushl  -0x30(%ebp)
    1deb:	ff 75 cc             	pushl  -0x34(%ebp)
    1dee:	52                   	push   %edx
    1def:	50                   	push   %eax
    1df0:	e8 ec f0 ff ff       	call   ee1 <APSetPen>
    1df5:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    1df8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfb:	8d 58 34             	lea    0x34(%eax),%ebx
    1dfe:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1e01:	83 ec 04             	sub    $0x4,%esp
    1e04:	83 ec 04             	sub    $0x4,%esp
    1e07:	89 e0                	mov    %esp,%eax
    1e09:	0f b7 4d c9          	movzwl -0x37(%ebp),%ecx
    1e0d:	66 89 08             	mov    %cx,(%eax)
    1e10:	0f b6 4d cb          	movzbl -0x35(%ebp),%ecx
    1e14:	88 48 02             	mov    %cl,0x2(%eax)
    1e17:	53                   	push   %ebx
    1e18:	52                   	push   %edx
    1e19:	e8 fc f0 ff ff       	call   f1a <APSetBrush>
    1e1e:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH ,GRID_WIDTH,GRID_WIDTH);
    1e21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1e24:	6b d0 32             	imul   $0x32,%eax,%edx
    1e27:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1e2a:	6b c0 32             	imul   $0x32,%eax,%eax
    1e2d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e30:	83 c1 34             	add    $0x34,%ecx
    1e33:	83 ec 0c             	sub    $0xc,%esp
    1e36:	6a 32                	push   $0x32
    1e38:	6a 32                	push   $0x32
    1e3a:	52                   	push   %edx
    1e3b:	50                   	push   %eax
    1e3c:	51                   	push   %ecx
    1e3d:	e8 c0 f4 ff ff       	call   1302 <APDrawRect>
    1e42:	83 c4 20             	add    $0x20,%esp
                    break;
    1e45:	90                   	nop
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    1e46:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    1e4a:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    1e4e:	0f 8e 17 fd ff ff    	jle    1b6b <APGridPaint+0x10d>
        return;
    }
    
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    
    for (int j = 0; j < GRID_H_NUMBER; j++)
    1e54:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1e58:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    1e5c:	0f 8e fd fc ff ff    	jle    1b5f <APGridPaint+0x101>
                    break;
                default: break;
            }
        }
    }
}
    1e62:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e65:	5b                   	pop    %ebx
    1e66:	5e                   	pop    %esi
    1e67:	5f                   	pop    %edi
    1e68:	5d                   	pop    %ebp
    1e69:	c3                   	ret    

00001e6a <sprintint>:

#include "APLib.h"

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    1e6a:	55                   	push   %ebp
    1e6b:	89 e5                	mov    %esp,%ebp
    1e6d:	53                   	push   %ebx
    1e6e:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    1e71:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    1e78:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    1e7c:	74 17                	je     1e95 <sprintint+0x2b>
    1e7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1e82:	79 11                	jns    1e95 <sprintint+0x2b>
        neg = 1;
    1e84:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    1e8b:	8b 45 10             	mov    0x10(%ebp),%eax
    1e8e:	f7 d8                	neg    %eax
    1e90:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e93:	eb 06                	jmp    1e9b <sprintint+0x31>
    } else {
        x = xx;
    1e95:	8b 45 10             	mov    0x10(%ebp),%eax
    1e98:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    1e9b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    1ea2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    1ea5:	8d 41 01             	lea    0x1(%ecx),%eax
    1ea8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1eab:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1eae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1eb1:	ba 00 00 00 00       	mov    $0x0,%edx
    1eb6:	f7 f3                	div    %ebx
    1eb8:	89 d0                	mov    %edx,%eax
    1eba:	0f b6 80 a4 28 00 00 	movzbl 0x28a4(%eax),%eax
    1ec1:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    1ec5:	8b 5d 14             	mov    0x14(%ebp),%ebx
    1ec8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ecb:	ba 00 00 00 00       	mov    $0x0,%edx
    1ed0:	f7 f3                	div    %ebx
    1ed2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ed5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ed9:	75 c7                	jne    1ea2 <sprintint+0x38>
    if(neg)
    1edb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1edf:	74 0e                	je     1eef <sprintint+0x85>
        buf[i++] = '-';
    1ee1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ee4:	8d 50 01             	lea    0x1(%eax),%edx
    1ee7:	89 55 f8             	mov    %edx,-0x8(%ebp)
    1eea:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    1eef:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ef2:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    1ef5:	eb 1b                	jmp    1f12 <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    1ef7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1efa:	8b 00                	mov    (%eax),%eax
    1efc:	8d 48 01             	lea    0x1(%eax),%ecx
    1eff:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f02:	89 0a                	mov    %ecx,(%edx)
    1f04:	89 c2                	mov    %eax,%edx
    1f06:	8b 45 08             	mov    0x8(%ebp),%eax
    1f09:	01 d0                	add    %edx,%eax
    1f0b:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    1f0e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    1f12:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    1f16:	7f df                	jg     1ef7 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f18:	eb 21                	jmp    1f3b <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    1f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f1d:	8b 00                	mov    (%eax),%eax
    1f1f:	8d 48 01             	lea    0x1(%eax),%ecx
    1f22:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f25:	89 0a                	mov    %ecx,(%edx)
    1f27:	89 c2                	mov    %eax,%edx
    1f29:	8b 45 08             	mov    0x8(%ebp),%eax
    1f2c:	01 c2                	add    %eax,%edx
    1f2e:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    1f31:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1f34:	01 c8                	add    %ecx,%eax
    1f36:	0f b6 00             	movzbl (%eax),%eax
    1f39:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    1f3b:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    1f3f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    1f43:	79 d5                	jns    1f1a <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    1f45:	90                   	nop
    1f46:	83 c4 20             	add    $0x20,%esp
    1f49:	5b                   	pop    %ebx
    1f4a:	5d                   	pop    %ebp
    1f4b:	c3                   	ret    

00001f4c <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    1f4c:	55                   	push   %ebp
    1f4d:	89 e5                	mov    %esp,%ebp
    1f4f:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    1f52:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    1f59:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    1f60:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    1f67:	8d 45 0c             	lea    0xc(%ebp),%eax
    1f6a:	83 c0 04             	add    $0x4,%eax
    1f6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    1f70:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1f77:	e9 d9 01 00 00       	jmp    2155 <sprintf+0x209>
        c = fmt[i] & 0xff;
    1f7c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f82:	01 d0                	add    %edx,%eax
    1f84:	0f b6 00             	movzbl (%eax),%eax
    1f87:	0f be c0             	movsbl %al,%eax
    1f8a:	25 ff 00 00 00       	and    $0xff,%eax
    1f8f:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    1f92:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1f96:	75 2c                	jne    1fc4 <sprintf+0x78>
            if(c == '%'){
    1f98:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    1f9c:	75 0c                	jne    1faa <sprintf+0x5e>
                state = '%';
    1f9e:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    1fa5:	e9 a7 01 00 00       	jmp    2151 <sprintf+0x205>
            } else {
                dst[j++] = c;
    1faa:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1fad:	8d 50 01             	lea    0x1(%eax),%edx
    1fb0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    1fb3:	89 c2                	mov    %eax,%edx
    1fb5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb8:	01 d0                	add    %edx,%eax
    1fba:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1fbd:	88 10                	mov    %dl,(%eax)
    1fbf:	e9 8d 01 00 00       	jmp    2151 <sprintf+0x205>
            }
        } else if(state == '%'){
    1fc4:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1fc8:	0f 85 83 01 00 00    	jne    2151 <sprintf+0x205>
            if(c == 'd'){
    1fce:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    1fd2:	75 4c                	jne    2020 <sprintf+0xd4>
                buf[bi] = '\0';
    1fd4:	8d 55 ce             	lea    -0x32(%ebp),%edx
    1fd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fda:	01 d0                	add    %edx,%eax
    1fdc:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    1fdf:	83 ec 0c             	sub    $0xc,%esp
    1fe2:	8d 45 ce             	lea    -0x32(%ebp),%eax
    1fe5:	50                   	push   %eax
    1fe6:	e8 20 e5 ff ff       	call   50b <atoi>
    1feb:	83 c4 10             	add    $0x10,%esp
    1fee:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    1ff1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    1ff8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ffb:	8b 00                	mov    (%eax),%eax
    1ffd:	83 ec 08             	sub    $0x8,%esp
    2000:	ff 75 d8             	pushl  -0x28(%ebp)
    2003:	6a 01                	push   $0x1
    2005:	6a 0a                	push   $0xa
    2007:	50                   	push   %eax
    2008:	8d 45 c8             	lea    -0x38(%ebp),%eax
    200b:	50                   	push   %eax
    200c:	ff 75 08             	pushl  0x8(%ebp)
    200f:	e8 56 fe ff ff       	call   1e6a <sprintint>
    2014:	83 c4 20             	add    $0x20,%esp
                ap++;
    2017:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    201b:	e9 2a 01 00 00       	jmp    214a <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    2020:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    2024:	74 06                	je     202c <sprintf+0xe0>
    2026:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    202a:	75 4c                	jne    2078 <sprintf+0x12c>
                buf[bi] = '\0';
    202c:	8d 55 ce             	lea    -0x32(%ebp),%edx
    202f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2032:	01 d0                	add    %edx,%eax
    2034:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    2037:	83 ec 0c             	sub    $0xc,%esp
    203a:	8d 45 ce             	lea    -0x32(%ebp),%eax
    203d:	50                   	push   %eax
    203e:	e8 c8 e4 ff ff       	call   50b <atoi>
    2043:	83 c4 10             	add    $0x10,%esp
    2046:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    2049:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    2050:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2053:	8b 00                	mov    (%eax),%eax
    2055:	83 ec 08             	sub    $0x8,%esp
    2058:	ff 75 dc             	pushl  -0x24(%ebp)
    205b:	6a 00                	push   $0x0
    205d:	6a 10                	push   $0x10
    205f:	50                   	push   %eax
    2060:	8d 45 c8             	lea    -0x38(%ebp),%eax
    2063:	50                   	push   %eax
    2064:	ff 75 08             	pushl  0x8(%ebp)
    2067:	e8 fe fd ff ff       	call   1e6a <sprintint>
    206c:	83 c4 20             	add    $0x20,%esp
                ap++;
    206f:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    2073:	e9 d2 00 00 00       	jmp    214a <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    2078:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    207c:	75 46                	jne    20c4 <sprintf+0x178>
                s = (char*)*ap;
    207e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2081:	8b 00                	mov    (%eax),%eax
    2083:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    2086:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    208a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    208e:	75 25                	jne    20b5 <sprintf+0x169>
                    s = "(null)";
    2090:	c7 45 f4 18 23 00 00 	movl   $0x2318,-0xc(%ebp)
                while(*s != 0){
    2097:	eb 1c                	jmp    20b5 <sprintf+0x169>
                    dst[j++] = *s;
    2099:	8b 45 c8             	mov    -0x38(%ebp),%eax
    209c:	8d 50 01             	lea    0x1(%eax),%edx
    209f:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20a2:	89 c2                	mov    %eax,%edx
    20a4:	8b 45 08             	mov    0x8(%ebp),%eax
    20a7:	01 c2                	add    %eax,%edx
    20a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20ac:	0f b6 00             	movzbl (%eax),%eax
    20af:	88 02                	mov    %al,(%edx)
                    s++;
    20b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    20b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20b8:	0f b6 00             	movzbl (%eax),%eax
    20bb:	84 c0                	test   %al,%al
    20bd:	75 da                	jne    2099 <sprintf+0x14d>
    20bf:	e9 86 00 00 00       	jmp    214a <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    20c4:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    20c8:	75 1d                	jne    20e7 <sprintf+0x19b>
                dst[j++] = *ap;
    20ca:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20cd:	8d 50 01             	lea    0x1(%eax),%edx
    20d0:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20d3:	89 c2                	mov    %eax,%edx
    20d5:	8b 45 08             	mov    0x8(%ebp),%eax
    20d8:	01 c2                	add    %eax,%edx
    20da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20dd:	8b 00                	mov    (%eax),%eax
    20df:	88 02                	mov    %al,(%edx)
                ap++;
    20e1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    20e5:	eb 63                	jmp    214a <sprintf+0x1fe>
            } else if(c == '%'){
    20e7:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    20eb:	75 17                	jne    2104 <sprintf+0x1b8>
                dst[j++] = c;
    20ed:	8b 45 c8             	mov    -0x38(%ebp),%eax
    20f0:	8d 50 01             	lea    0x1(%eax),%edx
    20f3:	89 55 c8             	mov    %edx,-0x38(%ebp)
    20f6:	89 c2                	mov    %eax,%edx
    20f8:	8b 45 08             	mov    0x8(%ebp),%eax
    20fb:	01 d0                	add    %edx,%eax
    20fd:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2100:	88 10                	mov    %dl,(%eax)
    2102:	eb 46                	jmp    214a <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    2104:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    2108:	7e 18                	jle    2122 <sprintf+0x1d6>
    210a:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    210e:	7f 12                	jg     2122 <sprintf+0x1d6>
            {
                buf[bi++] = c;
    2110:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2113:	8d 50 01             	lea    0x1(%eax),%edx
    2116:	89 55 f0             	mov    %edx,-0x10(%ebp)
    2119:	8b 55 e0             	mov    -0x20(%ebp),%edx
    211c:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    2120:	eb 2f                	jmp    2151 <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    2122:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2125:	8d 50 01             	lea    0x1(%eax),%edx
    2128:	89 55 c8             	mov    %edx,-0x38(%ebp)
    212b:	89 c2                	mov    %eax,%edx
    212d:	8b 45 08             	mov    0x8(%ebp),%eax
    2130:	01 d0                	add    %edx,%eax
    2132:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    2135:	8b 45 c8             	mov    -0x38(%ebp),%eax
    2138:	8d 50 01             	lea    0x1(%eax),%edx
    213b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    213e:	89 c2                	mov    %eax,%edx
    2140:	8b 45 08             	mov    0x8(%ebp),%eax
    2143:	01 d0                	add    %edx,%eax
    2145:	8b 55 e0             	mov    -0x20(%ebp),%edx
    2148:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    214a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    2151:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2155:	8b 55 0c             	mov    0xc(%ebp),%edx
    2158:	8b 45 ec             	mov    -0x14(%ebp),%eax
    215b:	01 d0                	add    %edx,%eax
    215d:	0f b6 00             	movzbl (%eax),%eax
    2160:	84 c0                	test   %al,%al
    2162:	0f 85 14 fe ff ff    	jne    1f7c <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    2168:	8b 45 c8             	mov    -0x38(%ebp),%eax
    216b:	8d 50 01             	lea    0x1(%eax),%edx
    216e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    2171:	89 c2                	mov    %eax,%edx
    2173:	8b 45 08             	mov    0x8(%ebp),%eax
    2176:	01 d0                	add    %edx,%eax
    2178:	c6 00 00             	movb   $0x0,(%eax)
}
    217b:	90                   	nop
    217c:	c9                   	leave  
    217d:	c3                   	ret    
