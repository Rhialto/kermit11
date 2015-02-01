$ set noon
$
$! K11SML.COM  30-Dec-86  13:14:02
$!
$!  This creates a RSX11 Kermit without DAP and with a smaller RMS
$! overlay,  in response to users with 18bit RSX systems.  This is
$! 24KW rather than 28KW as K11RSX.TSK is (not much, but it helps)
$!
$! There will be one undefined symbol  $BFMT2   which is not a problem.
$!
$!
$! 27-Jan-86  09:56:03  Modified K11RSX.CMD to build FULL RSX Kermit-11
$! under RSTS/E v9.x
$!
$! 30-Dec-86  10:10:34  Created from k11rsx to make smaller tasks for 18
$! bit systems
$!
$!
$! Assume: LB: translation does NOT include the UIC [1,1]
$
$ if f$parse("LB:",,"PPN") .eqs. "[1,1]" then goto abort
$
$ cop/rep lb:[1,200]rmslib.p30 lb:[1,1]rmslib.olb
$ cop/rep lb:[1,200]syslib.p30 lb:[1,1]syslib.olb
$ cop/rep [1,11]k11sml.odl sy:[1,8]
$ ass [1,1] lb
$ ass dv0: ov
$ xtkb
k11sml/pr:0/cp/mm,k11sml/-wi/-sp=k11sml/mp
units=9
asg=sy:6:7:8:9
gbldef=lncnt$:3
gbldef=maxsiz:300
gbldef=tc.pth:146
gbldef=t.v131:30
gbldef=t.v132:31
gbldef=t.v2xx:35
gbldef=t.bmp1:35
gbldef=tiunit:0
gbldef=dapsup:0
gbldef=$hbufs:2
;
;	to link with RMSRES, include 'reslib=lb:[1,1]rmsres/ro'
;	and edit the file K11RSX.ODL as indicated in the odl.
;
;;reslib = lb:[1,1]rmsres/ro
;
task=...ker
gbldef=tiunit:0
gbldef=.priv:240

; since we use our own stack area we really don't need much
; at task build time

stack=64

//
$ cop/rep lb:[1,200]rmslib.olb lb:[1,1]
$ cop/rep lb:[1,200]syslib.olb lb:[1,1]
$abort:
$ exit
