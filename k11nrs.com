$ set noon
$ assign [1,8] in
$ assign dv0: ov
$ tkb
[1,8]k11nrs/pm,[1,8]k11nrs/-wi,[1,8]k11nrs=brian4:[1,8]k11nrs/mp
gbldef=lncnt$:3
gbldef=maxsiz:300
gbldef=.priv:240
gbldef=tf.wbt:100
gbldef=tc.pth:146
gbldef=$hbufs:2
//
$ run [1,2]maksil
[1,8]k11nrs







$tel br kermit task build done
$pip [1,8]k11nrs.tsk=[1,8]k11nrs.sil
$pip [1,8]k11nrs.sil/de
$exit


