@Section(Installation and Release Notes)
@Index(release notes) @Index(installation)

This is release 3.51 of Kermit-11.  Major changes from previous versions
include  LONG  PACKET support, new CONNECT code for RSX-11M/M+ and P/OS,
BREAK and DTR control for RT-11 V5.2, a DIAL  command,  and  many  other
small   changes.    All  changes  are  documented  in  the  source  file
K11CMD.MAC.  Specific to  3.51  are  numerous  RT11  and  TSX+  changes,
including running Kermit as a foreground task on the PRO/350.

Kermit-11 runs on the following operating systems.
@Begin(Format)

Exec    Minimum         Notes
        version

RSTS/E  v8.0    Multiple private delimiter SYSGEN support, RMS11 v2
RSX-11M v4.1    Full duplex terminal driver, RMS11 v2
RSX-11M+        v2.1    Full duplex terminal driver, RMS11 v2
RT-11   v4.0    Requires multiple terminal SYSGEN support
RT-11   v5.1    Can use the XL and XC handlers or MT service
TSX+    v5      Must use CL handler for outgoing connections
PRO/RT  v5.1    Uses the XC handler
P/OS    v2.0    Uses either XK or XT (XT for TMS support)
IAS     v3.1    Built with RMS v1, will function on 3.2 patch A and B
@End(Format)

If your system version is older than that listed you are free to see  if
Kermit will run; if it does not, UPGRADE.  Kermit is fairly generous, it
runs on both the current  executive  versions  plus  generally  contains
support  for the last major release.  In other words, if you are running
RSTS v7 or RSX-11M 3.2, you will not be supported for  Kermit,  just  as
your  system  can  not be supported by Digital.  For example, RSTS/E 8.0
support expired on 31-Dec-85, as version 9.0 was released in June  1985.
Since  version  8  was the last major version, Kermit-11 will ATTEMPT to
support it for a while; verification of 8.0 functionality  is  difficult
as  the author is a field test site and has not used 8.0 since SEP 1984,
and is currently running RSTS/E 9.2.

The creation of Kermit-11 from source is possible only  on  the  current
versions  of  the above mentioned systems; this is due to the use of new
macro calls and directives that may not be present  on  older  versions.
For  example,  Kermit-11  can  be  built  under RSTS/E for all the other
executives as long as the RSTS/E version is 9.1 or later,  and  one  has
the  appropriate  system  specific libraries (such as SYSLIB, RMSLIB and
RMSDAP from RSX-11M+).  Before attempting to build from source, see  the
section  later  in  this  document  for  specific notes relating to your
system.   You  should  not  need  to  build  Kermit  from  source;  your
distribution  will  have  either  the relevant executable image or 'hex'
files that can be converted into something that will run.

As of this writing (04-Feb-86), the current versions are:

@Begin(Format)
        RSTS/E   9.1, 9.2       RSX-11M 4.2
        RSX-11M+ 3.0            RT-11   5.2
        TSX+     6.02           P/OS    2.0, 3.0 soon to be released
        IAS      3.2, Patch B
@End(Format)

@SubSection(Kermit-11 Restrictions)
@Index(restrictions)

A problem was found with versions of Kermit-11 prior to  3.49  regarding
the  sending and processing of attribute packets.  Basically, two of the
attribute types were improperly implemented.  The support for  attribute
packets  was  added  back  in April 1984, at a time when testing against
other implementations was not possible.  At this writing, in March 1986,
some problems have been found.

The corrected version of Kermit-11 is V3.49; this version  will  NOT  be
able  to exchange attribute packets with previous versions.  In order to
make an intitial download of Kermit-11 V3.49 to a host running an  older
version, you must explicitly disable attribute support, as in:

@Begin(Format)
        Kermit-11>SET NOATT
@End(Format)

and then force both ends to binary mode, as in:

@Begin(Format)
        Kermit-11>SET FILE BINARY
   or   Kermit-11>SET FILE TYPE FIXED
@End(Format)

The best way to accomplish the updating of remote sites is to use a  pre
3.49 version of Kermit-11 at both ends, transfer the image appropiate to
your system, and then replace the old executable  image  on  the  remote
side and your own side.

@SubSection(Installation of Kermit-11 on RSTS/E)
@Index(RSTS/E installation)

The minimum version of RSTS/E  must  be  8.0  or  later  for  Kermit  to
function  correctly.   Kermit will run on version 7.2, but there will be
random problems with file access.  This is  due  to  the  use  of  RMS11
version  2  in  Kermit-11  for  all  file  activity; version 7 of RSTS/E
supports only RMS version 1.8.

Kermit's use of RMS11 costs you NOTHING.  You have the option  of  using
an image that contains RMS in disk overlays (K11NRS.TSK), or you can use
one  that's  linked  to  the  segmented  RMS  resident  library,  RMSRES
(K11.TSK).   The pros and cons of using RMS will not be discussed; there
aren't any valid reasons NOT to use it.

Be sure that the SYSGEN question relating to multiple private delimiters
was answered YES, otherwise Kermit will tell you it can't run without it
as soon as you attempt a file transfer.  Multiple delimiter  masks  cost
you  one word in executive data space to be used as a pointer to a small
buffer containing the delimiter mask; the small buffer is not  allocated
until Kermit requests the monitor to do so.

@Heading(Tape Distribution)
@index(tape distribution)

There are many different possibilities here.  You  may  have  an  ANSI-D
tape  from Columbia, a backup tape from a friend, a DOS format tape from
DECUS, or even RX50's for a Micro-11 system.  All following examples are
done under RSTS/E version 9.0 or later.

(1) DOS format Kermit-11 tape

@Begin(Format)
        $ MOU MM0:/FOR=DOS
        $ PIP MM0:[*,*]*.*/L:S
        $ PIP SY:[1,2]=MM0:[*,*]K11.TSK
        $ PIP SY:[1,2]=MM0:[*,*]K11HLP.HLP
        $ PIP SY:[1,2]=MM0:[*,*]K11USR.DOC
        $ SET FILE [1,2]K11.TSK/RUN=RSX/PRO=104
        $ SET FILE [1,2]K11HLP.HLP/PRO=40
        $ DEFINE/COMMAND/SYSTEM KER-MIT [1,2]K11.TSK/LINE=30000
@End(Format)

The above commands did the following:

@Begin(Format)
        (1) Insure the tape label format is DOS-11
        (2) Get a directory to make sure the files are really there
        (3) Copy the executable task image (linked to RMSRES)
        (4) Copy the online help file
        (5) Copy the Kermit-11 users guide
        (6) Set protection and runtime system name
        (7) Create a CCL definition for Kermit to be invoked with
@End(Format)

(2) Ansi D format tape from Columbia

@Begin(Format)
        $ MOU MM0:/FOR=ANS KERMIT       ! RSTS/E 9.0 or 9.1
        $ MOU MM0:/OV=ID                ! RSTS/E 9.2 or later
        $ PIP SY:=MM0:K11.HEX
        $ PIP SY:=MM0:K11HEX.BAS
	$ PIP SY:=K11.HEX/RMS
	$ PIP SY:=K11HEX.BAS/RMS
        $ PIP SY:[1,2]=MM0:K11HLP.HLP
        $ PIP SY:[1,2]=MM0:K11USR.DOC
        $ BASIC
        old k11hex
        run
        K11HEX- Decode Kermit-11 Hex files (RSTS/E Basic+)
        Input Hex file ? K11.HEX
        Output Task image? K11.TSK
        $
        $ COP/REP K11.TSK [1,2]
        $ SET FILE [1,2]K11.TSK/RUN=RSX/PRO=104
        $ SET FILE [1,2]K11HLP.HLP/PRO=40
        $ DEFINE/COMMAND/SYSTEM KER-MIT [1,2]K11.TSK/LINE=30000
@End(Format)

Again, the sequence of operations is:

@Begin(Format)
        (1) Insure current tape labeling is ANSI
        (2) Copy a hexified version of the task image
        (3) Copy a simple Basic+ program to create the task image
        (4) Copy online help file and user documentation
        (5) Switch to Basic+
        (6) Run the K11HEX program, creating a task image
        (7) Copy the task image to [1,2]
        (8) Set runtime system, protection and ccl command.
@End(Format)

If the tape label for an ANSI tape is unknown, you can switch to  Basic+
or  RSX  keyboard  monitors and do an ASSIGN MM0:.ANSI as the RSTS/E DCL
Mount command lacks an override switch for  volume  identification.   If
the  DCL  command BASIC fails, try the ccl command SY/R to find out what
Basic is called, and  then  try  a  SWITCH  nnnnnn  ccl  command,  where
'nnnnnn'  is  the  Basic+ run time system name.  For example, the author
always uses BAS4F for the basic run time system  (to  designate  4  word
FP11/KEF11  support),  and  the DCL symbol BASIC is defined as BASIC :==
CCL SWI BAS4F.

If PIP gives you an error message regarding insufficient  buffer  space,
redefine  the CCL command definition for PIP to extend PIP to 28KW; this
is done by specifying a line number in the form 8192+size(KW).

(3) RX50 or RX01 floppy diskettes

The DECUS Library Micro-RSTS distribution is  on  RT-11  formatted  RX50
diskettes;   the   Decus   Library   (Decus   number  11-731)  alternate
distribution media on RX01's is also a set  of  RT-11  formatted  floppy
diskettes.   These are readable on RSTS/E with the program FIT, supplied
with your system.  If you have RSTS/E  Kermit  on  floppies,  the  first
thing  to  do  is  to get directory listings of all the diskettes so you
know which floppy to use for a given file.  The following example is the
general method:

@Begin(Format)
        $ RUN AUXLIB$:FIT
        FIT    V9.0-14 RSTS V9.0-14 U of Toledo 44
        FIT>SY:=DX0:*.*
        FIT>SY:=DX0:*.*
        FIT>^Z
        $ COP/REP K11HLP.HLP [1,2]
        $ COP/REP K11.TSK [1,2]
        $ SET FILE [1,2]K11.TSK/RUN=RSX/PRO=104
        $ SET FILE [1,2]K11HLP.HLP/PRO=40
        $ DEFINE/COMMAND/SYSTEM KER-MIT [1,2]K11.TSK/LINE=30000
@End(Format)

Since there are only two  or  three  floppy  diskettes  involved  it  is
convenient  to copy all the diskettes to your account, and then move the
needed files to their final destination.  In the above  example,  it  is
assumed  that a different diskette was placed into DX0 before the second
file transfer command was issued.  In the case of  RX50  diskettes,  the
input  device  name  would be DUn, where 'N' is the number of winchester
drives (hard disks) on your system.  For example, if you have  one  RD52
on your system, then floppy drive zero is called DU1:.

In summary, you want to copy K11.TSK  from  the  media  and  install  it
somewhere  with  world  read+execute  access and preferably define a CCL
command for it.  Dialup access is documented at the end of this file for
obtaining newer Kermit-11 versions.

@SubSection(Installing Kermit-11 on RT-11 and TSX+)

@Heading(RT-11)
@Index(RT-11)

Kermit-11, as used under RT-11, supports the use  of  multiple  terminal
service,  the  XC  and  XL handlers found on version 5 of RT-11, and, in
extreme cases, the use of the console line for connecting TO  the  RT-11
system.

The first option, the use  of  Multiple  Terminal  support,  requires  a
SYSGEN if this feature is not configured.  Serial lines in this case are
designated by numbers; the console is always line zero, the  next  line,
say  a  DLV11E, may be line one.  These line numbers are assigned during
SYSGEN based upon the order of  entry  during  SYSGEN  (under  5.2,  the
questions  start  with question number 180).  You can also use a DZ11 or
DZV11.  The actual assignments may be viewed on a  running  system  with
the DCL command SHO TER.

The best solution is to use the XL driver (XC on  PRO/RT-11),  available
on  RT-11  version  5.1  and  5.2.   This  is  a  driver that makes very
efficient use of a DLV11 compatible interface;  it's  the  same  handler
that is used by VTCOM.  To use it, you must have, just like for multiple
terminal support, an extra  DL11/DLV11  interface  in  addition  to  the
console interface.  The XL handler supports two DCL commands:

@Begin(Format)
        SET XL CSR=n
        SET XL VECTOR=m
@End(Format)

Where 'N' is the address of the CSR (control status register) and 'M' is
the  interrupt vector address.  The defaults are 176500 for the CSR, and
300 for the interrupt vector.
The XC handler, used ONLY on the PRO/300 series, has it's CSR and vector
fixed  at  173300  and 210 respectively.  Kermit-11, upon finding itself
running on a PRO/3xx under RT-11, does an implicit SET LIN XC:.  The DCL
command  SET  XC SPEED=N must be used outside of Kermit to change the XC
line speed from the default of 1200 baud.

Last, but not least, if there is no way to get an  additional  interface
into  your system (perhaps you have a four slot QBUS backplane), you can
force Kermit to use the console.  This implies, of course, that it  will
not  be  possible to dial out from the RT-11 system; the system could be
used only for a remote Kermit to connect to it via the console port.  If
Kermit  finds  that  the  XL  handler  is not present, and that multiple
terminal service is absent, it  will  force  the  use  of  the  console.
Otherwise, the command:

@Begin(Format)
        Kermit-11>SET LINE TT:
@End(Format)

will force the console to be used.

In summary, the following commands (in order) specify serial  lines  for
Kermit-11:
        
@Begin(Format)
        Kermit-11>SET LINE 1            use terminal line one
        Kermit-11>SET LIN XL            use the XL handler
        Kermit-11>SET LIN TT:           force use of the console line
@End(Format)

Kermit-11 also requires the presence of timer support in the  executive.
This  is  required  to  support  the .TWAIT directive; FB and XM systems
always have support for this; SJ systems by default do not.   If  Kermit
decides  that  it  does not have a clock, which it would think if .TWAIT
support is missing, it will try to fake .TWAIT's with cpu  bound  loops.
The  best  thing is to insure that you have a FB or XM monitor available
for use with Kermit.

@Heading(TSX+)
@Index(TSX+)

Kermit-11 is used on TSX+ (a product of S&H Computing) as both  a  LOCAL
Kermit  (you  connect  out to another system using the CL handler) and a
REMOTE Kermit  (you  log  into  a  TSX+  system  and  run  Kermit-11  to
communicate  with your local Kermit system).  The second is identical to
Kermit use on most multiuser systems (for example, TOPS-20 and  RSTS/E),
while  the  former  is  similar  to  Kermit  use on RT-11 with the XL/XC
handler.  In order to CONNECT out from TSX Kermit to another system, you
need  to associate the appropriate CL line with the logical name XL, or,
if you are running Kermit-11 2.44 or later and have 8 CL lines or  less,
you can directly specify the CL unit number:

@Begin(Format)
        .SET CLn LINE=4
        .SET CL NOLFOUT
        .ASS CLn XL
        .KERMIT
        Kermit-11>SET LIN XL
        Kermit-11>CONNECT

   or

        Kermit-11>SET LIN CLn
@End(Format)

where 'N' is the CL unit number, or just CL for  CL0:.   Please  consult
the Kermit-11 User's Guide for further information regarding serial line
support.

The image K11XM.SAV will use approximately 100 blocks of  PLAS  swapfile
space;  if  that is excessive, or if Kermit fails to load, then the disk
overlayed image K11RT4.SAV may  be  used.   Alternately,  the  TSGEN.MAC
parameter  SEGBLK  may  be too small to contain K11XM's virtual overlay;
the TSX+ system manager will need to increase SEGBLK and reboot TSX+.

@Heading(Installation Procedure)
@Index(TSX+ installation)

As in the case of RSTS/E, there are so many media formats  that  may  be
used  for Kermit that we must restrict the discussion to the more likely
media.  First of all, the files of interest are:

@Begin(Format)
        K11XM.SAV       For use on RT-11 XM, PRO/RT-11 and TSX+
        K11RT4.SAV      For use on RT-11 SJ and FB, also usable on TSX+
        K11HLP.HLP      The online help file
        K11USR.DOC      The user's guide
@End(Format)

The most common media that RT-11 and TSX+ users may get Kermit-11 is  on
8  inch  RX01  diskettes  and  5  1/4 inch RX50 floppies.  Both examples
reference RX50 devices, the use of RX01  and  RX02  disks  is  the  same
except  that  a  RX01  (RX11-BA and RXV11-BA) drive is called DX and the
RX02 drive is called DY.  Additionally, the eight inch floppies  have  a
lower  capacity  than  an RX50, thus Kermit-11 files may be split across
two or more diskettes.  The RX50 drives are known as DZ0:  and DZ1:   on
the  PRO/350,  and  they  are  known  as DUn:  and DUn+1:  on other QBUS
processors, when N is the number of fixed drives (RD50,51 and  52).   If
your  system  is NOT a PRO/3xx series systems, you would need to replace
the references to DZn:   with  the  appropiate  DU  device  names.   For
example,  if you have one RD52 winchester drive and two RX50 units, then
the first RX50 would be DU1:  and the  second  DU2:.   The  RC25  is  an
exception;  if your system had one RC25 and an RX50, then the first RX50
would be called DU4:.  If your system  contained  no  MSCP  disk  drives
other than the RX50, then the units would be DU0:  and DU1:.

(1) RT-11 5.2 and PRO/350, files on RX50 media

@Begin(Format)
        .COPY DZ0:K11XM.SAV DK:KERMIT.SAV
        .COPY DZ0:K11HLP.HLP DK:
        .COPY DZ0:K11USR.DOC DK:
        .SET XC SPEED=9600
        .KERMIT
        Kermit-11 T3.44 Last Edit: 04-Feb-86
        PRO/350 comm port set to XC0:
        Kermit-11>EXIT
@End(Format)

Since this was a PRO/350, we must use the  K11XM.SAV  executable  image,
since  only RT-11XM will run on the PRO.  Had this been a PDP-11 running
RT-11 SJ or RT-11 FB, we would  have  copied  K11RT4.SAV  to  KERMIT.SAV
rather  than  K11XM.  Note that on the PRO/350 you may have to UNLOAD XC
before Kermit-11 can be started via a .FRUN command.  Addtionally,  when
running in the foreground, you will likely want to give the command:

@Begin(Format)
        .FRUN K11XM.SAV
        ......
        ^F
        Kermit-11>SET QUIET
@End(Format)

(2) RT-11 5.2 FB and LSI-11/23

@Begin(Format)
        .COPY DU1:K11RT4.SAV DK:KERMIT.SAV
        .COPY DU1:K11HLP.HLP DK:
        .COPY DU1:K11USR.DOC DK:
        .SET XL CSR=176510
        .SET XL VEC=310
        .KERMIT
        Kermit-11 T3.44 Last Edit: 04-Feb-86
        Kermit-11>SET LIN XL:
@End(Format)

In this case, we had one winchester fixed disk  drive,  DU0:,  thus  the
RX50  units are called DU1:  and DU2:  We also have a DLV11 at a CSR and
VECTOR of 176510 and 310, respectively, which differs from  the  default
176500  and  300.   Since  the  DLV11's  speed is set via onboard switch
packs, the DCL command SET XL SPEED command is not usable.

(3) RT-11 without the Kermit save image

@Begin(Format)
        .COPY DU1:K11XM.HEX DK:
        .COPY DU1:K11HEX.MAC DK:
        .R MACRO
        *K11HEX=K11HEX
        *^C
        .R LINK
        *K11HEX=K11HEX
        *^C
        .RUN K11HEX
        *K11XM=K11XM
        .RUN K11XM
        Kermit T3.44 Last edit: 04-Feb-86
        Kermit-11>EXIT
        .
@End(Format)

In this case, it is  assumed  that  we  have  the  files  K11XM.HEX  (or
K11RT4.HEX)  and  K11HEX.MAC, perhaps obtained from a remote system with
VTCOM.  After copying the two files we assembled and linked  the  K11HEX
program.   The  K11HEX  program  is  then run to create the desired save
image.  Keep in mind that K11XM is for TSX+, RT-11 XM and  the  PRO/350,
whereas  K11RT4 is for SJ and FB systems.  Again, the disk configuration
was one MSCP winchester disk (a RD50, RD51 or RD52) and two RX50 units.

In the event that you are using multiple terminal support, you could use
a command of the form:

@Begin(Format)
        .SHO TER
        Unit  Owner      Type      Width  Tab  CRLF  FORM  SCOPE  SPEED
        0            S-Console DL   132   No   Yes    No    No    N/A
        1            Remote    DL    80   Yes  Yes    No    No    N/A

        .KERMIT
        Kermit-11 T3.44 Last Edit: 04-Feb-86
        Kermit-11>SET LINE 1
@End(Format)

otherwise use the XL (XC for the PRO) handler.  The XL handler  must  be
previously  installed; it does not have to be loaded.  Kermit will fetch
the handler if it is not resident.

@Begin(Format)
        .INS XL
        .KERMIT
        Kermit-11 T3.44 Last Edit: 04-Feb-86    
        Kermit-11>SET LIN XL
        Kermit-11>CONNECT
@End(Format)

@SubSection(Installing Kermit-11 on P/OS)

@Heading(P/OS Kermit-11)
@Index(P/OS)

Kermit-11, running on the PRO/350 and 380 under P/OS, runs under control
of  DCL.   DCL is normally installed at system generation time; it is an
optional application.  DCL can also be installed under the  PRO/TOOLKIT.
The  DECUS  distribution,  on  RX50  diskettes, has all the needed files
under the directory [001002], or, in Files-11 ODS1 terms, in UIC  [1,2].
Thus, installing Kermit-11 under P/OS from RX50's is quite simple:

@Begin(Format)
        $ COPY/CONT DZ1:[1,2]K11POS.TSK [USERFILES]
        $ COPY/CONT DZ1:[1,2]K11HLP.HLP [1,2]
@End(Format)

Where DZ1 is the first floppy drive unit, as opposed to RT-11, where DZ0
is the first floppy drive unit.
Thus, assuming that the current default directory  is  [USERFILES],  one
simply types:

@Begin(Format)
        $ RUN K11POS
        Kermit-11 T3.44 Last edit: 04-Feb-86
        Line set to XK0: at 9600 baud
        Kermit-11>
@End(Format)

As noted, the PRO/3xx Kermit-11 can make  use  of  XT1:   and  XT2:   to
access the PRO/TMS Telephone Management System.  If a SET LINE XT1:  (or
XT2:, when applicable) is done, then the Kermit-11 DIAL command  can  be
used  to  access  the TMS internal modem to place an outgoing call.  All
needed formatting characters MUST be imbedded in the  TMS  dial  string.
If the DIAL command is used, and the line name starts with 'XT', then it
is assumed that TMS is being used; otherwise you would  be  required  to
use  the  SET  MODEM command prior to issuing the DIAL command.  Further
information regarding DIAL and SET MODEM is available in  the  Kermit-11
User's Guide and in the online HELP file.

The other obvious way to get Kermit-11 onto your PRO is by bootstrapping
Steven's  PRO  Kermit  or  Bob  Denny's  PRO Kermit to download the task
image, or by using PFT to transfer the task image from  an  RSX-11M+  or
VMS host (this is left for the reader to explore).

The other method to load Kermit-11 on to a PRO/3xx  P/OS  system  is  by
transferring   the  files  K11POS.HEX  (a  'Hexified'  task  image)  and
K11HEX.FTN (a Fortran-77 program)  or  K11HEX.B2S  (a  Basic+2  program)
using  PRO/Communications  (Pro/Comm).  The K11HEX programs are intended
to convert  the  'HEX'  file  format  into  an  executable  task  image;
instructions  are contained in the respective source files for compiling
and  task  building.   Please  note  that  whenever  a  task  image   is
transferred  to  an RSX based system, as P/OS is, the image MUST be made
contiguous, as in:

@Begin(Format)
        $ COPY/CONT K11POS.TSK K11POS.TSK               P/OS under DCL
        > PIP K11POS.TSK/CO=K11POS.TSK                  RSX-11M under MCR
@End(Format)

The last note regards  FUNCTION  key  mapping;  K11POS  will,  while  in
CONNECT mode, map the following keys:

@Begin(Format)
        F5  (Break)     Control\ B will send a break to the remote system
                        as well as typing F5.
        F6  (Interrupt) Send a Control C (03  octal) to remote
        F10 (Exit)      Send a Control Z (032 octal) to remote
        F11 (ESC)       Send Escape      (033 octal) to remote
        F12 (BS)        Send Backspace   (011 octal) to remote
        F13 (LF)        Send LineFeed    (012 octal) to remote
@End(Format)

@SubSection(Installing Kermit-11 on RSX-11M and RSX-11M Plus)
@Index(RSX installation)

Kermit-11 runs under RSX-11M 4.0 or later, RSX-11M Plus  2.1  or  later,
and MicroRsx version 3.  All file activity is done through RMS11 version
2; this is one compelling reason why Kermit can not function on  earlier
versions  of  RSX.  The use of RMS11 does, however, give you transparent
support for Decnet and compatability of  Kermit's  file  system  between
RSX, P/OS and RSTS/E.

There are two distributed task images for RSX.  The file  K11RSX.TSK  is
used  on  RSX-11M  and  can also be used on RSX-11M Plus, and has DECNET
support linked into the image.  The other image, K11POS.TSK,  is  usable
only  on  RSX-11M  Plus  and  MicroRSX, as it is linked to the segmented
RMSRES resident library.  It is NOT linked to  DAPRES,  thus  if  Decnet
access is required, the former task image must be used.

The main distribution methods for Kermit on RSX are via DOS-11 formatted
magnetic  tape,  Ansi-D  tape  from  Columbia University and the RSX SIG
symposia tape (in BRU or VMS Backup format).  The former, DOS-11, is the
format that the Decus library's copy of Kermit-11 (Decus number 11-731).
There  is  an  alternative  distribution  from  DECUS  on  either  RT-11
formatted RX01 diskettes, or on ODS1 RX50 diskettes.

(1) DOS format magtape

@Begin(Format)
        > MOU MM0:/FOR
        > INS $FLX
        > FLX SY:/RS=MM0:[*,*]K11RSX.TSK/DO
        > FLX SY:/RS=MM0:[*,*]K11POS.TSK/DO
        > FLX SY:/RS=MM0:[*,*]K11HLP.HLP/DO
        > FLX SY:/RS=MM0:[*,*]K11USR.DOC/DO
        > PIP [1,54]/CO=K11RSX.TSK
        > PIP [1,2]/CO=K11HLP.HLP
        > PIP [1,54]K11RSX.TSK/PR/WO:R
        > PIP [1,2]K11HLP.HLP/PR/WO:R
        > INS $K11RSX/TASK=...KER

        (1)  The tape is mounted foreign
        (2)  FLX is installed, if it is not already
        (3)  The main Kermit-11 RSX task image is copied
        (4)  The alternate task image is copied
        (5)  The online HELP file is copied
        (6)  The users guide us copied
        (7)  The task is copied to [1,54] and made contiguous
        (8)  The help file is copied to [1,2] and made contiguous
        (9)  The task image's protection is set to WORLD read access
        (10) The HELP file's  protection is set to WORLD read access
        (11) The task image is installed as KER
@End(Format)

(2) ANSI D format tape from Columbia University

@Begin(Format)
        >MOU MM0:/OV=ID
        >PIP SY:=MM0:K11RSX.HEX
        >PIP SY:=MM0:K11HEX.FTN
        >PIP SY:=MM0:K11HLP.HLP
        >PIP SY:=MM0:K11USR.DOC
@End(Format)

The tape set, as it comes from Columbia University, is blocked  at  8192
bytes  per  tape  block.   This  could  cause  PIP to fail unless PIP is
installed with a very large size increment.  If this should  occur,  you
will get an error message similar to:

@Begin(Format)
        PIP - open failure on input file
        MM0:[5,20]K11RSX.HEX;1  No buffer space available for file
@End(Format)

To correct this you can do one of two things:

@Begin(Format)
        >INS $PIP/TASK=...XPP/INC=50000
        >XPP SY:=MM0:K11RSX.HEX
        >XPP SY:=MM0:K11HEX.FTN
        >XPP SY:=MM0:K11HLP.HLP
        >XPP SY:=MM0:K11USR.DOC
        >REM XPP

or:

        >RUN $PIP/INC=50000
        PIP>SY:=MM0:K11RSX.HEX
        PIP>SY:=MM0:K11HEX.FTN
        PIP>SY:=MM0:K11HLP.HLP
        PIP>SY:=MM0:K11USR.DOC
        PIP>^Z
        >
@End(Format)

Note that we could not get K11RSX.TSK from this tape;  it's  not  there.
Instead  we copied K11RSX.HEX, a file that can be run through the K11HEX
program(s) to create the needed task image.

@Begin(Format)
        >F77 K11HEX=K11HEX
        >TKB
        TKB>K11HEX=K11HEX,LB:F4POTS/LB
        TKB>/
        Enter Options:
        TKB>maxbuf=512
        TKB>//
        >RUN K11HEX
        Input  file ? k11rsx.hex
        Output file ? kermit.tsk
        Encode or Decode ? decode
        all done
        >PIP [1,54]/CO=K11RSX.TSK
        >PIP [1,2]/CO=K11HLP.HLP
        >PIP [1,54]K11RSX.TSK/PR/WO:R
        >PIP [1,2]K11HLP.HLP/PR/WO:R
        >INS $K11RSX/TASK=...KER
@End(Format)

(3) RT-11 Format RX01 diskettes

@Begin(Format)
        > MOU DX0:/FOR
        > MOU DX1:/FOR
        > FLX SY:/RS=DX0:K11RSX.TSK/RT
        > FLX SY:/RS=DX1:K11HLP.HLP/RT
        > FLX SY:/RS=DX1:K11USR.DOC/RT
        > PIP [1,54]/CO=K11RSX.TSK
        > PIP [1,2]/CO=K11HLP.HLP
        > PIP [1,54]K11RSX.TSK/PR/WO:R
        > PIP [1,2]K11HLP.HLP/PR/WO:R
        > INS $K11RSX/TASK=...KER
@End(Format)

RX01's diskettes can hold approximately 470 blocks of data; this implies
that  there will be at least two, if not three, diskettes involved.  You
will need to try a different diskette if  the  desired  file(s)  is  not
present  on the currently mounted disk.  Also, if you have an RX02 drive
instead of an RX01 drive, the device name will be DY instead of DX.


Please note that RSX Kermit is a privileged task; it's  built  with  the
/PR:0  TKB  switch.  This is required so that Kermit can access terminal
lines other than your own; as would be the case when you are dialing out
from  your  system.   The  task  does,  however  (under RSX-11M Plus and
MicroRSX), drop and regain privilege when it needs it; for example,  the
SET   LINE  and  CONNECT  commands  both  have  to  issue  set  multiple
characteristics calls to condition the serial line being used.

@SubSection(Kermit-11 Notes on IAS installations)

This information regarding IAS Kermit was provided by the EPA  in  there
conversion  of  Kermit-11  to  run  under  IAS version 3.1.  The current
version of IAS Kermit-11 is based on base 2.30 of  Kermit-11.   It  will
likely  stay at this base level forever; the conversion was done for use
with RMS11 version 1, which will be superceded by RMS11 version 2 in IAS
3.2  Update C.  At that point the IAS 3.1 Kermit task image, K11I31.TSK,
will no longer function since it is linked to an RMS version 1  resident
library.   The  RMS  resident  libraries were redone for RMS v2 in order
that (1) the library can be segmented into multiple  libraries  and  (2)
the  entry  point  addresses are never changed, thus new versions of the
reslib do not force the user to relink ones task images.

@Heading(Restrictions and Notes) @index(installation notes)
@Index(release notes)

@Begin(Enumerate)
Dial-out lines must not be interactive terminals.  That  is,  if  you
are going to use a line as a dial- out line, you must not allocate it to
PDS or SCI.

Spawning installed tasks is currently  done  via  a  SPWN$  directive
rather  than  via  RUN$T.   Therefore, anyone wanting to spawn installed
tasks must have the PR.RTC (real-time) privilege.  A  workaround  is  to
exit  from  Kermit,  run the program, and then run Kermit again.  Kermit
will first try to run an installed task named $$$xxx, where xxx  is  the
system  command  requested;  if  that  fails,  Kermit will try to run an
installed task named ...xxx.

@index(wildcard files)
Wild-card file operations are supported (for example, DIR *.DAT,  DEL
*.TSK,  SEND  *.MAC).   Under  RSX,  Kermit  uses  RMS  version  2 to do
wild-card operations; this is available under IAS V3.2 but not under IAS
V3.1.   Therefore,  on  IAS  V3.1 (the version that the EPA is running),
there are the following restrictions on file operations::

@Begin(Enumerate)
@BlankSpace(-2 lines)
     Wild-cards must be specified for the entire field or not at all.
     For example, TEST.* is OK but TEST*.* is not.

     If a wild-card file  operation  is  executed,  with  either  the
     file-name  or  the  file-type  specified  as  a wild-card, the file
     version number is also taken to be a wild-card.

     Wild-card operations are not allowed on directories.  Therefore,
     [*,*]*.DAT is not a legal wild-card operation in Kermit-IAS.  It is
     legal to use explicit directories, such as [200,200]*.DAT.

     RMS  Version  2  supports  transparent   DECNET   remote   file
     operations,  while  RMS  Version 1 does not.  Therefore, Kermit-IAS
     under IAS V3.1 does not support DECNET file transfers.

     Renaming files within Kermit is not supported under V3.1 of IAS.
@End(Enumerate)

Kermit under IAS currently reads packets one character at a time, and
so  can use up a fair amount of the CPU if it is receiving files.  If it
is sending packets (sending files or remote command responses), or if it
is  reading  commands rather than its file transfer packets, it will use
long I/O operations and will not put an excessive burden on the system.
@End(Enumerate)

@Heading(Installing Kermit-11 on AIS)

Kermit is built as a multi-user task, with a task name  of  $$$KER.   It
can be run as an installed "foreign command" task:

@Begin(Format)
        PDS> install k11ias
        PDS> kermit
        Kermit-11 T2.30
        Kermit-11>...
@End(Format)

You can also specify another name for the installed command:

@Begin(Format)
        PDS> install/sys:k11 k11ias
        PDS> k11
        Kermit-11 T2.30
        Kermit-11>...
@End(Format)

Or you can just run it as a non-installed task:

@Begin(Format)
        PDS> run k11ias
        16:30:15
        Kermit-11 T2.30
        Kermit-11>...
@End(Format)

The following files are supplied for Kermit-IAS to run:

@Begin(Format)
        K11I31.TSK      - The Kermit task image
        K11HLP.HLP      - The Kermit help file.  For this to be used by
                          Kermit, it must be in the default directory.
        K11I31.DOC      - This file, describing Kermit on IAS
@End(Format)

@SubSection(Obtaining Kermit-11 Updates From the University of Toledo)

From Bitnet server on U of Toledo's 11/785

@Begin(Format)
from VM/CMS:    CP SMSG RSCS MSG UOFT02 KERMSRV DIR
                CP SMSG RSCS MSG UOFT02 KERMSRV SEND K11*.*

from VMS Jnet:  $ SEN/REM UOFT02 KERMSRV SEND K11*.*
@End(Format)

Dialup access to the 11/785:

@Begin(Format)
        (419) 537-4411
        Service class  VX785A
        User: KERMIT
        Password: KERMIT
@End(Format)

Source and hex files are in KER:, binaries are in KERBIN:
@Modify(Format, FaceCode R)
