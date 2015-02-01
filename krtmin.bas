1 L$=CHR$(13)+CHR$(10) \ I$=CHR$(9) \ B%=1 \ REM KRTMIN V03.62-5_min 31-May-93
2 OPEN "DK:KRTMIN.HLP" FOR INPUT AS FILE #1
3 OPEN "DK:KRTMIN.PRE" FOR INPUT AS FILE #3
4 OPEN "DK:KRTHLP.MIN" FOR OUTPUT AS FILE #2
5 LINPUT #3,X$ \ X$=I$+".title  KRTHLP.MIN"+I$+DAT$+"  "+CLK$ \ GOTO 7
6 IF END #3 THEN 10 \ LINPUT #3,X$
7 PRINT #2,X$ \ PRINT X$ \ GOTO 6
10 CLOSE #3 \ LINPUT #1,X$ \ X%=LEN(X$) \ Y%=Y%+X%+2
11 H$="hlphead:"
12 X$="hident:.asciz"+I$+"/"+X$+"/"+L$+I$+".even"+L$+L$+H$
19 PRINT #2,X$; \ PRINT X$;
20 IF END #1 THEN 99 \ LINPUT #1,X$
30 X%=LEN(X$) \ Y%=Y%+X%+2 \ IF Y%<512 THEN 40 \ Y%=Y%-512 \ Z%=Z%+1
40 T$=SEG$(X$,1,1) \ IF T$<"1" THEN 20 \ IF T$>"5" THEN 20
43 Y$=".word"+I$+"L"+STR$(B%)+"$"+I$+","+STR$(Z%)+"."+I$+","
44 Y$=Y$+STR$(Y%)+"."+L$+I$
45 PRINT #2,Y$; \ PRINT Y$;
47 B%=B%+1 \ GOTO 20
99 RESTORE #1 \ B%=1 \ Y$=".word"+I$+"0"+L$
100 PRINT #2,Y$ \ PRINT Y$
120 IF END #1 THEN 199 \ LINPUT #1,X$ \ X%=LEN(X$)
130 Y%=Y%+X%+2 \ IF Y%<512 THEN 140 \ Y%=Y%-512 \ Z%=Z%+1
140 T$=SEG$(X$,1,1) \ IF T$<"1" THEN 120 \ IF T$>"5" THEN 120
143 Y$="L"+STR$(B%)+"$:"+I$+".asciz"+I$+'"'+X$+'"'
145 PRINT #2,Y$ \ PRINT Y$
147 B%=B%+1 \ GOTO 120
199 X$=I$+".even"+L$+I$+".restore"+L$+L$+I$+".end"
200 PRINT #2,X$ \ PRINT X$
299 CLOSE \ A=SYS(4)
