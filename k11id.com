
$!	I/D space and RSTS

$ set noon
$ assign [1,8] in
$ assign dv0:[1,8] ov
$ tkb
[1,8]k11id/id/pm,[1,8]k11id/-wi=brian4:[1,8]k11id/mp
;
;Change default dialer timeout:
;
; gblpat=k11dia:..diat:nnn
;

reslib = lb:rmsres/ro
gbldef=maxsiz:1000
gbldef=lncnt$:12
gblref=usermd
gbldef=.priv:240
gbldef=tf.wbt:100
gbldef=tc.pth:146
gbldef=$hbufs:10
//

$tel br kermit task build done
$exit


