L_50F3:	MVI  A, 027h
	CALL    L_0156
	LXI  H, D_559B
	CALL    L_0138
	CALL    L_3637
	CPI     00Dh
	JZ      L_5108
	XRA  A
	RET
;
L_5108:	LXI  B, 00000h	;+
	LXI  H, 0C400h	;+
	CALL    L_226E
	LXI  B, 00104h	;+
	LXI  H, 01101h	;+
	CALL    L_226E
	LXI  B, 03720h	;+
	CALL    L_2220
	MVI  A, 070h
	CALL    L_0156
L_5125:	LXI  H, D_553B
	CALL    L_0138
	CALL    L_RHEX	;>>
;	CPI     000h
	JNZ     L_5125
;	MOV  A, L
	ANI     001h
	STA     D_54EA
	CALL    L_0192
	LXI  H, D_525D
	CALL    L_22AE
	CALL    L_5216
	CALL    L_5225
	LXI  H, D_5260
	CALL    L_22AE
	CALL    L_5221
	LXI  B, L_0320
	CALL    L_5238
	CALL    L_5216
	CALL    L_5225
	LXI  H, D_5331
	CALL    L_22AE
	LXI  H, D_532A
	CALL    L_22AE
	CALL    L_5221
	LDA     D_54EA
	CPI     001h
	LXI  B, 003A0h	;+
	JZ      L_5180
	LXI  H, D_5234
	CALL    L_22AE
	LXI  B, 00240h	;+
L_5180:	CALL    L_5238
	CALL    L_5216
	CALL    L_5225
	LXI  H, D_535E
	CALL    L_22AE
	MVI  C, 01Ch
L_5191:	LXI  H, D_5479
	CALL    L_22AE
	CALL    L_012F
	DCR  C
	JNZ     L_5191
	CALL    L_5216
	CALL    L_5225
	MVI  C, 00Ch
	CALL    L_012F
	LXI  H, D_5499
	CALL    L_22AE
	MVI  B, 000h
L_51B1:	LXI  H, 02020h	; "  "
	SHLD    D_54C3
	MOV  L, B
	MVI  H, 000h
	LXI  D, D_54C3
	CALL    L_0183
	MOV  A, B
	STA     D_54CB
	CPI     040h
	JZ      L_51D3
	LXI  H, D_54C1
	CALL    L_22AE
	INR  B
	JMP     L_51B1
;
L_51D3:	MVI  C, 00Ch
	CALL    L_012F
	CALL    L_2041
	LXI  B, 00104h	;+
	LXI  H, 01101h	;+
	CALL    L_226E
L_51E4:	LXI  B, 03821h	;+
	CALL    L_2220
	MVI  A, 070h
	CALL    L_0156
	LXI  H, D_556D
	CALL    L_0138
	CALL    L_RHEX	;>>
;	CPI     000h
	JNZ     L_51E4
;	MOV  A, L
	ANI     007h
	CALL    L_0195
	CALL    L_5225
	LXI  H, D_54EB
	CALL    L_22AE
	CALL    L_ENTS	;L_362B
	CPI     00Dh
	JZ      L_5108
	XRA  A
	RET
;
L_5216:	LDA     D_54EA
	CPI     001h
	JNZ     L_5221
	JMP     L_0192
;
L_5221:	XRA  A
	JMP     L_0192
;
L_5225:	LDA     D_54EA
	CPI     000h
	RNZ
	LXI  H, D_5232
	CALL    L_22AE
	RET
;
D_5232:	.db 00Ah, 00Dh
D_5234:	.db 01Bh	; "_" - |   ■■ ■■| (offset 5234h)
	.db 052h	; "R" - | ■ ■  ■ | (offset 5235h)
	.db 001h	; "_" - |       ■| (offset 5236h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 5237h)
L_5238:	MVI  D, 020h
L_523A:	MOV  A, C
	CPI     07Fh
	JZ      L_5243
	CALL    L_012F
L_5243:	INR  C
	DCR  D
	JNZ     L_523A
	LXI  H, D_532A
	CALL    L_22AE
	DCR  B
	JNZ     L_5238
	MVI  C, 00Ah
	CALL    L_012F
	MVI  C, 00Dh
	CALL    L_012F
	RET
;
D_525D:	.db 01Bh	; "_" - |   ■■ ■■| (offset 525Dh)
	.db 040h	; "@" - | ■      | (offset 525Eh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 525Fh)
D_5260:	.db 00Ah, 00Dh
	.db "*************************"
	.db "*************************"
	.db 00Ah, 00Dh
	.db "*** prowerka matri~nogo p"
	.db "e~ata`}ego ustrojstwa ***"
	.db 00Ah, 00Dh
	.db "*************************"
	.db "*************************"
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db "*** osnownoj nabor pe"
	.db "~ataemyh liter ***"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 5327h)
	.db 052h	; "R" - | ■ ■  ■ | (offset 5328h)
	.db 000h
D_532A:	.db 00Ah, 00Dh
	.db "    "
	.db 0FFh	; " " - |■■■■■■■■| (offset 5330h)
D_5331:	.db 00Ah, 00Dh
	.db "****** dopolnitelxnyj"
	.db " nabor liter *****"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 535Ah)
	.db 052h	; "R" - | ■ ■  ■ | (offset 535Bh)
	.db 000h
	.db 0FFh	; " " - |■■■■■■■■| (offset 535Dh)
D_535E:	.db 01Bh	; "_" - |   ■■ ■■| (offset 535Eh)
	.db 00Fh	; "_" - |    ■■■■| (offset 535Fh)
	.db "*** uplotnennyj revim ***"
	.db 012h	; "_" - |   ■  ■ | (offset 5379h)
	.db 00Ah, 00Dh
	.db 00Eh	; "_" - |    ■■■ | (offset 537Ch)
	.db "*** ras{irennyj revim ***"
	.db 00Ah, 00Dh
	.db 01Bh	; "_" - |   ■■ ■■| (offset 5398h)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 5399h)
	.db "*** wybor {aga "
	.db 022h	; "
	.db "|lit"
	.db 022h	; "
	.db " ***"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 53B3h)
	.db 050h	; "P" - | ■ ■    | (offset 53B4h)
	.db 00Ah, 00Dh
	.db 01Bh	; "_" - |   ■■ ■■| (offset 53B7h)
	.db 045h	; "E" - | ■   ■ ■| (offset 53B8h)
	.db "*** pod~erknutyj revim ***"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 53D3h)
	.db 046h	; "F" - | ■   ■■ | (offset 53D4h)
	.db 00Ah, 00Dh
	.db 01Bh	; "_" - |   ■■ ■■| (offset 53D7h)
	.db 047h	; "G" - | ■   ■■■| (offset 53D8h)
	.db "*** revim dwojnogo udara ***"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 53F5h)
	.db 048h	; "H" - | ■  ■   | (offset 53F6h)
	.db 00Ah, 00Dh
	.db "***"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 53FCh)
	.db 053h	; "S" - | ■ ■  ■■| (offset 53FDh)
	.db 000h	; "_" - |        | (offset 53FEh)
	.db "wybor werhnego indeksa"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 5415h)
	.db 054h	; "T" - | ■ ■ ■  | (offset 5416h)
	.db "***"
	.db 00Ah, 00Dh
	.db "***"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 541Fh)
	.db 053h, 001h
	.db "wybor subskripta"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 5432h)
	.db 054h	; "T" - | ■ ■ ■  | (offset 5433h)
	.db "***"
	.db 00Ah, 00Dh
	.db "*** "
	.db 01Bh	; "_" - |   ■■ ■■| (offset 543Dh)
	.db 02Dh	; "-" - |  ■ ■■ ■| (offset 543Eh)
	.db 001h	; "_" - |       ■| (offset 543Fh)
	.db "wybor"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 5445h)
	.db 02Dh	; "-" - |  ■ ■■ ■| (offset 5446h)
	.db 000h
	.db "/anulirowanie "
	.db 01Bh	; "_" - |   ■■ ■■| (offset 5456h)
	.db 02Dh	; "-" - |  ■ ■■ ■| (offset 5457h)
	.db 001h	; "_" - |       ■| (offset 5458h)
	.db "pod~erkiwa`}ej linii"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 546Dh)
	.db 02Dh	; "-" - |  ■ ■■ ■| (offset 546Eh)
	.db 000h
	.db " ***"
	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 0FFh	; " " - |■■■■■■■■| (offset 5478h)
D_5479:	.db "--- ustanowka interwala ---"
	.db 00Ah, 00Dh
	.db 01Bh	; "_" - |   ■■ ■■| (offset 5496h)
	.db 041h	; "A" - | ■     ■| (offset 5497h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 5498h)
D_5499:	.db 00Ah, 00Dh
	.db 01Bh	; "_" - |   ■■ ■■| (offset 549Bh)
	.db 021h	; "!" - |  ■    ■| (offset 549Ch)
	.db 000h	; "_" - |        | (offset 549Dh)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 549Eh)
	.db 030h	; "0" - |  ■■    | (offset 549Fh)
	.db "**** wybor wida {rifta ****"
	.db 00Ah, 00Dh
	.db 01Bh	; "_" - |   ■■ ■■| (offset 54BDh)
	.db 052h	; "R" - | ■ ■  ■ | (offset 54BEh)
	.db 000h	; "_" - |        | (offset 54BFh)
	.db 0FFh	; " " - |■■■■■■■■| (offset 54C0h)
D_54C1:	.db 04Eh	; "N" - | ■  ■■■ | (offset 54C1h)
	.db 03Dh	; "=" - |  ■■■■ ■| (offset 54C2h)
D_54C3:	.db "      "
	.db 01Bh	; "_" - |   ■■ ■■| (offset 54C9h)
	.db 021h	; "!" - |  ■    ■| (offset 54CAh)
D_54CB:	.db 000h	; "_" - |        | (offset 54CBh)
	.db "0123456789 ABCDEF absdef"
	.db 01Bh	; "_" - |   ■■ ■■| (offset 54E4h)
	.db 021h	; "!" - |  ■    ■| (offset 54E5h)
	.db 000h
	.db 00Ah, 00Dh
	.db 0FFh	; " " - |■■■■■■■■| (offset 54E9h)
D_54EA:	.db 000h	; "_" - |        | (offset 54EAh)
D_54EB:	.db 00Ah, 00Dh
	.db 00Ah, 00Dh
	.db 01Bh	; "_" - |   ■■ ■■| (offset 54EFh)
	.db 04Dh	; "M" - | ■  ■■ ■| (offset 54F0h)
	.db 00Fh	; "_" - |    ■■■■| (offset 54F1h)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 54F2h)
	.db 053h	; "S" - | ■ ■  ■■| (offset 54F3h)
	.db 000h	; "_" - |        | (offset 54F4h)
	.db 01Bh	; "_" - |   ■■ ■■| (offset 54F5h)
	.db 033h	; "3" - |  ■■  ■■| (offset 54F6h)
	.db 012h	; "_" - |   ■  ■ | (offset 54F7h)
	.db "*******************"
	.db 00Ah, 00Dh
	.db 007h	; "_" - |     ■■■| (offset 550Dh)
	.db "*** konec testa ***"
	.db 00Ah, 00Dh
	.db 007h	; "_" - |     ■■■| (offset 5523h)
	.db "*******************"
	.db 00Ah, 00Dh
	.db 007h	; "_" - |     ■■■| (offset 5539h)
	.db 0FFh	; " " - |■■■■■■■■| (offset 553Ah)
D_553B:	.db 01Bh, 059h
	.db 038h	; "8" - |  ■■■   | (offset 553Dh)
	.db 021h	; "!" - |  ■    ■| (offset 553Eh)
	.db " tip printera (0-ROBOTRON"
	.db ",1-EPSON)?     "
	.db 008h	; "_" - |    ■   | (offset 5567h)
	.db 008h	; "_" - |    ■   | (offset 5568h)
	.db 008h	; "_" - |    ■   | (offset 5569h)
	.db 008h	; "_" - |    ■   | (offset 556Ah)
	.db 008h	; "_" - |    ■   | (offset 556Bh)
	.db 000h
D_556D:	.db " nomer grafi~eskogo"
	.db " revima (0-7) ?      "
	.db 008h	; "_" - |    ■   | (offset 5595h)
	.db 008h	; "_" - |    ■   | (offset 5596h)
	.db 008h	; "_" - |    ■   | (offset 5597h)
	.db 008h	; "_" - |    ■   | (offset 5598h)
	.db 008h	; "_" - |    ■   | (offset 5599h)
	.db 000h
D_559B:	.db 018h
	.db "    MAtri~noe   pe~ata`}ee"
	.db "   ustrojstro "
	.db 00Ah, 00Dh
	.db 018h
	.db " dolvno  obespe~iwatx"
	.db " priem  informacii "
	.db 00Ah, 00Dh
	.db 018h
	.db " po interfejsu tipa - "
	.db 022h	; "
	.db "CENTRONICS-8"
	.db 022h	; "
	.db ".   "
	.db 00Ah, 00Dh
	.db 018h
	.db "  kabelx interfejsa"
	.db " dolven obespe~iwatx "
	.db 00Ah, 00Dh
	.db 018h
	.db "      pereda~u sledu`}ih"
	.db " signalow :     "
	.db 00Ah, 00Dh
	.db 018h
	.db "  XS5                    "
	.db "       printer "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A02 --------> dannye[8]"
	.db " >-------- 09  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A03 --------> dannye[7]"
	.db " >-------- 08  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A04 --------> dannye[6]"
	.db " >-------- 07  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A05 --------> dannye[5]"
	.db " >-------- 06  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A06 --------> dannye[4]"
	.db " >-------- 05  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A07 --------> dannye[3]"
	.db " >-------- 04  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A08 --------> dannye[2]"
	.db " >-------- 03  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  A09 --------> dannye[1]"
	.db " >-------- 02  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  s05 ---------> - strob"
	.db " >--------- 01  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  s09 --------< gotownostx"
	.db "<-------- 11  "
	.db 00Ah, 00Dh
	.db 018h
	.db "  s01,a10 -----<> zemlq"
	.db " <>------ 19-30  "
	.db 00Ah, 00Dh
	.db 000h
