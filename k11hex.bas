10	  extend

20	! 04-Mar-84  23:15:56  Brian Nelson

1000	  on error go to 19000						&
	\ dim xl%(128%)							&
	\ input.recordsize%  = 4096%					&
	\ output.recordsize% = 512%					&
	\ open '_kb:' as file 12%					&
	\ print 'K11HEX - Decode Kermit-11 Hex files (RSTS/E Basic+)'	&
	\ print								&
	\ xl%(i%)         = -1% for i% = 0% to 128%			&
	\ xl%(ascii('0')) = 0%						&
	\ xl%(ascii('1')) = 1%						&
	\ xl%(ascii('2')) = 2%						&
	\ xl%(ascii('3')) = 3%						&
	\ xl%(ascii('4')) = 4%						&
	\ xl%(ascii('5')) = 5%						&
	\ xl%(ascii('6')) = 6%						&
	\ xl%(ascii('7')) = 7%						&
	\ xl%(ascii('8')) = 8%						&
	\ xl%(ascii('9')) = 9%						&
	\ xl%(ascii('A')) = 10%						&
	\ xl%(ascii('B')) = 11%						&
	\ xl%(ascii('C')) = 12%						&
	\ xl%(ascii('D')) = 13%						&
	\ xl%(ascii('E')) = 14%						&
	\ xl%(ascii('F')) = 15%						&

1020	  print 'Input  Hex  file  ? ';					&
	\ input line #12%, infile$					&
	\ print 'Output Task image ? ';					&
	\ input line #12%, outfile$					&
	\ open.in%  = 0%						&
	\ open.out% = 0%						&
	\ infile$  = cvt$$(infile$,-1%)					&
	\ outfile$ = cvt$$(outfile$,-1%)				&
	\ open infile$	for input as file #1%,				&
			recordsize  input.recordsize%,			&
			mode 8192%					&
	\ open outfile$	as file #2%, recordsize output.recordsize%	&



1040	  while -1%							&
	\  offset% = 0%							&
	\  for i% = 1% to 16%						&
	\    input line #1, rec$					&
	\    chk% = 0%							&
	\    for j% = 1% to 32%						&
	\	k%  = (j% * 2%) - 1%					&
	\	b%  = xl%( ascii(mid(rec$,k%+0%,1%)) ) * 16%		&
		    + xl%( ascii(mid(rec$,k%+1%,1%)) )			&
	\	chk% = chk% + b%					&
	\	field #2%, offset%+(j%-1%) as junk$, 1% as dat$		&
	\	lset dat$ = chr$(b%)					&
	\    next j%							&
	\    c$ = right(rec$,66%)					&
	\    check% = xl%( ascii(mid(c$,6%,1%)) )			&
		    + xl%( ascii(mid(c$,5%,1%)) ) * 16%			&
		    + xl%( ascii(mid(c$,4%,1%)) ) * 256%		&
		    + xl%( ascii(mid(c$,3%,1%)) ) * 4096%		&
	\    print 'Checksum error - ';chk%,check%			&
		    if chk% <> check%					&
	\    offset% = offset% + 32%					&
	\  next i%							&
	\  put #2%							&
	\ next


19000	  er% = err							&
	\ el% = erl							&
	\ resume 19020 if er% = 11%					&
	\ print er%;' error at line number ';,el%			&
	\ resume 32767%							&

19020	  close #1%							&
	\ close #2%							&
	\ go to 32767 if el% <> 1040%					&
	\ cmd$ = 'PIP ' + outfile$ + '<104>/RTS:RSX=' + outfile$	&
	\ print 'Trying to do CCL ';cmd$				&
	\ junk$ = sys(chr$(14%) + cmd$ )				&
	\ go to 32767							&




32767	  end
