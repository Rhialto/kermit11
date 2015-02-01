!  27-Sep-97	Link KRT V03.63 for RT-11XM or TSX-Plus
!		using extended memory overlays
r link
!				APR0, the root   extending HNBUFF
krttsx,krttsx=krtxm/t/e:3010//
!				APR1,APR2,APR3 = things that must stay loaded
krtdat/v:1
krtrms
krtpak
krtcmd
krterm
krtxl
krtsub
krtdsp
!				pad to end of APR1,APR2,APR3 segment..
krterr
!				APR4
krtsen/v:2
krtrec/v:2:1
krthlp/v:2:2
!				one shot init
krtosi/v:2:3
!				then overlay this
krtcm1/v:2:3
!				APR5
krtdia/v:3
krtst0/v:3:1
krtxmo
krtst1/v:3:2
krtcon
krttra
krtsho/v:3:3
krtser/v:3:4
krtdeb
krtidx/v:3:5
!				APR6
krtcvt/v:4
krtatr
krtini
krtutl/v:4:1
krtdir
krtedi/v:4:2
krtcom
krtstd
krtmdm/v:4:3
!				APR7 mapped by KRTOSI
//
xmstart
hnbuff
^C
