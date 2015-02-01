$ set noon
$
$! K11RSX.COM
$!
$! 27-Jan-86  09:56:03  Modified K11RSX.CMD to build FULL RSX Kermit-11
$! under RSTS/E v9.x
$!
$! Note: It is far better to use K11POS.TSK if you don't need DAP support
$! and you are running M+ or Micro-RSX
$!
$! Assume: LB: translation does NOT include the UIC [1,1]
$
$ if f$parse("LB:",,"PPN") .eqs. "[1,1]" then goto abort
$
$ cop/rep lb:[1,200]rmslib.p30 lb:[1,1]rmslib.olb
$ cop/rep lb:[1,200]syslib.p30 lb:[1,1]syslib.olb
$ cop/rep lb:[1,200]rmsdap.p30 lb:[1,1]rmsdap.olb
$ cop/rep [1,11]k11rsx.odl sy:[1,8]
$ cop/rep [1,11]k11dap.m41 sy:[1,8]
$ ass [1,1] lb
$ ass dv0: ov
$ xtkb
k11rsx/pr:0/cp/mm,k11rsx/-wi/-sp=k11rsx/mp
units=9
asg=sy:6:7:8:9
gbldef=tc.pth:146
gbldef=t.v131:30
gbldef=t.v132:31
gbldef=t.v2xx:35
gbldef=t.bmp1:35
gbldef=lncnt$:3
gbldef=tiunit:0
gbldef=dapsup:1
gbldef=$hbufs:2
;
;	to link with RMSRES, include 'reslib=lb:[1,1]rmsres/ro'
;	and edit the file K11RSX.ODL as indicated in the odl.
;
;;reslib = lb:[1,1]rmsres/ro
;
task=...ker
gbldef=maxsiz:300
gbldef=tiunit:0
gbldef=.priv:240

; since we use our own stack area we really don't need much
; at task build time

stack=64

//
$ cop/rep lb:[1,200]rmslib.olb lb:[1,1]
$ cop/rep lb:[1,200]syslib.olb lb:[1,1]
$ cop/rep lb:[1,200]rmsdap.olb lb:[1,1]
$abort:
$ exit
