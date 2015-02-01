k11rsx/pr:0/cp/mm,k11rsx/-wi/-sp=k11rsx/mp
units=9
asg=sy:6:7:8:9
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
