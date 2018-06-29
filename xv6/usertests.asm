
_usertests：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
       6:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 f2 5d 00 00       	push   $0x5df2
      13:	50                   	push   %eax
      14:	e8 a9 3d 00 00       	call   3dc2 <printf>
      19:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
      1c:	83 ec 08             	sub    $0x8,%esp
      1f:	6a 00                	push   $0x0
      21:	68 dc 5d 00 00       	push   $0x5ddc
      26:	e8 18 3c 00 00       	call   3c43 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
      31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      35:	79 1b                	jns    52 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
      37:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
      3c:	83 ec 08             	sub    $0x8,%esp
      3f:	68 fd 5d 00 00       	push   $0x5dfd
      44:	50                   	push   %eax
      45:	e8 78 3d 00 00       	call   3dc2 <printf>
      4a:	83 c4 10             	add    $0x10,%esp
    exit();
      4d:	e8 b1 3b 00 00       	call   3c03 <exit>
  }
  close(fd);
      52:	83 ec 0c             	sub    $0xc,%esp
      55:	ff 75 f4             	pushl  -0xc(%ebp)
      58:	e8 ce 3b 00 00       	call   3c2b <close>
      5d:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
      60:	83 ec 08             	sub    $0x8,%esp
      63:	6a 00                	push   $0x0
      65:	68 10 5e 00 00       	push   $0x5e10
      6a:	e8 d4 3b 00 00       	call   3c43 <open>
      6f:	83 c4 10             	add    $0x10,%esp
      72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
      75:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      79:	78 1b                	js     96 <opentest+0x96>
    printf(stdout, "open doesnotexist succeeded!\n");
      7b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
      80:	83 ec 08             	sub    $0x8,%esp
      83:	68 1d 5e 00 00       	push   $0x5e1d
      88:	50                   	push   %eax
      89:	e8 34 3d 00 00       	call   3dc2 <printf>
      8e:	83 c4 10             	add    $0x10,%esp
    exit();
      91:	e8 6d 3b 00 00       	call   3c03 <exit>
  }
  printf(stdout, "open test ok\n");
      96:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
      9b:	83 ec 08             	sub    $0x8,%esp
      9e:	68 3b 5e 00 00       	push   $0x5e3b
      a3:	50                   	push   %eax
      a4:	e8 19 3d 00 00       	call   3dc2 <printf>
      a9:	83 c4 10             	add    $0x10,%esp
}
      ac:	90                   	nop
      ad:	c9                   	leave  
      ae:	c3                   	ret    

000000af <writetest>:

void
writetest(void)
{
      af:	55                   	push   %ebp
      b0:	89 e5                	mov    %esp,%ebp
      b2:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      b5:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
      ba:	83 ec 08             	sub    $0x8,%esp
      bd:	68 49 5e 00 00       	push   $0x5e49
      c2:	50                   	push   %eax
      c3:	e8 fa 3c 00 00       	call   3dc2 <printf>
      c8:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
      cb:	83 ec 08             	sub    $0x8,%esp
      ce:	68 02 02 00 00       	push   $0x202
      d3:	68 5a 5e 00 00       	push   $0x5e5a
      d8:	e8 66 3b 00 00       	call   3c43 <open>
      dd:	83 c4 10             	add    $0x10,%esp
      e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
      e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      e7:	78 22                	js     10b <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
      e9:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
      ee:	83 ec 08             	sub    $0x8,%esp
      f1:	68 60 5e 00 00       	push   $0x5e60
      f6:	50                   	push   %eax
      f7:	e8 c6 3c 00 00       	call   3dc2 <printf>
      fc:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
      ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     106:	e9 8f 00 00 00       	jmp    19a <writetest+0xeb>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     10b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     110:	83 ec 08             	sub    $0x8,%esp
     113:	68 7b 5e 00 00       	push   $0x5e7b
     118:	50                   	push   %eax
     119:	e8 a4 3c 00 00       	call   3dc2 <printf>
     11e:	83 c4 10             	add    $0x10,%esp
    exit();
     121:	e8 dd 3a 00 00       	call   3c03 <exit>
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     126:	83 ec 04             	sub    $0x4,%esp
     129:	6a 0a                	push   $0xa
     12b:	68 97 5e 00 00       	push   $0x5e97
     130:	ff 75 f0             	pushl  -0x10(%ebp)
     133:	e8 eb 3a 00 00       	call   3c23 <write>
     138:	83 c4 10             	add    $0x10,%esp
     13b:	83 f8 0a             	cmp    $0xa,%eax
     13e:	74 1e                	je     15e <writetest+0xaf>
      printf(stdout, "error: write aa %d new file failed\n", i);
     140:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     145:	83 ec 04             	sub    $0x4,%esp
     148:	ff 75 f4             	pushl  -0xc(%ebp)
     14b:	68 a4 5e 00 00       	push   $0x5ea4
     150:	50                   	push   %eax
     151:	e8 6c 3c 00 00       	call   3dc2 <printf>
     156:	83 c4 10             	add    $0x10,%esp
      exit();
     159:	e8 a5 3a 00 00       	call   3c03 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     15e:	83 ec 04             	sub    $0x4,%esp
     161:	6a 0a                	push   $0xa
     163:	68 c8 5e 00 00       	push   $0x5ec8
     168:	ff 75 f0             	pushl  -0x10(%ebp)
     16b:	e8 b3 3a 00 00       	call   3c23 <write>
     170:	83 c4 10             	add    $0x10,%esp
     173:	83 f8 0a             	cmp    $0xa,%eax
     176:	74 1e                	je     196 <writetest+0xe7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     178:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     17d:	83 ec 04             	sub    $0x4,%esp
     180:	ff 75 f4             	pushl  -0xc(%ebp)
     183:	68 d4 5e 00 00       	push   $0x5ed4
     188:	50                   	push   %eax
     189:	e8 34 3c 00 00       	call   3dc2 <printf>
     18e:	83 c4 10             	add    $0x10,%esp
      exit();
     191:	e8 6d 3a 00 00       	call   3c03 <exit>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     196:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     19a:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     19e:	7e 86                	jle    126 <writetest+0x77>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     1a0:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 f8 5e 00 00       	push   $0x5ef8
     1ad:	50                   	push   %eax
     1ae:	e8 0f 3c 00 00       	call   3dc2 <printf>
     1b3:	83 c4 10             	add    $0x10,%esp
  close(fd);
     1b6:	83 ec 0c             	sub    $0xc,%esp
     1b9:	ff 75 f0             	pushl  -0x10(%ebp)
     1bc:	e8 6a 3a 00 00       	call   3c2b <close>
     1c1:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     1c4:	83 ec 08             	sub    $0x8,%esp
     1c7:	6a 00                	push   $0x0
     1c9:	68 5a 5e 00 00       	push   $0x5e5a
     1ce:	e8 70 3a 00 00       	call   3c43 <open>
     1d3:	83 c4 10             	add    $0x10,%esp
     1d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     1d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1dd:	78 3c                	js     21b <writetest+0x16c>
    printf(stdout, "open small succeeded ok\n");
     1df:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     1e4:	83 ec 08             	sub    $0x8,%esp
     1e7:	68 03 5f 00 00       	push   $0x5f03
     1ec:	50                   	push   %eax
     1ed:	e8 d0 3b 00 00       	call   3dc2 <printf>
     1f2:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     1f5:	83 ec 04             	sub    $0x4,%esp
     1f8:	68 d0 07 00 00       	push   $0x7d0
     1fd:	68 20 e4 00 00       	push   $0xe420
     202:	ff 75 f0             	pushl  -0x10(%ebp)
     205:	e8 11 3a 00 00       	call   3c1b <read>
     20a:	83 c4 10             	add    $0x10,%esp
     20d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     210:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     217:	75 57                	jne    270 <writetest+0x1c1>
     219:	eb 1b                	jmp    236 <writetest+0x187>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     21b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     220:	83 ec 08             	sub    $0x8,%esp
     223:	68 1c 5f 00 00       	push   $0x5f1c
     228:	50                   	push   %eax
     229:	e8 94 3b 00 00       	call   3dc2 <printf>
     22e:	83 c4 10             	add    $0x10,%esp
    exit();
     231:	e8 cd 39 00 00       	call   3c03 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
     236:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     23b:	83 ec 08             	sub    $0x8,%esp
     23e:	68 37 5f 00 00       	push   $0x5f37
     243:	50                   	push   %eax
     244:	e8 79 3b 00 00       	call   3dc2 <printf>
     249:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     24c:	83 ec 0c             	sub    $0xc,%esp
     24f:	ff 75 f0             	pushl  -0x10(%ebp)
     252:	e8 d4 39 00 00       	call   3c2b <close>
     257:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     25a:	83 ec 0c             	sub    $0xc,%esp
     25d:	68 5a 5e 00 00       	push   $0x5e5a
     262:	e8 ec 39 00 00       	call   3c53 <unlink>
     267:	83 c4 10             	add    $0x10,%esp
     26a:	85 c0                	test   %eax,%eax
     26c:	79 38                	jns    2a6 <writetest+0x1f7>
     26e:	eb 1b                	jmp    28b <writetest+0x1dc>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     270:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     275:	83 ec 08             	sub    $0x8,%esp
     278:	68 4a 5f 00 00       	push   $0x5f4a
     27d:	50                   	push   %eax
     27e:	e8 3f 3b 00 00       	call   3dc2 <printf>
     283:	83 c4 10             	add    $0x10,%esp
    exit();
     286:	e8 78 39 00 00       	call   3c03 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     28b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     290:	83 ec 08             	sub    $0x8,%esp
     293:	68 57 5f 00 00       	push   $0x5f57
     298:	50                   	push   %eax
     299:	e8 24 3b 00 00       	call   3dc2 <printf>
     29e:	83 c4 10             	add    $0x10,%esp
    exit();
     2a1:	e8 5d 39 00 00       	call   3c03 <exit>
  }
  printf(stdout, "small file test ok\n");
     2a6:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     2ab:	83 ec 08             	sub    $0x8,%esp
     2ae:	68 6c 5f 00 00       	push   $0x5f6c
     2b3:	50                   	push   %eax
     2b4:	e8 09 3b 00 00       	call   3dc2 <printf>
     2b9:	83 c4 10             	add    $0x10,%esp
}
     2bc:	90                   	nop
     2bd:	c9                   	leave  
     2be:	c3                   	ret    

000002bf <writetest1>:

void
writetest1(void)
{
     2bf:	55                   	push   %ebp
     2c0:	89 e5                	mov    %esp,%ebp
     2c2:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2c5:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     2ca:	83 ec 08             	sub    $0x8,%esp
     2cd:	68 80 5f 00 00       	push   $0x5f80
     2d2:	50                   	push   %eax
     2d3:	e8 ea 3a 00 00       	call   3dc2 <printf>
     2d8:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     2db:	83 ec 08             	sub    $0x8,%esp
     2de:	68 02 02 00 00       	push   $0x202
     2e3:	68 90 5f 00 00       	push   $0x5f90
     2e8:	e8 56 39 00 00       	call   3c43 <open>
     2ed:	83 c4 10             	add    $0x10,%esp
     2f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     2f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2f7:	79 1b                	jns    314 <writetest1+0x55>
    printf(stdout, "error: creat big failed!\n");
     2f9:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     2fe:	83 ec 08             	sub    $0x8,%esp
     301:	68 94 5f 00 00       	push   $0x5f94
     306:	50                   	push   %eax
     307:	e8 b6 3a 00 00       	call   3dc2 <printf>
     30c:	83 c4 10             	add    $0x10,%esp
    exit();
     30f:	e8 ef 38 00 00       	call   3c03 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     314:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     31b:	eb 4b                	jmp    368 <writetest1+0xa9>
    ((int*)buf)[0] = i;
     31d:	ba 20 e4 00 00       	mov    $0xe420,%edx
     322:	8b 45 f4             	mov    -0xc(%ebp),%eax
     325:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     327:	83 ec 04             	sub    $0x4,%esp
     32a:	68 00 02 00 00       	push   $0x200
     32f:	68 20 e4 00 00       	push   $0xe420
     334:	ff 75 ec             	pushl  -0x14(%ebp)
     337:	e8 e7 38 00 00       	call   3c23 <write>
     33c:	83 c4 10             	add    $0x10,%esp
     33f:	3d 00 02 00 00       	cmp    $0x200,%eax
     344:	74 1e                	je     364 <writetest1+0xa5>
      printf(stdout, "error: write big file failed\n", i);
     346:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     34b:	83 ec 04             	sub    $0x4,%esp
     34e:	ff 75 f4             	pushl  -0xc(%ebp)
     351:	68 ae 5f 00 00       	push   $0x5fae
     356:	50                   	push   %eax
     357:	e8 66 3a 00 00       	call   3dc2 <printf>
     35c:	83 c4 10             	add    $0x10,%esp
      exit();
     35f:	e8 9f 38 00 00       	call   3c03 <exit>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     364:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     368:	8b 45 f4             	mov    -0xc(%ebp),%eax
     36b:	3d 8a 40 00 00       	cmp    $0x408a,%eax
     370:	76 ab                	jbe    31d <writetest1+0x5e>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     372:	83 ec 0c             	sub    $0xc,%esp
     375:	ff 75 ec             	pushl  -0x14(%ebp)
     378:	e8 ae 38 00 00       	call   3c2b <close>
     37d:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     380:	83 ec 08             	sub    $0x8,%esp
     383:	6a 00                	push   $0x0
     385:	68 90 5f 00 00       	push   $0x5f90
     38a:	e8 b4 38 00 00       	call   3c43 <open>
     38f:	83 c4 10             	add    $0x10,%esp
     392:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     395:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     399:	79 1b                	jns    3b6 <writetest1+0xf7>
    printf(stdout, "error: open big failed!\n");
     39b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     3a0:	83 ec 08             	sub    $0x8,%esp
     3a3:	68 cc 5f 00 00       	push   $0x5fcc
     3a8:	50                   	push   %eax
     3a9:	e8 14 3a 00 00       	call   3dc2 <printf>
     3ae:	83 c4 10             	add    $0x10,%esp
    exit();
     3b1:	e8 4d 38 00 00       	call   3c03 <exit>
  }

  n = 0;
     3b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     3bd:	83 ec 04             	sub    $0x4,%esp
     3c0:	68 00 02 00 00       	push   $0x200
     3c5:	68 20 e4 00 00       	push   $0xe420
     3ca:	ff 75 ec             	pushl  -0x14(%ebp)
     3cd:	e8 49 38 00 00       	call   3c1b <read>
     3d2:	83 c4 10             	add    $0x10,%esp
     3d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     3d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3dc:	75 27                	jne    405 <writetest1+0x146>
      if(n == MAXFILE - 1){
     3de:	81 7d f0 8a 40 00 00 	cmpl   $0x408a,-0x10(%ebp)
     3e5:	75 7d                	jne    464 <writetest1+0x1a5>
        printf(stdout, "read only %d blocks from big", n);
     3e7:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     3ec:	83 ec 04             	sub    $0x4,%esp
     3ef:	ff 75 f0             	pushl  -0x10(%ebp)
     3f2:	68 e5 5f 00 00       	push   $0x5fe5
     3f7:	50                   	push   %eax
     3f8:	e8 c5 39 00 00       	call   3dc2 <printf>
     3fd:	83 c4 10             	add    $0x10,%esp
        exit();
     400:	e8 fe 37 00 00       	call   3c03 <exit>
      }
      break;
    } else if(i != 512){
     405:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     40c:	74 1e                	je     42c <writetest1+0x16d>
      printf(stdout, "read failed %d\n", i);
     40e:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     413:	83 ec 04             	sub    $0x4,%esp
     416:	ff 75 f4             	pushl  -0xc(%ebp)
     419:	68 02 60 00 00       	push   $0x6002
     41e:	50                   	push   %eax
     41f:	e8 9e 39 00 00       	call   3dc2 <printf>
     424:	83 c4 10             	add    $0x10,%esp
      exit();
     427:	e8 d7 37 00 00       	call   3c03 <exit>
    }
    if(((int*)buf)[0] != n){
     42c:	b8 20 e4 00 00       	mov    $0xe420,%eax
     431:	8b 00                	mov    (%eax),%eax
     433:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     436:	74 23                	je     45b <writetest1+0x19c>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     438:	b8 20 e4 00 00       	mov    $0xe420,%eax
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     43d:	8b 10                	mov    (%eax),%edx
     43f:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     444:	52                   	push   %edx
     445:	ff 75 f0             	pushl  -0x10(%ebp)
     448:	68 14 60 00 00       	push   $0x6014
     44d:	50                   	push   %eax
     44e:	e8 6f 39 00 00       	call   3dc2 <printf>
     453:	83 c4 10             	add    $0x10,%esp
             n, ((int*)buf)[0]);
      exit();
     456:	e8 a8 37 00 00       	call   3c03 <exit>
    }
    n++;
     45b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }
     45f:	e9 59 ff ff ff       	jmp    3bd <writetest1+0xfe>
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
     464:	90                   	nop
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     465:	83 ec 0c             	sub    $0xc,%esp
     468:	ff 75 ec             	pushl  -0x14(%ebp)
     46b:	e8 bb 37 00 00       	call   3c2b <close>
     470:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     473:	83 ec 0c             	sub    $0xc,%esp
     476:	68 90 5f 00 00       	push   $0x5f90
     47b:	e8 d3 37 00 00       	call   3c53 <unlink>
     480:	83 c4 10             	add    $0x10,%esp
     483:	85 c0                	test   %eax,%eax
     485:	79 1b                	jns    4a2 <writetest1+0x1e3>
    printf(stdout, "unlink big failed\n");
     487:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     48c:	83 ec 08             	sub    $0x8,%esp
     48f:	68 34 60 00 00       	push   $0x6034
     494:	50                   	push   %eax
     495:	e8 28 39 00 00       	call   3dc2 <printf>
     49a:	83 c4 10             	add    $0x10,%esp
    exit();
     49d:	e8 61 37 00 00       	call   3c03 <exit>
  }
  printf(stdout, "big files ok\n");
     4a2:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     4a7:	83 ec 08             	sub    $0x8,%esp
     4aa:	68 47 60 00 00       	push   $0x6047
     4af:	50                   	push   %eax
     4b0:	e8 0d 39 00 00       	call   3dc2 <printf>
     4b5:	83 c4 10             	add    $0x10,%esp
}
     4b8:	90                   	nop
     4b9:	c9                   	leave  
     4ba:	c3                   	ret    

000004bb <createtest>:

void
createtest(void)
{
     4bb:	55                   	push   %ebp
     4bc:	89 e5                	mov    %esp,%ebp
     4be:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     4c1:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     4c6:	83 ec 08             	sub    $0x8,%esp
     4c9:	68 58 60 00 00       	push   $0x6058
     4ce:	50                   	push   %eax
     4cf:	e8 ee 38 00 00       	call   3dc2 <printf>
     4d4:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     4d7:	c6 05 20 04 01 00 61 	movb   $0x61,0x10420
  name[2] = '\0';
     4de:	c6 05 22 04 01 00 00 	movb   $0x0,0x10422
  for(i = 0; i < 52; i++){
     4e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4ec:	eb 35                	jmp    523 <createtest+0x68>
    name[1] = '0' + i;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	83 c0 30             	add    $0x30,%eax
     4f4:	a2 21 04 01 00       	mov    %al,0x10421
    fd = open(name, O_CREATE|O_RDWR);
     4f9:	83 ec 08             	sub    $0x8,%esp
     4fc:	68 02 02 00 00       	push   $0x202
     501:	68 20 04 01 00       	push   $0x10420
     506:	e8 38 37 00 00       	call   3c43 <open>
     50b:	83 c4 10             	add    $0x10,%esp
     50e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     511:	83 ec 0c             	sub    $0xc,%esp
     514:	ff 75 f0             	pushl  -0x10(%ebp)
     517:	e8 0f 37 00 00       	call   3c2b <close>
     51c:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     51f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     523:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     527:	7e c5                	jle    4ee <createtest+0x33>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     529:	c6 05 20 04 01 00 61 	movb   $0x61,0x10420
  name[2] = '\0';
     530:	c6 05 22 04 01 00 00 	movb   $0x0,0x10422
  for(i = 0; i < 52; i++){
     537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     53e:	eb 1f                	jmp    55f <createtest+0xa4>
    name[1] = '0' + i;
     540:	8b 45 f4             	mov    -0xc(%ebp),%eax
     543:	83 c0 30             	add    $0x30,%eax
     546:	a2 21 04 01 00       	mov    %al,0x10421
    unlink(name);
     54b:	83 ec 0c             	sub    $0xc,%esp
     54e:	68 20 04 01 00       	push   $0x10420
     553:	e8 fb 36 00 00       	call   3c53 <unlink>
     558:	83 c4 10             	add    $0x10,%esp
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     55b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     55f:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     563:	7e db                	jle    540 <createtest+0x85>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     565:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     56a:	83 ec 08             	sub    $0x8,%esp
     56d:	68 80 60 00 00       	push   $0x6080
     572:	50                   	push   %eax
     573:	e8 4a 38 00 00       	call   3dc2 <printf>
     578:	83 c4 10             	add    $0x10,%esp
}
     57b:	90                   	nop
     57c:	c9                   	leave  
     57d:	c3                   	ret    

0000057e <dirtest>:

void dirtest(void)
{
     57e:	55                   	push   %ebp
     57f:	89 e5                	mov    %esp,%ebp
     581:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     584:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     589:	83 ec 08             	sub    $0x8,%esp
     58c:	68 a6 60 00 00       	push   $0x60a6
     591:	50                   	push   %eax
     592:	e8 2b 38 00 00       	call   3dc2 <printf>
     597:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     59a:	83 ec 0c             	sub    $0xc,%esp
     59d:	68 b2 60 00 00       	push   $0x60b2
     5a2:	e8 c4 36 00 00       	call   3c6b <mkdir>
     5a7:	83 c4 10             	add    $0x10,%esp
     5aa:	85 c0                	test   %eax,%eax
     5ac:	79 1b                	jns    5c9 <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     5ae:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     5b3:	83 ec 08             	sub    $0x8,%esp
     5b6:	68 b7 60 00 00       	push   $0x60b7
     5bb:	50                   	push   %eax
     5bc:	e8 01 38 00 00       	call   3dc2 <printf>
     5c1:	83 c4 10             	add    $0x10,%esp
    exit();
     5c4:	e8 3a 36 00 00       	call   3c03 <exit>
  }

  if(chdir("dir0") < 0){
     5c9:	83 ec 0c             	sub    $0xc,%esp
     5cc:	68 b2 60 00 00       	push   $0x60b2
     5d1:	e8 9d 36 00 00       	call   3c73 <chdir>
     5d6:	83 c4 10             	add    $0x10,%esp
     5d9:	85 c0                	test   %eax,%eax
     5db:	79 1b                	jns    5f8 <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
     5dd:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     5e2:	83 ec 08             	sub    $0x8,%esp
     5e5:	68 c5 60 00 00       	push   $0x60c5
     5ea:	50                   	push   %eax
     5eb:	e8 d2 37 00 00       	call   3dc2 <printf>
     5f0:	83 c4 10             	add    $0x10,%esp
    exit();
     5f3:	e8 0b 36 00 00       	call   3c03 <exit>
  }

  if(chdir("..") < 0){
     5f8:	83 ec 0c             	sub    $0xc,%esp
     5fb:	68 d8 60 00 00       	push   $0x60d8
     600:	e8 6e 36 00 00       	call   3c73 <chdir>
     605:	83 c4 10             	add    $0x10,%esp
     608:	85 c0                	test   %eax,%eax
     60a:	79 1b                	jns    627 <dirtest+0xa9>
    printf(stdout, "chdir .. failed\n");
     60c:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     611:	83 ec 08             	sub    $0x8,%esp
     614:	68 db 60 00 00       	push   $0x60db
     619:	50                   	push   %eax
     61a:	e8 a3 37 00 00       	call   3dc2 <printf>
     61f:	83 c4 10             	add    $0x10,%esp
    exit();
     622:	e8 dc 35 00 00       	call   3c03 <exit>
  }

  if(unlink("dir0") < 0){
     627:	83 ec 0c             	sub    $0xc,%esp
     62a:	68 b2 60 00 00       	push   $0x60b2
     62f:	e8 1f 36 00 00       	call   3c53 <unlink>
     634:	83 c4 10             	add    $0x10,%esp
     637:	85 c0                	test   %eax,%eax
     639:	79 1b                	jns    656 <dirtest+0xd8>
    printf(stdout, "unlink dir0 failed\n");
     63b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     640:	83 ec 08             	sub    $0x8,%esp
     643:	68 ec 60 00 00       	push   $0x60ec
     648:	50                   	push   %eax
     649:	e8 74 37 00 00       	call   3dc2 <printf>
     64e:	83 c4 10             	add    $0x10,%esp
    exit();
     651:	e8 ad 35 00 00       	call   3c03 <exit>
  }
  printf(stdout, "mkdir test\n");
     656:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     65b:	83 ec 08             	sub    $0x8,%esp
     65e:	68 a6 60 00 00       	push   $0x60a6
     663:	50                   	push   %eax
     664:	e8 59 37 00 00       	call   3dc2 <printf>
     669:	83 c4 10             	add    $0x10,%esp
}
     66c:	90                   	nop
     66d:	c9                   	leave  
     66e:	c3                   	ret    

0000066f <exectest>:

void
exectest(void)
{
     66f:	55                   	push   %ebp
     670:	89 e5                	mov    %esp,%ebp
     672:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     675:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     67a:	83 ec 08             	sub    $0x8,%esp
     67d:	68 00 61 00 00       	push   $0x6100
     682:	50                   	push   %eax
     683:	e8 3a 37 00 00       	call   3dc2 <printf>
     688:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     68b:	83 ec 08             	sub    $0x8,%esp
     68e:	68 e0 7f 00 00       	push   $0x7fe0
     693:	68 dc 5d 00 00       	push   $0x5ddc
     698:	e8 9e 35 00 00       	call   3c3b <exec>
     69d:	83 c4 10             	add    $0x10,%esp
     6a0:	85 c0                	test   %eax,%eax
     6a2:	79 1b                	jns    6bf <exectest+0x50>
    printf(stdout, "exec echo failed\n");
     6a4:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
     6a9:	83 ec 08             	sub    $0x8,%esp
     6ac:	68 0b 61 00 00       	push   $0x610b
     6b1:	50                   	push   %eax
     6b2:	e8 0b 37 00 00       	call   3dc2 <printf>
     6b7:	83 c4 10             	add    $0x10,%esp
    exit();
     6ba:	e8 44 35 00 00       	call   3c03 <exit>
  }
}
     6bf:	90                   	nop
     6c0:	c9                   	leave  
     6c1:	c3                   	ret    

000006c2 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     6c2:	55                   	push   %ebp
     6c3:	89 e5                	mov    %esp,%ebp
     6c5:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     6c8:	83 ec 0c             	sub    $0xc,%esp
     6cb:	8d 45 d8             	lea    -0x28(%ebp),%eax
     6ce:	50                   	push   %eax
     6cf:	e8 3f 35 00 00       	call   3c13 <pipe>
     6d4:	83 c4 10             	add    $0x10,%esp
     6d7:	85 c0                	test   %eax,%eax
     6d9:	74 17                	je     6f2 <pipe1+0x30>
    printf(1, "pipe() failed\n");
     6db:	83 ec 08             	sub    $0x8,%esp
     6de:	68 1d 61 00 00       	push   $0x611d
     6e3:	6a 01                	push   $0x1
     6e5:	e8 d8 36 00 00       	call   3dc2 <printf>
     6ea:	83 c4 10             	add    $0x10,%esp
    exit();
     6ed:	e8 11 35 00 00       	call   3c03 <exit>
  }
  pid = fork();
     6f2:	e8 04 35 00 00       	call   3bfb <fork>
     6f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     6fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     701:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     705:	0f 85 89 00 00 00    	jne    794 <pipe1+0xd2>
    close(fds[0]);
     70b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     70e:	83 ec 0c             	sub    $0xc,%esp
     711:	50                   	push   %eax
     712:	e8 14 35 00 00       	call   3c2b <close>
     717:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     71a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     721:	eb 66                	jmp    789 <pipe1+0xc7>
      for(i = 0; i < 1033; i++)
     723:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     72a:	eb 19                	jmp    745 <pipe1+0x83>
        buf[i] = seq++;
     72c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72f:	8d 50 01             	lea    0x1(%eax),%edx
     732:	89 55 f4             	mov    %edx,-0xc(%ebp)
     735:	89 c2                	mov    %eax,%edx
     737:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73a:	05 20 e4 00 00       	add    $0xe420,%eax
     73f:	88 10                	mov    %dl,(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     741:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     745:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     74c:	7e de                	jle    72c <pipe1+0x6a>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     74e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     751:	83 ec 04             	sub    $0x4,%esp
     754:	68 09 04 00 00       	push   $0x409
     759:	68 20 e4 00 00       	push   $0xe420
     75e:	50                   	push   %eax
     75f:	e8 bf 34 00 00       	call   3c23 <write>
     764:	83 c4 10             	add    $0x10,%esp
     767:	3d 09 04 00 00       	cmp    $0x409,%eax
     76c:	74 17                	je     785 <pipe1+0xc3>
        printf(1, "pipe1 oops 1\n");
     76e:	83 ec 08             	sub    $0x8,%esp
     771:	68 2c 61 00 00       	push   $0x612c
     776:	6a 01                	push   $0x1
     778:	e8 45 36 00 00       	call   3dc2 <printf>
     77d:	83 c4 10             	add    $0x10,%esp
        exit();
     780:	e8 7e 34 00 00       	call   3c03 <exit>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     785:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     789:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     78d:	7e 94                	jle    723 <pipe1+0x61>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     78f:	e8 6f 34 00 00       	call   3c03 <exit>
  } else if(pid > 0){
     794:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     798:	0f 8e f4 00 00 00    	jle    892 <pipe1+0x1d0>
    close(fds[1]);
     79e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     7a1:	83 ec 0c             	sub    $0xc,%esp
     7a4:	50                   	push   %eax
     7a5:	e8 81 34 00 00       	call   3c2b <close>
     7aa:	83 c4 10             	add    $0x10,%esp
    total = 0;
     7ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     7b4:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     7bb:	eb 66                	jmp    823 <pipe1+0x161>
      for(i = 0; i < n; i++){
     7bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7c4:	eb 3b                	jmp    801 <pipe1+0x13f>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     7c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c9:	05 20 e4 00 00       	add    $0xe420,%eax
     7ce:	0f b6 00             	movzbl (%eax),%eax
     7d1:	0f be c8             	movsbl %al,%ecx
     7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d7:	8d 50 01             	lea    0x1(%eax),%edx
     7da:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7dd:	31 c8                	xor    %ecx,%eax
     7df:	0f b6 c0             	movzbl %al,%eax
     7e2:	85 c0                	test   %eax,%eax
     7e4:	74 17                	je     7fd <pipe1+0x13b>
          printf(1, "pipe1 oops 2\n");
     7e6:	83 ec 08             	sub    $0x8,%esp
     7e9:	68 3a 61 00 00       	push   $0x613a
     7ee:	6a 01                	push   $0x1
     7f0:	e8 cd 35 00 00       	call   3dc2 <printf>
     7f5:	83 c4 10             	add    $0x10,%esp
     7f8:	e9 ac 00 00 00       	jmp    8a9 <pipe1+0x1e7>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     7fd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     801:	8b 45 f0             	mov    -0x10(%ebp),%eax
     804:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     807:	7c bd                	jl     7c6 <pipe1+0x104>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     809:	8b 45 ec             	mov    -0x14(%ebp),%eax
     80c:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     80f:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     812:	8b 45 e8             	mov    -0x18(%ebp),%eax
     815:	3d 00 20 00 00       	cmp    $0x2000,%eax
     81a:	76 07                	jbe    823 <pipe1+0x161>
        cc = sizeof(buf);
     81c:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     823:	8b 45 d8             	mov    -0x28(%ebp),%eax
     826:	83 ec 04             	sub    $0x4,%esp
     829:	ff 75 e8             	pushl  -0x18(%ebp)
     82c:	68 20 e4 00 00       	push   $0xe420
     831:	50                   	push   %eax
     832:	e8 e4 33 00 00       	call   3c1b <read>
     837:	83 c4 10             	add    $0x10,%esp
     83a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     83d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     841:	0f 8f 76 ff ff ff    	jg     7bd <pipe1+0xfb>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     847:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     84e:	74 1a                	je     86a <pipe1+0x1a8>
      printf(1, "pipe1 oops 3 total %d\n", total);
     850:	83 ec 04             	sub    $0x4,%esp
     853:	ff 75 e4             	pushl  -0x1c(%ebp)
     856:	68 48 61 00 00       	push   $0x6148
     85b:	6a 01                	push   $0x1
     85d:	e8 60 35 00 00       	call   3dc2 <printf>
     862:	83 c4 10             	add    $0x10,%esp
      exit();
     865:	e8 99 33 00 00       	call   3c03 <exit>
    }
    close(fds[0]);
     86a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     86d:	83 ec 0c             	sub    $0xc,%esp
     870:	50                   	push   %eax
     871:	e8 b5 33 00 00       	call   3c2b <close>
     876:	83 c4 10             	add    $0x10,%esp
    wait();
     879:	e8 8d 33 00 00       	call   3c0b <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     87e:	83 ec 08             	sub    $0x8,%esp
     881:	68 6e 61 00 00       	push   $0x616e
     886:	6a 01                	push   $0x1
     888:	e8 35 35 00 00       	call   3dc2 <printf>
     88d:	83 c4 10             	add    $0x10,%esp
     890:	eb 17                	jmp    8a9 <pipe1+0x1e7>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     892:	83 ec 08             	sub    $0x8,%esp
     895:	68 5f 61 00 00       	push   $0x615f
     89a:	6a 01                	push   $0x1
     89c:	e8 21 35 00 00       	call   3dc2 <printf>
     8a1:	83 c4 10             	add    $0x10,%esp
    exit();
     8a4:	e8 5a 33 00 00       	call   3c03 <exit>
  }
  printf(1, "pipe1 ok\n");
}
     8a9:	c9                   	leave  
     8aa:	c3                   	ret    

000008ab <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     8ab:	55                   	push   %ebp
     8ac:	89 e5                	mov    %esp,%ebp
     8ae:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     8b1:	83 ec 08             	sub    $0x8,%esp
     8b4:	68 78 61 00 00       	push   $0x6178
     8b9:	6a 01                	push   $0x1
     8bb:	e8 02 35 00 00       	call   3dc2 <printf>
     8c0:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     8c3:	e8 33 33 00 00       	call   3bfb <fork>
     8c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     8cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8cf:	75 02                	jne    8d3 <preempt+0x28>
    for(;;)
      ;
     8d1:	eb fe                	jmp    8d1 <preempt+0x26>

  pid2 = fork();
     8d3:	e8 23 33 00 00       	call   3bfb <fork>
     8d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     8db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8df:	75 02                	jne    8e3 <preempt+0x38>
    for(;;)
      ;
     8e1:	eb fe                	jmp    8e1 <preempt+0x36>

  pipe(pfds);
     8e3:	83 ec 0c             	sub    $0xc,%esp
     8e6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8e9:	50                   	push   %eax
     8ea:	e8 24 33 00 00       	call   3c13 <pipe>
     8ef:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     8f2:	e8 04 33 00 00       	call   3bfb <fork>
     8f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     8fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8fe:	75 4d                	jne    94d <preempt+0xa2>
    close(pfds[0]);
     900:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	50                   	push   %eax
     907:	e8 1f 33 00 00       	call   3c2b <close>
     90c:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     90f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     912:	83 ec 04             	sub    $0x4,%esp
     915:	6a 01                	push   $0x1
     917:	68 82 61 00 00       	push   $0x6182
     91c:	50                   	push   %eax
     91d:	e8 01 33 00 00       	call   3c23 <write>
     922:	83 c4 10             	add    $0x10,%esp
     925:	83 f8 01             	cmp    $0x1,%eax
     928:	74 12                	je     93c <preempt+0x91>
      printf(1, "preempt write error");
     92a:	83 ec 08             	sub    $0x8,%esp
     92d:	68 84 61 00 00       	push   $0x6184
     932:	6a 01                	push   $0x1
     934:	e8 89 34 00 00       	call   3dc2 <printf>
     939:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     93c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     93f:	83 ec 0c             	sub    $0xc,%esp
     942:	50                   	push   %eax
     943:	e8 e3 32 00 00       	call   3c2b <close>
     948:	83 c4 10             	add    $0x10,%esp
    for(;;)
      ;
     94b:	eb fe                	jmp    94b <preempt+0xa0>
  }

  close(pfds[1]);
     94d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     950:	83 ec 0c             	sub    $0xc,%esp
     953:	50                   	push   %eax
     954:	e8 d2 32 00 00       	call   3c2b <close>
     959:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     95c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     95f:	83 ec 04             	sub    $0x4,%esp
     962:	68 00 20 00 00       	push   $0x2000
     967:	68 20 e4 00 00       	push   $0xe420
     96c:	50                   	push   %eax
     96d:	e8 a9 32 00 00       	call   3c1b <read>
     972:	83 c4 10             	add    $0x10,%esp
     975:	83 f8 01             	cmp    $0x1,%eax
     978:	74 14                	je     98e <preempt+0xe3>
    printf(1, "preempt read error");
     97a:	83 ec 08             	sub    $0x8,%esp
     97d:	68 98 61 00 00       	push   $0x6198
     982:	6a 01                	push   $0x1
     984:	e8 39 34 00 00       	call   3dc2 <printf>
     989:	83 c4 10             	add    $0x10,%esp
     98c:	eb 7e                	jmp    a0c <preempt+0x161>
    return;
  }
  close(pfds[0]);
     98e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     991:	83 ec 0c             	sub    $0xc,%esp
     994:	50                   	push   %eax
     995:	e8 91 32 00 00       	call   3c2b <close>
     99a:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     99d:	83 ec 08             	sub    $0x8,%esp
     9a0:	68 ab 61 00 00       	push   $0x61ab
     9a5:	6a 01                	push   $0x1
     9a7:	e8 16 34 00 00       	call   3dc2 <printf>
     9ac:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     9af:	83 ec 0c             	sub    $0xc,%esp
     9b2:	ff 75 f4             	pushl  -0xc(%ebp)
     9b5:	e8 79 32 00 00       	call   3c33 <kill>
     9ba:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     9bd:	83 ec 0c             	sub    $0xc,%esp
     9c0:	ff 75 f0             	pushl  -0x10(%ebp)
     9c3:	e8 6b 32 00 00       	call   3c33 <kill>
     9c8:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     9cb:	83 ec 0c             	sub    $0xc,%esp
     9ce:	ff 75 ec             	pushl  -0x14(%ebp)
     9d1:	e8 5d 32 00 00       	call   3c33 <kill>
     9d6:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     9d9:	83 ec 08             	sub    $0x8,%esp
     9dc:	68 b4 61 00 00       	push   $0x61b4
     9e1:	6a 01                	push   $0x1
     9e3:	e8 da 33 00 00       	call   3dc2 <printf>
     9e8:	83 c4 10             	add    $0x10,%esp
  wait();
     9eb:	e8 1b 32 00 00       	call   3c0b <wait>
  wait();
     9f0:	e8 16 32 00 00       	call   3c0b <wait>
  wait();
     9f5:	e8 11 32 00 00       	call   3c0b <wait>
  printf(1, "preempt ok\n");
     9fa:	83 ec 08             	sub    $0x8,%esp
     9fd:	68 bd 61 00 00       	push   $0x61bd
     a02:	6a 01                	push   $0x1
     a04:	e8 b9 33 00 00       	call   3dc2 <printf>
     a09:	83 c4 10             	add    $0x10,%esp
}
     a0c:	c9                   	leave  
     a0d:	c3                   	ret    

00000a0e <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     a0e:	55                   	push   %ebp
     a0f:	89 e5                	mov    %esp,%ebp
     a11:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     a14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a1b:	eb 4f                	jmp    a6c <exitwait+0x5e>
    pid = fork();
     a1d:	e8 d9 31 00 00       	call   3bfb <fork>
     a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     a25:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a29:	79 14                	jns    a3f <exitwait+0x31>
      printf(1, "fork failed\n");
     a2b:	83 ec 08             	sub    $0x8,%esp
     a2e:	68 c9 61 00 00       	push   $0x61c9
     a33:	6a 01                	push   $0x1
     a35:	e8 88 33 00 00       	call   3dc2 <printf>
     a3a:	83 c4 10             	add    $0x10,%esp
      return;
     a3d:	eb 45                	jmp    a84 <exitwait+0x76>
    }
    if(pid){
     a3f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a43:	74 1e                	je     a63 <exitwait+0x55>
      if(wait() != pid){
     a45:	e8 c1 31 00 00       	call   3c0b <wait>
     a4a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     a4d:	74 19                	je     a68 <exitwait+0x5a>
        printf(1, "wait wrong pid\n");
     a4f:	83 ec 08             	sub    $0x8,%esp
     a52:	68 d6 61 00 00       	push   $0x61d6
     a57:	6a 01                	push   $0x1
     a59:	e8 64 33 00 00       	call   3dc2 <printf>
     a5e:	83 c4 10             	add    $0x10,%esp
        return;
     a61:	eb 21                	jmp    a84 <exitwait+0x76>
      }
    } else {
      exit();
     a63:	e8 9b 31 00 00       	call   3c03 <exit>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     a68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a6c:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     a70:	7e ab                	jle    a1d <exitwait+0xf>
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     a72:	83 ec 08             	sub    $0x8,%esp
     a75:	68 e6 61 00 00       	push   $0x61e6
     a7a:	6a 01                	push   $0x1
     a7c:	e8 41 33 00 00       	call   3dc2 <printf>
     a81:	83 c4 10             	add    $0x10,%esp
}
     a84:	c9                   	leave  
     a85:	c3                   	ret    

00000a86 <mem>:

void
mem(void)
{
     a86:	55                   	push   %ebp
     a87:	89 e5                	mov    %esp,%ebp
     a89:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     a8c:	83 ec 08             	sub    $0x8,%esp
     a8f:	68 f3 61 00 00       	push   $0x61f3
     a94:	6a 01                	push   $0x1
     a96:	e8 27 33 00 00       	call   3dc2 <printf>
     a9b:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     a9e:	e8 e0 31 00 00       	call   3c83 <getpid>
     aa3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     aa6:	e8 50 31 00 00       	call   3bfb <fork>
     aab:	89 45 ec             	mov    %eax,-0x14(%ebp)
     aae:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ab2:	0f 85 b7 00 00 00    	jne    b6f <mem+0xe9>
    m1 = 0;
     ab8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     abf:	eb 0e                	jmp    acf <mem+0x49>
      *(char**)m2 = m1;
     ac1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ac7:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     ac9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     acc:	89 45 f4             	mov    %eax,-0xc(%ebp)

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	68 11 27 00 00       	push   $0x2711
     ad7:	e8 b9 35 00 00       	call   4095 <malloc>
     adc:	83 c4 10             	add    $0x10,%esp
     adf:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ae2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ae6:	75 d9                	jne    ac1 <mem+0x3b>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     ae8:	eb 1c                	jmp    b06 <mem+0x80>
      m2 = *(char**)m1;
     aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aed:	8b 00                	mov    (%eax),%eax
     aef:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     af2:	83 ec 0c             	sub    $0xc,%esp
     af5:	ff 75 f4             	pushl  -0xc(%ebp)
     af8:	e8 56 34 00 00       	call   3f53 <free>
     afd:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     b00:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b03:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     b06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b0a:	75 de                	jne    aea <mem+0x64>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     b0c:	83 ec 0c             	sub    $0xc,%esp
     b0f:	68 00 50 00 00       	push   $0x5000
     b14:	e8 7c 35 00 00       	call   4095 <malloc>
     b19:	83 c4 10             	add    $0x10,%esp
     b1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     b1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b23:	75 25                	jne    b4a <mem+0xc4>
      printf(1, "couldn't allocate mem?!!\n");
     b25:	83 ec 08             	sub    $0x8,%esp
     b28:	68 fd 61 00 00       	push   $0x61fd
     b2d:	6a 01                	push   $0x1
     b2f:	e8 8e 32 00 00       	call   3dc2 <printf>
     b34:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     b37:	83 ec 0c             	sub    $0xc,%esp
     b3a:	ff 75 f0             	pushl  -0x10(%ebp)
     b3d:	e8 f1 30 00 00       	call   3c33 <kill>
     b42:	83 c4 10             	add    $0x10,%esp
      exit();
     b45:	e8 b9 30 00 00       	call   3c03 <exit>
    }
    free(m1);
     b4a:	83 ec 0c             	sub    $0xc,%esp
     b4d:	ff 75 f4             	pushl  -0xc(%ebp)
     b50:	e8 fe 33 00 00       	call   3f53 <free>
     b55:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     b58:	83 ec 08             	sub    $0x8,%esp
     b5b:	68 17 62 00 00       	push   $0x6217
     b60:	6a 01                	push   $0x1
     b62:	e8 5b 32 00 00       	call   3dc2 <printf>
     b67:	83 c4 10             	add    $0x10,%esp
    exit();
     b6a:	e8 94 30 00 00       	call   3c03 <exit>
  } else {
    wait();
     b6f:	e8 97 30 00 00       	call   3c0b <wait>
  }
}
     b74:	90                   	nop
     b75:	c9                   	leave  
     b76:	c3                   	ret    

00000b77 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     b77:	55                   	push   %ebp
     b78:	89 e5                	mov    %esp,%ebp
     b7a:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     b7d:	83 ec 08             	sub    $0x8,%esp
     b80:	68 1f 62 00 00       	push   $0x621f
     b85:	6a 01                	push   $0x1
     b87:	e8 36 32 00 00       	call   3dc2 <printf>
     b8c:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     b8f:	83 ec 0c             	sub    $0xc,%esp
     b92:	68 2e 62 00 00       	push   $0x622e
     b97:	e8 b7 30 00 00       	call   3c53 <unlink>
     b9c:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     b9f:	83 ec 08             	sub    $0x8,%esp
     ba2:	68 02 02 00 00       	push   $0x202
     ba7:	68 2e 62 00 00       	push   $0x622e
     bac:	e8 92 30 00 00       	call   3c43 <open>
     bb1:	83 c4 10             	add    $0x10,%esp
     bb4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     bb7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     bbb:	79 17                	jns    bd4 <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     bbd:	83 ec 08             	sub    $0x8,%esp
     bc0:	68 38 62 00 00       	push   $0x6238
     bc5:	6a 01                	push   $0x1
     bc7:	e8 f6 31 00 00       	call   3dc2 <printf>
     bcc:	83 c4 10             	add    $0x10,%esp
    return;
     bcf:	e9 84 01 00 00       	jmp    d58 <sharedfd+0x1e1>
  }
  pid = fork();
     bd4:	e8 22 30 00 00       	call   3bfb <fork>
     bd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     bdc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     be0:	75 07                	jne    be9 <sharedfd+0x72>
     be2:	b8 63 00 00 00       	mov    $0x63,%eax
     be7:	eb 05                	jmp    bee <sharedfd+0x77>
     be9:	b8 70 00 00 00       	mov    $0x70,%eax
     bee:	83 ec 04             	sub    $0x4,%esp
     bf1:	6a 0a                	push   $0xa
     bf3:	50                   	push   %eax
     bf4:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     bf7:	50                   	push   %eax
     bf8:	e8 6b 2e 00 00       	call   3a68 <memset>
     bfd:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     c00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c07:	eb 31                	jmp    c3a <sharedfd+0xc3>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     c09:	83 ec 04             	sub    $0x4,%esp
     c0c:	6a 0a                	push   $0xa
     c0e:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     c11:	50                   	push   %eax
     c12:	ff 75 e8             	pushl  -0x18(%ebp)
     c15:	e8 09 30 00 00       	call   3c23 <write>
     c1a:	83 c4 10             	add    $0x10,%esp
     c1d:	83 f8 0a             	cmp    $0xa,%eax
     c20:	74 14                	je     c36 <sharedfd+0xbf>
      printf(1, "fstests: write sharedfd failed\n");
     c22:	83 ec 08             	sub    $0x8,%esp
     c25:	68 64 62 00 00       	push   $0x6264
     c2a:	6a 01                	push   $0x1
     c2c:	e8 91 31 00 00       	call   3dc2 <printf>
     c31:	83 c4 10             	add    $0x10,%esp
      break;
     c34:	eb 0d                	jmp    c43 <sharedfd+0xcc>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
  for(i = 0; i < 1000; i++){
     c36:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c3a:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     c41:	7e c6                	jle    c09 <sharedfd+0x92>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
     c43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c47:	75 05                	jne    c4e <sharedfd+0xd7>
    exit();
     c49:	e8 b5 2f 00 00       	call   3c03 <exit>
  else
    wait();
     c4e:	e8 b8 2f 00 00       	call   3c0b <wait>
  close(fd);
     c53:	83 ec 0c             	sub    $0xc,%esp
     c56:	ff 75 e8             	pushl  -0x18(%ebp)
     c59:	e8 cd 2f 00 00       	call   3c2b <close>
     c5e:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     c61:	83 ec 08             	sub    $0x8,%esp
     c64:	6a 00                	push   $0x0
     c66:	68 2e 62 00 00       	push   $0x622e
     c6b:	e8 d3 2f 00 00       	call   3c43 <open>
     c70:	83 c4 10             	add    $0x10,%esp
     c73:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     c76:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c7a:	79 17                	jns    c93 <sharedfd+0x11c>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     c7c:	83 ec 08             	sub    $0x8,%esp
     c7f:	68 84 62 00 00       	push   $0x6284
     c84:	6a 01                	push   $0x1
     c86:	e8 37 31 00 00       	call   3dc2 <printf>
     c8b:	83 c4 10             	add    $0x10,%esp
    return;
     c8e:	e9 c5 00 00 00       	jmp    d58 <sharedfd+0x1e1>
  }
  nc = np = 0;
     c93:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     c9a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     ca0:	eb 3b                	jmp    cdd <sharedfd+0x166>
    for(i = 0; i < sizeof(buf); i++){
     ca2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ca9:	eb 2a                	jmp    cd5 <sharedfd+0x15e>
      if(buf[i] == 'c')
     cab:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb1:	01 d0                	add    %edx,%eax
     cb3:	0f b6 00             	movzbl (%eax),%eax
     cb6:	3c 63                	cmp    $0x63,%al
     cb8:	75 04                	jne    cbe <sharedfd+0x147>
        nc++;
     cba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
     cbe:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc4:	01 d0                	add    %edx,%eax
     cc6:	0f b6 00             	movzbl (%eax),%eax
     cc9:	3c 70                	cmp    $0x70,%al
     ccb:	75 04                	jne    cd1 <sharedfd+0x15a>
        np++;
     ccd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     cd1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd8:	83 f8 09             	cmp    $0x9,%eax
     cdb:	76 ce                	jbe    cab <sharedfd+0x134>
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     cdd:	83 ec 04             	sub    $0x4,%esp
     ce0:	6a 0a                	push   $0xa
     ce2:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ce5:	50                   	push   %eax
     ce6:	ff 75 e8             	pushl  -0x18(%ebp)
     ce9:	e8 2d 2f 00 00       	call   3c1b <read>
     cee:	83 c4 10             	add    $0x10,%esp
     cf1:	89 45 e0             	mov    %eax,-0x20(%ebp)
     cf4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     cf8:	7f a8                	jg     ca2 <sharedfd+0x12b>
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     cfa:	83 ec 0c             	sub    $0xc,%esp
     cfd:	ff 75 e8             	pushl  -0x18(%ebp)
     d00:	e8 26 2f 00 00       	call   3c2b <close>
     d05:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
     d08:	83 ec 0c             	sub    $0xc,%esp
     d0b:	68 2e 62 00 00       	push   $0x622e
     d10:	e8 3e 2f 00 00       	call   3c53 <unlink>
     d15:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
     d18:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
     d1f:	75 1d                	jne    d3e <sharedfd+0x1c7>
     d21:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
     d28:	75 14                	jne    d3e <sharedfd+0x1c7>
    printf(1, "sharedfd ok\n");
     d2a:	83 ec 08             	sub    $0x8,%esp
     d2d:	68 af 62 00 00       	push   $0x62af
     d32:	6a 01                	push   $0x1
     d34:	e8 89 30 00 00       	call   3dc2 <printf>
     d39:	83 c4 10             	add    $0x10,%esp
     d3c:	eb 1a                	jmp    d58 <sharedfd+0x1e1>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     d3e:	ff 75 ec             	pushl  -0x14(%ebp)
     d41:	ff 75 f0             	pushl  -0x10(%ebp)
     d44:	68 bc 62 00 00       	push   $0x62bc
     d49:	6a 01                	push   $0x1
     d4b:	e8 72 30 00 00       	call   3dc2 <printf>
     d50:	83 c4 10             	add    $0x10,%esp
    exit();
     d53:	e8 ab 2e 00 00       	call   3c03 <exit>
  }
}
     d58:	c9                   	leave  
     d59:	c3                   	ret    

00000d5a <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     d5a:	55                   	push   %ebp
     d5b:	89 e5                	mov    %esp,%ebp
     d5d:	83 ec 28             	sub    $0x28,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     d60:	83 ec 08             	sub    $0x8,%esp
     d63:	68 d1 62 00 00       	push   $0x62d1
     d68:	6a 01                	push   $0x1
     d6a:	e8 53 30 00 00       	call   3dc2 <printf>
     d6f:	83 c4 10             	add    $0x10,%esp

  unlink("f1");
     d72:	83 ec 0c             	sub    $0xc,%esp
     d75:	68 e0 62 00 00       	push   $0x62e0
     d7a:	e8 d4 2e 00 00       	call   3c53 <unlink>
     d7f:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     d82:	83 ec 0c             	sub    $0xc,%esp
     d85:	68 e3 62 00 00       	push   $0x62e3
     d8a:	e8 c4 2e 00 00       	call   3c53 <unlink>
     d8f:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     d92:	e8 64 2e 00 00       	call   3bfb <fork>
     d97:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
     d9a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d9e:	79 17                	jns    db7 <twofiles+0x5d>
    printf(1, "fork failed\n");
     da0:	83 ec 08             	sub    $0x8,%esp
     da3:	68 c9 61 00 00       	push   $0x61c9
     da8:	6a 01                	push   $0x1
     daa:	e8 13 30 00 00       	call   3dc2 <printf>
     daf:	83 c4 10             	add    $0x10,%esp
    exit();
     db2:	e8 4c 2e 00 00       	call   3c03 <exit>
  }

  fname = pid ? "f1" : "f2";
     db7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     dbb:	74 07                	je     dc4 <twofiles+0x6a>
     dbd:	b8 e0 62 00 00       	mov    $0x62e0,%eax
     dc2:	eb 05                	jmp    dc9 <twofiles+0x6f>
     dc4:	b8 e3 62 00 00       	mov    $0x62e3,%eax
     dc9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  fd = open(fname, O_CREATE | O_RDWR);
     dcc:	83 ec 08             	sub    $0x8,%esp
     dcf:	68 02 02 00 00       	push   $0x202
     dd4:	ff 75 e4             	pushl  -0x1c(%ebp)
     dd7:	e8 67 2e 00 00       	call   3c43 <open>
     ddc:	83 c4 10             	add    $0x10,%esp
     ddf:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(fd < 0){
     de2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     de6:	79 17                	jns    dff <twofiles+0xa5>
    printf(1, "create failed\n");
     de8:	83 ec 08             	sub    $0x8,%esp
     deb:	68 e6 62 00 00       	push   $0x62e6
     df0:	6a 01                	push   $0x1
     df2:	e8 cb 2f 00 00       	call   3dc2 <printf>
     df7:	83 c4 10             	add    $0x10,%esp
    exit();
     dfa:	e8 04 2e 00 00       	call   3c03 <exit>
  }

  memset(buf, pid?'p':'c', 512);
     dff:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e03:	74 07                	je     e0c <twofiles+0xb2>
     e05:	b8 70 00 00 00       	mov    $0x70,%eax
     e0a:	eb 05                	jmp    e11 <twofiles+0xb7>
     e0c:	b8 63 00 00 00       	mov    $0x63,%eax
     e11:	83 ec 04             	sub    $0x4,%esp
     e14:	68 00 02 00 00       	push   $0x200
     e19:	50                   	push   %eax
     e1a:	68 20 e4 00 00       	push   $0xe420
     e1f:	e8 44 2c 00 00       	call   3a68 <memset>
     e24:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 12; i++){
     e27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e2e:	eb 42                	jmp    e72 <twofiles+0x118>
    if((n = write(fd, buf, 500)) != 500){
     e30:	83 ec 04             	sub    $0x4,%esp
     e33:	68 f4 01 00 00       	push   $0x1f4
     e38:	68 20 e4 00 00       	push   $0xe420
     e3d:	ff 75 e0             	pushl  -0x20(%ebp)
     e40:	e8 de 2d 00 00       	call   3c23 <write>
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e4b:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
     e52:	74 1a                	je     e6e <twofiles+0x114>
      printf(1, "write failed %d\n", n);
     e54:	83 ec 04             	sub    $0x4,%esp
     e57:	ff 75 dc             	pushl  -0x24(%ebp)
     e5a:	68 f5 62 00 00       	push   $0x62f5
     e5f:	6a 01                	push   $0x1
     e61:	e8 5c 2f 00 00       	call   3dc2 <printf>
     e66:	83 c4 10             	add    $0x10,%esp
      exit();
     e69:	e8 95 2d 00 00       	call   3c03 <exit>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
     e6e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e72:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
     e76:	7e b8                	jle    e30 <twofiles+0xd6>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
     e78:	83 ec 0c             	sub    $0xc,%esp
     e7b:	ff 75 e0             	pushl  -0x20(%ebp)
     e7e:	e8 a8 2d 00 00       	call   3c2b <close>
     e83:	83 c4 10             	add    $0x10,%esp
  if(pid)
     e86:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e8a:	74 11                	je     e9d <twofiles+0x143>
    wait();
     e8c:	e8 7a 2d 00 00       	call   3c0b <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     e91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e98:	e9 dd 00 00 00       	jmp    f7a <twofiles+0x220>
  }
  close(fd);
  if(pid)
    wait();
  else
    exit();
     e9d:	e8 61 2d 00 00       	call   3c03 <exit>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
     ea2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ea6:	74 07                	je     eaf <twofiles+0x155>
     ea8:	b8 e0 62 00 00       	mov    $0x62e0,%eax
     ead:	eb 05                	jmp    eb4 <twofiles+0x15a>
     eaf:	b8 e3 62 00 00       	mov    $0x62e3,%eax
     eb4:	83 ec 08             	sub    $0x8,%esp
     eb7:	6a 00                	push   $0x0
     eb9:	50                   	push   %eax
     eba:	e8 84 2d 00 00       	call   3c43 <open>
     ebf:	83 c4 10             	add    $0x10,%esp
     ec2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    total = 0;
     ec5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     ecc:	eb 56                	jmp    f24 <twofiles+0x1ca>
      for(j = 0; j < n; j++){
     ece:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ed5:	eb 3f                	jmp    f16 <twofiles+0x1bc>
        if(buf[j] != (i?'p':'c')){
     ed7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eda:	05 20 e4 00 00       	add    $0xe420,%eax
     edf:	0f b6 00             	movzbl (%eax),%eax
     ee2:	0f be c0             	movsbl %al,%eax
     ee5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ee9:	74 07                	je     ef2 <twofiles+0x198>
     eeb:	ba 70 00 00 00       	mov    $0x70,%edx
     ef0:	eb 05                	jmp    ef7 <twofiles+0x19d>
     ef2:	ba 63 00 00 00       	mov    $0x63,%edx
     ef7:	39 d0                	cmp    %edx,%eax
     ef9:	74 17                	je     f12 <twofiles+0x1b8>
          printf(1, "wrong char\n");
     efb:	83 ec 08             	sub    $0x8,%esp
     efe:	68 06 63 00 00       	push   $0x6306
     f03:	6a 01                	push   $0x1
     f05:	e8 b8 2e 00 00       	call   3dc2 <printf>
     f0a:	83 c4 10             	add    $0x10,%esp
          exit();
     f0d:	e8 f1 2c 00 00       	call   3c03 <exit>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
     f12:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f19:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     f1c:	7c b9                	jl     ed7 <twofiles+0x17d>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
     f1e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f21:	01 45 ec             	add    %eax,-0x14(%ebp)
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f24:	83 ec 04             	sub    $0x4,%esp
     f27:	68 00 20 00 00       	push   $0x2000
     f2c:	68 20 e4 00 00       	push   $0xe420
     f31:	ff 75 e0             	pushl  -0x20(%ebp)
     f34:	e8 e2 2c 00 00       	call   3c1b <read>
     f39:	83 c4 10             	add    $0x10,%esp
     f3c:	89 45 dc             	mov    %eax,-0x24(%ebp)
     f3f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     f43:	7f 89                	jg     ece <twofiles+0x174>
          exit();
        }
      }
      total += n;
    }
    close(fd);
     f45:	83 ec 0c             	sub    $0xc,%esp
     f48:	ff 75 e0             	pushl  -0x20(%ebp)
     f4b:	e8 db 2c 00 00       	call   3c2b <close>
     f50:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
     f53:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
     f5a:	74 1a                	je     f76 <twofiles+0x21c>
      printf(1, "wrong length %d\n", total);
     f5c:	83 ec 04             	sub    $0x4,%esp
     f5f:	ff 75 ec             	pushl  -0x14(%ebp)
     f62:	68 12 63 00 00       	push   $0x6312
     f67:	6a 01                	push   $0x1
     f69:	e8 54 2e 00 00       	call   3dc2 <printf>
     f6e:	83 c4 10             	add    $0x10,%esp
      exit();
     f71:	e8 8d 2c 00 00       	call   3c03 <exit>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
     f76:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f7a:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
     f7e:	0f 8e 1e ff ff ff    	jle    ea2 <twofiles+0x148>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
     f84:	83 ec 0c             	sub    $0xc,%esp
     f87:	68 e0 62 00 00       	push   $0x62e0
     f8c:	e8 c2 2c 00 00       	call   3c53 <unlink>
     f91:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     f94:	83 ec 0c             	sub    $0xc,%esp
     f97:	68 e3 62 00 00       	push   $0x62e3
     f9c:	e8 b2 2c 00 00       	call   3c53 <unlink>
     fa1:	83 c4 10             	add    $0x10,%esp

  printf(1, "twofiles ok\n");
     fa4:	83 ec 08             	sub    $0x8,%esp
     fa7:	68 23 63 00 00       	push   $0x6323
     fac:	6a 01                	push   $0x1
     fae:	e8 0f 2e 00 00       	call   3dc2 <printf>
     fb3:	83 c4 10             	add    $0x10,%esp
}
     fb6:	90                   	nop
     fb7:	c9                   	leave  
     fb8:	c3                   	ret    

00000fb9 <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
     fb9:	55                   	push   %ebp
     fba:	89 e5                	mov    %esp,%ebp
     fbc:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
     fbf:	83 ec 08             	sub    $0x8,%esp
     fc2:	68 30 63 00 00       	push   $0x6330
     fc7:	6a 01                	push   $0x1
     fc9:	e8 f4 2d 00 00       	call   3dc2 <printf>
     fce:	83 c4 10             	add    $0x10,%esp
  pid = fork();
     fd1:	e8 25 2c 00 00       	call   3bfb <fork>
     fd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid < 0){
     fd9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fdd:	79 17                	jns    ff6 <createdelete+0x3d>
    printf(1, "fork failed\n");
     fdf:	83 ec 08             	sub    $0x8,%esp
     fe2:	68 c9 61 00 00       	push   $0x61c9
     fe7:	6a 01                	push   $0x1
     fe9:	e8 d4 2d 00 00       	call   3dc2 <printf>
     fee:	83 c4 10             	add    $0x10,%esp
    exit();
     ff1:	e8 0d 2c 00 00       	call   3c03 <exit>
  }

  name[0] = pid ? 'p' : 'c';
     ff6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ffa:	74 07                	je     1003 <createdelete+0x4a>
     ffc:	b8 70 00 00 00       	mov    $0x70,%eax
    1001:	eb 05                	jmp    1008 <createdelete+0x4f>
    1003:	b8 63 00 00 00       	mov    $0x63,%eax
    1008:	88 45 cc             	mov    %al,-0x34(%ebp)
  name[2] = '\0';
    100b:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
  for(i = 0; i < N; i++){
    100f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1016:	e9 9b 00 00 00       	jmp    10b6 <createdelete+0xfd>
    name[1] = '0' + i;
    101b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101e:	83 c0 30             	add    $0x30,%eax
    1021:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    1024:	83 ec 08             	sub    $0x8,%esp
    1027:	68 02 02 00 00       	push   $0x202
    102c:	8d 45 cc             	lea    -0x34(%ebp),%eax
    102f:	50                   	push   %eax
    1030:	e8 0e 2c 00 00       	call   3c43 <open>
    1035:	83 c4 10             	add    $0x10,%esp
    1038:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    103b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    103f:	79 17                	jns    1058 <createdelete+0x9f>
      printf(1, "create failed\n");
    1041:	83 ec 08             	sub    $0x8,%esp
    1044:	68 e6 62 00 00       	push   $0x62e6
    1049:	6a 01                	push   $0x1
    104b:	e8 72 2d 00 00       	call   3dc2 <printf>
    1050:	83 c4 10             	add    $0x10,%esp
      exit();
    1053:	e8 ab 2b 00 00       	call   3c03 <exit>
    }
    close(fd);
    1058:	83 ec 0c             	sub    $0xc,%esp
    105b:	ff 75 ec             	pushl  -0x14(%ebp)
    105e:	e8 c8 2b 00 00       	call   3c2b <close>
    1063:	83 c4 10             	add    $0x10,%esp
    if(i > 0 && (i % 2 ) == 0){
    1066:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    106a:	7e 46                	jle    10b2 <createdelete+0xf9>
    106c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106f:	83 e0 01             	and    $0x1,%eax
    1072:	85 c0                	test   %eax,%eax
    1074:	75 3c                	jne    10b2 <createdelete+0xf9>
      name[1] = '0' + (i / 2);
    1076:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1079:	89 c2                	mov    %eax,%edx
    107b:	c1 ea 1f             	shr    $0x1f,%edx
    107e:	01 d0                	add    %edx,%eax
    1080:	d1 f8                	sar    %eax
    1082:	83 c0 30             	add    $0x30,%eax
    1085:	88 45 cd             	mov    %al,-0x33(%ebp)
      if(unlink(name) < 0){
    1088:	83 ec 0c             	sub    $0xc,%esp
    108b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    108e:	50                   	push   %eax
    108f:	e8 bf 2b 00 00       	call   3c53 <unlink>
    1094:	83 c4 10             	add    $0x10,%esp
    1097:	85 c0                	test   %eax,%eax
    1099:	79 17                	jns    10b2 <createdelete+0xf9>
        printf(1, "unlink failed\n");
    109b:	83 ec 08             	sub    $0x8,%esp
    109e:	68 43 63 00 00       	push   $0x6343
    10a3:	6a 01                	push   $0x1
    10a5:	e8 18 2d 00 00       	call   3dc2 <printf>
    10aa:	83 c4 10             	add    $0x10,%esp
        exit();
    10ad:	e8 51 2b 00 00       	call   3c03 <exit>
    exit();
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
  for(i = 0; i < N; i++){
    10b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10b6:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10ba:	0f 8e 5b ff ff ff    	jle    101b <createdelete+0x62>
        exit();
      }
    }
  }

  if(pid==0)
    10c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10c4:	75 05                	jne    10cb <createdelete+0x112>
    exit();
    10c6:	e8 38 2b 00 00       	call   3c03 <exit>
  else
    wait();
    10cb:	e8 3b 2b 00 00       	call   3c0b <wait>

  for(i = 0; i < N; i++){
    10d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10d7:	e9 22 01 00 00       	jmp    11fe <createdelete+0x245>
    name[0] = 'p';
    10dc:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    10e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e3:	83 c0 30             	add    $0x30,%eax
    10e6:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    10e9:	83 ec 08             	sub    $0x8,%esp
    10ec:	6a 00                	push   $0x0
    10ee:	8d 45 cc             	lea    -0x34(%ebp),%eax
    10f1:	50                   	push   %eax
    10f2:	e8 4c 2b 00 00       	call   3c43 <open>
    10f7:	83 c4 10             	add    $0x10,%esp
    10fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    10fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1101:	74 06                	je     1109 <createdelete+0x150>
    1103:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1107:	7e 21                	jle    112a <createdelete+0x171>
    1109:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    110d:	79 1b                	jns    112a <createdelete+0x171>
      printf(1, "oops createdelete %s didn't exist\n", name);
    110f:	83 ec 04             	sub    $0x4,%esp
    1112:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1115:	50                   	push   %eax
    1116:	68 54 63 00 00       	push   $0x6354
    111b:	6a 01                	push   $0x1
    111d:	e8 a0 2c 00 00       	call   3dc2 <printf>
    1122:	83 c4 10             	add    $0x10,%esp
      exit();
    1125:	e8 d9 2a 00 00       	call   3c03 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    112a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    112e:	7e 27                	jle    1157 <createdelete+0x19e>
    1130:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1134:	7f 21                	jg     1157 <createdelete+0x19e>
    1136:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    113a:	78 1b                	js     1157 <createdelete+0x19e>
      printf(1, "oops createdelete %s did exist\n", name);
    113c:	83 ec 04             	sub    $0x4,%esp
    113f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1142:	50                   	push   %eax
    1143:	68 78 63 00 00       	push   $0x6378
    1148:	6a 01                	push   $0x1
    114a:	e8 73 2c 00 00       	call   3dc2 <printf>
    114f:	83 c4 10             	add    $0x10,%esp
      exit();
    1152:	e8 ac 2a 00 00       	call   3c03 <exit>
    }
    if(fd >= 0)
    1157:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    115b:	78 0e                	js     116b <createdelete+0x1b2>
      close(fd);
    115d:	83 ec 0c             	sub    $0xc,%esp
    1160:	ff 75 ec             	pushl  -0x14(%ebp)
    1163:	e8 c3 2a 00 00       	call   3c2b <close>
    1168:	83 c4 10             	add    $0x10,%esp

    name[0] = 'c';
    116b:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    name[1] = '0' + i;
    116f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1172:	83 c0 30             	add    $0x30,%eax
    1175:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    1178:	83 ec 08             	sub    $0x8,%esp
    117b:	6a 00                	push   $0x0
    117d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1180:	50                   	push   %eax
    1181:	e8 bd 2a 00 00       	call   3c43 <open>
    1186:	83 c4 10             	add    $0x10,%esp
    1189:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    118c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1190:	74 06                	je     1198 <createdelete+0x1df>
    1192:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1196:	7e 21                	jle    11b9 <createdelete+0x200>
    1198:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    119c:	79 1b                	jns    11b9 <createdelete+0x200>
      printf(1, "oops createdelete %s didn't exist\n", name);
    119e:	83 ec 04             	sub    $0x4,%esp
    11a1:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11a4:	50                   	push   %eax
    11a5:	68 54 63 00 00       	push   $0x6354
    11aa:	6a 01                	push   $0x1
    11ac:	e8 11 2c 00 00       	call   3dc2 <printf>
    11b1:	83 c4 10             	add    $0x10,%esp
      exit();
    11b4:	e8 4a 2a 00 00       	call   3c03 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    11b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11bd:	7e 27                	jle    11e6 <createdelete+0x22d>
    11bf:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11c3:	7f 21                	jg     11e6 <createdelete+0x22d>
    11c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11c9:	78 1b                	js     11e6 <createdelete+0x22d>
      printf(1, "oops createdelete %s did exist\n", name);
    11cb:	83 ec 04             	sub    $0x4,%esp
    11ce:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11d1:	50                   	push   %eax
    11d2:	68 78 63 00 00       	push   $0x6378
    11d7:	6a 01                	push   $0x1
    11d9:	e8 e4 2b 00 00       	call   3dc2 <printf>
    11de:	83 c4 10             	add    $0x10,%esp
      exit();
    11e1:	e8 1d 2a 00 00       	call   3c03 <exit>
    }
    if(fd >= 0)
    11e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11ea:	78 0e                	js     11fa <createdelete+0x241>
      close(fd);
    11ec:	83 ec 0c             	sub    $0xc,%esp
    11ef:	ff 75 ec             	pushl  -0x14(%ebp)
    11f2:	e8 34 2a 00 00       	call   3c2b <close>
    11f7:	83 c4 10             	add    $0x10,%esp
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    11fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11fe:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1202:	0f 8e d4 fe ff ff    	jle    10dc <createdelete+0x123>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1208:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    120f:	eb 33                	jmp    1244 <createdelete+0x28b>
    name[0] = 'p';
    1211:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    1215:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1218:	83 c0 30             	add    $0x30,%eax
    121b:	88 45 cd             	mov    %al,-0x33(%ebp)
    unlink(name);
    121e:	83 ec 0c             	sub    $0xc,%esp
    1221:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1224:	50                   	push   %eax
    1225:	e8 29 2a 00 00       	call   3c53 <unlink>
    122a:	83 c4 10             	add    $0x10,%esp
    name[0] = 'c';
    122d:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    unlink(name);
    1231:	83 ec 0c             	sub    $0xc,%esp
    1234:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1237:	50                   	push   %eax
    1238:	e8 16 2a 00 00       	call   3c53 <unlink>
    123d:	83 c4 10             	add    $0x10,%esp
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1240:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1244:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1248:	7e c7                	jle    1211 <createdelete+0x258>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
    124a:	83 ec 08             	sub    $0x8,%esp
    124d:	68 98 63 00 00       	push   $0x6398
    1252:	6a 01                	push   $0x1
    1254:	e8 69 2b 00 00       	call   3dc2 <printf>
    1259:	83 c4 10             	add    $0x10,%esp
}
    125c:	90                   	nop
    125d:	c9                   	leave  
    125e:	c3                   	ret    

0000125f <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    125f:	55                   	push   %ebp
    1260:	89 e5                	mov    %esp,%ebp
    1262:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1265:	83 ec 08             	sub    $0x8,%esp
    1268:	68 a9 63 00 00       	push   $0x63a9
    126d:	6a 01                	push   $0x1
    126f:	e8 4e 2b 00 00       	call   3dc2 <printf>
    1274:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1277:	83 ec 08             	sub    $0x8,%esp
    127a:	68 02 02 00 00       	push   $0x202
    127f:	68 ba 63 00 00       	push   $0x63ba
    1284:	e8 ba 29 00 00       	call   3c43 <open>
    1289:	83 c4 10             	add    $0x10,%esp
    128c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    128f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1293:	79 17                	jns    12ac <unlinkread+0x4d>
    printf(1, "create unlinkread failed\n");
    1295:	83 ec 08             	sub    $0x8,%esp
    1298:	68 c5 63 00 00       	push   $0x63c5
    129d:	6a 01                	push   $0x1
    129f:	e8 1e 2b 00 00       	call   3dc2 <printf>
    12a4:	83 c4 10             	add    $0x10,%esp
    exit();
    12a7:	e8 57 29 00 00       	call   3c03 <exit>
  }
  write(fd, "hello", 5);
    12ac:	83 ec 04             	sub    $0x4,%esp
    12af:	6a 05                	push   $0x5
    12b1:	68 df 63 00 00       	push   $0x63df
    12b6:	ff 75 f4             	pushl  -0xc(%ebp)
    12b9:	e8 65 29 00 00       	call   3c23 <write>
    12be:	83 c4 10             	add    $0x10,%esp
  close(fd);
    12c1:	83 ec 0c             	sub    $0xc,%esp
    12c4:	ff 75 f4             	pushl  -0xc(%ebp)
    12c7:	e8 5f 29 00 00       	call   3c2b <close>
    12cc:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    12cf:	83 ec 08             	sub    $0x8,%esp
    12d2:	6a 02                	push   $0x2
    12d4:	68 ba 63 00 00       	push   $0x63ba
    12d9:	e8 65 29 00 00       	call   3c43 <open>
    12de:	83 c4 10             	add    $0x10,%esp
    12e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    12e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12e8:	79 17                	jns    1301 <unlinkread+0xa2>
    printf(1, "open unlinkread failed\n");
    12ea:	83 ec 08             	sub    $0x8,%esp
    12ed:	68 e5 63 00 00       	push   $0x63e5
    12f2:	6a 01                	push   $0x1
    12f4:	e8 c9 2a 00 00       	call   3dc2 <printf>
    12f9:	83 c4 10             	add    $0x10,%esp
    exit();
    12fc:	e8 02 29 00 00       	call   3c03 <exit>
  }
  if(unlink("unlinkread") != 0){
    1301:	83 ec 0c             	sub    $0xc,%esp
    1304:	68 ba 63 00 00       	push   $0x63ba
    1309:	e8 45 29 00 00       	call   3c53 <unlink>
    130e:	83 c4 10             	add    $0x10,%esp
    1311:	85 c0                	test   %eax,%eax
    1313:	74 17                	je     132c <unlinkread+0xcd>
    printf(1, "unlink unlinkread failed\n");
    1315:	83 ec 08             	sub    $0x8,%esp
    1318:	68 fd 63 00 00       	push   $0x63fd
    131d:	6a 01                	push   $0x1
    131f:	e8 9e 2a 00 00       	call   3dc2 <printf>
    1324:	83 c4 10             	add    $0x10,%esp
    exit();
    1327:	e8 d7 28 00 00       	call   3c03 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    132c:	83 ec 08             	sub    $0x8,%esp
    132f:	68 02 02 00 00       	push   $0x202
    1334:	68 ba 63 00 00       	push   $0x63ba
    1339:	e8 05 29 00 00       	call   3c43 <open>
    133e:	83 c4 10             	add    $0x10,%esp
    1341:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    1344:	83 ec 04             	sub    $0x4,%esp
    1347:	6a 03                	push   $0x3
    1349:	68 17 64 00 00       	push   $0x6417
    134e:	ff 75 f0             	pushl  -0x10(%ebp)
    1351:	e8 cd 28 00 00       	call   3c23 <write>
    1356:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1359:	83 ec 0c             	sub    $0xc,%esp
    135c:	ff 75 f0             	pushl  -0x10(%ebp)
    135f:	e8 c7 28 00 00       	call   3c2b <close>
    1364:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    1367:	83 ec 04             	sub    $0x4,%esp
    136a:	68 00 20 00 00       	push   $0x2000
    136f:	68 20 e4 00 00       	push   $0xe420
    1374:	ff 75 f4             	pushl  -0xc(%ebp)
    1377:	e8 9f 28 00 00       	call   3c1b <read>
    137c:	83 c4 10             	add    $0x10,%esp
    137f:	83 f8 05             	cmp    $0x5,%eax
    1382:	74 17                	je     139b <unlinkread+0x13c>
    printf(1, "unlinkread read failed");
    1384:	83 ec 08             	sub    $0x8,%esp
    1387:	68 1b 64 00 00       	push   $0x641b
    138c:	6a 01                	push   $0x1
    138e:	e8 2f 2a 00 00       	call   3dc2 <printf>
    1393:	83 c4 10             	add    $0x10,%esp
    exit();
    1396:	e8 68 28 00 00       	call   3c03 <exit>
  }
  if(buf[0] != 'h'){
    139b:	0f b6 05 20 e4 00 00 	movzbl 0xe420,%eax
    13a2:	3c 68                	cmp    $0x68,%al
    13a4:	74 17                	je     13bd <unlinkread+0x15e>
    printf(1, "unlinkread wrong data\n");
    13a6:	83 ec 08             	sub    $0x8,%esp
    13a9:	68 32 64 00 00       	push   $0x6432
    13ae:	6a 01                	push   $0x1
    13b0:	e8 0d 2a 00 00       	call   3dc2 <printf>
    13b5:	83 c4 10             	add    $0x10,%esp
    exit();
    13b8:	e8 46 28 00 00       	call   3c03 <exit>
  }
  if(write(fd, buf, 10) != 10){
    13bd:	83 ec 04             	sub    $0x4,%esp
    13c0:	6a 0a                	push   $0xa
    13c2:	68 20 e4 00 00       	push   $0xe420
    13c7:	ff 75 f4             	pushl  -0xc(%ebp)
    13ca:	e8 54 28 00 00       	call   3c23 <write>
    13cf:	83 c4 10             	add    $0x10,%esp
    13d2:	83 f8 0a             	cmp    $0xa,%eax
    13d5:	74 17                	je     13ee <unlinkread+0x18f>
    printf(1, "unlinkread write failed\n");
    13d7:	83 ec 08             	sub    $0x8,%esp
    13da:	68 49 64 00 00       	push   $0x6449
    13df:	6a 01                	push   $0x1
    13e1:	e8 dc 29 00 00       	call   3dc2 <printf>
    13e6:	83 c4 10             	add    $0x10,%esp
    exit();
    13e9:	e8 15 28 00 00       	call   3c03 <exit>
  }
  close(fd);
    13ee:	83 ec 0c             	sub    $0xc,%esp
    13f1:	ff 75 f4             	pushl  -0xc(%ebp)
    13f4:	e8 32 28 00 00       	call   3c2b <close>
    13f9:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    13fc:	83 ec 0c             	sub    $0xc,%esp
    13ff:	68 ba 63 00 00       	push   $0x63ba
    1404:	e8 4a 28 00 00       	call   3c53 <unlink>
    1409:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    140c:	83 ec 08             	sub    $0x8,%esp
    140f:	68 62 64 00 00       	push   $0x6462
    1414:	6a 01                	push   $0x1
    1416:	e8 a7 29 00 00       	call   3dc2 <printf>
    141b:	83 c4 10             	add    $0x10,%esp
}
    141e:	90                   	nop
    141f:	c9                   	leave  
    1420:	c3                   	ret    

00001421 <linktest>:

void
linktest(void)
{
    1421:	55                   	push   %ebp
    1422:	89 e5                	mov    %esp,%ebp
    1424:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    1427:	83 ec 08             	sub    $0x8,%esp
    142a:	68 71 64 00 00       	push   $0x6471
    142f:	6a 01                	push   $0x1
    1431:	e8 8c 29 00 00       	call   3dc2 <printf>
    1436:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    1439:	83 ec 0c             	sub    $0xc,%esp
    143c:	68 7b 64 00 00       	push   $0x647b
    1441:	e8 0d 28 00 00       	call   3c53 <unlink>
    1446:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    1449:	83 ec 0c             	sub    $0xc,%esp
    144c:	68 7f 64 00 00       	push   $0x647f
    1451:	e8 fd 27 00 00       	call   3c53 <unlink>
    1456:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    1459:	83 ec 08             	sub    $0x8,%esp
    145c:	68 02 02 00 00       	push   $0x202
    1461:	68 7b 64 00 00       	push   $0x647b
    1466:	e8 d8 27 00 00       	call   3c43 <open>
    146b:	83 c4 10             	add    $0x10,%esp
    146e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1471:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1475:	79 17                	jns    148e <linktest+0x6d>
    printf(1, "create lf1 failed\n");
    1477:	83 ec 08             	sub    $0x8,%esp
    147a:	68 83 64 00 00       	push   $0x6483
    147f:	6a 01                	push   $0x1
    1481:	e8 3c 29 00 00       	call   3dc2 <printf>
    1486:	83 c4 10             	add    $0x10,%esp
    exit();
    1489:	e8 75 27 00 00       	call   3c03 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    148e:	83 ec 04             	sub    $0x4,%esp
    1491:	6a 05                	push   $0x5
    1493:	68 df 63 00 00       	push   $0x63df
    1498:	ff 75 f4             	pushl  -0xc(%ebp)
    149b:	e8 83 27 00 00       	call   3c23 <write>
    14a0:	83 c4 10             	add    $0x10,%esp
    14a3:	83 f8 05             	cmp    $0x5,%eax
    14a6:	74 17                	je     14bf <linktest+0x9e>
    printf(1, "write lf1 failed\n");
    14a8:	83 ec 08             	sub    $0x8,%esp
    14ab:	68 96 64 00 00       	push   $0x6496
    14b0:	6a 01                	push   $0x1
    14b2:	e8 0b 29 00 00       	call   3dc2 <printf>
    14b7:	83 c4 10             	add    $0x10,%esp
    exit();
    14ba:	e8 44 27 00 00       	call   3c03 <exit>
  }
  close(fd);
    14bf:	83 ec 0c             	sub    $0xc,%esp
    14c2:	ff 75 f4             	pushl  -0xc(%ebp)
    14c5:	e8 61 27 00 00       	call   3c2b <close>
    14ca:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    14cd:	83 ec 08             	sub    $0x8,%esp
    14d0:	68 7f 64 00 00       	push   $0x647f
    14d5:	68 7b 64 00 00       	push   $0x647b
    14da:	e8 84 27 00 00       	call   3c63 <link>
    14df:	83 c4 10             	add    $0x10,%esp
    14e2:	85 c0                	test   %eax,%eax
    14e4:	79 17                	jns    14fd <linktest+0xdc>
    printf(1, "link lf1 lf2 failed\n");
    14e6:	83 ec 08             	sub    $0x8,%esp
    14e9:	68 a8 64 00 00       	push   $0x64a8
    14ee:	6a 01                	push   $0x1
    14f0:	e8 cd 28 00 00       	call   3dc2 <printf>
    14f5:	83 c4 10             	add    $0x10,%esp
    exit();
    14f8:	e8 06 27 00 00       	call   3c03 <exit>
  }
  unlink("lf1");
    14fd:	83 ec 0c             	sub    $0xc,%esp
    1500:	68 7b 64 00 00       	push   $0x647b
    1505:	e8 49 27 00 00       	call   3c53 <unlink>
    150a:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    150d:	83 ec 08             	sub    $0x8,%esp
    1510:	6a 00                	push   $0x0
    1512:	68 7b 64 00 00       	push   $0x647b
    1517:	e8 27 27 00 00       	call   3c43 <open>
    151c:	83 c4 10             	add    $0x10,%esp
    151f:	85 c0                	test   %eax,%eax
    1521:	78 17                	js     153a <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    1523:	83 ec 08             	sub    $0x8,%esp
    1526:	68 c0 64 00 00       	push   $0x64c0
    152b:	6a 01                	push   $0x1
    152d:	e8 90 28 00 00       	call   3dc2 <printf>
    1532:	83 c4 10             	add    $0x10,%esp
    exit();
    1535:	e8 c9 26 00 00       	call   3c03 <exit>
  }

  fd = open("lf2", 0);
    153a:	83 ec 08             	sub    $0x8,%esp
    153d:	6a 00                	push   $0x0
    153f:	68 7f 64 00 00       	push   $0x647f
    1544:	e8 fa 26 00 00       	call   3c43 <open>
    1549:	83 c4 10             	add    $0x10,%esp
    154c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    154f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1553:	79 17                	jns    156c <linktest+0x14b>
    printf(1, "open lf2 failed\n");
    1555:	83 ec 08             	sub    $0x8,%esp
    1558:	68 e5 64 00 00       	push   $0x64e5
    155d:	6a 01                	push   $0x1
    155f:	e8 5e 28 00 00       	call   3dc2 <printf>
    1564:	83 c4 10             	add    $0x10,%esp
    exit();
    1567:	e8 97 26 00 00       	call   3c03 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    156c:	83 ec 04             	sub    $0x4,%esp
    156f:	68 00 20 00 00       	push   $0x2000
    1574:	68 20 e4 00 00       	push   $0xe420
    1579:	ff 75 f4             	pushl  -0xc(%ebp)
    157c:	e8 9a 26 00 00       	call   3c1b <read>
    1581:	83 c4 10             	add    $0x10,%esp
    1584:	83 f8 05             	cmp    $0x5,%eax
    1587:	74 17                	je     15a0 <linktest+0x17f>
    printf(1, "read lf2 failed\n");
    1589:	83 ec 08             	sub    $0x8,%esp
    158c:	68 f6 64 00 00       	push   $0x64f6
    1591:	6a 01                	push   $0x1
    1593:	e8 2a 28 00 00       	call   3dc2 <printf>
    1598:	83 c4 10             	add    $0x10,%esp
    exit();
    159b:	e8 63 26 00 00       	call   3c03 <exit>
  }
  close(fd);
    15a0:	83 ec 0c             	sub    $0xc,%esp
    15a3:	ff 75 f4             	pushl  -0xc(%ebp)
    15a6:	e8 80 26 00 00       	call   3c2b <close>
    15ab:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    15ae:	83 ec 08             	sub    $0x8,%esp
    15b1:	68 7f 64 00 00       	push   $0x647f
    15b6:	68 7f 64 00 00       	push   $0x647f
    15bb:	e8 a3 26 00 00       	call   3c63 <link>
    15c0:	83 c4 10             	add    $0x10,%esp
    15c3:	85 c0                	test   %eax,%eax
    15c5:	78 17                	js     15de <linktest+0x1bd>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15c7:	83 ec 08             	sub    $0x8,%esp
    15ca:	68 07 65 00 00       	push   $0x6507
    15cf:	6a 01                	push   $0x1
    15d1:	e8 ec 27 00 00       	call   3dc2 <printf>
    15d6:	83 c4 10             	add    $0x10,%esp
    exit();
    15d9:	e8 25 26 00 00       	call   3c03 <exit>
  }

  unlink("lf2");
    15de:	83 ec 0c             	sub    $0xc,%esp
    15e1:	68 7f 64 00 00       	push   $0x647f
    15e6:	e8 68 26 00 00       	call   3c53 <unlink>
    15eb:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    15ee:	83 ec 08             	sub    $0x8,%esp
    15f1:	68 7b 64 00 00       	push   $0x647b
    15f6:	68 7f 64 00 00       	push   $0x647f
    15fb:	e8 63 26 00 00       	call   3c63 <link>
    1600:	83 c4 10             	add    $0x10,%esp
    1603:	85 c0                	test   %eax,%eax
    1605:	78 17                	js     161e <linktest+0x1fd>
    printf(1, "link non-existant succeeded! oops\n");
    1607:	83 ec 08             	sub    $0x8,%esp
    160a:	68 28 65 00 00       	push   $0x6528
    160f:	6a 01                	push   $0x1
    1611:	e8 ac 27 00 00       	call   3dc2 <printf>
    1616:	83 c4 10             	add    $0x10,%esp
    exit();
    1619:	e8 e5 25 00 00       	call   3c03 <exit>
  }

  if(link(".", "lf1") >= 0){
    161e:	83 ec 08             	sub    $0x8,%esp
    1621:	68 7b 64 00 00       	push   $0x647b
    1626:	68 4b 65 00 00       	push   $0x654b
    162b:	e8 33 26 00 00       	call   3c63 <link>
    1630:	83 c4 10             	add    $0x10,%esp
    1633:	85 c0                	test   %eax,%eax
    1635:	78 17                	js     164e <linktest+0x22d>
    printf(1, "link . lf1 succeeded! oops\n");
    1637:	83 ec 08             	sub    $0x8,%esp
    163a:	68 4d 65 00 00       	push   $0x654d
    163f:	6a 01                	push   $0x1
    1641:	e8 7c 27 00 00       	call   3dc2 <printf>
    1646:	83 c4 10             	add    $0x10,%esp
    exit();
    1649:	e8 b5 25 00 00       	call   3c03 <exit>
  }

  printf(1, "linktest ok\n");
    164e:	83 ec 08             	sub    $0x8,%esp
    1651:	68 69 65 00 00       	push   $0x6569
    1656:	6a 01                	push   $0x1
    1658:	e8 65 27 00 00       	call   3dc2 <printf>
    165d:	83 c4 10             	add    $0x10,%esp
}
    1660:	90                   	nop
    1661:	c9                   	leave  
    1662:	c3                   	ret    

00001663 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1663:	55                   	push   %ebp
    1664:	89 e5                	mov    %esp,%ebp
    1666:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1669:	83 ec 08             	sub    $0x8,%esp
    166c:	68 76 65 00 00       	push   $0x6576
    1671:	6a 01                	push   $0x1
    1673:	e8 4a 27 00 00       	call   3dc2 <printf>
    1678:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    167b:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    167f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1683:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    168a:	e9 fc 00 00 00       	jmp    178b <concreate+0x128>
    file[1] = '0' + i;
    168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1692:	83 c0 30             	add    $0x30,%eax
    1695:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    1698:	83 ec 0c             	sub    $0xc,%esp
    169b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    169e:	50                   	push   %eax
    169f:	e8 af 25 00 00       	call   3c53 <unlink>
    16a4:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    16a7:	e8 4f 25 00 00       	call   3bfb <fork>
    16ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid && (i % 3) == 1){
    16af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16b3:	74 3b                	je     16f0 <concreate+0x8d>
    16b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16b8:	ba 56 55 55 55       	mov    $0x55555556,%edx
    16bd:	89 c8                	mov    %ecx,%eax
    16bf:	f7 ea                	imul   %edx
    16c1:	89 c8                	mov    %ecx,%eax
    16c3:	c1 f8 1f             	sar    $0x1f,%eax
    16c6:	29 c2                	sub    %eax,%edx
    16c8:	89 d0                	mov    %edx,%eax
    16ca:	01 c0                	add    %eax,%eax
    16cc:	01 d0                	add    %edx,%eax
    16ce:	29 c1                	sub    %eax,%ecx
    16d0:	89 ca                	mov    %ecx,%edx
    16d2:	83 fa 01             	cmp    $0x1,%edx
    16d5:	75 19                	jne    16f0 <concreate+0x8d>
      link("C0", file);
    16d7:	83 ec 08             	sub    $0x8,%esp
    16da:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16dd:	50                   	push   %eax
    16de:	68 86 65 00 00       	push   $0x6586
    16e3:	e8 7b 25 00 00       	call   3c63 <link>
    16e8:	83 c4 10             	add    $0x10,%esp
    16eb:	e9 87 00 00 00       	jmp    1777 <concreate+0x114>
    } else if(pid == 0 && (i % 5) == 1){
    16f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16f4:	75 3b                	jne    1731 <concreate+0xce>
    16f6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16f9:	ba 67 66 66 66       	mov    $0x66666667,%edx
    16fe:	89 c8                	mov    %ecx,%eax
    1700:	f7 ea                	imul   %edx
    1702:	d1 fa                	sar    %edx
    1704:	89 c8                	mov    %ecx,%eax
    1706:	c1 f8 1f             	sar    $0x1f,%eax
    1709:	29 c2                	sub    %eax,%edx
    170b:	89 d0                	mov    %edx,%eax
    170d:	c1 e0 02             	shl    $0x2,%eax
    1710:	01 d0                	add    %edx,%eax
    1712:	29 c1                	sub    %eax,%ecx
    1714:	89 ca                	mov    %ecx,%edx
    1716:	83 fa 01             	cmp    $0x1,%edx
    1719:	75 16                	jne    1731 <concreate+0xce>
      link("C0", file);
    171b:	83 ec 08             	sub    $0x8,%esp
    171e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1721:	50                   	push   %eax
    1722:	68 86 65 00 00       	push   $0x6586
    1727:	e8 37 25 00 00       	call   3c63 <link>
    172c:	83 c4 10             	add    $0x10,%esp
    172f:	eb 46                	jmp    1777 <concreate+0x114>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1731:	83 ec 08             	sub    $0x8,%esp
    1734:	68 02 02 00 00       	push   $0x202
    1739:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    173c:	50                   	push   %eax
    173d:	e8 01 25 00 00       	call   3c43 <open>
    1742:	83 c4 10             	add    $0x10,%esp
    1745:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(fd < 0){
    1748:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    174c:	79 1b                	jns    1769 <concreate+0x106>
        printf(1, "concreate create %s failed\n", file);
    174e:	83 ec 04             	sub    $0x4,%esp
    1751:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1754:	50                   	push   %eax
    1755:	68 89 65 00 00       	push   $0x6589
    175a:	6a 01                	push   $0x1
    175c:	e8 61 26 00 00       	call   3dc2 <printf>
    1761:	83 c4 10             	add    $0x10,%esp
        exit();
    1764:	e8 9a 24 00 00       	call   3c03 <exit>
      }
      close(fd);
    1769:	83 ec 0c             	sub    $0xc,%esp
    176c:	ff 75 e8             	pushl  -0x18(%ebp)
    176f:	e8 b7 24 00 00       	call   3c2b <close>
    1774:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1777:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    177b:	75 05                	jne    1782 <concreate+0x11f>
      exit();
    177d:	e8 81 24 00 00       	call   3c03 <exit>
    else
      wait();
    1782:	e8 84 24 00 00       	call   3c0b <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1787:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    178b:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    178f:	0f 8e fa fe ff ff    	jle    168f <concreate+0x2c>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1795:	83 ec 04             	sub    $0x4,%esp
    1798:	6a 28                	push   $0x28
    179a:	6a 00                	push   $0x0
    179c:	8d 45 bd             	lea    -0x43(%ebp),%eax
    179f:	50                   	push   %eax
    17a0:	e8 c3 22 00 00       	call   3a68 <memset>
    17a5:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    17a8:	83 ec 08             	sub    $0x8,%esp
    17ab:	6a 00                	push   $0x0
    17ad:	68 4b 65 00 00       	push   $0x654b
    17b2:	e8 8c 24 00 00       	call   3c43 <open>
    17b7:	83 c4 10             	add    $0x10,%esp
    17ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
  n = 0;
    17bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    17c4:	e9 93 00 00 00       	jmp    185c <concreate+0x1f9>
    if(de.inum == 0)
    17c9:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    17cd:	66 85 c0             	test   %ax,%ax
    17d0:	75 05                	jne    17d7 <concreate+0x174>
      continue;
    17d2:	e9 85 00 00 00       	jmp    185c <concreate+0x1f9>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    17d7:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    17db:	3c 43                	cmp    $0x43,%al
    17dd:	75 7d                	jne    185c <concreate+0x1f9>
    17df:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    17e3:	84 c0                	test   %al,%al
    17e5:	75 75                	jne    185c <concreate+0x1f9>
      i = de.name[1] - '0';
    17e7:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    17eb:	0f be c0             	movsbl %al,%eax
    17ee:	83 e8 30             	sub    $0x30,%eax
    17f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    17f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17f8:	78 08                	js     1802 <concreate+0x19f>
    17fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fd:	83 f8 27             	cmp    $0x27,%eax
    1800:	76 1e                	jbe    1820 <concreate+0x1bd>
        printf(1, "concreate weird file %s\n", de.name);
    1802:	83 ec 04             	sub    $0x4,%esp
    1805:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1808:	83 c0 02             	add    $0x2,%eax
    180b:	50                   	push   %eax
    180c:	68 a5 65 00 00       	push   $0x65a5
    1811:	6a 01                	push   $0x1
    1813:	e8 aa 25 00 00       	call   3dc2 <printf>
    1818:	83 c4 10             	add    $0x10,%esp
        exit();
    181b:	e8 e3 23 00 00       	call   3c03 <exit>
      }
      if(fa[i]){
    1820:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1823:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1826:	01 d0                	add    %edx,%eax
    1828:	0f b6 00             	movzbl (%eax),%eax
    182b:	84 c0                	test   %al,%al
    182d:	74 1e                	je     184d <concreate+0x1ea>
        printf(1, "concreate duplicate file %s\n", de.name);
    182f:	83 ec 04             	sub    $0x4,%esp
    1832:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1835:	83 c0 02             	add    $0x2,%eax
    1838:	50                   	push   %eax
    1839:	68 be 65 00 00       	push   $0x65be
    183e:	6a 01                	push   $0x1
    1840:	e8 7d 25 00 00       	call   3dc2 <printf>
    1845:	83 c4 10             	add    $0x10,%esp
        exit();
    1848:	e8 b6 23 00 00       	call   3c03 <exit>
      }
      fa[i] = 1;
    184d:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1850:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1853:	01 d0                	add    %edx,%eax
    1855:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1858:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    185c:	83 ec 04             	sub    $0x4,%esp
    185f:	6a 10                	push   $0x10
    1861:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1864:	50                   	push   %eax
    1865:	ff 75 e8             	pushl  -0x18(%ebp)
    1868:	e8 ae 23 00 00       	call   3c1b <read>
    186d:	83 c4 10             	add    $0x10,%esp
    1870:	85 c0                	test   %eax,%eax
    1872:	0f 8f 51 ff ff ff    	jg     17c9 <concreate+0x166>
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    1878:	83 ec 0c             	sub    $0xc,%esp
    187b:	ff 75 e8             	pushl  -0x18(%ebp)
    187e:	e8 a8 23 00 00       	call   3c2b <close>
    1883:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1886:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    188a:	74 17                	je     18a3 <concreate+0x240>
    printf(1, "concreate not enough files in directory listing\n");
    188c:	83 ec 08             	sub    $0x8,%esp
    188f:	68 dc 65 00 00       	push   $0x65dc
    1894:	6a 01                	push   $0x1
    1896:	e8 27 25 00 00       	call   3dc2 <printf>
    189b:	83 c4 10             	add    $0x10,%esp
    exit();
    189e:	e8 60 23 00 00       	call   3c03 <exit>
  }

  for(i = 0; i < 40; i++){
    18a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    18aa:	e9 45 01 00 00       	jmp    19f4 <concreate+0x391>
    file[1] = '0' + i;
    18af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b2:	83 c0 30             	add    $0x30,%eax
    18b5:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    18b8:	e8 3e 23 00 00       	call   3bfb <fork>
    18bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    18c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18c4:	79 17                	jns    18dd <concreate+0x27a>
      printf(1, "fork failed\n");
    18c6:	83 ec 08             	sub    $0x8,%esp
    18c9:	68 c9 61 00 00       	push   $0x61c9
    18ce:	6a 01                	push   $0x1
    18d0:	e8 ed 24 00 00       	call   3dc2 <printf>
    18d5:	83 c4 10             	add    $0x10,%esp
      exit();
    18d8:	e8 26 23 00 00       	call   3c03 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    18dd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    18e0:	ba 56 55 55 55       	mov    $0x55555556,%edx
    18e5:	89 c8                	mov    %ecx,%eax
    18e7:	f7 ea                	imul   %edx
    18e9:	89 c8                	mov    %ecx,%eax
    18eb:	c1 f8 1f             	sar    $0x1f,%eax
    18ee:	29 c2                	sub    %eax,%edx
    18f0:	89 d0                	mov    %edx,%eax
    18f2:	89 c2                	mov    %eax,%edx
    18f4:	01 d2                	add    %edx,%edx
    18f6:	01 c2                	add    %eax,%edx
    18f8:	89 c8                	mov    %ecx,%eax
    18fa:	29 d0                	sub    %edx,%eax
    18fc:	85 c0                	test   %eax,%eax
    18fe:	75 06                	jne    1906 <concreate+0x2a3>
    1900:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1904:	74 28                	je     192e <concreate+0x2cb>
       ((i % 3) == 1 && pid != 0)){
    1906:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1909:	ba 56 55 55 55       	mov    $0x55555556,%edx
    190e:	89 c8                	mov    %ecx,%eax
    1910:	f7 ea                	imul   %edx
    1912:	89 c8                	mov    %ecx,%eax
    1914:	c1 f8 1f             	sar    $0x1f,%eax
    1917:	29 c2                	sub    %eax,%edx
    1919:	89 d0                	mov    %edx,%eax
    191b:	01 c0                	add    %eax,%eax
    191d:	01 d0                	add    %edx,%eax
    191f:	29 c1                	sub    %eax,%ecx
    1921:	89 ca                	mov    %ecx,%edx
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1923:	83 fa 01             	cmp    $0x1,%edx
    1926:	75 7c                	jne    19a4 <concreate+0x341>
       ((i % 3) == 1 && pid != 0)){
    1928:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    192c:	74 76                	je     19a4 <concreate+0x341>
      close(open(file, 0));
    192e:	83 ec 08             	sub    $0x8,%esp
    1931:	6a 00                	push   $0x0
    1933:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1936:	50                   	push   %eax
    1937:	e8 07 23 00 00       	call   3c43 <open>
    193c:	83 c4 10             	add    $0x10,%esp
    193f:	83 ec 0c             	sub    $0xc,%esp
    1942:	50                   	push   %eax
    1943:	e8 e3 22 00 00       	call   3c2b <close>
    1948:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    194b:	83 ec 08             	sub    $0x8,%esp
    194e:	6a 00                	push   $0x0
    1950:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1953:	50                   	push   %eax
    1954:	e8 ea 22 00 00       	call   3c43 <open>
    1959:	83 c4 10             	add    $0x10,%esp
    195c:	83 ec 0c             	sub    $0xc,%esp
    195f:	50                   	push   %eax
    1960:	e8 c6 22 00 00       	call   3c2b <close>
    1965:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1968:	83 ec 08             	sub    $0x8,%esp
    196b:	6a 00                	push   $0x0
    196d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1970:	50                   	push   %eax
    1971:	e8 cd 22 00 00       	call   3c43 <open>
    1976:	83 c4 10             	add    $0x10,%esp
    1979:	83 ec 0c             	sub    $0xc,%esp
    197c:	50                   	push   %eax
    197d:	e8 a9 22 00 00       	call   3c2b <close>
    1982:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1985:	83 ec 08             	sub    $0x8,%esp
    1988:	6a 00                	push   $0x0
    198a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    198d:	50                   	push   %eax
    198e:	e8 b0 22 00 00       	call   3c43 <open>
    1993:	83 c4 10             	add    $0x10,%esp
    1996:	83 ec 0c             	sub    $0xc,%esp
    1999:	50                   	push   %eax
    199a:	e8 8c 22 00 00       	call   3c2b <close>
    199f:	83 c4 10             	add    $0x10,%esp
    19a2:	eb 3c                	jmp    19e0 <concreate+0x37d>
    } else {
      unlink(file);
    19a4:	83 ec 0c             	sub    $0xc,%esp
    19a7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19aa:	50                   	push   %eax
    19ab:	e8 a3 22 00 00       	call   3c53 <unlink>
    19b0:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19b3:	83 ec 0c             	sub    $0xc,%esp
    19b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19b9:	50                   	push   %eax
    19ba:	e8 94 22 00 00       	call   3c53 <unlink>
    19bf:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19c2:	83 ec 0c             	sub    $0xc,%esp
    19c5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19c8:	50                   	push   %eax
    19c9:	e8 85 22 00 00       	call   3c53 <unlink>
    19ce:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19d1:	83 ec 0c             	sub    $0xc,%esp
    19d4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19d7:	50                   	push   %eax
    19d8:	e8 76 22 00 00       	call   3c53 <unlink>
    19dd:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    19e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19e4:	75 05                	jne    19eb <concreate+0x388>
      exit();
    19e6:	e8 18 22 00 00       	call   3c03 <exit>
    else
      wait();
    19eb:	e8 1b 22 00 00       	call   3c0b <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    19f0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19f4:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    19f8:	0f 8e b1 fe ff ff    	jle    18af <concreate+0x24c>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    19fe:	83 ec 08             	sub    $0x8,%esp
    1a01:	68 0d 66 00 00       	push   $0x660d
    1a06:	6a 01                	push   $0x1
    1a08:	e8 b5 23 00 00       	call   3dc2 <printf>
    1a0d:	83 c4 10             	add    $0x10,%esp
}
    1a10:	90                   	nop
    1a11:	c9                   	leave  
    1a12:	c3                   	ret    

00001a13 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1a13:	55                   	push   %ebp
    1a14:	89 e5                	mov    %esp,%ebp
    1a16:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1a19:	83 ec 08             	sub    $0x8,%esp
    1a1c:	68 1b 66 00 00       	push   $0x661b
    1a21:	6a 01                	push   $0x1
    1a23:	e8 9a 23 00 00       	call   3dc2 <printf>
    1a28:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1a2b:	83 ec 0c             	sub    $0xc,%esp
    1a2e:	68 82 61 00 00       	push   $0x6182
    1a33:	e8 1b 22 00 00       	call   3c53 <unlink>
    1a38:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1a3b:	e8 bb 21 00 00       	call   3bfb <fork>
    1a40:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1a43:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a47:	79 17                	jns    1a60 <linkunlink+0x4d>
    printf(1, "fork failed\n");
    1a49:	83 ec 08             	sub    $0x8,%esp
    1a4c:	68 c9 61 00 00       	push   $0x61c9
    1a51:	6a 01                	push   $0x1
    1a53:	e8 6a 23 00 00       	call   3dc2 <printf>
    1a58:	83 c4 10             	add    $0x10,%esp
    exit();
    1a5b:	e8 a3 21 00 00       	call   3c03 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1a60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a64:	74 07                	je     1a6d <linkunlink+0x5a>
    1a66:	b8 01 00 00 00       	mov    $0x1,%eax
    1a6b:	eb 05                	jmp    1a72 <linkunlink+0x5f>
    1a6d:	b8 61 00 00 00       	mov    $0x61,%eax
    1a72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1a75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a7c:	e9 9a 00 00 00       	jmp    1b1b <linkunlink+0x108>
    x = x * 1103515245 + 12345;
    1a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a84:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1a8a:	05 39 30 00 00       	add    $0x3039,%eax
    1a8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1a92:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1a95:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1a9a:	89 c8                	mov    %ecx,%eax
    1a9c:	f7 e2                	mul    %edx
    1a9e:	89 d0                	mov    %edx,%eax
    1aa0:	d1 e8                	shr    %eax
    1aa2:	89 c2                	mov    %eax,%edx
    1aa4:	01 d2                	add    %edx,%edx
    1aa6:	01 c2                	add    %eax,%edx
    1aa8:	89 c8                	mov    %ecx,%eax
    1aaa:	29 d0                	sub    %edx,%eax
    1aac:	85 c0                	test   %eax,%eax
    1aae:	75 23                	jne    1ad3 <linkunlink+0xc0>
      close(open("x", O_RDWR | O_CREATE));
    1ab0:	83 ec 08             	sub    $0x8,%esp
    1ab3:	68 02 02 00 00       	push   $0x202
    1ab8:	68 82 61 00 00       	push   $0x6182
    1abd:	e8 81 21 00 00       	call   3c43 <open>
    1ac2:	83 c4 10             	add    $0x10,%esp
    1ac5:	83 ec 0c             	sub    $0xc,%esp
    1ac8:	50                   	push   %eax
    1ac9:	e8 5d 21 00 00       	call   3c2b <close>
    1ace:	83 c4 10             	add    $0x10,%esp
    1ad1:	eb 44                	jmp    1b17 <linkunlink+0x104>
    } else if((x % 3) == 1){
    1ad3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1ad6:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1adb:	89 c8                	mov    %ecx,%eax
    1add:	f7 e2                	mul    %edx
    1adf:	d1 ea                	shr    %edx
    1ae1:	89 d0                	mov    %edx,%eax
    1ae3:	01 c0                	add    %eax,%eax
    1ae5:	01 d0                	add    %edx,%eax
    1ae7:	29 c1                	sub    %eax,%ecx
    1ae9:	89 ca                	mov    %ecx,%edx
    1aeb:	83 fa 01             	cmp    $0x1,%edx
    1aee:	75 17                	jne    1b07 <linkunlink+0xf4>
      link("cat", "x");
    1af0:	83 ec 08             	sub    $0x8,%esp
    1af3:	68 82 61 00 00       	push   $0x6182
    1af8:	68 2c 66 00 00       	push   $0x662c
    1afd:	e8 61 21 00 00       	call   3c63 <link>
    1b02:	83 c4 10             	add    $0x10,%esp
    1b05:	eb 10                	jmp    1b17 <linkunlink+0x104>
    } else {
      unlink("x");
    1b07:	83 ec 0c             	sub    $0xc,%esp
    1b0a:	68 82 61 00 00       	push   $0x6182
    1b0f:	e8 3f 21 00 00       	call   3c53 <unlink>
    1b14:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1b17:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b1b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1b1f:	0f 8e 5c ff ff ff    	jle    1a81 <linkunlink+0x6e>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1b25:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b29:	74 07                	je     1b32 <linkunlink+0x11f>
    wait();
    1b2b:	e8 db 20 00 00       	call   3c0b <wait>
    1b30:	eb 05                	jmp    1b37 <linkunlink+0x124>
  else 
    exit();
    1b32:	e8 cc 20 00 00       	call   3c03 <exit>

  printf(1, "linkunlink ok\n");
    1b37:	83 ec 08             	sub    $0x8,%esp
    1b3a:	68 30 66 00 00       	push   $0x6630
    1b3f:	6a 01                	push   $0x1
    1b41:	e8 7c 22 00 00       	call   3dc2 <printf>
    1b46:	83 c4 10             	add    $0x10,%esp
}
    1b49:	90                   	nop
    1b4a:	c9                   	leave  
    1b4b:	c3                   	ret    

00001b4c <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1b4c:	55                   	push   %ebp
    1b4d:	89 e5                	mov    %esp,%ebp
    1b4f:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1b52:	83 ec 08             	sub    $0x8,%esp
    1b55:	68 3f 66 00 00       	push   $0x663f
    1b5a:	6a 01                	push   $0x1
    1b5c:	e8 61 22 00 00       	call   3dc2 <printf>
    1b61:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1b64:	83 ec 0c             	sub    $0xc,%esp
    1b67:	68 4c 66 00 00       	push   $0x664c
    1b6c:	e8 e2 20 00 00       	call   3c53 <unlink>
    1b71:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1b74:	83 ec 08             	sub    $0x8,%esp
    1b77:	68 00 02 00 00       	push   $0x200
    1b7c:	68 4c 66 00 00       	push   $0x664c
    1b81:	e8 bd 20 00 00       	call   3c43 <open>
    1b86:	83 c4 10             	add    $0x10,%esp
    1b89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1b8c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b90:	79 17                	jns    1ba9 <bigdir+0x5d>
    printf(1, "bigdir create failed\n");
    1b92:	83 ec 08             	sub    $0x8,%esp
    1b95:	68 4f 66 00 00       	push   $0x664f
    1b9a:	6a 01                	push   $0x1
    1b9c:	e8 21 22 00 00       	call   3dc2 <printf>
    1ba1:	83 c4 10             	add    $0x10,%esp
    exit();
    1ba4:	e8 5a 20 00 00       	call   3c03 <exit>
  }
  close(fd);
    1ba9:	83 ec 0c             	sub    $0xc,%esp
    1bac:	ff 75 f0             	pushl  -0x10(%ebp)
    1baf:	e8 77 20 00 00       	call   3c2b <close>
    1bb4:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1bb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bbe:	eb 63                	jmp    1c23 <bigdir+0xd7>
    name[0] = 'x';
    1bc0:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1bc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc7:	8d 50 3f             	lea    0x3f(%eax),%edx
    1bca:	85 c0                	test   %eax,%eax
    1bcc:	0f 48 c2             	cmovs  %edx,%eax
    1bcf:	c1 f8 06             	sar    $0x6,%eax
    1bd2:	83 c0 30             	add    $0x30,%eax
    1bd5:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bdb:	99                   	cltd   
    1bdc:	c1 ea 1a             	shr    $0x1a,%edx
    1bdf:	01 d0                	add    %edx,%eax
    1be1:	83 e0 3f             	and    $0x3f,%eax
    1be4:	29 d0                	sub    %edx,%eax
    1be6:	83 c0 30             	add    $0x30,%eax
    1be9:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1bec:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1bf0:	83 ec 08             	sub    $0x8,%esp
    1bf3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1bf6:	50                   	push   %eax
    1bf7:	68 4c 66 00 00       	push   $0x664c
    1bfc:	e8 62 20 00 00       	call   3c63 <link>
    1c01:	83 c4 10             	add    $0x10,%esp
    1c04:	85 c0                	test   %eax,%eax
    1c06:	74 17                	je     1c1f <bigdir+0xd3>
      printf(1, "bigdir link failed\n");
    1c08:	83 ec 08             	sub    $0x8,%esp
    1c0b:	68 65 66 00 00       	push   $0x6665
    1c10:	6a 01                	push   $0x1
    1c12:	e8 ab 21 00 00       	call   3dc2 <printf>
    1c17:	83 c4 10             	add    $0x10,%esp
      exit();
    1c1a:	e8 e4 1f 00 00       	call   3c03 <exit>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1c1f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c23:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c2a:	7e 94                	jle    1bc0 <bigdir+0x74>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1c2c:	83 ec 0c             	sub    $0xc,%esp
    1c2f:	68 4c 66 00 00       	push   $0x664c
    1c34:	e8 1a 20 00 00       	call   3c53 <unlink>
    1c39:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1c3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c43:	eb 5e                	jmp    1ca3 <bigdir+0x157>
    name[0] = 'x';
    1c45:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1c49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c4c:	8d 50 3f             	lea    0x3f(%eax),%edx
    1c4f:	85 c0                	test   %eax,%eax
    1c51:	0f 48 c2             	cmovs  %edx,%eax
    1c54:	c1 f8 06             	sar    $0x6,%eax
    1c57:	83 c0 30             	add    $0x30,%eax
    1c5a:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c60:	99                   	cltd   
    1c61:	c1 ea 1a             	shr    $0x1a,%edx
    1c64:	01 d0                	add    %edx,%eax
    1c66:	83 e0 3f             	and    $0x3f,%eax
    1c69:	29 d0                	sub    %edx,%eax
    1c6b:	83 c0 30             	add    $0x30,%eax
    1c6e:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1c71:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1c75:	83 ec 0c             	sub    $0xc,%esp
    1c78:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c7b:	50                   	push   %eax
    1c7c:	e8 d2 1f 00 00       	call   3c53 <unlink>
    1c81:	83 c4 10             	add    $0x10,%esp
    1c84:	85 c0                	test   %eax,%eax
    1c86:	74 17                	je     1c9f <bigdir+0x153>
      printf(1, "bigdir unlink failed");
    1c88:	83 ec 08             	sub    $0x8,%esp
    1c8b:	68 79 66 00 00       	push   $0x6679
    1c90:	6a 01                	push   $0x1
    1c92:	e8 2b 21 00 00       	call   3dc2 <printf>
    1c97:	83 c4 10             	add    $0x10,%esp
      exit();
    1c9a:	e8 64 1f 00 00       	call   3c03 <exit>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1c9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ca3:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1caa:	7e 99                	jle    1c45 <bigdir+0xf9>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1cac:	83 ec 08             	sub    $0x8,%esp
    1caf:	68 8e 66 00 00       	push   $0x668e
    1cb4:	6a 01                	push   $0x1
    1cb6:	e8 07 21 00 00       	call   3dc2 <printf>
    1cbb:	83 c4 10             	add    $0x10,%esp
}
    1cbe:	90                   	nop
    1cbf:	c9                   	leave  
    1cc0:	c3                   	ret    

00001cc1 <subdir>:

void
subdir(void)
{
    1cc1:	55                   	push   %ebp
    1cc2:	89 e5                	mov    %esp,%ebp
    1cc4:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1cc7:	83 ec 08             	sub    $0x8,%esp
    1cca:	68 99 66 00 00       	push   $0x6699
    1ccf:	6a 01                	push   $0x1
    1cd1:	e8 ec 20 00 00       	call   3dc2 <printf>
    1cd6:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    1cd9:	83 ec 0c             	sub    $0xc,%esp
    1cdc:	68 a6 66 00 00       	push   $0x66a6
    1ce1:	e8 6d 1f 00 00       	call   3c53 <unlink>
    1ce6:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    1ce9:	83 ec 0c             	sub    $0xc,%esp
    1cec:	68 a9 66 00 00       	push   $0x66a9
    1cf1:	e8 75 1f 00 00       	call   3c6b <mkdir>
    1cf6:	83 c4 10             	add    $0x10,%esp
    1cf9:	85 c0                	test   %eax,%eax
    1cfb:	74 17                	je     1d14 <subdir+0x53>
    printf(1, "subdir mkdir dd failed\n");
    1cfd:	83 ec 08             	sub    $0x8,%esp
    1d00:	68 ac 66 00 00       	push   $0x66ac
    1d05:	6a 01                	push   $0x1
    1d07:	e8 b6 20 00 00       	call   3dc2 <printf>
    1d0c:	83 c4 10             	add    $0x10,%esp
    exit();
    1d0f:	e8 ef 1e 00 00       	call   3c03 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d14:	83 ec 08             	sub    $0x8,%esp
    1d17:	68 02 02 00 00       	push   $0x202
    1d1c:	68 c4 66 00 00       	push   $0x66c4
    1d21:	e8 1d 1f 00 00       	call   3c43 <open>
    1d26:	83 c4 10             	add    $0x10,%esp
    1d29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1d2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d30:	79 17                	jns    1d49 <subdir+0x88>
    printf(1, "create dd/ff failed\n");
    1d32:	83 ec 08             	sub    $0x8,%esp
    1d35:	68 ca 66 00 00       	push   $0x66ca
    1d3a:	6a 01                	push   $0x1
    1d3c:	e8 81 20 00 00       	call   3dc2 <printf>
    1d41:	83 c4 10             	add    $0x10,%esp
    exit();
    1d44:	e8 ba 1e 00 00       	call   3c03 <exit>
  }
  write(fd, "ff", 2);
    1d49:	83 ec 04             	sub    $0x4,%esp
    1d4c:	6a 02                	push   $0x2
    1d4e:	68 a6 66 00 00       	push   $0x66a6
    1d53:	ff 75 f4             	pushl  -0xc(%ebp)
    1d56:	e8 c8 1e 00 00       	call   3c23 <write>
    1d5b:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1d5e:	83 ec 0c             	sub    $0xc,%esp
    1d61:	ff 75 f4             	pushl  -0xc(%ebp)
    1d64:	e8 c2 1e 00 00       	call   3c2b <close>
    1d69:	83 c4 10             	add    $0x10,%esp
  
  if(unlink("dd") >= 0){
    1d6c:	83 ec 0c             	sub    $0xc,%esp
    1d6f:	68 a9 66 00 00       	push   $0x66a9
    1d74:	e8 da 1e 00 00       	call   3c53 <unlink>
    1d79:	83 c4 10             	add    $0x10,%esp
    1d7c:	85 c0                	test   %eax,%eax
    1d7e:	78 17                	js     1d97 <subdir+0xd6>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1d80:	83 ec 08             	sub    $0x8,%esp
    1d83:	68 e0 66 00 00       	push   $0x66e0
    1d88:	6a 01                	push   $0x1
    1d8a:	e8 33 20 00 00       	call   3dc2 <printf>
    1d8f:	83 c4 10             	add    $0x10,%esp
    exit();
    1d92:	e8 6c 1e 00 00       	call   3c03 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1d97:	83 ec 0c             	sub    $0xc,%esp
    1d9a:	68 06 67 00 00       	push   $0x6706
    1d9f:	e8 c7 1e 00 00       	call   3c6b <mkdir>
    1da4:	83 c4 10             	add    $0x10,%esp
    1da7:	85 c0                	test   %eax,%eax
    1da9:	74 17                	je     1dc2 <subdir+0x101>
    printf(1, "subdir mkdir dd/dd failed\n");
    1dab:	83 ec 08             	sub    $0x8,%esp
    1dae:	68 0d 67 00 00       	push   $0x670d
    1db3:	6a 01                	push   $0x1
    1db5:	e8 08 20 00 00       	call   3dc2 <printf>
    1dba:	83 c4 10             	add    $0x10,%esp
    exit();
    1dbd:	e8 41 1e 00 00       	call   3c03 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dc2:	83 ec 08             	sub    $0x8,%esp
    1dc5:	68 02 02 00 00       	push   $0x202
    1dca:	68 28 67 00 00       	push   $0x6728
    1dcf:	e8 6f 1e 00 00       	call   3c43 <open>
    1dd4:	83 c4 10             	add    $0x10,%esp
    1dd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1dda:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dde:	79 17                	jns    1df7 <subdir+0x136>
    printf(1, "create dd/dd/ff failed\n");
    1de0:	83 ec 08             	sub    $0x8,%esp
    1de3:	68 31 67 00 00       	push   $0x6731
    1de8:	6a 01                	push   $0x1
    1dea:	e8 d3 1f 00 00       	call   3dc2 <printf>
    1def:	83 c4 10             	add    $0x10,%esp
    exit();
    1df2:	e8 0c 1e 00 00       	call   3c03 <exit>
  }
  write(fd, "FF", 2);
    1df7:	83 ec 04             	sub    $0x4,%esp
    1dfa:	6a 02                	push   $0x2
    1dfc:	68 49 67 00 00       	push   $0x6749
    1e01:	ff 75 f4             	pushl  -0xc(%ebp)
    1e04:	e8 1a 1e 00 00       	call   3c23 <write>
    1e09:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1e0c:	83 ec 0c             	sub    $0xc,%esp
    1e0f:	ff 75 f4             	pushl  -0xc(%ebp)
    1e12:	e8 14 1e 00 00       	call   3c2b <close>
    1e17:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    1e1a:	83 ec 08             	sub    $0x8,%esp
    1e1d:	6a 00                	push   $0x0
    1e1f:	68 4c 67 00 00       	push   $0x674c
    1e24:	e8 1a 1e 00 00       	call   3c43 <open>
    1e29:	83 c4 10             	add    $0x10,%esp
    1e2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1e2f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e33:	79 17                	jns    1e4c <subdir+0x18b>
    printf(1, "open dd/dd/../ff failed\n");
    1e35:	83 ec 08             	sub    $0x8,%esp
    1e38:	68 58 67 00 00       	push   $0x6758
    1e3d:	6a 01                	push   $0x1
    1e3f:	e8 7e 1f 00 00       	call   3dc2 <printf>
    1e44:	83 c4 10             	add    $0x10,%esp
    exit();
    1e47:	e8 b7 1d 00 00       	call   3c03 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    1e4c:	83 ec 04             	sub    $0x4,%esp
    1e4f:	68 00 20 00 00       	push   $0x2000
    1e54:	68 20 e4 00 00       	push   $0xe420
    1e59:	ff 75 f4             	pushl  -0xc(%ebp)
    1e5c:	e8 ba 1d 00 00       	call   3c1b <read>
    1e61:	83 c4 10             	add    $0x10,%esp
    1e64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    1e67:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1e6b:	75 0b                	jne    1e78 <subdir+0x1b7>
    1e6d:	0f b6 05 20 e4 00 00 	movzbl 0xe420,%eax
    1e74:	3c 66                	cmp    $0x66,%al
    1e76:	74 17                	je     1e8f <subdir+0x1ce>
    printf(1, "dd/dd/../ff wrong content\n");
    1e78:	83 ec 08             	sub    $0x8,%esp
    1e7b:	68 71 67 00 00       	push   $0x6771
    1e80:	6a 01                	push   $0x1
    1e82:	e8 3b 1f 00 00       	call   3dc2 <printf>
    1e87:	83 c4 10             	add    $0x10,%esp
    exit();
    1e8a:	e8 74 1d 00 00       	call   3c03 <exit>
  }
  close(fd);
    1e8f:	83 ec 0c             	sub    $0xc,%esp
    1e92:	ff 75 f4             	pushl  -0xc(%ebp)
    1e95:	e8 91 1d 00 00       	call   3c2b <close>
    1e9a:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e9d:	83 ec 08             	sub    $0x8,%esp
    1ea0:	68 8c 67 00 00       	push   $0x678c
    1ea5:	68 28 67 00 00       	push   $0x6728
    1eaa:	e8 b4 1d 00 00       	call   3c63 <link>
    1eaf:	83 c4 10             	add    $0x10,%esp
    1eb2:	85 c0                	test   %eax,%eax
    1eb4:	74 17                	je     1ecd <subdir+0x20c>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1eb6:	83 ec 08             	sub    $0x8,%esp
    1eb9:	68 98 67 00 00       	push   $0x6798
    1ebe:	6a 01                	push   $0x1
    1ec0:	e8 fd 1e 00 00       	call   3dc2 <printf>
    1ec5:	83 c4 10             	add    $0x10,%esp
    exit();
    1ec8:	e8 36 1d 00 00       	call   3c03 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    1ecd:	83 ec 0c             	sub    $0xc,%esp
    1ed0:	68 28 67 00 00       	push   $0x6728
    1ed5:	e8 79 1d 00 00       	call   3c53 <unlink>
    1eda:	83 c4 10             	add    $0x10,%esp
    1edd:	85 c0                	test   %eax,%eax
    1edf:	74 17                	je     1ef8 <subdir+0x237>
    printf(1, "unlink dd/dd/ff failed\n");
    1ee1:	83 ec 08             	sub    $0x8,%esp
    1ee4:	68 b9 67 00 00       	push   $0x67b9
    1ee9:	6a 01                	push   $0x1
    1eeb:	e8 d2 1e 00 00       	call   3dc2 <printf>
    1ef0:	83 c4 10             	add    $0x10,%esp
    exit();
    1ef3:	e8 0b 1d 00 00       	call   3c03 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ef8:	83 ec 08             	sub    $0x8,%esp
    1efb:	6a 00                	push   $0x0
    1efd:	68 28 67 00 00       	push   $0x6728
    1f02:	e8 3c 1d 00 00       	call   3c43 <open>
    1f07:	83 c4 10             	add    $0x10,%esp
    1f0a:	85 c0                	test   %eax,%eax
    1f0c:	78 17                	js     1f25 <subdir+0x264>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1f0e:	83 ec 08             	sub    $0x8,%esp
    1f11:	68 d4 67 00 00       	push   $0x67d4
    1f16:	6a 01                	push   $0x1
    1f18:	e8 a5 1e 00 00       	call   3dc2 <printf>
    1f1d:	83 c4 10             	add    $0x10,%esp
    exit();
    1f20:	e8 de 1c 00 00       	call   3c03 <exit>
  }

  if(chdir("dd") != 0){
    1f25:	83 ec 0c             	sub    $0xc,%esp
    1f28:	68 a9 66 00 00       	push   $0x66a9
    1f2d:	e8 41 1d 00 00       	call   3c73 <chdir>
    1f32:	83 c4 10             	add    $0x10,%esp
    1f35:	85 c0                	test   %eax,%eax
    1f37:	74 17                	je     1f50 <subdir+0x28f>
    printf(1, "chdir dd failed\n");
    1f39:	83 ec 08             	sub    $0x8,%esp
    1f3c:	68 f8 67 00 00       	push   $0x67f8
    1f41:	6a 01                	push   $0x1
    1f43:	e8 7a 1e 00 00       	call   3dc2 <printf>
    1f48:	83 c4 10             	add    $0x10,%esp
    exit();
    1f4b:	e8 b3 1c 00 00       	call   3c03 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    1f50:	83 ec 0c             	sub    $0xc,%esp
    1f53:	68 09 68 00 00       	push   $0x6809
    1f58:	e8 16 1d 00 00       	call   3c73 <chdir>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	74 17                	je     1f7b <subdir+0x2ba>
    printf(1, "chdir dd/../../dd failed\n");
    1f64:	83 ec 08             	sub    $0x8,%esp
    1f67:	68 15 68 00 00       	push   $0x6815
    1f6c:	6a 01                	push   $0x1
    1f6e:	e8 4f 1e 00 00       	call   3dc2 <printf>
    1f73:	83 c4 10             	add    $0x10,%esp
    exit();
    1f76:	e8 88 1c 00 00       	call   3c03 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    1f7b:	83 ec 0c             	sub    $0xc,%esp
    1f7e:	68 2f 68 00 00       	push   $0x682f
    1f83:	e8 eb 1c 00 00       	call   3c73 <chdir>
    1f88:	83 c4 10             	add    $0x10,%esp
    1f8b:	85 c0                	test   %eax,%eax
    1f8d:	74 17                	je     1fa6 <subdir+0x2e5>
    printf(1, "chdir dd/../../dd failed\n");
    1f8f:	83 ec 08             	sub    $0x8,%esp
    1f92:	68 15 68 00 00       	push   $0x6815
    1f97:	6a 01                	push   $0x1
    1f99:	e8 24 1e 00 00       	call   3dc2 <printf>
    1f9e:	83 c4 10             	add    $0x10,%esp
    exit();
    1fa1:	e8 5d 1c 00 00       	call   3c03 <exit>
  }
  if(chdir("./..") != 0){
    1fa6:	83 ec 0c             	sub    $0xc,%esp
    1fa9:	68 3e 68 00 00       	push   $0x683e
    1fae:	e8 c0 1c 00 00       	call   3c73 <chdir>
    1fb3:	83 c4 10             	add    $0x10,%esp
    1fb6:	85 c0                	test   %eax,%eax
    1fb8:	74 17                	je     1fd1 <subdir+0x310>
    printf(1, "chdir ./.. failed\n");
    1fba:	83 ec 08             	sub    $0x8,%esp
    1fbd:	68 43 68 00 00       	push   $0x6843
    1fc2:	6a 01                	push   $0x1
    1fc4:	e8 f9 1d 00 00       	call   3dc2 <printf>
    1fc9:	83 c4 10             	add    $0x10,%esp
    exit();
    1fcc:	e8 32 1c 00 00       	call   3c03 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    1fd1:	83 ec 08             	sub    $0x8,%esp
    1fd4:	6a 00                	push   $0x0
    1fd6:	68 8c 67 00 00       	push   $0x678c
    1fdb:	e8 63 1c 00 00       	call   3c43 <open>
    1fe0:	83 c4 10             	add    $0x10,%esp
    1fe3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1fe6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fea:	79 17                	jns    2003 <subdir+0x342>
    printf(1, "open dd/dd/ffff failed\n");
    1fec:	83 ec 08             	sub    $0x8,%esp
    1fef:	68 56 68 00 00       	push   $0x6856
    1ff4:	6a 01                	push   $0x1
    1ff6:	e8 c7 1d 00 00       	call   3dc2 <printf>
    1ffb:	83 c4 10             	add    $0x10,%esp
    exit();
    1ffe:	e8 00 1c 00 00       	call   3c03 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    2003:	83 ec 04             	sub    $0x4,%esp
    2006:	68 00 20 00 00       	push   $0x2000
    200b:	68 20 e4 00 00       	push   $0xe420
    2010:	ff 75 f4             	pushl  -0xc(%ebp)
    2013:	e8 03 1c 00 00       	call   3c1b <read>
    2018:	83 c4 10             	add    $0x10,%esp
    201b:	83 f8 02             	cmp    $0x2,%eax
    201e:	74 17                	je     2037 <subdir+0x376>
    printf(1, "read dd/dd/ffff wrong len\n");
    2020:	83 ec 08             	sub    $0x8,%esp
    2023:	68 6e 68 00 00       	push   $0x686e
    2028:	6a 01                	push   $0x1
    202a:	e8 93 1d 00 00       	call   3dc2 <printf>
    202f:	83 c4 10             	add    $0x10,%esp
    exit();
    2032:	e8 cc 1b 00 00       	call   3c03 <exit>
  }
  close(fd);
    2037:	83 ec 0c             	sub    $0xc,%esp
    203a:	ff 75 f4             	pushl  -0xc(%ebp)
    203d:	e8 e9 1b 00 00       	call   3c2b <close>
    2042:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2045:	83 ec 08             	sub    $0x8,%esp
    2048:	6a 00                	push   $0x0
    204a:	68 28 67 00 00       	push   $0x6728
    204f:	e8 ef 1b 00 00       	call   3c43 <open>
    2054:	83 c4 10             	add    $0x10,%esp
    2057:	85 c0                	test   %eax,%eax
    2059:	78 17                	js     2072 <subdir+0x3b1>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    205b:	83 ec 08             	sub    $0x8,%esp
    205e:	68 8c 68 00 00       	push   $0x688c
    2063:	6a 01                	push   $0x1
    2065:	e8 58 1d 00 00       	call   3dc2 <printf>
    206a:	83 c4 10             	add    $0x10,%esp
    exit();
    206d:	e8 91 1b 00 00       	call   3c03 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2072:	83 ec 08             	sub    $0x8,%esp
    2075:	68 02 02 00 00       	push   $0x202
    207a:	68 b1 68 00 00       	push   $0x68b1
    207f:	e8 bf 1b 00 00       	call   3c43 <open>
    2084:	83 c4 10             	add    $0x10,%esp
    2087:	85 c0                	test   %eax,%eax
    2089:	78 17                	js     20a2 <subdir+0x3e1>
    printf(1, "create dd/ff/ff succeeded!\n");
    208b:	83 ec 08             	sub    $0x8,%esp
    208e:	68 ba 68 00 00       	push   $0x68ba
    2093:	6a 01                	push   $0x1
    2095:	e8 28 1d 00 00       	call   3dc2 <printf>
    209a:	83 c4 10             	add    $0x10,%esp
    exit();
    209d:	e8 61 1b 00 00       	call   3c03 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    20a2:	83 ec 08             	sub    $0x8,%esp
    20a5:	68 02 02 00 00       	push   $0x202
    20aa:	68 d6 68 00 00       	push   $0x68d6
    20af:	e8 8f 1b 00 00       	call   3c43 <open>
    20b4:	83 c4 10             	add    $0x10,%esp
    20b7:	85 c0                	test   %eax,%eax
    20b9:	78 17                	js     20d2 <subdir+0x411>
    printf(1, "create dd/xx/ff succeeded!\n");
    20bb:	83 ec 08             	sub    $0x8,%esp
    20be:	68 df 68 00 00       	push   $0x68df
    20c3:	6a 01                	push   $0x1
    20c5:	e8 f8 1c 00 00       	call   3dc2 <printf>
    20ca:	83 c4 10             	add    $0x10,%esp
    exit();
    20cd:	e8 31 1b 00 00       	call   3c03 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    20d2:	83 ec 08             	sub    $0x8,%esp
    20d5:	68 00 02 00 00       	push   $0x200
    20da:	68 a9 66 00 00       	push   $0x66a9
    20df:	e8 5f 1b 00 00       	call   3c43 <open>
    20e4:	83 c4 10             	add    $0x10,%esp
    20e7:	85 c0                	test   %eax,%eax
    20e9:	78 17                	js     2102 <subdir+0x441>
    printf(1, "create dd succeeded!\n");
    20eb:	83 ec 08             	sub    $0x8,%esp
    20ee:	68 fb 68 00 00       	push   $0x68fb
    20f3:	6a 01                	push   $0x1
    20f5:	e8 c8 1c 00 00       	call   3dc2 <printf>
    20fa:	83 c4 10             	add    $0x10,%esp
    exit();
    20fd:	e8 01 1b 00 00       	call   3c03 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    2102:	83 ec 08             	sub    $0x8,%esp
    2105:	6a 02                	push   $0x2
    2107:	68 a9 66 00 00       	push   $0x66a9
    210c:	e8 32 1b 00 00       	call   3c43 <open>
    2111:	83 c4 10             	add    $0x10,%esp
    2114:	85 c0                	test   %eax,%eax
    2116:	78 17                	js     212f <subdir+0x46e>
    printf(1, "open dd rdwr succeeded!\n");
    2118:	83 ec 08             	sub    $0x8,%esp
    211b:	68 11 69 00 00       	push   $0x6911
    2120:	6a 01                	push   $0x1
    2122:	e8 9b 1c 00 00       	call   3dc2 <printf>
    2127:	83 c4 10             	add    $0x10,%esp
    exit();
    212a:	e8 d4 1a 00 00       	call   3c03 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    212f:	83 ec 08             	sub    $0x8,%esp
    2132:	6a 01                	push   $0x1
    2134:	68 a9 66 00 00       	push   $0x66a9
    2139:	e8 05 1b 00 00       	call   3c43 <open>
    213e:	83 c4 10             	add    $0x10,%esp
    2141:	85 c0                	test   %eax,%eax
    2143:	78 17                	js     215c <subdir+0x49b>
    printf(1, "open dd wronly succeeded!\n");
    2145:	83 ec 08             	sub    $0x8,%esp
    2148:	68 2a 69 00 00       	push   $0x692a
    214d:	6a 01                	push   $0x1
    214f:	e8 6e 1c 00 00       	call   3dc2 <printf>
    2154:	83 c4 10             	add    $0x10,%esp
    exit();
    2157:	e8 a7 1a 00 00       	call   3c03 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    215c:	83 ec 08             	sub    $0x8,%esp
    215f:	68 45 69 00 00       	push   $0x6945
    2164:	68 b1 68 00 00       	push   $0x68b1
    2169:	e8 f5 1a 00 00       	call   3c63 <link>
    216e:	83 c4 10             	add    $0x10,%esp
    2171:	85 c0                	test   %eax,%eax
    2173:	75 17                	jne    218c <subdir+0x4cb>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2175:	83 ec 08             	sub    $0x8,%esp
    2178:	68 50 69 00 00       	push   $0x6950
    217d:	6a 01                	push   $0x1
    217f:	e8 3e 1c 00 00       	call   3dc2 <printf>
    2184:	83 c4 10             	add    $0x10,%esp
    exit();
    2187:	e8 77 1a 00 00       	call   3c03 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    218c:	83 ec 08             	sub    $0x8,%esp
    218f:	68 45 69 00 00       	push   $0x6945
    2194:	68 d6 68 00 00       	push   $0x68d6
    2199:	e8 c5 1a 00 00       	call   3c63 <link>
    219e:	83 c4 10             	add    $0x10,%esp
    21a1:	85 c0                	test   %eax,%eax
    21a3:	75 17                	jne    21bc <subdir+0x4fb>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    21a5:	83 ec 08             	sub    $0x8,%esp
    21a8:	68 74 69 00 00       	push   $0x6974
    21ad:	6a 01                	push   $0x1
    21af:	e8 0e 1c 00 00       	call   3dc2 <printf>
    21b4:	83 c4 10             	add    $0x10,%esp
    exit();
    21b7:	e8 47 1a 00 00       	call   3c03 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    21bc:	83 ec 08             	sub    $0x8,%esp
    21bf:	68 8c 67 00 00       	push   $0x678c
    21c4:	68 c4 66 00 00       	push   $0x66c4
    21c9:	e8 95 1a 00 00       	call   3c63 <link>
    21ce:	83 c4 10             	add    $0x10,%esp
    21d1:	85 c0                	test   %eax,%eax
    21d3:	75 17                	jne    21ec <subdir+0x52b>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21d5:	83 ec 08             	sub    $0x8,%esp
    21d8:	68 98 69 00 00       	push   $0x6998
    21dd:	6a 01                	push   $0x1
    21df:	e8 de 1b 00 00       	call   3dc2 <printf>
    21e4:	83 c4 10             	add    $0x10,%esp
    exit();
    21e7:	e8 17 1a 00 00       	call   3c03 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    21ec:	83 ec 0c             	sub    $0xc,%esp
    21ef:	68 b1 68 00 00       	push   $0x68b1
    21f4:	e8 72 1a 00 00       	call   3c6b <mkdir>
    21f9:	83 c4 10             	add    $0x10,%esp
    21fc:	85 c0                	test   %eax,%eax
    21fe:	75 17                	jne    2217 <subdir+0x556>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2200:	83 ec 08             	sub    $0x8,%esp
    2203:	68 ba 69 00 00       	push   $0x69ba
    2208:	6a 01                	push   $0x1
    220a:	e8 b3 1b 00 00       	call   3dc2 <printf>
    220f:	83 c4 10             	add    $0x10,%esp
    exit();
    2212:	e8 ec 19 00 00       	call   3c03 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2217:	83 ec 0c             	sub    $0xc,%esp
    221a:	68 d6 68 00 00       	push   $0x68d6
    221f:	e8 47 1a 00 00       	call   3c6b <mkdir>
    2224:	83 c4 10             	add    $0x10,%esp
    2227:	85 c0                	test   %eax,%eax
    2229:	75 17                	jne    2242 <subdir+0x581>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    222b:	83 ec 08             	sub    $0x8,%esp
    222e:	68 d5 69 00 00       	push   $0x69d5
    2233:	6a 01                	push   $0x1
    2235:	e8 88 1b 00 00       	call   3dc2 <printf>
    223a:	83 c4 10             	add    $0x10,%esp
    exit();
    223d:	e8 c1 19 00 00       	call   3c03 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    2242:	83 ec 0c             	sub    $0xc,%esp
    2245:	68 8c 67 00 00       	push   $0x678c
    224a:	e8 1c 1a 00 00       	call   3c6b <mkdir>
    224f:	83 c4 10             	add    $0x10,%esp
    2252:	85 c0                	test   %eax,%eax
    2254:	75 17                	jne    226d <subdir+0x5ac>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2256:	83 ec 08             	sub    $0x8,%esp
    2259:	68 f0 69 00 00       	push   $0x69f0
    225e:	6a 01                	push   $0x1
    2260:	e8 5d 1b 00 00       	call   3dc2 <printf>
    2265:	83 c4 10             	add    $0x10,%esp
    exit();
    2268:	e8 96 19 00 00       	call   3c03 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    226d:	83 ec 0c             	sub    $0xc,%esp
    2270:	68 d6 68 00 00       	push   $0x68d6
    2275:	e8 d9 19 00 00       	call   3c53 <unlink>
    227a:	83 c4 10             	add    $0x10,%esp
    227d:	85 c0                	test   %eax,%eax
    227f:	75 17                	jne    2298 <subdir+0x5d7>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2281:	83 ec 08             	sub    $0x8,%esp
    2284:	68 0d 6a 00 00       	push   $0x6a0d
    2289:	6a 01                	push   $0x1
    228b:	e8 32 1b 00 00       	call   3dc2 <printf>
    2290:	83 c4 10             	add    $0x10,%esp
    exit();
    2293:	e8 6b 19 00 00       	call   3c03 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    2298:	83 ec 0c             	sub    $0xc,%esp
    229b:	68 b1 68 00 00       	push   $0x68b1
    22a0:	e8 ae 19 00 00       	call   3c53 <unlink>
    22a5:	83 c4 10             	add    $0x10,%esp
    22a8:	85 c0                	test   %eax,%eax
    22aa:	75 17                	jne    22c3 <subdir+0x602>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    22ac:	83 ec 08             	sub    $0x8,%esp
    22af:	68 29 6a 00 00       	push   $0x6a29
    22b4:	6a 01                	push   $0x1
    22b6:	e8 07 1b 00 00       	call   3dc2 <printf>
    22bb:	83 c4 10             	add    $0x10,%esp
    exit();
    22be:	e8 40 19 00 00       	call   3c03 <exit>
  }
  if(chdir("dd/ff") == 0){
    22c3:	83 ec 0c             	sub    $0xc,%esp
    22c6:	68 c4 66 00 00       	push   $0x66c4
    22cb:	e8 a3 19 00 00       	call   3c73 <chdir>
    22d0:	83 c4 10             	add    $0x10,%esp
    22d3:	85 c0                	test   %eax,%eax
    22d5:	75 17                	jne    22ee <subdir+0x62d>
    printf(1, "chdir dd/ff succeeded!\n");
    22d7:	83 ec 08             	sub    $0x8,%esp
    22da:	68 45 6a 00 00       	push   $0x6a45
    22df:	6a 01                	push   $0x1
    22e1:	e8 dc 1a 00 00       	call   3dc2 <printf>
    22e6:	83 c4 10             	add    $0x10,%esp
    exit();
    22e9:	e8 15 19 00 00       	call   3c03 <exit>
  }
  if(chdir("dd/xx") == 0){
    22ee:	83 ec 0c             	sub    $0xc,%esp
    22f1:	68 5d 6a 00 00       	push   $0x6a5d
    22f6:	e8 78 19 00 00       	call   3c73 <chdir>
    22fb:	83 c4 10             	add    $0x10,%esp
    22fe:	85 c0                	test   %eax,%eax
    2300:	75 17                	jne    2319 <subdir+0x658>
    printf(1, "chdir dd/xx succeeded!\n");
    2302:	83 ec 08             	sub    $0x8,%esp
    2305:	68 63 6a 00 00       	push   $0x6a63
    230a:	6a 01                	push   $0x1
    230c:	e8 b1 1a 00 00       	call   3dc2 <printf>
    2311:	83 c4 10             	add    $0x10,%esp
    exit();
    2314:	e8 ea 18 00 00       	call   3c03 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2319:	83 ec 0c             	sub    $0xc,%esp
    231c:	68 8c 67 00 00       	push   $0x678c
    2321:	e8 2d 19 00 00       	call   3c53 <unlink>
    2326:	83 c4 10             	add    $0x10,%esp
    2329:	85 c0                	test   %eax,%eax
    232b:	74 17                	je     2344 <subdir+0x683>
    printf(1, "unlink dd/dd/ff failed\n");
    232d:	83 ec 08             	sub    $0x8,%esp
    2330:	68 b9 67 00 00       	push   $0x67b9
    2335:	6a 01                	push   $0x1
    2337:	e8 86 1a 00 00       	call   3dc2 <printf>
    233c:	83 c4 10             	add    $0x10,%esp
    exit();
    233f:	e8 bf 18 00 00       	call   3c03 <exit>
  }
  if(unlink("dd/ff") != 0){
    2344:	83 ec 0c             	sub    $0xc,%esp
    2347:	68 c4 66 00 00       	push   $0x66c4
    234c:	e8 02 19 00 00       	call   3c53 <unlink>
    2351:	83 c4 10             	add    $0x10,%esp
    2354:	85 c0                	test   %eax,%eax
    2356:	74 17                	je     236f <subdir+0x6ae>
    printf(1, "unlink dd/ff failed\n");
    2358:	83 ec 08             	sub    $0x8,%esp
    235b:	68 7b 6a 00 00       	push   $0x6a7b
    2360:	6a 01                	push   $0x1
    2362:	e8 5b 1a 00 00       	call   3dc2 <printf>
    2367:	83 c4 10             	add    $0x10,%esp
    exit();
    236a:	e8 94 18 00 00       	call   3c03 <exit>
  }
  if(unlink("dd") == 0){
    236f:	83 ec 0c             	sub    $0xc,%esp
    2372:	68 a9 66 00 00       	push   $0x66a9
    2377:	e8 d7 18 00 00       	call   3c53 <unlink>
    237c:	83 c4 10             	add    $0x10,%esp
    237f:	85 c0                	test   %eax,%eax
    2381:	75 17                	jne    239a <subdir+0x6d9>
    printf(1, "unlink non-empty dd succeeded!\n");
    2383:	83 ec 08             	sub    $0x8,%esp
    2386:	68 90 6a 00 00       	push   $0x6a90
    238b:	6a 01                	push   $0x1
    238d:	e8 30 1a 00 00       	call   3dc2 <printf>
    2392:	83 c4 10             	add    $0x10,%esp
    exit();
    2395:	e8 69 18 00 00       	call   3c03 <exit>
  }
  if(unlink("dd/dd") < 0){
    239a:	83 ec 0c             	sub    $0xc,%esp
    239d:	68 b0 6a 00 00       	push   $0x6ab0
    23a2:	e8 ac 18 00 00       	call   3c53 <unlink>
    23a7:	83 c4 10             	add    $0x10,%esp
    23aa:	85 c0                	test   %eax,%eax
    23ac:	79 17                	jns    23c5 <subdir+0x704>
    printf(1, "unlink dd/dd failed\n");
    23ae:	83 ec 08             	sub    $0x8,%esp
    23b1:	68 b6 6a 00 00       	push   $0x6ab6
    23b6:	6a 01                	push   $0x1
    23b8:	e8 05 1a 00 00       	call   3dc2 <printf>
    23bd:	83 c4 10             	add    $0x10,%esp
    exit();
    23c0:	e8 3e 18 00 00       	call   3c03 <exit>
  }
  if(unlink("dd") < 0){
    23c5:	83 ec 0c             	sub    $0xc,%esp
    23c8:	68 a9 66 00 00       	push   $0x66a9
    23cd:	e8 81 18 00 00       	call   3c53 <unlink>
    23d2:	83 c4 10             	add    $0x10,%esp
    23d5:	85 c0                	test   %eax,%eax
    23d7:	79 17                	jns    23f0 <subdir+0x72f>
    printf(1, "unlink dd failed\n");
    23d9:	83 ec 08             	sub    $0x8,%esp
    23dc:	68 cb 6a 00 00       	push   $0x6acb
    23e1:	6a 01                	push   $0x1
    23e3:	e8 da 19 00 00       	call   3dc2 <printf>
    23e8:	83 c4 10             	add    $0x10,%esp
    exit();
    23eb:	e8 13 18 00 00       	call   3c03 <exit>
  }

  printf(1, "subdir ok\n");
    23f0:	83 ec 08             	sub    $0x8,%esp
    23f3:	68 dd 6a 00 00       	push   $0x6add
    23f8:	6a 01                	push   $0x1
    23fa:	e8 c3 19 00 00       	call   3dc2 <printf>
    23ff:	83 c4 10             	add    $0x10,%esp
}
    2402:	90                   	nop
    2403:	c9                   	leave  
    2404:	c3                   	ret    

00002405 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2405:	55                   	push   %ebp
    2406:	89 e5                	mov    %esp,%ebp
    2408:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    240b:	83 ec 08             	sub    $0x8,%esp
    240e:	68 e8 6a 00 00       	push   $0x6ae8
    2413:	6a 01                	push   $0x1
    2415:	e8 a8 19 00 00       	call   3dc2 <printf>
    241a:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    241d:	83 ec 0c             	sub    $0xc,%esp
    2420:	68 f7 6a 00 00       	push   $0x6af7
    2425:	e8 29 18 00 00       	call   3c53 <unlink>
    242a:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    242d:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    2434:	e9 a8 00 00 00       	jmp    24e1 <bigwrite+0xdc>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2439:	83 ec 08             	sub    $0x8,%esp
    243c:	68 02 02 00 00       	push   $0x202
    2441:	68 f7 6a 00 00       	push   $0x6af7
    2446:	e8 f8 17 00 00       	call   3c43 <open>
    244b:	83 c4 10             	add    $0x10,%esp
    244e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    2451:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2455:	79 17                	jns    246e <bigwrite+0x69>
      printf(1, "cannot create bigwrite\n");
    2457:	83 ec 08             	sub    $0x8,%esp
    245a:	68 00 6b 00 00       	push   $0x6b00
    245f:	6a 01                	push   $0x1
    2461:	e8 5c 19 00 00       	call   3dc2 <printf>
    2466:	83 c4 10             	add    $0x10,%esp
      exit();
    2469:	e8 95 17 00 00       	call   3c03 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    246e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2475:	eb 3f                	jmp    24b6 <bigwrite+0xb1>
      int cc = write(fd, buf, sz);
    2477:	83 ec 04             	sub    $0x4,%esp
    247a:	ff 75 f4             	pushl  -0xc(%ebp)
    247d:	68 20 e4 00 00       	push   $0xe420
    2482:	ff 75 ec             	pushl  -0x14(%ebp)
    2485:	e8 99 17 00 00       	call   3c23 <write>
    248a:	83 c4 10             	add    $0x10,%esp
    248d:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    2490:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2493:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2496:	74 1a                	je     24b2 <bigwrite+0xad>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2498:	ff 75 e8             	pushl  -0x18(%ebp)
    249b:	ff 75 f4             	pushl  -0xc(%ebp)
    249e:	68 18 6b 00 00       	push   $0x6b18
    24a3:	6a 01                	push   $0x1
    24a5:	e8 18 19 00 00       	call   3dc2 <printf>
    24aa:	83 c4 10             	add    $0x10,%esp
        exit();
    24ad:	e8 51 17 00 00       	call   3c03 <exit>
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
    24b2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    24b6:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    24ba:	7e bb                	jle    2477 <bigwrite+0x72>
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    24bc:	83 ec 0c             	sub    $0xc,%esp
    24bf:	ff 75 ec             	pushl  -0x14(%ebp)
    24c2:	e8 64 17 00 00       	call   3c2b <close>
    24c7:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    24ca:	83 ec 0c             	sub    $0xc,%esp
    24cd:	68 f7 6a 00 00       	push   $0x6af7
    24d2:	e8 7c 17 00 00       	call   3c53 <unlink>
    24d7:	83 c4 10             	add    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    24da:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    24e1:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    24e8:	0f 8e 4b ff ff ff    	jle    2439 <bigwrite+0x34>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    24ee:	83 ec 08             	sub    $0x8,%esp
    24f1:	68 2a 6b 00 00       	push   $0x6b2a
    24f6:	6a 01                	push   $0x1
    24f8:	e8 c5 18 00 00       	call   3dc2 <printf>
    24fd:	83 c4 10             	add    $0x10,%esp
}
    2500:	90                   	nop
    2501:	c9                   	leave  
    2502:	c3                   	ret    

00002503 <bigfile>:

void
bigfile(void)
{
    2503:	55                   	push   %ebp
    2504:	89 e5                	mov    %esp,%ebp
    2506:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2509:	83 ec 08             	sub    $0x8,%esp
    250c:	68 37 6b 00 00       	push   $0x6b37
    2511:	6a 01                	push   $0x1
    2513:	e8 aa 18 00 00       	call   3dc2 <printf>
    2518:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    251b:	83 ec 0c             	sub    $0xc,%esp
    251e:	68 45 6b 00 00       	push   $0x6b45
    2523:	e8 2b 17 00 00       	call   3c53 <unlink>
    2528:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    252b:	83 ec 08             	sub    $0x8,%esp
    252e:	68 02 02 00 00       	push   $0x202
    2533:	68 45 6b 00 00       	push   $0x6b45
    2538:	e8 06 17 00 00       	call   3c43 <open>
    253d:	83 c4 10             	add    $0x10,%esp
    2540:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2543:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2547:	79 17                	jns    2560 <bigfile+0x5d>
    printf(1, "cannot create bigfile");
    2549:	83 ec 08             	sub    $0x8,%esp
    254c:	68 4d 6b 00 00       	push   $0x6b4d
    2551:	6a 01                	push   $0x1
    2553:	e8 6a 18 00 00       	call   3dc2 <printf>
    2558:	83 c4 10             	add    $0x10,%esp
    exit();
    255b:	e8 a3 16 00 00       	call   3c03 <exit>
  }
  for(i = 0; i < 20; i++){
    2560:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2567:	eb 52                	jmp    25bb <bigfile+0xb8>
    memset(buf, i, 600);
    2569:	83 ec 04             	sub    $0x4,%esp
    256c:	68 58 02 00 00       	push   $0x258
    2571:	ff 75 f4             	pushl  -0xc(%ebp)
    2574:	68 20 e4 00 00       	push   $0xe420
    2579:	e8 ea 14 00 00       	call   3a68 <memset>
    257e:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    2581:	83 ec 04             	sub    $0x4,%esp
    2584:	68 58 02 00 00       	push   $0x258
    2589:	68 20 e4 00 00       	push   $0xe420
    258e:	ff 75 ec             	pushl  -0x14(%ebp)
    2591:	e8 8d 16 00 00       	call   3c23 <write>
    2596:	83 c4 10             	add    $0x10,%esp
    2599:	3d 58 02 00 00       	cmp    $0x258,%eax
    259e:	74 17                	je     25b7 <bigfile+0xb4>
      printf(1, "write bigfile failed\n");
    25a0:	83 ec 08             	sub    $0x8,%esp
    25a3:	68 63 6b 00 00       	push   $0x6b63
    25a8:	6a 01                	push   $0x1
    25aa:	e8 13 18 00 00       	call   3dc2 <printf>
    25af:	83 c4 10             	add    $0x10,%esp
      exit();
    25b2:	e8 4c 16 00 00       	call   3c03 <exit>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    25b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    25bb:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    25bf:	7e a8                	jle    2569 <bigfile+0x66>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    25c1:	83 ec 0c             	sub    $0xc,%esp
    25c4:	ff 75 ec             	pushl  -0x14(%ebp)
    25c7:	e8 5f 16 00 00       	call   3c2b <close>
    25cc:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    25cf:	83 ec 08             	sub    $0x8,%esp
    25d2:	6a 00                	push   $0x0
    25d4:	68 45 6b 00 00       	push   $0x6b45
    25d9:	e8 65 16 00 00       	call   3c43 <open>
    25de:	83 c4 10             	add    $0x10,%esp
    25e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    25e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    25e8:	79 17                	jns    2601 <bigfile+0xfe>
    printf(1, "cannot open bigfile\n");
    25ea:	83 ec 08             	sub    $0x8,%esp
    25ed:	68 79 6b 00 00       	push   $0x6b79
    25f2:	6a 01                	push   $0x1
    25f4:	e8 c9 17 00 00       	call   3dc2 <printf>
    25f9:	83 c4 10             	add    $0x10,%esp
    exit();
    25fc:	e8 02 16 00 00       	call   3c03 <exit>
  }
  total = 0;
    2601:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    2608:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    260f:	83 ec 04             	sub    $0x4,%esp
    2612:	68 2c 01 00 00       	push   $0x12c
    2617:	68 20 e4 00 00       	push   $0xe420
    261c:	ff 75 ec             	pushl  -0x14(%ebp)
    261f:	e8 f7 15 00 00       	call   3c1b <read>
    2624:	83 c4 10             	add    $0x10,%esp
    2627:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    262a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    262e:	79 17                	jns    2647 <bigfile+0x144>
      printf(1, "read bigfile failed\n");
    2630:	83 ec 08             	sub    $0x8,%esp
    2633:	68 8e 6b 00 00       	push   $0x6b8e
    2638:	6a 01                	push   $0x1
    263a:	e8 83 17 00 00       	call   3dc2 <printf>
    263f:	83 c4 10             	add    $0x10,%esp
      exit();
    2642:	e8 bc 15 00 00       	call   3c03 <exit>
    }
    if(cc == 0)
    2647:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    264b:	74 7a                	je     26c7 <bigfile+0x1c4>
      break;
    if(cc != 300){
    264d:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2654:	74 17                	je     266d <bigfile+0x16a>
      printf(1, "short read bigfile\n");
    2656:	83 ec 08             	sub    $0x8,%esp
    2659:	68 a3 6b 00 00       	push   $0x6ba3
    265e:	6a 01                	push   $0x1
    2660:	e8 5d 17 00 00       	call   3dc2 <printf>
    2665:	83 c4 10             	add    $0x10,%esp
      exit();
    2668:	e8 96 15 00 00       	call   3c03 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    266d:	0f b6 05 20 e4 00 00 	movzbl 0xe420,%eax
    2674:	0f be d0             	movsbl %al,%edx
    2677:	8b 45 f4             	mov    -0xc(%ebp),%eax
    267a:	89 c1                	mov    %eax,%ecx
    267c:	c1 e9 1f             	shr    $0x1f,%ecx
    267f:	01 c8                	add    %ecx,%eax
    2681:	d1 f8                	sar    %eax
    2683:	39 c2                	cmp    %eax,%edx
    2685:	75 1a                	jne    26a1 <bigfile+0x19e>
    2687:	0f b6 05 4b e5 00 00 	movzbl 0xe54b,%eax
    268e:	0f be d0             	movsbl %al,%edx
    2691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2694:	89 c1                	mov    %eax,%ecx
    2696:	c1 e9 1f             	shr    $0x1f,%ecx
    2699:	01 c8                	add    %ecx,%eax
    269b:	d1 f8                	sar    %eax
    269d:	39 c2                	cmp    %eax,%edx
    269f:	74 17                	je     26b8 <bigfile+0x1b5>
      printf(1, "read bigfile wrong data\n");
    26a1:	83 ec 08             	sub    $0x8,%esp
    26a4:	68 b7 6b 00 00       	push   $0x6bb7
    26a9:	6a 01                	push   $0x1
    26ab:	e8 12 17 00 00       	call   3dc2 <printf>
    26b0:	83 c4 10             	add    $0x10,%esp
      exit();
    26b3:	e8 4b 15 00 00       	call   3c03 <exit>
    }
    total += cc;
    26b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26bb:	01 45 f0             	add    %eax,-0x10(%ebp)
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    26be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
    26c2:	e9 48 ff ff ff       	jmp    260f <bigfile+0x10c>
    if(cc < 0){
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    26c7:	90                   	nop
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    26c8:	83 ec 0c             	sub    $0xc,%esp
    26cb:	ff 75 ec             	pushl  -0x14(%ebp)
    26ce:	e8 58 15 00 00       	call   3c2b <close>
    26d3:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    26d6:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    26dd:	74 17                	je     26f6 <bigfile+0x1f3>
    printf(1, "read bigfile wrong total\n");
    26df:	83 ec 08             	sub    $0x8,%esp
    26e2:	68 d0 6b 00 00       	push   $0x6bd0
    26e7:	6a 01                	push   $0x1
    26e9:	e8 d4 16 00 00       	call   3dc2 <printf>
    26ee:	83 c4 10             	add    $0x10,%esp
    exit();
    26f1:	e8 0d 15 00 00       	call   3c03 <exit>
  }
  unlink("bigfile");
    26f6:	83 ec 0c             	sub    $0xc,%esp
    26f9:	68 45 6b 00 00       	push   $0x6b45
    26fe:	e8 50 15 00 00       	call   3c53 <unlink>
    2703:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    2706:	83 ec 08             	sub    $0x8,%esp
    2709:	68 ea 6b 00 00       	push   $0x6bea
    270e:	6a 01                	push   $0x1
    2710:	e8 ad 16 00 00       	call   3dc2 <printf>
    2715:	83 c4 10             	add    $0x10,%esp
}
    2718:	90                   	nop
    2719:	c9                   	leave  
    271a:	c3                   	ret    

0000271b <fourteen>:

void
fourteen(void)
{
    271b:	55                   	push   %ebp
    271c:	89 e5                	mov    %esp,%ebp
    271e:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2721:	83 ec 08             	sub    $0x8,%esp
    2724:	68 fb 6b 00 00       	push   $0x6bfb
    2729:	6a 01                	push   $0x1
    272b:	e8 92 16 00 00       	call   3dc2 <printf>
    2730:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2733:	83 ec 0c             	sub    $0xc,%esp
    2736:	68 0a 6c 00 00       	push   $0x6c0a
    273b:	e8 2b 15 00 00       	call   3c6b <mkdir>
    2740:	83 c4 10             	add    $0x10,%esp
    2743:	85 c0                	test   %eax,%eax
    2745:	74 17                	je     275e <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    2747:	83 ec 08             	sub    $0x8,%esp
    274a:	68 19 6c 00 00       	push   $0x6c19
    274f:	6a 01                	push   $0x1
    2751:	e8 6c 16 00 00       	call   3dc2 <printf>
    2756:	83 c4 10             	add    $0x10,%esp
    exit();
    2759:	e8 a5 14 00 00       	call   3c03 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    275e:	83 ec 0c             	sub    $0xc,%esp
    2761:	68 38 6c 00 00       	push   $0x6c38
    2766:	e8 00 15 00 00       	call   3c6b <mkdir>
    276b:	83 c4 10             	add    $0x10,%esp
    276e:	85 c0                	test   %eax,%eax
    2770:	74 17                	je     2789 <fourteen+0x6e>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2772:	83 ec 08             	sub    $0x8,%esp
    2775:	68 58 6c 00 00       	push   $0x6c58
    277a:	6a 01                	push   $0x1
    277c:	e8 41 16 00 00       	call   3dc2 <printf>
    2781:	83 c4 10             	add    $0x10,%esp
    exit();
    2784:	e8 7a 14 00 00       	call   3c03 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2789:	83 ec 08             	sub    $0x8,%esp
    278c:	68 00 02 00 00       	push   $0x200
    2791:	68 88 6c 00 00       	push   $0x6c88
    2796:	e8 a8 14 00 00       	call   3c43 <open>
    279b:	83 c4 10             	add    $0x10,%esp
    279e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    27a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27a5:	79 17                	jns    27be <fourteen+0xa3>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27a7:	83 ec 08             	sub    $0x8,%esp
    27aa:	68 b8 6c 00 00       	push   $0x6cb8
    27af:	6a 01                	push   $0x1
    27b1:	e8 0c 16 00 00       	call   3dc2 <printf>
    27b6:	83 c4 10             	add    $0x10,%esp
    exit();
    27b9:	e8 45 14 00 00       	call   3c03 <exit>
  }
  close(fd);
    27be:	83 ec 0c             	sub    $0xc,%esp
    27c1:	ff 75 f4             	pushl  -0xc(%ebp)
    27c4:	e8 62 14 00 00       	call   3c2b <close>
    27c9:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    27cc:	83 ec 08             	sub    $0x8,%esp
    27cf:	6a 00                	push   $0x0
    27d1:	68 f8 6c 00 00       	push   $0x6cf8
    27d6:	e8 68 14 00 00       	call   3c43 <open>
    27db:	83 c4 10             	add    $0x10,%esp
    27de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    27e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27e5:	79 17                	jns    27fe <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27e7:	83 ec 08             	sub    $0x8,%esp
    27ea:	68 28 6d 00 00       	push   $0x6d28
    27ef:	6a 01                	push   $0x1
    27f1:	e8 cc 15 00 00       	call   3dc2 <printf>
    27f6:	83 c4 10             	add    $0x10,%esp
    exit();
    27f9:	e8 05 14 00 00       	call   3c03 <exit>
  }
  close(fd);
    27fe:	83 ec 0c             	sub    $0xc,%esp
    2801:	ff 75 f4             	pushl  -0xc(%ebp)
    2804:	e8 22 14 00 00       	call   3c2b <close>
    2809:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    280c:	83 ec 0c             	sub    $0xc,%esp
    280f:	68 62 6d 00 00       	push   $0x6d62
    2814:	e8 52 14 00 00       	call   3c6b <mkdir>
    2819:	83 c4 10             	add    $0x10,%esp
    281c:	85 c0                	test   %eax,%eax
    281e:	75 17                	jne    2837 <fourteen+0x11c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2820:	83 ec 08             	sub    $0x8,%esp
    2823:	68 80 6d 00 00       	push   $0x6d80
    2828:	6a 01                	push   $0x1
    282a:	e8 93 15 00 00       	call   3dc2 <printf>
    282f:	83 c4 10             	add    $0x10,%esp
    exit();
    2832:	e8 cc 13 00 00       	call   3c03 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2837:	83 ec 0c             	sub    $0xc,%esp
    283a:	68 b0 6d 00 00       	push   $0x6db0
    283f:	e8 27 14 00 00       	call   3c6b <mkdir>
    2844:	83 c4 10             	add    $0x10,%esp
    2847:	85 c0                	test   %eax,%eax
    2849:	75 17                	jne    2862 <fourteen+0x147>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    284b:	83 ec 08             	sub    $0x8,%esp
    284e:	68 d0 6d 00 00       	push   $0x6dd0
    2853:	6a 01                	push   $0x1
    2855:	e8 68 15 00 00       	call   3dc2 <printf>
    285a:	83 c4 10             	add    $0x10,%esp
    exit();
    285d:	e8 a1 13 00 00       	call   3c03 <exit>
  }

  printf(1, "fourteen ok\n");
    2862:	83 ec 08             	sub    $0x8,%esp
    2865:	68 01 6e 00 00       	push   $0x6e01
    286a:	6a 01                	push   $0x1
    286c:	e8 51 15 00 00       	call   3dc2 <printf>
    2871:	83 c4 10             	add    $0x10,%esp
}
    2874:	90                   	nop
    2875:	c9                   	leave  
    2876:	c3                   	ret    

00002877 <rmdot>:

void
rmdot(void)
{
    2877:	55                   	push   %ebp
    2878:	89 e5                	mov    %esp,%ebp
    287a:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    287d:	83 ec 08             	sub    $0x8,%esp
    2880:	68 0e 6e 00 00       	push   $0x6e0e
    2885:	6a 01                	push   $0x1
    2887:	e8 36 15 00 00       	call   3dc2 <printf>
    288c:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    288f:	83 ec 0c             	sub    $0xc,%esp
    2892:	68 1a 6e 00 00       	push   $0x6e1a
    2897:	e8 cf 13 00 00       	call   3c6b <mkdir>
    289c:	83 c4 10             	add    $0x10,%esp
    289f:	85 c0                	test   %eax,%eax
    28a1:	74 17                	je     28ba <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    28a3:	83 ec 08             	sub    $0x8,%esp
    28a6:	68 1f 6e 00 00       	push   $0x6e1f
    28ab:	6a 01                	push   $0x1
    28ad:	e8 10 15 00 00       	call   3dc2 <printf>
    28b2:	83 c4 10             	add    $0x10,%esp
    exit();
    28b5:	e8 49 13 00 00       	call   3c03 <exit>
  }
  if(chdir("dots") != 0){
    28ba:	83 ec 0c             	sub    $0xc,%esp
    28bd:	68 1a 6e 00 00       	push   $0x6e1a
    28c2:	e8 ac 13 00 00       	call   3c73 <chdir>
    28c7:	83 c4 10             	add    $0x10,%esp
    28ca:	85 c0                	test   %eax,%eax
    28cc:	74 17                	je     28e5 <rmdot+0x6e>
    printf(1, "chdir dots failed\n");
    28ce:	83 ec 08             	sub    $0x8,%esp
    28d1:	68 32 6e 00 00       	push   $0x6e32
    28d6:	6a 01                	push   $0x1
    28d8:	e8 e5 14 00 00       	call   3dc2 <printf>
    28dd:	83 c4 10             	add    $0x10,%esp
    exit();
    28e0:	e8 1e 13 00 00       	call   3c03 <exit>
  }
  if(unlink(".") == 0){
    28e5:	83 ec 0c             	sub    $0xc,%esp
    28e8:	68 4b 65 00 00       	push   $0x654b
    28ed:	e8 61 13 00 00       	call   3c53 <unlink>
    28f2:	83 c4 10             	add    $0x10,%esp
    28f5:	85 c0                	test   %eax,%eax
    28f7:	75 17                	jne    2910 <rmdot+0x99>
    printf(1, "rm . worked!\n");
    28f9:	83 ec 08             	sub    $0x8,%esp
    28fc:	68 45 6e 00 00       	push   $0x6e45
    2901:	6a 01                	push   $0x1
    2903:	e8 ba 14 00 00       	call   3dc2 <printf>
    2908:	83 c4 10             	add    $0x10,%esp
    exit();
    290b:	e8 f3 12 00 00       	call   3c03 <exit>
  }
  if(unlink("..") == 0){
    2910:	83 ec 0c             	sub    $0xc,%esp
    2913:	68 d8 60 00 00       	push   $0x60d8
    2918:	e8 36 13 00 00       	call   3c53 <unlink>
    291d:	83 c4 10             	add    $0x10,%esp
    2920:	85 c0                	test   %eax,%eax
    2922:	75 17                	jne    293b <rmdot+0xc4>
    printf(1, "rm .. worked!\n");
    2924:	83 ec 08             	sub    $0x8,%esp
    2927:	68 53 6e 00 00       	push   $0x6e53
    292c:	6a 01                	push   $0x1
    292e:	e8 8f 14 00 00       	call   3dc2 <printf>
    2933:	83 c4 10             	add    $0x10,%esp
    exit();
    2936:	e8 c8 12 00 00       	call   3c03 <exit>
  }
  if(chdir("/") != 0){
    293b:	83 ec 0c             	sub    $0xc,%esp
    293e:	68 62 6e 00 00       	push   $0x6e62
    2943:	e8 2b 13 00 00       	call   3c73 <chdir>
    2948:	83 c4 10             	add    $0x10,%esp
    294b:	85 c0                	test   %eax,%eax
    294d:	74 17                	je     2966 <rmdot+0xef>
    printf(1, "chdir / failed\n");
    294f:	83 ec 08             	sub    $0x8,%esp
    2952:	68 64 6e 00 00       	push   $0x6e64
    2957:	6a 01                	push   $0x1
    2959:	e8 64 14 00 00       	call   3dc2 <printf>
    295e:	83 c4 10             	add    $0x10,%esp
    exit();
    2961:	e8 9d 12 00 00       	call   3c03 <exit>
  }
  if(unlink("dots/.") == 0){
    2966:	83 ec 0c             	sub    $0xc,%esp
    2969:	68 74 6e 00 00       	push   $0x6e74
    296e:	e8 e0 12 00 00       	call   3c53 <unlink>
    2973:	83 c4 10             	add    $0x10,%esp
    2976:	85 c0                	test   %eax,%eax
    2978:	75 17                	jne    2991 <rmdot+0x11a>
    printf(1, "unlink dots/. worked!\n");
    297a:	83 ec 08             	sub    $0x8,%esp
    297d:	68 7b 6e 00 00       	push   $0x6e7b
    2982:	6a 01                	push   $0x1
    2984:	e8 39 14 00 00       	call   3dc2 <printf>
    2989:	83 c4 10             	add    $0x10,%esp
    exit();
    298c:	e8 72 12 00 00       	call   3c03 <exit>
  }
  if(unlink("dots/..") == 0){
    2991:	83 ec 0c             	sub    $0xc,%esp
    2994:	68 92 6e 00 00       	push   $0x6e92
    2999:	e8 b5 12 00 00       	call   3c53 <unlink>
    299e:	83 c4 10             	add    $0x10,%esp
    29a1:	85 c0                	test   %eax,%eax
    29a3:	75 17                	jne    29bc <rmdot+0x145>
    printf(1, "unlink dots/.. worked!\n");
    29a5:	83 ec 08             	sub    $0x8,%esp
    29a8:	68 9a 6e 00 00       	push   $0x6e9a
    29ad:	6a 01                	push   $0x1
    29af:	e8 0e 14 00 00       	call   3dc2 <printf>
    29b4:	83 c4 10             	add    $0x10,%esp
    exit();
    29b7:	e8 47 12 00 00       	call   3c03 <exit>
  }
  if(unlink("dots") != 0){
    29bc:	83 ec 0c             	sub    $0xc,%esp
    29bf:	68 1a 6e 00 00       	push   $0x6e1a
    29c4:	e8 8a 12 00 00       	call   3c53 <unlink>
    29c9:	83 c4 10             	add    $0x10,%esp
    29cc:	85 c0                	test   %eax,%eax
    29ce:	74 17                	je     29e7 <rmdot+0x170>
    printf(1, "unlink dots failed!\n");
    29d0:	83 ec 08             	sub    $0x8,%esp
    29d3:	68 b2 6e 00 00       	push   $0x6eb2
    29d8:	6a 01                	push   $0x1
    29da:	e8 e3 13 00 00       	call   3dc2 <printf>
    29df:	83 c4 10             	add    $0x10,%esp
    exit();
    29e2:	e8 1c 12 00 00       	call   3c03 <exit>
  }
  printf(1, "rmdot ok\n");
    29e7:	83 ec 08             	sub    $0x8,%esp
    29ea:	68 c7 6e 00 00       	push   $0x6ec7
    29ef:	6a 01                	push   $0x1
    29f1:	e8 cc 13 00 00       	call   3dc2 <printf>
    29f6:	83 c4 10             	add    $0x10,%esp
}
    29f9:	90                   	nop
    29fa:	c9                   	leave  
    29fb:	c3                   	ret    

000029fc <dirfile>:

void
dirfile(void)
{
    29fc:	55                   	push   %ebp
    29fd:	89 e5                	mov    %esp,%ebp
    29ff:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2a02:	83 ec 08             	sub    $0x8,%esp
    2a05:	68 d1 6e 00 00       	push   $0x6ed1
    2a0a:	6a 01                	push   $0x1
    2a0c:	e8 b1 13 00 00       	call   3dc2 <printf>
    2a11:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2a14:	83 ec 08             	sub    $0x8,%esp
    2a17:	68 00 02 00 00       	push   $0x200
    2a1c:	68 de 6e 00 00       	push   $0x6ede
    2a21:	e8 1d 12 00 00       	call   3c43 <open>
    2a26:	83 c4 10             	add    $0x10,%esp
    2a29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a30:	79 17                	jns    2a49 <dirfile+0x4d>
    printf(1, "create dirfile failed\n");
    2a32:	83 ec 08             	sub    $0x8,%esp
    2a35:	68 e6 6e 00 00       	push   $0x6ee6
    2a3a:	6a 01                	push   $0x1
    2a3c:	e8 81 13 00 00       	call   3dc2 <printf>
    2a41:	83 c4 10             	add    $0x10,%esp
    exit();
    2a44:	e8 ba 11 00 00       	call   3c03 <exit>
  }
  close(fd);
    2a49:	83 ec 0c             	sub    $0xc,%esp
    2a4c:	ff 75 f4             	pushl  -0xc(%ebp)
    2a4f:	e8 d7 11 00 00       	call   3c2b <close>
    2a54:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2a57:	83 ec 0c             	sub    $0xc,%esp
    2a5a:	68 de 6e 00 00       	push   $0x6ede
    2a5f:	e8 0f 12 00 00       	call   3c73 <chdir>
    2a64:	83 c4 10             	add    $0x10,%esp
    2a67:	85 c0                	test   %eax,%eax
    2a69:	75 17                	jne    2a82 <dirfile+0x86>
    printf(1, "chdir dirfile succeeded!\n");
    2a6b:	83 ec 08             	sub    $0x8,%esp
    2a6e:	68 fd 6e 00 00       	push   $0x6efd
    2a73:	6a 01                	push   $0x1
    2a75:	e8 48 13 00 00       	call   3dc2 <printf>
    2a7a:	83 c4 10             	add    $0x10,%esp
    exit();
    2a7d:	e8 81 11 00 00       	call   3c03 <exit>
  }
  fd = open("dirfile/xx", 0);
    2a82:	83 ec 08             	sub    $0x8,%esp
    2a85:	6a 00                	push   $0x0
    2a87:	68 17 6f 00 00       	push   $0x6f17
    2a8c:	e8 b2 11 00 00       	call   3c43 <open>
    2a91:	83 c4 10             	add    $0x10,%esp
    2a94:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2a97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a9b:	78 17                	js     2ab4 <dirfile+0xb8>
    printf(1, "create dirfile/xx succeeded!\n");
    2a9d:	83 ec 08             	sub    $0x8,%esp
    2aa0:	68 22 6f 00 00       	push   $0x6f22
    2aa5:	6a 01                	push   $0x1
    2aa7:	e8 16 13 00 00       	call   3dc2 <printf>
    2aac:	83 c4 10             	add    $0x10,%esp
    exit();
    2aaf:	e8 4f 11 00 00       	call   3c03 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2ab4:	83 ec 08             	sub    $0x8,%esp
    2ab7:	68 00 02 00 00       	push   $0x200
    2abc:	68 17 6f 00 00       	push   $0x6f17
    2ac1:	e8 7d 11 00 00       	call   3c43 <open>
    2ac6:	83 c4 10             	add    $0x10,%esp
    2ac9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2acc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ad0:	78 17                	js     2ae9 <dirfile+0xed>
    printf(1, "create dirfile/xx succeeded!\n");
    2ad2:	83 ec 08             	sub    $0x8,%esp
    2ad5:	68 22 6f 00 00       	push   $0x6f22
    2ada:	6a 01                	push   $0x1
    2adc:	e8 e1 12 00 00       	call   3dc2 <printf>
    2ae1:	83 c4 10             	add    $0x10,%esp
    exit();
    2ae4:	e8 1a 11 00 00       	call   3c03 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2ae9:	83 ec 0c             	sub    $0xc,%esp
    2aec:	68 17 6f 00 00       	push   $0x6f17
    2af1:	e8 75 11 00 00       	call   3c6b <mkdir>
    2af6:	83 c4 10             	add    $0x10,%esp
    2af9:	85 c0                	test   %eax,%eax
    2afb:	75 17                	jne    2b14 <dirfile+0x118>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2afd:	83 ec 08             	sub    $0x8,%esp
    2b00:	68 40 6f 00 00       	push   $0x6f40
    2b05:	6a 01                	push   $0x1
    2b07:	e8 b6 12 00 00       	call   3dc2 <printf>
    2b0c:	83 c4 10             	add    $0x10,%esp
    exit();
    2b0f:	e8 ef 10 00 00       	call   3c03 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2b14:	83 ec 0c             	sub    $0xc,%esp
    2b17:	68 17 6f 00 00       	push   $0x6f17
    2b1c:	e8 32 11 00 00       	call   3c53 <unlink>
    2b21:	83 c4 10             	add    $0x10,%esp
    2b24:	85 c0                	test   %eax,%eax
    2b26:	75 17                	jne    2b3f <dirfile+0x143>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b28:	83 ec 08             	sub    $0x8,%esp
    2b2b:	68 5d 6f 00 00       	push   $0x6f5d
    2b30:	6a 01                	push   $0x1
    2b32:	e8 8b 12 00 00       	call   3dc2 <printf>
    2b37:	83 c4 10             	add    $0x10,%esp
    exit();
    2b3a:	e8 c4 10 00 00       	call   3c03 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2b3f:	83 ec 08             	sub    $0x8,%esp
    2b42:	68 17 6f 00 00       	push   $0x6f17
    2b47:	68 7b 6f 00 00       	push   $0x6f7b
    2b4c:	e8 12 11 00 00       	call   3c63 <link>
    2b51:	83 c4 10             	add    $0x10,%esp
    2b54:	85 c0                	test   %eax,%eax
    2b56:	75 17                	jne    2b6f <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b58:	83 ec 08             	sub    $0x8,%esp
    2b5b:	68 84 6f 00 00       	push   $0x6f84
    2b60:	6a 01                	push   $0x1
    2b62:	e8 5b 12 00 00       	call   3dc2 <printf>
    2b67:	83 c4 10             	add    $0x10,%esp
    exit();
    2b6a:	e8 94 10 00 00       	call   3c03 <exit>
  }
  if(unlink("dirfile") != 0){
    2b6f:	83 ec 0c             	sub    $0xc,%esp
    2b72:	68 de 6e 00 00       	push   $0x6ede
    2b77:	e8 d7 10 00 00       	call   3c53 <unlink>
    2b7c:	83 c4 10             	add    $0x10,%esp
    2b7f:	85 c0                	test   %eax,%eax
    2b81:	74 17                	je     2b9a <dirfile+0x19e>
    printf(1, "unlink dirfile failed!\n");
    2b83:	83 ec 08             	sub    $0x8,%esp
    2b86:	68 a3 6f 00 00       	push   $0x6fa3
    2b8b:	6a 01                	push   $0x1
    2b8d:	e8 30 12 00 00       	call   3dc2 <printf>
    2b92:	83 c4 10             	add    $0x10,%esp
    exit();
    2b95:	e8 69 10 00 00       	call   3c03 <exit>
  }

  fd = open(".", O_RDWR);
    2b9a:	83 ec 08             	sub    $0x8,%esp
    2b9d:	6a 02                	push   $0x2
    2b9f:	68 4b 65 00 00       	push   $0x654b
    2ba4:	e8 9a 10 00 00       	call   3c43 <open>
    2ba9:	83 c4 10             	add    $0x10,%esp
    2bac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2baf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2bb3:	78 17                	js     2bcc <dirfile+0x1d0>
    printf(1, "open . for writing succeeded!\n");
    2bb5:	83 ec 08             	sub    $0x8,%esp
    2bb8:	68 bc 6f 00 00       	push   $0x6fbc
    2bbd:	6a 01                	push   $0x1
    2bbf:	e8 fe 11 00 00       	call   3dc2 <printf>
    2bc4:	83 c4 10             	add    $0x10,%esp
    exit();
    2bc7:	e8 37 10 00 00       	call   3c03 <exit>
  }
  fd = open(".", 0);
    2bcc:	83 ec 08             	sub    $0x8,%esp
    2bcf:	6a 00                	push   $0x0
    2bd1:	68 4b 65 00 00       	push   $0x654b
    2bd6:	e8 68 10 00 00       	call   3c43 <open>
    2bdb:	83 c4 10             	add    $0x10,%esp
    2bde:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2be1:	83 ec 04             	sub    $0x4,%esp
    2be4:	6a 01                	push   $0x1
    2be6:	68 82 61 00 00       	push   $0x6182
    2beb:	ff 75 f4             	pushl  -0xc(%ebp)
    2bee:	e8 30 10 00 00       	call   3c23 <write>
    2bf3:	83 c4 10             	add    $0x10,%esp
    2bf6:	85 c0                	test   %eax,%eax
    2bf8:	7e 17                	jle    2c11 <dirfile+0x215>
    printf(1, "write . succeeded!\n");
    2bfa:	83 ec 08             	sub    $0x8,%esp
    2bfd:	68 db 6f 00 00       	push   $0x6fdb
    2c02:	6a 01                	push   $0x1
    2c04:	e8 b9 11 00 00       	call   3dc2 <printf>
    2c09:	83 c4 10             	add    $0x10,%esp
    exit();
    2c0c:	e8 f2 0f 00 00       	call   3c03 <exit>
  }
  close(fd);
    2c11:	83 ec 0c             	sub    $0xc,%esp
    2c14:	ff 75 f4             	pushl  -0xc(%ebp)
    2c17:	e8 0f 10 00 00       	call   3c2b <close>
    2c1c:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2c1f:	83 ec 08             	sub    $0x8,%esp
    2c22:	68 ef 6f 00 00       	push   $0x6fef
    2c27:	6a 01                	push   $0x1
    2c29:	e8 94 11 00 00       	call   3dc2 <printf>
    2c2e:	83 c4 10             	add    $0x10,%esp
}
    2c31:	90                   	nop
    2c32:	c9                   	leave  
    2c33:	c3                   	ret    

00002c34 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2c34:	55                   	push   %ebp
    2c35:	89 e5                	mov    %esp,%ebp
    2c37:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2c3a:	83 ec 08             	sub    $0x8,%esp
    2c3d:	68 ff 6f 00 00       	push   $0x6fff
    2c42:	6a 01                	push   $0x1
    2c44:	e8 79 11 00 00       	call   3dc2 <printf>
    2c49:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2c4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2c53:	e9 e7 00 00 00       	jmp    2d3f <iref+0x10b>
    if(mkdir("irefd") != 0){
    2c58:	83 ec 0c             	sub    $0xc,%esp
    2c5b:	68 10 70 00 00       	push   $0x7010
    2c60:	e8 06 10 00 00       	call   3c6b <mkdir>
    2c65:	83 c4 10             	add    $0x10,%esp
    2c68:	85 c0                	test   %eax,%eax
    2c6a:	74 17                	je     2c83 <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2c6c:	83 ec 08             	sub    $0x8,%esp
    2c6f:	68 16 70 00 00       	push   $0x7016
    2c74:	6a 01                	push   $0x1
    2c76:	e8 47 11 00 00       	call   3dc2 <printf>
    2c7b:	83 c4 10             	add    $0x10,%esp
      exit();
    2c7e:	e8 80 0f 00 00       	call   3c03 <exit>
    }
    if(chdir("irefd") != 0){
    2c83:	83 ec 0c             	sub    $0xc,%esp
    2c86:	68 10 70 00 00       	push   $0x7010
    2c8b:	e8 e3 0f 00 00       	call   3c73 <chdir>
    2c90:	83 c4 10             	add    $0x10,%esp
    2c93:	85 c0                	test   %eax,%eax
    2c95:	74 17                	je     2cae <iref+0x7a>
      printf(1, "chdir irefd failed\n");
    2c97:	83 ec 08             	sub    $0x8,%esp
    2c9a:	68 2a 70 00 00       	push   $0x702a
    2c9f:	6a 01                	push   $0x1
    2ca1:	e8 1c 11 00 00       	call   3dc2 <printf>
    2ca6:	83 c4 10             	add    $0x10,%esp
      exit();
    2ca9:	e8 55 0f 00 00       	call   3c03 <exit>
    }

    mkdir("");
    2cae:	83 ec 0c             	sub    $0xc,%esp
    2cb1:	68 3e 70 00 00       	push   $0x703e
    2cb6:	e8 b0 0f 00 00       	call   3c6b <mkdir>
    2cbb:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2cbe:	83 ec 08             	sub    $0x8,%esp
    2cc1:	68 3e 70 00 00       	push   $0x703e
    2cc6:	68 7b 6f 00 00       	push   $0x6f7b
    2ccb:	e8 93 0f 00 00       	call   3c63 <link>
    2cd0:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    2cd3:	83 ec 08             	sub    $0x8,%esp
    2cd6:	68 00 02 00 00       	push   $0x200
    2cdb:	68 3e 70 00 00       	push   $0x703e
    2ce0:	e8 5e 0f 00 00       	call   3c43 <open>
    2ce5:	83 c4 10             	add    $0x10,%esp
    2ce8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2ceb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2cef:	78 0e                	js     2cff <iref+0xcb>
      close(fd);
    2cf1:	83 ec 0c             	sub    $0xc,%esp
    2cf4:	ff 75 f0             	pushl  -0x10(%ebp)
    2cf7:	e8 2f 0f 00 00       	call   3c2b <close>
    2cfc:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2cff:	83 ec 08             	sub    $0x8,%esp
    2d02:	68 00 02 00 00       	push   $0x200
    2d07:	68 3f 70 00 00       	push   $0x703f
    2d0c:	e8 32 0f 00 00       	call   3c43 <open>
    2d11:	83 c4 10             	add    $0x10,%esp
    2d14:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2d17:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d1b:	78 0e                	js     2d2b <iref+0xf7>
      close(fd);
    2d1d:	83 ec 0c             	sub    $0xc,%esp
    2d20:	ff 75 f0             	pushl  -0x10(%ebp)
    2d23:	e8 03 0f 00 00       	call   3c2b <close>
    2d28:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2d2b:	83 ec 0c             	sub    $0xc,%esp
    2d2e:	68 3f 70 00 00       	push   $0x703f
    2d33:	e8 1b 0f 00 00       	call   3c53 <unlink>
    2d38:	83 c4 10             	add    $0x10,%esp
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2d3b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d3f:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2d43:	0f 8e 0f ff ff ff    	jle    2c58 <iref+0x24>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2d49:	83 ec 0c             	sub    $0xc,%esp
    2d4c:	68 62 6e 00 00       	push   $0x6e62
    2d51:	e8 1d 0f 00 00       	call   3c73 <chdir>
    2d56:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    2d59:	83 ec 08             	sub    $0x8,%esp
    2d5c:	68 42 70 00 00       	push   $0x7042
    2d61:	6a 01                	push   $0x1
    2d63:	e8 5a 10 00 00       	call   3dc2 <printf>
    2d68:	83 c4 10             	add    $0x10,%esp
}
    2d6b:	90                   	nop
    2d6c:	c9                   	leave  
    2d6d:	c3                   	ret    

00002d6e <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2d6e:	55                   	push   %ebp
    2d6f:	89 e5                	mov    %esp,%ebp
    2d71:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    2d74:	83 ec 08             	sub    $0x8,%esp
    2d77:	68 56 70 00 00       	push   $0x7056
    2d7c:	6a 01                	push   $0x1
    2d7e:	e8 3f 10 00 00       	call   3dc2 <printf>
    2d83:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2d86:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2d8d:	eb 1d                	jmp    2dac <forktest+0x3e>
    pid = fork();
    2d8f:	e8 67 0e 00 00       	call   3bfb <fork>
    2d94:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    2d97:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d9b:	78 1a                	js     2db7 <forktest+0x49>
      break;
    if(pid == 0)
    2d9d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2da1:	75 05                	jne    2da8 <forktest+0x3a>
      exit();
    2da3:	e8 5b 0e 00 00       	call   3c03 <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2da8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2dac:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    2db3:	7e da                	jle    2d8f <forktest+0x21>
    2db5:	eb 01                	jmp    2db8 <forktest+0x4a>
    pid = fork();
    if(pid < 0)
      break;
    2db7:	90                   	nop
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    2db8:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    2dbf:	75 3b                	jne    2dfc <forktest+0x8e>
    printf(1, "fork claimed to work 1000 times!\n");
    2dc1:	83 ec 08             	sub    $0x8,%esp
    2dc4:	68 64 70 00 00       	push   $0x7064
    2dc9:	6a 01                	push   $0x1
    2dcb:	e8 f2 0f 00 00       	call   3dc2 <printf>
    2dd0:	83 c4 10             	add    $0x10,%esp
    exit();
    2dd3:	e8 2b 0e 00 00       	call   3c03 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    2dd8:	e8 2e 0e 00 00       	call   3c0b <wait>
    2ddd:	85 c0                	test   %eax,%eax
    2ddf:	79 17                	jns    2df8 <forktest+0x8a>
      printf(1, "wait stopped early\n");
    2de1:	83 ec 08             	sub    $0x8,%esp
    2de4:	68 86 70 00 00       	push   $0x7086
    2de9:	6a 01                	push   $0x1
    2deb:	e8 d2 0f 00 00       	call   3dc2 <printf>
    2df0:	83 c4 10             	add    $0x10,%esp
      exit();
    2df3:	e8 0b 0e 00 00       	call   3c03 <exit>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
    2df8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2dfc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e00:	7f d6                	jg     2dd8 <forktest+0x6a>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
    2e02:	e8 04 0e 00 00       	call   3c0b <wait>
    2e07:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e0a:	74 17                	je     2e23 <forktest+0xb5>
    printf(1, "wait got too many\n");
    2e0c:	83 ec 08             	sub    $0x8,%esp
    2e0f:	68 9a 70 00 00       	push   $0x709a
    2e14:	6a 01                	push   $0x1
    2e16:	e8 a7 0f 00 00       	call   3dc2 <printf>
    2e1b:	83 c4 10             	add    $0x10,%esp
    exit();
    2e1e:	e8 e0 0d 00 00       	call   3c03 <exit>
  }
  
  printf(1, "fork test OK\n");
    2e23:	83 ec 08             	sub    $0x8,%esp
    2e26:	68 ad 70 00 00       	push   $0x70ad
    2e2b:	6a 01                	push   $0x1
    2e2d:	e8 90 0f 00 00       	call   3dc2 <printf>
    2e32:	83 c4 10             	add    $0x10,%esp
}
    2e35:	90                   	nop
    2e36:	c9                   	leave  
    2e37:	c3                   	ret    

00002e38 <sbrktest>:

void
sbrktest(void)
{
    2e38:	55                   	push   %ebp
    2e39:	89 e5                	mov    %esp,%ebp
    2e3b:	53                   	push   %ebx
    2e3c:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2e3f:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    2e44:	83 ec 08             	sub    $0x8,%esp
    2e47:	68 bb 70 00 00       	push   $0x70bb
    2e4c:	50                   	push   %eax
    2e4d:	e8 70 0f 00 00       	call   3dc2 <printf>
    2e52:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    2e55:	83 ec 0c             	sub    $0xc,%esp
    2e58:	6a 00                	push   $0x0
    2e5a:	e8 2c 0e 00 00       	call   3c8b <sbrk>
    2e5f:	83 c4 10             	add    $0x10,%esp
    2e62:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2e65:	83 ec 0c             	sub    $0xc,%esp
    2e68:	6a 00                	push   $0x0
    2e6a:	e8 1c 0e 00 00       	call   3c8b <sbrk>
    2e6f:	83 c4 10             	add    $0x10,%esp
    2e72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    2e75:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2e7c:	eb 4f                	jmp    2ecd <sbrktest+0x95>
    b = sbrk(1);
    2e7e:	83 ec 0c             	sub    $0xc,%esp
    2e81:	6a 01                	push   $0x1
    2e83:	e8 03 0e 00 00       	call   3c8b <sbrk>
    2e88:	83 c4 10             	add    $0x10,%esp
    2e8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(b != a){
    2e8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2e91:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2e94:	74 24                	je     2eba <sbrktest+0x82>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2e96:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    2e9b:	83 ec 0c             	sub    $0xc,%esp
    2e9e:	ff 75 e8             	pushl  -0x18(%ebp)
    2ea1:	ff 75 f4             	pushl  -0xc(%ebp)
    2ea4:	ff 75 f0             	pushl  -0x10(%ebp)
    2ea7:	68 c6 70 00 00       	push   $0x70c6
    2eac:	50                   	push   %eax
    2ead:	e8 10 0f 00 00       	call   3dc2 <printf>
    2eb2:	83 c4 20             	add    $0x20,%esp
      exit();
    2eb5:	e8 49 0d 00 00       	call   3c03 <exit>
    }
    *b = 1;
    2eba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2ebd:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    2ec0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2ec3:	83 c0 01             	add    $0x1,%eax
    2ec6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){ 
    2ec9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2ecd:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    2ed4:	7e a8                	jle    2e7e <sbrktest+0x46>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2ed6:	e8 20 0d 00 00       	call   3bfb <fork>
    2edb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    2ede:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2ee2:	79 1b                	jns    2eff <sbrktest+0xc7>
    printf(stdout, "sbrk test fork failed\n");
    2ee4:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    2ee9:	83 ec 08             	sub    $0x8,%esp
    2eec:	68 e1 70 00 00       	push   $0x70e1
    2ef1:	50                   	push   %eax
    2ef2:	e8 cb 0e 00 00       	call   3dc2 <printf>
    2ef7:	83 c4 10             	add    $0x10,%esp
    exit();
    2efa:	e8 04 0d 00 00       	call   3c03 <exit>
  }
  c = sbrk(1);
    2eff:	83 ec 0c             	sub    $0xc,%esp
    2f02:	6a 01                	push   $0x1
    2f04:	e8 82 0d 00 00       	call   3c8b <sbrk>
    2f09:	83 c4 10             	add    $0x10,%esp
    2f0c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  c = sbrk(1);
    2f0f:	83 ec 0c             	sub    $0xc,%esp
    2f12:	6a 01                	push   $0x1
    2f14:	e8 72 0d 00 00       	call   3c8b <sbrk>
    2f19:	83 c4 10             	add    $0x10,%esp
    2f1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a + 1){
    2f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f22:	83 c0 01             	add    $0x1,%eax
    2f25:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    2f28:	74 1b                	je     2f45 <sbrktest+0x10d>
    printf(stdout, "sbrk test failed post-fork\n");
    2f2a:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    2f2f:	83 ec 08             	sub    $0x8,%esp
    2f32:	68 f8 70 00 00       	push   $0x70f8
    2f37:	50                   	push   %eax
    2f38:	e8 85 0e 00 00       	call   3dc2 <printf>
    2f3d:	83 c4 10             	add    $0x10,%esp
    exit();
    2f40:	e8 be 0c 00 00       	call   3c03 <exit>
  }
  if(pid == 0)
    2f45:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2f49:	75 05                	jne    2f50 <sbrktest+0x118>
    exit();
    2f4b:	e8 b3 0c 00 00       	call   3c03 <exit>
  wait();
    2f50:	e8 b6 0c 00 00       	call   3c0b <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2f55:	83 ec 0c             	sub    $0xc,%esp
    2f58:	6a 00                	push   $0x0
    2f5a:	e8 2c 0d 00 00       	call   3c8b <sbrk>
    2f5f:	83 c4 10             	add    $0x10,%esp
    2f62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    2f65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f68:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f6d:	29 c2                	sub    %eax,%edx
    2f6f:	89 d0                	mov    %edx,%eax
    2f71:	89 45 dc             	mov    %eax,-0x24(%ebp)
  p = sbrk(amt);
    2f74:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2f77:	83 ec 0c             	sub    $0xc,%esp
    2f7a:	50                   	push   %eax
    2f7b:	e8 0b 0d 00 00       	call   3c8b <sbrk>
    2f80:	83 c4 10             	add    $0x10,%esp
    2f83:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (p != a) { 
    2f86:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2f89:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2f8c:	74 1b                	je     2fa9 <sbrktest+0x171>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2f8e:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    2f93:	83 ec 08             	sub    $0x8,%esp
    2f96:	68 14 71 00 00       	push   $0x7114
    2f9b:	50                   	push   %eax
    2f9c:	e8 21 0e 00 00       	call   3dc2 <printf>
    2fa1:	83 c4 10             	add    $0x10,%esp
    exit();
    2fa4:	e8 5a 0c 00 00       	call   3c03 <exit>
  }
  lastaddr = (char*) (BIG-1);
    2fa9:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
  *lastaddr = 99;
    2fb0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2fb3:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    2fb6:	83 ec 0c             	sub    $0xc,%esp
    2fb9:	6a 00                	push   $0x0
    2fbb:	e8 cb 0c 00 00       	call   3c8b <sbrk>
    2fc0:	83 c4 10             	add    $0x10,%esp
    2fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    2fc6:	83 ec 0c             	sub    $0xc,%esp
    2fc9:	68 00 f0 ff ff       	push   $0xfffff000
    2fce:	e8 b8 0c 00 00       	call   3c8b <sbrk>
    2fd3:	83 c4 10             	add    $0x10,%esp
    2fd6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c == (char*)0xffffffff){
    2fd9:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    2fdd:	75 1b                	jne    2ffa <sbrktest+0x1c2>
    printf(stdout, "sbrk could not deallocate\n");
    2fdf:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    2fe4:	83 ec 08             	sub    $0x8,%esp
    2fe7:	68 52 71 00 00       	push   $0x7152
    2fec:	50                   	push   %eax
    2fed:	e8 d0 0d 00 00       	call   3dc2 <printf>
    2ff2:	83 c4 10             	add    $0x10,%esp
    exit();
    2ff5:	e8 09 0c 00 00       	call   3c03 <exit>
  }
  c = sbrk(0);
    2ffa:	83 ec 0c             	sub    $0xc,%esp
    2ffd:	6a 00                	push   $0x0
    2fff:	e8 87 0c 00 00       	call   3c8b <sbrk>
    3004:	83 c4 10             	add    $0x10,%esp
    3007:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a - 4096){
    300a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    300d:	2d 00 10 00 00       	sub    $0x1000,%eax
    3012:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    3015:	74 1e                	je     3035 <sbrktest+0x1fd>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3017:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    301c:	ff 75 e0             	pushl  -0x20(%ebp)
    301f:	ff 75 f4             	pushl  -0xc(%ebp)
    3022:	68 70 71 00 00       	push   $0x7170
    3027:	50                   	push   %eax
    3028:	e8 95 0d 00 00       	call   3dc2 <printf>
    302d:	83 c4 10             	add    $0x10,%esp
    exit();
    3030:	e8 ce 0b 00 00       	call   3c03 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3035:	83 ec 0c             	sub    $0xc,%esp
    3038:	6a 00                	push   $0x0
    303a:	e8 4c 0c 00 00       	call   3c8b <sbrk>
    303f:	83 c4 10             	add    $0x10,%esp
    3042:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    3045:	83 ec 0c             	sub    $0xc,%esp
    3048:	68 00 10 00 00       	push   $0x1000
    304d:	e8 39 0c 00 00       	call   3c8b <sbrk>
    3052:	83 c4 10             	add    $0x10,%esp
    3055:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    3058:	8b 45 e0             	mov    -0x20(%ebp),%eax
    305b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    305e:	75 1b                	jne    307b <sbrktest+0x243>
    3060:	83 ec 0c             	sub    $0xc,%esp
    3063:	6a 00                	push   $0x0
    3065:	e8 21 0c 00 00       	call   3c8b <sbrk>
    306a:	83 c4 10             	add    $0x10,%esp
    306d:	89 c2                	mov    %eax,%edx
    306f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3072:	05 00 10 00 00       	add    $0x1000,%eax
    3077:	39 c2                	cmp    %eax,%edx
    3079:	74 1e                	je     3099 <sbrktest+0x261>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    307b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3080:	ff 75 e0             	pushl  -0x20(%ebp)
    3083:	ff 75 f4             	pushl  -0xc(%ebp)
    3086:	68 a8 71 00 00       	push   $0x71a8
    308b:	50                   	push   %eax
    308c:	e8 31 0d 00 00       	call   3dc2 <printf>
    3091:	83 c4 10             	add    $0x10,%esp
    exit();
    3094:	e8 6a 0b 00 00       	call   3c03 <exit>
  }
  if(*lastaddr == 99){
    3099:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    309c:	0f b6 00             	movzbl (%eax),%eax
    309f:	3c 63                	cmp    $0x63,%al
    30a1:	75 1b                	jne    30be <sbrktest+0x286>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    30a3:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    30a8:	83 ec 08             	sub    $0x8,%esp
    30ab:	68 d0 71 00 00       	push   $0x71d0
    30b0:	50                   	push   %eax
    30b1:	e8 0c 0d 00 00       	call   3dc2 <printf>
    30b6:	83 c4 10             	add    $0x10,%esp
    exit();
    30b9:	e8 45 0b 00 00       	call   3c03 <exit>
  }

  a = sbrk(0);
    30be:	83 ec 0c             	sub    $0xc,%esp
    30c1:	6a 00                	push   $0x0
    30c3:	e8 c3 0b 00 00       	call   3c8b <sbrk>
    30c8:	83 c4 10             	add    $0x10,%esp
    30cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    30ce:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    30d1:	83 ec 0c             	sub    $0xc,%esp
    30d4:	6a 00                	push   $0x0
    30d6:	e8 b0 0b 00 00       	call   3c8b <sbrk>
    30db:	83 c4 10             	add    $0x10,%esp
    30de:	29 c3                	sub    %eax,%ebx
    30e0:	89 d8                	mov    %ebx,%eax
    30e2:	83 ec 0c             	sub    $0xc,%esp
    30e5:	50                   	push   %eax
    30e6:	e8 a0 0b 00 00       	call   3c8b <sbrk>
    30eb:	83 c4 10             	add    $0x10,%esp
    30ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a){
    30f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    30f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    30f7:	74 1e                	je     3117 <sbrktest+0x2df>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    30f9:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    30fe:	ff 75 e0             	pushl  -0x20(%ebp)
    3101:	ff 75 f4             	pushl  -0xc(%ebp)
    3104:	68 00 72 00 00       	push   $0x7200
    3109:	50                   	push   %eax
    310a:	e8 b3 0c 00 00       	call   3dc2 <printf>
    310f:	83 c4 10             	add    $0x10,%esp
    exit();
    3112:	e8 ec 0a 00 00       	call   3c03 <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3117:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    311e:	eb 76                	jmp    3196 <sbrktest+0x35e>
    ppid = getpid();
    3120:	e8 5e 0b 00 00       	call   3c83 <getpid>
    3125:	89 45 d0             	mov    %eax,-0x30(%ebp)
    pid = fork();
    3128:	e8 ce 0a 00 00       	call   3bfb <fork>
    312d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pid < 0){
    3130:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3134:	79 1b                	jns    3151 <sbrktest+0x319>
      printf(stdout, "fork failed\n");
    3136:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    313b:	83 ec 08             	sub    $0x8,%esp
    313e:	68 c9 61 00 00       	push   $0x61c9
    3143:	50                   	push   %eax
    3144:	e8 79 0c 00 00       	call   3dc2 <printf>
    3149:	83 c4 10             	add    $0x10,%esp
      exit();
    314c:	e8 b2 0a 00 00       	call   3c03 <exit>
    }
    if(pid == 0){
    3151:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3155:	75 33                	jne    318a <sbrktest+0x352>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3157:	8b 45 f4             	mov    -0xc(%ebp),%eax
    315a:	0f b6 00             	movzbl (%eax),%eax
    315d:	0f be d0             	movsbl %al,%edx
    3160:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3165:	52                   	push   %edx
    3166:	ff 75 f4             	pushl  -0xc(%ebp)
    3169:	68 21 72 00 00       	push   $0x7221
    316e:	50                   	push   %eax
    316f:	e8 4e 0c 00 00       	call   3dc2 <printf>
    3174:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    3177:	83 ec 0c             	sub    $0xc,%esp
    317a:	ff 75 d0             	pushl  -0x30(%ebp)
    317d:	e8 b1 0a 00 00       	call   3c33 <kill>
    3182:	83 c4 10             	add    $0x10,%esp
      exit();
    3185:	e8 79 0a 00 00       	call   3c03 <exit>
    }
    wait();
    318a:	e8 7c 0a 00 00       	call   3c0b <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    318f:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    3196:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    319d:	76 81                	jbe    3120 <sbrktest+0x2e8>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    319f:	83 ec 0c             	sub    $0xc,%esp
    31a2:	8d 45 c8             	lea    -0x38(%ebp),%eax
    31a5:	50                   	push   %eax
    31a6:	e8 68 0a 00 00       	call   3c13 <pipe>
    31ab:	83 c4 10             	add    $0x10,%esp
    31ae:	85 c0                	test   %eax,%eax
    31b0:	74 17                	je     31c9 <sbrktest+0x391>
    printf(1, "pipe() failed\n");
    31b2:	83 ec 08             	sub    $0x8,%esp
    31b5:	68 1d 61 00 00       	push   $0x611d
    31ba:	6a 01                	push   $0x1
    31bc:	e8 01 0c 00 00       	call   3dc2 <printf>
    31c1:	83 c4 10             	add    $0x10,%esp
    exit();
    31c4:	e8 3a 0a 00 00       	call   3c03 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    31c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    31d0:	e9 88 00 00 00       	jmp    325d <sbrktest+0x425>
    if((pids[i] = fork()) == 0){
    31d5:	e8 21 0a 00 00       	call   3bfb <fork>
    31da:	89 c2                	mov    %eax,%edx
    31dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31df:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
    31e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31e6:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    31ea:	85 c0                	test   %eax,%eax
    31ec:	75 4a                	jne    3238 <sbrktest+0x400>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    31ee:	83 ec 0c             	sub    $0xc,%esp
    31f1:	6a 00                	push   $0x0
    31f3:	e8 93 0a 00 00       	call   3c8b <sbrk>
    31f8:	83 c4 10             	add    $0x10,%esp
    31fb:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3200:	29 c2                	sub    %eax,%edx
    3202:	89 d0                	mov    %edx,%eax
    3204:	83 ec 0c             	sub    $0xc,%esp
    3207:	50                   	push   %eax
    3208:	e8 7e 0a 00 00       	call   3c8b <sbrk>
    320d:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    3210:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3213:	83 ec 04             	sub    $0x4,%esp
    3216:	6a 01                	push   $0x1
    3218:	68 82 61 00 00       	push   $0x6182
    321d:	50                   	push   %eax
    321e:	e8 00 0a 00 00       	call   3c23 <write>
    3223:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3226:	83 ec 0c             	sub    $0xc,%esp
    3229:	68 e8 03 00 00       	push   $0x3e8
    322e:	e8 60 0a 00 00       	call   3c93 <sleep>
    3233:	83 c4 10             	add    $0x10,%esp
    3236:	eb ee                	jmp    3226 <sbrktest+0x3ee>
    }
    if(pids[i] != -1)
    3238:	8b 45 f0             	mov    -0x10(%ebp),%eax
    323b:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    323f:	83 f8 ff             	cmp    $0xffffffff,%eax
    3242:	74 15                	je     3259 <sbrktest+0x421>
      read(fds[0], &scratch, 1);
    3244:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3247:	83 ec 04             	sub    $0x4,%esp
    324a:	6a 01                	push   $0x1
    324c:	8d 55 9f             	lea    -0x61(%ebp),%edx
    324f:	52                   	push   %edx
    3250:	50                   	push   %eax
    3251:	e8 c5 09 00 00       	call   3c1b <read>
    3256:	83 c4 10             	add    $0x10,%esp
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3259:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    325d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3260:	83 f8 09             	cmp    $0x9,%eax
    3263:	0f 86 6c ff ff ff    	jbe    31d5 <sbrktest+0x39d>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3269:	83 ec 0c             	sub    $0xc,%esp
    326c:	68 00 10 00 00       	push   $0x1000
    3271:	e8 15 0a 00 00       	call   3c8b <sbrk>
    3276:	83 c4 10             	add    $0x10,%esp
    3279:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    327c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3283:	eb 2b                	jmp    32b0 <sbrktest+0x478>
    if(pids[i] == -1)
    3285:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3288:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    328c:	83 f8 ff             	cmp    $0xffffffff,%eax
    328f:	74 1a                	je     32ab <sbrktest+0x473>
      continue;
    kill(pids[i]);
    3291:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3294:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3298:	83 ec 0c             	sub    $0xc,%esp
    329b:	50                   	push   %eax
    329c:	e8 92 09 00 00       	call   3c33 <kill>
    32a1:	83 c4 10             	add    $0x10,%esp
    wait();
    32a4:	e8 62 09 00 00       	call   3c0b <wait>
    32a9:	eb 01                	jmp    32ac <sbrktest+0x474>
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
      continue;
    32ab:	90                   	nop
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    32ac:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    32b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32b3:	83 f8 09             	cmp    $0x9,%eax
    32b6:	76 cd                	jbe    3285 <sbrktest+0x44d>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    32b8:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    32bc:	75 1b                	jne    32d9 <sbrktest+0x4a1>
    printf(stdout, "failed sbrk leaked memory\n");
    32be:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    32c3:	83 ec 08             	sub    $0x8,%esp
    32c6:	68 3a 72 00 00       	push   $0x723a
    32cb:	50                   	push   %eax
    32cc:	e8 f1 0a 00 00       	call   3dc2 <printf>
    32d1:	83 c4 10             	add    $0x10,%esp
    exit();
    32d4:	e8 2a 09 00 00       	call   3c03 <exit>
  }

  if(sbrk(0) > oldbrk)
    32d9:	83 ec 0c             	sub    $0xc,%esp
    32dc:	6a 00                	push   $0x0
    32de:	e8 a8 09 00 00       	call   3c8b <sbrk>
    32e3:	83 c4 10             	add    $0x10,%esp
    32e6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    32e9:	76 20                	jbe    330b <sbrktest+0x4d3>
    sbrk(-(sbrk(0) - oldbrk));
    32eb:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    32ee:	83 ec 0c             	sub    $0xc,%esp
    32f1:	6a 00                	push   $0x0
    32f3:	e8 93 09 00 00       	call   3c8b <sbrk>
    32f8:	83 c4 10             	add    $0x10,%esp
    32fb:	29 c3                	sub    %eax,%ebx
    32fd:	89 d8                	mov    %ebx,%eax
    32ff:	83 ec 0c             	sub    $0xc,%esp
    3302:	50                   	push   %eax
    3303:	e8 83 09 00 00       	call   3c8b <sbrk>
    3308:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    330b:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3310:	83 ec 08             	sub    $0x8,%esp
    3313:	68 55 72 00 00       	push   $0x7255
    3318:	50                   	push   %eax
    3319:	e8 a4 0a 00 00       	call   3dc2 <printf>
    331e:	83 c4 10             	add    $0x10,%esp
}
    3321:	90                   	nop
    3322:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3325:	c9                   	leave  
    3326:	c3                   	ret    

00003327 <validateint>:

void
validateint(int *p)
{
    3327:	55                   	push   %ebp
    3328:	89 e5                	mov    %esp,%ebp
    332a:	53                   	push   %ebx
    332b:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    332e:	b8 0d 00 00 00       	mov    $0xd,%eax
    3333:	8b 55 08             	mov    0x8(%ebp),%edx
    3336:	89 d1                	mov    %edx,%ecx
    3338:	89 e3                	mov    %esp,%ebx
    333a:	89 cc                	mov    %ecx,%esp
    333c:	cd 40                	int    $0x40
    333e:	89 dc                	mov    %ebx,%esp
    3340:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3343:	90                   	nop
    3344:	83 c4 10             	add    $0x10,%esp
    3347:	5b                   	pop    %ebx
    3348:	5d                   	pop    %ebp
    3349:	c3                   	ret    

0000334a <validatetest>:

void
validatetest(void)
{
    334a:	55                   	push   %ebp
    334b:	89 e5                	mov    %esp,%ebp
    334d:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3350:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3355:	83 ec 08             	sub    $0x8,%esp
    3358:	68 63 72 00 00       	push   $0x7263
    335d:	50                   	push   %eax
    335e:	e8 5f 0a 00 00       	call   3dc2 <printf>
    3363:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    3366:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    336d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3374:	e9 8a 00 00 00       	jmp    3403 <validatetest+0xb9>
    if((pid = fork()) == 0){
    3379:	e8 7d 08 00 00       	call   3bfb <fork>
    337e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3381:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3385:	75 14                	jne    339b <validatetest+0x51>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    3387:	8b 45 f4             	mov    -0xc(%ebp),%eax
    338a:	83 ec 0c             	sub    $0xc,%esp
    338d:	50                   	push   %eax
    338e:	e8 94 ff ff ff       	call   3327 <validateint>
    3393:	83 c4 10             	add    $0x10,%esp
      exit();
    3396:	e8 68 08 00 00       	call   3c03 <exit>
    }
    sleep(0);
    339b:	83 ec 0c             	sub    $0xc,%esp
    339e:	6a 00                	push   $0x0
    33a0:	e8 ee 08 00 00       	call   3c93 <sleep>
    33a5:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    33a8:	83 ec 0c             	sub    $0xc,%esp
    33ab:	6a 00                	push   $0x0
    33ad:	e8 e1 08 00 00       	call   3c93 <sleep>
    33b2:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    33b5:	83 ec 0c             	sub    $0xc,%esp
    33b8:	ff 75 ec             	pushl  -0x14(%ebp)
    33bb:	e8 73 08 00 00       	call   3c33 <kill>
    33c0:	83 c4 10             	add    $0x10,%esp
    wait();
    33c3:	e8 43 08 00 00       	call   3c0b <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    33c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33cb:	83 ec 08             	sub    $0x8,%esp
    33ce:	50                   	push   %eax
    33cf:	68 72 72 00 00       	push   $0x7272
    33d4:	e8 8a 08 00 00       	call   3c63 <link>
    33d9:	83 c4 10             	add    $0x10,%esp
    33dc:	83 f8 ff             	cmp    $0xffffffff,%eax
    33df:	74 1b                	je     33fc <validatetest+0xb2>
      printf(stdout, "link should not succeed\n");
    33e1:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    33e6:	83 ec 08             	sub    $0x8,%esp
    33e9:	68 7d 72 00 00       	push   $0x727d
    33ee:	50                   	push   %eax
    33ef:	e8 ce 09 00 00       	call   3dc2 <printf>
    33f4:	83 c4 10             	add    $0x10,%esp
      exit();
    33f7:	e8 07 08 00 00       	call   3c03 <exit>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    33fc:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    3403:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3406:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    3409:	0f 86 6a ff ff ff    	jbe    3379 <validatetest+0x2f>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    340f:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3414:	83 ec 08             	sub    $0x8,%esp
    3417:	68 96 72 00 00       	push   $0x7296
    341c:	50                   	push   %eax
    341d:	e8 a0 09 00 00       	call   3dc2 <printf>
    3422:	83 c4 10             	add    $0x10,%esp
}
    3425:	90                   	nop
    3426:	c9                   	leave  
    3427:	c3                   	ret    

00003428 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3428:	55                   	push   %ebp
    3429:	89 e5                	mov    %esp,%ebp
    342b:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    342e:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3433:	83 ec 08             	sub    $0x8,%esp
    3436:	68 a3 72 00 00       	push   $0x72a3
    343b:	50                   	push   %eax
    343c:	e8 81 09 00 00       	call   3dc2 <printf>
    3441:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3444:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    344b:	eb 2e                	jmp    347b <bsstest+0x53>
    if(uninit[i] != '\0'){
    344d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3450:	05 00 bd 00 00       	add    $0xbd00,%eax
    3455:	0f b6 00             	movzbl (%eax),%eax
    3458:	84 c0                	test   %al,%al
    345a:	74 1b                	je     3477 <bsstest+0x4f>
      printf(stdout, "bss test failed\n");
    345c:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3461:	83 ec 08             	sub    $0x8,%esp
    3464:	68 ad 72 00 00       	push   $0x72ad
    3469:	50                   	push   %eax
    346a:	e8 53 09 00 00       	call   3dc2 <printf>
    346f:	83 c4 10             	add    $0x10,%esp
      exit();
    3472:	e8 8c 07 00 00       	call   3c03 <exit>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    3477:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    347b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    347e:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3483:	76 c8                	jbe    344d <bsstest+0x25>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    3485:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    348a:	83 ec 08             	sub    $0x8,%esp
    348d:	68 be 72 00 00       	push   $0x72be
    3492:	50                   	push   %eax
    3493:	e8 2a 09 00 00       	call   3dc2 <printf>
    3498:	83 c4 10             	add    $0x10,%esp
}
    349b:	90                   	nop
    349c:	c9                   	leave  
    349d:	c3                   	ret    

0000349e <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    349e:	55                   	push   %ebp
    349f:	89 e5                	mov    %esp,%ebp
    34a1:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    34a4:	83 ec 0c             	sub    $0xc,%esp
    34a7:	68 cb 72 00 00       	push   $0x72cb
    34ac:	e8 a2 07 00 00       	call   3c53 <unlink>
    34b1:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    34b4:	e8 42 07 00 00       	call   3bfb <fork>
    34b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    34bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34c0:	0f 85 97 00 00 00    	jne    355d <bigargtest+0xbf>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    34c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    34cd:	eb 12                	jmp    34e1 <bigargtest+0x43>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    34cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    34d2:	c7 04 85 60 bc 00 00 	movl   $0x72d8,0xbc60(,%eax,4)
    34d9:	d8 72 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    34dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    34e1:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    34e5:	7e e8                	jle    34cf <bigargtest+0x31>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    34e7:	c7 05 dc bc 00 00 00 	movl   $0x0,0xbcdc
    34ee:	00 00 00 
    printf(stdout, "bigarg test\n");
    34f1:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    34f6:	83 ec 08             	sub    $0x8,%esp
    34f9:	68 b5 73 00 00       	push   $0x73b5
    34fe:	50                   	push   %eax
    34ff:	e8 be 08 00 00       	call   3dc2 <printf>
    3504:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    3507:	83 ec 08             	sub    $0x8,%esp
    350a:	68 60 bc 00 00       	push   $0xbc60
    350f:	68 dc 5d 00 00       	push   $0x5ddc
    3514:	e8 22 07 00 00       	call   3c3b <exec>
    3519:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    351c:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3521:	83 ec 08             	sub    $0x8,%esp
    3524:	68 c2 73 00 00       	push   $0x73c2
    3529:	50                   	push   %eax
    352a:	e8 93 08 00 00       	call   3dc2 <printf>
    352f:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    3532:	83 ec 08             	sub    $0x8,%esp
    3535:	68 00 02 00 00       	push   $0x200
    353a:	68 cb 72 00 00       	push   $0x72cb
    353f:	e8 ff 06 00 00       	call   3c43 <open>
    3544:	83 c4 10             	add    $0x10,%esp
    3547:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    354a:	83 ec 0c             	sub    $0xc,%esp
    354d:	ff 75 ec             	pushl  -0x14(%ebp)
    3550:	e8 d6 06 00 00       	call   3c2b <close>
    3555:	83 c4 10             	add    $0x10,%esp
    exit();
    3558:	e8 a6 06 00 00       	call   3c03 <exit>
  } else if(pid < 0){
    355d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3561:	79 1b                	jns    357e <bigargtest+0xe0>
    printf(stdout, "bigargtest: fork failed\n");
    3563:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    3568:	83 ec 08             	sub    $0x8,%esp
    356b:	68 d2 73 00 00       	push   $0x73d2
    3570:	50                   	push   %eax
    3571:	e8 4c 08 00 00       	call   3dc2 <printf>
    3576:	83 c4 10             	add    $0x10,%esp
    exit();
    3579:	e8 85 06 00 00       	call   3c03 <exit>
  }
  wait();
    357e:	e8 88 06 00 00       	call   3c0b <wait>
  fd = open("bigarg-ok", 0);
    3583:	83 ec 08             	sub    $0x8,%esp
    3586:	6a 00                	push   $0x0
    3588:	68 cb 72 00 00       	push   $0x72cb
    358d:	e8 b1 06 00 00       	call   3c43 <open>
    3592:	83 c4 10             	add    $0x10,%esp
    3595:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3598:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    359c:	79 1b                	jns    35b9 <bigargtest+0x11b>
    printf(stdout, "bigarg test failed!\n");
    359e:	a1 f4 7f 00 00       	mov    0x7ff4,%eax
    35a3:	83 ec 08             	sub    $0x8,%esp
    35a6:	68 eb 73 00 00       	push   $0x73eb
    35ab:	50                   	push   %eax
    35ac:	e8 11 08 00 00       	call   3dc2 <printf>
    35b1:	83 c4 10             	add    $0x10,%esp
    exit();
    35b4:	e8 4a 06 00 00       	call   3c03 <exit>
  }
  close(fd);
    35b9:	83 ec 0c             	sub    $0xc,%esp
    35bc:	ff 75 ec             	pushl  -0x14(%ebp)
    35bf:	e8 67 06 00 00       	call   3c2b <close>
    35c4:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    35c7:	83 ec 0c             	sub    $0xc,%esp
    35ca:	68 cb 72 00 00       	push   $0x72cb
    35cf:	e8 7f 06 00 00       	call   3c53 <unlink>
    35d4:	83 c4 10             	add    $0x10,%esp
}
    35d7:	90                   	nop
    35d8:	c9                   	leave  
    35d9:	c3                   	ret    

000035da <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    35da:	55                   	push   %ebp
    35db:	89 e5                	mov    %esp,%ebp
    35dd:	53                   	push   %ebx
    35de:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    35e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    35e8:	83 ec 08             	sub    $0x8,%esp
    35eb:	68 00 74 00 00       	push   $0x7400
    35f0:	6a 01                	push   $0x1
    35f2:	e8 cb 07 00 00       	call   3dc2 <printf>
    35f7:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    35fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    3601:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3605:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3608:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    360d:	89 c8                	mov    %ecx,%eax
    360f:	f7 ea                	imul   %edx
    3611:	c1 fa 06             	sar    $0x6,%edx
    3614:	89 c8                	mov    %ecx,%eax
    3616:	c1 f8 1f             	sar    $0x1f,%eax
    3619:	29 c2                	sub    %eax,%edx
    361b:	89 d0                	mov    %edx,%eax
    361d:	83 c0 30             	add    $0x30,%eax
    3620:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3623:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3626:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    362b:	89 d8                	mov    %ebx,%eax
    362d:	f7 ea                	imul   %edx
    362f:	c1 fa 06             	sar    $0x6,%edx
    3632:	89 d8                	mov    %ebx,%eax
    3634:	c1 f8 1f             	sar    $0x1f,%eax
    3637:	89 d1                	mov    %edx,%ecx
    3639:	29 c1                	sub    %eax,%ecx
    363b:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3641:	29 c3                	sub    %eax,%ebx
    3643:	89 d9                	mov    %ebx,%ecx
    3645:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    364a:	89 c8                	mov    %ecx,%eax
    364c:	f7 ea                	imul   %edx
    364e:	c1 fa 05             	sar    $0x5,%edx
    3651:	89 c8                	mov    %ecx,%eax
    3653:	c1 f8 1f             	sar    $0x1f,%eax
    3656:	29 c2                	sub    %eax,%edx
    3658:	89 d0                	mov    %edx,%eax
    365a:	83 c0 30             	add    $0x30,%eax
    365d:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3660:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3663:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3668:	89 d8                	mov    %ebx,%eax
    366a:	f7 ea                	imul   %edx
    366c:	c1 fa 05             	sar    $0x5,%edx
    366f:	89 d8                	mov    %ebx,%eax
    3671:	c1 f8 1f             	sar    $0x1f,%eax
    3674:	89 d1                	mov    %edx,%ecx
    3676:	29 c1                	sub    %eax,%ecx
    3678:	6b c1 64             	imul   $0x64,%ecx,%eax
    367b:	29 c3                	sub    %eax,%ebx
    367d:	89 d9                	mov    %ebx,%ecx
    367f:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3684:	89 c8                	mov    %ecx,%eax
    3686:	f7 ea                	imul   %edx
    3688:	c1 fa 02             	sar    $0x2,%edx
    368b:	89 c8                	mov    %ecx,%eax
    368d:	c1 f8 1f             	sar    $0x1f,%eax
    3690:	29 c2                	sub    %eax,%edx
    3692:	89 d0                	mov    %edx,%eax
    3694:	83 c0 30             	add    $0x30,%eax
    3697:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    369a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    369d:	ba 67 66 66 66       	mov    $0x66666667,%edx
    36a2:	89 c8                	mov    %ecx,%eax
    36a4:	f7 ea                	imul   %edx
    36a6:	c1 fa 02             	sar    $0x2,%edx
    36a9:	89 c8                	mov    %ecx,%eax
    36ab:	c1 f8 1f             	sar    $0x1f,%eax
    36ae:	29 c2                	sub    %eax,%edx
    36b0:	89 d0                	mov    %edx,%eax
    36b2:	c1 e0 02             	shl    $0x2,%eax
    36b5:	01 d0                	add    %edx,%eax
    36b7:	01 c0                	add    %eax,%eax
    36b9:	29 c1                	sub    %eax,%ecx
    36bb:	89 ca                	mov    %ecx,%edx
    36bd:	89 d0                	mov    %edx,%eax
    36bf:	83 c0 30             	add    $0x30,%eax
    36c2:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    36c5:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    36c9:	83 ec 04             	sub    $0x4,%esp
    36cc:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36cf:	50                   	push   %eax
    36d0:	68 0d 74 00 00       	push   $0x740d
    36d5:	6a 01                	push   $0x1
    36d7:	e8 e6 06 00 00       	call   3dc2 <printf>
    36dc:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    36df:	83 ec 08             	sub    $0x8,%esp
    36e2:	68 02 02 00 00       	push   $0x202
    36e7:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36ea:	50                   	push   %eax
    36eb:	e8 53 05 00 00       	call   3c43 <open>
    36f0:	83 c4 10             	add    $0x10,%esp
    36f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    36f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    36fa:	79 18                	jns    3714 <fsfull+0x13a>
      printf(1, "open %s failed\n", name);
    36fc:	83 ec 04             	sub    $0x4,%esp
    36ff:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3702:	50                   	push   %eax
    3703:	68 19 74 00 00       	push   $0x7419
    3708:	6a 01                	push   $0x1
    370a:	e8 b3 06 00 00       	call   3dc2 <printf>
    370f:	83 c4 10             	add    $0x10,%esp
      break;
    3712:	eb 6b                	jmp    377f <fsfull+0x1a5>
    }
    int total = 0;
    3714:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    371b:	83 ec 04             	sub    $0x4,%esp
    371e:	68 00 02 00 00       	push   $0x200
    3723:	68 20 e4 00 00       	push   $0xe420
    3728:	ff 75 e8             	pushl  -0x18(%ebp)
    372b:	e8 f3 04 00 00       	call   3c23 <write>
    3730:	83 c4 10             	add    $0x10,%esp
    3733:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    3736:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    373d:	7e 0c                	jle    374b <fsfull+0x171>
        break;
      total += cc;
    373f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3742:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    3745:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    }
    3749:	eb d0                	jmp    371b <fsfull+0x141>
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
    374b:	90                   	nop
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    374c:	83 ec 04             	sub    $0x4,%esp
    374f:	ff 75 ec             	pushl  -0x14(%ebp)
    3752:	68 29 74 00 00       	push   $0x7429
    3757:	6a 01                	push   $0x1
    3759:	e8 64 06 00 00       	call   3dc2 <printf>
    375e:	83 c4 10             	add    $0x10,%esp
    close(fd);
    3761:	83 ec 0c             	sub    $0xc,%esp
    3764:	ff 75 e8             	pushl  -0x18(%ebp)
    3767:	e8 bf 04 00 00       	call   3c2b <close>
    376c:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    376f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3773:	74 09                	je     377e <fsfull+0x1a4>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3775:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3779:	e9 83 fe ff ff       	jmp    3601 <fsfull+0x27>
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
    377e:	90                   	nop
  }

  while(nfiles >= 0){
    377f:	e9 db 00 00 00       	jmp    385f <fsfull+0x285>
    char name[64];
    name[0] = 'f';
    3784:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3788:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    378b:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3790:	89 c8                	mov    %ecx,%eax
    3792:	f7 ea                	imul   %edx
    3794:	c1 fa 06             	sar    $0x6,%edx
    3797:	89 c8                	mov    %ecx,%eax
    3799:	c1 f8 1f             	sar    $0x1f,%eax
    379c:	29 c2                	sub    %eax,%edx
    379e:	89 d0                	mov    %edx,%eax
    37a0:	83 c0 30             	add    $0x30,%eax
    37a3:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    37a6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    37a9:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    37ae:	89 d8                	mov    %ebx,%eax
    37b0:	f7 ea                	imul   %edx
    37b2:	c1 fa 06             	sar    $0x6,%edx
    37b5:	89 d8                	mov    %ebx,%eax
    37b7:	c1 f8 1f             	sar    $0x1f,%eax
    37ba:	89 d1                	mov    %edx,%ecx
    37bc:	29 c1                	sub    %eax,%ecx
    37be:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    37c4:	29 c3                	sub    %eax,%ebx
    37c6:	89 d9                	mov    %ebx,%ecx
    37c8:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    37cd:	89 c8                	mov    %ecx,%eax
    37cf:	f7 ea                	imul   %edx
    37d1:	c1 fa 05             	sar    $0x5,%edx
    37d4:	89 c8                	mov    %ecx,%eax
    37d6:	c1 f8 1f             	sar    $0x1f,%eax
    37d9:	29 c2                	sub    %eax,%edx
    37db:	89 d0                	mov    %edx,%eax
    37dd:	83 c0 30             	add    $0x30,%eax
    37e0:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    37e3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    37e6:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    37eb:	89 d8                	mov    %ebx,%eax
    37ed:	f7 ea                	imul   %edx
    37ef:	c1 fa 05             	sar    $0x5,%edx
    37f2:	89 d8                	mov    %ebx,%eax
    37f4:	c1 f8 1f             	sar    $0x1f,%eax
    37f7:	89 d1                	mov    %edx,%ecx
    37f9:	29 c1                	sub    %eax,%ecx
    37fb:	6b c1 64             	imul   $0x64,%ecx,%eax
    37fe:	29 c3                	sub    %eax,%ebx
    3800:	89 d9                	mov    %ebx,%ecx
    3802:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3807:	89 c8                	mov    %ecx,%eax
    3809:	f7 ea                	imul   %edx
    380b:	c1 fa 02             	sar    $0x2,%edx
    380e:	89 c8                	mov    %ecx,%eax
    3810:	c1 f8 1f             	sar    $0x1f,%eax
    3813:	29 c2                	sub    %eax,%edx
    3815:	89 d0                	mov    %edx,%eax
    3817:	83 c0 30             	add    $0x30,%eax
    381a:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    381d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3820:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3825:	89 c8                	mov    %ecx,%eax
    3827:	f7 ea                	imul   %edx
    3829:	c1 fa 02             	sar    $0x2,%edx
    382c:	89 c8                	mov    %ecx,%eax
    382e:	c1 f8 1f             	sar    $0x1f,%eax
    3831:	29 c2                	sub    %eax,%edx
    3833:	89 d0                	mov    %edx,%eax
    3835:	c1 e0 02             	shl    $0x2,%eax
    3838:	01 d0                	add    %edx,%eax
    383a:	01 c0                	add    %eax,%eax
    383c:	29 c1                	sub    %eax,%ecx
    383e:	89 ca                	mov    %ecx,%edx
    3840:	89 d0                	mov    %edx,%eax
    3842:	83 c0 30             	add    $0x30,%eax
    3845:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3848:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    384c:	83 ec 0c             	sub    $0xc,%esp
    384f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3852:	50                   	push   %eax
    3853:	e8 fb 03 00 00       	call   3c53 <unlink>
    3858:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    385b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    385f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3863:	0f 89 1b ff ff ff    	jns    3784 <fsfull+0x1aa>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3869:	83 ec 08             	sub    $0x8,%esp
    386c:	68 39 74 00 00       	push   $0x7439
    3871:	6a 01                	push   $0x1
    3873:	e8 4a 05 00 00       	call   3dc2 <printf>
    3878:	83 c4 10             	add    $0x10,%esp
}
    387b:	90                   	nop
    387c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    387f:	c9                   	leave  
    3880:	c3                   	ret    

00003881 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3881:	55                   	push   %ebp
    3882:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3884:	a1 f8 7f 00 00       	mov    0x7ff8,%eax
    3889:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    388f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3894:	a3 f8 7f 00 00       	mov    %eax,0x7ff8
  return randstate;
    3899:	a1 f8 7f 00 00       	mov    0x7ff8,%eax
}
    389e:	5d                   	pop    %ebp
    389f:	c3                   	ret    

000038a0 <main>:

int
main(int argc, char *argv[])
{
    38a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    38a4:	83 e4 f0             	and    $0xfffffff0,%esp
    38a7:	ff 71 fc             	pushl  -0x4(%ecx)
    38aa:	55                   	push   %ebp
    38ab:	89 e5                	mov    %esp,%ebp
    38ad:	51                   	push   %ecx
    38ae:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    38b1:	83 ec 08             	sub    $0x8,%esp
    38b4:	68 4f 74 00 00       	push   $0x744f
    38b9:	6a 01                	push   $0x1
    38bb:	e8 02 05 00 00       	call   3dc2 <printf>
    38c0:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    38c3:	83 ec 08             	sub    $0x8,%esp
    38c6:	6a 00                	push   $0x0
    38c8:	68 63 74 00 00       	push   $0x7463
    38cd:	e8 71 03 00 00       	call   3c43 <open>
    38d2:	83 c4 10             	add    $0x10,%esp
    38d5:	85 c0                	test   %eax,%eax
    38d7:	78 17                	js     38f0 <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    38d9:	83 ec 08             	sub    $0x8,%esp
    38dc:	68 74 74 00 00       	push   $0x7474
    38e1:	6a 01                	push   $0x1
    38e3:	e8 da 04 00 00       	call   3dc2 <printf>
    38e8:	83 c4 10             	add    $0x10,%esp
    exit();
    38eb:	e8 13 03 00 00       	call   3c03 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    38f0:	83 ec 08             	sub    $0x8,%esp
    38f3:	68 00 02 00 00       	push   $0x200
    38f8:	68 63 74 00 00       	push   $0x7463
    38fd:	e8 41 03 00 00       	call   3c43 <open>
    3902:	83 c4 10             	add    $0x10,%esp
    3905:	83 ec 0c             	sub    $0xc,%esp
    3908:	50                   	push   %eax
    3909:	e8 1d 03 00 00       	call   3c2b <close>
    390e:	83 c4 10             	add    $0x10,%esp

  bigargtest();
    3911:	e8 88 fb ff ff       	call   349e <bigargtest>
  bigwrite();
    3916:	e8 ea ea ff ff       	call   2405 <bigwrite>
  bigargtest();
    391b:	e8 7e fb ff ff       	call   349e <bigargtest>
  bsstest();
    3920:	e8 03 fb ff ff       	call   3428 <bsstest>
  sbrktest();
    3925:	e8 0e f5 ff ff       	call   2e38 <sbrktest>
  validatetest();
    392a:	e8 1b fa ff ff       	call   334a <validatetest>

  opentest();
    392f:	e8 cc c6 ff ff       	call   0 <opentest>
  writetest();
    3934:	e8 76 c7 ff ff       	call   af <writetest>
  writetest1();
    3939:	e8 81 c9 ff ff       	call   2bf <writetest1>
  createtest();
    393e:	e8 78 cb ff ff       	call   4bb <createtest>

  mem();
    3943:	e8 3e d1 ff ff       	call   a86 <mem>
  pipe1();
    3948:	e8 75 cd ff ff       	call   6c2 <pipe1>
  preempt();
    394d:	e8 59 cf ff ff       	call   8ab <preempt>
  exitwait();
    3952:	e8 b7 d0 ff ff       	call   a0e <exitwait>

  rmdot();
    3957:	e8 1b ef ff ff       	call   2877 <rmdot>
  fourteen();
    395c:	e8 ba ed ff ff       	call   271b <fourteen>
  bigfile();
    3961:	e8 9d eb ff ff       	call   2503 <bigfile>
  subdir();
    3966:	e8 56 e3 ff ff       	call   1cc1 <subdir>
  concreate();
    396b:	e8 f3 dc ff ff       	call   1663 <concreate>
  linkunlink();
    3970:	e8 9e e0 ff ff       	call   1a13 <linkunlink>
  linktest();
    3975:	e8 a7 da ff ff       	call   1421 <linktest>
  unlinkread();
    397a:	e8 e0 d8 ff ff       	call   125f <unlinkread>
  createdelete();
    397f:	e8 35 d6 ff ff       	call   fb9 <createdelete>
  twofiles();
    3984:	e8 d1 d3 ff ff       	call   d5a <twofiles>
  sharedfd();
    3989:	e8 e9 d1 ff ff       	call   b77 <sharedfd>
  dirfile();
    398e:	e8 69 f0 ff ff       	call   29fc <dirfile>
  iref();
    3993:	e8 9c f2 ff ff       	call   2c34 <iref>
  forktest();
    3998:	e8 d1 f3 ff ff       	call   2d6e <forktest>
  bigdir(); // slow
    399d:	e8 aa e1 ff ff       	call   1b4c <bigdir>

  exectest();
    39a2:	e8 c8 cc ff ff       	call   66f <exectest>

  exit();
    39a7:	e8 57 02 00 00       	call   3c03 <exit>

000039ac <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    39ac:	55                   	push   %ebp
    39ad:	89 e5                	mov    %esp,%ebp
    39af:	57                   	push   %edi
    39b0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    39b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    39b4:	8b 55 10             	mov    0x10(%ebp),%edx
    39b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    39ba:	89 cb                	mov    %ecx,%ebx
    39bc:	89 df                	mov    %ebx,%edi
    39be:	89 d1                	mov    %edx,%ecx
    39c0:	fc                   	cld    
    39c1:	f3 aa                	rep stos %al,%es:(%edi)
    39c3:	89 ca                	mov    %ecx,%edx
    39c5:	89 fb                	mov    %edi,%ebx
    39c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    39ca:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    39cd:	90                   	nop
    39ce:	5b                   	pop    %ebx
    39cf:	5f                   	pop    %edi
    39d0:	5d                   	pop    %ebp
    39d1:	c3                   	ret    

000039d2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    39d2:	55                   	push   %ebp
    39d3:	89 e5                	mov    %esp,%ebp
    39d5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    39d8:	8b 45 08             	mov    0x8(%ebp),%eax
    39db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    39de:	90                   	nop
    39df:	8b 45 08             	mov    0x8(%ebp),%eax
    39e2:	8d 50 01             	lea    0x1(%eax),%edx
    39e5:	89 55 08             	mov    %edx,0x8(%ebp)
    39e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    39eb:	8d 4a 01             	lea    0x1(%edx),%ecx
    39ee:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    39f1:	0f b6 12             	movzbl (%edx),%edx
    39f4:	88 10                	mov    %dl,(%eax)
    39f6:	0f b6 00             	movzbl (%eax),%eax
    39f9:	84 c0                	test   %al,%al
    39fb:	75 e2                	jne    39df <strcpy+0xd>
    ;
  return os;
    39fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3a00:	c9                   	leave  
    3a01:	c3                   	ret    

00003a02 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3a02:	55                   	push   %ebp
    3a03:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3a05:	eb 08                	jmp    3a0f <strcmp+0xd>
    p++, q++;
    3a07:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3a0b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3a0f:	8b 45 08             	mov    0x8(%ebp),%eax
    3a12:	0f b6 00             	movzbl (%eax),%eax
    3a15:	84 c0                	test   %al,%al
    3a17:	74 10                	je     3a29 <strcmp+0x27>
    3a19:	8b 45 08             	mov    0x8(%ebp),%eax
    3a1c:	0f b6 10             	movzbl (%eax),%edx
    3a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a22:	0f b6 00             	movzbl (%eax),%eax
    3a25:	38 c2                	cmp    %al,%dl
    3a27:	74 de                	je     3a07 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3a29:	8b 45 08             	mov    0x8(%ebp),%eax
    3a2c:	0f b6 00             	movzbl (%eax),%eax
    3a2f:	0f b6 d0             	movzbl %al,%edx
    3a32:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a35:	0f b6 00             	movzbl (%eax),%eax
    3a38:	0f b6 c0             	movzbl %al,%eax
    3a3b:	29 c2                	sub    %eax,%edx
    3a3d:	89 d0                	mov    %edx,%eax
}
    3a3f:	5d                   	pop    %ebp
    3a40:	c3                   	ret    

00003a41 <strlen>:

uint
strlen(char *s)
{
    3a41:	55                   	push   %ebp
    3a42:	89 e5                	mov    %esp,%ebp
    3a44:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3a47:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3a4e:	eb 04                	jmp    3a54 <strlen+0x13>
    3a50:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3a54:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3a57:	8b 45 08             	mov    0x8(%ebp),%eax
    3a5a:	01 d0                	add    %edx,%eax
    3a5c:	0f b6 00             	movzbl (%eax),%eax
    3a5f:	84 c0                	test   %al,%al
    3a61:	75 ed                	jne    3a50 <strlen+0xf>
    ;
  return n;
    3a63:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3a66:	c9                   	leave  
    3a67:	c3                   	ret    

00003a68 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3a68:	55                   	push   %ebp
    3a69:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3a6b:	8b 45 10             	mov    0x10(%ebp),%eax
    3a6e:	50                   	push   %eax
    3a6f:	ff 75 0c             	pushl  0xc(%ebp)
    3a72:	ff 75 08             	pushl  0x8(%ebp)
    3a75:	e8 32 ff ff ff       	call   39ac <stosb>
    3a7a:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3a7d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3a80:	c9                   	leave  
    3a81:	c3                   	ret    

00003a82 <strchr>:

char*
strchr(const char *s, char c)
{
    3a82:	55                   	push   %ebp
    3a83:	89 e5                	mov    %esp,%ebp
    3a85:	83 ec 04             	sub    $0x4,%esp
    3a88:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a8b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3a8e:	eb 14                	jmp    3aa4 <strchr+0x22>
    if(*s == c)
    3a90:	8b 45 08             	mov    0x8(%ebp),%eax
    3a93:	0f b6 00             	movzbl (%eax),%eax
    3a96:	3a 45 fc             	cmp    -0x4(%ebp),%al
    3a99:	75 05                	jne    3aa0 <strchr+0x1e>
      return (char*)s;
    3a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    3a9e:	eb 13                	jmp    3ab3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3aa0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3aa4:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa7:	0f b6 00             	movzbl (%eax),%eax
    3aaa:	84 c0                	test   %al,%al
    3aac:	75 e2                	jne    3a90 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    3aae:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3ab3:	c9                   	leave  
    3ab4:	c3                   	ret    

00003ab5 <gets>:

char*
gets(char *buf, int max)
{
    3ab5:	55                   	push   %ebp
    3ab6:	89 e5                	mov    %esp,%ebp
    3ab8:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3abb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3ac2:	eb 42                	jmp    3b06 <gets+0x51>
    cc = read(0, &c, 1);
    3ac4:	83 ec 04             	sub    $0x4,%esp
    3ac7:	6a 01                	push   $0x1
    3ac9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3acc:	50                   	push   %eax
    3acd:	6a 00                	push   $0x0
    3acf:	e8 47 01 00 00       	call   3c1b <read>
    3ad4:	83 c4 10             	add    $0x10,%esp
    3ad7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3ada:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3ade:	7e 33                	jle    3b13 <gets+0x5e>
      break;
    buf[i++] = c;
    3ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ae3:	8d 50 01             	lea    0x1(%eax),%edx
    3ae6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3ae9:	89 c2                	mov    %eax,%edx
    3aeb:	8b 45 08             	mov    0x8(%ebp),%eax
    3aee:	01 c2                	add    %eax,%edx
    3af0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3af4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3af6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3afa:	3c 0a                	cmp    $0xa,%al
    3afc:	74 16                	je     3b14 <gets+0x5f>
    3afe:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3b02:	3c 0d                	cmp    $0xd,%al
    3b04:	74 0e                	je     3b14 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b09:	83 c0 01             	add    $0x1,%eax
    3b0c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3b0f:	7c b3                	jl     3ac4 <gets+0xf>
    3b11:	eb 01                	jmp    3b14 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    3b13:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3b14:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3b17:	8b 45 08             	mov    0x8(%ebp),%eax
    3b1a:	01 d0                	add    %edx,%eax
    3b1c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3b1f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3b22:	c9                   	leave  
    3b23:	c3                   	ret    

00003b24 <stat>:

int
stat(char *n, struct stat *st)
{
    3b24:	55                   	push   %ebp
    3b25:	89 e5                	mov    %esp,%ebp
    3b27:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3b2a:	83 ec 08             	sub    $0x8,%esp
    3b2d:	6a 00                	push   $0x0
    3b2f:	ff 75 08             	pushl  0x8(%ebp)
    3b32:	e8 0c 01 00 00       	call   3c43 <open>
    3b37:	83 c4 10             	add    $0x10,%esp
    3b3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3b3d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b41:	79 07                	jns    3b4a <stat+0x26>
    return -1;
    3b43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3b48:	eb 25                	jmp    3b6f <stat+0x4b>
  r = fstat(fd, st);
    3b4a:	83 ec 08             	sub    $0x8,%esp
    3b4d:	ff 75 0c             	pushl  0xc(%ebp)
    3b50:	ff 75 f4             	pushl  -0xc(%ebp)
    3b53:	e8 03 01 00 00       	call   3c5b <fstat>
    3b58:	83 c4 10             	add    $0x10,%esp
    3b5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3b5e:	83 ec 0c             	sub    $0xc,%esp
    3b61:	ff 75 f4             	pushl  -0xc(%ebp)
    3b64:	e8 c2 00 00 00       	call   3c2b <close>
    3b69:	83 c4 10             	add    $0x10,%esp
  return r;
    3b6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3b6f:	c9                   	leave  
    3b70:	c3                   	ret    

00003b71 <atoi>:

int
atoi(const char *s)
{
    3b71:	55                   	push   %ebp
    3b72:	89 e5                	mov    %esp,%ebp
    3b74:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3b77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3b7e:	eb 25                	jmp    3ba5 <atoi+0x34>
    n = n*10 + *s++ - '0';
    3b80:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3b83:	89 d0                	mov    %edx,%eax
    3b85:	c1 e0 02             	shl    $0x2,%eax
    3b88:	01 d0                	add    %edx,%eax
    3b8a:	01 c0                	add    %eax,%eax
    3b8c:	89 c1                	mov    %eax,%ecx
    3b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    3b91:	8d 50 01             	lea    0x1(%eax),%edx
    3b94:	89 55 08             	mov    %edx,0x8(%ebp)
    3b97:	0f b6 00             	movzbl (%eax),%eax
    3b9a:	0f be c0             	movsbl %al,%eax
    3b9d:	01 c8                	add    %ecx,%eax
    3b9f:	83 e8 30             	sub    $0x30,%eax
    3ba2:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3ba5:	8b 45 08             	mov    0x8(%ebp),%eax
    3ba8:	0f b6 00             	movzbl (%eax),%eax
    3bab:	3c 2f                	cmp    $0x2f,%al
    3bad:	7e 0a                	jle    3bb9 <atoi+0x48>
    3baf:	8b 45 08             	mov    0x8(%ebp),%eax
    3bb2:	0f b6 00             	movzbl (%eax),%eax
    3bb5:	3c 39                	cmp    $0x39,%al
    3bb7:	7e c7                	jle    3b80 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    3bb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3bbc:	c9                   	leave  
    3bbd:	c3                   	ret    

00003bbe <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3bbe:	55                   	push   %ebp
    3bbf:	89 e5                	mov    %esp,%ebp
    3bc1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    3bc4:	8b 45 08             	mov    0x8(%ebp),%eax
    3bc7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3bca:	8b 45 0c             	mov    0xc(%ebp),%eax
    3bcd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3bd0:	eb 17                	jmp    3be9 <memmove+0x2b>
    *dst++ = *src++;
    3bd2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3bd5:	8d 50 01             	lea    0x1(%eax),%edx
    3bd8:	89 55 fc             	mov    %edx,-0x4(%ebp)
    3bdb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3bde:	8d 4a 01             	lea    0x1(%edx),%ecx
    3be1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    3be4:	0f b6 12             	movzbl (%edx),%edx
    3be7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3be9:	8b 45 10             	mov    0x10(%ebp),%eax
    3bec:	8d 50 ff             	lea    -0x1(%eax),%edx
    3bef:	89 55 10             	mov    %edx,0x10(%ebp)
    3bf2:	85 c0                	test   %eax,%eax
    3bf4:	7f dc                	jg     3bd2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    3bf6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3bf9:	c9                   	leave  
    3bfa:	c3                   	ret    

00003bfb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3bfb:	b8 01 00 00 00       	mov    $0x1,%eax
    3c00:	cd 40                	int    $0x40
    3c02:	c3                   	ret    

00003c03 <exit>:
SYSCALL(exit)
    3c03:	b8 02 00 00 00       	mov    $0x2,%eax
    3c08:	cd 40                	int    $0x40
    3c0a:	c3                   	ret    

00003c0b <wait>:
SYSCALL(wait)
    3c0b:	b8 03 00 00 00       	mov    $0x3,%eax
    3c10:	cd 40                	int    $0x40
    3c12:	c3                   	ret    

00003c13 <pipe>:
SYSCALL(pipe)
    3c13:	b8 04 00 00 00       	mov    $0x4,%eax
    3c18:	cd 40                	int    $0x40
    3c1a:	c3                   	ret    

00003c1b <read>:
SYSCALL(read)
    3c1b:	b8 05 00 00 00       	mov    $0x5,%eax
    3c20:	cd 40                	int    $0x40
    3c22:	c3                   	ret    

00003c23 <write>:
SYSCALL(write)
    3c23:	b8 10 00 00 00       	mov    $0x10,%eax
    3c28:	cd 40                	int    $0x40
    3c2a:	c3                   	ret    

00003c2b <close>:
SYSCALL(close)
    3c2b:	b8 15 00 00 00       	mov    $0x15,%eax
    3c30:	cd 40                	int    $0x40
    3c32:	c3                   	ret    

00003c33 <kill>:
SYSCALL(kill)
    3c33:	b8 06 00 00 00       	mov    $0x6,%eax
    3c38:	cd 40                	int    $0x40
    3c3a:	c3                   	ret    

00003c3b <exec>:
SYSCALL(exec)
    3c3b:	b8 07 00 00 00       	mov    $0x7,%eax
    3c40:	cd 40                	int    $0x40
    3c42:	c3                   	ret    

00003c43 <open>:
SYSCALL(open)
    3c43:	b8 0f 00 00 00       	mov    $0xf,%eax
    3c48:	cd 40                	int    $0x40
    3c4a:	c3                   	ret    

00003c4b <mknod>:
SYSCALL(mknod)
    3c4b:	b8 11 00 00 00       	mov    $0x11,%eax
    3c50:	cd 40                	int    $0x40
    3c52:	c3                   	ret    

00003c53 <unlink>:
SYSCALL(unlink)
    3c53:	b8 12 00 00 00       	mov    $0x12,%eax
    3c58:	cd 40                	int    $0x40
    3c5a:	c3                   	ret    

00003c5b <fstat>:
SYSCALL(fstat)
    3c5b:	b8 08 00 00 00       	mov    $0x8,%eax
    3c60:	cd 40                	int    $0x40
    3c62:	c3                   	ret    

00003c63 <link>:
SYSCALL(link)
    3c63:	b8 13 00 00 00       	mov    $0x13,%eax
    3c68:	cd 40                	int    $0x40
    3c6a:	c3                   	ret    

00003c6b <mkdir>:
SYSCALL(mkdir)
    3c6b:	b8 14 00 00 00       	mov    $0x14,%eax
    3c70:	cd 40                	int    $0x40
    3c72:	c3                   	ret    

00003c73 <chdir>:
SYSCALL(chdir)
    3c73:	b8 09 00 00 00       	mov    $0x9,%eax
    3c78:	cd 40                	int    $0x40
    3c7a:	c3                   	ret    

00003c7b <dup>:
SYSCALL(dup)
    3c7b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3c80:	cd 40                	int    $0x40
    3c82:	c3                   	ret    

00003c83 <getpid>:
SYSCALL(getpid)
    3c83:	b8 0b 00 00 00       	mov    $0xb,%eax
    3c88:	cd 40                	int    $0x40
    3c8a:	c3                   	ret    

00003c8b <sbrk>:
SYSCALL(sbrk)
    3c8b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3c90:	cd 40                	int    $0x40
    3c92:	c3                   	ret    

00003c93 <sleep>:
SYSCALL(sleep)
    3c93:	b8 0d 00 00 00       	mov    $0xd,%eax
    3c98:	cd 40                	int    $0x40
    3c9a:	c3                   	ret    

00003c9b <uptime>:
SYSCALL(uptime)
    3c9b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3ca0:	cd 40                	int    $0x40
    3ca2:	c3                   	ret    

00003ca3 <paintWindow>:

SYSCALL(paintWindow)
    3ca3:	b8 16 00 00 00       	mov    $0x16,%eax
    3ca8:	cd 40                	int    $0x40
    3caa:	c3                   	ret    

00003cab <sendMessage>:
SYSCALL(sendMessage)
    3cab:	b8 17 00 00 00       	mov    $0x17,%eax
    3cb0:	cd 40                	int    $0x40
    3cb2:	c3                   	ret    

00003cb3 <getMessage>:
SYSCALL(getMessage)
    3cb3:	b8 19 00 00 00       	mov    $0x19,%eax
    3cb8:	cd 40                	int    $0x40
    3cba:	c3                   	ret    

00003cbb <registWindow>:
SYSCALL(registWindow)
    3cbb:	b8 18 00 00 00       	mov    $0x18,%eax
    3cc0:	cd 40                	int    $0x40
    3cc2:	c3                   	ret    

00003cc3 <changePosition>:
SYSCALL(changePosition)
    3cc3:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3cc8:	cd 40                	int    $0x40
    3cca:	c3                   	ret    

00003ccb <setupTimer>:
SYSCALL(setupTimer)
    3ccb:	b8 1b 00 00 00       	mov    $0x1b,%eax
    3cd0:	cd 40                	int    $0x40
    3cd2:	c3                   	ret    

00003cd3 <deleteTimer>:
SYSCALL(deleteTimer)
    3cd3:	b8 1c 00 00 00       	mov    $0x1c,%eax
    3cd8:	cd 40                	int    $0x40
    3cda:	c3                   	ret    

00003cdb <getCurrentTime>:
SYSCALL(getCurrentTime)
    3cdb:	b8 1d 00 00 00       	mov    $0x1d,%eax
    3ce0:	cd 40                	int    $0x40
    3ce2:	c3                   	ret    

00003ce3 <removeWindow>:
SYSCALL(removeWindow)
    3ce3:	b8 1e 00 00 00       	mov    $0x1e,%eax
    3ce8:	cd 40                	int    $0x40
    3cea:	c3                   	ret    

00003ceb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3ceb:	55                   	push   %ebp
    3cec:	89 e5                	mov    %esp,%ebp
    3cee:	83 ec 18             	sub    $0x18,%esp
    3cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cf4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    3cf7:	83 ec 04             	sub    $0x4,%esp
    3cfa:	6a 01                	push   $0x1
    3cfc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3cff:	50                   	push   %eax
    3d00:	ff 75 08             	pushl  0x8(%ebp)
    3d03:	e8 1b ff ff ff       	call   3c23 <write>
    3d08:	83 c4 10             	add    $0x10,%esp
}
    3d0b:	90                   	nop
    3d0c:	c9                   	leave  
    3d0d:	c3                   	ret    

00003d0e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3d0e:	55                   	push   %ebp
    3d0f:	89 e5                	mov    %esp,%ebp
    3d11:	53                   	push   %ebx
    3d12:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3d15:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    3d1c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3d20:	74 17                	je     3d39 <printint+0x2b>
    3d22:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3d26:	79 11                	jns    3d39 <printint+0x2b>
    neg = 1;
    3d28:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    3d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d32:	f7 d8                	neg    %eax
    3d34:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3d37:	eb 06                	jmp    3d3f <printint+0x31>
  } else {
    x = xx;
    3d39:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    3d3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    3d46:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3d49:	8d 41 01             	lea    0x1(%ecx),%eax
    3d4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3d4f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d52:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d55:	ba 00 00 00 00       	mov    $0x0,%edx
    3d5a:	f7 f3                	div    %ebx
    3d5c:	89 d0                	mov    %edx,%eax
    3d5e:	0f b6 80 fc 7f 00 00 	movzbl 0x7ffc(%eax),%eax
    3d65:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    3d69:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d6f:	ba 00 00 00 00       	mov    $0x0,%edx
    3d74:	f7 f3                	div    %ebx
    3d76:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3d79:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3d7d:	75 c7                	jne    3d46 <printint+0x38>
  if(neg)
    3d7f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3d83:	74 2d                	je     3db2 <printint+0xa4>
    buf[i++] = '-';
    3d85:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d88:	8d 50 01             	lea    0x1(%eax),%edx
    3d8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3d8e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    3d93:	eb 1d                	jmp    3db2 <printint+0xa4>
    putc(fd, buf[i]);
    3d95:	8d 55 dc             	lea    -0x24(%ebp),%edx
    3d98:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d9b:	01 d0                	add    %edx,%eax
    3d9d:	0f b6 00             	movzbl (%eax),%eax
    3da0:	0f be c0             	movsbl %al,%eax
    3da3:	83 ec 08             	sub    $0x8,%esp
    3da6:	50                   	push   %eax
    3da7:	ff 75 08             	pushl  0x8(%ebp)
    3daa:	e8 3c ff ff ff       	call   3ceb <putc>
    3daf:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3db2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    3db6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3dba:	79 d9                	jns    3d95 <printint+0x87>
    putc(fd, buf[i]);
}
    3dbc:	90                   	nop
    3dbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3dc0:	c9                   	leave  
    3dc1:	c3                   	ret    

00003dc2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3dc2:	55                   	push   %ebp
    3dc3:	89 e5                	mov    %esp,%ebp
    3dc5:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    3dc8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    3dcf:	8d 45 0c             	lea    0xc(%ebp),%eax
    3dd2:	83 c0 04             	add    $0x4,%eax
    3dd5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    3dd8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3ddf:	e9 59 01 00 00       	jmp    3f3d <printf+0x17b>
    c = fmt[i] & 0xff;
    3de4:	8b 55 0c             	mov    0xc(%ebp),%edx
    3de7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3dea:	01 d0                	add    %edx,%eax
    3dec:	0f b6 00             	movzbl (%eax),%eax
    3def:	0f be c0             	movsbl %al,%eax
    3df2:	25 ff 00 00 00       	and    $0xff,%eax
    3df7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    3dfa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3dfe:	75 2c                	jne    3e2c <printf+0x6a>
      if(c == '%'){
    3e00:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3e04:	75 0c                	jne    3e12 <printf+0x50>
        state = '%';
    3e06:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    3e0d:	e9 27 01 00 00       	jmp    3f39 <printf+0x177>
      } else {
        putc(fd, c);
    3e12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3e15:	0f be c0             	movsbl %al,%eax
    3e18:	83 ec 08             	sub    $0x8,%esp
    3e1b:	50                   	push   %eax
    3e1c:	ff 75 08             	pushl  0x8(%ebp)
    3e1f:	e8 c7 fe ff ff       	call   3ceb <putc>
    3e24:	83 c4 10             	add    $0x10,%esp
    3e27:	e9 0d 01 00 00       	jmp    3f39 <printf+0x177>
      }
    } else if(state == '%'){
    3e2c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    3e30:	0f 85 03 01 00 00    	jne    3f39 <printf+0x177>
      if(c == 'd'){
    3e36:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    3e3a:	75 1e                	jne    3e5a <printf+0x98>
        printint(fd, *ap, 10, 1);
    3e3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e3f:	8b 00                	mov    (%eax),%eax
    3e41:	6a 01                	push   $0x1
    3e43:	6a 0a                	push   $0xa
    3e45:	50                   	push   %eax
    3e46:	ff 75 08             	pushl  0x8(%ebp)
    3e49:	e8 c0 fe ff ff       	call   3d0e <printint>
    3e4e:	83 c4 10             	add    $0x10,%esp
        ap++;
    3e51:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e55:	e9 d8 00 00 00       	jmp    3f32 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    3e5a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    3e5e:	74 06                	je     3e66 <printf+0xa4>
    3e60:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    3e64:	75 1e                	jne    3e84 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    3e66:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e69:	8b 00                	mov    (%eax),%eax
    3e6b:	6a 00                	push   $0x0
    3e6d:	6a 10                	push   $0x10
    3e6f:	50                   	push   %eax
    3e70:	ff 75 08             	pushl  0x8(%ebp)
    3e73:	e8 96 fe ff ff       	call   3d0e <printint>
    3e78:	83 c4 10             	add    $0x10,%esp
        ap++;
    3e7b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e7f:	e9 ae 00 00 00       	jmp    3f32 <printf+0x170>
      } else if(c == 's'){
    3e84:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    3e88:	75 43                	jne    3ecd <printf+0x10b>
        s = (char*)*ap;
    3e8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e8d:	8b 00                	mov    (%eax),%eax
    3e8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    3e92:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    3e96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3e9a:	75 25                	jne    3ec1 <printf+0xff>
          s = "(null)";
    3e9c:	c7 45 f4 9e 74 00 00 	movl   $0x749e,-0xc(%ebp)
        while(*s != 0){
    3ea3:	eb 1c                	jmp    3ec1 <printf+0xff>
          putc(fd, *s);
    3ea5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ea8:	0f b6 00             	movzbl (%eax),%eax
    3eab:	0f be c0             	movsbl %al,%eax
    3eae:	83 ec 08             	sub    $0x8,%esp
    3eb1:	50                   	push   %eax
    3eb2:	ff 75 08             	pushl  0x8(%ebp)
    3eb5:	e8 31 fe ff ff       	call   3ceb <putc>
    3eba:	83 c4 10             	add    $0x10,%esp
          s++;
    3ebd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3ec1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ec4:	0f b6 00             	movzbl (%eax),%eax
    3ec7:	84 c0                	test   %al,%al
    3ec9:	75 da                	jne    3ea5 <printf+0xe3>
    3ecb:	eb 65                	jmp    3f32 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3ecd:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    3ed1:	75 1d                	jne    3ef0 <printf+0x12e>
        putc(fd, *ap);
    3ed3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3ed6:	8b 00                	mov    (%eax),%eax
    3ed8:	0f be c0             	movsbl %al,%eax
    3edb:	83 ec 08             	sub    $0x8,%esp
    3ede:	50                   	push   %eax
    3edf:	ff 75 08             	pushl  0x8(%ebp)
    3ee2:	e8 04 fe ff ff       	call   3ceb <putc>
    3ee7:	83 c4 10             	add    $0x10,%esp
        ap++;
    3eea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3eee:	eb 42                	jmp    3f32 <printf+0x170>
      } else if(c == '%'){
    3ef0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3ef4:	75 17                	jne    3f0d <printf+0x14b>
        putc(fd, c);
    3ef6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3ef9:	0f be c0             	movsbl %al,%eax
    3efc:	83 ec 08             	sub    $0x8,%esp
    3eff:	50                   	push   %eax
    3f00:	ff 75 08             	pushl  0x8(%ebp)
    3f03:	e8 e3 fd ff ff       	call   3ceb <putc>
    3f08:	83 c4 10             	add    $0x10,%esp
    3f0b:	eb 25                	jmp    3f32 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3f0d:	83 ec 08             	sub    $0x8,%esp
    3f10:	6a 25                	push   $0x25
    3f12:	ff 75 08             	pushl  0x8(%ebp)
    3f15:	e8 d1 fd ff ff       	call   3ceb <putc>
    3f1a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    3f1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3f20:	0f be c0             	movsbl %al,%eax
    3f23:	83 ec 08             	sub    $0x8,%esp
    3f26:	50                   	push   %eax
    3f27:	ff 75 08             	pushl  0x8(%ebp)
    3f2a:	e8 bc fd ff ff       	call   3ceb <putc>
    3f2f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3f32:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3f39:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3f3d:	8b 55 0c             	mov    0xc(%ebp),%edx
    3f40:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f43:	01 d0                	add    %edx,%eax
    3f45:	0f b6 00             	movzbl (%eax),%eax
    3f48:	84 c0                	test   %al,%al
    3f4a:	0f 85 94 fe ff ff    	jne    3de4 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3f50:	90                   	nop
    3f51:	c9                   	leave  
    3f52:	c3                   	ret    

00003f53 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3f53:	55                   	push   %ebp
    3f54:	89 e5                	mov    %esp,%ebp
    3f56:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3f59:	8b 45 08             	mov    0x8(%ebp),%eax
    3f5c:	83 e8 08             	sub    $0x8,%eax
    3f5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f62:	a1 e8 bc 00 00       	mov    0xbce8,%eax
    3f67:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f6a:	eb 24                	jmp    3f90 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f6f:	8b 00                	mov    (%eax),%eax
    3f71:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f74:	77 12                	ja     3f88 <free+0x35>
    3f76:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f79:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f7c:	77 24                	ja     3fa2 <free+0x4f>
    3f7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f81:	8b 00                	mov    (%eax),%eax
    3f83:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3f86:	77 1a                	ja     3fa2 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f88:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f8b:	8b 00                	mov    (%eax),%eax
    3f8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f90:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3f93:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f96:	76 d4                	jbe    3f6c <free+0x19>
    3f98:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f9b:	8b 00                	mov    (%eax),%eax
    3f9d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3fa0:	76 ca                	jbe    3f6c <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3fa2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fa5:	8b 40 04             	mov    0x4(%eax),%eax
    3fa8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    3faf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fb2:	01 c2                	add    %eax,%edx
    3fb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fb7:	8b 00                	mov    (%eax),%eax
    3fb9:	39 c2                	cmp    %eax,%edx
    3fbb:	75 24                	jne    3fe1 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    3fbd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fc0:	8b 50 04             	mov    0x4(%eax),%edx
    3fc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fc6:	8b 00                	mov    (%eax),%eax
    3fc8:	8b 40 04             	mov    0x4(%eax),%eax
    3fcb:	01 c2                	add    %eax,%edx
    3fcd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fd0:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    3fd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fd6:	8b 00                	mov    (%eax),%eax
    3fd8:	8b 10                	mov    (%eax),%edx
    3fda:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fdd:	89 10                	mov    %edx,(%eax)
    3fdf:	eb 0a                	jmp    3feb <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    3fe1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fe4:	8b 10                	mov    (%eax),%edx
    3fe6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fe9:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    3feb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fee:	8b 40 04             	mov    0x4(%eax),%eax
    3ff1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    3ff8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3ffb:	01 d0                	add    %edx,%eax
    3ffd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4000:	75 20                	jne    4022 <free+0xcf>
    p->s.size += bp->s.size;
    4002:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4005:	8b 50 04             	mov    0x4(%eax),%edx
    4008:	8b 45 f8             	mov    -0x8(%ebp),%eax
    400b:	8b 40 04             	mov    0x4(%eax),%eax
    400e:	01 c2                	add    %eax,%edx
    4010:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4013:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4016:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4019:	8b 10                	mov    (%eax),%edx
    401b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    401e:	89 10                	mov    %edx,(%eax)
    4020:	eb 08                	jmp    402a <free+0xd7>
  } else
    p->s.ptr = bp;
    4022:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4025:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4028:	89 10                	mov    %edx,(%eax)
  freep = p;
    402a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    402d:	a3 e8 bc 00 00       	mov    %eax,0xbce8
}
    4032:	90                   	nop
    4033:	c9                   	leave  
    4034:	c3                   	ret    

00004035 <morecore>:

static Header*
morecore(uint nu)
{
    4035:	55                   	push   %ebp
    4036:	89 e5                	mov    %esp,%ebp
    4038:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    403b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4042:	77 07                	ja     404b <morecore+0x16>
    nu = 4096;
    4044:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    404b:	8b 45 08             	mov    0x8(%ebp),%eax
    404e:	c1 e0 03             	shl    $0x3,%eax
    4051:	83 ec 0c             	sub    $0xc,%esp
    4054:	50                   	push   %eax
    4055:	e8 31 fc ff ff       	call   3c8b <sbrk>
    405a:	83 c4 10             	add    $0x10,%esp
    405d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4060:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4064:	75 07                	jne    406d <morecore+0x38>
    return 0;
    4066:	b8 00 00 00 00       	mov    $0x0,%eax
    406b:	eb 26                	jmp    4093 <morecore+0x5e>
  hp = (Header*)p;
    406d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4070:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4073:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4076:	8b 55 08             	mov    0x8(%ebp),%edx
    4079:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    407c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    407f:	83 c0 08             	add    $0x8,%eax
    4082:	83 ec 0c             	sub    $0xc,%esp
    4085:	50                   	push   %eax
    4086:	e8 c8 fe ff ff       	call   3f53 <free>
    408b:	83 c4 10             	add    $0x10,%esp
  return freep;
    408e:	a1 e8 bc 00 00       	mov    0xbce8,%eax
}
    4093:	c9                   	leave  
    4094:	c3                   	ret    

00004095 <malloc>:

void*
malloc(uint nbytes)
{
    4095:	55                   	push   %ebp
    4096:	89 e5                	mov    %esp,%ebp
    4098:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    409b:	8b 45 08             	mov    0x8(%ebp),%eax
    409e:	83 c0 07             	add    $0x7,%eax
    40a1:	c1 e8 03             	shr    $0x3,%eax
    40a4:	83 c0 01             	add    $0x1,%eax
    40a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    40aa:	a1 e8 bc 00 00       	mov    0xbce8,%eax
    40af:	89 45 f0             	mov    %eax,-0x10(%ebp)
    40b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40b6:	75 23                	jne    40db <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    40b8:	c7 45 f0 e0 bc 00 00 	movl   $0xbce0,-0x10(%ebp)
    40bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40c2:	a3 e8 bc 00 00       	mov    %eax,0xbce8
    40c7:	a1 e8 bc 00 00       	mov    0xbce8,%eax
    40cc:	a3 e0 bc 00 00       	mov    %eax,0xbce0
    base.s.size = 0;
    40d1:	c7 05 e4 bc 00 00 00 	movl   $0x0,0xbce4
    40d8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    40db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40de:	8b 00                	mov    (%eax),%eax
    40e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    40e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40e6:	8b 40 04             	mov    0x4(%eax),%eax
    40e9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    40ec:	72 4d                	jb     413b <malloc+0xa6>
      if(p->s.size == nunits)
    40ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40f1:	8b 40 04             	mov    0x4(%eax),%eax
    40f4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    40f7:	75 0c                	jne    4105 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    40f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40fc:	8b 10                	mov    (%eax),%edx
    40fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4101:	89 10                	mov    %edx,(%eax)
    4103:	eb 26                	jmp    412b <malloc+0x96>
      else {
        p->s.size -= nunits;
    4105:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4108:	8b 40 04             	mov    0x4(%eax),%eax
    410b:	2b 45 ec             	sub    -0x14(%ebp),%eax
    410e:	89 c2                	mov    %eax,%edx
    4110:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4113:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4116:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4119:	8b 40 04             	mov    0x4(%eax),%eax
    411c:	c1 e0 03             	shl    $0x3,%eax
    411f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4122:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4125:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4128:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    412b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    412e:	a3 e8 bc 00 00       	mov    %eax,0xbce8
      return (void*)(p + 1);
    4133:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4136:	83 c0 08             	add    $0x8,%eax
    4139:	eb 3b                	jmp    4176 <malloc+0xe1>
    }
    if(p == freep)
    413b:	a1 e8 bc 00 00       	mov    0xbce8,%eax
    4140:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4143:	75 1e                	jne    4163 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    4145:	83 ec 0c             	sub    $0xc,%esp
    4148:	ff 75 ec             	pushl  -0x14(%ebp)
    414b:	e8 e5 fe ff ff       	call   4035 <morecore>
    4150:	83 c4 10             	add    $0x10,%esp
    4153:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4156:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    415a:	75 07                	jne    4163 <malloc+0xce>
        return 0;
    415c:	b8 00 00 00 00       	mov    $0x0,%eax
    4161:	eb 13                	jmp    4176 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4163:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4166:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4169:	8b 45 f4             	mov    -0xc(%ebp),%eax
    416c:	8b 00                	mov    (%eax),%eax
    416e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    4171:	e9 6d ff ff ff       	jmp    40e3 <malloc+0x4e>
}
    4176:	c9                   	leave  
    4177:	c3                   	ret    

00004178 <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    4178:	55                   	push   %ebp
    4179:	89 e5                	mov    %esp,%ebp
    417b:	83 ec 1c             	sub    $0x1c,%esp
    417e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    4181:	8b 55 10             	mov    0x10(%ebp),%edx
    4184:	8b 45 14             	mov    0x14(%ebp),%eax
    4187:	88 4d ec             	mov    %cl,-0x14(%ebp)
    418a:	88 55 e8             	mov    %dl,-0x18(%ebp)
    418d:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    4190:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    4194:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    4197:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    419b:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    419e:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    41a2:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    41a5:	8b 45 08             	mov    0x8(%ebp),%eax
    41a8:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    41ac:	66 89 10             	mov    %dx,(%eax)
    41af:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    41b3:	88 50 02             	mov    %dl,0x2(%eax)
}
    41b6:	8b 45 08             	mov    0x8(%ebp),%eax
    41b9:	c9                   	leave  
    41ba:	c2 04 00             	ret    $0x4

000041bd <distance_2>:
#include "stat.h"


//-------------------------calculate function------------------------------
static inline int distance_2(int x1,int y1,int x2,int y2)
{
    41bd:	55                   	push   %ebp
    41be:	89 e5                	mov    %esp,%ebp
    return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
    41c0:	8b 45 08             	mov    0x8(%ebp),%eax
    41c3:	2b 45 10             	sub    0x10(%ebp),%eax
    41c6:	89 c2                	mov    %eax,%edx
    41c8:	8b 45 08             	mov    0x8(%ebp),%eax
    41cb:	2b 45 10             	sub    0x10(%ebp),%eax
    41ce:	0f af d0             	imul   %eax,%edx
    41d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    41d4:	2b 45 14             	sub    0x14(%ebp),%eax
    41d7:	89 c1                	mov    %eax,%ecx
    41d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    41dc:	2b 45 14             	sub    0x14(%ebp),%eax
    41df:	0f af c1             	imul   %ecx,%eax
    41e2:	01 d0                	add    %edx,%eax
}
    41e4:	5d                   	pop    %ebp
    41e5:	c3                   	ret    

000041e6 <abs_int>:

static inline int abs_int(int x)
{
    41e6:	55                   	push   %ebp
    41e7:	89 e5                	mov    %esp,%ebp
    return (x >= 0)? x :-x;
    41e9:	8b 45 08             	mov    0x8(%ebp),%eax
    41ec:	99                   	cltd   
    41ed:	89 d0                	mov    %edx,%eax
    41ef:	33 45 08             	xor    0x8(%ebp),%eax
    41f2:	29 d0                	sub    %edx,%eax
}
    41f4:	5d                   	pop    %ebp
    41f5:	c3                   	ret    

000041f6 <APGetIndex>:
{
    return (x >= 0 )? x : -x;
}

static inline int APGetIndex(AHdc hdc,int x,int y)
{
    41f6:	55                   	push   %ebp
    41f7:	89 e5                	mov    %esp,%ebp
    if (x < 0)
    41f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    41fd:	79 07                	jns    4206 <APGetIndex+0x10>
        return X_SMALLER;
    41ff:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
    4204:	eb 40                	jmp    4246 <APGetIndex+0x50>
    else if (x >= hdc->size.cx )
    4206:	8b 45 08             	mov    0x8(%ebp),%eax
    4209:	8b 00                	mov    (%eax),%eax
    420b:	3b 45 0c             	cmp    0xc(%ebp),%eax
    420e:	7f 07                	jg     4217 <APGetIndex+0x21>
        return X_BIGGER;
    4210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    4215:	eb 2f                	jmp    4246 <APGetIndex+0x50>
    if (y < 0)
    4217:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    421b:	79 07                	jns    4224 <APGetIndex+0x2e>
        return Y_SMALLER;
    421d:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
    4222:	eb 22                	jmp    4246 <APGetIndex+0x50>
    else if (y>=hdc->size.cy)
    4224:	8b 45 08             	mov    0x8(%ebp),%eax
    4227:	8b 40 04             	mov    0x4(%eax),%eax
    422a:	3b 45 10             	cmp    0x10(%ebp),%eax
    422d:	7f 07                	jg     4236 <APGetIndex+0x40>
        return Y_BIGGER;
    422f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    4234:	eb 10                	jmp    4246 <APGetIndex+0x50>
    return y * hdc->size.cx + x;
    4236:	8b 45 08             	mov    0x8(%ebp),%eax
    4239:	8b 00                	mov    (%eax),%eax
    423b:	0f af 45 10          	imul   0x10(%ebp),%eax
    423f:	89 c2                	mov    %eax,%edx
    4241:	8b 45 0c             	mov    0xc(%ebp),%eax
    4244:	01 d0                	add    %edx,%eax
}
    4246:	5d                   	pop    %ebp
    4247:	c3                   	ret    

00004248 <APLoadBitmap>:

//-------------------------------bitmap--------------------------------------
ABitmap APLoadBitmap(char * filename)
{
    4248:	55                   	push   %ebp
    4249:	89 e5                	mov    %esp,%ebp
    424b:	83 ec 78             	sub    $0x78,%esp
    ABitmap bmp;
    bmp.width = bmp.height = 0;
    424e:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    4255:	8b 45 cc             	mov    -0x34(%ebp),%eax
    4258:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.data = 0;
    425b:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
    int fd = open(filename, O_RDONLY);
    4262:	83 ec 08             	sub    $0x8,%esp
    4265:	6a 00                	push   $0x0
    4267:	ff 75 0c             	pushl  0xc(%ebp)
    426a:	e8 d4 f9 ff ff       	call   3c43 <open>
    426f:	83 c4 10             	add    $0x10,%esp
    4272:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (fd < 0)
    4275:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4279:	79 2e                	jns    42a9 <APLoadBitmap+0x61>
    {
        printf(1, "Cannot open %s\n", filename);
    427b:	83 ec 04             	sub    $0x4,%esp
    427e:	ff 75 0c             	pushl  0xc(%ebp)
    4281:	68 a5 74 00 00       	push   $0x74a5
    4286:	6a 01                	push   $0x1
    4288:	e8 35 fb ff ff       	call   3dc2 <printf>
    428d:	83 c4 10             	add    $0x10,%esp
        return bmp;
    4290:	8b 45 08             	mov    0x8(%ebp),%eax
    4293:	8b 55 c8             	mov    -0x38(%ebp),%edx
    4296:	89 10                	mov    %edx,(%eax)
    4298:	8b 55 cc             	mov    -0x34(%ebp),%edx
    429b:	89 50 04             	mov    %edx,0x4(%eax)
    429e:	8b 55 d0             	mov    -0x30(%ebp),%edx
    42a1:	89 50 08             	mov    %edx,0x8(%eax)
    42a4:	e9 d2 01 00 00       	jmp    447b <APLoadBitmap+0x233>
    }
    ABitmapFileHeader fileHeader;
    read(fd, (char *)&fileHeader, sizeof(fileHeader));
    42a9:	83 ec 04             	sub    $0x4,%esp
    42ac:	6a 0e                	push   $0xe
    42ae:	8d 45 ba             	lea    -0x46(%ebp),%eax
    42b1:	50                   	push   %eax
    42b2:	ff 75 ec             	pushl  -0x14(%ebp)
    42b5:	e8 61 f9 ff ff       	call   3c1b <read>
    42ba:	83 c4 10             	add    $0x10,%esp
    //printf(1, "%x %d %d %d %d\n", fileHeader.bfType, fileHeader.bfSize, fileHeader.bfOffBits, fileHeader.bfReserved1, fileHeader.bfReserved2);
    ABitmapInfoHeader infoHeader;
    read(fd, (char *)&infoHeader, sizeof(infoHeader));
    42bd:	83 ec 04             	sub    $0x4,%esp
    42c0:	6a 28                	push   $0x28
    42c2:	8d 45 92             	lea    -0x6e(%ebp),%eax
    42c5:	50                   	push   %eax
    42c6:	ff 75 ec             	pushl  -0x14(%ebp)
    42c9:	e8 4d f9 ff ff       	call   3c1b <read>
    42ce:	83 c4 10             	add    $0x10,%esp
    bmp.width = infoHeader.biWidth;
    42d1:	8b 45 96             	mov    -0x6a(%ebp),%eax
    42d4:	89 45 c8             	mov    %eax,-0x38(%ebp)
    bmp.height = infoHeader.biHeight;
    42d7:	8b 45 9a             	mov    -0x66(%ebp),%eax
    42da:	89 45 cc             	mov    %eax,-0x34(%ebp)
    //printf(1,"bitmap height: %d,bitmap width:%d",bmp.height,bmp.width);
    bmp.data = (AColor *)malloc(bmp.width * bmp.height * sizeof(AColor));
    42dd:	8b 55 c8             	mov    -0x38(%ebp),%edx
    42e0:	8b 45 cc             	mov    -0x34(%ebp),%eax
    42e3:	0f af d0             	imul   %eax,%edx
    42e6:	89 d0                	mov    %edx,%eax
    42e8:	01 c0                	add    %eax,%eax
    42ea:	01 d0                	add    %edx,%eax
    42ec:	83 ec 0c             	sub    $0xc,%esp
    42ef:	50                   	push   %eax
    42f0:	e8 a0 fd ff ff       	call   4095 <malloc>
    42f5:	83 c4 10             	add    $0x10,%esp
    42f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int c = infoHeader.biBitCount;
    42fb:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    42ff:	0f b7 c0             	movzwl %ax,%eax
    4302:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //printf(1, "%d %d %d\n", w, h, c);
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    4305:	8b 55 c8             	mov    -0x38(%ebp),%edx
    4308:	8b 45 e8             	mov    -0x18(%ebp),%eax
    430b:	0f af c2             	imul   %edx,%eax
    430e:	83 c0 1f             	add    $0x1f,%eax
    4311:	c1 e8 05             	shr    $0x5,%eax
    4314:	c1 e0 02             	shl    $0x2,%eax
    4317:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int s = l * bmp.height;
    431a:	8b 55 cc             	mov    -0x34(%ebp),%edx
    431d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4320:	0f af c2             	imul   %edx,%eax
    4323:	89 45 e0             	mov    %eax,-0x20(%ebp)
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    4326:	8b 45 e0             	mov    -0x20(%ebp),%eax
    4329:	83 ec 0c             	sub    $0xc,%esp
    432c:	50                   	push   %eax
    432d:	e8 63 fd ff ff       	call   4095 <malloc>
    4332:	83 c4 10             	add    $0x10,%esp
    4335:	89 45 dc             	mov    %eax,-0x24(%ebp)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    4338:	83 ec 04             	sub    $0x4,%esp
    433b:	ff 75 e0             	pushl  -0x20(%ebp)
    433e:	ff 75 dc             	pushl  -0x24(%ebp)
    4341:	ff 75 ec             	pushl  -0x14(%ebp)
    4344:	e8 d2 f8 ff ff       	call   3c1b <read>
    4349:	83 c4 10             	add    $0x10,%esp
    int bit = infoHeader.biBitCount / 8;
    434c:	0f b7 45 a0          	movzwl -0x60(%ebp),%eax
    4350:	66 c1 e8 03          	shr    $0x3,%ax
    4354:	0f b7 c0             	movzwl %ax,%eax
    4357:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < bmp.height; ++j)
    435a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4361:	e9 e5 00 00 00       	jmp    444b <APLoadBitmap+0x203>
    {
        int off = (bmp.height - j - 1) * bmp.width;
    4366:	8b 55 cc             	mov    -0x34(%ebp),%edx
    4369:	8b 45 f4             	mov    -0xc(%ebp),%eax
    436c:	29 c2                	sub    %eax,%edx
    436e:	89 d0                	mov    %edx,%eax
    4370:	8d 50 ff             	lea    -0x1(%eax),%edx
    4373:	8b 45 c8             	mov    -0x38(%ebp),%eax
    4376:	0f af c2             	imul   %edx,%eax
    4379:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        for (int i = 0; i < bmp.width; ++i)
    437c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4383:	e9 b1 00 00 00       	jmp    4439 <APLoadBitmap+0x1f1>
        {
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
    4388:	8b 55 d0             	mov    -0x30(%ebp),%edx
    438b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    438e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4391:	01 c8                	add    %ecx,%eax
    4393:	89 c1                	mov    %eax,%ecx
    4395:	89 c8                	mov    %ecx,%eax
    4397:	01 c0                	add    %eax,%eax
    4399:	01 c8                	add    %ecx,%eax
    439b:	01 c2                	add    %eax,%edx
    439d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43a0:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    43a4:	89 c1                	mov    %eax,%ecx
    43a6:	8b 45 d8             	mov    -0x28(%ebp),%eax
    43a9:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    43ad:	01 c1                	add    %eax,%ecx
    43af:	8b 45 d8             	mov    -0x28(%ebp),%eax
    43b2:	01 c8                	add    %ecx,%eax
    43b4:	8d 48 ff             	lea    -0x1(%eax),%ecx
    43b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
    43ba:	01 c8                	add    %ecx,%eax
    43bc:	0f b6 00             	movzbl (%eax),%eax
    43bf:	88 42 02             	mov    %al,0x2(%edx)
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
    43c2:	8b 55 d0             	mov    -0x30(%ebp),%edx
    43c5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    43c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43cb:	01 c8                	add    %ecx,%eax
    43cd:	89 c1                	mov    %eax,%ecx
    43cf:	89 c8                	mov    %ecx,%eax
    43d1:	01 c0                	add    %eax,%eax
    43d3:	01 c8                	add    %ecx,%eax
    43d5:	01 c2                	add    %eax,%edx
    43d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43da:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    43de:	89 c1                	mov    %eax,%ecx
    43e0:	8b 45 d8             	mov    -0x28(%ebp),%eax
    43e3:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    43e7:	01 c1                	add    %eax,%ecx
    43e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
    43ec:	01 c8                	add    %ecx,%eax
    43ee:	8d 48 fe             	lea    -0x2(%eax),%ecx
    43f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    43f4:	01 c8                	add    %ecx,%eax
    43f6:	0f b6 00             	movzbl (%eax),%eax
    43f9:	88 42 01             	mov    %al,0x1(%edx)
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
    43fc:	8b 55 d0             	mov    -0x30(%ebp),%edx
    43ff:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    4402:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4405:	01 c8                	add    %ecx,%eax
    4407:	89 c1                	mov    %eax,%ecx
    4409:	89 c8                	mov    %ecx,%eax
    440b:	01 c0                	add    %eax,%eax
    440d:	01 c8                	add    %ecx,%eax
    440f:	01 c2                	add    %eax,%edx
    4411:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4414:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    4418:	89 c1                	mov    %eax,%ecx
    441a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    441d:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    4421:	01 c1                	add    %eax,%ecx
    4423:	8b 45 d8             	mov    -0x28(%ebp),%eax
    4426:	01 c8                	add    %ecx,%eax
    4428:	8d 48 fd             	lea    -0x3(%eax),%ecx
    442b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    442e:	01 c8                	add    %ecx,%eax
    4430:	0f b6 00             	movzbl (%eax),%eax
    4433:	88 02                	mov    %al,(%edx)
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    {
        int off = (bmp.height - j - 1) * bmp.width;
        for (int i = 0; i < bmp.width; ++i)
    4435:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    4439:	8b 55 c8             	mov    -0x38(%ebp),%edx
    443c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    443f:	39 c2                	cmp    %eax,%edx
    4441:	0f 87 41 ff ff ff    	ja     4388 <APLoadBitmap+0x140>
    int l = (((bmp.width * c) + 31) >> 5) << 2;
    int s = l * bmp.height;
    unsigned char * data = (unsigned char *)malloc(sizeof(unsigned char) * s);
    read(fd, (char *)data, sizeof(unsigned char) * s);
    int bit = infoHeader.biBitCount / 8;
    for (int j = 0; j < bmp.height; ++j)
    4447:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    444b:	8b 55 cc             	mov    -0x34(%ebp),%edx
    444e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4451:	39 c2                	cmp    %eax,%edx
    4453:	0f 87 0d ff ff ff    	ja     4366 <APLoadBitmap+0x11e>
            bmp.data[off + i].r = (int)data[j * l + bit * i + bit - 1];
            bmp.data[off + i].g = (int)data[j * l + bit * i + bit - 2];
            bmp.data[off + i].b = (int)data[j * l + bit * i + bit - 3];
        }
    }
    close(fd);
    4459:	83 ec 0c             	sub    $0xc,%esp
    445c:	ff 75 ec             	pushl  -0x14(%ebp)
    445f:	e8 c7 f7 ff ff       	call   3c2b <close>
    4464:	83 c4 10             	add    $0x10,%esp
    return bmp;
    4467:	8b 45 08             	mov    0x8(%ebp),%eax
    446a:	8b 55 c8             	mov    -0x38(%ebp),%edx
    446d:	89 10                	mov    %edx,(%eax)
    446f:	8b 55 cc             	mov    -0x34(%ebp),%edx
    4472:	89 50 04             	mov    %edx,0x4(%eax)
    4475:	8b 55 d0             	mov    -0x30(%ebp),%edx
    4478:	89 50 08             	mov    %edx,0x8(%eax)
}
    447b:	8b 45 08             	mov    0x8(%ebp),%eax
    447e:	c9                   	leave  
    447f:	c2 04 00             	ret    $0x4

00004482 <APCreateCompatibleDCFromBitmap>:

AHdc APCreateCompatibleDCFromBitmap(ABitmap bmp)
{
    4482:	55                   	push   %ebp
    4483:	89 e5                	mov    %esp,%ebp
    4485:	53                   	push   %ebx
    4486:	83 ec 24             	sub    $0x24,%esp
    AHdc hdc = (AHdc)malloc(sizeof(ADc));
    4489:	83 ec 0c             	sub    $0xc,%esp
    448c:	6a 1c                	push   $0x1c
    448e:	e8 02 fc ff ff       	call   4095 <malloc>
    4493:	83 c4 10             	add    $0x10,%esp
    4496:	89 45 f4             	mov    %eax,-0xc(%ebp)
    hdc->pen.size = 0;
    4499:	8b 45 f4             	mov    -0xc(%ebp),%eax
    449c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    hdc->pen.color = hdc->brush.color = hdc->font.color = COLOR_NULL;
    44a3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    44a6:	8d 45 d8             	lea    -0x28(%ebp),%eax
    44a9:	6a 0c                	push   $0xc
    44ab:	6a 0c                	push   $0xc
    44ad:	6a 0c                	push   $0xc
    44af:	50                   	push   %eax
    44b0:	e8 c3 fc ff ff       	call   4178 <RGB>
    44b5:	83 c4 0c             	add    $0xc,%esp
    44b8:	0f b7 45 d8          	movzwl -0x28(%ebp),%eax
    44bc:	66 89 43 13          	mov    %ax,0x13(%ebx)
    44c0:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
    44c4:	88 43 15             	mov    %al,0x15(%ebx)
    44c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
    44cd:	0f b7 4a 13          	movzwl 0x13(%edx),%ecx
    44d1:	66 89 48 10          	mov    %cx,0x10(%eax)
    44d5:	0f b6 52 15          	movzbl 0x15(%edx),%edx
    44d9:	88 50 12             	mov    %dl,0x12(%eax)
    44dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44df:	8b 55 f4             	mov    -0xc(%ebp),%edx
    44e2:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
    44e6:	66 89 48 08          	mov    %cx,0x8(%eax)
    44ea:	0f b6 52 12          	movzbl 0x12(%edx),%edx
    44ee:	88 50 0a             	mov    %dl,0xa(%eax)
    hdc->size.cx = bmp.width;
    44f1:	8b 45 08             	mov    0x8(%ebp),%eax
    44f4:	89 c2                	mov    %eax,%edx
    44f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44f9:	89 10                	mov    %edx,(%eax)
    hdc->size.cy = bmp.height;
    44fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    44fe:	89 c2                	mov    %eax,%edx
    4500:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4503:	89 50 04             	mov    %edx,0x4(%eax)
    hdc->content = bmp.data;
    4506:	8b 55 10             	mov    0x10(%ebp),%edx
    4509:	8b 45 f4             	mov    -0xc(%ebp),%eax
    450c:	89 50 18             	mov    %edx,0x18(%eax)
    //printf(1, "size of bitmap: %d %d %d\n", hdc->size.cx, hdc->size.cy,sizeof(hdc->content));
    return hdc;
    450f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    4512:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4515:	c9                   	leave  
    4516:	c3                   	ret    

00004517 <APSetPen>:

//--------------------------------settings---------------------------
APen APSetPen(AHdc hdc, APen pen)
{
    4517:	55                   	push   %ebp
    4518:	89 e5                	mov    %esp,%ebp
    451a:	83 ec 10             	sub    $0x10,%esp
    APen r = hdc->pen;
    451d:	8b 45 0c             	mov    0xc(%ebp),%eax
    4520:	8b 50 08             	mov    0x8(%eax),%edx
    4523:	89 55 f8             	mov    %edx,-0x8(%ebp)
    4526:	8b 40 0c             	mov    0xc(%eax),%eax
    4529:	89 45 fc             	mov    %eax,-0x4(%ebp)
    hdc->pen = pen;
    452c:	8b 45 0c             	mov    0xc(%ebp),%eax
    452f:	8b 55 10             	mov    0x10(%ebp),%edx
    4532:	89 50 08             	mov    %edx,0x8(%eax)
    4535:	8b 55 14             	mov    0x14(%ebp),%edx
    4538:	89 50 0c             	mov    %edx,0xc(%eax)
    return r;
    453b:	8b 45 08             	mov    0x8(%ebp),%eax
    453e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4541:	89 10                	mov    %edx,(%eax)
    4543:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4546:	89 50 04             	mov    %edx,0x4(%eax)
}
    4549:	8b 45 08             	mov    0x8(%ebp),%eax
    454c:	c9                   	leave  
    454d:	c2 04 00             	ret    $0x4

00004550 <APSetBrush>:

ABrush APSetBrush(AHdc hdc, ABrush brush)
{
    4550:	55                   	push   %ebp
    4551:	89 e5                	mov    %esp,%ebp
    4553:	83 ec 10             	sub    $0x10,%esp
    ABrush r = hdc->brush;
    4556:	8b 45 0c             	mov    0xc(%ebp),%eax
    4559:	0f b7 50 10          	movzwl 0x10(%eax),%edx
    455d:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    4561:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    4565:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->brush = brush;
    4568:	8b 45 0c             	mov    0xc(%ebp),%eax
    456b:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    456f:	66 89 50 10          	mov    %dx,0x10(%eax)
    4573:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    4577:	88 50 12             	mov    %dl,0x12(%eax)
    return r;
    457a:	8b 45 08             	mov    0x8(%ebp),%eax
    457d:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    4581:	66 89 10             	mov    %dx,(%eax)
    4584:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    4588:	88 50 02             	mov    %dl,0x2(%eax)
}
    458b:	8b 45 08             	mov    0x8(%ebp),%eax
    458e:	c9                   	leave  
    458f:	c2 04 00             	ret    $0x4

00004592 <APSetFont>:

AFont APSetFont(AHdc hdc,AFont font)
{
    4592:	55                   	push   %ebp
    4593:	89 e5                	mov    %esp,%ebp
    4595:	83 ec 10             	sub    $0x10,%esp
    AFont r = hdc->font;
    4598:	8b 45 0c             	mov    0xc(%ebp),%eax
    459b:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    459f:	66 89 55 fd          	mov    %dx,-0x3(%ebp)
    45a3:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    45a7:	88 45 ff             	mov    %al,-0x1(%ebp)
    hdc->font = font;
    45aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    45ad:	0f b7 55 10          	movzwl 0x10(%ebp),%edx
    45b1:	66 89 50 13          	mov    %dx,0x13(%eax)
    45b5:	0f b6 55 12          	movzbl 0x12(%ebp),%edx
    45b9:	88 50 15             	mov    %dl,0x15(%eax)
    return r;
    45bc:	8b 45 08             	mov    0x8(%ebp),%eax
    45bf:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    45c3:	66 89 10             	mov    %dx,(%eax)
    45c6:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    45ca:	88 50 02             	mov    %dl,0x2(%eax)
}
    45cd:	8b 45 08             	mov    0x8(%ebp),%eax
    45d0:	c9                   	leave  
    45d1:	c2 04 00             	ret    $0x4

000045d4 <APDrawPoint>:


//--------------------------------drawing----------------------------

void APDrawPoint(AHdc hdc, int x, int y)
{
    45d4:	55                   	push   %ebp
    45d5:	89 e5                	mov    %esp,%ebp
    45d7:	83 ec 20             	sub    $0x20,%esp
    int i, j, t;
    int off = hdc->pen.size / 2;
    45da:	8b 45 08             	mov    0x8(%ebp),%eax
    45dd:	8b 40 0c             	mov    0xc(%eax),%eax
    45e0:	89 c2                	mov    %eax,%edx
    45e2:	c1 ea 1f             	shr    $0x1f,%edx
    45e5:	01 d0                	add    %edx,%eax
    45e7:	d1 f8                	sar    %eax
    45e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int d2 = off * off;
    45ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    45ef:	0f af 45 f4          	imul   -0xc(%ebp),%eax
    45f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    i = y - off;
    45f6:	8b 45 10             	mov    0x10(%ebp),%eax
    45f9:	2b 45 f4             	sub    -0xc(%ebp),%eax
    45fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (i < 0)
    45ff:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    4603:	0f 89 98 00 00 00    	jns    46a1 <APDrawPoint+0xcd>
        i = 0;
    4609:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for (; i <= y + off; ++i)
    4610:	e9 8c 00 00 00       	jmp    46a1 <APDrawPoint+0xcd>
    {
        j = x - off;
    4615:	8b 45 0c             	mov    0xc(%ebp),%eax
    4618:	2b 45 f4             	sub    -0xc(%ebp),%eax
    461b:	89 45 f8             	mov    %eax,-0x8(%ebp)
        if (j < 0)
    461e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    4622:	79 69                	jns    468d <APDrawPoint+0xb9>
            j = 0;
    4624:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
        for (; j <= x + off; ++j)
    462b:	eb 60                	jmp    468d <APDrawPoint+0xb9>
        {
            t = APGetIndex(hdc, j, i);
    462d:	ff 75 fc             	pushl  -0x4(%ebp)
    4630:	ff 75 f8             	pushl  -0x8(%ebp)
    4633:	ff 75 08             	pushl  0x8(%ebp)
    4636:	e8 bb fb ff ff       	call   41f6 <APGetIndex>
    463b:	83 c4 0c             	add    $0xc,%esp
    463e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            if (t == X_BIGGER)
    4641:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%ebp)
    4645:	74 55                	je     469c <APDrawPoint+0xc8>
                break;
            if (t == Y_BIGGER)
    4647:	83 7d ec fd          	cmpl   $0xfffffffd,-0x14(%ebp)
    464b:	74 67                	je     46b4 <APDrawPoint+0xe0>
                return;
            if (distance_2(j, i, x, y) <= d2)
    464d:	ff 75 10             	pushl  0x10(%ebp)
    4650:	ff 75 0c             	pushl  0xc(%ebp)
    4653:	ff 75 fc             	pushl  -0x4(%ebp)
    4656:	ff 75 f8             	pushl  -0x8(%ebp)
    4659:	e8 5f fb ff ff       	call   41bd <distance_2>
    465e:	83 c4 10             	add    $0x10,%esp
    4661:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    4664:	7f 23                	jg     4689 <APDrawPoint+0xb5>
                hdc->content[t] = hdc->pen.color;
    4666:	8b 45 08             	mov    0x8(%ebp),%eax
    4669:	8b 48 18             	mov    0x18(%eax),%ecx
    466c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    466f:	89 d0                	mov    %edx,%eax
    4671:	01 c0                	add    %eax,%eax
    4673:	01 d0                	add    %edx,%eax
    4675:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    4678:	8b 45 08             	mov    0x8(%ebp),%eax
    467b:	0f b7 48 08          	movzwl 0x8(%eax),%ecx
    467f:	66 89 0a             	mov    %cx,(%edx)
    4682:	0f b6 40 0a          	movzbl 0xa(%eax),%eax
    4686:	88 42 02             	mov    %al,0x2(%edx)
    for (; i <= y + off; ++i)
    {
        j = x - off;
        if (j < 0)
            j = 0;
        for (; j <= x + off; ++j)
    4689:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    468d:	8b 55 0c             	mov    0xc(%ebp),%edx
    4690:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4693:	01 d0                	add    %edx,%eax
    4695:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4698:	7d 93                	jge    462d <APDrawPoint+0x59>
    469a:	eb 01                	jmp    469d <APDrawPoint+0xc9>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
    469c:	90                   	nop
    int off = hdc->pen.size / 2;
    int d2 = off * off;
    i = y - off;
    if (i < 0)
        i = 0;
    for (; i <= y + off; ++i)
    469d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    46a1:	8b 55 10             	mov    0x10(%ebp),%edx
    46a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    46a7:	01 d0                	add    %edx,%eax
    46a9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    46ac:	0f 8d 63 ff ff ff    	jge    4615 <APDrawPoint+0x41>
    46b2:	eb 01                	jmp    46b5 <APDrawPoint+0xe1>
        {
            t = APGetIndex(hdc, j, i);
            if (t == X_BIGGER)
                break;
            if (t == Y_BIGGER)
                return;
    46b4:	90                   	nop
            if (distance_2(j, i, x, y) <= d2)
                hdc->content[t] = hdc->pen.color;
        }
    }
}
    46b5:	c9                   	leave  
    46b6:	c3                   	ret    

000046b7 <APDrawLine>:

void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    46b7:	55                   	push   %ebp
    46b8:	89 e5                	mov    %esp,%ebp
    46ba:	53                   	push   %ebx
    46bb:	83 ec 4c             	sub    $0x4c,%esp
    if (x1 == x2)
    46be:	8b 45 0c             	mov    0xc(%ebp),%eax
    46c1:	3b 45 14             	cmp    0x14(%ebp),%eax
    46c4:	0f 85 80 00 00 00    	jne    474a <APDrawLine+0x93>
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
    46ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    46ce:	0f 88 9d 02 00 00    	js     4971 <APDrawLine+0x2ba>
    46d4:	8b 45 08             	mov    0x8(%ebp),%eax
    46d7:	8b 00                	mov    (%eax),%eax
    46d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
    46dc:	0f 8e 8f 02 00 00    	jle    4971 <APDrawLine+0x2ba>
            return;
        if (y1 > y2)
    46e2:	8b 45 10             	mov    0x10(%ebp),%eax
    46e5:	3b 45 18             	cmp    0x18(%ebp),%eax
    46e8:	7e 12                	jle    46fc <APDrawLine+0x45>
        {
            int tmp = y2;
    46ea:	8b 45 18             	mov    0x18(%ebp),%eax
    46ed:	89 45 dc             	mov    %eax,-0x24(%ebp)
            y2 = y1;
    46f0:	8b 45 10             	mov    0x10(%ebp),%eax
    46f3:	89 45 18             	mov    %eax,0x18(%ebp)
            y1 = tmp;
    46f6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    46f9:	89 45 10             	mov    %eax,0x10(%ebp)
        }
        if (y1 < 0) y1 = 0;
    46fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    4700:	79 07                	jns    4709 <APDrawLine+0x52>
    4702:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
    4709:	8b 45 08             	mov    0x8(%ebp),%eax
    470c:	8b 40 04             	mov    0x4(%eax),%eax
    470f:	3b 45 18             	cmp    0x18(%ebp),%eax
    4712:	7d 0c                	jge    4720 <APDrawLine+0x69>
    4714:	8b 45 08             	mov    0x8(%ebp),%eax
    4717:	8b 40 04             	mov    0x4(%eax),%eax
    471a:	83 e8 01             	sub    $0x1,%eax
    471d:	89 45 18             	mov    %eax,0x18(%ebp)
        for (int j = y1; j <= y2;j++ )
    4720:	8b 45 10             	mov    0x10(%ebp),%eax
    4723:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4726:	eb 15                	jmp    473d <APDrawLine+0x86>
            APDrawPoint(hdc,x1,j);
    4728:	ff 75 f4             	pushl  -0xc(%ebp)
    472b:	ff 75 0c             	pushl  0xc(%ebp)
    472e:	ff 75 08             	pushl  0x8(%ebp)
    4731:	e8 9e fe ff ff       	call   45d4 <APDrawPoint>
    4736:	83 c4 0c             	add    $0xc,%esp
            y2 = y1;
            y1 = tmp;
        }
        if (y1 < 0) y1 = 0;
        if (y2 > hdc->size.cy) y2 = hdc->size.cy - 1;
        for (int j = y1; j <= y2;j++ )
    4739:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    473d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4740:	3b 45 18             	cmp    0x18(%ebp),%eax
    4743:	7e e3                	jle    4728 <APDrawLine+0x71>
            APDrawPoint(hdc,x1,j);
        return;
    4745:	e9 2b 02 00 00       	jmp    4975 <APDrawLine+0x2be>
    }
    else if (y1 == y2)
    474a:	8b 45 10             	mov    0x10(%ebp),%eax
    474d:	3b 45 18             	cmp    0x18(%ebp),%eax
    4750:	75 7f                	jne    47d1 <APDrawLine+0x11a>
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
    4752:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    4756:	0f 88 18 02 00 00    	js     4974 <APDrawLine+0x2bd>
    475c:	8b 45 08             	mov    0x8(%ebp),%eax
    475f:	8b 40 04             	mov    0x4(%eax),%eax
    4762:	3b 45 10             	cmp    0x10(%ebp),%eax
    4765:	0f 8e 09 02 00 00    	jle    4974 <APDrawLine+0x2bd>
            return;
        if (x1 > x2)
    476b:	8b 45 0c             	mov    0xc(%ebp),%eax
    476e:	3b 45 14             	cmp    0x14(%ebp),%eax
    4771:	7e 12                	jle    4785 <APDrawLine+0xce>
        {
            int tmp = x2;
    4773:	8b 45 14             	mov    0x14(%ebp),%eax
    4776:	89 45 d8             	mov    %eax,-0x28(%ebp)
            x2 = x1;
    4779:	8b 45 0c             	mov    0xc(%ebp),%eax
    477c:	89 45 14             	mov    %eax,0x14(%ebp)
            x1 = tmp;
    477f:	8b 45 d8             	mov    -0x28(%ebp),%eax
    4782:	89 45 0c             	mov    %eax,0xc(%ebp)
        }
        if (x1 < 0) x1 = 0;
    4785:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    4789:	79 07                	jns    4792 <APDrawLine+0xdb>
    478b:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
    4792:	8b 45 08             	mov    0x8(%ebp),%eax
    4795:	8b 00                	mov    (%eax),%eax
    4797:	3b 45 14             	cmp    0x14(%ebp),%eax
    479a:	7d 0b                	jge    47a7 <APDrawLine+0xf0>
    479c:	8b 45 08             	mov    0x8(%ebp),%eax
    479f:	8b 00                	mov    (%eax),%eax
    47a1:	83 e8 01             	sub    $0x1,%eax
    47a4:	89 45 14             	mov    %eax,0x14(%ebp)
        for (int i = x1 ; i <= x2; i++)
    47a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    47aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    47ad:	eb 15                	jmp    47c4 <APDrawLine+0x10d>
            APDrawPoint(hdc,i,y1);
    47af:	ff 75 10             	pushl  0x10(%ebp)
    47b2:	ff 75 f0             	pushl  -0x10(%ebp)
    47b5:	ff 75 08             	pushl  0x8(%ebp)
    47b8:	e8 17 fe ff ff       	call   45d4 <APDrawPoint>
    47bd:	83 c4 0c             	add    $0xc,%esp
            x2 = x1;
            x1 = tmp;
        }
        if (x1 < 0) x1 = 0;
        if (x2 > hdc->size.cx) x2 = hdc->size.cx - 1;
        for (int i = x1 ; i <= x2; i++)
    47c0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    47c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    47c7:	3b 45 14             	cmp    0x14(%ebp),%eax
    47ca:	7e e3                	jle    47af <APDrawLine+0xf8>
            APDrawPoint(hdc,i,y1);
        return;
    47cc:	e9 a4 01 00 00       	jmp    4975 <APDrawLine+0x2be>
    }
    
    int s = 0,e = 0;
    47d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    47d8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    if (abs_int(x1 - x2) > abs_int(y1 - y2))
    47df:	8b 45 0c             	mov    0xc(%ebp),%eax
    47e2:	2b 45 14             	sub    0x14(%ebp),%eax
    47e5:	50                   	push   %eax
    47e6:	e8 fb f9 ff ff       	call   41e6 <abs_int>
    47eb:	83 c4 04             	add    $0x4,%esp
    47ee:	89 c3                	mov    %eax,%ebx
    47f0:	8b 45 10             	mov    0x10(%ebp),%eax
    47f3:	2b 45 18             	sub    0x18(%ebp),%eax
    47f6:	50                   	push   %eax
    47f7:	e8 ea f9 ff ff       	call   41e6 <abs_int>
    47fc:	83 c4 04             	add    $0x4,%esp
    47ff:	39 c3                	cmp    %eax,%ebx
    4801:	0f 8e b5 00 00 00    	jle    48bc <APDrawLine+0x205>
    {
        double angle = (double)(y1 - y2) / (double)(x1 - x2);
    4807:	8b 45 10             	mov    0x10(%ebp),%eax
    480a:	2b 45 18             	sub    0x18(%ebp),%eax
    480d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    4810:	db 45 b0             	fildl  -0x50(%ebp)
    4813:	8b 45 0c             	mov    0xc(%ebp),%eax
    4816:	2b 45 14             	sub    0x14(%ebp),%eax
    4819:	89 45 b0             	mov    %eax,-0x50(%ebp)
    481c:	db 45 b0             	fildl  -0x50(%ebp)
    481f:	de f9                	fdivrp %st,%st(1)
    4821:	dd 5d d0             	fstpl  -0x30(%ebp)
        if (x2 > x1)
    4824:	8b 45 14             	mov    0x14(%ebp),%eax
    4827:	3b 45 0c             	cmp    0xc(%ebp),%eax
    482a:	7e 0e                	jle    483a <APDrawLine+0x183>
        {
            s = x1;
    482c:	8b 45 0c             	mov    0xc(%ebp),%eax
    482f:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x2;
    4832:	8b 45 14             	mov    0x14(%ebp),%eax
    4835:	89 45 e8             	mov    %eax,-0x18(%ebp)
    4838:	eb 0c                	jmp    4846 <APDrawLine+0x18f>
        }
        else
        {
            s = x2;
    483a:	8b 45 14             	mov    0x14(%ebp),%eax
    483d:	89 45 ec             	mov    %eax,-0x14(%ebp)
            e = x1;
    4840:	8b 45 0c             	mov    0xc(%ebp),%eax
    4843:	89 45 e8             	mov    %eax,-0x18(%ebp)
        }
        if (s < 0) s = 0;
    4846:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    484a:	79 07                	jns    4853 <APDrawLine+0x19c>
    484c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
    4853:	8b 45 08             	mov    0x8(%ebp),%eax
    4856:	8b 00                	mov    (%eax),%eax
    4858:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    485b:	7f 0b                	jg     4868 <APDrawLine+0x1b1>
    485d:	8b 45 08             	mov    0x8(%ebp),%eax
    4860:	8b 00                	mov    (%eax),%eax
    4862:	83 e8 01             	sub    $0x1,%eax
    4865:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (int i = s; i <= e; i++)
    4868:	8b 45 ec             	mov    -0x14(%ebp),%eax
    486b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    486e:	eb 3f                	jmp    48af <APDrawLine+0x1f8>
        {
            int j = (int)((i - x1) * angle + y1);
    4870:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4873:	2b 45 0c             	sub    0xc(%ebp),%eax
    4876:	89 45 b0             	mov    %eax,-0x50(%ebp)
    4879:	db 45 b0             	fildl  -0x50(%ebp)
    487c:	dc 4d d0             	fmull  -0x30(%ebp)
    487f:	db 45 10             	fildl  0x10(%ebp)
    4882:	de c1                	faddp  %st,%st(1)
    4884:	d9 7d b6             	fnstcw -0x4a(%ebp)
    4887:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    488b:	b4 0c                	mov    $0xc,%ah
    488d:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    4891:	d9 6d b4             	fldcw  -0x4c(%ebp)
    4894:	db 5d cc             	fistpl -0x34(%ebp)
    4897:	d9 6d b6             	fldcw  -0x4a(%ebp)
            APDrawPoint(hdc,i,j);
    489a:	ff 75 cc             	pushl  -0x34(%ebp)
    489d:	ff 75 e4             	pushl  -0x1c(%ebp)
    48a0:	ff 75 08             	pushl  0x8(%ebp)
    48a3:	e8 2c fd ff ff       	call   45d4 <APDrawPoint>
    48a8:	83 c4 0c             	add    $0xc,%esp
            s = x2;
            e = x1;
        }
        if (s < 0) s = 0;
        if (e >= hdc->size.cx) e = hdc->size.cx - 1;
        for (int i = s; i <= e; i++)
    48ab:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    48af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    48b2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    48b5:	7e b9                	jle    4870 <APDrawLine+0x1b9>
        {
            int j = (int)((i - x1) * angle + y1);
            APDrawPoint(hdc,i,j);
        }
        return;
    48b7:	e9 b9 00 00 00       	jmp    4975 <APDrawLine+0x2be>
    }
    double angle = (double)(x1 - x2)/(double)(y1 - y2);
    48bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    48bf:	2b 45 14             	sub    0x14(%ebp),%eax
    48c2:	89 45 b0             	mov    %eax,-0x50(%ebp)
    48c5:	db 45 b0             	fildl  -0x50(%ebp)
    48c8:	8b 45 10             	mov    0x10(%ebp),%eax
    48cb:	2b 45 18             	sub    0x18(%ebp),%eax
    48ce:	89 45 b0             	mov    %eax,-0x50(%ebp)
    48d1:	db 45 b0             	fildl  -0x50(%ebp)
    48d4:	de f9                	fdivrp %st,%st(1)
    48d6:	dd 5d c0             	fstpl  -0x40(%ebp)
    if (y1 > y2)
    48d9:	8b 45 10             	mov    0x10(%ebp),%eax
    48dc:	3b 45 18             	cmp    0x18(%ebp),%eax
    48df:	7e 0e                	jle    48ef <APDrawLine+0x238>
    {
        s = y2;
    48e1:	8b 45 18             	mov    0x18(%ebp),%eax
    48e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y1;
    48e7:	8b 45 10             	mov    0x10(%ebp),%eax
    48ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
    48ed:	eb 0c                	jmp    48fb <APDrawLine+0x244>
    }
    else
    {
        s = y1;
    48ef:	8b 45 10             	mov    0x10(%ebp),%eax
    48f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
        e = y2;
    48f5:	8b 45 18             	mov    0x18(%ebp),%eax
    48f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    }
    if (s < 0)  s = 0;
    48fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    48ff:	79 07                	jns    4908 <APDrawLine+0x251>
    4901:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    4908:	8b 45 08             	mov    0x8(%ebp),%eax
    490b:	8b 40 04             	mov    0x4(%eax),%eax
    490e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    4911:	7f 0c                	jg     491f <APDrawLine+0x268>
    4913:	8b 45 08             	mov    0x8(%ebp),%eax
    4916:	8b 40 04             	mov    0x4(%eax),%eax
    4919:	83 e8 01             	sub    $0x1,%eax
    491c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for (int j = s; j <= e; j++)
    491f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4922:	89 45 e0             	mov    %eax,-0x20(%ebp)
    4925:	eb 3f                	jmp    4966 <APDrawLine+0x2af>
    {
        int i = (int)((j - y1)*angle + x1);
    4927:	8b 45 e0             	mov    -0x20(%ebp),%eax
    492a:	2b 45 10             	sub    0x10(%ebp),%eax
    492d:	89 45 b0             	mov    %eax,-0x50(%ebp)
    4930:	db 45 b0             	fildl  -0x50(%ebp)
    4933:	dc 4d c0             	fmull  -0x40(%ebp)
    4936:	db 45 0c             	fildl  0xc(%ebp)
    4939:	de c1                	faddp  %st,%st(1)
    493b:	d9 7d b6             	fnstcw -0x4a(%ebp)
    493e:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
    4942:	b4 0c                	mov    $0xc,%ah
    4944:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
    4948:	d9 6d b4             	fldcw  -0x4c(%ebp)
    494b:	db 5d bc             	fistpl -0x44(%ebp)
    494e:	d9 6d b6             	fldcw  -0x4a(%ebp)
        APDrawPoint(hdc,i,j);
    4951:	ff 75 e0             	pushl  -0x20(%ebp)
    4954:	ff 75 bc             	pushl  -0x44(%ebp)
    4957:	ff 75 08             	pushl  0x8(%ebp)
    495a:	e8 75 fc ff ff       	call   45d4 <APDrawPoint>
    495f:	83 c4 0c             	add    $0xc,%esp
        s = y1;
        e = y2;
    }
    if (s < 0)  s = 0;
    if (e >= hdc->size.cy) e = hdc->size.cy - 1;
    for (int j = s; j <= e; j++)
    4962:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    4966:	8b 45 e0             	mov    -0x20(%ebp),%eax
    4969:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    496c:	7e b9                	jle    4927 <APDrawLine+0x270>
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
    496e:	90                   	nop
    496f:	eb 04                	jmp    4975 <APDrawLine+0x2be>
void APDrawLine(AHdc hdc,int x1, int y1,int x2,int y2)
{
    if (x1 == x2)
    {
        if (x1 < 0 || x1 >= hdc->size.cx)
            return;
    4971:	90                   	nop
    4972:	eb 01                	jmp    4975 <APDrawLine+0x2be>
        return;
    }
    else if (y1 == y2)
    {
        if (y1 < 0 || y1 >= hdc->size.cy)
            return;
    4974:	90                   	nop
    {
        int i = (int)((j - y1)*angle + x1);
        APDrawPoint(hdc,i,j);
    }
    return;
}
    4975:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4978:	c9                   	leave  
    4979:	c3                   	ret    

0000497a <APDrawRect>:

void APDrawRect(AHdc hdc, int x, int y, int w, int h)
{
    497a:	55                   	push   %ebp
    497b:	89 e5                	mov    %esp,%ebp
    497d:	53                   	push   %ebx
    497e:	83 ec 24             	sub    $0x24,%esp
    //edge - color
    APDrawLine(hdc,x,y,x,y+h-1);
    4981:	8b 55 10             	mov    0x10(%ebp),%edx
    4984:	8b 45 18             	mov    0x18(%ebp),%eax
    4987:	01 d0                	add    %edx,%eax
    4989:	83 e8 01             	sub    $0x1,%eax
    498c:	83 ec 04             	sub    $0x4,%esp
    498f:	50                   	push   %eax
    4990:	ff 75 0c             	pushl  0xc(%ebp)
    4993:	ff 75 10             	pushl  0x10(%ebp)
    4996:	ff 75 0c             	pushl  0xc(%ebp)
    4999:	ff 75 08             	pushl  0x8(%ebp)
    499c:	e8 16 fd ff ff       	call   46b7 <APDrawLine>
    49a1:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y,x+w-1,y);
    49a4:	8b 55 0c             	mov    0xc(%ebp),%edx
    49a7:	8b 45 14             	mov    0x14(%ebp),%eax
    49aa:	01 d0                	add    %edx,%eax
    49ac:	83 e8 01             	sub    $0x1,%eax
    49af:	83 ec 04             	sub    $0x4,%esp
    49b2:	ff 75 10             	pushl  0x10(%ebp)
    49b5:	50                   	push   %eax
    49b6:	ff 75 10             	pushl  0x10(%ebp)
    49b9:	ff 75 0c             	pushl  0xc(%ebp)
    49bc:	ff 75 08             	pushl  0x8(%ebp)
    49bf:	e8 f3 fc ff ff       	call   46b7 <APDrawLine>
    49c4:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x+w-1,y,x+w-1,y+h-1);
    49c7:	8b 55 10             	mov    0x10(%ebp),%edx
    49ca:	8b 45 18             	mov    0x18(%ebp),%eax
    49cd:	01 d0                	add    %edx,%eax
    49cf:	8d 48 ff             	lea    -0x1(%eax),%ecx
    49d2:	8b 55 0c             	mov    0xc(%ebp),%edx
    49d5:	8b 45 14             	mov    0x14(%ebp),%eax
    49d8:	01 d0                	add    %edx,%eax
    49da:	8d 50 ff             	lea    -0x1(%eax),%edx
    49dd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    49e0:	8b 45 14             	mov    0x14(%ebp),%eax
    49e3:	01 d8                	add    %ebx,%eax
    49e5:	83 e8 01             	sub    $0x1,%eax
    49e8:	83 ec 04             	sub    $0x4,%esp
    49eb:	51                   	push   %ecx
    49ec:	52                   	push   %edx
    49ed:	ff 75 10             	pushl  0x10(%ebp)
    49f0:	50                   	push   %eax
    49f1:	ff 75 08             	pushl  0x8(%ebp)
    49f4:	e8 be fc ff ff       	call   46b7 <APDrawLine>
    49f9:	83 c4 18             	add    $0x18,%esp
    APDrawLine(hdc,x,y+h-1,x+w-1,y+h-1);
    49fc:	8b 55 10             	mov    0x10(%ebp),%edx
    49ff:	8b 45 18             	mov    0x18(%ebp),%eax
    4a02:	01 d0                	add    %edx,%eax
    4a04:	8d 48 ff             	lea    -0x1(%eax),%ecx
    4a07:	8b 55 0c             	mov    0xc(%ebp),%edx
    4a0a:	8b 45 14             	mov    0x14(%ebp),%eax
    4a0d:	01 d0                	add    %edx,%eax
    4a0f:	8d 50 ff             	lea    -0x1(%eax),%edx
    4a12:	8b 5d 10             	mov    0x10(%ebp),%ebx
    4a15:	8b 45 18             	mov    0x18(%ebp),%eax
    4a18:	01 d8                	add    %ebx,%eax
    4a1a:	83 e8 01             	sub    $0x1,%eax
    4a1d:	83 ec 04             	sub    $0x4,%esp
    4a20:	51                   	push   %ecx
    4a21:	52                   	push   %edx
    4a22:	50                   	push   %eax
    4a23:	ff 75 0c             	pushl  0xc(%ebp)
    4a26:	ff 75 08             	pushl  0x8(%ebp)
    4a29:	e8 89 fc ff ff       	call   46b7 <APDrawLine>
    4a2e:	83 c4 18             	add    $0x18,%esp
    
    //fill - color
    int x_r = x + w - 1 - hdc->pen.size/2,
    4a31:	8b 55 0c             	mov    0xc(%ebp),%edx
    4a34:	8b 45 14             	mov    0x14(%ebp),%eax
    4a37:	01 d0                	add    %edx,%eax
    4a39:	8d 50 ff             	lea    -0x1(%eax),%edx
    4a3c:	8b 45 08             	mov    0x8(%ebp),%eax
    4a3f:	8b 40 0c             	mov    0xc(%eax),%eax
    4a42:	89 c1                	mov    %eax,%ecx
    4a44:	c1 e9 1f             	shr    $0x1f,%ecx
    4a47:	01 c8                	add    %ecx,%eax
    4a49:	d1 f8                	sar    %eax
    4a4b:	29 c2                	sub    %eax,%edx
    4a4d:	89 d0                	mov    %edx,%eax
    4a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        y_r = y + h - 1 - hdc->pen.size/2;
    4a52:	8b 55 10             	mov    0x10(%ebp),%edx
    4a55:	8b 45 18             	mov    0x18(%ebp),%eax
    4a58:	01 d0                	add    %edx,%eax
    4a5a:	8d 50 ff             	lea    -0x1(%eax),%edx
    4a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    4a60:	8b 40 0c             	mov    0xc(%eax),%eax
    4a63:	89 c1                	mov    %eax,%ecx
    4a65:	c1 e9 1f             	shr    $0x1f,%ecx
    4a68:	01 c8                	add    %ecx,%eax
    4a6a:	d1 f8                	sar    %eax
    4a6c:	29 c2                	sub    %eax,%edx
    4a6e:	89 d0                	mov    %edx,%eax
    4a70:	89 45 f0             	mov    %eax,-0x10(%ebp)
    x += hdc->pen.size/2;
    4a73:	8b 45 08             	mov    0x8(%ebp),%eax
    4a76:	8b 40 0c             	mov    0xc(%eax),%eax
    4a79:	89 c2                	mov    %eax,%edx
    4a7b:	c1 ea 1f             	shr    $0x1f,%edx
    4a7e:	01 d0                	add    %edx,%eax
    4a80:	d1 f8                	sar    %eax
    4a82:	01 45 0c             	add    %eax,0xc(%ebp)
    y += hdc->pen.size/2;
    4a85:	8b 45 08             	mov    0x8(%ebp),%eax
    4a88:	8b 40 0c             	mov    0xc(%eax),%eax
    4a8b:	89 c2                	mov    %eax,%edx
    4a8d:	c1 ea 1f             	shr    $0x1f,%edx
    4a90:	01 d0                	add    %edx,%eax
    4a92:	d1 f8                	sar    %eax
    4a94:	01 45 10             	add    %eax,0x10(%ebp)
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
    4a97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4a9b:	0f 88 d8 00 00 00    	js     4b79 <APDrawRect+0x1ff>
    4aa1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4aa5:	0f 88 ce 00 00 00    	js     4b79 <APDrawRect+0x1ff>
    4aab:	8b 45 08             	mov    0x8(%ebp),%eax
    4aae:	8b 00                	mov    (%eax),%eax
    4ab0:	3b 45 0c             	cmp    0xc(%ebp),%eax
    4ab3:	0f 8e c0 00 00 00    	jle    4b79 <APDrawRect+0x1ff>
    4ab9:	8b 45 08             	mov    0x8(%ebp),%eax
    4abc:	8b 40 04             	mov    0x4(%eax),%eax
    4abf:	3b 45 10             	cmp    0x10(%ebp),%eax
    4ac2:	0f 8e b1 00 00 00    	jle    4b79 <APDrawRect+0x1ff>
        return;
    
    if (x < 0) x = 0;
    4ac8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    4acc:	79 07                	jns    4ad5 <APDrawRect+0x15b>
    4ace:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%ebp)
    if (y < 0) y = 0;
    4ad5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    4ad9:	79 07                	jns    4ae2 <APDrawRect+0x168>
    4adb:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    4ae2:	8b 45 08             	mov    0x8(%ebp),%eax
    4ae5:	8b 00                	mov    (%eax),%eax
    4ae7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    4aea:	7f 0b                	jg     4af7 <APDrawRect+0x17d>
    4aec:	8b 45 08             	mov    0x8(%ebp),%eax
    4aef:	8b 00                	mov    (%eax),%eax
    4af1:	83 e8 01             	sub    $0x1,%eax
    4af4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    4af7:	8b 45 08             	mov    0x8(%ebp),%eax
    4afa:	8b 40 04             	mov    0x4(%eax),%eax
    4afd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    4b00:	7f 0c                	jg     4b0e <APDrawRect+0x194>
    4b02:	8b 45 08             	mov    0x8(%ebp),%eax
    4b05:	8b 40 04             	mov    0x4(%eax),%eax
    4b08:	83 e8 01             	sub    $0x1,%eax
    4b0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    
    int index = 0;
    4b0e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    4b15:	8b 45 0c             	mov    0xc(%ebp),%eax
    4b18:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4b1b:	eb 52                	jmp    4b6f <APDrawRect+0x1f5>
    {
        for (int j = y; j <= y_r; j++)
    4b1d:	8b 45 10             	mov    0x10(%ebp),%eax
    4b20:	89 45 e8             	mov    %eax,-0x18(%ebp)
    4b23:	eb 3e                	jmp    4b63 <APDrawRect+0x1e9>
        {
            index = APGetIndex(hdc,i,j);
    4b25:	83 ec 04             	sub    $0x4,%esp
    4b28:	ff 75 e8             	pushl  -0x18(%ebp)
    4b2b:	ff 75 ec             	pushl  -0x14(%ebp)
    4b2e:	ff 75 08             	pushl  0x8(%ebp)
    4b31:	e8 c0 f6 ff ff       	call   41f6 <APGetIndex>
    4b36:	83 c4 10             	add    $0x10,%esp
    4b39:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            hdc->content[index] = hdc->brush.color;
    4b3c:	8b 45 08             	mov    0x8(%ebp),%eax
    4b3f:	8b 48 18             	mov    0x18(%eax),%ecx
    4b42:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    4b45:	89 d0                	mov    %edx,%eax
    4b47:	01 c0                	add    %eax,%eax
    4b49:	01 d0                	add    %edx,%eax
    4b4b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    4b4e:	8b 45 08             	mov    0x8(%ebp),%eax
    4b51:	0f b7 48 10          	movzwl 0x10(%eax),%ecx
    4b55:	66 89 0a             	mov    %cx,(%edx)
    4b58:	0f b6 40 12          	movzbl 0x12(%eax),%eax
    4b5c:	88 42 02             	mov    %al,0x2(%edx)
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    {
        for (int j = y; j <= y_r; j++)
    4b5f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    4b63:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4b66:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    4b69:	7e ba                	jle    4b25 <APDrawRect+0x1ab>
    if (x_r >= hdc->size.cx) x_r = hdc->size.cx - 1;
    if (y_r >= hdc->size.cy) y_r = hdc->size.cy - 1;
    
    int index = 0;
    //cprintf("%d,%d,%d",hdc->brush.color.r,hdc->brush.color.g,hdc->pbrush.color.b);
    for (int i = x; i <= x_r; i++)
    4b6b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    4b6f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4b72:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    4b75:	7e a6                	jle    4b1d <APDrawRect+0x1a3>
    4b77:	eb 01                	jmp    4b7a <APDrawRect+0x200>
        y_r = y + h - 1 - hdc->pen.size/2;
    x += hdc->pen.size/2;
    y += hdc->pen.size/2;
    
    if (x_r < 0 || y_r < 0 || x >= hdc->size.cx || y >= hdc->size.cy)
        return;
    4b79:	90                   	nop
        {
            index = APGetIndex(hdc,i,j);
            hdc->content[index] = hdc->brush.color;
        }
    }
}
    4b7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    4b7d:	c9                   	leave  
    4b7e:	c3                   	ret    

00004b7f <APDrawText>:

//----------------------------Draw Text------------------------------
//Only support English letter
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    4b7f:	55                   	push   %ebp
    4b80:	89 e5                	mov    %esp,%ebp
    4b82:	83 ec 28             	sub    $0x28,%esp
    uint lenth = strlen(str);
    4b85:	83 ec 0c             	sub    $0xc,%esp
    4b88:	ff 75 0c             	pushl  0xc(%ebp)
    4b8b:	e8 b1 ee ff ff       	call   3a41 <strlen>
    4b90:	83 c4 10             	add    $0x10,%esp
    4b93:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    AColor c = hdc->font.color;
    4b96:	8b 45 08             	mov    0x8(%ebp),%eax
    4b99:	0f b7 50 13          	movzwl 0x13(%eax),%edx
    4b9d:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    4ba1:	0f b6 40 15          	movzbl 0x15(%eax),%eax
    4ba5:	88 45 df             	mov    %al,-0x21(%ebp)
    uint index = 0;
    4ba8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int z = 0; z < lenth; z++)
    4baf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4bb6:	e9 bc 00 00 00       	jmp    4c77 <APDrawText+0xf8>
    {
        index = (uint)str[z] - 32;
    4bbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    4bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
    4bc1:	01 d0                	add    %edx,%eax
    4bc3:	0f b6 00             	movzbl (%eax),%eax
    4bc6:	0f be c0             	movsbl %al,%eax
    4bc9:	83 e8 20             	sub    $0x20,%eax
    4bcc:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (index >= 0 && index < Alphabet_NUMBER)
    4bcf:	83 7d e0 5f          	cmpl   $0x5f,-0x20(%ebp)
    4bd3:	0f 87 9a 00 00 00    	ja     4c73 <APDrawText+0xf4>
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
    4bd9:	8b 45 08             	mov    0x8(%ebp),%eax
    4bdc:	8b 00                	mov    (%eax),%eax
    4bde:	0f af 45 14          	imul   0x14(%ebp),%eax
    4be2:	89 c2                	mov    %eax,%edx
    4be4:	8b 45 10             	mov    0x10(%ebp),%eax
    4be7:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    4bea:	8b 55 f4             	mov    -0xc(%ebp),%edx
    4bed:	89 d0                	mov    %edx,%eax
    4bef:	c1 e0 03             	shl    $0x3,%eax
    4bf2:	01 d0                	add    %edx,%eax
    4bf4:	01 c8                	add    %ecx,%eax
    4bf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    4bf9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    4c00:	eb 6b                	jmp    4c6d <APDrawText+0xee>
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    4c02:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    4c09:	eb 50                	jmp    4c5b <APDrawText+0xdc>
                {
                    if (Alphabet[index][i][j])
    4c0b:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4c0e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    4c11:	89 d0                	mov    %edx,%eax
    4c13:	c1 e0 03             	shl    $0x3,%eax
    4c16:	01 d0                	add    %edx,%eax
    4c18:	69 d1 a2 00 00 00    	imul   $0xa2,%ecx,%edx
    4c1e:	01 c2                	add    %eax,%edx
    4c20:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4c23:	01 d0                	add    %edx,%eax
    4c25:	05 20 80 00 00       	add    $0x8020,%eax
    4c2a:	0f b6 00             	movzbl (%eax),%eax
    4c2d:	84 c0                	test   %al,%al
    4c2f:	74 26                	je     4c57 <APDrawText+0xd8>
                        hdc->content[off + j] = c;
    4c31:	8b 45 08             	mov    0x8(%ebp),%eax
    4c34:	8b 50 18             	mov    0x18(%eax),%edx
    4c37:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    4c3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4c3d:	01 c8                	add    %ecx,%eax
    4c3f:	89 c1                	mov    %eax,%ecx
    4c41:	89 c8                	mov    %ecx,%eax
    4c43:	01 c0                	add    %eax,%eax
    4c45:	01 c8                	add    %ecx,%eax
    4c47:	01 d0                	add    %edx,%eax
    4c49:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    4c4d:	66 89 10             	mov    %dx,(%eax)
    4c50:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    4c54:	88 50 02             	mov    %dl,0x2(%eax)
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
            {
                for (int j = 0; j < Alphabet_WIDTH; j++)
    4c57:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    4c5b:	83 7d e8 08          	cmpl   $0x8,-0x18(%ebp)
    4c5f:	7e aa                	jle    4c0b <APDrawText+0x8c>
                {
                    if (Alphabet[index][i][j])
                        hdc->content[off + j] = c;
                }
                off += hdc->size.cx;
    4c61:	8b 45 08             	mov    0x8(%ebp),%eax
    4c64:	8b 00                	mov    (%eax),%eax
    4c66:	01 45 f0             	add    %eax,-0x10(%ebp)
    {
        index = (uint)str[z] - 32;
        if (index >= 0 && index < Alphabet_NUMBER)
        {
            int off = y * hdc->size.cx + x + z * Alphabet_WIDTH;
            for (int i = 0; i < Alphabet_HEIGHT; i++)
    4c69:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    4c6d:	83 7d ec 11          	cmpl   $0x11,-0x14(%ebp)
    4c71:	7e 8f                	jle    4c02 <APDrawText+0x83>
void APDrawText(AHdc hdc, char * str, int x, int y)
{
    uint lenth = strlen(str);
    AColor c = hdc->font.color;
    uint index = 0;
    for (int z = 0; z < lenth; z++)
    4c73:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    4c77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c7a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    4c7d:	0f 82 38 ff ff ff    	jb     4bbb <APDrawText+0x3c>
                }
                off += hdc->size.cx;
            }
        }
    }
}
    4c83:	90                   	nop
    4c84:	c9                   	leave  
    4c85:	c3                   	ret    

00004c86 <APDcCopy>:


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    4c86:	55                   	push   %ebp
    4c87:	89 e5                	mov    %esp,%ebp
    4c89:	83 ec 30             	sub    $0x30,%esp
    if (w < 0 || h < 0) return;
    4c8c:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
    4c90:	0f 88 8e 01 00 00    	js     4e24 <APDcCopy+0x19e>
    4c96:	83 7d 24 00          	cmpl   $0x0,0x24(%ebp)
    4c9a:	0f 88 84 01 00 00    	js     4e24 <APDcCopy+0x19e>
    int wx_r = wx + w, wy_r = wy + h;
    4ca0:	8b 55 0c             	mov    0xc(%ebp),%edx
    4ca3:	8b 45 20             	mov    0x20(%ebp),%eax
    4ca6:	01 d0                	add    %edx,%eax
    4ca8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4cab:	8b 55 10             	mov    0x10(%ebp),%edx
    4cae:	8b 45 24             	mov    0x24(%ebp),%eax
    4cb1:	01 d0                	add    %edx,%eax
    4cb3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    int x_r = x + w , y_r = y + h ;
    4cb6:	8b 55 18             	mov    0x18(%ebp),%edx
    4cb9:	8b 45 20             	mov    0x20(%ebp),%eax
    4cbc:	01 d0                	add    %edx,%eax
    4cbe:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4cc1:	8b 55 1c             	mov    0x1c(%ebp),%edx
    4cc4:	8b 45 24             	mov    0x24(%ebp),%eax
    4cc7:	01 d0                	add    %edx,%eax
    4cc9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
    4ccc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    4cd0:	0f 88 51 01 00 00    	js     4e27 <APDcCopy+0x1a1>
    4cd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    4cda:	0f 88 47 01 00 00    	js     4e27 <APDcCopy+0x1a1>
    4ce0:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    4ce4:	0f 88 3d 01 00 00    	js     4e27 <APDcCopy+0x1a1>
    4cea:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    4cee:	0f 88 33 01 00 00    	js     4e27 <APDcCopy+0x1a1>
    4cf4:	8b 45 14             	mov    0x14(%ebp),%eax
    4cf7:	8b 00                	mov    (%eax),%eax
    4cf9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4cfc:	0f 8c 25 01 00 00    	jl     4e27 <APDcCopy+0x1a1>
    4d02:	8b 45 14             	mov    0x14(%ebp),%eax
    4d05:	8b 40 04             	mov    0x4(%eax),%eax
    4d08:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    4d0b:	0f 8c 16 01 00 00    	jl     4e27 <APDcCopy+0x1a1>
        return;
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    4d11:	8b 45 08             	mov    0x8(%ebp),%eax
    4d14:	8b 00                	mov    (%eax),%eax
    4d16:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4d19:	7f 0b                	jg     4d26 <APDcCopy+0xa0>
    4d1b:	8b 45 08             	mov    0x8(%ebp),%eax
    4d1e:	8b 00                	mov    (%eax),%eax
    4d20:	83 e8 01             	sub    $0x1,%eax
    4d23:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    4d26:	8b 45 08             	mov    0x8(%ebp),%eax
    4d29:	8b 40 04             	mov    0x4(%eax),%eax
    4d2c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4d2f:	7f 0c                	jg     4d3d <APDcCopy+0xb7>
    4d31:	8b 45 08             	mov    0x8(%ebp),%eax
    4d34:	8b 40 04             	mov    0x4(%eax),%eax
    4d37:	83 e8 01             	sub    $0x1,%eax
    4d3a:	89 45 f8             	mov    %eax,-0x8(%ebp)
    
    int off1 = 0,off2 = 0;
    4d3d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    4d44:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    for (int j = 0; j <= wy_r - wy; j++)
    4d4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4d52:	e9 bc 00 00 00       	jmp    4e13 <APDcCopy+0x18d>
    {
        off1 = dst->size.cx * (j + wy) + wx;
    4d57:	8b 45 08             	mov    0x8(%ebp),%eax
    4d5a:	8b 00                	mov    (%eax),%eax
    4d5c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    4d5f:	8b 55 10             	mov    0x10(%ebp),%edx
    4d62:	01 ca                	add    %ecx,%edx
    4d64:	0f af d0             	imul   %eax,%edx
    4d67:	8b 45 0c             	mov    0xc(%ebp),%eax
    4d6a:	01 d0                	add    %edx,%eax
    4d6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        off2 = src->size.cx * (j + y) + x;
    4d6f:	8b 45 14             	mov    0x14(%ebp),%eax
    4d72:	8b 00                	mov    (%eax),%eax
    4d74:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    4d77:	8b 55 1c             	mov    0x1c(%ebp),%edx
    4d7a:	01 ca                	add    %ecx,%edx
    4d7c:	0f af d0             	imul   %eax,%edx
    4d7f:	8b 45 18             	mov    0x18(%ebp),%eax
    4d82:	01 d0                	add    %edx,%eax
    4d84:	89 45 e0             	mov    %eax,-0x20(%ebp)
        for (int i = 0; i <=  wx_r - wx; i++)
    4d87:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4d8e:	eb 74                	jmp    4e04 <APDcCopy+0x17e>
        {
            AColor c = src->content[off2 + i];
    4d90:	8b 45 14             	mov    0x14(%ebp),%eax
    4d93:	8b 50 18             	mov    0x18(%eax),%edx
    4d96:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    4d99:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4d9c:	01 c8                	add    %ecx,%eax
    4d9e:	89 c1                	mov    %eax,%ecx
    4da0:	89 c8                	mov    %ecx,%eax
    4da2:	01 c0                	add    %eax,%eax
    4da4:	01 c8                	add    %ecx,%eax
    4da6:	01 d0                	add    %edx,%eax
    4da8:	0f b7 10             	movzwl (%eax),%edx
    4dab:	66 89 55 dd          	mov    %dx,-0x23(%ebp)
    4daf:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    4db3:	88 45 df             	mov    %al,-0x21(%ebp)
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
    4db6:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    4dba:	0f b6 45 2a          	movzbl 0x2a(%ebp),%eax
    4dbe:	38 c2                	cmp    %al,%dl
    4dc0:	75 18                	jne    4dda <APDcCopy+0x154>
    4dc2:	0f b6 55 de          	movzbl -0x22(%ebp),%edx
    4dc6:	0f b6 45 29          	movzbl 0x29(%ebp),%eax
    4dca:	38 c2                	cmp    %al,%dl
    4dcc:	75 0c                	jne    4dda <APDcCopy+0x154>
    4dce:	0f b6 55 dd          	movzbl -0x23(%ebp),%edx
    4dd2:	0f b6 45 28          	movzbl 0x28(%ebp),%eax
    4dd6:	38 c2                	cmp    %al,%dl
    4dd8:	74 26                	je     4e00 <APDcCopy+0x17a>
                dst->content[off1 + i] = c;
    4dda:	8b 45 08             	mov    0x8(%ebp),%eax
    4ddd:	8b 50 18             	mov    0x18(%eax),%edx
    4de0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    4de3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4de6:	01 c8                	add    %ecx,%eax
    4de8:	89 c1                	mov    %eax,%ecx
    4dea:	89 c8                	mov    %ecx,%eax
    4dec:	01 c0                	add    %eax,%eax
    4dee:	01 c8                	add    %ecx,%eax
    4df0:	01 d0                	add    %edx,%eax
    4df2:	0f b7 55 dd          	movzwl -0x23(%ebp),%edx
    4df6:	66 89 10             	mov    %dx,(%eax)
    4df9:	0f b6 55 df          	movzbl -0x21(%ebp),%edx
    4dfd:	88 50 02             	mov    %dl,0x2(%eax)
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    {
        off1 = dst->size.cx * (j + wy) + wx;
        off2 = src->size.cx * (j + y) + x;
        for (int i = 0; i <=  wx_r - wx; i++)
    4e00:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    4e04:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e07:	2b 45 0c             	sub    0xc(%ebp),%eax
    4e0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    4e0d:	7d 81                	jge    4d90 <APDcCopy+0x10a>
    
    if (wx_r >= dst->size.cx) wx_r = dst->size.cx - 1;
    if (wy_r >= dst->size.cy) wy_r = dst->size.cy - 1;
    
    int off1 = 0,off2 = 0;
    for (int j = 0; j <= wy_r - wy; j++)
    4e0f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    4e13:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e16:	2b 45 10             	sub    0x10(%ebp),%eax
    4e19:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    4e1c:	0f 8d 35 ff ff ff    	jge    4d57 <APDcCopy+0xd1>
    4e22:	eb 04                	jmp    4e28 <APDcCopy+0x1a2>


//--------------------------Dc operation-----------------------------------
void APDcCopy(AHdc dst,int wx, int wy, AHdc src,int x,int y,int w,int h,AColor trans)
{
    if (w < 0 || h < 0) return;
    4e24:	90                   	nop
    4e25:	eb 01                	jmp    4e28 <APDcCopy+0x1a2>
    int wx_r = wx + w, wy_r = wy + h;
    int x_r = x + w , y_r = y + h ;
    if (wx < 0 || wy < 0 || x < 0 || y < 0 || x_r > src->size.cx || y_r > src->size.cy)
        return;
    4e27:	90                   	nop
            AColor c = src->content[off2 + i];
            if (c.r != trans.r || c.g != trans.g || c.b != trans.b)
                dst->content[off1 + i] = c;
        }
    }
}
    4e28:	c9                   	leave  
    4e29:	c3                   	ret    

00004e2a <RGB>:
    uchar g;
    uchar r;
}AColor;

static inline AColor RGB(uchar r, uchar g, uchar b)
{
    4e2a:	55                   	push   %ebp
    4e2b:	89 e5                	mov    %esp,%ebp
    4e2d:	83 ec 1c             	sub    $0x1c,%esp
    4e30:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    4e33:	8b 55 10             	mov    0x10(%ebp),%edx
    4e36:	8b 45 14             	mov    0x14(%ebp),%eax
    4e39:	88 4d ec             	mov    %cl,-0x14(%ebp)
    4e3c:	88 55 e8             	mov    %dl,-0x18(%ebp)
    4e3f:	88 45 e4             	mov    %al,-0x1c(%ebp)
    AColor rgb;
    rgb.r = r;
    4e42:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
    4e46:	88 45 ff             	mov    %al,-0x1(%ebp)
    rgb.g = g;
    4e49:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
    4e4d:	88 45 fe             	mov    %al,-0x2(%ebp)
    rgb.b = b;
    4e50:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
    4e54:	88 45 fd             	mov    %al,-0x3(%ebp)
    return rgb;
    4e57:	8b 45 08             	mov    0x8(%ebp),%eax
    4e5a:	0f b7 55 fd          	movzwl -0x3(%ebp),%edx
    4e5e:	66 89 10             	mov    %dx,(%eax)
    4e61:	0f b6 55 ff          	movzbl -0x1(%ebp),%edx
    4e65:	88 50 02             	mov    %dl,0x2(%eax)
}
    4e68:	8b 45 08             	mov    0x8(%ebp),%eax
    4e6b:	c9                   	leave  
    4e6c:	c2 04 00             	ret    $0x4

00004e6f <APSendMessage>:
#include "APWindow.h"

int iconReady = 0;

void APSendMessage(AHwnd hwnd, AMessage msg)
{
    4e6f:	55                   	push   %ebp
    4e70:	89 e5                	mov    %esp,%ebp
    4e72:	83 ec 08             	sub    $0x8,%esp
      sendMessage(hwnd->id, &msg);
    4e75:	8b 45 08             	mov    0x8(%ebp),%eax
    4e78:	8b 00                	mov    (%eax),%eax
    4e7a:	83 ec 08             	sub    $0x8,%esp
    4e7d:	8d 55 0c             	lea    0xc(%ebp),%edx
    4e80:	52                   	push   %edx
    4e81:	50                   	push   %eax
    4e82:	e8 24 ee ff ff       	call   3cab <sendMessage>
    4e87:	83 c4 10             	add    $0x10,%esp
}
    4e8a:	90                   	nop
    4e8b:	c9                   	leave  
    4e8c:	c3                   	ret    

00004e8d <APCreateWindow>:


AHwnd APCreateWindow(char * title,int is_map,int page)
{
    4e8d:	55                   	push   %ebp
    4e8e:	89 e5                	mov    %esp,%ebp
    4e90:	83 ec 18             	sub    $0x18,%esp
    AHwnd r = (AHwnd)malloc(sizeof(AWindow));
    4e93:	83 ec 0c             	sub    $0xc,%esp
    4e96:	68 98 00 00 00       	push   $0x98
    4e9b:	e8 f5 f1 ff ff       	call   4095 <malloc>
    4ea0:	83 c4 10             	add    $0x10,%esp
    4ea3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (r == 0)
    4ea6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4eaa:	75 15                	jne    4ec1 <APCreateWindow+0x34>
        printf(1,"%s - window creation failed!\n",title);
    4eac:	83 ec 04             	sub    $0x4,%esp
    4eaf:	ff 75 08             	pushl  0x8(%ebp)
    4eb2:	68 b8 74 00 00       	push   $0x74b8
    4eb7:	6a 01                	push   $0x1
    4eb9:	e8 04 ef ff ff       	call   3dc2 <printf>
    4ebe:	83 c4 10             	add    $0x10,%esp
    
    //title init
    strcpy(r->title, title);
    4ec1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4ec4:	05 84 00 00 00       	add    $0x84,%eax
    4ec9:	83 ec 08             	sub    $0x8,%esp
    4ecc:	ff 75 08             	pushl  0x8(%ebp)
    4ecf:	50                   	push   %eax
    4ed0:	e8 fd ea ff ff       	call   39d2 <strcpy>
    4ed5:	83 c4 10             	add    $0x10,%esp
    
    //DC innit
    r->Dc.size.cx = SCREEN_WIDTH;
    4ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4edb:	c7 40 3c 20 03 00 00 	movl   $0x320,0x3c(%eax)
    r->Dc.size.cy = SCREEN_HEIGHT - WND_TITLE_HEIGHT;
    4ee2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4ee5:	c7 40 40 26 02 00 00 	movl   $0x226,0x40(%eax)
    r->Dc.content = (AColor *)malloc(sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    4eec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4eef:	8b 40 3c             	mov    0x3c(%eax),%eax
    4ef2:	89 c2                	mov    %eax,%edx
    4ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4ef7:	8b 40 40             	mov    0x40(%eax),%eax
    4efa:	0f af d0             	imul   %eax,%edx
    4efd:	89 d0                	mov    %edx,%eax
    4eff:	01 c0                	add    %eax,%eax
    4f01:	01 d0                	add    %edx,%eax
    4f03:	83 ec 0c             	sub    $0xc,%esp
    4f06:	50                   	push   %eax
    4f07:	e8 89 f1 ff ff       	call   4095 <malloc>
    4f0c:	83 c4 10             	add    $0x10,%esp
    4f0f:	89 c2                	mov    %eax,%edx
    4f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f14:	89 50 54             	mov    %edx,0x54(%eax)
    if (r->Dc.content == 0)
    4f17:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f1a:	8b 40 54             	mov    0x54(%eax),%eax
    4f1d:	85 c0                	test   %eax,%eax
    4f1f:	75 15                	jne    4f36 <APCreateWindow+0xa9>
        printf(1,"$s window - Dc creation failed!\n",title);
    4f21:	83 ec 04             	sub    $0x4,%esp
    4f24:	ff 75 08             	pushl  0x8(%ebp)
    4f27:	68 d8 74 00 00       	push   $0x74d8
    4f2c:	6a 01                	push   $0x1
    4f2e:	e8 8f ee ff ff       	call   3dc2 <printf>
    4f33:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    4f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f39:	8b 40 3c             	mov    0x3c(%eax),%eax
    4f3c:	89 c2                	mov    %eax,%edx
    4f3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f41:	8b 40 40             	mov    0x40(%eax),%eax
    4f44:	0f af d0             	imul   %eax,%edx
    4f47:	89 d0                	mov    %edx,%eax
    4f49:	01 c0                	add    %eax,%eax
    4f4b:	01 c2                	add    %eax,%edx
    4f4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f50:	8b 40 54             	mov    0x54(%eax),%eax
    4f53:	83 ec 04             	sub    $0x4,%esp
    4f56:	52                   	push   %edx
    4f57:	68 ff ff ff 00       	push   $0xffffff
    4f5c:	50                   	push   %eax
    4f5d:	e8 06 eb ff ff       	call   3a68 <memset>
    4f62:	83 c4 10             	add    $0x10,%esp
    
    r->msg.type = MSG_NULL;
    4f65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f68:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    r->pid = getpid();
    4f6f:	e8 0f ed ff ff       	call   3c83 <getpid>
    4f74:	89 c2                	mov    %eax,%edx
    4f76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f79:	89 50 04             	mov    %edx,0x4(%eax)
    
    //Window Title init
    r->TitleDc.size.cx = SCREEN_WIDTH;
    4f7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f7f:	c7 40 58 20 03 00 00 	movl   $0x320,0x58(%eax)
    r->TitleDc.size.cy = WND_TITLE_HEIGHT;
    4f86:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f89:	c7 40 5c 32 00 00 00 	movl   $0x32,0x5c(%eax)
    r->TitleDc.content = (AColor *)malloc(sizeof(AColor) * r->TitleDc.size.cx * r->TitleDc.size.cy);
    4f90:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f93:	8b 40 58             	mov    0x58(%eax),%eax
    4f96:	89 c2                	mov    %eax,%edx
    4f98:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f9b:	8b 40 5c             	mov    0x5c(%eax),%eax
    4f9e:	0f af d0             	imul   %eax,%edx
    4fa1:	89 d0                	mov    %edx,%eax
    4fa3:	01 c0                	add    %eax,%eax
    4fa5:	01 d0                	add    %edx,%eax
    4fa7:	83 ec 0c             	sub    $0xc,%esp
    4faa:	50                   	push   %eax
    4fab:	e8 e5 f0 ff ff       	call   4095 <malloc>
    4fb0:	83 c4 10             	add    $0x10,%esp
    4fb3:	89 c2                	mov    %eax,%edx
    4fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fb8:	89 50 70             	mov    %edx,0x70(%eax)
    if (r->TitleDc.content == 0)
    4fbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fbe:	8b 40 70             	mov    0x70(%eax),%eax
    4fc1:	85 c0                	test   %eax,%eax
    4fc3:	75 15                	jne    4fda <APCreateWindow+0x14d>
        printf(1,"%s window - Title DC creation failed!\n",title);
    4fc5:	83 ec 04             	sub    $0x4,%esp
    4fc8:	ff 75 08             	pushl  0x8(%ebp)
    4fcb:	68 fc 74 00 00       	push   $0x74fc
    4fd0:	6a 01                	push   $0x1
    4fd2:	e8 eb ed ff ff       	call   3dc2 <printf>
    4fd7:	83 c4 10             	add    $0x10,%esp
    memset(r->Dc.content, DEFAULT_TITLE_COLOR, sizeof(AColor) * r->Dc.size.cx * r->Dc.size.cy);
    4fda:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fdd:	8b 40 3c             	mov    0x3c(%eax),%eax
    4fe0:	89 c2                	mov    %eax,%edx
    4fe2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fe5:	8b 40 40             	mov    0x40(%eax),%eax
    4fe8:	0f af d0             	imul   %eax,%edx
    4feb:	89 d0                	mov    %edx,%eax
    4fed:	01 c0                	add    %eax,%eax
    4fef:	01 c2                	add    %eax,%edx
    4ff1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4ff4:	8b 40 54             	mov    0x54(%eax),%eax
    4ff7:	83 ec 04             	sub    $0x4,%esp
    4ffa:	52                   	push   %edx
    4ffb:	68 ff 00 00 00       	push   $0xff
    5000:	50                   	push   %eax
    5001:	e8 62 ea ff ff       	call   3a68 <memset>
    5006:	83 c4 10             	add    $0x10,%esp
    
    r->is_grid = is_map;
    5009:	8b 45 f4             	mov    -0xc(%ebp),%eax
    500c:	8b 55 0c             	mov    0xc(%ebp),%edx
    500f:	89 50 08             	mov    %edx,0x8(%eax)
    //if is Grid Mode
    if (is_map)
    5012:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    5016:	74 49                	je     5061 <APCreateWindow+0x1d4>
    {
        //Grid_Mode activate
        r->Grid = (int*)malloc(sizeof(int) * GRID_W_NUMBER * GRID_H_NUMBER * page);
    5018:	8b 45 10             	mov    0x10(%ebp),%eax
    501b:	69 c0 c0 02 00 00    	imul   $0x2c0,%eax,%eax
    5021:	83 ec 0c             	sub    $0xc,%esp
    5024:	50                   	push   %eax
    5025:	e8 6b f0 ff ff       	call   4095 <malloc>
    502a:	83 c4 10             	add    $0x10,%esp
    502d:	89 c2                	mov    %eax,%edx
    502f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5032:	89 50 0c             	mov    %edx,0xc(%eax)
        r->total_page = page;
    5035:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5038:	8b 55 10             	mov    0x10(%ebp),%edx
    503b:	89 50 10             	mov    %edx,0x10(%eax)
        r->cur_page = 0;
    503e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5041:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        r->pos_x = 0;
    5048:	8b 45 f4             	mov    -0xc(%ebp),%eax
    504b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        r->pos_y = 0;
    5052:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5055:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    505c:	e9 8d 00 00 00       	jmp    50ee <APCreateWindow+0x261>
    }
    else
    {
        //non Grid_Mode activate
        r->wholeDc.size.cx = SCREEN_WIDTH;
    5061:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5064:	c7 40 20 20 03 00 00 	movl   $0x320,0x20(%eax)
        r->wholeDc.size.cy = MAX_DC_HEIGHT;
    506b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    506e:	c7 40 24 40 06 00 00 	movl   $0x640,0x24(%eax)
        r->wholeDc.content = (AColor *)malloc(sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    5075:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5078:	8b 40 20             	mov    0x20(%eax),%eax
    507b:	89 c2                	mov    %eax,%edx
    507d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5080:	8b 40 24             	mov    0x24(%eax),%eax
    5083:	0f af d0             	imul   %eax,%edx
    5086:	89 d0                	mov    %edx,%eax
    5088:	01 c0                	add    %eax,%eax
    508a:	01 d0                	add    %edx,%eax
    508c:	83 ec 0c             	sub    $0xc,%esp
    508f:	50                   	push   %eax
    5090:	e8 00 f0 ff ff       	call   4095 <malloc>
    5095:	83 c4 10             	add    $0x10,%esp
    5098:	89 c2                	mov    %eax,%edx
    509a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    509d:	89 50 38             	mov    %edx,0x38(%eax)
        if (r->wholeDc.content == 0)
    50a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    50a3:	8b 40 38             	mov    0x38(%eax),%eax
    50a6:	85 c0                	test   %eax,%eax
    50a8:	75 15                	jne    50bf <APCreateWindow+0x232>
            printf(1,"%s window - whole DC creation failed!\n",title);
    50aa:	83 ec 04             	sub    $0x4,%esp
    50ad:	ff 75 08             	pushl  0x8(%ebp)
    50b0:	68 24 75 00 00       	push   $0x7524
    50b5:	6a 01                	push   $0x1
    50b7:	e8 06 ed ff ff       	call   3dc2 <printf>
    50bc:	83 c4 10             	add    $0x10,%esp
        memset(r->wholeDc.content, DEFAULT_WINDOW_COLOR, sizeof(AColor) * r->wholeDc.size.cx * r->wholeDc.size.cy);
    50bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    50c2:	8b 40 20             	mov    0x20(%eax),%eax
    50c5:	89 c2                	mov    %eax,%edx
    50c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    50ca:	8b 40 24             	mov    0x24(%eax),%eax
    50cd:	0f af d0             	imul   %eax,%edx
    50d0:	89 d0                	mov    %edx,%eax
    50d2:	01 c0                	add    %eax,%eax
    50d4:	01 c2                	add    %eax,%edx
    50d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    50d9:	8b 40 38             	mov    0x38(%eax),%eax
    50dc:	83 ec 04             	sub    $0x4,%esp
    50df:	52                   	push   %edx
    50e0:	68 ff ff ff 00       	push   $0xffffff
    50e5:	50                   	push   %eax
    50e6:	e8 7d e9 ff ff       	call   3a68 <memset>
    50eb:	83 c4 10             	add    $0x10,%esp
    }
    return r;
    50ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    50f1:	c9                   	leave  
    50f2:	c3                   	ret    

000050f3 <APWndProc>:

bool APWndProc(AHwnd hwnd, AMessage msg)
{
    50f3:	55                   	push   %ebp
    50f4:	89 e5                	mov    %esp,%ebp
    50f6:	57                   	push   %edi
    50f7:	56                   	push   %esi
    50f8:	53                   	push   %ebx
    50f9:	83 ec 0c             	sub    $0xc,%esp
    //printf(1,"start window processing!\n");
    switch (msg.type)
    50fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    50ff:	83 f8 03             	cmp    $0x3,%eax
    5102:	74 02                	je     5106 <APWndProc+0x13>
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
            //printf(1,"paint finished!\n");
            break;
        default: break;
    5104:	eb 7c                	jmp    5182 <APWndProc+0x8f>
    //printf(1,"start window processing!\n");
    switch (msg.type)
    {
        case MSG_PAINT:
            //printf(1,"paint!\n");
            paintWindow(hwnd, 0, 0, &hwnd->TitleDc, 0, 0, hwnd->TitleDc.size.cx, hwnd->TitleDc.size.cy,False,hwnd->pos_x,hwnd->pos_y);
    5106:	8b 45 08             	mov    0x8(%ebp),%eax
    5109:	8b 58 1c             	mov    0x1c(%eax),%ebx
    510c:	8b 45 08             	mov    0x8(%ebp),%eax
    510f:	8b 48 18             	mov    0x18(%eax),%ecx
    5112:	8b 45 08             	mov    0x8(%ebp),%eax
    5115:	8b 50 5c             	mov    0x5c(%eax),%edx
    5118:	8b 45 08             	mov    0x8(%ebp),%eax
    511b:	8b 40 58             	mov    0x58(%eax),%eax
    511e:	8b 75 08             	mov    0x8(%ebp),%esi
    5121:	83 c6 58             	add    $0x58,%esi
    5124:	83 ec 04             	sub    $0x4,%esp
    5127:	53                   	push   %ebx
    5128:	51                   	push   %ecx
    5129:	6a 00                	push   $0x0
    512b:	52                   	push   %edx
    512c:	50                   	push   %eax
    512d:	6a 00                	push   $0x0
    512f:	6a 00                	push   $0x0
    5131:	56                   	push   %esi
    5132:	6a 00                	push   $0x0
    5134:	6a 00                	push   $0x0
    5136:	ff 75 08             	pushl  0x8(%ebp)
    5139:	e8 65 eb ff ff       	call   3ca3 <paintWindow>
    513e:	83 c4 30             	add    $0x30,%esp
            paintWindow(hwnd, 0, WND_TITLE_HEIGHT, &hwnd->Dc, 0, 0, hwnd->Dc.size.cx, hwnd->Dc.size.cy,hwnd->is_grid,hwnd->pos_x,hwnd->pos_y);
    5141:	8b 45 08             	mov    0x8(%ebp),%eax
    5144:	8b 70 1c             	mov    0x1c(%eax),%esi
    5147:	8b 45 08             	mov    0x8(%ebp),%eax
    514a:	8b 58 18             	mov    0x18(%eax),%ebx
    514d:	8b 45 08             	mov    0x8(%ebp),%eax
    5150:	8b 48 08             	mov    0x8(%eax),%ecx
    5153:	8b 45 08             	mov    0x8(%ebp),%eax
    5156:	8b 50 40             	mov    0x40(%eax),%edx
    5159:	8b 45 08             	mov    0x8(%ebp),%eax
    515c:	8b 40 3c             	mov    0x3c(%eax),%eax
    515f:	8b 7d 08             	mov    0x8(%ebp),%edi
    5162:	83 c7 3c             	add    $0x3c,%edi
    5165:	83 ec 04             	sub    $0x4,%esp
    5168:	56                   	push   %esi
    5169:	53                   	push   %ebx
    516a:	51                   	push   %ecx
    516b:	52                   	push   %edx
    516c:	50                   	push   %eax
    516d:	6a 00                	push   $0x0
    516f:	6a 00                	push   $0x0
    5171:	57                   	push   %edi
    5172:	6a 32                	push   $0x32
    5174:	6a 00                	push   $0x0
    5176:	ff 75 08             	pushl  0x8(%ebp)
    5179:	e8 25 eb ff ff       	call   3ca3 <paintWindow>
    517e:	83 c4 30             	add    $0x30,%esp
            //printf(1,"paint finished!\n");
            break;
    5181:	90                   	nop
        default: break;
            
            
    }
    return False;
    5182:	b8 00 00 00 00       	mov    $0x0,%eax
}
    5187:	8d 65 f4             	lea    -0xc(%ebp),%esp
    518a:	5b                   	pop    %ebx
    518b:	5e                   	pop    %esi
    518c:	5f                   	pop    %edi
    518d:	5d                   	pop    %ebp
    518e:	c3                   	ret    

0000518f <APPreJudge>:

bool APPreJudge(AHwnd hwnd, AMessage * msg)
{
    518f:	55                   	push   %ebp
    5190:	89 e5                	mov    %esp,%ebp
    if (msg->wndID != hwnd->id)
    5192:	8b 45 0c             	mov    0xc(%ebp),%eax
    5195:	8b 50 08             	mov    0x8(%eax),%edx
    5198:	8b 45 08             	mov    0x8(%ebp),%eax
    519b:	8b 00                	mov    (%eax),%eax
    519d:	39 c2                	cmp    %eax,%edx
    519f:	74 07                	je     51a8 <APPreJudge+0x19>
        return False;
    51a1:	b8 00 00 00 00       	mov    $0x0,%eax
    51a6:	eb 05                	jmp    51ad <APPreJudge+0x1e>
    return True;
    51a8:	b8 01 00 00 00       	mov    $0x1,%eax
}
    51ad:	5d                   	pop    %ebp
    51ae:	c3                   	ret    

000051af <APWndExec>:

void APWndExec(AHwnd hwnd, bool (*wndProc)(AHwnd, AMessage))
{
    51af:	55                   	push   %ebp
    51b0:	89 e5                	mov    %esp,%ebp
    51b2:	83 ec 18             	sub    $0x18,%esp
    hwnd->wndProc = wndProc;
    51b5:	8b 45 08             	mov    0x8(%ebp),%eax
    51b8:	8b 55 0c             	mov    0xc(%ebp),%edx
    51bb:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    //--------add window to list
    registWindow(hwnd);
    51c1:	83 ec 0c             	sub    $0xc,%esp
    51c4:	ff 75 08             	pushl  0x8(%ebp)
    51c7:	e8 ef ea ff ff       	call   3cbb <registWindow>
    51cc:	83 c4 10             	add    $0x10,%esp
    //--------draw window
    AMessage msg;
    msg.type = MSG_INIT;
    51cf:	c7 45 ec 02 00 00 00 	movl   $0x2,-0x14(%ebp)
    msg.wndID = hwnd->id;
    51d6:	8b 45 08             	mov    0x8(%ebp),%eax
    51d9:	8b 00                	mov    (%eax),%eax
    51db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    APSendMessage(hwnd,msg);
    51de:	ff 75 f4             	pushl  -0xc(%ebp)
    51e1:	ff 75 f0             	pushl  -0x10(%ebp)
    51e4:	ff 75 ec             	pushl  -0x14(%ebp)
    51e7:	ff 75 08             	pushl  0x8(%ebp)
    51ea:	e8 80 fc ff ff       	call   4e6f <APSendMessage>
    51ef:	83 c4 10             	add    $0x10,%esp
    //--------process window
    //printf(1,"start getting message!\n");
    while (1)
    {
        getMessage(hwnd);
    51f2:	83 ec 0c             	sub    $0xc,%esp
    51f5:	ff 75 08             	pushl  0x8(%ebp)
    51f8:	e8 b6 ea ff ff       	call   3cb3 <getMessage>
    51fd:	83 c4 10             	add    $0x10,%esp
        if (APPreJudge(hwnd,&hwnd->msg))
    5200:	8b 45 08             	mov    0x8(%ebp),%eax
    5203:	83 c0 74             	add    $0x74,%eax
    5206:	83 ec 08             	sub    $0x8,%esp
    5209:	50                   	push   %eax
    520a:	ff 75 08             	pushl  0x8(%ebp)
    520d:	e8 7d ff ff ff       	call   518f <APPreJudge>
    5212:	83 c4 10             	add    $0x10,%esp
    5215:	84 c0                	test   %al,%al
    5217:	74 1b                	je     5234 <APWndExec+0x85>
            if (wndProc(hwnd, hwnd->msg))
    5219:	8b 45 08             	mov    0x8(%ebp),%eax
    521c:	ff 70 7c             	pushl  0x7c(%eax)
    521f:	ff 70 78             	pushl  0x78(%eax)
    5222:	ff 70 74             	pushl  0x74(%eax)
    5225:	ff 75 08             	pushl  0x8(%ebp)
    5228:	8b 45 0c             	mov    0xc(%ebp),%eax
    522b:	ff d0                	call   *%eax
    522d:	83 c4 10             	add    $0x10,%esp
    5230:	84 c0                	test   %al,%al
    5232:	75 0c                	jne    5240 <APWndExec+0x91>
                break;
        hwnd->msg.type = MSG_NULL;
    5234:	8b 45 08             	mov    0x8(%ebp),%eax
    5237:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%eax)
    }
    523e:	eb b2                	jmp    51f2 <APWndExec+0x43>
    while (1)
    {
        getMessage(hwnd);
        if (APPreJudge(hwnd,&hwnd->msg))
            if (wndProc(hwnd, hwnd->msg))
                break;
    5240:	90                   	nop
        hwnd->msg.type = MSG_NULL;
    }
}
    5241:	90                   	nop
    5242:	c9                   	leave  
    5243:	c3                   	ret    

00005244 <APGridPaint>:

//---------------------------------------------------
//Grid_mode paint
void APGridPaint(AHwnd wnd)
{
    5244:	55                   	push   %ebp
    5245:	89 e5                	mov    %esp,%ebp
    5247:	57                   	push   %edi
    5248:	56                   	push   %esi
    5249:	53                   	push   %ebx
    524a:	83 ec 7c             	sub    $0x7c,%esp
    if (!iconReady)
    524d:	a1 ec bc 00 00       	mov    0xbcec,%eax
    5252:	85 c0                	test   %eax,%eax
    5254:	0f 85 7a 02 00 00    	jne    54d4 <APGridPaint+0x290>
    {
        iconReady = 1;
    525a:	c7 05 ec bc 00 00 01 	movl   $0x1,0xbcec
    5261:	00 00 00 
        //load icon bitmap
        grid_wall = APLoadBitmap ("grid_wall.bmp");
    5264:	8d 45 88             	lea    -0x78(%ebp),%eax
    5267:	83 ec 08             	sub    $0x8,%esp
    526a:	68 4b 75 00 00       	push   $0x754b
    526f:	50                   	push   %eax
    5270:	e8 d3 ef ff ff       	call   4248 <APLoadBitmap>
    5275:	83 c4 0c             	add    $0xc,%esp
    5278:	8b 45 88             	mov    -0x78(%ebp),%eax
    527b:	a3 44 04 01 00       	mov    %eax,0x10444
    5280:	8b 45 8c             	mov    -0x74(%ebp),%eax
    5283:	a3 48 04 01 00       	mov    %eax,0x10448
    5288:	8b 45 90             	mov    -0x70(%ebp),%eax
    528b:	a3 4c 04 01 00       	mov    %eax,0x1044c
        g_wall = APCreateCompatibleDCFromBitmap(grid_wall);
    5290:	83 ec 04             	sub    $0x4,%esp
    5293:	ff 35 4c 04 01 00    	pushl  0x1044c
    5299:	ff 35 48 04 01 00    	pushl  0x10448
    529f:	ff 35 44 04 01 00    	pushl  0x10444
    52a5:	e8 d8 f1 ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    52aa:	83 c4 10             	add    $0x10,%esp
    52ad:	a3 50 04 01 00       	mov    %eax,0x10450
        grid_river = APLoadBitmap ("grid_river.bmp");
    52b2:	8d 45 88             	lea    -0x78(%ebp),%eax
    52b5:	83 ec 08             	sub    $0x8,%esp
    52b8:	68 59 75 00 00       	push   $0x7559
    52bd:	50                   	push   %eax
    52be:	e8 85 ef ff ff       	call   4248 <APLoadBitmap>
    52c3:	83 c4 0c             	add    $0xc,%esp
    52c6:	8b 45 88             	mov    -0x78(%ebp),%eax
    52c9:	a3 8c 04 01 00       	mov    %eax,0x1048c
    52ce:	8b 45 8c             	mov    -0x74(%ebp),%eax
    52d1:	a3 90 04 01 00       	mov    %eax,0x10490
    52d6:	8b 45 90             	mov    -0x70(%ebp),%eax
    52d9:	a3 94 04 01 00       	mov    %eax,0x10494
        g_river = APCreateCompatibleDCFromBitmap(grid_river);
    52de:	83 ec 04             	sub    $0x4,%esp
    52e1:	ff 35 94 04 01 00    	pushl  0x10494
    52e7:	ff 35 90 04 01 00    	pushl  0x10490
    52ed:	ff 35 8c 04 01 00    	pushl  0x1048c
    52f3:	e8 8a f1 ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    52f8:	83 c4 10             	add    $0x10,%esp
    52fb:	a3 7c 04 01 00       	mov    %eax,0x1047c
        grid_stone = APLoadBitmap ("grid_stone.bmp");
    5300:	8d 45 88             	lea    -0x78(%ebp),%eax
    5303:	83 ec 08             	sub    $0x8,%esp
    5306:	68 68 75 00 00       	push   $0x7568
    530b:	50                   	push   %eax
    530c:	e8 37 ef ff ff       	call   4248 <APLoadBitmap>
    5311:	83 c4 0c             	add    $0xc,%esp
    5314:	8b 45 88             	mov    -0x78(%ebp),%eax
    5317:	a3 80 04 01 00       	mov    %eax,0x10480
    531c:	8b 45 8c             	mov    -0x74(%ebp),%eax
    531f:	a3 84 04 01 00       	mov    %eax,0x10484
    5324:	8b 45 90             	mov    -0x70(%ebp),%eax
    5327:	a3 88 04 01 00       	mov    %eax,0x10488
        g_stone = APCreateCompatibleDCFromBitmap(grid_stone);
    532c:	83 ec 04             	sub    $0x4,%esp
    532f:	ff 35 88 04 01 00    	pushl  0x10488
    5335:	ff 35 84 04 01 00    	pushl  0x10484
    533b:	ff 35 80 04 01 00    	pushl  0x10480
    5341:	e8 3c f1 ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    5346:	83 c4 10             	add    $0x10,%esp
    5349:	a3 24 04 01 00       	mov    %eax,0x10424
        grid_lake = APLoadBitmap ("grid_lake.bmp");
    534e:	8d 45 88             	lea    -0x78(%ebp),%eax
    5351:	83 ec 08             	sub    $0x8,%esp
    5354:	68 77 75 00 00       	push   $0x7577
    5359:	50                   	push   %eax
    535a:	e8 e9 ee ff ff       	call   4248 <APLoadBitmap>
    535f:	83 c4 0c             	add    $0xc,%esp
    5362:	8b 45 88             	mov    -0x78(%ebp),%eax
    5365:	a3 58 04 01 00       	mov    %eax,0x10458
    536a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    536d:	a3 5c 04 01 00       	mov    %eax,0x1045c
    5372:	8b 45 90             	mov    -0x70(%ebp),%eax
    5375:	a3 60 04 01 00       	mov    %eax,0x10460
        g_lake = APCreateCompatibleDCFromBitmap(grid_lake);
    537a:	83 ec 04             	sub    $0x4,%esp
    537d:	ff 35 60 04 01 00    	pushl  0x10460
    5383:	ff 35 5c 04 01 00    	pushl  0x1045c
    5389:	ff 35 58 04 01 00    	pushl  0x10458
    538f:	e8 ee f0 ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    5394:	83 c4 10             	add    $0x10,%esp
    5397:	a3 9c 04 01 00       	mov    %eax,0x1049c
        grid_forest = APLoadBitmap ("grid_forest.bmp");
    539c:	8d 45 88             	lea    -0x78(%ebp),%eax
    539f:	83 ec 08             	sub    $0x8,%esp
    53a2:	68 85 75 00 00       	push   $0x7585
    53a7:	50                   	push   %eax
    53a8:	e8 9b ee ff ff       	call   4248 <APLoadBitmap>
    53ad:	83 c4 0c             	add    $0xc,%esp
    53b0:	8b 45 88             	mov    -0x78(%ebp),%eax
    53b3:	a3 34 04 01 00       	mov    %eax,0x10434
    53b8:	8b 45 8c             	mov    -0x74(%ebp),%eax
    53bb:	a3 38 04 01 00       	mov    %eax,0x10438
    53c0:	8b 45 90             	mov    -0x70(%ebp),%eax
    53c3:	a3 3c 04 01 00       	mov    %eax,0x1043c
        g_forest = APCreateCompatibleDCFromBitmap(grid_forest);
    53c8:	83 ec 04             	sub    $0x4,%esp
    53cb:	ff 35 3c 04 01 00    	pushl  0x1043c
    53d1:	ff 35 38 04 01 00    	pushl  0x10438
    53d7:	ff 35 34 04 01 00    	pushl  0x10434
    53dd:	e8 a0 f0 ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    53e2:	83 c4 10             	add    $0x10,%esp
    53e5:	a3 54 04 01 00       	mov    %eax,0x10454
        grid_mountain = APLoadBitmap ("grid_mountain.bmp");
    53ea:	8d 45 88             	lea    -0x78(%ebp),%eax
    53ed:	83 ec 08             	sub    $0x8,%esp
    53f0:	68 95 75 00 00       	push   $0x7595
    53f5:	50                   	push   %eax
    53f6:	e8 4d ee ff ff       	call   4248 <APLoadBitmap>
    53fb:	83 c4 0c             	add    $0xc,%esp
    53fe:	8b 45 88             	mov    -0x78(%ebp),%eax
    5401:	a3 28 04 01 00       	mov    %eax,0x10428
    5406:	8b 45 8c             	mov    -0x74(%ebp),%eax
    5409:	a3 2c 04 01 00       	mov    %eax,0x1042c
    540e:	8b 45 90             	mov    -0x70(%ebp),%eax
    5411:	a3 30 04 01 00       	mov    %eax,0x10430
        g_mountain = APCreateCompatibleDCFromBitmap(grid_mountain);
    5416:	83 ec 04             	sub    $0x4,%esp
    5419:	ff 35 30 04 01 00    	pushl  0x10430
    541f:	ff 35 2c 04 01 00    	pushl  0x1042c
    5425:	ff 35 28 04 01 00    	pushl  0x10428
    542b:	e8 52 f0 ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    5430:	83 c4 10             	add    $0x10,%esp
    5433:	a3 40 04 01 00       	mov    %eax,0x10440
        grid_grass = APLoadBitmap ("grid_grass.bmp");
    5438:	8d 45 88             	lea    -0x78(%ebp),%eax
    543b:	83 ec 08             	sub    $0x8,%esp
    543e:	68 a7 75 00 00       	push   $0x75a7
    5443:	50                   	push   %eax
    5444:	e8 ff ed ff ff       	call   4248 <APLoadBitmap>
    5449:	83 c4 0c             	add    $0xc,%esp
    544c:	8b 45 88             	mov    -0x78(%ebp),%eax
    544f:	a3 70 04 01 00       	mov    %eax,0x10470
    5454:	8b 45 8c             	mov    -0x74(%ebp),%eax
    5457:	a3 74 04 01 00       	mov    %eax,0x10474
    545c:	8b 45 90             	mov    -0x70(%ebp),%eax
    545f:	a3 78 04 01 00       	mov    %eax,0x10478
        g_grass = APCreateCompatibleDCFromBitmap(grid_grass);
    5464:	83 ec 04             	sub    $0x4,%esp
    5467:	ff 35 78 04 01 00    	pushl  0x10478
    546d:	ff 35 74 04 01 00    	pushl  0x10474
    5473:	ff 35 70 04 01 00    	pushl  0x10470
    5479:	e8 04 f0 ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    547e:	83 c4 10             	add    $0x10,%esp
    5481:	a3 a0 04 01 00       	mov    %eax,0x104a0
        grid_snake = APLoadBitmap ("grid_snake.bmp");
    5486:	8d 45 88             	lea    -0x78(%ebp),%eax
    5489:	83 ec 08             	sub    $0x8,%esp
    548c:	68 b6 75 00 00       	push   $0x75b6
    5491:	50                   	push   %eax
    5492:	e8 b1 ed ff ff       	call   4248 <APLoadBitmap>
    5497:	83 c4 0c             	add    $0xc,%esp
    549a:	8b 45 88             	mov    -0x78(%ebp),%eax
    549d:	a3 64 04 01 00       	mov    %eax,0x10464
    54a2:	8b 45 8c             	mov    -0x74(%ebp),%eax
    54a5:	a3 68 04 01 00       	mov    %eax,0x10468
    54aa:	8b 45 90             	mov    -0x70(%ebp),%eax
    54ad:	a3 6c 04 01 00       	mov    %eax,0x1046c
        g_snake = APCreateCompatibleDCFromBitmap(grid_snake);
    54b2:	83 ec 04             	sub    $0x4,%esp
    54b5:	ff 35 6c 04 01 00    	pushl  0x1046c
    54bb:	ff 35 68 04 01 00    	pushl  0x10468
    54c1:	ff 35 64 04 01 00    	pushl  0x10464
    54c7:	e8 b6 ef ff ff       	call   4482 <APCreateCompatibleDCFromBitmap>
    54cc:	83 c4 10             	add    $0x10,%esp
    54cf:	a3 98 04 01 00       	mov    %eax,0x10498
        //printf(1,"bitmap DC created!\n");
    }
    
    if (!wnd->is_grid)
    54d4:	8b 45 08             	mov    0x8(%ebp),%eax
    54d7:	8b 40 08             	mov    0x8(%eax),%eax
    54da:	85 c0                	test   %eax,%eax
    54dc:	75 17                	jne    54f5 <APGridPaint+0x2b1>
    {
        printf(1,"error! paint non-Grid Mode program! \n");
    54de:	83 ec 08             	sub    $0x8,%esp
    54e1:	68 c8 75 00 00       	push   $0x75c8
    54e6:	6a 01                	push   $0x1
    54e8:	e8 d5 e8 ff ff       	call   3dc2 <printf>
    54ed:	83 c4 10             	add    $0x10,%esp
        return;
    54f0:	e9 65 05 00 00       	jmp    5a5a <APGridPaint+0x816>
    }
    if (wnd->total_page <= 0 || wnd->cur_page >= wnd->total_page)
    54f5:	8b 45 08             	mov    0x8(%ebp),%eax
    54f8:	8b 40 10             	mov    0x10(%eax),%eax
    54fb:	85 c0                	test   %eax,%eax
    54fd:	7e 10                	jle    550f <APGridPaint+0x2cb>
    54ff:	8b 45 08             	mov    0x8(%ebp),%eax
    5502:	8b 50 14             	mov    0x14(%eax),%edx
    5505:	8b 45 08             	mov    0x8(%ebp),%eax
    5508:	8b 40 10             	mov    0x10(%eax),%eax
    550b:	39 c2                	cmp    %eax,%edx
    550d:	7c 17                	jl     5526 <APGridPaint+0x2e2>
    {
        printf(1,"Grid mode page error!");
    550f:	83 ec 08             	sub    $0x8,%esp
    5512:	68 ee 75 00 00       	push   $0x75ee
    5517:	6a 01                	push   $0x1
    5519:	e8 a4 e8 ff ff       	call   3dc2 <printf>
    551e:	83 c4 10             	add    $0x10,%esp
        return;
    5521:	e9 34 05 00 00       	jmp    5a5a <APGridPaint+0x816>
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    5526:	8b 45 08             	mov    0x8(%ebp),%eax
    5529:	8b 40 14             	mov    0x14(%eax),%eax
    552c:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
    5532:	89 45 dc             	mov    %eax,-0x24(%ebp)
    5535:	8b 45 dc             	mov    -0x24(%ebp),%eax
    5538:	89 45 d8             	mov    %eax,-0x28(%ebp)
    for (int j = 0; j < GRID_H_NUMBER; j++)
    553b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    5542:	e9 f4 03 00 00       	jmp    593b <APGridPaint+0x6f7>
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    5547:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    554e:	e9 da 03 00 00       	jmp    592d <APGridPaint+0x6e9>
        {
            index = start + GRID_W_NUMBER * j + i;
    5553:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5556:	c1 e0 04             	shl    $0x4,%eax
    5559:	89 c2                	mov    %eax,%edx
    555b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    555e:	01 c2                	add    %eax,%edx
    5560:	8b 45 e0             	mov    -0x20(%ebp),%eax
    5563:	01 d0                	add    %edx,%eax
    5565:	89 45 dc             	mov    %eax,-0x24(%ebp)
            APen pen;
            ABrush brush;
            switch (wnd->Grid[index])
    5568:	8b 45 08             	mov    0x8(%ebp),%eax
    556b:	8b 40 0c             	mov    0xc(%eax),%eax
    556e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    5571:	c1 e2 02             	shl    $0x2,%edx
    5574:	01 d0                	add    %edx,%eax
    5576:	8b 00                	mov    (%eax),%eax
    5578:	83 f8 0a             	cmp    $0xa,%eax
    557b:	0f 87 a7 03 00 00    	ja     5928 <APGridPaint+0x6e4>
    5581:	8b 04 85 04 76 00 00 	mov    0x7604(,%eax,4),%eax
    5588:	ff e0                	jmp    *%eax
            {
                case GRID_WALL:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_wall,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    558a:	8d 45 c0             	lea    -0x40(%ebp),%eax
    558d:	6a 0c                	push   $0xc
    558f:	6a 0c                	push   $0xc
    5591:	6a 0c                	push   $0xc
    5593:	50                   	push   %eax
    5594:	e8 91 f8 ff ff       	call   4e2a <RGB>
    5599:	83 c4 0c             	add    $0xc,%esp
    559c:	8b 1d 50 04 01 00    	mov    0x10450,%ebx
    55a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    55a5:	6b c8 32             	imul   $0x32,%eax,%ecx
    55a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    55ab:	6b c0 32             	imul   $0x32,%eax,%eax
    55ae:	89 45 84             	mov    %eax,-0x7c(%ebp)
    55b1:	8b 45 08             	mov    0x8(%ebp),%eax
    55b4:	8d 78 3c             	lea    0x3c(%eax),%edi
    55b7:	83 ec 0c             	sub    $0xc,%esp
    55ba:	83 ec 04             	sub    $0x4,%esp
    55bd:	89 e0                	mov    %esp,%eax
    55bf:	0f b7 75 c0          	movzwl -0x40(%ebp),%esi
    55c3:	66 89 30             	mov    %si,(%eax)
    55c6:	0f b6 55 c2          	movzbl -0x3e(%ebp),%edx
    55ca:	88 50 02             	mov    %dl,0x2(%eax)
    55cd:	6a 32                	push   $0x32
    55cf:	6a 32                	push   $0x32
    55d1:	6a 00                	push   $0x0
    55d3:	6a 00                	push   $0x0
    55d5:	53                   	push   %ebx
    55d6:	51                   	push   %ecx
    55d7:	ff 75 84             	pushl  -0x7c(%ebp)
    55da:	57                   	push   %edi
    55db:	e8 a6 f6 ff ff       	call   4c86 <APDcCopy>
    55e0:	83 c4 30             	add    $0x30,%esp
                    break;
    55e3:	e9 41 03 00 00       	jmp    5929 <APGridPaint+0x6e5>
                case GRID_ROAD:
                    //printf(1,"Grid_Road");
                    pen.color = RGB(0x69,0x69,0x69);
    55e8:	8d 45 88             	lea    -0x78(%ebp),%eax
    55eb:	6a 69                	push   $0x69
    55ed:	6a 69                	push   $0x69
    55ef:	6a 69                	push   $0x69
    55f1:	50                   	push   %eax
    55f2:	e8 33 f8 ff ff       	call   4e2a <RGB>
    55f7:	83 c4 0c             	add    $0xc,%esp
    55fa:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    55fe:	66 89 45 a8          	mov    %ax,-0x58(%ebp)
    5602:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    5606:	88 45 aa             	mov    %al,-0x56(%ebp)
                    pen.size = 1;
    5609:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
                    brush.color = RGB(0x69,0x69,0x69);
    5610:	8d 45 88             	lea    -0x78(%ebp),%eax
    5613:	6a 69                	push   $0x69
    5615:	6a 69                	push   $0x69
    5617:	6a 69                	push   $0x69
    5619:	50                   	push   %eax
    561a:	e8 0b f8 ff ff       	call   4e2a <RGB>
    561f:	83 c4 0c             	add    $0xc,%esp
    5622:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    5626:	66 89 45 a5          	mov    %ax,-0x5b(%ebp)
    562a:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    562e:	88 45 a7             	mov    %al,-0x59(%ebp)
                    APSetPen(&wnd->Dc,pen);
    5631:	8b 45 08             	mov    0x8(%ebp),%eax
    5634:	8d 50 3c             	lea    0x3c(%eax),%edx
    5637:	8d 45 88             	lea    -0x78(%ebp),%eax
    563a:	ff 75 ac             	pushl  -0x54(%ebp)
    563d:	ff 75 a8             	pushl  -0x58(%ebp)
    5640:	52                   	push   %edx
    5641:	50                   	push   %eax
    5642:	e8 d0 ee ff ff       	call   4517 <APSetPen>
    5647:	83 c4 0c             	add    $0xc,%esp
                    APSetBrush(&wnd->Dc,brush);
    564a:	8b 45 08             	mov    0x8(%ebp),%eax
    564d:	8d 58 3c             	lea    0x3c(%eax),%ebx
    5650:	8d 55 88             	lea    -0x78(%ebp),%edx
    5653:	83 ec 04             	sub    $0x4,%esp
    5656:	83 ec 04             	sub    $0x4,%esp
    5659:	89 e0                	mov    %esp,%eax
    565b:	0f b7 4d a5          	movzwl -0x5b(%ebp),%ecx
    565f:	66 89 08             	mov    %cx,(%eax)
    5662:	0f b6 4d a7          	movzbl -0x59(%ebp),%ecx
    5666:	88 48 02             	mov    %cl,0x2(%eax)
    5669:	53                   	push   %ebx
    566a:	52                   	push   %edx
    566b:	e8 e0 ee ff ff       	call   4550 <APSetBrush>
    5670:	83 c4 0c             	add    $0xc,%esp
                    APDrawRect(&wnd->Dc,i * GRID_WIDTH,j * GRID_WIDTH,GRID_WIDTH,GRID_WIDTH);
    5673:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5676:	6b d0 32             	imul   $0x32,%eax,%edx
    5679:	8b 45 e0             	mov    -0x20(%ebp),%eax
    567c:	6b c0 32             	imul   $0x32,%eax,%eax
    567f:	8b 4d 08             	mov    0x8(%ebp),%ecx
    5682:	83 c1 3c             	add    $0x3c,%ecx
    5685:	83 ec 0c             	sub    $0xc,%esp
    5688:	6a 32                	push   $0x32
    568a:	6a 32                	push   $0x32
    568c:	52                   	push   %edx
    568d:	50                   	push   %eax
    568e:	51                   	push   %ecx
    568f:	e8 e6 f2 ff ff       	call   497a <APDrawRect>
    5694:	83 c4 20             	add    $0x20,%esp
                    break;
    5697:	e9 8d 02 00 00       	jmp    5929 <APGridPaint+0x6e5>
                case GRID_GRASS:
                    //printf(1,"Grid_Grass");
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_grass,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    569c:	8d 45 c3             	lea    -0x3d(%ebp),%eax
    569f:	6a 0c                	push   $0xc
    56a1:	6a 0c                	push   $0xc
    56a3:	6a 0c                	push   $0xc
    56a5:	50                   	push   %eax
    56a6:	e8 7f f7 ff ff       	call   4e2a <RGB>
    56ab:	83 c4 0c             	add    $0xc,%esp
    56ae:	8b 1d a0 04 01 00    	mov    0x104a0,%ebx
    56b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    56b7:	6b c8 32             	imul   $0x32,%eax,%ecx
    56ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
    56bd:	6b c0 32             	imul   $0x32,%eax,%eax
    56c0:	89 45 84             	mov    %eax,-0x7c(%ebp)
    56c3:	8b 45 08             	mov    0x8(%ebp),%eax
    56c6:	8d 78 3c             	lea    0x3c(%eax),%edi
    56c9:	83 ec 0c             	sub    $0xc,%esp
    56cc:	83 ec 04             	sub    $0x4,%esp
    56cf:	89 e0                	mov    %esp,%eax
    56d1:	0f b7 75 c3          	movzwl -0x3d(%ebp),%esi
    56d5:	66 89 30             	mov    %si,(%eax)
    56d8:	0f b6 55 c5          	movzbl -0x3b(%ebp),%edx
    56dc:	88 50 02             	mov    %dl,0x2(%eax)
    56df:	6a 32                	push   $0x32
    56e1:	6a 32                	push   $0x32
    56e3:	6a 00                	push   $0x0
    56e5:	6a 00                	push   $0x0
    56e7:	53                   	push   %ebx
    56e8:	51                   	push   %ecx
    56e9:	ff 75 84             	pushl  -0x7c(%ebp)
    56ec:	57                   	push   %edi
    56ed:	e8 94 f5 ff ff       	call   4c86 <APDcCopy>
    56f2:	83 c4 30             	add    $0x30,%esp
                    break;
    56f5:	e9 2f 02 00 00       	jmp    5929 <APGridPaint+0x6e5>
                case GRID_RIVER:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_river,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    56fa:	8d 45 c6             	lea    -0x3a(%ebp),%eax
    56fd:	6a 0c                	push   $0xc
    56ff:	6a 0c                	push   $0xc
    5701:	6a 0c                	push   $0xc
    5703:	50                   	push   %eax
    5704:	e8 21 f7 ff ff       	call   4e2a <RGB>
    5709:	83 c4 0c             	add    $0xc,%esp
    570c:	8b 1d 7c 04 01 00    	mov    0x1047c,%ebx
    5712:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5715:	6b c8 32             	imul   $0x32,%eax,%ecx
    5718:	8b 45 e0             	mov    -0x20(%ebp),%eax
    571b:	6b c0 32             	imul   $0x32,%eax,%eax
    571e:	89 45 84             	mov    %eax,-0x7c(%ebp)
    5721:	8b 45 08             	mov    0x8(%ebp),%eax
    5724:	8d 78 3c             	lea    0x3c(%eax),%edi
    5727:	83 ec 0c             	sub    $0xc,%esp
    572a:	83 ec 04             	sub    $0x4,%esp
    572d:	89 e0                	mov    %esp,%eax
    572f:	0f b7 75 c6          	movzwl -0x3a(%ebp),%esi
    5733:	66 89 30             	mov    %si,(%eax)
    5736:	0f b6 55 c8          	movzbl -0x38(%ebp),%edx
    573a:	88 50 02             	mov    %dl,0x2(%eax)
    573d:	6a 32                	push   $0x32
    573f:	6a 32                	push   $0x32
    5741:	6a 00                	push   $0x0
    5743:	6a 00                	push   $0x0
    5745:	53                   	push   %ebx
    5746:	51                   	push   %ecx
    5747:	ff 75 84             	pushl  -0x7c(%ebp)
    574a:	57                   	push   %edi
    574b:	e8 36 f5 ff ff       	call   4c86 <APDcCopy>
    5750:	83 c4 30             	add    $0x30,%esp
                    break;
    5753:	e9 d1 01 00 00       	jmp    5929 <APGridPaint+0x6e5>
                case GRID_FOREST:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_forest,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    5758:	8d 45 c9             	lea    -0x37(%ebp),%eax
    575b:	6a 0c                	push   $0xc
    575d:	6a 0c                	push   $0xc
    575f:	6a 0c                	push   $0xc
    5761:	50                   	push   %eax
    5762:	e8 c3 f6 ff ff       	call   4e2a <RGB>
    5767:	83 c4 0c             	add    $0xc,%esp
    576a:	8b 1d 54 04 01 00    	mov    0x10454,%ebx
    5770:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5773:	6b c8 32             	imul   $0x32,%eax,%ecx
    5776:	8b 45 e0             	mov    -0x20(%ebp),%eax
    5779:	6b c0 32             	imul   $0x32,%eax,%eax
    577c:	89 45 84             	mov    %eax,-0x7c(%ebp)
    577f:	8b 45 08             	mov    0x8(%ebp),%eax
    5782:	8d 78 3c             	lea    0x3c(%eax),%edi
    5785:	83 ec 0c             	sub    $0xc,%esp
    5788:	83 ec 04             	sub    $0x4,%esp
    578b:	89 e0                	mov    %esp,%eax
    578d:	0f b7 75 c9          	movzwl -0x37(%ebp),%esi
    5791:	66 89 30             	mov    %si,(%eax)
    5794:	0f b6 55 cb          	movzbl -0x35(%ebp),%edx
    5798:	88 50 02             	mov    %dl,0x2(%eax)
    579b:	6a 32                	push   $0x32
    579d:	6a 32                	push   $0x32
    579f:	6a 00                	push   $0x0
    57a1:	6a 00                	push   $0x0
    57a3:	53                   	push   %ebx
    57a4:	51                   	push   %ecx
    57a5:	ff 75 84             	pushl  -0x7c(%ebp)
    57a8:	57                   	push   %edi
    57a9:	e8 d8 f4 ff ff       	call   4c86 <APDcCopy>
    57ae:	83 c4 30             	add    $0x30,%esp
                    break;
    57b1:	e9 73 01 00 00       	jmp    5929 <APGridPaint+0x6e5>
                case GRID_LAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_lake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    57b6:	8d 45 cc             	lea    -0x34(%ebp),%eax
    57b9:	6a 0c                	push   $0xc
    57bb:	6a 0c                	push   $0xc
    57bd:	6a 0c                	push   $0xc
    57bf:	50                   	push   %eax
    57c0:	e8 65 f6 ff ff       	call   4e2a <RGB>
    57c5:	83 c4 0c             	add    $0xc,%esp
    57c8:	8b 1d 9c 04 01 00    	mov    0x1049c,%ebx
    57ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    57d1:	6b c8 32             	imul   $0x32,%eax,%ecx
    57d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    57d7:	6b c0 32             	imul   $0x32,%eax,%eax
    57da:	89 45 84             	mov    %eax,-0x7c(%ebp)
    57dd:	8b 45 08             	mov    0x8(%ebp),%eax
    57e0:	8d 78 3c             	lea    0x3c(%eax),%edi
    57e3:	83 ec 0c             	sub    $0xc,%esp
    57e6:	83 ec 04             	sub    $0x4,%esp
    57e9:	89 e0                	mov    %esp,%eax
    57eb:	0f b7 75 cc          	movzwl -0x34(%ebp),%esi
    57ef:	66 89 30             	mov    %si,(%eax)
    57f2:	0f b6 55 ce          	movzbl -0x32(%ebp),%edx
    57f6:	88 50 02             	mov    %dl,0x2(%eax)
    57f9:	6a 32                	push   $0x32
    57fb:	6a 32                	push   $0x32
    57fd:	6a 00                	push   $0x0
    57ff:	6a 00                	push   $0x0
    5801:	53                   	push   %ebx
    5802:	51                   	push   %ecx
    5803:	ff 75 84             	pushl  -0x7c(%ebp)
    5806:	57                   	push   %edi
    5807:	e8 7a f4 ff ff       	call   4c86 <APDcCopy>
    580c:	83 c4 30             	add    $0x30,%esp
                    break;
    580f:	e9 15 01 00 00       	jmp    5929 <APGridPaint+0x6e5>
                case GRID_STONE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_stone,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    5814:	8d 45 cf             	lea    -0x31(%ebp),%eax
    5817:	6a 0c                	push   $0xc
    5819:	6a 0c                	push   $0xc
    581b:	6a 0c                	push   $0xc
    581d:	50                   	push   %eax
    581e:	e8 07 f6 ff ff       	call   4e2a <RGB>
    5823:	83 c4 0c             	add    $0xc,%esp
    5826:	8b 1d 24 04 01 00    	mov    0x10424,%ebx
    582c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    582f:	6b c8 32             	imul   $0x32,%eax,%ecx
    5832:	8b 45 e0             	mov    -0x20(%ebp),%eax
    5835:	6b c0 32             	imul   $0x32,%eax,%eax
    5838:	89 45 84             	mov    %eax,-0x7c(%ebp)
    583b:	8b 45 08             	mov    0x8(%ebp),%eax
    583e:	8d 78 3c             	lea    0x3c(%eax),%edi
    5841:	83 ec 0c             	sub    $0xc,%esp
    5844:	83 ec 04             	sub    $0x4,%esp
    5847:	89 e0                	mov    %esp,%eax
    5849:	0f b7 75 cf          	movzwl -0x31(%ebp),%esi
    584d:	66 89 30             	mov    %si,(%eax)
    5850:	0f b6 55 d1          	movzbl -0x2f(%ebp),%edx
    5854:	88 50 02             	mov    %dl,0x2(%eax)
    5857:	6a 32                	push   $0x32
    5859:	6a 32                	push   $0x32
    585b:	6a 00                	push   $0x0
    585d:	6a 00                	push   $0x0
    585f:	53                   	push   %ebx
    5860:	51                   	push   %ecx
    5861:	ff 75 84             	pushl  -0x7c(%ebp)
    5864:	57                   	push   %edi
    5865:	e8 1c f4 ff ff       	call   4c86 <APDcCopy>
    586a:	83 c4 30             	add    $0x30,%esp
                    break;
    586d:	e9 b7 00 00 00       	jmp    5929 <APGridPaint+0x6e5>
                case GRID_MOUNTAIN:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_mountain,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    5872:	8d 45 d2             	lea    -0x2e(%ebp),%eax
    5875:	6a 0c                	push   $0xc
    5877:	6a 0c                	push   $0xc
    5879:	6a 0c                	push   $0xc
    587b:	50                   	push   %eax
    587c:	e8 a9 f5 ff ff       	call   4e2a <RGB>
    5881:	83 c4 0c             	add    $0xc,%esp
    5884:	8b 1d 40 04 01 00    	mov    0x10440,%ebx
    588a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    588d:	6b c8 32             	imul   $0x32,%eax,%ecx
    5890:	8b 45 e0             	mov    -0x20(%ebp),%eax
    5893:	6b c0 32             	imul   $0x32,%eax,%eax
    5896:	89 45 84             	mov    %eax,-0x7c(%ebp)
    5899:	8b 45 08             	mov    0x8(%ebp),%eax
    589c:	8d 78 3c             	lea    0x3c(%eax),%edi
    589f:	83 ec 0c             	sub    $0xc,%esp
    58a2:	83 ec 04             	sub    $0x4,%esp
    58a5:	89 e0                	mov    %esp,%eax
    58a7:	0f b7 75 d2          	movzwl -0x2e(%ebp),%esi
    58ab:	66 89 30             	mov    %si,(%eax)
    58ae:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
    58b2:	88 50 02             	mov    %dl,0x2(%eax)
    58b5:	6a 32                	push   $0x32
    58b7:	6a 32                	push   $0x32
    58b9:	6a 00                	push   $0x0
    58bb:	6a 00                	push   $0x0
    58bd:	53                   	push   %ebx
    58be:	51                   	push   %ecx
    58bf:	ff 75 84             	pushl  -0x7c(%ebp)
    58c2:	57                   	push   %edi
    58c3:	e8 be f3 ff ff       	call   4c86 <APDcCopy>
    58c8:	83 c4 30             	add    $0x30,%esp
                    break;
    58cb:	eb 5c                	jmp    5929 <APGridPaint+0x6e5>
                case GRID_PROGRAM_SNAKE:
                    APDcCopy(&wnd->Dc,i * GRID_WIDTH ,j * GRID_WIDTH,g_snake,0,0,GRID_WIDTH,GRID_WIDTH,COLOR_NULL);
    58cd:	8d 45 d5             	lea    -0x2b(%ebp),%eax
    58d0:	6a 0c                	push   $0xc
    58d2:	6a 0c                	push   $0xc
    58d4:	6a 0c                	push   $0xc
    58d6:	50                   	push   %eax
    58d7:	e8 4e f5 ff ff       	call   4e2a <RGB>
    58dc:	83 c4 0c             	add    $0xc,%esp
    58df:	8b 1d 98 04 01 00    	mov    0x10498,%ebx
    58e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    58e8:	6b c8 32             	imul   $0x32,%eax,%ecx
    58eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    58ee:	6b c0 32             	imul   $0x32,%eax,%eax
    58f1:	89 45 84             	mov    %eax,-0x7c(%ebp)
    58f4:	8b 45 08             	mov    0x8(%ebp),%eax
    58f7:	8d 78 3c             	lea    0x3c(%eax),%edi
    58fa:	83 ec 0c             	sub    $0xc,%esp
    58fd:	83 ec 04             	sub    $0x4,%esp
    5900:	89 e0                	mov    %esp,%eax
    5902:	0f b7 75 d5          	movzwl -0x2b(%ebp),%esi
    5906:	66 89 30             	mov    %si,(%eax)
    5909:	0f b6 55 d7          	movzbl -0x29(%ebp),%edx
    590d:	88 50 02             	mov    %dl,0x2(%eax)
    5910:	6a 32                	push   $0x32
    5912:	6a 32                	push   $0x32
    5914:	6a 00                	push   $0x0
    5916:	6a 00                	push   $0x0
    5918:	53                   	push   %ebx
    5919:	51                   	push   %ecx
    591a:	ff 75 84             	pushl  -0x7c(%ebp)
    591d:	57                   	push   %edi
    591e:	e8 63 f3 ff ff       	call   4c86 <APDcCopy>
    5923:	83 c4 30             	add    $0x30,%esp
                    break;
    5926:	eb 01                	jmp    5929 <APGridPaint+0x6e5>
                default: break;
    5928:	90                   	nop
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    {
        for (int i = 0; i < GRID_W_NUMBER;i++)
    5929:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    592d:	83 7d e0 0f          	cmpl   $0xf,-0x20(%ebp)
    5931:	0f 8e 1c fc ff ff    	jle    5553 <APGridPaint+0x30f>
        return;
    }
    
    //Grid part
    int index = wnd->cur_page * GRID_W_NUMBER * GRID_H_NUMBER,start = index;
    for (int j = 0; j < GRID_H_NUMBER; j++)
    5937:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    593b:	83 7d e4 0a          	cmpl   $0xa,-0x1c(%ebp)
    593f:	0f 8e 02 fc ff ff    	jle    5547 <APGridPaint+0x303>
        }
    }
    //Title Part
    APen pen;
    ABrush brush;
    pen.color = RGB(0x18,0x74,0xcd);
    5945:	8d 45 88             	lea    -0x78(%ebp),%eax
    5948:	68 cd 00 00 00       	push   $0xcd
    594d:	6a 74                	push   $0x74
    594f:	6a 18                	push   $0x18
    5951:	50                   	push   %eax
    5952:	e8 d3 f4 ff ff       	call   4e2a <RGB>
    5957:	83 c4 0c             	add    $0xc,%esp
    595a:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    595e:	66 89 45 b8          	mov    %ax,-0x48(%ebp)
    5962:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    5966:	88 45 ba             	mov    %al,-0x46(%ebp)
    pen.size = 1;
    5969:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    brush.color = RGB(0x18,0x74,0xcd);
    5970:	8d 45 88             	lea    -0x78(%ebp),%eax
    5973:	68 cd 00 00 00       	push   $0xcd
    5978:	6a 74                	push   $0x74
    597a:	6a 18                	push   $0x18
    597c:	50                   	push   %eax
    597d:	e8 a8 f4 ff ff       	call   4e2a <RGB>
    5982:	83 c4 0c             	add    $0xc,%esp
    5985:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    5989:	66 89 45 b5          	mov    %ax,-0x4b(%ebp)
    598d:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    5991:	88 45 b7             	mov    %al,-0x49(%ebp)
    APSetPen(&wnd->TitleDc,pen);
    5994:	8b 45 08             	mov    0x8(%ebp),%eax
    5997:	8d 50 58             	lea    0x58(%eax),%edx
    599a:	8d 45 88             	lea    -0x78(%ebp),%eax
    599d:	ff 75 bc             	pushl  -0x44(%ebp)
    59a0:	ff 75 b8             	pushl  -0x48(%ebp)
    59a3:	52                   	push   %edx
    59a4:	50                   	push   %eax
    59a5:	e8 6d eb ff ff       	call   4517 <APSetPen>
    59aa:	83 c4 0c             	add    $0xc,%esp
    APSetBrush(&wnd->TitleDc,brush);
    59ad:	8b 45 08             	mov    0x8(%ebp),%eax
    59b0:	8d 58 58             	lea    0x58(%eax),%ebx
    59b3:	8d 55 88             	lea    -0x78(%ebp),%edx
    59b6:	83 ec 04             	sub    $0x4,%esp
    59b9:	83 ec 04             	sub    $0x4,%esp
    59bc:	89 e0                	mov    %esp,%eax
    59be:	0f b7 4d b5          	movzwl -0x4b(%ebp),%ecx
    59c2:	66 89 08             	mov    %cx,(%eax)
    59c5:	0f b6 4d b7          	movzbl -0x49(%ebp),%ecx
    59c9:	88 48 02             	mov    %cl,0x2(%eax)
    59cc:	53                   	push   %ebx
    59cd:	52                   	push   %edx
    59ce:	e8 7d eb ff ff       	call   4550 <APSetBrush>
    59d3:	83 c4 0c             	add    $0xc,%esp
    APDrawRect(&wnd->TitleDc,0,0,SCREEN_WIDTH,WND_TITLE_HEIGHT);
    59d6:	8b 45 08             	mov    0x8(%ebp),%eax
    59d9:	83 c0 58             	add    $0x58,%eax
    59dc:	83 ec 0c             	sub    $0xc,%esp
    59df:	6a 32                	push   $0x32
    59e1:	68 20 03 00 00       	push   $0x320
    59e6:	6a 00                	push   $0x0
    59e8:	6a 00                	push   $0x0
    59ea:	50                   	push   %eax
    59eb:	e8 8a ef ff ff       	call   497a <APDrawRect>
    59f0:	83 c4 20             	add    $0x20,%esp


    AFont font;
    font.color = RGB(0x08,0x08,0x08);
    59f3:	8d 45 88             	lea    -0x78(%ebp),%eax
    59f6:	6a 08                	push   $0x8
    59f8:	6a 08                	push   $0x8
    59fa:	6a 08                	push   $0x8
    59fc:	50                   	push   %eax
    59fd:	e8 28 f4 ff ff       	call   4e2a <RGB>
    5a02:	83 c4 0c             	add    $0xc,%esp
    5a05:	0f b7 45 88          	movzwl -0x78(%ebp),%eax
    5a09:	66 89 45 b2          	mov    %ax,-0x4e(%ebp)
    5a0d:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
    5a11:	88 45 b4             	mov    %al,-0x4c(%ebp)
    APSetFont(&wnd->TitleDc,font);
    5a14:	8b 45 08             	mov    0x8(%ebp),%eax
    5a17:	8d 58 58             	lea    0x58(%eax),%ebx
    5a1a:	8d 55 88             	lea    -0x78(%ebp),%edx
    5a1d:	83 ec 04             	sub    $0x4,%esp
    5a20:	83 ec 04             	sub    $0x4,%esp
    5a23:	89 e0                	mov    %esp,%eax
    5a25:	0f b7 4d b2          	movzwl -0x4e(%ebp),%ecx
    5a29:	66 89 08             	mov    %cx,(%eax)
    5a2c:	0f b6 4d b4          	movzbl -0x4c(%ebp),%ecx
    5a30:	88 48 02             	mov    %cl,0x2(%eax)
    5a33:	53                   	push   %ebx
    5a34:	52                   	push   %edx
    5a35:	e8 58 eb ff ff       	call   4592 <APSetFont>
    5a3a:	83 c4 0c             	add    $0xc,%esp
    APDrawText(&wnd->TitleDc,wnd->title,20,20);
    5a3d:	8b 45 08             	mov    0x8(%ebp),%eax
    5a40:	8d 90 84 00 00 00    	lea    0x84(%eax),%edx
    5a46:	8b 45 08             	mov    0x8(%ebp),%eax
    5a49:	83 c0 58             	add    $0x58,%eax
    5a4c:	6a 14                	push   $0x14
    5a4e:	6a 14                	push   $0x14
    5a50:	52                   	push   %edx
    5a51:	50                   	push   %eax
    5a52:	e8 28 f1 ff ff       	call   4b7f <APDrawText>
    5a57:	83 c4 10             	add    $0x10,%esp
    
}
    5a5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    5a5d:	5b                   	pop    %ebx
    5a5e:	5e                   	pop    %esi
    5a5f:	5f                   	pop    %edi
    5a60:	5d                   	pop    %ebp
    5a61:	c3                   	ret    

00005a62 <random>:

#include "APLib.h"
#include "x86.h"

int random(int seed)
{
    5a62:	55                   	push   %ebp
    5a63:	89 e5                	mov    %esp,%ebp
static int rand_num = 3;
if (seed > 0)
    5a65:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    5a69:	7e 08                	jle    5a73 <random+0x11>
{
rand_num = seed;
    5a6b:	8b 45 08             	mov    0x8(%ebp),%eax
    5a6e:	a3 40 bc 00 00       	mov    %eax,0xbc40
}
rand_num *= 3;
    5a73:	8b 15 40 bc 00 00    	mov    0xbc40,%edx
    5a79:	89 d0                	mov    %edx,%eax
    5a7b:	01 c0                	add    %eax,%eax
    5a7d:	01 d0                	add    %edx,%eax
    5a7f:	a3 40 bc 00 00       	mov    %eax,0xbc40
if (rand_num < 0)
    5a84:	a1 40 bc 00 00       	mov    0xbc40,%eax
    5a89:	85 c0                	test   %eax,%eax
    5a8b:	79 0c                	jns    5a99 <random+0x37>
{
rand_num *= (-1);
    5a8d:	a1 40 bc 00 00       	mov    0xbc40,%eax
    5a92:	f7 d8                	neg    %eax
    5a94:	a3 40 bc 00 00       	mov    %eax,0xbc40
}
return rand_num % 997;
    5a99:	8b 0d 40 bc 00 00    	mov    0xbc40,%ecx
    5a9f:	ba f1 65 77 83       	mov    $0x837765f1,%edx
    5aa4:	89 c8                	mov    %ecx,%eax
    5aa6:	f7 ea                	imul   %edx
    5aa8:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
    5aab:	c1 f8 09             	sar    $0x9,%eax
    5aae:	89 c2                	mov    %eax,%edx
    5ab0:	89 c8                	mov    %ecx,%eax
    5ab2:	c1 f8 1f             	sar    $0x1f,%eax
    5ab5:	29 c2                	sub    %eax,%edx
    5ab7:	89 d0                	mov    %edx,%eax
    5ab9:	69 c0 e5 03 00 00    	imul   $0x3e5,%eax,%eax
    5abf:	29 c1                	sub    %eax,%ecx
    5ac1:	89 c8                	mov    %ecx,%eax
}
    5ac3:	5d                   	pop    %ebp
    5ac4:	c3                   	ret    

00005ac5 <sprintint>:

static void
sprintint(char * dst, int * j, int xx, int base, int sgn, int size)
{
    5ac5:	55                   	push   %ebp
    5ac6:	89 e5                	mov    %esp,%ebp
    5ac8:	53                   	push   %ebx
    5ac9:	83 ec 20             	sub    $0x20,%esp
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    5acc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(sgn && xx < 0){
    5ad3:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
    5ad7:	74 17                	je     5af0 <sprintint+0x2b>
    5ad9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    5add:	79 11                	jns    5af0 <sprintint+0x2b>
        neg = 1;
    5adf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        x = -xx;
    5ae6:	8b 45 10             	mov    0x10(%ebp),%eax
    5ae9:	f7 d8                	neg    %eax
    5aeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    5aee:	eb 06                	jmp    5af6 <sprintint+0x31>
    } else {
        x = xx;
    5af0:	8b 45 10             	mov    0x10(%ebp),%eax
    5af3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    
    i = 0;
    5af6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    do{
        buf[i++] = digits[x % base];
    5afd:	8b 4d f8             	mov    -0x8(%ebp),%ecx
    5b00:	8d 41 01             	lea    0x1(%ecx),%eax
    5b03:	89 45 f8             	mov    %eax,-0x8(%ebp)
    5b06:	8b 5d 14             	mov    0x14(%ebp),%ebx
    5b09:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5b0c:	ba 00 00 00 00       	mov    $0x0,%edx
    5b11:	f7 f3                	div    %ebx
    5b13:	89 d0                	mov    %edx,%eax
    5b15:	0f b6 80 44 bc 00 00 	movzbl 0xbc44(%eax),%eax
    5b1c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
    }while((x /= base) != 0);
    5b20:	8b 5d 14             	mov    0x14(%ebp),%ebx
    5b23:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5b26:	ba 00 00 00 00       	mov    $0x0,%edx
    5b2b:	f7 f3                	div    %ebx
    5b2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    5b30:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    5b34:	75 c7                	jne    5afd <sprintint+0x38>
    if(neg)
    5b36:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    5b3a:	74 0e                	je     5b4a <sprintint+0x85>
        buf[i++] = '-';
    5b3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5b3f:	8d 50 01             	lea    0x1(%eax),%edx
    5b42:	89 55 f8             	mov    %edx,-0x8(%ebp)
    5b45:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
    
    size -= i;
    5b4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5b4d:	29 45 1c             	sub    %eax,0x1c(%ebp)
    while (size > 0)
    5b50:	eb 1b                	jmp    5b6d <sprintint+0xa8>
    {
        dst[(*j)++] = '0';
    5b52:	8b 45 0c             	mov    0xc(%ebp),%eax
    5b55:	8b 00                	mov    (%eax),%eax
    5b57:	8d 48 01             	lea    0x1(%eax),%ecx
    5b5a:	8b 55 0c             	mov    0xc(%ebp),%edx
    5b5d:	89 0a                	mov    %ecx,(%edx)
    5b5f:	89 c2                	mov    %eax,%edx
    5b61:	8b 45 08             	mov    0x8(%ebp),%eax
    5b64:	01 d0                	add    %edx,%eax
    5b66:	c6 00 30             	movb   $0x30,(%eax)
        --size;
    5b69:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    }while((x /= base) != 0);
    if(neg)
        buf[i++] = '-';
    
    size -= i;
    while (size > 0)
    5b6d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    5b71:	7f df                	jg     5b52 <sprintint+0x8d>
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    5b73:	eb 21                	jmp    5b96 <sprintint+0xd1>
        dst[(*j)++] = buf[i];
    5b75:	8b 45 0c             	mov    0xc(%ebp),%eax
    5b78:	8b 00                	mov    (%eax),%eax
    5b7a:	8d 48 01             	lea    0x1(%eax),%ecx
    5b7d:	8b 55 0c             	mov    0xc(%ebp),%edx
    5b80:	89 0a                	mov    %ecx,(%edx)
    5b82:	89 c2                	mov    %eax,%edx
    5b84:	8b 45 08             	mov    0x8(%ebp),%eax
    5b87:	01 c2                	add    %eax,%edx
    5b89:	8d 4d e0             	lea    -0x20(%ebp),%ecx
    5b8c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    5b8f:	01 c8                	add    %ecx,%eax
    5b91:	0f b6 00             	movzbl (%eax),%eax
    5b94:	88 02                	mov    %al,(%edx)
    {
        dst[(*j)++] = '0';
        --size;
    }
    
    while(--i >= 0)
    5b96:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
    5b9a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
    5b9e:	79 d5                	jns    5b75 <sprintint+0xb0>
        dst[(*j)++] = buf[i];
}
    5ba0:	90                   	nop
    5ba1:	83 c4 20             	add    $0x20,%esp
    5ba4:	5b                   	pop    %ebx
    5ba5:	5d                   	pop    %ebp
    5ba6:	c3                   	ret    

00005ba7 <sprintf>:


void sprintf(char * dst, char * fmt, ...)
{
    5ba7:	55                   	push   %ebp
    5ba8:	89 e5                	mov    %esp,%ebp
    5baa:	83 ec 38             	sub    $0x38,%esp
    char *s;
    char buf[10];
    int bi = 0;
    5bad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int c, i, state, j;
    uint *ap;
    j = 0;
    5bb4:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
    
    state = 0;
    5bbb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    ap = (uint*)(void*)&fmt + 1;
    5bc2:	8d 45 0c             	lea    0xc(%ebp),%eax
    5bc5:	83 c0 04             	add    $0x4,%eax
    5bc8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(i = 0; fmt[i]; i++){
    5bcb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5bd2:	e9 d9 01 00 00       	jmp    5db0 <sprintf+0x209>
        c = fmt[i] & 0xff;
    5bd7:	8b 55 0c             	mov    0xc(%ebp),%edx
    5bda:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5bdd:	01 d0                	add    %edx,%eax
    5bdf:	0f b6 00             	movzbl (%eax),%eax
    5be2:	0f be c0             	movsbl %al,%eax
    5be5:	25 ff 00 00 00       	and    $0xff,%eax
    5bea:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if(state == 0){
    5bed:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    5bf1:	75 2c                	jne    5c1f <sprintf+0x78>
            if(c == '%'){
    5bf3:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    5bf7:	75 0c                	jne    5c05 <sprintf+0x5e>
                state = '%';
    5bf9:	c7 45 e8 25 00 00 00 	movl   $0x25,-0x18(%ebp)
    5c00:	e9 a7 01 00 00       	jmp    5dac <sprintf+0x205>
            } else {
                dst[j++] = c;
    5c05:	8b 45 c8             	mov    -0x38(%ebp),%eax
    5c08:	8d 50 01             	lea    0x1(%eax),%edx
    5c0b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    5c0e:	89 c2                	mov    %eax,%edx
    5c10:	8b 45 08             	mov    0x8(%ebp),%eax
    5c13:	01 d0                	add    %edx,%eax
    5c15:	8b 55 e0             	mov    -0x20(%ebp),%edx
    5c18:	88 10                	mov    %dl,(%eax)
    5c1a:	e9 8d 01 00 00       	jmp    5dac <sprintf+0x205>
            }
        } else if(state == '%'){
    5c1f:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    5c23:	0f 85 83 01 00 00    	jne    5dac <sprintf+0x205>
            if(c == 'd'){
    5c29:	83 7d e0 64          	cmpl   $0x64,-0x20(%ebp)
    5c2d:	75 4c                	jne    5c7b <sprintf+0xd4>
                buf[bi] = '\0';
    5c2f:	8d 55 ce             	lea    -0x32(%ebp),%edx
    5c32:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5c35:	01 d0                	add    %edx,%eax
    5c37:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    5c3a:	83 ec 0c             	sub    $0xc,%esp
    5c3d:	8d 45 ce             	lea    -0x32(%ebp),%eax
    5c40:	50                   	push   %eax
    5c41:	e8 2b df ff ff       	call   3b71 <atoi>
    5c46:	83 c4 10             	add    $0x10,%esp
    5c49:	89 45 d8             	mov    %eax,-0x28(%ebp)
                bi = 0;
    5c4c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 10, 1, l);
    5c53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5c56:	8b 00                	mov    (%eax),%eax
    5c58:	83 ec 08             	sub    $0x8,%esp
    5c5b:	ff 75 d8             	pushl  -0x28(%ebp)
    5c5e:	6a 01                	push   $0x1
    5c60:	6a 0a                	push   $0xa
    5c62:	50                   	push   %eax
    5c63:	8d 45 c8             	lea    -0x38(%ebp),%eax
    5c66:	50                   	push   %eax
    5c67:	ff 75 08             	pushl  0x8(%ebp)
    5c6a:	e8 56 fe ff ff       	call   5ac5 <sprintint>
    5c6f:	83 c4 20             	add    $0x20,%esp
                ap++;
    5c72:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    5c76:	e9 2a 01 00 00       	jmp    5da5 <sprintf+0x1fe>
            } else if(c == 'x' || c == 'p'){
    5c7b:	83 7d e0 78          	cmpl   $0x78,-0x20(%ebp)
    5c7f:	74 06                	je     5c87 <sprintf+0xe0>
    5c81:	83 7d e0 70          	cmpl   $0x70,-0x20(%ebp)
    5c85:	75 4c                	jne    5cd3 <sprintf+0x12c>
                buf[bi] = '\0';
    5c87:	8d 55 ce             	lea    -0x32(%ebp),%edx
    5c8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5c8d:	01 d0                	add    %edx,%eax
    5c8f:	c6 00 00             	movb   $0x0,(%eax)
                int l = atoi(buf);
    5c92:	83 ec 0c             	sub    $0xc,%esp
    5c95:	8d 45 ce             	lea    -0x32(%ebp),%eax
    5c98:	50                   	push   %eax
    5c99:	e8 d3 de ff ff       	call   3b71 <atoi>
    5c9e:	83 c4 10             	add    $0x10,%esp
    5ca1:	89 45 dc             	mov    %eax,-0x24(%ebp)
                bi = 0;
    5ca4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                sprintint(dst, &j, *ap, 16, 0, l);
    5cab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5cae:	8b 00                	mov    (%eax),%eax
    5cb0:	83 ec 08             	sub    $0x8,%esp
    5cb3:	ff 75 dc             	pushl  -0x24(%ebp)
    5cb6:	6a 00                	push   $0x0
    5cb8:	6a 10                	push   $0x10
    5cba:	50                   	push   %eax
    5cbb:	8d 45 c8             	lea    -0x38(%ebp),%eax
    5cbe:	50                   	push   %eax
    5cbf:	ff 75 08             	pushl  0x8(%ebp)
    5cc2:	e8 fe fd ff ff       	call   5ac5 <sprintint>
    5cc7:	83 c4 20             	add    $0x20,%esp
                ap++;
    5cca:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 10, 1, l);
                ap++;
            } else if(c == 'x' || c == 'p'){
    5cce:	e9 d2 00 00 00       	jmp    5da5 <sprintf+0x1fe>
                buf[bi] = '\0';
                int l = atoi(buf);
                bi = 0;
                sprintint(dst, &j, *ap, 16, 0, l);
                ap++;
            } else if(c == 's'){
    5cd3:	83 7d e0 73          	cmpl   $0x73,-0x20(%ebp)
    5cd7:	75 46                	jne    5d1f <sprintf+0x178>
                s = (char*)*ap;
    5cd9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5cdc:	8b 00                	mov    (%eax),%eax
    5cde:	89 45 f4             	mov    %eax,-0xc(%ebp)
                ap++;
    5ce1:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
                if(s == 0)
    5ce5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    5ce9:	75 25                	jne    5d10 <sprintf+0x169>
                    s = "(null)";
    5ceb:	c7 45 f4 30 76 00 00 	movl   $0x7630,-0xc(%ebp)
                while(*s != 0){
    5cf2:	eb 1c                	jmp    5d10 <sprintf+0x169>
                    dst[j++] = *s;
    5cf4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    5cf7:	8d 50 01             	lea    0x1(%eax),%edx
    5cfa:	89 55 c8             	mov    %edx,-0x38(%ebp)
    5cfd:	89 c2                	mov    %eax,%edx
    5cff:	8b 45 08             	mov    0x8(%ebp),%eax
    5d02:	01 c2                	add    %eax,%edx
    5d04:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d07:	0f b6 00             	movzbl (%eax),%eax
    5d0a:	88 02                	mov    %al,(%edx)
                    s++;
    5d0c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            } else if(c == 's'){
                s = (char*)*ap;
                ap++;
                if(s == 0)
                    s = "(null)";
                while(*s != 0){
    5d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d13:	0f b6 00             	movzbl (%eax),%eax
    5d16:	84 c0                	test   %al,%al
    5d18:	75 da                	jne    5cf4 <sprintf+0x14d>
    5d1a:	e9 86 00 00 00       	jmp    5da5 <sprintf+0x1fe>
                    dst[j++] = *s;
                    s++;
                }
            } else if(c == 'c'){
    5d1f:	83 7d e0 63          	cmpl   $0x63,-0x20(%ebp)
    5d23:	75 1d                	jne    5d42 <sprintf+0x19b>
                dst[j++] = *ap;
    5d25:	8b 45 c8             	mov    -0x38(%ebp),%eax
    5d28:	8d 50 01             	lea    0x1(%eax),%edx
    5d2b:	89 55 c8             	mov    %edx,-0x38(%ebp)
    5d2e:	89 c2                	mov    %eax,%edx
    5d30:	8b 45 08             	mov    0x8(%ebp),%eax
    5d33:	01 c2                	add    %eax,%edx
    5d35:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5d38:	8b 00                	mov    (%eax),%eax
    5d3a:	88 02                	mov    %al,(%edx)
                ap++;
    5d3c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    5d40:	eb 63                	jmp    5da5 <sprintf+0x1fe>
            } else if(c == '%'){
    5d42:	83 7d e0 25          	cmpl   $0x25,-0x20(%ebp)
    5d46:	75 17                	jne    5d5f <sprintf+0x1b8>
                dst[j++] = c;
    5d48:	8b 45 c8             	mov    -0x38(%ebp),%eax
    5d4b:	8d 50 01             	lea    0x1(%eax),%edx
    5d4e:	89 55 c8             	mov    %edx,-0x38(%ebp)
    5d51:	89 c2                	mov    %eax,%edx
    5d53:	8b 45 08             	mov    0x8(%ebp),%eax
    5d56:	01 d0                	add    %edx,%eax
    5d58:	8b 55 e0             	mov    -0x20(%ebp),%edx
    5d5b:	88 10                	mov    %dl,(%eax)
    5d5d:	eb 46                	jmp    5da5 <sprintf+0x1fe>
            } else if(c >= '0' && c <= '9')
    5d5f:	83 7d e0 2f          	cmpl   $0x2f,-0x20(%ebp)
    5d63:	7e 18                	jle    5d7d <sprintf+0x1d6>
    5d65:	83 7d e0 39          	cmpl   $0x39,-0x20(%ebp)
    5d69:	7f 12                	jg     5d7d <sprintf+0x1d6>
            {
                buf[bi++] = c;
    5d6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5d6e:	8d 50 01             	lea    0x1(%eax),%edx
    5d71:	89 55 f0             	mov    %edx,-0x10(%ebp)
    5d74:	8b 55 e0             	mov    -0x20(%ebp),%edx
    5d77:	88 54 05 ce          	mov    %dl,-0x32(%ebp,%eax,1)
                continue;
    5d7b:	eb 2f                	jmp    5dac <sprintf+0x205>
            }
            else {
                // Unknown % sequence.  Print it to draw attention.
                dst[j++] = '%';
    5d7d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    5d80:	8d 50 01             	lea    0x1(%eax),%edx
    5d83:	89 55 c8             	mov    %edx,-0x38(%ebp)
    5d86:	89 c2                	mov    %eax,%edx
    5d88:	8b 45 08             	mov    0x8(%ebp),%eax
    5d8b:	01 d0                	add    %edx,%eax
    5d8d:	c6 00 25             	movb   $0x25,(%eax)
                dst[j++] = c;
    5d90:	8b 45 c8             	mov    -0x38(%ebp),%eax
    5d93:	8d 50 01             	lea    0x1(%eax),%edx
    5d96:	89 55 c8             	mov    %edx,-0x38(%ebp)
    5d99:	89 c2                	mov    %eax,%edx
    5d9b:	8b 45 08             	mov    0x8(%ebp),%eax
    5d9e:	01 d0                	add    %edx,%eax
    5da0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    5da3:	88 10                	mov    %dl,(%eax)
            }
            state = 0;
    5da5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    uint *ap;
    j = 0;
    
    state = 0;
    ap = (uint*)(void*)&fmt + 1;
    for(i = 0; fmt[i]; i++){
    5dac:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5db0:	8b 55 0c             	mov    0xc(%ebp),%edx
    5db3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5db6:	01 d0                	add    %edx,%eax
    5db8:	0f b6 00             	movzbl (%eax),%eax
    5dbb:	84 c0                	test   %al,%al
    5dbd:	0f 85 14 fe ff ff    	jne    5bd7 <sprintf+0x30>
                dst[j++] = c;
            }
            state = 0;
        }
    }
    dst[j++] = '\0';
    5dc3:	8b 45 c8             	mov    -0x38(%ebp),%eax
    5dc6:	8d 50 01             	lea    0x1(%eax),%edx
    5dc9:	89 55 c8             	mov    %edx,-0x38(%ebp)
    5dcc:	89 c2                	mov    %eax,%edx
    5dce:	8b 45 08             	mov    0x8(%ebp),%eax
    5dd1:	01 d0                	add    %edx,%eax
    5dd3:	c6 00 00             	movb   $0x0,(%eax)
}
    5dd6:	90                   	nop
    5dd7:	c9                   	leave  
    5dd8:	c3                   	ret    
