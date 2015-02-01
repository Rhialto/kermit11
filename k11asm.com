$ ! k11asm.com
$ ! simple rsts v9 dcl com file to assemble individual k11 modules
$ ! also, decide to use macro.sav or mac.tsk as macro.sav is 2 to 3
$ ! times faster than MAC
$ !
$ cmd = "MACRO"
$ if p1 .eqs. "K11MCO" .or. p1 .eqs. "k11cmo" then cmd = "MAC"
$ if p1 .eqs. "K11PCO" .or. p1 .eqs. "k11pco" then cmd = "MAC"
$ if p1 .eqs. "K11CPY" .or. p1 .eqs. "k11cpy" then cmd = "MAC"
$ if p1 .eqs. "K11RMS" .or. p1 .eqs. "k11rms" then cmd = "MAC"
$ if p1 .eqs. "K11RMZ" .or. p1 .eqs. "k11rmz" then cmd = "MAC"
$ if p1 .eqs. "K11RXY" .or. p1 .eqs. "k11rxy" then cmd = "MAC"
$ if p1 .eqs. "K11M41" .or. p1 .eqs. "k11m41" then cmd = "MAC"
$ open/rep/write 1 'p1'.COM
$ write 1 "$"
$ write 1 "$ set noon"
$ write 1 "$ ass [1,11] in"
$ write 1 "$ ccl ''cmd' ''p1'=in:''p1'"
$ close 1
$ sub 'p1'.COM
