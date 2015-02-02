k11idm/id/mm/mu/cp/pr:0,k11idm/-sp=k11idm/mp
ident=t3.64
task=...ker
;k11idm/id/mm/mu/cp/pr:0/da=k11idm/mp
;libr = rmsres:ro
ressup = lb:[3,54]rmsres/sv:0
;clstr=rmsres,dapres:ro
units=10
asg=sy:6:7:8:9:10
gbldef=lncnt$:12
gbldef=maxsiz:1000
gbldef=t.v131:30
gbldef=t.v132:31
gbldef=t.v2xx:36
gbldef=t.bmp1:35
gbldef=tiunit:0
gbldef=tc.pth:146
gbldef=dapsup:0
gbldef=$hbufs:10
;
; To change the maximum text record buffer size (only do this on I/D)
;
; GBLDEF=MAXSIZ:nnnn
;
;
; To change the dialer timeout value:
; GBLPAT=K11DIA:..DIAT:45
; 
; If you want to avoid the M+ v3/MicroRsx v3 Kermit logical name translation
; for KERMIT$LINEn , then include the following:
; GBLPAT=K11PAK:DO$TRA:0
;
; else:
; GBLPAT=K11PAK:DO$TRA:1	; the default
;
; If you want to reduce the message printing (as in SET QUIET)
; then:
; GBLPAT=K11PAK:DO$MSG:0
; else
; GBLPAT=K11PAK:DO$MSG:1	; the default
;
; If you want logfiles to be appended to instead of created each time
; then:
; GBLPAT=K11PAK:DO$APP:1
; else:
; GBLPAT=K11PAK:DO$APP:0	; the default
;
; If, for whatever reason, you don't want version number printed at
; program startup,
; then:
; GBLPAT=K11PAK:DO$VER:0
;
;
; If you want kermit to NOT exit at end of file from the invocation
; as in: ker @dial
; (which is can set in the com file via SET EOF NOEXIT)
; then:
; GBLPAT=K11PAK:DO$EXI:0
;
; If you want to force SET RSX CON ALT,
; then:
GBLPAT=K11PAK:DO$ALT:1
;
;
; If you want to force the use of PRO/COMM (DTE) for P/OS instead
; of the internal connect code, then:
;
; GBLPAT=K11PAK:DO$DTE:1
;
; to use the default of the internal code (in case K11M41.MAC has been
; altered)
;
; GBLPAT=K11PAK:DO$DTE:0
;
;
; since we use our own stack area we really don't need much
; at task build time

stack=64

//
