$ set noon
$ ! create kermit-11 hex files under rsts/e t9.0-09
$
$ assign [1,11] in
$ set noon
$ run in:k11hex
in:k11rt4.sav
k11rt4.hex
en
$
$ run in:k11hex
in:k11xm.sav
k11xm.hex
en
$
$ pip [1,11]=*.hex/rms
$exit
