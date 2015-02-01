$ set ver
$ set def sys$sysroot:[brian.k11]
$ conv/fdl=sys$login:fixed_nocarriage k11.tsk k11.tsk
$ conv/fdl=sys$login:fixed_nocarriage k11nrs.tsk k11nrs.tsk
$ conv/fdl=sys$login:fixed_nocarriage k11pos.tsk k11pos.tsk
$ conv/fdl=sys$login:fixed_nocarriage k11rsx.tsk k11rsx.tsk
$ conv/fdl=sys$login:fixed_nocarriage k11xm.sav k11xm.sav
$ conv/fdl=sys$login:fixed_nocarriage k11rt4.sav k11rt4.sav
$ dif k11.tsk;1 k11.tsk;2
$ set nover
