$ assign [1,13] rt
$
$ ! 09-Nov-84  15:48:57
$ ! This command file runs under DCL on RSTS/E T9.0
$ ! To link, insure you have a SYSLIB.OBJ from RTV5
$ ! in your account so the linker can get the over-
$ ! lay handler for virtual overlays.
$ !
$ ! Edits: 08-May-85  18:43:49 BDN	Remove SWI RT11 due to bug in FT update
$ !        18-Jan-86  07:16:09 BDN	Reduce XM size due to botting on VM:
$ !	   04-Feb-86  14:55:02 BDN	Redude XM size again
$ !	   07-Jun-86  18:15:10 BDN	Many changes for running in FG
$ !
$ ! If you must reduce the physical memory required for the virtual overlays
$ ! you can edit this to place :1 after every region, this would force  LINK
$ ! to generate an image much like disk overlays;  each segment  in a region
$ ! would have to swap. That's a bit extreme, but if need be ....
$ !
$ ! i.e. Change all  /v:4:n   To   /v:4:1
$ !
$ ! This overlay will squeeze into 24KW of XM
$ !
$ ! To increase the handler space available, alter the value for the /E:nnnn
$ ! switch
$ !
$ run [1,2]link
k11xm,k11xm=rt:k11xm,rt:k11dat/t/e:2700//
rt:k11rt4
rt:k11pak/v:1
rt:k11cmd
rt:k11rtt/v:2
rt:k11tsx
rt:k11prt
rt:k11sub
rt:k11dsp
rt:k11rti/v:3:1
rt:k11cm1
rt:k11sen/v:3:1
rt:k11rec/v:3:1
rt:k11rco/v:4
rt:k11dia/v:4
rt:k11st0/v:4:1
rt:k11st1/v:4:1
rt:k11sho/v:4:1
rt:k11hlp/v:4:1
rt:k11ser/v:4:1
rt:k11tra/v:4:1
rt:k11deb/v:4:1
rt:k11cvt/v:5
rt:k11atr/v:5
rt:k11ini
rt:k11rtu/v:5
rt:k11rtd/v:5
rt:k11edi/v:5
rt:k11com/v:5:1
rt:k11std/v:5:1
rt:k11rte/v:5:1
rt:k11dfh/v:5:1
//
xmstar
hnbuff
$ exit
