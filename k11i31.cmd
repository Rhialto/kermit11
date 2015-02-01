k11ias/rw/mu,k11ias/-wi/-sp=k11ias/mp
units	=9
asg	=sy:6:7:8:9
;
;	to link with RMSRES, include 'reslib=lb:[1,1]rmsres/ro'
;	and edit the file K11RSX.ODL as indicated in the odl.
;
;;reslib = lb:[1,1]rmsres/ro
;
task	=$$$ker
gbldef	=tiunit:0
gbldef	=.priv:240
libr	=rmsres:ro

; since we use our own stack area we really don't need much
; at task build time

stack	=64

//
