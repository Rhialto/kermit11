!	RSTS/E Kermit optional patches
!
!	Brian Nelson  30-Mar-84  09:47:07
!
!
!	 Example of patching RSTS/E Kermit to disable commands based
!	on user programmer  number.  The  effect  of  the  following
!	patches  is  to  disallow  any user with a programmer number
!	greater than  127  (ie,  100,221)  to  access  the  commands
!	DELETE  ,DIRECTORY,  ERASE  and RENAME. If you would like to
!	do this based  on  project  number  instead  you  can  patch
!	either  ...UIC+0  to  be  the  high  cutoff point instead of
!	patching ...UIC+2, or you can use different project  numbers
!	for  each  command by changing the '377' (which is in octal)
!	to the desired cutoff point. To restict access  to  the  DIR
!	command  to  users  with  a project (group) number less than
!	(10,*), you would patch ..$DIR byte offset zero  from  0  to
!	10.  (the  '.'  is  needed  to force ONLPAT to use a decimal
!	interpretation of the number. 
!
!	 At this  time the only other thing you may want to patch is
!	location ..DIRP offset  zero, which  is by  default 1.  This
!	value is checked  against  the user's project  number by the
!	DIRECTORY command.  If the user's project  number is greater
!	than  this number,  the ppn (uic) field  for the DIR command
!	is zeroed,  thus  preventing that  user from looking  at the
!	directory listing  of ANY other  account.  The default is to
!	restrict the use  of ppn's for this  command to  [1,*] users
!	only.  The last patch here changes that to include [2,*].
!
!
! Keep user's with programmer numbers > 127 from using DIR, DEL, REN and ERA.
!
!
File to patch? 
Base address? ...UIC+2
Offset address? 0
 Base	Offset  Old     New?
??????	000000	000000	? 127.
??????	000002	041000	? ^Z
Offset address? ^Z
Base address? ..$DEL
Offset address? -1
 Base	Offset  Old     New?
??????	177777	   120	? <LF>
??????	000000	   000	? 377
??????	000001	   104	? ^Z
Offset address? ^Z
Base address? ..$DIR
Offset address? -1
 Base	Offset  Old     New?
??????	177777	   114	? <LF>
??????	000000	   000	? 377
??????	000001	   104	? ^Z
Offset address? ^Z
Base address? ..$ERA
Offset address? -1
 Base	Offset  Old     New?
??????	177777	   123	? <LF>
??????	000000	   000	? 377
??????	000001	   105	? ^Z
Offset address? ^Z
Base address? ..$REN
Offset address? -1
 Base	Offset  Old     New?
??????	177777	   115	? <LF>
??????	000000	   000	? 377
??????	000001	   122	? ^Z
Offset address? ^Z
Base address? ..DIRP
Offset address? 0
 Base	Offset  Old     New?
??????	000000	000001	? 2
??????	000002	??????	? ^Z
Offset address? ^Z
Base address? SLOWDO
Offset address? 0
 Base	Offset  Old     New?
??????	000000	000000	? 1
??????	000002	??????	? ^C
