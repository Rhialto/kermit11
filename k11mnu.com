$ ! RSTS version 9.0 Kermit account login command file
$ ! Note theat the account should have NOPASS and CAPTIVE
$ ! attributes.
$ set noon
$ write 0 ""
$ tel br kermit logged in
$ help:
$ set ter/vt100
$ write 0 ""
$ write 0 "This is a public Kermit account.  Currently, you can either"
$ write 0 "run Kermit to transfer files to you system, use TYPE to get"
$ write 0 "HEX  files,  DIR to look at this account,  XDIR to get  the"
$ write 0 "directory of online Kermit files, WHO to see system status,"
$ write 0 "LOG to logout, or TELL to talk to the systems manager. HELP"
$ write 0 "will reprint this message"
$ write 0 "All Kermit files OTHER than Kermit-11 are in KERMIT:.  The"
$ write 0 "Kermit-11 sources and hex files are in PDPKER$SRC: and the"
$ write 0 "executable files are in PDPKER$EXE:"
$ write 0 ""
$ write 0 "Files of interest for PDP-11's"
$ write 0 ""
$ write 0 "RSTS/E    PDPKER$EXE:K11.TSK    , PDPKER$EXE:K11NRS.TSK"
$ write 0 "RT11      PDPKER$EXE:K11XM.SAV  , PDPKER$EXE:K11RT4.SAV"
$ write 0 "P/OS      PDPKER$EXE:K11POS.TSK , KERMIT:PRO???.*"
$ write 0 "RSX       PDPKER$EXE:K11RSX.TSK"
$ write 0 "PRO/RT11  PDPKER$EXE:K11XM.SAV"
$ write 0 "General   PDPKER$SRC:K11INS.DOC,K11HEX.FTN,K11HEX.BAS,K11HEX.MAC"
$ write 0 "          PDPKER$SRC:K11HLP.HLP,K11CMD.MAC"
$ write 0 "Rainbow   KERMIT:MS????.*, KERMIT:86????.*"
$ write 0 ""
$ loop:
$ set data
$ on control_c then goto endloop
$ inquire/nopun junk "Ker[mit],Help,Type,Dir,Xdir,Who,LOG or TELL ? "
$ write 0 ""
$ junk = f$edit(junk,255)
$ if junk .eqs. "" then goto endloop
$ set nodata
$ if f$instr(1,junk,"XDI") .eq. 1 then TYP 1:[4,0]KERMIT.DIR
$ if f$instr(1,junk,"HEL") .eq. 1 then goto help
$ if f$instr(1,junk,"EXI") .eq. 1 then goto exit
$ if f$instr(1,junk,"KER") .ne. 1 then goto notker
$ write 0 ""
$ write 0 "This  is  Kermit-11  running  on  RSTS/E.  The most useful mode of"
$ write 0 "operation is to run Kermit-11 as a server, which is done  via  the"
$ write 0 "SERVER  command.  Once  you  type SER to Kermit-11, escape back to"
$ write 0 "your local system and use the GET command to get a file  from  the"
$ write 0 "PDP  11/70  here,  or  use the SEND command to send a file to this"
$ write 0 "system. Other commands, such  as  REMOTE  DIR,  are  supported  by"
$ write 0 "Kermit-11  but  may  not be supported by your local system. Please"
$ write 0 "note  that  RSTS/E  uses  ?  instead  of  %  for  single  wildcard"
$ write 0 "character  matching,  and  the  *  is  used  to wildcard an entire"
$ write 0 "filename or filetype.  RSTS Kermit will convert % to ? for the GET"
$ write 0 "command and the REM DIR command."
$ write 0 ""
$ ker
$ goto endloop
$ notker:
$ if f$instr(1,junk,"LOG") .eq. 1 then LOG
$ if f$instr(1,junk,"WHO") .eq. 1 then SY
$ if f$instr(1,junk,"DIR") .eq. 1 then DIR
$ if f$instr(1,junk,"TYP") .eq. 1 then TYP
$ if f$instr(1,junk,"TEL") .ne. 1 then goto endloop
$ write 0 "To talk to BRIAN, type BR your message in response to the TELL>"
$ write 0 "To return to the menu, type a control Z"
$ TEL
$ endloop:
$ goto loop
$ exit:
$ exit
