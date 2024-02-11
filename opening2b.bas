#RetroDevStudio.MetaData.BASIC:7169,BASIC V7.0 VDC,uppercase,10,10
# U4 LORD BRITISH WRITING

# WRITING 2:
# + CREATURES ON TOP LEFT AND RIGHT
# + BORDER FOR MAP

# WRITING 2B:
# + TILES FOR MAP

10 GRAPHIC 0
20 PRINT "WELCOME TO THE ULTIMA 4 INTRO":PRINT
30 DIM XL(7):FOR X=0 TO 7:XL(X)=2        X:NEXT
40 DIM YL(200):FOR Y=0 TO 199:YL(Y)=Y*80:NEXT

50 DEF FN W(ZZ)=PEEK(ZZ)+PEEK(ZZ+1)*256
60 BS=FN W(45)
70 BE=FN W(4624)
#  DB:DATA BEGIN
#  DE:DATA END
80 DB=BE+1:DE=DB+8000

90 PRINT "BASIC FROM "BS" TO "BE"."
100 PRINT "LEAVES "FRE(0)" BYTES FREE FOR DATA."


110 DD=PEEK(186)
120 PRINT "INSERT DATADISK":GETKEY I$
130 BLOAD"VDCBASIC2D.0AC6",U(DD),B0:SYS DEC("AC6")

140 RGO 28,16:REM 64K VRAM
150 RGO 25,128:REM BITMAP MODE ON
# 2 SCANLINES PER CHAR, 156 SCANLINES (EACH VAL +1)
160 RGW 0,127:RGW 4,155:RGW 6,100:RGW 7,140:RGW 9,1
170 RGW 36,0

#AS:ATTRIBUTE SOURCE
#AD:ATTRIBUTE DESTINATION
180 AS=40000:AD=16000

#PS:PIXEL SOURCE
#PD:PIXEL DESTINATION
190 PS=24000:PD=0

#RW:ROW WIDTH
200 RW=80

210 DISP 0:ATTR AD
220 VMF 0,0,16000: REM CLEAR SCREEN-RAM (ALL PIXELS TO BG-COLOR)
230 VMF 16000,DEC("0F"),8000: REM SETUP ATTRIBUTE-RAM (BLACK/WHITE AS BG/FG COLORS FOR ALL PIXELS)

240 PF$="TITLE.VDC"
250 BLOAD (PF$),U(DD),P(DB),B0
260 RTV DB,24000,24000


#210 GOTO 1600

# COORDINATES FOR "QUEST OF THE AVATAR" ANIMATION
270 DIM IA(1,5)
280 IA(0,0)=0:IA(0,1)=0:IA(0,2)=1:IA(0,3)=1:IA(0,4)=2:IA(0,5)=2
290 IA(1,0)=0:IA(1,1)=1:IA(1,2)=1:IA(1,3)=2:IA(1,4)=2:IA(1,5)=3


300 VMF 0,0,16000: REM CLEAR SCREEN-RAM (ALL PIXELS TO BG-COLOR)
310 VMF 16000,DEC("0F"),8000: REM SETUP ATTRIBUTE-RAM (BLACK/WHITE AS BG/FG COLORS FOR ALL PIXELS)
320 RESTORE

###########################################
# LORD BRITISH CA 2.5 SECS
###########################################
330 FAST:S=TI
340 VMF AD,7,8*RW
350 READ I
360 DO WHILE I<>0

# X1:BYTE, X2:BIT OF X-POSITION OF PIXEL
# X GOES FROM 77-205
# YP:Y-POSITION OF PIXEL
#360  X=(I+20)*2
370  X=I+I+40

380  READ I
390  Y=191-I
400  X1=INT(X/8)
410  X2=7-(X-X1*8)
420  YP=YL(Y)

430  VMO YP+X1,XL(X2)

440  X=X+2
450  X1=INT(X/8)
460  X2=7-(X-X1*8)

470  VMO YP+X1,XL(X2)

480  READ I
490  GET I$:IF LEN(I$)>0 THEN PRINT "PAUSE":GETKEY I$:PRINT "GO"

500 LOOP

510 S=TI-S:PRINT "LORD BRITISH: "S" JIFFIES"
520 SLOW

# "AND" - NEEDS TO BE COPIED FROM TITLE.EGA {SHIFT-ARROW UP} DELAYED 1 SEC
#  SCREEN-RAM: ROWS 17-20 = 17*80 - 21*80 = 1360-1680 -> 320 BYTES
#  ATTRIBUTES: ROWS 9-11 = 9*80 - 11*80 = 720-880 -> 160 BYTES
530 VMC PS+1360,PD+1360,320
540 VMC AS+720,AD+720,160

# LINE {SHIFT-ARROW UP} 1 SEC DELAY AND 1 SEC DURATION
550 FAST
560 YP=31*RW
570 VMF AD+15*RW,8,RW
580 FOR I=170 TO 475 STEP 2
590  X=I:X1=INT(X/8):X2=7-(X-X1*8)
600  VMO YP+X1,XL(X2)
610  X=I+2:X1=INT(X/8):X2=7-(X-X1*8)
620  VMO YP+X1,XL(X2)
630 NEXT
640 SLOW

# "ORIGIN SYSTEMS,INC." ABOVE LINE {SHIFT-ARROW UP} 1 SEC
#  SCREEN-RAM: ROWS 21-30 = 1680-2400 -> 720 BYTES
#  ATTRIBUTES: ROWS 10-15 = 800-1200 -> 400 BYTES
#  9 ANIMATION STEPS - 1 STEP ABOUT 6-7 JIFFIES

650 VMF AD+880,3,320

660 I=0

670 TI$="000000"
680 DO

690   IF TI>4 THEN BEGIN
700    VMC PS+21*RW,PD+(21+8-I)*RW,(I+1)*RW
710    TI$="000000"
720    I=I+1
730   BEND

740 LOOP UNTIL I>8


# "PRESENT" BELOW LINE {SHIFT-ARROW UP} 0.75 SECS
#  SCREEN-RAM: SOURCE=0, DESTINATION=33
#  ATTRIBUTES: SOURCE=0, DESTINATION=16
#  5 ANIMATION STEPS

750 I=0
760 TI$="000000"
770 DO

780  IF TI>4 THEN BEGIN
#1400 FOR I=0 TO 4
790   VMC PS+(4-I)*RW,PD+33*RW,(I+1)*RW

800   TI$="000000"
810   I=I+1
820  BEND

830 LOOP UNTIL I>4

#1415 NEXT

# SAVE "PRESENTS" IN HIDDEN AREA OF VRAM TO NOT LOSE IT WHEN COPYING "ULTIMA IV"
# 136-189=53 FOR 5 ROWS
# DESTINATION: ROW 33-37
840 FOR I=0 TO 4
850  VMC PS+34+I*RW,PS+34+((I+33)*RW),14
860 NEXT

870 FOR I=0 TO 2
880  VMC AS+34+I*RW,AS+34+((I+16)*RW),14
890 NEXT


# "ULTIMA IV" {SHIFT-ARROW UP} 4.5 SECS
#  SCREEN-RAM: SOURCE=33*80, DESTINATION=33*80 -> LENGTH (-79*80) -> 46*80
#  ATTRIBUTES: SOURCE=16*80, DESTINATION=16*80 -> -40*80 -> 24*80
900 REM PRINT "PRESS KEY TO CONTINUE":GETKEY I$
910 SYN
920 VMC PS+33*RW,PD+33*RW,46*RW
930 VMC AS+16*RW,AD+16*RW,24*RW

# "QUEST OF THE AVATAR" {SHIFT-ARROW UP} 0.75 SECS
#  SCREEN-RAM: SOURCE=80*80, LENGTH= 13*80
#  ATTRIBUTES: SOURCE=40*80, LENGTH= 7*80

#  ANIMATION CONSISTS OF 13 LINES
#  DRAW MIDDLE LINE FIRST (6)
#  THEN IN 6 STEPS:
#  0   AND    12 TO 5 AND 7
#  0-1 AND 11-12 TO 4 AND 7
#  0-2 AND 10-12 TO 3 AND 7
#  0-3 AND  9-12 TO 2 AND 7
#  0-4 AND  8-12 TO 1 AND 7
#  0-5 AND  7-12 TO 0 AND 7

# MIDDLE LINE (85)
940 VMC PS+86*RW,PD+86*RW,RW
950 VMC AS+43*RW,AD+43*RW,RW


960 FOR I=0 TO 5

#     ABOVE MIDDLE LINE
970  VMC PS+80*RW,PD+(85-I)*RW,(I+1)*RW
980  VMC AS+40*RW,AD+(42-IA(0,I))*RW,IA(0,I)*RW

#     BELOW MIDDLE LINE
990  VMC PS+(92-I)*RW,PD+87*RW,RW*(I+1)
1000  VMC AS+(46-IA(1,I))*RW,AD+43*RW,IA(1,I)*RW

#1624  SLEEP 1

1010 NEXT

######################
# LOAD MAP INTO VRAM #
######################

1020 PRINT "LOADING TILES...";
1030 BLOAD "TILES.BMP.VDC",U(DD),B0,P(DB)
1040 PRINT "DONE"

1050 RTV DB,PS,16*80
1060 RTV DB+16000,AS,8*80

# O1:TOP OFFSET FOR TILES IN SCREEN-RAM
# P1:TOP OFFSET FOR TILES IN ATTRIBUTE-RAM
1065 O1=104*80:P1=52*80

1069 S=TI:FAST

1070 READ D:XT=2
1080 DO WHILE D>=0
1090  XS=D+D+D+D
1095  T=XT+YT*16*80+PS+O1
1097  T2=XT+YT*8*80+AS+P1

1100  VMC PS+XS,T,4,16,80,64
1110  VMC AS+XS,T2,4,8,80,64

1120  XT=XT+4:IF XT>77 THEN XT=2:YT=YT+1
1129  READ D
1130 LOOP

1135 S=TI-S:SLOW
1136 PRINT "MAP DRAW TOOK "S" JIFFIES"

##############################
# BORDER AND CONTENTS OF MAP #
##############################

1140 PRINT "PRESS KEY TO DRAW BORDER":GETKEY I$

# COPY TOP AND BOTTOM LINE
#    O1:TOP OFFSET FOR SCREEN-RAM
#    O2:BOTTOM OFFSET FOR SCREEN-RAM
#    P1:TOP OFFSET FOR ATTRIBUTE-RAM
#    P2:BOTTOM OFFSET FOR ATTRIBUTE-RAM
1150 O1=96*80:O2=184*80:P1=O1/2:P2=O2/2

1160 S=TI:FAST

1170 FOR X=0 TO 38
1180  TV=O1+38-X:T2=P1+38-X

1190  VMC PS+TV,PD+TV,4+X+X,96,80,80
1200  VMC AS+T2,AD+T2,4+X+X,48,80,80

1210 NEXT:SLOW

1220 PRINT "BORDER DURATION:"(TI-S)


#1119 DISP24000:ATTR40000:END

###########################################
# CREATURES IN TOP LEFT AND RIGHT CORNERS #
###########################################

1230 PRINT "LOADING CREATURES.VDC...";
1240 BLOAD "CREATURES.VDC",B0,P(DB),U(DD)
1250 PRINT "DONE"

# TS:TARGET SCREEN-RAM
# TA:TARGET ATTRIBUTE-RAM
1260 TS=24000:TA=40000

1270 RTV DB,TS,13824
1280 RTV DB+13824,TA,6912

# A1:ANIMATION STEP ARRAY. CONTAINS INDICES OF IMAGES TO DISPLAY IN ORDER
1290 DIM A1(119),A3(119),B1(63),B3(63):X1=0:X2=0

1300 READ D
1310 DO WHILE D>-1
1320  A1(X1)=D*192+TA
1330  A3(X1)=D*384+TS
1340  X1=X1+1
1350  READ D
1360 LOOP

1370 READ D
1380 DO WHILE D>-1
1390  B1(X2)=D*192+TA+3456
1400  B3(X2)=D*384+TS+6912
1410  X2=X2+1
1420  READ D
1430 LOOP

1440 FS=5
1450 FR=INT(60/FS)

1460 DIM S(16),A(16):S0=32*12:A0=16*12
1470 FOR ZZ=1TO16
1480  S(ZZ)=S0-ZZ*24
1490  A(ZZ)=A0-ZZ*12
1500 NEXT

1510 PRINT "PRESS KEY TO START CREATURE ANIMATION"
1520 GETKEY I$

# SLIDE IN CREATURES
#   Z:LAST ANIMATION INDEX
1530 Z1=X1:Z2=X2:X1=0:X2=0
1540 TI$="000000"

1550 FOR ZZ=1 TO 16

#    LEFT CREATURE
1560  SL=A3(X1)
1570  AL=A1(X1)

#    RIGHT CREATURE
1580  SR=B3(X2)
1590  AR=B1(X2)

1600  SYN

#    LEFT CREATURE
1610  VMC SL+S(ZZ),    0,12,ZZ+ZZ,80
1620  VMC AL+A(ZZ),AD,12,ZZ,80

#    RIGHT CREATURE
1630  VMC SR+S(ZZ),   67,12,ZZ+ZZ,80
1640  VMC AR+A(ZZ),AD+67,12,ZZ,80

1650  DO WHILE TI<FR:K=K+1:LOOP

1660  K=0
1670  TI$="000000"

1680  X1=X1+1
1690  X2=X2+1

1700 NEXT


# ANIMATION LOOP
1710 FA=0

1720 DO

1730  SL=A3(X1)
1740  AL=A1(X1)

1750  SR=B3(X2)
1760  AR=B1(X2)

1770  SYN
1780  VMC SL, 0,12,32,80:VMC AL,AD,12,16,80
1790  VMC SR,67,12,32,80:VMC AR,AD+67,12,16,80

1800  DO WHILE TI<FR: K=K+1:LOOP
1810  K=0
1820  TI$="000000"
1830  X1=X1+1:IF X1=Z1 THEN X1=0
1840  X2=X2+1:IF X2=Z2 THEN X2=0

1850  GET I$:IF LEN(I$)=0 THEN 1970

#F MEANS FASTER
1860  IF I$<>"F" THEN 1900
1870  FS=FS+1:IF FS>10 THEN FS=10
1880  FR=INT(60/FS):PRINT "FRAMERATE "(60/FR)
1890  GOTO 1970

#S MEANS SLOWER
1900  IF I$<>"S" THEN 1940
1910  FS=FS-1:IF FS<1 THEN FS=1
1920  FR=INT(60/FS):PRINT "FRAMERATE "(60/FR)
1930  GOTO 1970

#SPACE TOGGLES SLOW/FAST
1940  IF I$<>"" THEN 1970
1950  IF FA THEN SLOW:ELSE FAST
1960  FA=NOT FA

1970 LOOP


1980 SLOW:END

#####

# LORD BRITISH WRITING
1990 DATA 84,189,85,188,87,188,89,188,91,188,92,189,92,190,91,191
2000 DATA 89,191,88,190,88,189,87,187,86,186,86,185,85,184,85,183
2010 DATA 84,182,84,181,83,180,83,179,82,178,82,177,81,176,79,176
2020 DATA 78,176,77,177,77,178,78,179,80,179,81,178,84,178,85,177
2030 DATA 86,177,87,176,89,176,91,176,93,176,95,176,97,176,99,176
2040 DATA 101,176,103,176,105,176,107,176,109,176,111,176,113,176,115,176
2050 DATA 117,176,119,176,121,176,123,176,125,176,127,176,129,176,131,176
2060 DATA 133,176,135,176,137,176,139,176,141,176,143,176,145,176,147,176
2070 DATA 149,176,151,176,153,176,155,176,157,176,159,176,161,176,163,176
2080 DATA 165,176,167,176,169,176,171,176,173,176,175,176,177,176,179,176
2090 DATA 181,176,183,176,185,176,187,176,189,176,191,176,193,176,195,176
2100 DATA 197,176,199,176,201,176,202,176,203,177,204,177,205,178,94,184
2110 DATA 94,183,93,182,93,181,92,180,92,179,93,178,95,178,96,178
2120 DATA 97,179,97,180,98,181,98,182,99,183,99,184,98,185,96,185
2130 DATA 95,185,105,185,106,184,106,183,105,182,105,181,104,180,104,179
2140 DATA 103,178,107,184,108,185,110,185,119,185,117,185,116,185,115,184
2150 DATA 115,183,114,182,114,181,113,180,113,179,114,178,116,178,117,179
2160 DATA 118,180,119,181,119,182,120,183,120,184,121,185,121,186,122,187
2170 DATA 122,188,123,189,123,190,118,179,119,178,139,190,139,189,138,188
2180 DATA 138,187,137,186,137,185,136,184,136,183,135,182,135,181,134,180
2190 DATA 134,179,133,178,140,191,142,191,143,191,144,190,144,189,143,188
2200 DATA 143,187,142,186,142,185,140,185,143,184,143,183,142,182,142,181
2210 DATA 141,180,141,179,140,178,138,178,136,178,135,179,150,185,151,184
2220 DATA 151,183,150,182,150,181,149,180,149,179,148,178,152,184,153,185
2230 DATA 155,185,161,185,160,184,160,183,159,182,159,181,158,180,158,179
2240 DATA 157,178,162,188,162,187,169,188,169,187,168,186,168,185,167,184
2250 DATA 167,183,166,182,166,181,165,180,165,179,166,178,168,178,169,178
2260 DATA 170,179,165,185,166,185,170,185,178,185,177,184,177,183,176,182
2270 DATA 176,181,175,180,175,179,174,178,179,188,179,187,187,184,186,185
2280 DATA 184,185,183,185,182,184,182,183,183,182,184,181,185,180,185,179
2290 DATA 184,178,182,178,181,178,180,179,197,190,197,189,196,188,196,187
2300 DATA 195,186,195,185,194,184,194,183,193,182,193,181,192,180,192,179
2310 DATA 191,178,197,185,198,185,199,184,199,183,198,182,198,181,197,180
2320 DATA 197,179,198,178,0

# MAP TILE INDICES
2330 DATA 6,6,6,4,4,4,1,1,0,0,0,0,1,4,4,13,14,15,4
2340 DATA 6,6,4,4,4,1,1,1,1,0,0,1,1,4,4,4,4,4,4
2350 DATA 6,4,4,1,1,1,2,2,1,1,1,1,1,1,10,4,4,4,6
2360 DATA 6,4,4,1,1,2,2,1,1,9,8,1,1,1,1,4,6,6,6
2370 DATA 4,4,4,4,1,1,1,1,4,4,8,8,1,1,1,1,1,6,6,-1

# ANIMATION FRAMES LEFT CREATURE
2380 DATA 1,1,1,0,0,1,1,1,0,0,1,1,2,2,3,3
2390 DATA 4,4,1,2,3,4,1,2,5,6,7,8,5,6,7,8
2400 DATA 5,6,7,8,5,6,7,8,5,6,7,8,5,6,7,8
2410 DATA 9,10,9,10,9,10,11,11,11,11,12,12,13,13,12,13
2420 DATA 12,13,12,11,11,11,0,0,1,2,3,4,1,2,5,6
2430 DATA 7,8,5,6,7,8,9,10,11,11,11,0,0,14,14,14
2440 DATA 15,16,16,16,17,17,17,16,16,16,17,17,17,16,16,16
2450 DATA 15,14,14,0,0,11,11,11,-1

# ANIMATION FRAMES RIGHT CREATURE
2460 DATA 1,0,1,2,3,4,3,2,1,0,1,2,3,4,5,6
2470 DATA 5,6,5,6,4,7,8,9,10,9,8,7,8,9,10,11
2480 DATA 12,11,12,13,11,12,13,1,13,1,14,1,15,1,14,1
2490 DATA 15,10,9,8,16,17,16,17,16,17,9,8,7,4,3,2,-1