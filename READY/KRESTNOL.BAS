REM --------------------------------------------------------------------------
REM Крестики - нолики ver. 1.0 (CGA - Поиск)
REM QB version 1.0
REM --------------------------------------------------------------------------
DECLARE SUB MUSIC (FILENAME$, R!)
DECLARE SUB DatLoad (FLNM$, X!, Y!, Sx!, Sy!)
DECLARE SUB PRKEY ()
REM --------------------------------------------------------------------------
DIM TMPPIX(800), SWPPIX(800), KRS(256), NOL(256), Cur(128), POLE(2, 2)
XPL = 1: OPL = 0: E$ = ".CGA": PL = 0
REM --------------------------------------------------------------------------
SCREEN 1
DEF SEG = &HB800
CLS
REM --------------------------------------------------------------------------
CALL MUSIC("KRESTNOL.MUS", 1): BLOAD "LOGO00" + E$: CALL PRKEY
CALL MUSIC("KRESTNOL.MUS", 1): BLOAD "LOGO01" + E$: CALL PRKEY
CALL MUSIC("KRESTNOL.MUS", 1): BLOAD "LOGO02" + E$
REM --------------------------------------------------------------------------
DO UNTIL A$ = "X" OR A$ = "O"
A$ = UCASE$(INKEY$)
LOOP
REM --------------------------------------------------------------------------
CALL MUSIC("GAME00.MUS", 1)
IF A$ = "X" THEN
        PLY = XPL
        FIGE = XPL
        FIGC = OPL
ELSE
        PLY = OPL
        FIGE = OPL
        FIGC = XPL
END IF
IF PLY = 1 THEN P$ = "00" ELSE P$ = "01"
COLOR , 0: BLOAD "PICT" + P$ + E$
CALL PRKEY
REM --------------------------------------------------------------------------
COLOR 0, 1: BLOAD "LOGO03" + E$
GET (66, 145)-(100, 150), SWPPIX
LINE (66, 145)-(100, 150), 1, BF: LINE (66, 145)-(100, 150), 2, B
GET (66, 145)-(100, 150), TMPPIX
REM --------------------------------------------------------------------------
Lab00:
REM --------------------------------------------------------------------------
A$ = INKEY$
IF A$ = "" THEN GOTO Lab00
IF A$ = CHR$(27) THEN
        SOUND 523.25, 2: SOUND 587.33, 1: SOUND 659.26, 1: SOUND 587.33, 1: SOUND 659.26, 1: SOUND 698.46, 2
        CLS : END
END IF
REM --------------------------------------------------------------------------
IF A$ = CHR$(13) AND PL = 0 THEN
        SOUND 1046.5, 1: SOUND 1046.5, 1: SOUND 1174.7, 2
        GOTO Game:
END IF
REM --------------------------------------------------------------------------
IF MID$(A$, 2, 1) = CHR$(77) THEN
        SOUND 130.81, .3: SOUND 146.83, .3: SOUND 164.81, .3
        IF PL = 1 THEN GOTO UnCorCont
        PL = 1
        HOD = 1
        PUT (66, 145), SWPPIX, PSET
        GET (234, 145)-(300, 155), SWPPIX
        PUT (234, 145), TMPPIX, PSET
ELSEIF MID$(A$, 2, 1) = CHR$(75) THEN
        SOUND 130.81, .3: SOUND 146.83, .3: SOUND 164.81, .3
        IF PL = 0 THEN GOTO UnCorCont
        PL = 0
        HOD = 0
        PUT (234, 145), SWPPIX, PSET
        GET (66, 145)-(100, 150), SWPPIX
        PUT (66, 145), TMPPIX, PSET
END IF
REM --------------------------------------------------------------------------
UnCorCont:
GOTO Lab00
REM --------------------------------------------------------------------------
Game:
REM --------------------------------------------------------------------------
CLS
PRINT "Initializing Setup ... Please Wait"
CALL DatLoad("KRESTIK", 16, 16, 0, 8): GET (0, 8)-(16, 24), KRS
CALL DatLoad("NOLIK", 16, 16, 0, 8): GET (0, 8)-(16, 24), NOL
CALL DatLoad("CURSOR", 16, 8, 0, 8): GET (0, 8)-(16, 16), Cur
REM --------------------------------------------------------------------------
FOR TPX = 0 TO 2
FOR TPY = 0 TO 2
POLE(TPX, TPY) = 2
NEXT TPY
NEXT TPX
REM --------------------------------------------------------------------------
CLS
BLOAD "GAME00" + E$: GX = 153: GY = 101
CXP = 153: CYP = 111: CX = 1: CY = 1: PUT (CXP, CYP), Cur:
CompX = 1: CompY = 1: CompXPL = 153: CompYPL = 101
REM --------------------------------------------------------------------------
StartPlay:
REM --------------------------------------------------------------------------
IF PL = 0 THEN
        HOD = 1
        IF PLY = NOL THEN
                PUT (CompXPL, CompYPL), KRS
                POLE(CompX, CompY) = NOL
        ELSE
                PUT (CompXPL, CompYPL), NOL
                POLE(CompX, CompY) = KRS
        END IF
END IF
REM --------------------------------------------------------------------------
Lab01:
REM --------------------------------------------------------------------------
B$ = INKEY$
IF B$ = "" THEN GOTO Lab01
IF B$ = CHR$(27) THEN
        SOUND 523.25, 2: SOUND 587.33, 1: SOUND 659.26, 1: SOUND 587.33, 1: SOUND 659.26, 1: SOUND 698.46, 2
        CLS : END
END IF
IF B$ = CHR$(32) AND HOD = 1 THEN
        IF POLE(CX, CY) <> 2 THEN
                SOUND 100, .4: SOUND 200, .4: SOUND 300, .4
        GOTO UnCorLab01
        END IF
        SOUND 659.26, .7: SOUND 523.25, .7: SOUND 587.33, .7
        POLE(CX, CY) = PLY
        IF PLY = XPL THEN
                PUT (GX, GY), KRS
        ELSE
                PUT (GX, GY), NOL
        END IF
        GOSUB CheckComp
END IF
IF MID$(B$, 2, 1) = CHR$(77) THEN
        REM *** Right ***
        SOUND 1568!, .4: SOUND 1760!, .4: SOUND 1975!, .4
        IF CX + 1 = 3 THEN GOTO UnCorLab01
        PUT (CXP, CYP), Cur
        CXP = CXP + 40
        GX = GX + 40
        CX = CX + 1
        PUT (CXP, CYP), Cur
ELSEIF MID$(B$, 2, 1) = CHR$(75) THEN
        REM *** Left ***
        SOUND 1568!, .4: SOUND 1760!, .4: SOUND 1975!, .4
        IF CX - 1 = -1 THEN GOTO UnCorLab01
        PUT (CXP, CYP), Cur
        CXP = CXP - 40
        GX = GX - 40
        CX = CX - 1
        PUT (CXP, CYP), Cur
ELSEIF MID$(B$, 2, 1) = CHR$(80) THEN
        REM *** Down ***
        SOUND 1568!, .4: SOUND 1760!, .4: SOUND 1975!, .4
        IF CY + 1 = 3 THEN GOTO UnCorLab01
        PUT (CXP, CYP), Cur
        CYP = CYP + 35
        GY = GY + 33
        CY = CY + 1
        PUT (CXP, CYP), Cur
ELSEIF MID$(B$, 2, 1) = CHR$(72) THEN
        REM *** Up ***
        SOUND 1568!, .4: SOUND 1760!, .4: SOUND 1975!, .4
        IF CY - 1 = -1 THEN GOTO UnCorLab01
        PUT (CXP, CYP), Cur
        CYP = CYP - 35
        GY = GY - 33
        CY = CY - 1
        PUT (CXP, CYP), Cur
END IF
UnCorLab01:
GOTO Lab01
REM --------------------------------------------------------------------------
CheckComp:
REM --------------------------------------------------------------------------
REM ******* Три вертикальных линии *******************************************
EF = 0: CF = 0:
FOR X = 0 TO 2
FOR Y = 0 TO 2
IF POLE(X, Y) = FIGE THEN EF = EF + 1
IF POLE(X, Y) = FIGC THEN CF = CF + 1
IF POLE(X, Y) = CLRF THEN NRX = X: NRY = Y
NEXT Y
LOCATE 1, 1: PRINT EF; CF; NRX; NRY
IF EF = 2 AND CF = 0 THEN GETX = NRX: GETY = NRY: GOTO ComMOVE
EF = 0: CF = 0: NRX = 0: NRY = 0: NEXT X
REM --------------------------------------------------------------------------
ComMOVE:
REM --------------------------------------------------------------------------
GOSUB MakeCC
IF PLY = NOL THEN
                PUT (NCORx, NCORy), KRS
                POLE(GETX, GETY) = NOL
ELSE
                PUT (NCORx, NCORy), NOL
                POLE(GETX, GETY) = KRS
END IF
GOTO Lab01
REM --------------------------------------------------------------------------
MakeCC:
REM 153 101
IF GETX = 0 THEN NCORx = 103
IF GETX = 1 THEN NCORx = 153
IF GETX = 2 THEN NCORx = 193
IF GETY = 0 THEN NCORy = 66
IF GETY = 1 THEN NCORy = 101
IF GETY = 2 THEN NCORy = 136
RETURN
REM --------------------------------------------------------------------------

SUB DatLoad (FLNM$, X, Y, Sx, Sy)
A = 1
OPEN "B", #1, FLNM$ + ".DAT"
FOR TX = 0 TO X
FOR TY = 0 TO Y
D$ = " ": SEEK #1, A: GET #1, , D$: D = ASC(D$)
PSET (TX + Sx, TY + Sy), D
A = A + 1
NEXT TY, TX
CLOSE #1
END SUB

SUB MUSIC (FILENAME$, R)
OPEN "I", #1, FILENAME$
INPUT #1, MELODY$
CLOSE #1
FOR TMP = 0 TO R
PLAY MELODY$
NEXT TMP
END SUB

SUB PRKEY
WHILE INKEY$ = ""
WEND
END SUB

