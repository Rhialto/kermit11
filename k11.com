$ set noon
$ assign [1,8] in
$ assign dv0:[1,8] ov
$ tkb
[1,8]k11/pm,[1,8]k11/-wi,[1,8]k11=brian4:[1,8]k11/mp
;
;Change default dialer timeout:
;
; gblpat=k11dia:..diat:nnn
;

reslib = lb:rmsres/ro
gbldef=lncnt$:3
gbldef=maxsiz:300
gblref=usermd
gbldef=.priv:240
gbldef=tf.wbt:100
gbldef=tc.pth:146
gbldef=$hbufs:2
//
$ run [1,2]maksil
[1,8]k11







$tel br kermit task build done
$pip [1,8]k11.tsk=[1,8]k11.sil
$pip [1,8]k11.sil/de
$exit


