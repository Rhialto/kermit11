SRC=K11ATR.MAC K11CPY.MAC K11CVT.MAC K11DAT.MAC K11DEB.MAC K11DER.MAC \
 K11DFH.MAC K11DIA.MAC K11EDI.MAC K11ERR.MAC K11ER1.MAC K11ER2.MAC \
 K11ER3.MAC K11HLP.MAC K11INI.MAC K11LCL.MAC K11MCO.MAC K11M41.MAC \
 K11RMS.MAC K11RMZ.MAC K11RXX.MAC K11SUB.MAC K11TRA.MAC K11PCO.MAC

SRCCOM=K11CM1.MAC K11COM.MAC K11SHO.MAC K11ST0.MAC K11ST1.MAC \
 K11STD.MAC K11CMD.MAC

SRCDEF=K11PAK.MAC K11REC.MAC K11SEN.MAC K11SER.MAC

ALL: K11RSX K11IDM K11IDD

K11RSX: $(SRC:.MAC.OBJ) $(SRCCOM:.MAC.OBJ) $(SRCDEF:.MAC.OBJ) K11RSX.CMD
	TKB @K11RSX

K11IDD: $(SRC:.MAC.OBJ) $(SRCCOM:.MAC.OBJ) $(SRCDEF:.MAC.OBJ) K11IDD.CMD
	TKB @K11IDD

K11IDM: $(SRC:.MAC.OBJ) $(SRCCOM:.MAC.OBJ) $(SRCDEF:.MAC.OBJ) K11IDM.CMD
	TKB @K11IDM

$(SRC:.MAC.OBJ): *.MAC
	MAC $@=$<

$(SRCCOM:.MAC.OBJ): *.MAC
	MAC $@=$<

$(SRCDEF:.MAC.OBJ): *.MAC
	MAC $@=$<

$(SRC:.MAC.OBJ): K11MAC.MAC

K11SER.OBJ $(SRCCOM:.MAC.OBJ): K11CDF.MAC K11MAC.MAC

$(SRCDEF:.MAC.OBJ): K11DEF.MAC K11MAC.MAC
