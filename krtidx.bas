1 REM KRTIDX.BAS V03.63 27-SEP-97 \ L$=CHR$(13)+CHR$(10) \ I$=CHR$(9) \ B%=1
2 OPEN "DK:KRTHLP.HLP" FOR INPUT AS FILE #1 \ LINPUT #1,K$
3 OPEN "DK:KRTIDX.MAC" FOR OUTPUT AS FILE #2 \ X%=LEN(K$) \ Y%=Y%+X%+2
4 X$=I$+".title"+I$+"KRTIDX"+I$+"HELP RMS Index"+I$+DAT$+"  "+CLK$+L$
5 PRINT #2,X$; \ PRINT X$;
6 FOR X=1 TO 23 \ READ X$ \ PRINT #2,X$ \ PRINT X$ \ NEXT X
7 X$="hident::.asciz"+I$+'"'+K$+'"'+L$+I$+".even"+L$+L$+I$
8 PRINT #2,X$; \ PRINT X$;
9 X$=";"+I$+"address"+I$+",block"+I$+",offset"+I$+",string"+L$+"hlphead:"
10 PRINT #2,X$; \ PRINT X$;
25 IF END #1 THEN 99 \ LINPUT #1,X$
30 X%=LEN(X$) \ Y%=Y%+X%+2 \ IF Y%<512 THEN 40 \ Y%=Y%-512 \ Z%=Z%+1
40 T$=SEG$(X$,1,1) \ IF T$<"1" THEN 25 \ IF T$>"5" THEN 25
41 REM	hlphead:.word	L1$	,block	,offset
42 REM		.word	L2$	,block	,offset
43 Y$=".word"+I$+"L"+STR$(B%)+"$"+I$+","+STR$(Z%)+"."+I$+","
44 Y$=Y$+STR$(Y%)+"."+I$+"; "+X$+L$+I$
45 PRINT #2,Y$; \ PRINT Y$;
47 B%=B%+1 \ GOTO 25
99 RESTORE #1 \ B%=1 \ Y$=".word"+I$+"0"+I$+I$+I$+"; null terminator"+L$
100 PRINT #2,Y$ \ PRINT Y$
120 IF END #1 THEN 199 \ LINPUT #1,X$ \ X%=LEN(X$)
130 Y%=Y%+X%+2 \ IF Y%<512 THEN 140 \ Y%=Y%-512 \ Z%=Z%+1
140 T$=SEG$(X$,1,1) \ IF T$<"1" THEN 120 \ IF T$>"5" THEN 120
141 REM L1$:	.asciz	"1 ?"
142 REM L2$:	.asciz	"1 @"
143 Y$="L"+STR$(B%)+"$:"+I$+".asciz"+I$+'"'+X$+'"'
145 PRINT #2,Y$ \ PRINT Y$
147 B%=B%+1 \ GOTO 120
199 X$=I$+".even"+L$+L$+I$+".end"
200 PRINT #2,X$ \ PRINT X$
299 CLOSE \ A=SYS(4)
301 DATA '	.ident	"V03.63"'
302 DATA ""
303 DATA "; /63/	27-Sep-97  Billy Youdelman  V03.63"
304 DATA ";"
305 DATA ";	moved this into a module of its own as KRTHLP was > 4096. words"
306 DATA ""
307 DATA ""
308 DATA "	.psect	$code	,ro,i,lcl,rel,con"
309 DATA "	.sbttl	Pass top of index back to caller"
310 DATA ""
311 DATA "loahlp::mov	#hlphead,r0		; calling this also loads this overlay"
312 DATA "	return"
313 DATA ""
314 DATA ""
315 DATA "	.psect	$pdata	,ro,d,lcl,rel,con"
316 DATA "	.sbttl	Fake RMS for help text file under RT-11"
317 DATA ""
318 DATA ';	Note here the "block" and "offset" point to the first line FOLLOWING'
319 DATA ";	the topic/subtopic line in the help text file (KRTHLP.HLP).  In other"
320 DATA ";	words, these data point to the first byte of the help text itself for"
321 DATA ";	the indicated topic or subtopic, which is directly AFTER the <cr><lf>"
322 DATA ";	tag on the topic/subtopic line."
323 DATA ""
