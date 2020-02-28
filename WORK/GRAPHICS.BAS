REM Graphicks Drawer ver. 1.0
CLS
SCREEN 1
PRINT "Graphics Drawer ver. 1.0"
INPUT "Type <1> to Load or <2> to Create - ", TYP
IF TYP = 2 THEN
        CLS
        GOTO Repeat
ELSEIF TYP = 1 THEN
        INPUT "Filename (DAT) - ", FLNM$
        IF FLNM$ = "" THEN END
        INPUT "Screen Size Xs,Ys - ", Xs, Ys
        INPUT "Edit (Y/N) - ", YN3$: YN3$ = UCASE$(YN3$)
        CLS : A = 1
        OPEN "B", #1, FLNM$ + ".DAT"
        FOR TX = 0 TO Xs
        FOR TY = 0 TO Ys
        SEEK #1, A: D$ = " ": GET #1, , D$: D = ASC(D$)
        PSET (TX, TY), D
        A = A + 1
        NEXT TY, TX
        CLOSE #1
        IF YN3$ = "Y" THEN GOTO Repeat
END IF
END
Repeat:
LOCATE 5, 1: PRINT SPACE$(160);
LOCATE 5, 1
INPUT ; "X1=", X1: INPUT ; "Y1=", Y1: INPUT ; "X2=", X2: INPUT ; "Y2=", Y2
INPUT ; "Cl=", Cl: INPUT "BF?", B$: B$ = UCASE$(B$)
IF B$ = "" THEN
        LINE (X1, Y1)-(X2, Y2), Cl
ELSEIF B$ = "B" THEN
        LINE (X1, Y1)-(X2, Y2), Cl, B
ELSEIF B$ = "BF" THEN
        LINE (X1, Y1)-(X2, Y2), Cl, BF
END IF
INPUT "Repeat (Y/N) - ", YN$
IF UCASE$(YN$) = "N" THEN GOTO Cont00 ELSE GOTO Repeat
Cont00:
INPUT "Size XS,YS - ", Xs, Ys
IF Xs AND Ys = 0 THEN END
INPUT "Filename (DAT) - ", FLNM$
IF FLNM$ = "" THEN END
OPEN "B", #1, FLNM$ + ".DAT": A = 1
FOR TSTX = 0 TO Xs
FOR TSTY = 0 TO Ys
DIN = POINT(TSTX, TSTY)
DIN$ = CHR$(DIN)
SEEK #1, A: PUT #1, , DIN$
A = A + 1
NEXT TSTY, TSTX
CLOSE #1
CLS
INPUT "Test to load (Y/N) ? - ", YN2$
IF UCASE$(YN2$) = "Y" THEN GOTO Load
END
Load:
CLS
OPEN "B", #1, FLNM$ + ".DAT"
A = 1
FOR TSTX = 0 TO Xs
FOR TSTY = 0 TO Ys
DAT$ = " ": SEEK #1, A: GET #1, , DAT$: DAT = ASC(DAT$)
PSET (TSTX, TSTY), DAT
A = A + 1
NEXT TSTY, TSTX
CLOSE #1

